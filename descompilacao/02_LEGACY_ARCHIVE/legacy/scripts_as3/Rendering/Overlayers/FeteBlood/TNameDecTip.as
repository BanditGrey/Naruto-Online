package Rendering.Overlayers.FeteBlood
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Rendering.Texts.TPainterTextEffectHTML;
   import Resources.Strings.STRING_FETEBLOODMAINMANAGE;
   
   public class TNameDecTip extends TOverlayer
   {
      
      protected static const COLOR_Context_YELLOW:uint = 4294967040;
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected var TPName:TPainterTextEffect;
      
      protected var FBName:TBounds;
      
      protected var TPPri:TPainterTextEffect;
      
      protected var FBPri:TBounds;
      
      protected var DiaoLuoDec:TPainterTextEffectHTML;
      
      protected var BDiaoLuo:TBounds;
      
      protected var FCur:int;
      
      public function TNameDecTip(param1:TUIComponent)
      {
         super(param1);
         this.TPName = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBName = new TBounds();
         this.TPPri = ConstructPainterTextEffect(COLOR_Context_YELLOW);
         this.FBPri = new TBounds();
         this.DiaoLuoDec = ConstructPainterTextEffectCopy(COLOR_Context_YELLOW);
         this.BDiaoLuo = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         this.FCur = FContext as int;
         this.nAme();
         this.pRi();
         this.DiaoLuo();
      }
      
      protected function nAme() : void
      {
         BoundsAlignDown(this.FBName);
         this.TPName.Text = STRING_FETEBLOODMAINMANAGE.STRING_NameVec[this.FCur];
         this.TPName.Evaluate(this.FBName);
         BoundsContextUnion(this.FBName);
      }
      
      protected function pRi() : void
      {
         BoundsAlignDown(this.FBPri);
         this.TPPri.Text = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.STRING_Function_Cost,SLogicsCore.BloodFeteDatas.CallCostPri[this.FCur]);
         this.TPPri.Evaluate(this.FBPri);
         BoundsContextUnion(this.FBPri);
      }
      
      protected function DiaoLuo() : void
      {
         BoundsAlignDown(this.BDiaoLuo);
         this.DiaoLuoDec.Text = STRING_FETEBLOODMAINMANAGE.STRING_DIAOLUO_Vec[this.FCur];
         this.DiaoLuoDec.Evaluate(this.BDiaoLuo);
         BoundsContextUnion(this.BDiaoLuo);
      }
      
      override public function set Context(param1:Object) : void
      {
         if(param1 != null)
         {
            if(!ContextVerificate(param1))
            {
               param1 = null;
            }
         }
         FContext = param1;
         FModified = true;
      }
      
      override public function Show() : void
      {
         if(!this.visible)
         {
            this.visible = true;
         }
      }
      
      override public function Hide() : void
      {
         if(this.visible)
         {
            this.visible = false;
         }
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.TPName.X = FBoundsRendering.X + this.FBName.X;
         this.TPName.Y = FBoundsRendering.Y + this.FBName.Y;
         this.TPPri.X = FBoundsRendering.X + this.FBPri.X;
         this.TPPri.Y = FBoundsRendering.Y + this.FBPri.Y;
         this.DiaoLuoDec.X = FBoundsRendering.X + this.BDiaoLuo.X;
         this.DiaoLuoDec.Y = FBoundsRendering.Y + this.BDiaoLuo.Y;
      }
   }
}

