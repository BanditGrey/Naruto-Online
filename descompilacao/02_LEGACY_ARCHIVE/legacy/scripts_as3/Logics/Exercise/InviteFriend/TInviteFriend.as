package Logics.Exercise.InviteFriend
{
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TInviteFriend extends TBaseActivity
   {
      
      protected var FFeedBoxStatus:int;
      
      protected var FInviteBoxs:Vector.<TBaseBox>;
      
      protected var FCurIndex:int;
      
      protected var FTotalInvite:int;
      
      protected var FInviteList:Vector.<TConsumeRankInfo>;
      
      public function TInviteFriend()
      {
         super();
         this.FInviteBoxs = new Vector.<TBaseBox>();
         this.FInviteList = new Vector.<TConsumeRankInfo>();
      }
      
      public function get FeedBoxStatus() : int
      {
         return this.FFeedBoxStatus;
      }
      
      public function set FeedBoxStatus(param1:int) : void
      {
         this.FFeedBoxStatus = param1;
      }
      
      public function get InviteBoxs() : Vector.<TBaseBox>
      {
         return this.FInviteBoxs;
      }
      
      public function set InviteBoxs(param1:Vector.<TBaseBox>) : void
      {
         this.FInviteBoxs = param1;
      }
      
      public function get CurIndex() : int
      {
         return this.FCurIndex;
      }
      
      public function set CurIndex(param1:int) : void
      {
         this.FCurIndex = param1;
      }
      
      public function get InviteList() : Vector.<TConsumeRankInfo>
      {
         return this.FInviteList;
      }
      
      public function set InviteList(param1:Vector.<TConsumeRankInfo>) : void
      {
         this.FInviteList = param1;
      }
      
      public function get TotalInvite() : int
      {
         return this.FTotalInvite;
      }
      
      public function set TotalInvite(param1:int) : void
      {
         this.FTotalInvite = param1;
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.FFeedBoxStatus != TBaseActivity.STATUS_GETED)
         {
            return true;
         }
         _loc3_ = int(this.FInviteBoxs.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FInviteBoxs[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
   }
}

