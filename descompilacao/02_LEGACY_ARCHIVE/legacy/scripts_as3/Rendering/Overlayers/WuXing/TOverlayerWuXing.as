package Rendering.Overlayers.WuXing
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.Json.TWuxingAttribute;
   import Logics.DatebaseVO.VO.TWuxingConfig;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   
   public class TOverlayerWuXing extends TOverlayer
   {
      
      protected static const SIZE_Padding_01:uint = 3;
      
      protected static const SIZE_Padding_02:uint = 5;
      
      protected static const SIZE_Padding_03:uint = 15;
      
      protected static const SIZE_Context_00:uint = 14;
      
      protected static const FORMAT_AppendAttributesPercentage:String = "  %0 %1%";
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_01:uint = 4291545959;
      
      protected static const COLOR_Context_02:uint = 4294901760;
      
      protected static const STRING_wuxing:Array = [[80002338,80002343,80002350],[80002339,80002344,80002347],[80002340,80002345,80002349],[80002336,80002341,80002346],[80002337,80002342,80002348]];
      
      protected var FPainterUpgradingLevel:TPainterTextEffect;
      
      protected var FPainterBasisProperty:TPainterTextEffect;
      
      protected var FBoundsUpgradingLevel:TBounds;
      
      protected var FBoundsBasisProperty:TBounds;
      
      protected var FBoundsOffset:TBounds;
      
      public var IsNextLevel:Boolean;
      
      public function TOverlayerWuXing(param1:TUIComponent)
      {
         super(param1);
         this.FPainterUpgradingLevel = ConstructPainterTextEffect(COLOR_Context_01);
         this.FPainterUpgradingLevel.Font.Bold = true;
         this.FBoundsUpgradingLevel = new TBounds();
         this.FPainterBasisProperty = ConstructPainterTextEffect(COLOR_Context_01);
         this.FBoundsBasisProperty = new TBounds();
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TWuxingConfig = null;
         var _loc4_:TPainterTextEffect = null;
         _loc3_ = FContext as TWuxingConfig;
         this.EvaluationPerform_UpgradingLevel(_loc3_);
         this.FBoundsOffset = this.FBoundsUpgradingLevel;
         this.EvaluationPerform_BasisProperty(_loc3_);
         this.FBoundsOffset = this.FBoundsBasisProperty;
      }
      
      protected function EvaluationPerform_UpgradingLevel(param1:TWuxingConfig) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.Level);
         this.FPainterUpgradingLevel.Text = this.IsNextLevel ? new ConsumeFrame(80002335).DescribeString : new ConsumeFrame(80002334).DescribeString;
         this.FPainterUpgradingLevel.Text += _loc2_;
         this.FPainterUpgradingLevel.Font.Size = SIZE_Context_00;
         this.FPainterUpgradingLevel.Font.Color = this.IsNextLevel ? COLOR_Context_02 : COLOR_Context_01;
         this.FBoundsUpgradingLevel.Y = 1;
         this.FPainterUpgradingLevel.Evaluate(this.FBoundsUpgradingLevel);
         BoundsContextUnion(this.FBoundsUpgradingLevel);
      }
      
      protected function EvaluationPerform_BasisProperty(param1:TWuxingConfig) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:TWuxingAttribute = null;
         var _loc7_:Array = null;
         BoundsAlignDown(this.FBoundsBasisProperty,this.FBoundsOffset,SIZE_Padding_01);
         this.FPainterBasisProperty.Text = "";
         _loc5_ = int(param1.XiangkeArr.length);
         _loc7_ = STRING_wuxing[param1.Type - 1];
         this.FPainterBasisProperty.Text = new ConsumeFrame(_loc7_[0]).DescribeString + "\n";
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc6_ = param1.XiangkeArr[_loc2_] as TWuxingAttribute;
            this.FPainterBasisProperty.Text += TUtilityString.Format(FORMAT_AppendAttributesPercentage,_loc6_.Name,"+" + _loc6_.Value * 100) + "\n";
            _loc2_++;
         }
         this.FPainterBasisProperty.Text += new ConsumeFrame(_loc7_[1]).DescribeString + "\n";
         _loc5_ = int(param1.FanxiangkeArr.length);
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc6_ = param1.FanxiangkeArr[_loc2_] as TWuxingAttribute;
            this.FPainterBasisProperty.Text += TUtilityString.Format(FORMAT_AppendAttributesPercentage,_loc6_.Name,"+" + (_loc6_.Value * 100).toFixed(0)) + "\n";
            _loc2_++;
         }
         this.FPainterBasisProperty.Text += new ConsumeFrame(_loc7_[2]).DescribeString + "\n";
         _loc5_ = int(param1.XiangshengArr.length);
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc6_ = param1.XiangshengArr[_loc2_] as TWuxingAttribute;
            this.FPainterBasisProperty.Text += TUtilityString.Format(FORMAT_AppendAttributesPercentage,_loc6_.Name,"+" + _loc6_.Value * 100) + "\n";
            _loc2_++;
         }
         this.FPainterBasisProperty.Evaluate(this.FBoundsBasisProperty);
         this.FPainterBasisProperty.Font.Color = this.IsNextLevel ? COLOR_Context_02 : COLOR_Context_01;
         BoundsContextUnion(this.FBoundsBasisProperty);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBounds = null;
         var _loc4_:TPainterTextEffect = null;
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPainterUpgradingLevel.X = FBoundsRendering.X + this.FBoundsUpgradingLevel.X;
         this.FPainterUpgradingLevel.Y = FBoundsRendering.Y + this.FBoundsUpgradingLevel.Y;
         this.FPainterBasisProperty.X = FBoundsRendering.X + this.FBoundsBasisProperty.X;
         this.FPainterBasisProperty.Y = FBoundsRendering.Y + this.FBoundsBasisProperty.Y;
      }
   }
}

