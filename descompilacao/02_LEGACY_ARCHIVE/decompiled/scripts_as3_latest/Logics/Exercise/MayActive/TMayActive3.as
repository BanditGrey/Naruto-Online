package Logics.Exercise.MayActive
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TMayActive3 extends TBaseActivity
   {
      
      public static const SOLDIER_COUNT:int = 3;
      
      protected var FRefreshTime:int;
      
      protected var FRefreshCost:int;
      
      protected var FMyPower:int;
      
      protected var FAPValue:int;
      
      protected var FMPValue:int;
      
      protected var FMaxAP:int;
      
      protected var FMaxMP:int;
      
      protected var FAddAPCost:int;
      
      protected var FAddMPCost:int;
      
      protected var FKillCount:int;
      
      protected var FScore:int;
      
      protected var FBossAppearTime:int;
      
      protected var FBossIsAppear:int;
      
      protected var FRewardRound:int;
      
      protected var FCurMonster:TBaseBox;
      
      protected var FCurBoss:TBaseBox;
      
      protected var FMySoldier:TBaseBox;
      
      protected var FSoldierList:Vector.<TBaseBox>;
      
      protected var FGiftList:Vector.<TBaseBox>;
      
      protected var FSpecialReward:Vector.<TBaseBox>;
      
      protected var FKillReward:Vector.<TBaseBox>;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FSoldierIndex:Vector.<int>;
      
      protected var FMonsterDesc:Vector.<String>;
      
      public var MonsterDescNew:Vector.<String>;
      
      public function TMayActive3()
      {
         super();
         this.FSoldierList = new Vector.<TBaseBox>();
         this.FGiftList = new Vector.<TBaseBox>();
         this.FSpecialReward = new Vector.<TBaseBox>();
         this.FKillReward = new Vector.<TBaseBox>();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FSoldierIndex = new Vector.<int>(SOLDIER_COUNT);
         this.FMonsterDesc = new Vector.<String>();
         this.MonsterDescNew = new Vector.<String>();
         this.FCurBoss = new TBaseBox();
      }
      
      public function get MyPower() : int
      {
         return this.FMyPower;
      }
      
      public function set MyPower(param1:int) : void
      {
         this.FMyPower = param1;
      }
      
      public function get APValue() : int
      {
         return this.FAPValue;
      }
      
      public function set APValue(param1:int) : void
      {
         this.FAPValue = param1;
      }
      
      public function get MPValue() : int
      {
         return this.FMPValue;
      }
      
      public function set MPValue(param1:int) : void
      {
         this.FMPValue = param1;
      }
      
      public function get AddAPCost() : int
      {
         return this.FAddAPCost;
      }
      
      public function set AddAPCost(param1:int) : void
      {
         this.FAddAPCost = param1;
      }
      
      public function get AddMPCost() : int
      {
         return this.FAddMPCost;
      }
      
      public function set AddMPCost(param1:int) : void
      {
         this.FAddMPCost = param1;
      }
      
      public function get KillCount() : int
      {
         return this.FKillCount;
      }
      
      public function set KillCount(param1:int) : void
      {
         this.FKillCount = param1;
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get CurMonster() : TBaseBox
      {
         return this.FCurMonster;
      }
      
      public function set CurMonster(param1:TBaseBox) : void
      {
         this.FCurMonster = param1;
      }
      
      public function get CurBoss() : TBaseBox
      {
         return this.FCurBoss;
      }
      
      public function set CurBoss(param1:TBaseBox) : void
      {
         this.FCurBoss = param1;
      }
      
      public function get MySoldier() : TBaseBox
      {
         return this.FMySoldier;
      }
      
      public function set MySoldier(param1:TBaseBox) : void
      {
         this.FMySoldier = param1;
      }
      
      public function get SoldierList() : Vector.<TBaseBox>
      {
         return this.FSoldierList;
      }
      
      public function set SoldierList(param1:Vector.<TBaseBox>) : void
      {
         this.FSoldierList = param1;
      }
      
      public function get GiftList() : Vector.<TBaseBox>
      {
         return this.FGiftList;
      }
      
      public function set GiftList(param1:Vector.<TBaseBox>) : void
      {
         this.FGiftList = param1;
      }
      
      public function get SpecialReward() : Vector.<TBaseBox>
      {
         return this.FSpecialReward;
      }
      
      public function set SpecialReward(param1:Vector.<TBaseBox>) : void
      {
         this.FSpecialReward = param1;
      }
      
      public function get KillReward() : Vector.<TBaseBox>
      {
         return this.FKillReward;
      }
      
      public function set KillReward(param1:Vector.<TBaseBox>) : void
      {
         this.FKillReward = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get RefreshTime() : int
      {
         return this.FRefreshTime;
      }
      
      public function set RefreshTime(param1:int) : void
      {
         this.FRefreshTime = param1;
      }
      
      public function get RefreshCost() : int
      {
         return this.FRefreshCost;
      }
      
      public function set RefreshCost(param1:int) : void
      {
         this.FRefreshCost = param1;
      }
      
      public function get SoldierIndex() : Vector.<int>
      {
         return this.FSoldierIndex;
      }
      
      public function set SoldierIndex(param1:Vector.<int>) : void
      {
         this.FSoldierIndex = param1;
      }
      
      public function get MaxAP() : int
      {
         return this.FMaxAP;
      }
      
      public function set MaxAP(param1:int) : void
      {
         this.FMaxAP = param1;
      }
      
      public function get MaxMP() : int
      {
         return this.FMaxMP;
      }
      
      public function set MaxMP(param1:int) : void
      {
         this.FMaxMP = param1;
      }
      
      public function get BossAppearTime() : int
      {
         return this.FBossAppearTime;
      }
      
      public function set BossAppearTime(param1:int) : void
      {
         this.FBossAppearTime = param1;
      }
      
      public function get BossIsAppear() : int
      {
         return this.FBossIsAppear;
      }
      
      public function set BossIsAppear(param1:int) : void
      {
         this.FBossIsAppear = param1;
      }
      
      public function get RewardRound() : int
      {
         return this.FRewardRound;
      }
      
      public function set RewardRound(param1:int) : void
      {
         this.FRewardRound = param1;
      }
      
      public function get MonsterDesc() : Vector.<String>
      {
         return this.FMonsterDesc;
      }
      
      public function set MonsterDesc(param1:Vector.<String>) : void
      {
         this.FMonsterDesc = param1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FSpecialReward[0].Status == TBaseActivity.STATUS_CANNOTGET && FRankPoint >= this.FSpecialReward[0].Price)
         {
            this.FSpecialReward[0].Status = TBaseActivity.STATUS_CANGET;
         }
      }
      
      public function InitMonsterDescNew() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         if(this.FMonsterDesc.length > 0 && Boolean(this.FMonsterDesc[0]))
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.MonsterDescNew.length)
         {
            _loc2_ = int(parseInt(this.MonsterDescNew[_loc1_]));
            if(TBaseActivity.IsRealNumber(this.MonsterDescNew[_loc1_]) && !isNaN(_loc2_) && _loc2_ > 0)
            {
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
               if(_loc4_)
               {
                  _loc3_ = _loc4_.Desc;
                  _loc3_ = _loc3_.split("&lt;").join("<");
                  _loc3_ = _loc3_.split("&gt;").join(">");
                  this.FMonsterDesc[_loc1_] = _loc3_;
               }
               else
               {
                  this.FMonsterDesc[_loc1_] = this.MonsterDescNew[_loc1_];
               }
            }
            else
            {
               this.FMonsterDesc[_loc1_] = this.MonsterDescNew[_loc1_];
            }
            _loc1_++;
         }
      }
   }
}

