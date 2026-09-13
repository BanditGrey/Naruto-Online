package Processors.Game.Lobby.Married
{
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Homeland.THomelandModel;
   import Processors.Game.Lobby.Married.Panel.TUIMarriedApply;
   import Processors.Game.Lobby.Married.Panel.TUIMarriedCheck;
   import Processors.Game.Lobby.Married.Panel.TUIMarriedDivorce;
   import Processors.Game.Lobby.Married.Panel.TUIMarriedInlet;
   import Processors.Game.Lobby.Married.Panel.TUIMarriedTreatment;
   import Processors.Game.Lobby.Married.Panel.TUIRingTips;
   import Processors.Game.Lobby.MarryRank.TMarryRankModel;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorMarried extends TProcessorLobbyWindows
   {
      
      public static const PRE_APPLY:int = 1;
      
      public static const PRE_DIVORCE:int = 2;
      
      public static const APPLY:int = 3;
      
      public static const TREATMENT:int = 4;
      
      public static const DIVORCE:int = 5;
      
      protected var FMC_Scene:MovieClip;
      
      public var Inlet:TUIMarriedInlet;
      
      public var Apply:TUIMarriedApply;
      
      public var Treatment:TUIMarriedTreatment;
      
      public var Divorce:TUIMarriedDivorce;
      
      public var Check:TUIMarriedCheck;
      
      public var Tips:TUIRingTips;
      
      protected var FHelpTips:THint;
      
      public function TProcessorMarried(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.Inlet = new TUIMarriedInlet(this);
         this.Apply = new TUIMarriedApply(this);
         this.Treatment = new TUIMarriedTreatment(this);
         this.Divorce = new TUIMarriedDivorce(this);
         this.Check = new TUIMarriedCheck(this);
         this.Tips = new TUIRingTips(this);
         this.FHelpTips = new THint();
         SetUIModuleID(CONST_MODULES.MODULE_Married);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(4043309057);
         super.ResourcesPerform_UIRequest();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.UpdateUI();
         this.PerformPacket_CS_InfoReq();
         TMarriedModel.EffectGenerateTextByErrorCode = EffectGenerateTextByErrorCode;
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Married_InfoRet,this.ProcessorOnInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Married_MarryRet,this.ProcessorOnMarryRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Married_AgreeRet,this.ProcessorOnAgreeRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Married_SettimeRet,this.ProcessorOnSettimeRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Married_RingChangeRet,this.ProcessorOnRingChangeRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Married_ChangeNameRet,this.ProcessorOnChangeNameRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Married_PickRoseRet,this.ProcessorOnPickRoseRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Married_FriendRet,this.ProcessorOnFriendRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Married_DivorceRet,this.ProcessorOnDivorceRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Married_BuyLandRet,this.ProcessorOnBuyLandRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Married_RankRet,this.ProcessorOnRankRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Married_ReceiveRet,this.ProcessorOnReceiveRet);
         super.PacketRegisterRoutines();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_MarriedMain") as MovieClip;
         this.FMC_Scene.x = (FUICore.StageWidth - this.FMC_Scene.width) / 2;
         this.FMC_Scene.y = 100;
         this.addChild(this.FMC_Scene);
         this.Inlet.Perform_UIDispatch(this.FMC_Scene["MC_Inlet"]);
         this.Apply.OnItemOver = UIComponentsHintOnOver;
         this.Apply.OnItemOut = UIComponentsHintOnOut;
         this.Apply.Perform_UIDispatch(this.FMC_Scene["MC_Apply"]);
         this.Treatment.OnItemOver = UIComponentsHintOnOver;
         this.Treatment.OnItemOut = UIComponentsHintOnOut;
         this.Treatment.Perform_UIDispatch(this.FMC_Scene["MC_Treatment"]);
         this.Divorce.OnItemOver = UIComponentsHintOnOver;
         this.Divorce.OnItemOut = UIComponentsHintOnOut;
         this.Divorce.Perform_UIDispatch(this.FMC_Scene["MC_Divorce"]);
         this.Check.OnItemOver = UIComponentsHintOnOver;
         this.Check.OnItemOut = UIComponentsHintOnOut;
         this.Check.Perform_UIDispatch(this.FMC_Scene["MC_Check"]);
         this.Tips.Perform_UIDispatch(this.FMC_Scene);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FIsResourcesLoadCompleted == false || Visible == false)
         {
            return;
         }
         if(Boolean(this.FMC_Scene) && this.FMC_Scene.visible)
         {
            if(Boolean(this.Apply) && this.Apply.Visible)
            {
               this.Apply.LogicsPerform();
            }
            if(Boolean(this.Treatment) && this.Treatment.Visible)
            {
               this.Treatment.LogicsPerform();
            }
         }
      }
      
      protected function UpdateUI() : void
      {
      }
      
      protected function PerformPacket_CS_InfoReq() : void
      {
         var _loc1_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Married_InfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      private function ProcessorOnInfoRet(param1:TPacket) : void
      {
         THomelandModel.ProcessorOnInfoRet(THomelandModel.copyByteArray(param1.Data));
         if(this.visible == false)
         {
            return;
         }
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         var _loc4_:int = _loc2_.readInt();
         var _loc5_:int = _loc2_.readInt();
         var _loc6_:int = _loc2_.readInt();
         var _loc7_:int = _loc2_.readInt();
         var _loc8_:int = int(_loc2_.readUnsignedInt());
         var _loc9_:int = int(_loc2_.readUnsignedInt());
         var _loc10_:int = int(_loc2_.readUnsignedInt());
         var _loc11_:int = int(_loc2_.readUnsignedInt());
         if(_loc7_ == 0)
         {
            if(_loc5_ == 0)
            {
               this.Status = PRE_APPLY;
               this.Apply.data = {"status":0};
            }
            else if(SLogicsCore.Character.Identifier0 == _loc8_ && SLogicsCore.Character.Identifier1 == _loc9_)
            {
               this.Status = APPLY;
               this.Apply.data = {
                  "status":1,
                  "Identifier0":_loc10_,
                  "Identifier1":_loc11_,
                  "ring":_loc5_
               };
            }
            else
            {
               this.Status = TREATMENT;
               this.Treatment.data = {
                  "Identifier0":_loc8_,
                  "Identifier1":_loc9_,
                  "Ring":_loc5_
               };
            }
         }
         else if(_loc7_ == 1)
         {
            this.Status = PRE_DIVORCE;
            if(SLogicsCore.Character.Identifier0 == _loc8_ && SLogicsCore.Character.Identifier1 == _loc9_)
            {
               this.Divorce.data = {
                  "Identifier0":_loc10_,
                  "Identifier1":_loc11_,
                  "Ring":_loc5_
               };
            }
            else
            {
               this.Divorce.data = {
                  "Identifier0":_loc8_,
                  "Identifier1":_loc9_,
                  "Ring":_loc5_
               };
            }
         }
      }
      
      private function ProcessorOnMarryRet(param1:TPacket) : void
      {
         var _loc4_:int = 0;
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         _loc4_ = _loc2_.readInt();
         if(_loc4_ == 0)
         {
            EffectGenerateTextByErrorCode(1382);
         }
         this.PerformPacket_CS_InfoReq();
      }
      
      private function ProcessorOnAgreeRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.PerformPacket_CS_InfoReq();
         OnClose(this);
      }
      
      private function ProcessorOnSettimeRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         OnClose(this);
      }
      
      private function ProcessorOnRingChangeRet(param1:TPacket) : void
      {
         THomelandModel.ProcessorOnRingChangeRet(param1);
      }
      
      private function ProcessorOnChangeNameRet(param1:TPacket) : void
      {
         THomelandModel.ProcessorOnChangeNameRet(param1);
      }
      
      private function ProcessorOnPickRoseRet(param1:TPacket) : void
      {
         THomelandModel.ProcessorOnPickRoseRet(param1);
      }
      
      private function ProcessorOnFriendRet(param1:TPacket) : void
      {
         THomelandModel.ProcessorOnFriendRet(param1);
      }
      
      private function ProcessorOnDivorceRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.PerformPacket_CS_InfoReq();
         this.OnWindowClose();
      }
      
      private function ProcessorOnBuyLandRet(param1:TPacket) : void
      {
         THomelandModel.ProcessorOnBuyLandRet(param1);
      }
      
      private function ProcessorOnRankRet(param1:TPacket) : void
      {
         TMarryRankModel.ProcessorOnRankRet(param1);
      }
      
      private function ProcessorOnReceiveRet(param1:TPacket) : void
      {
         TMarryRankModel.ProcessorOnReceiveRet(param1);
      }
      
      public function OnWindowClose(param1:MouseEvent = null) : void
      {
         ProcessorClose();
      }
      
      public function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_70170111) as TSystemLanguage;
         this.FHelpTips.Content = _loc2_.Desc;
         UIHelpTipsHintOnOver(this,this.FHelpTips);
      }
      
      public function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         UIHelpTipsHintOnOut(this);
      }
      
      public function set Status(param1:int) : void
      {
         this.Inlet.Status = param1;
         this.Apply.Status = param1;
         this.Treatment.Status = param1;
         this.Divorce.Status = param1;
      }
   }
}

