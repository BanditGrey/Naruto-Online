package Rendering.Overlayers.Inventories
{
   import Components.Standard.*;
   import Foundation.Common.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.VO.TLostsacredUpgrade;
   import Logics.Inventories.*;
   import Rendering.Overlayers.*;
   import Rendering.Texts.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class TOverlayerSuperTreasure extends TOverlayerInventory
   {
      
      protected static const SIZE_DividingLine_Max_Width:uint = 290;
      
      protected static const SIZE_DividingLine_Min_Width:uint = 280;
      
      protected static const SIZE_Image_Width:uint = 48;
      
      protected static const SIZE_Image_Height:uint = 48;
      
      protected static const SIZE_DefaultIcon_Width:uint = 36;
      
      protected static const SIZE_DefaultIcon_Height:uint = 36;
      
      protected static const SIZE_WordWrapWidth:uint = 130;
      
      protected static const SIZE_TextFormat_leading:uint = 2;
      
      protected static const SIZE_Three:uint = 3;
      
      protected static const SIZE_Padding_01:uint = 3;
      
      protected static const SIZE_Padding_02:uint = 5;
      
      protected static const SIZE_Padding_03:uint = 10;
      
      protected static const SIZE_Padding_04:uint = 15;
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_01:uint = 4291545959;
      
      protected static const COLOR_Context_02:uint = 4294967040;
      
      protected static const COLOR_Context_03:uint = 4284940083;
      
      protected static const CATEGORY_TreasurePower:uint = CONST_INVENTORY.CATEGORYSECOND_TreasurePower;
      
      protected static const BASEATTRIBUTENAMES:Vector.<uint> = CONST_COMMON.BASEATTRIBUTENAMES;
      
      protected static const STRINGS_TreasuresAttributeCaption:Vector.<String> = STRING_INVENTORY.STRINGS_TreasuresAttributeCaption;
      
      protected static const FORMAT_UpgradingLevel:String = STRING_OVERLAYERTREASURE.FORMAT_UpgradingLevel;
      
      protected static const FORMAT_RequirementLevel:String = STRING_OVERLAYERTREASURE.FORMAT_RequirementLevel;
      
      protected static const FORMAT_CategorySecond:String = STRING_OVERLAYERTREASURE.FORMAT_CategorySecond;
      
      protected static const FORMAT_AppendAttributeCaption2:String = STRING_OVERLAYERTREASURE.FORMAT_AppendAttributeCaption2;
      
      protected static const FORMAT_AppendAttributes_01:String = STRING_OVERLAYERTREASURE.FORMAT_AppendAttributes_01;
      
      protected static const FORMAT_AppendAttributes_02:String = STRING_OVERLAYERTREASURE.FORMAT_AppendAttributes_02;
      
      protected static const FORMAT_DescCaption:String = STRING_OVERLAYERTREASURE.FORMAT_DescCaption;
      
      protected var FPainterUpgradingLevel:TPainterTextEffect;
      
      protected var FPainterCategorySecond:TPainterTextEffect;
      
      protected var FPainterAppendAttributeCaption:TPainterTextEffect;
      
      protected var FPainterAppendAttributes:TPainterTextEffect;
      
      protected var FPainterDescCaption:TPainterTextEffect;
      
      protected var FPainterNimei0:TPainterTextEffect;
      
      protected var FBoundsNimei0:TBounds;
      
      protected var FPainterNimeiVector:Vector.<TPainterTextEffect>;
      
      protected var FBoundsNimei:Vector.<TBounds>;
      
      protected var FBoundsUpgradingLevel:TBounds;
      
      protected var FBoundsCategorySecond:TBounds;
      
      protected var FBoundsAppendAttributeCaption:TBounds;
      
      protected var FBoundsAppendAttributes:TBounds;
      
      protected var FBoundsDescCaption:TBounds;
      
      protected var FDividingLinePartCaption:Bitmap;
      
      protected var FDividingLinePartAttribute:Bitmap;
      
      protected var FDividingLinePartDescCaption:Bitmap;
      
      protected var FDividingLinePartNimei:Bitmap;
      
      protected var FBoundsPartCaption:TBounds;
      
      protected var FBoundsPartAttribute:TBounds;
      
      protected var FBoundsPartDescCaption:TBounds;
      
      protected var FBoundsPartDescCaption_nimei:TBounds;
      
      protected var FTextFormatRequirementLevel:TextFormat;
      
      protected var FTextFormatCategorySecond:TextFormat;
      
      protected var FTextFormatDescCaption:TextFormat;
      
      protected var FContextUpgradingLevel:uint;
      
      public function TOverlayerSuperTreasure(param1:TUIComponent, param2:uint)
      {
         super(param1,param2);
         FImage = new TUIImage(this);
         FBoundsImage = new TBounds();
         this.FPainterUpgradingLevel = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsUpgradingLevel = new TBounds();
         this.FPainterCategorySecond = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsCategorySecond = new TBounds();
         this.FPainterAppendAttributeCaption = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsAppendAttributeCaption = new TBounds();
         this.FPainterAppendAttributes = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsAppendAttributes = new TBounds();
         this.FPainterDescCaption = ConstructPainterTextEffect(COLOR_Context_White);
         this.FPainterDescCaption.WordWrapWidth = SIZE_WordWrapWidth;
         this.FBoundsDescCaption = new TBounds();
         this.FPainterNimei0 = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsNimei0 = new TBounds();
         this.FPainterNimeiVector = new Vector.<TPainterTextEffect>(SIZE_Three);
         this.FBoundsNimei = new Vector.<TBounds>(SIZE_Three);
         var _loc3_:int = 0;
         while(_loc3_ < 6)
         {
            this.FPainterNimeiVector[_loc3_] = ConstructPainterTextEffect(COLOR_Context_White);
            this.FBoundsNimei[_loc3_] = new TBounds();
            _loc3_++;
         }
         this.FDividingLinePartCaption = new Bitmap();
         this.FDividingLinePartAttribute = new Bitmap();
         this.FDividingLinePartDescCaption = new Bitmap();
         this.FDividingLinePartNimei = new Bitmap();
         addChild(this.FDividingLinePartCaption);
         addChild(this.FDividingLinePartAttribute);
         addChild(this.FDividingLinePartDescCaption);
         addChild(this.FDividingLinePartNimei);
         this.FBoundsPartCaption = new TBounds();
         this.FBoundsPartAttribute = new TBounds();
         this.FBoundsPartDescCaption = new TBounds();
         this.FBoundsPartDescCaption_nimei = new TBounds();
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
         this.FDividingLinePartNimei.bitmapData = FDividingLine;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is TEquipment;
      }
      
      override protected function ContextModified() : Boolean
      {
         var _loc1_:TEquipment = FContext as TEquipment;
         return FContextIdentifier0 != _loc1_.Identifier0 || FContextIdentifier1 != _loc1_.Identifier1 || FContextIDTemplate != _loc1_.IDTemplate || this.FContextUpgradingLevel != _loc1_.UpgradingLevel || FContextTimingTime != _loc1_.TimingTime;
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
         this.FDividingLinePartNimei.width = SIZE_DividingLine_Min_Width;
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
         this.EvaluationPerform_Nimei0(_loc1_);
         FBoundsOffset = this.FBoundsNimei0;
         this.EvaluationPerform_NimeiVector(_loc1_);
         this.EvaluationPerform_Nimei(null);
         FBoundsOffset = this.FBoundsPartDescCaption_nimei;
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
         this.FPainterAppendAttributeCaption.Text = TUtilityString.Format(FORMAT_AppendAttributeCaption2,_loc2_);
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
         this.FBoundsPartDescCaption.Width = this.FDividingLinePartDescCaption.width;
         this.FBoundsPartDescCaption.Height = this.FDividingLinePartDescCaption.height;
         BoundsAlignDown(this.FBoundsPartDescCaption,FBoundsOffset,SIZE_Padding_02);
         BoundsContextUnion(this.FBoundsPartDescCaption);
      }
      
      protected function EvaluationPerform_Nimei0(param1:TEquipment) : void
      {
         BoundsAlignDown(this.FBoundsNimei0,FBoundsOffset,SIZE_Padding_01);
         this.FPainterNimei0.Text = STRING_LOSTSHENQI.str15;
         this.FPainterNimei0.Evaluate(this.FBoundsNimei0);
         BoundsContextUnion(this.FBoundsNimei0);
      }
      
      protected function EvaluationPerform_NimeiVector(param1:TEquipment) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TLostsacredUpgrade = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:Object = null;
         var _loc10_:String = null;
         var _loc11_:uint = 0;
         var _loc12_:String = null;
         var _loc13_:Boolean = false;
         _loc3_ = param1.IDTemplate.toString() + 0;
         _loc5_ = uint(_loc3_);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_LostsacredUpgrade,_loc5_) as TLostsacredUpgrade;
         if(_loc4_.AddextraValueArray)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc4_.AddextraValueArray.length)
            {
               BoundsAlignDown(this.FBoundsNimei[_loc2_],FBoundsOffset,SIZE_Padding_01);
               _loc7_ = _loc4_.AddextraValueArray[_loc2_];
               _loc9_ = _loc7_[1];
               _loc8_ = String(_loc9_.typeEffect).split("_");
               _loc6_ = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc8_[0]);
               _loc10_ = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc6_];
               if(param1.UpgradingLevel >= _loc7_[0])
               {
                  _loc12_ = STRING_LOSTSHENQI.str4;
                  _loc13_ = true;
               }
               else
               {
                  _loc12_ = STRING_LOSTSHENQI.str5;
                  _loc13_ = false;
               }
               if(_loc8_[3] == 1)
               {
                  _loc3_ = TUtilityString.Format(STRING_LOSTSHENQI.str3,_loc7_[0],_loc10_,this.ChangeToRateString(_loc8_[1],_loc8_[2]),_loc12_);
               }
               else
               {
                  _loc3_ = TUtilityString.Format(STRING_LOSTSHENQI.str3,_loc7_[0],_loc10_,_loc8_[1],_loc12_);
               }
               this.FPainterNimeiVector[_loc2_].Text = _loc3_;
               if(_loc13_)
               {
                  this.FPainterNimeiVector[_loc2_].Font.Color = COLOR_Context_03;
               }
               else
               {
                  this.FPainterNimeiVector[_loc2_].Font.Color = COLOR_Context_White;
               }
               this.FPainterNimeiVector[_loc2_].Evaluate(this.FBoundsNimei[_loc2_]);
               BoundsContextUnion(this.FBoundsNimei0);
               FBoundsOffset = this.FBoundsNimei[_loc2_];
               _loc2_++;
            }
         }
      }
      
      protected function ChangeToRateString(param1:uint, param2:uint) : String
      {
         if(param2 == 1000)
         {
            return param1 / 10 + "%";
         }
         return param1 + "%";
      }
      
      protected function EvaluationPerform_Nimei(param1:TEquipment) : void
      {
         var _loc2_:int = 0;
         this.FBoundsPartDescCaption_nimei.Width = this.FDividingLinePartNimei.width;
         this.FBoundsPartDescCaption_nimei.Height = this.FDividingLinePartNimei.height;
         _loc2_ = this.FPainterDescCaption.NumLines * SIZE_TextFormat_leading;
         BoundsAlignDown(this.FBoundsPartDescCaption_nimei,FBoundsOffset,SIZE_Padding_02 + _loc2_);
         BoundsContextUnion(this.FBoundsPartDescCaption_nimei);
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
         this.FPainterNimei0.X = FBoundsRendering.X + this.FBoundsNimei0.X;
         this.FPainterNimei0.Y = FBoundsRendering.Y + this.FBoundsNimei0.Y;
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            this.FPainterNimeiVector[_loc2_].X = FBoundsRendering.X + this.FBoundsNimei[_loc2_].X;
            this.FPainterNimeiVector[_loc2_].Y = FBoundsRendering.Y + this.FBoundsNimei[_loc2_].Y;
            _loc2_++;
         }
         this.FDividingLinePartNimei.x = FBoundsRendering.X + this.FBoundsPartDescCaption_nimei.X - FMarginLeft + 2;
         this.FDividingLinePartNimei.y = FBoundsRendering.Y + this.FBoundsPartDescCaption_nimei.Y;
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

