package Processors.Game.Lobby.MarryRank
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TMarryRankModel
   {
      
      public static var marryRank:TProcessorMarryRank;
      
      protected static var FMarryRankgift:TBins;
      
      public static var MarryRanks:Vector.<Object> = new Vector.<Object>();
      
      public static var MyRank:int = 0;
      
      public static var ProcessorOnRankRet:Function = null;
      
      public static var ProcessorOnReceiveRet:Function = null;
      
      public function TMarryRankModel()
      {
         super();
      }
      
      public static function get MarryRankgift() : TBins
      {
         if(FMarryRankgift == null)
         {
            FMarryRankgift = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_MarryRankgift);
         }
         return FMarryRankgift;
      }
   }
}

