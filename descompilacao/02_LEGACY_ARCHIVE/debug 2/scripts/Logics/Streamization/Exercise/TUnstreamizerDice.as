package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TAward;
   import Logics.Exercise.Dice.TDice;
   import Logics.Exercise.Dice.TDiceBox;
   import Logics.Exercise.Dice.TDiceLog;
   import Logics.Exercise.Dice.TDiceRank;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerDice extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerDice()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:Vector.<uint> = null;
         var _loc12_:TDice = null;
         var _loc13_:TDiceBox = null;
         var _loc14_:TDiceRank = null;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:TDiceLog = null;
         var _loc18_:TAward = null;
         var _loc19_:TFixedAward = null;
         var _loc20_:TBins = null;
         var _loc21_:TBins = null;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc24_:uint = 0;
         var _loc25_:TArticle = null;
         _loc12_ = param2 as TDice;
         _loc12_.Identify = param1.readUnsignedInt();
         _loc12_.BeginTime = param1.readUnsignedInt();
         _loc12_.EndTime = param1.readUnsignedInt();
         _loc6_ = int(param1.readUnsignedShort());
         _loc12_.DescList.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc12_.InitDescListNew();
         _loc12_.CurResult = param1.readUnsignedInt();
         _loc12_.WinCount = param1.readUnsignedInt();
         _loc6_ = int(param1.readUnsignedShort());
         _loc12_.FirstNumber.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.FirstNumber.push(param1.readUnsignedInt());
            _loc4_++;
         }
         _loc6_ = int(param1.readUnsignedShort());
         _loc12_.SecondNumber.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.SecondNumber.push(param1.readUnsignedInt());
            _loc4_++;
         }
         _loc12_.Life = param1.readUnsignedInt();
         _loc12_.DiceGold = param1.readUnsignedInt();
         _loc12_.CanBeWrong = param1.readUnsignedInt();
         _loc12_.WrongGold = param1.readUnsignedInt();
         _loc12_.WinPrice = param1.readUnsignedInt();
         _loc12_.BoxList.length = 0;
         _loc12_.RewardStatus.length = 0;
         _loc10_ = new Vector.<uint>();
         _loc11_ = new Vector.<uint>();
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc13_ = new TDiceBox();
            _loc13_.Identify = param1.readUnsignedInt();
            _loc13_.Color = param1.readUnsignedInt();
            _loc13_.NeedWinCount = param1.readUnsignedInt();
            _loc13_.Status = param1.readByte();
            _loc12_.RewardStatus.push(_loc13_.Status);
            _loc10_.length = 0;
            _loc10_.push(param1.readUnsignedInt());
            _loc9_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc10_);
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc8_ = _loc9_.GetInventoryByIndex(_loc5_);
               _loc8_.Quantity = _loc11_[_loc5_];
               _loc5_++;
            }
            _loc13_.Inventories = _loc9_;
            _loc12_.BoxList.push(_loc13_);
            _loc4_++;
         }
         _loc12_.RankList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc14_ = new TDiceRank();
            _loc14_.Identifier0 = param1.readUnsignedInt();
            _loc14_.Identifier1 = param1.readUnsignedInt();
            _loc14_.Name = TUtilityString.FetchUTF(param1);
            _loc14_.WinCount = param1.readUnsignedInt();
            _loc12_.RankList.push(_loc14_);
            _loc4_++;
         }
         if(!_loc12_.LoadLog)
         {
            _loc6_ = int(param1.readUnsignedShort());
            _loc10_ = new Vector.<uint>();
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc17_ = new TDiceLog();
               _loc17_.GetTime = param1.readUnsignedInt();
               _loc9_ = new TInventories();
               _loc10_.length = 0;
               _loc10_.push(param1.readUnsignedInt());
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc10_);
               _loc17_.Inventories = _loc9_;
               _loc12_.DiceLogList.push(_loc17_);
               _loc4_++;
            }
            _loc12_.LoadLog = true;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

