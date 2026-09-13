package Processors.Game.Battle
{
   import Components.Controls.*;
   import Debugging.*;
   import Foundation.Common.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Battle.*;
   import Logics.Battle.model.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Processors.*;
   import Processors.Game.Battle.Character.*;
   import Processors.Game.Battle.Effect.*;
   import Processors.Game.Battle.GoneWord.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   import ghostcat.util.easing.TweenUtil;
   
   public class TBattleStage extends TProcessor
   {
      
      protected static const KEY_QUOTE:uint = CONST_KEYCODE.KEY_QUOTE;
      
      protected static const TYPE_PROFESSIONS:Vector.<String> = STRING_COMMON.TYPE_PROFESSIONS;
      
      protected static const RESOURCESSTATE_Request:int = 0;
      
      protected static const RESOURCESSTATE_Wait:int = 1;
      
      protected static const RESOURCESSTATE_Dispatch:int = 2;
      
      protected static const TEXT_FIGHT_STATUS:Vector.<String> = STRING_BATTLE.TEXT_FIGHT_STATUS;
      
      public static const Ninja_One_Reincarnation_Footstone:int = CONST_COMMON.Ninja_One_Reincarnation_Footstone;
      
      public static const Ninja_Two_Reincarnation_Footstone:int = CONST_COMMON.Ninja_Two_Reincarnation_Footstone;
      
      public static const Ninja_Three_Reincarnation_Footstone:int = CONST_COMMON.Ninja_Three_Reincarnation_Footstone;
      
      public static const TYPETEXT_Float:int = 1;
      
      public static const TYPETEXT_Up:int = 2;
      
      public static const TYPETEXT_Down:int = 3;
      
      public static const TYPETEXT_Stand:int = 4;
      
      public static const TYPETEXT_Hold:int = 5;
      
      public static const TYPETEXT_UpNumber:int = 6;
      
      public static const TYPETEXT_FloatCopy:int = 7;
      
      public static const Pet_1_Point_X:Number = 250;
      
      public static const Pet_1_Point_Y:Number = 300;
      
      public static const Pet_2_Point_X:Number = 1000;
      
      public static const Pet_2_Point_Y:Number = 300;
      
      public static const BOOM_POS:uint = 99;
      
      public static const PET_POS:uint = 100;
      
      public static const BOOM_EFFECT_ID:uint = 13620044;
      
      public static const BOOM_EFFECT_EFFECT:Object = {
         "target":1,
         "anmyhp":{
            "3":100,
            "checkDie":1
         }
      };
      
      protected var FBattleHandle:TBattleHandle;
      
      protected var FBattleFiled:TUIComponent;
      
      protected var FPlayerRoleMgr:Vector.<TRole>;
      
      protected var FPlayerPetMgr:Vector.<TRole>;
      
      protected var FPlayerRole_0:Dictionary;
      
      protected var FPlayerRole_1:Dictionary;
      
      protected var FMounts_0:TRole;
      
      protected var FMounts_1:TRole;
      
      protected var FCommandList:Vector.<Object>;
      
      protected var FEffectSprite:Sprite;
      
      protected var FEndStatues:Boolean;
      
      protected var FIsCrit:Boolean;
      
      protected var FTipsScene:MovieClip;
      
      protected var FTalentBins:TBins;
      
      protected var FSkillBins:TBins;
      
      protected var FWhiteSprite:Sprite;
      
      protected var FColorSprite:Sprite;
      
      protected var FBuffTips:MovieClip;
      
      protected var FHintBtn:THint;
      
      protected var FPetImageBins:TBins;
      
      protected var FBasePetBins:TBins;
      
      protected var FIsHadBoom:Boolean;
      
      protected var FConfusionRole:TRole;
      
      protected var IsStop:Boolean;
      
      protected var FBattleInfo:TBattleInfo;
      
      protected var FIsGroupBattle:Boolean;
      
      protected var FCriticalUI:Function;
      
      protected var FOnChangeBg:Function;
      
      protected var FOnAntiColorBlackWhiteBg:Function;
      
      protected var FOnRedAntiColorBg:Function;
      
      protected var FOnEndBattle:Function;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      public var SoulOnOver:Function;
      
      public var SoulOnOut:Function;
      
      protected var FNegotiateBrforeBattle:Function;
      
      protected var FSetTrunNumber:Function;
      
      public function TBattleStage(param1:TUIComponent, param2:Boolean = false)
      {
         super(param1);
         this.FBattleHandle = param1 as TBattleHandle;
         this.FIsGroupBattle = param2;
         this.FHintBtn = new THint();
         this.InitBattleStage();
      }
      
      protected function InitBattleStage() : void
      {
         this.FPlayerRoleMgr = new Vector.<TRole>();
         this.FPlayerPetMgr = new Vector.<TRole>();
         this.FCommandList = new Vector.<Object>();
         this.FPlayerRole_0 = new Dictionary(true);
         this.FPlayerRole_1 = new Dictionary(true);
         this.FBattleFiled = new TUIComponent(this);
         this.FEffectSprite = new Sprite();
         addChild(this.FEffectSprite);
         this.FEffectSprite.mouseEnabled = false;
         this.FEffectSprite.mouseChildren = false;
         this.FTalentBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_HeroTalent);
         this.FSkillBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SkillConfig);
         this.FPetImageBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_PetImage);
         this.FBasePetBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BasePet);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(!Visible)
         {
            return;
         }
         if(!this.FIsGroupBattle)
         {
            this.CheckMouseIn();
         }
         this.RoleUpdata();
      }
      
      protected function CheckMouseIn() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TRole = null;
         if(this.IsStop)
         {
            this.HideTips();
            return;
         }
         var _loc3_:Array = new Array();
         var _loc4_:Array = new Array();
         _loc1_ = 0;
         while(_loc1_ < this.FPlayerRoleMgr.length)
         {
            _loc2_ = this.FPlayerRoleMgr[_loc1_];
            if(_loc2_.CheckMouseInColor())
            {
               _loc3_.push(_loc2_);
            }
            else
            {
               _loc4_.push(_loc2_);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc1_];
            _loc2_.ShowHighLight = false;
            _loc1_++;
         }
         if(_loc3_.length <= 0)
         {
            this.HideTips();
            return;
         }
         _loc3_.sort(this.ZBuffer,Array.NUMERIC | Array.DESCENDING);
         if(_loc3_.length > 0)
         {
            _loc2_ = _loc3_[0];
            _loc2_.ShowHighLight = true;
            this.ShowTips(_loc2_);
         }
         else
         {
            this.HideTips();
         }
         _loc1_ = 1;
         while(_loc1_ < _loc3_.length)
         {
            _loc2_ = _loc3_[_loc1_];
            _loc2_.ShowHighLight = false;
            _loc1_++;
         }
         _loc3_ = null;
         _loc4_ = null;
      }
      
      protected function ShowTips(param1:TRole) : void
      {
         var _loc2_:THeroTalent = null;
         var _loc3_:TSkillConfig = null;
         var _loc4_:THero = null;
         var _loc5_:int = 0;
         if(this.FTipsScene == null)
         {
            this.FTipsScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_BATTLE.RESOURCE_ClassName_BattleTip) as MovieClip;
            addChild(this.FTipsScene);
         }
         if(param1.HeroData != null)
         {
            this.FTipsScene.tf_name.text = param1.CharacterName;
            this.FTipsScene.tf_level.text = this.GetLevelStrByLevel(param1.Level);
            this.FTipsScene.tf_type.text = TYPE_PROFESSIONS[param1.HeroData.Profession];
            _loc2_ = this.FTalentBins.GetDatebaseByIdentifier(param1.HeroData.Talent) as THeroTalent;
            this.FTipsScene.tf_talent.text = _loc2_.TalentName;
         }
         else if(param1.EnemyData != null)
         {
            this.FTipsScene.tf_name.text = param1.EnemyData.Name;
            this.FTipsScene.tf_level.text = this.GetLevelStrByLevel(param1.EnemyData.Level);
            this.FTipsScene.tf_type.text = TYPE_PROFESSIONS[param1.EnemyData.Profession];
            _loc2_ = this.FTalentBins.GetDatebaseByIdentifier(param1.EnemyData.TalentId) as THeroTalent;
            this.FTipsScene.tf_talent.text = _loc2_ ? _loc2_.TalentName : STRING_COMMON.COMMON_NONE;
         }
         if(param1.Camp == 0)
         {
            _loc5_ = this.FBattleInfo.GetRole1SkillById(param1.Id);
         }
         else
         {
            _loc5_ = this.FBattleInfo.GetRole2SkillById(param1.Id);
         }
         _loc3_ = this.FSkillBins.GetDatebaseByIdentifier(_loc5_) as TSkillConfig;
         this.FTipsScene.tf_skill.text = _loc3_.Name;
         this.FTipsScene.tf_hp.text = param1.CurHealth + "/" + param1.TotleHealth;
         this.FTipsScene.mc_hp.scaleX = Math.min(param1.CurHealth / param1.TotleHealth,1);
         this.FTipsScene.tf_sp.text = param1.CurAnger + "/" + param1.TotleAnger;
         this.FTipsScene.mc_sp.scaleX = Math.min(param1.CurAnger / param1.TotleAnger,1);
         this.FTipsScene.visible = true;
         this.FTipsScene.x = mouseX + 5;
         this.FTipsScene.y = mouseY;
      }
      
      public function GetLevelStrByLevel(param1:uint) : String
      {
         var _loc2_:String = "";
         if(param1 < Ninja_One_Reincarnation_Footstone)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.LevelLv_Describe,param1);
         }
         else if(param1 < Ninja_Two_Reincarnation_Footstone)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,1,param1 - Ninja_One_Reincarnation_Footstone);
         }
         else if(param1 < Ninja_Three_Reincarnation_Footstone)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,2,param1 - Ninja_Two_Reincarnation_Footstone);
         }
         else
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,3,param1 - Ninja_Three_Reincarnation_Footstone);
         }
         return _loc2_;
      }
      
      protected function HideTips() : void
      {
         if(this.FTipsScene != null)
         {
            this.FTipsScene.visible = false;
         }
      }
      
      protected function ZBuffer(param1:TRole, param2:TRole) : int
      {
         if(param1.PosY - param2.PosY != 0)
         {
            return (param1.PosY - param2.PosY) * 10000;
         }
         if(this.stage != null)
         {
            if(param2.PosX < stage.width / 2 && param1.PosX < stage.width / 2)
            {
               return param2.PosX - param1.PosX;
            }
            if(param2.PosX >= stage.width / 2 && param1.PosX >= stage.width / 2)
            {
               return param1.PosX - param2.PosX;
            }
            return param1.PosX - param2.PosX;
         }
         return 0;
      }
      
      protected function ZBufferSort() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TRole = null;
         this.FPlayerRoleMgr.sort(this.ZBuffer);
         _loc1_ = 0;
         while(_loc1_ < this.FPlayerRoleMgr.length)
         {
            _loc2_ = this.FPlayerRoleMgr[_loc1_];
            if(_loc2_ != null && _loc2_.parent != null && _loc2_.Parent.getChildAt(_loc1_) != _loc2_)
            {
               _loc2_.Parent.setChildIndex(_loc2_,_loc1_);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FPlayerPetMgr.length)
         {
            _loc2_ = this.FPlayerPetMgr[_loc1_];
            if(_loc2_ != null && _loc2_.parent != null)
            {
               _loc2_.Parent.addChildAt(_loc2_,0);
            }
            _loc1_++;
         }
      }
      
      protected function RoleUpdata() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TRole = null;
         _loc1_ = 0;
         while(_loc1_ < this.FPlayerRoleMgr.length)
         {
            _loc2_ = this.FPlayerRoleMgr[_loc1_];
            if(_loc2_ != null)
            {
               _loc2_.UpdateActive();
               _loc2_.CheckBuffUI();
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FPlayerPetMgr.length)
         {
            _loc2_ = this.FPlayerPetMgr[_loc1_];
            if(_loc2_ != null)
            {
               _loc2_.UpdateActive();
            }
            _loc1_++;
         }
         if(this.FConfusionRole != null)
         {
            this.FConfusionRole.UpdateActive();
         }
      }
      
      protected function MakeCommandList(param1:int, param2:Vector.<TTurnInfo>) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TTurnInfo = null;
         var _loc9_:TActiveInfo = null;
         var _loc10_:TActiveInfo = null;
         var _loc11_:TActiveInfo = null;
         var _loc12_:TTargetInfo = null;
         var _loc13_:TTargetInfo = null;
         var _loc14_:TTargetInfo = null;
         var _loc15_:TRole = null;
         var _loc16_:TRole = null;
         var _loc17_:Vector.<TTargetInfo> = null;
         var _loc18_:Dictionary = null;
         var _loc19_:Dictionary = null;
         var _loc20_:Boolean = false;
         var _loc21_:Boolean = false;
         var _loc22_:Boolean = false;
         var _loc23_:Vector.<TActiveInfo> = null;
         var _loc24_:Vector.<TActiveInfo> = null;
         var _loc25_:Vector.<TActiveInfo> = null;
         var _loc26_:Vector.<TActiveInfo> = null;
         var _loc27_:Vector.<TRole> = null;
         var _loc28_:Object = null;
         var _loc29_:Vector.<TActiveInfo> = null;
         var _loc30_:TRole = null;
         var _loc31_:Vector.<TRole> = null;
         var _loc32_:Vector.<TActiveInfo> = null;
         var _loc33_:TRole = null;
         var _loc34_:Vector.<TRole> = null;
         var _loc35_:Vector.<int> = null;
         var _loc36_:Boolean = false;
         var _loc38_:Vector.<TRole> = null;
         var _loc39_:int = 0;
         var _loc40_:Vector.<TRole> = null;
         _loc23_ = new Vector.<TActiveInfo>();
         _loc24_ = new Vector.<TActiveInfo>();
         _loc25_ = new Vector.<TActiveInfo>();
         _loc26_ = new Vector.<TActiveInfo>();
         _loc29_ = new Vector.<TActiveInfo>();
         _loc32_ = new Vector.<TActiveInfo>();
         _loc35_ = new Vector.<int>();
         this.FIsHadBoom = false;
         if(this.FConfusionRole != null)
         {
            TPoolRole.SaveRole(this.FConfusionRole);
            this.FConfusionRole = null;
         }
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc28_ = {
               "checkTurn":1,
               "turnNumber":_loc3_ + 1
            };
            this.FCommandList.push(_loc28_);
            _loc8_ = param2[_loc3_];
            _loc4_ = 0;
            while(_loc4_ < _loc8_.ActiveCount)
            {
               _loc23_.length = 0;
               _loc24_.length = 0;
               _loc25_.length = 0;
               _loc26_.length = 0;
               _loc29_.length = 0;
               _loc32_.length = 0;
               _loc35_.length = 0;
               _loc21_ = false;
               _loc22_ = false;
               _loc20_ = false;
               _loc9_ = _loc8_.ActiveInfos[_loc4_];
               if(_loc9_.ActivePos == BOOM_POS)
               {
                  this.FIsHadBoom = true;
                  _loc15_ = null;
               }
               else if(_loc9_.ActivePos == PET_POS)
               {
                  _loc15_ = this["FMounts_" + _loc9_.ActiveCamp];
               }
               else
               {
                  _loc15_ = this["FPlayerRole_" + _loc9_.ActiveCamp][_loc9_.ActivePos];
               }
               if(!this.FIsHadBoom && _loc15_ == null)
               {
                  return;
               }
               _loc18_ = new Dictionary(true);
               _loc19_ = new Dictionary(true);
               _loc17_ = _loc9_.TargetInfos;
               _loc6_ = 0;
               while(_loc6_ < _loc17_.length)
               {
                  _loc12_ = _loc17_[_loc6_];
                  if(_loc12_.TargetPos == PET_POS)
                  {
                     _loc16_ = this["FMounts_" + _loc12_.TargetCamp];
                  }
                  else
                  {
                     _loc16_ = this["FPlayerRole_" + _loc12_.TargetCamp][_loc12_.TargetPos];
                  }
                  if(_loc16_ == null)
                  {
                     return;
                  }
                  if(_loc12_.TargetStatus & CONST_BATTLE.ActiveType_Crit)
                  {
                     _loc20_ = true;
                  }
                  if(_loc12_.TargetStatus & CONST_BATTLE.ActiveType_Block)
                  {
                     _loc21_ = true;
                  }
                  if(Boolean(_loc12_.TargetStatus & CONST_BATTLE.ActiveType_Confusion) || Boolean(_loc12_.TargetStatus2 & CONST_BATTLE.ActiveType_Charm))
                  {
                     _loc22_ = true;
                  }
                  if(_loc12_.CMD != TTargetInfo.CMD_ATTACKEX && _loc12_.CMD != TTargetInfo.CMD_NONE)
                  {
                     if(_loc18_[_loc12_.CMD] == null)
                     {
                        _loc18_[_loc12_.CMD] = new Vector.<TRole>();
                        _loc19_[_loc12_.CMD] = new Vector.<TTargetInfo>();
                     }
                     _loc18_[_loc12_.CMD].push(_loc16_);
                     _loc19_[_loc12_.CMD].push(_loc12_);
                     if(_loc12_.CMD == 9)
                     {
                        _loc29_.push(_loc9_);
                        _loc30_ = this["FPlayerRole_" + _loc12_.TargetCamp][_loc12_.TargetPos];
                     }
                     else if(_loc12_.CMD == 10)
                     {
                        _loc32_.push(_loc9_);
                        _loc35_.push(_loc12_.ResultInfo.BuffId);
                        _loc33_ = this["FPlayerRole_" + _loc12_.TargetCamp][_loc12_.TargetPos];
                     }
                  }
                  else
                  {
                     if(_loc18_[TTargetInfo.CMD_ATTACK] == null)
                     {
                        _loc18_[TTargetInfo.CMD_ATTACK] = new Vector.<TRole>();
                        _loc19_[TTargetInfo.CMD_ATTACK] = new Vector.<TTargetInfo>();
                     }
                     _loc18_[TTargetInfo.CMD_ATTACK].push(_loc16_);
                     _loc19_[TTargetInfo.CMD_ATTACK].push(_loc12_);
                  }
                  _loc6_++;
               }
               _loc5_ = _loc4_ + 1;
               while(_loc5_ < _loc8_.ActiveCount)
               {
                  _loc10_ = _loc8_.ActiveInfos[_loc5_];
                  if(_loc10_.ActiveType == CONST_BATTLE.Active_Block)
                  {
                     _loc4_++;
                     _loc17_ = _loc10_.TargetInfos;
                     _loc6_ = 0;
                     while(_loc6_ < _loc17_.length)
                     {
                        _loc12_ = _loc17_[_loc6_];
                        if(_loc12_.CMD == TTargetInfo.CMD_ATTACK || _loc12_.CMD == TTargetInfo.CMD_RELIVE)
                        {
                           if(_loc18_[_loc12_.CMD] == null)
                           {
                              _loc18_[_loc12_.CMD] = new Vector.<TRole>();
                              _loc19_[_loc12_.CMD] = new Vector.<TTargetInfo>();
                           }
                           _loc18_[_loc12_.CMD].push(_loc16_);
                           _loc19_[_loc12_.CMD].push(_loc12_);
                        }
                        _loc6_++;
                     }
                     _loc23_.push(_loc10_);
                     _loc21_ = true;
                  }
                  else if(_loc10_.ActiveType == CONST_BATTLE.Active_PassiveSkill)
                  {
                     _loc4_++;
                     _loc24_.push(_loc10_);
                  }
                  else if(_loc10_.ActiveType == CONST_BATTLE.Active_DiedSkill)
                  {
                     _loc4_++;
                     _loc17_ = _loc8_.ActiveInfos[_loc4_].TargetInfos;
                     _loc6_ = 0;
                     while(_loc6_ < _loc17_.length)
                     {
                        _loc12_ = _loc17_[_loc6_];
                        if(_loc12_.CMD == TTargetInfo.CMD_AllHertHp)
                        {
                           if(_loc18_[_loc12_.CMD] == null)
                           {
                              _loc18_[_loc12_.CMD] = new Vector.<TRole>();
                              _loc19_[_loc12_.CMD] = new Vector.<TTargetInfo>();
                           }
                           _loc18_[_loc12_.CMD].push(_loc16_);
                           _loc19_[_loc12_.CMD].push(_loc12_);
                        }
                        _loc6_++;
                     }
                     _loc25_.push(_loc10_);
                  }
                  else
                  {
                     if(_loc10_.ActiveType != CONST_BATTLE.Active_FightStatus)
                     {
                        break;
                     }
                     _loc4_++;
                     _loc26_.push(_loc10_);
                  }
                  _loc5_++;
               }
               if(_loc18_[TTargetInfo.CMD_HURTBUFF] != null)
               {
                  _loc28_ = {
                     "play":_loc15_,
                     "checkBuffHurt":1,
                     "result":_loc19_[TTargetInfo.CMD_HURTBUFF]
                  };
                  this.FCommandList.push(_loc28_);
               }
               if(_loc18_[TTargetInfo.CMD_STATUS] != null)
               {
                  _loc28_ = {
                     "addStatus":1,
                     "target":_loc18_[TTargetInfo.CMD_STATUS],
                     "result":_loc19_[TTargetInfo.CMD_STATUS]
                  };
                  this.FCommandList.push(_loc28_);
               }
               if(_loc18_[TTargetInfo.CMD_HurtHp] != null)
               {
                  _loc28_ = {
                     "skillid":-4,
                     "hurtHp":1,
                     "target":_loc18_[TTargetInfo.CMD_HurtHp],
                     "result":_loc19_[TTargetInfo.CMD_HurtHp]
                  };
                  this.FCommandList.push(_loc28_);
               }
               if(_loc9_.ActivePos == PET_POS)
               {
                  _loc28_ = {
                     "play":_loc15_,
                     "skillEffect":1
                  };
                  this.FCommandList.push(_loc28_);
               }
               if(_loc22_)
               {
                  _loc28_ = {
                     "confusionPlay":_loc15_,
                     "hasEnemy":this.HasEnemy(_loc15_.Camp,_loc18_[TTargetInfo.CMD_ATTACK]),
                     "skillid":_loc9_.SkillEffectId,
                     "target":_loc18_[TTargetInfo.CMD_ATTACK],
                     "result":_loc19_[TTargetInfo.CMD_ATTACK],
                     "time":200,
                     "crit":_loc20_
                  };
                  this.FCommandList.push(_loc28_);
               }
               else
               {
                  _loc28_ = {
                     "play":_loc15_,
                     "skillid":_loc9_.SkillEffectId,
                     "target":_loc18_[TTargetInfo.CMD_ATTACK],
                     "result":_loc19_[TTargetInfo.CMD_ATTACK],
                     "time":200,
                     "crit":_loc20_
                  };
                  this.FCommandList.push(_loc28_);
               }
               if(_loc18_[TTargetInfo.CMD_AllHertHp] != null)
               {
                  _loc6_ = 0;
                  while(_loc6_ < _loc18_[TTargetInfo.CMD_AllHertHp].length)
                  {
                     _loc12_ = _loc19_[TTargetInfo.CMD_AllHertHp][_loc6_];
                     _loc16_ = this["FPlayerRole_" + _loc12_.TargetCamp][_loc12_.TargetPos];
                     if(_loc16_ == null)
                     {
                        return;
                     }
                     _loc28_ = {
                        "ResetHp":1,
                        "play":_loc16_,
                        "result":_loc12_
                     };
                     this.FCommandList.push(_loc28_);
                     _loc6_++;
                  }
               }
               if(_loc18_[TTargetInfo.CMD_ATTRBUFF] != null)
               {
                  _loc6_ = 0;
                  while(_loc6_ < _loc18_[TTargetInfo.CMD_ATTRBUFF].length)
                  {
                     _loc12_ = _loc19_[TTargetInfo.CMD_ATTRBUFF][_loc6_];
                     _loc16_ = this["FPlayerRole_" + _loc12_.TargetCamp][_loc12_.TargetPos];
                     if(_loc16_ == null)
                     {
                        return;
                     }
                     _loc28_ = {
                        "Source":_loc15_,
                        "play":_loc16_,
                        "addBuff":1,
                        "result":Vector.<TTargetInfo>([_loc12_])
                     };
                     this.FCommandList.push(_loc28_);
                     _loc6_++;
                  }
               }
               if(!this.FIsHadBoom)
               {
                  _loc28_ = {
                     "play":_loc15_,
                     "checkBuff":2
                  };
                  this.FCommandList.push(_loc28_);
               }
               if(_loc18_[TTargetInfo.CMD_CONTROLBUFF] != null)
               {
                  _loc6_ = 0;
                  while(_loc6_ < _loc18_[TTargetInfo.CMD_CONTROLBUFF].length)
                  {
                     _loc12_ = _loc19_[TTargetInfo.CMD_CONTROLBUFF][_loc6_];
                     _loc16_ = this["FPlayerRole_" + _loc12_.TargetCamp][_loc12_.TargetPos];
                     if(_loc16_ == null)
                     {
                        return;
                     }
                     _loc28_ = {
                        "Source":_loc15_,
                        "play":_loc16_,
                        "addBuff":1,
                        "result":Vector.<TTargetInfo>([_loc12_])
                     };
                     this.FCommandList.push(_loc28_);
                     _loc6_++;
                  }
               }
               if(_loc18_[TTargetInfo.CMD_MIXRBUFF] != null)
               {
                  _loc6_ = 0;
                  while(_loc6_ < _loc18_[TTargetInfo.CMD_MIXRBUFF].length)
                  {
                     _loc12_ = _loc19_[TTargetInfo.CMD_MIXRBUFF][_loc6_];
                     _loc16_ = this["FPlayerRole_" + _loc12_.TargetCamp][_loc12_.TargetPos];
                     if(_loc16_ == null)
                     {
                        return;
                     }
                     _loc28_ = {
                        "Source":_loc15_,
                        "play":_loc16_,
                        "addBuff":1,
                        "result":Vector.<TTargetInfo>([_loc12_])
                     };
                     this.FCommandList.push(_loc28_);
                     _loc6_++;
                  }
               }
               _loc36_ = false;
               if(_loc24_.length > 0)
               {
                  _loc7_ = 0;
                  while(_loc7_ < _loc24_.length)
                  {
                     _loc27_ = new Vector.<TRole>();
                     _loc36_ = false;
                     _loc10_ = _loc24_[_loc7_];
                     _loc6_ = 0;
                     while(_loc6_ < _loc10_.TargetInfos.length)
                     {
                        _loc12_ = _loc10_.TargetInfos[_loc6_];
                        _loc38_ = new Vector.<TRole>();
                        _loc16_ = this["FPlayerRole_" + _loc12_.TargetCamp][_loc12_.TargetPos];
                        if(_loc16_ != null)
                        {
                           _loc27_.push(_loc16_);
                           if(_loc10_.ActiveCamp != _loc12_.TargetCamp && _loc12_.CMD == TTargetInfo.CMD_CONTROLBUFF && _loc12_.ResultInfo.BuffId != 0)
                           {
                              _loc28_ = {
                                 "Source":this["FPlayerRole_" + _loc10_.ActiveCamp][_loc10_.ActivePos],
                                 "play":_loc16_,
                                 "addBuff":1,
                                 "result":Vector.<TTargetInfo>([_loc12_])
                              };
                              this.FCommandList.push(_loc28_);
                              _loc36_ = true;
                           }
                           else
                           {
                              _loc38_.push(_loc16_);
                              _loc15_ = this["FPlayerRole_" + _loc12_.TargetCamp][_loc12_.TargetPos];
                              _loc28_ = {
                                 "play":_loc15_,
                                 "PassiveSkill":1,
                                 "target":_loc38_,
                                 "result":Vector.<TTargetInfo>([_loc12_]),
                                 "time":50
                              };
                              this.FCommandList.push(_loc28_);
                              _loc36_ = true;
                           }
                        }
                        _loc6_++;
                     }
                     if(_loc36_ == false)
                     {
                        _loc15_ = this["FPlayerRole_" + _loc10_.ActiveCamp][_loc10_.ActivePos];
                        _loc28_ = {
                           "play":_loc15_,
                           "PassiveSkill":1,
                           "target":_loc27_,
                           "result":_loc24_[_loc7_].TargetInfos,
                           "time":50
                        };
                        this.FCommandList.push(_loc28_);
                     }
                     _loc7_++;
                  }
               }
               if(_loc25_.length > 0)
               {
                  this.MakeDeadSkillCommandList(_loc25_,_loc17_);
               }
               if(_loc29_.length > 0)
               {
                  _loc31_ = new Vector.<TRole>();
                  _loc31_.push(_loc30_);
                  _loc28_ = {
                     "play":_loc30_,
                     "NewSkill":1,
                     "target":_loc31_,
                     "result":_loc29_[0].TargetInfos,
                     "time":50
                  };
                  this.FCommandList.push(_loc28_);
               }
               if(_loc32_.length > 0)
               {
                  _loc34_ = new Vector.<TRole>();
                  _loc34_.push(_loc33_);
                  _loc28_ = {
                     "play":_loc33_,
                     "NewBuff":1,
                     "target":_loc34_,
                     "result":_loc32_[0].TargetInfos,
                     "BuffID":_loc35_[_loc35_.length - 1],
                     "time":50
                  };
                  this.FCommandList.push(_loc28_);
               }
               if(_loc26_.length > 0)
               {
                  _loc39_ = 0;
                  while(_loc39_ < _loc26_.length)
                  {
                     _loc10_ = _loc26_[_loc39_];
                     _loc40_ = new Vector.<TRole>();
                     _loc6_ = 0;
                     while(_loc6_ < _loc10_.TargetInfos.length)
                     {
                        _loc12_ = _loc10_.TargetInfos[_loc6_];
                        _loc16_ = this["FPlayerRole_" + _loc12_.TargetCamp][_loc12_.TargetPos];
                        _loc40_.push(_loc16_);
                        _loc6_++;
                     }
                     _loc15_ = this["FPlayerRole_" + _loc10_.ActiveCamp][_loc10_.ActivePos];
                     _loc28_ = {
                        "play":_loc15_,
                        "skillid":_loc10_.SkillEffectId,
                        "target":_loc40_,
                        "result":_loc10_.TargetInfos,
                        "time":200,
                        "crit":_loc20_
                     };
                     this.FCommandList.push(_loc28_);
                     _loc39_++;
                  }
               }
               if(_loc21_)
               {
                  _loc6_ = 0;
                  for(; _loc6_ < _loc18_[TTargetInfo.CMD_ATTACK].length; _loc6_++)
                  {
                     _loc12_ = _loc19_[TTargetInfo.CMD_ATTACK][_loc6_];
                     _loc16_ = this["FPlayerRole_" + _loc12_.TargetCamp][_loc12_.TargetPos];
                     if(_loc12_.TargetStatus & CONST_BATTLE.ActiveType_Block)
                     {
                        if(!(_loc12_.TargetStatus & CONST_BATTLE.ActiveType_Died))
                        {
                           _loc11_ = this.GetActiveInfo(_loc12_.TargetCamp,_loc12_.TargetPos,_loc23_);
                           if(_loc11_ == null)
                           {
                              break;
                           }
                           if(_loc11_.TargetCount < 1)
                           {
                              continue;
                           }
                           _loc15_ = this["FPlayerRole_" + _loc9_.ActiveCamp][_loc9_.ActivePos];
                           _loc28_ = {
                              "play":_loc16_,
                              "skillid":-1,
                              "target":Vector.<TRole>([_loc15_,_loc15_]),
                              "result":_loc11_.TargetInfos,
                              "time":200
                           };
                           this.FCommandList.push(_loc28_);
                        }
                        _loc28_ = {
                           "play":_loc16_,
                           "checkDie":1
                        };
                        this.FCommandList.push(_loc28_);
                     }
                  }
                  _loc28_ = {
                     "play":_loc15_,
                     "checkDie":1
                  };
                  this.FCommandList.push(_loc28_);
                  if(Boolean(_loc11_) && _loc25_.length > 0)
                  {
                     this.MakeDeadSkillCommandList(_loc25_,_loc11_.TargetInfos);
                  }
               }
               if(_loc18_[TTargetInfo.CMD_RELIVE] != null)
               {
                  _loc6_ = 0;
                  while(_loc6_ < _loc18_[TTargetInfo.CMD_RELIVE].length)
                  {
                     _loc12_ = _loc19_[TTargetInfo.CMD_RELIVE][_loc6_];
                     _loc16_ = this["FPlayerRole_" + _loc12_.TargetCamp][_loc12_.TargetPos];
                     if(_loc16_ == null)
                     {
                        return;
                     }
                     _loc28_ = {
                        "relive":1,
                        "play":_loc16_,
                        "result":_loc12_,
                        "skillid":-3,
                        "time":0
                     };
                     this.FCommandList.push(_loc28_);
                     _loc6_++;
                  }
               }
               if(_loc18_[TTargetInfo.CMD_POSITION] != null)
               {
                  _loc6_ = 0;
                  while(_loc6_ < _loc18_[TTargetInfo.CMD_POSITION].length)
                  {
                     _loc12_ = _loc19_[TTargetInfo.CMD_POSITION][_loc6_];
                     _loc16_ = this["FPlayerRole_" + _loc12_.TargetCamp][_loc12_.TargetPos];
                     if(_loc16_ == null)
                     {
                        return;
                     }
                     _loc28_ = {
                        "play":_loc16_,
                        "chgPosition":1,
                        "result":Vector.<TTargetInfo>([_loc12_])
                     };
                     this.FCommandList.push(_loc28_);
                     _loc6_++;
                  }
               }
               if(!this.FIsHadBoom)
               {
                  _loc28_ = {
                     "play":_loc15_,
                     "checkBuff":1
                  };
                  this.FCommandList.push(_loc28_);
               }
               _loc4_++;
            }
            _loc28_ = {"chgNewBuffs":1};
            this.FCommandList.push(_loc28_);
            _loc3_++;
         }
         var _loc37_:int = 0;
      }
      
      protected function GetActiveInfo(param1:uint, param2:uint, param3:Vector.<TActiveInfo>) : TActiveInfo
      {
         var _loc4_:uint = 0;
         var _loc5_:TActiveInfo = null;
         if(param3 == null)
         {
            return null;
         }
         _loc4_ = 0;
         while(_loc4_ < param3.length)
         {
            _loc5_ = param3[_loc4_];
            if(_loc5_.ActiveCamp == param1 && _loc5_.ActivePos == param2)
            {
               return _loc5_;
            }
            _loc4_++;
         }
         return null;
      }
      
      protected function MakeDeadSkillCommandList(param1:Vector.<TActiveInfo>, param2:Vector.<TTargetInfo>) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:TTargetInfo = null;
         var _loc8_:TTargetInfo = null;
         var _loc9_:TTargetInfo = null;
         var _loc10_:TActiveInfo = null;
         var _loc11_:Vector.<TRole> = null;
         var _loc12_:TActiveInfo = null;
         var _loc13_:TRole = null;
         var _loc14_:TRole = null;
         var _loc15_:TRole = null;
         var _loc16_:Object = null;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc11_ = new Vector.<TRole>();
            _loc12_ = null;
            _loc12_ = param1[_loc4_];
            if(_loc12_ != null)
            {
               _loc13_ = this["FPlayerRole_" + _loc12_.ActiveCamp][_loc12_.ActivePos];
               if(_loc13_ != null)
               {
                  _loc3_ = 0;
                  while(_loc3_ < _loc12_.TargetInfos.length)
                  {
                     _loc9_ = _loc12_.TargetInfos[_loc3_];
                     _loc14_ = this["FPlayerRole_" + _loc9_.TargetCamp][_loc9_.TargetPos];
                     _loc11_.push(_loc14_);
                     _loc3_++;
                  }
                  _loc16_ = {
                     "play":_loc13_,
                     "skillid":-2,
                     "target":_loc11_,
                     "result":_loc12_.TargetInfos,
                     "time":1500
                  };
                  this.FCommandList.push(_loc16_);
                  _loc5_ = 0;
                  while(_loc5_ < _loc12_.TargetInfos.length)
                  {
                     _loc8_ = _loc12_.TargetInfos[_loc5_];
                     if(_loc8_.CMD == TTargetInfo.CMD_CONTROLBUFF || _loc8_.CMD == TTargetInfo.CMD_ATTRBUFF)
                     {
                        _loc15_ = this["FPlayerRole_" + _loc8_.TargetCamp][_loc8_.TargetPos];
                        if(_loc15_ != null)
                        {
                           _loc16_ = {
                              "Source":_loc13_,
                              "play":_loc15_,
                              "addBuff":1,
                              "result":Vector.<TTargetInfo>([_loc8_])
                           };
                           this.FCommandList.push(_loc16_);
                        }
                     }
                     _loc5_++;
                  }
               }
            }
            _loc4_++;
         }
      }
      
      protected function HasEnemy(param1:uint, param2:Vector.<TRole>) : Boolean
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc4_ = param2.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(param2[_loc3_].Camp != param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function SetFloatTextCopy(param1:int, param2:Number, param3:Number, param4:String) : TGoneWord
      {
         var _loc5_:TGoneWord = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         param3 += 30;
         _loc6_ = Math.PI / 3 + (Math.random() - 0.5) * Math.PI / 3;
         _loc7_ = 20 * Math.sin(_loc6_) * param1;
         _loc8_ = -20 * Math.cos(_loc6_);
         _loc9_ = 0;
         _loc10_ = 0;
         _loc5_ = TPoolEffectGoneWord.GetGoneWord();
         this.FEffectSprite.addChild(_loc5_);
         _loc5_.SetGoneWord(param2 + _loc9_,param3 + (_loc10_ - 26) / 2,param4,_loc7_,_loc8_,26,CONST_BATTLE.GetColorIndex(0),CONST_BATTLE.GetFilterColorIndex(0));
         _loc9_ += _loc5_.EffectWidth;
         if(_loc5_)
         {
            _loc5_.StartFloat();
         }
         return null;
      }
      
      protected function SetFloatText(param1:int, param2:Number, param3:Number, param4:String, param5:Boolean = false, param6:int = 0, param7:Boolean = false) : TGoneWord
      {
         var _loc8_:TGoneWord = null;
         var _loc9_:TGoneWord = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         param3 += 30;
         _loc10_ = Math.PI / 3 + (Math.random() - 0.5) * Math.PI / 3;
         _loc11_ = 20 * Math.sin(_loc10_) * param1;
         _loc12_ = -20 * Math.cos(_loc10_);
         _loc13_ = 0;
         _loc14_ = 0;
         if(int(param4) != 0)
         {
            if(param4.indexOf("+") >= 0)
            {
               _loc8_ = TPoolEffectGoneWord.GetGoneWord();
               this.FEffectSprite.addChild(_loc8_);
               _loc8_.SetGoneWord(param2 + _loc13_,param3,param4,_loc11_,_loc12_,param5 ? 60 : 32,CONST_BATTLE.TEXT_Add_Color,CONST_BATTLE.TEXT_Add_FilterColor);
            }
            else if(param5)
            {
               _loc8_ = TPoolEffectGoneWord.GetGoneWordWithBg();
               this.FEffectSprite.addChild(_loc8_);
               _loc8_.SetGoneWordWithBg(param2 + _loc13_,param3,param4,_loc11_,_loc12_);
            }
            else if(param7)
            {
               _loc8_ = TPoolEffectGoneWord.GetGoneWord();
               this.FEffectSprite.addChild(_loc8_);
               _loc8_.SetGoneWord(param2 + _loc13_,param3,param4,_loc11_,_loc12_,32,4294927923);
            }
            else
            {
               _loc8_ = TPoolEffectGoneWord.GetGoneWord();
               this.FEffectSprite.addChild(_loc8_);
               _loc8_.SetGoneWord(param2 + _loc13_,param3,param4,_loc11_,_loc12_,32,CONST_BATTLE.TEXT_Dec_Color,CONST_BATTLE.TEXT_Dec_FilterColor);
            }
            _loc13_ = _loc8_.EffectWidth;
            _loc14_ = _loc8_.EffectHeight;
         }
         if(param6 > 0)
         {
            _loc9_ = TPoolEffectGoneWord.GetGoneWord();
            this.FEffectSprite.addChild(_loc9_);
            _loc9_.SetGoneWord(param2 + _loc13_,param3 + (_loc14_ - 26) / 2,TEXT_FIGHT_STATUS[param6],_loc11_,_loc12_,26,CONST_BATTLE.GetColorIndex(param6),CONST_BATTLE.GetFilterColorIndex(param6));
            _loc13_ += _loc9_.EffectWidth;
         }
         if(param1 == -1)
         {
            if(_loc8_)
            {
               _loc8_.x -= _loc13_;
            }
            if(_loc9_)
            {
               _loc9_.x -= _loc13_;
            }
         }
         if(_loc8_)
         {
            _loc8_.StartFloat();
         }
         if(_loc9_)
         {
            _loc9_.StartFloat();
         }
         return null;
      }
      
      protected function SetStandText(param1:Number, param2:Number, param3:int) : TGoneWord
      {
         var _loc4_:TGoneWord = null;
         if(param3 < 0 || param3 >= TEXT_FIGHT_STATUS.length)
         {
            return null;
         }
         _loc4_ = TPoolEffectGoneWord.GetGoneWordWithBg();
         this.FEffectSprite.addChild(_loc4_);
         _loc4_.SetGoneWordWithBg(param1,param2,TEXT_FIGHT_STATUS[param3],0,0,32);
         _loc4_.StartStand();
         return _loc4_;
      }
      
      protected function SetHoldText(param1:Number, param2:Number, param3:int) : TGoneWord
      {
         var _loc4_:TGoneWord = null;
         if(param3 < 0 || param3 >= TEXT_FIGHT_STATUS.length)
         {
            return null;
         }
         _loc4_ = TPoolEffectGoneWord.GetGoneWordWithBg();
         this.FEffectSprite.addChild(_loc4_);
         _loc4_.SetGoneWordWithBg(param1,param2,TEXT_FIGHT_STATUS[param3],0,0,32);
         return _loc4_;
      }
      
      protected function SetUpText(param1:Number, param2:Number, param3:int) : TGoneWord
      {
         var _loc4_:TGoneWord = null;
         if(param3 < 0 || param3 >= TEXT_FIGHT_STATUS.length)
         {
            return null;
         }
         _loc4_ = TPoolEffectGoneWord.GetGoneWordWithBg();
         this.FEffectSprite.addChild(_loc4_);
         _loc4_.SetGoneWordWithBg(param1,param2,TEXT_FIGHT_STATUS[param3]);
         _loc4_.StartUp();
         return _loc4_;
      }
      
      protected function SetUpTextNumber(param1:Number, param2:Number, param3:String, param4:uint, param5:uint = 0) : TGoneWord
      {
         var _loc6_:TGoneWord = null;
         if(param3 == null || param3.length <= 0)
         {
            return null;
         }
         _loc6_ = TPoolEffectGoneWord.GetGoneWord();
         this.FEffectSprite.addChild(_loc6_);
         _loc6_.SetGoneWord(param1,param2,param3,0,0,24,param4,param5);
         _loc6_.StartUp();
         return _loc6_;
      }
      
      protected function SetDownText(param1:Number, param2:Number, param3:int) : TGoneWord
      {
         var _loc4_:TGoneWord = null;
         if(param3 < 0 || param3 >= TEXT_FIGHT_STATUS.length)
         {
            return null;
         }
         _loc4_ = TPoolEffectGoneWord.GetGoneWordWithBg();
         this.FEffectSprite.addChild(_loc4_);
         _loc4_.SetGoneWordWithBg(param1,param2,TEXT_FIGHT_STATUS[param3]);
         _loc4_.StartDown();
         return _loc4_;
      }
      
      protected function AddUIStageOnKeyDown() : void
      {
         FUICore.UIStage.addEventListener(KeyboardEvent.KEY_DOWN,this.UIStageOnKeyDown);
      }
      
      protected function RemoveUIStageOnKeyDown() : void
      {
         FUICore.UIStage.removeEventListener(KeyboardEvent.KEY_DOWN,this.UIStageOnKeyDown);
      }
      
      protected function OnBuffMouseMove(param1:Object, param2:String, param3:String, param4:String) : void
      {
         this.IsStop = true;
         if(this.FBuffTips == null)
         {
            this.FBuffTips = TUtilityReflection.CreateDisplayObjectInstance(CONST_BATTLE.RESOURCE_ClassName_BuffTip) as MovieClip;
            this.FEffectSprite.addChild(this.FBuffTips);
         }
         this.FBuffTips.tf_buffName.text = param2;
         this.FBuffTips.tf_buffTurn.text = STRING_BATTLE.RESOURCE_TIPSINFO_TurnHead + param3;
         this.FBuffTips.tf_buffDesc.text = param4;
         this.FBuffTips.x = mouseX + 5;
         this.FBuffTips.y = mouseY;
         this.FBuffTips.visible = true;
      }
      
      protected function OnBuffMouseRollOut(param1:Object) : void
      {
         this.IsStop = false;
         if(this.FBuffTips != null)
         {
            this.FBuffTips.visible = false;
         }
      }
      
      protected function UIStageOnKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:uint = 0;
         if(param1.ctrlKey && param1.altKey && param1.keyCode == KEY_QUOTE)
         {
            Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,this.FBattleInfo.toString());
         }
      }
      
      protected function OnPetRoll(param1:MouseEvent) : void
      {
         var _loc2_:TActive = null;
         var _loc3_:TPetImage = null;
         var _loc4_:TBasePet = null;
         var _loc5_:String = null;
         var _loc6_:TSoulArray = null;
         if(param1.type == MouseEvent.MOUSE_MOVE)
         {
            _loc2_ = param1.currentTarget as TActive;
            _loc3_ = this.FPetImageBins.GetDatebaseByIdentifier(_loc2_.Id) as TPetImage;
            _loc4_ = this.FBasePetBins.GetDatebaseByIdentifier(_loc2_.direction ? uint(this.FBattleInfo.PlayerInfo_1.MountsLevel) : uint(this.FBattleInfo.PlayerInfo_2.MountsLevel)) as TBasePet;
            _loc5_ = _loc4_.NeedTransLv > 0 ? STRING_BATTLE.STRING_TransPetTip : STRING_BATTLE.STRING_PetTip;
            _loc5_ = _loc5_.split("%biglevel%").join(_loc4_.ReviceCount + 1);
            _loc5_ = _loc5_.split("%level%").join(_loc4_.Star);
            _loc5_ = _loc5_.split("%name%").join(_loc3_.Name);
            if(_loc2_.SoulFormationID != 0)
            {
               _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SoulArray,_loc2_.SoulFormationID) as TSoulArray;
               if(this.SoulOnOver != null)
               {
                  this.SoulOnOver(_loc6_,_loc5_);
               }
            }
            else
            {
               this.FHintBtn.Caption = _loc5_;
               if(this.FHintOnMove != null)
               {
                  this.FHintOnMove(this,this.FHintBtn);
               }
            }
         }
         else if(param1.type == MouseEvent.ROLL_OUT)
         {
            if(this.SoulOnOut != null)
            {
               this.SoulOnOut();
            }
            if(this.FHintOnOut != null)
            {
               this.FHintOnOut(this);
            }
         }
      }
      
      public function set CriticalUI(param1:Function) : void
      {
         this.FCriticalUI = param1;
      }
      
      public function get CriticalUI() : Function
      {
         return this.FCriticalUI;
      }
      
      public function set OnChangeBg(param1:Function) : void
      {
         this.FOnChangeBg = param1;
      }
      
      public function get OnChangeBg() : Function
      {
         return this.FOnChangeBg;
      }
      
      public function set OnAntiColorBlackWhiteBg(param1:Function) : void
      {
         this.FOnAntiColorBlackWhiteBg = param1;
      }
      
      public function get OnAntiColorBlackWhiteBg() : Function
      {
         return this.FOnAntiColorBlackWhiteBg;
      }
      
      public function set OnRedAntiColorBg(param1:Function) : void
      {
         this.FOnRedAntiColorBg = param1;
      }
      
      public function get OnRedAntiColorBg() : Function
      {
         return this.FOnRedAntiColorBg;
      }
      
      public function get EffectSprite() : Sprite
      {
         return this.FEffectSprite;
      }
      
      public function get EndStatues() : Boolean
      {
         return this.FEndStatues;
      }
      
      public function get IsCrit() : Boolean
      {
         return this.FIsCrit;
      }
      
      public function set IsCrit(param1:Boolean) : void
      {
         this.FIsCrit = param1;
      }
      
      public function set OnEndBattle(param1:Function) : void
      {
         this.FOnEndBattle = param1;
      }
      
      public function set HintOnMove(param1:Function) : void
      {
         this.FHintOnMove = param1;
      }
      
      public function get HintOnMove() : Function
      {
         return this.FHintOnMove;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set SetTrunNumber(param1:Function) : void
      {
         this.FSetTrunNumber = param1;
      }
      
      public function get SetTrunNumber() : Function
      {
         return this.FSetTrunNumber;
      }
      
      public function set NegotiateBrforeBattle(param1:Function) : void
      {
         this.FNegotiateBrforeBattle = param1;
      }
      
      public function ButtonSkipOnClick() : void
      {
         if(this.FEndStatues)
         {
            return;
         }
         this.FEndStatues = true;
         if(this.FOnEndBattle != null)
         {
            this.FOnEndBattle(this);
         }
      }
      
      public function SetBattle(param1:TGroupRoleInfo, param2:TGroupRoleInfo) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TRole = null;
         var _loc5_:TRoleBattleInfo = null;
         var _loc6_:THeroTalent = null;
         var _loc7_:TSkillConfig = null;
         var _loc8_:Object = null;
         var _loc9_:TSkillAura = null;
         var _loc10_:uint = 0;
         var _loc11_:Array = null;
         var _loc12_:int = 0;
         if(param1 == null || param2 == null || param1.RoleCount <= 0 || param2.RoleCount <= 0)
         {
            return;
         }
         if(param1.MountsId != 0)
         {
            _loc5_ = new TRoleBattleInfo(0);
            _loc5_.RoleId = param1.MountsId;
            _loc5_.SoulFormationID = param1.SoulFormationID;
            this.FMounts_0 = TPoolRole.GetRole(this.FBattleFiled,_loc5_,CONST_MODULES.MODULE_Battle,this,false,this.SetEffectText,param1.SoulFormationID);
            this.FMounts_0.OnEffectEnd = this.NextCommand;
            this.FMounts_0.SetPosition(Pet_1_Point_X,Pet_1_Point_Y);
            this.FMounts_0.direction = true;
            this.FMounts_0.RoleBattleInfo = param1.RoleBattleInfos[0];
            this.FPlayerPetMgr.push(this.FMounts_0);
            this.FMounts_0.addEventListener(MouseEvent.MOUSE_MOVE,this.OnPetRoll);
            this.FMounts_0.addEventListener(MouseEvent.ROLL_OUT,this.OnPetRoll);
            TEffectControl.ShowPublicEffect(this.FMounts_0.BgSprite,CONST_BATTLE.BattlePetEffectId);
         }
         if(param2.MountsId != 0)
         {
            _loc5_ = new TRoleBattleInfo(1);
            _loc5_.RoleId = param2.MountsId;
            _loc5_.SoulFormationID = param2.SoulFormationID;
            this.FMounts_1 = TPoolRole.GetRole(this.FBattleFiled,_loc5_,CONST_MODULES.MODULE_Battle,this,false,this.SetEffectText,param2.SoulFormationID);
            this.FMounts_1.OnEffectEnd = this.NextCommand;
            this.FMounts_1.SetPosition(Pet_2_Point_X,Pet_2_Point_Y);
            this.FMounts_1.direction = false;
            this.FMounts_1.RoleBattleInfo = param2.RoleBattleInfos[0];
            this.FPlayerPetMgr.push(this.FMounts_1);
            this.FMounts_1.addEventListener(MouseEvent.MOUSE_MOVE,this.OnPetRoll);
            this.FMounts_1.addEventListener(MouseEvent.ROLL_OUT,this.OnPetRoll);
            TEffectControl.ShowPublicEffect(this.FMounts_1.BgSprite,CONST_BATTLE.BattlePetEffectId);
         }
         _loc3_ = 0;
         while(_loc3_ < param1.RoleCount)
         {
            if(param1.RoleBattleInfos[_loc3_].CurHealth > 0)
            {
               _loc4_ = TPoolRole.GetRole(this.FBattleFiled,param1.RoleBattleInfos[_loc3_],CONST_MODULES.MODULE_Battle,this,true,this.SetEffectText);
               _loc4_.OnEffectEnd = this.NextCommand;
               _loc4_.OnBuffMouseMove = this.OnBuffMouseMove;
               _loc4_.OnBuffMouseRollOut = this.OnBuffMouseRollOut;
               this.FPlayerRole_0[_loc4_.Pos] = _loc4_;
               this.FPlayerRoleMgr.push(_loc4_);
               if(_loc4_.HeroData)
               {
                  _loc10_ = uint(_loc4_.HeroData.Talent);
               }
               else
               {
                  _loc10_ = uint(_loc4_.EnemyData.TalentId);
               }
               _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroTalent,_loc10_) as THeroTalent;
               if(_loc6_)
               {
                  _loc11_ = null;
                  _loc8_ = _loc6_.TalentEffectObject;
                  if(_loc8_)
                  {
                     _loc11_ = _loc8_["talentEffect"];
                     _loc12_ = 0;
                     while(_loc12_ < _loc11_.length)
                     {
                        _loc8_ = _loc11_[_loc12_];
                        if(_loc8_["tType"] == 203)
                        {
                           _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc8_["tValue"]) as TSkillConfig;
                           _loc8_ = _loc7_.EffectsObject;
                           if(_loc8_)
                           {
                              _loc8_ = _loc8_["effects"];
                              _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillAura,_loc8_[0]) as TSkillAura;
                              if(_loc9_)
                              {
                                 TEffectControl.ShowPublicEffect(_loc4_.BgSprite,_loc9_.ResourceId);
                              }
                           }
                           break;
                        }
                        _loc12_++;
                     }
                  }
               }
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < param2.RoleCount)
         {
            if(param2.RoleBattleInfos[_loc3_].CurHealth > 0)
            {
               _loc4_ = TPoolRole.GetRole(this.FBattleFiled,param2.RoleBattleInfos[_loc3_],CONST_MODULES.MODULE_Battle,this,true,this.SetEffectText);
               _loc4_.OnEffectEnd = this.NextCommand;
               _loc4_.OnBuffMouseMove = this.OnBuffMouseMove;
               _loc4_.OnBuffMouseRollOut = this.OnBuffMouseRollOut;
               this.FPlayerRole_1[_loc4_.Pos] = _loc4_;
               this.FPlayerRoleMgr.push(_loc4_);
               if(_loc4_.HeroData)
               {
                  _loc10_ = uint(_loc4_.HeroData.Talent);
               }
               else
               {
                  _loc10_ = uint(_loc4_.EnemyData.TalentId);
               }
               _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroTalent,_loc10_) as THeroTalent;
               if(_loc6_)
               {
                  _loc8_ = _loc6_.TalentEffectObject;
                  if(_loc8_)
                  {
                     _loc11_ = _loc8_["talentEffect"];
                     _loc12_ = 0;
                     while(_loc12_ < _loc11_.length)
                     {
                        _loc8_ = _loc11_[_loc12_];
                        if(_loc8_["tType"] == 203)
                        {
                           _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc8_["tValue"]) as TSkillConfig;
                           _loc8_ = _loc7_.EffectsObject;
                           if(_loc8_)
                           {
                              _loc8_ = _loc8_["effects"];
                              _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillAura,_loc8_[0]) as TSkillAura;
                              if(_loc9_)
                              {
                                 TEffectControl.ShowPublicEffect(_loc4_.BgSprite,_loc9_.ResourceId);
                              }
                           }
                           break;
                        }
                        _loc12_++;
                     }
                  }
               }
            }
            _loc3_++;
         }
         this.ZBufferSort();
      }
      
      public function CreditCommandList(param1:TBattleInfo) : void
      {
         this.FEndStatues = false;
         this.FBattleInfo = param1;
         this.SetBattle(param1.PlayerInfo_1,param1.PlayerInfo_2);
         this.MakeCommandList(param1.TotleTurn,param1.TurnInfos);
         if(this.FBuffTips != null)
         {
            this.FBuffTips.visible = false;
         }
         if(!SLogicsCore.Character.IsSkillShowTime)
         {
            this.AddUIStageOnKeyDown();
         }
         setTimeout(this.NextCommand,1500);
      }
      
      public function NextCommand() : void
      {
         var i:int;
         var ConfusionAttack:Function;
         var Index:int = 0;
         var Source:TRole = null;
         var Role:TRole = null;
         var CommandObj:Object = null;
         var TargetVect:Vector.<TRole> = null;
         var ResultVect:Vector.<TTargetInfo> = null;
         var TargetInfo:TTargetInfo = null;
         var RoleBattleInfo:TRoleBattleInfo = null;
         var RoleCamp:int = 0;
         var IndexJ:int = 0;
         if(this.FEndStatues)
         {
            return;
         }
         if(this.FNegotiateBrforeBattle != null)
         {
            this.FNegotiateBrforeBattle();
         }
         if(this.FConfusionRole != null)
         {
            this.FConfusionRole.Visible = false;
         }
         if(this.FCommandList.length <= 0)
         {
            setTimeout(this.ButtonSkipOnClick,1000);
            return;
         }
         CommandObj = this.FCommandList.shift();
         if(SLogicsCore.Character.IsSkillShowTime)
         {
            this.FCommandList.push(CommandObj);
         }
         if(CommandObj)
         {
            if(CommandObj.checkBuff == 1 && Boolean(CommandObj.play))
            {
               Role = CommandObj.play;
               Role.CheckBuffs(0);
               this.NextCommand();
            }
            else if(CommandObj.ResetHp)
            {
               Role = CommandObj.play;
               TargetInfo = CommandObj.result;
               Role.TotleHealth = TargetInfo.ResultInfo.CurAllHp;
               Role.CurHealth = TargetInfo.ResultInfo.CurHp;
               this.NextCommand();
            }
            else if(CommandObj.checkTurn == 1)
            {
               if(this.FSetTrunNumber != null)
               {
                  this.FSetTrunNumber(CommandObj.turnNumber);
               }
               this.NextCommand();
            }
            else if(CommandObj.checkBuff == 2 && Boolean(CommandObj.play))
            {
               Role = CommandObj.play;
               Role.CheckBuffs(1);
               this.NextCommand();
            }
            else if(CommandObj.chgNewBuffs == 1)
            {
               Index = 0;
               while(Index < this.FPlayerRoleMgr.length)
               {
                  Role = this.FPlayerRoleMgr[Index];
                  Role.ChgNewBuffs();
                  Index++;
               }
               this.NextCommand();
            }
            else if(Boolean(CommandObj.checkBuffHurt) && Boolean(CommandObj.play))
            {
               Role = CommandObj.play;
               Role.CheckBuffsHurt(CommandObj.result);
               setTimeout(this.NextCommand,200);
            }
            else if(Boolean(CommandObj.addBuff) && Boolean(CommandObj.play))
            {
               Source = CommandObj.Source;
               Role = CommandObj.play;
               Role.AddBuffs(Source,CommandObj.result);
               setTimeout(this.NextCommand,200);
            }
            else if(Boolean(CommandObj.checkDie) && Boolean(CommandObj.play))
            {
               Role = CommandObj.play;
               Role.CheckDie();
               setTimeout(this.NextCommand,200);
            }
            else if(Boolean(CommandObj.chgPosition) && Boolean(CommandObj.play))
            {
               Role = CommandObj.play;
               Role.ChgPosition(CommandObj.result);
               this.NextCommand();
            }
            else if(CommandObj.addStatus)
            {
               TargetVect = CommandObj.target;
               ResultVect = CommandObj.result;
               Index = 0;
               while(Index < TargetVect.length)
               {
                  TargetVect[Index].AddStatus(ResultVect[Index]);
                  Index++;
               }
               this.NextCommand();
            }
            else if(CommandObj.skillEffect)
            {
               Role = CommandObj.play;
               TEffectControl.ShowPublicEffect(Role,CONST_BATTLE.Public_Effect_PetAttackEffect,0,0,this.NextCommand);
            }
            else if(CommandObj.PassiveSkill)
            {
               Role = CommandObj.play;
               Role.PassiveSkillPlay(CommandObj.target,CommandObj.result,CommandObj.time);
            }
            else if(CommandObj.NewSkill)
            {
               Role = CommandObj.play;
               Role.NewSkillPlay(CommandObj.target,CommandObj.result,CommandObj.time);
            }
            else if(CommandObj.NewBuff)
            {
               Role = CommandObj.play;
               Role.NewTextBuffPlay(CommandObj.target,CommandObj.BuffID,CommandObj.time);
            }
            else if(CommandObj.confusionPlay)
            {
               ConfusionAttack = function():void
               {
                  if(FConfusionRole)
                  {
                     FConfusionRole.CommandPlay(CommandObj.skillid,CommandObj.target,CommandObj.result,CommandObj.time);
                  }
               };
               Role = CommandObj.confusionPlay;
               if(!CommandObj.hasEnemy)
               {
                  RoleCamp = (Role.RoleInfo.Camp + 1) % 2;
               }
               else
               {
                  RoleCamp = Role.RoleInfo.Camp;
               }
               RoleBattleInfo = Role.RoleInfo.Clone(RoleCamp);
               if(this.FConfusionRole == null)
               {
                  this.FConfusionRole = TPoolRole.GetRole(this.FBattleFiled,RoleBattleInfo,CONST_MODULES.MODULE_Battle,this,true);
                  this.FConfusionRole.OnEffectEnd = this.NextCommand;
                  this.FConfusionRole.Visible = true;
               }
               else
               {
                  this.FConfusionRole.ResetRole(this.FBattleFiled,RoleBattleInfo,CONST_MODULES.MODULE_Battle,this,true);
                  this.FConfusionRole.Visible = true;
               }
               this.FConfusionRole.SetPosition(CONST_COMMON.STAGE_Width / 2,SBattleConfig.GetPostionByCamyPos(0,1,SBattleConfig.Type_PostionY));
               setTimeout(ConfusionAttack,500);
            }
            else if(Boolean(CommandObj.relive) && Boolean(CommandObj.play))
            {
               setTimeout(function():void
               {
                  Role = CommandObj.play;
                  RoleBattleInfo = Role.RoleInfo.Clone(Role.RoleInfo.Camp);
                  Role.ResetRole(FBattleFiled,RoleBattleInfo,CONST_MODULES.MODULE_Battle,Role.BattleStage,true,SetEffectText);
                  TargetInfo = CommandObj.result;
                  Role.TotleHealth = TargetInfo.ResultInfo.CurAllHp;
                  Role.CurHealth = TargetInfo.ResultInfo.CurHp;
                  setTimeout(function():void
                  {
                     Role.CommandPlay(CommandObj.skillid,null,null,CommandObj.time);
                  },50);
                  setTimeout(NextCommand,200);
               },1000);
            }
            else if(CommandObj.hurtHp)
            {
               TargetVect = CommandObj.target;
               ResultVect = CommandObj.result;
               Index = 0;
               while(Index < TargetVect.length)
               {
                  IndexJ = 0;
                  while(IndexJ < ResultVect.length)
                  {
                     if(TargetVect[Index].Pos == ResultVect[IndexJ].TargetPos)
                     {
                        TargetVect[Index].CurHealth -= ResultVect[IndexJ].ResultInfo.HurtHp;
                        TargetVect[Index].CommandPlay(CommandObj.skillid,null,new <TTargetInfo>[ResultVect[IndexJ]],0);
                        break;
                     }
                     IndexJ++;
                  }
                  Index++;
               }
               setTimeout(this.NextCommand,200);
            }
            else if(CommandObj.play)
            {
               this.FIsCrit = CommandObj.crit;
               Role = CommandObj.play;
               Role.CommandPlay(CommandObj.skillid,CommandObj.target,CommandObj.result,CommandObj.time);
            }
            else if(this.FIsHadBoom)
            {
               TargetVect = CommandObj.target;
               ResultVect = CommandObj.result;
               Index = 0;
               while(Index < TargetVect.length)
               {
                  Role = TargetVect[Index];
                  TEffectControl.ShowEffect(Role,BOOM_EFFECT_ID,{
                     "target":1,
                     "anmyhp":{
                        "3":100,
                        "checkDie":1
                     }
                  },null,null,Vector.<TRole>([Role]),Vector.<TTargetInfo>([ResultVect[Index]]),0,0,0,0,this.SetEffectText,0,0,0,-1);
                  Index++;
               }
               setTimeout(this.NextCommand,1500);
            }
            else
            {
               this.NextCommand();
            }
         }
         i = 0;
      }
      
      public function Reset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TRole = null;
         while(this.FPlayerRoleMgr.length)
         {
            _loc2_ = this.FPlayerRoleMgr.pop();
            if(_loc2_ != null)
            {
               TPoolRole.SaveRole(_loc2_);
            }
         }
         if(this.FConfusionRole)
         {
            TPoolRole.SaveRole(this.FConfusionRole);
            this.FConfusionRole = null;
         }
         while(this.FPlayerPetMgr.length)
         {
            _loc2_ = this.FPlayerPetMgr.pop();
            _loc2_.removeEventListener(MouseEvent.MOUSE_MOVE,this.OnPetRoll);
            _loc2_.removeEventListener(MouseEvent.ROLL_OUT,this.OnPetRoll);
            TEffectControl.RemovePublicEffect(_loc2_.BgSprite,CONST_BATTLE.BattlePetEffectId);
            if(_loc2_ != null)
            {
               TPoolRole.SaveRole(_loc2_);
            }
         }
         this.FCommandList.length = 0;
         this.FPlayerRoleMgr.length = 0;
         this.FPlayerPetMgr.length = 0;
         this.FPlayerRole_0 = new Dictionary(true);
         this.FPlayerRole_1 = new Dictionary(true);
         this.FMounts_0 = null;
         this.FMounts_1 = null;
         this.RemoveUIStageOnKeyDown();
      }
      
      public function ShowWhiteSprite() : void
      {
         var HideWhiteSprite:Function = null;
         HideWhiteSprite = function():void
         {
            FWhiteSprite.visible = false;
         };
         if(this.FWhiteSprite == null)
         {
            this.FWhiteSprite = new Sprite();
            this.FWhiteSprite.graphics.beginFill(16777215);
            this.FWhiteSprite.graphics.drawRect(0,0,1250,650);
            this.FWhiteSprite.graphics.endFill();
         }
         addChild(this.FWhiteSprite);
         this.FWhiteSprite.visible = true;
         setTimeout(HideWhiteSprite,70);
      }
      
      public function ChangeBg(param1:Object, param2:uint) : void
      {
         if(this.FOnChangeBg != null)
         {
            this.FOnChangeBg(param1,param2);
         }
      }
      
      public function FullScreenGradient(param1:Object, param2:uint, param3:uint) : void
      {
         var HideFullScreenGradientSprite:Function = null;
         var Sender:Object = param1;
         var Color:uint = param2;
         var time:uint = param3;
         HideFullScreenGradientSprite = function():void
         {
            FColorSprite.visible = false;
         };
         if(this.FColorSprite == null)
         {
            this.FColorSprite = new Sprite();
         }
         this.FColorSprite.graphics.clear();
         this.FColorSprite.graphics.beginFill(Color);
         this.FColorSprite.graphics.drawRect(0,0,1250,650);
         this.FColorSprite.graphics.endFill();
         addChild(this.FColorSprite);
         this.FColorSprite.visible = true;
         this.FColorSprite.alpha = 1;
         TweenUtil.to(this.FColorSprite,time,{
            "alpha":0.5,
            "onComplete":HideFullScreenGradientSprite
         });
      }
      
      public function AntiColorBlackWhite(param1:TRole, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TRole = null;
         _loc3_ = 0;
         while(_loc3_ < this.FPlayerRoleMgr.length)
         {
            _loc4_ = this.FPlayerRoleMgr[_loc3_];
            if(param2)
            {
               if(_loc4_ != param1)
               {
                  _loc4_.AntiColorBlackWhite = true;
               }
            }
            else
            {
               _loc4_.AntiColorBlackWhite = false;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.FPlayerPetMgr.length)
         {
            _loc4_ = this.FPlayerPetMgr[_loc3_];
            _loc4_.AntiColorBlackWhite = param2;
            _loc3_++;
         }
         if(this.FOnAntiColorBlackWhiteBg != null)
         {
            this.FOnAntiColorBlackWhiteBg(this,param2);
         }
      }
      
      public function RedAntiColor(param1:TRole, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TRole = null;
         _loc3_ = 0;
         while(_loc3_ < this.FPlayerRoleMgr.length)
         {
            _loc4_ = this.FPlayerRoleMgr[_loc3_];
            if(param2)
            {
               if(_loc4_ != param1)
               {
                  _loc4_.RedAntiColor = true;
               }
            }
            else
            {
               _loc4_.RedAntiColor = false;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.FPlayerPetMgr.length)
         {
            _loc4_ = this.FPlayerPetMgr[_loc3_];
            _loc4_.RedAntiColor = param2;
            _loc3_++;
         }
         if(this.FOnRedAntiColorBg != null)
         {
            this.FOnRedAntiColorBg(this,param2);
         }
      }
      
      public function ShowBigEffect(param1:int = 0) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:Bitmap = null;
         if(param1 < 0)
         {
            _loc2_ = 0;
            _loc3_ = 20;
            _loc4_ = _loc2_ - 250;
            _loc5_ = 20;
            _loc6_ = 1;
            _loc7_ = 300;
         }
         else
         {
            if(param1 <= 0)
            {
               return;
            }
            _loc2_ = CONST_COMMON.STAGE_Width;
            _loc3_ = 20;
            _loc4_ = _loc2_ + 250;
            _loc5_ = 20;
            _loc6_ = -1;
            _loc7_ = 300;
         }
         _loc8_ = TPoolBitmap.GetBitmap();
         _loc8_.x = _loc2_;
         _loc8_.y = _loc3_;
         _loc8_.scaleX = _loc6_;
         TEffectControl.ShowMoveEffect(_loc8_,_loc4_,_loc5_,_loc7_,this.EndBigEffect);
         _loc8_ = TPoolBitmap.GetBitmap();
         _loc8_.x = _loc2_;
         _loc8_.y = CONST_COMMON.STAGE_Height - 180 - _loc3_;
         _loc8_.scaleX = _loc6_;
         TEffectControl.ShowMoveEffect(_loc8_,_loc4_,_loc5_,_loc7_,this.EndBigEffect);
      }
      
      protected function EndBigEffect(param1:DisplayObjectContainer) : void
      {
         if(param1 != null && param1 is Bitmap)
         {
            TPoolBitmap.SaveBitmap(param1 as Bitmap);
         }
      }
      
      public function SetEffectText(param1:int, param2:int = 0, param3:Number = 0, param4:Number = 0, param5:String = "0", param6:Boolean = false, param7:int = 0, param8:uint = 16777215, param9:uint = 0, param10:Boolean = false) : TGoneWord
      {
         if(SLogicsCore.Character.IsSkillShowTime)
         {
            return null;
         }
         if(param1 == TYPETEXT_FloatCopy)
         {
            this.SetFloatTextCopy(param2,param3,param4,param5);
         }
         else if(param1 == TYPETEXT_Float)
         {
            this.SetFloatText(param2,param3,param4,param5,param6,param7,param10);
         }
         else if(param1 == TYPETEXT_Up)
         {
            this.SetUpText(param3,param4,param7);
         }
         else if(param1 == TYPETEXT_Down)
         {
            this.SetDownText(param3,param4,param7);
         }
         else if(param1 == TYPETEXT_Stand)
         {
            this.SetStandText(param3,param4,param7);
         }
         else
         {
            if(param1 == TYPETEXT_Hold)
            {
               return this.SetHoldText(param3,param4,param7);
            }
            if(param1 == TYPETEXT_UpNumber)
            {
               return this.SetUpTextNumber(param3,param4,param5,param8,param9);
            }
         }
         return null;
      }
   }
}

