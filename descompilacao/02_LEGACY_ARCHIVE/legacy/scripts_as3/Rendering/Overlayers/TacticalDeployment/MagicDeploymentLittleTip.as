package Rendering.Overlayers.TacticalDeployment
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Logics.Magic.TMagic;
   import Logics.Magic.TMagicData;
   import Logics.SLogicsCore;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Strings.STRING_COMMON;
   
   public class MagicDeploymentLittleTip extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4293708148;
      
      public static const four:int = 4;
      
      protected var FMagicData:TMagicData;
      
      protected var FPMagicName:TPainterTextEffect;
      
      protected var FBMagicName:TBounds;
      
      protected var FPMagicNameOne:TPainterTextEffect;
      
      protected var FBMagicNameOne:TBounds;
      
      protected var FPTwo:Vector.<TPainterTextEffect>;
      
      protected var FBTwo:Vector.<TBounds>;
      
      protected var FPThree:Vector.<TPainterTextEffect>;
      
      protected var FBThree:Vector.<TBounds>;
      
      protected var FPFour:Vector.<TPainterTextEffect>;
      
      protected var FBFour:Vector.<TBounds>;
      
      protected var FPFive:Vector.<TPainterTextEffect>;
      
      protected var FBFive:Vector.<TBounds>;
      
      protected var BeforeValue:Vector.<int>;
      
      protected var CentreValue:Vector.<int>;
      
      protected var QueenValue:Vector.<int>;
      
      protected var HouValue:Vector.<int>;
      
      public function MagicDeploymentLittleTip(param1:TUIComponent)
      {
         var _loc2_:int = 0;
         var _loc3_:TPainterTextEffect = null;
         var _loc4_:TBounds = null;
         super(param1);
         this.BeforeValue = new Vector.<int>();
         this.CentreValue = new Vector.<int>();
         this.QueenValue = new Vector.<int>();
         this.HouValue = new Vector.<int>();
         this.FPTwo = new Vector.<TPainterTextEffect>(four);
         this.FBTwo = new Vector.<TBounds>(four);
         this.FPThree = new Vector.<TPainterTextEffect>(four);
         this.FBThree = new Vector.<TBounds>(four);
         this.FPFour = new Vector.<TPainterTextEffect>(four);
         this.FBFour = new Vector.<TBounds>(four);
         this.FPFive = new Vector.<TPainterTextEffect>(four);
         this.FBFive = new Vector.<TBounds>(four);
         _loc2_ = 0;
         while(_loc2_ < four)
         {
            _loc3_ = ConstructPainterTextEffect(COLOR_Context_White);
            _loc4_ = new TBounds();
            this.FPTwo[_loc2_] = _loc3_;
            this.FBTwo[_loc2_] = _loc4_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < four)
         {
            _loc3_ = ConstructPainterTextEffect(COLOR_Context_White);
            _loc4_ = new TBounds();
            this.FPThree[_loc2_] = _loc3_;
            this.FBThree[_loc2_] = _loc4_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < four)
         {
            _loc3_ = ConstructPainterTextEffect(COLOR_Context_White);
            _loc4_ = new TBounds();
            this.FPFour[_loc2_] = _loc3_;
            this.FBFour[_loc2_] = _loc4_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < four)
         {
            _loc3_ = ConstructPainterTextEffect(COLOR_Context_White);
            _loc4_ = new TBounds();
            this.FPFive[_loc2_] = _loc3_;
            this.FBFive[_loc2_] = _loc4_;
            _loc2_++;
         }
         this.FPMagicName = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBMagicName = new TBounds();
         this.FPMagicNameOne = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBMagicNameOne = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         this.FMagicData = SLogicsCore.MagicData;
         this.AnalysisData();
         this.ValuationName();
         this.ValuationOne();
         this.ValuationTwo();
         this.ValuationThree();
         this.ValuationFour();
         this.ValuationFive();
      }
      
      public function AnalysisData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TMagic = null;
         this.BeforeValue.length = 0;
         this.CentreValue.length = 0;
         this.QueenValue.length = 0;
         this.HouValue.length = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FMagicData.Magics.Count)
         {
            _loc2_ = this.FMagicData.Magics.GetMagicByIndex(_loc1_);
            this.getVector(_loc1_).push(_loc2_.Power,_loc2_.Agile,_loc2_.Intelligence,_loc2_.Life);
            _loc1_++;
         }
      }
      
      public function getVector(param1:int) : Vector.<int>
      {
         var _loc2_:Vector.<int> = null;
         switch(param1)
         {
            case 0:
               _loc2_ = this.BeforeValue;
               break;
            case 1:
               _loc2_ = this.CentreValue;
               break;
            case 2:
               _loc2_ = this.QueenValue;
               break;
            case 3:
               _loc2_ = this.HouValue;
         }
         return _loc2_;
      }
      
      public function getVectorByindex(param1:int) : Vector.<int>
      {
         var _loc2_:Vector.<int> = null;
         switch(param1)
         {
            case 0:
               _loc2_ = this.CentreValue;
               break;
            case 1:
               _loc2_ = this.BeforeValue;
               break;
            case 2:
               _loc2_ = this.QueenValue;
               break;
            case 3:
               _loc2_ = this.HouValue;
         }
         return _loc2_;
      }
      
      public function ValuationName() : void
      {
         BoundsAlignDown(this.FBMagicName);
         this.FPMagicName.Text = STRING_COMMON.STRING_NewString[4];
         this.FPMagicName.Evaluate(this.FBMagicName);
         BoundsContextUnion(this.FBMagicName);
      }
      
      public function ValuationOne() : void
      {
         BoundsAlignDown(this.FBMagicNameOne);
         this.FPMagicNameOne.Text = "       " + STRING_COMMON.STRING_NewString[5] + "         " + STRING_COMMON.STRING_NewString[6] + "         " + STRING_COMMON.STRING_NewString[7] + "         " + STRING_COMMON.STRING_NewString[8] + "                ";
         this.FPMagicNameOne.Evaluate(this.FBMagicNameOne);
         BoundsContextUnion(this.FBMagicNameOne);
      }
      
      public function ValuationTwo() : void
      {
         var _loc2_:int = 0;
         var _loc1_:String = "";
         if(this.CentreValue.length)
         {
            _loc2_ = 0;
            while(_loc2_ < four)
            {
               if(!_loc2_)
               {
                  BoundsAlignDown(this.FBTwo[0]);
               }
               if(!_loc2_)
               {
                  _loc1_ = STRING_COMMON.STRING_NewString[0] + ":  +" + this.getVectorByindex(_loc2_)[0] + "     ";
               }
               else
               {
                  _loc1_ = "  +" + this.getVectorByindex(_loc2_)[0] + "     ";
               }
               this.FPTwo[_loc2_].Text = _loc1_;
               this.FPTwo[_loc2_].Evaluate(this.FBTwo[0]);
               if(!_loc2_)
               {
                  BoundsContextUnion(this.FBTwo[0]);
               }
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < four)
            {
               if(!_loc2_)
               {
                  BoundsAlignDown(this.FBTwo[0]);
               }
               if(!_loc2_)
               {
                  _loc1_ = STRING_COMMON.STRING_NewString[0] + ":  +" + 0;
               }
               else
               {
                  _loc1_ = "  +" + 0;
               }
               this.FPTwo[_loc2_].Text = _loc1_;
               this.FPTwo[_loc2_].Evaluate(this.FBTwo[0]);
               if(!_loc2_)
               {
                  BoundsContextUnion(this.FBTwo[0]);
               }
               _loc2_++;
            }
         }
      }
      
      public function ValuationThree() : void
      {
         var _loc2_:int = 0;
         var _loc1_:String = "";
         if(this.BeforeValue.length)
         {
            _loc2_ = 0;
            while(_loc2_ < four)
            {
               if(!_loc2_)
               {
                  BoundsAlignDown(this.FBThree[0]);
               }
               if(!_loc2_)
               {
                  _loc1_ = STRING_COMMON.STRING_NewString[1] + ":  +" + this.getVectorByindex(_loc2_)[1] + "     ";
               }
               else
               {
                  _loc1_ = "  +" + this.getVectorByindex(_loc2_)[1] + "     ";
               }
               this.FPThree[_loc2_].Text = _loc1_;
               this.FPThree[_loc2_].Evaluate(this.FBThree[0]);
               if(!_loc2_)
               {
                  BoundsContextUnion(this.FBThree[0]);
               }
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < four)
            {
               if(!_loc2_)
               {
                  BoundsAlignDown(this.FBThree[0]);
               }
               if(!_loc2_)
               {
                  _loc1_ = STRING_COMMON.STRING_NewString[1] + ":  +" + 0;
               }
               else
               {
                  _loc1_ = "  +" + 0;
               }
               this.FPThree[_loc2_].Text = _loc1_;
               this.FPThree[_loc2_].Evaluate(this.FBThree[0]);
               if(!_loc2_)
               {
                  BoundsContextUnion(this.FBThree[0]);
               }
               _loc2_++;
            }
         }
      }
      
      public function ValuationFour() : void
      {
         var _loc2_:int = 0;
         var _loc1_:String = "";
         if(this.BeforeValue.length)
         {
            _loc2_ = 0;
            while(_loc2_ < four)
            {
               if(!_loc2_)
               {
                  BoundsAlignDown(this.FBFour[0]);
               }
               if(!_loc2_)
               {
                  _loc1_ = STRING_COMMON.STRING_NewString[2] + ":  +" + this.getVectorByindex(_loc2_)[2] + "     ";
               }
               else
               {
                  _loc1_ = "  +" + this.getVectorByindex(_loc2_)[2] + "     ";
               }
               this.FPFour[_loc2_].Text = _loc1_;
               this.FPFour[_loc2_].Evaluate(this.FBFour[0]);
               if(!_loc2_)
               {
                  BoundsContextUnion(this.FBFour[0]);
               }
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < four)
            {
               if(!_loc2_)
               {
                  BoundsAlignDown(this.FBFour[0]);
               }
               if(!_loc2_)
               {
                  _loc1_ = STRING_COMMON.STRING_NewString[2] + ":  +" + 0;
               }
               else
               {
                  _loc1_ = "  +" + 0;
               }
               this.FPFour[_loc2_].Text = _loc1_;
               this.FPFour[_loc2_].Evaluate(this.FBFour[0]);
               if(!_loc2_)
               {
                  BoundsContextUnion(this.FBFour[0]);
               }
               _loc2_++;
            }
         }
      }
      
      public function ValuationFive() : void
      {
         var _loc2_:int = 0;
         var _loc1_:String = "";
         if(this.BeforeValue.length)
         {
            _loc2_ = 0;
            while(_loc2_ < four)
            {
               if(!_loc2_)
               {
                  BoundsAlignDown(this.FBFive[0]);
               }
               if(!_loc2_)
               {
                  _loc1_ = STRING_COMMON.STRING_NewString[3] + ":  +" + this.getVectorByindex(_loc2_)[3] + "     ";
               }
               else
               {
                  _loc1_ = "  +" + this.getVectorByindex(_loc2_)[3] + "     ";
               }
               this.FPFive[_loc2_].Text = _loc1_;
               this.FPFive[_loc2_].Evaluate(this.FBFive[0]);
               if(!_loc2_)
               {
                  BoundsContextUnion(this.FBFive[0]);
               }
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < four)
            {
               if(!_loc2_)
               {
                  BoundsAlignDown(this.FBFive[0]);
               }
               if(!_loc2_)
               {
                  _loc1_ = STRING_COMMON.STRING_NewString[3] + ":  +" + 0;
               }
               else
               {
                  _loc1_ = "  +" + 0;
               }
               this.FPFive[_loc2_].Text = _loc1_;
               this.FPFive[_loc2_].Evaluate(this.FBFive[0]);
               if(!_loc2_)
               {
                  BoundsContextUnion(this.FBFive[0]);
               }
               _loc2_++;
            }
         }
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         var _loc2_:int = 0;
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPMagicName.X = FBoundsRendering.X + this.FBMagicName.X + 80;
         this.FPMagicName.Y = FBoundsRendering.Y + this.FBMagicName.Y;
         this.FPMagicNameOne.X = FBoundsRendering.X + this.FBMagicNameOne.X + 10;
         this.FPMagicNameOne.Y = FBoundsRendering.Y + this.FBMagicNameOne.Y;
         _loc2_ = 0;
         while(_loc2_ < four)
         {
            if(_loc2_)
            {
               switch(_loc2_)
               {
                  case 1:
                     this.FPTwo[_loc2_].X = this.FPTwo[0].X + 100;
                     break;
                  case 2:
                     this.FPTwo[_loc2_].X = this.FPTwo[0].X + 170;
                     break;
                  case 3:
                     this.FPTwo[_loc2_].X = this.FPTwo[0].X + 240;
               }
            }
            else
            {
               this.FPTwo[_loc2_].X = FBoundsRendering.X + this.FBTwo[_loc2_].X;
            }
            this.FPTwo[_loc2_].Y = FBoundsRendering.Y + this.FBTwo[0].Y;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < four)
         {
            if(_loc2_)
            {
               switch(_loc2_)
               {
                  case 1:
                     this.FPThree[_loc2_].X = this.FPTwo[0].X + 100;
                     break;
                  case 2:
                     this.FPThree[_loc2_].X = this.FPTwo[0].X + 170;
                     break;
                  case 3:
                     this.FPThree[_loc2_].X = this.FPTwo[0].X + 240;
               }
            }
            else
            {
               this.FPThree[_loc2_].X = FBoundsRendering.X + this.FBThree[_loc2_].X;
            }
            this.FPThree[_loc2_].Y = FBoundsRendering.Y + this.FBThree[0].Y;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < four)
         {
            if(_loc2_)
            {
               switch(_loc2_)
               {
                  case 1:
                     this.FPFour[_loc2_].X = this.FPTwo[0].X + 100;
                     break;
                  case 2:
                     this.FPFour[_loc2_].X = this.FPTwo[0].X + 170;
                     break;
                  case 3:
                     this.FPFour[_loc2_].X = this.FPTwo[0].X + 240;
               }
            }
            else
            {
               this.FPFour[_loc2_].X = FBoundsRendering.X + this.FBFour[_loc2_].X;
            }
            this.FPFour[_loc2_].Y = FBoundsRendering.Y + this.FBFour[0].Y;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < four)
         {
            if(_loc2_)
            {
               switch(_loc2_)
               {
                  case 1:
                     this.FPFive[_loc2_].X = this.FPTwo[0].X + 100;
                     break;
                  case 2:
                     this.FPFive[_loc2_].X = this.FPTwo[0].X + 170;
                     break;
                  case 3:
                     this.FPFive[_loc2_].X = this.FPTwo[0].X + 240;
               }
            }
            else
            {
               this.FPFive[_loc2_].X = FBoundsRendering.X + this.FBFive[_loc2_].X;
            }
            this.FPFive[_loc2_].Y = FBoundsRendering.Y + this.FBFive[0].Y;
            _loc2_++;
         }
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

