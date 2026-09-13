package Rendering.Overlayers.Inventories
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Strings.STRING_JADE;
   
   public class TOverJadeTunShiLittleTip extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_01:uint = 4291545959;
      
      protected var FPName:TPainterTextEffect;
      
      protected var FBName:TBounds;
      
      protected var FPExp:TPainterTextEffect;
      
      protected var FBExp:TBounds;
      
      public function TOverJadeTunShiLittleTip(param1:TUIComponent)
      {
         super(param1);
         this.FPName = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBName = new TBounds();
         this.FPExp = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBExp = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:TInventory = FContext as TInventory;
         this.SetValue(_loc1_);
      }
      
      protected function SetValue(param1:TInventory) : void
      {
         var _loc2_:String = null;
         _loc2_ = param1.Name;
         BoundsAlignDown(this.FBName);
         this.FPName.Text = _loc2_;
         this.FPName.Evaluate(this.FBName);
         BoundsContextUnion(this.FBName);
         if((FContext as TInventory).IDTemplate == 14510001)
         {
            _loc2_ = TUtilityString.Format(STRING_JADE.STRING_JingYan1,SLogicsCore.LostShenQiLogicData.GetTunShiExpById(param1.IDTemplate));
         }
         else
         {
            _loc2_ = TUtilityString.Format(STRING_JADE.STRING_JingYan,SLogicsCore.LostShenQiLogicData.GetTunShiExpById(param1.IDTemplate));
         }
         BoundsAlignDown(this.FBExp);
         this.FPExp.Text = _loc2_;
         this.FPExp.Evaluate(this.FBExp);
         BoundsContextUnion(this.FBExp);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPName.X = FBoundsRendering.X + this.FBName.X;
         this.FPName.Y = FBoundsRendering.Y + this.FBName.Y;
         this.FPExp.X = FBoundsRendering.X + this.FBExp.X;
         this.FPExp.Y = FBoundsRendering.Y + this.FBExp.Y;
      }
   }
}

