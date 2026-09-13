package subclass
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class CoinSingleClass extends Sprite
   {
      
      protected var FCoinSing:MC_SFB = null;
      
      protected var FParent:LoadingGame = null;
      
      protected var FHitTarget:MovieClip = null;
      
      protected var Fmc_target:MovieClip = null;
      
      protected var FSpeed:int;
      
      public function CoinSingleClass(Parent:LoadingGame)
      {
         super();
         this.FParent = Parent;
         this.FCoinSing = new MC_SFB();
         this.FHitTarget = this.FCoinSing["MC_Coin"];
         this.Fmc_target = this.FHitTarget["mc_target"];
         this.Fmc_target.visible = false;
         this.addChild(this.FCoinSing);
         this.addEvent();
      }
      
      public function setPosition(X:int, Y:int, speed:int) : void
      {
         this.x = X;
         this.y = Y;
         this.FSpeed = speed;
      }
      
      public function addEvent() : void
      {
         this.addEventListener(Event.ADDED_TO_STAGE,this.addStage);
      }
      
      public function addStage(e:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.addStage);
         this.addEventListener(Event.ENTER_FRAME,this.EnterFrame);
      }
      
      public function EnterFrame(e:Event) : void
      {
         if(this.stage == null)
         {
            return;
         }
         this.y += this.FSpeed;
         if(this.Fmc_target.hitTestObject(this.FParent.HitObject))
         {
            this.FParent.UpdateGrade();
            this.removeEventListener(Event.ENTER_FRAME,this.EnterFrame);
            this.parent.removeChild(this);
         }
         if(this.y >= 409)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.EnterFrame);
            this.parent.removeChild(this);
         }
      }
   }
}

