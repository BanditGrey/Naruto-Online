package Processors.Game.Lobby.GodEquip
{
   import Components.Slots.TUISlot;
   import Foundation.Common.TBounds;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Signals.TSignal;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_COUNTER;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_GODEQUIP;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SIGNAL;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorGodEquip extends TProcessorLobbyWindows
   {
      
      protected static const MAX_COUNT:uint = 6;
      
      protected static const SIZE_WindowWidth:uint = 330;
      
      protected static const SIZE_WindowHeight:uint = 306;
      
      protected var FScene:MovieClip;
      
      protected var FSlotVect:Vector.<TUISlot>;
      
      protected var FWindowBounds:TBounds;
      
      protected var FGodEquidIds:Vector.<Object>;
      
      protected var FGodEquidPrice:Vector.<Object>;
      
      protected var FGodEquidBuyLimit:uint;
      
      protected var FIDTemplates:Vector.<uint>;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUIWindowInformation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      public function TProcessorGodEquip(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         SetUIModuleID(CONST_MODULES.MODULE_GodEquip);
      }
      
      public static function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_GodEquip);
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_GODEQUIP.RESOURCESID_SWF_GODEQUIP);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TUISlot = null;
         var _loc3_:TConfigValue = null;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GODEQUIP_CREDITSUIT) as TConfigValue;
         this.FGodEquidIds = _loc3_.Value as Vector.<Object>;
         _loc1_ = 0;
         while(_loc1_ < this.FGodEquidIds.length)
         {
            if(this.FGodEquidIds[_loc1_]["pro"] == SLogicsCore.Character.GetMainHero().Profession)
            {
               this.FIDTemplates = Vector.<uint>(this.FGodEquidIds[_loc1_]["value"]);
               break;
            }
            _loc1_++;
         }
         this.FSlotVect = new Vector.<TUISlot>(MAX_COUNT);
         this.FInventories = new TInventories();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,this.FIDTemplates);
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_GODEQUIP.RESOURCE_ClassName_GODEQUIP) as MovieClip;
         addChild(this.FScene);
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc2_ = new TUISlot(this);
            _loc2_.Resource = this.FScene["MC_Slot_" + _loc1_];
            _loc2_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc2_.OnQuerySequenceContext = SlotsOnQuerySequenceContext;
            _loc2_.OnOverlay = UIComponentsHintOnOver;
            _loc2_.OnOut = UIComponentsHintOnOut;
            _loc2_.Init();
            this.FSlotVect[_loc1_] = _loc2_;
            this.FSlotVect[_loc1_].Context = this.FInventories.GetInventoryByIndex(_loc1_);
            _loc1_++;
         }
         this.FWindowBounds = new TBounds();
         this.FWindowBounds.Width = SIZE_WindowWidth;
         this.FWindowBounds.Height = SIZE_WindowHeight;
         ComponentBoundsCenter(this,this.FWindowBounds);
         FOverlayerEquipment = new TOverlayerEquipment(this.Parent,CONST_MODULES.MODULE_GodEquip);
         FOverlayerEquipment.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GODEQUIP_PRICE) as TConfigValue;
         this.FGodEquidPrice = _loc3_.Value as Vector.<Object>;
         this.FScene["MC_SpecialPrice"]["TF_Old"].text = this.FGodEquidPrice[0][1];
         this.FScene["MC_SpecialPrice"]["TF_New"].text = this.FGodEquidPrice[1][1];
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GODEQUIP_BUYLIMIT) as TConfigValue;
         this.FGodEquidBuyLimit = _loc3_.Value as uint;
         this.FUIWindowInformation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowInformation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowInformation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowInformation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowInformation);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FScene["Btn_Close"].addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick);
         this.FScene["MC_SpecialPrice"]["BTN_BecomeVIP"].addEventListener(MouseEvent.CLICK,this.ButtonBuyOnClick);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         super.LogicsPerform();
         if(FIsResourcesLoadCompleted && Visible)
         {
            this.LogicsPerform_Signals();
            _loc1_ = 0;
            while(_loc1_ < MAX_COUNT)
            {
               _loc3_ = this.FSlotVect[_loc1_];
               _loc3_.Update();
               _loc1_++;
            }
         }
      }
      
      protected function LogicsPerform_Signals() : void
      {
         var _loc1_:TSignal = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc1_ = SLogicsCore.SignalRetrieve(CONST_SIGNAL.SIGNALDESTINATION_COMMON_GodEquip_Ret);
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = _loc1_.Identifier;
         _loc3_ = uint(_loc1_.Value);
         if(_loc2_ != CONST_COUNTER.KEY_GodEquipBuyStatus)
         {
            return;
         }
         if(this.FScene != null)
         {
            TGameUtil.setButtonMode(this.FScene["MC_SpecialPrice"]["BTN_BecomeVIP"],Boolean(_loc3_ < this.FGodEquidBuyLimit));
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Common_BuyGodEquip_Ret,this.PacketPerform_SC_BuyGodEquip_Ret);
      }
      
      protected function PacketPerform_SC_BuyGodEquip_Ret(param1:TPacket) : void
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
         if(this.FScene != null)
         {
            TGameUtil.setButtonMode(this.FScene["MC_SpecialPrice"]["BTN_BecomeVIP"],false);
         }
      }
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function ButtonBuyOnClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(Boolean(param1.target) && !param1.target.buttonMode)
         {
            return;
         }
         if(SLogicsCore.Character.CreditGold < this.FGodEquidPrice[1][1])
         {
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         _loc2_ = new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_GodEquip).DescribeString;
         this.FUIWindowInformation.Text = TUtilityString.Format(_loc2_,this.FGodEquidPrice[1][1]);
         this.FUIWindowInformation.Visible = true;
      }
      
      protected function WindowInformationOnOK(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Common_BuyGodEquip_Req);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         var _loc2_:Vector.<uint> = null;
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         _loc2_ = Vector.<uint>([CONST_COUNTER.KEY_GodEquipBuyStatus]);
         SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_COMMON_GodEquip_Req,0,0,_loc2_);
      }
   }
}

