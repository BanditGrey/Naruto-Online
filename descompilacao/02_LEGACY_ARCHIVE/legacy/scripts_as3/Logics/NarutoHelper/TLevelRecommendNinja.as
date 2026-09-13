package Logics.NarutoHelper
{
   public class TLevelRecommendNinja
   {
      
      protected var FLevelRecommend:uint;
      
      protected var FHeroInfos:THeroInfos;
      
      public function TLevelRecommendNinja()
      {
         super();
         this.FHeroInfos = new THeroInfos();
      }
      
      public function get LevelRecommend() : uint
      {
         return this.FLevelRecommend;
      }
      
      public function set LevelRecommend(param1:uint) : void
      {
         this.FLevelRecommend = param1;
      }
      
      public function get HeroInfos() : THeroInfos
      {
         return this.FHeroInfos;
      }
      
      public function set HeroInfos(param1:THeroInfos) : void
      {
         this.FHeroInfos = param1;
      }
   }
}

