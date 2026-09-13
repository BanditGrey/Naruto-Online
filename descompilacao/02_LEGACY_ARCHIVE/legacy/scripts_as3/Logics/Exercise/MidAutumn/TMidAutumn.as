package Logics.Exercise.MidAutumn
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   
   public class TMidAutumn extends TBaseActivity
   {
      
      public static const BOX_COUNT:uint = 5;
      
      public static const PET_COUNT:uint = 3;
      
      protected var FExchangeInventories:TInventories;
      
      protected var FFreeTimes:int;
      
      protected var FFreeBoxStatus:int;
      
      protected var FBoxVect:Vector.<TBaseBox>;
      
      protected var FPetVect:Vector.<TBaseBox>;
      
      protected var FPetID:Vector.<uint>;
      
      protected var FTitleID:int;
      
      public function TMidAutumn()
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
      
      public function get FreeBoxStatus() : int
      {
         return this.FFreeBoxStatus;
      }
      
      public function set FreeBoxStatus(param1:int) : void
      {
         this.FFreeBoxStatus = param1;
      }
      
      public function get PetVect() : Vector.<TBaseBox>
      {
         return this.FPetVect;
      }
      
      public function set PetVect(param1:Vector.<TBaseBox>) : void
      {
         this.FPetVect = param1;
      }
      
      public function get TitleID() : int
      {
         return this.FTitleID;
      }
      
      public function set TitleID(param1:int) : void
      {
         this.FTitleID = param1;
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

