package Logics.LostShenQi
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TLostsacredGenerate;
   import Logics.DatebaseVO.VO.TMasterStone;
   import Logics.DatebaseVO.VO.TMasterStoneConfig;
   import Logics.DatebaseVO.VO.TMasterStoneUpgrade;
   import Logics.DatebaseVO.VO.TMazeaward;
   import Logics.DatebaseVO.VO.TVipConfig;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TLostShenQiLogicData
   {
      
      protected var FLostJadeId:uint;
      
      protected var FShenJiFuId:uint;
      
      protected var FShenQiHeXinId:uint;
      
      protected var FLostsacredGenerateBins:TBins;
      
      protected var FMasterStoneUpgradBins:TBins;
      
      protected var FMasterStoneConfigBins:TBins;
      
      protected var FMasterStoneBins:TBins;
      
      protected var FBianGengCostVector:Vector.<uint>;
      
      protected var FTiaoGuoCostVector:Vector.<uint>;
      
      protected var FXingDongLiBuyCostVector:Vector.<uint>;
      
      protected var FXingDongDianShu:uint;
      
      protected var FCurShiJianId:uint;
      
      protected var FMianFeiTiaoGuoShiJianCiShu:uint;
      
      protected var FBuyTiaoGuoShiJianCiShu:uint;
      
      protected var FShiYongTiaoGuoShiJianCiShu:uint;
      
      protected var FMianFeiBianGengShiJianCiShu:uint;
      
      protected var FGouMaiBianGengShiJianCiShu:uint;
      
      protected var FShiYongBianGengShiJianCiShu:uint;
      
      protected var FGouMaiXIngDongDianCiShu:uint;
      
      protected var FMiGongJiFen:uint;
      
      protected var FShiFouYiQingChuMiWu:uint;
      
      protected var FCurQuestionID:uint;
      
      protected var FCurPosition_X:uint;
      
      protected var FCurPosition_Y:uint;
      
      protected var FCurGameState:uint;
      
      protected var FYiJingChongZhiCishu:uint;
      
      protected var FBeginMiGongCishu:uint;
      
      protected var FMoRenMiGongCishu:int;
      
      protected var FBuyXingDongOneTimeNum:int;
      
      protected var FOverPosition:Vector.<uint>;
      
      protected var FBeginPosition:Vector.<uint>;
      
      protected var FTempValue:uint;
      
      protected var FBaseValue:uint;
      
      protected var FRestCost:uint;
      
      protected var FShenQiOpenLevel:uint;
      
      protected var FSuperJadeShowLevel:uint;
      
      protected var FSuperJadeOpenLevel:uint;
      
      protected var FMazeawardbins:TBins;
      
      public function TLostShenQiLogicData()
      {
         super();
      }
      
      public function get LostJadeNum() : uint
      {
         return uint(SLogicsCore.Character.Appliances.GetAllCountByTempletID(this.LostJadeId));
      }
      
      public function get DangQianMiGongKeHuoDeiJadeNum() : uint
      {
         var _loc1_:TBins = null;
         var _loc2_:TMazeaward = null;
         var _loc3_:* = 0;
         _loc1_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Mazeaward);
         _loc3_ = int(_loc1_.Count - 1);
         while(_loc3_ >= 0)
         {
            _loc2_ = _loc1_.GetDatebaseByIndex(_loc3_) as TMazeaward;
            if(this.FMiGongJiFen >= _loc2_.EventPoint)
            {
               _loc3_ = int(_loc2_.AwardLostpiece);
               break;
            }
            _loc3_--;
         }
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         return _loc3_;
      }
      
      public function get ShenJiFuNum() : uint
      {
         var _loc1_:uint = 0;
         return uint(SLogicsCore.Character.Appliances.GetAllCountByTempletID(this.ShenJiFuId));
      }
      
      public function get LostsacredGenerateBins() : TBins
      {
         if(!this.FLostsacredGenerateBins)
         {
            this.FLostsacredGenerateBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_LostsacredGenerate);
         }
         return this.FLostsacredGenerateBins;
      }
      
      public function GetIsSuperFaQiById(param1:uint) : Boolean
      {
         var _loc2_:TLostsacredGenerate = null;
         _loc2_ = this.LostsacredGenerateBins.GetDatebaseByValue("ArtifactId",param1) as TLostsacredGenerate;
         if(_loc2_)
         {
            return true;
         }
         return false;
      }
      
      public function GetTunShiExpById(param1:uint) : uint
      {
         var _loc2_:TMasterStoneUpgrade = null;
         _loc2_ = this.MasterStoneUpgradBins.GetDatebaseByIdentifier(param1) as TMasterStoneUpgrade;
         return _loc2_.NormalDevour;
      }
      
      public function GetTunShiCostById(param1:uint) : uint
      {
         var _loc2_:TMasterStoneUpgrade = null;
         _loc2_ = this.MasterStoneUpgradBins.GetDatebaseByIdentifier(param1) as TMasterStoneUpgrade;
         return _loc2_.GoldExpend;
      }
      
      public function get MasterStoneUpgradBins() : TBins
      {
         if(!this.FMasterStoneUpgradBins)
         {
            this.FMasterStoneUpgradBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_MasterStoneUpgrade);
         }
         return this.FMasterStoneUpgradBins;
      }
      
      public function GetJinJieCostById(param1:uint) : uint
      {
         var _loc2_:TMasterStoneConfig = null;
         _loc2_ = this.MasterStoneConfigBins.GetDatebaseByIdentifier(param1) as TMasterStoneConfig;
         return _loc2_.Expend;
      }
      
      public function get MasterStoneConfigBins() : TBins
      {
         if(!this.FMasterStoneConfigBins)
         {
            this.FMasterStoneConfigBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_MasterStoneConfig);
         }
         return this.FMasterStoneConfigBins;
      }
      
      public function get MasterStoneBins() : TBins
      {
         if(!this.FMasterStoneBins)
         {
            this.FMasterStoneBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_MasterStone);
         }
         return this.FMasterStoneBins;
      }
      
      public function GetBooJade(param1:uint) : Boolean
      {
         var _loc2_:TMasterStone = null;
         _loc2_ = this.MasterStoneBins.GetDatebaseByIdentifier(param1) as TMasterStone;
         if(_loc2_)
         {
            return true;
         }
         return false;
      }
      
      public function get LostJadeId() : uint
      {
         var _loc1_:TConfigValue = null;
         if(this.FLostJadeId == 0)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91200016) as TConfigValue;
            this.FLostJadeId = _loc1_.Value as int;
         }
         return this.FLostJadeId;
      }
      
      public function get ShenJiFuId() : uint
      {
         var _loc1_:TConfigValue = null;
         if(this.FShenJiFuId == 0)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91200017) as TConfigValue;
            this.FShenJiFuId = _loc1_.Value as int;
         }
         return this.FShenJiFuId;
      }
      
      public function get ShenQiHeXinId() : uint
      {
         if(this.FShenQiHeXinId == 0)
         {
            this.FShenQiHeXinId = 14111311;
         }
         return this.FShenQiHeXinId;
      }
      
      public function get MoRenMiGongCishu() : uint
      {
         var _loc1_:TConfigValue = null;
         if(this.FMoRenMiGongCishu == 0)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91200003) as TConfigValue;
            this.FMoRenMiGongCishu = _loc1_.Value as int;
         }
         return this.FMoRenMiGongCishu;
      }
      
      public function get MiGongShenYuCiShu() : uint
      {
         var _loc1_:int = 0;
         _loc1_ = this.FYiJingChongZhiCishu + this.MoRenMiGongCishu;
         if(this.FBeginMiGongCishu >= _loc1_)
         {
            _loc1_ = 0;
         }
         else
         {
            _loc1_ = 1;
         }
         return _loc1_;
      }
      
      public function get OverPosition() : Vector.<uint>
      {
         var _loc1_:TConfigValue = null;
         if(!this.FOverPosition)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91200014) as TConfigValue;
            this.FOverPosition = _loc1_.Value as Vector.<uint>;
         }
         return this.FOverPosition;
      }
      
      public function get BeginPosition() : Vector.<uint>
      {
         var _loc1_:TConfigValue = null;
         if(!this.FBeginPosition)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91200013) as TConfigValue;
            this.FBeginPosition = _loc1_.Value as Vector.<uint>;
         }
         return this.FBeginPosition;
      }
      
      public function get BuyXingDongOneTimeNum() : uint
      {
         var _loc1_:TConfigValue = null;
         if(this.FBuyXingDongOneTimeNum == 0)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91200018) as TConfigValue;
            this.FBuyXingDongOneTimeNum = _loc1_.Value as int;
         }
         return this.FBuyXingDongOneTimeNum;
      }
      
      public function get BaseValue() : uint
      {
         return this.FBaseValue;
      }
      
      public function set BaseValue(param1:uint) : void
      {
         this.FBaseValue = param1;
      }
      
      public function get TempValue() : uint
      {
         return this.FTempValue;
      }
      
      public function set TempValue(param1:uint) : void
      {
         this.FTempValue = param1;
      }
      
      public function get YiJingChongZhiCishu() : uint
      {
         return this.FYiJingChongZhiCishu;
      }
      
      public function set YiJingChongZhiCishu(param1:uint) : void
      {
         this.FYiJingChongZhiCishu = param1;
      }
      
      public function set CurGameState(param1:uint) : void
      {
         this.FCurGameState = param1;
      }
      
      public function get CurGameState() : uint
      {
         return this.FCurGameState;
      }
      
      public function set BeginMiGongCishu(param1:uint) : void
      {
         this.FBeginMiGongCishu = param1;
      }
      
      public function get BeginMiGongCishu() : uint
      {
         return this.FBeginMiGongCishu;
      }
      
      public function set CurPosition_Y(param1:uint) : void
      {
         this.FCurPosition_Y = param1;
      }
      
      public function get CurPosition_Y() : uint
      {
         return this.FCurPosition_Y;
      }
      
      public function set CurPosition_X(param1:uint) : void
      {
         this.FCurPosition_X = param1;
      }
      
      public function get CurPosition_X() : uint
      {
         return this.FCurPosition_X;
      }
      
      public function set CurQuestionID(param1:uint) : void
      {
         this.FCurQuestionID = param1;
      }
      
      public function get CurQuestionID() : uint
      {
         return this.FCurQuestionID;
      }
      
      public function set ShiFouYiQingChuMiWu(param1:uint) : void
      {
         this.FShiFouYiQingChuMiWu = param1;
      }
      
      public function get ShiFouYiQingChuMiWu() : uint
      {
         return this.FShiFouYiQingChuMiWu;
      }
      
      public function set MiGongJiFen(param1:uint) : void
      {
         this.FMiGongJiFen = param1;
      }
      
      public function get MiGongJiFen() : uint
      {
         return this.FMiGongJiFen;
      }
      
      public function set GouMaiXIngDongDianCiShu(param1:uint) : void
      {
         this.FGouMaiXIngDongDianCiShu = param1;
      }
      
      public function get GouMaiXIngDongDianCiShu() : uint
      {
         return this.FGouMaiXIngDongDianCiShu;
      }
      
      public function set ShiYongBianGengShiJianCiShu(param1:uint) : void
      {
         this.FShiYongBianGengShiJianCiShu = param1;
      }
      
      public function get ShiYongBianGengShiJianCiShu() : uint
      {
         return this.FShiYongBianGengShiJianCiShu;
      }
      
      public function set GouMaiBianGengShiJianCiShu(param1:uint) : void
      {
         this.FGouMaiBianGengShiJianCiShu = param1;
      }
      
      public function get GouMaiBianGengShiJianCiShu() : uint
      {
         return this.FGouMaiBianGengShiJianCiShu;
      }
      
      public function get MianFeiBianGengShiJianCiShu() : uint
      {
         var _loc1_:TConfigValue = null;
         if(this.FMianFeiBianGengShiJianCiShu == 0)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91200009) as TConfigValue;
            this.FMianFeiBianGengShiJianCiShu = _loc1_.Value as int;
         }
         return this.FMianFeiBianGengShiJianCiShu;
      }
      
      public function get ShengYuBianGengCiShu() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc1_ = this.FGouMaiBianGengShiJianCiShu + this.MianFeiBianGengShiJianCiShu;
         if(_loc1_ >= this.FShiYongBianGengShiJianCiShu)
         {
            _loc2_ = _loc1_ - this.FShiYongBianGengShiJianCiShu;
         }
         else
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      public function set ShiYongTiaoGuoShiJianCiShu(param1:uint) : void
      {
         this.FShiYongTiaoGuoShiJianCiShu = param1;
      }
      
      public function get ShiYongTiaoGuoShiJianCiShu() : uint
      {
         return this.FShiYongTiaoGuoShiJianCiShu;
      }
      
      public function set BuyTiaoGuoShiJianCiShu(param1:uint) : void
      {
         this.FBuyTiaoGuoShiJianCiShu = param1;
      }
      
      public function get BuyTiaoGuoShiJianCiShu() : uint
      {
         return this.FBuyTiaoGuoShiJianCiShu;
      }
      
      public function get MianFeiTiaoGuoShiJianCiShu() : uint
      {
         var _loc1_:TConfigValue = null;
         if(this.FMianFeiTiaoGuoShiJianCiShu == 0)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91200008) as TConfigValue;
            this.FMianFeiTiaoGuoShiJianCiShu = _loc1_.Value as int;
         }
         return this.FMianFeiTiaoGuoShiJianCiShu;
      }
      
      public function get ShengYuTiaoGuoCiShu() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc1_ = this.MianFeiTiaoGuoShiJianCiShu + this.FBuyTiaoGuoShiJianCiShu;
         if(_loc1_ >= this.FShiYongTiaoGuoShiJianCiShu)
         {
            _loc2_ = _loc1_ - this.FShiYongTiaoGuoShiJianCiShu;
         }
         else
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      public function set CurShiJianId(param1:uint) : void
      {
         this.FCurShiJianId = param1;
      }
      
      public function get CurShiJianId() : uint
      {
         return this.FCurShiJianId;
      }
      
      public function set XingDongDianShu(param1:uint) : void
      {
         this.FXingDongDianShu = param1;
      }
      
      public function get XingDongDianShu() : uint
      {
         return this.FXingDongDianShu;
      }
      
      public function get RestCost() : uint
      {
         var _loc1_:TConfigValue = null;
         if(this.FRestCost == 0)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91200004) as TConfigValue;
            this.FRestCost = _loc1_.Value as int;
         }
         return this.FRestCost;
      }
      
      public function get VipCanRestCount() : uint
      {
         var _loc1_:TVipConfig = null;
         _loc1_ = SLogicsCore.UndertownLogicData.VipConfigBins.GetDatebaseByIdentifier(SLogicsCore.Character.VipLevel) as TVipConfig;
         return _loc1_.LostsacredRefresh;
      }
      
      public function get XingDongLiBuyCostVector() : Vector.<uint>
      {
         var _loc1_:TConfigValue = null;
         if(this.FXingDongLiBuyCostVector == null)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91200012) as TConfigValue;
            this.FXingDongLiBuyCostVector = _loc1_.Value as Vector.<uint>;
         }
         return this.FXingDongLiBuyCostVector;
      }
      
      public function get TiaoGuoCostVector() : Vector.<uint>
      {
         var _loc1_:TConfigValue = null;
         if(this.FTiaoGuoCostVector == null)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91200010) as TConfigValue;
            this.FTiaoGuoCostVector = _loc1_.Value as Vector.<uint>;
         }
         return this.FTiaoGuoCostVector;
      }
      
      public function get BianGengCostVector() : Vector.<uint>
      {
         var _loc1_:TConfigValue = null;
         if(this.FBianGengCostVector == null)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91200011) as TConfigValue;
            this.FBianGengCostVector = _loc1_.Value as Vector.<uint>;
         }
         return this.FBianGengCostVector;
      }
      
      public function get ShenQiOpenLevel() : uint
      {
         var _loc1_:TConfigValue = null;
         if(this.FShenQiOpenLevel == 0)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91200001) as TConfigValue;
            this.FShenQiOpenLevel = _loc1_.Value as int;
         }
         return this.FShenQiOpenLevel;
      }
      
      public function get SuperJadeShowLevel() : uint
      {
         var _loc1_:TConfigValue = null;
         if(this.FSuperJadeShowLevel == 0)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91000015) as TConfigValue;
            this.FSuperJadeShowLevel = _loc1_.Value as int;
         }
         return this.FSuperJadeShowLevel;
      }
      
      public function get SuperJadeOpenLevel() : uint
      {
         var _loc1_:TConfigValue = null;
         if(this.FSuperJadeOpenLevel == 0)
         {
            _loc1_ = null;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91000016) as TConfigValue;
            this.FSuperJadeOpenLevel = _loc1_.Value as int;
         }
         return this.FSuperJadeOpenLevel;
      }
      
      public function get Mazeawardbins() : TBins
      {
         if(!this.FMazeawardbins)
         {
            this.FMazeawardbins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Mazeaward);
         }
         return this.FMazeawardbins;
      }
      
      public function get GetXiaDangJiFen() : TMazeaward
      {
         var _loc1_:TMazeaward = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.Mazeawardbins.Count)
         {
            _loc1_ = this.Mazeawardbins.GetDatebaseByIndex(_loc2_) as TMazeaward;
            if(_loc1_.EventPoint > this.MiGongJiFen)
            {
               break;
            }
            _loc2_++;
         }
         return _loc1_;
      }
   }
}

