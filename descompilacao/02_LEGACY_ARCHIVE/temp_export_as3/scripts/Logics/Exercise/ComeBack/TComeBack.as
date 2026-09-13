package Logics.Exercise.ComeBack
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TComeBack extends TBaseActivity
   {
      
      public static const TYPE_NEW_PLAYER_IN_NEW_SERVER:int = 1;
      
      public static const TYPE_OLD_PLAYER_IN_OLD_SERVER:int = 2;
      
      public static const TYPE_OLD_PLAYER_IN_NEW_SERVER:int = 3;
      
      public static const TYPE_NONE:int = 4;
      
      protected var FIsOld:int;
      
      protected var FIsNewServer:int;
      
      protected var FServerID:String;
      
      protected var FActivityBeginTime:int;
      
      protected var FActivityEndTime:int;
      
      protected var FOldAward:TBaseBox;
      
      protected var FNewAward:TBaseBox;
      
      protected var FCDKAward:TBaseBox;
      
      protected var FCDKLotteryAward:TBaseBox;
      
      protected var FLeftDays:int;
      
      protected var FBackAwardList:Object;
      
      protected var FBackAwardStatus:int;
      
      protected var FTotalRechargeGold:int;
      
      protected var FRechargeGold:int;
      
      protected var FRewardGold:int;
      
      protected var FRate:int;
      
      protected var FSaleBox:Vector.<TBaseBox>;
      
      public function TComeBack()
      {
         super();
         this.FSaleBox = new Vector.<TBaseBox>();
      }
      
      public function get IsOld() : int
      {
         return this.FIsOld;
      }
      
      public function set IsOld(param1:int) : void
      {
         this.FIsOld = param1;
      }
      
      public function get IsNewServer() : int
      {
         return this.FIsNewServer;
      }
      
      public function set IsNewServer(param1:int) : void
      {
         this.FIsNewServer = param1;
      }
      
      public function get ServerID() : String
      {
         return this.FServerID;
      }
      
      public function set ServerID(param1:String) : void
      {
         this.FServerID = param1;
      }
      
      public function get CDKAward() : TBaseBox
      {
         return this.FCDKAward;
      }
      
      public function set CDKAward(param1:TBaseBox) : void
      {
         this.FCDKAward = param1;
      }
      
      public function get CDKLotteryAward() : TBaseBox
      {
         return this.FCDKLotteryAward;
      }
      
      public function set CDKLotteryAward(param1:TBaseBox) : void
      {
         this.FCDKLotteryAward = param1;
      }
      
      public function get BackAwardList() : Object
      {
         return this.FBackAwardList;
      }
      
      public function set BackAwardList(param1:Object) : void
      {
         this.FBackAwardList = param1;
      }
      
      public function get BackAwardStatus() : int
      {
         return this.FBackAwardStatus;
      }
      
      public function set BackAwardStatus(param1:int) : void
      {
         this.FBackAwardStatus = param1;
      }
      
      public function get RechargeGold() : int
      {
         return this.FRechargeGold;
      }
      
      public function set RechargeGold(param1:int) : void
      {
         this.FRechargeGold = param1;
      }
      
      public function get RewardGold() : int
      {
         return this.FRewardGold;
      }
      
      public function set RewardGold(param1:int) : void
      {
         this.FRewardGold = param1;
      }
      
      public function get Rate() : int
      {
         return this.FRate;
      }
      
      public function set Rate(param1:int) : void
      {
         this.FRate = param1;
      }
      
      public function get OldAward() : TBaseBox
      {
         return this.FOldAward;
      }
      
      public function set OldAward(param1:TBaseBox) : void
      {
         this.FOldAward = param1;
      }
      
      public function get NewAward() : TBaseBox
      {
         return this.FNewAward;
      }
      
      public function set NewAward(param1:TBaseBox) : void
      {
         this.FNewAward = param1;
      }
      
      public function get LeftDays() : int
      {
         return this.FLeftDays;
      }
      
      public function set LeftDays(param1:int) : void
      {
         this.FLeftDays = param1;
      }
      
      public function get SaleBox() : Vector.<TBaseBox>
      {
         return this.FSaleBox;
      }
      
      public function set SaleBox(param1:Vector.<TBaseBox>) : void
      {
         this.FSaleBox = param1;
      }
      
      public function get ActivityBeginTime() : int
      {
         return this.FActivityBeginTime;
      }
      
      public function set ActivityBeginTime(param1:int) : void
      {
         this.FActivityBeginTime = param1;
      }
      
      public function get ActivityEndTime() : int
      {
         return this.FActivityEndTime;
      }
      
      public function set ActivityEndTime(param1:int) : void
      {
         this.FActivityEndTime = param1;
      }
      
      public function CheckStatus() : Boolean
      {
         if(Boolean(this.FNewAward) && Boolean(this.FNewAward.Status == TBaseActivity.STATUS_CANGET) || Boolean(this.FOldAward) && Boolean(this.FOldAward.Status == TBaseActivity.STATUS_CANGET))
         {
            return true;
         }
         if(Boolean(this.FCDKLotteryAward) && this.FCDKLotteryAward.Status >= 1)
         {
            return true;
         }
         if(this.FBackAwardStatus >= 1 || this.FRewardGold > 0)
         {
            return true;
         }
         return false;
      }
   }
}

