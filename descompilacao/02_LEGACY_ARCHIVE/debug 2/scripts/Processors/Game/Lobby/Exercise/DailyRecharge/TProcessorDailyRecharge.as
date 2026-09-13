package Processors.Game.Lobby.Exercise.DailyRecharge
{
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.DailyRecharge.TDailyRecharge;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerDailyRecharge;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorDailyRecharge extends TProcessorBaseActivity
   {
      
      protected static const BOX_COUNT:int = 4;
      
      protected static const REQ_TYPE_GET_DAILYBOX:int = 1;
      
      protected static const REQ_TYPE_GET_SERVERBOX:int = 2;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FDailyRecharge:TDailyRecharge;
      
      protected var FUnstreamizerDailyRecharge:TUnstreamizerDailyRecharge;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      public function TProcessorDailyRecharge(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FDailyRecharge = SLogicsCore.DailyRecharge;
         this.FUnstreamizerDailyRecharge = new TUnstreamizerDailyRecharge();
         this.FBuyBoxDate = new Object();
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Gift" + _loc1_];
            _loc3_.MC_BoxPic.MC_Icon.gotoAndStop(_loc1_ + 1);
            TGameUtil.setButtonMode(_loc3_.BTN_Get,true);
            _loc3_.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnBoxListUp);
            _loc3_.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxListOver);
            _loc3_.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            this.FBoxList[_loc1_] = _loc3_;
            _loc1_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.MC_DailyBox.BTN_Get,true);
         FMC_Scene.MC_DailyBox.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnDailyBoxUp);
         FMC_Scene.MC_DailyBox.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnDailyBoxOver);
         FMC_Scene.MC_DailyBox.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateDailyBox();
         this.UpdateBoxList();
         this.UpdateText();
      }
      
      protected function UpdateDailyBox() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TBaseBox = null;
         _loc1_ = FMC_Scene.MC_DailyBox;
         _loc2_ = this.FDailyRecharge.DailyBox;
         _loc1_.TF_Price.text = TUtilityString.Format(this.FDailyRecharge.DescListNew[2],_loc2_.Level);
         if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            _loc1_.BTN_Get.visible = true;
            _loc1_.MC_Got.visible = false;
         }
         else if(_loc2_.Status == TBaseActivity.STATUS_CANGET)
         {
            _loc1_.BTN_Get.visible = true;
            _loc1_.MC_Got.visible = false;
         }
         else
         {
            _loc1_.BTN_Get.visible = false;
            _loc1_.MC_Got.visible = true;
         }
      }
      
      protected function UpdateBoxList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc2_ = this.FBoxList[_loc1_];
            if(_loc1_ < this.FDailyRecharge.BoxList.length)
            {
               _loc3_ = this.FDailyRecharge.BoxList[_loc1_];
               _loc2_.visible = true;
               _loc2_.TF_Num.text = TUtilityString.Format(this.FDailyRecharge.DescListNew[5],_loc3_.Count);
               _loc2_.TF_LimitCount.text = TUtilityString.Format(this.FDailyRecharge.DescListNew[6],_loc3_.LimitCount);
               _loc2_.MC_Price.TF_Desc.text = TUtilityString.Format(this.FDailyRecharge.DescListNew[7],_loc3_.Price);
               if(_loc3_.LimitCount == 0)
               {
                  _loc2_.BTN_Get.visible = false;
                  _loc2_.MC_Got.visible = false;
                  _loc2_.MC_End.visible = true;
               }
               else
               {
                  _loc2_.MC_End.visible = false;
                  if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
                  {
                     _loc2_.BTN_Get.visible = true;
                     TGameUtil.setButtonMode(_loc2_.BTN_Get,false);
                     _loc2_.MC_Got.visible = false;
                  }
                  else if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
                  {
                     _loc2_.BTN_Get.visible = true;
                     TGameUtil.setButtonMode(_loc2_.BTN_Get,true);
                     _loc2_.MC_Got.visible = false;
                  }
                  else
                  {
                     _loc2_.BTN_Get.visible = false;
                     TGameUtil.setButtonMode(_loc2_.BTN_Get,false);
                     _loc2_.MC_Got.visible = true;
                  }
               }
            }
            else
            {
               _loc2_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Desc.text = this.FDailyRecharge.DescListNew[0];
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FDailyRecharge.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FDailyRecharge.EndTime) - 1) * 1000)));
         FMC_Scene.TF_DailyPrice.text = TUtilityString.Format(this.FDailyRecharge.DescListNew[1],this.FDailyRecharge.DailyBox.Price);
         FMC_Scene.TF_ServerPrice.text = TUtilityString.Format(this.FDailyRecharge.DescListNew[4],this.FDailyRecharge.DailyBox.Price);
         FMC_Scene.TF_RechargeGold.text = this.FDailyRecharge.RechargeGold.toString();
         FMC_Scene.TF_ServerNum.text = this.FDailyRecharge.ServerNum.toString();
      }
      
      protected function ProcessorOnDailyBoxUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode || this.FBeClicked)
         {
            return;
         }
         if(Boolean(this.FDailyRecharge) && Boolean(this.FDailyRecharge.DailyBox))
         {
            if(this.FDailyRecharge.DailyBox.Status == TBaseActivity.STATUS_CANGET)
            {
               this.ProcessorOnGetBoxUp(REQ_TYPE_GET_DAILYBOX);
            }
            else
            {
               ProcessorEffectText(this.FDailyRecharge.DescListNew[8]);
            }
         }
      }
      
      protected function ProcessorOnBoxListUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode || this.FBeClicked)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(this.FDailyRecharge) && _loc2_ < this.FDailyRecharge.BoxList.length)
         {
            if(this.FDailyRecharge.BoxList[_loc2_].CurPrice > 0)
            {
               this.ProcessorOnBuyBoxUp(REQ_TYPE_GET_SERVERBOX,this.FDailyRecharge.BoxList[_loc2_].CurPrice,_loc2_ + 1);
            }
            else
            {
               this.ProcessorOnGetBoxUp(REQ_TYPE_GET_SERVERBOX,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0) : void
      {
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxIndex = param3;
         this.FBuyBoxDate.Cost = param2;
         this.FBuyBoxDate.CostType = param4;
         this.FBuyBoxDate.BoxIndex1 = param6;
         if(param4 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = param2;
            if(param5 != "")
            {
               FUIWindowConfirmation.Text = param5;
            }
            else
            {
               FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            }
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
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGold >= this.FBuyBoxDate.Cost)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
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
      
      protected function ProcessorOnDailyBoxOver(param1:MouseEvent) : void
      {
         if(Boolean(this.FDailyRecharge) && Boolean(this.FDailyRecharge.DailyBox))
         {
            ProcessorOnNewBoxOver(this.FDailyRecharge.DailyBox.Inventories);
         }
      }
      
      protected function ProcessorOnBoxListOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(this.FDailyRecharge) && _loc2_ < this.FDailyRecharge.BoxList.length)
         {
            ProcessorOnNewBoxOver(this.FDailyRecharge.BoxList[_loc2_].Inventories);
         }
      }
      
      override protected function PerformPacket_CS_LoadLogReq(param1:MouseEvent = null) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
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
         this.FIsOpen = true;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
         PerformPacket_CS_LoadInfoReq();
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
         this.FUnstreamizerDailyRecharge.Unstreamize(_loc2_,this.FDailyRecharge,null);
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
         if(Boolean(this.FDailyRecharge) && Boolean(this.FDailyRecharge.DailyBox) && this.FDailyRecharge.BoxList.length > 0)
         {
            this.FDailyRecharge.RechargeGold = _loc2_.readUnsignedInt();
            this.FDailyRecharge.ServerNum = _loc2_.readUnsignedInt();
            this.FDailyRecharge.ChangeStatus();
            ProcessorCheckEffect(FActivityID,this.FDailyRecharge.CheckStatus());
            if(this.FIsOpen)
            {
               this.UpdateUI();
            }
         }
      }
      
      override public function ProcessorActivityThirdLoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         ProcessorUnstreamActivityLog(this.FDailyRecharge,_loc2_);
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
            case REQ_TYPE_GET_DAILYBOX:
               this.FDailyRecharge.DailyBox.Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc16_ = this.FDailyRecharge.DailyBox.Inventories.Count;
               _loc5_ = 0;
               while(_loc5_ < _loc16_)
               {
                  _loc9_ = this.FDailyRecharge.DailyBox.Inventories.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               this.FDailyRecharge.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FDailyRecharge.CheckStatus());
               this.UpdateUI();
               break;
            case REQ_TYPE_GET_SERVERBOX:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FDailyRecharge.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               --this.FDailyRecharge.BoxList[_loc5_].LimitCount;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc16_ = this.FDailyRecharge.BoxList[_loc5_].Inventories.Count;
               _loc6_ = 0;
               while(_loc6_ < _loc16_)
               {
                  _loc9_ = this.FDailyRecharge.BoxList[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               ProcessorEffectText(_loc4_);
               this.FDailyRecharge.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FDailyRecharge.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function Test() : void
      {
      }
   }
}

