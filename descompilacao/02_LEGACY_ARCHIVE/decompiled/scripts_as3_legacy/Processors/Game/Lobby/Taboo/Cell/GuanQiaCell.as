package Processors.Game.Lobby.Taboo.Cell
{
   public class GuanQiaCell
   {
      
      protected var FmodeId:uint;
      
      protected var FScreenId:uint;
      
      protected var FCurCustomed:uint;
      
      protected var FIsGetRewards:Boolean;
      
      protected var FCurBeginCustomed:uint;
      
      protected var FCurStage:int;
      
      public function GuanQiaCell()
      {
         super();
      }
      
      public function set CurCustomed(param1:uint) : void
      {
         this.FCurCustomed = param1;
      }
      
      public function set CurStage(param1:int) : void
      {
         this.FCurStage = param1;
      }
      
      public function get CurStage() : int
      {
         return this.FCurStage;
      }
      
      public function get modeId() : uint
      {
         return this.FmodeId;
      }
      
      public function set modeId(param1:uint) : void
      {
         this.FmodeId = param1;
      }
      
      public function get ScreenId() : uint
      {
         return this.FScreenId;
      }
      
      public function set ScreenId(param1:uint) : void
      {
         this.FScreenId = param1;
      }
      
      public function get CurCustomed() : uint
      {
         return this.FCurCustomed;
      }
      
      public function set IsGetRewards(param1:Boolean) : void
      {
         this.FIsGetRewards = param1;
      }
      
      public function get IsGetRewards() : Boolean
      {
         return this.FIsGetRewards;
      }
      
      public function set CurBeginCustomed(param1:uint) : void
      {
         this.FCurBeginCustomed = param1;
      }
      
      public function get CurBeginCustomed() : uint
      {
         return this.FCurBeginCustomed;
      }
   }
}

