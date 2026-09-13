package Rendering.Overlayers.Taboo
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TTabooAddition;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_TABOO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TABOO;
   
   public class TOverThreeOverTip extends TOverlayer
   {
      
      protected static const COLOR_Context_YELLOW:uint = 4294967040;
      
      protected var Cur_Arr:Array;
      
      protected var FDec1:TPainterTextEffect;
      
      protected var FDec2:TPainterTextEffect;
      
      protected var FDec3:TPainterTextEffect;
      
      protected var FBounds1:TBounds;
      
      protected var FBounds2:TBounds;
      
      protected var FBounds3:TBounds;
      
      public function TOverThreeOverTip(param1:TUIComponent)
      {
         super(param1);
         this.FDec1 = ConstructPainterTextEffect(COLOR_Context_YELLOW);
         this.FBounds1 = new TBounds();
         this.FDec2 = ConstructPainterTextEffect(COLOR_Context_YELLOW);
         this.FBounds2 = new TBounds();
         this.FDec3 = ConstructPainterTextEffect(COLOR_Context_YELLOW);
         this.FBounds3 = new TBounds();
         FMarginLeft = 10;
         FMarginTop = 10;
         FMarginRight = 10;
         FMarginBottom = 10;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         this.Cur_Arr = FContext as Array;
         this.EvaluationPerform_Dec();
      }
      
      protected function EvaluationPerform_Dec() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TTabooAddition = null;
         _loc1_ = CONST_TABOO.Configuration_Base + this.Cur_Arr[0] * 1000 + this.Cur_Arr[1];
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TabooAddition,_loc1_) as TTabooAddition;
         BoundsAlignDown(this.FBounds1);
         this.FDec1.Text = this.Cur_Arr[2] ? TUtilityString.Format(STRING_TABOO.Str13,_loc2_.Name) : TUtilityString.Format(STRING_TABOO.Str12,_loc2_.Name);
         this.FDec1.Evaluate(this.FBounds1);
         BoundsContextUnion(this.FBounds1);
         BoundsAlignDown(this.FBounds2);
         this.FDec2.Text = TUtilityString.Format(STRING_TABOO.Str14,this.Cur_Arr[3],this.Cur_Arr[1] + 3 - this.Cur_Arr[3]);
         this.FDec2.Evaluate(this.FBounds2);
         BoundsContextUnion(this.FBounds2);
         var _loc3_:String = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc2_.AddEffectArr[0][0])];
         if(_loc2_.AddEffectArr.length > 1)
         {
            _loc3_ = STRING_TABOO.Str23;
         }
         BoundsAlignDown(this.FBounds3);
         this.FDec3.Text = TUtilityString.Format(STRING_TABOO.Str15,_loc2_.Name,_loc3_,_loc2_.AddEffectArr[0][1]);
         this.FDec3.Evaluate(this.FBounds3);
         BoundsContextUnion(this.FBounds3);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FDec1.X = FBoundsRendering.X + this.FBounds1.X;
         this.FDec1.Y = FBoundsRendering.Y + this.FBounds1.Y;
         this.FDec2.X = FBoundsRendering.X + this.FBounds2.X;
         this.FDec2.Y = FBoundsRendering.Y + this.FBounds2.Y;
         this.FDec3.X = FBoundsRendering.X + this.FBounds3.X;
         this.FDec3.Y = FBoundsRendering.Y + this.FBounds3.Y;
      }
      
      override public function Show() : void
      {
         this.visible = true;
      }
      
      override public function Hide() : void
      {
         this.visible = false;
      }
   }
}

