package Logics.Streamization.WuXing
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.WuXing.TWuXing;
   import Resources.Constants.CONST_WUXING;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerWuxing extends TUnstreamizer
   {
      
      protected var FWuXingData:Vector.<TWuXing>;
      
      protected var FWuXingExpData:Vector.<TWuXing>;
      
      protected const ELE_TYPE:Array = CONST_WUXING.ELE_TYPE;
      
      public function TUnstreamizerWuxing()
      {
         super();
         this.FWuXingData = new Vector.<TWuXing>();
         this.FWuXingExpData = new Vector.<TWuXing>();
         this.InitWuxingExpData();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TWuXing = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc4_ = param1.readShort();
         this.FWuXingData.length = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = new TWuXing();
            _loc6_.heroId = param1.readUnsignedInt();
            _loc6_.ElementBit = param1.readUnsignedInt();
            _loc6_.ElementPoint = param1.readUnsignedInt();
            this.FWuXingData.push(_loc6_);
            _loc5_++;
         }
         _loc4_ = param1.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = int(param1.readUnsignedInt());
            _loc8_ = int(param1.readUnsignedInt());
            _loc6_ = this.FWuXingExpData[_loc7_ - 1];
            _loc6_.Exp = _loc8_;
            _loc5_++;
         }
      }
      
      protected function InitWuxingExpData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TWuXing = null;
         _loc1_ = 1;
         while(_loc1_ < this.ELE_TYPE.length)
         {
            _loc2_ = new TWuXing();
            _loc2_.ElementId = _loc1_;
            _loc2_.Exp = 0;
            this.FWuXingExpData.push(_loc2_);
            _loc1_++;
         }
      }
      
      public function UpdateElementPointByHeroId(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TWuXing = null;
         if(this.FWuXingData)
         {
            _loc4_ = int(param1.readUnsignedInt());
            _loc5_ = int(param1.readUnsignedInt());
            for each(_loc6_ in this.FWuXingData)
            {
               if(_loc6_.heroId == _loc4_)
               {
                  _loc6_.ElementPoint += _loc5_;
                  break;
               }
            }
         }
      }
      
      public function UpdateElementBitByHeroId(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TWuXing = null;
         if(this.FWuXingData)
         {
            _loc4_ = int(param1.readUnsignedInt());
            _loc5_ = int(param1.readUnsignedInt());
            for each(_loc6_ in this.FWuXingData)
            {
               if(_loc6_.heroId == _loc4_)
               {
                  _loc6_.ElementBit = _loc5_ > 0 ? 1 << _loc5_ | _loc6_.ElementBit : 0;
                  break;
               }
            }
         }
      }
      
      public function UpdateElementExpByHeroId(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TWuXing = null;
         if(this.FWuXingExpData)
         {
            _loc4_ = int(param1.readUnsignedInt());
            _loc5_ = int(param1.readUnsignedInt());
            for each(_loc6_ in this.FWuXingExpData)
            {
               if(_loc6_.ElementId == _loc4_)
               {
                  _loc6_.Exp = _loc5_;
                  break;
               }
            }
         }
      }
      
      public function get WuXingExpData() : Vector.<TWuXing>
      {
         return this.FWuXingExpData;
      }
      
      public function get WuXingData() : Vector.<TWuXing>
      {
         return this.FWuXingData;
      }
   }
}

