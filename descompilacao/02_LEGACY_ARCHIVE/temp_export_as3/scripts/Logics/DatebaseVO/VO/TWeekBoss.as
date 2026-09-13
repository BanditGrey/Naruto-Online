package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TWeekBoss extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FStageName:String;
      
      protected var FArmyid:int;
      
      protected var FAward:String;
      
      protected var FAwardArr:Array;
      
      protected var FSpecialaward:String;
      
      protected var FSpecialawardArr:Array;
      
      protected var FModel:int;
      
      protected var FChallengeTimes:int;
      
      protected var FHeroid:int;
      
      protected var FDescription:String;
      
      public var Status:int;
      
      public var SpecialStatus:int;
      
      public var BattleStatus:int;
      
      public var LimitCount:int;
      
      public var BuyCount:int;
      
      public function TWeekBoss()
      {
         super();
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FStageName = TUtilityString.FetchUTF(param1);
         this.FArmyid = param1.readInt();
         this.FAward = TUtilityString.FetchUTF(param1);
         this.FAwardArr = Json.decode(this.FAward);
         this.FSpecialaward = TUtilityString.FetchUTF(param1);
         this.FSpecialawardArr = Json.decode(this.FSpecialaward);
         this.FModel = param1.readInt();
         this.FChallengeTimes = param1.readInt();
         this.FHeroid = param1.readInt();
         this.FDescription = TUtilityString.FetchUTF(param1);
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FStageName);
         param1.writeInt(this.FArmyid);
         TUtilityString.FlushUTF(param1,this.FAward);
         TUtilityString.FlushUTF(param1,this.FSpecialaward);
         param1.writeInt(this.FModel);
         param1.writeInt(this.FChallengeTimes);
         param1.writeInt(this.FHeroid);
         TUtilityString.FlushUTF(param1,this.FDescription);
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
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get StageName() : String
      {
         return this.FStageName;
      }
      
      public function get Armyid() : int
      {
         return this.FArmyid;
      }
      
      public function get Award() : String
      {
         return this.FAward;
      }
      
      public function get AwardArr() : Array
      {
         return this.FAwardArr;
      }
      
      public function get Specialaward() : String
      {
         return this.FSpecialaward;
      }
      
      public function get SpecialawardArr() : Array
      {
         return this.FSpecialawardArr;
      }
      
      public function get ChallengeTimes() : int
      {
         return this.FChallengeTimes;
      }
      
      public function get Model() : int
      {
         return this.FModel;
      }
      
      public function get HeroId() : int
      {
         return this.FHeroid;
      }
      
      public function get Description() : String
      {
         return this.FDescription;
      }
   }
}

