package Foundation.Worker
{
   import Foundation.Common.TCoordinate;
   import Resources.Constants.CONST_WORKER;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class TMainWorker
   {
      
      protected var FBmpDataBytes:Vector.<ByteArray>;
      
      protected var FBmpDataRGBBytes:ByteArray;
      
      protected var FBmpDataAlphaBytes:ByteArray;
      
      protected var FIsInitWorker:Boolean;
      
      protected var FBitmapDatas:Vector.<BitmapData>;
      
      protected var FMainWorker:Object;
      
      protected var FMainToBack:Object;
      
      protected var FBackToMain:Object;
      
      protected var FOnBackToMain:Function;
      
      protected var FIsFree:Boolean;
      
      public function TMainWorker()
      {
         super();
         this.FIsFree = true;
         this.FIsInitWorker = false;
      }
      
      protected function ProcessorOnBackToMain(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Rectangle = null;
         var _loc6_:BitmapData = null;
         var _loc7_:ByteArray = null;
         var _loc8_:Boolean = false;
         var _loc9_:Object = null;
         _loc2_ = this.FBackToMain.receive();
         switch(_loc2_)
         {
            case CONST_WORKER.MESSAGE_PAKDECODER_COMPLETED:
               _loc4_ = int(this.FBackToMain.receive(true));
               this.FBitmapDatas = new Vector.<BitmapData>(_loc4_);
               _loc3_ = 0;
               while(_loc3_ < _loc4_)
               {
                  _loc8_ = Boolean(this.FBackToMain.receive(true));
                  _loc9_ = this.FBackToMain.receive(true);
                  _loc5_ = new Rectangle();
                  _loc5_.x = _loc9_.x;
                  _loc5_.y = _loc9_.y;
                  _loc5_.width = _loc9_.width;
                  _loc5_.height = _loc9_.height;
                  _loc6_ = new BitmapData(_loc5_.width,_loc5_.height,_loc8_);
                  _loc7_ = this.FBmpDataBytes[_loc3_];
                  _loc7_.position = 0;
                  _loc6_.setPixels(_loc5_,_loc7_);
                  _loc7_.clear();
                  this.FBitmapDatas[_loc3_] = _loc6_;
                  _loc3_++;
               }
               if(this.FOnBackToMain != null)
               {
                  this.FOnBackToMain(this.FBitmapDatas);
               }
         }
      }
      
      public function get MainWorker() : Object
      {
         return this.FMainWorker;
      }
      
      public function set MainWorker(param1:Object) : void
      {
         this.FMainWorker = param1;
      }
      
      public function get MainToBack() : Object
      {
         return this.FMainToBack;
      }
      
      public function set MainToBack(param1:Object) : void
      {
         this.FMainToBack = param1;
      }
      
      public function get BackToMain() : Object
      {
         return this.FBackToMain;
      }
      
      public function set BackToMain(param1:Object) : void
      {
         this.FBackToMain = param1;
      }
      
      public function get OnBackToMain() : Function
      {
         return this.FOnBackToMain;
      }
      
      public function set OnBackToMain(param1:Function) : void
      {
         this.FOnBackToMain = param1;
      }
      
      public function get IsFree() : Boolean
      {
         return this.FIsFree;
      }
      
      public function set IsFree(param1:Boolean) : void
      {
         this.FIsFree = param1;
      }
      
      public function InitWorker() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ByteArray = null;
         if(this.FIsInitWorker)
         {
            return;
         }
         this.FBackToMain.addEventListener(Event.CHANNEL_MESSAGE,this.ProcessorOnBackToMain,false,0,true);
         this.FBmpDataRGBBytes = new ByteArray();
         this.FBmpDataRGBBytes.shareable = true;
         this.FMainWorker.setSharedProperty(CONST_WORKER.SHARED_BmpDataRGB_Bytes,this.FBmpDataRGBBytes);
         this.FBmpDataAlphaBytes = new ByteArray();
         this.FBmpDataAlphaBytes.shareable = true;
         this.FMainWorker.setSharedProperty(CONST_WORKER.SHARED_BmpDataAlpha_Bytes,this.FBmpDataAlphaBytes);
         this.FBmpDataBytes = new Vector.<ByteArray>(100);
         _loc1_ = 0;
         while(_loc1_ < 100)
         {
            _loc2_ = new ByteArray();
            _loc2_.shareable = true;
            this.FMainWorker.setSharedProperty(CONST_WORKER.SHARED_BmpData_Bytes + _loc1_,_loc2_);
            this.FBmpDataBytes[_loc1_] = _loc2_;
            _loc1_++;
         }
         this.FIsInitWorker = true;
      }
      
      public function PerformPakDecoder(param1:Array, param2:int, param3:int, param4:int, param5:Vector.<TCoordinate>, param6:int) : void
      {
         var _loc7_:int = 0;
         var _loc8_:BitmapData = null;
         var _loc9_:BitmapData = null;
         this.FMainToBack.send(CONST_WORKER.MESSAGE_PAKDECODER_START);
         this.FBmpDataRGBBytes.clear();
         _loc8_ = param1[0];
         _loc8_.copyPixelsToByteArray(_loc8_.rect,this.FBmpDataRGBBytes);
         this.FMainToBack.send(_loc8_.transparent);
         this.FMainToBack.send(_loc8_.rect);
         this.FMainToBack.send(param6);
         this.FMainToBack.send(param2);
         this.FMainToBack.send(param3);
         this.FMainToBack.send(param4);
         if(param3 != 0 && param2 != param3)
         {
            this.FBmpDataAlphaBytes.clear();
            _loc9_ = param1[1];
            _loc9_.copyPixelsToByteArray(_loc9_.rect,this.FBmpDataAlphaBytes);
            this.FMainToBack.send(_loc9_.transparent);
            this.FMainToBack.send(_loc9_.rect);
         }
         this.FMainToBack.send(param5.length);
         _loc7_ = 0;
         while(_loc7_ < param5.length)
         {
            this.FMainToBack.send(param5[_loc7_]);
            _loc7_++;
         }
      }
   }
}

