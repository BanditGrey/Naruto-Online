package Rendering.Overlayers.SpringFestival
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
   
   public class TOverlayerFish extends TOverlayer
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
      
      protected var FIDTemplates:Vector.<uint>;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TOverlayerFish(param1:TUIComponent)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TPainterTextEffect = null;
         var _loc5_:TBounds = null;
         super(param1);
         this.FPainterExplain1 = ConstructPainterTextEffect(COLOR_ContextDefault);
         this.FBoundsExplain1 = new TBounds();
         this.FPainterExplain2 = ConstructPainterTextEffect(QUALITYCOLOR_Purple);
         this.FBoundsExplain2 = new TBounds();
         this.FPainterExplain3 = ConstructPainterTextEffect(COLOR_ContextDefault);
         this.FBoundsExplain3 = new TBounds();
         this.FExplainTextFormat = new TextFormat();
         this.FIDTemplates = new Vector.<uint>();
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
         var _loc3_:TInventories = null;
         var _loc4_:TInventory = null;
         var _loc5_:TBaseBox = null;
         _loc5_ = FContext as TBaseBox;
         this.FContextExplain3 = "";
         _loc2_ = _loc5_.Inventories.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc5_.Inventories.GetInventoryByIndex(_loc1_);
            if(_loc1_ < _loc5_.MaxVect.length && _loc5_.MaxVect[_loc1_] > 0)
            {
               this.FContextExplain3 += _loc4_.Name + " " + _loc4_.Quantity + "~" + _loc5_.MaxVect[_loc1_] + "#\n";
            }
            else
            {
               this.FContextExplain3 += _loc4_.Name + "*" + _loc4_.Quantity + "#\n";
            }
            _loc1_++;
         }
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
         var _loc1_:TInventory = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Vector.<uint> = null;
         var _loc6_:Vector.<uint> = null;
         var _loc7_:TBaseBox = null;
         var _loc8_:TInventories = null;
         _loc7_ = FContext as TBaseBox;
         _loc5_ = new Vector.<uint>();
         _loc6_ = new Vector.<uint>();
         this.FPainterExplain3.RenderBounds(this.FBoundsExplain3,TAlignment.HORIZONTAL_Center);
         _loc5_.push(0);
         _loc8_ = _loc7_.Inventories;
         _loc4_ = 0;
         while(_loc4_ < _loc8_.Count)
         {
            _loc1_ = _loc8_.GetInventoryByIndex(_loc4_);
            _loc6_.push(QUALITYCOLOR_INDEX[_loc1_.Quality]);
            _loc3_ = this.FContextExplain3.indexOf("#",_loc2_ + 1);
            _loc2_ = _loc3_;
            _loc5_.push(_loc3_);
            _loc4_++;
         }
         this.FContextExplain3 = this.FContextExplain3.split("#").join(" ");
         this.FPainterExplain3.Text = this.FContextExplain3;
         this.FPainterExplain3.Evaluate(this.FBoundsExplain3);
         _loc4_ = 0;
         while(_loc4_ < _loc8_.Count)
         {
            this.FExplainTextFormat.color = _loc6_[_loc4_];
            this.FPainterExplain3.SetTextFormat(this.FExplainTextFormat,_loc5_[_loc4_],_loc5_[_loc4_ + 1]);
            _loc4_++;
         }
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

