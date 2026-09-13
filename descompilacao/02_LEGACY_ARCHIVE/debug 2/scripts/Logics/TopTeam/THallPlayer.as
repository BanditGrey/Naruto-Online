package Logics.TopTeam
{
   import Logics.Characters.TDigest;
   
   public class THallPlayer extends TDigest
   {
      
      protected var FJob:uint;
      
      protected var FEnterTime:uint;
      
      public function THallPlayer(param1:uint, param2:uint)
      {
         super(param1,param2);
      }
      
      public function get Job() : uint
      {
         return this.FJob;
      }
      
      public function set Job(param1:uint) : void
      {
         this.FJob = param1;
      }
      
      public function get EnterTime() : uint
      {
         return this.FEnterTime;
      }
      
      public function set EnterTime(param1:uint) : void
      {
         this.FEnterTime = param1;
      }
   }
}

