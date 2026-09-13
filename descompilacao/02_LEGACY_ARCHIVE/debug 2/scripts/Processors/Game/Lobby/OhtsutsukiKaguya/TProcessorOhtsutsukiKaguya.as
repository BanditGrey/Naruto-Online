package Processors.Game.Lobby.OhtsutsukiKaguya
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.OhtsutsukiKaguya.Data.OhtsutsukiKaguyaData;
   import Processors.Game.Lobby.OhtsutsukiKaguya.PanelMc.TProcessorPanelOne;
   import Processors.Game.Lobby.OhtsutsukiKaguya.PanelMc.TProcessorPanelThree;
   import Processors.Game.Lobby.OhtsutsukiKaguya.PanelMc.TProcessorPanelTwo;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_OhtsutsukiKaguya;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_OhtsutsukiKaguya;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.utils.ByteArray;
   
   public class TProcessorOhtsutsukiKaguya extends TProcessorLobbyWindows
   {
      
      protected var FOnePanel:TProcessorPanelOne = null;
      
      protected var FTwoPanel:TProcessorPanelTwo = null;
      
      protected var FThreePanel:TProcessorPanelThree = null;
      
      protected var FKaguyaData:OhtsutsukiKaguyaData = null;
      
      protected var FPopWindow:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var IsInitilization:Boolean;
      
      protected var FUpdateOthersPanel:Function;
      
      protected var wocao:int;
      
      protected var FJumpTerm:Function;
      
      public function TProcessorOhtsutsukiKaguya(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FKaguyaData = SLogicsCore.KaguyaData;
         this.FOnePanel = new TProcessorPanelOne(this);
         this.FOnePanel.OnClose = this.CloseMe;
         this.FOnePanel.FreeBackFun = this.FreeBackFun;
         this.FOnePanel.CostBackFun = this.CostBackFun;
         this.FTwoPanel = new TProcessorPanelTwo(this);
         this.FTwoPanel.OnClose = this.CloseMe;
         this.FTwoPanel.ConfirmFun = this.BTN_ConfirmClick;
         this.FTwoPanel.GetGiftFun = this.BTN_GetGiftClick;
         this.FTwoPanel.getInitilization = this.InitilizationBackFun;
         this.FTwoPanel.JumpTerm = this.Jump;
         this.FThreePanel = new TProcessorPanelThree(this);
         this.FThreePanel.OnClose = this.CloseThree;
         this.FThreePanel.BackGetVipFun = this.CostBackFun;
         SetUIModuleID(CONST_MODULES.MODULE_Kaguya);
      }
      
      protected function CloseThree(param1:TUIComponent) : void
      {
         this.FThreePanel.visible = false;
      }
      
      protected function CloseMe(param1:TUIComponent) : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_OhtsutsukiKaguya.This_Resource_Id);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FPopWindow = new TUIWindowConfirmation(this);
         this.FPopWindow.OnOK = this.PopWindowOnOk;
         this.FPopWindow.x = (FUICore.StageWidth - this.FPopWindow.WindowWidth) / 2;
         this.FPopWindow.y = (FUICore.StageHeight - this.FPopWindow.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FPopWindow);
         this.FPopWindow.visible = false;
         this.FUIWindowRecharge = new TUIWindowRecharge(this);
         this.FUIWindowRecharge.x = (FUICore.StageWidth - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (FUICore.StageHeight - this.FUIWindowRecharge.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.IsInitilization = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.SysLanuage();
         super.ResourcesPerform_UILocations();
      }
      
      protected function SysLanuage() : void
      {
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.OhtsutsukiKaguya_Openlevel) as TConfigValue;
         this.FKaguyaData.OpenLevel = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.OhtsutsukiKaguya_Buy_GiveExp) as TConfigValue;
         this.FKaguyaData.ExpArr = _loc1_.Value as Vector.<Object>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.OhtsutsukiKaguya_Expend) as TConfigValue;
         this.FKaguyaData.GoldArr = _loc1_.Value as Vector.<Object>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.OhtsutsukiKaguya_Duration) as TConfigValue;
         this.FKaguyaData.TimeArr = _loc1_.Value as Vector.<Object>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.OhtsutsukiKaguya_OriginalPrice) as TConfigValue;
         this.FKaguyaData.BeforeValue = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.OhtsutsukiKaguya_OriginalPriceArr) as TConfigValue;
         this.FKaguyaData.BeforeGoldArr = _loc1_.Value as Vector.<Object>;
      }
      
      override protected function LogicsPerform() : void
      {
         if(Boolean(this.FTwoPanel) && Boolean(this.visible) && this.FTwoPanel.visible)
         {
            this.FTwoPanel.UpdateImage();
         }
         super.LogicsPerform();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FOnePanel.Load();
            this.FTwoPanel.Load();
            this.FThreePanel.Load();
            return;
         }
         this.InitilizationBackFun();
      }
      
      protected function ShowPanelByType(param1:int) : void
      {
         this.FOnePanel.visible = false;
         this.FTwoPanel.visible = false;
         switch(param1)
         {
            case 0:
               this.FOnePanel.SetState(param1);
               this.FOnePanel.visible = true;
               break;
            case 1:
               this.FOnePanel.SetState(param1);
               this.FOnePanel.visible = true;
               break;
            case 2:
               this.FTwoPanel.visible = true;
               this.FTwoPanel.OpenThisPanel();
         }
      }
      
      protected function InitilizationBackFun() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         this.FKaguyaData.IsCanOpenpanel = true;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Dark_Bright_Get_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function FreeBackFun() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Dark_Bright_Get_Free);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function CostBackFun(param1:int) : void
      {
         var _loc2_:String = null;
         this.wocao = param1;
         _loc2_ = new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_KaguyaBuy).DescribeString;
         _loc2_ = _loc2_.split("%n").join("\n");
         this.FPopWindow.Text = TUtilityString.Format(_loc2_,this.FKaguyaData.GoldArr[this.wocao][1],this.FKaguyaData.TimeArr[this.wocao][1]);
         this.FPopWindow.visible = true;
      }
      
      protected function PopWindowOnOk(param1:Object) : void
      {
         var _loc2_:uint = uint(this.FKaguyaData.GoldArr[this.wocao][1]);
         if(SLogicsCore.Character.CreditGold < _loc2_)
         {
            this.FUIWindowRecharge.visible = true;
         }
         else
         {
            this.RealCao();
         }
      }
      
      protected function RealCao() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Dark_Bright_Get_RMB);
         _loc1_.Data.writeUnsignedInt(this.wocao);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function BTN_ConfirmClick() : void
      {
         this.FThreePanel.visible = true;
         this.FThreePanel.OpenPanel();
      }
      
      protected function BTN_GetGiftClick() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Dark_Bright_Get_Reward);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Dark_Bright_Get_Info,this.PACKETID_SC_Dark_Bright_Get_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Dark_Bright_Get_Free,this.PACKETID_SC_Dark_Bright_Get_Free);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Dark_Bright_Set_RMB,this.PACKETID_SC_Dark_Bright_Set_RMB);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Dark_Bright_Get_Reward,this.PACKETID_SC_Dark_Bright_Get_Reward);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Dark_Bright_Privilege,this.PACKETID_SC_Dark_Bright_Privilege);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Dark_Bright_addTems,this.PACKETID_SC_Dark_Bright_addTems);
      }
      
      public function PACKETID_SC_Dark_Bright_addTems(param1:TPacket) : void
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
         ++SLogicsCore.GroupBattleData.PVETimes;
         SLogicsCore.KaguyaData.C_S_Privilege(4);
         if(this.FUpdateOthersPanel != null)
         {
            this.FUpdateOthersPanel(4);
         }
      }
      
      public function PACKETID_SC_Dark_Bright_Privilege(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         _loc5_ = _loc2_.readInt();
         if(_loc4_ != 7)
         {
            if(_loc4_ > this.FKaguyaData.Type_Count_Vector.length)
            {
               this.FKaguyaData.Type_Count_Vector.push(_loc5_);
            }
            else
            {
               this.FKaguyaData.Type_Count_Vector[_loc4_] = _loc5_;
            }
         }
         if(this.FUpdateOthersPanel != null)
         {
            this.FUpdateOthersPanel(_loc4_);
         }
      }
      
      public function PACKETID_SC_Dark_Bright_Get_Reward(param1:TPacket) : void
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
         this.FKaguyaData.IsCanGetReward = true;
         EffectGenerateText(STRING_OhtsutsukiKaguya.GetReward_Successful_Tip);
         this.FTwoPanel.OpenThisPanel();
      }
      
      protected function PACKETID_SC_Dark_Bright_Set_RMB(param1:TPacket) : void
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
         EffectGenerateText(STRING_OhtsutsukiKaguya.Open_Successful_Tip);
         this.InitilizationBackFun();
      }
      
      protected function PACKETID_SC_Dark_Bright_Get_Free(param1:TPacket) : void
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
         this.InitilizationBackFun();
      }
      
      protected function PACKETID_SC_Dark_Bright_Get_Info(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            this.FKaguyaData.IsCanOpenpanel = false;
            if(this.IsInitilization)
            {
               EffectGenerateTextByErrorCode(_loc3_);
               return;
            }
         }
         var _loc4_:int = int(_loc2_.readUnsignedInt());
         this.FKaguyaData.IsCanGetReward = Boolean(_loc4_);
         this.FKaguyaData.CurLevelAllExp_ = _loc2_.readUnsignedInt();
         this.FKaguyaData.EndTime = _loc2_.readUnsignedInt();
         this.FKaguyaData.CurExp = _loc2_.readUnsignedInt();
         this.FKaguyaData.CurLevel = _loc2_.readUnsignedInt();
         this.FKaguyaData.OpenState = _loc2_.readUnsignedInt();
         if(this.FKaguyaData.OpenState == 1 || this.FKaguyaData.OpenState == 2)
         {
            if(SLogicsCore.KaguyaData.EndTime <= STimingCore.GetServerTick())
            {
               this.FKaguyaData.IsLongTime = 7;
            }
            else
            {
               this.FKaguyaData.IsLongTime = 8;
            }
         }
         if(this.FKaguyaData.CurLevel >= 1)
         {
            _loc5_ = "";
            _loc5_ = this.FKaguyaData.getArrByType(7);
            if(_loc5_ != "")
            {
               _loc6_ = this.getStr(_loc5_);
               this.FKaguyaData.PropertyTypeVec.length = 0;
               this.FKaguyaData.PropertyValueVec.length = 0;
               if(_loc6_.length)
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc6_.length)
                  {
                     this.FKaguyaData.PropertyTypeVec.push(_loc6_[_loc4_][0]);
                     this.FKaguyaData.PropertyValueVec.push(_loc6_[_loc4_][1]);
                     _loc4_++;
                  }
               }
            }
         }
         if(!this.IsInitilization || !this.FKaguyaData.IsCanOpenpanel)
         {
            return;
         }
         this.FKaguyaData.IsCanOpenpanel = false;
         if(this.FKaguyaData.OpenState == 1)
         {
            if(SLogicsCore.KaguyaData.EndTime <= STimingCore.GetServerTick())
            {
               this.ShowPanelByType(1);
            }
            else
            {
               this.ShowPanelByType(2);
            }
         }
         else if(this.FKaguyaData.OpenState == 0)
         {
            this.ShowPanelByType(this.FKaguyaData.OpenState);
         }
         else if(SLogicsCore.KaguyaData.EndTime <= STimingCore.GetServerTick())
         {
            this.ShowPanelByType(1);
         }
         else
         {
            this.ShowPanelByType(this.FKaguyaData.OpenState);
         }
      }
      
      protected function getStr(param1:String) : Array
      {
         var _loc4_:int = 0;
         param1 = param1.substring(1,param1.length - 1);
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(true)
         {
            _loc3_ = param1.indexOf("[",_loc3_);
            if(_loc3_ == -1)
            {
               break;
            }
            _loc4_ = param1.indexOf("]",_loc3_);
            if(_loc4_ == -1)
            {
               return _loc2_;
            }
            _loc3_ += 1;
            _loc2_.push(param1.substring(_loc3_,_loc4_).split(","));
            _loc3_ = _loc4_;
         }
         return _loc2_;
      }
      
      public function set UpdateOthersPanel(param1:Function) : void
      {
         this.FUpdateOthersPanel = param1;
      }
      
      protected function Jump(param1:int) : void
      {
         if(this.FJumpTerm != null)
         {
            this.ShowPanelByType(3);
            this.FJumpTerm(param1);
         }
      }
      
      public function set JumpTerm(param1:Function) : void
      {
         this.FJumpTerm = param1;
      }
   }
}

