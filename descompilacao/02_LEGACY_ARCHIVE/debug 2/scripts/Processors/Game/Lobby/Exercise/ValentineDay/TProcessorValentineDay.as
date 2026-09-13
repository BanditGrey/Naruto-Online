package Processors.Game.Lobby.Exercise.ValentineDay
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
   import Logics.DatebaseVO.VO.TActivityPetConfig;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.ValentineDay.TValentineDay1;
   import Logics.Exercise.ValentineDay.TValentineDay2;
   import Logics.Exercise.ValentineDay.TValentineDay3;
   import Logics.Exercise.ValentineDay.TValentineDay4;
   import Logics.Exercise.ValentineDay.TValentineDayDatas;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerValentineDay;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.ValentineDay.Compoents.TUIValentineDay1;
   import Processors.Game.Lobby.Exercise.ValentineDay.Compoents.TUIValentineDay2;
   import Processors.Game.Lobby.Exercise.ValentineDay.Compoents.TUIValentineDay3;
   import Processors.Game.Lobby.Exercise.ValentineDay.Compoents.TUIValentineDay4;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Rendering.Overlayers.Box.TOverlayerBox;
   import Rendering.Overlayers.Christmas.TOverlayerThreeStr;
   import Rendering.Overlayers.NationalDay.TOverlayerSimpleNinjia;
   import Rendering.Overlayers.SpringFestival.TOverlayerFish;
   import Rendering.Overlayers.Sprite.TOverlayerSprite;
   import Rendering.Overlayers.Title.TOverlayerTitle;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorValentineDay extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      public static const ACTIVITY_1_GET_LABA:int = 1;
      
      public static const ACTIVITY_1_GET_GIFT:int = 2;
      
      public static const ACTIVITY_1_BUY_GIFT:int = 3;
      
      public static const ACTIVITY_1_GET_SIGN_BOX:int = 4;
      
      public static const ACTIVITY_2_GET_GIFT:int = 1;
      
      public static const ACTIVITY_2_BUY_BOX:int = 2;
      
      public static const ACTIVITY_3_GET_ROSE:int = 1;
      
      public static const ACTIVITY_3_GET_ALL_ROSE:int = 2;
      
      public static const ACTIVITY_3_GET_TITLE:int = 3;
      
      public static const ACTIVITY_3_GET_GIFT:int = 4;
      
      public static const ACTIVITY_3_RESET:int = 5;
      
      public static const ACTIVITY_4_BUY_BOX:int = 1;
      
      public static const ACTIVITY_4_GET_PET:int = 2;
      
      public static const TIP_OF_FISH:int = 0;
      
      public static const CHANGE_CHIP_COUNT:int = 0;
      
      public static const CHANGE_BOX_STATUS:int = 1;
      
      public static const CHANGE_PET_STATUS:int = 2;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      protected var TAB_COUNT:int = 4;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIValentineDay1,TUIValentineDay2,TUIValentineDay3,TUIValentineDay4]);
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FValentineDayDatas:TValentineDayDatas;
      
      protected var FUnstreamizerValentineDay:TUnstreamizerValentineDay;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FBuyBoxDate:Object;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FOverlayerFish:TOverlayerFish;
      
      protected var FOverlayerSimpleNinjia:TOverlayerSimpleNinjia;
      
      protected var FOverlayerThreeStr:TOverlayerThreeStr;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FOverlayerSprite:TOverlayerSprite;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FActivityPetConfigBins:TBins;
      
      protected var FIsOpen:Boolean;
      
      public function TProcessorValentineDay(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FValentineDayDatas = SLogicsCore.ValentineDayDatas;
         this.FUnstreamizerValentineDay = new TUnstreamizerValentineDay();
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
         this.FOverlayerSimpleNinjia = new TOverlayerSimpleNinjia(this.Parent);
         this.FOverlayerSimpleNinjia.Visible = false;
         this.FOverlayerThreeStr = new TOverlayerThreeStr(this.Parent);
         this.FOverlayerThreeStr.Visible = false;
         this.FOverlayerFish = new TOverlayerFish(this.Parent);
         this.FOverlayerThreeStr.Visible = false;
         this.FOverlayerTitle = new TOverlayerTitle(this.Parent);
         this.FOverlayerTitle.Visible = false;
         this.FOverlayerSprite = new TOverlayerSprite(this.Parent);
         this.FOverlayerSprite.Visible = false;
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
            this.FUIWindowVect[_loc1_].OnBoxOver = this.ProcessorOnBoxOver;
            this.FUIWindowVect[_loc1_].OnBoxOut = this.ProcessorOnBoxOut;
            this.FUIWindowVect[_loc1_].OnGetBox = this.ProcessorOnGetBoxUp;
            this.FUIWindowVect[_loc1_].OnItemOver = UIComponentsHintOnOver;
            this.FUIWindowVect[_loc1_].OnItemOut = UIComponentsHintOnOut;
            this.FUIWindowVect[_loc1_].OnShowTip = ProcessorOnShowTip;
            this.FUIWindowVect[_loc1_].OnHideTip = ProcessorOnHideTip;
            this.FUIWindowVect[_loc1_].OnBuyBox = this.ProcessorOnBuyBoxUp;
            this.FUIWindowVect[_loc1_].OnLoadRank = this.ProcessorOnGotoRank;
            this.FUIWindowVect[_loc1_].OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FUIWindowVect[_loc1_].OnShowHeroTip = this.ProcessorOnHeroOver;
            this.FUIWindowVect[_loc1_].OnHideHeroTip = this.ProcessorOnHeroOut;
            this.FUIWindowVect[_loc1_].OnShowThreeStr = this.ProcessorOnShowThreeStr;
            this.FUIWindowVect[_loc1_].OnHideThreeStr = this.ProcessorOnHideThreeStr;
            this.FUIWindowVect[_loc1_].OnLoadLog = this.ProcessorOnLoadLog;
            this.FUIWindowVect[_loc1_].GotoRecharge = ProcessorOnRechargeUp;
            this.FUIWindowVect[_loc1_].OnSpecialOver = this.ProcessorOnSpecialOver;
            this.FUIWindowVect[_loc1_].OnSpecialOut = this.ProcessorOnSpecialOut;
            this.FUIWindowVect[_loc1_].OnShowFlowText = this.ProceossorOnShowFlowText;
            this.FUIWindowVect[_loc1_].OnShowDesc = this.ProcessorOnShowDesc;
            this.FUIWindowVect[_loc1_].OnShowPetTip = this.ProcessorOnShowPetDesc;
            this.FUIWindowVect[_loc1_].OnHidePetTip = this.ProcessorOnHidePetDesc;
            this.FUIWindowVect[_loc1_].OnShowTitleTip = this.ProcessorOnTitleOver;
            this.FUIWindowVect[_loc1_].OnHideTitleTip = this.ProcessorOnTitleOut;
            _loc1_++;
         }
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBox);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSimpleNinjia);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerThreeStr);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerFish);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTitle);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSprite);
         this.FUnstreamizerTitle.UnstreamizeTitleByDatabase(null,this.FAllTitles,null);
         this.FActivityPetConfigBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ActivityPetConfig);
         FMC_Scene.BTN_CloseWindow.addEventListener(MouseEvent.CLICK,this.ProcessorOnCloseUp);
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
            _loc3_ = this.FValentineDayDatas.GetActivityByIndex(_loc1_);
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
            if(this.FValentineDayDatas.Activities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
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
         _loc3_ = this.FValentineDayDatas.GetActivityByIndex(_loc2_);
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
         _loc3_ = this.FValentineDayDatas.GetActivityByIndex(_loc2_);
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
         if(this.FBeClicked)
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
      
      protected function ProcessorOnHeroOver(param1:TBaseBox) : void
      {
         this.FOverlayerSimpleNinjia.Context = param1;
         this.FOverlayerSimpleNinjia.Render(FUICore.MouseCoordinate);
         this.FOverlayerSimpleNinjia.Show();
      }
      
      protected function ProcessorOnShowPetDesc(param1:TBaseBox) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TActivityPetConfig = null;
         _loc3_ = uint(param1.Identify);
         _loc4_ = this.FActivityPetConfigBins.GetDatebaseByIdentifier(_loc3_) as TActivityPetConfig;
         this.FOverlayerSprite.Context = null;
         this.FOverlayerSprite.Context = _loc4_;
         this.FOverlayerSprite.Render(FUICore.MouseCoordinate);
         this.FOverlayerSprite.Show();
      }
      
      protected function ProcessorOnHidePetDesc() : void
      {
         this.FOverlayerSprite.Hide();
      }
      
      protected function ProcessorOnHeroOut() : void
      {
         this.FOverlayerSimpleNinjia.Hide();
      }
      
      protected function ProcessorOnShowThreeStr(param1:TBaseBox) : void
      {
         this.FOverlayerThreeStr.Context = param1;
         this.FOverlayerThreeStr.Render(FUICore.MouseCoordinate);
         this.FOverlayerThreeStr.Show();
      }
      
      protected function ProcessorOnHideThreeStr() : void
      {
         this.FOverlayerThreeStr.Hide();
      }
      
      protected function ProcessorOnLoadLog(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
      }
      
      protected function ProcessorOnSpecialOver(param1:int, param2:TBaseBox) : void
      {
         if(param1 == TIP_OF_FISH)
         {
            this.FOverlayerFish.Context = param2;
            this.FOverlayerFish.Render(FUICore.MouseCoordinate);
            this.FOverlayerFish.Show();
         }
      }
      
      protected function ProcessorOnSpecialOut(param1:int) : void
      {
         if(param1 == TIP_OF_FISH)
         {
            this.FOverlayerFish.Hide();
         }
      }
      
      protected function ProcessorOnShowDesc() : void
      {
         FProcessorWindowDesc.BaseActivity = this.FValentineDayDatas.GetActivityByIndex(this.FChangeTabIndex);
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProceossorOnShowFlowText(param1:String) : void
      {
         ProcessorEffectText(param1);
      }
      
      protected function ProcessorOnCloseUp(param1:MouseEvent) : void
      {
         if(this.FChangeTabIndex == ACTIVITY_3_ID - 1 && this.FUIWindowVect[this.FChangeTabIndex].IsPlaying)
         {
            return;
         }
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
         this.FUnstreamizerValentineDay.Unstreamize(_loc2_,this.FValentineDayDatas,null);
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
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TValentineDay1 = null;
         var _loc9_:TValentineDay2 = null;
         var _loc10_:TValentineDay4 = null;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         _loc5_ = _loc2_.readInt();
         switch(_loc5_)
         {
            case ACTIVITY_2_ID:
               _loc9_ = this.FValentineDayDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TValentineDay2;
               if(_loc9_)
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc9_.GiftList.length)
                  {
                     _loc9_.GiftList[_loc4_].Status = _loc2_.readInt();
                     _loc4_++;
                  }
                  _loc9_.CheckBoxStatus();
                  this.FValentineDayDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FValentineDayDatas.CheckStatus());
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_4_ID:
               _loc10_ = this.FValentineDayDatas.GetActivityByIdentify(ACTIVITY_4_ID) as TValentineDay4;
               if(_loc10_.BoxVect.length > 0 && _loc10_.ExchangeInventories.Count > 0)
               {
                  _loc5_ = int(_loc2_.readUnsignedInt());
                  if(_loc5_ == CHANGE_CHIP_COUNT)
                  {
                     _loc4_ = _loc2_.readUnsignedInt();
                     _loc6_ = int(_loc2_.readUnsignedInt());
                     _loc10_.ExchangeInventories.GetInventoryByIndex(_loc4_ - 1).Quantity = _loc6_;
                     _loc10_.CheckChipIsEnough();
                  }
                  else if(_loc5_ == CHANGE_BOX_STATUS)
                  {
                     _loc4_ = _loc2_.readUnsignedInt();
                     _loc10_.BoxVect[_loc4_ - 1].Status = TBaseActivity.STATUS_CANGET;
                  }
                  this.UpdateUI();
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
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:uint = 0;
         var _loc16_:TBaseBox = null;
         var _loc17_:TValentineDay1 = null;
         var _loc18_:TValentineDay2 = null;
         var _loc19_:TValentineDay3 = null;
         var _loc20_:TValentineDay4 = null;
         var _loc21_:uint = 0;
         var _loc22_:TBins = null;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         _loc22_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
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
               _loc2_.readShort();
               _loc10_ = _loc2_.readUnsignedInt();
               _loc17_ = this.FValentineDayDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TValentineDay1;
               if(_loc10_ == ACTIVITY_1_GET_GIFT)
               {
                  _loc17_.Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc17_.Inventories;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.FUIWindowVect[0].PlayMovie(2);
                  this.FValentineDayDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FValentineDayDatas.CheckStatus());
               }
               else if(_loc10_ == ACTIVITY_1_BUY_GIFT)
               {
                  _loc17_.Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc17_.Inventories;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.FUIWindowVect[0].PlayMovie(2);
                  this.FValentineDayDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FValentineDayDatas.CheckStatus());
               }
               else if(_loc10_ == ACTIVITY_1_GET_LABA)
               {
                  if(_loc17_.FreeCount > 0)
                  {
                     --_loc17_.FreeCount;
                  }
                  _loc23_ = int(_loc2_.readUnsignedInt());
                  _loc8_ = new TInventories();
                  _loc13_ = new Vector.<uint>();
                  _loc14_ = new Vector.<uint>();
                  _loc17_.LabaInventories = new TInventories();
                  _loc5_ = 0;
                  while(_loc5_ < _loc23_)
                  {
                     _loc21_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc12_ = CONST_COMMON.GetItemIDByType(_loc21_,_loc11_,_loc22_);
                     _loc13_.push(_loc12_);
                     _loc14_.push(_loc2_.readUnsignedInt());
                     _loc5_++;
                  }
                  this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc13_);
                  _loc5_ = 0;
                  while(_loc5_ < _loc23_)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc9_.Quantity = _loc14_[_loc5_];
                     _loc5_++;
                  }
                  _loc17_.LabaInventories = _loc8_;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  _loc17_.LabaFlowStr = _loc4_;
                  this.FUIWindowVect[0].PlayMovie(1);
                  this.FValentineDayDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FValentineDayDatas.CheckStatus());
               }
               else if(_loc10_ == ACTIVITY_1_GET_SIGN_BOX)
               {
                  _loc17_.CurStatus = TBaseActivity.STATUS_GETED;
                  _loc5_ = _loc17_.CurDay - 1;
                  _loc17_.DayList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc17_.DayList[_loc5_].Inventories;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.FValentineDayDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FValentineDayDatas.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_2_ID:
               _loc2_.readShort();
               _loc10_ = _loc2_.readUnsignedInt();
               _loc18_ = this.FValentineDayDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TValentineDay2;
               if(_loc10_ == ACTIVITY_2_GET_GIFT)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc18_.GiftList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc18_.GiftList[_loc5_].Inventories;
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
               else if(_loc10_ == ACTIVITY_2_BUY_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  --_loc18_.BoxList[_loc5_].BuyCount;
                  _loc8_ = _loc18_.BoxList[_loc5_].Inventories;
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
               this.FValentineDayDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
               ProcessorCheckEffect(FActivityID,this.FValentineDayDatas.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_3_ID:
               _loc2_.readShort();
               _loc10_ = _loc2_.readUnsignedInt();
               _loc19_ = this.FValentineDayDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TValentineDay3;
               if(_loc10_ == ACTIVITY_3_GET_ROSE)
               {
                  if(_loc19_.FreeCount > 0)
                  {
                     --_loc19_.FreeCount;
                  }
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc24_ = int(_loc2_.readUnsignedInt());
                  _loc25_ = _loc2_.readUnsignedInt() - 1;
                  _loc15_ = _loc2_.readUnsignedInt();
                  _loc26_ = int(_loc2_.readUnsignedInt());
                  if(_loc15_ > 0)
                  {
                     _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                     _loc4_ = _loc4_ + (_loc19_.ActivityDesc2 + "* " + _loc15_);
                     ProcessorEffectText(_loc4_);
                  }
                  _loc19_.RoseStatus[_loc5_] = _loc24_;
                  _loc19_.Score += _loc15_;
                  _loc19_.IsEnd = _loc26_;
                  this.FUIWindowVect[2].SetMovieParam(_loc5_,_loc25_);
                  this.FUIWindowVect[2].PlayMovie(1);
                  _loc19_.ChangeGiftStatus();
               }
               else if(_loc10_ == ACTIVITY_3_GET_ALL_ROSE)
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc19_.RoseStatus.length)
                  {
                     _loc19_.RoseStatus[_loc5_] = _loc2_.readInt();
                     _loc5_++;
                  }
                  _loc15_ = _loc2_.readUnsignedInt();
                  _loc19_.Score += _loc15_;
                  _loc19_.FreeCount = _loc2_.readUnsignedInt();
                  _loc19_.IsEnd = _loc2_.readInt();
                  if(_loc15_ > 0)
                  {
                     _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                     _loc4_ = _loc4_ + (_loc19_.ActivityDesc2 + "* " + _loc15_);
                     ProcessorEffectText(_loc4_);
                  }
                  this.FUIWindowVect[2].PlayMovie(3);
                  _loc19_.ChangeGiftStatus();
               }
               else if(_loc10_ == ACTIVITY_3_GET_TITLE)
               {
                  _loc19_.TitleStatus = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
                  ProcessorEffectText(_loc4_);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_GET_GIFT)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc19_.GiftList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc19_.GiftList[_loc5_].Inventories;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc19_.ChangeGiftStatus();
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_RESET)
               {
                  _loc19_.ResetRoseStatus();
                  this.UpdateUI();
               }
               this.FValentineDayDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
               ProcessorCheckEffect(FActivityID,this.FValentineDayDatas.CheckStatus());
               break;
            case ACTIVITY_4_ID:
               _loc2_.readShort();
               _loc10_ = _loc2_.readUnsignedInt();
               _loc20_ = this.FValentineDayDatas.GetActivityByIdentify(ACTIVITY_4_ID) as TValentineDay4;
               if(_loc10_ == ACTIVITY_4_BUY_BOX)
               {
                  if(_loc20_.FreeTimes > 0)
                  {
                     --_loc20_.FreeTimes;
                  }
                  _loc23_ = int(_loc2_.readUnsignedInt());
                  _loc8_ = new TInventories();
                  _loc13_ = new Vector.<uint>();
                  _loc14_ = new Vector.<uint>();
                  _loc5_ = 0;
                  while(_loc5_ < _loc23_)
                  {
                     _loc21_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc12_ = CONST_COMMON.GetItemIDByType(_loc21_,_loc11_,_loc22_);
                     _loc13_.push(_loc12_);
                     _loc14_.push(_loc2_.readUnsignedInt());
                     _loc5_++;
                  }
                  this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc13_);
                  _loc5_ = 0;
                  while(_loc5_ < _loc23_)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc9_.Quantity = _loc14_[_loc5_];
                     _loc5_++;
                  }
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.FUIWindowVect[3].PlayMovie();
               }
               else if(_loc10_ == ACTIVITY_4_GET_PET)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  ProcessorEffectText(_loc4_);
                  _loc20_.PetVect[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  this.UpdateUI();
               }
               this.FValentineDayDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
               ProcessorCheckEffect(FActivityID,this.FValentineDayDatas.CheckStatus());
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([1,1,0,0]);
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
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"活动1");
         TUtilityString.FlushUTF(_loc3_,"活动2");
         TUtilityString.FlushUTF(_loc3_,"活动3");
         _loc3_.writeInt(15);
         _loc3_.writeInt(10);
         _loc3_.writeInt(15);
         _loc3_.writeInt(1);
         _loc3_.writeInt(2);
         _loc3_.writeInt(1);
         _loc3_.writeShort(31);
         _loc1_ = 0;
         while(_loc1_ < 31)
         {
            _loc3_.writeInt(1);
            _loc3_.writeShort(3);
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc2_ + _loc1_);
               _loc3_.writeUnsignedInt(1 + _loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeInt(_loc1_);
            TUtilityString.FlushUTF(_loc3_,"活动1");
            _loc3_.writeShort(3);
            _loc2_ = 0;
            while(_loc2_ < 3)
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

