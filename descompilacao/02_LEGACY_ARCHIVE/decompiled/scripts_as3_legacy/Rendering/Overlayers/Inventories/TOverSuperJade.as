package Rendering.Overlayers.Inventories
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TMasterStone;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_OVERLAYERTREASURE;
   import flash.text.TextFormat;
   
   public class TOverSuperJade extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_01:uint = 4291545959;
      
      protected static const COLOR_Context_03:uint = 4284940083;
      
      protected static const FORMAT_ChaunDaiDengJi:String = STRING_OVERLAYERTREASURE.FORMAT_ChaunDaiDengJi;
      
      protected static const FORMAT_XingJiShuLiang:String = STRING_OVERLAYERTREASURE.FORMAT_XingJiShuLiang;
      
      protected static const FORMAT_DangQianShuXing:String = STRING_OVERLAYERTREASURE.FORMAT_DangQianShuXing;
      
      protected static const FORMAT_XiaJiShuXing:String = STRING_OVERLAYERTREASURE.FORMAT_XiaJiShuXing;
      
      protected var FPName:TPainterTextEffect;
      
      protected var FBName:TBounds;
      
      protected var FP0:TPainterTextEffect;
      
      protected var FB0:TBounds;
      
      protected var FP1:TPainterTextEffect;
      
      protected var FB1:TBounds;
      
      protected var FP2:TPainterTextEffect;
      
      protected var FB2:TBounds;
      
      protected var FP3:TPainterTextEffect;
      
      protected var FB3:TBounds;
      
      protected var FTextFormatChaunDai:TextFormat;
      
      protected var FTextFormatXingJi:TextFormat;
      
      protected var FTextFormatNextLevel:TextFormat;
      
      protected var FCurBoo:Boolean;
      
      public function TOverSuperJade(param1:TUIComponent)
      {
         super(param1);
         this.FPName = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBName = new TBounds();
         this.FP1 = ConstructPainterTextEffect(COLOR_Context_03);
         this.FB1 = new TBounds();
         this.FP2 = ConstructPainterTextEffect(COLOR_Context_01);
         this.FB2 = new TBounds();
         this.FP3 = ConstructPainterTextEffect(COLOR_Context_01);
         this.FB3 = new TBounds();
         this.FTextFormatChaunDai = new TextFormat();
         this.FTextFormatXingJi = new TextFormat();
         this.FTextFormatNextLevel = new TextFormat();
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:TInventory = FContext as TInventory;
         this.SetName(_loc1_);
         this.XingJiShuLiang(_loc1_);
         this.CurAttri(_loc1_);
         this.NextAttri(_loc1_);
      }
      
      protected function SetName(param1:TInventory) : void
      {
         BoundsAlignDown(this.FBName);
         this.FPName.Text = param1.Name;
         this.FPName.Font.Color = CONST_COMMON.QUALITYCOLOR_INDEX[param1.Quality];
         this.FPName.Evaluate(this.FBName);
         BoundsContextUnion(this.FBName);
      }
      
      protected function ChaunDaiDengJi(param1:TInventory) : void
      {
      }
      
      protected function XingJiShuLiang(param1:TInventory) : void
      {
         var _loc2_:TMasterStone = SLogicsCore.LostShenQiLogicData.MasterStoneBins.GetDatebaseByIdentifier(param1.IDTemplate) as TMasterStone;
         BoundsAlignDown(this.FB1);
         this.FP1.Text = TUtilityString.Format(FORMAT_XingJiShuLiang,_loc2_.Level);
         this.FP1.Evaluate(this.FB1);
         BoundsContextUnion(this.FB1);
      }
      
      protected function CurAttri(param1:TInventory) : void
      {
         var _loc2_:TArticle = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,param1.IDTemplate) as TArticle;
         var _loc3_:int = FORMAT_DangQianShuXing.length - "%0".length;
         BoundsAlignDown(this.FB2);
         this.FP2.Text = TUtilityString.Format(FORMAT_DangQianShuXing,_loc2_.FunctionDesc);
         this.FTextFormatXingJi.size = this.FP2.Font.Size;
         this.FTextFormatXingJi.color = COLOR_Context_White;
         this.FP2.Evaluate(this.FB2);
         this.FP2.SetTextFormat(this.FTextFormatXingJi,0,_loc3_);
         BoundsContextUnion(this.FB2);
      }
      
      protected function NextAttri(param1:TInventory) : void
      {
         var _loc2_:uint = param1.IDTemplate + 1;
         var _loc3_:TMasterStone = SLogicsCore.LostShenQiLogicData.MasterStoneBins.GetDatebaseByIdentifier(_loc2_) as TMasterStone;
         if(!_loc3_)
         {
            this.FCurBoo = false;
            return;
         }
         var _loc4_:TArticle = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc2_) as TArticle;
         this.FCurBoo = true;
         var _loc5_:int = FORMAT_XiaJiShuXing.length - "%0".length;
         BoundsAlignDown(this.FB3);
         this.FP3.Text = TUtilityString.Format(FORMAT_XiaJiShuXing,_loc4_.FunctionDesc);
         this.FTextFormatNextLevel.size = this.FP3.Font.Size;
         this.FTextFormatNextLevel.color = COLOR_Context_White;
         this.FP3.Evaluate(this.FB3);
         this.FP3.SetTextFormat(this.FTextFormatNextLevel,0,_loc5_);
         BoundsContextUnion(this.FB3);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPName.X = FBoundsRendering.X + this.FBName.X;
         this.FPName.Y = FBoundsRendering.Y + this.FBName.Y;
         this.FP1.X = FBoundsRendering.X + this.FB1.X;
         this.FP1.Y = FBoundsRendering.Y + this.FB1.Y;
         this.FP2.X = FBoundsRendering.X + this.FB2.X;
         this.FP2.Y = FBoundsRendering.Y + this.FB2.Y;
         if(this.FCurBoo)
         {
            this.FP3.X = FBoundsRendering.X + this.FB3.X;
            this.FP3.Y = FBoundsRendering.Y + this.FB3.Y;
            this.FP3.Visible = true;
         }
         else
         {
            this.FP3.X = FBoundsRendering.X + this.FB3.X;
            this.FP3.Y = 0;
            this.FP3.Visible = false;
         }
      }
      
      override protected function ContextModified() : Boolean
      {
         return true;
      }
   }
}

