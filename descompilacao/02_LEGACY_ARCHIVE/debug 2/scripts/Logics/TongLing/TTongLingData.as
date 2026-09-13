package Logics.TongLing
{
   public class TTongLingData
   {
      
      protected var FId0:uint;
      
      protected var FId1:uint;
      
      protected var FWashAttributeList:Vector.<TAttribute>;
      
      protected var FWashingAttributeList:Vector.<TAttribute>;
      
      public function TTongLingData()
      {
         super();
         this.FWashAttributeList = new Vector.<TAttribute>();
         this.FWashingAttributeList = new Vector.<TAttribute>();
      }
      
      protected function UpdataWashData(param1:TAttribute) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         _loc3_ = this.FWashAttributeList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FWashAttributeList[_loc2_].Type == param1.Type)
            {
               this.FWashAttributeList[_loc2_].Value = param1.Value;
               return;
            }
            _loc2_++;
         }
         this.AddWashAttribute(param1.Type,param1.Value);
      }
      
      public function get Id0() : uint
      {
         return this.FId0;
      }
      
      public function set Id0(param1:uint) : void
      {
         this.FId0 = param1;
      }
      
      public function get Id1() : uint
      {
         return this.FId1;
      }
      
      public function set Id1(param1:uint) : void
      {
         this.FId1 = param1;
      }
      
      public function get WashAttributeList() : Vector.<TAttribute>
      {
         return this.FWashAttributeList;
      }
      
      public function set WashAttributeList(param1:Vector.<TAttribute>) : void
      {
         this.FWashAttributeList = param1;
      }
      
      public function get WashingAttributeList() : Vector.<TAttribute>
      {
         return this.FWashingAttributeList;
      }
      
      public function set WashingAttributeList(param1:Vector.<TAttribute>) : void
      {
         this.FWashingAttributeList = param1;
      }
      
      public function get WashCount() : uint
      {
         return this.FWashAttributeList.length;
      }
      
      public function get WashingCount() : uint
      {
         return this.FWashingAttributeList.length;
      }
      
      public function ClearWashAttribute() : void
      {
         this.FWashAttributeList.length = 0;
      }
      
      public function ClearWashingAttribute() : void
      {
         this.FWashingAttributeList.length = 0;
      }
      
      public function UpdateWashingDateToWashData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TAttribute = null;
         _loc1_ = 0;
         while(_loc1_ < this.FWashingAttributeList.length)
         {
            _loc5_ = this.FWashingAttributeList[_loc1_];
            this.UpdataWashData(_loc5_);
            _loc1_++;
         }
         this.ClearWashingAttribute();
      }
      
      public function AddWashAttribute(param1:uint, param2:uint) : void
      {
         var _loc3_:TAttribute = null;
         _loc3_ = new TAttribute();
         _loc3_.Type = param1;
         _loc3_.Value = param2;
         this.FWashAttributeList.push(_loc3_);
      }
      
      public function AddWashingAttribute(param1:uint, param2:uint) : void
      {
         var _loc3_:TAttribute = null;
         _loc3_ = new TAttribute();
         _loc3_.Type = param1;
         _loc3_.Value = param2;
         this.FWashingAttributeList.push(_loc3_);
      }
      
      public function GetWashAttributeByType(param1:uint) : uint
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TAttribute = null;
         _loc3_ = this.FWashAttributeList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FWashAttributeList[_loc2_];
            if(_loc4_.Type == param1)
            {
               return _loc4_.Value;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function GetWashingAttributeByType(param1:uint) : uint
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TAttribute = null;
         _loc3_ = this.FWashingAttributeList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FWashingAttributeList[_loc2_];
            if(_loc4_.Type == param1)
            {
               return _loc4_.Value;
            }
            _loc2_++;
         }
         return 0;
      }
   }
}

