package Processors.Game.Lobby.BigDipper.TigerMachine
{
   import Foundation.UI.*;
   import Processors.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.filters.*;
   
   public class TTigerMachine extends TProcessor
   {
      
      protected static const BLUR_WIDTH:int = 2;
      
      protected static const BLUR_HEIGHT:int = 16;
      
      protected static const LIGHT_FRAMENUM:int = 30;
      
      protected static const YOFFSET:int = 5;
      
      protected static const FIRST_FRAME_ID:int = CONST_BIGDIPPER.MoveFrameMoveTurn[0];
      
      protected static const FRAME_NUM:int = CONST_BIGDIPPER.STAR_NUM;
      
      protected static const FRAME_HEIGTH:int = CONST_BIGDIPPER.TigerMachineMotherBoardWidth;
      
      protected static const FRAM_TURN:Vector.<int> = CONST_BIGDIPPER.MoveFrameMoveTurn;
      
      protected static const MIN_ACTIONCYCLE:int = 3;
      
      public static const SPEEDMAX:Number = Math.PI / 20;
      
      public static const SPEEDMIN:Number = Math.PI / 20;
      
      protected var FBitMapData:BitmapData;
      
      protected var FBitMap:Bitmap;
      
      protected var FDisplay:Sprite;
      
      protected var FMachineUI:MovieClip;
      
      protected var FSpeedMove:Number;
      
      protected var FCurrentAngle:Number;
      
      protected var FAngleSpeed:Number;
      
      protected var FCoordinateY:Number;
      
      protected var FStoreCoordinateY:Number;
      
      protected var FStoreFrameIndex:int;
      
      protected var FTargetCoordinateY:Number;
      
      protected var FFilterArray:Array;
      
      protected var FRunning:Boolean;
      
      protected var FDelayTime:uint;
      
      protected var FDelayStore:uint;
      
      protected var FIFFlash:Boolean;
      
      public function TTigerMachine(param1:TUIComponent, param2:MovieClip)
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         super(param1);
         this.FMachineUI = param2;
         this.ConstructBitmap(CONST_BIGDIPPER.TigerMachineMotherBoardWidth,CONST_BIGDIPPER.TigerMachineMotherBoardHeight);
         _loc3_ = (CONST_BIGDIPPER.TigerMachineMotherBoardWidth - this.FMachineUI.width) / 2;
         _loc4_ = CONST_BIGDIPPER.TigerMachineStarYOffset / 2;
         this.ConstructDisplay(_loc3_,_loc4_,this.FMachineUI);
         this.StopFrameByID(FIRST_FRAME_ID,1);
         this.Reset();
      }
      
      protected function ConstructBitmap(param1:int, param2:int) : void
      {
         var _loc3_:BlurFilter = null;
         var _loc4_:Number = NaN;
         this.FBitMapData = new BitmapData(param1,param2,true,0);
         this.FBitMap = new Bitmap(this.FBitMapData);
         addChild(this.FBitMap);
         this.FFilterArray = new Array();
         _loc3_ = new BlurFilter(BLUR_WIDTH,_loc4_);
         this.FFilterArray.length = 0;
         this.FFilterArray.push(_loc3_);
      }
      
      protected function ConstructDisplay(param1:Number, param2:Number, param3:MovieClip) : void
      {
         this.FDisplay = new Sprite();
         this.FDisplay.addChild(param3);
         param3.x = param1;
         param3.y = param2;
         addChild(this.FDisplay);
      }
      
      protected function ClearBitmap() : void
      {
         this.FBitMapData.fillRect(this.FBitMapData.rect,0);
      }
      
      public function TargetY(param1:int) : Number
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = MIN_ACTIONCYCLE * FRAME_NUM * FRAME_HEIGTH;
         _loc2_ = 0;
         while(_loc2_ < FRAM_TURN.length)
         {
            if(param1 == FRAM_TURN[_loc2_])
            {
               break;
            }
            _loc2_++;
         }
         if(_loc2_ >= this.FStoreFrameIndex)
         {
            _loc3_ = (_loc2_ - this.FStoreFrameIndex) * FRAME_HEIGTH + _loc4_;
         }
         else
         {
            _loc3_ = (FRAME_NUM + _loc2_ - this.FStoreFrameIndex) * FRAME_HEIGTH + _loc4_;
         }
         this.FStoreFrameIndex = _loc2_;
         return _loc3_;
      }
      
      protected function Reset() : void
      {
         this.FCoordinateY = 0;
         this.FStoreCoordinateY = 0;
         this.FStoreFrameIndex = 0;
      }
      
      protected function StopFrameByID(param1:int, param2:int) : void
      {
         var _loc3_:MovieClip = null;
         this.FMachineUI.gotoAndStop(param1);
         _loc3_ = this.FMachineUI[CONST_BIGDIPPER.RESOURCE_Link_MC_TigerMachineStar];
         _loc3_.gotoAndStop(param2);
      }
      
      protected function PlayFrameByID(param1:int, param2:int) : void
      {
         var _loc3_:MovieClip = null;
         this.FMachineUI.gotoAndStop(param1);
         _loc3_ = this.FMachineUI[CONST_BIGDIPPER.RESOURCE_Link_MC_TigerMachineStar];
         _loc3_.gotoAndPlay(param2);
      }
      
      override protected function LogicsPerform() : void
      {
         if(this.FRunning)
         {
            if(this.FDelayTime > 0)
            {
               --this.FDelayTime;
               return;
            }
            this.FCurrentAngle += this.FAngleSpeed;
            if(this.FCurrentAngle > Math.PI)
            {
               this.DoAfterActionOver();
               return;
            }
            this.BlurStar(this.FCurrentAngle);
            this.FCoordinateY = this.FSpeedMove * (Math.cos(this.FCurrentAngle) - 1) + this.FStoreCoordinateY;
            this.DrawStarByCoordinate(this.FCoordinateY);
         }
      }
      
      protected function DrawStarByCoordinate(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:* = 0;
         _loc2_ = -param1 % (FRAME_NUM * FRAME_HEIGTH);
         _loc3_ = int(_loc2_ / FRAME_HEIGTH);
         this.ClearBitmap();
         this.DrawStarByIndex(_loc3_,-_loc2_);
         if(++_loc3_ > FRAME_NUM - 1)
         {
            this.DrawStarByIndex(0,-_loc2_ + FRAME_NUM * FRAME_HEIGTH);
         }
         else
         {
            this.DrawStarByIndex(_loc3_,-_loc2_);
         }
         _loc3_--;
         this.FMachineUI.gotoAndStop(FRAM_TURN[_loc3_]);
      }
      
      protected function DrawStarByIndex(param1:int, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         _loc3_ = param2 + param1 * FRAME_HEIGTH;
         this.FMachineUI.y = _loc3_ + CONST_BIGDIPPER.TigerMachineStarYOffset / 2;
         this.DrawStarByIndentifier(FRAM_TURN[param1]);
      }
      
      protected function DrawStarByIndentifier(param1:int) : void
      {
         this.StopFrameByID(param1,1);
         this.FBitMapData.draw(this.FDisplay);
      }
      
      protected function BlurStar(param1:Number) : void
      {
         var _loc2_:BlurFilter = null;
         var _loc3_:Number = NaN;
         _loc3_ = Math.sin(param1) * BLUR_HEIGHT;
         _loc2_ = this.FFilterArray[0];
         _loc2_.blurY = _loc3_;
         this.FDisplay.filters = this.FFilterArray;
      }
      
      protected function DoBeforeAction() : void
      {
         this.FDisplay.visible = false;
         this.FBitMap.visible = true;
         this.ClearBitmap();
         this.DrawStarByIndentifier(this.FMachineUI.currentFrame);
         this.FCurrentAngle = 0;
      }
      
      protected function DoAfterActionOver() : void
      {
         this.FDisplay.visible = true;
         this.FBitMap.visible = false;
         this.FRunning = false;
         this.FMachineUI.y = CONST_BIGDIPPER.TigerMachineStarYOffset / 2;
         if(!this.FIFFlash)
         {
            this.StopFrameByID(this.FMachineUI.currentFrame,1);
         }
         else
         {
            this.PlayFrameByID(this.FMachineUI.currentFrame,this.FDelayStore % LIGHT_FRAMENUM + 1);
         }
         this.FDisplay.filters = null;
         this.FStoreCoordinateY -= this.FTargetCoordinateY;
      }
      
      public function get Running() : Boolean
      {
         return this.FRunning;
      }
      
      public function Setup(param1:int, param2:uint, param3:Number, param4:Boolean, param5:Boolean = true) : void
      {
         if(this.FRunning)
         {
            return;
         }
         this.FTargetCoordinateY = this.TargetY(param1);
         this.FSpeedMove = (this.FTargetCoordinateY + YOFFSET) / 2;
         this.FAngleSpeed = param3;
         this.FDelayTime = param2;
         this.FDelayStore = param2;
         this.FIFFlash = param4;
         if(param5)
         {
            this.StopFrameByID(FIRST_FRAME_ID,1);
            this.Reset();
         }
         else
         {
            this.StopFrameByID(this.FMachineUI.currentFrame,1);
         }
      }
      
      public function Move() : void
      {
         this.DoBeforeAction();
         this.FRunning = true;
      }
      
      public function Stop() : void
      {
         this.DoAfterActionOver();
         this.FDelayStore = 0;
         this.FStoreFrameIndex = 0;
         this.StopFrameByID(FIRST_FRAME_ID,1);
         this.FStoreCoordinateY = 0;
      }
      
      public function StopFlash() : void
      {
         this.StopFrameByID(this.FMachineUI.currentFrame,1);
      }
   }
}

