package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TDailyTaskReward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TDailyTask extends TDatebaseVO
   {
      
      protected var FType:int;
      
      protected var FEventType:int;
      
      protected var FRewardVect:Vector.<TDailyTaskReward>;
      
      protected var FSmallpicture:int;
      
      protected var FPoint:int;
      
      protected var FCancel:int;
      
      protected var FTaskname:String;
      
      protected var FRate:int;
      
      protected var FIsgoto:int;
      
      protected var FInstantVect:Vector.<TDailyTaskReward>;
      
      protected var FComplete:int;
      
      protected var FDescription:String;
      
      protected var FRewards:String;
      
      protected var FInstant:String;
      
      public function TDailyTask()
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
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FEventType);
         TUtilityString.FlushUTF(param1,this.FRewards);
         param1.writeUnsignedInt(this.FSmallpicture);
         param1.writeUnsignedInt(this.FPoint);
         param1.writeUnsignedInt(this.FCancel);
         TUtilityString.FlushUTF(param1,this.FTaskname);
         param1.writeUnsignedInt(this.FRate);
         param1.writeUnsignedInt(this.FIsgoto);
         TUtilityString.FlushUTF(param1,this.FInstant);
         param1.writeUnsignedInt(this.FComplete);
         TUtilityString.FlushUTF(param1,this.FDescription);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:TDailyTaskReward = null;
         this.FType = param1.readUnsignedInt();
         this.FEventType = param1.readUnsignedInt();
         this.FRewards = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(this.FRewards);
         _loc7_ = _loc4_ as Array;
         _loc3_ = int(_loc7_.length);
         this.FRewardVect = new Vector.<TDailyTaskReward>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc8_ = new TDailyTaskReward(_loc7_[_loc2_]);
            this.FRewardVect[_loc2_] = _loc8_;
            _loc2_++;
         }
         this.FSmallpicture = param1.readUnsignedInt();
         this.FPoint = param1.readUnsignedInt();
         this.FCancel = param1.readUnsignedInt();
         this.FTaskname = TUtilityString.FetchUTF(param1);
         this.FRate = param1.readUnsignedInt();
         this.FIsgoto = param1.readUnsignedInt();
         this.FInstant = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(this.FInstant);
         _loc7_ = _loc4_ as Array;
         _loc3_ = int(_loc7_.length);
         this.FInstantVect = new Vector.<TDailyTaskReward>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc8_ = new TDailyTaskReward(_loc7_[_loc2_]);
            this.FInstantVect[_loc2_] = _loc8_;
            _loc2_++;
         }
         this.FComplete = param1.readUnsignedInt();
         this.FDescription = TUtilityString.FetchUTF(param1);
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function get EventType() : int
      {
         return this.FEventType;
      }
      
      public function get RewardVect() : Vector.<TDailyTaskReward>
      {
         return this.FRewardVect;
      }
      
      public function get Smallpicture() : int
      {
         return this.FSmallpicture;
      }
      
      public function get Point() : int
      {
         return this.FPoint;
      }
      
      public function get Cancel() : int
      {
         return this.FCancel;
      }
      
      public function get Taskname() : String
      {
         return this.FTaskname;
      }
      
      public function get Rate() : int
      {
         return this.FRate;
      }
      
      public function get Isgoto() : int
      {
         return this.FIsgoto;
      }
      
      public function get InstantVect() : Vector.<TDailyTaskReward>
      {
         return this.FInstantVect;
      }
      
      public function get Complete() : int
      {
         return this.FComplete;
      }
      
      public function get Description() : String
      {
         return this.FDescription;
      }
      
      public function get Rewards() : String
      {
         return this.FRewards;
      }
      
      public function get Instant() : String
      {
         return this.FInstant;
      }
   }
}

