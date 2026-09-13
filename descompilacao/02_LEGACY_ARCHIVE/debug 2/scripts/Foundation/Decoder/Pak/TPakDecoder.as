package Foundation.Decoder.Pak
{
   import Foundation.Common.*;
   import Foundation.Worker.SMainWorker;
   import Foundation.Worker.WorkerCompat;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.system.ImageDecodingPolicy;
   import flash.system.LoaderContext;
   import flash.utils.*;
   
   public class TPakDecoder extends EventDispatcher
   {
      
      protected var FLoader:Loader;
      
      protected var FLoaderContext0:LoaderContext;
      
      protected var FBitmapDatas:Array;
      
      protected var FLoadList:Vector.<ByteArray>;
      
      protected var FSizes:Vector.<TCoordinate>;
      
      protected var FWidth:int;
      
      protected var FHeight:int;
      
      protected var FType:int;
      
      protected var FLoadNum:int;
      
      protected var FLength:int;
      
      protected var FBytes:ByteArray;
      
      protected var FResult:Vector.<BitmapData>;
      
      protected var FQuality:int;
      
      protected var FAlphaQuality:int;
      
      protected var FAlphaFilter:int;
      
      protected var FTag:int;
      
      public function TPakDecoder(param1:ByteArray = null)
      {
         super();
         this.FLoader = new Loader();
         this.FLoaderContext0 = new LoaderContext();
         this.FLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.LoadHandlerOnComplete);
         this.FLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.LoadHandlerOnIOError);
         this.FLoadList = new Vector.<ByteArray>();
         this.FBitmapDatas = new Array();
         this.FResult = new Vector.<BitmapData>();
         this.FSizes = new Vector.<TCoordinate>();
         this.FBytes = param1;
      }
      
      protected function ReadData(param1:ByteArray) : void
      {
         var _loc4_:ByteArray = null;
         var _loc2_:int = int(param1.readUnsignedInt());
         var _loc3_:ByteArray = new ByteArray();
         param1.readBytes(_loc3_,0,_loc2_);
         this.FLoadList.push(_loc3_);
         if(this.FAlphaQuality != 0 && this.FQuality != this.FAlphaQuality)
         {
            _loc4_ = new ByteArray();
            _loc2_ = int(param1.readUnsignedInt());
            if(_loc2_)
            {
               param1.readBytes(_loc4_,0,_loc2_);
            }
            this.FLoadList.push(_loc4_);
         }
      }
      
      protected function LoadNext() : void
      {
         var Index:int = 0;
         var Count:int = 0;
         var Data:ByteArray = null;
         var StrImageDecodingPolicy:String = null;
         if(this.FWidth > 50 || this.FHeight > 50)
         {
            StrImageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
         }
         else
         {
            StrImageDecodingPolicy = ImageDecodingPolicy.ON_DEMAND;
         }
         this.FLoaderContext0.imageDecodingPolicy = StrImageDecodingPolicy;
         Data = this.FLoadList[this.FLoadNum];
         try
         {
            this.FLoader.loadBytes(Data,this.FLoaderContext0);
         }
         catch(error:Error)
         {
         }
      }
      
      protected function LoadHandlerOnComplete(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Loader = null;
         _loc4_ = (param1.currentTarget as LoaderInfo).loader;
         _loc3_ = int(this.FLoadList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FLoadList[_loc2_].length == _loc4_.contentLoaderInfo.bytesTotal)
            {
               this.FBitmapDatas[_loc2_] = (_loc4_.content as Bitmap).bitmapData;
               break;
            }
            _loc2_++;
         }
         if(this.FBitmapDatas.length < this.FLoadList.length)
         {
            ++this.FLoadNum;
            this.LoadNext();
         }
         else
         {
            this.LoadAllComplete();
         }
      }
      
      protected function LoadHandlerOnIOError(param1:ErrorEvent) : void
      {
         dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
      }
      
      protected function ProcessorOnBackToMain(param1:Vector.<BitmapData>) : void
      {
         SMainWorker.OnBackToMain = null;
         this.FResult = param1;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      protected function LoadAllComplete() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TCoordinate = null;
         var _loc4_:BitmapData = null;
         var _loc5_:BitmapData = null;
         var _loc6_:Point = null;
         var _loc7_:BitmapData = null;
         var _loc8_:Rectangle = null;
         var _loc9_:Boolean = false;
         _loc9_ = WorkerCompat.WorkersSupported;
         if(_loc9_)
         {
            SMainWorker.OnBackToMain = this.ProcessorOnBackToMain;
            SMainWorker.PerformPakDecoder(this.FBitmapDatas,this.FQuality,this.FAlphaQuality,this.FAlphaFilter,this.FSizes,this.FLength);
         }
         else
         {
            _loc6_ = new Point();
            _loc2_ = 0;
            _loc4_ = this.FBitmapDatas[0];
            if(this.FResult == null)
            {
               this.FResult = new Vector.<BitmapData>(this.FLength);
            }
            if(this.FAlphaQuality != 0 && this.FQuality != this.FAlphaQuality)
            {
               _loc5_ = this.FBitmapDatas[1];
            }
            _loc1_ = 0;
            while(_loc1_ < this.FLength)
            {
               _loc3_ = this.FSizes[_loc1_];
               if(_loc3_.X == 0 || _loc3_.Y == 0)
               {
                  _loc3_ = new TCoordinate();
                  _loc3_.X = 1;
                  _loc3_.Y = 1;
               }
               _loc7_ = new BitmapData(_loc3_.X,_loc3_.Y,true,0);
               _loc8_ = new Rectangle(_loc2_,0,_loc3_.X,_loc3_.Y);
               _loc7_.copyPixels(_loc4_,_loc8_,_loc6_);
               if(this.FAlphaQuality != 0 && this.FQuality != this.FAlphaQuality)
               {
                  _loc7_.copyChannel(_loc5_,_loc8_,_loc6_,BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
               }
               else
               {
                  _loc7_.copyChannel(_loc4_,new Rectangle(_loc2_,_loc4_.height / 2,_loc3_.X,_loc3_.Y),_loc6_,BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
               }
               this.DoAlphaFilter(_loc7_);
               this.FResult[_loc1_] = _loc7_;
               _loc2_ += _loc3_.X;
               _loc1_++;
            }
            _loc4_.dispose();
            if(_loc5_ != null)
            {
               _loc5_.dispose();
            }
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      protected function DoAlphaFilter(param1:BitmapData) : void
      {
         var _loc2_:Point = null;
         _loc2_ = new Point();
         if(this.FAlphaFilter)
         {
            param1.threshold(param1,param1.rect,_loc2_,"<",this.FAlphaFilter << 24,0,4278190080,true);
         }
      }
      
      public function get Bytes() : ByteArray
      {
         return this.FBytes;
      }
      
      public function set Bytes(param1:ByteArray) : void
      {
         this.FBytes = param1;
      }
      
      public function get Result() : Vector.<BitmapData>
      {
         return this.FResult;
      }
      
      public function get Quality() : int
      {
         return this.FQuality;
      }
      
      public function get AlphaQuality() : int
      {
         return this.FAlphaQuality;
      }
      
      public function get AlphaFilter() : int
      {
         return this.FAlphaFilter;
      }
      
      public function get Tag() : int
      {
         return this.FTag;
      }
      
      public function set Tag(param1:int) : void
      {
         this.FTag = param1;
      }
      
      public function Decode() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:ByteArray = null;
         var _loc7_:TCoordinate = null;
         _loc6_ = new ByteArray();
         this.FBytes.position = 0;
         this.FBytes.readBytes(_loc6_,0,this.FBytes.length);
         _loc6_.position = 0;
         _loc6_.uncompress();
         this.FType = _loc6_.readByte();
         this.FWidth = _loc6_.readUnsignedShort();
         this.FHeight = _loc6_.readUnsignedShort();
         this.FQuality = _loc6_.readByte();
         this.FAlphaQuality = _loc6_.readByte();
         this.FAlphaFilter = _loc6_.readByte();
         this.FLength = _loc6_.readUnsignedShort();
         this.FBitmapDatas.length = 0;
         this.FLoadList.length = 0;
         this.FSizes.length = 0;
         if(this.FType == 1)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FLength)
            {
               _loc2_ = _loc6_.readShort();
               _loc3_ = _loc6_.readShort();
               _loc4_ = _loc6_.readShort();
               _loc5_ = _loc6_.readShort();
               _loc7_ = new TCoordinate();
               _loc7_.X = _loc4_;
               _loc7_.Y = _loc5_;
               this.FSizes.push(_loc7_);
               _loc1_++;
            }
            this.ReadData(_loc6_);
         }
         this.FLoadNum = 0;
         this.LoadNext();
      }
      
      public function Clear() : void
      {
         var _loc1_:BitmapData = null;
         this.FLoadList.length = 0;
         this.FSizes.length = 0;
         this.FBytes.clear();
         this.FLoader.unload();
         try
         {
            this.FLoader.close();
         }
         catch(err:Error)
         {
         }
         if(this.FBitmapDatas.length != 0)
         {
            for each(_loc1_ in this.FBitmapDatas)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            this.FBitmapDatas.length = 0;
         }
         this.FResult = null;
      }
   }
}

