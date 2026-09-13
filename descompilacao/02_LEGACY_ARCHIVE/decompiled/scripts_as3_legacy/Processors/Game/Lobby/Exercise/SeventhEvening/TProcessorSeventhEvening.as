package Processors.Game.Lobby.Exercise.SeventhEvening
{
   import Foundation.Common.TBounds;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.SeventhEvening.TSeventhEvening;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TExchangeItem;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerSeventhEvening;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowPetDesc;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Rendering.Overlayers.Box.TOverlayerBox;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.SeventhEvening.TOverlayerBallon;
   import Rendering.Overlayers.Title.TOverlayerTitle;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SEVENTHEVENING;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_Ramen;
   import Resources.Strings.STRING_SEVENTHEVENING;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorSeventhEvening extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH:uint = 609;
      
      protected static const SIZE_HEIGHT:uint = 485;
      
      protected static const BOX_COUNT:int = TSeventhEvening.BOX_COUNT;
      
      protected static const PERSON_COUNT:int = TSeventhEvening.PERSON_COUNT;
      
      protected static const BALLON_COUNT:int = TSeventhEvening.BALLON_COUNT;
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FBTN_Log:MovieClip;
      
      protected var FBTN_Desc:MovieClip;
      
      protected var FBTN_Rank:MovieClip;
      
      protected var FBTN_Exchange:MovieClip;
      
      protected var FMC_Box:MovieClip;
      
      protected var FMC_Bridge0:MovieClip;
      
      protected var FMC_Bridge1:MovieClip;
      
      protected var FMC_BigBox:MovieClip;
      
      protected var FMC_SmallBox:MovieClip;
      
      protected var FTF_Time:TextField;
      
      protected var FTF_PerPoint:TextField;
      
      protected var FTF_TotalPoint:TextField;
      
      protected var FTF_Count:TextField;
      
      protected var FNameList:Vector.<TextField>;
      
      protected var FBallonList:Vector.<MovieClip>;
      
      protected var FInitialized:Boolean;
      
      protected var FEndTime:int;
      
      protected var FBounds:TBounds;
      
      protected var FDelayTimeID:int;
      
      protected var FEndTimeID:int;
      
      protected var FTimeID:int;
      
      protected var FProcessorSeventhEveningRank:TProcessorSeventhEveningRank;
      
      protected var FProcessorWindowSeventhEveningExchange:TProcessorWindowSeventhEveningExchange;
      
      protected var FProcessorWindowSeventhEveningDesc:TProcessorWindowSeventhEveningDesc;
      
      protected var FProcessorWindowSeventhEveningLog:TProcessorWindowSeventhEveningLog;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorWindowPetDesc:TProcessorWindowPetDesc;
      
      protected var FOverlayerBallon:TOverlayerBallon;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FSeventhEvening:TSeventhEvening;
      
      protected var FUnstreamizerSeventhEvening:TUnstreamizerSeventhEvening;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FIndex:int;
      
      protected var FMaxMaskWidth:int;
      
      protected var FBallonIndex:int;
      
      protected var FCurDayZeroClock:int;
      
      protected var FBeClicked:Boolean;
      
      protected var FOnOpenActivity:Function;
      
      protected var FCheckEffect:Function;
      
      protected var FOnShowHeroInfo:Function;
      
      public function TProcessorSeventhEvening(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorSeventhEveningRank = new TProcessorSeventhEveningRank(this.Parent);
         this.FProcessorWindowSeventhEveningExchange = new TProcessorWindowSeventhEveningExchange(this.Parent);
         this.FProcessorWindowSeventhEveningDesc = new TProcessorWindowSeventhEveningDesc(this.Parent);
         this.FProcessorWindowSeventhEveningLog = new TProcessorWindowSeventhEveningLog(this.Parent);
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowPetDesc = new TProcessorWindowPetDesc(this.Parent);
         this.FProcessorWindowPetDesc.Visible = false;
         this.FSeventhEvening = SLogicsCore.SeventhEvening;
         this.FUnstreamizerTitle = new TUnstreamizerTitle();
         this.FUnstreamizerSeventhEvening = new TUnstreamizerSeventhEvening();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FNameList = new Vector.<TextField>(BOX_COUNT * PERSON_COUNT);
         this.FBallonList = new Vector.<MovieClip>(BALLON_COUNT);
         this.FOverlayerBallon = new TOverlayerBallon(this.Parent);
         this.FOverlayerBallon.Visible = false;
         this.FOverlayerBox = new TOverlayerBox(this.Parent);
         this.FOverlayerBox.Visible = false;
         this.FOverlayerTitle = new TOverlayerTitle(this.Parent);
         this.FOverlayerTitle.Visible = false;
         this.FAllTitles = new TTitles();
         this.FInitialized = false;
         this.FBounds = new TBounds();
         this.FBounds.Width = SIZE_WIDTH;
         this.FBounds.Height = SIZE_HEIGHT;
         ComponentBoundsCenter(this,this.FBounds);
         SetUIModuleID(CONST_MODULES.ACTIVE_Test);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SEVENTHEVENING.RESOURCESID_SWF_SEVENTHEVENING);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_SEVENTHEVENING.RESOURCE_MC_SeventhEvening) as MovieClip;
         addChild(this.FMC_Scene);
         this.FBTN_Close = this.FMC_Scene[CONST_SEVENTHEVENING.RESOURCE_Link_BTN_Close];
         this.FBTN_Help = this.FMC_Scene[CONST_SEVENTHEVENING.RESOURCE_Link_BTN_Help];
         this.FBTN_Log = this.FMC_Scene[CONST_SEVENTHEVENING.RESOURCE_Link_BTN_Log];
         this.FBTN_Desc = this.FMC_Scene[CONST_SEVENTHEVENING.RESOURCE_Link_BTN_Desc];
         this.FBTN_Rank = this.FMC_Scene[CONST_SEVENTHEVENING.RESOURCE_Link_BTN_Rank];
         this.FBTN_Exchange = this.FMC_Scene[CONST_SEVENTHEVENING.RESOURCE_Link_BTN_Exchange];
         this.FTF_Time = this.FMC_Scene[CONST_SEVENTHEVENING.RESOURCE_Link_TF_Time];
         this.FTF_PerPoint = this.FMC_Scene["TF_PerPoint"];
         this.FTF_TotalPoint = this.FMC_Scene["TF_TotalPoint"];
         this.FTF_Count = this.FMC_Scene["TF_Count"];
         this.FMC_Box = this.FMC_Scene["MC_Box"];
         this.FMC_Box.buttonMode = true;
         this.FMC_Bridge0 = this.FMC_Scene["MC_Bridge0"];
         this.FMC_Bridge1 = this.FMC_Scene["MC_Bridge1"];
         this.FMaxMaskWidth = this.FMC_Bridge0.MC_Mask.width;
         this.FMC_BigBox = this.FMC_Scene["MC_BigBox"];
         this.FMC_SmallBox = this.FMC_Scene["MC_SmallBox"];
         _loc2_ = PERSON_COUNT * BOX_COUNT;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FNameList[_loc1_] = this.FMC_Scene["TF_Name" + _loc1_];
            _loc1_++;
         }
         _loc2_ = BALLON_COUNT;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FBallonList[_loc1_] = this.FMC_Scene["MC_Balloon" + _loc1_];
            this.FBallonList[_loc1_].MC_BallonPic.gotoAndStop(_loc1_ + 1);
            if(_loc1_ == 0)
            {
               this.FBallonList[_loc1_].MC_BallonPic.mc_ball0.MC_StandBy.play();
            }
            this.FBallonList[_loc1_].MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBallonOver);
            this.FBallonList[_loc1_].MC_Tip.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnBallonOut);
            this.FBallonList[_loc1_].MC_Tip.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyUp);
            _loc1_++;
         }
         this.ResourcesPerform_WindowUIDispatch();
         this.FInitialized = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function ResourcesPerform_WindowUIDispatch() : void
      {
         this.FProcessorSeventhEveningRank.OnCloseUp = this.ProcessorOnCloseRank;
         this.FProcessorSeventhEveningRank.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorSeventhEveningRank.OnOut = UIComponentsHintOnOut;
         this.FProcessorSeventhEveningRank.TitleHintOnOver = this.ProcessorOnTitleOver;
         this.FProcessorSeventhEveningRank.TitleHintOnOut = this.ProcessorOnTitleOut;
         this.FProcessorSeventhEveningRank.Visible = false;
         this.FProcessorWindowSeventhEveningExchange.OnCloseUp = this.ProcessorOnCloseExchange;
         this.FProcessorWindowSeventhEveningExchange.OnExchange = this.PerformPacket_CS_ExchangeReq;
         this.FProcessorWindowSeventhEveningExchange.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowSeventhEveningExchange.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowSeventhEveningExchange.TipOnOver = ProcessorTipOnOver;
         this.FProcessorWindowSeventhEveningExchange.TipOnOut = ProcessorTipOnOut;
         this.FProcessorWindowSeventhEveningExchange.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FProcessorWindowSeventhEveningExchange.Visible = false;
         this.FProcessorWindowSeventhEveningDesc.OnCloseUp = this.ProcessorOnCloseDesc;
         this.FProcessorWindowSeventhEveningDesc.Visible = false;
         this.FProcessorWindowSeventhEveningLog.OnCloseUp = this.ProcessorOnCloseLog;
         this.FProcessorWindowSeventhEveningLog.Visible = false;
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.OnCancel = this.WindowCofirmationOnCancel;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2 + 80;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = CONST_COMMON.STAGE_Width - 400 >> 1;
         this.FProcessorWindowRecruit.y = CONST_COMMON.STAGE_Height - 367 >> 1;
         this.FProcessorWindowPetDesc.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowPetDesc.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         FOverlayerEquipment = new TOverlayerEquipment(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerAppliance.Visible = false;
         FOverlayerHint = new TOverlayerHint(this.Parent);
         FOverlayerHint.visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerAccessory.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBallon);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBox);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTitle);
         this.FUnstreamizerTitle.UnstreamizeTitleByDatabase(null,this.FAllTitles,null);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,OnClose);
         this.FBTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLogUp);
         this.FBTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnDescUp);
         this.FBTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnRankUp);
         this.FBTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         this.FMC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnBoxUp);
         this.FMC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
         this.FMC_Box.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnBoxOut);
         this.FMC_BigBox.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
         this.FMC_BigBox.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnBoxOut);
         this.FMC_SmallBox.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
         this.FMC_SmallBox.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnBoxOut);
         TGameUtil.setButtonMode(this.FBTN_Log,true);
         TGameUtil.setButtonMode(this.FBTN_Desc,true);
         TGameUtil.setButtonMode(this.FBTN_Rank,true);
         TGameUtil.setButtonMode(this.FBTN_Exchange,true);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FInitialized)
         {
            if(this.visible)
            {
               if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
               {
                  this.FProcessorWindowRecruit.UpdataBitmap();
               }
               if(this.FProcessorWindowPetDesc != null && this.FProcessorWindowPetDesc.Visible == true)
               {
                  this.FProcessorWindowPetDesc.UpdataBitmap();
               }
               this.FTF_Time.text = TGameUtil.fomatTime(this.FCurDayZeroClock - STimingCore.GetServerTick());
            }
         }
      }
      
      protected function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateBalloon();
         this.UpdateBridge();
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FTF_PerPoint.text = this.FSeventhEvening.RankPoint.toString();
         this.FTF_TotalPoint.text = this.FSeventhEvening.TotalHeartScore + "/" + this.FSeventhEvening.MaxTotalHeartScore;
         this.FTF_Count.text = this.FSeventhEvening.FreeCount.toString() + STRING_SEVENTHEVENING.FORMAT_COUNTS_NAME;
         _loc2_ = PERSON_COUNT * BOX_COUNT;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc1_ < PERSON_COUNT)
            {
               if(this.FSeventhEvening.HeartRewardName[_loc1_] == null)
               {
                  this.FNameList[_loc1_].text = STRING_SEVENTHEVENING.FORMAT_NONE_NAME;
               }
               else
               {
                  this.FNameList[_loc1_].text = this.FSeventhEvening.HeartRewardName[_loc1_];
               }
            }
            else if(this.FSeventhEvening.FreeHeartRewardName[_loc1_ - PERSON_COUNT] == null)
            {
               this.FNameList[_loc1_].text = STRING_SEVENTHEVENING.FORMAT_NONE_NAME;
            }
            else
            {
               this.FNameList[_loc1_].text = this.FSeventhEvening.FreeHeartRewardName[_loc1_ - PERSON_COUNT];
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBalloon() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         if(this.FSeventhEvening.FreeCount > 0)
         {
            if(this.FBallonList[0].MC_BallonPic.mc_ball0.Btn_GetReward)
            {
               this.FBallonList[0].MC_BallonPic.mc_ball0.Btn_GetReward.gotoAndStop(1);
            }
         }
         else if(this.FBallonList[0].MC_BallonPic.mc_ball0.Btn_GetReward)
         {
            this.FBallonList[0].MC_BallonPic.mc_ball0.Btn_GetReward.gotoAndStop(5);
         }
      }
      
      protected function UpdateBridge() : void
      {
         var _loc1_:int = 0;
         if(this.FSeventhEvening.SeventhEveningRewardStatus == TBaseActivity.STATUS_CANGET)
         {
            this.FMC_Box.gotoAndPlay(1);
         }
         else
         {
            this.FMC_Box.gotoAndStop(1);
         }
         _loc1_ = Number(this.FSeventhEvening.TotalHeartScore / this.FSeventhEvening.MaxTotalHeartScore) * this.FMaxMaskWidth;
         this.FMC_Bridge0.MC_Mask.width = Math.min(_loc1_,this.FMaxMaskWidth);
         this.FMC_Bridge1.MC_Mask.width = Math.min(_loc1_,this.FMaxMaskWidth);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SeventhEvening_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SeventhEvening_BuyBoxRet,this.PerformPacket_SC_BuyBoxRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SeventhEvening_ExchangeRet,this.PerformPacket_SC_ExchangeRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SeventhEvening_GetRewardRet,this.PerformPacket_SC_GetRewardRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SeventhEvening_OpenActivityRet,this.PerformPacket_SC_OpenActiveRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SeventhEvening_ChangeStatusRet,this.PerformPacket_SC_ChangeStatusRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SeventhEvening_LoadExchangeRet,this.PerformPacket_SC_LoadExchangeRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SeventhEvening_LoadRankRet,this.PerformPacket_SC_LoadRankRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SeventhEvening_ChangeScoreRet,this.PerformPacket_SC_ChangeScoreRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SeventhEvening_LoadLogRet,this.PerformPacket_SC_LoadLogRet);
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
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_SeventhEvening,false);
         if(this.visible)
         {
            ProcessorClose();
         }
         if(this.FOnOpenActivity != null)
         {
            this.FOnOpenActivity();
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
         this.FCurDayZeroClock = _loc3_ / 1000;
         this.FTimeID = setTimeout(this.PerformPacket_CS_LoadInfoReq,_loc2_);
      }
      
      protected function PerformPacket_SC_OpenActiveRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = int(_loc2_.readUnsignedByte());
         var _loc4_:Boolean = _loc3_ == 0 ? false : true;
         this.FEndTime = _loc2_.readUnsignedInt();
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_SeventhEvening,_loc4_);
         if(!_loc4_ && this.visible)
         {
            ProcessorClose();
         }
         if(this.FOnOpenActivity != null)
         {
            this.FOnOpenActivity();
         }
         if(this.FDelayTimeID != 0)
         {
            clearTimeout(this.FDelayTimeID);
            this.FDelayTimeID = 0;
         }
         this.FDelayTimeID = setTimeout(this.ProcessorDelayCloseActivity,10 * 1000);
      }
      
      protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SeventhEvening_LoadInfoReq);
         if(this.FSeventhEvening.NeedConfig)
         {
            _loc1_.Data.writeUnsignedInt(1);
         }
         else
         {
            _loc1_.Data.writeUnsignedInt(0);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_LoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         this.FUnstreamizerSeventhEvening.Unstreamize(_loc2_,this.FSeventhEvening,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
            this.FProcessorSeventhEveningRank.Visible = false;
            this.FProcessorWindowSeventhEveningExchange.Visible = false;
            this.FProcessorWindowSeventhEveningDesc.Visible = false;
            this.FProcessorWindowSeventhEveningLog.Visible = false;
         }
      }
      
      protected function PerformPacket_CS_LoadExchangeReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SeventhEvening_LoadExchangeReq);
         if(this.FSeventhEvening.NeedExchangeConfig)
         {
            _loc1_.Data.writeUnsignedInt(1);
         }
         else
         {
            _loc1_.Data.writeUnsignedInt(0);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_LoadExchangeRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventories = null;
         var _loc6_:Vector.<uint> = null;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:TInventory = null;
         var _loc9_:int = 0;
         var _loc10_:TExchangeItem = null;
         _loc2_ = param1.Data;
         _loc9_ = _loc2_.readInt();
         if(_loc9_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc9_);
            ProcessorClose();
            return;
         }
         this.FSeventhEvening.Magpie = _loc2_.readUnsignedInt();
         _loc3_ = int(_loc2_.readUnsignedShort());
         if(this.FSeventhEvening.NeedExchangeConfig)
         {
            _loc6_ = new Vector.<uint>();
            _loc7_ = new Vector.<uint>();
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc6_.push(_loc2_.readUnsignedInt());
               _loc7_.push(_loc2_.readUnsignedInt());
               _loc4_++;
            }
            _loc5_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc5_,_loc6_);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc8_ = _loc5_.GetInventoryByIndex(_loc4_);
               _loc8_.Quantity = _loc7_[_loc4_];
               _loc4_++;
            }
            this.FSeventhEvening.ExchangeInventories = _loc5_;
            this.FSeventhEvening.NeedExchangeConfig = false;
         }
         _loc3_ = int(_loc2_.readUnsignedShort());
         this.FSeventhEvening.ExchangeItemList.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc10_ = new TExchangeItem();
            _loc10_.Identify = _loc2_.readUnsignedInt();
            _loc10_.CostPoint = _loc2_.readUnsignedInt();
            _loc10_.BuyCount = _loc2_.readUnsignedInt();
            _loc10_.LimitCount = _loc2_.readUnsignedInt();
            this.FSeventhEvening.ExchangeItemList.push(_loc10_);
            _loc4_++;
         }
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.FProcessorWindowSeventhEveningExchange.UpdateUI();
            this.FProcessorWindowSeventhEveningExchange.Visible = true;
            this.FProcessorSeventhEveningRank.Visible = false;
            this.FProcessorWindowSeventhEveningDesc.Visible = false;
            this.FProcessorWindowSeventhEveningLog.Visible = false;
         }
      }
      
      protected function PerformPacket_CS_LoadRankReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SeventhEvening_LoadRankReq);
         _loc1_.Data.writeUnsignedInt(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_LoadRankRet(param1:TPacket = null) : void
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
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         this.FSeventhEvening.RankGiftList.length = 0;
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
            this.FSeventhEvening.RankGiftList.push(_loc7_);
            _loc4_++;
         }
         this.FSeventhEvening.RankPlayerList.length = 0;
         _loc5_ = int(_loc2_.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = new TConsumeRankInfo();
            _loc6_.UserName = TUtilityString.FetchUTF(_loc2_);
            _loc6_.ServerName = TUtilityString.FetchUTF(_loc2_);
            _loc6_.Rank = _loc2_.readUnsignedInt();
            _loc6_.Score = _loc2_.readUnsignedInt();
            this.FSeventhEvening.RankPlayerList.push(_loc6_);
            _loc4_++;
         }
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.FProcessorWindowSeventhEveningExchange.Visible = false;
            this.FProcessorSeventhEveningRank.Visible = true;
            this.FProcessorWindowSeventhEveningDesc.Visible = false;
            this.FProcessorWindowSeventhEveningLog.Visible = false;
            this.FProcessorSeventhEveningRank.UpdateUI();
         }
      }
      
      protected function PerformPacket_CS_LoadLogReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SeventhEvening_LoadLogReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_LoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TLotteryNews = null;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:TInventories = null;
         var _loc9_:TInventory = null;
         var _loc10_:int = 0;
         _loc2_ = param1.Data;
         _loc5_ = _loc2_.readInt();
         if(_loc5_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc5_);
            ProcessorClose();
            return;
         }
         _loc3_ = int(_loc2_.readUnsignedShort());
         this.FSeventhEvening.LogList.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = new TLotteryNews();
            _loc7_ = new Vector.<uint>();
            _loc7_.push(_loc2_.readUnsignedInt());
            _loc10_ = int(_loc2_.readUnsignedInt());
            _loc6_.GetTime = _loc2_.readUnsignedInt();
            _loc8_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc7_);
            _loc9_ = _loc8_.GetInventoryByIndex(0);
            _loc9_.Quantity = _loc10_;
            _loc6_.Inventories = _loc8_;
            this.FSeventhEvening.LogList.push(_loc6_);
            _loc4_++;
         }
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.FProcessorWindowSeventhEveningExchange.Visible = false;
            this.FProcessorSeventhEveningRank.Visible = false;
            this.FProcessorWindowSeventhEveningDesc.Visible = false;
            this.FProcessorWindowSeventhEveningLog.Visible = true;
            this.FProcessorWindowSeventhEveningLog.UpdateUI();
         }
      }
      
      protected function ProcessorOnBuyUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.currentTarget.parent.name.slice(10));
         this.FIndex = _loc2_;
         if(this.FBeClicked)
         {
            return;
         }
         if(_loc2_ == 0)
         {
            if(this.FSeventhEvening.FreeCount > 0)
            {
               this.PerformPacket_CS_BuyBoxReq();
            }
            else
            {
               this.UpdateBalloon();
            }
         }
         else if(!this.FUIWindowConfirmation.IsSelected)
         {
            this.FUIWindowConfirmation.Text = TUtilityString.Format(STRING_Ramen.FORMAT_MakeRamenOnce,this.FSeventhEvening.BallonList[_loc2_].Price);
            this.FUIWindowConfirmation.SetCheckBox(true);
            this.FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FSeventhEvening.BallonList[this.FIndex].Price;
         if(!this.FSeventhEvening.IsGoldEnough(_loc2_))
         {
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         this.PerformPacket_CS_BuyBoxReq();
      }
      
      protected function WindowCofirmationOnCancel(param1:Object = null) : void
      {
         this.UpdateBalloon();
      }
      
      protected function PerformPacket_CS_BuyBoxReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SeventhEvening_BuyBoxReq);
         _loc2_ = _loc1_.Data;
         _loc3_ = this.FSeventhEvening.BallonList[this.FIndex].Identify;
         _loc2_.writeInt(_loc3_);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         this.FBeClicked = true;
      }
      
      protected function PerformPacket_SC_BuyBoxRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TInventories = null;
         var _loc7_:TInventory = null;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:MovieClip = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.FBeClicked = false;
            this.UpdateUI();
         }
         else
         {
            _loc12_ = int(_loc2_.readUnsignedInt());
            _loc11_ = int(_loc2_.readUnsignedInt());
            this.FSeventhEvening.RankPoint += _loc12_;
            this.FSeventhEvening.PerHeartScore += _loc11_;
            if(this.FIndex == 0)
            {
               --this.FSeventhEvening.FreeCount;
            }
            _loc8_ = new Vector.<uint>();
            _loc8_.push(_loc2_.readUnsignedInt());
            _loc9_ = int(_loc2_.readUnsignedInt());
            _loc6_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc6_,_loc8_);
            _loc7_ = _loc6_.GetInventoryByIndex(0);
            _loc10_ = TUtilityString.Format(STRING_SEVENTHEVENING.FORMAT_GET_HEART_SCORE,_loc11_) + "\n";
            _loc10_ = _loc10_ + (TUtilityString.Format(STRING_SEVENTHEVENING.FORMAT_GET_MAGPIE,_loc12_) + "\n");
            _loc10_ = _loc10_ + (_loc7_.Name + "*" + _loc9_ + "\n");
            this.FBallonIndex = this.FIndex;
            switch(this.FIndex)
            {
               case 0:
                  this.FBallonList[0].MC_BallonPic.mc_ball0.gotoAndStop(2);
                  _loc13_ = this.FBallonList[0].MC_BallonPic.mc_ball0.MC_Effect;
                  break;
               case 1:
                  this.FBallonList[1].MC_BallonPic.mc_ball1.gotoAndStop(2);
                  _loc13_ = this.FBallonList[1].MC_BallonPic.mc_ball1.MC_Effect;
                  break;
               case 2:
                  this.FBallonList[2].MC_BallonPic.mc_ball2.gotoAndStop(2);
                  _loc13_ = this.FBallonList[2].MC_BallonPic.mc_ball2.MC_Effect;
                  break;
               case 3:
                  this.FBallonList[3].MC_BallonPic.mc_ball3.gotoAndStop(2);
                  _loc13_ = this.FBallonList[3].MC_BallonPic.mc_ball3.MC_Effect;
            }
            _loc13_.MC_Desc.TF_Desc.text = _loc10_;
            TweenUtil.to(_loc13_,1500,{"onComplete":this.EndTween});
            this.UpdateUI();
         }
      }
      
      protected function EndTween() : void
      {
         switch(this.FBallonIndex)
         {
            case 0:
               this.FBallonList[0].MC_BallonPic.mc_ball0.gotoAndStop(1);
               break;
            case 1:
               this.FBallonList[1].MC_BallonPic.mc_ball1.gotoAndStop(1);
               break;
            case 2:
               this.FBallonList[2].MC_BallonPic.mc_ball2.gotoAndStop(1);
               break;
            case 3:
               this.FBallonList[3].MC_BallonPic.mc_ball3.gotoAndStop(1);
         }
         this.UpdateBalloon();
         this.FBeClicked = false;
      }
      
      protected function PerformPacket_CS_ExchangeReq(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SeventhEvening_ExchangeReq);
         _loc3_ = _loc2_.Data;
         this.FIndex = param1;
         _loc4_ = this.FSeventhEvening.ExchangeItemList[param1].Identify;
         _loc3_.writeInt(_loc4_);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_SC_ExchangeRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:TExchangeItem = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.FProcessorWindowSeventhEveningExchange.UpdateUI();
         }
         else
         {
            _loc6_ = STRING_SEVENTHEVENING.FORMAT_EXCHANGE_STRING;
            this.ProcessorEffectText(_loc6_);
            ++this.FSeventhEvening.ExchangeItemList[this.FIndex].BuyCount;
            this.FSeventhEvening.Magpie -= this.FSeventhEvening.ExchangeItemList[this.FIndex].CostPoint;
            this.FProcessorWindowSeventhEveningExchange.UpdateUI();
         }
      }
      
      protected function PerformPacket_CS_GetRewardReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SeventhEvening_GetRewardReq);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_GetRewardRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.UpdateUI();
         }
         else
         {
            _loc6_ = STRING_SEVENTHEVENING.FORMAT_GET_STRING + this.FSeventhEvening.SeventhEveningBox.Name + "*1";
            this.ProcessorEffectText(_loc6_);
            this.FSeventhEvening.SeventhEveningRewardStatus = TBaseActivity.STATUS_GETED;
            this.CheckAwardStatus();
            this.UpdateUI();
            this.ProcessorCheckEffect(false);
         }
      }
      
      protected function PerformPacket_SC_ChangeStatusRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = param1.Data;
         this.ProcessorCheckEffect(true);
         this.FSeventhEvening.SeventhEveningRewardStatus = TBaseActivity.STATUS_CANGET;
         if(this.visible)
         {
            this.UpdateUI();
         }
      }
      
      protected function PerformPacket_SC_ChangeScoreRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
         }
         else
         {
            this.FSeventhEvening.TotalHeartScore = _loc2_.readUnsignedInt();
            this.UpdateUI();
         }
      }
      
      protected function ProcessorOnBallonOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         this.FOverlayerBallon.Context = null;
         _loc3_ = param1.currentTarget.parent.name;
         _loc2_ = int(_loc3_.slice(10));
         this.FOverlayerBallon.Context = this.FSeventhEvening.BallonList[_loc2_];
         this.FOverlayerBallon.Render(FUICore.MouseCoordinate);
         this.FOverlayerBallon.Show();
         this.FOverlayerBallon.Y -= 20;
      }
      
      protected function ProcessorOnBallonOut(param1:MouseEvent) : void
      {
         this.FOverlayerBallon.Hide();
      }
      
      protected function ProcessorOnBoxUp(param1:MouseEvent) : void
      {
         if(this.FSeventhEvening.SeventhEveningRewardStatus != TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         this.PerformPacket_CS_GetRewardReq();
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         if(param1.currentTarget.name == "MC_Box")
         {
            _loc2_ = this.FSeventhEvening.SeventhEveningBox;
         }
         else if(param1.currentTarget.name == "MC_BigBox")
         {
            _loc2_ = this.FSeventhEvening.HeartReward.GetInventoryByIndex(0);
         }
         else if(param1.currentTarget.name == "MC_SmallBox")
         {
            _loc2_ = this.FSeventhEvening.FreeHeartReward.GetInventoryByIndex(0);
         }
         UIComponentsHintOnOver(this,_loc2_);
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         if(param1.currentTarget.name == "MC_Box")
         {
            _loc2_ = this.FSeventhEvening.SeventhEveningBox;
         }
         else if(param1.currentTarget.name == "MC_BigBox")
         {
            _loc2_ = this.FSeventhEvening.HeartReward.GetInventoryByIndex(0);
         }
         else if(param1.currentTarget.name == "MC_SmallBox")
         {
            _loc2_ = this.FSeventhEvening.FreeHeartReward.GetInventoryByIndex(0);
         }
         UIComponentsHintOnOut(this,_loc2_);
      }
      
      protected function ProcessorEffectText(param1:String) : void
      {
         if(FOnEffectText != null)
         {
            FOnEffectText(this,param1);
         }
      }
      
      protected function CheckAwardStatus() : void
      {
         if(this.FSeventhEvening.SeventhEveningRewardStatus == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorCheckEffect(true);
            return;
         }
         this.ProcessorCheckEffect(false);
      }
      
      protected function ProcessorOnLogUp(param1:MouseEvent) : void
      {
         this.PerformPacket_CS_LoadLogReq();
      }
      
      protected function ProcessorOnDescUp(param1:MouseEvent) : void
      {
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowSeventhEveningDesc.Visible = true;
            this.FProcessorWindowSeventhEveningDesc.UpdateUI();
         }
      }
      
      protected function ProcessorOnRankUp(param1:MouseEvent) : void
      {
         this.PerformPacket_CS_LoadRankReq();
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.PerformPacket_CS_LoadExchangeReq();
      }
      
      protected function ProcessorOnCloseRank() : void
      {
         this.FProcessorSeventhEveningRank.Visible = false;
      }
      
      protected function ProcessorOnCloseExchange() : void
      {
         this.FProcessorWindowSeventhEveningExchange.Visible = false;
         this.UpdateUI();
      }
      
      protected function ProcessorOnCloseDesc() : void
      {
         this.FProcessorWindowSeventhEveningDesc.Visible = false;
      }
      
      protected function ProcessorOnCloseLog() : void
      {
         this.FProcessorWindowSeventhEveningLog.Visible = false;
      }
      
      protected function ProcessorOnShowGotoRecharge() : void
      {
         this.FUIWindowRecharge.Visible = true;
      }
      
      protected function ProcessorOnShowRecruit() : void
      {
         if(this.FSeventhEvening.Hero)
         {
            if(this.FSeventhEvening.Hero.Type == TBaseBox.TYPE_IS_HERO)
            {
               this.FProcessorWindowRecruit.SetHeroData(this.FSeventhEvening.Hero.Identify);
            }
            else if(this.FSeventhEvening.Hero.Type == TBaseBox.TYPE_IS_PET)
            {
               this.FProcessorWindowPetDesc.SetPetData(this.FSeventhEvening.Hero.Identify);
            }
         }
      }
      
      protected function ProcessorOnShowHeroInfo(param1:uint, param2:uint) : void
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
      
      protected function ProcessorCheckEffect(param1:Boolean) : void
      {
         if(this.FCheckEffect != null)
         {
            this.FCheckEffect(CONST_SHORTCUTS.POSITION_NewActiveList,CONST_SHORTCUTS.TYPE_NewActiveList_SeventhEvening,param1);
         }
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
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowSeventhEveningExchange.Load();
            this.FProcessorSeventhEveningRank.Load();
            this.FProcessorWindowSeventhEveningDesc.Load();
            this.FProcessorWindowSeventhEveningLog.Load();
            this.FProcessorWindowRecruit.Load();
            this.FProcessorWindowPetDesc.Load();
            return;
         }
         this.PerformPacket_CS_LoadInfoReq();
         this.SetInterval();
      }
      
      override public function Unmount() : void
      {
         if(this.FTimeID != 0)
         {
            clearTimeout(this.FTimeID);
            this.FTimeID = 0;
         }
         super.Unmount();
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1371571200);
         TUtilityString.FlushUTF(_loc3_,"七夕活动");
         TUtilityString.FlushUTF(_loc3_,"七夕活动描述");
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(2);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(4);
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            TUtilityString.FlushUTF(_loc3_,"");
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            TUtilityString.FlushUTF(_loc3_,"");
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(14100046);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 2);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 2);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeShort(3);
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc3_.writeUnsignedInt(14100009 + _loc2_);
               _loc3_.writeUnsignedInt(_loc2_ + 1);
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
         _loc3_.writeUnsignedInt(0);
         if(this.FSeventhEvening.NeedExchangeConfig)
         {
            _loc3_.writeShort(10);
            _loc1_ = 0;
            while(_loc1_ < 10)
            {
               _loc3_.writeUnsignedInt(14100004 + _loc1_);
               _loc3_.writeUnsignedInt(_loc1_ + 1);
               _loc1_++;
            }
         }
         _loc3_.writeShort(10);
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
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
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc3_,"aaa");
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit3() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc3_,"aaa");
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit4() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(14100004 + _loc1_);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

