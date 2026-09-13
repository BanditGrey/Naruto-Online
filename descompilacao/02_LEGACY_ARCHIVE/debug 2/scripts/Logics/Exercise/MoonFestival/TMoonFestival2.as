package Logics.Exercise.MoonFestival
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TMoonFestival2 extends TBaseActivity
   {
      
      public var Score:int;
      
      public var Count:int;
      
      public var TenPrice:int;
      
      public var SweetList:Vector.<TBaseBox>;
      
      public var StatusList:Vector.<int>;
      
      public var IndexList:Vector.<int>;
      
      public var AmountList:Vector.<int>;
      
      public var ShowItems:TInventories;
      
      public var Pet:TBaseBox;
      
      public function TMoonFestival2()
      {
         super();
         this.SweetList = new Vector.<TBaseBox>();
         this.StatusList = new Vector.<int>();
         this.IndexList = new Vector.<int>();
         this.AmountList = new Vector.<int>();
      }
      
      public function ChangeStatus() : void
      {
      }
   }
}

