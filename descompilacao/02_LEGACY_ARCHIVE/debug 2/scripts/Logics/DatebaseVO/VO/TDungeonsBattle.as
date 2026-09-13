package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TDailyTaskReward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TDungeonsBattle extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FBossName:String;
      
      protected var FLocation:uint;
      
      protected var FSStage:uint;
      
      protected var FLevelLimit:uint;
      
      protected var FArmyid:uint;
      
      protected var FImage:uint;
      
      protected var FBaseAward:String;
      
      protected var FRandomAward:String;
      
      protected var FRandomAward2:String;
      
      protected var FDescription:String;
      
      protected var FDisplay:int;
      
      protected var FFirstOccupationAward:String;
      
      protected var FBaseAwardVect:Vector.<TDailyTaskReward>;
      
      protected var FRandomAwardVect:Vector.<TDailyTaskReward>;
      
      protected var FRandomAward2Vect:Vector.<TDailyTaskReward>;
      
      protected var FFirstOccupationAwardVect:Vector.<TDailyTaskReward>;
      
      public function TDungeonsBattle()
      {
         super();
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FBossName);
         TUtilityString.FlushUTF(param1,this.FDescription);
         param1.writeUnsignedInt(this.FLocation);
         param1.writeUnsignedInt(this.FSStage);
         param1.writeUnsignedInt(this.FLevelLimit);
         param1.writeUnsignedInt(this.FArmyid);
         param1.writeUnsignedInt(this.FImage);
         TUtilityString.FlushUTF(param1,this.FBaseAward);
         TUtilityString.FlushUTF(param1,this.FRandomAward);
         TUtilityString.FlushUTF(param1,this.FRandomAward2);
         param1.writeUnsignedInt(this.FDisplay);
         TUtilityString.FlushUTF(param1,this.FFirstOccupationAward);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:TDailyTaskReward = null;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FBossName = TUtilityString.FetchUTF(param1);
         this.FDescription = TUtilityString.FetchUTF(param1);
         this.FLocation = param1.readUnsignedInt();
         this.FSStage = param1.readUnsignedInt();
         this.FLevelLimit = param1.readUnsignedInt();
         this.FArmyid = param1.readUnsignedInt();
         this.FImage = param1.readUnsignedInt();
         this.FBaseAward = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(this.FBaseAward);
         _loc5_ = _loc4_ as Array;
         _loc3_ = int(_loc5_.length);
         this.FBaseAwardVect = new Vector.<TDailyTaskReward>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = new TDailyTaskReward(_loc5_[_loc2_]);
            this.FBaseAwardVect[_loc2_] = _loc6_;
            _loc2_++;
         }
         this.FRandomAward = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(this.FRandomAward);
         _loc5_ = _loc4_ as Array;
         _loc3_ = int(_loc5_.length);
         this.FRandomAwardVect = new Vector.<TDailyTaskReward>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = new TDailyTaskReward(_loc5_[_loc2_]["value"][0]);
            this.FRandomAwardVect[_loc2_] = _loc6_;
            _loc2_++;
         }
         this.FRandomAward2 = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(this.FRandomAward2);
         _loc5_ = _loc4_ as Array;
         _loc3_ = int(_loc5_.length);
         this.FRandomAward2Vect = new Vector.<TDailyTaskReward>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = new TDailyTaskReward(_loc5_[_loc2_]["value"][0]);
            this.FRandomAward2Vect[_loc2_] = _loc6_;
            _loc2_++;
         }
         this.FDisplay = param1.readUnsignedInt();
         this.FFirstOccupationAward = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(this.FFirstOccupationAward);
         _loc5_ = _loc4_ as Array;
         _loc3_ = int(_loc5_.length);
         this.FFirstOccupationAwardVect = new Vector.<TDailyTaskReward>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = new TDailyTaskReward(_loc5_[_loc2_]);
            this.FFirstOccupationAwardVect[_loc2_] = _loc6_;
            _loc2_++;
         }
      }
      
      public function get Display() : int
      {
         return this.FDisplay;
      }
      
      public function get FirstOccupationAward() : String
      {
         return this.FFirstOccupationAward;
      }
      
      public function get FirstOccupationAwardVect() : Vector.<TDailyTaskReward>
      {
         return this.FFirstOccupationAwardVect;
      }
      
      public function get RandomAward2Vect() : Vector.<TDailyTaskReward>
      {
         return this.FRandomAward2Vect;
      }
      
      public function get RandomAwardVect() : Vector.<TDailyTaskReward>
      {
         return this.FRandomAwardVect;
      }
      
      public function get BaseAwardVect() : Vector.<TDailyTaskReward>
      {
         return this.FBaseAwardVect;
      }
      
      public function get Location() : uint
      {
         return this.FLocation;
      }
      
      public function get SStage() : uint
      {
         return this.FSStage;
      }
      
      public function get LevelLimit() : uint
      {
         return this.FLevelLimit;
      }
      
      public function get Armyid() : uint
      {
         return this.FArmyid;
      }
      
      public function get Image() : uint
      {
         return this.FImage;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get BossName() : String
      {
         return this.FBossName;
      }
      
      public function get Description() : String
      {
         return this.FDescription;
      }
      
      public function get BaseAward() : String
      {
         return this.FBaseAward;
      }
      
      public function get RandomAward() : String
      {
         return this.FRandomAward;
      }
      
      public function get RandomAward2() : String
      {
         return this.FRandomAward2;
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

