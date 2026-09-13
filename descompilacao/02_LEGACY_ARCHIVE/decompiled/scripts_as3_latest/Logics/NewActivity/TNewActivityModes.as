package Logics.NewActivity
{
   import Foundation.Common.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Streamization.Inventories.*;
   import Resources.Constants.*;
   
   public class TNewActivityModes
   {
      
      public static const ICONTYPE_Lottery:uint = 1;
      
      public static const NEW_ACTIVELIST_TYPE:Vector.<uint> = CONST_SHORTCUTS.NEW_ACTIVELIST_TYPE;
      
      public static const NEW_ACTIVELIST_SECONDARY_TYPE:Vector.<uint> = CONST_SHORTCUTS.NEW_ACTIVELIST_SECONDARY_TYPE;
      
      protected var FActivityIsOpen:Vector.<Boolean>;
      
      protected var FActivityStatus:Object;
      
      protected var FActivityRewardStatus:Object;
      
      public function TNewActivityModes()
      {
         super();
         this.FActivityIsOpen = new Vector.<Boolean>();
         this.FActivityStatus = {"999":true};
         this.FActivityRewardStatus = {};
      }
      
      public function SetActivityStatus(param1:int, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < NEW_ACTIVELIST_TYPE.length)
         {
            if(param1 == NEW_ACTIVELIST_TYPE[_loc3_])
            {
               this.FActivityIsOpen.push(param2);
               this.FActivityStatus[param1] = param2;
               break;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < NEW_ACTIVELIST_SECONDARY_TYPE.length)
         {
            if(param1 == NEW_ACTIVELIST_SECONDARY_TYPE[_loc3_])
            {
               this.FActivityIsOpen.push(param2);
               this.FActivityStatus[param1] = param2;
               break;
            }
            _loc3_++;
         }
      }
      
      public function getActivityStatus(param1:int) : Boolean
      {
         var _loc2_:String = null;
         for(_loc2_ in this.FActivityStatus)
         {
            if(_loc2_ == param1.toString())
            {
               return this.FActivityStatus[_loc2_];
            }
         }
         return false;
      }
   }
}

