package Rendering.Overlayers.Inventories
{
   import Foundation.Common.Integer.UInt64;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Strings.STRING_SHORTCUTS;
   
   public class TOverWindowFunctionTip extends TOverlayer
   {
      
      protected static const COLOR_Context_AppendAttributes:uint = 4284940032;
      
      protected var P1:TPainterTextEffect;
      
      protected var B1:TBounds;
      
      protected var P2:TPainterTextEffect;
      
      protected var B2:TBounds;
      
      protected var CurCount:int;
      
      protected var CurExP:UInt64;
      
      public function TOverWindowFunctionTip(param1:TUIComponent)
      {
         super(param1);
         this.P1 = ConstructPainterTextEffect(COLOR_Context_AppendAttributes);
         this.B1 = new TBounds();
         this.P2 = ConstructPainterTextEffect(COLOR_Context_AppendAttributes);
         this.B2 = new TBounds();
         this.CurExP = new UInt64();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         _loc1_ = int(FContext);
         _loc2_ = SLogicsCore.Character.ConfigArrInformation[_loc1_];
         _loc3_ = _loc2_[1][0];
         this.CurExP = UInt64.ParseUInt64(String(_loc2_[0]));
         this.CurCount = _loc3_["amount"];
         this.dec1();
         this.dec2();
      }
      
      protected function dec1() : void
      {
         BoundsAlignDown(this.B1);
         this.P1.Text = TUtilityString.Format(STRING_SHORTCUTS.STRING_NORMAL_FUCK1,this.CurExP.ToNumber());
         this.P1.Evaluate(this.B1);
         BoundsContextUnion(this.B1);
      }
      
      protected function dec2() : void
      {
         BoundsAlignDown(this.B2);
         this.P2.Text = TUtilityString.Format(STRING_SHORTCUTS.STRING_NORMAL_FUCK2,SLogicsCore.Character.ConfigArrInformationName,this.CurCount);
         this.P2.Evaluate(this.B2);
         BoundsContextUnion(this.B2);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.P1.X = FBoundsRendering.X + this.B1.X;
         this.P1.Y = FBoundsRendering.Y + this.B1.Y;
         this.P2.x = FBoundsRendering.X + this.B2.X;
         this.P2.y = FBoundsRendering.Y + this.B2.Y;
      }
      
      override protected function ContextModified() : Boolean
      {
         return true;
      }
   }
}

