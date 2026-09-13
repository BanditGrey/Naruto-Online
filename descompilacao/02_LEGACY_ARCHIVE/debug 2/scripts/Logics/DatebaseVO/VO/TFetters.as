package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TFetters extends TDatebaseVO
   {
      
      protected var FTeamId:uint;
      
      protected var FFriendLevel:uint;
      
      protected var FCombination:String;
      
      protected var FName:String;
      
      protected var FFormation:uint;
      
      protected var FAddAttr:String;
      
      protected var FAddAttrPercent:String;
      
      protected var FDescription:String;
      
      protected var FNeedExp:uint;
      
      protected var FExpAll:uint;
      
      protected var FExpTotal:uint;
      
      protected var FIsMystical:uint;
      
      protected var FLevelLimit:uint;
      
      public function TFetters()
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
         param1.writeUnsignedInt(this.FTeamId);
         param1.writeUnsignedInt(this.FFriendLevel);
         TUtilityString.FlushUTF(param1,this.FCombination);
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeUnsignedInt(this.FFormation);
         TUtilityString.FlushUTF(param1,this.FAddAttr);
         TUtilityString.FlushUTF(param1,this.FAddAttrPercent);
         TUtilityString.FlushUTF(param1,this.FDescription);
         param1.writeUnsignedInt(this.FNeedExp);
         param1.writeUnsignedInt(this.FExpAll);
         param1.writeUnsignedInt(this.FExpTotal);
         param1.writeUnsignedInt(this.FIsMystical);
         param1.writeUnsignedInt(this.FLevelLimit);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FTeamId = param1.readUnsignedInt();
         this.FFriendLevel = param1.readUnsignedInt();
         this.FCombination = TUtilityString.FetchUTF(param1);
         this.FName = TUtilityString.FetchUTF(param1);
         this.FFormation = param1.readUnsignedInt();
         this.FAddAttr = TUtilityString.FetchUTF(param1);
         this.FAddAttrPercent = TUtilityString.FetchUTF(param1);
         this.FDescription = TUtilityString.FetchUTF(param1);
         this.FNeedExp = param1.readUnsignedInt();
         this.FExpAll = param1.readUnsignedInt();
         this.FExpTotal = param1.readUnsignedInt();
         this.FIsMystical = param1.readUnsignedInt();
         this.FLevelLimit = param1.readUnsignedInt();
      }
      
      public function get TeamId() : uint
      {
         return this.FTeamId;
      }
      
      public function get FriendLevel() : uint
      {
         return this.FFriendLevel;
      }
      
      public function get Combination() : String
      {
         return this.FCombination;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Formation() : uint
      {
         return this.FFormation;
      }
      
      public function get AddAttr() : String
      {
         return this.FAddAttr;
      }
      
      public function get AddAttrPercent() : String
      {
         return this.FAddAttrPercent;
      }
      
      public function get Description() : String
      {
         return this.FDescription;
      }
      
      public function get IsMystical() : uint
      {
         return this.FIsMystical;
      }
      
      public function get LevelLimit() : uint
      {
         return this.FLevelLimit;
      }
      
      public function get ExpTotal() : uint
      {
         return this.FExpTotal;
      }
      
      public function get NeedExp() : uint
      {
         return this.FNeedExp;
      }
      
      public function get ExpAll() : uint
      {
         return this.FExpAll;
      }
   }
}

