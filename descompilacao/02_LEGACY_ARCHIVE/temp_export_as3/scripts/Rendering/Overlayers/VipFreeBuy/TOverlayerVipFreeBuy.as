package Rendering.Overlayers.VipFreeBuy
{
   import Foundation.Common.TAlignment;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.VipFreeBuy.TVipFreeBuy;
   import Logics.Exercise.VipShop.TVipBox;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Rendering.Overlayers.*;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Strings.STRING_VIPFREEBUY;
   import flash.text.TextFormat;
   
   public class TOverlayerVipFreeBuy extends TOverlayer
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
      
      protected static const SIZE_OffsetY:uint = 4;
      
      protected static const COLOR_ContextCaption:uint = 4294967040;
      
      protected static const COLOR_ContextExplain:uint = 4294954137;
      
      protected static const COLOR_ContextToday:uint = 4294954137;
      
      protected static const COLOR_ContextStatusHaveGot:uint = 4291559424;
      
      protected static const COLOR_ContextStatusCanGet:uint = 4278255360;
      
      protected static const COLOR_ContextStatusCantGet:uint = 4294953984;
      
      protected static const COLOR_ContextCount:uint = 4294954137;
      
      protected static const COLOR_ContextPrice:uint = 4294967040;
      
      protected var FPainterCaption:TPainterTextEffect;
      
      protected var FPainterExplain0:TPainterTextEffect;
      
      protected var FPainterExplain1:TPainterTextEffect;
      
      protected var FPainterExplain2:TPainterTextEffect;
      
      protected var FPainterExplain3:TPainterTextEffect;
      
      protected var FPainterExplain4:TPainterTextEffect;
      
      protected var FPainterToday:TPainterTextEffect;
      
      protected var FPainterStatus:TPainterTextEffect;
      
      protected var FPainterCount:TPainterTextEffect;
      
      protected var FPainterPrice:TPainterTextEffect;
      
      protected var FBoundsCaption:TBounds;
      
      protected var FBoundsExplain0:TBounds;
      
      protected var FBoundsExplain1:TBounds;
      
      protected var FBoundsExplain2:TBounds;
      
      protected var FBoundsExplain3:TBounds;
      
      protected var FBoundsExplain4:TBounds;
      
      protected var FBoundsToday:TBounds;
      
      protected var FBoundsStatus:TBounds;
      
      protected var FBoundsCount:TBounds;
      
      protected var FBoundsPrice:TBounds;
      
      protected var FContextCaption:String;
      
      protected var FContextExplain0:String;
      
      protected var FContextExplain1:String;
      
      protected var FContextExplain2:String;
      
      protected var FContextExplain3:String;
      
      protected var FContextExplain4:String;
      
      protected var FContextToday:String;
      
      protected var FContextStatus:String;
      
      protected var FContextCount:String;
      
      protected var FContextPrice:String;
      
      protected var FBoundsOffsetY:TBounds;
      
      protected var FVipLv:int;
      
      protected var FVipBox:TVipBox;
      
      protected var FExplainTextFormat:TextFormat;
      
      public function TOverlayerVipFreeBuy(param1:TUIComponent)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TPainterTextEffect = null;
         var _loc5_:TBounds = null;
         super(param1);
         this.FPainterCaption = ConstructPainterTextEffect(COLOR_ContextCaption);
         this.FBoundsCaption = new TBounds();
         this.FPainterExplain0 = ConstructPainterTextEffect(COLOR_ContextExplain);
         this.FBoundsExplain0 = new TBounds();
         this.FPainterExplain1 = ConstructPainterTextEffect(COLOR_ContextExplain);
         this.FBoundsExplain1 = new TBounds();
         this.FPainterExplain2 = ConstructPainterTextEffect(COLOR_ContextExplain);
         this.FBoundsExplain2 = new TBounds();
         this.FPainterExplain3 = ConstructPainterTextEffect(COLOR_ContextExplain);
         this.FBoundsExplain3 = new TBounds();
         this.FPainterExplain4 = ConstructPainterTextEffect(COLOR_ContextExplain);
         this.FBoundsExplain4 = new TBounds();
         this.FPainterToday = ConstructPainterTextEffect(COLOR_ContextToday);
         this.FBoundsToday = new TBounds();
         this.FPainterStatus = ConstructPainterTextEffect(COLOR_ContextStatusCantGet);
         this.FBoundsStatus = new TBounds();
         this.FPainterCount = ConstructPainterTextEffect(COLOR_ContextCount);
         this.FBoundsCount = new TBounds();
         this.FPainterPrice = ConstructPainterTextEffect(COLOR_ContextPrice);
         this.FBoundsPrice = new TBounds();
         this.FVipLv = SLogicsCore.Character.VipLevel;
         this.FExplainTextFormat = new TextFormat();
      }
      
      override protected function ContextVerificate(param1:Object) : Boolean
      {
         return param1 is TVipBox;
      }
      
      override protected function ContextSynchronize() : void
      {
         this.FPainterCaption.Text = "";
         this.FContextCaption = "";
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
         this.FPainterToday.Text = "";
         this.FContextToday = "";
         this.FPainterStatus.Text = "";
         this.FContextStatus = "";
         this.FPainterCount.Text = "";
         this.FContextCount = "";
         this.FPainterPrice.Text = "";
         this.FContextPrice = "";
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         this.EvaluationPerform_Caption();
         this.FBoundsOffsetY = this.FBoundsCaption;
         this.EvaluationPerform_Explain0();
         this.FBoundsOffsetY = this.FBoundsExplain0;
         this.EvaluationPerform_Explain1();
         this.FBoundsOffsetY = this.FBoundsExplain1;
         this.EvaluationPerform_Explain2();
         this.FBoundsOffsetY = this.FBoundsExplain2;
         this.EvaluationPerform_Explain3();
         this.FBoundsOffsetY = this.FBoundsExplain0;
         this.EvaluationPerform_Explain4();
         this.FBoundsOffsetY = this.FBoundsExplain4;
         this.EvaluationPerform_Today();
         this.FBoundsOffsetY = this.FBoundsToday;
         this.EvaluationPerform_Status();
         this.FBoundsOffsetY = this.FBoundsStatus;
         this.EvaluationPerform_Count();
         this.FBoundsOffsetY = this.FBoundsCount;
         this.EvaluationPerform_Price();
         this.FBoundsOffsetY = this.FBoundsPrice;
      }
      
      protected function EvaluationPerform_Caption() : void
      {
         this.FVipBox = FContext as TVipBox;
         BoundsAlignDown(this.FBoundsCaption);
         this.FPainterCaption.Text = STRING_VIPFREEBUY.STRINGS_VIP_LEVEL + this.FVipBox.VipLevel;
         this.FPainterCaption.Evaluate(this.FBoundsCaption);
         BoundsContextUnion(this.FBoundsCaption);
      }
      
      protected function EvaluationPerform_Explain0() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         this.FVipBox = FContext as TVipBox;
         this.FContextExplain0 = "";
         if(this.FVipBox.Inventories.Count <= 0)
         {
            return;
         }
         _loc3_ = this.FVipBox.Inventories.GetInventoryByIndex(0);
         this.FContextExplain0 += TUtilityString.Format(STRING_VIPFREEBUY.STRINGS_DAY_REWARDS,1);
         this.FContextExplain0 += _loc3_.Name + "*" + _loc3_.Quantity;
         BoundsAlignDown(this.FBoundsExplain0);
         this.FPainterExplain0.Text = this.FContextExplain0;
         this.FPainterExplain0.Evaluate(this.FBoundsExplain0);
         BoundsContextUnion(this.FBoundsExplain0);
      }
      
      protected function EvaluationPerform_Explain1() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         this.FVipBox = FContext as TVipBox;
         this.FContextExplain1 = "";
         if(this.FVipBox.Inventories.Count <= 1)
         {
            return;
         }
         _loc3_ = this.FVipBox.Inventories.GetInventoryByIndex(1);
         this.FContextExplain1 += TUtilityString.Format(STRING_VIPFREEBUY.STRINGS_DAY_REWARDS,2);
         this.FContextExplain1 += _loc3_.Name + "*" + _loc3_.Quantity;
         BoundsAlignDown(this.FBoundsExplain1);
         this.FPainterExplain1.Text = this.FContextExplain1;
         this.FPainterExplain1.Evaluate(this.FBoundsExplain1);
         BoundsContextUnion(this.FBoundsExplain1);
      }
      
      protected function EvaluationPerform_Explain2() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         this.FVipBox = FContext as TVipBox;
         this.FContextExplain2 = "";
         if(this.FVipBox.Inventories.Count <= 2)
         {
            return;
         }
         _loc3_ = this.FVipBox.Inventories.GetInventoryByIndex(2);
         this.FContextExplain2 += TUtilityString.Format(STRING_VIPFREEBUY.STRINGS_DAY_REWARDS,3);
         this.FContextExplain2 += _loc3_.Name + "*" + _loc3_.Quantity;
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
         this.FVipBox = FContext as TVipBox;
         this.FContextExplain3 = "";
         if(this.FVipBox.Inventories.Count <= 3)
         {
            return;
         }
         _loc3_ = this.FVipBox.Inventories.GetInventoryByIndex(3);
         this.FContextExplain3 += TUtilityString.Format(STRING_VIPFREEBUY.STRINGS_DAY_REWARDS,4);
         this.FContextExplain3 += _loc3_.Name + "*" + _loc3_.Quantity;
         BoundsAlignDown(this.FBoundsExplain3);
         this.FPainterExplain3.Text = this.FContextExplain3;
         this.FPainterExplain3.Evaluate(this.FBoundsExplain3);
         BoundsContextUnion(this.FBoundsExplain3);
      }
      
      protected function EvaluationPerform_Explain4() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         this.FVipBox = FContext as TVipBox;
         this.FContextExplain4 = "";
         if(this.FVipBox.Inventories.Count <= 4)
         {
            return;
         }
         _loc3_ = this.FVipBox.Inventories.GetInventoryByIndex(4);
         this.FContextExplain4 += TUtilityString.Format(STRING_VIPFREEBUY.STRINGS_DAY_REWARDS,5);
         this.FContextExplain4 += _loc3_.Name + "*" + _loc3_.Quantity;
         BoundsAlignDown(this.FBoundsExplain4);
         this.FPainterExplain4.Text = this.FContextExplain4;
         this.FPainterExplain4.Evaluate(this.FBoundsExplain4);
         BoundsContextUnion(this.FBoundsExplain4);
      }
      
      protected function EvaluationPerform_Today() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         var _loc5_:TVipFreeBuy = null;
         _loc5_ = SLogicsCore.VipFreeBuy;
         this.FVipBox = FContext as TVipBox;
         this.FContextToday = "";
         _loc1_ = _loc5_.GetBoxDay[this.FVipBox.Identify - 1];
         _loc3_ = _loc5_.RewardStatus[this.FVipBox.Identify - 1];
         if(_loc3_ == 1)
         {
            if(_loc1_ < 5)
            {
               _loc4_ = this.FVipBox.Inventories.GetInventoryByIndex(_loc1_);
               this.FContextToday = "\n" + STRING_VIPFREEBUY.STRINGS_NEXT_DAY_GET;
               this.FContextToday += _loc4_.Name + "*" + _loc4_.Quantity + "\n";
            }
            else
            {
               this.FContextToday = "\n" + STRING_VIPFREEBUY.STRINGS_ALL_GOT + "\n";
            }
         }
         else
         {
            _loc4_ = this.FVipBox.Inventories.GetInventoryByIndex(_loc1_);
            this.FContextToday = "\n" + STRING_VIPFREEBUY.STRINGS_DAY_GET;
            this.FContextToday += _loc4_.Name + "*" + _loc4_.Quantity + "\n";
         }
         BoundsAlignDown(this.FBoundsToday);
         this.FPainterToday.Text = this.FContextToday;
         this.FPainterToday.Evaluate(this.FBoundsToday);
         BoundsContextUnion(this.FBoundsToday);
      }
      
      protected function EvaluationPerform_Status() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         var _loc4_:int = 0;
         var _loc5_:TVipFreeBuy = null;
         _loc5_ = SLogicsCore.VipFreeBuy;
         _loc4_ = _loc5_.RewardStatus[this.FVipBox.Identify - 1];
         this.FVipBox = FContext as TVipBox;
         this.FContextStatus = "";
         if(_loc4_ == 1)
         {
            this.FContextStatus = "\n" + STRING_VIPFREEBUY.STRINGS_HAVE_GOT + "\n";
         }
         else if(_loc4_ == 0)
         {
            this.FContextStatus = "\n" + STRING_VIPFREEBUY.STRINGS_NEVER_GOT + "\n";
         }
         else
         {
            this.FContextStatus = "\n" + STRING_VIPFREEBUY.STRINGS_NEVER_BUY + "\n";
         }
         BoundsAlignDown(this.FBoundsStatus);
         this.FPainterStatus.Text = this.FContextStatus;
         this.FPainterStatus.Evaluate(this.FBoundsStatus);
         BoundsContextUnion(this.FBoundsStatus);
      }
      
      protected function EvaluationPerform_Count() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TVipFreeBuy = null;
         _loc4_ = SLogicsCore.VipFreeBuy;
         _loc3_ = _loc4_.RewardStatus[this.FVipBox.Identify - 1];
         this.FVipBox = FContext as TVipBox;
         _loc1_ = this.FVipBox.Inventories.Count;
         this.FContextCount = "";
         _loc2_ = _loc1_ - _loc4_.GetBoxDay[this.FVipBox.Identify - 1];
         this.FContextCount = STRING_VIPFREEBUY.STRINGS_REMAIN_DAY + _loc2_ + "\n";
         BoundsAlignDown(this.FBoundsCount);
         this.FPainterCount.Text = this.FContextCount;
         this.FPainterCount.Evaluate(this.FBoundsCount);
         BoundsContextUnion(this.FBoundsCount);
      }
      
      protected function EvaluationPerform_Price() : void
      {
         this.FVipBox = FContext as TVipBox;
         this.FContextPrice = "";
         this.FContextPrice = TUtilityString.Format(STRING_VIPFREEBUY.STRINGS_BOX_PRICE,this.FVipBox.Price);
         BoundsAlignDown(this.FBoundsPrice);
         this.FPainterPrice.Text = this.FContextPrice;
         this.FPainterPrice.Evaluate(this.FBoundsPrice);
         BoundsContextUnion(this.FBoundsPrice);
      }
      
      override protected function SketchingPerform_Context() : void
      {
         this.SketchingPerform_Caption();
         this.SketchingPerform_Explain0();
         this.SketchingPerform_Explain1();
         this.SketchingPerform_Explain2();
         this.SketchingPerform_Explain3();
         this.SketchingPerform_Explain4();
         this.SketchingPerform_Today();
         this.SketchingPerform_Status();
         this.SketchingPerform_Count();
         this.SketchingPerform_Price();
      }
      
      protected function SketchingPerform_Caption() : void
      {
         this.FBoundsCaption.Width = FBoundsContext.Width;
         this.FPainterCaption.RenderBounds(this.FBoundsCaption,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Explain0() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         this.FVipBox = FContext as TVipBox;
         this.FPainterExplain0.RenderBounds(this.FBoundsExplain0,TAlignment.HORIZONTAL_Center);
         if(this.FVipBox.Inventories.Count <= 0)
         {
            return;
         }
         _loc5_ = this.FVipBox.Inventories.GetInventoryByIndex(0);
         this.FExplainTextFormat.color = QUALITYCOLOR_INDEX[_loc5_.Quality];
         _loc3_ = this.FContextExplain0.indexOf(":") + 1;
         _loc4_ = this.FContextExplain0.length;
         this.FPainterExplain0.SetTextFormat(this.FExplainTextFormat,_loc3_,_loc4_);
      }
      
      protected function SketchingPerform_Explain1() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         this.FVipBox = FContext as TVipBox;
         this.FPainterExplain1.RenderBounds(this.FBoundsExplain1,TAlignment.HORIZONTAL_Center);
         if(this.FVipBox.Inventories.Count <= 1)
         {
            return;
         }
         _loc5_ = this.FVipBox.Inventories.GetInventoryByIndex(1);
         this.FExplainTextFormat.color = QUALITYCOLOR_INDEX[_loc5_.Quality];
         _loc3_ = this.FContextExplain1.indexOf(":") + 1;
         _loc4_ = this.FContextExplain1.length;
         this.FPainterExplain1.SetTextFormat(this.FExplainTextFormat,_loc3_,_loc4_);
      }
      
      protected function SketchingPerform_Explain2() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         this.FVipBox = FContext as TVipBox;
         this.FPainterExplain2.RenderBounds(this.FBoundsExplain2,TAlignment.HORIZONTAL_Center);
         if(this.FVipBox.Inventories.Count <= 2)
         {
            return;
         }
         _loc5_ = this.FVipBox.Inventories.GetInventoryByIndex(2);
         this.FExplainTextFormat.color = QUALITYCOLOR_INDEX[_loc5_.Quality];
         _loc3_ = this.FContextExplain2.indexOf(":") + 1;
         _loc4_ = this.FContextExplain2.length;
         this.FPainterExplain2.SetTextFormat(this.FExplainTextFormat,_loc3_,_loc4_);
      }
      
      protected function SketchingPerform_Explain3() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         this.FVipBox = FContext as TVipBox;
         this.FPainterExplain3.RenderBounds(this.FBoundsExplain3,TAlignment.HORIZONTAL_Center);
         if(this.FVipBox.Inventories.Count <= 3)
         {
            return;
         }
         _loc5_ = this.FVipBox.Inventories.GetInventoryByIndex(3);
         this.FExplainTextFormat.color = QUALITYCOLOR_INDEX[_loc5_.Quality];
         _loc3_ = this.FContextExplain3.indexOf(":") + 1;
         _loc4_ = this.FContextExplain3.length;
         this.FPainterExplain3.SetTextFormat(this.FExplainTextFormat,_loc3_,_loc4_);
      }
      
      protected function SketchingPerform_Explain4() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         this.FVipBox = FContext as TVipBox;
         this.FPainterExplain4.RenderBounds(this.FBoundsExplain4,TAlignment.HORIZONTAL_Center);
         if(this.FVipBox.Inventories.Count <= 4)
         {
            return;
         }
         _loc5_ = this.FVipBox.Inventories.GetInventoryByIndex(4);
         this.FExplainTextFormat.color = QUALITYCOLOR_INDEX[_loc5_.Quality];
         _loc3_ = this.FContextExplain4.indexOf(":") + 1;
         _loc4_ = this.FContextExplain4.length;
         this.FPainterExplain4.SetTextFormat(this.FExplainTextFormat,_loc3_,_loc4_);
      }
      
      protected function SketchingPerform_Today() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         var _loc6_:TVipFreeBuy = null;
         var _loc7_:int = 0;
         _loc6_ = SLogicsCore.VipFreeBuy;
         this.FVipBox = FContext as TVipBox;
         this.FPainterToday.RenderBounds(this.FBoundsToday,TAlignment.HORIZONTAL_Center);
         _loc1_ = _loc6_.GetBoxDay[this.FVipBox.Identify - 1];
         _loc7_ = _loc6_.RewardStatus[this.FVipBox.Identify - 1];
         if(_loc1_ < 5)
         {
            _loc5_ = this.FVipBox.Inventories.GetInventoryByIndex(_loc1_);
            _loc5_ = this.FVipBox.Inventories.GetInventoryByIndex(_loc1_);
            this.FExplainTextFormat.color = QUALITYCOLOR_INDEX[_loc5_.Quality];
            _loc3_ = this.FContextToday.indexOf(":") + 1;
            _loc4_ = this.FContextToday.length - 1;
            this.FPainterToday.SetTextFormat(this.FExplainTextFormat,_loc3_,_loc4_);
         }
      }
      
      protected function SketchingPerform_Status() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TVipFreeBuy = null;
         this.FPainterStatus.RenderBounds(this.FBoundsStatus,TAlignment.HORIZONTAL_Center);
         this.FVipBox = FContext as TVipBox;
         _loc2_ = SLogicsCore.VipFreeBuy;
         this.FPainterToday.RenderBounds(this.FBoundsToday,TAlignment.HORIZONTAL_Center);
         _loc1_ = _loc2_.RewardStatus[this.FVipBox.Identify - 1];
         if(_loc1_ == -1)
         {
            this.FExplainTextFormat.color = COLOR_ContextStatusCantGet;
         }
         else if(_loc1_ == 0)
         {
            this.FExplainTextFormat.color = COLOR_ContextStatusCanGet;
         }
         else
         {
            this.FExplainTextFormat.color = COLOR_ContextStatusHaveGot;
         }
         this.FPainterStatus.SetTextFormat(this.FExplainTextFormat);
      }
      
      protected function SketchingPerform_Count() : void
      {
         this.FPainterCount.RenderBounds(this.FBoundsCount,TAlignment.HORIZONTAL_Center);
      }
      
      protected function SketchingPerform_Price() : void
      {
         this.FPainterPrice.RenderBounds(this.FBoundsCount,TAlignment.HORIZONTAL_Center);
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
         this.FPainterToday.x = FBoundsRendering.X;
         this.FPainterToday.y = FBoundsRendering.Y + this.FBoundsToday.Y;
         this.FPainterStatus.x = FBoundsRendering.X;
         this.FPainterStatus.y = FBoundsRendering.Y + this.FBoundsStatus.Y;
         this.FPainterCount.x = FBoundsRendering.X;
         this.FPainterCount.y = FBoundsRendering.Y + this.FBoundsCount.Y;
         this.FPainterPrice.x = FBoundsRendering.X;
         this.FPainterPrice.y = FBoundsRendering.Y + this.FBoundsPrice.Y;
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

