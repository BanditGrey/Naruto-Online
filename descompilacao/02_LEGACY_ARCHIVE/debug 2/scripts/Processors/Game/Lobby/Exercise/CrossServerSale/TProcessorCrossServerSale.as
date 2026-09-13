package Processors.Game.Lobby.Exercise.CrossServerSale
{
   import Foundation.Network.TPacket;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.CrossServerSale.TCrossServerSale;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerBaseInventories;
   import Logics.Streamization.Exercise.TUnstreamizerCrossServerSale;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorCrossServerSale extends TProcessorBaseActivity
   {
      
      public static const BOX_COUNT:uint = 3;
      
      public static const REQ_TYPE_BUY:int = 1;
      
      protected var FCrossServerSale:TCrossServerSale;
      
      protected var FBeClicked:Boolean;
      
      protected var FUnstreamizerBaseInventories:TUnstreamizerBaseInventories;
      
      protected var FUnstreamizerCrossServerSale:TUnstreamizerCrossServerSale;
      
      protected var FUIBoxVect:Vector.<TUIBaseBox>;
      
      protected var FTurnTimeID:int;
      
      public function TProcessorCrossServerSale(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FCrossServerSale = SLogicsCore.CrossServerSale;
         this.FUnstreamizerBaseInventories = new TUnstreamizerBaseInventories();
         this.FUnstreamizerCrossServerSale = new TUnstreamizerCrossServerSale();
         this.FUIBoxVect = new Vector.<TUIBaseBox>(BOX_COUNT);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIBaseBox = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc5_ = new TUIBaseBox(this,1);
            _loc5_.Perform_UIDispatch(FMC_Scene["MC_Item" + _loc1_]);
            _loc5_.OnOverlay = this.SlotsOnOver;
            _loc5_.OnOut = this.SlotsOnOut;
            _loc5_.OnGetBox = this.ProcessorOnBuyUp;
            _loc5_.OnBtnOver = this.ProcessorOnBtnOver;
            _loc5_.OnBtnOut = this.ProcessorOnBtnOut;
            this.FUIBoxVect[_loc1_] = _loc5_;
            _loc1_++;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         super.LogicsPerform();
         if(FInitialized)
         {
            if(this.visible)
            {
               if(Boolean(this.FCrossServerSale) && Boolean(FTF_Time))
               {
                  FTF_Time.text = TGameUtil.fomatTime(this.FCrossServerSale.EndTime - STimingCore.GetServerTick());
               }
               _loc1_ = 0;
               while(_loc1_ < BOX_COUNT)
               {
                  if(this.FUIBoxVect[_loc1_])
                  {
                     this.FUIBoxVect[_loc1_].LogicsPerform();
                  }
                  _loc1_++;
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         super.UpdateUI();
         this.UpdateText();
         this.UpdateBox();
      }
      
      protected function UpdateText() : void
      {
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FCrossServerSale.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FCrossServerSale.EndTime) - 1) * 1000)));
         FTF_Desc.text = this.FCrossServerSale.ActivityDesc;
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:TInventories = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:TBaseBox = null;
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            _loc6_ = this.FCrossServerSale.BoxVect[_loc2_];
            _loc1_ = _loc6_.Inventories;
            this.FUIBoxVect[_loc2_].UpdateUI(_loc1_);
            _loc5_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_MAX_LIMIT,_loc6_.LimitCount.toString());
            this.FUIBoxVect[_loc2_].SetLimitText(_loc5_);
            _loc5_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BUY_COUNT,_loc6_.Count - _loc6_.BuyCount,_loc6_.Count);
            this.FUIBoxVect[_loc2_].SetCountText(_loc5_);
            _loc5_ = _loc6_.Price.toString();
            this.FUIBoxVect[_loc2_].SetPriceText(_loc5_);
            _loc5_ = _loc6_.CurPrice.toString();
            this.FUIBoxVect[_loc2_].SetCurPriceText(_loc5_);
            _loc5_ = _loc6_.Discount + STRING_COMMON.GetItemNameByType(0,2);
            this.FUIBoxVect[_loc2_].SetBuff(true,_loc5_);
            _loc5_ = _loc6_.Inventory.Name;
            this.FUIBoxVect[_loc2_].SetNameText(_loc5_);
            if(_loc6_.BuyCount >= _loc6_.Count || _loc6_.LimitCount <= 0)
            {
               this.FUIBoxVect[_loc2_].SetBtnMode(false);
            }
            else
            {
               this.FUIBoxVect[_loc2_].SetBtnMode(true);
            }
            if(_loc6_.LimitCount <= 0)
            {
               this.FUIBoxVect[_loc2_].IsBoxGot(true);
            }
            else
            {
               this.FUIBoxVect[_loc2_].IsBoxGot(false);
            }
            _loc2_++;
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         if(this.FCrossServerSale)
         {
            FNeedConfig = this.FCrossServerSale.NeedConfig;
         }
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnBuyUp(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBeClicked)
         {
            return;
         }
         FIndex = int(param1.currentTarget.parent.name.slice(7));
         if(!this.FCrossServerSale.BoxVect[FIndex])
         {
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCrossServerSale.BoxVect[FIndex].CurPrice);
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         if(this.FCrossServerSale.IsCreditGoldEnough(this.FCrossServerSale.BoxVect[FIndex].CurPrice))
         {
            this.FBeClicked = true;
            this.PerformPacket_CS_BuyBoxReq();
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      override protected function PerformPacket_CS_BuyBoxReq(param1:MouseEvent = null) : void
      {
         var _loc2_:Vector.<int> = new Vector.<int>();
         _loc2_.push(FIndex + 1);
         PerformPacket_CS_AllReq(REQ_TYPE_BUY,_loc2_);
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         UIComponentsHintOnOver(this,param2);
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         UIComponentsHintOnOut(this,param2);
      }
      
      protected function ProcessorOnBtnOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:TBaseBox = null;
         if(param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc3_ = int(param1.currentTarget.parent.name.slice(7));
         if(!this.FCrossServerSale.BoxVect[_loc3_])
         {
            return;
         }
         _loc4_ = this.FCrossServerSale.BoxVect[_loc3_];
         if(_loc4_.BuyCount >= _loc4_.Count)
         {
            _loc2_ = STRING_BASEACTIVITY.FORMAT_NO_BUY_COUNT;
         }
         else if(_loc4_.LimitCount <= 0)
         {
            _loc2_ = STRING_BASEACTIVITY.FORMAT_SALE_END;
         }
         ProcessorOnShowTip(_loc2_);
      }
      
      protected function ProcessorOnBtnOut(param1:MouseEvent) : void
      {
         if(param1.currentTarget.buttonMode)
         {
            return;
         }
         ProcessorOnHideTip();
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
         this.FUnstreamizerCrossServerSale.Unstreamize(_loc2_,this.FCrossServerSale,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:TInventories = null;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc12_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc12_)
         {
            case REQ_TYPE_BUY:
               _loc10_ = this.FCrossServerSale.BoxVect[FIndex].Inventories;
               ++this.FCrossServerSale.BoxVect[FIndex].BuyCount;
               _loc7_ = 0;
               while(_loc7_ < BOX_COUNT)
               {
                  this.FCrossServerSale.BoxVect[_loc7_].LimitCount = _loc2_.readUnsignedInt();
                  _loc7_++;
               }
               _loc11_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc7_ = 0;
               while(_loc7_ < _loc10_.Count)
               {
                  _loc11_ += _loc10_.GetInventoryByIndex(_loc7_).Name + "*" + _loc10_.GetInventoryByIndex(_loc7_).Quantity + "\n";
                  _loc7_++;
               }
               ProcessorEffectText(_loc11_);
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
         if(this.FCrossServerSale.BoxVect[0] != null)
         {
            _loc3_ = int(_loc2_.readUnsignedShort());
            _loc4_ = 0;
            while(_loc4_ < _loc3_ / 2)
            {
               _loc7_ = int(_loc2_.readUnsignedInt());
               this.FCrossServerSale.BoxVect[_loc7_ - 1].LimitCount = _loc2_.readUnsignedInt();
               _loc4_++;
            }
            this.UpdateUI();
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([50,60,70]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"活动时间");
         TUtilityString.FlushUTF(_loc3_,"打折促销");
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(_loc4_[_loc1_]);
            _loc3_.writeUnsignedInt(5);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(100);
            _loc3_.writeUnsignedInt(50);
            _loc3_.writeUnsignedInt(5);
            _loc3_.writeShort(1);
            _loc2_ = 0;
            while(_loc2_ < 1)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(_loc1_ + 1);
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
         _loc3_.writeShort(6);
         _loc1_ = 0;
         while(_loc1_ < 6 / 3)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

