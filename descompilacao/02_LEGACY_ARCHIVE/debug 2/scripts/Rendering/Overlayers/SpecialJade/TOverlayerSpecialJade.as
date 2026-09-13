package Rendering.Overlayers.SpecialJade
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSpecialStone;
   import Logics.Jade.TSpecialJade;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   
   public class TOverlayerSpecialJade extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_YELLOW:uint = 4294967040;
      
      protected static const COLOR_ContextDefault:uint = 4294958161;
      
      protected static const SIZE_DividingLine_Min_Width:uint = 135;
      
      protected var FPainterBig:TPainterTextEffect;
      
      protected var FPainterReward:TPainterTextEffect;
      
      protected var FBoundsName:TBounds;
      
      protected var FBoundsReward:TBounds;
      
      protected var FBoundsBmp:TBounds;
      
      protected var FcurHero:TSpecialJade;
      
      protected var FIdentifier:int;
      
      protected var FBoundsOffset:TBounds;
      
      public function TOverlayerSpecialJade(param1:TUIComponent)
      {
         super(param1);
         this.FPainterBig = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsName = new TBounds();
         this.FBoundsBmp = new TBounds();
         this.FPainterReward = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsReward = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override public function set Context(param1:Object) : void
      {
         super.Context = param1;
         if(!FModified && FContext != null)
         {
            FContext = param1;
            FModified = true;
         }
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:int = 0;
         this.FcurHero = FContext as TSpecialJade;
         this.FBoundsOffset = this.FBoundsName;
         BoundsAlignDown(this.FBoundsBmp);
         this.FPainterBig.Evaluate(this.FBoundsBmp);
         BoundsContextUnion(this.FBoundsBmp);
         this.FBoundsBmp.X = 0;
         this.FBoundsOffset = this.FBoundsBmp;
         this.EvaluationPerform_Reward(1);
         this.FBoundsOffset = this.FBoundsReward;
      }
      
      protected function EvaluationPerform_Reward(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TSpecialStone = null;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SpeicalJade,this.FcurHero.JadeID) as TSpecialStone;
         this.FPainterReward.Text = "";
         BoundsAlignDown(this.FBoundsReward);
         this.FPainterReward.Text = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.Qiudao_STRING_006) + "\n" + STRING_COMMON.STRINGS_SPECIAL_JADE_ATTRS[0] + "：" + _loc3_.Power + "\n" + STRING_COMMON.STRINGS_SPECIAL_JADE_ATTRS[1] + "：" + _loc3_.Agile + "\n" + STRING_COMMON.STRINGS_SPECIAL_JADE_ATTRS[2] + "：" + _loc3_.Intelligence + "\n" + STRING_COMMON.STRINGS_SPECIAL_JADE_ATTRS[3] + "：" + _loc3_.Life + "\n" + STRING_COMMON.STRINGS_SPECIAL_JADE_ATTRS[5] + "：" + _loc3_.Damagerate / 100 + "%\n" + STRING_COMMON.STRINGS_SPECIAL_JADE_ATTRS[6] + "：" + _loc3_.Avoidrate / 100 + "%";
         this.FPainterReward.Evaluate(this.FBoundsReward);
         BoundsContextUnion(this.FBoundsReward);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPainterBig.X = FBoundsRendering.X + this.FBoundsName.X;
         this.FPainterBig.Y = FBoundsRendering.Y + this.FBoundsName.Y;
         this.FPainterReward.X = FBoundsRendering.X + this.FBoundsReward.X;
         this.FPainterReward.Y = FBoundsRendering.Y + this.FBoundsReward.Y - 5;
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

