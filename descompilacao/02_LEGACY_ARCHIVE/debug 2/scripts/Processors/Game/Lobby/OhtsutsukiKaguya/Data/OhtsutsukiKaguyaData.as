package Processors.Game.Lobby.OhtsutsukiKaguya.Data
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Logics.DatebaseVO.VO.TNightPowerConfig;
   import Logics.DatebaseVO.VO.TNightPowerPrivilege;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_OhtsutsukiKaguya;
   import flash.utils.ByteArray;
   
   public class OhtsutsukiKaguyaData
   {
      
      protected var FOpenLevel:int;
      
      protected var FExpArr:Vector.<Object> = null;
      
      protected var FGoldArr:Vector.<Object> = null;
      
      protected var FTimeArr:Vector.<Object> = null;
      
      protected var FBeforeGoldArr:Vector.<Object> = null;
      
      protected var FNiJiBuyCounGold:Vector.<uint> = null;
      
      protected var FBeforeValue:int;
      
      protected var FCurPoint:int;
      
      protected var FTNightPowerConfig:TBins;
      
      protected var FNightPowerPrivilege:TBins;
      
      protected var FEndTime:uint;
      
      protected var FOneDAY:uint;
      
      protected var FRoleCurAtPosition:int;
      
      protected var FIsCanGetReward:Boolean;
      
      protected var FIsSelectDoubel:Boolean;
      
      protected var FOpenState:int;
      
      protected var FIsLongTime:int;
      
      protected var FPerLevel:int;
      
      protected var FCurLevel:int;
      
      protected var FPerLevelAllExp:uint;
      
      protected var FCurLevelAllExp:uint;
      
      protected var FCurNeedExp:uint;
      
      protected var FCurLevelAllExp_:uint;
      
      protected var FNextLevelAllExp:uint;
      
      protected var FNextLevel:int;
      
      protected var FCurExp:uint;
      
      protected var FDvalue:uint;
      
      protected var FIsCanOpenpanel:Boolean;
      
      protected var FIsHighestLevel:Boolean;
      
      protected var FPropertyTypeVec:Vector.<int>;
      
      protected var FPropertyValueVec:Vector.<int>;
      
      protected var FType_Count_Vector:Vector.<int>;
      
      public function OhtsutsukiKaguyaData()
      {
         super();
         this.FPropertyTypeVec = new Vector.<int>();
         this.FPropertyValueVec = new Vector.<int>();
         this.FType_Count_Vector = new Vector.<int>(15);
      }
      
      public function get PropertyTypeVec() : Vector.<int>
      {
         return this.FPropertyTypeVec;
      }
      
      public function get PropertyValueVec() : Vector.<int>
      {
         return this.FPropertyValueVec;
      }
      
      public function get Type_Count_Vector() : Vector.<int>
      {
         return this.FType_Count_Vector;
      }
      
      public function set CurLevel(param1:int) : void
      {
         var _loc2_:TNightPowerConfig = null;
         this.FCurLevel = param1;
         if(!this.FTNightPowerConfig)
         {
            this.FTNightPowerConfig = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NightPowerConfig) as TBins;
         }
         _loc2_ = this.FTNightPowerConfig.GetDatebaseByIdentifier(this.FCurLevel + CONST_OhtsutsukiKaguya.ConfigTimeValue) as TNightPowerConfig;
         if(!_loc2_)
         {
            _loc2_ = this.FTNightPowerConfig.GetDatebaseByIndex(0) as TNightPowerConfig;
            this.FCurPoint = _loc2_.Deduction;
            return;
         }
         this.FCurNeedExp = _loc2_.Exp;
         this.FOneDAY = _loc2_.DailyReward;
         this.FNextLevel = this.FCurLevel + 1;
         if(this.FNextLevel >= this.FTNightPowerConfig.Count)
         {
            this.FNextLevel = this.FTNightPowerConfig.Count;
         }
         this.FCurPoint = _loc2_.Deduction;
         this.FCurLevelAllExp = _loc2_.AllExp;
         this.SetPerLevelAllExpByCurLevel();
         this.SetValueByCurLevel();
      }
      
      public function get CurLevel() : int
      {
         return this.FCurLevel;
      }
      
      protected function SetPerLevelAllExpByCurLevel() : void
      {
         var _loc1_:TNightPowerConfig = null;
         this.FPerLevel = this.FCurLevel - 1;
         if(this.FPerLevel <= 0)
         {
            this.FPerLevelAllExp = 0;
         }
         else
         {
            if(!this.FTNightPowerConfig)
            {
               this.FTNightPowerConfig = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NightPowerConfig) as TBins;
            }
            _loc1_ = this.FTNightPowerConfig.GetDatebaseByIdentifier(CONST_OhtsutsukiKaguya.ConfigTimeValue + this.FPerLevel) as TNightPowerConfig;
            this.FPerLevelAllExp = _loc1_.AllExp;
         }
      }
      
      protected function SetValueByCurLevel() : void
      {
         var _loc1_:TNightPowerConfig = null;
         if(!this.FTNightPowerConfig)
         {
            this.FTNightPowerConfig = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NightPowerConfig) as TBins;
         }
         _loc1_ = this.FTNightPowerConfig.GetDatebaseByIdentifier(CONST_OhtsutsukiKaguya.ConfigTimeValue + this.FNextLevel) as TNightPowerConfig;
         this.FDvalue = this.FCurLevelAllExp;
         if(_loc1_)
         {
            this.FNextLevelAllExp = _loc1_.AllExp;
            this.FDvalue = this.FNextLevelAllExp - this.FCurLevelAllExp;
         }
         else
         {
            this.FNextLevel = 0;
            this.FNextLevelAllExp = this.FCurLevelAllExp;
         }
         if(this.FNextLevel >= this.FTNightPowerConfig.Count)
         {
            this.FIsHighestLevel = true;
         }
         else
         {
            this.FIsHighestLevel = false;
         }
      }
      
      public function get CurExp() : uint
      {
         return this.FCurExp;
      }
      
      public function set CurExp(param1:uint) : void
      {
         this.FCurExp = param1;
      }
      
      public function set NextLevel(param1:int) : void
      {
         this.FNextLevel = param1;
      }
      
      public function get NextLevel() : int
      {
         return this.FNextLevel;
      }
      
      public function set OpenState(param1:int) : void
      {
         this.FOpenState = param1;
      }
      
      public function get OpenState() : int
      {
         return this.FOpenState;
      }
      
      public function get IsLongTime() : int
      {
         return this.FIsLongTime;
      }
      
      public function set IsLongTime(param1:int) : void
      {
         this.FIsLongTime = param1;
      }
      
      public function set BeforeValue(param1:int) : void
      {
         this.FBeforeValue = param1;
      }
      
      public function get BeforeValue() : int
      {
         return this.FBeforeValue;
      }
      
      public function set TimeArr(param1:Vector.<Object>) : void
      {
         this.FTimeArr = param1;
      }
      
      public function get TimeArr() : Vector.<Object>
      {
         return this.FTimeArr;
      }
      
      public function set BeforeGoldArr(param1:Vector.<Object>) : void
      {
         this.FBeforeGoldArr = param1;
      }
      
      public function get BeforeGoldArr() : Vector.<Object>
      {
         return this.FBeforeGoldArr;
      }
      
      public function set NiJiBuyCounGold(param1:Vector.<uint>) : void
      {
         this.FNiJiBuyCounGold = param1;
      }
      
      public function get NiJiBuyCounGold() : Vector.<uint>
      {
         return this.FNiJiBuyCounGold;
      }
      
      public function set GoldArr(param1:Vector.<Object>) : void
      {
         this.FGoldArr = param1;
      }
      
      public function get GoldArr() : Vector.<Object>
      {
         return this.FGoldArr;
      }
      
      public function set ExpArr(param1:Vector.<Object>) : void
      {
         this.FExpArr = param1;
      }
      
      public function get ExpArr() : Vector.<Object>
      {
         return this.FExpArr;
      }
      
      public function set OpenLevel(param1:int) : void
      {
         this.FOpenLevel = param1;
      }
      
      public function get OpenLevel() : int
      {
         return this.FOpenLevel;
      }
      
      public function set NPowerPrivilege(param1:TBins) : void
      {
         this.FNightPowerPrivilege = param1;
      }
      
      public function get NPowerPrivilege() : TBins
      {
         if(!this.FNightPowerPrivilege)
         {
            this.FNightPowerPrivilege = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NightPowerPrivilege) as TBins;
         }
         return this.FNightPowerPrivilege;
      }
      
      public function set TNPowerConfig(param1:TBins) : void
      {
         this.FTNightPowerConfig = param1;
      }
      
      public function get TNPowerConfig() : TBins
      {
         if(!this.FTNightPowerConfig)
         {
            this.FTNightPowerConfig = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NightPowerConfig) as TBins;
         }
         return this.FTNightPowerConfig;
      }
      
      public function set EndTime(param1:uint) : void
      {
         this.FEndTime = param1;
      }
      
      public function get EndTime() : uint
      {
         return this.FEndTime;
      }
      
      public function set PerLevelAllExp(param1:uint) : void
      {
         this.FPerLevelAllExp = param1;
      }
      
      public function get PerLevelAllExp() : uint
      {
         return this.FPerLevelAllExp;
      }
      
      public function set CurLevelAllExp(param1:uint) : void
      {
         this.FCurLevelAllExp = param1;
      }
      
      public function get CurLevelAllExp() : uint
      {
         return this.FCurLevelAllExp;
      }
      
      public function set CurLevelAllExp_(param1:uint) : void
      {
         this.FCurLevelAllExp_ = param1;
      }
      
      public function get CurLevelAllExp_() : uint
      {
         return this.FCurLevelAllExp_;
      }
      
      public function set NextLevelAllExp(param1:uint) : void
      {
         this.FNextLevelAllExp = param1;
      }
      
      public function get NextLevelAllExp() : uint
      {
         return this.FNextLevelAllExp;
      }
      
      public function set CurPoint(param1:int) : void
      {
         this.FCurPoint = param1;
      }
      
      public function get CurPoint() : int
      {
         return this.FCurPoint;
      }
      
      public function get OneDAY() : uint
      {
         return this.FOneDAY;
      }
      
      public function get IsCanOpenpanel() : Boolean
      {
         return this.FIsCanOpenpanel;
      }
      
      public function set IsCanOpenpanel(param1:Boolean) : void
      {
         this.FIsCanOpenpanel = param1;
      }
      
      public function get IsHighestLevel() : Boolean
      {
         return this.FIsHighestLevel;
      }
      
      public function get IsCanGetReward() : Boolean
      {
         return this.FIsCanGetReward;
      }
      
      public function get IsSelectDoubel() : Boolean
      {
         return this.FIsSelectDoubel;
      }
      
      public function set IsSelectDoubel(param1:Boolean) : void
      {
         this.FIsSelectDoubel = param1;
      }
      
      public function set IsCanGetReward(param1:Boolean) : void
      {
         this.FIsCanGetReward = param1;
      }
      
      public function get CurNeedExp() : uint
      {
         return this.FCurNeedExp;
      }
      
      public function set RoleCurAtPosition(param1:int) : void
      {
         this.FRoleCurAtPosition = param1;
      }
      
      public function get RoleCurAtPosition() : int
      {
         return this.FRoleCurAtPosition;
      }
      
      public function C_S_Privilege(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Dark_Bright_Privilege);
         _loc2_.Data.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function InitilizationBackFun() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Dark_Bright_Get_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function C_S_RenJie(param1:int = 1) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Dark_Bright_addTems);
         _loc2_.Data.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function GetValueByType(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:TNightPowerPrivilege = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(!this.FNightPowerPrivilege)
         {
            this.FNightPowerPrivilege = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NightPowerPrivilege) as TBins;
         }
         _loc5_ = this.FNightPowerPrivilege.Count;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = this.FNightPowerPrivilege.GetDatebaseByIndex(_loc4_) as TNightPowerPrivilege;
            if(this.FCurLevel == _loc3_.Needlevel && _loc3_.TypeValueArr[0] == param1)
            {
               _loc2_ = int(_loc3_.TypeValueArr[1]);
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function GetMaxValueByType(param1:int) : int
      {
         var _loc3_:TNightPowerPrivilege = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         if(this.FOpenState == 0 || this.FIsLongTime == 7)
         {
            return _loc2_;
         }
         if(!this.FNightPowerPrivilege)
         {
            this.FNightPowerPrivilege = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NightPowerPrivilege) as TBins;
         }
         _loc5_ = this.FNightPowerPrivilege.Count;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = this.FNightPowerPrivilege.GetDatebaseByIndex(_loc4_) as TNightPowerPrivilege;
            if(this.FCurLevel >= _loc3_.Needlevel && _loc3_.TypeValueArr[0] == param1)
            {
               _loc2_ = Math.max(_loc3_.TypeValueArr[1],_loc2_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function GetValueByTypeCopy(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:TNightPowerPrivilege = null;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         if(!this.FNightPowerPrivilege)
         {
            this.FNightPowerPrivilege = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NightPowerPrivilege) as TBins;
         }
         _loc5_ = this.FNightPowerPrivilege.Count;
         _loc4_ = int(_loc5_ - 1);
         while(_loc4_ >= 0)
         {
            _loc3_ = this.FNightPowerPrivilege.GetDatebaseByIndex(_loc4_) as TNightPowerPrivilege;
            if(_loc3_.TypeValueArr[0] == param1)
            {
               if(this.FCurLevel >= _loc3_.Needlevel)
               {
                  _loc2_ = int(_loc3_.TypeValueArr[1]);
                  break;
               }
            }
            _loc4_--;
         }
         return _loc2_;
      }
      
      public function getArrByType(param1:int) : String
      {
         var _loc3_:TNightPowerPrivilege = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:String = "";
         if(!this.FNightPowerPrivilege)
         {
            this.FNightPowerPrivilege = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NightPowerPrivilege) as TBins;
         }
         _loc5_ = this.FNightPowerPrivilege.Count;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = this.FNightPowerPrivilege.GetDatebaseByIndex(_loc4_) as TNightPowerPrivilege;
            if(this.FCurLevel == _loc3_.Needlevel && _loc3_.TypeValueArr[0] == param1)
            {
               _loc2_ = _loc3_.AddAttr;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function GetExpByExp(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         if(this.FCurLevel > 1)
         {
            _loc3_ = this.GetValueByType(5) / 100 + 1;
            _loc2_ = param1 / _loc3_;
            _loc3_--;
            _loc2_ = Math.ceil(_loc2_ * _loc3_);
            if(_loc2_ <= 0)
            {
               _loc2_ = 1;
            }
         }
         else
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      public function CheckStatus() : Boolean
      {
         if(SLogicsCore.KaguyaData.EndTime > STimingCore.GetServerTick() && !this.FIsCanGetReward)
         {
            return true;
         }
         return false;
      }
   }
}

