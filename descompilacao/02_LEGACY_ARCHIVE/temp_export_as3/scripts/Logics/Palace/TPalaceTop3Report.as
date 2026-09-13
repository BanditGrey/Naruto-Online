package Logics.Palace
{
   import Foundation.Common.Stubs.TStubReferences;
   
   public class TPalaceTop3Report
   {
      
      protected var FChallengeName:String;
      
      protected var FTargetName:String;
      
      protected var FTime:uint;
      
      protected var FReportID:String;
      
      protected var FIsWin:Boolean;
      
      protected var FStubReferences:TStubReferences;
      
      public function TPalaceTop3Report()
      {
         super();
         this.FStubReferences = new TStubReferences(this);
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get ChallengeName() : String
      {
         return this.FChallengeName;
      }
      
      public function set ChallengeName(param1:String) : void
      {
         this.FChallengeName = param1;
      }
      
      public function get Time() : uint
      {
         return this.FTime;
      }
      
      public function set Time(param1:uint) : void
      {
         this.FTime = param1;
      }
      
      public function get ReportID() : String
      {
         return this.FReportID;
      }
      
      public function set ReportID(param1:String) : void
      {
         this.FReportID = param1;
      }
      
      public function get IsWin() : Boolean
      {
         return this.FIsWin;
      }
      
      public function set IsWin(param1:Boolean) : void
      {
         this.FIsWin = param1;
      }
      
      public function get TargetName() : String
      {
         return this.FTargetName;
      }
      
      public function set TargetName(param1:String) : void
      {
         this.FTargetName = param1;
      }
   }
}

