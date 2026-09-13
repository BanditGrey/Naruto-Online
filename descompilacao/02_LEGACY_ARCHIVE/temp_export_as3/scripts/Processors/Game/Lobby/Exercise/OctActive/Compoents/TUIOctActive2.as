package Processors.Game.Lobby.Exercise.OctActive.Compoents
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.OctActive.TOctActive2;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUINews;
   import Processors.Game.Lobby.Exercise.OctActive.TProcessorOctActive;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIOctActive2 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 2;
      
      protected static const POINT_COUNT:int = 15;
      
      protected static const CANNON_COUNT:int = 4;
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      public static const MOVIE_TYPE_CANNON_BOMB:int = 1;
      
      public static const MOVIE_TYPE_FIGHT_POINT:int = 2;
      
      public static const MOVIE_TYPE_BIG_CANNON:int = 3;
      
      public static const MOVIE_TYPE_ADD_SCORE:int = 4;
      
      public static const MOVIE_TYPE_POINT_DEAD:int = 5;
      
      public static const MOVIE_TYPE_MANY_POINT_FIGHT:int = 6;
      
      protected var FOctActive2:TOctActive2;
      
      protected var FPointList:Vector.<MovieClip>;
      
      protected var FCannonList:Vector.<MovieClip>;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FUIWindowExchange:TUIWindowExchange;
      
      protected var FUINews:TUINews;
      
      protected var FCurPointIndex:int;
      
      protected var FCurCannonIndex:int;
      
      protected var FMovieType:int;
      
      protected var FIsTagVisible:Boolean;
      
      protected var FBuyBoxDate:Object;
      
      protected var FIsDead:int;
      
      protected var FFrameCount:int;
      
      protected var FAmount:int;
      
      protected var FFirstLoad:Boolean;
      
      protected var FPointIndex:Vector.<int>;
      
      protected var FInitX:int;
      
      protected var FInitTextX:int;
      
      public function TUIOctActive2(param1:TUIComponent)
      {
         super(param1);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FPointList = new Vector.<MovieClip>(POINT_COUNT);
         this.FCannonList = new Vector.<MovieClip>(CANNON_COUNT);
         this.FBuyBoxDate = new Object();
         this.FPointIndex = new Vector.<int>();
         this.FUIWindowExchange = new TUIWindowExchange(this.Parent.Parent);
         this.FIsTagVisible = true;
         this.FCurCannonIndex = -1;
         this.FFirstLoad = true;
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < POINT_COUNT)
         {
            this.FPointList[_loc2_] = FMC_Scene["MC_Point" + _loc2_];
            this.FPointList[_loc2_].buttonMode = true;
            this.FPointList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnPointUp);
            this.FPointList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnPointOver);
            this.FPointList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnPointOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < CANNON_COUNT)
         {
            this.FCannonList[_loc2_] = FMC_Scene["MC_Cannon" + _loc2_];
            this.FCannonList[_loc2_].buttonMode = true;
            this.FCannonList[_loc2_].MC_Icon.gotoAndStop(_loc2_ + 1);
            this.FCannonList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnCannonUp);
            this.FCannonList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnCannonOver);
            this.FCannonList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnCannonOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene["MC_Box" + _loc2_];
            this.FBoxList[_loc2_].gotoAndStop(_loc2_ + 1);
            TGameUtil.setButtonMode(param1.BTN_Exchange,true);
            this.FBoxList[_loc2_].BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeBoxUp);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnExchangeBoxOver);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnExchangeBoxOut);
            _loc2_++;
         }
         this.FInitX = this.FBoxList[0].x;
         this.FInitTextX = FMC_Scene.MC_CountA.x;
         FMC_Scene.MC_BigCannon.buttonMode = true;
         FMC_Scene.MC_BigCannon.addEventListener(MouseEvent.CLICK,this.ProcessorOnBigCannonUp);
         FMC_Scene.MC_BigCannon.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBigCannonOver);
         FMC_Scene.MC_BigCannon.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBigCannonOut);
         FMC_Scene.MC_Movie.visible = false;
         FMC_Scene.MC_Effect.visible = false;
         TGameUtil.setButtonMode(FMC_Scene.MC_Desc.BTN_Start,true);
         FMC_Scene.MC_Desc.BTN_Start.addEventListener(MouseEvent.CLICK,this.ProcessorOnStartUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Reset,true);
         FMC_Scene.BTN_Reset.addEventListener(MouseEvent.CLICK,this.ProcessorOnResetUp);
         FMC_Scene.BTN_Reset.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnResetOver);
         FMC_Scene.BTN_Reset.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         FMC_Scene.MC_ScoreTip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnScoreTip);
         FMC_Scene.MC_ScoreTip.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         this.FUIWindowExchange.OnOKUp = this.WindowExchangeOnOK;
         this.FUIWindowExchange.Visible = false;
         this.FUINews = new TUINews(this);
         this.FUINews.X += 60;
         this.FUINews.Y += 170;
         this.FUINews.Perform_UIDispatch(FMC_Scene["MC_List"]);
      }
      
      protected function UpdatePoint() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < POINT_COUNT)
         {
            _loc3_ = this.FPointList[_loc1_];
            _loc4_ = this.FOctActive2.PointList[_loc1_];
            _loc3_.MC_Dead.visible = false;
            _loc3_.MC_Attack.visible = false;
            _loc3_.MC_Icon.gotoAndStop(_loc4_.Level);
            _loc3_.TF_Level.text = TUtilityString.Format(this.FOctActive2.DescListNew[3],_loc4_.Level);
            _loc1_++;
         }
      }
      
      protected function UpdateCannon() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < CANNON_COUNT)
         {
            _loc3_ = this.FCannonList[_loc1_];
            _loc4_ = this.FOctActive2.CannonList[_loc1_];
            _loc3_.MC_Select.visible = this.FCurCannonIndex == _loc1_ ? true : false;
            _loc3_.TF_Name.text = TUtilityString.Format(_loc4_.DescListNew[0]);
            _loc3_.TF_Power.text = TUtilityString.Format(this.FOctActive2.DescListNew[4],_loc4_.Level);
            _loc3_.TF_Price.text = TUtilityString.Format(this.FOctActive2.DescListNew[5],_loc4_.Price);
            _loc1_++;
         }
         if(this.FOctActive2.BigCannon.Min < this.FOctActive2.BigCannon.Max)
         {
            FMC_Scene.MC_BigCannon.MC_Mask.visible = true;
            FMC_Scene.MC_BigCannon.MC_Icon.filters = [TGameUtil.GaryColorFilters];
            FMC_Scene.MC_BigCannon.MC_Icon.gotoAndStop(1);
         }
         else
         {
            FMC_Scene.MC_BigCannon.MC_Mask.visible = false;
            FMC_Scene.MC_BigCannon.MC_Icon.filters = [];
            FMC_Scene.MC_BigCannon.MC_Icon.gotoAndPlay(1);
         }
         _loc3_ = FMC_Scene.MC_BigCannon;
         _loc3_.TF_Power.text = TUtilityString.Format(this.FOctActive2.DescListNew[4],this.FOctActive2.BigCannon.Level);
         _loc3_.TF_Price.text = TUtilityString.Format(this.FOctActive2.DescListNew[9],this.FOctActive2.BigCannon.Min,this.FOctActive2.BigCannon.Max);
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            _loc4_ = this.FOctActive2.BoxList[_loc1_];
            if(this.FOctActive2.MyScore >= _loc4_.Price)
            {
               TGameUtil.setButtonMode(_loc3_.BTN_Exchange,true);
            }
            else
            {
               TGameUtil.setButtonMode(_loc3_.BTN_Exchange,false);
            }
            _loc1_++;
         }
         this.FBoxList[0].TF_Price.text = this.FOctActive2.DescListNew[6];
         this.FBoxList[1].TF_Price.text = this.FOctActive2.DescListNew[15];
         FMC_Scene.MC_CountA.TF_CountA.text = this.FOctActive2.ScoreA.toString();
         FMC_Scene.MC_CountB.TF_CountB.text = this.FOctActive2.ScoreB.toString();
         if(this.FOctActive2.IsBoxVisible == TBaseActivity.STATUS_CANNOTGET)
         {
            this.FBoxList[0].x = this.FInitX + 65;
            FMC_Scene.MC_CountA.x = this.FInitTextX + 65;
            this.FBoxList[1].visible = false;
            FMC_Scene.MC_CountB.visible = false;
         }
         else
         {
            this.FBoxList[0].x = this.FInitX;
            FMC_Scene.MC_CountA.x = this.FInitTextX;
            this.FBoxList[1].visible = true;
            FMC_Scene.MC_CountB.visible = true;
         }
      }
      
      protected function UpdateNews() : void
      {
         this.FUINews.NewsDate = this.FOctActive2.NewsList;
         this.FUINews.UpdateUI();
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Score.text = this.FOctActive2.MyScore.toString();
      }
      
      protected function ProcessorOnStartUp(param1:MouseEvent) : void
      {
         this.FOctActive2.IsDescVisible = 1;
         FMC_Scene.MC_Desc.visible = false;
         FMC_Scene.BTN_Desc.visible = true;
      }
      
      protected function ProcessorOnCannonUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(9));
         if(Boolean(this.FOctActive2) && Boolean(_loc2_ < this.FOctActive2.CannonList.length) && this.FCurCannonIndex != _loc2_)
         {
            if(this.FOctActive2.BigCannon.Min == this.FOctActive2.BigCannon.Max)
            {
               FOnShowFlowText(this.FOctActive2.DescListNew[16]);
               return;
            }
            this.FCurCannonIndex = _loc2_;
            this.UpdateCannon();
         }
      }
      
      protected function ProcessorOnPointUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(!this.FOctActive2)
         {
            return;
         }
         if(FIsPlaying && (this.FMovieType == MOVIE_TYPE_BIG_CANNON || this.FMovieType == MOVIE_TYPE_MANY_POINT_FIGHT))
         {
            return;
         }
         if(this.FCurCannonIndex == -1)
         {
            FOnShowFlowText(this.FOctActive2.DescListNew[11]);
            return;
         }
         if(this.FOctActive2.BigCannon.Min == this.FOctActive2.BigCannon.Max)
         {
            FOnShowFlowText(this.FOctActive2.DescListNew[16]);
            return;
         }
         _loc5_ = int(String(param1.currentTarget.name).slice(8));
         if(Boolean(FOnBuyBox != null) && Boolean(this.FOctActive2) && _loc5_ < this.FOctActive2.PointList.length)
         {
            _loc4_ = this.FOctActive2.MyScore - this.FOctActive2.CannonList[this.FCurCannonIndex].Price;
            if(_loc4_ >= 0)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorOctActive.ACTIVITY_2_FIRE,this.FCurCannonIndex + 1,_loc5_ + 1);
            }
            else
            {
               _loc3_ = Math.abs(_loc4_) * this.FOctActive2.Rate;
               _loc2_ = TUtilityString.Format(this.FOctActive2.DescListNew[10],this.FOctActive2.CannonList[this.FCurCannonIndex].Price,Math.abs(_loc4_),_loc3_);
               FOnBuyBox(ACTIVITY_2_ID,TProcessorOctActive.ACTIVITY_2_FIRE,_loc3_,this.FCurCannonIndex + 1,0,_loc2_,_loc5_ + 1);
            }
         }
      }
      
      protected function ProcessorOnResetUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         if(FOnBuyBox != null && Boolean(this.FOctActive2))
         {
            _loc3_ = this.FOctActive2.MyScore - this.FOctActive2.ResetPrice;
            if(_loc3_ >= 0)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorOctActive.ACTIVITY_2_RESET);
            }
            else
            {
               _loc2_ = Math.abs(_loc3_) * this.FOctActive2.Rate;
               _loc4_ = TUtilityString.Format(this.FOctActive2.DescListNew[17],this.FOctActive2.ResetPrice,Math.abs(_loc3_),_loc2_);
               FOnBuyBox(ACTIVITY_2_ID,TProcessorOctActive.ACTIVITY_2_RESET,_loc2_,0,0,_loc4_);
            }
         }
      }
      
      protected function ProcessorOnBigCannonUp(param1:MouseEvent) : void
      {
         if(FIsPlaying)
         {
            return;
         }
         if(Boolean(FOnGetBox != null && this.FOctActive2) && Boolean(this.FOctActive2.BigCannon) && this.FOctActive2.BigCannon.Min == this.FOctActive2.BigCannon.Max)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorOctActive.ACTIVITY_2_BIG_FIRE);
         }
      }
      
      protected function ProcessorOnExchangeBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(FOnGetBox != null) && Boolean(this.FOctActive2) && _loc2_ < this.FOctActive2.BoxList.length)
         {
            this.FUIWindowExchange.UpdateUI(_loc2_);
         }
      }
      
      protected function WindowExchangeOnOK(param1:int, param2:int) : void
      {
         if(FOnGetBox != null)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorOctActive.ACTIVITY_2_EXCHANGE_ITEM,param1 + 1,param2);
         }
      }
      
      protected function ProcessorOnPointOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FOctActive2) && _loc2_ < this.FOctActive2.PointDesc.length)
         {
            this.FPointList[_loc2_].filters = [TGameUtil.highLightFilters];
            FOnShowHtmlTip(this.FOctActive2.PointDesc[this.FOctActive2.PointList[_loc2_].Level - 1]);
         }
      }
      
      protected function ProcessorOnPointOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(Boolean(FOnHideHtmlTip != null) && Boolean(this.FOctActive2) && _loc2_ < this.FOctActive2.PointDesc.length)
         {
            this.FPointList[_loc2_].filters = [];
            FOnHideHtmlTip();
         }
      }
      
      protected function ProcessorOnCannonOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(9));
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FOctActive2) && _loc2_ < this.FOctActive2.CannonList.length)
         {
            this.FCannonList[_loc2_].filters = [TGameUtil.highLightFilters];
            FOnShowHtmlTip(this.FOctActive2.CannonList[_loc2_].DescListNew[1]);
         }
      }
      
      protected function ProcessorOnCannonOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(9));
         if(Boolean(this.FOctActive2) && _loc2_ < this.FOctActive2.CannonList.length)
         {
            this.FCannonList[_loc2_].filters = [];
            FOnHideHtmlTip();
         }
      }
      
      protected function ProcessorOnBigCannonOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FOctActive2) && Boolean(this.FOctActive2.BigCannon))
         {
            FOnShowHtmlTip(this.FOctActive2.BigCannon.DescListNew[0]);
         }
      }
      
      protected function ProcessorOnBigCannonOut(param1:MouseEvent) : void
      {
         if(Boolean(FOnHideHtmlTip != null) && Boolean(this.FOctActive2) && Boolean(this.FOctActive2.BigCannon))
         {
            FOnHideHtmlTip();
         }
      }
      
      protected function ProcessorOnExchangeBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnItemOver != null) && Boolean(this.FOctActive2) && _loc2_ < this.FOctActive2.BoxList.length)
         {
            FOnItemOver(this,this.FOctActive2.BoxList[_loc2_].Inventories.GetInventoryByIndex(0));
         }
      }
      
      protected function ProcessorOnExchangeBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnItemOut != null) && Boolean(this.FOctActive2) && _loc2_ < this.FOctActive2.BoxList.length)
         {
            FOnItemOut(this,this.FOctActive2.BoxList[_loc2_].Inventories.GetInventoryByIndex(0));
         }
      }
      
      protected function ProcessorOnScoreTip(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FOctActive2) && this.FOctActive2.DescList.length > 14)
         {
            FOnShowHtmlTip(this.FOctActive2.DescListNew[14]);
         }
      }
      
      protected function ProcessorOnResetOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FOctActive2) && this.FOctActive2.DescList.length > 18)
         {
            FOnShowHtmlTip(this.FOctActive2.DescListNew[18]);
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
         FMC_Scene.MC_Desc.visible = true;
         FMC_Scene.BTN_Desc.visible = false;
      }
      
      public function get PointIndex() : Vector.<int>
      {
         return this.FPointIndex;
      }
      
      public function set PointIndex(param1:Vector.<int>) : void
      {
         this.FPointIndex = param1;
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
                  case MOVIE_TYPE_CANNON_BOMB:
                     CurFrame = this.FCannonList[this.FCurCannonIndex].MC_Bomb.currentFrame;
                     break;
                  case MOVIE_TYPE_FIGHT_POINT:
                     CurFrame = this.FPointList[this.FCurPointIndex].MC_Attack.currentFrame;
                     break;
                  case MOVIE_TYPE_POINT_DEAD:
                     CurFrame = this.FPointList[this.FCurPointIndex].MC_Dead.currentFrame;
                     break;
                  case MOVIE_TYPE_ADD_SCORE:
                     CurFrame = FMC_Scene.MC_Effect.currentFrame;
                     break;
                  case MOVIE_TYPE_BIG_CANNON:
                     CurFrame = FMC_Scene.MC_Movie.currentFrame;
                     break;
                  case MOVIE_TYPE_MANY_POINT_FIGHT:
                     CurFrame = this.FPointList[this.FPointIndex[0]].MC_Attack.currentFrame;
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
         if(this.FFirstLoad)
         {
            this.FUIWindowExchange.Load();
            this.FFirstLoad = false;
         }
         this.FOctActive2 = SLogicsCore.OctActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TOctActive2;
         FMC_Scene.MC_Desc.visible = this.FOctActive2.IsDescVisible == 0 ? true : false;
         FMC_Scene.BTN_Desc.visible = !FMC_Scene.MC_Desc.visible;
         this.UpdatePoint();
         this.UpdateCannon();
         this.UpdateBox();
         this.UpdateNews();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         this.FMovieType = param1;
         FIsPlaying = true;
         if(this.FMovieType == MOVIE_TYPE_CANNON_BOMB)
         {
            _loc6_ = this.FCannonList[this.FCurCannonIndex].MC_Bomb;
            FTotalFrame = _loc6_.totalFrames;
            _loc6_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_TYPE_FIGHT_POINT)
         {
            _loc6_ = this.FPointList[this.FCurPointIndex].MC_Attack;
            FTotalFrame = _loc6_.totalFrames;
            _loc6_.visible = true;
            _loc6_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_TYPE_POINT_DEAD)
         {
            _loc6_ = this.FPointList[this.FCurPointIndex].MC_Dead;
            FTotalFrame = _loc6_.totalFrames;
            _loc6_.visible = true;
            _loc6_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_TYPE_BIG_CANNON)
         {
            FMC_Scene.MC_BigCannon.MC_Bomb.gotoAndPlay(1);
            _loc6_ = FMC_Scene.MC_Movie;
            _loc6_.visible = true;
            FTotalFrame = _loc6_.totalFrames;
            _loc6_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_TYPE_ADD_SCORE)
         {
            _loc6_ = FMC_Scene.MC_Effect;
            _loc6_.visible = true;
            FTotalFrame = _loc6_.totalFrames;
            _loc6_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_TYPE_MANY_POINT_FIGHT)
         {
            _loc5_ = int(this.FPointIndex.length);
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc6_ = this.FPointList[this.FPointIndex[_loc3_]].MC_Attack;
               FTotalFrame = _loc6_.totalFrames;
               _loc6_.visible = true;
               _loc6_.gotoAndPlay(1);
               _loc3_++;
            }
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         if(this.FMovieType == MOVIE_TYPE_CANNON_BOMB)
         {
            this.PlayMovie(MOVIE_TYPE_FIGHT_POINT);
         }
         else if(this.FMovieType == MOVIE_TYPE_FIGHT_POINT)
         {
            if(this.FIsDead == 0)
            {
               if(this.FAmount > 0)
               {
                  this.PlayMovie(MOVIE_TYPE_ADD_SCORE);
               }
               else
               {
                  this.UpdateUI();
               }
            }
            else
            {
               this.FPointList[this.FCurPointIndex].MC_Attack.visible = false;
               this.PlayMovie(MOVIE_TYPE_POINT_DEAD);
            }
         }
         else if(this.FMovieType == MOVIE_TYPE_POINT_DEAD)
         {
            if(this.FAmount > 0)
            {
               this.FPointList[this.FCurPointIndex].MC_Dead.visible = false;
               this.PlayMovie(MOVIE_TYPE_ADD_SCORE);
            }
            else
            {
               this.UpdateUI();
            }
         }
         else if(this.FMovieType == MOVIE_TYPE_BIG_CANNON)
         {
            FMC_Scene.MC_Movie.visible = false;
            this.PlayMovie(MOVIE_TYPE_MANY_POINT_FIGHT);
         }
         else if(this.FMovieType == MOVIE_TYPE_ADD_SCORE)
         {
            FMC_Scene.MC_Effect.visible = false;
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_TYPE_MANY_POINT_FIGHT)
         {
            _loc2_ = int(this.FPointIndex.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FPointList[this.FPointIndex[_loc1_]].MC_Attack.visible = false;
               _loc1_++;
            }
            if(this.FAmount > 0)
            {
               this.PlayMovie(MOVIE_TYPE_ADD_SCORE);
            }
            else
            {
               this.UpdateUI();
            }
         }
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FCurPointIndex = param1;
         this.FIsDead = param2;
         this.FAmount = param3;
      }
   }
}

