package Logics.Exercise.BaseRank
{
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TActiveRankDataNew
   {
      
      public var CurMyRank:int;
      
      public var RankPoint:int;
      
      public var RankGiftList:Vector.<TBaseBox>;
      
      public var ScoreCommand:Vector.<int>;
      
      public var RankSpecialList:Vector.<TInventories>;
      
      public var RankPlayerList:Vector.<TConsumeRankInfo>;
      
      public function TActiveRankDataNew()
      {
         super();
         this.ScoreCommand = new Vector.<int>();
         this.RankGiftList = new Vector.<TBaseBox>();
         this.RankSpecialList = new Vector.<TInventories>();
         this.RankPlayerList = new Vector.<TConsumeRankInfo>();
      }
   }
}

