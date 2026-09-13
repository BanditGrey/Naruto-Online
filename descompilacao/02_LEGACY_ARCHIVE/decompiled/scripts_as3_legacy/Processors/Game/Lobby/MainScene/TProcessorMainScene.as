package Processors.Game.Lobby.MainScene
{
   import Components.Controls.Button;
   import Externals.SExternalCore;
   import Foundation.Common.TCoordinate;
   import Foundation.Network.*;
   import Foundation.Queries.Coordinate.TQueryCoordinate;
   import Foundation.Resources.*;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.*;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.Characters.MoveRole.*;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.TDailyActivity;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.Quests.*;
   import Logics.Unlocks.TUnlock;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Common.Shortcuts.*;
   import Processors.Game.Lobby.Homeland.THomelandModel;
   import Processors.Game.Lobby.MainScene.Role.*;
   import Processors.Game.Lobby.Married.TMarriedModel;
   import Processors.Game.Windows.Information.TUIWindowDailyActivityNotify;
   import Resources.Constants.*;
   import Resources.Strings.STRING_MAINSCENE;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.*;
   
   public class TProcessorMainScene extends TProcessorLobbyPlate
   {
      
      protected static const BaseDailyActivityID:uint = 70200000;
      
      protected static const AutoEnterTime:uint = 30;
      
      protected static const MainRoleAndNpcYOffset:int = 20;
      
      protected static const FSendToServerPositionMinimumSpacing:int = 300 * 300;
      
      protected static const LOADTYPE_Secondary:uint = TLayerBackGround.LOADTYPE_Secondary;
      
      protected static const RESOURCE_Link_MC_CityNames:String = CONST_MainScene.RESOURCE_Link_MC_CityNames;
      
      public static const RESOURCE_Link_MC_CityName:String = CONST_MainScene.RESOURCE_Link_MC_CityName;
      
      protected var FCharacter:TCharacter;
      
      protected var FCureentSenceID:int;
      
      protected var FBackGround:TLayerBackGround;
      
      protected var FLayerNpc:TLayerNpc;
      
      protected var FRoleMountPoint:TUIComponent;
      
      protected var FLayerCanMove:TLayerCanMove;
      
      protected var FLayerLittleScript:TLayerLittleScript;
      
      protected var FLayerNpcDialog:TLayerNpcDialog;
      
      protected var FMainRole:TUIRoleCanMovePlayerRoleMainRole;
      
      protected var FPet:TUIRoleCanMovePet;
      
      protected var FEnterNotificationEffect:MovieClip;
      
      protected var FMC_CityName:MovieClip;
      
      protected var FMC_CityNames:Vector.<MovieClip>;
      
      protected var FPreSendMainRoleX:int;
      
      protected var FPreSendMainRoleY:int;
      
      protected var FPreSendMainRolePositionTick:int;
      
      protected var FSearchToNpc:Boolean;
      
      protected var FAlreadySendFreshNpc:Boolean;
      
      protected var FMainRoleTargetNpc:TUIRoleNpc;
      
      protected var FAlreadyInitNpcQuest:Boolean;
      
      protected var FPreMainRoleMapX:int;
      
      protected var FPreMainRoleMapY:int;
      
      protected var FMainPlayerCoordinate:TCoordinate;
      
      protected var FMountPointWindow:TUIComponent;
      
      protected var FButtonStatus:Vector.<Boolean>;
      
      protected var FUIWindowDailyActivityNotify:TUIWindowDailyActivityNotify;
      
      protected var FEnterDailyActivityTime:uint;
      
      protected var FActivityType:uint;
      
      protected var FRequestQuestGoahead:Function;
      
      protected var FOnEnterWorldMap:Function;
      
      protected var FSetupWorldMapTarget:Function;
      
      protected var FSendFreshGuideNpc:Function;
      
      protected var FOnAutoSearchWayEffect:Function;
      
      protected var FOnProcessorCheckPopTips:Function;
      
      protected var FOnEffectAcquireInventory:Function;
      
      protected var FOnQueryShortcutCoordinate:Function;
      
      protected var FHideHeroContorlPanle:Function;
      
      protected var FShowHeroContorlPanle:Function;
      
      protected var FAutoEnterActivity:Function;
      
      protected var Field:TextField;
      
      public function TProcessorMainScene(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FCharacter = SLogicsCore.Character;
         this.FMountPointWindow = param2.MountPointWindow;
         this.ConstructScene();
         this.FMainPlayerCoordinate = new TCoordinate();
         FUICore.stage.addEventListener(MouseEvent.CLICK,this.HandleMouseClick);
         FResourcesState = RESOURCESSTATE_UIRequest;
         this.FButtonStatus = SLogicsCore.ButtonStatus;
         SetUIModuleID(CONST_MODULES.MODULE_MainScene);
      }
      
      protected function Test() : void
      {
         var _loc1_:Button = null;
         _loc1_ = new Button();
         _loc1_.label = "报名";
         addChild(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.OnClick);
         _loc1_.visible = true;
         _loc1_.x = 400;
         _loc1_ = new Button();
         _loc1_.label = "报名状态";
         addChild(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.OnClickTwo);
         _loc1_.visible = true;
         _loc1_.x = 500;
      }
      
      protected function OnClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_OrganizationWar_CommandReq);
         _loc2_.Data.writeUnsignedInt(4);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnClickTwo(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_OrganizationWar_CommandReq);
         _loc2_.Data.writeUnsignedInt(5);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ConstructScene() : void
      {
         this.FBackGround = new TLayerBackGround(this,CONST_MODULES.MODULE_MainScene);
         this.FBackGround.OnLoadCompleted = this.ProcessorResourcesOnLoadCompleted;
         this.FBackGround.LoadType = LOADTYPE_Secondary;
         this.FBackGround.IsNeedSmallPic = true;
         this.FLayerNpc = new TLayerNpc(this.FBackGround);
         this.FLayerNpc.visible = true;
         this.FLayerCanMove = new TLayerCanMove(this.FBackGround,CONST_MODULES.MODULE_MainScene);
         this.FLayerCanMove.RoleClicked = this.PlayerClicked;
         TUIRoleNpc.FOnNpcClicked = this.OnNpcClicked;
         this.FLayerLittleScript = new TLayerLittleScript(this);
         this.FLayerLittleScript.visible = true;
         this.FLayerLittleScript.MouseEventObject = this.FBackGround;
         this.FLayerLittleScript.ChangeRolePositionByMouse = this.OnMoveByMouse;
         this.FLayerLittleScript.Load();
         this.FLayerNpcDialog = new TLayerNpcDialog(this.FMountPointWindow);
         this.FLayerNpcDialog.TaskOnClick = this.LayerNpcDialogQuestResquest;
         this.FLayerNpcDialog.AfterHideDialog = this.DeleteBarrier;
         this.FLayerNpcDialog.Load();
         this.FLayerNpcDialog.OnEffectAcquireInventory = this.ProcessorOnEffectAcquireInventory;
         this.FLayerNpcDialog.OnQueryShortcutCoordinate = this.ProcessorOnQueryShortcutCoordinate;
         this.FRoleMountPoint = new TUIComponent(this);
         this.FRoleMountPoint.visible = true;
         FResourcesState = RESOURCESSTATE_UIRequest;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_QUEST.RESOURCESID_QuestBadge);
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_MainScene.RESOURCESID_EnterNotification);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FEnterNotificationEffect = TUtilityReflection.CreateDisplayObjectInstance(CONST_MainScene.RESOURCE_ClassName_MC_Notification) as MovieClip;
         addChild(this.FEnterNotificationEffect);
         this.FEnterNotificationEffect.x = (CONST_COMMON.STAGE_Width - 297) / 2;
         this.FEnterNotificationEffect.y = 150;
         this.FEnterNotificationEffect.cacheAsBitmap = true;
         this.FEnterNotificationEffect.visible = false;
         this.FMC_CityName = this.FEnterNotificationEffect[RESOURCE_Link_MC_CityNames];
         this.FMC_CityNames = new Vector.<MovieClip>(2);
         this.FMC_CityNames[0] = this.FMC_CityName[RESOURCE_Link_MC_CityName + 0];
         this.FMC_CityNames[1] = this.FMC_CityName[RESOURCE_Link_MC_CityName + 1];
         this.FUIWindowDailyActivityNotify = new TUIWindowDailyActivityNotify(this.Parent.Parent);
         TUtilityUIWindow.SetupWindowActivityNotify(this.FUIWindowDailyActivityNotify);
         this.FUIWindowDailyActivityNotify.OnOK = this.OnEnterDailyActivity;
         this.FUIWindowDailyActivityNotify.OnCancel = this.OnCancelEnter;
         this.FUIWindowDailyActivityNotify.Visible = false;
         this.FUIWindowDailyActivityNotify.x = (FUICore.StageWidth - this.FUIWindowDailyActivityNotify.WindowWidth) / 2;
         this.FUIWindowDailyActivityNotify.y = (FUICore.StageHeight - this.FUIWindowDailyActivityNotify.WindowHeight) / 2;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         super.LogicsPerform();
         if(!this.Visible)
         {
            return;
         }
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_MAINCITY)
         {
            this.FBackGround.Update();
            this.FLayerCanMove.Update();
            this.FLayerNpc.Update();
            if(this.FUIWindowDailyActivityNotify.Visible)
            {
               _loc1_ = this.FEnterDailyActivityTime - STimingCore.GetServerTick();
               if(_loc1_ > 0)
               {
                  this.FUIWindowDailyActivityNotify.UpdataEnterTime(TUtilityString.Format(STRING_MAINSCENE.FormatString_AutoEnterTime,_loc1_));
               }
               else if(_loc1_ > -1)
               {
                  this.FUIWindowDailyActivityNotify.TimeOutAutoEnter();
               }
            }
         }
      }
      
      protected function GetFrameByTownID(param1:uint) : uint
      {
         switch(param1)
         {
            case 23100001:
               return 0;
            case 23200001:
               return 1;
            default:
               return 0;
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Town_NewRoleNtf,this.PacketPerform_SC_TOWN_NewRole);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Town_RoleMove,this.PacketPerform_SC_TOWN_RoleMove);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Town_RemoveRole,this.PacketPerform_RemoveTownRole);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Town_UpdateRole,this.PacketPerform_UpdateTownRole);
      }
      
      protected function SimulationTOWN_NewRole() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Vector.<int> = Vector.<int>([1,3,4]);
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_SC_LOBBY_Town_NewRoleNtf);
         _loc3_ = 50;
         _loc1_.Data.writeShort(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_.Data.writeUnsignedInt(0);
            _loc1_.Data.writeUnsignedInt(_loc2_ + 1);
            _loc1_.Data.writeShort(Math.random() > 0.5 ? 1 : 0);
            _loc1_.Data.writeUnsignedInt(_loc4_[_loc2_ % 3]);
            TUtilityString.FlushUTF(_loc1_.Data,"xingxingtie" + _loc2_);
            _loc1_.Data.writeUnsignedInt(uint(Math.random() * 36 + 40100001));
            _loc1_.Data.writeByte(1);
            _loc1_.Data.writeUnsignedInt(uint(Math.random() * 8) * 100 + 18100000);
            _loc1_.Data.writeShort(int(Math.random() * 2500));
            _loc1_.Data.writeShort(int(Math.random() * (650 - 390) + 390));
            _loc1_.Data.writeByte(2);
            _loc1_.Data.writeUnsignedInt(0);
            _loc2_++;
         }
         _loc1_.Data.position = 0;
         this.PacketPerform_SC_TOWN_NewRole(_loc1_);
      }
      
      protected function PacketPerform_SC_TOWN_NewRole(param1:TPacket) : void
      {
         this.FLayerCanMove.AddNewCanControlRole(param1);
      }
      
      protected function PacketPerform_SC_TOWN_RoleMove(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc2_ = param1.Data.readUnsignedInt();
         _loc3_ = param1.Data.readUnsignedInt();
         _loc4_ = param1.Data.readUnsignedShort();
         _loc5_ = param1.Data.readUnsignedShort();
         this.FLayerCanMove.PlayerMove(_loc2_,_loc3_,_loc4_,_loc5_);
      }
      
      protected function PacketPerform_RemoveTownRole(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data.readUnsignedInt();
         _loc3_ = param1.Data.readUnsignedInt();
         this.FLayerCanMove.PlayerRemove(_loc2_,_loc3_);
      }
      
      protected function PacketPerform_UpdateTownRole(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         _loc2_ = param1.Data.readUnsignedInt();
         _loc3_ = param1.Data.readUnsignedInt();
         _loc4_ = param1.Data.readByte();
         _loc5_ = param1.Data.readUnsignedInt();
         this.FLayerCanMove.PlayerUpdate(_loc2_,_loc3_,_loc4_,_loc5_);
      }
      
      protected function ProcessorEnterTown(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         if(param1 != null)
         {
            this.FLayerCanMove.ClearAllRole();
            this.FBackGround.SwitchScene(SLogicsCore.Character.TownID);
            this.FLayerNpc.UpdataCurrentCityNpc();
            this.FMainRole.ChangeDirection(CONST_MainScene.DIRECTION_RIGHT);
            this.FMainRole.Pet.ChangeDirection(CONST_MainScene.DIRECTION_RIGHT);
            this.FMainRole.Reload();
            this.FLayerCanMove.InitNewRole(this.FMainRole);
         }
         if(SLogicsCore.Character.RoleSencePosition < 0)
         {
            SExternalCore.GameStatistical(CONST_ACCOUNT.STATISTICALSETP_EnterMainScene);
            SExternalCore.LoginIn();
            SExternalCore.BrazilLog(6);
         }
         SLogicsCore.Character.RoleSencePosition = CONST_COMMON.SCENEPOSITION_MAINCITY;
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
      
      protected function ProcessorResourcesOnLoadCompleted(param1:Object) : void
      {
      }
      
      protected function UpdateRolePositionSendToServer() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         _loc1_ = this.FMainRole.MapX - this.FPreMainRoleMapX;
         _loc2_ = this.FMainRole.MapY - this.FPreMainRoleMapY;
         _loc3_ = _loc1_ * _loc1_ + _loc2_ * _loc2_;
         if(_loc3_ > FSendToServerPositionMinimumSpacing)
         {
            this.FPreMainRoleMapX = this.FMainRole.MapX;
            this.FPreMainRoleMapY = this.FMainRole.MapY;
            this.PacketPerform_CS_LOBBY_Town_Move(this.FMainRole.MapX,this.FMainRole.MapY);
         }
      }
      
      protected function OnMainRoleArriveNpc() : void
      {
         var _loc1_:int = 0;
         if(TUIRoleNpc.IfCityDoor(this.FMainRoleTargetNpc))
         {
            if(SLogicsCore.AutoSearching)
            {
               if(SLogicsCore.AutoSearchQuest.TaskState == CONST_QUEST.STATE_TASKING && SLogicsCore.AutoSearchQuest.EventType == CONST_QUEST.QuestEventTypeKillMonster)
               {
                  this.FSetupWorldMapTarget(2,SLogicsCore.AutoSearchQuest.CityID,SLogicsCore.AutoSearchQuest.CampId);
                  SLogicsCore.AutoSearching = false;
                  this.IfPlayAutoSearchWayEffect(false);
               }
               else
               {
                  _loc1_ = this.FLayerNpc.SearchRelationTownIDByQuest(SLogicsCore.AutoSearchQuest);
                  this.FSetupWorldMapTarget(1,_loc1_,0);
               }
            }
            this.FOnEnterWorldMap(this);
         }
         else if(this.FMainRoleTargetNpc.RoleData.UserType == CONST_NPC.NPC_FUNCTION_YUELAO)
         {
            THomelandModel.ProcessorWindowsSwitch(TMarriedModel.married);
         }
         else
         {
            BarrierActuate(this.FLayerNpcDialog);
            this.FLayerNpcDialog.UINpc = this.FMainRoleTargetNpc;
            this.FLayerNpcDialog.ShowDialog();
            SLogicsCore.AutoSearching = false;
            this.IfPlayAutoSearchWayEffect(false);
         }
      }
      
      protected function IfPlayAutoSearchWayEffect(param1:Boolean) : void
      {
         if(this.FOnAutoSearchWayEffect != null)
         {
            this.FOnAutoSearchWayEffect(this,param1);
         }
      }
      
      protected function HideAvater() : void
      {
         if(this.FHideHeroContorlPanle != null)
         {
            this.FHideHeroContorlPanle(this);
         }
      }
      
      protected function OnEnterDailyActivity(param1:Object, param2:Boolean = false) : void
      {
         if(this.FAutoEnterActivity != null)
         {
            this.FAutoEnterActivity(this,this.FActivityType,param2);
         }
         this.FEnterDailyActivityTime = 0;
         this.FActivityType = 0;
      }
      
      protected function OnCancelEnter(param1:Object) : void
      {
         this.FEnterDailyActivityTime = 0;
         this.FActivityType = 0;
      }
      
      protected function OnNpcClicked(param1:Object) : void
      {
         var _loc2_:TUIRoleNpc = null;
         _loc2_ = param1 as TUIRoleNpc;
         this.FMainRole.SetupTargetPosition(_loc2_.MapX,_loc2_.MapY + MainRoleAndNpcYOffset,CONST_MainScene.RoleMoveSpeed);
         this.FMainRoleTargetNpc = _loc2_;
         this.HideAvater();
      }
      
      protected function OnMainRoleArriveTarget() : void
      {
         this.UpdateRolePositionSendToServer();
         if(this.FMainRoleTargetNpc != null)
         {
            this.OnMainRoleArriveNpc();
         }
      }
      
      protected function OnMoveByMouse() : void
      {
         this.FMainRoleTargetNpc = null;
         this.HideAvater();
      }
      
      protected function LayerNpcDialogQuestResquest(param1:TQuest, param2:int) : void
      {
         this.FRequestQuestGoahead(param1,param2);
      }
      
      protected function DeleteBarrier(param1:Object) : void
      {
         BarrierDeactuate(param1);
      }
      
      private function HandleMouseClick(param1:MouseEvent) : void
      {
         if(SLogicsCore.AutoSearching)
         {
            SLogicsCore.AutoSearching = false;
            this.IfPlayAutoSearchWayEffect(false);
            this.FMainRoleTargetNpc = null;
            this.FMainRole.SetupTargetPosition(this.FMainRole.MapX,this.FMainRole.MapY,CONST_MainScene.RoleMoveSpeed);
         }
      }
      
      protected function ProcessorOnEffectAcquireInventory(param1:Object, param2:Object, param3:TEffectCoordinateParameters) : void
      {
         if(this.FOnEffectAcquireInventory != null)
         {
            this.FOnEffectAcquireInventory(param1,param2,param3);
         }
      }
      
      protected function ProcessorOnQueryShortcutCoordinate(param1:Object, param2:uint, param3:TQueryCoordinate) : void
      {
         if(this.FOnQueryShortcutCoordinate != null)
         {
            this.FOnQueryShortcutCoordinate(param1,CONST_SHORTCUTS.POSITION_Function,param2,param3);
         }
      }
      
      protected function PlayEnterCityEffect(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = this.GetFrameByTownID(this.FCharacter.TownID);
         this.FMC_CityNames[0].visible = false;
         this.FMC_CityNames[1].visible = false;
         if(param1)
         {
            _loc3_ = this.FMC_CityNames[_loc2_];
            _loc3_.gotoAndPlay(1);
            _loc3_.visible = true;
            this.FEnterNotificationEffect.visible = true;
            this.FEnterNotificationEffect.gotoAndPlay(1);
         }
      }
      
      protected function VerificationLocaltionOperatingByPosition(param1:uint, param2:uint) : TUnlock
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TUnlock = null;
         _loc4_ = int(SLogicsCore.Unlocks.Count);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = SLogicsCore.Unlocks.GetUnlockByIndex(_loc3_);
            if(param1 == _loc5_.Position && param2 == _loc5_.Localtion)
            {
               return _loc5_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function PlayerClicked(param1:TUIRoleCanMovePlayerRole) : void
      {
         if(this.FShowHeroContorlPanle != null)
         {
            this.FShowHeroContorlPanle(this,param1);
         }
      }
      
      public function set RequestQuestGoahead(param1:Function) : void
      {
         this.FRequestQuestGoahead = param1;
      }
      
      public function set OnEnterWorldMap(param1:Function) : void
      {
         this.FOnEnterWorldMap = param1;
      }
      
      public function set SetupWorldMapTarget(param1:Function) : void
      {
         this.FSetupWorldMapTarget = param1;
      }
      
      public function set SendFreshGuideNpc(param1:Function) : void
      {
         this.FSendFreshGuideNpc = param1;
      }
      
      public function set OpenNpcUserTypeWindow(param1:Function) : void
      {
         this.FLayerNpcDialog.OpenNpcUserTypeWindow = param1;
      }
      
      public function get LayerNpcDialog() : TLayerNpcDialog
      {
         return this.FLayerNpcDialog;
      }
      
      public function get FreshGuideNpc() : TUIRoleNpc
      {
         return this.FLayerNpc.FreshGuideNpc;
      }
      
      public function get MainPlayerCoordinate() : TCoordinate
      {
         this.FMainPlayerCoordinate.X = this.FMainRole.MapX - SLogicsCore.ScreenMapX;
         this.FMainPlayerCoordinate.Y = this.FMainRole.MapY;
         return this.FMainPlayerCoordinate;
      }
      
      public function set OnAutoSearchWayEffect(param1:Function) : void
      {
         this.FOnAutoSearchWayEffect = param1;
      }
      
      override public function set OnEffectText(param1:Function) : void
      {
         super.OnEffectText = param1;
         this.FLayerNpcDialog.OnEffectText = param1;
      }
      
      public function get OnProcessorCheckPopTips() : Function
      {
         return this.FOnProcessorCheckPopTips;
      }
      
      public function set OnProcessorCheckPopTips(param1:Function) : void
      {
         this.FOnProcessorCheckPopTips = param1;
      }
      
      public function get OnEffectAcquireInventory() : Function
      {
         return this.FOnEffectAcquireInventory;
      }
      
      public function set OnEffectAcquireInventory(param1:Function) : void
      {
         this.FOnEffectAcquireInventory = param1;
      }
      
      public function get OnQueryShortcutCoordinate() : Function
      {
         return this.FOnQueryShortcutCoordinate;
      }
      
      public function set OnQueryShortcutCoordinate(param1:Function) : void
      {
         this.FOnQueryShortcutCoordinate = param1;
      }
      
      public function set HideHeroContorlPanle(param1:Function) : void
      {
         this.FHideHeroContorlPanle = param1;
      }
      
      public function set ShowHeroContorlPanle(param1:Function) : void
      {
         this.FShowHeroContorlPanle = param1;
      }
      
      public function set AutoEnterActivity(param1:Function) : void
      {
         this.FAutoEnterActivity = param1;
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
            _loc2_.ShortcutModeAvatar = TLobbyShortcutMode.SHORTCUTMODE_Show;
         }
         if(param1 is TLobbyShortcutActivityModes)
         {
            _loc3_ = param1 as TLobbyShortcutActivityModes;
            _loc3_.SetAllShortcutShow();
         }
         if(param1 is TLobbyShortcutActiveSpecialModes)
         {
            _loc4_ = param1 as TLobbyShortcutActiveSpecialModes;
            _loc4_.ShortcutModeCDK = TLobbyShortcutMode.SHORTCUTMODE_Show;
         }
         if(param1 is TLobbyShortcutFunctionModes)
         {
            _loc5_ = param1 as TLobbyShortcutFunctionModes;
            _loc5_.ShortcutModeHero = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeStar = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeTacticalDeployment = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeBackpack = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeTreasure = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeSummonPet = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeStrengthen = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeMail = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeTongLing = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeOrganiZation = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeInheritPractice = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeReturn = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutMapModes)
         {
            _loc6_ = param1 as TLobbyShortcutMapModes;
            _loc6_.ShortcutModeMap = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc6_.ShortcutModeReturnHome = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutQuestGuideModes)
         {
            _loc7_ = param1 as TLobbyShortcutQuestGuideModes;
            _loc7_.ShortcutMode = TLobbyShortcutMode.SHORTCUTMODE_Show;
         }
         if(param1 is TLobbyShortcutConstantlyModes)
         {
            _loc8_ = param1 as TLobbyShortcutConstantlyModes;
            _loc8_.ShortcutModeStrengthen = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc8_.ShortcutModeArena = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc8_.ShortcutModeBigDipper = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc8_.ShortcutModeMentorship = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc8_.ShortcutModeTongLing = TLobbyShortcutMode.SHORTCUTMODE_Show;
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         this.ProcessorEnterTown(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FLayerNpcDialog.Load();
            this.FLayerLittleScript.Load();
            return;
         }
         if(SLogicsCore.AutoSearching)
         {
            this.IfPlayAutoSearchWayEffect(false);
            this.AutoSearchWay(SLogicsCore.AutoSearchQuest);
         }
         MusicPlayNext(CONST_SIGNAL.SIGNALDESTINATION_SOUND,CONST_MUSIC.PLAY_SCENE_MainCity,SLogicsCore.Character.TownID);
         TutorialNextStep(400);
         if(this.FOnProcessorCheckPopTips != null)
         {
            this.FOnProcessorCheckPopTips(this);
         }
         this.PlayEnterCityEffect(true);
         if(this.FActivityType != 0 && SLogicsCore.TheWorldTreeLogicData.CurPenetrateState != 1)
         {
            this.FEnterDailyActivityTime = STimingCore.GetServerTick() + AutoEnterTime;
            this.FUIWindowDailyActivityNotify.Visible = true;
         }
      }
      
      override public function Unmount() : void
      {
      }
      
      public function CreateMainRole() : void
      {
         var _loc1_:THero = null;
         var _loc3_:TBaseHero = null;
         var _loc4_:TRoleModel = null;
         var _loc2_:TRoleCanControl = new TRoleCanControl(0,0);
         _loc1_ = SLogicsCore.Character.Heros.GetHeroByIndex(0);
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc1_.Identifier) as TBaseHero;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc1_.Identifier) as TRoleModel;
         _loc2_.RoleName = _loc1_.Name;
         _loc2_.RoleTemplateID = _loc1_.Identifier;
         _loc2_.MilitaryRank = SLogicsCore.Character.MilitaryRank;
         this.FMainRole = new TUIRoleCanMovePlayerRoleMainRole(this.FLayerCanMove);
         this.FMainRole.ModuleId = CONST_MODULES.MODULE_Common;
         this.FMainRole.ChangeTextureID(_loc4_.Model);
         this.FMainRole.TransformID = SLogicsCore.Character.Wing.TransformID;
         this.FMainRole.OnArriveTarget = this.OnMainRoleArriveTarget;
         this.FMainRole.RoleData = _loc2_;
         this.FMainRole.RoleData.TransformID = SLogicsCore.Character.Wing.TransformID;
         this.FMainRole.RoleData.HideWing = SLogicsCore.Character.Wing.HideWing;
         this.FMainRole.RoleData.BadgeList = SLogicsCore.Character.BadgeList;
         this.FMainRole.JadeID = SLogicsCore.Character.SpecialJade.JadeID;
         this.FMainRole.Init();
         this.ChangeMainHeroQuality();
         this.FPet = new TUIRoleCanMovePet(this.FLayerCanMove);
         this.FPet.ModuleId = CONST_MODULES.MODULE_Common;
         this.FPet.TextrueID = SLogicsCore.Character.Pet.PetModelID;
         this.FPet.FollowRole = this.FMainRole;
         this.FPet.RelexBoo = SLogicsCore.Character.Pet.RelexBoo;
         this.FMainRole.Pet = this.FPet;
         this.FPet.Init();
         this.FLayerCanMove.InitNewRole(this.FMainRole);
         this.FLayerCanMove.MainRole = this.FMainRole;
         this.FBackGround.ScreenRole = this.FMainRole;
         this.FLayerLittleScript.MainRole = this.FMainRole;
      }
      
      public function AddNewQuest(param1:TQuest) : void
      {
         if(this.FAlreadyInitNpcQuest)
         {
            this.FLayerNpc.AddNewQuest(param1);
            this.FLayerNpcDialog.AddNewQuest(param1);
         }
      }
      
      public function UpdateQuesteState(param1:TQuest) : void
      {
         if(this.FAlreadyInitNpcQuest)
         {
            this.FLayerNpc.UpdateQuestState(param1);
            this.FLayerNpcDialog.UpdateQuestState(param1);
         }
      }
      
      public function AutoSearchWay(param1:Object) : void
      {
         SLogicsCore.AutoSearchQuest = param1 as TQuest;
         SLogicsCore.AutoSearching = true;
         this.IfPlayAutoSearchWayEffect(true);
         this.FLayerNpc.AutoSearchWay(SLogicsCore.AutoSearchQuest);
      }
      
      public function UpdateMilitaryRank() : void
      {
         this.FMainRole.RoleData.MilitaryRank = SLogicsCore.Character.MilitaryRank;
         this.FMainRole.UpdateMilitaryRank();
      }
      
      public function ChangeMainHeroQuality() : void
      {
         this.FMainRole.RoleData.Quality = SLogicsCore.Character.MainHero.Quality;
         this.FMainRole.UpdateMainRoleNameColor();
      }
      
      public function CloseNpcDialog() : void
      {
         this.FLayerNpcDialog.HideDialog();
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
      
      public function UpdateNpc() : void
      {
         this.FLayerNpc.UpdataCurrentCityNpc();
      }
      
      public function InitNpcQuest() : void
      {
         this.FLayerNpc.InitNpcQuest();
         this.FAlreadyInitNpcQuest = true;
         this.FLayerNpc.UpdataCurrentCityNpc();
      }
      
      public function InitAllNpc() : void
      {
         this.FLayerNpc.InitNPC();
         this.FSendFreshGuideNpc(this.FLayerNpc.FreshGuideNpc);
      }
      
      public function ShowAndHideMainSceneRoles(param1:Boolean) : void
      {
         this.FLayerCanMove.SwitchMode(param1);
      }
      
      public function GotoCityDoor() : void
      {
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_MAINCITY)
         {
            this.OnNpcClicked(this.FLayerNpc.CityDoor);
         }
      }
      
      public function ChangeShape(param1:int) : void
      {
         var _loc2_:Boolean = false;
         _loc2_ = param1 != 0;
         if(this.FMainRole == null)
         {
            return;
         }
         this.FMainRole.ChangeHeroShape(_loc2_,param1);
      }
      
      public function UpdateTitle(param1:uint) : void
      {
         if(this.FMainRole)
         {
            this.FMainRole.RoleData.TitleID = param1;
            this.FMainRole.Init();
         }
      }
      
      public function UpdateLittlePet(param1:uint) : void
      {
         this.FMainRole.RoleData.LittlePetID = param1;
         this.FMainRole.Init();
      }
      
      public function UpdateWing(param1:int, param2:int = 2) : void
      {
         if(Boolean(this.FMainRole) && Boolean(this.FMainRole.RoleData))
         {
            this.FMainRole.RoleData.TransformID = param1;
            this.FMainRole.RoleData.HideWing = param2;
            this.FMainRole.Init();
         }
      }
      
      public function UpdateBadge(param1:Vector.<int>) : void
      {
         if(this.FMainRole)
         {
            this.FMainRole.RoleData.BadgeList = param1;
            this.FMainRole.Init();
         }
      }
      
      public function UpdateJade(param1:int) : void
      {
         if(this.FMainRole)
         {
            this.FMainRole.JadeID = param1;
            this.FMainRole.Init();
         }
      }
      
      public function SetActivityStatus(param1:uint, param2:uint) : void
      {
         var _loc3_:TUnlock = null;
         var _loc4_:TDailyActivity = null;
         var _loc5_:uint = 0;
         _loc3_ = this.VerificationLocaltionOperatingByPosition(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_DailyActivity);
         if(_loc3_ != null && _loc3_.State != TUnlock.UNLOCKSTATE_Unlocked)
         {
            return;
         }
         if(this.FActivityType == param1 && param2 == CONST_ORGANIZATION.STATUS_ORGACTIVITY_End)
         {
            this.FEnterDailyActivityTime = 0;
            this.FActivityType = 0;
         }
         if(param2 != CONST_ORGANIZATION.STATUS_ORGACTIVITY_Battle)
         {
            return;
         }
         if(param1 == CONST_ORGANIZATION.TYPE_ORGACTIVITY_AnimalSeal)
         {
            return;
         }
         if(param1 == CONST_ORGANIZATION.TYPE_ORGACTIVITY_PETBATTLE)
         {
            _loc5_ = BaseDailyActivityID + SLogicsCore.Character.Country;
            param1 = CONST_ORGANIZATION.TYPE_ORGACTIVITY_YUZHIBO + SLogicsCore.Character.Country - 1;
         }
         else
         {
            if(param1 == CONST_ORGANIZATION.TYPE_ORGACTIVITY_MUYEGUARD)
            {
               return;
            }
            if(param1 == CONST_ORGANIZATION.TYPE_ORGACTIVITY_MUYEBATTLE)
            {
               return;
            }
            if(param1 == CONST_ORGANIZATION.TYPE_ORGACTIVITY_TRAITORATTACK)
            {
               _loc5_ = BaseDailyActivityID + 6;
            }
            else if(param1 == CONST_ORGANIZATION.TYPE_ORGACTIVITY_YUZHIBO)
            {
               _loc5_ = BaseDailyActivityID + 1;
            }
            else if(param1 == CONST_ORGANIZATION.TYPE_ORGACTIVITY_RIXIANG)
            {
               _loc5_ = BaseDailyActivityID + 2;
            }
            else if(param1 == CONST_ORGANIZATION.TYPE_ORGACTIVITY_QIANSHOU)
            {
               _loc5_ = BaseDailyActivityID + 3;
            }
            else
            {
               _loc5_ = BaseDailyActivityID + SLogicsCore.Character.Country;
               param1 = CONST_ORGANIZATION.TYPE_ORGACTIVITY_YUZHIBO + SLogicsCore.Character.Country - 1;
            }
         }
         if(param1 >= CONST_ORGANIZATION.TYPE_ORGACTIVITY_YUZHIBO && param1 <= CONST_ORGANIZATION.TYPE_ORGACTIVITY_QIANSHOU)
         {
            if(param1 - CONST_ORGANIZATION.TYPE_ORGACTIVITY_YUZHIBO + 1 != SLogicsCore.Character.Country)
            {
               return;
            }
         }
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_DailyActivity,_loc5_) as TDailyActivity;
         if(_loc4_ == null)
         {
            return;
         }
         this.FEnterDailyActivityTime = STimingCore.GetServerTick() + AutoEnterTime;
         this.FUIWindowDailyActivityNotify.Text = TUtilityString.Format(STRING_MAINSCENE.FormatString_ActivityInfo,_loc4_.ActivityName);
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_MAINCITY && SLogicsCore.TheWorldTreeLogicData.CurPenetrateState != 1)
         {
            this.FUIWindowDailyActivityNotify.Visible = true;
         }
         this.FActivityType = param1;
      }
   }
}

