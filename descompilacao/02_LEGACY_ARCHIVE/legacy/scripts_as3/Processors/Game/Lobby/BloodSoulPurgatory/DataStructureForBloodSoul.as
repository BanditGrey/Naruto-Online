package Processors.Game.Lobby.BloodSoulPurgatory
{
   public class DataStructureForBloodSoul
   {
      
      protected var FSoulId:int;
      
      protected var FCurExp:int;
      
      protected var FgoldTimes:int;
      
      protected var Ftype:int;
      
      public function DataStructureForBloodSoul()
      {
         super();
      }
      
      public function set SoulId(param1:int) : void
      {
         this.FSoulId = param1;
      }
      
      public function get SoulId() : int
      {
         return this.FSoulId;
      }
      
      public function set CurExp(param1:int) : void
      {
         this.FCurExp = param1;
      }
      
      public function get CurExp() : int
      {
         return this.FCurExp;
      }
      
      public function set goldTimes(param1:int) : void
      {
         this.FgoldTimes = param1;
      }
      
      public function get goldTimes() : int
      {
         return this.FgoldTimes;
      }
      
      public function set type(param1:int) : void
      {
         this.Ftype = param1;
      }
      
      public function get type() : int
      {
         return this.Ftype;
      }
   }
}

