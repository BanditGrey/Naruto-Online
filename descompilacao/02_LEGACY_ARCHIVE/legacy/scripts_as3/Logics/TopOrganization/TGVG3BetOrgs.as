package Logics.TopOrganization
{
   public class TGVG3BetOrgs
   {
      
      protected var FGVG3BetOrgs:Vector.<TGVG3BetOrg>;
      
      public function TGVG3BetOrgs()
      {
         super();
         this.FGVG3BetOrgs = new Vector.<TGVG3BetOrg>();
      }
      
      public function get Count() : uint
      {
         return this.FGVG3BetOrgs.length;
      }
      
      public function Add(param1:TGVG3BetOrg) : void
      {
         this.FGVG3BetOrgs.push(param1);
      }
      
      public function GetGVG3BetOrgByIndex(param1:int) : TGVG3BetOrg
      {
         if(param1 < 0 || param1 >= this.FGVG3BetOrgs.length)
         {
            return null;
         }
         return this.FGVG3BetOrgs[param1];
      }
      
      public function GetIndex(param1:TGVG3BetOrg) : int
      {
         var _loc2_:int = 0;
         _loc2_ = this.FGVG3BetOrgs.indexOf(param1);
         if(_loc2_ > -1)
         {
            return _loc2_;
         }
         return -1;
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FGVG3BetOrgs.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FGVG3BetOrgs.pop();
            _loc2_++;
         }
         this.FGVG3BetOrgs.length = 0;
      }
   }
}

