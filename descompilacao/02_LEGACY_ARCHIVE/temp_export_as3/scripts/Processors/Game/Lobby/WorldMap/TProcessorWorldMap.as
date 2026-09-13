package Processors.Game.Lobby.WorldMap
{
   import Debugging.*;
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Strings.*;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Campaign.*;
   import Logics.Characters.*;
   import Logics.ChatOptions.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Logics.Items.*;
   import Logics.Streamization.Campaign.*;
   import Processors.*;
   import Processors.Game.*;
   import Processors.Game.Battle.*;
   import Processors.Game.Lobby.Campaign.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Common.Shortcuts.*;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.*;
   import Rendering.Overlayers.Inventories.*;
   import Resources.Constants.*;
   import Resources.Strings.STRING_WORLDMAP;
   import Utilities.UI.Overlayers.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class TProcessorWorldMap extends TProcessorLobbyPlate
   {
      
      public static const SELECT_NONE:int = 0;
      
      public static const SELECT_HOME:int = 1;
      
      public static const SELECT_CITY:int = 2;
      
      public static const SELECT_CAMPAIGN:int = 3;
      
      protected static const SIZE_WIDTH_Mission:int = 1250;
      
      protected static const SIZE_HEIGHT_Mission:int = 650;
      
      protected static const SIZE_WIDTH_Camp:int = 867;
      
      protected static const SIZE_HEIGHT_Camp:int = 532;
      
      protected static const SIZE_WIDTH_AutoMission:int = 495;
      
      protected static const SIZE_HEIGHT_AutoMission:int = 555;
      
      protected static const SIZE_WIDTH_AutoCamp:int = 479;
      
      protected static const SIZE_HEIGHT_AutoCamp:int = 417;
      
      protected static const Stamp_MissionId:uint = 1;
      
      protected static const Stamp_CampId:uint = 1;
      
      protected static const Stamp_HomeId:uint = 100000;
      
      protected static const COUNT_Movie:uint = 6;
      
      public static var LevelFilters:GlowFilter = new GlowFilter(0,1,4,4,5);
      
      protected var FScene:MovieClip;
      
      protected var FRole:MovieClip;
      
      protected var FMissionChoose:TNodalChoose;
      
      protected var FCampChoose:TCampChoose;
      
      protected var FAutoMission:TAutoNodal;
      
      protected var FAutoCamp:TAutoNodalFB;
      
      protected var FSelectStatus:int;
      
      protected var FNodalAutoMonsterInfo:TNodalAutoMonsterInfo;
      
      protected var UnstreamizerOpenAuto:TUnstreamizerOpenAuto;
      
      protected var FNodalModel:TNodal;
      
      protected var UnstreamizerNodal:TUnstreamizerNodal;
      
      protected var FBoundsMission:TBounds;
      
      protected var FBoundsCamp:TBounds;
      
      protected var FBoundsAutoMission:TBounds;
      
      protected var FBoundsAutoCamp:TBounds;
      
      protected var FIsRoleFirstShow:Boolean;
      
      protected var FTargetCityId:uint;
      
      protected var FTargetNodalId:uint;
      
      protected var FTimerID:uint;
      
      protected var FPassNodalWindow:TPassNodalWindow;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FCityBins:TBins;
      
      protected var FSingleBins:TBins;
      
      protected var FSinglePointPath:TBins;
      
      protected var FBlockPointBins:TBins;
      
      protected var FEnemyArmyBins:TBins;
      
      protected var FEnemyBins:TBins;
      
      protected var FLevelTextFormat:TextFormat;
      
      protected var FIsInit:Boolean;
      
      protected var FPoolCampaign:TPoolCampaign;
      
      protected var FPoolItem:TPoolItem;
      
      protected var FCharacter:TCharacter;
      
      protected var FAutoCityId:uint;
      
      protected var FAutoMissionId:uint;
      
      protected var FAutoCount:int;
      
      protected var FStartTime:int;
      
      protected var FIsFast:Boolean;
      
      protected var FAutoByteArray:ByteArray;
      
      protected var FOnReturnCityScene:Function;
      
      protected var FOnCheckTask:Function;
      
      protected var FAddPopTips:Function;
      
      protected var FOnNotifyMainSceneIntoAutoBattle:Function;
      
      protected var FOnAutoBattleMainUISet:Function;
      
      protected var FOnEnterWorldMap:Function;
      
      public function TProcessorWorldMap(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FNodalAutoMonsterInfo = new TNodalAutoMonsterInfo();
         this.UnstreamizerOpenAuto = new TUnstreamizerOpenAuto();
         this.UnstreamizerNodal = new TUnstreamizerNodal();
         this.FBoundsMission = new TBounds();
         this.FBoundsCamp = new TBounds();
         this.FBoundsAutoMission = new TBounds();
         this.FBoundsAutoCamp = new TBounds();
         this.FBoundsMission.Width = SIZE_WIDTH_Mission;
         this.FBoundsMission.Height = SIZE_HEIGHT_Mission;
         this.FBoundsCamp.Width = SIZE_WIDTH_Camp;
         this.FBoundsCamp.Height = SIZE_HEIGHT_Camp;
         this.FBoundsAutoMission.Width = SIZE_WIDTH_AutoMission;
         this.FBoundsAutoMission.Height = SIZE_HEIGHT_AutoMission;
         this.FBoundsAutoCamp.Width = SIZE_WIDTH_AutoCamp;
         this.FBoundsAutoCamp.Height = SIZE_HEIGHT_AutoCamp;
         this.FSelectStatus = SELECT_NONE;
         this.FNodalModel = SLogicsCore.Nodal;
         this.FPoolCampaign = SLogicsCore.PoolCampaign;
         this.FPoolItem = SLogicsCore.PoolItem;
         this.FCharacter = SLogicsCore.Character;
         this.FLevelTextFormat = new TextFormat(CONST_FONTLIBRARY.NormalFounts,STRING_WORLDMAP.LevelTextFormat_Size,16777215,true);
         this.FIsInit = false;
         SetUIModuleID(CONST_MODULES.MODULE_WorldMap);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FMissionChoose != null && this.FMissionChoose.Visible == true)
         {
            this.FMissionChoose.UpdataBitmap();
         }
         if(this.FCampChoose != null && this.FCampChoose.Visible == true)
         {
            this.FCampChoose.UpdataBitmap();
         }
         if(this.FPassNodalWindow != null)
         {
            this.FPassNodalWindow.UpdataSlot();
         }
         if(Boolean(this.FScene) && this.FScene.mc_autoBattle.visible == true)
         {
            if(this.FAutoMission.TotleTimer > 0)
            {
               this.FScene.mc_autoBattle.tf_info.text = STRING_WORLDMAP.STRINGS_AutoBattle + TGameUtil.fomatTime(this.FAutoMission.TotleTimer);
            }
            else
            {
               this.FScene.mc_autoBattle.tf_info.text = STRING_WORLDMAP.STRINGS_AutoBattleEnd;
            }
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_CAMPAIGN.RESOURCESID_WorldMap);
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
         this.FCityBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_City);
         this.FSingleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Single);
         this.FSinglePointPath = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SinglePointPath);
         this.FBlockPointBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BlockPoint);
         this.FEnemyArmyBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_EnemyArmy);
         this.FEnemyBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Enemy);
         this.InitNodalChoose();
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_WorldMap_ContinueAutoInfo,this.PacketPerform_SC_ContinueAutoInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_WorldMap_AutoBattleInfo,this.PacketPerform_SC_AutoBattleInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_WorldMap_AutoBattleFBInfo,this.PacketPerform_SC_AutoBattleFBInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_WorldMap_ResetFB,this.PacketPerform_SC_ResetFB);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_WorldMap_Assessment,this.PacketPerform_SC_StarInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_WorldMap_Notify,this.PacketPerform_SC_Notify);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_WorldMap_QueryChestRet,this.PacketPerform_SC_PassNodalWindow);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_WorldMap_ReceiveChestRet,this.PacketPerform_SC_PassNodalWindow);
      }
      
      protected function PacketPerform_SC_WorldMapInfo(param1:ByteArray) : void
      {
         this.Enter(param1);
         this.FIsInit = true;
         if(this.FTargetCityId == 0)
         {
            this.FTargetCityId = this.FCharacter.TownID;
            this.FRole.x = this.FScene["home_" + this.FTargetCityId].x;
            this.FRole.y = this.FScene["home_" + this.FTargetCityId].y;
         }
         clearTimeout(this.FTimerID);
         this.FTimerID = setTimeout(this.SetGoto,500);
         this.FScene.visible = true;
         if(this.FRole)
         {
            this.FRole.mc_head.gotoAndStop("icon" + this.FCharacter.MainHero.Identifier);
         }
         this.UpdataMapUI();
      }
      
      protected function PacketPerform_SC_ContinueAutoInfo(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         this.FAutoCityId = _loc2_.readUnsignedInt();
         this.FAutoMissionId = _loc2_.readUnsignedInt();
         this.FAutoCount = _loc2_.readUnsignedShort();
         this.FStartTime = _loc2_.readUnsignedInt();
         this.FIsFast = Boolean(_loc2_.readByte());
         _loc3_ = this.FStartTime + 180 * this.FAutoCount;
         if(this.FOnNotifyMainSceneIntoAutoBattle != null)
         {
            this.FOnNotifyMainSceneIntoAutoBattle(this,true,_loc3_);
         }
         if(this.FOnEnterWorldMap != null)
         {
            this.FOnEnterWorldMap(this);
         }
      }
      
      protected function PacketPerform_SC_AutoBattleInfo(param1:TPacket) : void
      {
         if(this.FAutoMission == null)
         {
            this.FAutoByteArray = new ByteArray();
            this.FAutoByteArray.writeBytes(param1.Data,0,param1.Data.length);
         }
         else
         {
            this.FAutoMission.PacketPerform_SC_AutoBattleInfo(param1);
            if(this.FOnNotifyMainSceneIntoAutoBattle != null)
            {
               this.FOnNotifyMainSceneIntoAutoBattle(this,true,STimingCore.GetServerTick() + this.FAutoMission.TotleTimer);
            }
         }
      }
      
      protected function PacketPerform_SC_AutoBattleFBInfo(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         if(this.FAutoCamp == null)
         {
            this.FAutoCamp = new TAutoNodalFB(this,this.FNodalModel);
            this.FAutoCamp.OnEffectText = FOnEffectText;
            this.FAutoCamp.OnEndAutoCamp = this.OnEndAutoCamp;
            this.FAutoCamp.BackFunction = this.WhatFuck;
            ComponentBoundsCenter(this.FAutoCamp,this.FBoundsAutoCamp);
         }
         this.FAutoCamp.PacketPerform_SC_AutoBattleInfo(param1);
         if(!this.FAutoCamp.visible)
         {
            this.FAutoCamp.OpenWindow();
         }
      }
      
      protected function PacketPerform_SC_ResetFB(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:TCampaign = null;
         _loc4_ = param1.Data;
         _loc2_ = _loc4_.readInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc3_ = _loc4_.readInt();
         this.FNodalModel.ResetCampaign(_loc3_);
         this.FCampChoose.Updata();
      }
      
      protected function MakeTextField(param1:int, param2:int) : TextField
      {
         var _loc3_:TextField = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TBlockPoint = null;
         var _loc7_:TBlockPoint = null;
         var _loc8_:TCity = null;
         var _loc9_:TSingle = null;
         var _loc10_:String = null;
         _loc3_ = new TextField();
         _loc3_.autoSize = TextFieldAutoSize.CENTER;
         _loc3_.selectable = false;
         _loc3_.name = "level_" + param1;
         this.FScene["level_" + param1] = _loc3_;
         this.FScene.addChild(_loc3_);
         _loc3_.visible = false;
         _loc3_.filters = [LevelFilters];
         if(param2 == SELECT_CITY)
         {
            _loc8_ = this.FCityBins.GetDatebaseByIdentifier(param1) as TCity;
            _loc6_ = this.FBlockPointBins.GetDatebaseByIdentifier(_loc8_.Start) as TBlockPoint;
            _loc7_ = this.FBlockPointBins.GetDatebaseByIdentifier(_loc8_.Last) as TBlockPoint;
            _loc4_ = uint(_loc6_.Level);
            _loc5_ = uint(_loc7_.Level);
            _loc3_.text = "(" + STRING_WORLDMAP.STRINGS_LV + _loc4_ + "~" + _loc5_ + ")";
         }
         else if(param2 == SELECT_CAMPAIGN)
         {
            _loc9_ = this.FSingleBins.GetDatebaseByIdentifier(param1) as TSingle;
            _loc4_ = uint(_loc9_.Level);
            _loc10_ = STRING_WORLDMAP.STRING_Camp;
            _loc10_ = _loc10_.split("%count%").join(_loc4_);
            _loc3_.text = _loc10_;
         }
         _loc3_.setTextFormat(this.FLevelTextFormat);
         _loc3_.antiAliasType = AntiAliasType.ADVANCED;
         return _loc3_;
      }
      
      protected function InitNodalChoose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DisplayObject = null;
         var _loc3_:TCity = null;
         var _loc4_:TextField = null;
         this.FIsRoleFirstShow = true;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_CAMPAIGN.RESOURCE_ClassName_Nodal) as MovieClip;
         addChild(this.FScene);
         _loc1_ = int(CONST_CAMPAIGN.Start_NodalId);
         while(_loc1_ <= CONST_CAMPAIGN.End_NodalId)
         {
            _loc2_ = this.FScene["city_" + _loc1_];
            if(_loc2_ != null)
            {
               _loc2_.visible = false;
               _loc2_.addEventListener(MouseEvent.CLICK,this.OnNodalChoose);
               _loc4_ = this.MakeTextField(_loc1_,SELECT_CITY);
               _loc4_.x = _loc2_.x + STRING_WORLDMAP.LevelTextFiled_X;
               _loc4_.y = _loc2_.y + STRING_WORLDMAP.LevelTextFiled_Y;
               _loc4_.width = _loc2_.width;
            }
            _loc1_ += Stamp_MissionId;
         }
         _loc1_ = int(CONST_CAMPAIGN.Start_CAMPId);
         while(_loc1_ <= CONST_CAMPAIGN.End_CAMPId)
         {
            _loc2_ = this.FScene["camp_" + _loc1_];
            if(_loc2_ != null)
            {
               _loc2_.visible = false;
               _loc2_.addEventListener(MouseEvent.CLICK,this.OnNodalChoose);
               _loc3_ = this.FCityBins.GetDatebaseByIdentifier(_loc1_) as TCity;
               _loc4_ = this.MakeTextField(_loc3_.Start,SELECT_CAMPAIGN);
               _loc4_.x = _loc2_.x + STRING_WORLDMAP.LevelTextFiled_X;
               _loc4_.y = _loc2_.y + STRING_WORLDMAP.LevelTextFiled_Y;
               _loc4_.width = _loc2_.width;
            }
            _loc1_ += Stamp_CampId;
         }
         _loc1_ = int(CONST_CAMPAIGN.Start_HomelId);
         while(_loc1_ <= CONST_CAMPAIGN.End_HomeId)
         {
            _loc2_ = this.FScene["home_" + _loc1_];
            if(_loc2_ != null)
            {
               _loc2_.visible = true;
               _loc2_.addEventListener(MouseEvent.CLICK,this.OnNodalChoose);
            }
            _loc1_ += Stamp_HomeId;
         }
         this.FScene.btn_close.addEventListener(MouseEvent.CLICK,this.OnCloseMap);
         this.FRole = this.FScene.mc_role;
         this.FRole.mouseChildren = this.FRole.mouseEnabled = false;
         this.FRole.gotoAndPlay(1);
         this.FRole.addEventListener(Event.COMPLETE,this.PlayComplete);
         this.FMissionChoose = new TNodalChoose(this,this.FNodalModel);
         this.FMissionChoose.OnEffectText = FOnEffectText;
         this.FMissionChoose.AddPopTips = this.FAddPopTips;
         this.FMissionChoose.OpenAutoInfo = this.OpenAutoInfo;
         this.FMissionChoose.OnHelpTipsOver = this.UIHelpTipsHintOnOver;
         this.FMissionChoose.OnHelpTipsOut = this.UIHelpTipsHintOnOut;
         this.FCampChoose = new TCampChoose(this,this.FNodalModel);
         this.FCampChoose.SlotsOnMove = this.UIComponentsApplianceOnOver;
         this.FCampChoose.SlotsOnOut = this.UIComponentsApplianceOnOut;
         this.FCampChoose.HintOnMove = this.UIComponentsHintOnOver;
         this.FCampChoose.HintOnOut = this.UIComponentsHintOnOut;
         this.FCampChoose.OnHelpTipsOver = this.UIHelpTipsHintOnOver;
         this.FCampChoose.OnHelpTipsOut = this.UIHelpTipsHintOnOut;
         this.FCampChoose.OnEffectText = FOnEffectText;
         ComponentBoundsCenter(this.FMissionChoose,this.FBoundsMission);
         ComponentBoundsCenter(this.FCampChoose,this.FBoundsCamp);
         this.FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_WorldMap);
         this.FOverlayerAppliance.Visible = false;
         this.FOverlayerHint = new TOverlayerHint(this);
         this.FOverlayerHint.visible = false;
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverlayerHelpTips.Visible = false;
         if(this.FScene.mc_autoBattle != null)
         {
            TGameUtil.setButtonMode(this.FScene.mc_autoBattle.btn_look,true);
            this.FScene.mc_autoBattle.btn_look.addEventListener(MouseEvent.CLICK,this.OnLookAutoBattle);
            this.FScene.mc_autoBattle.visible = false;
         }
      }
      
      override protected function ProcessorResize() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc1_ = FUICore.StageWidth;
         if(Boolean(this.FScene) && Boolean(this.FScene.btn_close))
         {
            this.FScene.btn_close.x = _loc1_ - this.FScene.btn_close.width;
         }
      }
      
      protected function OnCloseMap(param1:MouseEvent) : void
      {
         this.Visible = false;
         this.FTargetNodalId = 0;
         SLogicsCore.AutoSearching = false;
         if(this.FOnReturnCityScene != null)
         {
            this.FOnReturnCityScene(this);
         }
      }
      
      protected function OnNodalChoose(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = String(param1.currentTarget.name).slice(0,4);
         if(_loc2_ == "city")
         {
            this.FSelectStatus = SELECT_CITY;
            TutorialNextStep(307);
         }
         else if(_loc2_ == "camp")
         {
            this.FSelectStatus = SELECT_CAMPAIGN;
         }
         else if(_loc2_ == "home")
         {
            this.FSelectStatus = SELECT_HOME;
         }
         this.FTargetCityId = int(String(param1.currentTarget.name).slice(5));
         this.FRole.gotoAndPlay(1);
         this.FRole.x = param1.currentTarget.x;
         this.FRole.y = param1.currentTarget.y;
         this.FTargetNodalId = 0;
         SLogicsCore.AutoSearching = false;
      }
      
      protected function PlayComplete(param1:Event) : void
      {
         if(this.FIsRoleFirstShow)
         {
            this.FIsRoleFirstShow = false;
            return;
         }
         clearTimeout(this.FTimerID);
         if(this.FSelectStatus == SELECT_CITY)
         {
            if(this.FTargetNodalId == 0)
            {
               this.FTargetNodalId = this.FNodalModel.CurMissionID;
            }
            if(this.FTargetNodalId > this.FNodalModel.CurMissionID)
            {
               this.FTargetNodalId = this.FNodalModel.CurMissionID;
            }
            this.FMissionChoose.SetCityID(this.FTargetCityId,this.FNodalModel.CurMissionID,this.FTargetNodalId);
            this.FMissionChoose.Visible = true;
         }
         else if(this.FSelectStatus == SELECT_CAMPAIGN)
         {
            this.MakeCampData(this.FTargetCityId);
            this.FCampChoose.MakeCampData = this.MakeCampData;
            this.FCampChoose.SetCityID(this.FTargetCityId);
            this.FCampChoose.Visible = true;
         }
         else if(this.FSelectStatus == SELECT_HOME)
         {
            if(this.FOnReturnCityScene != null)
            {
               this.FCharacter.TownID = this.FTargetCityId;
               this.FOnReturnCityScene(this);
            }
         }
         this.FSelectStatus = 0;
         this.FTargetCityId = 0;
         this.FTargetNodalId = 0;
      }
      
      protected function WhatFuck() : void
      {
         this.FCampChoose.Updata();
      }
      
      protected function SetGoto() : void
      {
         var _loc1_:TBlockPoint = null;
         if(this.FSelectStatus == SELECT_HOME)
         {
            if(this.FScene["home_" + this.FTargetCityId] != null)
            {
               this.FRole.gotoAndPlay(1);
               this.FRole.x = this.FScene["home_" + this.FTargetCityId].x;
               this.FRole.y = this.FScene["home_" + this.FTargetCityId].y;
            }
         }
         else if(this.FSelectStatus == SELECT_CAMPAIGN)
         {
            if(this.FScene["camp_" + this.FTargetCityId] != null)
            {
               this.FRole.gotoAndPlay(1);
               this.FRole.x = this.FScene["camp_" + this.FTargetCityId].x;
               this.FRole.y = this.FScene["camp_" + this.FTargetCityId].y;
            }
         }
         else if(this.FSelectStatus == SELECT_CITY)
         {
            if(this.FTargetNodalId > this.FNodalModel.CurMissionID)
            {
               this.FTargetNodalId = this.FNodalModel.CurMissionID;
               _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BlockPoint,this.FTargetNodalId) as TBlockPoint;
               this.FTargetCityId = _loc1_.Campaign;
               EffectGenerateText(STRING_WORLDMAP.STRING_NeedCompleteBeforMission);
            }
            if(this.FScene["city_" + this.FTargetCityId] != null)
            {
               this.FRole.gotoAndPlay(1);
               this.FRole.x = this.FScene["city_" + this.FTargetCityId].x;
               this.FRole.y = this.FScene["city_" + this.FTargetCityId].y;
               TutorialNextStep(307);
            }
         }
         this.FIsRoleFirstShow = false;
      }
      
      protected function PacketPerform_SC_StarInfo(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:ByteArray = null;
         _loc6_ = param1.Data;
         _loc5_ = _loc6_.readByte();
         _loc2_ = _loc6_.readByte();
         _loc4_ = _loc6_.readInt();
         _loc3_ = int(_loc6_.readUnsignedInt());
         if(this.FPassNodalWindow == null)
         {
            this.FPassNodalWindow = new TPassNodalWindow(this,CONST_MODULES.MODULE_WorldMap);
            this.FPassNodalWindow.OnEffectText = FOnEffectText;
            this.FPassNodalWindow.EffectGenerateTextByErrorCode = EffectGenerateTextByErrorCode;
         }
         this.FPassNodalWindow.SetPassNodalWindow(_loc2_,_loc4_,_loc5_);
         if(this.FAutoCamp.StatusEnd)
         {
            this.FPassNodalWindow.ShowWindows();
         }
         if(_loc2_ == CONST_BATTLE.BattleType_Nodal)
         {
            this.FNodalModel.SetMissionStarByID(_loc4_,_loc5_);
         }
         else if(_loc2_ == CONST_BATTLE.BattleType_Camp)
         {
            this.FNodalModel.SetCampStarByID(_loc4_,_loc5_);
         }
      }
      
      protected function PacketPerform_SC_Notify(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.UnstreamizerNodal.UnstreamizationCampaign(_loc2_,this.FNodalModel,SResourcesCore.ResourceBin);
         if(Boolean(this.FCampChoose) && this.FCampChoose.visible == true)
         {
            this.FCampChoose.Updata();
         }
      }
      
      protected function OnEndAutoCamp(param1:Object) : void
      {
         if(this.FPassNodalWindow != null)
         {
            this.FPassNodalWindow.ShowWindows();
         }
      }
      
      protected function PacketPerform_SC_PassNodalWindow(param1:TPacket) : void
      {
         if(this.FPassNodalWindow != null)
         {
            this.FPassNodalWindow.PacketProcess(param1);
         }
      }
      
      protected function ProcessorEnterWorldMapReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Enter_WorldMap);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function CheckLevelUpOpenNormalCamp() : uint
      {
         var _loc1_:TCity = null;
         var _loc2_:TSingle = null;
         var _loc3_:int = 0;
         _loc3_ = this.FNodalModel.GetCampaignMaxId() + 1;
         _loc1_ = this.FCityBins.GetDatebaseByIdentifier(_loc3_) as TCity;
         if(_loc1_ == null)
         {
            return null;
         }
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Single,_loc1_.Start) as TSingle;
         if(Boolean(_loc2_) && _loc2_.Level <= this.FCharacter.MainHero.Level)
         {
            return _loc3_;
         }
         return 0;
      }
      
      protected function UpdataMapUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DisplayObject = null;
         var _loc3_:TBlockPoint = null;
         var _loc4_:TCity = null;
         this.CheckOpenNodalCamp();
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BlockPoint,this.FNodalModel.CurMissionID) as TBlockPoint;
         _loc1_ = int(CONST_CAMPAIGN.Start_NodalId);
         while(_loc1_ <= _loc3_.Campaign)
         {
            _loc2_ = this.FScene["city_" + _loc1_];
            if(_loc2_ != null)
            {
               _loc2_.visible = true;
               this.FScene["level_" + _loc1_].visible = true;
            }
            _loc1_++;
         }
         _loc1_ = int(CONST_CAMPAIGN.Start_CAMPId);
         while(_loc1_ <= CONST_CAMPAIGN.End_CAMPId)
         {
            if(this.FNodalModel.GetCampaignByIndex(_loc1_) != null)
            {
               _loc2_ = this.FScene["camp_" + _loc1_];
               if(_loc2_ != null)
               {
                  _loc2_.visible = true;
                  _loc4_ = this.FCityBins.GetDatebaseByIdentifier(_loc1_) as TCity;
                  this.FScene["level_" + _loc4_.Start].visible = true;
               }
            }
            _loc1_++;
         }
         this.FScene.mc_citySign.x = this.FScene["city_" + _loc3_.Campaign].x;
         this.FScene.mc_citySign.y = this.FScene["city_" + _loc3_.Campaign].y;
         this.FScene.mc_citySign.play();
         this.CheckShowIcon();
         this.PlayMovie();
      }
      
      protected function CheckShowIcon() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:DisplayObject = null;
         var _loc3_:TConfigValue = null;
         var _loc4_:TCampaign = null;
         var _loc5_:TCity = null;
         var _loc6_:TSingle = null;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.CONST_SHOWMAINCITY_QUEST_ID) as TConfigValue;
         if(this.FCharacter.MainQuestComplete.GetQuestByIdentifier(int(_loc3_.Value)) == null)
         {
            this.FScene["home_" + CONST_CAMPAIGN.End_HomeId].visible = false;
         }
         else
         {
            this.FScene["home_" + CONST_CAMPAIGN.End_HomeId].visible = true;
         }
         _loc1_ = CONST_CAMPAIGN.Start_CAMPId;
         while(_loc1_ <= CONST_CAMPAIGN.End_CAMPId)
         {
            _loc2_ = this.FScene["camp_" + _loc1_];
            if(_loc2_ != null)
            {
               _loc5_ = this.FCityBins.GetDatebaseByIdentifier(_loc1_) as TCity;
               _loc6_ = this.FSingleBins.GetDatebaseByIdentifier(_loc5_.Start) as TSingle;
               if(_loc6_.Level <= this.FCharacter.MainHero.Level)
               {
                  _loc4_ = this.FNodalModel.GetCampaignByIndex(_loc1_);
                  if(_loc4_ == null)
                  {
                     this.MakeCampData(_loc1_);
                  }
                  this.FScene["level_" + _loc5_.Start].visible = true;
                  _loc2_.visible = true;
               }
               else
               {
                  this.FScene["level_" + _loc5_.Start].visible = false;
                  _loc2_.visible = false;
               }
            }
            _loc1_++;
         }
      }
      
      protected function PlayMovie(param1:Boolean = true) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = 0;
         while(_loc2_ < COUNT_Movie)
         {
            if(param1)
            {
               this.FScene.mc_movie["movie_" + _loc2_].play();
            }
            else
            {
               this.FScene.mc_movie["movie_" + _loc2_].stop();
            }
            _loc2_++;
         }
      }
      
      protected function UIComponentsApplianceOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         _loc3_ = param2 as TInventory;
         if(this.FOverlayerAppliance != null)
         {
            this.FOverlayerAppliance.Context = _loc3_;
            this.FOverlayerAppliance.Render(FUICore.MouseCoordinate);
            this.FOverlayerAppliance.Show();
         }
      }
      
      protected function UIComponentsApplianceOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         _loc3_ = param1 as TInventory;
         if(this.FOverlayerAppliance != null)
         {
            this.FOverlayerAppliance.Hide();
         }
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.visible = true;
      }
      
      protected function UIComponentsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHint.visible = false;
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
      
      protected function OpenAutoInfo(param1:uint, param2:int = 0) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TEnemyArmy = null;
         var _loc7_:TEnemy = null;
         var _loc8_:TBlockPoint = null;
         var _loc9_:Dictionary = null;
         var _loc10_:Dictionary = null;
         var _loc11_:uint = 0;
         var _loc12_:TMonster = null;
         var _loc13_:String = null;
         if(Boolean(this.FAutoMission) && this.FAutoMission.IsAutoBattle)
         {
            EffectGenerateText(STRING_WORLDMAP.STRINGS_AutoBattle);
            return;
         }
         _loc8_ = this.FBlockPointBins.GetDatebaseByIdentifier(param1) as TBlockPoint;
         this.FNodalAutoMonsterInfo.HootMonster.length = 0;
         this.FNodalAutoMonsterInfo.CurAutoMissionId = param1;
         this.FNodalAutoMonsterInfo.CurAutoCityId = param2;
         this.FNodalAutoMonsterInfo.CostTime = 180;
         _loc9_ = new Dictionary(true);
         _loc10_ = new Dictionary(true);
         _loc3_ = 0;
         while(_loc3_ < _loc8_.Armys.length)
         {
            _loc5_ = _loc8_.Armys[_loc3_];
            _loc6_ = this.FEnemyArmyBins.GetDatebaseByIdentifier(_loc5_) as TEnemyArmy;
            _loc4_ = 0;
            while(_loc4_ < _loc6_.EnemyIdVect.length)
            {
               _loc11_ = _loc6_.EnemyIdVect[_loc4_];
               _loc7_ = this.FEnemyBins.GetDatebaseByIdentifier(_loc11_) as TEnemy;
               if(_loc9_[_loc11_] == null)
               {
                  _loc9_[_loc11_] = 1;
                  _loc10_[_loc11_] = _loc7_.Level;
               }
               else
               {
                  _loc9_[_loc11_] += 1;
               }
               _loc4_++;
            }
            _loc3_++;
         }
         for(_loc13_ in _loc9_)
         {
            _loc12_ = this.FPoolCampaign.AcquireMonster(int(_loc13_));
            _loc12_.MonsterLevel = _loc10_[_loc13_];
            _loc12_.MonsterCount = _loc9_[_loc13_];
            this.FNodalAutoMonsterInfo.HootMonster.push(_loc12_);
         }
         if(this.FAutoMission == null)
         {
            this.FAutoMission = new TAutoNodal(this);
            this.FAutoMission.OnCheckTask = this.FOnCheckTask;
            this.FAutoMission.OnEffectText = FOnEffectText;
            this.FAutoMission.OnTurnBackWorldMap = this.FOnAutoBattleMainUISet;
            this.FAutoMission.OnSmallAutoBattle = this.OnSmallAutoBattle;
            this.FAutoMission.OnNotifyMainSceneIntoAutoBattle = this.FOnNotifyMainSceneIntoAutoBattle;
            ComponentBoundsCenter(this.FAutoMission,this.FBoundsAutoMission);
         }
         this.FAutoMission.OpenWindow(this.FNodalAutoMonsterInfo);
         this.FMissionChoose.Visible = false;
         if(this.FOnAutoBattleMainUISet != null)
         {
            this.FOnAutoBattleMainUISet(this,true);
         }
         if(this.FScene.mc_autoBattle != null)
         {
            this.FScene.mc_autoBattle.visible = false;
         }
      }
      
      protected function OnSmallAutoBattle(param1:Object) : void
      {
         if(this.FAutoMission != null)
         {
            this.FAutoMission.visible = false;
         }
         if(this.FScene.mc_autoBattle != null)
         {
            this.FScene.mc_autoBattle.visible = true;
         }
      }
      
      protected function OnLookAutoBattle(param1:MouseEvent = null) : void
      {
         if(this.FAutoMission != null)
         {
            this.FAutoMission.visible = true;
         }
         if(this.FScene.mc_autoBattle != null)
         {
            this.FScene.mc_autoBattle.visible = false;
         }
      }
      
      protected function MakeCampData(param1:int) : void
      {
         var _loc2_:TSinglePointPath = null;
         var _loc3_:TCity = null;
         var _loc4_:TCampaign = null;
         var _loc5_:TSingle = null;
         var _loc6_:TItem = null;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(this.FNodalModel.GetCampaignById(param1) != null)
         {
            return;
         }
         _loc3_ = this.FCityBins.GetDatebaseByIdentifier(param1) as TCity;
         _loc4_ = this.FPoolCampaign.AcquireCampaign(param1);
         _loc4_.Diffculty = -1;
         _loc4_.LayerIndex = 0;
         _loc4_.EnemyIndex = 0;
         _loc4_.EnterCount = 0;
         _loc4_.ResetCount = 1;
         _loc7_ = uint(_loc3_.Start);
         _loc5_ = this.FSingleBins.GetDatebaseByIdentifier(_loc7_) as TSingle;
         _loc8_ = int(_loc5_.Awards.length);
         _loc4_.OpenLevel = _loc5_.Level;
         _loc9_ = 0;
         while(_loc9_ < _loc8_)
         {
            if(_loc4_.NormalDropItems.GetItemById(_loc5_.Awards[_loc9_]) == null)
            {
               _loc6_ = this.FPoolItem.AcquireItem();
               _loc6_.Type = 1;
               _loc6_.ID = _loc5_.Awards[_loc9_];
               _loc6_.Count = 1;
               _loc4_.NormalDropItems.Add(_loc6_);
            }
            _loc9_++;
         }
         _loc9_ = int(_loc5_.StartId);
         while(_loc9_ <= _loc5_.EndId)
         {
            _loc2_ = this.FSinglePointPath.GetDatebaseByIdentifier(_loc9_) as TSinglePointPath;
            if(_loc4_.GetEnemyByIndex(TCampaign.Type_Noraml,_loc2_.Armys) <= 0)
            {
               _loc4_.NormalEnemy.push(_loc2_.Armys);
            }
            _loc9_++;
         }
         _loc4_.NormalCampId = _loc7_;
         _loc7_ = uint(_loc3_.Last);
         _loc5_ = this.FSingleBins.GetDatebaseByIdentifier(_loc7_) as TSingle;
         _loc8_ = int(_loc5_.Awards.length);
         _loc9_ = 0;
         while(_loc9_ < _loc8_)
         {
            if(_loc4_.HardDropItems.GetItemById(_loc5_.Awards[_loc9_]) == null)
            {
               _loc6_ = this.FPoolItem.AcquireItem();
               _loc6_.Type = 1;
               _loc6_.ID = _loc5_.Awards[_loc9_];
               _loc6_.Count = 1;
               _loc4_.HardDropItems.Add(_loc6_);
            }
            _loc9_++;
         }
         _loc9_ = int(_loc5_.StartId);
         while(_loc9_ <= _loc5_.EndId)
         {
            _loc2_ = this.FSinglePointPath.GetDatebaseByIdentifier(_loc9_) as TSinglePointPath;
            if(_loc4_.GetEnemyByIndex(TCampaign.Type_Hard,_loc2_.Armys) <= 0)
            {
               _loc4_.HardEnemy.push(_loc2_.Armys);
            }
            _loc9_++;
         }
         _loc4_.HardCampId = _loc7_;
         _loc4_.IsInit = true;
         this.FNodalModel.AddCampaign(_loc4_);
      }
      
      public function get OnReturnCityScene() : Function
      {
         return this.FOnReturnCityScene;
      }
      
      public function set OnReturnCityScene(param1:Function) : void
      {
         this.FOnReturnCityScene = param1;
      }
      
      public function get OnCheckTask() : Function
      {
         return this.FOnCheckTask;
      }
      
      public function set OnCheckTask(param1:Function) : void
      {
         this.FOnCheckTask = param1;
      }
      
      public function get AddPopTips() : Function
      {
         return this.FAddPopTips;
      }
      
      public function set AddPopTips(param1:Function) : void
      {
         this.FAddPopTips = param1;
      }
      
      public function get OnNotifyMainSceneIntoAutoBattle() : Function
      {
         return this.FOnNotifyMainSceneIntoAutoBattle;
      }
      
      public function set OnNotifyMainSceneIntoAutoBattle(param1:Function) : void
      {
         this.FOnNotifyMainSceneIntoAutoBattle = param1;
      }
      
      public function get OnAutoBattleMainUISet() : Function
      {
         return this.FOnAutoBattleMainUISet;
      }
      
      public function set OnAutoBattleMainUISet(param1:Function) : void
      {
         this.FOnAutoBattleMainUISet = param1;
      }
      
      public function get OnEnterWorldMap() : Function
      {
         return this.FOnEnterWorldMap;
      }
      
      public function set OnEnterWorldMap(param1:Function) : void
      {
         this.FOnEnterWorldMap = param1;
      }
      
      override public function ChatOptionsSetup(param1:TChatOptions) : void
      {
         param1.ChatStatus = CONST_CHAT.MODE_Hidden;
      }
      
      public function Enter(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = param1.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.UnstreamizerNodal.Unstreamize(param1,this.FNodalModel,SResourcesCore.ResourceBin);
      }
      
      public function SetGotoTarget(param1:uint, param2:uint, param3:uint = 0, param4:Boolean = false) : void
      {
         this.FSelectStatus = param1;
         this.FTargetCityId = param2;
         this.FTargetNodalId = param3;
         if(param4)
         {
            this.SetGoto();
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         var MainUISet:Function;
         var Data:ByteArray = null;
         var Stream:ByteArray = param1;
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FCharacter.RoleSencePosition = CONST_COMMON.SCENEPOSITION_WORLDMAP;
         this.CheckShowIcon();
         if(this.FIsInit)
         {
            if(this.FRole != null)
            {
               clearTimeout(this.FTimerID);
               this.FTimerID = setTimeout(this.SetGoto,500);
               if(this.FTargetCityId == 0)
               {
                  this.FTargetCityId = this.FCharacter.TownID;
                  this.FRole.x = this.FScene["home_" + this.FTargetCityId].x;
                  this.FRole.y = this.FScene["home_" + this.FTargetCityId].y;
               }
               if(this.FMissionChoose)
               {
                  this.FMissionChoose.HideScene();
               }
               if(Boolean(this.FCampChoose) && this.FCampChoose.Visible == true)
               {
                  this.FCampChoose.Visible = false;
               }
            }
            this.UpdataMapUI();
            this.FScene.visible = true;
            if(Boolean(this.FAutoMission) && this.FAutoMission.IsAutoBattle)
            {
               MainUISet = function():void
               {
                  if(FOnAutoBattleMainUISet != null)
                  {
                     FOnAutoBattleMainUISet(this,true);
                  }
               };
               this.OnLookAutoBattle();
               setTimeout(MainUISet,150);
            }
            return;
         }
         if(Stream != null)
         {
            this.PacketPerform_SC_WorldMapInfo(Stream);
            if(this.FAutoMissionId != 0)
            {
               this.OpenAutoInfo(this.FAutoMissionId);
               this.FAutoMissionId = 0;
               this.FAutoMission.ContinueAutoBattleCount(this.FAutoCount,this.FStartTime,this.FIsFast);
            }
            if(this.FAutoByteArray != null)
            {
               this.FAutoByteArray.position = 0;
               this.FAutoMission.ContinueAutoBattle(this.FAutoByteArray);
               this.FAutoByteArray = null;
            }
            return;
         }
         this.ProcessorEnterWorldMapReq();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         if(this.FScene)
         {
            this.FScene.visible = false;
            this.PlayMovie(false);
         }
      }
      
      public function OnEnterAutoBattle(param1:Object) : void
      {
         this.OnLookAutoBattle();
      }
      
      public function CheckOpenNodalCamp() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TBlockPoint = null;
         var _loc3_:TBlockPoint = null;
         var _loc4_:uint = 0;
         var _loc5_:Boolean = false;
         if(!this.FIsInit)
         {
            return;
         }
         _loc5_ = false;
         if(this.FNodalModel.GetMissionStarByID(this.FNodalModel.CurMissionID) > 0)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BlockPoint,this.FNodalModel.CurMissionID) as TBlockPoint;
            _loc4_ = uint(_loc2_.NextPoint);
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BlockPoint,_loc4_) as TBlockPoint;
            if(_loc3_ != null)
            {
               if(this.FCharacter.GetMainHeroLogicLevel(this.FCharacter.GetMainLevel()) >= _loc3_.Level)
               {
                  if(this.FNodalModel.CurMissionID != _loc4_)
                  {
                     this.FNodalModel.CurMissionID = _loc4_;
                     _loc5_ = true;
                  }
               }
            }
         }
         _loc1_ = this.CheckLevelUpOpenNormalCamp();
         if(_loc1_ != 0)
         {
            this.MakeCampData(_loc1_);
            _loc5_ = true;
         }
         if(_loc5_)
         {
            this.UpdataMapUI();
         }
      }
      
      override public function ShortcutModesSetup(param1:TLobbyShortcutModes) : void
      {
         var _loc2_:TLobbyShortcutQuestGuideModes = null;
         super.ShortcutModesSetup(param1);
         if(param1 is TLobbyShortcutQuestGuideModes)
         {
            _loc2_ = param1 as TLobbyShortcutQuestGuideModes;
            _loc2_.ShortcutMode = TLobbyShortcutMode.SHORTCUTMODE_Show;
         }
      }
   }
}

