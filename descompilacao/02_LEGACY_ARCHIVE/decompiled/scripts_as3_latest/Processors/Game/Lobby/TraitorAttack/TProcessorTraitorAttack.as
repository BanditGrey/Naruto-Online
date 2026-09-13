package Processors.Game.Lobby.TraitorAttack
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.Characters.MoveRole.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Streamization.TraitorAttack.*;
   import Logics.TraitorAttack.*;
   import Processors.Game.Lobby.CityDefend.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Common.Shortcuts.*;
   import Processors.Game.Lobby.MainScene.*;
   import Processors.Game.Lobby.MainScene.Role.*;
   import Processors.Game.Windows.Information.*;
   import Rendering.Overlayers.HelpTips.*;
   import Rendering.Overlayers.Hints.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.utils.*;
   
   public class TProcessorTraitorAttack extends TProcessorLobbyPlate
   {
      
      protected static const TYPE_PROFESSIONS:Vector.<String> = STRING_COMMON.TYPE_PROFESSIONS;
      
      protected static const MonsterBaseId:uint = 12500001;
      
      protected static const MonsterWaveBase:uint = 100;
      
      protected static const MAX_MONSTER_COUNT:uint = 5;
      
      protected static const SendToServerPositionMinimumSpacing:int = 300 * 300;
      
      protected var FBackGround:TLayerBackGround;
      
      protected var FCanMove:TLayerCanMove;
      
      protected var FLayerLittleScript:TLayerLittleScript;
      
      protected var FPreTargetMapX:int;
      
      protected var FPreTargetMapY:int;
      
      protected var FMonsterLayer:TUIComponent;
      
      protected var FMainRole:TUIRoleCanMovePlayerRoleMainRole;
      
      protected var FMonsters:Vector.<TTraitorAttackActive>;
      
      protected var FDeadMonsters:Vector.<TTraitorAttackActive>;
      
      protected var FCheckTouchRoleVect:Vector.<TUIRoleCanMovePlayerRole>;
      
      protected var FBackLayerMask:Sprite;
      
      protected var FIsInBattle:Boolean;
      
      protected var FMc_Resurrection_Autofire:MovieClip;
      
      protected var FTraitorAttackData:TTraitorAttackData;
      
      protected var FUnstreamizerTraitorAttack:TUnstreamizerTraitorAttack;
      
      protected var FTipsScene:MovieClip;
      
      protected var FTipRole:TTraitorAttackActive;
      
      protected var FScene:MovieClip;
      
      protected var FProcessorWindowTraitorAttack:TProcessorWindowTraitorAttack;
      
      protected var FProcessorWindowCountdownStart:TProcessorWindowCountdown;
      
      protected var FProcessorWindowCountdown:TProcessorWindowCountdown;
      
      protected var FProcessorWindowCountdownEnterTown:TProcessorWindowCountdown;
      
      protected var FProcessorWindowResurrection:TProcessorWindowResurrection;
      
      protected var FWindowConfirmationTurnBack:TUIWindowConfirmation;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FCharacter:TCharacter;
      
      protected var FIsArriveTarget:Boolean;
      
      protected var FIsDie:Boolean;
      
      protected var FBattleBack:Boolean;
      
      protected var FDieTime:uint;
      
      protected var FCostVect:Vector.<uint>;
      
      protected var FAppearcd:uint;
      
      protected var FHeroTalentBins:TBins;
      
      protected var FSkillBins:TBins;
      
      protected var FMakeMonsterSign:Dictionary;
      
      protected var FOnEnterCityScene:Function;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FOnUpdateReturnHomePanel:Function;
      
      protected var FSetSceneBitmapData:Function;
      
      protected var FOnEndAutoBattle:Function;
      
      protected var FExecuteCommand:Function;
      
      protected var FMonster:TTraitorAttackActive;
      
      protected var FIsHooked:Boolean = false;
      
      protected var FIsAutoGoldResurgence:Boolean = false;
      
      protected var FIsAutoSkipResurgence:Boolean = false;
      
      protected var FOpenThisPanel:Function;
      
      public function TProcessorTraitorAttack(param1:TUIComponent, param2:TLobbyParameters)
      {
         var _loc3_:BitmapData = null;
         var _loc4_:Bitmap = null;
         super(param1,param2);
         this.FBackGround = new TLayerBackGround(this,CONST_MODULES.MODULE_TraitorAttack);
         this.FBackGround.OnLoadCompleted = this.ProcessorResourcesOnLoadCompleted;
         this.FBackGround.IsNeedSmallPic = false;
         this.FBackGround.visible = true;
         this.FBackGround.RoleControlWidth = CONST_COMMON.STAGE_Width;
         this.FBackLayerMask = new Sprite();
         this.FBackLayerMask.graphics.beginFill(0,0.2);
         this.FBackLayerMask.graphics.drawRect(0,0,this.FBackGround.Width,this.FBackGround.Height);
         this.FBackLayerMask.graphics.endFill();
         this.FBackLayerMask.visible = false;
         this.addChild(this.FBackLayerMask);
         this.FCanMove = new TLayerCanMove(this.FBackGround,CONST_MODULES.MODULE_TraitorAttack);
         this.FCanMove.visible = false;
         this.FMonsterLayer = new TUIComponent(this.FBackGround);
         this.FLayerLittleScript = new TLayerLittleScript(this);
         this.FLayerLittleScript.visible = true;
         this.FLayerLittleScript.MouseEventObject = this.FBackGround;
         this.FLayerLittleScript.ChangeRolePositionByMouse = this.OnMoveByMouse;
         this.FLayerLittleScript.LongClickMove = false;
         this.FCharacter = SLogicsCore.Character;
         this.FTraitorAttackData = new TTraitorAttackData();
         this.FUnstreamizerTraitorAttack = new TUnstreamizerTraitorAttack();
         this.FMonsters = new Vector.<TTraitorAttackActive>();
         this.FDeadMonsters = new Vector.<TTraitorAttackActive>();
         this.FCheckTouchRoleVect = new Vector.<TUIRoleCanMovePlayerRole>();
         this.FMakeMonsterSign = new Dictionary();
         this.FProcessorWindowResurrection = new TProcessorWindowResurrection(this);
         this.FBattleBack = false;
         SetUIModuleID(CONST_MODULES.MODULE_TraitorAttack);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         super.LogicsPerform();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_TraitorAttack)
         {
            this.FBackGround.Update();
            this.FCanMove.Update();
            this.LogicsPerform_Timer();
            this.FMonsterLayer.x = -SLogicsCore.ScreenMapX;
            this.UpdataMonster();
            this.CheckRoleTouchMonster();
         }
      }
      
      protected function LogicsPerform_Timer() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         if(this.FOnUpdateReturnHomePanel != null)
         {
            _loc1_ = this.FTraitorAttackData.EndTime - STimingCore.GetServerTick();
            _loc2_ = TGameUtil.fomatTime(_loc1_);
            this.FOnUpdateReturnHomePanel(this,STRING_TRAITORATTACK.STRING_Activity_Name,STRING_COMMON.STRING_EndTime + _loc2_);
         }
      }
      
      protected function UpdataMonster() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TTraitorAttackActive = null;
         _loc1_ = 0;
         while(_loc1_ < this.FMonsters.length)
         {
            _loc2_ = this.FMonsters[_loc1_];
            if(_loc2_ != null)
            {
               this.FMonster = _loc2_;
               _loc2_.UpdateActive();
               if(!this.FIsDie && _loc2_.Display.hitTestObject(this.FMainRole))
               {
                  this.EnterFightReq(_loc2_.Id);
                  break;
               }
            }
            _loc1_++;
         }
         this.DeathCountdown(this);
         this.FMonsters.sort(this.SortPos);
         _loc1_ = 0;
         while(_loc1_ < this.FMonsters.length)
         {
            this.FMonsterLayer.setChildIndex(this.FMonsters[_loc1_],_loc1_);
            _loc1_++;
         }
      }
      
      protected function SortPos(param1:TTraitorAttackActive, param2:TTraitorAttackActive) : int
      {
         if(param1.y < param2.y)
         {
            return -1;
         }
         if(param1.y > param2.y)
         {
            return 1;
         }
         return 0;
      }
      
      protected function CheckRoleTouchMonster() : void
      {
         var _loc1_:* = 0;
         var _loc2_:TUIRoleCanMovePlayerRole = null;
         _loc1_ = 0;
         while(_loc1_ < this.FCheckTouchRoleVect.length)
         {
            _loc2_ = this.FCheckTouchRoleVect[_loc1_];
            if(this.IsRoleTouchMonster(_loc2_))
            {
               this.FCanMove.InitNewRole(_loc2_);
               this.FCheckTouchRoleVect.splice(_loc1_,1);
               _loc1_--;
               break;
            }
            _loc1_++;
         }
      }
      
      protected function IsRoleTouchMonster(param1:TUIRoleCanMovePlayerRole) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:TTraitorAttackActive = null;
         if(param1.MapX >= 1200)
         {
            return true;
         }
         _loc2_ = 0;
         while(_loc2_ < this.FMonsters.length)
         {
            _loc3_ = this.FMonsters[_loc2_];
            if(_loc3_ != null)
            {
               if(_loc3_.Display.hitTestObject(param1))
               {
                  return true;
               }
            }
            _loc2_++;
         }
         return false;
      }
      
      protected function ProcessorResourcesOnLoadCompleted(param1:Object) : void
      {
         this.FCanMove.visible = true;
      }
      
      protected function ChangeSceneId(param1:uint) : void
      {
         this.FCanMove.visible = true;
         this.FBackGround.SwitchScene(param1);
      }
      
      protected function CreateMainRole() : void
      {
         var _loc1_:THero = null;
         var _loc2_:TRoleCanControl = null;
         var _loc3_:TUIRoleCanMovePet = null;
         if(this.FMainRole != null)
         {
            return;
         }
         _loc2_ = SLogicsCore.PoolUIRoleCanMove.AcquireRoleCanControl(0,0);
         _loc1_ = this.FCharacter.GetMainHero();
         _loc2_.RoleName = _loc1_.Name;
         _loc2_.RoleTemplateID = _loc1_.Identifier;
         _loc2_.MilitaryRank = this.FCharacter.MilitaryRank;
         _loc2_.TitleID = this.FCharacter.TitleId;
         _loc2_.LittlePetID = this.FCharacter.LittlePetId;
         this.FMainRole = new TUIRoleCanMovePlayerRoleMainRole(this.FCanMove);
         this.FMainRole.ModuleId = CONST_MODULES.MODULE_TraitorAttack;
         this.FMainRole.ChangeTextureID(_loc1_.ModelID);
         this.FMainRole.RoleData = _loc2_;
         this.FMainRole.OnArriveTarget = this.OnMainRoleArriveTarget;
         this.FMainRole.Init();
         this.FMainRole.RoleData.Quality = _loc1_.Quality;
         this.FMainRole.UpdateMainRoleNameColor();
         _loc3_ = new TUIRoleCanMovePet(this.FCanMove);
         _loc3_.ModuleId = CONST_MODULES.MODULE_TraitorAttack;
         _loc3_.TextrueID = this.FCharacter.Pet.PetModelID;
         _loc3_.FollowRole = this.FMainRole;
         _loc3_.RelexBoo = this.FCharacter.Pet.RelexBoo;
         this.FMainRole.Pet = _loc3_;
         _loc3_.Init();
         this.FCanMove.InitNewRole(this.FMainRole);
         this.FCanMove.MainRole = this.FMainRole;
         this.FBackGround.ScreenRole = this.FMainRole;
         this.FLayerLittleScript.MainRole = this.FMainRole;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TRAITORATTACK.RESOURCE_TraitorAttack);
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BATTLESCENE.RESOURCESID_BATTLESCENE);
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
         this.InitTraitorAttack();
         this.FOverlayerHint = new TOverlayerHint(this);
         this.FOverlayerHint.Visible = false;
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function InitTraitorAttack() : void
      {
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_TRAITORATTACK.RESOURCE_ClassName_MC_TraitorAttack) as MovieClip;
         addChild(this.FScene);
         this.FProcessorWindowCountdownStart = new TProcessorWindowCountdown(this);
         this.FProcessorWindowCountdownStart.SetScene(this.FScene.mc_StartCountdown);
         this.FProcessorWindowCountdownStart.Visible = false;
         this.FProcessorWindowCountdownStart.OnTimeOver = this.DeathCountdown;
         this.FProcessorWindowCountdown = new TProcessorWindowCountdown(this);
         this.FProcessorWindowCountdown.SetScene(this.FScene.mc_Countdown);
         this.FProcessorWindowCountdown.Visible = false;
         this.FProcessorWindowCountdown.OnTimeOver = this.DeathCountdown;
         this.FProcessorWindowCountdownEnterTown = new TProcessorWindowCountdown(this);
         this.FProcessorWindowCountdownEnterTown.SetScene(this.FScene.mc_ReturnCity);
         this.FProcessorWindowCountdownEnterTown.Visible = false;
         this.FMc_Resurrection_Autofire = this.FScene.mc_Resurrection_Autofire;
         this.FMc_Resurrection_Autofire.visible = false;
         this.FProcessorWindowResurrection.OnEffectText = EffectGenerateText;
         this.FProcessorWindowResurrection.HintOnOver = this.UIComponentsHintOnOver;
         this.FProcessorWindowResurrection.HintOnOut = this.UIComponentsHintOnOut;
         this.FProcessorWindowResurrection.ShowBack = this.OnShowBack;
         this.FProcessorWindowResurrection.SetScene(this.FScene.mc_Resurrection,false);
         this.FProcessorWindowResurrection.Visible = false;
         this.FProcessorWindowTraitorAttack = new TProcessorWindowTraitorAttack(this);
         this.FProcessorWindowTraitorAttack.HintOnOver = this.UIComponentsHintOnOver;
         this.FProcessorWindowTraitorAttack.HintOnOut = this.UIComponentsHintOnOut;
         this.FProcessorWindowTraitorAttack.HelpHintOnOver = this.UIHelpHintOnOver;
         this.FProcessorWindowTraitorAttack.HelpHintOnOut = this.UIHelpHintOnOut;
         this.FProcessorWindowTraitorAttack.SetScene(this.FScene);
         this.FProcessorWindowTraitorAttack.InitUI(this.FTraitorAttackData);
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      protected function UIComponentsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHint.Hide();
      }
      
      protected function UIHelpHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHelpTips.Context = param2;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function UIHelpHintOnOut(param1:Object) : void
      {
         this.FOverlayerHelpTips.Hide();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Town_NewRoleNtf,this.AddNewRole);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Town_RoleMove,this.RoleMove);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Town_RemoveRole,this.RemoveTownRole);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Town_UpdateRole,this.UpdateRole);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TraitorAttack_ReviveRet,this.PacketPerform_SC_ReviveRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TraitorAttack_MonsterInfo,this.PacketPerform_SC_MonsterInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TraitorAttack_BattleRet,this.PacketPerform_SC_BattleRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TraitorAttack_RankUpdate,this.PacketPerform_SC_RankUpdate);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TraitorAttack_RebornNotify,this.PacketPerform_SC_RebornNotify);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TraitorAttack_DeathNotify,this.PacketPerform_SC_DeathNotify);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TraitorAttack_RoundUpdate,this.PacketPerform_SC_RoundUpdate);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TraitorAttack_ScoreUpdate,this.PacketPerform_SC_ScoreUpdate);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TraitorAttack_PlayerCount,this.PacketPerform_SC_PlayerCount);
      }
      
      protected function PacketPerform_SC_Enter_TraitorAttack(param1:ByteArray) : void
      {
         var _loc2_:TBins = null;
         var _loc3_:uint = 0;
         var _loc4_:TConfigValue = null;
         this.FUnstreamizerTraitorAttack.Unstreamize(param1,this.FTraitorAttackData,null);
         _loc2_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConfigValue);
         _loc4_ = _loc2_.GetDatebaseByIdentifier(CONST_CONFIGVALUE.TraitorAttack_Mapid) as TConfigValue;
         _loc3_ = _loc4_.Value as uint;
         _loc4_ = _loc2_.GetDatebaseByIdentifier(CONST_CONFIGVALUE.TraitorAttack_Revivecost) as TConfigValue;
         this.FCostVect = _loc4_.Value as Vector.<uint>;
         _loc4_ = _loc2_.GetDatebaseByIdentifier(CONST_CONFIGVALUE.TraitorAttack_Deathtime) as TConfigValue;
         this.FDieTime = _loc4_.Value as int;
         _loc4_ = _loc2_.GetDatebaseByIdentifier(CONST_CONFIGVALUE.TraitorAttack_Appearcd) as TConfigValue;
         this.FAppearcd = _loc4_.Value as int;
         this.ChangeSceneId(_loc3_);
      }
      
      protected function AddNewRole(param1:TPacket) : void
      {
         this.FCanMove.AddNewCanControlRole(param1);
      }
      
      protected function RoleMove(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc2_ = param1.Data.readUnsignedInt();
         _loc3_ = param1.Data.readUnsignedInt();
         _loc4_ = param1.Data.readUnsignedShort();
         _loc5_ = param1.Data.readUnsignedShort();
         this.FCanMove.PlayerMove(_loc2_,_loc3_,_loc4_,_loc5_);
      }
      
      protected function RemoveTownRole(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TUIRoleCanMovePlayerRole = null;
         _loc2_ = param1.Data.readUnsignedInt();
         _loc3_ = param1.Data.readUnsignedInt();
         this.FCanMove.PlayerRemove(_loc2_,_loc3_);
         _loc4_ = 0;
         while(_loc4_ < this.FCheckTouchRoleVect.length)
         {
            _loc5_ = this.FCheckTouchRoleVect[_loc4_];
            if(_loc5_.RoleData.Identifier0 == _loc2_ && _loc5_.RoleData.Identifier1 == _loc3_)
            {
               this.FCheckTouchRoleVect.splice(_loc4_,1);
               break;
            }
            _loc4_++;
         }
      }
      
      protected function PacketPerform_SC_ReviveRet(param1:TPacket) : void
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
         this.FProcessorWindowResurrection.ResurrectionOk();
         ++this.FTraitorAttackData.ResurrectionTimes;
      }
      
      protected function PacketPerform_SC_MonsterInfo(param1:TPacket) : void
      {
         var _loc2_:* = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         var _loc5_:TTraitorAttackActive = null;
         _loc3_ = param1.Data;
         this.FUnstreamizerTraitorAttack.UnstreamizeTraitorAttackMonsterInfo(_loc3_,this.FTraitorAttackData,null);
         _loc2_ = 0;
         while(_loc2_ < this.FMonsters.length)
         {
            _loc5_ = this.FMonsters[_loc2_];
            _loc4_ = uint(_loc5_.Id);
            if(this.FTraitorAttackData.MonsterList[_loc4_] <= 0)
            {
               this.FMonsters.splice(_loc2_,1);
               _loc2_--;
               this.FDeadMonsters.push(_loc5_);
               _loc5_.IsDie = true;
               if(_loc5_.parent)
               {
                  _loc5_.parent.removeChild(_loc5_);
               }
            }
            else
            {
               _loc5_.SetHp(this.FTraitorAttackData.MonsterList[_loc4_]);
            }
            _loc2_++;
         }
      }
      
      protected function PacketPerform_SC_BattleRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TUIRoleCanMovePlayerRole = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FIsInBattle = true;
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_TraitorAttack,0,this.FIsHooked,this.FIsAutoGoldResurgence,this.FIsAutoSkipResurgence);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
         _loc4_ = 0;
         while(_loc4_ < this.FCheckTouchRoleVect.length)
         {
            _loc5_ = this.FCheckTouchRoleVect[_loc4_];
            this.FCanMove.InitNewRole(_loc5_);
            _loc4_++;
         }
         this.FCheckTouchRoleVect.length = 0;
         this.FMainRole.StopMove();
      }
      
      protected function PacketPerform_SC_RankUpdate(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerTraitorAttack.UnstreamizeTraitorAttackRankUpdate(_loc2_,this.FTraitorAttackData.RankList,null);
         if(this.FProcessorWindowTraitorAttack != null)
         {
            this.FProcessorWindowTraitorAttack.UpdataRankUI();
         }
      }
      
      protected function PacketPerform_SC_RebornNotify(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TUIRoleCanMovePlayerRole = null;
         _loc2_ = param1.Data.readUnsignedInt();
         _loc3_ = param1.Data.readUnsignedInt();
         _loc4_ = this.FCanMove.RolesUI.GetRoleByIdentifier(_loc2_,_loc3_);
         if(_loc4_ != null)
         {
            this.FCanMove.PlayerMove(_loc2_,_loc3_,1200,480);
            this.FCheckTouchRoleVect.push(_loc4_);
         }
      }
      
      protected function PacketPerform_SC_DeathNotify(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         if(this.FTraitorAttackData.ResurrectionTimes < this.FCostVect.length)
         {
            _loc2_ = this.FCostVect[this.FTraitorAttackData.ResurrectionTimes];
         }
         else
         {
            _loc2_ = this.FCostVect[this.FCostVect.length - 1];
         }
         this.FProcessorWindowResurrection.StartCountdown(STimingCore.GetServerTick() + this.FDieTime,_loc2_);
      }
      
      protected function PacketPerform_SC_RoundUpdate(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TUIRoleCanMovePlayerRole = null;
         var _loc6_:uint = 0;
         var _loc7_:TTraitorAttackActive = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         this.FTraitorAttackData.CurWave = _loc3_;
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FProcessorWindowTraitorAttack.UpdataWave();
         if(this.FProcessorWindowCountdownStart.GetLastTime() < this.FAppearcd)
         {
            this.FProcessorWindowCountdownStart.Stop();
            this.FProcessorWindowCountdown.StartCountdown(STimingCore.GetServerTick() + this.FAppearcd);
         }
         setTimeout(this.EnterNextWaveMonster,this.FAppearcd * 1000);
         _loc4_ = 0;
         while(_loc4_ < this.FCanMove.RolesUI.Count)
         {
            _loc5_ = this.FCanMove.RolesUI.GetRoleByIndex(_loc4_);
            this.FCanMove.InitNewRole(_loc5_);
            _loc4_++;
         }
         this.FCanMove.InitNewRole(this.FMainRole);
         this.FCheckTouchRoleVect.length = 0;
         _loc6_ = this.FMonsters.length;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc7_ = this.FMonsters.pop();
            _loc7_.IsDie = true;
            this.FDeadMonsters.push(_loc7_);
            if(_loc7_.parent)
            {
               _loc7_.parent.removeChild(_loc7_);
            }
            _loc4_++;
         }
         if(!this.FIsInBattle)
         {
            SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_TraitorAttackMonster);
         }
      }
      
      protected function PacketPerform_SC_ScoreUpdate(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerTraitorAttack.UnstreamizeTraitorAttackScoreUpdate(_loc2_,this.FTraitorAttackData,null);
         if(this.FProcessorWindowTraitorAttack != null)
         {
            this.FProcessorWindowTraitorAttack.UpdataScoreUI();
         }
      }
      
      protected function PacketPerform_SC_PlayerCount(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FTraitorAttackData.EnterHeroCount = _loc2_.readUnsignedInt();
         if(this.FProcessorWindowTraitorAttack != null)
         {
            this.FProcessorWindowTraitorAttack.UpdataPlayerCountUI();
         }
      }
      
      protected function UpdateRole(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         _loc2_ = param1.Data.readUnsignedInt();
         _loc3_ = param1.Data.readUnsignedInt();
         _loc4_ = param1.Data.readByte();
         _loc5_ = param1.Data.readUnsignedInt();
         this.FCanMove.PlayerUpdate(_loc2_,_loc3_,_loc4_,_loc5_);
      }
      
      protected function OnMainRoleArriveTarget() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         if(!this.FIsArriveTarget)
         {
            return;
         }
      }
      
      protected function UpdateRolePositionSendToServer() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         _loc1_ = this.FLayerLittleScript.TargetMapX - this.FPreTargetMapX;
         _loc2_ = this.FLayerLittleScript.TargetMapY - this.FPreTargetMapY;
         _loc3_ = _loc1_ * _loc1_ + _loc2_ * _loc2_;
         if(_loc3_ > SendToServerPositionMinimumSpacing)
         {
            this.FPreTargetMapX = this.FLayerLittleScript.TargetMapX;
            this.FPreTargetMapY = this.FLayerLittleScript.TargetMapY;
            this.PacketPerform_CS_LOBBY_Town_Move(this.FLayerLittleScript.TargetMapX,this.FLayerLittleScript.TargetMapY);
         }
      }
      
      protected function PacketPerform_CS_LOBBY_Town_Move(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LOBBY_Town_Move);
         _loc4_ = _loc3_.Data;
         _loc4_.writeShort(param1);
         _loc4_.writeShort(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function OnMoveByMouse() : void
      {
         this.FIsArriveTarget = false;
         this.UpdateRolePositionSendToServer();
      }
      
      protected function EnterCityScene(param1:Object = null) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TTraitorAttackActive = null;
         if(this.FOnEnterCityScene != null)
         {
            this.FOnEnterCityScene(param1);
         }
         this.FCanMove.ClearAllRole();
         _loc3_ = this.FMonsters.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FMonsters.pop();
            _loc4_.IsDie = true;
            _loc4_.Releasing();
            if(_loc4_.parent)
            {
               _loc4_.parent.removeChild(_loc4_);
            }
            _loc4_ = null;
            _loc2_++;
         }
         _loc3_ = this.FDeadMonsters.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FDeadMonsters.pop();
            _loc4_.Releasing();
            if(_loc4_.parent)
            {
               _loc4_.parent.removeChild(_loc4_);
            }
            _loc4_ = null;
            _loc2_++;
         }
         this.FMakeMonsterSign = new Dictionary();
         this.FCheckTouchRoleVect.length = 0;
         this.FBackGround.Reset();
         SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_TraitorAttack);
         SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_TraitorAttackMonster);
      }
      
      protected function OnShowBack(param1:Object, param2:Boolean) : void
      {
         if(param2)
         {
            this.FIsDie = true;
            this.FBackGround.filters = [TGameUtil.rBlackFilters];
         }
         else
         {
            this.FIsDie = false;
            this.FBackGround.filters = [];
         }
      }
      
      protected function OnResurrection(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TraitorAttack_ReviveReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function EnterTraitorAttack() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         this.FProcessorWindowCountdownStart.StartCountdown(STimingCore.GetServerTick() + this.FTraitorAttackData.CDTime);
         this.FProcessorWindowCountdown.Stop();
         this.FProcessorWindowResurrection.Stop();
         _loc1_ = 0;
         while(_loc1_ < MAX_MONSTER_COUNT)
         {
            _loc2_ = MonsterBaseId + this.FTraitorAttackData.CurWave * MonsterWaveBase + _loc1_;
            if(this.FTraitorAttackData.MonsterList[_loc2_] == null)
            {
               this.FTraitorAttackData.MonsterList[_loc2_] = 10000000;
            }
            _loc1_++;
         }
         if(this.FTraitorAttackData.EndTime - STimingCore.GetServerTick() > 30 * 60)
         {
            setTimeout(this.EnterNextWaveMonster,this.FTraitorAttackData.CDTime * 1000);
         }
         else
         {
            setTimeout(this.EnterNextWaveMonster,1000);
         }
         this.OnShowBack(this,false);
         this.FProcessorWindowTraitorAttack.UpdataRankUI();
         this.FProcessorWindowTraitorAttack.UpdataScoreUI();
         this.FProcessorWindowTraitorAttack.UpdataWave();
         this.FProcessorWindowTraitorAttack.UpdataPlayerCountUI();
      }
      
      protected function EnterNextWaveMonster() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TTraitorAttackActive = null;
         if(this.FMakeMonsterSign[this.FTraitorAttackData.CurWave] == true)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_MONSTER_COUNT)
         {
            _loc2_ = MonsterBaseId + this.FTraitorAttackData.CurWave * MonsterWaveBase + _loc1_;
            if(this.FTraitorAttackData.MonsterList[_loc2_] > 0)
            {
               if(this.FDeadMonsters.length > 0)
               {
                  _loc3_ = this.FDeadMonsters.pop();
                  _loc3_.ResetActive(this.FMonsterLayer,_loc2_,CONST_MODULES.MODULE_TraitorAttackMonster,true);
               }
               else
               {
                  _loc3_ = new TTraitorAttackActive(this.FMonsterLayer,_loc2_,CONST_MODULES.MODULE_TraitorAttackMonster,true);
                  _loc3_.addEventListener(MouseEvent.MOUSE_MOVE,this.ShowTips);
                  _loc3_.addEventListener(MouseEvent.ROLL_OUT,this.HideTips);
               }
               _loc3_.InitPos(1350 - 40 * _loc1_,400 + 40 * _loc1_);
               _loc3_.RunToStage();
               this.FMonsters.push(_loc3_);
               _loc3_.SetHp(this.FTraitorAttackData.MonsterList[_loc2_]);
            }
            _loc1_++;
         }
         this.FMakeMonsterSign[this.FTraitorAttackData.CurWave] = true;
      }
      
      protected function GetSceneBitmapData() : BitmapData
      {
         var _loc1_:BitmapData = null;
         _loc1_ = new BitmapData(CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         _loc1_.draw(this.FBackGround);
         return _loc1_;
      }
      
      protected function EnterFightReq(param1:uint) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         this.FCanMove.InitNewRole(this.FMainRole);
         this.FPreTargetMapX = 0;
         this.FPreTargetMapY = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TraitorAttack_BattleReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.FCanMove.visible = false;
         this.FMonsterLayer.visible = false;
         if(this.FSetSceneBitmapData != null)
         {
            this.FSetSceneBitmapData(this,this.GetSceneBitmapData());
         }
         this.FCanMove.visible = true;
         this.FMonsterLayer.visible = true;
      }
      
      protected function GetMonsterIndexById(param1:uint) : int
      {
         var _loc2_:uint = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FMonsters.length)
         {
            if(this.FMonsters[_loc2_].Id == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      protected function ShowTips(param1:MouseEvent) : void
      {
         var _loc2_:TTraitorAttackActive = null;
         var _loc3_:THeroTalent = null;
         var _loc4_:uint = 0;
         var _loc5_:TSkillConfig = null;
         if(this.FHeroTalentBins == null)
         {
            this.FHeroTalentBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_HeroTalent);
         }
         if(this.FSkillBins == null)
         {
            this.FSkillBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SkillConfig);
         }
         _loc2_ = param1.currentTarget as TTraitorAttackActive;
         if(this.FTipRole != _loc2_)
         {
            if(this.FTipRole != null)
            {
               this.FTipRole.ShowHighLight = false;
            }
            this.FTipRole = _loc2_;
            if(_loc2_.direction == false)
            {
               FUICore.MouseCaptureSet(this.FTipRole);
               _loc2_.CursorHovering = true;
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
            if(_loc2_.EnemyData != null)
            {
               this.FTipsScene.tf_name.text = _loc2_.EnemyData.Name;
               this.FTipsScene.tf_level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc2_.EnemyData.Level);
               this.FTipsScene.tf_type.text = TYPE_PROFESSIONS[_loc2_.EnemyData.Profession];
               this.FTipsScene.tf_health.text = _loc2_.EnemyData.Hp;
               _loc3_ = this.FHeroTalentBins.GetDatebaseByIdentifier(_loc2_.EnemyData.TalentId) as THeroTalent;
               this.FTipsScene.tf_talent.text = _loc3_ ? _loc3_.TalentName : STRING_COMMON.COMMON_NONE;
               _loc5_ = this.FSkillBins.GetDatebaseByIdentifier(_loc2_.EnemyData.Skill) as TSkillConfig;
               this.FTipsScene.tf_skill.text = _loc5_.Name;
               this.FTipsScene.tf_skilldesc.text = _loc5_.Desc;
            }
            else
            {
               this.FTipsScene.tf_name.text = _loc2_.NpcData.Name;
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
      
      protected function HideTips(param1:MouseEvent) : void
      {
         FUICore.MouseCaptureRelease(this.FTipRole);
         this.FTipRole = null;
         if(this.FTipsScene != null)
         {
            this.FTipsScene.visible = false;
         }
      }
      
      public function get OnEnterCityScene() : Function
      {
         return this.FOnEnterCityScene;
      }
      
      public function set OnEnterCityScene(param1:Function) : void
      {
         this.FOnEnterCityScene = param1;
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      public function get SetStatusType() : Function
      {
         return this.FSetStatusType;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function get OnInitBattle() : Function
      {
         return this.FOnInitBattle;
      }
      
      public function set OnUpdateReturnHomePanel(param1:Function) : void
      {
         this.FOnUpdateReturnHomePanel = param1;
      }
      
      public function get OnUpdateReturnHomePanel() : Function
      {
         return this.FOnUpdateReturnHomePanel;
      }
      
      public function set BattleBack(param1:Boolean) : void
      {
         this.FBattleBack = param1;
      }
      
      public function get BattleBack() : Boolean
      {
         return this.FBattleBack;
      }
      
      public function get SetSceneBitmapData() : Function
      {
         return this.FSetSceneBitmapData;
      }
      
      public function set SetSceneBitmapData(param1:Function) : void
      {
         this.FSetSceneBitmapData = param1;
      }
      
      public function get OnEndAutoBattle() : Function
      {
         return this.FOnEndAutoBattle;
      }
      
      public function set OnEndAutoBattle(param1:Function) : void
      {
         this.FOnEndAutoBattle = param1;
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
         if(param1 is TLobbyShortcutAvatarModes)
         {
            _loc2_ = param1 as TLobbyShortcutAvatarModes;
            _loc2_.ShortcutModeAvatar = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
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
            _loc6_.ShortcutModeAutoBattle = TLobbyShortcutMode.SHORTCUTMODE_Show;
         }
         if(param1 is TLobbyShortcutQuestGuideModes)
         {
            _loc7_ = param1 as TLobbyShortcutQuestGuideModes;
            _loc7_.ShortcutMode = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutConstantlyModes)
         {
            _loc8_ = param1 as TLobbyShortcutConstantlyModes;
            _loc8_.ShortcutModeArena = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeBigDipper = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeStrengthen = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeMentorship = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeTongLing = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(this.FOpenThisPanel != null)
         {
            this.FOpenThisPanel(3);
         }
         if(this.FBattleBack)
         {
            this.FBattleBack = false;
            return;
         }
         this.FCharacter.RoleSencePosition = CONST_COMMON.SCENEPOSITION_TraitorAttack;
         if(param1 != null)
         {
            this.PacketPerform_SC_Enter_TraitorAttack(param1);
         }
         if(!FIsResourcesLoadCompleted)
         {
            this.FLayerLittleScript.Load();
            return;
         }
         this.CreateMainRole();
         this.EnterTraitorAttack();
         this.FCanMove.SwitchMode(SLogicsCore.IsShowAllUser);
      }
      
      protected function testData() : void
      {
         var _loc1_:TTraitorAttackRankHero = null;
         this.FTraitorAttackData.CDTime = 2;
         this.FTraitorAttackData.CurWave = 2;
         this.FTraitorAttackData.EndTime = STimingCore.GetServerTick() + 20 * 60;
         this.FTraitorAttackData.EnterHeroCount = 5;
         this.FTraitorAttackData.MonsterList[12500201] = 100000;
         this.FTraitorAttackData.MonsterList[12500202] = 200100;
         this.FTraitorAttackData.MonsterList[12500203] = 300200;
         this.FTraitorAttackData.MonsterList[12500204] = 400300;
         this.FTraitorAttackData.MonsterList[12500205] = 500400;
         this.FTraitorAttackData.ScoreList[0] = 30;
         this.FTraitorAttackData.ScoreList[1] = 20;
         this.FTraitorAttackData.ScoreList[2] = 10;
         var _loc2_:int = 0;
         while(_loc2_ < 8)
         {
            this.FTraitorAttackData.RankList.MySelfHarm.Low = 10001;
            this.FTraitorAttackData.RankList.TotleHarm.Low = 1000000;
            _loc1_ = new TTraitorAttackRankHero();
            _loc1_.HeroName = "abc" + _loc2_;
            _loc1_.HeroHarm.Low = 1000 * _loc2_;
            this.FTraitorAttackData.RankList.Add(_loc1_);
            _loc2_++;
         }
         this.FProcessorWindowTraitorAttack.UpdataPlayerCountUI();
         this.FProcessorWindowTraitorAttack.UpdataRankUI();
         this.FProcessorWindowTraitorAttack.UpdataScoreUI();
         this.FProcessorWindowTraitorAttack.UpdataWave();
         this.FProcessorWindowTraitorAttack.UpdataPlayerCountUI();
         this.ChangeSceneId(10201);
      }
      
      override public function Unmount() : void
      {
      }
      
      public function EnterTraitorAttackReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Enter_TraitorAttack);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function BackTownDialog() : void
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
         if(this.FOnEndAutoBattle != null)
         {
            this.FOnEndAutoBattle(this);
         }
         this.FWindowConfirmationTurnBack.Visible = true;
      }
      
      public function UpdatePet() : void
      {
         this.FMainRole.Pet.RelexBoo = SLogicsCore.Character.Pet.RelexBoo;
         this.FMainRole.Pet.visible = !SLogicsCore.Character.Pet.RelexBoo;
         if(!SLogicsCore.Character.Pet.RelexBoo)
         {
            this.FMainRole.Pet.TextrueID = SLogicsCore.Character.Pet.PetModelID;
            this.FMainRole.Pet.Init();
         }
      }
      
      public function ChangeMainHeroQuality() : void
      {
         this.FMainRole.RoleData.Quality = SLogicsCore.Character.MainHero.Quality;
         this.FMainRole.UpdateMainRoleNameColor();
      }
      
      public function TraitorAttackEnd() : void
      {
         if(this.FProcessorWindowCountdownEnterTown != null)
         {
            this.FProcessorWindowCountdownEnterTown.StartCountdown(STimingCore.GetServerTick() + 5);
            setTimeout(this.EnterCityScene,5000);
         }
         if(this.FProcessorWindowCountdownStart != null)
         {
            this.FProcessorWindowCountdownStart.Stop();
         }
         if(this.FProcessorWindowResurrection != null)
         {
            this.FProcessorWindowResurrection.Stop();
         }
         if(this.FProcessorWindowCountdown != null)
         {
            this.FProcessorWindowCountdown.Stop();
         }
         if(this.FOnEndAutoBattle != null)
         {
            this.FOnEndAutoBattle(this);
         }
      }
      
      public function ShowAndHide(param1:Boolean) : void
      {
         if(this.FCanMove != null)
         {
            this.FCanMove.SwitchMode(param1);
         }
      }
      
      public function DeathCountdown(param1:Object) : void
      {
         if(this.FIsHooked)
         {
            this.FBackLayerMask.visible = true;
            if(this.FMonster != null && this.FMainRole != null && !this.FProcessorWindowCountdownStart.getBoo() && !this.FProcessorWindowCountdown.getBoo() && !this.FProcessorWindowCountdownEnterTown.getBoo() && !this.FProcessorWindowResurrection.getBoo() && !this.FIsInBattle)
            {
               this.FMainRole.SetupTargetPosition(this.FMonster.x,this.FMonster.y,CONST_MainScene.RoleMoveSpeed);
            }
            this.FMc_Resurrection_Autofire.visible = this.FIsHooked;
         }
      }
      
      public function BattleEnd() : void
      {
         this.FIsInBattle = false;
         this.DeathCountdown(this);
      }
      
      public function GoldlackF() : void
      {
         if(this.FExecuteCommand != null)
         {
            this.FExecuteCommand({
               "type":2,
               "value":2
            });
         }
      }
      
      public function SetAutoBattle(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         this.FIsHooked = param1;
         this.FIsAutoGoldResurgence = param2;
         this.FProcessorWindowResurrection.FIsAutoGoldResurgence = this.FIsAutoGoldResurgence;
         this.FIsAutoSkipResurgence = param3;
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         if(!this.FMc_Resurrection_Autofire)
         {
            return;
         }
         if(param1)
         {
            this.FBackLayerMask.visible = param1;
            if(this.FMonster != null && this.FMainRole != null && !this.FProcessorWindowCountdownStart.getBoo() && !this.FProcessorWindowCountdown.getBoo() && !this.FProcessorWindowCountdownEnterTown.getBoo() && !this.FProcessorWindowResurrection.getBoo() && !this.FIsInBattle)
            {
               this.FMainRole.SetupTargetPosition(this.FMonster.x,this.FMonster.y,CONST_MainScene.RoleMoveSpeed);
            }
         }
         else
         {
            this.FBackLayerMask.visible = param1;
            if(this.FMonster != null)
            {
               this.FMainRole.StopMove();
            }
         }
         if(this.FMc_Resurrection_Autofire)
         {
            if(param1)
            {
               this.FMc_Resurrection_Autofire.gotoAndPlay(1);
            }
            else
            {
               this.FMc_Resurrection_Autofire.gotoAndStop(1);
            }
            this.FMc_Resurrection_Autofire.visible = param1;
         }
      }
      
      public function get ExecuteCommand() : Function
      {
         return this.FExecuteCommand;
      }
      
      public function set ExecuteCommand(param1:Function) : void
      {
         this.FExecuteCommand = param1;
      }
      
      public function set OpenThisPanel(param1:Function) : void
      {
         this.FOpenThisPanel = param1;
      }
   }
}

