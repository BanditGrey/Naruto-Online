package Rendering.Overlayers.NijiaMystic
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TNijiaMystic;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Strings.STRING_OVERLAYERNIJIAMYSTIC;
   import flash.display.Bitmap;
   
   public class TOverlayerNijiaMystic extends TOverlayer
   {
      
      protected static const SIZE_DividingLineOffset:uint = 3;
      
      protected static const SIZE_Padding_01:uint = 3;
      
      protected static const SIZE_Padding_02:uint = 5;
      
      protected static const SIZE_Padding_03:uint = 15;
      
      protected static const SIZE_Context_00:uint = 15;
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_01:uint = 4291545959;
      
      protected static const COLOR_Context_02:uint = 4294967040;
      
      protected static const COLOR_Context_03:uint = 4294890346;
      
      protected static const COLOR_Context_04:uint = 4291545959;
      
      protected static const COLOR_Context_Invalid:uint = 4286611584;
      
      protected static const COLOR_Context_Unknown:uint = 4278255615;
      
      protected static const COLOR_Context_AppendAttributes:uint = 4284940032;
      
      protected static const COLOR_Context_Blue:uint = 4278228735;
      
      protected static const FORMAT_CurMysticLevel:String = STRING_OVERLAYERNIJIAMYSTIC.FORMAT_CurMysticLevel;
      
      protected static const FORMAT_NextMysticLevel:String = STRING_OVERLAYERNIJIAMYSTIC.FORMAT_NextMysticLevel;
      
      protected var FPainterMysticName:TPainterTextEffect;
      
      protected var FBoundsMysticName:TBounds;
      
      protected var FPainterCurMysticLevel:TPainterTextEffect;
      
      protected var FBoundsCurMysticLevel:TBounds;
      
      protected var FPainterNextMysticLevel:TPainterTextEffect;
      
      protected var FBoundsNextMysticLevel:TBounds;
      
      protected var FDividingLinePartName:Bitmap;
      
      protected var FBoundsPartName:TBounds;
      
      protected var FBoundsOffset:TBounds;
      
      public function TOverlayerNijiaMystic(param1:TUIComponent)
      {
         super(param1);
         this.FPainterMysticName = ConstructPainterTextEffect(COLOR_Context_01);
         this.FPainterMysticName.Font.Bold = true;
         this.FBoundsMysticName = new TBounds();
         this.FPainterCurMysticLevel = ConstructPainterTextEffect(COLOR_Context_02);
         this.FPainterCurMysticLevel.Font.Bold = true;
         this.FBoundsCurMysticLevel = new TBounds();
         this.FPainterNextMysticLevel = ConstructPainterTextEffect(COLOR_Context_03);
         this.FPainterNextMysticLevel.Font.Bold = true;
         this.FBoundsNextMysticLevel = new TBounds();
         this.FDividingLinePartName = new Bitmap();
         addChild(this.FDividingLinePartName);
         this.FBoundsPartName = new TBounds();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FDividingLinePartName.bitmapData = FDividingLine;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:TNijiaMystic = null;
         _loc1_ = FContext as TNijiaMystic;
         this.EvaluationPerform_Name(_loc1_.Name);
         this.FBoundsOffset = this.FBoundsMysticName;
         this.EvaluationPerform_PartName();
         this.FBoundsOffset = this.FBoundsPartName;
         this.EvaluationPerform_CurLevel(_loc1_.Desc);
         this.FBoundsOffset = this.FBoundsCurMysticLevel;
         if(_loc1_.NextNijiaMystic != null)
         {
            this.FPainterNextMysticLevel.Visible = true;
            this.EvaluationPerform_NextLevel(_loc1_.NextNijiaMystic.Desc);
            this.FBoundsOffset = this.FBoundsNextMysticLevel;
         }
         else
         {
            this.FPainterNextMysticLevel.Visible = false;
         }
      }
      
      protected function EvaluationPerform_Name(param1:String) : void
      {
         BoundsAlignDown(this.FBoundsMysticName);
         this.FPainterMysticName.Text = param1;
         this.FPainterMysticName.Evaluate(this.FBoundsMysticName);
         BoundsContextUnion(this.FBoundsMysticName);
      }
      
      protected function EvaluationPerform_PartName() : void
      {
         this.FBoundsPartName.Width = this.FDividingLinePartName.width;
         this.FBoundsPartName.Height = this.FDividingLinePartName.height;
         BoundsAlignDown(this.FBoundsPartName,this.FBoundsOffset,SIZE_Padding_02);
         this.FBoundsPartName.X = 0;
         BoundsContextUnion(this.FBoundsPartName);
      }
      
      protected function EvaluationPerform_CurLevel(param1:String) : void
      {
         BoundsAlignDown(this.FBoundsCurMysticLevel);
         this.FPainterCurMysticLevel.Text = TUtilityString.Format(FORMAT_CurMysticLevel,param1);
         this.FPainterCurMysticLevel.Evaluate(this.FBoundsCurMysticLevel);
         BoundsContextUnion(this.FBoundsCurMysticLevel);
      }
      
      protected function EvaluationPerform_NextLevel(param1:String) : void
      {
         BoundsAlignDown(this.FBoundsNextMysticLevel);
         this.FPainterNextMysticLevel.Text = TUtilityString.Format(FORMAT_NextMysticLevel,param1);
         this.FPainterNextMysticLevel.Evaluate(this.FBoundsNextMysticLevel);
         BoundsContextUnion(this.FBoundsNextMysticLevel);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         var _loc2_:TNijiaMystic = null;
         _loc2_ = FContext as TNijiaMystic;
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPainterMysticName.X = FBoundsRendering.X + this.FBoundsMysticName.X;
         this.FPainterMysticName.Y = FBoundsRendering.Y + this.FBoundsMysticName.Y;
         this.FDividingLinePartName.x = FBoundsRendering.X + this.FBoundsPartName.X - FMarginLeft + SIZE_DividingLineOffset;
         this.FDividingLinePartName.y = FBoundsRendering.Y + this.FBoundsPartName.Y - 5;
         this.FPainterCurMysticLevel.X = FBoundsRendering.X + this.FBoundsCurMysticLevel.X;
         this.FPainterCurMysticLevel.Y = FBoundsRendering.Y + this.FBoundsCurMysticLevel.Y;
         if(_loc2_.NextNijiaMystic != null)
         {
            this.FPainterNextMysticLevel.X = FBoundsRendering.X + this.FBoundsNextMysticLevel.X;
            this.FPainterNextMysticLevel.Y = FBoundsRendering.Y + this.FBoundsNextMysticLevel.Y;
         }
      }
      
      override public function Show() : void
      {
         if(FContext == null)
         {
            return;
         }
         super.Show();
      }
   }
}

