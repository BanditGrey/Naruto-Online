package Processors.Game.Lobby.EightDoor
{
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TEightInnerGates_Attr;
   import Logics.DatebaseVO.VO.TEightInnerGates_Obtain;
   import Logics.DatebaseVO.VO.THeroTalent;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.DatebaseVO.VO.TVipConfig;
   import Logics.EightDoor.TEightDoorLogicData;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyPlate;
   import Processors.Game.Lobby.EightDoor.Panel.TProcessorWindowOnePanel;
   import Processors.Game.Lobby.EightDoor.Panel.TProcessorWindowTwoPanel;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.EightDoor.TEightDoorTip;
   import Rendering.Overlayers.FeteBlood.TExpDecTip;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_EIGHTDOOR;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_EIGHTDOOR;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   
   public class TProcessorWindowManEightDoor extends TProcessorLobbyPlate
   {
      
      public static const EIGHT:int = 8;
      
      protected var FMainPanel:Sprite = null;
      
      protected var FMC_OnePanel:MovieClip = null;
      
      protected var FMC_TwoPanel:MovieClip = null;
      
      protected var FProcessorWindowOnePanel:TProcessorWindowOnePanel;
      
      protected var FProcessorWindowTwoPanel:TProcessorWindowTwoPanel;
      
      protected var FIsInitilization:int;
      
      protected var FMC_Close:SimpleButton = null;
      
      protected var FCloseHelp:MovieClip = null;
      
      protected var FBTN_AutoChallenge:MovieClip = null;
      
      protected var FBTN_AutoChallengeCopy:MovieClip = null;
      
      protected var FThisLogicData:TEightDoorLogicData;
      
      protected var FTExpDecTip:TExpDecTip = null;
      
      protected var FUIWindowAdvancedPractice:TUIWindowConfirmation;
      
      protected var FTGoldCallBtn:TEightDoorTip = null;
      
      protected var ThiNT:THint;
      
      protected var FRewardVecId:Vector.<uint>;
      
      protected var FRewardVecCount:Vector.<uint>;
      
      protected var value2:int;
      
      protected var value3:int;
      
      protected var AllType:int;
      
      protected var type1:Boolean;
      
      protected var type2:Boolean;
      
      protected var type3:Boolean;
      
      protected var type4:Boolean;
      
      protected var type5:Boolean;
      
      protected var type6:Boolean;
      
      protected var FSetChatPositionByType:Function;
      
      protected var FBackMainScreen:Function;
      
      protected var FOnSetChatOptions:Function;
      
      protected var FHelpTips:THint;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      public function TProcessorWindowManEightDoor(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FRewardVecId = new Vector.<uint>();
         this.FRewardVecCount = new Vector.<uint>();
         this.FThisLogicData = SLogicsCore.EightDoorLogicData;
         this.FProcessorWindowOnePanel = new TProcessorWindowOnePanel();
         this.FProcessorWindowOnePanel.PointCellBack = this.PACKETID_C2S_Eight_Inner_Gates_Open_Gates;
         this.FProcessorWindowOnePanel.BackEightDoorOver = this.BackEightDoorOver;
         this.FProcessorWindowOnePanel.BackEightDoorOut = this.BackEightDoorOut;
         this.FProcessorWindowOnePanel.BackEightDoorMove = this.BackEightDoorMove;
         this.FProcessorWindowOnePanel.BackMainPointOver = this.BackMainPointOver;
         this.FProcessorWindowOnePanel.BackMainPointOut = this.BackMainPointOut;
         this.FProcessorWindowOnePanel.BackMainPointMove = this.BackMainPointMove;
         this.FProcessorWindowTwoPanel = new TProcessorWindowTwoPanel();
         this.FProcessorWindowTwoPanel.BuyCount = this.PACKETID_C2S_Eight_Inner_Gates_Buy_Tms;
         this.FProcessorWindowTwoPanel.FanBeiFun = this.PACKETID_C2S_Eight_Inner_Gates_Blast_Double;
         this.FProcessorWindowTwoPanel.PiShanFun = this.PACKETID_C2S_Eight_Inner_Gates_Blast_Cliffs;
         this.FProcessorWindowTwoPanel.BackOver = this.GetStoreBackOver;
         this.FProcessorWindowTwoPanel.BackOut = this.GetStoreBackOut;
         this.FProcessorWindowTwoPanel.BackMove = this.GetStoreBackMove;
         this.FProcessorWindowTwoPanel.BaoXiangOver = this.BaoXiangOver;
         this.FProcessorWindowTwoPanel.BaoXiangOut = this.GetStoreBackOut;
         this.FProcessorWindowTwoPanel.BaoXiangMove = this.GetStoreBackMove;
         this.FTExpDecTip = new TExpDecTip(param1);
         this.FTExpDecTip.visible = false;
         this.FTGoldCallBtn = new TEightDoorTip(param1);
         this.FTGoldCallBtn.Visible = false;
         this.FUIWindowAdvancedPractice = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowAdvancedPractice.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowAdvancedPractice.OnCheckBoxSelected = this.OnCheckBoxSelected;
         this.FUIWindowAdvancedPractice.x = (FUICore.StageWidth - this.FUIWindowAdvancedPractice.WindowWidth) / 2;
         this.FUIWindowAdvancedPractice.y = (FUICore.StageHeight - this.FUIWindowAdvancedPractice.WindowHeight) / 2;
         this.ThiNT = new THint();
         this.FHelpTips = new THint();
         SetUIModuleID(CONST_MODULES.MODULE_EightDoor);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_EIGHTDOOR.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMainPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_EIGHTDOOR.MainPanelName) as Sprite;
         addChild(this.FMainPanel);
         this.FMC_OnePanel = this.FMainPanel["MC_OnePanel"];
         this.FMC_TwoPanel = this.FMainPanel["MC_TwoPanel"];
         this.FMC_Close = this.FMainPanel["MC_Close"]["BTN_Close"];
         this.FCloseHelp = this.FMainPanel["MC_Close"];
         this.FBTN_AutoChallenge = this.FMainPanel["BTN_AutoChallenge"];
         this.FBTN_AutoChallengeCopy = this.FMainPanel["BTN_AutoChallengeCopy"];
         TGameUtil.setButtonMode(this.FBTN_AutoChallenge,true);
         TGameUtil.setButtonMode(this.FBTN_AutoChallengeCopy,true);
         setTimeout(this.CloseChat,50);
         this.FProcessorWindowOnePanel.ThisPanel = this.FMC_OnePanel;
         this.FProcessorWindowTwoPanel.ThisPanel = this.FMC_TwoPanel;
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this.Parent);
         this.FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         TUtilityUIOverlayer.ResourcesDispatch(this.FTExpDecTip);
         TUtilityUIOverlayer.ResourcesDispatch(this.FTGoldCallBtn);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowAdvancedPractice);
         this.FUIWindowAdvancedPractice.SetCheckBox(true);
         this.FIsInitilization = 1;
         this.OpenPanelByType(0);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ProcessorResize() : void
      {
         if(!this.FIsInitilization)
         {
         }
      }
      
      protected function AddListener() : void
      {
         this.FMC_Close.addEventListener(MouseEvent.CLICK,this.ClickHandle);
         this.FMainPanel["MC_Close"]["BTN_Help"].addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         this.FMainPanel["MC_Close"]["BTN_Help"].addEventListener(MouseEvent.ROLL_OUT,this.ButtonHelpOnOut);
         this.FBTN_AutoChallenge.addEventListener(MouseEvent.CLICK,this.ClickHandle);
         this.FBTN_AutoChallengeCopy.addEventListener(MouseEvent.CLICK,this.ClickHandle);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.AddListener();
         if(this.FIsInitilization == 2)
         {
            return;
         }
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_EIGHTDOOR.EightDoorMoRenOpenCount) as TConfigValue;
         this.FThisLogicData.EightDoorMoRenOpenCount = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_EIGHTDOOR.EightDoorBuyCountGoldCount) as TConfigValue;
         this.FThisLogicData.EightDoorBuyCountGoldCount = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_EIGHTDOOR.EightDoorPuTongFanBeiGoldCount) as TConfigValue;
         this.FThisLogicData.EightDoorPuTongFanBeiGoldCount = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_EIGHTDOOR.EightDoorBiDingFanBeiGoldCount) as TConfigValue;
         this.FThisLogicData.EightDoorBiDingFanBeiGoldCount = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_EIGHTDOOR.EightDoorBuyMaxCount) as TConfigValue;
         this.FThisLogicData.EightDoorBuyMaxCount = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_EIGHTDOOR.EightDoorBuyMaxPageCount) as TConfigValue;
         this.FThisLogicData.EightDoorBuyMaxPageCount = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90700011) as TConfigValue;
         this.FThisLogicData.CostTypeVec[0] = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90700013) as TConfigValue;
         this.FThisLogicData.CostTypeVec[1] = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90700015) as TConfigValue;
         this.FThisLogicData.CostTypeVec[2] = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90700012) as TConfigValue;
         this.FThisLogicData.WenRouTiaoJiao = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90700012) as TConfigValue;
         this.FThisLogicData.WenRouTiaoJiao = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90700014) as TConfigValue;
         this.FThisLogicData.EMengTiaoJiao = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90700016) as TConfigValue;
         this.FThisLogicData.DiYuTiaoJiao = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90700019) as TConfigValue;
         this.FThisLogicData.TianShiId = _loc1_.Value as uint;
         this.FIsInitilization = 2;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         if(!this.FIsInitilization)
         {
            return;
         }
         this.FProcessorWindowTwoPanel.updateMoney();
         super.LogicsPerform();
      }
      
      protected function OpenPanelByType(param1:int) : void
      {
         this.FMC_OnePanel.visible = false;
         this.FMC_TwoPanel.visible = false;
         this.FBTN_AutoChallenge.visible = false;
         this.FBTN_AutoChallengeCopy.visible = false;
         switch(param1)
         {
            case 0:
               this.FBTN_AutoChallengeCopy.visible = true;
               this.FMC_OnePanel.visible = true;
               break;
            case 1:
               this.PACKETID_C2S_Eight_Inner_Gates_Blast_Award();
               this.FMC_TwoPanel.visible = true;
               this.FBTN_AutoChallenge.visible = true;
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Eight_Inner_Gates_Mission,this.PACKETID_S2C_Eight_Inner_Gates_Mission);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Eight_Inner_Gates_Open_Gates,this.PACKETID_S2C_Eight_Inner_Gates_Open_Gates);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Eight_Inner_Gates_Blast_Cliffs,this.PACKETID_S2C_Eight_Inner_Gates_Blast_Cliffs);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Eight_Inner_Gates_Buy_Tms,this.PACKETID_S2C_Eight_Inner_Gates_Buy_Tms);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Eight_Inner_Gates_Blast_Double,this.PACKETID_S2C_Eight_Inner_Gates_Blast_Double);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Eight_Inner_Gates_Blast_Award,this.PACKETID_S2C_Eight_Inner_Gates_Blast_Award);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Eight_Inner_Gates_Hero_Talent,this.PACKETID_S2C_Eight_Inner_Gates_Hero_Talent);
      }
      
      protected function PACKETID_C2S_Eight_Inner_Gates_Mission() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Eight_Inner_Gates_Mission);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_S2C_Eight_Inner_Gates_Mission(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:TEightInnerGates_Attr = null;
         var _loc9_:TEightInnerGates_Attr = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         this.FThisLogicData.GodStoreCount = _loc3_.readUnsignedInt();
         this.FThisLogicData.PiShanCount = _loc3_.readUnsignedInt();
         this.FThisLogicData.PiShanBuyCount = _loc3_.readUnsignedInt();
         this.FThisLogicData.OpenedLastId = _loc3_.readUnsignedInt();
         if(this.FThisLogicData.OpenedLastId == 0)
         {
            this.FProcessorWindowOnePanel.UpdateByPage(0);
         }
         else
         {
            _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EightInnerGates_Attr,this.FThisLogicData.OpenedLastId) as TEightInnerGates_Attr;
            _loc11_ = this.FThisLogicData.OpenedLastId + 1;
            _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EightInnerGates_Attr,_loc11_) as TEightInnerGates_Attr;
            if(_loc9_)
            {
               if(_loc8_.MajorType == _loc9_.MajorType)
               {
                  if(_loc8_.Label == _loc9_.Label)
                  {
                     _loc12_ = _loc8_.Label;
                  }
                  else
                  {
                     _loc12_ = _loc9_.Label;
                  }
                  _loc7_ = _loc8_.MajorType.toString();
               }
               else
               {
                  _loc7_ = _loc9_.MajorType.toString();
                  _loc12_ = _loc9_.Label;
               }
            }
            else
            {
               _loc7_ = _loc8_.MajorType.toString();
               _loc12_ = _loc8_.Label;
            }
            _loc10_ = int(_loc7_.charAt(_loc7_.length - 1));
            this.FProcessorWindowOnePanel.CurIndex = _loc10_ - 1;
            this.FProcessorWindowOnePanel.UpdateByPage(_loc12_ - 1);
         }
         this.FProcessorWindowOnePanel.UpdateMainPoint();
         this.FProcessorWindowOnePanel.UpdateEightCell();
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_EightDoor,SLogicsCore.EightDoorLogicData.CheckStatus());
      }
      
      protected function PACKETID_C2S_Eight_Inner_Gates_Open_Gates(param1:TEightInnerGates_Attr) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Eight_Inner_Gates_Open_Gates);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1.MajorType);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PACKETID_S2C_Eight_Inner_Gates_Open_Gates(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.PACKETID_C2S_Eight_Inner_Gates_Mission();
      }
      
      protected function C_TO_S_2() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Eight_Inner_Gates_Blast_Cliffs);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(this.value2);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_EightDoor,SLogicsCore.EightDoorLogicData.CheckStatus());
      }
      
      protected function PACKETID_S2C_Eight_Inner_Gates_Blast_Cliffs(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         EffectGenerateText(STRING_EIGHTDOOR.str9);
         this.FProcessorWindowTwoPanel.BaoXiangIdVec.length = 0;
         this.FRewardVecId.length = 0;
         this.FRewardVecCount.length = 0;
         SLogicsCore.EightDoorLogicData.ClearVecLength();
         _loc4_ = _loc3_.readShort();
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            this.FProcessorWindowTwoPanel.BaoXiangIdVec.push(_loc3_.readUnsignedInt());
            _loc8_ = SLogicsCore.EightDoorLogicData.GetRewardVecById(_loc6_);
            _loc5_ = _loc3_.readShort();
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc9_ = uint(_loc3_.readShort());
               _loc8_.push(_loc9_);
               _loc10_ = _loc3_.readUnsignedInt();
               _loc8_.push(_loc10_);
               this.FRewardVecId.push(_loc10_);
               _loc11_ = _loc3_.readUnsignedInt();
               _loc8_.push(_loc11_);
               this.FRewardVecCount.push(_loc11_);
               _loc7_++;
            }
            _loc6_++;
         }
         ++SLogicsCore.EightDoorLogicData.PiShanCount;
         SLogicsCore.EightDoorLogicData.CurState = 1;
         this.FProcessorWindowTwoPanel.PlayerEffect();
         this.FProcessorWindowTwoPanel.UpdateView();
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_EightDoor,SLogicsCore.EightDoorLogicData.CheckStatus());
      }
      
      protected function WindowConfirmationOnOK(param1:Object) : void
      {
         switch(this.AllType)
         {
            case 1:
               this.C_TO_S();
               break;
            case 2:
            case 4:
            case 5:
               this.C_TO_S_2();
               break;
            case 3:
            case 6:
               this.C_TO_S_3();
         }
      }
      
      protected function C_TO_S() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Eight_Inner_Gates_Buy_Tms);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function OnCheckBoxSelected(param1:Object, param2:Boolean) : void
      {
         switch(this.AllType)
         {
            case 1:
               this.type1 = param2;
               break;
            case 2:
               this.type2 = param2;
               break;
            case 3:
               this.type3 = param2;
               break;
            case 4:
               this.type4 = param2;
               break;
            case 5:
               this.type5 = param2;
               break;
            case 6:
               this.type6 = param2;
         }
      }
      
      protected function PACKETID_C2S_Eight_Inner_Gates_Blast_Double(param1:int) : void
      {
         var _loc2_:int = 0;
         this.value3 = param1;
         switch(param1)
         {
            case 2:
               this.AllType = 3;
               break;
            case 3:
               this.AllType = 6;
         }
         if(param1 == 1)
         {
            this.C_TO_S_3();
         }
         else
         {
            this.FUIWindowAdvancedPractice.IsSelected = param1 == 2 ? this.type3 : this.type6;
            if(this.FUIWindowAdvancedPractice.IsSelected)
            {
               this.FUIWindowAdvancedPractice.SetSelectedOrNot(true);
            }
            else
            {
               this.FUIWindowAdvancedPractice.SetSelectedOrNot(false);
            }
            if(this.FUIWindowAdvancedPractice.IsSelected)
            {
               this.C_TO_S_3();
            }
            else
            {
               if(param1 == 2)
               {
                  _loc2_ = int(this.FThisLogicData.EightDoorPuTongFanBeiGoldCount);
               }
               else
               {
                  _loc2_ = int(this.FThisLogicData.EightDoorBiDingFanBeiGoldCount);
               }
               this.FUIWindowAdvancedPractice.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Eight2).DescribeString,_loc2_,STRING_EIGHTDOOR.str7[param1 - 2]);
               this.FUIWindowAdvancedPractice.Visible = true;
            }
         }
      }
      
      protected function PACKETID_C2S_Eight_Inner_Gates_Blast_Cliffs(param1:int) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Vector.<uint> = null;
         var _loc4_:uint = 0;
         this.value2 = param1;
         switch(param1)
         {
            case 1:
               this.AllType = 2;
               _loc2_ = this.type2;
               break;
            case 2:
               this.AllType = 4;
               _loc2_ = this.type4;
               break;
            case 3:
               this.AllType = 5;
               _loc2_ = this.type5;
         }
         if(_loc2_)
         {
            this.FUIWindowAdvancedPractice.SetSelectedOrNot(true);
         }
         else
         {
            this.FUIWindowAdvancedPractice.SetSelectedOrNot(false);
         }
         this.FUIWindowAdvancedPractice.IsSelected = _loc2_;
         if(this.FUIWindowAdvancedPractice.IsSelected)
         {
            this.C_TO_S_2();
         }
         else
         {
            switch(param1)
            {
               case 1:
                  _loc3_ = this.FThisLogicData.WenRouTiaoJiao;
                  break;
               case 2:
                  _loc3_ = this.FThisLogicData.EMengTiaoJiao;
                  break;
               case 3:
                  _loc3_ = this.FThisLogicData.DiYuTiaoJiao;
            }
            _loc4_ = this.FThisLogicData.PiShanCount;
            if(_loc4_ >= _loc3_.length)
            {
               _loc4_ = _loc3_.length - 1;
            }
            this.FUIWindowAdvancedPractice.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Eight0).DescribeString,_loc3_[_loc4_],STRING_EIGHTDOOR.str6[this.FThisLogicData.CostTypeVec[param1 - 1]],STRING_EIGHTDOOR.str5[param1 - 1]);
            this.FUIWindowAdvancedPractice.Visible = true;
         }
      }
      
      protected function PACKETID_C2S_Eight_Inner_Gates_Buy_Tms() : void
      {
         var _loc1_:TVipConfig = null;
         var _loc2_:uint = 0;
         this.AllType = 1;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_VipConfig,SLogicsCore.Character.VipLevel) as TVipConfig;
         if(this.type1)
         {
            this.FUIWindowAdvancedPractice.SetSelectedOrNot(true);
         }
         else
         {
            this.FUIWindowAdvancedPractice.SetSelectedOrNot(false);
         }
         this.FUIWindowAdvancedPractice.IsSelected = this.type1;
         if(this.FUIWindowAdvancedPractice.IsSelected)
         {
            this.C_TO_S();
         }
         else
         {
            _loc2_ = this.FThisLogicData.PiShanBuyCount;
            if(_loc2_ >= this.FThisLogicData.EightDoorBuyCountGoldCount.length)
            {
               _loc2_ = this.FThisLogicData.EightDoorBuyCountGoldCount.length - 1;
            }
            this.FUIWindowAdvancedPractice.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Eight1).DescribeString,this.FThisLogicData.EightDoorBuyCountGoldCount[_loc2_],_loc1_.AddEightInnerGatesTimes - this.FThisLogicData.PiShanBuyCount);
            this.FUIWindowAdvancedPractice.Visible = true;
         }
      }
      
      protected function PACKETID_S2C_Eight_Inner_Gates_Buy_Tms(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         EffectGenerateText(STRING_EIGHTDOOR.str8);
         ++SLogicsCore.EightDoorLogicData.PiShanBuyCount;
         this.FProcessorWindowTwoPanel.UpdateView();
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_EightDoor,SLogicsCore.EightDoorLogicData.CheckStatus());
      }
      
      protected function C_TO_S_3() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Eight_Inner_Gates_Blast_Double);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(this.value3);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_S2C_Eight_Inner_Gates_Blast_Double(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc4_ = _loc3_.readUnsignedInt();
         _loc5_ = _loc3_.readUnsignedInt();
         if(_loc5_ == 2 || _loc5_ == 3)
         {
            if(_loc4_)
            {
               EffectGenerateText(STRING_EIGHTDOOR.str10);
            }
            else
            {
               EffectGenerateText(STRING_EIGHTDOOR.str11);
            }
         }
         else
         {
            EffectGenerateText(STRING_BASEACTIVITY.FORMAT_GET);
         }
         this.PACKETID_C2S_Eight_Inner_Gates_Blast_Award();
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_EightDoor,SLogicsCore.EightDoorLogicData.CheckStatus());
      }
      
      protected function PACKETID_C2S_Eight_Inner_Gates_Blast_Award() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Eight_Inner_Gates_Blast_Award);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_S2C_Eight_Inner_Gates_Blast_Award(param1:TPacket) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:uint = 0;
         var _loc9_:int = 0;
         var _loc2_:ByteArray = param1.Data;
         this.FProcessorWindowTwoPanel.BaoXiangIdVec.length = 0;
         this.FRewardVecId.length = 0;
         this.FRewardVecCount.length = 0;
         SLogicsCore.EightDoorLogicData.ClearVecLength();
         _loc3_ = _loc2_.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            this.FProcessorWindowTwoPanel.BaoXiangIdVec.push(_loc2_.readUnsignedInt());
            _loc7_ = SLogicsCore.EightDoorLogicData.GetRewardVecById(_loc5_);
            _loc4_ = _loc2_.readShort();
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc7_.push(_loc2_.readShort());
               _loc8_ = _loc2_.readUnsignedInt();
               _loc7_.push(_loc8_);
               this.FRewardVecId.push(_loc8_);
               _loc8_ = _loc2_.readUnsignedInt();
               _loc7_.push(_loc8_);
               this.FRewardVecCount.push(_loc8_);
               _loc6_++;
            }
            _loc5_++;
         }
         _loc9_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ == 0)
         {
            SLogicsCore.EightDoorLogicData.CurState = 0;
         }
         else if(_loc9_)
         {
            SLogicsCore.EightDoorLogicData.CurState = 2;
         }
         else
         {
            SLogicsCore.EightDoorLogicData.CurState = 1;
         }
         SLogicsCore.EightDoorLogicData.GodStoreCount = _loc2_.readUnsignedInt();
         this.FProcessorWindowTwoPanel.PlayerEffect();
         this.FProcessorWindowTwoPanel.UpdateView();
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_EightDoor,SLogicsCore.EightDoorLogicData.CheckStatus());
      }
      
      protected function PACKETID_S2C_Eight_Inner_Gates_Hero_Talent(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:THero = null;
         var _loc6_:THeroTalent = null;
         var _loc4_:ByteArray = param1.Data;
         _loc2_ = _loc4_.readUnsignedInt();
         _loc3_ = _loc4_.readUnsignedInt();
         _loc5_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc2_);
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroTalent,_loc3_) as THeroTalent;
         if(_loc5_)
         {
            _loc5_.TalentName = _loc6_.TalentName;
            _loc5_.TalentDesc = _loc6_.TalentDesc;
         }
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_EightDoor,SLogicsCore.EightDoorLogicData.CheckStatus());
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!this.FIsInitilization)
         {
            return;
         }
         this.PACKETID_C2S_Eight_Inner_Gates_Mission();
         this.visible = true;
         setTimeout(this.CloseChat,50);
         this.OpenPanelByType(0);
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         if(this.FOnSetChatOptions != null)
         {
            this.FOnSetChatOptions(this,true);
         }
         this.visible = false;
      }
      
      protected function BackMainPointOver(param1:TEightInnerGates_Attr) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc2_:String = " ";
         _loc2_ += TUtilityString.Format(STRING_EIGHTDOOR.str15,param1.Name);
         _loc4_ = 0;
         while(_loc4_ < param1.AddAttrArr.length)
         {
            _loc3_ = param1.AddAttrArr[_loc4_];
            _loc2_ += TUtilityString.Format(STRING_EIGHTDOOR.str14,STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc3_[0])],_loc3_[1]);
            _loc4_++;
         }
         this.ThiNT.Content = _loc2_;
         this.FTGoldCallBtn.Context = this.ThiNT;
         this.FTGoldCallBtn.Render(FUICore.MouseCoordinate);
         this.FTGoldCallBtn.Show();
      }
      
      protected function BackMainPointOut() : void
      {
         if(this.FTGoldCallBtn != null)
         {
            this.FTGoldCallBtn.Hide();
         }
      }
      
      protected function BackMainPointMove() : void
      {
         if(this.FTGoldCallBtn != null)
         {
            this.FTGoldCallBtn.Render(FUICore.MouseCoordinate);
            this.FTGoldCallBtn.Show();
         }
      }
      
      protected function BaoXiangOver(param1:int) : void
      {
         var _loc2_:String = "";
         _loc2_ = TUtilityString.Format(STRING_EIGHTDOOR.str19,STRING_EIGHTDOOR.str18[param1]);
         this.ThiNT.Content = _loc2_;
         this.FTGoldCallBtn.Context = this.ThiNT;
         this.FTGoldCallBtn.Render(FUICore.MouseCoordinate);
         this.FTGoldCallBtn.Show();
      }
      
      protected function GetStoreBackOver(param1:int) : void
      {
         var _loc2_:TArticle = null;
         var _loc3_:Vector.<uint> = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:TEightInnerGates_Obtain = null;
         if(this.FTGoldCallBtn != null)
         {
            _loc3_ = SLogicsCore.EightDoorLogicData.GetRewardVecById(param1);
            _loc4_ = "";
            _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EightInnerGates_Obtain,this.FProcessorWindowTwoPanel.BaoXiangIdVec[param1]) as TEightInnerGates_Obtain;
            _loc4_ += TUtilityString.Format(STRING_EIGHTDOOR.str12,_loc7_.Name);
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length / 3)
            {
               _loc6_ = STRING_COMMON.GetItemNameByType(_loc3_[_loc5_ * 3],_loc3_[_loc5_ * 3 + 1]);
               _loc4_ += TUtilityString.Format(STRING_EIGHTDOOR.str13,_loc6_,_loc3_[_loc5_ * 3 + 2]);
               _loc5_++;
            }
            this.ThiNT.Content = _loc4_;
            this.FTGoldCallBtn.Context = this.ThiNT;
            this.FTGoldCallBtn.Render(FUICore.MouseCoordinate);
            this.FTGoldCallBtn.Show();
         }
      }
      
      protected function GetStoreBackOut() : void
      {
         if(this.FTGoldCallBtn != null)
         {
            this.FTGoldCallBtn.Hide();
         }
      }
      
      protected function GetStoreBackMove() : void
      {
         if(this.FTGoldCallBtn != null)
         {
            this.FTGoldCallBtn.Render(FUICore.MouseCoordinate);
            this.FTGoldCallBtn.Show();
         }
      }
      
      protected function BackEightDoorOver(param1:int, param2:Boolean = false, param3:String = "77") : void
      {
         var _loc4_:String = null;
         if(this.FTExpDecTip != null)
         {
            _loc4_ = "";
            if(param2)
            {
               _loc4_ = param3;
            }
            else if(param1 == 0)
            {
               _loc4_ = TUtilityString.Format(STRING_EIGHTDOOR.str4,SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevel(this.FProcessorWindowOnePanel.EightDoorCellVec[param1].EightInnerGates_Mission.Level));
            }
            else
            {
               _loc4_ = TUtilityString.Format(STRING_EIGHTDOOR.str3,SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevel(this.FProcessorWindowOnePanel.EightDoorCellVec[param1].EightInnerGates_Mission.Level),this.FProcessorWindowOnePanel.EightDoorCellVec[param1 - 1].EightInnerGates_Mission.Name);
            }
            this.FTExpDecTip.Context = _loc4_;
            this.FTExpDecTip.Render(FUICore.MouseCoordinate);
            this.FTExpDecTip.Show();
         }
      }
      
      protected function BackEightDoorOut(param1:int) : void
      {
         if(this.FTExpDecTip != null)
         {
            this.FTExpDecTip.Hide();
         }
      }
      
      protected function BackEightDoorMove(param1:int) : void
      {
         if(this.FTExpDecTip != null && this.FTExpDecTip.visible)
         {
            this.FTExpDecTip.Render(FUICore.MouseCoordinate);
         }
      }
      
      protected function ClickHandle(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_Close:
               this.BackMainScreenCopy();
               break;
            case this.FBTN_AutoChallenge:
               this.OpenPanelByType(0);
               this.PACKETID_C2S_Eight_Inner_Gates_Mission();
               break;
            case this.FBTN_AutoChallengeCopy:
               this.OpenPanelByType(1);
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
      
      public function get BackMainScreen() : Function
      {
         return this.FBackMainScreen;
      }
      
      public function set SetChatPositionByType(param1:Function) : void
      {
         this.FSetChatPositionByType = param1;
      }
      
      public function get OnSetChatOptions() : Function
      {
         return this.FOnSetChatOptions;
      }
      
      public function set OnSetChatOptions(param1:Function) : void
      {
         this.FOnSetChatOptions = param1;
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_70170087) as TSystemLanguage;
         this.FHelpTips.Content = _loc2_.Desc;
         this.UIHelpTipsHintOnOver(this,this.FHelpTips);
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         this.UIHelpTipsHintOnOut(this);
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
   }
}

