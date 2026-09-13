package Logics.TheWorldTree
{
   import Processors.Game.Lobby.Married.TMarriedModel;
   import flash.utils.getTimer;
   
   public class TTheWorldTreeLogicData
   {
      
      protected var FTheWorldTreeCurLevel:uint;
      
      protected var FTheWorldTreeCurExp:uint;
      
      protected var FTheWorldTreeWateringCount:uint;
      
      protected var FTheWorldTreeRainCount:uint;
      
      protected var FCurPenetrateState:uint;
      
      protected var FOnlineAdditionExpSurplusTimes:uint;
      
      protected var FSeverCurTime:uint;
      
      protected var FOnlineAdditionExpSurplusTimesCopy:uint;
      
      protected var FCurOnlineTimeAllTime:uint;
      
      protected var FCurOfflineTimeAllTime:uint;
      
      protected var FPropsAdditionExpSurplusTimes:uint;
      
      protected var FPenetrateBeginTimes:uint;
      
      protected var FCurGetGiftedId:Vector.<uint>;
      
      protected var FTheWorldTreeDropOutGoods:Vector.<uint>;
      
      protected var FOnlineBuffPercent:int;
      
      protected var FKaguyaPowerPercent:Vector.<uint>;
      
      protected var FKaguyaPowerPercentCopy:uint;
      
      protected var FKaguyaPowerPercentCopy2:uint;
      
      protected var FVipLevelPercent:Vector.<uint>;
      
      protected var FVipLevelPercentCopy:uint;
      
      protected var FVipLevelPercentCopy2:uint;
      
      protected var FGoldBuyPercent:int;
      
      protected var FPropsDropOutPercent:int;
      
      protected var FBuyExpOneHourOrice:int;
      
      protected var FPropsDropOutOneHourOrice:int;
      
      protected var FWateringCountCost:Vector.<uint>;
      
      protected var FAddExpOneTime:uint;
      
      protected var FAddPowerOneTime:uint;
      
      protected var FRainCountCost:Vector.<uint>;
      
      protected var FWateringExp:int;
      
      protected var FJieSuanTimeCell:int;
      
      protected var FRainExp:int;
      
      protected var FOneTimesbabyCount:Vector.<uint>;
      
      protected var FEverydayRiskCount:Vector.<uint>;
      
      protected var FRiskThreeDifficultyCost:Vector.<uint>;
      
      protected var FCanWuAllTime:uint;
      
      protected var FOneTimesCanWuAllTime:uint;
      
      protected var FChuJiRewardVec:Vector.<uint>;
      
      protected var FGaoJiRewardVec:Vector.<uint>;
      
      protected var FDingJiRewardVec:Vector.<uint>;
      
      protected var FModeCountOne:uint;
      
      protected var FModeCountTwo:uint;
      
      protected var FModeCountThree:uint;
      
      protected var FCurProgressState:uint;
      
      protected var FCurChangeModeState:uint;
      
      protected var FMaoXianYouXiQuanName:String;
      
      protected var FSystemBid:uint;
      
      protected var FShieldingVec:Vector.<uint>;
      
      protected var FMaoXianJiLuVec:Vector.<uint>;
      
      protected var FWanOuYouXiQuanCount:uint;
      
      protected var FSureBtnIsClick:Boolean;
      
      protected var FWhatTheFuck:uint;
      
      protected var FClearingObject:Object;
      
      public function TTheWorldTreeLogicData()
      {
         super();
         this.FCurGetGiftedId = new Vector.<uint>();
         this.FClearingObject = new Object();
         this.FTheWorldTreeDropOutGoods = new Vector.<uint>();
         this.FShieldingVec = new Vector.<uint>();
         this.FMaoXianJiLuVec = new Vector.<uint>();
      }
      
      public function set TheWorldTreeCurLevel(param1:uint) : void
      {
         this.FTheWorldTreeCurLevel = param1;
      }
      
      public function get TheWorldTreeCurLevel() : uint
      {
         return this.FTheWorldTreeCurLevel;
      }
      
      public function set TheWorldTreeCurExp(param1:uint) : void
      {
         this.FTheWorldTreeCurExp = param1;
      }
      
      public function get TheWorldTreeCurExp() : uint
      {
         return this.FTheWorldTreeCurExp;
      }
      
      public function set TheWorldTreeWateringCount(param1:uint) : void
      {
         this.FTheWorldTreeWateringCount = param1;
      }
      
      public function get TheWorldTreeWateringCount() : uint
      {
         return this.FTheWorldTreeWateringCount;
      }
      
      public function set TheWorldTreeRainCount(param1:uint) : void
      {
         this.FTheWorldTreeRainCount = param1;
      }
      
      public function get TheWorldTreeRainCount() : uint
      {
         return this.FTheWorldTreeRainCount;
      }
      
      public function set CurPenetrateState(param1:uint) : void
      {
         this.FCurPenetrateState = param1;
      }
      
      public function get CurPenetrateState() : uint
      {
         return this.FCurPenetrateState;
      }
      
      public function set OnlineAdditionExpSurplusTimes(param1:uint) : void
      {
         this.FOnlineAdditionExpSurplusTimes = param1;
      }
      
      public function get OnlineAdditionExpSurplusTimes() : uint
      {
         return this.FOnlineAdditionExpSurplusTimes;
      }
      
      public function set SeverCurTime(param1:uint) : void
      {
         this.FSeverCurTime = param1;
         TMarriedModel.ClientTime = getTimer() / 1000;
         TMarriedModel.ServerTime = param1;
      }
      
      public function get SeverCurTime() : uint
      {
         return this.FSeverCurTime;
      }
      
      public function set OnlineAdditionExpSurplusTimesCopy(param1:uint) : void
      {
         this.FOnlineAdditionExpSurplusTimesCopy = param1;
      }
      
      public function get OnlineAdditionExpSurplusTimesCopy() : uint
      {
         return this.FOnlineAdditionExpSurplusTimesCopy;
      }
      
      public function set CurOnlineTimeAllTime(param1:uint) : void
      {
         this.FCurOnlineTimeAllTime = param1;
      }
      
      public function get CurOnlineTimeAllTime() : uint
      {
         return this.FCurOnlineTimeAllTime;
      }
      
      public function set CurOfflineTimeAllTime(param1:uint) : void
      {
         this.FCurOfflineTimeAllTime = param1;
      }
      
      public function get CurOfflineTimeAllTime() : uint
      {
         return this.FCurOfflineTimeAllTime;
      }
      
      public function set PropsAdditionExpSurplusTimes(param1:uint) : void
      {
         this.FPropsAdditionExpSurplusTimes = param1;
      }
      
      public function get PropsAdditionExpSurplusTimes() : uint
      {
         return this.FPropsAdditionExpSurplusTimes;
      }
      
      public function set PenetrateBeginTimes(param1:uint) : void
      {
         this.FPenetrateBeginTimes = param1;
      }
      
      public function get PenetrateBeginTimes() : uint
      {
         return this.FPenetrateBeginTimes;
      }
      
      public function get CurGetGiftedId() : Vector.<uint>
      {
         return this.FCurGetGiftedId;
      }
      
      public function set CurGetGiftedId(param1:Vector.<uint>) : void
      {
         this.FCurGetGiftedId = param1;
      }
      
      public function get TheWorldTreeDropOutGoods() : Vector.<uint>
      {
         return this.FTheWorldTreeDropOutGoods;
      }
      
      public function set TheWorldTreeDropOutGoods(param1:Vector.<uint>) : void
      {
         this.FTheWorldTreeDropOutGoods = param1;
      }
      
      public function get OnlineBuffPercent() : int
      {
         return this.FOnlineBuffPercent;
      }
      
      public function set OnlineBuffPercent(param1:int) : void
      {
         this.FOnlineBuffPercent = param1;
      }
      
      public function get KaguyaPowerPercent() : Vector.<uint>
      {
         return this.FKaguyaPowerPercent;
      }
      
      public function set KaguyaPowerPercent(param1:Vector.<uint>) : void
      {
         this.FKaguyaPowerPercent = param1;
      }
      
      public function get KaguyaPowerPercentCopy() : uint
      {
         return this.FKaguyaPowerPercentCopy;
      }
      
      public function set KaguyaPowerPercentCopy(param1:uint) : void
      {
         this.FKaguyaPowerPercentCopy = param1;
      }
      
      public function get KaguyaPowerPercentCopy2() : uint
      {
         return this.FKaguyaPowerPercentCopy2;
      }
      
      public function set KaguyaPowerPercentCopy2(param1:uint) : void
      {
         this.FKaguyaPowerPercentCopy2 = param1;
      }
      
      public function get VipLevelPercent() : Vector.<uint>
      {
         return this.FVipLevelPercent;
      }
      
      public function set VipLevelPercent(param1:Vector.<uint>) : void
      {
         this.FVipLevelPercent = param1;
      }
      
      public function get VipLevelPercentCopy() : uint
      {
         return this.FVipLevelPercentCopy;
      }
      
      public function set VipLevelPercentCopy(param1:uint) : void
      {
         this.FVipLevelPercentCopy = param1;
      }
      
      public function get VipLevelPercentCopy2() : uint
      {
         return this.FVipLevelPercentCopy2;
      }
      
      public function set VipLevelPercentCopy2(param1:uint) : void
      {
         this.FVipLevelPercentCopy2 = param1;
      }
      
      public function get GoldBuyPercent() : int
      {
         return this.FGoldBuyPercent;
      }
      
      public function set GoldBuyPercent(param1:int) : void
      {
         this.FGoldBuyPercent = param1;
      }
      
      public function get PropsDropOutPercent() : int
      {
         return this.FPropsDropOutPercent;
      }
      
      public function set PropsDropOutPercent(param1:int) : void
      {
         this.FPropsDropOutPercent = param1;
      }
      
      public function get BuyExpOneHourOrice() : int
      {
         return this.FBuyExpOneHourOrice;
      }
      
      public function set BuyExpOneHourOrice(param1:int) : void
      {
         this.FBuyExpOneHourOrice = param1;
      }
      
      public function get PropsDropOutOneHourOrice() : int
      {
         return this.FPropsDropOutOneHourOrice;
      }
      
      public function set PropsDropOutOneHourOrice(param1:int) : void
      {
         this.FPropsDropOutOneHourOrice = param1;
      }
      
      public function get WateringCountCost() : Vector.<uint>
      {
         return this.FWateringCountCost;
      }
      
      public function set WateringCountCost(param1:Vector.<uint>) : void
      {
         this.FWateringCountCost = param1;
      }
      
      public function get AddExpOneTime() : uint
      {
         return this.FAddExpOneTime;
      }
      
      public function set AddExpOneTime(param1:uint) : void
      {
         this.FAddExpOneTime = param1;
      }
      
      public function get AddPowerOneTime() : uint
      {
         return this.FAddPowerOneTime;
      }
      
      public function set AddPowerOneTime(param1:uint) : void
      {
         this.FAddPowerOneTime = param1;
      }
      
      public function get RainCountCost() : Vector.<uint>
      {
         return this.FRainCountCost;
      }
      
      public function set RainCountCost(param1:Vector.<uint>) : void
      {
         this.FRainCountCost = param1;
      }
      
      public function get WateringExp() : int
      {
         return this.FWateringExp;
      }
      
      public function set WateringExp(param1:int) : void
      {
         this.FWateringExp = param1;
      }
      
      public function get JieSuanTimeCell() : int
      {
         return this.FJieSuanTimeCell;
      }
      
      public function set JieSuanTimeCell(param1:int) : void
      {
         this.FJieSuanTimeCell = param1;
      }
      
      public function get RainExp() : int
      {
         return this.FRainExp;
      }
      
      public function set RainExp(param1:int) : void
      {
         this.FRainExp = param1;
      }
      
      public function get OneTimesbabyCount() : Vector.<uint>
      {
         return this.FOneTimesbabyCount;
      }
      
      public function set OneTimesbabyCount(param1:Vector.<uint>) : void
      {
         this.FOneTimesbabyCount = param1;
      }
      
      public function get EverydayRiskCount() : Vector.<uint>
      {
         return this.FEverydayRiskCount;
      }
      
      public function set EverydayRiskCount(param1:Vector.<uint>) : void
      {
         this.FEverydayRiskCount = param1;
      }
      
      public function get RiskThreeDifficultyCost() : Vector.<uint>
      {
         return this.FRiskThreeDifficultyCost;
      }
      
      public function set RiskThreeDifficultyCost(param1:Vector.<uint>) : void
      {
         this.FRiskThreeDifficultyCost = param1;
      }
      
      public function set CanWuAllTime(param1:uint) : void
      {
         this.FCanWuAllTime = param1;
      }
      
      public function get CanWuAllTime() : uint
      {
         return this.FCanWuAllTime;
      }
      
      public function set OneTimesCanWuAllTime(param1:uint) : void
      {
         this.FOneTimesCanWuAllTime = param1;
      }
      
      public function get OneTimesCanWuAllTime() : uint
      {
         return this.FOneTimesCanWuAllTime;
      }
      
      public function get ChuJiRewardVec() : Vector.<uint>
      {
         return this.FChuJiRewardVec;
      }
      
      public function set ChuJiRewardVec(param1:Vector.<uint>) : void
      {
         this.FChuJiRewardVec = param1;
      }
      
      public function get GaoJiRewardVec() : Vector.<uint>
      {
         return this.FGaoJiRewardVec;
      }
      
      public function set GaoJiRewardVec(param1:Vector.<uint>) : void
      {
         this.FGaoJiRewardVec = param1;
      }
      
      public function get DingJiRewardVec() : Vector.<uint>
      {
         return this.FDingJiRewardVec;
      }
      
      public function set DingJiRewardVec(param1:Vector.<uint>) : void
      {
         this.FDingJiRewardVec = param1;
      }
      
      public function set ModeCountOne(param1:uint) : void
      {
         this.FModeCountOne = param1;
      }
      
      public function get ModeCountOne() : uint
      {
         return this.FModeCountOne;
      }
      
      public function set ModeCountTwo(param1:uint) : void
      {
         this.FModeCountTwo = param1;
      }
      
      public function get ModeCountTwo() : uint
      {
         return this.FModeCountTwo;
      }
      
      public function set ModeCountThree(param1:uint) : void
      {
         this.FModeCountThree = param1;
      }
      
      public function get ModeCountThree() : uint
      {
         return this.FModeCountThree;
      }
      
      public function set CurProgressState(param1:uint) : void
      {
         this.FCurProgressState = param1;
      }
      
      public function get CurProgressState() : uint
      {
         return this.FCurProgressState;
      }
      
      public function set CurChangeModeState(param1:uint) : void
      {
         this.FCurChangeModeState = param1;
      }
      
      public function get CurChangeModeState() : uint
      {
         return this.FCurChangeModeState;
      }
      
      public function set MaoXianYouXiQuanName(param1:String) : void
      {
         this.FMaoXianYouXiQuanName = param1;
      }
      
      public function get MaoXianYouXiQuanName() : String
      {
         return this.FMaoXianYouXiQuanName;
      }
      
      public function set SystemBid(param1:uint) : void
      {
         this.FSystemBid = param1;
      }
      
      public function get SystemBid() : uint
      {
         return this.FSystemBid;
      }
      
      public function get ShieldingVec() : Vector.<uint>
      {
         return this.FShieldingVec;
      }
      
      public function get MaoXianJiLuVec() : Vector.<uint>
      {
         return this.FMaoXianJiLuVec;
      }
      
      public function set WanOuYouXiQuanCount(param1:uint) : void
      {
         this.FWanOuYouXiQuanCount = param1;
      }
      
      public function get WanOuYouXiQuanCount() : uint
      {
         return this.FWanOuYouXiQuanCount;
      }
      
      public function set SureBtnIsClick(param1:Boolean) : void
      {
         this.FSureBtnIsClick = param1;
      }
      
      public function get SureBtnIsClick() : Boolean
      {
         return this.FSureBtnIsClick;
      }
      
      public function set WhatTheFuck(param1:uint) : void
      {
         this.FWhatTheFuck = param1;
      }
      
      public function get WhatTheFuck() : uint
      {
         return this.FWhatTheFuck;
      }
      
      public function get ClearingObject() : Object
      {
         return this.FClearingObject;
      }
   }
}

