package Foundation.Resources.Streamization.Bin
{
   import Foundation.LoaderQueue.Adapter.TURLLoaderAdapter;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Common.TPoolResourceRequest;
   import Foundation.Resources.Common.TResource;
   import Foundation.Resources.Common.TResourceRequest;
   import Foundation.Resources.Streamization.TResourceLoader;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class TResourceLoaderBin extends TResourceLoader
   {
      
      public function TResourceLoaderBin(param1:String, param2:String, param3:TPoolResourceRequest, param4:uint, param5:uint)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override protected function ConstructLoaderAdapter(param1:URLRequest) : void
      {
         FLoaderAdapter = new TURLLoaderAdapter(FPriority,param1);
      }
      
      override protected function ConstructUnstreamizer() : void
      {
         FUnstreamizer = new TResourceUnstreamizerBin();
         FUnstreamizer.OnResourceUnstreamized = UnstreamizerOnResourceUnstreamized;
      }
      
      override protected function ResourceInstantialize(param1:TResourceRequest) : TResource
      {
         return new TBins(param1.Identifier);
      }
      
      override protected function LoadingPerform_Wait() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:TResourceRequest = null;
         var _loc4_:ByteArray = null;
         var _loc5_:ByteArray = null;
         var _loc6_:TURLLoaderAdapter = null;
         super.LoadingPerform_Wait();
         if(FLoaderAdapter == null)
         {
            return;
         }
         _loc6_ = FLoaderAdapter as TURLLoaderAdapter;
         _loc4_ = _loc6_.Data;
         if(_loc4_ != null)
         {
            _loc4_.endian = Endian.LITTLE_ENDIAN;
            FLoadingStream = _loc4_;
            FLoadingStream.position = 0;
            FLoadingState = LOADINGSTATE_UnstreamizationRequest;
         }
      }
   }
}

