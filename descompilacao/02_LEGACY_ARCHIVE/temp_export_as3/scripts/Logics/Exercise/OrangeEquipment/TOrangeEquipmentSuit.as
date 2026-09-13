package Logics.Exercise.OrangeEquipment
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TOrangeEquipmentSuit
   {
      
      protected var FIdentify:uint;
      
      protected var FTitle:String;
      
      protected var FSuitVect:Vector.<TBaseBox>;
      
      protected var FExchangeItemID:uint;
      
      protected var FInventories:TInventories;
      
      protected var FExchangeInventory:TInventory;
      
      public function TOrangeEquipmentSuit()
      {
         super();
         this.FSuitVect = new Vector.<TBaseBox>();
      }
      
      public function get Title() : String
      {
         return this.FTitle;
      }
      
      public function set Title(param1:String) : void
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
               this.FTitle = _loc3_;
            }
         }
         else
         {
            this.FTitle = param1;
         }
      }
      
      public function get Identify() : uint
      {
         return this.FIdentify;
      }
      
      public function set Identify(param1:uint) : void
      {
         this.FIdentify = param1;
      }
      
      public function get SuitVect() : Vector.<TBaseBox>
      {
         return this.FSuitVect;
      }
      
      public function set SuitVect(param1:Vector.<TBaseBox>) : void
      {
         this.FSuitVect = param1;
      }
      
      public function get ExchangeItemID() : uint
      {
         return this.FExchangeItemID;
      }
      
      public function set ExchangeItemID(param1:uint) : void
      {
         this.FExchangeItemID = param1;
      }
      
      public function get Inventories() : TInventories
      {
         return this.FInventories;
      }
      
      public function set Inventories(param1:TInventories) : void
      {
         this.FInventories = param1;
      }
      
      public function get ExchangeInventory() : TInventory
      {
         return this.FExchangeInventory;
      }
      
      public function set ExchangeInventory(param1:TInventory) : void
      {
         this.FExchangeInventory = param1;
      }
   }
}

