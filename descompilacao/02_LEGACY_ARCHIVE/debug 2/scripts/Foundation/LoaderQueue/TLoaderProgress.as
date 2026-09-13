package Foundation.LoaderQueue
{
   import Foundation.Resources.Spaces.*;
   import Logics.Agent.SParametersCore;
   import flash.events.*;
   import flash.utils.*;
   
   use namespace ResourcesSpace;
   
   public class TLoaderProgress extends EventDispatcher
   {
      
      protected static const SIZE_DefaultFile:uint = 1 * 1024 * 1024;
      
      protected var FItems:Vector.<ILoaderAdapter>;
      
      protected var FIsStarted:Boolean;
      
      protected var FResourceSizeConfig:Dictionary;
      
      protected var FMax:uint;
      
      protected var FPendings:uint;
      
      protected var FTotalProgress:Number;
      
      protected var FBytesTotal:Number;
      
      protected var FBytesLoaded:Number;
      
      protected var FOnChange:Function;
      
      protected var FOnComplete:Function;
      
      public function TLoaderProgress()
      {
         super();
         this.FItems = new Vector.<ILoaderAdapter>();
         this.FIsStarted = false;
         this.FResourceSizeConfig = SParametersCore.ResourceSizeConfig;
      }
      
      protected function UpdateProgress() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ILoaderAdapter = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc6_:Number = NaN;
         _loc3_ = 0;
         _loc4_ = 0;
         _loc5_ = true;
         _loc6_ = 0;
         _loc1_ = 0;
         while(_loc1_ < this.Count)
         {
            _loc2_ = this.FItems[_loc1_];
            if(!isNaN(_loc2_.BytesLoaded / _loc2_.BytesTotal))
            {
               _loc6_ += _loc2_.BytesLoaded / _loc2_.BytesTotal;
               _loc4_ += _loc2_.BytesLoaded;
               _loc3_ += _loc2_.BytesTotal + SIZE_DefaultFile;
               if(_loc2_.IsAnalyticed)
               {
                  _loc4_ += SIZE_DefaultFile;
               }
               else
               {
                  _loc5_ = false;
               }
            }
            else if(_loc2_.BytesTotal == 0)
            {
               _loc3_ += SIZE_DefaultFile;
            }
            _loc1_++;
         }
         if(this.FMax - this.Count > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FMax - this.Count)
            {
               _loc3_ += SIZE_DefaultFile;
               _loc1_++;
            }
         }
         this.FTotalProgress = _loc6_ / this.Count;
         this.FBytesLoaded = _loc4_;
         this.FBytesTotal = _loc3_;
         if(this.FOnChange != null)
         {
            this.FOnChange();
         }
         if(this.FTotalProgress == 1 && _loc5_ && this.FPendings == 0)
         {
            if(this.FOnComplete != null)
            {
               this.FOnComplete();
            }
         }
      }
      
      public function get Count() : uint
      {
         return this.FItems.length;
      }
      
      public function set Max(param1:uint) : void
      {
         this.FMax = param1;
      }
      
      public function set Pendings(param1:uint) : void
      {
         this.FPendings = param1;
      }
      
      public function get TotalProgress() : Number
      {
         return this.FTotalProgress;
      }
      
      public function get BytesTotal() : Number
      {
         return this.FBytesTotal;
      }
      
      public function get BytesLoaded() : Number
      {
         return this.FBytesLoaded;
      }
      
      public function get OnChange() : Function
      {
         return this.FOnChange;
      }
      
      public function set OnChange(param1:Function) : void
      {
         this.FOnChange = param1;
      }
      
      public function get OnComplete() : Function
      {
         return this.FOnComplete;
      }
      
      public function set OnComplete(param1:Function) : void
      {
         this.FOnComplete = param1;
      }
      
      ResourcesSpace function AddItem(param1:ILoaderAdapter) : void
      {
         if(this.FItems.indexOf(param1) == -1)
         {
            this.FItems.push(param1);
            this.UpdateProgress();
         }
      }
      
      ResourcesSpace function RemoveItem(param1:ILoaderAdapter) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FItems.indexOf(param1);
         if(_loc2_ != -1)
         {
            this.FItems.splice(_loc2_,1);
            this.UpdateProgress();
         }
      }
      
      public function Start() : void
      {
         this.FIsStarted = true;
      }
      
      public function Stop() : void
      {
         this.FMax = 0;
         this.FPendings = 0;
         this.FIsStarted = false;
      }
      
      public function Clear() : void
      {
         var _loc1_:* = 0;
         var _loc2_:ILoaderAdapter = null;
         var _loc3_:Vector.<ILoaderAdapter> = null;
         this.Stop();
         if(this.FItems == null)
         {
            return;
         }
         _loc1_ = int(this.Count - 1);
         while(_loc1_ >= 0)
         {
            _loc2_ = this.FItems.pop();
            if(!_loc2_.IsAnalyticed)
            {
               if(_loc3_ == null)
               {
                  _loc3_ = new Vector.<ILoaderAdapter>();
               }
               _loc3_.push(_loc2_);
            }
            else
            {
               _loc2_.Dispose();
               _loc2_ = null;
            }
            _loc1_--;
         }
         if(_loc3_ != null)
         {
            this.FItems = _loc3_;
         }
      }
      
      public function Dispose() : void
      {
         this.Clear();
         this.FItems = null;
      }
      
      public function Update() : void
      {
         if(this.FIsStarted)
         {
            this.UpdateProgress();
         }
      }
   }
}

