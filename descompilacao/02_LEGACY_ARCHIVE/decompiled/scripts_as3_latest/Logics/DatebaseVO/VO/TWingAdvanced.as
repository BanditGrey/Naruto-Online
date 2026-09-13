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
   
   public class TWingAdvanced extends TDatebaseVO
   {
      
      public var name:String;
      
      public var illusionType:int;
      
      public var description:String;
      
      public var needStage:int;
      
      public var expend:String;
      
      public var addition:String;
      
      public var additionClient:String;
      
      public var duration:int;
      
      public var offset:String;
      
      public var vipLimit:int;
      
      public var activatetime:int;
      
      public var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TWingAdvanced()
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
         TUtilityString.FlushUTF(param1,this.name);
         param1.writeUnsignedInt(this.illusionType);
         TUtilityString.FlushUTF(param1,this.description);
         param1.writeUnsignedInt(this.needStage);
         TUtilityString.FlushUTF(param1,this.expend);
         TUtilityString.FlushUTF(param1,this.addition);
         TUtilityString.FlushUTF(param1,this.additionClient);
         param1.writeUnsignedInt(this.duration);
         TUtilityString.FlushUTF(param1,this.offset);
         param1.writeUnsignedInt(this.vipLimit);
         param1.writeUnsignedInt(this.activatetime);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.name = TUtilityString.FetchUTF(param1);
         this.illusionType = param1.readUnsignedInt();
         this.description = TUtilityString.FetchUTF(param1);
         this.needStage = param1.readUnsignedInt();
         this.expend = TUtilityString.FetchUTF(param1);
         this.addition = TUtilityString.FetchUTF(param1);
         this.additionClient = TUtilityString.FetchUTF(param1);
         this.duration = param1.readUnsignedInt();
         this.offset = TUtilityString.FetchUTF(param1);
         this.vipLimit = param1.readUnsignedInt();
         this.activatetime = param1.readUnsignedInt();
      }
      
      public function get ExpendItems() : TInventories
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         var _loc4_:TInventories = null;
         var _loc5_:Vector.<uint> = null;
         var _loc6_:Vector.<uint> = null;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:Array = null;
         _loc5_ = new Vector.<uint>();
         _loc6_ = new Vector.<uint>();
         _loc7_ = new Vector.<uint>();
         _loc4_ = new TInventories();
         _loc8_ = Json.decode(this.expend);
         _loc2_ = int(_loc8_.length);
         if(_loc8_[0].length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc5_.push(_loc8_[_loc1_][0]);
               _loc6_.push(_loc8_[_loc1_][1]);
               _loc7_.push(_loc8_[_loc1_][2]);
               _loc1_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc4_,_loc5_);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = _loc4_.GetInventoryByIndex(_loc1_);
               _loc3_.Quantity = _loc6_[_loc1_];
               _loc3_.MaxPrice = _loc7_[_loc1_];
               _loc1_++;
            }
            return _loc4_;
         }
         return null;
      }
   }
}

