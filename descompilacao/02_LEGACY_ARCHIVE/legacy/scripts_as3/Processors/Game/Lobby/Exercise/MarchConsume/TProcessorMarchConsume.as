package Processors.Game.Lobby.Exercise.MarchConsume
{
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.MarchConsume.TMarchConsume;
   import Logics.Exercise.MarchConsume.TMarchConsumeBox;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerMarchConsume;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorMarchConsume extends TProcessorBaseActivity
   {
      
      protected static const SHOW_ITEM_COUNT:int = 5;
      
      protected static const LEVEL_COUNT:int = 3;
      
      protected static const DAILY_BOX_COUNT:int = 3;
      
      protected static const BUFF_COUNT:int = 4;
      
      protected static const REQ_GET_DAILY_ITEMS:int = 1;
      
      protected static const REQ_GET_TOTAL_BOXES:int = 2;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FMarchConsume:TMarchConsume;
      
      protected var FUnstreamizerMarchConsume:TUnstreamizerMarchConsume;
      
      protected var FProcessorMarchConsumeLog:TProcessorMarchConsumeLog;
      
      protected var FBuyBoxDate:Object;
      
      protected var FDailyItems:Vector.<TUIBaseBox>;
      
      public function TProcessorMarchConsume(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FMarchConsume = SLogicsCore.MarchConsume;
         this.FUnstreamizerMarchConsume = new TUnstreamizerMarchConsume();
         this.FBuyBoxDate = new Object();
         this.FProcessorMarchConsumeLog = new TProcessorMarchConsumeLog(this.Parent);
         this.FDailyItems = new Vector.<TUIBaseBox>(LEVEL_COUNT);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIBaseBox = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < LEVEL_COUNT)
         {
            _loc5_ = new TUIBaseBox(this,DAILY_BOX_COUNT);
            _loc5_.Perform_UIDispatch(FMC_Scene["MC_Items" + _loc1_]);
            _loc5_.OnOverlay = UIComponentsHintOnOver;
            _loc5_.OnOut = UIComponentsHintOnOut;
            _loc5_.OnGetBox = this.ProcessorOnGetDailyBoxUp;
            this.FDailyItems[_loc1_] = _loc5_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < LEVEL_COUNT)
         {
            _loc2_ = 0;
            while(_loc2_ < LEVEL_COUNT)
            {
               _loc4_ = FMC_Scene["MC_Box" + _loc1_]["MC_Box" + _loc2_].MC_BoxPic;
               _loc4_.buttonMode = true;
               _loc4_.gotoAndStop(_loc2_ + _loc1_ * LEVEL_COUNT + 1);
               _loc4_.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetTotalBoxUp);
               _loc4_.addEventListener(MouseEvent.ROLL_OVER,this.ProcessorOnTotalBoxOver);
               _loc4_.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
               _loc2_++;
            }
            _loc1_++;
         }
         this.FProcessorMarchConsumeLog.OnCloseUp = this.ProcessorOnCloseLogUp;
         this.FProcessorMarchConsumeLog.Visible = false;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLogUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < LEVEL_COUNT)
            {
               if(this.FDailyItems[_loc1_])
               {
                  this.FDailyItems[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateDailyItems();
         this.UpdateTotalBoxes();
         this.UpdateGold();
         this.UpdateText();
      }
      
      protected function UpdateDailyItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < LEVEL_COUNT)
         {
            if(_loc1_ < this.FMarchConsume.DailyItems.length)
            {
               _loc3_ = this.FMarchConsume.DailyItems[_loc1_];
               this.FDailyItems[_loc1_].UpdateUI(_loc3_.Inventories);
               this.FDailyItems[_loc1_].SetDescText(0,_loc3_.Price.toString());
               if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  this.FDailyItems[_loc1_].SetBtnMode(false);
                  this.FDailyItems[_loc1_].IsBoxGot(false);
               }
               else if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
               {
                  this.FDailyItems[_loc1_].SetBtnMode(true);
                  this.FDailyItems[_loc1_].IsBoxGot(false);
               }
               else
               {
                  this.FDailyItems[_loc1_].IsBoxGot(true);
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateTotalBoxes() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBaseBox = null;
         var _loc6_:TMarchConsumeBox = null;
         var _loc7_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < LEVEL_COUNT)
         {
            _loc6_ = this.FMarchConsume.TotalBox[_loc1_];
            FMC_Scene["MC_Box" + _loc1_].TF_Gold.text = _loc6_.Gold.toString();
            FMC_Scene["MC_Box" + _loc1_].TF_Desc.text = TUtilityString.Format(this.FMarchConsume.DescListNew[2],_loc6_.Days);
            _loc2_ = 0;
            while(_loc2_ < _loc6_.Boxes.length)
            {
               _loc5_ = _loc6_.Boxes[_loc2_];
               _loc7_ = FMC_Scene["MC_Box" + _loc1_]["MC_Box" + _loc2_];
               _loc7_.TF_Price.text = TUtilityString.Format(this.FMarchConsume.DescListNew[3],_loc6_.Days,_loc5_.Price);
               if(_loc5_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc7_.MC_Click.visible = false;
                  _loc7_.MC_Got.visible = false;
               }
               else if(_loc5_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc7_.MC_Click.visible = true;
                  _loc7_.MC_Got.visible = false;
               }
               else
               {
                  _loc7_.MC_Click.visible = false;
                  _loc7_.MC_Got.visible = true;
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateGold() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < LEVEL_COUNT)
         {
            if(this.FMarchConsume.ConsumeGold >= this.FMarchConsume.DailyItems[_loc1_].Price)
            {
               FMC_Scene["MC_Bar" + _loc1_].filters = [];
            }
            else
            {
               FMC_Scene["MC_Bar" + _loc1_].filters = [TGameUtil.GaryColorFilters];
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         FMC_Scene.TF_Desc.text = this.FMarchConsume.DescListNew[1];
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FMarchConsume.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FMarchConsume.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Gold.text = this.FMarchConsume.ConsumeGold.toString();
         _loc1_ = 0;
         while(_loc1_ < this.FMarchConsume.DailyItems.length)
         {
            FMC_Scene["MC_Step" + _loc1_].TF_Gold.text = this.FMarchConsume.DailyItems[_loc1_].Price.toString();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < BUFF_COUNT)
         {
            FMC_Scene["MC_Buff" + _loc1_].TF_Gold.text = this.FMarchConsume.Price[_loc1_].toString();
            _loc1_++;
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnLogUp(param1:MouseEvent) : void
      {
         this.FProcessorMarchConsumeLog.UpdateUI();
         this.FProcessorMarchConsumeLog.Visible = true;
      }
      
      protected function ProcessorOnGetDailyBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(8));
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(Boolean(this.FMarchConsume) && this.FMarchConsume.DailyItems[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(REQ_GET_DAILY_ITEMS,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnGetTotalBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.parent.name).slice(6));
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(this.FMarchConsume && _loc2_ < this.FMarchConsume.TotalBox.length) && Boolean(_loc3_ < this.FMarchConsume.TotalBox[_loc2_].Boxes.length) && this.FMarchConsume.TotalBox[_loc2_].Boxes[_loc3_].Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(REQ_GET_TOTAL_BOXES,_loc2_ + 1,_loc3_ + 1);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FMarchConsume;
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc6_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc6_.push(param2);
         }
         if(param3 != 0)
         {
            _loc6_.push(param3);
         }
         PerformPacket_CS_AllReq(param1,_loc6_);
      }
      
      protected function ProcessorOnTotalBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.parent.name).slice(6));
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(this.FMarchConsume) && Boolean(_loc2_ < this.FMarchConsume.TotalBox.length) && _loc3_ < this.FMarchConsume.TotalBox[_loc2_].Boxes.length)
         {
            ProcessorOnNewBoxOver(this.FMarchConsume.TotalBox[_loc2_].Boxes[_loc3_].Inventories);
         }
      }
      
      protected function ProcessorOnCloseLogUp() : void
      {
         this.FProcessorMarchConsumeLog.Visible = false;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorMarchConsumeLog.Load();
            return;
         }
         this.visible = true;
         this.alpha = 1;
         this.FIsOpen = true;
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
         this.visible = false;
         this.FIsOpen = false;
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerMarchConsume.Unstreamize(_loc2_,this.FMarchConsume,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
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
         var _loc8_:int = 0;
         _loc2_ = param1.Data;
         _loc2_.readShort();
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
         var _loc13_:TBaseBox = null;
         var _loc14_:uint = 0;
         var _loc15_:TBins = null;
         var _loc16_:int = 0;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc7_)
         {
            case REQ_GET_DAILY_ITEMS:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FMarchConsume.DailyItems[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc8_ = this.FMarchConsume.DailyItems[_loc5_].Inventories;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FMarchConsume.CheckStatus());
               this.UpdateUI();
               break;
            case REQ_GET_TOTAL_BOXES:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               _loc6_ = _loc2_.readUnsignedInt() - 1;
               this.FMarchConsume.TotalBox[_loc5_].Boxes[_loc6_].Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc8_ = this.FMarchConsume.TotalBox[_loc5_].Boxes[_loc6_].Inventories;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FMarchConsume.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function Test() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeUnsignedInt(STimingCore.GetServerTick() + 100);
         _loc3_.writeShort(7);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"已完成%0天");
         TUtilityString.FlushUTF(_loc3_,"完成%0/%1");
         TUtilityString.FlushUTF(_loc3_,"活动期间共累计消费%0金币");
         TUtilityString.FlushUTF(_loc3_,"%0共累计消费%1金币");
         TUtilityString.FlushUTF(_loc3_,"%0额度每日消费奖励");
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(2);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(0);
         TUtilityString.FlushUTF(_loc3_,"xxxxx");
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(3);
            _loc3_.writeInt(0);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100002 + _loc1_);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            TUtilityString.FlushUTF(_loc3_,"Index" + _loc1_);
            _loc3_.writeInt(1401571200 + _loc1_ * 100);
            _loc3_.writeShort(1);
            _loc3_.writeInt(3);
            _loc3_.writeInt(0);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100002 + _loc1_);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

