package Rendering.Overlayers.Inventories
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TLostsacredGenerate;
   import Logics.DatebaseVO.VO.TLostsacredUpgrade;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.LostShenqi.TJieXiObject;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_LOSTSHENQI;
   
   public class TOverShenQiEWaiAttriTip extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const SevenSenven:int = 17;
      
      protected var FPName:TPainterTextEffect;
      
      protected var FBName:TBounds;
      
      protected var FP1:Vector.<TPainterTextEffect>;
      
      protected var FB1:Vector.<TBounds>;
      
      protected var FNum:int;
      
      public function TOverShenQiEWaiAttriTip(param1:TUIComponent)
      {
         var _loc2_:TPainterTextEffect = null;
         var _loc3_:int = 0;
         super(param1);
         this.FPName = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBName = new TBounds();
         this.FP1 = new Vector.<TPainterTextEffect>(SevenSenven);
         this.FB1 = new Vector.<TBounds>(SevenSenven);
         _loc3_ = 0;
         while(_loc3_ < SevenSenven)
         {
            _loc2_ = ConstructPainterTextEffect(COLOR_Context_White);
            this.FP1[_loc3_] = _loc2_;
            this.FB1[_loc3_] = new TBounds();
            _loc3_++;
         }
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:THero = FContext as THero;
         this.SetValue(_loc1_);
      }
      
      protected function SetValue(param1:THero) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:TLostsacredUpgrade = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:TJieXiObject = null;
         var _loc10_:TJieXiObject = null;
         var _loc11_:TInventory = null;
         _loc10_ = new TJieXiObject(null);
         _loc2_ = uint(param1.TalismansMounted.Capacity);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc11_ = param1.TalismansMounted.GetInventoryByIndex(_loc3_);
            if(_loc11_ != null && this.GetBoo(_loc11_))
            {
               _loc5_ = _loc11_.IDTemplate.toString() + 0;
               _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_LostsacredUpgrade,uint(_loc5_)) as TLostsacredUpgrade;
               _loc9_ = _loc6_.JieXiObject;
               if(_loc9_)
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc9_.LevelVector.length)
                  {
                     if(_loc11_.UpgradingLevel >= _loc9_.LevelVector[_loc4_])
                     {
                        _loc10_.LevelVector.push(_loc9_.LevelVector[_loc4_]);
                        _loc10_.Value0Vector.push(_loc9_.Value0Vector[_loc4_]);
                        _loc10_.Value1Vector.push(_loc9_.Value1Vector[_loc4_]);
                        _loc10_.Value2Vector.push(_loc9_.Value2Vector[_loc4_]);
                        _loc10_.Value3Vector.push(_loc9_.Value3Vector[_loc4_]);
                     }
                     _loc4_++;
                  }
               }
            }
            _loc3_++;
         }
         BoundsAlignDown(this.FBName);
         _loc2_ = _loc10_.LevelVector.length;
         if(_loc2_ > 0)
         {
            this.FPName.Text = STRING_LOSTSHENQI.str6;
         }
         else
         {
            this.FPName.Text = STRING_LOSTSHENQI.str7;
         }
         this.FPName.Evaluate(this.FBName);
         BoundsContextUnion(this.FBName);
         this.FNum = _loc2_;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            BoundsAlignDown(this.FB1[_loc3_]);
            _loc7_ = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc10_.Value0Vector[_loc3_]);
            _loc8_ = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc7_];
            if(_loc10_.Value3Vector[_loc3_] == 1)
            {
               _loc5_ = TUtilityString.Format(STRING_LOSTSHENQI.str2,_loc8_,this.ChangeToRateString(_loc10_.Value1Vector[_loc3_],_loc10_.Value2Vector[_loc3_]));
            }
            else
            {
               _loc5_ = TUtilityString.Format(STRING_LOSTSHENQI.str2,_loc8_,_loc10_.Value1Vector[_loc3_]);
            }
            this.FP1[_loc3_].Text = _loc5_;
            this.FP1[_loc3_].Evaluate(this.FB1[_loc3_]);
            BoundsContextUnion(this.FB1[_loc3_]);
            _loc3_++;
         }
      }
      
      protected function ChangeToRateString(param1:uint, param2:uint) : String
      {
         if(param2 == 1000)
         {
            return param1 / 10 + "%";
         }
         return param1 + "%";
      }
      
      protected function GetBoo(param1:TInventory) : Boolean
      {
         var _loc2_:TLostsacredGenerate = null;
         _loc2_ = SLogicsCore.LostShenQiLogicData.LostsacredGenerateBins.GetDatebaseByValue("ArtifactId",param1.IDTemplate) as TLostsacredGenerate;
         if(_loc2_)
         {
            return true;
         }
         return false;
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         var _loc2_:int = 0;
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPName.X = FBoundsRendering.X + this.FBName.X;
         this.FPName.Y = FBoundsRendering.Y + this.FBName.Y;
         _loc2_ = 0;
         while(_loc2_ < SevenSenven)
         {
            if(_loc2_ >= this.FNum)
            {
               this.FP1[_loc2_].X = FBoundsRendering.X + this.FB1[_loc2_].X;
               this.FP1[_loc2_].Y = 0;
               this.FP1[_loc2_].Visible = false;
            }
            else
            {
               this.FP1[_loc2_].X = FBoundsRendering.X + this.FB1[_loc2_].X;
               this.FP1[_loc2_].Y = FBoundsRendering.Y + this.FB1[_loc2_].Y;
               this.FP1[_loc2_].Visible = true;
            }
            _loc2_++;
         }
      }
      
      override protected function ContextModified() : Boolean
      {
         return true;
      }
   }
}

