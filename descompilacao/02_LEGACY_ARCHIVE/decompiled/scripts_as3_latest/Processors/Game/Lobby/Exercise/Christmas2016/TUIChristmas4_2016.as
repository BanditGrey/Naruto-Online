package Processors.Game.Lobby.Exercise.Christmas2016
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.Christmas2016.TChristmas4_2016;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIChristmas4_2016 extends TUIBaseWindow
   {
      
      protected static const FUND_COUNT:int = 4;
      
      protected static const EGG_COUNT:int = 9;
      
      protected static const LUCKY_COUNT:int = 3;
      
      protected static const NEWS_COUNT:int = 4;
      
      protected static const ACTIVITY_4_ID:int = 4;
      
      protected static const MOVIE_OF_OPEN_EGG_GOLD:int = 1;
      
      protected static const MOVIE_OF_OPEN_EGG_GIFT:int = 2;
      
      protected static const MOVIE_OF_REFRESH:int = 3;
      
      protected var FChristmas4_2016:TChristmas4_2016;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FUIPage_LuckyPlayer:TUIPage;
      
      protected var FTotalPage_LuckyPlayer:int;
      
      protected var FCurPage_LuckyPlayer:int;
      
      protected var FUIPage_News:TUIPage;
      
      protected var FTotalPage_News:int;
      
      protected var FCurPage_News:int;
      
      protected var FOpenIndex:int;
      
      public function TUIChristmas4_2016(param1:TUIComponent)
      {
         super(param1);
         this.FUIPage_LuckyPlayer = new TUIPage(this);
         this.FUIPage_News = new TUIPage(this);
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
         while(_loc2_ < FUND_COUNT)
         {
            _loc5_ = FMC_Scene["MC_Fund" + _loc2_];
            TGameUtil.setButtonMode(_loc5_.BTN_Buy,true);
            _loc5_.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyFund);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < EGG_COUNT)
         {
            _loc5_ = FMC_Scene["MC_Egg" + _loc2_];
            _loc5_.MC_Hammer.visible = false;
            _loc5_.MC_Gift.visible = false;
            _loc5_.MC_Gold.visible = false;
            _loc5_.MC_Icon.buttonMode = true;
            _loc5_.MC_Icon.addEventListener(MouseEvent.CLICK,this.ProcessorOnEggUp);
            _loc5_.MC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnEggOver);
            _loc5_.MC_Icon.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnEggOut);
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         this.FUIPage_LuckyPlayer.ButtonPrevious.Substrate = FMC_Scene.MC_LuckyPlayer.MC_ChangePage.MC_PageLeft;
         this.FUIPage_LuckyPlayer.ButtonNext.Substrate = FMC_Scene.MC_LuckyPlayer.MC_ChangePage.MC_PageRight;
         this.FUIPage_LuckyPlayer.TotalQuantity = this.FTotalPage_LuckyPlayer;
         this.FUIPage_LuckyPlayer.LabelPage = FMC_Scene.MC_LuckyPlayer.MC_ChangePage.TF_Page;
         this.FUIPage_LuckyPlayer.PageSize = LUCKY_COUNT;
         this.FUIPage_LuckyPlayer.PageIndex = 0;
         this.FCurPage_LuckyPlayer = 0;
         this.FUIPage_LuckyPlayer.OnChangePage = this.ProcessorPageOnChange_LuckyPlayer;
         this.FUIPage_News.ButtonPrevious.Substrate = FMC_Scene.MC_News.MC_ChangePage.MC_PageLeft;
         this.FUIPage_News.ButtonNext.Substrate = FMC_Scene.MC_News.MC_ChangePage.MC_PageRight;
         this.FUIPage_News.TotalQuantity = this.FTotalPage_News;
         this.FUIPage_News.LabelPage = FMC_Scene.MC_News.MC_ChangePage.TF_Page;
         this.FUIPage_News.PageSize = NEWS_COUNT;
         this.FUIPage_News.PageIndex = 0;
         this.FCurPage_News = 0;
         this.FUIPage_News.OnChangePage = this.ProcessorPageOnChange_News;
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FChristmas4_2016.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FChristmas4_2016.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FChristmas4_2016.DescListNew[1];
      }
      
      protected function UpdateFund() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < FUND_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Fund" + _loc1_];
            _loc3_ = this.FChristmas4_2016.FundList[_loc1_];
            _loc2_.TF_Desc.text = TUtilityString.Format(this.FChristmas4_2016.DescListNew[2],this.FChristmas4_2016.TotalRechargeGold,_loc3_.Count);
            _loc2_.TF_Desc1.text = this.FChristmas4_2016.DescListNew[3 + _loc1_];
            _loc2_.TF_Desc2.text = TUtilityString.Format(this.FChristmas4_2016.DescListNew[7],_loc3_.Discount);
            _loc2_.TF_Desc3.text = TUtilityString.Format(this.FChristmas4_2016.DescListNew[8],_loc3_.ReturnMoney);
            if(this.FChristmas4_2016.CurFund == 0)
            {
               _loc2_.BTN_Buy.visible = true;
               _loc2_.MC_Got.visible = false;
               if(this.FChristmas4_2016.TotalRechargeGold >= _loc3_.Count)
               {
                  TGameUtil.setButtonMode(_loc2_.BTN_Buy,true);
               }
               else
               {
                  TGameUtil.setButtonMode(_loc2_.BTN_Buy,false);
               }
            }
            else if(_loc1_ == this.FChristmas4_2016.CurFund - 1)
            {
               _loc2_.BTN_Buy.visible = false;
               _loc2_.MC_Got.visible = true;
            }
            else
            {
               _loc2_.BTN_Buy.visible = true;
               _loc2_.MC_Got.visible = false;
               TGameUtil.setButtonMode(_loc2_.BTN_Buy,false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateEgg() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < EGG_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Egg" + _loc1_];
            _loc3_ = this.FChristmas4_2016.EggList[_loc1_];
            _loc2_.MC_Hammer.visible = false;
            _loc2_.MC_Gift.visible = false;
            _loc2_.MC_Gold.visible = false;
            if(_loc3_ == TBaseActivity.STATUS_GETED)
            {
               _loc2_.MC_Icon.visible = false;
               _loc2_.MC_Open.visible = true;
            }
            else
            {
               _loc2_.MC_Icon.visible = true;
               _loc2_.MC_Open.visible = false;
            }
            _loc1_++;
         }
         if(FMC_Scene.MC_End)
         {
            FMC_Scene.MC_End.visible = this.FChristmas4_2016.LimitCount == 0 ? true : false;
         }
      }
      
      protected function UpdateLuckyPlayer() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TLotteryNews = null;
         var _loc6_:String = null;
         FMC_Scene.MC_LuckyPlayer.TF_Desc.text = this.FChristmas4_2016.DescListNew[12];
         this.FUIPage_LuckyPlayer.TotalQuantity = this.FChristmas4_2016.LuckyList.length;
         this.FUIPage_LuckyPlayer.Update();
         _loc1_ = 0;
         while(_loc1_ < LUCKY_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage_LuckyPlayer * LUCKY_COUNT;
            if(_loc2_ < this.FChristmas4_2016.LuckyList.length)
            {
               _loc5_ = this.FChristmas4_2016.LuckyList[_loc2_];
               _loc6_ = TUtilityDate.FormatMMDDChineseNew(new Date(STimingCore.GetClientShowTime(_loc5_.GetTime) * 1000));
               FMC_Scene.MC_LuckyPlayer["TF_Log" + _loc1_].text = TUtilityString.Format(this.FChristmas4_2016.DescListNew[9],_loc6_,_loc5_.PlayerNick,_loc5_.Count);
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
         var _loc6_:String = null;
         this.FUIPage_News.TotalQuantity = this.FChristmas4_2016.NewsList.length;
         this.FUIPage_News.Update();
         _loc1_ = 0;
         while(_loc1_ < NEWS_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage_News * NEWS_COUNT;
            if(_loc2_ < this.FChristmas4_2016.NewsList.length)
            {
               _loc5_ = this.FChristmas4_2016.NewsList[_loc2_];
               _loc6_ = TUtilityDate.FormatMMDDChineseNew(new Date(STimingCore.GetClientShowTime(_loc5_.GetTime) * 1000));
               if(_loc5_.NewsType == TChristmas4_2016.TYPE_GOLD)
               {
                  FMC_Scene.MC_News["TF_Log" + _loc1_].text = TUtilityString.Format(this.FChristmas4_2016.DescListNew[10],_loc6_,_loc5_.PlayerNick,_loc5_.Count);
               }
               else
               {
                  FMC_Scene.MC_News["TF_Log" + _loc1_].text = TUtilityString.Format(this.FChristmas4_2016.DescListNew[11],_loc6_,_loc5_.PlayerNick,_loc5_.Count);
               }
            }
            else
            {
               FMC_Scene.MC_News["TF_Log" + _loc1_].text = "";
            }
            _loc1_++;
         }
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
      
      protected function ProcessorOnBuyFund(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnBuyBox != null && !FIsPlaying) && Boolean(this.FChristmas4_2016) && this.FChristmas4_2016.CurFund == 0)
         {
            FOnBuyBox(ACTIVITY_4_ID,TProcessorChristmas2016.ACTIVITY_4_BUY_FUND,this.FChristmas4_2016.FundList[_loc2_].Price,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnEggUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(FOnBuyBox != null && !FIsPlaying) && Boolean(this.FChristmas4_2016) && this.FChristmas4_2016.EggList[_loc2_] == 0)
         {
            if(this.FChristmas4_2016.LimitCount <= 0)
            {
               FOnShowFlowText(this.FChristmas4_2016.DescListNew[16]);
            }
            else
            {
               FOnBuyBox(ACTIVITY_4_ID,TProcessorChristmas2016.ACTIVITY_4_OPEN_EGG,this.FChristmas4_2016.Price,_loc2_ + 1);
               FMC_Scene["MC_Egg" + _loc2_].MC_Hammer.visible = false;
            }
         }
      }
      
      protected function ProcessorOnEggOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(this.FChristmas4_2016) && this.FChristmas4_2016.EggList[_loc2_] == 0)
         {
            FMC_Scene["MC_Egg" + _loc2_].MC_Hammer.visible = true;
            FMC_Scene["MC_Egg" + _loc2_].MC_Hammer.gotoAndStop(1);
         }
      }
      
      protected function ProcessorOnEggOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(this.FChristmas4_2016) && this.FChristmas4_2016.EggList[_loc2_] == 0)
         {
            FMC_Scene["MC_Egg" + _loc2_].MC_Hammer.visible = false;
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
            FOnLoadLog(ACTIVITY_4_ID);
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
            if(FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_OF_OPEN_EGG_GOLD:
                     CurFrame = FMC_Scene["MC_Egg" + this.FOpenIndex].MC_Gold.currentFrame;
                     break;
                  case MOVIE_OF_OPEN_EGG_GIFT:
                     CurFrame = FMC_Scene["MC_Egg" + this.FOpenIndex].MC_Gift.currentFrame;
                     break;
                  case MOVIE_OF_REFRESH:
                     CurFrame = FMC_Scene.MC_Movie0.currentFrame;
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
         this.FChristmas4_2016 = SLogicsCore.ChristmasDatas_2016.GetActivityByIdentify(ACTIVITY_4_ID) as TChristmas4_2016;
         this.UpdateText();
         this.UpdateFund();
         this.UpdateEgg();
         this.UpdateLuckyPlayer();
         this.UpdateNews();
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
         if(this.FMovieType == MOVIE_OF_OPEN_EGG_GOLD)
         {
            _loc5_ = FMC_Scene["MC_Egg" + this.FOpenIndex].MC_Gold;
            _loc5_.visible = true;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
            FMC_Scene["MC_Egg" + this.FOpenIndex].MC_Hammer.visible = true;
            FMC_Scene["MC_Egg" + this.FOpenIndex].MC_Hammer.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_OPEN_EGG_GIFT)
         {
            _loc5_ = FMC_Scene["MC_Egg" + this.FOpenIndex].MC_Gift;
            _loc5_.visible = true;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
            FMC_Scene["MC_Egg" + this.FOpenIndex].MC_Hammer.visible = true;
            FMC_Scene["MC_Egg" + this.FOpenIndex].MC_Hammer.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_REFRESH)
         {
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         FIsPlaying = false;
         if(this.FMovieType == MOVIE_OF_OPEN_EGG_GOLD)
         {
            FMC_Scene["MC_Egg" + this.FOpenIndex].MC_Gold.visible = false;
            FMC_Scene["MC_Egg" + this.FOpenIndex].MC_Hammer.visible = false;
            FOnShowFlowText(FFlowStr);
            if(this.FChristmas4_2016.IsEnd == 1)
            {
               this.FChristmas4_2016.ResetEgg();
               this.UpdateUI();
            }
            else
            {
               this.UpdateUI();
            }
         }
         else if(this.FMovieType == MOVIE_OF_OPEN_EGG_GIFT)
         {
            FMC_Scene["MC_Egg" + this.FOpenIndex].MC_Gold.visible = false;
            FMC_Scene["MC_Egg" + this.FOpenIndex].MC_Hammer.visible = false;
            FOnShowFlowText(FFlowStr);
            if(this.FChristmas4_2016.IsEnd == 1)
            {
               this.FChristmas4_2016.ResetEgg();
               this.UpdateUI();
            }
            else
            {
               this.UpdateUI();
            }
         }
         else if(this.FMovieType == MOVIE_OF_REFRESH)
         {
            FMC_Scene.MC_Movie0.visible = false;
            this.FChristmas4_2016.ResetEgg();
            this.UpdateUI();
         }
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FOpenIndex = param1;
      }
   }
}

