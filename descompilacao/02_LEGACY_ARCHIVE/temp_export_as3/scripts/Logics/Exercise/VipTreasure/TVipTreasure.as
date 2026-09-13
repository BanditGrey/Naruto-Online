package Logics.Exercise.VipTreasure
{
   import Logics.Characters.TCharacter;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   
   public class TVipTreasure extends TBaseActivity
   {
      
      protected static const BOX_COUNT:int = 10;
      
      protected static const REWARD_COUNT:int = 4;
      
      protected var FRequirementNextExp:int;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FRewardList:Vector.<TBaseBox>;
      
      public function TVipTreasure()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>(BOX_COUNT);
         this.FRewardList = new Vector.<TBaseBox>(REWARD_COUNT);
      }
      
      public function get RequirementNextExp() : int
      {
         return this.FRequirementNextExp;
      }
      
      public function set RequirementNextExp(param1:int) : void
      {
         this.FRequirementNextExp = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get RewardList() : Vector.<TBaseBox>
      {
         return this.FRewardList;
      }
      
      public function set RewardList(param1:Vector.<TBaseBox>) : void
      {
         this.FRewardList = param1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(this.FBoxList[0].Status == TBaseActivity.STATUS_CANNOTGET && _loc2_.VipLevel >= 1)
         {
            this.FBoxList[0].Status = TBaseActivity.STATUS_CANGET;
            return;
         }
         _loc1_ = 1;
         while(_loc1_ < this.FBoxList.length)
         {
            if(this.FBoxList[_loc1_ - 1].Status == TBaseActivity.STATUS_GETED && this.FBoxList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && _loc2_.VipLevel >= _loc1_ + 1)
            {
               this.FBoxList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
               return;
            }
            _loc1_++;
         }
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         this.ChangeStatus();
         _loc1_ = 0;
         while(_loc1_ < this.FBoxList.length)
         {
            if(this.FBoxList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FRewardList.length)
         {
            if(this.FRewardList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
   }
}

