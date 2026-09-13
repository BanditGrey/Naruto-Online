package Foundation.Resources.Repositories
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Common.TResource;
   import Foundation.Resources.Streamization.Bin.TResourceLoaderBin;
   import Logics.DatebaseVO.TDatebaseVO;
   
   public class TResourceRepositoryBin extends TResourceRepository
   {
      
      public function TResourceRepositoryBin(param1:String, param2:uint)
      {
         super(param1,param2);
      }
      
      override protected function ConstructLoaders() : void
      {
         FLoaderPrimary = new TResourceLoaderBin(FResourcePath,".bin",FPoolResourceRequest,TYPE_Primary,FPriority);
         FLoaderPrimary.OnResourceUnstreamized = this.LoadersOnResourceUnstreamized;
         FLoaderPrimary.OnLoadFailedResource = ProcessorLoadFailedResources;
         FLoaderSecondary = new TResourceLoaderBin(FResourcePath,".bin",FPoolResourceRequest,TYPE_Secondary,FPriority + 100);
         FLoaderSecondary.OnResourceUnstreamized = this.LoadersOnResourceUnstreamized;
         FLoaderSecondary.OnLoadFailedResource = ProcessorLoadFailedResources;
      }
      
      override protected function LoadersOnResourceUnstreamized(param1:Object, param2:TResource) : void
      {
         var _loc3_:TBins = null;
         _loc3_ = param2 as TBins;
         FResources.Add(_loc3_);
      }
      
      public function GetDatebase(param1:uint, param2:uint) : TDatebaseVO
      {
         var _loc3_:TBins = null;
         _loc3_ = this.GetBinsByResourceID(param1);
         return _loc3_.GetDatebaseByIdentifier(param2);
      }
      
      public function GetBinsByResourceID(param1:uint) : TBins
      {
         return FResources.GetEntityByIdentifier(param1) as TBins;
      }
   }
}

