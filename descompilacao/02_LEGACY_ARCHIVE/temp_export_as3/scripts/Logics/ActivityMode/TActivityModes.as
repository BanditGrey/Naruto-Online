package Logics.ActivityMode
{
   import Foundation.Common.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Streamization.Inventories.*;
   import Resources.Constants.*;
   
   public class TActivityModes
   {
      
      public static const ICONTYPE_FirstRecharge:uint = 1;
      
      public static const ICONTYPE_Recharge:uint = 2;
      
      public static const ICONTYPE_ActivityInner:uint = 3;
      
      public static const ICONTYPE_GiftBag:uint = 4;
      
      public static const ICONTYPE_RechageCashBack:uint = 5;
      
      public static const ICONTYPE_Second_FirstDay:uint = 1;
      
      public static const ICONTYPE_Second_Online:uint = 2;
      
      public static const ICONTYPE_Second_Gold:uint = 3;
      
      public static const ICONTYPE_Second_SevenDay:uint = 4;
      
      protected var FActivityModes:Vector.<TActivityAtoms>;
      
      public function TActivityModes()
      {
         super();
         this.FActivityModes = new Vector.<TActivityAtoms>();
      }
      
      protected function SortMount(param1:TActivityAtoms, param2:TActivityAtoms) : int
      {
         if(param1.Sort < param2.Sort)
         {
            return -1;
         }
         return 1;
      }
      
      protected function SortActivityAtoms() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TActivityAtoms = null;
         _loc2_ = int(this.FActivityModes.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FActivityModes[_loc1_];
            _loc3_.SortActivityAtoms();
            _loc1_++;
         }
      }
      
      public function get Count() : int
      {
         return this.FActivityModes.length;
      }
      
      public function GetActivityAtomsByIndex(param1:int) : TActivityAtoms
      {
         return this.FActivityModes[param1];
      }
      
      public function GetActivityAtomsByIdentifier(param1:uint) : TActivityAtoms
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TActivityAtoms = null;
         _loc2_ = int(this.FActivityModes.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FActivityModes[_loc3_];
            if(_loc4_.Identifier == param1)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function GetActivityAtomsByType(param1:uint) : TActivityAtoms
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TActivityAtoms = null;
         _loc2_ = int(this.FActivityModes.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FActivityModes[_loc3_];
            if(_loc4_.IconType == param1)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function GetActivityAtomsBySecondType(param1:uint, param2:uint) : TActivityAtoms
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TActivityAtoms = null;
         _loc3_ = int(this.FActivityModes.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this.FActivityModes[_loc4_];
            if(_loc5_.IconType == param1 && _loc5_.SecondIconType == param2)
            {
               return _loc5_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TActivityAtoms = null;
         _loc1_ = int(this.FActivityModes.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FActivityModes[_loc2_];
            _loc2_++;
         }
         this.FActivityModes.length = 0;
      }
      
      public function Add(param1:TActivityAtoms) : void
      {
         this.FActivityModes.push(param1);
      }
      
      public function Delete(param1:int) : void
      {
         var _loc2_:TActivityAtoms = null;
         _loc2_ = this.FActivityModes[param1];
         this.FActivityModes.splice(param1,1);
      }
      
      public function Sort() : void
      {
         this.FActivityModes.sort(this.SortMount);
         this.SortActivityAtoms();
      }
      
      public function GetActivityIconIsOn(param1:uint) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:Boolean = false;
         var _loc4_:TActivityAtoms = null;
         _loc3_ = false;
         _loc2_ = 0;
         while(_loc2_ < this.FActivityModes.length)
         {
            _loc4_ = this.FActivityModes[_loc2_];
            if(_loc4_.IconType == param1)
            {
               if(_loc4_.IsOn)
               {
                  _loc3_ = true;
                  break;
               }
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function GetActivitySecondIconIsOn(param1:uint, param2:uint) : Boolean
      {
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         var _loc5_:TActivityAtoms = null;
         _loc4_ = false;
         _loc3_ = 0;
         while(_loc3_ < this.FActivityModes.length)
         {
            _loc5_ = this.FActivityModes[_loc3_];
            if(_loc5_.IconType == param1 && _loc5_.SecondIconType == param2)
            {
               if(_loc5_.IsOn)
               {
                  _loc4_ = true;
                  break;
               }
            }
            _loc3_++;
         }
         return _loc4_;
      }
   }
}

