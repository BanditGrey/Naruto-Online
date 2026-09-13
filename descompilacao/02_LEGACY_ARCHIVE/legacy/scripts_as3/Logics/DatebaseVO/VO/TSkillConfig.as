package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TSkillConfig extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FDesc:String;
      
      protected var FIcon:uint;
      
      protected var FSortId:uint;
      
      protected var FDescReincarnation:String;
      
      protected var FEffects:String;
      
      protected var FEffectsObject:Object;
      
      protected var FScreening:String;
      
      protected var FScreeningVector:Array;
      
      protected var FType:int;
      
      protected var FSkillId:int;
      
      protected var FAwakecost:String;
      
      protected var FAwakedesc:String;
      
      protected var FAwakedescRe:String;
      
      protected var FAwakecostObject:Object;
      
      public function TSkillConfig()
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
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FDesc);
         param1.writeUnsignedInt(this.FIcon);
         param1.writeUnsignedInt(this.FSortId);
         TUtilityString.FlushUTF(param1,this.FDescReincarnation);
         TUtilityString.FlushUTF(param1,this.FEffects);
         TUtilityString.FlushUTF(param1,this.FScreening);
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FSkillId);
         TUtilityString.FlushUTF(param1,this.FAwakecost);
         TUtilityString.FlushUTF(param1,this.FAwakedesc);
         TUtilityString.FlushUTF(param1,this.FAwakedescRe);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FDesc = TUtilityString.FetchUTF(param1);
         this.FIcon = param1.readUnsignedInt();
         this.FSortId = param1.readUnsignedInt();
         this.FDescReincarnation = TUtilityString.FetchUTF(param1);
         this.FDescReincarnation = this.FDescReincarnation.split("&lt;").join("<");
         this.FDescReincarnation = this.FDescReincarnation.split("&gt;").join(">");
         this.FEffects = TUtilityString.FetchUTF(param1);
         if(!this.FEffects)
         {
            this.FEffectsObject = null;
         }
         else
         {
            this.FEffectsObject = Json.decode(this.FEffects) as Object;
         }
         this.FScreening = TUtilityString.FetchUTF(param1);
         this.FScreeningVector = Json.decode(this.FScreening);
         this.FType = param1.readUnsignedInt();
         this.FSkillId = param1.readUnsignedInt();
         this.FAwakecost = TUtilityString.FetchUTF(param1);
         this.FAwakedesc = TUtilityString.FetchUTF(param1);
         this.FAwakedescRe = TUtilityString.FetchUTF(param1);
         this.FAwakecostObject = Json.decode(this.FAwakecost);
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function get Icon() : uint
      {
         return this.FIcon;
      }
      
      public function get SortId() : uint
      {
         return this.FSortId;
      }
      
      public function get DescReincarnation() : String
      {
         return this.FDescReincarnation;
      }
      
      public function get Effects() : String
      {
         return this.FEffects;
      }
      
      public function get EffectsObject() : Object
      {
         return this.FEffectsObject;
      }
      
      public function get Screening() : String
      {
         return this.FScreening;
      }
      
      public function get ScreeningVector() : Array
      {
         return this.FScreeningVector;
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function get SkillId() : int
      {
         return this.FSkillId;
      }
      
      public function get Awakecost() : String
      {
         return this.FAwakecost;
      }
      
      public function get Awakedesc() : String
      {
         return this.FAwakedesc;
      }
      
      public function get AwakedescRe() : String
      {
         return this.FAwakedescRe;
      }
      
      public function get AwakecostObject() : Object
      {
         return this.FAwakecostObject;
      }
   }
}

