package Foundation.Worker
{
   import Foundation.Common.TCoordinate;
   import Resources.Constants.CONST_WORKER;
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class TWorker
   {
      
      protected var FMainToBack:Object;
      
      protected var FBackToMain:Object;
      
      protected var FBitmapDatas:Array;
      
      protected var FBmpDataBytes:Vector.<ByteArray>;
      
      protected var FBmpDataRGBBytes:ByteArray;
      
      protected var FBmpDataAlphaBytes:ByteArray;
      
      protected var FIsInitWorker:Boolean;
      
      protected var FOnBackToMain:Function;
      
      public function TWorker()
      {
         super();
         this.FIsInitWorker = false;
      }
      
      protected function PerformPakDecoder(param1:BitmapData, param2:BitmapData, param3:int, param4:int, param5:int, param6:int, param7:Vector.<TCoordinate>, param8:Rectangle) : void
      {
         var _loc9_:* = 0;
         var _loc10_:int = 0;
         var _loc11_:TCoordinate = null;
         var _loc12_:Point = null;
         var _loc13_:BitmapData = null;
         var _loc14_:Rectangle = null;
         var _loc15_:ByteArray = null;
         _loc12_ = new Point();
         _loc10_ = 0;
         _loc9_ = 0;
         while(_loc9_ < param3)
         {
            _loc11_ = param7[_loc9_];
            if(_loc11_.X == 0 || _loc11_.Y == 0)
            {
               _loc11_.X = 1;
               _loc11_.Y = 1;
            }
            _loc13_ = new BitmapData(_loc11_.X,_loc11_.Y);
            _loc14_ = new Rectangle(_loc10_,0,_loc11_.X,_loc11_.Y);
            _loc13_.copyPixels(param1,_loc14_,_loc12_);
            if(param5 != 0 && param4 != param5)
            {
               _loc13_.copyChannel(param2,_loc14_,_loc12_,BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
            }
            else
            {
               _loc13_.copyChannel(param1,new Rectangle(_loc10_,param1.height / 2,_loc11_.X,_loc11_.Y),_loc12_,BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
            }
            this.DoAlphaFilter(param6,_loc13_);
            this.FBitmapDatas.push(_loc13_);
            _loc10_ += _loc11_.X;
            _loc9_++;
         }
         param1.dispose();
         param1 = null;
         if(param2 != null)
         {
            param2.dispose();
            param2 = null;
         }
         this.FBackToMain.send(CONST_WORKER.MESSAGE_PAKDECODER_COMPLETED);
         this.FBackToMain.send(param3);
         _loc9_ = 0;
         while(this.FBitmapDatas.length != 0)
         {
            _loc13_ = this.FBitmapDatas.shift();
            _loc15_ = this.FBmpDataBytes[_loc9_++];
            _loc15_.clear();
            _loc13_.copyPixelsToByteArray(_loc13_.rect,_loc15_);
            this.FBackToMain.send(_loc13_.transparent);
            this.FBackToMain.send(_loc13_.rect);
            _loc13_.dispose();
            _loc13_ = null;
         }
      }
      
      protected function DoAlphaFilter(param1:int, param2:BitmapData) : void
      {
         var _loc3_:Point = null;
         _loc3_ = new Point();
         if(param1)
         {
            param2.threshold(param2,param2.rect,_loc3_,"<",param1 << 24,0,4278190080,true);
         }
      }
      
      protected function ProcessorOnMainToBack(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Rectangle = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:BitmapData = null;
         var _loc11_:BitmapData = null;
         var _loc12_:TCoordinate = null;
         var _loc13_:Boolean = false;
         var _loc14_:Vector.<TCoordinate> = null;
         var _loc15_:Object = null;
         if(this.FMainToBack.messageAvailable)
         {
            _loc2_ = this.FMainToBack.receive();
            switch(_loc2_)
            {
               case CONST_WORKER.MESSAGE_PAKDECODER_START:
                  _loc13_ = Boolean(this.FMainToBack.receive(true));
                  _loc15_ = this.FMainToBack.receive(true);
                  _loc5_ = new Rectangle();
                  _loc5_.x = _loc15_.x;
                  _loc5_.y = _loc15_.y;
                  _loc5_.width = _loc15_.width;
                  _loc5_.height = _loc15_.height;
                  _loc10_ = new BitmapData(_loc5_.width,_loc5_.height,_loc13_);
                  this.FBmpDataRGBBytes.position = 0;
                  _loc10_.setPixels(_loc5_,this.FBmpDataRGBBytes);
                  _loc6_ = int(this.FMainToBack.receive(true));
                  _loc7_ = int(this.FMainToBack.receive(true));
                  _loc8_ = int(this.FMainToBack.receive(true));
                  _loc9_ = int(this.FMainToBack.receive(true));
                  if(_loc8_ != 0 && _loc7_ != _loc8_)
                  {
                     _loc13_ = Boolean(this.FMainToBack.receive(true));
                     _loc15_ = this.FMainToBack.receive(true);
                     _loc5_ = new Rectangle();
                     _loc5_.x = _loc15_.x;
                     _loc5_.y = _loc15_.y;
                     _loc5_.width = _loc15_.width;
                     _loc5_.height = _loc15_.height;
                     _loc11_ = new BitmapData(_loc5_.width,_loc5_.height,_loc13_);
                     this.FBmpDataAlphaBytes.position = 0;
                     _loc11_.setPixels(_loc5_,this.FBmpDataAlphaBytes);
                  }
                  _loc4_ = int(this.FMainToBack.receive(true));
                  _loc14_ = new Vector.<TCoordinate>(_loc4_);
                  _loc3_ = 0;
                  while(_loc3_ < _loc4_)
                  {
                     _loc15_ = this.FMainToBack.receive(true);
                     _loc12_ = new TCoordinate();
                     _loc12_.X = _loc15_.X;
                     _loc12_.Y = _loc15_.Y;
                     _loc14_[_loc3_] = _loc12_;
                     _loc3_++;
                  }
                  this.PerformPakDecoder(_loc10_,_loc11_,_loc6_,_loc7_,_loc8_,_loc9_,_loc14_,_loc5_);
            }
         }
      }
      
      public function get OnBackToMain() : Function
      {
         return this.FOnBackToMain;
      }
      
      public function set OnBackToMain(param1:Function) : void
      {
         this.FOnBackToMain = param1;
      }
      
      public function InitWorker() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Object = null;
         if(this.FIsInitWorker)
         {
            return;
         }
         _loc2_ = WorkerCompat.Worker.current;
         this.FMainToBack = _loc2_.getSharedProperty(CONST_WORKER.SHARED_MainToBack);
         this.FMainToBack.addEventListener(Event.CHANNEL_MESSAGE,this.ProcessorOnMainToBack,false,0,true);
         this.FBackToMain = _loc2_.getSharedProperty(CONST_WORKER.SHARED_BackToMain);
         this.FBmpDataRGBBytes = _loc2_.getSharedProperty(CONST_WORKER.SHARED_BmpDataRGB_Bytes);
         this.FBmpDataRGBBytes.position = 0;
         this.FBmpDataAlphaBytes = _loc2_.getSharedProperty(CONST_WORKER.SHARED_BmpDataAlpha_Bytes);
         this.FBmpDataAlphaBytes.position = 0;
         this.FBmpDataBytes = new Vector.<ByteArray>(100);
         _loc1_ = 0;
         while(_loc1_ < 100)
         {
            this.FBmpDataBytes[_loc1_] = _loc2_.getSharedProperty(CONST_WORKER.SHARED_BmpData_Bytes + _loc1_);
            this.FBmpDataBytes[_loc1_].position = 0;
            _loc1_++;
         }
         this.FBitmapDatas = new Array();
         this.FIsInitWorker = true;
      }
   }
}

