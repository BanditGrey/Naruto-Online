package Rendering.Overlayers.Title
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.Title.TTitle;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_OVERLAYERTITLE;
   import Utilities.Timing.TUtilityTiming;
   import flash.display.Bitmap;
   import flash.events.TimerEvent;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   
   public class TOverlayerTitle extends TOverlayer
   {
      
      protected static const SIZE_DividingLineOffset:uint = 3;
      
      protected static const CAPACITY_HeroHeads:uint = 4;
      
      protected static const CAPACITY_AppendAttributes:uint = 4;
      
      protected static const SIZE_Image_Width:uint = 80;
      
      protected static const SIZE_Image_Height:uint = 70;
      
      protected static const SIZE_Context_00:uint = 18;
      
      protected static const SIZE_Padding_01:uint = 3;
      
      protected static const SIZE_Padding_02:uint = 10;
      
      protected static const SIZE_Padding_03:uint = 15;
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_Invalid:uint = 4286611584;
      
      protected static const COLOR_Context_01:uint = 4291545959;
      
      protected static const COLOR_Context_03:uint = 4294890346;
      
      protected static const COLOR_Context_04:uint = 16737792;
      
      protected static const COLOR_Context_Green:uint = 4284940032;
      
      protected static const SIZE_DividingLine_Max_Width:uint = 250;
      
      protected static const SIZE_DividingLine_Min_Width:uint = 240;
      
      protected var FTimingTimer:Timer;
      
      protected var FPainterTitleName:TPainterTextEffect;
      
      protected var FPainterUseLevel:TPainterTextEffect;
      
      protected var FPainterVipLevel:TPainterTextEffect;
      
      protected var FPainterDescCaption:TPainterTextEffect;
      
      protected var FPainterTitleDesc:TPainterTextEffect;
      
      protected var FPainterAddValueCaption:TPainterTextEffect;
      
      protected var FPainterAppendAttributes:Vector.<TPainterTextEffect>;
      
      protected var FBoundsAppendAttributes:Vector.<TBounds>;
      
      protected var FPainterTimingTime:TPainterTextEffect;
      
      protected var FBoundsTitleName:TBounds;
      
      protected var FBoundsUseLevel:TBounds;
      
      protected var FBoundsVipLevel:TBounds;
      
      protected var FBoundsPartCaption:TBounds;
      
      protected var FBoundsDescCaption:TBounds;
      
      protected var FBoundsTitleDesc:TBounds;
      
      protected var FBoundsPartDesc:TBounds;
      
      protected var FBoundsAddValueCaption:TBounds;
      
      protected var FBoundsPartAddValue:TBounds;
      
      protected var FBoundsTimingTime:TBounds;
      
      protected var FTextFormatTitleName:TextFormat;
      
      protected var FTextFormatUseLevel:TextFormat;
      
      protected var FTextFormatVipLevel:TextFormat;
      
      protected var FTextFormatTimingTime:TextFormat;
      
      protected var FDividingLinePartCaption:Bitmap;
      
      protected var FDividingLinePartDesc:Bitmap;
      
      protected var FDividingLinePartAddValue:Bitmap;
      
      protected var FBoundsOffset:TBounds;
      
      protected var FTitle:TTitle;
      
      public function TOverlayerTitle(param1:TUIComponent)
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TPainterTextEffect = null;
         var _loc5_:TBounds = null;
         super(param1);
         this.FPainterTitleName = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsTitleName = new TBounds();
         this.FPainterUseLevel = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsUseLevel = new TBounds();
         this.FPainterVipLevel = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsVipLevel = new TBounds();
         this.FPainterDescCaption = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsDescCaption = new TBounds();
         this.FPainterTitleDesc = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsTitleDesc = new TBounds();
         this.FPainterAddValueCaption = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsAddValueCaption = new TBounds();
         this.FPainterAppendAttributes = new Vector.<TPainterTextEffect>(CAPACITY_AppendAttributes);
         this.FBoundsAppendAttributes = new Vector.<TBounds>(CAPACITY_AppendAttributes);
         _loc2_ = 0;
         while(_loc2_ < CAPACITY_AppendAttributes)
         {
            _loc4_ = ConstructPainterTextEffect(COLOR_Context_Green);
            this.FPainterAppendAttributes[_loc2_] = _loc4_;
            _loc5_ = new TBounds();
            this.FBoundsAppendAttributes[_loc2_] = _loc5_;
            _loc2_++;
         }
         this.FPainterTimingTime = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsTimingTime = new TBounds();
         this.FDividingLinePartCaption = new Bitmap();
         addChild(this.FDividingLinePartCaption);
         this.FBoundsPartCaption = new TBounds();
         this.FDividingLinePartDesc = new Bitmap();
         addChild(this.FDividingLinePartDesc);
         this.FBoundsPartDesc = new TBounds();
         this.FDividingLinePartAddValue = new Bitmap();
         addChild(this.FDividingLinePartAddValue);
         this.FBoundsPartAddValue = new TBounds();
         this.FTextFormatTitleName = new TextFormat();
         this.FTextFormatUseLevel = new TextFormat();
         this.FTextFormatVipLevel = new TextFormat();
         this.FTextFormatTimingTime = new TextFormat();
         this.FTimingTimer = new Timer(1000);
         this.FTimingTimer.addEventListener(TimerEvent.TIMER,this.TimeOnTimer);
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 1;
         FMarginBottom = 15;
         this.FBoundsOffset = new TBounds();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FDividingLinePartCaption.bitmapData = FDividingLine;
         this.FDividingLinePartDesc.bitmapData = FDividingLine;
         this.FDividingLinePartAddValue.bitmapData = FDividingLine;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ContextSynchronize() : void
      {
         this.FDividingLinePartCaption.width = SIZE_DividingLine_Min_Width;
         this.FDividingLinePartDesc.width = SIZE_DividingLine_Min_Width;
         this.FDividingLinePartAddValue.width = SIZE_DividingLine_Min_Width;
      }
      
      protected function TimeOnTimer(param1:TimerEvent) : void
      {
         var _loc2_:uint = 0;
         if(this.FTitle.Type == 1)
         {
            _loc2_ = this.FTitle.EndTime - STimingCore.GetServerTime();
            if(_loc2_ > 0)
            {
               this.ProcessorCountDown(this.FTitle);
            }
            else
            {
               this.FPainterTimingTime.Visible = false;
               this.FDividingLinePartAddValue.visible = false;
               this.FTimingTimer.stop();
            }
         }
         else if(this.FTitle.Type == 3)
         {
            this.FPainterTimingTime.Visible = true;
            this.FDividingLinePartAddValue.visible = true;
            this.FTimingTimer.stop();
         }
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TTitle = null;
         _loc3_ = FContext as TTitle;
         this.FTitle = FContext as TTitle;
         this.EvaluationPerform_TitleName(_loc3_);
         this.FBoundsOffset = this.FBoundsTitleName;
         this.EvaluationPerform_UseLevel(_loc3_);
         this.FBoundsOffset = this.FBoundsUseLevel;
         this.EvaluationPerform_VipLevel(_loc3_);
         this.FBoundsOffset = this.FBoundsVipLevel;
         this.EvaluationPerform_PartCaption(_loc3_);
         this.FBoundsOffset = this.FBoundsPartCaption;
         this.EvaluationPerform_DescCaption(_loc3_);
         this.FBoundsOffset = this.FBoundsDescCaption;
         this.EvaluationPerform_TitleDesc(_loc3_);
         this.FBoundsOffset = this.FBoundsTitleDesc;
         this.EvaluationPerform_PartDesc(_loc3_);
         this.FBoundsOffset = this.FBoundsPartDesc;
         this.EvaluationPerform_AddValueCaption(_loc3_);
         this.FBoundsOffset = this.FBoundsAddValueCaption;
         this.EvaluationPerform_AppendAttributes(_loc3_);
         if(_loc3_.Type == 1)
         {
            if(_loc3_.EndTime - STimingCore.GetServerTime() > 0)
            {
               this.EvaluationPerform_Time(_loc3_);
               if(!this.FTimingTimer.running)
               {
                  this.FTimingTimer.start();
               }
            }
            else
            {
               this.FPainterTimingTime.Visible = false;
               this.FDividingLinePartAddValue.visible = false;
               if(this.FTimingTimer.running)
               {
                  this.FTimingTimer.stop();
               }
            }
         }
         else if(_loc3_.Type == 3)
         {
            this.EvaluationPerform_Time(_loc3_);
         }
      }
      
      protected function EvaluationPerform_Time(param1:TTitle) : void
      {
         this.FPainterTimingTime.Visible = true;
         this.FDividingLinePartAddValue.visible = true;
         this.EvaluationPerform_PartAddValue(param1);
         this.FBoundsOffset = this.FBoundsPartAddValue;
         this.EvaluationPerform_TimingTime(param1);
         this.FBoundsOffset = this.FBoundsTimingTime;
      }
      
      protected function EvaluationPerform_TitleName(param1:TTitle) : void
      {
         BoundsAlignDown(this.FBoundsTitleName);
         this.FPainterTitleName.Text = param1.TitleName;
         this.FTextFormatTitleName.size = SIZE_Context_00;
         this.FPainterTitleName.Evaluate(this.FBoundsTitleName);
         this.FPainterTitleName.SetTextFormat(this.FTextFormatTitleName);
         BoundsContextUnion(this.FBoundsTitleName);
      }
      
      protected function EvaluationPerform_UseLevel(param1:TTitle) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         BoundsAlignDown(this.FBoundsUseLevel,this.FBoundsOffset,SIZE_Padding_02);
         _loc2_ = 0;
         _loc3_ = int(STRING_OVERLAYERTITLE.FORMAT_UseLevel_COLOR_LEGNTH);
         this.FPainterUseLevel.Text = TUtilityString.Format(STRING_OVERLAYERTITLE.FORMAT_UseLevel,param1.Level);
         this.FTextFormatUseLevel.color = COLOR_Context_White;
         this.FPainterUseLevel.Evaluate(this.FBoundsUseLevel);
         this.FPainterUseLevel.SetTextFormat(this.FTextFormatUseLevel,_loc2_,_loc3_);
         BoundsContextUnion(this.FBoundsUseLevel);
      }
      
      protected function EvaluationPerform_VipLevel(param1:TTitle) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         BoundsAlignDown(this.FBoundsVipLevel,this.FBoundsOffset);
         _loc2_ = 0;
         _loc3_ = int(STRING_OVERLAYERTITLE.FORMAT_VipLevel_COLOR_LEGNTH);
         this.FPainterVipLevel.Text = TUtilityString.Format(STRING_OVERLAYERTITLE.FORMAT_VipLevel,param1.VipLevel);
         this.FTextFormatVipLevel.color = COLOR_Context_White;
         this.FTextFormatVipLevel.size = 12;
         this.FPainterVipLevel.Evaluate(this.FBoundsVipLevel);
         this.FPainterVipLevel.SetTextFormat(this.FTextFormatVipLevel,_loc2_,_loc3_);
         BoundsContextUnion(this.FBoundsVipLevel);
      }
      
      protected function EvaluationPerform_PartCaption(param1:TTitle) : void
      {
         this.FBoundsPartCaption.Width = this.FDividingLinePartCaption.width;
         this.FBoundsPartCaption.Height = this.FDividingLinePartCaption.height;
         BoundsAlignDown(this.FBoundsPartCaption,this.FBoundsOffset);
         this.FBoundsPartCaption.X = 0;
         BoundsContextUnion(this.FBoundsPartCaption);
      }
      
      protected function EvaluationPerform_DescCaption(param1:TTitle) : void
      {
         BoundsAlignDown(this.FBoundsDescCaption,this.FBoundsOffset,SIZE_Padding_01);
         this.FPainterDescCaption.Text = STRING_OVERLAYERTITLE.STRING_TitleDescCaption;
         this.FPainterDescCaption.Evaluate(this.FBoundsDescCaption);
         BoundsContextUnion(this.FBoundsDescCaption);
      }
      
      protected function EvaluationPerform_TitleDesc(param1:TTitle) : void
      {
         var _loc2_:String = null;
         BoundsAlignRight(this.FBoundsTitleDesc,this.FBoundsOffset,SIZE_Padding_01);
         _loc2_ = TUtilityString.Format(STRING_OVERLAYERTITLE.FORMAT_TitleDesc,param1.TitleSource);
         _loc2_ = _loc2_.split("%n").join("\n");
         this.FPainterTitleDesc.Text = _loc2_;
         this.FPainterTitleDesc.Evaluate(this.FBoundsTitleDesc);
         BoundsContextUnion(this.FBoundsTitleDesc);
      }
      
      protected function EvaluationPerform_PartDesc(param1:TTitle) : void
      {
         this.FBoundsPartDesc.Width = this.FDividingLinePartDesc.width;
         this.FBoundsPartDesc.Height = this.FDividingLinePartDesc.height;
         BoundsAlignDown(this.FBoundsPartDesc,this.FBoundsOffset);
         this.FBoundsPartDesc.X = 0;
         BoundsContextUnion(this.FBoundsPartDesc);
      }
      
      protected function EvaluationPerform_AddValueCaption(param1:TTitle) : void
      {
         BoundsAlignDown(this.FBoundsAddValueCaption,this.FBoundsOffset,SIZE_Padding_01);
         this.FPainterAddValueCaption.Text = STRING_OVERLAYERTITLE.STRING_AddValue;
         this.FPainterAddValueCaption.Evaluate(this.FBoundsAddValueCaption);
         BoundsContextUnion(this.FBoundsAddValueCaption);
      }
      
      protected function EvaluationPerform_AppendAttributes(param1:TTitle) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TBounds = null;
         var _loc5_:TPainterTextEffect = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         _loc3_ = CAPACITY_AppendAttributes;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = "";
            _loc4_ = this.FBoundsAppendAttributes[_loc2_];
            if(_loc2_ == 0)
            {
               BoundsAlignRight(_loc4_,this.FBoundsOffset,SIZE_Padding_01);
            }
            else
            {
               BoundsAlignDown(_loc4_,this.FBoundsOffset,SIZE_Padding_01);
            }
            this.FBoundsOffset = _loc4_;
            _loc5_ = this.FPainterAppendAttributes[_loc2_];
            if(param1.AddValues.length > 0)
            {
               _loc7_ = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(param1.AddValues[_loc2_].AddType);
               if(_loc7_ > -1)
               {
                  if(param1.AddValues[_loc2_].AddValue >= 1)
                  {
                     _loc6_ = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc7_] + " + " + param1.AddValues[_loc2_].AddValue;
                  }
                  else
                  {
                     _loc6_ = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc7_] + " + " + param1.AddValues[_loc2_].AddValue * 100 + "%";
                  }
               }
            }
            _loc5_.Text = _loc6_;
            _loc5_.Evaluate(_loc4_);
            BoundsContextUnion(_loc4_);
            _loc2_++;
         }
      }
      
      protected function EvaluationPerform_PartAddValue(param1:TTitle) : void
      {
         this.FBoundsPartAddValue.Width = this.FDividingLinePartAddValue.width;
         this.FBoundsPartAddValue.Height = this.FDividingLinePartAddValue.height;
         BoundsAlignDown(this.FBoundsPartAddValue,this.FBoundsOffset);
         this.FBoundsPartAddValue.X = 0;
         BoundsContextUnion(this.FBoundsPartAddValue);
      }
      
      protected function EvaluationPerform_TimingTime(param1:TTitle) : void
      {
         BoundsAlignDown(this.FBoundsTimingTime,this.FBoundsOffset,SIZE_Padding_01);
         this.ProcessorCountDown(param1);
         BoundsContextUnion(this.FBoundsTimingTime);
      }
      
      protected function ProcessorCountDown(param1:TTitle) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         _loc5_ = 0;
         _loc6_ = 0;
         _loc7_ = "";
         if(param1.Type == 1)
         {
            _loc2_ = param1.EndTime - STimingCore.GetServerTime();
            _loc3_ = TUtilityTiming.FormatDHMSBySeconds(_loc2_);
            _loc7_ = TUtilityString.Format(STRING_OVERLAYERTITLE.FORMAT_Time,_loc3_);
            _loc6_ = int(STRING_OVERLAYERTITLE.FORMAT_Time_COLOR_LEGNTH);
         }
         else if(param1.Type == 3)
         {
            if(param1.LastTime.length > 0)
            {
               _loc7_ = TUtilityString.Format(STRING_OVERLAYERTITLE.FORMAT_Date,param1.LastTime[0],param1.LastTime[1],param1.LastTime[2]);
               _loc6_ = int(STRING_OVERLAYERTITLE.FORMAT_Date_COLOR_LEGNTH);
            }
         }
         this.FPainterTimingTime.Text = _loc7_;
         this.FTextFormatTimingTime.color = COLOR_Context_White;
         this.FPainterTimingTime.Evaluate(this.FBoundsTimingTime);
         this.FPainterTimingTime.SetTextFormat(this.FTextFormatTimingTime,_loc5_,_loc6_);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBounds = null;
         var _loc5_:TBounds = null;
         var _loc6_:TPainterTextEffect = null;
         var _loc7_:TTitle = null;
         _loc7_ = FContext as TTitle;
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPainterTitleName.X = FBoundsRendering.X + this.FBoundsTitleName.X;
         this.FPainterTitleName.Y = FBoundsRendering.Y + this.FBoundsTitleName.Y;
         this.FPainterUseLevel.X = FBoundsRendering.X + this.FBoundsUseLevel.X;
         this.FPainterUseLevel.Y = FBoundsRendering.Y + this.FBoundsUseLevel.Y;
         this.FPainterVipLevel.X = FBoundsRendering.X + this.FBoundsVipLevel.X;
         this.FPainterVipLevel.Y = FBoundsRendering.Y + this.FBoundsVipLevel.Y;
         this.FDividingLinePartCaption.x = FBoundsRendering.X + this.FBoundsPartCaption.X - FMarginLeft + SIZE_DividingLineOffset;
         this.FDividingLinePartCaption.y = FBoundsRendering.Y + this.FBoundsPartCaption.Y;
         this.FPainterDescCaption.X = FBoundsRendering.X + this.FBoundsDescCaption.X;
         this.FPainterDescCaption.Y = FBoundsRendering.Y + this.FBoundsDescCaption.Y;
         this.FPainterTitleDesc.X = FBoundsRendering.X + this.FBoundsTitleDesc.X;
         this.FPainterTitleDesc.Y = FBoundsRendering.Y + this.FBoundsTitleDesc.Y;
         this.FDividingLinePartDesc.x = FBoundsRendering.X + this.FBoundsPartDesc.X - FMarginLeft + SIZE_DividingLineOffset;
         this.FDividingLinePartDesc.y = FBoundsRendering.Y + this.FBoundsPartDesc.Y;
         this.FPainterAddValueCaption.X = FBoundsRendering.X + this.FBoundsAddValueCaption.X;
         this.FPainterAddValueCaption.Y = FBoundsRendering.Y + this.FBoundsAddValueCaption.Y;
         _loc3_ = int(CAPACITY_AppendAttributes);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = this.FPainterAppendAttributes[_loc2_];
            _loc4_ = this.FBoundsAppendAttributes[_loc2_];
            _loc6_.X = FBoundsRendering.X + _loc4_.X;
            _loc6_.Y = FBoundsRendering.Y + _loc4_.Y;
            _loc2_++;
         }
         this.FDividingLinePartAddValue.x = FBoundsRendering.X + this.FBoundsPartAddValue.X - FMarginLeft + SIZE_DividingLineOffset;
         this.FDividingLinePartAddValue.y = FBoundsRendering.Y + this.FBoundsPartAddValue.Y;
         this.FDividingLinePartAddValue.x = FBoundsRendering.X + this.FBoundsPartAddValue.X - FMarginLeft + SIZE_DividingLineOffset;
         this.FDividingLinePartAddValue.y = FBoundsRendering.Y + this.FBoundsPartAddValue.Y;
         this.FPainterTimingTime.X = FBoundsRendering.X + this.FBoundsTimingTime.X;
         this.FPainterTimingTime.Y = FBoundsRendering.Y + this.FBoundsTimingTime.Y;
         this.FDividingLinePartCaption.width = SIZE_DividingLine_Max_Width;
         this.FDividingLinePartDesc.width = SIZE_DividingLine_Max_Width;
         this.FDividingLinePartAddValue.width = SIZE_DividingLine_Max_Width;
      }
      
      override public function Show() : void
      {
         if(FContext == null)
         {
            return;
         }
         super.Show();
      }
   }
}

