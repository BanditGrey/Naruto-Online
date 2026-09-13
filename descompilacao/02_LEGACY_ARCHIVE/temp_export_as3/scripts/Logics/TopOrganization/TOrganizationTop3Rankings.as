package Logics.TopOrganization
{
   public class TOrganizationTop3Rankings
   {
      
      protected var FOrganizationTop3Rankings:Vector.<TOrganizationTop3Ranking>;
      
      public function TOrganizationTop3Rankings()
      {
         super();
         this.FOrganizationTop3Rankings = new Vector.<TOrganizationTop3Ranking>();
      }
      
      protected function SortByRank(param1:TOrganizationTop3Ranking, param2:TOrganizationTop3Ranking) : int
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc3_ = param1.Rank;
         _loc4_ = param2.Rank;
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 0;
      }
      
      public function get Count() : uint
      {
         return this.FOrganizationTop3Rankings.length;
      }
      
      public function Add(param1:TOrganizationTop3Ranking) : void
      {
         this.FOrganizationTop3Rankings.push(param1);
      }
      
      public function GetTopOrganizationReportByIndex(param1:int) : TOrganizationTop3Ranking
      {
         if(param1 < 0 || param1 >= this.FOrganizationTop3Rankings.length)
         {
            return null;
         }
         return this.FOrganizationTop3Rankings[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FOrganizationTop3Rankings.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FOrganizationTop3Rankings.pop();
            _loc2_++;
         }
         this.FOrganizationTop3Rankings.length = 0;
      }
      
      public function Sort() : void
      {
         this.FOrganizationTop3Rankings.sort(this.SortByRank);
      }
   }
}

