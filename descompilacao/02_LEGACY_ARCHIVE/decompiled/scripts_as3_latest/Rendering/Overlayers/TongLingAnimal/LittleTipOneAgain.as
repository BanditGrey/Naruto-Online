package Rendering.Overlayers.TongLingAnimal
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_INHERITPRACTICE;
   import Resources.Strings.STRING_TONGLING;
   
   public class LittleTipOneAgain extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected var FTongLingScri:TPainterTextEffect;
      
      protected var FBoundsScri:TBounds;
      
      protected var FGoldPuergatoryArr:Vector.<uint>;
      
      protected var FSilver_Price:int;
      
      protected var FBloodSoulCount:int;
      
      protected var FSelectInventories:TInventories = null;
      
      protected var TArt:TArticle = null;
      
      public function LittleTipOneAgain(param1:TUIComponent)
      {
         super(param1);
         this.FTongLingScri = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsScri = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
         this.FSelectInventories = SLogicsCore.Character.Appliances;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:Object = null;
         var _loc3_:int = 0;
         this.TArt = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,14107119) as TArticle;
         _loc1_ = FContext as Object;
         var _loc2_:String = "...";
         var _loc4_:int = int(_loc1_.type);
         var _loc5_:int = int(_loc1_.goldTimes);
         var _loc6_:int = int(_loc1_.BloodType);
         BoundsAlignDown(this.FBoundsScri);
         if(_loc4_ == 1)
         {
            _loc2_ = TUtilityString.Format(STRING_TONGLING.TONGLING_20,this.FSilver_Price,STRING_INHERITPRACTICE.INHERIT_SILVER_COIN,1);
         }
         else if(_loc4_ == 2)
         {
            if(_loc5_ >= this.FGoldPuergatoryArr.length)
            {
               _loc5_ = this.FGoldPuergatoryArr.length - 1;
            }
            _loc2_ = TUtilityString.Format(STRING_TONGLING.TONGLING_30,this.FGoldPuergatoryArr[_loc5_],STRING_INHERITPRACTICE.INHERIT_GOLD,1,STRING_COMMON.STRING_BloodSoul[_loc6_],1,this.TArt.Name,this.FSelectInventories.GetAllCountByTempletID(14107119));
         }
         else
         {
            _loc2_ = TUtilityString.Format(STRING_TONGLING.TONGLING_30,this.getConsumeGold(_loc5_),STRING_INHERITPRACTICE.INHERIT_GOLD,this.FBloodSoulCount,STRING_COMMON.STRING_BloodSoul[_loc6_],this.FBloodSoulCount,this.TArt.Name,this.FSelectInventories.GetAllCountByTempletID(14107119));
         }
         this.FTongLingScri.Text = _loc2_;
         this.FTongLingScri.Evaluate(this.FBoundsScri);
         BoundsContextUnion(this.FBoundsScri);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FTongLingScri.X = FBoundsRendering.X + this.FBoundsScri.X;
         this.FTongLingScri.Y = FBoundsRendering.Y + this.FBoundsScri.Y;
      }
      
      public function getConsumeGold(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FBloodSoulCount)
         {
            _loc4_ = param1 + _loc2_;
            if(_loc4_ >= this.FGoldPuergatoryArr.length)
            {
               _loc4_ = this.FGoldPuergatoryArr.length - 1;
            }
            _loc3_ += this.FGoldPuergatoryArr[_loc4_];
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function getUintByType(param1:int) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case 1:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_SILVER_COIN;
               break;
            case 2:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_GOLD;
               break;
            case 3:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_GOLD;
         }
         return _loc2_;
      }
      
      public function set GoldPuergatoryArr(param1:Vector.<uint>) : void
      {
         this.FGoldPuergatoryArr = param1;
      }
      
      public function set Silver_Price(param1:int) : void
      {
         this.FSilver_Price = param1;
      }
      
      public function set BloodSoulCount(param1:int) : void
      {
         this.FBloodSoulCount = param1;
      }
   }
}

