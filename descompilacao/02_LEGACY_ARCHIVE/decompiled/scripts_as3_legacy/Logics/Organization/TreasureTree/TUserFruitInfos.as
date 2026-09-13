package Logics.Organization.TreasureTree
{
   public class TUserFruitInfos
   {
      
      protected var FUserFruitInfos:Vector.<TUserFruitInfo>;
      
      public function TUserFruitInfos()
      {
         super();
         this.FUserFruitInfos = new Vector.<TUserFruitInfo>();
      }
      
      public function get Count() : uint
      {
         return this.FUserFruitInfos.length;
      }
      
      public function Add(param1:TUserFruitInfo) : void
      {
         this.FUserFruitInfos.push(param1);
      }
      
      public function GetUserFruitByIndex(param1:int) : TUserFruitInfo
      {
         if(param1 < 0 || param1 >= this.FUserFruitInfos.length)
         {
            return null;
         }
         return this.FUserFruitInfos[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FUserFruitInfos.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FUserFruitInfos.pop();
            _loc2_++;
         }
         this.FUserFruitInfos.length = 0;
      }
   }
}

