package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TTavernGrade extends TDatebaseVO
   {
      
      protected var FLevel:uint;
      
      protected var FPage:uint;
      
      protected var FWineLvs:Vector.<int>;
      
      protected var FPayConfigsVect:Object;
      
      protected var FVipsVect:Object;
      
      protected var FPreview:uint;
      
      protected var FTips:String;
      
      protected var FIsTavern:uint;
      
      protected var FIsViolent:uint;
      
      protected var FWineLv:String;
      
      protected var FPayConfigs:String;
      
      protected var FVips:String;
      
      public function TTavernGrade()
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
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FPage);
         TUtilityString.FlushUTF(param1,this.FWineLv);
         TUtilityString.FlushUTF(param1,this.FPayConfigs);
         TUtilityString.FlushUTF(param1,this.FVips);
         param1.writeUnsignedInt(this.FPreview);
         TUtilityString.FlushUTF(param1,this.FTips);
         param1.writeUnsignedInt(this.FIsTavern);
         param1.writeUnsignedInt(this.FIsViolent);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:String = null;
         this.FLevel = param1.readUnsignedInt();
         this.FPage = param1.readUnsignedInt();
         this.FWineLv = TUtilityString.FetchUTF(param1);
         this.FWineLvs = Vector.<int>(Json.decode(this.FWineLv).wineLv);
         this.FPayConfigs = TUtilityString.FetchUTF(param1);
         this.FPayConfigsVect = Json.decode(this.FPayConfigs);
         this.FVips = TUtilityString.FetchUTF(param1);
         this.FVipsVect = Json.decode(this.FVips);
         this.FPreview = param1.readUnsignedInt();
         this.FTips = TUtilityString.FetchUTF(param1);
         this.FIsTavern = param1.readUnsignedInt();
         this.FIsViolent = param1.readUnsignedInt();
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function get Page() : uint
      {
         return this.FPage;
      }
      
      public function get WineLvs() : Vector.<int>
      {
         return this.FWineLvs;
      }
      
      public function get PayConfigsVect() : Object
      {
         return this.FPayConfigsVect;
      }
      
      public function get VipsVect() : Object
      {
         return this.FVipsVect;
      }
      
      public function get Preview() : uint
      {
         return this.FPreview;
      }
      
      public function get Tips() : String
      {
         return this.FTips;
      }
      
      public function get IsTavern() : uint
      {
         return this.FIsTavern;
      }
      
      public function get IsViolent() : uint
      {
         return this.FIsViolent;
      }
      
      public function get WineLv() : String
      {
         return this.FWineLv;
      }
      
      public function get PayConfigs() : String
      {
         return this.FPayConfigs;
      }
      
      public function get Vips() : String
      {
         return this.FVips;
      }
   }
}

