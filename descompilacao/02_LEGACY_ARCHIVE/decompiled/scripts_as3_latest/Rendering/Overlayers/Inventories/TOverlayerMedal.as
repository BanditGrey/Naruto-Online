package Rendering.Overlayers.Inventories
{
   import Components.Standard.*;
   import Foundation.Common.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.VO.TRuneEnchantValue;
   import Logics.Inventories.*;
   import Rendering.Overlayers.*;
   import Rendering.Texts.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class TOverlayerMedal extends TOverlayerInventory
   {
      
      protected static const SIZE_WordWrapWidth:uint = 130;
      
      protected static const CAPACITY_AppendAttributes:uint = 4;
      
      protected static const SIZE_DividingLine_Max_Width:uint = 280;
      
      protected static const SIZE_DividingLine_Min_Width:uint = 270;
      
      protected static const SIZE_Image_Width:uint = 48;
      
      protected static const SIZE_Image_Height:uint = 48;
      
      protected static const SIZE_DefaultIcon_Width:uint = 36;
      
      protected static const SIZE_DefaultIcon_Height:uint = 36;
      
      protected static const SIZE_Padding_01:uint = 1;
      
      protected static const SIZE_Padding_02:uint = 3;
      
      protected static const SIZE_Padding_03:uint = 10;
      
      protected static const SIZE_Context_00:uint = 15;
      
      protected static const BASEATTRIBUTENAMES:Vector.<uint> = CONST_COMMON.BASEATTRIBUTENAMES;
      
      protected static const STRINGS_BASEATTRIBUTENAMES:Vector.<String> = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES;
      
      protected static const FORMAT_UpgradingLevel:String = STRING_OVERLAYEREQUIPMENT.FORMAT_UpgradingLevel;
      
      protected static const FORMAT_BasisProperty_01:String = STRING_OVERLAYEREQUIPMENT.FORMAT_BasisProperty_01;
      
      protected static const FORMAT_BasisProperty_02:String = STRING_OVERLAYEREQUIPMENT.FORMAT_BasisProperty_02;
      
      protected static const FORMAT_AppendAttributeCaption:String = STRING_OVERLAYEREQUIPMENT.FORMAT_AppendAttributeCaption;
      
      protected static const FORMAT_AppendAttributes:String = STRING_OVERLAYEREQUIPMENT.FORMAT_AppendAttributes;
      
      protected static const FORMAT_AppendAttributesPercentage:String = STRING_OVERLAYEREQUIPMENT.FORMAT_AppendAttributesPercentage;
      
      protected static const FORMAT_AppendAttributesUnknown:String = STRING_OVERLAYEREQUIPMENT.FORMAT_AppendAttributesUnknown;
      
      protected var FPainterUpgradingLevel:TPainterTextEffect;
      
      protected var FPainterBasisProperty:TPainterTextEffect;
      
      protected var FPainterBasicAttributeCaption:TPainterTextEffect;
      
      protected var FPainterAppendAttributes:Vector.<TPainterTextEffect>;
      
      protected var FPainterRefinedAttributeCaption:TPainterTextEffect;
      
      protected var FBoundsUpgradingLevel:TBounds;
      
      protected var FBoundsBasisProperty:TBounds;
      
      protected var FBoundsAppendAttributeCaption:TBounds;
      
      protected var FBoundsRefinedAttributeCaption:TBounds;
      
      protected var FBoundsAppendAttributes:Vector.<TBounds>;
      
      protected var FDividingLinePartCaption:Bitmap;
      
      protected var FDividingLinePartAttribute:Bitmap;
      
      protected var FBoundsPartCaption:TBounds;
      
      protected var FBoundsPartAttribute:TBounds;
      
      protected var FTextFormatBasisProperty:TextFormat;
      
      protected var FContextUpgradingLevel:uint;
      
      protected var FContextWeaponSkillID:uint;
      
      public function TOverlayerMedal(param1:TUIComponent, param2:uint)
      {
         var _loc3_:int = 0;
         var _loc4_:TBounds = null;
         var _loc5_:TPainterTextEffect = null;
         super(param1,param2);
         FImage = new TUIImage(this);
         FImage.mouseEnabled = false;
         FBoundsImage = new TBounds();
         this.FPainterUpgradingLevel = ConstructPainterTextEffect(COLOR_Context_01);
         this.FPainterUpgradingLevel.Font.Bold = true;
         this.FBoundsUpgradingLevel = new TBounds();
         this.FPainterBasisProperty = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsBasisProperty = new TBounds();
         this.FPainterBasicAttributeCaption = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsAppendAttributeCaption = new TBounds();
         this.FPainterRefinedAttributeCaption = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsRefinedAttributeCaption = new TBounds();
         this.FPainterAppendAttributes = new Vector.<TPainterTextEffect>(CAPACITY_AppendAttributes);
         this.FBoundsAppendAttributes = new Vector.<TBounds>(CAPACITY_AppendAttributes);
         _loc3_ = 0;
         while(_loc3_ < CAPACITY_AppendAttributes)
         {
            _loc5_ = ConstructPainterTextEffect(COLOR_Context_AppendAttributes);
            this.FPainterAppendAttributes[_loc3_] = _loc5_;
            _loc4_ = new TBounds();
            this.FBoundsAppendAttributes[_loc3_] = _loc4_;
            _loc3_++;
         }
         FPainterTimingTime = ConstructPainterTextEffect(COLOR_Context_White);
         FBoundsTimingTime = new TBounds();
         this.FDividingLinePartCaption = new Bitmap();
         this.FDividingLinePartAttribute = new Bitmap();
         addChild(this.FDividingLinePartCaption);
         addChild(this.FDividingLinePartAttribute);
         this.FBoundsPartCaption = new TBounds();
         this.FBoundsPartAttribute = new TBounds();
         this.FTextFormatBasisProperty = new TextFormat();
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
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is TEquipment;
      }
      
      override protected function ContextModified() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:TAppliance = null;
         var _loc5_:TEquipment = null;
         _loc5_ = FContext as TEquipment;
         if(_loc3_)
         {
         }
         return _loc3_;
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
         this.FContextWeaponSkillID = _loc3_.WeaponSkillID;
         FContextTimingTime = _loc3_.TimingTime;
         this.FDividingLinePartCaption.width = SIZE_DividingLine_Min_Width;
         this.FDividingLinePartAttribute.width = SIZE_DividingLine_Min_Width;
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
         BoundsAlignRight(FBoundsImage,null,SIZE_Padding_01);
         BoundsContextUnion(FBoundsImage);
         FBoundsOffset = FBoundsImage;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TEquipment = null;
         var _loc4_:TPainterTextEffect = null;
         _loc3_ = FContext as TEquipment;
         EvaluationPerform_Caption(_loc3_);
         FBoundsOffset = FBoundsCaption;
         this.EvaluationPerform_UpgradingLevel(_loc3_);
         FBoundsOffset = FBoundsImage;
         this.EvaluationPerform_PartCaption(null);
         FBoundsOffset = this.FBoundsPartCaption;
         this.EvaluationPerform_BasicAttributeCaption(_loc3_);
         FBoundsOffset = this.FBoundsAppendAttributeCaption;
         this.EvaluationPerform_BasisProperty(_loc3_);
         FBoundsOffset = this.FBoundsBasisProperty;
         this.EvaluationPerform_PartBasicAttribute(null);
         FBoundsOffset = this.FBoundsPartAttribute;
         this.EvaluationPerform_RefinedAttributeCaption(_loc3_);
         FBoundsOffset = this.FBoundsRefinedAttributeCaption;
         this.EvaluationPerform_AppendAttributes(_loc3_);
      }
      
      protected function EvaluationPerform_UpgradingLevel(param1:TEquipment) : void
      {
         var _loc2_:String = null;
         BoundsAlignRight(this.FBoundsUpgradingLevel,FBoundsOffset,SIZE_Padding_01);
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
      
      protected function EvaluationPerform_PartCaption(param1:TEquipment) : void
      {
         this.FBoundsPartCaption.Width = this.FDividingLinePartCaption.width;
         this.FBoundsPartCaption.Height = this.FDividingLinePartCaption.height;
         BoundsAlignDown(this.FBoundsPartCaption,FBoundsOffset,SIZE_Padding_02);
         this.FBoundsPartCaption.X = 0;
         BoundsContextUnion(this.FBoundsPartCaption);
      }
      
      protected function EvaluationPerform_BasisProperty(param1:TEquipment) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:TRuneEnchantValue = null;
         var _loc8_:TBins = null;
         var _loc9_:int = 0;
         var _loc10_:TRuneEnchantValue = null;
         BoundsAlignRight(this.FBoundsBasisProperty,FBoundsOffset,SIZE_Padding_01);
         _loc2_ = BASEATTRIBUTENAMES.indexOf(param1.BasisPropertyCategory);
         _loc3_ = STRINGS_BASEATTRIBUTENAMES[_loc2_];
         _loc4_ = param1.BasisProperty.toString();
         _loc2_ = BASEATTRIBUTENAMES.indexOf(param1.MainAdditionalCategory);
         _loc5_ = STRINGS_BASEATTRIBUTENAMES[_loc2_];
         _loc6_ = (param1.MainAdditionalValue * 100).toString();
         _loc8_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RuneEnchantValue);
         _loc9_ = _loc8_.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc9_)
         {
            _loc10_ = _loc8_.GetDatebaseByIndex(_loc2_) as TRuneEnchantValue;
            if(param1.UpgradingLevel == _loc10_.Level)
            {
               _loc7_ = _loc10_;
               break;
            }
            _loc2_++;
         }
         if(param1.UpgradingLevel != 0)
         {
            this.FPainterBasisProperty.Text = TUtilityString.Format(FORMAT_BasisProperty_01,_loc3_,_loc4_,parseInt(_loc4_) * (_loc7_.Mainattribute - 100) / 100) + "\n" + TUtilityString.Format(FORMAT_BasisProperty_01,_loc5_,_loc6_ + "%",(parseFloat(_loc6_) * (_loc7_.Assattribute - 100) / 100).toFixed(2) + "%");
         }
         else
         {
            this.FPainterBasisProperty.Text = TUtilityString.Format(FORMAT_BasisProperty_02,_loc3_,_loc4_) + "\n" + TUtilityString.Format(FORMAT_BasisProperty_02,_loc5_,_loc6_ + "%");
         }
         this.FTextFormatBasisProperty.size = this.FPainterBasisProperty.Font.Size;
         this.FTextFormatBasisProperty.color = COLOR_Context_White;
         this.FPainterBasisProperty.Evaluate(this.FBoundsBasisProperty);
         BoundsContextUnion(this.FBoundsBasisProperty);
      }
      
      protected function EvaluationPerform_BasicAttributeCaption(param1:TEquipment) : void
      {
         BoundsAlignDown(this.FBoundsAppendAttributeCaption,FBoundsOffset,SIZE_Padding_02);
         this.FPainterBasicAttributeCaption.Text = STRING_OVERLAYERTREASURE.FORMAT_AppendAttributeCaption2.substring(0,5);
         this.FPainterBasicAttributeCaption.Evaluate(this.FBoundsAppendAttributeCaption);
         BoundsContextUnion(this.FBoundsAppendAttributeCaption);
      }
      
      protected function EvaluationPerform_RefinedAttributeCaption(param1:TEquipment) : void
      {
         BoundsAlignDown(this.FBoundsRefinedAttributeCaption,FBoundsOffset,SIZE_Padding_02);
         this.FPainterRefinedAttributeCaption.Text = FORMAT_AppendAttributeCaption;
         this.FPainterRefinedAttributeCaption.Evaluate(this.FBoundsRefinedAttributeCaption);
         this.FBoundsRefinedAttributeCaption.X = 0;
         BoundsContextUnion(this.FBoundsRefinedAttributeCaption);
      }
      
      protected function EvaluationPerform_AppendAttributes(param1:TEquipment) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBounds = null;
         var _loc4_:TPainterTextEffect = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:uint = 0;
         var _loc8_:TEquipmentAppendAttribute = null;
         var _loc9_:int = 0;
         _loc9_ = param1.AppendAttributes.Count;
         _loc2_ = 0;
         while(_loc2_ < CAPACITY_AppendAttributes)
         {
            _loc3_ = this.FBoundsAppendAttributes[_loc2_];
            if(_loc2_ == 0)
            {
               BoundsAlignRight(_loc3_,FBoundsOffset,SIZE_Padding_01);
            }
            else
            {
               BoundsAlignDown(_loc3_,FBoundsOffset);
            }
            FBoundsOffset = _loc3_;
            _loc4_ = this.FPainterAppendAttributes[_loc2_];
            if(_loc2_ < _loc9_)
            {
               _loc8_ = param1.AppendAttributes.GetAttributeByIndex(_loc2_);
               if(_loc8_ == null)
               {
                  _loc4_.Text = FORMAT_AppendAttributesUnknown;
                  _loc4_.Font.Color = COLOR_Context_Unknown;
                  _loc4_.Evaluate(_loc3_);
                  BoundsContextUnion(_loc3_);
               }
               else
               {
                  _loc5_ = _loc8_.Name;
                  _loc6_ = _loc8_.OldValue.toFixed(2);
                  if(_loc8_.Percentage == 1)
                  {
                     _loc4_.Text = TUtilityString.Format(FORMAT_AppendAttributesPercentage,_loc5_,_loc6_);
                  }
                  else
                  {
                     _loc4_.Text = TUtilityString.Format(FORMAT_AppendAttributes,_loc5_,_loc6_);
                  }
                  _loc4_.Font.Color = COLOR_Context_AppendAttributes;
                  _loc4_.Evaluate(_loc3_);
                  BoundsContextUnion(_loc3_);
               }
            }
            else
            {
               _loc4_.Text = FORMAT_AppendAttributesUnknown;
               _loc4_.Font.Color = COLOR_Context_Unknown;
               _loc4_.Evaluate(_loc3_);
               BoundsContextUnion(_loc3_);
            }
            _loc2_++;
         }
      }
      
      protected function EvaluationPerform_PartBasicAttribute(param1:TEquipment) : void
      {
         this.FBoundsPartAttribute.Width = this.FDividingLinePartAttribute.width;
         this.FBoundsPartAttribute.Height = this.FDividingLinePartAttribute.height;
         BoundsAlignDown(this.FBoundsPartAttribute,FBoundsOffset,SIZE_Padding_02);
         this.FBoundsPartAttribute.X = 0;
         BoundsContextUnion(this.FBoundsPartAttribute);
      }
      
      protected function SketchingPerform_Caption() : void
      {
         FPainterCaption.RenderBounds(FBoundsCaption,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_UpgradingLevel() : void
      {
         this.FPainterUpgradingLevel.RenderBounds(this.FBoundsUpgradingLevel,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_BasisProperty() : void
      {
         this.FPainterBasisProperty.RenderBounds(this.FBoundsBasisProperty,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_AppendAttributeCaption() : void
      {
         this.FPainterBasicAttributeCaption.RenderBounds(this.FBoundsAppendAttributeCaption,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_AppendAttributes() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBounds = null;
         var _loc4_:TPainterTextEffect = null;
         var _loc5_:TEquipment = null;
         _loc5_ = FContext as TEquipment;
         _loc2_ = int(_loc5_.MaxAdditionalCount);
         _loc1_ = 0;
         while(_loc1_ < CAPACITY_AppendAttributes)
         {
            if(_loc1_ >= _loc2_)
            {
               break;
            }
            _loc4_ = this.FPainterAppendAttributes[_loc1_];
            _loc3_ = this.FBoundsAppendAttributes[_loc1_];
            _loc4_.RenderBounds(_loc3_,TAlignment.HORIZONTAL_Left);
            _loc1_++;
         }
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBounds = null;
         var _loc4_:TPainterTextEffect = null;
         var _loc5_:TEquipment = null;
         _loc5_ = FContext as TEquipment;
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
         this.FDividingLinePartCaption.x = FBoundsRendering.X + this.FBoundsPartCaption.X - FMarginLeft + SIZE_DividingLineOffset;
         this.FDividingLinePartCaption.y = FBoundsRendering.Y + this.FBoundsPartCaption.Y;
         this.FPainterBasisProperty.X = FBoundsRendering.X + this.FBoundsBasisProperty.X;
         this.FPainterBasisProperty.Y = FBoundsRendering.Y + this.FBoundsBasisProperty.Y;
         this.FPainterBasicAttributeCaption.X = FBoundsRendering.X + this.FBoundsAppendAttributeCaption.X;
         this.FPainterBasicAttributeCaption.Y = FBoundsRendering.Y + this.FBoundsAppendAttributeCaption.Y;
         this.FDividingLinePartAttribute.x = FBoundsRendering.X - FMarginLeft + SIZE_DividingLineOffset;
         this.FDividingLinePartAttribute.y = FBoundsRendering.Y + this.FBoundsPartAttribute.Y;
         this.FPainterRefinedAttributeCaption.X = FBoundsRendering.X + this.FBoundsRefinedAttributeCaption.X;
         this.FPainterRefinedAttributeCaption.Y = FBoundsRendering.Y + this.FBoundsRefinedAttributeCaption.Y;
         _loc2_ = 0;
         while(_loc2_ < CAPACITY_AppendAttributes)
         {
            _loc4_ = this.FPainterAppendAttributes[_loc2_];
            _loc3_ = this.FBoundsAppendAttributes[_loc2_];
            _loc4_.X = FBoundsRendering.X + _loc3_.X;
            _loc4_.Y = FBoundsRendering.Y + _loc3_.Y;
            _loc2_++;
         }
         FPainterSalePrice.X = FBoundsRendering.X + FBoundsSalePrice.X;
         FPainterSalePrice.Y = FBoundsRendering.Y + FBoundsSalePrice.Y;
         if(_loc5_.TimingTime > 0)
         {
            FDividingLinePartTimingTime.x = FBoundsRendering.X + FBoundsPartTimingTime.X - FMarginLeft + SIZE_DividingLineOffset;
            FDividingLinePartTimingTime.y = FBoundsRendering.Y + FBoundsPartTimingTime.Y;
            FPainterTimingTime.X = FBoundsRendering.X + FBoundsTimingTime.X;
            FPainterTimingTime.Y = FBoundsRendering.Y + FBoundsTimingTime.Y;
         }
         this.FDividingLinePartCaption.width = SIZE_DividingLine_Max_Width;
         this.FDividingLinePartAttribute.width = SIZE_DividingLine_Max_Width;
         FDividingLinePartTimingTime.width = SIZE_DividingLine_Max_Width;
      }
   }
}

