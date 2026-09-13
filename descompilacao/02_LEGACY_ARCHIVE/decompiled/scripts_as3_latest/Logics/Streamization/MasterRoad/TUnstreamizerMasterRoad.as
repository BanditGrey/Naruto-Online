package Logics.Streamization.MasterRoad
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TMasterRoadBattle;
   import Logics.DatebaseVO.VO.TMasterRoadEvent;
   import Logics.DatebaseVO.VO.TMasterRoadMall;
   import Logics.DatebaseVO.VO.TMasterRoadVenue;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.MasterRoad.TMasterRoad;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerMasterRoad extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FMasterRoadVenueBins:TBins;
      
      protected var FMasterRoadEventBins:TBins;
      
      protected var FMasterRoadBattleBins:TBins;
      
      protected var FMasterRoadMallBins:TBins;
      
      protected var FArticleBins:TBins;
      
      public function TUnstreamizerMasterRoad()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:TInventory = null;
         var _loc11_:TInventories = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:Vector.<uint> = null;
         var _loc21_:Vector.<uint> = null;
         var _loc22_:TBaseBox = null;
         var _loc23_:Vector.<int> = null;
         var _loc24_:Vector.<int> = null;
         var _loc25_:TMasterRoad = null;
         var _loc26_:TMasterRoadVenue = null;
         var _loc27_:TMasterRoadEvent = null;
         var _loc28_:TMasterRoadMall = null;
         var _loc29_:TMasterRoadBattle = null;
         var _loc30_:TConsumeRankInfo = null;
         var _loc31_:String = null;
         _loc20_ = new Vector.<uint>();
         _loc21_ = new Vector.<uint>();
         _loc23_ = new Vector.<int>();
         _loc24_ = new Vector.<int>();
         _loc25_ = param2 as TMasterRoad;
         if(!this.FArticleBins)
         {
            this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         }
         if(!this.FMasterRoadVenueBins)
         {
            this.FMasterRoadVenueBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_MasterRoadVenue);
         }
         if(!this.FMasterRoadEventBins)
         {
            this.FMasterRoadEventBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_MasterRoadEvent);
         }
         if(!this.FMasterRoadBattleBins)
         {
            this.FMasterRoadBattleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_MasterRoadBattle);
         }
         if(!this.FMasterRoadMallBins)
         {
            this.FMasterRoadMallBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_MasterRoadMall);
         }
         _loc25_.MyScore = param1.readUnsignedInt();
         _loc25_.VenuesData.length = 0;
         _loc7_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc12_ = param1.readUnsignedInt();
            _loc26_ = this.FMasterRoadVenueBins.GetDatebaseByIdentifier(_loc12_) as TMasterRoadVenue;
            _loc26_.CurPoint = param1.readUnsignedInt();
            _loc26_.Status = param1.readInt();
            _loc26_.ActiveTime = param1.readInt();
            _loc26_.EventList.length = 0;
            _loc8_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc12_ = param1.readUnsignedInt();
               _loc27_ = this.FMasterRoadEventBins.GetDatebaseByIdentifier(_loc12_) as TMasterRoadEvent;
               _loc15_ = param1.readUnsignedInt();
               if(_loc27_)
               {
                  _loc27_.Progress = _loc15_;
                  _loc27_.Status = _loc27_.Progress >= _loc27_.Command ? 1 : 0;
                  _loc26_.EventList[_loc5_] = _loc27_;
               }
               _loc5_++;
            }
            _loc26_.Sort();
            _loc26_.BattleList.length = 0;
            _loc8_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc12_ = param1.readUnsignedInt();
               _loc29_ = this.FMasterRoadBattleBins.GetDatebaseByIdentifier(_loc12_) as TMasterRoadBattle;
               _loc16_ = param1.readInt();
               _loc17_ = param1.readInt();
               _loc18_ = param1.readInt();
               _loc19_ = param1.readInt();
               if(_loc29_)
               {
                  _loc29_.Status = _loc16_;
                  _loc29_.BattleStatus = _loc17_;
                  _loc29_.LimitCount = _loc18_;
                  _loc29_.Price = _loc19_;
                  _loc26_.BattleList[_loc5_] = _loc29_;
               }
               _loc5_++;
            }
            _loc25_.VenuesData[_loc4_] = _loc26_;
            _loc4_++;
         }
         _loc25_.MallData.length = 0;
         _loc7_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc12_ = param1.readUnsignedInt();
            _loc28_ = this.FMasterRoadMallBins.GetDatebaseByIdentifier(_loc12_) as TMasterRoadMall;
            _loc18_ = int(param1.readUnsignedInt());
            _loc10_ = _loc28_.Inventories.GetInventoryByIndex(0);
            _loc10_.LimitCount = _loc18_;
            _loc10_.MaxPrice = _loc28_.consume;
            _loc10_.Desc = _loc28_.Desc;
            _loc25_.MallData[_loc4_] = _loc28_;
            _loc4_++;
         }
      }
      
      public function UnstreamizationPerform_Temple(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TMasterRoad = null;
         var _loc9_:TConsumeRankInfo = null;
         _loc8_ = param2 as TMasterRoad;
         _loc8_.TempleIndex = param1.readUnsignedInt() - 1;
         _loc8_.TempleStatus = param1.readInt();
         _loc8_.HonorPlayers.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc9_ = new TConsumeRankInfo();
            _loc9_.Rank = _loc4_ + 1;
            _loc9_.ServerName = TUtilityString.FetchUTF(param1);
            _loc9_.UserName = TUtilityString.FetchUTF(param1);
            _loc9_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc9_.Time = param1.readUnsignedInt();
            _loc9_.HeroID = param1.readUnsignedInt();
            _loc8_.HonorPlayers[_loc4_] = _loc9_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

