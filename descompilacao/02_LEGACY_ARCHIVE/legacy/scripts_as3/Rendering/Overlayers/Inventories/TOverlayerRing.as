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
   import Logics.SLogicsCore;
   import Rendering.Overlayers.*;
   import Rendering.Texts.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class TOverlayerRing extends TOverlayerInventory
   {
      
      protected static const SIZE_WordWrapWidth:uint = 130;
      
      protected static const CAPACITY_AppendAttributes:uint = 3;
      
      protected static const CAPACITY_GiftedStoneItems:uint = 8;
      
      protected static const CAPACITY_SuitEffects:uint = 3;
      
      protected static const SIZE_DividingLine_Max_Width:uint = 280;
      
      protected static const SIZE_DividingLine_Min_Width:uint = 270;
      
      protected static const SIZE_Image_Width:uint = 48;
      
      protected static const SIZE_Image_Height:uint = 48;
      
      protected static const SIZE_DefaultIcon_Width:uint = 36;
      
      protected static const SIZE_DefaultIcon_Height:uint = 36;
      
      protected static const SIZE_TextFormat_leading:uint = 4;
      
      protected static const SIZE_Padding_01:uint = 1;
      
      protected static const SIZE_Padding_02:uint = 3;
      
      protected static const SIZE_Padding_03:uint = 10;
      
      protected static const SIZE_Context_00:uint = 15;
      
      protected static const STRINGS_EquipmensCaption:Vector.<String> = STRING_INVENTORY.STRINGS_EquipmensCaption;
      
      protected static const TYPE_PROFESSIONS:Vector.<String> = STRING_COMMON.TYPE_PROFESSIONS;
      
      protected static const BASEATTRIBUTENAMES:Vector.<uint> = CONST_COMMON.BASEATTRIBUTENAMES;
      
      protected static const STRINGS_BASEATTRIBUTENAMES:Vector.<String> = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES;
      
      protected static const BASEATTRIBUTENAME_HitRate:uint = CONST_COMMON.BASEATTRIBUTENAME_HitRate;
      
      protected static const BASEATTRIBUTENAME_DodgeRate:uint = CONST_COMMON.BASEATTRIBUTENAME_DodgeRate;
      
      protected static const BASEATTRIBUTENAME_CritRate:uint = CONST_COMMON.BASEATTRIBUTENAME_CritRate;
      
      protected static const BASEATTRIBUTENAME_BlockRate:uint = CONST_COMMON.BASEATTRIBUTENAME_BlockRate;
      
      protected static const FORMAT_UpgradingLevel:String = STRING_OVERLAYEREQUIPMENT.FORMAT_UpgradingLevel;
      
      protected static const FORMAT_RequirementLevel:String = STRING_OVERLAYEREQUIPMENT.FORMAT_RequirementLevel;
      
      protected static const FORMAT_RequirementLevelCopy:String = STRING_OVERLAYEREQUIPMENT.FORMAT_RequirementLevelCopy;
      
      protected static const FORMAT_RequirementLevelCopyCrazy:String = STRING_OVERLAYEREQUIPMENT.FORMAT_RequirementLevelCopyCrazy;
      
      protected static const FORMAT_CategorySecond:String = STRING_OVERLAYEREQUIPMENT.FORMAT_CategorySecond;
      
      protected static const FORMAT_RequirementCareer:String = STRING_OVERLAYEREQUIPMENT.FORMAT_RequirementCareer;
      
      protected static const FORMAT_BasisProperty_01:String = STRING_OVERLAYEREQUIPMENT.FORMAT_BasisProperty_01;
      
      protected static const FORMAT_BasisProperty_02:String = STRING_OVERLAYEREQUIPMENT.FORMAT_BasisProperty_02;
      
      protected static const FORMAT_AppendAttributeCaption:String = STRING_OVERLAYEREQUIPMENT.FORMAT_AppendAttributeCaption;
      
      protected static const FORMAT_AppendAttributes:String = STRING_OVERLAYEREQUIPMENT.FORMAT_AppendAttributes;
      
      protected static const FORMAT_AppendAttributesPercentage:String = STRING_OVERLAYEREQUIPMENT.FORMAT_AppendAttributesPercentage;
      
      protected static const FORMAT_AppendAttributesUnknown:String = STRING_OVERLAYEREQUIPMENT.FORMAT_AppendAttributesUnknown;
      
      protected static const FORMAT_WeaponSkillCaption:String = STRING_OVERLAYEREQUIPMENT.FORMAT_WeaponSkillCaption;
      
      protected static const FORMAT_GiftedStoneItemCaption:String = STRING_OVERLAYEREQUIPMENT.FORMAT_GiftedStoneItemCaption;
      
      protected static const FORMAT_GiftedStoneItems:String = STRING_OVERLAYEREQUIPMENT.FORMAT_GiftedStoneItems;
      
      protected static const FORMAT_GiftedStoneItemNull:String = STRING_OVERLAYEREQUIPMENT.FORMAT_GiftedStoneItemNull;
      
      protected static const FORMAT_SuitCaption:String = STRING_OVERLAYEREQUIPMENT.FORMAT_SuitCaption;
      
      protected static const FORMAT_Suit_01:String = STRING_OVERLAYEREQUIPMENT.FORMAT_Suit_01;
      
      protected static const FORMAT_ExpendHole_01:String = STRING_OVERLAYEREQUIPMENT.FORMAT_ExpendHole_01;
      
      protected static const FORMAT_EnchantLevel:String = STRING_OVERLAYEREQUIPMENT.FORMAT_EnchantLevel;
      
      protected static const FORMAT_Enchant:String = STRING_OVERLAYEREQUIPMENT.FORMAT_Enchant;
      
      public static const Ninja_Two_Reincarnation_Footstone:int = CONST_COMMON.Ninja_Two_Reincarnation_Footstone;
      
      public static const Ninja_Three_Reincarnation_Footstone:int = CONST_COMMON.Ninja_Three_Reincarnation_Footstone;
      
      public static const Ninja_One_Reincarnation_Footstone:int = CONST_COMMON.Ninja_One_Reincarnation_Footstone;
      
      public static const Ninja_Reincarnation_Logic_:int = CONST_COMMON.Ninja_Reincarnation_Logic_;
      
      protected var FPainterUpgradingLevel:TPainterTextEffect;
      
      protected var FPainterRequirementLevel:TPainterTextEffect;
      
      protected var FPainterCategorySecond:TPainterTextEffect;
      
      protected var FPainterRequirementCareer:TPainterTextEffect;
      
      protected var FPainterEnchantLevel:TPainterTextEffect;
      
      protected var FPainterEnchantProperty:TPainterTextEffect;
      
      protected var FPainterBasisProperty:TPainterTextEffect;
      
      protected var FPainterAppendAttributeCaption:TPainterTextEffect;
      
      protected var FPainterAppendAttributes:Vector.<TPainterTextEffect>;
      
      protected var FPainterWeaponSkillCaption:TPainterTextEffect;
      
      protected var FPainterGiftedStoneItemCaption:TPainterTextEffect;
      
      protected var FPainterGiftedStoneItems:Vector.<TPainterTextEffect>;
      
      protected var FPainterSuitCaption:TPainterTextEffect;
      
      protected var FPainterSuitAttributes:Vector.<TPainterTextEffect>;
      
      protected var FPainterExpandHole:TPainterTextEffect;
      
      protected var FBoundsUpgradingLevel:TBounds;
      
      protected var FBoundsRequirementLevel:TBounds;
      
      protected var FBoundsCategorySecond:TBounds;
      
      protected var FBoundsRequirementCareer:TBounds;
      
      protected var FBoundsEnchantLevel:TBounds;
      
      protected var FBoundsEnchantProperty:TBounds;
      
      protected var FBoundsBasisProperty:TBounds;
      
      protected var FBoundsAppendAttributeCaption:TBounds;
      
      protected var FBoundsAppendAttributes:Vector.<TBounds>;
      
      protected var FBoundsWeaponSkillCaption:TBounds;
      
      protected var FBoundsGiftedStoneItemCaption:TBounds;
      
      protected var FBoundsGiftedStoneItems:Vector.<TBounds>;
      
      protected var FBoundsSuitCaption:TBounds;
      
      protected var FBoundsSuitAttributes:Vector.<TBounds>;
      
      protected var FBoundsExpandHole:TBounds;
      
      protected var FBoundsPartCaption:TBounds;
      
      protected var FBoundsPartAttribute:TBounds;
      
      protected var FBoundsPartGiftedStone:TBounds;
      
      protected var FTextFormatRequirementLevel:TextFormat;
      
      protected var FTextFormatCategorySecond:TextFormat;
      
      protected var FTextFormatRequirementCareer:TextFormat;
      
      protected var FTextFormatBasisProperty:TextFormat;
      
      protected var FTextFormatWeaponSkillCaption:TextFormat;
      
      protected var FContextUpgradingLevel:uint;
      
      protected var FContextGiftedStoneCount:uint;
      
      protected var FContextGiftedStoneIDTemplate:Vector.<uint>;
      
      protected var FContextWeaponSkillID:uint;
      
      protected var FContextSuitCount:uint;
      
      public function TOverlayerRing(param1:TUIComponent, param2:uint)
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
         this.FPainterRequirementLevel = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsRequirementLevel = new TBounds();
         this.FPainterCategorySecond = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsCategorySecond = new TBounds();
         this.FPainterRequirementCareer = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsRequirementCareer = new TBounds();
         this.FPainterBasisProperty = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsEnchantLevel = new TBounds();
         this.FPainterEnchantLevel = ConstructPainterTextEffect(COLOR_Context_Blue);
         this.FBoundsEnchantProperty = new TBounds();
         this.FPainterEnchantProperty = ConstructPainterTextEffect(COLOR_Context_Blue);
         this.FBoundsBasisProperty = new TBounds();
         this.FPainterAppendAttributeCaption = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsAppendAttributeCaption = new TBounds();
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
         this.FPainterWeaponSkillCaption = ConstructPainterTextEffect(COLOR_Context_01);
         this.FPainterWeaponSkillCaption.WordWrapWidth = SIZE_WordWrapWidth;
         this.FBoundsWeaponSkillCaption = new TBounds();
         this.FPainterGiftedStoneItemCaption = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsGiftedStoneItemCaption = new TBounds();
         this.FPainterGiftedStoneItems = new Vector.<TPainterTextEffect>(CAPACITY_GiftedStoneItems / 2);
         this.FBoundsGiftedStoneItems = new Vector.<TBounds>(CAPACITY_GiftedStoneItems / 2);
         _loc3_ = 0;
         while(_loc3_ < CAPACITY_GiftedStoneItems / 2)
         {
            _loc5_ = ConstructPainterTextEffect(COLOR_Context_01);
            this.FPainterGiftedStoneItems[_loc3_] = _loc5_;
            _loc4_ = new TBounds();
            this.FBoundsGiftedStoneItems[_loc3_] = _loc4_;
            _loc3_++;
         }
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
         this.FPainterExpandHole = ConstructPainterTextEffect(COLOR_Context_04);
         this.FBoundsExpandHole = new TBounds();
         FPainterTimingTime = ConstructPainterTextEffect(COLOR_Context_White);
         FBoundsTimingTime = new TBounds();
         addChild(FDividingLinePartTimingTime);
         this.FBoundsPartCaption = new TBounds();
         this.FBoundsPartAttribute = new TBounds();
         this.FBoundsPartGiftedStone = new TBounds();
         this.FTextFormatRequirementLevel = new TextFormat();
         this.FTextFormatCategorySecond = new TextFormat();
         this.FTextFormatRequirementCareer = new TextFormat();
         this.FTextFormatBasisProperty = new TextFormat();
         this.FTextFormatWeaponSkillCaption = new TextFormat();
         FTextFormatSalePrice = new TextFormat();
         FTextFormatCaptionA = new TextFormat();
         FTextFormatCaptionB = new TextFormat();
         this.FContextGiftedStoneIDTemplate = new Vector.<uint>(CAPACITY_GiftedStoneItems);
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
         _loc3_ = FContextIdentifier0 != _loc5_.Identifier0 || FContextIdentifier1 != _loc5_.Identifier1 || FContextIDTemplate != _loc5_.IDTemplate || this.FContextUpgradingLevel != _loc5_.UpgradingLevel || this.FContextWeaponSkillID != _loc5_.WeaponSkillID || this.FContextGiftedStoneCount != _loc5_.GiftedStoneItems.Count || this.FContextSuitCount != _loc5_.SuitCount || FContextTimingTime != _loc5_.TimingTime;
         if(!_loc3_)
         {
            _loc2_ = int(this.FContextGiftedStoneCount);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc4_ = _loc5_.GiftedStoneItems.GetGiftedStoneByIndex(_loc1_);
               if(_loc4_.IDTemplate != this.FContextGiftedStoneIDTemplate[_loc1_])
               {
                  _loc3_ = true;
                  break;
               }
               _loc1_++;
            }
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
         this.FContextGiftedStoneCount = _loc3_.GiftedStoneItems.Count;
         this.FContextSuitCount = _loc3_.SuitCount;
         FContextTimingTime = _loc3_.TimingTime;
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
         FBoundsOffset = FBoundsCaption;
         this.EvaluationPerform_RequirementLevel(_loc3_);
         FBoundsOffset = this.FBoundsRequirementLevel;
         this.EvaluationPerform_CategorySecond(_loc3_);
         FBoundsOffset = this.FBoundsCategorySecond;
         if(this.EvaluationPerform_EnchantLevel(_loc3_))
         {
            FBoundsOffset = this.FBoundsEnchantLevel;
         }
         if(this.EvaluationPerform_EnchantProperty(_loc3_))
         {
            FBoundsOffset = this.FBoundsEnchantProperty;
         }
         if(_loc3_.MaxAdditionalCount != 0)
         {
            this.FPainterAppendAttributeCaption.Visible = true;
            this.EvaluationPerform_AppendAttributeCaption(_loc3_);
            FBoundsOffset = this.FBoundsAppendAttributeCaption;
            this.EvaluationPerform_AppendAttributes(_loc3_);
            _loc2_ = int(_loc3_.MaxAdditionalCount);
            _loc1_ = 0;
            while(_loc1_ < CAPACITY_AppendAttributes)
            {
               _loc4_ = this.FPainterAppendAttributes[_loc1_];
               if(_loc1_ < _loc2_)
               {
                  _loc4_.Visible = true;
               }
               else
               {
                  _loc4_.Visible = false;
               }
               _loc1_++;
            }
         }
         else
         {
            this.FPainterAppendAttributeCaption.Visible = false;
            _loc2_ = int(CAPACITY_AppendAttributes);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc4_ = this.FPainterAppendAttributes[_loc1_];
               _loc4_.Visible = false;
               _loc1_++;
            }
         }
         if(_loc3_.WeaponSkillID > 0)
         {
            this.EvaluationPerform_WeaponSkillCaption(_loc3_);
            FBoundsOffset = this.FBoundsWeaponSkillCaption;
            this.FPainterWeaponSkillCaption.Visible = true;
         }
         else
         {
            this.FPainterWeaponSkillCaption.Visible = false;
         }
         if(_loc3_.HoleCount != 0)
         {
            this.EvaluationPerform_GiftedStoneItemCaption(_loc3_);
            FBoundsOffset = this.FBoundsGiftedStoneItemCaption;
            this.EvaluationPerform_GiftedStoneItems(_loc3_);
            this.FPainterGiftedStoneItemCaption.Visible = true;
            _loc2_ = _loc3_.HoleCount + _loc3_.ExpandHoleCount;
            _loc1_ = 0;
            while(_loc1_ < CAPACITY_GiftedStoneItems)
            {
               _loc4_ = this.FPainterGiftedStoneItems[_loc1_ / 2];
               if(_loc1_ < _loc2_)
               {
                  _loc4_.Visible = true;
               }
               else
               {
                  _loc4_.Visible = false;
               }
               _loc1_++;
               _loc1_++;
            }
         }
         else
         {
            this.FPainterGiftedStoneItemCaption.Visible = false;
            _loc2_ = int(this.FPainterGiftedStoneItems.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc4_ = this.FPainterGiftedStoneItems[_loc1_];
               _loc4_.Visible = false;
               _loc1_++;
            }
         }
         if(_loc3_.DigHoleNum != 0)
         {
            this.EvaluationPerform_ExpandHole(_loc3_);
            this.FPainterExpandHole.visible = true;
         }
         else
         {
            this.FPainterExpandHole.visible = false;
         }
         if(_loc3_.SuitData.MaxCount != 0)
         {
            this.EvaluationPerform_SuitCaption(_loc3_);
            FBoundsOffset = this.FBoundsSuitCaption;
            this.EvaluationPerform_SuitAttributes(_loc3_);
            this.FPainterSuitCaption.Visible = true;
            _loc1_ = 0;
            while(_loc1_ < CAPACITY_SuitEffects)
            {
               _loc4_ = this.FPainterSuitAttributes[_loc1_];
               _loc4_.Visible = true;
               _loc1_++;
            }
         }
         else
         {
            this.FPainterSuitCaption.Visible = false;
            _loc2_ = int(CAPACITY_SuitEffects);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc4_ = this.FPainterSuitAttributes[_loc1_];
               _loc4_.Visible = false;
               _loc1_++;
            }
         }
         if(_loc3_.TimingTime > 0)
         {
            FPainterTimingTime.Visible = true;
            FDividingLinePartTimingTime.visible = true;
            EvaluationPerform_PartTimingTime(null);
            FBoundsOffset = FBoundsPartTimingTime;
            EvaluationPerform_TimingTime(_loc3_);
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
      
      protected function EvaluationPerform_CategorySecond(param1:TEquipment) : void
      {
         BoundsAlignDown(this.FBoundsCategorySecond,FBoundsOffset);
         var _loc2_:String = STRINGS_EquipmensCaption[param1.CategorySecond - 1];
         var _loc3_:int = FORMAT_CategorySecond.length - "%0".length;
         this.FPainterCategorySecond.Text = TUtilityString.Format(FORMAT_CategorySecond,_loc2_ + "         ");
         this.FTextFormatCategorySecond.size = this.FPainterCategorySecond.Font.Size;
         this.FTextFormatCategorySecond.color = COLOR_Context_White;
         --this.FBoundsCategorySecond.Y;
         this.FPainterCategorySecond.Evaluate(this.FBoundsCategorySecond);
         this.FPainterCategorySecond.SetTextFormat(this.FTextFormatCategorySecond,0,_loc3_);
         BoundsContextUnion(this.FBoundsCategorySecond);
      }
      
      protected function EvaluationPerform_RequirementCareer(param1:TEquipment) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:Vector.<uint> = null;
         var _loc7_:uint = 0;
         BoundsAlignDown(this.FBoundsRequirementCareer,FBoundsOffset);
         _loc6_ = param1.RequirementCareer;
         _loc3_ = int(_loc6_.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc7_ = _loc6_[_loc2_];
            if(_loc7_ >= TYPE_PROFESSIONS.length)
            {
               _loc5_ = "";
            }
            else
            {
               _loc5_ = TYPE_PROFESSIONS[_loc7_] + "  ";
            }
            _loc2_++;
         }
         _loc4_ = FORMAT_RequirementCareer.length - "%0".length;
         this.FPainterRequirementCareer.Text = TUtilityString.Format(FORMAT_RequirementCareer,_loc5_);
         this.FTextFormatRequirementCareer.size = this.FPainterRequirementCareer.Font.Size;
         this.FTextFormatRequirementCareer.color = COLOR_Context_White;
         --this.FBoundsRequirementCareer.Y;
         this.FPainterRequirementCareer.Evaluate(this.FBoundsRequirementCareer);
         this.FPainterRequirementCareer.SetTextFormat(this.FTextFormatRequirementCareer,0,_loc4_);
         BoundsContextUnion(this.FBoundsRequirementCareer);
      }
      
      protected function EvaluationPerform_EnchantLevel(param1:TEquipment) : Boolean
      {
         if(param1.EnchantCoefficient > 0)
         {
            BoundsAlignDown(this.FBoundsEnchantLevel,FBoundsOffset,SIZE_Padding_02);
            this.FPainterEnchantLevel.Text = TUtilityString.Format(FORMAT_EnchantLevel,param1.EnchantLevel);
            this.FPainterEnchantLevel.Evaluate(this.FBoundsEnchantLevel);
            this.FPainterEnchantLevel.Visible = true;
            return true;
         }
         this.FPainterEnchantLevel.Visible = false;
         return false;
      }
      
      protected function EvaluationPerform_EnchantProperty(param1:TEquipment) : Boolean
      {
         if(param1.EnchantCoefficient > 0)
         {
            BoundsAlignDown(this.FBoundsEnchantProperty,FBoundsOffset,SIZE_Padding_02);
            this.FPainterEnchantProperty.Text = TUtilityString.Format(FORMAT_Enchant,param1.EnchantValue);
            this.FPainterEnchantProperty.Evaluate(this.FBoundsEnchantProperty);
            this.FPainterEnchantProperty.Visible = true;
            return true;
         }
         this.FPainterEnchantProperty.Visible = false;
         return false;
      }
      
      protected function EvaluationPerform_BasisProperty(param1:TEquipment) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
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
         this.FTextFormatBasisProperty.size = this.FPainterBasisProperty.Font.Size;
         this.FTextFormatBasisProperty.color = COLOR_Context_White;
         this.FPainterBasisProperty.Evaluate(this.FBoundsBasisProperty);
         this.FPainterBasisProperty.SetTextFormat(this.FTextFormatBasisProperty,0,_loc3_);
         BoundsContextUnion(this.FBoundsBasisProperty);
      }
      
      protected function EvaluationPerform_AppendAttributeCaption(param1:TEquipment) : void
      {
         BoundsAlignDown(this.FBoundsAppendAttributeCaption,FBoundsOffset,SIZE_Padding_01);
         this.FPainterAppendAttributeCaption.Text = FORMAT_AppendAttributeCaption;
         this.FPainterAppendAttributeCaption.Evaluate(this.FBoundsAppendAttributeCaption);
         BoundsContextUnion(this.FBoundsAppendAttributeCaption);
      }
      
      protected function EvaluationPerform_AppendAttributes(param1:TEquipment) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBounds = null;
         var _loc6_:TPainterTextEffect = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:uint = 0;
         var _loc10_:TEquipmentAppendAttribute = null;
         var _loc11_:int = 0;
         _loc3_ = int(param1.MaxAdditionalCount);
         _loc4_ = param1.AppendAttributes.Count;
         _loc2_ = 0;
         while(_loc2_ < CAPACITY_AppendAttributes)
         {
            if(_loc2_ >= _loc3_)
            {
               break;
            }
            _loc5_ = this.FBoundsAppendAttributes[_loc2_];
            if(_loc2_ == 0)
            {
               BoundsAlignRight(_loc5_,FBoundsOffset,SIZE_Padding_01);
            }
            else
            {
               BoundsAlignDown(_loc5_,FBoundsOffset);
            }
            FBoundsOffset = _loc5_;
            _loc6_ = this.FPainterAppendAttributes[_loc2_];
            if(_loc2_ < _loc4_)
            {
               _loc10_ = param1.AppendAttributes.GetAttributeByIndex(_loc2_);
               _loc9_ = _loc10_.Category;
               _loc11_ = BASEATTRIBUTENAMES.indexOf(_loc9_);
               _loc7_ = STRINGS_BASEATTRIBUTENAMES[_loc11_];
               if(_loc10_.Percentage == 1)
               {
                  _loc8_ = Number(_loc10_.Value / (_loc10_.Divisor / 100)).toFixed(1);
               }
               else
               {
                  _loc8_ = _loc10_.Value.toString();
               }
               if(_loc10_.Percentage == 1)
               {
                  _loc6_.Text = TUtilityString.Format(FORMAT_AppendAttributesPercentage,_loc7_,_loc8_);
               }
               else
               {
                  _loc6_.Text = TUtilityString.Format(FORMAT_AppendAttributes,_loc7_,_loc8_);
               }
               _loc6_.Font.Color = COLOR_Context_AppendAttributes;
               _loc6_.Evaluate(_loc5_);
               BoundsContextUnion(_loc5_);
            }
            else
            {
               _loc6_.Text = FORMAT_AppendAttributesUnknown;
               _loc6_.Font.Color = COLOR_Context_Unknown;
               _loc6_.Evaluate(_loc5_);
               BoundsContextUnion(_loc5_);
            }
            _loc2_++;
         }
      }
      
      protected function EvaluationPerform_WeaponSkillCaption(param1:TEquipment) : void
      {
         var _loc2_:int = 0;
         BoundsAlignDown(this.FBoundsWeaponSkillCaption,FBoundsOffset,SIZE_Padding_02);
         _loc2_ = FORMAT_WeaponSkillCaption.length - " %0\n%1".length;
         this.FPainterWeaponSkillCaption.Text = TUtilityString.Format(FORMAT_WeaponSkillCaption,param1.WeaponSkillName,param1.WeaponSkillDesc);
         this.FBoundsWeaponSkillCaption.X = 0;
         this.FTextFormatWeaponSkillCaption.color = COLOR_Context_White;
         this.FTextFormatWeaponSkillCaption.leading = SIZE_TextFormat_leading;
         this.FPainterWeaponSkillCaption.Evaluate(this.FBoundsWeaponSkillCaption);
         this.FPainterWeaponSkillCaption.SetTextFormat(this.FTextFormatWeaponSkillCaption,0,5);
         BoundsContextUnion(this.FBoundsWeaponSkillCaption);
      }
      
      protected function EvaluationPerform_GiftedStoneItemCaption(param1:TEquipment) : void
      {
         BoundsAlignDown(this.FBoundsGiftedStoneItemCaption,FBoundsOffset,SIZE_Padding_02);
         this.FPainterGiftedStoneItemCaption.Text = FORMAT_GiftedStoneItemCaption;
         this.FPainterGiftedStoneItemCaption.Evaluate(this.FBoundsGiftedStoneItemCaption);
         BoundsContextUnion(this.FBoundsGiftedStoneItemCaption);
      }
      
      protected function EvaluationPerform_GiftedStoneItems(param1:TEquipment) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBounds = null;
         var _loc5_:TPainterTextEffect = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc9_:TInventory = null;
         var _loc10_:TGiftedStoneItems = null;
         var _loc11_:int = 0;
         _loc10_ = param1.GiftedStoneItems;
         _loc8_ = param1.HoleCount + param1.ExpandHoleCount;
         _loc3_ = _loc10_.Count;
         _loc2_ = 0;
         while(_loc2_ < CAPACITY_GiftedStoneItems)
         {
            _loc11_ = _loc2_ / 2;
            _loc5_ = this.FPainterGiftedStoneItems[_loc11_];
            _loc5_.Font.Size = 12;
            if(_loc2_ < _loc8_ && _loc2_ < _loc3_)
            {
               _loc9_ = _loc10_.GetGiftedStoneByIndex(_loc2_);
               _loc6_ = _loc9_.Name;
               _loc7_ = _loc9_.Description;
               if(_loc2_ % 2 == 0)
               {
                  _loc5_.Text = TUtilityString.Format(STRING_OVERLAYEREQUIPMENT.FORMAT_GiftedStoneItems,_loc6_,_loc7_) + " | ";
                  _loc5_.Font.Color = COLOR_Context_03;
                  _loc4_ = this.FBoundsGiftedStoneItems[_loc11_];
                  BoundsAlignDown(_loc4_,FBoundsOffset);
                  FBoundsOffset = _loc4_;
               }
               else
               {
                  _loc5_.Text += TUtilityString.Format(STRING_OVERLAYEREQUIPMENT.FORMAT_GiftedStoneItems,_loc6_,_loc7_) + "  ";
                  _loc5_.Font.Color = COLOR_Context_03;
                  _loc5_.Evaluate(_loc4_);
                  BoundsContextUnion(_loc4_);
               }
            }
            else if(_loc2_ % 2 == 0)
            {
               _loc5_.Text = STRING_OVERLAYEREQUIPMENT.FORMAT_GiftedStoneItemNull + " | ";
               _loc5_.Font.Color = COLOR_Context_03;
               _loc4_ = this.FBoundsGiftedStoneItems[_loc11_];
               BoundsAlignDown(_loc4_,FBoundsOffset);
               FBoundsOffset = _loc4_;
            }
            else
            {
               _loc5_.Text += STRING_OVERLAYEREQUIPMENT.FORMAT_GiftedStoneItemNull;
               _loc5_.Font.Color = COLOR_Context_03 + "  ";
               _loc5_.Evaluate(_loc4_);
               BoundsContextUnion(_loc4_);
            }
            _loc2_++;
         }
      }
      
      protected function EvaluationPerform_ExpandHole(param1:TEquipment) : void
      {
         BoundsAlignDown(this.FBoundsExpandHole,FBoundsOffset);
         FBoundsOffset = this.FBoundsExpandHole;
         this.FPainterExpandHole.Text = TUtilityString.Format(FORMAT_ExpendHole_01,param1.ExpandHoleCount,param1.DigHoleNum);
         this.FPainterExpandHole.Evaluate(this.FBoundsExpandHole);
         BoundsContextUnion(this.FBoundsExpandHole);
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
         _loc2_ = 0;
         while(_loc2_ < CAPACITY_SuitEffects)
         {
            _loc7_ = this.FBoundsSuitAttributes[_loc2_];
            BoundsAlignDown(_loc7_,FBoundsOffset);
            FBoundsOffset = _loc7_;
            _loc8_ = this.FPainterSuitAttributes[_loc2_];
            _loc8_.Font.Size = 12;
            _loc9_ = param1.SuitData.SuitEffects.GetSuitEffectByIndex(_loc2_);
            _loc10_ = _loc9_.SuitQuantity;
            _loc11_ = "";
            _loc5_ = int(_loc9_.Category.length);
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               if(_loc9_.Percentage[_loc4_] == 1)
               {
                  _loc12_ = String((parseFloat(_loc9_.Value[_loc4_]) * 100).toFixed(0)) + "%";
               }
               else
               {
                  _loc12_ = _loc9_.Value[_loc4_];
               }
               _loc6_ = BASEATTRIBUTENAMES.indexOf(_loc9_.Category[_loc4_]);
               _loc11_ += STRINGS_BASEATTRIBUTENAMES[_loc6_] + "+" + _loc12_ + "\t";
               _loc4_++;
            }
            _loc5_ = int(_loc9_.EffectDesc.length);
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc11_ += "\n\t\t\t\t" + _loc9_.EffectDesc[_loc4_];
               _loc4_++;
            }
            _loc8_.Text = TUtilityString.Format(FORMAT_Suit_01,_loc10_,_loc11_);
            if(param1.SuitCount >= (_loc2_ + 1) * 2)
            {
               _loc8_.Font.Color = COLOR_Context_03;
            }
            else
            {
               _loc8_.Font.Color = COLOR_Context_Invalid;
            }
            _loc8_.Evaluate(_loc7_);
            BoundsContextUnion(_loc7_);
            _loc2_++;
         }
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
      
      protected function SketchingPerform_RequirementCareer() : void
      {
         this.FPainterRequirementCareer.RenderBounds(this.FBoundsRequirementCareer,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_EnchantLevel() : void
      {
         this.FPainterEnchantLevel.RenderBounds(this.FBoundsEnchantLevel,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_EnchantProperty() : void
      {
         this.FPainterEnchantProperty.RenderBounds(this.FBoundsEnchantProperty,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_BasisProperty() : void
      {
         this.FPainterBasisProperty.RenderBounds(this.FBoundsBasisProperty,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_AppendAttributeCaption() : void
      {
         this.FPainterAppendAttributeCaption.RenderBounds(this.FBoundsAppendAttributeCaption,TAlignment.HORIZONTAL_Left);
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
      
      protected function SketchingPerform_WeaponSkillCaption() : void
      {
         this.FPainterAppendAttributeCaption.RenderBounds(this.FBoundsAppendAttributeCaption,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_GiftedStoneItemCaption() : void
      {
         this.FPainterGiftedStoneItemCaption.RenderBounds(this.FBoundsGiftedStoneItemCaption,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_GiftedStoneItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBounds = null;
         var _loc4_:TPainterTextEffect = null;
         var _loc5_:TEquipment = null;
         var _loc6_:int = 0;
         _loc5_ = FContext as TEquipment;
         _loc2_ = _loc5_.HoleCount + _loc5_.ExpandHoleCount;
         _loc1_ = 0;
         while(_loc1_ < CAPACITY_GiftedStoneItems)
         {
            if(_loc1_ >= _loc2_)
            {
               break;
            }
            _loc6_ = _loc1_ / 2;
            _loc4_ = this.FPainterGiftedStoneItems[_loc6_];
            _loc3_ = this.FBoundsGiftedStoneItems[_loc6_];
            _loc4_.RenderBounds(_loc3_,TAlignment.HORIZONTAL_Left);
            _loc1_++;
         }
      }
      
      protected function SketchingPerform_ExpandHole() : void
      {
         this.FPainterExpandHole.RenderBounds(this.FBoundsExpandHole,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_SuitCaption() : void
      {
         this.FPainterSuitCaption.RenderBounds(this.FBoundsSuitCaption,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_SuitAttributes() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBounds = null;
         var _loc3_:TPainterTextEffect = null;
         _loc1_ = 0;
         while(_loc1_ < CAPACITY_SuitEffects)
         {
            _loc3_ = this.FPainterSuitAttributes[_loc1_];
            _loc2_ = this.FBoundsSuitAttributes[_loc1_];
            _loc3_.RenderBounds(_loc2_,TAlignment.HORIZONTAL_Left);
            _loc1_++;
         }
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
         this.FPainterRequirementCareer.X = FBoundsRendering.X + this.FBoundsRequirementCareer.X;
         this.FPainterRequirementCareer.Y = FBoundsRendering.Y + this.FBoundsRequirementCareer.Y;
         this.FPainterEnchantLevel.X = FBoundsRendering.X + this.FBoundsEnchantLevel.X;
         this.FPainterEnchantLevel.Y = FBoundsRendering.Y + this.FBoundsEnchantLevel.Y;
         this.FPainterEnchantProperty.X = FBoundsRendering.X + this.FBoundsEnchantProperty.X;
         this.FPainterEnchantProperty.Y = FBoundsRendering.Y + this.FBoundsEnchantProperty.Y;
         this.FPainterBasisProperty.X = FBoundsRendering.X + this.FBoundsBasisProperty.X;
         this.FPainterBasisProperty.Y = FBoundsRendering.Y + this.FBoundsBasisProperty.Y;
         if(_loc6_.MaxAdditionalCount != 0)
         {
            this.FPainterAppendAttributeCaption.X = FBoundsRendering.X + this.FBoundsAppendAttributeCaption.X;
            this.FPainterAppendAttributeCaption.Y = FBoundsRendering.Y + this.FBoundsAppendAttributeCaption.Y;
            _loc3_ = int(_loc6_.MaxAdditionalCount);
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               if(_loc2_ >= _loc3_)
               {
                  break;
               }
               _loc5_ = this.FPainterAppendAttributes[_loc2_];
               _loc4_ = this.FBoundsAppendAttributes[_loc2_];
               _loc5_.X = FBoundsRendering.X + _loc4_.X;
               _loc5_.Y = FBoundsRendering.Y + _loc4_.Y;
               _loc2_++;
            }
         }
         if(_loc6_.WeaponSkillID > 0)
         {
            this.FPainterWeaponSkillCaption.X = FBoundsRendering.X + this.FBoundsWeaponSkillCaption.X;
            this.FPainterWeaponSkillCaption.Y = FBoundsRendering.Y + this.FBoundsWeaponSkillCaption.Y;
         }
         if(_loc6_.HoleCount != 0)
         {
            this.FPainterGiftedStoneItemCaption.X = FBoundsRendering.X + this.FBoundsGiftedStoneItemCaption.X;
            this.FPainterGiftedStoneItemCaption.Y = FBoundsRendering.Y + this.FBoundsGiftedStoneItemCaption.Y;
            _loc3_ = _loc6_.HoleCount + _loc6_.ExpandHoleCount;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc5_ = this.FPainterGiftedStoneItems[int(_loc2_ / 2)];
               _loc4_ = this.FBoundsGiftedStoneItems[int(_loc2_ / 2)];
               _loc5_.X = FBoundsRendering.X + _loc4_.X;
               _loc5_.Y = FBoundsRendering.Y + _loc4_.Y;
               _loc2_++;
            }
         }
         if(_loc6_.DigHoleNum != 0)
         {
            this.FPainterExpandHole.X = FBoundsRendering.X + this.FBoundsExpandHole.X;
            this.FPainterExpandHole.Y = FBoundsRendering.Y + this.FBoundsExpandHole.Y;
         }
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

