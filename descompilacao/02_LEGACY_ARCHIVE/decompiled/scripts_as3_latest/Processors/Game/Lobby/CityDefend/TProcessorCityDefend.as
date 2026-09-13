package Processors.Game.Lobby.CityDefend
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
   import Logics.ChatOptions.*;
   import Logics.CityDefend.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Streamization.CityDefend.*;
   import Processors.Game.Battle.TBattleHandle;
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
   import flash.events.*;
   import flash.utils.*;
   
   public class TProcessorCityDefend extends TProcessorLobbyPlate
   {
      
      protected static const TYPE_Defend:uint = 0;
      
      protected static const TYPE_Attack:uint = 1;
      
      protected static const Door_X:Vector.<Number> = Vector.<Number>([1176,1179]);
      
      protected static const Door_Y:Vector.<Number> = Vector.<Number>([469,469]);
      
      protected static const AUTOBATTLE_Status_Scene:uint = 0;
      
      protected static const AUTOBATTLE_Status_OnDoor:uint = 1;
      
      protected var MAX_ROLECOUNT:uint;
      
      protected var FBackGround:TLayerBackGround;
      
      protected var FCanMove:TLayerCanMove;
      
      protected var FLayerLittleScript:TLayerLittleScript;
      
      protected var FMainRole:TUIRoleCanMovePlayerRoleMainRole;
      
      protected var FCityDefendData:TCityDefendData;
      
      protected var FUnstreamizerCityDefend:TUnstreamizerCityDefend;
      
      protected var FScene:MovieClip;
      
      protected var FDoor:MovieClip;
      
      protected var FMC_AutoBattle:MovieClip;
      
      protected var FProcessorWindowCityDefned:TProcessorWindowCityDefned;
      
      protected var FProcessorWindowDoorHeroList:TProcessorWindowDoorHeroList;
      
      protected var FProcessorWindowCountdown:TProcessorWindowCountdown;
      
      protected var FProcessorWindowResurrection:TProcessorWindowResurrection;
      
      protected var FWindowConfirmationTurnBack:TUIWindowConfirmation;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FOutCityId:uint;
      
      protected var FInCityId:uint;
      
      protected var FDieTime:uint;
      
      protected var FOverTime:Vector.<uint>;
      
      protected var FOutMonsterId:uint;
      
      protected var FInMonsterId:uint;
      
      protected var FCost:int;
      
      protected var FCharacter:TCharacter;
      
      protected var FIsArriveTarget:Boolean;
      
      protected var FConfigValueBins:TBins;
      
      protected var FDoorPos_X:Number;
      
      protected var FDoorPos_Y:Number;
      
      protected var FBattleBack:Boolean;
      
      protected var FIsAutoBattle:Boolean;
      
      protected var FRoleAutoStatus:uint;
      
      protected var FOnEnterCityScene:Function;
      
      protected var FSetStatusType:Function;
      
      protected var FSetBattlePacket:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FOnUpdateReturnHomePanel:Function;
      
      protected var FOnSetDailyActivityStatus:Function;
      
      protected var FOnEndAutoBattle:Function;
      
      protected var FExecuteCommand:Function;
      
      protected var FIsAutoGoldResurgence:Boolean = false;
      
      protected var FIsAutoSkipResurgence:Boolean = false;
      
      protected var FOpenThisPanel:Function;
      
      public function TProcessorCityDefend(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FBackGround = new TLayerBackGround(this,CONST_MODULES.MODULE_CityDefend);
         this.FBackGround.OnLoadCompleted = this.ProcessorResourcesOnLoadCompleted;
         this.FBackGround.IsNeedSmallPic = false;
         this.FBackGround.visible = true;
         this.FCanMove = new TLayerCanMove(this.FBackGround,CONST_MODULES.MODULE_CityDefend);
         this.FCanMove.NeedInitPos = false;
         this.FCanMove.visible = false;
         this.FLayerLittleScript = new TLayerLittleScript(this);
         this.FLayerLittleScript.visible = true;
         this.FLayerLittleScript.MouseEventObject = this.FBackGround;
         this.FLayerLittleScript.ChangeRolePositionByMouse = this.OnMoveByMouse;
         this.FLayerLittleScript.LongClickMove = false;
         this.FCharacter = SLogicsCore.Character;
         this.FCityDefendData = new TCityDefendData();
         this.FUnstreamizerCityDefend = new TUnstreamizerCityDefend();
         this.FBattleBack = false;
         this.FIsAutoBattle = false;
         this.FRoleAutoStatus = AUTOBATTLE_Status_Scene;
         this.FProcessorWindowResurrection = new TProcessorWindowResurrection(this);
         SetUIModuleID(CONST_MODULES.MODULE_CityDefend);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_CITYDEFEND.RESOURCE_CityDefend);
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
         var _loc1_:TConfigValue = null;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_CITYDEFEND.RESOURCE_ClassName_MC_CityDefend) as MovieClip;
         this.FDoor = TUtilityReflection.CreateDisplayObjectInstance(CONST_CITYDEFEND.RESOURCE_ClassName_MC_Door) as MovieClip;
         addChild(this.FDoor);
         TGameUtil.setButtonMode(this.FDoor,true);
         this.FDoor.addEventListener(MouseEvent.CLICK,this.OnDoorClick);
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.CityDefend_Defend_Cleargold) as TConfigValue;
         this.FCost = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.CityDefend_Defend_Allman) as TConfigValue;
         this.MAX_ROLECOUNT = _loc1_.Value as uint;
         this.FProcessorWindowDoorHeroList = new TProcessorWindowDoorHeroList(this);
         this.FProcessorWindowDoorHeroList.OnEffectText = EffectGenerateText;
         this.FProcessorWindowDoorHeroList.SetStatusType = this.FSetStatusType;
         this.FProcessorWindowDoorHeroList.OutDoor = this.OnOutDoor;
         this.FProcessorWindowDoorHeroList.SetScene(this.FScene.mc_heroList);
         this.FProcessorWindowDoorHeroList.InitUI(this.FCityDefendData);
         this.FProcessorWindowDoorHeroList.Visible = false;
         this.FMC_AutoBattle = this.FScene.mc_AutoBattle;
         this.FMC_AutoBattle.visible = false;
         addChild(this.FMC_AutoBattle);
         this.FProcessorWindowCountdown = new TProcessorWindowCountdown(this);
         this.FProcessorWindowCountdown.OnTimeOver = this.OnTimeOver;
         this.FProcessorWindowCountdown.SetScene(this.FScene.mc_Countdown);
         this.FProcessorWindowCountdown.Visible = false;
         this.FProcessorWindowResurrection.OnEffectText = EffectGenerateText;
         this.FProcessorWindowResurrection.HintOnOver = this.UIComponentsHintOnOver;
         this.FProcessorWindowResurrection.HintOnOut = this.UIComponentsHintOnOut;
         this.FProcessorWindowResurrection.ShowBack = this.OnShowBack;
         this.FProcessorWindowResurrection.OnResurrection = this.OnResurrection;
         this.FProcessorWindowResurrection.OnTimeOver = this.OnTimeOver;
         this.FProcessorWindowResurrection.Goldlack = this.GoldlackF;
         this.FProcessorWindowResurrection.SetScene(this.FScene.mc_Resurrection);
         this.FProcessorWindowResurrection.Visible = false;
         this.FProcessorWindowCityDefned = new TProcessorWindowCityDefned(this);
         this.FProcessorWindowCityDefned.HintOnOver = this.UIComponentsHintOnOver;
         this.FProcessorWindowCityDefned.HintOnOut = this.UIComponentsHintOnOut;
         this.FProcessorWindowCityDefned.HelpHintOnOver = this.UIHelpHintOnOver;
         this.FProcessorWindowCityDefned.HelpHintOnOut = this.UIHelpHintOnOut;
         this.FProcessorWindowCityDefned.SetScene(this.FScene);
         this.FProcessorWindowCityDefned.InitUI(this.FCityDefendData);
         this.FOverlayerHint = new TOverlayerHint(this);
         this.FOverlayerHint.Visible = false;
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CityDefend_FightRet,this.PacketPerform_SC_FightRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CityDefend_ReviveRet,this.PacketPerform_SC_ReviveRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CityDefend_UpdataRank,this.PacketPerform_SC_UpdataRank);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CityDefend_UpdataDoorHp,this.PacketPerform_SC_UpdataDoorHp);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CityDefend_UpdataHeros,this.PacketPerform_SC_UpdataHeros);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CityDefend_UpdataHeroStatus,this.PacketPerform_SC_UpdataHeroStatus);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CityDefend_UpdataReport,this.PacketPerform_SC_UpdataReport);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CityDefend_BattleEnd,this.PacketPerform_SC_BattleEnd);
      }
      
      protected function PacketPerform_SC_Enter_CityDefend(param1:ByteArray) : void
      {
         var _loc2_:Date = null;
         var _loc3_:uint = 0;
         var _loc4_:TEnemy = null;
         var _loc5_:TConfigValue = null;
         this.FUnstreamizerCityDefend.Unstreamize(param1,this.FCityDefendData,null);
         this.FConfigValueBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConfigValue);
         _loc5_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.CityDefend_Defend_Outcityid) as TConfigValue;
         this.FOutCityId = _loc5_.Value as int;
         _loc5_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.CityDefend_Defend_Incityid) as TConfigValue;
         this.FInCityId = _loc5_.Value as int;
         _loc5_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.CityDefend_Defend_Deathtime) as TConfigValue;
         this.FDieTime = _loc5_.Value as int;
         _loc5_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.CityDefend_Defend_Overtime) as TConfigValue;
         this.FOverTime = _loc5_.Value as Vector.<uint>;
         _loc5_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.CityDefend_Defend_OutMonsterId) as TConfigValue;
         this.FOutMonsterId = _loc5_.Value as uint;
         _loc5_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.CityDefend_Defend_InMonsterId) as TConfigValue;
         this.FInMonsterId = _loc5_.Value as uint;
         _loc2_ = new Date(STimingCore.GetServerTime() * 1000);
         _loc2_.hours = this.FOverTime[0];
         _loc2_.minutes = this.FOverTime[1];
         _loc2_.seconds = 0;
         this.FCityDefendData.ActivityColdDown = _loc2_.getTime() / 1000;
         this.FCityDefendData.OrganizationBuffLevel = SLogicsCore.Organization.GetOrgActivityLevelByType(CONST_ORGANIZATION.TYPE_ORGACTIVITY_MUYEGUARD);
         if(this.FCityDefendData.CityDoorIndex == 0)
         {
            this.FCityDefendData.DefendBuffLevel = 0;
            _loc3_ = this.FOutMonsterId + this.FCityDefendData.WorldLevel;
            this.ChangeSceneId(this.FOutCityId);
         }
         else
         {
            this.FCityDefendData.DefendBuffLevel = 1;
            _loc3_ = this.FInMonsterId + this.FCityDefendData.WorldLevel;
            this.ChangeSceneId(this.FInCityId);
         }
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Enemy,_loc3_) as TEnemy;
         this.FCityDefendData.CityDoorTotleHp = _loc4_.Hp;
      }
      
      protected function PacketPerform_SC_FightRet(param1:TPacket) : void
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
         if(TBattleHandle.IsInBattle)
         {
            return;
         }
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_CityDefend,0,this.FIsAutoBattle,this.FIsAutoGoldResurgence,this.FIsAutoSkipResurgence);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
            TBattleHandle.IsInBattle = true;
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
      }
      
      protected function PacketPerform_SC_UpdataRank(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerCityDefend.UnstreamizeCityDefendOrganizationRank(_loc2_,this.FCityDefendData.OrganizationRank,null);
         this.FUnstreamizerCityDefend.UnstreamizeCityDefendHeroRank(_loc2_,this.FCityDefendData.HeroRank,null);
         if(this.FProcessorWindowCityDefned)
         {
            this.FProcessorWindowCityDefned.UpdataRankUI();
         }
      }
      
      protected function PacketPerform_SC_UpdataDoorHp(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FCityDefendData.CityDoorCurHp = _loc2_.readFloat();
         if(this.FProcessorWindowCityDefned)
         {
            this.FProcessorWindowCityDefned.UpdataDoorHp();
         }
         if(this.FCityDefendData.CityDoorCurHp <= 0)
         {
            if(this.FCityDefendData.CityDoorIndex == 0)
            {
               this.FProcessorWindowCountdown.StartCountdown(STimingCore.GetServerTick() + 10);
               setTimeout(this.OnEnterNextCity,10000);
               this.FProcessorWindowResurrection.ResurrectionOk();
            }
         }
      }
      
      protected function PacketPerform_SC_UpdataHeros(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:TCityDefendHero = null;
         var _loc7_:TRoleCanControl = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = _loc2_.readByte();
         if(_loc5_ < 0)
         {
            this.FCityDefendData.HeroList.Dec(_loc3_,_loc4_);
            this.FCityDefendData.DoorHeroList.Dec(_loc3_,_loc4_);
            this.FCanMove.PlayerRemove(_loc3_,_loc4_);
         }
         else
         {
            _loc6_ = SLogicsCore.PoolCityDefend.AcquireCityDefendHero(_loc3_,_loc4_);
            this.FCityDefendData.HeroList.Add(_loc6_);
            _loc6_.Status = _loc5_;
            _loc6_.UserName = TUtilityString.FetchUTF(_loc2_);
            _loc6_.Quality = _loc2_.readUnsignedByte();
            _loc6_.MilitaryRank = _loc2_.readUnsignedInt();
            _loc6_.PetStatus = Boolean(_loc2_.readUnsignedByte() == 0);
            _loc6_.PetModelId = _loc2_.readUnsignedInt();
            _loc6_.RoleTemplateId = _loc2_.readUnsignedInt();
            _loc6_.UserType = _loc2_.readUnsignedByte();
            _loc6_.UserLevel = _loc2_.readUnsignedShort();
            if(_loc6_.Identifier0 == this.FCharacter.Identifier0 && _loc6_.Identifier1 == this.FCharacter.Identifier1)
            {
               return;
            }
            if(this.FCityDefendData.CityDefendType == TYPE_Attack && this.FCanMove.RoleCount >= this.MAX_ROLECOUNT)
            {
               return;
            }
            _loc7_ = SLogicsCore.PoolUIRoleCanMove.AcquireRoleCanControl(_loc3_,_loc4_);
            _loc7_.RoleName = _loc6_.UserName;
            _loc7_.MilitaryRank = _loc6_.MilitaryRank;
            _loc7_.RelexBoo = _loc6_.PetStatus;
            _loc7_.TextureID = _loc6_.PetModelId;
            _loc7_.RoleTemplateID = _loc6_.RoleTemplateId;
            _loc7_.Quality = _loc6_.Quality;
            if(_loc6_.UserType == TYPE_Defend)
            {
               _loc7_.MapX = 2150 + Math.random() * 50;
               _loc7_.MapY = 450 + Math.random() * 40;
            }
            else
            {
               _loc7_.MapX = 100 + Math.random() * 200;
               _loc7_.MapY = 400 + Math.random() * 200;
            }
            this.FCanMove.PlayerAdd(_loc7_);
         }
         if(this.FProcessorWindowDoorHeroList)
         {
            this.FProcessorWindowDoorHeroList.UpdataDoorHeroList();
         }
      }
      
      protected function PacketPerform_SC_UpdataHeroStatus(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:TCityDefendHero = null;
         var _loc8_:TCityDefendHero = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = uint(_loc2_.readByte());
         if(_loc3_ == this.FCharacter.Identifier0 && this.FCharacter.Identifier1 == _loc4_)
         {
            if(_loc5_ == 0)
            {
               if(this.FCityDefendData.CityDefendType == TYPE_Defend)
               {
                  this.FMainRole.MapX = 2150 + Math.random() * 50;
                  this.FMainRole.MapY = 450 + Math.random() * 40;
               }
               else
               {
                  this.FMainRole.MapX = 100 + Math.random() * 200;
                  this.FMainRole.MapY = 400 + Math.random() * 200;
               }
               this.FProcessorWindowResurrection.StartCountdown(STimingCore.GetServerTick() + this.FDieTime,this.FCost);
               this.FProcessorWindowDoorHeroList.Visible = false;
               this.FRoleAutoStatus = AUTOBATTLE_Status_Scene;
            }
         }
         else
         {
            _loc7_ = this.FCityDefendData.HeroList.GetHeroById(_loc3_,_loc4_);
            _loc6_ = _loc7_.Status;
            _loc7_.Status = _loc5_;
            if(_loc5_ == 0)
            {
               if(_loc7_.UserType == TYPE_Defend)
               {
                  this.FCanMove.PlayerMove(_loc3_,_loc4_,2150 + Math.random() * 50,450 + Math.random() * 40);
               }
               else
               {
                  this.FCanMove.PlayerMove(_loc3_,_loc4_,100 + Math.random() * 200,400 + Math.random() * 200);
               }
               this.FCityDefendData.DoorHeroList.Dec(_loc3_,_loc4_);
            }
            else
            {
               if(_loc6_ == 0)
               {
                  if(_loc7_.UserType == TYPE_Defend)
                  {
                     this.FCanMove.PlayerMove(_loc3_,_loc4_,this.FDoorPos_X + 600,this.FDoorPos_Y - 30 + Math.random() * 50);
                  }
                  else
                  {
                     this.FCanMove.PlayerMove(_loc3_,_loc4_,this.FDoorPos_X - 90 + Math.random() * 20,this.FDoorPos_Y - 30 + Math.random() * 50);
                  }
               }
               if(_loc6_ != 1 && _loc5_ == 1)
               {
                  _loc8_ = this.FCityDefendData.DoorHeroList.GetHeroById(_loc3_,_loc4_);
                  if(_loc8_ == null && _loc7_.UserType != this.FCityDefendData.CityDefendType)
                  {
                     _loc8_ = SLogicsCore.PoolCityDefend.AcquireCityDefendHero(_loc3_,_loc4_);
                     this.FCityDefendData.DoorHeroList.Add(_loc8_);
                     _loc8_.UserName = _loc7_.UserName;
                     _loc8_.UserLevel = _loc7_.UserLevel;
                  }
               }
               else if(_loc5_ == 2)
               {
                  this.FCityDefendData.DoorHeroList.Dec(_loc3_,_loc4_);
               }
            }
         }
         if(this.FProcessorWindowDoorHeroList)
         {
            this.FProcessorWindowDoorHeroList.UpdataDoorHeroList();
         }
      }
      
      protected function PacketPerform_SC_UpdataReport(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerCityDefend.UnstreamizeCityDefendReport(_loc2_,this.FCityDefendData.ReportList,null);
         this.FProcessorWindowCityDefned.UpdataReportUI();
      }
      
      protected function PacketPerform_SC_BattleEnd(param1:TPacket) : void
      {
         if(this.FProcessorWindowCountdown != null)
         {
            this.FProcessorWindowCountdown.StartCountdown(STimingCore.GetServerTick() + 5);
            setTimeout(this.EnterCityScene,5000);
            this.FProcessorWindowResurrection.Stop();
         }
         if(this.FOnSetDailyActivityStatus != null)
         {
            this.FOnSetDailyActivityStatus(this,CONST_ORGANIZATION.TYPE_ORGACTIVITY_MUYEGUARD,CONST_ORGANIZATION.STATUS_ORGACTIVITY_End);
         }
         if(this.FOnEndAutoBattle != null)
         {
            this.FOnEndAutoBattle(this);
         }
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_CityDefend)
         {
            this.FBackGround.Update();
            this.FCanMove.Update();
            this.LogicsPerform_Timer();
            this.LogicsPerform_DoorPos();
            this.LogicsPerform_MainRoleMove();
            if(this.visible)
            {
               if(this.FProcessorWindowResurrection.Visible || this.FProcessorWindowCountdown.Visible)
               {
                  if(this.FMainRole == null)
                  {
                     return;
                  }
                  this.FMainRole.StopMove();
               }
            }
         }
      }
      
      protected function LogicsPerform_Timer() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         if(this.FOnUpdateReturnHomePanel != null)
         {
            _loc1_ = this.FCityDefendData.ActivityColdDown - STimingCore.GetServerTime();
            _loc2_ = TGameUtil.fomatTime(_loc1_);
            this.FOnUpdateReturnHomePanel(this,STRING_CITYDEFEND.STRING_Activity_Name,STRING_COMMON.STRING_EndTime + _loc2_);
         }
      }
      
      protected function LogicsPerform_DoorPos() : void
      {
         if(this.FDoor == null)
         {
            return;
         }
         this.FDoor.x = Door_X[this.FCityDefendData.CityDoorIndex] - SLogicsCore.ScreenMapX;
      }
      
      protected function LogicsPerform_MainRoleMove() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this.FMainRole == null)
         {
            return;
         }
         if(this.FCityDefendData.CityDefendType == TYPE_Defend)
         {
            if(this.FMainRole.MapX < 1700)
            {
               this.FMainRole.MapX = 1700;
               this.FMainRole.StopMove();
               this.OnMainRoleArriveTarget();
               if(!this.FProcessorWindowDoorHeroList.Visible)
               {
                  this.OnDoorClick();
               }
            }
         }
         else
         {
            _loc1_ = 0.62;
            _loc2_ = Door_X[this.FCityDefendData.CityDoorIndex] - 50;
            _loc3_ = Door_Y[this.FCityDefendData.CityDoorIndex];
            _loc4_ = _loc1_ * (this.FMainRole.MapX - _loc2_) + _loc3_;
            if(_loc4_ > this.FMainRole.MapY)
            {
               this.FMainRole.MapY = _loc4_;
               this.FMainRole.StopMove();
               this.OnMainRoleArriveTarget();
               if(!this.FProcessorWindowDoorHeroList.Visible)
               {
                  this.OnDoorClick();
               }
            }
         }
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
         _loc2_.TitleID = this.FCharacter.TitleId;
         _loc2_.LittlePetID = this.FCharacter.LittlePetId;
         _loc2_.RoleName = _loc1_.Name;
         _loc2_.RoleTemplateID = _loc1_.Identifier;
         _loc2_.MilitaryRank = this.FCharacter.MilitaryRank;
         this.FMainRole = new TUIRoleCanMovePlayerRoleMainRole(this.FCanMove);
         this.FMainRole.ModuleId = CONST_MODULES.MODULE_CityDefend;
         this.FMainRole.ChangeTextureID(_loc1_.ModelID);
         this.FMainRole.RoleData = _loc2_;
         this.FMainRole.OnArriveTarget = this.OnMainRoleArriveTarget;
         this.FMainRole.Init();
         this.FMainRole.RoleData.Quality = _loc1_.Quality;
         this.FMainRole.UpdateMainRoleNameColor();
         _loc3_ = new TUIRoleCanMovePet(this.FCanMove);
         _loc3_.ModuleId = CONST_MODULES.MODULE_CityDefend;
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
      
      protected function EnterCityDefend() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TRoleCanControl = null;
         var _loc3_:TCityDefendHero = null;
         this.FProcessorWindowCityDefned.UpdataRankUI();
         this.FProcessorWindowCityDefned.UpdataReportUI();
         this.FProcessorWindowCityDefned.UpdataDoorHp();
         this.FProcessorWindowDoorHeroList.Visible = false;
         this.FProcessorWindowDoorHeroList.UpdataDoorHeroList();
         this.FProcessorWindowCountdown.StartCountdown(this.FCityDefendData.BeferStartColdDown);
         this.FProcessorWindowResurrection.Stop();
         this.FDoor.x = Door_X[this.FCityDefendData.CityDoorIndex];
         this.FDoor.y = Door_Y[this.FCityDefendData.CityDoorIndex];
         if(this.FCityDefendData.CityDefendType == TYPE_Defend)
         {
            this.FMainRole.MapX = 2150 + Math.random() * 50;
            this.FMainRole.MapY = 450 + Math.random() * 40;
         }
         else
         {
            this.FMainRole.MapX = 100 + Math.random() * 200;
            this.FMainRole.MapY = 400 + Math.random() * 200;
         }
         this.FDoorPos_X = Door_X[this.FCityDefendData.CityDoorIndex];
         this.FDoorPos_Y = Door_Y[this.FCityDefendData.CityDoorIndex];
         _loc1_ = 0;
         while(_loc1_ < this.FCityDefendData.HeroList.Count)
         {
            _loc3_ = this.FCityDefendData.HeroList.GetHeroByIndex(_loc1_);
            if(!(_loc3_.Identifier0 == this.FCharacter.Identifier0 && _loc3_.Identifier1 == this.FCharacter.Identifier1))
            {
               if(this.FCityDefendData.CityDefendType == TYPE_Attack && this.FCanMove.RoleCount >= this.MAX_ROLECOUNT)
               {
                  return;
               }
               _loc2_ = SLogicsCore.PoolUIRoleCanMove.AcquireRoleCanControl(_loc3_.Identifier0,_loc3_.Identifier1);
               _loc2_.RoleName = _loc3_.UserName;
               _loc2_.MilitaryRank = _loc3_.MilitaryRank;
               _loc2_.RelexBoo = _loc3_.PetStatus;
               _loc2_.TextureID = _loc3_.PetModelId;
               _loc2_.RoleTemplateID = _loc3_.RoleTemplateId;
               _loc2_.Quality = _loc3_.Quality;
               if(_loc3_.UserType == TYPE_Defend)
               {
                  if(_loc3_.Status == 1 || _loc3_.Status == 2)
                  {
                     _loc2_.MapX = this.FDoorPos_X + 600;
                     _loc2_.MapY = this.FDoorPos_Y - 30 + Math.random() * 50;
                  }
                  else
                  {
                     _loc2_.MapX = 2150 + Math.random() * 50;
                     _loc2_.MapY = 450 + Math.random() * 40;
                  }
               }
               else if(_loc3_.Status == 1 || _loc3_.Status == 2)
               {
                  _loc2_.MapX = this.FDoorPos_X - 90 + Math.random() * 20;
                  _loc2_.MapY = this.FDoorPos_Y - 30 + Math.random() * 50;
               }
               else
               {
                  _loc2_.MapX = 100 + Math.random() * 200;
                  _loc2_.MapY = 400 + Math.random() * 200;
               }
               this.FCanMove.PlayerAdd(_loc2_);
            }
            _loc1_++;
         }
         this.OnShowBack(this,false);
      }
      
      protected function OnResurrection(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CityDefend_ReviveReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnTimeOver(param1:Object) : void
      {
         if(this.FIsAutoBattle && !TBattleHandle.IsInBattle)
         {
            this.StartAutoBattle();
         }
      }
      
      protected function EnterCityScene(param1:Object = null) : void
      {
         if(this.FOnEnterCityScene != null)
         {
            this.FOnEnterCityScene(param1);
         }
         this.FCanMove.ClearAllRole();
         if(this.FOnEndAutoBattle != null)
         {
            this.FOnEndAutoBattle(this);
         }
         this.FBackGround.Reset();
         SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_FightPet);
      }
      
      protected function OnEnterNextCity() : void
      {
         var _loc1_:TEnemy = null;
         var _loc2_:uint = 0;
         var _loc3_:TCityDefendHero = null;
         this.FCityDefendData.DefendBuffLevel = 1;
         this.FCityDefendData.CityDoorIndex = 1;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Enemy,this.FInMonsterId + this.FCityDefendData.WorldLevel) as TEnemy;
         this.FCityDefendData.CityDoorTotleHp = _loc1_.Hp;
         this.FCityDefendData.CityDoorCurHp = this.FCityDefendData.CityDoorTotleHp;
         this.FProcessorWindowCityDefned.UpdataDoorHp();
         this.ChangeSceneId(this.FInCityId);
         this.FCityDefendData.DoorHeroList.Clear();
         this.FProcessorWindowDoorHeroList.Visible = false;
         this.FDoor.x = Door_X[this.FCityDefendData.CityDoorIndex];
         this.FDoor.y = Door_Y[this.FCityDefendData.CityDoorIndex];
         if(this.FCityDefendData.CityDefendType == TYPE_Defend)
         {
            this.FMainRole.MapX = 2150 + Math.random() * 50;
            this.FMainRole.MapY = 450 + Math.random() * 40;
         }
         else
         {
            this.FMainRole.MapX = 100 + Math.random() * 200;
            this.FMainRole.MapY = 400 + Math.random() * 200;
         }
         this.FDoorPos_X = Door_X[this.FCityDefendData.CityDoorIndex];
         this.FDoorPos_Y = Door_Y[this.FCityDefendData.CityDoorIndex];
         _loc2_ = 0;
         while(_loc2_ < this.FCityDefendData.HeroList.Count)
         {
            _loc3_ = this.FCityDefendData.HeroList.GetHeroByIndex(_loc2_);
            _loc3_.Status = 0;
            if(_loc3_.UserType == TYPE_Defend)
            {
               this.FCanMove.PlayerMove(_loc3_.Identifier0,_loc3_.Identifier1,2150 + Math.random() * 50,450 + Math.random() * 40);
            }
            else
            {
               this.FCanMove.PlayerMove(_loc3_.Identifier0,_loc3_.Identifier1,100 + Math.random() * 200,400 + Math.random() * 200);
            }
            _loc2_++;
         }
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
      
      protected function OnMainRoleArriveTarget() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         if(!this.FIsArriveTarget)
         {
            return;
         }
         this.FIsArriveTarget = false;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CityDefend_CityDoorReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeByte(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         this.FProcessorWindowDoorHeroList.Visible = true;
         this.FRoleAutoStatus = AUTOBATTLE_Status_OnDoor;
         if(this.FIsAutoBattle)
         {
            this.StartAutoBattle();
         }
      }
      
      protected function OnOutDoor(param1:Object) : void
      {
         this.FRoleAutoStatus = AUTOBATTLE_Status_Scene;
      }
      
      protected function OnMoveByMouse() : void
      {
         this.FIsArriveTarget = false;
      }
      
      protected function OnShowBack(param1:Object, param2:Boolean) : void
      {
         if(param2)
         {
            this.FBackGround.filters = [TGameUtil.rBlackFilters];
            if(this.FIsAutoGoldResurgence)
            {
               this.FProcessorWindowResurrection.ResurrectionClick();
            }
         }
         else
         {
            this.FBackGround.filters = [];
         }
      }
      
      protected function StartAutoBattle() : void
      {
         if(this.FProcessorWindowResurrection.Visible == false && this.FProcessorWindowCountdown.Visible == false)
         {
            if(this.FRoleAutoStatus == AUTOBATTLE_Status_Scene)
            {
               this.OnDoorClick();
            }
            else if(this.FRoleAutoStatus == AUTOBATTLE_Status_OnDoor)
            {
               this.FProcessorWindowDoorHeroList.FightFirst();
            }
         }
      }
      
      protected function StopAutoBattle() : void
      {
         if(this.FMainRole != null)
         {
            this.FMainRole.StopMove();
         }
      }
      
      protected function OnDoorClick(param1:MouseEvent = null) : void
      {
         this.FIsArriveTarget = true;
         if(this.FCityDefendData.CityDefendType == TYPE_Defend)
         {
            this.FMainRole.SetupTargetPosition(this.FDoorPos_X + 600,this.FDoorPos_Y - 30 + Math.random() * 50,CONST_MainScene.RoleMoveSpeed);
         }
         else
         {
            this.FMainRole.SetupTargetPosition(this.FDoorPos_X - 90 + Math.random() * 20,this.FDoorPos_Y - 30 + Math.random() * 50,CONST_MainScene.RoleMoveSpeed);
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
      
      public function set SetBattlePacket(param1:Function) : void
      {
         this.FSetBattlePacket = param1;
      }
      
      public function get SetBattlePacket() : Function
      {
         return this.FSetBattlePacket;
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
      
      public function set OnSetDailyActivityStatus(param1:Function) : void
      {
         this.FOnSetDailyActivityStatus = param1;
      }
      
      public function get OnSetDailyActivityStatus() : Function
      {
         return this.FOnSetDailyActivityStatus;
      }
      
      public function set OnEndAutoBattle(param1:Function) : void
      {
         this.FOnEndAutoBattle = param1;
      }
      
      public function get OnEndAutoBattle() : Function
      {
         return this.FOnEndAutoBattle;
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
      
      override public function ChatOptionsSetup(param1:TChatOptions) : void
      {
         param1.ChatOptionsReset();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(this.FBattleBack)
         {
            this.FBattleBack = false;
            if(this.FIsAutoBattle && this.FProcessorWindowResurrection.Visible == false && this.FProcessorWindowCountdown.Visible == false)
            {
               this.StartAutoBattle();
            }
            return;
         }
         this.FBattleBack = false;
         this.FIsAutoBattle = false;
         this.FRoleAutoStatus = AUTOBATTLE_Status_Scene;
         if(param1 != null)
         {
            this.PacketPerform_SC_Enter_CityDefend(param1);
         }
         if(!FIsResourcesLoadCompleted)
         {
            this.FLayerLittleScript.Load();
            return;
         }
         if(this.FOpenThisPanel != null)
         {
            this.FOpenThisPanel(4);
         }
         this.FCharacter.RoleSencePosition = CONST_COMMON.SCENEPOSITION_CityDefend;
         this.CreateMainRole();
         this.EnterCityDefend();
         this.FCanMove.SwitchMode(SLogicsCore.IsShowAllUser);
      }
      
      override public function Unmount() : void
      {
      }
      
      public function EnterCityDefendReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Enter_CityDefend);
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
      
      public function ShowAndHide(param1:Boolean) : void
      {
         if(this.FCanMove != null)
         {
            this.FCanMove.SwitchMode(param1);
         }
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
         this.FIsAutoBattle = param1;
         this.FIsAutoGoldResurgence = param2;
         this.FProcessorWindowResurrection.FIsAutoGoldResurgence = this.FIsAutoGoldResurgence;
         this.FIsAutoSkipResurgence = param3;
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         if(this.FIsAutoBattle)
         {
            this.StartAutoBattle();
            this.FMC_AutoBattle.play();
            this.FMC_AutoBattle.visible = true;
         }
         else
         {
            this.StopAutoBattle();
            this.FMC_AutoBattle.stop();
            this.FMC_AutoBattle.visible = false;
         }
      }
   }
}

