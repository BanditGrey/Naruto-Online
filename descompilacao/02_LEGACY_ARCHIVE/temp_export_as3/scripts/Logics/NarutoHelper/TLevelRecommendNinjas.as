package Logics.NarutoHelper
{
   public class TLevelRecommendNinjas
   {
      
      protected var FLevelRecommendNinjas:Vector.<TLevelRecommendNinja>;
      
      public function TLevelRecommendNinjas()
      {
         super();
         this.FLevelRecommendNinjas = new Vector.<TLevelRecommendNinja>();
      }
      
      protected function SortByLevel(param1:TLevelRecommendNinja, param2:TLevelRecommendNinja) : int
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc3_ = param1.LevelRecommend;
         _loc4_ = param2.LevelRecommend;
         if(_loc3_ > _loc4_)
         {
            return -1;
         }
         if(_loc3_ < _loc4_)
         {
            return 1;
         }
         return 0;
      }
      
      public function get Count() : int
      {
         return this.FLevelRecommendNinjas.length;
      }
      
      public function GetLevelRecommendNinjaByIndex(param1:int) : TLevelRecommendNinja
      {
         return this.FLevelRecommendNinjas[param1];
      }
      
      public function GetLevelRecommendNinjaByLevel(param1:int) : TLevelRecommendNinja
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TLevelRecommendNinja = null;
         _loc3_ = this.FLevelRecommendNinjas.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FLevelRecommendNinjas[_loc2_];
            if(_loc4_.LevelRecommend == param1)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function Add(param1:TLevelRecommendNinja) : void
      {
         this.FLevelRecommendNinjas.push(param1);
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = this.FLevelRecommendNinjas.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FLevelRecommendNinjas.pop();
            _loc1_++;
         }
         this.FLevelRecommendNinjas.length = 0;
      }
      
      public function Sort() : void
      {
         this.FLevelRecommendNinjas.sort(this.SortByLevel);
      }
   }
}

