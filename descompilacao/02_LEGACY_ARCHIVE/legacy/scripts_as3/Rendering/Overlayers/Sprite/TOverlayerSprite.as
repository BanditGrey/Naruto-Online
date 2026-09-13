package Rendering.Overlayers.Sprite
{
   import Foundation.Common.TAlignment;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.Json.TAddValue;
   import Logics.DatebaseVO.VO.TActivityPetConfig;
   import Rendering.Overlayers.*;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.text.TextFormat;
   
   public class TOverlayerSprite extends TOverlayer
   {
      
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
      
      protected var FPainterExplain0:TPainterTextEffect;
      
      protected var FPainterExplain1:TPainterTextEffect;
      
      protected var FPainterExplain2:TPainterTextEffect;
      
      protected var FPainterExplain3:TPainterTextEffect;
      
      protected var FPainterExplain4:TPainterTextEffect;
      
      protected var FPainterExplain5:TPainterTextEffect;
      
      protected var FBoundsExplain0:TBounds;
      
      protected var FBoundsExplain1:TBounds;
      
      protected var FBoundsExplain2:TBounds;
      
      protected var FBoundsExplain3:TBounds;
      
      protected var FBoundsExplain4:TBounds;
      
      protected var FBoundsExplain5:TBounds;
      
      protected var FContextExplain0:String;
      
      protected var FContextExplain1:String;
      
      protected var FContextExplain2:String;
      
      protected var FContextExplain3:String;
      
      protected var FContextExplain4:String;
      
      protected var FContextExplain5:String;
      
      protected var FBoundsOffsetY:TBounds;
      
      protected var FExplainTextFormat:TextFormat;
      
      protected var FTitleConfig:TActivityPetConfig;
      
      protected var FDate:Date;
      
      public function TOverlayerSprite(param1:TUIComponent)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TPainterTextEffect = null;
         var _loc5_:TBounds = null;
         super(param1);
         this.FPainterExplain0 = ConstructPainterTextEffect(COLOR_ContextDefault);
         this.FBoundsExplain0 = new TBounds();
         this.FPainterExplain1 = ConstructPainterTextEffect(COLOR_ContextDefault);
         this.FBoundsExplain1 = new TBounds();
         this.FPainterExplain2 = ConstructPainterTextEffect(QUALITYCOLOR_White);
         this.FBoundsExplain2 = new TBounds();
         this.FPainterExplain3 = ConstructPainterTextEffect(QUALITYCOLOR_Red);
         this.FBoundsExplain3 = new TBounds();
         this.FPainterExplain4 = ConstructPainterTextEffect(QUALITYCOLOR_Blue);
         this.FBoundsExplain4 = new TBounds();
         this.FPainterExplain5 = ConstructPainterTextEffect(COLOR_ContextDefault);
         this.FBoundsExplain5 = new TBounds();
         this.FExplainTextFormat = new TextFormat();
         this.FDate = new Date();
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is TActivityPetConfig;
      }
      
      override protected function ContextSynchronize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FPainterExplain0.Text = "";
         this.FContextExplain0 = "";
         this.FPainterExplain1.Text = "";
         this.FContextExplain1 = "";
         this.FPainterExplain2.Text = "";
         this.FContextExplain2 = "";
         this.FPainterExplain3.Text = "";
         this.FContextExplain3 = "";
         this.FPainterExplain4.Text = "";
         this.FContextExplain4 = "";
         this.FPainterExplain5.Text = "";
         this.FContextExplain5 = "";
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         this.EvaluationPerform_Explain0();
         this.FBoundsOffsetY = this.FBoundsExplain0;
         this.EvaluationPerform_Explain1();
         this.FBoundsOffsetY = this.FBoundsExplain1;
         this.EvaluationPerform_Explain2();
         this.FBoundsOffsetY = this.FBoundsExplain2;
         this.EvaluationPerform_Explain3();
         this.FBoundsOffsetY = this.FBoundsExplain3;
         this.EvaluationPerform_Explain4();
         this.FBoundsOffsetY = this.FBoundsExplain4;
         this.EvaluationPerform_Explain5();
         this.FBoundsOffsetY = this.FBoundsExplain5;
      }
      
      protected function EvaluationPerform_Explain0() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FTitleConfig = FContext as TActivityPetConfig;
         this.FContextExplain0 = "";
         this.FContextExplain0 = TUtilityString.Format(STRING_BASEACTIVITY.FPRMAT_NAME_STRING,this.FTitleConfig.Title);
         BoundsAlignDown(this.FBoundsExplain0);
         this.FPainterExplain0.Text = this.FContextExplain0;
         this.FPainterExplain0.Evaluate(this.FBoundsExplain0);
         BoundsContextUnion(this.FBoundsExplain0);
      }
      
      protected function EvaluationPerform_Explain1() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FTitleConfig = FContext as TActivityPetConfig;
         this.FContextExplain1 = "";
         this.FContextExplain1 = "\n" + this.FTitleConfig.TitleDesc;
         this.FContextExplain1 = this.FContextExplain1.split("%n").join("\n");
         BoundsAlignDown(this.FBoundsExplain1);
         this.FPainterExplain1.Text = this.FContextExplain1;
         this.FPainterExplain1.Evaluate(this.FBoundsExplain1);
         BoundsContextUnion(this.FBoundsExplain1);
      }
      
      protected function EvaluationPerform_Explain2() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:TAddValue = null;
         this.FTitleConfig = FContext as TActivityPetConfig;
         this.FContextExplain2 = STRING_BASEACTIVITY.FPRMAT_ADD_VALUE_STRING;
         _loc2_ = int(this.FTitleConfig.AddValues.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = this.FTitleConfig.AddValues[_loc1_];
            _loc4_ = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc5_.AddType);
            this.FContextExplain2 += " " + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc4_] + _loc5_.AddValue + "\n";
            _loc1_++;
         }
         BoundsAlignDown(this.FBoundsExplain2);
         this.FPainterExplain2.Text = this.FContextExplain2;
         this.FPainterExplain2.Evaluate(this.FBoundsExplain2);
         BoundsContextUnion(this.FBoundsExplain2);
      }
      
      protected function EvaluationPerform_Explain3() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FTitleConfig = FContext as TActivityPetConfig;
         this.FContextExplain3 = "";
         this.FContextExplain3 = "\n" + this.FTitleConfig.Title2Desc;
         this.FContextExplain3 = this.FContextExplain3.split("%n").join("\n");
         BoundsAlignDown(this.FBoundsExplain3);
         this.FPainterExplain3.Text = this.FContextExplain3;
         this.FPainterExplain3.Evaluate(this.FBoundsExplain3);
         BoundsContextUnion(this.FBoundsExplain3);
      }
      
      protected function EvaluationPerform_Explain4() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FTitleConfig = FContext as TActivityPetConfig;
         this.FContextExplain4 = "";
         this.FContextExplain4 = "\n" + this.FTitleConfig.Title3Desc;
         this.FContextExplain4 = this.FContextExplain4.split("%n").join("\n");
         BoundsAlignDown(this.FBoundsExplain4);
         this.FPainterExplain4.Text = this.FContextExplain4;
         this.FPainterExplain4.Evaluate(this.FBoundsExplain4);
         BoundsContextUnion(this.FBoundsExplain4);
      }
      
      protected function EvaluationPerform_Explain5() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         this.FTitleConfig = FContext as TActivityPetConfig;
         this.FContextExplain5 = STRING_BASEACTIVITY.FPRMAT_END_TIME_STRING;
         if(this.FTitleConfig.Type == 2)
         {
            this.FContextExplain5 += STRING_BASEACTIVITY.FORMAT_ALLWAYS_STRING;
         }
         else
         {
            _loc2_ = int(this.FTitleConfig.LastTime.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               if(_loc1_ < _loc2_ - 1)
               {
                  this.FContextExplain5 += this.FTitleConfig.LastTime[_loc1_] + "-";
               }
               else
               {
                  this.FContextExplain5 += this.FTitleConfig.LastTime[_loc1_] + "\n";
               }
               _loc1_++;
            }
         }
         BoundsAlignDown(this.FBoundsExplain5);
         this.FPainterExplain5.Text = this.FContextExplain5;
         this.FPainterExplain5.Evaluate(this.FBoundsExplain5);
         BoundsContextUnion(this.FBoundsExplain5);
      }
      
      override protected function SketchingPerform_Context() : void
      {
         this.SketchingPerform_Explain0();
         this.SketchingPerform_Explain1();
         this.SketchingPerform_Explain2();
         this.SketchingPerform_Explain3();
         this.SketchingPerform_Explain4();
         this.SketchingPerform_Explain5();
      }
      
      protected function SketchingPerform_Explain0() : void
      {
         this.FPainterExplain0.RenderBounds(this.FBoundsExplain0,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Explain1() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         this.FPainterExplain1.RenderBounds(this.FBoundsExplain1,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Explain2() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.FPainterExplain2.RenderBounds(this.FBoundsExplain2,TAlignment.HORIZONTAL_Center);
         this.FExplainTextFormat.color = QUALITYCOLOR_Green;
         _loc1_ = this.FContextExplain2.indexOf(":") + 1;
         this.FPainterExplain2.SetTextFormat(this.FExplainTextFormat,_loc1_,this.FContextExplain2.length - 1);
      }
      
      protected function SketchingPerform_Explain3() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         this.FPainterExplain3.RenderBounds(this.FBoundsExplain3,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Explain4() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         this.FPainterExplain4.RenderBounds(this.FBoundsExplain4,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Explain5() : void
      {
         this.FPainterExplain5.RenderBounds(this.FBoundsExplain5,TAlignment.HORIZONTAL_Center);
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
         this.FPainterExplain1.x = FBoundsRendering.X;
         this.FPainterExplain1.y = FBoundsRendering.Y + this.FBoundsExplain1.Y;
         this.FPainterExplain2.x = FBoundsRendering.X;
         this.FPainterExplain2.y = FBoundsRendering.Y + this.FBoundsExplain2.Y;
         this.FPainterExplain3.x = FBoundsRendering.X;
         this.FPainterExplain3.y = FBoundsRendering.Y + this.FBoundsExplain3.Y;
         this.FPainterExplain4.x = FBoundsRendering.X;
         this.FPainterExplain4.y = FBoundsRendering.Y + this.FBoundsExplain4.Y;
         this.FPainterExplain5.x = FBoundsRendering.X;
         this.FPainterExplain5.y = FBoundsRendering.Y + this.FBoundsExplain5.Y;
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

