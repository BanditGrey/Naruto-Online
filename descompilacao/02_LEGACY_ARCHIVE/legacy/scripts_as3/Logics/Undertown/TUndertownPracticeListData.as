package Logics.Undertown
{
   import Logics.DatebaseVO.VO.TDungeonsPractise;
   
   public class TUndertownPracticeListData
   {
      
      protected var FIdentifier0:uint;
      
      protected var FIdentifier1:uint;
      
      protected var FPracticeEndTime:uint;
      
      protected var FUserName:String;
      
      protected var FFirstOccupyProtectEndTime:uint;
      
      protected var FAttackedProtectEndTime:uint;
      
      protected var FDungeonsPractiseData:TDungeonsPractise;
      
      public function TUndertownPracticeListData()
      {
         super();
      }
      
      public function Rest() : void
      {
         this.FPracticeEndTime = 0;
         this.FFirstOccupyProtectEndTime = 0;
         this.FAttackedProtectEndTime = 0;
      }
      
      public function set DungeonsPractiseData(param1:TDungeonsPractise) : void
      {
         this.FDungeonsPractiseData = param1;
      }
      
      public function get DungeonsPractiseData() : TDungeonsPractise
      {
         return this.FDungeonsPractiseData;
      }
      
      public function set AttackedProtectEndTime(param1:uint) : void
      {
         this.FAttackedProtectEndTime = param1;
      }
      
      public function get AttackedProtectEndTime() : uint
      {
         return this.FAttackedProtectEndTime;
      }
      
      public function set FirstOccupyProtectEndTime(param1:uint) : void
      {
         this.FFirstOccupyProtectEndTime = param1;
      }
      
      public function get FirstOccupyProtectEndTime() : uint
      {
         return this.FFirstOccupyProtectEndTime;
      }
      
      public function set UserName(param1:String) : void
      {
         this.FUserName = param1;
      }
      
      public function get UserName() : String
      {
         return this.FUserName;
      }
      
      public function set PracticeEndTime(param1:uint) : void
      {
         this.FPracticeEndTime = param1;
      }
      
      public function get PracticeEndTime() : uint
      {
         return this.FPracticeEndTime;
      }
      
      public function set Identifier0(param1:uint) : void
      {
         this.FIdentifier0 = param1;
      }
      
      public function get Identifier0() : uint
      {
         return this.FIdentifier0;
      }
      
      public function set Identifier1(param1:uint) : void
      {
         this.FIdentifier1 = param1;
      }
      
      public function get Identifier1() : uint
      {
         return this.FIdentifier1;
      }
      
      public function get TimeLimit() : uint
      {
         return this.FDungeonsPractiseData.PractiseMaxTime * 60 * 60;
      }
   }
}

