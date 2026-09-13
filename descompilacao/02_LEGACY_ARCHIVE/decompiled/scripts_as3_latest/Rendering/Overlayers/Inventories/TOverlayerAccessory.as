package Rendering.Overlayers.Inventories
{
   import Components.Standard.TUIImage;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TAnimationSequence;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TBaseEquip;
   import Logics.DatebaseVO.VO.TEquipUpgrade;
   import Logics.DatebaseVO.VO.TOrnamentBuildConsume;
   import Logics.DatebaseVO.VO.TSuit;
   import Logics.Inventories.TCollectionInventory;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventory;
   import Logics.Inventories.TSuitEffect;
   import Logics.SLogicsCore;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_INVENTORY;
   import Resources.Strings.STRING_OVERLAYEREQUIPMENT;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   
   public class TOverlayerAccessory extends TOverlayerInventory
   {
      
      protected static const SIZE_Image_Width:uint = 48;
      
      protected static const SIZE_Image_Height:uint = 48;
      
      protected static const CAPACITY_SuitEffects:uint = 2;
      
      protected static const SIZE_DividingLine_Max_Width:uint = 280;
      
      protected static const SIZE_DividingLine_Min_Width:uint = 270;
      
      protected static const SIZE_DefaultIcon_Width:uint = 36;
      
      protected static const SIZE_DefaultIcon_Height:uint = 36;
      
      protected static const FORMAT_RequirementLevel:String = STRING_OVERLAYEREQUIPMENT.FORMAT_RequirementLevel;
      
      protected static const FORMAT_RequirementLevelCopy:String = STRING_OVERLAYEREQUIPMENT.FORMAT_RequirementLevelCopy;
      
      protected static const FORMAT_RequirementLevelCopyCrazy:String = STRING_OVERLAYEREQUIPMENT.FORMAT_RequirementLevelCopyCrazy;
      
      protected static const STRINGS_AccessoryType:Vector.<String> = STRING_INVENTORY.STRINGS_AccessoryType;
      
      protected static const FORMAT_AccessoryType:String = STRING_OVERLAYEREQUIPMENT.FORMAT_AccessoryType;
      
      protected static const FORMAT_BasisProperty_01:String = STRING_OVERLAYEREQUIPMENT.FORMAT_BasisProperty_01;
      
      protected static const FORMAT_BasisProperty_02:String = STRING_OVERLAYEREQUIPMENT.FORMAT_BasisProperty_02;
      
      protected static const BASEATTRIBUTENAMES:Vector.<uint> = CONST_COMMON.BASEATTRIBUTENAMES;
      
      protected static const STRINGS_BASEATTRIBUTENAMES:Vector.<String> = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES;
      
      protected static const FORMAT_SuitCaption:String = STRING_OVERLAYEREQUIPMENT.FORMAT_SuitCaption;
      
      protected static const FORMAT_Suit_01:String = STRING_OVERLAYEREQUIPMENT.FORMAT_Suit_01;
      
      protected static const FORMAT_UpgradingLevel:String = STRING_OVERLAYEREQUIPMENT.FORMAT_UpgradingLevel;
      
      public static const Ninja_Two_Reincarnation_Footstone:int = CONST_COMMON.Ninja_Two_Reincarnation_Footstone;
      
      public static const Ninja_Three_Reincarnation_Footstone:int = CONST_COMMON.Ninja_Three_Reincarnation_Footstone;
      
      public static const Ninja_One_Reincarnation_Footstone:int = CONST_COMMON.Ninja_One_Reincarnation_Footstone;
      
      public static const Ninja_Reincarnation_Logic_:int = CONST_COMMON.Ninja_Reincarnation_Logic_;
      
      protected var FPainterRequirementLevel:TPainterTextEffect;
      
      protected var FPainterUpgradingLevel:TPainterTextEffect;
      
      protected var FPainterCategorySecond:TPainterTextEffect;
      
      protected var FPainterBasisProperty:TPainterTextEffect;
      
      protected var FPainterSuitCaption:TPainterTextEffect;
      
      protected var FPainterSuitAttributes:Vector.<TPainterTextEffect>;
      
      protected var FPainterSuitEffect:TPainterTextEffect;
      
      protected var FPainterEightSuitEffect:TPainterTextEffect;
      
      protected var FBoundsRequirementLevel:TBounds;
      
      protected var FBoundsCategorySecond:TBounds;
      
      protected var FBoundsBasisProperty:TBounds;
      
      protected var FBoundsEffectProperty:TBounds;
      
      protected var FBoundsEightSuitProperty:TBounds;
      
      protected var FBoundsSuitCaption:TBounds;
      
      protected var FBoundsSuitAttributes:Vector.<TBounds>;
      
      protected var FBoundsPartCaption:TBounds;
      
      protected var FBoundsPartAttribute:TBounds;
      
      protected var FDividingLinePartCaption:Bitmap;
      
      protected var FDividingLinePartAttribute:Bitmap;
      
      protected var FBoundsUpgradingLevel:TBounds;
      
      protected var FTextFormatRequirementLevel:TextFormat;
      
      protected var FTextFormatCategorySecond:TextFormat;
      
      protected var FTextFormatRequirementCareer:TextFormat;
      
      protected var FTextFormatBasisProperty:TextFormat;
      
      protected var FTextFormatWeaponSkillCaption:TextFormat;
      
      public var IsMeOrOthers:int = 1;
      
      public var AccessoryMounted:TCollectionInventory;
      
      public function TOverlayerAccessory(param1:TUIComponent, param2:uint)
      {
         var _loc3_:int = 0;
         var _loc4_:TBounds = null;
         var _loc5_:TPainterTextEffect = null;
         super(param1,param2);
         FImage = new TUIImage(this);
         FImage.mouseEnabled = false;
         FBoundsImage = new TBounds();
         this.FPainterRequirementLevel = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsRequirementLevel = new TBounds();
         this.FPainterCategorySecond = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsCategorySecond = new TBounds();
         this.FPainterBasisProperty = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsBasisProperty = new TBounds();
         this.FPainterSuitCaption = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsSuitCaption = new TBounds();
         this.FPainterSuitAttributes = new Vector.<TPainterTextEffect>(CAPACITY_SuitEffects);
         this.FBoundsSuitAttributes = new Vector.<TBounds>(CAPACITY_SuitEffects);
         _loc3_ = 0;
         while(_loc3_ < CAPACITY_SuitEffects)
         {
            _loc5_ = ConstructPainterTextEffect(COLOR_Context_01);
            this.FPainterSuitAttributes[_loc3_] = _loc5_;
            _loc4_ = new TBounds();
            this.FBoundsSuitAttributes[_loc3_] = _loc4_;
            _loc3_++;
         }
         this.FPainterUpgradingLevel = ConstructPainterTextEffect(COLOR_Context_01);
         this.FPainterUpgradingLevel.Font.Bold = true;
         this.FPainterSuitEffect = ConstructPainterTextEffect(COLOR_Context_White);
         this.FPainterEightSuitEffect = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsEffectProperty = new TBounds();
         this.FBoundsPartCaption = new TBounds();
         this.FBoundsPartAttribute = new TBounds();
         this.FDividingLinePartCaption = new Bitmap();
         this.FDividingLinePartAttribute = new Bitmap();
         this.FBoundsUpgradingLevel = new TBounds();
         this.FBoundsEightSuitProperty = new TBounds();
         addChild(this.FDividingLinePartCaption);
         addChild(this.FDividingLinePartAttribute);
         this.FTextFormatRequirementLevel = new TextFormat();
         this.FTextFormatCategorySecond = new TextFormat();
         this.FTextFormatRequirementCareer = new TextFormat();
         this.FTextFormatBasisProperty = new TextFormat();
         this.FTextFormatWeaponSkillCaption = new TextFormat();
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
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is TEquipment;
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
      
      override protected function UpdatingPeform(param1:TCoordinate) : void
      {
         this.ContextSynchronize();
         EvaluationPerform(param1);
         SketchingPerform();
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
         FBoundsOffset = FBoundsCaption;
         this.EvaluationPerform_RequirementLevel(_loc3_);
         FBoundsOffset = this.FBoundsRequirementLevel;
         this.EvaluationPerform_CategorySecond(_loc3_);
         FBoundsOffset = this.FBoundsCategorySecond;
         this.EvaluationPerform_PartCaption(null);
         FBoundsOffset = this.FBoundsPartCaption;
         this.EvaluationPerform_BasisProperty(_loc3_);
         FBoundsOffset = this.FBoundsBasisProperty;
         this.EvaluationPerform_PartAttribute(null);
         FBoundsOffset = this.FBoundsPartAttribute;
         if(_loc3_.SuitData.MaxCount != 0)
         {
            this.EvaluationPerform_SuitCaption(_loc3_);
            FBoundsOffset = this.FBoundsSuitCaption;
            this.EvaluationPerform_SuitAttributes(_loc3_);
         }
         this.EvaluationPerform_SuitEffecTt(_loc3_);
         FBoundsOffset = this.FBoundsEffectProperty;
         this.EvaluationPerform_EightSuitEffecTt(_loc3_);
         FBoundsOffset = this.FBoundsEightSuitProperty;
         EvaluationPerform_SalePrice(_loc3_);
         FBoundsOffset = FBoundsSalePrice;
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
      
      protected function EvaluationPerform_RequirementLevel(param1:TEquipment) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         BoundsAlignDown(this.FBoundsRequirementLevel,FBoundsOffset,SIZE_Padding_02);
         if(param1.RequirementLevel <= Ninja_Reincarnation_Logic_)
         {
            _loc2_ = FORMAT_RequirementLevel.length - "%0".length;
            this.FPainterRequirementLevel.Text = TUtilityString.Format(FORMAT_RequirementLevel,param1.RequirementLevel);
         }
         else if(param1.RequirementLevel > Ninja_One_Reincarnation_Footstone)
         {
            _loc2_ = FORMAT_RequirementLevel.length - "%0".length;
            this.FPainterRequirementLevel.Text = TUtilityString.Format(FORMAT_RequirementLevel,STRING_COMMON.GetLevelStrByLevelLineFeed(param1.RequirementLevel));
         }
         else
         {
            _loc2_ = FORMAT_RequirementLevelCopy.length - FORMAT_RequirementLevelCopyCrazy.length;
            if(param1.RequirementLevel - Ninja_Reincarnation_Logic_ > 100)
            {
               _loc3_ = Ninja_Three_Reincarnation_Footstone;
            }
            else if(param1.RequirementLevel - Ninja_Reincarnation_Logic_ > 50)
            {
               _loc3_ = Ninja_Two_Reincarnation_Footstone;
            }
            else
            {
               _loc3_ = Ninja_One_Reincarnation_Footstone;
            }
            this.FPainterRequirementLevel.Text = TUtilityString.Format(FORMAT_RequirementLevelCopy,param1.RequirementLevel,SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevel(_loc3_ + param1.RequirementLevel - Ninja_Reincarnation_Logic_));
         }
         this.FTextFormatRequirementLevel.size = this.FPainterRequirementLevel.Font.Size;
         this.FTextFormatRequirementLevel.color = COLOR_Context_White;
         this.FBoundsRequirementLevel.Y -= 3;
         this.FPainterRequirementLevel.Evaluate(this.FBoundsRequirementLevel);
         this.FPainterRequirementLevel.SetTextFormat(this.FTextFormatRequirementLevel,0,_loc2_);
         BoundsContextUnion(this.FBoundsRequirementLevel);
      }
      
      protected function EvaluationPerform_CategorySecond(param1:TInventory) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         BoundsAlignDown(this.FBoundsCategorySecond,FBoundsOffset);
         _loc3_ = STRINGS_AccessoryType[param1.CategorySecond - 11];
         _loc2_ = FORMAT_AccessoryType.length - "%0".length;
         this.FPainterCategorySecond.Text = TUtilityString.Format(FORMAT_AccessoryType,_loc3_);
         this.FTextFormatCategorySecond.size = this.FPainterCategorySecond.Font.Size;
         this.FTextFormatCategorySecond.color = COLOR_Context_White;
         --this.FBoundsCategorySecond.Y;
         this.FPainterCategorySecond.Evaluate(this.FBoundsCategorySecond);
         this.FPainterCategorySecond.SetTextFormat(this.FTextFormatCategorySecond,0,_loc2_);
         BoundsContextUnion(this.FBoundsCategorySecond);
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
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:TOrnamentBuildConsume = null;
         var _loc8_:TBins = null;
         _loc8_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_OrnamentBuildConsume) as TBins;
         BoundsAlignDown(this.FBoundsBasisProperty,FBoundsOffset,SIZE_Padding_02);
         _loc2_ = BASEATTRIBUTENAMES.indexOf(param1.BasisPropertyCategory);
         _loc4_ = STRINGS_BASEATTRIBUTENAMES[_loc2_];
         _loc5_ = param1.BasisProperty.toString();
         _loc6_ = param1.UpgradingBasisProperty.toString();
         _loc3_ = _loc4_.length + 1;
         if(param1.UpgradingBasisProperty != 0)
         {
            this.FPainterBasisProperty.Text = TUtilityString.Format(FORMAT_BasisProperty_01,_loc4_,_loc5_,_loc6_);
         }
         else
         {
            this.FPainterBasisProperty.Text = TUtilityString.Format(FORMAT_BasisProperty_02,_loc4_,_loc5_);
         }
         if(param1.UpgradingLevel > 0)
         {
            _loc7_ = _loc8_.GetDatebaseByValue2("AccessoryId",param1.IDTemplate,"AccessoryLevel",param1.UpgradingLevel) as TOrnamentBuildConsume;
            if(_loc7_ != null)
            {
               this.FPainterBasisProperty.Text = this.FPainterBasisProperty.Text + " ( +" + _loc7_.AddValue + ")";
            }
            else
            {
               this.FPainterBasisProperty.Text = this.FPainterBasisProperty.Text;
            }
         }
         this.FTextFormatBasisProperty.size = this.FPainterBasisProperty.Font.Size;
         this.FTextFormatBasisProperty.color = COLOR_Context_White;
         this.FPainterBasisProperty.Evaluate(this.FBoundsBasisProperty);
         this.FPainterBasisProperty.SetTextFormat(this.FTextFormatBasisProperty,0,_loc3_);
         BoundsContextUnion(this.FBoundsBasisProperty);
      }
      
      protected function EvaluationPerform_PartAttribute(param1:TEquipment) : void
      {
         this.FBoundsPartAttribute.Width = this.FDividingLinePartAttribute.width;
         this.FBoundsPartAttribute.Height = this.FDividingLinePartAttribute.height;
         BoundsAlignDown(this.FBoundsPartAttribute,FBoundsOffset,SIZE_Padding_02);
         this.FBoundsPartAttribute.X = 0;
         BoundsContextUnion(this.FBoundsPartAttribute);
         this.FDividingLinePartAttribute.visible = true;
      }
      
      protected function EvaluationPerform_SuitCaption(param1:TEquipment) : void
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         BoundsAlignDown(this.FBoundsSuitCaption,FBoundsOffset,SIZE_Padding_02);
         _loc2_ = param1.SuitData.Name;
         _loc3_ = param1.SuitData.MaxCount;
         this.FPainterSuitCaption.Text = TUtilityString.Format(FORMAT_SuitCaption,_loc2_,param1.SuitCount,_loc3_);
         this.FPainterSuitCaption.Evaluate(this.FBoundsSuitCaption);
         BoundsContextUnion(this.FBoundsSuitCaption);
      }
      
      protected function EvaluationPerform_SuitEffecTt(param1:TEquipment) : void
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:TSuit = null;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:uint = 0;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:TBaseEquip = null;
         var _loc14_:TEquipUpgrade = null;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         BoundsAlignDown(this.FBoundsEffectProperty,FBoundsOffset,SIZE_Padding_02);
         _loc2_ = STRING_OVERLAYEREQUIPMENT.FORMAT_AccessorySuitEffect + "\n";
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Suit,param1.SuitID) as TSuit;
         _loc13_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,param1.IDTemplate) as TBaseEquip;
         _loc14_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EquipUpgrade,param1.IDTemplate) as TEquipUpgrade;
         _loc10_ = 0;
         while(_loc10_ < _loc4_.SuitEffects[0].Category.length)
         {
            _loc5_ = BASEATTRIBUTENAMES.indexOf(_loc4_.SuitEffects[0].Category[_loc10_]);
            if(_loc4_.SuitEffects[0].Percentage[_loc10_])
            {
               _loc6_ = Number(_loc4_.SuitEffects[0].Value[_loc10_]);
               _loc6_ = _loc6_ * 100;
               _loc15_ = int(_loc6_);
               _loc8_ = String(_loc6_);
               if(_loc6_ != _loc15_)
               {
                  _loc8_ = _loc6_.toFixed(1);
               }
               _loc2_ += STRINGS_BASEATTRIBUTENAMES[_loc5_] + "+" + _loc8_ + "%" + "\n";
            }
            else
            {
               _loc7_ = uint(_loc4_.SuitEffects[0].Value[_loc10_]);
               _loc2_ += STRINGS_BASEATTRIBUTENAMES[_loc5_] + "+" + String(_loc7_) + "\n";
            }
            _loc10_++;
         }
         _loc12_ = int(_loc4_.SuitEffects[0].EffectDesc.length);
         _loc11_ = 0;
         while(_loc11_ < _loc12_)
         {
            _loc2_ += _loc4_.SuitEffects[0].EffectDesc[_loc11_];
            _loc11_++;
         }
         this.FPainterSuitEffect.Text = _loc2_;
         if(param1.SuitCount >= 2)
         {
            this.FPainterSuitEffect.Font.Color = COLOR_Context_03;
         }
         else
         {
            this.FPainterSuitEffect.Font.Color = COLOR_Context_Invalid;
         }
         if(Boolean(_loc13_) && Boolean(_loc13_.SuitIdArr.length == 1) && (Boolean(_loc14_) && Boolean(_loc14_.IsEpic == 2)) || Boolean(_loc13_) && Boolean(_loc13_.SuitIdArr.length > 1))
         {
            _loc16_ = _loc13_.SuitIdArr.indexOf(param1.SuitID);
            if(Boolean(param1.SuitObject) && param1.SuitObject[2] == _loc16_)
            {
               this.FPainterSuitEffect.Font.Color = COLOR_Context_03;
            }
            else
            {
               this.FPainterSuitEffect.Font.Color = COLOR_Context_Invalid;
            }
         }
         this.FPainterSuitEffect.Evaluate(this.FBoundsEffectProperty);
         BoundsContextUnion(this.FBoundsEffectProperty);
      }
      
      protected function EvaluationPerform_EightSuitEffecTt(param1:TEquipment) : void
      {
         var _loc2_:String = null;
         var _loc3_:TSuit = null;
         var _loc4_:TBaseEquip = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         var _loc10_:TEquipUpgrade = null;
         var _loc12_:int = 0;
         BoundsAlignDown(this.FBoundsEightSuitProperty,FBoundsOffset);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,param1.IDTemplate) as TBaseEquip;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Suit,_loc4_.EightsuitId) as TSuit;
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EquipUpgrade,param1.IDTemplate) as TEquipUpgrade;
         _loc2_ = STRING_OVERLAYEREQUIPMENT.FORMAT_AccessoryEightSuitEffect + "\n";
         _loc5_ = 0;
         while(_loc5_ < _loc3_.SuitEffects[3].Category.length)
         {
            _loc8_ = BASEATTRIBUTENAMES.indexOf(_loc3_.SuitEffects[3].Category[_loc5_]);
            if(_loc3_.SuitEffects[3].Percentage[_loc5_])
            {
               _loc7_ = Number(_loc3_.SuitEffects[3].Value[_loc5_]);
               _loc7_ = _loc7_ * 100;
               _loc12_ = int(_loc7_);
               _loc6_ = String(_loc7_);
               if(_loc7_ != _loc12_)
               {
                  _loc6_ = _loc7_.toFixed(1);
               }
               _loc2_ += STRINGS_BASEATTRIBUTENAMES[_loc8_] + "+" + _loc6_ + "%" + "\n";
            }
            else
            {
               _loc9_ = uint(_loc3_.SuitEffects[3].Value[_loc5_]);
               _loc2_ += STRINGS_BASEATTRIBUTENAMES[_loc8_] + "+" + String(_loc9_) + "\n";
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc3_.SuitEffects[3].EffectDesc.length)
         {
            _loc2_ += _loc3_.SuitEffects[3].EffectDesc[_loc5_];
            _loc5_++;
         }
         this.FPainterEightSuitEffect.Text = _loc2_;
         var _loc11_:int = _loc4_.EightsuitIdArr.indexOf(_loc4_.EightsuitId);
         if(Boolean(param1.EightSuitObject) && param1.EightSuitObject[8] == _loc11_)
         {
            this.FPainterEightSuitEffect.Font.Color = COLOR_Context_03;
         }
         else
         {
            this.FPainterEightSuitEffect.Font.Color = COLOR_Context_Invalid;
         }
         this.FPainterEightSuitEffect.Evaluate(this.FBoundsEightSuitProperty);
         BoundsContextUnion(this.FBoundsEightSuitProperty);
      }
      
      protected function EvaluationPerfrom_AccessoryMounted(param1:TCollectionInventory, param2:TEquipment) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TEquipment = null;
         var _loc6_:Boolean = true;
         var _loc7_:TBaseEquip = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,param2.IDTemplate) as TBaseEquip;
         var _loc8_:int = _loc7_.EightsuitId;
         if(param1 == null)
         {
            return false;
         }
         _loc3_ = param1.Capacity;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1.GetInventoryByIndex(_loc4_) as TEquipment;
            if(_loc5_ == null)
            {
               _loc6_ = false;
               break;
            }
            _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,_loc5_.IDTemplate) as TBaseEquip;
            if((Boolean(_loc7_)) && _loc7_.EightsuitId != _loc8_)
            {
               _loc6_ = false;
               break;
            }
            _loc4_++;
         }
         return _loc6_;
      }
      
      protected function EvaluationPerform_SuitAttributes(param1:TEquipment) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TBounds = null;
         var _loc8_:TPainterTextEffect = null;
         var _loc9_:TSuitEffect = null;
         var _loc10_:uint = 0;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:TSuit = null;
         var _loc14_:TBaseEquip = null;
         var _loc15_:int = 0;
         var _loc16_:Array = null;
         var _loc18_:TArticle = null;
         _loc16_ = null;
         var _loc17_:int = 0;
         _loc14_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,param1.IDTemplate) as TBaseEquip;
         _loc16_ = this.GetSourceTargetId(_loc14_.SuitId);
         _loc16_.sortOn("Identifier",Array.NUMERIC);
         _loc14_ = _loc16_[0] as TBaseEquip;
         _loc7_ = this.FBoundsSuitAttributes[0];
         BoundsAlignDown(_loc7_,FBoundsOffset);
         FBoundsOffset = _loc7_;
         _loc8_ = this.FPainterSuitAttributes[_loc2_];
         _loc18_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc14_.Identifier) as TArticle;
         _loc8_.Text = _loc18_.Name;
         _loc17_ = param1.SuitMemberId.indexOf(_loc14_.Identifier);
         if(_loc17_ != -1 && Boolean(this.IsMeOrOthers))
         {
            _loc8_.Font.Color = COLOR_Context_03;
         }
         else
         {
            _loc8_.Font.Color = COLOR_Context_Invalid;
         }
         _loc8_.Evaluate(_loc7_);
         BoundsContextUnion(_loc7_);
         _loc14_ = _loc16_[1] as TBaseEquip;
         _loc7_ = this.FBoundsSuitAttributes[1];
         BoundsAlignDown(_loc7_,FBoundsOffset);
         FBoundsOffset = _loc7_;
         _loc8_ = this.FPainterSuitAttributes[1];
         _loc18_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc14_.Identifier) as TArticle;
         _loc8_.Text = _loc18_.Name;
         _loc17_ = param1.SuitMemberId.indexOf(_loc14_.Identifier);
         if(_loc17_ != -1 && Boolean(this.IsMeOrOthers))
         {
            _loc8_.Font.Color = COLOR_Context_03;
         }
         else
         {
            _loc8_.Font.Color = COLOR_Context_Invalid;
         }
         _loc8_.Evaluate(_loc7_);
         BoundsContextUnion(_loc7_);
      }
      
      public function GetSourceTargetId(param1:int) : Array
      {
         var _loc2_:TBins = null;
         _loc2_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseEquip);
         return _loc2_.GetTwoDatebaseVO("SuitId",param1);
      }
      
      override protected function ContextSynchronize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TEquipment = null;
         _loc3_ = FContext as TEquipment;
         this.FDividingLinePartCaption.width = SIZE_DividingLine_Min_Width;
         this.FDividingLinePartAttribute.width = SIZE_DividingLine_Min_Width;
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
         this.FDividingLinePartCaption.x = FBoundsRendering.X + this.FBoundsPartCaption.X - FMarginLeft + SIZE_DividingLineOffset;
         this.FDividingLinePartCaption.y = FBoundsRendering.Y + this.FBoundsPartCaption.Y;
         this.FPainterBasisProperty.X = FBoundsRendering.X + this.FBoundsBasisProperty.X;
         this.FPainterBasisProperty.Y = FBoundsRendering.Y + this.FBoundsBasisProperty.Y;
         this.FDividingLinePartAttribute.x = FBoundsRendering.X + this.FBoundsPartAttribute.X - FMarginLeft + SIZE_DividingLineOffset;
         this.FDividingLinePartAttribute.y = FBoundsRendering.Y + this.FBoundsPartAttribute.Y;
         if(_loc6_.SuitData.MaxCount != 0)
         {
            this.FPainterSuitCaption.X = FBoundsRendering.X + this.FBoundsSuitCaption.X;
            this.FPainterSuitCaption.Y = FBoundsRendering.Y + this.FBoundsSuitCaption.Y;
            _loc2_ = 0;
            while(_loc2_ < CAPACITY_SuitEffects)
            {
               _loc5_ = this.FPainterSuitAttributes[_loc2_];
               _loc4_ = this.FBoundsSuitAttributes[_loc2_];
               _loc5_.X = FBoundsRendering.X + _loc4_.X;
               _loc5_.Y = FBoundsRendering.Y + _loc4_.Y;
               _loc2_++;
            }
         }
         this.FPainterSuitEffect.X = FBoundsRendering.X + this.FBoundsEffectProperty.X;
         this.FPainterSuitEffect.Y = FBoundsRendering.Y + this.FBoundsEffectProperty.Y;
         this.FPainterEightSuitEffect.X = FBoundsRendering.X + this.FBoundsEightSuitProperty.X;
         this.FPainterEightSuitEffect.Y = FBoundsRendering.Y + this.FBoundsEightSuitProperty.Y;
         FPainterSalePrice.X = FBoundsRendering.X + FBoundsSalePrice.X;
         FPainterSalePrice.Y = FBoundsRendering.Y + FBoundsSalePrice.Y;
         this.FDividingLinePartCaption.width = SIZE_DividingLine_Max_Width;
         this.FDividingLinePartAttribute.width = SIZE_DividingLine_Max_Width;
      }
   }
}

