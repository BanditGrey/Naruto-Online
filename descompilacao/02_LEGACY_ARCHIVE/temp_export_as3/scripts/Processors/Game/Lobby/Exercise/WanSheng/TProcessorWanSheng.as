package Processors.Game.Lobby.Exercise.WanSheng
{
   import Components.Pages.TUIPage;
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
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.WanSheng.TWanSheng;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerWanSheng;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.FebActive.TProcessorFebActiveShop;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   
   public class TProcessorWanSheng extends TProcessorBaseActivity
   {
      
      public static const SHOW_ITEM_COUNT:int = 6;
      
      public static const GIFT_COUNT:int = 3;
      
      public static const BOSS_COUNT:int = 5;
      
      public static const SWEET_COUNT:int = 5;
      
      public static const LOG_COUNT:int = 20;
      
      public static const ACTIVITY_1_GET_GIFT:int = 1;
      
      public static const ACTIVITY_1_OPEN_EGG:int = 2;
      
      public static const ACTIVITY_1_GET_RECHARGE_BOX:int = 3;
      
      public static const ACTIVITY_1_GET_CONSUME_BOX:int = 4;
      
      public static const ACTIVITY_1_REFRESH:int = 5;
      
      public static const ACTIVITY_1_GET_SWEET:int = 6;
      
      public static const ACTIVITY_1_GET_TEN:int = 7;
      
      public static const ACTIVITY_1_GET_KILL_BOX:int = 8;
      
      public static const ACTIVITY_1_EXCHANGE_ITEM:int = 9;
      
      public static const MOVIE_TYPE_OPEN_EGG:int = 1;
      
      public static const MOVIE_TYPE_BEAT_BOSS:int = 2;
      
      public static const MOVIE_TYPE_BOSS_DIED:int = 3;
      
      public static const MOVIE_TYPE_REFRESH_BOSS:int = 4;
      
      public static const MOVIE_TYPE_SWEET:int = 5;
      
      public static const MOVIE_TYPE_FLOW_TEXT:int = 6;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FWanSheng:TWanSheng;
      
      protected var FUnstreamizerWanSheng:TUnstreamizerWanSheng;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FIsPlaying:Boolean;
      
      protected var FWindowType:int;
      
      protected var FMovieType:int;
      
      protected var FOpenIndex:int;
      
      protected var FFrameCount:int;
      
      protected var FTotalFrame:int;
      
      protected var FPlayMovie:MovieClip;
      
      protected var FSweetList:Vector.<MovieClip>;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FUIPage_Lucky:TUIPage;
      
      protected var FTotalPage_Lucky:int;
      
      protected var FCurPage_Lucky:int;
      
      public function TProcessorWanSheng(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FWanSheng = SLogicsCore.WanSheng;
         this.FUnstreamizerWanSheng = new TUnstreamizerWanSheng(param3);
         this.FBuyBoxDate = new Object();
         this.FUIPage = new TUIPage(this);
         this.FUIPage_Lucky = new TUIPage(this);
         this.FSweetList = new Vector.<MovieClip>(SWEET_COUNT);
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem.OnOut = UIComponentsHintOnOut;
         this.FShowItem.OnShowRecruit = ProcessorOnShowItemDesc;
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Gift" + _loc1_];
            _loc4_.MC_BoxPic.buttonMode = true;
            _loc4_.MC_Got.mouseEnabled = false;
            _loc4_.MC_BoxPic.gotoAndStop(_loc1_ + 1);
            _loc4_.MC_BoxPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
            _loc4_.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
            _loc4_.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < BOSS_COUNT)
         {
            FMC_Scene["MC_Icon" + _loc1_].buttonMode = true;
            FMC_Scene["MC_Icon" + _loc1_].MC_Icon.gotoAndStop(_loc1_ + 1);
            FMC_Scene["MC_Icon" + _loc1_].MC_Icon.addEventListener(MouseEvent.CLICK,this.ProcessorOnIconUp);
            FMC_Scene["MC_Icon" + _loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnIconOver);
            FMC_Scene["MC_Icon" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < SWEET_COUNT)
         {
            this.FSweetList[_loc1_] = FMC_Scene["MC_Sweet" + _loc1_];
            this.FSweetList[_loc1_].buttonMode = true;
            this.FSweetList[_loc1_].gotoAndStop(_loc1_ + 1);
            this.FSweetList[_loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnSweetUp);
            this.FSweetList[_loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSweetOver);
            this.FSweetList[_loc1_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
            _loc1_++;
         }
         FMC_Scene.MC_Egg.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnEggOver);
         FMC_Scene.MC_Egg.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         FMC_Scene.MC_RechargeBox.MC_GoldPic.buttonMode = true;
         FMC_Scene.MC_RechargeBox.MC_GoldPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnRechargeBoxUp);
         FMC_Scene.MC_RechargeBox.MC_GoldPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnRechargeBoxOver);
         FMC_Scene.MC_RechargeBox.MC_GoldPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         FMC_Scene.MC_ConsumeBox.MC_BoxPic.buttonMode = true;
         FMC_Scene.MC_ConsumeBox.MC_BoxPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnConsumeBoxUp);
         FMC_Scene.MC_ConsumeBox.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnConsumeBoxOver);
         FMC_Scene.MC_ConsumeBox.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         FMC_Scene.MC_Box.buttonMode = true;
         FMC_Scene.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxBossOver);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_RechargeBox.BTN_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_RechargeBox.BTN_Right;
         this.FUIPage.PageSize = 1;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.FUIPage_Lucky.ButtonPrevious.Substrate = FMC_Scene.MC_Lucky.MC_ChangePage.MC_PageLeft;
         this.FUIPage_Lucky.ButtonNext.Substrate = FMC_Scene.MC_Lucky.MC_ChangePage.MC_PageRight;
         this.FUIPage_Lucky.LabelPage = FMC_Scene.MC_Lucky.MC_ChangePage.TF_Page;
         this.FUIPage_Lucky.TotalQuantity = this.FTotalPage_Lucky;
         this.FUIPage_Lucky.PageSize = LOG_COUNT;
         this.FUIPage_Lucky.PageIndex = 0;
         this.FCurPage_Lucky = 0;
         this.FUIPage_Lucky.OnChangePage = this.ProcessorPageOnChange_Lucky;
         FMC_Scene.MC_Boss.MC_RefreshMovie.visible = false;
         FMC_Scene.MC_Boss.MC_BeatMovie.visible = false;
         FMC_Scene.MC_FlowText.visible = false;
         FMC_Scene.MC_Lucky.visible = false;
         this.FMC_Mask = FMC_Scene.MC_Boss.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
         FMC_Scene.MC_FlowText.mouseEnabled = false;
         FMC_Scene.MC_FlowText.mouseChildren = false;
         this.FProcessorFebActiveShop.Visible = false;
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorFebActiveShop.OnOut = UIComponentsHintOnOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorFebActiveShop.X = -21;
         this.FProcessorFebActiveShop.y = 15;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         TGameUtil.setButtonMode(FMC_Scene.BTN_Gold,true);
         FMC_Scene.BTN_Gold.addEventListener(MouseEvent.CLICK,this.ProcessorOnGoldUp);
         FMC_Scene.BTN_Gold.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGoldOver);
         FMC_Scene.BTN_Gold.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Coin,true);
         FMC_Scene.BTN_Coin.addEventListener(MouseEvent.CLICK,this.ProcessorOnCoinUp);
         FMC_Scene.BTN_Coin.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnCoinOver);
         FMC_Scene.BTN_Coin.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         TGameUtil.setButtonMode(FMC_Scene.BTN_OpenEgg,true);
         FMC_Scene.BTN_OpenEgg.addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenEgg);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,true);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.CLICK,this.ProcessorOnAutoUp);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnAutoOver);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Lucky,true);
         FMC_Scene.BTN_Lucky.addEventListener(MouseEvent.CLICK,this.ProcessorOnLuckyUp);
         FMC_Scene.MC_Lucky.BTN_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnLuckyClose);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
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
            if(this.FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_TYPE_OPEN_EGG:
                     _loc2_ = int(FMC_Scene.MC_Egg.MC_Movie.currentFrame);
                     break;
                  case MOVIE_TYPE_BEAT_BOSS:
                     _loc2_ = int(FMC_Scene.MC_Boss.MC_BeatMovie.currentFrame);
                     break;
                  case MOVIE_TYPE_BOSS_DIED:
                     return;
                  case MOVIE_TYPE_REFRESH_BOSS:
                     _loc2_ = int(FMC_Scene.MC_Boss.MC_RefreshMovie.currentFrame);
                     break;
                  case MOVIE_TYPE_SWEET:
                     return;
                  case MOVIE_TYPE_FLOW_TEXT:
                     _loc2_ = int(FMC_Scene.MC_FlowText.currentFrame);
               }
               if(_loc2_ == this.FTotalFrame)
               {
                  this.FIsPlaying = false;
                  this.FFrameCount = 0;
                  this.MovieEnd();
               }
               else
               {
                  ++this.FFrameCount;
                  if(this.FFrameCount > 100)
                  {
                     this.FIsPlaying = false;
                     this.FFrameCount = 0;
                     this.UpdateUI();
                  }
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateGift();
         this.UpdateBox();
         this.UpdateBoss();
         this.UpdateSweet();
         this.UpdateItem();
         this.UpdateLucky();
         this.UpdateText();
         if(this.FProcessorFebActiveShop.Visible)
         {
            this.FProcessorFebActiveShop.UpdateUI(this.FWanSheng);
         }
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Gift" + _loc1_];
            _loc3_ = this.FWanSheng.GiftList[_loc1_];
            _loc2_.TF_Desc.text = this.FWanSheng.DescListNew[2 + _loc1_];
            if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc2_.MC_Got.visible = false;
               _loc2_.MC_Click.visible = false;
            }
            else if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc2_.MC_Got.visible = false;
               _loc2_.MC_Click.visible = true;
            }
            else
            {
               _loc2_.MC_Got.visible = true;
               _loc2_.MC_Click.visible = false;
            }
            _loc1_++;
         }
         FMC_Scene.TF_FreeTimes.text = this.FWanSheng.LimitTimes.toString();
         FMC_Scene.MC_Egg.MC_Movie.gotoAndStop(1);
         if(this.FWanSheng.LimitTimes > 0)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_OpenEgg,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_OpenEgg,false);
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:TBaseBox = null;
         this.FUIPage.TotalQuantity = this.FWanSheng.RechargeBox.length;
         this.FUIPage.Update();
         _loc1_ = this.FCurPage;
         _loc3_ = this.FWanSheng.RechargeBox[_loc1_];
         _loc2_ = FMC_Scene.MC_RechargeBox;
         _loc2_.MC_GoldPic.gotoAndStop(_loc1_ + 1);
         _loc2_.TF_Desc.text = TUtilityString.Format(this.FWanSheng.DescListNew[6],this.FWanSheng.TotalRechargeGold,_loc3_.Price);
         if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            _loc2_.MC_Click.visible = false;
            _loc2_.MC_Got.visible = false;
         }
         else if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
         {
            _loc2_.MC_Got.visible = false;
            _loc2_.MC_Click.visible = true;
         }
         else
         {
            _loc2_.MC_Click.visible = false;
            _loc2_.MC_Got.visible = true;
         }
         _loc3_ = this.FWanSheng.ConsumeBox;
         _loc2_ = FMC_Scene.MC_ConsumeBox;
         _loc2_.TF_Desc.text = TUtilityString.Format(this.FWanSheng.DescListNew[7],this.FWanSheng.TotalConsumeGold % _loc3_.Price,_loc3_.Price);
         _loc2_.TF_Count.text = "*" + _loc3_.Count;
         _loc2_.MC_Click.visible = _loc3_.Count > 0 ? true : false;
      }
      
      protected function UpdateBoss() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < BOSS_COUNT)
         {
            _loc5_ = FMC_Scene["MC_Icon" + _loc1_];
            _loc6_ = this.FWanSheng.BossList[_loc1_];
            _loc5_.TF_Count.text = "*" + _loc6_.Count;
            _loc5_.TF_Price.text = _loc6_.Min + "/" + _loc6_.Max;
            if(_loc6_.Count > 0)
            {
               _loc5_.filters = [TGameUtil.highLightFilters];
            }
            else
            {
               _loc5_.filters = [];
            }
            _loc1_++;
         }
         FMC_Scene.MC_Boss.MC_KillMovie.gotoAndStop(this.FWanSheng.CurBoss);
         FMC_Scene.MC_Boss.MC_RefreshMovie.visible = false;
         FMC_Scene.MC_Boss.MC_BeatMovie.visible = false;
         _loc4_ = this.FWanSheng.MaxHP;
         FMC_Scene.MC_Boss.MC_Bar.TF_Count.text = this.FWanSheng.CurHP + "/" + _loc4_;
         _loc2_ = Number(this.FWanSheng.CurHP / _loc4_) * this.FBarMaxWidth;
         _loc3_ = Math.min(_loc2_,this.FBarMaxWidth);
         this.FMC_Mask.width = _loc3_;
      }
      
      protected function UpdateSweet() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < SWEET_COUNT)
         {
            _loc3_ = this.FSweetList[_loc1_];
            _loc4_ = this.FWanSheng.SweetList[_loc1_];
            if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.filters = [];
            }
            else
            {
               _loc3_.filters = [TGameUtil.GaryColorFilters];
            }
            _loc1_++;
         }
      }
      
      protected function UpdateItem() : void
      {
         this.FShowItem.UpdateUI(this.FWanSheng.ShowItems);
      }
      
      protected function UpdateLucky() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:TLotteryNews = null;
         var _loc8_:TSystemLanguage = null;
         this.FUIPage_Lucky.TotalQuantity = this.FWanSheng.LuckyList.length;
         this.FUIPage_Lucky.Update();
         _loc1_ = 0;
         while(_loc1_ < LOG_COUNT)
         {
            _loc3_ = _loc1_ + this.FCurPage_Lucky * LOG_COUNT;
            if(_loc3_ < this.FWanSheng.LuckyList.length)
            {
               _loc7_ = this.FWanSheng.LuckyList[_loc3_];
               _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,_loc7_.SoureID) as TSystemLanguage;
               if(_loc8_ == null)
               {
                  throw new Error("SystemLanguage表未配置 " + _loc7_.SoureID);
               }
               _loc4_ = _loc8_.Desc;
               if(_loc7_.GetTime > 0)
               {
                  _loc6_ = TUtilityDate.FormatDate(new Date(STimingCore.GetClientShowTime(_loc7_.GetTime) * 1000));
                  _loc4_ = _loc4_.split("%when%").join(_loc6_);
               }
               if(Boolean(_loc7_.PlayerNick) && _loc7_.PlayerNick != "")
               {
                  _loc4_ = _loc4_.split("%who%").join(_loc7_.PlayerNick);
               }
               if(Boolean(_loc7_.Inventories) && _loc7_.Inventories.Count > 0)
               {
                  _loc5_ = _loc7_.Inventories.GetInventoryByIndex(0).Name + "*" + _loc7_.Inventories.GetInventoryByIndex(0).Quantity;
                  _loc4_ = _loc4_.split("%what%").join(_loc5_);
               }
               FMC_Scene.MC_Lucky["TF_Log" + _loc1_].text = _loc4_;
            }
            else
            {
               FMC_Scene.MC_Lucky["TF_Log" + _loc1_].text = "";
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FWanSheng.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FWanSheng.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FWanSheng.DescListNew[1];
         FMC_Scene.TF_Score.text = this.FWanSheng.Score.toString();
         FMC_Scene.TF_ScoreB.text = this.FWanSheng.ShopExchangePoint.toString();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateBox();
      }
      
      protected function ProcessorPageOnChange_Lucky(param1:Object, param2:int) : void
      {
         this.FCurPage_Lucky = param2;
         this.UpdateLucky();
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(this.FWanSheng && _loc2_ < this.FWanSheng.GiftList.length) && Boolean(!this.FIsPlaying) && this.FWanSheng.GiftList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_GIFT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnOpenEgg(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(Boolean(this.FWanSheng) && !this.FIsPlaying)
         {
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_OPEN_EGG,this.FWanSheng.EggPrice);
         }
      }
      
      protected function ProcessorOnRechargeBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FCurPage;
         if(Boolean(this.FWanSheng && _loc2_ < this.FWanSheng.RechargeBox.length) && Boolean(!this.FIsPlaying) && this.FWanSheng.RechargeBox[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_RECHARGE_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnConsumeBoxUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FWanSheng) && Boolean(this.FWanSheng.ConsumeBox.Count > 0) && !this.FIsPlaying)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_CONSUME_BOX);
         }
      }
      
      protected function ProcessorOnGoldUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FWanSheng) && !this.FIsPlaying)
         {
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_REFRESH,this.FWanSheng.GoldCost,2);
         }
      }
      
      protected function ProcessorOnCoinUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FWanSheng) && !this.FIsPlaying)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_REFRESH,1);
         }
      }
      
      protected function ProcessorOnSweetUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(this.FIsPlaying || _loc2_ >= this.FWanSheng.SweetList.length || this.FWanSheng.SweetList[_loc2_].Status != TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         FMC_Scene.MC_Click.visible = false;
         _loc6_ = this.FWanSheng.SweetList[_loc2_];
         if(this.FWanSheng.Score > _loc6_.Price)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_SWEET,_loc2_ + 1);
         }
         else
         {
            _loc3_ = (_loc6_.Price - this.FWanSheng.Score) * this.FWanSheng.ScorePrice;
            _loc4_ = TUtilityString.Format(this.FWanSheng.DescListNew[28],_loc6_.Price,_loc3_,_loc6_.Price - this.FWanSheng.Score);
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_GET_SWEET,_loc3_,_loc2_ + 1,0,_loc4_);
         }
      }
      
      protected function ProcessorOnAutoUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:TBaseBox = null;
         if(!param1.currentTarget.buttonMode || this.FIsPlaying)
         {
            return;
         }
         FMC_Scene.MC_Click.visible = false;
         if(this.FWanSheng.Score > this.FWanSheng.TenPrice)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_TEN);
         }
         else
         {
            _loc3_ = (this.FWanSheng.TenPrice - this.FWanSheng.Score) * this.FWanSheng.ScorePrice;
            _loc4_ = TUtilityString.Format(this.FWanSheng.DescListNew[28],this.FWanSheng.TenPrice,_loc3_,this.FWanSheng.TenPrice - this.FWanSheng.Score);
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_GET_TEN,_loc3_,0,0,_loc4_);
         }
      }
      
      protected function ProcessorOnIconUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(this.FWanSheng && _loc2_ < this.FWanSheng.BossList.length) && Boolean(!this.FIsPlaying) && this.FWanSheng.BossList[_loc2_].Count > 0)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_KILL_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnLuckyUp(param1:MouseEvent) : void
      {
         FMC_Scene.MC_Lucky.visible = true;
      }
      
      protected function ProcessorOnLuckyClose(param1:MouseEvent) : void
      {
         FMC_Scene.MC_Lucky.visible = false;
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(this.FWanSheng) && _loc2_ < this.FWanSheng.GiftList.length)
         {
            _loc3_ = this.FWanSheng.GiftList[_loc2_].Inventories;
            ProcessorOnNewBoxOver(_loc3_);
         }
      }
      
      protected function ProcessorOnBoxBossOver(param1:MouseEvent) : void
      {
         if(this.FWanSheng)
         {
            ProcessorOnShowHtmlText(this.FWanSheng.DescListNew[21]);
         }
      }
      
      protected function ProcessorOnGoldOver(param1:MouseEvent) : void
      {
         if(this.FWanSheng)
         {
            ProcessorOnShowHtmlText(this.FWanSheng.DescListNew[14]);
         }
      }
      
      protected function ProcessorOnCoinOver(param1:MouseEvent) : void
      {
         if(this.FWanSheng)
         {
            ProcessorOnShowHtmlText(this.FWanSheng.DescListNew[15]);
         }
      }
      
      protected function ProcessorOnIconOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(this.FWanSheng)
         {
            ProcessorOnShowHtmlText(this.FWanSheng.DescListNew[22 + _loc2_]);
         }
      }
      
      protected function ProcessorOnSweetOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(Boolean(this.FWanSheng) && _loc2_ < this.FWanSheng.SweetList.length)
         {
            _loc3_ = this.FWanSheng.SweetList[_loc2_].Desc1;
            ProcessorOnShowHtmlText(this.FWanSheng.DescListNew[9 + _loc2_]);
         }
      }
      
      protected function ProcessorOnEggOver(param1:MouseEvent) : void
      {
         if(this.FWanSheng)
         {
            ProcessorOnShowHtmlText(this.FWanSheng.DescListNew[5]);
         }
      }
      
      protected function ProcessorOnRechargeBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FCurPage;
         if(this.FWanSheng)
         {
            ProcessorOnNewBoxOver(this.FWanSheng.RechargeBox[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnConsumeBoxOver(param1:MouseEvent) : void
      {
         if(this.FWanSheng)
         {
            ProcessorOnShowHtmlText(this.FWanSheng.DescListNew[29]);
         }
      }
      
      protected function ProcessorOnAutoOver(param1:MouseEvent) : void
      {
         if(this.FWanSheng)
         {
            ProcessorOnShowHtmlText(this.FWanSheng.DescListNew[8]);
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(this.FWanSheng)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_EXCHANGE_ITEM,param1 + 1);
         }
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
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI(this.FWanSheng);
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorFebActiveShop.Visible = false;
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FWanSheng;
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         ProcessorLoadActiveRankNew(0);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorFebActiveShop.Load();
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
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
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
         this.FUnstreamizerWanSheng.Unstreamize(_loc2_,this.FWanSheng,null);
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
         if(this.FWanSheng)
         {
            _loc6_ = _loc2_.readInt();
            if(_loc6_ == 1)
            {
               if(this.FWanSheng.GiftList.length > 0)
               {
                  this.FWanSheng.TotalRechargeGold = _loc2_.readUnsignedInt();
                  this.FWanSheng.GiftList[1].Status = _loc2_.readInt();
                  _loc4_ = 0;
                  while(_loc4_ < this.FWanSheng.RechargeBox.length)
                  {
                     this.FWanSheng.RechargeBox[_loc4_].Status = _loc2_.readInt();
                     _loc4_++;
                  }
                  this.FWanSheng.ChangeStatus();
                  ProcessorCheckEffect(FActivityID,this.FWanSheng.CheckStatus());
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
            }
            else if(this.FWanSheng.ConsumeBox)
            {
               this.FWanSheng.TotalConsumeGold = _loc2_.readUnsignedInt();
               this.FWanSheng.ConsumeBox.Count = _loc2_.readInt();
               this.FWanSheng.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng.CheckStatus());
               if(this.FIsOpen)
               {
                  this.UpdateUI();
               }
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
         ProcessorUnstreamActivityLog(this.FWanSheng,_loc2_);
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
         var _loc15_:TBins = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:uint = 0;
         var _loc21_:Vector.<uint> = null;
         var _loc22_:Vector.<uint> = null;
         var _loc23_:String = null;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
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
            case ACTIVITY_1_GET_GIFT:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FWanSheng.GiftList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FWanSheng.GiftList[_loc5_].Inventories.Count)
               {
                  _loc9_ = this.FWanSheng.GiftList[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               this.FWanSheng.RankPoint = _loc2_.readUnsignedInt();
               this.FWanSheng.ShopExchangePoint = _loc2_.readUnsignedInt();
               this.FWanSheng.Score = _loc2_.readUnsignedInt();
               ProcessorEffectText(_loc4_);
               this.FWanSheng.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_OPEN_EGG:
               if(this.FWanSheng.LimitTimes > 0)
               {
                  --this.FWanSheng.LimitTimes;
               }
               _loc18_ = int(_loc2_.readUnsignedInt());
               _loc17_ = int(_loc2_.readUnsignedInt());
               _loc16_ = int(_loc2_.readUnsignedInt());
               if(_loc16_ == 0)
               {
                  _loc4_ = TUtilityString.Format(this.FWanSheng.DescListNew[17 + _loc18_],_loc17_,this.FWanSheng.DescListNew[16]) + "\n";
               }
               else
               {
                  _loc4_ = "";
                  _loc6_ = 0;
                  while(_loc6_ < _loc16_)
                  {
                     _loc14_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc12_ = _loc2_.readUnsignedInt();
                     _loc4_ += STRING_COMMON.GetItemNameByType(_loc14_,_loc11_) + "*" + _loc12_ + "\n";
                     _loc6_++;
                  }
               }
               this.FWanSheng.RankPoint = _loc2_.readUnsignedInt();
               this.FWanSheng.ShopExchangePoint = _loc2_.readUnsignedInt();
               this.FWanSheng.Score = _loc2_.readUnsignedInt();
               this.FWanSheng.TotalConsumeGold = _loc2_.readUnsignedInt();
               this.FWanSheng.ConsumeBox.Count = _loc2_.readInt();
               this.FWanSheng.GiftList[2].Status = _loc2_.readInt();
               this.FWanSheng.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng.CheckStatus());
               FMC_Scene.MC_FlowText.MC_Text.TF_Desc.text = _loc4_;
               this.PlayMovie(MOVIE_TYPE_OPEN_EGG);
               break;
            case ACTIVITY_1_GET_RECHARGE_BOX:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FWanSheng.RechargeBox[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FWanSheng.RechargeBox[_loc5_].Inventories.Count)
               {
                  _loc9_ = this.FWanSheng.RechargeBox[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               this.FWanSheng.RankPoint = _loc2_.readUnsignedInt();
               this.FWanSheng.ShopExchangePoint = _loc2_.readUnsignedInt();
               this.FWanSheng.Score = _loc2_.readUnsignedInt();
               ProcessorEffectText(_loc4_);
               this.FWanSheng.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_CONSUME_BOX:
               --this.FWanSheng.ConsumeBox.Count;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc18_ = int(_loc2_.readUnsignedInt());
               _loc17_ = int(_loc2_.readUnsignedInt());
               _loc16_ = int(_loc2_.readUnsignedInt());
               if(_loc16_ == 0)
               {
                  _loc4_ = TUtilityString.Format(this.FWanSheng.DescListNew[17 + _loc18_],_loc17_,this.FWanSheng.DescListNew[17]) + "\n";
               }
               else
               {
                  _loc6_ = 0;
                  while(_loc6_ < _loc16_)
                  {
                     _loc14_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc12_ = _loc2_.readUnsignedInt();
                     _loc4_ += STRING_COMMON.GetItemNameByType(_loc14_,_loc11_) + "*" + _loc12_ + "\n";
                     _loc6_++;
                  }
               }
               this.FWanSheng.RankPoint = _loc2_.readUnsignedInt();
               this.FWanSheng.ShopExchangePoint = _loc2_.readUnsignedInt();
               this.FWanSheng.Score = _loc2_.readUnsignedInt();
               ProcessorEffectText(_loc4_);
               this.FWanSheng.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_REFRESH:
               this.FWanSheng.CurBoss = _loc2_.readUnsignedInt();
               this.FWanSheng.MaxHP = _loc2_.readUnsignedInt();
               this.FWanSheng.CurHP = this.FWanSheng.MaxHP;
               this.FWanSheng.TotalConsumeGold = _loc2_.readUnsignedInt();
               this.FWanSheng.ConsumeBox.Count = _loc2_.readInt();
               ProcessorEffectText(this.FWanSheng.DescListNew[27]);
               this.FWanSheng.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng.CheckStatus());
               this.PlayMovie(MOVIE_TYPE_REFRESH_BOSS);
               break;
            case ACTIVITY_1_GET_SWEET:
               _loc12_ = _loc2_.readUnsignedInt();
               if(_loc12_ > 0)
               {
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc4_ = _loc4_ + (this.FWanSheng.DescListNew[17] + "*" + _loc12_ + "\n");
                  ProcessorEffectText(_loc4_);
               }
               _loc5_ = 0;
               while(_loc5_ < this.FWanSheng.SweetList.length)
               {
                  this.FWanSheng.SweetList[_loc5_].Status = _loc2_.readInt();
                  _loc5_++;
               }
               _loc5_ = 0;
               while(_loc5_ < this.FWanSheng.BossList.length)
               {
                  _loc13_ = this.FWanSheng.BossList[_loc5_];
                  _loc13_.Count = _loc2_.readUnsignedInt();
                  _loc13_.Min = _loc2_.readUnsignedInt();
                  _loc5_++;
               }
               this.FWanSheng.RankPoint = _loc2_.readUnsignedInt();
               this.FWanSheng.ShopExchangePoint = _loc2_.readUnsignedInt();
               this.FWanSheng.Score = _loc2_.readUnsignedInt();
               this.FWanSheng.TotalConsumeGold = _loc2_.readUnsignedInt();
               this.FWanSheng.ConsumeBox.Count = _loc2_.readInt();
               this.FWanSheng.CurBoss = _loc2_.readUnsignedInt();
               this.FWanSheng.CurHP = _loc2_.readUnsignedInt();
               this.FWanSheng.MaxHP = _loc2_.readUnsignedInt();
               this.FWanSheng.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng.CheckStatus());
               this.PlayMovie(MOVIE_TYPE_BEAT_BOSS);
               break;
            case ACTIVITY_1_GET_TEN:
               this.FWanSheng.AmountList.length = 0;
               this.FWanSheng.IndexList.length = 0;
               this.FWanSheng.StatusList.length = 0;
               this.FWanSheng.CurBossList.length = 0;
               this.FWanSheng.HpList.length = 0;
               this.FWanSheng.MaxHpList.length = 0;
               _loc5_ = 0;
               while(_loc5_ < 10)
               {
                  this.FWanSheng.AmountList[_loc5_] = _loc2_.readUnsignedInt();
                  this.FWanSheng.IndexList[_loc5_] = _loc2_.readUnsignedInt();
                  this.FWanSheng.StatusList[_loc5_] = _loc2_.readInt();
                  this.FWanSheng.CurBossList[_loc5_] = _loc2_.readInt();
                  this.FWanSheng.HpList[_loc5_] = _loc2_.readInt();
                  this.FWanSheng.MaxHpList[_loc5_] = _loc2_.readInt();
                  _loc5_++;
               }
               _loc5_ = 0;
               while(_loc5_ < this.FWanSheng.BossList.length)
               {
                  _loc13_ = this.FWanSheng.BossList[_loc5_];
                  _loc13_.Count = _loc2_.readUnsignedInt();
                  _loc13_.Min = _loc2_.readUnsignedInt();
                  _loc5_++;
               }
               this.FWanSheng.RankPoint = _loc2_.readUnsignedInt();
               this.FWanSheng.ShopExchangePoint = _loc2_.readUnsignedInt();
               this.FWanSheng.Score = _loc2_.readUnsignedInt();
               this.FWanSheng.TotalConsumeGold = _loc2_.readUnsignedInt();
               this.FWanSheng.ConsumeBox.Count = _loc2_.readInt();
               this.FWanSheng.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng.CheckStatus());
               this.PlayGameMovie();
               break;
            case ACTIVITY_1_GET_KILL_BOX:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               --this.FWanSheng.BossList[_loc5_].Count;
               _loc12_ = _loc2_.readUnsignedInt();
               this.FWanSheng.RankPoint += _loc12_;
               this.FWanSheng.ShopExchangePoint += _loc12_;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc4_ = _loc4_ + (this.FWanSheng.DescListNew[17] + "*" + _loc12_ + "\n");
               ProcessorEffectText(_loc4_);
               this.FWanSheng.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_EXCHANGE_ITEM:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               --this.FWanSheng.ShopExchangeItems[_loc5_].LimitCount;
               this.FWanSheng.ShopExchangePoint = _loc2_.readUnsignedInt();
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FWanSheng.ShopExchangeItems[_loc5_].Inventories.Count)
               {
                  _loc9_ = this.FWanSheng.ShopExchangeItems[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               ProcessorEffectText(_loc4_);
               this.FWanSheng.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         this.FIsPlaying = true;
         this.FMovieType = param1;
         if(this.FMovieType == MOVIE_TYPE_OPEN_EGG)
         {
            _loc4_ = FMC_Scene.MC_Egg.MC_Movie;
            this.FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
            FMC_Scene.MC_FlowText.visible = true;
            FMC_Scene.MC_FlowText.gotoAndPlay(1);
            FMC_Scene.BTN_OpenEgg.visible = false;
         }
         else if(this.FMovieType == MOVIE_TYPE_BEAT_BOSS)
         {
            _loc4_ = FMC_Scene.MC_Boss.MC_BeatMovie;
            _loc4_.visible = true;
            this.FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_TYPE_BOSS_DIED)
         {
            _loc4_ = FMC_Scene.MC_Boss.MC_KillMovie;
            _loc4_.visible = true;
            _loc4_.gotoAndStop(this.FWanSheng.CurBoss + BOSS_COUNT + 1);
            setTimeout(this.MovieEnd,500);
         }
         else if(this.FMovieType == MOVIE_TYPE_REFRESH_BOSS)
         {
            _loc4_ = FMC_Scene.MC_Boss.MC_RefreshMovie;
            this.FTotalFrame = _loc4_.totalFrames;
            _loc4_.visible = true;
            _loc4_.gotoAndPlay(1);
         }
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         this.FIsPlaying = false;
         if(this.FMovieType == MOVIE_TYPE_OPEN_EGG)
         {
            FMC_Scene.MC_Egg.MC_Movie.gotoAndStop(1);
            FMC_Scene.BTN_OpenEgg.visible = true;
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_TYPE_BEAT_BOSS)
         {
            FMC_Scene.MC_Boss.MC_BeatMovie.visible = false;
            if(this.FWanSheng.CurHP <= 0)
            {
               this.PlayMovie(MOVIE_TYPE_BOSS_DIED);
            }
            else
            {
               this.UpdateUI();
            }
         }
         else if(this.FMovieType == MOVIE_TYPE_REFRESH_BOSS)
         {
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_TYPE_BOSS_DIED)
         {
            this.PlayMovie(MOVIE_TYPE_REFRESH_BOSS);
         }
      }
      
      public function PlayGameMovie() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(!this.FIsPlaying)
         {
            this.FIsPlaying = true;
            this.FMovieType = MOVIE_TYPE_SWEET;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,false);
         }
         FMC_Scene.MC_Boss.MC_BeatMovie.visible = true;
         FMC_Scene.MC_Boss.MC_BeatMovie.play();
         _loc3_ = int(this.FWanSheng.StatusList.length);
         if(_loc3_ > 0)
         {
            _loc1_ = this.FWanSheng.IndexList[0] - 1;
            this.FWanSheng.SweetList[_loc1_].Status = this.FWanSheng.StatusList[0];
            if(_loc1_ <= 0)
            {
               _loc2_ = 4;
            }
            else
            {
               _loc2_ = _loc1_ - 1;
            }
            if(_loc2_ != 0)
            {
               this.FWanSheng.SweetList[_loc2_].Status = TBaseActivity.STATUS_CANNOTGET;
            }
            if(this.FWanSheng.AmountList[0] > 0)
            {
               _loc5_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = _loc5_ + (this.FWanSheng.DescListNew[17] + "*" + this.FWanSheng.AmountList[0] + "\n");
               this.FWanSheng.ChangeStatus();
               ProcessorEffectText(_loc5_);
            }
            _loc8_ = this.FWanSheng.MaxHpList[0];
            FMC_Scene.MC_Boss.MC_Bar.TF_Count.text = this.FWanSheng.HpList[0] + "/" + _loc8_;
            _loc6_ = Number(this.FWanSheng.HpList[0] / _loc8_) * this.FBarMaxWidth;
            _loc7_ = Math.min(_loc6_,this.FBarMaxWidth);
            this.FMC_Mask.width = _loc7_;
            this.FWanSheng.CurBoss = this.FWanSheng.CurBossList[0];
            this.FWanSheng.CurHP = this.FWanSheng.HpList[0];
            this.FWanSheng.MaxHP = this.FWanSheng.MaxHpList[0];
            FMC_Scene.MC_Boss.MC_KillMovie.gotoAndStop(this.FWanSheng.CurBossList[0]);
            this.UpdateSweet();
            this.FWanSheng.StatusList.shift();
            this.FWanSheng.IndexList.shift();
            this.FWanSheng.AmountList.shift();
            this.FWanSheng.CurBossList.shift();
            this.FWanSheng.HpList.shift();
            this.FWanSheng.MaxHpList.shift();
            setTimeout(this.PlayGameMovie,250);
         }
         else
         {
            this.FIsPlaying = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,true);
            this.UpdateUI();
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
         _loc3_.writeShort(29);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"每日登陆礼包");
         TUtilityString.FlushUTF(_loc3_,"每日充值200金币可领");
         TUtilityString.FlushUTF(_loc3_,"每日彩蛋礼包");
         TUtilityString.FlushUTF(_loc3_,"彩蛋TIPS");
         TUtilityString.FlushUTF(_loc3_,"累计充值%0/%1可领");
         TUtilityString.FlushUTF(_loc3_,"每消费%0/%1可领");
         TUtilityString.FlushUTF(_loc3_,"十连击TIPS");
         TUtilityString.FlushUTF(_loc3_,"点1TIP");
         TUtilityString.FlushUTF(_loc3_,"点2TIP");
         TUtilityString.FlushUTF(_loc3_,"点3TIP");
         TUtilityString.FlushUTF(_loc3_,"点4TIP");
         TUtilityString.FlushUTF(_loc3_,"点5TIP");
         TUtilityString.FlushUTF(_loc3_,"金币刷新TIP");
         TUtilityString.FlushUTF(_loc3_,"硬币刷新TIP");
         TUtilityString.FlushUTF(_loc3_,"游戏币名字");
         TUtilityString.FlushUTF(_loc3_,"收集物名字");
         TUtilityString.FlushUTF(_loc3_,"你什么都没拿到");
         TUtilityString.FlushUTF(_loc3_,"你获得了%0个%1");
         TUtilityString.FlushUTF(_loc3_,"你运气太好了,获得了%0个%1");
         TUtilityString.FlushUTF(_loc3_,"宝箱怪物TIP");
         TUtilityString.FlushUTF(_loc3_,"怪物1TIP");
         TUtilityString.FlushUTF(_loc3_,"怪物2TIP");
         TUtilityString.FlushUTF(_loc3_,"怪物3TIP");
         TUtilityString.FlushUTF(_loc3_,"怪物4TIP");
         TUtilityString.FlushUTF(_loc3_,"怪物5TIP");
         TUtilityString.FlushUTF(_loc3_,"刷新成功");
         TUtilityString.FlushUTF(_loc3_,"当前消耗%0个XX，是否花费%1金币补齐不足的%2个XX？");
         TUtilityString.FlushUTF(_loc3_,"消费礼包TIPS");
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(110);
         _loc3_.writeUnsignedInt(110);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeInt(1);
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
         _loc3_.writeInt(1);
         _loc3_.writeInt(100);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(1);
            _loc3_.writeInt(10 + _loc1_);
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
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(_loc2_ % 2);
            _loc2_++;
         }
         _loc3_.writeShort(5);
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_.writeUnsignedInt(_loc2_);
            _loc3_.writeUnsignedInt(10);
            _loc3_.writeUnsignedInt(_loc2_);
            _loc2_++;
         }
         _loc3_.writeShort(6);
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeShort(1);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(6);
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(6);
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            TUtilityString.FlushUTF(_loc3_,"aaa");
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc3_.writeUnsignedInt(70100108);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

