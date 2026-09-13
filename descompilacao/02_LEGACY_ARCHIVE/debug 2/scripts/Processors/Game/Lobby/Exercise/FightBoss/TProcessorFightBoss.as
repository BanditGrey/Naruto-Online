package Processors.Game.Lobby.Exercise.FightBoss
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
   import Logics.Exercise.FightBoss.TFightBoss;
   import Logics.Exercise.FightBoss.TFightBossDatas;
   import Logics.Exercise.FightBoss.TFightPoint;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerFightBoss;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.FightBoss.Compoents.TUIFightBoss;
   import Processors.Game.Lobby.Exercise.FightBoss.Compoents.TUIFightPoint;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Rendering.Overlayers.Title.TOverlayerTitle;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorFightBoss extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_1_GET_BOX:int = 1;
      
      public static const ACTIVITY_1_GET_HERO:int = 2;
      
      public static const ACTIVITY_1_KILL_BOSS:int = 3;
      
      public static const ACTIVITY_1_REFRESH_BOSS:int = 4;
      
      public static const ACTIVITY_1_GET_GIFT:int = 5;
      
      public static const ACTIVITY_2_BUY_BOX:int = 1;
      
      public static const ACTIVITY_2_BUY_HERO:int = 2;
      
      public static const ACTIVITY_2_GET_BOMB:int = 3;
      
      public static const ACTIVITY_2_REFRESH_POINT:int = 4;
      
      public static const ACTIVITY_2_GET_LAST_GIFT:int = 5;
      
      public static const ACTIVITY_2_GET_GIFT:int = 6;
      
      public static const FilterColor:uint = 16733962;
      
      public static const FilterGlowWidth:int = 5;
      
      public static const FilterGlowStrength:int = 5;
      
      protected var TAB_COUNT:int = 2;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIFightBoss,TUIFightPoint]);
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FFightBossDatas:TFightBossDatas;
      
      protected var FUnstreamizerFightBoss:TUnstreamizerFightBoss;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FBuyBoxDate:Object;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorFightBossRank:TProcessorFightBossRank;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FActivityPetConfigBins:TBins;
      
      protected var FIsOpen:Boolean;
      
      public function TProcessorFightBoss(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FFightBossDatas = SLogicsCore.FightBossDatas;
         this.FUnstreamizerFightBoss = new TUnstreamizerFightBoss();
         this.FUnstreamizerTitle = new TUnstreamizerTitle();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FTabList = new Vector.<MovieClip>(this.TAB_COUNT);
         this.FChangeTabIndex = 0;
         this.FGlowsFilter = new Vector.<TEffectBaseGlowTwo>(this.TAB_COUNT);
         this.FUIWindowVect = new Vector.<TUIBaseWindow>(this.TAB_COUNT);
         this.FOverlayerTitle = new TOverlayerTitle(this.Parent.Parent);
         this.FOverlayerTitle.Visible = false;
         this.FBuyBoxDate = new Object();
         this.FProcessorFightBossRank = new TProcessorFightBossRank(this.Parent);
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
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
            this.FUIWindowVect[_loc1_].OnLoadRank = this.ProcessorOnGotoRank;
            this.FUIWindowVect[_loc1_].OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FUIWindowVect[_loc1_].OnLoadLog = this.ProcessorOnLoadLog;
            this.FUIWindowVect[_loc1_].GotoRecharge = ProcessorOnRechargeUp;
            this.FUIWindowVect[_loc1_].OnShowFlowText = this.ProceossorOnShowFlowText;
            this.FUIWindowVect[_loc1_].OnShowDesc = this.ProcessorOnShowDesc;
            this.FUIWindowVect[_loc1_].OnShowHtmlTip = ProcessorOnShowHtmlText;
            this.FUIWindowVect[_loc1_].OnHideHtmlTip = ProcessorOnHideHtmlText;
            _loc1_++;
         }
         this.FProcessorFightBossRank.OnCloseUp = this.ProcessorOnCloseWindow;
         this.FProcessorFightBossRank.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorFightBossRank.OnOut = UIComponentsHintOnOut;
         this.FProcessorFightBossRank.TitleHintOnOver = this.ProcessorOnTitleOver;
         this.FProcessorFightBossRank.TitleHintOnOut = this.ProcessorOnTitleOut;
         this.FProcessorFightBossRank.Visible = false;
         this.FUnstreamizerTitle.UnstreamizeTitleByDatabase(null,this.FAllTitles,null);
         this.FActivityPetConfigBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ActivityPetConfig);
         FMC_Scene.BTN_CloseWindow.addEventListener(MouseEvent.CLICK,this.ProcessorOnCloseUp);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTitle);
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
            this.UpdateTabEffect();
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
            _loc3_ = this.FFightBossDatas.GetActivityByIndex(_loc1_);
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
            if(this.FFightBossDatas.Activities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
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
         _loc3_ = this.FFightBossDatas.GetActivityByIndex(_loc2_);
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
         _loc3_ = this.FFightBossDatas.GetActivityByIndex(_loc2_);
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
         this.FBuyBoxDate.Cost = param3;
         this.FBuyBoxDate.BoxIndex = param4;
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
         this.FProcessorFightBossRank.Visible = false;
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
      
      protected function ProcessorOnLoadLog(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_OrangeEquipment_LoadLogReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnShowDesc() : void
      {
         FProcessorWindowDesc.BaseActivity = this.FFightBossDatas.GetActivityByIndex(this.FChangeTabIndex);
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProceossorOnShowFlowText(param1:String) : void
      {
         ProcessorEffectText(param1);
      }
      
      protected function ProcessorOnCloseUp(param1:MouseEvent) : void
      {
         if(this.FUIWindowVect[this.FChangeTabIndex].IsPlaying)
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
            this.FProcessorFightBossRank.Load();
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
         this.FProcessorFightBossRank.visible = false;
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
         this.FUnstreamizerFightBoss.Unstreamize(_loc2_,this.FFightBossDatas,null);
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
         var _loc12_:TFightBoss = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc11_ = int(_loc2_.readUnsignedInt());
         _loc12_ = this.FFightBossDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TFightBoss;
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
            this.FProcessorFightBossRank.Visible = true;
            this.FProcessorFightBossRank.UpdateUI();
         }
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
         var _loc17_:TFightPoint = null;
         _loc16_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         super.ProcessorLoadLogRet();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         _loc17_ = this.FFightBossDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TFightPoint;
         _loc17_.LogList.length = 0;
         _loc5_ = _loc2_.readShort();
         _loc14_ = new Vector.<uint>();
         _loc15_ = new Vector.<uint>();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc10_ = new TLotteryNews();
            _loc14_.length = 0;
            _loc15_.length = 0;
            _loc7_ = int(_loc2_.readUnsignedShort());
            _loc6_ = 0;
            while(_loc6_ < _loc7_ / 4)
            {
               _loc12_ = _loc2_.readUnsignedInt();
               _loc11_ = _loc2_.readUnsignedInt();
               _loc13_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc16_);
               _loc14_.push(_loc13_);
               _loc15_.push(_loc2_.readUnsignedInt());
               _loc10_.GetTime = _loc2_.readUnsignedInt();
               _loc6_++;
            }
            _loc9_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc14_);
            _loc8_ = _loc9_.GetInventoryByIndex(0);
            _loc8_.Quantity = _loc15_[0];
            _loc10_.Inventory = _loc8_;
            _loc10_.Inventories = _loc9_;
            _loc17_.LogList.push(_loc10_);
            _loc4_++;
         }
         FProcessorWindowLog.BaseActivity = _loc17_;
         FProcessorWindowLog.UpdateUI();
         FProcessorWindowLog.Visible = true;
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TFightBoss = null;
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
         var _loc17_:uint = 0;
         var _loc18_:TBins = null;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:Vector.<Object> = null;
         var _loc24_:TConfigValue = null;
         var _loc25_:TFightBoss = null;
         var _loc26_:TFightPoint = null;
         var _loc27_:int = 0;
         var _loc28_:int = 0;
         var _loc29_:int = 0;
         _loc18_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
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
               _loc25_ = this.FFightBossDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TFightBoss;
               if(_loc10_ == ACTIVITY_1_KILL_BOSS)
               {
                  if(_loc25_.FreeCount > 0)
                  {
                     --_loc25_.FreeCount;
                  }
                  _loc27_ = int(_loc2_.readUnsignedInt());
                  _loc4_ = TUtilityString.Format(_loc25_.ActivityDesc2,_loc25_.CurHP - _loc27_) + "\n";
                  _loc25_.CurHP = _loc27_;
                  if(_loc27_ == 0)
                  {
                     --_loc25_.LimitCount;
                  }
                  _loc15_ = _loc2_.readUnsignedInt();
                  _loc25_.Score += _loc15_;
                  if(_loc15_ > 0)
                  {
                     _loc24_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.DROP_ITEM_NAME) as TConfigValue;
                     _loc23_ = _loc24_.Value as Vector.<Object>;
                     _loc4_ += STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                     _loc4_ = _loc4_ + (_loc23_[2] + "*" + _loc15_ + "\n");
                  }
                  ProcessorEffectText(_loc4_);
                  _loc25_.Count = _loc2_.readUnsignedInt();
                  _loc5_ = 0;
                  while(_loc5_ < _loc25_.BoxList.length)
                  {
                     _loc25_.BoxList[_loc5_].Status = _loc2_.readInt();
                     _loc5_++;
                  }
                  _loc25_.ChangeStatus();
                  this.FUIWindowVect[0].PlayMovie(TUIFightBoss.MOVIE_TYPE_BEAT_BOSS);
                  this.FFightBossDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FFightBossDatas.CheckStatus());
               }
               else if(_loc10_ == ACTIVITY_1_GET_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc6_ = 0;
                  while(_loc6_ < _loc25_.BoxList.length)
                  {
                     _loc25_.BoxList[_loc6_].Status = _loc2_.readInt();
                     _loc6_++;
                  }
                  _loc25_.Round = _loc2_.readUnsignedInt();
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
                  this.FFightBossDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FFightBossDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_GIFT)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc25_.GiftList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc25_.GiftList[_loc5_].Inventories;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.FFightBossDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FFightBossDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_HERO)
               {
                  _loc25_.HeroList[0].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
                  ProcessorEffectText(_loc4_);
                  this.FFightBossDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FFightBossDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_REFRESH_BOSS)
               {
                  _loc25_.CurHP = _loc25_.MaxHP;
                  this.FUIWindowVect[0].PlayMovie(TUIFightBoss.MOVIE_TYPE_REFRESH_BOSS);
               }
               break;
            case ACTIVITY_2_ID:
               _loc2_.readShort();
               _loc10_ = _loc2_.readUnsignedInt();
               _loc26_ = this.FFightBossDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TFightPoint;
               _loc24_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.DROP_ITEM_NAME) as TConfigValue;
               _loc23_ = _loc24_.Value as Vector.<Object>;
               if(_loc10_ == ACTIVITY_2_BUY_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc26_.Score -= _loc26_.BoxList[_loc5_].Price;
                  --_loc26_.BoxList[_loc5_].Count;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  ProcessorEffectText(_loc4_);
                  _loc26_.ChangeStatus();
                  this.FFightBossDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FFightBossDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_BUY_HERO)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc26_.Score -= _loc26_.HeroList[_loc5_].Price;
                  _loc26_.HeroList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  ProcessorEffectText(_loc4_);
                  _loc26_.ChangeStatus();
                  this.FFightBossDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FFightBossDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_GET_BOMB)
               {
                  _loc29_ = _loc2_.readUnsignedInt() - 1;
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  if(_loc26_.CannonList[_loc29_].Count > 0)
                  {
                     --_loc26_.CannonList[_loc29_].Count;
                  }
                  this.FUIWindowVect[1].SetMovieParam(_loc5_,_loc29_);
                  _loc15_ = _loc2_.readUnsignedInt();
                  if(_loc15_ > 0)
                  {
                     _loc4_ = TUtilityString.Format(_loc26_.ActivityDesc3,_loc15_) + "\n";
                  }
                  _loc26_.PointList[_loc5_].Min -= Math.min(_loc26_.PointList[_loc5_].Min,_loc15_);
                  _loc27_ = int(_loc2_.readUnsignedInt());
                  _loc28_ = int(_loc2_.readUnsignedInt());
                  _loc4_ += STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  if(_loc27_ > 0)
                  {
                     _loc4_ += _loc23_[2] + "*" + _loc27_ + "\n";
                  }
                  if(_loc28_ > 0)
                  {
                     _loc26_.Score += _loc28_;
                     _loc4_ += _loc23_[3] + "*" + _loc28_ + "\n";
                  }
                  ProcessorEffectText(_loc4_);
                  _loc26_.BoxStatus = _loc2_.readInt();
                  _loc26_.ChangeStatus();
                  this.FUIWindowVect[1].PlayMovie(TUIFightPoint.MOVIE_TYPE_CANNON_BOMB);
                  this.FFightBossDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FFightBossDatas.CheckStatus());
               }
               else if(_loc10_ == ACTIVITY_2_REFRESH_POINT)
               {
                  _loc26_.GameStatus = TFightPoint.GAME_STATUS_NORMAL;
                  _loc5_ = 0;
                  while(_loc5_ < _loc26_.PointList.length)
                  {
                     _loc26_.PointList[_loc5_].Min = _loc26_.PointList[_loc5_].Max;
                     _loc26_.PointList[_loc5_].Status = TBaseActivity.STATUS_CANNOTGET;
                     _loc5_++;
                  }
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_GET_LAST_GIFT)
               {
                  _loc26_.BoxStatus = _loc2_.readInt();
                  _loc26_.Score += _loc26_.BoxCount;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc4_ = _loc4_ + (_loc23_[3] + "*" + _loc26_.BoxCount + "\n");
                  ProcessorEffectText(_loc4_);
                  _loc26_.ChangeStatus();
                  this.FFightBossDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FFightBossDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_GET_GIFT)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc26_.GameStatus = _loc2_.readInt();
                  _loc26_.PointList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc26_.Score += _loc26_.PointList[_loc5_].Count;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc4_ = _loc4_ + (_loc23_[3] + "*" + _loc26_.PointList[_loc5_].Count + "\n");
                  ProcessorEffectText(_loc4_);
                  _loc26_.ChangeStatus();
                  this.FFightBossDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FFightBossDatas.CheckStatus());
                  this.UpdateUI();
               }
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([1,1]);
         var _loc5_:Vector.<int> = Vector.<int>([1,0]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
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
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(2);
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeUnsignedInt(4);
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(4);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            TUtilityString.FlushUTF(_loc3_,"bbbbb");
            TUtilityString.FlushUTF(_loc3_,"ccccc");
            _loc3_.writeInt(10 + _loc1_);
            _loc3_.writeInt(1);
            _loc3_.writeShort(1);
            _loc2_ = 0;
            while(_loc2_ < 1)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc2_ + _loc1_);
               _loc3_.writeUnsignedInt(1 + _loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            TUtilityString.FlushUTF(_loc3_,"&lt;P ALIGN=\'LEFT\'&gt;&lt;FONT FACE=\'Verdana\' SIZE=\'13\' COLOR=\'#EBEBD1\' LETTERSPACING=\'0\' KERNING=\'0\'&gt;&lt;B&gt;奖励&lt;FONT COLOR=\'#FFD166\'&gt;银币*%1&lt;/FONT&gt;，&lt;FONT COLOR=\'#CC66FF\'&gt;经验*%2&lt;/FONT&gt;。&lt;BR /&gt;奖励&lt;/P&gt;");
            _loc3_.writeInt(10 + _loc1_);
            _loc3_.writeInt(1);
            _loc3_.writeShort(1);
            _loc2_ = 0;
            while(_loc2_ < 1)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc2_ + _loc1_);
               _loc3_.writeUnsignedInt(1 + _loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeInt(0);
            _loc3_.writeUnsignedInt(11210009 + _loc1_);
            _loc3_.writeUnsignedInt(0);
            TUtilityString.FlushUTF(_loc3_,"aaa");
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
         var _loc4_:Vector.<int> = Vector.<int>([1,1]);
         var _loc5_:Vector.<int> = Vector.<int>([1,0]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc3_,"描述1");
            _loc3_.writeInt(_loc4_[_loc1_]);
            _loc3_.writeUnsignedInt(STimingCore.GetServerTime());
            _loc3_.writeInt(_loc5_[_loc1_]);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(2);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"活动1");
         TUtilityString.FlushUTF(_loc3_,"活动2");
         TUtilityString.FlushUTF(_loc3_,"活动3");
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

