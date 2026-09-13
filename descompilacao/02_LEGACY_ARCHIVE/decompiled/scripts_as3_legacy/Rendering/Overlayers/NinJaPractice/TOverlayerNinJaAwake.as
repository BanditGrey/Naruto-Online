package Rendering.Overlayers.NinJaPractice
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.THeroTalent;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.text.TextFormat;
   
   public class TOverlayerNinJaAwake extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_Gray:uint = 4286611584;
      
      protected var FPainterName:TPainterTextEffect;
      
      protected var FBoundsName:TBounds;
      
      protected var FBoundsOffset:TBounds;
      
      protected var FTextFormat:TextFormat;
      
      public function TOverlayerNinJaAwake(param1:TUIComponent)
      {
         super(param1);
         this.FPainterName = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsName = new TBounds();
         this.FTextFormat = new TextFormat();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:THero = null;
         _loc3_ = FContext as THero;
         this.FBoundsOffset = this.FBoundsName;
         this.EvaluationPerform_Text(_loc3_);
      }
      
      protected function EvaluationPerform_Text(param1:THero) : void
      {
         var _loc2_:int = 0;
         var _loc3_:THeroTalent = null;
         var _loc4_:TBaseHero = null;
         var _loc5_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:Vector.<uint> = new Vector.<uint>();
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,param1.Identifier) as TBaseHero;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroTalent,_loc4_.Talent) as THeroTalent;
         _loc2_ = int(param1.AwakeLevel);
         _loc5_ = _loc3_.AwakeDesc.split("\\n");
         this.FPainterName.Text = "";
         _loc6_.push(0);
         _loc9_ = 0;
         while(_loc9_ < _loc5_.length)
         {
            this.FPainterName.Text += _loc5_[_loc9_] + "\n";
            this.FPainterName.Evaluate(this.FBoundsOffset);
            _loc8_ = this.FPainterName.Text.indexOf("\n",_loc7_ + 1);
            _loc6_.push(_loc8_);
            _loc7_ = _loc8_;
            _loc9_++;
         }
         _loc9_ = 0;
         while(_loc9_ < _loc5_.length)
         {
            this.FTextFormat.color = _loc2_ > _loc9_ ? COLOR_Context_White : COLOR_Context_Gray;
            this.FPainterName.SetTextFormat(this.FTextFormat,_loc6_[_loc9_],_loc6_[_loc9_ + 1]);
            _loc9_++;
         }
         this.FPainterName.Evaluate(this.FBoundsOffset);
         BoundsContextUnion(this.FBoundsOffset);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPainterName.X = FBoundsRendering.X + this.FBoundsOffset.X;
         this.FPainterName.Y = FBoundsRendering.Y + this.FBoundsOffset.Y - 5;
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

