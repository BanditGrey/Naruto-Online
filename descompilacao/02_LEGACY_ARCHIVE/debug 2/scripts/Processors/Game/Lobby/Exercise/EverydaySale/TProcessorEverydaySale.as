package Processors.Game.Lobby.Exercise.EverydaySale
{
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.EverydaySale.TEverydaySale;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerEverydaySale;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Rendering.Overlayers.Box.TOverlayerBox;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TProcessorEverydaySale extends TProcessorBaseActivity
   {
      
      protected static const BOX_COUNT:int = 6;
      
      protected static const ITEM_COUNT:int = 1;
      
      protected static const REQ_TYPE_GET_SALE_ITEM:int = 1;
      
      protected static const REQ_TYPE_GET_REWARD:int = 2;
      
      protected var FEverydaySale:TEverydaySale;
      
      protected var FBeClicked:Boolean;
      
      protected var FUnstreamizerEverydaySale:TUnstreamizerEverydaySale;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FCost:int;
      
      protected var FArticleBins:TBins;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FUIBaseBox:TUIBaseBox;
      
      protected var FMC_BoxPic:MovieClip;
      
      protected var FMC_AccumBar:MovieClip;
      
      protected var FMC_Bar:MovieClip;
      
      protected var FMC_Mask:Sprite;
      
      protected var FBarMaxHeight:int;
      
      protected var FNextTimeID:int;
      
      public function TProcessorEverydaySale(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FEverydaySale = SLogicsCore.EverydaySale;
         this.FUnstreamizerEverydaySale = new TUnstreamizerEverydaySale();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FOverlayerBox = new TOverlayerBox(this.Parent);
         this.FOverlayerBox.Visible = false;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.FUIBaseBox = new TUIBaseBox(this,ITEM_COUNT);
         this.FUIBaseBox.Perform_UIDispatch(FMC_Scene["MC_Item"]);
         this.FUIBaseBox.OnOverlay = UIComponentsHintOnOver;
         this.FUIBaseBox.OnOut = UIComponentsHintOnOut;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Box" + _loc1_];
            this.FBoxList[_loc1_] = _loc4_;
            _loc4_.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            _loc1_++;
         }
         this.FMC_BoxPic = FMC_Scene.MC_BoxPic;
         this.FMC_AccumBar = FMC_Scene["MC_AccumBar"];
         this.FMC_Bar = this.FMC_AccumBar["MC_Bar"];
         this.FMC_Mask = this.FMC_AccumBar["MC_Mask"];
         this.FBarMaxHeight = this.FMC_Mask.height;
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBox);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.ResourcesPerform_UILocations();
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Recharge,true);
         FMC_Scene.BTN_Recharge.addEventListener(MouseEvent.CLICK,ProcessorOnRechargeUp);
         FMC_Scene.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSaleBoxOver);
         FMC_Scene.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnSaleBoxOut);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         super.LogicsPerform();
         if(FInitialized)
         {
            if(this.FUIBaseBox)
            {
               this.FUIBaseBox.LogicsPerform();
            }
            if(Boolean(this.FEverydaySale) && Boolean(FTF_Time))
            {
               FTF_Time.text = TGameUtil.fomatTime(this.FEverydaySale.NextTime - STimingCore.GetServerTick());
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateBox();
         this.UpdateBar();
      }
      
      protected function UpdateText() : void
      {
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FEverydaySale.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FEverydaySale.EndTime) - 1) * 1000)));
         FTF_Desc.text = this.FEverydaySale.ActivityDesc;
         FMC_Scene.TF_Gold.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_CUR_AND_TOTAL_RECHARGE_GOLD,this.FEverydaySale.RechargeGold,this.FEverydaySale.BaseBox.Price);
         FMC_Scene.TF_Count.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_REMAIN_COUNT,this.FEverydaySale.BaseBox.BuyCount,this.FEverydaySale.BaseBox.Count);
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         if(this.FEverydaySale.SaleType == TEverydaySale.SALE_TYPE_ITEM)
         {
            this.FMC_BoxPic.visible = false;
            _loc3_ = this.FEverydaySale.BaseBox.Inventories;
            this.FUIBaseBox.UpdateUI(_loc3_);
            this.FUIBaseBox.SetVisible(true);
         }
         else
         {
            this.FMC_BoxPic.visible = true;
            this.FUIBaseBox.SetVisible(false);
         }
         if(this.FEverydaySale.BaseBox.Status == TBaseActivity.STATUS_CANGET)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
            FMC_Scene.BTN_Buy.visible = true;
            FMC_Scene.MC_Got.visible = false;
         }
         else if(this.FEverydaySale.BaseBox.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,false);
            FMC_Scene.BTN_Buy.visible = true;
            FMC_Scene.MC_Got.visible = false;
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,false);
            FMC_Scene.BTN_Buy.visible = false;
            FMC_Scene.MC_Got.visible = true;
         }
      }
      
      protected function UpdateBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBaseBox = null;
         _loc4_ = this.FEverydaySale.Rewards[this.FEverydaySale.Rewards.length - 1].Price;
         _loc3_ = Number(this.FEverydaySale.Count / _loc4_) * this.FBarMaxHeight;
         this.FMC_Mask.height = Math.min(_loc3_,this.FBarMaxHeight);
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc2_ = this.FBoxList[_loc1_];
            if(_loc1_ < this.FEverydaySale.Rewards.length)
            {
               _loc2_.visible = true;
               _loc5_ = this.FEverydaySale.Rewards[_loc1_];
               if(_loc1_ < BOX_COUNT - 1)
               {
                  this.FMC_AccumBar["TF_Count" + _loc1_].text = _loc5_.Price.toString();
               }
               switch(_loc5_.Status)
               {
                  case TBaseActivity.STATUS_CANNOTGET:
                     _loc2_.gotoAndStop(1);
                     _loc2_.notOpen.gotoAndStop(_loc1_ + 1);
                     _loc2_.notOpen.filters = [TGameUtil.GaryColorFilters];
                     break;
                  case TBaseActivity.STATUS_CANGET:
                     _loc2_.gotoAndStop(2);
                     _loc2_.canGet.MC_OpenBox.gotoAndStop(_loc1_ + 1);
                     break;
                  case TBaseActivity.STATUS_GETED:
                     _loc2_.gotoAndStop(3);
                     _loc2_.Got.gotoAndStop(_loc1_ + 1);
               }
            }
            else
            {
               _loc2_.visible = false;
            }
            _loc1_++;
         }
         this.FMC_AccumBar.TF_CurCount.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_AMOUNT,this.FEverydaySale.Count);
         if(this.FEverydaySale.GetLimitCount() == -1)
         {
            FMC_Scene.TF_NextCount.text = STRING_BASEACTIVITY.FORMAT_ALL_BOX_OPEN;
         }
         else
         {
            FMC_Scene.TF_NextCount.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_REMAIN_BOX_COUNT,this.FEverydaySale.GetLimitCount());
         }
      }
      
      protected function SetEndTime() : void
      {
         var _loc1_:Number = NaN;
         if(this.FNextTimeID != 0)
         {
            clearTimeout(this.FNextTimeID);
            this.FNextTimeID = 0;
         }
         _loc1_ = (this.FEverydaySale.NextTime - STimingCore.GetServerTick()) * 1000;
         if(_loc1_ < 0)
         {
            return;
         }
         if(_loc1_ > int.MAX_VALUE)
         {
            _loc1_ = int.MAX_VALUE;
         }
         this.FNextTimeID = setTimeout(this.PerformPacket_CS_LoadInfoReq,_loc1_);
      }
      
      protected function ProcessorOnBuyUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode || this.FBeClicked)
         {
            return;
         }
         PerformPacket_CS_AllReq(REQ_TYPE_GET_SALE_ITEM);
      }
      
      protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<int> = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(this.FEverydaySale.Rewards[_loc2_].Status != TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         FIndex = _loc2_;
         _loc3_ = new Vector.<int>();
         _loc3_.push(FIndex + 1);
         PerformPacket_CS_AllReq(REQ_TYPE_GET_REWARD,_loc3_);
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(this.FEverydaySale) && _loc2_ < this.FEverydaySale.Rewards.length)
         {
            _loc3_ = this.FEverydaySale.Rewards[_loc2_].Inventories;
            ProcessorOnNewBoxOver(_loc3_);
         }
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         ProcessorOnNewBoxOut();
      }
      
      protected function ProcessorOnSaleBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventories = null;
         if(Boolean(this.FEverydaySale) && Boolean(this.FEverydaySale.BaseBox))
         {
            _loc2_ = this.FEverydaySale.BaseBox.Inventories;
            ProcessorOnNewBoxOver(_loc2_);
         }
      }
      
      protected function ProcessorOnSaleBoxOut(param1:MouseEvent) : void
      {
         ProcessorOnNewBoxOut();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.visible = true;
         this.alpha = 1;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         if(this.FNextTimeID != 0)
         {
            clearTimeout(this.FNextTimeID);
            this.FNextTimeID = 0;
         }
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         super.ProcessorOnLoadInfoRet();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerEverydaySale.Unstreamize(_loc2_,this.FEverydaySale,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.SetEndTime();
            ProcessorCheckEffect(FActivityID,this.FEverydaySale.CheckStatus());
            this.UpdateUI();
         }
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc2_ = param1.Data;
         if(Boolean(this.FEverydaySale.Rewards) && this.FEverydaySale.Rewards.length > 0)
         {
            _loc2_.readUnsignedShort();
            this.FEverydaySale.RechargeGold = _loc2_.readUnsignedInt();
            ProcessorCheckEffect(FActivityID,this.FEverydaySale.CheckStatus());
            if(this.visible == true)
            {
               this.UpdateUI();
            }
         }
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventories = null;
         var _loc9_:TInventory = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:uint = 0;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            if(_loc3_ == 358)
            {
               this.FEverydaySale.BaseBox.BuyCount = 0;
               this.FEverydaySale.BaseBox.Status = TBaseActivity.STATUS_CANNOTGET;
               ProcessorCheckEffect(FActivityID,this.FEverydaySale.CheckStatus());
               this.UpdateUI();
            }
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc7_)
         {
            case REQ_TYPE_GET_SALE_ITEM:
               if(this.FEverydaySale.BaseBox.BuyCount > 0)
               {
                  --this.FEverydaySale.BaseBox.BuyCount;
               }
               this.FEverydaySale.BaseBox.Status = TBaseActivity.STATUS_GETED;
               ++this.FEverydaySale.Count;
               _loc8_ = this.FEverydaySale.BaseBox.Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc4_ += _loc8_.GetInventoryByIndex(_loc5_).Name + "*" + _loc8_.GetInventoryByIndex(_loc5_).Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FEverydaySale.CheckStatus());
               this.UpdateUI();
               break;
            case REQ_TYPE_GET_REWARD:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FEverydaySale.Rewards[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc8_ = this.FEverydaySale.Rewards[_loc5_].Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc4_ += _loc8_.GetInventoryByIndex(_loc5_).Name + "*" + _loc8_.GetInventoryByIndex(_loc5_).Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FEverydaySale.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([1,0,0,0,0]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1421571200);
         TUtilityString.FlushUTF(_loc3_,"天天特价");
         _loc3_.writeUnsignedInt(STimingCore.GetServerTime() + 100);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(1001);
         _loc3_.writeUnsignedInt(1000);
         _loc3_.writeUnsignedInt(1000);
         _loc3_.writeUnsignedInt(50);
         _loc3_.writeInt(1);
         _loc3_.writeShort(1);
         _loc1_ = 0;
         while(_loc1_ < 1)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(1 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc3_.writeUnsignedInt((_loc1_ + 1) * 5);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeShort(3);
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc2_ + _loc1_);
               _loc3_.writeUnsignedInt(1 + _loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit1() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeUnsignedInt(20);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

