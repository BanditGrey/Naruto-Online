package Rendering.Overlayers.OhtsutsukiKaguya
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.OhtsutsukiKaguya.Data.OhtsutsukiKaguyaData;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_OhtsutsukiKaguya;
   
   public class TOverOhtsutsukiKaguyaIcon extends TOverlayer
   {
      
      protected static const COLOR_Context_YELLOW:uint = 4294967040;
      
      protected static const COLOR_Context_HUI:uint = 4291611852;
      
      public static const TEN:int = 7;
      
      public static const Three:int = 3;
      
      protected var FPainter01:TPainterTextEffect;
      
      protected var FBounds01:TBounds;
      
      protected var FPainter02:TPainterTextEffect;
      
      protected var FBounds02:TBounds;
      
      protected var FPainter03:TPainterTextEffect;
      
      protected var FBounds03:TBounds;
      
      protected var FPainter04:TPainterTextEffect;
      
      protected var FBounds04:TBounds;
      
      protected var FPainter05:TPainterTextEffect;
      
      protected var FBounds05:TBounds;
      
      protected var FPainter06:TPainterTextEffect;
      
      protected var FBounds06:TBounds;
      
      protected var FPainter07:TPainterTextEffect;
      
      protected var FBounds07:TBounds;
      
      protected var FPainterVec:Vector.<TPainterTextEffect>;
      
      protected var FBounds:Vector.<TBounds>;
      
      protected var wc:OhtsutsukiKaguyaData;
      
      protected var CurState:int;
      
      public function TOverOhtsutsukiKaguyaIcon(param1:TUIComponent)
      {
         var _loc2_:int = 0;
         super(param1);
         this.FPainterVec = new Vector.<TPainterTextEffect>(TEN);
         this.FBounds = new Vector.<TBounds>(TEN);
         _loc2_ = 0;
         while(_loc2_ < TEN)
         {
            this.FPainterVec[_loc2_] = ConstructPainterTextEffect(COLOR_Context_YELLOW);
            this.FBounds[_loc2_] = new TBounds();
            _loc2_++;
         }
         FMarginLeft = 10;
         FMarginTop = 10;
         FMarginRight = 10;
         FMarginBottom = 10;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:int = 0;
         if(SLogicsCore.KaguyaData.OpenState == 0)
         {
            this.CurState = 0;
         }
         else if(SLogicsCore.KaguyaData.IsLongTime == 7)
         {
            this.CurState = 1;
         }
         else
         {
            this.CurState = 2;
         }
         _loc1_ = FContext as int;
         this.EvaluationPerform_Caption();
      }
      
      override public function set Context(param1:Object) : void
      {
         FContext = param1;
         FModified = true;
      }
      
      protected function EvaluationPerform_Caption() : void
      {
         var _loc1_:int = 0;
         this.wc = SLogicsCore.KaguyaData;
         FModified = true;
         var _loc2_:String = "";
         _loc1_ = 0;
         while(_loc1_ < this.wc.PropertyValueVec.length + Three)
         {
            BoundsAlignDown(this.FBounds[_loc1_]);
            if(_loc1_ == 0)
            {
               _loc2_ = TUtilityString.Format(STRING_OhtsutsukiKaguya.Icpn_Tip_Html1,SLogicsCore.KaguyaData.CurLevel);
            }
            else if(_loc1_ == 1)
            {
               _loc2_ = TUtilityString.Format(STRING_OhtsutsukiKaguya.Icpn_Tip_Html4,this.CurState == 1 ? STRING_OhtsutsukiKaguya.OnePanel_Up_Dec_03 : STRING_OhtsutsukiKaguya.OnePanel_Up_Dec_05);
            }
            else if(_loc1_ == 2)
            {
               _loc2_ = STRING_OhtsutsukiKaguya.Icpn_Tip_Html2;
            }
            else
            {
               _loc2_ = TUtilityString.Format(STRING_OhtsutsukiKaguya.Icpn_Tip_Html3,STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[CONST_COMMON.BASEATTRIBUTENAMES.indexOf(this.wc.PropertyTypeVec[_loc1_ - Three])],this.wc.PropertyValueVec[_loc1_ - Three]);
            }
            this.FPainterVec[_loc1_].Text = _loc2_;
            if(this.CurState == 1 && _loc1_ >= 2)
            {
               this.FPainterVec[_loc1_].Font.Color = COLOR_Context_HUI;
            }
            else
            {
               this.FPainterVec[_loc1_].Font.Color = COLOR_Context_YELLOW;
            }
            this.FPainterVec[_loc1_].Evaluate(this.FBounds[_loc1_]);
            BoundsContextUnion(this.FBounds[_loc1_]);
            _loc1_++;
         }
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         var _loc2_:int = 0;
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         _loc2_ = 0;
         while(_loc2_ < TEN)
         {
            if(_loc2_ < this.wc.PropertyValueVec.length + Three)
            {
               this.FPainterVec[_loc2_].visible = true;
               this.FPainterVec[_loc2_].X = this.FBounds[_loc2_].X + FBoundsRendering.X;
               this.FPainterVec[_loc2_].Y = this.FBounds[_loc2_].Y + FBoundsRendering.Y;
            }
            else
            {
               this.FPainterVec[_loc2_].visible = false;
               this.FPainterVec[_loc2_].Y = 0;
            }
            _loc2_++;
         }
      }
      
      override public function Show() : void
      {
         if(this.CurState == 0)
         {
            return;
         }
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
   }
}

