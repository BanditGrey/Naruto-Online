package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TBloodSoul_battle extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FBossName:String;
      
      protected var FNeedLevel:uint;
      
      protected var FLocation:int;
      
      protected var FSStage:int;
      
      protected var FSStageID:int;
      
      protected var FType:int;
      
      protected var FArmyid:int;
      
      protected var FImage:int;
      
      protected var FAward:String;
      
      protected var FShowaward:String;
      
      protected var FStageClear:int;
      
      protected var FAwards:Vector.<TFixedAward>;
      
      protected var FShowawards:Vector.<TFixedAward>;
      
      public function TBloodSoul_battle()
      {
         super();
         this.FAwards = new Vector.<TFixedAward>();
         this.FShowawards = new Vector.<TFixedAward>();
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
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FBossName);
         param1.writeUnsignedInt(this.FNeedLevel);
         param1.writeUnsignedInt(this.FLocation);
         param1.writeUnsignedInt(this.FSStage);
         param1.writeUnsignedInt(this.FSStageID);
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FArmyid);
         param1.writeUnsignedInt(this.FImage);
         TUtilityString.FlushUTF(param1,this.FAward);
         TUtilityString.FlushUTF(param1,this.FShowaward);
         param1.writeUnsignedInt(this.FStageClear);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Array = null;
         var _loc5_:TFixedAward = null;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FBossName = TUtilityString.FetchUTF(param1);
         this.FNeedLevel = param1.readUnsignedInt();
         this.FLocation = param1.readUnsignedInt();
         this.FSStage = param1.readUnsignedInt();
         this.FSStageID = param1.readUnsignedInt();
         this.FType = param1.readUnsignedInt();
         this.FArmyid = param1.readUnsignedInt();
         this.FImage = param1.readUnsignedInt();
         this.FAward = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(this.FAward);
         _loc2_ = _loc4_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = new TFixedAward(_loc4_[_loc3_]);
            this.FAwards[_loc3_] = _loc5_;
            _loc3_++;
         }
         this.FShowaward = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(this.FShowaward);
         _loc2_ = _loc4_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = new TFixedAward(_loc4_[_loc3_]);
            this.FShowawards[_loc3_] = _loc5_;
            _loc3_++;
         }
         this.FStageClear = param1.readUnsignedInt();
      }
      
      public function get StageClear() : int
      {
         return this.FStageClear;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get BossName() : String
      {
         return this.FBossName;
      }
      
      public function get NeedLevel() : int
      {
         return this.FNeedLevel;
      }
      
      public function get Location() : int
      {
         return this.FLocation;
      }
      
      public function get SStage() : int
      {
         return this.FSStage;
      }
      
      public function get SStageID() : int
      {
         return this.FSStageID;
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function get Armyid() : int
      {
         return this.FArmyid;
      }
      
      public function get Image() : int
      {
         return this.FImage;
      }
      
      public function get Showaward() : String
      {
         return this.FShowaward;
      }
      
      public function get Showawards() : Vector.<TFixedAward>
      {
         return this.FShowawards;
      }
      
      public function get Award() : String
      {
         return this.FAward;
      }
      
      public function get Awards() : Vector.<TFixedAward>
      {
         return this.FAwards;
      }
   }
}

