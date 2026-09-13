package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TDailyTaskReward;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TAwakenExploration extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FType:int;
      
      protected var FSubType:int;
      
      protected var FRound:int;
      
      protected var FCostType:int;
      
      protected var FCost:int;
      
      protected var FGeneralAward:String;
      
      protected var FSeniorAward:String;
      
      protected var FGeneralAwardVect:Vector.<TDailyTaskReward>;
      
      protected var FSeniorAwardVect:Vector.<TDailyTaskReward>;
      
      public function TAwakenExploration()
      {
         super();
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FSubType);
         param1.writeUnsignedInt(this.FRound);
         param1.writeUnsignedInt(this.FCostType);
         param1.writeUnsignedInt(this.FCost);
         TUtilityString.FlushUTF(param1,this.FGeneralAward);
         TUtilityString.FlushUTF(param1,this.FSeniorAward);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:TDailyTaskReward = null;
         var _loc6_:int = 0;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FType = param1.readUnsignedInt();
         this.FSubType = param1.readUnsignedInt();
         this.FRound = param1.readUnsignedInt();
         this.FCostType = param1.readUnsignedInt();
         this.FCost = param1.readUnsignedInt();
         this.FGeneralAward = TUtilityString.FetchUTF(param1);
         this.FSeniorAward = TUtilityString.FetchUTF(param1);
      }
      
      public function get SeniorAward() : String
      {
         return this.FSeniorAward;
      }
      
      public function get GeneralAward() : String
      {
         return this.FGeneralAward;
      }
      
      public function get Cost() : int
      {
         return this.FCost;
      }
      
      public function get CostType() : int
      {
         return this.FCostType;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function get SubType() : int
      {
         return this.FSubType;
      }
      
      public function get Round() : int
      {
         return this.FRound;
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
   }
}

