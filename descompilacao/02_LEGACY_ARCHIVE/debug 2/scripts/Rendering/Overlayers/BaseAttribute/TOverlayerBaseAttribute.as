package Rendering.Overlayers.BaseAttribute
{
   import Components.Standard.*;
   import Foundation.Common.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Characters.*;
   import Logics.Inventories.*;
   import Rendering.Overlayers.*;
   import Rendering.Texts.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.text.*;
   
   public class TOverlayerBaseAttribute extends TOverlayer
   {
      
      protected static const SIZE_TextFormat_leading:uint = 1;
      
      protected static const SIZE_WordWrapWidth:uint = 170;
      
      protected static const SIZE_Padding_01:uint = 5;
      
      protected static const SIZE_Context_00:uint = 14;
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_01:uint = 4294958161;
      
      protected static const COLOR_Context_02:uint = 4294967040;
      
      protected static const STARTINDEX_BaseAttribute:uint = 5;
      
      protected static const ENDINDEX_BaseAttribute:uint = 17;
      
      public static const CAPACITY_OverlayerBaseAttributes:int = 11;
      
      public static const PROFESSION_Intellect:uint = CONST_CHARACTER.PROFESSION_Intellect;
      
      public static const PROFESSION_Warlock:uint = CONST_CHARACTER.PROFESSION_Warlock;
      
      public static const CAPACITY_BaseAttributes:int = CONST_COMMON.CAPACITY_BaseAttributes;
      
      public static const STRINGS_OVERLAYERBASEATTRIBUTENAMES:Vector.<String> = STRING_COMMON.STRINGS_OVERLAYERBASEATTRIBUTENAMES;
      
      public static const BASEATTRIBUTEINDEX_PhysicalAttack:int = CONST_COMMON.BASEATTRIBUTEINDEX_PhysicalAttack;
      
      public static const BASEATTRIBUTEINDEX_MagicAttack:int = CONST_COMMON.BASEATTRIBUTEINDEX_MagicAttack;
      
      public static const BASEATTRIBUTEINDEX_PhysicalDefends:int = CONST_COMMON.BASEATTRIBUTEINDEX_PhysicalDefends;
      
      public static const BASEATTRIBUTEINDEX_MagicDefends:int = CONST_COMMON.BASEATTRIBUTEINDEX_MagicDefends;
      
      public static const BASEATTRIBUTEINDEX_Hit:Number = CONST_COMMON.BASEATTRIBUTEINDEX_Hit;
      
      public static const BASEATTRIBUTEINDEX_Dodge:Number = CONST_COMMON.BASEATTRIBUTEINDEX_Dodge;
      
      public static const BASEATTRIBUTEINDEX_Crit:Number = CONST_COMMON.BASEATTRIBUTEINDEX_Crit;
      
      public static const BASEATTRIBUTEINDEX_GridFile:Number = CONST_COMMON.BASEATTRIBUTEINDEX_GridFile;
      
      public static const BASEATTRIBUTEINDEX_Punch:Number = CONST_COMMON.BASEATTRIBUTEINDEX_Punch;
      
      public static const BASEATTRIBUTEINDEX_Help:Number = CONST_COMMON.BASEATTRIBUTEINDEX_Help;
      
      public static const BASEATTRIBUTEINDEX_Wreck:Number = CONST_COMMON.BASEATTRIBUTEINDEX_Wreck;
      
      public static const BASEATTRIBUTEINDEX_Uprising:Number = CONST_COMMON.BASEATTRIBUTEINDEX_Uprising;
      
      public static const FORMAT_BaseAttribute:String = STRING_OVERLAYERBASEATTRIBUTE.FORMAT_BaseAttribute;
      
      protected var FPainterCaption:TPainterTextEffect;
      
      protected var FBoundsCaption:TBounds;
      
      protected var FBoundsOffset:TBounds;
      
      protected var FContextIdentifier0:uint;
      
      protected var FContextIdentifier1:uint;
      
      protected var FContextIDTemplate:uint;
      
      protected var FBaseAttributes:Vector.<Number>;
      
      protected var FTextFormatCaption:TextFormat;
      
      public function TOverlayerBaseAttribute(param1:TUIComponent)
      {
         super(param1);
         this.FBaseAttributes = new Vector.<Number>(CAPACITY_OverlayerBaseAttributes);
         this.FPainterCaption = ConstructPainterTextEffect(COLOR_Context_01);
         this.FPainterCaption.Font.Size = SIZE_Context_00;
         this.FPainterCaption.WordWrapWidth = SIZE_WordWrapWidth;
         this.FBoundsCaption = new TBounds();
         this.FTextFormatCaption = new TextFormat();
         FMarginLeft = 15;
         FMarginTop = 10;
         FMarginRight = 15;
         FMarginBottom = 10;
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is THero;
      }
      
      override protected function ContextModified() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:THero = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         _loc4_ = FContext as THero;
         _loc3_ = false;
         _loc2_ = CAPACITY_BaseAttributes;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc1_ + STARTINDEX_BaseAttribute > ENDINDEX_BaseAttribute)
            {
               break;
            }
            _loc5_ = this.FBaseAttributes[_loc1_];
            _loc6_ = _loc4_.GetBaseAttributeByIndex(_loc1_ + STARTINDEX_BaseAttribute);
            if(_loc5_ > _loc6_ || _loc5_ < _loc6_)
            {
               _loc3_ = true;
               break;
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      override protected function ContextSynchronize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:THero = null;
         _loc3_ = FContext as THero;
         _loc2_ = CAPACITY_BaseAttributes;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc1_ + STARTINDEX_BaseAttribute > ENDINDEX_BaseAttribute)
            {
               break;
            }
            this.FBaseAttributes[_loc1_] = _loc3_.GetBaseAttributeByIndex(_loc1_ + STARTINDEX_BaseAttribute);
            _loc1_++;
         }
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:THero = null;
         _loc1_ = FContext as THero;
         this.EvaluationPerform_Caption(_loc1_);
         this.FBoundsOffset = this.FBoundsCaption;
      }
      
      protected function EvaluationPerform_Caption(param1:THero) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         BoundsAlignDown(this.FBoundsCaption);
         if(param1.Profession == PROFESSION_Intellect || param1.Profession == PROFESSION_Warlock)
         {
            _loc3_ = STRINGS_OVERLAYERBASEATTRIBUTENAMES[BASEATTRIBUTEINDEX_MagicAttack];
            _loc4_ = param1.GetBaseAttributeByIndex(BASEATTRIBUTEINDEX_MagicAttack);
         }
         else
         {
            _loc3_ = STRINGS_OVERLAYERBASEATTRIBUTENAMES[BASEATTRIBUTEINDEX_PhysicalAttack];
            _loc4_ = param1.GetBaseAttributeByIndex(BASEATTRIBUTEINDEX_PhysicalAttack);
         }
         _loc2_ = TUtilityString.Format(FORMAT_BaseAttribute,_loc3_,_loc4_,STRINGS_OVERLAYERBASEATTRIBUTENAMES[BASEATTRIBUTEINDEX_PhysicalDefends],param1.GetBaseAttributeByIndex(BASEATTRIBUTEINDEX_PhysicalDefends),STRINGS_OVERLAYERBASEATTRIBUTENAMES[BASEATTRIBUTEINDEX_MagicDefends],param1.GetBaseAttributeByIndex(BASEATTRIBUTEINDEX_MagicDefends),STRINGS_OVERLAYERBASEATTRIBUTENAMES[BASEATTRIBUTEINDEX_Hit],param1.GetBaseAttributeByIndex(BASEATTRIBUTEINDEX_Hit),STRINGS_OVERLAYERBASEATTRIBUTENAMES[BASEATTRIBUTEINDEX_Dodge],param1.GetBaseAttributeByIndex(BASEATTRIBUTEINDEX_Dodge),STRINGS_OVERLAYERBASEATTRIBUTENAMES[BASEATTRIBUTEINDEX_Crit],param1.GetBaseAttributeByIndex(BASEATTRIBUTEINDEX_Crit),STRINGS_OVERLAYERBASEATTRIBUTENAMES[BASEATTRIBUTEINDEX_GridFile],param1.GetBaseAttributeByIndex(BASEATTRIBUTEINDEX_GridFile),STRINGS_OVERLAYERBASEATTRIBUTENAMES[BASEATTRIBUTEINDEX_Punch],param1.GetBaseAttributeByIndex(BASEATTRIBUTEINDEX_Punch),STRINGS_OVERLAYERBASEATTRIBUTENAMES[BASEATTRIBUTEINDEX_Help],param1.GetBaseAttributeByIndex(BASEATTRIBUTEINDEX_Help)
         ,STRINGS_OVERLAYERBASEATTRIBUTENAMES[BASEATTRIBUTEINDEX_Wreck],param1.GetBaseAttributeByIndex(BASEATTRIBUTEINDEX_Wreck),STRINGS_OVERLAYERBASEATTRIBUTENAMES[BASEATTRIBUTEINDEX_Uprising],param1.GetBaseAttributeByIndex(BASEATTRIBUTEINDEX_Uprising));
         this.FTextFormatCaption.leading = SIZE_TextFormat_leading;
         this.FPainterCaption.Text = _loc2_;
         this.FPainterCaption.Evaluate(this.FBoundsCaption);
         this.FPainterCaption.SetTextFormat(this.FTextFormatCaption);
         this.FBoundsCaption.Height += 10;
         BoundsContextUnion(this.FBoundsCaption);
      }
      
      override protected function SketchingPerform_Context() : void
      {
         this.SketchingPerform_Caption();
      }
      
      protected function SketchingPerform_Caption() : void
      {
         this.FPainterCaption.RenderBounds(this.FBoundsCaption,TAlignment.HORIZONTAL_Left);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPainterCaption.X = FBoundsRendering.X + this.FBoundsCaption.X;
         this.FPainterCaption.Y = FBoundsRendering.Y + this.FBoundsCaption.Y;
      }
   }
}

