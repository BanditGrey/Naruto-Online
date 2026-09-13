package Processors.Game.Lobby.Exercise.DecActive
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
   import Logics.Exercise.DecActive.TDecActive1;
   import Logics.Exercise.DecActive.TDecActive2;
   import Logics.Exercise.DecActive.TDecActive3;
   import Logics.Exercise.DecActive.TDecActive4;
   import Logics.Exercise.DecActive.TDecActiveDatas;
   import Logics.Exercise.DecActive.TLotteryLog;
   import Logics.Exercise.DecActive.TTicketData;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerDecActive;
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
   import Processors.Game.Lobby.Exercise.DecActive.Compoents.TUIDecActive1;
   import Processors.Game.Lobby.Exercise.DecActive.Compoents.TUIDecActive2;
   import Processors.Game.Lobby.Exercise.DecActive.Compoents.TUIDecActive3;
   import Processors.Game.Lobby.Exercise.DecActive.Compoents.TUIDecActive4;
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
   
   public class TProcessorDecActive extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      public static const ACTIVITY_1_GET_DAILY_BOX:int = 1;
      
      public static const ACTIVITY_1_LOTTERY:int = 2;
      
      public static const ACTIVITY_1_GET_LOTTERY_BOX:int = 3;
      
      public static const ACTIVITY_1_BUY_INVESTMENT:int = 4;
      
      public static const ACTIVITY_2_GET_TICKET:int = 1;
      
      public static const ACTIVITY_2_GET_LUCKY_BOX:int = 2;
      
      public static const ACTIVITY_2_GET_GIFT:int = 3;
      
      public static const ACTIVITY_3_PLAY_GAME:int = 1;
      
      public static const ACTIVITY_3_GET_GAME_BOX:int = 2;
      
      public static const ACTIVITY_3_EXCHANGE_ITEM:int = 3;
      
      public static const ACTIVITY_3_GET_REWARD:int = 4;
      
      public static const ACTIVITY_4_PLAY_GAME:int = 1;
      
      public static const ACTIVITY_4_EXCHANGE_HERO:int = 2;
      
      public static const ACTIVITY_4_EXCHANGE_ITEM:int = 3;
      
      public static const ACTIVITY_4_GET_GIFT:int = 4;
      
      public static const ACTIVITY_4_AUTO_PLAY:int = 5;
      
      public static const ACTIVITY_4_RESET_GAME:int = 6;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      public static const WINDOW_SELECTE_NUM:int = 1;
      
      public static const WINDOW_MY_SELECTED:int = 2;
      
      public static const WINDOW_LOTTERY_LOG:int = 3;
      
      public static const WINDOW_EQUIPMENT_DESC_2:int = 5;
      
      public static const WINDOW_EGG_BOOK:int = 6;
      
      protected var TAB_COUNT:int = 4;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIDecActive1,TUIDecActive2,TUIDecActive3,TUIDecActive4]);
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FDecActiveDatas:TDecActiveDatas;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      protected var FUnstreamizerDecActive:TUnstreamizerDecActive;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FBuyBoxDate:Object;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorWindowEquipDesc:TProcessorWindowEquipDesc;
      
      protected var FProcessorWindowEquipDesc2:TProcessorWindowEquipDesc2;
      
      protected var FProcessorWindowTitleDesc:TProcessorWindowTitleDesc;
      
      protected var FProcessorDecActiveSelectNum:TProcessorDecActiveSelectNum;
      
      protected var FProcessorDecActiveMySelected:TProcessorDecActiveMySelected;
      
      protected var FProcessorDecActiveLotteryLog:TProcessorDecActiveLotteryLog;
      
      protected var FProcessorDecActiveBook:TProcessorDecActiveBook;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FIsOpen:Boolean;
      
      protected var FStrLength:int;
      
      protected var FWindowType:int;
      
      public function TProcessorDecActive(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FDecActiveDatas = SLogicsCore.DecActiveDatas;
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         this.FUnstreamizerDecActive = new TUnstreamizerDecActive(param3);
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
         this.FProcessorWindowEquipDesc = new TProcessorWindowEquipDesc(this.Parent);
         this.FProcessorWindowEquipDesc2 = new TProcessorWindowEquipDesc2(this.Parent);
         this.FProcessorWindowTitleDesc = new TProcessorWindowTitleDesc(this.Parent);
         this.FProcessorDecActiveSelectNum = new TProcessorDecActiveSelectNum(this.Parent);
         this.FProcessorDecActiveMySelected = new TProcessorDecActiveMySelected(this.Parent);
         this.FProcessorDecActiveLotteryLog = new TProcessorDecActiveLotteryLog(this.Parent);
         this.FProcessorDecActiveBook = new TProcessorDecActiveBook(this.Parent);
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
            this.FUIWindowVect[_loc1_].OnUpdateWindow = this.PerformPacket_CS_LoadInfoReq;
            _loc1_++;
         }
         this.FProcessorDecActiveSelectNum.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorDecActiveSelectNum.OnGetBox = this.ProcessorOnGetBoxUp;
         this.FProcessorDecActiveSelectNum.Visible = false;
         this.FProcessorDecActiveMySelected.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorDecActiveMySelected.Visible = false;
         this.FProcessorDecActiveLotteryLog.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorDecActiveLotteryLog.Visible = false;
         this.FProcessorWindowEquipDesc.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorWindowEquipDesc.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowEquipDesc.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowEquipDesc.Visible = false;
         this.FProcessorWindowEquipDesc2.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorWindowEquipDesc2.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowEquipDesc2.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowEquipDesc2.Visible = false;
         this.FProcessorWindowTitleDesc.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorWindowTitleDesc.TitleHintOnOver = this.ProcessorOnTitleOver;
         this.FProcessorWindowTitleDesc.TitleHintOnOut = this.ProcessorOnTitleOut;
         this.FProcessorWindowTitleDesc.Visible = false;
         this.FProcessorDecActiveBook.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorDecActiveBook.TipOnOver = ProcessorOnShowHtmlText;
         this.FProcessorDecActiveBook.TipOnOut = ProcessorOnHideHtmlText;
         this.FProcessorDecActiveBook.Visible = false;
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
            _loc3_ = this.FDecActiveDatas.GetActivityByIndex(_loc1_);
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
            if(this.FDecActiveDatas.Activities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
            {
               this.FGlowsFilter[_loc1_].IsRunOver = false;
            }
            else
            {
               this.FGlowsFilter[_loc1_].Stop();
            }
            _loc1_++;
         }
         switch(this.FWindowType)
         {
            case WINDOW_SELECTE_NUM:
               this.FProcessorDecActiveSelectNum.UpdateUI();
               break;
            case WINDOW_MY_SELECTED:
               this.FProcessorDecActiveMySelected.UpdateUI();
               break;
            case WINDOW_LOTTERY_LOG:
               this.FProcessorDecActiveLotteryLog.UpdateUI();
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
         _loc3_ = this.FDecActiveDatas.GetActivityByIndex(_loc2_);
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
         _loc3_ = this.FDecActiveDatas.GetActivityByIndex(_loc2_);
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
         FProcessorWindowDesc.BaseActivity = this.FDecActiveDatas.GetActivityByIndex(this.FChangeTabIndex);
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
         ProcessorLoadActiveRankNew(param1);
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
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HappyTreasure_LoadInfoReq);
         _loc1_.Data.writeUnsignedInt(ActivityID);
         _loc1_.Data.writeUnsignedInt(this.FChangeTabIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOnShowWindow(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:TDecActive2 = null;
         var _loc5_:TDecActive3 = null;
         this.FWindowType = param1;
         switch(param1)
         {
            case WINDOW_SELECTE_NUM:
               _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DecActive2_LoadSelectNumReq);
               break;
            case WINDOW_MY_SELECTED:
               _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DecActive2_LoadMySelectedReq);
               break;
            case WINDOW_LOTTERY_LOG:
               _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DecActive2_LoadLotteryLogReq);
               break;
            case WINDOW_EQUIPMENT_DESC:
               _loc4_ = this.FDecActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TDecActive2;
               this.FProcessorWindowEquipDesc.Visible = true;
               this.FProcessorWindowEquipDesc.UpdateUI(_loc4_.TreeShowItems);
               return;
            case WINDOW_TITLE_DESC:
               _loc5_ = this.FDecActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TDecActive3;
               this.FProcessorWindowTitleDesc.Visible = true;
               this.FProcessorWindowTitleDesc.UpdateUI(_loc5_.TitleList);
               return;
            case WINDOW_EQUIPMENT_DESC_2:
               _loc5_ = this.FDecActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TDecActive3;
               this.FProcessorWindowEquipDesc2.Visible = true;
               this.FProcessorWindowEquipDesc2.UpdateUI(_loc5_.EquipList);
               return;
            case WINDOW_EGG_BOOK:
               this.FProcessorDecActiveBook.Visible = true;
               this.FProcessorDecActiveBook.UpdateUI();
               return;
         }
         _loc2_.Data.writeUnsignedInt(FActivityID);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnHideWindow(param1:int = 0) : void
      {
         this.FWindowType = 0;
         switch(param1)
         {
            case WINDOW_SELECTE_NUM:
               this.FProcessorDecActiveSelectNum.Visible = false;
               break;
            case WINDOW_MY_SELECTED:
               this.FProcessorDecActiveMySelected.Visible = false;
               break;
            case WINDOW_LOTTERY_LOG:
               this.FProcessorDecActiveLotteryLog.Visible = false;
               break;
            case WINDOW_EQUIPMENT_DESC:
               this.FProcessorWindowEquipDesc.Visible = false;
               break;
            case WINDOW_TITLE_DESC:
               this.FProcessorWindowTitleDesc.Visible = false;
               break;
            case WINDOW_EQUIPMENT_DESC_2:
               this.FProcessorWindowEquipDesc2.Visible = false;
               break;
            case WINDOW_EGG_BOOK:
               this.FProcessorDecActiveBook.Visible = false;
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRecruit.Load();
            this.FProcessorDecActiveSelectNum.Load();
            this.FProcessorDecActiveMySelected.Load();
            this.FProcessorDecActiveLotteryLog.Load();
            this.FProcessorWindowEquipDesc.Load();
            this.FProcessorWindowEquipDesc2.Load();
            this.FProcessorWindowTitleDesc.Load();
            this.FProcessorDecActiveBook.Load();
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
         this.FUnstreamizerDecActive.Unstreamize(_loc2_,this.FDecActiveDatas,null);
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
         _loc5_ = this.FDecActiveDatas.GetActivityByIdentify(_loc4_) as TBaseActivity;
         ProcessorUnstreamActivityLog(_loc5_,_loc2_);
      }
      
      public function ProcessorLoadSelectNumRet(param1:TPacket = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc6_:TTicketData = null;
         var _loc7_:TDecActive2 = null;
         _loc4_ = param1.Data;
         _loc5_ = _loc4_.readInt();
         if(_loc5_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc5_);
            return;
         }
         _loc7_ = this.FDecActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TDecActive2;
         _loc7_.MyTickets.length = 0;
         _loc3_ = _loc4_.readShort();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = new TTicketData();
            _loc6_.Num = _loc4_.readUnsignedInt();
            _loc6_.Count = _loc4_.readUnsignedInt();
            _loc7_.MyTickets[_loc2_] = _loc6_;
            _loc2_++;
         }
         if(FIsResourcesLoadCompleted && this.FIsOpen)
         {
            this.FProcessorDecActiveSelectNum.Visible = true;
            this.FProcessorDecActiveSelectNum.UpdateUI();
         }
      }
      
      public function ProcessorLoadMySelectedRet(param1:TPacket = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc6_:TTicketData = null;
         var _loc7_:TDecActive2 = null;
         _loc4_ = param1.Data;
         _loc5_ = _loc4_.readInt();
         if(_loc5_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc5_);
            return;
         }
         _loc7_ = this.FDecActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TDecActive2;
         _loc7_.AllTickets.length = 0;
         _loc3_ = _loc4_.readShort();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = new TTicketData();
            _loc6_.Time = _loc4_.readUnsignedInt();
            _loc6_.Num = _loc4_.readUnsignedInt();
            _loc6_.Count = _loc4_.readUnsignedInt();
            _loc6_.Status = _loc4_.readInt();
            _loc6_.Gold = _loc4_.readUnsignedInt();
            _loc7_.AllTickets[_loc2_] = _loc6_;
            _loc2_++;
         }
         if(FIsResourcesLoadCompleted && this.FIsOpen)
         {
            this.FProcessorDecActiveMySelected.Visible = true;
            this.FProcessorDecActiveMySelected.UpdateUI();
         }
      }
      
      public function ProcessorLoadLotteryLogRet(param1:TPacket = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:ByteArray = null;
         var _loc7_:int = 0;
         var _loc8_:TLotteryLog = null;
         var _loc9_:TDecActive2 = null;
         _loc6_ = param1.Data;
         _loc7_ = _loc6_.readInt();
         if(_loc7_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc7_);
            return;
         }
         _loc9_ = this.FDecActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TDecActive2;
         _loc9_.LotteryLogs.length = 0;
         _loc4_ = _loc6_.readShort();
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc8_ = new TLotteryLog();
            _loc8_.Time = _loc6_.readUnsignedInt();
            _loc5_ = _loc6_.readShort();
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc8_.FirstNumbers.push(_loc6_.readUnsignedInt());
               _loc3_++;
            }
            _loc5_ = _loc6_.readShort();
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc8_.SecondNumbers.push(_loc6_.readUnsignedInt());
               _loc3_++;
            }
            _loc5_ = _loc6_.readShort();
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc8_.ThirdNumbers.push(_loc6_.readUnsignedInt());
               _loc3_++;
            }
            _loc9_.LotteryLogs[_loc2_] = _loc8_;
            _loc2_++;
         }
         if(FIsResourcesLoadCompleted && this.FIsOpen)
         {
            this.FProcessorDecActiveLotteryLog.Visible = true;
            this.FProcessorDecActiveLotteryLog.UpdateUI();
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
         var _loc9_:TDecActive1 = null;
         var _loc10_:TDecActive2 = null;
         var _loc11_:TDecActive3 = null;
         var _loc12_:TDecActive4 = null;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         _loc6_ = _loc2_.readInt();
         switch(_loc6_)
         {
            case ACTIVITY_1_ID:
               _loc9_ = this.FDecActiveDatas.GetActivityByIdentify(_loc6_) as TDecActive1;
               if(_loc9_)
               {
                  _loc9_.LotteryCount = _loc2_.readUnsignedInt();
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_2_ID:
               _loc10_ = this.FDecActiveDatas.GetActivityByIdentify(_loc6_) as TDecActive2;
               if(_loc10_)
               {
                  _loc10_.MaxCount = _loc2_.readUnsignedInt();
                  _loc10_.BarGold = _loc2_.readUnsignedInt();
                  _loc10_.RechargeGold = _loc2_.readUnsignedInt();
                  _loc3_ = int(_loc10_.TreeItems.length);
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_)
                  {
                     _loc10_.TreeItems[_loc4_].Status = _loc2_.readInt();
                     _loc4_++;
                  }
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_3_ID:
               _loc11_ = this.FDecActiveDatas.GetActivityByIdentify(_loc6_) as TDecActive3;
               if(_loc11_)
               {
                  _loc11_.BarGold = _loc2_.readUnsignedInt();
                  _loc11_.RechargeGold = _loc2_.readUnsignedInt();
                  _loc3_ = int(_loc11_.RechargeAdd.length);
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_)
                  {
                     _loc11_.RechargeAdd[_loc4_].count = _loc2_.readInt();
                     _loc11_.RechargeAdd[_loc4_].gold = _loc2_.readInt();
                     _loc4_++;
                  }
                  _loc11_.MyScore = _loc2_.readUnsignedInt();
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_4_ID:
               _loc12_ = this.FDecActiveDatas.GetActivityByIdentify(_loc6_) as TDecActive4;
               if(_loc12_)
               {
                  _loc12_.RechargeGold = _loc2_.readUnsignedInt();
                  _loc3_ = int(_loc12_.BoxList.length);
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_)
                  {
                     _loc12_.BoxList[_loc4_].Status = _loc2_.readInt();
                     _loc4_++;
                  }
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
         var _loc24_:TDecActive1 = null;
         var _loc25_:TDecActive2 = null;
         var _loc26_:TDecActive3 = null;
         var _loc27_:TDecActive4 = null;
         var _loc28_:int = 0;
         var _loc29_:int = 0;
         var _loc30_:int = 0;
         var _loc31_:int = 0;
         var _loc32_:Vector.<uint> = null;
         var _loc33_:Vector.<uint> = null;
         var _loc34_:String = null;
         var _loc35_:TDessertHouseTask = null;
         var _loc36_:TSystemLanguage = null;
         var _loc37_:int = 0;
         var _loc38_:TLotteryNews = null;
         var _loc39_:int = 0;
         var _loc40_:Number = NaN;
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
               _loc24_ = this.FDecActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TDecActive1;
               if(_loc10_ == ACTIVITY_1_GET_DAILY_BOX)
               {
                  _loc24_.DailyBox.Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc24_.DailyBox.Inventories.Count)
                  {
                     _loc9_ = _loc24_.DailyBox.Inventories.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FDecActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FDecActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_LOTTERY)
               {
                  --_loc24_.LotteryCount;
                  ++_loc24_.Count;
                  _loc24_.LotteryIndex = _loc2_.readUnsignedInt() - 1;
                  _loc24_.ChangeStatus();
                  this.FDecActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FDecActiveDatas.CheckStatus());
                  this.FUIWindowVect[0].PlayMovie();
               }
               else if(_loc10_ == ACTIVITY_1_GET_LOTTERY_BOX)
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
                  this.FDecActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FDecActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_BUY_INVESTMENT)
               {
                  _loc24_.InvestIndex = _loc2_.readUnsignedInt() - 1;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED;
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FDecActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FDecActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_2_ID:
               _loc25_ = this.FDecActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TDecActive2;
               if(_loc10_ == ACTIVITY_2_GET_TICKET)
               {
                  _loc28_ = int(_loc2_.readUnsignedInt());
                  _loc25_.AddTicket(_loc28_);
                  ++_loc25_.SelectedCount;
                  _loc25_.PoolGold += _loc25_.Price;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED;
                  ProcessorEffectText(_loc4_);
                  _loc25_.ChangeStatus();
                  this.FDecActiveDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FDecActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_GET_LUCKY_BOX)
               {
                  --_loc25_.LuckyBox.Count;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc25_.LuckyBox.Inventories.Count)
                  {
                     _loc9_ = _loc25_.LuckyBox.Inventories.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc25_.ChangeStatus();
                  this.FDecActiveDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FDecActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_GET_GIFT)
               {
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
                  _loc25_.TreeLevel = _loc2_.readUnsignedInt();
                  _loc25_.BarGold = _loc2_.readUnsignedInt();
                  _loc25_.RechargeGold = _loc2_.readUnsignedInt();
                  if(_loc25_.TreeLevel == -1)
                  {
                     _loc5_ = 0;
                     while(_loc5_ < _loc25_.TreeItems.length)
                     {
                        _loc25_.TreeItems[_loc5_].Status = TBaseActivity.STATUS_GETED;
                        _loc5_++;
                     }
                     _loc5_ = 0;
                     while(_loc5_ < _loc25_.NeedGolds.length)
                     {
                        _loc25_.NeedGolds[_loc5_] = 0;
                        _loc5_++;
                     }
                  }
                  else
                  {
                     _loc5_ = 0;
                     while(_loc5_ < _loc25_.TreeItems.length)
                     {
                        _loc25_.TreeItems[_loc5_].Status = _loc2_.readUnsignedInt();
                        _loc5_++;
                     }
                     _loc5_ = 0;
                     while(_loc5_ < _loc25_.NeedGolds.length)
                     {
                        _loc25_.NeedGolds[_loc5_] = _loc2_.readUnsignedInt();
                        _loc5_++;
                     }
                  }
                  ProcessorEffectText(_loc4_);
                  _loc25_.ChangeStatus();
                  this.FDecActiveDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FDecActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_3_ID:
               _loc26_ = this.FDecActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TDecActive3;
               if(_loc10_ == ACTIVITY_3_PLAY_GAME)
               {
                  _loc26_.BossIndex = _loc2_.readUnsignedInt() - 1;
                  _loc26_.BallIndex = _loc2_.readUnsignedInt() - 1;
                  _loc14_ = int(_loc2_.readUnsignedInt());
                  _loc26_.MyScore = _loc2_.readUnsignedInt();
                  _loc26_.RankPoint += _loc14_;
                  _loc26_.ShopExchangePoint += _loc14_;
                  _loc26_.CheckStatus();
                  if(_loc14_ > 0)
                  {
                     ProcessorEffectText(TUtilityString.Format(_loc26_.DescListNew[5],_loc14_));
                     this.FUIWindowVect[2].PlayMovie(0,false);
                  }
                  else
                  {
                     ProcessorEffectText(_loc26_.DescListNew[6]);
                     this.FUIWindowVect[2].PlayMovie(0,true);
                  }
                  _loc26_.ChangeStatus();
                  this.FDecActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FDecActiveDatas.CheckStatus());
               }
               else if(_loc10_ == ACTIVITY_3_GET_GAME_BOX)
               {
                  _loc26_.RankPoint = _loc2_.readUnsignedInt();
                  _loc26_.ShopExchangePoint = _loc2_.readUnsignedInt();
                  --_loc26_.Gift.Count;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc26_.Gift.Inventories.Count)
                  {
                     _loc9_ = _loc26_.Gift.Inventories.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc26_.ChangeStatus();
                  this.FDecActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FDecActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_EXCHANGE_ITEM)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc26_.ShopExchangePoint = _loc2_.readUnsignedInt();
                  --_loc26_.ShopExchangeItems[_loc5_].LimitCount;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  _loc26_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FDecActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FDecActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_GET_REWARD)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc26_.ShopRewardItems[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
                  _loc26_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FDecActiveDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FDecActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_4_ID:
               _loc27_ = this.FDecActiveDatas.GetActivityByIdentify(ACTIVITY_4_ID) as TDecActive4;
               if(_loc10_ == ACTIVITY_4_PLAY_GAME)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc27_.EggStatus[_loc5_] = TBaseActivity.STATUS_GETED;
                  _loc27_.ScoreA = _loc2_.readUnsignedInt();
                  _loc27_.ScoreB = _loc2_.readUnsignedInt();
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
                  _loc21_ = _loc2_.readInt();
                  if(_loc21_ == 1)
                  {
                     _loc5_ = 0;
                     while(_loc5_ < _loc27_.EggStatus.length)
                     {
                        _loc27_.EggIndex[_loc5_] = _loc2_.readUnsignedInt();
                        _loc27_.EggStatus[_loc5_] = TBaseActivity.STATUS_CANNOTGET;
                        _loc5_++;
                     }
                  }
                  ProcessorEffectText(_loc4_);
                  _loc27_.ChangeStatus();
                  this.FDecActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FDecActiveDatas.CheckStatus());
                  this.FUIWindowVect[3].PlayMovie(0,_loc21_ == 1 ? true : false);
               }
               else if(_loc10_ == ACTIVITY_4_AUTO_PLAY)
               {
                  _loc27_.HalfCount = _loc27_.HalfCount > 0 ? int(_loc27_.HalfCount - 1) : 0;
                  _loc27_.ScoreA = _loc2_.readUnsignedInt();
                  _loc27_.ScoreB = _loc2_.readUnsignedInt();
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
                  _loc5_ = 0;
                  while(_loc5_ < _loc27_.EggStatus.length)
                  {
                     _loc27_.EggIndex[_loc5_] = _loc2_.readUnsignedInt();
                     _loc27_.EggStatus[_loc5_] = TBaseActivity.STATUS_CANNOTGET;
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc27_.ChangeStatus();
                  this.FDecActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FDecActiveDatas.CheckStatus());
                  this.FUIWindowVect[3].PlayMovie(2);
               }
               else if(_loc10_ == ACTIVITY_4_RESET_GAME)
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc27_.EggStatus.length)
                  {
                     _loc27_.EggIndex[_loc5_] = _loc2_.readUnsignedInt();
                     _loc27_.EggStatus[_loc5_] = TBaseActivity.STATUS_CANNOTGET;
                     _loc5_++;
                  }
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_RESET_TASK_SUCCESS);
                  _loc27_.ChangeStatus();
                  this.FDecActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FDecActiveDatas.CheckStatus());
                  this.FUIWindowVect[3].PlayMovie(1);
               }
               else if(_loc10_ == ACTIVITY_4_GET_GIFT)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc18_ = int(_loc2_.readUnsignedInt());
                  _loc6_ = 0;
                  while(_loc6_ < _loc27_.BoxList[_loc5_].Inventories.Count)
                  {
                     _loc16_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc14_ = int(_loc2_.readUnsignedInt());
                     _loc4_ += STRING_COMMON.GetItemNameByType(_loc16_,_loc11_) + "*" + _loc14_ + "\n";
                     _loc6_++;
                  }
                  _loc27_.ScoreA = _loc2_.readUnsignedInt();
                  _loc27_.ScoreB = _loc2_.readUnsignedInt();
                  _loc27_.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  ProcessorEffectText(_loc4_);
                  _loc27_.ChangeStatus();
                  this.FDecActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FDecActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_4_EXCHANGE_HERO)
               {
                  _loc27_.Hero.Status = TBaseActivity.STATUS_GETED;
                  _loc27_.ScoreB -= _loc27_.Hero.Price;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  ProcessorEffectText(_loc4_);
                  _loc27_.ChangeStatus();
                  this.FDecActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FDecActiveDatas.CheckStatus());
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
                  this.FDecActiveDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FDecActiveDatas.CheckStatus());
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
         _loc3_.writeShort(7);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"每累计登陆5天可免费获得1次抽奖机会\n再登陆%0天即可获得1次抽奖");
         TUtilityString.FlushUTF(_loc3_,"抽奖%0次");
         TUtilityString.FlushUTF(_loc3_,"每日可获得%0金币");
         TUtilityString.FlushUTF(_loc3_,"每日可获得%0金币");
         TUtilityString.FlushUTF(_loc3_,"每日可获得%0金币");
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(110);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
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
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(1);
            _loc3_.writeInt(_loc1_ + 1);
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
            TUtilityString.FlushUTF(_loc3_,"aaa");
            _loc3_.writeInt(_loc1_ + 1);
            _loc3_.writeInt(_loc1_ + 1);
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
         _loc3_.writeShort(14);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"奖池金币为玩家选号花费金币总和");
         TUtilityString.FlushUTF(_loc3_,"每充值满100金币可获得增加1次选号机会");
         TUtilityString.FlushUTF(_loc3_,"一等奖");
         TUtilityString.FlushUTF(_loc3_,"二等奖");
         TUtilityString.FlushUTF(_loc3_,"三等奖");
         TUtilityString.FlushUTF(_loc3_,"已满级");
         TUtilityString.FlushUTF(_loc3_,"未开奖");
         TUtilityString.FlushUTF(_loc3_,"未中奖");
         TUtilityString.FlushUTF(_loc3_,"号码%0*%1次");
         TUtilityString.FlushUTF(_loc3_,"无");
         TUtilityString.FlushUTF(_loc3_,"无");
         TUtilityString.FlushUTF(_loc3_,"无");
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeInt(1);
         _loc3_.writeUnsignedInt(STimingCore.GetServerTick() + 1000);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc3_.writeShort(1);
         _loc1_ = 0;
         while(_loc1_ < 1)
         {
            _loc3_.writeInt(1 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeInt(1 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeInt(1 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(1 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(1 + _loc1_);
            _loc3_.writeShort(1 + _loc1_);
            _loc2_ = 0;
            while(_loc2_ < _loc1_ + 1)
            {
               _loc3_.writeUnsignedInt(1 + _loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeShort(3 + _loc1_);
            _loc2_ = 0;
            while(_loc2_ < _loc1_ + 3)
            {
               TUtilityString.FlushUTF(_loc3_,"新浪 S1 名字有六个字" + _loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt((_loc1_ + 1) * 100);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(1);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(0);
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
         _loc3_.writeShort(24);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"消耗%0雪花");
         TUtilityString.FlushUTF(_loc3_,"每消耗%0/10个雪花可增加1次领取机会");
         TUtilityString.FlushUTF(_loc3_,"当前雪球消耗%0个雪花，是否花费%1金币补齐不足的%2个雪花？");
         TUtilityString.FlushUTF(_loc3_,"获得%0个收集物");
         TUtilityString.FlushUTF(_loc3_,"你啥眼神,这么近都没打中");
         TUtilityString.FlushUTF(_loc3_,"雪球1");
         TUtilityString.FlushUTF(_loc3_,"雪球2");
         TUtilityString.FlushUTF(_loc3_,"雪球3");
         TUtilityString.FlushUTF(_loc3_,"雪球1");
         TUtilityString.FlushUTF(_loc3_,"雪球2");
         TUtilityString.FlushUTF(_loc3_,"雪球3");
         TUtilityString.FlushUTF(_loc3_,"雪球3");
         TUtilityString.FlushUTF(_loc3_,"雪球3");
         TUtilityString.FlushUTF(_loc3_,"雪球1");
         TUtilityString.FlushUTF(_loc3_,"雪球2");
         TUtilityString.FlushUTF(_loc3_,"雪球3");
         TUtilityString.FlushUTF(_loc3_,"雪球1");
         TUtilityString.FlushUTF(_loc3_,"雪球2");
         TUtilityString.FlushUTF(_loc3_,"雪球3");
         TUtilityString.FlushUTF(_loc3_,"雪球1");
         TUtilityString.FlushUTF(_loc3_,"雪球2");
         TUtilityString.FlushUTF(_loc3_,"雪球3");
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeShort(3);
            _loc3_.writeInt(_loc1_ + 1);
            _loc3_.writeInt(_loc1_ + 2);
            _loc3_.writeInt(_loc1_ + 3);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt((_loc1_ + 1) * 50);
            _loc3_.writeUnsignedInt((_loc1_ + 1) * 50);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(20);
         _loc1_ = 0;
         while(_loc1_ < 20)
         {
            _loc3_.writeInt(3);
            _loc3_.writeInt(_loc1_ + 1);
            _loc3_.writeInt(_loc1_ % 2);
            _loc3_.writeShort(1);
            _loc2_ = 0;
            while(_loc2_ < 1)
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
            _loc3_.writeInt(1);
            _loc3_.writeInt(_loc1_ + 1);
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
      
      public function Test4() : void
      {
      }
   }
}

