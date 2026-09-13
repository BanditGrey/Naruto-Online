package Logics.Exercise.SpringFestival
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TSpringFestivalCollect extends TBaseActivity
   {
      
      protected var FScore:int;
      
      protected var FCount:int;
      
      protected var FSweetList:Vector.<TBaseBox>;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FHeroList:Vector.<TBaseBox>;
      
      public function TSpringFestivalCollect()
      {
         super();
         this.FSweetList = new Vector.<TBaseBox>();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FHeroList = new Vector.<TBaseBox>();
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get SweetList() : Vector.<TBaseBox>
      {
         return this.FSweetList;
      }
      
      public function set SweetList(param1:Vector.<TBaseBox>) : void
      {
         this.FSweetList = param1;
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get Count() : int
      {
         return this.FCount;
      }
      
      public function set Count(param1:int) : void
      {
         this.FCount = param1;
      }
      
      public function get HeroList() : Vector.<TBaseBox>
      {
         return this.FHeroList;
      }
      
      public function set HeroList(param1:Vector.<TBaseBox>) : void
      {
         this.FHeroList = param1;
      }
      
      public function ChangeStatus() : void
      {
         if(this.FHeroList[0].Status == TBaseActivity.STATUS_CANNOTGET && this.FScore >= this.FHeroList[0].Price)
         {
            this.FHeroList[0].Status = TBaseActivity.STATUS_CANGET;
         }
      }
   }
}

