package Logics.BloodFete
{
   import Foundation.Common.Integer.UInt64;
   
   public class TBloodFeteSingle
   {
      
      protected var FIdentifierUInt64:UInt64;
      
      protected var FIdentifier:uint;
      
      protected var FLevel:int;
      
      protected var FName:String = "";
      
      protected var FPositionIndex:int = -1;
      
      protected var FEffectId:uint;
      
      protected var FExp:uint;
      
      protected var FAllExp:uint;
      
      protected var FLevelcount:uint;
      
      protected var FNeedExp:uint;
      
      protected var FQuality:uint;
      
      protected var FType:int;
      
      protected var FPrice:int;
      
      protected var FAddAttrArr:Array;
      
      protected var FThisIsAccident:int;
      
      protected var FDevourExp:int;
      
      protected var FNextLevelID:int;
      
      public function TBloodFeteSingle()
      {
         super();
         this.FIdentifierUInt64 = new UInt64();
      }
      
      public function set IdentifierUInt64(param1:UInt64) : void
      {
         this.FIdentifierUInt64 = param1;
      }
      
      public function get IdentifierUInt64() : UInt64
      {
         return this.FIdentifierUInt64;
      }
      
      public function set Identifier(param1:uint) : void
      {
         this.FIdentifier = param1;
      }
      
      public function get Identifier() : uint
      {
         return this.FIdentifier;
      }
      
      public function set ThisIsAccident(param1:int) : void
      {
         this.FThisIsAccident = param1;
      }
      
      public function get ThisIsAccident() : int
      {
         return this.FThisIsAccident;
      }
      
      public function UpdateOthersProperty() : void
      {
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set PositionIndex(param1:int) : void
      {
         this.FPositionIndex = param1;
      }
      
      public function get PositionIndex() : int
      {
         return this.FPositionIndex;
      }
      
      public function set EffectId(param1:uint) : void
      {
         this.FEffectId = param1;
      }
      
      public function get EffectId() : uint
      {
         return this.FEffectId;
      }
      
      public function set Exp(param1:uint) : void
      {
         this.FExp = param1;
      }
      
      public function get Exp() : uint
      {
         return this.FExp;
      }
      
      public function set NeedExp(param1:uint) : void
      {
         this.FNeedExp = param1;
      }
      
      public function get NeedExp() : uint
      {
         return this.FNeedExp;
      }
      
      public function set Levelcount(param1:uint) : void
      {
         this.FLevelcount = param1;
      }
      
      public function get Levelcount() : uint
      {
         return this.FLevelcount;
      }
      
      public function set AllExp(param1:uint) : void
      {
         this.FAllExp = param1;
      }
      
      public function get AllExp() : uint
      {
         return this.FAllExp;
      }
      
      public function set NextLevelID(param1:uint) : void
      {
         this.FNextLevelID = param1;
      }
      
      public function get NextLevelID() : uint
      {
         return this.FNextLevelID;
      }
      
      public function set DevourExp(param1:uint) : void
      {
         this.FDevourExp = param1;
      }
      
      public function get DevourExp() : uint
      {
         return this.FDevourExp;
      }
      
      public function set Level(param1:uint) : void
      {
         this.FLevel = param1;
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function set Quality(param1:uint) : void
      {
         this.FQuality = param1;
      }
      
      public function get Quality() : uint
      {
         return this.FQuality;
      }
      
      public function set Type(param1:int) : void
      {
         this.FType = param1;
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function set Price(param1:int) : void
      {
         this.FPrice = param1;
      }
      
      public function get Price() : int
      {
         return this.FPrice;
      }
      
      public function set AddAttrArr(param1:Array) : void
      {
         this.FAddAttrArr = param1;
      }
      
      public function get AddAttrArr() : Array
      {
         return this.FAddAttrArr;
      }
   }
}

