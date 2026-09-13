package Processors.Game.Lobby.Exercise.AugustActive.Compoents
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.AugustActive.TAugustActive2;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.AugustActive.TProcessorAugustActive;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.FebActive.TProcessorFebActiveShop;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIAugustActive2 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 4;
      
      protected static const EXCHANGE_BOX_COUNT:int = 3;
      
      protected static const CARD_COUNT:int = 40;
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      protected static const MOVIE_TYPE_OPEN_CARD:int = 1;
      
      protected static const MOVIE_TYPE_OPEN_ALL_CARD:int = 2;
      
      protected static const MOVIE_TYPE_RESET:int = 3;
      
      protected static const MOVIE_TYPE_CLEAR:int = 4;
      
      protected static const MOVIE_TYPE_CLOSE_CARD:int = 5;
      
      protected var FAugustActive2:TAugustActive2;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FCardList:Vector.<MovieClip>;
      
      protected var FExchangeList:Vector.<MovieClip>;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FCurIndex:int;
      
      protected var FCurType:int;
      
      protected var FLastIndex:int;
      
      protected var FMovieType:int;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      protected var FFrameCount:int;
      
      public function TUIAugustActive2(param1:TUIComponent)
      {
         super(param1);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FCardList = new Vector.<MovieClip>(CARD_COUNT);
         this.FExchangeList = new Vector.<MovieClip>(EXCHANGE_BOX_COUNT);
         this.FUIPage = new TUIPage(this);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < CARD_COUNT)
         {
            this.FCardList[_loc2_] = FMC_Scene.MC_Cards["MC_Card" + _loc2_];
            this.FCardList[_loc2_].buttonMode = true;
            this.FCardList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenCardUp);
            this.FCardList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnCardOver);
            this.FCardList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene["MC_Box" + _loc2_];
            this.FBoxList[_loc2_].buttonMode = true;
            this.FBoxList[_loc2_].MC_Icon.gotoAndStop(_loc2_ + 1);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxRewardOver);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < EXCHANGE_BOX_COUNT)
         {
            this.FExchangeList[_loc2_] = FMC_Scene["MC_Item" + _loc2_];
            this.FExchangeList[_loc2_].buttonMode = true;
            this.FExchangeList[_loc2_].MC_Box.MC_Icon.gotoAndStop(_loc2_ + 1);
            this.FExchangeList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeItem);
            this.FExchangeList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnExchangeItemOver);
            this.FExchangeList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         FMC_Scene.MC_Movie2.visible = false;
         FMC_Scene.MC_Effect.visible = false;
         FMC_Scene.MC_Hero.MC_Hero.buttonMode = true;
         TGameUtil.setButtonMode(FMC_Scene.MC_Hero.BTN_Get,true);
         FMC_Scene.MC_Hero.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeHeroUp);
         FMC_Scene.MC_Hero.MC_Hero.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroDescUp);
         FMC_Scene.MC_Hero.MC_Hero.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         FMC_Scene.MC_Hero.MC_Hero.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Again,true);
         FMC_Scene.BTN_Again.addEventListener(MouseEvent.CLICK,this.ProcessorOnAgainUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_AllOpen,true);
         FMC_Scene.BTN_AllOpen.addEventListener(MouseEvent.CLICK,this.ProcessorOnAllOpenUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_EquipDesc,true);
         FMC_Scene.BTN_EquipDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowEquipDesc1);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = this.ProcessorOnItemOver;
         this.FProcessorFebActiveShop.OnOut = this.ProcessorOnItemOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorFebActiveShop.X = -142;
         this.FProcessorFebActiveShop.y = -36;
         this.FMC_Mask = FMC_Scene.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
         TweenUtil.to(this.FMC_Mask,1000,{"width":0});
      }
      
      protected function UpdateCard() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < CARD_COUNT)
         {
            _loc3_ = this.FCardList[_loc1_];
            _loc5_ = this.FAugustActive2.CardList[_loc1_];
            _loc3_.MC_Card.MC_ClearMovie.visible = false;
            if(_loc5_ == -1)
            {
               _loc3_.visible = false;
            }
            else
            {
               _loc3_.visible = true;
               if(_loc5_ == 0)
               {
                  _loc3_.MC_Card.MC_Icon.visible = false;
                  _loc3_.MC_Card.gotoAndStop(1);
               }
               else
               {
                  _loc3_.MC_Card.MC_Icon.visible = true;
                  _loc3_.MC_Card.MC_Icon.gotoAndStop(_loc5_);
                  _loc3_.MC_Card.gotoAndStop(_loc3_.MC_Card.totalFrames);
               }
            }
            _loc1_++;
         }
         if(this.FAugustActive2.CardList.indexOf(0) == -1)
         {
            FMC_Scene.MC_OnceMore.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_AllOpen,false);
         }
         else
         {
            FMC_Scene.MC_OnceMore.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_AllOpen,true);
         }
         FMC_Scene.MC_Movie2.visible = false;
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            _loc4_ = this.FAugustActive2.BoxList[_loc1_];
            _loc3_.TF_Count.text = this.FAugustActive2.BoxScore + "/" + _loc4_.Price;
            if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_.MC_Got.visible = false;
               _loc3_.gotoAndStop(1);
               _loc3_.MC_CanGet.visible = false;
               _loc3_.MC_Icon.gotoAndStop(_loc1_ + 1);
            }
            else if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.MC_Got.visible = false;
               _loc3_.gotoAndPlay(1);
               _loc3_.MC_CanGet.visible = true;
               _loc3_.MC_Icon.gotoAndStop(_loc1_ + 1);
            }
            else
            {
               _loc3_.MC_Got.visible = true;
               _loc3_.gotoAndStop(1);
               _loc3_.MC_CanGet.visible = false;
               _loc3_.MC_Icon.gotoAndStop(_loc1_ + 1 + BOX_COUNT);
            }
            _loc1_++;
         }
         _loc5_ = Number(this.FAugustActive2.BoxScore / _loc4_.Price) * this.FBarMaxWidth;
         _loc6_ = Math.min(_loc5_,this.FBarMaxWidth);
         TweenUtil.to(this.FMC_Mask,1000,{"width":_loc6_});
      }
      
      protected function UpdateItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_BOX_COUNT)
         {
            _loc3_ = this.FExchangeList[_loc1_];
            _loc4_ = this.FAugustActive2.ShopExchangeItems[_loc1_];
            _loc3_.TF_Price.text = _loc4_.Price;
            _loc3_.TF_Limit.text = _loc4_.LimitCount;
            if(this.FAugustActive2.ShopExchangePoint >= _loc4_.Price && _loc4_.LimitCount > 0)
            {
               _loc3_.MC_Box.MC_Icon.gotoAndPlay(1);
               _loc3_.BTN_Buy.visible = true;
               TGameUtil.setButtonMode(_loc3_,true);
            }
            else
            {
               _loc3_.MC_Box.MC_Icon.gotoAndStop(1);
               _loc3_.BTN_Buy.visible = false;
               TGameUtil.setButtonMode(_loc3_,false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateHero() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TBaseBox = null;
         _loc1_ = FMC_Scene.MC_Hero;
         _loc2_ = this.FAugustActive2.Hero;
         _loc1_.TF_Price.text = _loc2_.Price.toString();
         if(_loc2_.Status == TBaseActivity.STATUS_GETED)
         {
            _loc1_.MC_Got.visible = true;
            TGameUtil.setButtonMode(_loc1_.BTN_Get,false);
         }
         else if(this.FAugustActive2.ShopExchangePoint >= _loc2_.Price)
         {
            _loc1_.MC_Got.visible = false;
            TGameUtil.setButtonMode(_loc1_.BTN_Get,true);
         }
         else
         {
            _loc1_.MC_Got.visible = false;
            TGameUtil.setButtonMode(_loc1_.BTN_Get,false);
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FAugustActive2.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FAugustActive2.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FAugustActive2.DescListNew[1];
         FMC_Scene.MC_FreeCount.TF_FreeCount.text = this.FAugustActive2.FreeCount.toString();
         FMC_Scene.TF_Score.text = this.FAugustActive2.ShopExchangePoint.toString();
         _loc1_ = this.FAugustActive2.NextAwardDiff;
         if(_loc1_ > 0)
         {
            FMC_Scene.TF_Desc1.text = TUtilityString.Format(this.FAugustActive2.DescListNew[3],_loc1_);
         }
         else
         {
            FMC_Scene.TF_Desc1.text = this.FAugustActive2.DescListNew[4];
         }
      }
      
      protected function ProcessorOnOpenCardUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(FIsPlaying)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnBuyBox != null) && Boolean(this.FAugustActive2) && this.FAugustActive2.CardList[_loc2_] == 0)
         {
            if(this.FAugustActive2.FreeCount > 0)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorAugustActive.ACTIVITY_2_OPEN_CARD,_loc2_ + 1);
            }
            else
            {
               FOnBuyBox(ACTIVITY_2_ID,TProcessorAugustActive.ACTIVITY_2_OPEN_CARD,this.FAugustActive2.CardPrice,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnAgainUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(FIsPlaying)
         {
            return;
         }
         if(FOnBuyBox != null && Boolean(this.FAugustActive2))
         {
            if(this.FAugustActive2.IsBoxAllGet())
            {
               _loc2_ = TUtilityString.Format(this.FAugustActive2.DescListNew[7],this.FAugustActive2.AgainPrice);
               FOnGetBox(ACTIVITY_2_ID,TProcessorAugustActive.ACTIVITY_2_RESET);
            }
            else
            {
               FOnShowFlowText(this.FAugustActive2.DescListNew[6]);
            }
         }
      }
      
      protected function ProcessorOnAllOpenUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!param1.currentTarget.buttonMode || FIsPlaying)
         {
            return;
         }
         if(FOnBuyBox != null && Boolean(this.FAugustActive2))
         {
            _loc2_ = TUtilityString.Format(this.FAugustActive2.DescListNew[2],this.FAugustActive2.OpenAllCount * this.FAugustActive2.AllOpenPrice,this.FAugustActive2.OpenAllCount + this.FAugustActive2.FreeCount,this.FAugustActive2.AllOpenPrice);
            if(this.FAugustActive2.OpenAllCount > 0)
            {
               FOnBuyBox(ACTIVITY_2_ID,TProcessorAugustActive.ACTIVITY_2_OPEN_ALL_CARD,this.FAugustActive2.OpenAllCount * this.FAugustActive2.AllOpenPrice,0,0,_loc2_);
            }
            else
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorAugustActive.ACTIVITY_2_OPEN_ALL_CARD);
            }
         }
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(FIsPlaying)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnGetBox != null && this.FAugustActive2) && Boolean(_loc2_ < this.FAugustActive2.BoxList.length) && this.FAugustActive2.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorAugustActive.ACTIVITY_2_GET_SCORE_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnExchangeHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(!param1.currentTarget.buttonMode || FIsPlaying)
         {
            return;
         }
         if(FOnGetBox != null && Boolean(this.FAugustActive2))
         {
            _loc2_ = this.FAugustActive2.Hero;
            if(_loc2_.Status != TBaseActivity.STATUS_GETED && this.FAugustActive2.ShopExchangePoint >= _loc2_.Price)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorAugustActive.ACTIVITY_2_EXCHANGE_HERO,0);
            }
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FAugustActive2))
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorAugustActive.ACTIVITY_2_EXCHANGE_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnCardOver(param1:MouseEvent) : void
      {
      }
      
      protected function ProcessorOnBoxRewardOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FAugustActive2) && _loc2_ < this.FAugustActive2.BoxList.length)
         {
            FOnNewBoxOver(this.FAugustActive2.BoxList[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnExchangeItemOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FAugustActive2) && _loc2_ < this.FAugustActive2.ShopExchangeItems.length)
         {
            FOnNewBoxOver(this.FAugustActive2.ShopExchangeItems[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnHeroDescUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FAugustActive2) && Boolean(this.FAugustActive2.Hero))
         {
            _loc2_ = this.FAugustActive2.Hero;
            FOnShowRecruit(_loc2_.Identify,_loc2_.Type);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FAugustActive2) && this.FAugustActive2.DescList.length > 5)
         {
            FOnShowHtmlTip(this.FAugustActive2.DescListNew[5]);
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
      
      protected function ProcessorOnShowEquipDesc1(param1:MouseEvent) : void
      {
         if(FOnShowWindow != null)
         {
            FOnShowWindow(TProcessorAugustActive.WINDOW_EQUIPMENT_DESC);
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI(this.FAugustActive2);
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorFebActiveShop.Visible = false;
      }
      
      protected function ProcessorOnItemOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(param1,param2);
         }
      }
      
      protected function ProcessorOnItemOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(param1,param2);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         if(FInitialized && this.visible)
         {
            if(FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_TYPE_OPEN_CARD:
                     CurFrame = this.FCardList[this.FCurIndex].MC_Card.currentFrame;
                     break;
                  case MOVIE_TYPE_OPEN_ALL_CARD:
                     CurFrame = FMC_Scene.MC_Movie2.currentFrame;
                     break;
                  case MOVIE_TYPE_RESET:
                     CurFrame = this.FCardList[0].MC_Card.currentFrame;
                     break;
                  case MOVIE_TYPE_CLEAR:
                     CurFrame = this.FCardList[this.FCurIndex].MC_Card.MC_ClearMovie.currentFrame;
                     break;
                  case MOVIE_TYPE_CLOSE_CARD:
                     CurFrame = this.FCardList[this.FLastIndex].MC_Card.currentFrame;
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
         this.FAugustActive2 = SLogicsCore.AugustActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TAugustActive2;
         this.UpdateCard();
         this.UpdateBox();
         this.UpdateItem();
         this.UpdateHero();
         this.UpdateText();
         if(FIsFirstLoad)
         {
            FIsFirstLoad = false;
            this.FProcessorFebActiveShop.Load();
         }
         if(this.FProcessorFebActiveShop.Visible)
         {
         }
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FCurIndex = param1;
         this.FCurType = param2;
         this.FLastIndex = param3;
         this.PlayMovie(MOVIE_TYPE_OPEN_CARD);
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         FIsPlaying = true;
         this.FMovieType = param1;
         switch(this.FMovieType)
         {
            case MOVIE_TYPE_OPEN_CARD:
               _loc5_ = this.FCardList[this.FCurIndex].MC_Card;
               _loc5_.gotoAndPlay(1);
               _loc5_.MC_Icon.visible = true;
               _loc5_.MC_Icon.gotoAndStop(this.FCurType);
               FTotalFrame = _loc5_.totalFrames;
               break;
            case MOVIE_TYPE_OPEN_ALL_CARD:
               _loc5_ = FMC_Scene.MC_Movie2;
               _loc5_.gotoAndPlay(1);
               _loc5_.visible = true;
               FTotalFrame = _loc5_.totalFrames;
               _loc3_ = 0;
               while(_loc3_ < this.FCardList.length)
               {
                  if(this.FAugustActive2.CardList[_loc3_] == 0)
                  {
                     _loc5_ = this.FCardList[_loc3_].MC_Card;
                     _loc5_.gotoAndPlay(1);
                     _loc5_.MC_Icon.visible = true;
                     _loc5_.MC_Icon.gotoAndStop(this.FAugustActive2.Card2List[_loc3_]);
                  }
                  _loc3_++;
               }
               break;
            case MOVIE_TYPE_RESET:
               FMC_Scene.MC_OnceMore.visible = false;
               _loc3_ = 0;
               while(_loc3_ < this.FCardList.length)
               {
                  this.FCardList[_loc3_].visible = true;
                  _loc5_ = this.FCardList[_loc3_].MC_Card;
                  _loc5_.gotoAndPlay(1);
                  _loc5_.MC_Icon.visible = false;
                  FTotalFrame = _loc5_.totalFrames;
                  _loc3_++;
               }
               break;
            case MOVIE_TYPE_CLEAR:
               _loc5_ = this.FCardList[this.FCurIndex].MC_Card.MC_ClearMovie;
               _loc5_.gotoAndPlay(1);
               _loc5_.visible = true;
               _loc5_ = this.FCardList[this.FLastIndex].MC_Card.MC_ClearMovie;
               _loc5_.gotoAndPlay(1);
               _loc5_.visible = true;
               FTotalFrame = _loc5_.totalFrames;
               break;
            case MOVIE_TYPE_CLOSE_CARD:
               _loc5_ = this.FCardList[this.FCurIndex].MC_Card;
               _loc5_.gotoAndPlay(1);
               _loc5_.MC_Icon.visible = false;
               _loc5_ = this.FCardList[this.FLastIndex].MC_Card;
               _loc5_.gotoAndPlay(1);
               _loc5_.MC_Icon.visible = false;
               FTotalFrame = _loc5_.totalFrames;
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         switch(this.FMovieType)
         {
            case MOVIE_TYPE_OPEN_CARD:
               if(this.FLastIndex == -1)
               {
                  this.FAugustActive2.CardList[this.FCurIndex] = this.FCurType;
                  _loc3_ = this.FCardList[this.FCurIndex].MC_Card.gotoAndStop(FTotalFrame);
                  this.UpdateUI();
               }
               else if(this.FCurType == this.FAugustActive2.CardList[this.FLastIndex])
               {
                  this.PlayMovie(MOVIE_TYPE_CLEAR);
               }
               else
               {
                  this.PlayMovie(MOVIE_TYPE_CLOSE_CARD);
               }
               break;
            case MOVIE_TYPE_OPEN_ALL_CARD:
               _loc1_ = 0;
               while(_loc1_ < this.FAugustActive2.CardList.length)
               {
                  this.FAugustActive2.CardList[_loc1_] = -1;
                  _loc1_++;
               }
               this.UpdateUI();
               break;
            case MOVIE_TYPE_RESET:
               this.UpdateUI();
               break;
            case MOVIE_TYPE_CLEAR:
               this.FAugustActive2.CardList[this.FCurIndex] = -1;
               this.FAugustActive2.CardList[this.FLastIndex] = -1;
               FMC_Scene.MC_Effect.visible = true;
               FMC_Scene.MC_Effect.gotoAndPlay(1);
               this.UpdateUI();
               break;
            case MOVIE_TYPE_CLOSE_CARD:
               this.FAugustActive2.CardList[this.FCurIndex] = 0;
               this.FAugustActive2.CardList[this.FLastIndex] = 0;
               this.UpdateUI();
         }
      }
   }
}

