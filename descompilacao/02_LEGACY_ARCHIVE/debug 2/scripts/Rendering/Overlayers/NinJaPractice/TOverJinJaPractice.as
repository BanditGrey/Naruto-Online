package Rendering.Overlayers.NinJaPractice
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.DatebaseVO.VO.TPropSwitch;
   import Logics.Inventories.TInventory;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_INHERITPRACTICE;
   
   public class TOverJinJaPractice extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_YELLOW:uint = 4294967040;
      
      protected var FPainterName:TPainterTextEffect;
      
      protected var FPainterReward:TPainterTextEffect;
      
      protected var FBoundsName:TBounds;
      
      protected var FBoundsReward:TBounds;
      
      protected var FBoundsOffset:TBounds;
      
      public function TOverJinJaPractice(param1:TUIComponent)
      {
         super(param1);
         this.FPainterName = ConstructPainterTextEffect(COLOR_Context_YELLOW);
         this.FBoundsName = new TBounds();
         this.FPainterReward = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsReward = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         _loc3_ = FContext as TInventory;
         this.EvaluationPerform_Name(_loc3_);
         this.FBoundsOffset = this.FBoundsName;
         this.EvaluationPerform_Reward(_loc3_);
         this.FBoundsOffset = this.FBoundsReward;
      }
      
      protected function EvaluationPerform_Name(param1:TInventory) : void
      {
         BoundsAlignDown(this.FBoundsName);
         this.FPainterName.Text = param1.Name;
         this.FPainterName.Evaluate(this.FBoundsName);
         BoundsContextUnion(this.FBoundsName);
      }
      
      protected function EvaluationPerform_Reward(param1:TInventory) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:TPropSwitch = null;
         _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_PropSwitch,param1.IDTemplate) as TPropSwitch;
         this.FPainterReward.Text = "";
         BoundsAlignDown(this.FBoundsReward);
         this.FPainterReward.Text = STRING_INHERITPRACTICE.INHERIT_EXP + "：" + _loc8_.ExchageExp + "\n" + STRING_INHERITPRACTICE.INHERIT_ALL_EXP + "：" + _loc8_.ExchageExp * param1.Quantity;
         this.FPainterReward.Evaluate(this.FBoundsReward);
         BoundsContextUnion(this.FBoundsReward);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPainterName.X = FBoundsRendering.X + this.FBoundsName.X;
         this.FPainterName.Y = FBoundsRendering.Y + this.FBoundsName.Y;
         this.FPainterReward.X = FBoundsRendering.X + this.FBoundsReward.X;
         this.FPainterReward.Y = FBoundsRendering.Y + this.FBoundsReward.Y;
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

