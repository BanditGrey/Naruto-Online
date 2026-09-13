package Processors.Game.Lobby.GeneralStar.PackageStarPoint
{
   import Foundation.UI.TUIComponent;
   import Logics.Characters.TCharacter;
   import Logics.GeneralStar.TEsotericPoint;
   import Logics.GeneralStar.TEsotericPoints;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_GENERAL_STAR;
   import flash.display.MovieClip;
   
   public class TUIMiddleBackground extends TUIComponent
   {
      
      protected var FPoints:Vector.<TPoint>;
      
      protected var FPointCount:uint;
      
      protected var FSeals:Vector.<MovieClip>;
      
      protected var FWords:Vector.<MovieClip>;
      
      protected var FScene:MovieClip;
      
      protected var FCharacter:TCharacter;
      
      protected var FEsotericPoints:TEsotericPoints;
      
      protected var FOnGeneralStarMove:Function;
      
      protected var FOnGeneralStarOut:Function;
      
      protected var FOnGeneralStarClick:Function;
      
      protected var FOnSetColour:Function;
      
      protected var FOnClickTiaoZhuan:Function;
      
      public function TUIMiddleBackground(param1:TUIComponent)
      {
         super(param1);
         this.FSeals = new Vector.<MovieClip>();
         this.FWords = new Vector.<MovieClip>();
         this.FCharacter = SLogicsCore.Character;
      }
      
      protected function UIDispatch(param1:MovieClip, param2:uint, param3:uint, param4:uint) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:TPoint = null;
         var _loc7_:MovieClip = null;
         this.FPoints = new Vector.<TPoint>(this.FPointCount);
         _loc5_ = 0;
         while(_loc5_ < param2)
         {
            _loc6_ = new TPoint(this);
            _loc6_.Substrate = param1[CONST_GENERAL_STAR.RESOURCESID_POINT + _loc5_];
            _loc6_.OnGeneralStarMove = this.FOnGeneralStarMove;
            _loc6_.OnGeneralStarOut = this.FOnGeneralStarOut;
            _loc6_.OnClickPoint = this.FOnGeneralStarClick;
            _loc6_.OnClickTiaoZhuan = this.OnClickTiaoZhuanC;
            _loc6_.Init();
            this.FPoints[_loc5_] = _loc6_;
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param3)
         {
            _loc7_ = param1[CONST_GENERAL_STAR.RESPIRCESID_MC_Seal_ + _loc5_];
            this.FSeals.push(_loc7_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param4)
         {
            _loc7_ = param1[CONST_GENERAL_STAR.RESPIRCESID_MC_Word_ + _loc5_];
            this.FWords.push(_loc7_);
            _loc5_++;
         }
      }
      
      protected function updatePoint(param1:uint) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TEsotericPoint = null;
         var _loc5_:int = 0;
         _loc3_ = this.FPoints.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FPoints[_loc2_].Context = this.FEsotericPoints.GetEsotericPointByIndex(_loc2_);
            if(_loc2_ < param1)
            {
               this.FPoints[_loc2_].SetPointState(TPoint.RENDERINGSTATE_Pointed);
            }
            else if(_loc2_ > param1)
            {
               this.FPoints[_loc2_].SetPointState(TPoint.RENDERINGSTATE_Disabled);
            }
            else
            {
               if(this.FCharacter.StarMapIndex == 0)
               {
                  _loc4_ = this.FCharacter.EsotericPoints.GetEsotericPointByIndex(0) as TEsotericPoint;
               }
               else
               {
                  _loc4_ = this.FEsotericPoints.GetEsotericPointByIndex(_loc2_) as TEsotericPoint;
               }
               _loc5_ = 0;
               if(this.FCharacter.GeneralsSoul >= _loc4_.NeedFetch)
               {
                  _loc5_ = 1;
                  this.FOnSetColour(true,0);
               }
               else
               {
                  _loc5_ = 0;
                  this.FOnSetColour(true,0);
               }
               if(this.FCharacter.AwakenGeneralsSoul >= _loc4_.NeedNewFetch)
               {
                  _loc5_ += 1;
                  this.FOnSetColour(true,1);
               }
               else
               {
                  this.FOnSetColour(true,1);
               }
               if(_loc5_ == 2)
               {
                  this.FPoints[_loc2_].SetPointState(TPoint.RENDERINGSTATE_CanPoint);
               }
               else
               {
                  this.FPoints[_loc2_].SetPointState(TPoint.RENDERINGSTATE_Disabled);
               }
            }
            _loc2_++;
         }
      }
      
      protected function playWordsAndCo() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         switch(this.FCharacter.MainHero.Profession)
         {
            case 4:
               _loc2_ = 1;
               _loc3_ = 3;
               break;
            case 1:
               _loc2_ = 2;
               _loc3_ = 2;
               break;
            case 3:
               _loc2_ = 3;
               _loc3_ = 1;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FWords.length)
         {
            this.FWords[_loc1_].gotoAndStop(2);
            _loc4_ = this.FWords[_loc1_]["mm"];
            _loc4_["mm"]["mm"].gotoAndStop(_loc2_);
            _loc4_.play();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FSeals.length)
         {
            this.FSeals[_loc1_].gotoAndStop(2);
            if(this.FSeals[_loc1_]["mm"] != null)
            {
               _loc4_ = this.FSeals[_loc1_]["mm"];
               _loc4_["mm"]["mm"].gotoAndStop(_loc3_);
               _loc4_.play();
            }
            else
            {
               this.FSeals[_loc1_].play();
            }
            _loc1_++;
         }
      }
      
      public function get Scene() : MovieClip
      {
         return this.FScene;
      }
      
      public function set Scene(param1:MovieClip) : void
      {
         this.FScene = param1;
      }
      
      public function get OnGeneralStarMove() : Function
      {
         return this.FOnGeneralStarMove;
      }
      
      public function set OnGeneralStarMove(param1:Function) : void
      {
         this.FOnGeneralStarMove = param1;
      }
      
      public function get OnGeneralStarOut() : Function
      {
         return this.FOnGeneralStarOut;
      }
      
      public function set OnGeneralStarOut(param1:Function) : void
      {
         this.FOnGeneralStarOut = param1;
      }
      
      public function get OnGeneralStarClick() : Function
      {
         return this.FOnGeneralStarClick;
      }
      
      public function set OnGeneralStarClick(param1:Function) : void
      {
         this.FOnGeneralStarClick = param1;
      }
      
      protected function OnClickTiaoZhuanC(param1:int) : void
      {
         if(this.FOnClickTiaoZhuan != null)
         {
            this.FOnClickTiaoZhuan(param1);
         }
      }
      
      public function get OnClickTiaoZhuan() : Function
      {
         return this.FOnClickTiaoZhuan;
      }
      
      public function set OnClickTiaoZhuan(param1:Function) : void
      {
         this.FOnClickTiaoZhuan = param1;
      }
      
      public function get OnSetColour() : Function
      {
         return this.FOnSetColour;
      }
      
      public function set OnSetColour(param1:Function) : void
      {
         this.FOnSetColour = param1;
      }
      
      public function init(param1:MovieClip, param2:uint, param3:uint, param4:uint) : void
      {
         this.FScene = param1;
         this.FPointCount = param2;
         this.UIDispatch(param1,param2,param3,param4);
      }
      
      public function updateGround(param1:uint, param2:TEsotericPoints) : void
      {
         this.FEsotericPoints = param2;
         this.updatePoint(param1);
      }
      
      public function AllLight(param1:TEsotericPoints) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TEsotericPoint = null;
         this.FEsotericPoints = param1;
         _loc3_ = this.FPoints.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FPoints[_loc2_].Context = this.FEsotericPoints.GetEsotericPointByIndex(_loc2_);
            this.FPoints[_loc2_].SetPointState(TPoint.RENDERINGSTATE_Pointed);
            _loc2_++;
         }
         this.playWordsAndCo();
      }
      
      public function updatePointStar(param1:TEsotericPoint) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TEsotericPoint = null;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         _loc2_ = param1.PointIndex - 1;
         this.FPoints[_loc2_].SetPointState(TPoint.RENDERINGSTATE_Pointed);
         _loc3_ = this.FEsotericPoints.GetEsotericPointByIndex(_loc2_ + 1) as TEsotericPoint;
         _loc5_ = 0;
         if(this.FCharacter.GeneralsSoul >= _loc3_.NeedFetch)
         {
            _loc5_ = 1;
            this.FOnSetColour(true,0);
         }
         else
         {
            _loc5_ = 0;
            this.FOnSetColour(true,0);
         }
         if(this.FCharacter.AwakenGeneralsSoul >= _loc3_.NeedNewFetch)
         {
            _loc5_ += 1;
            this.FOnSetColour(true,1);
         }
         else
         {
            this.FOnSetColour(true,1);
         }
         if(_loc5_ == 2)
         {
            this.FPoints[_loc2_ + 1].SetPointState(TPoint.RENDERINGSTATE_CanPoint);
         }
         else
         {
            this.FPoints[_loc2_ + 1].SetPointState(TPoint.RENDERINGSTATE_Disabled);
         }
      }
      
      public function GetPointByIndex(param1:uint) : TPoint
      {
         return this.FPoints[param1];
      }
   }
}

