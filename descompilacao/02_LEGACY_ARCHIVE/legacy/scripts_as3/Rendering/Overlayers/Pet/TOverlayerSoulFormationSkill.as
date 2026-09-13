package Rendering.Overlayers.Pet
{
   import Foundation.Common.TAlignment;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSkillConfig;
   import Logics.DatebaseVO.VO.TSoulArray;
   import Logics.Inventories.TInventory;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Rendering.Overlayers.*;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_SOULFORMATION;
   import flash.text.TextFormat;
   import ghostcat.util.data.Json;
   
   public class TOverlayerSoulFormationSkill extends TOverlayer
   {
      
      protected static const COLOR_ContextOddsAward:uint = 4294967295;
      
      protected static const COLOR_ContextRobbed:uint = 4284900966;
      
      protected static const QUALITYCOLOR_None:uint = 4294967295;
      
      protected static const QUALITYCOLOR_White:uint = 4294967295;
      
      protected static const QUALITYCOLOR_Green:uint = 4285071106;
      
      protected static const QUALITYCOLOR_Blue:uint = 4278228735;
      
      protected static const QUALITYCOLOR_Purple:uint = 4288217295;
      
      protected static const QUALITYCOLOR_Yellow:uint = 4294967040;
      
      protected static const QUALITYCOLOR_Red:uint = 4294836224;
      
      protected static const QUALITYCOLOR_Orange:uint = 4294901888;
      
      public static const QUALITYCOLOR_INDEX:Vector.<uint> = Vector.<uint>([QUALITYCOLOR_None,QUALITYCOLOR_White,QUALITYCOLOR_Green,QUALITYCOLOR_Blue,QUALITYCOLOR_Purple,QUALITYCOLOR_Yellow,QUALITYCOLOR_Red,QUALITYCOLOR_Orange]);
      
      public static const FORWARD_COUNT:uint = 4;
      
      public static const MIDDLE_COUNT:uint = 2;
      
      public static const BACK_COUNT:uint = 2;
      
      protected var FPainterExplain0:TPainterTextEffect;
      
      protected var FPainterExplain1:TPainterTextEffect;
      
      protected var FPainterExplain2:TPainterTextEffect;
      
      protected var FPainterExplain3:TPainterTextEffect;
      
      protected var FBoundsExplain0:TBounds;
      
      protected var FBoundsExplain1:TBounds;
      
      protected var FBoundsExplain2:TBounds;
      
      protected var FBoundsExplain3:TBounds;
      
      protected var FContextExplain0:String;
      
      protected var FContextExplain1:String;
      
      protected var FContextExplain2:String;
      
      protected var FContextExplain3:String;
      
      protected var FBoundsOffsetY:TBounds;
      
      protected var FExplainTextFormat:TextFormat;
      
      protected var FSoulArray:TSoulArray;
      
      public var PetName:String;
      
      public function TOverlayerSoulFormationSkill(param1:TUIComponent)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TPainterTextEffect = null;
         var _loc5_:TBounds = null;
         super(param1);
         this.FPainterExplain0 = ConstructPainterTextEffect(QUALITYCOLOR_Red);
         this.FBoundsExplain0 = new TBounds();
         this.FPainterExplain1 = ConstructPainterTextEffect(COLOR_ContextDefault);
         this.FBoundsExplain1 = new TBounds();
         this.FPainterExplain2 = ConstructPainterTextEffect(QUALITYCOLOR_Green);
         this.FBoundsExplain2 = new TBounds();
         this.FPainterExplain3 = ConstructPainterTextEffect(QUALITYCOLOR_Blue);
         this.FBoundsExplain3 = new TBounds();
         this.FExplainTextFormat = new TextFormat();
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is TSoulArray;
      }
      
      override protected function ContextSynchronize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FPainterExplain0.Text = "";
         this.FContextExplain0 = "";
         this.FPainterExplain1.Text = "";
         this.FContextExplain1 = "";
         this.FPainterExplain2.Text = "";
         this.FContextExplain2 = "";
         this.FPainterExplain3.Text = "";
         this.FContextExplain3 = "";
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         this.EvaluationPerform_Explain0();
         this.FBoundsOffsetY = this.FBoundsExplain0;
         this.EvaluationPerform_Explain1();
         this.FBoundsOffsetY = this.FBoundsExplain1;
         this.EvaluationPerform_Explain2();
         this.FBoundsOffsetY = this.FBoundsExplain2;
         this.EvaluationPerform_Explain3();
         this.FBoundsOffsetY = this.FBoundsExplain3;
      }
      
      protected function EvaluationPerform_Explain0() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FSoulArray = FContext as TSoulArray;
         this.FContextExplain0 = "";
         BoundsAlignDown(this.FBoundsExplain0);
         this.FPainterExplain0.Text = this.FSoulArray.name;
         this.FPainterExplain0.Evaluate(this.FBoundsExplain0);
         BoundsContextUnion(this.FBoundsExplain0);
      }
      
      protected function EvaluationPerform_Explain1() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FSoulArray = FContext as TSoulArray;
         this.FContextExplain1 = "";
         BoundsAlignDown(this.FBoundsExplain1);
         this.FPainterExplain1.Text = new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_0016).DescribeString + this.FSoulArray.level;
         this.FPainterExplain1.Evaluate(this.FBoundsExplain1);
         BoundsContextUnion(this.FBoundsExplain1);
      }
      
      protected function EvaluationPerform_Explain2() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         this.FSoulArray = FContext as TSoulArray;
         this.FContextExplain2 = "";
         _loc5_ = Json.decode(this.FSoulArray.active);
         _loc2_ = new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_0015).DescribeString;
         this.FContextExplain2 += TUtilityString.Format(_loc2_,1);
         if(_loc5_.length == 1)
         {
            this.FContextExplain2 += new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_0017).DescribeString + "\n";
         }
         else
         {
            _loc4_ = int(_loc5_[0][1]);
            _loc3_ = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc4_) as TSkillConfig).Name;
            _loc3_ = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc4_) as TSkillConfig).Name;
            this.FContextExplain2 += _loc3_;
            this.FContextExplain2 += "\n" + (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc4_) as TSkillConfig).Desc + "\n";
         }
         this.FContextExplain2 = this.FContextExplain2.split("%n").join("");
         BoundsAlignDown(this.FBoundsExplain2);
         this.FPainterExplain2.Text = this.FContextExplain2;
         this.FPainterExplain2.Evaluate(this.FBoundsExplain2);
         BoundsContextUnion(this.FBoundsExplain2);
      }
      
      protected function EvaluationPerform_Explain3() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         this.FSoulArray = FContext as TSoulArray;
         this.FContextExplain3 = "";
         _loc5_ = Json.decode(this.FSoulArray.active);
         _loc2_ = new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_0015).DescribeString;
         this.FContextExplain3 += TUtilityString.Format(_loc2_,2);
         if(_loc5_.length == 1)
         {
            _loc4_ = int(_loc5_[0][1]);
            _loc3_ = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc4_) as TSkillConfig).Name;
            this.FContextExplain3 += _loc3_;
            this.FContextExplain3 += "\n" + (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc4_) as TSkillConfig).Desc + "\n";
         }
         else
         {
            _loc4_ = int(_loc5_[1][1]);
            _loc3_ = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc4_) as TSkillConfig).Name;
            this.FContextExplain3 += _loc3_;
            this.FContextExplain3 += "\n" + (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc4_) as TSkillConfig).Desc + "\n";
         }
         this.FContextExplain3 = this.FContextExplain3.split("%n").join("");
         BoundsAlignDown(this.FBoundsExplain3);
         this.FPainterExplain3.Text = this.FContextExplain3;
         this.FPainterExplain3.Evaluate(this.FBoundsExplain3);
         BoundsContextUnion(this.FBoundsExplain3);
      }
      
      override protected function SketchingPerform_Context() : void
      {
         this.SketchingPerform_Explain0();
         this.SketchingPerform_Explain1();
         this.SketchingPerform_Explain2();
         this.SketchingPerform_Explain3();
      }
      
      protected function SketchingPerform_Explain0() : void
      {
         var _loc1_:TInventory = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.FPainterExplain0.RenderBounds(this.FBoundsExplain0,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Explain1() : void
      {
         var _loc1_:TInventory = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.FPainterExplain1.RenderBounds(this.FBoundsExplain1,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Explain2() : void
      {
         var _loc1_:TInventory = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.FPainterExplain2.RenderBounds(this.FBoundsExplain2,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Explain3() : void
      {
         var _loc1_:TInventory = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.FPainterExplain3.RenderBounds(this.FBoundsExplain3,TAlignment.HORIZONTAL_Center);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TBounds = null;
         var _loc7_:TPainterTextEffect = null;
         _loc6_ = new TBounds();
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPainterExplain0.x = FBoundsRendering.X;
         this.FPainterExplain0.y = FBoundsRendering.Y + this.FBoundsExplain0.Y;
         this.FPainterExplain1.x = FBoundsRendering.X;
         this.FPainterExplain1.y = FBoundsRendering.Y + this.FBoundsExplain1.Y;
         this.FPainterExplain2.x = FBoundsRendering.X;
         this.FPainterExplain2.y = FBoundsRendering.Y + this.FBoundsExplain2.Y;
         this.FPainterExplain3.x = FBoundsRendering.X;
         this.FPainterExplain3.y = FBoundsRendering.Y + this.FBoundsExplain3.Y;
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

