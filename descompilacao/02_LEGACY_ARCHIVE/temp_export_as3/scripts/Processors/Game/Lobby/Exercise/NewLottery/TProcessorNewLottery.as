package Processors.Game.Lobby.Exercise.NewLottery
{
   import Components.ScrollBar.TScrollBar;
   import Components.Standard.TUITab;
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
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.NewLottery.TNewLottery;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerNewLottery;
   import Logics.Streamization.Exercise.TUnstreamizerNewLotteryExchange;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUINews;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorNewLottery extends TProcessorBaseActivity
   {
      
      protected static const TAB_COUNT:int = 2;
      
      protected static const LIST_COUNT:int = 5;
      
      protected static const BTN_COUNT:int = 3;
      
      protected static const SHOW_COUNT:int = 4;
      
      protected static const TAB_FREE:int = TNewLottery.TAB_FREE;
      
      protected static const TAB_GOLD:int = TNewLottery.TAB_GOLD;
      
      protected static const MIN_SCROLL_HEIGHT:Number = 18;
      
      protected static const ITEM_STAMP:Number = 0;
      
      protected static const SINGLE_ITEM_STAMP:Number = 18;
      
      protected static const OUT_COUNT:int = 20;
      
      protected static const MIDDLE_COUNT:int = 14;
      
      protected static const INSIDE_COUNT:int = 8;
      
      protected static const ROTATE_MOVIE:int = 1;
      
      protected static const SHINE_MOVIE:int = 2;
      
      protected static const BAR_MOVIE:int = 3;
      
      protected static const GET_MOVIE:int = 4;
      
      public static const FREE_LOTTERY_REQ:int = 1;
      
      public static const GET_FREE_BOX_REQ:int = 2;
      
      public static const GOLD_LOTTERY_REQ:int = 3;
      
      public static const GET_GOLD_BOX_REQ:int = 4;
      
      public static const EXCHANGE_REQ:int = 5;
      
      protected static const ROUND_OUT:int = 0;
      
      protected static const ROUND_MIDDLE:int = 1;
      
      protected static const ROUND_INSIDE:int = 2;
      
      protected static const ADD_ROUND:int = 1;
      
      protected static const RANDOM_ROUND:int = 1;
      
      protected static const SHINE_COUNT:int = 20;
      
      protected static const EffectMulti_DelayTicks:int = 2000;
      
      protected static const SHINE_DELAY_TIME:int = 5;
      
      protected static const LOTTERY_ONE_COUNT:int = 1;
      
      protected static const LOTTERY_TEN_COUNT:int = 10;
      
      protected static const LOTTERY_FIFTY_COUNT:int = 50;
      
      protected static const LOTTERY_TYPE_ONE:int = 1;
      
      protected static const LOTTERY_TYPE_TEN:int = 2;
      
      protected static const LOTTERY_TYPE_FIFTY:int = 3;
      
      protected var FNewLottery:TNewLottery;
      
      protected var FUnstreamizerNewLottery:TUnstreamizerNewLottery;
      
      protected var FUnstreamizerNewLotteryExchange:TUnstreamizerNewLotteryExchange;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorNewLotteryExchange:TProcessorNewLotteryExchange;
      
      protected var FUINews:TUINews;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FIsCD:Boolean;
      
      protected var FCost:int;
      
      protected var FBuyBoxDate:Object;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FUITab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      protected var FTF_CDTime:TextField;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FOutItems:TUIBaseBox;
      
      protected var FMiddleItems:TUIBaseBox;
      
      protected var FInsideItems:TUIBaseBox;
      
      protected var FTargetIndex:int;
      
      protected var FCurIndex:int;
      
      protected var FTargetStep:int;
      
      protected var FCurStep:int;
      
      protected var FShineIndex:int;
      
      protected var FShineType:int;
      
      protected var FShineTime:int;
      
      protected var FMovieType:int;
      
      protected var FLotteryType:int;
      
      protected var FIsEndPushText:Boolean;
      
      protected var FEffectTexts:Vector.<String>;
      
      protected var FEffDelayReferenceTick:int;
      
      protected var FStringID:int;
      
      protected var FSystemLanguage:TSystemLanguage;
      
      protected var FRound:int;
      
      protected var FTimeid:int;
      
      public function TProcessorNewLottery(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FNewLottery = SLogicsCore.NewLottery;
         this.FUnstreamizerNewLottery = new TUnstreamizerNewLottery();
         this.FUnstreamizerNewLotteryExchange = new TUnstreamizerNewLotteryExchange();
         this.FUITab = new TUITab(this);
         this.FChangeTabIndex = 0;
         this.FBuyBoxDate = new Object();
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorNewLotteryExchange = new TProcessorNewLotteryExchange(this.Parent);
         this.FEffectTexts = new Vector.<String>();
         this.FOutItems = new TUIBaseBox(this,OUT_COUNT);
         this.FMiddleItems = new TUIBaseBox(this,MIDDLE_COUNT);
         this.FInsideItems = new TUIBaseBox(this,INSIDE_COUNT);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            this.FUITab.SetTabByIndex(FMC_Scene["BTN_Tab" + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.ChangeTabOnSwitch;
         this.FUITab.Init();
         this.FTF_CDTime = FMC_Scene.MC_FreeBtn.MC_LotteryTime.TF_Time;
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FProcessorNewLotteryExchange.OnCloseUp = this.ProcessorOnExchangeCloseUp;
         this.FProcessorNewLotteryExchange.OnExchange = this.ProcessorOnGetBoxUp;
         this.FProcessorNewLotteryExchange.DownHintOnOver = UIComponentsHintOnOver;
         this.FProcessorNewLotteryExchange.DownHintOnOut = UIComponentsHintOnOut;
         this.FProcessorNewLotteryExchange.TipOnOver = ProcessorTipOnOver;
         this.FProcessorNewLotteryExchange.TipOnOut = ProcessorTipOnOut;
         this.FProcessorNewLotteryExchange.OnShowRecruit = this.ProcessorOnShowHero;
         this.FProcessorNewLotteryExchange.Visible = false;
         this.FUINews = new TUINews(this);
         this.FUINews.Perform_UIDispatch(FMC_Scene["MC_List"]);
         this.FUINews.OnOverlay = UIComponentsHintOnOver;
         this.FUINews.OnOut = UIComponentsHintOnOut;
         this.FUINews.OnShowHeroInfo = ProcessorOnShowHeroInfo;
         this.FOutItems.Perform_UIDispatch(FMC_Scene["MC_OutItems"]);
         this.FOutItems.OnOverlay = UIComponentsHintOnOver;
         this.FOutItems.OnOut = UIComponentsHintOnOut;
         this.FMiddleItems.Perform_UIDispatch(FMC_Scene["MC_MiddleItems"]);
         this.FMiddleItems.OnOverlay = UIComponentsHintOnOver;
         this.FMiddleItems.OnOut = UIComponentsHintOnOut;
         this.FInsideItems.Perform_UIDispatch(FMC_Scene["MC_InsideItems"]);
         this.FInsideItems.OnOverlay = UIComponentsHintOnOver;
         this.FInsideItems.OnOut = UIComponentsHintOnOut;
         this.FMC_Mask = FMC_Scene.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
         TweenUtil.to(this.FMC_Mask,1000,{"width":0});
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         super.ResourcesPerform_UILocations();
         TGameUtil.setButtonMode(FMC_Scene.Btn_Exchange,true);
         FMC_Scene.Btn_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         FMC_Scene.MC_Box.buttonMode = true;
         FMC_Scene.MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnBigBoxUp);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBigBoxOver);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         _loc1_ = 0;
         while(_loc1_ < BTN_COUNT)
         {
            _loc3_ = FMC_Scene.MC_FreeBtn["BTN_Lottery" + _loc1_];
            TGameUtil.setButtonMode(_loc3_,true);
            _loc3_.addEventListener(MouseEvent.CLICK,this.ProcessorOnLotteryUp);
            _loc3_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnLotteryOver);
            _loc3_.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < BTN_COUNT)
         {
            _loc3_ = FMC_Scene.MC_GoldBtn["BTN_Lottery" + _loc1_];
            TGameUtil.setButtonMode(_loc3_,true);
            _loc3_.addEventListener(MouseEvent.CLICK,this.ProcessorOnLotteryUp);
            _loc3_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnLotteryOver);
            _loc3_.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < SHOW_COUNT)
         {
            _loc3_ = FMC_Scene["Btn_ShowRecruit" + _loc1_];
            TGameUtil.setButtonMode(_loc3_,true);
            _loc3_.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowRecruit);
            _loc1_++;
         }
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            _loc1_ = this.FNewLottery.NextTime - STimingCore.GetServerTick();
            this.FTF_CDTime.text = TGameUtil.fomatTime(_loc1_);
            if(_loc1_ <= 0 && this.FIsCD || _loc1_ > 0 && !this.FIsCD)
            {
               this.FIsCD = _loc1_ <= 0 ? false : true;
               this.UpdateBtns();
            }
            if(Boolean(this.FProcessorWindowRecruit) && this.FProcessorWindowRecruit.Visible)
            {
               this.FProcessorWindowRecruit.UpdataBitmap();
            }
            this.FOutItems.LogicsPerform();
            this.FMiddleItems.LogicsPerform();
            this.FInsideItems.LogicsPerform();
            if(this.FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case ROTATE_MOVIE:
                     this.PlayMovie(ROTATE_MOVIE);
                     break;
                  case SHINE_MOVIE:
                     this.PlayMovie(SHINE_MOVIE);
               }
            }
            this.LogicsPerform_EffectText();
         }
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseActivity = null;
         this.UpdateGoldPool();
         this.UpdateBtns();
         this.UpdateHeroList();
         this.UpdateNews();
         this.UpdateBar();
         this.UpdateItems();
         this.UpdateText();
         if(this.FProcessorNewLotteryExchange.Visible)
         {
            this.FProcessorNewLotteryExchange.UpdateUI();
         }
      }
      
      protected function UpdateGoldPool() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         FMC_Scene.MC_LuckyPool.TF_Gold.text = this.FNewLottery.PoolGold.toString();
         _loc2_ = int(this.FNewLottery.LuckyList.length);
         _loc1_ = 0;
         while(_loc1_ < LIST_COUNT)
         {
            _loc3_ = FMC_Scene.MC_LuckyPool["MC_Log" + _loc1_];
            if(_loc1_ < _loc2_)
            {
               _loc3_.visible = true;
               _loc3_.TF_Name.text = this.FNewLottery.LuckyList[_loc1_].name;
               _loc3_.TF_Server.text = this.FNewLottery.LuckyList[_loc1_].server;
               _loc3_.TF_Gold.text = this.FNewLottery.LuckyList[_loc1_].gold.toString();
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBtns() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         _loc4_ = this.FNewLottery.GetCurRound(this.FChangeTabIndex);
         if(this.FChangeTabIndex == TAB_FREE)
         {
            FMC_Scene.MC_FreeBtn.visible = true;
            FMC_Scene.MC_GoldBtn.visible = false;
            FMC_Scene.MC_FreeBtn.MC_LotteryTime.visible = this.FIsCD;
            _loc1_ = 0;
            while(_loc1_ < BTN_COUNT)
            {
               _loc3_ = FMC_Scene.MC_FreeBtn["BTN_Lottery" + _loc1_];
               if(_loc1_ <= _loc4_)
               {
                  TGameUtil.setButtonMode(_loc3_,true);
               }
               else
               {
                  TGameUtil.setButtonMode(_loc3_,false);
               }
               _loc1_++;
            }
         }
         else
         {
            FMC_Scene.MC_FreeBtn.visible = false;
            FMC_Scene.MC_GoldBtn.visible = true;
            if(_loc4_ == ROUND_OUT)
            {
               TGameUtil.setButtonMode(FMC_Scene.MC_GoldBtn.BTN_Lottery0,true);
               TGameUtil.setButtonMode(FMC_Scene.MC_GoldBtn.BTN_Lottery1,true);
               TGameUtil.setButtonMode(FMC_Scene.MC_GoldBtn.BTN_Lottery2,true);
            }
            else if(_loc4_ == ROUND_MIDDLE)
            {
               TGameUtil.setButtonMode(FMC_Scene.MC_GoldBtn.BTN_Lottery0,true);
               TGameUtil.setButtonMode(FMC_Scene.MC_GoldBtn.BTN_Lottery1,true);
               TGameUtil.setButtonMode(FMC_Scene.MC_GoldBtn.BTN_Lottery2,false);
            }
            else if(_loc4_ == ROUND_INSIDE)
            {
               TGameUtil.setButtonMode(FMC_Scene.MC_GoldBtn.BTN_Lottery0,true);
               TGameUtil.setButtonMode(FMC_Scene.MC_GoldBtn.BTN_Lottery1,false);
               TGameUtil.setButtonMode(FMC_Scene.MC_GoldBtn.BTN_Lottery2,false);
            }
         }
      }
      
      protected function UpdateHeroList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < SHOW_COUNT)
         {
            _loc2_ = FMC_Scene["Btn_ShowRecruit" + _loc1_];
            if(_loc1_ < this.FNewLottery.HeroList.length)
            {
               _loc2_.MC_Icon.gotoAndStop("ID" + this.FNewLottery.HeroList[_loc1_]);
            }
            else
            {
               _loc2_.MC_Icon.gotoAndStop("ID0");
            }
            _loc1_++;
         }
      }
      
      protected function UpdateNews() : void
      {
         this.FUINews.NewsDate = this.FNewLottery.NewsList;
         this.FUINews.UpdateUI();
      }
      
      protected function UpdateBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBaseBox = null;
         if(this.FChangeTabIndex == TAB_FREE)
         {
            _loc4_ = this.FNewLottery.FreeBox;
            _loc3_ = this.FNewLottery.FreeBar[this.FNewLottery.FreeBar.length - 1];
            _loc1_ = Number(this.FNewLottery.FreeExp / _loc3_) * this.FBarMaxWidth;
            FMC_Scene.MC_Arrow0.TF_Count.text = TUtilityString.Format(this.FNewLottery.DescListNew[1],this.FNewLottery.FreeBar[0]);
            FMC_Scene.MC_Arrow1.TF_Count.text = TUtilityString.Format(this.FNewLottery.DescListNew[2],this.FNewLottery.FreeBar[1]);
            FMC_Scene.TF_Process.text = this.FNewLottery.FreeExp + "/" + _loc3_;
         }
         else
         {
            _loc4_ = this.FNewLottery.GoldBox;
            _loc3_ = this.FNewLottery.GoldBar[this.FNewLottery.GoldBar.length - 1];
            _loc1_ = Number(this.FNewLottery.GoldExp / _loc3_) * this.FBarMaxWidth;
            FMC_Scene.MC_Arrow0.TF_Count.text = TUtilityString.Format(this.FNewLottery.DescListNew[1],this.FNewLottery.GoldBar[0]);
            FMC_Scene.MC_Arrow1.TF_Count.text = TUtilityString.Format(this.FNewLottery.DescListNew[2],this.FNewLottery.GoldBar[1]);
            FMC_Scene.TF_Process.text = this.FNewLottery.GoldExp + "/" + _loc3_;
         }
         _loc2_ = Math.min(_loc1_,this.FBarMaxWidth);
         TweenUtil.to(this.FMC_Mask,1000,{"width":_loc2_});
         FMC_Scene.TF_BoxDesc.text = TUtilityString.Format(this.FNewLottery.DescListNew[3],_loc3_);
         if(_loc4_.Count > 0)
         {
            FMC_Scene.MC_Box.MC_Click.visible = true;
            FMC_Scene.MC_Box.MC_Icon.gotoAndPlay(1);
            FMC_Scene.TF_BoxCount.text = "*" + _loc4_.Count;
         }
         else
         {
            FMC_Scene.MC_Box.MC_Click.visible = false;
            FMC_Scene.MC_Box.MC_Icon.gotoAndStop(1);
            FMC_Scene.TF_BoxCount.text = "";
         }
      }
      
      protected function UpdateItems() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this.FNewLottery.GetCurRound(this.FChangeTabIndex);
         if(this.FChangeTabIndex == TAB_FREE)
         {
            this.FOutItems.UpdateUI(this.FNewLottery.FreeOut.Inventories);
            this.FMiddleItems.UpdateUI(this.FNewLottery.FreeMiddle.Inventories);
            this.FInsideItems.UpdateUI(this.FNewLottery.FreeInside.Inventories);
            this.FOutItems.SetFire(this.FNewLottery.FreeOut.ExchangeVect);
            this.FMiddleItems.SetFire(this.FNewLottery.FreeMiddle.ExchangeVect);
            this.FInsideItems.SetFire(this.FNewLottery.FreeInside.ExchangeVect);
            if(_loc1_ == 0)
            {
               this.FOutItems.SetGaryFilters(false);
               this.FMiddleItems.SetGaryFilters(true);
               this.FInsideItems.SetGaryFilters(true);
            }
            else if(_loc1_ == 1)
            {
               this.FOutItems.SetGaryFilters(false);
               this.FMiddleItems.SetGaryFilters(false);
               this.FInsideItems.SetGaryFilters(true);
            }
            else if(_loc1_ == 2)
            {
               this.FOutItems.SetGaryFilters(false);
               this.FMiddleItems.SetGaryFilters(false);
               this.FInsideItems.SetGaryFilters(false);
            }
         }
         else
         {
            this.FOutItems.UpdateUI(this.FNewLottery.GoldOut.Inventories);
            this.FMiddleItems.UpdateUI(this.FNewLottery.GoldMiddle.Inventories);
            this.FInsideItems.UpdateUI(this.FNewLottery.GoldInside.Inventories);
            this.FOutItems.SetFire(this.FNewLottery.GoldOut.ExchangeVect);
            this.FMiddleItems.SetFire(this.FNewLottery.GoldMiddle.ExchangeVect);
            this.FInsideItems.SetFire(this.FNewLottery.GoldInside.ExchangeVect);
            if(_loc1_ == 0)
            {
               this.FOutItems.SetGaryFilters(false);
               this.FMiddleItems.SetGaryFilters(true);
               this.FInsideItems.SetGaryFilters(true);
            }
            else if(_loc1_ == 1)
            {
               this.FOutItems.SetGaryFilters(true);
               this.FMiddleItems.SetGaryFilters(false);
               this.FInsideItems.SetGaryFilters(true);
            }
            else if(_loc1_ == 2)
            {
               this.FOutItems.SetGaryFilters(true);
               this.FMiddleItems.SetGaryFilters(true);
               this.FInsideItems.SetGaryFilters(false);
            }
         }
         this.FOutItems.SetSelected(false,0);
         this.FMiddleItems.SetSelected(false,0);
         this.FInsideItems.SetSelected(false,0);
         this.FOutItems.SetGetCount();
         this.FMiddleItems.SetGetCount();
         this.FInsideItems.SetGetCount();
         this.FCurIndex = 0;
         this.FCurStep = 0;
         this.FShineIndex = 0;
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FNewLottery.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FNewLottery.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FNewLottery.DescListNew[7];
         FMC_Scene.TF_Score.text = this.FNewLottery.Score.toString();
      }
      
      protected function ProcessorOnLotteryUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!param1.currentTarget.buttonMode || this.FIsPlaying)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.name).slice(11));
         this.FRound = this.FNewLottery.GetCurRound(this.FChangeTabIndex);
         _loc4_ = TBaseActivity.SWEET_TYPE_GOLD;
         if(this.FChangeTabIndex == TAB_FREE)
         {
            if(_loc2_ == ROUND_OUT)
            {
               _loc3_ = 0;
               _loc4_ = TBaseActivity.SWEET_TYPE_FREE;
            }
            else if(_loc2_ == ROUND_MIDDLE)
            {
               _loc3_ = this.FNewLottery.FreeMiddle.Price;
            }
            else
            {
               _loc3_ = this.FNewLottery.FreeInside.Price;
            }
            this.ProcessorOnBuyBoxUp(FREE_LOTTERY_REQ,_loc3_,_loc2_ + 1,_loc4_);
         }
         else
         {
            if(_loc2_ == LOTTERY_TYPE_ONE - 1)
            {
               _loc3_ = this.FNewLottery.GoldOut.Price;
            }
            else if(_loc2_ == LOTTERY_TYPE_TEN - 1)
            {
               _loc3_ = this.FNewLottery.GoldMiddle.Price;
            }
            else
            {
               _loc3_ = this.FNewLottery.GoldInside.Price;
            }
            this.ProcessorOnBuyBoxUp(GOLD_LOTTERY_REQ,_loc3_,_loc2_ + 1,_loc4_);
         }
      }
      
      protected function ProcessorOnLotteryOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = int(String(param1.currentTarget.name).slice(11));
         _loc4_ = this.FNewLottery.GetCurRound(this.FChangeTabIndex);
         if(this.FChangeTabIndex == TAB_FREE)
         {
            if(_loc3_ == ROUND_OUT)
            {
               _loc2_ = TUtilityString.Format(this.FNewLottery.DescListNew[6],this.FNewLottery.FreeOut.Level,this.FNewLottery.FreeOut.BuyCount);
            }
            else if(_loc3_ == ROUND_MIDDLE)
            {
               _loc2_ = TUtilityString.Format(this.FNewLottery.DescListNew[5],this.FNewLottery.FreeMiddle.Price,this.FNewLottery.FreeMiddle.Level,this.FNewLottery.FreeMiddle.BuyCount);
            }
            else
            {
               _loc2_ = TUtilityString.Format(this.FNewLottery.DescListNew[5],this.FNewLottery.FreeInside.Price,this.FNewLottery.FreeInside.Level,this.FNewLottery.FreeInside.BuyCount);
            }
         }
         else if(_loc3_ == LOTTERY_TYPE_ONE - 1)
         {
            if(_loc4_ == ROUND_OUT)
            {
               _loc2_ = TUtilityString.Format(this.FNewLottery.DescListNew[5],this.FNewLottery.GoldOut.Price,this.FNewLottery.GoldOut.Level,this.FNewLottery.GoldOut.BuyCount);
            }
            else if(_loc4_ == ROUND_MIDDLE)
            {
               _loc2_ = TUtilityString.Format(this.FNewLottery.DescListNew[5],this.FNewLottery.GoldMiddle.Price,this.FNewLottery.GoldMiddle.Level,this.FNewLottery.GoldMiddle.BuyCount);
            }
            else
            {
               _loc2_ = TUtilityString.Format(this.FNewLottery.DescListNew[5],this.FNewLottery.GoldInside.Price,this.FNewLottery.GoldInside.Level,this.FNewLottery.GoldInside.BuyCount);
            }
         }
         else if(_loc3_ == LOTTERY_TYPE_TEN - 1)
         {
            if(_loc4_ == ROUND_OUT)
            {
               _loc2_ = TUtilityString.Format(this.FNewLottery.DescListNew[5],this.FNewLottery.GoldOut.Price,this.FNewLottery.GoldOut.Level * LOTTERY_TEN_COUNT,this.FNewLottery.GoldOut.BuyCount);
            }
            else
            {
               if(_loc4_ != ROUND_MIDDLE)
               {
                  return;
               }
               _loc2_ = TUtilityString.Format(this.FNewLottery.DescListNew[5],this.FNewLottery.GoldMiddle.Price,this.FNewLottery.GoldMiddle.Level * LOTTERY_TEN_COUNT,this.FNewLottery.GoldMiddle.BuyCount);
            }
         }
         else
         {
            if(_loc4_ != ROUND_OUT)
            {
               return;
            }
            _loc2_ = TUtilityString.Format(this.FNewLottery.DescListNew[5],this.FNewLottery.GoldOut.Price,this.FNewLottery.GoldOut.Level * LOTTERY_FIFTY_COUNT,this.FNewLottery.GoldOut.BuyCount);
         }
         ProcessorOnShowHtmlText(_loc2_);
      }
      
      protected function ProcessorOnBigBoxUp(param1:MouseEvent) : void
      {
         if(this.FChangeTabIndex == TAB_FREE)
         {
            if(Boolean(this.FNewLottery) && Boolean(this.FNewLottery.FreeBox) && this.FNewLottery.FreeBox.Count > 0)
            {
               this.ProcessorOnGetBoxUp(GET_FREE_BOX_REQ);
            }
         }
         else if(Boolean(this.FNewLottery) && Boolean(this.FNewLottery.GoldBox) && this.FNewLottery.GoldBox.Count > 0)
         {
            this.ProcessorOnGetBoxUp(GET_GOLD_BOX_REQ);
         }
      }
      
      protected function ProcessorOnBigBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventories = null;
         if(this.FChangeTabIndex == TAB_FREE)
         {
            if(Boolean(this.FNewLottery) && Boolean(this.FNewLottery.FreeBox))
            {
               ProcessorOnNewBoxOver(this.FNewLottery.FreeBox.Inventories);
            }
         }
         else if(Boolean(this.FNewLottery) && Boolean(this.FNewLottery.GoldBox))
         {
            ProcessorOnNewBoxOver(this.FNewLottery.GoldBox.Inventories,this.FNewLottery.DescListNew[4]);
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(15));
         if(_loc2_ < this.FNewLottery.HeroList.length)
         {
            this.FProcessorWindowRecruit.SetHeroData(this.FNewLottery.HeroList[_loc2_]);
         }
      }
      
      protected function ProcessorOnShowHero(param1:int) : void
      {
         this.FProcessorWindowRecruit.SetHeroData(param1);
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.PerformPacket_CS_LoadExchangeItemReq();
      }
      
      protected function ProcessorOnExchangeCloseUp(param1:MouseEvent) : void
      {
         this.FProcessorNewLotteryExchange.Visible = false;
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         if(_loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         this.FIsPlaying = false;
         this.UpdateUI();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function PerformPacket_CS_LoadExchangeItemReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HappyTreasure_LoadInfoReq);
         _loc1_.Data.writeUnsignedInt(FActivityID);
         _loc1_.Data.writeUnsignedInt(2);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 1) : void
      {
         this.FBuyBoxDate.BoxType = param1;
         this.FBuyBoxDate.BoxIndex = param3;
         this.FBuyBoxDate.Cost = param2;
         this.FBuyBoxDate.CostType = param4;
         this.FBuyBoxDate.BuyCount = param6;
         if(param4 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BuyCount);
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
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BuyCount);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int = 0, param3:int = 1) : void
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
         if(param3 > 0)
         {
            _loc6_.push(param3);
         }
         PerformPacket_CS_AllReq(param1,_loc6_);
      }
      
      override protected function PerformPacket_CS_LoadLogReq(param1:MouseEvent = null) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(0);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRecruit.Load();
            this.FProcessorNewLotteryExchange.Load();
            return;
         }
         this.visible = true;
         this.alpha = 1;
         this.FIsPlaying = false;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
         TweenUtil.removeAllTween();
         clearTimeout(this.FTimeid);
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
         this.FUnstreamizerNewLottery.Unstreamize(_loc2_,this.FNewLottery,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorOnLoadExchangeItemRet(param1:TPacket = null) : void
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
         this.FUnstreamizerNewLotteryExchange.Unstreamize(_loc2_,this.FNewLottery.ExchangeItems,null);
         if(FIsResourcesLoadCompleted && FMC_Scene.visible)
         {
            this.FProcessorNewLotteryExchange.Visible = true;
            this.FProcessorNewLotteryExchange.UpdateUI();
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
         ProcessorUnstreamActivityLog(this.FNewLottery,_loc2_);
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         _loc3_ = _loc2_.readInt();
         var _loc4_:int = _loc3_;
         switch(0)
         {
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
         var _loc13_:uint = 0;
         var _loc14_:int = 0;
         var _loc15_:uint = 0;
         var _loc16_:TBaseBox = null;
         var _loc17_:TBins = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
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
            case FREE_LOTTERY_REQ:
               this.FRound = _loc2_.readUnsignedInt() - 1;
               this.FNewLottery.NextTime = _loc2_.readUnsignedInt();
               this.FTargetIndex = _loc2_.readUnsignedInt() - 1;
               this.FNewLottery.FreeBox.Count = _loc2_.readUnsignedInt();
               this.FNewLottery.FreeExp = _loc2_.readUnsignedInt();
               this.FNewLottery.Score = _loc2_.readUnsignedInt();
               this.FNewLottery.PoolGold = _loc2_.readUnsignedInt();
               if(this.FRound == ROUND_OUT)
               {
                  _loc23_ = OUT_COUNT;
               }
               else if(this.FRound == ROUND_MIDDLE)
               {
                  _loc23_ = MIDDLE_COUNT;
               }
               else
               {
                  _loc23_ = INSIDE_COUNT;
               }
               this.FIsPlaying = true;
               _loc22_ = int(Math.random() * RANDOM_ROUND) + ADD_ROUND;
               this.FTargetStep = _loc23_ * _loc22_ + this.FTargetIndex;
               this.PlayMovie(ROTATE_MOVIE);
               break;
            case GOLD_LOTTERY_REQ:
               this.FLotteryType = _loc2_.readUnsignedInt();
               this.FRound = _loc2_.readUnsignedInt() - 1;
               this.FNewLottery.GoldBox.Count = _loc2_.readUnsignedInt();
               this.FNewLottery.GoldExp = _loc2_.readUnsignedInt();
               this.FNewLottery.Score = _loc2_.readUnsignedInt();
               this.FNewLottery.PoolGold = _loc2_.readUnsignedInt();
               if(this.FRound == ROUND_OUT)
               {
                  if(this.FLotteryType == LOTTERY_TYPE_ONE)
                  {
                     this.FTargetIndex = _loc2_.readUnsignedInt() - 1;
                     _loc23_ = OUT_COUNT;
                     this.FIsPlaying = true;
                     _loc22_ = int(Math.random() * RANDOM_ROUND) + ADD_ROUND;
                     this.FTargetStep = _loc23_ * _loc22_ + this.FTargetIndex;
                     this.PlayMovie(ROTATE_MOVIE);
                  }
                  else if(this.FLotteryType == LOTTERY_TYPE_TEN)
                  {
                     this.FNewLottery.GetIndexList.length = 0;
                     _loc5_ = 0;
                     while(_loc5_ < LOTTERY_TEN_COUNT)
                     {
                        this.FNewLottery.GetIndexList.push(_loc2_.readUnsignedInt() - 1);
                        _loc5_++;
                     }
                     this.FIsPlaying = true;
                     this.PlayMovie(SHINE_MOVIE);
                  }
                  else
                  {
                     this.FNewLottery.GetIndexList.length = 0;
                     _loc5_ = 0;
                     while(_loc5_ < LOTTERY_FIFTY_COUNT)
                     {
                        this.FNewLottery.GetIndexList.push(_loc2_.readUnsignedInt() - 1);
                        _loc5_++;
                     }
                     this.FIsPlaying = true;
                     this.PlayMovie(SHINE_MOVIE);
                  }
               }
               else if(this.FRound == ROUND_MIDDLE)
               {
                  if(this.FLotteryType == LOTTERY_TYPE_ONE)
                  {
                     this.FTargetIndex = _loc2_.readUnsignedInt() - 1;
                     _loc23_ = MIDDLE_COUNT;
                     this.FIsPlaying = true;
                     _loc22_ = int(Math.random() * RANDOM_ROUND) + ADD_ROUND;
                     this.FTargetStep = _loc23_ * _loc22_ + this.FTargetIndex;
                     this.PlayMovie(ROTATE_MOVIE);
                  }
                  else if(this.FLotteryType == LOTTERY_TYPE_TEN)
                  {
                     this.FNewLottery.GetIndexList.length = 0;
                     _loc5_ = 0;
                     while(_loc5_ < LOTTERY_TEN_COUNT)
                     {
                        this.FNewLottery.GetIndexList.push(_loc2_.readUnsignedInt() - 1);
                        _loc5_++;
                     }
                     this.FIsPlaying = true;
                     this.PlayMovie(SHINE_MOVIE);
                  }
               }
               else if(this.FLotteryType == LOTTERY_TYPE_ONE)
               {
                  this.FTargetIndex = _loc2_.readUnsignedInt() - 1;
                  _loc23_ = INSIDE_COUNT;
                  this.FIsPlaying = true;
                  _loc22_ = int(Math.random() * RANDOM_ROUND) + ADD_ROUND;
                  this.FTargetStep = _loc23_ * _loc22_ + this.FTargetIndex;
                  this.PlayMovie(ROTATE_MOVIE);
               }
               break;
            case GET_FREE_BOX_REQ:
               --this.FNewLottery.FreeBox.Count;
               _loc11_ = _loc2_.readUnsignedInt();
               _loc12_ = _loc2_.readUnsignedInt();
               _loc15_ = _loc2_.readUnsignedInt();
               _loc4_ = STRING_COMMON.GetItemNameByType(_loc11_,_loc12_) + "*" + _loc15_;
               this.FEffectTexts.push(_loc4_);
               this.FIsEndPushText = true;
               this.UpdateUI();
               break;
            case GET_GOLD_BOX_REQ:
               --this.FNewLottery.GoldBox.Count;
               _loc11_ = _loc2_.readUnsignedInt();
               _loc12_ = _loc2_.readUnsignedInt();
               _loc15_ = _loc2_.readUnsignedInt();
               _loc4_ = STRING_COMMON.GetItemNameByType(_loc11_,_loc12_) + "*" + _loc15_;
               this.FEffectTexts.push(_loc4_);
               this.FIsEndPushText = true;
               this.UpdateUI();
               break;
            case EXCHANGE_REQ:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FNewLottery.ExchangeItems[_loc5_].IsOwn = _loc2_.readUnsignedInt();
               ++this.FNewLottery.ExchangeItems[_loc5_].BuyCount;
               this.FNewLottery.Score -= this.FNewLottery.ExchangeItems[_loc5_].CostPoint;
               _loc9_ = this.FNewLottery.ExchangeItems[_loc5_].Inventories.GetInventoryByIndex(0);
               _loc4_ = _loc9_.Name + "*" + _loc9_.Quantity;
               this.FEffectTexts.push(_loc4_);
               this.FIsEndPushText = true;
               this.UpdateUI();
         }
      }
      
      public function PlayMovie(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:TInventory = null;
         var _loc7_:int = 0;
         this.FMovieType = param1;
         switch(this.FMovieType)
         {
            case ROTATE_MOVIE:
               if(this.FRound == ROUND_OUT)
               {
                  _loc4_ = OUT_COUNT;
                  this.FOutItems.SetSelected(false,this.FCurIndex);
               }
               else if(this.FRound == ROUND_MIDDLE)
               {
                  _loc4_ = MIDDLE_COUNT;
                  this.FMiddleItems.SetSelected(false,this.FCurIndex);
               }
               else if(this.FRound == ROUND_INSIDE)
               {
                  _loc4_ = INSIDE_COUNT;
                  this.FInsideItems.SetSelected(false,this.FCurIndex);
               }
               if(this.FCurStep == this.FTargetStep)
               {
                  this.MovieEnd();
               }
               else
               {
                  ++this.FCurStep;
                  this.FCurIndex = this.FCurIndex < _loc4_ - 1 ? int(this.FCurIndex + 1) : 0;
               }
               break;
            case SHINE_MOVIE:
               if(this.FShineIndex < SHINE_COUNT)
               {
                  ++this.FShineTime;
                  if(this.FShineTime >= SHINE_DELAY_TIME)
                  {
                     ++this.FShineIndex;
                     this.FShineType = this.FShineType == 0 ? 1 : 0;
                     if(this.FRound == ROUND_OUT)
                     {
                        this.FOutItems.SetBoxShine(this.FShineType);
                     }
                     if(this.FRound == ROUND_MIDDLE)
                     {
                        this.FMiddleItems.SetBoxShine(this.FShineType);
                     }
                     else if(this.FRound == ROUND_INSIDE)
                     {
                        this.FInsideItems.SetBoxShine(this.FShineType);
                     }
                     this.FShineTime = 0;
                  }
               }
               else
               {
                  this.MovieEnd();
               }
               break;
            case BAR_MOVIE:
               break;
            case GET_MOVIE:
               this.FTimeid = setTimeout(this.MovieEnd,2000);
               if(this.FChangeTabIndex == TAB_FREE)
               {
                  if(this.FRound == ROUND_OUT)
                  {
                     this.FOutItems.SetGetCount(false,this.FTargetIndex,1);
                     _loc6_ = this.FNewLottery.FreeOut.Inventories.GetInventoryByIndex(this.FTargetIndex);
                  }
                  else if(this.FRound == ROUND_MIDDLE)
                  {
                     this.FMiddleItems.SetGetCount(false,this.FTargetIndex,1);
                     _loc6_ = this.FNewLottery.FreeMiddle.Inventories.GetInventoryByIndex(this.FTargetIndex);
                  }
                  else if(this.FRound == ROUND_INSIDE)
                  {
                     this.FInsideItems.SetGetCount(false,this.FTargetIndex,1);
                     _loc6_ = this.FNewLottery.FreeInside.Inventories.GetInventoryByIndex(this.FTargetIndex);
                  }
                  _loc5_ = _loc6_.Name + "*" + _loc6_.Quantity;
                  this.FEffectTexts.push(_loc5_);
                  this.FIsEndPushText = true;
               }
               else if(this.FRound == ROUND_OUT)
               {
                  switch(this.FLotteryType)
                  {
                     case LOTTERY_TYPE_ONE:
                        this.FOutItems.SetGetCount(false,this.FTargetIndex,1);
                        _loc6_ = this.FNewLottery.GoldOut.Inventories.GetInventoryByIndex(this.FTargetIndex);
                        _loc5_ = _loc6_.Name + "*" + _loc6_.Quantity;
                        this.FEffectTexts.push(_loc5_);
                        this.FIsEndPushText = true;
                        break;
                     case LOTTERY_TYPE_TEN:
                     case LOTTERY_TYPE_FIFTY:
                        this.FOutItems.SetGetCountByList(this.FNewLottery.GetIndexList);
                        _loc2_ = 0;
                        while(_loc2_ < this.FNewLottery.GetIndexList.length)
                        {
                           _loc7_ = this.FNewLottery.GetIndexList[_loc2_];
                           _loc6_ = this.FNewLottery.GoldOut.Inventories.GetInventoryByIndex(_loc7_);
                           _loc5_ = _loc6_.Name + "*" + _loc6_.Quantity;
                           this.FEffectTexts.push(_loc5_);
                           _loc2_++;
                        }
                        this.FIsEndPushText = true;
                  }
               }
               else if(this.FRound == ROUND_MIDDLE)
               {
                  switch(this.FLotteryType)
                  {
                     case LOTTERY_TYPE_ONE:
                        this.FMiddleItems.SetGetCount(false,this.FTargetIndex,1);
                        _loc6_ = this.FNewLottery.GoldMiddle.Inventories.GetInventoryByIndex(this.FTargetIndex);
                        _loc5_ = _loc6_.Name + "*" + _loc6_.Quantity;
                        this.FEffectTexts.push(_loc5_);
                        this.FIsEndPushText = true;
                        break;
                     case LOTTERY_TYPE_TEN:
                        this.FMiddleItems.SetGetCountByList(this.FNewLottery.GetIndexList);
                        _loc2_ = 0;
                        while(_loc2_ < this.FNewLottery.GetIndexList.length)
                        {
                           _loc7_ = this.FNewLottery.GetIndexList[_loc2_];
                           _loc6_ = this.FNewLottery.GoldMiddle.Inventories.GetInventoryByIndex(_loc7_);
                           _loc5_ = _loc6_.Name + "*" + _loc6_.Quantity;
                           this.FEffectTexts.push(_loc5_);
                           _loc2_++;
                        }
                        this.FIsEndPushText = true;
                  }
               }
               else if(this.FRound == ROUND_INSIDE)
               {
                  this.FInsideItems.SetGetCount(false,this.FTargetIndex,1);
                  _loc6_ = this.FNewLottery.GoldInside.Inventories.GetInventoryByIndex(this.FTargetIndex);
                  _loc5_ = _loc6_.Name + "*" + _loc6_.Quantity;
                  this.FEffectTexts.push(_loc5_);
                  this.FIsEndPushText = true;
               }
         }
      }
      
      public function MovieEnd() : void
      {
         switch(this.FMovieType)
         {
            case ROTATE_MOVIE:
               this.FMovieType = GET_MOVIE;
               this.PlayMovie(this.FMovieType);
               break;
            case SHINE_MOVIE:
               this.FMovieType = GET_MOVIE;
               this.PlayMovie(this.FMovieType);
               break;
            case BAR_MOVIE:
               break;
            case GET_MOVIE:
               clearTimeout(this.FTimeid);
               this.FIsPlaying = false;
               this.UpdateUI();
         }
      }
      
      public function DelayUpdate() : void
      {
      }
      
      protected function LogicsPerform_EffectText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         _loc6_ = "";
         _loc4_ = "";
         if(this.FIsEndPushText)
         {
            if(this.FEffectTexts.length == 0)
            {
               return;
            }
            this.FStringID = CONST_SYSTEMLANGUAGE.BACKPACK_FORMAT_02;
            _loc2_ = int(this.FEffectTexts.length);
            _loc3_ = 10;
            _loc5_ = STimingCore.TickCount - this.FEffDelayReferenceTick;
            if(_loc5_ < EffectMulti_DelayTicks)
            {
               return;
            }
            _loc7_ = this.GetEffectText(this.FStringID);
            _loc6_ = _loc7_.split("\\n")[0] + "\n";
            _loc1_ = 0;
            while(_loc1_ < _loc3_)
            {
               if(_loc2_ <= _loc1_)
               {
                  break;
               }
               _loc4_ += this.FEffectTexts.shift();
               _loc4_ = _loc4_ + "\n";
               _loc1_++;
            }
            _loc6_ += _loc4_;
            this.FEffDelayReferenceTick = STimingCore.TickCount;
            EffectGenerateText(_loc6_);
         }
      }
      
      protected function GetEffectText(param1:uint) : String
      {
         this.FSystemLanguage = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,this.FStringID) as TSystemLanguage;
         if(this.FSystemLanguage != null)
         {
            return this.FSystemLanguage.Desc;
         }
         return "";
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeUnsignedInt(0);
         _loc4_.writeUnsignedInt(1371571200);
         _loc4_.writeUnsignedInt(1401571200);
         _loc4_.writeShort(8);
         TUtilityString.FlushUTF(_loc4_,"活动说明长");
         TUtilityString.FlushUTF(_loc4_,"%0积分解锁中圈");
         TUtilityString.FlushUTF(_loc4_,"%0积分解锁内圈");
         TUtilityString.FlushUTF(_loc4_,"%0积分激活宝箱");
         TUtilityString.FlushUTF(_loc4_,"获得以下道具中一个:");
         TUtilityString.FlushUTF(_loc4_,"花费xx金币，可增加x进阶积分，可增加x兑换积分");
         TUtilityString.FlushUTF(_loc4_,"增加x进阶积分，可增加x兑换积分");
         TUtilityString.FlushUTF(_loc4_,"活动说明");
         _loc4_.writeUnsignedInt(20);
         _loc4_.writeUnsignedInt(STimingCore.GetServerTick() + 1);
         _loc4_.writeUnsignedInt(100);
         _loc4_.writeUnsignedInt(10);
         _loc4_.writeShort(1);
         _loc1_ = 0;
         while(_loc1_ < 1)
         {
            _loc4_.writeUnsignedInt(11110071);
            _loc1_++;
         }
         _loc4_.writeUnsignedInt(10);
         _loc4_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc4_.writeUnsignedInt((_loc1_ + 1) * 10);
            _loc1_++;
         }
         _loc4_.writeUnsignedInt(20);
         _loc4_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc4_.writeUnsignedInt((_loc1_ + 1) * 20);
            _loc1_++;
         }
         _loc4_.writeUnsignedInt(1);
         _loc4_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc4_.writeUnsignedInt(1);
            _loc4_.writeUnsignedInt(14100001 + _loc1_);
            _loc4_.writeUnsignedInt(1 + _loc1_);
            _loc1_++;
         }
         _loc4_.writeUnsignedInt(2);
         _loc4_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc4_.writeUnsignedInt(1);
            _loc4_.writeUnsignedInt(14100001 + _loc1_);
            _loc4_.writeUnsignedInt(1 + _loc1_);
            _loc1_++;
         }
         _loc4_.writeShort(3);
         _loc4_.writeUnsignedInt(20);
         _loc4_.writeUnsignedInt(5);
         _loc4_.writeUnsignedInt(2);
         _loc4_.writeUnsignedInt(3);
         _loc4_.writeShort(20);
         _loc1_ = 0;
         while(_loc1_ < 20)
         {
            _loc4_.writeUnsignedInt(1);
            _loc4_.writeUnsignedInt(14100001 + _loc1_);
            _loc4_.writeUnsignedInt(1 + _loc1_);
            _loc4_.writeUnsignedInt(0);
            _loc1_++;
         }
         _loc4_.writeUnsignedInt(20);
         _loc4_.writeUnsignedInt(5);
         _loc4_.writeUnsignedInt(2);
         _loc4_.writeUnsignedInt(3);
         _loc4_.writeShort(14);
         _loc1_ = 0;
         while(_loc1_ < 14)
         {
            _loc4_.writeUnsignedInt(1);
            _loc4_.writeUnsignedInt(14100001 + _loc1_);
            _loc4_.writeUnsignedInt(1 + _loc1_);
            _loc4_.writeUnsignedInt(0);
            _loc1_++;
         }
         _loc4_.writeUnsignedInt(30);
         _loc4_.writeUnsignedInt(5);
         _loc4_.writeUnsignedInt(2);
         _loc4_.writeUnsignedInt(3);
         _loc4_.writeShort(8);
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _loc4_.writeUnsignedInt(1);
            _loc4_.writeUnsignedInt(14100001 + _loc1_);
            _loc4_.writeUnsignedInt(1 + _loc1_);
            _loc4_.writeUnsignedInt(0);
            _loc1_++;
         }
         _loc4_.writeShort(3);
         _loc4_.writeUnsignedInt(20);
         _loc4_.writeUnsignedInt(5);
         _loc4_.writeUnsignedInt(2);
         _loc4_.writeUnsignedInt(3);
         _loc4_.writeShort(20);
         _loc1_ = 0;
         while(_loc1_ < 20)
         {
            _loc4_.writeUnsignedInt(1);
            _loc4_.writeUnsignedInt(14100002 + _loc1_);
            _loc4_.writeUnsignedInt(1 + _loc1_);
            _loc4_.writeUnsignedInt(0);
            _loc1_++;
         }
         _loc4_.writeUnsignedInt(30);
         _loc4_.writeUnsignedInt(5);
         _loc4_.writeUnsignedInt(2);
         _loc4_.writeUnsignedInt(3);
         _loc4_.writeShort(14);
         _loc1_ = 0;
         while(_loc1_ < 14)
         {
            _loc4_.writeUnsignedInt(1);
            _loc4_.writeUnsignedInt(14100002 + _loc1_);
            _loc4_.writeUnsignedInt(1 + _loc1_);
            _loc4_.writeUnsignedInt(0);
            _loc1_++;
         }
         _loc4_.writeUnsignedInt(40);
         _loc4_.writeUnsignedInt(5);
         _loc4_.writeUnsignedInt(2);
         _loc4_.writeUnsignedInt(3);
         _loc4_.writeShort(8);
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _loc4_.writeUnsignedInt(1);
            _loc4_.writeUnsignedInt(14100002 + _loc1_);
            _loc4_.writeUnsignedInt(1 + _loc1_);
            _loc4_.writeUnsignedInt(0);
            _loc1_++;
         }
         _loc4_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            TUtilityString.FlushUTF(_loc4_,"name" + _loc1_);
            TUtilityString.FlushUTF(_loc4_,"server" + _loc1_);
            _loc4_.writeUnsignedInt(_loc1_);
            _loc1_++;
         }
         _loc4_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc4_.writeUnsignedInt(_loc1_ + 1);
            _loc4_.writeUnsignedInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc4_,"aaa");
            _loc4_.writeUnsignedInt(70100022);
            _loc4_.writeUnsignedInt(1);
            _loc4_.writeUnsignedInt(14100001 + _loc1_);
            _loc4_.writeUnsignedInt(1 + _loc1_);
            _loc1_++;
         }
         _loc4_.position = 0;
         return _loc4_;
      }
   }
}

