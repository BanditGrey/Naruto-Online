package Logics.Exercise.JanActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TJanActive1 extends TBaseActivity
   {
      
      public var ScoreA:int;
      
      public var ScoreB:int;
      
      public var ConsumeScore:int;
      
      public var AutoPrice:int;
      
      public var MaxCount:int;
      
      public var IceIndex:int;
      
      public var ScorePrice:int;
      
      public var Gift:TBaseBox;
      
      public var ShowItems:TInventories;
      
      public var EquipList:TInventories;
      
      public var TitleList:Vector.<uint>;
      
      public var IceList:Vector.<int>;
      
      public var PriceList:Vector.<int>;
      
      public var TreeList:Vector.<TBaseBox>;
      
      public var FirstPlay:int;
      
      public var AllIceList:Vector.<uint>;
      
      public function TJanActive1()
      {
         super();
         this.TitleList = new Vector.<uint>();
         this.IceList = new Vector.<int>();
         this.PriceList = new Vector.<int>();
         this.TreeList = new Vector.<TBaseBox>();
         this.AllIceList = new Vector.<uint>();
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < FShopRewardItems.length)
         {
            if(FShopRewardItems[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && FRankPoint >= FShopRewardItems[_loc1_].Price)
            {
               FShopRewardItems[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
   }
}

