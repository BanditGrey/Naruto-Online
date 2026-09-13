package Components.Standard
{
   import Foundation.UI.*;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUITab extends TUIComponent
   {
      
      public static const RENDERINGSTATE_Select:int = 1;
      
      public static const RENDERINGSTATE_UnSelect:int = 2;
      
      public static const RENDERINGSTATE_Hovering:int = 3;
      
      public static const RENDERINGSTATE_Disabled:int = 4;
      
      public static const RESOURCE_Link_TF_Caption:String = "TF_Caption";
      
      public static const FilterGlowWidth:int = 4;
      
      public static const FilterGlowStrength:int = 20;
      
      protected var FTabs:Vector.<MovieClip>;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FCaption:String;
      
      protected var FTabIndexPressed:int;
      
      protected var FIsEnabled:Boolean;
      
      protected var FInitialization:Boolean;
      
      protected var FTabX:Vector.<Number>;
      
      protected var FTabY:Vector.<Number>;
      
      protected var FMoveArr:Array;
      
      protected var FTabIndex:int;
      
      protected var FOnSwitch:Function;
      
      protected var FOnOver:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnMove:Function;
      
      protected var FFilterColor:uint;
      
      public function TUITab(param1:TUIComponent)
      {
         super(param1);
         this.FTabs = new Vector.<MovieClip>();
         this.FGlowsFilter = new Vector.<TEffectBaseGlowTwo>();
         this.FTabX = new Vector.<Number>();
         this.FTabY = new Vector.<Number>();
         this.FCaption = "";
         this.FTabIndex = 0;
         this.FTabIndexPressed = -1;
         this.FInitialization = false;
      }
      
      protected function Initialization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:BitmapData = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TEffectBaseGlowTwo = null;
         _loc2_ = int(this.FTabs.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FTabs[_loc1_];
            _loc4_.addEventListener(MouseEvent.CLICK,this.TabOnClick,false,0,true);
            _loc4_.addEventListener(MouseEvent.MOUSE_OVER,this.TabOnOver,false,0,true);
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.TabOnOut,false,0,true);
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.TabOnMove,false,0,true);
            if(_loc1_ == 0)
            {
               this.FTabIndex = 0;
               _loc4_.gotoAndStop(RENDERINGSTATE_Select);
            }
            else
            {
               _loc4_.gotoAndStop(RENDERINGSTATE_UnSelect);
            }
            _loc5_ = new TEffectBaseGlowTwo();
            _loc5_.SetParameters(_loc4_,this.FFilterColor,FilterGlowWidth,FilterGlowStrength);
            this.FGlowsFilter.push(_loc5_);
            _loc1_++;
         }
         this.FInitialization = true;
      }
      
      protected function UpdateBinding(param1:int) : void
      {
      }
      
      protected function SwitchTab(param1:int) : void
      {
         var _loc2_:MovieClip = null;
         if(param1 == this.FTabIndex)
         {
            return;
         }
         _loc2_ = this.FTabs[this.FTabIndex];
         _loc2_.buttonMode = true;
         _loc2_.gotoAndStop(RENDERINGSTATE_UnSelect);
         _loc2_ = this.FTabs[param1];
         _loc2_.buttonMode = false;
         _loc2_.gotoAndStop(RENDERINGSTATE_Select);
         this.FTabIndex = param1;
         if(this.FOnSwitch != null)
         {
            this.FOnSwitch(this.FTabIndex);
         }
      }
      
      protected function TabOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc3_ = param1.currentTarget as MovieClip;
         _loc2_ = this.FTabs.indexOf(_loc3_);
         if(_loc3_.currentFrame == RENDERINGSTATE_Disabled)
         {
            return;
         }
         this.SwitchTab(_loc2_);
      }
      
      protected function TabOnOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc3_ = param1.currentTarget as MovieClip;
         if(_loc3_.currentFrame != RENDERINGSTATE_UnSelect)
         {
            if(_loc3_.buttonMode != false)
            {
               _loc3_.buttonMode = false;
            }
         }
         else
         {
            if(_loc3_.buttonMode != true)
            {
               _loc3_.buttonMode = true;
            }
            _loc3_.gotoAndStop(RENDERINGSTATE_Hovering);
         }
         _loc2_ = this.FTabs.indexOf(_loc3_);
         if(this.FOnOver != null)
         {
            this.FOnOver(this,_loc2_,this.FIsEnabled);
         }
      }
      
      protected function TabOnMove(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc3_ = param1.currentTarget as MovieClip;
         _loc2_ = this.FTabs.indexOf(_loc3_);
         if(this.FOnMove != null)
         {
            this.FOnMove(this,_loc2_,this.FIsEnabled);
         }
      }
      
      protected function TabOnOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc3_ = param1.currentTarget as MovieClip;
         if(_loc3_ != this.FTabs[this.FTabIndex])
         {
            if(_loc3_.currentFrame == RENDERINGSTATE_Disabled)
            {
               _loc3_.gotoAndStop(RENDERINGSTATE_Disabled);
            }
            else
            {
               _loc3_.gotoAndStop(RENDERINGSTATE_UnSelect);
            }
         }
         else
         {
            _loc3_.gotoAndStop(RENDERINGSTATE_Select);
         }
         _loc2_ = this.FTabs.indexOf(_loc3_);
         if(this.FOnOut != null)
         {
            this.FOnOut(this,_loc2_,this.FIsEnabled);
         }
      }
      
      public function get Count() : int
      {
         return this.FTabs.length;
      }
      
      public function SetTabCaptionByIndex(param1:String, param2:int, param3:uint = 0) : void
      {
         var _loc4_:TextField = this.FTabs[param2][RESOURCE_Link_TF_Caption] as TextField;
         this.FCaption = param1;
         if(_loc4_ != null && Boolean(param1))
         {
            _loc4_.text = param1;
            if(param3 != 0)
            {
               _loc4_.textColor = param3;
            }
            _loc4_.mouseEnabled = false;
         }
      }
      
      public function SetTabCanClickByIndex(param1:int) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = this.FTabs[param1];
         _loc2_.gotoAndStop(RENDERINGSTATE_UnSelect);
      }
      
      public function SetTabEnabledByIndex(param1:int, param2:Boolean) : void
      {
         var _loc3_:MovieClip = null;
         _loc3_ = this.FTabs[param1];
         _loc3_.gotoAndStop(RENDERINGSTATE_Disabled);
         if(!param2)
         {
            if(!_loc3_.hasEventListener(MouseEvent.CLICK))
            {
               _loc3_.addEventListener(MouseEvent.CLICK,this.TabOnClick);
            }
            if(!_loc3_.hasEventListener(MouseEvent.MOUSE_OVER))
            {
               _loc3_.addEventListener(MouseEvent.MOUSE_OVER,this.TabOnOver);
            }
            if(!_loc3_.hasEventListener(MouseEvent.MOUSE_OUT))
            {
               _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.TabOnOut);
            }
            if(!_loc3_.hasEventListener(MouseEvent.MOUSE_MOVE))
            {
               _loc3_.addEventListener(MouseEvent.MOUSE_MOVE,this.TabOnMove);
            }
         }
         else
         {
            _loc3_.removeEventListener(MouseEvent.CLICK,this.TabOnClick);
            _loc3_.removeEventListener(MouseEvent.MOUSE_OVER,this.TabOnOver);
            _loc3_.removeEventListener(MouseEvent.MOUSE_OUT,this.TabOnOut);
            _loc3_.removeEventListener(MouseEvent.MOUSE_MOVE,this.TabOnMove);
         }
         this.FIsEnabled = param2;
      }
      
      public function SetTabOpenByIndex(param1:int, param2:Boolean) : void
      {
         var _loc3_:MovieClip = null;
         _loc3_ = this.FTabs[param1];
         _loc3_.gotoAndStop(RENDERINGSTATE_UnSelect);
         this.FIsEnabled = param2;
      }
      
      public function GetTabByIndex(param1:int) : MovieClip
      {
         return this.FTabs[param1];
      }
      
      public function SetTabByIndex(param1:MovieClip, param2:int) : void
      {
         this.FTabs[param2] = param1;
         this.FTabX[param2] = param1.x;
         this.FTabY[param2] = param1.y;
      }
      
      public function NiMeijiaQiang(param1:Array) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:uint = 0;
         this.FMoveArr = param1;
         _loc3_ = int(_loc2_ = int(uint(this.FTabX.length - 1)));
         while(_loc3_ >= 0)
         {
            this.FTabs[_loc3_].visible = true;
            if(!this.GetBooByIndex(_loc3_))
            {
               this.FTabs[_loc3_].x = this.FTabX[_loc2_];
               this.FTabs[_loc3_].y = this.FTabY[_loc2_];
               _loc2_--;
            }
            _loc3_--;
         }
         if(!this.FMoveArr)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < this.FMoveArr.length)
         {
            this.FTabs[this.FMoveArr[_loc3_]].visible = false;
            _loc3_++;
         }
      }
      
      protected function GetBooByIndex(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         if(!this.FMoveArr)
         {
            return false;
         }
         _loc2_ = 0;
         while(_loc2_ < this.FMoveArr.length)
         {
            if(param1 == this.FMoveArr[_loc2_])
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function SetTabHideByIndexCopy(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this.FTabX.length)
         {
            this.FTabs[_loc3_].visible = true;
            if(!(_loc3_ == param1 && param1 < this.FTabX.length))
            {
               this.FTabs[_loc3_].x = this.FTabX[_loc2_];
               this.FTabs[_loc3_].y = this.FTabY[_loc2_];
               _loc2_++;
            }
            _loc3_++;
         }
         if(param1 < this.FTabX.length)
         {
            this.FTabs[param1].visible = false;
         }
      }
      
      public function SetTabShowByIndex(param1:int) : void
      {
         this.FTabs[param1].visible = true;
      }
      
      public function SetTabHideByIndex(param1:int) : void
      {
         this.FTabs[param1].visible = false;
      }
      
      public function GetMoviClipByIndex(param1:int) : MovieClip
      {
         return this.FTabs[param1];
      }
      
      public function get TabIndex() : int
      {
         return this.FTabIndex;
      }
      
      public function set TabIndex(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         if(this.FTabIndex != param1)
         {
            this.FTabIndex = param1;
            _loc3_ = int(this.FTabs.length);
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = this.FTabs[_loc2_];
               _loc4_.gotoAndStop(RENDERINGSTATE_UnSelect);
               _loc2_++;
            }
            _loc4_ = this.FTabs[param1];
            _loc4_.gotoAndStop(RENDERINGSTATE_Select);
         }
      }
      
      public function get OnSwitch() : Function
      {
         return this.FOnSwitch;
      }
      
      public function set OnSwitch(param1:Function) : void
      {
         this.FOnSwitch = param1;
      }
      
      public function get OnOver() : Function
      {
         return this.FOnOver;
      }
      
      public function set OnOver(param1:Function) : void
      {
         this.FOnOver = param1;
      }
      
      public function get OnMove() : Function
      {
         return this.FOnMove;
      }
      
      public function set OnMove(param1:Function) : void
      {
         this.FOnMove = param1;
      }
      
      public function get OnOut() : Function
      {
         return this.FOnOut;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function get FilterColor() : uint
      {
         return this.FFilterColor;
      }
      
      public function set FilterColor(param1:uint) : void
      {
         this.FFilterColor = param1;
      }
      
      public function get Caption() : String
      {
         return this.FCaption;
      }
      
      public function Init() : void
      {
         if(this.FInitialization)
         {
            return;
         }
         this.Initialization();
      }
      
      public function Clear() : void
      {
         this.FTabs.length = 0;
      }
      
      public function Reset() : void
      {
         this.SwitchTab(0);
      }
      
      public function SwithTagManual(param1:int) : void
      {
         this.SwitchTab(param1);
      }
      
      public function StartTabShowGlowByIndex(param1:int) : void
      {
         this.FGlowsFilter[param1].IsRunOver = false;
      }
      
      public function StopTabShowGlowByIndex(param1:int) : void
      {
         this.FGlowsFilter[param1].Stop();
      }
      
      public function StopGlow() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TEffectBaseGlowTwo = null;
         _loc1_ = 0;
         while(_loc1_ < this.FGlowsFilter.length)
         {
            this.StopTabShowGlowByIndex(_loc1_);
            _loc1_++;
         }
      }
      
      public function Update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TEffectBaseGlowTwo = null;
         _loc1_ = 0;
         while(_loc1_ < this.FGlowsFilter.length)
         {
            _loc2_ = this.FGlowsFilter[_loc1_];
            if(!_loc2_.IsRunOver)
            {
               _loc2_.Run();
            }
            _loc1_++;
         }
      }
   }
}

