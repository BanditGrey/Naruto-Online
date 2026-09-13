package Foundation.Resources.Streamization.SWF
{
   import Foundation.LoaderQueue.Adapter.TLoaderAdapter;
   import Foundation.Resources.Common.TPoolResourceRequest;
   import Foundation.Resources.Common.TResource;
   import Foundation.Resources.Common.TResourceRequest;
   import Foundation.Resources.SWF.TSwf;
   import Foundation.Resources.Streamization.TResourceLoader;
   import flash.display.DisplayObject;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class TResourceLoaderSwf extends TResourceLoader
   {
      
      public function TResourceLoaderSwf(param1:String, param2:String, param3:TPoolResourceRequest, param4:uint, param5:uint)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override protected function ConstructLoaderAdapter(param1:URLRequest) : void
      {
         FLoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         FLoaderAdapter = new TLoaderAdapter(FPriority,param1,FLoaderContext);
      }
      
      override protected function ConstructUnstreamizer() : void
      {
         FUnstreamizer = new TResourceUnstreamizerSwf();
         FUnstreamizer.OnResourceUnstreamized = UnstreamizerOnResourceUnstreamized;
      }
      
      override protected function ResourceInstantialize(param1:TResourceRequest) : TResource
      {
         return new TSwf(param1.Identifier);
      }
      
      override protected function LoadingPerform_Request() : void
      {
         super.LoadingPerform_Request();
      }
      
      override protected function LoadingPerform_Wait() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:TLoaderAdapter = null;
         super.LoadingPerform_Wait();
         if(FLoaderAdapter == null)
         {
            return;
         }
         _loc2_ = FLoaderAdapter as TLoaderAdapter;
         _loc1_ = _loc2_.Content;
         if(_loc1_ != null)
         {
            FLoadingState = LOADINGSTATE_UnstreamizationRequest;
         }
      }
      
      override protected function LoadingPerform_UnstreamizationRequest() : void
      {
         FLoadingState = LOADINGSTATE_UnstreamizationWait;
      }
      
      override protected function LoadingPerform_UnstreamizationWait() : void
      {
         FLoadingState = LOADINGSTATE_Finalize;
      }
   }
}

