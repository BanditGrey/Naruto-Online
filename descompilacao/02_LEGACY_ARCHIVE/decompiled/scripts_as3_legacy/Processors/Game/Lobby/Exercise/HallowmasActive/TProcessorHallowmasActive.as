package Processors.Game.Lobby.Exercise.HallowmasActive
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
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.HallowmasActive.THallowmasActive1;
   import Logics.Exercise.HallowmasActive.THallowmasActive2;
   import Logics.Exercise.HallowmasActive.THallowmasActive3;
   import Logics.Exercise.HallowmasActive.THallowmasActive4;
   import Logics.Exercise.HallowmasActive.THallowmasActiveDatas;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerHallowmasActive;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowEquipDesc;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowTitleDesc;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Rendering.Overlayers.Box.TOverlayerBox;
   import Rendering.Overlayers.SpringFestival.TOverlayerFish;
   import Rendering.Overlayers.Title.TOverlayerTitle;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorHallowmasActive extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      public static const ACTIVITY_1_SIGN:int = 1;
      
      public static const ACTIVITY_2_GET_BOX:int = 1;
      
      public static const ACTIVITY_2_GET_FISH:int = 2;
      
      public static const ACTIVITY_3_BREAK_ICE:int = 1;
      
      public static const ACTIVITY_3_AUTO_GAME:int = 2;
      
      public static const ACTIVITY_3_EXCHANGE_ITEM:int = 3;
      
      public static const ACTIVITY_3_GET_REWARD:int = 4;
      
      public static const ACTIVITY_3_GET_SOUL:int = 5;
      
      public static const ACTIVITY_3_GET_TASK:int = 6;
      
      public static const ACTIVITY_3_FINISH_TASK:int = 7;
      
      public static const ACTIVITY_3_GET_GIFT:int = 8;
      
      public static const ACTIVITY_4_FIND_TEASURE:int = 1;
      
      public static const ACTIVITY_4_GET_RECHARGE_BOX:int = 2;
      
      public static const ACTIVITY_4_EXCHANGE_ITEM:int = 3;
      
      public static const ACTIVITY_4_GET_GIFT:int = 4;
      
      public static const ACTIVITY_4_AUTO_PLAY:int = 5;
      
      public static const ACTIVITY_4_PLAY_GAME:int = 6;
      
      public static const ACTIVITY_4_EXCHANGE_HERO:int = 7;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      protected var TAB_COUNT:int = 4;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIHallowmasActive1,TUIHallowmasActive2,TUIHallowmasActive3,TUIHallowmasActive4]);
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FHallowmasActiveDatas:THallowmasActiveDatas;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      protected var FUnstreamizerHallowmasActive:TUnstreamizerHallowmasActive;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FBuyBoxDate:Object;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorWindowEquipDesc:TProcessorWindowEquipDesc;
      
      protected var FProcessorWindowTitleDesc:TProcessorWindowTitleDesc;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FOverlayerFish:TOverlayerFish;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FIsOpen:Boolean;
      
      protected var FStrLength:int;
      
      protected var FWindowType:int;
      
      public function TProcessorHallowmasActive(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FHallowmasActiveDatas = SLogicsCore.HallowmasActiveDatas;
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         this.FUnstreamizerHallowmasActive = new TUnstreamizerHallowmasActive(param3);
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
         this.FProcessorWindowEquipDesc = new TProcessorWindowEquipDesc(this.Parent);
         this.FProcessorWindowTitleDesc = new TProcessorWindowTitleDesc(this.Parent);
         this.FOverlayerTitle = new TOverlayerTitle(this.Parent);
         this.FOverlayerTitle.Visible = false;
         this.FOverlayerFish = new TOverlayerFish(this.Parent);
         this.FOverlayerFish.Visible = false;
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
            this.FTabList[_loc1_].MC_Tab.MC_Selected.visible = false;
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
            this.FUIWindowVect[_loc1_].OnNewBoxOver = ProcessorOnNewBoxOver;
            this.FUIWindowVect[_loc1_].OnNewBoxOut = ProcessorOnNewBoxOut;
            this.FUIWindowVect[_loc1_].OnItemOver = UIComponentsHintOnOver;
            this.FUIWindowVect[_loc1_].OnItemOut = UIComponentsHintOnOut;
            this.FUIWindowVect[_loc1_].OnShowDesc = this.ProcessorOnShowDesc;
            this.FUIWindowVect[_loc1_].OnShowFlowText = ProcessorEffectText;
            this.FUIWindowVect[_loc1_].OnShowHtmlTip = ProcessorOnShowHtmlText;
            this.FUIWindowVect[_loc1_].OnHideHtmlTip = ProcessorOnHideHtmlText;
            this.FUIWindowVect[_loc1_].OnShowRecruit = ProcessorOnShowItemDesc;
            this.FUIWindowVect[_loc1_].OnLoadLog = this.ProcessorOnLoadLog;
            this.FUIWindowVect[_loc1_].GotoRecharge = ProcessorOnRechargeUp;
            this.FUIWindowVect[_loc1_].OnLoadRank = this.ProcessorOnLoadRank;
            this.FUIWindowVect[_loc1_].OnSpecialOver = this.ProcessorOnSpecialOver;
            this.FUIWindowVect[_loc1_].OnSpecialOut = this.ProcessorOnSpecialOut;
            this.FUIWindowVect[_loc1_].OnShowWindow = this.ProcessorOnShowWindow;
            this.FUIWindowVect[_loc1_].OnGoto = ProcessorOnGoto;
            this.FUIWindowVect[_loc1_].OnCloseWindow = this.ProcessorOnCloseWindow;
            _loc1_++;
         }
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTitle);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBox);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerFish);
         this.FProcessorWindowEquipDesc.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorWindowEquipDesc.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowEquipDesc.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowEquipDesc.Visible = false;
         this.FProcessorWindowTitleDesc.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorWindowTitleDesc.TitleHintOnOver = this.ProcessorOnTitleOver;
         this.FProcessorWindowTitleDesc.TitleHintOnOut = this.ProcessorOnTitleOut;
         this.FProcessorWindowTitleDesc.Visible = false;
         this.FUnstreamizerTitle.UnstreamizeTitleByDatabase(null,this.FAllTitles,null);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
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
            _loc3_ = this.FHallowmasActiveDatas.GetActivityByIndex(_loc1_);
            if(_loc3_.IsOpen == TBaseActivity.IS_NOT_OPEN)
            {
               _loc2_.MC_Title.visible = false;
               _loc2_.MC_ComingSoon.visible = true;
               _loc2_.MC_Closed.visible = false;
               _loc2_.MC_ComingSoon.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_OPEN,TUtilityDate.FormatMMDDChineseNew(new Date(STimingCore.GetClientShowTime(_loc3_.BeginTime) * 1000)));
            }
            else if(_loc3_.IsOpen == TBaseActivity.IS_OPEN)
            {
               _loc2_.MC_Title.visible = true;
               _loc2_.MC_ComingSoon.visible = false;
               _loc2_.MC_Closed.visible = false;
               _loc2_.MC_Title.gotoAndStop(_loc1_ + 1);
            }
            else
            {
               _loc2_.MC_Title.visible = false;
               _loc2_.MC_ComingSoon.visible = false;
               _loc2_.MC_Closed.visible = true;
            }
            if(_loc1_ == this.FChangeTabIndex)
            {
               _loc2_.MC_Tab.MC_Selected.visible = true;
               this.FUIWindowVect[_loc1_].SetVisible(true);
               this.FUIWindowVect[_loc1_].UpdateUI();
            }
            else
            {
               _loc2_.MC_Tab.MC_Selected.visible = false;
               this.FUIWindowVect[_loc1_].SetVisible(false);
            }
            if(this.FHallowmasActiveDatas.Activities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
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
         _loc3_ = this.FHallowmasActiveDatas.GetActivityByIndex(_loc2_);
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
         _loc3_ = this.FHallowmasActiveDatas.GetActivityByIndex(_loc2_);
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
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 0, param6:String = "", param7:int = 0) : void
      {
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxType = param2;
         this.FBuyBoxDate.BoxIndex = param4;
         this.FBuyBoxDate.Cost = param3;
         this.FBuyBoxDate.CostType = param5;
         this.FBuyBoxDate.BoxIndex1 = param7;
         if(param5 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
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
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
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
      
      protected function ProcessorOnTitleOut() : void
      {
         this.FOverlayerTitle.Hide();
      }
      
      protected function ProcessorOnShowDesc() : void
      {
         FProcessorWindowDesc.BaseActivity = this.FHallowmasActiveDatas.GetActivityByIndex(this.FChangeTabIndex);
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnLoadLog(param1:int) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(param1,null);
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
      
      protected function ProcessorOnLoadRank(param1:int) : void
      {
         ProcessorLoadActiveRankNew(param1);
      }
      
      protected function ProcessorOnSpecialOver(param1:int, param2:TBaseBox) : void
      {
         if(param1 == 0)
         {
            this.FOverlayerFish.Context = param2;
            this.FOverlayerFish.Render(FUICore.MouseCoordinate);
            this.FOverlayerFish.Show();
         }
      }
      
      protected function ProcessorOnSpecialOut(param1:int) : void
      {
         if(param1 == 0)
         {
            this.FOverlayerFish.Hide();
         }
      }
      
      protected function ProcessorOnShowWindow(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:THallowmasActive1 = null;
         var _loc5_:THallowmasActive2 = null;
         var _loc6_:THallowmasActive3 = null;
         var _loc7_:THallowmasActive4 = null;
         this.FWindowType = param1;
         switch(param1)
         {
            case WINDOW_EQUIPMENT_DESC:
               _loc6_ = this.FHallowmasActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as THallowmasActive3;
               this.FProcessorWindowEquipDesc.Visible = true;
               this.FProcessorWindowEquipDesc.UpdateUI(_loc6_.EquipList);
               return;
            case WINDOW_TITLE_DESC:
               _loc6_ = this.FHallowmasActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as THallowmasActive3;
               this.FProcessorWindowTitleDesc.Visible = true;
               this.FProcessorWindowTitleDesc.UpdateUI(_loc6_.TitleList);
               return;
            default:
               return;
         }
      }
      
      protected function ProcessorOnHideWindow(param1:int = 0) : void
      {
         this.FWindowType = 0;
         switch(param1)
         {
            case WINDOW_EQUIPMENT_DESC:
               this.FProcessorWindowEquipDesc.Visible = false;
               break;
            case WINDOW_TITLE_DESC:
               this.FProcessorWindowTitleDesc.Visible = false;
         }
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
            this.FProcessorWindowEquipDesc.Load();
            this.FProcessorWindowTitleDesc.Load();
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
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
         if(this.FUIWindowVect[0])
         {
            this.FUIWindowVect[0].Unmount();
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
         this.FUnstreamizerHallowmasActive.Unstreamize(_loc2_,this.FHallowmasActiveDatas,null);
         if(FIsResourcesLoadCompleted && this.visible)
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
         _loc5_ = this.FHallowmasActiveDatas.GetActivityByIdentify(_loc4_) as TBaseActivity;
         ProcessorUnstreamActivityLog(_loc5_,_loc2_);
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
         var _loc11_:THallowmasActive3 = null;
         var _loc12_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc12_ = int(_loc2_.readUnsignedInt());
         _loc11_ = this.FHallowmasActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as THallowmasActive3;
         _loc2_.readUnsignedShort();
         if(_loc11_)
         {
            _loc11_.RankGiftList.length = 0;
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
               _loc11_.RankGiftList.push(_loc7_);
               _loc4_++;
            }
            _loc11_.RankPlayerList.length = 0;
            _loc5_ = int(_loc2_.readUnsignedShort());
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc6_ = new TConsumeRankInfo();
               _loc6_.UserName = TUtilityString.FetchUTF(_loc2_);
               _loc6_.ServerName = TUtilityString.FetchUTF(_loc2_);
               _loc6_.Rank = _loc2_.readUnsignedInt();
               _loc6_.Score = _loc2_.readUnsignedInt();
               _loc11_.RankPlayerList.push(_loc6_);
               _loc4_++;
            }
         }
         if(FIsResourcesLoadCompleted && this.visible)
         {
            FProcessorActiveRankOld.Visible = true;
            FProcessorActiveRankOld.UpdateUI(_loc11_);
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
         var _loc9_:THallowmasActive1 = null;
         var _loc10_:THallowmasActive2 = null;
         var _loc11_:THallowmasActive3 = null;
         var _loc12_:THallowmasActive4 = null;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         _loc6_ = _loc2_.readInt();
         switch(_loc6_)
         {
            case ACTIVITY_1_ID:
               _loc9_ = this.FHallowmasActiveDatas.GetActivityByIdentify(_loc6_) as THallowmasActive1;
               if(_loc9_)
               {
                  _loc9_.SurpriseStatus = _loc2_.readInt();
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_2_ID:
               _loc10_ = this.FHallowmasActiveDatas.GetActivityByIdentify(_loc6_) as THallowmasActive2;
               if(_loc10_)
               {
                  _loc10_.TotalMoney = _loc2_.readUnsignedInt();
                  _loc10_.Count = _loc2_.readUnsignedInt();
                  _loc3_ = int(_loc10_.BoxList.length);
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_)
                  {
                     _loc10_.BoxList[_loc4_].Status = _loc2_.readInt();
                     _loc4_++;
                  }
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_3_ID:
               break;
            case ACTIVITY_4_ID:
               _loc12_ = this.FHallowmasActiveDatas.GetActivityByIdentify(_loc6_) as THallowmasActive4;
               if(_loc12_)
               {
                  _loc12_.RechargeGold = _loc2_.readUnsignedInt();
                  _loc12_.ChangeStatus();
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
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
         var _loc13_:int = 0;
         var _loc14_:uint = 0;
         var _loc15_:TBaseBox = null;
         var _loc16_:uint = 0;
         var _loc17_:TBins = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:Vector.<Object> = null;
         var _loc23_:TConfigValue = null;
         var _loc24_:THallowmasActive1 = null;
         var _loc25_:THallowmasActive2 = null;
         var _loc26_:THallowmasActive3 = null;
         var _loc27_:THallowmasActive4 = null;
         var _loc28_:int = 0;
         var _loc29_:int = 0;
         var _loc30_:int = 0;
         var _loc31_:int = 0;
         var _loc32_:Vector.<uint> = null;
         var _loc33_:Vector.<uint> = null;
         var _loc34_:String = null;
         var _loc35_:TSystemLanguage = null;
         var _loc36_:TDessertHouseTask = null;
         this.FBeClicked = false;
         _loc17_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc23_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.DROP_ITEM_NAME) as TConfigValue;
         _loc22_ = _loc23_.Value as Vector.<Object>;
         _loc32_ = new Vector.<uint>();
         _loc33_ = new Vector.<uint>();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         _loc10_ = _loc2_.readUnsignedInt();
         switch(_loc7_)
         {
            case ACTIVITY_1_ID:
               _loc24_ = this.FHallowmasActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as THallowmasActive1;
               if(_loc10_ == ACTIVITY_1_SIGN)
               {
                  _loc5_ = int(_loc2_.readUnsignedInt());
                  _loc24_.GameStatus = _loc2_.readInt();
                  _loc24_.SignStatus = TBaseActivity.STATUS_GETED;
                  this.FUIWindowVect[0].SetMovieParam(_loc5_);
                  this.FUIWindowVect[0].PlayMovie(1);
                  this.FHallowmasActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FHallowmasActiveDatas.CheckStatus());
               }
               break;
            case ACTIVITY_2_ID:
               _loc25_ = this.FHallowmasActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as THallowmasActive2;
               if(_loc10_ == ACTIVITY_2_GET_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc25_.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc25_.ChangeStatus();
                  _loc8_ = _loc25_.BoxList[_loc5_].Inventories;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
               }
               else if(_loc10_ == ACTIVITY_2_GET_FISH)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  --_loc25_.Count;
                  _loc16_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc4_ = _loc4_ + (_loc25_.FishList[_loc5_].Desc1 + "\n");
                  _loc4_ = _loc4_ + (STRING_COMMON.GetItemNameByType(_loc16_,_loc11_) + "*" + _loc14_ + "\n");
                  ProcessorEffectText(_loc4_);
                  this.FUIWindowVect[1].PlayMovie(_loc5_ + 1);
               }
               this.FHallowmasActiveDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
               ProcessorCheckEffect(FActivityID,this.FHallowmasActiveDatas.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_3_ID:
               _loc26_ = this.FHallowmasActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as THallowmasActive3;
               if(_loc10_ == ACTIVITY_3_GET_TASK)
               {
                  _loc12_ = _loc2_.readUnsignedInt();
                  _loc36_ = this.FActivityTaskData.GetTaskByIdentify(_loc12_);
                  if(_loc36_ != null)
                  {
                     _loc36_.Status = TBaseActivity.STATUS_CANGET;
                     _loc36_.Process = 0;
                  }
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET_TASK_SUCCESS);
                  this.FHallowmasActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FHallowmasActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_FINISH_TASK)
               {
                  _loc12_ = _loc2_.readUnsignedInt();
                  _loc36_ = this.FActivityTaskData.GetTaskByIdentify(_loc12_);
                  this.FActivityTaskData.NeedShine = _loc2_.readUnsignedInt();
                  if(_loc36_ != null)
                  {
                     _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                     _loc5_ = 0;
                     while(_loc5_ < _loc36_.TaskAward[_loc36_.Step].Count)
                     {
                        _loc9_ = _loc36_.TaskAward[_loc36_.Step].GetInventoryByIndex(_loc5_);
                        _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                        _loc5_++;
                     }
                     ++_loc36_.Step;
                     if(_loc36_.Step >= TActivityTaskData.STEP_COUNT)
                     {
                        _loc36_.Status = TBaseActivity.STATUS_GETED;
                     }
                     else
                     {
                        _loc36_.Process = 0;
                        _loc36_.Status = TBaseActivity.STATUS_CANNOTGET;
                     }
                  }
                  _loc26_.ScoreA = _loc2_.readUnsignedInt();
                  ProcessorEffectText(_loc4_);
                  _loc26_.ChangeStatus();
                  this.FHallowmasActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FHallowmasActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_GET_GIFT)
               {
                  --_loc26_.Gift.Count;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc26_.Gift.Inventories.Count)
                  {
                     _loc9_ = _loc26_.Gift.Inventories.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  _loc26_.ScoreA = _loc2_.readUnsignedInt();
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc26_.RankPoint += _loc14_;
                  _loc26_.ShopExchangePoint += _loc14_;
                  ProcessorEffectText(_loc4_);
                  _loc26_.ChangeStatus();
                  this.FHallowmasActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FHallowmasActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_BREAK_ICE)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc26_.IceList[_loc5_] = _loc14_;
                  _loc26_.ScoreA = _loc2_.readUnsignedInt();
                  _loc26_.ScoreB = _loc2_.readUnsignedInt();
                  ++_loc26_.IceIndex;
                  _loc6_ = 0;
                  while(_loc6_ < _loc26_.TreeList.length)
                  {
                     _loc26_.TreeList[_loc6_].Status = _loc2_.readInt();
                     _loc6_++;
                  }
                  _loc26_.ConsumeScore += _loc2_.readUnsignedInt();
                  _loc26_.Gift.Count = _loc2_.readUnsignedInt();
                  this.FUIWindowVect[2].FlowStr = TUtilityString.Format(_loc26_.DescListNew[6],_loc14_);
                  _loc26_.FirstPlay = 1;
                  this.FUIWindowVect[2].SetMovieParam(_loc5_);
                  this.FUIWindowVect[2].PlayMovie(TUIHallowmasActive3.MOVIE_OF_PLAY_GAME);
                  _loc26_.ChangeStatus();
                  this.FHallowmasActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FHallowmasActiveDatas.CheckStatus());
               }
               else if(_loc10_ == ACTIVITY_3_AUTO_GAME)
               {
                  _loc18_ = _loc26_.MaxCount;
                  _loc14_ = 0;
                  _loc6_ = 0;
                  while(_loc6_ < _loc18_)
                  {
                     _loc5_ = _loc2_.readUnsignedInt() - 1;
                     _loc26_.IceList[_loc5_] = _loc2_.readUnsignedInt();
                     _loc6_++;
                  }
                  _loc26_.ScoreA = _loc2_.readUnsignedInt();
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc26_.ScoreB += _loc14_;
                  _loc26_.IceIndex = _loc26_.MaxCount + 1;
                  _loc6_ = 0;
                  while(_loc6_ < _loc26_.TreeList.length)
                  {
                     _loc26_.TreeList[_loc6_].Status = _loc2_.readUnsignedInt();
                     _loc6_++;
                  }
                  _loc26_.ConsumeScore += _loc2_.readUnsignedInt();
                  _loc26_.Gift.Count = _loc2_.readUnsignedInt();
                  this.FUIWindowVect[2].FlowStr = TUtilityString.Format(_loc26_.DescListNew[6],_loc14_);
                  this.FUIWindowVect[2].PlayMovie(TUIHallowmasActive3.MOVIE_OF_AUTO);
                  _loc26_.ChangeStatus();
                  this.FHallowmasActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FHallowmasActiveDatas.CheckStatus());
               }
               else if(_loc10_ == ACTIVITY_3_GET_SOUL)
               {
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc26_.RankPoint += _loc14_;
                  _loc26_.ShopExchangePoint += _loc14_;
                  _loc26_.AllIceList.length = 0;
                  _loc6_ = 0;
                  while(_loc6_ < 16)
                  {
                     _loc26_.AllIceList[_loc6_] = _loc2_.readUnsignedInt();
                     _loc6_++;
                  }
                  _loc4_ = TUtilityString.Format(_loc26_.DescListNew[7],_loc14_);
                  ProcessorEffectText(_loc4_);
                  _loc6_ = 0;
                  while(_loc6_ < _loc26_.TreeList.length)
                  {
                     _loc26_.TreeList[_loc6_].Status = TBaseActivity.STATUS_CANNOTGET;
                     _loc6_++;
                  }
                  this.FUIWindowVect[2].PlayMovie(TUIHallowmasActive3.MOVIE_OF_FLOW_1);
                  _loc26_.ChangeStatus();
                  this.FHallowmasActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FHallowmasActiveDatas.CheckStatus());
               }
               else if(_loc10_ == ACTIVITY_3_EXCHANGE_ITEM)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc26_.ShopExchangePoint = _loc2_.readUnsignedInt();
                  --_loc26_.ShopExchangeItems[_loc5_].LimitCount;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  _loc26_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FHallowmasActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FHallowmasActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_GET_REWARD)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc26_.ShopRewardItems[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
                  _loc26_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FHallowmasActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FHallowmasActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_4_ID:
               _loc27_ = this.FHallowmasActiveDatas.GetActivityByIdentify(ACTIVITY_4_ID) as THallowmasActive4;
               if(_loc10_ == ACTIVITY_4_PLAY_GAME)
               {
                  if(_loc27_.ScoreA > 0)
                  {
                     --_loc27_.ScoreA;
                  }
                  _loc27_.GameStatus = TBaseActivity.STATUS_CANGET;
                  _loc27_.ChangeStatus();
                  this.FHallowmasActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FHallowmasActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_4_FIND_TEASURE)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc27_.PointList[_loc5_] = _loc2_.readInt();
                  _loc27_.GameStatus = _loc2_.readInt();
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc27_.ScoreB += _loc14_;
                  _loc6_ = 0;
                  while(_loc6_ < _loc27_.Gift.length)
                  {
                     _loc27_.Gift[_loc6_].Count = _loc2_.readUnsignedInt();
                     _loc6_++;
                  }
                  if(_loc27_.PointList[_loc5_] == THallowmasActive4.TYPE_BOMB)
                  {
                     _loc4_ = _loc27_.DescListNew[7];
                  }
                  else
                  {
                     _loc4_ = TUtilityString.Format(_loc27_.DescListNew[6],_loc14_);
                  }
                  ProcessorEffectText(_loc4_);
                  _loc27_.ChangeStatus();
                  this.FHallowmasActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FHallowmasActiveDatas.CheckStatus());
                  this.FUIWindowVect[3].SetMovieParam(_loc5_);
                  this.FUIWindowVect[3].PlayMovie(TUIHallowmasActive4.MOVIE_OF_PLAY_GAME);
               }
               else if(_loc10_ == ACTIVITY_4_GET_RECHARGE_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc27_.ScoreB = _loc2_.readUnsignedInt();
                  _loc27_.RechargeList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc27_.RechargeList[_loc5_].Inventories.Count)
                  {
                     _loc9_ = _loc27_.RechargeList[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc6_++;
                  }
                  _loc27_.ChangeStatus();
                  this.FHallowmasActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FHallowmasActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_4_EXCHANGE_HERO)
               {
                  _loc27_.Hero.Status = TBaseActivity.STATUS_GETED;
                  _loc27_.ScoreB -= _loc27_.Hero.Price;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  ProcessorEffectText(_loc4_);
                  _loc27_.ChangeStatus();
                  this.FHallowmasActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FHallowmasActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_4_EXCHANGE_ITEM)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  --_loc27_.ExchangeItems[_loc5_].LimitCount;
                  _loc27_.ScoreB -= _loc27_.ExchangeItems[_loc5_].Price;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  ProcessorEffectText(_loc4_);
                  _loc27_.ChangeStatus();
                  this.FHallowmasActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FHallowmasActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_4_GET_GIFT)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc27_.Gift[_loc5_].Count = _loc2_.readUnsignedInt();
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc27_.Gift[_loc5_].Inventories.Count)
                  {
                     _loc9_ = _loc27_.Gift[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc6_++;
                  }
                  _loc27_.ScoreB = _loc2_.readUnsignedInt();
                  ProcessorEffectText(_loc4_);
                  _loc27_.ChangeStatus();
                  this.FHallowmasActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FHallowmasActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_4_AUTO_PLAY)
               {
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc27_.ScoreB += _loc14_;
                  _loc6_ = 0;
                  while(_loc6_ < _loc27_.PointList.length)
                  {
                     _loc27_.PointList[_loc6_] = _loc2_.readInt();
                     _loc6_++;
                  }
                  _loc27_.GameStatus = TBaseActivity.STATUS_CANNOTGET;
                  _loc6_ = 0;
                  while(_loc6_ < _loc27_.Gift.length)
                  {
                     _loc27_.Gift[_loc6_].Count = _loc2_.readUnsignedInt();
                     _loc6_++;
                  }
                  _loc27_.ChangeStatus();
                  this.FHallowmasActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FHallowmasActiveDatas.CheckStatus());
                  this.FUIWindowVect[3].FlowStr = TUtilityString.Format(_loc27_.DescListNew[6],_loc14_);
                  this.FUIWindowVect[3].PlayMovie(TUIHallowmasActive4.MOVIE_OF_AUTO);
               }
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc3_,"描述1");
            _loc3_.writeInt(1);
            _loc3_.writeUnsignedInt(STimingCore.GetServerTime());
            _loc3_.writeInt(1);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(8);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"浇水成功%n成熟时间减少%0分钟");
         TUtilityString.FlushUTF(_loc3_,"已满级");
         TUtilityString.FlushUTF(_loc3_,"登陆送奖励");
         TUtilityString.FlushUTF(_loc3_,"每日充值送奖励");
         TUtilityString.FlushUTF(_loc3_,"TIP0");
         TUtilityString.FlushUTF(_loc3_,"TIP1");
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(200);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(STimingCore.GetServerTime() + 10);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(0);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(7);
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeInt(1);
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
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc3_,"描述1");
            _loc3_.writeInt(1);
            _loc3_.writeUnsignedInt(STimingCore.GetServerTime());
            _loc3_.writeInt(1);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(2);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(9);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"一键探索TIPS");
         TUtilityString.FlushUTF(_loc3_,"TIP1");
         TUtilityString.FlushUTF(_loc3_,"TIP2");
         TUtilityString.FlushUTF(_loc3_,"TIP3");
         TUtilityString.FlushUTF(_loc3_,"TIP4");
         TUtilityString.FlushUTF(_loc3_,"TIP5");
         TUtilityString.FlushUTF(_loc3_,"活动道具名称");
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(1);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(100043);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeShort(7);
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(7);
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeShort(1);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

