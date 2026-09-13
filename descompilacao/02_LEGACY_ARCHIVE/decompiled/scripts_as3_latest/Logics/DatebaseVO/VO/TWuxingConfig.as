package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TWuxingAttribute;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TWuxingConfig extends TDatebaseVO
   {
      
      protected var FType:uint;
      
      protected var FLevel:uint;
      
      protected var FEnemylevel:uint;
      
      protected var FXiangke:String;
      
      protected var FFanxiangke:String;
      
      protected var FXiangsheng:String;
      
      protected var FXiangkeArr:Vector.<TWuxingAttribute>;
      
      protected var FFanxiangkeArr:Vector.<TWuxingAttribute>;
      
      protected var FXiangshengArr:Vector.<TWuxingAttribute>;
      
      public function TWuxingConfig()
      {
         super();
         this.FXiangkeArr = new Vector.<TWuxingAttribute>();
         this.FFanxiangkeArr = new Vector.<TWuxingAttribute>();
         this.FXiangshengArr = new Vector.<TWuxingAttribute>();
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
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FEnemylevel);
         TUtilityString.FlushUTF(param1,this.FXiangke);
         TUtilityString.FlushUTF(param1,this.FFanxiangke);
         TUtilityString.FlushUTF(param1,this.FXiangsheng);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:TWuxingAttribute = null;
         var _loc5_:int = 0;
         this.FType = param1.readUnsignedInt();
         this.FLevel = param1.readUnsignedInt();
         this.FEnemylevel = param1.readUnsignedInt();
         this.FXiangke = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FXiangke);
         _loc5_ = int(_loc2_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc4_ = new TWuxingAttribute(_loc2_[_loc3_]);
            this.FXiangkeArr[_loc3_] = _loc4_;
            _loc3_++;
         }
         this.FFanxiangke = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FFanxiangke);
         _loc5_ = int(_loc2_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc4_ = new TWuxingAttribute(_loc2_[_loc3_]);
            this.FFanxiangkeArr[_loc3_] = _loc4_;
            _loc3_++;
         }
         this.FXiangsheng = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FXiangsheng);
         _loc5_ = int(_loc2_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc4_ = new TWuxingAttribute(_loc2_[_loc3_]);
            this.FXiangshengArr[_loc3_] = _loc4_;
            _loc3_++;
         }
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function get Enemylevel() : uint
      {
         return this.FEnemylevel;
      }
      
      public function get Xiangke() : String
      {
         return this.FXiangke;
      }
      
      public function get XiangkeArr() : Vector.<TWuxingAttribute>
      {
         return this.FXiangkeArr;
      }
      
      public function get Fanxiangke() : String
      {
         return this.FFanxiangke;
      }
      
      public function get FanxiangkeArr() : Vector.<TWuxingAttribute>
      {
         return this.FFanxiangkeArr;
      }
      
      public function get Xiangsheng() : String
      {
         return this.FXiangsheng;
      }
      
      public function get XiangshengArr() : Vector.<TWuxingAttribute>
      {
         return this.FXiangshengArr;
      }
   }
}

