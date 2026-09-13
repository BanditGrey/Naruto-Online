package Logics.Undertown
{
   public class TUndertownRewardListData
   {
      
      protected var FDiaoLuoTime:uint;
      
      protected var FAllPracticeTime:uint;
      
      protected var FType:uint;
      
      protected var FName:String;
      
      protected var FAwardVect:Vector.<TDailyTaskRewardCopy>;
      
      public function TUndertownRewardListData()
      {
         super();
         this.FAwardVect = new Vector.<TDailyTaskRewardCopy>();
      }
      
      public function set DiaoLuoTime(param1:uint) : void
      {
         this.FDiaoLuoTime = param1;
      }
      
      public function get DiaoLuoTime() : uint
      {
         return this.FDiaoLuoTime;
      }
      
      public function set AllPracticeTime(param1:uint) : void
      {
         this.FAllPracticeTime = param1;
      }
      
      public function get AllPracticeTime() : uint
      {
         return this.FAllPracticeTime;
      }
      
      public function set Type(param1:uint) : void
      {
         this.FType = param1;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get AwardVect() : Vector.<TDailyTaskRewardCopy>
      {
         return this.FAwardVect;
      }
   }
}

