package Logics.Exercise.NinjiaVillage
{
   import Logics.Exercise.TBaseBox;
   
   public class TNinjiaVillageBaseData extends TBaseBox
   {
      
      protected var FBigType:int;
      
      protected var FSmallType:int;
      
      protected var FIsOn:int;
      
      protected var FReturnRate:int;
      
      protected var FMaxTime:int;
      
      protected var FReturnGold:int;
      
      protected var FReturnGift:int;
      
      public var ReturnType:int;
      
      public var MaxTime:int;
      
      public var CZ:int;
      
      protected var FLimitLevel:Vector.<uint>;
      
      public function TNinjiaVillageBaseData()
      {
         super();
         this.FLimitLevel = new Vector.<uint>();
      }
      
      public function get BigType() : int
      {
         return this.FBigType;
      }
      
      public function set BigType(param1:int) : void
      {
         this.FBigType = param1;
      }
      
      public function get SmallType() : int
      {
         return this.FSmallType;
      }
      
      public function set SmallType(param1:int) : void
      {
         this.FSmallType = param1;
      }
      
      public function get LimitLevel() : Vector.<uint>
      {
         return this.FLimitLevel;
      }
      
      public function set LimitLevel(param1:Vector.<uint>) : void
      {
         this.FLimitLevel = param1;
      }
      
      public function get IsOn() : int
      {
         return this.FIsOn;
      }
      
      public function set IsOn(param1:int) : void
      {
         this.FIsOn = param1;
      }
      
      public function get ReturnGold() : int
      {
         return this.FReturnGold;
      }
      
      public function set ReturnGold(param1:int) : void
      {
         this.FReturnGold = param1;
      }
      
      public function get ReturnGift() : int
      {
         return this.FReturnGift;
      }
      
      public function set ReturnGift(param1:int) : void
      {
         this.FReturnGift = param1;
      }
   }
}

