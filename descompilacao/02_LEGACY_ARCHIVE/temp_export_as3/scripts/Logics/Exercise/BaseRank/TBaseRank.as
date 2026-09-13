package Logics.Exercise.BaseRank
{
   public class TBaseRank
   {
      
      protected var FIdentify:int;
      
      protected var FRankList:Vector.<TRankInfo>;
      
      public function TBaseRank()
      {
         super();
         this.FRankList = new Vector.<TRankInfo>();
      }
      
      public function get Identify() : int
      {
         return this.FIdentify;
      }
      
      public function set Identify(param1:int) : void
      {
         this.FIdentify = param1;
      }
      
      public function get RankList() : Vector.<TRankInfo>
      {
         return this.FRankList;
      }
      
      public function set RankList(param1:Vector.<TRankInfo>) : void
      {
         this.FRankList = param1;
      }
   }
}

