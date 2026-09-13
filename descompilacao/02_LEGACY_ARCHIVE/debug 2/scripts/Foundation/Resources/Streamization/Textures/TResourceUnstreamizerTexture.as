package Foundation.Resources.Streamization.Textures
{
   import Debugging.*;
   import Foundation.Decoder.Pak.*;
   import Foundation.Resources.Common.*;
   import Foundation.Resources.Spaces.*;
   import Foundation.Resources.Streamization.*;
   import Foundation.Resources.Textures.*;
   import Foundation.Utilities.*;
   import Foundation.Worker.SMainWorker;
   import Foundation.Worker.WorkerCompat;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   
   use namespace ResourcesSpace;
   
   public class TResourceUnstreamizerTexture extends TResourceUnstreamizerAsynchronous
   {
      
      protected static const UNSTREAMIZATIONSTATE_Properties:int = 1;
      
      protected static const UNSTREAMIZATIONSTATE_SurfaceInitialization:int = 2;
      
      protected static const UNSTREAMIZATIONSTATE_SurfaceLoad:int = 3;
      
      protected static const UNSTREAMIZATIONSTATE_SurfaceWait:int = 4;
      
      protected static const UNSTREAMIZATIONSTATE_Traversal:int = 5;
      
      protected static const UNSTREAMIZATIONSTATE_Finalize:int = 6;
      
      protected var FUnstreamizerSequence:TUnstreamizerAnimationSequence;
      
      protected var FPakDecoder:TPakDecoder;
      
      protected var FTexture:TTexture;
      
      protected var FTextureData:ByteArray;
      
      protected var FBitmapDatas:Vector.<Vector.<BitmapData>>;
      
      protected var FCurrentCount:uint;
      
      protected var FDecoderCount:int;
      
      protected var FValidatingIdentifier:Boolean;
      
      public function TResourceUnstreamizerTexture()
      {
         super();
         this.FUnstreamizerSequence = new TUnstreamizerAnimationSequence();
         this.FPakDecoder = new TPakDecoder();
         this.FPakDecoder.addEventListener(Event.COMPLETE,this.LoadPakOnCompleteHandler);
         this.FPakDecoder.addEventListener(IOErrorEvent.IO_ERROR,this.LoadPakOnIOErrorHandler);
         this.FValidatingIdentifier = true;
      }
      
      override protected function UnstreamizationRegisterRountines() : void
      {
         FUnstreamizationRoutines.Register(UNSTREAMIZATIONSTATE_Properties,this.UnstreamizationPerform_Properties);
         FUnstreamizationRoutines.Register(UNSTREAMIZATIONSTATE_SurfaceInitialization,this.UnstreamizationPerform_SurfaceInitialization);
         FUnstreamizationRoutines.Register(UNSTREAMIZATIONSTATE_SurfaceLoad,this.UnstreamizationPerform_SurfaceLoad);
         FUnstreamizationRoutines.Register(UNSTREAMIZATIONSTATE_SurfaceWait,this.UnstreamizationPerform_SurfaceWait);
         FUnstreamizationRoutines.Register(UNSTREAMIZATIONSTATE_Traversal,this.UnstreamizationPerform_Traversal);
         FUnstreamizationRoutines.Register(UNSTREAMIZATIONSTATE_Finalize,this.UnstreamizationPerform_Finalize);
      }
      
      override protected function UnstreamizationInitialize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         super.UnstreamizationInitialize(param1,param2,param3);
         this.FTexture = param2 as TTexture;
         FUnstreamizationState = UNSTREAMIZATIONSTATE_Properties;
      }
      
      override protected function UnstreamizationFinalize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<BitmapData> = null;
         super.UnstreamizationFinalize();
         this.FTexture = null;
         _loc1_ = 0;
         while(_loc1_ < this.FBitmapDatas.length)
         {
            _loc2_ = this.FBitmapDatas[_loc1_];
            _loc2_.length = 0;
            _loc1_++;
         }
         this.FBitmapDatas.length = 0;
      }
      
      protected function UnstreamizationPerform_Properties() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = FStream.readUnsignedInt();
         if(this.FValidatingIdentifier)
         {
            if(_loc1_ != this.FTexture.Identifier)
            {
               _loc1_ = this.FTexture.Identifier;
            }
         }
         this.FTexture.Coerce(_loc1_);
         FUnstreamizationState = UNSTREAMIZATIONSTATE_SurfaceInitialization;
      }
      
      protected function UnstreamizationPerform_SurfaceInitialization() : void
      {
         var _loc1_:uint = 0;
         this.FCurrentCount = 0;
         _loc1_ = FStream.readUnsignedInt();
         this.FTextureData = new ByteArray();
         this.FTextureData.endian = Endian.LITTLE_ENDIAN;
         FStream.readBytes(this.FTextureData,0,_loc1_);
         this.FDecoderCount = FStream.readUnsignedShort();
         this.FBitmapDatas = new Vector.<Vector.<BitmapData>>(this.FDecoderCount);
         FUnstreamizationState = UNSTREAMIZATIONSTATE_SurfaceLoad;
      }
      
      protected function UnstreamizationPerform_SurfaceLoad() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:Boolean = false;
         _loc4_ = WorkerCompat.WorkersSupported;
         if(_loc4_)
         {
            if(!SMainWorker.IsFree)
            {
               return;
            }
         }
         if(this.FCurrentCount < this.FDecoderCount)
         {
            _loc2_ = FStream.readUnsignedInt();
            _loc3_ = new ByteArray();
            _loc3_.endian = Endian.LITTLE_ENDIAN;
            FStream.readBytes(_loc3_,0,_loc2_);
            if(_loc4_)
            {
               SMainWorker.IsFree = false;
            }
            this.FPakDecoder.Bytes = _loc3_;
            this.FPakDecoder.Tag = this.FCurrentCount;
            this.FPakDecoder.Decode();
         }
         FUnstreamizationState = UNSTREAMIZATIONSTATE_SurfaceWait;
      }
      
      protected function UnstreamizationPerform_SurfaceWait() : void
      {
         if(this.FDecoderCount != this.FCurrentCount)
         {
            return;
         }
         FUnstreamizationState = UNSTREAMIZATIONSTATE_Traversal;
      }
      
      protected function UnstreamizationPerform_Traversal() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TAnimationSequence = null;
         _loc1_ = int(FStream.readUnsignedShort());
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = new TAnimationSequence(0);
            this.FUnstreamizerSequence.Unstreamize(this.FTextureData,_loc3_,this.FBitmapDatas[_loc2_]);
            this.FTexture.SequenceAppend(_loc3_);
            _loc2_++;
         }
         FUnstreamizationState = UNSTREAMIZATIONSTATE_Finalize;
      }
      
      protected function UnstreamizationPerform_Finalize() : void
      {
         var _loc1_:TTexture = null;
         _loc1_ = this.FTexture;
         this.UnstreamizationFinalize();
         FUnstreamizationState = UNSTREAMIZATIONSTATE_Idle;
         ResourceNotifyUnstreamized(_loc1_);
      }
      
      protected function SurfaceLoadersOnComplete(param1:Event) : void
      {
         UnstreamizationPerform(FStream,FDestination,FCorrelator);
      }
      
      protected function LoadPakOnCompleteHandler(param1:Event) : void
      {
         var _loc2_:TPakDecoder = null;
         var _loc3_:Boolean = false;
         _loc2_ = param1.currentTarget as TPakDecoder;
         var _loc4_:Number;
         this.FBitmapDatas[_loc4_ = this.FCurrentCount++] = _loc2_.Result;
         _loc2_.Clear();
         _loc3_ = WorkerCompat.WorkersSupported;
         if(_loc3_)
         {
            SMainWorker.IsFree = true;
         }
         FUnstreamizationState = UNSTREAMIZATIONSTATE_SurfaceLoad;
      }
      
      protected function LoadPakOnIOErrorHandler(param1:IOErrorEvent) : void
      {
      }
      
      public function get ValidatingIdentifier() : Boolean
      {
         return this.FValidatingIdentifier;
      }
      
      public function set ValidatingIdentifier(param1:Boolean) : void
      {
         this.FValidatingIdentifier = param1;
      }
   }
}

