package Logics.Exercise.FrogWallet
{
   public class TShadowConfig
   {
      
      protected var FItemID:int;
      
      protected var FMaxCnt:int;
      
      protected var FItemCnt:Vector.<int>;
      
      protected var FItemMinGold:Vector.<int>;
      
      protected var FItemMaxGold:Vector.<int>;
      
      protected var FRange:Vector.<int>;
      
      public function TShadowConfig()
      {
         super();
         this.FItemCnt = new Vector.<int>();
         this.FItemMinGold = new Vector.<int>();
         this.FItemMaxGold = new Vector.<int>();
         this.FRange = new Vector.<int>();
      }
      
      public function get ItemID() : int
      {
         return this.FItemID;
      }
      
      public function set ItemID(param1:int) : void
      {
         this.FItemID = param1;
      }
      
      public function get MaxCnt() : int
      {
         return this.FMaxCnt;
      }
      
      public function set MaxCnt(param1:int) : void
      {
         this.FMaxCnt = param1;
      }
      
      public function get ItemCnt() : Vector.<int>
      {
         return this.FItemCnt;
      }
      
      public function set ItemCnt(param1:Vector.<int>) : void
      {
         this.FItemCnt = param1;
      }
      
      public function get Range() : Vector.<int>
      {
         return this.FRange;
      }
      
      public function set Range(param1:Vector.<int>) : void
      {
         this.FRange = param1;
      }
      
      public function get ItemMinGold() : Vector.<int>
      {
         return this.FItemMinGold;
      }
      
      public function set ItemMinGold(param1:Vector.<int>) : void
      {
         this.FItemMinGold = param1;
      }
      
      public function get ItemMaxGold() : Vector.<int>
      {
         return this.FItemMaxGold;
      }
      
      public function set ItemMaxGold(param1:Vector.<int>) : void
      {
         this.FItemMaxGold = param1;
      }
   }
}

