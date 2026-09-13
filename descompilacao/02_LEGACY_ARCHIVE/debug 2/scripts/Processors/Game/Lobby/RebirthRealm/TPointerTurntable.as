package Processors.Game.Lobby.RebirthRealm
{
   import flash.display.MovieClip;
   
   public class TPointerTurntable
   {
      
      public static const CircleValue:Number = 3 * 20;
      
      public static const LowestValue:Number = 1;
      
      public static const HighestValue:Number = 10;
      
      public static const IncrementOne:Number = 1;
      
      protected var FFrameMovieClip:Vector.<MovieClip> = null;
      
      protected var FCurIndex:int;
      
      protected var FIsStart:Boolean = false;
      
      protected var FIncrement:int;
      
      protected var FBaseSpeed:Number;
      
      protected var FIndexIncrement:int;
      
      protected var FEndFunction:Function;
      
      protected var FHowCircle:int = 60;
      
      protected var Temp:Number;
      
      protected var ss:int = 8;
      
      public function TPointerTurntable()
      {
         super();
      }
      
      public function LogicsPerform() : void
      {
         if(this.IsCanTurn())
         {
            if(this.FIsStart)
            {
               ++this.FIncrement;
               if(this.FIncrement > this.FBaseSpeed)
               {
                  this.FIncrement = 0;
                  ++this.FIndexIncrement;
                  if(this.FIndexIncrement >= this.FFrameMovieClip.length)
                  {
                     this.FIndexIncrement = 0;
                  }
                  if(this.FIndexIncrement - 1 < 0)
                  {
                     this.FFrameMovieClip[this.FFrameMovieClip.length - 1].gotoAndStop(2);
                  }
                  else
                  {
                     this.FFrameMovieClip[this.FIndexIncrement - 1].gotoAndStop(2);
                  }
                  this.FFrameMovieClip[this.FIndexIncrement].gotoAndStop(1);
                  if(this.FBaseSpeed <= LowestValue)
                  {
                     --this.FHowCircle;
                     if(this.FHowCircle <= 0)
                     {
                        this.FHowCircle = CircleValue;
                        this.Temp = IncrementOne;
                        this.FBaseSpeed = LowestValue + this.Temp;
                     }
                  }
                  else if(this.FBaseSpeed > HighestValue)
                  {
                     this.FBaseSpeed += 1;
                     if(this.FCurIndex == this.FIndexIncrement)
                     {
                        this.FIsStart = false;
                        this.FEndFunction(this.FCurIndex);
                     }
                  }
                  else
                  {
                     this.FBaseSpeed += this.Temp;
                  }
               }
            }
         }
      }
      
      public function SetBaseMovieClip(param1:Vector.<MovieClip>) : void
      {
         this.FFrameMovieClip = param1;
      }
      
      public function SetStart(param1:int) : void
      {
         this.FCurIndex = param1;
         this.Temp = 0 - IncrementOne;
         this.FBaseSpeed = HighestValue;
         this.FIsStart = true;
      }
      
      public function IsCanTurn() : Boolean
      {
         return this.FFrameMovieClip != null;
      }
      
      public function RecoverMovieClip() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FFrameMovieClip.length)
         {
            this.FFrameMovieClip[_loc1_].gotoAndStop(2);
            _loc1_++;
         }
      }
      
      public function Reset() : void
      {
         this.RecoverMovieClip();
         this.FFrameMovieClip[0].gotoAndStop(1);
      }
      
      public function set EndFunction(param1:Function) : void
      {
         this.FEndFunction = param1;
      }
   }
}

