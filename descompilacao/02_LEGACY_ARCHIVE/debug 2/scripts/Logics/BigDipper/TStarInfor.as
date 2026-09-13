package Logics.BigDipper
{
   public class TStarInfor
   {
      
      protected var FStarID:uint;
      
      protected var FStarLevel:uint;
      
      protected var FUpgradeNeedExp:uint;
      
      protected var FAttributeType:int;
      
      protected var FAttributeValue:String;
      
      protected var FCurrentExp:uint;
      
      protected var FAttributeName:String;
      
      protected var FStarNameID:int;
      
      protected var FStarName:String;
      
      protected var FCurrentLevelCeiling:uint;
      
      protected var FStarNextAddAttrValue:String;
      
      public function TStarInfor()
      {
         super();
      }
      
      public function get StarID() : uint
      {
         return this.FStarID;
      }
      
      public function set StarID(param1:uint) : void
      {
         this.FStarID = param1;
      }
      
      public function get StarLevel() : uint
      {
         return this.FStarLevel;
      }
      
      public function set StarLevel(param1:uint) : void
      {
         this.FStarLevel = param1;
      }
      
      public function get UpgradeNeedExp() : uint
      {
         return this.FUpgradeNeedExp;
      }
      
      public function set UpgradeNeedExp(param1:uint) : void
      {
         this.FUpgradeNeedExp = param1;
      }
      
      public function get AttributeType() : int
      {
         return this.FAttributeType;
      }
      
      public function set AttributeType(param1:int) : void
      {
         this.FAttributeType = param1;
      }
      
      public function get AttributeValue() : String
      {
         return this.FAttributeValue;
      }
      
      public function set AttributeValue(param1:String) : void
      {
         this.FAttributeValue = param1;
      }
      
      public function get AttributeName() : String
      {
         return this.FAttributeName;
      }
      
      public function set AttributeName(param1:String) : void
      {
         this.FAttributeName = param1;
      }
      
      public function get StarName() : String
      {
         return this.FStarName;
      }
      
      public function set StarName(param1:String) : void
      {
         this.FStarName = param1;
      }
      
      public function get CurrentLevelCeiling() : uint
      {
         return this.FCurrentLevelCeiling;
      }
      
      public function set CurrentLevelCeiling(param1:uint) : void
      {
         this.FCurrentLevelCeiling = param1;
      }
      
      public function get StarNameID() : int
      {
         return this.FStarNameID;
      }
      
      public function set StarNameID(param1:int) : void
      {
         this.FStarNameID = param1;
      }
      
      public function get CurrentExp() : uint
      {
         return this.FCurrentExp;
      }
      
      public function set CurrentExp(param1:uint) : void
      {
         this.FCurrentExp = param1;
      }
      
      public function get StarNextAddAttrValue() : String
      {
         return this.FStarNextAddAttrValue;
      }
      
      public function set StarNextAddAttrValue(param1:String) : void
      {
         this.FStarNextAddAttrValue = param1;
      }
   }
}

