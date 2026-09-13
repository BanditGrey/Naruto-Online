package Logics.Inventories
{
   import Foundation.Common.Stubs.TStubReferences;
   
   public class TInventorySample extends TInventoryReference
   {
      
      protected var FStubReferences:TStubReferences;
      
      protected var FIndentifier:uint;
      
      protected var FModel:uint;
      
      protected var FName:String;
      
      protected var FMajorType:uint;
      
      protected var FTemplateID:uint;
      
      protected var FConsumeType:String;
      
      protected var FIntegration:int;
      
      protected var FUnlockLevel:int;
      
      protected var FIsVip:int;
      
      protected var FIsDisplay:int;
      
      protected var FAmount:int;
      
      protected var FCostGold:int;
      
      protected var FDiscount:int;
      
      protected var FHotPrice:int;
      
      protected var FPage:int;
      
      protected var FVipLevel:int;
      
      protected var FIsHot:int;
      
      protected var FIsNew:int;
      
      protected var FBuyTimes:int;
      
      protected var FSortID:uint;
      
      public function TInventorySample()
      {
         super();
         this.FStubReferences = new TStubReferences(this);
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get TemplateID() : uint
      {
         return this.FTemplateID;
      }
      
      public function set TemplateID(param1:uint) : void
      {
         this.FTemplateID = param1;
      }
      
      public function get Indentifier() : uint
      {
         return this.FIndentifier;
      }
      
      public function set Indentifier(param1:uint) : void
      {
         this.FIndentifier = param1;
      }
      
      public function get Model() : uint
      {
         return this.FModel;
      }
      
      public function set Model(param1:uint) : void
      {
         this.FModel = param1;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function get MajorType() : uint
      {
         return this.FMajorType;
      }
      
      public function set MajorType(param1:uint) : void
      {
         this.FMajorType = param1;
      }
      
      public function get ConsumeType() : String
      {
         return this.FConsumeType;
      }
      
      public function set ConsumeType(param1:String) : void
      {
         this.FConsumeType = param1;
      }
      
      public function get Integration() : int
      {
         return this.FIntegration;
      }
      
      public function set Integration(param1:int) : void
      {
         this.FIntegration = param1;
      }
      
      public function get UnlockLevel() : int
      {
         return this.FUnlockLevel;
      }
      
      public function set UnlockLevel(param1:int) : void
      {
         this.FUnlockLevel = param1;
      }
      
      public function get IsVip() : int
      {
         return this.FIsVip;
      }
      
      public function set IsVip(param1:int) : void
      {
         this.FIsVip = param1;
      }
      
      public function get IsDisplay() : int
      {
         return this.FIsDisplay;
      }
      
      public function set IsDisplay(param1:int) : void
      {
         this.FIsDisplay = param1;
      }
      
      public function get Amount() : int
      {
         return this.FAmount;
      }
      
      public function set Amount(param1:int) : void
      {
         this.FAmount = param1;
      }
      
      public function get CostGold() : int
      {
         return this.FCostGold;
      }
      
      public function set CostGold(param1:int) : void
      {
         this.FCostGold = param1;
      }
      
      public function get Discount() : int
      {
         return this.FDiscount;
      }
      
      public function set Discount(param1:int) : void
      {
         this.FDiscount = param1;
      }
      
      public function get HotPrice() : int
      {
         return this.FHotPrice;
      }
      
      public function set HotPrice(param1:int) : void
      {
         this.FHotPrice = param1;
      }
      
      public function get Page() : int
      {
         return this.FPage;
      }
      
      public function set Page(param1:int) : void
      {
         this.FPage = param1;
      }
      
      public function get VipLevel() : int
      {
         return this.FVipLevel;
      }
      
      public function set VipLevel(param1:int) : void
      {
         this.FVipLevel = param1;
      }
      
      public function get IsHot() : int
      {
         return this.FIsHot;
      }
      
      public function set IsHot(param1:int) : void
      {
         this.FIsHot = param1;
      }
      
      public function get IsNew() : int
      {
         return this.FIsNew;
      }
      
      public function set IsNew(param1:int) : void
      {
         this.FIsNew = param1;
      }
      
      public function get BuyTimes() : int
      {
         return this.FBuyTimes;
      }
      
      public function set BuyTimes(param1:int) : void
      {
         this.FBuyTimes = param1;
      }
      
      public function get SortID() : uint
      {
         return this.FSortID;
      }
      
      public function set SortID(param1:uint) : void
      {
         this.FSortID = param1;
      }
      
      public function Clear() : void
      {
      }
   }
}

