package Logics.GroupBattle
{
   public class TInviteShadows
   {
      
      protected var FInviteShadows:Vector.<TInviteShadow>;
      
      public function TInviteShadows()
      {
         super();
         this.FInviteShadows = new Vector.<TInviteShadow>();
      }
      
      public function get Count() : uint
      {
         return this.FInviteShadows.length;
      }
      
      public function GetInviteShadowByIndex(param1:int) : TInviteShadow
      {
         if(param1 >= this.FInviteShadows.length)
         {
            return null;
         }
         return this.FInviteShadows[param1];
      }
      
      public function GetInviteShadowByIdentifier(param1:uint, param2:uint) : TInviteShadow
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TInviteShadow = null;
         _loc4_ = this.FInviteShadows.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FInviteShadows[_loc3_];
            if(_loc5_.Identifier0 == param1 && _loc5_.Identifier1 == param2)
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
         var _loc3_:TInviteShadow = null;
         _loc1_ = int(this.FInviteShadows.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FInviteShadows.pop();
            _loc2_++;
         }
         this.FInviteShadows.length = 0;
      }
      
      public function Add(param1:TInviteShadow) : void
      {
         this.FInviteShadows.push(param1);
      }
      
      public function Delete(param1:int) : void
      {
         var _loc2_:TInviteShadow = null;
         _loc2_ = this.FInviteShadows[param1];
         this.FInviteShadows.splice(param1,1);
      }
   }
}

