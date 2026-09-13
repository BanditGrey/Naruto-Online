package Rendering.Overlayers.MasterRoad
{
   import Components.Standard.TUIImage;
   import Foundation.Common.TAlignment;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TAnimationSequence;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Rendering.Overlayers.Inventories.TOverlayerInventory;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Strings.STRING_INVENTORY;
   import Resources.Strings.STRING_MASTERROAD;
   import Resources.Strings.STRING_OVERLAYERCROSSSERVERWAR;
   import Resources.Strings.STRING_OVERLAYERTREASURE;
   import Resources.Strings.STRING_SYSTEMACTIVITY;
   import flash.display.Bitmap;
   import flash.events.TimerEvent;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   
   public class TOverlayerHonorPlayer extends TOverlayerInventory
   {
      
      protected static const SIZE_DividingLine_Max_Width:uint = 290;
      
      protected static const SIZE_DividingLine_Min_Width:uint = 280;
      
      protected static const SIZE_Image_Width:uint = 81;
      
      protected static const SIZE_Image_Height:uint = 71;
      
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
      
      public function TOverlayerHonorPlayer(param1:TUIComponent, param2:uint)
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
         this.FDividingLinePartCaption.bitmapData = FDividingLine;
         this.FDividingLinePartAttribute.bitmapData = FDividingLine;
         this.FDividingLinePartDescCaption.bitmapData = FDividingLine;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is TConsumeRankInfo;
      }
      
      override protected function ContextSynchronize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TConsumeRankInfo = null;
         _loc3_ = FContext as TConsumeRankInfo;
         this.FDividingLinePartCaption.width = SIZE_DividingLine_Min_Width;
         this.FDividingLinePartAttribute.width = SIZE_DividingLine_Min_Width;
         this.FDividingLinePartDescCaption.width = SIZE_DividingLine_Min_Width;
         FDividingLinePartTimingTime.width = SIZE_DividingLine_Min_Width;
      }
      
      override protected function EvaluationPerform_Icon() : void
      {
         var _loc1_:TConsumeRankInfo = null;
         var _loc2_:TAnimationSequence = null;
         FImage.Sequence = null;
         _loc1_ = FContext as TConsumeRankInfo;
         _loc2_ = SResourcesCore.TexturesHeadIcon.GetAnimationSequenceByIdentifiers(_loc1_.HeroID,0);
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
         }
         FBoundsImage.Width = SIZE_Image_Width;
         FBoundsImage.Height = SIZE_Image_Height;
         BoundsContextUnion(FBoundsImage);
         FBoundsOffset = FBoundsImage;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:TConsumeRankInfo = null;
         _loc1_ = FContext as TConsumeRankInfo;
         this.EvaluationPerform_Name(_loc1_);
         FBoundsOffset = this.FBoundsUpgradingLevel;
         this.EvaluationPerform_Server(_loc1_);
         FBoundsOffset = this.FBoundsRequirementLevel;
         this.EvaluationPerform_Time(_loc1_);
         FBoundsOffset = this.FBoundsCategorySecond;
         this.EvaluationPerform_Desc(_loc1_);
         FBoundsOffset = this.FBoundsAppendAttributeCaption;
      }
      
      protected function EvaluationPerform_Name(param1:TConsumeRankInfo) : void
      {
         BoundsAlignRight(this.FBoundsUpgradingLevel,FBoundsOffset,SIZE_Padding_02);
         this.FPainterUpgradingLevel.Text = STRING_SYSTEMACTIVITY.FORMAT_PLAYER_NICK + ":" + param1.UserName + "\n";
         this.FPainterUpgradingLevel.Font.Size = SIZE_Context_00 - 1;
         this.FBoundsUpgradingLevel.Y += 1;
         this.FPainterUpgradingLevel.Evaluate(this.FBoundsUpgradingLevel);
         BoundsContextUnion(this.FBoundsUpgradingLevel);
      }
      
      protected function EvaluationPerform_Server(param1:TConsumeRankInfo) : void
      {
         BoundsAlignDown(this.FBoundsRequirementLevel,FBoundsOffset,SIZE_Padding_02);
         this.FPainterRequirementLevel.Text = TUtilityString.Format(STRING_OVERLAYERCROSSSERVERWAR.FORMAT_ServerName,param1.ServerName);
         this.FPainterRequirementLevel.Evaluate(this.FBoundsRequirementLevel);
         BoundsContextUnion(this.FBoundsRequirementLevel);
      }
      
      protected function EvaluationPerform_Time(param1:TConsumeRankInfo) : void
      {
         BoundsAlignDown(this.FBoundsCategorySecond,FBoundsOffset,SIZE_Padding_01);
         this.FPainterCategorySecond.Text = TUtilityString.Format(new ConsumeFrameCopy(STRING_MASTERROAD.STRING_004).DescribeString,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(param1.Time) * 1000)));
         this.FPainterCategorySecond.Evaluate(this.FBoundsCategorySecond);
         BoundsContextUnion(this.FBoundsCategorySecond);
      }
      
      protected function EvaluationPerform_Desc(param1:TConsumeRankInfo) : void
      {
         BoundsAlignDown(this.FBoundsAppendAttributeCaption);
         this.FPainterAppendAttributeCaption.Text = new ConsumeFrameCopy(STRING_MASTERROAD.STRING_008).DescribeString + "\n" + param1.Desc1;
         this.FPainterAppendAttributeCaption.Evaluate(this.FBoundsAppendAttributeCaption);
         BoundsContextUnion(this.FBoundsAppendAttributeCaption);
      }
      
      override protected function SketchingPerform_Context() : void
      {
         this.SketchingPerform_Name();
         this.SketchingPerform_Server();
         this.SketchingPerform_Time();
         this.SketchingPerform_Desc();
      }
      
      protected function SketchingPerform_Name() : void
      {
         FPainterCaption.RenderBounds(this.FBoundsUpgradingLevel,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_Server() : void
      {
         this.FPainterRequirementLevel.RenderBounds(this.FBoundsRequirementLevel,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_Time() : void
      {
         this.FPainterCategorySecond.RenderBounds(this.FBoundsCategorySecond,TAlignment.HORIZONTAL_Left);
      }
      
      protected function SketchingPerform_Desc() : void
      {
         this.FPainterAppendAttributeCaption.RenderBounds(this.FBoundsAppendAttributeCaption,TAlignment.HORIZONTAL_Left);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBounds = null;
         var _loc5_:TPainterTextEffect = null;
         var _loc6_:TConsumeRankInfo = null;
         _loc6_ = FContext as TConsumeRankInfo;
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         FImage.X = FBoundsRendering.X + FBoundsImage.X;
         FImage.Y = FBoundsRendering.Y + FBoundsImage.Y;
         this.FPainterUpgradingLevel.X = FBoundsRendering.X + this.FBoundsUpgradingLevel.X;
         this.FPainterUpgradingLevel.Y = FBoundsRendering.Y + this.FBoundsUpgradingLevel.Y;
         this.FPainterRequirementLevel.X = FBoundsRendering.X + this.FBoundsRequirementLevel.X;
         this.FPainterRequirementLevel.Y = FBoundsRendering.Y + this.FBoundsRequirementLevel.Y;
         this.FPainterCategorySecond.X = FBoundsRendering.X + this.FBoundsCategorySecond.X;
         this.FPainterCategorySecond.Y = FBoundsRendering.Y + this.FBoundsCategorySecond.Y;
         this.FPainterAppendAttributeCaption.X = FBoundsRendering.X + this.FBoundsAppendAttributeCaption.X;
         this.FPainterAppendAttributeCaption.Y = FBoundsRendering.Y + this.FBoundsAppendAttributeCaption.Y;
      }
   }
}

