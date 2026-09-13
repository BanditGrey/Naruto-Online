package Processors.Game.TopTeamBattle
{
   import Foundation.Common.Integer.UInt64;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Battle.model.TBattleInfo;
   import Logics.Battle.model.TRoleBattleInfo;
   import Logics.ChatOptions.TChatOptions;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.TEnemy;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.DatebaseVO.VO.TSkillConfig;
   import Logics.GroupBattle.TGroupBattleRewards;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Battle.TUnstreamizerBattleRepot;
   import Processors.Game.Battle.Effect.TEffectControl;
   import Processors.Game.GroupBattle.TBattleLine;
   import Processors.Game.TProcessorGame;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_CHAT;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_GROUPBATTLE;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_MUSIC;
   import Resources.Constants.CONST_SIGNAL;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   import ghostcat.util.data.Json;
   
   public class TTopTeamStage extends TProcessorGame
   {
      
      protected static const MAX_PLAYERCOUNT:uint = 3;
      
      protected static const MAX_TURN:uint = 3;
      
      protected static const MAX_COUNT:uint = 3;
      
      public static const PLAY_SCENE_Nodal:uint = CONST_MUSIC.PLAY_SCENE_Nodal;
      
      public static const PLAY_SCENE_Campaign:uint = CONST_MUSIC.PLAY_SCENE_Campaign;
      
      public static const PLAY_SCENE_KillHeros:uint = CONST_MUSIC.PLAY_SCENE_KillHeros;
      
      public static const PLAY_SCENE_Arena:uint = CONST_MUSIC.PLAY_SCENE_Arena;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const CONST_STAGE_Point:Vector.<Object> = Vector.<Object>([[[0,0]],[[0,-100],[0,70]],[[-87,-85],[0,0],[82,89]]]);
      
      protected var FScene:MovieClip;
      
      protected var FBattleLineVect:Vector.<TBattleLine>;
      
      protected var FBattleType:uint;
      
      protected var FUnstreamizerBattleRepot:TUnstreamizerBattleRepot;
      
      protected var FTurnReports:Vector.<Vector.<TBattleInfo>>;
      
      protected var FTurnReportIndex:uint;
      
      protected var FIsInFight:Boolean;
      
      protected var FWinType:uint;
      
      protected var FBattleTurn:uint;
      
      protected var FLeaguePointPathBins:TBins;
      
      protected var FLeagueMapPveBins:TBins;
      
      protected var FEnemyArmyBins:TBins;
      
      protected var FRoleModelBins:TBins;
      
      protected var FEnemyBins:TBins;
      
      protected var FBaseHeroBins:TBins;
      
      protected var FPlayerIds:Vector.<uint>;
      
      protected var FEnemyIds:Vector.<uint>;
      
      protected var FPlayerNames:Vector.<String>;
      
      protected var FEnemyNames:Vector.<String>;
      
      protected var FPlayerLevel:Vector.<uint>;
      
      protected var FEnemyLevel:Vector.<uint>;
      
      protected var FPlayerUIDLow:Vector.<uint>;
      
      protected var FEnemyUIDLow:Vector.<uint>;
      
      protected var FPlayerUIDHigh:Vector.<uint>;
      
      protected var FEnemyUIDHigh:Vector.<uint>;
      
      protected var FProcessorBattleLoading:TTopTeamLoading;
      
      protected var FTopTeamWindow:TTopTeamWindow;
      
      protected var FTopTeamWindowWin:TTopTeamWindowWin;
      
      protected var FModelVect:Vector.<int>;
      
      protected var FSkillVect:Vector.<int>;
      
      protected var FGroupBattleRewardsVect:Vector.<TGroupBattleRewards>;
      
      protected var FOverlayerEquipment:TOverlayerEquipment;
      
      protected var FOverlayerTreasure:TOverlayerTreasure;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FOverlayerAccessory:TOverlayerAccessory;
      
      protected var FResourcesLoad:Boolean;
      
      protected var FInit:Boolean;
      
      protected var FTurnBackTopTeam:Function;
      
      protected var FOnQuit:Function;
      
      protected var FOnInitGroupBattle:Function;
      
      protected var FRoleModel:TRoleModel;
      
      public function TTopTeamStage(param1:TUIComponent)
      {
         var _loc2_:uint = 0;
         var _loc3_:TBattleLine = null;
         super(param1);
         this.FTurnReports = new Vector.<Vector.<TBattleInfo>>(MAX_TURN);
         this.FUnstreamizerBattleRepot = new TUnstreamizerBattleRepot();
         this.FModelVect = new Vector.<int>();
         this.FSkillVect = new Vector.<int>();
         this.FTopTeamWindow = new TTopTeamWindow(this);
         this.FTopTeamWindow.OnSkipBattle = this.OnSkipBattle;
         this.FBattleLineVect = new Vector.<TBattleLine>(MAX_COUNT);
         _loc2_ = 0;
         while(_loc2_ < MAX_COUNT)
         {
            _loc3_ = new TBattleLine(this);
            _loc3_.x = -50 + 50 * _loc2_;
            _loc3_.y = 100 + 180 * _loc2_;
            _loc3_.EndFight = this.CheckEndFight;
            this.FBattleLineVect[_loc2_] = _loc3_;
            _loc2_++;
         }
         this.FBattleType = CONST_GROUPBATTLE.BattleType_PVP;
         this.FGroupBattleRewardsVect = new Vector.<TGroupBattleRewards>();
         this.FResourcesLoad = false;
         this.FInit = false;
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TBattleLine = null;
         super.LogicsPerform();
         if(Visible == false)
         {
            return;
         }
         TEffectControl.UpdataRoleEffect();
         TEffectControl.UpdataPublicEffect();
         this.FTopTeamWindow.UpdataPlayerHead();
         if(Boolean(this.FTopTeamWindowWin) && this.FTopTeamWindowWin.Visible)
         {
            this.FTopTeamWindowWin.Updata();
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfBattle.LoadPrimary(CONST_BATTLE.RESOURCE_Battle);
         SResourcesCore.TexturesSwfBattle.LoadPrimary(CONST_BATTLE.RESOURCE_GroupBattle);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         if(this.FInit)
         {
            return;
         }
         this.FProcessorBattleLoading = new TTopTeamLoading(this);
         this.FProcessorBattleLoading.OnLoadingCompleted = this.LoadResourcesEnd;
         this.FProcessorBattleLoading.OnStartBattle = this.OnStartBattle;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_BATTLE.RESOURCE_ClassName_TopTeamBattle_Main) as MovieClip;
         addChild(this.FScene);
         this.FTopTeamWindow.SetScene(this.FScene);
         this.FTopTeamWindowWin = new TTopTeamWindowWin(this);
         this.FTopTeamWindowWin.OnClose = this.OnReturnTopTeam;
         this.FTopTeamWindowWin.Init();
         this.FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_TopTeam);
         this.FOverlayerEquipment.Visible = false;
         this.FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_TopTeam);
         this.FOverlayerTreasure.Visible = false;
         this.FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_TopTeam);
         this.FOverlayerAppliance.Visible = false;
         this.FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_TopTeam);
         this.FOverlayerAccessory.Visible = false;
         this.FOverlayerAccessory.IsMeOrOthers = 0;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAccessory);
         if(this.FResourcesLoad)
         {
            this.LoadResources();
            this.FResourcesLoad = false;
         }
         this.FInit = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function StartFight() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:Vector.<TBattleInfo> = null;
         var _loc4_:TBattleLine = null;
         var _loc5_:TBattleInfo = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc3_ = this.FTurnReports[this.FTurnReportIndex];
         _loc2_ = _loc3_.length;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc4_ = this.FBattleLineVect[_loc1_];
            if(_loc1_ < _loc2_)
            {
               _loc5_ = _loc3_[_loc1_];
               _loc4_.SetBattleInfo(_loc5_,this.FBattleType);
               _loc4_.x = CONST_STAGE_Point[_loc2_ - 1][_loc1_][0];
               _loc4_.y = CONST_STAGE_Point[_loc2_ - 1][_loc1_][1];
               _loc4_.Visible = true;
               this.CheckResources(_loc4_.FightReport);
               _loc6_ = _loc4_.FightReport.PlayerInfo_1.RoleBattleInfos[0].RoleName;
               _loc7_ = _loc4_.FightReport.PlayerInfo_2.RoleBattleInfos[0].RoleName;
               this.FTopTeamWindow.AddFightReport(_loc6_,_loc7_,_loc5_.GroupBattleData.FightResult,_loc5_.GroupBattleData.FightReportId);
               _loc8_ = this.FPlayerNames.indexOf(_loc6_);
               _loc9_ = this.FEnemyNames.indexOf(_loc7_);
               this.FTopTeamWindow.SetPlayerStatus(_loc8_,CONST_GROUPBATTLE.FightStatus_Fighting,_loc9_,CONST_GROUPBATTLE.FightStatus_Fighting);
            }
            else
            {
               _loc4_.Visible = false;
            }
            _loc1_++;
         }
         ++this.FTurnReportIndex;
      }
      
      protected function CheckResources(param1:TBattleInfo) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<TRoleBattleInfo> = null;
         var _loc4_:TRoleBattleInfo = null;
         var _loc5_:TBaseHero = null;
         var _loc6_:TEnemy = null;
         var _loc7_:Object = null;
         var _loc8_:TRoleModel = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         if(this.FRoleModelBins == null)
         {
            this.FRoleModelBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
         }
         if(this.FEnemyBins == null)
         {
            this.FEnemyBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Enemy);
         }
         if(this.FBaseHeroBins == null)
         {
            this.FBaseHeroBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
         }
         _loc3_ = param1.PlayerInfo_1.RoleBattleInfos;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc2_];
            _loc8_ = this.FRoleModelBins.GetDatebaseByIdentifier(_loc4_.RoleId) as TRoleModel;
            if(this.FModelVect.indexOf(_loc8_.Model) < 0)
            {
               this.FModelVect.push(_loc8_.Model);
            }
            if(_loc4_.RoleId > 12101000)
            {
               _loc6_ = this.FEnemyBins.GetDatebaseByIdentifier(_loc4_.RoleId) as TEnemy;
               _loc7_ = Json.decode(_loc6_.Effects);
               _loc9_ = uint(_loc6_.Normal);
               _loc10_ = uint(_loc6_.Skill);
            }
            else
            {
               _loc5_ = this.FBaseHeroBins.GetDatebaseByIdentifier(_loc4_.RoleId) as TBaseHero;
               _loc7_ = Json.decode(_loc5_.AttackEffect);
               _loc9_ = uint(_loc5_.NormalAttack);
               _loc10_ = uint((SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc4_.SkillId) as TSkillConfig).SkillId);
            }
            this.CheckEffect(_loc7_[_loc9_],this.FSkillVect);
            if(_loc7_[_loc10_] == null)
            {
               throw new Error("SkillId:" + _loc10_ + "在EffectObj内未能找到");
            }
            this.CheckEffect(_loc7_[_loc10_],this.FSkillVect);
            _loc2_++;
         }
         _loc3_ = param1.PlayerInfo_2.RoleBattleInfos;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc2_];
            _loc8_ = this.FRoleModelBins.GetDatebaseByIdentifier(_loc4_.RoleId) as TRoleModel;
            if(this.FModelVect.indexOf(_loc8_.Model) < 0)
            {
               this.FModelVect.push(_loc8_.Model);
            }
            if(_loc4_.RoleId > 12101000)
            {
               _loc6_ = this.FEnemyBins.GetDatebaseByIdentifier(_loc4_.RoleId) as TEnemy;
               _loc7_ = Json.decode(_loc6_.Effects);
               _loc9_ = uint(_loc6_.Normal);
               _loc10_ = uint(_loc6_.Skill);
            }
            else
            {
               _loc5_ = this.FBaseHeroBins.GetDatebaseByIdentifier(_loc4_.RoleId) as TBaseHero;
               _loc7_ = Json.decode(_loc5_.AttackEffect);
               _loc9_ = uint(_loc5_.NormalAttack);
               _loc10_ = uint((SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc4_.SkillId) as TSkillConfig).SkillId);
            }
            this.CheckEffect(_loc7_[_loc9_],this.FSkillVect);
            if(_loc7_[_loc10_] == null)
            {
               throw new Error("SkillId:" + _loc10_ + "在EffectObj内未能找到");
            }
            this.CheckEffect(_loc7_[_loc10_],this.FSkillVect);
            _loc2_++;
         }
         if(this.FInit)
         {
            this.LoadResources();
         }
         else
         {
            this.FResourcesLoad = true;
            FResourcesState = RESOURCESSTATE_UIRequest;
         }
      }
      
      protected function CheckEffect(param1:Object, param2:Vector.<int>) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc6_:uint = 0;
         if(param1 == null)
         {
         }
         _loc5_ = param1.appendEffect;
         if(_loc5_ != null)
         {
            for(_loc4_ in _loc5_)
            {
               _loc6_ = uint(_loc5_[_loc4_].effectId);
               if(_loc6_)
               {
                  if(param2.indexOf(_loc6_) < 0)
                  {
                     param2.push(_loc6_);
                  }
               }
               this.CheckEffect(_loc5_[_loc4_],param2);
            }
         }
      }
      
      protected function LoadResources() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<uint> = null;
         if(this.FOnInitGroupBattle != null)
         {
            this.FOnInitGroupBattle(this);
         }
         this.FProcessorBattleLoading.StartLoading(this.FBattleTurn);
         if(this.FScene != null)
         {
            this.FScene.visible = false;
         }
         _loc2_ = CONST_BATTLE.COMMON_EffectVect;
         SResourcesCore.TexturesSwfSkill.LoadPrimary(CONST_BATTLE.EFFECT_BIGBLACK_ID);
         SResourcesCore.TexturesSwfSkill.LoadPrimary(CONST_BATTLE.BATTLE_BIGBLACK_ID);
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            SResourcesCore.TexturesSwfSkill.LoadPrimary(_loc2_[_loc1_]);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FModelVect.length)
         {
            SResourcesCore.TexturesModel.LoadPrimary(this.FModelVect[_loc1_],CONST_MODULES.MODULE_TopTeam);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FSkillVect.length)
         {
            SResourcesCore.TexturesSwfSkill.LoadPrimary(this.FSkillVect[_loc1_]);
            _loc1_++;
         }
         FResourcesState = RESOURCESSTATE_UIRequest;
      }
      
      protected function LoadResourcesEnd(param1:Object = null) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(PLAY_SCENE_Arena);
         SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_SOUND,_loc2_,0,true);
         this.FProcessorBattleLoading.EndLoading();
      }
      
      protected function OnStartBattle(param1:Object = null) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TBattleLine = null;
         if(this.FScene != null)
         {
            this.FScene.visible = true;
            this.FTopTeamWindow.UpdataReport();
         }
         _loc2_ = 0;
         while(_loc2_ < MAX_COUNT)
         {
            _loc3_ = this.FBattleLineVect[_loc2_];
            if(_loc3_.Visible)
            {
               _loc3_.StartBattle();
            }
            _loc2_++;
         }
      }
      
      public function UnLoadResources() : void
      {
         var _loc1_:int = 0;
         TEffectControl.RemoveAllEffect();
         if(this.FModelVect != null)
         {
            this.FModelVect.length = 0;
         }
         if(this.FSkillVect != null)
         {
            this.FSkillVect.length = 0;
         }
         this.FTopTeamWindow.UnLoadBackGround();
      }
      
      protected function CheckEndFight(param1:Object) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TBattleLine = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc3_ = param1 as TBattleLine;
         _loc4_ = _loc3_.FightReport.PlayerInfo_1.RoleBattleInfos[0].RoleName;
         _loc5_ = _loc3_.FightReport.PlayerInfo_2.RoleBattleInfos[0].RoleName;
         _loc6_ = this.FPlayerNames.indexOf(_loc4_);
         _loc7_ = this.FEnemyNames.indexOf(_loc5_);
         _loc8_ = _loc3_.FightReport.GroupBattleData.FightResult == 0 ? CONST_GROUPBATTLE.FightStatus_Waiting : CONST_GROUPBATTLE.FightStatus_Lost;
         _loc9_ = _loc3_.FightReport.GroupBattleData.FightResult == 0 ? CONST_GROUPBATTLE.FightStatus_Lost : CONST_GROUPBATTLE.FightStatus_Waiting;
         this.FTopTeamWindow.SetPlayerStatus(_loc6_,_loc8_,_loc7_,_loc9_);
         _loc2_ = 0;
         while(_loc2_ < MAX_COUNT)
         {
            _loc3_ = this.FBattleLineVect[_loc2_];
            if(_loc3_.InFight)
            {
               return;
            }
            _loc2_++;
         }
         setTimeout(this.EndFight,2000);
      }
      
      protected function EndFight() : void
      {
         if(this.FTurnReportIndex < this.FTurnReports.length)
         {
            ++this.FBattleTurn;
            if(this.FTurnReports[this.FTurnReportIndex] != null)
            {
               this.StartFight();
               return;
            }
         }
         this.FIsInFight = false;
         this.FTopTeamWindowWin.Visible = true;
         this.FTopTeamWindowWin.SetGroupBattleWinRewards(this.FGroupBattleRewardsVect,this.FWinType);
      }
      
      protected function OnReturnTopTeam(param1:Object) : void
      {
         this.ResetTopTeamBattle();
         if(this.FOnQuit != null)
         {
            this.FOnQuit(this);
         }
         switch(this.FBattleType)
         {
            case CONST_GROUPBATTLE.BattleType_PVE:
               this.FTurnBackTopTeam(this);
               this.UnLoadResources();
               break;
            case CONST_GROUPBATTLE.BattleType_PVP:
               this.FTurnBackTopTeam(this);
               this.UnLoadResources();
         }
      }
      
      protected function ResetTopTeamBattle() : void
      {
         this.FTurnReports = new Vector.<Vector.<TBattleInfo>>(MAX_TURN);
         this.FTurnReportIndex = 0;
      }
      
      protected function UIComponentsOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               _loc4_ = this.FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc4_ = this.FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = this.FOverlayerAccessory;
               break;
            default:
               _loc4_ = this.FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function UIComponentsOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               _loc4_ = this.FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc4_ = this.FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = this.FOverlayerAccessory;
               break;
            default:
               _loc4_ = this.FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
      }
      
      protected function OnSkipBattle(param1:Object) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TBattleLine = null;
         _loc2_ = 0;
         while(_loc2_ < MAX_COUNT)
         {
            _loc3_ = this.FBattleLineVect[_loc2_];
            if(_loc3_.Visible)
            {
               _loc3_.SkipBattle();
            }
            _loc2_++;
         }
      }
      
      public function get Active() : Boolean
      {
         return this.Visible;
      }
      
      public function get Loading() : Boolean
      {
         if(this.FProcessorBattleLoading == null)
         {
            return false;
         }
         return this.FProcessorBattleLoading.Visible;
      }
      
      public function ChatOptionsSetup(param1:TChatOptions) : void
      {
         param1.ChatStatus = CONST_CHAT.MODE_None;
      }
      
      public function get TurnBackTopTeam() : Function
      {
         return this.FTurnBackTopTeam;
      }
      
      public function set TurnBackTopTeam(param1:Function) : void
      {
         this.FTurnBackTopTeam = param1;
      }
      
      public function get OnQuit() : Function
      {
         return this.FOnQuit;
      }
      
      public function set OnQuit(param1:Function) : void
      {
         this.FOnQuit = param1;
      }
      
      public function get OnInitGroupBattle() : Function
      {
         return this.FOnInitGroupBattle;
      }
      
      public function set OnInitGroupBattle(param1:Function) : void
      {
         this.FOnInitGroupBattle = param1;
      }
      
      public function SetTopTeamBattleType(param1:Object, param2:ByteArray) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:int = 0;
         this.FPlayerUIDLow = new Vector.<uint>(MAX_PLAYERCOUNT);
         this.FEnemyUIDLow = new Vector.<uint>(MAX_PLAYERCOUNT);
         this.FPlayerUIDHigh = new Vector.<uint>(MAX_PLAYERCOUNT);
         this.FEnemyUIDHigh = new Vector.<uint>(MAX_PLAYERCOUNT);
         this.FPlayerIds = new Vector.<uint>(MAX_PLAYERCOUNT);
         this.FPlayerNames = new Vector.<String>(MAX_PLAYERCOUNT);
         this.FPlayerLevel = new Vector.<uint>(MAX_PLAYERCOUNT);
         _loc5_ = TUtilityString.FetchUTF(param2);
         _loc6_ = TUtilityString.FetchUTF(param2);
         _loc4_ = uint(param2.readShort());
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc10_ = param2.readUnsignedInt();
            _loc11_ = param2.readUnsignedInt();
            this.FPlayerUIDHigh[_loc3_] = _loc10_;
            this.FPlayerUIDLow[_loc3_] = _loc11_;
            this.FPlayerLevel[_loc3_] = param2.readUnsignedInt();
            _loc12_ = int(param2.readUnsignedInt());
            this.FRoleModel = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc12_) as TRoleModel;
            this.FPlayerIds[_loc3_] = this.FRoleModel.Model;
            this.FPlayerNames[_loc3_] = TUtilityString.FetchUTF(param2);
            _loc3_++;
         }
         this.FEnemyIds = new Vector.<uint>(MAX_PLAYERCOUNT);
         this.FEnemyNames = new Vector.<String>(MAX_PLAYERCOUNT);
         this.FEnemyLevel = new Vector.<uint>(MAX_PLAYERCOUNT);
         _loc7_ = TUtilityString.FetchUTF(param2);
         _loc8_ = TUtilityString.FetchUTF(param2);
         _loc4_ = uint(param2.readShort());
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc10_ = param2.readUnsignedInt();
            _loc11_ = param2.readUnsignedInt();
            this.FEnemyUIDHigh[_loc3_] = _loc10_;
            this.FEnemyUIDLow[_loc3_] = _loc11_;
            this.FEnemyLevel[_loc3_] = param2.readUnsignedInt();
            _loc12_ = int(param2.readUnsignedInt());
            this.FRoleModel = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc12_) as TRoleModel;
            this.FEnemyIds[_loc3_] = this.FRoleModel.Model;
            this.FEnemyNames[_loc3_] = TUtilityString.FetchUTF(param2);
            _loc3_++;
         }
         this.FTopTeamWindow.SetPlateServer(_loc5_,_loc6_,_loc7_,_loc8_);
         this.FTopTeamWindow.SetPlayerHead(this.FPlayerIds,this.FEnemyIds,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         this.FTopTeamWindow.SetPlayerName(this.FPlayerNames,this.FEnemyNames,this.FPlayerLevel,this.FEnemyLevel);
      }
      
      protected function CheckFightResult(param1:uint, param2:uint) : uint
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc4_ = this.FPlayerUIDHigh.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(this.FPlayerUIDHigh[_loc3_] == param1 && this.FPlayerUIDLow[_loc3_] == param2)
            {
               return 0;
            }
            _loc3_++;
         }
         _loc4_ = this.FEnemyUIDHigh.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(this.FEnemyUIDHigh[_loc3_] == param1 && this.FEnemyUIDLow[_loc3_] == param2)
            {
               return 1;
            }
            _loc3_++;
         }
         return 0;
      }
      
      public function SetTopTeamBattleInfor(param1:Object, param2:ByteArray) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TBattleInfo = null;
         var _loc6_:Vector.<TBattleInfo> = null;
         var _loc7_:uint = 0;
         var _loc8_:UInt64 = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         _loc9_ = param2.readUnsignedInt();
         _loc10_ = param2.readUnsignedInt();
         _loc8_ = new UInt64(_loc10_,_loc9_);
         _loc5_ = new TBattleInfo();
         _loc5_.GroupBattleData.FightReportId = _loc8_.ToString();
         _loc9_ = param2.readUnsignedInt();
         _loc10_ = param2.readUnsignedInt();
         _loc5_.GroupBattleData.FightResult = this.CheckFightResult(_loc9_,_loc10_);
         _loc7_ = param2.readUnsignedInt() - 1;
         _loc13_ = uint(param2.readInt());
         _loc13_ = uint(param2.readInt());
         this.FUnstreamizerBattleRepot.Unstreamize(param2,_loc5_,null);
         _loc6_ = this.FTurnReports[_loc7_];
         if(_loc6_ == null)
         {
            _loc6_ = new Vector.<TBattleInfo>();
            this.FTurnReports[_loc7_] = _loc6_;
         }
         _loc6_.push(_loc5_);
      }
      
      public function SetTopTeamBattleReward(param1:Object, param2:ByteArray) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TGroupBattleRewards = null;
         var _loc6_:TRoleModel = null;
         var _loc7_:int = 0;
         this.FWinType = param2.readUnsignedInt();
         _loc4_ = uint(param2.readShort());
         this.FGroupBattleRewardsVect.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = new TGroupBattleRewards();
            param2.readUnsignedInt();
            param2.readUnsignedInt();
            _loc7_ = int(param2.readUnsignedInt());
            _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc7_) as TRoleModel;
            _loc5_.ModelId = _loc6_.Model;
            _loc5_.UserName = TUtilityString.FetchUTF(param2);
            _loc5_.Score = param2.readUnsignedInt();
            _loc5_.ExtraScore = param2.readUnsignedInt();
            _loc5_.Point = param2.readUnsignedInt();
            _loc5_.UserLevel = param2.readUnsignedInt();
            this.FGroupBattleRewardsVect.push(_loc5_);
            _loc3_++;
         }
         if(!this.FIsInFight)
         {
            this.FIsInFight = true;
            this.FTopTeamWindow.Reset();
            this.FBattleTurn = 1;
            this.StartFight();
         }
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBattleLine = null;
         super.Visible = param1;
         if(Boolean(this.FBattleLineVect) && Visible == false)
         {
            _loc2_ = 0;
            while(_loc2_ < MAX_COUNT)
            {
               _loc3_ = this.FBattleLineVect[_loc2_];
               if(_loc3_)
               {
                  _loc3_.Visible = false;
               }
               _loc2_++;
            }
         }
      }
      
      public function Release() : void
      {
         SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_TopTeam);
      }
   }
}

