package Rendering.Overlayers.Wing
{
   import Foundation.Common.TAlignment;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TWingAdvanced;
   import Logics.DatebaseVO.VO.TWingUpgrade;
   import Logics.Inventories.TInventory;
   import Logics.Wing.TWing;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Rendering.Overlayers.*;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_WING;
   import flash.display.Bitmap;
   import flash.text.TextFormat;
   import ghostcat.util.data.Json;
   
   public class TOverlayerWing extends TOverlayer
   {
      
      protected static const SIZE_DividingLineOffset:uint = 3;
      
      protected static const SIZE_Padding_02:uint = 5;
      
      protected static const SIZE_DividingLine_Max_Width:uint = 280;
      
      protected static const SIZE_DividingLine_Min_Width:uint = 270;
      
      protected static const COLOR_ContextOddsAward:uint = 4294967295;
      
      protected static const COLOR_ContextRobbed:uint = 4284900966;
      
      protected static const QUALITYCOLOR_None:uint = 4294967295;
      
      protected static const QUALITYCOLOR_White:uint = 4294967295;
      
      protected static const QUALITYCOLOR_Green:uint = 4285071106;
      
      protected static const QUALITYCOLOR_Blue:uint = 4278228735;
      
      protected static const QUALITYCOLOR_Purple:uint = 4288217295;
      
      protected static const QUALITYCOLOR_Yellow:uint = 4294967040;
      
      protected static const QUALITYCOLOR_Red:uint = 4294836224;
      
      protected static const QUALITYCOLOR_Orange:uint = 4294901888;
      
      public static const QUALITYCOLOR_INDEX:Vector.<uint> = Vector.<uint>([QUALITYCOLOR_None,QUALITYCOLOR_White,QUALITYCOLOR_Green,QUALITYCOLOR_Blue,QUALITYCOLOR_Purple,QUALITYCOLOR_Yellow,QUALITYCOLOR_Red,QUALITYCOLOR_Orange]);
      
      public static const FORWARD_COUNT:uint = 4;
      
      public static const MIDDLE_COUNT:uint = 2;
      
      public static const BACK_COUNT:uint = 2;
      
      protected var FPainterExplain0:TPainterTextEffect;
      
      protected var FPainterExplain1:TPainterTextEffect;
      
      protected var FPainterExplain2:TPainterTextEffect;
      
      protected var FPainterExplain3:TPainterTextEffect;
      
      protected var FBoundsExplain0:TBounds;
      
      protected var FBoundsExplain1:TBounds;
      
      protected var FBoundsExplain2:TBounds;
      
      protected var FBoundsExplain3:TBounds;
      
      protected var FContextExplain0:String;
      
      protected var FContextExplain1:String;
      
      protected var FContextExplain2:String;
      
      protected var FContextExplain3:String;
      
      protected var FBoundsOffsetY:TBounds;
      
      protected var FExplainTextFormat:TextFormat;
      
      protected var FDividingLinePartCaption:Bitmap;
      
      protected var FBoundsPartCaption:TBounds;
      
      protected var FWing:TWing;
      
      public function TOverlayerWing(param1:TUIComponent)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TPainterTextEffect = null;
         var _loc5_:TBounds = null;
         super(param1);
         this.FPainterExplain0 = ConstructPainterTextEffect(COLOR_ContextDefault);
         this.FBoundsExplain0 = new TBounds();
         this.FPainterExplain1 = ConstructPainterTextEffect(QUALITYCOLOR_Green);
         this.FBoundsExplain1 = new TBounds();
         this.FPainterExplain2 = ConstructPainterTextEffect(QUALITYCOLOR_None);
         this.FBoundsExplain2 = new TBounds();
         this.FPainterExplain3 = ConstructPainterTextEffect(COLOR_ContextDefault);
         this.FBoundsExplain3 = new TBounds();
         this.FDividingLinePartCaption = new Bitmap();
         addChild(this.FDividingLinePartCaption);
         this.FBoundsPartCaption = new TBounds();
         this.FExplainTextFormat = new TextFormat();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FDividingLinePartCaption.bitmapData = FDividingLine;
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is TWing;
      }
      
      override protected function ContextSynchronize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FPainterExplain0.Text = "";
         this.FContextExplain0 = "";
         this.FDividingLinePartCaption.width = SIZE_DividingLine_Min_Width;
         this.FPainterExplain1.Text = "";
         this.FContextExplain1 = "";
         this.FPainterExplain2.Text = "";
         this.FContextExplain2 = "";
         this.FPainterExplain3.Text = "";
         this.FContextExplain3 = "";
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         this.EvaluationPerform_Explain0();
         this.FBoundsOffsetY = this.FBoundsExplain0;
         this.EvaluationPerform_PartCaption();
         this.FBoundsOffsetY = this.FBoundsPartCaption;
         this.EvaluationPerform_Explain1();
         this.FBoundsOffsetY = this.FBoundsExplain1;
      }
      
      protected function EvaluationPerform_Explain0() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TWingUpgrade = null;
         var _loc6_:Array = null;
         this.FWing = FContext as TWing;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_WingUpgrade,this.FWing.WingID) as TWingUpgrade;
         this.FContextExplain0 = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_026).DescribeString + _loc5_.name + "\n";
         _loc6_ = Json.decode(_loc5_.addAttribute);
         _loc1_ = 0;
         while(_loc1_ < _loc6_.length)
         {
            _loc2_ = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc6_[_loc1_][0]);
            this.FContextExplain0 += STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc2_] + "+";
            if(_loc6_[_loc1_][1] <= 3)
            {
               _loc4_ = Number(_loc6_[_loc1_][1] * 100).toFixed();
               this.FContextExplain0 += _loc4_ + "%" + "\n";
            }
            else
            {
               this.FContextExplain0 += _loc6_[_loc1_][1] + "\n";
            }
            _loc1_++;
         }
         BoundsAlignDown(this.FBoundsExplain0);
         this.FPainterExplain0.Text = this.FContextExplain0;
         this.FPainterExplain0.Evaluate(this.FBoundsExplain0);
         BoundsContextUnion(this.FBoundsExplain0);
      }
      
      protected function EvaluationPerform_PartCaption() : void
      {
         this.FBoundsPartCaption.Width = this.FDividingLinePartCaption.width;
         this.FBoundsPartCaption.Height = this.FDividingLinePartCaption.height;
         BoundsAlignDown(this.FBoundsPartCaption,this.FBoundsOffsetY,SIZE_Padding_02);
         this.FBoundsPartCaption.X = 0;
         BoundsContextUnion(this.FBoundsPartCaption);
      }
      
      protected function EvaluationPerform_Explain1() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc8_:TWingAdvanced = null;
         this.FWing = FContext as TWing;
         this.FContextExplain1 = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_027).DescribeString + "\n";
         _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_WingAdvanced,this.FWing.TransformID) as TWingAdvanced;
         if(_loc8_)
         {
            _loc5_ = Json.decode(_loc8_.additionClient);
            if(_loc5_[0].length > 0)
            {
               _loc1_ = 0;
               while(_loc1_ < _loc5_.length)
               {
                  _loc7_ = new ConsumeFrameCopy(_loc5_[_loc1_][0]).DescribeString;
                  _loc2_ = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc5_[_loc1_][1]);
                  if(_loc5_[_loc1_][2] < 1)
                  {
                     _loc4_ = _loc5_[_loc1_][2] * 100;
                     this.FContextExplain1 += TUtilityString.Format(_loc7_,STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc2_],_loc4_) + "\n";
                  }
                  else
                  {
                     this.FContextExplain1 += TUtilityString.Format(_loc7_,STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc2_],_loc5_[_loc1_][2]) + "\n";
                  }
                  _loc1_++;
               }
            }
            else
            {
               this.FContextExplain1 += new ConsumeFrameCopy(STRING_WING.WINGS_STRING_018).DescribeString + "\n";
            }
         }
         else
         {
            this.FContextExplain1 += new ConsumeFrameCopy(STRING_WING.WINGS_STRING_018).DescribeString + "\n";
         }
         BoundsAlignDown(this.FBoundsExplain1);
         this.FPainterExplain1.Text = this.FContextExplain1;
         this.FPainterExplain1.Evaluate(this.FBoundsExplain1);
         BoundsContextUnion(this.FBoundsExplain1);
      }
      
      override protected function SketchingPerform_Context() : void
      {
         this.SketchingPerform_Explain0();
         this.SketchingPerform_Explain1();
      }
      
      protected function SketchingPerform_Explain0() : void
      {
         var _loc1_:TInventory = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.FPainterExplain0.RenderBounds(this.FBoundsExplain0,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Explain1() : void
      {
         var _loc1_:TInventory = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.FPainterExplain1.RenderBounds(this.FBoundsExplain1,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Explain2() : void
      {
         var _loc1_:TInventory = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.FPainterExplain2.RenderBounds(this.FBoundsExplain2,TAlignment.HORIZONTAL_Center);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TBounds = null;
         var _loc7_:TPainterTextEffect = null;
         _loc6_ = new TBounds();
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPainterExplain0.x = FBoundsRendering.X;
         this.FPainterExplain0.y = FBoundsRendering.Y + this.FBoundsExplain0.Y;
         this.FDividingLinePartCaption.x = FBoundsRendering.X + this.FBoundsPartCaption.X - FMarginLeft + SIZE_DividingLineOffset;
         this.FDividingLinePartCaption.y = FBoundsRendering.Y + this.FBoundsPartCaption.Y;
         this.FPainterExplain1.x = FBoundsRendering.X;
         this.FPainterExplain1.y = FBoundsRendering.Y + this.FBoundsExplain1.Y;
         this.FDividingLinePartCaption.width = SIZE_DividingLine_Max_Width;
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

