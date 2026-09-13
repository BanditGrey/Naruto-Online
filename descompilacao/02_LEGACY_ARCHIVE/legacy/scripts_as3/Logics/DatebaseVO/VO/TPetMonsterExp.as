package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TPetMonsterExp extends TDatebaseVO
   {
      
      protected var FMonsterId:int;
      
      protected var FMonsterLevel:int;
      
      protected var FNeedExp:int;
      
      protected var FGotExp:int;
      
      protected var FAddType:uint;
      
      protected var FAddValues:uint;
      
      protected var FAddValue:String;
      
      public function TPetMonsterExp()
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
         param1.writeUnsignedInt(this.FMonsterId);
         param1.writeUnsignedInt(this.FMonsterLevel);
         param1.writeUnsignedInt(this.FNeedExp);
         param1.writeUnsignedInt(this.FGotExp);
         TUtilityString.FlushUTF(param1,this.FAddValue);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         this.FMonsterId = param1.readUnsignedInt();
         this.FMonsterLevel = param1.readUnsignedInt();
         this.FNeedExp = param1.readUnsignedInt();
         this.FGotExp = param1.readUnsignedInt();
         this.FAddValue = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FAddValue);
         this.FAddType = _loc3_.addType as uint;
         this.FAddValues = _loc3_.addValue;
      }
      
      public function get MonsterLevel() : int
      {
         return this.FMonsterLevel;
      }
      
      public function get MonsterId() : int
      {
         return this.FMonsterId;
      }
      
      public function get NeedExp() : int
      {
         return this.FNeedExp;
      }
      
      public function get GotExp() : int
      {
         return this.FGotExp;
      }
      
      public function get AddType() : uint
      {
         return this.FAddType;
      }
      
      public function get AddValues() : uint
      {
         return this.FAddValues;
      }
      
      public function get AddValue() : String
      {
         return this.FAddValue;
      }
   }
}

