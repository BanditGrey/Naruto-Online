package Logics.Exercise.FortuneCat
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TFortuneCat extends TBaseActivity
   {
      
      public static const GAME_STATUS_NOT_BEGIN:int = 0;
      
      public static const GAME_STATUS_NORMAL:int = 1;
      
      public static const GAME_STATUS_END:int = 2;
      
      protected var FGameStatus:int;
      
      protected var FCurCount:int;
      
      protected var FMaxCount:int;
      
      protected var FGoldList:Vector.<int>;
      
      protected var FAllLogs:Vector.<TBaseBox>;
      
      public var NeedGold:int;
      
      public var RechargeGold:int;
      
      public var NeedVip:int;
      
      public function TFortuneCat()
      {
         super();
         this.FGoldList = new Vector.<int>();
         this.FAllLogs = new Vector.<TBaseBox>();
      }
      
      public function get GameStatus() : int
      {
         return this.FGameStatus;
      }
      
      public function set GameStatus(param1:int) : void
      {
         this.FGameStatus = param1;
      }
      
      public function get GoldList() : Vector.<int>
      {
         return this.FGoldList;
      }
      
      public function set GoldList(param1:Vector.<int>) : void
      {
         this.FGoldList = param1;
      }
      
      public function get AllLogs() : Vector.<TBaseBox>
      {
         return this.FAllLogs;
      }
      
      public function set AllLogs(param1:Vector.<TBaseBox>) : void
      {
         this.FAllLogs = param1;
      }
      
      public function get CurCount() : int
      {
         return this.FCurCount;
      }
      
      public function set CurCount(param1:int) : void
      {
         this.FCurCount = param1;
      }
      
      public function get MaxCount() : int
      {
         return this.FMaxCount;
      }
      
      public function set MaxCount(param1:int) : void
      {
         this.FMaxCount = param1;
      }
      
      public function CheckStatus() : Boolean
      {
         return false;
      }
   }
}

