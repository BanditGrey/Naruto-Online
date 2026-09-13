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
   import Utilities.Timing.TUtilityTiming;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class TOverlayerInventory extends TOverlayer
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
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected static const FORMAT_Caption:String = STRING_OVERLAYERINVENTORY.FORMAT_Caption;
      
      protected static const FORMAT_SalePrice:String = STRING_OVERLAYERINVENTORY.FORMAT_SalePrice;
      
      protected static const FORMAT_TimingTime:String = STRING_OVERLAYERINVENTORY.FORMAT_TimingTime;
      
      protected var FQuerySequenceTimer:Timer;
      
      protected var FImage:TUIImage;
      
      protected var FMC_DefaultIcon:MovieClip;
      
      protected var FPainterCaption:TPainterTextEffect;
      
      protected var FPainterSalePrice:TPainterTextEffect;
      
      protected var FPainterTimingTime:TPainterTextEffect;
      
      protected var FBoundsImage:TBounds;
      
      protected var FBoundsCaption:TBounds;
      
      protected var FBoundsSalePrice:TBounds;
      
      protected var FBoundsTimingTime:TBounds;
      
      protected var FBoundsOffset:TBounds;
      
      protected var FDividingLinePartTimingTime:Bitmap;
      
      protected var FBoundsPartTimingTime:TBounds;
      
      protected var FTextFormatCaptionA:TextFormat;
      
      protected var FTextFormatCaptionB:TextFormat;
      
      protected var FTextFormatSalePrice:TextFormat;
      
      protected var FContextIdentifier0:uint;
      
      protected var FContextIdentifier1:uint;
      
      protected var FContextIDTemplate:uint;
      
      protected var FContextTimingTime:uint;
      
      protected var FEquipedName:String;
      
      protected var FModuleId:uint;
      
      public function TOverlayerInventory(param1:TUIComponent, param2:uint)
      {
         var _loc3_:int = 0;
         var _loc4_:TBounds = null;
         var _loc5_:TPainterTextEffect = null;
         super(param1);
         this.FModuleId = param2;
         this.FPainterCaption = this.ConstructPainterTextEffect(COLOR_Context_01);
         this.FPainterCaption.Font.Bold = true;
         this.FBoundsCaption = new TBounds();
         this.FPainterSalePrice = this.ConstructPainterTextEffect(COLOR_Context_02);
         this.FBoundsSalePrice = new TBounds();
         this.FPainterTimingTime = this.ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsTimingTime = new TBounds();
         this.FDividingLinePartTimingTime = new Bitmap();
         this.FBoundsPartTimingTime = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 1;
         FMarginBottom = 15;
         this.FEquipedName = "";
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FDividingLinePartTimingTime.bitmapData = FDividingLine;
      }
      
      override protected function ConstructPainterTextEffect(param1:uint = 4294958161) : TPainterTextEffect
      {
         var _loc2_:TPainterTextEffect = null;
         return super.ConstructPainterTextEffect(param1);
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is TInventory;
      }
      
      protected function EvaluationPerform_Caption(param1:TInventory) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         BoundsAlignRight(this.FBoundsCaption,this.FBoundsOffset,SIZE_Padding_03);
         _loc2_ = param1.Name;
         _loc4_ = 0;
         _loc5_ = uint(this.FEquipedName.length);
         if(this.FEquipedName == "")
         {
            this.FPainterCaption.Text = TUtilityString.Format(FORMAT_Caption,_loc2_);
            this.FPainterCaption.Font.Size = SIZE_Context_00;
            this.FPainterCaption.Font.Color = QUALITYCOLOR_INDEX[param1.Quality];
         }
         else
         {
            _loc3_ = this.FEquipedName + _loc2_;
            this.FPainterCaption.Text = TUtilityString.Format(FORMAT_Caption,this.FEquipedName + _loc2_);
            this.FTextFormatCaptionA.color = 16755236;
            this.FTextFormatCaptionA.size = 14;
            this.FPainterCaption.Evaluate(this.FBoundsCaption);
            this.FPainterCaption.SetTextFormat(this.FTextFormatCaptionA,_loc4_,_loc5_);
            this.FTextFormatCaptionB.color = QUALITYCOLOR_INDEX[param1.Quality];
            this.FTextFormatCaptionB.size = SIZE_Context_00;
            this.FPainterCaption.SetTextFormat(this.FTextFormatCaptionB,_loc5_,_loc3_.length);
         }
         this.FBoundsCaption.Y -= 5;
         this.FPainterCaption.Evaluate(this.FBoundsCaption);
         BoundsContextUnion(this.FBoundsCaption);
      }
      
      protected function EvaluationPerform_SalePrice(param1:TInventory) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         BoundsAlignDown(this.FBoundsSalePrice,this.FBoundsOffset,SIZE_Padding_02);
         _loc3_ = param1.SellValue + param1.SellingValue;
         _loc2_ = FORMAT_SalePrice.length - "%0".length;
         this.FPainterSalePrice.Text = TUtilityString.Format(FORMAT_SalePrice,_loc3_);
         this.FTextFormatSalePrice.color = COLOR_Context_White;
         this.FPainterSalePrice.Evaluate(this.FBoundsSalePrice);
         this.FPainterSalePrice.SetTextFormat(this.FTextFormatSalePrice,0,_loc2_);
         BoundsContextUnion(this.FBoundsSalePrice);
      }
      
      protected function EvaluationPerform_SuitEffect(param1:TInventory) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         BoundsAlignDown(this.FBoundsSalePrice,this.FBoundsOffset,SIZE_Padding_02);
         _loc3_ = param1.SellValue + param1.SellingValue;
         _loc2_ = FORMAT_SalePrice.length - "%0".length;
         this.FPainterSalePrice.Text = TUtilityString.Format(FORMAT_SalePrice,_loc3_);
         this.FTextFormatSalePrice.color = COLOR_Context_White;
         this.FPainterSalePrice.Evaluate(this.FBoundsSalePrice);
         this.FPainterSalePrice.SetTextFormat(this.FTextFormatSalePrice,0,_loc2_);
         BoundsContextUnion(this.FBoundsSalePrice);
      }
      
      protected function EvaluationPerform_PartTimingTime(param1:TInventory) : void
      {
         this.FBoundsPartTimingTime.Width = this.FDividingLinePartTimingTime.width;
         this.FBoundsPartTimingTime.Height = this.FDividingLinePartTimingTime.height;
         BoundsAlignDown(this.FBoundsPartTimingTime,this.FBoundsOffset,SIZE_Padding_02);
         this.FBoundsPartTimingTime.X = 0;
         BoundsContextUnion(this.FBoundsPartTimingTime);
      }
      
      protected function EvaluationPerform_TimingTime(param1:TInventory) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         BoundsAlignDown(this.FBoundsTimingTime,this.FBoundsOffset,SIZE_Padding_02);
         _loc2_ = param1.TimingTime;
         _loc3_ = TUtilityTiming.FormatDHMSBySeconds(_loc2_);
         this.FPainterTimingTime.Text = TUtilityString.Format(FORMAT_TimingTime,_loc3_);
         this.FPainterTimingTime.Evaluate(this.FBoundsTimingTime);
         BoundsContextUnion(this.FBoundsTimingTime);
      }
      
      protected function TimeQuerySequence(param1:TimerEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:TResourceRepositoryTexture = null;
         var _loc4_:TTexture = null;
         _loc2_ = FContext as TInventory;
         if(_loc2_ == null)
         {
            return;
         }
         _loc3_ = SResourcesCore.TexturesInventory;
         _loc4_ = _loc3_.GetTextureByIdentifier(_loc2_.IDTexture);
         if(_loc4_ != null)
         {
            this.FImage.Sequence = _loc4_.GetAnimationSequenceByIdentifier(0);
            if(this.FMC_DefaultIcon.visible)
            {
               this.FMC_DefaultIcon.stop();
               this.FMC_DefaultIcon.visible = false;
            }
            this.FQuerySequenceTimer.reset();
            this.FQuerySequenceTimer.stop();
         }
         else
         {
            _loc3_.LoadSecondary(_loc2_.IDTexture,this.FModuleId);
            this.FQuerySequenceTimer.reset();
            if(!this.FQuerySequenceTimer.running)
            {
               this.FQuerySequenceTimer.start();
            }
         }
      }
      
      public function get EquipedName() : String
      {
         return this.FEquipedName;
      }
      
      public function set EquipedName(param1:String) : void
      {
         if(param1 != this.FEquipedName)
         {
            this.FEquipedName = param1;
            FModified = true;
         }
      }
   }
}

