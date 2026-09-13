package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TFirstRechargeReward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TheFirstRecharge extends TDatebaseVO
   {
      
      public var Fname:String;
      
      public var FbigType:int;
      
      public var FsmallType:int;
      
      public var Fdesc:String;
      
      public var FactAward:String;
      
      public var Frecharge:int;
      
      public var Fprice:int;
      
      public var FisOn:int;
      
      public var FendTime:int;
      
      public var awardList:Vector.<TFirstRechargeReward> = new Vector.<TFirstRechargeReward>();
      
      public function TheFirstRecharge()
      {
         super();
      }
      
      override ResourcesSpace function ReadDataByXml(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc5_:uint = uint(param1.elements().length());
         var _loc6_:int = 0;
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
         TUtilityString.FlushUTF(param1,this.Fname);
         param1.writeUnsignedInt(this.FbigType);
         param1.writeUnsignedInt(this.FsmallType);
         TUtilityString.FlushUTF(param1,this.Fdesc);
         TUtilityString.FlushUTF(param1,this.FactAward);
         param1.writeUnsignedInt(this.Frecharge);
         param1.writeUnsignedInt(this.Fprice);
         param1.writeUnsignedInt(this.FisOn);
         param1.writeUnsignedInt(this.FendTime);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.Fname = TUtilityString.FetchUTF(param1);
         this.FbigType = param1.readUnsignedInt();
         this.FsmallType = param1.readUnsignedInt();
         this.Fdesc = TUtilityString.FetchUTF(param1);
         this.FactAward = TUtilityString.FetchUTF(param1);
         var _loc2_:Array = [];
         try
         {
            _loc2_ = Json.decode(this.FactAward) as Array;
         }
         catch(e:Error)
         {
         }
         var _loc3_:int = int(_loc2_.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this.awardList[_loc4_] = new TFirstRechargeReward(_loc2_[_loc4_]);
            _loc4_++;
         }
         this.Frecharge = param1.readUnsignedInt();
         this.Fprice = param1.readUnsignedInt();
         this.FisOn = param1.readUnsignedInt();
         this.FendTime = param1.readUnsignedInt();
      }
   }
}

