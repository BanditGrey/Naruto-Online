package Rendering.Overlayers.Pet
{
   import Foundation.Common.TAlignment;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSoulArray;
   import Logics.Inventories.TInventory;
   import Rendering.Overlayers.*;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Strings.STRING_ACTIVITYINNER;
   import Resources.Strings.STRING_COMMON;
   import flash.text.TextFormat;
   import ghostcat.util.data.Json;
   
   public class TOverlayerSoulFormation extends TOverlayer
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
      
      public function TOverlayerSoulFormation(param1:TUIComponent)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TPainterTextEffect = null;
         var _loc5_:TBounds = null;
         super(param1);
         this.FPainterExplain0 = ConstructPainterTextEffect(COLOR_ContextDefault);
         this.FBoundsExplain0 = new TBounds();
         this.FPainterExplain1 = ConstructPainterTextEffect(QUALITYCOLOR_Green);
         this.FBoundsExplain1 = new TBounds();
         this.FPainterExplain2 = ConstructPainterTextEffect(QUALITYCOLOR_None);
         this.FBoundsExplain2 = new TBounds();
         this.FPainterExplain3 = ConstructPainterTextEffect(COLOR_ContextDefault);
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
      }
      
      protected function EvaluationPerform_Explain0() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FSoulArray = FContext as TSoulArray;
         this.FContextExplain0 = this.FSoulArray.name;
         this.FContextExplain0 += "\n" + STRING_ACTIVITYINNER.FormatString_MyPetLevel;
         this.FContextExplain0 = TUtilityString.Format(this.FContextExplain0,this.FSoulArray.levelDescription) + "\n";
         BoundsAlignDown(this.FBoundsExplain0);
         this.FPainterExplain0.Text = this.FContextExplain0;
         this.FPainterExplain0.Evaluate(this.FBoundsExplain0);
         BoundsContextUnion(this.FBoundsExplain0);
      }
      
      protected function EvaluationPerform_Explain1() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         this.FSoulArray = FContext as TSoulArray;
         this.FContextExplain1 = "\n" + STRING_COMMON.STRING_NewString[6];
         _loc1_ = 0;
         while(_loc1_ < FORWARD_COUNT)
         {
            _loc3_ = Json.decode(this.FSoulArray.forwardAddition);
            _loc4_ = _loc3_[_loc1_];
            this.FContextExplain1 += "\n" + STRING_COMMON.GetBaseAttributeNameByType(_loc4_["tType"]);
            if(_loc4_["tValue"] > 0)
            {
               this.FContextExplain1 += "+" + _loc4_["tValue"] * 100 + "%";
            }
            else
            {
               this.FContextExplain1 += _loc4_["tValue"] * 100 + "%";
            }
            _loc1_++;
         }
         this.FContextExplain1 += "\n\n" + STRING_COMMON.STRING_NewString[5];
         _loc1_ = 0;
         while(_loc1_ < MIDDLE_COUNT)
         {
            _loc3_ = Json.decode(this.FSoulArray.middleAddition);
            _loc4_ = _loc3_[_loc1_];
            this.FContextExplain1 += "\n" + STRING_COMMON.GetBaseAttributeNameByType(_loc4_["tType"]);
            if(_loc4_["tValue"] > 0)
            {
               this.FContextExplain1 += "+" + _loc4_["tValue"] * 100 + "%";
            }
            else
            {
               this.FContextExplain1 += _loc4_["tValue"] * 100 + "%";
            }
            _loc1_++;
         }
         this.FContextExplain1 += "\n\n" + STRING_COMMON.STRING_NewString[7];
         _loc1_ = 0;
         while(_loc1_ < BACK_COUNT)
         {
            _loc3_ = Json.decode(this.FSoulArray.backAddition);
            _loc4_ = _loc3_[_loc1_];
            this.FContextExplain1 += "\n" + STRING_COMMON.GetBaseAttributeNameByType(_loc4_["tType"]);
            if(_loc4_["tValue"] > 0)
            {
               this.FContextExplain1 += "+" + _loc4_["tValue"] * 100 + "%";
            }
            else
            {
               this.FContextExplain1 += _loc4_["tValue"] * 100 + "%";
            }
            _loc1_++;
         }
         BoundsAlignDown(this.FBoundsExplain1);
         this.FPainterExplain1.Text = this.FContextExplain1;
         this.FPainterExplain1.Evaluate(this.FBoundsExplain1);
         BoundsContextUnion(this.FBoundsExplain1);
      }
      
      override protected function SketchingPerform_Context() : void
      {
         this.SketchingPerform_Explain0();
         this.SketchingPerform_Explain1();
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

