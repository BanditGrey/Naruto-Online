package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TFollowBloodBound extends TDatebaseVO
   {
      
      protected var FType:int;
      
      protected var FName:String;
      
      protected var FQuality:int;
      
      protected var FPrice:int;
      
      protected var FDevourExp:int;
      
      protected var FNextLevelID:int;
      
      protected var FNeedExp:int;
      
      protected var FExpAll:int;
      
      protected var FLevelcount:int;
      
      protected var FLevel:int;
      
      protected var FIconID:int;
      
      protected var FLevelLimit:int;
      
      protected var FAddAttr:String;
      
      protected var FAddAttrArr:Array;
      
      public function TFollowBloodBound()
      {
         super();
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FType);
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeUnsignedInt(this.FQuality);
         param1.writeUnsignedInt(this.FPrice);
         param1.writeUnsignedInt(this.FDevourExp);
         param1.writeUnsignedInt(this.FNextLevelID);
         param1.writeUnsignedInt(this.FNeedExp);
         param1.writeUnsignedInt(this.FExpAll);
         param1.writeUnsignedInt(this.FLevelcount);
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FIconID);
         param1.writeUnsignedInt(this.FLevelLimit);
         TUtilityString.FlushUTF(param1,this.FAddAttr);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Object = null;
         this.FType = param1.readUnsignedInt();
         this.FName = TUtilityString.FetchUTF(param1);
         this.FQuality = param1.readUnsignedInt();
         this.FPrice = param1.readUnsignedInt();
         this.FDevourExp = param1.readUnsignedInt();
         this.FNextLevelID = param1.readUnsignedInt();
         this.FNeedExp = param1.readUnsignedInt();
         this.FExpAll = param1.readUnsignedInt();
         this.FLevelcount = param1.readUnsignedInt();
         this.FLevel = param1.readUnsignedInt();
         this.FIconID = param1.readUnsignedInt();
         this.FLevelLimit = param1.readUnsignedInt();
         this.FAddAttr = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FAddAttr);
         if(_loc2_ == 0)
         {
            this.FAddAttrArr = null;
         }
         else
         {
            this.FAddAttrArr = _loc2_ as Array;
         }
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
      
      public function get LevelLimit() : int
      {
         return this.FLevelLimit;
      }
      
      public function get IconID() : int
      {
         return this.FIconID;
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
      
      public function get ExpAll() : int
      {
         return this.FExpAll;
      }
      
      public function get Levelcount() : int
      {
         return this.FLevelcount;
      }
      
      public function get NeedExp() : int
      {
         return this.FNeedExp;
      }
      
      public function get NextLevelID() : int
      {
         return this.FNextLevelID;
      }
      
      public function get DevourExp() : int
      {
         return this.FDevourExp;
      }
      
      public function get Price() : int
      {
         return this.FPrice;
      }
      
      public function get Quality() : int
      {
         return this.FQuality;
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get AddAttr() : String
      {
         return this.FAddAttr;
      }
      
      public function get AddAttrArr() : Array
      {
         return this.FAddAttrArr;
      }
   }
}

