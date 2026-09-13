package Logics.TopOrganization
{
   public class TJoinOrganizations
   {
      
      protected var FJoinOrganizations:Vector.<TJoinOrganization>;
      
      public function TJoinOrganizations()
      {
         super();
         this.FJoinOrganizations = new Vector.<TJoinOrganization>();
      }
      
      public function get Count() : uint
      {
         return this.FJoinOrganizations.length;
      }
      
      public function Add(param1:TJoinOrganization) : void
      {
         this.FJoinOrganizations.push(param1);
      }
      
      public function GetTopOrganizationReportByIndex(param1:int) : TJoinOrganization
      {
         if(param1 < 0 || param1 >= this.FJoinOrganizations.length)
         {
            return null;
         }
         return this.FJoinOrganizations[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FJoinOrganizations.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FJoinOrganizations.pop();
            _loc2_++;
         }
         this.FJoinOrganizations.length = 0;
      }
   }
}

