package Processors.Game.Lobby.Exercise.ComeBack
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.ComeBack.TComeBack;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerComeBack;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.ComeBack.Compoents.TUIComeBack1;
   import Processors.Game.Lobby.Exercise.ComeBack.Compoents.TUIComeBack2;
   import Processors.Game.Lobby.Exercise.ComeBack.Compoents.TUIComeBack3;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.utils.ByteArray;
   
   public class TProcessorComeBack extends TProcessorBaseActivity
   {
      
      protected static const WINDOW_COUNT:int = 3;
      
      public static const TYPE_GET_OLD_AWARD_REQ:int = 1;
      
      public static const TYPE_LOTTERY_REQ:int = 2;
      
      public static const TYPE_GET_NEW_AWARD_REQ:int = 3;
      
      public static const TYPE_BUY_SALE_ITEM_REQ:int = 4;
      
      public static const TYPE_GET_BACK_AWARD_REQ:int = 5;
      
      public static const TYPE_GET_RETURN_GOLD_REQ:int = 6;
      
      protected var FBeClicked:Boolean;
      
      protected var FBuyBoxDate:Object;
      
      protected var FWindowIndex:int;
      
      protected var FUnstreamizerComeBack:TUnstreamizerComeBack;
      
      protected var FComeBack:TComeBack;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIComeBack1,TUIComeBack2,TUIComeBack3]);
      
      public function TProcessorComeBack(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FComeBack = SLogicsCore.ComeBack;
         this.FUnstreamizerComeBack = new TUnstreamizerComeBack();
         this.FUIWindowVect = new Vector.<TUIBaseWindow>(WINDOW_COUNT);
         this.FBuyBoxDate = new Object();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Class = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < WINDOW_COUNT)
         {
            _loc4_ = this.ACTIVITY_REFERENCE[_loc1_];
            this.FUIWindowVect[_loc1_] = new _loc4_(this);
            this.FUIWindowVect[_loc1_].Perform_UIDispatch(FMC_Scene["MC_Activity" + _loc1_]);
            this.FUIWindowVect[_loc1_].OnShowWindow = this.ProcessorOnShowWindow;
            this.FUIWindowVect[_loc1_].OnCloseWindow = this.ProcessorOnCloseWindow;
            this.FUIWindowVect[_loc1_].OnActiveUp = this.ProcessorOnActiveUp;
            this.FUIWindowVect[_loc1_].OnItemOver = UIComponentsHintOnOver;
            this.FUIWindowVect[_loc1_].OnItemOut = UIComponentsHintOnOut;
            this.FUIWindowVect[_loc1_].OnShowDesc = this.ProcessorOnShowDesc;
            this.FUIWindowVect[_loc1_].OnLoadLog = this.ProcessorOnLoadLog;
            this.FUIWindowVect[_loc1_].OnNewBoxOver = ProcessorOnNewBoxOver;
            this.FUIWindowVect[_loc1_].OnNewBoxOut = ProcessorOnNewBoxOut;
            this.FUIWindowVect[_loc1_].OnBuyBox = this.ProcessorOnBuyBoxUp;
            this.FUIWindowVect[_loc1_].OnGetBox = this.ProcessorOnGetBoxUp;
            this.FUIWindowVect[_loc1_].OnShowFlowText = ProcessorEffectText;
            this.FUIWindowVect[_loc1_].GotoRecharge = ProcessorOnRechargeUp;
            _loc1_++;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            this.FUIWindowVect[this.FWindowIndex].LogicsPerform();
         }
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FUIWindowVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FWindowIndex == _loc1_)
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
      }
      
      protected function ProcessorOnShowWindow(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.FWindowIndex = param1;
         this.UpdateUI();
      }
      
      protected function ProcessorOnActiveUp(param1:String) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ComeBack_CDKActiveReq);
         TUtilityString.FlushUTF(_loc2_.Data,param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         if(FOnClose != null)
         {
            FOnClose(null);
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 0, param6:String = "") : void
      {
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxType = param2;
         this.FBuyBoxDate.BoxIndex = param4;
         this.FBuyBoxDate.Cost = param3;
         this.FBuyBoxDate.CostType = param5;
         if(param5 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex);
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            if(param6 != "")
            {
               FUIWindowConfirmation.Text = param6;
            }
            else
            {
               FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,param3);
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
         this.FBeClicked = true;
         _loc5_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc5_.push(param2);
         }
         PerformPacket_CS_AllReq(param1,_loc5_);
      }
      
      protected function ProcessorOnLoadLog(param1:int) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(param1,null);
      }
      
      protected function ProcessorOnShowDesc(param1:String = "") : void
      {
         FProcessorWindowDesc.BaseActivity = this.FComeBack;
         FProcessorWindowDesc.Visible = true;
         FProcessorWindowDesc.UpdateUI(param1);
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
         this.FUnstreamizerComeBack.Unstreamize(_loc2_,this.FComeBack,null);
         if(FIsResourcesLoadCompleted && FMC_Scene.visible)
         {
            this.UpdateUI();
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
            case TYPE_GET_NEW_AWARD_REQ:
               this.FComeBack.NewAward.Status = TBaseActivity.STATUS_GETED;
               _loc8_ = this.FComeBack.NewAward.Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FComeBack.CheckStatus());
               this.UpdateUI();
               break;
            case TYPE_GET_OLD_AWARD_REQ:
               this.FComeBack.OldAward.Status = TBaseActivity.STATUS_GETED;
               _loc8_ = this.FComeBack.OldAward.Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FComeBack.CheckStatus());
               this.UpdateUI();
               break;
            case TYPE_LOTTERY_REQ:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FComeBack.CDKLotteryAward.Count = _loc2_.readInt();
               --this.FComeBack.CDKLotteryAward.Status;
               this.FUIWindowVect[1].PlayMovie(_loc5_);
               ProcessorCheckEffect(FActivityID,this.FComeBack.CheckStatus());
               break;
            case TYPE_GET_BACK_AWARD_REQ:
               this.FComeBack.BackAwardStatus = TBaseActivity.STATUS_GETED;
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
               ProcessorCheckEffect(FActivityID,this.FComeBack.CheckStatus());
               this.UpdateUI();
               break;
            case TYPE_GET_RETURN_GOLD_REQ:
               _loc4_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED + STRING_BASEACTIVITY.FORMAT_PAY_LIMIT,this.FComeBack.RewardGold);
               this.FComeBack.RewardGold = 0;
               this.FComeBack.RechargeGold = 0;
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FComeBack.CheckStatus());
               this.UpdateUI();
               break;
            case TYPE_BUY_SALE_ITEM_REQ:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               --this.FComeBack.SaleBox[_loc5_].LimitCount;
               _loc8_ = this.FComeBack.SaleBox[_loc5_].Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FComeBack.CheckStatus());
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
         if(this.FComeBack)
         {
            this.FComeBack.TotalRechargeGold = _loc2_.readUnsignedInt();
            this.FComeBack.RechargeGold = _loc2_.readUnsignedInt();
            this.FComeBack.RewardGold = _loc2_.readUnsignedInt();
            if(this.FComeBack.BackAwardList)
            {
               _loc4_ = 0;
               while(_loc4_ < 4)
               {
                  this.FComeBack.BackAwardList["Type" + _loc4_] = _loc2_.readUnsignedInt();
                  this.FComeBack.BackAwardList["Value" + _loc4_] = _loc2_.readUnsignedInt();
                  _loc4_++;
               }
            }
            ProcessorCheckEffect(FActivityID,this.FComeBack.CheckStatus());
            if(FIsResourcesLoadCompleted && FMC_Scene.visible)
            {
               this.UpdateUI();
            }
         }
      }
      
      override public function ProcessorOnCDKActiveRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         if(this.FComeBack.CDKLotteryAward)
         {
            ++this.FComeBack.CDKLotteryAward.BuyCount;
            this.FComeBack.CDKLotteryAward.Status = _loc2_.readInt();
            this.FComeBack.CDKLotteryAward.Count = _loc2_.readInt();
            ProcessorEffectText(this.FComeBack.DescListNew[8]);
         }
         if(FIsResourcesLoadCompleted && FMC_Scene.visible)
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
         _loc5_ = this.FComeBack as TBaseActivity;
         ProcessorUnstreamActivityLog(_loc5_,_loc2_);
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(9);
         TUtilityString.FlushUTF(_loc3_,"老玩家在新服活动说明长");
         TUtilityString.FlushUTF(_loc3_,"老玩家在新服活动说明短1");
         TUtilityString.FlushUTF(_loc3_,"且在2014年12月-2014年12月4日");
         TUtilityString.FlushUTF(_loc3_,"你当前为老玩家，可领取老玩家礼包");
         TUtilityString.FlushUTF(_loc3_,"你当前为新玩家，可领取新玩家礼包");
         TUtilityString.FlushUTF(_loc3_,"老玩家在新服活动说明短2");
         TUtilityString.FlushUTF(_loc3_,"当前已激活邀请码:%0个");
         TUtilityString.FlushUTF(_loc3_,"还差%0个就能进行抽奖");
         TUtilityString.FlushUTF(_loc3_,"CDK使用成功");
         TUtilityString.FlushUTF(_loc3_,"2014服");
         _loc3_.writeInt(1);
         _loc3_.writeInt(1);
         _loc3_.writeInt(1);
         TUtilityString.FlushUTF(_loc3_,"且在2014年12月1日-2014年12月4日");
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.writeInt(0);
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100002 + _loc1_);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100003 + _loc1_);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.writeInt(10);
         _loc3_.writeInt(5);
         _loc3_.writeInt(1);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100004 + _loc1_);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
      
      protected function Test1() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(6);
         TUtilityString.FlushUTF(_loc3_,"老玩家在老服长描述");
         TUtilityString.FlushUTF(_loc3_,"老玩家在老服短描述1");
         TUtilityString.FlushUTF(_loc3_,"老玩家在老服短描述2");
         TUtilityString.FlushUTF(_loc3_,"充值了100金币,可获得额外返还10%");
         TUtilityString.FlushUTF(_loc3_,"活动期间内充值可额外获得50%金币返回");
         TUtilityString.FlushUTF(_loc3_,"尚未充值无法获得加成");
         TUtilityString.FlushUTF(_loc3_,"你离开了%0天，可获得以下奖励:");
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"2014服");
         _loc3_.writeInt(2);
         _loc3_.writeInt(1);
         _loc3_.writeInt(50);
         _loc3_.writeInt(0);
         _loc3_.writeInt(40);
         _loc3_.writeInt(10);
         _loc3_.writeInt(20);
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 10);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(1 + _loc1_);
            _loc3_.writeUnsignedInt(10 + _loc1_);
            _loc3_.writeUnsignedInt(1 + _loc1_);
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

