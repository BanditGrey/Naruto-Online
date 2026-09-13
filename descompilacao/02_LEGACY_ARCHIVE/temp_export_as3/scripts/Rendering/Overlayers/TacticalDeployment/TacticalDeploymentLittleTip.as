package Rendering.Overlayers.TacticalDeployment
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.DatebaseVO.VO.TBloodSoul_Attr;
   import Processors.Game.Lobby.BloodSoulPurgatory.DataStructureForBloodSoul;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_TONGLING;
   
   public class TacticalDeploymentLittleTip extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4293708148;
      
      public static const Four:int = 4;
      
      protected var scrP:TPainterTextEffect;
      
      protected var scrB:TBounds;
      
      protected var BloodSoul_Attr:TBins;
      
      protected var FVecInt:Vector.<int>;
      
      protected var ScrHtml:String = STRING_TONGLING.TONGLING_23 + " +0" + "\n" + STRING_TONGLING.TONGLING_22 + " +0" + "\n" + STRING_TONGLING.TONGLING_24 + " +0" + "\n";
      
      public function TacticalDeploymentLittleTip(param1:TUIComponent)
      {
         super(param1);
         this.FVecInt = new Vector.<int>(Four);
         this.scrP = ConstructPainterTextEffect(COLOR_Context_White);
         this.scrB = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         BoundsAlignDown(this.scrB);
         this.scrP.Text = this.ScrHtml;
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
      
      public function UpdataValue(param1:Vector.<DataStructureForBloodSoul>) : void
      {
         var _loc2_:int = 0;
         var _loc4_:String = null;
         if(param1 == null)
         {
            return;
         }
         this.BloodSoul_Attr = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BloodPurgatory_Attr);
         var _loc3_:String = "";
         _loc2_ = 0;
         while(_loc2_ < Four)
         {
            this.FVecInt[_loc2_] = this.GetLifeAllBySoureId(param1[_loc2_].SoulId);
            switch(_loc2_)
            {
               case 0:
                  _loc4_ = STRING_TONGLING.TONGLING_23;
                  break;
               case 1:
                  _loc4_ = STRING_TONGLING.TONGLING_22;
                  break;
               case 2:
                  _loc4_ = STRING_TONGLING.TONGLING_24;
                  break;
               case 3:
                  _loc4_ = STRING_TONGLING.TONGLING_255;
            }
            _loc3_ = _loc3_ + _loc4_ + " +" + this.FVecInt[_loc2_] + "\n";
            _loc2_++;
         }
         this.ScrHtml = _loc3_;
      }
      
      public function GetLifeAllBySoureId(param1:int) : int
      {
         var _loc2_:TBloodSoul_Attr = null;
         _loc2_ = this.BloodSoul_Attr.GetDatebaseByIdentifier(param1) as TBloodSoul_Attr;
         var _loc3_:int = 0;
         return _loc2_.Life;
      }
   }
}

