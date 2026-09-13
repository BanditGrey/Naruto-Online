package Logics.TopOrganization
{
   public class TGVG3BattleOrgs
   {
      
      protected var FGVG3BattleOrgs:Vector.<TGVG3BattleOrg>;
      
      public function TGVG3BattleOrgs()
      {
         super();
         this.FGVG3BattleOrgs = new Vector.<TGVG3BattleOrg>();
      }
      
      public function get Count() : uint
      {
         return this.FGVG3BattleOrgs.length;
      }
      
      public function Add(param1:TGVG3BattleOrg) : void
      {
         this.FGVG3BattleOrgs.push(param1);
      }
      
      public function GetGVG3BattleOrgByIndex(param1:int) : TGVG3BattleOrg
      {
         if(param1 < 0 || param1 >= this.FGVG3BattleOrgs.length)
         {
            return null;
         }
         return this.FGVG3BattleOrgs[param1];
      }
      
      public function GetGVG3BattleOrgByIdentifier(param1:uint) : TGVG3BattleOrg
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TGVG3BattleOrg = null;
         _loc3_ = this.FGVG3BattleOrgs.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FGVG3BattleOrgs[_loc2_];
            if(_loc4_.OrgID == param1)
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
         _loc1_ = int(this.FGVG3BattleOrgs.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FGVG3BattleOrgs.pop();
            _loc2_++;
         }
         this.FGVG3BattleOrgs.length = 0;
      }
   }
}

