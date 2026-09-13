package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TArchive extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FIcon:uint;
      
      protected var FSuitId:String;
      
      protected var FSuitIdVector:Array;
      
      protected var FType:uint;
      
      protected var FAmount:uint;
      
      protected var FResolve:uint;
      
      protected var FAddAttribute:String;
      
      protected var FAddAttributeVector:Array;
      
      public function TArchive()
      {
         super();
      }
      
      override ResourcesSpace function ReadDataByXml(param1:XML) : void
      {
         var _loc4_:XML = null;
         var _loc5_:String = null;
         var _loc6_:* = undefined;
         var _loc2_:uint = uint(param1.elements().length());
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.elements()[_loc3_];
            _loc5_ = String(_loc4_.name());
            _loc6_ = _loc4_;
            if(_loc5_ == "id")
            {
               Coerce(uint(_loc6_));
            }
            else
            {
               _loc5_ = "F" + _loc5_;
               if(hasOwnProperty(_loc5_))
               {
                  this[_loc5_] = _loc6_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc5_.slice(1,2)) < 0)
                  {
                     _loc5_ = "F" + _loc5_.slice(1,2).toLocaleUpperCase() + _loc5_.slice(2);
                  }
                  if(hasOwnProperty(_loc5_.slice(1)))
                  {
                     if(this[_loc5_] is Boolean)
                     {
                        this[_loc5_] = Boolean(int(_loc6_));
                     }
                     else
                     {
                        this[_loc5_] = _loc6_;
                     }
                  }
               }
            }
            _loc3_++;
         }
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeUnsignedInt(this.FIcon);
         TUtilityString.FlushUTF(param1,this.FSuitId);
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FAmount);
         param1.writeUnsignedInt(this.FResolve);
         TUtilityString.FlushUTF(param1,this.FAddAttribute);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FIcon = param1.readUnsignedInt();
         this.FSuitId = TUtilityString.FetchUTF(param1);
         this.FType = param1.readUnsignedInt();
         this.FAmount = param1.readUnsignedInt();
         this.FResolve = param1.readUnsignedInt();
         this.FAddAttribute = TUtilityString.FetchUTF(param1);
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Icon() : uint
      {
         return this.FIcon;
      }
      
      public function get SuitId() : String
      {
         return this.FSuitId;
      }
      
      public function get SuitIdVector() : Array
      {
         if(this.FSuitIdVector == null && Boolean(this.FSuitId))
         {
            this.FSuitIdVector = JSON.parse(this.FSuitId) as Array;
         }
         return this.FSuitIdVector;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function get Amount() : uint
      {
         return this.FAmount;
      }
      
      public function get Resolve() : uint
      {
         return this.FResolve;
      }
      
      public function get AddAttribute() : String
      {
         return this.FAddAttribute;
      }
      
      public function get AddAttributeVector() : Array
      {
         if(this.FAddAttributeVector == null && Boolean(this.FAddAttribute))
         {
            this.FAddAttributeVector = JSON.parse(this.FAddAttribute) as Array;
         }
         return this.FAddAttributeVector;
      }
   }
}

