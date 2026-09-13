package Logics.Streamization.ActivityMode
{
   import Foundation.Resources.Bins.*;
   import Foundation.Streamization.*;
   import Foundation.Timing.*;
   import Foundation.Utilities.*;
   import Logics.ActivityMode.*;
   import Logics.DatebaseVO.*;
   import Logics.DatebaseVO.VO.*;
   import flash.utils.*;
   
   public class TUnstreamizerActivityAtoms extends TUnstreamizer
   {
      
      protected var FUnstreamizerActivityAtom:TUnstreamizerActivityAtom;
      
      public function TUnstreamizerActivityAtoms()
      {
         super();
         this.FUnstreamizerActivityAtom = new TUnstreamizerActivityAtom();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_ActivityAtoms(param1,param2,param3);
      }
      
      protected function UnstreamizationPerform_ActivityAtoms(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TActivityAtoms = null;
         var _loc5_:TActivityAtom = null;
         var _loc6_:Vector.<TBins> = null;
         var _loc7_:TBins = null;
         var _loc8_:TActivity = null;
         var _loc9_:int = 0;
         var _loc10_:Date = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         _loc4_ = param2 as TActivityAtoms;
         _loc6_ = param3 as Vector.<TBins>;
         _loc7_ = _loc6_[0];
         _loc9_ = int(STimingCore.GetServerTick());
         _loc10_ = new Date(STimingCore.GetClientShowTime(_loc9_) * 1000);
         _loc10_.hours = 0;
         _loc10_.minutes = 0;
         _loc4_.CheckTime = _loc10_.time / 1000 + 24 * 60 * 60 + 60;
         _loc8_ = _loc7_.GetDatebaseByIdentifier(_loc4_.Identifier) as TActivity;
         if(_loc8_ == null)
         {
            return;
         }
         _loc4_.LeftCaption = _loc8_.Name;
         _loc4_.RightCaption = _loc8_.TName;
         _loc4_.Desc = _loc8_.Desc;
         _loc4_.IconType = _loc8_.IconType;
         _loc4_.SecondIconType = _loc8_.SecondIconType;
         _loc4_.StartIndex = _loc8_.StartIndexVect;
         _loc4_.EndIndex = _loc8_.EndIndexVect;
         _loc4_.Sort = _loc8_.Sort;
         _loc12_ = _loc4_.Count;
         _loc11_ = 0;
         while(_loc11_ < _loc12_)
         {
            _loc5_ = _loc4_.GetActivityAtomByIndex(_loc11_);
            this.FUnstreamizerActivityAtom.Unstreamize(param1,_loc5_,param3);
            _loc11_++;
         }
      }
   }
}

