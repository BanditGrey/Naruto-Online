package Processors.Game.Lobby.Exercise.NinjaBank
{
   import Foundation.Network.TPacket;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.NinjaBank.TNinjaBank;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerNinjaBank;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.NinjaBank.Compoents.TUINinjaBank1;
   import Processors.Game.Lobby.Exercise.NinjaBank.Compoents.TUINinjaBank2;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorNinjaBank extends TProcessorBaseActivity
   {
      
      public static const TYPE_BUY_FUND:int = 1;
      
      public static const TYPE_OPEN_BOX:int = 2;
      
      public static const TYPE_GET_GIFT:int = 3;
      
      public static const TYPE_GET_RETURN:int = 4;
      
      protected var TAB_COUNT:int = 2;
      
      protected var FNinjaBank:TNinjaBank;
      
      protected var FUnstreamizerNinjaBank:TUnstreamizerNinjaBank;
      
      protected var FChangeTabIndex:int;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FBeClicked:Boolean;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FIsOpen:Boolean;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUINinjaBank1,TUINinjaBank2]);
      
      public function TProcessorNinjaBank(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FNinjaBank = SLogicsCore.NinjaBank;
         this.FUnstreamizerNinjaBank = new TUnstreamizerNinjaBank();
         this.FBuyBoxDate = new Object();
         this.FUIWindowVect = new Vector.<TUIBaseWindow>(this.TAB_COUNT);
         this.FChangeTabIndex = 0;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Class = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            _loc4_ = this.ACTIVITY_REFERENCE[_loc1_];
            this.FUIWindowVect[_loc1_] = new _loc4_(this);
            this.FUIWindowVect[_loc1_].Perform_UIDispatch(FMC_Scene["MC_NinjaBank" + _loc1_]);
            this.FUIWindowVect[_loc1_].OnGetBox = this.ProcessorOnGetBoxUp;
            this.FUIWindowVect[_loc1_].OnBuyBox = this.ProcessorOnBuyBoxUp;
            this.FUIWindowVect[_loc1_].OnItemOver = UIComponentsHintOnOver;
            this.FUIWindowVect[_loc1_].OnItemOut = UIComponentsHintOnOut;
            this.FUIWindowVect[_loc1_].OnNewBoxOver = ProcessorOnNewBoxOver;
            this.FUIWindowVect[_loc1_].OnNewBoxOut = ProcessorOnNewBoxOut;
            this.FUIWindowVect[_loc1_].GotoRecharge = ProcessorOnRechargeUp;
            this.FUIWindowVect[_loc1_].OnShowHtmlTip = ProcessorOnShowHtmlText;
            this.FUIWindowVect[_loc1_].OnHideHtmlTip = ProcessorOnHideHtmlText;
            this.FUIWindowVect[_loc1_].OnLoadLog = this.ProcessorOnLoadLog;
            this.FUIWindowVect[_loc1_].OnShowDesc = this.ProcessorOnShowDesc;
            _loc1_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.MC_Tab0,false);
         FMC_Scene.MC_Tab0.addEventListener(MouseEvent.CLICK,this.ChangeTabOnSwitch);
         TGameUtil.setButtonMode(FMC_Scene.MC_Tab1,true);
         FMC_Scene.MC_Tab1.addEventListener(MouseEvent.CLICK,this.ChangeTabOnSwitch);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FInitialized)
         {
            if(Boolean(FMC_Scene) && FMC_Scene.visible)
            {
               this.FUIWindowVect[this.FChangeTabIndex].LogicsPerform();
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         if(this.FNinjaBank.GameStatus == 1)
         {
            TGameUtil.setButtonMode(FMC_Scene.MC_Tab0,false);
            TGameUtil.setButtonMode(FMC_Scene.MC_Tab1,false);
         }
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            if(_loc1_ == this.FChangeTabIndex)
            {
               this.FUIWindowVect[_loc1_].SetVisible(true);
               this.FUIWindowVect[_loc1_].UpdateUI();
            }
            else
            {
               this.FUIWindowVect[_loc1_].SetVisible(false);
            }
            _loc1_++;
         }
         if(this.FNinjaBank.GameStatus == 2)
         {
            FMC_Scene.MC_Tip.visible = false;
         }
         else
         {
            FMC_Scene.MC_Tip.visible = true;
            FMC_Scene.MC_Tip.MC_Tip.TF_Text.text = this.FNinjaBank.DescListNew[7];
         }
      }
      
      protected function ChangeTabOnSwitch(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(_loc2_ != this.FChangeTabIndex && this.FNinjaBank.GameStatus == 2)
         {
            if(_loc2_ == 0)
            {
               TGameUtil.setButtonMode(FMC_Scene.MC_Tab0,false);
               TGameUtil.setButtonMode(FMC_Scene.MC_Tab1,true);
            }
            else
            {
               TGameUtil.setButtonMode(FMC_Scene.MC_Tab0,true);
               TGameUtil.setButtonMode(FMC_Scene.MC_Tab1,false);
            }
            this.FChangeTabIndex = _loc2_;
            this.UpdateUI();
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "") : void
      {
         this.FBuyBoxDate.BoxType = param1;
         this.FBuyBoxDate.BoxIndex = param3;
         this.FBuyBoxDate.Cost = param2;
         this.FBuyBoxDate.CostType = param4;
         if(param4 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex);
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
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int = 0) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:int = 0;
         var _loc5_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBuyBoxDate.BoxType = param1;
         this.FBeClicked = true;
         _loc5_ = new Vector.<int>();
         _loc5_.push(param2 + 1);
         PerformPacket_CS_AllReq(param1,_loc5_);
      }
      
      protected function ProcessorOnLoadLog(param1:int) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(param1,null);
      }
      
      protected function ProcessorOnShowDesc() : void
      {
         FProcessorWindowDesc.BaseActivity = this.FNinjaBank;
         super.ProcessorOnOpenDesc();
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
         this.FIsOpen = true;
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FIsOpen = false;
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
         this.FUnstreamizerNinjaBank.Unstreamize(_loc2_,this.FNinjaBank,null);
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
         _loc2_ = param1.Data;
         _loc2_.readShort();
         this.FNinjaBank.CanBuyCount = _loc2_.readUnsignedInt();
         this.FNinjaBank.CurPrice = _loc2_.readUnsignedInt();
         this.FNinjaBank.RechargeGold = _loc2_.readUnsignedInt();
         if(this.FIsOpen)
         {
            this.UpdateUI();
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
         ProcessorUnstreamActivityLog(this.FNinjaBank,_loc2_);
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
         var _loc15_:TBaseBox = null;
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
            case TYPE_BUY_FUND:
               ++this.FNinjaBank.BoughtCount;
               --this.FNinjaBank.CanBuyCount;
               ++this.FNinjaBank.OpenBoxCount;
               this.FNinjaBank.CurBuyIndex = _loc2_.readUnsignedInt();
               _loc4_ = STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED;
               this.FNinjaBank.ChangeStatus();
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FNinjaBank.CheckStatus());
               this.UpdateUI();
               break;
            case TYPE_OPEN_BOX:
               --this.FNinjaBank.OpenBoxCount;
               this.FNinjaBank.ChangeStatus();
               _loc10_ = _loc2_.readUnsignedInt();
               _loc11_ = _loc2_.readUnsignedInt();
               _loc14_ = _loc2_.readUnsignedInt();
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc4_ = _loc4_ + (STRING_COMMON.GetItemNameByType(_loc10_,_loc11_) + "*" + _loc14_ + "\n");
               ProcessorEffectText(_loc4_);
               this.FUIWindowVect[0].PlayMovie();
               ProcessorCheckEffect(FActivityID,this.FNinjaBank.CheckStatus());
               this.UpdateUI();
               break;
            case TYPE_GET_GIFT:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FNinjaBank.OpenBoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc8_ = this.FNinjaBank.OpenBoxList[_loc5_].Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FNinjaBank.CheckStatus());
               this.UpdateUI();
               break;
            case TYPE_GET_RETURN:
               this.FNinjaBank.AwardStatus = TBaseActivity.STATUS_CANNOTGET;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FNinjaBank.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([0,0,0,1,1,1,1,1]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(12);
         TUtilityString.FlushUTF(_loc3_,"活动1");
         TUtilityString.FlushUTF(_loc3_,"活动2");
         TUtilityString.FlushUTF(_loc3_,"活动3");
         TUtilityString.FlushUTF(_loc3_,"已充值%0金币");
         TUtilityString.FlushUTF(_loc3_,"大宝箱TIP");
         TUtilityString.FlushUTF(_loc3_,"购买单价%0金币");
         TUtilityString.FlushUTF(_loc3_,"已成功购买%0份忍の基金,倒计时%1");
         TUtilityString.FlushUTF(_loc3_,"7月14日开启");
         TUtilityString.FlushUTF(_loc3_,"开启%0次");
         TUtilityString.FlushUTF(_loc3_,"开启%0次");
         TUtilityString.FlushUTF(_loc3_,"开启%0次");
         TUtilityString.FlushUTF(_loc3_,"开启%0次");
         _loc3_.writeInt(STimingCore.GetServerTime() + 1000);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(99);
         _loc3_.writeUnsignedInt(99);
         _loc3_.writeUnsignedInt(95);
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeUnsignedInt(80);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeShort(1);
            TUtilityString.FlushUTF(_loc3_,"购买2-4份基金");
            _loc3_.writeInt(_loc1_ + 1);
            _loc3_.writeInt(_loc1_ + 2);
            _loc3_.writeInt(10);
            _loc3_.writeShort(5);
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc2_ + _loc1_);
               _loc3_.writeUnsignedInt(1 + _loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(1 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(7);
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            _loc3_.writeShort(1);
            TUtilityString.FlushUTF(_loc3_,"开启" + (_loc1_ + 1) + "次");
            _loc3_.writeInt(_loc1_ + 1);
            _loc3_.writeInt(1);
            _loc3_.writeShort(1);
            _loc2_ = 0;
            while(_loc2_ < 1)
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
   }
}

