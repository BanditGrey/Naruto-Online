package Processors.Game.Lobby.Exercise.JanActive
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.JanActive.TJanActive2;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIJanActive2 extends TUIBaseWindow
   {
      
      protected static const POINT_COUNT:int = 20;
      
      protected static const RECHARGE_BOX_COUNT:int = 2;
      
      protected static const EXCHANGE_BOX_COUNT:int = 6;
      
      protected static const GIFT_COUNT:int = 3;
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      public static const MOVIE_OF_WAITING:int = 0;
      
      public static const MOVIE_OF_PLAY_GAME:int = 1;
      
      public static const MOVIE_OF_BOMB:int = 2;
      
      public static const MOVIE_OF_RESET:int = 3;
      
      public static const MOVIE_OF_AUTO:int = 4;
      
      public static const MOVIE_OF_SUCCESS:int = 5;
      
      protected var FJanActive2:TJanActive2;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FOpenIndex:int;
      
      protected var FExchangeList:Vector.<TUIBaseBox>;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FUIPage1:TUIPage;
      
      protected var FTotalPage1:int;
      
      protected var FCurPage1:int;
      
      public function TUIJanActive2(param1:TUIComponent)
      {
         super(param1);
         this.FExchangeList = new Vector.<TUIBaseBox>(EXCHANGE_BOX_COUNT);
         this.FUIPage = new TUIPage(this);
         this.FUIPage1 = new TUIPage(this);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIBaseBox = null;
         var _loc5_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < POINT_COUNT)
         {
            FMC_Scene["MC_Point" + _loc2_].buttonMode = true;
            FMC_Scene["MC_Point" + _loc2_].MC_Smoke.visible = false;
            FMC_Scene["MC_Point" + _loc2_].MC_Role.visible = false;
            FMC_Scene["MC_Point" + _loc2_].MC_Bomb.visible = false;
            FMC_Scene["MC_Point" + _loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnPointUp);
            FMC_Scene["MC_Point" + _loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnPointOver);
            FMC_Scene["MC_Point" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnPointOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < RECHARGE_BOX_COUNT)
         {
            FMC_Scene["MC_Box" + _loc2_].buttonMode = true;
            FMC_Scene["MC_Box" + _loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnRechargeBoxUp);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < EXCHANGE_BOX_COUNT)
         {
            _loc4_ = new TUIBaseBox(this,1);
            _loc4_.Perform_UIDispatch(FMC_Scene["MC_Item" + _loc2_]);
            _loc4_.OnOverlay = this.SlotsOnOver;
            _loc4_.OnOut = this.SlotsOnOut;
            this.FExchangeList[_loc2_] = _loc4_;
            FMC_Scene["MC_Item" + _loc2_].BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < GIFT_COUNT)
         {
            FMC_Scene["MC_Gift" + _loc2_].MC_Box.buttonMode = true;
            FMC_Scene["MC_Gift" + _loc2_].MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
            FMC_Scene["MC_Gift" + _loc2_].MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
            FMC_Scene["MC_Gift" + _loc2_].MC_Box.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         FMC_Scene.MC_Reset.visible = false;
         FMC_Scene.MC_Hammer.visible = false;
         FMC_Scene.MC_Success.visible = false;
         FMC_Scene.MC_Tip0.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip0Over);
         FMC_Scene.MC_Tip0.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_Tip1.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip1Over);
         FMC_Scene.MC_Tip1.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.Btn_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.Btn_Right;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = RECHARGE_BOX_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.FUIPage1.ButtonPrevious.Substrate = FMC_Scene.Btn_Left1;
         this.FUIPage1.ButtonNext.Substrate = FMC_Scene.Btn_Right1;
         this.FUIPage1.TotalQuantity = this.FTotalPage1;
         this.FUIPage1.PageSize = EXCHANGE_BOX_COUNT;
         this.FUIPage1.PageIndex = 0;
         this.FCurPage1 = 0;
         this.FUIPage1.OnChangePage = this.ProcessorPageOnChange1;
         FMC_Scene.MC_Hero.buttonMode = true;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeHeroUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_ShowDesc,true);
         FMC_Scene.BTN_ShowDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroDescUp);
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,true);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.CLICK,this.ProcessorOnAutoUp);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnAutoOver);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.MC_Mask.BTN_Buy,true);
         FMC_Scene.MC_Mask.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnStartUp);
         if(FMC_Scene.BTN_Log)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
            FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
      }
      
      protected function UpdatePoint() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         if(this.FJanActive2.GameStatus == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.MC_Mask.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,false);
            _loc1_ = 0;
            while(_loc1_ < POINT_COUNT)
            {
               _loc2_ = FMC_Scene["MC_Point" + _loc1_];
               _loc2_.gotoAndStop(1);
               _loc1_++;
            }
         }
         else
         {
            FMC_Scene.MC_Mask.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,this.FJanActive2.CheckStatus());
            _loc1_ = 0;
            while(_loc1_ < POINT_COUNT)
            {
               _loc2_ = FMC_Scene["MC_Point" + _loc1_];
               if(_loc1_ < this.FJanActive2.PointList.length)
               {
                  _loc2_.visible = true;
                  _loc3_ = this.FJanActive2.PointList[_loc1_];
                  if(_loc3_ == TJanActive2.TYPE_NONE)
                  {
                     _loc2_.gotoAndStop(1);
                     _loc2_.TF_Count.text = "";
                  }
                  else
                  {
                     _loc2_.gotoAndStop(3);
                     _loc2_.TF_Count.text = "*" + this.FJanActive2.PointList[_loc1_];
                  }
               }
               else
               {
                  _loc2_.visible = false;
               }
               _loc1_++;
            }
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TBaseBox = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < GIFT_COUNT)
         {
            _loc1_ = FMC_Scene["MC_Gift" + _loc3_];
            _loc2_ = this.FJanActive2.Gift[_loc3_];
            _loc1_.TF_Desc.text = _loc2_.Desc1;
            _loc1_.TF_Count.text = "*" + _loc2_.Count.toString();
            if(_loc2_.Count > 0)
            {
               _loc1_.MC_Box.gotoAndPlay(1);
            }
            else
            {
               _loc1_.MC_Box.gotoAndStop(1);
            }
            _loc3_++;
         }
         this.FUIPage.TotalQuantity = this.FJanActive2.RechargeList.length;
         this.FUIPage.Update();
         _loc3_ = 0;
         while(_loc3_ < RECHARGE_BOX_COUNT)
         {
            _loc4_ = _loc3_ + this.FCurPage * RECHARGE_BOX_COUNT;
            _loc1_ = FMC_Scene["MC_Box" + _loc3_];
            if(_loc4_ < this.FJanActive2.RechargeList.length)
            {
               _loc1_.visible = true;
               _loc2_ = this.FJanActive2.RechargeList[_loc4_];
               _loc1_.TF_Count.text = "*" + _loc2_.Inventories.GetInventoryByIndex(0).Quantity;
               _loc1_.TF_Price.text = TUtilityString.Format(this.FJanActive2.DescListNew[5],_loc2_.Price);
               if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc1_.MC_Got.visible = false;
                  _loc1_.MC_Click.visible = false;
               }
               else if(_loc2_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc1_.MC_Got.visible = false;
                  _loc1_.MC_Click.visible = true;
               }
               else
               {
                  _loc1_.MC_Got.visible = true;
                  _loc1_.MC_Click.visible = false;
               }
            }
            else
            {
               _loc1_.visible = false;
            }
            _loc3_++;
         }
      }
      
      protected function UpdateHero() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TBaseBox = null;
         _loc1_ = FMC_Scene.MC_Hero;
         _loc2_ = this.FJanActive2.Hero;
         FMC_Scene.TF_Price.text = _loc2_.Price.toString();
         if(_loc2_.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Got.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,false);
            FMC_Scene.BTN_Exchange.visible = false;
         }
         else if(this.FJanActive2.ScoreB >= _loc2_.Price)
         {
            FMC_Scene.MC_Got.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
            FMC_Scene.BTN_Exchange.visible = true;
         }
         else
         {
            FMC_Scene.MC_Got.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,false);
            FMC_Scene.BTN_Exchange.visible = true;
         }
      }
      
      protected function UpdateExchange() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TBaseBox = null;
         this.FUIPage1.TotalQuantity = this.FJanActive2.ExchangeItems.length;
         this.FUIPage1.Update();
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_BOX_COUNT)
         {
            _loc3_ = _loc1_ + this.FCurPage1 * EXCHANGE_BOX_COUNT;
            if(_loc3_ < this.FJanActive2.ExchangeItems.length)
            {
               this.FExchangeList[_loc1_].SetVisible(true);
               _loc5_ = this.FJanActive2.ExchangeItems[_loc3_];
               this.FExchangeList[_loc1_].UpdateUI(_loc5_.Inventories);
               this.FExchangeList[_loc1_].Identify = _loc3_;
               _loc4_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc5_.LimitCount.toString());
               this.FExchangeList[_loc1_].SetLimitText(_loc4_);
               _loc4_ = _loc5_.Price.toString();
               this.FExchangeList[_loc1_].SetPriceText(_loc4_);
               if(this.FJanActive2.ScoreB < _loc5_.Price)
               {
                  if(_loc5_.LimitCount > 0)
                  {
                     this.FExchangeList[_loc1_].FMC_Got.visible = false;
                     this.FExchangeList[_loc1_].FBTN_Exchange.visible = true;
                     this.FExchangeList[_loc1_].SetExchangeBtnMode(false);
                  }
                  else
                  {
                     this.FExchangeList[_loc1_].FMC_Got.visible = true;
                     this.FExchangeList[_loc1_].FBTN_Exchange.visible = false;
                  }
               }
               else if(_loc5_.LimitCount > 0)
               {
                  this.FExchangeList[_loc1_].FMC_Got.visible = false;
                  this.FExchangeList[_loc1_].FBTN_Exchange.visible = true;
                  this.FExchangeList[_loc1_].SetExchangeBtnMode(true);
               }
               else
               {
                  this.FExchangeList[_loc1_].FMC_Got.visible = true;
                  this.FExchangeList[_loc1_].FBTN_Exchange.visible = false;
               }
            }
            else
            {
               this.FExchangeList[_loc1_].SetVisible(false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FJanActive2.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FJanActive2.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FJanActive2.DescListNew[1];
         FMC_Scene.TF_ScoreA.text = this.FJanActive2.ScoreA.toString();
         FMC_Scene.TF_ScoreB.text = this.FJanActive2.ScoreB.toString();
         FMC_Scene.TF_Desc1.text = this.FJanActive2.DescListNew[2];
         FMC_Scene.TF_RechargeGold.text = TUtilityString.Format(this.FJanActive2.DescListNew[8],this.FJanActive2.RechargeGold);
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateBox();
      }
      
      protected function ProcessorPageOnChange1(param1:Object, param2:int) : void
      {
         this.FCurPage1 = param2;
         this.UpdateExchange();
      }
      
      protected function ProcessorOnStartUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && !FIsPlaying && Boolean(this.FJanActive2))
         {
            if(this.FJanActive2.ScoreA > 0)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorJanActive.ACTIVITY_2_PLAY_GAME);
            }
            else
            {
               _loc2_ = TUtilityString.Format(this.FJanActive2.DescListNew[3],this.FJanActive2.ScorePrice);
               FOnBuyBox(ACTIVITY_2_ID,TProcessorJanActive.ACTIVITY_2_PLAY_GAME,this.FJanActive2.ScorePrice,0,0,_loc2_);
            }
         }
      }
      
      protected function ProcessorOnPointUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(Boolean(FOnBuyBox != null && !FIsPlaying) && Boolean(this.FJanActive2) && this.FJanActive2.PointList[_loc2_] == TJanActive2.TYPE_NONE)
         {
            FOnBuyBox(ACTIVITY_2_ID,TProcessorJanActive.ACTIVITY_2_FIND_TEASURE,this.FJanActive2.Price,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnAutoUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnBuyBox != null && !FIsPlaying && Boolean(this.FJanActive2))
         {
            FOnBuyBox(ACTIVITY_2_ID,TProcessorJanActive.ACTIVITY_2_AUTO_PLAY,this.FJanActive2.AutoPrice);
         }
      }
      
      protected function ProcessorOnRechargeBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         _loc3_ = _loc2_ + this.FCurPage * RECHARGE_BOX_COUNT;
         if(Boolean(FOnGetBox != null && !FIsPlaying) && Boolean(this.FJanActive2) && this.FJanActive2.RechargeList[_loc3_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorJanActive.ACTIVITY_2_GET_RECHARGE_BOX,_loc3_ + 1);
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnGetBox != null && !FIsPlaying && this.FJanActive2) && Boolean(_loc2_ < this.FJanActive2.Gift.length) && this.FJanActive2.Gift[_loc2_].Count > 0)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorJanActive.ACTIVITY_2_GET_GIFT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnExchangeHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FJanActive2))
         {
            _loc2_ = this.FJanActive2.Hero;
            if(_loc2_.Status != TBaseActivity.STATUS_GETED && this.FJanActive2.ScoreB >= _loc2_.Price)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorJanActive.ACTIVITY_2_EXCHANGE_HERO);
            }
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage1 * EXCHANGE_BOX_COUNT;
         if(Boolean(!FIsPlaying && FOnGetBox != null && this.FJanActive2 && _loc3_ < this.FJanActive2.ExchangeItems.length) && Boolean(this.FJanActive2.ExchangeItems[_loc3_].LimitCount > 0) && this.FJanActive2.ScoreB >= this.FJanActive2.ExchangeItems[_loc3_].Price)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorJanActive.ACTIVITY_2_EXCHANGE_ITEM,_loc3_ + 1);
         }
      }
      
      protected function ProcessorOnPointOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(Boolean(this.FJanActive2) && Boolean(_loc2_ < this.FJanActive2.PointList.length) && this.FJanActive2.PointList[_loc2_] == TJanActive2.TYPE_NONE)
         {
            FMC_Scene["MC_Point" + _loc2_].MC_Role.visible = true;
         }
      }
      
      protected function ProcessorOnPointOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         FMC_Scene["MC_Point" + _loc2_].MC_Role.visible = false;
      }
      
      protected function ProcessorOnRechargeBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         _loc3_ = _loc2_ + this.FCurPage * RECHARGE_BOX_COUNT;
         if(FOnGetBox != null && Boolean(this.FJanActive2))
         {
            FOnNewBoxOver(this.FJanActive2.RechargeList[_loc3_].Inventories);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnNewBoxOver != null && !FIsPlaying) && Boolean(this.FJanActive2) && _loc2_ < this.FJanActive2.Gift.length)
         {
            FOnNewBoxOver(this.FJanActive2.Gift[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnTip0Over(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FJanActive2) && this.FJanActive2.DescList.length > 9)
         {
            FOnShowHtmlTip(this.FJanActive2.DescListNew[9]);
         }
      }
      
      protected function ProcessorOnTip1Over(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FJanActive2) && this.FJanActive2.DescList.length > 10)
         {
            FOnShowHtmlTip(this.FJanActive2.DescListNew[10]);
         }
      }
      
      protected function ProcessorOnAutoOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FJanActive2) && this.FJanActive2.DescList.length > 11)
         {
            FOnShowHtmlTip(this.FJanActive2.DescListNew[11]);
         }
      }
      
      protected function ProcessorOnHeroDescUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FJanActive2) && Boolean(this.FJanActive2.Hero))
         {
            _loc2_ = this.FJanActive2.Hero;
            FOnShowRecruit(_loc2_.Identify,_loc2_.Type);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FJanActive2))
         {
            FOnShowHtmlTip(this.FJanActive2.DescListNew[4]);
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(this,param2);
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int) : void
      {
         if(FOnShowRecruit != null)
         {
            FOnShowRecruit(param1,param2);
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_2_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
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
            if(FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_OF_WAITING:
                     return;
                  case MOVIE_OF_RESET:
                     CurFrame = FMC_Scene.MC_Reset.currentFrame;
                     break;
                  case MOVIE_OF_PLAY_GAME:
                     CurFrame = FMC_Scene["MC_Point" + this.FOpenIndex].MC_Smoke.currentFrame;
                     break;
                  case MOVIE_OF_BOMB:
                     CurFrame = FMC_Scene["MC_Point" + this.FOpenIndex].MC_Bomb.currentFrame;
                     break;
                  case MOVIE_OF_AUTO:
                     CurFrame = FMC_Scene.MC_Hammer.currentFrame;
                     break;
                  case MOVIE_OF_SUCCESS:
                     CurFrame = FMC_Scene.MC_Success.currentFrame;
               }
               if(CurFrame == FTotalFrame)
               {
                  FIsPlaying = false;
                  this.FFrameCount = 0;
                  this.MovieEnd();
               }
               else
               {
                  ++this.FFrameCount;
                  if(this.FFrameCount > 100)
                  {
                     FIsPlaying = false;
                     this.FFrameCount = 0;
                     this.UpdateUI();
                  }
               }
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FJanActive2 = SLogicsCore.JanActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TJanActive2;
         this.UpdatePoint();
         this.UpdateBox();
         this.UpdateHero();
         this.UpdateExchange();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         FIsPlaying = true;
         this.FMovieType = param1;
         if(this.FMovieType == MOVIE_OF_PLAY_GAME)
         {
            _loc4_ = FMC_Scene["MC_Point" + this.FOpenIndex].MC_Smoke;
            _loc4_.visible = true;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_BOMB)
         {
            FMC_Scene["MC_Point" + this.FOpenIndex].gotoAndStop(2);
            _loc4_ = FMC_Scene["MC_Point" + this.FOpenIndex].MC_Bomb;
            _loc4_.visible = true;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_AUTO)
         {
            _loc4_ = FMC_Scene.MC_Hammer;
            _loc4_.visible = true;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_SUCCESS)
         {
            _loc4_ = FMC_Scene.MC_Success;
            _loc4_.visible = true;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_RESET)
         {
            _loc4_ = FMC_Scene.MC_Reset;
            _loc4_.visible = true;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_WAITING)
         {
            setTimeout(this.MovieEnd,2000);
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         FIsPlaying = false;
         if(this.FMovieType == MOVIE_OF_PLAY_GAME)
         {
            if(this.FJanActive2.PointList[this.FOpenIndex] == TJanActive2.TYPE_BOMB)
            {
               this.PlayMovie(MOVIE_OF_BOMB);
            }
            else if(this.FJanActive2.GameStatus == TBaseActivity.STATUS_CANNOTGET)
            {
               FMC_Scene["MC_Point" + this.FOpenIndex].gotoAndStop(3);
               FMC_Scene["MC_Point" + this.FOpenIndex].TF_Count.text = "*" + this.FJanActive2.PointList[_loc1_];
               _loc1_ = 0;
               while(_loc1_ < this.FJanActive2.PointList.length)
               {
                  this.FJanActive2.PointList[_loc1_] = TJanActive2.TYPE_NONE;
                  _loc1_++;
               }
               this.PlayMovie(MOVIE_OF_SUCCESS);
            }
            else
            {
               this.UpdateUI();
            }
         }
         else if(this.FMovieType == MOVIE_OF_BOMB)
         {
            FMC_Scene["MC_Point" + this.FOpenIndex].MC_Bomb.visible = false;
            _loc1_ = 0;
            while(_loc1_ < this.FJanActive2.PointList.length)
            {
               this.FJanActive2.PointList[_loc1_] = TJanActive2.TYPE_NONE;
               _loc1_++;
            }
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_AUTO)
         {
            FMC_Scene.MC_Hammer.visible = false;
            _loc1_ = 0;
            while(_loc1_ < this.FJanActive2.PointList.length)
            {
               FMC_Scene["MC_Point" + _loc1_].MC_Smoke.visible = false;
               if(this.FJanActive2.PointList[_loc1_] == TJanActive2.TYPE_BOMB)
               {
                  FMC_Scene["MC_Point" + _loc1_].gotoAndStop(2);
                  FMC_Scene["MC_Point" + _loc1_].TF_Count.text = "";
               }
               else
               {
                  FMC_Scene["MC_Point" + _loc1_].gotoAndStop(3);
                  FMC_Scene["MC_Point" + _loc1_].TF_Count.text = "*" + this.FJanActive2.PointList[_loc1_];
               }
               _loc1_++;
            }
            this.PlayMovie(MOVIE_OF_SUCCESS);
            FOnShowFlowText(FFlowStr);
         }
         else if(this.FMovieType == MOVIE_OF_SUCCESS)
         {
            FMC_Scene.MC_Success.visible = false;
            _loc1_ = 0;
            while(_loc1_ < this.FJanActive2.PointList.length)
            {
               this.FJanActive2.PointList[_loc1_] = TJanActive2.TYPE_NONE;
               _loc1_++;
            }
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_WAITING)
         {
            this.PlayMovie(MOVIE_OF_RESET);
         }
         else if(this.FMovieType == MOVIE_OF_RESET)
         {
            FMC_Scene.MC_Reset.visible = false;
            _loc1_ = 0;
            while(_loc1_ < this.FJanActive2.PointList.length)
            {
               this.FJanActive2.PointList[_loc1_] = TJanActive2.TYPE_NONE;
               _loc1_++;
            }
            this.UpdateUI();
         }
      }
      
      override public function Unmount() : void
      {
         var _loc1_:int = 0;
         TweenUtil.removeAllTween();
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FOpenIndex = param1;
      }
   }
}

