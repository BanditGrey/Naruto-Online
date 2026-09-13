package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TWorldCupVo1 extends TDatebaseVO
   {
      
      public var name:String;
      
      public var flag:int;
      
      public var odds:int;
      
      public var min:int;
      
      public var max:int;
      
      public var starttime:String;
      
      public var endtime:String;
      
      public var deadline:String;
      
      public var group:String;
      
      public function TWorldCupVo1()
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
         TUtilityString.FlushUTF(param1,this.name);
         param1.writeUnsignedInt(this.flag);
         param1.writeUnsignedInt(this.odds);
         param1.writeUnsignedInt(this.min);
         param1.writeUnsignedInt(this.max);
         TUtilityString.FlushUTF(param1,this.starttime);
         TUtilityString.FlushUTF(param1,this.endtime);
         TUtilityString.FlushUTF(param1,this.deadline);
         TUtilityString.FlushUTF(param1,this.group);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.name = TUtilityString.FetchUTF(param1);
         this.flag = param1.readUnsignedInt();
         this.odds = param1.readUnsignedInt();
         this.min = param1.readUnsignedInt();
         this.max = param1.readUnsignedInt();
         this.starttime = TUtilityString.FetchUTF(param1);
         this.endtime = TUtilityString.FetchUTF(param1);
         this.deadline = TUtilityString.FetchUTF(param1);
         this.group = TUtilityString.FetchUTF(param1);
      }
   }
}

