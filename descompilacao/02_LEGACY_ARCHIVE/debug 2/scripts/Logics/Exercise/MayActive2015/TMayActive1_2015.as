package Logics.Exercise.MayActive2015
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TMayActive1_2015 extends TBaseActivity
   {
      
      public var ScoreA:int;
      
      public var Price:int;
      
      public var AutoPrice:int;
      
      public var ScorePrice:int;
      
      public var ConsumeScore:int;
      
      public var MaxCard:int;
      
      public var OpenCard:int;
      
      public var CurValue:int;
      
      public var LuckyIndex:int;
      
      public var ShowList:Vector.<Object>;
      
      public var IsFirstPlay:int;
      
      public var MatchIndex:Vector.<int>;
      
      public var CardScore:Vector.<int>;
      
      public var Gift:TBaseBox;
      
      public var ShowItems:TInventories;
      
      public var EquipList:TInventories;
      
      public var TitleList:Vector.<uint>;
      
      public var CardList:Vector.<int>;
      
      public function TMayActive1_2015()
      {
         super();
         this.MatchIndex = new Vector.<int>();
         this.CardScore = new Vector.<int>();
         this.ShowList = new Vector.<Object>();
         this.TitleList = new Vector.<uint>();
         this.CardList = new Vector.<int>();
      }
      
      public function get IsDouble() : int
      {
         return this.CardList.indexOf(this.LuckyIndex);
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
      }
      
      public function ResetCard() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.CurValue = 0;
         _loc1_ = 0;
         while(_loc1_ < this.MatchIndex.length)
         {
            this.MatchIndex[_loc1_] = 0;
            _loc1_++;
         }
         this.OpenCard = 0;
         _loc2_ = int(this.CardList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.CardList[_loc1_] = 0;
            _loc1_++;
         }
      }
   }
}

