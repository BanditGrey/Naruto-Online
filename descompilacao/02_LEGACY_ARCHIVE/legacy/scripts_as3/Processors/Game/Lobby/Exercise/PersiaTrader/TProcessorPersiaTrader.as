package Processors.Game.Lobby.Exercise.PersiaTrader
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.PersiaTrader.TPersiaTrader;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerPersiaTrader;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowTitleDesc;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
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
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorPersiaTrader extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      public static const TAB_COUNT:int = 4;
      
      public static const ACTIVITY_1_FREE_FRESH_ALL_ITEM:int = 1;
      
      public static const ACTIVITY_1_GOLD_FRESH_ALL_ITEM:int = 2;
      
      public static const ACTIVITY_1_FRESH_ITEM:int = 3;
      
      public static const ACTIVITY_1_FRESH_PRICE:int = 4;
      
      public static const ACTIVITY_1_BUY_ITEM:int = 5;
      
      public static const ACTIVITY_2_EXCHANGE_ITEM:int = 6;
      
      public static const ACTIVITY_3_INIT:int = 7;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      public static const DELAY_TIME:int = 100;
      
      protected static const SHOW_ITEM_COUNT:int = 4;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIPersiaTrader1,TUIPersiaTrader2,TUIPersiaTrader3,TUIPersiaTrader4]);
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FPersiaTrader:TPersiaTrader;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      protected var FUnstreamizerPersiaTrader:TUnstreamizerPersiaTrader;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FBuyBoxDate:Object;
      
      protected var FProcessorWindowTitleDesc:TProcessorWindowTitleDesc;
      
      protected var FUIWindowConfirmationRefresh:TUIWindowConfirmation;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FIsOpen:Boolean;
      
      protected var FStrLength:int;
      
      protected var FWindowType:int;
      
      protected var FInitCDTime:int;
      
      protected var FShowItem:TUIShowItem;
      
      public function TProcessorPersiaTrader(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FPersiaTrader = SLogicsCore.PersiaTrader;
         this.FUnstreamizerPersiaTrader = new TUnstreamizerPersiaTrader();
         this.FUnstreamizerTitle = new TUnstreamizerTitle();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FTabList = new Vector.<MovieClip>(TAB_COUNT);
         this.FChangeTabIndex = 0;
         this.FGlowsFilter = new Vector.<TEffectBaseGlowTwo>(TAB_COUNT);
         this.FUIWindowVect = new Vector.<TUIBaseWindow>(TAB_COUNT);
         this.FOverlayerBox = new TOverlayerBox(this.Parent);
         this.FOverlayerBox.Visible = false;
         this.FBuyBoxDate = new Object();
         this.FProcessorWindowTitleDesc = new TProcessorWindowTitleDesc(this.Parent);
         this.FUIWindowConfirmationRefresh = new TUIWindowConfirmation(this.Parent);
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
            this.FTabList[_loc1_] = FMC_Scene["MC_Tab" + _loc1_];
            this.FTabList[_loc1_].gotoAndStop(_loc1_ + 1);
            this.FTabList[_loc1_].MC_Name.gotoAndStop(_loc1_ + 1);
            this.FTabList[_loc1_].buttonMode = true;
            this.FTabList[_loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnChangePage);
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
            this.FUIWindowVect[_loc1_].OnShowFlowText = ProcessorEffectText;
            this.FUIWindowVect[_loc1_].OnShowHtmlTip = ProcessorOnShowHtmlText;
            this.FUIWindowVect[_loc1_].OnHideHtmlTip = ProcessorOnHideHtmlText;
            this.FUIWindowVect[_loc1_].OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FUIWindowVect[_loc1_].OnLoadRank = this.ProcessorOnLoadRank;
            this.FUIWindowVect[_loc1_].GotoRecharge = ProcessorOnRechargeUp;
            this.FUIWindowVect[_loc1_].OnCloseWindow = this.ProcessorOnCloseWindow;
            this.FUIWindowVect[_loc1_].OnGoto = ProcessorOnGoto;
            this.FUIWindowVect[_loc1_].OnShowWindow = this.ProcessorOnShowWindow;
            this.FUIWindowVect[_loc1_].OnUpdateWindow = this.PerformPacket_CS_LoadInfoReq;
            _loc1_++;
         }
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem.OnOut = UIComponentsHintOnOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FProcessorWindowTitleDesc.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorWindowTitleDesc.TitleHintOnOver = this.ProcessorOnTitleOver;
         this.FProcessorWindowTitleDesc.TitleHintOnOut = this.ProcessorOnTitleOut;
         this.FProcessorWindowTitleDesc.Visible = false;
         this.FUIWindowConfirmationRefresh.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmationRefresh.OnCancel = WindowCofirmationOnCancel;
         this.FUIWindowConfirmationRefresh.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmationRefresh.WindowWidth) / 2;
         this.FUIWindowConfirmationRefresh.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmationRefresh.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationRefresh);
         this.FUIWindowConfirmationRefresh.SetCheckBox(false);
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
            this.FUIWindowVect[this.FChangeTabIndex].LogicsPerform();
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
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
         while(_loc1_ < TAB_COUNT)
         {
            _loc2_ = this.FTabList[_loc1_];
            if(_loc1_ == this.FChangeTabIndex)
            {
               _loc2_.gotoAndStop(2);
               this.FUIWindowVect[_loc1_].SetVisible(true);
               this.FUIWindowVect[_loc1_].UpdateUI();
            }
            else
            {
               _loc2_.gotoAndStop(1);
               this.FUIWindowVect[_loc1_].SetVisible(false);
            }
            _loc1_++;
         }
         this.FShowItem.UpdateUI(this.FPersiaTrader.HotList);
      }
      
      protected function ProcessorOnChangePage(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseActivity = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(_loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         if(this.FChangeTabIndex == 2 && STimingCore.GetServerTick() >= this.FInitCDTime + DELAY_TIME)
         {
            this.FInitCDTime = STimingCore.GetServerTick();
            PerformPacket_CS_AllReq(ACTIVITY_3_INIT);
         }
         else
         {
            this.PerformPacket_CS_LoadInfoReq();
         }
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0, param7:int = 0) : void
      {
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxIndex = param3;
         this.FBuyBoxDate.Cost = param2;
         this.FBuyBoxDate.CostType = param4;
         this.FBuyBoxDate.BoxIndex1 = param6;
         this.FBuyBoxDate.ConfirmType = param7;
         if(param4 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
            return;
         }
         if(param7 == 0)
         {
            if(!FUIWindowConfirmation.IsSelected)
            {
               if(param5 != "")
               {
                  FUIWindowConfirmation.Text = param5;
               }
               else
               {
                  FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,param2);
               }
               FUIWindowConfirmation.SetCheckBox(true);
               FUIWindowConfirmation.Visible = true;
            }
            else
            {
               this.WindowConfirmationOnOK();
            }
         }
         else if(param7 != 0)
         {
            if(!this.FUIWindowConfirmationRefresh.IsSelected)
            {
               if(param5 != "")
               {
                  this.FUIWindowConfirmationRefresh.Text = param5;
               }
               else
               {
                  this.FUIWindowConfirmationRefresh.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,param2);
               }
               this.FUIWindowConfirmationRefresh.SetCheckBox(false);
               this.FUIWindowConfirmationRefresh.Visible = true;
            }
            else
            {
               this.WindowConfirmationOnOK();
            }
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGold >= this.FBuyBoxDate.Cost)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int = 0, param3:int = 0) : void
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
         if(param2 != 0)
         {
            _loc6_.push(param2);
         }
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
      
      override protected function ProcessorOnOpenDesc(param1:MouseEvent = null) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FPersiaTrader;
         super.ProcessorOnOpenDesc();
      }
      
      override protected function PerformPacket_CS_LoadLogReq(param1:MouseEvent = null) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int = 0) : void
      {
         ProcessorOnShowItemDesc(param1,param2);
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
         this.FWindowType = param1;
         switch(param1)
         {
            case WINDOW_EQUIPMENT_DESC:
               return;
            case WINDOW_TITLE_DESC:
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
            case WINDOW_TITLE_DESC:
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTitleDesc.Load();
            this.FUIWindowConfirmationRefresh.Load();
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
         this.FUnstreamizerPersiaTrader.Unstreamize(_loc2_,this.FPersiaTrader,null);
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
         ProcessorUnstreamActivityLog(this.FPersiaTrader,_loc2_);
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
         _loc2_ = param1.Data;
         _loc2_.readShort();
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
         var _loc16_:TBins = null;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:Vector.<Object> = null;
         var _loc22_:TConfigValue = null;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         var _loc28_:Vector.<uint> = null;
         var _loc29_:Vector.<uint> = null;
         var _loc30_:Vector.<uint> = null;
         var _loc31_:Vector.<uint> = null;
         var _loc32_:String = null;
         var _loc33_:TSystemLanguage = null;
         var _loc34_:int = 0;
         var _loc35_:TLotteryNews = null;
         var _loc36_:int = 0;
         var _loc37_:Number = NaN;
         this.FBeClicked = false;
         _loc16_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc22_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.DROP_ITEM_NAME) as TConfigValue;
         _loc21_ = _loc22_.Value as Vector.<Object>;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc7_)
         {
            case ACTIVITY_1_BUY_ITEM:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FPersiaTrader.Score = _loc2_.readUnsignedInt();
               this.FPersiaTrader.TotalConsumeGold = _loc2_.readUnsignedInt();
               this.FPersiaTrader.SaleItems[_loc5_].Status = TBaseActivity.STATUS_GETED;
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
               this.FPersiaTrader.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FPersiaTrader.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_FRESH_ITEM:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FPersiaTrader.SaleItems[_loc5_] = this.SetNewSaleItem(_loc2_,_loc16_);
               this.FPersiaTrader.Score = _loc2_.readUnsignedInt();
               this.FPersiaTrader.TotalConsumeGold = _loc2_.readUnsignedInt();
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_REFRESH_SUCCESSED);
               this.FPersiaTrader.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FPersiaTrader.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_FRESH_PRICE:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FPersiaTrader.SaleItems[_loc5_].CurPrice = _loc2_.readUnsignedInt();
               this.FPersiaTrader.Score = _loc2_.readUnsignedInt();
               this.FPersiaTrader.TotalConsumeGold = _loc2_.readUnsignedInt();
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_REFRESH_SUCCESSED);
               this.FPersiaTrader.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FPersiaTrader.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_FREE_FRESH_ALL_ITEM:
            case ACTIVITY_1_GOLD_FRESH_ALL_ITEM:
               this.FPersiaTrader.NextTime = _loc2_.readInt();
               _loc17_ = int(this.FPersiaTrader.SaleItems.length);
               _loc5_ = 0;
               while(_loc5_ < _loc17_)
               {
                  this.FPersiaTrader.SaleItems[_loc5_] = this.SetNewSaleItem(_loc2_,_loc16_);
                  _loc5_++;
               }
               this.FPersiaTrader.Score = _loc2_.readUnsignedInt();
               this.FPersiaTrader.TotalConsumeGold = _loc2_.readUnsignedInt();
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_REFRESH_SUCCESSED);
               this.FPersiaTrader.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FPersiaTrader.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_2_EXCHANGE_ITEM:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               --this.FPersiaTrader.ExchangeItems[_loc5_].LimitCount;
               this.FPersiaTrader.Score = _loc2_.readUnsignedInt();
               _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
               ProcessorEffectText(_loc4_);
               this.FPersiaTrader.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FPersiaTrader.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_3_INIT:
               this.FUnstreamizerPersiaTrader.UnstreamizeShowList(_loc2_,this.FPersiaTrader,null);
               this.UpdateUI();
         }
      }
      
      public function SetNewSaleItem(param1:ByteArray, param2:TBins) : TBaseBox
      {
         var _loc3_:TBaseBox = null;
         var _loc4_:TInventories = null;
         var _loc5_:TInventory = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:Vector.<uint> = null;
         var _loc12_:Vector.<uint> = null;
         _loc9_ = new Vector.<uint>();
         _loc10_ = new Vector.<uint>();
         _loc11_ = new Vector.<uint>();
         _loc12_ = new Vector.<uint>();
         _loc3_ = new TBaseBox();
         _loc3_.Min = param1.readUnsignedInt();
         _loc3_.Price = param1.readUnsignedInt();
         _loc3_.CurPrice = param1.readUnsignedInt();
         _loc3_.Status = param1.readInt();
         _loc4_ = new TInventories();
         _loc11_.length = 0;
         _loc12_.length = 0;
         _loc9_.length = 0;
         _loc10_.length = 0;
         _loc11_.push(param1.readUnsignedInt());
         _loc12_.push(param1.readUnsignedInt());
         _loc6_ = param1.readUnsignedInt();
         _loc7_ = param1.readUnsignedInt();
         _loc8_ = CONST_COMMON.GetItemIDByType(_loc6_,_loc7_,param2);
         _loc9_.push(_loc8_);
         _loc10_.push(param1.readUnsignedInt());
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc4_,_loc9_);
         _loc5_ = _loc4_.GetInventoryByIndex(0);
         _loc5_.Quantity = _loc10_[0];
         _loc5_.NewType = _loc11_[0];
         _loc5_.NewIdentify = _loc12_[0];
         _loc3_.Inventories = _loc4_;
         return _loc3_;
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(6);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"%0花费%1金币购买了%2");
         TUtilityString.FlushUTF(_loc3_,"刷新单个物品花费%0金币");
         TUtilityString.FlushUTF(_loc3_,"刷新单个物品价格花费%0金币");
         TUtilityString.FlushUTF(_loc3_,"%0,%1花费%2金币购买了%3");
         TUtilityString.FlushUTF(_loc3_,"当前已达到最低价格，是否继续刷新");
         TUtilityString.FlushUTF(_loc3_,"当前有特殊道具，是否继续刷新");
         TUtilityString.FlushUTF(_loc3_,"当前有特殊道具，是否继续刷新");
         _loc3_.writeUnsignedInt(STimingCore.GetServerTick() + 10);
         _loc3_.writeUnsignedInt(10);
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
            _loc3_.writeInt(2);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(1);
            _loc3_.writeInt(2);
            _loc3_.writeInt(3);
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            TUtilityString.FlushUTF(_loc3_,"aaa");
            _loc3_.writeInt(2);
            _loc3_.writeInt(3);
            _loc3_.writeInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(12);
         _loc1_ = 0;
         while(_loc1_ < 12)
         {
            _loc3_.writeInt(1);
            _loc3_.writeInt(2);
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

