package Processors.Game.Lobby.Exercise.FebActive
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.FebActive.TFebActive1;
   import Logics.Exercise.FebActive.TFebActive2;
   import Logics.Exercise.FebActive.TFebActive3;
   import Logics.Exercise.FebActive.TFebActiveDatas;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerFebActive;
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
   
   public class TProcessorFebActive extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const TAB_COUNT:int = 3;
      
      public static const ACTIVITY_1_GET_DAILY_GIFT:int = 1;
      
      public static const ACTIVITY_1_GET_DAILY_BOX:int = 2;
      
      public static const ACTIVITY_1_GET_LOGIN_GIFT:int = 3;
      
      public static const ACTIVITY_1_GET_SPECIAL_GIFT:int = 4;
      
      public static const ACTIVITY_1_BUY_SPECIAL_ITEM:int = 5;
      
      public static const ACTIVITY_2_WATER:int = 1;
      
      public static const ACTIVITY_2_GET:int = 2;
      
      public static const ACTIVITY_3_USE_ITEM:int = 1;
      
      public static const ACTIVITY_3_USE_GOLD:int = 2;
      
      public static const ACTIVITY_3_GET_GIFT:int = 3;
      
      public static const ACTIVITY_3_GET_BOX:int = 4;
      
      public static const ACTIVITY_3_EXCHANGE_ITEM:int = 5;
      
      public static const ACTIVITY_3_GET_TASK:int = 6;
      
      public static const ACTIVITY_3_FINISH_TASK:int = 7;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 10;
      
      public static const FilterGlowStrength:int = 10;
      
      public static const WINDOW_ALL_LOG:int = 1;
      
      public static const WINDOW_MY_SELECTED:int = 2;
      
      public static const WINDOW_LOTTERY_LOG:int = 3;
      
      public static const WINDOW_HOME:int = 5;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIFebActive1,TUIFebActive2,TUIFebActive3]);
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FFebActiveDatas:TFebActiveDatas;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      protected var FUnstreamizerFebActive:TUnstreamizerFebActive;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FBuyBoxDate:Object;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorWindowEquipDesc:TProcessorWindowEquipDesc;
      
      protected var FProcessorWindowTitleDesc:TProcessorWindowTitleDesc;
      
      protected var FProcessorFebActiveWaterLog:TProcessorFebActiveWaterLog;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FIsOpen:Boolean;
      
      protected var FStrLength:int;
      
      protected var FWindowType:int;
      
      public function TProcessorFebActive(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FFebActiveDatas = SLogicsCore.FebActiveDatas;
         this.FUnstreamizerFebActive = new TUnstreamizerFebActive(param3);
         this.FUnstreamizerTitle = new TUnstreamizerTitle();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FTabList = new Vector.<MovieClip>(TAB_COUNT);
         this.FChangeTabIndex = -1;
         this.FGlowsFilter = new Vector.<TEffectBaseGlowTwo>(TAB_COUNT);
         this.FUIWindowVect = new Vector.<TUIBaseWindow>(TAB_COUNT);
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
         this.FProcessorFebActiveWaterLog = new TProcessorFebActiveWaterLog(this.Parent);
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
         while(_loc1_ < TAB_COUNT)
         {
            this.FTabList[_loc1_] = FMC_Scene.MC_Main["MC_Tab" + _loc1_];
            TGameUtil.setButtonMode(this.FTabList[_loc1_].MC_Icon,true);
            this.FTabList[_loc1_].gotoAndStop(_loc1_ + 1);
            this.FTabList[_loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnChangePage);
            _loc5_ = new TEffectBaseGlowTwo();
            _loc5_.SetParameters(FMC_Scene.MC_Main["MC_Tab" + _loc1_],FilterColor,FilterGlowWidth,FilterGlowStrength);
            this.FGlowsFilter[_loc1_] = _loc5_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
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
            this.FUIWindowVect[_loc1_].OnUpdateWindow = this.PerformPacket_CS_LoadInfoReq;
            _loc1_++;
         }
         this.FProcessorWindowEquipDesc.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorWindowEquipDesc.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowEquipDesc.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowEquipDesc.Visible = false;
         this.FProcessorWindowTitleDesc.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorWindowTitleDesc.TitleHintOnOver = this.ProcessorOnTitleOver;
         this.FProcessorWindowTitleDesc.TitleHintOnOut = this.ProcessorOnTitleOut;
         this.FProcessorWindowTitleDesc.Visible = false;
         this.FProcessorFebActiveWaterLog.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorFebActiveWaterLog.Visible = false;
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
            if(this.FChangeTabIndex >= 0)
            {
               this.FUIWindowVect[this.FChangeTabIndex].LogicsPerform();
            }
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
         if(this.FChangeTabIndex == -1)
         {
            FMC_Scene.MC_Main.visible = true;
            this.UpdateMain();
            _loc1_ = 0;
            while(_loc1_ < TAB_COUNT)
            {
               this.FUIWindowVect[_loc1_].SetVisible(false);
               if(this.FFebActiveDatas.Activities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
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
         else
         {
            FMC_Scene.MC_Main.visible = false;
            _loc1_ = 0;
            while(_loc1_ < TAB_COUNT)
            {
               if(_loc1_ == this.FChangeTabIndex)
               {
                  this.FUIWindowVect[_loc1_].SetVisible(true);
                  this.FUIWindowVect[_loc1_].UpdateUI();
               }
               else
               {
                  this.FUIWindowVect[_loc1_].SetVisible(false);
               }
               if(this.FFebActiveDatas.Activities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
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
      
      protected function UpdateMain() : void
      {
         var _loc1_:int = 0;
         FMC_Scene.MC_Main.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FFebActiveDatas.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FFebActiveDatas.EndTime) - 1) * 1000)));
         FMC_Scene.MC_Main.TF_Desc.text = this.FFebActiveDatas.DescListNew[0];
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            FMC_Scene.MC_Main["TF_Desc" + _loc1_].text = this.FFebActiveDatas.DescListNew[1 + _loc1_];
            _loc1_++;
         }
      }
      
      protected function ProcessorOnChangePage(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseActivity = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         _loc3_ = this.FFebActiveDatas.GetActivityByIndex(_loc2_);
         if(_loc3_.IsOpen != TBaseActivity.IS_OPEN || _loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         this.PerformPacket_CS_LoadInfoReq();
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
         FProcessorWindowDesc.BaseActivity = this.FFebActiveDatas.GetActivityByIndex(this.FChangeTabIndex);
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
         ProcessorLoadActiveRankNew(this.FChangeTabIndex + 1);
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         if(this.FChangeTabIndex == -1)
         {
            _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HappyTreasure_LoadInfoReq);
            _loc1_.Data.writeUnsignedInt(FActivityID);
            _loc1_.Data.writeUnsignedInt(1);
            SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         }
         else
         {
            _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HappyTreasure_LoadInfoReq);
            _loc1_.Data.writeUnsignedInt(FActivityID);
            _loc1_.Data.writeUnsignedInt(this.FChangeTabIndex + 1);
            SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         }
      }
      
      protected function ProcessorOnShowWindow(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:TFebActive3 = null;
         this.FWindowType = param1;
         switch(param1)
         {
            case WINDOW_EQUIPMENT_DESC:
               _loc4_ = this.FFebActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TFebActive3;
               this.FProcessorWindowEquipDesc.Visible = true;
               this.FProcessorWindowEquipDesc.UpdateUI(_loc4_.EquipList);
               return;
            case WINDOW_TITLE_DESC:
               _loc4_ = this.FFebActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TFebActive3;
               this.FProcessorWindowTitleDesc.Visible = true;
               this.FProcessorWindowTitleDesc.UpdateUI(_loc4_.TitleList);
               return;
            case WINDOW_ALL_LOG:
               this.FProcessorFebActiveWaterLog.Visible = true;
               this.FProcessorFebActiveWaterLog.UpdateUI();
               return;
            case WINDOW_HOME:
               this.FChangeTabIndex = -1;
               this.UpdateUI();
               return;
            default:
               _loc2_.Data.writeUnsignedInt(FActivityID);
               SNetworkCore.Transceiver.PacketTransmit(_loc2_);
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
               break;
            case WINDOW_ALL_LOG:
               this.FProcessorFebActiveWaterLog.Visible = false;
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
            this.FProcessorFebActiveWaterLog.Load();
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
         this.FChangeTabIndex = -1;
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
         TweenUtil.removeAllTween();
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
         this.FUnstreamizerFebActive.Unstreamize(_loc2_,this.FFebActiveDatas,null);
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
         _loc5_ = this.FFebActiveDatas.GetActivityByIdentify(_loc4_) as TBaseActivity;
         ProcessorUnstreamActivityLog(_loc5_,_loc2_);
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
         var _loc9_:TFebActive1 = null;
         var _loc10_:TFebActive2 = null;
         var _loc11_:TFebActive3 = null;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         _loc6_ = _loc2_.readInt();
         switch(_loc6_)
         {
            case ACTIVITY_1_ID:
               _loc9_ = this.FFebActiveDatas.GetActivityByIdentify(_loc6_) as TFebActive1;
               if(_loc9_)
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc9_.DailyBox.length)
                  {
                     _loc9_.DailyBox[_loc4_].Count = _loc2_.readUnsignedInt();
                     _loc9_.DailyBox[_loc4_].Status = _loc2_.readInt();
                     _loc4_++;
                  }
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_2_ID:
               _loc10_ = this.FFebActiveDatas.GetActivityByIdentify(_loc6_) as TFebActive2;
               if(_loc10_)
               {
                  _loc10_.TotalRecharge = _loc2_.readUnsignedInt();
                  _loc10_.ConsumeGold = _loc2_.readUnsignedInt();
                  _loc10_.RechargeAddTimes = _loc2_.readUnsignedInt();
                  _loc10_.ConsumeAddTimes = _loc2_.readUnsignedInt();
                  _loc10_.WaterCount = _loc2_.readUnsignedInt();
                  _loc10_.RechargeGold = _loc2_.readUnsignedInt();
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_3_ID:
               _loc11_ = this.FFebActiveDatas.GetActivityByIdentify(_loc6_) as TFebActive3;
               if((Boolean(_loc11_)) && Boolean(_loc11_.ActivityTaskData))
               {
                  _loc11_.ActivityTaskData.NeedShine = _loc2_.readUnsignedInt();
                  this.FFebActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
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
         var _loc14_:int = 0;
         var _loc15_:TBaseBox = null;
         var _loc16_:uint = 0;
         var _loc17_:TBins = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:Vector.<Object> = null;
         var _loc23_:TConfigValue = null;
         var _loc24_:TFebActive1 = null;
         var _loc25_:TFebActive2 = null;
         var _loc26_:TFebActive3 = null;
         var _loc27_:int = 0;
         var _loc28_:int = 0;
         var _loc29_:int = 0;
         var _loc30_:int = 0;
         var _loc31_:Vector.<uint> = null;
         var _loc32_:Vector.<uint> = null;
         var _loc33_:String = null;
         var _loc34_:TSystemLanguage = null;
         var _loc35_:int = 0;
         var _loc36_:TLotteryNews = null;
         var _loc37_:int = 0;
         var _loc38_:Number = NaN;
         var _loc39_:TDessertHouseTask = null;
         this.FBeClicked = false;
         _loc17_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc23_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.DROP_ITEM_NAME) as TConfigValue;
         _loc22_ = _loc23_.Value as Vector.<Object>;
         _loc31_ = new Vector.<uint>();
         _loc32_ = new Vector.<uint>();
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
               _loc24_ = this.FFebActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TFebActive1;
               if(_loc10_ == ACTIVITY_1_GET_DAILY_GIFT)
               {
                  _loc24_.DailyGift.Status = TBaseActivity.STATUS_GETED;
                  _loc18_ = int(_loc2_.readUnsignedInt());
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc18_)
                  {
                     _loc16_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc14_ = int(_loc2_.readUnsignedInt());
                     _loc4_ += STRING_COMMON.GetItemNameByType(_loc16_,_loc11_) + "*" + _loc14_ + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FFebActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FFebActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_DAILY_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc24_.DailyBox[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc24_.DailyBox[_loc5_].Inventories.Count)
                  {
                     _loc9_ = _loc24_.DailyBox[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc6_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FFebActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FFebActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_LOGIN_GIFT)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc24_.LoginGift[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc24_.LoginGift[_loc5_].Inventories.Count)
                  {
                     _loc9_ = _loc24_.LoginGift[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc6_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FFebActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FFebActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_SPECIAL_GIFT)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc24_.SpecialGift[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc24_.SpecialGift[_loc5_].Inventories.Count)
                  {
                     _loc9_ = _loc24_.SpecialGift[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc6_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FFebActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FFebActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_BUY_SPECIAL_ITEM)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc24_.SpecialItem[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc24_.SpecialItem[_loc5_].Inventories.Count)
                  {
                     _loc9_ = _loc24_.SpecialItem[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc6_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FFebActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FFebActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_2_ID:
               _loc25_ = this.FFebActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TFebActive2;
               if(_loc10_ == ACTIVITY_2_WATER)
               {
                  --_loc25_.WaterCount;
                  _loc25_.CurTreeLevel = _loc2_.readUnsignedInt();
                  _loc25_.CurTreeValue = _loc2_.readUnsignedInt();
                  _loc25_.CurReturn.Count = _loc2_.readUnsignedInt();
                  ProcessorEffectText(_loc25_.DescListNew[14]);
                  _loc25_.ChangeStatus();
                  this.FFebActiveDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FFebActiveDatas.CheckStatus());
                  this.FUIWindowVect[1].PlayMovie();
               }
               else if(_loc10_ == ACTIVITY_2_GET)
               {
                  _loc25_.CurReturn.Status = TBaseActivity.STATUS_GETED;
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
                  _loc25_.ChangeStatus();
                  this.FFebActiveDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FFebActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_3_ID:
               _loc26_ = this.FFebActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TFebActive3;
               this.FActivityTaskData = _loc26_.ActivityTaskData;
               if(_loc10_ == ACTIVITY_3_GET_GIFT)
               {
                  _loc26_.FirecrackerTime = _loc2_.readUnsignedInt();
                  _loc26_.ScoreA = _loc2_.readUnsignedInt();
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
                  _loc26_.ChangeStatus();
                  this.FFebActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FFebActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_USE_ITEM)
               {
                  if(_loc26_.ScoreA > 0)
                  {
                     --_loc26_.ScoreA;
                  }
                  _loc14_ = int(_loc2_.readUnsignedInt());
                  _loc27_ = int(_loc2_.readUnsignedInt());
                  _loc28_ = int(_loc2_.readUnsignedInt());
                  _loc4_ = TUtilityString.Format(_loc26_.DescListNew[9],_loc27_,_loc14_);
                  _loc26_.BossHp -= _loc27_;
                  _loc26_.BossHp = Math.max(0,_loc26_.BossHp);
                  if(_loc14_ > 0)
                  {
                     _loc26_.RankPoint += _loc14_;
                     _loc26_.ShopExchangePoint += _loc14_;
                     _loc4_ = TUtilityString.Format(_loc4_,_loc14_);
                  }
                  if(_loc26_.BossHp <= 0)
                  {
                     ++_loc26_.KillGift[_loc26_.BossIndex - 1].Count;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc26_.ChangeStatus();
                  this.FUIWindowVect[2].SetMovieParam(_loc28_);
                  this.FUIWindowVect[2].PlayMovie(TUIFebActive3.MOVIE_TYPE_USE_BOMB0);
                  _loc26_.ChangeStatus();
                  this.FFebActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FFebActiveDatas.CheckStatus());
               }
               else if(_loc10_ == ACTIVITY_3_USE_GOLD)
               {
                  _loc14_ = int(_loc2_.readUnsignedInt());
                  _loc27_ = int(_loc2_.readUnsignedInt());
                  _loc28_ = int(_loc2_.readUnsignedInt());
                  _loc4_ = TUtilityString.Format(_loc26_.DescListNew[9],_loc27_,_loc14_);
                  _loc26_.BossHp -= _loc27_;
                  _loc26_.BossHp = Math.max(0,_loc26_.BossHp);
                  if(_loc14_ > 0)
                  {
                     _loc26_.RankPoint += _loc14_;
                     _loc26_.ShopExchangePoint += _loc14_;
                     _loc4_ = TUtilityString.Format(_loc4_,_loc14_);
                  }
                  if(_loc26_.BossHp <= 0)
                  {
                     ++_loc26_.KillGift[_loc26_.BossIndex - 1].Count;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc26_.ChangeStatus();
                  this.FUIWindowVect[2].SetMovieParam(_loc28_);
                  this.FUIWindowVect[2].PlayMovie(TUIFebActive3.MOVIE_TYPE_USE_BOMB1);
                  _loc26_.ChangeStatus();
                  this.FFebActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FFebActiveDatas.CheckStatus());
               }
               else if(_loc10_ == ACTIVITY_3_GET_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc26_.RankPoint = _loc2_.readUnsignedInt();
                  _loc26_.ShopExchangePoint = _loc2_.readUnsignedInt();
                  --_loc26_.KillGift[_loc5_].Count;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc26_.KillGift[_loc5_].Inventories.Count)
                  {
                     _loc9_ = _loc26_.KillGift[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc6_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc26_.ChangeStatus();
                  this.FFebActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FFebActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_EXCHANGE_ITEM)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc26_.ShopExchangePoint = _loc2_.readUnsignedInt();
                  --_loc26_.ShopExchangeItems[_loc5_].LimitCount;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  ProcessorEffectText(_loc4_);
                  _loc26_.ChangeStatus();
                  this.FFebActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FFebActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_GET_TASK)
               {
                  _loc12_ = _loc2_.readUnsignedInt();
                  _loc39_ = this.FActivityTaskData.GetTaskByIdentify(_loc12_);
                  if(_loc39_ != null)
                  {
                     _loc39_.Status = TBaseActivity.STATUS_CANGET;
                     _loc39_.Process = 0;
                  }
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET_TASK_SUCCESS);
                  this.FFebActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FFebActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_FINISH_TASK)
               {
                  _loc12_ = _loc2_.readUnsignedInt();
                  _loc39_ = this.FActivityTaskData.GetTaskByIdentify(_loc12_);
                  this.FActivityTaskData.NeedShine = _loc2_.readUnsignedInt();
                  if(_loc39_ != null)
                  {
                     _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                     _loc5_ = 0;
                     while(_loc5_ < _loc39_.TaskAward[_loc39_.Step].Count)
                     {
                        _loc9_ = _loc39_.TaskAward[_loc39_.Step].GetInventoryByIndex(_loc5_);
                        _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                        _loc5_++;
                     }
                     ++_loc39_.Step;
                     if(_loc39_.Step >= TActivityTaskData.STEP_COUNT)
                     {
                        _loc39_.Status = TBaseActivity.STATUS_GETED;
                     }
                     else
                     {
                        _loc39_.Process = 0;
                        _loc39_.Status = TBaseActivity.STATUS_CANNOTGET;
                     }
                  }
                  _loc26_.ScoreA = _loc2_.readUnsignedInt();
                  ProcessorEffectText(_loc4_);
                  _loc26_.ChangeStatus();
                  this.FFebActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FFebActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
         }
      }
      
      public function TestInit0() : void
      {
      }
      
      public function TestInit1() : void
      {
      }
      
      public function TestInit2() : void
      {
      }
   }
}

