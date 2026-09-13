package Logics.Mentorship
{
   import Logics.Mentorship.Elements.TArrestPlayer;
   
   public class TArrest
   {
      
      protected var FArrestList:Vector.<TArrestPlayer>;
      
      public function TArrest()
      {
         super();
         this.FArrestList = new Vector.<TArrestPlayer>();
      }
      
      protected function SortBuLevel(param1:TArrestPlayer, param2:TArrestPlayer) : int
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc3_ = param1.Level;
         _loc4_ = param2.Level;
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
      
      public function get ArrestList() : Vector.<TArrestPlayer>
      {
         return this.FArrestList;
      }
      
      public function set ArrestList(param1:Vector.<TArrestPlayer>) : void
      {
         this.FArrestList = param1;
      }
      
      public function Sort() : void
      {
         this.FArrestList.sort(this.SortBuLevel);
      }
   }
}

