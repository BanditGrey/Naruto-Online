package Rendering.Overlayers.TreasureMap
{
   import Foundation.Common.TAlignment;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TDigging;
   import Logics.DatebaseVO.VO.TDiggingReward;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Rendering.Overlayers.*;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TREASUREMAP;
   import flash.text.TextFormat;
   
   public class TOverlayerTreasureMap extends TOverlayer
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
      
      protected var FPainterCaption:TPainterTextEffect;
      
      protected var FPainterCaptionExplain:TPainterTextEffect;
      
      protected var FPainterTime:TPainterTextEffect;
      
      protected var FPainterOddsReward:TPainterTextEffect;
      
      protected var FPainterExplain:TPainterTextEffect;
      
      protected var FPainterRobbed:TPainterTextEffect;
      
      protected var FPainterRobbedExplain:TPainterTextEffect;
      
      protected var FBoundsCaption:TBounds;
      
      protected var FBoundsCaptionExplain:TBounds;
      
      protected var FBoundsTime:TBounds;
      
      protected var FBoundsOddsReward:TBounds;
      
      protected var FBoundsExplain:TBounds;
      
      protected var FBoundsRobbed:TBounds;
      
      protected var FBoundsRobbedExplain:TBounds;
      
      protected var FContextCaption:String;
      
      protected var FContextCaptionExplain:String;
      
      protected var FContextTime:String;
      
      protected var FContextOddsReward:String;
      
      protected var FContextExplain:String;
      
      protected var FContextRobbed:String;
      
      protected var FContextRobbedExplain:String;
      
      protected var FBoundsOffsetY:TBounds;
      
      protected var FExplainTextFormat:TextFormat;
      
      protected var FIDTemplates:Vector.<uint>;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var TdigReward:TDiggingReward;
      
      public function TOverlayerTreasureMap(param1:TUIComponent)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TPainterTextEffect = null;
         var _loc5_:TBounds = null;
         super(param1);
         this.FPainterCaption = ConstructPainterTextEffect(COLOR_ContextOddsAward);
         this.FPainterCaptionExplain = ConstructPainterTextEffect(COLOR_ContextDefault);
         this.FBoundsCaptionExplain = new TBounds();
         this.FBoundsCaption = new TBounds();
         this.FPainterTime = ConstructPainterTextEffect(COLOR_ContextDefault);
         this.FBoundsTime = new TBounds();
         this.FPainterOddsReward = ConstructPainterTextEffect(COLOR_ContextOddsAward);
         this.FBoundsOddsReward = new TBounds();
         this.FPainterExplain = ConstructPainterTextEffect(COLOR_ContextDefault);
         this.FBoundsExplain = new TBounds();
         this.FPainterRobbed = ConstructPainterTextEffect(COLOR_ContextRobbed);
         this.FPainterRobbedExplain = ConstructPainterTextEffect(COLOR_ContextRobbed);
         this.FBoundsRobbed = new TBounds();
         this.FBoundsRobbedExplain = new TBounds();
         this.FExplainTextFormat = new TextFormat();
         this.FIDTemplates = new Vector.<uint>();
         this.FInventories = new TInventories();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is Object;
      }
      
      override protected function ContextSynchronize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FPainterCaption.Text = "";
         this.FContextCaption = "";
         this.FPainterCaptionExplain.Text = "";
         this.FContextCaptionExplain = "";
         this.FPainterOddsReward.Text = "";
         this.FContextOddsReward = "";
         this.FPainterTime.Text = "";
         this.FContextTime = "";
         this.FPainterExplain.Text = "";
         this.FContextExplain = "";
         this.FPainterRobbed.Text = "";
         this.FContextRobbed = "";
         this.FPainterRobbedExplain.Text = "";
         this.FContextRobbedExplain = "";
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:Object = FContext as Object;
         var _loc2_:uint = uint(_loc1_.id);
         this.TdigReward = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TDiggingReward,_loc2_) as TDiggingReward;
         this.EvaluationPerform_Caption();
         this.FBoundsOffsetY = this.FBoundsCaption;
         this.EvaluationPerform_Explain_Mast();
         this.FBoundsOffsetY = this.FBoundsCaptionExplain;
         this.EvaluationPerform_ContextTime();
         this.FBoundsOffsetY = this.FBoundsTime;
         this.EvaluationPerform_ContextOddsReward();
         this.FBoundsOffsetY = this.FBoundsOddsReward;
         this.EvaluationPerform_Explain();
         this.FBoundsOffsetY = this.FBoundsExplain;
         this.EvaluationPerform_ContextRobbed();
         this.FBoundsOffsetY = this.FBoundsRobbed;
         this.RobbedPerform_Explain();
         this.FBoundsOffsetY = this.FBoundsRobbedExplain;
      }
      
      override protected function ContextModified() : Boolean
      {
         return true;
      }
      
      protected function EvaluationPerform_Caption() : void
      {
         BoundsAlignDown(this.FBoundsCaption);
         this.FContextCaption = STRING_TREASUREMAP.STRING_MastsReward;
         this.FPainterCaption.Text = this.FContextCaption + "\n";
         this.FPainterCaption.Evaluate(this.FBoundsCaption);
         BoundsContextUnion(this.FBoundsCaption);
      }
      
      protected function EvaluationPerform_Explain_Mast() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         this.FContextCaptionExplain = "";
         this.FIDTemplates.length = 0;
         _loc2_ = int(this.TdigReward.MastGetReward.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FContextCaptionExplain += STRING_COMMON.GetItemNameByType(this.TdigReward.MastGetReward[_loc1_].type,this.TdigReward.MastGetReward[_loc1_].code) + " *" + this.TdigReward.MastGetReward[_loc1_].amount + "\n";
            _loc1_++;
         }
         BoundsAlignDown(this.FBoundsCaptionExplain);
         this.FPainterCaptionExplain.Text = this.FContextCaptionExplain;
         this.FPainterCaptionExplain.Evaluate(this.FBoundsCaptionExplain);
         BoundsContextUnion(this.FBoundsCaptionExplain);
      }
      
      protected function EvaluationPerform_ContextTime() : void
      {
         var _loc1_:TDigging = null;
         BoundsAlignDown(this.FBoundsTime);
         _loc1_ = TDigging(FContext.Digging);
         this.FContextTime = TUtilityString.Format(STRING_TREASUREMAP.STRING_TreasureTime,_loc1_.Digtime / 60);
         this.FPainterTime.Text = this.FContextTime + "\n";
         this.FPainterTime.Evaluate(this.FBoundsTime);
         BoundsContextUnion(this.FBoundsTime);
      }
      
      protected function EvaluationPerform_ContextOddsReward() : void
      {
         BoundsAlignDown(this.FBoundsOddsReward);
         this.FContextOddsReward = STRING_TREASUREMAP.STRING_OddsReward;
         this.FPainterOddsReward.Text = this.FContextOddsReward + "\n";
         this.FPainterOddsReward.Evaluate(this.FBoundsOddsReward);
         BoundsContextUnion(this.FBoundsOddsReward);
      }
      
      protected function EvaluationPerform_Explain() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         var _loc4_:Vector.<int> = null;
         this.FContextExplain = "";
         this.FIDTemplates.length = 0;
         _loc4_ = new Vector.<int>();
         _loc2_ = int(this.TdigReward.OddsGetReward.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FIDTemplates.push(this.TdigReward.OddsGetReward[_loc1_].code);
            _loc4_.push(this.TdigReward.OddsGetReward[_loc1_].amount);
            _loc1_++;
         }
         _loc2_ = int(this.TdigReward.OddsGetReward2.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FIDTemplates.push(this.TdigReward.OddsGetReward2[_loc1_].code);
            _loc4_.push(this.TdigReward.OddsGetReward2[_loc1_].amount);
            _loc1_++;
         }
         this.FInventories.Clear();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,this.FIDTemplates);
         _loc1_ = 0;
         while(_loc1_ < this.FInventories.Count)
         {
            _loc3_ = this.FInventories.GetInventoryByIndex(_loc1_);
            if(_loc3_.IDTemplate == 14111300)
            {
               this.FContextExplain += _loc3_.Name + STRING_TREASUREMAP.STRING_1 + "*" + _loc4_[_loc1_] + ",\n";
            }
            else
            {
               this.FContextExplain += _loc3_.Name + "*" + _loc4_[_loc1_] + ",\n";
            }
            _loc1_++;
         }
         BoundsAlignDown(this.FBoundsExplain);
         this.FPainterExplain.Text = this.FContextExplain;
         this.FPainterExplain.Evaluate(this.FBoundsExplain);
         BoundsContextUnion(this.FBoundsExplain);
      }
      
      protected function EvaluationPerform_ContextRobbed() : void
      {
         BoundsAlignDown(this.FBoundsRobbed);
         this.FContextRobbed = STRING_TREASUREMAP.STRING_LostReward;
         this.FPainterRobbed.Text = this.FContextRobbed + "\n";
         this.FPainterRobbed.Evaluate(this.FBoundsRobbed);
         BoundsContextUnion(this.FBoundsRobbed);
      }
      
      protected function RobbedPerform_Explain() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         this.FContextRobbedExplain = "";
         this.FIDTemplates.length = 0;
         _loc2_ = int(this.TdigReward.LossThings.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FContextRobbedExplain += STRING_COMMON.GetItemNameByType(this.TdigReward.LossThings[_loc1_].type,this.TdigReward.LossThings[_loc1_].code) + " *" + this.TdigReward.LossThings[_loc1_].amount + "\n";
            _loc1_++;
         }
         BoundsAlignDown(this.FBoundsRobbedExplain);
         this.FPainterRobbedExplain.Text = this.FContextRobbedExplain;
         this.FPainterRobbedExplain.Evaluate(this.FBoundsRobbedExplain);
         BoundsContextUnion(this.FBoundsRobbedExplain);
      }
      
      override protected function SketchingPerform_Context() : void
      {
         this.SketchingPerform_Caption();
         this.SketchingPerform_AppendAttributes();
         this.SketchingPerform_AppendNextAttributes();
         this.SketchingPerform_Explain();
         this.SketchingPerform_Robbed();
      }
      
      protected function SketchingPerform_Caption() : void
      {
         this.FBoundsCaption.Width = FBoundsContext.Width;
         this.FPainterCaption.RenderBounds(this.FBoundsCaption,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_AppendAttributes() : void
      {
         this.FPainterOddsReward.RenderBounds(this.FBoundsOddsReward,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_AppendNextAttributes() : void
      {
         this.FPainterTime.RenderBounds(this.FBoundsTime,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Explain() : void
      {
         var _loc1_:TInventory = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.FPainterExplain.RenderBounds(this.FBoundsExplain,TAlignment.HORIZONTAL_Center);
         _loc4_ = 0;
         while(_loc4_ < this.FInventories.Count)
         {
            _loc1_ = this.FInventories.GetInventoryByIndex(_loc4_);
            this.FExplainTextFormat.color = QUALITYCOLOR_INDEX[_loc1_.Quality];
            _loc3_ = this.FContextExplain.indexOf(",",_loc2_ + 1);
            this.FPainterExplain.SetTextFormat(this.FExplainTextFormat,_loc2_,_loc3_);
            _loc2_ = _loc3_;
            _loc4_++;
         }
      }
      
      protected function SketchingPerform_Robbed() : void
      {
         this.FPainterRobbed.RenderBounds(this.FBoundsRobbed,TAlignment.HORIZONTAL_Center);
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
         this.FPainterCaption.x = FBoundsRendering.X;
         this.FPainterCaption.y = FBoundsRendering.Y;
         this.FPainterCaptionExplain.x = FBoundsRendering.X;
         this.FPainterCaptionExplain.y = FBoundsRendering.Y + this.FBoundsCaptionExplain.Y;
         this.FPainterTime.x = FBoundsRendering.X;
         this.FPainterTime.y = FBoundsRendering.Y + this.FBoundsTime.Y;
         this.FPainterOddsReward.x = FBoundsRendering.X;
         this.FPainterOddsReward.y = FBoundsRendering.Y + this.FBoundsOddsReward.Y;
         this.FPainterExplain.x = FBoundsRendering.X;
         this.FPainterExplain.y = FBoundsRendering.Y + this.FBoundsExplain.Y;
         this.FPainterRobbed.x = FBoundsRendering.X;
         this.FPainterRobbed.y = FBoundsRendering.Y + this.FBoundsRobbed.Y;
         this.FPainterRobbedExplain.x = FBoundsRendering.X;
         this.FPainterRobbedExplain.y = FBoundsRendering.Y + this.FBoundsRobbedExplain.Y;
      }
   }
}

