package Logics.Streamization.ActivityMode
{
   import Foundation.Resources.Bins.*;
   import Foundation.Streamization.*;
   import Logics.ActivityMode.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.DatebaseVO.VO.Json.*;
   import Logics.Inventories.*;
   import Logics.Streamization.Inventories.*;
   import Resources.Constants.*;
   import flash.utils.*;
   
   public class TUnstreamizerActivityAtom extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerActivityAtom()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_ActivityAtom(param1,param2,param3);
      }
      
      protected function UnstreamizationPerform_ActivityAtom(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TActivityAtom = null;
         var _loc5_:Vector.<TBins> = null;
         var _loc6_:TBins = null;
         var _loc7_:TBins = null;
         var _loc8_:TBins = null;
         var _loc9_:TActiveList = null;
         var _loc10_:TArticle = null;
         var _loc11_:TAward = null;
         var _loc12_:TFixedAward = null;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:Vector.<uint> = null;
         var _loc16_:Vector.<uint> = null;
         var _loc17_:TInventories = null;
         var _loc18_:TInventory = null;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         _loc4_ = param2 as TActivityAtom;
         _loc5_ = param3 as Vector.<TBins>;
         _loc6_ = _loc5_[1];
         _loc8_ = _loc5_[2];
         _loc7_ = _loc5_[3];
         _loc9_ = _loc6_.GetDatebaseByIdentifier(_loc4_.Identifier) as TActiveList;
         if(_loc9_ == null)
         {
            return;
         }
         _loc4_.ConditionValue = _loc9_.ConditionVect.Value;
         _loc4_.Tips = _loc9_.Tips.Value;
         _loc4_.Price = _loc9_.Price;
         _loc4_.AddAwardNum = _loc9_.AddAwardNum;
         _loc4_.GetType = _loc9_.GetType;
         _loc4_.Sort = _loc9_.Sort;
         _loc4_.DayTime = _loc9_.DayTimeVect;
         _loc15_ = new Vector.<uint>();
         _loc16_ = new Vector.<uint>();
         _loc20_ = int(_loc9_.ClientAwardVect.length);
         _loc19_ = 0;
         while(_loc19_ < _loc20_)
         {
            _loc15_.length = 0;
            _loc16_.length = 0;
            _loc13_ = _loc9_.ClientAwardVect[_loc19_];
            _loc11_ = _loc7_.GetDatebaseByIdentifier(_loc13_) as TAward;
            if(_loc11_ != null)
            {
               _loc22_ = int(_loc11_.FixedAwards.length);
               _loc21_ = 0;
               while(_loc21_ < _loc22_)
               {
                  _loc12_ = _loc11_.FixedAwards[_loc21_];
                  if(_loc12_.Type == 1)
                  {
                     _loc15_.push(_loc12_.Code);
                  }
                  else
                  {
                     _loc14_ = CONST_COMMON.RewardIDToTemplateID(_loc12_.Type,_loc12_.Code);
                     _loc15_.push(_loc14_);
                  }
                  _loc16_.push(_loc12_.Amount);
                  _loc21_++;
               }
            }
            else
            {
               _loc10_ = _loc8_.GetDatebaseByIdentifier(_loc13_) as TArticle;
               if(_loc10_ != null)
               {
                  _loc15_.push(_loc13_);
                  _loc16_.push(1);
               }
            }
            _loc17_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc17_,_loc15_);
            _loc22_ = int(_loc16_.length);
            _loc21_ = 0;
            while(_loc21_ < _loc22_)
            {
               _loc18_ = _loc17_.GetInventoryByTempletID(_loc15_[_loc21_]);
               _loc18_.Quantity = _loc16_[_loc21_];
               _loc21_++;
            }
            _loc4_.InventoriesVect.push(_loc17_);
            _loc19_++;
         }
      }
   }
}

