package Processors.Game.Lobby.FightPet
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.Characters.MoveRole.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.FightPet.*;
   import Logics.TimeCoolDown.*;
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
   import flash.utils.*;
   
   public class TProcessorFightPet extends TProcessorLobbyPlate
   {
      
      protected static const FSendToServerPositionMinimumSpacing:int = 300 * 300;
      
      protected var FBackGround:TLayerBackGround;
      
      protected var FLittleScript:TLayerLittleScript;
      
      protected var FCanMove:TLayerCanMove;
      
      protected var FLayerOver:TLayerOver;
      
      protected var FBackLayerMask:Sprite;
      
      protected var FMainRole:TUIRoleCanMovePlayerRoleMainRole;
      
      protected var FMonster:TUIRoleCanMoveMonster;
      
      protected var FPet:TUIRoleCanMovePet;
      
      protected var FCheckTouchRoleVect:Vector.<TUIRoleCanMovePlayerRole>;
      
      protected var FTime:uint;
      
      protected var FTimeCD:uint;
      
      protected var FTotalHP:uint;
      
      protected var FMonsterLv:uint;
      
      protected var FUIWindowInformation:TUIWindowConfirmation;
      
      protected var FPreTargetMapX:int;
      
      protected var FPreTargetMapY:int;
      
      protected var FIsInCD:Boolean;
      
      protected var FFightPetData:TFightPet;
      
      protected var FTimeCoolDown:TTimeCoolDown;
      
      protected var FBackTownTimeCoolDown:TTimeCoolDown;
      
      protected var FIsBack:Boolean;
      
      protected var FIsInBattle:Boolean;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FConfigValue:TBins;
      
      protected var FMapId:uint;
      
      protected var FIsStarRun:Boolean;
      
      protected var FUIRoleCanMovePlayerRoleTemp:TUIRoleCanMovePlayerRole;
      
      protected var FIsHitMonst:Boolean;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FOnEnterCityScene:Function;
      
      protected var FSetSceneBitmapData:Function;
      
      protected var FOnEndAutoBattle:Function;
      
      protected var FExecuteCommand:Function;
      
      protected var FOpenThisPanel:Function;
      
      protected var FIsHooked:Boolean = false;
      
      protected var FIsAutoGoldResurgence:Boolean = false;
      
      protected var FIsAutoSkipResurgence:Boolean = false;
      
      public function TProcessorFightPet(param1:TUIComponent, param2:TLobbyParameters)
      {
         var _loc3_:BitmapData = null;
         var _loc4_:Bitmap = null;
         super(param1,param2);
         this.FBackGround = new TLayerBackGround(this,CONST_MODULES.MODULE_FightPet);
         this.FBackGround.OnLoadCompleted = this.ProcessorResourcesOnLoadCompleted;
         this.FBackGround.IsNeedSmallPic = false;
         this.FBackGround.visible = true;
         this.FCanMove = new TLayerCanMove(this.FBackGround,CONST_MODULES.MODULE_FightPet);
         this.FCanMove.visible = false;
         this.FLittleScript = new TLayerLittleScript(this);
         this.FLittleScript.visible = true;
         this.FLittleScript.MouseEventObject = this.FBackGround;
         this.FLittleScript.ChangeRolePositionByMouse = this.ChangeRolePositionByMouse;
         this.FFightPetData = new TFightPet();
         this.FBackLayerMask = new Sprite();
         addChild(this.FBackLayerMask);
         this.FBackLayerMask.graphics.beginFill(0,0.2);
         this.FBackLayerMask.graphics.drawRect(0,0,this.FBackGround.Width,this.FBackGround.Height);
         this.FBackLayerMask.graphics.endFill();
         this.FBackLayerMask.visible = false;
         this.FLayerOver = new TLayerOver(this);
         this.FLayerOver.OnMoraleUp = this.OnMoraleUp;
         this.FLayerOver.OnResurrection = this.OnResurrection;
         this.FLayerOver.FightPetData = this.FFightPetData;
         this.FLayerOver.OnMoraleUpOver = this.UIComponentsHintOnOver;
         this.FLayerOver.OnMoraleUpOut = this.UIComponentsHintOnOut;
         this.FLayerOver.OnHelpOver = this.UIHelpTipsHintOnOver;
         this.FLayerOver.OnHelpOut = this.UIHelpTipsHintOnOut;
         this.FLayerOver.SetResurrectionStatue = this.SetResurrectionStatue;
         this.FLayerOver.StarRun = this.OnStarRun;
         this.FLayerOver.DeathCountdown = this.DeathCountdown;
         this.FLayerOver.Goldlack = this.GoldlackF;
         this.FTimeCoolDown = new TTimeCoolDown(CONST_COMMON.TIME_COOLDOWN_FightPet_EnterCD);
         SLogicsCore.Character.TimeCoolDowns.Add(this.FTimeCoolDown);
         this.FBackTownTimeCoolDown = new TTimeCoolDown(CONST_COMMON.TIME_COOLDOWN_FightPet_BACKTOWN);
         SLogicsCore.Character.TimeCoolDowns.Add(this.FBackTownTimeCoolDown);
         this.FCheckTouchRoleVect = new Vector.<TUIRoleCanMovePlayerRole>();
         SetUIModuleID(CONST_MODULES.MODULE_FightPet);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_FIGHTPET.RESOURCESID_Swf_FirstRecharge);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         super.ResourcesPerform_UIDispatch();
         this.FOverlayerHint = new TOverlayerHint(this);
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverlayerHint.Visible = false;
         this.FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_FightPet)
         {
            this.FBackGround.Update();
            this.FCanMove.Update();
            this.logicsMonster();
            this.logicsHitMonster();
            this.logicsDieCD();
            this.logicsBackTownCD();
            if(STimingCore.TickCount - this.FTime >= 5000 && this.FMonster != null)
            {
               this.MonsterMove();
            }
            this.DeathCountdown();
            this.CheckRoleTouchMonster();
         }
      }
      
      protected function CheckRoleTouchMonster() : void
      {
         var _loc1_:* = 0;
         var _loc2_:TUIRoleCanMovePlayerRole = null;
         if(this.FMonster == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FCheckTouchRoleVect.length)
         {
            _loc2_ = this.FCheckTouchRoleVect[_loc1_];
            if(this.FMonster.hitTestObject(_loc2_))
            {
               this.FCanMove.InitNewRole(_loc2_);
               this.FCheckTouchRoleVect.splice(_loc1_,1);
               _loc1_--;
               break;
            }
            _loc1_++;
         }
      }
      
      private function logicsBackTownCD() : void
      {
         if(this.FFightPetData.GameOver && this.FIsBack)
         {
            if(this.FBackTownTimeCoolDown.TimingTime >= 0)
            {
               this.FLayerOver.BackTownCDUpdate(this.FBackTownTimeCoolDown.TimingTime);
            }
            if(this.FBackTownTimeCoolDown.TimingTime == 0)
            {
               this.backTownFun();
            }
         }
      }
      
      private function logicsDieCD() : void
      {
         if(this.FLayerOver.IsInit && this.FIsInCD)
         {
            if(this.FTimeCoolDown.TimingTime >= 0)
            {
               if(!this.FFightPetData.IsDie)
               {
                  this.FLayerOver.InfoCDUpdate(this.FTimeCoolDown.TimingTime);
                  this.FBackGround.filters = [];
               }
               if(this.FTimeCoolDown.TimingTime == 0)
               {
                  this.FIsInCD = false;
                  this.FFightPetData.CDTime = 0;
                  this.DeathCountdown();
               }
            }
         }
      }
      
      private function logicsHitMonster() : void
      {
         if(this.FMonster != null && this.FMainRole != null && !this.FIsInCD && this.FIsBack && !this.FIsInBattle)
         {
            if(this.FMonster.Direction == -1)
            {
               if(this.FMainRole.MapX >= this.FMonster.MapX && this.FMainRole.MapX <= this.FMonster.MapX + 200 && this.FMainRole.MapY >= this.FMonster.MapY - this.FMainRole.height && this.FMainRole.MapY <= this.FMonster.MapY + this.FMonster.width)
               {
                  this.FIsHitMonst = true;
                  this.enterFightReq();
               }
            }
            else if(this.FMonster.Direction == 1)
            {
               if(this.FMainRole.MapX >= this.FMonster.MapX - 200 && this.FMainRole.MapX <= this.FMonster.MapX && this.FMainRole.MapY >= this.FMonster.MapY - this.FMainRole.height && this.FMainRole.MapY <= this.FMonster.MapY + this.FMonster.width)
               {
                  this.FIsHitMonst = true;
                  this.enterFightReq();
               }
            }
         }
      }
      
      private function logicsMonster() : void
      {
         if(this.FMonster != null)
         {
            if(this.FMonster.CheckIfInScreen(this.FMonster))
            {
               this.FMonster.UpdateData();
               this.FMonster.UpdateView();
               this.FMonster.visible = true;
            }
            else
            {
               this.FMonster.visible = false;
            }
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FightPet_FightRet,this.FightingMonsterRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FightPet_InspireRet,this.InspireRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FightPet_IsDie,this.OnIsDie);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FightPet_MonsterInfo,this.MonsterInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FightPet_PlayerCount,this.PlayerCount);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FightPet_RankUpdate,this.RankRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FightPet_ResurrectionRet,this.ResurrectionRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FightPet_GameOver,this.GameOver);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FightPet_RebornNotify,this.RebornNotify);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Town_NewRoleNtf,this.AddNewRole);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Town_RoleMove,this.RoleMove);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Town_RemoveRole,this.RemoveTownRole);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Town_UpdateRole,this.UpdateRole);
      }
      
      private function RebornNotify(param1:TPacket) : void
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
      
      private function GameOver(param1:TPacket) : void
      {
         this.FFightPetData.GameOver = true;
         if(this.FMonster != null)
         {
            this.FMonster.TextFieldName("","",0);
            this.FMonster.Release();
            this.FMonster = null;
         }
         this.FIsHooked = false;
         this.FIsAutoGoldResurgence = false;
         this.FIsAutoSkipResurgence = false;
         if(this.FOnEndAutoBattle != null)
         {
            this.FOnEndAutoBattle(this);
         }
         this.FBackTownTimeCoolDown.TimingTime = 5;
      }
      
      private function ResurrectionRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = param1.Data.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FFightPetData.IsDie = false;
         this.FIsInCD = false;
         this.FLayerOver.Resurrection();
         this.FBackGround.filters = [];
         ++this.FFightPetData.ReviveTimes;
      }
      
      private function RankRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TFightPetRank = null;
         this.FFightPetData.MainPlayerDamage.High = param1.Data.readUnsignedInt();
         this.FFightPetData.MainPlayerDamage.Low = param1.Data.readUnsignedInt();
         this.FFightPetData.ClearRankList();
         _loc2_ = param1.Data.readUnsignedShort();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new TFightPetRank();
            _loc4_.Name = TUtilityString.FetchUTF(param1.Data);
            _loc4_.Damage.High = param1.Data.readUnsignedInt();
            _loc4_.Damage.Low = param1.Data.readUnsignedInt();
            this.FFightPetData.TopTenRank[_loc3_] = _loc4_;
            _loc3_++;
         }
         if(this.FLayerOver.IsInit)
         {
            this.FLayerOver.RankUpdate(this.FFightPetData);
         }
      }
      
      private function PlayerCount(param1:TPacket) : void
      {
         this.FFightPetData.AllplayerCount = param1.Data.readUnsignedInt();
         if(this.FLayerOver.IsInit)
         {
            this.FLayerOver.updatePlayerNum(this.FFightPetData.AllplayerCount);
         }
      }
      
      private function MonsterInfo(param1:TPacket) : void
      {
         var _loc2_:TEnemy = null;
         this.FFightPetData.MonsterID = param1.Data.readUnsignedInt();
         this.FFightPetData.MonsterHP = param1.Data.readFloat();
         this.FFightPetData.MonsterName = TUtilityString.FetchUTF(param1.Data);
         if(this.FMonster == null)
         {
            this.CreateMonster(this.FFightPetData);
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Enemy,this.FFightPetData.MonsterID) as TEnemy;
            this.FFightPetData.MonsterTotaleHP = _loc2_.Hp;
            this.FFightPetData.MonsterLV = _loc2_.Level;
         }
         if(this.FLayerOver.IsInit)
         {
            this.FLayerOver.updateMonster(this.FFightPetData);
         }
      }
      
      private function OnIsDie(param1:TPacket) : void
      {
         var _loc2_:TConfigValue = null;
         _loc2_ = this.FConfigValue.GetDatebaseByIdentifier(CONST_CONFIGVALUE.FIGHTPET_DIECD) as TConfigValue;
         this.FTimeCoolDown.TimingTime = _loc2_.Value as uint;
         this.FFightPetData.IsDie = true;
         this.FIsInCD = true;
         this.FLayerOver.DieCDUpdate(this.FTimeCoolDown.TimingTime);
      }
      
      private function InspireRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = param1.Data.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FFightPetData.InspireCount = param1.Data.readByte();
         this.FLayerOver.updateInspire();
         this.InspireEffectGenerateText();
      }
      
      private function InspireEffectGenerateText() : void
      {
         var _loc1_:TConfigValue = null;
         var _loc2_:String = null;
         var _loc3_:Vector.<Object> = null;
         var _loc4_:Vector.<Object> = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc2_ = "";
         _loc5_ = 0;
         _loc1_ = this.FConfigValue.GetDatebaseByIdentifier(CONST_CONFIGVALUE.FIGHTPET_MORALEUP_PROPERTY) as TConfigValue;
         _loc3_ = _loc1_.Value as Vector.<Object>;
         _loc1_ = this.FConfigValue.GetDatebaseByIdentifier(CONST_CONFIGVALUE.FIGHTPET_MORALEUP_POINT) as TConfigValue;
         _loc4_ = _loc1_.Value as Vector.<Object>;
         _loc7_ = _loc3_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            if(this.FFightPetData.InspireCount == 0)
            {
               _loc5_ = 0;
            }
            else
            {
               _loc5_ = uint(_loc4_[this.FFightPetData.InspireCount - 1][_loc6_]);
            }
            _loc2_ += _loc3_[_loc6_] + "+" + _loc5_.toString() + "%\n";
            _loc6_++;
         }
         EffectGenerateText(STRING_FIGHTPET.STRING_Inspire + _loc2_);
      }
      
      private function FightingMonsterRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TUIRoleCanMovePlayerRole = null;
         this.FIsInBattle = false;
         _loc2_ = param1.Data.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FIsBack = false;
         this.OnSetStatusType(this,CONST_BATTLE.BattleType_FightPet,0,this.FIsHooked,this.FIsAutoGoldResurgence,this.FIsAutoSkipResurgence);
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
         _loc3_ = 0;
         while(_loc3_ < this.FCheckTouchRoleVect.length)
         {
            _loc4_ = this.FCheckTouchRoleVect[_loc3_];
            this.FCanMove.InitNewRole(_loc4_);
            _loc3_++;
         }
         this.FCheckTouchRoleVect.length = 0;
      }
      
      protected function OnSetStatusType(param1:Object, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false) : void
      {
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(param1,param2,param3,param4,param5,param6);
         }
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Visible = true;
      }
      
      protected function UIComponentsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHint.Visible = false;
      }
      
      protected function UIHelpTipsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHelpTips.Context = param2;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function UIHelpTipsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHelpTips.Hide();
      }
      
      private function CreateMainRole() : void
      {
         var _loc1_:THero = null;
         var _loc2_:TRoleCanControl = null;
         var _loc3_:TBaseHero = null;
         _loc1_ = SLogicsCore.Character.Heros.GetHeroByIndex(0);
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc1_.Identifier) as TBaseHero;
         _loc2_ = SLogicsCore.PoolUIRoleCanMove.AcquireRoleCanControl(0,0);
         _loc2_.TitleID = SLogicsCore.Character.TitleId;
         _loc2_.LittlePetID = SLogicsCore.Character.LittlePetId;
         _loc2_.RoleName = _loc1_.Name;
         _loc2_.RoleTemplateID = _loc1_.Identifier;
         _loc2_.MilitaryRank = SLogicsCore.Character.MilitaryRank;
         this.FMainRole = new TUIRoleCanMovePlayerRoleMainRole(this.FCanMove);
         this.FMainRole.ModuleId = CONST_MODULES.MODULE_FightPet;
         this.FMainRole.ChangeTextureID(_loc1_.ModelID);
         this.FMainRole.RoleData = _loc2_;
         this.ChangeMainHeroQuality();
         this.FMainRole.Init();
         this.FPet = new TUIRoleCanMovePet(this.FCanMove);
         this.FPet.ModuleId = CONST_MODULES.MODULE_FightPet;
         this.FPet.TextrueID = SLogicsCore.Character.Pet.PetModelID;
         this.FPet.FollowRole = this.FMainRole;
         this.FPet.RelexBoo = SLogicsCore.Character.Pet.RelexBoo;
         this.FMainRole.Pet = this.FPet;
         this.FPet.Init();
         this.FCanMove.InitNewRole(this.FMainRole);
         this.FCanMove.MainRole = this.FMainRole;
         this.FBackGround.ScreenRole = this.FMainRole;
         this.FLittleScript.MainRole = this.FMainRole;
      }
      
      private function OnMainRoleArriveTarget() : void
      {
         this.UpdateRolePositionSendToServer();
      }
      
      protected function UpdateRolePositionSendToServer() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         if(this.FIsHitMonst)
         {
            return;
         }
         if(this.FFightPetData.GameOver)
         {
            return;
         }
         if(this.FMonster.Direction == -1)
         {
            if(this.FLittleScript.TargetMapX > this.FMonster.MapX + 200)
            {
               return;
            }
         }
         else if(this.FMonster.Direction == 1)
         {
            if(this.FLittleScript.TargetMapX > this.FMonster.MapX)
            {
               return;
            }
         }
         _loc1_ = this.FLittleScript.TargetMapX - this.FPreTargetMapX;
         _loc2_ = this.FLittleScript.TargetMapY - this.FPreTargetMapY;
         _loc3_ = _loc1_ * _loc1_ + _loc2_ * _loc2_;
         if(_loc3_ > FSendToServerPositionMinimumSpacing)
         {
            this.FPreTargetMapX = this.FLittleScript.TargetMapX;
            this.FPreTargetMapY = this.FLittleScript.TargetMapY;
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
      
      private function CreateMonster(param1:TFightPet) : void
      {
         var _loc2_:TEnemy = null;
         var _loc3_:TRoleModel = null;
         var _loc4_:String = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Enemy,param1.MonsterID) as TEnemy;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc2_.Identifier) as TRoleModel;
         this.FFightPetData.MonsterModleID = _loc3_.Model;
         this.FMonster = new TUIRoleCanMoveMonster(this.FCanMove);
         this.FMonster.ModuleId = CONST_MODULES.MODULE_FightPet;
         this.FCanMove.addChild(this.FMonster);
         this.FMonster.ChangeTextureID(this.FFightPetData.MonsterModleID);
         this.FMonster.OnArriveTarget = this.monsterStop;
         this.FMonster.StopToBattleIdle();
         this.FMonster.MapX = 1000;
         this.FMonster.MapY = 470;
         _loc4_ = TUtilityString.Format(STRING_FIGHTPET.FORMAT_MONSTER_MODLE_NAME,param1.MonsterName);
         this.FMonster.TextFieldName(_loc4_,CONST_FONTLIBRARY.NormalFounts,4294967295);
         this.FMonster.ChangeDirection(CONST_MainScene.DIRECTION_Left);
      }
      
      private function monsterStop() : void
      {
         this.FMonster.StopToBattleIdle();
      }
      
      private function MonsterMove() : void
      {
         this.FMonster.SetupTargetPosition(Math.random() * (1300 - 950) + 950,Math.random() * (600 - 415) + 415,CONST_MainScene.RoleMoveSpeed);
         this.FTime = STimingCore.TickCount;
         this.DeathCountdown();
      }
      
      private function enterFightReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         this.FIsInBattle = true;
         this.FCanMove.InitNewRole(this.FMainRole);
         this.FPreTargetMapX = 0;
         this.FPreTargetMapY = 0;
         this.FIsHitMonst = false;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_FightPet_FightReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         this.FCanMove.visible = false;
         if(this.FSetSceneBitmapData != null)
         {
            this.FSetSceneBitmapData(this,this.GetSceneBitmapData());
         }
         this.FCanMove.visible = true;
      }
      
      private function ProcessorResourcesOnLoadCompleted(param1:Object) : void
      {
         this.FCanMove.visible = true;
      }
      
      private function SetResurrectionStatue() : void
      {
         this.FFightPetData.IsDie = false;
         this.FBackGround.filters = [];
      }
      
      private function ChangeRolePositionByMouse() : void
      {
         this.UpdateRolePositionSendToServer();
      }
      
      private function OnStarRun() : void
      {
         this.FIsStarRun = true;
      }
      
      private function OnResurrection() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_FightPet_ResurrectionReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      private function OnMoraleUp() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_FightPet_InspireReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
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
            TUtilityString.FlushUTF(_loc1_.Data,"张武哥哥" + _loc2_);
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
         this.FCanMove.AddNewCanControlRole(_loc1_);
      }
      
      private function WindowInformationOnOK(param1:Object) : void
      {
         this.backTownFun();
      }
      
      private function backTownFun() : void
      {
         this.FCanMove.ClearAllRole();
         if(this.FMonster != null)
         {
            this.FMonster.TextFieldName("","",0);
            this.FMonster.Release();
            this.FMonster = null;
         }
         if(this.FMainRole != null)
         {
            this.FCanMove.removeChild(this.FMainRole);
            this.FMainRole.RoleData.StubReferences.Dereference(this);
            this.FMainRole = null;
         }
         if(this.FPet != null)
         {
            this.FPet.Release();
            this.FPet = null;
         }
         if(this.FOnEnterCityScene != null)
         {
            this.FOnEnterCityScene(this);
         }
         this.FFightPetData.GameOver = false;
         this.FFightPetData.IsDie = false;
         this.FBackGround.Reset();
         SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_FightPet);
      }
      
      private function AddNewRole(param1:TPacket) : void
      {
         this.FCanMove.AddNewCanControlRole(param1);
      }
      
      private function RoleMove(param1:TPacket) : void
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
      
      private function RemoveTownRole(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data.readUnsignedInt();
         _loc3_ = param1.Data.readUnsignedInt();
         this.FCanMove.PlayerRemove(_loc2_,_loc3_);
      }
      
      private function UpdateRole(param1:TPacket) : void
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
      
      private function DataInit(param1:ByteArray) : void
      {
         var _loc2_:TConfigValue = null;
         this.FFightPetData.InspireCount = param1.readShort();
         this.FFightPetData.CDTime = param1.readUnsignedInt();
         this.FFightPetData.TotalCD = param1.readUnsignedInt();
         this.FFightPetData.ReviveTimes = param1.readUnsignedInt();
         this.FLayerOver.FightPetCoolDown = this.FFightPetData.TotalCD;
         this.FTimeCoolDown.TimingTime = this.FFightPetData.CDTime;
         if(this.FTimeCoolDown.TimingTime > 0)
         {
            this.FIsInCD = true;
         }
         if(this.FConfigValue == null)
         {
            this.FConfigValue = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConfigValue);
         }
         _loc2_ = this.FConfigValue.GetDatebaseByIdentifier(CONST_CONFIGVALUE.FIGHTPET_MAPID) as TConfigValue;
         this.FMapId = _loc2_.Value as uint;
         this.FBackGround.SwitchScene(this.FMapId);
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
      
      public function get OnEnterCityScene() : Function
      {
         return this.FOnEnterCityScene;
      }
      
      public function set OnEnterCityScene(param1:Function) : void
      {
         this.FOnEnterCityScene = param1;
      }
      
      public function get SetSceneBitmapData() : Function
      {
         return this.FSetSceneBitmapData;
      }
      
      public function set SetSceneBitmapData(param1:Function) : void
      {
         this.FSetSceneBitmapData = param1;
      }
      
      public function set UpdateReturnHomePanel(param1:Function) : void
      {
         this.FLayerOver.UpdateReturnHomePanel = param1;
      }
      
      public function get OnEndAutoBattle() : Function
      {
         return this.FOnEndAutoBattle;
      }
      
      public function set OnEndAutoBattle(param1:Function) : void
      {
         this.FOnEndAutoBattle = param1;
      }
      
      public function set OpenThisPanel(param1:Function) : void
      {
         this.FOpenThisPanel = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(param1 != null)
         {
            this.DataInit(param1);
         }
         SLogicsCore.Character.RoleSencePosition = CONST_COMMON.SCENEPOSITION_FightPet;
         if(!FIsResourcesLoadCompleted)
         {
            this.FLittleScript.Load();
            this.FLayerOver.Load();
            return;
         }
         if(this.FMainRole == null)
         {
            this.CreateMainRole();
         }
         if(this.FOpenThisPanel != null)
         {
            this.FOpenThisPanel(1);
         }
         this.FIsBack = true;
         this.FIsStarRun = false;
         this.FTime = STimingCore.TickCount;
         this.DeathCountdown();
         this.FLayerOver.init(this.FFightPetData);
         this.FLayerOver.Visible = true;
         this.FCanMove.SwitchMode(SLogicsCore.IsShowAllUser);
      }
      
      override public function Unmount() : void
      {
         this.FCheckTouchRoleVect.length = 0;
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
            _loc5_.ShortcutModeTongLing = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
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
            _loc8_.ShortcutModesReset(2);
         }
      }
      
      public function BattleEnd() : void
      {
         this.FLayerOver.BattleBackUpdate();
         this.FIsBack = true;
         this.FMainRole.MapX = Math.random() * (250 - 100) + 100;
         this.FMainRole.MapY = Math.random() * (600 - 415) + 415;
         this.FPet.MapX = this.FMainRole.MapX - 10;
         this.FPet.MapY = this.FMainRole.MapY + 2;
         this.FPet.ChangeDirection(CONST_MainScene.DIRECTION_RIGHT);
         this.FCanMove.ResetRolePosition();
         if(this.FFightPetData.GameOver)
         {
            this.FBackTownTimeCoolDown.TimingTime = 5;
            if(this.FMonster != null)
            {
               this.FMonster.TextFieldName("","",0);
               this.FMonster.Release();
               this.FMonster = null;
            }
         }
         else
         {
            this.FBackGround.filters = [TGameUtil.rBlackFilters];
            if(!this.FFightPetData.IsDie)
            {
               this.FBackGround.filters = [];
            }
         }
      }
      
      public function BackTownBox() : void
      {
         if(this.FUIWindowInformation == null)
         {
            this.FUIWindowInformation = new TUIWindowConfirmation(Parent);
            this.FUIWindowInformation.OnOK = this.WindowInformationOnOK;
            TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowInformation);
            this.FUIWindowInformation.Text = STRING_FIGHTPET.STRING_BACKTOWN;
            this.FUIWindowInformation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowInformation.WindowWidth) / 2;
            this.FUIWindowInformation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowInformation.WindowHeight) / 2;
         }
         this.FUIWindowInformation.visible = true;
         if(this.FFightPetData.GameOver)
         {
            this.FUIWindowInformation.visible = false;
            this.backTownFun();
         }
         if(this.FOnEndAutoBattle != null)
         {
            this.FOnEndAutoBattle(this);
         }
      }
      
      public function EnterFightPetReq(param1:uint) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Enter_FightPet);
         _loc2_.Data.writeByte(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function GetSceneBitmapData() : BitmapData
      {
         var _loc1_:BitmapData = null;
         _loc1_ = new BitmapData(CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         _loc1_.draw(this.FBackGround);
         return _loc1_;
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
      
      public function ShowAndHide(param1:Boolean) : void
      {
         if(this.FCanMove != null)
         {
            this.FCanMove.SwitchMode(param1);
         }
      }
      
      public function DeathCountdown() : void
      {
         if(this.FIsHooked)
         {
            if(this.FMonster != null && this.FMainRole != null && !this.FIsInCD && this.FIsBack && !this.FIsInBattle)
            {
               this.FMainRole.SetupTargetPosition(this.FMonster.MapX,this.FMonster.MapY,CONST_MainScene.RoleMoveSpeed);
            }
         }
      }
      
      public function SetAutoBattle(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         this.FIsHooked = param1;
         this.FIsAutoGoldResurgence = param2;
         this.FLayerOver.FIsAutoGoldResurgence = this.FIsAutoGoldResurgence;
         this.FIsAutoSkipResurgence = param3;
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         if(param1)
         {
            this.DeathCountdown();
         }
         else if(this.FMonster != null)
         {
            this.FMainRole.StopMove();
         }
         this.FBackLayerMask.visible = param1;
         this.FLayerOver.SetVisibelFire(param1);
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
      
      public function get ExecuteCommand() : Function
      {
         return this.FExecuteCommand;
      }
      
      public function set ExecuteCommand(param1:Function) : void
      {
         this.FExecuteCommand = param1;
      }
   }
}

