package Rendering.Overlayers.Christmas
{
   import Foundation.Common.TAlignment;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.*;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Rendering.Overlayers.*;
   import Rendering.Texts.TPainterTextEffect;
   import flash.text.TextFormat;
   
   public class TOverlayerThreeStr extends TOverlayer
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
      
      public const Item_ID:Vector.<uint>;
      
      protected var FPainterExplain1:TPainterTextEffect;
      
      protected var FPainterExplain2:TPainterTextEffect;
      
      protected var FPainterExplain3:TPainterTextEffect;
      
      protected var FBoundsExplain1:TBounds;
      
      protected var FBoundsExplain2:TBounds;
      
      protected var FBoundsExplain3:TBounds;
      
      protected var FContextExplain1:String;
      
      protected var FContextExplain2:String;
      
      protected var FContextExplain3:String;
      
      protected var FBoundsOffsetY:TBounds;
      
      protected var FExplainTextFormat:TextFormat;
      
      protected var FBaseBox:TBaseBox;
      
      protected var FIDTemplates:Vector.<uint>;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TOverlayerThreeStr(param1:TUIComponent)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TPainterTextEffect = null;
         var _loc5_:TBounds = null;
         this.Item_ID = Vector.<uint>([14101081,14101082,14101083,14101084,14101085]);
         super(param1);
         this.FPainterExplain1 = ConstructPainterTextEffect(COLOR_ContextDefault);
         this.FBoundsExplain1 = new TBounds();
         this.FPainterExplain2 = ConstructPainterTextEffect(QUALITYCOLOR_Purple);
         this.FBoundsExplain2 = new TBounds();
         this.FPainterExplain3 = ConstructPainterTextEffect(COLOR_ContextDefault);
         this.FBoundsExplain3 = new TBounds();
         this.FExplainTextFormat = new TextFormat();
         this.FIDTemplates = new Vector.<uint>();
         this.FInventories = new TInventories();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is TBaseBox;
      }
      
      override protected function ContextSynchronize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FPainterExplain1.Text = "";
         this.FContextExplain1 = "";
         this.FPainterExplain2.Text = "";
         this.FContextExplain2 = "";
         this.FPainterExplain3.Text = "";
         this.FContextExplain3 = "";
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         this.EvaluationPerform_Explain1();
         this.FBoundsOffsetY = this.FBoundsExplain1;
         this.EvaluationPerform_Explain2();
         this.FBoundsOffsetY = this.FBoundsExplain2;
         this.EvaluationPerform_Explain3();
         this.FBoundsOffsetY = this.FBoundsExplain3;
      }
      
      protected function EvaluationPerform_Explain1() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc3_ = FContext as TBaseBox;
         this.FContextExplain1 = "";
         this.FContextExplain1 = "\n" + _loc3_.Desc1;
         this.FContextExplain1 = this.FContextExplain1.split("%n").join("\n");
         BoundsAlignDown(this.FBoundsExplain1);
         this.FPainterExplain1.Text = this.FContextExplain1;
         this.FPainterExplain1.Evaluate(this.FBoundsExplain1);
         BoundsContextUnion(this.FBoundsExplain1);
      }
      
      protected function EvaluationPerform_Explain2() : void
      {
         var _loc1_:TBaseBox = null;
         _loc1_ = FContext as TBaseBox;
         this.FContextExplain2 = "";
         this.FContextExplain2 = "\n" + _loc1_.Desc2;
         this.FContextExplain2 = this.FContextExplain2.split("%n").join("\n");
         BoundsAlignDown(this.FBoundsExplain2);
         this.FPainterExplain2.Text = this.FContextExplain2;
         this.FPainterExplain2.Evaluate(this.FBoundsExplain2);
         BoundsContextUnion(this.FBoundsExplain2);
      }
      
      protected function EvaluationPerform_Explain3() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         var _loc4_:TBaseBox = null;
         _loc4_ = FContext as TBaseBox;
         this.FContextExplain3 = "";
         this.FContextExplain3 = "\n" + _loc4_.Desc3;
         this.FContextExplain3 = this.FContextExplain3.split("%n").join("\n");
         BoundsAlignDown(this.FBoundsExplain3);
         this.FPainterExplain3.Text = this.FContextExplain3;
         this.FPainterExplain3.Evaluate(this.FBoundsExplain3);
         BoundsContextUnion(this.FBoundsExplain3);
      }
      
      override protected function SketchingPerform_Context() : void
      {
         this.SketchingPerform_Explain1();
         this.SketchingPerform_Explain2();
         this.SketchingPerform_Explain3();
      }
      
      protected function SketchingPerform_Explain1() : void
      {
         this.FPainterExplain1.RenderBounds(this.FBoundsExplain1,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Explain2() : void
      {
         this.FPainterExplain2.RenderBounds(this.FBoundsExplain2,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Explain3() : void
      {
         this.FPainterExplain3.RenderBounds(this.FBoundsExplain3,TAlignment.HORIZONTAL_Center);
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
         this.FPainterExplain1.x = FBoundsRendering.X;
         this.FPainterExplain1.y = FBoundsRendering.Y + this.FBoundsExplain1.Y;
         this.FPainterExplain2.x = FBoundsRendering.X;
         this.FPainterExplain2.y = FBoundsRendering.Y + this.FBoundsExplain2.Y;
         this.FPainterExplain3.x = FBoundsRendering.X;
         this.FPainterExplain3.y = FBoundsRendering.Y + this.FBoundsExplain3.Y;
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

