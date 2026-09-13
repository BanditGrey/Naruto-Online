package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TActivityTaskReward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TActivityTask extends TDatebaseVO
   {
      
      protected var FTasktype:int;
      
      protected var FTaskName:String;
      
      protected var FTaskDesc:String;
      
      protected var FTaskReq:String;
      
      protected var FTaskPoint:String;
      
      protected var FTaskAward:String;
      
      protected var FReset:int;
      
      protected var FConsume:int;
      
      protected var FGo:int;
      
      protected var FSwitch:int;
      
      protected var FClientTaskReq:String;
      
      protected var FRequirements:Vector.<int>;
      
      protected var FPoints:Vector.<int>;
      
      protected var FRewards:Vector.<TActivityTaskReward>;
      
      protected var FClientReq:Vector.<int>;
      
      public function TActivityTask()
      {
         super();
         this.FRequirements = new Vector.<int>();
         this.FPoints = new Vector.<int>();
         this.FRewards = new Vector.<TActivityTaskReward>();
         this.FClientReq = new Vector.<int>();
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
         param1.writeUnsignedInt(this.FTasktype);
         TUtilityString.FlushUTF(param1,this.FTaskName);
         TUtilityString.FlushUTF(param1,this.FTaskDesc);
         TUtilityString.FlushUTF(param1,this.FTaskReq);
         TUtilityString.FlushUTF(param1,this.FTaskPoint);
         TUtilityString.FlushUTF(param1,this.FTaskAward);
         param1.writeUnsignedInt(this.FReset);
         param1.writeUnsignedInt(this.FConsume);
         param1.writeUnsignedInt(this.FGo);
         param1.writeUnsignedInt(this.FSwitch);
         TUtilityString.FlushUTF(param1,this.FClientTaskReq);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TActivityTaskReward = null;
         this.FTasktype = param1.readUnsignedInt();
         this.FTaskName = TUtilityString.FetchUTF(param1);
         this.FTaskDesc = TUtilityString.FetchUTF(param1);
         this.FTaskReq = TUtilityString.FetchUTF(param1);
         this.FTaskPoint = TUtilityString.FetchUTF(param1);
         this.FTaskAward = TUtilityString.FetchUTF(param1);
         this.FReset = param1.readUnsignedInt();
         this.FConsume = param1.readUnsignedInt();
         this.FGo = param1.readUnsignedInt();
         this.FSwitch = param1.readUnsignedInt();
         this.FClientTaskReq = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FTaskReq) as Array;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               this.FRequirements[_loc3_] = _loc2_[_loc3_];
               _loc3_++;
            }
         }
         _loc2_ = Json.decode(this.FTaskPoint) as Array;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               this.FPoints[_loc3_] = _loc2_[_loc3_];
               _loc3_++;
            }
         }
         _loc2_ = Json.decode(this.FTaskAward) as Array;
         _loc4_ = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = new TActivityTaskReward(_loc2_[_loc3_]);
            this.FRewards[_loc3_] = _loc5_;
            _loc3_++;
         }
         _loc2_ = Json.decode(this.FClientTaskReq) as Array;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               this.FClientReq[_loc3_] = _loc2_[_loc3_];
               _loc3_++;
            }
         }
      }
      
      public function get Tasktype() : int
      {
         return this.FTasktype;
      }
      
      public function get TaskName() : String
      {
         return this.FTaskName;
      }
      
      public function get TaskDesc() : String
      {
         return this.FTaskDesc;
      }
      
      public function get TaskReq() : String
      {
         return this.FTaskReq;
      }
      
      public function get TaskPoint() : String
      {
         return this.FTaskPoint;
      }
      
      public function get TaskAward() : String
      {
         return this.FTaskAward;
      }
      
      public function get Reset() : int
      {
         return this.FReset;
      }
      
      public function get Consume() : int
      {
         return this.FConsume;
      }
      
      public function get Go() : int
      {
         return this.FGo;
      }
      
      public function get Switch() : int
      {
         return this.FSwitch;
      }
      
      public function get Requirements() : Vector.<int>
      {
         return this.FRequirements;
      }
      
      public function get Points() : Vector.<int>
      {
         return this.FPoints;
      }
      
      public function get Rewards() : Vector.<TActivityTaskReward>
      {
         return this.FRewards;
      }
      
      public function get ClientTaskReq() : String
      {
         return this.FClientTaskReq;
      }
      
      public function get ClientReq() : Vector.<int>
      {
         return this.FClientReq;
      }
   }
}

