package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TEmblem extends TDatebaseVO
   {
      
      protected var FType:int;
      
      protected var FName:String;
      
      protected var FUnlockcondition:int;
      
      protected var FUnlockType:int;
      
      protected var FTips:String;
      
      protected var FImageid:int;
      
      protected var FError:String;
      
      protected var FAddAttribute:String;
      
      public var AddAttributes:Array;
      
      public function TEmblem()
      {
         super();
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FType = param1.readUnsignedInt();
         this.FName = TUtilityString.FetchUTF(param1);
         this.FUnlockcondition = param1.readUnsignedInt();
         this.FUnlockType = param1.readUnsignedInt();
         this.FTips = TUtilityString.FetchUTF(param1);
         this.FImageid = param1.readUnsignedInt();
         this.FError = TUtilityString.FetchUTF(param1);
         this.FAddAttribute = TUtilityString.FetchUTF(param1);
         this.AddAttributes = Json.decode(this.FAddAttribute);
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FType);
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeUnsignedInt(this.FUnlockcondition);
         param1.writeUnsignedInt(this.FUnlockType);
         TUtilityString.FlushUTF(param1,this.FTips);
         param1.writeUnsignedInt(this.FImageid);
         TUtilityString.FlushUTF(param1,this.FError);
         TUtilityString.FlushUTF(param1,this.FAddAttribute);
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
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Unlockcondition() : int
      {
         return this.FUnlockcondition;
      }
      
      public function get UnlockType() : int
      {
         return this.FUnlockType;
      }
      
      public function get Tips() : String
      {
         return this.FTips;
      }
      
      public function get Imageid() : int
      {
         return this.FImageid;
      }
      
      public function get AddAttribute() : String
      {
         return this.FAddAttribute;
      }
      
      public function get Error() : String
      {
         return this.FError;
      }
   }
}

