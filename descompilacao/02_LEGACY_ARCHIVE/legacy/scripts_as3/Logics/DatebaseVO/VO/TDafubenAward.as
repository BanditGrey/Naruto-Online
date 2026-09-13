package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TDafubenAward extends TDatebaseVO
   {
      
      protected var FAwardid:int;
      
      protected var FChaptername:String;
      
      protected var FAward:String;
      
      protected var FAwardArr:Array;
      
      protected var FNeed:int;
      
      protected var FStardec:String;
      
      protected var FNeedstar:int;
      
      protected var FDec:String;
      
      protected var FLevel:int;
      
      public var AwardList:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TDafubenAward()
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
         param1.writeUnsignedInt(this.FAwardid);
         TUtilityString.FlushUTF(param1,this.FChaptername);
         TUtilityString.FlushUTF(param1,this.FAward);
         param1.writeUnsignedInt(this.FNeedstar);
         TUtilityString.FlushUTF(param1,this.FStardec);
         TUtilityString.FlushUTF(param1,this.FDec);
         param1.writeUnsignedInt(this.FNeed);
         param1.writeUnsignedInt(this.FLevel);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FAwardid = param1.readUnsignedInt();
         this.FChaptername = TUtilityString.FetchUTF(param1);
         this.FAward = TUtilityString.FetchUTF(param1);
         this.FAwardArr = Json.decode(this.FAward);
         this.FNeedstar = param1.readUnsignedInt();
         this.FStardec = TUtilityString.FetchUTF(param1);
         this.FDec = TUtilityString.FetchUTF(param1);
         this.FNeed = param1.readUnsignedInt();
         this.FLevel = param1.readUnsignedInt();
         this.UnstreamizationInventory();
      }
      
      protected function UnstreamizationInventory() : void
      {
         var _loc1_:TInventories = null;
         var _loc2_:TInventory = null;
         var _loc3_:uint = 0;
         var _loc4_:Vector.<uint> = null;
         var _loc5_:Vector.<uint> = null;
         var _loc6_:TBins = null;
         var _loc7_:Object = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc4_ = new Vector.<uint>();
         _loc5_ = new Vector.<uint>();
         _loc1_ = new TInventories();
         _loc8_ = int(this.FAwardArr.length);
         _loc9_ = 0;
         while(_loc9_ < _loc8_)
         {
            _loc7_ = this.FAwardArr[_loc9_];
            _loc10_ = int(_loc7_.type);
            _loc11_ = int(_loc7_.code);
            _loc3_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc6_);
            _loc4_.push(_loc3_);
            _loc5_.push(_loc7_.amount);
            _loc9_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc1_,_loc4_);
         _loc9_ = 0;
         while(_loc9_ < _loc8_)
         {
            _loc2_ = _loc1_.GetInventoryByIndex(_loc9_);
            _loc2_.Quantity = _loc5_[_loc9_];
            _loc9_++;
         }
         this.AwardList = _loc1_;
      }
      
      public function get Awardid() : int
      {
         return this.FAwardid;
      }
      
      public function get Chaptername() : String
      {
         return this.FChaptername;
      }
      
      public function get Award() : String
      {
         return this.FAward;
      }
      
      public function get AwardArr() : Array
      {
         return this.FAwardArr;
      }
      
      public function get Needstar() : int
      {
         return this.FNeedstar;
      }
      
      public function get Stardec() : String
      {
         return this.FStardec;
      }
      
      public function get Need() : int
      {
         return this.FNeed;
      }
      
      public function get Dec() : String
      {
         return this.FDec;
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
   }
}

