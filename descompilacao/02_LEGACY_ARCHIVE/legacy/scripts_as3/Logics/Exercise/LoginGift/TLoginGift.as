package Logics.Exercise.LoginGift
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TLoginGift extends TBaseActivity
   {
      
      public var SignStatus:int;
      
      public var SignPrice:int;
      
      public var CurSign:int;
      
      public var MaxSign:int;
      
      public var Fund:TBaseBox;
      
      public var SignList:Vector.<TBaseBox>;
      
      public var Itemlist:Vector.<TBaseBox>;
      
      public function TLoginGift()
      {
         super();
         this.SignList = new Vector.<TBaseBox>();
         this.Itemlist = new Vector.<TBaseBox>();
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function CheckStatus() : Boolean
      {
         return false;
      }
   }
}

