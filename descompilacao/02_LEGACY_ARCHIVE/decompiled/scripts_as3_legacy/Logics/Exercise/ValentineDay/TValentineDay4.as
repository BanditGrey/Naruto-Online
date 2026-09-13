package Logics.Exercise.ValentineDay
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TValentineDay4 extends TBaseActivity
   {
      
      public static const BOX_COUNT:uint = 5;
      
      public static const PET_COUNT:uint = 3;
      
      protected var FExchangeInventories:TInventories;
      
      protected var FFreeTimes:int;
      
      protected var FBoxVect:Vector.<TBaseBox>;
      
      protected var FPetVect:Vector.<TBaseBox>;
      
      protected var FPetID:Vector.<uint>;
      
      protected var FTitleID:uint;
      
      protected var FTitleDesc1:String;
      
      protected var FTitleDesc2:String;
      
      protected var FTitleDesc3:String;
      
      public function TValentineDay4()
      {
         super();
         this.FBoxVect = new Vector.<TBaseBox>(BOX_COUNT);
         this.FPetVect = new Vector.<TBaseBox>(PET_COUNT);
         this.FPetID = new Vector.<uint>(PET_COUNT);
      }
      
      public function get FreeTimes() : int
      {
         return this.FFreeTimes;
      }
      
      public function set FreeTimes(param1:int) : void
      {
         this.FFreeTimes = param1;
      }
      
      public function get ExchangeInventories() : TInventories
      {
         return this.FExchangeInventories;
      }
      
      public function set ExchangeInventories(param1:TInventories) : void
      {
         this.FExchangeInventories = param1;
      }
      
      public function get BoxVect() : Vector.<TBaseBox>
      {
         return this.FBoxVect;
      }
      
      public function set BoxVect(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxVect = param1;
      }
      
      public function get PetVect() : Vector.<TBaseBox>
      {
         return this.FPetVect;
      }
      
      public function set PetVect(param1:Vector.<TBaseBox>) : void
      {
         this.FPetVect = param1;
      }
      
      public function get TitleID() : uint
      {
         return this.FTitleID;
      }
      
      public function set TitleID(param1:uint) : void
      {
         this.FTitleID = param1;
      }
      
      public function get TitleDesc1() : String
      {
         return this.FTitleDesc1;
      }
      
      public function set TitleDesc1(param1:String) : void
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
               this.FTitleDesc1 = _loc3_;
            }
         }
         else
         {
            this.FTitleDesc1 = param1;
         }
      }
      
      public function get TitleDesc2() : String
      {
         return this.FTitleDesc2;
      }
      
      public function set TitleDesc2(param1:String) : void
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
               this.FTitleDesc2 = _loc3_;
            }
         }
         else
         {
            this.FTitleDesc2 = param1;
         }
      }
      
      public function get TitleDesc3() : String
      {
         return this.FTitleDesc3;
      }
      
      public function set TitleDesc3(param1:String) : void
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
               this.FTitleDesc3 = _loc3_;
            }
         }
         else
         {
            this.FTitleDesc3 = param1;
         }
      }
      
      public function CheckChipIsEnough() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBaseBox = null;
         var _loc6_:TInventories = null;
         var _loc7_:TInventory = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Boolean = true;
         _loc1_ = 0;
         while(_loc1_ < PET_COUNT)
         {
            _loc5_ = this.FPetVect[_loc1_];
            if(_loc5_.Status == STATUS_CANNOTGET)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc5_.ExchangeInventories.Count)
               {
                  _loc7_ = _loc5_.ExchangeInventories.GetInventoryByIndex(_loc3_);
                  _loc9_ = int(_loc7_.Quantity);
                  _loc8_ = int(this.FExchangeInventories.GetInventoryByTempletID(_loc7_.IDTemplate).Quantity);
                  if(_loc8_ < _loc9_)
                  {
                     _loc10_ = false;
                     break;
                  }
                  _loc3_++;
               }
               if(_loc10_)
               {
                  if(_loc1_ == 0)
                  {
                     this.FPetVect[_loc1_].Status = STATUS_CANGET;
                  }
                  else if(this.FPetVect[_loc1_ - 1].Status == STATUS_GETED)
                  {
                     this.FPetVect[_loc1_].Status = STATUS_CANGET;
                  }
               }
            }
            _loc1_++;
         }
      }
   }
}

