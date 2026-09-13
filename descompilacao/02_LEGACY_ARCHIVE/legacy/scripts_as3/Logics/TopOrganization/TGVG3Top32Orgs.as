package Logics.TopOrganization
{
   public class TGVG3Top32Orgs
   {
      
      protected var FGVG3Top32Orgs:Vector.<TGVG3Top32Org>;
      
      public function TGVG3Top32Orgs()
      {
         super();
         this.FGVG3Top32Orgs = new Vector.<TGVG3Top32Org>();
      }
      
      protected function SortByInitPos(param1:TGVG3Top32Org, param2:TGVG3Top32Org) : int
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc3_ = param1.InitPos;
         _loc4_ = param2.InitPos;
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
         return this.FGVG3Top32Orgs.length;
      }
      
      public function Add(param1:TGVG3Top32Org) : void
      {
         this.FGVG3Top32Orgs.push(param1);
      }
      
      public function GetGVG3Top32OrgByIndex(param1:int) : TGVG3Top32Org
      {
         if(param1 < 0 || param1 >= this.FGVG3Top32Orgs.length)
         {
            return null;
         }
         return this.FGVG3Top32Orgs[param1];
      }
      
      public function GetIndexByIndentifier(param1:uint) : int
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TGVG3Top32Org = null;
         _loc3_ = this.FGVG3Top32Orgs.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FGVG3Top32Orgs[_loc2_];
            if(_loc4_.OrgID == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function Sort() : void
      {
         this.FGVG3Top32Orgs.sort(this.SortByInitPos);
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FGVG3Top32Orgs.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FGVG3Top32Orgs.pop();
            _loc2_++;
         }
         this.FGVG3Top32Orgs.length = 0;
      }
   }
}

