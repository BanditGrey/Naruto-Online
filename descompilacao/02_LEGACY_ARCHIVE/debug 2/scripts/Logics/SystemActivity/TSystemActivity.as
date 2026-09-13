package Logics.SystemActivity
{
   import Logics.Inventories.TInventories;
   
   public class TSystemActivity
   {
      
      public static const TYPE_NORMAL:int = 0;
      
      public static const TYPE_HURT:int = 1;
      
      public static const TYPE_POINT:int = 2;
      
      public static const TYPE_STATUS:int = 3;
      
      protected var FIdentify:int;
      
      protected var FActivityName:String;
      
      protected var FActivityTabName:String;
      
      protected var FActivityDesc:String;
      
      protected var FBeginTime:int;
      
      protected var FEndTime:int;
      
      protected var FInventories:TInventories;
      
      protected var FCount:Vector.<int>;
      
      protected var FRewardID:Vector.<int>;
      
      protected var FActivityData:Vector.<TSystemActivityData>;
      
      protected var FActivityType:int;
      
      public function TSystemActivity()
      {
         super();
         this.FCount = new Vector.<int>();
         this.FRewardID = new Vector.<int>();
         this.FActivityData = new Vector.<TSystemActivityData>();
      }
      
      public function get Identify() : int
      {
         return this.FIdentify;
      }
      
      public function set Identify(param1:int) : void
      {
         this.FIdentify = param1;
         switch(this.FIdentify)
         {
            case 1:
               this.FActivityType = TYPE_HURT;
               break;
            case 2:
               this.FActivityType = TYPE_NORMAL;
               break;
            case 3:
               this.FActivityType = TYPE_POINT;
               break;
            case 4:
               this.FActivityType = TYPE_STATUS;
         }
      }
      
      public function get ActivityName() : String
      {
         return this.FActivityName;
      }
      
      public function set ActivityTabName(param1:String) : void
      {
         this.FActivityTabName = param1;
      }
      
      public function get ActivityTabName() : String
      {
         return this.FActivityTabName;
      }
      
      public function set ActivityName(param1:String) : void
      {
         this.FActivityName = param1;
      }
      
      public function get ActivityDesc() : String
      {
         return this.FActivityDesc;
      }
      
      public function set ActivityDesc(param1:String) : void
      {
         this.FActivityDesc = param1;
      }
      
      public function get BeginTime() : int
      {
         return this.FBeginTime;
      }
      
      public function set BeginTime(param1:int) : void
      {
         this.FBeginTime = param1;
      }
      
      public function get EndTime() : int
      {
         return this.FEndTime;
      }
      
      public function set EndTime(param1:int) : void
      {
         this.FEndTime = param1;
      }
      
      public function get Inventories() : TInventories
      {
         return this.FInventories;
      }
      
      public function set Inventories(param1:TInventories) : void
      {
         this.FInventories = param1;
      }
      
      public function get ActivityData() : Vector.<TSystemActivityData>
      {
         return this.FActivityData;
      }
      
      public function set ActivityData(param1:Vector.<TSystemActivityData>) : void
      {
         this.FActivityData = param1;
      }
      
      public function get ActivityType() : int
      {
         return this.FActivityType;
      }
      
      public function set ActivityType(param1:int) : void
      {
         this.FActivityType = param1;
      }
      
      public function get Count() : Vector.<int>
      {
         return this.FCount;
      }
      
      public function set Count(param1:Vector.<int>) : void
      {
         this.FCount = param1;
      }
      
      public function get RewardID() : Vector.<int>
      {
         return this.FRewardID;
      }
      
      public function set RewardID(param1:Vector.<int>) : void
      {
         this.FRewardID = param1;
      }
      
      public function GetOrgNameByRank(param1:int, param2:int) : String
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = int(this.FActivityData.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(this.FActivityData[_loc3_].FamilyType == param1 && this.FActivityData[_loc3_].Rank == param2)
            {
               return this.FActivityData[_loc3_].OrganzationName;
            }
            _loc3_++;
         }
         return "";
      }
   }
}

