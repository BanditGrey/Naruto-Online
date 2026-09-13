package Logics.Streamization.Emblem
{
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Emblem.TEmblemData;
   import Resources.Constants.CONST_EMBLEM;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerEmblem extends TUnstreamizer
   {
      
      public var EmblemDatas:Vector.<TEmblemData>;
      
      public var EmblemId:int;
      
      public var RingId:int;
      
      public var EmblemNum:int;
      
      public var RingExp:int;
      
      public var Currid:int;
      
      public function TUnstreamizerEmblem()
      {
         super();
         this.EmblemDatas = new Vector.<TEmblemData>();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TEmblemData = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         this.EmblemDatas.length = 0;
         _loc5_ = param1.readShort();
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = param1.readInt();
            _loc4_ = new TEmblemData(_loc7_);
            _loc4_.Type = param1.readInt();
            _loc4_.Name = TUtilityString.FetchUTF(param1);
            _loc4_.Unlock = param1.readInt();
            this.EmblemDatas.push(_loc4_);
            _loc6_++;
         }
         this.EmblemId = param1.readInt();
         this.RingId = param1.readInt();
         this.EmblemNum = param1.readInt();
         this.RingExp = param1.readInt();
         this.Currid = param1.readInt();
      }
      
      public function UpdateEmblemByEmblemId(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:TEmblemData = null;
         if(this.EmblemDatas)
         {
            _loc4_ = param1.readInt();
            for each(_loc5_ in this.EmblemDatas)
            {
               if(_loc5_.EmblemId == _loc4_)
               {
                  _loc5_.Unlock = CONST_EMBLEM.UNLOCK;
                  ++this.EmblemNum;
                  break;
               }
            }
         }
      }
   }
}

