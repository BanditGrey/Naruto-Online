package Processors.Game.Lobby.TheWorldTree
{
   import Components.Slots.TUISlot;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TGodtreeDrop;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.TheWorldTree.TTheWorldTreeLogicData;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyPlate;
   import Processors.Game.Lobby.TheWorldTree.BigPanel.TheWorldTree;
   import Processors.Game.Lobby.TheWorldTree.LittlePanel.TPressorWindowBuyExpPopBuyFream;
   import Processors.Game.Lobby.TheWorldTree.LittlePanel.TPressorWindowCanWuJieSuanPopBuyFream;
   import Processors.Game.Lobby.TheWorldTree.LittlePanel.TPressorWindowCanWuOverPopBuyFream;
   import Processors.Game.Lobby.TheWorldTree.LittlePanel.TPressorWindowDrowUotReward;
   import Processors.Game.Lobby.TheWorldTree.LittlePanel.TProcessorWindowDuoTasking_ChangeType;
   import Processors.Game.Lobby.TheWorldTree.LittlePanel.TProcessorWindowDuoTasking_Congratulations;
   import Processors.Game.Lobby.TheWorldTree.LittlePanel.TProcessorWindowTheWorldTree_RiskPanel;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.FeteBlood.TExpDecTip;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_ThreeWorldTree;
   import Resources.Strings.STRING_THEWORLDTREE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   
   public class TProcessorWindowTheWorldTree extends TProcessorLobbyPlate
   {
      
      public static const FIVE:int = 6;
      
      protected var FTheWorldTreeMainPanel:Sprite;
      
      protected var FDuoTaskingMainPanel:Sprite;
      
      protected var FTheWorldTree:TheWorldTree = null;
      
      protected var FPressorWindowBuyExpPopBuyFream:TPressorWindowBuyExpPopBuyFream;
      
      protected var FPressorWindowCanWuOverPopBuyFream:TPressorWindowCanWuOverPopBuyFream;
      
      protected var FPressorWindowCanWuJieSuanPopBuyFream:TPressorWindowCanWuJieSuanPopBuyFream;
      
      protected var FPressorWindowDrowUotReward:TPressorWindowDrowUotReward;
      
      protected var FProcessorWindowDuoTasking_ChangeType:TProcessorWindowDuoTasking_ChangeType;
      
      protected var FProcessorWindowTheWorldTree_RiskPanel:TProcessorWindowTheWorldTree_RiskPanel;
      
      protected var FProcessorWindowDuoTasking_Congratulations:TProcessorWindowDuoTasking_Congratulations;
      
      protected var FLogicDate:TTheWorldTreeLogicData;
      
      protected var FFiveSlot:Vector.<TUISlot> = null;
      
      protected var FCurGetRewadId:int;
      
      protected var FIsInitilization:Boolean;
      
      protected var FTExpDecTip:TExpDecTip;
      
      protected var FUIWindowConfirmationSell:TUIWindowConfirmation;
      
      protected var FNiMeiType:int;
      
      protected var FNiMeiType1:int;
      
      protected var FNiMeiType2:int;
      
      protected var FNiMeiType3:int;
      
      protected var FNiMeiType4:int;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FSetChatPositionByType:Function;
      
      protected var FBackMainScreen:Function;
      
      protected var FUpdateHeroPower:Function;
      
      protected var FOnSetChatOptions:Function;
      
      protected var FUpdateOtheroPanel:Function;
      
      protected var FOpenThisPanelFunction:Function;
      
      protected var FCurRainType:int;
      
      protected var TempTime:uint;
      
      protected var FTEMPtype:int;
      
      protected var FTEMPcount:int;
      
      public function TProcessorWindowTheWorldTree(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FLogicDate = SLogicsCore.TheWorldTreeLogicData;
         this.FTheWorldTree = new TheWorldTree(this.FLogicDate,this);
         this.FTheWorldTree.OnCloseFun = this.CloseThisPanel;
         this.FTheWorldTree.UpdateFiveSlot = this.UpdateFiveSlot;
         this.FTheWorldTree.QianBackFunction = this.QianBackFunction;
         this.FTheWorldTree.PiaoZi = this.PiaoZi;
         this.FTheWorldTree.BuyExpBtn = this.BuyExpBtn;
         this.FTheWorldTree.HouBackFunction = this.HouBackFunction;
         this.FTheWorldTree.TongBuTimeFun = this.TongBuTimeFun;
         this.FTheWorldTree.BackOverFun = this.BackOverFun;
         this.FTheWorldTree.BackOutFun = this.BackOutFun;
         this.FTheWorldTree.BackMoveFun = this.BackMoveFun;
         this.FTheWorldTree.GoToMaoXianPanelFun = this.GoToMaoXianPanelFun;
         this.FPressorWindowBuyExpPopBuyFream = new TPressorWindowBuyExpPopBuyFream(param1);
         this.FPressorWindowBuyExpPopBuyFream.BuyFunctionBack = this.BuyFunctionBack;
         this.FPressorWindowCanWuOverPopBuyFream = new TPressorWindowCanWuOverPopBuyFream(param1);
         this.FPressorWindowCanWuOverPopBuyFream.CanOverBackFunction = this.CanOverBackFunction;
         this.FPressorWindowCanWuJieSuanPopBuyFream = new TPressorWindowCanWuJieSuanPopBuyFream(param1);
         this.FPressorWindowCanWuJieSuanPopBuyFream.SureBtnBackFun = this.SureBtnBackFun;
         this.FPressorWindowDrowUotReward = new TPressorWindowDrowUotReward(param1);
         this.FPressorWindowDrowUotReward.SlotBackOutFunc = this.SlotsOnOut;
         this.FPressorWindowDrowUotReward.SlotBackOverFunc = this.SlotsOnOver;
         this.FPressorWindowDrowUotReward.RewardBackFun = this.RewardBackFun;
         this.FProcessorWindowTheWorldTree_RiskPanel = new TProcessorWindowTheWorldTree_RiskPanel(this.FLogicDate);
         this.FProcessorWindowTheWorldTree_RiskPanel.OnCloseFun = this.CloseThisPanel;
         this.FProcessorWindowTheWorldTree_RiskPanel.BackFunction = this.BackFunction;
         this.FProcessorWindowTheWorldTree_RiskPanel.PiaoZi = this.PiaoZi;
         this.FProcessorWindowDuoTasking_ChangeType = new TProcessorWindowDuoTasking_ChangeType(param1);
         this.FProcessorWindowDuoTasking_ChangeType.BackFun = this.PACKETID_C2S_RISK_TOY_Select_Game_Model;
         this.FProcessorWindowDuoTasking_ChangeType.BackOverFun = this.UIHelpTipsHintOnOver;
         this.FProcessorWindowDuoTasking_ChangeType.BackOutFun = this.UIHelpTipsHintOnOut;
         this.FProcessorWindowDuoTasking_Congratulations = new TProcessorWindowDuoTasking_Congratulations(param1);
         this.FProcessorWindowDuoTasking_Congratulations.BackFunction = this.PACKETID_C2S_RISK_TOY_GET_USER_INFO;
         this.FFiveSlot = new Vector.<TUISlot>(FIVE);
         this.FOverlayerAppliance = new TOverlayerAppliance(this.Parent,CONST_MODULES.MODULE_TheWorldTree);
         this.FOverlayerAppliance.Visible = false;
         this.FUIWindowConfirmationSell = new TUIWindowConfirmation(param1);
         this.FUIWindowConfirmationSell.OnOK = this.WindowConfirmationSellOnOK;
         this.FUIWindowConfirmationSell.OnCheckBoxSelected = this.OnCheckBoxSelected;
         this.FUIWindowConfirmationSell.x = (FUICore.StageWidth - this.FUIWindowConfirmationSell.WindowWidth) / 2;
         this.FUIWindowConfirmationSell.y = (FUICore.StageHeight - this.FUIWindowConfirmationSell.WindowHeight) / 2;
         SetUIModuleID(CONST_MODULES.MODULE_TheWorldTree);
      }
      
      protected function TongBuTimeFun(param1:uint, param2:uint, param3:uint = 0) : void
      {
         if(!this.FPressorWindowBuyExpPopBuyFream.Visible && param3 == 0)
         {
            return;
         }
         this.FPressorWindowBuyExpPopBuyFream.OneTimeEvent(param1,param2,param3);
      }
      
      protected function BuyExpBtn(param1:int) : void
      {
         this.FPressorWindowBuyExpPopBuyFream.Type = param1;
         this.FPressorWindowBuyExpPopBuyFream.OpenThiePanel();
         this.FPressorWindowBuyExpPopBuyFream.visible = true;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_ThreeWorldTree.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUISlot = null;
         this.GetDataByConfig();
         this.FTheWorldTreeMainPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_ThreeWorldTree.TheWorldTreePanelName) as Sprite;
         addChild(this.FTheWorldTreeMainPanel);
         this.FTheWorldTree.ThisPanel = this.FTheWorldTreeMainPanel;
         this.FDuoTaskingMainPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_ThreeWorldTree.DuoTaskingPanelName) as Sprite;
         addChild(this.FDuoTaskingMainPanel);
         this.FProcessorWindowTheWorldTree_RiskPanel.ThisPanel = this.FDuoTaskingMainPanel;
         _loc1_ = 0;
         while(_loc1_ < FIVE)
         {
            _loc2_ = this.GetUISlot();
            _loc2_.Resource = this.FTheWorldTreeMainPanel["MC_CanWuQian"]["MC_SlotArea"]["MC_SlotArea"]["MC_Slot_" + _loc1_];
            _loc2_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc2_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc2_.OnOverlay = this.SlotsOnOver;
            _loc2_.OnOut = this.SlotsOnOut;
            _loc2_.Init();
            this.FFiveSlot[_loc1_] = _loc2_;
            _loc1_++;
         }
         new Tools_Help(this,this.FTheWorldTree.MC_Close["BTN_Help"],CONST_SYSTEMLANGUAGE.HELPTIPS_TheWordTree,FUICore);
         new Tools_Help(this,this.FProcessorWindowTheWorldTree_RiskPanel.MC_Close["BTN_Help"],CONST_SYSTEMLANGUAGE.HELPTIPS_WanOu,FUICore);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         this.FTExpDecTip = new TExpDecTip(this.Parent);
         this.FTExpDecTip.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTExpDecTip);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationSell);
         this.FUIWindowConfirmationSell.SetCheckBox(true);
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this.Parent);
         this.FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         this.FIsInitilization = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FTheWorldTree.AddEvent();
         this.FProcessorWindowTheWorldTree_RiskPanel.AddEvent();
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(!this.FIsInitilization)
         {
            return;
         }
         this.FTheWorldTree.LogicsPerform();
         this.FProcessorWindowTheWorldTree_RiskPanel.LogicsPerform();
         _loc1_ = 0;
         while(_loc1_ < FIVE)
         {
            this.FFiveSlot[_loc1_].Update();
            _loc1_++;
         }
         super.LogicsPerform();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FPressorWindowBuyExpPopBuyFream.Load();
            this.FPressorWindowCanWuOverPopBuyFream.Load();
            this.FPressorWindowCanWuJieSuanPopBuyFream.Load();
            this.FPressorWindowDrowUotReward.Load();
            this.FProcessorWindowDuoTasking_ChangeType.Load();
            this.FProcessorWindowDuoTasking_Congratulations.Load();
            return;
         }
         if(this.FSetChatPositionByType != null)
         {
            this.FSetChatPositionByType(0);
         }
         setTimeout(this.CloseChat,50);
         this.OpenPanelByType(0);
      }
      
      protected function BackFunction(param1:int) : void
      {
         switch(param1)
         {
            case 100:
               this.PACKETID_C2S_RISK_TOY_Accept_Game_Star();
               break;
            case 200:
               this.OpenPanelByType(0);
               break;
            case 300:
               this.PACKETID_C2S_RISK_TOY_Accept_Game_Resul();
               break;
            default:
               this.PACKETID_C2S_RISK_TOY_Select_Game_Toy(param1);
         }
      }
      
      public function OpenPanelByType(param1:int) : void
      {
         this.FTheWorldTree.ThisPanel.visible = false;
         this.FProcessorWindowTheWorldTree_RiskPanel.ThisPanel.visible = false;
         this.FProcessorWindowDuoTasking_ChangeType.visible = false;
         switch(param1)
         {
            case 0:
               this.FTheWorldTree.ThisPanel.visible = true;
               if(this.FLogicDate.CurPenetrateState == 1)
               {
                  this.PACKETID_C2S_World_Tree_Get_All_Drop_Item();
               }
               else if(this.FLogicDate.CurPenetrateState == 2)
               {
                  this.FTheWorldTree.UpdateView();
                  this.FPressorWindowCanWuOverPopBuyFream.UpdateView();
                  this.FPressorWindowCanWuOverPopBuyFream.visible = true;
               }
               else
               {
                  this.PACKETID_C2S_World_Tree_Get_Info();
               }
               this.FTheWorldTree.OpenThisPanel();
               break;
            case 1:
               this.FProcessorWindowTheWorldTree_RiskPanel.Rest();
               this.FProcessorWindowTheWorldTree_RiskPanel.UpdateView();
               this.FProcessorWindowTheWorldTree_RiskPanel.ThisPanel.visible = true;
               break;
            case 2:
               this.FTheWorldTree.ThisPanel.visible = true;
               this.FProcessorWindowDuoTasking_ChangeType.UpdateFreeCount();
               this.FProcessorWindowDuoTasking_ChangeType.visible = true;
         }
      }
      
      protected function CloseChat() : void
      {
         if(this.FOnSetChatOptions != null)
         {
            this.FOnSetChatOptions(this,false);
         }
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
      }
      
      protected function RewardBackFun(param1:TGodtreeDrop) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         this.FCurGetRewadId = param1.GodtreeLevel;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_World_Tree_Get_Gift);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1.GodtreeLevel);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function HouBackFunction() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_World_Tree_Stop_World_Tree);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function QianBackFunction(param1:int) : void
      {
         switch(param1)
         {
            case 0:
               this.PACKETID_C2S_World_Tree_Start_World_Tree();
               break;
            case 1:
               this.PACKETID_C2S_World_Tree_Wartering(1);
               this.FCurRainType = 1;
               break;
            case 2:
               this.PACKETID_C2S_World_Tree_Wartering(2);
               this.FCurRainType = 2;
               break;
            case 3:
               this.FPressorWindowDrowUotReward.OpenThisPanel();
               this.FPressorWindowDrowUotReward.visible = true;
               break;
            case 4:
               this.FPressorWindowCanWuOverPopBuyFream.UpdateView();
               this.FPressorWindowCanWuOverPopBuyFream.visible = true;
         }
      }
      
      protected function PACKETID_C2S_World_Tree_Start_World_Tree() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_World_Tree_Start_World_Tree);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function WindowConfirmationSellOnOK(param1:Object) : void
      {
         switch(this.FNiMeiType)
         {
            case 1:
            case 2:
               this.FTemp_C2S_Tree_Wartering(this.FNiMeiType);
               break;
            case 3:
            case 4:
               this.BuyFunctionBackC_S();
         }
      }
      
      protected function OnCheckBoxSelected(param1:Object, param2:Boolean) : void
      {
         switch(this.FNiMeiType)
         {
            case 1:
               this.FNiMeiType1 = param2 ? 1 : 0;
               break;
            case 2:
               this.FNiMeiType2 = param2 ? 1 : 0;
               break;
            case 3:
               this.FNiMeiType3 = param2 ? 1 : 0;
               break;
            case 4:
               this.FNiMeiType4 = param2 ? 1 : 0;
         }
      }
      
      protected function FTemp_C2S_Tree_Wartering(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_World_Tree_Wartering);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FNiMeiType);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PACKETID_C2S_World_Tree_Wartering(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.FNiMeiType = param1;
         if(this.FNiMeiType == 1)
         {
            if(this.FNiMeiType1)
            {
               this.FTemp_C2S_Tree_Wartering(param1);
            }
            else
            {
               _loc2_ = int(this.FLogicDate.TheWorldTreeWateringCount);
               _loc3_ = int(this.FLogicDate.WateringCountCost.length);
               if(_loc2_ >= _loc3_)
               {
                  _loc2_ = int(this.FLogicDate.WateringCountCost[_loc3_ - 1]);
               }
               else
               {
                  _loc2_ = int(this.FLogicDate.WateringCountCost[_loc2_]);
               }
               this.FUIWindowConfirmationSell.SetSelectedOrNot(false);
               this.FUIWindowConfirmationSell.Visible = true;
               this.FUIWindowConfirmationSell.Text = TUtilityString.Format(new ConsumeFrame(70270070).DescribeString,_loc2_,this.FLogicDate.WateringExp);
            }
         }
         else if(this.FNiMeiType2)
         {
            this.FTemp_C2S_Tree_Wartering(param1);
         }
         else
         {
            _loc2_ = int(this.FLogicDate.TheWorldTreeRainCount);
            _loc3_ = int(this.FLogicDate.RainCountCost.length);
            if(_loc2_ >= _loc3_)
            {
               _loc2_ = int(this.FLogicDate.RainCountCost[_loc3_ - 1]);
            }
            else
            {
               _loc2_ = int(this.FLogicDate.RainCountCost[_loc2_]);
            }
            this.FUIWindowConfirmationSell.SetSelectedOrNot(false);
            this.FUIWindowConfirmationSell.Visible = true;
            this.FUIWindowConfirmationSell.Text = TUtilityString.Format(new ConsumeFrame(70270071).DescribeString,_loc2_,this.FLogicDate.RainExp);
         }
      }
      
      protected function SureBtnBackFun() : void
      {
         this.PACKETID_C2S_World_Tree_Get_Info();
         this.FPressorWindowCanWuJieSuanPopBuyFream.visible = false;
      }
      
      protected function PACKETID_C2S_World_Tree_Get_Info() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_World_Tree_Get_Info);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function BuyFunctionBack(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         this.TempTime = param2 * 60 * 60;
         this.FTEMPtype = param1;
         this.FTEMPcount = param2;
         if(param1 == 1)
         {
            this.FNiMeiType = 3;
            if(this.FNiMeiType3)
            {
               this.BuyFunctionBackC_S();
            }
            else
            {
               this.FUIWindowConfirmationSell.SetSelectedOrNot(false);
               this.FUIWindowConfirmationSell.Visible = true;
               this.FUIWindowConfirmationSell.Text = TUtilityString.Format(new ConsumeFrame(70270072).DescribeString,this.FLogicDate.BuyExpOneHourOrice * param2,param2);
            }
         }
         else
         {
            this.FNiMeiType = 4;
            if(this.FNiMeiType4)
            {
               this.BuyFunctionBackC_S();
            }
            else
            {
               this.FUIWindowConfirmationSell.SetSelectedOrNot(false);
               this.FUIWindowConfirmationSell.Visible = true;
               this.FUIWindowConfirmationSell.Text = TUtilityString.Format(new ConsumeFrame(70270073).DescribeString,this.FLogicDate.PropsDropOutOneHourOrice * param2,param2);
            }
         }
      }
      
      protected function BuyFunctionBackC_S() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         if(this.FTEMPtype == 1)
         {
            _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_World_Tree_Buy_Exp_Cost);
         }
         else
         {
            _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_World_Tree_Buy_Item_Cost);
         }
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(this.FTEMPcount);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_C2S_World_Tree_Get_All_Drop_Item() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_World_Tree_Get_All_Drop_Item);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function CanOverBackFunction() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_World_Tree_Get_Calcu_Info);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_World_Tree_Buy_Exp_Cost,this.PACKETID_S2C_World_Tree_Buy_Exp_Cost);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_World_Tree_Buy_Item_Cost,this.PACKETID_S2C_World_Tree_Buy_Item_Cost);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_World_Tree_Start_World_Tree,this.PACKETID_S2C_World_Tree_Start_World_Tree);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_World_Tree_Wartering,this.PACKETID_S2C_World_Tree_Wartering);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_World_Tree_Drop_Item,this.PACKETID_S2C_World_Tree_Drop_Item);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_World_Tree_Get_Info,this.PACKETID_S2C_World_Tree_Get_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_World_Tree_Get_All_Drop_Item,this.PACKETID_S2C_World_Tree_Get_All_Drop_Item);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_World_Tree_Get_Gift,this.PACKETID_S2C_World_Tree_Get_Gift);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_World_Tree_Stop_World_Tree,this.PACKETID_S2C_World_Tree_Stop_World_Tree);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_World_Tree_Get_Calcu_Info,this.PACKETID_S2C_World_Tree_Get_Calcu_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_RISK_TOY_GET_USER_INFO,this.PACKETID_S2C_RISK_TOY_GET_USER_INFO);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_RISK_TOY_Select_Game_Model,this.PACKETID_S2C_RISK_TOY_Select_Game_Model);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_RISK_TOY_Select_Game_Toy,this.PACKETID_S2C_RISK_TOY_Select_Game_Toy);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_RISK_TOY_Accept_Game_Result,this.PACKETID_S2C_RISK_TOY_Accept_Game_Result);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_RISK_TOY_Accept_Game_Start,this.PACKETID_S2C_RISK_TOY_Accept_Game_Start);
      }
      
      protected function PACKETID_S2C_World_Tree_Buy_Exp_Cost(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FLogicDate.OnlineAdditionExpSurplusTimesCopy += this.TempTime;
         EffectGenerateText(new ConsumeFrameCopy(STRING_THEWORLDTREE.str40).DescribeString);
         this.FTheWorldTree.OpenThisPanel();
      }
      
      protected function PACKETID_S2C_World_Tree_Buy_Item_Cost(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FLogicDate.PropsAdditionExpSurplusTimes += this.TempTime;
         EffectGenerateText(new ConsumeFrameCopy(STRING_THEWORLDTREE.str40).DescribeString);
         this.FTheWorldTree.OpenThisPanel();
      }
      
      protected function PACKETID_S2C_World_Tree_Start_World_Tree(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.PACKETID_C2S_World_Tree_Get_All_Drop_Item();
         this.FLogicDate.PenetrateBeginTimes = _loc3_.readUnsignedInt();
         this.FLogicDate.CurPenetrateState = 1;
         this.FTheWorldTree.OpenThisPanel();
         this.FTheWorldTree.UpdateView();
      }
      
      protected function PACKETID_S2C_World_Tree_Wartering(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         var _loc5_:String = "";
         if(this.FNiMeiType == 1)
         {
            _loc4_ = this.FLogicDate.WateringExp;
         }
         else
         {
            _loc4_ = this.FLogicDate.RainExp;
         }
         _loc5_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str41).DescribeString,_loc4_);
         this.FTheWorldTree.NowPlayeEffect();
         EffectGenerateText(_loc5_);
         this.PACKETID_C2S_World_Tree_Get_Info();
      }
      
      protected function PACKETID_S2C_World_Tree_Drop_Item(param1:TPacket) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:ByteArray = param1.Data;
         _loc3_ = _loc2_.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            this.FLogicDate.TheWorldTreeDropOutGoods.push(_loc2_.readUnsignedInt());
            this.FLogicDate.TheWorldTreeDropOutGoods.push(_loc2_.readShort());
            this.FLogicDate.TheWorldTreeDropOutGoods.push(_loc2_.readUnsignedInt());
            this.FLogicDate.TheWorldTreeDropOutGoods.push(_loc2_.readUnsignedInt());
            _loc4_++;
         }
         this.FTheWorldTree.UpdateView();
      }
      
      protected function PACKETID_S2C_World_Tree_Get_Info(param1:TPacket) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:ByteArray = param1.Data;
         this.FLogicDate.CurOnlineTimeAllTime = _loc2_.readUnsignedInt();
         this.FLogicDate.CurOfflineTimeAllTime = _loc2_.readUnsignedInt();
         _loc3_ = _loc2_.readUnsignedInt();
         this.FLogicDate.SeverCurTime = _loc3_;
         this.FLogicDate.OnlineAdditionExpSurplusTimes = _loc2_.readUnsignedInt();
         this.FLogicDate.PenetrateBeginTimes = _loc2_.readUnsignedInt();
         if(_loc3_ > this.FLogicDate.OnlineAdditionExpSurplusTimes)
         {
            this.FLogicDate.OnlineAdditionExpSurplusTimesCopy = 0;
         }
         else
         {
            this.FLogicDate.OnlineAdditionExpSurplusTimesCopy = this.FLogicDate.OnlineAdditionExpSurplusTimes - _loc3_;
         }
         _loc3_ = _loc2_.readUnsignedInt();
         this.FLogicDate.CanWuAllTime = _loc3_ - this.FLogicDate.PenetrateBeginTimes;
         this.FLogicDate.PropsAdditionExpSurplusTimes = _loc2_.readUnsignedInt();
         this.FLogicDate.TheWorldTreeCurExp = _loc2_.readUnsignedInt();
         this.FLogicDate.TheWorldTreeCurLevel = _loc2_.readUnsignedInt();
         this.FLogicDate.TheWorldTreeWateringCount = _loc2_.readUnsignedInt();
         this.FLogicDate.TheWorldTreeRainCount = _loc2_.readUnsignedInt();
         this.FLogicDate.CurPenetrateState = _loc2_.readUnsignedInt();
         this.FLogicDate.CurGetGiftedId.length = 0;
         _loc4_ = _loc2_.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            this.FLogicDate.CurGetGiftedId.push(_loc2_.readUnsignedInt());
            _loc5_++;
         }
         if(this.FLogicDate.CurPenetrateState == 1 || this.FLogicDate.CurPenetrateState == 2)
         {
            if(this.FOpenThisPanelFunction != null)
            {
               this.FOpenThisPanelFunction();
            }
            return;
         }
         if(!this.FIsInitilization)
         {
            return;
         }
         this.FTheWorldTree.UpdateView();
      }
      
      protected function PACKETID_S2C_World_Tree_Get_All_Drop_Item(param1:TPacket) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:ByteArray = param1.Data;
         this.FLogicDate.TheWorldTreeDropOutGoods.length = 0;
         _loc3_ = _loc2_.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            this.FLogicDate.TheWorldTreeDropOutGoods.push(_loc2_.readUnsignedInt());
            this.FLogicDate.TheWorldTreeDropOutGoods.push(_loc2_.readShort());
            this.FLogicDate.TheWorldTreeDropOutGoods.push(_loc2_.readUnsignedInt());
            this.FLogicDate.TheWorldTreeDropOutGoods.push(_loc2_.readUnsignedInt());
            _loc4_++;
         }
         this.FTheWorldTree.UpdateView();
      }
      
      protected function PACKETID_S2C_World_Tree_Get_Gift(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FLogicDate.CurGetGiftedId.push(this.FCurGetRewadId);
         this.FPressorWindowDrowUotReward.OpenThisPanel();
         this.FTheWorldTree.UpdateView();
      }
      
      protected function PACKETID_S2C_World_Tree_Stop_World_Tree(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FLogicDate.CanWuAllTime = _loc3_.readUnsignedInt();
         this.FLogicDate.CurPenetrateState = 2;
         if(FIsResourcesLoadCompleted)
         {
            this.FTheWorldTree.OpenThisPanel();
            this.FTheWorldTree.UpdateView();
            this.FPressorWindowCanWuOverPopBuyFream.UpdateView();
            this.FPressorWindowCanWuOverPopBuyFream.visible = true;
            return;
         }
      }
      
      protected function PACKETID_S2C_World_Tree_Get_Calcu_Info(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FLogicDate.ClearingObject["onlineTms"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["onlineExp1"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["onlineExp2"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["dropTms"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["vipTms"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["vipExp1"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["vipExp2"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["costTms"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["costExp1"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["costExp2"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["dkTms"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["dkExp1"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["dkExp2"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["allExp1"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["allExp2"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["treePower"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["allTms"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["baseExp1"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["baseExp2"] = _loc3_.readUnsignedInt();
         this.FLogicDate.ClearingObject["level"] = _loc3_.readUnsignedInt();
         this.FLogicDate.CurPenetrateState = 0;
         this.FPressorWindowCanWuOverPopBuyFream.visible = false;
         this.FPressorWindowCanWuJieSuanPopBuyFream.OpenThisPanel();
         this.FPressorWindowCanWuJieSuanPopBuyFream.Visible = true;
      }
      
      protected function PACKETID_C2S_RISK_TOY_Accept_Game_Star() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_RISK_TOY_Accept_Game_Star);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function GoToMaoXianPanelFun() : void
      {
         this.PACKETID_C2S_RISK_TOY_GET_USER_INFO();
      }
      
      protected function PACKETID_C2S_RISK_TOY_GET_USER_INFO() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_RISK_TOY_GET_USER_INFO);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_C2S_RISK_TOY_Select_Game_Model(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_RISK_TOY_Select_Game_Model);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PACKETID_C2S_RISK_TOY_Select_Game_Toy(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_RISK_TOY_Select_Game_Toy);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PACKETID_C2S_RISK_TOY_Accept_Game_Resul() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_RISK_TOY_Accept_Game_Resul);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_S2C_RISK_TOY_GET_USER_INFO(param1:TPacket) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:ByteArray = param1.Data;
         this.FLogicDate.WanOuYouXiQuanCount = _loc2_.readUnsignedInt();
         this.FLogicDate.ModeCountOne = _loc2_.readUnsignedInt();
         this.FLogicDate.ModeCountTwo = _loc2_.readUnsignedInt();
         this.FLogicDate.ModeCountThree = _loc2_.readUnsignedInt();
         this.FLogicDate.CurProgressState = _loc2_.readUnsignedInt();
         this.FLogicDate.CurChangeModeState = _loc2_.readUnsignedInt();
         this.FLogicDate.SystemBid = _loc2_.readUnsignedInt();
         this.FProcessorWindowTheWorldTree_RiskPanel.ForValueToCurvec();
         this.FLogicDate.ShieldingVec.length = 0;
         _loc4_ = _loc2_.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this.FLogicDate.ShieldingVec.push(_loc2_.readUnsignedInt());
            this.FLogicDate.ShieldingVec.push(_loc2_.readUnsignedInt());
            _loc3_++;
         }
         this.FLogicDate.MaoXianJiLuVec.length = 0;
         _loc4_ = _loc2_.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this.FLogicDate.MaoXianJiLuVec.push(_loc2_.readUnsignedInt());
            this.FLogicDate.MaoXianJiLuVec.push(_loc2_.readUnsignedInt());
            _loc3_++;
         }
         switch(this.FLogicDate.CurProgressState)
         {
            case 0:
               this.OpenPanelByType(2);
               break;
            case 1:
            case 2:
            case 3:
               this.OpenPanelByType(1);
         }
      }
      
      protected function PACKETID_S2C_RISK_TOY_Select_Game_Model(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.PACKETID_C2S_RISK_TOY_GET_USER_INFO();
      }
      
      protected function PACKETID_S2C_RISK_TOY_Select_Game_Toy(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            this.FProcessorWindowTheWorldTree_RiskPanel.FIsCanClick = false;
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc2_ = int(_loc3_.readUnsignedInt());
         _loc4_ = int(_loc3_.readUnsignedInt());
         this.FLogicDate.SystemBid = _loc4_;
         this.FLogicDate.CurProgressState = 3;
         this.FProcessorWindowTheWorldTree_RiskPanel.FIsCanClick = false;
         this.FProcessorWindowTheWorldTree_RiskPanel.UpdateViewBySilverCoin(_loc2_);
      }
      
      protected function PACKETID_S2C_RISK_TOY_Accept_Game_Result(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FLogicDate.ShieldingVec[1] = _loc3_.readUnsignedInt();
         this.FProcessorWindowTheWorldTree_RiskPanel.GameOver();
         this.FProcessorWindowDuoTasking_Congratulations.UpdateView();
         this.FProcessorWindowDuoTasking_Congratulations.visible = true;
      }
      
      protected function PACKETID_S2C_RISK_TOY_Accept_Game_Start(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FLogicDate.CurProgressState = 2;
         this.FProcessorWindowTheWorldTree_RiskPanel.UpdateDescription();
      }
      
      protected function BackOverFun(param1:int) : void
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case 0:
               _loc2_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str20).DescribeString,this.FLogicDate.OnlineBuffPercent / 100);
               break;
            case 1:
               if(this.FLogicDate.KaguyaPowerPercentCopy == 0)
               {
                  _loc2_ = new ConsumeFrameCopy(STRING_THEWORLDTREE.str21).DescribeString;
               }
               else
               {
                  _loc2_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str22).DescribeString,SLogicsCore.KaguyaData.CurLevel,this.FLogicDate.KaguyaPowerPercentCopy / 100,this.FLogicDate.KaguyaPowerPercentCopy2 / 100);
               }
               break;
            case 2:
               if(this.FLogicDate.VipLevelPercentCopy == 0)
               {
                  _loc2_ = new ConsumeFrameCopy(STRING_THEWORLDTREE.str23).DescribeString;
               }
               else if(SLogicsCore.Character.VipLevel == 10)
               {
                  _loc2_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str43).DescribeString,SLogicsCore.Character.VipLevel,this.FLogicDate.VipLevelPercentCopy / 100);
               }
               else
               {
                  _loc2_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str24).DescribeString,SLogicsCore.Character.VipLevel,this.FLogicDate.VipLevelPercentCopy / 100,this.FLogicDate.VipLevelPercentCopy2 / 100);
               }
               break;
            case 3:
               _loc2_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str25).DescribeString,this.FLogicDate.GoldBuyPercent / 100);
               break;
            case 4:
               _loc2_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str26).DescribeString,this.FLogicDate.PropsDropOutPercent / 100);
               break;
            case 5:
               _loc2_ = new ConsumeFrameCopy(70300003).DescribeString;
         }
         this.FTExpDecTip.Context = _loc2_;
         this.FTExpDecTip.Render(FUICore.MouseCoordinate);
         this.FTExpDecTip.Show();
      }
      
      protected function BackOutFun() : void
      {
         this.FTExpDecTip.Hide();
      }
      
      protected function BackMoveFun() : void
      {
         if(this.FTExpDecTip.visible)
         {
            this.FTExpDecTip.Render(FUICore.MouseCoordinate);
         }
      }
      
      override protected function ProcessorResize() : void
      {
         super.ProcessorResize();
      }
      
      protected function UpdateFiveSlot(param1:TInventories, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < FIVE)
         {
            _loc4_ = param2 * FIVE + _loc3_;
            if(_loc4_ >= param1.Count)
            {
               this.FFiveSlot[_loc4_].Context = null;
            }
            else
            {
               this.FFiveSlot[_loc4_].Context = param1.GetInventoryByIndex(_loc4_);
            }
            _loc3_++;
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture);
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         _loc4_ = this.FOverlayerAppliance;
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         _loc4_ = this.FOverlayerAppliance;
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
      }
      
      public function set UpdateOtheroPanel(param1:Function) : void
      {
         this.FUpdateOtheroPanel = param1;
      }
      
      protected function CloseThisPanel() : void
      {
         if(this.FLogicDate.CurPenetrateState == 1)
         {
            EffectGenerateText(new ConsumeFrameCopy(STRING_THEWORLDTREE.str8).DescribeString);
            return;
         }
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
      
      protected function PiaoZi(param1:String) : void
      {
         EffectGenerateText(param1);
      }
      
      public function set OpenThisPanelFunction(param1:Function) : void
      {
         this.FOpenThisPanelFunction = param1;
      }
      
      protected function GetUISlot() : TUISlot
      {
         return new TUISlot(this);
      }
      
      protected function GetDataByConfig() : void
      {
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800006) as TConfigValue;
         this.FLogicDate.OnlineBuffPercent = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800007) as TConfigValue;
         this.FLogicDate.KaguyaPowerPercent = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800008) as TConfigValue;
         this.FLogicDate.VipLevelPercent = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800009) as TConfigValue;
         this.FLogicDate.GoldBuyPercent = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800010) as TConfigValue;
         this.FLogicDate.PropsDropOutPercent = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800011) as TConfigValue;
         this.FLogicDate.BuyExpOneHourOrice = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800012) as TConfigValue;
         this.FLogicDate.PropsDropOutOneHourOrice = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800002) as TConfigValue;
         this.FLogicDate.WateringCountCost = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800003) as TConfigValue;
         this.FLogicDate.RainCountCost = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800015) as TConfigValue;
         this.FLogicDate.WateringExp = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800014) as TConfigValue;
         this.FLogicDate.JieSuanTimeCell = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800016) as TConfigValue;
         this.FLogicDate.RainExp = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800017) as TConfigValue;
         this.FLogicDate.OneTimesCanWuAllTime = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800018) as TConfigValue;
         this.FLogicDate.ChuJiRewardVec = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800019) as TConfigValue;
         this.FLogicDate.GaoJiRewardVec = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800020) as TConfigValue;
         this.FLogicDate.DingJiRewardVec = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800013) as TConfigValue;
         this.FLogicDate.OneTimesbabyCount = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800004) as TConfigValue;
         this.FLogicDate.EverydayRiskCount = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800005) as TConfigValue;
         this.FLogicDate.RiskThreeDifficultyCost = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,90800034) as TConfigValue;
         this.FLogicDate.MaoXianYouXiQuanName = _loc1_.Value as String;
      }
      
      protected function UIHelpTipsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHelpTips.Context = param2;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function UIHelpTipsHintOnOut() : void
      {
         this.FOverlayerHelpTips.Hide();
      }
   }
}

