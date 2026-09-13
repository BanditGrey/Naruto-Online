package Processors.Game.Lobby.Campaign
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Resources.Strings.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Battle.*;
   import Logics.Campaign.*;
   import Logics.Characters.*;
   import Logics.ChatOptions.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Items.*;
   import Logics.Streamization.Campaign.*;
   import Logics.Streamization.Items.*;
   import Processors.Game.Battle.*;
   import Processors.Game.Battle.Character.*;
   import Processors.Game.Lobby.Campaign.Monster.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Common.Shortcuts.*;
   import Processors.Game.Lobby.MainScene.*;
   import Processors.Game.Plot.*;
   import Processors.Game.Windows.Information.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   
   public class TProcessorBattleScene extends TProcessorLobbyPlate
   {
      
      protected static const MonsterGroup_Stamp:Number = 600;
      
      protected static const SIZE_WIDTH_PassNodal:int = 395;
      
      protected static const SIZE_HEIGHT_PassNodal:int = 350;
      
      protected static const TYPE_PROFESSIONS:Vector.<String> = STRING_COMMON.TYPE_PROFESSIONS;
      
      public static const ENTER_TYPE_NODAL:int = CONST_BATTLE.BattleType_Nodal;
      
      public static const ENTER_TYPE_CAMP:int = CONST_BATTLE.BattleType_Camp;
      
      public static const ENTER_TYPE_TRIALS:int = CONST_BATTLE.BattleType_KillHero;
      
      public static const PLAY_SCENE_Nodal:uint = CONST_MUSIC.PLAY_SCENE_Nodal;
      
      public static const PLAY_SCENE_Campaign:uint = CONST_MUSIC.PLAY_SCENE_Campaign;
      
      public static const PLAY_SCENE_KillHeros:uint = CONST_MUSIC.PLAY_SCENE_KillHeros;
      
      public static const PLAY_SCENE_Arena:uint = CONST_MUSIC.PLAY_SCENE_Arena;
      
      protected var FSceneGo:MovieClip;
      
      protected var FSceneModel:TNodalSceneModel;
      
      protected var UnstreamizerScene:TUnstreamizerNodalScene;
      
      protected var UnstreamizerNodalSceneMonster:TUnstreamizerNodalSceneMonster;
      
      protected var FControlGroupRole:TGroupMonster;
      
      protected var FGroupMonsterVect:Vector.<TGroupMonster>;
      
      protected var FFreeGroupMonsterVect:Vector.<TGroupMonster>;
      
      protected var StopUpdata:Boolean;
      
      protected var FPassNodalWindow:TPassNodalWindow;
      
      protected var Control_Area:TBounds;
      
      protected var FBoundsPassWindow:TBounds;
      
      protected var FPassDoor:TGroupMonster;
      
      protected var FTipsScene:MovieClip;
      
      protected var FHeroTalentBins:TBins;
      
      protected var FSkillBins:TBins;
      
      protected var FPlayPoint:Point;
      
      protected var FMissionName:String;
      
      protected var FLostPopTipsId:Vector.<Array>;
      
      protected var FTipRole:TActive;
      
      protected var FWindowConfirmationTurnBack:TUIWindowConfirmation;
      
      protected var FRunAreaWidth:Number;
      
      protected var FOutBattleScene:Boolean;
      
      protected var FBackGround:TLayerBackGround;
      
      protected var FMonsterSprite:TUIComponent;
      
      protected var FLayerLittleScript:TLayerLittleScript;
      
      protected var FBackgroundLoadCompleted:Boolean;
      
      protected var FVisibleNavigation:Boolean;
      
      protected var FIsPass:Boolean;
      
      protected var FCityBins:TBins;
      
      protected var FBlockPointBins:TBins;
      
      protected var FRaidersDailyConfigBins:TBins;
      
      protected var FEnemyArmyBins:TBins;
      
      protected var FSingleBins:TBins;
      
      protected var FNodalModel:TNodal;
      
      protected var FCharacter:TCharacter;
      
      protected var FPoolItem:TPoolItem;
      
      protected var FPoolCampaign:TPoolCampaign;
      
      protected var FOnEnterCityScene:Function;
      
      protected var FOnCheckTask:Function;
      
      protected var FSetSceneBitmapData:Function;
      
      protected var FOnUpdateReturnHomePanel:Function;
      
      protected var FUnLoadResource:Function;
      
      protected var FOnProcessorCheckPlot:Function;
      
      protected var FAddPopTips:Function;
      
      protected var FSetStatusType:Function;
      
      protected var FSetMonsterCount:Function;
      
      protected var FOnProcessorCheckPopTips:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FIsOpenWindows:Function;
      
      public function TProcessorBattleScene(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FBackGround = new TLayerBackGround(this,CONST_MODULES.MODULE_Campaign);
         this.FBackGround.OnLoadCompleted = this.ProcessorResourcesOnLoadCompleted;
         this.FBackGround.IsNeedSmallPic = false;
         this.FBackGround.visible = true;
         this.FMonsterSprite = new TUIComponent(this);
         this.FLayerLittleScript = new TLayerLittleScript(this);
         this.FLayerLittleScript.visible = true;
         this.FLayerLittleScript.MouseEventObject = this.FBackGround;
         this.Control_Area = new TBounds();
         this.Control_Area.X = 0;
         this.Control_Area.Y = 400;
         this.Control_Area.Width = 1250;
         this.Control_Area.Height = 650;
         this.FRunAreaWidth = 0;
         this.UnstreamizerNodalSceneMonster = new TUnstreamizerNodalSceneMonster();
         this.UnstreamizerScene = new TUnstreamizerNodalScene();
         this.FGroupMonsterVect = new Vector.<TGroupMonster>();
         this.FFreeGroupMonsterVect = new Vector.<TGroupMonster>();
         this.StopUpdata = false;
         this.FBoundsPassWindow = new TBounds();
         this.FBoundsPassWindow.Width = SIZE_WIDTH_PassNodal;
         this.FBoundsPassWindow.Height = SIZE_HEIGHT_PassNodal;
         this.FPlayPoint = new Point(0,0);
         this.FNodalModel = SLogicsCore.Nodal;
         this.FCharacter = SLogicsCore.Character;
         this.FPoolItem = SLogicsCore.PoolItem;
         this.FPoolCampaign = SLogicsCore.PoolCampaign;
         this.FVisibleNavigation = true;
         this.FIsPass = false;
         SetUIModuleID(CONST_MODULES.MODULE_Campaign);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BATTLESCENE.RESOURCESID_BATTLESCENE);
         SResourcesCore.TexturesModel.LoadPrimary(CONST_BATTLE.CITY_DOOR);
         SResourcesCore.TexturesSwfCommon.LoadPrimary(CONST_COMMON.RESOURCESID_Swf_Common);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIWait() : void
      {
         if(SResourcesCore.LoadingPrimary)
         {
            return;
         }
         this.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         if(this.FHeroTalentBins == null)
         {
            this.FHeroTalentBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_HeroTalent);
         }
         if(this.FSkillBins == null)
         {
            this.FSkillBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SkillConfig);
         }
         this.FSceneGo = TUtilityReflection.CreateDisplayObjectInstance(CONST_BATTLESCENE.RESOURCE_ClassName_GoTip) as MovieClip;
         addChild(this.FSceneGo);
         this.FSceneGo.mouseEnabled = false;
         this.FSceneGo.visible = false;
         this.FSceneGo.stop();
         this.FSceneGo.x = FUICore.StageWidth;
         this.FSceneGo.y = (CONST_COMMON.STAGE_Height - this.FSceneGo.height) / 2;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Hurdle_Assessment,this.PacketPerform_SC_StarInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Hurdle_QueryChestRet,this.PacketPerform_SC_PassNodalWindow);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Hurdle_ReceiveChestRet,this.PacketPerform_SC_PassNodalWindow);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Hurdle_MoveToNextLayerRet,this.PacketPerform_SC_MoveToNextLayerRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Hurdle_FightOk,this.PacketPerform_SC_FightOk);
      }
      
      protected function ProcessorEnterHurdle() : void
      {
         if(this.FSceneModel == null)
         {
            return;
         }
         if(Boolean(this.FPassNodalWindow) && this.FCharacter.RoleSencePosition != CONST_COMMON.SCENEPOSITION_BATTLESENCE)
         {
            this.FPassNodalWindow.visible = false;
         }
         this.FCharacter.RoleSencePosition = CONST_COMMON.SCENEPOSITION_BATTLESENCE;
         if(this.FSceneModel.Monsters.length > 0)
         {
            if(this.FPassDoor != null)
            {
               this.FPassDoor.Visible = false;
            }
         }
         else
         {
            if(this.FPassDoor == null)
            {
               this.CreateDoor();
            }
            this.FPassDoor.Visible = true;
            this.FPassDoor.MapX = SBattleConfig.GetPostionByCamyPos(1,1,SBattleConfig.Type_PostionX);
            this.FPassDoor.MapY = SBattleConfig.GetPostionByCamyPos(1,1,SBattleConfig.Type_PostionY);
         }
         this.ShowGoTip();
         if(this.FControlGroupRole != null)
         {
            this.FControlGroupRole.visible = true;
         }
         this.FOutBattleScene = false;
      }
      
      protected function PacketPerform_SC_StarInfo(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TCity = null;
         var _loc7_:TBlockPoint = null;
         var _loc8_:ByteArray = null;
         if(this.FCharacter.RoleSencePosition != CONST_COMMON.SCENEPOSITION_BATTLESENCE)
         {
            return;
         }
         _loc8_ = param1.Data;
         _loc2_ = _loc8_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc3_ = int(_loc8_.readUnsignedInt());
         _loc4_ = int(_loc8_.readUnsignedInt());
         _loc5_ = int(_loc8_.readUnsignedByte());
         _loc6_ = this.FCityBins.GetDatebaseByIdentifier(_loc3_) as TCity;
         if(this.FPassNodalWindow == null)
         {
            this.FPassNodalWindow = new TPassNodalWindow(this,CONST_MODULES.MODULE_Campaign,false);
            this.FPassNodalWindow.OnEffectText = FOnEffectText;
            this.FPassNodalWindow.EffectGenerateTextByErrorCode = EffectGenerateTextByErrorCode;
         }
         this.FPassNodalWindow.SetPassNodalWindow(_loc6_.Type,_loc4_,_loc5_,this.EnterCityScene);
         this.FIsPass = true;
         if(this.FOnCheckTask != null)
         {
            this.FOnCheckTask(_loc4_,1);
         }
         if(_loc6_.Type == ENTER_TYPE_NODAL)
         {
            _loc7_ = this.FBlockPointBins.GetDatebaseByIdentifier(_loc4_) as TBlockPoint;
            this.FNodalModel.SetMissionStarByID(_loc4_,_loc5_);
            this.FNodalModel.CurMissionID = _loc7_.NextPoint;
         }
         else if(_loc6_.Type == ENTER_TYPE_CAMP)
         {
            this.FNodalModel.SetCampStarByID(_loc4_,_loc5_);
         }
         this.ShowGoTip(false);
      }
      
      protected function PacketPerform_SC_PassNodalWindow(param1:TPacket) : void
      {
         if(this.FPassNodalWindow != null)
         {
            this.FPassNodalWindow.PacketProcess(param1);
         }
      }
      
      protected function LoadResourcesEnd() : void
      {
         TutorialNextStep(301);
         if(Boolean(this.FSceneModel) && this.FSceneModel.EnterType == ENTER_TYPE_NODAL)
         {
            if(this.FOnProcessorCheckPlot != null)
            {
               this.FOnProcessorCheckPlot(this,TProcessorPlot.PLOT_TYPE_Nodal,TProcessorPlot.PLOT_POS_Befor,this.FSceneModel.MissionId);
            }
         }
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FCharacter.RoleSencePosition == CONST_COMMON.SCENEPOSITION_BATTLESENCE)
         {
            this.FBackGround.Update();
         }
         if(visible == false || this.FOutBattleScene)
         {
            return;
         }
         this.UpdataMonster();
         this.CheckEnterDoor();
         this.CheckMouseIn();
         if(this.FPassNodalWindow != null)
         {
            this.FPassNodalWindow.UpdataSlot();
         }
      }
      
      protected function ProcessorResourcesOnLoadCompleted(param1:Object) : void
      {
         this.FMonsterSprite.Visible = true;
      }
      
      protected function StartMove() : void
      {
         this.SetMove(this.FPassDoor.MapX,this.FPassDoor.MapY);
      }
      
      protected function CheckRoleEnterDoor() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:TActive = null;
         var _loc3_:TActive = null;
         if(this.FPassDoor == null)
         {
            return false;
         }
         _loc3_ = this.FPassDoor.GetActiveByIndex(0);
         _loc1_ = 0;
         while(_loc1_ < this.FControlGroupRole.Count)
         {
            _loc2_ = this.FControlGroupRole.GetActiveByIndex(_loc1_);
            if(_loc2_ != null && _loc2_.hitTestObject(_loc3_))
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      protected function CheckEnterDoor() : void
      {
         if(this.StopUpdata)
         {
            return;
         }
         if(Boolean(this.FPassDoor) && this.FPassDoor.Visible)
         {
            if(this.CheckRoleEnterDoor())
            {
               this.EnterNextLayer();
            }
         }
      }
      
      protected function CheckMouseIn() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TActive = null;
         var _loc4_:TGroupMonster = null;
         if(Boolean(this.FPassNodalWindow) && this.FPassNodalWindow.visible == true)
         {
            return;
         }
         if(visible == false)
         {
            return;
         }
         if(this.FControlGroupRole != null && this.FControlGroupRole.visible == true)
         {
            _loc3_ = this.FControlGroupRole.CheckMouseIn();
            if(_loc3_ == null)
            {
               this.FControlGroupRole.ShowHighLight = false;
            }
         }
         if(_loc3_ == null)
         {
            _loc2_ = int(this.FGroupMonsterVect.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc4_ = this.FGroupMonsterVect[_loc1_];
               if(!(_loc4_ == null || _loc4_.visible == false))
               {
                  _loc3_ = _loc4_.CheckMouseIn();
                  if(_loc3_ != null)
                  {
                     break;
                  }
                  _loc4_.ShowHighLight = false;
               }
               _loc1_++;
            }
         }
         if(_loc3_ != null)
         {
            _loc3_.ShowHighLight = true;
            if(_loc3_.HasTip)
            {
               this.ShowTips(_loc3_);
            }
         }
         else
         {
            this.HideTips();
         }
      }
      
      protected function ShowTips(param1:TActive) : void
      {
         var _loc2_:THeroTalent = null;
         var _loc3_:uint = 0;
         var _loc4_:TSkillConfig = null;
         var _loc5_:THero = null;
         if(this.FIsOpenWindows != null)
         {
            if(this.FIsOpenWindows(this))
            {
               return;
            }
         }
         if(this.FTipRole != param1)
         {
            if(this.FTipRole != null)
            {
               this.FTipRole.ShowHighLight = false;
            }
            this.FTipRole = param1;
            if(param1.direction == false)
            {
               FUICore.MouseCaptureSet(this.FTipRole);
               param1.CursorHovering = true;
            }
            if(FResourcesState != RESOURCESSTATE_Ready)
            {
               return;
            }
            if(this.FTipsScene == null)
            {
               this.FTipsScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_GroupMonstonTip) as MovieClip;
               addChild(this.FTipsScene);
            }
            if(param1.HeroData != null)
            {
               _loc5_ = this.FCharacter.Heros.GetHeroByIdentifier(param1.Id);
               if(param1.direction)
               {
                  this.FTipsScene.tf_name.text = _loc5_.Name;
                  this.FTipsScene.tf_level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc5_.Level);
               }
               else
               {
                  this.FTipsScene.tf_name.text = param1.HeroData.Name;
                  this.FTipsScene.tf_level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(param1.HeroData.Level);
               }
               this.FTipsScene.tf_type.text = TYPE_PROFESSIONS[param1.HeroData.Profession];
               this.FTipsScene.tf_health.text = _loc5_ ? _loc5_.BaseAttributeHealth : 1000;
               _loc2_ = this.FHeroTalentBins.GetDatebaseByIdentifier(param1.HeroData.Talent) as THeroTalent;
               this.FTipsScene.tf_talent.text = _loc2_ ? _loc2_.TalentName : STRING_COMMON.COMMON_NONE;
               if(_loc5_)
               {
                  _loc3_ = _loc5_.Skills.GetMountSkillId();
                  _loc4_ = this.FSkillBins.GetDatebaseByIdentifier(_loc3_) as TSkillConfig;
               }
               this.FTipsScene.tf_skill.text = _loc4_ ? _loc4_.Name : STRING_COMMON.COMMON_NONE;
               this.FTipsScene.tf_skilldesc.text = _loc4_ ? _loc4_.Desc : STRING_COMMON.COMMON_NONE;
            }
            else if(param1.EnemyData != null)
            {
               this.FTipsScene.tf_name.text = param1.EnemyData.Name;
               this.FTipsScene.tf_level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(param1.EnemyData.Level);
               this.FTipsScene.tf_type.text = TYPE_PROFESSIONS[param1.EnemyData.Profession];
               this.FTipsScene.tf_health.text = param1.EnemyData.Hp;
               _loc2_ = this.FHeroTalentBins.GetDatebaseByIdentifier(param1.EnemyData.TalentId) as THeroTalent;
               this.FTipsScene.tf_talent.text = _loc2_ ? _loc2_.TalentName : STRING_COMMON.COMMON_NONE;
               _loc4_ = this.FSkillBins.GetDatebaseByIdentifier(param1.EnemyData.Skill) as TSkillConfig;
               this.FTipsScene.tf_skill.text = _loc4_.Name;
               this.FTipsScene.tf_skilldesc.text = _loc4_.Desc;
            }
            else
            {
               this.FTipsScene.tf_name.text = param1.NpcData.Name;
               this.FTipsScene.tf_level.text = "LV." + 70;
               this.FTipsScene.tf_type.text = STRING_COMMON.TYPE_PROFESSION_STRENGTH;
               this.FTipsScene.tf_health.text = 1000;
               this.FTipsScene.tf_talent.text = STRING_COMMON.COMMON_NONE;
               this.FTipsScene.tf_skill.text = STRING_COMMON.COMMON_NONE;
               this.FTipsScene.tf_skilldesc.text = STRING_COMMON.COMMON_NONE;
            }
         }
         if(this.FTipsScene != null)
         {
            this.FTipsScene.visible = true;
            this.FTipsScene.x = mouseX + 15;
            this.FTipsScene.y = mouseY;
            if(this.FTipsScene.x > CONST_COMMON.STAGE_Width - this.FTipsScene.width)
            {
               this.FTipsScene.x = mouseX - this.FTipsScene.width - 5;
            }
            if(this.FTipsScene.y > CONST_COMMON.STAGE_Height - this.FTipsScene.height)
            {
               this.FTipsScene.y = mouseY - this.FTipsScene.height - 5;
            }
         }
      }
      
      protected function HideTips() : void
      {
         FUICore.MouseCaptureRelease(this.FTipRole);
         this.FTipRole = null;
         if(this.FTipsScene != null)
         {
            this.FTipsScene.visible = false;
         }
      }
      
      protected function EnterNextLayer() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LOBBY_Hurdle_EnterNextLayer);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         if(this.FPassDoor != null)
         {
            this.FPassDoor.Visible = false;
         }
      }
      
      protected function PacketPerform_SC_MoveToNextLayerRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         if(this.FCharacter.RoleSencePosition != CONST_COMMON.SCENEPOSITION_BATTLESENCE)
         {
            return;
         }
         this.FSceneModel.Reset();
         this.UnstreamizerNodalSceneMonster.Unstreamize(_loc2_,this.FSceneModel,SResourcesCore.ResourceBin);
         this.SetMonster();
         if(this.FControlGroupRole != null)
         {
            this.FControlGroupRole.ActivePlay(TActive.TYPE_ACTIVE_FIGHT_IDLE);
         }
         this.ChangeSceneId(this.FSceneModel.ResourceBgId);
         this.UpdateReturnHomePanel();
         this.FNodalModel.AddCampaignLayerIndex(this.FSceneModel.CityId,this.FSceneModel.MissionId);
      }
      
      protected function PacketPerform_SC_FightOk(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            if(this.FGroupMonsterVect[0] != null)
            {
               this.FGroupMonsterVect[0].visible = true;
            }
            this.FControlGroupRole.visible = true;
            this.StopUpdata = false;
            return;
         }
         if(this.FOnInitBattle != null)
         {
            FUICore.MouseCaptureRelease(this.FTipRole);
            this.FOnInitBattle(this);
         }
         this.FControlGroupRole.StopMove();
         TutorialNextStep(308);
      }
      
      protected function FightMonster(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:TGroupMonster = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BattleStart);
         _loc3_ = _loc2_.Data;
         _loc3_.writeShort(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         if(this.FSetSceneBitmapData != null)
         {
            this.FSetSceneBitmapData(this,this.GetSceneBitmapData());
         }
         this.FControlGroupRole.MapX -= 250;
         this.FControlGroupRole.StopMove();
      }
      
      protected function InitMonster() : void
      {
         if(this.FControlGroupRole == null)
         {
            this.FControlGroupRole = new TGroupMonster(this.FMonsterSprite,CONST_MODULES.MODULE_Common,TGroupMonster.CAMP_LEFT);
         }
         else
         {
            this.FControlGroupRole.ReloadRole();
         }
         this.FControlGroupRole.ResetRole(this.FSceneModel.Heros);
         this.FControlGroupRole.MapX = SBattleConfig.GetPostionByCamyPos(0,1,SBattleConfig.Type_PostionX);
         this.FControlGroupRole.MapY = SBattleConfig.GetPostionByCamyPos(0,1,SBattleConfig.Type_PostionY);
         this.FBackGround.ScreenRole = this.FControlGroupRole;
         this.FLayerLittleScript.MainRole = this.FControlGroupRole;
         this.SetMonster();
      }
      
      protected function UpdataMonster() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TGroupMonster = null;
         if(this.StopUpdata)
         {
            return;
         }
         if(this.FControlGroupRole)
         {
            this.FControlGroupRole.UpdataRole();
         }
         _loc2_ = int(this.FGroupMonsterVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FGroupMonsterVect[_loc1_];
            if(_loc3_ != null)
            {
               _loc3_.UpdataRole();
               _loc3_.UpdateRolePosition();
               if(_loc1_ == 0 && this.FControlGroupRole.visible == true && this.GroupHitTest(this.FControlGroupRole,_loc3_))
               {
                  this.FightMonster(_loc1_);
                  _loc3_.visible = false;
                  this.FControlGroupRole.visible = false;
                  this.StopUpdata = true;
               }
            }
            _loc1_++;
         }
         if(this.FPassDoor != null)
         {
            this.FPassDoor.UpdataRole();
         }
      }
      
      protected function GroupHitTest(param1:TGroupMonster, param2:TGroupMonster) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TActive = null;
         var _loc6_:TActive = null;
         _loc3_ = 0;
         while(_loc3_ < param1.Count)
         {
            _loc4_ = 0;
            while(_loc4_ < param2.Count)
            {
               _loc5_ = param1.GetActiveByIndex(_loc3_);
               _loc6_ = param2.GetActiveByIndex(_loc4_);
               if(Boolean(_loc5_) && Boolean(_loc6_) && _loc5_.Display.hitTestObject(_loc6_.Display))
               {
                  return true;
               }
               _loc4_++;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function SetMonster() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<TMonster> = null;
         var _loc4_:TMonster = null;
         var _loc5_:TGroupMonster = null;
         var _loc6_:TEnemyArmy = null;
         this.StopUpdata = false;
         if(this.FControlGroupRole)
         {
            this.FControlGroupRole.MapX = SBattleConfig.GetPostionByCamyPos(0,1,SBattleConfig.Type_PostionX);
            this.FControlGroupRole.MapY = SBattleConfig.GetPostionByCamyPos(0,1,SBattleConfig.Type_PostionY);
            this.FControlGroupRole.StopMove();
         }
         while(this.FGroupMonsterVect.length)
         {
            _loc5_ = this.FGroupMonsterVect.pop();
            _loc5_.SaveRole();
            this.FFreeGroupMonsterVect.push(_loc5_);
         }
         _loc2_ = int(this.FSceneModel.Monsters.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FFreeGroupMonsterVect.length <= 0)
            {
               _loc5_ = new TGroupMonster(this.FMonsterSprite,CONST_MODULES.MODULE_Campaign,TGroupMonster.CAMP_RIGNT);
            }
            else
            {
               _loc5_ = this.FFreeGroupMonsterVect.pop();
               _loc5_.ModuleId = CONST_MODULES.MODULE_Campaign;
            }
            _loc5_.ResetRole(this.FSceneModel.Monsters[_loc1_]);
            _loc5_.SetPos(MonsterGroup_Stamp * _loc1_ + SBattleConfig.GetPostionByCamyPos(1,1,SBattleConfig.Type_PostionX),SBattleConfig.GetPostionByCamyPos(1,1,SBattleConfig.Type_PostionY));
            _loc6_ = this.FEnemyArmyBins.GetDatebaseByIdentifier(this.FSceneModel.EnemyArmyId[_loc1_]) as TEnemyArmy;
            if(_loc6_ != null)
            {
               _loc5_.TalkInfo = _loc6_.Text;
            }
            else
            {
               _loc5_.TalkInfo = "";
            }
            _loc5_.AutoMove = true;
            _loc5_.SetControlGroupRole = this.SetMove;
            this.FGroupMonsterVect.push(_loc5_);
            _loc1_++;
         }
         this.FRunAreaWidth = SBattleConfig.GetPostionByCamyPos(1,1,SBattleConfig.Type_PostionX) + MonsterGroup_Stamp / 2;
         this.FBackGround.RoleControlWidth = this.Control_Area.Width;
      }
      
      protected function SetMove(param1:int, param2:int) : void
      {
         this.FControlGroupRole.SetupTargetPosition(param1,param2,CONST_MainScene.RoleMoveSpeed);
      }
      
      protected function UpdateReturnHomePanel() : void
      {
         if(this.FOnUpdateReturnHomePanel != null)
         {
            this.FOnUpdateReturnHomePanel(this,this.FMissionName,STRING_BATTLE.STRINGS_MonsterCount + this.FGroupMonsterVect.length);
         }
         if(this.FSetMonsterCount != null)
         {
            this.FSetMonsterCount(this,this.FGroupMonsterVect.length);
         }
      }
      
      protected function ResetControlGroupRole(param1:TMonsters) : void
      {
         this.FControlGroupRole.ResetRole(param1);
      }
      
      protected function EnterCityScene(param1:Object) : void
      {
         this.FControlGroupRole.StopMove();
         if(this.FOnEnterCityScene != null)
         {
            this.FOnEnterCityScene(param1);
         }
         if(this.FUnLoadResource != null)
         {
            this.FOutBattleScene = true;
            this.FUnLoadResource(this);
         }
         this.FBackGround.Reset();
         super.Unmount();
      }
      
      protected function ShowGoTip(param1:Boolean = true) : void
      {
         if(param1)
         {
            this.FSceneGo.visible = true;
            this.FSceneGo.play();
         }
         else
         {
            this.FSceneGo.visible = false;
            this.FSceneGo.stop();
         }
      }
      
      protected function ShowPassWindow(param1:Object = null) : void
      {
         if(!this.FIsPass)
         {
            return;
         }
         if(this.FPassNodalWindow != null)
         {
            this.FPassNodalWindow.ShowWindows();
            addChild(this.FPassNodalWindow);
            this.SetVisibleNavigation(this.FVisibleNavigation);
         }
         this.FIsPass = false;
         TutorialNextStep(303);
      }
      
      protected function ChangeSceneId(param1:uint) : void
      {
         this.FMonsterSprite.Visible = false;
         this.FBackGround.SwitchScene(param1);
      }
      
      protected function ProcessorPlayMusic(param1:int) : void
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case ENTER_TYPE_NODAL:
               _loc2_ = int(PLAY_SCENE_Nodal);
               break;
            case ENTER_TYPE_CAMP:
               _loc2_ = int(PLAY_SCENE_Campaign);
               break;
            case ENTER_TYPE_TRIALS:
               _loc2_ = int(PLAY_SCENE_KillHeros);
         }
         MusicPlayNext(CONST_SIGNAL.SIGNALDESTINATION_SOUND,_loc2_,this.FSceneModel.MissionId);
      }
      
      protected function SetVisibleNavigation(param1:Boolean) : void
      {
         ShortcutModesNotifyUpdate();
         ChatOptionsNotifyUpdate();
         PopTipsNotifyUpdate();
      }
      
      protected function CheckPopTip() : void
      {
         var _loc1_:* = 0;
         var _loc2_:Array = null;
         if(this.FSceneModel.EnterType == ENTER_TYPE_NODAL)
         {
            if(this.FLostPopTipsId.length >= this.FGroupMonsterVect.length)
            {
               _loc2_ = this.FLostPopTipsId[this.FLostPopTipsId.length - this.FGroupMonsterVect.length];
            }
            if(this.FAddPopTips != null && _loc2_ != null)
            {
               _loc1_ = int(_loc2_.length - 1);
               while(_loc1_ >= 0)
               {
                  this.FAddPopTips(this,_loc2_[_loc1_]);
                  _loc1_--;
               }
            }
         }
      }
      
      protected function CreateDoor() : void
      {
         var _loc1_:TMonsters = null;
         var _loc2_:TMonster = null;
         _loc1_ = new TMonsters();
         _loc2_ = new TMonster(CONST_BATTLE.CITY_DOOR);
         _loc2_.MonsterPos = 1;
         _loc1_.Add(_loc2_);
         this.FPassDoor = new TGroupMonster(this,CONST_MODULES.MODULE_Campaign,TGroupMonster.CAMP_RIGNT,true);
         this.FPassDoor.ResetRole(_loc1_);
         TGameUtil.setSpriteButton(this.FPassDoor,true);
         this.FPassDoor.SetControlGroupRole = this.SetMove;
      }
      
      public function get OnEnterCityScene() : Function
      {
         return this.FOnEnterCityScene;
      }
      
      public function set OnEnterCityScene(param1:Function) : void
      {
         this.FOnEnterCityScene = param1;
      }
      
      public function get OnCheckTask() : Function
      {
         return this.FOnCheckTask;
      }
      
      public function set OnCheckTask(param1:Function) : void
      {
         this.FOnCheckTask = param1;
      }
      
      public function get SetSceneBitmapData() : Function
      {
         return this.FSetSceneBitmapData;
      }
      
      public function set SetSceneBitmapData(param1:Function) : void
      {
         this.FSetSceneBitmapData = param1;
      }
      
      public function get OnUpdateReturnHomePanel() : Function
      {
         return this.FOnUpdateReturnHomePanel;
      }
      
      public function set OnUpdateReturnHomePanel(param1:Function) : void
      {
         this.FOnUpdateReturnHomePanel = param1;
      }
      
      public function get PlayPoint() : Point
      {
         return this.FPlayPoint;
      }
      
      public function set PlayPoint(param1:Point) : void
      {
         this.FPlayPoint = param1;
      }
      
      public function get UnLoadResource() : Function
      {
         return this.FUnLoadResource;
      }
      
      public function set UnLoadResource(param1:Function) : void
      {
         this.FUnLoadResource = param1;
      }
      
      public function get OnProcessorCheckPlot() : Function
      {
         return this.FOnProcessorCheckPlot;
      }
      
      public function set OnProcessorCheckPlot(param1:Function) : void
      {
         this.FOnProcessorCheckPlot = param1;
      }
      
      public function get AddPopTips() : Function
      {
         return this.FAddPopTips;
      }
      
      public function set AddPopTips(param1:Function) : void
      {
         this.FAddPopTips = param1;
      }
      
      public function get SetStatusType() : Function
      {
         return this.FSetStatusType;
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      public function get SetMonsterCount() : Function
      {
         return this.FSetMonsterCount;
      }
      
      public function set SetMonsterCount(param1:Function) : void
      {
         this.FSetMonsterCount = param1;
      }
      
      public function get OnProcessorCheckPopTips() : Function
      {
         return this.FOnProcessorCheckPopTips;
      }
      
      public function set OnProcessorCheckPopTips(param1:Function) : void
      {
         this.FOnProcessorCheckPopTips = param1;
      }
      
      public function get OnInitBattle() : Function
      {
         return this.FOnInitBattle;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function get IsOpenWindows() : Function
      {
         return this.FIsOpenWindows;
      }
      
      public function set IsOpenWindows(param1:Function) : void
      {
         this.FIsOpenWindows = param1;
      }
      
      public function MainHeroQualityOnChange(param1:Object) : void
      {
         this.ProcessorsOnChangePosition(param1);
      }
      
      public function ProcessorsOnChangePosition(param1:Object) : void
      {
         var _loc2_:TMonsters = null;
         var _loc3_:TMonster = null;
         var _loc4_:int = 0;
         var _loc5_:THeros = null;
         var _loc6_:THero = null;
         if(this.FSceneModel == null)
         {
            return;
         }
         _loc2_ = new TMonsters();
         _loc5_ = this.FCharacter.Heros;
         this.FSceneModel.Heros = _loc2_;
         _loc4_ = 0;
         while(_loc4_ < _loc5_.Count)
         {
            _loc6_ = _loc5_.GetHeroByIndex(_loc4_);
            if((Boolean(_loc6_)) && _loc6_.FightPosition > 0)
            {
               _loc3_ = this.FPoolCampaign.AcquireMonster(_loc6_.Identifier);
               _loc3_.IsChar = Boolean(_loc4_ == 0);
               _loc3_.MonsterPos = _loc6_.FightPosition;
               _loc2_.Add(_loc3_);
            }
            _loc4_++;
         }
         this.ResetControlGroupRole(_loc2_);
      }
      
      public function OnEnterScene(param1:ByteArray) : void
      {
         var _loc2_:TGroupMonster = null;
         var _loc3_:TBlockPoint = null;
         var _loc4_:TCampaign = null;
         var _loc5_:TSingle = null;
         var _loc6_:TRaidersDailyConfig = null;
         if(this.FCityBins == null)
         {
            this.FCityBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_City);
         }
         if(this.FBlockPointBins == null)
         {
            this.FBlockPointBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BlockPoint);
         }
         if(this.FRaidersDailyConfigBins == null)
         {
            this.FRaidersDailyConfigBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RaidersDailyConfig);
         }
         if(this.FEnemyArmyBins == null)
         {
            this.FEnemyArmyBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_EnemyArmy);
         }
         if(this.FSingleBins == null)
         {
            this.FSingleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Single);
         }
         while(this.FGroupMonsterVect.length)
         {
            _loc2_ = this.FGroupMonsterVect.pop();
            _loc2_.SaveRole();
         }
         if(this.FSceneModel == null)
         {
            this.FSceneModel = new TNodalSceneModel();
         }
         else
         {
            this.FSceneModel.Reset();
         }
         this.UnstreamizerScene.Unstreamize(param1,this.FSceneModel,SResourcesCore.ResourceBin);
         this.InitMonster();
         if(this.FSceneModel.EnterType == ENTER_TYPE_NODAL)
         {
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BlockPoint,this.FSceneModel.MissionId) as TBlockPoint;
            this.FMissionName = _loc3_ ? _loc3_.Name : STRING_COMMON.COMMON_NONE;
            this.FLostPopTipsId = _loc3_ ? _loc3_.PopTipIds : null;
         }
         else if(this.FSceneModel.EnterType == ENTER_TYPE_CAMP)
         {
            _loc4_ = this.FNodalModel.GetCampaignById(this.FSceneModel.CityId);
            _loc5_ = this.FSingleBins.GetDatebaseByIdentifier(this.FSceneModel.MissionId) as TSingle;
            this.FMissionName = _loc5_ ? _loc5_.Name : STRING_COMMON.COMMON_NONE;
            if(_loc4_.Diffculty < 0)
            {
               _loc4_.LayerIndex = 0;
               _loc4_.EnemyIndex = 0;
               _loc4_.EnterCount += 1;
            }
         }
         else if(this.FSceneModel.EnterType == ENTER_TYPE_TRIALS)
         {
            _loc6_ = this.FRaidersDailyConfigBins.GetDatebaseByIdentifier(this.FSceneModel.MissionId) as TRaidersDailyConfig;
            this.FMissionName = _loc6_ ? _loc6_.Name : STRING_COMMON.COMMON_NONE;
         }
         this.ChangeSceneId(this.FSceneModel.ResourceBgId);
         this.UpdateReturnHomePanel();
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,this.FSceneModel.EnterType,this.FSceneModel.MissionId);
         }
      }
      
      public function TurnBackBattleScene(param1:Object, param2:Boolean) : void
      {
         var _loc3_:TGroupMonster = null;
         var _loc4_:Number = NaN;
         if(param2)
         {
            _loc3_ = this.FGroupMonsterVect.shift();
            _loc3_.SaveRole();
            if(this.FSceneModel.EnterType == ENTER_TYPE_CAMP)
            {
               this.FNodalModel.AddCampaignEnemyIndex(this.FSceneModel.CityId,this.FSceneModel.MissionId);
               if(this.FGroupMonsterVect.length <= 0 && !this.FIsPass)
               {
                  if(this.FPassDoor == null)
                  {
                     this.CreateDoor();
                  }
                  this.FPassDoor.Visible = true;
                  if(this.FControlGroupRole != null)
                  {
                     _loc4_ = this.FControlGroupRole.MapX + 250;
                  }
                  else
                  {
                     _loc4_ = SBattleConfig.GetPostionByCamyPos(0,1,SBattleConfig.Type_PostionX) + 80;
                  }
                  this.FPassDoor.MapX = _loc4_;
                  this.FPassDoor.MapY = SBattleConfig.GetPostionByCamyPos(1,1,SBattleConfig.Type_PostionY);
               }
            }
            this.FRunAreaWidth += MonsterGroup_Stamp;
            this.FRunAreaWidth = Math.min(this.FRunAreaWidth,2500);
            this.FBackGround.RoleControlWidth = this.FRunAreaWidth;
         }
         else
         {
            if(this.FGroupMonsterVect[0] != null)
            {
               this.FGroupMonsterVect[0].visible = true;
            }
            this.CheckPopTip();
         }
         this.FControlGroupRole.visible = true;
         this.StopUpdata = false;
         this.UpdateReturnHomePanel();
         this.FVisibleNavigation = true;
         if(this.FSceneModel.EnterType == ENTER_TYPE_NODAL)
         {
            if(this.FGroupMonsterVect.length <= 0)
            {
               this.FVisibleNavigation = false;
               if(this.FOnProcessorCheckPlot != null)
               {
                  this.FOnProcessorCheckPlot(this,TProcessorPlot.PLOT_TYPE_Nodal,TProcessorPlot.PLOT_POS_End,this.FSceneModel.CityId,this.ShowPassWindow);
                  return;
               }
            }
         }
         if(this.FGroupMonsterVect.length <= 0)
         {
            this.FVisibleNavigation = false;
            this.ShowPassWindow();
         }
         this.ProcessorPlayMusic(this.FSceneModel.EnterType);
      }
      
      public function GetSceneBitmapData() : BitmapData
      {
         var _loc1_:BitmapData = null;
         _loc1_ = new BitmapData(CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         _loc1_.draw(this.FBackGround);
         return _loc1_;
      }
      
      public function SetGotoTarget() : void
      {
         if(this.FSceneModel.EnterType == 0 || this.FSceneModel.EnterType == 2)
         {
            if(this.FGroupMonsterVect.length > 0)
            {
               this.SetMove(this.FGroupMonsterVect[0].MapX,this.FGroupMonsterVect[0].MapY);
            }
         }
         else if(this.FSceneModel.EnterType == 1)
         {
            if(this.FGroupMonsterVect.length > 0)
            {
               this.SetMove(this.FGroupMonsterVect[0].MapX,this.FGroupMonsterVect[0].MapY);
            }
            else
            {
               this.SetMove(this.FPassDoor.MapX,this.FPassDoor.MapY);
            }
         }
      }
      
      public function SetTurnBackDialog() : void
      {
         if(this.FWindowConfirmationTurnBack == null)
         {
            this.FWindowConfirmationTurnBack = new TUIWindowConfirmation(Parent);
            TUtilityUIWindow.SetupWindowConfirmation(this.FWindowConfirmationTurnBack);
            this.FWindowConfirmationTurnBack.OnOK = this.EnterCityScene;
            this.FWindowConfirmationTurnBack.Text = STRING_BATTLE.STRINGS_ReturnCityTipInfo;
            this.FWindowConfirmationTurnBack.x = (CONST_COMMON.STAGE_Width - this.FWindowConfirmationTurnBack.Scene.width) / 2;
            this.FWindowConfirmationTurnBack.y = (CONST_COMMON.STAGE_Height - this.FWindowConfirmationTurnBack.Scene.height) / 2;
         }
         this.FWindowConfirmationTurnBack.Visible = true;
      }
      
      override public function ShortcutModesSetup(param1:TLobbyShortcutModes) : void
      {
         var _loc2_:TLobbyShortcutAvatarModes = null;
         var _loc3_:TLobbyShortcutActivityModes = null;
         var _loc4_:TLobbyShortcutActiveSpecialModes = null;
         var _loc5_:TLobbyShortcutFunctionModes = null;
         var _loc6_:TLobbyShortcutMapModes = null;
         var _loc7_:TLobbyShortcutQuestGuideModes = null;
         var _loc8_:TLobbyShortcutConstantlyModes = null;
         if(!this.FVisibleNavigation)
         {
            super.ShortcutModesSetup(param1);
            return;
         }
         if(param1 is TLobbyShortcutAvatarModes)
         {
            _loc2_ = param1 as TLobbyShortcutAvatarModes;
            _loc2_.ShortcutModeAvatar = TLobbyShortcutMode.SHORTCUTMODE_Show;
         }
         if(param1 is TLobbyShortcutActivityModes)
         {
            _loc3_ = param1 as TLobbyShortcutActivityModes;
            _loc3_.SetAllShortcutHide();
         }
         if(param1 is TLobbyShortcutActiveSpecialModes)
         {
            _loc4_ = param1 as TLobbyShortcutActiveSpecialModes;
            _loc4_.ShortcutModeCDK = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutFunctionModes)
         {
            _loc5_ = param1 as TLobbyShortcutFunctionModes;
            _loc5_.ShortcutModeHero = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeStar = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeTacticalDeployment = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeInheritPractice = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeBackpack = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeTreasure = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeSummonPet = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeStrengthen = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeMail = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeTongLing = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeOrganiZation = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeReturn = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutMapModes)
         {
            _loc6_ = param1 as TLobbyShortcutMapModes;
            _loc6_.ShortcutModeMap = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc6_.ShortcutModeReturnHome = TLobbyShortcutMode.SHORTCUTMODE_Show;
         }
         if(param1 is TLobbyShortcutQuestGuideModes)
         {
            _loc7_ = param1 as TLobbyShortcutQuestGuideModes;
            _loc7_.ShortcutMode = TLobbyShortcutMode.SHORTCUTMODE_Show;
         }
         if(param1 is TLobbyShortcutConstantlyModes)
         {
            _loc8_ = param1 as TLobbyShortcutConstantlyModes;
            _loc8_.ShortcutModeStrengthen = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeArena = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeBigDipper = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeMentorship = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeTongLing = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
      }
      
      override public function ChatOptionsSetup(param1:TChatOptions) : void
      {
         if(!this.FVisibleNavigation)
         {
            param1.ChatStatus = CONST_CHAT.MODE_Hidden;
            return;
         }
         param1.ChatOptionsReset();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(param1 != null)
         {
            this.OnEnterScene(param1);
         }
         if(!FIsResourcesLoadCompleted)
         {
            this.FLayerLittleScript.Load();
            return;
         }
         this.LoadResourcesEnd();
         this.ProcessorEnterHurdle();
         if(this.FSceneModel != null)
         {
            this.ProcessorPlayMusic(this.FSceneModel.EnterType);
         }
         if(this.FOnProcessorCheckPopTips != null)
         {
            this.FOnProcessorCheckPopTips(this);
         }
         this.FVisibleNavigation = true;
      }
      
      override public function Unmount() : void
      {
         this.FVisibleNavigation = true;
      }
   }
}

