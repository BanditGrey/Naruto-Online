package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.*;
   import flash.utils.*;
   
   use namespace ResourcesSpace;
   
   public class TNightPowerConfig extends TDatebaseVO
   {
      
      protected var FLevel:int;
      
      protected var FResource:int;
      
      protected var FExp:int;
      
      protected var FAllExp:int;
      
      protected var FDeduction:int;
      
      protected var FDailyReward:int;
      
      protected var FDesLevelup:String;
      
      protected var FDesPrivilege:String;
      
      protected var FDesReward:String;
      
      public function TNightPowerConfig()
      {
         super();
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FResource);
         param1.writeUnsignedInt(this.FExp);
         param1.writeUnsignedInt(this.FAllExp);
         param1.writeUnsignedInt(this.FDeduction);
         param1.writeUnsignedInt(this.FDailyReward);
         TUtilityString.FlushUTF(param1,this.FDesLevelup);
         TUtilityString.FlushUTF(param1,this.FDesPrivilege);
         TUtilityString.FlushUTF(param1,this.FDesReward);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FLevel = param1.readUnsignedInt();
         this.FResource = param1.readUnsignedInt();
         this.FExp = param1.readUnsignedInt();
         this.FAllExp = param1.readUnsignedInt();
         this.FDeduction = param1.readUnsignedInt();
         this.FDailyReward = param1.readUnsignedInt();
         this.FDesLevelup = TUtilityString.FetchUTF(param1);
         this.FDesPrivilege = TUtilityString.FetchUTF(param1);
         this.FDesReward = TUtilityString.FetchUTF(param1);
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
      
      public function get Level() : int
      {
         return this.FLevel;
      }
      
      public function get Resource() : int
      {
         return this.FResource;
      }
      
      public function get Exp() : int
      {
         return this.FExp;
      }
      
      public function get AllExp() : int
      {
         return this.FAllExp;
      }
      
      public function get Deduction() : int
      {
         return this.FDeduction;
      }
      
      public function get DailyReward() : int
      {
         return this.FDailyReward;
      }
      
      public function get DesLevelup() : String
      {
         return this.FDesLevelup;
      }
      
      public function get DesPrivilege() : String
      {
         return this.FDesPrivilege;
      }
      
      public function get DesReward() : String
      {
         return this.FDesReward;
      }
   }
}

