package Processors.Game.Lobby.Prerogative
{
   import Foundation.Container.THashMap;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.DatebaseVO.VO.TPlatformID;
   import Logics.Prerogative.TPlatformPrerogative;
   import Logics.SLogicsCore;
   import Logics.Streamization.Prerogative.TUnstreamizerPrerogative;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_PREROGATIVE;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorPrerogative extends TProcessorLobbyWindows
   {
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var FStatuesHashMap:THashMap;
      
      protected var FProcessorWindowPrerogative:TProcessorWindowPrerogative;
      
      protected var FPlatformPrerogative:TPlatformPrerogative;
      
      protected var FUnstreamizerPrerogative:TUnstreamizerPrerogative;
      
      protected var FShowFlatformIconEffect:Function;
      
      public function TProcessorPrerogative(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowPrerogative = new TProcessorWindowPrerogative(this);
         this.FProcessorWindowPrerogative.OnInventoryOver = UIComponentsHintOnOver;
         this.FProcessorWindowPrerogative.OnInventoryOut = UIComponentsHintOnOut;
         this.FProcessorWindowPrerogative.OnClose = this.ProcessorWindowOnClose;
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_Prerogative);
         FOverlayerEquipment.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_Prerogative);
         FOverlayerAccessory.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_Prerogative);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_Prerogative);
         FOverlayerAppliance.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         this.FPlatformPrerogative = SLogicsCore.PlatformPrerogative;
         this.FUnstreamizerPrerogative = new TUnstreamizerPrerogative();
         this.FStatuesHashMap = new THashMap();
         SetUIModuleID(CONST_MODULES.MODULE_Prerogative);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_PREROGATIVE.RESOURCESID_Swf_PREROGATIVE);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Prerogative_Data_Ret,this.PacketPerform_SC_Data_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Prerogative_Reward_Ret,this.PacketPerform_SC_Reward_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Prerogative_Data2_Ret,this.PacketPerform_SC_Data2_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Prerogative_Reward2_Ret,this.PacketPerform_SC_Reward2_Ret);
      }
      
      protected function PacketPerform_SC_Data_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TPlatformID = null;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerPrerogative.UnstreamizeVIPWelfare(null,this.FPlatformPrerogative.PrerogativeOnes,null);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_PlatformID,SLogicsCore.Character.AgentOperatorId) as TPlatformID;
         this.FPlatformPrerogative.IsOpen = _loc4_.Open;
         this.FPlatformPrerogative.AgentName = _loc4_.Platform;
         _loc7_ = int(_loc2_.readUnsignedInt());
         this.FPlatformPrerogative.YearStatus = _loc2_.readUnsignedInt();
         this.FPlatformPrerogative.MemberLevel = _loc2_.readUnsignedInt();
         this.FPlatformPrerogative.LastLoginMemberLevel = _loc2_.readUnsignedInt();
         this.FPlatformPrerogative.YearPayIsGet = Boolean(_loc2_.readUnsignedInt());
         this.FPlatformPrerogative.CommonPayIsGet = Boolean(_loc2_.readUnsignedInt());
         this.FPlatformPrerogative.BecomeMemberURL = _loc4_.BecomeMemberURL;
         this.FPlatformPrerogative.YearMemberURL = _loc4_.YearMemberURL;
         this.FPlatformPrerogative.MemberDescURL = _loc4_.MemberDescURL;
         if(this.FPlatformPrerogative.MemberLevel == 0)
         {
            _loc5_ = true;
         }
         else
         {
            _loc5_ = this.FPlatformPrerogative.CommonPayIsGet;
         }
         if(this.FPlatformPrerogative.YearStatus == 0)
         {
            _loc6_ = true;
         }
         else
         {
            _loc6_ = this.FPlatformPrerogative.YearPayIsGet;
         }
         this.FStatuesHashMap.Put(_loc7_,[_loc5_,_loc6_]);
         if(this.FShowFlatformIconEffect != null)
         {
            this.FShowFlatformIconEffect(this,this.CheckStatues());
         }
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowPrerogative.Update();
            this.FProcessorWindowPrerogative.Visible = true;
         }
      }
      
      protected function PacketPerform_SC_Data2_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TPlatformID = null;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerPrerogative.UnstreamizeVIPWelfare(null,this.FPlatformPrerogative.PrerogativeOnes,null);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_PlatformID,SLogicsCore.Character.AgentOperatorId) as TPlatformID;
         this.FPlatformPrerogative.IsOpen = _loc4_.Open;
         this.FPlatformPrerogative.AgentName = _loc4_.Platform;
         _loc7_ = int(_loc2_.readUnsignedInt());
         this.FPlatformPrerogative.YearStatus = _loc2_.readUnsignedInt();
         this.FPlatformPrerogative.MemberLevel = _loc2_.readUnsignedInt();
         this.FPlatformPrerogative.LastLoginMemberLevel = _loc2_.readUnsignedInt();
         this.FPlatformPrerogative.CommonPayIsGet = Boolean(_loc2_.readUnsignedInt());
         this.FPlatformPrerogative.YearPayIsGet = Boolean(_loc2_.readUnsignedInt());
         if(this.FPlatformPrerogative.MemberLevel == 0)
         {
            _loc5_ = true;
         }
         else
         {
            _loc5_ = this.FPlatformPrerogative.CommonPayIsGet;
         }
         if(this.FPlatformPrerogative.YearStatus == 0)
         {
            _loc6_ = true;
         }
         else
         {
            _loc6_ = this.FPlatformPrerogative.YearPayIsGet;
         }
         this.FStatuesHashMap.Put(_loc7_,[_loc5_,_loc6_]);
         if(this.FShowFlatformIconEffect != null)
         {
            this.FShowFlatformIconEffect(this,this.CheckStatues());
         }
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowPrerogative.Update();
            this.FProcessorWindowPrerogative.Visible = true;
         }
      }
      
      protected function CheckStatues() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         _loc2_ = this.FStatuesHashMap.Size();
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = this.FStatuesHashMap.Get(_loc1_ + 1) as Array;
            _loc4_ = int(_loc5_.length);
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               if(_loc5_[_loc3_] == false)
               {
                  return true;
               }
               _loc3_++;
            }
            _loc1_++;
         }
         return false;
      }
      
      protected function PacketPerform_SC_Reward_Ret(param1:TPacket) : void
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
         this.FPlatformPrerogative.MajorType = _loc2_.readUnsignedInt();
         this.FPlatformPrerogative.MinorType = _loc2_.readUnsignedInt();
         this.ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
         this.PacketPerform_CS_Data_Req();
      }
      
      protected function PacketPerform_SC_Reward2_Ret(param1:TPacket) : void
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
         this.FPlatformPrerogative.MajorType = _loc2_.readUnsignedInt();
         this.FPlatformPrerogative.MinorType = _loc2_.readUnsignedInt();
         this.ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowPrerogative.Update();
            this.FProcessorWindowPrerogative.Visible = true;
         }
         this.PacketPerform_CS_Data2_Req();
      }
      
      public function PacketPerform_CS_Data2_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Prerogative_Data2_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function PacketPerform_CS_Data_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Prerogative_Data_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorWindowOnClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      protected function ProcessorEffectText(param1:String) : void
      {
         if(FOnEffectText != null)
         {
            FOnEffectText(this,param1);
         }
      }
      
      public function set ShowFlatformIconEffect(param1:Function) : void
      {
         this.FShowFlatformIconEffect = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowPrerogative.Load();
            return;
         }
         this.visible = true;
         this.alpha = 1;
         this.PacketPerform_CS_Data_Req();
      }
      
      override public function Unmount() : void
      {
         this.visible = false;
         this.FProcessorWindowPrerogative.ResetTab();
         super.Unmount();
      }
   }
}

