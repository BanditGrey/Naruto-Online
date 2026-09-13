package Logics.Exercise.OrangeEquipment
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventory;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TOrangeEquipment extends TBaseActivity
   {
      
      protected var FActiveDesc2:String;
      
      protected var FFreeTimes:int;
      
      protected var FFreeInventory:TInventory;
      
      protected var FChipVect:Vector.<int>;
      
      protected var FChipID:Vector.<uint>;
      
      protected var FChipPrice:Vector.<int>;
      
      protected var FChipBoxes:Vector.<TOrangeEquipmentChipBox>;
      
      protected var FSuitBoxes:Vector.<TOrangeEquipmentSuit>;
      
      public function TOrangeEquipment()
      {
         super();
         this.FChipVect = new Vector.<int>();
         this.FChipID = new Vector.<uint>();
         this.FChipBoxes = new Vector.<TOrangeEquipmentChipBox>();
         this.FSuitBoxes = new Vector.<TOrangeEquipmentSuit>();
         this.FChipPrice = new Vector.<int>();
      }
      
      public function get ActiveDesc2() : String
      {
         return this.FActiveDesc2;
      }
      
      public function set ActiveDesc2(param1:String) : void
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
               this.FActiveDesc2 = _loc3_;
            }
         }
         else
         {
            this.FActiveDesc2 = param1;
         }
      }
      
      public function get ChipVect() : Vector.<int>
      {
         return this.FChipVect;
      }
      
      public function set ChipVect(param1:Vector.<int>) : void
      {
         this.FChipVect = param1;
      }
      
      public function get FreeTimes() : int
      {
         return this.FFreeTimes;
      }
      
      public function set FreeTimes(param1:int) : void
      {
         this.FFreeTimes = param1;
      }
      
      public function get ChipBoxes() : Vector.<TOrangeEquipmentChipBox>
      {
         return this.FChipBoxes;
      }
      
      public function set ChipBoxes(param1:Vector.<TOrangeEquipmentChipBox>) : void
      {
         this.FChipBoxes = param1;
      }
      
      public function get SuitBoxes() : Vector.<TOrangeEquipmentSuit>
      {
         return this.FSuitBoxes;
      }
      
      public function set SuitBoxes(param1:Vector.<TOrangeEquipmentSuit>) : void
      {
         this.FSuitBoxes = param1;
      }
      
      public function get ChipID() : Vector.<uint>
      {
         return this.FChipID;
      }
      
      public function set ChipID(param1:Vector.<uint>) : void
      {
         this.FChipID = param1;
      }
      
      public function get FreeInventory() : TInventory
      {
         return this.FFreeInventory;
      }
      
      public function set FreeInventory(param1:TInventory) : void
      {
         this.FFreeInventory = param1;
      }
      
      public function get ChipPrice() : Vector.<int>
      {
         return this.FChipPrice;
      }
      
      public function set ChipPrice(param1:Vector.<int>) : void
      {
         this.FChipPrice = param1;
      }
      
      public function GetBoxIDByIndex(param1:int, param2:int) : uint
      {
         if(param1 == -1 && param2 == -1)
         {
            return this.FFreeInventory.IDTemplate;
         }
         return this.FChipBoxes[param1].Inventories.GetInventoryByIndex(param2).IDTemplate;
      }
      
      public function GetEquipmentIDByIndex(param1:int, param2:int) : uint
      {
         return this.FSuitBoxes[param1].SuitVect[param2].Inventories.GetInventoryByIndex(0).IDTemplate;
      }
      
      public function GetChipCountByID(param1:uint) : int
      {
         var _loc2_:int = 0;
         _loc2_ = this.FChipID.indexOf(param1);
         if(_loc2_ == -1)
         {
            return 0;
         }
         return this.FChipVect[_loc2_];
      }
      
      public function GetNeedGold(param1:int, param2:int) : int
      {
         var _loc3_:TBaseBox = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc3_ = this.FSuitBoxes[param1].SuitVect[param2];
         _loc4_ = _loc3_.Price - this.GetChipCountByID(this.FSuitBoxes[param1].ExchangeItemID);
         _loc6_ = this.FChipID.indexOf(this.FSuitBoxes[param1].ExchangeItemID);
         return int(_loc4_ * this.FChipPrice[_loc6_]);
      }
   }
}

