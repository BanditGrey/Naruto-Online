package Processors.Game.Lobby.Exercise.WanSheng2
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
   import Logics.Exercise.WanSheng2.TWanSheng2;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerWanSheng2;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   
   public class TProcessorWanSheng2 extends TProcessorBaseActivity
   {
      
      public static const SHOW_ITEM_COUNT:int = 6;
      
      public static const GIFT_COUNT:int = 3;
      
      public static const BOSS_COUNT:int = 5;
      
      public static const SWEET_COUNT:int = 5;
      
      public static const LOG_COUNT:int = 20;
      
      protected static const EXCHANGE_BOX_COUNT:int = 6;
      
      public static const ACTIVITY_1_GET_GIFT:int = 1;
      
      public static const ACTIVITY_1_OPEN_EGG:int = 2;
      
      public static const ACTIVITY_1_GET_RECHARGE_BOX:int = 3;
      
      public static const ACTIVITY_1_GET_CONSUME_BOX:int = 4;
      
      public static const ACTIVITY_1_REFRESH:int = 5;
      
      public static const ACTIVITY_1_GET_SWEET:int = 6;
      
      public static const ACTIVITY_1_GET_TEN:int = 7;
      
      public static const ACTIVITY_1_GET_KILL_BOX:int = 8;
      
      public static const ACTIVITY_1_EXCHANGE_ITEM:int = 9;
      
      public static const ACTIVITY_1_EXCHANGE_HERO:int = 10;
      
      public static const MOVIE_TYPE_OPEN_EGG:int = 1;
      
      public static const MOVIE_TYPE_BEAT_BOSS:int = 2;
      
      public static const MOVIE_TYPE_BOSS_DIED:int = 3;
      
      public static const MOVIE_TYPE_REFRESH_BOSS:int = 4;
      
      public static const MOVIE_TYPE_SWEET:int = 5;
      
      public static const MOVIE_TYPE_FLOW_TEXT:int = 6;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FWanSheng2:TWanSheng2;
      
      protected var FUnstreamizerWanSheng2:TUnstreamizerWanSheng2;
      
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
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FUIPage_Lucky:TUIPage;
      
      protected var FTotalPage_Lucky:int;
      
      protected var FCurPage_Lucky:int;
      
      protected var FExchangeList:Vector.<TUIBaseBox>;
      
      protected var FUIPage_Exchange:TUIPage;
      
      protected var FTotalPage_Exchange:int;
      
      protected var FCurPage_Exchange:int;
      
      public function TProcessorWanSheng2(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FWanSheng2 = SLogicsCore.WanSheng2;
         this.FUnstreamizerWanSheng2 = new TUnstreamizerWanSheng2(param3);
         this.FBuyBoxDate = new Object();
         this.FUIPage = new TUIPage(this);
         this.FUIPage_Lucky = new TUIPage(this);
         this.FSweetList = new Vector.<MovieClip>(SWEET_COUNT);
         this.FExchangeList = new Vector.<TUIBaseBox>(EXCHANGE_BOX_COUNT);
         this.FUIPage_Exchange = new TUIPage(this);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TUIBaseBox = null;
         super.ResourcesPerform_UIDispatch();
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
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_BOX_COUNT)
         {
            _loc6_ = new TUIBaseBox(this,1);
            _loc6_.Perform_UIDispatch(FMC_Scene["MC_Item" + _loc1_]);
            _loc6_.OnOverlay = UIComponentsHintOnOver;
            _loc6_.OnOut = UIComponentsHintOnOut;
            this.FExchangeList[_loc1_] = _loc6_;
            FMC_Scene["MC_Item" + _loc1_].BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
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
         this.FUIPage_Exchange.ButtonPrevious.Substrate = FMC_Scene.BTN_Left;
         this.FUIPage_Exchange.ButtonNext.Substrate = FMC_Scene.BTN_Right;
         this.FUIPage_Exchange.TotalQuantity = this.FTotalPage_Exchange;
         this.FUIPage_Exchange.PageSize = EXCHANGE_BOX_COUNT;
         this.FUIPage_Exchange.PageIndex = 0;
         this.FCurPage_Exchange = 0;
         this.FUIPage_Exchange.OnChangePage = this.ProcessorPageOnChange_Exchange;
         FMC_Scene.MC_Boss.MC_RefreshMovie.visible = false;
         FMC_Scene.MC_Boss.MC_BeatMovie.visible = false;
         FMC_Scene.MC_FlowText.visible = false;
         FMC_Scene.MC_Lucky.visible = false;
         this.FMC_Mask = FMC_Scene.MC_Boss.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
         FMC_Scene.MC_FlowText.mouseEnabled = false;
         FMC_Scene.MC_FlowText.mouseChildren = false;
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
         FMC_Scene.BTN_OpenEgg.buttonMode = true;
         FMC_Scene.BTN_OpenEgg.addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenEgg);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,true);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.CLICK,this.ProcessorOnAutoUp);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnAutoOver);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Lucky,true);
         FMC_Scene.BTN_Lucky.addEventListener(MouseEvent.CLICK,this.ProcessorOnLuckyUp);
         FMC_Scene.MC_Lucky.BTN_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnLuckyClose);
         TGameUtil.setButtonMode(FMC_Scene.MC_Hero0.Btn_Get,true);
         FMC_Scene.MC_Hero0.Btn_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeHeroUp);
         TGameUtil.setButtonMode(FMC_Scene.MC_Hero0.BTN_HeroDesc,true);
         FMC_Scene.MC_Hero0.BTN_HeroDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroDescUp);
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
            _loc1_ = 0;
            while(_loc1_ < EXCHANGE_BOX_COUNT)
            {
               if(this.FExchangeList[_loc1_])
               {
                  this.FExchangeList[_loc1_].LogicsPerform();
               }
               _loc1_++;
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
         this.UpdateExchange();
         this.UpdateLucky();
         this.UpdateHero();
         this.UpdateText();
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         FMC_Scene.TF_FreeTimes.text = this.FWanSheng2.LimitTimes.toString();
         FMC_Scene.MC_Egg.MC_Movie.gotoAndStop(1);
         if(this.FWanSheng2.LimitTimes > 0)
         {
            FMC_Scene.BTN_OpenEgg.filters = [];
         }
         else
         {
            FMC_Scene.BTN_OpenEgg.filters = [TGameUtil.GaryColorFilters];
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:TBaseBox = null;
         this.FUIPage.TotalQuantity = this.FWanSheng2.RechargeBox.length;
         this.FUIPage.Update();
         _loc1_ = this.FCurPage;
         _loc3_ = this.FWanSheng2.RechargeBox[_loc1_];
         _loc2_ = FMC_Scene.MC_RechargeBox;
         _loc2_.MC_GoldPic.gotoAndStop(_loc1_ + 1);
         _loc2_.TF_Desc.text = TUtilityString.Format(this.FWanSheng2.DescListNew[6],this.FWanSheng2.TotalRechargeGold,_loc3_.Price);
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
         _loc3_ = this.FWanSheng2.ConsumeBox;
         _loc2_ = FMC_Scene.MC_ConsumeBox;
         _loc2_.TF_Desc.text = TUtilityString.Format(this.FWanSheng2.DescListNew[7],this.FWanSheng2.TotalConsumeGold % _loc3_.Price,_loc3_.Price);
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
            _loc6_ = this.FWanSheng2.BossList[_loc1_];
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
         FMC_Scene.MC_Boss.MC_KillMovie.gotoAndStop(this.FWanSheng2.CurBoss);
         FMC_Scene.MC_Boss.MC_RefreshMovie.visible = false;
         FMC_Scene.MC_Boss.MC_BeatMovie.visible = false;
         _loc4_ = this.FWanSheng2.MaxHP;
         FMC_Scene.MC_Boss.MC_Bar.TF_Count.text = this.FWanSheng2.CurHP + "/" + _loc4_;
         _loc2_ = Number(this.FWanSheng2.CurHP / _loc4_) * this.FBarMaxWidth;
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
            _loc4_ = this.FWanSheng2.SweetList[_loc1_];
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
      
      protected function UpdateExchange() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TBaseBox = null;
         this.FUIPage_Exchange.TotalQuantity = this.FWanSheng2.ShopExchangeItems.length;
         this.FUIPage_Exchange.Update();
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_BOX_COUNT)
         {
            _loc3_ = _loc1_ + this.FCurPage_Exchange * EXCHANGE_BOX_COUNT;
            if(_loc3_ < this.FWanSheng2.ShopExchangeItems.length)
            {
               this.FExchangeList[_loc1_].SetVisible(true);
               _loc5_ = this.FWanSheng2.ShopExchangeItems[_loc3_];
               this.FExchangeList[_loc1_].UpdateUI(_loc5_.Inventories);
               this.FExchangeList[_loc1_].Identify = _loc3_;
               _loc4_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc5_.LimitCount.toString());
               this.FExchangeList[_loc1_].SetLimitText(_loc4_);
               _loc4_ = _loc5_.Price.toString();
               this.FExchangeList[_loc1_].SetPriceText(_loc4_);
               if(_loc5_.IsHot == 0)
               {
                  if(this.FWanSheng2.ShopExchangePoint < _loc5_.Price || _loc5_.LimitCount <= 0)
                  {
                     this.FExchangeList[_loc1_].SetExchangeBtnMode(false);
                  }
                  else
                  {
                     this.FExchangeList[_loc1_].SetExchangeBtnMode(true);
                  }
                  this.FExchangeList[_loc1_].MC_Tag.visible = false;
               }
               else
               {
                  if(this.FWanSheng2.ShopExchangePoint < _loc5_.Price || _loc5_.LimitCount <= 0)
                  {
                     this.FExchangeList[_loc1_].SetExchangeBtnMode(false);
                  }
                  else
                  {
                     this.FExchangeList[_loc1_].SetExchangeBtnMode(true);
                  }
                  if(this.FWanSheng2.Hero.Status == TBaseActivity.STATUS_GETED)
                  {
                     this.FExchangeList[_loc1_].MC_Tag.visible = false;
                  }
                  else
                  {
                     this.FExchangeList[_loc1_].MC_Tag.visible = true;
                  }
               }
               if(_loc5_.LimitCount == 0)
               {
                  this.FExchangeList[_loc1_].SetMCIsVisible("MC_Got",true);
                  this.FExchangeList[_loc1_].SetMCIsVisible("BTN_Exchange",false);
               }
               else
               {
                  this.FExchangeList[_loc1_].SetMCIsVisible("MC_Got",false);
                  this.FExchangeList[_loc1_].SetMCIsVisible("BTN_Exchange",true);
               }
            }
            else
            {
               this.FExchangeList[_loc1_].SetVisible(false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateHero() : void
      {
         var _loc1_:TBaseBox = null;
         _loc1_ = this.FWanSheng2.Hero;
         FMC_Scene.MC_Hero0.TF_Price.text = _loc1_.Price.toString();
         if(_loc1_.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Hero0.MC_Got.visible = true;
            FMC_Scene.MC_Hero0.Btn_Get.visible = false;
         }
         else if(this.FWanSheng2.ShopExchangePoint >= _loc1_.Price)
         {
            FMC_Scene.MC_Hero0.MC_Got.visible = false;
            FMC_Scene.MC_Hero0.Btn_Get.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.MC_Hero0.Btn_Get,true);
         }
         else
         {
            FMC_Scene.MC_Hero0.MC_Got.visible = false;
            FMC_Scene.MC_Hero0.Btn_Get.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.MC_Hero0.Btn_Get,false);
         }
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
         this.FUIPage_Lucky.TotalQuantity = this.FWanSheng2.LuckyList.length;
         this.FUIPage_Lucky.Update();
         _loc1_ = 0;
         while(_loc1_ < LOG_COUNT)
         {
            _loc3_ = _loc1_ + this.FCurPage_Lucky * LOG_COUNT;
            if(_loc3_ < this.FWanSheng2.LuckyList.length)
            {
               _loc7_ = this.FWanSheng2.LuckyList[_loc3_];
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
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FWanSheng2.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FWanSheng2.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FWanSheng2.DescListNew[1];
         FMC_Scene.TF_Score.text = this.FWanSheng2.Score.toString();
         FMC_Scene.TF_ScoreB.text = this.FWanSheng2.ShopExchangePoint.toString();
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
      
      protected function ProcessorPageOnChange_Exchange(param1:Object, param2:int) : void
      {
         this.FCurPage_Exchange = param2;
         this.UpdateExchange();
      }
      
      protected function ProcessorOnOpenEgg(param1:MouseEvent) : void
      {
         if(Boolean(this.FWanSheng2) && Boolean(!this.FIsPlaying) && this.FWanSheng2.LimitTimes > 0)
         {
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_OPEN_EGG,this.FWanSheng2.EggPrice);
         }
      }
      
      protected function ProcessorOnRechargeBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FCurPage;
         if(Boolean(this.FWanSheng2 && _loc2_ < this.FWanSheng2.RechargeBox.length) && Boolean(!this.FIsPlaying) && this.FWanSheng2.RechargeBox[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_RECHARGE_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnConsumeBoxUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FWanSheng2) && Boolean(this.FWanSheng2.ConsumeBox.Count > 0) && !this.FIsPlaying)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_CONSUME_BOX);
         }
      }
      
      protected function ProcessorOnGoldUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FWanSheng2) && !this.FIsPlaying)
         {
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_REFRESH,this.FWanSheng2.GoldCost,2);
         }
      }
      
      protected function ProcessorOnCoinUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FWanSheng2) && !this.FIsPlaying)
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
         if(this.FIsPlaying || _loc2_ >= this.FWanSheng2.SweetList.length || this.FWanSheng2.SweetList[_loc2_].Status != TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         FMC_Scene.MC_Click.visible = false;
         _loc6_ = this.FWanSheng2.SweetList[_loc2_];
         if(this.FWanSheng2.Score > _loc6_.Price)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_SWEET,_loc2_ + 1);
         }
         else
         {
            _loc3_ = (_loc6_.Price - this.FWanSheng2.Score) * this.FWanSheng2.ScorePrice;
            _loc4_ = TUtilityString.Format(this.FWanSheng2.DescListNew[28],_loc6_.Price,_loc3_,_loc6_.Price - this.FWanSheng2.Score);
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
         if(this.FWanSheng2.Score > this.FWanSheng2.TenPrice)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_TEN);
         }
         else
         {
            _loc3_ = (this.FWanSheng2.TenPrice - this.FWanSheng2.Score) * this.FWanSheng2.ScorePrice;
            _loc4_ = TUtilityString.Format(this.FWanSheng2.DescListNew[28],this.FWanSheng2.TenPrice,_loc3_,this.FWanSheng2.TenPrice - this.FWanSheng2.Score);
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_GET_TEN,_loc3_,0,0,_loc4_);
         }
      }
      
      protected function ProcessorOnIconUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(this.FWanSheng2 && _loc2_ < this.FWanSheng2.BossList.length) && Boolean(!this.FIsPlaying) && this.FWanSheng2.BossList[_loc2_].Count > 0)
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
      
      protected function ProcessorOnBoxBossOver(param1:MouseEvent) : void
      {
         if(this.FWanSheng2)
         {
            ProcessorOnShowHtmlText(this.FWanSheng2.DescListNew[21]);
         }
      }
      
      protected function ProcessorOnGoldOver(param1:MouseEvent) : void
      {
         if(this.FWanSheng2)
         {
            ProcessorOnShowHtmlText(this.FWanSheng2.DescListNew[14]);
         }
      }
      
      protected function ProcessorOnCoinOver(param1:MouseEvent) : void
      {
         if(this.FWanSheng2)
         {
            ProcessorOnShowHtmlText(this.FWanSheng2.DescListNew[15]);
         }
      }
      
      protected function ProcessorOnIconOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(this.FWanSheng2)
         {
            ProcessorOnShowHtmlText(this.FWanSheng2.DescListNew[22 + _loc2_]);
         }
      }
      
      protected function ProcessorOnSweetOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(Boolean(this.FWanSheng2) && _loc2_ < this.FWanSheng2.SweetList.length)
         {
            _loc3_ = this.FWanSheng2.SweetList[_loc2_].Desc1;
            ProcessorOnShowHtmlText(this.FWanSheng2.DescListNew[9 + _loc2_]);
         }
      }
      
      protected function ProcessorOnEggOver(param1:MouseEvent) : void
      {
         if(this.FWanSheng2)
         {
            ProcessorOnShowHtmlText(this.FWanSheng2.DescListNew[5]);
         }
      }
      
      protected function ProcessorOnRechargeBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FCurPage;
         if(this.FWanSheng2)
         {
            ProcessorOnNewBoxOver(this.FWanSheng2.RechargeBox[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnConsumeBoxOver(param1:MouseEvent) : void
      {
         if(this.FWanSheng2)
         {
            ProcessorOnShowHtmlText(this.FWanSheng2.DescListNew[29]);
         }
      }
      
      protected function ProcessorOnAutoOver(param1:MouseEvent) : void
      {
         if(this.FWanSheng2)
         {
            ProcessorOnShowHtmlText(this.FWanSheng2.DescListNew[8]);
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage_Exchange * EXCHANGE_BOX_COUNT;
         if(Boolean(!this.FIsPlaying && this.FWanSheng2 && _loc3_ < this.FWanSheng2.ShopExchangeItems.length) && Boolean(this.FWanSheng2.ShopExchangeItems[_loc3_].LimitCount > 0) && this.FWanSheng2.ShopExchangePoint >= this.FWanSheng2.ShopExchangeItems[_loc3_].Price)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_EXCHANGE_ITEM,_loc3_ + 1);
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
      
      protected function ProcessorOnExchangeHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!this.FIsPlaying && Boolean(this.FWanSheng2))
         {
            _loc2_ = this.FWanSheng2.Hero;
            if(_loc2_.Status != TBaseActivity.STATUS_GETED && this.FWanSheng2.ShopExchangePoint >= _loc2_.Price)
            {
               this.ProcessorOnGetBoxUp(ACTIVITY_1_EXCHANGE_HERO);
            }
         }
      }
      
      protected function ProcessorOnHeroDescUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(Boolean(this.FWanSheng2) && Boolean(this.FWanSheng2.Hero))
         {
            _loc2_ = this.FWanSheng2.Hero;
            ProcessorOnShowItemDesc(_loc2_.Identify,_loc2_.Type);
         }
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
         FProcessorWindowDesc.BaseActivity = this.FWanSheng2;
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
         this.FUnstreamizerWanSheng2.Unstreamize(_loc2_,this.FWanSheng2,null);
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
         if(this.FWanSheng2)
         {
            _loc6_ = _loc2_.readInt();
            if(_loc6_ == 1)
            {
               if(this.FWanSheng2)
               {
                  this.FWanSheng2.TotalRechargeGold = _loc2_.readUnsignedInt();
                  this.FWanSheng2.ChangeStatus();
                  ProcessorCheckEffect(FActivityID,this.FWanSheng2.CheckStatus());
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
            }
            else if(Boolean(this.FWanSheng2) && Boolean(this.FWanSheng2.ConsumeBox))
            {
               this.FWanSheng2.TotalConsumeGold = _loc2_.readUnsignedInt();
               this.FWanSheng2.ConsumeBox.Count = _loc2_.readInt();
               this.FWanSheng2.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng2.CheckStatus());
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
         ProcessorUnstreamActivityLog(this.FWanSheng2,_loc2_);
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
               break;
            case ACTIVITY_1_OPEN_EGG:
               if(this.FWanSheng2.LimitTimes > 0)
               {
                  --this.FWanSheng2.LimitTimes;
               }
               _loc18_ = int(_loc2_.readUnsignedInt());
               _loc17_ = int(_loc2_.readUnsignedInt());
               _loc16_ = int(_loc2_.readUnsignedInt());
               if(_loc16_ == 0)
               {
                  _loc4_ = TUtilityString.Format(this.FWanSheng2.DescListNew[17 + _loc18_],_loc17_,this.FWanSheng2.DescListNew[16]) + "\n";
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
               this.FWanSheng2.RankPoint = _loc2_.readUnsignedInt();
               this.FWanSheng2.ShopExchangePoint = _loc2_.readUnsignedInt();
               this.FWanSheng2.Score = _loc2_.readUnsignedInt();
               this.FWanSheng2.TotalConsumeGold = _loc2_.readUnsignedInt();
               this.FWanSheng2.ConsumeBox.Count = _loc2_.readInt();
               this.FWanSheng2.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng2.CheckStatus());
               FMC_Scene.MC_FlowText.MC_Text.TF_Desc.text = _loc4_;
               this.PlayMovie(MOVIE_TYPE_OPEN_EGG);
               break;
            case ACTIVITY_1_GET_RECHARGE_BOX:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FWanSheng2.RechargeBox[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FWanSheng2.RechargeBox[_loc5_].Inventories.Count)
               {
                  _loc9_ = this.FWanSheng2.RechargeBox[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               this.FWanSheng2.RankPoint = _loc2_.readUnsignedInt();
               this.FWanSheng2.ShopExchangePoint = _loc2_.readUnsignedInt();
               this.FWanSheng2.Score = _loc2_.readUnsignedInt();
               ProcessorEffectText(_loc4_);
               this.FWanSheng2.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng2.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_CONSUME_BOX:
               --this.FWanSheng2.ConsumeBox.Count;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc18_ = int(_loc2_.readUnsignedInt());
               _loc17_ = int(_loc2_.readUnsignedInt());
               _loc16_ = int(_loc2_.readUnsignedInt());
               if(_loc16_ == 0)
               {
                  _loc4_ = TUtilityString.Format(this.FWanSheng2.DescListNew[17 + _loc18_],_loc17_,this.FWanSheng2.DescListNew[17]) + "\n";
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
               this.FWanSheng2.RankPoint = _loc2_.readUnsignedInt();
               this.FWanSheng2.ShopExchangePoint = _loc2_.readUnsignedInt();
               this.FWanSheng2.Score = _loc2_.readUnsignedInt();
               ProcessorEffectText(_loc4_);
               this.FWanSheng2.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng2.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_REFRESH:
               this.FWanSheng2.CurBoss = _loc2_.readUnsignedInt();
               this.FWanSheng2.MaxHP = _loc2_.readUnsignedInt();
               this.FWanSheng2.CurHP = this.FWanSheng2.MaxHP;
               this.FWanSheng2.TotalConsumeGold = _loc2_.readUnsignedInt();
               this.FWanSheng2.ConsumeBox.Count = _loc2_.readInt();
               ProcessorEffectText(this.FWanSheng2.DescListNew[27]);
               this.FWanSheng2.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng2.CheckStatus());
               this.PlayMovie(MOVIE_TYPE_REFRESH_BOSS);
               break;
            case ACTIVITY_1_GET_SWEET:
               _loc12_ = _loc2_.readUnsignedInt();
               if(_loc12_ > 0)
               {
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc4_ = _loc4_ + (this.FWanSheng2.DescListNew[17] + "*" + _loc12_ + "\n");
                  ProcessorEffectText(_loc4_);
               }
               _loc5_ = 0;
               while(_loc5_ < this.FWanSheng2.SweetList.length)
               {
                  this.FWanSheng2.SweetList[_loc5_].Status = _loc2_.readInt();
                  _loc5_++;
               }
               _loc5_ = 0;
               while(_loc5_ < this.FWanSheng2.BossList.length)
               {
                  _loc13_ = this.FWanSheng2.BossList[_loc5_];
                  _loc13_.Count = _loc2_.readUnsignedInt();
                  _loc13_.Min = _loc2_.readUnsignedInt();
                  _loc5_++;
               }
               this.FWanSheng2.RankPoint = _loc2_.readUnsignedInt();
               this.FWanSheng2.ShopExchangePoint = _loc2_.readUnsignedInt();
               this.FWanSheng2.Score = _loc2_.readUnsignedInt();
               this.FWanSheng2.TotalConsumeGold = _loc2_.readUnsignedInt();
               this.FWanSheng2.ConsumeBox.Count = _loc2_.readInt();
               this.FWanSheng2.CurBoss = _loc2_.readUnsignedInt();
               this.FWanSheng2.CurHP = _loc2_.readUnsignedInt();
               this.FWanSheng2.MaxHP = _loc2_.readUnsignedInt();
               this.FWanSheng2.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng2.CheckStatus());
               this.PlayMovie(MOVIE_TYPE_BEAT_BOSS);
               break;
            case ACTIVITY_1_GET_TEN:
               this.FWanSheng2.AmountList.length = 0;
               this.FWanSheng2.IndexList.length = 0;
               this.FWanSheng2.StatusList.length = 0;
               this.FWanSheng2.CurBossList.length = 0;
               this.FWanSheng2.HpList.length = 0;
               this.FWanSheng2.MaxHpList.length = 0;
               _loc5_ = 0;
               while(_loc5_ < 10)
               {
                  this.FWanSheng2.AmountList[_loc5_] = _loc2_.readUnsignedInt();
                  this.FWanSheng2.IndexList[_loc5_] = _loc2_.readUnsignedInt();
                  this.FWanSheng2.StatusList[_loc5_] = _loc2_.readInt();
                  this.FWanSheng2.CurBossList[_loc5_] = _loc2_.readInt();
                  this.FWanSheng2.HpList[_loc5_] = _loc2_.readInt();
                  this.FWanSheng2.MaxHpList[_loc5_] = _loc2_.readInt();
                  _loc5_++;
               }
               _loc5_ = 0;
               while(_loc5_ < this.FWanSheng2.BossList.length)
               {
                  _loc13_ = this.FWanSheng2.BossList[_loc5_];
                  _loc13_.Count = _loc2_.readUnsignedInt();
                  _loc13_.Min = _loc2_.readUnsignedInt();
                  _loc5_++;
               }
               this.FWanSheng2.RankPoint = _loc2_.readUnsignedInt();
               this.FWanSheng2.ShopExchangePoint = _loc2_.readUnsignedInt();
               this.FWanSheng2.Score = _loc2_.readUnsignedInt();
               this.FWanSheng2.TotalConsumeGold = _loc2_.readUnsignedInt();
               this.FWanSheng2.ConsumeBox.Count = _loc2_.readInt();
               this.FWanSheng2.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng2.CheckStatus());
               this.PlayGameMovie();
               break;
            case ACTIVITY_1_GET_KILL_BOX:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               --this.FWanSheng2.BossList[_loc5_].Count;
               _loc12_ = _loc2_.readUnsignedInt();
               this.FWanSheng2.RankPoint += _loc12_;
               this.FWanSheng2.ShopExchangePoint += _loc12_;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc4_ = _loc4_ + (this.FWanSheng2.DescListNew[17] + "*" + _loc12_ + "\n");
               ProcessorEffectText(_loc4_);
               this.FWanSheng2.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng2.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_EXCHANGE_ITEM:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               --this.FWanSheng2.ShopExchangeItems[_loc5_].LimitCount;
               this.FWanSheng2.ShopExchangePoint = _loc2_.readUnsignedInt();
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FWanSheng2.ShopExchangeItems[_loc5_].Inventories.Count)
               {
                  _loc9_ = this.FWanSheng2.ShopExchangeItems[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               ProcessorEffectText(_loc4_);
               this.FWanSheng2.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng2.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_EXCHANGE_HERO:
               this.FWanSheng2.Hero.Status = TBaseActivity.STATUS_GETED;
               this.FWanSheng2.ShopExchangePoint -= this.FWanSheng2.Hero.Price;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
               ProcessorEffectText(_loc4_);
               this.FWanSheng2.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWanSheng2.CheckStatus());
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
            _loc4_.gotoAndStop(this.FWanSheng2.CurBoss + BOSS_COUNT + 1);
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
            if(this.FWanSheng2.CurHP <= 0)
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
         _loc3_ = int(this.FWanSheng2.StatusList.length);
         if(_loc3_ > 0)
         {
            _loc1_ = this.FWanSheng2.IndexList[0] - 1;
            this.FWanSheng2.SweetList[_loc1_].Status = this.FWanSheng2.StatusList[0];
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
               this.FWanSheng2.SweetList[_loc2_].Status = TBaseActivity.STATUS_CANNOTGET;
            }
            if(this.FWanSheng2.AmountList[0] > 0)
            {
               _loc5_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = _loc5_ + (this.FWanSheng2.DescListNew[17] + "*" + this.FWanSheng2.AmountList[0] + "\n");
               this.FWanSheng2.ChangeStatus();
               ProcessorEffectText(_loc5_);
            }
            _loc8_ = this.FWanSheng2.MaxHpList[0];
            FMC_Scene.MC_Boss.MC_Bar.TF_Count.text = this.FWanSheng2.HpList[0] + "/" + _loc8_;
            _loc6_ = Number(this.FWanSheng2.HpList[0] / _loc8_) * this.FBarMaxWidth;
            _loc7_ = Math.min(_loc6_,this.FBarMaxWidth);
            this.FMC_Mask.width = _loc7_;
            this.FWanSheng2.CurBoss = this.FWanSheng2.CurBossList[0];
            this.FWanSheng2.CurHP = this.FWanSheng2.HpList[0];
            this.FWanSheng2.MaxHP = this.FWanSheng2.MaxHpList[0];
            FMC_Scene.MC_Boss.MC_KillMovie.gotoAndStop(this.FWanSheng2.CurBossList[0]);
            this.UpdateSweet();
            this.FWanSheng2.StatusList.shift();
            this.FWanSheng2.IndexList.shift();
            this.FWanSheng2.AmountList.shift();
            this.FWanSheng2.CurBossList.shift();
            this.FWanSheng2.HpList.shift();
            this.FWanSheng2.MaxHpList.shift();
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

