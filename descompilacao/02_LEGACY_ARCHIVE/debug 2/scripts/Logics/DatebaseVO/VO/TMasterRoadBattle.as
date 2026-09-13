package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TMasterRoadBattle extends TDatebaseVO
   {
      
      public var theVenue:int;
      
      public var theFunction:int;
      
      public var name:String;
      
      public var stageName:String;
      
      public var title:String;
      
      public var needLevel:int;
      
      public var sStageID:int;
      
      public var armyid:int;
      
      public var model:int;
      
      public var award:String;
      
      public var achievementReward:int;
      
      public var challengeTimes:int;
      
      public var description:String;
      
      public var battleCondition:String;
      
      public var LimitCount:int;
      
      public var Status:int;
      
      public var Price:int;
      
      public var BattleStatus:int;
      
      public var Inventories:TInventories;
      
      public var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TMasterRoadBattle()
      {
         super();
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
         param1.writeUnsignedInt(this.theVenue);
         param1.writeUnsignedInt(this.theFunction);
         TUtilityString.FlushUTF(param1,this.name);
         TUtilityString.FlushUTF(param1,this.stageName);
         TUtilityString.FlushUTF(param1,this.title);
         param1.writeUnsignedInt(this.needLevel);
         param1.writeUnsignedInt(this.sStageID);
         param1.writeUnsignedInt(this.armyid);
         param1.writeUnsignedInt(this.model);
         TUtilityString.FlushUTF(param1,this.award);
         param1.writeUnsignedInt(this.achievementReward);
         param1.writeUnsignedInt(this.challengeTimes);
         TUtilityString.FlushUTF(param1,this.description);
         TUtilityString.FlushUTF(param1,this.battleCondition);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.theVenue = param1.readUnsignedInt();
         this.theFunction = param1.readUnsignedInt();
         this.name = TUtilityString.FetchUTF(param1);
         this.stageName = TUtilityString.FetchUTF(param1);
         this.title = TUtilityString.FetchUTF(param1);
         this.needLevel = param1.readUnsignedInt();
         this.sStageID = param1.readUnsignedInt();
         this.armyid = param1.readUnsignedInt();
         this.model = param1.readUnsignedInt();
         this.award = TUtilityString.FetchUTF(param1);
         this.achievementReward = param1.readUnsignedInt();
         this.challengeTimes = param1.readUnsignedInt();
         this.description = TUtilityString.FetchUTF(param1);
         this.battleCondition = TUtilityString.FetchUTF(param1);
      }
      
      public function get AwardItems() : TInventories
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         var _loc4_:Vector.<uint> = null;
         var _loc5_:Vector.<uint> = null;
         var _loc6_:Array = null;
         var _loc7_:Object = null;
         if(!this.Inventories)
         {
            _loc4_ = new Vector.<uint>();
            _loc5_ = new Vector.<uint>();
            this.Inventories = new TInventories();
            _loc6_ = Json.decode(this.award);
            _loc2_ = int(_loc6_.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               if(_loc6_[_loc1_].type == 23)
               {
                  _loc4_.push(14107166);
               }
               else
               {
                  _loc4_.push(_loc6_[_loc1_].code);
               }
               _loc5_.push(_loc6_[_loc1_].amount);
               _loc1_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.Inventories,_loc4_);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.Inventories.GetInventoryByIndex(_loc1_);
               _loc3_.Quantity = _loc5_[_loc1_];
               _loc1_++;
            }
         }
         return this.Inventories;
      }
      
      public function Command(param1:int) : String
      {
         var _loc2_:Array = null;
         return _loc2_[param1];
      }
   }
}

