package Rendering.Overlayers.TongLingAnimal
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_INHERITPRACTICE;
   import Resources.Strings.STRING_TONGLING;
   
   public class LittleTip extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected var Vec:Vector.<Object>;
      
      protected var scrP:TPainterTextEffect;
      
      protected var scrB:TBounds;
      
      public function LittleTip(param1:TUIComponent)
      {
         super(param1);
         var _loc2_:TConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_Buy) as TConfigValue;
         this.Vec = _loc2_.Value as Vector.<Object>;
         this.scrP = ConstructPainterTextEffect(COLOR_Context_White);
         this.scrB = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:int = 0;
         _loc1_ = FContext as int;
         BoundsAlignDown(this.scrB);
         this.scrP.Text = STRING_TONGLING.TONGLING_XIAOHAO + this.Vec[_loc1_][1] + this.MoneyUint(this.Vec[_loc1_][0]) + STRING_TONGLING.TONGLING_OpneLanwei;
         this.scrP.Evaluate(this.scrB);
         BoundsContextUnion(this.scrB);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.scrP.X = FBoundsRendering.X + this.scrB.X;
         this.scrP.Y = FBoundsRendering.Y + this.scrB.Y;
      }
      
      override public function Show() : void
      {
         if(FContext == null)
         {
            return;
         }
         super.Show();
      }
      
      public function MoneyUint(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case 0:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_SILVER_COIN;
               break;
            case 1:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_GOLD;
               break;
            case 2:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_GIFT;
               break;
            case 3:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_GOLD;
         }
         return _loc2_;
      }
   }
}

