package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.MasterRoad.TMasterRoad;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_MASTERROAD;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TMasterRoadMall extends TDatebaseVO
   {
      
      public var venueCondition:String;
      
      public var dailyLimit:String;
      
      public var consume:int;
      
      public var itemid:String;
      
      public var sort:int;
      
      public var type:int;
      
      public var Items:TInventories;
      
      public var FMasterRoad:TMasterRoad;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FMasterRoadVenueBins:TBins;
      
      public function TMasterRoadMall()
      {
         super();
         this.FMasterRoad = SLogicsCore.MasterRoad;
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
         TUtilityString.FlushUTF(param1,this.venueCondition);
         TUtilityString.FlushUTF(param1,this.dailyLimit);
         param1.writeUnsignedInt(this.consume);
         TUtilityString.FlushUTF(param1,this.itemid);
         param1.writeUnsignedInt(this.sort);
         param1.writeUnsignedInt(this.type);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.venueCondition = TUtilityString.FetchUTF(param1);
         this.dailyLimit = TUtilityString.FetchUTF(param1);
         this.consume = param1.readUnsignedInt();
         this.itemid = TUtilityString.FetchUTF(param1);
         this.sort = param1.readUnsignedInt();
         this.type = param1.readUnsignedInt();
      }
      
      public function get Inventories() : TInventories
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         var _loc4_:Vector.<uint> = null;
         var _loc5_:Vector.<uint> = null;
         var _loc6_:Array = null;
         if(!this.Items)
         {
            _loc4_ = new Vector.<uint>();
            _loc5_ = new Vector.<uint>();
            this.Items = new TInventories();
            _loc6_ = Json.decode(this.itemid);
            _loc4_.push(_loc6_[0]);
            _loc5_.push(_loc6_[1]);
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.Items,_loc4_);
            _loc3_ = this.Items.GetInventoryByIndex(0);
            _loc3_.Quantity = _loc5_[0];
         }
         return this.Items;
      }
      
      public function get Desc() : String
      {
         if(this.VenueName == "")
         {
            return "";
         }
         return TUtilityString.Format(new ConsumeFrameCopy(STRING_MASTERROAD.STRING_007).DescribeString,this.VenueName,this.VenueCount);
      }
      
      public function get VenueName() : String
      {
         var _loc1_:Array = null;
         var _loc2_:TMasterRoadVenue = null;
         if(!this.FMasterRoadVenueBins)
         {
            this.FMasterRoadVenueBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_MasterRoadVenue);
         }
         _loc1_ = Json.decode(this.venueCondition);
         if(_loc1_[0] != 0)
         {
            _loc2_ = this.FMasterRoadVenueBins.GetDatebaseByIdentifier(_loc1_[0]) as TMasterRoadVenue;
            return _loc2_.name;
         }
         return "";
      }
      
      public function get VenueCount() : int
      {
         var _loc1_:Array = null;
         var _loc2_:TMasterRoadVenue = null;
         if(!this.FMasterRoadVenueBins)
         {
            this.FMasterRoadVenueBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_MasterRoadVenue);
         }
         _loc1_ = Json.decode(this.venueCondition);
         return _loc1_[1];
      }
      
      public function get Status() : int
      {
         var _loc1_:Array = null;
         var _loc2_:TMasterRoadVenue = null;
         if(!this.FMasterRoadVenueBins)
         {
            this.FMasterRoadVenueBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_MasterRoadVenue);
         }
         _loc1_ = Json.decode(this.venueCondition);
         if(this.FMasterRoad.GetVenuePointByIdentify(_loc1_[0]) >= _loc1_[1])
         {
            return TBaseActivity.STATUS_CANGET;
         }
         return TBaseActivity.STATUS_CANNOTGET;
      }
   }
}

