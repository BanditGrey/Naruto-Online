package Processors.Game.Lobby.Recharge
{
   import Components.ScrollBar.TScrollBar;
   import Components.Slots.TUISlot;
   import Components.Standard.TUITab;
   import Externals.SExternalCore;
   import Foundation.Common.THint;
   import Foundation.Container.THashMap;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.ActivityMode.TActivityAtom;
   import Logics.ActivityMode.TActivityAtoms;
   import Logics.DatebaseVO.VO.TActiveList;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Signals.TSignal;
   import Processors.Game.Battle.Character.TActive;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Recharge.Components.TUIDailyConsumeItem;
   import Processors.Game.Lobby.Recharge.Components.TUIRechageRankingItem;
   import Processors.Game.Lobby.Recharge.Components.TUIRewardItem;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_ACTIVITY_MODE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_COUNTER;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_FIRSTRECHAGE;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_RECHARGE;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SIGNAL;
   import Resources.Strings.STRING_ACTIVITYINNER;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_RECHARGE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowRecharge extends TProcessorLobbyWindow
   {
      
      protected static const Capacity_Slots:uint = 4;
      
      protected static const HEIGHT_UIRewardItem:uint = 70;
      
      protected static const DAILY_FUNDS_COUNT:uint = 30;
      
      public static const SIGNALDESTINATION_ACTIVE_Recharge_Ret:uint = CONST_SIGNAL.SIGNALDESTINATION_ACTIVE_Recharge_Ret;
      
      public static const SIGNALDESTINATION_COUNTER_MilitaryOrdersLimit_Ret:uint = CONST_SIGNAL.SIGNALDESTINATION_COUNTER_MilitaryOrdersLimit_Ret;
      
      public static const SIGNALDESTINATION_COUNTER_MakeRamen_Ret:uint = CONST_SIGNAL.SIGNALDESTINATION_COUNTER_MakeRamen_Ret;
      
      public static const KEY_COUNTER_MilitaryOrdersLimit:uint = CONST_COUNTER.KEY_COUNTER_MilitaryOrdersLimit;
      
      public static const KEY_MAKE_RAMEN:uint = CONST_COUNTER.KEY_MAKE_RAMEN;
      
      public static const KEY_Activity_FlockRecharge:uint = CONST_ACTIVITY_MODE.Activity_FlockRecharge;
      
      public static const KEY_Activity_OnePay:uint = CONST_ACTIVITY_MODE.Activity_OnePay;
      
      public static const KEY_Activity_VIPBox:uint = CONST_ACTIVITY_MODE.Activity_VIPBox;
      
      public static const KEY_Activity_EreryDayRecharge:uint = CONST_ACTIVITY_MODE.Activity_EreryDayRecharge;
      
      public static const KEY_Activity_AddConsume:uint = CONST_ACTIVITY_MODE.Activity_AddConsume;
      
      public static const KEY_Activity_DailyConsume:uint = CONST_ACTIVITY_MODE.Activity_DailyConsume;
      
      public static const KEY_Recharge:uint = CONST_COUNTER.KEY_Recharge;
      
      public static const KEY_AddConsume:uint = CONST_COUNTER.KEY_AddConsume;
      
      public static const KEY_Activity_InvestmentFunds:uint = CONST_ACTIVITY_MODE.Activity_InvestmentFunds;
      
      public static const KEY_Activity_RechageRanking:uint = CONST_ACTIVITY_MODE.Activity_RechageRanking;
      
      protected static const KEY_Activity_Vector:Vector.<uint> = Vector.<uint>([KEY_Activity_FlockRecharge,KEY_Activity_OnePay,KEY_Activity_VIPBox,KEY_Activity_EreryDayRecharge,KEY_Activity_AddConsume,KEY_Activity_DailyConsume,KEY_Activity_InvestmentFunds,KEY_Activity_RechageRanking]);
      
      protected static const Frame_Activity_Vector:Vector.<String> = Vector.<String>([CONST_RECHARGE.Frame_FlockRecharge,CONST_RECHARGE.Frame_OnePay,CONST_RECHARGE.Frame_VIPBox,CONST_RECHARGE.Frame_DailyRecharge,CONST_RECHARGE.Frame_AddConsume,CONST_RECHARGE.Frame_DailyConsume,CONST_RECHARGE.Frame_InvestmentFunds,CONST_RECHARGE.Frame_RechageRanking]);
      
      protected static const String_Activity_Vector:Vector.<String> = Vector.<String>([STRING_RECHARGE.STRING_BuyActionTimes,STRING_RECHARGE.STRING_GotoRamen]);
      
      protected static const INVESTMENTFUNDS_IDENTIFY:Vector.<uint> = Vector.<uint>([423001,423002]);
      
      protected var FMainUI:Sprite;
      
      protected var FUITab:TUITab;
      
      protected var FBtn_Left:SimpleButton;
      
      protected var FBtn_Right:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FMC_Tittle:MovieClip;
      
      protected var FTF_Tittle:TextField;
      
      protected var FMC_Background:MovieClip;
      
      protected var FMC_Detail:MovieClip;
      
      protected var FMC_Text:MovieClip;
      
      protected var FTF_Date:TextField;
      
      protected var FTF_Detail:TextField;
      
      protected var FTF_Time:TextField;
      
      protected var FBTN_Recharge:SimpleButton;
      
      protected var FMC_Reward:Sprite;
      
      protected var FMC_Top:Sprite;
      
      protected var FTF_RechargeType:TextField;
      
      protected var FMC_AddGold:MovieClip;
      
      protected var FMC_VIPGold:MovieClip;
      
      protected var FTF_AddGold:TextField;
      
      protected var FTF_VIPLevel:TextField;
      
      protected var FTF_NextVIPLevel:TextField;
      
      protected var FMC_Bottom:Sprite;
      
      protected var FMC_HasRecieved:Sprite;
      
      protected var FMC_CostGold:Sprite;
      
      protected var FTF_CostGold:TextField;
      
      protected var FMC_DailyRecharge:Sprite;
      
      protected var FBTN_DailyGetReward:MovieClip;
      
      protected var FMC_List:MovieClip;
      
      protected var FMC_DailyConsume:Sprite;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FDailySlotList:Vector.<TUISlot>;
      
      protected var FTabIndex:int;
      
      protected var FPageIndex:int;
      
      protected var FMC_InvestmentFunds:Sprite;
      
      protected var FBTN_DailyFunds:MovieClip;
      
      protected var FBTN_LevelFunds:MovieClip;
      
      protected var FMC_InvestConfirmation:MovieClip;
      
      protected var FInvestSlotList:Vector.<TUISlot>;
      
      protected var FMC_RechageRanking:Sprite;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FLookInfo:MovieClip;
      
      protected var FTF_MyRanking:TextField;
      
      protected var FTF_MyPay:TextField;
      
      protected var FMC_NoRank:MovieClip;
      
      protected var FMC_RechageRankList:MovieClip;
      
      protected var FMC_Hero:MovieClip;
      
      protected var FMyRank:uint;
      
      protected var FMyPay:uint;
      
      protected var FRechageRankLsit:Vector.<TUIRechageRankingItem>;
      
      protected var FHeroID:int;
      
      protected var FUIHero:TActive;
      
      protected var FScrollRechageRankBar:TScrollBar;
      
      protected var FRewardList:Vector.<TUIRewardItem>;
      
      protected var FInitialized:Boolean;
      
      protected var FActivityAtomsList:Vector.<TActivityAtoms>;
      
      protected var FFilterRechargeAtomsList:Vector.<TActivityAtoms>;
      
      protected var FActivityAtoms:TActivityAtoms;
      
      protected var FActivityAtom:TActivityAtom;
      
      protected var FActiveHashMap:THashMap;
      
      protected var FRechargeValue:uint;
      
      protected var FCounterMilitaryOrdersLimit:uint;
      
      protected var FCounterMakeRamenLimit:uint;
      
      protected var FCounterGoldConsumeLimit:uint;
      
      protected var FDailyConsumelist:Vector.<TUIDailyConsumeItem>;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FFuctionList:Vector.<Function>;
      
      protected var FHint:THint;
      
      protected var FMadkSp:Sprite;
      
      protected var FModuleId:uint;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FOnNewRechargeGift:Function;
      
      protected var FOnBuyActionTimes:Function;
      
      protected var FOnGotoRamen:Function;
      
      protected var FOnHintOver:Function;
      
      protected var FOnHintOut:Function;
      
      protected var FInforArray:Array;
      
      public function TProcessorWindowRecharge(param1:TUIComponent, param2:uint)
      {
         super(param1);
         this.FModuleId = param2;
         this.FUITab = new TUITab(this);
         this.FUITab.FilterColor = 16776960;
         this.FDailySlotList = new Vector.<TUISlot>(Capacity_Slots);
         this.FRewardList = new Vector.<TUIRewardItem>();
         this.FPageIndex = 0;
         this.FInitialized = false;
         this.FActivityAtomsList = new Vector.<TActivityAtoms>();
         this.FFilterRechargeAtomsList = new Vector.<TActivityAtoms>();
         this.FDailyConsumelist = new Vector.<TUIDailyConsumeItem>(2);
         this.FFuctionList = new Vector.<Function>();
         this.FInvestSlotList = new Vector.<TUISlot>(2);
         this.FActiveHashMap = new THashMap();
         this.FHint = new THint();
         this.FInforArray = new Array();
         this.FRechageRankLsit = new Vector.<TUIRechageRankingItem>();
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = this.ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = this.ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_RECHARGE.RESOURCESID_Swf_Recharge);
         this.FProcessorWindowRecruit.Load();
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:Sprite = null;
         var _loc4_:TUISlot = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TUIDailyConsumeItem = null;
         var _loc7_:TConfigValue = null;
         var _loc8_:Vector.<Object> = null;
         var _loc9_:String = null;
         this.FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_RECHARGE.RESOURCE_ClassName_MC_Recharge) as Sprite;
         addChild(this.FMainUI);
         _loc3_ = this.FMainUI[CONST_RECHARGE.RESOURCE_Link_MC_UIRecharge];
         this.FMC_Tittle = _loc3_[CONST_RECHARGE.RESOURCE_Link_MC_Tittle];
         this.FTF_Tittle = this.FMC_Tittle[CONST_RECHARGE.RESOURCE_Link_TF_Tittle];
         this.FMC_Background = this.FMC_Tittle[CONST_RECHARGE.RESOURCE_Link_MC_Background];
         this.FBtn_Left = this.FMainUI[CONST_RECHARGE.RESOURCE_Link_Btn_Left];
         this.FBtn_Right = this.FMainUI[CONST_RECHARGE.RESOURCE_Link_Btn_Right];
         this.FBTN_Close = this.FMainUI[CONST_RECHARGE.RESOURCE_LINK_BTN_Close];
         this.FBTN_Help = this.FMainUI[CONST_RECHARGE.RESOURCE_LINK_BTN_Help];
         this.FMC_Detail = _loc3_[CONST_RECHARGE.RESOURCE_Link_MC_Detail];
         this.FMC_Text = this.FMC_Detail[CONST_RECHARGE.RESOURCE_Link_MC_Text];
         this.FTF_Date = this.FMC_Text[CONST_RECHARGE.RESOURCE_Link_TF_Date];
         this.FTF_Detail = this.FMC_Text[CONST_RECHARGE.RESOURCE_Link_TF_Detail];
         this.FTF_Time = this.FMC_Text[CONST_RECHARGE.RESOURCE_Link_TF_Time];
         this.FBTN_Recharge = this.FMC_Text[CONST_RECHARGE.RESOURCE_Link_BTN_Recharge];
         this.FMC_Reward = this.FMC_Detail[CONST_RECHARGE.RESOURCE_Link_MC_Reward];
         this.FMC_Top = this.FMC_Reward[CONST_RECHARGE.RESOURCE_Link_MC_Top];
         this.FTF_RechargeType = this.FMC_Top[CONST_RECHARGE.RESOURCE_Link_TF_RechargeType];
         this.FMC_AddGold = this.FMC_Top[CONST_RECHARGE.RESOURCE_Link_MC_AddGold];
         this.FTF_AddGold = this.FMC_AddGold[CONST_RECHARGE.RESOURCE_Link_TF_AddGold];
         this.FMC_VIPGold = this.FMC_Top[CONST_RECHARGE.RESOURCE_Link_MC_VIPGold];
         this.FTF_VIPLevel = this.FMC_VIPGold[CONST_RECHARGE.RESOURCE_Link_TF_VIPLevel];
         this.FTF_NextVIPLevel = this.FMC_VIPGold[CONST_RECHARGE.RESOURCE_Link_TF_NextVIPLevel];
         this.FMC_Bottom = this.FMC_Reward[CONST_RECHARGE.RESOURCE_Link_MC_Bottom];
         this.FMC_CostGold = this.FMC_Top[CONST_RECHARGE.RESOURCE_Link_MC_CostGold];
         this.FTF_CostGold = this.FMC_CostGold[CONST_RECHARGE.RESOURCE_Link_TF_CostGold];
         this.FMC_DailyRecharge = this.FMC_Detail[CONST_RECHARGE.RESOURCE_Link_MC_DailyRecharge];
         this.FBTN_DailyGetReward = this.FMC_DailyRecharge[CONST_RECHARGE.RESOURCE_Link_BTN_GetReward];
         this.FMC_HasRecieved = this.FMC_DailyRecharge[CONST_RECHARGE.RESOURCE_Link_MC_HasRecieved] as Sprite;
         TGameUtil.setButtonMode(this.FBTN_DailyGetReward,true);
         _loc2_ = Capacity_Slots;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = new TUISlot(this);
            _loc4_.Resource = this.FMC_DailyRecharge[CONST_RECHARGE.RESOURCE_Link_MC_Slot + _loc1_] as Sprite;
            _loc4_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc4_.Tag = _loc1_;
            _loc4_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc4_.OnOverlay = this.SlotsOnMove;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc4_.Init();
            this.FDailySlotList[_loc1_] = _loc4_;
            _loc1_++;
         }
         _loc2_ = CONST_RECHARGE.CAPACITY_MC_Tabs;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = this.FMainUI[CONST_RECHARGE.RESOURCE_Link_MC_Tabs + _loc1_];
            this.FUITab.SetTabByIndex(_loc5_,_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FMC_List = this.FMC_Detail[CONST_RECHARGE.RESOURCE_Link_MC_List];
         this.FMC_DailyConsume = this.FMC_Detail[CONST_RECHARGE.RESOURCE_Link_MC_DailyConsume];
         this.FFuctionList.push(this.FOnBuyActionTimes);
         this.FFuctionList.push(this.FOnGotoRamen);
         _loc2_ = this.FDailyConsumelist.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = new TUIDailyConsumeItem(this);
            _loc6_.Resource = this.FMC_DailyConsume[CONST_RECHARGE.RESOURCE_Link_MC_DailyConsume_ + _loc1_];
            _loc6_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc6_.OnOverlay = this.SlotsOnMove;
            _loc6_.OnOut = this.SlotsOnOut;
            _loc6_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc6_.OnGoto = this.FFuctionList[_loc1_];
            _loc6_.OnGetReward = this.ProcessorOnGetReward;
            _loc6_.Init();
            this.FDailyConsumelist[_loc1_] = _loc6_;
            _loc1_++;
         }
         this.FScrollBar = new TScrollBar(this.FMC_List,350,false,0,35);
         this.FMC_InvestmentFunds = this.FMC_Detail["MC_InvestmentFunds"];
         this.FBTN_DailyFunds = this.FMC_InvestmentFunds["BTN_Buy0"];
         this.FBTN_LevelFunds = this.FMC_InvestmentFunds["BTN_Buy1"];
         this.FBTN_DailyFunds.addEventListener(MouseEvent.CLICK,this.ButtonDailyFundsOnClick);
         this.FBTN_LevelFunds.addEventListener(MouseEvent.CLICK,this.ButtonLevelFundsOnClick);
         this.FBTN_DailyFunds.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonDailyFundsOnMove);
         this.FBTN_DailyFunds.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonDailyFundsOnOut);
         this.FBTN_LevelFunds.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonLevelFundsOnMove);
         this.FBTN_LevelFunds.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonLevelFundsOnOut);
         this.FMC_InvestConfirmation = TUtilityReflection.CreateDisplayObjectInstance(CONST_FIRSTRECHAGE.RESOURCE_Link_MC_InvestConfirmation) as MovieClip;
         addChild(this.FMC_InvestConfirmation);
         this.FMC_InvestConfirmation.x = this.width - this.FMC_InvestConfirmation.width >> 1;
         this.FMC_InvestConfirmation.y = this.height - this.FMC_InvestConfirmation.height >> 1;
         this.FMC_InvestConfirmation.visible = false;
         TGameUtil.setButtonMode(this.FMC_InvestConfirmation["Btn_Ok"],true);
         TGameUtil.setButtonMode(this.FMC_InvestConfirmation["Btn_Cancel"],true);
         _loc4_ = new TUISlot(this);
         _loc4_.Resource = this.FMC_InvestConfirmation["MC_Slot_0"] as Sprite;
         _loc4_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         _loc4_.Tag = _loc1_;
         _loc4_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         _loc4_.OnOverlay = this.SlotsOnMove;
         _loc4_.OnOut = this.SlotsOnOut;
         _loc4_.OnQuerySubscript = this.SlotsOnQuerySubscript;
         _loc4_.Init();
         this.FInvestSlotList[0] = _loc4_;
         this.FMC_RechageRanking = this.FMC_Detail[CONST_RECHARGE.RESOURCE_Link_MC_RechargeRank];
         this.FLookInfo = this.FMC_RechageRanking["BTN_Detail"];
         this.FTF_MyRanking = this.FMC_RechageRanking["MC_Info"]["TF_Rank"];
         this.FTF_MyPay = this.FMC_RechageRanking["MC_Info"]["TF_Pay"];
         this.FMC_NoRank = this.FMC_RechageRanking["MC_Info"]["MC_NoRank"];
         this.FMC_RechageRankList = this.FMC_RechageRanking["mc_list"];
         this.FMC_Hero = this.FMC_RechageRanking["MC_Hero"];
         this.FLookInfo.buttonMode = true;
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60380006) as TConfigValue;
         _loc8_ = _loc7_.Value as Vector.<Object>;
         this.FHeroID = parseInt(_loc8_[0] as String);
         this.FScrollRechageRankBar = new TScrollBar(this.FMC_RechageRankList,172,false,0,66);
         this.FOverlayerHint = new TOverlayerHint(this.Parent);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         this.FInitialized = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TActiveList = null;
         this.FBtn_Left.addEventListener(MouseEvent.CLICK,this.ButtonLeftOnClick,false,0,true);
         this.FBtn_Right.addEventListener(MouseEvent.CLICK,this.ButtonRightOnClick,false,0,true);
         this.FBTN_DailyGetReward.addEventListener(MouseEvent.CLICK,this.ButtonGetDailyRewardOnClick,false,0,true);
         this.FBTN_Recharge.addEventListener(MouseEvent.CLICK,this.ButtonRechargeOnClick,false,0,true);
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick,false,0,true);
         this.FMC_InvestConfirmation.Btn_Ok.addEventListener(MouseEvent.CLICK,this.ButtonInvestOkOnClick,false,0,true);
         this.FMC_InvestConfirmation.Btn_Cancel.addEventListener(MouseEvent.CLICK,this.ButtonInvestCancelOnClick,false,0,true);
         this.FLookInfo.addEventListener(MouseEvent.CLICK,this.ButtonLookInfoOnClick,false,0,true);
         this.FMC_Hero.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHeroOnMove,false,0,true);
         this.FMC_Hero.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHeroOnOut,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      private function ButtonHeroOnMove(param1:MouseEvent) : void
      {
         var _loc2_:THint = null;
         var _loc3_:TBaseHero = null;
         _loc2_ = new THint();
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.FHeroID) as TBaseHero;
         _loc2_.Caption = _loc3_.Desc;
         this.FOverlayerHint.Context = _loc2_;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      private function ButtonHeroOnOut(param1:MouseEvent) : void
      {
         this.FOverlayerHint.Hide();
      }
      
      private function ButtonLookInfoOnClick(param1:MouseEvent) : void
      {
         this.ProcessorOnShowRecruit(this.FHeroID);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:uint = 0;
         this.LogicsPerform_Signals();
         if(this.Visible)
         {
            this.LogicsPerform_RechargeSignals();
            if(this.FInitialized)
            {
               _loc2_ = this.FRewardList.length;
               _loc1_ = 0;
               while(_loc1_ < _loc2_)
               {
                  this.FRewardList[_loc1_].UpdateSlot();
                  _loc1_++;
               }
               _loc2_ = this.FDailySlotList.length;
               _loc1_ = 0;
               while(_loc1_ < _loc2_)
               {
                  this.FDailySlotList[_loc1_].Update();
                  _loc1_++;
               }
               _loc2_ = this.FDailyConsumelist.length;
               _loc1_ = 0;
               while(_loc1_ < _loc2_)
               {
                  this.FDailyConsumelist[_loc1_].UpdateSlot();
                  _loc1_++;
               }
               _loc2_ = this.FRechageRankLsit.length;
               _loc1_ = 0;
               while(_loc1_ < _loc2_)
               {
                  this.FRechageRankLsit[_loc1_].UpdateSlot();
                  _loc1_++;
               }
               this.FInvestSlotList[0].Update();
            }
            if(this.FUITab != null)
            {
               this.FUITab.Update();
            }
            if(this.FActivityAtoms != null && this.FTF_Time != null)
            {
               _loc4_ = this.FActivityAtoms.EndTime - STimingCore.GetServerTick();
               this.FTF_Time.text = TGameUtil.fomatTime(_loc4_);
               if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
               {
                  this.FProcessorWindowRecruit.UpdataBitmap();
               }
            }
         }
         super.LogicsPerform();
      }
      
      protected function LogicsPerform_Signals() : void
      {
         var _loc1_:TSignal = null;
         var _loc2_:uint = 0;
         var _loc3_:TActivityAtoms = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         _loc1_ = SLogicsCore.SignalRetrieve(SIGNALDESTINATION_ACTIVE_Recharge_Ret);
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = _loc1_.Identifier;
         _loc3_ = _loc1_.UserData as TActivityAtoms;
         this.PlayEffectRecharge(_loc3_);
         this.FActiveHashMap.Put(_loc2_,_loc3_);
         this.Update();
      }
      
      protected function LogicsPerform_RechargeSignals() : void
      {
         var _loc1_:TSignal = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc1_ = SLogicsCore.SignalRetrieve(CONST_SIGNAL.SIGNALDESTINATION_ACTIVE_RechargeDetail_Ret);
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = _loc1_.Identifier;
         _loc3_ = uint(_loc1_.Value);
         switch(_loc2_)
         {
            case KEY_Recharge:
               this.FRechargeValue = _loc3_;
               break;
            case KEY_COUNTER_MilitaryOrdersLimit:
               this.FCounterMilitaryOrdersLimit = _loc3_;
               break;
            case KEY_MAKE_RAMEN:
               this.FCounterMakeRamenLimit = _loc3_;
               break;
            case KEY_AddConsume:
               this.FCounterGoldConsumeLimit = _loc3_;
         }
         this.Update();
      }
      
      protected function PlayEffectRecharge(param1:TActivityAtoms) : void
      {
         if(this.FOnNewRechargeGift != null)
         {
            this.FOnNewRechargeGift(CONST_SHORTCUTS.POSITION_ActiveList,CONST_SHORTCUTS.TYPE_ActiveList_Recharge,this.CheckHasGet());
         }
      }
      
      protected function CheckHasGet() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TActivityAtoms = null;
         var _loc6_:TActivityAtom = null;
         _loc3_ = int(KEY_Activity_Vector.length);
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc5_ = this.FActiveHashMap.Get(KEY_Activity_Vector[_loc1_]) as TActivityAtoms;
            if(_loc5_)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc5_.Count)
               {
                  _loc6_ = _loc5_.GetActivityAtomByIndex(_loc2_);
                  if(_loc6_.ActiveStatus > 0)
                  {
                     return true;
                  }
                  _loc2_++;
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      protected function UpdateUITab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc3_ = CONST_RECHARGE.CAPACITY_MC_Tabs;
         _loc4_ = this.FFilterRechargeAtomsList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = _loc1_ + this.FPageIndex * _loc3_;
            if(_loc4_ <= _loc2_)
            {
               this.FUITab.SetTabHideByIndex(_loc1_);
            }
            else
            {
               this.FUITab.SetTabShowByIndex(_loc1_);
               this.FUITab.SetTabCaptionByIndex(this.FFilterRechargeAtomsList[_loc2_].LeftCaption,_loc1_);
            }
            _loc1_++;
         }
      }
      
      protected function UpdatePageInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc3_ = CONST_RECHARGE.CAPACITY_MC_Tabs;
         _loc4_ = this.FFilterRechargeAtomsList.length;
         if(this.FPageIndex == 0)
         {
            this.FBtn_Left.visible = false;
            this.FBtn_Right.visible = false;
         }
         else if(this.FPageIndex == uint(_loc4_ / _loc3_))
         {
            this.FBtn_Left.visible = true;
            this.FBtn_Right.visible = false;
         }
         else
         {
            this.FBtn_Left.visible = true;
            this.FBtn_Right.visible = true;
         }
      }
      
      protected function UpdateRechargeText(param1:TActivityAtoms) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         this.FTF_Tittle.text = param1.RightCaption;
         _loc3_ = KEY_Activity_Vector.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(param1.Identifier == KEY_Activity_Vector[_loc2_])
            {
               this.FMC_Background.gotoAndStop(Frame_Activity_Vector[_loc2_]);
            }
            _loc2_++;
         }
         this.FTF_Date.text = TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(param1.StartTime) * 1000)) + "~" + TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(param1.EndTime - 1) * 1000));
         this.FTF_Detail.text = param1.Desc;
      }
      
      protected function UpdateDailyRecharge(param1:TActivityAtoms) : void
      {
         var _loc2_:int = 0;
         this.FScrollBar.Clear();
         _loc2_ = param1.GetActivityAtomByIndex(0).ActiveStatus;
         this.FActivityAtoms = param1;
         if(_loc2_ > 0)
         {
            TGameUtil.setButtonMode(this.FBTN_DailyGetReward,true);
            this.FBTN_DailyGetReward.mouseEnabled = true;
            this.FBTN_DailyGetReward.visible = true;
            this.FMC_HasRecieved.visible = false;
         }
         else if(_loc2_ == 0)
         {
            TGameUtil.setButtonMode(this.FBTN_DailyGetReward,false);
            this.FBTN_DailyGetReward.mouseEnabled = false;
            this.FBTN_DailyGetReward.visible = true;
            this.FMC_HasRecieved.visible = false;
         }
         else
         {
            TGameUtil.setButtonMode(this.FBTN_DailyGetReward,false);
            this.FBTN_DailyGetReward.mouseEnabled = false;
            this.FBTN_DailyGetReward.visible = false;
            this.FMC_HasRecieved.visible = true;
         }
         this.FMC_Detail.addChild(this.FMC_Text);
         this.FMC_Reward.visible = false;
         this.FMC_DailyRecharge.visible = true;
         this.FMC_DailyConsume.visible = false;
         this.FMC_InvestmentFunds.visible = false;
         this.FMC_RechageRanking.visible = false;
         this.UpdateDailySlots(param1);
      }
      
      protected function UpdateMCRecharge(param1:TActivityAtoms) : void
      {
         if(this.FActivityAtoms != null && this.FActivityAtoms.Identifier == param1.Identifier)
         {
            this.UpdateUpdateRewardItemInfo(param1);
            return;
         }
         this.FActivityAtoms = param1;
         this.FScrollBar.Clear();
         this.FMC_Reward.visible = true;
         this.FMC_DailyRecharge.visible = false;
         this.FMC_DailyConsume.visible = false;
         this.FMC_InvestmentFunds.visible = false;
         this.FMC_RechageRanking.visible = false;
         this.UpdateMCReward(param1);
         this.UpdateRewardItem(param1);
         this.FScrollBar.AddItem(this.FMC_Text);
         this.FScrollBar.AddItem(this.FMC_Reward);
         this.FScrollBar.Visible = true;
      }
      
      protected function UpdateInvestmentFunds(param1:TActivityAtoms) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TActivityAtom = null;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         this.FScrollBar.Clear();
         this.FActivityAtoms = param1;
         this.FMC_Reward.visible = false;
         this.FMC_DailyRecharge.visible = false;
         this.FMC_DailyConsume.visible = false;
         this.FMC_InvestmentFunds.visible = true;
         _loc4_ = this.FActivityAtoms.GetActivityAtomByIdentifier(INVESTMENTFUNDS_IDENTIFY[0]);
         _loc5_ = _loc4_.ActiveStatus;
         if(_loc5_ == -1)
         {
            TGameUtil.setButtonMode(this.FBTN_DailyFunds,false);
         }
         else if(_loc5_ == 0)
         {
            TGameUtil.setButtonMode(this.FBTN_DailyFunds,true);
         }
         _loc4_ = this.FActivityAtoms.GetActivityAtomByIdentifier(INVESTMENTFUNDS_IDENTIFY[1]);
         _loc5_ = _loc4_.ActiveStatus;
         if(_loc5_ == -1)
         {
            TGameUtil.setButtonMode(this.FBTN_LevelFunds,false);
            this.FMC_InvestConfirmation.visible = false;
         }
         else if(_loc5_ == 0)
         {
            TGameUtil.setButtonMode(this.FBTN_LevelFunds,true);
            this.FBTN_LevelFunds.mouseEnabled = true;
         }
         this.FScrollBar.AddItem(this.FMC_Text);
         this.FScrollBar.AddItem(this.FMC_InvestmentFunds);
         this.FScrollBar.Visible = true;
         this.UpdateInvestInventories(_loc4_.InventoriesVect);
      }
      
      protected function UpdateRewardItem(param1:TActivityAtoms) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TUIRewardItem = null;
         _loc3_ = this.FRewardList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FRewardList[_loc2_];
            this.FMC_Reward.removeChild(_loc4_);
            _loc4_.StubReferences.Dereference(this);
            _loc2_++;
         }
         this.FRewardList.length = 0;
         SLogicsCore.PoolUIRewardItem.Update();
         _loc3_ = uint(param1.OpenCount);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = SLogicsCore.PoolUIRewardItem.AcquireUIRewardItem(this);
            _loc4_.StubReferences.Reference(this);
            _loc4_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc4_.OnOverlay = this.SlotsOnMove;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc4_.OnGetReward = this.ProcessorOnGetReward;
            _loc4_.y = this.FMC_Top.height + _loc2_ * HEIGHT_UIRewardItem;
            this.FMC_Reward.addChild(_loc4_);
            this.FRewardList.push(_loc4_);
            _loc2_++;
         }
         this.FMC_Bottom.y = this.FRewardList.length * HEIGHT_UIRewardItem + this.FMC_Top.height;
         this.UpdateUpdateRewardItemInfo(param1);
      }
      
      protected function UpdateUpdateRewardItemInfo(param1:TActivityAtoms) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TUIRewardItem = null;
         var _loc6_:String = null;
         var _loc7_:TActivityAtom = null;
         var _loc8_:uint = 0;
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         param1.SortActivityAtoms();
         _loc3_ = uint(param1.OpenCount);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc7_ = param1.GetActivityAtomByIndex(_loc2_);
            _loc5_ = this.FRewardList[_loc2_];
            _loc5_.Identifier = _loc7_.Identifier;
            if(param1.Identifier == KEY_Activity_OnePay)
            {
               _loc8_ = 14;
               _loc10_ = 0;
               while(_loc10_ < _loc7_.DayTime.length)
               {
                  _loc9_ = _loc7_.DayTime[_loc10_] as Array;
                  if(this.GetServerDay() >= _loc9_[0] && this.GetServerDay() < _loc9_[1])
                  {
                     _loc6_ = TUtilityString.Format(STRING_RECHARGE.FORMAT_SINGLERECHARGE,_loc7_.ConditionValue[_loc10_][0],_loc7_.ConditionValue[_loc10_][1]);
                     _loc5_.SetItemInfo(_loc6_,_loc7_.InventoriesVect[_loc10_],_loc7_.ActiveStatus,_loc8_);
                  }
                  _loc10_++;
               }
            }
            else if(param1.Identifier == KEY_Activity_VIPBox)
            {
               _loc8_ = 18;
               _loc10_ = 0;
               while(_loc10_ < _loc7_.DayTime.length)
               {
                  _loc9_ = _loc7_.DayTime[_loc10_] as Array;
                  if(this.GetServerDay() >= _loc9_[0] && this.GetServerDay() < _loc9_[1])
                  {
                     _loc6_ = "VIP" + _loc7_.ConditionValue[_loc10_];
                     _loc5_.SetItemInfo(_loc6_,_loc7_.InventoriesVect[_loc10_],_loc7_.ActiveStatus,_loc8_);
                  }
                  _loc10_++;
               }
            }
            else if(param1.Identifier == KEY_Activity_FlockRecharge)
            {
               _loc8_ = 18;
               _loc10_ = 0;
               while(_loc10_ < _loc7_.DayTime.length)
               {
                  _loc9_ = _loc7_.DayTime[_loc10_] as Array;
                  if(this.GetServerDay() >= _loc9_[0] && this.GetServerDay() < _loc9_[1])
                  {
                     _loc6_ = _loc7_.ConditionValue[_loc10_][0] + STRING_COMMON.ITEMNAME_Gold;
                     _loc5_.SetItemInfo(_loc6_,_loc7_.InventoriesVect[_loc10_],_loc7_.ActiveStatus,_loc8_);
                  }
                  _loc10_++;
               }
            }
            else if(param1.Identifier == KEY_Activity_AddConsume)
            {
               _loc8_ = 18;
               _loc10_ = 0;
               while(_loc10_ < _loc7_.DayTime.length)
               {
                  _loc9_ = _loc7_.DayTime[_loc10_] as Array;
                  if(this.GetServerDay() >= _loc9_[0] && this.GetServerDay() < _loc9_[1])
                  {
                     _loc6_ = _loc7_.ConditionValue[_loc10_] + STRING_COMMON.ITEMNAME_Gold;
                     _loc5_.SetItemInfo(_loc6_,_loc7_.InventoriesVect[_loc10_],_loc7_.ActiveStatus,_loc8_);
                  }
                  _loc10_++;
               }
            }
            _loc2_++;
         }
      }
      
      protected function UpdateMCReward(param1:TActivityAtoms) : void
      {
         switch(param1.Identifier)
         {
            case KEY_Activity_FlockRecharge:
               this.FTF_RechargeType.text = STRING_RECHARGE.STRING_FlockRecharge;
               this.FMC_AddGold.visible = true;
               this.FMC_VIPGold.visible = false;
               this.FMC_CostGold.visible = false;
               this.FTF_AddGold.text = SLogicsCore.CounterLimit.GetValue(KEY_Recharge);
               break;
            case KEY_Activity_OnePay:
               this.FTF_RechargeType.text = STRING_RECHARGE.STRING_OnePay;
               this.FMC_AddGold.visible = false;
               this.FMC_VIPGold.visible = false;
               this.FMC_CostGold.visible = false;
               break;
            case KEY_Activity_VIPBox:
               this.FTF_RechargeType.text = STRING_RECHARGE.STRING_VIPBox;
               this.FMC_AddGold.visible = false;
               this.FMC_CostGold.visible = false;
               this.FMC_VIPGold.visible = true;
               if(SLogicsCore.Character.VipLevel == 10)
               {
                  this.FTF_VIPLevel.text = SLogicsCore.Character.VipLevel.toString() + "";
                  this.FTF_NextVIPLevel.text = STRING_RECHARGE.STRING_MAXVIPLevel;
                  return;
               }
               this.FTF_VIPLevel.text = TUtilityString.Format(STRING_RECHARGE.FORMAT_VIPGOLD_0,SLogicsCore.Character.VipLevel);
               this.FTF_NextVIPLevel.text = TUtilityString.Format(STRING_RECHARGE.FORMAT_VIPGOLD_1,SLogicsCore.Character.VipData.RequirementNextExp,SLogicsCore.Character.VipLevel + 1);
               break;
            case KEY_Activity_AddConsume:
               this.FTF_RechargeType.text = STRING_RECHARGE.STRING_AddConsume;
               this.FMC_AddGold.visible = false;
               this.FMC_VIPGold.visible = false;
               this.FMC_CostGold.visible = true;
               this.FTF_CostGold.text = SLogicsCore.CounterLimit.GetValue(KEY_AddConsume) + "";
         }
      }
      
      protected function UpdateDailySlots(param1:TActivityAtoms) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TActivityAtom = null;
         var _loc5_:Array = null;
         _loc2_ = 0;
         _loc4_ = param1.GetActivityAtomByIndex(_loc2_);
         this.FActivityAtom = _loc4_;
         _loc3_ = this.FDailySlotList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FDailySlotList[_loc2_].Context = null;
            this.FDailySlotList[_loc2_].Resource.visible = false;
            _loc2_++;
         }
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.DayTime.length)
         {
            _loc5_ = _loc4_.DayTime[_loc6_] as Array;
            if(this.GetServerDay() >= _loc5_[0] && this.GetServerDay() < _loc5_[1])
            {
               _loc3_ = uint(_loc4_.InventoriesVect[_loc6_].Count);
               _loc2_ = 0;
               while(_loc2_ < _loc3_)
               {
                  this.FDailySlotList[_loc2_].Context = _loc4_.InventoriesVect[_loc6_].GetInventoryByIndex(_loc2_);
                  this.FDailySlotList[_loc2_].Resource.visible = true;
                  _loc2_++;
               }
            }
            _loc6_++;
         }
      }
      
      protected function FilterRechargeType() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityAtoms = null;
         _loc2_ = int(this.FFilterRechargeAtomsList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FFilterRechargeAtomsList.pop();
            _loc1_++;
         }
         this.FFilterRechargeAtomsList.length = 0;
         _loc2_ = int(KEY_Activity_Vector.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FActiveHashMap.Get(KEY_Activity_Vector[_loc1_]) as TActivityAtoms;
            if(_loc4_ != null && _loc4_.IsOn)
            {
               this.FFilterRechargeAtomsList.push(_loc4_);
            }
            _loc1_++;
         }
         this.FFilterRechargeAtomsList.sort(this.Sort);
      }
      
      protected function Sort(param1:TActivityAtoms, param2:TActivityAtoms) : int
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc3_ = param1.Sort;
         _loc4_ = param2.Sort;
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 0;
      }
      
      protected function UpdateUIRecharge() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TActivityAtoms = null;
         if(this.FFilterRechargeAtomsList.length == 0)
         {
            return;
         }
         _loc3_ = this.FPageIndex * CONST_RECHARGE.CAPACITY_MC_Tabs;
         if(this.FTabIndex + _loc3_ >= this.FFilterRechargeAtomsList.length)
         {
            this.FTabIndex = 0;
         }
         _loc4_ = this.FFilterRechargeAtomsList[this.FTabIndex + _loc3_];
         this.FMC_RechageRanking.visible = false;
         this.FScrollBar.SetScrollVisble(true);
         this.FBTN_Recharge.visible = true;
         if(_loc4_.Identifier == KEY_Activity_EreryDayRecharge)
         {
            this.UpdateDailyRecharge(_loc4_);
         }
         else if(_loc4_.Identifier == KEY_Activity_DailyConsume)
         {
            this.UpdateDailyConsume(_loc4_);
         }
         else if(_loc4_.Identifier == KEY_Activity_InvestmentFunds)
         {
            this.UpdateInvestmentFunds(_loc4_);
         }
         else if(_loc4_.Identifier == KEY_Activity_RechageRanking)
         {
            this.RequestRechageRank();
            this.UpdateRechageRanking(_loc4_);
         }
         else
         {
            this.UpdateMCRecharge(_loc4_);
         }
         this.UpdateRechargeText(_loc4_);
      }
      
      protected function UpdateRechageRanking(param1:TActivityAtoms) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIRechageRankingItem = null;
         var _loc5_:String = null;
         var _loc6_:TInventories = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:TActivityAtom = null;
         var _loc12_:Vector.<Object> = null;
         this.FActivityAtoms = param1;
         if(this.FMyRank == 0)
         {
            this.FTF_MyRanking.visible = false;
            this.FMC_NoRank.visible = true;
            this.FMC_RechageRanking["MC_Info"]["TF_Ranking"].visible = false;
            this.FMC_RechageRanking["MC_Info"]["MC_bg"].visible = false;
         }
         else
         {
            this.FTF_MyRanking.visible = true;
            this.FMC_RechageRanking["MC_Info"]["TF_Ranking"].visible = true;
            this.FMC_RechageRanking["MC_Info"]["MC_bg"].visible = true;
            this.FTF_MyRanking.text = this.FMyRank.toString();
            this.FMC_NoRank.visible = false;
         }
         this.FTF_MyPay.text = this.FMyPay.toString();
         this.FScrollRechageRankBar.Clear();
         this.FRechageRankLsit.length = 0;
         _loc11_ = param1.GetActivityAtomByIndex(param1.Count - 1);
         _loc12_ = _loc11_.ConditionValue as Vector.<Object>;
         _loc2_ = int(_loc12_[1]);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new TUIRechageRankingItem(this,_loc3_ + 1);
            _loc4_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc4_.OnOverlay = this.SlotsOnMove;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc4_.Init();
            _loc5_ = STRING_RECHARGE.STRING_RechageRanking + (_loc3_ + 1) + "";
            _loc9_ = STRING_RECHARGE.STRING_Name;
            _loc10_ = "0";
            _loc4_.SetText(_loc5_,_loc9_,_loc10_);
            _loc6_ = this.GetPayRankReward(_loc3_ + 1,param1);
            _loc7_ = 0;
            while(_loc7_ < _loc6_.Count)
            {
               _loc4_.SetItemInfo(_loc7_,_loc6_.GetInventoryByIndex(_loc7_));
               _loc7_++;
            }
            this.FScrollRechageRankBar.AddItem(_loc4_);
            this.FRechageRankLsit.push(_loc4_);
            _loc3_++;
         }
         if(this.FInforArray != null)
         {
            _loc2_ = this.FInforArray.length / 2;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = this.FRechageRankLsit[_loc3_];
               _loc5_ = STRING_RECHARGE.STRING_RechageRanking + (_loc3_ + 1) + "";
               _loc9_ = this.FInforArray[_loc3_ << 1];
               _loc10_ = this.FInforArray[(_loc3_ << 1) + 1] + STRING_RECHARGE.STRING_Gold;
               _loc4_.SetText(_loc5_,_loc9_,_loc10_);
               _loc3_++;
            }
         }
         this.FScrollBar.Clear();
         this.FScrollBar.AddItem(this.FMC_Text);
         this.FMC_Reward.visible = false;
         this.FMC_DailyRecharge.visible = false;
         this.FMC_DailyConsume.visible = false;
         this.FMC_RechageRanking.visible = true;
         this.FMC_Detail.addChild(this.FMC_RechageRanking);
         this.FBTN_Recharge.visible = false;
         this.FScrollBar.SetScrollVisble(false);
         this.FMC_Detail["MC_InvestmentFunds"].visible = false;
      }
      
      protected function GetPayRankReward(param1:int, param2:TActivityAtoms) : TInventories
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TActivityAtom = null;
         var _loc6_:TInventories = null;
         var _loc7_:Array = null;
         var _loc8_:Vector.<Object> = null;
         _loc7_ = new Array();
         _loc3_ = param2.Count;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param2.GetActivityAtomByIndex(_loc4_);
            if(_loc5_ != null && _loc5_.ConditionValue != null)
            {
               _loc8_ = _loc5_.ConditionValue as Vector.<Object>;
               _loc7_.length = 0;
               _loc7_.push(_loc8_[0],_loc8_[1]);
               if(_loc7_.length == 1)
               {
                  if(param1 == _loc7_[0])
                  {
                     if(_loc5_.InventoriesVect != null)
                     {
                        _loc6_ = _loc5_.InventoriesVect[0];
                     }
                  }
               }
               if(_loc7_.length == 2)
               {
                  if(param1 >= _loc7_[0] && param1 <= _loc7_[1])
                  {
                     if(_loc5_.InventoriesVect != null)
                     {
                        _loc6_ = _loc5_.InventoriesVect[0];
                     }
                  }
               }
            }
            _loc4_++;
         }
         return _loc6_;
      }
      
      protected function UpdateDailyConsume(param1:TActivityAtoms) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TUIDailyConsumeItem = null;
         var _loc5_:uint = 0;
         this.FScrollBar.Clear();
         this.FMC_Detail.addChild(this.FMC_Text);
         this.FMC_DailyConsume.visible = true;
         this.FMC_Reward.visible = false;
         this.FMC_DailyRecharge.visible = false;
         this.FMC_InvestmentFunds.visible = false;
         this.FActivityAtoms = param1;
         _loc3_ = this.FDailyConsumelist.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FDailyConsumelist[_loc2_];
            _loc5_ = _loc2_ == 0 ? KEY_COUNTER_MilitaryOrdersLimit : KEY_MAKE_RAMEN;
            _loc4_.SetItemInfo(String_Activity_Vector[_loc2_],param1.GetActivityAtomByIndex(_loc2_),_loc5_);
            _loc2_++;
         }
      }
      
      protected function PerformPacket_CS_UpdateCounterReq() : void
      {
         var _loc1_:Vector.<uint> = null;
         _loc1_ = new Vector.<uint>(4);
         _loc1_[0] = KEY_Recharge;
         SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_ACTIVE_RechargeDetail_Req,0,0,_loc1_);
         _loc1_[1] = KEY_COUNTER_MilitaryOrdersLimit;
         SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_COUNTER_MilitaryOrdersLimit_Req,0,0,_loc1_);
         _loc1_[2] = KEY_MAKE_RAMEN;
         SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_COUNTER_MakeRamen_Req,0,0,_loc1_);
         _loc1_[3] = KEY_AddConsume;
         SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_ACTIVE_AddConsume_Req,0,0,_loc1_);
         this.RequestRechageRank();
      }
      
      protected function CheckTabShowGlow() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TActivityAtoms = null;
         var _loc6_:Boolean = false;
         _loc3_ = int(CONST_RECHARGE.CAPACITY_MC_Tabs);
         _loc4_ = int(this.FFilterRechargeAtomsList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = _loc1_ + this.FPageIndex;
            if(_loc2_ >= _loc4_)
            {
               break;
            }
            _loc5_ = this.FFilterRechargeAtomsList[_loc2_];
            if(this.CheckIfCanShowEffectSingle(_loc5_))
            {
               this.FUITab.StartTabShowGlowByIndex(_loc1_);
            }
            else
            {
               this.FUITab.StopTabShowGlowByIndex(_loc1_);
            }
            _loc1_++;
         }
      }
      
      protected function CheckIfCanShowEffectSingle(param1:TActivityAtoms) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TActivityAtom = null;
         _loc3_ = param1.OpenCount;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1.GetActivityAtomByIndex(_loc2_);
            if(_loc4_.ActiveStatus > 0)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      protected function Update() : void
      {
         if(this.FInitialized)
         {
            this.FilterRechargeType();
            this.UpdateUITab();
            this.UpdatePageInfo();
            this.FUITab.SwithTagManual(this.FTabIndex);
            this.TabOnSwitch(this.FTabIndex);
            this.CheckTabShowGlow();
         }
      }
      
      protected function GetServerDay() : int
      {
         return (STimingCore.GetServerTick() - STimingCore.GetServerStartTime()) / (24 * 60 * 60) + 1;
      }
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
         this.FUITab.StopGlow();
         SResourcesCore.PerformAutoReleaseResources(this.FModuleId);
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FTabIndex = param1 as int;
         this.UpdateUIRecharge();
      }
      
      protected function ButtonLeftOnClick(param1:MouseEvent) : void
      {
         --this.FPageIndex;
         if(this.FPageIndex <= 0)
         {
            this.FPageIndex = 0;
         }
         this.UpdateUITab();
         this.UpdatePageInfo();
         this.TabOnSwitch(null);
         this.CheckTabShowGlow();
      }
      
      protected function ButtonRightOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         ++this.FPageIndex;
         _loc2_ = uint(this.FFilterRechargeAtomsList.length / CONST_RECHARGE.CAPACITY_MC_Tabs);
         if(this.FPageIndex > _loc2_)
         {
            this.FPageIndex = _loc2_;
         }
         this.UpdateUITab();
         this.UpdatePageInfo();
         this.TabOnSwitch(null);
         this.CheckTabShowGlow();
      }
      
      protected function ButtonGetDailyRewardOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Activity_ReceiveAwardsReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FActivityAtom.Identifier);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ButtonDailyFundsOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         _loc4_ = this.FActivityAtoms.GetActivityAtomByIdentifier(INVESTMENTFUNDS_IDENTIFY[0]).ActiveStatus;
         if(_loc4_ == -1)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Activity_ReceiveAwardsReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FActivityAtoms.GetActivityAtomByIdentifier(INVESTMENTFUNDS_IDENTIFY[0]).Identifier);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ButtonLevelFundsOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FActivityAtoms.GetActivityAtomByIdentifier(INVESTMENTFUNDS_IDENTIFY[1]).ActiveStatus;
         if(_loc2_ == -1)
         {
            return;
         }
         this.FMC_InvestConfirmation.visible = true;
      }
      
      protected function UpdateInvestInventories(param1:Vector.<TInventories>) : void
      {
         this.FInvestSlotList[0].Context = param1[0].GetInventoryByIndex(0);
         this.FInvestSlotList[0].Resource.visible = true;
      }
      
      protected function ButtonRechargeOnClick(param1:MouseEvent) : void
      {
         SExternalCore.NavigateToRecharge();
      }
      
      protected function ButtonInvestOkOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Activity_ReceiveAwardsReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FActivityAtoms.GetActivityAtomByIdentifier(INVESTMENTFUNDS_IDENTIFY[1]).Identifier);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ButtonInvestCancelOnClick(param1:MouseEvent) : void
      {
         this.FMC_InvestConfirmation.visible = false;
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,this.FModuleId);
         }
      }
      
      protected function SlotsOnMove(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOver != null)
         {
            this.FOnInventoryOver(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOut != null)
         {
            this.FOnInventoryOut(this,param2);
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function ProcessorOnGetReward(param1:Object, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Activity_ReceiveAwardsReq);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ButtonLevelFundsOnOut(param1:MouseEvent) : void
      {
         if(this.FOnHintOut != null)
         {
            this.FOnHintOut(this);
         }
      }
      
      protected function ButtonLevelFundsOnMove(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         this.FHint.Caption = this.FActivityAtoms.GetActivityAtomByIdentifier(INVESTMENTFUNDS_IDENTIFY[1]).Tips[0];
         if(this.FOnHintOver != null)
         {
            this.FOnHintOver(this,this.FHint);
         }
      }
      
      protected function ButtonDailyFundsOnOut(param1:MouseEvent) : void
      {
         if(this.FOnHintOut != null)
         {
            this.FOnHintOut(this);
         }
      }
      
      protected function ButtonDailyFundsOnMove(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         this.FHint.Caption = this.FActivityAtoms.GetActivityAtomByIdentifier(INVESTMENTFUNDS_IDENTIFY[0]).Tips[0];
         if(this.FOnHintOver != null)
         {
            this.FOnHintOver(this,this.FHint);
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int = 0) : void
      {
         this.FProcessorWindowRecruit.SetHeroData(param1);
      }
      
      protected function ProcessorTipOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      protected function ProcessorTipOnOut(param1:Object) : void
      {
         this.FOverlayerHint.Hide();
      }
      
      protected function RequestRechageRank() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Activity_RechageRankReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function get OnInventoryOver() : Function
      {
         return this.FOnInventoryOver;
      }
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function get OnInventoryOut() : Function
      {
         return this.FOnInventoryOut;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
      }
      
      public function get OnNewRechargeGift() : Function
      {
         return this.FOnNewRechargeGift;
      }
      
      public function set OnNewRechargeGift(param1:Function) : void
      {
         this.FOnNewRechargeGift = param1;
      }
      
      public function get OnBuyActionTimes() : Function
      {
         return this.FOnBuyActionTimes;
      }
      
      public function set OnBuyActionTimes(param1:Function) : void
      {
         this.FOnBuyActionTimes = param1;
      }
      
      public function get OnGotoRamen() : Function
      {
         return this.FOnGotoRamen;
      }
      
      public function set OnGotoRamen(param1:Function) : void
      {
         this.FOnGotoRamen = param1;
      }
      
      public function set OnHintOver(param1:Function) : void
      {
         this.FOnHintOver = param1;
      }
      
      public function set OnHintOut(param1:Function) : void
      {
         this.FOnHintOut = param1;
      }
      
      public function Init() : void
      {
         this.PerformPacket_CS_UpdateCounterReq();
         this.FTabIndex = 0;
      }
      
      public function SendPayRank(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         _loc2_ = param1.Data.readUnsignedShort();
         this.FInforArray.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = TUtilityString.FetchUTF(param1.Data);
            this.FInforArray.push(_loc4_);
            this.FMyRank = param1.Data.readUnsignedInt();
            this.FInforArray.push(this.FMyRank);
            _loc3_++;
         }
         this.FMyRank = param1.Data.readUnsignedInt();
         this.FMyPay = param1.Data.readUnsignedInt();
      }
      
      public function Test() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUIRechageRankingItem = null;
         var _loc4_:String = null;
         var _loc5_:TInventories = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         if(this.FMyRank == 0)
         {
            this.FTF_MyRanking.visible = false;
            this.FMC_NoRank.visible = true;
         }
         else
         {
            this.FTF_MyRanking.visible = true;
            this.FTF_MyRanking.text = this.FMyRank.toString();
            this.FMC_NoRank.visible = false;
         }
         _loc10_ = this.FPageIndex * CONST_RECHARGE.CAPACITY_MC_Tabs;
         _loc1_ = this.FInforArray.length / 2;
         this.FScrollRechageRankBar.Clear();
         this.FRechageRankLsit.length = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = new TUIRechageRankingItem(this,_loc2_ + 1);
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnOverlay = this.SlotsOnMove;
            _loc3_.OnOut = this.SlotsOnOut;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.Init();
            _loc4_ = TUtilityString.Format(STRING_ACTIVITYINNER.FormatString_ArenaRank,_loc2_ + 1 + "");
            _loc8_ = this.FInforArray[_loc2_ << 1];
            _loc9_ = this.FInforArray[(_loc2_ << 1) + 1];
            _loc3_.SetText(_loc4_,_loc8_,_loc9_);
            _loc5_ = this.FFilterRechargeAtomsList[this.FTabIndex + _loc10_].GetActivityAtomByIndex(0).InventoriesVect[0];
            _loc6_ = 0;
            while(_loc6_ < _loc5_.Count)
            {
               _loc3_.SetItemInfo(_loc6_,_loc5_.GetInventoryByIndex(_loc6_));
               _loc6_++;
            }
            this.FRechageRankLsit.push(_loc3_);
            _loc2_++;
         }
         this.FMC_RechageRanking.visible = true;
      }
   }
}

