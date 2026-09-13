package Processors.Game.Lobby.LostShenqi
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TMazeconfig;
   import Logics.Inventories.TInventory;
   import Logics.LostShenQi.TLostShenQiLogicData;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.LostShenqi.LittleShiJianPanel.TProcessorCaiQuanGame;
   import Processors.Game.Lobby.LostShenqi.LittleShiJianPanel.TProcessorHuoYingWenDa;
   import Processors.Game.Lobby.LostShenqi.LittleShiJianPanel.TProcessorShaiZiGame;
   import Processors.Game.Lobby.LostShenqi.LittleShiJianPanel.TProcessorTiaoZhanBoss;
   import Processors.Game.Lobby.LostShenqi.LittleShiJianPanel.TProcessorTiaoZhanShengLi;
   import Processors.Game.Lobby.LostShenqi.LittleShiJianPanel.TProcessorTiaoZhanShiBai;
   import Processors.Game.Lobby.LostShenqi.OtherPanel.TProcessoriShenQiMiGongDiTu;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_MUSIC;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_JADE;
   import Resources.Strings.STRING_LOSTSHENQI;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.utils.ByteArray;
   
   public class TProcessorLostShenQiMain extends TProcessorLobbyWindows
   {
      
      protected var FProcessorLostShenQi:TProcessorLostShenQi;
      
      protected var FProcessoriShenQiMiGongDiTu:TProcessoriShenQiMiGongDiTu;
      
      protected var FProcessorShaiZiGame:TProcessorShaiZiGame;
      
      protected var FProcessorCaiQuanGame:TProcessorCaiQuanGame;
      
      protected var FProcessorTiaoZhanBoss:TProcessorTiaoZhanBoss;
      
      protected var FProcessorTiaoZhanShiBai:TProcessorTiaoZhanShiBai;
      
      protected var FProcessorTiaoZhanShengLi:TProcessorTiaoZhanShengLi;
      
      protected var FProcessorHuoYingWenDa:TProcessorHuoYingWenDa;
      
      protected var FUIWindowConfirmationCopy:TUIWindowConfirmation;
      
      public var FCurTabIndex:int;
      
      protected var FCurClickX:uint;
      
      protected var FCurClickY:uint;
      
      protected var FCurBuyType:uint;
      
      protected var FCurBuyTypeCopy:uint;
      
      protected var FKengDie:Boolean;
      
      protected var FLostShenQiLogicData:TLostShenQiLogicData;
      
      protected var FMC_Goto_FaQiFunction:Function;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FType0:Boolean;
      
      protected var FType1:Boolean;
      
      protected var FType2:Boolean;
      
      protected var FType3:Boolean;
      
      protected var FType4:Boolean;
      
      protected var FType5:Boolean;
      
      public function TProcessorLostShenQiMain(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorLostShenQi = new TProcessorLostShenQi(this,param2);
         this.FProcessorLostShenQi.MC_Goto_FaQiFunction = this.MC_Goto_FaQiFunctionClick;
         this.FProcessorLostShenQi.MakeBtnFunction = this.MakeBtnFunction;
         this.FProcessorLostShenQi.ShengJiBackFunction = this.ShengJiBackFunction;
         this.FProcessorLostShenQi.OnClose = this.CloseThisPane;
         this.FProcessorLostShenQi.EnterInMiGongFunction = this.EnterInMiGongFunction;
         this.FProcessorLostShenQi.BuyFunction = this.BuyFunction;
         this.FProcessorLostShenQi.PiaoZi = this.PiaoZi;
         this.FProcessoriShenQiMiGongDiTu = new TProcessoriShenQiMiGongDiTu(this);
         this.FProcessoriShenQiMiGongDiTu.OnClose = this.CloseThisPaneNiMei;
         this.FProcessoriShenQiMiGongDiTu.BuyBackFunction = this.BuyBackFunction;
         this.FProcessoriShenQiMiGongDiTu.BackFucntion = this.PACKETID_C2S_MAZE_Move_Position;
         this.FProcessorShaiZiGame = new TProcessorShaiZiGame(this);
         this.FProcessorShaiZiGame.BackFunction = this.BackFunction;
         this.FProcessorShaiZiGame.PiaoZi = this.PiaoZi;
         this.FProcessorCaiQuanGame = new TProcessorCaiQuanGame(this);
         this.FProcessorCaiQuanGame.BackFunction = this.BackFunction;
         this.FProcessorCaiQuanGame.PiaoZi = this.PiaoZi;
         this.FProcessorTiaoZhanBoss = new TProcessorTiaoZhanBoss(this);
         this.FProcessorTiaoZhanBoss.BackFunction = this.BackFunctionCopy;
         this.FProcessorTiaoZhanShiBai = new TProcessorTiaoZhanShiBai(this);
         this.FProcessorTiaoZhanShiBai.BackFunction = this.BackFunction;
         this.FProcessorTiaoZhanShengLi = new TProcessorTiaoZhanShengLi(this);
         this.FProcessorTiaoZhanShengLi.BackFunction = this.BackFunction;
         this.FProcessorHuoYingWenDa = new TProcessorHuoYingWenDa(this);
         this.FProcessorHuoYingWenDa.BackFunction = this.BackFunctionNiMei;
         this.FLostShenQiLogicData = SLogicsCore.LostShenQiLogicData;
         SetUIModuleID(CONST_MODULES.MODULE_LostShenQi);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(1526726656);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FUIWindowConfirmationCopy = new TUIWindowConfirmation(Parent);
         this.FUIWindowConfirmationCopy.OnOK = this.OnConfirmationOkCopy;
         this.FUIWindowConfirmationCopy.OnCheckBoxSelected = this.OnCheckBoxSelected;
         this.FUIWindowConfirmationCopy.OnCancel = this.OnCancel;
         this.FUIWindowConfirmationCopy.x = (FUICore.StageWidth - this.FUIWindowConfirmationCopy.WindowWidth) / 2;
         this.FUIWindowConfirmationCopy.y = (FUICore.StageHeight - this.FUIWindowConfirmationCopy.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationCopy);
         this.FUIWindowConfirmationCopy.SetCheckBox(true);
         super.ResourcesPerform_UIDispatch();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorLostShenQi.Load();
            this.FProcessoriShenQiMiGongDiTu.Load();
            this.FProcessorShaiZiGame.Load();
            this.FProcessorCaiQuanGame.Load();
            this.FProcessorTiaoZhanBoss.Load();
            this.FProcessorTiaoZhanShiBai.Load();
            this.FProcessorTiaoZhanShengLi.Load();
            this.FProcessorHuoYingWenDa.Load();
            return;
         }
         this.PACKETID_C2S_MAZE_Get_Info();
         if(this.FCurTabIndex == 1)
         {
            this.woqu();
         }
         this.PanelVisiByIndex();
      }
      
      protected function EnterInMiGongFunction() : void
      {
         if(this.FLostShenQiLogicData.CurGameState == 0)
         {
            this.PACKETID_C2S_MAZE_Start_Game();
         }
         else
         {
            this.FCurTabIndex = 1;
            this.woqu();
            this.PanelVisiByIndex();
            if(this.FLostShenQiLogicData.CurShiJianId != 0)
            {
               this.ShowPanelByEventId(this.FLostShenQiLogicData.CurShiJianId);
            }
         }
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
      
      protected function PanelVisiByIndex() : void
      {
         this.FProcessorLostShenQi.Visible = false;
         this.FProcessoriShenQiMiGongDiTu.Visible = false;
         switch(this.FCurTabIndex)
         {
            case 0:
               this.FProcessorLostShenQi.Visible = true;
               this.FProcessorLostShenQi.OpenThisPanel();
               break;
            case 1:
               this.FProcessoriShenQiMiGongDiTu.Visible = true;
               this.FProcessoriShenQiMiGongDiTu.OpenThisPanel();
               break;
            case 2:
         }
      }
      
      protected function CloseThisPaneNiMei() : void
      {
         if(FOnClose != null)
         {
            this.FCurTabIndex = 0;
            this.PanelVisiByIndex();
         }
      }
      
      protected function CloseThisPane() : void
      {
         if(FOnClose != null)
         {
            this.FCurTabIndex = 0;
            FOnClose(this);
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_MAZE_Get_Info,this.PACKETID_S2C_MAZE_Get_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_MAZE_Get_Event_Info,this.PACKETID_S2C_MAZE_Get_Event_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_MAZE_Move_Position,this.PACKETID_S2C_MAZE_Move_Position);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_MAZE_Deal_Event,this.PACKETID_S2C_MAZE_Deal_Event);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_MAZE_Answer_Question,this.PACKETID_S2C_MAZE_Answer_Question);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_MAZE_Moved_Position,this.PACKETID_S2C_MAZE_Moved_Position);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_MAZE_Over_Game,this.PACKETID_S2C_MAZE_Over_Game);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_MAZE_Start_Game,this.PACKETID_S2C_MAZE_Start_Game);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_MAZE_Forge_Sacre,this.PACKETID_S2C_MAZE_Forge_Sacre);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_MAZE_Sacre_Level_Up,this.PACKETID_S2C_MAZE_Sacre_Level_Up);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_MAZE_Buy_Skip,this.PACKETID_S2C_MAZE_Buy_Skip);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_MAZE_Buy_Reset,this.PACKETID_S2C_MAZE_Buy_Reset);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_MAZE_Get_Award,this.PACKETID_S2C_MAZE_Get_Award);
      }
      
      protected function PACKETID_S2C_MAZE_Get_Award(param1:TPacket) : void
      {
         var _loc2_:TArticle = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:String = null;
         var _loc9_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc3_ = uint(param1.Data.readShort());
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = uint(param1.Data.readShort());
            _loc6_ = param1.Data.readUnsignedInt();
            _loc8_ = param1.Data.readUnsignedInt();
            _loc7_ = CONST_COMMON.GetItemIDByType(_loc5_,_loc6_,_loc9_);
            _loc2_ = _loc9_.GetDatebaseByIdentifier(_loc7_) as TArticle;
            _loc10_ = TUtilityString.Format(STRING_JADE.STRING_Tip,_loc2_.Name,_loc8_);
            this.PiaoZi(_loc10_);
            _loc4_++;
         }
      }
      
      protected function PiaoZi(param1:String) : void
      {
         EffectGenerateText(param1);
      }
      
      protected function OnConfirmationOkCopy(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         switch(this.FCurBuyTypeCopy)
         {
            case 3:
               _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_MAZE_Buy_Reset);
               SNetworkCore.Transceiver.PacketTransmit(_loc2_);
               break;
            case 0:
            case 1:
               if(this.FKengDie)
               {
                  _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_MAZE_Buy_Skip);
                  _loc3_ = _loc2_.Data;
                  _loc3_.writeUnsignedInt(this.FCurBuyType);
                  SNetworkCore.Transceiver.PacketTransmit(_loc2_);
               }
               this.BackFunction(this.FCurBuyTypeCopy);
               break;
            case 2:
            case 4:
            case 5:
               _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_MAZE_Buy_Skip);
               _loc3_ = _loc2_.Data;
               _loc3_.writeUnsignedInt(this.FCurBuyType);
               SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         }
      }
      
      protected function OnCancel(param1:Object) : void
      {
         switch(this.FCurBuyTypeCopy)
         {
            case 0:
               this.FType0 = false;
               break;
            case 1:
               this.FType1 = false;
               break;
            case 2:
               this.FType2 = false;
               break;
            case 3:
               this.FType3 = false;
               break;
            case 4:
               this.FType4 = false;
               break;
            case 5:
               this.FType5 = false;
         }
      }
      
      protected function OnCheckBoxSelected(param1:Object, param2:Boolean) : void
      {
         switch(this.FCurBuyTypeCopy)
         {
            case 0:
               this.FType0 = param2;
               break;
            case 1:
               this.FType1 = param2;
               break;
            case 2:
               this.FType2 = param2;
               break;
            case 3:
               this.FType3 = param2;
               break;
            case 4:
               this.FType4 = param2;
               break;
            case 5:
               this.FType5 = param2;
         }
      }
      
      protected function TanKuang() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         this.FUIWindowConfirmationCopy.SetSelectedOrNot(false);
         switch(this.FCurBuyTypeCopy)
         {
            case 3:
               this.FUIWindowConfirmationCopy.SetCheckBox(false);
               if(this.FLostShenQiLogicData.BeginMiGongCishu >= this.FLostShenQiLogicData.MoRenMiGongCishu)
               {
                  _loc1_ = TUtilityString.Format(new ConsumeFrame(70430016).DescribeString,this.FLostShenQiLogicData.RestCost,this.FLostShenQiLogicData.VipCanRestCount - this.FLostShenQiLogicData.YiJingChongZhiCishu);
               }
               else
               {
                  _loc1_ = new ConsumeFrame(70430020).DescribeString;
               }
               break;
            case 0:
               this.FUIWindowConfirmationCopy.SetCheckBox(false);
               if(this.FLostShenQiLogicData.ShengYuTiaoGuoCiShu <= 0)
               {
                  this.FKengDie = true;
                  _loc2_ = int(this.FLostShenQiLogicData.BuyTiaoGuoShiJianCiShu);
                  if(_loc2_ >= this.FLostShenQiLogicData.TiaoGuoCostVector.length)
                  {
                     _loc2_ = this.FLostShenQiLogicData.TiaoGuoCostVector.length - 1;
                  }
                  _loc1_ = TUtilityString.Format(new ConsumeFrame(70430007).DescribeString,this.FLostShenQiLogicData.TiaoGuoCostVector[_loc2_]);
               }
               else
               {
                  this.FKengDie = false;
                  _loc1_ = new ConsumeFrame(70430017).DescribeString;
               }
               break;
            case 1:
               this.FUIWindowConfirmationCopy.SetCheckBox(false);
               if(this.FLostShenQiLogicData.ShengYuBianGengCiShu <= 0)
               {
                  this.FKengDie = true;
                  _loc2_ = int(this.FLostShenQiLogicData.GouMaiBianGengShiJianCiShu);
                  if(_loc2_ >= this.FLostShenQiLogicData.BianGengCostVector.length)
                  {
                     _loc2_ = this.FLostShenQiLogicData.BianGengCostVector.length - 1;
                  }
                  _loc1_ = TUtilityString.Format(new ConsumeFrame(70430008).DescribeString,this.FLostShenQiLogicData.BianGengCostVector[_loc2_]);
               }
               else
               {
                  this.FKengDie = false;
                  _loc1_ = new ConsumeFrame(70430018).DescribeString;
               }
               break;
            case 2:
               if(this.FType2)
               {
                  this.OnConfirmationOkCopy(null);
                  return;
               }
               this.FUIWindowConfirmationCopy.SetCheckBox(true);
               _loc2_ = int(this.FLostShenQiLogicData.GouMaiXIngDongDianCiShu);
               if(_loc2_ >= this.FLostShenQiLogicData.XingDongLiBuyCostVector.length)
               {
                  _loc2_ = this.FLostShenQiLogicData.XingDongLiBuyCostVector.length - 1;
               }
               _loc1_ = TUtilityString.Format(new ConsumeFrame(70430013).DescribeString,this.FLostShenQiLogicData.XingDongLiBuyCostVector[_loc2_],this.FLostShenQiLogicData.BuyXingDongOneTimeNum);
               break;
            case 4:
               if(this.FType4)
               {
                  this.OnConfirmationOkCopy(null);
                  return;
               }
               this.FUIWindowConfirmationCopy.SetCheckBox(true);
               _loc2_ = int(this.FLostShenQiLogicData.BuyTiaoGuoShiJianCiShu);
               if(_loc2_ >= this.FLostShenQiLogicData.TiaoGuoCostVector.length)
               {
                  _loc2_ = this.FLostShenQiLogicData.TiaoGuoCostVector.length - 1;
               }
               _loc1_ = TUtilityString.Format(new ConsumeFrame(70430014).DescribeString,this.FLostShenQiLogicData.TiaoGuoCostVector[_loc2_]);
               break;
            case 5:
               if(this.FType5)
               {
                  this.OnConfirmationOkCopy(null);
                  return;
               }
               this.FUIWindowConfirmationCopy.SetCheckBox(true);
               _loc2_ = int(this.FLostShenQiLogicData.GouMaiBianGengShiJianCiShu);
               if(_loc2_ >= this.FLostShenQiLogicData.BianGengCostVector.length)
               {
                  _loc2_ = this.FLostShenQiLogicData.BianGengCostVector.length - 1;
               }
               _loc1_ = TUtilityString.Format(new ConsumeFrame(70430015).DescribeString,this.FLostShenQiLogicData.BianGengCostVector[_loc2_]);
         }
         this.FUIWindowConfirmationCopy.Text = _loc1_;
         this.FUIWindowConfirmationCopy.Visible = true;
      }
      
      protected function BuyFunction() : void
      {
         this.FCurBuyType = 3;
         this.FCurBuyTypeCopy = 3;
         this.TanKuang();
      }
      
      protected function PACKETID_S2C_MAZE_Buy_Reset(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = param1.Data.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         EffectGenerateText(STRING_LOSTSHENQI.str8);
         this.MeiYiSi();
      }
      
      protected function BuyBackFunction(param1:int, param2:uint) : void
      {
         this.FCurBuyType = param1;
         this.FCurBuyTypeCopy = param2;
         this.TanKuang();
      }
      
      protected function PACKETID_S2C_MAZE_Buy_Skip(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc3_ = param1.Data.readUnsignedInt();
         switch(_loc3_)
         {
            case 0:
               ++this.FLostShenQiLogicData.BuyTiaoGuoShiJianCiShu;
               break;
            case 1:
               ++this.FLostShenQiLogicData.GouMaiBianGengShiJianCiShu;
               break;
            case 2:
               _loc3_ = this.FLostShenQiLogicData.BuyXingDongOneTimeNum;
               ++this.FLostShenQiLogicData.GouMaiXIngDongDianCiShu;
               this.FLostShenQiLogicData.XingDongDianShu += _loc3_;
         }
         this.FProcessoriShenQiMiGongDiTu.UpdateView();
      }
      
      protected function ShengJiBackFunction(param1:TInventory, param2:uint = 0) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_MAZE_Sacre_Level_Up);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(param1.Identifier0);
         _loc4_.writeUnsignedInt(param1.Identifier1);
         _loc4_.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function PACKETID_S2C_MAZE_Sacre_Level_Up(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = param1.Data.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         EffectGenerateText(STRING_LOSTSHENQI.str9);
         this.FProcessorLostShenQi.ShenQiShenJiBackFunction();
      }
      
      protected function MakeBtnFunction(param1:TInventory, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_MAZE_Forge_Sacre);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(param1.Identifier0);
         _loc4_.writeUnsignedInt(param1.Identifier1);
         _loc4_.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function PACKETID_S2C_MAZE_Forge_Sacre(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = param1.Data.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         EffectGenerateText(STRING_LOSTSHENQI.str10);
         this.FProcessorLostShenQi.ShenQiMakeBackFunction();
      }
      
      protected function PACKETID_C2S_MAZE_Start_Game() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_MAZE_Start_Game);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_S2C_MAZE_Start_Game(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = param1.Data.readUnsignedByte();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FLostShenQiLogicData.CurGameState = 1;
         this.FCurTabIndex = 1;
         this.woqu();
         this.PanelVisiByIndex();
      }
      
      protected function PACKETID_C2S_MAZE_Over_Game() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_MAZE_Over_Game);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_S2C_MAZE_Over_Game(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = param1.Data.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FLostShenQiLogicData.CurGameState = 0;
         this.FCurTabIndex = 0;
         this.PanelVisiByIndex();
      }
      
      protected function PACKETID_C2S_MAZE_Moved_Position() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_MAZE_Moved_Position);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_S2C_MAZE_Moved_Position(param1:TPacket) : void
      {
         this.FProcessoriShenQiMiGongDiTu.PACKETID_S2C_MAZE_Moved_Position(param1.Data);
      }
      
      protected function PACKETID_C2S_MAZE_Move_Position(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         this.FCurClickX = this.FLostShenQiLogicData.CurPosition_X;
         this.FCurClickY = this.FLostShenQiLogicData.CurPosition_Y;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_MAZE_Move_Position);
         _loc3_.Data.writeUnsignedInt(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
         if(this.FLostShenQiLogicData.OverPosition[0] == param1 && this.FLostShenQiLogicData.OverPosition[1] == param2 && this.FLostShenQiLogicData.XingDongDianShu > 0)
         {
            if(!this.FProcessorTiaoZhanShengLi.Visible)
            {
               this.FProcessorTiaoZhanShengLi.Visible = true;
               this.FProcessorTiaoZhanShengLi.OpenThisPanel();
               this.PACKETID_C2S_MAZE_Over_Game();
               this.FCurTabIndex = 0;
               this.PanelVisiByIndex();
            }
         }
      }
      
      protected function PACKETID_S2C_MAZE_Move_Position(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = param1.Data.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc2_ = param1.Data.readUnsignedInt();
         if(_loc2_ != 0)
         {
            this.ShowPanelByEventId(_loc2_);
         }
         this.woqu();
      }
      
      protected function woqu() : void
      {
         this.MeiYiSi();
         this.PACKETID_C2S_MAZE_Moved_Position();
         this.PACKETID_C2S_MAZE_Get_Event_Info();
      }
      
      protected function MeiYiSi() : void
      {
         this.PACKETID_C2S_MAZE_Get_Info();
      }
      
      protected function ShowPanelByEventId(param1:uint) : void
      {
         var _loc2_:TMazeconfig = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Mazeconfig,param1) as TMazeconfig;
         if(_loc2_)
         {
            switch(_loc2_.EventType)
            {
               case 1:
                  this.FProcessorTiaoZhanBoss.Nimei = _loc2_.WinRate;
                  this.FProcessorTiaoZhanBoss.Visible = true;
                  this.FProcessorTiaoZhanBoss.OpenThisPanel();
                  break;
               case 2:
                  this.PiaoZi(_loc2_.EventName);
                  this.BackFunction(2);
                  break;
               case 3:
                  this.PiaoZi(_loc2_.EventName);
                  this.BackFunction(2);
                  this.FLostShenQiLogicData.ShiFouYiQingChuMiWu = 1;
                  break;
               case 4:
                  this.PiaoZi(_loc2_.EventName);
                  this.BackFunction(2);
                  break;
               case 5:
                  this.BackFunction(2);
                  break;
               case 6:
                  this.BackFunction(2);
                  break;
               case 7:
                  this.BackFunction(2);
                  break;
               case 8:
                  this.FProcessorShaiZiGame.Visible = true;
                  this.FProcessorShaiZiGame.OpenThisPanel();
                  break;
               case 9:
                  this.FProcessorCaiQuanGame.Visible = true;
                  this.FProcessorCaiQuanGame.OpenThisPanel();
            }
         }
      }
      
      protected function BackFunctionCopy(param1:uint) : void
      {
         if(param1 == 2)
         {
            this.BackFunction(param1);
         }
         else
         {
            this.FCurBuyType = param1;
            this.FCurBuyTypeCopy = param1;
            this.TanKuang();
         }
      }
      
      protected function BackFunction(param1:uint) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_MAZE_Deal_Event);
         _loc2_.Data.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PACKETID_S2C_MAZE_Deal_Event(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc4_ = _loc3_.readUnsignedInt();
         _loc5_ = _loc3_.readUnsignedInt();
         _loc6_ = _loc3_.readUnsignedInt();
         this.FLostShenQiLogicData.TempValue = _loc3_.readUnsignedInt();
         if(this.FProcessorShaiZiGame.Visible)
         {
            this.FProcessorShaiZiGame.S_C_Back(_loc5_);
         }
         if(this.FProcessorCaiQuanGame.Visible)
         {
            this.FProcessorCaiQuanGame.S_C_Back(_loc5_);
         }
         if(_loc6_ == 2 && _loc4_ != 0)
         {
            if(!this.FProcessorHuoYingWenDa.Visible)
            {
               this.FProcessorHuoYingWenDa.UpdateView(_loc4_);
               this.FProcessorHuoYingWenDa.Visible = true;
               this.FProcessorHuoYingWenDa.OpenThisPanel();
            }
         }
         if(this.FProcessorTiaoZhanBoss.Visible)
         {
            this.FProcessorTiaoZhanBoss.Visible = false;
            if(_loc6_ == 2)
            {
               if(this.FSetStatusType != null)
               {
                  this.FSetStatusType(this,CONST_BATTLE.BattleType_MiGong,CONST_MUSIC.ID_SCENE_Arena);
               }
               if(this.FOnInitBattle != null)
               {
                  this.FOnInitBattle(this);
               }
            }
            else if(_loc6_ == 1)
            {
               this.PiaoZi(STRING_LOSTSHENQI.str11);
               this.ShowPanelByEventId(_loc4_);
            }
         }
         this.MeiYiSi();
      }
      
      protected function BackFunctionNiMei(param1:uint) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_MAZE_Answer_Question);
         _loc2_.Data.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PACKETID_S2C_MAZE_Answer_Question(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:String = null;
         var _loc4_:ByteArray = param1.Data;
         _loc2_ = _loc4_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc3_ = _loc4_.readUnsignedInt();
         this.FLostShenQiLogicData.TempValue = _loc4_.readUnsignedInt();
         if(this.FProcessorHuoYingWenDa.Visible)
         {
            this.FProcessorHuoYingWenDa.Visible = false;
         }
         if(_loc3_)
         {
            _loc5_ = TUtilityString.Format(new ConsumeFrame(70430003).DescribeString,SLogicsCore.LostShenQiLogicData.TempValue);
         }
         else
         {
            _loc5_ = TUtilityString.Format(new ConsumeFrame(70430004).DescribeString,SLogicsCore.LostShenQiLogicData.TempValue);
         }
         this.PiaoZi(_loc5_);
         this.woqu();
      }
      
      protected function PACKETID_C2S_MAZE_Get_Event_Info() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_MAZE_Get_Event_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_S2C_MAZE_Get_Event_Info(param1:TPacket) : void
      {
         this.FProcessoriShenQiMiGongDiTu.UpdateViewCopy();
         this.FProcessoriShenQiMiGongDiTu.PACKETID_S2C_MAZE_Get_Event_Info(param1.Data);
      }
      
      protected function PACKETID_C2S_MAZE_Get_Info() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_MAZE_Get_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_S2C_MAZE_Get_Info(param1:TPacket) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc2_:ByteArray = param1.Data;
         this.FLostShenQiLogicData.XingDongDianShu = _loc2_.readUnsignedInt();
         this.FLostShenQiLogicData.CurShiJianId = _loc2_.readUnsignedInt();
         this.FLostShenQiLogicData.BuyTiaoGuoShiJianCiShu = _loc2_.readUnsignedInt();
         this.FLostShenQiLogicData.ShiYongTiaoGuoShiJianCiShu = _loc2_.readUnsignedInt();
         this.FLostShenQiLogicData.GouMaiBianGengShiJianCiShu = _loc2_.readUnsignedInt();
         this.FLostShenQiLogicData.ShiYongBianGengShiJianCiShu = _loc2_.readUnsignedInt();
         this.FLostShenQiLogicData.GouMaiXIngDongDianCiShu = _loc2_.readUnsignedInt();
         this.FLostShenQiLogicData.MiGongJiFen = _loc2_.readUnsignedInt();
         this.FLostShenQiLogicData.ShiFouYiQingChuMiWu = _loc2_.readUnsignedInt();
         this.FLostShenQiLogicData.CurQuestionID = _loc2_.readUnsignedInt();
         this.FLostShenQiLogicData.CurPosition_X = _loc2_.readUnsignedInt();
         this.FLostShenQiLogicData.CurPosition_Y = _loc2_.readUnsignedInt();
         this.FLostShenQiLogicData.BeginMiGongCishu = _loc2_.readUnsignedInt();
         this.FLostShenQiLogicData.CurGameState = _loc2_.readUnsignedInt();
         this.FLostShenQiLogicData.YiJingChongZhiCishu = _loc2_.readUnsignedInt();
         this.FLostShenQiLogicData.BaseValue = _loc2_.readUnsignedInt();
         this.FProcessoriShenQiMiGongDiTu.ChuLiRoleWeiZi();
         if(this.FProcessorTiaoZhanBoss)
         {
            this.FProcessorTiaoZhanBoss.UpdateView();
         }
         if(this.FCurClickX < this.FLostShenQiLogicData.CurPosition_X)
         {
            _loc4_ = 2;
         }
         if(this.FCurClickX > this.FLostShenQiLogicData.CurPosition_X)
         {
            _loc4_ = 1;
         }
         if(this.FCurClickY < this.FLostShenQiLogicData.CurPosition_Y)
         {
            _loc4_ = 3;
         }
         if(this.FCurClickY > this.FLostShenQiLogicData.CurPosition_Y)
         {
            _loc4_ = 4;
         }
         this.FProcessoriShenQiMiGongDiTu.SetFangXiang(_loc4_);
         this.FProcessoriShenQiMiGongDiTu.UpdateViewCopy();
         this.FProcessorLostShenQi.UpdateViewByIndex(0);
      }
      
      protected function MC_Goto_FaQiFunctionClick() : void
      {
         if(this.FMC_Goto_FaQiFunction != null)
         {
            this.FMC_Goto_FaQiFunction();
         }
      }
      
      public function set MC_Goto_FaQiFunction(param1:Function) : void
      {
         this.FMC_Goto_FaQiFunction = param1;
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
   }
}

