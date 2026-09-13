package Processors.Game.Lobby.Exercise.ThanksgivingDay
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
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.ThanksgivingDay.TMsgGraph;
   import Logics.Exercise.ThanksgivingDay.TMsgTreasure;
   import Logics.Exercise.ThanksgivingDay.TThanksgivingDay1;
   import Logics.Exercise.ThanksgivingDay.TThanksgivingDay2;
   import Logics.Exercise.ThanksgivingDay.TThanksgivingDay3;
   import Logics.Exercise.ThanksgivingDay.TThanksgivingDay4;
   import Logics.Exercise.ThanksgivingDay.TThanksgivingDayDatas;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerThanksgivingDay;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Processors.Game.Windows.Information.TUIWindowInformation;
   import Rendering.Overlayers.Box.TOverlayerBox;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorThanksgivingDay extends TProcessorBaseActivity
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
      
      public static const ACTIVITY_2_GET_FREE_BOX:int = 8;
      
      public static const ACTIVITY_3_GET_BOX:int = 1;
      
      public static const ACTIVITY_3_GET_BIG_BOX:int = 2;
      
      public static const ACTIVITY_3_PLAY_DART:int = 3;
      
      public static const ACTIVITY_3_GET_TASK:int = 4;
      
      public static const ACTIVITY_3_FINISH_TASK:int = 5;
      
      public static const ACTIVITY_3_GET_TASK_BOX:int = 6;
      
      public static const ACTIVITY_3_PLAY_DART_TEN:int = 7;
      
      public static const ACTIVITY_4_OPEN_CARD:int = 1;
      
      public static const ACTIVITY_4_OPEN_ALL_CARD:int = 2;
      
      public static const ACTIVITY_4_RESET:int = 3;
      
      public static const ACTIVITY_4_GET_SCORE_BOX:int = 4;
      
      public static const ACTIVITY_4_EXCHANGE_BOX:int = 5;
      
      public static const ACTIVITY_4_EXCHANGE_HERO:int = 6;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      protected var TAB_COUNT:int = 4;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIThanksgivingDay1,TUIThanksgivingDay2,TUIThanksgivingDay3,TUIThanksgivingDay4]);
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FThanksgivingDayDatas:TThanksgivingDayDatas;
      
      protected var FUnstreamizerThanksgivingDay:TUnstreamizerThanksgivingDay;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FBuyBoxDate:Object;
      
      protected var FUIWindowInformation:TUIWindowInformation;
      
      protected var FIsOpen:Boolean;
      
      protected var FProcessorThanksgivingDayRank:TProcessorThanksgivingDayRank;
      
      public function TProcessorThanksgivingDay(param1:TUIComponent, param2:TLobbyParameters, param3:int)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FThanksgivingDayDatas = SLogicsCore.ThanksgivingDayDatas;
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         this.FUnstreamizerThanksgivingDay = new TUnstreamizerThanksgivingDay(param3);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
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
         this.FUIWindowInformation = new TUIWindowInformation(this.Parent);
         this.FProcessorThanksgivingDayRank = new TProcessorThanksgivingDayRank(this.Parent);
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
            this.FUIWindowVect[_loc1_].OnItemOver = UIComponentsHintOnOver;
            this.FUIWindowVect[_loc1_].OnItemOut = UIComponentsHintOnOut;
            this.FUIWindowVect[_loc1_].OnNewBoxOver = ProcessorOnNewBoxOver;
            this.FUIWindowVect[_loc1_].OnNewBoxOut = ProcessorOnNewBoxOut;
            this.FUIWindowVect[_loc1_].OnShowDesc = this.ProcessorOnShowDesc;
            this.FUIWindowVect[_loc1_].OnShowFlowText = ProcessorEffectText;
            this.FUIWindowVect[_loc1_].OnShowHtmlTip = ProcessorOnShowHtmlText;
            this.FUIWindowVect[_loc1_].OnHideHtmlTip = ProcessorOnHideHtmlText;
            this.FUIWindowVect[_loc1_].OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FUIWindowVect[_loc1_].OnLoadLog = this.ProcessorOnLoadLog;
            this.FUIWindowVect[_loc1_].OnLoadRank = this.ProcessorOnLoadRank;
            this.FUIWindowVect[_loc1_].GotoRecharge = ProcessorOnRechargeUp;
            this.FUIWindowVect[_loc1_].OnGoto = ProcessorOnGoto;
            this.FUIWindowVect[_loc1_].OnCloseWindow = this.ProcessorOnCloseWindow;
            _loc1_++;
         }
         this.FUIWindowInformation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowInformation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowInformation.WindowHeight) / 2 - 30;
         TUtilityUIWindow.SetupWindowInformation(this.FUIWindowInformation);
         this.FProcessorThanksgivingDayRank.OnCloseUp = this.ProcessorOnCloseRank;
         this.FProcessorThanksgivingDayRank.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorThanksgivingDayRank.OnOut = UIComponentsHintOnOut;
         this.FProcessorThanksgivingDayRank.TitleHintOnOver = ProcessorOnTitleEffectOver;
         this.FProcessorThanksgivingDayRank.TitleHintOnOut = ProcessorOnTitleEffectOut;
         this.FProcessorThanksgivingDayRank.Visible = false;
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
            _loc3_ = this.FThanksgivingDayDatas.GetActivityByIndex(_loc1_);
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
            if(this.FThanksgivingDayDatas.Activities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
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
         _loc3_ = this.FThanksgivingDayDatas.GetActivityByIndex(_loc2_);
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
         _loc3_ = this.FThanksgivingDayDatas.GetActivityByIndex(_loc2_);
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
      
      protected function ProcessorOnShowDesc() : void
      {
         FProcessorWindowDesc.BaseActivity = this.FThanksgivingDayDatas.GetActivityByIndex(this.FChangeTabIndex);
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnLoadLog(param1:int) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(param1,null);
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
      
      protected function ProcessorOnLoadRank() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SpringFestival_LoadRankInfoReq);
         _loc1_.Data.writeUnsignedInt(FActivityID);
         _loc1_.Data.writeUnsignedInt(this.FChangeTabIndex + 1);
         _loc1_.Data.writeShort(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOnCloseRank() : void
      {
         this.FProcessorThanksgivingDayRank.Visible = false;
      }
      
      private function WindowInformationOnOK(param1:Object) : void
      {
         this.FUIWindowInformation.Visible = false;
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRecruit.Load();
            this.FUIWindowInformation.Load();
            this.FProcessorThanksgivingDayRank.Load();
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
         this.FUnstreamizerThanksgivingDay.Unstreamize(_loc2_,this.FThanksgivingDayDatas,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
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
         var _loc12_:TThanksgivingDay3 = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc11_ = int(_loc2_.readUnsignedInt());
         _loc12_ = this.FThanksgivingDayDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TThanksgivingDay3;
         _loc2_.readUnsignedShort();
         if(_loc12_)
         {
            _loc12_.RankRewardList.length = 0;
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
               _loc12_.RankRewardList.push(_loc7_);
               _loc4_++;
            }
            _loc12_.RankList.length = 0;
            _loc5_ = int(_loc2_.readUnsignedShort());
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc6_ = new TConsumeRankInfo();
               _loc6_.UserName = TUtilityString.FetchUTF(_loc2_);
               _loc6_.ServerName = TUtilityString.FetchUTF(_loc2_);
               _loc6_.Rank = _loc2_.readUnsignedInt();
               _loc6_.Score = _loc2_.readUnsignedInt();
               _loc12_.RankList.push(_loc6_);
               _loc4_++;
            }
         }
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.FProcessorThanksgivingDayRank.Visible = true;
            this.FProcessorThanksgivingDayRank.UpdateUI();
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
         _loc5_ = this.FThanksgivingDayDatas.GetActivityByIdentify(_loc4_) as TBaseActivity;
         ProcessorUnstreamActivityLog(_loc5_,_loc2_);
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
         var _loc16_:TThanksgivingDay2 = null;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:TMsgTreasure = null;
         var _loc20_:TMsgGraph = null;
         var _loc21_:TBins = null;
         _loc21_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc2_ = param1.Data;
         _loc16_ = this.FThanksgivingDayDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TThanksgivingDay2;
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
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TThanksgivingDay1 = null;
         var _loc9_:TThanksgivingDay2 = null;
         var _loc10_:TThanksgivingDay3 = null;
         var _loc11_:TThanksgivingDay4 = null;
         var _loc12_:Vector.<int> = null;
         var _loc13_:int = 0;
         var _loc14_:TBaseBox = null;
         var _loc15_:TConfigValue = null;
         var _loc16_:int = 0;
         var _loc17_:String = null;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         _loc5_ = _loc2_.readInt();
         switch(_loc5_)
         {
            case ACTIVITY_1_ID:
               _loc8_ = this.FThanksgivingDayDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TThanksgivingDay1;
               _loc5_ = int(_loc2_.readUnsignedInt());
               _loc8_.CanReturn = _loc2_.readUnsignedInt();
               if(Boolean(FMC_Scene) && this.visible)
               {
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_2_ID:
               _loc9_ = this.FThanksgivingDayDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TThanksgivingDay2;
               break;
            case ACTIVITY_3_ID:
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
         var _loc21_:Vector.<uint> = null;
         var _loc22_:Vector.<uint> = null;
         var _loc23_:Vector.<int> = null;
         var _loc24_:TConfigValue = null;
         var _loc25_:TThanksgivingDay1 = null;
         var _loc26_:TThanksgivingDay2 = null;
         var _loc27_:TThanksgivingDay3 = null;
         var _loc28_:TThanksgivingDay4 = null;
         var _loc29_:int = 0;
         var _loc30_:int = 0;
         var _loc31_:int = 0;
         var _loc32_:String = null;
         var _loc33_:String = null;
         var _loc34_:TUIThanksgivingDay2 = null;
         var _loc35_:int = 0;
         var _loc36_:int = 0;
         var _loc37_:TMsgTreasure = null;
         var _loc38_:uint = 0;
         var _loc39_:TMsgGraph = null;
         var _loc40_:int = 0;
         var _loc41_:int = 0;
         var _loc42_:TDessertHouseTask = null;
         _loc16_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         switch(_loc7_)
         {
            case ACTIVITY_1_ID:
               _loc17_ = _loc2_.readShort();
               _loc25_ = this.FThanksgivingDayDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TThanksgivingDay1;
               _loc23_ = new Vector.<int>();
               _loc5_ = 0;
               while(_loc5_ < _loc17_)
               {
                  _loc23_.push(_loc2_.readUnsignedInt());
                  _loc5_++;
               }
               _loc29_ = _loc23_[1];
               _loc30_ = _loc23_[2];
               _loc25_.BoxList[_loc29_].Status = _loc30_;
               _loc25_.ChangeSignStatus();
               _loc14_ = _loc25_.BoxList[_loc29_];
               _loc9_ = _loc14_.Inventories.GetInventoryByIndex(0);
               _loc32_ = TUtilityString.Format(_loc25_.DescListNew[5],_loc9_.Name);
               if(SLogicsCore.Character.VipLevel >= _loc14_.Level && _loc14_.Level > 0)
               {
                  _loc32_ += "\n" + TUtilityString.Format(_loc25_.DescListNew[6],_loc9_.Name);
               }
               if(_loc30_ == TBaseActivity.STATUS_CANGET)
               {
                  this.FUIWindowInformation.Text = _loc32_;
                  this.FUIWindowInformation.Visible = true;
               }
               this.FThanksgivingDayDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
               ProcessorCheckEffect(FActivityID,this.FThanksgivingDayDatas.CheckStatus());
               if(Boolean(FMC_Scene) && this.visible)
               {
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_2_ID:
               _loc2_.readShort();
               _loc10_ = _loc2_.readUnsignedInt();
               _loc26_ = this.FThanksgivingDayDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TThanksgivingDay2;
               if(_loc10_ == ACTIVITY_2_START)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc26_.MsgTreasure[_loc5_].TreasureStatus = TBaseActivity.STATUS_IS_GOT;
                  _loc37_ = _loc26_.MsgTreasure[_loc5_];
                  _loc26_.TreasureMapCount[_loc5_] -= _loc37_.NeedScore;
                  _loc17_ = int(_loc37_.TreasureMapBoxList.length);
                  _loc5_ = 0;
                  while(_loc5_ < _loc17_)
                  {
                     _loc37_.TreasureMapBoxList[_loc5_].Inventories.Clear();
                     _loc37_.TreasureMapBoxList[_loc5_].Inventories = null;
                     _loc5_++;
                  }
                  this.FUIWindowVect[1].PlayMovie(TUIThanksgivingDay2.MOVIE_TYPE_SHUFFLE);
               }
               else if(_loc10_ == ACTVITTY_2_SEARCH)
               {
                  _loc21_ = new Vector.<uint>();
                  _loc22_ = new Vector.<uint>();
                  _loc8_ = new TInventories();
                  if(_loc26_.FreeTreasureMap > 0)
                  {
                     --_loc26_.FreeTreasureMap;
                  }
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc37_ = _loc26_.MsgTreasure[_loc5_];
                  _loc6_ = _loc2_.readUnsignedInt() - 1;
                  _loc14_ = _loc37_.TreasureMapBoxList[_loc6_];
                  _loc10_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc38_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                  _loc21_.push(_loc38_);
                  _loc22_.push(_loc2_.readUnsignedInt());
                  this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc21_);
                  _loc8_.GetInventoryByIndex(0).Quantity = _loc22_[0];
                  _loc14_.Inventories = _loc8_;
                  _loc32_ = TUtilityString.Format(_loc26_.DescListNew[5],_loc14_.Inventories.GetInventoryByIndex(0).Name,_loc14_.Inventories.GetInventoryByIndex(0).Quantity);
                  ProcessorEffectText(_loc32_);
                  _loc35_ = int(_loc2_.readUnsignedInt());
                  _loc36_ = int(_loc2_.readUnsignedInt());
                  _loc39_ = _loc26_.SeekTreasureMapBoxList[_loc5_];
                  _loc40_ = int(_loc2_.readUnsignedInt());
                  if(_loc40_ > _loc39_.CurStep && _loc40_ > 0)
                  {
                     _loc14_ = _loc39_.TreasureBoxList[_loc40_ - 1];
                     if(_loc14_ != null && _loc14_.Inventories != null)
                     {
                        _loc32_ = TUtilityString.Format(_loc26_.DescListNew[7],_loc14_.Inventories.GetInventoryByIndex(0).Name,_loc14_.Inventories.GetInventoryByIndex(0).Quantity);
                        ProcessorEffectText(_loc32_);
                     }
                  }
                  _loc39_.CurStep = _loc40_;
                  _loc26_.SeekTreasureStatue = _loc2_.readUnsignedInt();
                  _loc26_.SeekTreasureCount = _loc2_.readUnsignedInt();
                  if(_loc26_.SeekTreasureCount == 5)
                  {
                     _loc6_ = 0;
                     while(_loc6_ < _loc26_.TreasureMapBoxList.length)
                     {
                        _loc26_.TreasureMapBoxList[_loc6_] = new TBaseBox();
                        _loc6_++;
                     }
                  }
                  this.UpdateUI();
                  if(_loc35_ != TBaseActivity.STATUS_IS_GOT)
                  {
                     this.FUIWindowVect[1].SetMovieParam(_loc5_,_loc35_,_loc36_);
                  }
                  if(_loc35_ == TBaseActivity.STATUS_CANGET)
                  {
                     _loc21_ = new Vector.<uint>();
                     _loc22_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc37_.TreasureMapBoxList[0];
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc38_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc21_.push(_loc38_);
                     _loc22_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc21_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc22_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc21_ = new Vector.<uint>();
                     _loc22_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc37_.TreasureMapBoxList[1];
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc38_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc21_.push(_loc38_);
                     _loc22_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc21_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc22_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc21_ = new Vector.<uint>();
                     _loc22_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc37_.TreasureMapBoxList[2];
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc38_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc21_.push(_loc38_);
                     _loc22_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc21_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc22_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc21_ = new Vector.<uint>();
                     _loc22_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc37_.TreasureMapBoxList[3];
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc38_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc21_.push(_loc38_);
                     _loc22_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc21_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc22_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc21_ = new Vector.<uint>();
                     _loc22_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc37_.TreasureMapBoxList[4];
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc38_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc21_.push(_loc38_);
                     _loc22_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc21_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc22_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc21_ = new Vector.<uint>();
                     _loc22_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc37_.TreasureMapBoxList[5];
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc38_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc21_.push(_loc38_);
                     _loc22_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc21_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc22_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc21_ = new Vector.<uint>();
                     _loc22_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc37_.TreasureMapBoxList[6];
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc38_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc21_.push(_loc38_);
                     _loc22_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc21_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc22_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc21_ = new Vector.<uint>();
                     _loc22_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc37_.TreasureMapBoxList[7];
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc38_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc21_.push(_loc38_);
                     _loc22_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc21_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc22_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc21_ = new Vector.<uint>();
                     _loc22_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc37_.TreasureMapBoxList[8];
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc38_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc21_.push(_loc38_);
                     _loc22_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc21_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc22_[0];
                     _loc14_.Inventories = _loc8_;
                  }
                  if(_loc36_ == TBaseActivity.STATUS_CANGET)
                  {
                     _loc21_ = new Vector.<uint>();
                     _loc22_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = new TBaseBox();
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc38_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc21_.push(_loc38_);
                     _loc22_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc21_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc22_[0];
                     _loc14_.Inventories = _loc8_;
                     _loc32_ = TUtilityString.Format(_loc26_.DescListNew[6],_loc14_.Inventories.GetInventoryByIndex(0).Name,_loc14_.Inventories.GetInventoryByIndex(0).Quantity);
                     ProcessorEffectText(_loc32_);
                  }
               }
               else if(_loc10_ == ACTVITTY_2_GIVE_UP)
               {
                  _loc5_ = int(_loc2_.readUnsignedInt());
                  _loc35_ = int(_loc2_.readUnsignedInt());
                  _loc37_ = _loc26_.MsgTreasure[_loc5_ - 1];
                  _loc37_.TreasureStatus = _loc35_;
                  if(_loc35_ == TBaseActivity.STATUS_CANGET)
                  {
                     _loc17_ = 9;
                     _loc6_ = 0;
                     while(_loc6_ < _loc17_)
                     {
                        _loc21_ = new Vector.<uint>();
                        _loc22_ = new Vector.<uint>();
                        _loc8_ = new TInventories();
                        _loc14_ = _loc37_.TreasureMapBoxList[_loc6_];
                        _loc10_ = _loc2_.readUnsignedInt();
                        _loc11_ = _loc2_.readUnsignedInt();
                        _loc38_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                        _loc21_.push(_loc38_);
                        _loc22_.push(_loc2_.readUnsignedInt());
                        this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc21_);
                        _loc8_.GetInventoryByIndex(0).Quantity = _loc22_[0];
                        _loc14_.Inventories = _loc8_;
                        _loc6_++;
                     }
                  }
                  this.FUIWindowVect[1].PlayMovie(TUIThanksgivingDay2.MOVIE_TYPE_REFRESH);
               }
               else if(_loc10_ == ACTVITTY_2_FREE_REFRESH)
               {
                  _loc26_.RefreshBuyTime = _loc2_.readUnsignedInt();
                  _loc17_ = 3;
                  _loc6_ = 0;
                  while(_loc6_ < _loc17_)
                  {
                     _loc21_ = new Vector.<uint>();
                     _loc22_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc26_.BuyTreasureMapBoxList[_loc6_];
                     _loc14_.Price = _loc2_.readUnsignedInt();
                     _loc14_.Status = TBaseActivity.STATUS_CANNOTGET;
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc38_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc21_.push(_loc38_);
                     _loc22_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc21_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc22_[0];
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
                     _loc21_ = new Vector.<uint>();
                     _loc22_ = new Vector.<uint>();
                     _loc8_ = new TInventories();
                     _loc14_ = _loc26_.BuyTreasureMapBoxList[_loc6_];
                     _loc14_.Price = _loc2_.readUnsignedInt();
                     _loc14_.Status = TBaseActivity.STATUS_CANNOTGET;
                     _loc10_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc38_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                     _loc21_.push(_loc38_);
                     _loc22_.push(_loc2_.readUnsignedInt());
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc21_);
                     _loc8_.GetInventoryByIndex(0).Quantity = _loc22_[0];
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
                  _loc9_ = _loc26_.BuyTreasureMapBoxList[_loc5_].Inventories.GetInventoryByIndex(0);
                  _loc26_.TreasureMapCount[_loc6_] += _loc9_.Quantity;
                  _loc26_.BuyTreasureMapBoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTVITTY_2_SEEK_BOX)
               {
                  _loc21_ = new Vector.<uint>();
                  _loc22_ = new Vector.<uint>();
                  _loc8_ = new TInventories();
                  _loc5_ = int(_loc2_.readUnsignedInt());
                  _loc14_ = new TBaseBox();
                  _loc26_.TreasureMapBoxList[_loc5_ - 1] = _loc14_;
                  _loc10_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc38_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc16_);
                  _loc21_.push(_loc38_);
                  _loc22_.push(_loc2_.readUnsignedInt());
                  this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc21_);
                  _loc8_.GetInventoryByIndex(0).Quantity = _loc22_[0];
                  _loc14_.Inventories = _loc8_;
                  if(_loc26_.SeekTreasureCount > 0)
                  {
                     --_loc26_.SeekTreasureCount;
                  }
                  _loc32_ = TUtilityString.Format(_loc26_.DescListNew[10],_loc14_.Inventories.GetInventoryByIndex(0).Name,_loc14_.Inventories.GetInventoryByIndex(0).Quantity);
                  ProcessorEffectText(_loc32_);
                  if(_loc26_.SeekTreasureCount == TBaseActivity.STATUS_CANNOTGET)
                  {
                     _loc17_ = int(_loc26_.SeekTreasureMapBoxList.length);
                     _loc5_ = 0;
                     while(_loc5_ < _loc17_)
                     {
                        _loc26_.SeekTreasureMapBoxList[_loc5_].GraphStatus = TBaseActivity.STATUS_CANNOTGET;
                        _loc26_.SeekTreasureMapBoxList[_loc5_].CurStep = 0;
                        _loc5_++;
                     }
                     _loc17_ = int(_loc26_.TreasureMapBoxList.length);
                     _loc5_ = 0;
                     while(_loc5_ < _loc17_)
                     {
                        if(_loc26_.TreasureMapBoxList[_loc5_].Inventories)
                        {
                           _loc26_.TreasureMapBoxList[_loc5_].Inventories.Clear();
                        }
                        _loc5_++;
                     }
                  }
                  this.UpdateUI();
                  this.FUIWindowVect[1].PlayMovie(TUIThanksgivingDay2.MOVIE_TYPE_HAMMER);
               }
               else if(_loc10_ == ACTIVITY_2_GET_FREE_BOX)
               {
                  --_loc26_.FreeTimes;
                  _loc15_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc13_ = _loc2_.readUnsignedInt();
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc4_ = _loc4_ + (STRING_COMMON.GetItemNameByType(_loc15_,_loc11_) + "*" + _loc13_ + "\n");
                  ProcessorEffectText(_loc4_);
                  this.FThanksgivingDayDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FThanksgivingDayDatas.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_3_ID:
               _loc2_.readShort();
               _loc10_ = _loc2_.readUnsignedInt();
               _loc27_ = this.FThanksgivingDayDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TThanksgivingDay3;
               if(_loc10_ == ACTIVITY_3_PLAY_DART)
               {
                  if(_loc27_.FreeCount > 0)
                  {
                     --_loc27_.FreeCount;
                  }
                  else if(_loc27_.MyPower > 0)
                  {
                     --_loc27_.MyPower;
                  }
                  _loc29_ = int(_loc2_.readUnsignedInt());
                  _loc15_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc13_ = _loc2_.readUnsignedInt();
                  _loc5_ = 0;
                  while(_loc5_ < _loc27_.BoxList.length)
                  {
                     _loc27_.BoxList[_loc5_].Status = _loc2_.readInt();
                     _loc5_++;
                  }
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  if(_loc29_ > 0)
                  {
                     _loc27_.RankPoint += _loc29_;
                     _loc4_ += _loc27_.DescListNew[9] + "*" + _loc29_ + "\n";
                  }
                  if(_loc13_ > 0)
                  {
                     _loc4_ += STRING_COMMON.GetItemNameByType(_loc15_,_loc11_) + "*" + _loc13_;
                  }
                  this.FUIWindowVect[2].PlayMovie();
                  _loc27_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FThanksgivingDayDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FThanksgivingDayDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_PLAY_DART_TEN)
               {
                  _loc27_.FreeCount = 0;
                  _loc27_.MyPower = _loc2_.readUnsignedInt();
                  _loc29_ = int(_loc2_.readUnsignedInt());
                  _loc5_ = 0;
                  while(_loc5_ < _loc27_.BoxList.length)
                  {
                     _loc27_.BoxList[_loc5_].Status = _loc2_.readInt();
                     _loc5_++;
                  }
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  if(_loc29_ > 0)
                  {
                     _loc27_.RankPoint += _loc29_;
                     _loc4_ += _loc27_.DescListNew[9] + "*" + _loc29_ + "\n";
                  }
                  this.FUIWindowVect[2].PlayMovie();
                  _loc27_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FThanksgivingDayDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FThanksgivingDayDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_GET_BIG_BOX)
               {
                  _loc14_ = _loc27_.BigBox;
                  _loc14_.Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc14_.Inventories.Count)
                  {
                     _loc9_ = _loc14_.Inventories.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.FThanksgivingDayDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FThanksgivingDayDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_GET_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc14_ = _loc27_.BoxList[_loc5_];
                  _loc14_.Status = TBaseActivity.STATUS_CANNOTGET;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc14_.Inventories.Count)
                  {
                     _loc9_ = _loc14_.Inventories.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  _loc5_ = 0;
                  while(_loc5_ < _loc27_.BoxList.length)
                  {
                     _loc27_.BoxList[_loc5_].Status = _loc2_.readInt();
                     _loc5_++;
                  }
                  _loc27_.Round = _loc2_.readUnsignedInt();
                  ProcessorEffectText(_loc4_);
                  this.FThanksgivingDayDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FThanksgivingDayDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_GET_TASK)
               {
                  _loc38_ = _loc2_.readUnsignedInt();
                  _loc42_ = this.FActivityTaskData.GetTaskByIdentify(_loc38_);
                  if(_loc42_ != null)
                  {
                     _loc42_.Status = TBaseActivity.STATUS_CANGET;
                     _loc42_.Process = 0;
                  }
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET_TASK_SUCCESS);
                  this.FThanksgivingDayDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FThanksgivingDayDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_FINISH_TASK)
               {
                  _loc38_ = _loc2_.readUnsignedInt();
                  _loc42_ = this.FActivityTaskData.GetTaskByIdentify(_loc38_);
                  this.FActivityTaskData.NeedShine = _loc2_.readUnsignedInt();
                  if(_loc42_ != null)
                  {
                     this.FActivityTaskData.Score += _loc42_.TaskPoint[_loc42_.Step];
                     this.FActivityTaskData.ChangeStatus();
                     _loc4_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_FINISH_TASK_SUCCESS,_loc42_.TaskPoint[_loc42_.Step]);
                     _loc4_ = _loc4_ + STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                     _loc5_ = 0;
                     while(_loc5_ < _loc42_.TaskAward[_loc42_.Step].Count)
                     {
                        _loc9_ = _loc42_.TaskAward[_loc42_.Step].GetInventoryByIndex(_loc5_);
                        _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                        if(_loc27_.DartID == _loc9_.IDTemplate)
                        {
                           _loc27_.MyPower += _loc9_.Quantity;
                        }
                        else if(_loc27_.ItemID == _loc9_.IDTemplate)
                        {
                           _loc27_.RankPoint += _loc9_.Quantity;
                        }
                        _loc5_++;
                     }
                     ++_loc42_.Step;
                     if(_loc42_.Step >= TActivityTaskData.STEP_COUNT)
                     {
                        _loc42_.Status = TBaseActivity.STATUS_GETED;
                     }
                     else
                     {
                        _loc42_.Process = 0;
                        _loc42_.Status = TBaseActivity.STATUS_CANNOTGET;
                     }
                  }
                  ProcessorEffectText(_loc4_);
                  this.FThanksgivingDayDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FThanksgivingDayDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_GET_TASK_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  this.FActivityTaskData.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc8_ = this.FActivityTaskData.BoxList[_loc5_].Inventories;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     if(_loc27_.DartID == _loc9_.IDTemplate)
                     {
                        _loc27_.MyPower += _loc9_.Quantity;
                     }
                     else if(_loc27_.ItemID == _loc9_.IDTemplate)
                     {
                        _loc27_.RankPoint += _loc9_.Quantity;
                     }
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.FThanksgivingDayDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FThanksgivingDayDatas.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_4_ID:
               _loc2_.readShort();
               _loc10_ = _loc2_.readUnsignedInt();
               _loc28_ = this.FThanksgivingDayDatas.GetActivityByIdentify(ACTIVITY_4_ID) as TThanksgivingDay4;
               if(_loc10_ == ACTIVITY_4_OPEN_CARD)
               {
                  if(_loc28_.FreeCount > 0)
                  {
                     --_loc28_.FreeCount;
                  }
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc29_ = _loc2_.readInt();
                  _loc6_ = _loc2_.readUnsignedInt() - 1;
                  _loc13_ = _loc2_.readUnsignedInt();
                  _loc30_ = int(_loc2_.readUnsignedInt());
                  _loc31_ = int(_loc2_.readUnsignedInt());
                  _loc28_.BoxScore += _loc30_;
                  _loc28_.ShopExchangePoint += _loc31_;
                  _loc28_.ChangeStatus();
                  if(_loc13_ > 0 || _loc30_ > 0 || _loc31_ > 0)
                  {
                     _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  }
                  if(_loc13_ > 0)
                  {
                     _loc4_ += _loc28_.DescListNew[8] + "*" + _loc13_ + "\n";
                  }
                  if(_loc30_ > 0)
                  {
                     _loc4_ += _loc28_.DescListNew[9] + "*" + _loc30_ + "\n";
                  }
                  if(_loc31_ > 0)
                  {
                     _loc4_ += _loc28_.DescListNew[10] + "*" + _loc31_ + "\n";
                  }
                  ProcessorEffectText(_loc4_);
                  this.FThanksgivingDayDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FThanksgivingDayDatas.CheckStatus());
                  this.FUIWindowVect[3].SetMovieParam(_loc5_,_loc29_,_loc6_);
               }
               else if(_loc10_ == ACTIVITY_4_OPEN_ALL_CARD)
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc28_.Card2List.length)
                  {
                     _loc28_.Card2List[_loc5_] = _loc2_.readInt();
                     if(_loc28_.CardList[_loc5_] == 0)
                     {
                        --_loc28_.FreeCount;
                     }
                     _loc5_++;
                  }
                  _loc28_.FreeCount = Math.max(_loc28_.FreeCount,0);
                  _loc13_ = _loc2_.readUnsignedInt();
                  _loc30_ = int(_loc2_.readUnsignedInt());
                  _loc31_ = int(_loc2_.readUnsignedInt());
                  _loc28_.BoxScore += _loc30_;
                  _loc28_.ShopExchangePoint += _loc31_;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  if(_loc13_ > 0)
                  {
                     _loc4_ += _loc28_.DescListNew[8] + "*" + _loc13_ + "\n";
                  }
                  if(_loc30_ > 0)
                  {
                     _loc4_ += _loc28_.DescListNew[9] + "*" + _loc30_ + "\n";
                  }
                  if(_loc31_ > 0)
                  {
                     _loc4_ += _loc28_.DescListNew[10] + "*" + _loc31_ + "\n";
                  }
                  _loc28_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FThanksgivingDayDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FThanksgivingDayDatas.CheckStatus());
                  this.FUIWindowVect[3].PlayMovie(2);
               }
               else if(_loc10_ == ACTIVITY_4_RESET)
               {
                  _loc28_.BoxScore = 0;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_RESET_TASK_SUCCESS;
                  _loc5_ = 0;
                  while(_loc5_ < _loc28_.CardList.length)
                  {
                     _loc28_.CardList[_loc5_] = 0;
                     _loc5_++;
                  }
                  _loc5_ = 0;
                  while(_loc5_ < _loc28_.BoxList.length)
                  {
                     _loc28_.BoxList[_loc5_].Status = TBaseActivity.STATUS_CANNOTGET;
                     _loc5_++;
                  }
                  _loc28_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FThanksgivingDayDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FThanksgivingDayDatas.CheckStatus());
                  this.FUIWindowVect[3].PlayMovie(3);
               }
               else if(_loc10_ == ACTIVITY_4_GET_SCORE_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc28_.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc28_.BoxList[_loc5_].Inventories.Count)
                  {
                     _loc9_ = _loc28_.BoxList[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc6_++;
                  }
                  _loc13_ = _loc2_.readUnsignedInt();
                  _loc28_.ShopExchangePoint += _loc13_;
                  _loc28_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FThanksgivingDayDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FThanksgivingDayDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_4_EXCHANGE_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  --_loc28_.ShopExchangeItems[_loc5_].LimitCount;
                  _loc28_.ShopExchangePoint -= _loc28_.ShopExchangeItems[_loc5_].Price;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc28_.ShopExchangeItems[_loc5_].Inventories.Count)
                  {
                     _loc9_ = _loc28_.ShopExchangeItems[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc6_++;
                  }
                  _loc28_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FThanksgivingDayDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FThanksgivingDayDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_4_EXCHANGE_HERO)
               {
                  _loc28_.Hero.Status = TBaseActivity.STATUS_GETED;
                  _loc28_.ShopExchangePoint -= _loc28_.Hero.Price;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  _loc28_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FThanksgivingDayDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FThanksgivingDayDatas.CheckStatus());
                  this.UpdateUI();
               }
         }
      }
      
      public function TestInit2() : void
      {
      }
   }
}

