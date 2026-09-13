package Logics.Organization.TreasureTree
{
   public class TUserFruitInfo
   {
      
      protected var FFruitID:uint;
      
      protected var FFruitName:String;
      
      protected var FFruitLevel:uint;
      
      protected var FFruitMatureTime:uint;
      
      protected var FFruitEvolveTime:uint;
      
      public function TUserFruitInfo()
      {
         super();
         this.FFruitID = 0;
         this.FFruitName = "";
         this.FFruitLevel = 0;
         this.FFruitMatureTime = 0;
         this.FFruitEvolveTime = 0;
      }
      
      public function get FruitID() : uint
      {
         return this.FFruitID;
      }
      
      public function set FruitID(param1:uint) : void
      {
         this.FFruitID = param1;
      }
      
      public function get FruitLevel() : uint
      {
         return this.FFruitLevel;
      }
      
      public function set FruitLevel(param1:uint) : void
      {
         this.FFruitLevel = param1;
      }
      
      public function get FruitMatureTime() : uint
      {
         return this.FFruitMatureTime;
      }
      
      public function set FruitMatureTime(param1:uint) : void
      {
         this.FFruitMatureTime = param1;
      }
      
      public function get FruitEvolveTime() : uint
      {
         return this.FFruitEvolveTime;
      }
      
      public function set FruitEvolveTime(param1:uint) : void
      {
         this.FFruitEvolveTime = param1;
      }
      
      public function get FruitName() : String
      {
         return this.FFruitName;
      }
      
      public function set FruitName(param1:String) : void
      {
         this.FFruitName = param1;
      }
   }
}

