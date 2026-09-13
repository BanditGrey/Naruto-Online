package Processors.Game.Lobby.Exercise.RechargeGive
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.RechargeGive.TRechargeGive;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerBaseInventories;
   import Logics.Streamization.Exercise.TUnstreamizerRechargeGive;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorRechargeGive extends TProcessorBaseActivity
   {
      
      public static const BOX_COUNT:uint = TRechargeGive.BOX_COUNT;
      
      public static const ITEM_COUNT:uint = 6;
      
      public static const TAB_TYPE_CONSUME:int = 0;
      
      public static const TAB_TYPE_RECHARGE:int = 1;
      
      public static const TYPE_CONSUME:int = 1;
      
      public static const TYPE_RECHARGE:int = 2;
      
      protected var FRechargeGive:TRechargeGive;
      
      protected var FBeClicked:Boolean;
      
      protected var FUnstreamizerBaseInventories:TUnstreamizerBaseInventories;
      
      protected var FUnstreamizerRechargeGive:TUnstreamizerRechargeGive;
      
      protected var FUIBoxVect:Vector.<TUIBaseBox>;
      
      protected var FTF_CurValue:TextField;
      
      protected var FBtn_TabConsume:MovieClip;
      
      protected var FBtn_TabRecharge:MovieClip;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FUITab:TUITab;
      
      protected var FTabVect:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FMC_ChangePage:MovieClip;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      public function TProcessorRechargeGive(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FRechargeGive = SLogicsCore.RechargeGive;
         this.FUnstreamizerBaseInventories = new TUnstreamizerBaseInventories();
         this.FUnstreamizerRechargeGive = new TUnstreamizerRechargeGive();
         this.FUIBoxVect = new Vector.<TUIBaseBox>(BOX_COUNT);
         this.FUITab = new TUITab(this);
         this.FTabVect = new Vector.<MovieClip>();
         this.FChangeTabIndex = 0;
         this.FUIPage = new TUIPage(this);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIBaseBox = null;
         super.ResourcesPerform_UIDispatch();
         this.FTF_CurValue = FMC_Scene["TF_CurValue"];
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc5_ = new TUIBaseBox(this,ITEM_COUNT);
            _loc5_.Perform_UIDispatch(FMC_Scene["MC_Item" + _loc1_]);
            _loc5_.OnOverlay = this.SlotsOnOver;
            _loc5_.OnOut = this.SlotsOnOut;
            _loc5_.OnGetBox = this.ProcessorOnBuyUp;
            _loc5_.OnBtnOver = this.ProcessorOnBtnOver;
            _loc5_.OnBtnOut = this.ProcessorOnBtnOut;
            this.FUIBoxVect[_loc1_] = _loc5_;
            _loc1_++;
         }
         this.FBtn_TabConsume = FMC_Scene["Btn_TabConsume"];
         this.FBtn_TabRecharge = FMC_Scene["Btn_TabRecharge"];
         this.FTabVect.push(this.FBtn_TabConsume);
         this.FTabVect.push(this.FBtn_TabRecharge);
         _loc2_ = int(this.FTabVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FUITab.SetTabByIndex(this.FTabVect[_loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.ChangeTabOnSwitch;
         this.FUITab.Init();
         this.FMC_ChangePage = FMC_Scene["MC_ChangePage"];
         this.FUIPage.ButtonPrevious.Substrate = this.FMC_ChangePage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = this.FMC_ChangePage.MC_PageRight;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = BOX_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.FMC_Mask = FMC_Scene["MC_Mask"];
         this.FMC_Mask.visible = false;
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
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FRechargeGive.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FRechargeGive.EndTime - 1) * 1000)));
         switch(this.FChangeTabIndex)
         {
            case TAB_TYPE_CONSUME:
               FTF_Desc.text = this.FRechargeGive.ActivityName;
               this.FTF_CurValue.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_TODAY_CONSUME,this.FRechargeGive.CurConsume);
               break;
            case TAB_TYPE_RECHARGE:
               FTF_Desc.text = this.FRechargeGive.ActivityDesc;
               this.FTF_CurValue.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_TODAY_RECHARGE,this.FRechargeGive.CurRecharge);
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:TInventories = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:TBaseBox = null;
         var _loc7_:Vector.<TBaseBox> = null;
         if(this.FChangeTabIndex == TAB_TYPE_CONSUME)
         {
            _loc7_ = this.FRechargeGive.ConsumeBoxVect;
         }
         else
         {
            _loc7_ = this.FRechargeGive.RechargeBoxVect;
         }
         this.FUIPage.TotalQuantity = _loc7_.length;
         this.FUIPage.Update();
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            _loc4_ = _loc2_ + this.FCurPage * BOX_COUNT;
            if(_loc4_ < _loc7_.length)
            {
               this.FUIBoxVect[_loc2_].SetVisible(true);
               _loc6_ = _loc7_[_loc4_];
               _loc1_ = _loc6_.Inventories;
               this.FUIBoxVect[_loc2_].UpdateUI(_loc1_);
               if(_loc6_.Status == TBaseActivity.STATUS_CANGET)
               {
                  this.FUIBoxVect[_loc2_].SetBtnMode(true);
                  this.FUIBoxVect[_loc2_].IsBoxGot(false);
               }
               else if(_loc6_.Status == TBaseActivity.STATUS_GETED)
               {
                  this.FUIBoxVect[_loc2_].SetBtnMode(false);
                  this.FUIBoxVect[_loc2_].IsBoxGot(true);
               }
               else
               {
                  this.FUIBoxVect[_loc2_].SetBtnMode(false);
                  this.FUIBoxVect[_loc2_].IsBoxGot(false);
               }
               _loc5_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_TOTAL_RECHARGE,_loc6_.Price);
               this.FUIBoxVect[_loc2_].SetPriceText(_loc5_);
            }
            else
            {
               this.FUIBoxVect[_loc2_].SetVisible(false);
            }
            _loc2_++;
         }
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         if(_loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         this.FCurPage = 0;
         if(this.FChangeTabIndex == TAB_TYPE_CONSUME)
         {
            this.FMC_Mask.visible = false;
         }
         else
         {
            this.FMC_Mask.visible = true;
         }
         this.UpdateUI();
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateUI();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         if(this.FRechargeGive)
         {
            FNeedConfig = this.FRechargeGive.NeedConfig;
         }
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnBuyUp(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Vector.<TBaseBox> = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBeClicked)
         {
            return;
         }
         _loc4_ = int(param1.currentTarget.parent.name.slice(7));
         _loc5_ = _loc4_ + this.FCurPage * BOX_COUNT;
         if(this.FChangeTabIndex == TAB_TYPE_CONSUME)
         {
            _loc6_ = this.FRechargeGive.ConsumeBoxVect;
            if(_loc5_ > _loc6_.length - 1)
            {
               return;
            }
            FIndex = _loc5_;
            this.PerformPacket_CS_GetRewardReq();
         }
         else
         {
            _loc6_ = this.FRechargeGive.RechargeBoxVect;
            if(_loc5_ > _loc6_.length - 1)
            {
               return;
            }
            FIndex = _loc5_;
            this.PerformPacket_CS_BuyBoxReq();
         }
      }
      
      override protected function PerformPacket_CS_GetRewardReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_GetRewardReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         _loc2_.Data.writeUnsignedInt(FIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      override protected function PerformPacket_CS_BuyBoxReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_BuyBoxReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         _loc2_.Data.writeUnsignedInt(FIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
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
      }
      
      protected function ProcessorOnBtnOut(param1:MouseEvent) : void
      {
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
         this.visible = false;
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
         this.FUnstreamizerRechargeGive.Unstreamize(_loc2_,this.FRechargeGive,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorGetRewardRet(param1:TPacket = null) : void
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
         var _loc12_:Vector.<TBaseBox> = null;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc12_ = this.FRechargeGive.ConsumeBoxVect;
         _loc10_ = _loc12_[FIndex].Inventories;
         _loc12_[FIndex].Status = TBaseActivity.STATUS_GETED;
         _loc11_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc7_ = 0;
         while(_loc7_ < _loc10_.Count)
         {
            _loc11_ += _loc10_.GetInventoryByIndex(_loc7_).Name + "*" + _loc10_.GetInventoryByIndex(_loc7_).Quantity + "\n";
            _loc7_++;
         }
         ProcessorEffectText(_loc11_);
         ProcessorCheckEffect(FActivityID,this.FRechargeGive.CheckBoxStatus());
         this.UpdateUI();
      }
      
      override public function ProcessorBuyBoxRet(param1:TPacket = null) : void
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
         var _loc12_:Vector.<TBaseBox> = null;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc12_ = this.FRechargeGive.RechargeBoxVect;
         _loc10_ = _loc12_[FIndex].Inventories;
         _loc12_[FIndex].Status = TBaseActivity.STATUS_GETED;
         _loc11_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc7_ = 0;
         while(_loc7_ < _loc10_.Count)
         {
            _loc11_ += _loc10_.GetInventoryByIndex(_loc7_).Name + "*" + _loc10_.GetInventoryByIndex(_loc7_).Quantity + "\n";
            _loc7_++;
         }
         ProcessorEffectText(_loc11_);
         ProcessorCheckEffect(FActivityID,this.FRechargeGive.CheckBoxStatus());
         this.UpdateUI();
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc3_ / 2)
         {
            _loc5_ = _loc2_.readInt();
            _loc6_ = _loc2_.readInt();
            _loc4_++;
         }
         if(_loc5_ == TYPE_CONSUME)
         {
            this.FRechargeGive.CurConsume = _loc6_;
            this.FRechargeGive.ChangeBoxStatus();
            if(this.FRechargeGive.RechargeBoxVect.length > 0)
            {
               ProcessorCheckEffect(FActivityID,this.FRechargeGive.CheckBoxStatus());
            }
         }
         else if(_loc5_ == TYPE_RECHARGE)
         {
            this.FRechargeGive.CurRecharge = _loc6_;
            this.FRechargeGive.ChangeBoxStatus();
            if(this.FRechargeGive.RechargeBoxVect.length > 0)
            {
               ProcessorCheckEffect(FActivityID,this.FRechargeGive.CheckBoxStatus());
            }
         }
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            this.UpdateUI();
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([50,60,70,80,90,100,110]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"活动时间");
         TUtilityString.FlushUTF(_loc3_,"你冲我送");
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(1000);
         _loc3_.writeShort(7);
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            _loc3_.writeInt(1);
            _loc3_.writeUnsignedInt(_loc4_[_loc1_]);
            _loc3_.writeShort(5);
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(_loc1_ + 1);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeInt(1);
            _loc3_.writeUnsignedInt(_loc4_[_loc1_]);
            _loc3_.writeShort(5);
            _loc2_ = 0;
            while(_loc2_ < 5)
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

