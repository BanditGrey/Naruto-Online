package Logics.Lottery
{
   import Foundation.Common.Stubs.TStubReferences;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   
   public class TLotteryNews
   {
      
      protected var FStubReferences:TStubReferences;
      
      protected var FIdentifier0:uint;
      
      protected var FIdentifier1:uint;
      
      protected var FPlayerNick:String;
      
      protected var FNewsType:int;
      
      protected var FIdentify:int;
      
      protected var FGetTime:int;
      
      protected var FGetSource:String;
      
      protected var FCount:int;
      
      protected var FInventories:TInventories;
      
      protected var FInventory:TInventory;
      
      protected var FDesc1:String;
      
      protected var FSoureID:int;
      
      public var PriceList:Vector.<int>;
      
      public var StatusList:Vector.<int>;
      
      public var ServerID:String;
      
      public function TLotteryNews()
      {
         super();
         this.FStubReferences = new TStubReferences(this);
         this.FGetSource = "";
         this.PriceList = new Vector.<int>();
         this.StatusList = new Vector.<int>();
      }
      
      public function get GetSource() : String
      {
         return this.FGetSource;
      }
      
      public function set GetSource(param1:String) : void
      {
         this.FGetSource = param1;
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get PlayerNick() : String
      {
         return this.FPlayerNick;
      }
      
      public function set PlayerNick(param1:String) : void
      {
         this.FPlayerNick = param1;
      }
      
      public function get NewsType() : int
      {
         return this.FNewsType;
      }
      
      public function set NewsType(param1:int) : void
      {
         this.FNewsType = param1;
      }
      
      public function get Identifier0() : uint
      {
         return this.FIdentifier0;
      }
      
      public function set Identifier0(param1:uint) : void
      {
         this.FIdentifier0 = param1;
      }
      
      public function get Identifier1() : uint
      {
         return this.FIdentifier1;
      }
      
      public function set Identifier1(param1:uint) : void
      {
         this.FIdentifier1 = param1;
      }
      
      public function get Identify() : int
      {
         return this.FIdentify;
      }
      
      public function set Identify(param1:int) : void
      {
         this.FIdentify = param1;
      }
      
      public function get GetTime() : int
      {
         return this.FGetTime;
      }
      
      public function set GetTime(param1:int) : void
      {
         this.FGetTime = param1;
      }
      
      public function get Inventories() : TInventories
      {
         return this.FInventories;
      }
      
      public function set Inventories(param1:TInventories) : void
      {
         this.FInventories = param1;
      }
      
      public function get Inventory() : TInventory
      {
         return this.FInventory;
      }
      
      public function set Inventory(param1:TInventory) : void
      {
         this.FInventory = param1;
      }
      
      public function get Desc1() : String
      {
         return this.FDesc1;
      }
      
      public function set Desc1(param1:String) : void
      {
         this.FDesc1 = param1;
      }
      
      public function get SoureID() : int
      {
         return this.FSoureID;
      }
      
      public function set SoureID(param1:int) : void
      {
         this.FSoureID = param1;
      }
      
      public function get Count() : int
      {
         return this.FCount;
      }
      
      public function set Count(param1:int) : void
      {
         this.FCount = param1;
      }
   }
}

