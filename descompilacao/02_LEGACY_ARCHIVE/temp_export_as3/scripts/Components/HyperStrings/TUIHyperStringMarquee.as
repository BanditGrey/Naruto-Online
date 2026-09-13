package Components.HyperStrings
{
   import Foundation.Common.TAlignment;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Display.TZoom9Grid;
   import Foundation.Movements.TMovementLinear;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityCartisian;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.HyperStrings.Atoms.THyperStringAtom;
   import Logics.HyperStrings.Elements.THyperStringElementGraphical;
   import Logics.HyperStrings.Elements.THyperStringElementIcon;
   import Logics.HyperStrings.THyperString;
   import Logics.HyperStrings.TSketcherHyperStrings;
   import Rendering.HyperStrings.Data.THyperStringFontSheet;
   import Rendering.HyperStrings.TSketcherHyperString;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class TUIHyperStringMarquee extends TUIComponent
   {
      
      protected var FSketcher:TSketcherHyperString;
      
      protected var FMovement:TMovementLinear;
      
      protected var FZoom9Grid:TZoom9Grid;
      
      protected var FAnimationSubstrate:BitmapData;
      
      protected var FOvarlaySubstrate:Bitmap;
      
      protected var FCoordinateRendering:TCoordinate;
      
      protected var FCoordinateHyperString:TCoordinate;
      
      protected var FMaskSubstrate:Sprite;
      
      protected var FMaskBitmapData:BitmapData;
      
      protected var FMaskBitmap:Bitmap;
      
      protected var FMask:Shape;
      
      protected var FBoundsSubstrate:TBounds;
      
      protected var FHyperStringWidth:int;
      
      protected var FHyperStringHeight:int;
      
      protected var FTickReference:int;
      
      protected var FMousePressedAtom:THyperStringAtom;
      
      protected var FModified:Boolean;
      
      protected var FTextureExpression:TTexture;
      
      public var BTN_Close:MovieClip;
      
      protected var FUIMessageBypassing:Boolean;
      
      protected var FOnClickAtom:Function;
      
      public var OnHideMarquee:Function;
      
      protected var FVelocityX:Number;
      
      protected var FSketcherClipBounds:TBounds;
      
      public function TUIHyperStringMarquee(param1:TUIComponent)
      {
         super(param1);
         FBoundsClient.Width = 800;
         FBoundsClient.Height = 40;
         this.FSketcherClipBounds = new TBounds();
         this.FAnimationSubstrate = new BitmapData(1,1);
         this.FZoom9Grid = new TZoom9Grid(this.FAnimationSubstrate.clone());
         this.FZoom9Grid.GridRect = new Rectangle(22,22,12,12);
         this.FOvarlaySubstrate = new Bitmap();
         this.FOvarlaySubstrate.alpha = 0.6;
         addChild(this.FOvarlaySubstrate);
         this.FMovement = new TMovementLinear();
         this.FCoordinateRendering = new TCoordinate();
         this.FCoordinateHyperString = new TCoordinate();
         this.FBoundsSubstrate = new TBounds();
         this.FMaskSubstrate = new Sprite();
         this.FMaskSubstrate.cacheAsBitmap = true;
         this.addChild(this.FMaskSubstrate);
         this.FMaskBitmapData = new BitmapData(796,40,true,0);
         this.FMaskBitmap = new Bitmap(this.FMaskBitmapData);
         this.FMaskSubstrate.addChild(this.FMaskBitmap);
         this.FSketcher = new TSketcherHyperString(this);
         this.FSketcher.AlignmentLineVertical = TAlignment.VERTICAL_Center;
         this.FSketcher.WrapTrailingSpaces = true;
         this.FMaskSubstrate.addChild(this.FSketcher);
         this.FMask = new Shape();
         this.FMask.graphics.beginFill(0,0);
         this.FMask.graphics.drawRect(5,0,790,40);
         this.FMask.graphics.endFill();
         this.FMaskSubstrate.addChild(this.FMask);
         this.FMaskSubstrate.mask = this.FMask;
         this.FModified = true;
         this.FVelocityX = -100;
         this.FMaskSubstrate.mouseEnabled = false;
         this.mouseEnabled = false;
      }
      
      protected function SketcherHyperStringOnQuerySequence(param1:Object, param2:THyperStringElementGraphical, param3:TQueryAnimationSequence) : void
      {
         var _loc4_:THyperStringElementIcon = null;
         var _loc5_:uint = 0;
         _loc4_ = param2 as THyperStringElementIcon;
         _loc5_ = _loc4_.IDIcon;
         if(_loc4_ != null)
         {
            if(this.FTextureExpression != null)
            {
               param3.Value = this.FTextureExpression.GetAnimationSequenceByIdentifier(_loc5_);
            }
         }
      }
      
      public function get TextureExpression() : TTexture
      {
         return this.FTextureExpression;
      }
      
      public function set TextureExpression(param1:TTexture) : void
      {
         this.FTextureExpression = param1;
      }
      
      protected function ResourcesPerform_UIDispatch() : void
      {
      }
      
      protected function RenderingPerform() : void
      {
         this.RenderingPerform_Substrate();
         this.RenderingPerform_Movement();
         this.RenderingPerform_HyperString();
         if(this.BTN_Close == null)
         {
            this.BTN_Close = TUtilityReflection.CreateDisplayObjectInstance("Btn_ClosePost") as MovieClip;
            if(this.BTN_Close)
            {
               this.BTN_Close.mouseEnabled = true;
               TGameUtil.setButtonMode(this.BTN_Close,true);
               this.BTN_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnHideMarquee);
               this.parent.addChild(this.BTN_Close);
               this.BTN_Close.visible = false;
               this.BTN_Close.x = 770;
            }
         }
      }
      
      protected function RenderingPerform_Substrate() : void
      {
         this.SketchingPerform();
      }
      
      protected function RenderingPerform_Movement() : void
      {
         var _loc1_:int = 0;
         if(this.FTickReference != 0)
         {
            _loc1_ = STimingCore.TickCount - this.FTickReference;
            this.FMovement.Move(_loc1_);
            if(this.FMovement.X < -this.FHyperStringWidth * 2)
            {
               this.FTickReference = 0;
            }
         }
      }
      
      protected function RenderingPerform_HyperString() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.FTickReference == 0)
         {
            return;
         }
         _loc3_ = this.FMovement.X + FBoundsScreen.X;
         _loc4_ = this.FMovement.Y + FBoundsScreen.Y + (FBoundsScreen.Height - this.FHyperStringHeight) / 2;
         _loc1_ = this.FSketcher.LineCount;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            TUtilityCartisian.CoordinateSet(this.FCoordinateRendering,_loc3_,_loc4_);
            this.FSketcher.RenderLine(this.FCoordinateRendering,_loc2_,true);
            _loc3_ += this.FSketcher.GetLineWidthByIndex(_loc2_);
            this.FSketcher.X = _loc3_;
            _loc2_++;
         }
      }
      
      public function RenderingPerform_HyperString_Copy() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.FTickReference == 0)
         {
            return;
         }
         _loc3_ = FBoundsScreen.X;
         _loc4_ = FBoundsScreen.Y + (FBoundsScreen.Height - this.FHyperStringHeight) / 2;
         this.FSketcher.X = (FBoundsClient.Width - this.FSketcher.SketchWidth) / 2;
         this.RenderingPerform_SketcherHyperStrings();
      }
      
      protected function RenderingPerform_SketcherHyperStrings() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:TSketcherHyperString = null;
         var _loc6_:TSketcherHyperStrings = null;
         this.FSketcher.RenderCopy();
      }
      
      protected function SketchingPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = FBoundsClient.Width;
         _loc2_ = FBoundsClient.Height;
         TUtilityCartisian.BoundsSetSize(this.FBoundsSubstrate,_loc1_,_loc2_);
         this.FZoom9Grid.Width = this.FBoundsSubstrate.Width;
         this.FZoom9Grid.Height = this.FBoundsSubstrate.Height;
         if(this.FOvarlaySubstrate.bitmapData != this.FZoom9Grid.ImageData)
         {
            if(this.FOvarlaySubstrate.bitmapData != null)
            {
               this.FOvarlaySubstrate.bitmapData.dispose();
            }
            this.FOvarlaySubstrate.bitmapData = this.FZoom9Grid.ImageData;
         }
      }
      
      public function SketchingPerform_Copy() : void
      {
         this.SketchingPerform();
      }
      
      public function get OnClickAtom() : Function
      {
         return this.FOnClickAtom;
      }
      
      public function set OnClickAtom(param1:Function) : void
      {
         this.FOnClickAtom = param1;
      }
      
      override public function set Width(param1:int) : void
      {
         if(param1 != FBoundsClient.Width)
         {
            FBoundsClient.Width = param1;
            this.FModified = true;
         }
      }
      
      override public function set Height(param1:int) : void
      {
         if(param1 != FBoundsClient.Height)
         {
            FBoundsClient.Height = param1;
            this.FModified = true;
         }
      }
      
      public function get Animating() : Boolean
      {
         return this.FTickReference != 0;
      }
      
      public function get UIMessageBypassing() : Boolean
      {
         return this.FUIMessageBypassing;
      }
      
      public function set UIMessageBypassing(param1:Boolean) : void
      {
         this.FUIMessageBypassing = param1;
      }
      
      public function get FontSheet() : THyperStringFontSheet
      {
         return this.FSketcher.FontSheet;
      }
      
      public function get Sketcher() : TSketcherHyperString
      {
         return this.FSketcher;
      }
      
      public function set FontSheet(param1:THyperStringFontSheet) : void
      {
         this.FSketcher.FontSheet = param1;
      }
      
      public function get AnimationSubstrate() : BitmapData
      {
         return this.FAnimationSubstrate;
      }
      
      public function set AnimationSubstrate(param1:BitmapData) : void
      {
         if(param1 != this.FAnimationSubstrate)
         {
            this.FAnimationSubstrate = param1;
            this.FZoom9Grid.Source = this.FAnimationSubstrate.clone();
            this.FModified = true;
         }
      }
      
      public function get VelocityX() : Number
      {
         return this.FVelocityX;
      }
      
      public function set VelocityX(param1:Number) : void
      {
         this.FVelocityX = param1;
      }
      
      public function ResourcesUpdate() : void
      {
         this.ResourcesPerform_UIDispatch();
      }
      
      public function UpdateRenderingPerform() : void
      {
         this.RenderingPerform();
      }
      
      public function Animate(param1:THyperString) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(param1 == null)
         {
            this.FSketcher.Reset();
            this.FTickReference = 0;
            return;
         }
         this.FSketcher.OnQuerySequence = this.SketcherHyperStringOnQuerySequence;
         this.FSketcher.Sketch(param1,1920);
         _loc6_ = 0;
         _loc7_ = 0;
         _loc2_ = this.FSketcher.LineCount;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FSketcher.GetLineWidthByIndex(_loc3_);
            _loc5_ = this.FSketcher.GetLineHeightByIndex(_loc3_);
            _loc6_ += _loc4_;
            if(_loc5_ > _loc7_)
            {
               _loc7_ = _loc5_;
            }
            _loc3_++;
         }
         this.FHyperStringWidth = _loc6_;
         this.FHyperStringHeight = _loc7_;
         this.FSketcher.Y = (this.Height - this.FSketcher.Height) / 2;
         this.FMovement.SetupRay(FBoundsClient.Width - _loc6_ + 30,0,this.FVelocityX,0,0,0);
         this.FTickReference = STimingCore.TickCount;
      }
      
      protected function ProcessorOnHideMarquee(param1:MouseEvent) : void
      {
         this.FTickReference = 0;
         this.BTN_Close.visible = false;
         if(this.OnHideMarquee != null)
         {
            this.OnHideMarquee();
         }
      }
      
      public function SetBtnCloseVisible(param1:Boolean) : void
      {
         if(this.BTN_Close)
         {
            this.BTN_Close.visible = param1;
         }
      }
   }
}

