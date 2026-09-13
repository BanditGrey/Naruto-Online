package Logics.Exercise.FishGame
{
   import flash.utils.getTimer;
   
   public class TFish
   {
      
      protected var FType:int;
      
      protected var FSpeed:Number;
      
      protected var FRotation:Number;
      
      protected var FIsMoving:Boolean;
      
      protected var FIsCaptured:Boolean;
      
      protected var FCanTurning:Boolean;
      
      protected var FHasShown:Boolean;
      
      protected var FCurX:Number;
      
      protected var FCurY:Number;
      
      protected var FIdentify:uint;
      
      protected var FBirthTime:int;
      
      protected var FA:Number;
      
      protected var FB:Number;
      
      public function TFish()
      {
         super();
         this.FCurX = 0;
         this.FCurY = 0;
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function set Type(param1:int) : void
      {
         this.FType = param1;
      }
      
      public function get Speed() : Number
      {
         return this.FSpeed;
      }
      
      public function set Speed(param1:Number) : void
      {
         this.FSpeed = param1;
      }
      
      public function get IsMoving() : Boolean
      {
         return this.FIsMoving;
      }
      
      public function set IsMoving(param1:Boolean) : void
      {
         this.FIsMoving = param1;
      }
      
      public function get IsCaptured() : Boolean
      {
         return this.FIsCaptured;
      }
      
      public function set IsCaptured(param1:Boolean) : void
      {
         this.FIsCaptured = param1;
      }
      
      public function get CanTurning() : Boolean
      {
         return this.FCanTurning;
      }
      
      public function set CanTurning(param1:Boolean) : void
      {
         this.FCanTurning = param1;
      }
      
      public function get HasShown() : Boolean
      {
         return this.FHasShown;
      }
      
      public function set HasShown(param1:Boolean) : void
      {
         this.FHasShown = param1;
      }
      
      public function get Rotation() : Number
      {
         return this.FRotation;
      }
      
      public function set Rotation(param1:Number) : void
      {
         this.FRotation = param1;
      }
      
      public function get CurX() : Number
      {
         return this.FCurX;
      }
      
      public function set CurX(param1:Number) : void
      {
         this.FCurX = param1;
      }
      
      public function get CurY() : Number
      {
         return this.FCurY;
      }
      
      public function set CurY(param1:Number) : void
      {
         this.FCurY = param1;
      }
      
      public function get Identify() : uint
      {
         return this.FIdentify;
      }
      
      public function set Identify(param1:uint) : void
      {
         this.FIdentify = param1;
      }
      
      public function get BirthTime() : int
      {
         return this.FBirthTime;
      }
      
      public function set BirthTime(param1:int) : void
      {
         this.FBirthTime = param1;
      }
      
      public function get A() : Number
      {
         return this.FA;
      }
      
      public function set A(param1:Number) : void
      {
         this.FA = param1;
      }
      
      public function get B() : Number
      {
         return this.FB;
      }
      
      public function set B(param1:Number) : void
      {
         this.FB = param1;
      }
      
      public function Move() : void
      {
         var _loc1_:Number = NaN;
         _loc1_ = (getTimer() - this.FBirthTime) * this.FSpeed;
         this.FCurX = _loc1_;
         this.FCurY = this.FA * _loc1_ + this.FB;
      }
      
      public function IsOutOfScree() : void
      {
      }
   }
}

