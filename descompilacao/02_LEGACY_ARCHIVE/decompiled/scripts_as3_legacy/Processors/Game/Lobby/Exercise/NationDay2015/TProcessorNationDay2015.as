package Processors.Game.Lobby.Exercise.NationDay2015
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
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.NationalDay_2015.TNationalDay1_2015;
   import Logics.Exercise.NationalDay_2015.TNationalDay2_2015;
   import Logics.Exercise.NationalDay_2015.TNationalDay3_2015;
   import Logics.Exercise.NationalDay_2015.TNationalDayDatas_2015;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerNationDay2015;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowEquipDesc;
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
   
   public class TProcessorNationDay2015 extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_1_GET_DAILY_GIFT:int = 1;
      
      public static const ACTIVITY_1_LOTTERY:int = 2;
      
      public static const ACTIVITY_1_BUY_FUND:int = 3;
      
      public static const ACTIVITY_2_PLAY_GAME:int = 1;
      
      public static const ACTIVITY_2_BUY_DICE:int = 2;
      
      public static const ACTIVITY_2_GET_BOX:int = 3;
      
      public static const ACTIVITY_2_UPGRADE:int = 4;
      
      public static const ACTIVITY_2_EXCHANGE_ITEM:int = 5;
      
      public static const ACTIVITY_2_UPGRADE_CANCEL:int = 6;
      
      public static const ACTIVITY_3_EXCHANGE_ITEM:int = 1;
      
      public static const ACTIVITY_3_EXCHANGE_HERO:int = 2;
      
      public static const ACTIVITY_3_GET_SWEET:int = 3;
      
      public static const ACTIVITY_3_GET_TEN:int = 4;
      
      public static const ACTIVITY_3_GET_BOX:int = 5;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      public static const WINDOW_HOME:int = 5;
      
      protected var TAB_COUNT:int = 3;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUINationDay1_2015,TUINationDay2_2015,TUINationDay3_2015]);
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FNationalDayDatas_2015:TNationalDayDatas_2015;
      
      protected var FUnstreamizerNationDay2015:TUnstreamizerNationDay2015;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FBuyBoxDate:Object;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorWindowEquipDesc:TProcessorWindowEquipDesc;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FIsOpen:Boolean;
      
      protected var FStrLength:int;
      
      public function TProcessorNationDay2015(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FNationalDayDatas_2015 = SLogicsCore.NationalDayDatas_2015;
         this.FUnstreamizerNationDay2015 = new TUnstreamizerNationDay2015();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerTitle = new TUnstreamizerTitle();
         this.FTabList = new Vector.<MovieClip>(this.TAB_COUNT);
         this.FChangeTabIndex = -1;
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
            while(_loc1_ < this.TAB_COUNT)
            {
               this.FUIWindowVect[_loc1_].SetVisible(false);
               if(this.FNationalDayDatas_2015.Activities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
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
            while(_loc1_ < this.TAB_COUNT)
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
               if(this.FNationalDayDatas_2015.Activities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
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
         var _loc2_:TNationalDay1_2015 = null;
         _loc2_ = this.FNationalDayDatas_2015.GetActivityByIdentify(ACTIVITY_1_ID) as TNationalDay1_2015;
         FMC_Scene.MC_Main.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(_loc2_.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(_loc2_.EndTime) - 1) * 1000)));
         FMC_Scene.MC_Main.TF_Desc.text = _loc2_.DescListNew[8];
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            FMC_Scene.MC_Main["TF_Desc" + _loc1_].text = _loc2_.DescListNew[2 + _loc1_];
            _loc1_++;
         }
      }
      
      protected function ProcessorOnChangePage(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseActivity = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         _loc3_ = this.FNationalDayDatas_2015.GetActivityByIndex(_loc2_);
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
         _loc3_ = this.FNationalDayDatas_2015.GetActivityByIndex(_loc2_);
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
         FProcessorWindowDesc.BaseActivity = this.FNationalDayDatas_2015.GetActivityByIndex(this.FChangeTabIndex);
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
      
      protected function ProcessorOnShowWindow(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         switch(param1)
         {
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
         this.FChangeTabIndex = -1;
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         var _loc1_:int = 0;
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
         _loc1_ = 0;
         while(_loc1_ < this.FUIWindowVect.length)
         {
            if(this.FUIWindowVect[_loc1_])
            {
               this.FUIWindowVect[_loc1_].Unmount();
            }
            _loc1_++;
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
         this.FUnstreamizerNationDay2015.Unstreamize(_loc2_,this.FNationalDayDatas_2015,null);
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
         _loc5_ = this.FNationalDayDatas_2015.GetActivityByIdentify(_loc4_) as TBaseActivity;
         ProcessorUnstreamActivityLog(_loc5_,_loc2_);
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
         var _loc11_:TNationalDay2_2015 = null;
         var _loc12_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc12_ = int(_loc2_.readUnsignedInt());
         _loc11_ = this.FNationalDayDatas_2015.GetActivityByIdentify(ACTIVITY_2_ID) as TNationalDay2_2015;
         _loc2_.readUnsignedShort();
         if(_loc11_)
         {
            _loc11_.RankGiftList.length = 0;
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
               _loc11_.RankGiftList.push(_loc7_);
               _loc4_++;
            }
            _loc11_.RankPlayerList.length = 0;
            _loc5_ = int(_loc2_.readUnsignedShort());
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc6_ = new TConsumeRankInfo();
               _loc6_.UserName = TUtilityString.FetchUTF(_loc2_);
               _loc6_.ServerName = TUtilityString.FetchUTF(_loc2_);
               _loc6_.Rank = _loc2_.readUnsignedInt();
               _loc6_.Score = _loc2_.readUnsignedInt();
               _loc11_.RankPlayerList.push(_loc6_);
               _loc4_++;
            }
         }
         if(FIsResourcesLoadCompleted && this.visible)
         {
            FProcessorActiveRankOld.Visible = true;
            FProcessorActiveRankOld.UpdateUI(_loc11_);
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
         var _loc9_:TNationalDay1_2015 = null;
         var _loc10_:TNationalDay2_2015 = null;
         var _loc11_:TNationalDay3_2015 = null;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         _loc6_ = _loc2_.readInt();
         switch(_loc6_)
         {
            case ACTIVITY_1_ID:
               _loc9_ = this.FNationalDayDatas_2015.GetActivityByIdentify(_loc6_) as TNationalDay1_2015;
               if(_loc9_)
               {
                  _loc9_.FreeCount = _loc2_.readUnsignedInt();
                  this.FNationalDayDatas_2015.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FNationalDayDatas_2015.CheckStatus());
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_2_ID:
               _loc10_ = this.FNationalDayDatas_2015.GetActivityByIdentify(_loc6_) as TNationalDay2_2015;
               break;
            case ACTIVITY_3_ID:
               _loc11_ = this.FNationalDayDatas_2015.GetActivityByIdentify(_loc6_) as TNationalDay3_2015;
               if(_loc11_)
               {
                  _loc11_.TotalRechargeGold = _loc2_.readUnsignedInt();
                  this.FNationalDayDatas_2015.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FNationalDayDatas_2015.CheckStatus());
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
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         var _loc28_:Vector.<uint> = null;
         var _loc29_:Vector.<uint> = null;
         var _loc30_:String = null;
         var _loc31_:TSystemLanguage = null;
         var _loc32_:int = 0;
         var _loc33_:TNationalDay1_2015 = null;
         var _loc34_:TNationalDay2_2015 = null;
         var _loc35_:TNationalDay3_2015 = null;
         this.FBeClicked = false;
         _loc17_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc23_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.DROP_ITEM_NAME) as TConfigValue;
         _loc22_ = _loc23_.Value as Vector.<Object>;
         _loc28_ = new Vector.<uint>();
         _loc29_ = new Vector.<uint>();
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
               _loc33_ = this.FNationalDayDatas_2015.GetActivityByIdentify(ACTIVITY_1_ID) as TNationalDay1_2015;
               if(_loc10_ == ACTIVITY_1_GET_DAILY_GIFT)
               {
                  _loc33_.DailyGift.Status = TBaseActivity.STATUS_GETED;
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
                  _loc33_.ChangeStatus();
                  this.FNationalDayDatas_2015.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FNationalDayDatas_2015.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_LOTTERY)
               {
                  --_loc33_.FreeCount;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc18_ = int(_loc2_.readUnsignedInt());
                  _loc6_ = 0;
                  while(_loc6_ < _loc18_)
                  {
                     _loc16_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc13_ = int(_loc2_.readUnsignedInt());
                     _loc4_ += STRING_COMMON.GetItemNameByType(_loc16_,_loc11_) + "*" + _loc13_ + "\n";
                     _loc6_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc33_.ChangeStatus();
                  this.FNationalDayDatas_2015.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FNationalDayDatas_2015.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_BUY_FUND)
               {
                  _loc33_.FundStatus = _loc2_.readUnsignedInt();
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
                  _loc33_.ChangeStatus();
                  this.FNationalDayDatas_2015.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FNationalDayDatas_2015.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_2_ID:
               _loc34_ = this.FNationalDayDatas_2015.GetActivityByIdentify(ACTIVITY_2_ID) as TNationalDay2_2015;
               if(_loc10_ == ACTIVITY_2_PLAY_GAME)
               {
                  if(_loc34_.Count > 0)
                  {
                     --_loc34_.Count;
                  }
                  _loc34_.Step = _loc2_.readUnsignedInt();
                  _loc34_.TargetIndex = (_loc34_.StepIndex + _loc34_.Step) % TUINationDay2_2015.SHOW_ITEM_COUNT;
                  _loc34_.NextDoubleStatus = _loc34_.ItemList[_loc34_.TargetIndex].Type == TNationalDay2_2015.TYPE_DOUBLE ? 1 : 0;
                  _loc34_.UpgradeStatus = _loc34_.ItemList[_loc34_.TargetIndex].Type == TNationalDay2_2015.TYPE_HOME ? 1 : 0;
                  _loc34_.BossHp = _loc2_.readUnsignedInt();
                  _loc34_.Gift.Count = _loc2_.readUnsignedInt();
                  _loc34_.RankPoint = _loc2_.readUnsignedInt();
                  _loc34_.ShopExchangePoint = _loc2_.readUnsignedInt();
                  this.FUIWindowVect[1].PlayMovie();
               }
               else if(_loc10_ == ACTIVITY_2_BUY_DICE)
               {
                  _loc34_.Step = _loc2_.readUnsignedInt();
                  _loc34_.TargetIndex = (_loc34_.StepIndex + _loc34_.Step) % TUINationDay2_2015.SHOW_ITEM_COUNT;
                  _loc34_.NextDoubleStatus = _loc34_.ItemList[_loc34_.TargetIndex].Type == TNationalDay2_2015.TYPE_DOUBLE ? 1 : 0;
                  _loc34_.UpgradeStatus = _loc34_.ItemList[_loc34_.TargetIndex].Type == TNationalDay2_2015.TYPE_HOME ? 1 : 0;
                  _loc34_.BossHp = _loc2_.readUnsignedInt();
                  _loc34_.Gift.Count = _loc2_.readUnsignedInt();
                  _loc34_.RankPoint = _loc2_.readUnsignedInt();
                  _loc34_.ShopExchangePoint = _loc2_.readUnsignedInt();
                  this.FUIWindowVect[1].PlayMovie();
               }
               else if(_loc10_ == ACTIVITY_2_UPGRADE)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  ++_loc34_.ItemList[_loc5_].Level;
                  _loc34_.UpgradeStatus = 0;
                  _loc28_.length = 0;
                  _loc29_.length = 0;
                  _loc8_ = new TInventories();
                  _loc18_ = int(_loc2_.readUnsignedInt());
                  _loc6_ = 0;
                  while(_loc6_ < _loc18_)
                  {
                     _loc16_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc12_ = CONST_COMMON.GetItemIDByType(_loc16_,_loc11_,_loc17_);
                     _loc28_.push(_loc12_);
                     _loc29_.push(_loc2_.readUnsignedInt());
                     _loc6_++;
                  }
                  this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc28_);
                  _loc6_ = 0;
                  while(_loc6_ < _loc18_)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc6_);
                     _loc9_.Quantity = _loc29_[_loc6_];
                     _loc6_++;
                  }
                  _loc34_.ItemList[_loc5_].Inventories = _loc8_;
                  ProcessorEffectText(_loc34_.DescListNew[3]);
                  _loc34_.ChangeStatus();
                  this.FNationalDayDatas_2015.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FNationalDayDatas_2015.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_UPGRADE_CANCEL)
               {
                  _loc34_.UpgradeStatus = 0;
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_GET_BOX)
               {
                  --_loc34_.Gift.Count;
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
                  _loc34_.ChangeStatus();
                  this.FNationalDayDatas_2015.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FNationalDayDatas_2015.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_EXCHANGE_ITEM)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  --_loc34_.ShopExchangeItems[_loc5_].LimitCount;
                  _loc34_.ShopExchangePoint -= _loc34_.ShopExchangeItems[_loc5_].Price;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  ProcessorEffectText(_loc4_);
                  _loc34_.ChangeStatus();
                  this.FNationalDayDatas_2015.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FNationalDayDatas_2015.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_3_ID:
               _loc35_ = this.FNationalDayDatas_2015.GetActivityByIdentify(ACTIVITY_3_ID) as TNationalDay3_2015;
               if(_loc10_ == ACTIVITY_3_GET_SWEET)
               {
                  if(_loc35_.Count > 0)
                  {
                     --_loc35_.Count;
                  }
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc35_.Score += _loc14_;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  if(_loc14_ > 0)
                  {
                     _loc4_ += _loc35_.DescListNew[9] + "*" + _loc14_ + "\n";
                  }
                  _loc5_ = 0;
                  while(_loc5_ < _loc35_.SweetList.length)
                  {
                     _loc35_.SweetList[_loc5_].Status = _loc2_.readInt();
                     _loc5_++;
                  }
                  _loc35_.PoolValue = _loc2_.readUnsignedInt();
                  _loc35_.Gift.Count = _loc2_.readUnsignedInt();
                  ProcessorEffectText(_loc4_);
                  _loc35_.ChangeStatus();
                  this.FNationalDayDatas_2015.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FNationalDayDatas_2015.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_GET_TEN)
               {
                  _loc35_.AmountList.length = 0;
                  _loc35_.IndexList.length = 0;
                  _loc35_.StatusList.length = 0;
                  _loc5_ = 0;
                  while(_loc5_ < 10)
                  {
                     _loc35_.AmountList[_loc5_] = _loc2_.readUnsignedInt();
                     _loc35_.IndexList[_loc5_] = _loc2_.readUnsignedInt();
                     _loc35_.StatusList[_loc5_] = _loc2_.readInt();
                     _loc35_.Score += _loc35_.AmountList[_loc5_];
                     _loc5_++;
                  }
                  _loc35_.PoolValue = _loc2_.readUnsignedInt();
                  _loc35_.Gift.Count = _loc2_.readUnsignedInt();
                  if(Boolean(FMC_Scene) && Boolean(this.visible) && this.FIsOpen)
                  {
                     this.FUIWindowVect[2].PlayMovie();
                  }
               }
               else if(_loc10_ == ACTIVITY_3_GET_BOX)
               {
                  --_loc35_.Gift.Count;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc35_.Gift.Inventories.Count)
                  {
                     _loc9_ = _loc35_.Gift.Inventories.GetInventoryByIndex(_loc6_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc6_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc35_.ChangeStatus();
                  this.FNationalDayDatas_2015.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FNationalDayDatas_2015.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_EXCHANGE_HERO)
               {
                  _loc35_.Hero.Status = TBaseActivity.STATUS_GETED;
                  _loc35_.Score = _loc2_.readUnsignedInt();
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  ProcessorEffectText(_loc4_);
                  _loc35_.ChangeStatus();
                  this.FNationalDayDatas_2015.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FNationalDayDatas_2015.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_EXCHANGE_ITEM)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  --_loc35_.ItemList[_loc5_].LimitCount;
                  _loc35_.Score = _loc2_.readUnsignedInt();
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc35_.ItemList[_loc5_].Inventories.Count)
                  {
                     _loc9_ = _loc35_.ItemList[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc6_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc35_.ChangeStatus();
                  this.FNationalDayDatas_2015.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FNationalDayDatas_2015.CheckStatus());
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
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
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
         _loc3_.writeShort(8);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"主面板介绍1");
         TUtilityString.FlushUTF(_loc3_,"主面板介绍2");
         TUtilityString.FlushUTF(_loc3_,"主面板介绍3");
         TUtilityString.FlushUTF(_loc3_,"每登陆%0天可获得1次抽奖机会,再登陆%1天可获得1次抽奖机会");
         TUtilityString.FlushUTF(_loc3_,"玩家自投资之日起，连续10天都能获得金币和道具返回。");
         TUtilityString.FlushUTF(_loc3_,"每日可获得%0金币");
         TUtilityString.FlushUTF(_loc3_,"...");
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(2);
         _loc3_.writeUnsignedInt(3);
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
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeInt(1);
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
      
      public function TestInit1() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
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
         TUtilityString.FlushUTF(_loc3_,"击杀礼包描述");
         TUtilityString.FlushUTF(_loc3_,"建筑升级成功");
         TUtilityString.FlushUTF(_loc3_,"你到达积分点,获得%0点积分,%n%同时对怪兽造成%1点伤害");
         TUtilityString.FlushUTF(_loc3_,"你到达物品点,获得%0");
         TUtilityString.FlushUTF(_loc3_,"你到达双倍点,获得双倍状态");
         TUtilityString.FlushUTF(_loc3_,"你到达栖息地,获得%0");
         TUtilityString.FlushUTF(_loc3_,"你当前处于双倍状态中,获得双倍的%0积分,%n%同时对怪兽造成%1点伤害");
         TUtilityString.FlushUTF(_loc3_,"你当前处于双倍状态中,到达物品点,获得%0");
         TUtilityString.FlushUTF(_loc3_,"你当前处于双倍状态中,到达栖息地,获得%0");
         TUtilityString.FlushUTF(_loc3_,"1级栖息地描述");
         TUtilityString.FlushUTF(_loc3_,"2级栖息地描述");
         TUtilityString.FlushUTF(_loc3_,"3级栖息地描述");
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(2);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(99);
         _loc3_.writeUnsignedInt(23);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.writeShort(24);
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            _loc3_.writeInt(_loc1_ % 4 + 1);
            _loc3_.writeInt(_loc1_ % 2 + 1);
            _loc3_.writeInt(_loc1_ + 1);
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
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            TUtilityString.FlushUTF(_loc3_,"aaa");
            _loc3_.writeUnsignedInt(70100022);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.writeShort(7);
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeShort(1);
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
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
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
         _loc3_.writeShort(14);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"礼包描述");
         TUtilityString.FlushUTF(_loc3_,"十连抽TIPS");
         TUtilityString.FlushUTF(_loc3_,"TIPS1");
         TUtilityString.FlushUTF(_loc3_,"TIPS2");
         TUtilityString.FlushUTF(_loc3_,"TIPS3");
         TUtilityString.FlushUTF(_loc3_,"TIPS4");
         TUtilityString.FlushUTF(_loc3_,"TIPS5");
         TUtilityString.FlushUTF(_loc3_,"活动道具名称");
         TUtilityString.FlushUTF(_loc3_,"兑换需要消耗收集物%0个");
         TUtilityString.FlushUTF(_loc3_,"当前充值%0金币,再充值%1金币,仅需消耗%2个收集物");
         TUtilityString.FlushUTF(_loc3_,"忍者TIPS");
         TUtilityString.FlushUTF(_loc3_,"充值活动详情");
         _loc3_.writeUnsignedInt(99);
         _loc3_.writeUnsignedInt(23);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(3);
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
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(1);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.writeShort(6);
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _loc3_.writeInt(_loc1_ + 1);
            _loc3_.writeInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.writeShort(6);
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _loc3_.writeInt(_loc1_ + 1);
            _loc3_.writeInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.writeInt(0);
         _loc3_.writeInt(1);
         _loc3_.writeUnsignedInt(11210009);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeShort(6);
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeShort(1);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

