package Processors.Game.Lobby.FirstRecharge
{
   import Components.Slots.TUISlot;
   import Externals.SExternalCore;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.ActivityMode.TActivityAtom;
   import Logics.ActivityMode.TActivityAtoms;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TActiveList;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Signals.TSignal;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_COUNTER;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_FIRSTRECHAGE;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_RECHARGE;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SIGNAL;
   import Resources.Strings.STRING_RECHARGE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorFirstRecharge extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH_Recharge:uint = 590;
      
      protected static const SIZE_HIGHT_Recharge:uint = 426;
      
      protected static const FIRST_RECHARGE:uint = 1;
      
      protected static const RECHARGE:uint = 2;
      
      protected static const CAPACITY_SLOTS:uint = 6;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const KEY_FirstRecharge:uint = CONST_COUNTER.KEY_FirstRecharge;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const SIGNALDESTINATION_ACTIVE_FirstRecharge_Ret:uint = CONST_SIGNAL.SIGNALDESTINATION_ACTIVE_FirstRecharge_Ret;
      
      public static const SYSTEMLANGUAGE_FIRST_RECHARGE_NINJA_TIP:int = 70100016;
      
      public static const CONFIGVALUE_ID_FIRST_RECHARGE:int = 60380002;
      
      protected var FMC_FirstRecharge:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FTF_GiftValue:TextField;
      
      protected var FBTN_GetReward:MovieClip;
      
      protected var FBTN_Recharge:MovieClip;
      
      protected var FTF_FirstRecharge:TextField;
      
      protected var FTF_Recharge:TextField;
      
      protected var FTF_CurRecharge:TextField;
      
      protected var FTF_NeedRecharge:TextField;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FHelpTips:THint;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FMCList:Vector.<MovieClip>;
      
      protected var FInitialized:Boolean;
      
      protected var FActivityAtoms:TActivityAtoms;
      
      protected var FActivityAtom:TActivityAtom;
      
      protected var FRechargeValue:uint;
      
      protected var FCharacter:TCharacter;
      
      protected var FConfigValue:TConfigValue;
      
      protected var FOnNewFirstRechargeGift:Function;
      
      protected var FOnFirstRechargeSpecial:Function;
      
      public function TProcessorFirstRecharge(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FSlotList = new Vector.<TUISlot>(CAPACITY_SLOTS);
         this.FMCList = new Vector.<MovieClip>();
         this.FHelpTips = new THint();
         this.FCharacter = SLogicsCore.Character;
         this.FInitialized = false;
         SetUIModuleID(CONST_MODULES.MODULE_FirstRecharge);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_FIRSTRECHAGE.RESOURCESID_Swf_FirstRecharge);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         this.FMC_FirstRecharge = TUtilityReflection.CreateDisplayObjectInstance(CONST_FIRSTRECHAGE.RESOURCE_ClassName_MC_FirstRecharge) as MovieClip;
         addChild(this.FMC_FirstRecharge);
         this.FMC_FirstRecharge.x = CONST_COMMON.STAGE_Width - SIZE_WIDTH_Recharge >> 1;
         this.FMC_FirstRecharge.y = CONST_COMMON.STAGE_Height - SIZE_HIGHT_Recharge >> 1;
         this.FBTN_Close = this.FMC_FirstRecharge[CONST_FIRSTRECHAGE.RESOURCE_Link_BTN_Close];
         this.FTF_GiftValue = this.FMC_FirstRecharge[CONST_FIRSTRECHAGE.RESOURCE_Link_TF_GiftValue];
         this.FBTN_GetReward = this.FMC_FirstRecharge[CONST_FIRSTRECHAGE.RESOURCE_Link_BTN_GetReward];
         this.FBTN_Recharge = this.FMC_FirstRecharge[CONST_FIRSTRECHAGE.RESOURCE_Link_BTN_Recharge];
         TGameUtil.setButtonMode(this.FBTN_GetReward,true);
         TGameUtil.setButtonMode(this.FBTN_Recharge,true);
         this.FMC_Effect = this.FMC_FirstRecharge[CONST_FIRSTRECHAGE.RESOURCE_Link_MC_Effect];
         this.FMC_Effect.mouseEnabled = false;
         this.FirstRechargeUIDispatch(this.FMC_FirstRecharge["MC_FirstRechargeGift"]);
         this.FMCList.push(this.FMC_FirstRecharge["MC_FirstRechargeGift"]);
         this.RechargeUIDispatch(this.FMC_FirstRecharge["MC_Recharge"]);
         this.FMCList.push(this.FMC_FirstRecharge["MC_Recharge"]);
         _loc2_ = CAPACITY_SLOTS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_FirstRecharge[CONST_RECHARGE.RESOURCE_Link_MC_Slot + _loc1_] as MovieClip;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.Tag = _loc1_;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnOverlay = UIComponentsHintOnOver;
            _loc3_.OnOut = UIComponentsHintOnOut;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.Init();
            this.FSlotList[_loc1_] = _loc3_;
            _loc1_++;
         }
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_FirstRecharge);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_FirstRecharge);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_FirstRecharge);
         FOverlayerAppliance.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_FirstRecharge);
         FOverlayerAccessory.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this.Parent);
         FOverlayerHelpTips.Visible = false;
         this.FInitialized = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TActiveList = null;
         super.ResourcesPerform_UILocations();
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ButtonOnClose,false,0,true);
         this.FBTN_GetReward.addEventListener(MouseEvent.CLICK,this.ButtonOnGetReward,false,0,true);
         this.FBTN_Recharge.addEventListener(MouseEvent.CLICK,this.ButtonRechargeOnClick,false,0,true);
         if(this.FMC_FirstRecharge["MC_FirstRechargeGift"].MC_Tip)
         {
            this.FMC_FirstRecharge["MC_FirstRechargeGift"].MC_Tip.buttonMode = true;
            this.FMC_FirstRecharge["MC_FirstRechargeGift"].MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnNinJaOnOver);
            this.FMC_FirstRecharge["MC_FirstRechargeGift"].MC_Tip.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnNinJaOnOut);
         }
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         super.LogicsPerform();
         if(this.FInitialized)
         {
            _loc2_ = this.FSlotList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FSlotList[_loc1_].Update();
               _loc1_++;
            }
         }
         this.LogicsPerform_Signals();
         if(this.Visible)
         {
            this.LogicsPerform_RechargeSignals();
         }
      }
      
      protected function LogicsPerform_Signals() : void
      {
         var _loc1_:TSignal = null;
         var _loc2_:uint = 0;
         var _loc3_:TActivityAtoms = null;
         _loc1_ = SLogicsCore.SignalRetrieve(SIGNALDESTINATION_ACTIVE_FirstRecharge_Ret);
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = _loc1_.Identifier;
         _loc3_ = _loc1_.UserData as TActivityAtoms;
         this.FActivityAtoms = _loc3_;
         this.FActivityAtoms.SortActivityAtoms();
         this.PlayEffectFirstRecharge();
         if(this.FActivityAtoms.GetActivityAtomByIndex(this.FActivityAtoms.Count - 1).ActiveStatus == -1)
         {
            this.ButtonOnClose(null);
            this.FActivityAtoms.IsOn = false;
            return;
         }
         if(this.FInitialized)
         {
            this.Init();
         }
      }
      
      protected function LogicsPerform_RechargeSignals() : void
      {
         var _loc1_:TSignal = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc1_ = SLogicsCore.SignalRetrieve(CONST_SIGNAL.SIGNALDESTINATION_ACTIVE_RechargeDetail_Ret);
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = _loc1_.Identifier;
         _loc3_ = uint(_loc1_.Value);
         switch(_loc2_)
         {
            case KEY_FirstRecharge:
               this.FRechargeValue = _loc3_;
         }
         this.UpdateActiveProgress();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
      }
      
      protected function FirstRechargeUIDispatch(param1:MovieClip) : void
      {
         this.FTF_FirstRecharge = param1[CONST_FIRSTRECHAGE.RESOURCE_Link_TF_GiftValue];
      }
      
      protected function RechargeUIDispatch(param1:MovieClip) : void
      {
         this.FTF_Recharge = param1[CONST_FIRSTRECHAGE.RESOURCE_Link_TF_GiftValue];
         this.FTF_CurRecharge = param1[CONST_FIRSTRECHAGE.RESOURCE_Link_TF_CurRecharge];
         this.FTF_NeedRecharge = param1[CONST_FIRSTRECHAGE.RESOURCE_Link_TF_NeedRecharge];
      }
      
      protected function PlayEffectFirstRecharge() : void
      {
         this.FConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONFIGVALUE_ID_FIRST_RECHARGE) as TConfigValue;
         if(Boolean(this.FConfigValue.Value) && Boolean(this.FCharacter.VipData.VipExp <= 90) && this.FCharacter.VipData.VipLevel == 0)
         {
            this.FOnFirstRechargeSpecial(CONST_SHORTCUTS.POSITION_ActiveList,CONST_SHORTCUTS.TYPE_ActiveList_FirstRecharge,true);
         }
         else if(this.FOnNewFirstRechargeGift != null)
         {
            this.FOnFirstRechargeSpecial(CONST_SHORTCUTS.POSITION_ActiveList,CONST_SHORTCUTS.TYPE_ActiveList_FirstRecharge,false);
            this.FOnNewFirstRechargeGift(CONST_SHORTCUTS.POSITION_ActiveList,CONST_SHORTCUTS.TYPE_ActiveList_FirstRecharge,this.CheckHasGet());
         }
      }
      
      protected function CheckHasGet() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TActivityAtom = null;
         _loc2_ = uint(this.FActivityAtoms.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FActivityAtoms.GetActivityAtomByIndex(_loc1_);
            if(_loc3_.ActiveStatus > 0)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      protected function UpdateActiveProgress() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TActivityAtom = null;
         _loc2_ = uint(this.FActivityAtoms.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FActivityAtoms.GetActivityAtomByIndex(_loc1_);
            if(_loc1_ == 0)
            {
               if(_loc3_.ActiveStatus >= 0)
               {
                  this.FMCList[1].visible = false;
                  this.FMCList[0].visible = true;
                  this.PlayEffects(true);
                  this.FActivityAtom = _loc3_;
                  this.UpdateFirstRecharge(_loc3_);
                  break;
               }
            }
            else if(_loc3_.ActiveStatus >= 0)
            {
               this.FMCList[1].visible = true;
               this.FMCList[0].visible = false;
               this.PlayEffects(false);
               this.FActivityAtom = _loc3_;
               this.UpdateRecharge(_loc3_);
               break;
            }
            _loc1_++;
         }
         if(this.FActivityAtom != null)
         {
            if(this.FActivityAtom.ActiveStatus >= 1)
            {
               this.FBTN_GetReward.mouseEnabled = true;
               TGameUtil.setButtonMode(this.FBTN_GetReward,true);
            }
            else
            {
               this.FBTN_GetReward.mouseEnabled = false;
               TGameUtil.setButtonMode(this.FBTN_GetReward,false);
            }
         }
      }
      
      protected function PlayEffects(param1:Boolean = true) : void
      {
         if(param1)
         {
            this.FMC_Effect.play();
            this.FMC_Effect.visible = true;
         }
         else
         {
            this.FMC_Effect.stop();
            this.FMC_Effect.visible = false;
         }
      }
      
      protected function UpdateFirstRecharge(param1:TActivityAtom) : void
      {
         this.FTF_GiftValue.text = this.FTF_FirstRecharge.text = param1.Price.toString();
         this.UpdateSlot(param1);
      }
      
      protected function UpdateRecharge(param1:TActivityAtom) : void
      {
         this.FTF_GiftValue.text = this.FTF_Recharge.text = param1.Price.toString();
         this.FTF_CurRecharge.text = this.FRechargeValue.toString();
         this.FTF_NeedRecharge.text = param1.ConditionValue[0].toString();
         this.UpdateSlot(param1);
      }
      
      protected function UpdateSlot(param1:TActivityAtom) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         _loc3_ = this.FSlotList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FSlotList[_loc2_].Context = null;
            this.FSlotList[_loc2_].Resource.visible = false;
            _loc2_++;
         }
         _loc3_ = uint(param1.InventoriesVect[0].Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(_loc2_ >= param1.InventoriesVect[0].Count)
            {
               break;
            }
            this.FSlotList[_loc2_].Context = param1.InventoriesVect[0].GetInventoryByIndex(_loc2_);
            this.FSlotList[_loc2_].Resource.visible = true;
            _loc2_++;
         }
      }
      
      protected function Init() : void
      {
         this.UpdateActiveProgress();
      }
      
      protected function PerformPacket_CS_UpdateCounterReq() : void
      {
         var _loc1_:Vector.<uint> = null;
         _loc1_ = new Vector.<uint>(1);
         _loc1_[0] = KEY_FirstRecharge;
         SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_ACTIVE_RechargeDetail_Req,0,0,_loc1_);
      }
      
      protected function ButtonOnClose(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function ButtonOnGetReward(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FActivityAtom.ActiveStatus <= 0)
         {
            EffectGenerateText(STRING_RECHARGE.STRING_Recharge);
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Activity_ReceiveAwardsReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FActivityAtom.Identifier);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ButtonRechargeOnClick(param1:MouseEvent) : void
      {
         SExternalCore.NavigateToRecharge();
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_FirstRecharge);
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
      
      protected function ProcessorOnNinJaOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,SYSTEMLANGUAGE_FIRST_RECHARGE_NINJA_TIP) as TSystemLanguage;
         if(_loc2_)
         {
            this.FHelpTips.Content = _loc2_.Desc;
            UIHelpTipsHintOnOver(this,this.FHelpTips);
         }
      }
      
      protected function ProcessorOnNinJaOnOut(param1:MouseEvent) : void
      {
         UIHelpTipsHintOnOut(this);
      }
      
      public function get OnNewFirstRechargeGift() : Function
      {
         return this.FOnNewFirstRechargeGift;
      }
      
      public function set OnNewFirstRechargeGift(param1:Function) : void
      {
         this.FOnNewFirstRechargeGift = param1;
      }
      
      public function get OnFirstRechargeSpecial() : Function
      {
         return this.FOnFirstRechargeSpecial;
      }
      
      public function set OnFirstRechargeSpecial(param1:Function) : void
      {
         this.FOnFirstRechargeSpecial = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.Init();
         this.PerformPacket_CS_UpdateCounterReq();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.PlayEffects(true);
      }
   }
}

