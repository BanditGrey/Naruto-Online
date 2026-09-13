package Processors.Game.Lobby.BigDipper
{
   public class TBigDipperTipData
   {
      
      protected var FDataChanged:Boolean;
      
      protected var FResourceID:uint;
      
      protected var FStarName:String;
      
      protected var FStarCurrentExp:String;
      
      protected var FStarNeedExp:String;
      
      protected var FCurrentLevelCeiling:String;
      
      protected var FStarAddAttrTypeName:String;
      
      protected var FStarAddAttrValue:String;
      
      protected var FStarNextAddAttrTypeName:String;
      
      protected var FStarNextAddAttrValue:String;
      
      public function TBigDipperTipData()
      {
         super();
      }
      
      public function get StarName() : String
      {
         return this.FStarName;
      }
      
      public function set StarName(param1:String) : void
      {
         this.FStarName = param1;
      }
      
      public function get StarCurrentExp() : String
      {
         return this.FStarCurrentExp;
      }
      
      public function set StarCurrentExp(param1:String) : void
      {
         this.FStarCurrentExp = param1;
      }
      
      public function get StarNeedExp() : String
      {
         return this.FStarNeedExp;
      }
      
      public function set StarNeedExp(param1:String) : void
      {
         this.FStarNeedExp = param1;
      }
      
      public function get CurrentLevelCeiling() : String
      {
         return this.FCurrentLevelCeiling;
      }
      
      public function set CurrentLevelCeiling(param1:String) : void
      {
         this.FCurrentLevelCeiling = param1;
      }
      
      public function get StarAddAttrTypeName() : String
      {
         return this.FStarAddAttrTypeName;
      }
      
      public function set StarAddAttrTypeName(param1:String) : void
      {
         this.FStarAddAttrTypeName = param1;
      }
      
      public function get StarAddAttrValue() : String
      {
         return this.FStarAddAttrValue;
      }
      
      public function set StarAddAttrValue(param1:String) : void
      {
         this.FStarAddAttrValue = param1;
      }
      
      public function get StarNextAddAttrTypeName() : String
      {
         return this.FStarNextAddAttrTypeName;
      }
      
      public function set StarNextAddAttrTypeName(param1:String) : void
      {
         this.FStarNextAddAttrTypeName = param1;
      }
      
      public function get StarNextAddAttrValue() : String
      {
         return this.FStarNextAddAttrValue;
      }
      
      public function set StarNextAddAttrValue(param1:String) : void
      {
         this.FStarNextAddAttrValue = param1;
      }
      
      public function get DataChanged() : Boolean
      {
         return this.FDataChanged;
      }
      
      public function set DataChanged(param1:Boolean) : void
      {
         this.FDataChanged = param1;
      }
      
      public function get ResourceID() : uint
      {
         return this.FResourceID;
      }
      
      public function set ResourceID(param1:uint) : void
      {
         this.FResourceID = param1;
      }
   }
}

