package Components.Shortcuts
{
   import Foundation.Common.*;
   import Foundation.Resources.Textures.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Processors.Game.Lobby.Shortcuts.Window.*;
   import Resources.Constants.CONST_SHORTCUTS;
   import flash.display.*;
   import flash.events.*;
   
   public class TUIShortcut extends TUIComponent
   {
      
      protected static const COORDINATE_Btn_X:int = 0;
      
      protected static const COORDINATE_Btn_Y:int = 1;
      
      protected static const Type_NineUp:uint = 0;
      
      protected static const Type_NineDown:uint = 1;
      
      protected static const Type_NineLeft:uint = 2;
      
      protected static const Type_NineRight:uint = 3;
      
      protected static const Type_NineLeftUp:uint = 4;
      
      protected static const Type_NineLeftDown:uint = 5;
      
      protected static const Type_NineRightUp:uint = 6;
      
      protected static const Type_NineRightDown:uint = 7;
      
      protected static const Type_NineMiddle:uint = 8;
      
      protected static const Middle_Width:uint = 65;
      
      protected static const Middle_Height:uint = 78;
      
      protected var FSubstrate:Sprite;
      
      protected var FBmp_Left:Bitmap;
      
      protected var FBmpData_Middle:BitmapData;
      
      protected var FBmps_Middle:Vector.<Bitmap>;
      
      protected var FBmp_Right:Bitmap;
      
      protected var FNineGridBitmaps:Vector.<Bitmap>;
      
      protected var FEffects:TAnimationSequence;
      
      protected var FSpecialEffects:TAnimationSequence;
      
      protected var FLayerEffects:Vector.<Bitmap>;
      
      protected var FButtons:Vector.<SimpleButton>;
      
      protected var FDiscord:SimpleButton;
      
      protected var FHints:Vector.<THint>;
      
      protected var FCoordinateBtn:Vector.<int>;
      
      protected var FBounds:TBounds;
      
      protected var FCapacity:uint;
      
      protected var FIsEffects:Vector.<Boolean>;
      
      protected var FIsSpecialEffects:Vector.<Boolean>;
      
      protected var FIsInitialization:Boolean;
      
      protected var FIsInitSecodary:Boolean;
      
      protected var FIsWrap:Boolean;
      
      protected var FOnFunctions:Vector.<Function>;
      
      protected var FOnBtnMove:Function;
      
      protected var FOnBtnOver:Function;
      
      protected var FOnBtnOut:Function;
      
      protected var FOnBtnDown:Function;
      
      protected var FOnBtnUp:Function;
      
      public function TUIShortcut(param1:TUIComponent)
      {
         super(param1);
         this.FSubstrate = new Sprite();
         this.addChild(this.FSubstrate);
         this.FBmps_Middle = new Vector.<Bitmap>();
         this.FButtons = new Vector.<SimpleButton>();
         this.FHints = new Vector.<THint>();
         this.FNineGridBitmaps = new Vector.<Bitmap>();
         this.FLayerEffects = new Vector.<Bitmap>();
         this.FBounds = new TBounds();
         this.FOnFunctions = new Vector.<Function>();
         this.FIsEffects = new Vector.<Boolean>();
         this.FIsSpecialEffects = new Vector.<Boolean>();
         this.FIsInitialization = false;
         this.FIsInitSecodary = false;
      }
      
      protected function Resources_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Bitmap = null;
         var _loc4_:Bitmap = null;
         var _loc5_:SimpleButton = null;
         var _loc6_:TAnimationFrame = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(this.FEffects != null)
         {
            _loc6_ = this.FEffects.GetAnimationFrameByIndex(0);
            _loc8_ = _loc6_.Surface.width;
            _loc9_ = _loc6_.Surface.height;
         }
         if(this.FSpecialEffects != null)
         {
            _loc6_ = this.FSpecialEffects.GetAnimationFrameByIndex(0);
            _loc8_ = _loc6_.Surface.width;
            _loc9_ = _loc6_.Surface.height;
         }
         this.FSubstrate.addChild(this.FBmp_Left);
         _loc7_ = this.FBmp_Left.width;
         _loc2_ = int(this.FCapacity);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = new Bitmap(this.FBmpData_Middle);
            _loc4_.x = _loc7_;
            this.FSubstrate.addChild(_loc4_);
            this.FBmps_Middle[_loc1_] = _loc4_;
            _loc7_ = _loc4_.x + _loc4_.width;
            _loc3_ = new Bitmap();
            _loc3_.x = _loc4_.x - (_loc8_ - _loc4_.width) / 2 - this.FCoordinateBtn[COORDINATE_Btn_X];
            _loc3_.y = _loc4_.y - (_loc9_ - _loc4_.height) / 2 - this.FCoordinateBtn[COORDINATE_Btn_Y];
            this.FLayerEffects[_loc1_] = _loc3_;
            this.FSubstrate.addChild(_loc3_);
            _loc5_ = this.FButtons[_loc1_];
            _loc5_.x = _loc4_.x + (_loc4_.width - _loc5_.width) / 2 + this.FCoordinateBtn[COORDINATE_Btn_X];
            _loc5_.y = _loc4_.y + (_loc4_.height - _loc5_.height) / 2 + this.FCoordinateBtn[COORDINATE_Btn_Y];
            _loc5_.tabIndex = _loc1_;
            this.FSubstrate.addChild(_loc5_);
            this.FIsEffects[_loc1_] = false;
            this.FIsSpecialEffects[_loc1_] = false;
            _loc5_.addEventListener(MouseEvent.CLICK,this.BtnOnClick,false,0,true);
            _loc5_.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnOnMove,false,0,true);
            _loc5_.addEventListener(MouseEvent.MOUSE_OVER,this.BtnOnOver,false,0,true);
            _loc5_.addEventListener(MouseEvent.MOUSE_OUT,this.BtnOnOUT,false,0,true);
            _loc5_.addEventListener(MouseEvent.MOUSE_DOWN,this.BtnOnDown,false,0,true);
            _loc5_.addEventListener(MouseEvent.MOUSE_UP,this.BtnOnUp,false,0,true);
            _loc1_++;
         }
         this.FSubstrate.addChild(this.FBmp_Right);
         this.FBmp_Right.x = _loc7_;
      }
      
      protected function UpdateLocation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Bitmap = null;
         var _loc4_:SimpleButton = null;
         var _loc5_:Bitmap = null;
         var _loc6_:TAnimationFrame = null;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         if(this.FEffects != null)
         {
            _loc6_ = this.FEffects.GetAnimationFrameByIndex(0);
            _loc8_ = _loc6_.Surface.width;
            _loc9_ = _loc6_.Surface.height;
         }
         _loc7_ = false;
         _loc10_ = this.FBmp_Left.width;
         this.FBounds.Width = this.FBmp_Left.width;
         _loc2_ = int(this.FCapacity);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FBmps_Middle[_loc1_];
            _loc4_ = this.FButtons[_loc1_];
            _loc5_ = this.FLayerEffects[_loc1_];
            if(_loc3_.visible)
            {
               _loc3_.x = _loc10_;
               _loc4_.x = _loc3_.x + this.FCoordinateBtn[COORDINATE_Btn_X];
               _loc4_.y = _loc3_.y + this.FCoordinateBtn[COORDINATE_Btn_Y];
               _loc5_.x = _loc3_.x - (_loc8_ - _loc3_.width) / 2 - this.FCoordinateBtn[COORDINATE_Btn_X];
               _loc5_.y = _loc3_.y - (_loc9_ - _loc3_.height) / 2 - this.FCoordinateBtn[COORDINATE_Btn_Y];
               _loc10_ += _loc3_.width;
               _loc7_ = true;
            }
            else
            {
               _loc3_.x = 0;
               _loc4_.x = 0;
               _loc5_.x = 0;
               _loc5_.y = 0;
               _loc5_.visible = false;
            }
            _loc1_++;
         }
         this.FBmp_Right.x = _loc10_;
         this.FBmp_Left.visible = _loc7_;
         this.FBmp_Right.visible = _loc7_;
         if(_loc7_)
         {
            this.FBounds.Width = _loc10_;
         }
         else
         {
            this.FBounds.Width = 0;
         }
      }
      
      protected function LogicsPerform_UpdataEffects() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:Bitmap = null;
         var _loc5_:TAnimationFrame = null;
         var _loc6_:Boolean = false;
         _loc2_ = int(this.FCapacity);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc1_ < this.FIsSpecialEffects.length && this.FIsSpecialEffects[_loc1_])
            {
               _loc6_ = this.FIsSpecialEffects[_loc1_];
               if(_loc6_)
               {
                  _loc4_ = this.FLayerEffects[_loc1_];
                  _loc5_ = this.FSpecialEffects.GetAnimationFrameByTick(STimingCore.TickCount);
                  if(_loc4_.bitmapData == null)
                  {
                     _loc4_.bitmapData = _loc5_.Surface;
                  }
                  else if(_loc4_.bitmapData != _loc5_.Surface)
                  {
                     _loc4_.bitmapData = _loc5_.Surface;
                  }
               }
            }
            else
            {
               _loc3_ = this.FIsEffects[_loc1_];
               if(_loc3_)
               {
                  _loc4_ = this.FLayerEffects[_loc1_];
                  _loc5_ = this.FEffects.GetAnimationFrameByTick(STimingCore.TickCount);
                  if(_loc4_.bitmapData == null)
                  {
                     _loc4_.bitmapData = _loc5_.Surface;
                  }
                  else if(_loc4_.bitmapData != _loc5_.Surface)
                  {
                     _loc4_.bitmapData = _loc5_.Surface;
                  }
               }
            }
            _loc1_++;
         }
      }
      
      protected function Resources_UILocations_SecondaryList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Bitmap = null;
         var _loc4_:Bitmap = null;
         var _loc5_:SimpleButton = null;
         var _loc6_:TAnimationFrame = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         if(this.FEffects != null)
         {
            _loc6_ = this.FEffects.GetAnimationFrameByIndex(0);
            _loc8_ = _loc6_.Surface.width;
            _loc9_ = _loc6_.Surface.height;
         }
         _loc2_ = int(this.FNineGridBitmaps.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FSubstrate.addChild(this.FNineGridBitmaps[_loc1_]);
            _loc1_++;
         }
         _loc10_ = this.FNineGridBitmaps[Type_NineLeftUp].height;
         _loc7_ = this.FNineGridBitmaps[Type_NineLeftUp].width;
         _loc2_ = int(this.FCapacity);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new Bitmap();
            this.FSubstrate.addChild(_loc3_);
            _loc3_.x = _loc7_ - (_loc8_ - Middle_Width) / 2 - this.FCoordinateBtn[COORDINATE_Btn_X];
            _loc3_.y = _loc10_ - (_loc9_ - Middle_Height) / 2 - this.FCoordinateBtn[COORDINATE_Btn_Y];
            this.FLayerEffects[_loc1_] = _loc3_;
            _loc5_ = this.FButtons[_loc1_];
            _loc5_.x = _loc7_ + (Middle_Width - _loc5_.width) / 2 + this.FCoordinateBtn[COORDINATE_Btn_X];
            _loc5_.y = _loc10_ + (Middle_Height - _loc5_.height) / 2 + this.FCoordinateBtn[COORDINATE_Btn_Y];
            _loc5_.tabIndex = _loc1_;
            this.FSubstrate.addChild(_loc5_);
            this.FIsEffects[_loc1_] = false;
            _loc5_.addEventListener(MouseEvent.CLICK,this.BtnOnClick,false,0,true);
            _loc5_.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnOnMove,false,0,true);
            _loc5_.addEventListener(MouseEvent.MOUSE_OVER,this.BtnOnOver,false,0,true);
            _loc5_.addEventListener(MouseEvent.MOUSE_OUT,this.BtnOnOUT,false,0,true);
            _loc5_.addEventListener(MouseEvent.MOUSE_DOWN,this.BtnOnDown,false,0,true);
            _loc5_.addEventListener(MouseEvent.MOUSE_UP,this.BtnOnUp,false,0,true);
            _loc1_++;
         }
      }
      
      protected function ReplaceShortcuts(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Bitmap = null;
         var _loc5_:Bitmap = null;
         var _loc6_:SimpleButton = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:TAnimationFrame = null;
         var _loc12_:int = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         if(this.FEffects != null)
         {
            _loc11_ = this.FEffects.GetAnimationFrameByIndex(0);
            _loc9_ = _loc11_.Surface.width;
            _loc10_ = _loc11_.Surface.height;
         }
         _loc8_ = this.FNineGridBitmaps[Type_NineLeftUp].height;
         _loc7_ = this.FNineGridBitmaps[Type_NineLeftUp].width;
         _loc3_ = int(this.FCapacity);
         _loc12_ = 0;
         _loc19_ = param1 is TWindowActivitySecondary ? CONST_SHORTCUTS.TARGET_Index : CONST_SHORTCUTS.TARGET_Index_New;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = this.FButtons[_loc2_];
            if(_loc6_.visible)
            {
               _loc17_ = _loc7_ + Middle_Width * uint(_loc12_ % _loc19_);
               _loc18_ = _loc8_ + Middle_Height * uint(_loc12_ / _loc19_);
               _loc4_ = this.FLayerEffects[_loc2_];
               _loc4_.x = _loc17_ - (_loc9_ - Middle_Width) / 2 - this.FCoordinateBtn[COORDINATE_Btn_X];
               _loc4_.y = _loc18_ - (_loc10_ - Middle_Height) / 2 - this.FCoordinateBtn[COORDINATE_Btn_Y];
               _loc6_ = this.FButtons[_loc2_];
               _loc6_.x = _loc17_ + (Middle_Width - _loc6_.width) / 2 + this.FCoordinateBtn[COORDINATE_Btn_X];
               _loc6_.y = _loc18_ + (Middle_Height - _loc6_.height) / 2 + this.FCoordinateBtn[COORDINATE_Btn_Y];
               _loc12_++;
            }
            _loc2_++;
         }
         _loc7_ += Middle_Width * Math.min(_loc12_,_loc19_);
         _loc8_ += Middle_Height * Math.ceil(_loc12_ / _loc19_);
         _loc5_ = this.FNineGridBitmaps[Type_NineLeftUp];
         _loc13_ = _loc8_ - _loc5_.height;
         _loc5_ = this.FNineGridBitmaps[Type_NineLeft];
         _loc5_.height = _loc13_;
         _loc5_.y = this.FNineGridBitmaps[Type_NineLeftUp].height;
         _loc5_ = this.FNineGridBitmaps[Type_NineLeftDown];
         _loc5_.y = _loc8_;
         _loc5_ = this.FNineGridBitmaps[Type_NineLeftUp];
         _loc14_ = _loc7_ - _loc5_.width;
         _loc5_ = this.FNineGridBitmaps[Type_NineUp];
         _loc5_.x = this.FNineGridBitmaps[Type_NineLeftUp].width;
         _loc5_.width = _loc14_;
         _loc5_ = this.FNineGridBitmaps[Type_NineRightUp];
         _loc5_.x = _loc7_;
         _loc5_ = this.FNineGridBitmaps[Type_NineRight];
         _loc5_.x = _loc7_;
         _loc5_.y = this.FNineGridBitmaps[Type_NineRightUp].height;
         _loc5_.height = _loc13_;
         _loc5_ = this.FNineGridBitmaps[Type_NineDown];
         _loc5_.x = this.FNineGridBitmaps[Type_NineLeftDown].width;
         _loc5_.y = _loc8_;
         _loc5_.width = _loc14_;
         _loc5_ = this.FNineGridBitmaps[Type_NineRightDown];
         _loc5_.x = _loc7_;
         _loc5_.y = _loc8_;
         _loc5_ = this.FNineGridBitmaps[Type_NineMiddle];
         _loc5_.x = this.FNineGridBitmaps[Type_NineLeftUp].width;
         _loc5_.y = this.FNineGridBitmaps[Type_NineLeftUp].height;
         _loc5_.width = _loc14_;
         _loc5_.height = _loc13_;
         this.FBounds.Width = this.FSubstrate.width;
      }
      
      protected function BtnOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:SimpleButton = null;
         var _loc5_:Function = null;
         _loc4_ = param1.currentTarget as SimpleButton;
         _loc3_ = int(this.FCapacity);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(_loc4_ == this.FButtons[_loc2_])
            {
               _loc5_ = this.FOnFunctions[_loc2_];
               if(_loc5_ != null)
               {
                  _loc5_(param1,_loc2_);
               }
            }
            _loc2_++;
         }
      }
      
      protected function BtnOnMove(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:SimpleButton = null;
         _loc4_ = param1.currentTarget as SimpleButton;
         _loc3_ = int(this.FCapacity);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(_loc4_ == this.FButtons[_loc2_])
            {
               if(this.FOnBtnMove != null)
               {
                  this.FOnBtnMove(this,_loc2_);
               }
            }
            _loc2_++;
         }
      }
      
      protected function BtnOnOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SimpleButton = null;
         _loc3_ = param1.currentTarget as SimpleButton;
         _loc2_ = this.FButtons.indexOf(_loc3_);
         if(this.FOnBtnOver != null)
         {
            this.FOnBtnOver(_loc3_,_loc2_);
         }
      }
      
      protected function BtnOnOUT(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SimpleButton = null;
         _loc3_ = param1.currentTarget as SimpleButton;
         _loc2_ = this.FButtons.indexOf(_loc3_);
         if(this.FOnBtnOut != null)
         {
            this.FOnBtnOut(_loc3_,_loc2_);
         }
      }
      
      protected function BtnOnDown(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SimpleButton = null;
         _loc3_ = param1.currentTarget as SimpleButton;
         _loc2_ = this.FButtons.indexOf(_loc3_);
         if(this.FOnBtnDown != null)
         {
            this.FOnBtnDown(_loc3_,_loc2_);
         }
      }
      
      protected function BtnOnUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SimpleButton = null;
         _loc3_ = param1.currentTarget as SimpleButton;
         _loc2_ = this.FButtons.indexOf(_loc3_);
         if(this.FOnBtnUp != null)
         {
            this.FOnBtnUp(_loc3_,_loc2_);
         }
      }
      
      public function get Substrate() : Sprite
      {
         return this.FSubstrate;
      }
      
      public function get Capacity() : uint
      {
         return this.FCapacity;
      }
      
      public function set Capacity(param1:uint) : void
      {
         this.FCapacity = param1;
         this.FOnFunctions.length = param1;
      }
      
      public function get Bmp_Left() : Bitmap
      {
         return this.FBmp_Left;
      }
      
      public function set Bmp_Left(param1:Bitmap) : void
      {
         this.FBmp_Left = param1;
      }
      
      public function get BmpData_Middle() : BitmapData
      {
         return this.FBmpData_Middle;
      }
      
      public function set BmpData_Middle(param1:BitmapData) : void
      {
         this.FBmpData_Middle = param1;
      }
      
      public function get Bmp_Right() : Bitmap
      {
         return this.FBmp_Right;
      }
      
      public function set Bmp_Right(param1:Bitmap) : void
      {
         this.FBmp_Right = param1;
      }
      
      public function get IsInitialization() : Boolean
      {
         return this.FIsInitialization;
      }
      
      public function set IsInitialization(param1:Boolean) : void
      {
         this.FIsInitialization = param1;
      }
      
      public function get Bounds() : TBounds
      {
         return this.FBounds;
      }
      
      public function get CoordinateBtn() : Vector.<int>
      {
         return this.FCoordinateBtn;
      }
      
      public function set CoordinateBtn(param1:Vector.<int>) : void
      {
         this.FCoordinateBtn = param1;
      }
      
      public function get OnBtnMove() : Function
      {
         return this.FOnBtnMove;
      }
      
      public function set OnBtnMove(param1:Function) : void
      {
         this.FOnBtnMove = param1;
      }
      
      public function get OnBtnOver() : Function
      {
         return this.FOnBtnOver;
      }
      
      public function set OnBtnOver(param1:Function) : void
      {
         this.FOnBtnOver = param1;
      }
      
      public function get OnBtnOut() : Function
      {
         return this.FOnBtnOut;
      }
      
      public function set OnBtnOut(param1:Function) : void
      {
         this.FOnBtnOut = param1;
      }
      
      public function get OnBtnDown() : Function
      {
         return this.FOnBtnDown;
      }
      
      public function set OnBtnDown(param1:Function) : void
      {
         this.FOnBtnDown = param1;
      }
      
      public function get OnBtnUp() : Function
      {
         return this.FOnBtnUp;
      }
      
      public function set OnBtnUp(param1:Function) : void
      {
         this.FOnBtnUp = param1;
      }
      
      public function get IsWrap() : Boolean
      {
         return this.FIsWrap;
      }
      
      public function set IsWrap(param1:Boolean) : void
      {
         this.FIsWrap = param1;
      }
      
      public function get Effects() : TAnimationSequence
      {
         return this.FEffects;
      }
      
      public function set Effects(param1:TAnimationSequence) : void
      {
         this.FEffects = param1;
      }
      
      public function get SpecialEffects() : TAnimationSequence
      {
         return this.FSpecialEffects;
      }
      
      public function set SpecialEffects(param1:TAnimationSequence) : void
      {
         this.FSpecialEffects = param1;
      }
      
      public function get NineGridBitmaps() : Vector.<Bitmap>
      {
         return this.FNineGridBitmaps;
      }
      
      public function set NineGridBitmaps(param1:Vector.<Bitmap>) : void
      {
         this.FNineGridBitmaps = param1;
      }
      
      public function get IsInitSecodary() : Boolean
      {
         return this.FIsInitSecodary;
      }
      
      public function GetBmp_Middle(param1:int) : Bitmap
      {
         return this.FBmps_Middle[param1];
      }
      
      public function GetFunctionByIndex(param1:int) : Function
      {
         return this.FOnFunctions[param1];
      }
      
      public function SetFunctionByIndex(param1:Function, param2:int) : void
      {
         this.FOnFunctions[param2] = param1;
      }
      
      public function GetIsEffectByIndex(param1:int) : Boolean
      {
         return this.FIsEffects[param1];
      }
      
      public function get IsEffectLength() : int
      {
         return this.FIsEffects.length;
      }
      
      public function GetIsSpecialEffectByIndex(param1:int) : Boolean
      {
         return this.FIsSpecialEffects[param1];
      }
      
      public function SetIsEffectByIndex(param1:Boolean, param2:int) : void
      {
         if(param2 >= this.FIsEffects.length)
         {
            return;
         }
         if(this.FIsEffects[param2] != param1)
         {
            this.FIsEffects[param2] = param1;
            this.FLayerEffects[param2].visible = param1;
         }
      }
      
      public function SetIsSpecialEffectByIndex(param1:Boolean, param2:int) : void
      {
         if(this.FIsSpecialEffects[param2] != param1)
         {
            this.FIsSpecialEffects[param2] = param1;
            this.FLayerEffects[param2].visible = param1;
         }
      }
      
      public function GetButtonByIndex(param1:int) : SimpleButton
      {
         if(param1 >= this.FButtons.length)
         {
            return null;
         }
         return this.FButtons[param1];
      }
      
      public function SetButtonByIndex(param1:SimpleButton, param2:int) : void
      {
         this.FButtons[param2] = param1;
      }
      
      public function GetHintByIndex(param1:int) : THint
      {
         return this.FHints[param1];
      }
      
      public function SetHintByIndex(param1:THint, param2:int) : void
      {
         this.FHints[param2] = param1;
      }
      
      public function GetLayerEffectByIndex(param1:int) : Bitmap
      {
         return this.FLayerEffects[param1];
      }
      
      public function SetLayerEffectByIndex(param1:Bitmap, param2:int) : void
      {
         this.FLayerEffects[param2] = param1;
      }
      
      public function Perform_UIDispatch() : void
      {
         if(!this.FIsInitialization)
         {
            this.Resources_UILocations();
            this.FIsInitialization = true;
         }
      }
      
      public function UpdateComponentsLocation() : void
      {
         this.UpdateLocation();
      }
      
      public function UpdataEffect() : void
      {
         this.LogicsPerform_UpdataEffects();
      }
      
      public function Perform_UIDispatch_SecondaryList() : void
      {
         if(!this.FIsInitSecodary)
         {
            this.Resources_UILocations_SecondaryList();
            this.FIsInitSecodary = true;
         }
      }
      
      public function ReplaceShortcutsLocation(param1:Object) : void
      {
         if(this.FIsInitSecodary)
         {
            this.ReplaceShortcuts(param1);
         }
      }
      
      public function CheckShortcutsEffect() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FIsEffects.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FIsEffects[_loc1_])
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
   }
}

