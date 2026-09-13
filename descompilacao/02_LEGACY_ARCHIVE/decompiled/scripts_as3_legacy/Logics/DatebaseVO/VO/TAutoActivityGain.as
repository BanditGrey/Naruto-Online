package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TAutoActivityGain extends TDatebaseVO
   {
      
      protected var FMonsterCoin:uint;
      
      protected var FMonsterExp:uint;
      
      protected var FTraitorCoin:uint;
      
      protected var FTraitorExp:uint;
      
      public function TAutoActivityGain()
      {
         super();
      }
      
      override ResourcesSpace function ReadDataByXml(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         _loc5_ = uint(param1.elements().length());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = param1.elements()[_loc6_];
            _loc3_ = String(_loc2_.name());
            _loc4_ = _loc2_;
            if(_loc3_ == "id")
            {
               Coerce(uint(_loc4_));
            }
            else
            {
               _loc3_ = "F" + _loc3_;
               if(hasOwnProperty(_loc3_))
               {
                  this[_loc3_] = _loc4_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc3_.slice(1,2)) < 0)
                  {
                     _loc3_ = "F" + _loc3_.slice(1,2).toLocaleUpperCase() + _loc3_.slice(2);
                  }
                  if(hasOwnProperty(_loc3_.slice(1)))
                  {
                     if(this[_loc3_] is Boolean)
                     {
                        this[_loc3_] = Boolean(int(_loc4_));
                     }
                     else
                     {
                        this[_loc3_] = _loc4_;
                     }
                  }
               }
            }
            _loc6_++;
         }
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FMonsterCoin);
         param1.writeUnsignedInt(this.FMonsterExp);
         param1.writeUnsignedInt(this.FTraitorCoin);
         param1.writeUnsignedInt(this.FTraitorExp);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FMonsterCoin = param1.readUnsignedInt();
         this.FMonsterExp = param1.readUnsignedInt();
         this.FTraitorCoin = param1.readUnsignedInt();
         this.FTraitorExp = param1.readUnsignedInt();
      }
      
      public function get MonsterCoin() : uint
      {
         return this.FMonsterCoin;
      }
      
      public function get MonsterExp() : uint
      {
         return this.FMonsterExp;
      }
      
      public function get TraitorCoin() : uint
      {
         return this.FTraitorCoin;
      }
      
      public function get TraitorExp() : uint
      {
         return this.FTraitorExp;
      }
   }
}

