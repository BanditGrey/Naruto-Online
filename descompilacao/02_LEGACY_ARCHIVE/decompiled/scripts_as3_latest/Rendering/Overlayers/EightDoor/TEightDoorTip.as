package Rendering.Overlayers.EightDoor
{
   import Foundation.Common.TAlignment;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
   import Foundation.Fonts.SFontCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityCartisian;
   import Logics.BloodFete.TBloodFeteSingle;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterHtmlTextEffectCopy;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_OVERLAYER;
   
   public class TEightDoorTip extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_YELLOW:uint = 4294958161;
      
      protected var TPTimes:TPainterTextEffect;
      
      protected var FBTimes:TBounds;
      
      protected var FContextCaption:String;
      
      protected var FCur:TBloodFeteSingle;
      
      public function TEightDoorTip(param1:TUIComponent)
      {
         super(param1);
         this.TPTimes = ConstructPainterTextEffect(COLOR_Context_YELLOW);
         this.FBTimes = new TBounds();
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
         return this.FContextCaption != _loc2_.Content;
      }
      
      override protected function ContextSynchronize() : void
      {
         var _loc1_:THint = null;
         _loc1_ = FContext as THint;
         this.FContextCaption = _loc1_.Content;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:THint = null;
         _loc1_ = FContext as THint;
         this.FCur = FContext as TBloodFeteSingle;
         this.EvaluationPerform_Caption(_loc1_);
      }
      
      protected function EvaluationPerform_Caption(param1:THint) : void
      {
         this.TPTimes.Text = param1.Content;
         this.TPTimes.Evaluate(this.FBTimes);
         BoundsContextUnion(this.FBTimes);
      }
      
      override public function set Context(param1:Object) : void
      {
         if(param1 != null)
         {
            if(!this.ContextVerificate(param1))
            {
               param1 = null;
            }
         }
         FContext = param1;
         FModified = true;
      }
      
      override public function Show() : void
      {
         if(!this.visible)
         {
            this.visible = true;
         }
      }
      
      override public function Hide() : void
      {
         if(this.visible)
         {
            this.visible = false;
         }
      }
      
      override protected function EvaluationPerform_Substrate() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = FBoundsContext.Width + FMarginLeft + FMarginRight;
         _loc2_ = FBoundsContext.Height + FMarginTop + FMarginBottom;
         if(_loc1_ < SIZE_MinWidth)
         {
            _loc1_ = int(SIZE_MinWidth);
         }
         TUtilityCartisian.BoundsSetSize(FBoundsSubstrate,_loc1_,_loc2_);
      }
      
      override protected function SketchingPerform_Context() : void
      {
         this.SketchingPerform_Caption();
      }
      
      protected function SketchingPerform_Caption() : void
      {
         this.TPTimes.RenderBounds(this.FBTimes,TAlignment.HORIZONTAL_Center,TAlignment.VERTICAL_Center);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.TPTimes.X = FBoundsRendering.X;
         this.TPTimes.Y = FBoundsRendering.Y;
      }
      
      protected function ConstructPainterHtmlTextEffectCopy(param1:uint = 4294958161) : TPainterHtmlTextEffectCopy
      {
         var _loc2_:TPainterHtmlTextEffectCopy = null;
         _loc2_ = new TPainterHtmlTextEffectCopy(this);
         SFontCore.FontSelect(_loc2_.Font,CONST_OVERLAYER.TEXT_ANTIALIAS_FontSetName,CONST_OVERLAYER.TEXT_ANTIALIAS_FontSetSize,CONST_OVERLAYER.TEXT_ANTIALIAS_FontSetBold);
         _loc2_.Font.Leading = 5;
         _loc2_.FontEffect.AntiAliased = true;
         _loc2_.FontEffect.Outlined = true;
         _loc2_.FontEffect.OutlineSize = SIZE_OutlineSize;
         _loc2_.FontEffect.Shadowed = true;
         _loc2_.FontEffect.ShadowDistance = 3;
         _loc2_.WordWrap = false;
         _loc2_.WordWrapWidth = FWordWrapWidth;
         _loc2_.Multilineable = true;
         return _loc2_;
      }
   }
}

