package Processors.Game.GroupBattle
{
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Logics.Battle.model.*;
   import Logics.DatebaseVO.VO.*;
   import Processors.*;
   import Processors.Game.Battle.*;
   import Resources.Constants.*;
   import flash.utils.*;
   
   public class TBattleLine extends TProcessor
   {
      
      public static const BattleType_PVE:uint = CONST_GROUPBATTLE.BattleType_PVE;
      
      public static const BattleType_PVP:uint = CONST_GROUPBATTLE.BattleType_PVP;
      
      protected var FBattleInfo:TBattleInfo;
      
      protected var FBattleType:uint;
      
      protected var FLeaderIds:Vector.<uint>;
      
      protected var FFightReport:TBattleInfo;
      
      protected var FInFight:Boolean;
      
      protected var FBaseHeroBins:TBins;
      
      protected var FEnemyBins:TBins;
      
      protected var FBattleStage:TBattleStage;
      
      protected var FEndFight:Function;
      
      public function TBattleLine(param1:TUIComponent)
      {
         super(param1);
         this.FInFight = false;
         this.FBattleStage = new TBattleStage(this,true);
         this.FBattleStage.OnEndBattle = this.OnEndBattle;
         this.FBattleStage.CriticalUI = this.OnSetUnUseFunction;
         this.FBattleStage.OnAntiColorBlackWhiteBg = this.OnSetUnUseFunction;
         this.FBattleStage.OnRedAntiColorBg = this.OnSetUnUseFunction;
      }
      
      protected function MakeFightReport() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TRoleBattleInfo = null;
         var _loc6_:TTurnInfo = null;
         var _loc7_:TActiveInfo = null;
         var _loc8_:TTargetInfo = null;
         var _loc9_:TResultInfo = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:Dictionary = null;
         var _loc18_:Dictionary = null;
         var _loc19_:Dictionary = null;
         var _loc20_:Dictionary = null;
         var _loc21_:uint = 0;
         var _loc22_:uint = 0;
         var _loc23_:uint = 0;
         var _loc24_:uint = 0;
         var _loc25_:uint = 0;
         var _loc26_:TBaseHero = null;
         var _loc27_:TEnemy = null;
         if(this.FBaseHeroBins == null)
         {
            this.FBaseHeroBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
         }
         if(this.FEnemyBins == null)
         {
            this.FEnemyBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Enemy);
         }
         this.FFightReport = new TBattleInfo();
         _loc17_ = new Dictionary();
         _loc18_ = new Dictionary();
         _loc19_ = new Dictionary();
         _loc20_ = new Dictionary();
         this.FFightReport.GroupBattleData = this.FBattleInfo.GroupBattleData;
         this.FFightReport.PlayerInfo_1.Camp = this.FBattleInfo.PlayerInfo_1.Camp;
         this.FFightReport.PlayerInfo_2.Camp = this.FBattleInfo.PlayerInfo_2.Camp;
         _loc10_ = 0;
         _loc12_ = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FBattleInfo.PlayerInfo_1.RoleCount)
         {
            _loc5_ = this.FBattleInfo.PlayerInfo_1.RoleBattleInfos[_loc1_];
            _loc10_ += _loc5_.CurHealth;
            _loc12_ += _loc5_.TotleHealth;
            _loc17_["pos" + _loc5_.Pos] = _loc5_.CurHealth;
            _loc19_["pos" + _loc5_.Pos] = _loc5_.TotleHealth;
            if(_loc5_.RoleId >= 11100001 && _loc5_.RoleId <= 11100024)
            {
               this.FFightReport.PlayerInfo_1.RoleBattleInfos.push(_loc5_);
               _loc5_.Pos = 1;
            }
            _loc1_++;
         }
         _loc5_ = this.FFightReport.PlayerInfo_1.RoleBattleInfos[0];
         _loc5_.StartHealth = _loc10_;
         _loc5_.CurHealth = _loc10_;
         _loc5_.TotleHealth = _loc12_;
         _loc5_.CurAnger = 0;
         _loc26_ = this.FBaseHeroBins.GetDatebaseByIdentifier(_loc5_.RoleId) as TBaseHero;
         _loc22_ = uint(_loc26_.NormalAttack);
         _loc23_ = uint(_loc5_.SkillId);
         _loc11_ = 0;
         _loc12_ = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FBattleInfo.PlayerInfo_2.RoleCount)
         {
            _loc5_ = this.FBattleInfo.PlayerInfo_2.RoleBattleInfos[_loc1_];
            _loc11_ += _loc5_.CurHealth;
            _loc12_ += _loc5_.TotleHealth;
            _loc18_["pos" + _loc5_.Pos] = _loc5_.CurHealth;
            _loc20_["pos" + _loc5_.Pos] = _loc5_.TotleHealth;
            if(this.FBattleType == BattleType_PVE)
            {
               if(this.FLeaderIds.indexOf(_loc5_.RoleId) >= 0)
               {
                  this.FFightReport.PlayerInfo_2.RoleBattleInfos.push(_loc5_);
                  _loc5_.Pos = 1;
               }
            }
            else if(this.FBattleType == BattleType_PVP)
            {
               if(_loc5_.RoleId >= 11100001 && _loc5_.RoleId <= 11100024)
               {
                  this.FFightReport.PlayerInfo_2.RoleBattleInfos.push(_loc5_);
                  _loc5_.Pos = 1;
               }
            }
            _loc1_++;
         }
         _loc5_ = this.FFightReport.PlayerInfo_2.RoleBattleInfos[0];
         _loc5_.StartHealth = _loc11_;
         _loc5_.CurHealth = _loc11_;
         _loc5_.TotleHealth = _loc12_;
         _loc5_.CurAnger = 0;
         if(_loc5_.RoleId > 12101000)
         {
            _loc27_ = this.FEnemyBins.GetDatebaseByIdentifier(_loc5_.RoleId) as TEnemy;
            _loc24_ = uint(_loc27_.Normal);
         }
         else
         {
            _loc26_ = this.FBaseHeroBins.GetDatebaseByIdentifier(_loc5_.RoleId) as TBaseHero;
            _loc24_ = uint(_loc26_.NormalAttack);
         }
         _loc25_ = uint(_loc5_.SkillId);
         _loc2_ = 0;
         while(_loc2_ < this.FBattleInfo.TotleTurn)
         {
            _loc13_ = 0;
            _loc14_ = 0;
            _loc15_ = 0;
            _loc16_ = 0;
            _loc6_ = this.FBattleInfo.TurnInfos[_loc2_];
            _loc3_ = 0;
            while(_loc3_ < _loc6_.ActiveCount)
            {
               _loc7_ = _loc6_.ActiveInfos[_loc3_];
               if(_loc3_ == 0)
               {
                  _loc21_ = uint(_loc7_.ActiveCamp);
               }
               _loc4_ = 0;
               while(_loc4_ < _loc7_.TargetCount)
               {
                  _loc8_ = _loc7_.TargetInfos[_loc4_];
                  if(_loc8_.TargetCamp == 0)
                  {
                     if(_loc8_.ResultInfo.HurtHp >= 0)
                     {
                        if(_loc17_["pos" + _loc8_.TargetPos] > _loc8_.ResultInfo.HurtHp)
                        {
                           _loc13_ += _loc8_.ResultInfo.HurtHp;
                           _loc17_["pos" + _loc8_.TargetPos] -= _loc8_.ResultInfo.HurtHp;
                        }
                        else
                        {
                           _loc13_ += _loc17_["pos" + _loc8_.TargetPos];
                           _loc17_["pos" + _loc8_.TargetPos] = 0;
                        }
                     }
                     else if(_loc19_["pos" + _loc8_.TargetPos] - _loc17_["pos" + _loc8_.TargetPos] > -_loc8_.ResultInfo.HurtHp)
                     {
                        _loc15_ += _loc8_.ResultInfo.HurtHp;
                        _loc17_["pos" + _loc8_.TargetPos] -= _loc8_.ResultInfo.HurtHp;
                     }
                     else
                     {
                        _loc15_ += _loc17_["pos" + _loc8_.TargetPos] - _loc19_["pos" + _loc8_.TargetPos];
                        _loc17_["pos" + _loc8_.TargetPos] = _loc19_["pos" + _loc8_.TargetPos];
                     }
                  }
                  else if(_loc8_.ResultInfo.HurtHp >= 0)
                  {
                     if(_loc18_["pos" + _loc8_.TargetPos] > _loc8_.ResultInfo.HurtHp)
                     {
                        _loc14_ += _loc8_.ResultInfo.HurtHp;
                        _loc18_["pos" + _loc8_.TargetPos] -= _loc8_.ResultInfo.HurtHp;
                     }
                     else
                     {
                        _loc14_ += _loc18_["pos" + _loc8_.TargetPos];
                        _loc18_["pos" + _loc8_.TargetPos] = 0;
                     }
                  }
                  else if(_loc20_["pos" + _loc8_.TargetPos] - _loc18_["pos" + _loc8_.TargetPos] > -_loc8_.ResultInfo.HurtHp)
                  {
                     _loc16_ += _loc8_.ResultInfo.HurtHp;
                     _loc18_["pos" + _loc8_.TargetPos] -= _loc8_.ResultInfo.HurtHp;
                  }
                  else
                  {
                     _loc16_ += _loc18_["pos" + _loc8_.TargetPos] - _loc20_["pos" + _loc8_.TargetPos];
                     _loc18_["pos" + _loc8_.TargetPos] = _loc20_["pos" + _loc8_.TargetPos];
                  }
                  _loc4_++;
               }
               _loc3_++;
            }
            _loc6_ = new TTurnInfo();
            if(_loc21_ == 0)
            {
               _loc7_ = new TActiveInfo(0);
               _loc7_.ActiveCamp = 0;
               _loc7_.ActivePos = 1;
               _loc7_.SkillEffectId = _loc2_ % 2 ? int(_loc23_) : int(_loc22_);
               _loc8_ = new TTargetInfo(0);
               _loc8_.CMD = 1;
               _loc8_.TargetCamp = 1;
               _loc8_.TargetPos = 1;
               _loc8_.TargetStatus = CONST_BATTLE.ActiveType_Hit;
               _loc8_.ResultInfo.HurtHp = _loc14_;
               _loc7_.TargetInfos.push(_loc8_);
               _loc11_ -= _loc14_;
               if(_loc15_ < 0)
               {
                  _loc8_ = new TTargetInfo(1);
                  _loc8_.CMD = 1;
                  _loc8_.TargetCamp = 0;
                  _loc8_.TargetPos = 1;
                  _loc8_.TargetStatus = 1;
                  _loc8_.ResultInfo.HurtHp = _loc15_;
                  _loc7_.TargetInfos.push(_loc8_);
                  _loc10_ -= _loc15_;
               }
               _loc7_.TargetCount = _loc7_.TargetInfos.length;
               _loc6_.ActiveInfos.push(_loc7_);
               if(_loc11_ > 0)
               {
                  _loc7_ = new TActiveInfo(1);
                  _loc7_.ActiveCamp = 1;
                  _loc7_.ActivePos = 1;
                  _loc7_.SkillEffectId = _loc2_ % 2 ? int(_loc25_) : int(_loc24_);
                  _loc8_ = new TTargetInfo(0);
                  _loc8_.CMD = 1;
                  _loc8_.TargetCamp = 0;
                  _loc8_.TargetPos = 1;
                  _loc8_.TargetStatus = CONST_BATTLE.ActiveType_Hit;
                  _loc8_.ResultInfo.HurtHp = _loc13_;
                  _loc7_.TargetInfos.push(_loc8_);
                  _loc10_ -= _loc13_;
                  if(_loc16_ < 0)
                  {
                     _loc8_ = new TTargetInfo(1);
                     _loc8_.CMD = 1;
                     _loc8_.TargetCamp = 1;
                     _loc8_.TargetPos = 1;
                     _loc8_.TargetStatus = 1;
                     _loc8_.ResultInfo.HurtHp = _loc16_;
                     _loc7_.TargetInfos.push(_loc8_);
                     _loc11_ -= _loc16_;
                  }
                  _loc7_.TargetCount = _loc7_.TargetInfos.length;
                  _loc6_.ActiveInfos.push(_loc7_);
               }
               _loc6_.ActiveCount = _loc6_.ActiveInfos.length;
            }
            else
            {
               _loc7_ = new TActiveInfo(0);
               _loc7_.ActiveCamp = 1;
               _loc7_.ActivePos = 1;
               _loc7_.SkillEffectId = _loc2_ % 2 ? int(_loc25_) : int(_loc24_);
               _loc8_ = new TTargetInfo(0);
               _loc8_.CMD = 1;
               _loc8_.TargetCamp = 0;
               _loc8_.TargetPos = 1;
               _loc8_.TargetStatus = CONST_BATTLE.ActiveType_Hit;
               _loc8_.ResultInfo.HurtHp = _loc13_;
               _loc7_.TargetInfos.push(_loc8_);
               _loc10_ -= _loc13_;
               if(_loc16_ < 0)
               {
                  _loc8_ = new TTargetInfo(1);
                  _loc8_.CMD = 1;
                  _loc8_.TargetCamp = 1;
                  _loc8_.TargetPos = 1;
                  _loc8_.TargetStatus = 1;
                  _loc8_.ResultInfo.HurtHp = _loc16_;
                  _loc7_.TargetInfos.push(_loc8_);
                  _loc11_ -= _loc16_;
               }
               _loc7_.TargetCount = _loc7_.TargetInfos.length;
               _loc6_.ActiveInfos.push(_loc7_);
               if(_loc10_ > 0)
               {
                  _loc7_ = new TActiveInfo(1);
                  _loc7_.ActiveCamp = 0;
                  _loc7_.ActivePos = 1;
                  _loc7_.SkillEffectId = _loc2_ % 2 ? int(_loc23_) : int(_loc22_);
                  _loc8_ = new TTargetInfo(0);
                  _loc8_.CMD = 1;
                  _loc8_.TargetCamp = 1;
                  _loc8_.TargetPos = 1;
                  _loc8_.TargetStatus = CONST_BATTLE.ActiveType_Hit;
                  _loc8_.ResultInfo.HurtHp = _loc14_;
                  _loc7_.TargetInfos.push(_loc8_);
                  _loc11_ -= _loc14_;
                  if(_loc15_ < 0)
                  {
                     _loc8_ = new TTargetInfo(1);
                     _loc8_.CMD = 1;
                     _loc8_.TargetCamp = 0;
                     _loc8_.TargetPos = 1;
                     _loc8_.TargetStatus = 1;
                     _loc8_.ResultInfo.HurtHp = _loc15_;
                     _loc7_.TargetInfos.push(_loc8_);
                     _loc10_ -= _loc15_;
                  }
                  _loc7_.TargetCount = _loc7_.TargetInfos.length;
                  _loc6_.ActiveInfos.push(_loc7_);
               }
               _loc6_.ActiveCount = _loc6_.ActiveInfos.length;
            }
            this.FFightReport.TurnInfos.push(_loc6_);
            _loc2_++;
         }
         this.FFightReport.TotleTurn = this.FFightReport.TurnInfos.length;
      }
      
      protected function OnEndBattle(param1:Object) : void
      {
         this.FInFight = false;
         if(this.FEndFight != null)
         {
            this.FEndFight(this);
         }
      }
      
      protected function OnSetUnUseFunction(param1:Object = null, param2:Boolean = false) : void
      {
      }
      
      public function get InFight() : Boolean
      {
         return this.FInFight;
      }
      
      public function get FightReport() : TBattleInfo
      {
         return this.FFightReport;
      }
      
      public function set EndFight(param1:Function) : void
      {
         this.FEndFight = param1;
      }
      
      public function get EndFight() : Function
      {
         return this.FEndFight;
      }
      
      public function SetBattleInfo(param1:TBattleInfo, param2:uint, param3:Vector.<uint> = null) : void
      {
         this.FBattleStage.Reset();
         this.FBattleInfo = param1;
         this.FBattleType = param2;
         this.FLeaderIds = param3;
         this.MakeFightReport();
         this.FInFight = true;
      }
      
      public function StartBattle() : void
      {
         this.FBattleStage.CreditCommandList(this.FFightReport);
      }
      
      public function SkipBattle() : void
      {
         this.FBattleStage.ButtonSkipOnClick();
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
         if(this.FBattleStage)
         {
            this.FBattleStage.Visible = param1;
         }
      }
   }
}

