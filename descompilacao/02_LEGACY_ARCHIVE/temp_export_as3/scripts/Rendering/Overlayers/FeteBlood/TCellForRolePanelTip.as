package Rendering.Overlayers.FeteBlood
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityCartisian;
   import Logics.BloodFete.TBloodFeteSingle;
   import Logics.Characters.THero;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_FETEBLOODMAINMANAGE;
   
   public class TCellForRolePanelTip extends TOverlayer
   {
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_YELLOW:uint = 4294967040;
      
      protected static const COLOR_Context_BLUE:uint = 4278228735;
      
      public static const Count:int = 12;
      
      protected var TPName:TPainterTextEffect;
      
      protected var FBName:TBounds;
      
      protected var TPDesOne:Vector.<TPainterTextEffect>;
      
      protected var FBDesOne:Vector.<TBounds>;
      
      protected var TPDesTwo:Vector.<TPainterTextEffect>;
      
      protected var FBDesTwo:Vector.<TBounds>;
      
      protected var FBloodFeteMounted:Vector.<TBloodFeteSingle>;
      
      protected var StrOne:Vector.<String>;
      
      protected var StrTwo:Vector.<String>;
      
      protected var ColorUint:Vector.<uint>;
      
      protected var FCurHero:THero;
      
      protected var FIsShow:Boolean;
      
      public function TCellForRolePanelTip(param1:TUIComponent)
      {
         super(param1);
         this.TPName = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBName = new TBounds();
         this.TPDesOne = new Vector.<TPainterTextEffect>(Count);
         this.FBDesOne = new Vector.<TBounds>(Count);
         this.TPDesTwo = new Vector.<TPainterTextEffect>(Count);
         this.FBDesTwo = new Vector.<TBounds>(Count);
         this.StrOne = new Vector.<String>();
         this.StrTwo = new Vector.<String>();
         this.ColorUint = new Vector.<uint>();
         var _loc2_:int = 0;
         while(_loc2_ < Count)
         {
            this.TPDesOne[_loc2_] = ConstructPainterTextEffect(COLOR_Context_White);
            this.FBDesOne[_loc2_] = new TBounds();
            this.TPDesTwo[_loc2_] = ConstructPainterTextEffect(COLOR_Context_White);
            this.FBDesTwo[_loc2_] = new TBounds();
            _loc2_++;
         }
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
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
      
      override protected function EvaluationPerform_Context() : void
      {
         this.FCurHero = FContext as THero;
         this.dEs();
      }
      
      protected function dEs() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBloodFeteSingle = null;
         var _loc6_:Array = null;
         this.StrOne.length = 0;
         this.StrTwo.length = 0;
         this.ColorUint.length = 0;
         this.FBloodFeteMounted = this.FCurHero.BloodFeteMounted;
         _loc1_ = int(this.FBloodFeteMounted.length);
         var _loc5_:String = STRING_FETEBLOODMAINMANAGE.STRING_None;
         if(_loc1_ == 0)
         {
            this.FIsShow = true;
            this.StrOne.push(STRING_FETEBLOODMAINMANAGE.STRING_NOONE);
            this.StrTwo.push("");
         }
         else
         {
            this.FIsShow = false;
            _loc5_ = "";
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc4_ = this.FBloodFeteMounted[_loc2_];
               _loc3_ = 0;
               while(_loc3_ < _loc4_.AddAttrArr.length)
               {
                  _loc6_ = _loc4_.AddAttrArr[_loc3_];
                  this.StrOne.push(_loc4_.Name);
                  this.ColorUint.push(_loc4_.Quality);
                  this.StrTwo.push(STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc6_[0])] + " +" + this.getProptyScr(_loc6_));
                  _loc3_++;
               }
               _loc2_++;
            }
         }
         _loc2_ = 0;
         while(_loc2_ < Count)
         {
            this.TPDesOne[_loc2_].visible = false;
            this.TPDesTwo[_loc2_].visible = false;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.StrOne.length)
         {
            this.TPDesOne[_loc2_].visible = true;
            this.TPDesTwo[_loc2_].visible = true;
            this.BoundsAlignDown(this.FBDesOne[_loc2_]);
            if(this.FIsShow)
            {
               this.TPDesOne[_loc2_].Text = this.StrOne[_loc2_];
            }
            else
            {
               this.TPDesOne[_loc2_].Text = this.StrOne[_loc2_] + ":";
               this.TPDesOne[_loc2_].Font.Color = QUALITYCOLOR_INDEX[this.ColorUint[_loc2_]];
            }
            this.TPDesOne[_loc2_].Evaluate(this.FBDesOne[_loc2_]);
            BoundsContextUnion(this.FBDesOne[_loc2_]);
            this.BoundsAlignDownCopy(this.FBDesTwo[_loc2_],this.FBDesOne[_loc2_]);
            this.TPDesTwo[_loc2_].Text = this.StrTwo[_loc2_];
            this.TPDesTwo[_loc2_].Evaluate(this.FBDesTwo[_loc2_]);
            BoundsContextUnion(this.FBDesTwo[_loc2_]);
            _loc2_++;
         }
      }
      
      protected function BoundsAlignDownCopy(param1:TBounds, param2:TBounds = null, param3:int = 0) : void
      {
         if(param2 == null)
         {
            param2 = FBoundsContext;
         }
         TUtilityCartisian.CoordinateSet(param1,param2.X + param2.Width,param2.Y + param3);
      }
      
      override protected function BoundsAlignDown(param1:TBounds, param2:TBounds = null, param3:int = 0) : void
      {
         if(param2 == null)
         {
            param2 = FBoundsContext;
         }
         TUtilityCartisian.CoordinateSet(param1,param2.X,param2.YEnd + param3);
      }
      
      protected function nAme() : void
      {
         this.BoundsAlignDown(this.FBName);
         this.TPName.Text = STRING_FETEBLOODMAINMANAGE.DOntTip;
         this.TPName.Evaluate(this.FBName);
         BoundsContextUnion(this.FBName);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.TPName.X = FBoundsRendering.X + this.FBName.X;
         this.TPName.Y = FBoundsRendering.Y + this.FBName.Y;
         var _loc2_:int = 0;
         while(_loc2_ < this.StrOne.length)
         {
            this.TPDesOne[_loc2_].X = FBoundsRendering.X + this.FBDesOne[_loc2_].X;
            this.TPDesOne[_loc2_].Y = FBoundsRendering.Y + this.FBDesOne[_loc2_].Y;
            this.TPDesTwo[_loc2_].X = FBoundsRendering.X + this.FBDesTwo[_loc2_].X;
            this.TPDesTwo[_loc2_].Y = FBoundsRendering.Y + this.FBDesTwo[_loc2_].Y;
            _loc2_++;
         }
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
      
      public function getProptyScr(param1:Array) : String
      {
         var _loc2_:String = null;
         if(param1[1] < 1)
         {
            _loc2_ = Number(param1[1] * 100).toFixed(1) + "%";
         }
         else
         {
            _loc2_ = String(param1[1]);
         }
         return _loc2_;
      }
   }
}

