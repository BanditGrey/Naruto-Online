package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.*;
   import Logics.DatebaseVO.VO.Json.*;
   import flash.utils.*;
   
   use namespace ResourcesSpace;
   
   public class TStarPoint extends TDatebaseVO
   {
      
      protected var FMapId:int;
      
      protected var FIndex:int;
      
      protected var FIsSkill:int;
      
      protected var FAddType:String;
      
      protected var FNeedFetch:int;
      
      protected var FNeedNewfetch:int;
      
      protected var FName:String;
      
      protected var FDesc:String;
      
      protected var FServenStarLevelLimit:int;
      
      protected var FStarPointAddType:TStarPointAddType;
      
      protected var FArrow:int;
      
      protected var FIsgoto:int;
      
      public function TStarPoint()
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
         if(FIdentifier == 17135001)
         {
         }
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FMapId);
         param1.writeUnsignedInt(this.FIndex);
         param1.writeUnsignedInt(this.FIsSkill);
         TUtilityString.FlushUTF(param1,this.FAddType);
         param1.writeUnsignedInt(this.FNeedFetch);
         param1.writeUnsignedInt(this.FNeedNewfetch);
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FDesc);
         param1.writeUnsignedInt(this.FServenStarLevelLimit);
         param1.writeUnsignedInt(this.FArrow);
         param1.writeUnsignedInt(this.FIsgoto);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FMapId = param1.readUnsignedInt();
         this.FIndex = param1.readUnsignedInt();
         this.FIsSkill = param1.readUnsignedInt();
         this.FAddType = TUtilityString.FetchUTF(param1);
         this.FNeedFetch = param1.readUnsignedInt();
         this.FNeedNewfetch = param1.readUnsignedInt();
         this.FName = TUtilityString.FetchUTF(param1);
         this.FDesc = TUtilityString.FetchUTF(param1);
         this.FServenStarLevelLimit = param1.readUnsignedInt();
         this.FStarPointAddType = new TStarPointAddType(this.FAddType);
         this.FArrow = param1.readUnsignedInt();
         this.FIsgoto = param1.readUnsignedInt();
      }
      
      public function get MapId() : int
      {
         return this.FMapId;
      }
      
      public function get Index() : int
      {
         return this.FIndex;
      }
      
      public function get IsSkill() : int
      {
         return this.FIsSkill;
      }
      
      public function get Arrow() : int
      {
         return this.FArrow;
      }
      
      public function get Isgoto() : int
      {
         return this.FIsgoto;
      }
      
      public function get AddType() : String
      {
         return this.FAddType;
      }
      
      public function get NeedFetch() : int
      {
         return this.FNeedFetch;
      }
      
      public function get NeedNewfetch() : int
      {
         return this.FNeedNewfetch;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function get ServenStarLevelLimit() : int
      {
         return this.FServenStarLevelLimit;
      }
      
      public function get StarPointAddType() : TStarPointAddType
      {
         return this.FStarPointAddType;
      }
   }
}

