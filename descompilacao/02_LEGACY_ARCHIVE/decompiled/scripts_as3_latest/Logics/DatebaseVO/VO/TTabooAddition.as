package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TTabooAddition extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FAdditiveEffect:String;
      
      protected var FSynthesis:String;
      
      protected var FAddAttribute:String;
      
      protected var FSubType:int;
      
      protected var FNeedLevel:int;
      
      protected var FAddEffectArr:Array;
      
      protected var FSMaterialArr:Array;
      
      protected var FAddProperty:Array;
      
      public function TTabooAddition()
      {
         super();
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FAdditiveEffect);
         TUtilityString.FlushUTF(param1,this.FSynthesis);
         TUtilityString.FlushUTF(param1,this.FAddAttribute);
         param1.writeUnsignedInt(this.FSubType);
         param1.writeUnsignedInt(this.FNeedLevel);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FAdditiveEffect = TUtilityString.FetchUTF(param1);
         this.FSynthesis = TUtilityString.FetchUTF(param1);
         this.FAddAttribute = TUtilityString.FetchUTF(param1);
         this.FSubType = param1.readUnsignedInt();
         this.FNeedLevel = param1.readUnsignedInt();
         this.FAddEffectArr = Json.decode(this.FAdditiveEffect);
         this.FSMaterialArr = Json.decode(this.FSynthesis);
         this.FAddProperty = Json.decode(this.FAddAttribute);
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get NeedLevel() : int
      {
         return this.FNeedLevel;
      }
      
      public function get SubType() : int
      {
         return this.FSubType;
      }
      
      public function get AddEffectArr() : Array
      {
         return this.FAddEffectArr;
      }
      
      public function get SMaterialArr() : Array
      {
         return this.FSMaterialArr;
      }
      
      public function get AddProperty() : Array
      {
         return this.FAddProperty;
      }
      
      public function get AddAttribute() : String
      {
         return this.FAddAttribute;
      }
      
      public function get Synthesis() : String
      {
         return this.FSynthesis;
      }
      
      public function get AdditiveEffect() : String
      {
         return this.FAdditiveEffect;
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
   }
}

