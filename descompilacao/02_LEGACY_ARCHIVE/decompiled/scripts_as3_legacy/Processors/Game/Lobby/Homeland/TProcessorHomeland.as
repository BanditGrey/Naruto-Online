package Processors.Game.Lobby.Homeland
{
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.TFriendDigest;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Homeland.Panel.TUIChangeName;
   import Processors.Game.Lobby.Homeland.Panel.TUIExtendLand;
   import Processors.Game.Lobby.Homeland.Panel.TUIFriendInfo;
   import Processors.Game.Lobby.Homeland.Panel.TUIHomeInfo;
   import Processors.Game.Lobby.Homeland.Panel.TUILandInfo;
   import Processors.Game.Lobby.Homeland.Panel.TUIMarriedList;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   
   public class TProcessorHomeland extends TProcessorLobbyWindows
   {
      
      public var FMC_Scene:MovieClip;
      
      public var FHomeInfo:TUIHomeInfo;
      
      public var FFriendInfo:TUIFriendInfo;
      
      public var FLandInfo:TUILandInfo;
      
      public var FMarryList:TUIMarriedList;
      
      public var FChangeName:TUIChangeName;
      
      public var FExtendLand:TUIExtendLand;
      
      public var FHelpTips:THint;
      
      public function TProcessorHomeland(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         THomelandModel.UpdateUI = this.UpdateUI;
         THomelandModel.ProcessorOnInfoRet = this.ProcessorOnInfoRet;
         THomelandModel.ProcessorOnRingChangeRet = this.ProcessorOnRingChangeRet;
         THomelandModel.ProcessorOnChangeNameRet = this.ProcessorOnChangeNameRet;
         THomelandModel.ProcessorOnPickRoseRet = this.ProcessorOnPickRoseRet;
         THomelandModel.ProcessorOnFriendRet = this.ProcessorOnFriendRet;
         THomelandModel.ProcessorOnBuyLandRet = this.ProcessorOnBuyLandRet;
         this.FHelpTips = new THint();
         SetUIModuleID(CONST_MODULES.MODULE_Homeland);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(4043309059);
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
         this.PerformPacket_CS_FriendReq();
         if(THomelandModel.Status == 1)
         {
            THomelandModel.goHomeland(SLogicsCore.Character.Identifier0,SLogicsCore.Character.Identifier1);
         }
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_Scene["BTN_Close"].addEventListener(MouseEvent.CLICK,this.OnWindowClose);
         this.FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OVER,this.ButtonHelpOnOver);
         this.FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
         this.FMC_Scene["BTN_Pick"].addEventListener(MouseEvent.CLICK,this.OnClickPickAll);
         TGameUtil.setButtonMode(this.FMC_Scene["BTN_Pick"],true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_Homeland") as MovieClip;
         this.addChild(this.FMC_Scene);
         this.FHomeInfo = new TUIHomeInfo(this.FMC_Scene["MC_HomelandInfo"]);
         this.FFriendInfo = new TUIFriendInfo(this.FMC_Scene["MC_FriendInfo"]);
         this.FLandInfo = new TUILandInfo(this.FMC_Scene["MC_LandInfo"]);
         this.FLandInfo.EffectGenerateTextByErrorCode = EffectGenerateTextByErrorCode;
         this.FMarryList = new TUIMarriedList(this.FMC_Scene["MC_MarryList"]);
         this.FMarryList.visible = false;
         this.FChangeName = new TUIChangeName(this.FMC_Scene["MC_ChangeName"]);
         this.FChangeName.visible = false;
         this.FExtendLand = new TUIExtendLand(this.FMC_Scene["MC_ExtendLand"]);
         this.FExtendLand.visible = false;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
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
            this.FLandInfo.LogicsPerform();
         }
      }
      
      protected function UpdateUI() : void
      {
         this.FHomeInfo.UpdateUI();
         this.FFriendInfo.UpdateUI();
         this.FLandInfo.UpdateUI();
      }
      
      protected function PerformPacket_CS_InfoReq() : void
      {
         var _loc1_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Married_InfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      private function ProcessorOnInfoRet(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readInt();
         var _loc3_:int = param1.readInt();
         THomelandModel.selfHome.ringId = param1.readInt();
         THomelandModel.selfHome.ringExp = param1.readInt();
         THomelandModel.selfHome.status = param1.readInt();
         THomelandModel.selfHome.userid_1_0 = param1.readUnsignedInt();
         THomelandModel.selfHome.userid_1_1 = param1.readUnsignedInt();
         THomelandModel.selfHome.userid_2_0 = param1.readUnsignedInt();
         THomelandModel.selfHome.userid_2_1 = param1.readUnsignedInt();
         THomelandModel.selfHome.charm = param1.readInt();
         THomelandModel.selfHome.pick = param1.readInt();
         THomelandModel.selfHome.buyLand = param1.readInt();
         THomelandModel.selfHome.landName = THomelandModel.readString(param1);
         THomelandModel.selfLand = THomelandModel.readLandInfo(param1);
         THomelandModel.selectedTime = THomelandModel.readSelectedTime(param1);
         THomelandModel.selfHome.receive = param1.readInt();
         THomelandModel.selfHome.userrace_0 = param1.readInt();
         THomelandModel.selfHome.userrace_1 = param1.readInt();
         THomelandModel.selfHome.username_0 = THomelandModel.readString(param1);
         THomelandModel.selfHome.username_1 = THomelandModel.readString(param1);
         if(this.visible)
         {
            this.UpdateUI();
         }
         THomelandModel.UpdateShortcuts();
      }
      
      protected function ProcessorOnRingChangeRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         THomelandModel.selfHome.ringExp = _loc2_.readInt();
         if(THomelandModel.UpdateRingUI != null)
         {
            THomelandModel.UpdateRingUI();
         }
      }
      
      protected function ProcessorOnChangeNameRet(param1:TPacket) : void
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
      }
      
      protected function ProcessorOnPickRoseRet(param1:TPacket) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         _loc5_ = int(_loc2_.readUnsignedInt());
         _loc6_ = _loc2_.readInt();
         _loc7_ = _loc2_.readInt();
         this.FLandInfo.pickTips(_loc6_,_loc7_);
         if(THomelandModel.Status == 0)
         {
            this.PerformPacket_CS_InfoReq();
         }
         else
         {
            this.PerformPacket_CS_FriendReq();
         }
      }
      
      protected function PerformPacket_CS_FriendReq() : void
      {
         var _loc4_:TFriendDigest = null;
         var _loc5_:TPacket = null;
         if(THomelandModel.selfLand.length == 0)
         {
            setTimeout(this.PerformPacket_CS_FriendReq,1000);
            return;
         }
         var _loc1_:Vector.<TFriendDigest> = new Vector.<TFriendDigest>();
         var _loc2_:int = int(SLogicsCore.Friends.Count);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = SLogicsCore.Friends.GetDigestByIndex(_loc3_);
            if(!(_loc4_.Identifier0 == THomelandModel.selfHome.userid_1_0 && _loc4_.Identifier1 == THomelandModel.selfHome.userid_1_1))
            {
               if(!(_loc4_.Identifier0 == THomelandModel.selfHome.userid_2_0 && _loc4_.Identifier1 == THomelandModel.selfHome.userid_2_1))
               {
                  _loc1_.push(_loc4_);
               }
            }
            _loc3_++;
         }
         if(_loc1_.length > 0)
         {
            _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Married_FriendReq);
            _loc5_.Data.writeShort(_loc1_.length);
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               _loc5_.Data.writeUnsignedInt(_loc1_[_loc3_].Identifier0);
               _loc5_.Data.writeUnsignedInt(_loc1_[_loc3_].Identifier1);
               _loc3_++;
            }
            SNetworkCore.Transceiver.PacketTransmit(_loc5_);
         }
         else
         {
            this.UpdateUI();
         }
      }
      
      private function ProcessorOnFriendRet(param1:TPacket) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Boolean = false;
         var _loc11_:Object = null;
         THomelandModel.friendInfos.length = 0;
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readShort();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            THomelandModel.friendInfos.push({
               "Identifier0":_loc2_.readUnsignedInt(),
               "Identifier1":_loc2_.readUnsignedInt()
            });
            _loc4_++;
         }
         _loc3_ = _loc2_.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = _loc2_.readUnsignedInt();
            _loc7_ = _loc2_.readUnsignedInt();
            _loc8_ = _loc2_.readUnsignedInt();
            _loc9_ = _loc2_.readUnsignedInt();
            THomelandModel.friendInfos[_loc4_].host = THomelandModel.readString(_loc2_);
            THomelandModel.friendInfos[_loc4_].hostess = THomelandModel.readString(_loc2_);
            THomelandModel.friendInfos[_loc4_].landName = THomelandModel.readString(_loc2_);
            THomelandModel.friendInfos[_loc4_].charm = _loc2_.readInt();
            THomelandModel.friendInfos[_loc4_].landInfo = THomelandModel.readLandInfo(_loc2_);
            _loc4_++;
         }
         var _loc5_:Vector.<Object> = new Vector.<Object>();
         _loc3_ = int(THomelandModel.friendInfos.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc10_ = false;
            for each(_loc11_ in _loc5_)
            {
               if(_loc11_.host == THomelandModel.friendInfos[_loc4_].host && _loc11_.hostess == THomelandModel.friendInfos[_loc4_].hostess)
               {
                  _loc10_ = true;
                  break;
               }
            }
            if(_loc10_ == false)
            {
               _loc5_.push(THomelandModel.friendInfos[_loc4_]);
            }
            _loc4_++;
         }
         THomelandModel.friendInfos = _loc5_;
         this.UpdateUI();
      }
      
      private function ProcessorOnBuyLandRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         if(THomelandModel.Status == 0)
         {
            this.PerformPacket_CS_InfoReq();
         }
         else
         {
            this.PerformPacket_CS_FriendReq();
         }
      }
      
      public function OnWindowClose(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      public function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_70170112) as TSystemLanguage;
         this.FHelpTips.Content = _loc2_.Desc;
         UIHelpTipsHintOnOver(this,this.FHelpTips);
      }
      
      public function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         UIHelpTipsHintOnOut(this);
      }
      
      public function OnClickPickAll(param1:MouseEvent) : void
      {
         this.FLandInfo.pickAllRose();
      }
   }
}

