package Logics.Streamization.GeneralStar
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TStarPoint;
   import Logics.GeneralStar.TEsotericPoint;
   import Logics.GeneralStar.TEsotericPoints;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerGeneralStar extends TUnstreamizer
   {
      
      public static const FORMAT_SkillName:String = CONST_COMMON.STRING_ThinSquare;
      
      protected const TYPE_STRENGTH:uint = 1;
      
      protected const TYPE_AGILITY:uint = 2;
      
      protected const TYPE_INTELLECT:uint = 3;
      
      protected var FSpeed:uint = 11;
      
      protected var FHurtRate:uint = 28;
      
      protected var FRecoverRate:uint = 34;
      
      protected var FMAXHP:uint = 101;
      
      protected var FAvoidhurtRate:uint = 29;
      
      protected var FCharacter:TCharacter;
      
      protected var FStarPointBin:TBins;
      
      protected var FType:uint;
      
      protected var FUnstreamizationEsotericPoint:TUnstreamizationEsotericPoint;
      
      public function TUnstreamizerGeneralStar()
      {
         super();
         this.FCharacter = SLogicsCore.Character;
         this.FUnstreamizationEsotericPoint = new TUnstreamizationEsotericPoint();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TEsotericPoints = null;
         var _loc5_:TEsotericPoint = null;
         var _loc6_:TEsotericPoint = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         _loc4_ = param2 as TEsotericPoints;
         _loc4_.Init();
         _loc4_.Pofession = this.FCharacter.MainHero.Profession;
         switch(_loc4_.Pofession)
         {
            case 4:
               this.FType = this.TYPE_STRENGTH;
               break;
            case 1:
               this.FType = this.TYPE_AGILITY;
               break;
            case 3:
               this.FType = this.TYPE_INTELLECT;
         }
         this.UnstreamizationEsotericPoint(param1,_loc4_,param3);
         _loc5_ = this.FCharacter.EsotericPoints.GetEsotericPointByIdentifier(this.FCharacter.StarMapIndex) as TEsotericPoint;
         _loc8_ = _loc4_.FPointsCount();
         if(_loc5_ != null)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               _loc6_ = this.FCharacter.EsotericPoints.GetEsotericPointByIndex(_loc7_) as TEsotericPoint;
               this.SetRate(_loc4_,_loc6_);
               if(_loc6_ == _loc5_)
               {
                  break;
               }
               _loc7_++;
            }
         }
      }
      
      protected function UnstreamizationEsotericPoint(param1:ByteArray, param2:TEsotericPoints, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TEsotericPoint = null;
         var _loc7_:TStarPoint = null;
         this.FStarPointBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_StarPoint);
         _loc5_ = uint(this.FStarPointBin.Count);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = this.FStarPointBin.GetDatebaseByIndex(_loc4_) as TStarPoint;
            if(Math.floor(_loc7_.MapId / 10) == this.FType)
            {
               _loc6_ = new TEsotericPoint(0);
               this.FUnstreamizationEsotericPoint.UnstreamizationEsotericPoint(_loc7_,_loc6_);
               param2.AddEsotericPoint(_loc6_);
            }
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
      
      public function SetRate(param1:TEsotericPoints, param2:TEsotericPoint) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = int(param2.Type.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(param2.Type[_loc3_] == this.FSpeed || param2.Type[_loc3_] == this.FHurtRate || param2.Type[_loc3_] == this.FRecoverRate || param2.Type[_loc3_] == this.FMAXHP || param2.Type[_loc3_] == this.FAvoidhurtRate)
            {
               param1.SetFormationBonus(param2.Target[_loc3_],param2.Value[_loc3_],param2.Type[_loc3_]);
            }
            _loc3_++;
         }
      }
   }
}

