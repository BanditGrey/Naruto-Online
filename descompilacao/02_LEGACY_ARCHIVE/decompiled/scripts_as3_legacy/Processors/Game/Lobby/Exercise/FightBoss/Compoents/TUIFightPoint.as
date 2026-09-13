package Processors.Game.Lobby.Exercise.FightBoss.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.FightBoss.TFightPoint;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.FightBoss.TProcessorFightBoss;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIFightPoint extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 4;
      
      protected static const POINT_COUNT:int = 4;
      
      protected static const HERO_COUNT:int = 1;
      
      protected static const CANNON_COUNT:int = 2;
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      public static const MOVIE_TYPE_CANNON_BOMB:int = 1;
      
      public static const MOVIE_TYPE_FIGHT_POINT:int = 2;
      
      protected var FFightPoint:TFightPoint;
      
      protected var FBoxList:Vector.<TUIBaseBox>;
      
      protected var FHeroList:Vector.<MovieClip>;
      
      protected var FPointList:Vector.<MovieClip>;
      
      protected var FCannonList:Vector.<MovieClip>;
      
      protected var FCurPointIndex:int;
      
      protected var FCurCannonIndex:int;
      
      protected var FMovieType:int;
      
      public function TUIFightPoint(param1:TUIComponent)
      {
         super(param1);
         this.FBoxList = new Vector.<TUIBaseBox>(BOX_COUNT);
         this.FHeroList = new Vector.<MovieClip>(HERO_COUNT);
         this.FPointList = new Vector.<MovieClip>(POINT_COUNT);
         this.FCannonList = new Vector.<MovieClip>(CANNON_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIBaseBox = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            _loc4_ = new TUIBaseBox(this,1);
            _loc4_.Perform_UIDispatch(FMC_Scene["MC_Box" + _loc2_]);
            _loc4_.OnOverlay = this.ProcessorOnGiftOver;
            _loc4_.OnOut = this.ProcessorOnGiftOut;
            _loc4_.OnGetBox = this.ProcessorOnBoxUp;
            this.FBoxList[_loc2_] = _loc4_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < HERO_COUNT)
         {
            this.FHeroList[_loc2_] = FMC_Scene["MC_Hero" + _loc2_];
            this.FHeroList[_loc2_].buttonMode = true;
            this.FHeroList[_loc2_].MC_Hero.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroUp);
            this.FHeroList[_loc2_].MC_Hero.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
            this.FHeroList[_loc2_].MC_Hero.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHeroOut);
            TGameUtil.setButtonMode(this.FHeroList[_loc2_].Btn_Get,true);
            this.FHeroList[_loc2_].Btn_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetHeroUp);
            _loc2_++;
         }
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
            this.FCannonList[_loc2_].MC_Tip.buttonMode = true;
            this.FCannonList[_loc2_].MC_Tip.addEventListener(MouseEvent.CLICK,this.ProcessorOnCannonUp);
            this.FCannonList[_loc2_].MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnCannonOver);
            this.FCannonList[_loc2_].MC_Tip.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnCannonOut);
            _loc2_++;
         }
         FMC_Scene.MC_Gift.buttonMode = true;
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.CLICK,this.ProcessorOnLastGiftUp);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnLastGiftOver);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnLastGiftOut);
         FMC_Scene.MC_OnceMore.visible = false;
         TGameUtil.setButtonMode(FMC_Scene.MC_OnceMore.Btn_OnceMore,true);
         FMC_Scene.MC_OnceMore.Btn_OnceMore.addEventListener(MouseEvent.CLICK,this.ProcessorOnOnceMoreUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:String = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            if(_loc1_ < this.FFightPoint.BoxList.length)
            {
               _loc4_ = this.FFightPoint.BoxList[_loc1_];
               this.FBoxList[_loc1_].UpdateUI(_loc4_.Inventories);
               _loc5_ = _loc4_.Price.toString();
               this.FBoxList[_loc1_].SetDescText(0,_loc5_);
               _loc5_ = _loc4_.Count.toString();
               this.FBoxList[_loc1_].SetLimitText(_loc5_);
               if(this.FFightPoint.Score >= _loc4_.Price && _loc4_.Count > 0)
               {
                  this.FBoxList[_loc1_].SetBtnMode(true);
               }
               else
               {
                  this.FBoxList[_loc1_].SetBtnMode(false);
               }
            }
            _loc1_++;
         }
         if(this.FFightPoint.BoxStatus >= TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_Gift.MC_Click.visible = true;
         }
         else
         {
            FMC_Scene.MC_Gift.MC_Click.visible = false;
         }
      }
      
      protected function UpdateHero() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < HERO_COUNT)
         {
            _loc3_ = this.FHeroList[_loc1_];
            if(_loc1_ < this.FFightPoint.HeroList.length)
            {
               _loc4_ = this.FFightPoint.HeroList[_loc1_];
               _loc3_.TF_Price.text = _loc4_.Price.toString();
               if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc3_.MC_Got.visible = false;
                  _loc3_.Btn_Get.visible = true;
                  TGameUtil.setButtonMode(_loc3_.Btn_Get,false);
                  _loc3_.MC_Own.visible = false;
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.MC_Got.visible = false;
                  _loc3_.Btn_Get.visible = true;
                  TGameUtil.setButtonMode(_loc3_.Btn_Get,true);
                  _loc3_.MC_Own.visible = false;
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_IS_GOT)
               {
                  _loc3_.MC_Got.visible = false;
                  _loc3_.Btn_Get.visible = false;
                  _loc3_.MC_Own.visible = true;
               }
               else
               {
                  _loc3_.MC_Got.visible = true;
                  _loc3_.Btn_Get.visible = false;
                  _loc3_.MC_Own.visible = false;
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdatePoint() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:MovieClip = null;
         var _loc5_:TBaseBox = null;
         if(this.FFightPoint.GameStatus == TFightPoint.GAME_STATUS_RESEET)
         {
            FMC_Scene.MC_OnceMore.visible = true;
         }
         else
         {
            FMC_Scene.MC_OnceMore.visible = false;
         }
         _loc1_ = 0;
         while(_loc1_ < POINT_COUNT)
         {
            _loc4_ = this.FPointList[_loc1_];
            if(_loc1_ < this.FFightPoint.PointList.length)
            {
               _loc4_.visible = true;
               _loc5_ = this.FFightPoint.PointList[_loc1_];
               _loc3_ = _loc5_.Min / _loc5_.Max;
               if(_loc5_.Min == 0)
               {
                  _loc4_.MC_Pic.gotoAndStop(1 + POINT_COUNT * _loc1_);
               }
               else if(_loc3_ > 0 && _loc3_ <= Number(1 / 3))
               {
                  _loc4_.MC_Pic.gotoAndStop(2 + POINT_COUNT * _loc1_);
               }
               else if(_loc3_ > Number(1 / 3) && _loc3_ <= Number(2 / 3))
               {
                  _loc4_.MC_Pic.gotoAndStop(3 + POINT_COUNT * _loc1_);
               }
               else
               {
                  _loc4_.MC_Pic.gotoAndStop(4 + POINT_COUNT * _loc1_);
               }
               _loc4_.MC_BoomMovie.visible = false;
               _loc4_.TF_HP.text = _loc5_.Min + "/" + _loc5_.Max;
               if(_loc5_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc4_.MC_Click.visible = false;
               }
               else if(_loc5_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc4_.MC_Click.visible = true;
               }
               else
               {
                  _loc4_.MC_Click.visible = false;
               }
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateCannon() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         var _loc4_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < CANNON_COUNT)
         {
            _loc4_ = this.FCannonList[_loc1_];
            if(_loc1_ < this.FFightPoint.CannonList.length)
            {
               _loc3_ = this.FFightPoint.CannonList[_loc1_];
               if(_loc4_.TF_Count)
               {
                  _loc4_.TF_Count.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_AMOUNT,_loc3_.Count);
               }
               _loc4_.MC_Bomb.visible = false;
               if(_loc3_.Count > 0)
               {
                  _loc4_.MC_StandBy.gotoAndPlay(1);
               }
               else
               {
                  _loc4_.MC_StandBy.gotoAndStop(1);
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FFightPoint.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FFightPoint.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FFightPoint.ActivityName;
         FMC_Scene.TF_Count.text = this.FFightPoint.Score.toString();
         FMC_Scene.TF_FreeCount.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_AMOUNT,this.FFightPoint.CannonList[0].Count);
      }
      
      protected function ProcessorOnCannonUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FFightPoint.GameStatus == TFightPoint.GAME_STATUS_RESEET)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(9));
         if(Boolean(FOnBuyBox != null && this.FFightPoint) && Boolean(_loc2_ < this.FFightPoint.CannonList.length) && !FIsPlaying)
         {
            if(this.FFightPoint.CannonList[_loc2_].Count > 0)
            {
               FOnBuyBox(ACTIVITY_2_ID,TProcessorFightBoss.ACTIVITY_2_GET_BOMB,0,_loc2_ + 1,TBaseActivity.SWEET_TYPE_FREE);
            }
            else
            {
               FOnBuyBox(ACTIVITY_2_ID,TProcessorFightBoss.ACTIVITY_2_GET_BOMB,this.FFightPoint.CannonList[_loc2_].Price,_loc2_ + 1,TBaseActivity.SWEET_TYPE_GOLD);
            }
         }
      }
      
      protected function ProcessorOnPointUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(Boolean(FOnGetBox != null) && Boolean(this.FFightPoint) && _loc2_ < this.FFightPoint.PointList.length)
         {
            if(this.FFightPoint.PointList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorFightBoss.ACTIVITY_2_GET_GIFT,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnLastGiftUp(param1:MouseEvent) : void
      {
         if(FOnGetBox != null && Boolean(this.FFightPoint))
         {
            if(this.FFightPoint.BoxStatus >= TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorFightBoss.ACTIVITY_2_GET_LAST_GIFT,0);
            }
         }
      }
      
      protected function ProcessorOnBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(Boolean(FOnBuyBox != null) && Boolean(this.FFightPoint) && _loc2_ < this.FFightPoint.BoxList.length)
         {
            if(this.FFightPoint.Score >= this.FFightPoint.BoxList[_loc2_].Price)
            {
               _loc3_ = TUtilityString.Format(this.FFightPoint.ActivityDesc2,this.FFightPoint.BoxList[_loc2_].Price);
               FOnBuyBox(ACTIVITY_2_ID,TProcessorFightBoss.ACTIVITY_2_BUY_BOX,0,_loc2_ + 1,TBaseActivity.SWEET_TYPE_GOLD,_loc3_);
            }
         }
      }
      
      protected function ProcessorOnGetHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnBuyBox != null) && Boolean(this.FFightPoint) && _loc2_ < this.FFightPoint.HeroList.length)
         {
            if(this.FFightPoint.HeroList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_ = TUtilityString.Format(this.FFightPoint.ActivityDesc2,this.FFightPoint.HeroList[_loc2_].Price);
               FOnBuyBox(ACTIVITY_2_ID,TProcessorFightBoss.ACTIVITY_2_BUY_HERO,0,_loc2_ + 1,TBaseActivity.SWEET_TYPE_GOLD,_loc3_);
            }
         }
      }
      
      protected function ProcessorOnOnceMoreUp(param1:MouseEvent) : void
      {
         if(FOnGetBox != null && this.FFightPoint.GameStatus == TFightPoint.GAME_STATUS_RESEET)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorFightBoss.ACTIVITY_2_REFRESH_POINT,0);
         }
      }
      
      protected function ProcessorOnCannonOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(9));
         this.FCannonList[_loc2_].filters = [TGameUtil.GoldFilters];
         if(Boolean(this.FFightPoint) && _loc2_ < this.FFightPoint.CannonList.length)
         {
            ProcessorOnShowHtmlTip(this.FFightPoint.CannonList[_loc2_].Desc1);
         }
      }
      
      protected function ProcessorOnCannonOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(9));
         this.FCannonList[_loc2_].filters = [];
         ProcessorOnHideHtmlTip();
      }
      
      protected function ProcessorOnPointOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(Boolean(this.FFightPoint) && _loc2_ < this.FFightPoint.PointList.length)
         {
            ProcessorOnShowHtmlTip(this.FFightPoint.PointList[_loc2_].Desc1);
         }
      }
      
      protected function ProcessorOnPointOut(param1:MouseEvent) : void
      {
         ProcessorOnHideHtmlTip();
      }
      
      protected function ProcessorOnGiftOver(param1:Object, param2:Object) : void
      {
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.MC_Scene.name).slice(6));
         if(Boolean(this.FFightPoint) && _loc3_ < this.FFightPoint.BoxList.length)
         {
            ProcessorOnShowHtmlTip(this.FFightPoint.BoxList[_loc3_].Desc1);
         }
      }
      
      protected function ProcessorOnGiftOut(param1:Object, param2:Object) : void
      {
         ProcessorOnHideHtmlTip();
      }
      
      protected function ProcessorOnLastGiftOver(param1:MouseEvent) : void
      {
         if(this.FFightPoint)
         {
            ProcessorOnShowHtmlTip(this.FFightPoint.ActivityDesc4);
         }
      }
      
      protected function ProcessorOnLastGiftOut(param1:MouseEvent) : void
      {
         ProcessorOnHideHtmlTip();
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(this.FFightPoint) && _loc2_ < this.FFightPoint.HeroList.length)
         {
            ProcessorOnShowHtmlTip(this.FFightPoint.HeroList[_loc2_].Desc1);
         }
      }
      
      protected function ProcessorOnHeroOut(param1:MouseEvent) : void
      {
         ProcessorOnHideHtmlTip();
      }
      
      protected function ProcessorOnHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FFightPoint) && _loc2_ < this.FFightPoint.HeroList.length)
         {
            FOnShowRecruit(this.FFightPoint.HeroList[_loc2_].Identify);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_2_ID);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < BOX_COUNT)
            {
               if(this.FBoxList[_loc1_])
               {
                  this.FBoxList[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
            if(FIsPlaying)
            {
               if(this.FMovieType == MOVIE_TYPE_CANNON_BOMB)
               {
                  CurFrame = this.FCannonList[this.FCurCannonIndex].MC_Bomb.currentFrame;
               }
               else if(this.FMovieType == MOVIE_TYPE_FIGHT_POINT)
               {
                  CurFrame = this.FPointList[this.FCurPointIndex].MC_BoomMovie.currentFrame;
               }
               if(CurFrame >= FTotalFrame)
               {
                  FIsPlaying = false;
                  this.MovieEnd();
               }
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FFightPoint = SLogicsCore.FightBossDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TFightPoint;
         this.UpdateBox();
         this.UpdateHero();
         this.UpdatePoint();
         this.UpdateCannon();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         this.FMovieType = param1;
         FIsPlaying = true;
         if(this.FMovieType == MOVIE_TYPE_CANNON_BOMB)
         {
            this.FCannonList[this.FCurCannonIndex].MC_StandBy.visible = false;
            _loc5_ = this.FCannonList[this.FCurCannonIndex].MC_Bomb;
            _loc5_.visible = true;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_TYPE_FIGHT_POINT)
         {
            this.FCannonList[this.FCurCannonIndex].MC_Bomb.visible = false;
            this.FCannonList[this.FCurCannonIndex].MC_StandBy.visible = true;
            _loc5_ = this.FPointList[this.FCurPointIndex].MC_BoomMovie;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.visible = true;
            _loc5_.gotoAndPlay(1);
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
            this.UpdateUI();
         }
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FCurPointIndex = param1;
         this.FCurCannonIndex = param2;
      }
   }
}

