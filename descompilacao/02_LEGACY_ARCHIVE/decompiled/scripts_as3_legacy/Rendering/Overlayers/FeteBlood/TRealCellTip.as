package Rendering.Overlayers.FeteBlood
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.BloodFete.TBloodFeteSingle;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_FETEBLOODMAINMANAGE;
   
   public class TRealCellTip extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_YELLOW:uint = 4294967040;
      
      protected static const COLOR_Context_BLUE:uint = 4278228735;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected static const PropertyCount:int = 4;
      
      protected var TPName:TPainterTextEffect;
      
      protected var FBName:TBounds;
      
      protected var TPDesVec:Vector.<TPainterTextEffect>;
      
      protected var FBDesVec:Vector.<TBounds>;
      
      protected var TPExp:TPainterTextEffect;
      
      protected var FBExp:TBounds;
      
      protected var StrArr:Vector.<String>;
      
      protected var FCur:TBloodFeteSingle;
      
      public function TRealCellTip(param1:TUIComponent)
      {
         var _loc2_:int = 0;
         super(param1);
         this.TPName = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBName = new TBounds();
         this.StrArr = new Vector.<String>();
         this.TPDesVec = new Vector.<TPainterTextEffect>(PropertyCount);
         this.FBDesVec = new Vector.<TBounds>(PropertyCount);
         _loc2_ = 0;
         while(_loc2_ < PropertyCount)
         {
            this.TPDesVec[_loc2_] = ConstructPainterTextEffect(COLOR_Context_BLUE);
            this.FBDesVec[_loc2_] = new TBounds();
            _loc2_++;
         }
         this.TPExp = ConstructPainterTextEffect(COLOR_Context_YELLOW);
         this.FBExp = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         this.FCur = FContext as TBloodFeteSingle;
         this.nAme();
         this.eXp();
         this.dEs();
      }
      
      protected function nAme() : void
      {
         BoundsAlignDown(this.FBName);
         this.TPName.Text = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.STRING_Name_Level,this.FCur.Name,this.FCur.Level);
         if(this.FCur.Type == 3)
         {
            this.TPName.Font.Color = QUALITYCOLOR_INDEX[6];
         }
         else
         {
            this.TPName.Font.Color = QUALITYCOLOR_INDEX[this.FCur.Quality];
         }
         this.TPName.Evaluate(this.FBName);
         BoundsContextUnion(this.FBName);
      }
      
      protected function eXp() : void
      {
         BoundsAlignDown(this.FBExp);
         this.TPExp.Text = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.STRING_Function_Exp,this.FCur.Exp,this.FCur.AllExp);
         this.TPExp.Evaluate(this.FBExp);
         BoundsContextUnion(this.FBExp);
      }
      
      protected function dEs() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         this.StrArr.length = 0;
         var _loc1_:String = STRING_FETEBLOODMAINMANAGE.STRING_None;
         if(this.FCur.AddAttrArr != null)
         {
            _loc1_ = "";
            _loc2_ = 0;
            while(_loc2_ < this.FCur.AddAttrArr.length)
            {
               _loc3_ = this.FCur.AddAttrArr[_loc2_];
               this.StrArr[_loc2_] = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc3_[0])] + " +" + this.getProptyScr(_loc3_);
               _loc2_++;
            }
         }
         _loc2_ = 0;
         while(_loc2_ < PropertyCount)
         {
            this.TPDesVec[_loc2_].visible = false;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.StrArr.length)
         {
            this.TPDesVec[_loc2_].visible = true;
            BoundsAlignDown(this.FBDesVec[_loc2_]);
            this.TPDesVec[_loc2_].Text = this.StrArr[_loc2_];
            this.TPDesVec[_loc2_].Evaluate(this.FBDesVec[_loc2_]);
            BoundsContextUnion(this.FBDesVec[_loc2_]);
            _loc2_++;
         }
      }
      
      public function getProptyScr(param1:Array) : String
      {
         var _loc2_:String = null;
         if(int(param1[1]) != param1[1])
         {
            _loc2_ = Number(param1[1] * 100).toFixed(1) + "%";
         }
         else
         {
            _loc2_ = String(param1[1]);
         }
         return _loc2_;
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
         this.TPExp.X = FBoundsRendering.X + this.FBExp.X;
         this.TPExp.Y = FBoundsRendering.Y + this.FBExp.Y;
         var _loc2_:int = 0;
         while(_loc2_ < this.StrArr.length)
         {
            this.TPDesVec[_loc2_].X = FBoundsRendering.X + this.FBDesVec[_loc2_].X;
            this.TPDesVec[_loc2_].Y = FBoundsRendering.Y + this.FBDesVec[_loc2_].Y;
            _loc2_++;
         }
      }
   }
}

