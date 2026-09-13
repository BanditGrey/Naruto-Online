package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TNinjaVillage extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FCz:String;
      
      protected var FBigType:int;
      
      protected var FSmallType:int;
      
      protected var FDesc1:String;
      
      protected var FDesc2:String;
      
      protected var FDesc3:String;
      
      protected var FDesc4:String;
      
      protected var FActAward:String;
      
      protected var FClientAward:String;
      
      protected var FLvBag:String;
      
      protected var FPrice:int;
      
      protected var FDayTime:String;
      
      protected var FIsOn:int;
      
      protected var FReturnRate:int;
      
      protected var FMaxTime:int;
      
      protected var FReturnGold:int;
      
      protected var FGoldRate:String;
      
      protected var FRegion:String;
      
      protected var FReturnType:int;
      
      protected var FAwardVect:Vector.<uint>;
      
      protected var FLimitLevel:Vector.<uint>;
      
      protected var FGoldRegion:Vector.<uint>;
      
      private var intCZ:int = 0;
      
      public function TNinjaVillage()
      {
         super();
         this.FAwardVect = new Vector.<uint>();
         this.FLimitLevel = new Vector.<uint>();
         this.FGoldRegion = new Vector.<uint>();
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
         param1.writeUnsignedInt(this.FBigType);
         param1.writeUnsignedInt(this.FSmallType);
         TUtilityString.FlushUTF(param1,this.FCz);
         TUtilityString.FlushUTF(param1,this.FDesc1);
         TUtilityString.FlushUTF(param1,this.FDesc2);
         TUtilityString.FlushUTF(param1,this.FDesc3);
         TUtilityString.FlushUTF(param1,this.FDesc4);
         TUtilityString.FlushUTF(param1,this.FActAward);
         TUtilityString.FlushUTF(param1,this.FClientAward);
         TUtilityString.FlushUTF(param1,this.FLvBag);
         param1.writeUnsignedInt(this.FPrice);
         TUtilityString.FlushUTF(param1,this.FDayTime);
         param1.writeUnsignedInt(this.FIsOn);
         param1.writeUnsignedInt(this.FReturnRate);
         param1.writeUnsignedInt(this.FMaxTime);
         param1.writeUnsignedInt(this.FReturnGold);
         TUtilityString.FlushUTF(param1,this.FGoldRate);
         TUtilityString.FlushUTF(param1,this.FRegion);
         param1.writeUnsignedInt(this.FReturnType);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FBigType = param1.readUnsignedInt();
         this.FSmallType = param1.readUnsignedInt();
         this.FCz = TUtilityString.FetchUTF(param1);
         this.FDesc1 = TUtilityString.FetchUTF(param1);
         this.FDesc2 = TUtilityString.FetchUTF(param1);
         this.FDesc3 = TUtilityString.FetchUTF(param1);
         this.FDesc4 = TUtilityString.FetchUTF(param1);
         this.FActAward = TUtilityString.FetchUTF(param1);
         this.FClientAward = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FClientAward) as Array;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               this.FAwardVect[_loc3_] = _loc2_[_loc3_];
               _loc3_++;
            }
         }
         this.FLvBag = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FLvBag) as Array;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               this.FLimitLevel[_loc3_] = _loc2_[_loc3_];
               _loc3_++;
            }
         }
         this.FPrice = param1.readUnsignedInt();
         this.FDayTime = TUtilityString.FetchUTF(param1);
         this.FIsOn = param1.readUnsignedInt();
         this.FReturnRate = param1.readUnsignedInt();
         this.FMaxTime = param1.readUnsignedInt();
         this.FReturnGold = param1.readUnsignedInt();
         this.FGoldRate = TUtilityString.FetchUTF(param1);
         this.FRegion = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FRegion) as Array;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               this.FGoldRegion[_loc3_] = _loc2_[_loc3_];
               _loc3_++;
            }
         }
         this.FReturnType = param1.readUnsignedInt();
         var _loc5_:String = this.FCz.replace("[","").replace("]","");
         this.intCZ = _loc5_ == "" ? 0 : int(_loc5_);
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Cz() : int
      {
         return this.intCZ;
      }
      
      public function get BigType() : int
      {
         return this.FBigType;
      }
      
      public function get SmallType() : int
      {
         return this.FSmallType;
      }
      
      public function get Desc1() : String
      {
         return this.FDesc1;
      }
      
      public function get Desc2() : String
      {
         return this.FDesc2;
      }
      
      public function get Desc3() : String
      {
         return this.FDesc3;
      }
      
      public function get Desc4() : String
      {
         return this.FDesc4;
      }
      
      public function get ActAward() : String
      {
         return this.FActAward;
      }
      
      public function get ClientAward() : String
      {
         return this.FClientAward;
      }
      
      public function get LvBag() : String
      {
         return this.FLvBag;
      }
      
      public function get Price() : int
      {
         return this.FPrice;
      }
      
      public function get DayTime() : String
      {
         return this.FDayTime;
      }
      
      public function get IsOn() : int
      {
         return this.FIsOn;
      }
      
      public function get ReturnRate() : int
      {
         return this.FReturnRate;
      }
      
      public function get MaxTime() : int
      {
         return this.FMaxTime;
      }
      
      public function get ReturnGold() : int
      {
         return this.FReturnGold;
      }
      
      public function get GoldRate() : String
      {
         return this.FGoldRate;
      }
      
      public function get AwardVect() : Vector.<uint>
      {
         return this.FAwardVect;
      }
      
      public function get LimitLevel() : Vector.<uint>
      {
         return this.FLimitLevel;
      }
      
      public function get Region() : String
      {
         return this.FRegion;
      }
      
      public function get GoldRegion() : Vector.<uint>
      {
         return this.FGoldRegion;
      }
      
      public function get ReturnType() : int
      {
         return this.FReturnType;
      }
   }
}

