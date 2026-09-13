package Logics.Exercise.FirstRechange_new
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TheFirstRecharge;
   import Logics.Exercise.TBaseActivity;
   import Logics.Streamization.Exercise.TUnstreamizerFirstRechargeResInfo;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TFirstRechange_new_Model extends TBaseActivity
   {
      
      public var firstRechangeResInfo:TUnstreamizerFirstRechargeResInfo;
      
      public function TFirstRechange_new_Model()
      {
         super();
         this.firstRechangeResInfo = new TUnstreamizerFirstRechargeResInfo();
      }
      
      public function haveAddupReward() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.firstRechangeResInfo.assupRechargeStatus.length)
         {
            if(this.firstRechangeResInfo.assupRechargeStatus[_loc1_] != -1)
            {
               return true;
            }
            _loc1_++;
         }
         if(this.firstRechangeResInfo.firstRechareStatus != -1)
         {
            return true;
         }
         return false;
      }
      
      public function getStaticVOByID(param1:int) : TheFirstRecharge
      {
         return SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TheFirstRecharge,param1) as TheFirstRecharge;
      }
   }
}

