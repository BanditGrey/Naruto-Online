package Logics.BigDipper
{
   import Resources.Constants.CONST_BIGDIPPER;
   
   public class TStarUpgradeInfor
   {
      
      protected var FResultID:int;
      
      protected var FCostMoney:uint;
      
      protected var FCostFreeTime:int;
      
      protected var FLength:int;
      
      protected var FStarID:Vector.<uint>;
      
      protected var FReceiveExperience:Vector.<int>;
      
      protected var FExperience:Vector.<uint>;
      
      protected var FLevel:Vector.<uint>;
      
      public function TStarUpgradeInfor(param1:int)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Vector.<uint> = null;
         super();
         this.FStarID = new Vector.<uint>();
         this.FReceiveExperience = new Vector.<int>();
         this.FExperience = new Vector.<uint>();
         this.FLevel = new Vector.<uint>();
         this.FStarID.length = param1;
         this.FReceiveExperience.length = param1;
         this.FExperience.length = param1;
         this.FLevel.length = param1;
         _loc4_ = CONST_BIGDIPPER.STARID;
         _loc3_ = int(_loc4_.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FStarID[_loc2_] = _loc4_[_loc2_];
            _loc2_++;
         }
      }
      
      public function get ResultID() : int
      {
         return this.FResultID;
      }
      
      public function set ResultID(param1:int) : void
      {
         this.FResultID = param1;
      }
      
      public function get CostMoney() : uint
      {
         return this.FCostMoney;
      }
      
      public function set CostMoney(param1:uint) : void
      {
         this.FCostMoney = param1;
      }
      
      public function get CostFreeTime() : int
      {
         return this.FCostFreeTime;
      }
      
      public function set CostFreeTime(param1:int) : void
      {
         this.FCostFreeTime = param1;
      }
      
      public function GetStarIDByIndex(param1:int) : uint
      {
         return this.FStarID[param1];
      }
      
      public function SetStarIDByIndex(param1:int, param2:uint) : void
      {
         this.FStarID[param1] = param2;
      }
      
      public function GetReceiveExperienceByIndex(param1:int) : int
      {
         return this.FReceiveExperience[param1];
      }
      
      public function GetReceiveExperienceByStarID(param1:uint) : int
      {
         var _loc2_:int = 0;
         _loc2_ = this.IndexByID(param1);
         if(_loc2_ == -1)
         {
            return 0;
         }
         return this.GetReceiveExperienceByIndex(_loc2_);
      }
      
      public function SetReceiveExperienceByIndex(param1:int, param2:int) : void
      {
         this.FReceiveExperience[param1] = param2;
      }
      
      public function SetReceiveExperienceByStarID(param1:uint, param2:int) : void
      {
         var _loc3_:int = 0;
         _loc3_ = this.IndexByID(param1);
         this.FReceiveExperience[_loc3_] = param2;
      }
      
      public function GetExperienceByIndex(param1:int) : uint
      {
         return this.FExperience[param1];
      }
      
      public function GetExperienceByStarID(param1:uint) : uint
      {
         var _loc2_:int = 0;
         _loc2_ = this.IndexByID(param1);
         if(_loc2_ == -1)
         {
            return 0;
         }
         return this.GetExperienceByIndex(_loc2_);
      }
      
      public function SetExperienceByIndex(param1:int, param2:uint) : void
      {
         this.FExperience[param1] = param2;
      }
      
      public function SetExperienceByStarID(param1:uint, param2:uint) : void
      {
         var _loc3_:int = 0;
         _loc3_ = this.IndexByID(param1);
         this.FExperience[_loc3_] = param2;
      }
      
      public function GetLevelByIndex(param1:int) : uint
      {
         return this.FLevel[param1];
      }
      
      public function GetLevelByStarID(param1:int) : uint
      {
         var _loc2_:int = 0;
         _loc2_ = this.IndexByID(param1);
         if(_loc2_ == -1)
         {
            return 0;
         }
         return this.GetLevelByIndex(_loc2_);
      }
      
      public function SetLevelByIndex(param1:int, param2:uint) : void
      {
         this.FLevel[param1] = param2;
      }
      
      public function SetLevelByStarID(param1:uint, param2:uint) : void
      {
         var _loc3_:int = 0;
         _loc3_ = this.IndexByID(param1);
         this.FLevel[_loc3_] = param2;
      }
      
      public function get Length() : int
      {
         return this.FLength;
      }
      
      public function set Length(param1:int) : void
      {
         this.FLength = param1;
      }
      
      public function IndexByID(param1:uint) : int
      {
         var _loc2_:int = 0;
         return this.FStarID.indexOf(param1);
      }
      
      public function Reset() : void
      {
         var _loc1_:int = 0;
         this.FResultID = 0;
         this.FCostMoney = 0;
         this.FCostFreeTime = 0;
         _loc1_ = 0;
         while(_loc1_ < CONST_BIGDIPPER.STAR_NUM)
         {
            this.FReceiveExperience[_loc1_] = 0;
            this.FExperience[_loc1_] = 0;
            this.FLevel[_loc1_] = 0;
            _loc1_++;
         }
         this.FLength = 0;
      }
   }
}

