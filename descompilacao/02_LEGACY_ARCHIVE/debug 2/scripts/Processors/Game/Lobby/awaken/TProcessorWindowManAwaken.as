package Processors.Game.Lobby.awaken
{
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TAwakenConfig;
   import Logics.DatebaseVO.VO.TAwakenExploration;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Awaken.TUnstreamizerAwaken;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyPlate;
   import Processors.Game.Lobby.awaken.Panel.TProcessorWindowManAwakenPanel;
   import Processors.Game.Lobby.awaken.Panel.TProcessorWindowManChangePanel;
   import Processors.Game.Lobby.awaken.Panel.TProcessorWindowManCombiningPanel;
   import Processors.Game.Lobby.awaken.Panel.TProcessorWindowManSkillPanel;
   import Processors.Game.Lobby.awaken.date.AwakenDateCELL;
   import Processors.Game.Lobby.awaken.date.AwakenLogicDate;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.FeteBlood.TGoldCallBtn;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_AWAKEN;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_AWAKEN;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.Sprite;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   
   public class TProcessorWindowManAwaken extends TProcessorLobbyPlate
   {
      
      protected var MainPanel:Sprite;
      
      protected var FUnstreamizerAwaken:TUnstreamizerAwaken;
      
      protected var FAwakenDatas:AwakenLogicDate;
      
      protected var FProcessorWindowManAwakenPanel:TProcessorWindowManAwakenPanel = null;
      
      protected var FProcessorWindowManChangePanel:TProcessorWindowManChangePanel = null;
      
      protected var FProcessorWindowManCombiningPanel:TProcessorWindowManCombiningPanel = null;
      
      protected var FProcessorWindowManSkillPanel:TProcessorWindowManSkillPanel = null;
      
      protected var FUIWindowConfirmationSell:TUIWindowConfirmation;
      
      protected var SixBooVec:Vector.<Boolean>;
      
      protected var CurChangeType:int;
      
      protected var FIsInitilization:int;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var ThiNT:THint;
      
      protected var FTanSuoBtn:TGoldCallBtn = null;
      
      protected var FTipDec1:String;
      
      protected var FTipDec2:String;
      
      protected var FTipDec3:String;
      
      protected var FOnSetChatOptions:Function;
      
      protected var FBackMainScreen:Function;
      
      protected var CurName_:String;
      
      protected var GetGoodsCount:int;
      
      protected var CurBigIndex:int;
      
      protected var CurLittleIndex:int;
      
      protected var CurTempId:int;
      
      protected var Nimei:int;
      
      public function TProcessorWindowManAwaken(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.Initilization();
         this.ThiNT = new THint();
         this.FUnstreamizerAwaken = new TUnstreamizerAwaken();
         this.FAwakenDatas = SLogicsCore.AwakenDate;
         this.SixBooVec = new Vector.<Boolean>(6);
         SetUIModuleID(CONST_MODULES.MODULE_Taboo);
      }
      
      protected function Initilization() : void
      {
         this.FProcessorWindowManAwakenPanel = new TProcessorWindowManAwakenPanel(this);
         this.FProcessorWindowManAwakenPanel.CloseFunction = this.BackMainScreenCopy;
         this.FProcessorWindowManAwakenPanel.OpenOthersPanel = this.OpenPanelByType;
         this.FProcessorWindowManAwakenPanel.BackFun = this.PACKETID_C2S_Awaken_Search_Idolum_Info;
         this.FProcessorWindowManAwakenPanel.BackFunMove = this.BackFunMove;
         this.FProcessorWindowManAwakenPanel.BackFunOut = this.BackFunOut;
         this.FProcessorWindowManAwakenPanel.BackFunOver = this.BackFunOver;
         this.FProcessorWindowManAwakenPanel.BackFOver = this.BackTeSguFunOver;
         this.FProcessorWindowManAwakenPanel.BackMove = this.SlotBackMove;
         this.FProcessorWindowManAwakenPanel.BackOut = this.SlotBackOut;
         this.FProcessorWindowManAwakenPanel.public::BackOver = this.SlotBackOver;
         this.FProcessorWindowManChangePanel = new TProcessorWindowManChangePanel(this);
         this.FProcessorWindowManChangePanel.SlotsOnMove = this.ApplianceOnOver;
         this.FProcessorWindowManChangePanel.SlotsOnOut = this.ApplianceOnOut;
         this.FProcessorWindowManChangePanel.BackFun = this.PACKETID_C2S_Awaken_Exchange_Idolum_Info;
         this.FProcessorWindowManCombiningPanel = new TProcessorWindowManCombiningPanel(this);
         this.FProcessorWindowManCombiningPanel.BtnClickBack = this.PACKETID_C2S_Awaken_Synthesis_Skill_Info;
         this.FProcessorWindowManCombiningPanel.BackMove = this.SlotBackMove;
         this.FProcessorWindowManCombiningPanel.BackOut = this.SlotBackOut;
         this.FProcessorWindowManCombiningPanel.BackOver = this.SlotBackOver;
         this.FProcessorWindowManSkillPanel = new TProcessorWindowManSkillPanel(this);
         this.FProcessorWindowManSkillPanel.BackClick = this.PACKETID_C2S_Awaken_OnOff_Skill_Info;
         this.FProcessorWindowManSkillPanel.BackMove = this.SlotBackMove;
         this.FProcessorWindowManSkillPanel.BackOut = this.SlotBackOut;
         this.FProcessorWindowManSkillPanel.BackOver = this.SlotBackOver;
         this.FUIWindowConfirmationSell = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmationSell.OnOK = this.WindowConfirmationSellOnOK;
         this.FUIWindowConfirmationSell.OnCancel = this.WindowConfirmationSellOnCancel;
         this.FUIWindowConfirmationSell.OnCheckBoxSelected = this.OnCheckBoxSelected;
         this.FUIWindowConfirmationSell.x = (FUICore.StageWidth - this.FUIWindowConfirmationSell.WindowWidth) / 2;
         this.FUIWindowConfirmationSell.y = (FUICore.StageHeight - this.FUIWindowConfirmationSell.WindowHeight) / 2;
      }
      
      protected function ApplianceOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TOverlayer = null;
         var _loc4_:TInventory = null;
         _loc4_ = param2 as TInventory;
         _loc3_ = this.FOverlayerAppliance;
         if(_loc3_ != null)
         {
            _loc3_.Context = _loc4_;
            _loc3_.Render(FUICore.MouseCoordinate);
            _loc3_.Show();
         }
      }
      
      protected function ApplianceOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TOverlayer = null;
         var _loc4_:TInventory = null;
         _loc4_ = param2 as TInventory;
         _loc3_ = this.FOverlayerAppliance;
         if(_loc3_ != null)
         {
            _loc3_.Hide();
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_AWAKEN.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.MainPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_AWAKEN.MainPanelName) as Sprite;
         addChild(this.MainPanel);
         this.setChildIndex(this.MainPanel,0);
         this.FProcessorWindowManAwakenPanel.SetPanel = this.MainPanel;
         this.FTanSuoBtn = new TGoldCallBtn(this);
         this.FTanSuoBtn.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTanSuoBtn);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationSell);
         this.FUIWindowConfirmationSell.SetCheckBox(true);
         this.FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_Awaken);
         this.FOverlayerAppliance.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         this.FIsInitilization = 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.AWAKEN_ChangeCount1) as TConfigValue;
         this.FAwakenDatas.ChangeCountVec[0] = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.AWAKEN_ChangeCount2) as TConfigValue;
         this.FAwakenDatas.ChangeCountVec[1] = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.AWAKEN_ChangeCount3) as TConfigValue;
         this.FAwakenDatas.ChangeCountVec[2] = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.AWAKEN_ChangeCount4) as TConfigValue;
         this.FAwakenDatas.SuiPianId = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90600006) as TConfigValue;
         this.FAwakenDatas.DiJiDanCiMastCount = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90600007) as TConfigValue;
         this.FAwakenDatas.ZhongJiDanCiMastCount = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90600008) as TConfigValue;
         this.FAwakenDatas.GaoJiDanCiMastCount = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90600009) as TConfigValue;
         this.FAwakenDatas.DiJiPiLiangDanCiMastCount = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90600010) as TConfigValue;
         this.FAwakenDatas.ZhongJiPiLiangDanCiMastCount = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90600011) as TConfigValue;
         this.FAwakenDatas.GaoJiPiLiangDanCiMastCount = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.AWAKEN_ChangeCount6) as TConfigValue;
         this.FAwakenDatas.PiLiangMastCount = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.AWAKEN_ChangeCount7) as TConfigValue;
         this.FAwakenDatas.BarCount = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.AWAKEN_ChangeCount8) as TConfigValue;
         this.FTipDec1 = _loc1_.Value as String;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.AWAKEN_ChangeCount9) as TConfigValue;
         this.FTipDec2 = _loc1_.Value as String;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.AWAKEN_ChangeCount10) as TConfigValue;
         this.FTipDec3 = _loc1_.Value as String;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90600021) as TConfigValue;
         this.FAwakenDatas.DaoJiDiJiTanSuoCount = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90600022) as TConfigValue;
         this.FAwakenDatas.DaoJiZhongJiTanSuoCount = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90600023) as TConfigValue;
         this.FAwakenDatas.DaoJiGaoJiTanSuoCount = _loc1_.Value as Vector.<uint>;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         if(!this.FIsInitilization)
         {
            return;
         }
         this.FProcessorWindowManChangePanel.UpdateImage();
         this.FProcessorWindowManAwakenPanel.UpdateImage();
         this.FProcessorWindowManAwakenPanel.updateMoney();
         this.FProcessorWindowManCombiningPanel.UpdateImage();
         this.FProcessorWindowManSkillPanel.UpdateImage();
         super.LogicsPerform();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowManAwakenPanel.Load();
            this.FProcessorWindowManChangePanel.Load();
            this.FProcessorWindowManCombiningPanel.Load();
            this.FProcessorWindowManSkillPanel.Load();
            return;
         }
         setTimeout(this.CloseChat,50);
         this.PACKETID_C2S_Awaken_Get_Idolum_Info();
         this.PACKETID_C2S_Awaken_Get_Log_Info();
         this.PACKETID_C2S_Awaken_Get_Bag_Info();
         this.OpenPanelByType(1);
      }
      
      public function OpenPanelByType(param1:int) : void
      {
         this.FProcessorWindowManAwakenPanel.visible = false;
         this.FProcessorWindowManChangePanel.visible = false;
         this.FProcessorWindowManCombiningPanel.visible = false;
         this.FProcessorWindowManSkillPanel.visible = false;
         switch(param1)
         {
            case 1:
               this.FProcessorWindowManAwakenPanel.visible = true;
               break;
            case 2:
               this.FProcessorWindowManChangePanel.visible = true;
               this.FProcessorWindowManChangePanel.UpdateView();
               break;
            case 3:
               this.FProcessorWindowManCombiningPanel.visible = true;
               this.FProcessorWindowManCombiningPanel.OpenThisPanel();
               break;
            case 4:
               this.FProcessorWindowManSkillPanel.visible = true;
               this.FProcessorWindowManSkillPanel.OpenThisPanel();
         }
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         if(this.FOnSetChatOptions != null)
         {
            this.FOnSetChatOptions(this,true);
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Awaken_Get_Idolum_Info,this.PACKETID_S2C_Awaken_Get_Idolum_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Awaken_Get_Bag_Info,this.PACKETID_S2C_Awaken_Get_Bag_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Awaken_Get_OnOff_Skill_Info,this.PACKETID_S2C_Awaken_Get_OnOff_Skill_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Awaken_Search_Idolum_Info,this.PACKETID_S2C_Awaken_Search_Idolum_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Awaken_Exchange_Idolum_Info,this.PACKETID_S2C_Awaken_Exchange_Idolum_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Awaken_OnOff_Skill_Info,this.PACKETID_S2C_Awaken_OnOff_Skill_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Awaken_Synthesis_Skill_Info,this.PACKETID_S2C_Awaken_Synthesis_Skill_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Awaken_Get_Log_Info,this.PACKETID_S2C_Awaken_Get_Log_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Awaken_Change_Bag,this.PACKETID_S2C_Awaken_Change_Bag);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Awaken_Auto_Fenjie,this.PACKETID_S2C_Awaken_Auto_Fenjie);
      }
      
      protected function PACKETID_S2C_Awaken_Change_Bag(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         this.FUnstreamizerAwaken.AwakenKnapsackChange(_loc3_,this.FAwakenDatas);
      }
      
      protected function PACKETID_C2S_Awaken_Get_Log_Info() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Awaken_Get_Log_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_S2C_Awaken_Get_Log_Info(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         this.FUnstreamizerAwaken.AwakenGetRewardTakeNotes(_loc3_,this.FAwakenDatas);
         this.FProcessorWindowManAwakenPanel.UpdategetRewardNone();
      }
      
      protected function PACKETID_C2S_Awaken_Synthesis_Skill_Info(param1:int, param2:uint, param3:int, param4:String, param5:int, param6:int = 0) : void
      {
         var _loc7_:TPacket = null;
         var _loc8_:ByteArray = null;
         this.CurName_ = param4;
         this.GetGoodsCount = param5;
         _loc7_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Awaken_Synthesis_Skill_Info);
         _loc7_.Data.writeUnsignedInt(param1);
         _loc7_.Data.writeUnsignedInt(param2);
         _loc7_.Data.writeUnsignedInt(param3);
         _loc7_.Data.writeUnsignedInt(param6);
         SNetworkCore.Transceiver.PacketTransmit(_loc7_);
      }
      
      protected function PACKETID_S2C_Awaken_Synthesis_Skill_Info(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         EffectGenerateText(TUtilityString.Format(STRING_AWAKEN.STRING_WeiTiShi,this.CurName_,this.GetGoodsCount));
         this.FAwakenDatas.CommonCount = _loc3_.readUnsignedInt();
         this.FProcessorWindowManCombiningPanel.UpdateFenJieView();
      }
      
      protected function PACKETID_S2C_Awaken_Auto_Fenjie(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = param1.Data;
         var _loc5_:TAwakenConfig = null;
         _loc2_ = int(_loc4_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc3_ = int(_loc4_.readUnsignedInt());
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_AwakenConfig,11000001) as TAwakenConfig;
         EffectGenerateText(TUtilityString.Format(STRING_AWAKEN.STRING_WeiTiShi,_loc5_.Name,_loc3_));
         this.FProcessorWindowManCombiningPanel.UpdateFenJieView();
      }
      
      protected function PACKETID_C2S_Awaken_OnOff_Skill_Info(param1:AwakenDateCELL, param2:int, param3:int) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Awaken_OnOff_Skill_Info);
         _loc4_.Data.writeUnsignedInt(param2);
         _loc4_.Data.writeUnsignedInt(param1.AwakenConfigDate.Identifier);
         _loc4_.Data.writeUnsignedInt(param3);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function PACKETID_S2C_Awaken_OnOff_Skill_Info(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FProcessorWindowManSkillPanel.SetIdForHero();
         this.FProcessorWindowManSkillPanel.UpdateTwoBaseCell();
         this.FProcessorWindowManSkillPanel.ChangVec();
         this.FProcessorWindowManSkillPanel.UpdateSlot();
      }
      
      protected function PACKETID_C2S_Awaken_Exchange_Idolum_Info(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         this.CurChangeType = param1;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Awaken_Exchange_Idolum_Info);
         _loc2_.Data.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PACKETID_S2C_Awaken_Exchange_Idolum_Info(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         EffectGenerateText(STRING_AWAKEN.Str777_0);
         ++this.FAwakenDatas.DangRiYiDuiHuanCount[this.CurChangeType - 1];
         this.FProcessorWindowManChangePanel.UpdateView();
         this.FProcessorWindowManAwakenPanel.UpdateView();
      }
      
      protected function PACKETID_C2S_Awaken_Search_Idolum_Info(param1:uint) : void
      {
         var _loc2_:TAwakenExploration = null;
         this.CurTempId = param1;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_AwakenExploration,param1) as TAwakenExploration;
         if(!_loc2_)
         {
            return;
         }
         this.CurBigIndex = _loc2_.Type;
         this.CurLittleIndex = _loc2_.SubType;
         if(_loc2_.CostType == 2)
         {
            if(this.GetBoolearn())
            {
               this.olnySendPacket();
            }
            else
            {
               this.FUIWindowConfirmationSell.SetCheckBox(true);
               this.FUIWindowConfirmationSell.SetSelectedOrNot(false);
               this.FUIWindowConfirmationSell.SetHtml = TUtilityString.Format(STRING_AWAKEN.TanKuangTipHtml,_loc2_.Cost,_loc2_.SubType == 1 ? STRING_AWAKEN.Str100 : STRING_AWAKEN.Str101);
               this.FUIWindowConfirmationSell.visible = true;
            }
         }
         else
         {
            this.olnySendPacket();
         }
      }
      
      protected function GetBoolearn() : Boolean
      {
         var _loc1_:Boolean = false;
         switch(this.CurBigIndex)
         {
            case 1:
               if(this.CurLittleIndex == 1)
               {
                  _loc1_ = this.SixBooVec[0];
               }
               else
               {
                  _loc1_ = this.SixBooVec[1];
               }
               break;
            case 2:
               if(this.CurLittleIndex == 1)
               {
                  _loc1_ = this.SixBooVec[2];
               }
               else
               {
                  _loc1_ = this.SixBooVec[3];
               }
               break;
            case 3:
               if(this.CurLittleIndex == 1)
               {
                  _loc1_ = this.SixBooVec[4];
               }
               else
               {
                  _loc1_ = this.SixBooVec[5];
               }
         }
         return _loc1_;
      }
      
      protected function WindowConfirmationSellOnCancel(param1:Object = null) : void
      {
         this.FAwakenDatas.TanSuoBtnIsCanClick = 0;
         switch(this.CurBigIndex)
         {
            case 1:
               if(this.CurLittleIndex == 1)
               {
                  this.SixBooVec[0] = false;
               }
               else
               {
                  this.SixBooVec[1] = false;
               }
               break;
            case 2:
               if(this.CurLittleIndex == 1)
               {
                  this.SixBooVec[2] = false;
               }
               else
               {
                  this.SixBooVec[3] = false;
               }
               break;
            case 3:
               if(this.CurLittleIndex == 1)
               {
                  this.SixBooVec[4] = false;
               }
               else
               {
                  this.SixBooVec[5] = false;
               }
         }
      }
      
      protected function OnCheckBoxSelected(param1:Object = null, param2:Boolean = false) : void
      {
         switch(this.CurBigIndex)
         {
            case 1:
               if(this.CurLittleIndex == 1)
               {
                  this.SixBooVec[0] = param2;
               }
               else
               {
                  this.SixBooVec[1] = param2;
               }
               break;
            case 2:
               if(this.CurLittleIndex == 1)
               {
                  this.SixBooVec[2] = param2;
               }
               else
               {
                  this.SixBooVec[3] = param2;
               }
               break;
            case 3:
               if(this.CurLittleIndex == 1)
               {
                  this.SixBooVec[4] = param2;
               }
               else
               {
                  this.SixBooVec[5] = param2;
               }
         }
      }
      
      protected function olnySendPacket() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Awaken_Search_Idolum_Info);
         _loc1_.Data.writeUnsignedInt(this.CurTempId);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function WindowConfirmationSellOnOK(param1:Object = null) : void
      {
         this.olnySendPacket();
      }
      
      protected function PACKETID_S2C_Awaken_Search_Idolum_Info(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            this.FAwakenDatas.TanSuoBtnIsCanClick = 0;
            return;
         }
         EffectGenerateText(STRING_AWAKEN.Str6);
         this.FUnstreamizerAwaken.AwakenTanSuoBack(_loc3_,this.FAwakenDatas);
         this.FProcessorWindowManAwakenPanel.StartPlayer();
         this.Nimei = 7;
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Awaken,SLogicsCore.AwakenDate.CheckStatus());
         this.PACKETID_C2S_Awaken_Get_Idolum_Info();
      }
      
      protected function PACKETID_S2C_Awaken_Get_OnOff_Skill_Info(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         this.FUnstreamizerAwaken.AwakenSkillInformation(_loc3_,this.FAwakenDatas);
      }
      
      protected function PACKETID_C2S_Awaken_Get_Bag_Info() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Awaken_Get_Bag_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_S2C_Awaken_Get_Bag_Info(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         this.FUnstreamizerAwaken.AwakenPacksackInformation(_loc3_,this.FAwakenDatas);
      }
      
      protected function PACKETID_C2S_Awaken_Get_Idolum_Info() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Awaken_Get_Idolum_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_S2C_Awaken_Get_Idolum_Info(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         this.FUnstreamizerAwaken.Unstreamize(_loc3_,this.FAwakenDatas,this);
         this.FProcessorWindowManAwakenPanel.UpdateView();
         if(this.Nimei == 7)
         {
            this.FProcessorWindowManAwakenPanel.UpdateTip();
         }
         this.Nimei = 0;
      }
      
      protected function BackTeSguFunOver(param1:int, param2:int) : void
      {
         switch(param1)
         {
            case 0:
               this.ThiNT.Content = STRING_AWAKEN.STRING_Si0[param2];
               break;
            case 1:
               this.ThiNT.Content = STRING_AWAKEN.STRING_Si1[param2];
               break;
            case 2:
               this.ThiNT.Content = STRING_AWAKEN.STRING_Si2[param2];
         }
         if(this.FTanSuoBtn)
         {
            this.FTanSuoBtn.Context = this.ThiNT;
            this.FTanSuoBtn.Render(FUICore.MouseCoordinate);
            this.FTanSuoBtn.Show();
         }
      }
      
      protected function BackFunOver(param1:uint, param2:int, param3:int) : void
      {
         var _loc4_:TAwakenExploration = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:TArticle = null;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_AwakenExploration,param1) as TAwakenExploration;
         var _loc5_:String = "";
         if(_loc4_)
         {
            _loc6_ = _loc4_.Round - 1;
            switch(_loc4_.SubType)
            {
               case 3:
                  if(param3 == 1)
                  {
                     _loc7_ = int(SLogicsCore.AwakenDate.GetDanCiMastCountByType(param2));
                     _loc8_ = int(SLogicsCore.AwakenDate.DanCiCountVec[param2]);
                     this.ThiNT.Content = TUtilityString.Format(STRING_AWAKEN.STRING_Tip[0],_loc7_ - _loc8_);
                  }
                  else
                  {
                     _loc7_ = int(SLogicsCore.AwakenDate.GetPiLiangMastCountByType(param2));
                     _loc8_ = int(SLogicsCore.AwakenDate.PiLiangCountVec[param2]);
                     this.ThiNT.Content = TUtilityString.Format(STRING_AWAKEN.STRING_Tip[0],_loc7_ - _loc8_);
                  }
                  break;
               case 4:
                  _loc7_ = int(SLogicsCore.AwakenDate.GetArrByType(param2)[0]);
                  _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc7_) as TArticle;
                  if(param3 == 1)
                  {
                     _loc7_ = int(SLogicsCore.AwakenDate.GetDanCiMastCountByType(param2));
                     _loc8_ = int(SLogicsCore.AwakenDate.DanCiCountVec[param2]);
                     this.ThiNT.Content = TUtilityString.Format(STRING_AWAKEN.STRING_Tip[4],CONST_COMMON.QUALITYCOLOR_INDEX_1[_loc9_.Quality],_loc9_.Name,_loc7_ - _loc8_);
                  }
                  else
                  {
                     _loc7_ = int(SLogicsCore.AwakenDate.GetPiLiangMastCountByType(param2));
                     _loc8_ = int(SLogicsCore.AwakenDate.PiLiangCountVec[param2]);
                     this.ThiNT.Content = TUtilityString.Format(STRING_AWAKEN.STRING_Tip[4],CONST_COMMON.QUALITYCOLOR_INDEX_1[_loc9_.Quality],_loc9_.Name,_loc7_ - _loc8_);
                  }
                  break;
               case 1:
                  if(_loc4_.CostType == 1)
                  {
                     _loc5_ = STRING_AWAKEN.STRING_Tip[1];
                  }
                  else
                  {
                     _loc5_ = STRING_AWAKEN.STRING_Tip[2];
                  }
                  _loc7_ = int(SLogicsCore.AwakenDate.GetDanCiMastCountByType(param2));
                  this.ThiNT.Content = TUtilityString.Format(_loc5_,_loc4_.Cost,_loc7_ - _loc6_);
                  break;
               case 2:
                  _loc6_ = _loc4_.Round - 1;
                  _loc7_ = int(SLogicsCore.AwakenDate.GetDanCiMastCountByType(param2));
                  this.ThiNT.Content = TUtilityString.Format(STRING_AWAKEN.STRING_TipHtml[_loc4_.Type - 1],_loc4_.Cost,SLogicsCore.AwakenDate.GetPiLiangMastCountByType(param2) - _loc6_);
            }
         }
         else
         {
            this.ThiNT.Content = STRING_AWAKEN.STRING_Tip[3];
         }
         if(this.FTanSuoBtn)
         {
            this.FTanSuoBtn.Context = this.ThiNT;
            this.FTanSuoBtn.Render(FUICore.MouseCoordinate);
            this.FTanSuoBtn.Show();
         }
      }
      
      protected function BackFunOut() : void
      {
         if(this.FTanSuoBtn != null)
         {
            this.FTanSuoBtn.Hide();
         }
      }
      
      protected function BackFunMove() : void
      {
         if(this.FTanSuoBtn != null)
         {
            this.FTanSuoBtn.Render(FUICore.MouseCoordinate);
         }
      }
      
      protected function SlotBackMove(param1:AwakenDateCELL) : void
      {
         this.BackFunMove();
      }
      
      protected function SlotBackOut(param1:AwakenDateCELL) : void
      {
         if(this.FTanSuoBtn != null)
         {
            this.FTanSuoBtn.Hide();
         }
      }
      
      protected function SlotBackOver(param1:AwakenDateCELL) : void
      {
         var _loc2_:TAwakenConfig = null;
         var _loc3_:String = null;
         switch(param1.AwakenConfigDate.Type)
         {
            case 1:
            case 2:
               this.ThiNT.Content = TUtilityString.Format(STRING_AWAKEN.AWKEN_SUIPIANTIP,CONST_COMMON.QUALITYCOLOR_INDEX_1[param1.AwakenConfigDate.Quality],param1.AwakenConfigDate.Name,param1.AwakenConfigDate.Description);
               break;
            case 3:
            case 4:
               _loc3_ = "";
               if(param1.AwakenConfigDate.Type == 3)
               {
                  _loc3_ = STRING_AWAKEN.Str666;
               }
               else
               {
                  _loc3_ = STRING_AWAKEN.Str555;
               }
               if(param1.AwakenSkillDate.NextSkillID != 0)
               {
                  _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_AwakenConfig,param1.AwakenSkillDate.NextSkillID) as TAwakenConfig;
                  this.ThiNT.Content = TUtilityString.Format(STRING_AWAKEN.AWKEN_SKILLTIP0,CONST_COMMON.QUALITYCOLOR_INDEX_1[param1.AwakenConfigDate.Quality],param1.AwakenConfigDate.Name,_loc3_,CONST_COMMON.QUALITYCOLOR_INDEX_1[2],param1.AwakenConfigDate.Description,_loc2_.Description);
               }
               else
               {
                  this.ThiNT.Content = TUtilityString.Format(STRING_AWAKEN.AWKEN_SKILLTIP1,CONST_COMMON.QUALITYCOLOR_INDEX_1[param1.AwakenConfigDate.Quality],param1.AwakenConfigDate.Name,_loc3_,CONST_COMMON.QUALITYCOLOR_INDEX_1[2],param1.AwakenConfigDate.Description);
               }
         }
         if(this.FTanSuoBtn)
         {
            this.FTanSuoBtn.Context = this.ThiNT;
            this.FTanSuoBtn.Render(FUICore.MouseCoordinate);
            this.FTanSuoBtn.Show();
         }
      }
      
      protected function CloseChat() : void
      {
         if(this.FOnSetChatOptions != null)
         {
            this.FOnSetChatOptions(this,false);
         }
      }
      
      protected function BackMainScreenCopy() : void
      {
         if(this.FBackMainScreen != null)
         {
            this.FBackMainScreen(this);
         }
      }
      
      public function set BackMainScreen(param1:Function) : void
      {
         this.FBackMainScreen = param1;
      }
      
      public function set OnSetChatOptions(param1:Function) : void
      {
         this.FOnSetChatOptions = param1;
      }
   }
}

