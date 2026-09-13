package Components.Standard
{
   import Foundation.Common.*;
   import Foundation.Display.TZoom9Grid;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.Rectangle;
   
   public class TUIScrollBar extends TUIComponent
   {
      
      protected static const RENDERINGSTATE_Normal:int = 0;
      
      protected static const RENDERINGSTATE_Hovering:int = 1;
      
      protected static const RENDERINGSTATE_Pressed:int = 2;
      
      protected static const RENDERINGSTATE_Disable:int = 3;
      
      public static const RESOURCE_Link_MC_ScrollBarSubstrate:String = "MC_ScrollBarSubstrate";
      
      public static const RESOURCE_Link_MC_ScrollBarThumb:String = "MC_ScrollBarThumb";
      
      public static const RESOURCE_Link_MC_ScrollBarButtonTop:String = "MC_ScrollBarButtonTop";
      
      public static const RESOURCE_Link_MC_ScrollBarButtonBottom:String = "MC_ScrollBarButtonBottom";
      
      protected var FMCScrollBar:Sprite;
      
      protected var FMC_Substrate:Sprite;
      
      protected var FButtonThumb:Sprite;
      
      protected var FButtonTop:Sprite;
      
      protected var FButtonBottom:Sprite;
      
      protected var FZoom9Grid:TZoom9Grid;
      
      protected var FAnimationSubstrate:BitmapData;
      
      protected var FThumbSprite:Sprite;
      
      protected var FThumbBitmap:Bitmap;
      
      protected var FThumbValueDomain:int;
      
      protected var FThumbValueRange:int;
      
      protected var FThumbSize:int;
      
      protected var FThumbSpace:int;
      
      protected var FRollPageSize:int;
      
      protected var FMouseCoordinate:TCoordinate;
      
      protected var FBoundsThumb:TBounds;
      
      protected var FRenderingStateThumb:int;
      
      protected var FThumbPressed:Boolean;
      
      protected var FThumbMouseOffset:int;
      
      protected var FInitialization:Boolean;
      
      protected var FMax:int;
      
      protected var FMin:int;
      
      protected var FValue:int;
      
      protected var FPageSize:int;
      
      protected var FThumbSizeMin:int;
      
      protected var FMouseWheelScale:int;
      
      protected var FOnChange:Function;
      
      public function TUIScrollBar(param1:TUIComponent)
      {
         super(param1);
         this.FMouseCoordinate = new TCoordinate();
         this.FBoundsThumb = new TBounds();
         this.FThumbSprite = new Sprite();
         this.FThumbBitmap = new Bitmap();
         this.FThumbSprite.addChild(this.FThumbBitmap);
         this.FMin = 0;
         this.FMax = 10;
         this.FValue = 0;
         this.FPageSize = 1;
         this.FThumbSizeMin = 1;
         this.FMouseWheelScale = 1;
         this.FRollPageSize = 50;
      }
      
      protected function Initialization() : void
      {
         var _loc1_:TCoordinate = null;
         addChild(this.FMCScrollBar);
         this.FMC_Substrate = this.FMCScrollBar[RESOURCE_Link_MC_ScrollBarSubstrate];
         this.FButtonThumb = this.FMCScrollBar[RESOURCE_Link_MC_ScrollBarThumb];
         this.FButtonTop = this.FMCScrollBar[RESOURCE_Link_MC_ScrollBarButtonTop];
         this.FButtonBottom = this.FMCScrollBar[RESOURCE_Link_MC_ScrollBarButtonBottom];
         this.FButtonThumb.buttonMode = true;
         this.FButtonTop.buttonMode = true;
         this.FButtonBottom.buttonMode = true;
         this.FButtonThumb.visible = false;
         this.FButtonThumb.parent.addChild(this.FThumbSprite);
         this.FThumbSprite.buttonMode = true;
         this.FAnimationSubstrate = new BitmapData(this.FButtonThumb.width,this.FButtonThumb.height,true,16777215);
         this.FAnimationSubstrate.draw(this.FButtonThumb);
         this.FZoom9Grid = new TZoom9Grid(this.FAnimationSubstrate.clone());
         this.FZoom9Grid.GridRect = new Rectangle(2,15,7,5);
         _loc1_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(this);
         FBoundsScreen.X = _loc1_.X;
         FBoundsScreen.Y = _loc1_.Y;
         FBoundsScreen.Width = this.FMCScrollBar.width;
         FBoundsScreen.Height = this.FMCScrollBar.height;
         FUICore.UIStage.addEventListener(MouseEvent.MOUSE_DOWN,this.UIMessagePerform_MouseDown,false,0,true);
         FUICore.UIStage.addEventListener(MouseEvent.MOUSE_UP,this.UIMessagePerform_MouseUp,false,0,true);
         FUICore.UIStage.addEventListener(MouseEvent.MOUSE_MOVE,this.UIMessagePerform_MouseMove,false,0,true);
         this.Parent.addEventListener(MouseEvent.MOUSE_WHEEL,this.UIMessagePerform_MouseWheel,false,0,true);
         this.FButtonTop.addEventListener(MouseEvent.CLICK,this.ButtonTop_MouseClick,false,0,true);
         this.FButtonBottom.addEventListener(MouseEvent.CLICK,this.ButtonBottom_MouseClick,false,0,true);
         this.FInitialization = true;
      }
      
      protected function ThumbValueSet(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FMax - this.FPageSize;
         if(param1 > _loc2_)
         {
            param1 = _loc2_;
         }
         if(param1 < this.FMin)
         {
            param1 = this.FMin;
         }
         if(this.FValue != param1)
         {
            this.FValue = param1;
            this.ThumbNotifyChange();
         }
      }
      
      protected function ThumbUpdate() : void
      {
      }
      
      protected function ThumbUpdateBounds() : void
      {
      }
      
      protected function ThumbNotifyChange() : void
      {
         if(this.FOnChange != null)
         {
            this.FOnChange(this);
         }
      }
      
      protected function RenderingPerform_ScrollBar() : void
      {
         this.ThumbUpdateBounds();
         this.RenderingPerform_Thumb();
      }
      
      protected function RenderingPerform_Thumb() : void
      {
         if(this.FZoom9Grid.Height != this.FBoundsThumb.Height || this.FZoom9Grid.Width != this.FBoundsThumb.Width)
         {
            this.FZoom9Grid.Width = this.FBoundsThumb.Width;
            this.FZoom9Grid.Height = this.FBoundsThumb.Height;
            if(this.FThumbBitmap.bitmapData != this.FZoom9Grid.ImageData)
            {
               if(this.FThumbBitmap.bitmapData != null)
               {
                  this.FThumbBitmap.bitmapData.dispose();
               }
               this.FThumbBitmap.bitmapData = this.FZoom9Grid.ImageData;
            }
         }
         this.FThumbSprite.x = this.FBoundsThumb.X;
         this.FThumbSprite.y = this.FBoundsThumb.Y;
      }
      
      protected function UIMessagePerform_MouseDown(param1:MouseEvent) : void
      {
      }
      
      protected function UIMessagePerform_MouseUp(param1:MouseEvent) : void
      {
         this.FThumbPressed = false;
      }
      
      protected function UIMessagePerform_MouseMove(param1:MouseEvent) : void
      {
      }
      
      protected function UIMessagePerform_MouseWheel(param1:MouseEvent) : void
      {
         this.ThumbValueSet(this.FValue - param1.delta * this.FMouseWheelScale);
      }
      
      protected function ButtonTop_MouseClick(param1:MouseEvent) : void
      {
         this.ThumbValueSet(this.FValue - this.FRollPageSize);
      }
      
      protected function ButtonBottom_MouseClick(param1:MouseEvent) : void
      {
         this.ThumbValueSet(this.FValue - this.FRollPageSize * -1);
      }
      
      public function get MCScrollBar() : Sprite
      {
         return this.FMCScrollBar;
      }
      
      public function set MCScrollBar(param1:Sprite) : void
      {
         this.FMCScrollBar = param1;
      }
      
      public function get Min() : int
      {
         return this.FMin;
      }
      
      public function set Min(param1:int) : void
      {
         if(param1 > this.FMax)
         {
            param1 = this.FMax;
         }
         this.FMin = param1;
         if(this.FValue < param1)
         {
            this.ThumbValueSet(param1);
         }
      }
      
      public function get Max() : int
      {
         return this.FMax;
      }
      
      public function set Max(param1:int) : void
      {
         if(param1 < this.FMin)
         {
            param1 = this.FMin;
         }
         this.FMax = param1;
         if(this.FValue > param1)
         {
            this.ThumbValueSet(param1);
         }
      }
      
      public function get Value() : int
      {
         return this.FValue;
      }
      
      public function set Value(param1:int) : void
      {
         this.ThumbValueSet(param1);
      }
      
      public function get PageSize() : int
      {
         return this.FPageSize;
      }
      
      public function set PageSize(param1:int) : void
      {
         this.FPageSize = param1;
         this.ThumbValueSet(this.FValue);
      }
      
      public function get ThumbSizeMin() : int
      {
         return this.FThumbSizeMin;
      }
      
      public function set ThumbSizeMin(param1:int) : void
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         this.FThumbSizeMin = param1;
      }
      
      public function get MouseWheelScale() : int
      {
         return this.FMouseWheelScale;
      }
      
      public function set MouseWheelScale(param1:int) : void
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         this.FMouseWheelScale = param1;
      }
      
      public function get OnChange() : Function
      {
         return this.FOnChange;
      }
      
      public function set OnChange(param1:Function) : void
      {
         this.FOnChange = param1;
      }
      
      public function Init() : void
      {
         if(this.FInitialization)
         {
            return;
         }
         this.Initialization();
      }
      
      public function RenderingPerform() : void
      {
         this.RenderingPerform_ScrollBar();
      }
   }
}

