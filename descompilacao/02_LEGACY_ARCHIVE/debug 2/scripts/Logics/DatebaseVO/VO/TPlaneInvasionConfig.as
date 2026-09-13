package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TPlaneInvasionConfig extends TDatebaseVO
   {
      
      protected var FLevel:uint;
      
      protected var FInCampain:uint;
      
      protected var FHeros:String;
      
      protected var FHerosArr:Object;
      
      protected var FNameTotal:String;
      
      protected var FNamePart:String;
      
      public function TPlaneInvasionConfig()
      {
         super();
      }
      
      override ResourcesSpace function ReadDataByXml(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:* = undefined;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         _loc5_ = uint(param1.elements().length());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = param1.elements()[_loc6_];
            _loc4_ = String(_loc2_.name());
            _loc3_ = _loc2_;
            if(_loc4_ == "id")
            {
               Coerce(uint(_loc3_));
            }
            else
            {
               _loc4_ = "F" + _loc4_;
               if(hasOwnProperty(_loc4_))
               {
                  this[_loc4_] = _loc3_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc4_.slice(1,2)) < 0)
                  {
                     _loc4_ = "F" + _loc4_.slice(1,2).toLocaleUpperCase() + _loc4_.slice(2);
                  }
                  if(hasOwnProperty(_loc4_.slice(1)))
                  {
                     if(this[_loc4_] is Boolean)
                     {
                        this[_loc4_] = Boolean(int(_loc3_));
                     }
                     else
                     {
                        this[_loc4_] = _loc3_;
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
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FInCampain);
         TUtilityString.FlushUTF(param1,this.FHeros);
         TUtilityString.FlushUTF(param1,this.FNameTotal);
         TUtilityString.FlushUTF(param1,this.FNamePart);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FLevel = param1.readUnsignedInt();
         this.FInCampain = param1.readUnsignedInt();
         this.FHeros = TUtilityString.FetchUTF(param1);
         if(!TUtilityString.Empty(this.FHeros))
         {
            this.FHerosArr = JSON.parse(this.FHeros);
         }
         this.FNameTotal = TUtilityString.FetchUTF(param1);
         this.FNamePart = TUtilityString.FetchUTF(param1);
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function get Incampain() : uint
      {
         return this.FInCampain;
      }
      
      public function get Heros() : String
      {
         return this.FHeros;
      }
      
      public function get HerosArr() : Object
      {
         return this.FHerosArr;
      }
      
      public function get NameTotal() : String
      {
         return this.FNameTotal;
      }
      
      public function get NamePart() : String
      {
         return this.FNamePart;
      }
   }
}

