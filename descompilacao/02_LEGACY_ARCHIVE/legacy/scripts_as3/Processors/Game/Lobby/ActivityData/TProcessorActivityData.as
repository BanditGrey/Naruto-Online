package Processors.Game.Lobby.ActivityData
{
   import Foundation.Container.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Logics.*;
   import Logics.ActivityMode.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Signals.*;
   import Logics.Streamization.ActivityMode.*;
   import Logics.Streamization.Inventories.*;
   import Processors.*;
   import Processors.Game.*;
   import Processors.Game.Lobby.Common.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.utils.*;
   
   public class TProcessorActivityData extends TProcessorLobbyModule
   {
      
      public static const SIGNALDESTINATIONS_ACTIVE_GiftBag_Ret:uint = CONST_SIGNAL.SIGNALDESTINATION_ACTIVE_GiftBag_Ret;
      
      public static const SIGNALDESTINATION_ACTIVE_Inner_Ret:uint = CONST_SIGNAL.SIGNALDESTINATION_ACTIVE_Inner_Ret;
      
      public static const SIGNALDESTINATION_ACTIVE_Recharge_Ret:uint = CONST_SIGNAL.SIGNALDESTINATION_ACTIVE_Recharge_Ret;
      
      public static const SIGNALDESTINATION_ACTIVE_FirstRecharge_Ret:uint = CONST_SIGNAL.SIGNALDESTINATION_ACTIVE_FirstRecharge_Ret;
      
      public static const ACTIVITY_COUNT:uint = CONST_ACTIVITY_MODE.ACTIVITY_COUNT;
      
      public static const KEY_Activity_OnLineGiftBag:uint = CONST_ACTIVITY_MODE.Activity_OnLineGiftBag;
      
      public static const KEY_Activity_GoldGiftBag:uint = CONST_ACTIVITY_MODE.Activity_GoldGiftBag;
      
      public static const KEY_Activity_FirstDayGiftBag:uint = CONST_ACTIVITY_MODE.Activity_FirstDayGiftBag;
      
      public static const KEY_Activity_7DayGiftBag:uint = CONST_ACTIVITY_MODE.Activity_7DayGiftBag;
      
      public static const KEY_Activity_FirstRecharge:uint = CONST_ACTIVITY_MODE.Activity_FirstRecharge;
      
      public static const KEY_Activity_FlockRecharge:uint = CONST_ACTIVITY_MODE.Activity_FlockRecharge;
      
      public static const KEY_Activity_OnePay:uint = CONST_ACTIVITY_MODE.Activity_OnePay;
      
      public static const KEY_Activity_VIPBox:uint = CONST_ACTIVITY_MODE.Activity_VIPBox;
      
      public static const KEY_Activity_EreryDayRecharge:uint = CONST_ACTIVITY_MODE.Activity_EreryDayRecharge;
      
      public static const KEY_Activity_LevelRanking:uint = CONST_ACTIVITY_MODE.Activity_LevelRanking;
      
      public static const KEY_Activity_PowerRanking:uint = CONST_ACTIVITY_MODE.Activity_PowerRanking;
      
      public static const KEY_Activity_AreanRanking:uint = CONST_ACTIVITY_MODE.Activity_AreanRanking;
      
      public static const KEY_Activity_PurpleHeros:uint = CONST_ACTIVITY_MODE.Activity_PurpleHeros;
      
      public static const KEY_Activity_GoldHeros:uint = CONST_ACTIVITY_MODE.Activity_GoldHeros;
      
      public static const KEY_Activity_CampPass:uint = CONST_ACTIVITY_MODE.Activity_CampPass;
      
      public static const KEY_Activity_KillHeroPass:uint = CONST_ACTIVITY_MODE.Activity_KillHeroPass;
      
      public static const KEY_Activity_MilitaryLv:uint = CONST_ACTIVITY_MODE.Activity_MilitaryLv;
      
      public static const KEY_Activity_TalismanLv:uint = CONST_ACTIVITY_MODE.Activity_TalismanLv;
      
      public static const KEY_Activity_JadeCombin:uint = CONST_ACTIVITY_MODE.Activity_JadeCombin;
      
      public static const KEY_Activity_SHeroLv:uint = CONST_ACTIVITY_MODE.Activity_SHeroLv;
      
      public static const KEY_Activity_Inventorie:uint = CONST_ACTIVITY_MODE.Activity_Inventorie;
      
      public static const KEY_Activity_RechageCashback:uint = CONST_ACTIVITY_MODE.Activity_RechageCashback;
      
      public static const KEY_Activity_AddConsume:uint = CONST_ACTIVITY_MODE.Activity_AddConsume;
      
      public static const KEY_Activity_DailyConsume:uint = CONST_ACTIVITY_MODE.Activity_DailyConsume;
      
      public static const KEY_Activity_InvestmentFunds:uint = CONST_ACTIVITY_MODE.Activity_InvestmentFunds;
      
      public static const KEY_Activity_JadeCombinHF:uint = CONST_ACTIVITY_MODE.Activity_JadeCombinHF;
      
      public static const KEY_Activity_PetRankHF:uint = CONST_ACTIVITY_MODE.Activity_PetRankHF;
      
      public static const KEY_Activity_HFReward:uint = CONST_ACTIVITY_MODE.Activity_HFReward;
      
      public static const KEY_Activity_HFPowerRanking:uint = CONST_ACTIVITY_MODE.Activity_HFPowerRanking;
      
      public static const KEY_ACTIVITY_COLLECTGAME:uint = CONST_ACTIVITY_MODE.ACTIVITY_COLLECTGAME;
      
      public static const KEY_ACTIVITY_LEVELGIFT:uint = CONST_ACTIVITY_MODE.ACTIVITY_LEVELGIFT;
      
      public static const KEY_Activity_RewardPsychicBeast:uint = CONST_ACTIVITY_MODE.Activity_RewardPsychicBeast;
      
      public static const KEY_Activity_RechageRanking:uint = CONST_ACTIVITY_MODE.Activity_RechageRanking;
      
      protected var FUnstreamizerActivityModes:TUnstreamizerActivityModes;
      
      protected var FActivityBins:TBins;
      
      protected var FActiveListBins:TBins;
      
      protected var FArticleBins:TBins;
      
      protected var FAwardBins:TBins;
      
      protected var FActiveHashMap:THashMap;
      
      protected var FActivityModes:TActivityModes;
      
      protected var FIsInit:Boolean;
      
      protected var FOnOpenActivityListStatusNotification:Function;
      
      public function TProcessorActivityData(param1:TUIComponent, param2:TLobbyParameters = null)
      {
         super(param1,param2);
         this.FUnstreamizerActivityModes = new TUnstreamizerActivityModes();
         this.FActivityModes = SLogicsCore.ActivityModes;
         this.ConstructCounterHashMap();
         this.FIsInit = false;
         FResourcesState = RESOURCESSTATE_UIRequest;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FActivityBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Activity);
         this.FActiveListBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ActiveList);
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FAwardBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Award);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Activity_LoadActivityInfoRet,this.PacketPerform_SC_LoadActiviesInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Activity_ActivityStatusRet,this.PacketPerform_SC_ActivieStatusRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Activity_ReceiveAwardsRet,this.PacketPerform_SC_ReceiveAwardsRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Activity_ActivityNotify,this.PacketPerform_SC_ActivityNotify);
      }
      
      protected function PacketPerform_SC_LoadActiviesInfoRet(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:TActivityAtoms = null;
         var _loc8_:TActivityAtom = null;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:Vector.<TBins> = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Boolean = false;
         _loc9_ = new Vector.<uint>();
         _loc4_ = param1.Data;
         _loc3_ = int(_loc4_.readUnsignedShort());
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = _loc4_.readUnsignedInt();
            _loc6_ = _loc4_.readUnsignedInt();
            if(_loc5_ == 427001)
            {
            }
            _loc7_ = this.FActivityModes.GetActivityAtomsByIdentifier(_loc6_);
            if(_loc7_ == null)
            {
               _loc7_ = new TActivityAtoms(_loc6_);
               _loc7_.ChgIconStatus = this.ProcessorOpenAcitvityStatusShortcutsNotification;
               this.FActivityModes.Add(_loc7_);
            }
            _loc11_ = _loc4_.readUnsignedInt();
            _loc12_ = _loc4_.readUnsignedInt();
            _loc13_ = Boolean(_loc4_.readUnsignedByte());
            _loc8_ = _loc7_.GetActivityAtomByIdentifier(_loc5_);
            if(_loc8_ == null)
            {
               _loc8_ = new TActivityAtom(_loc5_);
               _loc7_.Add(_loc8_);
            }
            _loc8_.StartTime = _loc11_;
            _loc8_.EndTime = _loc12_;
            _loc8_.IsOn = _loc13_;
            if(_loc13_)
            {
               _loc9_.push(_loc5_);
            }
            _loc2_++;
         }
         if(!this.FIsInit)
         {
            _loc10_ = new Vector.<TBins>();
            _loc10_.push(this.FActivityBins);
            _loc10_.push(this.FActiveListBins);
            _loc10_.push(this.FArticleBins);
            _loc10_.push(this.FAwardBins);
            this.FUnstreamizerActivityModes.Unstreamize(null,this.FActivityModes,_loc10_);
            _loc10_.length = 0;
         }
         this.ActivieStatusReq(_loc9_);
         this.FIsInit = true;
      }
      
      protected function PacketPerform_SC_ActivieStatusRet(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:TActivityAtoms = null;
         var _loc9_:TActivityAtom = null;
         var _loc10_:Vector.<uint> = null;
         _loc10_ = new Vector.<uint>();
         _loc4_ = param1.Data;
         _loc3_ = int(_loc4_.readUnsignedShort());
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = _loc4_.readUnsignedInt();
            _loc7_ = _loc4_.readUnsignedInt();
            _loc8_ = this.FActivityModes.GetActivityAtomsByIdentifier(_loc7_);
            _loc9_ = _loc8_.GetActivityAtomByIdentifier(_loc6_);
            _loc9_.ActiveStatus = _loc4_.readByte();
            if(_loc10_.indexOf(_loc7_) < 0)
            {
               _loc10_.push(_loc7_);
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc10_.length)
         {
            _loc7_ = _loc10_[_loc2_];
            _loc8_ = this.FActivityModes.GetActivityAtomsByIdentifier(_loc7_);
            _loc5_ = uint(this.FActiveHashMap.GetValue(_loc7_));
            SLogicsCore.SignalPost(_loc5_,_loc7_,0,_loc8_);
            _loc2_++;
         }
         this.ProcessorOpenAcitvityStatusShortcutsNotification();
      }
      
      protected function PacketPerform_SC_ReceiveAwardsRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TActivityAtoms = null;
         var _loc6_:TActivityAtom = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:TActiveList = null;
         _loc2_ = param1.Data;
         _loc7_ = _loc2_.readUnsignedInt();
         if(_loc7_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc7_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         _loc10_ = this.FActiveListBins.GetDatebaseByIdentifier(_loc4_) as TActiveList;
         _loc5_ = this.FActivityModes.GetActivityAtomsByIdentifier(_loc10_.Type);
         if(_loc10_.Type == KEY_Activity_InvestmentFunds)
         {
            EffectGenerateText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
         }
         else
         {
            EffectGenerateText(STRING_ACTIVITYINNER.STREING_REWARD_SUCCEED);
         }
         _loc9_ = new Vector.<uint>();
         _loc8_ = 0;
         while(_loc8_ < _loc5_.Count)
         {
            _loc6_ = _loc5_.GetActivityAtomByIndex(_loc8_);
            _loc9_.push(_loc6_.Identifier);
            _loc8_++;
         }
         this.ActivieStatusReq(_loc9_);
      }
      
      protected function PacketPerform_SC_ActivityNotify(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TActivityAtoms = null;
         var _loc5_:TActivityAtom = null;
         var _loc6_:uint = 0;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:TActiveList = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(this.FActiveListBins == null)
         {
            this.FActiveListBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ActiveList);
         }
         _loc8_ = this.FActiveListBins.GetDatebaseByIdentifier(_loc3_) as TActiveList;
         if(_loc8_ == null)
         {
            return;
         }
         _loc4_ = this.FActivityModes.GetActivityAtomsByIdentifier(_loc8_.Type);
         if(_loc4_ == null)
         {
            return;
         }
         _loc7_ = new Vector.<uint>();
         _loc6_ = 0;
         while(_loc6_ < _loc4_.Count)
         {
            _loc5_ = _loc4_.GetActivityAtomByIndex(_loc6_);
            _loc7_.push(_loc5_.Identifier);
            _loc6_++;
         }
         this.ActivieStatusReq(_loc7_);
      }
      
      protected function ActivieStatusReq(param1:Vector.<uint>) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         if(param1.length > 0)
         {
            _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Activity_ActivityStatusReq);
            _loc4_ = _loc3_.Data;
            _loc4_.writeShort(param1.length);
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               _loc4_.writeInt(param1[_loc2_]);
               _loc2_++;
            }
            SNetworkCore.Transceiver.PacketTransmit(_loc3_);
         }
      }
      
      protected function ConstructCounterHashMap() : void
      {
         this.FActiveHashMap = new THashMap();
         this.FActiveHashMap.Put(KEY_Activity_OnLineGiftBag,SIGNALDESTINATIONS_ACTIVE_GiftBag_Ret);
         this.FActiveHashMap.Put(KEY_Activity_GoldGiftBag,SIGNALDESTINATIONS_ACTIVE_GiftBag_Ret);
         this.FActiveHashMap.Put(KEY_Activity_FirstDayGiftBag,SIGNALDESTINATIONS_ACTIVE_GiftBag_Ret);
         this.FActiveHashMap.Put(KEY_Activity_7DayGiftBag,SIGNALDESTINATIONS_ACTIVE_GiftBag_Ret);
         this.FActiveHashMap.Put(KEY_Activity_HFReward,SIGNALDESTINATIONS_ACTIVE_GiftBag_Ret);
         this.FActiveHashMap.Put(KEY_ACTIVITY_LEVELGIFT,SIGNALDESTINATIONS_ACTIVE_GiftBag_Ret);
         this.FActiveHashMap.Put(KEY_ACTIVITY_COLLECTGAME,SIGNALDESTINATIONS_ACTIVE_GiftBag_Ret);
         this.FActiveHashMap.Put(KEY_Activity_LevelRanking,SIGNALDESTINATION_ACTIVE_Inner_Ret);
         this.FActiveHashMap.Put(KEY_Activity_PowerRanking,SIGNALDESTINATION_ACTIVE_Inner_Ret);
         this.FActiveHashMap.Put(KEY_Activity_AreanRanking,SIGNALDESTINATION_ACTIVE_Inner_Ret);
         this.FActiveHashMap.Put(KEY_Activity_PurpleHeros,SIGNALDESTINATION_ACTIVE_Inner_Ret);
         this.FActiveHashMap.Put(KEY_Activity_GoldHeros,SIGNALDESTINATION_ACTIVE_Inner_Ret);
         this.FActiveHashMap.Put(KEY_Activity_CampPass,SIGNALDESTINATION_ACTIVE_Inner_Ret);
         this.FActiveHashMap.Put(KEY_Activity_KillHeroPass,SIGNALDESTINATION_ACTIVE_Inner_Ret);
         this.FActiveHashMap.Put(KEY_Activity_MilitaryLv,SIGNALDESTINATION_ACTIVE_Inner_Ret);
         this.FActiveHashMap.Put(KEY_Activity_TalismanLv,SIGNALDESTINATION_ACTIVE_Inner_Ret);
         this.FActiveHashMap.Put(KEY_Activity_JadeCombin,SIGNALDESTINATION_ACTIVE_Inner_Ret);
         this.FActiveHashMap.Put(KEY_Activity_SHeroLv,SIGNALDESTINATION_ACTIVE_Inner_Ret);
         this.FActiveHashMap.Put(KEY_Activity_Inventorie,SIGNALDESTINATION_ACTIVE_Inner_Ret);
         this.FActiveHashMap.Put(KEY_Activity_JadeCombinHF,SIGNALDESTINATION_ACTIVE_Inner_Ret);
         this.FActiveHashMap.Put(KEY_Activity_PetRankHF,SIGNALDESTINATION_ACTIVE_Inner_Ret);
         this.FActiveHashMap.Put(KEY_Activity_HFPowerRanking,SIGNALDESTINATION_ACTIVE_Inner_Ret);
         this.FActiveHashMap.Put(KEY_Activity_RewardPsychicBeast,SIGNALDESTINATION_ACTIVE_Inner_Ret);
         this.FActiveHashMap.Put(KEY_Activity_FlockRecharge,SIGNALDESTINATION_ACTIVE_Recharge_Ret);
         this.FActiveHashMap.Put(KEY_Activity_OnePay,SIGNALDESTINATION_ACTIVE_Recharge_Ret);
         this.FActiveHashMap.Put(KEY_Activity_VIPBox,SIGNALDESTINATION_ACTIVE_Recharge_Ret);
         this.FActiveHashMap.Put(KEY_Activity_EreryDayRecharge,SIGNALDESTINATION_ACTIVE_Recharge_Ret);
         this.FActiveHashMap.Put(KEY_Activity_AddConsume,SIGNALDESTINATION_ACTIVE_Recharge_Ret);
         this.FActiveHashMap.Put(KEY_Activity_DailyConsume,SIGNALDESTINATION_ACTIVE_Recharge_Ret);
         this.FActiveHashMap.Put(KEY_Activity_InvestmentFunds,SIGNALDESTINATION_ACTIVE_Recharge_Ret);
         this.FActiveHashMap.Put(KEY_Activity_RechageRanking,SIGNALDESTINATION_ACTIVE_Recharge_Ret);
         this.FActiveHashMap.Put(KEY_Activity_FirstRecharge,SIGNALDESTINATION_ACTIVE_FirstRecharge_Ret);
      }
      
      override protected function LogicsPerform() : void
      {
         this.CheckActivieStatus();
      }
      
      protected function CheckActivieStatus() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TActivityAtom = null;
         var _loc4_:TActivityAtoms = null;
         var _loc5_:Boolean = false;
         if(this.FActivityModes == null)
         {
            return;
         }
         _loc5_ = false;
         _loc1_ = 0;
         while(_loc1_ < this.FActivityModes.Count)
         {
            _loc4_ = this.FActivityModes.GetActivityAtomsByIndex(_loc1_);
            if(STimingCore.GetClientShowTime(STimingCore.GetServerTick()) >= _loc4_.CheckTime)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc4_.Count)
               {
                  _loc3_ = _loc4_.GetActivityAtomByIndex(_loc2_);
                  _loc5_ = true;
                  _loc2_++;
               }
               _loc4_.CheckTime += 24 * 60 * 60;
            }
            _loc1_++;
         }
         if(_loc5_)
         {
            this.ProcessorOnActiveInfoReq();
         }
      }
      
      protected function ProcessorOpenAcitvityStatusShortcutsNotification() : void
      {
         if(!this.FIsInit)
         {
            return;
         }
         if(this.FOnOpenActivityListStatusNotification != null)
         {
            this.FOnOpenActivityListStatusNotification(this);
         }
      }
      
      protected function GetServerDay() : int
      {
         return (STimingCore.GetServerTick() - STimingCore.GetServerStartTime()) / (24 * 60 * 60) + 1;
      }
      
      public function get OnOpenActivityListStatusNotification() : Function
      {
         return this.FOnOpenActivityListStatusNotification;
      }
      
      public function set OnOpenActivityListStatusNotification(param1:Function) : void
      {
         this.FOnOpenActivityListStatusNotification = param1;
      }
      
      public function get IsInit() : Boolean
      {
         return this.FIsInit;
      }
      
      public function ProcessorOnActiveInfoReq() : void
      {
         var _loc1_:TPacket = null;
         if(this.FAwardBins == null)
         {
            this.FAwardBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Award);
         }
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Activity_LoadActivityInfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
   }
}

