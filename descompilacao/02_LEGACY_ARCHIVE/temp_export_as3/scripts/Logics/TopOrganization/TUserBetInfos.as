package Logics.TopOrganization
{
   public class TUserBetInfos
   {
      
      protected var FUserBetInfos:Vector.<TUserBetInfo>;
      
      public function TUserBetInfos()
      {
         super();
         this.FUserBetInfos = new Vector.<TUserBetInfo>();
      }
      
      public function get Count() : uint
      {
         return this.FUserBetInfos.length;
      }
      
      public function Add(param1:TUserBetInfo) : void
      {
         this.FUserBetInfos.push(param1);
      }
      
      public function GetUserBetInfoByIndex(param1:int) : TUserBetInfo
      {
         if(param1 < 0 || param1 >= this.FUserBetInfos.length)
         {
            return null;
         }
         return this.FUserBetInfos[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FUserBetInfos.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FUserBetInfos.pop();
            _loc2_++;
         }
         this.FUserBetInfos.length = 0;
      }
      
      public function CheckBetOrg(param1:uint) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TUserBetInfo = null;
         _loc3_ = this.FUserBetInfos.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FUserBetInfos[_loc2_];
            if(_loc4_.BetOrgID == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
   }
}

