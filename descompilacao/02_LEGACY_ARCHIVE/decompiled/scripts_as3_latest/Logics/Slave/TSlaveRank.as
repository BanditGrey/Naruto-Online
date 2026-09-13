package Logics.Slave
{
   public class TSlaveRank
   {
      
      protected var FRank:uint;
      
      protected var FUserName:String;
      
      protected var FServer:String;
      
      protected var FCount:uint;
      
      public function TSlaveRank()
      {
         super();
      }
      
      public function get Rank() : uint
      {
         return this.FRank;
      }
      
      public function set Rank(param1:uint) : void
      {
         this.FRank = param1;
      }
      
      public function get UserName() : String
      {
         return this.FUserName;
      }
      
      public function set UserName(param1:String) : void
      {
         this.FUserName = param1;
      }
      
      public function get Server() : String
      {
         return this.FServer;
      }
      
      public function set Server(param1:String) : void
      {
         this.FServer = param1;
      }
      
      public function get Count() : uint
      {
         return this.FCount;
      }
      
      public function set Count(param1:uint) : void
      {
         this.FCount = param1;
      }
   }
}

