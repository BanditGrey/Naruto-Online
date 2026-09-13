package Logics.Globalboss
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TDafubenAward;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TGlobalbossChapter
   {
      
      public var Identity:int;
      
      public var starNum:int;
      
      public var unlock:int;
      
      public var rewardInfo:Vector.<Object>;
      
      public var Next:TGlobalbossChapter;
      
      protected var FDafubenAward:TDafubenAward;
      
      protected var FDafubenAwardBins:TBins;
      
      public function TGlobalbossChapter()
      {
         super();
         this.FDafubenAwardBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DafubenAward);
         this.rewardInfo = new Vector.<Object>();
      }
      
      public function get DafubenAward() : TDafubenAward
      {
         this.FDafubenAward = this.FDafubenAwardBins.GetDatebaseByIdentifier(this.Identity) as TDafubenAward;
         return this.FDafubenAward;
      }
      
      public function get DafubenAwards() : Vector.<TDafubenAward>
      {
         var _loc1_:TDafubenAward = null;
         var _loc2_:int = 0;
         var _loc3_:Vector.<TDafubenAward> = null;
         _loc3_ = new Vector.<TDafubenAward>();
         if(this.FDafubenAwardBins)
         {
            _loc2_ = 0;
            while(_loc2_ < this.FDafubenAwardBins.Count)
            {
               _loc1_ = this.FDafubenAwardBins.GetDatebaseByIndex(_loc2_) as TDafubenAward;
               if(_loc1_.Identifier == this.Identity)
               {
                  _loc3_.push(_loc1_);
               }
               _loc2_++;
            }
         }
         return _loc3_;
      }
   }
}

