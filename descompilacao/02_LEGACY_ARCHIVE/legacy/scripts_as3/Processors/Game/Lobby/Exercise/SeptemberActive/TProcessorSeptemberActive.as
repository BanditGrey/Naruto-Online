package Processors.Game.Lobby.Exercise.SeptemberActive
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
   import Logics.Exercise.SeptemberActive.TSeptemberActive1;
   import Logics.Exercise.SeptemberActive.TSeptemberActive2;
   import Logics.Exercise.SeptemberActive.TSeptemberActive3;
   import Logics.Exercise.SeptemberActive.TSeptemberActive4;
   import Logics.Exercise.SeptemberActive.TSeptemberActiveDatas;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerSeptemberActive;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowEquipDesc;
   import Processors.Game.Lobby.Exercise.SeptemberActive.Compoents.TUISeptemberActive1;
   import Processors.Game.Lobby.Exercise.SeptemberActive.Compoents.TUISeptemberActive2;
   import Processors.Game.Lobby.Exercise.SeptemberActive.Compoents.TUISeptemberActive3;
   import Processors.Game.Lobby.Exercise.SeptemberActive.Compoents.TUISeptemberActive4;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Rendering.Overlayers.Box.TOverlayerBox;
   import Rendering.Overlayers.Title.TOverlayerTitle;
   import Resources.Constants.CONST_BASEACTIVITY;
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
   
   public class TProcessorSeptemberActive extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      public static const ACTIVITY_1_GET_DAILY_GIFT:int = 1;
      
      public static const ACTIVITY_1_BUY_ITEM:int = 2;
      
      public static const ACTIVITY_1_GET_SERVER_BOX:int = 3;
      
      public static const ACTIVITY_1_GET_BOX:int = 4;
      
      public static const ACTIVITY_2_WATER_UP:int = 1;
      
      public static const ACTIVITY_2_GET_FRUIT:int = 2;
      
      public static const ACTIVITY_3_GET_SERVER_BOX:int = 1;
      
      public static const ACTIVITY_3_BUY_WISH:int = 2;
      
      public static const ACTIVITY_3_GET_TASK:int = 3;
      
      public static const ACTIVITY_3_FINISH_TASK:int = 4;
      
      public static const ACTIVITY_4_OPEN_POINT:int = 1;
      
      public static const ACTIVITY_4_RESET:int = 2;
      
      public static const ACTIVITY_4_OPEN_ALL_POINT:int = 3;
      
      public static const ACTIVITY_4_EXCHANGE_HERO:int = 4;
      
      public static const ACTIVITY_4_EXCHANGE_ITEM:int = 5;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      protected var TAB_COUNT:int = 4;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUISeptemberActive1,TUISeptemberActive2,TUISeptemberActive3,TUISeptemberActive4]);
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FSeptemberActiveDatas:TSeptemberActiveDatas;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      protected var FUnstreamizerSeptemberActive:TUnstreamizerSeptemberActive;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FBuyBoxDate:Object;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorSeptemberActiveLog:TProcessorSeptemberActiveLog;
      
      protected var FProcessorSeptemberActiveRank:TProcessorSeptemberActiveRank;
      
      protected var FProcessorWindowEquipDesc:TProcessorWindowEquipDesc;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FIsOpen:Boolean;
      
      protected var FStrLength:int;
      
      public function TProcessorSeptemberActive(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FSeptemberActiveDatas = SLogicsCore.SeptemberActiveDatas;
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         this.FUnstreamizerSeptemberActive = new TUnstreamizerSeptemberActive(param3);
         this.FUnstreamizerTitle = new TUnstreamizerTitle();
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
         this.FProcessorSeptemberActiveLog = new TProcessorSeptemberActiveLog(this.Parent);
         this.FProcessorSeptemberActiveRank = new TProcessorSeptemberActiveRank(this.Parent);
         this.FProcessorWindowEquipDesc = new TProcessorWindowEquipDesc(this.Parent);
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
            this.FUIWindowVect[_loc1_].OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FUIWindowVect[_loc1_].OnLoadLog = this.ProcessorOnLoadLog;
            this.FUIWindowVect[_loc1_].OnLoadRank = this.ProcessorOnLoadRank;
            this.FUIWindowVect[_loc1_].GotoRecharge = ProcessorOnRechargeUp;
            this.FUIWindowVect[_loc1_].OnCloseWindow = this.ProcessorOnCloseWindow;
            this.FUIWindowVect[_loc1_].OnGoto = ProcessorOnGoto;
            this.FUIWindowVect[_loc1_].OnShowWindow = this.ProcessorOnShowWindow;
            _loc1_++;
         }
         this.FProcessorSeptemberActiveLog.OnCloseUp = this.ProcessorOnCloseActiveLog;
         this.FProcessorSeptemberActiveLog.Visible = false;
         this.FProcessorSeptemberActiveRank.OnCloseUp = this.ProcessorOnCloseRank;
         this.FProcessorSeptemberActiveRank.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorSeptemberActiveRank.OnOut = UIComponentsHintOnOut;
         this.FProcessorSeptemberActiveRank.TitleHintOnOver = this.ProcessorOnTitleOver;
         this.FProcessorSeptemberActiveRank.TitleHintOnOut = this.ProcessorOnTitleOut;
         this.FProcessorSeptemberActiveRank.Visible = false;
         this.FProcessorWindowEquipDesc.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorWindowEquipDesc.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowEquipDesc.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowEquipDesc.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTitle);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBox);
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
            _loc3_ = this.FSeptemberActiveDatas.GetActivityByIndex(_loc1_);
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
            if(this.FSeptemberActiveDatas.Activities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
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
         _loc3_ = this.FSeptemberActiveDatas.GetActivityByIndex(_loc2_);
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
         _loc3_ = this.FSeptemberActiveDatas.GetActivityByIndex(_loc2_);
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
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 0, param6:String = "") : void
      {
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxType = param2;
         this.FBuyBoxDate.BoxIndex = param4;
         this.FBuyBoxDate.Cost = param3;
         this.FBuyBoxDate.CostType = param5;
         if(param5 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex);
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
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int, param3:int = 0) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         if(this.FBeClicked || this.FUIWindowVect[3].IsPlaying)
         {
            return;
         }
         this.FBeClicked = true;
         _loc6_ = new Vector.<int>();
         _loc6_.push(param2);
         if(param3 != 0)
         {
            _loc6_.push(param3);
         }
         PerformPacket_CS_AllReq(param1,_loc6_);
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
         FProcessorWindowDesc.BaseActivity = this.FSeptemberActiveDatas.GetActivityByIndex(this.FChangeTabIndex);
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
      
      protected function ProcessorOnLoadRank(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SpringFestival_LoadRankInfoReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         _loc2_.Data.writeUnsignedInt(param1);
         _loc2_.Data.writeShort(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnCloseRank() : void
      {
         this.FProcessorSeptemberActiveRank.Visible = false;
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function ProcessorOnCloseActiveLog() : void
      {
         this.FProcessorSeptemberActiveLog.Visible = false;
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
      
      protected function ProcessorOnShowWindow() : void
      {
         var _loc1_:TSeptemberActive3 = null;
         _loc1_ = this.FSeptemberActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TSeptemberActive3;
         this.FProcessorWindowEquipDesc.Visible = true;
         this.FProcessorWindowEquipDesc.UpdateUI(_loc1_.Equipments);
      }
      
      protected function ProcessorOnHideWindow() : void
      {
         this.FProcessorWindowEquipDesc.Visible = false;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRecruit.Load();
            this.FProcessorSeptemberActiveLog.Load();
            this.FProcessorSeptemberActiveRank.Load();
            this.FProcessorWindowEquipDesc.Load();
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
         this.FUnstreamizerSeptemberActive.Unstreamize(_loc2_,this.FSeptemberActiveDatas,null);
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
         var _loc12_:TSeptemberActive3 = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc11_ = int(_loc2_.readUnsignedInt());
         _loc12_ = this.FSeptemberActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TSeptemberActive3;
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
            this.FProcessorSeptemberActiveRank.Visible = true;
            this.FProcessorSeptemberActiveRank.UpdateUI();
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
         _loc5_ = this.FSeptemberActiveDatas.GetActivityByIdentify(_loc4_) as TBaseActivity;
         if(_loc4_ == ACTIVITY_3_ID)
         {
            this.ProcessorUnstreamOnSeptemberActive3Log(_loc2_);
         }
         else
         {
            ProcessorUnstreamActivityLog(_loc5_,_loc2_);
         }
      }
      
      public function ProcessorUnstreamOnSeptemberActive3Log(param1:ByteArray = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TInventory = null;
         var _loc7_:TInventories = null;
         var _loc8_:TLotteryNews = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:Vector.<uint> = null;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:TBins = null;
         var _loc15_:int = 0;
         var _loc16_:TSystemLanguage = null;
         var _loc17_:int = 0;
         var _loc18_:TSeptemberActive3 = null;
         _loc18_ = SLogicsCore.SeptemberActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TSeptemberActive3;
         _loc3_ = param1.readShort();
         _loc18_.LogList.length = 0;
         _loc3_ = param1.readShort();
         _loc12_ = new Vector.<uint>();
         _loc13_ = new Vector.<uint>();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc8_ = new TLotteryNews();
            _loc12_.length = 0;
            _loc13_.length = 0;
            _loc5_ = int(param1.readUnsignedShort());
            _loc4_ = 0;
            while(_loc4_ < _loc5_ / 5)
            {
               _loc10_ = param1.readUnsignedInt();
               _loc9_ = param1.readUnsignedInt();
               _loc11_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc9_,_loc14_);
               _loc12_.push(_loc11_);
               _loc13_.push(param1.readUnsignedInt());
               _loc8_.GetTime = param1.readUnsignedInt();
               _loc17_ = int(param1.readUnsignedInt());
               if(_loc17_ != 0)
               {
                  _loc16_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,_loc17_) as TSystemLanguage;
                  _loc8_.GetSource = _loc16_.Desc;
               }
               else
               {
                  _loc8_.GetSource = "";
               }
               _loc4_++;
            }
            _loc7_ = new TInventories();
            FUnstreamizerInventory.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc7_,_loc12_);
            _loc6_ = _loc7_.GetInventoryByIndex(0);
            _loc6_.Quantity = _loc13_[0];
            _loc8_.Inventory = _loc6_;
            _loc8_.Inventories = _loc7_;
            _loc18_.LogList.push(_loc8_);
            _loc2_++;
         }
         this.FProcessorSeptemberActiveLog.BaseActivity = _loc18_;
         this.FProcessorSeptemberActiveLog.UpdateUI();
         this.FProcessorSeptemberActiveLog.Visible = true;
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
         var _loc9_:TSeptemberActive1 = null;
         var _loc10_:TSeptemberActive2 = null;
         var _loc11_:TSeptemberActive4 = null;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         _loc6_ = _loc2_.readInt();
         switch(_loc6_)
         {
            case ACTIVITY_1_ID:
               _loc9_ = this.FSeptemberActiveDatas.GetActivityByIdentify(_loc6_) as TSeptemberActive1;
               if((Boolean(_loc9_)) && _loc9_.GiftList.length > 0)
               {
                  _loc9_.GiftList[1].Status = _loc2_.readInt();
                  this.FSeptemberActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FSeptemberActiveDatas.CheckStatus());
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_2_ID:
               _loc10_ = this.FSeptemberActiveDatas.GetActivityByIdentify(_loc6_) as TSeptemberActive2;
               if(_loc10_)
               {
                  _loc10_.CurGold = _loc2_.readUnsignedInt();
                  _loc10_.WaterCount = _loc2_.readUnsignedInt();
                  this.FSeptemberActiveDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FSeptemberActiveDatas.CheckStatus());
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_4_ID:
               _loc11_ = this.FSeptemberActiveDatas.GetActivityByIdentify(_loc6_) as TSeptemberActive4;
               if(_loc11_)
               {
                  _loc11_.RechargeGold = _loc2_.readUnsignedInt();
                  this.FSeptemberActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FSeptemberActiveDatas.CheckStatus());
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
         var _loc24_:TSeptemberActive1 = null;
         var _loc25_:TSeptemberActive2 = null;
         var _loc26_:TSeptemberActive3 = null;
         var _loc27_:TSeptemberActive4 = null;
         var _loc28_:int = 0;
         var _loc29_:int = 0;
         var _loc30_:int = 0;
         var _loc31_:int = 0;
         var _loc32_:Vector.<uint> = null;
         var _loc33_:Vector.<uint> = null;
         var _loc34_:String = null;
         var _loc35_:TDessertHouseTask = null;
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
               _loc24_ = this.FSeptemberActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TSeptemberActive1;
               if(_loc10_ == ACTIVITY_1_GET_DAILY_GIFT)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc24_.GiftList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc28_ = int(_loc2_.readUnsignedInt());
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc28_)
                  {
                     _loc16_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc14_ = _loc2_.readUnsignedInt();
                     _loc4_ += STRING_COMMON.GetItemNameByType(_loc16_,_loc11_) + "*" + _loc14_ + "\n";
                     _loc6_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.FSeptemberActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FSeptemberActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_BUY_ITEM)
               {
                  ++_loc24_.MyCount;
                  _loc24_.TotalCount = _loc2_.readUnsignedInt();
                  _loc24_.SaleItem.LimitCount = _loc2_.readUnsignedInt();
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc9_ = _loc24_.SaleItem.Inventories.GetInventoryByIndex(0);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity;
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FSeptemberActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FSeptemberActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_SERVER_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc31_ = int(_loc2_.readUnsignedInt());
                  _loc24_.ServerList[_loc5_].LimitCount = _loc2_.readUnsignedInt();
                  if(_loc31_ != 0)
                  {
                     _loc4_ = _loc24_.DescListNew[11];
                  }
                  else
                  {
                     _loc24_.ServerList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                     _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                     _loc6_ = 0;
                     while(_loc6_ < _loc24_.ServerList[_loc5_].Inventories.Count)
                     {
                        _loc9_ = _loc24_.ServerList[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                        _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                        _loc6_++;
                     }
                  }
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FSeptemberActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FSeptemberActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc24_.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc24_.BoxList[_loc5_].Inventories.Count)
                  {
                     _loc9_ = _loc24_.BoxList[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc6_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FSeptemberActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FSeptemberActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_2_ID:
               _loc25_ = this.FSeptemberActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TSeptemberActive2;
               if(_loc10_ == ACTIVITY_2_WATER_UP)
               {
                  if(_loc25_.WaterCount > 0)
                  {
                     --_loc25_.WaterCount;
                  }
                  _loc25_.NextTime = _loc2_.readUnsignedInt();
                  _loc4_ = _loc25_.DescListNew[2].split("%n").join("\n");
                  _loc16_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc34_ = STRING_COMMON.GetItemNameByType(_loc16_,_loc11_) + "*" + _loc14_;
                  _loc4_ = TUtilityString.Format(_loc4_,_loc34_,_loc25_.WaterReduceTime / 60);
                  ProcessorEffectText(_loc4_);
                  _loc25_.ChangeStatus();
                  this.FSeptemberActiveDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FSeptemberActiveDatas.CheckStatus());
                  this.FUIWindowVect[1].PlayMovie(TUISeptemberActive2.MOVIE_TYPE_WATER);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_GET_FRUIT)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc25_.FruitStatus[_loc5_] = TBaseActivity.STATUS_GETED;
                  _loc25_.NextTime = _loc2_.readUnsignedInt();
                  _loc25_.TreeLevel = _loc2_.readUnsignedInt();
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc9_ = _loc25_.FruitList.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc18_ = int(_loc2_.readUnsignedInt());
                  if(_loc18_ > 0)
                  {
                     _loc32_.length = 0;
                     _loc33_.length = 0;
                     _loc25_.FruitStatus.length = 0;
                     _loc8_ = new TInventories();
                     _loc6_ = 0;
                     while(_loc6_ < _loc18_)
                     {
                        _loc16_ = _loc2_.readUnsignedInt();
                        _loc11_ = _loc2_.readUnsignedInt();
                        _loc12_ = CONST_COMMON.GetItemIDByType(_loc16_,_loc11_,_loc17_);
                        _loc32_.push(_loc12_);
                        _loc33_.push(_loc2_.readUnsignedInt());
                        _loc25_.FruitStatus.push(TBaseActivity.STATUS_CANNOTGET);
                        _loc6_++;
                     }
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc32_);
                     _loc6_ = 0;
                     while(_loc6_ < _loc18_)
                     {
                        _loc9_ = _loc8_.GetInventoryByIndex(_loc6_);
                        _loc9_.Quantity = _loc33_[_loc6_];
                        _loc6_++;
                     }
                     _loc25_.FruitList = _loc8_;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc25_.ChangeStatus();
                  this.FSeptemberActiveDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FSeptemberActiveDatas.CheckStatus());
                  if(_loc25_.TreeLevel == -1)
                  {
                     this.FUIWindowVect[1].PlayMovie(TUISeptemberActive2.MOVIE_TYPE_TREE);
                     _loc25_.FruitStatus.length = 0;
                     _loc25_.FruitList = new TInventories();
                  }
                  UIComponentsHintOnOut(this,null);
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_3_ID:
               _loc26_ = this.FSeptemberActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TSeptemberActive3;
               if(_loc10_ == ACTIVITY_3_GET_TASK)
               {
                  _loc12_ = _loc2_.readUnsignedInt();
                  _loc35_ = this.FActivityTaskData.GetTaskByIdentify(_loc12_);
                  if(_loc35_ != null)
                  {
                     _loc35_.Status = TBaseActivity.STATUS_CANGET;
                     _loc35_.Process = 0;
                  }
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET_TASK_SUCCESS);
                  this.FSeptemberActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FSeptemberActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_FINISH_TASK)
               {
                  _loc12_ = _loc2_.readUnsignedInt();
                  _loc35_ = this.FActivityTaskData.GetTaskByIdentify(_loc12_);
                  this.FActivityTaskData.NeedShine = _loc2_.readUnsignedInt();
                  if(_loc35_ != null)
                  {
                     this.FActivityTaskData.Score += _loc35_.TaskPoint[_loc35_.Step];
                     this.FActivityTaskData.ChangeStatus();
                     _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                     _loc5_ = 0;
                     while(_loc5_ < _loc35_.TaskAward[_loc35_.Step].Count)
                     {
                        _loc9_ = _loc35_.TaskAward[_loc35_.Step].GetInventoryByIndex(_loc5_);
                        _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                        if(_loc26_.ItemAID == _loc9_.IDTemplate)
                        {
                           _loc26_.MyScore += _loc9_.Quantity;
                        }
                        else if(_loc26_.ItemBID == _loc9_.IDTemplate)
                        {
                           _loc26_.RankPoint += _loc9_.Quantity;
                        }
                        _loc5_++;
                     }
                     ++_loc35_.Step;
                     if(_loc35_.Step >= TActivityTaskData.STEP_COUNT)
                     {
                        _loc35_.Status = TBaseActivity.STATUS_GETED;
                     }
                     else
                     {
                        _loc35_.Process = 0;
                        _loc35_.Status = TBaseActivity.STATUS_CANNOTGET;
                     }
                  }
                  ProcessorEffectText(_loc4_);
                  this.FSeptemberActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FSeptemberActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_GET_SERVER_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc26_.ServerBoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc26_.ServerBoxList[_loc5_].Inventories.Count)
                  {
                     _loc9_ = _loc26_.ServerBoxList[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc6_++;
                  }
                  _loc26_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FSeptemberActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FSeptemberActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_BUY_WISH)
               {
                  _loc26_.WishIndex = _loc2_.readUnsignedInt() - 1;
                  _loc26_.MyScore = _loc2_.readUnsignedInt();
                  _loc28_ = int(_loc2_.readUnsignedInt());
                  _loc29_ = int(_loc2_.readUnsignedInt());
                  _loc26_.PoolGold = _loc2_.readUnsignedInt();
                  if(_loc29_ == 0)
                  {
                     _loc4_ = _loc26_.DescListNew[7] + "\n";
                  }
                  else
                  {
                     _loc4_ = _loc26_.DescListNew[6] + "\n";
                  }
                  _loc16_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc4_ += STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  if(_loc28_ > 0)
                  {
                     _loc26_.RankPoint += _loc28_;
                     _loc4_ += _loc22_[CONST_BASEACTIVITY.SEPTEMBER_ACTIVITY_3_RANK_ITEM_1] + "*" + _loc28_ + "\n";
                  }
                  if(_loc14_ > 0)
                  {
                     _loc4_ += STRING_COMMON.GetItemNameByType(_loc16_,_loc11_) + "*" + _loc14_;
                  }
                  _loc26_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FSeptemberActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FSeptemberActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_4_ID:
               _loc27_ = this.FSeptemberActiveDatas.GetActivityByIdentify(ACTIVITY_4_ID) as TSeptemberActive4;
               if(_loc10_ == ACTIVITY_4_OPEN_POINT)
               {
                  if(_loc27_.FreeCount > 0)
                  {
                     --_loc27_.FreeCount;
                  }
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc27_.RewardsIndex[_loc5_] = _loc2_.readUnsignedInt();
                  _loc28_ = int(_loc2_.readUnsignedInt());
                  _loc29_ = int(_loc2_.readUnsignedInt());
                  if(_loc27_.RewardsIndex[_loc5_] == 1)
                  {
                     _loc4_ = _loc27_.DescListNew[4];
                  }
                  else
                  {
                     _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  }
                  if(_loc28_ > 0)
                  {
                     _loc4_ += _loc22_[CONST_BASEACTIVITY.SEPTEMBER_ACTIVITY_3_RANK_ITEM_1] + "*" + _loc28_ + "\n";
                  }
                  if(_loc29_ > 0)
                  {
                     _loc27_.CurScore += _loc29_;
                     _loc4_ += _loc22_[CONST_BASEACTIVITY.SEPTEMBER_ACTIVITY_4_RANK_ITEM_1] + "*" + _loc29_ + "\n";
                  }
                  _loc27_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FSeptemberActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FSeptemberActiveDatas.CheckStatus());
                  this.FUIWindowVect[3].SetMovieParam(_loc5_);
                  this.FUIWindowVect[3].PlayMovie(TUISeptemberActive4.MOVIE_OPEN_POINT);
               }
               else if(_loc10_ == ACTIVITY_4_RESET)
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc27_.RewardsIndex.length)
                  {
                     _loc27_.RewardsIndex[_loc5_] = 0;
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc27_.DescListNew[3]);
                  this.FSeptemberActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FSeptemberActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_4_OPEN_ALL_POINT)
               {
                  _loc27_.FreeCount = _loc2_.readUnsignedInt();
                  _loc5_ = 0;
                  while(_loc5_ < _loc27_.RewardsIndex.length)
                  {
                     _loc27_.RewardsIndex[_loc5_] = _loc2_.readUnsignedInt();
                     _loc5_++;
                  }
                  _loc28_ = int(_loc2_.readUnsignedInt());
                  _loc29_ = int(_loc2_.readUnsignedInt());
                  if(_loc28_ + _loc29_ == 0)
                  {
                     _loc4_ = _loc27_.DescListNew[4];
                  }
                  else
                  {
                     _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  }
                  if(_loc28_ > 0)
                  {
                     _loc4_ += _loc22_[CONST_BASEACTIVITY.SEPTEMBER_ACTIVITY_3_RANK_ITEM_1] + "*" + _loc28_ + "\n";
                  }
                  if(_loc29_ > 0)
                  {
                     _loc27_.CurScore += _loc29_;
                     _loc4_ += _loc22_[CONST_BASEACTIVITY.SEPTEMBER_ACTIVITY_4_RANK_ITEM_1] + "*" + _loc29_ + "\n";
                  }
                  _loc27_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FSeptemberActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FSeptemberActiveDatas.CheckStatus());
                  this.FUIWindowVect[3].PlayMovie(TUISeptemberActive4.MOVIE_OPEN_ALL_POINT);
               }
               else if(_loc10_ == ACTIVITY_4_EXCHANGE_HERO)
               {
                  _loc27_.Hero.Status = TBaseActivity.STATUS_GETED;
                  _loc27_.CurScore -= _loc27_.GetCurHeroPrice();
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  _loc27_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FSeptemberActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FSeptemberActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_4_EXCHANGE_ITEM)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  --_loc27_.GiftList[_loc5_].LimitCount;
                  _loc27_.CurScore -= _loc27_.GetCurItemPriceByIndex(_loc5_);
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc27_.GiftList[_loc5_].Inventories.Count)
                  {
                     _loc9_ = _loc27_.GiftList[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc6_++;
                  }
                  _loc27_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FSeptemberActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FSeptemberActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
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
         _loc3_.writeShort(13);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"%0折");
         TUtilityString.FlushUTF(_loc3_,"剩余购买次数：%0次");
         TUtilityString.FlushUTF(_loc3_,"当前参与%0次");
         TUtilityString.FlushUTF(_loc3_,"当前全服累计购买%0次");
         TUtilityString.FlushUTF(_loc3_,"全服累计购买达到%0次可解锁");
         TUtilityString.FlushUTF(_loc3_,"还差%0次可解锁");
         TUtilityString.FlushUTF(_loc3_,"备用");
         TUtilityString.FlushUTF(_loc3_,"全服剩余%0个");
         TUtilityString.FlushUTF(_loc3_,"%0次可领");
         TUtilityString.FlushUTF(_loc3_,"该档奖励已领完");
         TUtilityString.FlushUTF(_loc3_,"充值TIPS");
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeInt(1);
            _loc3_.writeShort(3);
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100002 + _loc2_);
               _loc3_.writeUnsignedInt(1 + _loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeInt(100);
         _loc3_.writeInt(10);
         _loc3_.writeInt(5);
         _loc3_.writeInt(5);
         _loc3_.writeInt(3);
         _loc3_.writeInt(0);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(14100001);
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt((_loc1_ + 1) * 10);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeInt(0);
            _loc3_.writeInt(10 + _loc1_);
            _loc3_.writeShort(3);
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(5);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(0);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeShort(3);
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(5);
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
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
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
         _loc3_.writeShort(4);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"浇水成功");
         TUtilityString.FlushUTF(_loc3_,"已满级");
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(200);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(STimingCore.GetServerTime() + 100);
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
         _loc3_.writeShort(10);
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit2() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc3_.writeInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc3_,"描述1");
            _loc3_.writeInt(1);
            _loc3_.writeUnsignedInt(STimingCore.GetServerTime());
            _loc3_.writeInt(1);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(8);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"全服祈福牌达到%0可领");
         TUtilityString.FlushUTF(_loc3_,"确定花费%0金币补齐不足的祈福牌？");
         TUtilityString.FlushUTF(_loc3_,"花费%0祈福牌");
         TUtilityString.FlushUTF(_loc3_,"任务积分奖励:");
         TUtilityString.FlushUTF(_loc3_,"祈福成功");
         TUtilityString.FlushUTF(_loc3_,"祈福失败");
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeShort(6);
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            TUtilityString.FlushUTF(_loc3_,"祈福TIPS");
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(0);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeShort(3);
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(5);
               _loc2_++;
            }
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
         _loc3_.writeShort(12);
         _loc1_ = 0;
         while(_loc1_ < 12)
         {
            TUtilityString.FlushUTF(_loc3_,"NAME");
            TUtilityString.FlushUTF(_loc3_,"SERVER");
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(1401571200);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(0);
         _loc3_.writeShort(0);
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit3() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc3_.writeInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc3_,"描述1");
            _loc3_.writeInt(1);
            _loc3_.writeUnsignedInt(STimingCore.GetServerTime());
            _loc3_.writeInt(1);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(4);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(8);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"忍者TIPS");
         TUtilityString.FlushUTF(_loc3_,"重置成功");
         TUtilityString.FlushUTF(_loc3_,"什么都没挖到");
         TUtilityString.FlushUTF(_loc3_,"兑换需要消耗收集物%0个");
         TUtilityString.FlushUTF(_loc3_,"当前充值%0金币,再充值%1金币,仅需消耗%2个收集物");
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

