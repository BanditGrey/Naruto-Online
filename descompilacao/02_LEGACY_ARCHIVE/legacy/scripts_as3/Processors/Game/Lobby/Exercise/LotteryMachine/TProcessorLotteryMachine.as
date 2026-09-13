package Processors.Game.Lobby.Exercise.LotteryMachine
{
   import Components.Pages.TUIPage;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.LotteryMachine.TLotteryMachine;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerLotteryMachine;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorLotteryMachine extends TProcessorBaseActivity
   {
      
      protected static const ITEM_COUNT:int = 10;
      
      protected static const RATE_COUNT:int = 5;
      
      protected static const LUCKY_COUNT:int = 3;
      
      protected static const NEWS_COUNT:int = 3;
      
      protected static const REQ_TYPE_GHANGE_STATUS:int = 1;
      
      protected static const REQ_TYPE_LOTTERY:int = 2;
      
      protected static const ADD_ROUND:int = 3;
      
      protected static const RANDOM_ROUND:int = 2;
      
      protected static const ADD_ROUND_RATE:int = 3;
      
      protected static const RANDOM_ROUND_RATE:int = 2;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FIsPlaying:Boolean;
      
      protected var FWindowType:int;
      
      protected var FMovieType:int;
      
      protected var FOpenIndex:int;
      
      protected var FFrameCount:int;
      
      protected var FTotalFrame:int;
      
      protected var FPlayMovie:MovieClip;
      
      protected var FLotteryMachine:TLotteryMachine;
      
      protected var FUnstreamizerLotteryMachine:TUnstreamizerLotteryMachine;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FReward:TUIShowItem;
      
      protected var FSelectIndex:int;
      
      protected var FRewardData:TInventories;
      
      protected var FRateIndex:int;
      
      protected var FTargetIndex:int;
      
      protected var FTotalStep:int;
      
      protected var FCurStep:int;
      
      protected var FFlowStr:String;
      
      protected var FIsPlaying_Rate:Boolean;
      
      protected var FFrameCount_Rate:int;
      
      protected var FTotalStep_Rate:int;
      
      protected var FCurStep_Rate:int;
      
      protected var FUIPage_LuckyPlayer:TUIPage;
      
      protected var FTotalPage_LuckyPlayer:int;
      
      protected var FCurPage_LuckyPlayer:int;
      
      protected var FUIPage_News:TUIPage;
      
      protected var FTotalPage_News:int;
      
      protected var FCurPage_News:int;
      
      protected var FUISelectConfirmation:TUIWindowConfirmation;
      
      public function TProcessorLotteryMachine(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FLotteryMachine = SLogicsCore.LotteryMachine;
         this.FUnstreamizerLotteryMachine = new TUnstreamizerLotteryMachine();
         this.FBuyBoxDate = new Object();
         this.FSelectIndex = -1;
         this.FRateIndex = -1;
         this.FUIPage_LuckyPlayer = new TUIPage(this);
         this.FUIPage_News = new TUIPage(this);
         this.FUISelectConfirmation = new TUIWindowConfirmation(this.Parent);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIShowItem = null;
         super.ResourcesPerform_UIDispatch();
         _loc5_ = new TUIShowItem(this,ITEM_COUNT);
         _loc5_.Perform_UIDispatch(FMC_Scene);
         _loc5_.OnOverlay = UIComponentsHintOnOver;
         _loc5_.OnOut = UIComponentsHintOnOut;
         this.FShowItem = _loc5_;
         _loc5_ = new TUIShowItem(this,1);
         _loc5_.Perform_UIDispatch(FMC_Scene.MC_Reward);
         _loc5_.OnOverlay = UIComponentsHintOnOver;
         _loc5_.OnOut = UIComponentsHintOnOut;
         this.FReward = _loc5_;
         _loc1_ = 0;
         while(_loc1_ < ITEM_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Slot" + _loc1_];
            _loc4_.MC_Movie.visible = false;
            _loc4_.BTN_Select.visible = false;
            _loc4_.BTN_Cancel.visible = false;
            TGameUtil.setButtonMode(_loc4_.BTN_Select,true);
            _loc4_.BTN_Select.addEventListener(MouseEvent.CLICK,this.ProcessorOnSelectUp);
            TGameUtil.setButtonMode(_loc4_.BTN_Cancel,true);
            _loc4_.BTN_Cancel.addEventListener(MouseEvent.CLICK,this.ProcessorOnCancelUp);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < RATE_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Time" + _loc1_];
            _loc4_.MC_Icon.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc1_++;
         }
         FMC_Scene.MC_Rate.visible = false;
         FMC_Scene.MC_Status.buttonMode = true;
         FMC_Scene.MC_Status.addEventListener(MouseEvent.CLICK,this.ProcessorOnStatusUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnLotteryUp);
         this.FUIPage_News.ButtonPrevious.Substrate = FMC_Scene.MC_News.MC_ChangePage.MC_PageLeft;
         this.FUIPage_News.ButtonNext.Substrate = FMC_Scene.MC_News.MC_ChangePage.MC_PageRight;
         this.FUIPage_News.TotalQuantity = this.FTotalPage_News;
         this.FUIPage_News.LabelPage = FMC_Scene.MC_News.MC_ChangePage.TF_Page;
         this.FUIPage_News.PageSize = NEWS_COUNT;
         this.FUIPage_News.PageIndex = 0;
         this.FCurPage_News = 0;
         this.FUIPage_News.OnChangePage = this.ProcessorPageOnChange_News;
         this.FUIPage_LuckyPlayer.ButtonPrevious.Substrate = FMC_Scene.MC_LuckyPlayer.MC_ChangePage.MC_PageLeft;
         this.FUIPage_LuckyPlayer.ButtonNext.Substrate = FMC_Scene.MC_LuckyPlayer.MC_ChangePage.MC_PageRight;
         this.FUIPage_LuckyPlayer.TotalQuantity = this.FTotalPage_LuckyPlayer;
         this.FUIPage_LuckyPlayer.LabelPage = FMC_Scene.MC_LuckyPlayer.MC_ChangePage.TF_Page;
         this.FUIPage_LuckyPlayer.PageSize = LUCKY_COUNT;
         this.FUIPage_LuckyPlayer.PageIndex = 0;
         this.FCurPage_LuckyPlayer = 0;
         this.FUIPage_LuckyPlayer.OnChangePage = this.ProcessorPageOnChange_LuckyPlayer;
         this.FUISelectConfirmation.OnOK = this.SelectOnOK;
         this.FUISelectConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUISelectConfirmation.WindowWidth) / 2;
         this.FUISelectConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUISelectConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUISelectConfirmation);
         this.FUISelectConfirmation.SetCheckBox(false);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            if(this.FReward)
            {
               this.FReward.LogicsPerform();
            }
            if(this.FIsPlaying)
            {
               if(this.FCurStep >= this.FTotalStep)
               {
                  this.FIsPlaying = false;
                  this.FFrameCount = 0;
                  this.ItemMovieEnd();
               }
               else
               {
                  this.PlayItemMovie();
                  ++this.FFrameCount;
                  if(this.FFrameCount > 100)
                  {
                     this.FIsPlaying = false;
                     this.FCurStep = 0;
                     this.FFrameCount = 0;
                     this.UpdateUI();
                  }
               }
            }
            if(this.FIsPlaying_Rate)
            {
               if(this.FCurStep_Rate >= this.FTotalStep_Rate)
               {
                  this.FIsPlaying_Rate = false;
                  this.FFrameCount_Rate = 0;
                  this.RateMovieEnd();
               }
               else
               {
                  this.PlayRateMovie();
                  ++this.FFrameCount_Rate;
                  if(this.FFrameCount_Rate > 100)
                  {
                     this.FIsPlaying_Rate = false;
                     this.FCurStep_Rate = 0;
                     this.FFrameCount_Rate = 0;
                     this.UpdateUI();
                  }
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         this.UpdateItems();
         this.UpdateGame();
         this.UpdateText();
         this.UpdateLuckyPlayer();
         this.UpdateNews();
      }
      
      protected function UpdateItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         if(this.FLotteryMachine.GiftStatus == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.MC_Status.filters = [TGameUtil.GaryColorFilters];
            FMC_Scene.MC_Status.stop();
         }
         else if(this.FLotteryMachine.GiftStatus == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_Status.filters = [];
            FMC_Scene.MC_Status.gotoAndPlay(1);
         }
         else if(this.FLotteryMachine.GiftStatus == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Status.filters = [TGameUtil.GaryColorFilters];
            FMC_Scene.MC_Status.stop();
         }
         else
         {
            FMC_Scene.MC_Status.filters = [TGameUtil.GaryColorFilters];
            FMC_Scene.MC_Status.stop();
         }
         this.FShowItem.UpdateUI(this.FLotteryMachine.Items);
         this.FReward.UpdateUI(this.FRewardData);
         _loc1_ = 0;
         while(_loc1_ < ITEM_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Slot" + _loc1_];
            _loc2_.filters = [];
            if(this.FLotteryMachine.GiftStatus == TBaseActivity.STATUS_GETED)
            {
               if(this.FSelectIndex != -1)
               {
                  _loc2_.BTN_Select.visible = false;
                  _loc2_.BTN_Cancel.visible = this.FSelectIndex == _loc1_ ? true : false;
               }
               else
               {
                  _loc2_.BTN_Select.visible = true;
                  _loc2_.BTN_Cancel.visible = false;
               }
            }
            else
            {
               _loc2_.BTN_Select.visible = false;
               _loc2_.BTN_Cancel.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateGame() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < RATE_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Time" + _loc1_];
            _loc2_.TF_Count.text = TUtilityString.Format(this.FLotteryMachine.DescListNew[3],this.FLotteryMachine.RateList[_loc1_]);
            _loc1_++;
         }
         if(this.FRateIndex == -1)
         {
            FMC_Scene.MC_Rate.visible = false;
         }
         else
         {
            FMC_Scene.MC_Rate.visible = true;
            FMC_Scene.MC_Rate.gotoAndPlay(1);
            FMC_Scene.MC_Rate.MC_Rate.TF_Count.text = "x" + this.FLotteryMachine.RateList[this.FRateIndex];
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,this.FLotteryMachine.LotteryCount > 0);
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         FMC_Scene.TF_Desc.text = this.FLotteryMachine.DescListNew[1];
         FMC_Scene.TF_Desc1.text = this.FLotteryMachine.DescListNew[2];
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FLotteryMachine.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FLotteryMachine.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Count.text = this.FLotteryMachine.LotteryCount.toString();
         FMC_Scene.TF_RechargeGold.text = this.FLotteryMachine.TotalRechargeGold.toString();
      }
      
      protected function UpdateLuckyPlayer() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TLotteryNews = null;
         var _loc6_:TSystemLanguage = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         this.FUIPage_LuckyPlayer.TotalQuantity = this.FLotteryMachine.LogList.length;
         this.FUIPage_LuckyPlayer.Update();
         _loc1_ = 0;
         while(_loc1_ < LUCKY_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage_LuckyPlayer * LUCKY_COUNT;
            if(_loc2_ < this.FLotteryMachine.LogList.length)
            {
               _loc5_ = this.FLotteryMachine.LogList[_loc2_];
               _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,_loc5_.SoureID) as TSystemLanguage;
               if(_loc6_ == null)
               {
                  throw new Error("SystemLanguage表未配置 " + _loc5_.SoureID);
               }
               _loc7_ = _loc6_.Desc;
               if(_loc5_.GetTime > 0)
               {
                  _loc8_ = TUtilityDate.FormatDate(new Date(STimingCore.GetClientShowTime(_loc5_.GetTime) * 1000));
                  _loc7_ = _loc7_.split("%when%").join(_loc8_);
               }
               if(Boolean(_loc5_.PlayerNick) && _loc5_.PlayerNick != "")
               {
                  _loc7_ = _loc7_.split("%who%").join(_loc5_.PlayerNick);
               }
               if(_loc5_.Inventory)
               {
                  _loc9_ = _loc5_.Inventory.Name + "*" + _loc5_.Inventory.Quantity;
                  _loc7_ = _loc7_.split("%what%").join(_loc9_);
               }
               FMC_Scene.MC_LuckyPlayer["TF_Log" + _loc1_].text = _loc7_;
            }
            else
            {
               FMC_Scene.MC_LuckyPlayer["TF_Log" + _loc1_].text = "";
            }
            _loc1_++;
         }
      }
      
      protected function UpdateNews() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TLotteryNews = null;
         var _loc6_:TSystemLanguage = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         this.FUIPage_News.TotalQuantity = this.FLotteryMachine.NewsList.length;
         this.FUIPage_News.Update();
         _loc1_ = 0;
         while(_loc1_ < NEWS_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage_News * NEWS_COUNT;
            if(_loc2_ < this.FLotteryMachine.NewsList.length)
            {
               _loc5_ = this.FLotteryMachine.NewsList[_loc2_];
               _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,_loc5_.SoureID) as TSystemLanguage;
               if(_loc6_ == null)
               {
                  throw new Error("SystemLanguage表未配置 " + _loc5_.SoureID);
               }
               _loc7_ = _loc6_.Desc;
               if(_loc5_.GetTime > 0)
               {
                  _loc8_ = TUtilityDate.FormatDate(new Date(STimingCore.GetClientShowTime(_loc5_.GetTime) * 1000));
                  _loc7_ = _loc7_.split("%when%").join(_loc8_);
               }
               if(Boolean(_loc5_.PlayerNick) && _loc5_.PlayerNick != "")
               {
                  _loc7_ = _loc7_.split("%who%").join(_loc5_.PlayerNick);
               }
               if(_loc5_.Inventory)
               {
                  _loc9_ = _loc5_.Inventory.Name + "*" + _loc5_.Inventory.Quantity;
                  _loc7_ = _loc7_.split("%what%").join(_loc9_);
               }
               FMC_Scene.MC_News["TF_Log" + _loc1_].text = _loc7_;
            }
            else
            {
               FMC_Scene.MC_News["TF_Log" + _loc1_].text = "";
            }
            _loc1_++;
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorPageOnChange_LuckyPlayer(param1:Object, param2:int) : void
      {
         this.FCurPage_LuckyPlayer = param2;
         this.UpdateLuckyPlayer();
      }
      
      protected function ProcessorPageOnChange_News(param1:Object, param2:int) : void
      {
         this.FCurPage_News = param2;
         this.UpdateNews();
      }
      
      protected function ProcessorOnStatusUp(param1:MouseEvent) : void
      {
         if(!this.FIsPlaying && !this.FIsPlaying_Rate && this.FLotteryMachine.GiftStatus == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(REQ_TYPE_GHANGE_STATUS);
         }
      }
      
      protected function ProcessorOnSelectUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:TInventory = null;
         if(!this.FIsPlaying && !this.FIsPlaying_Rate)
         {
            this.FSelectIndex = int(String(param1.currentTarget.parent.name).slice(7));
            _loc3_ = this.FLotteryMachine.Items.GetInventoryByIndex(this.FSelectIndex);
            _loc2_ = _loc3_.Name + "*" + _loc3_.Quantity;
            _loc2_ = TUtilityString.Format(this.FLotteryMachine.DescListNew[5],_loc2_);
            this.FUISelectConfirmation.Text = _loc2_;
            this.FUISelectConfirmation.SetCheckBox(false);
            this.FUISelectConfirmation.Visible = true;
         }
      }
      
      protected function SelectOnOK(param1:Object = null) : void
      {
         var _loc2_:TInventory = null;
         if(!this.FIsPlaying && !this.FIsPlaying_Rate)
         {
            _loc2_ = this.FLotteryMachine.Items.GetInventoryByIndex(this.FSelectIndex);
            this.FRewardData = new TInventories();
            this.FRewardData.Add(_loc2_);
            this.UpdateItems();
            FMC_Scene.MC_Rate.visible = false;
         }
      }
      
      protected function ProcessorOnCancelUp(param1:MouseEvent) : void
      {
         if(!this.FIsPlaying && !this.FIsPlaying_Rate)
         {
            this.FSelectIndex = -1;
            this.FRewardData = null;
            this.UpdateItems();
         }
      }
      
      protected function ProcessorOnLotteryUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode || this.FIsPlaying || this.FIsPlaying_Rate)
         {
            return;
         }
         this.ProcessorOnGetBoxUp(REQ_TYPE_LOTTERY,this.FSelectIndex + 1);
         if(this.FSelectIndex == -1)
         {
            this.FRewardData = null;
            this.FReward.UpdateUI(this.FRewardData);
         }
         FMC_Scene.MC_Rate.visible = false;
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0, param7:int = 0) : void
      {
         if(this.FBeClicked || this.FIsPlaying)
         {
            return;
         }
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
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = param2;
            if(param5 != "")
            {
               FUIWindowConfirmation.Text = param5;
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
         if(this.FBeClicked || this.FIsPlaying)
         {
            return;
         }
         this.FBeClicked = true;
         _loc6_ = new Vector.<int>();
         _loc6_.push(param2);
         PerformPacket_CS_AllReq(param1,_loc6_);
      }
      
      override protected function ProcessorOnOpenDesc(param1:MouseEvent = null) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FLotteryMachine;
         super.ProcessorOnOpenDesc();
      }
      
      override protected function PerformPacket_CS_LoadLogReq(param1:MouseEvent = null) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FUISelectConfirmation.Load();
            return;
         }
         this.visible = true;
         this.alpha = 1;
         this.FIsOpen = true;
         this.ResetUI();
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
         this.FUISelectConfirmation.Visible = false;
         this.FIsPlaying = false;
         this.FIsPlaying_Rate = false;
         this.FRewardData = null;
         this.FRateIndex = -1;
         this.FSelectIndex = -1;
         this.FCurStep = 0;
         this.FCurStep_Rate = 0;
      }
      
      public function ResetUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < ITEM_COUNT)
         {
            FMC_Scene["MC_Slot" + _loc1_].MC_Movie.visible = false;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < RATE_COUNT)
         {
            FMC_Scene["MC_Time" + _loc1_].filters = [];
            _loc1_++;
         }
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerLotteryMachine.Unstreamize(_loc2_,this.FLotteryMachine,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
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
         _loc2_ = param1.Data;
         _loc2_.readShort();
         if(this.FLotteryMachine)
         {
            this.FLotteryMachine.LotteryCount = _loc2_.readUnsignedInt();
            this.FLotteryMachine.TotalRechargeGold = _loc2_.readUnsignedInt();
            if(this.FIsOpen)
            {
               this.UpdateUI();
            }
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
         ProcessorUnstreamActivityLog(this.FLotteryMachine,_loc2_);
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
         var _loc13_:TBaseBox = null;
         var _loc14_:uint = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:uint = 0;
         var _loc20_:Vector.<uint> = null;
         var _loc21_:Vector.<uint> = null;
         var _loc22_:String = null;
         var _loc23_:int = 0;
         this.FBeClicked = false;
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
            case REQ_TYPE_GHANGE_STATUS:
               this.FLotteryMachine.GiftStatus = TBaseActivity.STATUS_GETED;
               this.FLotteryMachine.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FLotteryMachine.CheckStatus());
               this.UpdateUI();
               break;
            case REQ_TYPE_LOTTERY:
               --this.FLotteryMachine.LotteryCount;
               this.FSelectIndex = _loc2_.readUnsignedInt() - 1;
               this.FRateIndex = _loc2_.readUnsignedInt() - 1;
               this.FTargetIndex = _loc2_.readUnsignedInt() - 1;
               if(this.FSelectIndex != -1)
               {
                  this.FLotteryMachine.GiftStatus = TBaseActivity.STATUS_IS_GOT;
               }
               _loc16_ = int(Math.random() * RANDOM_ROUND) + ADD_ROUND;
               this.FTotalStep = ITEM_COUNT * _loc16_ + this.FTargetIndex + 1;
               this.FCurStep = 0;
               this.PlayItemMovie();
               _loc17_ = int(Math.random() * RANDOM_ROUND_RATE) + ADD_ROUND_RATE;
               this.FTotalStep_Rate = RATE_COUNT * _loc17_ + this.FRateIndex + 1;
               this.FCurStep_Rate = 0;
               this.PlayRateMovie();
               _loc9_ = this.FLotteryMachine.Items.GetInventoryByIndex(this.FTargetIndex);
               _loc22_ = _loc9_.Name + "*" + _loc9_.Quantity;
               this.FFlowStr = TUtilityString.Format(this.FLotteryMachine.DescListNew[4],this.FLotteryMachine.RateList[this.FRateIndex],_loc22_);
         }
      }
      
      public function PlayItemMovie() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         this.FIsPlaying = true;
         if(this.FSelectIndex == -1)
         {
            _loc1_ = 0;
            while(_loc1_ < ITEM_COUNT)
            {
               _loc2_ = FMC_Scene["MC_Slot" + _loc1_];
               if(_loc1_ == this.FCurStep % ITEM_COUNT)
               {
                  _loc2_.filters = [];
                  _loc2_.MC_Movie.visible = true;
               }
               else
               {
                  _loc2_.filters = [TGameUtil.GaryColorFilters];
                  _loc2_.MC_Movie.visible = false;
               }
               _loc1_++;
            }
            ++this.FCurStep;
         }
         else
         {
            this.FIsPlaying = false;
            FMC_Scene["MC_Slot" + this.FSelectIndex].BTN_Cancel.visible = false;
         }
      }
      
      public function ItemMovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:TInventory = null;
         this.FIsPlaying = false;
         this.FSelectIndex = -1;
         _loc3_ = this.FLotteryMachine.Items.GetInventoryByIndex(this.FTargetIndex);
         this.FRewardData = new TInventories();
         this.FRewardData.Add(_loc3_);
         this.UpdateUI();
         ProcessorEffectText(this.FFlowStr);
         this.FFlowStr = "";
      }
      
      public function PlayRateMovie() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         this.FIsPlaying_Rate = true;
         _loc1_ = 0;
         while(_loc1_ < RATE_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Time" + _loc1_];
            if(_loc1_ == this.FCurStep_Rate % RATE_COUNT)
            {
               _loc2_.filters = [];
            }
            else
            {
               _loc2_.filters = [TGameUtil.GaryColorFilters];
            }
            _loc1_++;
         }
         if(this.FFrameCount_Rate % 2 == 0)
         {
            ++this.FCurStep_Rate;
         }
      }
      
      public function RateMovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:TInventory = null;
         this.FIsPlaying_Rate = false;
         if(!this.FIsPlaying && this.FSelectIndex != -1 && this.FFlowStr != "")
         {
            this.FIsPlaying = false;
            FMC_Scene["MC_Slot" + this.FSelectIndex].BTN_Cancel.visible = false;
            this.FSelectIndex = -1;
            this.UpdateUI();
            ProcessorEffectText(this.FFlowStr);
            this.FFlowStr = "";
         }
      }
      
      public function Test() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(5);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"说明1");
         TUtilityString.FlushUTF(_loc3_,"%0倍");
         TUtilityString.FlushUTF(_loc3_,"你获得了%0倍的%1");
         TUtilityString.FlushUTF(_loc3_,"确认是否选定%0作为指定抽奖道具？");
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeInt(-1);
         _loc3_.writeShort(10);
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.writeShort(0);
         _loc3_.writeShort(0);
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

