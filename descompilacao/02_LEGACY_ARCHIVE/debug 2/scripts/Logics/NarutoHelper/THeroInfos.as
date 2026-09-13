package Logics.NarutoHelper
{
   import Logics.DatebaseVO.VO.TNinjiaRecommend;
   
   public class THeroInfos
   {
      
      protected var FHeroInfos:Vector.<TNinjiaRecommend>;
      
      public function THeroInfos()
      {
         super();
         this.FHeroInfos = new Vector.<TNinjiaRecommend>();
      }
      
      public function get Count() : int
      {
         return this.FHeroInfos.length;
      }
      
      public function GetHeroInfoByIndex(param1:int) : TNinjiaRecommend
      {
         return this.FHeroInfos[param1];
      }
      
      public function Add(param1:TNinjiaRecommend) : void
      {
         this.FHeroInfos.push(param1);
      }
   }
}

