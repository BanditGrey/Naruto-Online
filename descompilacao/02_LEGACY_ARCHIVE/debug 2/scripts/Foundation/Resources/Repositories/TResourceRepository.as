package Foundation.Resources.Repositories
{
   import Debugging.*;
   import Foundation.Common.*;
   import Foundation.Resources.Common.*;
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Resources.Streamization.*;
   import Foundation.Utilities.TUtilityHexadecimal;
   import Logging.SLogger;
   import Logging.TLogger;
   import flash.net.*;
   
   use namespace ResourcesSpace;
   
   public class TResourceRepository
   {
      
      protected static const TYPE_Primary:uint = TResourceLoader.TYPE_Primary;
      
      protected static const TYPE_Secondary:uint = TResourceLoader.TYPE_Secondary;
      
      protected var FPoolResourceRequest:TPoolResourceRequest;
      
      protected var FLoaderPrimary:TResourceLoader;
      
      protected var FLoaderSecondary:TResourceLoader;
      
      protected var FKnownIdentifiers:Vector.<uint>;
      
      protected var FResourcePath:String;
      
      protected var FAutoReleaseResourceID:Vector.<uint>;
      
      protected var FAutoLoadSourceModules:Vector.<uint>;
      
      protected var FIsAutoRelease:Boolean;
      
      protected var FPriority:uint;
      
      protected var FInstanceType:String;
      
      protected var FResources:TEntityList;
      
      public function TResourceRepository(param1:String, param2:uint)
      {
         super();
         this.FResourcePath = param1;
         this.FPriority = param2;
         this.FPoolResourceRequest = new TPoolResourceRequest();
         this.ConstructLoaders();
         this.FKnownIdentifiers = new Vector.<uint>();
         this.FResources = new TEntityList();
         this.FAutoReleaseResourceID = new Vector.<uint>();
         this.FAutoLoadSourceModules = new Vector.<uint>();
         this.FInstanceType = "";
      }
      
      protected function ConstructLoaders() : void
      {
      }
      
      protected function ProcessorLoadFailedResources(param1:Object, param2:uint) : void
      {
         var _loc3_:int = 0;
         _loc3_ = this.FKnownIdentifiers.indexOf(param2);
         if(_loc3_ >= 0)
         {
            this.FKnownIdentifiers.splice(_loc3_,1);
         }
      }
      
      private function LoadAutoRelease(param1:uint, param2:uint) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!this.FIsAutoRelease)
         {
            return;
         }
         if(param2 == 0 || param1 == 0)
         {
            return;
         }
         _loc3_ = this.FAutoReleaseResourceID.indexOf(param2);
         _loc4_ = this.FAutoLoadSourceModules.indexOf(param1);
         if(_loc3_ < 0 || _loc3_ > 0 && _loc4_ < 0)
         {
            this.FAutoReleaseResourceID.push(param2);
            this.FAutoLoadSourceModules.push(param1);
         }
      }
      
      protected function GetClassType() : String
      {
         return this.FInstanceType;
      }
      
      protected function LoadersOnResourceUnstreamized(param1:Object, param2:TResource) : void
      {
         this.FResources.Add(param2);
      }
      
      ResourcesSpace function get KnownIdentifiers() : Vector.<uint>
      {
         return this.FKnownIdentifiers;
      }
      
      public function get PrimaryCount() : int
      {
         return this.FLoaderPrimary.Count;
      }
      
      public function get SecondaryCount() : int
      {
         return this.FLoaderSecondary.Count;
      }
      
      public function get Loading() : Boolean
      {
         return this.LoadingPrimary || this.LoadingSecondary;
      }
      
      public function get LoadingPrimary() : Boolean
      {
         return this.FLoaderPrimary.Count != 0;
      }
      
      public function get LoadingSecondary() : Boolean
      {
         return this.FLoaderSecondary.Count != 0;
      }
      
      public function get Priority() : uint
      {
         return this.FPriority;
      }
      
      public function set Priority(param1:uint) : void
      {
         this.FPriority = param1;
      }
      
      public function get InstanceType() : String
      {
         return this.FInstanceType;
      }
      
      public function set InstanceType(param1:String) : void
      {
         this.FInstanceType = param1;
      }
      
      public function Process() : void
      {
         this.FLoaderPrimary.Process();
         this.FLoaderSecondary.Process();
      }
      
      public function LoadPrimary(param1:uint, param2:uint = 0) : void
      {
         var _loc3_:int = 0;
         _loc3_ = this.FKnownIdentifiers.indexOf(param1);
         this.LoadAutoRelease(param2,param1);
         if(_loc3_ >= 0)
         {
            return;
         }
         this.FKnownIdentifiers.push(param1);
         this.FLoaderPrimary.Load(param1);
      }
      
      public function LoadSecondary(param1:uint, param2:uint = 0) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:uint = 0;
         _loc3_ = this.FKnownIdentifiers.indexOf(param1);
         this.LoadAutoRelease(param2,param1);
         if(_loc3_ >= 0)
         {
            return;
         }
         this.FKnownIdentifiers.push(param1);
         this.FLoaderSecondary.Load(param1);
      }
      
      public function DeleteLoadingByIdentifier(param1:uint) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FKnownIdentifiers.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this.FKnownIdentifiers.splice(_loc2_,1);
         }
         this.FLoaderPrimary.UnLoad(param1);
         this.FLoaderSecondary.UnLoad(param1);
      }
      
      public function DeleteByIdentifier(param1:uint) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = this.FKnownIdentifiers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return false;
         }
         this.FKnownIdentifiers.splice(_loc2_,1);
         SLogger.TraceInformation(TLogger.LEVEL_UnLoad,"Deleted Resource ID: " + this.GetClassType() + TUtilityHexadecimal.Format(param1,8));
         return true;
      }
      
      public function PerformAutoReleaseResource(param1:uint) : void
      {
      }
   }
}

