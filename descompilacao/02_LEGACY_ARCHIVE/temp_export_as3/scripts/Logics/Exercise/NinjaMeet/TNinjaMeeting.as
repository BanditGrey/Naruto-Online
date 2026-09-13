package Logics.Exercise.NinjaMeet
{
   import Logics.Characters.TCharacter;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   
   public class TNinjaMeeting extends TBaseActivity
   {
      
      public static const STATUS_ISGOT:int = 2;
      
      protected var FHeroList:Vector.<TBaseBox>;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FScore:int;
      
      protected var FMoney:int;
      
      protected var FRate:int;
      
      public function TNinjaMeeting()
      {
         super();
         this.FHeroList = new Vector.<TBaseBox>();
         this.FBoxList = new Vector.<TBaseBox>();
      }
      
      public function get HeroList() : Vector.<TBaseBox>
      {
         return this.FHeroList;
      }
      
      public function set HeroList(param1:Vector.<TBaseBox>) : void
      {
         this.FHeroList = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get Money() : int
      {
         return this.FMoney;
      }
      
      public function set Money(param1:int) : void
      {
         this.FMoney = param1;
      }
      
      public function get Rate() : int
      {
         return this.FRate;
      }
      
      public function set Rate(param1:int) : void
      {
         this.FRate = param1;
      }
      
      public function IsMoneyEnough(param1:int) : Boolean
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(this.FScore + _loc2_.CreditGold >= param1)
         {
            return true;
         }
         return false;
      }
   }
}

