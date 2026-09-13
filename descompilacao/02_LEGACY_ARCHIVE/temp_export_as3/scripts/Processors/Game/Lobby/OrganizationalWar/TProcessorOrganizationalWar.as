package Processors.Game.Lobby.OrganizationalWar
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.DatebaseVO.VO.TOrganizationBase;
   import Logics.OrganizationalWar.*;
   import Logics.Streamization.OrganizationalWar.*;
   import Logics.TimeCoolDown.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Common.Shortcuts.*;
   import Processors.Game.Lobby.MainScene.Role.*;
   import Processors.Game.Windows.Information.*;
   import Rendering.Overlayers.HelpTips.*;
   import Rendering.Overlayers.Hints.*;
   import Resources.Constants.*;
   import Resources.Strings.STRING_ORGANIZATIONALWAR;
   import Utilities.UI.Overlayers.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.utils.*;
   
   public class TProcessorOrganizationalWar extends TProcessorLobbyPlate
   {
      
      protected var FGoalData:TOrganizationalWarGoalData;
      
      protected var FWindowOrganizationalWar:TProcessorWindowOrganizationalWar;
      
      protected var FWindowOrganizationalWarBattleScene:TProcessorWindowOrganizationalWarScene;
      
      protected var FUnstreamizerOrganizationalWar:TUnstreamizerOrganizationalWar;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FCommandCallBack:Function;
      
      protected var FActivityStatusCallBack:Function;
      
      protected var FWaitBack:Boolean;
      
      protected var FOnEnterTown:Function;
      
      protected var FBackToMainTown:Function;
      
      protected var FUpdateReturnHomePanel:Function;
      
      protected var FGetOrganizationalName:Function;
      
      protected var FGetOrgainizatinoLevel:Function;
      
      public function TProcessorOrganizationalWar(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FGoalData = new TOrganizationalWarGoalData();
         this.FWindowOrganizationalWar = new TProcessorWindowOrganizationalWar(this,param2);
         this.FWindowOrganizationalWarBattleScene = new TProcessorWindowOrganizationalWarScene(this);
         this.FUnstreamizerOrganizationalWar = new TUnstreamizerOrganizationalWar();
         this.FWindowOrganizationalWarBattleScene.GoalData = this.FGoalData;
         this.FWindowOrganizationalWar.GoalData = this.FGoalData;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_ORGANIZATIONALWAR.RESOURCESID_Swf_OrganizationalWar);
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_ORGANIZATIONALWAR.RESOURCESID_Swf_OrganizationalWarRole);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:MovieClip = null;
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance("OrganizationalWar") as MovieClip;
         addChild(_loc1_);
         this.FWindowOrganizationalWar.UIDispatch(_loc1_);
         this.FWindowOrganizationalWar.CommandRequet = this.CommandRequest;
         addChild(this.FWindowOrganizationalWar);
         this.FWindowOrganizationalWar.OnHintOver = this.UIComponentsOnOver;
         this.FWindowOrganizationalWar.OnHintOut = this.UIComponentsOnOut;
         this.FWindowOrganizationalWar.OnEffectText = OnEffectText;
         this.FWindowOrganizationalWar.GobackCity = this.BackToMainSceneRequest;
         this.FWindowOrganizationalWar.OnHelpTipsOver = this.UIHelpTipsHintOnOver;
         this.FWindowOrganizationalWar.OnHelpTipsOut = this.UIHelpTipsHintOnOut;
         this.FWindowOrganizationalWarBattleScene.UIDispatch(_loc1_);
         this.FWindowOrganizationalWarBattleScene.CommandRequest = this.CommandRequest;
         addChild(this.FWindowOrganizationalWarBattleScene);
         this.FWindowOrganizationalWarBattleScene.OnEffectText = OnEffectText;
         this.FWindowOrganizationalWarBattleScene.OnHintOver = this.UIComponentsOnOver;
         this.FWindowOrganizationalWarBattleScene.OnHintOut = this.UIComponentsOnOut;
         FParameters.MountPointWindow.addChild(_loc1_["RemindTime"]);
         this.FUIWindowConfirmation = new TUIWindowConfirmation(parent.parent as TUIComponent);
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FOverlayerHint = new TOverlayerHint(this);
         this.FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.LoadOrganizationalWarDeplayTable();
         this.FWindowOrganizationalWar.UILocations();
         this.FWindowOrganizationalWarBattleScene.UILocations();
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_OrganizationWar_CommandRet,this.PerformPacket_SC_CommandRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_OrganizationWar_AddNewRoleRet,this.PerformPacket_SC_AddNewRoleRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_OrganizationWar_RoleQuit,this.PerformPacket_SC_RoleQuit);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_OrganizationWar_RoleEnterQueue,this.PerformPacket_SC_RoleEnterQueue);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_OrganizationWar_FightDataRet,this.PerformPacket_SC_FightDataRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_OrganizationWar_RankInforRet,this.PerformPacket_SC_RankInforRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_OrganizationWar_BattleReportRet,this.PerformPacket_SC_BattleReportRet);
      }
      
      protected function PerformPacket_SC_CommandRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         this.FWaitBack = false;
         _loc2_ = param1.Data.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc3_ = param1.Data.readUnsignedInt();
         _loc4_ = int(param1.Data.readUnsignedInt());
         if(_loc3_ == CONST_ORGANIZATIONALWAR.CommandID_SignUp)
         {
            if(this.FActivityStatusCallBack != null)
            {
               this.FActivityStatusCallBack(this,CONST_ORGANIZATION.TYPE_ORGACTIVITY_MUYEBATTLE,_loc4_);
            }
         }
         if(this.FCommandCallBack != null)
         {
            this.FCommandCallBack(_loc4_);
            this.FCommandCallBack = null;
         }
      }
      
      protected function PerformPacket_SC_AddNewRoleRet(param1:TPacket) : void
      {
         this.FWindowOrganizationalWarBattleScene.AddNewRole(param1);
      }
      
      protected function PerformPacket_SC_RoleQuit(param1:TPacket) : void
      {
         this.FWindowOrganizationalWarBattleScene.RoleQuit(param1);
      }
      
      protected function PerformPacket_SC_RoleEnterQueue(param1:TPacket) : void
      {
         this.FWindowOrganizationalWarBattleScene.RoleEnterQueue(param1);
      }
      
      protected function PerformPacket_SC_FightDataRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         _loc2_ = param1.Data.readUnsignedInt();
         _loc3_ = param1.Data.readUnsignedInt();
         _loc4_ = param1.Data.readUnsignedInt();
         _loc5_ = param1.Data.readUnsignedInt();
         _loc6_ = int(param1.Data.readUnsignedByte());
         this.FWindowOrganizationalWarBattleScene.RoleFight(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_);
      }
      
      protected function PerformPacket_SC_RankInforRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TRankInfor = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc2_ = param1.Data;
         this.FGoalData.PlayerRecord = _loc2_.readUnsignedInt();
         this.FGoalData.PlayerRank = _loc2_.readUnsignedInt();
         this.FGoalData.OrganizationRecord = _loc2_.readUnsignedInt();
         this.FGoalData.OrganizationRank = _loc2_.readUnsignedInt();
         _loc4_ = int(_loc2_.readUnsignedShort());
         this.FGoalData.PlayerRankActiveNum = _loc4_;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FGoalData.PlayerRankInfors[_loc3_];
            _loc5_.RankID = _loc3_;
            _loc6_ = _loc2_.readUnsignedInt();
            _loc7_ = _loc2_.readUnsignedInt();
            _loc5_.Describtion = this.GetRoleNameByID(_loc6_,_loc7_);
            _loc5_.KeyValue = _loc2_.readUnsignedInt();
            _loc3_++;
         }
         _loc4_ = int(_loc2_.readUnsignedShort());
         this.FGoalData.OrganizationRankActiveNum = _loc4_;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FGoalData.OrganizationRankInfors[_loc3_];
            _loc5_.RankID = _loc3_;
            _loc6_ = _loc2_.readUnsignedInt();
            _loc5_.Describtion = this.GetOrganizationNameByID(_loc6_);
            _loc5_.KeyValue = _loc2_.readUnsignedInt();
            _loc3_++;
         }
      }
      
      protected function PerformPacket_SC_BattleReportRet(param1:TPacket) : void
      {
         this.FWindowOrganizationalWar.BattleReport(param1);
      }
      
      protected function EnterOrganizatinoalWarScene(param1:ByteArray) : void
      {
         var _loc2_:TTimeCoolDown = null;
         var _loc3_:Date = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:TBins = null;
         var _loc8_:TOrganizationBase = null;
         if(param1 == null)
         {
            return;
         }
         this.FGoalData.SystemColdDownTime = param1.readUnsignedInt();
         _loc2_ = SLogicsCore.Character.TimeCoolDowns.GetDigestByIdentifier(CONST_COMMON.TIME_COOLDOWN_OrganizationalWar_SystemColdTime);
         _loc2_.TimingTime = this.FGoalData.SystemColdDownTime;
         if(this.FGetOrgainizatinoLevel != null)
         {
            _loc5_ = this.FGetOrgainizatinoLevel(CONST_ORGANIZATION.TYPE_ORGACTIVITY_MUYEBATTLE);
         }
         _loc7_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_OrganizationBase);
         _loc4_ = uint(_loc7_.Count);
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc8_ = _loc7_.GetDatebaseByIndex(_loc6_) as TOrganizationBase;
            if(_loc8_.OrgLevel == _loc5_)
            {
               this.FGoalData.OrganizationAdded = _loc8_.MuyebattleUpgradeAddition;
               break;
            }
            _loc6_++;
         }
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
            _loc5_.ShortcutModeOrganiZation = TLobbyShortcutMode.SHORTCUTMODE_Show;
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
            _loc5_.ShortcutModeReturn = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutMapModes)
         {
            _loc6_ = param1 as TLobbyShortcutMapModes;
            _loc6_.ShortcutModeMap = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc6_.ShortcutModeReturnHome = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc6_.ShortcutModeAutoBattle = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
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
      
      protected function GetRoleNameByID(param1:uint, param2:uint) : String
      {
         var _loc3_:String = null;
         var _loc4_:TUIOrganizationalWarPlayer = null;
         _loc3_ = "";
         _loc4_ = this.FGoalData.OrganizationRole.GetRoleByIdentifier(param1,param2);
         if(_loc4_ != null)
         {
            _loc3_ = _loc4_.RoleData.Name;
         }
         return _loc3_;
      }
      
      protected function GetOrganizationNameByID(param1:uint) : String
      {
         var _loc2_:String = null;
         var _loc3_:TPacket = null;
         if(this.FGetOrganizationalName != null)
         {
            _loc2_ = this.FGetOrganizationalName(this,param1);
            if(_loc2_ != null)
            {
               return _loc2_;
            }
            this.RequestOrganizationalName();
         }
         return "";
      }
      
      protected function RequestOrganizationalName() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_LoadGulidListReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function BackToMainSceneRequest(param1:Object) : void
      {
         if(this.FOnEnterTown != null)
         {
            this.FOnEnterTown(this);
         }
      }
      
      protected function UIComponentsOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      protected function UIComponentsOnOut(param1:Object) : void
      {
         this.FOverlayerHint.Hide();
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
      
      public function set OnEnterTown(param1:Function) : void
      {
         this.FOnEnterTown = param1;
      }
      
      public function set BackToMainTown(param1:Function) : void
      {
         this.FBackToMainTown = param1;
      }
      
      public function set UpdateReturnHomePanel(param1:Function) : void
      {
         this.FWindowOrganizationalWar.UpdateReturnHomePanel = param1;
      }
      
      public function get GetOrganizationalName() : Function
      {
         return this.FGetOrganizationalName;
      }
      
      public function set GetOrganizationalName(param1:Function) : void
      {
         this.FGetOrganizationalName = param1;
      }
      
      public function set SetDailyActivityStatus(param1:Function) : void
      {
         this.FWindowOrganizationalWarBattleScene.SetDailyActivityStatus = param1;
      }
      
      public function get ActivityStatusCallBack() : Function
      {
         return this.FActivityStatusCallBack;
      }
      
      public function set ActivityStatusCallBack(param1:Function) : void
      {
         this.FActivityStatusCallBack = param1;
      }
      
      public function set GetOrgainizatinoLevel(param1:Function) : void
      {
         this.FGetOrgainizatinoLevel = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         this.EnterOrganizatinoalWarScene(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.CommandRequest(CONST_ORGANIZATIONALWAR.CommandID_RequestInfor,0,null);
         this.RequestOrganizationalName();
         this.FWaitBack = false;
         this.FGoalData.Running = true;
         SLogicsCore.Character.RoleSencePosition = CONST_COMMON.SCENEPOSITION_OrganizationWar;
         this.FWindowOrganizationalWar.visible = true;
         this.FWindowOrganizationalWarBattleScene.visible = true;
         this.FWindowOrganizationalWarBattleScene.ContorlBirthPlace(true);
      }
      
      override public function Unmount() : void
      {
         this.FWindowOrganizationalWarBattleScene.ContorlBirthPlace(false);
         this.FWindowOrganizationalWar.Reset();
      }
      
      public function CommandRequest(param1:uint, param2:uint, param3:Function) : void
      {
         var _loc4_:TPacket = null;
         this.FCommandCallBack = param3;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_OrganizationWar_CommandReq);
         _loc4_.Data.writeUnsignedInt(param1);
         _loc4_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      public function LoadOrganizationalWarDeplayTable() : void
      {
         this.FUnstreamizerOrganizationalWar.Unstreamize(null,this.FGoalData,null);
      }
      
      public function BackToMainSceneConfir() : void
      {
         this.FUIWindowConfirmation.OnOK = this.BackToMainSceneRequest;
         this.FUIWindowConfirmation.visible = true;
         this.FUIWindowConfirmation.Text = STRING_ORGANIZATIONALWAR.STRING_OutOrganizationalWar;
      }
   }
}

