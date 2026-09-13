package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TNewSpring2018Config2 extends TDatebaseVO
   {
      
      public var id:int;
      
      public var bigType:int;
      
      public var startTime:String;
      
      public var endTime:String;
      
      public var name:String;
      
      public var houduan:String;
      
      public var qianduan:String;
      
      public var orgPrice:String;
      
      public var dadao:String;
      
      public var jifeng:String;
      
      public var photo:String;
      
      public var chongzhi:String;
      
      public function TNewSpring2018Config2()
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
               _loc3_ = _loc3_;
               if(hasOwnProperty(_loc3_))
               {
                  this[_loc3_] = _loc4_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc3_.slice(1,2)) < 0)
                  {
                     _loc3_ = _loc3_.slice(1,2).toLocaleUpperCase() + _loc3_.slice(2);
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
         param1.writeUnsignedInt(this.id);
         param1.writeUnsignedInt(this.bigType);
         TUtilityString.FlushUTF(param1,this.startTime);
         TUtilityString.FlushUTF(param1,this.endTime);
         TUtilityString.FlushUTF(param1,this.name);
         TUtilityString.FlushUTF(param1,this.houduan);
         TUtilityString.FlushUTF(param1,this.qianduan);
         TUtilityString.FlushUTF(param1,this.orgPrice);
         TUtilityString.FlushUTF(param1,this.dadao);
         TUtilityString.FlushUTF(param1,this.jifeng);
         TUtilityString.FlushUTF(param1,this.photo);
         TUtilityString.FlushUTF(param1,this.chongzhi);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.id = param1.readUnsignedInt();
         this.bigType = param1.readUnsignedInt();
         this.startTime = TUtilityString.FetchUTF(param1);
         this.endTime = TUtilityString.FetchUTF(param1);
         this.name = TUtilityString.FetchUTF(param1);
         this.houduan = TUtilityString.FetchUTF(param1);
         this.qianduan = TUtilityString.FetchUTF(param1);
         this.orgPrice = TUtilityString.FetchUTF(param1);
         this.dadao = TUtilityString.FetchUTF(param1);
         this.jifeng = TUtilityString.FetchUTF(param1);
         this.photo = TUtilityString.FetchUTF(param1);
         this.chongzhi = TUtilityString.FetchUTF(param1);
      }
   }
}

