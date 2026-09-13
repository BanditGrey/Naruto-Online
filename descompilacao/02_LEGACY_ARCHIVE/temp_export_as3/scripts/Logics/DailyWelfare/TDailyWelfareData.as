package Logics.DailyWelfare
{
   public class TDailyWelfareData
   {
      
      protected var FWorldLevel:uint;
      
      protected var FRewardStatus:Vector.<int>;
      
      protected var FResourceFoundId:Vector.<uint>;
      
      protected var FResourceFoundTimes:Vector.<uint>;
      
      protected var FResourceFoundStatus:Vector.<uint>;
      
      protected var FEndTimer:int;
      
      protected var FOffdays:int;
      
      public function TDailyWelfareData()
      {
         super();
         this.FRewardStatus = new Vector.<int>(3);
         this.FResourceFoundId = new Vector.<uint>();
         this.FResourceFoundTimes = new Vector.<uint>();
         this.FResourceFoundStatus = new Vector.<uint>();
      }
      
      public function get WorldLevel() : uint
      {
         return this.FWorldLevel;
      }
      
      public function set WorldLevel(param1:uint) : void
      {
         this.FWorldLevel = param1;
      }
      
      public function get RewardStatus() : Vector.<int>
      {
         return this.FRewardStatus;
      }
      
      public function set RewardStatus(param1:Vector.<int>) : void
      {
         this.FRewardStatus = param1;
      }
      
      public function get EndTimer() : int
      {
         return this.FEndTimer;
      }
      
      public function set EndTimer(param1:int) : void
      {
         this.FEndTimer = param1;
      }
      
      public function get Offdays() : int
      {
         return this.FOffdays;
      }
      
      public function set Offdays(param1:int) : void
      {
         this.FOffdays = param1;
      }
      
      public function SetReardStatus(param1:uint, param2:int) : void
      {
         this.FRewardStatus[param1] = param2;
      }
      
      public function SetResourceData(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc4_:int = 0;
         _loc4_ = this.FResourceFoundId.indexOf(param1);
         if(_loc4_ < 0)
         {
            this.FResourceFoundId.push(param1);
            this.FResourceFoundTimes.push(param2);
            this.FResourceFoundStatus.push(param3);
         }
         else
         {
            this.FResourceFoundTimes[_loc4_] = param2;
            this.FResourceFoundStatus[_loc4_] = param3;
         }
      }
      
      public function SetGroupResourceData() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FResourceFoundId.length)
         {
            this.FResourceFoundTimes[_loc1_] = 0;
            if(this.FResourceFoundStatus[_loc1_] == 1)
            {
               this.FResourceFoundStatus[_loc1_] = 2;
            }
            _loc1_++;
         }
      }
      
      public function GetGroupResourceFoundCount() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc2_ = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FResourceFoundId.length)
         {
            if(this.FResourceFoundStatus[_loc1_] == 1)
            {
               _loc2_++;
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function GetResourceTimesById(param1:uint) : uint
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         _loc2_ = this.FResourceFoundId.indexOf(param1);
         if(_loc2_ < 0)
         {
            _loc3_ = 0;
         }
         else
         {
            _loc3_ = this.FResourceFoundTimes[_loc2_];
         }
         return _loc3_;
      }
      
      public function GetResourceStatusById(param1:uint) : uint
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         _loc2_ = this.FResourceFoundId.indexOf(param1);
         if(_loc2_ < 0)
         {
            _loc3_ = 3;
         }
         else
         {
            _loc3_ = this.FResourceFoundStatus[_loc2_];
         }
         return _loc3_;
      }
      
      public function get ResourceFoundIdCount() : uint
      {
         return this.FResourceFoundId.length;
      }
   }
}

