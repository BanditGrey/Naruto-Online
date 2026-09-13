package Rendering.Overlayers.NationalDay
{
   import Foundation.Common.TAlignment;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Rendering.Overlayers.*;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.text.TextFormat;
   
   public class TOverlayerSimpleNinjia extends TOverlayer
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
      
      public const Item_ID:Vector.<uint>;
      
      protected var FPainterExplain0:TPainterTextEffect;
      
      protected var FPainterExplain1:TPainterTextEffect;
      
      protected var FPainterExplain2:TPainterTextEffect;
      
      protected var FPainterExplain3:TPainterTextEffect;
      
      protected var FPainterExplain4:TPainterTextEffect;
      
      protected var FBoundsExplain0:TBounds;
      
      protected var FBoundsExplain1:TBounds;
      
      protected var FBoundsExplain2:TBounds;
      
      protected var FBoundsExplain3:TBounds;
      
      protected var FBoundsExplain4:TBounds;
      
      protected var FContextExplain0:String;
      
      protected var FContextExplain1:String;
      
      protected var FContextExplain2:String;
      
      protected var FContextExplain3:String;
      
      protected var FContextExplain4:String;
      
      protected var FBoundsOffsetY:TBounds;
      
      protected var FExplainTextFormat:TextFormat;
      
      protected var FBaseBox:TBaseBox;
      
      protected var FIDTemplates:Vector.<uint>;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TOverlayerSimpleNinjia(param1:TUIComponent)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TPainterTextEffect = null;
         var _loc5_:TBounds = null;
         this.Item_ID = Vector.<uint>([14101081,14101082,14101083,14101084,14101085]);
         super(param1);
         this.FPainterExplain0 = ConstructPainterTextEffect(QUALITYCOLOR_Purple);
         this.FBoundsExplain0 = new TBounds();
         this.FPainterExplain1 = ConstructPainterTextEffect(COLOR_ContextDefault);
         this.FBoundsExplain1 = new TBounds();
         this.FPainterExplain2 = ConstructPainterTextEffect(QUALITYCOLOR_Purple);
         this.FBoundsExplain2 = new TBounds();
         this.FPainterExplain3 = ConstructPainterTextEffect(COLOR_ContextDefault);
         this.FBoundsExplain3 = new TBounds();
         this.FPainterExplain4 = ConstructPainterTextEffect(QUALITYCOLOR_Green);
         this.FBoundsExplain4 = new TBounds();
         this.FExplainTextFormat = new TextFormat();
         this.FIDTemplates = new Vector.<uint>();
         this.FInventories = new TInventories();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is TBaseBox;
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
         this.FPainterExplain4.Text = "";
         this.FContextExplain4 = "";
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
         this.EvaluationPerform_Explain4();
         this.FBoundsOffsetY = this.FBoundsExplain4;
      }
      
      protected function EvaluationPerform_Explain0() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseHero = null;
         var _loc4_:TBB_Status = null;
         this.FBaseBox = FContext as TBaseBox;
         this.FContextExplain0 = "";
         if(this.FBaseBox.Type == TBaseBox.TYPE_IS_HERO)
         {
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.FBaseBox.Identify) as TBaseHero;
            this.FContextExplain0 = _loc3_.Name;
         }
         else if(this.FBaseBox.Type == TBaseBox.TYPE_IS_PET)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,this.FBaseBox.Identify) as TBB_Status;
            this.FContextExplain0 = _loc4_.Name;
         }
         else
         {
            this.FContextExplain0 = "";
         }
         this.FContextExplain0 = this.FContextExplain0.split("%n").join("\n");
         BoundsAlignDown(this.FBoundsExplain0);
         this.FPainterExplain0.Text = this.FContextExplain0;
         this.FPainterExplain0.Evaluate(this.FBoundsExplain0);
         BoundsContextUnion(this.FBoundsExplain0);
      }
      
      protected function EvaluationPerform_Explain1() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc3_ = FContext as TBaseBox;
         this.FContextExplain1 = "";
         this.FContextExplain1 = "\n" + _loc3_.Desc1;
         this.FContextExplain1 = this.FContextExplain1.split("%n").join("\n");
         BoundsAlignDown(this.FBoundsExplain1);
         this.FPainterExplain1.Text = this.FContextExplain1;
         this.FPainterExplain1.Evaluate(this.FBoundsExplain1);
         BoundsContextUnion(this.FBoundsExplain1);
      }
      
      protected function EvaluationPerform_Explain2() : void
      {
         var _loc1_:TBaseBox = null;
         _loc1_ = FContext as TBaseBox;
         this.FContextExplain2 = "";
         this.FContextExplain2 = "\n" + _loc1_.Desc2;
         this.FContextExplain2 = this.FContextExplain2.split("%n").join("\n");
         BoundsAlignDown(this.FBoundsExplain2);
         this.FPainterExplain2.Text = this.FContextExplain2;
         this.FPainterExplain2.Evaluate(this.FBoundsExplain2);
         BoundsContextUnion(this.FBoundsExplain2);
      }
      
      protected function EvaluationPerform_Explain3() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         var _loc4_:TBaseBox = null;
         _loc4_ = FContext as TBaseBox;
         this.FContextExplain3 = "";
         this.FContextExplain3 = "\n" + _loc4_.Desc3;
         this.FContextExplain3 = this.FContextExplain3.split("%n").join("\n");
         BoundsAlignDown(this.FBoundsExplain3);
         this.FPainterExplain3.Text = this.FContextExplain3;
         this.FPainterExplain3.Evaluate(this.FBoundsExplain3);
         BoundsContextUnion(this.FBoundsExplain3);
      }
      
      protected function EvaluationPerform_Explain4() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc3_ = FContext as TBaseBox;
         this.FContextExplain4 = "";
         if(_loc3_.LimitCount > 0)
         {
            this.FContextExplain4 = "\n" + TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_LEVEL,_loc3_.LimitCount);
         }
         BoundsAlignDown(this.FBoundsExplain4);
         this.FPainterExplain4.Text = this.FContextExplain4;
         this.FPainterExplain4.Evaluate(this.FBoundsExplain4);
         BoundsContextUnion(this.FBoundsExplain4);
      }
      
      override protected function SketchingPerform_Context() : void
      {
         this.SketchingPerform_Explain0();
         this.SketchingPerform_Explain1();
         this.SketchingPerform_Explain2();
         this.SketchingPerform_Explain3();
         this.SketchingPerform_Explain4();
      }
      
      protected function SketchingPerform_Explain0() : void
      {
         var _loc1_:TBaseHero = null;
         var _loc2_:TBB_Status = null;
         this.FBaseBox = FContext as TBaseBox;
         this.FContextExplain0 = "";
         if(this.FBaseBox.Type == TBaseBox.TYPE_IS_HERO)
         {
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.FBaseBox.Identify) as TBaseHero;
            this.FPainterExplain0.RenderBounds(this.FBoundsExplain0,TAlignment.HORIZONTAL_Center);
            this.FExplainTextFormat.color = QUALITYCOLOR_INDEX[_loc1_.Quality];
         }
         else if(this.FBaseBox.Type == TBaseBox.TYPE_IS_PET)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,this.FBaseBox.Identify) as TBB_Status;
            this.FExplainTextFormat.color = QUALITYCOLOR_INDEX[_loc2_.Rarity];
         }
         this.FPainterExplain0.SetTextFormat(this.FExplainTextFormat);
      }
      
      protected function SketchingPerform_Explain1() : void
      {
         this.FPainterExplain1.RenderBounds(this.FBoundsExplain1,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Explain2() : void
      {
         this.FPainterExplain2.RenderBounds(this.FBoundsExplain2,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Explain3() : void
      {
         this.FPainterExplain3.RenderBounds(this.FBoundsExplain3,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Explain4() : void
      {
         this.FPainterExplain4.RenderBounds(this.FBoundsExplain4,TAlignment.HORIZONTAL_Center);
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
         this.FPainterExplain4.x = FBoundsRendering.X;
         this.FPainterExplain4.y = FBoundsRendering.Y + this.FBoundsExplain4.Y;
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

