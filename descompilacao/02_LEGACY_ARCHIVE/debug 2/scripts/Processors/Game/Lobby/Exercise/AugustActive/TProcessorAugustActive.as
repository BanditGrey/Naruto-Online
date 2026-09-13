package Processors.Game.Lobby.Exercise.AugustActive
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
   import Logics.Exercise.AugustActive.TAugustActive1;
   import Logics.Exercise.AugustActive.TAugustActive2;
   import Logics.Exercise.AugustActive.TAugustActiveDatas;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerAugustActive;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.AugustActive.Compoents.TUIAugustActive1;
   import Processors.Game.Lobby.Exercise.AugustActive.Compoents.TUIAugustActive2;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowEquipDesc;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Rendering.Overlayers.Box.TOverlayerBox;
   import Rendering.Overlayers.Title.TOverlayerTitle;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_EFFECT;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorAugustActive extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_1_GET_BOX:int = 1;
      
      public static const ACTIVITY_1_GET_BIG_BOX:int = 2;
      
      public static const ACTIVITY_1_PLAY_DART:int = 3;
      
      public static const ACTIVITY_1_GET_TASK:int = 4;
      
      public static const ACTIVITY_1_FINISH_TASK:int = 5;
      
      public static const ACTIVITY_1_GET_TASK_BOX:int = 6;
      
      public static const ACTIVITY_1_PLAY_DART_TEN:int = 7;
      
      public static const ACTIVITY_2_OPEN_CARD:int = 1;
      
      public static const ACTIVITY_2_OPEN_ALL_CARD:int = 2;
      
      public static const ACTIVITY_2_RESET:int = 3;
      
      public static const ACTIVITY_2_GET_SCORE_BOX:int = 4;
      
      public static const ACTIVITY_2_EXCHANGE_BOX:int = 5;
      
      public static const ACTIVITY_2_EXCHANGE_HERO:int = 6;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      public static const CAPACITY_ParallelOutputRows:uint = CONST_EFFECT.CAPACITY_ParallelOutputRows;
      
      public static const WINDOW_EQUIPMENT_DESC:int = 0;
      
      protected var TAB_COUNT:int = 2;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIAugustActive1,TUIAugustActive2]);
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      protected var FAugustActiveDatas:TAugustActiveDatas;
      
      protected var FUnstreamizerAugustActive:TUnstreamizerAugustActive;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FBuyBoxDate:Object;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FProcessorWindowEquipDesc:TProcessorWindowEquipDesc;
      
      protected var FProcessorAugustActiveRank:TProcessorAugustActiveRank;
      
      protected var FIsOpen:Boolean;
      
      protected var FStrLength:int;
      
      protected var FWindowType:int;
      
      public function TProcessorAugustActive(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         this.FAugustActiveDatas = SLogicsCore.AugustActiveDatas;
         this.FUnstreamizerAugustActive = new TUnstreamizerAugustActive(param3);
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
         this.FProcessorAugustActiveRank = new TProcessorAugustActiveRank(this.Parent);
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
            this.FUIWindowVect[_loc1_].OnShowWindow = this.ProcessorOnShowWindow;
            this.FUIWindowVect[_loc1_].OnCloseWindow = this.ProcessorOnCloseWindow;
            this.FUIWindowVect[_loc1_].OnGoto = ProcessorOnGoto;
            _loc1_++;
         }
         this.FProcessorAugustActiveRank.OnCloseUp = this.ProcessorOnCloseRank;
         this.FProcessorAugustActiveRank.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorAugustActiveRank.OnOut = UIComponentsHintOnOut;
         this.FProcessorAugustActiveRank.TitleHintOnOver = this.ProcessorOnTitleOver;
         this.FProcessorAugustActiveRank.TitleHintOnOut = this.ProcessorOnTitleOut;
         this.FProcessorAugustActiveRank.Visible = false;
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
            _loc3_ = this.FAugustActiveDatas.GetActivityByIndex(_loc1_);
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
            if(this.FAugustActiveDatas.Activities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
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
         _loc3_ = this.FAugustActiveDatas.GetActivityByIndex(_loc2_);
         if(_loc3_.IsOpen != TBaseActivity.IS_OPEN || _loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         ProcessorLoadInfoReq(this.FChangeTabIndex);
      }
      
      protected function ProcessorOnTabOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseActivity = null;
         var _loc4_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         _loc3_ = this.FAugustActiveDatas.GetActivityByIndex(_loc2_);
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
         FProcessorWindowDesc.BaseActivity = this.FAugustActiveDatas.GetActivityByIndex(this.FChangeTabIndex);
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
         this.FProcessorAugustActiveRank.Visible = false;
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function ProcessorOnShowWindow(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:TAugustActive2 = null;
         this.FWindowType = param1;
         switch(param1)
         {
            case WINDOW_EQUIPMENT_DESC:
               _loc4_ = this.FAugustActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TAugustActive2;
               this.FProcessorWindowEquipDesc.Visible = true;
               this.FProcessorWindowEquipDesc.UpdateUI(_loc4_.EquipList);
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
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRecruit.Load();
            this.FProcessorAugustActiveRank.Load();
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
         ProcessorLoadInfoReq();
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
         this.FUnstreamizerAugustActive.Unstreamize(_loc2_,this.FAugustActiveDatas,null);
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
         var _loc12_:TAugustActive1 = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc11_ = int(_loc2_.readUnsignedInt());
         _loc12_ = this.FAugustActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TAugustActive1;
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
            this.FProcessorAugustActiveRank.Visible = true;
            this.FProcessorAugustActiveRank.UpdateUI();
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
         _loc5_ = this.FAugustActiveDatas.GetActivityByIdentify(_loc4_) as TBaseActivity;
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
         var _loc9_:TAugustActive1 = null;
         var _loc10_:TAugustActive2 = null;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         _loc6_ = _loc2_.readInt();
         switch(_loc6_)
         {
            case ACTIVITY_1_ID:
               _loc5_ = int(_loc2_.readUnsignedInt());
               _loc9_ = this.FAugustActiveDatas.GetActivityByIdentify(_loc6_) as TAugustActive1;
               if(_loc9_)
               {
                  if(_loc5_ == 1)
                  {
                     this.FActivityTaskData.NeedShine = _loc2_.readUnsignedInt();
                     this.FAugustActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  }
                  else if(_loc5_ == 2)
                  {
                     _loc4_ = 0;
                     while(_loc4_ < _loc9_.BoxList.length)
                     {
                        _loc9_.BoxList[_loc4_].Status = _loc2_.readInt();
                        _loc4_++;
                     }
                  }
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_2_ID:
               _loc10_ = this.FAugustActiveDatas.GetActivityByIdentify(_loc6_) as TAugustActive2;
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
         var _loc24_:TAugustActive1 = null;
         var _loc25_:TAugustActive2 = null;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         var _loc28_:int = 0;
         var _loc29_:TDessertHouseTask = null;
         var _loc30_:int = 0;
         this.FBeClicked = false;
         _loc17_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc23_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.DROP_ITEM_NAME) as TConfigValue;
         _loc22_ = _loc23_.Value as Vector.<Object>;
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
               _loc24_ = this.FAugustActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TAugustActive1;
               if(_loc10_ == ACTIVITY_1_PLAY_DART)
               {
                  if(_loc24_.FreeCount > 0)
                  {
                     --_loc24_.FreeCount;
                  }
                  else if(_loc24_.MyPower > 0)
                  {
                     --_loc24_.MyPower;
                  }
                  _loc26_ = int(_loc2_.readUnsignedInt());
                  _loc16_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc5_ = 0;
                  while(_loc5_ < _loc24_.BoxList.length)
                  {
                     _loc24_.BoxList[_loc5_].Status = _loc2_.readInt();
                     _loc5_++;
                  }
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  if(_loc26_ > 0)
                  {
                     _loc24_.RankPoint += _loc26_;
                     _loc4_ += _loc22_[CONST_BASEACTIVITY.AUGUST_ACTIVITY_1_RANK_ITEM_1] + "*" + _loc26_ + "\n";
                     this.FStrLength = _loc4_.length;
                  }
                  if(_loc14_ > 0)
                  {
                     _loc4_ += STRING_COMMON.GetItemNameByType(_loc16_,_loc11_) + "*" + _loc14_;
                  }
                  this.FUIWindowVect[0].PlayMovie();
                  if(_loc26_ > 0)
                  {
                     this.ProcessorSpecialEffectText(_loc4_,_loc14_);
                  }
                  else
                  {
                     ProcessorEffectText(_loc4_);
                  }
                  this.FAugustActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FAugustActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_PLAY_DART_TEN)
               {
                  _loc24_.FreeCount = 0;
                  _loc24_.MyPower = _loc2_.readUnsignedInt();
                  _loc26_ = int(_loc2_.readUnsignedInt());
                  _loc5_ = 0;
                  while(_loc5_ < _loc24_.BoxList.length)
                  {
                     _loc24_.BoxList[_loc5_].Status = _loc2_.readInt();
                     _loc5_++;
                  }
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  if(_loc26_ > 0)
                  {
                     _loc24_.RankPoint += _loc26_;
                     _loc4_ += _loc22_[CONST_BASEACTIVITY.AUGUST_ACTIVITY_1_RANK_ITEM_1] + "*" + _loc26_ + "\n";
                     this.FStrLength = _loc4_.length;
                  }
                  this.FUIWindowVect[0].PlayMovie();
                  if(_loc26_ > 0)
                  {
                     this.ProcessorSpecialEffectText(_loc4_,_loc14_);
                  }
                  else
                  {
                     ProcessorEffectText(_loc4_);
                  }
                  this.FAugustActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FAugustActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_BIG_BOX)
               {
                  _loc15_ = _loc24_.BigBox;
                  _loc15_.Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc15_.Inventories.Count)
                  {
                     _loc9_ = _loc15_.Inventories.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.FAugustActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FAugustActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc15_ = _loc24_.BoxList[_loc5_];
                  _loc15_.Status = TBaseActivity.STATUS_CANNOTGET;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc15_.Inventories.Count)
                  {
                     _loc9_ = _loc15_.Inventories.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  _loc5_ = 0;
                  while(_loc5_ < _loc24_.BoxList.length)
                  {
                     _loc24_.BoxList[_loc5_].Status = _loc2_.readInt();
                     _loc5_++;
                  }
                  _loc24_.Round = _loc2_.readUnsignedInt();
                  ProcessorEffectText(_loc4_);
                  this.FAugustActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FAugustActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_TASK)
               {
                  _loc12_ = _loc2_.readUnsignedInt();
                  _loc29_ = this.FActivityTaskData.GetTaskByIdentify(_loc12_);
                  if(_loc29_ != null)
                  {
                     _loc29_.Status = TBaseActivity.STATUS_CANGET;
                     _loc29_.Process = 0;
                  }
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET_TASK_SUCCESS);
                  this.FAugustActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FAugustActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_FINISH_TASK)
               {
                  _loc12_ = _loc2_.readUnsignedInt();
                  _loc29_ = this.FActivityTaskData.GetTaskByIdentify(_loc12_);
                  this.FActivityTaskData.NeedShine = _loc2_.readUnsignedInt();
                  if(_loc29_ != null)
                  {
                     this.FActivityTaskData.Score += _loc29_.TaskPoint[_loc29_.Step];
                     this.FActivityTaskData.ChangeStatus();
                     _loc4_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_FINISH_TASK_SUCCESS,_loc29_.TaskPoint[_loc29_.Step]);
                     _loc4_ = _loc4_ + STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                     _loc5_ = 0;
                     while(_loc5_ < _loc29_.TaskAward[_loc29_.Step].Count)
                     {
                        _loc9_ = _loc29_.TaskAward[_loc29_.Step].GetInventoryByIndex(_loc5_);
                        _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                        if(_loc24_.DartID == _loc9_.IDTemplate)
                        {
                           _loc24_.MyPower += _loc9_.Quantity;
                        }
                        else if(_loc24_.ItemID == _loc9_.IDTemplate)
                        {
                           _loc24_.RankPoint += _loc9_.Quantity;
                        }
                        _loc5_++;
                     }
                     ++_loc29_.Step;
                     if(_loc29_.Step >= TActivityTaskData.STEP_COUNT)
                     {
                        _loc29_.Status = TBaseActivity.STATUS_GETED;
                     }
                     else
                     {
                        _loc29_.Process = 0;
                        _loc29_.Status = TBaseActivity.STATUS_CANNOTGET;
                     }
                  }
                  ProcessorEffectText(_loc4_);
                  this.FAugustActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FAugustActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_TASK_BOX)
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
                     if(_loc24_.DartID == _loc9_.IDTemplate)
                     {
                        _loc24_.MyPower += _loc9_.Quantity;
                     }
                     else if(_loc24_.ItemID == _loc9_.IDTemplate)
                     {
                        _loc24_.RankPoint += _loc9_.Quantity;
                     }
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.FAugustActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FAugustActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_2_ID:
               _loc2_.readShort();
               _loc10_ = _loc2_.readUnsignedInt();
               _loc25_ = this.FAugustActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TAugustActive2;
               if(_loc10_ == ACTIVITY_2_OPEN_CARD)
               {
                  if(_loc25_.FreeCount > 0)
                  {
                     --_loc25_.FreeCount;
                  }
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc26_ = _loc2_.readInt();
                  _loc6_ = _loc2_.readUnsignedInt() - 1;
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc27_ = int(_loc2_.readUnsignedInt());
                  _loc28_ = int(_loc2_.readUnsignedInt());
                  _loc25_.BoxScore += _loc27_;
                  _loc25_.ShopExchangePoint += _loc28_;
                  _loc25_.ChangeStatus();
                  if(_loc14_ > 0 || _loc27_ > 0 || _loc28_ > 0)
                  {
                     _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  }
                  if(_loc14_ > 0)
                  {
                     _loc4_ += _loc22_[CONST_BASEACTIVITY.AUGUST_ACTIVITY_1_RANK_ITEM_1] + "*" + _loc14_ + "\n";
                  }
                  if(_loc27_ > 0)
                  {
                     _loc4_ += _loc22_[CONST_BASEACTIVITY.AUGUST_ACTIVITY_2_DROP_ITEM_1] + "*" + _loc27_ + "\n";
                  }
                  if(_loc28_ > 0)
                  {
                     _loc4_ += _loc22_[CONST_BASEACTIVITY.AUGUST_ACTIVITY_2_DROP_ITEM_2] + "*" + _loc28_ + "\n";
                  }
                  ProcessorEffectText(_loc4_);
                  this.FAugustActiveDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FAugustActiveDatas.CheckStatus());
                  this.FUIWindowVect[1].SetMovieParam(_loc5_,_loc26_,_loc6_);
               }
               else if(_loc10_ == ACTIVITY_2_OPEN_ALL_CARD)
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc25_.Card2List.length)
                  {
                     _loc25_.Card2List[_loc5_] = _loc2_.readInt();
                     if(_loc25_.CardList[_loc5_] == 0)
                     {
                        --_loc25_.FreeCount;
                     }
                     _loc5_++;
                  }
                  _loc25_.FreeCount = Math.max(_loc25_.FreeCount,0);
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc27_ = int(_loc2_.readUnsignedInt());
                  _loc28_ = int(_loc2_.readUnsignedInt());
                  _loc25_.BoxScore += _loc27_;
                  _loc25_.ShopExchangePoint += _loc28_;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  if(_loc14_ > 0)
                  {
                     _loc4_ += _loc22_[CONST_BASEACTIVITY.AUGUST_ACTIVITY_1_RANK_ITEM_1] + "*" + _loc14_ + "\n";
                  }
                  if(_loc27_ > 0)
                  {
                     _loc4_ += _loc22_[CONST_BASEACTIVITY.AUGUST_ACTIVITY_2_DROP_ITEM_1] + "*" + _loc27_ + "\n";
                  }
                  if(_loc28_ > 0)
                  {
                     _loc4_ += _loc22_[CONST_BASEACTIVITY.AUGUST_ACTIVITY_2_DROP_ITEM_2] + "*" + _loc28_ + "\n";
                  }
                  _loc25_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FAugustActiveDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FAugustActiveDatas.CheckStatus());
                  this.FUIWindowVect[1].PlayMovie(2);
               }
               else if(_loc10_ == ACTIVITY_2_RESET)
               {
                  _loc25_.BoxScore = 0;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_RESET_TASK_SUCCESS;
                  _loc5_ = 0;
                  while(_loc5_ < _loc25_.CardList.length)
                  {
                     _loc25_.CardList[_loc5_] = 0;
                     _loc5_++;
                  }
                  _loc5_ = 0;
                  while(_loc5_ < _loc25_.BoxList.length)
                  {
                     _loc25_.BoxList[_loc5_].Status = TBaseActivity.STATUS_CANNOTGET;
                     _loc5_++;
                  }
                  _loc25_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FAugustActiveDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FAugustActiveDatas.CheckStatus());
                  this.FUIWindowVect[1].PlayMovie(3);
               }
               else if(_loc10_ == ACTIVITY_2_GET_SCORE_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc25_.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc25_.BoxList[_loc5_].Inventories.Count)
                  {
                     _loc9_ = _loc25_.BoxList[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc6_++;
                  }
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc25_.ShopExchangePoint += _loc14_;
                  _loc25_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FAugustActiveDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FAugustActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_EXCHANGE_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  --_loc25_.ShopExchangeItems[_loc5_].LimitCount;
                  _loc25_.ShopExchangePoint -= _loc25_.ShopExchangeItems[_loc5_].Price;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc25_.ShopExchangeItems[_loc5_].Inventories.Count)
                  {
                     _loc9_ = _loc25_.ShopExchangeItems[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc6_++;
                  }
                  _loc25_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FAugustActiveDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FAugustActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_EXCHANGE_HERO)
               {
                  _loc25_.Hero.Status = TBaseActivity.STATUS_GETED;
                  _loc25_.ShopExchangePoint -= _loc25_.Hero.Price;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  _loc25_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FAugustActiveDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FAugustActiveDatas.CheckStatus());
                  this.UpdateUI();
               }
         }
      }
      
      protected function ProcessorSpecialEffectText(param1:String, param2:int) : void
      {
         var _loc3_:TextFormat = null;
         var _loc4_:TextFormat = null;
         var _loc5_:TextFormat = null;
         var _loc6_:TEffectTextParameters = null;
         _loc6_ = new TEffectTextParameters();
         _loc3_ = new TextFormat();
         _loc3_.color = 4294952980;
         _loc6_.EffectTextFormats.push(_loc3_);
         _loc6_.FormatsBeginIndex[0] = 0;
         _loc6_.FormatsEndIndex[0] = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED.length - 1;
         _loc4_ = new TextFormat();
         _loc4_.color = 4294901811;
         _loc6_.EffectTextFormats.push(_loc4_);
         _loc6_.FormatsBeginIndex[1] = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED.length - 1;
         _loc6_.FormatsEndIndex[1] = this.FStrLength - 1;
         if(param2 > 0)
         {
            _loc5_ = new TextFormat();
            _loc5_.color = 4294952980;
            _loc6_.EffectTextFormats.push(_loc5_);
            _loc6_.FormatsBeginIndex[2] = this.FStrLength - 1;
            _loc6_.FormatsEndIndex[2] = param1.length - 1;
         }
         if(FOnEffectText != null)
         {
            FOnEffectText(this,param1,_loc6_,null,CAPACITY_ParallelOutputRows);
            this.FStrLength = 0;
         }
      }
      
      public function Test() : void
      {
      }
   }
}

