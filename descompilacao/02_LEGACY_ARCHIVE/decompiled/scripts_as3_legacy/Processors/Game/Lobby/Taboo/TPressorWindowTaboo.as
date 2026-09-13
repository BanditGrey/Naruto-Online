package Processors.Game.Lobby.Taboo
{
   import Components.Standard.TUITab;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.Json.TDailyTaskReward;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TTabooAddition;
   import Logics.DatebaseVO.VO.TTabooBattle;
   import Logics.DatebaseVO.VO.TTabooBattleConfig;
   import Logics.DatebaseVO.VO.TTabooConfig;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Taboo.TUnstreamizerTaboo;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Taboo.Data.TabooData;
   import Processors.Game.Lobby.Taboo.Data.TabooDataCell;
   import Processors.Game.Lobby.Taboo.panel.*;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.Inventories.TOverlayerApplianceCopy;
   import Rendering.Overlayers.Taboo.TOverTabooStringTip;
   import Rendering.Overlayers.Taboo.TOverThreeOverTip;
   import Rendering.Overlayers.Taboo.TTabooTip;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TABOO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TABOO;
   import Resources.Strings.STRING_TALISMAN;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TPressorWindowTaboo extends TProcessorLobbyWindows
   {
      
      protected var MainPanel:Sprite = null;
      
      protected var FUnstreamizerTaboo:TUnstreamizerTaboo = null;
      
      protected var FTabooData:TabooData = null;
      
      protected var FTabooPractice:TProcessorWindowTabooPractice = null;
      
      protected var FTabooBackpack:TProcessorWindowTabooBackpack = null;
      
      protected var FTabooSynthesis:TProcessorWindowTabooSynthesis = null;
      
      protected var FTProcessorInherit:TProcessorWindowInherit = null;
      
      public var FTProcessorTa:TProcessorWindowTa = null;
      
      protected var FTProcessorCustoms:TProcessorWindowCustoms = null;
      
      protected var FTProcessorChange:TProcessorWindowChange = null;
      
      protected var FTProcessorLog:TProcessorSeventhEveningLog = null;
      
      protected var FUITab:TUITab;
      
      protected var FCurSynthesisData:TabooDataCell;
      
      protected var FBtn_Close:SimpleButton = null;
      
      protected var GoToFire:MovieClip = null;
      
      protected var FStringTip:TOverTabooStringTip;
      
      protected var FThreeTip:TOverThreeOverTip;
      
      protected var FTabooTip:TTabooTip = null;
      
      protected var FIsInitilization:Boolean;
      
      protected var FCurTabIndex:int;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var Lhero:THero;
      
      protected var Rhero:THero;
      
      protected var FCurState:Boolean;
      
      protected var ResetArr:Vector.<uint>;
      
      protected var FEffectsBaseGlowBtn:TEffectBaseGlow;
      
      protected var FMC_Ear_0:MovieClip = null;
      
      protected var FMC_Ear_1:MovieClip = null;
      
      protected var CurIndex:int;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      public function TPressorWindowTaboo(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerTaboo = new TUnstreamizerTaboo();
         this.FTabooData = SLogicsCore.TBooData;
         this.FTabooPractice = new TProcessorWindowTabooPractice(this);
         this.FTabooPractice.SlotsOnMove = this.UIComponentsApplianceOnOver;
         this.FTabooPractice.SlotsOnOut = this.UIComponentsApplianceOnOut;
         this.FTabooPractice.SeeTaboo = this.S_C_SeeTaboo;
         this.FTabooPractice.FunMove = this.FunMove;
         this.FTabooPractice.FunOut = this.FunOut;
         this.FTabooPractice.FunOver = this.FunOver;
         this.FTabooPractice.SevenFunOver = this.SevenFunOver;
         this.FTabooPractice.SevenFunMove = this.SevenFunMove;
         this.FTabooPractice.SevenFunOut = this.SevenFunOut;
         this.FTabooPractice.InheritFun = this.InheritBtnClick;
         this.FTabooBackpack = new TProcessorWindowTabooBackpack(this);
         this.FTabooBackpack.SlotsOnMove = this.UIComponentsApplianceOnOver;
         this.FTabooBackpack.SlotsOnOut = this.UIComponentsApplianceOnOut;
         this.FTabooSynthesis = new TProcessorWindowTabooSynthesis(this);
         this.FTabooSynthesis.SlotsOnMove = this.UIComponentsApplianceOnOver;
         this.FTabooSynthesis.SlotsOnOut = this.UIComponentsApplianceOnOut;
         this.FTabooSynthesis.MakeFun = this.S_C_MakeFun;
         this.FTProcessorInherit = new TProcessorWindowInherit(param1);
         this.FTProcessorInherit.BInheritFun = this.S_C_Inherit;
         this.FTProcessorInherit.BackFun = this.UpdatePrice;
         this.FTProcessorTa = new TProcessorWindowTa(param1);
         this.FTProcessorTa.GoTo_TabooFun = this.GoTo_Taboo;
         this.FTProcessorTa.SevenScreenClick = this.SevenScreenClick;
         this.FTProcessorTa.AddTimesCS = this.AddTimesCS;
         this.FTProcessorTa.ClosThisPanel = this.CloseClick;
         this.FTProcessorCustoms = new TProcessorWindowCustoms(param1);
         this.FTProcessorCustoms.FirebtnBack = this.FirebtnBack;
         this.FTProcessorCustoms.CloseBackFun = this.GoToFireBtn;
         this.FTProcessorCustoms.ChangeBtn = this.ChangeBtn;
         this.FTProcessorCustoms.GetTongGuanReward = this.GetTongGuanReward;
         this.FTProcessorCustoms.AutoFightFun = this.AutoFightFun;
         this.FTProcessorCustoms.FireBtnTipFunOver = this.FireBtnTipFunOver;
         this.FTProcessorCustoms.FireBtnTipFunOut = this.FireBtnTipFunOut;
         this.FTProcessorCustoms.FireBtnTipFunMove = this.FunMove;
         this.FTProcessorCustoms.AutoFightBtnTipM = this.AutoFightBtnTipM;
         this.FTProcessorCustoms.AutoFightBtnTipO = this.AutoFightBtnTipO;
         this.FTProcessorChange = new TProcessorWindowChange(param1);
         this.FTProcessorChange.SlotsOnMove = this.UIComponentsApplianceOnOver;
         this.FTProcessorChange.SlotsOnOut = this.UIComponentsApplianceOnOut;
         this.FTProcessorChange.BtnBackFun = this.BtnBackFun;
         this.FTProcessorLog = new TProcessorSeventhEveningLog(param1);
         this.FTProcessorLog.BackFun = this.LogBackFun;
         this.FUITab = new TUITab(this);
         SetUIModuleID(CONST_MODULES.MODULE_Taboo);
      }
      
      protected function UpdatePrice() : void
      {
         this.FTabooPractice.UPudatePrice();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TABOO.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.MainPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_TABOO.MainPanelName) as Sprite;
         addChild(this.MainPanel);
         this.MainPanel.x = (FUICore.StageWidth - this.MainPanel.width) / 2;
         this.MainPanel.y = (FUICore.StageHeight - this.MainPanel.height) / 2;
         this.FMC_Ear_0 = this.MainPanel["MC_Ear_0"];
         this.FMC_Ear_1 = this.MainPanel["MC_Ear_1"];
         this.FTabooPractice.SetPanel(this.MainPanel["MC_Practice_Panel"]);
         this.FTabooBackpack.SetPanel(this.MainPanel["MC_Backpack_Panel"]);
         this.FTabooSynthesis.SetPanel(this.MainPanel["MC_Synthesis_Panel"]);
         this.FBtn_Close = this.MainPanel["Btn_Close"];
         this.GoToFire = this.MainPanel["MC_GoTo_Btn"];
         TGameUtil.setButtonMode(this.GoToFire,true);
         this.FUITab.SetTabByIndex(this.MainPanel["MC_Tab_Practice"],0);
         this.FUITab.SetTabByIndex(this.MainPanel["MC_Tab_Synthesis"],1);
         this.FUITab.SetTabByIndex(this.MainPanel["MC_Tab_Backpack"],2);
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         FOverlayerAppliance = new TOverlayerApplianceCopy(this.Parent,CONST_MODULES.MODULE_Taboo);
         FOverlayerAppliance.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         this.FTabooTip = new TTabooTip(this.Parent);
         this.FTabooTip.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTabooTip);
         this.FStringTip = new TOverTabooStringTip(this.Parent);
         this.FStringTip.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FStringTip);
         this.FThreeTip = new TOverThreeOverTip(this.Parent);
         this.FThreeTip.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FThreeTip);
         this.FIsInitilization = true;
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (FUICore.StageWidth - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (FUICore.StageHeight - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(false);
         this.FEffectsBaseGlowBtn = new TEffectBaseGlow();
         this.FEffectsBaseGlowBtn.SetParameters(this.GoToFire,15911245,1);
         this.FEffectsBaseGlowBtn.visible = false;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.CloseClick);
         this.GoToFire.addEventListener(MouseEvent.CLICK,this.GoToFireBtn);
         this.FTabooData.InitilizationDate();
         new Tools_Help(this,this.MainPanel["Btn_Help"],CONST_SYSTEMLANGUAGE.HELPTIPS_TABOO_Panel,FUICore);
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TABOO_REST) as TConfigValue;
         this.ResetArr = _loc1_.Value as Vector.<uint>;
      }
      
      protected function CloseClick(param1:MouseEvent = null) : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         this.FTabooPractice.UpdateEnterFream();
         this.FTabooBackpack.UpdateEnterFream();
         this.FTabooSynthesis.UpdateEnterFream();
         this.UpdateEffectsGlow();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         var _loc2_:uint = 0;
         super.Mount();
         if(param1 != null)
         {
            param1.position = 0;
            _loc2_ = param1.readUnsignedInt();
         }
         if(!FIsResourcesLoadCompleted)
         {
            this.FTProcessorInherit.Load();
            this.FTProcessorTa.Load();
            this.FTProcessorCustoms.Load();
            this.FTProcessorChange.Load();
            this.FTProcessorLog.Load();
            return;
         }
         if(_loc2_ == 2)
         {
            this.visible = false;
            this.FTProcessorCustoms.visible = true;
            this.FTProcessorCustoms.OpenThisPanel();
         }
         this.FUITab.SwithTagManual(0);
         this.TabOnSwitch(0);
         if(this.FMC_Ear_0 != null)
         {
            this.FMC_Ear_0.gotoAndPlay(1);
            this.FMC_Ear_1.gotoAndPlay(1);
         }
      }
      
      override public function Unmount() : void
      {
         this.FTProcessorInherit.visible = false;
         this.FTProcessorTa.visible = false;
         this.FTProcessorCustoms.visible = false;
         this.FTProcessorChange.visible = false;
         this.FTProcessorLog.visible = false;
         super.Unmount();
      }
      
      public function BtnBackFun(param1:int) : void
      {
         SLogicsCore.TBooData.ForRestFlg = false;
         this.FTProcessorCustoms.UpdateByIndex(param1,this.CurIndex);
      }
      
      public function LogBackFun() : void
      {
         this.FTProcessorCustoms.visible = false;
         this.FTProcessorTa.OpenThisPanel();
         this.FTProcessorTa.visible = true;
      }
      
      public function ChangeBtn(param1:Vector.<TTabooBattle>, param2:int) : void
      {
         this.CurIndex = param2;
         this.FTProcessorChange.SetDate(param1);
         this.FTProcessorChange.OpenThisPanel();
         this.FTProcessorChange.visible = true;
      }
      
      protected function GoTo_Taboo() : void
      {
         this.TabOnSwitch(this.FCurTabIndex);
         this.visible = true;
      }
      
      protected function SevenScreenClick(param1:int, param2:TTabooBattleConfig) : void
      {
         if(SLogicsCore.Character.MainHero.Level < param2.OpenLevel)
         {
            EffectGenerateText(STRING_TABOO.Str10);
            return;
         }
         if(SLogicsCore.TBooData.ChallengeSurplusCount <= 0 && SLogicsCore.TBooData.CurGuanQia == 0)
         {
            EffectGenerateText(STRING_TABOO.Str9);
            return;
         }
         this.FTProcessorCustoms.CurScreenindex = param1;
         this.FTProcessorCustoms.visible = true;
         this.visible = false;
         this.FTProcessorTa.visible = false;
         this.FTabooData.ForRestFlg = true;
         this.FTProcessorCustoms.OpenThisPanel();
      }
      
      protected function GoToFireBtn(param1:MouseEvent = null) : void
      {
         this.visible = false;
         this.FTProcessorTa.visible = true;
         this.FTProcessorTa.OpenThisPanel();
      }
      
      protected function InheritBtnClick() : void
      {
         this.FTProcessorInherit.visible = true;
         this.FTProcessorInherit.OpenThisPanel();
      }
      
      protected function Get_Info() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Taboo_Tower_Get_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function AutoFightFun(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Taboo_Tower_Auto_Fight);
         _loc2_.Data.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function AddTimesCS() : void
      {
         var _loc1_:String = null;
         this.FCurState = false;
         this.FUIWindowConfirmation.Visible = true;
         var _loc2_:RegExp = /%t/g;
         var _loc3_:int = 0;
         if(SLogicsCore.KaguyaData.Type_Count_Vector[10] > 0)
         {
            _loc3_ = SLogicsCore.KaguyaData.GetValueByTypeCopy(10) - SLogicsCore.KaguyaData.Type_Count_Vector[10];
         }
         _loc1_ = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.HELPTIPS_TABOO).DescribeString,this.ResetArr[_loc3_],SLogicsCore.KaguyaData.CurLevel,SLogicsCore.KaguyaData.Type_Count_Vector[10]);
         _loc1_ = _loc1_.replace(_loc2_,"\n");
         this.FUIWindowConfirmation.Text = _loc1_;
      }
      
      protected function GetName(param1:uint) : String
      {
         var _loc2_:TArticle = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,param1) as TArticle;
         return _loc2_.Name;
      }
      
      protected function WindowConfirmationOnOK(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FCurState)
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Taboo_Skill_Use_Succe);
            _loc2_.Data.writeUnsignedInt(this.Lhero.Identifier);
            _loc2_.Data.writeUnsignedInt(this.Rhero.Identifier);
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         }
         else
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Taboo_Tower_Add_Tms);
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         }
      }
      
      protected function GetTongGuanReward(param1:uint) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Taboo_Tower_Get_Award);
         _loc2_.Data.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function FirebtnBack(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Taboo_Tower_Tower_Fight);
         _loc2_.Data.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function S_C_Inherit(param1:THero, param2:THero, param3:int) : void
      {
         this.FCurState = true;
         this.Lhero = param1;
         this.Rhero = param2;
         this.FUIWindowConfirmation.Visible = true;
         this.FUIWindowConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.HELPTIPS_TABOO1).DescribeString,param3);
         this.FTProcessorInherit.CanInherit = false;
      }
      
      protected function S_C_SeeTaboo(param1:int, param2:int, param3:THero) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         var _loc6_:uint = 0;
         var _loc7_:TTabooAddition = null;
         var _loc8_:TTabooBattleConfig = null;
         _loc6_ = CONST_TABOO.Configuration_Base + param2 * 1000 + param1;
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TabooAddition,_loc6_) as TTabooAddition;
         _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TabooBattleConfig,_loc7_.NeedLevel) as TTabooBattleConfig;
         if(_loc8_.OpenLevel > SLogicsCore.Character.MainHero.Level)
         {
            EffectGenerateText(TUtilityString.Format(STRING_TABOO.Str24,_loc8_.CampaignName));
            return;
         }
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Taboo_Skill_Use_Learn);
         _loc4_.Data.writeUnsignedInt(param3.Identifier);
         _loc4_.Data.writeUnsignedInt(_loc7_.Identifier);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function S_C_MakeFun(param1:TabooDataCell) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         this.FCurSynthesisData = param1;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Taboo_Skill_Use_Synth);
         _loc2_.Data.writeUnsignedInt(param1.ConfigureConfig.Identifier);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Taboo_Skill_Get_Bag,this.PACKETID_S2C_Taboo_Skill_Get_Bag);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Taboo_Skill_Get_Learn,this.PACKETID_S2C_Taboo_Skill_Get_Learn);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Taboo_Skill_Use_Learn,this.PACKETID_S2C_Taboo_Skill_Use_Learn);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Taboo_Skill_Use_Synth,this.PACKETID_S2C_Taboo_Skill_Use_Synth);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Taboo_Skill_Use_Succe,this.PACKETID_S2C_Taboo_Skill_Use_Succe);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Taboo_Tower_Get_Info,this.PACKETID_S2C_Taboo_Tower_Get_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Taboo_Tower_Add_Tms,this.PACKETID_S2C_Taboo_Tower_Add_Tms);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Taboo_Tower_Tower_Fight,this.PACKETID_S2C_Taboo_Tower_Tower_Fight);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Taboo_Tower_Auto_Fight,this.PACKETID_S2C_Taboo_Tower_Auto_Fight);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Taboo_Tower_Get_Award,this.PACKETID_S2C_Taboo_Tower_Get_Award);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Taboo_Tower_Get_Item_Info,this.PACKETID_S2C_Taboo_Tower_Get_Item_Info);
      }
      
      protected function PACKETID_S2C_Taboo_Tower_Get_Award(param1:TPacket) : void
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
         EffectGenerateText(STRING_BASEACTIVITY.FORMAT_GET);
         SLogicsCore.TBooData.CurGuanQiaCell.IsGetRewards = true;
         this.FTProcessorCustoms.OpenThisPanel();
      }
      
      protected function PACKETID_S2C_Taboo_Tower_Auto_Fight(param1:TPacket) : void
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
         if(this.FTabooData.ChallengeSurplusCount > 0)
         {
            --this.FTabooData.ChallengeSurplusCount;
         }
         this.FTProcessorLog.visible = true;
         this.FTProcessorLog.SetValue(_loc2_);
         this.FTProcessorCustoms.UpdateAutoBtn();
         this.Get_Info();
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Taboo,this.FTabooData.CheckStatus());
      }
      
      protected function PACKETID_S2C_Taboo_Tower_Tower_Fight(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         var _loc4_:int = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_Taboo,0);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
         if(_loc4_)
         {
            this.Get_Info();
         }
      }
      
      protected function PACKETID_S2C_Taboo_Tower_Add_Tms(param1:TPacket) : void
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
         this.FTabooData.ForRestFlg = true;
         this.Get_Info();
      }
      
      protected function PACKETID_S2C_Taboo_Tower_Get_Info(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:Boolean = false;
         _loc2_ = param1.Data;
         this.FTabooData.CurGuanQia = _loc2_.readUnsignedInt();
         this.FTabooData.ChallengeSurplusCount = _loc2_.readUnsignedInt();
         _loc3_ = _loc2_.readShort();
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = _loc2_.readUnsignedInt();
            _loc5_ = Boolean(_loc2_.readUnsignedInt());
            this.FTabooData.AddGuanQiaVec(_loc4_,_loc5_);
            _loc6_++;
         }
         this.FTProcessorTa.OpenThisPanel();
         this.FTabooData.ForRestFlg = false;
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Taboo,this.FTabooData.CheckStatus());
      }
      
      protected function PACKETID_S2C_Taboo_Skill_Use_Succe(param1:TPacket) : void
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
         EffectGenerateText(STRING_TABOO.Str29);
      }
      
      protected function PACKETID_S2C_Taboo_Skill_Use_Synth(param1:TPacket) : void
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
         EffectGenerateText(STRING_TALISMAN.STRING_COMBINOK);
      }
      
      protected function PACKETID_S2C_Taboo_Skill_Use_Learn(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TabooDataCell = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = this.FUnstreamizerTaboo.UnstreamizationGetHerosSkillCopy(_loc2_);
         this.FTabooPractice.UpdateSevenOnleOne(_loc4_.ConfigureConfig.Quality);
      }
      
      protected function PACKETID_S2C_Taboo_Skill_Get_Learn(param1:TPacket) : void
      {
         this.FUnstreamizerTaboo.UnstreamizationGetHerosSkill(param1.Data);
         this.FTProcessorInherit.setNull();
         this.FTProcessorInherit.UpdateView();
      }
      
      protected function PACKETID_S2C_Taboo_Tower_Get_Item_Info(param1:TPacket) : void
      {
         this.FUnstreamizerTaboo.UnstreamizationPerformCopy(param1.Data,this.FTabooData);
         if(this.FIsInitilization)
         {
            this.FTabooSynthesis.UpdateSevenCy();
         }
      }
      
      protected function PACKETID_S2C_Taboo_Skill_Get_Bag(param1:TPacket) : void
      {
         this.FUnstreamizerTaboo.Unstreamize(param1.Data,this.FTabooData,null);
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FCurTabIndex = param1 as int;
         this.FTabooPractice.ThisPanel.visible = false;
         this.FTabooSynthesis.ThisPanel.visible = false;
         this.FTabooBackpack.ThisPanel.visible = false;
         switch(this.FCurTabIndex)
         {
            case 0:
               this.FTabooPractice.OpenThisPanel();
               this.FTabooPractice.SetVisibel(false);
               this.FTabooPractice.ThisPanel.visible = true;
               break;
            case 1:
               this.FTabooSynthesis.OpenThisPanel();
               this.FTabooSynthesis.SetVisibel(true);
               this.FTabooSynthesis.ThisPanel.visible = true;
               break;
            case 2:
               this.FTabooBackpack.OpenThisPanel();
               this.FTabooBackpack.ThisPanel.visible = true;
         }
      }
      
      public function FilghtReadOver() : void
      {
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
      
      protected function SevenFunOver(param1:int, param2:int, param3:Boolean, param4:int) : void
      {
         this.FThreeTip.Context = [param1,param2,param3,param4];
         this.FThreeTip.Render(FUICore.MouseCoordinate);
         this.FThreeTip.Show();
      }
      
      protected function SevenFunMove() : void
      {
         if(this.FThreeTip)
         {
            this.FThreeTip.Render(FUICore.MouseCoordinate);
         }
      }
      
      protected function SevenFunOut() : void
      {
         if(this.FThreeTip)
         {
            this.FThreeTip.Hide();
         }
      }
      
      protected function AutoFightBtnTipM() : void
      {
         if(this.FStringTip)
         {
            this.FStringTip.Context = STRING_TABOO.Str28;
            this.FStringTip.Render(FUICore.MouseCoordinate);
            this.FStringTip.Show();
         }
      }
      
      protected function AutoFightBtnTipO() : void
      {
         if(this.FStringTip)
         {
            this.FStringTip.Hide();
         }
      }
      
      protected function FireBtnTipFunOut() : void
      {
         if(this.FStringTip)
         {
            this.FStringTip.Hide();
         }
      }
      
      protected function FireBtnTipFunOver(param1:Vector.<TDailyTaskReward>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TArticle = null;
         var _loc4_:TTabooConfig = null;
         var _loc5_:String = "";
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_].Type == 18)
            {
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TabooConfig,param1[_loc2_].Code) as TTabooConfig;
               _loc5_ += _loc4_.Name + " *" + param1[_loc2_].Amount;
            }
            else
            {
               _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,param1[_loc2_].Code) as TArticle;
               _loc5_ += _loc3_.Name + " *" + param1[_loc2_].Amount;
            }
            if(_loc2_ < param1.length)
            {
               _loc5_ += "\n";
            }
            _loc2_++;
         }
         if(this.FStringTip)
         {
            this.FStringTip.Context = _loc5_;
            this.FStringTip.Render(FUICore.MouseCoordinate);
            this.FStringTip.Show();
         }
      }
      
      protected function FunOver(param1:int, param2:int) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:TTabooAddition = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:RegExp = null;
         if(this.FStringTip)
         {
            _loc5_ = "";
            _loc3_ = CONST_TABOO.Configuration_Base + param1 * 1000 + param2;
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TabooAddition,_loc3_) as TTabooAddition;
            _loc6_ = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc4_.AddProperty[0][0])];
            if(_loc4_.AddProperty.length > 1)
            {
               _loc6_ = STRING_TABOO.Str23;
            }
            _loc5_ = TUtilityString.Format(STRING_TABOO.Str11,_loc4_.Name,_loc6_,_loc4_.AddProperty[0][1],_loc4_.Name,this.FTabooData.GetJinShuCountById(_loc3_));
            _loc7_ = /%t/g;
            _loc5_ = _loc5_.replace(_loc7_,"\n");
            this.FStringTip.Context = _loc5_;
            this.FStringTip.Render(FUICore.MouseCoordinate);
            this.FStringTip.Show();
         }
      }
      
      protected function FunMove() : void
      {
         if(this.FStringTip)
         {
            this.FStringTip.Render(FUICore.MouseCoordinate);
            this.FStringTip.Show();
         }
      }
      
      protected function FunOut() : void
      {
         if(this.FStringTip)
         {
            this.FStringTip.Hide();
         }
      }
      
      protected function UIComponentsApplianceOnOver(param1:Object, param2:Object) : void
      {
         if(param2 is TInventory)
         {
            if(FOverlayerAppliance != null)
            {
               FOverlayerAppliance.Context = param2;
               FOverlayerAppliance.Render(FUICore.MouseCoordinate);
               FOverlayerAppliance.Show();
            }
         }
         else if(this.FTabooTip != null)
         {
            this.FTabooTip.Context = param2;
            this.FTabooTip.Render(FUICore.MouseCoordinate);
            this.FTabooTip.Show();
         }
      }
      
      protected function UIComponentsApplianceOnOut(param1:Object, param2:Object) : void
      {
         if(FOverlayerAppliance != null)
         {
            FOverlayerAppliance.Hide();
         }
         if(this.FTabooTip != null)
         {
            this.FTabooTip.Hide();
         }
      }
      
      protected function UpdateEffectsGlow() : void
      {
         if(this.FEffectsBaseGlowBtn != null)
         {
            if(SLogicsCore.TBooData.ChallengeSurplusCount > 0)
            {
               this.FEffectsBaseGlowBtn.Run();
               this.FEffectsBaseGlowBtn.visible = true;
            }
            else
            {
               this.FEffectsBaseGlowBtn.Stop();
               this.FEffectsBaseGlowBtn.visible = false;
            }
         }
      }
   }
}

