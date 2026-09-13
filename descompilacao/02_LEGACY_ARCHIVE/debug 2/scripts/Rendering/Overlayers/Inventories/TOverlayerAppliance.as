package Rendering.Overlayers.Inventories
{
   import Components.Standard.*;
   import Foundation.Common.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Inventories.*;
   import Processors.Game.Lobby.ActivityInner.Window.TProcessorWindowActivityInnerPsychicBeast;
   import Rendering.Overlayers.*;
   import Rendering.Texts.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.text.*;
   
   public class TOverlayerAppliance extends TOverlayerInventory
   {
      
      protected static const SIZE_DividingLine_Max_Width:uint = 293;
      
      protected static const SIZE_DividingLine_Min_Width:uint = 270;
      
      protected static const SIZE_TextFormat_leading:uint = 2;
      
      protected static const SIZE_WordWrapWidth:uint = 95;
      
      protected static const SIZE_Padding_01:uint = 5;
      
      protected static const SIZE_Padding_03:uint = 10;
      
      protected static const FORMAT_RequirementLevel:String = STRING_OVERLAYERAPPLIANCE.FORMAT_RequirementLevel;
      
      protected static const FORMAT_RequirementLevelCopy:String = STRING_OVERLAYERAPPLIANCE.FORMAT_RequirementLevelCopy;
      
      protected static const FORMAT_DescCaption:String = STRING_OVERLAYERAPPLIANCE.FORMAT_DescCaption;
      
      protected static const FORMAT_Desc:String = STRING_OVERLAYERAPPLIANCE.FORMAT_Desc;
      
      protected static const TEMPNUMBER:uint = 18100000;
      
      protected var FPainterRequirementLevel:TPainterTextEffect;
      
      protected var FPainterDescCaption:TPainterTextEffect;
      
      protected var FPainterDesc:TPainterTextEffect;
      
      protected var FBoundsRequirementLevel:TBounds;
      
      protected var FBoundsDescCaption:TBounds;
      
      protected var FBoundsDesc:TBounds;
      
      protected var FTextFormatRequirementLevel:TextFormat;
      
      protected var FTextFormatDesc:TextFormat;
      
      public function TOverlayerAppliance(param1:TUIComponent, param2:uint)
      {
         super(param1,param2);
         this.FPainterRequirementLevel = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsRequirementLevel = new TBounds();
         this.FPainterDescCaption = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsDescCaption = new TBounds();
         this.FPainterDesc = ConstructPainterTextEffect(COLOR_Context_01);
         this.FPainterDesc.WordWrapWidth = SIZE_WordWrapWidth;
         this.FBoundsDesc = new TBounds();
         this.FTextFormatRequirementLevel = new TextFormat();
         this.FTextFormatDesc = new TextFormat();
         FTextFormatSalePrice = new TextFormat();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is TAppliance;
      }
      
      override protected function ContextModified() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:TAppliance = null;
         _loc2_ = FContext as TAppliance;
         return FContextIdentifier0 != _loc2_.Identifier0 || FContextIdentifier1 != _loc2_.Identifier1 || FContextIDTemplate != _loc2_.IDTemplate || FContextTimingTime != _loc2_.TimingTime;
      }
      
      override protected function ContextSynchronize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TAppliance = null;
         _loc3_ = FContext as TAppliance;
         FContextIdentifier0 = _loc3_.Identifier0;
         FContextIdentifier1 = _loc3_.Identifier1;
         FContextIDTemplate = _loc3_.IDTemplate;
         FContextTimingTime = _loc3_.TimingTime;
         FDividingLinePartTimingTime.width = SIZE_DividingLine_Min_Width;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:TAppliance = null;
         _loc1_ = FContext as TAppliance;
         this.EvaluationPerform_Caption(_loc1_);
         FBoundsOffset = FBoundsCaption;
         this.EvaluationPerform_RequirementLevel(_loc1_);
         FBoundsOffset = this.FBoundsRequirementLevel;
         this.EvaluationPerform_DescCaption(_loc1_);
         FBoundsOffset = this.FBoundsDescCaption;
         this.EvaluationPerform_Desc(_loc1_);
         FBoundsOffset = this.FBoundsDescCaption;
         this.EvaluationPerform_SalePrice(_loc1_);
         FBoundsOffset = FBoundsSalePrice;
         if(_loc1_.TimingTime > 0)
         {
            FPainterTimingTime.Visible = true;
            FDividingLinePartTimingTime.visible = true;
            EvaluationPerform_PartTimingTime(null);
            FBoundsOffset = FBoundsPartTimingTime;
            EvaluationPerform_TimingTime(_loc1_);
            FBoundsOffset = FBoundsTimingTime;
         }
         else
         {
            FPainterTimingTime.Visible = false;
            FDividingLinePartTimingTime.visible = false;
         }
      }
      
      override protected function EvaluationPerform_Caption(param1:TInventory) : void
      {
         var _loc2_:String = null;
         BoundsAlignDown(FBoundsCaption,null,SIZE_Padding_01);
         _loc2_ = param1.Name;
         FPainterCaption.Text = TUtilityString.Format(FORMAT_Caption,_loc2_);
         FPainterCaption.Font.Size = SIZE_Context_00;
         FPainterCaption.Font.Color = QUALITYCOLOR_INDEX[param1.Quality];
         FBoundsCaption.Y -= 5;
         FPainterCaption.Evaluate(FBoundsCaption);
         BoundsContextUnion(FBoundsCaption);
      }
      
      protected function EvaluationPerform_RequirementLevel(param1:TAppliance) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         BoundsAlignDown(this.FBoundsRequirementLevel,FBoundsOffset,SIZE_Padding_01);
         _loc2_ = int(STRING_OVERLAYERAPPLIANCE.FORMAT_RequirementLevel_COLOR_LEGNTH);
         if(param1.CategorySecond == TProcessorWindowActivityInnerPsychicBeast.PsychicBeastType)
         {
            _loc3_ = (param1.RequirementLevel - TEMPNUMBER) / 100 + 1;
            _loc4_ = (param1.RequirementLevel - TEMPNUMBER) % 100 - 1;
            _loc5_ = TUtilityString.Format(STRING_OVERLAYERAPPLIANCE.FORMAT_RequirementPetLevel,_loc3_,_loc4_);
            this.FPainterRequirementLevel.Text = _loc5_;
         }
         else if(param1.RequirementLevel < 1000)
         {
            this.FPainterRequirementLevel.Text = TUtilityString.Format(FORMAT_RequirementLevel,param1.RequirementLevel);
         }
         else
         {
            this.FPainterRequirementLevel.Text = TUtilityString.Format(FORMAT_RequirementLevelCopy,STRING_COMMON.GetLevelStrByLevelLineFeed(param1.RequirementLevel));
         }
         this.FTextFormatRequirementLevel.size = this.FPainterRequirementLevel.Font.Size;
         this.FTextFormatRequirementLevel.color = COLOR_Context_White;
         this.FPainterRequirementLevel.Evaluate(this.FBoundsRequirementLevel);
         this.FPainterRequirementLevel.SetTextFormat(this.FTextFormatRequirementLevel,0,_loc2_);
         BoundsContextUnion(this.FBoundsRequirementLevel);
      }
      
      protected function EvaluationPerform_DescCaption(param1:TAppliance) : void
      {
         BoundsAlignDown(this.FBoundsDescCaption,FBoundsOffset,SIZE_Padding_01);
         this.FPainterDescCaption.Text = TUtilityString.Format(FORMAT_DescCaption);
         this.FPainterDescCaption.Evaluate(this.FBoundsDescCaption);
         BoundsContextUnion(this.FBoundsDescCaption);
      }
      
      protected function EvaluationPerform_Desc(param1:TAppliance) : void
      {
         var _loc2_:String = null;
         BoundsAlignRight(this.FBoundsDesc,FBoundsOffset,SIZE_Padding_01);
         this.FTextFormatDesc.leading = SIZE_TextFormat_leading;
         _loc2_ = param1.Description.split("%n").join("\n");
         this.FPainterDesc.Text = TUtilityString.Format(FORMAT_Desc,_loc2_);
         this.FPainterDesc.Evaluate(this.FBoundsDesc);
         this.FPainterDesc.SetTextFormat(this.FTextFormatDesc);
         BoundsContextUnion(this.FBoundsDesc);
      }
      
      override protected function EvaluationPerform_SalePrice(param1:TInventory) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         _loc2_ = this.FPainterDesc.NumLines * SIZE_TextFormat_leading + this.FPainterDesc.TextHeight;
         BoundsAlignDown(FBoundsSalePrice,FBoundsOffset,_loc2_);
         _loc3_ = param1.SellValue;
         _loc4_ = FORMAT_SalePrice.length - "%0".length;
         FPainterSalePrice.Text = TUtilityString.Format(FORMAT_SalePrice,_loc3_);
         FTextFormatSalePrice.color = COLOR_Context_White;
         FPainterSalePrice.Evaluate(FBoundsSalePrice);
         FPainterSalePrice.SetTextFormat(FTextFormatSalePrice,0,_loc4_);
         BoundsContextUnion(FBoundsSalePrice);
      }
      
      override protected function SketchingPerform_Context() : void
      {
         var _loc1_:TAppliance = null;
         _loc1_ = FContext as TAppliance;
      }
      
      protected function SketchingPerform_Caption() : void
      {
         FPainterCaption.RenderBounds(FBoundsCaption,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_RequirementLevel() : void
      {
         this.FPainterRequirementLevel.RenderBounds(this.FBoundsRequirementLevel,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_DescCaption() : void
      {
         this.FPainterDescCaption.RenderBounds(this.FBoundsDescCaption,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_Desc() : void
      {
         this.FPainterDesc.RenderBounds(this.FBoundsDesc,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_SalePrice() : void
      {
         FPainterSalePrice.RenderBounds(FBoundsSalePrice,TAlignment.HORIZONTAL_Left);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBounds = null;
         var _loc5_:TPainterTextEffect = null;
         var _loc6_:TAppliance = null;
         _loc6_ = FContext as TAppliance;
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         FPainterCaption.X = FBoundsRendering.X + FBoundsCaption.X;
         FPainterCaption.Y = FBoundsRendering.Y + FBoundsCaption.Y;
         this.FPainterRequirementLevel.X = FBoundsRendering.X + this.FBoundsRequirementLevel.X;
         this.FPainterRequirementLevel.Y = FBoundsRendering.Y + this.FBoundsRequirementLevel.Y;
         this.FPainterDescCaption.X = FBoundsRendering.X + this.FBoundsDescCaption.X;
         this.FPainterDescCaption.Y = FBoundsRendering.Y + this.FBoundsDescCaption.Y;
         this.FPainterDesc.X = FBoundsRendering.X + this.FBoundsDesc.X;
         this.FPainterDesc.Y = FBoundsRendering.Y + this.FBoundsDesc.Y;
         FPainterSalePrice.X = FBoundsRendering.X + FBoundsSalePrice.X;
         FPainterSalePrice.Y = FBoundsRendering.Y + FBoundsSalePrice.Y;
         if(_loc6_.TimingTime > 0)
         {
            FDividingLinePartTimingTime.x = FBoundsRendering.X + FBoundsPartTimingTime.X - FMarginLeft + SIZE_DividingLineOffset;
            FDividingLinePartTimingTime.y = FBoundsRendering.Y + FBoundsPartTimingTime.Y;
            FPainterTimingTime.X = FBoundsRendering.X + FBoundsTimingTime.X;
            FPainterTimingTime.Y = FBoundsRendering.Y + FBoundsTimingTime.Y;
         }
         FDividingLinePartTimingTime.width = SIZE_DividingLine_Max_Width;
      }
   }
}

