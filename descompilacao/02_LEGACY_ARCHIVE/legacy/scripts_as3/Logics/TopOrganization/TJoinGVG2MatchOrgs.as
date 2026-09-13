package Logics.TopOrganization
{
   public class TJoinGVG2MatchOrgs
   {
      
      protected var FJoinGVG2MatchOrgs:Vector.<TJoinGVG2MatchOrg>;
      
      public function TJoinGVG2MatchOrgs()
      {
         super();
         this.FJoinGVG2MatchOrgs = new Vector.<TJoinGVG2MatchOrg>();
      }
      
      public function get Count() : uint
      {
         return this.FJoinGVG2MatchOrgs.length;
      }
      
      public function Add(param1:TJoinGVG2MatchOrg) : void
      {
         this.FJoinGVG2MatchOrgs.push(param1);
      }
      
      public function GetJoinGVG2MatchOrgByIndex(param1:int) : TJoinGVG2MatchOrg
      {
         if(param1 < 0 || param1 >= this.FJoinGVG2MatchOrgs.length)
         {
            return null;
         }
         return this.FJoinGVG2MatchOrgs[param1];
      }
      
      public function GetMyOrgByIdentifier(param1:uint) : TJoinGVG2MatchOrg
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TJoinGVG2MatchOrg = null;
         _loc3_ = this.FJoinGVG2MatchOrgs.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FJoinGVG2MatchOrgs[_loc2_];
            if(_loc4_.Identifier == param1)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FJoinGVG2MatchOrgs.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FJoinGVG2MatchOrgs.pop();
            _loc2_++;
         }
         this.FJoinGVG2MatchOrgs.length = 0;
      }
   }
}

