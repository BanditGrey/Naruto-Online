package Processors.Game.GroupBattle
{
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
   import Logics.DatebaseVO.VO.TEnemyArmy;
   import Logics.DatebaseVO.VO.TLeagueMapPve;
   import Logics.DatebaseVO.VO.TLeaguePointPath;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.DatebaseVO.VO.TSkillConfig;
   import Logics.GroupBattle.TGroupBattleRewards;
   import Logics.GroupBattle.TRoomPlayer;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Battle.TUnstreamizerBattleRepot;
   import Processors.Game.Battle.Effect.TEffectControl;
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
   
   public class TGroupBattleStage extends TProcessorGame
   {
      
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
      
      protected var FCampaignId:uint;
      
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
      
      protected var FLeaderIds:Vector.<uint>;
      
      protected var FPlayerNames:Vector.<String>;
      
      protected var FLeaderNames:Vector.<String>;
      
      protected var FProcessorBattleLoading:TGroupBattleLoading;
      
      protected var FGroupBattleWindow:TGroupBattleWindow;
      
      protected var FGroupBattleWindowWin:TGroupBattleWindowWin;
      
      protected var FGroupBattleWindowLost:TGroupBattleWindowLost;
      
      protected var FModelVect:Vector.<int>;
      
      protected var FSkillVect:Vector.<int>;
      
      protected var FGroupBattleRewardsVect:Vector.<TGroupBattleRewards>;
      
      protected var FOverlayerEquipment:TOverlayerEquipment;
      
      protected var FOverlayerTreasure:TOverlayerTreasure;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FOverlayerAccessory:TOverlayerAccessory;
      
      protected var FResourcesLoad:Boolean;
      
      protected var FInit:Boolean;
      
      protected var FTurnBackRoom:Function;
      
      protected var FOnQuit:Function;
      
      protected var FOnInitGroupBattle:Function;
      
      public function TGroupBattleStage(param1:TUIComponent)
      {
         var _loc2_:uint = 0;
         var _loc3_:TBattleLine = null;
         super(param1);
         this.FTurnReports = new Vector.<Vector.<TBattleInfo>>();
         this.FUnstreamizerBattleRepot = new TUnstreamizerBattleRepot();
         this.FPlayerIds = new Vector.<uint>();
         this.FEnemyIds = new Vector.<uint>();
         this.FLeaderIds = new Vector.<uint>();
         this.FPlayerNames = new Vector.<String>();
         this.FLeaderNames = new Vector.<String>();
         this.FModelVect = new Vector.<int>();
         this.FSkillVect = new Vector.<int>();
         this.FGroupBattleWindow = new TGroupBattleWindow(this);
         this.FGroupBattleWindow.OnSkipBattle = this.OnSkipBattle;
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
         this.FBattleType = CONST_GROUPBATTLE.BattleType_PVE;
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
         this.FGroupBattleWindow.UpdataPlayerHead();
         if(Boolean(this.FGroupBattleWindowWin) && this.FGroupBattleWindowWin.Visible)
         {
            this.FGroupBattleWindowWin.Updata();
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
         this.FProcessorBattleLoading = new TGroupBattleLoading(this);
         this.FProcessorBattleLoading.OnLoadingCompleted = this.LoadResourcesEnd;
         this.FProcessorBattleLoading.OnStartBattle = this.OnStartBattle;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_BATTLE.RESOURCE_ClassName_GroupBattle_Main) as MovieClip;
         addChild(this.FScene);
         this.FGroupBattleWindow.SetScene(this.FScene);
         this.FGroupBattleWindowWin = new TGroupBattleWindowWin(this);
         this.FGroupBattleWindowWin.OnClose = this.OnReturnRoom;
         this.FGroupBattleWindowWin.SlotsOnMove = this.UIComponentsOnOver;
         this.FGroupBattleWindowWin.SlotsOnOut = this.UIComponentsOnOut;
         this.FGroupBattleWindowWin.Init();
         this.FGroupBattleWindowLost = new TGroupBattleWindowLost(this);
         this.FGroupBattleWindowLost.OnClose = this.OnReturnRoom;
         this.FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_GroupBattle);
         this.FOverlayerEquipment.Visible = false;
         this.FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_GroupBattle);
         this.FOverlayerTreasure.Visible = false;
         this.FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_GroupBattle);
         this.FOverlayerAppliance.Visible = false;
         this.FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_GroupBattle);
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
               _loc4_.SetBattleInfo(_loc5_,this.FBattleType,this.FLeaderIds);
               _loc4_.x = CONST_STAGE_Point[_loc2_ - 1][_loc1_][0];
               _loc4_.y = CONST_STAGE_Point[_loc2_ - 1][_loc1_][1];
               _loc4_.Visible = true;
               this.CheckResources(_loc4_.FightReport);
               _loc6_ = _loc4_.FightReport.PlayerInfo_1.RoleBattleInfos[0].RoleName;
               _loc7_ = _loc4_.FightReport.PlayerInfo_2.RoleBattleInfos[0].RoleName;
               this.FGroupBattleWindow.AddFightReport(_loc6_,_loc7_,_loc5_.GroupBattleData.FightResult,_loc5_.GroupBattleData.FightReportId);
               _loc8_ = this.FPlayerNames.indexOf(_loc6_);
               _loc9_ = this.FLeaderNames.indexOf(_loc7_);
               this.FGroupBattleWindow.SetPlayerStatus(_loc8_,CONST_GROUPBATTLE.FightStatus_Fighting,_loc9_,CONST_GROUPBATTLE.FightStatus_Fighting);
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
            SResourcesCore.TexturesModel.LoadPrimary(this.FModelVect[_loc1_],CONST_MODULES.MODULE_GroupBattle);
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
            this.FGroupBattleWindow.UpdataReport();
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
         this.FGroupBattleWindow.UnLoadBackGround();
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
         _loc7_ = this.FLeaderNames.indexOf(_loc5_);
         _loc8_ = _loc3_.FightReport.GroupBattleData.FightResult == 0 ? CONST_GROUPBATTLE.FightStatus_Waiting : CONST_GROUPBATTLE.FightStatus_Lost;
         _loc9_ = _loc3_.FightReport.GroupBattleData.FightResult == 0 ? CONST_GROUPBATTLE.FightStatus_Lost : CONST_GROUPBATTLE.FightStatus_Waiting;
         if(_loc9_ == CONST_GROUPBATTLE.FightStatus_Lost)
         {
            this.FLeaderNames[_loc7_] = "";
         }
         this.FGroupBattleWindow.SetPlayerStatus(_loc6_,_loc8_,_loc7_,_loc9_);
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
            this.StartFight();
            return;
         }
         this.FIsInFight = false;
         if(this.FWinType == 0)
         {
            this.FGroupBattleWindowWin.Visible = true;
            this.FGroupBattleWindowWin.SetGroupBattleWinRewards(this.FGroupBattleRewardsVect);
         }
         else
         {
            this.FGroupBattleWindowLost.Visible = true;
         }
      }
      
      protected function OnReturnRoom(param1:Object) : void
      {
         this.ResetGroupBattle();
         if(this.FOnQuit != null)
         {
            this.FOnQuit(this,this.FBattleType,this.FWinType);
         }
         switch(this.FBattleType)
         {
            case CONST_GROUPBATTLE.BattleType_PVE:
               this.FTurnBackRoom(this);
               this.UnLoadResources();
               break;
            case CONST_GROUPBATTLE.BattleType_PVP:
               this.FTurnBackRoom(this);
               this.UnLoadResources();
         }
      }
      
      protected function ResetGroupBattle() : void
      {
         this.FTurnReports.length = 0;
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
      
      public function get TurnBackRoom() : Function
      {
         return this.FTurnBackRoom;
      }
      
      public function set TurnBackRoom(param1:Function) : void
      {
         this.FTurnBackRoom = param1;
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
      
      public function SetGroupBattleType(param1:Object, param2:ByteArray) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TLeagueMapPve = null;
         var _loc6_:TLeaguePointPath = null;
         var _loc7_:TEnemyArmy = null;
         var _loc8_:TEnemy = null;
         var _loc9_:TRoomPlayer = null;
         var _loc10_:TRoleModel = null;
         var _loc11_:uint = 0;
         this.FBattleType = param2.readByte();
         this.FCampaignId = param2.readUnsignedInt();
         this.FPlayerIds.length = 0;
         this.FPlayerNames.length = 0;
         _loc4_ = uint(SLogicsCore.GroupBattleData.RoomDetailInfo.RoomPlayers.Count);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc9_ = SLogicsCore.GroupBattleData.RoomDetailInfo.RoomPlayers.GetRoomPlayerByIndex(_loc3_);
            this.FPlayerIds.push(_loc9_ != null ? _loc9_.PlayerHeadID : 0);
            this.FPlayerNames.push(_loc9_ != null ? _loc9_.PlayerName : "");
            _loc3_++;
         }
         this.FEnemyIds.length = 0;
         this.FLeaderIds.length = 0;
         this.FLeaderNames.length = 0;
         if(this.FBattleType == CONST_GROUPBATTLE.BattleType_PVE)
         {
            if(this.FLeaguePointPathBins == null)
            {
               this.FLeaguePointPathBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_LeaguePointPath);
            }
            if(this.FLeagueMapPveBins == null)
            {
               this.FLeagueMapPveBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_LeagueMapPve);
            }
            if(this.FEnemyArmyBins == null)
            {
               this.FEnemyArmyBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_EnemyArmy);
            }
            if(this.FEnemyBins == null)
            {
               this.FEnemyBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Enemy);
            }
            if(this.FRoleModelBins == null)
            {
               this.FRoleModelBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
            }
            _loc6_ = this.FLeaguePointPathBins.GetDatebaseByIdentifier(this.FCampaignId) as TLeaguePointPath;
            if(_loc6_ != null)
            {
               _loc4_ = _loc6_.AramyVect.length;
               _loc3_ = 0;
               while(_loc3_ < _loc4_)
               {
                  _loc7_ = this.FEnemyArmyBins.GetDatebaseByIdentifier(_loc6_.AramyVect[_loc3_]) as TEnemyArmy;
                  _loc10_ = this.FRoleModelBins.GetDatebaseByIdentifier(_loc7_.IsLeader) as TRoleModel;
                  this.FLeaderIds.push(_loc7_.IsLeader);
                  this.FEnemyIds.push(_loc10_.RoleHead);
                  _loc8_ = this.FEnemyBins.GetDatebaseByIdentifier(_loc7_.IsLeader) as TEnemy;
                  this.FLeaderNames.push(_loc8_.Name);
                  _loc3_++;
               }
            }
            _loc5_ = this.FLeagueMapPveBins.GetDatebaseByIdentifier(this.FCampaignId) as TLeagueMapPve;
            if(_loc5_ != null)
            {
               _loc11_ = _loc5_.Map;
            }
         }
         this.FGroupBattleWindow.SetPlayerHead(this.FPlayerIds,this.FEnemyIds,_loc11_);
      }
      
      public function SetGroupBattleInfor(param1:Object, param2:ByteArray) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TBattleInfo = null;
         var _loc6_:Vector.<TBattleInfo> = null;
         _loc6_ = new Vector.<TBattleInfo>();
         _loc4_ = uint(param2.readShort());
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = new TBattleInfo();
            _loc5_.GroupBattleData.FightResult = param2.readByte();
            _loc5_.GroupBattleData.DefNpcId = param2.readUnsignedInt();
            _loc5_.GroupBattleData.AtkHp = param2.readUnsignedInt();
            _loc5_.GroupBattleData.DefHp = param2.readUnsignedInt();
            _loc5_.GroupBattleData.FightReportId = TUtilityString.FetchUTF(param2);
            this.FUnstreamizerBattleRepot.Unstreamize(param2,_loc5_,null);
            _loc6_.push(_loc5_);
            _loc3_++;
         }
         this.FTurnReports.push(_loc6_);
         if(!this.FIsInFight)
         {
            this.FIsInFight = true;
            this.FGroupBattleWindow.Reset();
            this.FBattleTurn = 1;
            this.StartFight();
         }
      }
      
      public function SetGroupBattleReward(param1:Object, param2:ByteArray) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TGroupBattleRewards = null;
         this.FWinType = param2.readByte();
         _loc4_ = uint(param2.readShort());
         this.FGroupBattleRewardsVect.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = new TGroupBattleRewards();
            _loc5_.SetData(param2);
            this.FGroupBattleRewardsVect.push(_loc5_);
            _loc3_++;
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
         SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_GroupBattle);
      }
   }
}

