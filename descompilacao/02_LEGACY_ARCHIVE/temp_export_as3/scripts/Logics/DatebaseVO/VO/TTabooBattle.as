package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TDailyTaskReward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TTabooBattle extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FBossName:String;
      
      protected var FLocation:int;
      
      protected var FSStage:int;
      
      protected var FLevelLimit:int;
      
      protected var FMode:int;
      
      protected var FArmyid:int;
      
      protected var FImage:int;
      
      protected var FBaseAward:String;
      
      protected var FSeniorAward:String;
      
      protected var FClearanceAward:String;
      
      protected var FGeneralAward:String;
      
      protected var FPieceAward:String;
      
      protected var FBaseRewardsVect:Vector.<TDailyTaskReward>;
      
      protected var FGeneralRewardsVect:Vector.<TDailyTaskReward>;
      
      protected var FPieceRewardsVect:Vector.<TDailyTaskReward>;
      
      protected var FGaoJiRewardsVect:Vector.<TDailyTaskReward>;
      
      protected var FClearanceRewardsVect:Vector.<TDailyTaskReward>;
      
      protected var FCurNanDu:int;
      
      protected var FNextMode:int;
      
      public function TTabooBattle()
      {
         super();
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FBossName);
         param1.writeUnsignedInt(this.FLocation);
         param1.writeUnsignedInt(this.FSStage);
         param1.writeUnsignedInt(this.FLevelLimit);
         param1.writeUnsignedInt(this.FMode);
         param1.writeUnsignedInt(this.FArmyid);
         param1.writeUnsignedInt(this.FImage);
         TUtilityString.FlushUTF(param1,this.FBaseAward);
         TUtilityString.FlushUTF(param1,this.FSeniorAward);
         TUtilityString.FlushUTF(param1,this.FClearanceAward);
         param1.writeUnsignedInt(this.FNextMode);
         TUtilityString.FlushUTF(param1,this.FGeneralAward);
         TUtilityString.FlushUTF(param1,this.FPieceAward);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:TDailyTaskReward = null;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FBossName = TUtilityString.FetchUTF(param1);
         this.FLocation = param1.readUnsignedInt();
         this.FSStage = param1.readUnsignedInt();
         this.FLevelLimit = param1.readUnsignedInt();
         this.FMode = param1.readUnsignedInt();
         this.FArmyid = param1.readUnsignedInt();
         this.FImage = param1.readUnsignedInt();
         this.FBaseAward = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FBaseAward);
         _loc4_ = _loc3_ as Array;
         _loc2_ = int(_loc4_.length);
         this.FBaseRewardsVect = new Vector.<TDailyTaskReward>(_loc2_);
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = new TDailyTaskReward(_loc4_[_loc6_]);
            this.FBaseRewardsVect[_loc6_] = _loc5_;
            _loc6_++;
         }
         this.FSeniorAward = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FSeniorAward);
         _loc4_ = _loc3_ as Array;
         _loc2_ = int(_loc4_.length);
         this.FGaoJiRewardsVect = new Vector.<TDailyTaskReward>(_loc2_);
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = new TDailyTaskReward(_loc4_[_loc6_]["value"][0]);
            this.FGaoJiRewardsVect[_loc6_] = _loc5_;
            _loc6_++;
         }
         this.FClearanceAward = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FClearanceAward);
         _loc4_ = _loc3_ as Array;
         _loc2_ = int(_loc4_.length);
         this.FClearanceRewardsVect = new Vector.<TDailyTaskReward>(_loc2_);
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = new TDailyTaskReward(_loc4_[_loc6_]);
            this.FClearanceRewardsVect[_loc6_] = _loc5_;
            _loc6_++;
         }
         this.FNextMode = param1.readUnsignedInt();
         this.FGeneralAward = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FGeneralAward);
         _loc4_ = _loc3_ as Array;
         _loc2_ = int(_loc4_.length);
         this.FGeneralRewardsVect = new Vector.<TDailyTaskReward>(_loc2_);
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = new TDailyTaskReward(_loc4_[_loc6_]["value"][0]);
            this.FGeneralRewardsVect[_loc6_] = _loc5_;
            _loc6_++;
         }
         this.FPieceAward = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FPieceAward);
         _loc4_ = _loc3_ as Array;
         _loc2_ = int(_loc4_.length);
         this.FPieceRewardsVect = new Vector.<TDailyTaskReward>(_loc2_);
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = new TDailyTaskReward(_loc4_[_loc6_]["value"][0]);
            this.FPieceRewardsVect[_loc6_] = _loc5_;
            _loc6_++;
         }
      }
      
      public function get PieceRewardsVect() : Vector.<TDailyTaskReward>
      {
         return this.FPieceRewardsVect;
      }
      
      public function get GeneralRewardsVect() : Vector.<TDailyTaskReward>
      {
         return this.FGeneralRewardsVect;
      }
      
      public function get BaseRewardsVect() : Vector.<TDailyTaskReward>
      {
         return this.FBaseRewardsVect;
      }
      
      public function get GaoJiRewardsVect() : Vector.<TDailyTaskReward>
      {
         return this.FGaoJiRewardsVect;
      }
      
      public function get ClearanceRewardsVect() : Vector.<TDailyTaskReward>
      {
         return this.FClearanceRewardsVect;
      }
      
      public function get NextMode() : int
      {
         return this.FNextMode;
      }
      
      public function get ClearanceAward() : String
      {
         return this.FClearanceAward;
      }
      
      public function get GeneralAward() : String
      {
         return this.FGeneralAward;
      }
      
      public function get PieceAward() : String
      {
         return this.FPieceAward;
      }
      
      public function get SeniorAward() : String
      {
         return this.FSeniorAward;
      }
      
      public function get BaseAward() : String
      {
         return this.FBaseAward;
      }
      
      public function get Image() : int
      {
         return this.FImage;
      }
      
      public function get Armyid() : int
      {
         return this.FArmyid;
      }
      
      public function get Mode() : int
      {
         return this.FMode;
      }
      
      public function get LevelLimit() : int
      {
         return this.FLevelLimit;
      }
      
      public function get SStage() : int
      {
         return this.FSStage;
      }
      
      public function get Location() : int
      {
         return this.FLocation;
      }
      
      public function get BossName() : String
      {
         return this.FBossName;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set CurNanDu(param1:int) : void
      {
         this.FCurNanDu = param1;
      }
      
      public function get CurNanDu() : int
      {
         return this.FCurNanDu;
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

