package Rendering.Overlayers.Inventories
{
   import Components.Standard.*;
   import Foundation.Common.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Inventories.*;
   import Rendering.Overlayers.*;
   import Rendering.Texts.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class TOverlayerTreasure extends TOverlayerInventory
   {
      
      protected static const SIZE_DividingLine_Max_Width:uint = 290;
      
      protected static const SIZE_DividingLine_Min_Width:uint = 280;
      
      protected static const SIZE_Image_Width:uint = 48;
      
      protected static const SIZE_Image_Height:uint = 48;
      
      protected static const SIZE_DefaultIcon_Width:uint = 36;
      
      protected static const SIZE_DefaultIcon_Height:uint = 36;
      
      protected static const SIZE_WordWrapWidth:uint = 130;
      
      protected static const SIZE_TextFormat_leading:uint = 2;
      
      protected static const SIZE_Padding_01:uint = 3;
      
      protected static const SIZE_Padding_02:uint = 5;
      
      protected static const SIZE_Padding_03:uint = 10;
      
      protected static const SIZE_Padding_04:uint = 15;
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_01:uint = 4291545959;
      
      protected static const COLOR_Context_02:uint = 4294967040;
      
      protected static const CATEGORY_TreasurePower:uint = CONST_INVENTORY.CATEGORYSECOND_TreasurePower;
      
      protected static const BASEATTRIBUTENAMES:Vector.<uint> = CONST_COMMON.BASEATTRIBUTENAMES;
      
      protected static const STRINGS_TreasuresAttributeCaption:Vector.<String> = STRING_INVENTORY.STRINGS_TreasuresAttributeCaption;
      
      protected static const FORMAT_UpgradingLevel:String = STRING_OVERLAYERTREASURE.FORMAT_UpgradingLevel;
      
      protected static const FORMAT_RequirementLevel:String = STRING_OVERLAYERTREASURE.FORMAT_RequirementLevel;
      
      protected static const FORMAT_CategorySecond:String = STRING_OVERLAYERTREASURE.FORMAT_CategorySecond;
      
      protected static const FORMAT_AppendAttributeCaption:String = STRING_OVERLAYERTREASURE.FORMAT_AppendAttributeCaption;
      
      protected static const FORMAT_AppendAttributes_01:String = STRING_OVERLAYERTREASURE.FORMAT_AppendAttributes_01;
      
      protected static const FORMAT_AppendAttributes_02:String = STRING_OVERLAYERTREASURE.FORMAT_AppendAttributes_02;
      
      protected static const FORMAT_DescCaption:String = STRING_OVERLAYERTREASURE.FORMAT_DescCaption;
      
      protected var FPainterUpgradingLevel:TPainterTextEffect;
      
      protected var FPainterRequirementLevel:TPainterTextEffect;
      
      protected var FPainterCategorySecond:TPainterTextEffect;
      
      protected var FPainterAppendAttributeCaption:TPainterTextEffect;
      
      protected var FPainterAppendAttributes:TPainterTextEffect;
      
      protected var FPainterDescCaption:TPainterTextEffect;
      
      protected var FBoundsUpgradingLevel:TBounds;
      
      protected var FBoundsRequirementLevel:TBounds;
      
      protected var FBoundsCategorySecond:TBounds;
      
      protected var FBoundsAppendAttributeCaption:TBounds;
      
      protected var FBoundsAppendAttributes:TBounds;
      
      protected var FBoundsDescCaption:TBounds;
      
      protected var FDividingLinePartCaption:Bitmap;
      
      protected var FDividingLinePartAttribute:Bitmap;
      
      protected var FDividingLinePartDescCaption:Bitmap;
      
      protected var FBoundsPartCaption:TBounds;
      
      protected var FBoundsPartAttribute:TBounds;
      
      protected var FBoundsPartDescCaption:TBounds;
      
      protected var FTextFormatRequirementLevel:TextFormat;
      
      protected var FTextFormatCategorySecond:TextFormat;
      
      protected var FTextFormatDescCaption:TextFormat;
      
      protected var FContextUpgradingLevel:uint;
      
      public function TOverlayerTreasure(param1:TUIComponent, param2:uint)
      {
         super(param1,param2);
         FImage = new TUIImage(this);
         FBoundsImage = new TBounds();
         this.FPainterUpgradingLevel = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsUpgradingLevel = new TBounds();
         this.FPainterRequirementLevel = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsRequirementLevel = new TBounds();
         this.FPainterCategorySecond = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsCategorySecond = new TBounds();
         this.FPainterAppendAttributeCaption = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsAppendAttributeCaption = new TBounds();
         this.FPainterAppendAttributes = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsAppendAttributes = new TBounds();
         this.FPainterDescCaption = ConstructPainterTextEffect(COLOR_Context_White);
         this.FPainterDescCaption.WordWrapWidth = SIZE_WordWrapWidth;
         this.FBoundsDescCaption = new TBounds();
         this.FDividingLinePartCaption = new Bitmap();
         this.FDividingLinePartAttribute = new Bitmap();
         this.FDividingLinePartDescCaption = new Bitmap();
         addChild(this.FDividingLinePartCaption);
         addChild(this.FDividingLinePartAttribute);
         addChild(this.FDividingLinePartDescCaption);
         this.FBoundsPartCaption = new TBounds();
         this.FBoundsPartAttribute = new TBounds();
         this.FBoundsPartDescCaption = new TBounds();
         this.FTextFormatRequirementLevel = new TextFormat();
         this.FTextFormatCategorySecond = new TextFormat();
         this.FTextFormatDescCaption = new TextFormat();
         FTextFormatSalePrice = new TextFormat();
         FTextFormatCaptionA = new TextFormat();
         FTextFormatCaptionB = new TextFormat();
         FQuerySequenceTimer = new Timer(500,1);
         FQuerySequenceTimer.addEventListener(TimerEvent.TIMER_COMPLETE,TimeQuerySequence);
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 1;
         FMarginBottom = 15;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         FMC_DefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         if(FMC_DefaultIcon != null)
         {
            FMC_DefaultIcon.mouseEnabled = false;
            this.addChild(FMC_DefaultIcon);
            FMC_DefaultIcon.stop();
            FMC_DefaultIcon.visible = false;
         }
         this.FDividingLinePartCaption.bitmapData = FDividingLine;
         this.FDividingLinePartAttribute.bitmapData = FDividingLine;
         this.FDividingLinePartDescCaption.bitmapData = FDividingLine;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is TEquipment;
      }
      
      override protected function ContextModified() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:TEquipment = null;
         _loc2_ = FContext as TEquipment;
         return FContextIdentifier0 != _loc2_.Identifier0 || FContextIdentifier1 != _loc2_.Identifier1 || FContextIDTemplate != _loc2_.IDTemplate || this.FContextUpgradingLevel != _loc2_.UpgradingLevel || FContextTimingTime != _loc2_.TimingTime;
      }
      
      override protected function ContextSynchronize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TEquipment = null;
         _loc3_ = FContext as TEquipment;
         FContextIdentifier0 = _loc3_.Identifier0;
         FContextIdentifier1 = _loc3_.Identifier1;
         FContextIDTemplate = _loc3_.IDTemplate;
         this.FContextUpgradingLevel = _loc3_.UpgradingLevel;
         FContextTimingTime = _loc3_.TimingTime;
         this.FDividingLinePartCaption.width = SIZE_DividingLine_Min_Width;
         this.FDividingLinePartAttribute.width = SIZE_DividingLine_Min_Width;
         this.FDividingLinePartDescCaption.width = SIZE_DividingLine_Min_Width;
         FDividingLinePartTimingTime.width = SIZE_DividingLine_Min_Width;
      }
      
      override protected function EvaluationPerform_Icon() : void
      {
         var _loc1_:TEquipment = null;
         var _loc2_:TAnimationSequence = null;
         FImage.Sequence = null;
         FMC_DefaultIcon.visible = false;
         _loc1_ = FContext as TEquipment;
         _loc2_ = SResourcesCore.TexturesInventory.GetAnimationSequenceByIdentifiers(_loc1_.IDTemplate,0);
         if(_loc2_ != null)
         {
            FImage.Sequence = _loc2_;
         }
         else
         {
            FImage.Sequence = null;
            if(!FQuerySequenceTimer.running)
            {
               FQuerySequenceTimer.start();
            }
            FMC_DefaultIcon.play();
            FMC_DefaultIcon.visible = true;
         }
         FBoundsImage.Width = SIZE_Image_Width;
         FBoundsImage.Height = SIZE_Image_Height;
         BoundsContextUnion(FBoundsImage);
         FBoundsOffset = FBoundsImage;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:TEquipment = null;
         _loc1_ = FContext as TEquipment;
         EvaluationPerform_Caption(_loc1_);
         FBoundsOffset = FBoundsCaption;
         this.EvaluationPerform_UpgradingLevel(_loc1_);
         FBoundsOffset = FBoundsCaption;
         this.EvaluationPerform_RequirementLevel(_loc1_);
         FBoundsOffset = this.FBoundsRequirementLevel;
         this.EvaluationPerform_CategorySecond(_loc1_);
         FBoundsOffset = this.FBoundsCategorySecond;
         this.EvaluationPerform_PartCaption(null);
         FBoundsOffset = this.FBoundsPartCaption;
         this.EvaluationPerform_AppendAttributeCaption(_loc1_);
         FBoundsOffset = this.FBoundsAppendAttributeCaption;
         this.EvaluationPerform_AppendAttributes(_loc1_);
         FBoundsOffset = this.FBoundsAppendAttributes;
         this.EvaluationPerform_PartAttribute(null);
         FBoundsOffset = this.FBoundsPartAttribute;
         this.EvaluationPerform_DescCaption(_loc1_);
         FBoundsOffset = this.FBoundsDescCaption;
         this.EvaluationPerform_PartDescCaption(null);
         FBoundsOffset = this.FBoundsPartDescCaption;
         EvaluationPerform_SalePrice(_loc1_);
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
      
      protected function EvaluationPerform_UpgradingLevel(param1:TEquipment) : void
      {
         var _loc2_:String = null;
         BoundsAlignRight(this.FBoundsUpgradingLevel,FBoundsOffset,SIZE_Padding_02);
         if(param1.UpgradingLevel > 0)
         {
            _loc2_ = TUtilityString.Format(FORMAT_UpgradingLevel,param1.UpgradingLevel.toString());
         }
         else
         {
            _loc2_ = "";
         }
         this.FPainterUpgradingLevel.Text = _loc2_;
         this.FPainterUpgradingLevel.Font.Size = SIZE_Context_00 - 1;
         this.FBoundsUpgradingLevel.Y += 1;
         this.FPainterUpgradingLevel.Evaluate(this.FBoundsUpgradingLevel);
         BoundsContextUnion(this.FBoundsUpgradingLevel);
      }
      
      protected function EvaluationPerform_RequirementLevel(param1:TEquipment) : void
      {
         var _loc2_:int = 0;
         BoundsAlignDown(this.FBoundsRequirementLevel,FBoundsOffset,SIZE_Padding_01);
         _loc2_ = FORMAT_RequirementLevel.length - "%0".length;
         this.FPainterRequirementLevel.Text = TUtilityString.Format(FORMAT_RequirementLevel,param1.RequirementLevel);
         this.FTextFormatRequirementLevel.size = this.FPainterRequirementLevel.Font.Size;
         this.FTextFormatRequirementLevel.color = COLOR_Context_White;
         this.FBoundsRequirementLevel.Y -= 2;
         this.FPainterRequirementLevel.Evaluate(this.FBoundsRequirementLevel);
         this.FPainterRequirementLevel.SetTextFormat(this.FTextFormatRequirementLevel,0,_loc2_);
         BoundsContextUnion(this.FBoundsRequirementLevel);
      }
      
      protected function EvaluationPerform_CategorySecond(param1:TEquipment) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         BoundsAlignDown(this.FBoundsCategorySecond,FBoundsOffset,SIZE_Padding_01);
         _loc3_ = STRINGS_TreasuresAttributeCaption[param1.CategorySecond % CATEGORY_TreasurePower];
         _loc2_ = FORMAT_CategorySecond.length - "%0".length;
         this.FPainterCategorySecond.Text = TUtilityString.Format(FORMAT_CategorySecond,_loc3_);
         this.FTextFormatCategorySecond.size = this.FPainterCategorySecond.Font.Size;
         this.FTextFormatCategorySecond.color = COLOR_Context_White;
         this.FPainterCategorySecond.Evaluate(this.FBoundsCategorySecond);
         this.FPainterCategorySecond.SetTextFormat(this.FTextFormatCategorySecond,0,_loc2_);
         BoundsContextUnion(this.FBoundsCategorySecond);
      }
      
      protected function EvaluationPerform_PartCaption(param1:TEquipment) : void
      {
         this.FBoundsPartCaption.Width = this.FDividingLinePartCaption.width;
         this.FBoundsPartCaption.Height = this.FDividingLinePartCaption.height;
         BoundsAlignDown(this.FBoundsPartCaption,FBoundsOffset,SIZE_Padding_03);
         this.FBoundsPartCaption.X = 0;
         BoundsContextUnion(this.FBoundsPartCaption);
      }
      
      protected function EvaluationPerform_AppendAttributeCaption(param1:TEquipment) : void
      {
         var _loc2_:String = null;
         BoundsAlignDown(this.FBoundsAppendAttributeCaption,FBoundsOffset,SIZE_Padding_01);
         _loc2_ = STRINGS_TreasuresAttributeCaption[param1.CategorySecond % CATEGORY_TreasurePower];
         this.FPainterAppendAttributeCaption.Text = TUtilityString.Format(FORMAT_AppendAttributeCaption,_loc2_);
         this.FPainterAppendAttributeCaption.Evaluate(this.FBoundsAppendAttributeCaption);
         BoundsContextUnion(this.FBoundsAppendAttributeCaption);
      }
      
      protected function EvaluationPerform_AppendAttributes(param1:TEquipment) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         BoundsAlignRight(this.FBoundsAppendAttributes,FBoundsOffset,SIZE_Padding_02);
         _loc2_ = BASEATTRIBUTENAMES.indexOf(param1.BasisPropertyCategory);
         _loc3_ = param1.BasisProperty.toString();
         _loc4_ = param1.UpgradingBasisProperty.toString();
         if(param1.UpgradingBasisProperty != 0)
         {
            this.FPainterAppendAttributes.Text = TUtilityString.Format(FORMAT_AppendAttributes_01,_loc3_,_loc4_);
         }
         else
         {
            this.FPainterAppendAttributes.Text = TUtilityString.Format(FORMAT_AppendAttributes_02,_loc3_);
         }
         this.FPainterAppendAttributes.Evaluate(this.FBoundsAppendAttributes);
         BoundsContextUnion(this.FBoundsAppendAttributes);
      }
      
      protected function EvaluationPerform_PartAttribute(param1:TEquipment) : void
      {
         this.FBoundsPartAttribute.Width = this.FDividingLinePartAttribute.width;
         this.FBoundsPartAttribute.Height = this.FDividingLinePartAttribute.height;
         BoundsAlignDown(this.FBoundsPartAttribute,FBoundsOffset,SIZE_Padding_02);
         this.FBoundsPartAttribute.X = 0;
         BoundsContextUnion(this.FBoundsPartAttribute);
      }
      
      protected function EvaluationPerform_DescCaption(param1:TEquipment) : void
      {
         BoundsAlignDown(this.FBoundsDescCaption,FBoundsOffset,SIZE_Padding_02);
         this.FTextFormatDescCaption.leading = SIZE_TextFormat_leading;
         this.FPainterDescCaption.Text = TUtilityString.Format(FORMAT_DescCaption,param1.Description);
         this.FPainterDescCaption.Evaluate(this.FBoundsDescCaption);
         this.FPainterDescCaption.SetTextFormat(this.FTextFormatDescCaption);
         BoundsContextUnion(this.FBoundsDescCaption);
      }
      
      protected function EvaluationPerform_PartDescCaption(param1:TEquipment) : void
      {
         var _loc2_:int = 0;
         this.FBoundsPartDescCaption.Width = this.FDividingLinePartDescCaption.width;
         this.FBoundsPartDescCaption.Height = this.FDividingLinePartDescCaption.height;
         _loc2_ = this.FPainterDescCaption.NumLines * SIZE_TextFormat_leading;
         BoundsAlignDown(this.FBoundsPartDescCaption,FBoundsOffset,SIZE_Padding_02 + _loc2_);
         BoundsContextUnion(this.FBoundsPartDescCaption);
      }
      
      override protected function SketchingPerform_Context() : void
      {
      }
      
      protected function SketchingPerform_Caption() : void
      {
         FPainterCaption.RenderBounds(FBoundsCaption,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_UpgradingLevel() : void
      {
         this.FPainterUpgradingLevel.RenderBounds(this.FBoundsUpgradingLevel,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_RequirementLevel() : void
      {
         this.FPainterRequirementLevel.RenderBounds(this.FBoundsRequirementLevel,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_CategorySecond() : void
      {
         this.FPainterCategorySecond.RenderBounds(this.FBoundsCategorySecond,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_AppendAttributeCaption() : void
      {
         this.FPainterAppendAttributeCaption.RenderBounds(this.FBoundsAppendAttributeCaption,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_AppendAttributes() : void
      {
         this.FPainterAppendAttributes.RenderBounds(this.FBoundsAppendAttributes,TAlignment.HORIZONTAL_Left);
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
         var _loc6_:TEquipment = null;
         _loc6_ = FContext as TEquipment;
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         FImage.X = FBoundsRendering.X + FBoundsImage.X;
         FImage.Y = FBoundsRendering.Y + FBoundsImage.Y;
         if(FMC_DefaultIcon.visible)
         {
            FMC_DefaultIcon.x = FImage.X + (SIZE_Image_Width - SIZE_DefaultIcon_Width) / 2;
            FMC_DefaultIcon.y = FImage.Y + (SIZE_Image_Height - SIZE_DefaultIcon_Height) / 2;
         }
         FPainterCaption.X = FBoundsRendering.X + FBoundsCaption.X;
         FPainterCaption.Y = FBoundsRendering.Y + FBoundsCaption.Y;
         this.FPainterUpgradingLevel.X = FBoundsRendering.X + this.FBoundsUpgradingLevel.X;
         this.FPainterUpgradingLevel.Y = FBoundsRendering.Y + this.FBoundsUpgradingLevel.Y;
         this.FPainterRequirementLevel.X = FBoundsRendering.X + this.FBoundsRequirementLevel.X;
         this.FPainterRequirementLevel.Y = FBoundsRendering.Y + this.FBoundsRequirementLevel.Y;
         this.FPainterCategorySecond.X = FBoundsRendering.X + this.FBoundsCategorySecond.X;
         this.FPainterCategorySecond.Y = FBoundsRendering.Y + this.FBoundsCategorySecond.Y;
         this.FDividingLinePartCaption.x = FBoundsRendering.X + this.FBoundsPartCaption.X - FMarginLeft + 2;
         this.FDividingLinePartCaption.y = FBoundsRendering.Y + this.FBoundsPartCaption.Y;
         this.FPainterAppendAttributeCaption.X = FBoundsRendering.X + this.FBoundsAppendAttributeCaption.X;
         this.FPainterAppendAttributeCaption.Y = FBoundsRendering.Y + this.FBoundsAppendAttributeCaption.Y;
         this.FPainterAppendAttributes.X = FBoundsRendering.X + this.FBoundsAppendAttributes.X;
         this.FPainterAppendAttributes.Y = FBoundsRendering.Y + this.FBoundsAppendAttributes.Y;
         this.FDividingLinePartAttribute.x = FBoundsRendering.X + this.FBoundsPartAttribute.X - FMarginLeft + 2;
         this.FDividingLinePartAttribute.y = FBoundsRendering.Y + this.FBoundsPartAttribute.Y;
         this.FPainterDescCaption.X = FBoundsRendering.X + this.FBoundsDescCaption.X;
         this.FPainterDescCaption.Y = FBoundsRendering.Y + this.FBoundsDescCaption.Y;
         this.FDividingLinePartDescCaption.x = FBoundsRendering.X + this.FBoundsPartDescCaption.X - FMarginLeft + 2;
         this.FDividingLinePartDescCaption.y = FBoundsRendering.Y + this.FBoundsPartDescCaption.Y;
         FPainterSalePrice.X = FBoundsRendering.X + FBoundsSalePrice.X;
         FPainterSalePrice.Y = FBoundsRendering.Y + FBoundsSalePrice.Y;
         if(_loc6_.TimingTime > 0)
         {
            FDividingLinePartTimingTime.x = FBoundsRendering.X + FBoundsPartTimingTime.X - FMarginLeft + SIZE_DividingLineOffset;
            FDividingLinePartTimingTime.y = FBoundsRendering.Y + FBoundsPartTimingTime.Y;
            FPainterTimingTime.X = FBoundsRendering.X + FBoundsTimingTime.X;
            FPainterTimingTime.Y = FBoundsRendering.Y + FBoundsTimingTime.Y;
         }
         this.FDividingLinePartCaption.width = SIZE_DividingLine_Max_Width;
         this.FDividingLinePartAttribute.width = SIZE_DividingLine_Max_Width;
         this.FDividingLinePartDescCaption.width = SIZE_DividingLine_Max_Width;
         FDividingLinePartTimingTime.width = SIZE_DividingLine_Max_Width;
      }
   }
}

