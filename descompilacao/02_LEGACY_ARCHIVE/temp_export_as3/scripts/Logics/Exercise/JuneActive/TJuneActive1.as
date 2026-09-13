package Logics.Exercise.JuneActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TJuneActive1 extends TBaseActivity
   {
      
      public static const MAX_COUNT:int = 50;
      
      public static const GAME_STATUS_NORMAL:int = 0;
      
      public static const GAME_STATUS_END:int = 1;
      
      protected var FGameStatus:int;
      
      protected var FSignStatus:int;
      
      protected var FSurpriseStatus:int;
      
      protected var FCurIndex:int;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      public function TJuneActive1()
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super();
         this.FBoxList = new Vector.<TBaseBox>(MAX_COUNT);
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            this.FBoxList[_loc1_] = new TBaseBox();
            this.FBoxList[_loc1_].Inventories = new TInventories();
            _loc1_++;
         }
      }
      
      public function get SignStatus() : int
      {
         return this.FSignStatus;
      }
      
      public function set SignStatus(param1:int) : void
      {
         this.FSignStatus = param1;
      }
      
      public function get CurIndex() : int
      {
         return this.FCurIndex;
      }
      
      public function set CurIndex(param1:int) : void
      {
         this.FCurIndex = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get GameStatus() : int
      {
         return this.FGameStatus;
      }
      
      public function set GameStatus(param1:int) : void
      {
         this.FGameStatus = param1;
      }
      
      public function get SurpriseStatus() : int
      {
         return this.FSurpriseStatus;
      }
      
      public function set SurpriseStatus(param1:int) : void
      {
         this.FSurpriseStatus = param1;
      }
      
      public function GetNextBoxIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.FCurIndex == this.FBoxList.length - 1)
         {
            return this.FCurIndex;
         }
         _loc3_ = int(this.FBoxList.length);
         _loc2_ = this.FCurIndex + 1;
         while(_loc2_ < _loc3_)
         {
            if(this.FBoxList[_loc2_] != null && this.FBoxList[_loc2_].Type == 2)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
   }
}

