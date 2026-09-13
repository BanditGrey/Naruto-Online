package Rendering.Overlayers.TongLingAnimal
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_TONGLING;
   
   public class TongLingIntroTip extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_BLACK:uint = 4278190080;
      
      protected var FTongLingScri:TPainterTextEffect;
      
      protected var FBoundsScri:TBounds;
      
      protected var FBoundsOffset:TBounds;
      
      public function TongLingIntroTip(param1:TUIComponent)
      {
         super(param1);
         this.FTongLingScri = ConstructPainterTextEffect(COLOR_Context_White);
         this.FTongLingScri.WordWrapWidth = 150;
         this.FBoundsScri = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TBB_Status = null;
         _loc1_ = FContext as uint;
         var _loc3_:String = "";
         this.FTongLingScri.Text = "";
         BoundsAlignDown(this.FBoundsScri);
         if(_loc1_ == 7)
         {
            _loc3_ = STRING_TONGLING.TONGLING_4;
         }
         else if(_loc1_ == 8)
         {
            _loc3_ = STRING_TONGLING.TONGLING_5;
         }
         else if(_loc1_ == 9)
         {
            _loc3_ = STRING_TONGLING.TONGLING_13;
         }
         else if(_loc1_ == 10)
         {
            _loc3_ = STRING_TONGLING.TONGLING_14;
         }
         else
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,_loc1_) as TBB_Status;
            _loc3_ = _loc2_.Desc;
         }
         this.FTongLingScri.Text = _loc3_;
         this.FTongLingScri.Evaluate(this.FBoundsScri);
         BoundsContextUnion(this.FBoundsScri);
         this.FBoundsOffset = this.FBoundsScri;
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FTongLingScri.X = FBoundsRendering.X + this.FBoundsScri.X;
         this.FTongLingScri.Y = FBoundsRendering.Y + this.FBoundsScri.Y;
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

