package Processors.Game.Lobby.Exercise.Christmas
{
   import Externals.SExternalCore;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.Christmas.TChristmasCollect;
   import Logics.Exercise.Christmas.TChristmasColorEgg;
   import Logics.Exercise.Christmas.TChristmasDatas;
   import Logics.Exercise.Christmas.TChristmasRank;
   import Logics.Exercise.Christmas.TChristmasSign;
   import Logics.Exercise.Christmas.TChristmasSock;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerChristmas;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.Christmas.Compoents.TUIChristmasBase;
   import Processors.Game.Lobby.Exercise.Christmas.Compoents.TUIChristmasCollect;
   import Processors.Game.Lobby.Exercise.Christmas.Compoents.TUIChristmasColorEgg;
   import Processors.Game.Lobby.Exercise.Christmas.Compoents.TUIChristmasRank;
   import Processors.Game.Lobby.Exercise.Christmas.Compoents.TUIChristmasSign;
   import Processors.Game.Lobby.Exercise.Christmas.Compoents.TUIChristmasSock;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Rendering.Overlayers.Box.TOverlayerBox;
   import Rendering.Overlayers.Christmas.TOverlayerThreeStr;
   import Rendering.Overlayers.NationalDay.TOverlayerSimpleNinjia;
   import Rendering.Overlayers.Title.TOverlayerTitle;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorChristmas extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      public static const ACTIVITY_5_ID:int = 5;
      
      public static const CHRISTMAS_SIGN_BOX:int = 1;
      
      public static const CHRISTMAS_COLLECT:int = 1;
      
      public static const CHRISTMAS_COLLECT_BOX:int = 2;
      
      public static const CHRISTMAS_COLLECT_NUM_BOX:int = 3;
      
      public static const CHRISTMAS_COLOREGG_GIFT:int = 1;
      
      public static const CHRISTMAS_COLOREGG_BUY_BOX:int = 2;
      
      public static const CHRISTMAS_RANK_GET_BOX:int = 1;
      
      public static const CHRISTMAS_RANK_GET_HERO:int = 2;
      
      public static const CHRISTMAS_SOCK_GET_SWEET:int = 1;
      
      public static const CHRISTMAS_SOCK_GET_SOCK:int = 2;
      
      public static const CHRISTMAS_SOCK_GET_HERO:int = 3;
      
      public static const CHRISTMAS_SOCK_GET_BOX:int = 4;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      protected var SIZE_WIDTH:int = 915;
      
      protected var SIZE_HEIGHT:int = 556;
      
      protected var TAB_COUNT:int = 5;
      
      protected var DAY_COUNT:int = 31;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIChristmasSign,TUIChristmasCollect,TUIChristmasColorEgg,TUIChristmasRank,TUIChristmasSock]);
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIChristmasBase>;
      
      protected var FChristmasDatas:TChristmasDatas;
      
      protected var FUnstreamizerChristmas:TUnstreamizerChristmas;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FBuyBoxDate:Object;
      
      protected var FProcessorChristmasRank:TProcessorChristmasRank;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorWindowChristmasDesc:TProcessorWindowChristmasDesc;
      
      protected var FOverlayerSimpleNinjia:TOverlayerSimpleNinjia;
      
      protected var FOverlayerThreeStr:TOverlayerThreeStr;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      public function TProcessorChristmas(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FChristmasDatas = SLogicsCore.ChristmasDatas;
         this.FUnstreamizerChristmas = new TUnstreamizerChristmas();
         this.FUnstreamizerTitle = new TUnstreamizerTitle();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FTabList = new Vector.<MovieClip>(this.TAB_COUNT);
         this.FChangeTabIndex = 0;
         this.FGlowsFilter = new Vector.<TEffectBaseGlowTwo>(this.TAB_COUNT);
         this.FUIWindowVect = new Vector.<TUIChristmasBase>(this.TAB_COUNT);
         this.FOverlayerBox = new TOverlayerBox(this.Parent);
         this.FOverlayerBox.Visible = false;
         this.FBuyBoxDate = new Object();
         this.FProcessorChristmasRank = new TProcessorChristmasRank(this.Parent);
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FProcessorWindowChristmasDesc = new TProcessorWindowChristmasDesc(this.Parent);
         this.FOverlayerSimpleNinjia = new TOverlayerSimpleNinjia(this.Parent);
         this.FOverlayerSimpleNinjia.Visible = false;
         this.FOverlayerThreeStr = new TOverlayerThreeStr(this.Parent);
         this.FOverlayerThreeStr.Visible = false;
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
            this.FUIWindowVect[_loc1_].OnBoxOver = this.ProcessorOnBoxOver;
            this.FUIWindowVect[_loc1_].OnBoxOut = this.ProcessorOnBoxOut;
            this.FUIWindowVect[_loc1_].OnGetBox = this.ProcessorOnGetBoxUp;
            this.FUIWindowVect[_loc1_].OnCollectUp = this.ProcessorOnCollectUp;
            this.FUIWindowVect[_loc1_].OnItemOver = UIComponentsHintOnOver;
            this.FUIWindowVect[_loc1_].OnItemOut = UIComponentsHintOnOut;
            this.FUIWindowVect[_loc1_].OnShowTip = ProcessorOnShowTip;
            this.FUIWindowVect[_loc1_].OnHideTip = ProcessorOnHideTip;
            this.FUIWindowVect[_loc1_].OnBuyBox = this.ProcessorOnBuyBoxUp;
            this.FUIWindowVect[_loc1_].OnLoadRank = this.ProcessorOnGotoRank;
            this.FUIWindowVect[_loc1_].OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FUIWindowVect[_loc1_].OnShowHeroTip = this.ProcessorOnHeroOver;
            this.FUIWindowVect[_loc1_].OnHideHeroTip = this.ProcessorOnHeroOut;
            this.FUIWindowVect[_loc1_].OnShowDesc = this.ProcessorOnShowDesc;
            this.FUIWindowVect[_loc1_].OnShowThreeStr = this.ProcessorOnShowThreeStr;
            this.FUIWindowVect[_loc1_].OnHideThreeStr = this.ProcessorOnHideThreeStr;
            this.FUIWindowVect[_loc1_].OnLoadLog = this.ProcessorOnLoadLog;
            _loc1_++;
         }
         this.FProcessorChristmasRank.OnCloseUp = this.ProcessorOnCloseWindow;
         this.FProcessorChristmasRank.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorChristmasRank.OnOut = UIComponentsHintOnOut;
         this.FProcessorChristmasRank.TitleHintOnOver = this.ProcessorOnTitleOver;
         this.FProcessorChristmasRank.TitleHintOnOut = this.ProcessorOnTitleOut;
         this.FProcessorChristmasRank.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBox);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSimpleNinjia);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerThreeStr);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTitle);
         this.FProcessorWindowChristmasDesc.OnCloseUp = this.ProcessorOnCloseDescWindow;
         this.FProcessorWindowChristmasDesc.Visible = false;
         this.FUnstreamizerTitle.UnstreamizeTitleByDatabase(null,this.FAllTitles,null);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FMC_Scene)
         {
            this.UpdateTabEffect();
            this.FUIWindowVect[this.FChangeTabIndex].LogicsPerform();
            if(FMC_Scene.visible)
            {
               if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
               {
                  this.FProcessorWindowRecruit.UpdataBitmap();
               }
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
            _loc3_ = this.FChristmasDatas.GetActivityByIndex(_loc1_);
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
            if(this.FChristmasDatas.Activities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
            {
               this.FGlowsFilter[_loc1_].IsRunOver = false;
            }
            else
            {
               this.FGlowsFilter[_loc1_].Stop();
            }
            _loc1_++;
         }
         FTF_Desc.text = this.FChristmasDatas.Activities[this.FChangeTabIndex].ActivityDesc;
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
         _loc3_ = this.FChristmasDatas.GetActivityByIndex(_loc2_);
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
         _loc3_ = this.FChristmasDatas.GetActivityByIndex(_loc2_);
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
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 0) : void
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
            FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
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
      
      protected function ProcessorOnCollectUp() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:Vector.<int> = null;
         var _loc3_:TChristmasCollect = null;
         if(this.FBeClicked)
         {
            return;
         }
         SExternalCore.AddCollect();
         _loc3_ = this.FChristmasDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TChristmasCollect;
         if(_loc3_.Status != TBaseActivity.STATUS_CANNOTGET)
         {
            return;
         }
         this.FBeClicked = true;
         _loc2_ = new Vector.<int>();
         _loc2_.push(CHRISTMAS_COLLECT);
         PerformPacket_CS_AllReq(ACTIVITY_2_ID,_loc2_);
      }
      
      protected function ProcessorOnGotoRank(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:int = 0;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Christmas_LoadRankListInfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         this.FProcessorChristmasRank.Visible = false;
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
      
      protected function ProcessorOnShowRecruit(param1:uint) : void
      {
         this.FProcessorWindowRecruit.SetHeroData(param1);
      }
      
      protected function ProcessorOnHeroOver(param1:TBaseBox) : void
      {
         this.FOverlayerSimpleNinjia.Context = param1;
         this.FOverlayerSimpleNinjia.Render(FUICore.MouseCoordinate);
         this.FOverlayerSimpleNinjia.Show();
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
      
      protected function ProcessorOnShowDesc() : void
      {
         this.FProcessorWindowChristmasDesc.Visible = true;
      }
      
      protected function ProcessorOnCloseDescWindow() : void
      {
         this.FProcessorWindowChristmasDesc.Visible = false;
      }
      
      protected function ProcessorOnLoadLog() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_OrangeEquipment_LoadLogReq);
         _loc1_.Data.writeUnsignedInt(FActivityID);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorChristmasRank.Load();
            this.FProcessorWindowRecruit.Load();
            this.FProcessorWindowChristmasDesc.Load();
            return;
         }
         this.visible = true;
         this.alpha = 1;
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
         this.FProcessorChristmasRank.visible = false;
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
         this.FUnstreamizerChristmas.Unstreamize(_loc2_,this.FChristmasDatas,null);
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
         var _loc6_:TChristmasRank = null;
         var _loc7_:TConsumeRankInfo = null;
         var _loc8_:TBaseBox = null;
         var _loc9_:TInventories = null;
         var _loc10_:TInventory = null;
         var _loc11_:Vector.<uint> = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc6_ = this.FChristmasDatas.GetActivityByIdentify(ACTIVITY_4_ID) as TChristmasRank;
         if(_loc6_)
         {
            _loc6_.RankRewardList.length = 0;
            _loc5_ = int(_loc2_.readUnsignedShort());
            _loc11_ = new Vector.<uint>();
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc8_ = new TBaseBox();
               _loc8_.Min = _loc2_.readUnsignedInt();
               _loc8_.Max = _loc2_.readUnsignedInt();
               _loc8_.TitleID = _loc2_.readUnsignedInt();
               _loc11_.length = 0;
               _loc9_ = new TInventories();
               _loc11_.push(_loc2_.readUnsignedInt());
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc11_);
               _loc10_ = _loc9_.GetInventoryByIndex(0);
               _loc10_.Quantity = 1;
               _loc8_.Inventories = _loc9_;
               _loc6_.RankRewardList.push(_loc8_);
               _loc4_++;
            }
            _loc6_.RankList.length = 0;
            _loc5_ = int(_loc2_.readUnsignedShort());
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc7_ = new TConsumeRankInfo();
               _loc7_.UserName = TUtilityString.FetchUTF(_loc2_);
               _loc7_.ServerName = TUtilityString.FetchUTF(_loc2_);
               _loc7_.Rank = _loc2_.readUnsignedInt();
               _loc7_.Score = _loc2_.readUnsignedInt();
               _loc6_.RankList.push(_loc7_);
               _loc4_++;
            }
         }
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.FProcessorChristmasRank.Visible = true;
            this.FProcessorChristmasRank.UpdateUI();
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
         var _loc17_:TChristmasSock = null;
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
         _loc17_ = this.FChristmasDatas.GetActivityByIdentify(ACTIVITY_5_ID) as TChristmasSock;
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
         var _loc8_:TChristmasColorEgg = null;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         _loc5_ = _loc2_.readInt();
         switch(_loc5_)
         {
            case ACTIVITY_1_ID:
            case ACTIVITY_2_ID:
               break;
            case ACTIVITY_3_ID:
               _loc8_ = this.FChristmasDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TChristmasColorEgg;
               if((Boolean(_loc8_)) && Boolean(FMC_Scene))
               {
                  _loc8_.Status = _loc2_.readInt();
                  this.FChristmasDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas.CheckStatus());
                  if(this.visible == true)
                  {
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_4_ID:
            case ACTIVITY_5_ID:
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
         var _loc14_:uint = 0;
         var _loc15_:TChristmasSign = null;
         var _loc16_:TChristmasCollect = null;
         var _loc17_:TChristmasColorEgg = null;
         var _loc18_:TChristmasRank = null;
         var _loc19_:TChristmasSock = null;
         var _loc20_:TBaseBox = null;
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
               _loc15_ = this.FChristmasDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TChristmasSign;
               _loc15_.CurStatus = TBaseActivity.STATUS_GETED;
               _loc5_ = _loc15_.CurDay - 1;
               _loc15_.DayList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc8_ = _loc15_.DayList[_loc5_].Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               this.FChristmasDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
               ProcessorCheckEffect(FActivityID,this.FChristmasDatas.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_2_ID:
               _loc2_.readShort();
               _loc10_ = _loc2_.readUnsignedInt();
               _loc16_ = this.FChristmasDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TChristmasCollect;
               if(_loc10_ == CHRISTMAS_COLLECT)
               {
                  _loc16_.CollectNum = _loc2_.readUnsignedInt();
                  _loc16_.ChangeStatus();
                  if(_loc16_.Status == TBaseActivity.STATUS_CANNOTGET)
                  {
                     _loc16_.Status = TBaseActivity.STATUS_CANGET;
                  }
               }
               else if(_loc10_ == CHRISTMAS_COLLECT_BOX)
               {
                  _loc16_.Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc16_.Inventories;
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
               else
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc16_.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc16_.BoxList[_loc5_].Inventories;
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
               this.FChristmasDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
               ProcessorCheckEffect(FActivityID,this.FChristmasDatas.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_3_ID:
               _loc2_.readShort();
               _loc10_ = _loc2_.readUnsignedInt();
               _loc17_ = this.FChristmasDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TChristmasColorEgg;
               if(_loc10_ == CHRISTMAS_COLOREGG_GIFT)
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
               }
               else if(_loc10_ == CHRISTMAS_COLOREGG_BUY_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  ++_loc17_.BoxList[_loc5_].BuyCount;
                  _loc8_ = _loc17_.BoxList[_loc5_].Inventories;
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
               this.FChristmasDatas.ChangeSingleActivityStatus(ACTIVITY_3_ID);
               ProcessorCheckEffect(FActivityID,this.FChristmasDatas.CheckStatus());
               ProcessorOnHideTip();
               this.UpdateUI();
               break;
            case ACTIVITY_4_ID:
               _loc2_.readShort();
               _loc10_ = _loc2_.readUnsignedInt();
               _loc18_ = this.FChristmasDatas.GetActivityByIdentify(ACTIVITY_4_ID) as TChristmasRank;
               if(_loc10_ == CHRISTMAS_RANK_GET_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  ++_loc18_.BoxList[_loc5_].BuyCount;
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
                  _loc5_ = 0;
                  while(_loc5_ < 5)
                  {
                     _loc18_.BoxList[_loc5_].Status = _loc2_.readInt();
                     _loc5_++;
                  }
               }
               else if(_loc10_ == CHRISTMAS_RANK_GET_HERO)
               {
                  _loc18_.HeroList[0].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
                  ProcessorEffectText(_loc4_);
               }
               this.FChristmasDatas.ChangeSingleActivityStatus(ACTIVITY_4_ID);
               ProcessorCheckEffect(FActivityID,this.FChristmasDatas.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_5_ID:
               _loc2_.readShort();
               _loc10_ = _loc2_.readUnsignedInt();
               _loc19_ = this.FChristmasDatas.GetActivityByIdentify(ACTIVITY_5_ID) as TChristmasSock;
               if(_loc10_ == CHRISTMAS_SOCK_GET_SWEET)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  if(_loc5_ < _loc19_.SweetList.length - 1)
                  {
                     _loc19_.SweetList[_loc5_ + 1].Status = TBaseActivity.STATUS_CANGET;
                  }
                  _loc19_.SweetList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc4_ = _loc4_ + (STRING_BASEACTIVITY.FORMAT_DROP_ITEM_NAME[0] + "*" + _loc19_.SweetList[_loc5_].Count);
                  ProcessorEffectText(_loc4_);
               }
               else if(_loc10_ == CHRISTMAS_SOCK_GET_SOCK)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  ++_loc19_.SockList[_loc5_].BuyCount;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc14_ = _loc2_.readUnsignedInt();
                  if(_loc14_ > 0)
                  {
                     _loc4_ += STRING_BASEACTIVITY.FORMAT_DROP_ITEM_NAME[0] + "*" + _loc14_ + "\n";
                  }
                  _loc14_ = _loc2_.readUnsignedInt();
                  if(_loc14_ > 0)
                  {
                     _loc4_ += STRING_BASEACTIVITY.FORMAT_DROP_ITEM_NAME[1] + "*" + _loc14_ + "\n";
                     _loc19_.Score += _loc14_;
                  }
                  ProcessorEffectText(_loc4_);
               }
               else if(_loc10_ == CHRISTMAS_SOCK_GET_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc20_ = _loc19_.BoxList[_loc5_];
                  _loc19_.Score -= _loc20_.Price;
                  _loc8_ = _loc19_.BoxList[_loc5_].Inventories;
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
               else if(_loc10_ == CHRISTMAS_SOCK_GET_HERO)
               {
                  _loc20_ = _loc19_.ExchangeHero;
                  _loc20_.Status = TBaseActivity.STATUS_GETED;
                  _loc19_.Score -= _loc20_.Price;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  ProcessorEffectText(_loc4_);
               }
               this.FChristmasDatas.ChangeSingleActivityStatus(ACTIVITY_5_ID);
               ProcessorCheckEffect(FActivityID,this.FChristmasDatas.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([1,1,1,1,1]);
         var _loc5_:Vector.<int> = Vector.<int>([1,0,0,0,0]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
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
         _loc3_.writeInt(1);
         _loc3_.writeInt(27);
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
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit1() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([1,1,1,1,1]);
         var _loc5_:Vector.<int> = Vector.<int>([1,0,0,0,0]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
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
         TUtilityString.FlushUTF(_loc3_,"活动2");
         _loc3_.writeInt(0);
         _loc3_.writeInt(0);
         _loc3_.writeShort(3);
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc2_ + _loc1_);
            _loc3_.writeUnsignedInt(1 + _loc2_);
            _loc2_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeInt(1);
            _loc3_.writeInt(1 + _loc1_);
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
      
      public function TestInit2() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([1,1,1,1,1]);
         var _loc5_:Vector.<int> = Vector.<int>([1,0,0,0,0]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc3_,"描述1");
            _loc3_.writeInt(_loc4_[_loc1_]);
            _loc3_.writeUnsignedInt(STimingCore.GetServerTime());
            _loc3_.writeInt(_loc5_[_loc1_]);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"活动2");
         TUtilityString.FlushUTF(_loc3_,"对话1");
         _loc3_.writeInt(1);
         _loc3_.writeShort(1);
         _loc2_ = 0;
         while(_loc2_ < 1)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14101121);
            _loc3_.writeUnsignedInt(1 + _loc2_);
            _loc2_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeInt(10 + _loc1_);
            _loc3_.writeInt(1 + _loc1_);
            _loc3_.writeInt(5);
            _loc3_.writeInt(_loc5_[_loc1_]);
            TUtilityString.FlushUTF(_loc3_,"彩蛋" + _loc1_);
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
      
      public function TestInit3() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([1,1,1,1,1]);
         var _loc5_:Vector.<int> = Vector.<int>([1,0,0,0,0]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc3_,"描述1");
            _loc3_.writeInt(_loc4_[_loc1_]);
            _loc3_.writeUnsignedInt(STimingCore.GetServerTime());
            _loc3_.writeInt(_loc5_[_loc1_]);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(4);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"活动4");
         TUtilityString.FlushUTF(_loc3_,"活动4");
         _loc3_.writeUnsignedInt(500);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(10 + _loc1_);
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
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeInt(0);
            _loc3_.writeUnsignedInt(11210009 + _loc1_);
            TUtilityString.FlushUTF(_loc3_,"aaa");
            TUtilityString.FlushUTF(_loc3_,"bbb");
            TUtilityString.FlushUTF(_loc3_,"ccc");
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
         var _loc4_:Vector.<int> = Vector.<int>([1,1,1,1,1]);
         var _loc5_:Vector.<int> = Vector.<int>([1,0,0,0,0]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc3_,"描述1");
            _loc3_.writeInt(_loc4_[_loc1_]);
            _loc3_.writeUnsignedInt(STimingCore.GetServerTime());
            _loc3_.writeInt(_loc5_[_loc1_]);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"活动5");
         _loc3_.writeUnsignedInt(110);
         _loc3_.writeInt(11210009);
         _loc3_.writeInt(1);
         _loc3_.writeInt(100);
         TUtilityString.FlushUTF(_loc3_,"aaa");
         TUtilityString.FlushUTF(_loc3_,"bbb");
         TUtilityString.FlushUTF(_loc3_,"ccc");
         _loc3_.writeShort(6);
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _loc3_.writeInt(10 + _loc1_);
            _loc3_.writeInt(1);
            _loc3_.writeUnsignedInt(0);
            TUtilityString.FlushUTF(_loc3_,"aaa");
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
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeInt(0);
            TUtilityString.FlushUTF(_loc3_,"aaa");
            TUtilityString.FlushUTF(_loc3_,"bbb");
            TUtilityString.FlushUTF(_loc3_,"ccc");
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
            _loc3_.writeUnsignedInt(_loc1_ + 1);
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

