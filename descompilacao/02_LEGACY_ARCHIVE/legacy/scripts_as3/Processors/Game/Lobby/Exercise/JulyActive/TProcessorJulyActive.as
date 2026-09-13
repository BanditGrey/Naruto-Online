package Processors.Game.Lobby.Exercise.JulyActive
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
   import Logics.Exercise.JulyActive.TJulyActive1;
   import Logics.Exercise.JulyActive.TJulyActive2;
   import Logics.Exercise.JulyActive.TJulyActiveDatas;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerJulyActive;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.JulyActive.Compoents.TUIJulyActive1;
   import Processors.Game.Lobby.Exercise.JulyActive.Compoents.TUIJulyActive2;
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
   
   public class TProcessorJulyActive extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_1_BUY_SALE_BOX:int = 1;
      
      public static const ACTIVITY_1_GET_DAILY_BOX:int = 2;
      
      public static const ACTIVITY_1_GET_SALE_COUNT_BOX:int = 3;
      
      public static const ACTIVITY_1_OPEN_CRYSTAL:int = 4;
      
      public static const ACTIVITY_1_OPEN_HOLE:int = 5;
      
      public static const ACTIVITY_1_EXCHANGE_ITEM:int = 6;
      
      public static const ACTIVITY_2_FIGHT_BOSS:int = 1;
      
      public static const ACTIVITY_2_GET_ALL_SERVER_BOX:int = 2;
      
      public static const ACTIVITY_2_GET_KILL_BOX:int = 3;
      
      public static const ACTIVITY_2_EXCHANGE_HERO:int = 4;
      
      public static const ACTIVITY_2_EXCHANGE_BOX:int = 5;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      protected var TAB_COUNT:int = 2;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIJulyActive1,TUIJulyActive2]);
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FJulyActiveDatas:TJulyActiveDatas;
      
      protected var FUnstreamizerJulyActive:TUnstreamizerJulyActive;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FBuyBoxDate:Object;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FProcessorJulyActiveRank:TProcessorJulyActiveRank;
      
      protected var FProcessorJulyActiveEquipDesc:TProcessorJulyActiveEquipDesc;
      
      protected var FIsOpen:Boolean;
      
      public function TProcessorJulyActive(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FJulyActiveDatas = SLogicsCore.JulyActiveDatas;
         this.FUnstreamizerJulyActive = new TUnstreamizerJulyActive();
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
         this.FProcessorJulyActiveRank = new TProcessorJulyActiveRank(this.Parent);
         this.FProcessorJulyActiveEquipDesc = new TProcessorJulyActiveEquipDesc(this.Parent);
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
            this.FUIWindowVect[_loc1_].OnBoxOver = this.ProcessorOnBoxOver;
            this.FUIWindowVect[_loc1_].OnBoxOut = this.ProcessorOnBoxOut;
            this.FUIWindowVect[_loc1_].OnNewBoxOver = ProcessorOnNewBoxOver;
            this.FUIWindowVect[_loc1_].OnNewBoxOut = ProcessorOnNewBoxOut;
            this.FUIWindowVect[_loc1_].OnItemOver = UIComponentsHintOnOver;
            this.FUIWindowVect[_loc1_].OnItemOut = UIComponentsHintOnOut;
            this.FUIWindowVect[_loc1_].OnShowDesc = this.ProcessorOnShowDesc;
            this.FUIWindowVect[_loc1_].OnShowFlowText = ProcessorEffectText;
            this.FUIWindowVect[_loc1_].OnShowHtmlTip = ProcessorOnShowHtmlText;
            this.FUIWindowVect[_loc1_].OnHideHtmlTip = ProcessorOnHideHtmlText;
            this.FUIWindowVect[_loc1_].OnShowTip = ProcessorOnShowTip;
            this.FUIWindowVect[_loc1_].OnHideTip = ProcessorOnHideTip;
            this.FUIWindowVect[_loc1_].OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FUIWindowVect[_loc1_].OnLoadLog = this.ProcessorOnLoadLog;
            this.FUIWindowVect[_loc1_].OnLoadRank = this.ProcessorOnGotoRank;
            this.FUIWindowVect[_loc1_].GotoRecharge = ProcessorOnRechargeUp;
            this.FUIWindowVect[_loc1_].OnShowWindow = this.ProcessorOnShowWindow;
            _loc1_++;
         }
         this.FProcessorJulyActiveRank.OnCloseUp = this.ProcessorOnCloseWindow;
         this.FProcessorJulyActiveRank.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorJulyActiveRank.OnOut = UIComponentsHintOnOut;
         this.FProcessorJulyActiveRank.TitleHintOnOver = this.ProcessorOnTitleOver;
         this.FProcessorJulyActiveRank.TitleHintOnOut = this.ProcessorOnTitleOut;
         this.FProcessorJulyActiveRank.Visible = false;
         this.FProcessorJulyActiveEquipDesc.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorJulyActiveEquipDesc.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorJulyActiveEquipDesc.OnOut = UIComponentsHintOnOut;
         this.FProcessorJulyActiveEquipDesc.Visible = false;
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
            _loc3_ = this.FJulyActiveDatas.GetActivityByIndex(_loc1_);
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
            if(this.FJulyActiveDatas.Activities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
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
         _loc3_ = this.FJulyActiveDatas.GetActivityByIndex(_loc2_);
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
         _loc3_ = this.FJulyActiveDatas.GetActivityByIndex(_loc2_);
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
         FProcessorWindowDesc.BaseActivity = this.FJulyActiveDatas.GetActivityByIndex(this.FChangeTabIndex);
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
         this.FProcessorJulyActiveRank.Visible = false;
      }
      
      protected function ProcessorOnShowWindow() : void
      {
         this.FProcessorJulyActiveEquipDesc.Visible = true;
         this.FProcessorJulyActiveEquipDesc.UpdateUI();
      }
      
      protected function ProcessorOnHideWindow() : void
      {
         this.FProcessorJulyActiveEquipDesc.Visible = false;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRecruit.Load();
            this.FProcessorJulyActiveRank.Load();
            this.FProcessorJulyActiveEquipDesc.Load();
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
         this.FUnstreamizerJulyActive.Unstreamize(_loc2_,this.FJulyActiveDatas,null);
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
         var _loc12_:TJulyActive1 = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc11_ = int(_loc2_.readUnsignedInt());
         _loc12_ = this.FJulyActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TJulyActive1;
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
            this.FProcessorJulyActiveRank.Visible = true;
            this.FProcessorJulyActiveRank.UpdateUI();
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
         _loc5_ = this.FJulyActiveDatas.GetActivityByIdentify(_loc4_) as TBaseActivity;
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
         var _loc8_:TJulyActive1 = null;
         var _loc9_:TJulyActive2 = null;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         _loc5_ = _loc2_.readInt();
         switch(_loc5_)
         {
            case ACTIVITY_1_ID:
               _loc8_ = this.FJulyActiveDatas.GetActivityByIdentify(_loc5_) as TJulyActive1;
               if((Boolean(_loc8_)) && Boolean(_loc8_.SaleBox))
               {
                  _loc8_.SaleBox.Status = _loc2_.readInt();
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_2_ID:
               _loc9_ = this.FJulyActiveDatas.GetActivityByIdentify(_loc5_) as TJulyActive2;
               if(_loc9_)
               {
                  _loc9_.MyPower = _loc2_.readUnsignedInt();
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
         var _loc24_:TJulyActive1 = null;
         var _loc25_:TJulyActive2 = null;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         var _loc28_:int = 0;
         var _loc29_:int = 0;
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
               _loc24_ = this.FJulyActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TJulyActive1;
               if(_loc10_ == ACTIVITY_1_BUY_SALE_BOX)
               {
                  --_loc24_.SaleBox.Count;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc24_.SaleBox.Price = _loc2_.readUnsignedInt();
                  _loc24_.TotalCount = _loc2_.readUnsignedInt();
                  _loc5_ = 0;
                  while(_loc5_ < _loc24_.SaleBox.Inventories.Count)
                  {
                     _loc9_ = _loc24_.SaleBox.Inventories.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  _loc5_ = 0;
                  while(_loc5_ < _loc24_.BuyCountAwards.length)
                  {
                     _loc24_.BuyCountAwards[_loc5_].Status = _loc2_.readInt();
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_DAILY_BOX)
               {
                  _loc24_.DailyStatus = TBaseActivity.STATUS_GETED;
                  _loc16_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc4_ = _loc4_ + (STRING_COMMON.GetItemNameByType(_loc16_,_loc11_) + "*" + _loc14_ + "\n");
                  ProcessorEffectText(_loc4_);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_SALE_COUNT_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc24_.BuyCountAwards[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc24_.BuyCountAwards[_loc5_].Inventories.Count)
                  {
                     _loc9_ = _loc24_.BuyCountAwards[_loc5_].Inventories.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_OPEN_CRYSTAL)
               {
                  _loc24_.CountA = Math.max(0,_loc24_.CountA - _loc24_.ConsumeCountA);
                  _loc26_ = int(_loc2_.readUnsignedInt());
                  _loc27_ = int(_loc2_.readUnsignedInt());
                  _loc16_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  if(_loc26_ > 0)
                  {
                     _loc24_.HoleStatus = 1;
                     _loc24_.CountB += _loc26_;
                     _loc4_ += _loc22_[CONST_BASEACTIVITY.JULY_ACTIVITY_1_DROP_ITEM_2] + "*" + _loc26_ + "\n";
                     this.FUIWindowVect[0].PlayMovie(2);
                  }
                  if(_loc27_ > 0)
                  {
                     _loc24_.RankPoint += _loc27_;
                     _loc24_.Score += _loc27_;
                     _loc4_ += _loc22_[CONST_BASEACTIVITY.JULY_ACTIVITY_1_DROP_ITEM_3] + "*" + _loc27_ + "\n";
                  }
                  if(_loc14_ > 0)
                  {
                     _loc4_ += STRING_COMMON.GetItemNameByType(_loc16_,_loc11_) + "*" + _loc14_ + "\n";
                  }
                  ProcessorEffectText(_loc4_);
                  this.FUIWindowVect[0].PlayMovie(1);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_OPEN_HOLE)
               {
                  _loc24_.CountB = Math.max(0,_loc24_.CountB - _loc24_.ConsumeCountB);
                  _loc26_ = int(_loc2_.readUnsignedInt());
                  _loc16_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  if(_loc26_ > 0)
                  {
                     _loc24_.Score += _loc26_;
                     _loc24_.RankPoint += _loc26_;
                     _loc4_ += _loc22_[CONST_BASEACTIVITY.JULY_ACTIVITY_1_DROP_ITEM_3] + "*" + _loc26_ + "\n";
                  }
                  if(_loc14_ > 0)
                  {
                     _loc4_ += STRING_COMMON.GetItemNameByType(_loc16_,_loc11_) + "*" + _loc14_ + "\n";
                  }
                  ProcessorEffectText(_loc4_);
                  this.FUIWindowVect[0].PlayMovie(3);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_EXCHANGE_ITEM)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc15_ = _loc24_.BoxList[_loc5_];
                  _loc24_.Score -= _loc15_.Price;
                  --_loc15_.Count;
                  _loc24_.NeedEffect = 1;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc15_.Inventories.Count)
                  {
                     _loc9_ = _loc15_.Inventories.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.UpdateUI();
               }
               ProcessorOnHideHtmlText();
               this.FJulyActiveDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
               ProcessorCheckEffect(FActivityID,this.FJulyActiveDatas.CheckStatus());
               break;
            case ACTIVITY_2_ID:
               _loc2_.readShort();
               _loc10_ = _loc2_.readUnsignedInt();
               _loc25_ = this.FJulyActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TJulyActive2;
               if(_loc10_ == ACTIVITY_2_EXCHANGE_HERO)
               {
                  _loc25_.Score -= _loc25_.ExchangeHero.Price;
                  _loc25_.ExchangeHero.Status = TBaseActivity.STATUS_GETED;
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_EXCHANGE);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_EXCHANGE_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc15_ = _loc25_.ExchangeBoxList[_loc5_];
                  --_loc15_.Count;
                  _loc25_.Score -= _loc15_.Price;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc15_.Inventories.Count)
                  {
                     _loc9_ = _loc15_.Inventories.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_FIGHT_BOSS)
               {
                  _loc25_.MyPower = Math.max(0,_loc25_.MyPower - _loc25_.NeedPower);
                  _loc25_.BossID = _loc2_.readUnsignedInt();
                  _loc25_.CurHp = _loc2_.readUnsignedInt();
                  _loc25_.MaxHp = _loc2_.readUnsignedInt();
                  _loc25_.KillCount = _loc2_.readUnsignedInt();
                  _loc25_.AllKillCount = _loc2_.readUnsignedInt();
                  _loc25_.AllKillStatus = _loc2_.readInt();
                  _loc27_ = int(_loc2_.readUnsignedInt());
                  _loc26_ = int(_loc2_.readUnsignedInt());
                  _loc28_ = int(_loc2_.readUnsignedInt());
                  _loc29_ = int(_loc2_.readUnsignedInt());
                  _loc4_ = TUtilityString.Format(_loc25_.DescListNew[9],_loc27_) + "\n";
                  _loc16_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc4_ += STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  if(_loc26_ > 0)
                  {
                     _loc4_ += _loc22_[CONST_BASEACTIVITY.JULY_ACTIVITY_1_DROP_ITEM_3] + "*" + _loc26_ + "\n";
                  }
                  if(_loc28_ > 0)
                  {
                     _loc25_.Score += _loc28_;
                     _loc4_ += _loc22_[CONST_BASEACTIVITY.JULY_ACTIVITY_2_DROP_ITEM_1] + "*" + _loc28_ + "\n";
                  }
                  if(_loc14_ > 0)
                  {
                     _loc4_ += STRING_COMMON.GetItemNameByType(_loc16_,_loc11_) + "*" + _loc14_ + "\n";
                  }
                  _loc25_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  if(_loc29_ == 1)
                  {
                     this.FUIWindowVect[1].PlayMovie(2);
                  }
                  else
                  {
                     this.FUIWindowVect[1].PlayMovie(1);
                  }
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_GET_ALL_SERVER_BOX)
               {
                  _loc25_.AllKillStatus = _loc2_.readInt();
                  _loc25_.AllKillCount = _loc2_.readUnsignedInt();
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc8_ = _loc25_.AllKillItems;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_GET_KILL_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc15_ = _loc25_.KillBoxList[_loc5_];
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
                  this.UpdateUI();
               }
               ProcessorOnHideHtmlText();
               this.FJulyActiveDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
               ProcessorCheckEffect(FActivityID,this.FJulyActiveDatas.CheckStatus());
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
         _loc3_.writeShort(9);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"矿山TIPS");
         TUtilityString.FlushUTF(_loc3_,"黑洞TIPS");
         TUtilityString.FlushUTF(_loc3_,"历史获得暗夜水晶%0个");
         TUtilityString.FlushUTF(_loc3_,"宠物TIPS");
         TUtilityString.FlushUTF(_loc3_,"确认花费%0金币补齐");
         TUtilityString.FlushUTF(_loc3_,"获得其中一个道具");
         TUtilityString.FlushUTF(_loc3_,"礼包详情");
         TUtilityString.FlushUTF(_loc3_,"暗夜水晶不足");
         TUtilityString.FlushUTF(_loc3_,"铁铲TIP");
         TUtilityString.FlushUTF(_loc3_,"水晶TIP");
         _loc3_.writeUnsignedInt(50);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(20);
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(20);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeInt(1);
         _loc3_.writeShort(1);
         _loc1_ = 0;
         while(_loc1_ < 1)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(1 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeInt(1);
         _loc3_.writeUnsignedInt(50);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeShort(1);
         TUtilityString.FlushUTF(_loc3_,"抢购礼包TIP");
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(1 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeShort(2);
            TUtilityString.FlushUTF(_loc3_,"购买总次数%0/99次可领");
            TUtilityString.FlushUTF(_loc3_,_loc1_ + "礼包TIP");
            _loc3_.writeInt(1);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeShort(1);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(1 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(11);
         _loc1_ = 0;
         while(_loc1_ < 11)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeShort(1);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(1 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(8);
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14200311 + _loc1_);
            _loc3_.writeUnsignedInt(1 + _loc1_);
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
         var _loc4_:Vector.<int> = Vector.<int>([1,1,1,1]);
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
         _loc3_.writeUnsignedInt(2);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(4);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"忍者TIP");
         TUtilityString.FlushUTF(_loc3_,"全服每击杀%0/500次可领");
         TUtilityString.FlushUTF(_loc3_,"1号怪物");
         TUtilityString.FlushUTF(_loc3_,"2号怪物");
         TUtilityString.FlushUTF(_loc3_,"3号怪物");
         TUtilityString.FlushUTF(_loc3_,"暂无");
         TUtilityString.FlushUTF(_loc3_,"战斗力不足");
         TUtilityString.FlushUTF(_loc3_,"你造成了%0点伤害");
         TUtilityString.FlushUTF(_loc3_,"幸运奖TIPS");
         TUtilityString.FlushUTF(_loc3_,"已售完");
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

