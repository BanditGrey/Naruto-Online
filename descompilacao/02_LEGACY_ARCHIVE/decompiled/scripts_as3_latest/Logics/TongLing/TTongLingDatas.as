package Logics.TongLing
{
   public class TTongLingDatas
   {
      
      protected var FTongLingData:Vector.<TTongLingData>;
      
      public var ContractID:int;
      
      public var ContractCount:int;
      
      public var TongLingAtt:Vector.<int>;
      
      public var CurExp:int;
      
      public function TTongLingDatas()
      {
         super();
         this.FTongLingData = new Vector.<TTongLingData>();
         this.TongLingAtt = new Vector.<int>(24);
      }
      
      public function get TongLingData() : Vector.<TTongLingData>
      {
         return this.FTongLingData;
      }
      
      public function set TongLingData(param1:Vector.<TTongLingData>) : void
      {
         this.FTongLingData = param1;
      }
      
      public function AddTongLingData(param1:TTongLingData) : void
      {
         this.FTongLingData.push(param1);
      }
      
      public function GetTongLingDataById64(param1:uint, param2:uint) : TTongLingData
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TTongLingData = null;
         _loc4_ = this.FTongLingData.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FTongLingData[_loc3_];
            if(_loc5_.Id0 == param1 && _loc5_.Id1 == param2)
            {
               return _loc5_;
            }
            _loc3_++;
         }
         return null;
      }
   }
}

