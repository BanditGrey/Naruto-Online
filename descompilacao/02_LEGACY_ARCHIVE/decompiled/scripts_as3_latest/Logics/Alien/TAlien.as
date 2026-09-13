package Logics.Alien
{
   public class TAlien
   {
      
      protected var FId:int;
      
      protected var FLevel:int;
      
      protected var FStatus:int;
      
      protected var FHeros:Object;
      
      protected var FNamePart:String;
      
      protected var FNameTotal:String;
      
      protected var FIsBattled:Boolean;
      
      public function TAlien()
      {
         super();
      }
      
      public function get Id() : int
      {
         return this.FId;
      }
      
      public function set Id(param1:int) : void
      {
         this.FId = param1;
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
      
      public function set Level(param1:int) : void
      {
         this.FLevel = param1;
      }
      
      public function get Heros() : Object
      {
         return this.FHeros;
      }
      
      public function set Heros(param1:Object) : void
      {
         this.FHeros = param1;
      }
      
      public function get Status() : int
      {
         return this.FStatus;
      }
      
      public function set Status(param1:int) : void
      {
         this.FStatus = param1;
      }
      
      public function get NamePart() : String
      {
         return this.FNamePart;
      }
      
      public function set NamePart(param1:String) : void
      {
         this.FNamePart = param1;
      }
      
      public function get NameTotal() : String
      {
         return this.FNameTotal;
      }
      
      public function set NameTotal(param1:String) : void
      {
         this.FNameTotal = param1;
      }
      
      public function get IsBattled() : Boolean
      {
         return this.FIsBattled;
      }
      
      public function set IsBattled(param1:Boolean) : void
      {
         this.FIsBattled = param1;
      }
   }
}

