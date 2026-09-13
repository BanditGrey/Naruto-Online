package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TStarMap extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FProfession:int;
      
      protected var FQuality:int;
      
      protected var FPointCount:int;
      
      protected var FPic:String;
      
      protected var FDesc:String;
      
      protected var FStartID:int;
      
      public function TStarMap()
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
         param1.writeUnsignedInt(this.FProfession);
         param1.writeUnsignedInt(this.FQuality);
         param1.writeUnsignedInt(this.FPointCount);
         TUtilityString.FlushUTF(param1,this.FPic);
         TUtilityString.FlushUTF(param1,this.FDesc);
         param1.writeUnsignedInt(this.FStartID);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FProfession = param1.readUnsignedInt();
         this.FQuality = param1.readUnsignedInt();
         this.FPointCount = param1.readUnsignedInt();
         this.FPic = TUtilityString.FetchUTF(param1);
         this.FDesc = TUtilityString.FetchUTF(param1);
         this.FStartID = param1.readUnsignedInt();
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Profession() : int
      {
         return this.FProfession;
      }
      
      public function get Quality() : int
      {
         return this.FQuality;
      }
      
      public function get PointCount() : int
      {
         return this.FPointCount;
      }
      
      public function get Pic() : String
      {
         return this.FPic;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function get StartID() : int
      {
         return this.FStartID;
      }
   }
}

