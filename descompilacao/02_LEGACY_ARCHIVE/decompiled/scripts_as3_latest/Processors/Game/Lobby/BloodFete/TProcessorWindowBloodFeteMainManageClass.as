package Processors.Game.Lobby.BloodFete
{
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.BloodFete.TBloodFeteData;
   import Logics.BloodFete.TBloodFeteSingle;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Logics.Streamization.BloodFete.TUnstreamizerBloodFete;
   import Processors.Game.Lobby.BloodFete.Panel.TProcessorWindowBloodFeteBag;
   import Processors.Game.Lobby.BloodFete.Panel.TProcessorWindowBloodFeteCell;
   import Processors.Game.Lobby.BloodFete.Panel.TProcessorWindowBloodFeteMainPanel;
   import Processors.Game.Lobby.BloodFete.cell.TBagBloodFeteCell;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyPlate;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowInformationNew;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Resources.Constants.CONST_BLOODFETE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_FETEBLOODMAINMANAGE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TProcessorWindowBloodFeteMainManageClass extends TProcessorLobbyPlate
   {
      
      protected var MainPanel:Sprite;
      
      protected var FProcessorWindowBloodFeteMainPanel:TProcessorWindowBloodFeteMainPanel;
      
      protected var FProcessorWindowBloodFeteBag:TProcessorWindowBloodFeteBag;
      
      protected var FProcessorWindowBloodFeteCell:TProcessorWindowBloodFeteCell;
      
      protected var FMC_Help:SimpleButton;
      
      protected var FMC_Close:SimpleButton;
      
      protected var FUIWindowConfirmationCallHero:TUIWindowConfirmation;
      
      protected var FUIWindowConfirmationTupo:TUIWindowConfirmation;
      
      protected var FUIWindowInformation:TUIWindowInformationNew;
      
      protected var FUIWindowConfirmationSell:TUIWindowConfirmation;
      
      protected var FBloodFeteDatas:TBloodFeteData;
      
      protected var FUnstreamizerBloodFete:TUnstreamizerBloodFete;
      
      protected var FControlStatus:int;
      
      protected var TempOrSellVector:Vector.<TBloodFeteSingle>;
      
      protected var FOneKeyIndex:uint;
      
      protected var FHelpTips:THint;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FSetChatPositionByType:Function;
      
      protected var FBackMainScreen:Function;
      
      protected var FUpdateHeroPower:Function;
      
      protected var FOnSetChatOptions:Function;
      
      protected var FUpdateOtheroPanel:Function;
      
      public function TProcessorWindowBloodFeteMainManageClass(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FBloodFeteDatas = SLogicsCore.BloodFeteDatas;
         this.TempOrSellVector = new Vector.<TBloodFeteSingle>();
         this.TempOrSellVector.length = 0;
         this.FUnstreamizerBloodFete = new TUnstreamizerBloodFete();
         this.FHelpTips = new THint();
         this.Initilization();
         SetUIModuleID(CONST_MODULES.MODULE_BloodFete);
      }
      
      protected function Initilization() : void
      {
         this.FUIWindowConfirmationCallHero = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmationCallHero.OnOK = this.WindowConfirmationCallHeroOnOK;
         this.FUIWindowConfirmationCallHero.OnCancel = this.WindowConfirmationSellOnCancel;
         this.FUIWindowConfirmationCallHero.x = (FUICore.StageWidth - this.FUIWindowConfirmationCallHero.WindowWidth) / 2;
         this.FUIWindowConfirmationCallHero.y = (FUICore.StageHeight - this.FUIWindowConfirmationCallHero.WindowHeight) / 2;
         this.FUIWindowConfirmationTupo = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmationTupo.OnOK = this.WindowConfirmationCallHeroOnOK;
         this.FUIWindowConfirmationTupo.x = (FUICore.StageWidth - this.FUIWindowConfirmationTupo.WindowWidth) / 2;
         this.FUIWindowConfirmationTupo.y = (FUICore.StageHeight - this.FUIWindowConfirmationTupo.WindowHeight) / 2;
         this.FUIWindowConfirmationSell = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmationSell.OnOK = this.WindowConfirmationSellOnOK;
         this.FUIWindowConfirmationSell.x = (FUICore.StageWidth - this.FUIWindowConfirmationSell.WindowWidth) / 2;
         this.FUIWindowConfirmationSell.y = (FUICore.StageHeight - this.FUIWindowConfirmationSell.WindowHeight) / 2;
         this.FUIWindowInformation = new TUIWindowInformationNew(this.Parent);
         this.FUIWindowInformation.x = (FUICore.StageWidth - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (FUICore.StageHeight - this.FUIWindowInformation.WindowHeight) / 2;
         this.FProcessorWindowBloodFeteMainPanel = new TProcessorWindowBloodFeteMainPanel(this);
         this.FProcessorWindowBloodFeteMainPanel.CloseFunction = this.BackMainScreenCopy;
         this.FProcessorWindowBloodFeteMainPanel.MC_ExchangeBtn_Bag_Fun = this.FMC_ExchangeBtn_Bag_Fun;
         this.FProcessorWindowBloodFeteMainPanel.MC_Call = this.OnSureCallHero;
         this.FProcessorWindowBloodFeteMainPanel.ThisPanelClick = this.OnCallHero;
         this.FProcessorWindowBloodFeteMainPanel.MC_OneKey_BloodFete_Fun = this.OneKey_BloodFete;
         this.FProcessorWindowBloodFeteMainPanel.MC_OneKey_Get_Fun = this.OneKey_Get;
         this.FProcessorWindowBloodFeteMainPanel.MC_OneKey_Sell_Fun = this.OneKey_Sell;
         this.FProcessorWindowBloodFeteMainPanel.Sell_Func = this.OnelyKey_Sell;
         this.FProcessorWindowBloodFeteMainPanel.Get_Func = this.OnelyKey_Get;
         this.FProcessorWindowBloodFeteMainPanel.PiaoZi = this.PiaoZi;
         this.FProcessorWindowBloodFeteMainPanel.ButtonHelpOnOver = this.ButtonHelpOnOver;
         this.FProcessorWindowBloodFeteMainPanel.ButtonHelpOnOut = this.ButtonHelpOnOut;
         this.FProcessorWindowBloodFeteBag = new TProcessorWindowBloodFeteBag(this);
         this.FProcessorWindowBloodFeteBag.CloseFunction = this.BackMainPanelWindow;
         this.FProcessorWindowBloodFeteBag.CellMoveBackFun = this.CellMoveBackFun;
         this.FProcessorWindowBloodFeteBag.PutOnCellOrTakeOffCell = this.PutOnCellOrTakeOffCell;
         this.FProcessorWindowBloodFeteBag.PhagocytosisBackFun = this.PhagocytosisBackFun;
         this.FProcessorWindowBloodFeteBag.Blood_FeteFunc = this.Blood_FeteFunc;
         this.FProcessorWindowBloodFeteBag.Btn_AKeyFunc = this.Btn_AKeyFunc;
         this.FProcessorWindowBloodFeteBag.Btn_GoFunc = this.Btn_GoFunc;
         this.FProcessorWindowBloodFeteBag.OpenPackageCellBack = this.OpenPackageCellBack;
         this.FProcessorWindowBloodFeteBag.PiaoZi = this.PiaoZi;
         this.FProcessorWindowBloodFeteCell = new TProcessorWindowBloodFeteCell(this);
         this.FProcessorWindowBloodFeteCell.BackFunction = this.ExchangeBackFunction;
         this.FProcessorWindowBloodFeteCell.CloseFunction = this.BackMainPanelWindow;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BLOODFETE.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.MainPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_BLOODFETE.MainPanelName) as Sprite;
         addChild(this.MainPanel);
         this.FMC_Help = this.MainPanel["MC_Help"];
         this.FMC_Close = this.MainPanel["MC_Close"];
         this.setChildIndex(this.MainPanel,0);
         this.FProcessorWindowBloodFeteMainPanel.MP = this.MainPanel;
         this.GetBaseCondition();
         TUtilityUIWindow.SetupWindowInformationNew(this.FUIWindowInformation);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationCallHero);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationTupo);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationSell);
         this.FUIWindowConfirmationTupo.SetCheckBox(true);
         this.FUIWindowConfirmationCallHero.SetCheckBox(true);
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         this.ProcessorResize();
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FProcessorWindowBloodFeteMainPanel)
         {
            if(this.FProcessorWindowBloodFeteMainPanel.IsInitilization)
            {
               this.FProcessorWindowBloodFeteMainPanel.UpdateImage();
               this.FProcessorWindowBloodFeteMainPanel.updateMoney();
            }
         }
         if(this.FProcessorWindowBloodFeteBag)
         {
            this.FProcessorWindowBloodFeteBag.LogicPerform();
         }
      }
      
      protected function GetBaseCondition() : void
      {
         var _loc1_:TSystemLanguage = null;
         var _loc2_:TConfigValue = null;
         var _loc3_:uint = 0;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.FollowBloodBound_SummonExpend) as TConfigValue;
         this.FBloodFeteDatas.CallCast = _loc2_.Value as int;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.FollowBloodBound_RoleHole_Openlevel) as TConfigValue;
         this.FBloodFeteDatas.BodyLevel_OpenCount = _loc2_.Value as Vector.<uint>;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.FollowBloodBound_Depot_OpenExpend) as TConfigValue;
         this.FBloodFeteDatas.BagCost_ByCount = _loc2_.Value as Vector.<uint>;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.FollowBloodBound_DefaultNum) as TConfigValue;
         this.FBloodFeteDatas.BagCellOpened = _loc2_.Value as int;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.FollowBloodBound_FirstMaster_Expend) as TConfigValue;
         _loc3_ = uint(_loc2_.Value as int);
         this.FBloodFeteDatas.CallCostPri.push(_loc3_);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.FollowBloodBound_SecondMaster_Expend) as TConfigValue;
         _loc3_ = uint(_loc2_.Value as int);
         this.FBloodFeteDatas.CallCostPri.push(_loc3_);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.FollowBloodBound_ThirdMaster_Expend) as TConfigValue;
         _loc3_ = uint(_loc2_.Value as int);
         this.FBloodFeteDatas.CallCostPri.push(_loc3_);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.FollowBloodBound_FourthMaster_Expend) as TConfigValue;
         _loc3_ = uint(_loc2_.Value as int);
         this.FBloodFeteDatas.CallCostPri.push(_loc3_);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.FollowBloodBound_FifthMaster_Expend) as TConfigValue;
         _loc3_ = uint(_loc2_.Value as int);
         this.FBloodFeteDatas.CallCostPri.push(_loc3_);
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_BloodFete) as TSystemLanguage;
         this.FHelpTips.Content = _loc1_.Desc;
      }
      
      public function OnCallHeroReq(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.getIsCanSendPakage())
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_FBB_C2S_CallHero_Req);
            _loc3_ = _loc2_.Data;
            _loc3_.writeUnsignedInt(this.FBloodFeteDatas.MC_AutoSell_TaskIndex);
            _loc3_.writeUnsignedInt(this.FBloodFeteDatas.MC_AutoCompound_Task);
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         }
         else
         {
            this.FBloodFeteDatas.IsAutoClick = false;
            this.FBloodFeteDatas.IsOneKeyBloodState = false;
            this.FProcessorWindowBloodFeteMainPanel.updateFiveIsCanClick();
         }
      }
      
      public function OnSureCallHero(param1:int) : void
      {
         var _loc2_:int = 0;
         this.FControlStatus = 7;
         if(this.FUIWindowConfirmationCallHero.IsSelected)
         {
            this.OnCallHeroReq(param1);
         }
         else
         {
            _loc2_ = this.FBloodFeteDatas.CallCast;
            if(this.FBloodFeteDatas.CallBtnCountFree == 0)
            {
               _loc2_ = this.FBloodFeteDatas.CallCast / 2;
            }
            this.FUIWindowConfirmationCallHero.Text = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.STRING_Function_SureCalll,_loc2_);
            this.FUIWindowConfirmationCallHero.visible = true;
         }
      }
      
      public function OneKeyHeChengFunction_C() : void
      {
         this.FControlStatus = 8;
         if(this.FUIWindowConfirmationTupo.IsSelected)
         {
            this.OneKeyHeChengFunction();
         }
         else
         {
            this.FUIWindowConfirmationTupo.Text = STRING_FETEBLOODMAINMANAGE.STRING_Function_OnekeyHeCheng;
            this.FUIWindowConfirmationTupo.visible = true;
         }
      }
      
      protected function WindowConfirmationCallHeroOnOK(param1:Object) : void
      {
         if(this.FControlStatus == 7)
         {
            this.OnCallHeroReq(7);
         }
         else
         {
            this.OneKeyHeChengFunction();
         }
      }
      
      protected function WindowConfirmationSellOnCancel(param1:Object) : void
      {
         this.FProcessorWindowBloodFeteMainPanel.ResetBloodFeteFiveBtn();
      }
      
      protected function OneKey_C_S() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         if(!Visible)
         {
            return;
         }
         _loc2_ = int(this.FBloodFeteDatas.FiveState.length - 1);
         while(_loc2_ >= 0)
         {
            if(this.FBloodFeteDatas.FiveState[_loc2_] == 0)
            {
               _loc1_ = _loc2_;
               break;
            }
            _loc2_--;
         }
         this.SendPackage(_loc1_,1);
      }
      
      protected function getIsCanSendPakage() : Boolean
      {
         var _loc1_:Boolean = true;
         if(this.FBloodFeteDatas.NumenBagBloodFete.length >= 20)
         {
            _loc1_ = false;
            EffectGenerateText(STRING_FETEBLOODMAINMANAGE.STRING_OverTwenty);
         }
         return _loc1_;
      }
      
      protected function SendPackage(param1:int, param2:int = 0) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         if(!this.getIsCanSendPakage())
         {
            this.FBloodFeteDatas.IsAutoClick = false;
            this.FBloodFeteDatas.IsOneKeyBloodState = false;
            this.FProcessorWindowBloodFeteMainPanel.updateFiveIsCanClick();
            return;
         }
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_FBB_C2S_OneKeyLight_Req);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(param2);
         _loc4_.writeUnsignedInt(param1);
         _loc4_.writeUnsignedInt(this.FBloodFeteDatas.MC_AutoSell_TaskIndex);
         _loc4_.writeUnsignedInt(this.FBloodFeteDatas.MC_AutoCompound_Task);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function OnelyKey_Sell(param1:TBloodFeteSingle) : void
      {
         this.TempOrSellVector.length = 0;
         this.TempOrSellVector.push(param1);
         if(param1.Type == 1 && param1.Quality >= 5)
         {
            this.FUIWindowConfirmationSell.SetHtml = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.STRING_SellBloodFete,CONST_COMMON.QUALITYCOLOR_INDEX_1[param1.Quality],param1.Name);
            this.FUIWindowConfirmationSell.Visible = true;
            return;
         }
         this.Sell_BloodFete();
      }
      
      protected function WindowConfirmationSellOnOK(param1:Object = null) : void
      {
         this.Sell_BloodFete();
      }
      
      protected function OneKey_Sell() : void
      {
         this.TempOrSellVector.length = 0;
         var _loc1_:* = int(this.FBloodFeteDatas.NumenBagBloodFete.length - 1);
         while(_loc1_ >= 0)
         {
            if(this.FBloodFeteDatas.NumenBagBloodFete[_loc1_].Type == 2)
            {
               this.TempOrSellVector.push(this.FBloodFeteDatas.NumenBagBloodFete[_loc1_]);
            }
            _loc1_--;
         }
         this.Sell_BloodFete();
      }
      
      protected function Sell_BloodFete(param1:int = 0) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.TempOrSellVector.length == 0)
         {
            return;
         }
         if(param1)
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_FBB_C2S_PickUp_Req);
         }
         else
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_FBB_C2S_SaleOut_Req);
         }
         _loc3_ = _loc2_.Data;
         if(param1)
         {
            _loc3_.writeUnsignedInt(this.FBloodFeteDatas.MC_AutoCompound_Task);
         }
         _loc3_.writeShort(this.TempOrSellVector.length);
         var _loc4_:int = 0;
         while(_loc4_ < this.TempOrSellVector.length)
         {
            _loc3_.writeUnsignedInt(this.TempOrSellVector[_loc4_].IdentifierUInt64.High);
            _loc3_.writeUnsignedInt(this.TempOrSellVector[_loc4_].IdentifierUInt64.Low);
            _loc4_++;
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnelyKey_Get(param1:TBloodFeteSingle) : void
      {
         if(this.FBloodFeteDatas.RealBagBloodFete.length >= this.FBloodFeteDatas.BagFieldLocked)
         {
            EffectGenerateText(STRING_FETEBLOODMAINMANAGE.STRING_BagFull);
            return;
         }
         this.TempOrSellVector.length = 0;
         this.TempOrSellVector.push(param1);
         this.Sell_BloodFete(1);
      }
      
      protected function OneKey_Get() : void
      {
         if(this.FBloodFeteDatas.RealBagBloodFete.length >= this.FBloodFeteDatas.BagFieldLocked)
         {
            EffectGenerateText(STRING_FETEBLOODMAINMANAGE.STRING_BagFull);
            return;
         }
         this.TempOrSellVector.length = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.FBloodFeteDatas.NumenBagBloodFete.length)
         {
            if(this.FBloodFeteDatas.NumenBagBloodFete[_loc1_].Type != 2)
            {
               this.TempOrSellVector.push(this.FBloodFeteDatas.NumenBagBloodFete[_loc1_]);
            }
            _loc1_++;
         }
         this.Sell_BloodFete(1);
      }
      
      protected function OneKey_BloodFete() : void
      {
         var _loc1_:uint = uint(SLogicsCore.Character.VipData.VipOpenLevel_FollowBloodBoundAutoSynthesis);
         if(!_loc1_)
         {
            EffectGenerateText(TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.Tip_3,_loc1_));
            return;
         }
         if(this.FBloodFeteDatas.IsAutoClick)
         {
            this.FBloodFeteDatas.IsAutoClick = false;
            this.FBloodFeteDatas.IsOneKeyBloodState = false;
            return;
         }
         this.FBloodFeteDatas.IsAutoClick = true;
         this.FBloodFeteDatas.IsOneKeyBloodState = true;
         this.OneKey_C_S();
      }
      
      protected function OnCallHero(param1:int) : void
      {
         this.SendPackage(param1,0);
      }
      
      protected function ExchangeBackFunction(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_FBB_C2S_Exchange_Req);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PutOnCellOrTakeOffCell(param1:int, param2:int, param3:TBagBloodFeteCell, param4:THero) : void
      {
         var _loc5_:TPacket = null;
         var _loc6_:ByteArray = null;
         if(param1)
         {
            _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_FBB_C2S_EquipOn_Req);
         }
         else
         {
            _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_FBB_C2S_EquipOff_Req);
         }
         _loc6_ = _loc5_.Data;
         _loc6_.writeUnsignedInt(param4.Identifier);
         _loc6_.writeUnsignedInt(param2);
         _loc6_.writeUnsignedInt(param3.BloodFeteSingle.IdentifierUInt64.High);
         _loc6_.writeUnsignedInt(param3.BloodFeteSingle.IdentifierUInt64.Low);
         param3 = null;
         SNetworkCore.Transceiver.PacketTransmit(_loc5_);
      }
      
      protected function CellMoveBackFun(param1:int, param2:int, param3:TBagBloodFeteCell, param4:THero) : void
      {
         var _loc5_:TPacket = null;
         var _loc6_:ByteArray = null;
         _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_FBB_C2S_FBB_S2C_Move_Req);
         _loc6_ = _loc5_.Data;
         if(param1)
         {
            _loc6_.writeUnsignedInt(param4.Identifier);
         }
         else
         {
            _loc6_.writeUnsignedInt(0);
         }
         _loc6_.writeUnsignedInt(param2);
         _loc6_.writeUnsignedInt(param3.BloodFeteSingle.IdentifierUInt64.High);
         _loc6_.writeUnsignedInt(param3.BloodFeteSingle.IdentifierUInt64.Low);
         param3 = null;
         SNetworkCore.Transceiver.PacketTransmit(_loc5_);
      }
      
      protected function PhagocytosisBackFun(param1:int, param2:int, param3:TBagBloodFeteCell, param4:TBagBloodFeteCell, param5:THero) : void
      {
         var _loc6_:TPacket = null;
         var _loc7_:ByteArray = null;
         if(param3 != null && param3.BloodFeteSingle != null && param3.BloodFeteSingle.IdentifierUInt64 != null && param4 != null && param4.BloodFeteSingle != null && param4.BloodFeteSingle.IdentifierUInt64 != null)
         {
            _loc6_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_FBB_C2S_Devour_Req);
            _loc7_ = _loc6_.Data;
            if(param1)
            {
               _loc7_.writeUnsignedInt(param5.Identifier);
            }
            else
            {
               _loc7_.writeUnsignedInt(0);
            }
            _loc7_.writeUnsignedInt(param3.BloodFeteSingle.IdentifierUInt64.High);
            _loc7_.writeUnsignedInt(param3.BloodFeteSingle.IdentifierUInt64.Low);
            _loc7_.writeUnsignedInt(param4.BloodFeteSingle.IdentifierUInt64.High);
            _loc7_.writeUnsignedInt(param4.BloodFeteSingle.IdentifierUInt64.Low);
            SNetworkCore.Transceiver.PacketTransmit(_loc6_);
         }
      }
      
      protected function OneKeyHeChengFunction() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_FBB_C2S_Devour_Req);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         _loc2_.writeUnsignedInt(0);
         _loc2_.writeUnsignedInt(0);
         _loc2_.writeUnsignedInt(0);
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function OpenPackageCellBack(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_FBB_C2S_OpenBagFields_Req);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_FBB_S2C_LoadDB_Ret,this.PACKETID_FBB_S2C_LoadDB_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_FBB_S2C_FBB_S2C_Move_Ret,this.PACKETID_FBB_S2C_FBB_S2C_Move_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_FBB_S2C_PickUp_Ret,this.PACKETID_FBB_S2C_PickUp_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_FBB_S2C_SaleOut_Ret,this.PACKETID_FBB_S2C_SaleOut_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_FBB_S2C_Devour_Ret,this.PACKETID_FBB_S2C_Devour_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_FBB_S2C_Exchange_Ret,this.PACKETID_FBB_S2C_Exchange_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_FBB_S2C_EquipOn_Ret,this.PACKETID_FBB_S2C_EquipOn_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_FBB_S2C_EquipOff_Ret,this.PACKETID_FBB_S2C_EquipOff_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_FBB_S2C_OnekeySync_Ret,this.PACKETID_FBB_S2C_OnekeySync_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_FBB_S2C_OpenBagFields_Ret,this.PACKETID_FBB_S2C_OpenBagFields_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_FBB_S2C_CallHero_Ret,this.PACKETID_FBB_S2C_CallHero_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_FBB_S2C_AddSync_Ret,this.PACKETID_FBB_S2C_AddSync_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_FBB_S2C_DeleteSync_Ret,this.PACKETID_FBB_S2C_DeleteSync_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_FBB_S2C_OthersHeros_Ret,this.PACKETID_FBB_S2C_OthersHeros_Ret);
      }
      
      protected function PACKETID_FBB_S2C_LoadDB_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FUnstreamizerBloodFete.Unstreamize(_loc3_,this.FBloodFeteDatas,this);
      }
      
      protected function PACKETID_FBB_S2C_FBB_S2C_Move_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FUnstreamizerBloodFete.MoveSynchronization(_loc3_,this.FBloodFeteDatas);
         this.FProcessorWindowBloodFeteBag.ReflashS_COnely();
      }
      
      protected function PACKETID_FBB_S2C_PickUp_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            this.FBloodFeteDatas.IsAutoClick = false;
            this.FBloodFeteDatas.IsOneKeyBloodState = false;
            EffectGenerateTextByErrorCode(_loc2_);
            this.FProcessorWindowBloodFeteMainPanel.updateFiveIsCanClick();
            return;
         }
      }
      
      protected function PACKETID_FBB_S2C_SaleOut_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FUnstreamizerBloodFete.SellBloodFete(_loc3_,this.FBloodFeteDatas,this.FProcessorWindowBloodFeteMainPanel);
         this.FProcessorWindowBloodFeteMainPanel.OpenThisPanel();
      }
      
      protected function PACKETID_FBB_S2C_Devour_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            this.FBloodFeteDatas.IsAutoClick = false;
            this.FBloodFeteDatas.IsOneKeyBloodState = false;
            EffectGenerateTextByErrorCode(_loc2_);
            this.FProcessorWindowBloodFeteMainPanel.updateFiveIsCanClick();
            return;
         }
      }
      
      protected function PACKETID_FBB_S2C_Exchange_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FBloodFeteDatas.DebrisId = _loc3_.readUnsignedInt();
         this.FBloodFeteDatas.DebrisNum = _loc3_.readUnsignedInt();
         this.FProcessorWindowBloodFeteCell.UpdateView();
         this.FProcessorWindowBloodFeteBag.UpdateCellCount();
         EffectGenerateText(STRING_FETEBLOODMAINMANAGE.STRING_ExchangeSuss);
      }
      
      protected function PACKETID_FBB_S2C_EquipOn_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            this.FBloodFeteDatas.IsAutoClick = false;
            this.FBloodFeteDatas.IsOneKeyBloodState = false;
            EffectGenerateTextByErrorCode(_loc2_);
            this.FProcessorWindowBloodFeteMainPanel.updateFiveIsCanClick();
            return;
         }
      }
      
      protected function PACKETID_FBB_S2C_EquipOff_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            this.FBloodFeteDatas.IsAutoClick = false;
            this.FBloodFeteDatas.IsOneKeyBloodState = false;
            EffectGenerateTextByErrorCode(_loc2_);
            this.FProcessorWindowBloodFeteMainPanel.updateFiveIsCanClick();
            return;
         }
      }
      
      protected function PACKETID_FBB_S2C_OpenBagFields_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FBloodFeteDatas.BagFieldLocked = _loc3_.readUnsignedInt();
         this.FProcessorWindowBloodFeteBag.ReflashBagCell();
      }
      
      protected function PACKETID_FBB_S2C_CallHero_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            this.FBloodFeteDatas.IsAutoClick = false;
            this.FBloodFeteDatas.IsOneKeyBloodState = false;
            EffectGenerateTextByErrorCode(_loc2_);
            this.FProcessorWindowBloodFeteMainPanel.updateFiveIsCanClick();
            return;
         }
      }
      
      protected function PACKETID_FBB_S2C_OnekeySync_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = "";
         var _loc4_:ByteArray = param1.Data;
         _loc2_ = int(_loc4_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            this.FBloodFeteDatas.IsAutoClick = false;
            this.FBloodFeteDatas.IsOneKeyBloodState = false;
            EffectGenerateTextByErrorCode(_loc2_);
            this.FProcessorWindowBloodFeteMainPanel.updateFiveIsCanClick();
            return;
         }
         this.FUnstreamizerBloodFete.LightenBooldFete(_loc4_,this.FBloodFeteDatas);
         this.FProcessorWindowBloodFeteMainPanel.OpenThisPanel();
         if(this.FBloodFeteDatas.FiveState[4] == 0)
         {
            this.FBloodFeteDatas.IsAutoClick = false;
            this.FBloodFeteDatas.IsOneKeyBloodState = false;
         }
         if(this.FBloodFeteDatas.IsAutoClick)
         {
            if(this.FBloodFeteDatas.IsOneKeyBloodState)
            {
               this.FOneKeyIndex = setTimeout(this.OneKey_C_S,100);
            }
         }
         this.FProcessorWindowBloodFeteMainPanel.UpdateOnline();
         _loc3_ = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.Tip_1,this.FBloodFeteDatas.NewName);
         if(this.FBloodFeteDatas.NewIndex)
         {
            _loc3_ = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.Tip_2,this.FBloodFeteDatas.NewName,STRING_FETEBLOODMAINMANAGE.STRING_NameVec[this.FBloodFeteDatas.NewIndex]);
         }
         EffectGenerateText(_loc3_);
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_BloodFete,this.FBloodFeteDatas.CheckStatus());
      }
      
      protected function PACKETID_FBB_S2C_AddSync_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:String = null;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            this.FProcessorWindowBloodFeteBag.ReflashS_COnely();
            return;
         }
         _loc4_ = this.FUnstreamizerBloodFete.AddBloodFete(_loc3_,this.FBloodFeteDatas,this.FProcessorWindowBloodFeteMainPanel);
         if(_loc4_)
         {
            _loc5_ = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.Tip_1,this.FBloodFeteDatas.NewName);
            EffectGenerateText(_loc5_);
         }
         else
         {
            this.FProcessorWindowBloodFeteMainPanel.OpenThisPanel();
            this.FProcessorWindowBloodFeteBag.ReflashS_COnely();
            this.FProcessorWindowBloodFeteCell.UpdateView();
            if(this.FUpdateHeroPower != null)
            {
               this.FUpdateHeroPower(null);
            }
         }
      }
      
      protected function PACKETID_FBB_S2C_DeleteSync_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FUnstreamizerBloodFete.DeleteBloodFete(_loc3_,this.FBloodFeteDatas);
         this.FProcessorWindowBloodFeteBag.ReflashS_COnely();
         if(this.FUpdateHeroPower != null)
         {
            this.FUpdateHeroPower(null);
         }
      }
      
      public function set UpdateOtheroPanel(param1:Function) : void
      {
         this.FUpdateOtheroPanel = param1;
      }
      
      protected function PACKETID_FBB_S2C_OthersHeros_Ret(param1:TPacket) : void
      {
         this.FUpdateOtheroPanel(param1);
      }
      
      override protected function ProcessorResize() : void
      {
         if(this.FProcessorWindowBloodFeteMainPanel.MC_FunctionalArea_Father)
         {
            this.FProcessorWindowBloodFeteMainPanel.MC_FunctionalArea_Father.y = FUICore.StageHeight - this.FProcessorWindowBloodFeteMainPanel.MC_FunctionalArea_Father.height;
            this.FMC_Close.x = FUICore.StageWidth - this.FMC_Close.width;
            this.FMC_Help.x = FUICore.StageWidth - this.FMC_Close.width - this.FMC_Help.width;
         }
      }
      
      protected function PiaoZi(param1:String) : void
      {
         EffectGenerateText(param1);
      }
      
      protected function BackMainPanelWindow(param1:int) : void
      {
         var _loc2_:int = 0;
         this.FProcessorWindowBloodFeteMainPanel.visible = true;
         this.FProcessorWindowBloodFeteBag.visible = false;
         this.FProcessorWindowBloodFeteCell.visible = false;
         switch(param1)
         {
            case 0:
               this.FProcessorWindowBloodFeteCell.visible = true;
               this.FProcessorWindowBloodFeteCell.UpdateView();
               break;
            case 1:
               this.FProcessorWindowBloodFeteBag.visible = true;
               this.FProcessorWindowBloodFeteBag.OpenPanel();
               break;
            case 2:
               this.FProcessorWindowBloodFeteMainPanel.visible = true;
               if(this.FProcessorWindowBloodFeteMainPanel.IsInitilization)
               {
                  this.FProcessorWindowBloodFeteMainPanel.OpenThisPanel();
               }
         }
         this.ProcessorResize();
      }
      
      protected function Blood_FeteFunc() : void
      {
         this.BackMainPanelWindow(0);
      }
      
      protected function Btn_AKeyFunc() : void
      {
         this.OneKeyHeChengFunction_C();
      }
      
      protected function Btn_GoFunc() : void
      {
         this.BackMainPanelWindow(2);
      }
      
      protected function BackMainScreenCopy() : void
      {
         if(this.FBackMainScreen != null)
         {
            this.FBackMainScreen(this);
         }
      }
      
      protected function FMC_ExchangeBtn_Bag_Fun(param1:int) : void
      {
         this.ProcessorResize();
         this.FProcessorWindowBloodFeteBag.visible = false;
         this.FProcessorWindowBloodFeteCell.visible = false;
         switch(param1)
         {
            case 0:
               this.FProcessorWindowBloodFeteBag.visible = true;
               this.FProcessorWindowBloodFeteBag.OpenPanel();
               this.FProcessorWindowBloodFeteBag.UpdateHeroUIPage();
               break;
            case 1:
               this.FProcessorWindowBloodFeteCell.visible = true;
               this.FProcessorWindowBloodFeteCell.UpdateView();
         }
      }
      
      protected function CloseChat() : void
      {
         if(this.FOnSetChatOptions != null)
         {
            this.FOnSetChatOptions(this,false);
         }
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         this.FOverlayerHelpTips.Context = this.FHelpTips;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         this.FOverlayerHelpTips.Hide();
      }
      
      public function set BackMainScreen(param1:Function) : void
      {
         this.FBackMainScreen = param1;
      }
      
      public function get BackMainScreen() : Function
      {
         return this.FBackMainScreen;
      }
      
      public function set SetChatPositionByType(param1:Function) : void
      {
         this.FSetChatPositionByType = param1;
      }
      
      public function get UpdateHerosPower() : Function
      {
         return this.FUpdateHeroPower;
      }
      
      public function set UpdateHerosPower(param1:Function) : void
      {
         this.FUpdateHeroPower = param1;
      }
      
      public function get OnSetChatOptions() : Function
      {
         return this.FOnSetChatOptions;
      }
      
      public function set OnSetChatOptions(param1:Function) : void
      {
         this.FOnSetChatOptions = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         this.BackMainPanelWindow(2);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowBloodFeteMainPanel.Load();
            this.FProcessorWindowBloodFeteBag.Load();
            this.FProcessorWindowBloodFeteCell.Load();
            return;
         }
         if(this.FSetChatPositionByType != null)
         {
            this.FSetChatPositionByType(0);
         }
         setTimeout(this.CloseChat,50);
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         if(this.FSetChatPositionByType != null)
         {
            this.FSetChatPositionByType(1);
         }
         if(this.FOnSetChatOptions != null)
         {
            this.FOnSetChatOptions(this,true);
         }
         clearTimeout(this.FOneKeyIndex);
         this.FOneKeyIndex = 0;
      }
   }
}

