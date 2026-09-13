package Rendering.Overlayers.BigDipper
{
   import Foundation.Common.TAlignment;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.Strings.TStrings;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Processors.Game.Lobby.BigDipper.TBigDipperTipData;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Strings.STRING_OVERLAYERDIGDIPPER;
   import Resources.Strings.STRING_PALACE;
   import flash.text.TextFormat;
   
   public class TOverlayerBigDipper extends TOverlayer
   {
      
      protected static const COLOR_ContextDefault:uint = 4294967295;
      
      protected static const COLOR_ContextValue:uint = 4294967040;
      
      protected static const COLOR_Context_AppendAttributes:uint = 4284940032;
      
      protected static const SIZE_Padding_01:uint = 15;
      
      public static const FORMAT_StarCaption:String = STRING_OVERLAYERDIGDIPPER.FORMAT_StarCaption;
      
      public static const FORMAT_CurrentLevelCeiling:String = STRING_OVERLAYERDIGDIPPER.FORMAT_CurrentLevelCeiling;
      
      public static const FORMAT_CurrentUpgradeAttribute:String = STRING_OVERLAYERDIGDIPPER.FORMAT_CurrentUpgradeAttribute;
      
      public static const FORMAT_NextUpgradeAttribute:String = STRING_OVERLAYERDIGDIPPER.FORMAT_NextUpgradeAttribute;
      
      protected var FPainterStarCaption:TPainterTextEffect;
      
      protected var FPainterLeveCeiling:TPainterTextEffect;
      
      protected var FPainterCurrentUpgradeAttribute:TPainterTextEffect;
      
      protected var FPainterNextUpgradeAttribute:TPainterTextEffect;
      
      protected var FBoundsStarCaption:TBounds;
      
      protected var FBoundsLeveCeiling:TBounds;
      
      protected var FBoundsCurrentUpgradeAttribute:TBounds;
      
      protected var FBoundsNextUpgradeAttribute:TBounds;
      
      protected var FBoundsOffset:TBounds;
      
      protected var FTextFormatCaption:TextFormat;
      
      protected var FContextResourceID:uint;
      
      protected var FStrings:TStrings;
      
      public function TOverlayerBigDipper(param1:TUIComponent)
      {
         super(param1);
         this.FPainterStarCaption = ConstructPainterTextEffect(COLOR_ContextValue);
         this.FBoundsStarCaption = new TBounds();
         this.FPainterLeveCeiling = ConstructPainterTextEffect(COLOR_ContextValue);
         this.FBoundsLeveCeiling = new TBounds();
         this.FPainterCurrentUpgradeAttribute = ConstructPainterTextEffect(COLOR_ContextValue);
         this.FBoundsCurrentUpgradeAttribute = new TBounds();
         this.FPainterNextUpgradeAttribute = ConstructPainterTextEffect(COLOR_ContextValue);
         this.FBoundsNextUpgradeAttribute = new TBounds();
         this.FTextFormatCaption = new TextFormat();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is TBigDipperTipData;
      }
      
      override protected function ContextModified() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:TBigDipperTipData = null;
         _loc2_ = FContext as TBigDipperTipData;
         return this.FContextResourceID != _loc2_.ResourceID;
      }
      
      override protected function ContextSynchronize() : void
      {
         var _loc1_:TBigDipperTipData = null;
         _loc1_ = FContext as TBigDipperTipData;
         this.FContextResourceID = _loc1_.ResourceID;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:TBigDipperTipData = null;
         _loc1_ = FContext as TBigDipperTipData;
         this.EvaluationPerform_Caption(_loc1_);
         this.FBoundsOffset = this.FBoundsStarCaption;
         this.EvaluationPerform_LevelCeiling(_loc1_);
         this.FBoundsOffset = this.FBoundsLeveCeiling;
         this.EvaluationPerform_CurrentUpgradeAttribute(_loc1_);
         this.FBoundsOffset = this.FBoundsCurrentUpgradeAttribute;
         this.EvaluationPerform_NextUpgradeAttribute(_loc1_);
      }
      
      protected function EvaluationPerform_Caption(param1:TBigDipperTipData) : void
      {
         var _loc2_:int = 0;
         BoundsAlignDown(this.FBoundsStarCaption);
         _loc2_ = FORMAT_StarCaption.length - " %1/%2".length;
         this.FPainterStarCaption.Text = TUtilityString.Format(FORMAT_StarCaption,param1.StarName,param1.StarCurrentExp,param1.StarNeedExp);
         this.FTextFormatCaption.color = COLOR_ContextDefault;
         this.FPainterStarCaption.Evaluate(this.FBoundsStarCaption);
         this.FPainterStarCaption.SetTextFormat(this.FTextFormatCaption,0,_loc2_);
         BoundsContextUnion(this.FBoundsStarCaption);
      }
      
      protected function EvaluationPerform_LevelCeiling(param1:TBigDipperTipData) : void
      {
         var _loc2_:int = 0;
         BoundsAlignDown(this.FBoundsLeveCeiling,this.FBoundsOffset);
         _loc2_ = FORMAT_CurrentLevelCeiling.length - STRING_PALACE.FORMAT_Level.length;
         this.FPainterLeveCeiling.Text = TUtilityString.Format(FORMAT_CurrentLevelCeiling,param1.CurrentLevelCeiling);
         this.FTextFormatCaption.color = COLOR_ContextDefault;
         this.FPainterLeveCeiling.Evaluate(this.FBoundsLeveCeiling);
         this.FPainterLeveCeiling.SetTextFormat(this.FTextFormatCaption,0,_loc2_);
         BoundsContextUnion(this.FBoundsLeveCeiling);
      }
      
      protected function EvaluationPerform_CurrentUpgradeAttribute(param1:TBigDipperTipData) : void
      {
         var _loc2_:int = 0;
         BoundsAlignDown(this.FBoundsCurrentUpgradeAttribute,this.FBoundsOffset);
         _loc2_ = FORMAT_CurrentUpgradeAttribute.length - "%0%1\n\n".length;
         this.FPainterCurrentUpgradeAttribute.Text = TUtilityString.Format(FORMAT_CurrentUpgradeAttribute,param1.StarAddAttrTypeName,param1.StarAddAttrValue);
         this.FTextFormatCaption.color = COLOR_ContextDefault;
         this.FPainterCurrentUpgradeAttribute.Evaluate(this.FBoundsCurrentUpgradeAttribute);
         this.FPainterCurrentUpgradeAttribute.SetTextFormat(this.FTextFormatCaption,0,_loc2_);
         BoundsContextUnion(this.FBoundsCurrentUpgradeAttribute);
      }
      
      protected function EvaluationPerform_NextUpgradeAttribute(param1:TBigDipperTipData) : void
      {
         var _loc2_:int = 0;
         BoundsAlignDown(this.FBoundsNextUpgradeAttribute,this.FBoundsOffset,SIZE_Padding_01);
         _loc2_ = FORMAT_NextUpgradeAttribute.length - "\n%0%1\n".length;
         this.FPainterNextUpgradeAttribute.Text = TUtilityString.Format(FORMAT_NextUpgradeAttribute,param1.StarAddAttrTypeName,param1.StarNextAddAttrValue);
         this.FTextFormatCaption.color = COLOR_ContextDefault;
         this.FPainterNextUpgradeAttribute.Evaluate(this.FBoundsNextUpgradeAttribute);
         this.FPainterNextUpgradeAttribute.SetTextFormat(this.FTextFormatCaption,0,_loc2_);
         BoundsContextUnion(this.FBoundsNextUpgradeAttribute);
      }
      
      override protected function SketchingPerform_Context() : void
      {
         this.SketchingPerform_Caption();
      }
      
      protected function SketchingPerform_Caption() : void
      {
         this.FPainterStarCaption.RenderBounds(this.FBoundsStarCaption,TAlignment.HORIZONTAL_Left);
         this.FPainterLeveCeiling.RenderBounds(this.FBoundsLeveCeiling,TAlignment.HORIZONTAL_Left);
         this.FPainterCurrentUpgradeAttribute.RenderBounds(this.FBoundsCurrentUpgradeAttribute,TAlignment.HORIZONTAL_Left);
         this.FPainterNextUpgradeAttribute.RenderBounds(this.FBoundsNextUpgradeAttribute,TAlignment.HORIZONTAL_Left);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPainterStarCaption.x = FBoundsRendering.X + this.FBoundsStarCaption.X;
         this.FPainterStarCaption.y = FBoundsRendering.Y + this.FBoundsStarCaption.Y;
         this.FPainterLeveCeiling.x = FBoundsRendering.X + this.FBoundsLeveCeiling.X;
         this.FPainterLeveCeiling.y = FBoundsRendering.Y + this.FBoundsLeveCeiling.Y;
         this.FPainterCurrentUpgradeAttribute.x = FBoundsRendering.X + this.FBoundsCurrentUpgradeAttribute.X;
         this.FPainterCurrentUpgradeAttribute.y = FBoundsRendering.Y + this.FBoundsCurrentUpgradeAttribute.Y;
         this.FPainterNextUpgradeAttribute.x = FBoundsRendering.X + this.FBoundsNextUpgradeAttribute.X;
         this.FPainterNextUpgradeAttribute.y = FBoundsRendering.Y + this.FBoundsNextUpgradeAttribute.Y;
      }
   }
}

