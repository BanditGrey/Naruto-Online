package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TSevenHeroSoul extends TDatebaseVO
   {
      
      protected var FHeroid:uint;
      
      protected var FSoultips:String;
      
      protected var FName:String;
      
      protected var FStringColor:String;
      
      protected var FColor:String;
      
      protected var FTextColor:uint;
      
      public function TSevenHeroSoul()
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
         param1.writeUnsignedInt(this.FHeroid);
         TUtilityString.FlushUTF(param1,this.FSoultips);
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FColor);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FHeroid = param1.readUnsignedInt();
         this.FSoultips = TUtilityString.FetchUTF(param1);
         this.FName = TUtilityString.FetchUTF(param1);
         this.FColor = TUtilityString.FetchUTF(param1);
         this.FTextColor = parseInt(this.FColor);
      }
      
      public function get Heroid() : uint
      {
         return this.FHeroid;
      }
      
      public function get Soultips() : String
      {
         return this.FSoultips;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Color() : String
      {
         return this.FColor;
      }
      
      public function get TextColor() : uint
      {
         return this.FTextColor;
      }
   }
}

