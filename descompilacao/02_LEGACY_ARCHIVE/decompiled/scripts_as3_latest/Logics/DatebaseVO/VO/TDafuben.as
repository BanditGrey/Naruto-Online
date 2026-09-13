package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TDafuben extends TDatebaseVO
   {
      
      protected var FChapterid:int;
      
      protected var FName:String;
      
      protected var FCondition:String;
      
      protected var FConditionList:Array;
      
      protected var FBp:int;
      
      protected var FAward:String;
      
      protected var FIconzy:String;
      
      protected var FUiid:int;
      
      protected var FNeed:int;
      
      protected var FLevel:int;
      
      public function TDafuben()
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
                     this[_loc3_] = _loc4_;
                  }
               }
            }
            _loc6_++;
         }
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FChapterid);
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FCondition);
         param1.writeUnsignedInt(this.FBp);
         TUtilityString.FlushUTF(param1,this.FAward);
         TUtilityString.FlushUTF(param1,this.FIconzy);
         param1.writeUnsignedInt(this.FUiid);
         param1.writeUnsignedInt(this.FNeed);
         param1.writeUnsignedInt(this.FLevel);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FChapterid = param1.readUnsignedInt();
         this.FName = TUtilityString.FetchUTF(param1);
         this.FCondition = TUtilityString.FetchUTF(param1);
         this.FConditionList = Json.decode(this.FCondition);
         this.FBp = param1.readUnsignedInt();
         this.FAward = TUtilityString.FetchUTF(param1);
         this.FIconzy = TUtilityString.FetchUTF(param1);
         this.FUiid = param1.readUnsignedInt();
         this.FNeed = param1.readUnsignedInt();
         this.FLevel = param1.readUnsignedInt();
      }
      
      public function get Chapterid() : int
      {
         return this.FChapterid;
      }
      
      public function get Condition() : String
      {
         return this.FCondition;
      }
      
      public function get ConditionList() : Array
      {
         return this.FConditionList;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Bp() : int
      {
         return this.FBp;
      }
      
      public function get Award() : String
      {
         return this.FAward;
      }
      
      public function get Iconzy() : String
      {
         return this.FIconzy;
      }
      
      public function get Uiid() : int
      {
         return this.FUiid;
      }
      
      public function get Need() : int
      {
         return this.FNeed;
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
   }
}

