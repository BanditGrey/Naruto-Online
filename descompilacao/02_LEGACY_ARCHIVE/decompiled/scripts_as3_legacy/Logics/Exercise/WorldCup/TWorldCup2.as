package Logics.Exercise.WorldCup
{
   import Logics.Exercise.TBaseActivity;
   
   public class TWorldCup2 extends TBaseActivity
   {
      
      public static const TYPE_WIN:int = 3;
      
      public static const TYPE_DRAW:int = 1;
      
      public static const TYPE_DEFEAT:int = 0;
      
      public var BetInfo:Vector.<Object>;
      
      public function TWorldCup2()
      {
         super();
         this.BetInfo = new Vector.<Object>();
      }
      
      public function ChangeStatus() : void
      {
      }
   }
}

