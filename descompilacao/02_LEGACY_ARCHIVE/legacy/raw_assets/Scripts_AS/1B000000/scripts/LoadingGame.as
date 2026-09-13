package
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.net.SharedObject;
   import flash.utils.Timer;
   import subclass.*;
   
   [SWF(width="584",height="409",frameRate="30")]
   public class LoadingGame extends Sprite
   {
      
      public static const TimeInterval:int = 500;
      
      public static const TimeIntervalBlosck:int = 30;
      
      public static const speed:int = 15;
      
      protected var FMainPanel:MC_LoadingGame = null;
      
      protected var FTwoRole:MovieClip = null;
      
      protected var FOneRole:MovieClip = null;
      
      protected var FMC_Transition:MovieClip = null;
      
      protected var FTimer:Timer = null;
      
      protected var FHitRecture:MovieClip = null;
      
      protected var FMC_Action_:MovieClip = null;
      
      protected var FMC_Action:MovieClip = null;
      
      protected var FSharedObject:SharedObject = null;
      
      protected var grade:int;
      
      protected var direction:int = 0;
      
      protected var ResolveRepetition:int = 0;
      
      protected var ResolveBlock:Timer = null;
      
      protected var FSilverCoinClass:SilverCoinClass = null;
      
      public function LoadingGame()
      {
         super();
         if(Boolean(stage))
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.init);
         }
      }
      
      private function init(e:Event = null) : void
      {
         this.FTimer = new Timer(TimeInterval);
         this.ResolveBlock = new Timer(TimeIntervalBlosck);
         this.FTimer.start();
         this.FTimer.addEventListener(TimerEvent.TIMER,this.TimeEvent);
         removeEventListener(Event.ADDED_TO_STAGE,this.init);
         this.ResolveBlock.addEventListener(TimerEvent.TIMER,this.EnterFrame);
         this.ResolveBlock.start();
         this.parent.addEventListener(MouseEvent.MOUSE_MOVE,this.moveFunction);
         this.FMainPanel = new MC_LoadingGame();
         addChildAt(this.FMainPanel,0);
         this.FMC_Transition = this.FMainPanel["MC_Transition"];
         this.FTwoRole = this.FMC_Transition["MC_Role"];
         this.FSilverCoinClass = new SilverCoinClass(this.FMC_Transition["MC_Hundreds"],this.FMC_Transition["MC_Tens"],this.FMC_Transition["MC_Units"]);
         this.FSilverCoinClass.SetPictureByNum(0);
         this.SetOneRole(Math.round(Math.random()) + 1);
         this.FSilverCoinClass.SetPictureByNum(this.grade);
      }
      
      protected function SetOneRole(frame:int) : void
      {
         this.ResolveRepetition = frame;
         this.FTwoRole.gotoAndStop(frame);
         this.FOneRole = this.FTwoRole["MC_Man"];
         this.FOneRole.gotoAndStop(frame);
         this.FHitRecture = this.FTwoRole["RectangleExp"];
         this.FMC_Action_ = this.FOneRole["MC_Action_"];
         this.FHitRecture.visible = false;
      }
      
      public function TimeEvent(e:TimerEvent) : void
      {
         var c:CoinSingleClass = null;
         c = new CoinSingleClass(this);
         this.addChild(c);
         c.setPosition(this.FMainPanel.x + Math.random() * 500 + 50,this.FMainPanel.y + 18,Math.random() * 4 + 5);
      }
      
      public function moveFunction(e:MouseEvent) : void
      {
         if(mouseX > this.FTwoRole.x + this.FTwoRole.width / 7)
         {
            this.FTwoRole.scaleX = -1;
            this.direction = 2;
         }
         else if(mouseX < this.FTwoRole.x - this.FTwoRole.width / 7)
         {
            this.FTwoRole.scaleX = 1;
            this.direction = 1;
         }
         else
         {
            this.direction = 0;
         }
      }
      
      public function EnterFrame(e:Event) : void
      {
         if(this.FTwoRole.x - this.FTwoRole.width / 7 <= mouseX && mouseX <= this.FTwoRole.x + this.FTwoRole.width / 7)
         {
            this.direction = 0;
         }
         if(this.direction != this.ResolveRepetition)
         {
            if(this.direction == 1 || this.direction == 2)
            {
               this.FMC_Action_.gotoAndStop(2);
               this.FMC_Action = this.FMC_Action_["MC_Action"];
            }
            else
            {
               this.FMC_Action_.gotoAndStop(1);
               this.FMC_Action = this.FMC_Action_["MC_Action"];
            }
            this.FMC_Action.gotoAndPlay(1);
            this.ResolveRepetition = this.direction;
         }
         if(Boolean(this.direction))
         {
            if(this.direction == 1)
            {
               if(this.FTwoRole.x <= 80)
               {
                  this.FTwoRole.x = 80;
                  this.FMC_Action_.gotoAndStop(1);
                  this.FMC_Action = this.FMC_Action_["MC_Action"];
               }
               else
               {
                  this.FTwoRole.x -= speed;
               }
            }
            else if(this.FTwoRole.x >= 560)
            {
               this.FTwoRole.x = 560;
               this.FMC_Action_.gotoAndStop(1);
               this.FMC_Action = this.FMC_Action_["MC_Action"];
            }
            else
            {
               this.FTwoRole.x += speed;
            }
            if(this.FTwoRole.x <= 80 || this.FTwoRole.x >= 560)
            {
               this.FMC_Action.gotoAndStop(1);
            }
         }
      }
      
      public function UpdateGrade() : void
      {
         var Word:FlutterWord = new FlutterWord();
         Word.x = this.FTwoRole.x;
         Word.y = this.FTwoRole.y - this.FTwoRole.height;
         this.addChild(Word);
         Word.Start();
         this.grade += 10;
         this.FSilverCoinClass.SetPictureByNum(this.grade);
      }
      
      public function get RoleObject() : MovieClip
      {
         return this.FTwoRole;
      }
      
      public function get HitObject() : MovieClip
      {
         return this.FHitRecture;
      }
      
      public function CloseExecute() : void
      {
         this.ResolveBlock.reset();
         this.ResolveBlock.removeEventListener(TimerEvent.TIMER,this.EnterFrame);
         this.parent.removeEventListener(MouseEvent.MOUSE_MOVE,this.moveFunction);
         this.FTimer.removeEventListener(TimerEvent.TIMER,this.TimeEvent);
         this.FMainPanel = null;
         this.FTwoRole = null;
         this.FOneRole = null;
         this.FMC_Transition = null;
         this.FTimer = null;
         this.FHitRecture = null;
         this.FMC_Action_ = null;
         this.FMC_Action = null;
         this.FSilverCoinClass = null;
      }
   }
}

