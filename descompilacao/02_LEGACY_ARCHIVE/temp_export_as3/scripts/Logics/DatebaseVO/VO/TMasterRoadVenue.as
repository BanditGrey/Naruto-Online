package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TMasterRoadVenue extends TDatebaseVO
   {
      
      public var name:String;
      
      public var allAchievePoint:int;
      
      public var includeFunction:String;
      
      public var medal:String;
      
      public var medalImage:int;
      
      public var addAttribute:String;
      
      public var CurPoint:int;
      
      public var Status:int;
      
      public var ActiveTime:int;
      
      public var battleFunction:String;
      
      public var MedalAttribute:Array;
      
      public var EventList:Vector.<TMasterRoadEvent>;
      
      public var BattleList:Vector.<TMasterRoadBattle>;
      
      public var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TMasterRoadVenue()
      {
         super();
         this.EventList = new Vector.<TMasterRoadEvent>();
         this.BattleList = new Vector.<TMasterRoadBattle>();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
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
               _loc3_ = _loc3_;
               if(hasOwnProperty(_loc3_))
               {
                  this[_loc3_] = _loc4_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc3_.slice(1,2)) < 0)
                  {
                     _loc3_ = _loc3_.slice(1,2).toLocaleUpperCase() + _loc3_.slice(2);
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
         TUtilityString.FlushUTF(param1,this.name);
         param1.writeUnsignedInt(this.allAchievePoint);
         TUtilityString.FlushUTF(param1,this.includeFunction);
         TUtilityString.FlushUTF(param1,this.medal);
         param1.writeUnsignedInt(this.medalImage);
         TUtilityString.FlushUTF(param1,this.addAttribute);
         TUtilityString.FlushUTF(param1,this.battleFunction);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.name = TUtilityString.FetchUTF(param1);
         this.allAchievePoint = param1.readUnsignedInt();
         this.includeFunction = TUtilityString.FetchUTF(param1);
         this.medal = TUtilityString.FetchUTF(param1);
         this.medalImage = param1.readUnsignedInt();
         this.addAttribute = TUtilityString.FetchUTF(param1);
         this.MedalAttribute = Json.decode(this.addAttribute);
         this.battleFunction = TUtilityString.FetchUTF(param1);
      }
      
      public function get TotalType() : int
      {
         var _loc1_:Array = null;
         _loc1_ = Json.decode(this.includeFunction);
         return _loc1_.length;
      }
      
      public function get TotalBattleType() : int
      {
         var _loc1_:Array = null;
         _loc1_ = Json.decode(this.battleFunction);
         return _loc1_.length;
      }
      
      public function GetBattleByID(param1:int) : TMasterRoadBattle
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.BattleList.length)
         {
            if(this.BattleList[_loc2_].Identifier == param1)
            {
               return this.BattleList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function Sort() : void
      {
         this.EventList.sort(this.SortStatus);
      }
      
      protected function SortStatus(param1:TMasterRoadEvent, param2:TMasterRoadEvent) : int
      {
         if(param1.Status > param2.Status)
         {
            return -1;
         }
         if(param1.Status < param2.Status)
         {
            return 1;
         }
         return 0;
      }
   }
}

