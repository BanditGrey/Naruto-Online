package Logics.Organization.TreasureTree
{
   public class TOperatingShowInfos
   {
      
      protected var FOperatingShowInfos:Vector.<TOperatingShowInfo>;
      
      public function TOperatingShowInfos()
      {
         super();
         this.FOperatingShowInfos = new Vector.<TOperatingShowInfo>();
      }
      
      public function get Count() : uint
      {
         return this.FOperatingShowInfos.length;
      }
      
      protected function SortByShowIndex(param1:TOperatingShowInfo, param2:TOperatingShowInfo) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = param1.ShowIndex;
         _loc4_ = param2.ShowIndex;
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 0;
      }
      
      public function Add(param1:TOperatingShowInfo) : void
      {
         this.FOperatingShowInfos.push(param1);
      }
      
      public function GetShowInfoByIndex(param1:int) : TOperatingShowInfo
      {
         if(param1 < 0 || param1 >= this.FOperatingShowInfos.length)
         {
            return null;
         }
         return this.FOperatingShowInfos[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FOperatingShowInfos.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FOperatingShowInfos.pop();
            _loc2_++;
         }
         this.FOperatingShowInfos.length = 0;
      }
      
      public function Sort() : void
      {
         this.FOperatingShowInfos.sort(this.SortByShowIndex);
      }
   }
}

