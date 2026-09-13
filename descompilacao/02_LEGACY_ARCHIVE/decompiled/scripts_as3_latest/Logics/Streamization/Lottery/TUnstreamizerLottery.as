package Logics.Streamization.Lottery
{
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Lottery.TLottery;
   import Logics.Lottery.TLotteryNews;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerLottery extends TUnstreamizer
   {
      
      public function TUnstreamizerLottery()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_ActivityData(param1,param2);
      }
      
      protected function UnstreamizationPerform_ActivityData(param1:ByteArray, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TLottery = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TLotteryNews = null;
         _loc5_ = param2 as TLottery;
         _loc5_.FreeExp = param1.readUnsignedInt();
         _loc5_.GoldExp = param1.readUnsignedInt();
         _loc5_.Point = param1.readUnsignedInt();
         _loc5_.NextTime = param1.readUnsignedInt();
         _loc5_.Stage = param1.readUnsignedInt();
         _loc5_.BeginTime = param1.readUnsignedInt();
         _loc5_.EndTime = param1.readUnsignedInt();
         _loc5_.VipLv = param1.readUnsignedInt();
         _loc5_.ActivityName = TUtilityString.FetchUTF(param1);
         _loc5_.ActivityDesc = TUtilityString.FetchUTF(param1);
         _loc5_.OnePrice = param1.readUnsignedInt();
         _loc5_.TenPrice = param1.readUnsignedInt();
         _loc5_.FiftyPrice = param1.readUnsignedInt();
         _loc5_.CDTime = param1.readUnsignedInt();
         _loc5_.GetPoint = param1.readUnsignedInt();
         _loc5_.GetProgess = param1.readUnsignedInt();
         _loc5_.CostProgress = param1.readUnsignedInt();
         _loc4_ = int(param1.readUnsignedShort());
         _loc5_.LotteryLog.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc8_ = new TLotteryNews();
            _loc8_.NewsType = param1.readUnsignedInt();
            _loc8_.Identify = param1.readUnsignedInt();
            _loc8_.GetTime = param1.readUnsignedInt();
            _loc5_.LotteryLog.push(_loc8_);
            _loc3_++;
         }
         _loc4_ = int(param1.readUnsignedShort());
         _loc5_.LotteryNews.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc8_ = new TLotteryNews();
            _loc8_.NewsType = param1.readUnsignedInt();
            _loc8_.Identify = param1.readUnsignedInt();
            _loc8_.PlayerNick = TUtilityString.FetchUTF(param1);
            _loc8_.Identifier0 = param1.readUnsignedInt();
            _loc8_.Identifier1 = param1.readUnsignedInt();
            _loc5_.LotteryNews.push(_loc8_);
            _loc3_++;
         }
         _loc4_ = int(param1.readUnsignedShort());
         _loc5_.HeroList.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_.HeroList[_loc3_] = param1.readUnsignedInt();
            _loc3_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

