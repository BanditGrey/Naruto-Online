package Logics.Exercise.OctActive
{
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   
   public class TOctActive1 extends TBaseActivity
   {
      
      protected var FMyScore:int;
      
      protected var FTotalCount:int;
      
      protected var FRound:int;
      
      protected var FIsBoxVisible:int;
      
      protected var FItemIDA:uint;
      
      protected var FItemIDB:uint;
      
      protected var FBigBox:TBaseBox;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FServerList:Vector.<TBaseBox>;
      
      protected var FShowItems:TInventories;
      
      public function TOctActive1()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FServerList = new Vector.<TBaseBox>();
      }
      
      public function get BigBox() : TBaseBox
      {
         return this.FBigBox;
      }
      
      public function set BigBox(param1:TBaseBox) : void
      {
         this.FBigBox = param1;
      }
      
      public function get ItemIDA() : uint
      {
         return this.FItemIDA;
      }
      
      public function set ItemIDA(param1:uint) : void
      {
         this.FItemIDA = param1;
      }
      
      public function get ItemIDB() : uint
      {
         return this.FItemIDB;
      }
      
      public function set ItemIDB(param1:uint) : void
      {
         this.FItemIDB = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get MyScore() : int
      {
         return this.FMyScore;
      }
      
      public function set MyScore(param1:int) : void
      {
         this.FMyScore = param1;
      }
      
      public function get ServerList() : Vector.<TBaseBox>
      {
         return this.FServerList;
      }
      
      public function set ServerList(param1:Vector.<TBaseBox>) : void
      {
         this.FServerList = param1;
      }
      
      public function get ShowItems() : TInventories
      {
         return this.FShowItems;
      }
      
      public function set ShowItems(param1:TInventories) : void
      {
         this.FShowItems = param1;
      }
      
      public function get TotalCount() : int
      {
         return this.FTotalCount;
      }
      
      public function set TotalCount(param1:int) : void
      {
         this.FTotalCount = param1;
      }
      
      public function get Round() : int
      {
         return this.FRound;
      }
      
      public function set Round(param1:int) : void
      {
         this.FRound = param1;
      }
      
      public function get IsBoxVisible() : int
      {
         return this.FIsBoxVisible;
      }
      
      public function set IsBoxVisible(param1:int) : void
      {
         this.FIsBoxVisible = param1;
      }
      
      public function get TaskStatus() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TActivityTaskData = null;
         _loc3_ = SLogicsCore.ActivityTaskData;
         _loc2_ = int(_loc3_.TaskList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc3_.TaskList[_loc1_].Step != TBaseActivity.STATUS_CANNOTGET)
            {
               return TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:TActivityTaskData = null;
         _loc4_ = SLogicsCore.ActivityTaskData;
         if(Boolean(this.FBigBox) && Boolean(this.FBigBox.Status == TBaseActivity.STATUS_CANNOTGET) && FRankPoint >= this.FBigBox.Price)
         {
            this.FBigBox.Status = TBaseActivity.STATUS_CANGET;
         }
         _loc2_ = int(_loc4_.TaskList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc4_.TaskList[_loc1_].Step != TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_ = true;
               break;
            }
            _loc1_++;
         }
         if(_loc3_)
         {
            _loc2_ = int(this.FServerList.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               if(this.FServerList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.FTotalCount >= this.FServerList[_loc1_].Price)
               {
                  this.FServerList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
               }
               _loc1_++;
            }
         }
      }
   }
}

