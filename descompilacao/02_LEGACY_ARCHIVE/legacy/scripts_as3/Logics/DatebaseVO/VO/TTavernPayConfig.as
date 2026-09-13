package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TTavernPayConfigTypes;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TTavernPayConfig extends TDatebaseVO
   {
      
      protected var FKey:String;
      
      protected var FTypesVect:TTavernPayConfigTypes;
      
      protected var FValue:int;
      
      protected var FDesc:String;
      
      protected var FTypes:String;
      
      public function TTavernPayConfig()
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
         TUtilityString.FlushUTF(param1,this.FKey);
         TUtilityString.FlushUTF(param1,this.FTypes);
         param1.writeUnsignedInt(this.FValue);
         TUtilityString.FlushUTF(param1,this.FDesc);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:String = null;
         this.FKey = TUtilityString.FetchUTF(param1);
         this.FTypes = TUtilityString.FetchUTF(param1);
         this.FTypesVect = new TTavernPayConfigTypes(this.FTypes);
         this.FValue = param1.readUnsignedInt();
         this.FDesc = TUtilityString.FetchUTF(param1);
      }
      
      public function get Key() : String
      {
         return this.FKey;
      }
      
      public function get TypesVect() : TTavernPayConfigTypes
      {
         return this.FTypesVect;
      }
      
      public function get Value() : int
      {
         return this.FValue;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function get Types() : String
      {
         return this.FTypes;
      }
   }
}

