package Logics.Organization.TreasureTree
{
   public class TUserWaterInfos
   {
      
      protected var FUserWaterInfos:Vector.<TUserWaterInfo>;
      
      public function TUserWaterInfos()
      {
         super();
         this.FUserWaterInfos = new Vector.<TUserWaterInfo>();
      }
      
      protected function SortByWater(param1:TUserWaterInfo, param2:TUserWaterInfo) : int
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc3_ = param1.NextWaterTime;
         _loc4_ = param2.NextWaterTime;
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         _loc5_ = uint(param1.IsOnline);
         _loc6_ = uint(param2.IsOnline);
         if(_loc5_ > _loc6_)
         {
            return -1;
         }
         if(_loc5_ < _loc6_)
         {
            return 1;
         }
         _loc7_ = param1.OrgDuty;
         _loc8_ = param2.OrgDuty;
         if(_loc7_ > _loc8_)
         {
            return -1;
         }
         if(_loc7_ < _loc8_)
         {
            return 1;
         }
         _loc9_ = param1.OrgMemberLevel;
         _loc10_ = param2.OrgMemberLevel;
         if(_loc9_ > _loc10_)
         {
            return -1;
         }
         if(_loc9_ < _loc10_)
         {
            return 1;
         }
         return 0;
      }
      
      public function get Count() : uint
      {
         return this.FUserWaterInfos.length;
      }
      
      public function Add(param1:TUserWaterInfo) : void
      {
         this.FUserWaterInfos.push(param1);
      }
      
      public function GetUserWaterByIndex(param1:int) : TUserWaterInfo
      {
         if(param1 < 0 || param1 >= this.FUserWaterInfos.length)
         {
            return null;
         }
         return this.FUserWaterInfos[param1];
      }
      
      public function GetUserWaterByIdentifier(param1:uint, param2:uint) : TUserWaterInfo
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TUserWaterInfo = null;
         _loc4_ = this.FUserWaterInfos.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FUserWaterInfos[_loc3_];
            if(_loc5_.OrgMemberID0 == param1 && _loc5_.OrgMemberID1 == param2)
            {
               return _loc5_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FUserWaterInfos.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FUserWaterInfos.pop();
            _loc2_++;
         }
         this.FUserWaterInfos.length = 0;
      }
      
      public function Sort() : void
      {
         this.FUserWaterInfos.sort(this.SortByWater);
      }
   }
}

