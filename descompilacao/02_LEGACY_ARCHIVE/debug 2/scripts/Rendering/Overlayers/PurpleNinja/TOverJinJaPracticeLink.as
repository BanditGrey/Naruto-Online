package Rendering.Overlayers.PurpleNinja
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TNinJaPractice;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_CHARACTER;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_INHERITPRACTICE;
   import flash.display.Bitmap;
   
   public class TOverJinJaPracticeLink extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_YELLOW:uint = 4294967040;
      
      protected static const COLOR_ContextDefault:uint = 4294958161;
      
      protected static const SIZE_DividingLine_Min_Width:uint = 135;
      
      protected var FPainterBig:TPainterTextEffect;
      
      protected var FPainterReward:TPainterTextEffect;
      
      protected var FLineBmp:Bitmap;
      
      protected var FBoundsName:TBounds;
      
      protected var FBoundsReward:TBounds;
      
      protected var FBoundsBmp:TBounds;
      
      protected var FcurHero:THero;
      
      protected var FPotentialLv:uint;
      
      protected var FBoundsOffset:TBounds;
      
      public var OpenLeve:int;
      
      public var herolevel:int;
      
      public function TOverJinJaPracticeLink(param1:TUIComponent)
      {
         super(param1);
         this.FPainterBig = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsName = new TBounds();
         this.FLineBmp = new Bitmap();
         addChild(this.FLineBmp);
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
         if(this.herolevel < this.OpenLeve)
         {
            this.FPainterBig.Font.Color = COLOR_ContextDefault;
         }
         else
         {
            this.FPainterBig.Font.Color = COLOR_Context_White;
         }
         if(!FModified && FContext != null)
         {
            if(this.FPotentialLv != THero(FContext).PotentialLv)
            {
               FContext = param1;
               FModified = true;
            }
         }
         this.FPotentialLv = THero(FContext).PotentialLv;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FLineBmp.bitmapData = FDividingLine;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ContextSynchronize() : void
      {
         this.FLineBmp.width = 0;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:int = 0;
         this.FcurHero = FContext as THero;
         if(this.herolevel < this.OpenLeve)
         {
            this.EvaluationPerform_Name(0);
            this.FBoundsOffset = this.FBoundsName;
         }
         else
         {
            this.EvaluationPerform_Name(1);
            this.FBoundsOffset = this.FBoundsName;
            BoundsAlignDown(this.FBoundsBmp);
            this.FPainterBig.Evaluate(this.FBoundsBmp);
            BoundsContextUnion(this.FBoundsBmp);
            this.FBoundsBmp.X = 0;
            this.FBoundsOffset = this.FBoundsBmp;
            if(this.FcurHero.Profession != CONST_CHARACTER.PROFESSION_Intellect)
            {
               this.EvaluationPerform_Reward(2);
            }
            else
            {
               this.EvaluationPerform_Reward(1);
            }
            this.FBoundsOffset = this.FBoundsReward;
         }
      }
      
      protected function EvaluationPerform_Name(param1:int = 1) : void
      {
         BoundsAlignDown(this.FBoundsName);
         if(param1)
         {
            this.FPainterBig.Text = STRING_INHERITPRACTICE.INHERIT_LEVEL + ":    " + this.FcurHero.GetQianNengOnlyLevelStr(this.FcurHero.PotentialLv);
         }
         else
         {
            this.FPainterBig.Text = TUtilityString.Format(STRING_INHERITPRACTICE.INHERIT_FORTION07,this.OpenLeve);
         }
         this.FPainterBig.Evaluate(this.FBoundsName);
         BoundsContextUnion(this.FBoundsName);
      }
      
      protected function EvaluationPerform_Reward(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TNinJaPractice = null;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NinJaPractice,this.FcurHero.PotentialLv + 1) as TNinJaPractice;
         this.FPainterReward.Text = "";
         BoundsAlignDown(this.FBoundsReward);
         if(param1 == 2)
         {
            this.FPainterReward.Text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[9] + "：" + _loc3_.AddNearAttack + "\n" + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[10] + "：" + _loc3_.AddNearDefense + "\n" + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[14] + "：" + _loc3_.AddStrategyDefense + "\n" + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[4] + "：" + _loc3_.AddSpeed + "\n" + STRING_INHERITPRACTICE.INHERIT_LIFE + "：" + _loc3_.AddMaxHp;
         }
         else
         {
            this.FPainterReward.Text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[13] + "：" + _loc3_.AddStrategyAttack + "\n" + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[14] + "：" + _loc3_.AddStrategyDefense + "\n" + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[10] + "：" + _loc3_.AddNearDefense + "\n" + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[4] + "：" + _loc3_.AddSpeed + "\n" + STRING_INHERITPRACTICE.INHERIT_LIFE + "：" + _loc3_.AddMaxHp;
         }
         this.FPainterReward.Evaluate(this.FBoundsReward);
         BoundsContextUnion(this.FBoundsReward);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         this.FLineBmp.width = 0;
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPainterBig.X = FBoundsRendering.X + this.FBoundsName.X;
         this.FPainterBig.Y = FBoundsRendering.Y + this.FBoundsName.Y;
         if(this.herolevel < this.OpenLeve)
         {
            this.FLineBmp.visible = false;
         }
         else
         {
            this.FLineBmp.visible = true;
            this.FLineBmp.y = FBoundsRendering.Y + this.FBoundsBmp.Y + 5;
            this.FPainterReward.X = FBoundsRendering.X + this.FBoundsReward.X;
            this.FPainterReward.Y = FBoundsRendering.Y + this.FBoundsReward.Y - 5;
         }
         this.FLineBmp.width = this.Width - 14;
         this.FLineBmp.x = 7;
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

