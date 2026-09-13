package Logics.Exercise.OrangeEquipment
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TOrangeEquipmentChipBox
   {
      
      protected var FTitle:String;
      
      protected var FPriceVect:Vector.<int>;
      
      protected var FInventories:TInventories;
      
      public function TOrangeEquipmentChipBox()
      {
         super();
         this.FPriceVect = new Vector.<int>();
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
      
      public function get PriceVect() : Vector.<int>
      {
         return this.FPriceVect;
      }
      
      public function set PriceVect(param1:Vector.<int>) : void
      {
         this.FPriceVect = param1;
      }
      
      public function get Inventories() : TInventories
      {
         return this.FInventories;
      }
      
      public function set Inventories(param1:TInventories) : void
      {
         this.FInventories = param1;
      }
   }
}

