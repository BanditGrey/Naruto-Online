package Logics.Exercise.VipShop
{
   import Logics.Exercise.TBaseActivity;
   
   public class TVipShop extends TBaseActivity
   {
      
      protected var FBoxList:Vector.<TVipBox>;
      
      protected var FVipCount:int;
      
      public function TVipShop()
      {
         super();
         this.FBoxList = new Vector.<TVipBox>();
      }
      
      public function get BoxList() : Vector.<TVipBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TVipBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get VipCount() : int
      {
         return this.FVipCount;
      }
      
      public function set VipCount(param1:int) : void
      {
         this.FVipCount = param1;
      }
      
      public function GetBoxByIdentify(param1:int) : TVipBox
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.FBoxList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FBoxList[_loc2_].Identify == param1)
            {
               return this.FBoxList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function GetBoxByIndex(param1:int) : TVipBox
      {
         var _loc2_:int = 0;
         if(param1 < this.FBoxList.length)
         {
            return this.FBoxList[param1];
         }
         return null;
      }
   }
}

