package Rendering.Overlayers.PurpleNinja
{
   import Foundation.Common.TAlignment;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
   import Foundation.Resources.Strings.TStrings;
   import Foundation.UI.TUIComponent;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import flash.text.TextFormat;
   
   public class TOverlayerPurpleNinja extends TOverlayer
   {
      
      protected static const COLOR_ContextValue:uint = 16711935;
      
      protected static const SIZE_WordWrapWidthDefault:uint = 180;
      
      protected static const SIZE_Padding_01:uint = 15;
      
      protected var FPainterPetGoldTrain:TPainterTextEffect;
      
      protected var FBoundsPetGoldTrain:TBounds;
      
      protected var FBoundsOffset:TBounds;
      
      protected var FTextFormatCaption:TextFormat;
      
      protected var FContextCaption:String;
      
      protected var FBeginIndex:uint;
      
      protected var FEndIndex:uint;
      
      protected var FStrings:TStrings;
      
      public function TOverlayerPurpleNinja(param1:TUIComponent)
      {
         super(param1);
         FWordWrapWidth = SIZE_WordWrapWidthDefault;
         this.FPainterPetGoldTrain = ConstructPainterTextEffect();
         this.FBoundsPetGoldTrain = new TBounds();
         this.FTextFormatCaption = new TextFormat();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is THint;
      }
      
      override protected function ContextModified() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:THint = null;
         _loc2_ = FContext as THint;
         return this.FContextCaption != _loc2_.Caption;
      }
      
      override protected function ContextSynchronize() : void
      {
         var _loc1_:THint = null;
         _loc1_ = FContext as THint;
         this.FContextCaption = _loc1_.Caption;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:THint = null;
         _loc1_ = FContext as THint;
         this.EvaluationPerform_Caption(_loc1_);
      }
      
      protected function EvaluationPerform_Caption(param1:THint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         BoundsAlignDown(this.FBoundsPetGoldTrain);
         this.FPainterPetGoldTrain.Text = param1.Caption;
         this.FPainterPetGoldTrain.Evaluate(this.FBoundsPetGoldTrain);
         this.FTextFormatCaption.color = COLOR_ContextValue;
         this.FEndIndex = param1.Caption.length;
         this.FPainterPetGoldTrain.SetTextFormat(this.FTextFormatCaption,this.FBeginIndex,this.FEndIndex);
         BoundsContextUnion(this.FBoundsPetGoldTrain);
      }
      
      override protected function SketchingPerform_Context() : void
      {
         this.SketchingPerform_Caption();
      }
      
      protected function SketchingPerform_Caption() : void
      {
         this.FPainterPetGoldTrain.RenderBounds(this.FBoundsPetGoldTrain,TAlignment.HORIZONTAL_Left);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPainterPetGoldTrain.x = FBoundsRendering.X;
         this.FPainterPetGoldTrain.y = FBoundsRendering.Y;
      }
      
      public function setIndex(param1:uint, param2:uint) : void
      {
         this.FBeginIndex = param1;
         this.FEndIndex = param2;
      }
      
      public function set BeginIndex(param1:uint) : void
      {
         this.FBeginIndex = param1;
      }
      
      public function get BeginIndex() : uint
      {
         return this.FBeginIndex;
      }
   }
}

