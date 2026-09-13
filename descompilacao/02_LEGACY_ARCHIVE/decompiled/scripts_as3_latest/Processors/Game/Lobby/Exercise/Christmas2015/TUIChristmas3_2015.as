package Processors.Game.Lobby.Exercise.Christmas2015
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.Christmas2015.TChristmas3_2015;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.FebActive.TProcessorFebActiveShop;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIChristmas3_2015 extends TUIBaseWindow
   {
      
      protected static const BOOK_COUNT:int = 3;
      
      protected static const BADGE_COUNT:int = 6;
      
      protected static const BOX_COUNT:int = 4;
      
      protected static const ICE_COUNT:int = 24;
      
      protected static const SHEAR_COUNT:int = 3;
      
      protected static const BAR_COUNT:int = 5;
      
      protected static const SOCK_COUNT:int = 10;
      
      protected static const ACTIVITY_3_ID:int = 3;
      
      public static const MOVIE_OF_BREAK_ICE:int = 1;
      
      public static const MOVIE_OF_NONE:int = 2;
      
      public static const MOVIE_OF_AUTO:int = 3;
      
      public static const MOVIE_OF_REFRESH:int = 4;
      
      public static const MOVIE_OF_SHEAR:int = 5;
      
      public static const MOVIE_OF_CHOICE_SHEAR:int = 6;
      
      public static const MOVIE_OF_USE_SHEAR:int = 7;
      
      public static const MOVIE_OF_SOCK_NULL:int = 8;
      
      public static const MOVIE_OF_SOCK_FALL:int = 9;
      
      public static const MOVIE_OF_GAME_WIN:int = 10;
      
      public static const MOVIE_OF_GAME_LOSE:int = 11;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 10;
      
      public static const FilterGlowStrength:int = 10;
      
      protected var FChristmas3_2015:TChristmas3_2015;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      protected var FInitX:int;
      
      protected var FInitY:int;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FOpenIndex:int;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxHeight:int;
      
      protected var FGlowFilter:TEffectBaseGlowTwo;
      
      public function TUIChristmas3_2015(param1:TUIComponent)
      {
         super(param1);
         this.FUIPage = new TUIPage(this);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < BOOK_COUNT)
         {
            _loc5_ = FMC_Scene["MC_Book" + _loc2_];
            _loc5_.MC_Icon0.gotoAndStop(_loc2_ + 1);
            _loc5_.MC_Icon1.gotoAndStop(_loc2_ + 1);
            _loc5_.MC_Icon2.gotoAndStop(_loc2_ + 1);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < ICE_COUNT)
         {
            FMC_Scene.MC_Ice["MC_Ice" + _loc2_].buttonMode = true;
            FMC_Scene.MC_Ice["MC_Ice" + _loc2_].MC_Movie.visible = false;
            FMC_Scene.MC_Ice["MC_Ice" + _loc2_].MC_Smoke.visible = false;
            FMC_Scene.MC_Ice["MC_Ice" + _loc2_].MC_Item.visible = false;
            FMC_Scene.MC_Ice["MC_Ice" + _loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnIceUp);
            FMC_Scene.MC_Ice["MC_Ice" + _loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnIceOver);
            FMC_Scene.MC_Ice["MC_Ice" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnIceOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < SHEAR_COUNT)
         {
            FMC_Scene.MC_Desc["MC_Shear" + _loc2_].buttonMode = true;
            FMC_Scene.MC_Desc["MC_Shear" + _loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnChoiceShear);
            FMC_Scene.MC_Desc["MC_Shear" + _loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnShearOver);
            FMC_Scene.MC_Desc["MC_Shear" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < SOCK_COUNT)
         {
            _loc5_ = FMC_Scene.MC_Game["MC_Sock" + _loc2_];
            _loc5_.buttonMode = true;
            _loc5_.MC_Icon.gotoAndStop(_loc2_ + 1);
            _loc5_.addEventListener(MouseEvent.CLICK,this.ProcessorOnSockUp);
            _loc2_++;
         }
         this.FShowItem = new TUIShowItem(this,BOX_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItem);
         this.FShowItem.OnOverlay = this.ProcessorOnItemOver;
         this.FShowItem.OnOut = this.ProcessorOnItemOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         FMC_Scene.MC_RechargeBox.MC_GoldPic.buttonMode = true;
         FMC_Scene.MC_RechargeBox.MC_GoldPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnRechargeBoxUp);
         FMC_Scene.MC_RechargeBox.MC_GoldPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnRechargeBoxOver);
         FMC_Scene.MC_RechargeBox.MC_GoldPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_RechargeBox.BTN_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_RechargeBox.BTN_Right;
         this.FUIPage.PageSize = 1;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         FMC_Scene.MC_Desc.BTN_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnCloseDesc);
         FMC_Scene.MC_Game.BTN_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnCloseGame);
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
         this.FProcessorFebActiveShop.Visible = false;
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = this.ProcessorOnItemOver;
         this.FProcessorFebActiveShop.OnOut = this.ProcessorOnItemOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorFebActiveShop.X = 0;
         this.FProcessorFebActiveShop.y = 0;
         this.FMC_Mask = FMC_Scene.MC_Game.MC_Bar.MC_Mask;
         this.FBarMaxHeight = this.FMC_Mask.height;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Enter,true);
         FMC_Scene.BTN_Enter.addEventListener(MouseEvent.CLICK,this.ProcessorOnEnterUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,true);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.CLICK,this.ProcessorOnAutoUp);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.MOUSE_OVER,this.ProcessorOnAutoOver);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGainUp);
         TGameUtil.setButtonMode(FMC_Scene.MC_Desc.BTN_Start,true);
         FMC_Scene.MC_Desc.BTN_Start.addEventListener(MouseEvent.CLICK,this.ProcessorOnStartUp);
         FMC_Scene.MC_Movie0.visible = false;
         FMC_Scene.MC_Game.MC_Win.visible = false;
         FMC_Scene.MC_Game.MC_Lose.visible = false;
         FMC_Scene.MC_Desc.MC_Movie.visible = false;
         FMC_Scene.MC_Desc.visible = false;
         FMC_Scene.MC_Game.visible = false;
         this.FGlowFilter = new TEffectBaseGlowTwo();
         this.FGlowFilter.SetParameters(FMC_Scene.BTN_Enter,FilterColor,FilterGlowWidth,FilterGlowStrength);
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FChristmas3_2015.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FChristmas3_2015.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FChristmas3_2015.DescListNew[1];
         FMC_Scene.TF_Desc1.text = TUtilityString.Format(this.FChristmas3_2015.DescListNew[8],this.FChristmas3_2015.FreeCount);
         FMC_Scene.TF_Desc2.text = TUtilityString.Format(this.FChristmas3_2015.DescListNew[6],this.FChristmas3_2015.LimitCount);
         FMC_Scene.TF_Desc3.text = TUtilityString.Format(this.FChristmas3_2015.DescListNew[7],this.FChristmas3_2015.Gain);
         FMC_Scene.TF_Desc4.text = TUtilityString.Format(this.FChristmas3_2015.DescListNew[2],this.FChristmas3_2015.BadgeCost);
         FMC_Scene.TF_Desc5.text = this.FChristmas3_2015.BadgeCount.toString();
         FMC_Scene.TF_Score0.text = this.FChristmas3_2015.RankPoint.toString();
         FMC_Scene.TF_Score1.text = this.FChristmas3_2015.ShopExchangePoint.toString();
      }
      
      protected function UpdateIce() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < ICE_COUNT)
         {
            FMC_Scene.MC_Ice["MC_Ice" + _loc1_].MC_Smoke.visible = false;
            if(this.FChristmas3_2015.IceList[_loc1_] == 0)
            {
               FMC_Scene.MC_Ice["MC_Ice" + _loc1_].MC_Ice.visible = true;
               FMC_Scene.MC_Ice["MC_Ice" + _loc1_].MC_Item.visible = false;
            }
            else
            {
               FMC_Scene.MC_Ice["MC_Ice" + _loc1_].MC_Ice.visible = false;
               FMC_Scene.MC_Ice["MC_Ice" + _loc1_].MC_Item.visible = true;
               FMC_Scene.MC_Ice["MC_Ice" + _loc1_].MC_Item.gotoAndStop(this.FChristmas3_2015.IceList[_loc1_]);
            }
            _loc1_++;
         }
         if(this.FChristmas3_2015.IsBegin)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
            TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,false);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,false);
            TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,true);
         }
         FMC_Scene.MC_Movie0.visible = false;
         FMC_Scene.MC_Movie0.stop();
      }
      
      protected function UpdateBook() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < BOOK_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Book" + _loc1_];
            _loc2_.TF_Count.text = "*" + this.FChristmas3_2015.BookList[_loc1_];
            _loc1_++;
         }
      }
      
      protected function UpdateBadge() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < BADGE_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Badge" + _loc1_];
            if(_loc1_ < this.FChristmas3_2015.BadgeCount)
            {
               _loc2_.filters = [];
            }
            else
            {
               _loc2_.filters = [TGameUtil.GaryColorFilters];
            }
            _loc1_++;
         }
         if(this.FChristmas3_2015.BadgeCount >= this.FChristmas3_2015.BadgeCost || this.FChristmas3_2015.ShearIndex > 0)
         {
            this.FGlowFilter.IsRunOver = false;
         }
         else
         {
            this.FGlowFilter.Stop();
         }
      }
      
      protected function UpdateRechargeBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:int = 0;
         this.FShowItem.UpdateUI(this.FChristmas3_2015.ShowItem);
         this.FUIPage.TotalQuantity = this.FChristmas3_2015.RechargeBox.length;
         this.FUIPage.Update();
         _loc1_ = this.FCurPage;
         _loc3_ = this.FChristmas3_2015.RechargeBox[_loc1_];
         _loc2_ = FMC_Scene.MC_RechargeBox;
         _loc2_.MC_GoldPic.gotoAndStop(_loc1_ + 1);
         _loc2_.TF_Desc0.text = TUtilityString.Format(this.FChristmas3_2015.DescListNew[3],this.FChristmas3_2015.TotalRechargeGold);
         _loc2_.TF_Desc1.text = TUtilityString.Format(this.FChristmas3_2015.DescListNew[4],_loc3_.Price);
         _loc2_.TF_Count.text = "*" + _loc3_.Inventories.GetInventoryByIndex(0).Quantity;
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
      }
      
      protected function UpdateDesc() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         if(this.FChristmas3_2015.ShearIndex == 0)
         {
            FMC_Scene.MC_Desc.visible = true;
            FMC_Scene.MC_Game.visible = false;
            FMC_Scene.MC_Desc.TF_Desc0.text = this.FChristmas3_2015.DescListNew[12];
            FMC_Scene.MC_Desc.TF_Desc1.text = this.FChristmas3_2015.DescListNew[25];
            _loc1_ = 0;
            while(_loc1_ < SHEAR_COUNT)
            {
               _loc2_ = FMC_Scene.MC_Desc["MC_Shear" + _loc1_];
               _loc2_.gotoAndStop(1);
               _loc2_.MC_Icon.gotoAndStop(_loc1_ + 1);
               FMC_Scene.MC_Desc["TF_Tip" + _loc1_].text = this.FChristmas3_2015.DescListNew[13 + _loc1_];
               _loc1_++;
            }
            if(this.FChristmas3_2015.BadgeCount >= this.FChristmas3_2015.BadgeCost)
            {
               TGameUtil.setButtonMode(FMC_Scene.MC_Desc.BTN_Start,true);
            }
            else
            {
               TGameUtil.setButtonMode(FMC_Scene.MC_Desc.BTN_Start,false);
            }
         }
         else if(this.FChristmas3_2015.ShearIndex < 0)
         {
            FMC_Scene.MC_Desc.visible = true;
            FMC_Scene.MC_Game.visible = false;
            FMC_Scene.MC_Desc.TF_Desc0.text = this.FChristmas3_2015.DescListNew[12];
            FMC_Scene.MC_Desc.TF_Desc1.text = this.FChristmas3_2015.DescListNew[25];
            _loc1_ = 0;
            while(_loc1_ < SHEAR_COUNT)
            {
               _loc2_ = FMC_Scene.MC_Desc["MC_Shear" + _loc1_];
               _loc2_.gotoAndStop(1);
               _loc2_.MC_Icon.gotoAndStop(4);
               FMC_Scene.MC_Desc["TF_Tip" + _loc1_].text = "";
               _loc1_++;
            }
            TGameUtil.setButtonMode(FMC_Scene.MC_Desc.BTN_Start,false);
         }
         else
         {
            FMC_Scene.MC_Desc.visible = false;
            FMC_Scene.MC_Game.visible = true;
            this.UpdateGame();
         }
      }
      
      protected function UpdateGame() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         if(this.FChristmas3_2015.LastShear > 0)
         {
            FMC_Scene.MC_Game.visible = true;
            FMC_Scene.MC_Game.MC_Win.visible = false;
            FMC_Scene.MC_Game.MC_Lose.visible = false;
            FMC_Scene.MC_Game.TF_Count.text = TUtilityString.Format(this.FChristmas3_2015.DescListNew[16],this.FChristmas3_2015.LastShear);
            FMC_Scene.MC_Game.TF_Score.text = TUtilityString.Format(this.FChristmas3_2015.DescListNew[17],this.FChristmas3_2015.CurSock);
            _loc1_ = 0;
            while(_loc1_ < BAR_COUNT)
            {
               _loc5_ = FMC_Scene.MC_Game.MC_Bar["MC_Value" + _loc1_];
               _loc5_.TF_Count.text = TUtilityString.Format(this.FChristmas3_2015.DescListNew[18],this.FChristmas3_2015.BarList[_loc1_].Price,this.FChristmas3_2015.BarList[_loc1_].Count);
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < SOCK_COUNT)
            {
               _loc5_ = FMC_Scene.MC_Game["MC_Sock" + _loc1_];
               _loc5_.MC_Shear.visible = false;
               _loc5_.MC_Smoke.visible = false;
               _loc5_.visible = this.FChristmas3_2015.SockList[_loc1_] == 0 ? true : false;
               _loc5_.gotoAndStop(1);
               _loc1_++;
            }
            _loc4_ = this.FChristmas3_2015.BarList[this.FChristmas3_2015.BarList.length - 1].Price;
            _loc2_ = Number(this.FChristmas3_2015.CurSock / _loc4_) * this.FBarMaxHeight;
            _loc3_ = Math.min(_loc2_,this.FBarMaxHeight);
            this.FMC_Mask.height = _loc3_;
         }
         else
         {
            FMC_Scene.MC_Game.visible = false;
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateRechargeBox();
      }
      
      protected function ProcessorOnIceUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnBuyBox != null && !FIsPlaying) && Boolean(this.FChristmas3_2015) && this.FChristmas3_2015.IceList[_loc2_] == 0)
         {
            if(this.FChristmas3_2015.LimitCount > 0)
            {
               if(this.FChristmas3_2015.FreeCount > 0)
               {
                  FOnGetBox(ACTIVITY_3_ID,TProcessorChristmas2015.ACTIVITY_3_BREAK_ICE,_loc2_ + 1);
               }
               else
               {
                  FOnBuyBox(ACTIVITY_3_ID,TProcessorChristmas2015.ACTIVITY_3_BREAK_ICE,this.FChristmas3_2015.Price,_loc2_ + 1);
               }
               FMC_Scene.MC_Ice["MC_Ice" + _loc2_].MC_Movie.visible = false;
            }
            else
            {
               FOnShowFlowText(this.FChristmas3_2015.DescListNew[9]);
            }
         }
      }
      
      protected function ProcessorOnAutoUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnBuyBox != null && !FIsPlaying && Boolean(this.FChristmas3_2015))
         {
            FOnBuyBox(ACTIVITY_3_ID,TProcessorChristmas2015.ACTIVITY_3_AUTO_GAME,this.FChristmas3_2015.AutoPrice);
         }
      }
      
      protected function ProcessorOnGainUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && !FIsPlaying && Boolean(this.FChristmas3_2015))
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorChristmas2015.ACTIVITY_3_GAIN);
         }
      }
      
      protected function ProcessorOnStartUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && !FIsPlaying && Boolean(this.FChristmas3_2015))
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorChristmas2015.ACTIVITY_3_START_GAME);
         }
      }
      
      protected function ProcessorOnChoiceShear(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(Boolean(FOnGetBox != null && !FIsPlaying) && Boolean(this.FChristmas3_2015) && this.FChristmas3_2015.ShearIndex == -1)
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorChristmas2015.ACTIVITY_3_CHOICE_SHEAR,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnSockUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnGetBox != null && !FIsPlaying) && Boolean(this.FChristmas3_2015) && this.FChristmas3_2015.SockList[_loc2_] == 0)
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorChristmas2015.ACTIVITY_3_CUT_SOCK,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnRechargeBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FCurPage;
         if(Boolean(FOnGetBox != null && !FIsPlaying) && Boolean(this.FChristmas3_2015) && this.FChristmas3_2015.RechargeBox[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorChristmas2015.ACTIVITY_3_GET_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FChristmas3_2015))
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorChristmas2015.ACTIVITY_3_EXCHANGE_BOX,param1 + 1);
         }
      }
      
      protected function ProcessorOnEnterUp(param1:MouseEvent) : void
      {
         this.UpdateDesc();
      }
      
      protected function ProcessorOnCloseDesc(param1:MouseEvent) : void
      {
         FMC_Scene.MC_Desc.visible = false;
      }
      
      protected function ProcessorOnCloseGame(param1:MouseEvent) : void
      {
         FMC_Scene.MC_Game.visible = false;
      }
      
      protected function ProcessorOnIceOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(!FIsPlaying && this.FChristmas3_2015.IceList[_loc2_] == 0)
         {
            FMC_Scene.MC_Ice["MC_Ice" + _loc2_].MC_Movie.visible = true;
            FMC_Scene.MC_Ice["MC_Ice" + _loc2_].MC_Movie.gotoAndStop(1);
         }
      }
      
      protected function ProcessorOnIceOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(!FIsPlaying)
         {
            _loc2_ = int(String(param1.currentTarget.name).slice(6));
            FMC_Scene.MC_Ice["MC_Ice" + _loc2_].MC_Movie.visible = false;
         }
      }
      
      protected function ProcessorOnRechargeBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FCurPage;
         if(FOnNewBoxOver != null)
         {
            FOnNewBoxOver(this.FChristmas3_2015.RechargeBox[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnAutoOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FChristmas3_2015))
         {
            FOnShowHtmlTip(this.FChristmas3_2015.DescListNew[29]);
         }
      }
      
      protected function ProcessorOnShearOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(FOnShowHtmlTip != null && this.FChristmas3_2015.ShearIndex == 0)
         {
            FOnShowHtmlTip(this.FChristmas3_2015.DescListNew[26 + _loc2_]);
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI(this.FChristmas3_2015);
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
            FOnLoadLog(ACTIVITY_3_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank(ACTIVITY_3_ID);
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
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            if(Boolean(this.FGlowFilter) && !this.FGlowFilter.IsRunOver)
            {
               this.FGlowFilter.Run();
            }
            if(FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_OF_BREAK_ICE:
                     CurFrame = FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].MC_Movie.currentFrame;
                     break;
                  case MOVIE_OF_NONE:
                     CurFrame = FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].MC_Smoke.currentFrame;
                     break;
                  case MOVIE_OF_AUTO:
                     CurFrame = FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].MC_Movie.currentFrame;
                     break;
                  case MOVIE_OF_REFRESH:
                     CurFrame = FMC_Scene.MC_Movie0.currentFrame;
                     break;
                  case MOVIE_OF_SHEAR:
                     CurFrame = FMC_Scene.MC_Desc.MC_Shear0.currentFrame;
                     break;
                  case MOVIE_OF_CHOICE_SHEAR:
                     CurFrame = FMC_Scene.MC_Desc.MC_Movie.currentFrame;
                     break;
                  case MOVIE_OF_USE_SHEAR:
                     CurFrame = FMC_Scene.MC_Game["MC_Sock" + this.FOpenIndex].MC_Shear.MC_Shear.currentFrame;
                     break;
                  case MOVIE_OF_SOCK_NULL:
                     CurFrame = FMC_Scene.MC_Game["MC_Sock" + this.FOpenIndex].MC_Smoke.currentFrame;
                     break;
                  case MOVIE_OF_SOCK_FALL:
                     CurFrame = FMC_Scene.MC_Game["MC_Sock" + this.FOpenIndex].currentFrame;
                     break;
                  case MOVIE_OF_GAME_WIN:
                     CurFrame = FMC_Scene.MC_Game.MC_Win.MC_Movie.currentFrame;
                     break;
                  case MOVIE_OF_GAME_LOSE:
                     CurFrame = FMC_Scene.MC_Game.MC_Lose.currentFrame;
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
         FIsPlaying = false;
         this.FChristmas3_2015 = SLogicsCore.ChristmasDatas_2015.GetActivityByIdentify(ACTIVITY_3_ID) as TChristmas3_2015;
         this.FCurPage = this.FUIPage.PageIndex = this.FChristmas3_2015.CurBoxIndex;
         this.UpdateText();
         this.UpdateIce();
         this.UpdateBook();
         this.UpdateBadge();
         this.UpdateRechargeBox();
         this.UpdateGame();
         if(FIsFirstLoad)
         {
            FIsFirstLoad = false;
            this.FProcessorFebActiveShop.Load();
         }
         if(this.FProcessorFebActiveShop.Visible)
         {
            this.FProcessorFebActiveShop.UpdateUI(this.FChristmas3_2015);
         }
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         this.FMovieType = param1;
         FIsPlaying = true;
         if(this.FMovieType == MOVIE_OF_BREAK_ICE)
         {
            _loc5_ = FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].MC_Movie;
            _loc5_.visible = true;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
            FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].MC_Ice.visible = false;
         }
         else if(this.FMovieType == MOVIE_OF_NONE)
         {
            _loc5_ = FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].MC_Smoke;
            _loc5_.visible = true;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_AUTO)
         {
            _loc3_ = 0;
            while(_loc3_ < this.FChristmas3_2015.IceList.length)
            {
               if(this.FChristmas3_2015.IceList[_loc3_] != 0)
               {
                  this.FOpenIndex = _loc3_;
                  _loc5_ = FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].MC_Movie;
                  _loc5_.visible = true;
                  FTotalFrame = _loc5_.totalFrames;
                  _loc5_.gotoAndPlay(1);
                  FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].MC_Ice.visible = false;
               }
               _loc3_++;
            }
         }
         else if(this.FMovieType == MOVIE_OF_REFRESH)
         {
            _loc5_ = FMC_Scene.MC_Movie0;
            _loc5_.visible = true;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_SHEAR)
         {
            _loc3_ = 0;
            while(_loc3_ < SHEAR_COUNT)
            {
               _loc5_ = FMC_Scene.MC_Desc["MC_Shear" + _loc3_];
               FTotalFrame = _loc5_.totalFrames;
               _loc5_.gotoAndPlay(1);
               _loc3_++;
            }
         }
         else if(this.FMovieType == MOVIE_OF_CHOICE_SHEAR)
         {
            _loc5_ = FMC_Scene.MC_Desc.MC_Movie;
            _loc5_.visible = true;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.MC_Icon.gotoAndStop(this.FChristmas3_2015.ShearIndex);
            _loc5_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_USE_SHEAR)
         {
            FMC_Scene.MC_Game["MC_Sock" + this.FOpenIndex].MC_Shear.visible = true;
            FMC_Scene.MC_Game["MC_Sock" + this.FOpenIndex].MC_Shear.gotoAndStop(this.FChristmas3_2015.ShearIndex);
            _loc5_ = FMC_Scene.MC_Game["MC_Sock" + this.FOpenIndex].MC_Shear.MC_Shear;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_SOCK_NULL)
         {
            _loc5_ = FMC_Scene.MC_Game["MC_Sock" + this.FOpenIndex].MC_Smoke;
            _loc5_.visible = true;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_SOCK_FALL)
         {
            _loc5_ = FMC_Scene.MC_Game["MC_Sock" + this.FOpenIndex];
            _loc5_.visible = true;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_GAME_LOSE)
         {
            _loc5_ = FMC_Scene.MC_Game.MC_Lose;
            _loc5_.MC_Text.TF_Text.text = TUtilityString.Format(this.FChristmas3_2015.DescListNew[22],this.FChristmas3_2015.Amount);
            _loc5_.visible = true;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_GAME_WIN)
         {
            FMC_Scene.MC_Game.MC_Win.visible = true;
            _loc5_ = FMC_Scene.MC_Game.MC_Win.MC_Movie;
            FMC_Scene.MC_Game.MC_Win.TF_Text.text = TUtilityString.Format(this.FChristmas3_2015.DescListNew[21],this.FChristmas3_2015.Amount);
            _loc5_.visible = true;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         FIsPlaying = false;
         if(this.FMovieType == MOVIE_OF_BREAK_ICE)
         {
            FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].MC_Movie.visible = false;
            if(this.FChristmas3_2015.IceList[this.FOpenIndex] == TChristmas3_2015.TYPE_NULL)
            {
               this.PlayMovie(MOVIE_OF_NONE);
            }
            else
            {
               this.UpdateUI();
            }
         }
         else if(this.FMovieType == MOVIE_OF_NONE)
         {
            FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].MC_Smoke.visible = false;
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_AUTO)
         {
            this.PlayMovie(MOVIE_OF_REFRESH);
         }
         else if(this.FMovieType == MOVIE_OF_REFRESH)
         {
            FMC_Scene.MC_Movie0.stop();
            FMC_Scene.MC_Movie0.visible = false;
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_SHEAR)
         {
            _loc1_ = 0;
            while(_loc1_ < SHEAR_COUNT)
            {
               FMC_Scene.MC_Desc["MC_Shear" + _loc1_].stop();
               _loc1_++;
            }
            this.UpdateUI();
            this.UpdateDesc();
         }
         else if(this.FMovieType == MOVIE_OF_CHOICE_SHEAR)
         {
            FMC_Scene.MC_Desc.MC_Movie.visible = false;
            this.UpdateDesc();
         }
         else if(this.FMovieType == MOVIE_OF_USE_SHEAR)
         {
            FMC_Scene.MC_Game["MC_Sock" + this.FOpenIndex].MC_Shear.visible = false;
            if(this.FChristmas3_2015.SockList[this.FOpenIndex] == TChristmas3_2015.TYPE_SOCK_NULL)
            {
               this.PlayMovie(MOVIE_OF_SOCK_NULL);
            }
            else
            {
               this.PlayMovie(MOVIE_OF_SOCK_FALL);
            }
         }
         else if(this.FMovieType == MOVIE_OF_SOCK_NULL)
         {
            FMC_Scene.MC_Game["MC_Sock" + this.FOpenIndex].visible = false;
            this.UpdateGame();
            if(this.FChristmas3_2015.IsEnd == TChristmas3_2015.TYPE_IS_LOSE)
            {
               this.PlayMovie(MOVIE_OF_GAME_LOSE);
            }
         }
         else if(this.FMovieType == MOVIE_OF_SOCK_FALL)
         {
            FMC_Scene.MC_Game["MC_Sock" + this.FOpenIndex].visible = false;
            this.UpdateGame();
            if(this.FChristmas3_2015.IsEnd == TChristmas3_2015.TYPE_IS_WIN)
            {
               this.PlayMovie(MOVIE_OF_GAME_WIN);
            }
         }
         else if(this.FMovieType == MOVIE_OF_GAME_LOSE)
         {
            FMC_Scene.MC_Game.MC_Lose.visible = false;
            this.FChristmas3_2015.ResetGame();
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_GAME_WIN)
         {
            FMC_Scene.MC_Game.MC_Win.visible = false;
            this.FChristmas3_2015.ResetGame();
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

