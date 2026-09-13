package Processors.Game.Lobby.Exercise.BaseActivity
{
   import Externals.SExternalCore;
   import Foundation.Common.TBounds;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.BaseRank.TActiveRankDataNew;
   import Logics.Exercise.BaseRank.TActiveRankDatas;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerActiveRank;
   import Logics.Streamization.Exercise.TUnstreamizerActiveRankNew;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Exercise.ActiveRank.TProcessorActiveRank;
   import Processors.Game.Lobby.Exercise.ActiveRank.TProcessorActiveRankNew;
   import Processors.Game.Lobby.Exercise.ActiveRank.TProcessorActiveRankOld;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Rendering.Overlayers.Box.TOverlayerBoxNew;
   import Rendering.Overlayers.Title.TOverlayerTitle;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_EFFECT;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TProcessorBaseActivity extends TProcessorLobbyWindows
   {
      
      public static const CAPACITY_ParallelOutputRows:uint = CONST_EFFECT.CAPACITY_ParallelOutputRows;
      
      public static const WINDOW_EQUIPMENT_DESC:int = 0;
      
      public static const WINDOW_TITLE_DESC:int = 4;
      
      public static const WINDOW_TITLE_DESC_NEW:int = 10;
      
      public static const WINDOW_HERO_DESC_NEW:int = 11;
      
      public static const WINDOW_PET_DESC_NEW:int = 12;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FBTN_Log:MovieClip;
      
      protected var FBTN_Desc:MovieClip;
      
      protected var FBTN_Recharge:MovieClip;
      
      protected var FMC_EffectLeft:MovieClip;
      
      protected var FMC_EffectRight:MovieClip;
      
      protected var FTF_Time:TextField;
      
      protected var FTF_Desc:TextField;
      
      protected var FTF_Date:TextField;
      
      protected var FInitialized:Boolean;
      
      protected var FEndTime:int;
      
      protected var FBounds:TBounds;
      
      protected var FDelayTimeID:int;
      
      protected var FEndTimeID:int;
      
      protected var FTimeID:int;
      
      protected var FCurWindowType:int;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FProcessorWindowLog:TProcessorWindowLog;
      
      protected var FProcessorWindowDesc:TProcessorWindowDesc;
      
      protected var FProcessorWindowPetDesc:TProcessorWindowPetDesc;
      
      protected var FProcessorWindowTitleDescNew:TProcessorWindowTitleDescNew;
      
      protected var FProcessorWindowHeroDesc:TProcessorWindowRecruit;
      
      protected var FProcessorActiveRank:TProcessorActiveRank;
      
      protected var FProcessorActiveRankNew:TProcessorActiveRankNew;
      
      protected var FProcessorActiveRankOld:TProcessorActiveRankOld;
      
      protected var FProcessorWindowEquip:TProcessorWindowEquipDesc;
      
      protected var FProcessorWindowTitle:TProcessorWindowTitleDesc;
      
      protected var FAllTitlesEffect:TTitles;
      
      protected var FOverlayerTitleEffect:TOverlayerTitle;
      
      protected var FActivityID:int;
      
      protected var FIndex:int;
      
      protected var FIdentify:int;
      
      protected var FNeedConfig:Boolean;
      
      protected var FReqType:int;
      
      protected var FIsMovieVisible:Boolean;
      
      protected var FUnstreamizerInventory:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerActiveRank:TUnstreamizerActiveRank;
      
      protected var FUnstreamizerActiveRankNew:TUnstreamizerActiveRankNew;
      
      protected var FUnstreamizerTitleEffect:TUnstreamizerTitle;
      
      protected var FOverlayerBoxNew:TOverlayerBoxNew;
      
      protected var FActiveRankDatas:TActiveRankDatas;
      
      protected var FActiveRankDataNew:TActiveRankDataNew;
      
      protected var FOnOpenActivity:Function;
      
      protected var FCheckEffect:Function;
      
      protected var FOnShowHeroInfo:Function;
      
      protected var FOnAddTitle:Function;
      
      protected var FOnGoto:Function;
      
      public function TProcessorBaseActivity(param1:TUIComponent, param2:TLobbyParameters, param3:int)
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Vector.<uint> = null;
         super(param1,param2);
         this.FActivityID = param3;
         this.FActiveRankDatas = SLogicsCore.ActiveRankDatas;
         this.FActiveRankDataNew = SLogicsCore.ActiveRankDataNew;
         this.FBounds = new TBounds();
         _loc6_ = CONST_BASEACTIVITY.ACTIVELIST_THIRD_TYPE;
         _loc5_ = _loc6_.indexOf(this.FActivityID);
         if(_loc5_ != -1)
         {
            this.FBounds.Width = CONST_BASEACTIVITY.ACTIVELIST_THIRD_STAGE_Width[_loc5_];
            this.FBounds.Height = CONST_BASEACTIVITY.ACTIVELIST_THIRD_STAGE_Height[_loc5_];
         }
         else
         {
            _loc4_ = CONST_BASEACTIVITY.NEW_ACTIVELIST_TYPE.indexOf(this.FActivityID);
            this.FBounds.Width = CONST_BASEACTIVITY.NEW_ACTIVELIST_STAGE_Width[_loc4_];
            this.FBounds.Height = CONST_BASEACTIVITY.NEW_ACTIVELIST_STAGE_Height[_loc4_];
         }
         ComponentBoundsCenter(this,this.FBounds);
         this.FProcessorWindowPetDesc = new TProcessorWindowPetDesc(this.Parent);
         this.FProcessorWindowLog = new TProcessorWindowLog(this.Parent);
         this.FProcessorWindowDesc = new TProcessorWindowDesc(this.Parent);
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FProcessorActiveRank = new TProcessorActiveRank(this.Parent);
         this.FProcessorActiveRankNew = new TProcessorActiveRankNew(this.Parent);
         this.FProcessorActiveRankOld = new TProcessorActiveRankOld(this.Parent);
         this.FProcessorWindowTitleDescNew = new TProcessorWindowTitleDescNew(this.Parent);
         this.FProcessorWindowHeroDesc = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowEquip = new TProcessorWindowEquipDesc(this.Parent);
         this.FProcessorWindowTitle = new TProcessorWindowTitleDesc(this.Parent);
         this.FUnstreamizerInventory = new TUnstreamizerInventoryReference();
         this.FUnstreamizerActiveRank = new TUnstreamizerActiveRank();
         this.FUnstreamizerActiveRankNew = new TUnstreamizerActiveRankNew();
         this.FUnstreamizerTitleEffect = new TUnstreamizerTitle();
         this.FNeedConfig = true;
         this.FInitialized = false;
         this.FAllTitlesEffect = new TTitles();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<uint> = null;
         _loc3_ = CONST_BASEACTIVITY.ACTIVELIST_THIRD_TYPE;
         _loc2_ = _loc3_.indexOf(this.FActivityID);
         if(_loc2_ != -1)
         {
            SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BASEACTIVITY.ACTIVELIST_THIRD_RESOURCESID[_loc2_]);
         }
         else
         {
            _loc1_ = CONST_BASEACTIVITY.NEW_ACTIVELIST_TYPE.indexOf(this.FActivityID);
            SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BASEACTIVITY.NEW_ACTIVELIST_RESOURCESID[_loc1_]);
         }
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<uint> = null;
         _loc3_ = CONST_BASEACTIVITY.ACTIVELIST_THIRD_TYPE;
         _loc2_ = _loc3_.indexOf(this.FActivityID);
         if(_loc2_ != -1)
         {
            this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_BASEACTIVITY.ACTIVELIST_THIRD_RESOURCE_ClassName[_loc2_]) as MovieClip;
         }
         else
         {
            _loc1_ = CONST_BASEACTIVITY.NEW_ACTIVELIST_TYPE.indexOf(this.FActivityID);
            this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_BASEACTIVITY.NEW_ACTIVELIST_RESOURCE_ClassName[_loc1_]) as MovieClip;
         }
         addChild(this.FMC_Scene);
         this.FMC_EffectLeft = this.FMC_Scene[CONST_BASEACTIVITY.RESOURCE_Link_MC_EffectLeft];
         this.FMC_EffectRight = this.FMC_Scene[CONST_BASEACTIVITY.RESOURCE_Link_MC_EffectRight];
         this.FBTN_Close = this.FMC_Scene[CONST_BASEACTIVITY.RESOURCE_Link_BTN_Close];
         this.FBTN_Help = this.FMC_Scene[CONST_BASEACTIVITY.RESOURCE_Link_BTN_Help];
         this.FBTN_Log = this.FMC_Scene[CONST_BASEACTIVITY.RESOURCE_Link_BTN_Log];
         this.FBTN_Desc = this.FMC_Scene[CONST_BASEACTIVITY.RESOURCE_Link_BTN_Desc];
         this.FTF_Time = this.FMC_Scene[CONST_BASEACTIVITY.RESOURCE_Link_TF_Time];
         this.FTF_Desc = this.FMC_Scene[CONST_BASEACTIVITY.RESOURCE_Link_TF_Desc];
         this.FTF_Date = this.FMC_Scene[CONST_BASEACTIVITY.RESOURCE_Link_TF_Date];
         this.FBTN_Recharge = this.FMC_Scene["BTN_GotoRecharge"];
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.OnCancel = this.WindowCofirmationOnCancel;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.FProcessorWindowPetDesc.Visible = false;
         this.FProcessorWindowPetDesc.x = (CONST_COMMON.STAGE_Width - 699) / 2;
         this.FProcessorWindowPetDesc.y = (CONST_COMMON.STAGE_Height - 379) / 2;
         this.FProcessorWindowTitleDescNew.Visible = false;
         this.FProcessorWindowTitleDescNew.OnCloseUp = this.ProcessorOnHideItemDesc;
         this.FProcessorWindowHeroDesc.Visible = false;
         this.FProcessorWindowHeroDesc.OnEffectText = FOnEffectText;
         this.FProcessorWindowHeroDesc.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowHeroDesc.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowHeroDesc.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowHeroDesc.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FProcessorWindowEquip.OnCloseUp = this.ProcessorOnHideOtherWindow;
         this.FProcessorWindowEquip.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowEquip.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowEquip.Visible = false;
         this.FProcessorWindowTitle.OnCloseUp = this.ProcessorOnHideOtherWindow;
         this.FProcessorWindowTitle.TitleHintOnOver = this.ProcessorOnTitleEffectOver;
         this.FProcessorWindowTitle.TitleHintOnOut = this.ProcessorOnTitleEffectOut;
         this.FProcessorWindowTitle.Visible = false;
         this.FOverlayerTitleEffect = new TOverlayerTitle(this.Parent);
         this.FOverlayerTitleEffect.Visible = false;
         this.FOverlayerBoxNew = new TOverlayerBoxNew(this.Parent);
         this.FOverlayerBoxNew.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBoxNew);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTitleEffect);
         this.FUnstreamizerTitleEffect.UnstreamizeTitleByDatabase(null,this.FAllTitlesEffect,null);
         this.ResourcesPerform_UIDispatchWindow();
         this.FInitialized = true;
         super.ResourcesPerform_UIDispatch();
         SetUIModuleID(CONST_MODULES.ACTIVE_Test);
      }
      
      protected function ResourcesPerform_UIDispatchWindow() : void
      {
         this.FProcessorWindowLog.OnCloseUp = this.ProcessorOnCloseLog;
         this.FProcessorWindowLog.Visible = false;
         this.FProcessorWindowDesc.OnCloseUp = this.ProcessorOnCloseDesc;
         this.FProcessorWindowDesc.Visible = false;
         this.FProcessorActiveRank.OnCloseUp = this.ProcessorOnCloseActiveRank;
         this.FProcessorActiveRank.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorActiveRank.OnOut = UIComponentsHintOnOut;
         this.FProcessorActiveRank.Visible = false;
         this.FProcessorActiveRankNew.OnCloseUp = this.ProcessorOnCloseActiveRankNew;
         this.FProcessorActiveRankNew.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorActiveRankNew.OnOut = UIComponentsHintOnOut;
         this.FProcessorActiveRankNew.TitleHintOnOver = this.ProcessorOnTitleEffectOver;
         this.FProcessorActiveRankNew.TitleHintOnOut = this.ProcessorOnTitleEffectOut;
         this.FProcessorActiveRankNew.Visible = false;
         this.FProcessorActiveRankOld.OnCloseUp = this.ProcessorOnCloseActiveRankNew;
         this.FProcessorActiveRankOld.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorActiveRankOld.OnOut = UIComponentsHintOnOut;
         this.FProcessorActiveRankOld.TitleHintOnOver = this.ProcessorOnTitleEffectOver;
         this.FProcessorActiveRankOld.TitleHintOnOut = this.ProcessorOnTitleEffectOut;
         this.FProcessorActiveRankOld.Visible = false;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         if(this.FBTN_Close)
         {
            this.FBTN_Close.addEventListener(MouseEvent.CLICK,OnClose);
         }
         if(this.FBTN_Help)
         {
            this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonHelpOnOver);
            this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
         }
         if(this.FBTN_Log)
         {
            this.FBTN_Log.addEventListener(MouseEvent.CLICK,this.PerformPacket_CS_LoadLogReq);
            TGameUtil.setButtonMode(this.FBTN_Log,true);
         }
         if(this.FBTN_Desc)
         {
            this.FBTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenDesc);
            TGameUtil.setButtonMode(this.FBTN_Desc,true);
         }
         if(this.FBTN_Recharge)
         {
            TGameUtil.setButtonMode(this.FBTN_Recharge,true);
            this.FBTN_Recharge.addEventListener(MouseEvent.CLICK,this.ProcessorOnRechargeUp);
         }
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(Boolean(this.FMC_Scene) && this.FMC_Scene.visible)
         {
            if(this.FProcessorWindowPetDesc != null && this.FProcessorWindowPetDesc.Visible == true)
            {
               this.FProcessorWindowPetDesc.UpdataBitmap();
            }
            if(this.FProcessorWindowTitleDescNew != null && this.FProcessorWindowTitleDescNew.Visible)
            {
               this.FProcessorWindowTitleDescNew.UpdataBitmap();
            }
            if(this.FProcessorWindowHeroDesc != null && this.FProcessorWindowHeroDesc.Visible == true)
            {
               this.FProcessorWindowHeroDesc.UpdataBitmap();
            }
         }
      }
      
      protected function UpdateUI() : void
      {
      }
      
      protected function ProcessorDelayCloseActivity() : void
      {
         if(this.FEndTimeID != 0)
         {
            clearTimeout(this.FEndTimeID);
            this.FEndTimeID = 0;
         }
         var _loc1_:Number = (this.FEndTime - STimingCore.GetServerTick()) * 1000;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         if(_loc1_ > int.MAX_VALUE)
         {
            _loc1_ = int.MAX_VALUE;
         }
         this.FEndTimeID = setTimeout(this.ProcessorCloseActivity,_loc1_);
         clearTimeout(this.FDelayTimeID);
      }
      
      protected function ProcessorCloseActivity() : void
      {
         var _loc1_:Vector.<uint> = null;
         var _loc2_:int = 0;
         _loc1_ = CONST_BASEACTIVITY.ACTIVELIST_THIRD_TYPE;
         _loc2_ = _loc1_.indexOf(this.FActivityID);
         if(_loc2_ != -1)
         {
            SLogicsCore.ActivityThirdModes.SetActivityStatus(this.FActivityID,false);
         }
         else
         {
            SLogicsCore.NewActivityModes.SetActivityStatus(this.FActivityID,false);
         }
         if(this.visible)
         {
            ProcessorClose();
         }
         if(this.FOnOpenActivity != null)
         {
            this.FOnOpenActivity(this.FActivityID);
         }
         clearTimeout(this.FEndTimeID);
         this.FEndTimeID = 0;
      }
      
      protected function SetInterval() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this.FTimeID != 0)
         {
            clearTimeout(this.FTimeID);
            this.FTimeID = 0;
         }
         var _loc1_:Date = new Date(STimingCore.GetServerTime() * 1000);
         _loc1_.hours = 0;
         _loc1_.minutes = 0;
         _loc1_.seconds = 0;
         _loc3_ = _loc1_.getTime() + 24 * 60 * 60 * 1000 + 5000;
         _loc2_ = _loc3_ - STimingCore.GetServerTime() * 1000;
         this.FTimeID = setTimeout(this.PerformPacket_CS_LoadInfoReq,_loc2_);
      }
      
      protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HappyTreasure_LoadInfoReq);
         _loc1_.Data.writeUnsignedInt(this.ActivityID);
         if(this.FNeedConfig)
         {
            _loc1_.Data.writeUnsignedInt(TBaseActivity.NEED_CONFIG);
         }
         else
         {
            _loc1_.Data.writeUnsignedInt(TBaseActivity.NOT_NEED_CONFIG);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_BuyBoxReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_BuyBoxReq);
         _loc2_.Data.writeUnsignedInt(this.ActivityID);
         _loc2_.Data.writeUnsignedInt(this.FIdentify);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_CS_GetRewardReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_GetRewardReq);
         _loc2_.Data.writeUnsignedInt(this.ActivityID);
         _loc2_.Data.writeUnsignedInt(this.FIdentify);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_CS_LoadLogReq(param1:MouseEvent = null) : void
      {
      }
      
      protected function PerformPacket_CS_AllReq(param1:int, param2:Vector.<int> = null, param3:String = "") : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         this.FReqType = param1;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_AllActivity_Req);
         _loc4_.Data.writeUnsignedInt(this.FActivityID);
         _loc4_.Data.writeUnsignedInt(param1);
         if(param2 == null)
         {
            _loc4_.Data.writeShort(0);
         }
         else
         {
            _loc7_ = int(param2.length);
            _loc4_.Data.writeShort(_loc7_);
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               _loc4_.Data.writeUnsignedInt(param2[_loc6_]);
               _loc6_++;
            }
         }
         TUtilityString.FlushUTF(_loc4_.Data,param3);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function PerformPacket_CS_AcitivityThird_LoadLogReq(param1:int, param2:Vector.<int> = null) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this.FReqType = param1;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ActivityThird_LoadLogReq);
         _loc3_.Data.writeUnsignedInt(this.FActivityID);
         _loc3_.Data.writeUnsignedInt(param1);
         if(param2 == null)
         {
            _loc3_.Data.writeShort(0);
         }
         else
         {
            _loc6_ = int(param2.length);
            _loc3_.Data.writeShort(_loc6_);
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc3_.Data.writeUnsignedInt(param2[_loc5_]);
               _loc5_++;
            }
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ProcessorCheckEffect(param1:uint, param2:Boolean) : void
      {
         if(this.FCheckEffect != null)
         {
            this.FCheckEffect(param1,param2);
         }
      }
      
      protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
      }
      
      protected function WindowCofirmationOnCancel(param1:Object = null) : void
      {
      }
      
      protected function ProcessorOnOpenDesc(param1:MouseEvent = null) : void
      {
         this.FProcessorWindowDesc.Visible = true;
         this.FProcessorWindowDesc.UpdateUI();
      }
      
      protected function ProcessorOnOpenDescNew(param1:String) : void
      {
         this.FProcessorWindowDesc.Visible = true;
         this.FProcessorWindowDesc.UpdateUI(param1);
      }
      
      protected function ProcessorOnCloseLog() : void
      {
         this.FProcessorWindowLog.Visible = false;
      }
      
      protected function ProcessorOnCloseDesc() : void
      {
         this.FProcessorWindowDesc.Visible = false;
      }
      
      protected function ProcessorOnCloseActiveRank() : void
      {
         this.FProcessorActiveRank.Visible = false;
      }
      
      protected function ProcessorOnCloseActiveRankNew() : void
      {
         this.FProcessorActiveRankNew.Visible = false;
         this.FProcessorActiveRankOld.Visible = false;
      }
      
      protected function ProcessorEffectText(param1:String, param2:TEffectTextParameters = null, param3:TEffectCoordinateParameters = null, param4:uint = 5) : void
      {
         if(FOnEffectText != null)
         {
            FOnEffectText(this,param1,param2,param3,param4);
         }
      }
      
      protected function ProcessorOnShowGotoRecharge() : void
      {
         this.FUIWindowRecharge.Visible = true;
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
      }
      
      protected function ProcessorOnTitleEffectOver(param1:uint) : void
      {
         var _loc2_:TTitle = null;
         _loc2_ = this.FAllTitlesEffect.GetTitleByIdentifier(param1);
         if(_loc2_ != null)
         {
            this.FOverlayerTitleEffect.Context = _loc2_;
            this.FOverlayerTitleEffect.Render(FUICore.MouseCoordinate);
            this.FOverlayerTitleEffect.Show();
         }
      }
      
      protected function ProcessorOnTitleEffectOut() : void
      {
         this.FOverlayerTitleEffect.Hide();
      }
      
      protected function ProcessorOnShowHeroInfo(param1:uint, param2:uint) : void
      {
         if(this.FOnShowHeroInfo != null)
         {
            this.FOnShowHeroInfo(param1,param2);
         }
      }
      
      protected function ProcessorOnAddTitle(param1:uint) : void
      {
         if(this.FOnAddTitle != null)
         {
            this.FOnAddTitle(param1);
         }
      }
      
      protected function ProcessorOnShowTip(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         FHtmlHint.Caption = param1;
         FOverlayerHint.Context = FHtmlHint;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.Show();
      }
      
      protected function ProcessorOnHideTip() : void
      {
         FOverlayerHint.Hide();
      }
      
      protected function ProcessorOnRechargeUp(param1:MouseEvent = null) : void
      {
         SExternalCore.NavigateToRecharge();
      }
      
      protected function ProcessorOnNewBoxOver(param1:TInventories, param2:String = "") : void
      {
         if(param1 != null)
         {
            if(param2 == "")
            {
               param2 = STRING_BASEACTIVITY.FORMAT_BOX_CONTEXT;
            }
            this.FOverlayerBoxNew.Desc = param2;
            this.FOverlayerBoxNew.Context = param1;
            this.FOverlayerBoxNew.Render(FUICore.MouseCoordinate);
            this.FOverlayerBoxNew.Show();
         }
      }
      
      protected function ProcessorOnNewBoxOut(param1:MouseEvent = null) : void
      {
         this.FOverlayerBoxNew.Hide();
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
      
      public function get ActivityID() : int
      {
         return this.FActivityID;
      }
      
      public function set ActivityID(param1:int) : void
      {
         this.FActivityID = param1;
      }
      
      public function get OnAddTitle() : Function
      {
         return this.FOnAddTitle;
      }
      
      public function set OnAddTitle(param1:Function) : void
      {
         this.FOnAddTitle = param1;
      }
      
      public function get IsMovieVisible() : Boolean
      {
         return this.FIsMovieVisible;
      }
      
      public function set IsMovieVisible(param1:Boolean) : void
      {
         this.FIsMovieVisible = param1;
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
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FUIWindowConfirmation.Load();
            this.FUIWindowRecharge.Load();
            this.FProcessorWindowLog.Load();
            this.FProcessorWindowDesc.Load();
            this.FProcessorWindowPetDesc.Load();
            this.FProcessorActiveRank.Load();
            this.FProcessorActiveRankNew.Load();
            this.FProcessorActiveRankOld.Load();
            this.FProcessorWindowTitleDescNew.Load();
            this.FProcessorWindowHeroDesc.Load();
            this.FProcessorWindowEquip.Load();
            this.FProcessorWindowTitle.Load();
            return;
         }
         if(this.FMC_Scene)
         {
            this.FMC_Scene.visible = true;
         }
      }
      
      override public function Unmount() : void
      {
         if(this.FMC_EffectLeft)
         {
            this.FMC_EffectLeft.stop();
         }
         if(this.FMC_EffectRight)
         {
            this.FMC_EffectRight.stop();
         }
         this.FProcessorWindowLog.Visible = false;
         this.FUIWindowConfirmation.Visible = false;
         this.FUIWindowRecharge.Visible = false;
         if(this.FMC_Scene)
         {
            this.FMC_Scene.visible = false;
         }
         if(this.FTimeID != 0)
         {
            clearTimeout(this.FTimeID);
            this.FTimeID = 0;
         }
         super.Unmount();
      }
      
      public function ProcessorOnOpenActive(param1:Boolean, param2:int) : void
      {
         this.FEndTime = param2;
         if(!param1 && this.visible)
         {
            ProcessorClose();
         }
         if(this.FOnOpenActivity != null)
         {
            this.FOnOpenActivity(this.FActivityID);
         }
         if(this.FDelayTimeID != 0)
         {
            clearTimeout(this.FDelayTimeID);
            this.FDelayTimeID = 0;
         }
         this.FDelayTimeID = setTimeout(this.ProcessorDelayCloseActivity,10 * 1000);
      }
      
      public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
      }
      
      public function ProcessorOnLoadNewsRet(param1:TPacket = null) : void
      {
      }
      
      public function ProcessorOnLoadExchangeItemRet(param1:TPacket = null) : void
      {
      }
      
      public function ProcessorBuyBoxRet(param1:TPacket = null) : void
      {
      }
      
      public function ProcessorGetRewardRet(param1:TPacket = null) : void
      {
      }
      
      public function ProcessorLoadLogRet(param1:TPacket = null) : void
      {
      }
      
      public function ProcessorLoadItemLogRet(param1:TPacket = null) : void
      {
      }
      
      public function ProcessorChangeStatus(param1:TPacket = null) : void
      {
      }
      
      public function ProcessorChangeGold(param1:TPacket = null) : void
      {
      }
      
      public function ProcessorExchangePet(param1:TPacket = null) : void
      {
      }
      
      public function ProcessorGetStone(param1:TPacket = null) : void
      {
      }
      
      public function ProcessorAllRet(param1:TPacket = null) : void
      {
      }
      
      public function ProcessorLoadRankRet(param1:TPacket = null) : void
      {
      }
      
      protected function ProcessorOnShowPet(param1:uint) : void
      {
      }
      
      public function ProcessorActivityThirdLoadLogRet(param1:TPacket = null) : void
      {
      }
      
      public function ProcessorUnstreamActivityLog(param1:TBaseActivity, param2:ByteArray) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TInventory = null;
         var _loc8_:TInventories = null;
         var _loc9_:TLotteryNews = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:TBins = null;
         var _loc16_:int = 0;
         var _loc17_:TSystemLanguage = null;
         var _loc18_:int = 0;
         _loc4_ = param2.readShort();
         param1.LogList.length = 0;
         _loc4_ = param2.readShort();
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc9_ = new TLotteryNews();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc6_ = int(param2.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc6_ / 5)
            {
               _loc11_ = param2.readUnsignedInt();
               _loc10_ = param2.readUnsignedInt();
               _loc12_ = CONST_COMMON.GetItemIDByType(_loc11_,_loc10_,_loc15_);
               _loc13_.push(_loc12_);
               _loc14_.push(param2.readUnsignedInt());
               _loc9_.GetTime = param2.readUnsignedInt();
               _loc18_ = int(param2.readUnsignedInt());
               if(_loc18_ != 0)
               {
                  _loc17_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,_loc18_) as TSystemLanguage;
                  if(_loc17_ == null)
                  {
                     throw new Error("SystemLanguage未找到 " + _loc18_);
                  }
                  _loc9_.GetSource = _loc17_.Desc;
               }
               else
               {
                  _loc9_.GetSource = "";
               }
               _loc5_++;
            }
            _loc8_ = new TInventories();
            this.FUnstreamizerInventory.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc13_);
            _loc7_ = _loc8_.GetInventoryByIndex(0);
            _loc7_.Quantity = _loc14_[0];
            _loc9_.Inventory = _loc7_;
            _loc9_.Inventories = _loc8_;
            param1.LogList.push(_loc9_);
            _loc3_++;
         }
         this.FProcessorWindowLog.BaseActivity = param1;
         this.FProcessorWindowLog.UpdateUI();
         this.FProcessorWindowLog.Visible = true;
      }
      
      public function ProcessorOnRewardLogRet(param1:TPacket = null) : void
      {
      }
      
      public function ProcessorOnTreasuresInfoRet(param1:TPacket) : void
      {
      }
      
      public function ProcessorOnCDKActiveRet(param1:TPacket) : void
      {
      }
      
      public function ProcessorOnLoadTaskInfoRet(param1:TPacket = null) : void
      {
      }
      
      public function ProcessorOnGoto(param1:uint) : void
      {
         if(this.FOnGoto != null)
         {
            this.FOnGoto(param1);
         }
      }
      
      public function ProcessorLoadInfoReq(param1:int = 0) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HappyTreasure_LoadInfoReq);
         _loc2_.Data.writeUnsignedInt(this.FActivityID);
         _loc2_.Data.writeUnsignedInt(param1 + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnChangeRankTab() : void
      {
      }
      
      protected function ProcessorOnLoadActiveRank(param1:int, param2:int = 1) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:int = 0;
         this.ProcessorLoadActiveRankNew(param1);
      }
      
      public function ProcessorLoadActiveRankRet(param1:TPacket = null) : void
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
         this.FUnstreamizerActiveRank.Unstreamize(_loc2_,this.FActiveRankDatas,null);
         this.FProcessorActiveRank.UpdateUI();
         this.FProcessorActiveRank.Visible = true;
      }
      
      protected function ProcessorLoadActiveRankNew(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActive_LoadRankReqNew);
         _loc2_.Data.writeUnsignedInt(this.FActivityID);
         _loc2_.Data.writeUnsignedInt(param1);
         _loc2_.Data.writeShort(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function ProcessorLoadActiveRankRetNew(param1:TPacket = null) : void
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
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         this.FUnstreamizerActiveRankNew.Unstreamize(_loc2_,this.FActiveRankDataNew,null);
         this.FProcessorActiveRankNew.UpdateUI();
         this.FProcessorActiveRankNew.Visible = true;
      }
      
      public function ProcessorOnShowItemDesc(param1:uint, param2:int = 0) : void
      {
         if(param2 == TBaseBox.TYPE_IS_HERO)
         {
            this.FProcessorWindowHeroDesc.SetHeroData(param1);
         }
         else if(param2 == TBaseBox.TYPE_IS_PET)
         {
            this.FProcessorWindowPetDesc.SetPetData(param1);
         }
         else if(param2 == TBaseBox.TYPE_IS_TITLE)
         {
            this.FProcessorWindowTitleDescNew.visible = true;
            this.FProcessorWindowTitleDescNew.UpdateUI(param1);
         }
      }
      
      public function ProcessorOnHideItemDesc(param1:int) : void
      {
         if(param1 == WINDOW_HERO_DESC_NEW)
         {
            this.FProcessorWindowHeroDesc.visible = false;
         }
         else if(param1 == WINDOW_PET_DESC_NEW)
         {
            this.FProcessorWindowPetDesc.visible = false;
         }
         else if(param1 == WINDOW_TITLE_DESC_NEW)
         {
            this.FProcessorWindowTitleDescNew.visible = false;
         }
      }
      
      protected function ProcessorOnLoadRank_New(param1:TBaseActivity) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         if(param1.RankType == TBaseActivity.RANK_TYPE_1)
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SpringFestival_LoadRankInfoReq);
            _loc2_.Data.writeUnsignedInt(this.FActivityID);
            _loc2_.Data.writeUnsignedInt(param1.RankIndex);
            _loc2_.Data.writeShort(0);
         }
         else if(param1.RankType == TBaseActivity.RANK_TYPE_3)
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActive_LoadRankReqNew);
            _loc2_.Data.writeUnsignedInt(this.FActivityID);
            _loc2_.Data.writeUnsignedInt(param1.RankIndex);
            _loc2_.Data.writeShort(0);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function ProcessorOnShowOtherWindow(param1:int, param2:TBaseActivity) : void
      {
         this.FCurWindowType = param1;
         switch(this.FCurWindowType)
         {
            case WINDOW_EQUIPMENT_DESC:
               this.FProcessorWindowEquip.Visible = true;
               this.FProcessorWindowEquip.UpdateUI(param2.Equipments);
               return;
            case WINDOW_TITLE_DESC:
               this.FProcessorWindowTitle.Visible = true;
               this.FProcessorWindowTitle.UpdateUI(param2.Titles);
               return;
            default:
               return;
         }
      }
      
      protected function ProcessorOnHideOtherWindow(param1:int = 0) : void
      {
         this.FCurWindowType = 0;
         switch(param1)
         {
            case WINDOW_EQUIPMENT_DESC:
               this.FProcessorWindowEquip.Visible = false;
               break;
            case WINDOW_TITLE_DESC:
               this.FProcessorWindowTitle.Visible = false;
         }
      }
   }
}

