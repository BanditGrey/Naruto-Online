package Logics.TopOrganization
{
   import Foundation.Common.TEntity;
   
   public class TJoinGVG2MatchOrg extends TEntity
   {
      
      protected var FOrganizaionName:String;
      
      protected var FGVG2Status:uint;
      
      protected var FLoseCount:uint;
      
      public function TJoinGVG2MatchOrg(param1:uint)
      {
         super(param1);
         this.FOrganizaionName = "";
      }
      
      public function get OrganizaionName() : String
      {
         return this.FOrganizaionName;
      }
      
      public function set OrganizaionName(param1:String) : void
      {
         this.FOrganizaionName = param1;
      }
      
      public function get GVG2Status() : uint
      {
         return this.FGVG2Status;
      }
      
      public function set GVG2Status(param1:uint) : void
      {
         this.FGVG2Status = param1;
      }
      
      public function get LoseCount() : uint
      {
         return this.FLoseCount;
      }
      
      public function set LoseCount(param1:uint) : void
      {
         this.FLoseCount = param1;
      }
   }
}

