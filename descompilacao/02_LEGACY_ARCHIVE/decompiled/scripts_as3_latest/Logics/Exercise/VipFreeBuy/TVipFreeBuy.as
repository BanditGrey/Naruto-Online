package Logics.Exercise.VipFreeBuy
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.VipShop.TVipBox;
   
   public class TVipFreeBuy extends TBaseActivity
   {
      
      public static const BOX_COUNT:int = 10;
      
      protected var FGetBoxDay:Vector.<int>;
      
      protected var FVipBoxList:Vector.<TVipBox>;
      
      public function TVipFreeBuy()
      {
         super();
         FNeedConfig = true;
         this.FVipBoxList = new Vector.<TVipBox>(BOX_COUNT);
         this.FGetBoxDay = new Vector.<int>(BOX_COUNT);
      }
      
      public function get VipBoxList() : Vector.<TVipBox>
      {
         return this.FVipBoxList;
      }
      
      public function set VipBoxList(param1:Vector.<TVipBox>) : void
      {
         this.FVipBoxList = param1;
      }
      
      public function get GetBoxDay() : Vector.<int>
      {
         return this.FGetBoxDay;
      }
      
      public function set GetBoxDay(param1:Vector.<int>) : void
      {
         this.FGetBoxDay = param1;
      }
      
      public function GetDateByIndex(param1:int) : TVipBox
      {
         var _loc2_:int = 0;
         if(param1 < this.FVipBoxList.length)
         {
            return this.FVipBoxList[param1];
         }
         return null;
      }
      
      public function GetDateByIdentify(param1:int) : TVipBox
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.FVipBoxList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FVipBoxList[_loc2_].Identify == param1)
            {
               return this.FVipBoxList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
   }
}

