package Foundation.Resources.Streamization
{
   import Debugging.*;
   import Foundation.Common.*;
   import Foundation.LoaderQueue.*;
   import Foundation.Registries.*;
   import Foundation.Resources.Common.*;
   import Foundation.Resources.Spaces.*;
   import Foundation.Timing.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Agent.*;
   import Resources.Constants.CONST_COMMON;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.utils.*;
   
   use namespace ResourcesSpace;
   
   public class TResourceLoader extends EventDispatcher
   {
      
      protected static var FLoaderQueue:TLoaderQueue;
      
      protected static const LOADINGSTATE_Failure:int = -1;
      
      protected static const LOADINGSTATE_Idle:uint = 0;
      
      protected static const LOADINGSTATE_Request:uint = 1;
      
      protected static const LOADINGSTATE_Wait:uint = 2;
      
      protected static const LOADINGSTATE_UnstreamizationRequest:uint = 3;
      
      protected static const LOADINGSTATE_UnstreamizationWait:uint = 4;
      
      protected static const LOADINGSTATE_Finalize:uint = 5;
      
      public static const TYPE_Primary:uint = 0;
      
      public static const TYPE_Secondary:uint = 1;
      
      ConstructLoader();
      
      protected var FRequests:TEntityList;
      
      protected var FLoaderAdaptes:Vector.<ILoaderAdapter>;
      
      protected var FLoaderAdapter:ILoaderAdapter;
      
      protected var FLoaderContext:LoaderContext;
      
      protected var FUnstreamizer:TResourceUnstreamizer;
      
      protected var FLoadingRoutines:TRegistryRoutine;
      
      protected var FLoadingState:int;
      
      protected var FLoadingRequest:TResourceRequest;
      
      protected var FLoadingStream:ByteArray;
      
      protected var FLoadingResource:TResource;
      
      protected var FResourcePath:String;
      
      protected var FResourceSuffix:String;
      
      protected var FPoolResourceRequest:TPoolResourceRequest;
      
      protected var FLoadType:uint;
      
      protected var FResourceConfig:Dictionary;
      
      protected var FOnResourceUnstreamized:Function;
      
      protected var FOnLoadFailedResource:Function;
      
      protected var FPriority:uint;
      
      public function TResourceLoader(param1:String, param2:String, param3:TPoolResourceRequest, param4:uint, param5:uint = 100)
      {
         super();
         this.FLoaderAdaptes = new Vector.<ILoaderAdapter>();
         this.FResourcePath = param1;
         this.FResourceSuffix = param2;
         this.FPoolResourceRequest = param3;
         this.FResourceConfig = SParametersCore.ResourceVersionConfig;
         this.FPriority = param5;
         this.FLoadType = param4;
         this.FRequests = new TEntityList();
         this.ConstructUnstreamizer();
         this.FLoadingRoutines = new TRegistryRoutine();
         this.LoadingRegisterRoutines();
      }
      
      protected static function ConstructLoader() : void
      {
         FLoaderQueue = new TLoaderQueue(CONST_COMMON.MAX_LOADING_SYNC,10,true);
         FLoaderQueue.addEventListener(TLoaderQueueEvent.TASK_ERROR,LoaderOnTaskError);
      }
      
      protected static function LoaderOnTaskError(param1:TLoaderQueueEvent) : void
      {
      }
      
      protected function AddEventListener() : void
      {
         this.FLoaderAdapter.addEventListener(TLoaderQueueEvent.TASK_COMPLETED,this.LoaderAdapterOnComplete);
      }
      
      protected function RemoveEventListener(param1:ILoaderAdapter) : void
      {
         param1.removeEventListener(TLoaderQueueEvent.TASK_COMPLETED,this.LoaderAdapterOnComplete);
      }
      
      protected function ConstructLoaderAdapter(param1:URLRequest) : void
      {
      }
      
      protected function ConstructUnstreamizer() : void
      {
      }
      
      protected function ResourceURL(param1:TResourceRequest) : String
      {
         return this.FResourcePath + TUtilityHexadecimal.Format(param1.Identifier,8) + this.FResourceSuffix;
      }
      
      protected function ResourceInstantialize(param1:TResourceRequest) : TResource
      {
         return null;
      }
      
      protected function ResourceNotifyUnstreamized(param1:TResource) : void
      {
         if(this.FOnResourceUnstreamized != null)
         {
            this.FOnResourceUnstreamized(this,param1);
         }
      }
      
      protected function LoadingRegisterRoutines() : void
      {
         this.FLoadingRoutines.Register(LOADINGSTATE_Failure,this.LoadingPerform_Failure);
         this.FLoadingRoutines.Register(LOADINGSTATE_Idle,this.LoadingPerform_Idle);
         this.FLoadingRoutines.Register(LOADINGSTATE_Request,this.LoadingPerform_Request);
         this.FLoadingRoutines.Register(LOADINGSTATE_Wait,this.LoadingPerform_Wait);
         this.FLoadingRoutines.Register(LOADINGSTATE_UnstreamizationRequest,this.LoadingPerform_UnstreamizationRequest);
         this.FLoadingRoutines.Register(LOADINGSTATE_UnstreamizationWait,this.LoadingPerform_UnstreamizationWait);
         this.FLoadingRoutines.Register(LOADINGSTATE_Finalize,this.LoadingPerform_Finalize);
      }
      
      protected function LoadingPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Function = null;
         do
         {
            _loc1_ = this.FLoadingState;
            _loc2_ = this.FLoadingRoutines.GetRoutineByIndentifier(this.FLoadingState);
            if(_loc2_ != null)
            {
               _loc2_();
            }
         }
         while(_loc1_ != this.FLoadingState);
      }
      
      protected function LoadingPerform_Failure() : void
      {
      }
      
      protected function LoadingPerform_Idle() : void
      {
         if(this.FRequests.Count != 0)
         {
            this.FLoadingState = LOADINGSTATE_Request;
         }
      }
      
      protected function LoadingPerform_Request() : void
      {
         var _loc1_:String = null;
         var _loc2_:URLRequest = null;
         var _loc3_:String = null;
         this.FLoadingRequest = this.FRequests.GetEntityByIndex(0) as TResourceRequest;
         _loc1_ = this.ResourceURL(this.FLoadingRequest);
         if(this.FResourceConfig)
         {
            _loc3_ = this.FResourceConfig[_loc1_];
         }
         if(_loc3_ == null)
         {
            if(SParametersCore.ClientVersion == 0)
            {
               _loc3_ = "";
            }
            else
            {
               _loc3_ = SParametersCore.ClientVersion.toString();
            }
         }
         if(_loc3_.length > 0)
         {
            _loc1_ = _loc3_ + "/" + _loc1_;
         }
         _loc1_ = SParametersCore.CdnRoot + _loc1_;
         _loc2_ = new URLRequest();
         _loc2_.url = _loc1_;
         this.ConstructLoaderAdapter(_loc2_);
         this.FLoaderAdapter.Identifier = this.FLoadingRequest.Identifier;
         if(this.FLoadType == TYPE_Primary)
         {
            SLoaderProgress.AddItem(this.FLoaderAdapter);
         }
         FLoaderQueue.AddItem(this.FLoaderAdapter);
         this.AddEventListener();
         this.FLoadingState = LOADINGSTATE_Wait;
      }
      
      protected function LoadingPerform_Wait() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ILoaderAdapter = null;
         this.FLoaderAdapter = null;
         _loc2_ = int(this.FLoaderAdaptes.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FLoaderAdaptes[_loc1_];
            if(_loc3_.IsCompleted)
            {
               this.FLoaderAdapter = _loc3_;
               break;
            }
            _loc1_++;
         }
      }
      
      protected function LoadingPerform_UnstreamizationRequest() : void
      {
         this.FLoadingResource = this.ResourceInstantialize(this.FLoadingRequest);
         this.FUnstreamizer.Unstreamize(this.FLoadingStream,this.FLoadingResource,null);
         this.FLoadingState = LOADINGSTATE_UnstreamizationWait;
      }
      
      protected function LoadingPerform_UnstreamizationWait() : void
      {
         this.FUnstreamizer.Process();
         if(this.FUnstreamizer.Unstreamizing)
         {
            return;
         }
         this.FLoadingState = LOADINGSTATE_Finalize;
      }
      
      protected function LoadingPerform_Finalize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TResourceRequest = null;
         _loc1_ = this.FLoaderAdaptes.indexOf(this.FLoaderAdapter);
         if(_loc1_ >= 0)
         {
            this.FLoaderAdaptes.splice(_loc1_,1);
         }
         this.FRequests.DeleteByIdentifier(this.FLoaderAdapter.Identifier);
         FLoaderQueue.RemoveItem(this.FLoaderAdapter);
         this.FLoaderAdapter.IsAnalyticed = true;
         if(this.FLoadType == TYPE_Secondary)
         {
            this.FLoaderAdapter.Dispose();
         }
         this.FLoadingRequest = null;
         this.FLoadingStream = null;
         this.FLoadingResource = null;
         this.FLoaderAdapter = null;
         this.FLoadingState = LOADINGSTATE_Idle;
      }
      
      protected function LoaderAdapterOnComplete(param1:TLoaderQueueEvent) : void
      {
         var _loc2_:ILoaderAdapter = null;
         _loc2_ = param1.target as ILoaderAdapter;
         _loc2_.removeEventListener(TLoaderQueueEvent.TASK_COMPLETED,this.LoaderAdapterOnComplete);
         this.FLoaderAdaptes.push(_loc2_);
         this.LoadingPerform();
      }
      
      protected function UnstreamizerOnResourceUnstreamized(param1:Object, param2:TResource) : void
      {
         this.ResourceNotifyUnstreamized(param2);
      }
      
      public function get Count() : int
      {
         return this.FRequests.Count;
      }
      
      public function get OnResourceUnstreamized() : Function
      {
         return this.FOnResourceUnstreamized;
      }
      
      public function set OnResourceUnstreamized(param1:Function) : void
      {
         this.FOnResourceUnstreamized = param1;
      }
      
      public function get OnLoadFailedResource() : Function
      {
         return this.FOnLoadFailedResource;
      }
      
      public function set OnLoadFailedResource(param1:Function) : void
      {
         this.FOnLoadFailedResource = param1;
      }
      
      public function get Priority() : uint
      {
         return this.FPriority;
      }
      
      public function Process() : void
      {
         this.LoadingPerform();
      }
      
      public function Load(param1:uint) : void
      {
         var _loc2_:TResourceRequest = null;
         _loc2_ = this.FPoolResourceRequest.Acquire(param1);
         this.FRequests.Add(_loc2_);
      }
      
      public function UnLoad(param1:uint) : void
      {
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:TResourceRequest = null;
         var _loc5_:ILoaderAdapter = null;
         _loc3_ = int(this.FLoaderAdaptes.length);
         _loc2_ = int(_loc3_ - 1);
         while(_loc2_ >= 0)
         {
            _loc5_ = this.FLoaderAdaptes[_loc2_];
            if(_loc5_.Identifier == param1)
            {
               this.FLoaderAdaptes.splice(_loc2_,1);
               this.FRequests.DeleteByIdentifier(param1);
               if(this.FLoaderAdapter != null)
               {
                  if(this.FLoaderAdapter.Identifier == param1)
                  {
                     this.FLoaderAdapter == null;
                  }
               }
               if(this.FLoadType == TYPE_Primary)
               {
                  SLoaderProgress.RemoveItem(_loc5_);
               }
               this.RemoveEventListener(_loc5_);
               FLoaderQueue.RemoveItem(_loc5_);
               _loc5_.Dispose();
               if(this.FLoadingState != LOADINGSTATE_UnstreamizationWait)
               {
                  if(this.FRequests.Count != 0)
                  {
                     this.FLoadingState = LOADINGSTATE_Request;
                  }
                  else
                  {
                     this.FLoadingState = LOADINGSTATE_Idle;
                  }
               }
               break;
            }
            _loc2_--;
         }
      }
      
      public function ResourceRequestedByIdentifier(param1:uint) : Boolean
      {
         return this.FRequests.GetEntityByIdentifier(param1) != null;
      }
   }
}

