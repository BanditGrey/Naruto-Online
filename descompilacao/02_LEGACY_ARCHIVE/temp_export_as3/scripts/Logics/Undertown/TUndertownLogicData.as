package Logics.Undertown
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TDungeonsBattle;
   import Logics.DatebaseVO.VO.TDungeonsPractise;
   import Logics.DatebaseVO.VO.TVipConfig;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TUndertownLogicData
   {
      
      protected var FDungeonsBattleBin:TBins;
      
      protected var FDungeonsBattleConfigBin:TBins;
      
      protected var FDungeonsPractiseBin:TBins;
      
      protected var FVipConfigBins:TBins;
      
      protected var FNextWillOpenPanelIndex:int;
      
      protected var FLastCustomsData:TDungeonsBattle;
      
      protected var FCurCustomsData:TDungeonsBattle;
      
      protected var FHistoricHighsCustomsData:TDungeonsBattle;
      
      protected var FDungeons_Reset_Cost:Vector.<Object>;
      
      protected var FFistZhanLingProtectTime:uint;
      
      protected var FAttackProtectTime:uint;
      
      protected var FUndertownPracticeListDataVector:Vector.<TUndertownPracticeListData>;
      
      protected var FUndertownRewardListDataVector:Vector.<TUndertownRewardListData>;
      
      protected var FRestCount:uint;
      
      protected var FSaoDangCostTime:int;
      
      protected var FIsAtDaoJiShiIng:Boolean;
      
      protected var FBuyCount:uint;
      
      protected var FSaoDangShenYuTime:uint;
      
      protected var FCostCount:uint;
      
      protected var FDefaultCount:uint;
      
      protected var FCountAndCost:Vector.<uint>;
      
      public function TUndertownLogicData()
      {
         super();
      }
      
      public function set NextWillOpenPanelIndex(param1:uint) : void
      {
         this.FNextWillOpenPanelIndex = param1;
      }
      
      public function get NextWillOpenPanelIndex() : uint
      {
         return this.FNextWillOpenPanelIndex;
      }
      
      public function set IsAtDaoJiShiIng(param1:Boolean) : void
      {
         this.FIsAtDaoJiShiIng = param1;
      }
      
      public function get IsAtDaoJiShiIng() : Boolean
      {
         return this.FIsAtDaoJiShiIng;
      }
      
      public function set LastCustomsId(param1:uint) : void
      {
         if(!this.FDungeonsBattleBin)
         {
            this.FDungeonsBattleBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DungeonsBattle);
         }
         if(!param1)
         {
            this.FLastCustomsData = null;
            this.FCurCustomsData = this.FDungeonsBattleBin.GetDatebaseByIndex(0) as TDungeonsBattle;
         }
         else
         {
            this.FLastCustomsData = this.FDungeonsBattleBin.GetDatebaseByIdentifier(param1) as TDungeonsBattle;
            param1++;
            this.FCurCustomsData = this.FDungeonsBattleBin.GetDatebaseByIdentifier(param1) as TDungeonsBattle;
         }
      }
      
      public function get LastCustomsData() : TDungeonsBattle
      {
         return this.FLastCustomsData;
      }
      
      public function get CurCustomsData() : TDungeonsBattle
      {
         return this.FCurCustomsData;
      }
      
      public function set HistoricHighsCustomsId(param1:uint) : void
      {
         if(!this.FDungeonsBattleBin)
         {
            this.FDungeonsBattleBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DungeonsBattle);
         }
         this.FHistoricHighsCustomsData = this.FDungeonsBattleBin.GetDatebaseByIdentifier(param1) as TDungeonsBattle;
      }
      
      public function get HistoricHighsCustomsData() : TDungeonsBattle
      {
         return this.FHistoricHighsCustomsData;
      }
      
      public function get DungeonsBattleBin() : TBins
      {
         if(!this.FDungeonsBattleBin)
         {
            this.FDungeonsBattleBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DungeonsBattle);
         }
         return this.FDungeonsBattleBin;
      }
      
      public function get DungeonsBattleConfigBin() : TBins
      {
         if(!this.FDungeonsBattleConfigBin)
         {
            this.FDungeonsBattleConfigBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DungeonsBattleConfig);
         }
         return this.FDungeonsBattleConfigBin;
      }
      
      public function get DungeonsPractiseBin() : TBins
      {
         if(!this.FDungeonsPractiseBin)
         {
            this.FDungeonsPractiseBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DungeonsPractise);
         }
         return this.FDungeonsPractiseBin;
      }
      
      public function get SaoDangCostTime() : int
      {
         var _loc1_:TConfigValue = null;
         if(this.FSaoDangCostTime == 0)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Undertown_3) as TConfigValue;
            this.FSaoDangCostTime = _loc1_.Value as int;
         }
         return this.FSaoDangCostTime;
      }
      
      public function get Dungeons_Reset_Cost() : Vector.<Object>
      {
         var _loc1_:TConfigValue = null;
         if(this.FDungeons_Reset_Cost == null)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Undertown_0) as TConfigValue;
            this.FDungeons_Reset_Cost = _loc1_.Value as Vector.<Object>;
         }
         return this.FDungeons_Reset_Cost;
      }
      
      public function get FistZhanLingProtectTime() : uint
      {
         var _loc1_:TConfigValue = null;
         if(this.FFistZhanLingProtectTime == 0)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Undertown_1) as TConfigValue;
            this.FFistZhanLingProtectTime = _loc1_.Value as uint;
         }
         return this.FFistZhanLingProtectTime;
      }
      
      public function get AttackProtectTime() : uint
      {
         var _loc1_:TConfigValue = null;
         if(this.FAttackProtectTime == 0)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Undertown_2) as TConfigValue;
            this.FAttackProtectTime = _loc1_.Value as uint;
         }
         return this.FAttackProtectTime;
      }
      
      public function set RestCount(param1:uint) : void
      {
         this.FRestCount = param1;
      }
      
      public function get RestCount() : uint
      {
         return this.FRestCount;
      }
      
      public function get GetRestCount() : uint
      {
         var _loc1_:TVipConfig = null;
         _loc1_ = this.VipConfigBins.GetDatebaseByIdentifier(SLogicsCore.Character.VipLevel) as TVipConfig;
         return _loc1_.DungeonsRefresh - this.FRestCount;
      }
      
      public function get CountAndCost() : Vector.<uint>
      {
         var _loc1_:TConfigValue = null;
         if(!this.FCountAndCost)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Undertown_5) as TConfigValue;
            this.FCountAndCost = _loc1_.Value as Vector.<uint>;
         }
         return this.FCountAndCost;
      }
      
      public function get DefaultCount() : uint
      {
         var _loc1_:TConfigValue = null;
         if(!this.FDefaultCount)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Undertown_4) as TConfigValue;
            this.FDefaultCount = _loc1_.Value as int;
         }
         return this.FDefaultCount;
      }
      
      public function set CostCount(param1:uint) : void
      {
         this.FCostCount = param1;
      }
      
      public function get CostCount() : uint
      {
         return this.FCostCount;
      }
      
      public function set SaoDangShenYuTime(param1:uint) : void
      {
         this.FSaoDangShenYuTime = param1;
      }
      
      public function get SaoDangShenYuTime() : uint
      {
         return this.FSaoDangShenYuTime;
      }
      
      public function set BuyCount(param1:uint) : void
      {
         this.FBuyCount = param1;
      }
      
      public function get BuyCount() : uint
      {
         return this.FBuyCount;
      }
      
      public function get OpenVipLevel() : uint
      {
         var _loc1_:TVipConfig = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.VipConfigBins.Count)
         {
            _loc1_ = this.VipConfigBins.GetDatebaseByIndex(_loc2_) as TVipConfig;
            if(_loc1_.DungeonsRefresh != 0)
            {
               break;
            }
            _loc2_++;
         }
         return _loc2_;
      }
      
      public function get VipConfigBins() : TBins
      {
         if(!this.FVipConfigBins)
         {
            this.FVipConfigBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_VipConfig);
         }
         return this.FVipConfigBins;
      }
      
      public function get TheHighestCustomsClearanceRecord() : String
      {
         var _loc1_:String = "";
         var _loc2_:TDungeonsBattle = null;
         if(!this.FHistoricHighsCustomsData)
         {
            _loc1_ = "0/" + this.DungeonsBattleBin.Count;
         }
         else
         {
            _loc2_ = this.DungeonsBattleBin.GetDatebaseByIndex(0) as TDungeonsBattle;
            _loc1_ = this.HistoricHighsCustomsData.Identifier - _loc2_.Identifier + 1 + "/" + this.DungeonsBattleBin.Count;
         }
         return _loc1_;
      }
      
      public function UndertownRewardListDeleteDataByTime(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TUndertownRewardListData = null;
         _loc2_ = 0;
         while(_loc2_ < this.UndertownRewardListDataVector.length)
         {
            _loc3_ = this.UndertownRewardListDataVector[_loc2_];
            if(_loc3_.DiaoLuoTime == param1)
            {
               this.UndertownRewardListDataVector.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
      
      public function get UndertownRewardListDataVector() : Vector.<TUndertownRewardListData>
      {
         if(!this.FUndertownRewardListDataVector)
         {
            this.FUndertownRewardListDataVector = new Vector.<TUndertownRewardListData>();
         }
         return this.FUndertownRewardListDataVector;
      }
      
      public function GetTUndertownPracticeListDataByLayer(param1:uint) : TUndertownPracticeListData
      {
         var _loc3_:int = 0;
         var _loc2_:TUndertownPracticeListData = null;
         _loc3_ = 0;
         while(_loc3_ < this.UndertownPracticeListDataVector.length)
         {
            if(param1 == this.UndertownPracticeListDataVector[_loc3_].DungeonsPractiseData.Identifier)
            {
               _loc2_ = this.UndertownPracticeListDataVector[_loc3_];
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function GetTUndertownPracticeListDataById64(param1:uint, param2:uint) : TUndertownPracticeListData
      {
         var _loc4_:int = 0;
         var _loc3_:TUndertownPracticeListData = null;
         _loc4_ = 0;
         while(_loc4_ < this.UndertownPracticeListDataVector.length)
         {
            if(param1 == this.UndertownPracticeListDataVector[_loc4_].Identifier0 && param2 == this.UndertownPracticeListDataVector[_loc4_].Identifier1)
            {
               _loc3_ = this.UndertownPracticeListDataVector[_loc4_];
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function get UndertownPracticeListDataVector() : Vector.<TUndertownPracticeListData>
      {
         var _loc1_:int = 0;
         var _loc2_:TDungeonsPractise = null;
         var _loc3_:int = 0;
         var _loc4_:TUndertownPracticeListData = null;
         if(!this.FUndertownPracticeListDataVector)
         {
            if(!this.FDungeonsPractiseBin)
            {
               this.FDungeonsPractiseBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DungeonsPractise);
            }
            _loc1_ = this.FDungeonsPractiseBin.Count;
            this.FUndertownPracticeListDataVector = new Vector.<TUndertownPracticeListData>(_loc1_);
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc4_ = new TUndertownPracticeListData();
               _loc2_ = this.FDungeonsPractiseBin.GetDatebaseByIndex(_loc3_) as TDungeonsPractise;
               _loc4_.DungeonsPractiseData = _loc2_;
               this.FUndertownPracticeListDataVector[_loc3_] = _loc4_;
               _loc3_++;
            }
         }
         return this.FUndertownPracticeListDataVector;
      }
      
      public function CheckLimitTimes() : Boolean
      {
         var _loc1_:int = this.FBuyCount + this.DefaultCount;
         if(_loc1_ <= this.FCostCount)
         {
            return false;
         }
         return true;
      }
   }
}

