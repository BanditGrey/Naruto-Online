package Processors.Game.Lobby.Heros
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.*;
   import Logics.Streamization.Characters.*;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Common.*;
   import Rendering.Overlayers.*;
   import Rendering.Overlayers.BaseAttribute.*;
   import Rendering.Overlayers.FeteBlood.TCellForRolePanelTip;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.*;
   import Rendering.Overlayers.Inventories.*;
   import Rendering.Overlayers.Title.TOverlayerTitle;
   import Resources.Constants.*;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_HEROS;
   import Resources.Strings.STRING_TAVERN;
   import Utilities.UI.Overlayers.*;
   import flash.text.TextFormat;
   import flash.utils.*;
   
   public class TProcessorHeros extends TProcessorLobbyWindows
   {
      
      public static const SIZE_WindowHeros_Width:uint = 778;
      
      public static const SIZE_WindowHeros_Height:uint = 500;
      
      public static const CAPACITY_ParallelOutputRows:uint = 0;
      
      public static const COLOR_ADDITIONBASEATTRIBUTE:uint = 65280;
      
      public static const COLOR_REDUCINGBASEATTRIBUTE:uint = 16711680;
      
      public static const INDEXEQUIPMENTMOUNTED:Vector.<uint> = CONST_INVENTORY.INDEXEQUIPMENTMOUNTED;
      
      public static const INDEXTREASUREMOUNTED:Vector.<uint> = CONST_INVENTORY.INDEXTREASUREMOUNTED;
      
      public static const INDEXACCESSORIES:Vector.<uint> = CONST_INVENTORY.INDEXACCESSORIES;
      
      public static const INDEXMEDLS:Vector.<uint> = CONST_INVENTORY.INDEXMEDALS;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const CATEGORY_Medals:uint = CONST_INVENTORY.CATEGORY_Medals;
      
      public static const TYPE_MOUNT:uint = 0;
      
      public static const TYPE_DISMOUNT:uint = 1;
      
      public static const BASEATTRIBUTEDEFAULTINDEX_Speed:uint = 3;
      
      public static const BASEATTRIBUTEINDEX_Speed:uint = 4;
      
      public static const BASEATTRIBUTEINDEX_Health:uint = 3;
      
      public static const BASEATTRIBUTEINDEX_PhysicalAttack:uint = 9;
      
      public static const BASEATTRIBUTEINDEX_MagicAttack:uint = 13;
      
      public static const BASEATTRIBUTEINDEX_PhysicalDefends:uint = 10;
      
      public static const BASEATTRIBUTEINDEX_MagicDefends:uint = 14;
      
      public static const BASEATTRIBUTEINDEX:Vector.<uint> = Vector.<uint>([BASEATTRIBUTEINDEX_Speed,BASEATTRIBUTEINDEX_Health,BASEATTRIBUTEINDEX_PhysicalAttack,BASEATTRIBUTEINDEX_MagicAttack,BASEATTRIBUTEINDEX_PhysicalDefends,BASEATTRIBUTEINDEX_MagicDefends]);
      
      public static const CAPACITY_BASEATTRIBUTESCACHE:uint = BASEATTRIBUTEINDEX.length;
      
      public static const STRINGS_BASEATTRIBUTENAMES:Vector.<String> = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES;
      
      public static const FORMAT_ADDITIONBASEATTRIBUTE:String = STRING_HEROS.FORMAT_ADDITIONBASEATTRIBUTE;
      
      public static const FORMAT_REDUCINGBASEATTRIBUTE:String = STRING_HEROS.FORMAT_REDUCINGBASEATTRIBUTE;
      
      protected var FUnstreamizerCharacter:TUnstreamizerCharacter;
      
      protected var FOverlayerEquipmentMounted:TOverlayerEquipment;
      
      protected var FOverlayerAccessoryMounted:TOverlayerAccessory;
      
      protected var FOverlayerBaseAttribute:TOverlayerBaseAttribute;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FFBOverTip:TCellForRolePanelTip;
      
      protected var FEffectTextParameters:TEffectTextParameters;
      
      protected var FProcessorWindowHeros:TProcessorWindowHeros;
      
      protected var FProcessorWindowOneKeySwap:TProcessorWindowOneKeySwap;
      
      protected var FProcessorWindowExpInherit:TProcessorWindowExpInherit;
      
      protected var FProcessorWindowTitle:TProcessorWindowTitle;
      
      protected var FBaseAttributesCache:Vector.<int>;
      
      protected var FNewBaseAttributesCache:Vector.<int>;
      
      protected var FCharacter:TCharacter;
      
      protected var FUseInventory:TInventory;
      
      protected var FBoundsHeros:TBounds;
      
      protected var FExchangeBounds:TBounds;
      
      protected var FExpInheritBounds:TBounds;
      
      protected var FHeroID:uint;
      
      protected var FIsProcessorBaseAttributesEffect:Boolean;
      
      protected var FInit:Boolean;
      
      protected var FSystemLanguage:TSystemLanguage;
      
      protected var FStringID:uint;
      
      protected var FIsOneKeySwap:Boolean;
      
      protected var FTitles:TTitles;
      
      protected var FOnUpdateTalismanMount:Function;
      
      protected var FOnShortcutHyperlinks:Function;
      
      protected var FOnChangeSkillReq:Function;
      
      protected var FOnUpdateBaseAttributeRet:Function;
      
      protected var FOnUseInventory:Function;
      
      protected var FOnDismissHero:Function;
      
      protected var FOnUserUpdateBaseInfo:Function;
      
      protected var FOnUserTotalFightingPowerReq:Function;
      
      private var FGoToHerosFightWindow:Function;
      
      protected var FGoAccessoryPanel:Function;
      
      public var GoSoulFormation:Function;
      
      public var GoWing:Function;
      
      public var OpenJadeFun:Function;
      
      public var OnUpdateMedalMount:Function;
      
      protected var FTabIndex:int = 0;
      
      public function TProcessorHeros(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FCharacter = SLogicsCore.Character;
         this.FTitles = SLogicsCore.Titles;
         this.FUnstreamizerCharacter = new TUnstreamizerCharacter();
         this.FEffectTextParameters = new TEffectTextParameters();
         this.FEffectTextParameters.Font.Color = CONST_EFFECT.COLOR_EffectText;
         this.FProcessorWindowHeros = new TProcessorWindowHeros(this);
         this.FProcessorWindowHeros.OnClose = this.ProcessorWindowHerosOnClose;
         this.FProcessorWindowHeros.OnMountEquipment = this.Perform_CS_MountEquipment;
         this.FProcessorWindowHeros.OnMountAccessory = this.Perform_CS_MountEquipment;
         this.FProcessorWindowHeros.OnDismountEquipment = this.Perform_CS_DismountEquipment;
         this.FProcessorWindowHeros.OnShortcutHyperlinks = this.ProcessorOnShortcutHyperlinks;
         this.FProcessorWindowHeros.OnInventoryOver = this.UIComponentsOverlayerOnOver;
         this.FProcessorWindowHeros.OnInventoryOut = this.UIComponentsOverlayerOnOut;
         this.FProcessorWindowHeros.OnBaseAttributeOver = this.UIComponentsHintBaseAttributeOnOver;
         this.FProcessorWindowHeros.OnBaseAttributeOut = this.UIComponentsHintBaseAttributeOnOut;
         this.FProcessorWindowHeros.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowHeros.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowHeros.HintOnOver = this.UIComponentsHintOnOver1;
         this.FProcessorWindowHeros.HintOnOut = this.UIComponentsHintOnOut1;
         this.FProcessorWindowHeros.OnChangeSkillReq = this.ProcessorOnChangeSkillReq;
         this.FProcessorWindowHeros.OnUseInventory = this.ProcessorOnUseInventory;
         this.FProcessorWindowHeros.OnEffectText = ProcessorsOnEffectText;
         this.FProcessorWindowHeros.OnDismiss = this.ProcessorOnDismiss;
         this.FProcessorWindowHeros.AKeySwapOnClick = this.ProcessorAKeySwapOnClick;
         this.FProcessorWindowHeros.InheritOnClick = this.ProcessorInheritOnClick;
         this.FProcessorWindowHeros.OnOpenTitleManage = this.ProcessorOnOpenTitleManage;
         this.FProcessorWindowHeros.TitleHintOnOver = this.UITitleHintOnOver;
         this.FProcessorWindowHeros.TitleHintOnOut = this.UITitleHintOnOut;
         this.FProcessorWindowHeros.GoAccessoryPanel = this.GoAccessory;
         this.FProcessorWindowHeros.GoSoulFormation = this.ProcessorGotoSoulFormation;
         this.FProcessorWindowHeros.GoWing = this.ProcessorGotoWing;
         this.FProcessorWindowHeros.BFOnMove = this.BFOnMove;
         this.FProcessorWindowHeros.BFOnOut = this.BFOnOut;
         this.FProcessorWindowHeros.OpenJadeFun = this.ProcessorGotoJade;
         if(this.FGoToHerosFightWindow != null)
         {
            this.FProcessorWindowHeros.GoToHerosFightWindow = this.FGoToHerosFightWindow;
         }
         this.FBoundsHeros = new TBounds();
         this.FBoundsHeros.Width = SIZE_WindowHeros_Width;
         this.FBoundsHeros.Height = SIZE_WindowHeros_Height;
         ComponentBoundsCenter(this.FProcessorWindowHeros,this.FBoundsHeros);
         this.FProcessorWindowOneKeySwap = new TProcessorWindowOneKeySwap(this);
         this.FProcessorWindowOneKeySwap.OnClose = this.ProcessorOnWindowExchangeClose;
         this.FProcessorWindowOneKeySwap.ExchangeOnClick = this.ProcessorOnExchange;
         this.FProcessorWindowOneKeySwap.OnEffectText = this.ProdessorOnEffectText;
         this.FExchangeBounds = new TBounds();
         this.FExchangeBounds.X = this.FProcessorWindowOneKeySwap.x;
         this.FExchangeBounds.Y = this.FProcessorWindowOneKeySwap.y;
         this.FExchangeBounds.Width = 688;
         this.FExchangeBounds.Height = 408;
         ComponentBoundsCenter(this.FProcessorWindowOneKeySwap,this.FExchangeBounds);
         this.FProcessorWindowExpInherit = new TProcessorWindowExpInherit(this);
         this.FProcessorWindowExpInherit.OnClose = this.ProcessorOnWindowInheritClose;
         this.FProcessorWindowExpInherit.ExchangeOnClick = this.ProcessorOnInherit;
         this.FProcessorWindowExpInherit.OnEffectText = this.ProdessorOnEffectText;
         this.FExpInheritBounds = new TBounds();
         this.FExpInheritBounds.X = this.FProcessorWindowExpInherit.x;
         this.FExpInheritBounds.Y = this.FProcessorWindowExpInherit.y;
         this.FExpInheritBounds.Width = 688;
         this.FExpInheritBounds.Height = 408;
         ComponentBoundsCenter(this.FProcessorWindowExpInherit,this.FExpInheritBounds);
         this.FProcessorWindowTitle = new TProcessorWindowTitle(this,CONST_MODULES.MODULE_Heros);
         this.FProcessorWindowTitle.OnEquipTitle = this.ProcessorOnEquipTitle;
         this.FBaseAttributesCache = new Vector.<int>(CAPACITY_BASEATTRIBUTESCACHE);
         this.FNewBaseAttributesCache = new Vector.<int>(CAPACITY_BASEATTRIBUTESCACHE);
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.visible = false;
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_Heros);
         FOverlayerEquipment.Visible = false;
         this.FOverlayerEquipmentMounted = new TOverlayerEquipment(this,CONST_MODULES.MODULE_Heros);
         this.FOverlayerEquipmentMounted.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_Heros);
         FOverlayerAccessory.visible = false;
         this.FOverlayerAccessoryMounted = new TOverlayerAccessory(this,CONST_MODULES.MODULE_Heros);
         this.FOverlayerAccessoryMounted.visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_Heros);
         FOverlayerAppliance.Visible = false;
         this.FOverlayerBaseAttribute = new TOverlayerBaseAttribute(this);
         this.FOverlayerBaseAttribute.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         this.FOverlayerTitle = new TOverlayerTitle(this);
         this.FOverlayerTitle.Visible = false;
         this.FFBOverTip = new TCellForRolePanelTip(this);
         this.FFBOverTip.Visible = false;
         this.FHeroID = 0;
         this.FIsOneKeySwap = false;
         SetUIModuleID(CONST_MODULES.MODULE_Heros);
      }
      
      public function get GoToHerosFightWindow() : Function
      {
         return this.FGoToHerosFightWindow;
      }
      
      public function set GoToHerosFightWindow(param1:Function) : void
      {
         this.FGoToHerosFightWindow = param1;
         if(this.FProcessorWindowHeros != null)
         {
            this.FProcessorWindowHeros.GoToHerosFightWindow = this.FGoToHerosFightWindow;
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_HEROS.RESOURCESID_Swf_Heros);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerEquipmentMounted);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAccessoryMounted);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBaseAttribute);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTitle);
         TUtilityUIOverlayer.ResourcesDispatch(this.FFBOverTip);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Heros_UseExpAppliance,this.PerformPacket_SC_Heros_UseExpAppliance);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Heros_Dismount,this.PerformPacket_SC_Heros_Dismount);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Heros_Mount,this.PerformPacket_SC_Heros_Mount);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Heros_DeleteHero,this.PerformPacket_SC_Heros_DeleteHero);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Heros_Inherit,this.PerformPacket_SC_Heros_Inherit);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Heros_OneKeySwap,this.PerformPacket_SC_Heros_OneKeySwap);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Common_AddHeroNum_Ret,this.PerformPacket_SC_Common_AddHeroNumRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Heros_Pvp,this.PACKETID_SC_Heros_Pvp);
      }
      
      protected function PerformPacket_SC_Heros_UseExpAppliance(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:TInventory = null;
         var _loc5_:TInventories = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         _loc3_ = param1.Data;
         this.FProcessorWindowHeros.SetBtnLock(true);
         _loc2_ = int(_loc3_.readUnsignedByte());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc6_ = _loc3_.readUnsignedInt();
         _loc7_ = _loc3_.readUnsignedInt();
         _loc8_ = int(_loc3_.readUnsignedByte());
         _loc5_ = this.FCharacter.Appliances;
         _loc4_ = _loc5_.GetInventoryByIdentifier(_loc6_,_loc7_);
         if(_loc4_ != null)
         {
            _loc4_.Quantity = _loc8_;
         }
         _loc5_.Sort();
         this.FProcessorWindowHeros.UpdateCharacterInventory();
      }
      
      protected function PACKETID_SC_Heros_Pvp(param1:TPacket) : void
      {
         this.FProcessorWindowHeros.PACKETID_SC_Heros_Pvp(param1);
      }
      
      protected function PerformPacket_SC_Heros_Dismount(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:THero = null;
         var _loc7_:TInventory = null;
         var _loc8_:TInventories = null;
         var _loc9_:TInventories = null;
         var _loc10_:TInventories = null;
         var _loc11_:TInventories = null;
         var _loc12_:TInventories = null;
         var _loc13_:TCollectionInventory = null;
         var _loc14_:TCollectionInventory = null;
         var _loc15_:TCollectionInventory = null;
         var _loc16_:TCollectionInventory = null;
         var _loc17_:TCollectionInventory = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:uint = 0;
         var _loc21_:TEquipment = null;
         _loc2_ = param1.Data;
         this.FProcessorWindowHeros.SetBtnLock(true);
         _loc20_ = _loc2_.readUnsignedInt();
         if(_loc20_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc20_);
            return;
         }
         _loc5_ = int(_loc2_.readUnsignedInt());
         _loc6_ = this.FCharacter.Heros.GetHeroByIdentifier(_loc5_);
         _loc8_ = this.FCharacter.Equipments;
         _loc9_ = this.FCharacter.Treasures;
         _loc10_ = this.FCharacter.Accessories;
         _loc12_ = this.FCharacter.Medals;
         _loc13_ = _loc6_.EquipmentsMounted;
         _loc14_ = _loc6_.TalismansMounted;
         _loc15_ = _loc6_.AccessoryMounted;
         _loc17_ = _loc6_.MedalsMounted;
         _loc4_ = int(_loc2_.readUnsignedShort());
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc18_ = int(_loc2_.readUnsignedByte());
            _loc19_ = INDEXEQUIPMENTMOUNTED.indexOf(_loc18_);
            if(_loc19_ >= 0)
            {
               _loc18_ = _loc19_;
               _loc16_ = _loc13_;
               _loc11_ = _loc8_;
            }
            else
            {
               _loc19_ = INDEXACCESSORIES.indexOf(_loc18_);
               if(_loc19_ >= 0)
               {
                  _loc18_ = _loc19_;
                  _loc16_ = _loc15_;
                  _loc11_ = _loc10_;
               }
               else
               {
                  _loc19_ = INDEXTREASUREMOUNTED.indexOf(_loc18_);
                  if(_loc19_ >= 0)
                  {
                     _loc18_ = _loc19_;
                     _loc16_ = _loc14_;
                     _loc11_ = _loc9_;
                  }
                  else
                  {
                     _loc18_ = INDEXMEDLS.indexOf(_loc18_);
                     _loc16_ = _loc17_;
                     _loc11_ = _loc12_;
                  }
               }
            }
            _loc7_ = _loc16_.GetInventoryByIndex(_loc18_);
            if(_loc7_ != null)
            {
               _loc11_.Add(_loc7_);
               _loc16_.SetInventoryByIndex(_loc18_,null);
               _loc21_ = _loc7_ as TEquipment;
               _loc21_.SuitMemberId.length = 0;
            }
            _loc3_++;
         }
         if(_loc4_ == 0)
         {
            return;
         }
         if(_loc7_ == null)
         {
            return;
         }
         this.FHeroID = _loc5_;
         this.ProcessorHeroBaseAttributeReq(_loc5_);
         _loc11_.Sort();
         switch(_loc7_.Category)
         {
            case CATEGORY_Accessories:
            case CATEGORY_Equipment:
               this.ProcessorHeroEquipmentMountedSuitCount(_loc6_,_loc7_,TYPE_DISMOUNT);
               this.FProcessorWindowHeros.UpdateCharacterInventory();
               break;
            case CATEGORY_Treasure:
               if(this.FOnUpdateTalismanMount != null)
               {
                  this.FOnUpdateTalismanMount(this);
               }
               break;
            case CATEGORY_Medals:
               if(this.OnUpdateMedalMount != null)
               {
                  this.OnUpdateMedalMount(this);
               }
         }
         if(this.FOnUserTotalFightingPowerReq != null)
         {
            this.FOnUserTotalFightingPowerReq(this);
         }
      }
      
      protected function PerformPacket_SC_Heros_Mount(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         var _loc5_:THero = null;
         var _loc6_:TInventory = null;
         var _loc7_:TInventory = null;
         var _loc8_:TInventories = null;
         var _loc9_:TInventories = null;
         var _loc10_:TInventories = null;
         var _loc11_:TInventories = null;
         var _loc12_:TInventories = null;
         var _loc13_:TCollectionInventory = null;
         var _loc14_:TCollectionInventory = null;
         var _loc15_:TCollectionInventory = null;
         var _loc16_:TCollectionInventory = null;
         var _loc17_:TCollectionInventory = null;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:int = 0;
         _loc3_ = param1.Data;
         this.FProcessorWindowHeros.SetBtnLock(true);
         _loc2_ = int(_loc3_.readUnsignedShort());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc4_ = int(_loc3_.readUnsignedInt());
         _loc5_ = this.FCharacter.Heros.GetHeroByIdentifier(_loc4_);
         _loc18_ = _loc3_.readUnsignedInt();
         _loc19_ = _loc3_.readUnsignedInt();
         _loc8_ = this.FCharacter.Equipments;
         _loc9_ = this.FCharacter.Treasures;
         _loc11_ = this.FCharacter.Accessories;
         _loc12_ = this.FCharacter.Medals;
         _loc13_ = _loc5_.EquipmentsMounted;
         _loc14_ = _loc5_.TalismansMounted;
         _loc16_ = _loc5_.AccessoryMounted;
         _loc17_ = _loc5_.MedalsMounted;
         _loc6_ = _loc8_.GetInventoryByIdentifier(_loc18_,_loc19_);
         if(_loc6_ == null)
         {
            _loc6_ = _loc11_.GetInventoryByIdentifier(_loc18_,_loc19_);
         }
         if(_loc6_ == null)
         {
            _loc6_ = _loc9_.GetInventoryByIdentifier(_loc18_,_loc19_);
         }
         if(_loc6_ == null)
         {
            _loc6_ = _loc12_.GetInventoryByIdentifier(_loc18_,_loc19_);
         }
         switch(_loc6_.Category)
         {
            case CATEGORY_Equipment:
               _loc20_ = INDEXEQUIPMENTMOUNTED.indexOf(_loc6_.CategorySecond);
               _loc7_ = _loc13_.GetInventoryByIndex(_loc20_);
               _loc15_ = _loc13_;
               _loc10_ = _loc8_;
               break;
            case CATEGORY_Treasure:
               _loc20_ = INDEXTREASUREMOUNTED.indexOf(_loc6_.CategorySecond);
               _loc7_ = _loc14_.GetInventoryByIndex(_loc20_);
               _loc15_ = _loc14_;
               _loc10_ = _loc9_;
               break;
            case CATEGORY_Accessories:
               _loc20_ = INDEXACCESSORIES.indexOf(_loc6_.CategorySecond);
               _loc7_ = _loc16_.GetInventoryByIndex(_loc20_);
               _loc15_ = _loc16_;
               _loc10_ = _loc11_;
               break;
            case CATEGORY_Medals:
               _loc20_ = INDEXMEDLS.indexOf(_loc6_.CategorySecond);
               _loc7_ = _loc17_.GetInventoryByIndex(_loc20_);
               _loc15_ = _loc17_;
               _loc10_ = _loc12_;
         }
         _loc15_.SetInventoryByIndex(_loc20_,_loc6_);
         _loc10_.DeleteInventoryByIdentifier(_loc18_,_loc19_);
         if(_loc7_ != null)
         {
            _loc10_.Add(_loc7_);
         }
         _loc10_.Sort();
         this.FHeroID = _loc4_;
         this.ProcessorHeroBaseAttributeReq(_loc4_);
         switch(_loc6_.Category)
         {
            case CATEGORY_Equipment:
               if(_loc7_ != null)
               {
                  this.ProcessorHeroEquipmentMountedSuitCount(_loc5_,_loc7_,TYPE_DISMOUNT);
               }
               this.ProcessorHeroEquipmentMountedSuitCount(_loc5_,_loc6_,TYPE_MOUNT);
               this.FProcessorWindowHeros.UpdateCharacterInventory();
               this.UIComponentsOverlayerOnOut(this,_loc6_,null);
               this.FProcessorWindowHeros.TabChangByMan(0);
               break;
            case CATEGORY_Treasure:
               if(this.FOnUpdateTalismanMount != null)
               {
                  this.FOnUpdateTalismanMount(this);
               }
               break;
            case CATEGORY_Accessories:
               if(_loc7_ != null)
               {
                  this.ProcessorHeroEquipmentMountedSuitCount(_loc5_,_loc7_,TYPE_DISMOUNT);
               }
               this.ProcessorHeroEquipmentMountedSuitCount(_loc5_,_loc6_,TYPE_MOUNT);
               this.FProcessorWindowHeros.UpdateCharacterInventory();
               this.UIComponentsOverlayerOnOut(this,_loc6_,null);
               if(FIsResourcesLoadCompleted)
               {
                  this.FProcessorWindowHeros.TabChangByMan(1);
               }
               break;
            case CATEGORY_Medals:
               if(this.OnUpdateMedalMount != null)
               {
                  this.OnUpdateMedalMount(this);
               }
         }
         if(this.FOnUserTotalFightingPowerReq != null)
         {
            this.FOnUserTotalFightingPowerReq(this);
         }
      }
      
      protected function PerformPacket_SC_Heros_DeleteHero(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:THero = null;
         _loc2_ = param1.Data;
         this.FProcessorWindowHeros.SetBtnLock(true);
         _loc3_ = _loc2_.readUnsignedShort();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = this.FCharacter.Heros.GetHeroByIdentifier(this.FHeroID);
         this.FCharacter.Heros.Delete(_loc4_);
         this.FProcessorWindowHeros.Update();
         if(this.FOnDismissHero != null)
         {
            this.FOnDismissHero(this,this.FHeroID);
         }
      }
      
      protected function PerformPacket_SC_Heros_OneKeySwap(param1:TPacket) : void
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
         EffectGenerateText(STRING_HEROS.STRING_Exchange);
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowOneKeySwap.Update();
         }
         if(this.FOnUserUpdateBaseInfo != null)
         {
            this.FOnUserUpdateBaseInfo(this);
         }
      }
      
      protected function PerformPacket_SC_Common_AddHeroNumRet(param1:TPacket) : void
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
         EffectGenerateText(STRING_TAVERN.BuySuccessful);
         SLogicsCore.Character.BuyHeroSlot = _loc2_.readUnsignedInt();
         this.FProcessorWindowHeros.AddHeroNumOk();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      protected function ProcessorOnDismiss(param1:Object, param2:THero) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjaHostel_HeroStatus_Req);
         _loc4_ = _loc3_.Data;
         this.FHeroID = param2.Identifier;
         _loc4_.writeUnsignedInt(param2.Identifier);
         _loc4_.writeUnsignedInt(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ProcessorAKeySwapOnClick(param1:Object) : void
      {
         this.FProcessorWindowOneKeySwap.Visible = true;
         this.FProcessorWindowOneKeySwap.Update();
      }
      
      protected function ProcessorInheritOnClick(param1:Object) : void
      {
         this.FProcessorWindowExpInherit.Visible = true;
         this.FProcessorWindowExpInherit.openMe();
      }
      
      protected function ProcessorOnEquipTitle(param1:Object, param2:uint) : void
      {
         this.PerformPacket_CS_EquipTitle_Req(param2);
      }
      
      protected function PerformPacket_CS_EquipTitle_Req(param1:uint) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Title_EquipTitle_Req);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnOpenTitleManage(param1:Object) : void
      {
         this.FProcessorWindowTitle.Visible = true;
         this.FProcessorWindowTitle.UpdateAllTitles();
         this.FProcessorWindowTitle.Update();
      }
      
      protected function PerformPacket_CS_LoadTitleList_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Title_LoadTitleList_Req);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorHerosBaseAttributeReq() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:THero = null;
         var _loc4_:THeros = null;
         _loc4_ = this.FCharacter.Heros;
         _loc2_ = _loc4_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc4_.GetHeroByIndex(_loc1_);
            this.ProcessorHeroBaseAttributeReq(_loc3_.Identifier);
            _loc1_++;
         }
      }
      
      protected function ProcessorHeroBaseAttributeReq(param1:uint) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Account_CharBaseAttributeReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Heros_Pvp);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorAllHeroEquipmentMountedSuitCount() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:THero = null;
         var _loc6_:THeros = null;
         var _loc7_:TCollectionInventory = null;
         var _loc8_:TEquipment = null;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:int = 0;
         var _loc11_:uint = 0;
         var _loc12_:Object = null;
         _loc9_ = new Vector.<uint>();
         _loc6_ = this.FCharacter.Heros;
         _loc2_ = _loc6_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = _loc6_.GetHeroByIndex(_loc1_);
            _loc7_ = _loc5_.EquipmentsMounted;
            _loc4_ = _loc7_.Capacity;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc8_ = _loc7_.GetInventoryByIndex(_loc3_) as TEquipment;
               if(_loc8_ != null)
               {
                  _loc12_ = _loc5_.GetSuitCountByEpicEquipment(_loc8_);
                  _loc5_.SetSuitObject(_loc8_,_loc12_);
                  _loc10_ = _loc9_.indexOf(_loc8_.SuitID);
                  if(_loc10_ < 0)
                  {
                     _loc9_.push(_loc8_.SuitID);
                     _loc11_ = _loc5_.GetSuitCountByEquipment(_loc8_);
                     _loc5_.SetSuitCount(_loc8_,_loc11_);
                  }
               }
               _loc3_++;
            }
            _loc7_ = _loc5_.AccessoryMounted;
            _loc4_ = _loc7_.Capacity;
            _loc9_.length = 0;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc8_ = _loc7_.GetInventoryByIndex(_loc3_) as TEquipment;
               if(_loc8_ != null)
               {
                  _loc12_ = _loc5_.GetSuitCountByEpicEquipment(_loc8_);
                  _loc5_.SetSuitObject(_loc8_,_loc12_);
                  _loc12_ = _loc5_.GetEightsuitCountByEpicAccessory(_loc8_);
                  _loc8_.EightSuitObject = _loc12_;
                  _loc10_ = _loc9_.indexOf(_loc8_.SuitID);
                  _loc9_.push(_loc8_.SuitID);
                  _loc11_ = _loc5_.GetSuitCountByEquipment(_loc8_);
                  _loc5_.SetSuitCount(_loc8_,_loc11_);
               }
               _loc3_++;
            }
            _loc9_.length = 0;
            _loc1_++;
         }
      }
      
      protected function ProcessorHeroEquipmentMountedSuitCount(param1:THero, param2:TInventory, param3:uint) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:TEquipment = null;
         var _loc6_:TCollectionInventory = null;
         var _loc7_:Object = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:TEquipment = null;
         _loc5_ = param2 as TEquipment;
         if(param2.Category == CATEGORY_Equipment)
         {
            _loc6_ = param1.EquipmentsMounted;
            _loc8_ = _loc6_.Capacity;
         }
         else
         {
            _loc6_ = param1.AccessoryMounted;
            _loc8_ = _loc6_.Capacity;
         }
         _loc9_ = 0;
         while(_loc9_ < _loc8_)
         {
            _loc10_ = _loc6_.GetInventoryByIndex(_loc9_) as TEquipment;
            if(_loc10_ != null)
            {
               _loc7_ = param1.GetSuitCountByEpicEquipment(_loc10_);
               param1.SetSuitObject(_loc10_,_loc7_);
               _loc7_ = param1.GetEightsuitCountByEpicAccessory(_loc10_);
               _loc10_.EightSuitObject = _loc7_;
            }
            _loc9_++;
         }
         _loc4_ = param1.GetSuitCountByEquipment(_loc5_);
         param1.SetSuitCount(_loc5_,_loc4_);
         switch(param3)
         {
            case TYPE_MOUNT:
               break;
            case TYPE_DISMOUNT:
               _loc5_.SuitCount = 0;
         }
      }
      
      protected function ProcessorBaseAttributesCache(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:THero = null;
         if(this.FIsProcessorBaseAttributesEffect)
         {
            return;
         }
         _loc4_ = this.FCharacter.Heros.GetHeroByIdentifier(param1);
         _loc3_ = int(CAPACITY_BASEATTRIBUTESCACHE);
         this.FBaseAttributesCache[0] = _loc4_.BaseAttributeSpeed;
         this.FBaseAttributesCache[1] = _loc4_.BaseAttributeLife;
         this.FBaseAttributesCache[2] = _loc4_.BaseAttributePhysicalAttack;
         this.FBaseAttributesCache[3] = _loc4_.BaseAttributeMagicAttack;
         this.FBaseAttributesCache[4] = _loc4_.BaseAttributePhysicalDefends;
         this.FBaseAttributesCache[5] = _loc4_.BaseAttributeMagicDefends;
         this.FIsProcessorBaseAttributesEffect = true;
      }
      
      protected function ProcessorBaseAttributesCompare() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:THero = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc3_ = this.FCharacter.Heros.GetHeroByIdentifier(this.FHeroID);
         if(_loc3_ == null)
         {
            return;
         }
         this.FNewBaseAttributesCache[0] = _loc3_.BaseAttributeSpeed;
         this.FNewBaseAttributesCache[1] = _loc3_.BaseAttributeLife;
         this.FNewBaseAttributesCache[2] = _loc3_.BaseAttributePhysicalAttack;
         this.FNewBaseAttributesCache[3] = _loc3_.BaseAttributeMagicAttack;
         this.FNewBaseAttributesCache[4] = _loc3_.BaseAttributePhysicalDefends;
         this.FNewBaseAttributesCache[5] = _loc3_.BaseAttributeMagicDefends;
         _loc2_ = int(CAPACITY_BASEATTRIBUTESCACHE);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FBaseAttributesCache[_loc1_];
            _loc5_ = this.FNewBaseAttributesCache[_loc1_];
            this.FBaseAttributesCache[_loc1_] = _loc5_ - _loc4_;
            _loc1_++;
         }
         this.ProcessorBaseAttributesEffect();
         this.FIsProcessorBaseAttributesEffect = false;
         this.FHeroID = 0;
      }
      
      protected function ProcessorBaseAttributesEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:TextFormat = null;
         _loc4_ = "";
         this.FEffectTextParameters.Clear();
         _loc2_ = int(CAPACITY_BASEATTRIBUTESCACHE);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = "";
            _loc10_ = new TextFormat();
            _loc5_ = this.FBaseAttributesCache[_loc1_];
            _loc6_ = int(BASEATTRIBUTEINDEX[_loc1_]);
            _loc7_ = STRINGS_BASEATTRIBUTENAMES[_loc6_];
            if(_loc5_ > 0)
            {
               _loc3_ = TUtilityString.Format(FORMAT_ADDITIONBASEATTRIBUTE,_loc7_,_loc5_);
               _loc10_.color = COLOR_ADDITIONBASEATTRIBUTE;
            }
            else if(_loc5_ < 0)
            {
               _loc5_ *= -1;
               _loc3_ = TUtilityString.Format(FORMAT_REDUCINGBASEATTRIBUTE,_loc7_,_loc5_);
               _loc10_.color = COLOR_REDUCINGBASEATTRIBUTE;
            }
            if(_loc5_ != 0)
            {
               this.FEffectTextParameters.EffectTextFormats.push(_loc10_);
            }
            this.FBaseAttributesCache[_loc1_] = 0;
            this.FNewBaseAttributesCache[_loc1_] = 0;
            _loc4_ += _loc3_;
            if(!TUtilityString.Empty(_loc3_))
            {
               if(_loc1_ < _loc2_ - 1)
               {
                  _loc4_ += "\n";
               }
            }
            _loc1_++;
         }
         _loc9_ = 0;
         _loc2_ = _loc4_.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc4_.charCodeAt(_loc1_) >= 48 && _loc4_.charCodeAt(_loc1_) <= 57)
            {
               if(!_loc8_)
               {
                  this.FEffectTextParameters.FormatsBeginIndex[_loc9_] = _loc1_;
                  _loc8_ = true;
               }
               if(_loc8_)
               {
                  this.FEffectTextParameters.FormatsEndIndex[_loc9_] = _loc1_ + 1;
               }
            }
            else if(_loc8_)
            {
               _loc9_++;
               _loc8_ = false;
            }
            _loc1_++;
         }
         if(!TUtilityString.Empty(_loc4_))
         {
            EffectGenerateText(_loc4_,this.FEffectTextParameters,null,CAPACITY_ParallelOutputRows);
            _loc4_ = "";
         }
      }
      
      public function ProcessorUseInventory() : void
      {
         if(this.FUseInventory != null)
         {
            switch(this.FUseInventory.CategorySecond)
            {
               case CATEGORY_Equipment:
                  this.FProcessorWindowHeros.UpdateTabInventory(0);
                  break;
               default:
                  this.FProcessorWindowHeros.UpdateTabInventory(1);
            }
         }
         this.FUseInventory = null;
      }
      
      override protected function PopTipsNotifyCheck() : void
      {
         if(FOnCheckPopTipsModes != null)
         {
            FOnCheckPopTipsModes(this,CONST_POPTIPS.POPTIP_Goto_Heros);
         }
      }
      
      protected function ProcessorWindowHerosOnClose(param1:Object) : void
      {
         ProcessorClose();
         TutorialNextStep(502);
      }
      
      protected function UIComponentsOverlayerOnOver(param1:Object, param2:Object, param3:Object, param4:int = 1) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TInventory = null;
         var _loc7_:TOverlayer = null;
         var _loc8_:TOverlayer = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = param3 as TInventory;
         switch(_loc5_.Category)
         {
            case CATEGORY_Equipment:
               if(_loc5_.CategorySecond == 7)
               {
                  _loc7_ = FOverlayerRing;
               }
               else
               {
                  _loc7_ = FOverlayerEquipment;
               }
               _loc8_ = this.FOverlayerEquipmentMounted;
               break;
            case CATEGORY_Accessories:
               FOverlayerAccessory.IsMeOrOthers = param4;
               _loc7_ = FOverlayerAccessory;
               _loc8_ = this.FOverlayerAccessoryMounted;
               break;
            default:
               _loc7_ = FOverlayerAppliance;
         }
         if(_loc7_ != null)
         {
            _loc7_.Context = _loc5_;
            if(_loc6_ == null)
            {
               _loc7_.Render(FUICore.MouseCoordinate);
            }
            else
            {
               _loc7_.Render(FUICore.MouseCoordinate);
               _loc7_.CoordinateOverlay.X -= _loc7_.BoundsSubstrate.Width + 20;
            }
            _loc7_.Show();
         }
         if(_loc6_ == null)
         {
            return;
         }
         if(_loc8_ != null)
         {
            this.FOverlayerAccessoryMounted.IsMeOrOthers = 1;
            _loc8_.Context = _loc6_;
            switch(_loc6_.Category)
            {
               case CATEGORY_Equipment:
                  (_loc8_ as TOverlayerEquipment).EquipedName = STRING_HEROS.STRING_AlreadyEquipment;
                  break;
               case CATEGORY_Accessories:
                  (_loc8_ as TOverlayerAccessory).EquipedName = STRING_HEROS.STRING_AlreadyEquipment;
                  (_loc8_ as TOverlayerAccessory).AccessoryMounted = this.FProcessorWindowHeros.FOverlayerAccessory.AccessoryMounted;
                  break;
               default:
                  (_loc8_ as TOverlayerEquipment).EquipedName = STRING_HEROS.STRING_AlreadyEquipment;
            }
            _loc8_.Render(_loc7_.CoordinateOverlay);
            _loc8_.CoordinateOverlay.X = _loc7_.CoordinateOverlay.X - _loc8_.BoundsSubstrate.Width;
            _loc8_.Show();
         }
      }
      
      protected function UIComponentsOverlayerOnOut(param1:Object, param2:TInventory, param3:Object, param4:int = 1) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TInventory = null;
         var _loc7_:TOverlayer = null;
         var _loc8_:TOverlayer = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = param3 as TInventory;
         switch(_loc5_.Category)
         {
            case CATEGORY_Equipment:
               if(_loc5_.CategorySecond == 7)
               {
                  _loc7_ = FOverlayerRing;
               }
               else
               {
                  _loc7_ = FOverlayerEquipment;
               }
               _loc8_ = this.FOverlayerEquipmentMounted;
               break;
            case CATEGORY_Accessories:
               _loc7_ = FOverlayerAccessory;
               _loc8_ = this.FOverlayerAccessoryMounted;
               break;
            default:
               _loc7_ = FOverlayerAppliance;
         }
         if(_loc7_ != null)
         {
            _loc7_.Hide();
         }
         if(_loc6_ == null)
         {
            return;
         }
         if(_loc8_ != null)
         {
            _loc8_.Hide();
         }
      }
      
      protected function UIComponentsHintOnOver1(param1:Object, param2:THint, param3:int = 7) : void
      {
         FOverlayerHint.WhatColor = 7;
         switch(param3)
         {
            case 1:
               FOverlayerHint.WhatColor = (param1 as TProcessorWindowHeros).IsColor;
               break;
            case 2:
               FOverlayerHint.WhatColor = (param1 as TProcessorWindowHeros).IsColorMagic;
         }
         FOverlayerHint.Context = param2;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.Show();
      }
      
      protected function UIComponentsHintOnOut1(param1:Object) : void
      {
         FOverlayerHint.Hide();
      }
      
      protected function UIComponentsHintBaseAttributeOnOver(param1:Object) : void
      {
         var _loc2_:THero = null;
         _loc2_ = param1 as THero;
         this.FOverlayerBaseAttribute.Context = _loc2_;
         this.FOverlayerBaseAttribute.Render(FUICore.MouseCoordinate);
         this.FOverlayerBaseAttribute.Show();
      }
      
      protected function UIComponentsHintBaseAttributeOnOut(param1:Object) : void
      {
         this.FOverlayerBaseAttribute.Hide();
      }
      
      protected function ProcessorOnShortcutHyperlinks(param1:Object, param2:uint, param3:uint, param4:int = 0, param5:Object = null) : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(param1,param2,param3,param4,param5);
         }
      }
      
      protected function Perform_CS_MountEquipment(param1:Object, param2:uint, param3:uint, param4:uint) : void
      {
         var _loc5_:TPacket = null;
         var _loc6_:ByteArray = null;
         _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Heros_Mount);
         _loc6_ = _loc5_.Data;
         _loc6_.writeUnsignedInt(param2);
         _loc6_.writeUnsignedInt(param3);
         _loc6_.writeUnsignedInt(param4);
         this.ProcessorBaseAttributesCache(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc5_);
      }
      
      protected function Perform_CS_DismountEquipment(param1:Object, param2:uint, param3:uint, param4:uint, param5:TCollectionInventory = null, param6:uint = 0) : void
      {
         var _loc7_:int = 0;
         var _loc8_:TPacket = null;
         var _loc9_:ByteArray = null;
         var _loc10_:TInventory = null;
         var _loc11_:uint = 0;
         _loc8_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Heros_Dismount);
         _loc9_ = _loc8_.Data;
         if(!param1)
         {
            _loc9_.writeUnsignedInt(param2);
            _loc9_.writeByte(param6);
            _loc9_.writeShort(0);
            SNetworkCore.Transceiver.PacketTransmit(_loc8_);
            this.ProcessorBaseAttributesCache(param2);
            return;
         }
         _loc9_.writeUnsignedInt(param2);
         _loc9_.writeByte(param6);
         _loc9_.writeShort(param3);
         if(param5)
         {
            _loc11_ = uint(param5.Capacity);
         }
         else
         {
            _loc11_ = param3;
         }
         if(param4 == 0)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc11_)
            {
               _loc10_ = param5.GetInventoryByIndex(_loc7_);
               if(_loc10_ != null)
               {
                  _loc9_.writeByte(_loc10_.CategorySecond);
               }
               _loc7_++;
            }
         }
         else
         {
            _loc9_.writeByte(param4);
         }
         this.ProcessorBaseAttributesCache(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc8_);
      }
      
      protected function ProcessorOnChangeSkillReq(param1:Object, param2:Object) : void
      {
         if(this.FOnChangeSkillReq != null)
         {
            this.FOnChangeSkillReq(param1,param2);
         }
      }
      
      protected function ProcessorOnUseInventory(param1:Object, param2:uint) : void
      {
         if(this.FOnUseInventory != null)
         {
            this.FOnUseInventory(param1,param2);
         }
      }
      
      protected function ProcessorOnWindowExchangeClose(param1:Object) : void
      {
         this.FProcessorWindowOneKeySwap.Visible = false;
         this.FIsOneKeySwap = false;
      }
      
      protected function ProcessorOnWindowInheritClose(param1:Object) : void
      {
         this.FProcessorWindowExpInherit.Visible = false;
      }
      
      protected function PerformPacket_SC_Heros_Inherit(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:THero = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         var _loc5_:int = int(_loc2_.readUnsignedInt());
         var _loc6_:int = int(_loc2_.readUnsignedInt());
         var _loc7_:int = int(_loc2_.readUnsignedInt());
         SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc6_).Level = _loc2_.readUnsignedInt();
         SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc6_).Experience.High = _loc2_.readUnsignedInt();
         SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc6_).Experience.Low = _loc2_.readUnsignedInt();
         SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc7_).Level = _loc2_.readUnsignedInt();
         SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc7_).Experience.High = _loc2_.readUnsignedInt();
         SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc7_).Experience.Low = _loc2_.readUnsignedInt();
         SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc7_).ExpIsInherited = 1;
         SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc6_).ExpIsInherited = 1;
         this.FProcessorWindowExpInherit.S_C_Reflash();
      }
      
      protected function ProcessorOnInherit(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Heros_Inherit);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(param1);
         _loc5_.writeUnsignedInt(param2);
         _loc5_.writeUnsignedInt(param3);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function ProcessorOnExchange(param1:Object, param2:Object, param3:Object) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         if(param2 == null || param3 == null)
         {
            return;
         }
         this.FIsOneKeySwap = true;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Heros_OneKeySwap);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt((param2 as THero).Identifier);
         _loc5_.writeUnsignedInt((param3 as THero).Identifier);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function ProdessorOnEffectText(param1:Object, param2:String, param3:TEffectTextParameters = null, param4:TEffectCoordinateParameters = null) : void
      {
         if(FOnEffectText != null)
         {
            FOnEffectText(this,param2);
         }
      }
      
      protected function BFOnMove(param1:THero) : void
      {
         this.FFBOverTip.Context = param1;
         this.FFBOverTip.Render(FUICore.MouseCoordinate);
         this.FFBOverTip.Show();
      }
      
      protected function BFOnOut() : void
      {
         this.FFBOverTip.Hide();
      }
      
      protected function UITitleHintOnOver(param1:Object, param2:uint) : void
      {
         var _loc3_:TTitle = null;
         _loc3_ = this.FTitles.GetTitleByIdentifier(param2);
         if(_loc3_ != null)
         {
            this.FOverlayerTitle.Context = _loc3_;
            this.FOverlayerTitle.Render(FUICore.MouseCoordinate);
            this.FOverlayerTitle.Show();
         }
      }
      
      protected function GoAccessory() : void
      {
         if(this.FGoAccessoryPanel != null)
         {
            this.FGoAccessoryPanel();
         }
      }
      
      protected function UITitleHintOnOut(param1:Object) : void
      {
         this.FOverlayerTitle.Hide();
      }
      
      protected function ProcessorGotoSoulFormation() : void
      {
         if(this.GoSoulFormation != null)
         {
            this.GoSoulFormation(this);
         }
      }
      
      protected function ProcessorGotoWing() : void
      {
         if(this.GoWing != null)
         {
            this.GoWing(this);
         }
      }
      
      protected function ProcessorGotoJade() : void
      {
         if(this.OpenJadeFun != null)
         {
            this.OpenJadeFun();
         }
      }
      
      public function get OnShortcutHyperlinks() : Function
      {
         return this.FOnShortcutHyperlinks;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function get OnUpdateTalismanMount() : Function
      {
         return this.FOnUpdateTalismanMount;
      }
      
      public function set OnUpdateTalismanMount(param1:Function) : void
      {
         this.FOnUpdateTalismanMount = param1;
      }
      
      public function get OnChangeSkillReq() : Function
      {
         return this.FOnChangeSkillReq;
      }
      
      public function set OnChangeSkillReq(param1:Function) : void
      {
         this.FOnChangeSkillReq = param1;
      }
      
      public function get OnUpdateBaseAttributeRet() : Function
      {
         return this.FOnUpdateBaseAttributeRet;
      }
      
      public function set OnUpdateBaseAttributeRet(param1:Function) : void
      {
         this.FOnUpdateBaseAttributeRet = param1;
      }
      
      public function get OnUseInventory() : Function
      {
         return this.FOnUseInventory;
      }
      
      public function set OnUseInventory(param1:Function) : void
      {
         this.FOnUseInventory = param1;
      }
      
      public function get ProcessorWindowHeros() : TProcessorWindowHeros
      {
         return this.FProcessorWindowHeros;
      }
      
      public function get OnDismissHero() : Function
      {
         return this.FOnDismissHero;
      }
      
      public function set OnDismissHero(param1:Function) : void
      {
         this.FOnDismissHero = param1;
      }
      
      public function get OnUserUpdateBaseInfo() : Function
      {
         return this.FOnUserUpdateBaseInfo;
      }
      
      public function set OnUserUpdateBaseInfo(param1:Function) : void
      {
         this.FOnUserUpdateBaseInfo = param1;
      }
      
      public function get OnUserTotalFightingPowerReq() : Function
      {
         return this.FOnUserTotalFightingPowerReq;
      }
      
      public function set OnUserTotalFightingPowerReq(param1:Function) : void
      {
         this.FOnUserTotalFightingPowerReq = param1;
      }
      
      public function set GoAccessoryPanel(param1:Function) : void
      {
         this.FGoAccessoryPanel = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(param1 != null)
         {
            this.FTabIndex = param1.readUnsignedInt();
         }
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowHeros.Load();
            this.FProcessorWindowOneKeySwap.Load();
            this.FProcessorWindowExpInherit.Load();
            this.FProcessorWindowTitle.Load();
            return;
         }
         this.ProcessorHerosBaseAttributeReq();
         this.ProcessorAllHeroEquipmentMountedSuitCount();
         this.FProcessorWindowHeros.SetZearo();
         this.FProcessorWindowHeros.Update(this.FTabIndex);
         this.ProcessorUseInventory();
         this.FProcessorWindowHeros.Visible = true;
         this.FProcessorWindowHeros.CheckCanExpand();
         TutorialNextStep(500);
         this.FProcessorWindowHeros.sendBaoTip();
         this.FProcessorWindowHeros.SetVisibelByValue(false);
         this.FProcessorWindowHeros.FOverlayerAccessory = FOverlayerAccessory;
      }
      
      override public function Unmount() : void
      {
         this.FTabIndex = 0;
         this.FProcessorWindowHeros.Reset();
         super.Unmount();
      }
      
      public function UpdateAllHeroEquipmentMountedSuitCount() : void
      {
         this.ProcessorAllHeroEquipmentMountedSuitCount();
      }
      
      public function UpdateCharacterBaseAttribute() : void
      {
         if(!Visible)
         {
            return;
         }
         if(!this.FIsOneKeySwap)
         {
            this.ProcessorBaseAttributesCompare();
         }
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowHeros.UpdateCharacterBaseAttributes();
         }
         if(this.FOnUpdateBaseAttributeRet != null)
         {
            this.FOnUpdateBaseAttributeRet(this);
         }
      }
      
      public function UpdateMainHeroSkill() : void
      {
         if(!Visible)
         {
            return;
         }
         this.FProcessorWindowHeros.UpdateMainHeroSkill();
      }
      
      public function ProcessorOnMountTalisman(param1:Object, param2:uint, param3:uint, param4:uint) : void
      {
         this.Perform_CS_MountEquipment(param1,param2,param3,param4);
      }
      
      public function ProcessorOnDismountTalisman(param1:Object, param2:uint, param3:uint, param4:uint) : void
      {
         this.Perform_CS_DismountEquipment(param1,param2,param3,param4);
      }
      
      public function UseInventory(param1:Object) : void
      {
         if(param1 is TEquipment)
         {
            this.FUseInventory = param1 as TEquipment;
         }
         else if(param1 is TAppliance)
         {
            this.FUseInventory = param1 as TAppliance;
         }
      }
      
      public function UpdateHeroBaseAttributeReq(param1:uint) : void
      {
         this.ProcessorHeroBaseAttributeReq(param1);
      }
      
      public function UpdateHerosBaseAttributeReq() : void
      {
         this.ProcessorHerosBaseAttributeReq();
      }
      
      public function UserUpdateCharBaseInfo() : void
      {
         if(this.FProcessorWindowHeros.Visible)
         {
            this.FProcessorWindowHeros.UpdateCharacterBaseInfo();
         }
      }
      
      public function UpdateCharacterInventory() : void
      {
         if(this.FProcessorWindowHeros.Visible)
         {
            this.FProcessorWindowHeros.UpdateCharacterInventory();
         }
      }
      
      public function UpdateTitle(param1:uint = 0) : void
      {
         this.ProcessorHeroBaseAttributeReq(this.FCharacter.GetMainHero().Identifier);
         this.FProcessorWindowHeros.UpdateTitle(param1);
         if(this.FProcessorWindowTitle.Visible)
         {
            this.FProcessorWindowTitle.Update();
         }
         this.FCharacter.TitleId = param1;
      }
      
      public function UpdateLittlePet(param1:uint = 0) : void
      {
         this.ProcessorHeroBaseAttributeReq(this.FCharacter.GetMainHero().Identifier);
         this.FProcessorWindowHeros.UpdateLittlePet(param1);
         this.FCharacter.LittlePetId = param1;
      }
      
      public function UpdateMagic() : void
      {
         this.ProcessorHerosBaseAttributeReq();
      }
      
      public function ResetHeros(param1:Object) : void
      {
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowHeros.SetBtnLock(true);
            this.FProcessorWindowHeros.Update();
         }
         if(this.FOnDismissHero != null)
         {
            this.FOnDismissHero(this,this.FHeroID);
         }
      }
   }
}

