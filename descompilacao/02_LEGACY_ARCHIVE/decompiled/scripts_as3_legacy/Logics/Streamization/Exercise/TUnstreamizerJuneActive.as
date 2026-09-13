package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.JuneActive.TJuneActive1;
   import Logics.Exercise.JuneActive.TJuneActive2;
   import Logics.Exercise.JuneActive.TJuneActive3;
   import Logics.Exercise.JuneActive.TJuneActive4;
   import Logics.Exercise.JuneActive.TJuneActiveDatas;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerJuneActive extends TUnstreamizer
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerJuneActive()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TJuneActiveDatas = null;
         var _loc7_:TBaseActivity = null;
         var _loc8_:int = 0;
         var _loc9_:TBins = null;
         _loc6_ = param2 as TJuneActiveDatas;
         _loc9_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc5_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = _loc6_.GetActivityByIndex(_loc4_);
            _loc7_.Identify = param1.readUnsignedInt();
            _loc7_.ActivityTabName = TUtilityString.FetchUTF(param1);
            _loc7_.IsOpen = param1.readInt();
            _loc7_.BeginTime = param1.readUnsignedInt();
            _loc7_.NeedShine = param1.readInt();
            _loc4_++;
         }
         _loc8_ = param1.readInt();
         switch(_loc8_)
         {
            case ACTIVITY_1_ID:
               this.UnstreamizationPerform_1(param1,_loc6_,_loc9_);
               break;
            case ACTIVITY_2_ID:
               this.UnstreamizationPerform_2(param1,_loc6_,_loc9_);
               break;
            case ACTIVITY_3_ID:
               this.UnstreamizationPerform_3(param1,_loc6_,_loc9_);
               break;
            case ACTIVITY_4_ID:
               this.UnstreamizationPerform_4(param1,_loc6_,_loc9_);
         }
      }
      
      protected function UnstreamizationPerform_1(param1:ByteArray, param2:Object, param3:TBins) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:TBaseBox = null;
         var _loc16_:TJuneActiveDatas = null;
         var _loc17_:TJuneActive1 = null;
         var _loc18_:int = 0;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc16_ = param2 as TJuneActiveDatas;
         _loc17_ = _loc16_.GetActivityByIdentify(ACTIVITY_1_ID) as TJuneActive1;
         _loc17_.BeginTime = param1.readUnsignedInt();
         _loc17_.EndTime = param1.readUnsignedInt();
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc17_.InitDescListNew();
         _loc17_.GameStatus = param1.readInt();
         _loc17_.SignStatus = param1.readInt();
         _loc17_.CurIndex = param1.readUnsignedInt() - 1;
         _loc17_.SurpriseStatus = param1.readInt();
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc18_ = param1.readUnsignedInt() - 1;
            _loc15_ = _loc17_.BoxList[_loc18_];
            _loc15_.Type = param1.readUnsignedInt();
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
            _loc13_.push(_loc10_);
            _loc14_.push(param1.readUnsignedInt());
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc9_.GetInventoryByIndex(0).Quantity = _loc14_[0];
            _loc15_.Inventories = _loc9_;
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerform_2(param1:ByteArray, param2:Object, param3:TBins) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:Vector.<int> = null;
         var _loc16_:TBaseBox = null;
         var _loc17_:TJuneActive2 = null;
         var _loc18_:TJuneActiveDatas = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc18_ = param2 as TJuneActiveDatas;
         _loc17_ = _loc18_.GetActivityByIdentify(ACTIVITY_2_ID) as TJuneActive2;
         _loc17_.BeginTime = param1.readUnsignedInt();
         _loc17_.EndTime = param1.readUnsignedInt();
         _loc17_.ActivityDesc = TUtilityString.FetchUTF(param1);
         _loc17_.ActivityDesc2 = TUtilityString.FetchUTF(param1);
         _loc17_.ActivityDesc3 = TUtilityString.FetchUTF(param1);
         _loc17_.TotalMoney = param1.readUnsignedInt();
         _loc17_.Count = param1.readUnsignedInt();
         _loc17_.BoxList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Status = param1.readInt();
            _loc16_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc16_.Desc2 = TUtilityString.FetchUTF(param1);
            _loc16_.Price = param1.readUnsignedInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
               _loc13_.push(_loc10_);
               _loc14_.push(param1.readUnsignedInt());
               _loc5_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc8_ = _loc9_.GetInventoryByIndex(_loc5_);
               _loc8_.Quantity = _loc14_[_loc5_];
               _loc5_++;
            }
            _loc16_.Inventories = _loc9_;
            _loc17_.BoxList[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc17_.FishList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc15_ = new Vector.<int>();
            _loc16_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc16_.Desc2 = TUtilityString.FetchUTF(param1);
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
               _loc13_.push(_loc10_);
               _loc14_.push(param1.readUnsignedInt());
               _loc15_.push(param1.readUnsignedInt());
               _loc5_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc8_ = _loc9_.GetInventoryByIndex(_loc5_);
               _loc8_.Quantity = _loc14_[_loc5_];
               _loc5_++;
            }
            _loc16_.Inventories = _loc9_;
            _loc16_.MaxVect = _loc15_;
            _loc17_.FishList[_loc4_] = _loc16_;
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerform_3(param1:ByteArray, param2:Object, param3:TBins) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:TBaseBox = null;
         var _loc16_:TJuneActive3 = null;
         var _loc17_:TJuneActiveDatas = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc17_ = param2 as TJuneActiveDatas;
         _loc16_ = _loc17_.GetActivityByIdentify(ACTIVITY_3_ID) as TJuneActive3;
         _loc16_.BeginTime = param1.readUnsignedInt();
         _loc16_.EndTime = param1.readUnsignedInt();
         _loc16_.ActivityDesc = TUtilityString.FetchUTF(param1);
         _loc16_.ActivityName = TUtilityString.FetchUTF(param1);
         _loc16_.RankPoint = param1.readUnsignedInt();
         _loc16_.Round = param1.readUnsignedInt();
         _loc16_.MyRank = param1.readUnsignedInt();
         _loc16_.ActivityDesc2 = TUtilityString.FetchUTF(param1);
         _loc16_.Count = param1.readUnsignedInt();
         _loc16_.Cost = param1.readUnsignedInt();
         _loc16_.BoxList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_ = new TBaseBox();
            _loc15_.Price = param1.readUnsignedInt();
            _loc15_.Status = param1.readInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
               _loc13_.push(_loc10_);
               _loc14_.push(param1.readUnsignedInt());
               _loc5_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc8_ = _loc9_.GetInventoryByIndex(_loc5_);
               _loc8_.Quantity = _loc14_[_loc5_];
               _loc5_++;
            }
            _loc15_.Inventories = _loc9_;
            _loc16_.BoxList[_loc4_] = _loc15_;
            _loc4_++;
         }
         _loc16_.HeroList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_ = new TBaseBox();
            _loc15_.Type = param1.readUnsignedInt();
            _loc15_.Price = param1.readUnsignedInt();
            _loc15_.Status = param1.readInt();
            _loc15_.Identify = param1.readUnsignedInt();
            _loc15_.LimitCount = param1.readInt();
            _loc15_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc15_.Desc2 = TUtilityString.FetchUTF(param1);
            _loc15_.Desc3 = TUtilityString.FetchUTF(param1);
            _loc16_.HeroList[_loc4_] = _loc15_;
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerform_4(param1:ByteArray, param2:Object, param3:TBins) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:TBaseBox = null;
         var _loc16_:TJuneActive4 = null;
         var _loc17_:TJuneActiveDatas = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc17_ = param2 as TJuneActiveDatas;
         _loc16_ = _loc17_.GetActivityByIdentify(ACTIVITY_4_ID) as TJuneActive4;
         _loc16_.BeginTime = param1.readUnsignedInt();
         _loc16_.EndTime = param1.readUnsignedInt();
         _loc16_.ActivityDesc = TUtilityString.FetchUTF(param1);
         _loc16_.ActivityDesc2 = TUtilityString.FetchUTF(param1);
         _loc16_.Score = param1.readUnsignedInt();
         _loc16_.TotalCount = param1.readUnsignedInt();
         _loc16_.SweetList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_ = new TBaseBox();
            _loc15_.Type = param1.readUnsignedInt();
            _loc15_.Price = param1.readUnsignedInt();
            _loc15_.Count = param1.readUnsignedInt();
            _loc15_.Status = param1.readInt();
            _loc15_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc16_.SweetList[_loc4_] = _loc15_;
            _loc4_++;
         }
         _loc16_.SockList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_ = new TBaseBox();
            _loc15_.CurPrice = param1.readUnsignedInt();
            _loc15_.Price = param1.readUnsignedInt();
            _loc15_.BuyCount = param1.readUnsignedInt();
            _loc15_.IsHot = param1.readUnsignedInt();
            _loc15_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc15_.Desc2 = TUtilityString.FetchUTF(param1);
            _loc15_.Desc3 = TUtilityString.FetchUTF(param1);
            _loc16_.SockList[_loc4_] = _loc15_;
            _loc4_++;
         }
         _loc6_ = param1.readShort();
         _loc16_.ExchangeHero = new TBaseBox();
         _loc16_.ExchangeHero.Price = param1.readUnsignedInt();
         _loc16_.ExchangeHero.Status = param1.readInt();
         _loc16_.ExchangeHero.Identify = param1.readUnsignedInt();
         _loc16_.ExchangeHero.LimitCount = param1.readUnsignedInt();
         _loc16_.ExchangeHero.Desc1 = TUtilityString.FetchUTF(param1);
         _loc16_.ExchangeHero.Desc2 = TUtilityString.FetchUTF(param1);
         _loc16_.ExchangeHero.Desc3 = TUtilityString.FetchUTF(param1);
         _loc16_.BoxList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_ = new TBaseBox();
            _loc15_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc15_.Desc2 = TUtilityString.FetchUTF(param1);
            _loc15_.Status = param1.readInt();
            _loc15_.Price = param1.readUnsignedInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
               _loc13_.push(_loc10_);
               _loc14_.push(param1.readUnsignedInt());
               _loc5_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc8_ = _loc9_.GetInventoryByIndex(_loc5_);
               _loc8_.Quantity = _loc14_[_loc5_];
               _loc5_++;
            }
            _loc15_.Inventories = _loc9_;
            _loc16_.BoxList[_loc4_] = _loc15_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

