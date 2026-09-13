package Logics.Inventories
{
   import Foundation.Common.Stubs.TStubReferences;
   import Foundation.Common.TEntity64;
   import Foundation.Timing.STimingCore;
   import Logics.Spaces.LogicsSpace;
   import Resources.Constants.CONST_INVENTORY;
   
   use namespace LogicsSpace;
   
   public class TInventory extends TEntity64
   {
      
      protected var FStubReferences:TStubReferences;
      
      protected var FCategory:uint;
      
      protected var FCategorySecond:uint;
      
      protected var FIDTemplate:uint;
      
      protected var FName:String;
      
      protected var FDescription:String;
      
      protected var FIDTexture:uint;
      
      protected var FQuantity:uint;
      
      protected var FQuality:uint;
      
      protected var FIsCanSell:Boolean;
      
      protected var FSellValue:uint;
      
      protected var FSellingValue:Number;
      
      protected var FIsCanDiscard:Boolean;
      
      protected var FIsCanReveal:Boolean;
      
      protected var FSortIndex:uint;
      
      protected var FRequirementLevel:uint;
      
      protected var FUpgradingLevel:uint;
      
      protected var FTimingCategory:uint;
      
      protected var FTimingState:uint;
      
      protected var FTempTimingTime:uint;
      
      protected var FTimingTime:uint;
      
      protected var FObtainType:uint;
      
      protected var FTimingReferenceTick:int;
      
      protected var FTimingReferenceTime:int;
      
      protected var FIsSelling:Boolean;
      
      protected var FType:uint;
      
      protected var FIsExchage:int;
      
      protected var FGoldNumberA:int;
      
      protected var FNewType:int;
      
      protected var FNewIdentify:int;
      
      protected var FShowFire:int;
      
      public var ItemStatus:int;
      
      protected var FEquipmentDeJade:TEquipment;
      
      protected var FCurJadeExp:uint;
      
      protected var FCurUnlock:uint;
      
      public var MinPrice:int;
      
      public var MaxPrice:int;
      
      public var LimitCount:int;
      
      public var Desc:String;
      
      public function TInventory(param1:uint, param2:uint)
      {
         super(param1,param2);
         this.FStubReferences = new TStubReferences(this);
         this.FName = "";
         this.FDescription = "";
         this.FIsSelling = false;
      }
      
      LogicsSpace function Coerce(param1:uint, param2:uint) : void
      {
         FIdentifier0 = param1;
         FIdentifier1 = param2;
      }
      
      LogicsSpace function TimingUpdate() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.FTimingState == CONST_INVENTORY.TIMINGSTATE_Started)
         {
            _loc1_ = STimingCore.TickCount - this.FTimingReferenceTick;
            _loc2_ = _loc1_ / 1000;
            _loc3_ = this.FTimingReferenceTime - _loc2_;
            if(_loc3_ <= 0)
            {
               this.FTimingTime = 0;
               this.FTimingState = CONST_INVENTORY.TIMINGSTATE_Expired;
            }
            else
            {
               this.FTimingTime = _loc3_;
            }
         }
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get Category() : uint
      {
         return this.FCategory;
      }
      
      public function set Category(param1:uint) : void
      {
         this.FCategory = param1;
      }
      
      public function get CategorySecond() : uint
      {
         return this.FCategorySecond;
      }
      
      public function set CategorySecond(param1:uint) : void
      {
         this.FCategorySecond = param1;
      }
      
      public function get IDTemplate() : uint
      {
         return this.FIDTemplate;
      }
      
      public function set IDTemplate(param1:uint) : void
      {
         this.FIDTemplate = param1;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function get Description() : String
      {
         return this.FDescription;
      }
      
      public function set Description(param1:String) : void
      {
         this.FDescription = param1;
      }
      
      public function get IDTexture() : uint
      {
         return this.FIDTexture;
      }
      
      public function set IDTexture(param1:uint) : void
      {
         this.FIDTexture = param1;
      }
      
      public function get Quantity() : uint
      {
         return this.FQuantity;
      }
      
      public function set Quantity(param1:uint) : void
      {
         this.FQuantity = param1;
      }
      
      public function get Quality() : uint
      {
         return this.FQuality;
      }
      
      public function set Quality(param1:uint) : void
      {
         this.FQuality = param1;
      }
      
      public function get IsCanSell() : Boolean
      {
         return this.FIsCanSell;
      }
      
      public function set IsCanSell(param1:Boolean) : void
      {
         this.FIsCanSell = param1;
      }
      
      public function get SellValue() : uint
      {
         return this.FSellValue;
      }
      
      public function set SellValue(param1:uint) : void
      {
         this.FSellValue = param1;
      }
      
      public function get SellingValue() : Number
      {
         return this.FSellingValue;
      }
      
      public function set SellingValue(param1:Number) : void
      {
         this.FSellingValue = param1;
      }
      
      public function get IsCanDiscard() : Boolean
      {
         return this.FIsCanDiscard;
      }
      
      public function set IsCanDiscard(param1:Boolean) : void
      {
         this.FIsCanDiscard = param1;
      }
      
      public function get IsCanReveal() : Boolean
      {
         return this.FIsCanReveal;
      }
      
      public function set IsCanReveal(param1:Boolean) : void
      {
         this.FIsCanReveal = param1;
      }
      
      public function get SortIndex() : uint
      {
         return this.FSortIndex;
      }
      
      public function set SortIndex(param1:uint) : void
      {
         this.FSortIndex = param1;
      }
      
      public function get RequirementLevel() : uint
      {
         return this.FRequirementLevel;
      }
      
      public function set RequirementLevel(param1:uint) : void
      {
         this.FRequirementLevel = param1;
      }
      
      public function get UpgradingLevel() : uint
      {
         return this.FUpgradingLevel;
      }
      
      public function set UpgradingLevel(param1:uint) : void
      {
         this.FUpgradingLevel = param1;
      }
      
      public function get TimingCategory() : uint
      {
         return this.FTimingCategory;
      }
      
      public function set TimingCategory(param1:uint) : void
      {
         this.FTimingCategory = param1;
      }
      
      public function get TimingState() : uint
      {
         return this.FTimingState;
      }
      
      public function set TimingState(param1:uint) : void
      {
         if(param1 == CONST_INVENTORY.TIMINGSTATE_Started)
         {
            this.FTimingReferenceTick = STimingCore.TickCount;
            this.FTimingReferenceTime = this.FTimingTime;
         }
         else
         {
            this.FTimingReferenceTick = 0;
            this.FTimingReferenceTime = 0;
         }
         this.FTimingState = param1;
      }
      
      public function get TempTimingTime() : uint
      {
         return this.FTempTimingTime;
      }
      
      public function set TempTimingTime(param1:uint) : void
      {
         if(this.FTimingState == CONST_INVENTORY.TIMINGSTATE_Started)
         {
            this.FTimingReferenceTick = STimingCore.TickCount;
            this.FTimingReferenceTime = param1;
         }
         else
         {
            this.FTimingReferenceTick = 0;
            this.FTimingReferenceTime = 0;
         }
         this.FTempTimingTime = param1;
      }
      
      public function get TimingTime() : uint
      {
         return this.FTimingTime;
      }
      
      public function set TimingTime(param1:uint) : void
      {
      }
      
      public function get ObtainType() : uint
      {
         return this.FObtainType;
      }
      
      public function set ObtainType(param1:uint) : void
      {
         this.FObtainType = param1;
      }
      
      public function get IsSelling() : Boolean
      {
         return this.FIsSelling;
      }
      
      public function set IsSelling(param1:Boolean) : void
      {
         this.FIsSelling = param1;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function set Type(param1:uint) : void
      {
         this.FType = param1;
      }
      
      public function get IsExchage() : int
      {
         return this.FIsExchage;
      }
      
      public function set IsExchage(param1:int) : void
      {
         this.FIsExchage = param1;
      }
      
      public function get GoldNumberA() : int
      {
         return this.FGoldNumberA;
      }
      
      public function set GoldNumberA(param1:int) : void
      {
         this.FGoldNumberA = param1;
      }
      
      public function get NewType() : int
      {
         return this.FNewType;
      }
      
      public function set NewType(param1:int) : void
      {
         this.FNewType = param1;
      }
      
      public function get NewIdentify() : int
      {
         return this.FNewIdentify;
      }
      
      public function set NewIdentify(param1:int) : void
      {
         this.FNewIdentify = param1;
      }
      
      public function get ShowFire() : int
      {
         return this.FShowFire;
      }
      
      public function set ShowFire(param1:int) : void
      {
         this.FShowFire = param1;
      }
      
      public function set EquipmentDeJade(param1:TEquipment) : void
      {
         this.FEquipmentDeJade = param1;
      }
      
      public function get EquipmentDeJade() : TEquipment
      {
         return this.FEquipmentDeJade;
      }
      
      public function set CurJadeExp(param1:uint) : void
      {
         this.FCurJadeExp = param1;
      }
      
      public function get CurJadeExp() : uint
      {
         return this.FCurJadeExp;
      }
      
      public function set CurUnlock(param1:uint) : void
      {
         this.FCurUnlock = param1;
      }
      
      public function get CurUnlock() : uint
      {
         return this.FCurUnlock;
      }
      
      public function Reset() : void
      {
         this.FCategory = 0;
         this.FCategorySecond = 0;
         this.FIDTemplate = 0;
         this.FName = "";
         this.FDescription = "";
         this.FIDTexture = 0;
         this.FQuantity = 0;
         this.FQuality = 0;
         this.FIsCanSell = false;
         this.FSellingValue = 0;
         this.FIsCanDiscard = false;
         this.FIsCanReveal = false;
         this.FSortIndex = 0;
         this.FRequirementLevel = 0;
         this.FUpgradingLevel = 0;
         this.FTimingCategory = 0;
         this.FTimingState = 0;
         this.FTempTimingTime = 0;
         this.FTimingTime = 0;
         this.FObtainType = 0;
         this.FTimingReferenceTick = 0;
         this.FTimingReferenceTime = 0;
         this.FIsSelling = false;
         this.FType = 0;
         this.FIsExchage = 0;
         this.FGoldNumberA = 0;
      }
   }
}

