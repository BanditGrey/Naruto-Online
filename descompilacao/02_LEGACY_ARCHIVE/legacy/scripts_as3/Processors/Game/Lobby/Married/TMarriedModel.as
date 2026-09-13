package Processors.Game.Lobby.Married
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.getTimer;
   
   public class TMarriedModel
   {
      
      protected static var FWeddingTime:TBins;
      
      public static var ClientTime:int = 0;
      
      public static var ServerTime:int = 0;
      
      public static var EffectGenerateTextByErrorCode:Function = null;
      
      public static var married:TProcessorMarried = null;
      
      public function TMarriedModel()
      {
         super();
      }
      
      public static function get WeddingTime() : TBins
      {
         if(FWeddingTime == null)
         {
            FWeddingTime = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_WeddingTime);
         }
         return FWeddingTime;
      }
      
      public static function get CurrentServerTime() : int
      {
         return ServerTime + (getTimer() / 1000 - ClientTime);
      }
   }
}

