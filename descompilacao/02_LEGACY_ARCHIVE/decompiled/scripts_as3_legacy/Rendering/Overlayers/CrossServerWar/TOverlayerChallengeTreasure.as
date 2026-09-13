package Rendering.Overlayers.CrossServerWar
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Logics.DatebaseVO.VO.Json.TCrossServerWarReward;
   import Logics.DatebaseVO.VO.TGSPVP_Reward;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_OVERLAYERCROSSSERVERWAR;
   
   public class TOverlayerChallengeTreasure extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_Invalid:uint = 4286611584;
      
      protected static const COLOR_Context_03:uint = 4294890346;
      
      protected static const COLOR_Context_04:uint = 16737792;
      
      protected static const COLOR_Context_Green:uint = 4284940032;
      
      protected var FPainterName:TPainterTextEffect;
      
      protected var FPainterReward:TPainterTextEffect;
      
      protected var FBoundsName:TBounds;
      
      protected var FBoundsReward:TBounds;
      
      protected var FBoundsOffset:TBounds;
      
      public function TOverlayerChallengeTreasure(param1:TUIComponent)
      {
         super(param1);
         this.FPainterName = ConstructPainterTextEffect(COLOR_Context_03);
         this.FBoundsName = new TBounds();
         this.FPainterReward = ConstructPainterTextEffect(COLOR_Context_03);
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
         var _loc3_:TGSPVP_Reward = null;
         _loc3_ = FContext as TGSPVP_Reward;
         this.EvaluationPerform_Name(_loc3_);
         this.FBoundsOffset = this.FBoundsName;
         this.EvaluationPerform_Reward(_loc3_);
         this.FBoundsOffset = this.FBoundsReward;
      }
      
      protected function EvaluationPerform_Name(param1:TGSPVP_Reward) : void
      {
         BoundsAlignDown(this.FBoundsName);
         this.FPainterName.Text = STRING_OVERLAYERCROSSSERVERWAR.STRING_TreasureReward;
         this.FPainterName.Evaluate(this.FBoundsName);
         BoundsContextUnion(this.FBoundsName);
      }
      
      protected function EvaluationPerform_Reward(param1:TGSPVP_Reward) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:TCrossServerWarReward = null;
         var _loc8_:String = null;
         this.FPainterReward.Text = "";
         BoundsAlignDown(this.FBoundsReward);
         _loc3_ = param1.CrossServerWarRewards.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc8_ = "";
            _loc7_ = param1.CrossServerWarRewards[_loc2_];
            _loc4_ = _loc7_.Type;
            _loc5_ = _loc7_.Code;
            _loc6_ = _loc7_.Amount;
            _loc8_ = STRING_COMMON.GetItemNameByType(_loc4_,_loc5_);
            if(_loc6_ > 1)
            {
               _loc8_ += "*" + _loc6_ + "\n";
            }
            else
            {
               _loc8_ = STRING_OVERLAYERCROSSSERVERWAR.STRING_GetTitle + _loc8_ + "\n";
            }
            this.FPainterReward.Text += _loc8_;
            _loc2_++;
         }
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

