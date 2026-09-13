package Rendering.Overlayers.Box
{
   import Foundation.Common.TAlignment;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.*;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Rendering.Overlayers.*;
   import Rendering.Texts.TPainterTextEffect;
   import flash.text.TextFormat;
   
   public class TOverlayerBox extends TOverlayer
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
      
      protected var FPainterExplain:TPainterTextEffect;
      
      protected var FBoundsExplain:TBounds;
      
      protected var FContextExplain:String;
      
      protected var FBoundsOffsetY:TBounds;
      
      protected var FExplainTextFormat:TextFormat;
      
      protected var FIDTemplates:Vector.<uint>;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TOverlayerBox(param1:TUIComponent)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TPainterTextEffect = null;
         var _loc5_:TBounds = null;
         super(param1);
         this.FPainterExplain = ConstructPainterTextEffect(COLOR_ContextDefault);
         this.FBoundsExplain = new TBounds();
         this.FExplainTextFormat = new TextFormat();
         this.FIDTemplates = new Vector.<uint>();
         this.FInventories = new TInventories();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is TInventories;
      }
      
      override protected function ContextSynchronize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FPainterExplain.Text = "";
         this.FContextExplain = "";
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         this.EvaluationPerform_Explain();
         this.FBoundsOffsetY = this.FBoundsExplain;
      }
      
      protected function EvaluationPerform_Explain() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         this.FInventories = FContext as TInventories;
         this.FContextExplain = "";
         _loc2_ = this.FInventories.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FInventories.GetInventoryByIndex(_loc1_);
            this.FContextExplain += _loc3_.Name + "*" + _loc3_.Quantity + "#\n";
            _loc1_++;
         }
         BoundsAlignDown(this.FBoundsExplain);
         this.FPainterExplain.Text = this.FContextExplain;
         this.FPainterExplain.Evaluate(this.FBoundsExplain);
         BoundsContextUnion(this.FBoundsExplain);
      }
      
      override protected function SketchingPerform_Context() : void
      {
         this.SketchingPerform_Explain();
      }
      
      protected function SketchingPerform_Explain() : void
      {
         var _loc1_:TInventory = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Vector.<uint> = null;
         var _loc6_:Vector.<uint> = null;
         _loc5_ = new Vector.<uint>();
         _loc6_ = new Vector.<uint>();
         this.FPainterExplain.RenderBounds(this.FBoundsExplain,TAlignment.HORIZONTAL_Center);
         _loc5_.push(0);
         _loc4_ = 0;
         while(_loc4_ < this.FInventories.Count)
         {
            _loc1_ = this.FInventories.GetInventoryByIndex(_loc4_);
            _loc6_.push(QUALITYCOLOR_INDEX[_loc1_.Quality]);
            _loc3_ = this.FContextExplain.indexOf("#",_loc2_ + 1);
            _loc2_ = _loc3_;
            _loc5_.push(_loc3_);
            _loc4_++;
         }
         this.FContextExplain = this.FContextExplain.split("#").join(" ");
         this.FPainterExplain.Text = this.FContextExplain;
         this.FPainterExplain.Evaluate(this.FBoundsExplain);
         _loc4_ = 0;
         while(_loc4_ < this.FInventories.Count)
         {
            this.FExplainTextFormat.color = _loc6_[_loc4_];
            this.FPainterExplain.SetTextFormat(this.FExplainTextFormat,_loc5_[_loc4_],_loc5_[_loc4_ + 1]);
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
         this.FPainterExplain.x = FBoundsRendering.X;
         this.FPainterExplain.y = FBoundsRendering.Y + this.FBoundsExplain.Y;
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

