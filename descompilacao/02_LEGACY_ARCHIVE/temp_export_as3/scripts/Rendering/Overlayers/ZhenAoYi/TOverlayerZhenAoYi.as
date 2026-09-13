package Rendering.Overlayers.ZhenAoYi
{
   import Foundation.Common.TAlignment;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSkillReform;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Rendering.Overlayers.*;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Strings.STRING_UNDERTOWN;
   import flash.text.TextFormat;
   
   public class TOverlayerZhenAoYi extends TOverlayer
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
      
      protected var FBoundsExplain0:TBounds;
      
      protected var FBoundsExplain1:TBounds;
      
      protected var FBoundsExplain2:TBounds;
      
      protected var FContextExplain0:String;
      
      protected var FContextExplain1:String;
      
      protected var FContextExplain2:String;
      
      protected var FBoundsOffsetY:TBounds;
      
      protected var FExplainTextFormat:TextFormat;
      
      protected var FSkillReform:TSkillReform;
      
      protected var FIsMax:Boolean;
      
      public function TOverlayerZhenAoYi(param1:TUIComponent)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TPainterTextEffect = null;
         var _loc5_:TBounds = null;
         super(param1);
         this.FPainterExplain0 = ConstructPainterTextEffect(COLOR_ContextDefault);
         this.FPainterExplain1 = ConstructPainterTextEffect(QUALITYCOLOR_Blue);
         this.FPainterExplain2 = ConstructPainterTextEffect(QUALITYCOLOR_Green);
         this.FBoundsExplain0 = new TBounds();
         this.FBoundsExplain1 = new TBounds();
         this.FBoundsExplain2 = new TBounds();
         this.FExplainTextFormat = new TextFormat();
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is TSkillReform;
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
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         this.EvaluationPerform_Explain0();
         this.FBoundsOffsetY = this.FBoundsExplain0;
         this.EvaluationPerform_Explain1();
         this.FBoundsOffsetY = this.FBoundsExplain1;
         this.EvaluationPerform_Explain2();
         this.FBoundsOffsetY = this.FBoundsExplain2;
      }
      
      protected function EvaluationPerform_Explain0() : void
      {
         this.FSkillReform = FContext as TSkillReform;
         this.FContextExplain0 = this.FSkillReform.Name + " LV." + this.FSkillReform.Level;
         BoundsAlignDown(this.FBoundsExplain0);
         this.FPainterExplain0.Text = this.FContextExplain0;
         this.FPainterExplain0.Evaluate(this.FBoundsExplain0);
         BoundsContextUnion(this.FBoundsExplain0);
      }
      
      protected function EvaluationPerform_Explain1() : void
      {
         this.FSkillReform = FContext as TSkillReform;
         this.FContextExplain1 = this.FSkillReform.Description.split("%n%").join("\n");
         BoundsAlignDown(this.FBoundsExplain1);
         this.FPainterExplain1.Text = this.FContextExplain1;
         this.FPainterExplain1.Evaluate(this.FBoundsExplain1);
         BoundsContextUnion(this.FBoundsExplain1);
      }
      
      protected function EvaluationPerform_Explain2() : void
      {
         this.FSkillReform = FContext as TSkillReform;
         if(this.FIsMax)
         {
            this.FContextExplain2 = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_29).DescribeString;
         }
         else
         {
            this.FContextExplain2 = TUtilityString.Format(new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_28).DescribeString,this.FSkillReform.ConsumeVector[0][1]);
         }
         BoundsAlignDown(this.FBoundsExplain2);
         this.FPainterExplain2.Text = this.FContextExplain2;
         this.FPainterExplain2.Evaluate(this.FBoundsExplain2);
         BoundsContextUnion(this.FBoundsExplain2);
      }
      
      override protected function SketchingPerform_Context() : void
      {
         this.SketchingPerform_Explain0();
         this.SketchingPerform_Explain1();
         this.SketchingPerform_Explain2();
      }
      
      protected function SketchingPerform_Explain0() : void
      {
         this.FPainterExplain0.RenderBounds(this.FBoundsExplain0,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Explain1() : void
      {
         this.FPainterExplain1.RenderBounds(this.FBoundsExplain1,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Explain2() : void
      {
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
         this.FPainterExplain1.x = FBoundsRendering.X;
         this.FPainterExplain1.y = FBoundsRendering.Y + this.FBoundsExplain1.Y;
         this.FPainterExplain2.x = FBoundsRendering.X;
         this.FPainterExplain2.y = FBoundsRendering.Y + this.FBoundsExplain2.Y;
      }
      
      override public function Show() : void
      {
         if(FContext == null)
         {
            return;
         }
         super.Show();
      }
      
      public function get IsMax() : Boolean
      {
         return this.FIsMax;
      }
      
      public function set IsMax(param1:Boolean) : void
      {
         this.FIsMax = param1;
      }
   }
}

