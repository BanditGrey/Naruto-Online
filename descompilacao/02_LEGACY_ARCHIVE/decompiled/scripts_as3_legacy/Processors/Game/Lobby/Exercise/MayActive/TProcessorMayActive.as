package Processors.Game.Lobby.Exercise.MayActive
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.MayActive.TMayActive1;
   import Logics.Exercise.MayActive.TMayActive2;
   import Logics.Exercise.MayActive.TMayActive3;
   import Logics.Exercise.MayActive.TMayActive4;
   import Logics.Exercise.MayActive.TMayActiveDatas;
   import Logics.Exercise.MayActive.TMsgGraph;
   import Logics.Exercise.MayActive.TMsgTreasure;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerMayActive;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowDesc;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowRank;
   import Processors.Game.Lobby.Exercise.MayActive.Compoents.TUIMayActive1;
   import Processors.Game.Lobby.Exercise.MayActive.Compoents.TUIMayActive2;
   import Processors.Game.Lobby.Exercise.MayActive.Compoents.TUIMayActive3;
   import Processors.Game.Lobby.Exercise.MayActive.Compoents.TUIMayActive4;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Processors.Game.Windows.Information.TUIWindowInformation;
   import Rendering.Overlayers.Box.TOverlayerBox;
   import Rendering.Overlayers.Title.TOverlayerTitle;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorMayActive extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      public static const ACTIVITY_2_START:int = 1;
      
      public static const ACTVITTY_2_SEARCH:int = 2;
      
      public static const ACTVITTY_2_GIVE_UP:int = 3;
      
      public static const ACTVITTY_2_FREE_REFRESH:int = 4;
      
      public static const ACTIVITY_2_GOLD_REFRESH:int = 5;
      
      public static const ACTVITTY_2_BUY_BOX:int = 6;
      
      public static const ACTVITTY_2_SEEK_BOX:int = 7;
      
      public static const ACTIVITY_3_FREE_REFRESH:int = 1;
      
      public static const ACTIVITY_3_GOLD_REFRESH:int = 2;
      
      public static const ACTIVITY_3_BUY_SOLDIER:int = 3;
      
      public static const ACTIVITY_3_ATTACK_MONSTER:int = 4;
      
      public static const ACTIVITY_3_GOTO_NEW_MAP:int = 5;
      
      public static const ACTIVITY_3_ADD_MP:int = 6;
      
      public static const ACTIVITY_3_ADD_AP:int = 7;
      
      public static const ACTIVITY_3_GET_GIFT:int = 8;
      
      public static const ACTIVITY_3_GET_BOX:int = 9;
      
      public static const ACTIVITY_3_GET_KILL_BOSS_BOX:int = 10;
      
      public static const ACTIVITY_3_ATTACK_BOSS:int = 11;
      
      public static const ACTIVITY_3_GET_SPECIAL_REWARD:int = 12;
      
      public static const ACTIVITY_3_GET_KILL_MONSTER_BOX:int = 13;
      
      public static const ACTIVITY_3_FIRE_SOLDIER:int = 14;
      
      public static const ACTIVITY_4_GET_BOX:int = 1;
      
      public static const ACTIVITY_4_GET_HERO:int = 2;
      
      public static const ACTIVITY_4_GET_SWEET:int = 3;
      
      public static const ACTIVITY_4_GET_TEN:int = 4;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      public static const ACTIVITY_3_DROP_ITEM_INDEX:int = 15;
      
      public static const ACTIVITY_4_DROP_ITEM_INDEX:int = 16;
      
      protected var TAB_COUNT:int = 4;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIMayActive1,TUIMayActive2,TUIMayActive3,TUIMayActive4]);
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FMayActiveDatas:TMayActiveDatas;
      
      protected var FUnstreamizerMayActive:TUnstreamizerMayActive;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FBuyBoxDate:Object;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorMayActiveRank:TProcessorWindowRank;
      
      protected var FUIWindowInformation:TUIWindowInformation;
      
      protected var FProcessorWindowMayActiveLog:TProcessorWindowMayActiveLog;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FIsOpen:Boolean;
      
      public function TProcessorMayActive(param1:TUIComponent, param2:TLobbyParameters, param3:int)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FMayActiveDatas = SLogicsCore.MayActiveDatas;
         this.FUnstreamizerMayActive = new TUnstreamizerMayActive();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerTitle = new TUnstreamizerTitle();
         this.FTabList = new Vector.<MovieClip>(this.TAB_COUNT);
         this.FChangeTabIndex = 0;
         this.FGlowsFilter = new Vector.<TEffectBaseGlowTwo>(this.TAB_COUNT);
         this.FUIWindowVect = new Vector.<TUIBaseWindow>(this.TAB_COUNT);
         this.FOverlayerBox = new TOverlayerBox(this.Parent);
         this.FOverlayerBox.Visible = false;
         this.FBuyBoxDate = new Object();
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         FProcessorWindowDesc = new TProcessorWindowDesc(this.Parent);
         this.FProcessorWindowMayActiveLog = new TProcessorWindowMayActiveLog(this.Parent);
         this.FProcessorMayActiveRank = new TProcessorWindowRank(this.Parent);
         this.FOverlayerTitle = new TOverlayerTitle(this.Parent);
         this.FOverlayerTitle.Visible = false;
         this.FAllTitles = new TTitles();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Class = null;
         var _loc5_:TEffectBaseGlowTwo = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            this.FTabList[_loc1_] = FMC_Scene["MC_Tab" + _loc1_];
            this.FTabList[_loc1_].MC_Tab.gotoAndStop(_loc1_ + 1);
            this.FTabList[_loc1_].buttonMode = true;
            this.FTabList[_loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnChangePage);
            this.FTabList[_loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTabOver);
            this.FTabList[_loc1_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnTabOut);
            this.FTabList[_loc1_].MC_ComingSoon.TF_Date.mouseEnabled = false;
            _loc5_ = new TEffectBaseGlowTwo();
            _loc5_.SetParameters(FMC_Scene["MC_Tab" + _loc1_],FilterColor,FilterGlowWidth,FilterGlowStrength);
            this.FGlowsFilter[_loc1_] = _loc5_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            _loc4_ = this.ACTIVITY_REFERENCE[_loc1_];
            this.FUIWindowVect[_loc1_] = new _loc4_(this);
            this.FUIWindowVect[_loc1_].Perform_UIDispatch(FMC_Scene["MC_Activity" + _loc1_]);
            this.FUIWindowVect[_loc1_].OnGetBox = this.ProcessorOnGetBoxUp;
            this.FUIWindowVect[_loc1_].OnBuyBox = this.ProcessorOnBuyBoxUp;
            this.FUIWindowVect[_loc1_].OnBoxOver = this.ProcessorOnBoxOver;
            this.FUIWindowVect[_loc1_].OnBoxOut = this.ProcessorOnBoxOut;
            this.FUIWindowVect[_loc1_].OnItemOver = UIComponentsHintOnOver;
            this.FUIWindowVect[_loc1_].OnItemOut = UIComponentsHintOnOut;
            this.FUIWindowVect[_loc1_].OnShowDesc = this.ProcessorOnShowDesc;
            this.FUIWindowVect[_loc1_].OnShowFlowText = ProcessorEffectText;
            this.FUIWindowVect[_loc1_].OnShowHtmlTip = ProcessorOnShowHtmlText;
            this.FUIWindowVect[_loc1_].OnHideHtmlTip = ProcessorOnHideHtmlText;
            this.FUIWindowVect[_loc1_].OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FUIWindowVect[_loc1_].OnLoadLog = this.ProcessorOnLoadLog;
            this.FUIWindowVect[_loc1_].OnLoadRank = this.ProcessorOnGotoRank;
            this.FUIWindowVect[_loc1_].GotoRecharge = ProcessorOnRechargeUp;
            this.FUIWindowVect[_loc1_].OnIntervalFun = this.ProcessorOnIntervalFun;
            _loc1_++;
         }
         this.ConstructUIWindowInformation();
         this.FProcessorMayActiveRank.OnCloseUp = this.ProcessorOnCloseWindow;
         this.FProcessorMayActiveRank.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorMayActiveRank.OnOut = UIComponentsHintOnOut;
         this.FProcessorMayActiveRank.TitleHintOnOver = this.ProcessorOnTitleOver;
         this.FProcessorMayActiveRank.TitleHintOnOut = this.ProcessorOnTitleOut;
         this.FProcessorMayActiveRank.Visible = false;
         this.FProcessorWindowMayActiveLog.OnCloseUp = this.ProcessorOnCloseMayActiveLog;
         this.FProcessorWindowMayActiveLog.Visible = false;
         FProcessorWindowDesc.OnCloseUp = ProcessorOnCloseDesc;
         FProcessorWindowDesc.Visible = false;
         this.FUnstreamizerTitle.UnstreamizeTitleByDatabase(null,this.FAllTitles,null);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTitle);
      }
      
      private function ProcessorOnCloseMayActiveLog() : void
      {
         this.FProcessorWindowMayActiveLog.Visible = false;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && this.visible)
         {
            this.UpdateTabEffect();
            this.FUIWindowVect[this.FChangeTabIndex].LogicsPerform();
            if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
            {
               this.FProcessorWindowRecruit.UpdataBitmap();
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseActivity = null;
         super.UpdateUI();
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            _loc2_ = this.FTabList[_loc1_];
            _loc3_ = this.FMayActiveDatas.GetActivityByIndex(_loc1_);
            if(_loc3_.IsOpen == TBaseActivity.IS_NOT_OPEN)
            {
               _loc2_.MC_Title.visible = false;
               _loc2_.MC_ComingSoon.visible = true;
               _loc2_.MC_Closed.visible = false;
               _loc2_.MC_Tab.visible = false;
               _loc2_.MC_ComingSoon.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_OPEN,TUtilityDate.FormatMMDDChineseNew(new Date(STimingCore.GetClientShowTime(_loc3_.BeginTime) * 1000)));
               this.FUIWindowVect[_loc1_].SetVisible(false);
            }
            else if(_loc3_.IsOpen == TBaseActivity.IS_OPEN)
            {
               _loc2_.MC_ComingSoon.visible = false;
               _loc2_.MC_Closed.visible = false;
               _loc2_.MC_Title.gotoAndStop(_loc1_ + 1);
               _loc2_.MC_Tab.gotoAndStop(_loc1_ + 1);
               if(_loc1_ == this.FChangeTabIndex)
               {
                  _loc2_.MC_Title.visible = false;
                  _loc2_.MC_Tab.visible = true;
                  this.FUIWindowVect[_loc1_].SetVisible(true);
                  this.FUIWindowVect[_loc1_].UpdateUI();
               }
               else
               {
                  _loc2_.MC_Title.visible = true;
                  _loc2_.MC_Tab.visible = false;
                  this.FUIWindowVect[_loc1_].SetVisible(false);
               }
            }
            else
            {
               _loc2_.MC_Title.visible = false;
               _loc2_.MC_ComingSoon.visible = false;
               _loc2_.MC_Closed.visible = true;
               _loc2_.MC_Tab.visible = false;
               this.FUIWindowVect[_loc1_].SetVisible(false);
            }
            if(this.FMayActiveDatas.Activities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
            {
               this.FGlowsFilter[_loc1_].IsRunOver = false;
            }
            else
            {
               this.FGlowsFilter[_loc1_].Stop();
            }
            _loc1_++;
         }
      }
      
      protected function UpdateTabEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TEffectBaseGlowTwo = null;
         if(this.FGlowsFilter == null || this.FGlowsFilter[0] == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FGlowsFilter.length)
         {
            _loc2_ = this.FGlowsFilter[_loc1_];
            if(!_loc2_.IsRunOver)
            {
               _loc2_.Run();
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorOnChangePage(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseActivity = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         _loc3_ = this.FMayActiveDatas.GetActivityByIndex(_loc2_);
         if(_loc3_.IsOpen != TBaseActivity.IS_OPEN || _loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         this.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnTabOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseActivity = null;
         var _loc4_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         _loc3_ = this.FMayActiveDatas.GetActivityByIndex(_loc2_);
         if(_loc3_.ActivityTabName)
         {
            _loc4_ = _loc3_.ActivityTabName.split("%n").join("\n");
            ProcessorOnShowTip(_loc4_);
         }
      }
      
      protected function ProcessorOnTabOut(param1:MouseEvent) : void
      {
         ProcessorOnHideTip();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HappyTreasure_LoadInfoReq);
         _loc1_.Data.writeUnsignedInt(ActivityID);
         _loc1_.Data.writeUnsignedInt(this.FChangeTabIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOnNewBuyBoxUp(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 0, param6:int = 0, param7:String = "") : void
      {
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxType = param2;
         this.FBuyBoxDate.BoxIndex1 = param4;
         this.FBuyBoxDate.BoxIndex2 = param5;
         this.FBuyBoxDate.Cost = param3;
         this.FBuyBoxDate.CostType = param6;
         if(param6 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex);
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = param3;
            if(param7 != "")
            {
               FUIWindowConfirmation.Text = param7;
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
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 0, param6:String = "", param7:int = 0) : void
      {
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxType = param2;
         this.FBuyBoxDate.BoxIndex = param4;
         this.FBuyBoxDate.BoxIndex2 = param7;
         this.FBuyBoxDate.Cost = param3;
         this.FBuyBoxDate.CostType = param5;
         if(param5 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex2);
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = param3;
            if(param6 != "")
            {
               FUIWindowConfirmation.Text = param6;
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
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex2);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0) : void
      {
         var _loc5_:TPacket = null;
         var _loc6_:int = 0;
         var _loc7_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc7_ = new Vector.<int>();
         _loc7_.push(param2);
         if(param3 != 0)
         {
            _loc7_.push(param3);
         }
         if(param4 != 0)
         {
            _loc7_.push(param4);
         }
         PerformPacket_CS_AllReq(param1,_loc7_);
      }
      
      protected function ProcessorOnGotoRank(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SpringFestival_LoadRankInfoReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         _loc2_.Data.writeUnsignedInt(param1);
         _loc2_.Data.writeShort(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         this.FProcessorMayActiveRank.Visible = false;
      }
      
      protected function ProcessorOnTitleOver(param1:uint) : void
      {
         var _loc2_:TTitle = null;
         _loc2_ = this.FAllTitles.GetTitleByIdentifier(param1);
         if(_loc2_ != null)
         {
            this.FOverlayerTitle.Context = _loc2_;
            this.FOverlayerTitle.Render(FUICore.MouseCoordinate);
            this.FOverlayerTitle.Show();
         }
      }
      
      protected function ConstructUIWindowInformation() : void
      {
         this.FUIWindowInformation = new TUIWindowInformation(this.Parent);
         this.FUIWindowInformation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowInformation.WindowHeight) / 2 - 30;
         TUtilityUIWindow.SetupWindowInformation(this.FUIWindowInformation);
      }
      
      private function WindowInformationOnOK() : void
      {
         this.FUIWindowInformation.Visible = false;
      }
      
      protected function ProcessorOnActiveLog() : void
      {
         this.FProcessorWindowMayActiveLog.Visible = false;
      }
      
      protected function ProcessorOnTitleOut() : void
      {
         this.FOverlayerTitle.Hide();
      }
      
      protected function ProcessorOnShowDesc() : void
      {
         FProcessorWindowDesc.BaseActivity = this.FMayActiveDatas.GetActivityByIndex(this.FChangeTabIndex);
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnLoadLog(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(param1 == ACTIVITY_2_ID)
         {
            PerformPacket_CS_AcitivityThird_LoadLogReq(ACTIVITY_2_ID,null);
            FProcessorWindowLog.Visible = true;
         }
         else if(param1 == ACTIVITY_3_ID)
         {
            PerformPacket_CS_AcitivityThird_LoadLogReq(ACTIVITY_3_ID,null);
         }
         else if(param1 == ACTIVITY_4_ID)
         {
            PerformPacket_CS_AcitivityThird_LoadLogReq(ACTIVITY_4_ID,null);
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int = 0) : void
      {
         if(param2 == TBaseBox.TYPE_IS_HERO)
         {
            this.FProcessorWindowRecruit.SetHeroData(param1);
         }
         else if(param2 == TBaseBox.TYPE_IS_PET)
         {
            FProcessorWindowPetDesc.SetPetData(param1);
         }
      }
      
      protected function ProcessorOnBoxOver(param1:TInventories) : void
      {
         if(param1 != null)
         {
            this.FOverlayerBox.Context = param1;
            this.FOverlayerBox.Render(FUICore.MouseCoordinate);
            this.FOverlayerBox.Show();
         }
      }
      
      protected function ProcessorOnBoxOut() : void
      {
         this.FOverlayerBox.Hide();
      }
      
      protected function ProcessorOnIntervalFun() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_MayActivity_BossStatusReq);
         _loc1_.Data.writeUnsignedInt(_loc3_);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRecruit.Load();
            this.FProcessorWindowMayActiveLog.Load();
            this.FProcessorMayActiveRank.Load();
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
         this.FChangeTabIndex = 0;
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
         this.FProcessorMayActiveRank.visible = false;
         _loc2_ = int(this.FUIWindowVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FUIWindowVect[_loc1_])
            {
               this.FUIWindowVect[_loc1_].Unmount();
            }
            _loc1_++;
         }
         TweenUtil.removeAllTween();
         this.FChangeTabIndex = 0;
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
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
            OnClose(this);
            return;
         }
         this.FUnstreamizerMayActive.Unstreamize(_loc2_,this.FMayActiveDatas,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.FProcessorWindowMayActiveLog.Visible = false;
            this.UpdateUI();
         }
      }
      
      override public function ProcessorLoadRankRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TConsumeRankInfo = null;
         var _loc7_:TBaseBox = null;
         var _loc8_:TInventories = null;
         var _loc9_:TInventory = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:int = 0;
         var _loc12_:TMayActive3 = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc11_ = int(_loc2_.readUnsignedInt());
         _loc12_ = this.FMayActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TMayActive3;
         _loc2_.readUnsignedShort();
         if(_loc12_)
         {
            _loc12_.RankGiftList.length = 0;
            _loc5_ = int(_loc2_.readUnsignedShort());
            _loc10_ = new Vector.<uint>();
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc7_ = new TBaseBox();
               _loc7_.Min = _loc2_.readUnsignedInt();
               _loc7_.Max = _loc2_.readUnsignedInt();
               _loc7_.TitleID = _loc2_.readUnsignedInt();
               _loc10_.length = 0;
               _loc8_ = new TInventories();
               _loc10_.push(_loc2_.readUnsignedInt());
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc10_);
               _loc9_ = _loc8_.GetInventoryByIndex(0);
               _loc9_.Quantity = 1;
               _loc7_.Inventories = _loc8_;
               _loc12_.RankGiftList.push(_loc7_);
               _loc4_++;
            }
            _loc12_.RankPlayerList.length = 0;
            _loc5_ = int(_loc2_.readUnsignedShort());
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc6_ = new TConsumeRankInfo();
               _loc6_.UserName = TUtilityString.FetchUTF(_loc2_);
               _loc6_.ServerName = TUtilityString.FetchUTF(_loc2_);
               _loc6_.Rank = _loc2_.readUnsignedInt();
               _loc6_.Score = _loc2_.readUnsignedInt();
               _loc12_.RankPlayerList.push(_loc6_);
               _loc4_++;
            }
         }
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.FProcessorMayActiveRank.Visible = true;
            this.FProcessorMayActiveRank.UpdateUI(_loc12_);
         }
      }
      
      override public function ProcessorLoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:TLotteryNews = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:Vector.<uint> = null;
         var _loc16_:TBins = null;
         var _loc17_:TMayActive1 = null;
         _loc16_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         super.ProcessorLoadLogRet();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         _loc17_ = this.FMayActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TMayActive1;
         _loc17_.LogList.length = 0;
         _loc5_ = _loc2_.readShort();
         _loc14_ = new Vector.<uint>();
         _loc15_ = new Vector.<uint>();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc10_ = new TLotteryNews();
            _loc14_.length = 0;
            _loc15_.length = 0;
            _loc7_ = int(_loc2_.readUnsignedShort());
            _loc6_ = 0;
            while(_loc6_ < _loc7_ / 4)
            {
               _loc12_ = _loc2_.readUnsignedInt();
               _loc11_ = _loc2_.readUnsignedInt();
               _loc13_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc16_);
               _loc14_.push(_loc13_);
               _loc15_.push(_loc2_.readUnsignedInt());
               _loc10_.GetTime = _loc2_.readUnsignedInt();
               _loc6_++;
            }
            _loc9_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc14_);
            _loc8_ = _loc9_.GetInventoryByIndex(0);
            _loc8_.Quantity = _loc15_[0];
            _loc10_.Inventory = _loc8_;
            _loc10_.Inventories = _loc9_;
            _loc17_.LogList.push(_loc10_);
            _loc4_++;
         }
         FProcessorWindowLog.BaseActivity = _loc17_;
         FProcessorWindowLog.UpdateUI();
         FProcessorWindowLog.Visible = true;
      }
      
      override public function ProcessorOnTreasuresInfoRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:TInventory = null;
         var _loc10_:TInventories = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:TBaseBox = null;
         var _loc16_:TMayActive2 = null;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:TMsgTreasure = null;
         var _loc20_:TMsgGraph = null;
         var _loc21_:TBins = null;
         _loc21_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc2_ = param1.Data;
         _loc16_ = this.FMayActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TMayActive2;
         _loc6_ = _loc2_.readInt();
         if(_loc6_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc6_);
            ProcessorClose();
            return;
         }
         _loc5_ = _loc2_.readUnsignedInt() - 1;
         _loc4_ = _loc2_.readUnsignedInt() - 1;
         _loc19_ = _loc16_.MsgTreasure[_loc4_];
         _loc8_ = _loc2_.readShort();
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc19_.RewardDesc[_loc7_] = TUtilityString.FetchUTF(_loc2_);
            _loc7_++;
         }
         _loc19_.Prize = _loc2_.readUnsignedInt();
         _loc19_.NeedScore = _loc2_.readUnsignedInt();
         _loc19_.TreasureStatus = _loc2_.readUnsignedInt();
         _loc8_ = _loc2_.readShort();
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc13_ = new Vector.<uint>();
            _loc14_ = new Vector.<uint>();
            _loc10_ = new TInventories();
            _loc18_ = _loc2_.readUnsignedInt() - 1;
            _loc15_ = _loc19_.TreasureMapBoxList[_loc18_];
            _loc15_.Identify = _loc18_;
            _loc5_ = int(_loc2_.readUnsignedInt());
            _loc12_ = _loc2_.readUnsignedInt();
            _loc11_ = CONST_COMMON.GetItemIDByType(_loc5_,_loc12_,_loc21_);
            _loc13_.push(_loc11_);
            _loc14_.push(_loc2_.readUnsignedInt());
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc10_,_loc13_);
            _loc10_.GetInventoryByIndex(0).Quantity = _loc14_[0];
            _loc15_.Inventories = _loc10_;
            _loc7_++;
         }
         if(this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorOnRewardLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:TLotteryNews = null;
         var _loc11_:Vector.<uint> = null;
         var _loc12_:TInventories = null;
         var _loc13_:TInventory = null;
         var _loc14_:int = 0;
         var _loc15_:TMayActive2 = null;
         var _loc16_:TBins = null;
         _loc2_ = param1.Data;
         _loc16_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc8_ = _loc2_.readInt();
         if(_loc8_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc8_);
            ProcessorClose();
            return;
         }
         _loc5_ = int(_loc2_.readUnsignedInt());
         if(_loc5_ == ACTIVITY_2_ID)
         {
            _loc15_ = this.FMayActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TMayActive2;
            _loc3_ = int(_loc2_.readUnsignedShort());
            this.FProcessorWindowMayActiveLog.LogList.length = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc10_ = new TLotteryNews();
               _loc10_.GetSource = TUtilityString.FetchUTF(_loc2_);
               _loc5_ = int(_loc2_.readUnsignedInt());
               _loc11_ = new Vector.<uint>();
               _loc6_ = int(_loc2_.readUnsignedInt());
               _loc9_ = int(CONST_COMMON.GetItemIDByType(_loc5_,_loc6_,_loc16_));
               _loc11_.push(_loc9_);
               _loc14_ = int(_loc2_.readUnsignedInt());
               _loc10_.GetTime = _loc2_.readUnsignedInt();
               _loc12_ = new TInventories();
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc12_,_loc11_);
               _loc13_ = _loc12_.GetInventoryByIndex(0);
               _loc13_.Quantity = _loc14_;
               _loc10_.Inventories = _loc12_;
               _loc10_.Desc1 = _loc15_.DescListNew[9];
               this.FProcessorWindowMayActiveLog.LogList.push(_loc10_);
               _loc4_++;
            }
            if(FIsResourcesLoadCompleted && this.visible)
            {
               this.FProcessorWindowMayActiveLog.Visible = true;
               this.FProcessorWindowMayActiveLog.UpdateUI();
            }
         }
      }
      
      override public function ProcessorActivityThirdLoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:TLotteryNews = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:Vector.<uint> = null;
         var _loc16_:TBins = null;
         var _loc17_:TBaseActivity = null;
         var _loc18_:int = 0;
         var _loc19_:TSystemLanguage = null;
         var _loc20_:int = 0;
         _loc16_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         _loc18_ = int(_loc2_.readUnsignedInt());
         _loc17_ = this.FMayActiveDatas.GetActivityByIdentify(_loc18_);
         _loc5_ = _loc2_.readShort();
         _loc17_.LogList.length = 0;
         _loc5_ = _loc2_.readShort();
         _loc14_ = new Vector.<uint>();
         _loc15_ = new Vector.<uint>();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc10_ = new TLotteryNews();
            _loc14_.length = 0;
            _loc15_.length = 0;
            _loc7_ = int(_loc2_.readUnsignedShort());
            _loc6_ = 0;
            while(_loc6_ < _loc7_ / 5)
            {
               _loc12_ = _loc2_.readUnsignedInt();
               _loc11_ = _loc2_.readUnsignedInt();
               _loc13_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc16_);
               _loc14_.push(_loc13_);
               _loc15_.push(_loc2_.readUnsignedInt());
               _loc10_.GetTime = _loc2_.readUnsignedInt();
               _loc20_ = int(_loc2_.readUnsignedInt());
               _loc19_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,_loc20_) as TSystemLanguage;
               if((Boolean(_loc19_)) && _loc19_.Desc != null)
               {
                  _loc10_.GetSource = _loc19_.Desc;
               }
               else
               {
                  _loc10_.GetSource = "";
               }
               _loc6_++;
            }
            _loc9_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc14_);
            _loc8_ = _loc9_.GetInventoryByIndex(0);
            _loc8_.Quantity = _loc15_[0];
            _loc10_.Inventory = _loc8_;
            _loc10_.Inventories = _loc9_;
            _loc17_.LogList.push(_loc10_);
            _loc4_++;
         }
         FProcessorWindowLog.BaseActivity = _loc17_;
         FProcessorWindowLog.UpdateUI();
         FProcessorWindowLog.Visible = true;
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TMayActive1 = null;
         var _loc9_:TMayActive2 = null;
         var _loc10_:TMayActive3 = null;
         var _loc11_:TMayActive4 = null;
         var _loc12_:Vector.<int> = null;
         var _loc13_:int = 0;
         var _loc14_:TBaseBox = null;
         var _loc15_:TConfigValue = null;
         var _loc16_:Vector.<Object> = null;
         var _loc17_:int = 0;
         var _loc18_:String = null;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         _loc5_ = _loc2_.readInt();
         switch(_loc5_)
         {
            case ACTIVITY_1_ID:
               _loc8_ = this.FMayActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TMayActive1;
               _loc5_ = int(_loc2_.readUnsignedInt());
               _loc8_.CanReturn = _loc2_.readUnsignedInt();
               if(Boolean(FMC_Scene) && this.visible)
               {
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_2_ID:
               _loc9_ = this.FMayActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TMayActive2;
               break;
            case ACTIVITY_3_ID:
               _loc10_ = this.FMayActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TMayActive3;
               if(_loc10_)
               {
                  _loc13_ = int(_loc2_.readUnsignedInt());
                  if(_loc13_ == 1)
                  {
                     _loc10_.APValue = _loc2_.readUnsignedInt();
                     _loc10_.MPValue = _loc2_.readUnsignedInt();
                  }
                  else if(_loc13_ == 2)
                  {
                     _loc10_.CurBoss.Min = _loc2_.readUnsignedInt();
                  }
                  else if(_loc13_ == 3)
                  {
                     _loc14_ = new TBaseBox();
                     _loc10_.BossIsAppear = 1;
                     _loc10_.BossAppearTime = _loc2_.readUnsignedInt();
                     _loc14_.Type = _loc2_.readUnsignedInt();
                     _loc14_.Min = _loc2_.readUnsignedInt();
                     _loc14_.Max = _loc2_.readUnsignedInt();
                     _loc14_.Price = _loc2_.readUnsignedInt();
                     _loc10_.CurBoss = _loc14_;
                     ProcessorCheckEffect(FActivityID,true);
                  }
                  else if(_loc13_ == 4)
                  {
                     _loc10_.BossIsAppear = 0;
                     _loc10_.BossAppearTime = _loc2_.readUnsignedInt();
                  }
               }
               if(Boolean(FMC_Scene) && this.visible)
               {
                  if(this.FUIWindowVect[2].IsPlaying)
                  {
                     setTimeout(this.UpdateUI,1000);
                  }
                  else
                  {
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_4_ID:
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
         var _loc12_:int = 0;
         var _loc13_:uint = 0;
         var _loc14_:TBaseBox = null;
         var _loc15_:uint = 0;
         var _loc16_:TBins = null;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:Vector.<Object> = null;
         var _loc22_:Vector.<uint> = null;
         var _loc23_:Vector.<uint> = null;
         var _loc24_:Vector.<int> = null;
         var _loc25_:TConfigValue = null;
         var _loc26_:TMayActive1 = null;
         var _loc27_:TMayActive2 = null;
         var _loc28_:TMayActive3 = null;
         var _loc29_:TMayActive4 = null;
         var _loc30_:int = 0;
         var _loc31_:int = 0;
         var _loc32_:int = 0;
         var _loc33_:String = null;
         var _loc34_:String = null;
         var _loc35_:TUIMayActive2 = null;
         var _loc36_:int = 0;
         var _loc37_:int = 0;
         var _loc38_:TMsgTreasure = null;
         var _loc39_:uint = 0;
         var _loc40_:TMsgGraph = null;
         var _loc41_:int = 0;
         var _loc42_:int = 0;
         _loc16_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc25_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.DROP_ITEM_NAME) as TConfigValue;
         _loc21_ = _loc25_.Value as Vector.<Object>;
         _loc7_ = int(_loc2_.readUnsignedInt());
         switch(_loc7_)
         {
            case ACTIVITY_1_ID:
               _loc17_ = _loc2_.readShort();
               _loc26_ = this.FMayActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TMayActive1;
               _loc24_ = new Vector.<int>();
               _loc5_ = 0;
               while(_loc5_ < _loc17_)
               {
                  _loc24_.push(_loc2_.readUnsignedInt());
                  _loc5_++;
               }
               _loc30_ = _loc24_[1];
               _loc31_ = _loc24_[2];
               _loc26_.BoxList[_loc30_].Status = _loc31_;
               _loc26_.ChangeSignStatus();
               _loc14_ = _loc26_.BoxList[_loc30_];
               _loc9_ = _loc14_.Inventories.GetInventoryByIndex(0);
               _loc33_ = TUtilityString.Format(_loc26_.DescListNew[5],_loc9_.Name);
               if(SLogicsCore.Character.VipLevel >= _loc14_.Level && _loc14_.Level > 0)
               {
                  _loc33_ += "\n" + TUtilityString.Format(_loc26_.DescListNew[6],_loc9_.Name);
               }
               if(_loc31_ == TBaseActivity.STATUS_CANGET)
               {
                  this.FUIWindowInformation.Text = _loc33_;
                  this.FUIWindowInformation.Visible = true;
               }
               this.FMayActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
               ProcessorCheckEffect(FActivityID,this.FMayActiveDatas.CheckStatus());
               if(Boolean(FMC_Scene) && this.visible)
               {
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_2_ID:
               _loc2_.readShort();
               _loc10_ = _loc2_.readUnsignedInt();
               _loc27_ = this.FMayActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TMayActive2;
               if(_loc10_ == ACTIVITY_2_START)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc27_.MsgTreasure[_loc5_].TreasureStatus = TBaseActivity.STATUS_IS_GOT;
                  _loc38_ = _loc27_.MsgTreasure[_loc5_];
                  _loc27_.TreasureMapCount[_loc5_] -= _loc38_.NeedScore;
                  _loc17_ = int(_loc38_.TreasureMapBoxList.length);
                  _loc5_ = 0;
                  while(_loc5_ < _loc17_)
                  {
                     _loc38_.TreasureMapBoxList[_loc5_].Inventories.Clear();
                     _loc38_.TreasureMapBoxList[_loc5_].Inventories = null;
                     _loc5_++;
                  }
                  this.FUIWindowVect[1].PlayMovie(TUIMayActive2.MOVIE_TYPE_SHUFFLE);
               }
               else if(_loc10_ == ACTVITTY_2_SEARCH)
               {
                  _loc22_ = new Vector.<uint>();
                  _loc23_ = new Vector.<uint>();
                  _loc8_ = new TInventories();
                  if(_loc27_.FreeTreasureMap > 0)
                  {
                     --_loc27_.FreeTreasureMap;
                  }
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc38_ = _loc27_.MsgTreasure[_loc5_];
                  _loc6_ = _loc2_.readUnsignedInt() - 1;
                  _loc14_ = _loc38_.TreasureMapBoxList[_loc6_];
                  _loc10_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc39_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                  _loc22_.push(_loc39_);
                  _loc23_.push(_loc2_.readUnsignedInt());
                  this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc22_);
                  _loc8_.GetInventoryByIndex(0).Quantity = _loc23_[0];
                  _loc14_.Inventories = _loc8_;
                  _loc33_ = TUtilityString.Format(_loc27_.DescListNew[5],_loc14_.Inventories.GetInventoryByIndex(0).Name,_loc14_.Inventories.GetInventoryByIndex(0).Quantity);
                  ProcessorEffectText(_loc33_);
                  _loc36_ = int(_loc2_.readUnsignedInt());
                  _loc37_ = int(_loc2_.readUnsignedInt());
                  _loc40_ = _loc27_.SeekTreasureMapBoxList[_loc5_];
                  _loc41_ = int(_loc2_.readUnsignedInt());
                  if(_loc41_ > _loc40_.CurStep && _loc41_ > 0)
                  {
                     _loc14_ = _loc40_.TreasureBoxList[_loc41_ - 1];
                     if(_loc14_ != null && _loc14_.Inventories != null)
                     {
                        _loc33_ = TUtilityString.Format(_loc27_.DescListNew[7],_loc14_.Inventories.GetInventoryByIndex(0).Name,_loc14_.Inventories.GetInventoryByIndex(0).Quantity);
                        ProcessorEffectText(_loc33_);
                     }
                  }
                  _loc40_.CurStep = _loc41_;
                  _loc27_.SeekTreasureStatue = _loc2_.readUnsignedInt();
                  _loc27_.SeekTreasureCount = _loc2_.readUnsignedInt();
                  if(_loc27_.SeekTreasureCount == 5)
                  {
                     _loc6_ = 0;
                     while(_loc6_ < _loc27_.TreasureMapBoxList.length)
                     {
                        _loc27_.TreasureMapBoxList[_loc6_] = new TBaseBox();
                        _loc6_++;
                     }
                  }
                  this.UpdateUI();
                  if(_loc36_ != TBaseActivity.STATUS_IS_GOT)
                  {
                     this.FUIWindowVect[1].SetMovieParam(_loc5_,_loc36_,_loc37_);
                  }
                  if(_loc36_ == TBaseActivity.STATUS_CANGET)
                  {
                     _loc22_ = new Vector.<uint>();
                     _loc23_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc38_.TreasureMapBoxList[0];
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc39_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc22_.push(_loc39_);
                     _loc23_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc22_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc23_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc22_ = new Vector.<uint>();
                     _loc23_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc38_.TreasureMapBoxList[1];
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc39_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc22_.push(_loc39_);
                     _loc23_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc22_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc23_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc22_ = new Vector.<uint>();
                     _loc23_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc38_.TreasureMapBoxList[2];
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc39_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc22_.push(_loc39_);
                     _loc23_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc22_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc23_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc22_ = new Vector.<uint>();
                     _loc23_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc38_.TreasureMapBoxList[3];
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc39_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc22_.push(_loc39_);
                     _loc23_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc22_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc23_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc22_ = new Vector.<uint>();
                     _loc23_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc38_.TreasureMapBoxList[4];
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc39_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc22_.push(_loc39_);
                     _loc23_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc22_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc23_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc22_ = new Vector.<uint>();
                     _loc23_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc38_.TreasureMapBoxList[5];
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc39_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc22_.push(_loc39_);
                     _loc23_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc22_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc23_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc22_ = new Vector.<uint>();
                     _loc23_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc38_.TreasureMapBoxList[6];
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc39_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc22_.push(_loc39_);
                     _loc23_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc22_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc23_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc22_ = new Vector.<uint>();
                     _loc23_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc38_.TreasureMapBoxList[7];
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc39_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc22_.push(_loc39_);
                     _loc23_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc22_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc23_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc22_ = new Vector.<uint>();
                     _loc23_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc38_.TreasureMapBoxList[8];
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc39_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc22_.push(_loc39_);
                     _loc23_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc22_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc23_[0];
                     _loc14_.Inventories = _loc8_;
                  }
                  if(_loc37_ == TBaseActivity.STATUS_CANGET)
                  {
                     _loc22_ = new Vector.<uint>();
                     _loc23_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = new TBaseBox();
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc39_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc22_.push(_loc39_);
                     _loc23_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc22_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc23_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc33_ = TUtilityString.Format(_loc27_.DescListNew[6],_loc14_.Inventories.GetInventoryByIndex(0).Name,_loc14_.Inventories.GetInventoryByIndex(0).Quantity);
                     ProcessorEffectText(_loc33_);
                  }
               }
               else if(_loc10_ == ACTVITTY_2_GIVE_UP)
               {
                  _loc5_ = int(_loc2_.readUnsignedInt());
                  _loc36_ = int(_loc2_.readUnsignedInt());
                  _loc38_ = _loc27_.MsgTreasure[_loc5_ - 1];
                  _loc38_.TreasureStatus = _loc36_;
                  if(_loc36_ == TBaseActivity.STATUS_CANGET)
                  {
                     _loc17_ = 9;
                     _loc6_ = 0;
                     while(_loc6_ < _loc17_)
                     {
                        _loc22_ = new Vector.<uint>();
                        _loc23_ = new Vector.<uint>();
                        _loc8_ = new TInventories();
                        _loc14_ = _loc38_.TreasureMapBoxList[_loc6_];
                        _loc10_ = _loc2_.readUnsignedInt();
                        _loc11_ = _loc2_.readUnsignedInt();
                        _loc39_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                        _loc22_.push(_loc39_);
                        _loc23_.push(_loc2_.readUnsignedInt());
                        this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc22_);
                        _loc8_.GetInventoryByIndex(0).Quantity = _loc23_[0];
                        _loc14_.Inventories = _loc8_;
                        _loc6_++;
                     }
                  }
                  this.FUIWindowVect[1].PlayMovie(TUIMayActive2.MOVIE_TYPE_REFRESH);
               }
               else if(_loc10_ == ACTVITTY_2_FREE_REFRESH)
               {
                  _loc27_.RefreshBuyTime = _loc2_.readUnsignedInt();
                  _loc17_ = 3;
                  _loc6_ = 0;
                  while(_loc6_ < _loc17_)
                  {
                     _loc22_ = new Vector.<uint>();
                     _loc23_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc27_.BuyTreasureMapBoxList[_loc6_];
                     _loc14_.Price = _loc2_.readUnsignedInt();
                     _loc14_.Status = TBaseActivity.STATUS_CANNOTGET;
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc39_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc22_.push(_loc39_);
                     _loc23_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc22_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc23_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc6_++;
                  }
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_GOLD_REFRESH)
               {
                  _loc17_ = 3;
                  _loc6_ = 0;
                  while(_loc6_ < _loc17_)
                  {
                     _loc22_ = new Vector.<uint>();
                     _loc23_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc27_.BuyTreasureMapBoxList[_loc6_];
                     _loc14_.Price = _loc2_.readUnsignedInt();
                     _loc14_.Status = TBaseActivity.STATUS_CANNOTGET;
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc39_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc22_.push(_loc39_);
                     _loc23_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc22_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc23_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc6_++;
                  }
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_REFRESH_SUCCESSED);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTVITTY_2_BUY_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc6_ = _loc2_.readUnsignedInt() - 1;
                  _loc9_ = _loc27_.BuyTreasureMapBoxList[_loc5_].Inventories.GetInventoryByIndex(0);
                  _loc27_.TreasureMapCount[_loc6_] += _loc9_.Quantity;
                  _loc27_.BuyTreasureMapBoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTVITTY_2_SEEK_BOX)
               {
                  _loc22_ = new Vector.<uint>();
                  _loc23_ = new Vector.<uint>();
                  _loc8_ = new TInventories();
                  _loc5_ = int(_loc2_.readUnsignedInt());
                  _loc14_ = new TBaseBox();
                  _loc27_.TreasureMapBoxList[_loc5_ - 1] = _loc14_;
                  _loc10_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc39_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                  _loc22_.push(_loc39_);
                  _loc23_.push(_loc2_.readUnsignedInt());
                  this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc22_);
                  _loc8_.GetInventoryByIndex(0).Quantity = _loc23_[0];
                  _loc14_.Inventories = _loc8_;
                  if(_loc27_.SeekTreasureCount > 0)
                  {
                     --_loc27_.SeekTreasureCount;
                  }
                  _loc33_ = TUtilityString.Format(_loc27_.DescListNew[10],_loc14_.Inventories.GetInventoryByIndex(0).Name,_loc14_.Inventories.GetInventoryByIndex(0).Quantity);
                  ProcessorEffectText(_loc33_);
                  if(_loc27_.SeekTreasureCount == TBaseActivity.STATUS_CANNOTGET)
                  {
                     _loc17_ = int(_loc27_.SeekTreasureMapBoxList.length);
                     _loc5_ = 0;
                     while(_loc5_ < _loc17_)
                     {
                        _loc27_.SeekTreasureMapBoxList[_loc5_].GraphStatus = TBaseActivity.STATUS_CANNOTGET;
                        _loc27_.SeekTreasureMapBoxList[_loc5_].CurStep = 0;
                        _loc5_++;
                     }
                     _loc17_ = int(_loc27_.TreasureMapBoxList.length);
                     _loc5_ = 0;
                     while(_loc5_ < _loc17_)
                     {
                        if(_loc27_.TreasureMapBoxList[_loc5_].Inventories)
                        {
                           _loc27_.TreasureMapBoxList[_loc5_].Inventories.Clear();
                        }
                        _loc5_++;
                     }
                  }
                  this.UpdateUI();
                  this.FUIWindowVect[1].PlayMovie(TUIMayActive2.MOVIE_TYPE_HAMMER);
               }
               break;
            case ACTIVITY_3_ID:
               _loc2_.readShort();
               _loc10_ = _loc2_.readUnsignedInt();
               _loc28_ = this.FMayActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TMayActive3;
               if(_loc10_ == ACTIVITY_3_BUY_SOLDIER)
               {
                  _loc30_ = int(_loc2_.readUnsignedInt());
                  _loc5_ = int(_loc2_.readUnsignedInt());
                  _loc17_ = int(_loc28_.SoldierList.length);
                  _loc6_ = 0;
                  while(_loc6_ < _loc17_)
                  {
                     _loc28_.SoldierList[_loc6_].Status = TBaseActivity.STATUS_CANNOTGET;
                     _loc6_++;
                  }
                  _loc28_.SoldierList[_loc5_ - 1].Status = TBaseActivity.STATUS_GETED;
                  _loc14_ = new TBaseBox();
                  _loc14_.Type = _loc5_;
                  _loc14_.Time = _loc2_.readUnsignedInt();
                  _loc14_.Level = _loc2_.readUnsignedInt();
                  _loc28_.MySoldier = _loc14_;
                  ProcessorEffectText(_loc28_.DescListNew[5]);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_ADD_AP)
               {
                  _loc28_.APValue = _loc2_.readUnsignedInt();
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_ADD_MP)
               {
                  _loc28_.MPValue = _loc2_.readUnsignedInt();
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_GET_GIFT)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  --_loc28_.GiftList[_loc5_].Count;
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
                  this.UpdateUI();
                  this.FMayActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FMayActiveDatas.CheckStatus());
               }
               else if(_loc10_ == ACTIVITY_3_ATTACK_MONSTER)
               {
                  _loc14_ = _loc28_.CurMonster;
                  _loc30_ = _loc28_.MyPower + _loc28_.MySoldier.Level;
                  _loc28_.MPValue -= _loc30_;
                  _loc30_ = int(_loc2_.readUnsignedInt());
                  _loc4_ = TUtilityString.Format(_loc28_.DescListNew[11],_loc30_) + "\n";
                  _loc14_.Min -= _loc30_;
                  if(_loc14_.Min <= 0)
                  {
                     ++_loc28_.KillCount;
                     ++_loc28_.KillReward[0].Count;
                  }
                  _loc13_ = _loc2_.readUnsignedInt();
                  _loc28_.RankPoint += _loc13_;
                  if(_loc13_ > 0)
                  {
                     _loc4_ += STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                     _loc4_ = _loc4_ + (_loc21_[ACTIVITY_3_DROP_ITEM_INDEX] + "*" + _loc13_ + "\n");
                  }
                  _loc31_ = _loc2_.readUnsignedInt() - 1;
                  if(_loc31_ != -1)
                  {
                     ++_loc28_.GiftList[_loc31_].Count;
                     _loc4_ += _loc28_.DescListNew[22];
                  }
                  this.FUIWindowVect[2].SetMovieParam(_loc31_);
                  ProcessorEffectText(_loc4_);
                  _loc5_ = 0;
                  while(_loc5_ < _loc28_.BoxList.length)
                  {
                     _loc28_.BoxList[_loc5_].Status = _loc2_.readInt();
                     _loc5_++;
                  }
                  _loc28_.ChangeStatus();
                  this.FUIWindowVect[2].PlayMovie(TUIMayActive3.MOVIE_TYPE_BEAT_MONSTER);
                  this.FMayActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FMayActiveDatas.CheckStatus());
               }
               else if(_loc10_ == ACTIVITY_3_ATTACK_BOSS)
               {
                  _loc28_.BossIsAppear = _loc2_.readUnsignedInt();
                  _loc14_ = _loc28_.CurBoss;
                  _loc13_ = _loc28_.MyPower + _loc28_.MySoldier.Level;
                  _loc28_.MPValue -= _loc13_;
                  _loc30_ = int(_loc2_.readUnsignedInt());
                  _loc32_ = int(_loc2_.readUnsignedInt());
                  _loc4_ = TUtilityString.Format(_loc28_.DescListNew[11],_loc32_) + "\n";
                  _loc14_.Min = _loc30_;
                  if(_loc14_.Min <= 0)
                  {
                     ++_loc28_.KillReward[1].Count;
                  }
                  _loc13_ = _loc2_.readUnsignedInt();
                  _loc28_.RankPoint += _loc13_;
                  if(_loc13_ > 0)
                  {
                     _loc4_ += STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                     _loc4_ = _loc4_ + (_loc21_[ACTIVITY_3_DROP_ITEM_INDEX] + "*" + _loc13_ + "\n");
                  }
                  _loc31_ = _loc2_.readUnsignedInt() - 1;
                  if(_loc31_ != -1)
                  {
                     ++_loc28_.GiftList[_loc31_].Count;
                     _loc4_ += _loc28_.DescListNew[22];
                  }
                  this.FUIWindowVect[2].SetMovieParam(_loc31_);
                  ProcessorEffectText(_loc4_);
                  _loc5_ = 0;
                  while(_loc5_ < _loc28_.BoxList.length)
                  {
                     _loc28_.BoxList[_loc5_].Status = _loc2_.readInt();
                     _loc5_++;
                  }
                  _loc28_.ChangeStatus();
                  this.FUIWindowVect[2].PlayMovie(TUIMayActive3.MOVIE_TYPE_BEAT_BOSS);
                  this.FMayActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FMayActiveDatas.CheckStatus());
               }
               else if(_loc10_ == ACTIVITY_3_GOTO_NEW_MAP)
               {
                  _loc28_.APValue = _loc2_.readUnsignedInt();
                  _loc14_ = new TBaseBox();
                  _loc14_.Type = _loc2_.readUnsignedInt();
                  if(_loc14_.Type != 0)
                  {
                     _loc14_.Min = _loc2_.readUnsignedInt();
                     _loc14_.Max = _loc2_.readUnsignedInt();
                     _loc14_.Price = _loc2_.readUnsignedInt();
                     _loc31_ = -1;
                  }
                  else
                  {
                     _loc31_ = _loc2_.readUnsignedInt() - 1;
                     if(_loc31_ != -1)
                     {
                        ++_loc28_.GiftList[_loc31_].Count;
                        ProcessorEffectText(_loc28_.DescListNew[22]);
                     }
                     else if(_loc28_.DescList.length >= 20)
                     {
                        ProcessorEffectText(_loc28_.DescListNew[19]);
                     }
                  }
                  this.FUIWindowVect[2].SetMovieParam(_loc31_);
                  _loc28_.CurMonster = _loc14_;
                  this.FUIWindowVect[2].PlayMovie(TUIMayActive3.MOVIE_GOTO_NEW_MAP);
                  this.FMayActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FMayActiveDatas.CheckStatus());
               }
               else if(_loc10_ == ACTIVITY_3_GET_KILL_MONSTER_BOX)
               {
                  _loc14_ = _loc28_.KillReward[0];
                  _loc14_.Count -= _loc14_.Price;
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
                  this.FMayActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FMayActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_GET_KILL_BOSS_BOX)
               {
                  _loc14_ = _loc28_.KillReward[1];
                  _loc14_.Count -= _loc14_.Price;
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
                  this.FMayActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FMayActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_GET_SPECIAL_REWARD)
               {
                  _loc28_.SpecialReward[0].Status = TBaseActivity.STATUS_GETED;
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
                  this.FMayActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FMayActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_GET_BOX)
               {
                  _loc5_ = int(_loc2_.readUnsignedInt());
                  _loc17_ = int(_loc28_.BoxList.length);
                  _loc6_ = 0;
                  while(_loc6_ < _loc17_)
                  {
                     _loc28_.BoxList[_loc6_].Status = _loc2_.readInt();
                     _loc6_++;
                  }
                  _loc28_.RewardRound = _loc2_.readUnsignedInt();
                  this.FMayActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
                  ProcessorCheckEffect(FActivityID,this.FMayActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_FIRE_SOLDIER)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc28_.MySoldier.Type = 0;
                  _loc28_.MySoldier.Level = 0;
                  _loc28_.MySoldier.Time = 0;
                  _loc28_.SoldierList[_loc5_].Status = TBaseActivity.STATUS_CANNOTGET;
                  ProcessorEffectText(_loc28_.DescListNew[17]);
                  ProcessorCheckEffect(FActivityID,this.FMayActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_4_ID:
               _loc2_.readShort();
               _loc10_ = _loc2_.readUnsignedInt();
               _loc29_ = this.FMayActiveDatas.GetActivityByIdentify(ACTIVITY_4_ID) as TMayActive4;
               if(_loc10_ == ACTIVITY_4_GET_SWEET)
               {
                  if(_loc29_.Count > 0)
                  {
                     --_loc29_.Count;
                  }
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc13_ = _loc2_.readUnsignedInt();
                  _loc29_.Score += _loc13_;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  if(_loc13_ > 0)
                  {
                     _loc4_ += _loc21_[ACTIVITY_4_DROP_ITEM_INDEX] + "*" + _loc13_ + "\n";
                  }
                  _loc13_ = _loc2_.readUnsignedInt();
                  if(_loc13_ > 0)
                  {
                     _loc4_ += _loc21_[ACTIVITY_3_DROP_ITEM_INDEX] + "*" + _loc13_ + "\n";
                  }
                  _loc5_ = 0;
                  while(_loc5_ < _loc29_.SweetList.length)
                  {
                     _loc29_.SweetList[_loc5_].Status = _loc2_.readInt();
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc29_.ChangeStatus();
                  this.FMayActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FMayActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_4_GET_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc14_ = _loc29_.BoxList[_loc5_];
                  --_loc14_.LimitCount;
                  _loc29_.Score -= _loc14_.Price;
                  _loc8_ = _loc29_.BoxList[_loc5_].Inventories;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_4_GET_HERO)
               {
                  _loc14_ = _loc29_.HeroList[0];
                  _loc14_.Status = TBaseActivity.STATUS_GETED;
                  _loc29_.Score -= _loc14_.Price;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  ProcessorEffectText(_loc4_);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_4_GET_TEN)
               {
                  _loc29_.Amount1List.length = 0;
                  _loc29_.Amount2List.length = 0;
                  _loc29_.IndexList.length = 0;
                  _loc29_.StatusList.length = 0;
                  _loc5_ = 0;
                  while(_loc5_ < 10)
                  {
                     _loc29_.Amount1List[_loc5_] = _loc2_.readUnsignedInt();
                     _loc29_.Amount2List[_loc5_] = _loc2_.readUnsignedInt();
                     _loc29_.IndexList[_loc5_] = _loc2_.readUnsignedInt();
                     _loc29_.StatusList[_loc5_] = _loc2_.readInt();
                     _loc5_++;
                  }
                  if(Boolean(FMC_Scene) && this.visible)
                  {
                     this.FUIWindowVect[3].PlayMovie();
                  }
               }
         }
      }
      
      public function GetBaseBox(param1:TBaseBox, param2:int, param3:int, param4:int, param5:TBins) : void
      {
         var _loc6_:Vector.<uint> = null;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:uint = 0;
         var _loc9_:TInventory = null;
         var _loc10_:TInventories = null;
         _loc8_ = CONST_COMMON.GetItemIDByType(param2,param3,param5);
         _loc6_.push(_loc8_);
         _loc7_.push(param4);
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc10_,_loc6_);
         _loc10_.GetInventoryByIndex(0).Quantity = _loc7_[0];
         param1.Inventories = _loc10_;
      }
      
      public function TestInit2() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([1,1,1,1]);
         var _loc5_:Vector.<int> = Vector.<int>([1,0,0,0]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc3_.writeInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc3_,"描述1");
            _loc3_.writeInt(_loc4_[_loc1_]);
            _loc3_.writeUnsignedInt(STimingCore.GetServerTime());
            _loc3_.writeInt(_loc5_[_loc1_]);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(13);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"雇佣时间剩余%0");
         TUtilityString.FlushUTF(_loc3_,"未雇佣佣兵");
         TUtilityString.FlushUTF(_loc3_,"距离下次刷新剩余%0");
         TUtilityString.FlushUTF(_loc3_,"雇佣成功");
         TUtilityString.FlushUTF(_loc3_,"距离BOSS出现剩余%0");
         TUtilityString.FlushUTF(_loc3_,"距离BOSS消失剩余%0");
         TUtilityString.FlushUTF(_loc3_,"收集%0");
         TUtilityString.FlushUTF(_loc3_,"花费100金币购买10点行动力");
         TUtilityString.FlushUTF(_loc3_,"花费100金币购买10点体力");
         TUtilityString.FlushUTF(_loc3_,"你对怪物造成%0点伤害");
         TUtilityString.FlushUTF(_loc3_,"你获得了神秘礼包");
         _loc3_.writeUnsignedInt(STimingCore.GetServerTime() + 30);
         _loc3_.writeUnsignedInt(30);
         _loc3_.writeUnsignedInt(30);
         _loc3_.writeUnsignedInt(30);
         _loc3_.writeUnsignedInt(20);
         _loc3_.writeUnsignedInt(120);
         _loc3_.writeUnsignedInt(120);
         _loc3_.writeUnsignedInt(30);
         _loc3_.writeUnsignedInt(30);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(STimingCore.GetServerTime() + 30);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(STimingCore.GetServerTime() + 10);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(7);
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeShort(10);
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            TUtilityString.FlushUTF(_loc3_,"AAA");
            TUtilityString.FlushUTF(_loc3_,"BBB");
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeInt(0);
            _loc3_.writeUnsignedInt(10 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.writeShort(7);
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            TUtilityString.FlushUTF(_loc3_,"怪物" + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            TUtilityString.FlushUTF(_loc3_,"AAA");
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            TUtilityString.FlushUTF(_loc3_,"忍者描述");
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeInt(0);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(11210009 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            TUtilityString.FlushUTF(_loc3_,"AAA");
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 10);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            TUtilityString.FlushUTF(_loc3_,"aaa");
            TUtilityString.FlushUTF(_loc3_,"aaa");
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeInt(1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

