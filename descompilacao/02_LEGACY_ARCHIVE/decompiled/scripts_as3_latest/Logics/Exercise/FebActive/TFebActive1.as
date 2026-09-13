package Logics.Exercise.FebActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TFebActive1 extends TBaseActivity
   {
      
      public static const TYPE_CONSUME:int = 0;
      
      public static const TYPE_RECHARGE:int = 1;
      
      public var LoginDay:int;
      
      public var DailyGift:TBaseBox;
      
      public var DailyBox:Vector.<TBaseBox>;
      
      public var LoginGift:Vector.<TBaseBox>;
      
      public var SpecialGift:Vector.<TBaseBox>;
      
      public var SpecialItem:Vector.<TBaseBox>;
      
      public function TFebActive1()
      {
         super();
         this.DailyBox = new Vector.<TBaseBox>();
         this.LoginGift = new Vector.<TBaseBox>();
         this.SpecialGift = new Vector.<TBaseBox>();
         this.SpecialItem = new Vector.<TBaseBox>();
      }
      
      public function ChangeStatus() : void
      {
      }
   }
}

