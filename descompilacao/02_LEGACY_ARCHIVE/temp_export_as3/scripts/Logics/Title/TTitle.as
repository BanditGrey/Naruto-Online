package Logics.Title
{
   import Logics.DatebaseVO.VO.Json.TAddValue;
   
   public class TTitle
   {
      
      protected var FIdentifier:uint;
      
      protected var FTitleName:String;
      
      protected var FTitleSource:String;
      
      protected var FVipLevel:uint;
      
      protected var FLevel:uint;
      
      protected var FLastTime:Vector.<uint>;
      
      protected var FType:uint;
      
      protected var FEndTime:uint;
      
      protected var FImageId:uint;
      
      protected var FIsEquiped:uint;
      
      protected var FAddValues:Vector.<TAddValue>;
      
      public function TTitle()
      {
         super();
         this.FAddValues = new Vector.<TAddValue>();
         this.FLastTime = new Vector.<uint>();
      }
      
      public function get Identifier() : uint
      {
         return this.FIdentifier;
      }
      
      public function set Identifier(param1:uint) : void
      {
         this.FIdentifier = param1;
      }
      
      public function get TitleName() : String
      {
         return this.FTitleName;
      }
      
      public function set TitleName(param1:String) : void
      {
         this.FTitleName = param1;
      }
      
      public function get TitleSource() : String
      {
         return this.FTitleSource;
      }
      
      public function set TitleSource(param1:String) : void
      {
         this.FTitleSource = param1;
      }
      
      public function get VipLevel() : uint
      {
         return this.FVipLevel;
      }
      
      public function set VipLevel(param1:uint) : void
      {
         this.FVipLevel = param1;
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function set Level(param1:uint) : void
      {
         this.FLevel = param1;
      }
      
      public function get EndTime() : uint
      {
         return this.FEndTime;
      }
      
      public function set EndTime(param1:uint) : void
      {
         this.FEndTime = param1;
      }
      
      public function get ImageId() : uint
      {
         return this.FImageId;
      }
      
      public function set ImageId(param1:uint) : void
      {
         this.FImageId = param1;
      }
      
      public function get AddValues() : Vector.<TAddValue>
      {
         return this.FAddValues;
      }
      
      public function set AddValues(param1:Vector.<TAddValue>) : void
      {
         this.FAddValues = param1;
      }
      
      public function get IsEquiped() : uint
      {
         return this.FIsEquiped;
      }
      
      public function set IsEquiped(param1:uint) : void
      {
         this.FIsEquiped = param1;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function set Type(param1:uint) : void
      {
         this.FType = param1;
      }
      
      public function get LastTime() : Vector.<uint>
      {
         return this.FLastTime;
      }
      
      public function set LastTime(param1:Vector.<uint>) : void
      {
         this.FLastTime = param1;
      }
   }
}

