package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TTreasureLevelup extends TDatebaseVO
   {
      
      protected var FItemid:uint;
      
      protected var FLevel:uint;
      
      protected var FNeedGold:uint;
      
      protected var FUpItem:uint;
      
      protected var FUpLevel:uint;
      
      public function TTreasureLevelup()
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
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FItemid);
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FNeedGold);
         param1.writeUnsignedInt(this.FUpItem);
         param1.writeUnsignedInt(this.FUpLevel);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FItemid = param1.readUnsignedInt();
         this.FLevel = param1.readUnsignedInt();
         this.FNeedGold = param1.readUnsignedInt();
         this.FUpItem = param1.readUnsignedInt();
         this.FUpLevel = param1.readUnsignedInt();
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function set Level(param1:uint) : void
      {
         this.FLevel = param1;
      }
      
      public function get NeedGold() : uint
      {
         return this.FNeedGold;
      }
      
      public function set NeedGold(param1:uint) : void
      {
         this.FNeedGold = param1;
      }
      
      public function get UpItem() : uint
      {
         return this.FUpItem;
      }
      
      public function set UpItem(param1:uint) : void
      {
         this.FUpItem = param1;
      }
      
      public function get UpLevel() : uint
      {
         return this.FUpLevel;
      }
      
      public function set UpLevel(param1:uint) : void
      {
         this.FUpLevel = param1;
      }
      
      public function get Itemid() : uint
      {
         return this.FItemid;
      }
   }
}

