package Rendering.Overlayers.TreasureMap
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityCartisian;
   import Logics.DatebaseVO.VO.TArticle;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TTreasureProofChangTips extends TOverlayer
   {
      
      protected static const QUALITYCOLOR_White:uint = 4294967295;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var scrP:TPainterTextEffect;
      
      protected var scrB:TBounds;
      
      public function TTreasureProofChangTips(param1:TUIComponent)
      {
         super(param1);
         this.scrP = ConstructPainterTextEffect(QUALITYCOLOR_White);
         this.scrB = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:TArticle = null;
         var _loc2_:uint = 0;
         _loc2_ = FContext as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc2_) as TArticle;
         BoundsAlignDown(this.scrB);
         this.scrP.Text = _loc1_.Name;
         this.scrP.Font.Color = QUALITYCOLOR_INDEX[_loc1_.Quality];
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
      
      override protected function RenderingPerform_Position(param1:TCoordinate) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc4_ = FBoundsSubstrate.Width;
         _loc5_ = FBoundsSubstrate.Height;
         _loc2_ = param1.X + 40;
         if(_loc2_ + _loc4_ > STAGE_Width)
         {
            _loc2_ -= _loc4_ + 50;
         }
         else
         {
            _loc2_ -= 30;
         }
         _loc3_ = param1.Y;
         if(_loc3_ + _loc5_ + 30 > STAGE_Height)
         {
            _loc3_ = param1.Y - _loc5_;
         }
         if(_loc3_ < 0)
         {
            _loc3_ = param1.Y;
            _loc3_ = param1.Y - (_loc3_ + _loc5_ + 30 - STAGE_Height);
         }
         TUtilityCartisian.CoordinateSet(FCoordinateOverlay,_loc2_,_loc3_);
      }
   }
}

