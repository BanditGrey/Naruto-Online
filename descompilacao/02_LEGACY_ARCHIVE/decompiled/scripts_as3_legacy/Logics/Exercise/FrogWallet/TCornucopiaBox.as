package Logics.Exercise.FrogWallet
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TCornucopiaBox
   {
      
      protected var FIdentify:int;
      
      protected var FBoxName:String;
      
      protected var FPayLimit:int;
      
      protected var FBoxPrice:int;
      
      protected var FRebate:int;
      
      protected var FState:int;
      
      protected var FGotTimes:int;
      
      protected var FGetGold:int;
      
      protected var FInventories:TInventories;
      
      protected var FCanGetTime:int;
      
      public function TCornucopiaBox()
      {
         super();
      }
      
      public function get Identify() : int
      {
         return this.FIdentify;
      }
      
      public function set Identify(param1:int) : void
      {
         this.FIdentify = param1;
      }
      
      public function get BoxName() : String
      {
         return this.FBoxName;
      }
      
      public function set BoxName(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         _loc2_ = int(parseInt(param1));
         if(TBaseActivity.IsRealNumber(param1) && !isNaN(_loc2_) && _loc2_ > 0)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
            if(_loc4_)
            {
               _loc3_ = _loc4_.Desc;
               _loc3_ = _loc3_.split("&lt;").join("<");
               _loc3_ = _loc3_.split("&gt;").join(">");
               this.FBoxName = _loc3_;
            }
         }
         else
         {
            this.FBoxName = param1;
         }
      }
      
      public function get PayLimit() : int
      {
         return this.FPayLimit;
      }
      
      public function set PayLimit(param1:int) : void
      {
         this.FPayLimit = param1;
      }
      
      public function get BoxPrice() : int
      {
         return this.FBoxPrice;
      }
      
      public function set BoxPrice(param1:int) : void
      {
         this.FBoxPrice = param1;
      }
      
      public function get Rebate() : int
      {
         return this.FRebate;
      }
      
      public function set Rebate(param1:int) : void
      {
         this.FRebate = param1;
      }
      
      public function get State() : int
      {
         return this.FState;
      }
      
      public function set State(param1:int) : void
      {
         this.FState = param1;
      }
      
      public function get GotTimes() : int
      {
         return this.FGotTimes;
      }
      
      public function set GotTimes(param1:int) : void
      {
         this.FGotTimes = param1;
      }
      
      public function get Inventories() : TInventories
      {
         return this.FInventories;
      }
      
      public function set Inventories(param1:TInventories) : void
      {
         this.FInventories = param1;
      }
      
      public function get GetGold() : int
      {
         return this.FGetGold;
      }
      
      public function set GetGold(param1:int) : void
      {
         this.FGetGold = param1;
      }
      
      public function get CanGetTime() : int
      {
         return this.FCanGetTime;
      }
      
      public function set CanGetTime(param1:int) : void
      {
         this.FCanGetTime = param1;
      }
   }
}

