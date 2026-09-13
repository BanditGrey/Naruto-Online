package Processors.Game.Lobby.Exercise
{
   import Foundation.Network.TPacket;
   import Foundation.UI.TUIComponent;
   import Logics.Agent.SParametersCore;
   import Logics.SLogicsCore;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.Cornucopia.TProcessorCornucopia;
   import Processors.Game.Lobby.Exercise.DecActive.TProcessorDecActive;
   import Processors.Game.Lobby.Exercise.GroupBuying.TProcessorGroupBuying;
   import Processors.Game.Lobby.Exercise.Hallowmas.TProcessorHallowmas;
   import Processors.Game.Lobby.Exercise.HappyTreasure.TProcessorHappyTreasure;
   import Processors.Game.Lobby.Exercise.NinjiaVillage.TProcessorNinjiaVillage;
   import Processors.Game.Lobby.Exercise.Smelt.TProcessorSmelt;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_PLATE;
   import Resources.Constants.CONST_SHORTCUTS;
   import flash.utils.ByteArray;
   
   public class TProcessorActivityManager extends TProcessorLobbyWindows
   {
      
      protected var FProcessorBaseActivities:Vector.<TProcessorBaseActivity>;
      
      protected var FProcessorBaseActivitiesThird:Vector.<TProcessorBaseActivity>;
      
      protected var FActivityID:uint;
      
      protected var FOnOpenActivity:Function;
      
      protected var FOnOpenThirdActivity:Function;
      
      protected var FCheckEffect:Function;
      
      protected var FOnShowHeroInfo:Function;
      
      protected var FOnAddTitle:Function;
      
      protected var FOnGoto:Function;
      
      public function TProcessorActivityManager(param1:TUIComponent, param2:TLobbyParameters = null)
      {
         super(param1,param2);
         this.ConstructTotalActivity(param1,param2);
      }
      
      protected function ConstructTotalActivity(param1:TUIComponent, param2:TLobbyParameters) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Class = null;
         var _loc6_:Vector.<Class> = null;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:Vector.<Class> = null;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:uint = 0;
         var _loc11_:TProcessorBaseActivity = null;
         _loc6_ = CONST_BASEACTIVITY.NEW_ACTIVITY_REFERENCE;
         _loc7_ = CONST_BASEACTIVITY.NEW_ACTIVELIST_TYPE;
         this.FProcessorBaseActivities = new Vector.<TProcessorBaseActivity>();
         _loc3_ = 0;
         while(_loc3_ < _loc6_.length)
         {
            _loc5_ = _loc6_[_loc3_];
            _loc10_ = _loc7_[_loc3_];
            this.FProcessorBaseActivities.push(new _loc5_(param1,param2,_loc10_));
            _loc3_++;
         }
         _loc4_ = int(this.FProcessorBaseActivities.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc11_ = this.FProcessorBaseActivities[_loc3_];
            _loc11_.OnClose = this.ProcessorsWindowsClose;
            _loc11_.OnOpenActivity = this.ProcessorOpenNewActivityList;
            _loc11_.OnEffectText = this.ProcessorEffectText;
            _loc11_.OnDialogMsg = this.ProcessorDialogMsg;
            _loc11_.CheckEffect = this.ProcessorCheckEffect;
            _loc11_.OnShowHeroInfo = this.ProcessorShowHeroInfor;
            _loc11_.OnAddTitle = this.ProcessorOnAddTitle;
            _loc11_.OnGoto = this.ProcessorOnGoto;
            _loc3_++;
         }
         _loc8_ = CONST_BASEACTIVITY.ACTIVITY_THIRD_REFERENCE;
         _loc9_ = CONST_BASEACTIVITY.ACTIVELIST_THIRD_TYPE;
         this.FProcessorBaseActivitiesThird = new Vector.<TProcessorBaseActivity>();
         _loc3_ = 0;
         while(_loc3_ < _loc8_.length)
         {
            _loc5_ = _loc8_[_loc3_];
            _loc10_ = _loc9_[_loc3_];
            this.FProcessorBaseActivitiesThird.push(new _loc5_(param1,param2,_loc10_));
            _loc3_++;
         }
         _loc4_ = int(this.FProcessorBaseActivitiesThird.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc11_ = this.FProcessorBaseActivitiesThird[_loc3_];
            _loc11_.OnClose = this.ProcessorsWindowsClose;
            _loc11_.OnOpenActivity = this.ProcessorOpenNewActivityList;
            _loc11_.OnEffectText = this.ProcessorEffectText;
            _loc11_.OnDialogMsg = this.ProcessorDialogMsg;
            _loc11_.CheckEffect = this.ProcessorCheckEffect;
            _loc11_.OnShowHeroInfo = this.ProcessorShowHeroInfor;
            _loc11_.OnAddTitle = this.ProcessorOnAddTitle;
            _loc11_.OnGoto = this.ProcessorOnGoto;
            _loc3_++;
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BaseActivity_BuyBoxRet,this.PerformPacket_SC_BuyBoxRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BaseActivity_GetRewardRet,this.PerformPacket_SC_GetRewardRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BaseActivity_OpenActivityRet,this.PerformPacket_SC_OpenActiveRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BaseActivity_ChangeStatusRet,this.PerformPacket_SC_ChangeStatusRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BaseActivity_ChangeGoldRet,this.PerformPacket_SC_ChangeGoldRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_AllActivity_Ret,this.PerformPacket_SC_AllActivityRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_HappyTreasure_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_HappyTreasure_BuyAllBoxRet,this.PerformPacket_SC_HappyTreasure_BuyAllBoxRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_HappyTreasure_LoadLogRet,this.PerformPacket_SC_HappyTreasure_LoadLogRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBuying_LoadInfoRet,this.PerformPacket_SC_GroupBuying_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_RechargeExchange_LoadInfoRet,this.PerformPacket_SC_RechargeExchange_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_OrangeEquipment_LoadInfoRet,this.PerformPacket_SC_OrangeEquipment_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_OrangeEquipment_LoadLogRet,this.PerformPacket_SC_OrangeEquipment_LoadLogRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MidAutumn_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MidAutumn_ExchangePetRet,this.PerformPacket_SC_MidAutumn_ExchangePetRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Discount_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_RechargeGive_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NationalDay_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NationalDay_GetStoneRet,this.PerformPacket_SC_NationDay_GetStoneRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NationalDay_GetHeroRet,this.PerformPacket_SC_NationDay_GetHeroRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TreasureBox_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TreasureBox_GetSmallBoxRet,this.PerformPacket_SC_NationDay_GetStoneRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjiaVillage_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjiaVillage_BuyLvUpBoxRet,this.PerformPacket_SC_BuyLvUpBoxRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Hallowmas_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Hallowmas_OtherRet,this.PerformPacket_SC_Hallowmas_OtherRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_InviteFriend_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GuaGuaLe_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_WishTree_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_EverydaySale_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_VipTreasure_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossServerSale_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Christmas_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Christmas_LoadCollectInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Christmas_LoadColorEggInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Christmas_LoadRankInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Christmas_LoadRankListInfoRet,this.PerformPacket_SC_LoadRankInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Christmas_LoadSockInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NewYear_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ActivityA_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ActivityB_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SpringFestival_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SpringFestivalFish_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SpringFestivalTaiko_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SpringFestival_LoadRankInfoRet,this.PerformPacket_SC_LoadRankInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SpringFestivalTaiko_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SpringFestivalCollect_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SpringFestivalCollect_LoadLogRet,this.PerformPacket_SC_SpringFestival_LoadLogRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ValentineDay1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ValentineDay2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ValentineDay3_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ValentineDay4_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BlackMarket_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaMeeting_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FightBoss_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FightPoint_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BrazilCarnival1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BrazilCarnival2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BrazilCarnival3_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BrazilCarnival4_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FortuneCat_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TowerLottery_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaTreasure_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaTreasure2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaTreasure3_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ActivityThird_LoadLogRet,this.PerformPacket_SC_ActivityThird_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaTreasure4_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SingleTopUp_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MayActive1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MayActive2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MayActive2_Treasures_Ret,this.PerformPacket_SC_TreasuresRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MayActive2_RewardLog_Ret,this.PerformPacket_SC_RewardLogRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MayActive3_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MayActive4_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SuperEquip_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_OneWorthThousand_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_JuneActive1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_JuneActive2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_JuneActive3_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_JuneActive4_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Payment_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaBank_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_JulyActive1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_JulyActive2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TheRecharge_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.ACTIVITY_S2C_RETURNCHARGERET,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ComeBack1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ComeBack2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ComeBack_CDKActiveRet,this.PerformPacket_SC_CDKActiveRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DessertHouse1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ActivityTask_LoadInfoRet,this.PerformPacket_SC_ActivityTask_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DessertHouse3_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_AugustActive1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_AugustActive2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NewLottery_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NewLotteryExchange_LoadInfoRet,this.PerformPacket_SC_LoadExchangeItemRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SeptemberActive1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SeptemberActive2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SeptemberActive3_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SeptemberActive4_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_OctActive1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_OctActive2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_OctActive3_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DailyRecharge_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CloudBuy_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BaseActivity_LoadNewsRet,this.PerformPacket_SC_LoadNewsRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FerrisWheel_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NovActive1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NovActive2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BaseActive_LoadRankRet,this.PerformPacket_SC_LoadActiveRankRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BaseActive_LoadRankLogRet,this.PerformPacket_SC_LoadActiveRankRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DecActive1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DecActive2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DecActive3_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DecActive4_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SuperChristmas_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DecActive2_LoadSelectNumRet,this.PerformPacket_SC_DecActive2_LoadSelectNumRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DecActive2_LoadMySelectedRet,this.PerformPacket_SC_DecActive2_LoadMySelectedRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DecActive2_LoadLotteryLogRet,this.PerformPacket_SC_DecActive2_LoadLotteryRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_JanActive1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_JanActive2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FebActive1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FebActive2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FebActive3_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BaseActive_LoadRankRetNew,this.PerformPacket_SC_LoadActiveRankRetNew);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MarchActive1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MarchActive2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MarchConsume_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_AprilActive1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_AprilActive2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CapsuleToys_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GoldDigger_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MayActive1_2015_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MayActive2_2015_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_PersiaTrader_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_AncientTreasure_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Cornucopia_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Cornucopia_LoadSelectNumRet,this.PerformPacket_SC_Cornucopia_LoadSelectNumRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Cornucopia_LoadLotteryLogRet,this.PerformPacket_SC_Cornucopia_LoadLotteryRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Cornucopia_LoadMySelectedRet,this.PerformPacket_SC_Cornucopia_LoadMySelectedRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GoldTree_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_AlchemyStudio_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GodWelfare_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_IdolumFight_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Bejeweled_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Exorcism_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaCrystal_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BossTreasure_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LoginGift_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DailyFirstRecharge_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MoonFestival1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MoonFestival2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NationDay1_2015_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NationDay2_2015_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NationDay3_2015_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_HallowmasActive1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_HallowmasActive2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_HallowmasActive3_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_HallowmasActive4_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_WanSheng_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Thanksgiving1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Thanksgiving2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Thanksgiving2_TreasuresRet,this.PerformPacket_SC_TreasuresRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Thanksgiving3_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Thanksgiving4_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_AccountLock_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Nov_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Christmas1_2015_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Christmas2_2015_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Christmas3_2015_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Christmas4_2015_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_JanActive1_2016_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_JanActive2_2016_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_JanActive3_2016_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SignGift_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FateRoulette_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_WanSheng2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Nov2016_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaFund_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CatWomen_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_WitchProving_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Christmas1_2016_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Christmas2_2016_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Christmas3_2016_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Christmas4_2016_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LotteryMachine_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CreationAncestor_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_WorldCup1_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_WorldCup2_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_WorldCup3_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NewSpring2018_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Double11Mall_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Smelt_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Smelt_BuyRet,this.PerformPacket_SC_SmeltBuyRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Smelt_SellRet,this.PerformPacket_SC_SmeltSellRet);
         super.PacketRegisterRoutines();
      }
      
      protected function GetWindowByIdentify(param1:int) : TProcessorBaseActivity
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         var _loc5_:Vector.<uint> = null;
         _loc5_ = CONST_BASEACTIVITY.ACTIVELIST_THIRD_TYPE;
         if(_loc5_.indexOf(param1) == -1)
         {
            _loc3_ = int(this.FProcessorBaseActivities.length);
            _loc2_ = 0;
            while(true)
            {
               if(_loc2_ < _loc3_)
               {
                  _loc4_ = this.FProcessorBaseActivities[_loc2_];
                  if(_loc4_.ActivityID == param1)
                  {
                     break;
                  }
                  _loc2_++;
                  continue;
               }
            }
            return _loc4_;
         }
         _loc3_ = int(this.FProcessorBaseActivitiesThird.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FProcessorBaseActivitiesThird[_loc2_];
            if(_loc4_.ActivityID == param1)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      protected function PerformPacket_SC_OpenActiveRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:TProcessorBaseActivity = null;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         _loc4_ = int(_loc2_.readUnsignedByte());
         _loc5_ = _loc4_ == 0 ? false : true;
         _loc6_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ <= CONST_SHORTCUTS.TYPE_NewActiveList_SeventhEvening)
         {
            return;
         }
         if(_loc3_ == CONST_SHORTCUTS.TYPE_NewActiveList_InviteFriend && SParametersCore.AgentID == CONST_PLATE.ID_PLATE_TR)
         {
            if(SParametersCore.IsFeedOpen != 1)
            {
               return;
            }
         }
         if(_loc3_ == CONST_SHORTCUTS.TYPE_NewActiveList_AccountLock)
         {
            return;
         }
         _loc8_ = CONST_BASEACTIVITY.ACTIVELIST_THIRD_TYPE;
         _loc9_ = _loc8_.indexOf(_loc3_);
         if(_loc9_ != -1)
         {
            SLogicsCore.ActivityThirdModes.SetActivityStatus(_loc3_,_loc5_);
         }
         else
         {
            SLogicsCore.NewActivityModes.SetActivityStatus(_loc3_,_loc5_);
         }
         _loc7_ = this.GetWindowByIdentify(_loc3_);
         if(_loc7_)
         {
            _loc7_.ProcessorOnOpenActive(_loc5_,_loc6_);
         }
      }
      
      protected function PerformPacket_SC_BuyBoxRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            _loc4_.ProcessorBuyBoxRet(param1);
         }
      }
      
      protected function PerformPacket_SC_GetRewardRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            _loc4_.ProcessorGetRewardRet(param1);
         }
      }
      
      protected function PerformPacket_SC_ChangeStatusRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc4_ = _loc2_.readUnsignedInt();
         this.ProcessorCheckEffect(_loc4_,true);
         _loc5_ = this.GetWindowByIdentify(_loc4_);
         if(_loc5_)
         {
            _loc5_.ProcessorChangeStatus(param1);
         }
      }
      
      protected function PerformPacket_SC_ChangeGoldRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = this.GetWindowByIdentify(_loc4_);
         if(_loc5_)
         {
            _loc5_.ProcessorChangeGold(param1);
         }
      }
      
      protected function PerformPacket_SC_LoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc3_ == -1)
         {
         }
         if(_loc4_)
         {
            _loc4_.ProcessorOnLoadInfoRet(param1);
         }
      }
      
      protected function PerformPacket_SC_LoadActiveRankRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            _loc4_.ProcessorLoadActiveRankRet(param1);
         }
      }
      
      protected function PerformPacket_SC_LoadActiveRankRetNew(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            _loc4_.ProcessorLoadActiveRankRetNew(param1);
         }
      }
      
      protected function PerformPacket_SC_LoadNewsRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            _loc4_.ProcessorOnLoadNewsRet(param1);
         }
      }
      
      protected function PerformPacket_SC_LoadExchangeItemRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            _loc4_.ProcessorOnLoadExchangeItemRet(param1);
         }
      }
      
      protected function PerformPacket_SC_TreasuresRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            _loc4_.ProcessorOnTreasuresInfoRet(param1);
         }
      }
      
      protected function PerformPacket_SC_RewardLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = int(CONST_BASEACTIVITY.TYPE_ActiveListThird_MayActive);
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            _loc4_.ProcessorOnRewardLogRet(param1);
         }
      }
      
      protected function PerformPacket_SC_ActivityThird_LoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            _loc4_.ProcessorActivityThirdLoadLogRet(param1);
         }
      }
      
      protected function PerformPacket_SC_AllActivityRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            _loc4_.ProcessorAllRet(param1);
         }
      }
      
      protected function PerformPacket_SC_LoadRankInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            _loc4_.ProcessorLoadRankRet(param1);
         }
      }
      
      protected function PerformPacket_SC_HappyTreasure_BuyAllBoxRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorHappyTreasure = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ == CONST_BASEACTIVITY.TYPE_NewActiveList_HappyTreasure)
         {
            _loc4_ = this.GetWindowByIdentify(_loc3_) as TProcessorHappyTreasure;
            _loc4_.ProcessorBuyAllRet(param1);
         }
      }
      
      protected function PerformPacket_SC_HappyTreasure_LoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorHappyTreasure = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ == CONST_BASEACTIVITY.TYPE_NewActiveList_HappyTreasure)
         {
            _loc4_ = this.GetWindowByIdentify(_loc3_) as TProcessorHappyTreasure;
            _loc4_.ProcessorLoadLogRet(param1);
         }
      }
      
      protected function PerformPacket_SC_GroupBuying_LoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorGroupBuying = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ == CONST_BASEACTIVITY.TYPE_NewActiveList_GroupBuying)
         {
            _loc4_ = this.GetWindowByIdentify(_loc3_) as TProcessorGroupBuying;
            _loc4_.ProcessorOnLoadInfoRet(param1);
         }
      }
      
      protected function PerformPacket_SC_RechargeExchange_LoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ == CONST_BASEACTIVITY.TYPE_NewActiveList_RechargeExchange)
         {
            _loc4_ = this.GetWindowByIdentify(_loc3_);
            if(_loc4_)
            {
               _loc4_.ProcessorOnLoadInfoRet(param1);
            }
         }
      }
      
      protected function PerformPacket_SC_OrangeEquipment_LoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ == CONST_BASEACTIVITY.TYPE_NewActiveList_OrangeEquipment)
         {
            _loc4_ = this.GetWindowByIdentify(_loc3_);
            if(_loc4_)
            {
               _loc4_.ProcessorOnLoadInfoRet(param1);
            }
         }
      }
      
      protected function PerformPacket_SC_OrangeEquipment_LoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            _loc4_.ProcessorLoadLogRet(param1);
         }
      }
      
      protected function PerformPacket_SC_SpringFestival_LoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            _loc4_.ProcessorLoadItemLogRet(param1);
         }
      }
      
      protected function PerformPacket_SC_MidAutumn_ExchangePetRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            _loc4_.ProcessorExchangePet(param1);
         }
      }
      
      protected function PerformPacket_SC_NationDay_GetStoneRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            _loc4_.ProcessorGetStone(param1);
         }
      }
      
      protected function PerformPacket_SC_NationDay_GetHeroRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            _loc4_.ProcessorExchangePet(param1);
         }
      }
      
      protected function PerformPacket_SC_BuyLvUpBoxRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            (_loc4_ as TProcessorNinjiaVillage).ProcessorOnBuyLvUpBoxRet(param1);
         }
      }
      
      protected function PerformPacket_SC_Hallowmas_OtherRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            (_loc4_ as TProcessorHallowmas).ProcessorOtherRet(param1);
         }
      }
      
      protected function PerformPacket_SC_CDKActiveRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            _loc4_.ProcessorOnCDKActiveRet(param1);
         }
      }
      
      protected function PerformPacket_SC_ActivityTask_LoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            _loc4_.ProcessorOnLoadTaskInfoRet(param1);
         }
      }
      
      protected function ProcessorCheckEffect(param1:uint, param2:Boolean) : void
      {
         var _loc3_:Vector.<uint> = null;
         var _loc4_:int = 0;
         _loc3_ = CONST_BASEACTIVITY.ACTIVELIST_THIRD_TYPE;
         _loc4_ = _loc3_.indexOf(param1);
         if(this.FCheckEffect != null)
         {
            if(_loc4_ != -1)
            {
               this.FCheckEffect(CONST_SHORTCUTS.POSITION_ActiveListThird,param1,param2);
            }
            else
            {
               this.FCheckEffect(CONST_SHORTCUTS.POSITION_NewActiveList,param1,param2);
            }
         }
      }
      
      protected function ProcessorsWindowsClose(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc3_ = int(this.FProcessorBaseActivitiesThird.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FProcessorBaseActivitiesThird[_loc2_];
            _loc4_.Unmount();
            _loc4_.visible = false;
            _loc2_++;
         }
         _loc3_ = int(this.FProcessorBaseActivities.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FProcessorBaseActivities[_loc2_];
            _loc4_.Unmount();
            _loc4_.visible = false;
            _loc2_++;
         }
         if(FOnClose != null)
         {
            FOnClose(param1);
         }
      }
      
      protected function ProcessorShowHeroInfor(param1:uint, param2:uint) : void
      {
         if(this.FOnShowHeroInfo != null)
         {
            this.FOnShowHeroInfo(this,param1,param2);
         }
      }
      
      protected function ProcessorOnAddTitle(param1:uint) : void
      {
         if(this.FOnAddTitle != null)
         {
            this.FOnAddTitle(param1);
         }
      }
      
      public function ProcessorOnGoto(param1:uint) : void
      {
         if(this.FOnGoto != null)
         {
            this.FOnGoto(this,param1);
         }
      }
      
      protected function ProcessorOpenNewActivityList(param1:int) : void
      {
         var _loc2_:Vector.<uint> = null;
         var _loc3_:int = 0;
         _loc2_ = CONST_BASEACTIVITY.ACTIVELIST_THIRD_TYPE;
         _loc3_ = _loc2_.indexOf(param1);
         if(_loc3_ != -1)
         {
            if(this.FOnOpenThirdActivity != null)
            {
               this.FOnOpenThirdActivity();
            }
         }
         else if(this.FOnOpenActivity != null)
         {
            this.FOnOpenActivity();
         }
      }
      
      protected function ProcessorEffectText(param1:Object, param2:String, param3:TEffectTextParameters = null, param4:TEffectCoordinateParameters = null, param5:uint = 5) : void
      {
         if(FOnEffectText != null)
         {
            FOnEffectText(param1,param2,param3,param4,param5);
         }
      }
      
      protected function ProcessorDialogMsg(param1:Object, param2:String) : void
      {
         if(FOnDialogMsg != null)
         {
            FOnDialogMsg(param1,param2);
         }
      }
      
      protected function PerformPacket_SC_DecActive2_LoadSelectNumRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            (_loc4_ as TProcessorDecActive).ProcessorLoadSelectNumRet(param1);
         }
      }
      
      protected function PerformPacket_SC_DecActive2_LoadMySelectedRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            (_loc4_ as TProcessorDecActive).ProcessorLoadMySelectedRet(param1);
         }
      }
      
      protected function PerformPacket_SC_DecActive2_LoadLotteryRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            (_loc4_ as TProcessorDecActive).ProcessorLoadLotteryLogRet(param1);
         }
      }
      
      protected function PerformPacket_SC_Cornucopia_LoadSelectNumRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            (_loc4_ as TProcessorCornucopia).ProcessorLoadSelectNumRet(param1);
         }
      }
      
      protected function PerformPacket_SC_Cornucopia_LoadMySelectedRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            (_loc4_ as TProcessorCornucopia).ProcessorLoadMySelectedRet(param1);
         }
      }
      
      protected function PerformPacket_SC_Cornucopia_LoadLotteryRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TProcessorBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = this.GetWindowByIdentify(_loc3_);
         if(_loc4_)
         {
            (_loc4_ as TProcessorCornucopia).ProcessorLoadLotteryLogRet(param1);
         }
      }
      
      protected function PerformPacket_SC_SmeltSellRet(param1:TPacket = null) : void
      {
         var _loc2_:TProcessorBaseActivity = null;
         _loc2_ = this.GetWindowByIdentify(CONST_BASEACTIVITY.TYPE_ActiveListThird_Smelt);
         if(_loc2_)
         {
            (_loc2_ as TProcessorSmelt).ProcessorOnSellRet(param1);
         }
      }
      
      protected function PerformPacket_SC_SmeltBuyRet(param1:TPacket = null) : void
      {
         var _loc2_:TProcessorBaseActivity = null;
         _loc2_ = this.GetWindowByIdentify(CONST_BASEACTIVITY.TYPE_ActiveListThird_Smelt);
         if(_loc2_)
         {
            (_loc2_ as TProcessorSmelt).ProcessorOnBuyRet(param1);
         }
      }
      
      public function get OnOpenActivity() : Function
      {
         return this.FOnOpenActivity;
      }
      
      public function set OnOpenActivity(param1:Function) : void
      {
         this.FOnOpenActivity = param1;
      }
      
      public function get CheckEffect() : Function
      {
         return this.FCheckEffect;
      }
      
      public function set CheckEffect(param1:Function) : void
      {
         this.FCheckEffect = param1;
      }
      
      public function get OnShowHeroInfo() : Function
      {
         return this.FOnShowHeroInfo;
      }
      
      public function set OnShowHeroInfo(param1:Function) : void
      {
         this.FOnShowHeroInfo = param1;
      }
      
      public function get OnAddTitle() : Function
      {
         return this.FOnAddTitle;
      }
      
      public function set OnAddTitle(param1:Function) : void
      {
         this.FOnAddTitle = param1;
      }
      
      public function get OnOpenThirdActivity() : Function
      {
         return this.FOnOpenThirdActivity;
      }
      
      public function set OnOpenThirdActivity(param1:Function) : void
      {
         this.FOnOpenThirdActivity = param1;
      }
      
      public function get OnGoto() : Function
      {
         return this.FOnGoto;
      }
      
      public function set OnGoto(param1:Function) : void
      {
         this.FOnGoto = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TProcessorBaseActivity = null;
         super.Mount();
         if(param1 != null)
         {
            this.FActivityID = param1.readUnsignedInt();
         }
         _loc3_ = this.GetWindowByIdentify(this.FActivityID);
         if(_loc3_ != null)
         {
            _loc3_.Mount();
         }
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
   }
}

