package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TDailyTaskReward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TDungeonsPractise extends TDatebaseVO
   {
      
      protected var FCampaignName:String;
      
      protected var FNeedStageId:uint;
      
      protected var FLevelRange:String;
      
      protected var FLevelRangeArr:Array;
      
      protected var FRandomAward:String;
      
      protected var FPractiseMaxTime:uint;
      
      protected var FDropDesc:String;
      
      protected var FRandomAwardVect:Vector.<TDailyTaskReward>;
      
      public function TDungeonsPractise()
      {
         super();
      }
      
      public function get RandomAwardVect() : Vector.<TDailyTaskReward>
      {
         return this.FRandomAwardVect;
      }
      
      public function get CampaignName() : String
      {
         return this.FCampaignName;
      }
      
      public function get NeedStageId() : uint
      {
         return this.FNeedStageId;
      }
      
      public function get LevelRangeArr() : Array
      {
         return this.FLevelRangeArr;
      }
      
      public function get LevelRange() : String
      {
         return this.FLevelRange;
      }
      
      public function get RandomAward() : String
      {
         return this.FRandomAward;
      }
      
      public function get PractiseMaxTime() : uint
      {
         return this.FPractiseMaxTime;
      }
      
      public function get DropDesc() : String
      {
         return this.FDropDesc;
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FCampaignName);
         param1.writeUnsignedInt(this.FNeedStageId);
         TUtilityString.FlushUTF(param1,this.FLevelRange);
         TUtilityString.FlushUTF(param1,this.FRandomAward);
         param1.writeUnsignedInt(this.FPractiseMaxTime);
         TUtilityString.FlushUTF(param1,this.FDropDesc);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:TDailyTaskReward = null;
         this.FCampaignName = TUtilityString.FetchUTF(param1);
         this.FNeedStageId = param1.readUnsignedInt();
         this.FLevelRange = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FLevelRange);
         this.FLevelRangeArr = _loc2_ as Array;
         this.FRandomAward = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FRandomAward);
         _loc5_ = _loc2_ as Array;
         _loc4_ = int(_loc5_.length);
         this.FRandomAwardVect = new Vector.<TDailyTaskReward>(_loc4_);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = new TDailyTaskReward(_loc5_[_loc3_]["value"][0]);
            this.FRandomAwardVect[_loc3_] = _loc6_;
            _loc3_++;
         }
         this.FPractiseMaxTime = param1.readUnsignedInt();
         this.FDropDesc = TUtilityString.FetchUTF(param1);
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

