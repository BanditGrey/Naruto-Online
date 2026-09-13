package Processors.Game.Lobby.Backpack
{
   import Debugging.*;
   import Externals.SExternalCore;
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Logics.Streamization.Characters.*;
   import Logics.Streamization.Inventories.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Processors.Game.Utilities.Inventories.*;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.*;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Inventories.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.*;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.utils.*;
   
   public class TProcessorBackpack extends TProcessorLobbyWindows
   {
      
      public static const SIZE_WindowUserAssets_Width:uint = 608;
      
      public static const SIZE_WindowUserAssets_Height:uint = 555;
      
      public static const STAGE_Width:Number = CONST_COMMON.STAGE_Width;
      
      public static const STAGE_Height:Number = CONST_COMMON.STAGE_Height;
      
      public static const TYPE_BACKPACK:uint = 0;
      
      public static const TYPE_TEMP_BACKPACK:uint = 1;
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const CATEGORY_Medals:uint = CONST_INVENTORY.CATEGORY_Medals;
      
      protected static const EffectMulti_DelayTicks:int = 2000;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerCharacter:TUnstreamizerCharacter;
      
      protected var FUnstreamizerInventories:TUnstreamizerInventories;
      
      protected var FUtilityInventory:TUtilityInventory;
      
      protected var FOverlayerSuperTreasureCopy:TOverlayerSuperTreasure;
      
      protected var FProcessorUserAssets:TProcessorWindowUserAssets;
      
      protected var FProcessorWindowSell:TProcessorWindowSell;
      
      protected var FBoundsBackpack:TBounds;
      
      protected var FCharacter:TCharacter;
      
      protected var FEffectTexts:Vector.<String>;
      
      protected var FInit:Boolean;
      
      protected var FStringID:uint;
      
      protected var FSystemLanguage:TSystemLanguage;
      
      protected var FEffDelayReferenceTick:int;
      
      protected var FIsEndPushText:Boolean;
      
      protected var FInventory:TInventory;
      
      protected var FQuantity:uint;
      
      protected var FExperience:uint;
      
      protected var FCoin:Number = 0;
      
      protected var FUIWindowConfirmationSell:TUIWindowConfirmation;
      
      protected var FInventories:TInventories;
      
      protected var FOnShortcutHyperlinks:Function;
      
      protected var FOnUpdateInventories:Function;
      
      protected var FOnInventoryReveal:Function;
      
      protected var FAddPopTips:Function;
      
      protected var FEndBattle:Function;
      
      public function TProcessorBackpack(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerCharacter = new TUnstreamizerCharacter();
         this.FUnstreamizerInventories = new TUnstreamizerInventories();
         this.FUtilityInventory = new TUtilityInventory();
         this.FProcessorUserAssets = new TProcessorWindowUserAssets(this);
         this.FProcessorUserAssets.OnInventoryOver = UIComponentsHintOnOver;
         this.FProcessorUserAssets.OnInventoryOut = UIComponentsHintOnOut;
         this.FProcessorUserAssets.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorUserAssets.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorUserAssets.OnClose = this.ProcessorUserAssetsOnClose;
         this.FProcessorUserAssets.OnButtonSell = this.ProcessorButtonSellOnClick;
         this.FProcessorUserAssets.OnSellInventoryToList = this.ProcessorAddInventoryToSellList;
         this.FProcessorUserAssets.OnSellInventory = this.ProcessorSellOnClick;
         this.FProcessorUserAssets.OnShortcutHyperlinks = this.ProcessorOnShortcutHyperlinks;
         this.FProcessorUserAssets.OnEffectText = ProcessorsOnEffectText;
         this.FProcessorUserAssets.OnInventoryReveal = this.ProcessorsOnInventoryReveal;
         this.FProcessorUserAssets.OnUseInventory = this.ProcessorUseInventory;
         this.FBoundsBackpack = new TBounds();
         this.FBoundsBackpack.X = this.FProcessorUserAssets.x;
         this.FBoundsBackpack.Y = this.FProcessorUserAssets.y;
         this.FBoundsBackpack.Width = SIZE_WindowUserAssets_Width;
         this.FBoundsBackpack.Height = SIZE_WindowUserAssets_Height;
         ComponentBoundsCenter(this.FProcessorUserAssets,this.FBoundsBackpack);
         this.FProcessorUserAssets.X -= 100;
         this.FProcessorWindowSell = new TProcessorWindowSell(this);
         this.FProcessorWindowSell.OnInventoryOver = UIComponentsHintOnOver;
         this.FProcessorWindowSell.OnInventoryOut = UIComponentsHintOnOut;
         this.FProcessorWindowSell.OnClose = this.ProcessorCloseOnClick;
         this.FProcessorWindowSell.OnAllSell = this.ProcessorAllSellOnClick;
         this.FProcessorWindowSell.OnInventoryClick = this.ProcessorInventoryClick;
         this.FProcessorWindowSell.X = this.FProcessorUserAssets.X + 554;
         this.FProcessorWindowSell.Y = this.FProcessorUserAssets.Y + 2;
         this.FCharacter = SLogicsCore.Character;
         this.FEffectTexts = new Vector.<String>();
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_Backpack);
         FOverlayerEquipment.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_Backpack);
         FOverlayerAccessory.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_Backpack);
         FOverlayerTreasure.Visible = false;
         this.FOverlayerSuperTreasureCopy = new TOverlayerSuperTreasure(this,CONST_MODULES.MODULE_Backpack);
         this.FOverlayerSuperTreasureCopy.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_Backpack);
         FOverlayerAppliance.Visible = false;
         FOverSuperJade = new TOverSuperJade(this);
         FOverSuperJade.Visible = false;
         FOverlayerMedal = new TOverlayerMedal(this,CONST_MODULES.MODULE_Backpack);
         FOverlayerMedal.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         this.FIsEndPushText = false;
         this.FUIWindowConfirmationSell = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmationSell.OnOK = this.WindowConfirmationSellOnOK;
         this.FUIWindowConfirmationSell.x = (STAGE_Width - this.FUIWindowConfirmationSell.WindowWidth) / 2;
         this.FUIWindowConfirmationSell.y = (STAGE_Height - this.FUIWindowConfirmationSell.WindowHeight) / 2;
         SetUIModuleID(CONST_MODULES.MODULE_Backpack);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BACKPACK.RESOURCESID_Swf_Backpack);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIWait() : void
      {
         if(SResourcesCore.LoadingPrimary)
         {
            return;
         }
         super.ResourcesPerform_UIWait();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSuperTreasureCopy);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverSuperJade);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerMedal);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationSell);
         this.FUIWindowConfirmationSell.SetCheckBox(true);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Backpack_LoadBagResult,this.PerformPacket_SC_LoadBagResult);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Backpack_SendThings,this.PerformPacket_SC_SendThings);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Backpack_ReduceThings,this.PerformPacket_SC_ReduceThings);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Backpack_InventoryExpire,this.PerformPacket_SC_InventoryExpire);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Backpack_UseAppliance,this.PerformPacket_SC_UseAppliance);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Backpack_SellItem,this.PerformPacket_SC_SellItem);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Backpack_InventoryNtf,this.PerformPacket_SC_InventoryNtf);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Backpack_DepotToBag,this.PerformPacket_SC_DepotToBag);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Backpack_MergeBagItem_Ret,this.PerformPacket_SC_MergeBagItem);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Backpack_OnlineExtend_Ret,this.PACKETID_SC_Backpack_OnlineExtend_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Backpack_OnlineExtendInforMation_Ret,this.PACKETID_SC_Backpack_OnlineExtendInforMation_Ret);
      }
      
      protected function PerformPacket_SC_LoadBagResult(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc4_ = _loc2_.readUnsignedByte();
         if(_loc4_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc4_);
            return;
         }
         this.FCharacter.Equipments.Clear();
         this.FCharacter.Appliances.Clear();
         this.FCharacter.Gems.Clear();
         this.FCharacter.Treasures.Clear();
         this.FCharacter.Materials.Clear();
         this.FCharacter.Accessories.Clear();
         this.FCharacter.Medals.Clear();
         this.FCharacter.TemporaryInventories.Clear();
         this.FUnstreamizerCharacter.UnstreamizeInventories(_loc2_,this.FCharacter,null);
         this.FUnstreamizerCharacter.UnstreamizeClassificationInventories(_loc2_,this.FCharacter,null);
         this.FUnstreamizerCharacter.UnstreamizeTemporaryInventories(_loc2_,this.FCharacter,null);
      }
      
      protected function PerformPacket_SC_SendThings(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedByte();
         this.FProcessorUserAssets.SetBtnLock(true);
         _loc4_ = uint(this.FCharacter.Equipments.Count);
         if(_loc3_ == TYPE_TEMP_BACKPACK)
         {
            if(this.FAddPopTips != null)
            {
               this.FAddPopTips(this,CONST_POPTIPS.POPTIP_PacketFull);
            }
            this.FUnstreamizerCharacter.UnstreamizeTemporaryInventories(_loc2_,this.FCharacter,null);
         }
         else
         {
            this.FUnstreamizerInventories.Unstreamize(_loc2_,this.FCharacter.Inventories,null);
         }
         this.FUnstreamizerCharacter.UnstreamizeClassificationInventories(_loc2_,this.FCharacter,null);
         this.FProcessorUserAssets.UserUpdateInventories();
         if(this.FCharacter.Equipments.Count > _loc4_)
         {
            if(this.FAddPopTips != null)
            {
               this.FAddPopTips(this,CONST_POPTIPS.POPTIP_ObtainedForbearance);
            }
         }
         if(this.FProcessorUserAssets.GetBackpackMiddleCount() <= 10)
         {
            if(this.FAddPopTips != null)
            {
               this.FAddPopTips(this,CONST_POPTIPS.POPTIP_TBackBagCount);
            }
         }
      }
      
      protected function PerformPacket_SC_ReduceThings(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:TInventories = null;
         var _loc10_:TInventory = null;
         var _loc11_:ByteArray = null;
         var _loc12_:uint = 0;
         _loc11_ = param1.Data;
         _loc12_ = _loc11_.readUnsignedByte();
         this.FProcessorUserAssets.SetBtnLock(true);
         _loc3_ = int(_loc11_.readUnsignedShort());
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = _loc11_.readUnsignedInt();
            _loc7_ = _loc11_.readUnsignedInt();
            _loc5_ = int(CAPACITY_INVENTORIES);
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               if(_loc12_ == TYPE_BACKPACK && _loc4_ < _loc5_ - 1)
               {
                  _loc9_ = this.FCharacter.GetBackpackByIndex(_loc4_);
               }
               else
               {
                  _loc9_ = this.FCharacter.GetBackpackByIndex(_loc5_ - 1);
               }
               _loc10_ = _loc9_.GetInventoryByIdentifier(_loc6_,_loc7_);
               if(_loc10_ != null)
               {
                  _loc9_.DeleteInventoryByIdentifier(_loc6_,_loc7_);
                  break;
               }
               _loc4_++;
            }
            _loc2_++;
         }
         if(this.FOnUpdateInventories != null)
         {
            this.FOnUpdateInventories(this);
         }
         this.FProcessorUserAssets.UserUpdateInventories();
      }
      
      protected function PerformPacket_SC_InventoryExpire(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:TInventories = null;
         var _loc10_:TInventory = null;
         var _loc11_:ByteArray = null;
         _loc11_ = param1.Data;
         this.FProcessorUserAssets.SetBtnLock(true);
         _loc3_ = int(_loc11_.readUnsignedShort());
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = _loc11_.readUnsignedInt();
            _loc7_ = _loc11_.readUnsignedInt();
            _loc8_ = _loc11_.readUnsignedShort();
            _loc5_ = int(CAPACITY_INVENTORIES);
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc9_ = this.FCharacter.GetBackpackByIndex(_loc4_);
               _loc10_ = _loc9_.GetInventoryByIdentifier(_loc6_,_loc7_);
               if(_loc10_ != null)
               {
                  _loc9_.DeleteInventoryByIdentifier(_loc6_,_loc7_);
                  break;
               }
               _loc4_++;
            }
            _loc2_++;
         }
         this.FProcessorUserAssets.UserUpdateInventories();
      }
      
      protected function PerformPacket_SC_UseAppliance(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:TInventory = null;
         var _loc12_:TInventories = null;
         var _loc13_:TArticle = null;
         var _loc14_:TArticle = null;
         var _loc15_:uint = 0;
         var _loc16_:Vector.<uint> = null;
         _loc2_ = param1.Data;
         _loc8_ = "";
         _loc10_ = "";
         _loc9_ = "";
         _loc16_ = new Vector.<uint>();
         this.FProcessorUserAssets.SetBtnLock(true);
         _loc12_ = new TInventories();
         _loc5_ = _loc2_.readUnsignedInt();
         if(_loc5_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc5_);
            return;
         }
         _loc15_ = _loc2_.readUnsignedInt();
         _loc7_ = uint(_loc2_.readShort());
         _loc12_.Clear();
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc11_ = new TInventory(0,0);
            _loc11_.Type = _loc2_.readShort();
            _loc11_.IDTemplate = _loc2_.readUnsignedInt();
            _loc11_.Quantity = _loc2_.readUnsignedInt();
            _loc12_.Add(_loc11_);
            _loc6_++;
         }
         if(_loc7_ == 0)
         {
            _loc16_.push(_loc15_);
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc12_,_loc16_);
         }
         _loc13_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc15_) as TArticle;
         switch(_loc13_.MinorType)
         {
            case CONST_INVENTORY.CATEGORYSECOND_ChangeName:
               EffectGenerateText(new ConsumeFrameCopy(STRING_COMMON.CHANGE_USESUCCESS).DescribeString);
               setTimeout(this.ReloadGame,3000);
               break;
            case CONST_INVENTORY.CATEGORYSECOND_ChangeFamily:
               this.FCharacter.Country = parseInt(this.FProcessorUserAssets.ChangeStr);
               EffectGenerateText(new ConsumeFrameCopy(STRING_COMMON.CHANGE_USESUCCESS).DescribeString);
               setTimeout(this.ReloadGame,3000);
               break;
            case CONST_INVENTORY.CATEGORYSECOND_BagExtend:
               this.FStringID = CONST_SYSTEMLANGUAGE.BACKPACK_STRING_06;
               _loc8_ = this.GetEffectText(this.FStringID);
               EffectGenerateText(_loc8_);
               this.FProcessorUserAssets.UserUpdateBackpackCapacity();
               return;
            case CONST_INVENTORY.CATEGORYSECOND_ExperienceReel:
               this.PlayEffectTexts(_loc13_,STRING_COMMON.ITEMNAME_Exp);
               break;
            case CONST_INVENTORY.CATEGORYSECOND_MainHeroExperienceReel:
               this.PlayEffectTexts(_loc13_,STRING_COMMON.ITEMNAME_Exp);
               break;
            case CONST_INVENTORY.CATEGORYSECOND_SilverCard:
               this.PlayEffectTexts(_loc13_,STRING_COMMON.ITEMNAME_Coin);
               break;
            case CONST_INVENTORY.CATEGORYSECOND_BattleSkipCard:
               if(this.FEndBattle != null)
               {
                  this.FEndBattle(this);
               }
               break;
            case CONST_INVENTORY.CATEGORYSECOND_AddActionCount:
               _loc9_ = this.GetEffectText(CONST_SYSTEMLANGUAGE.BACKPACK_FORMAT_10);
               _loc10_ = TUtilityString.Format(_loc9_,_loc13_.FunctionValue * this.FQuantity);
               EffectGenerateText(_loc10_);
               break;
            case CONST_INVENTORY.CATEGORYSECOND_Treasure:
            case CONST_INVENTORY.CATEGORYSECOND_SpecialMaterial:
            case CONST_INVENTORY.CATEGORYSECOND_CommenMaterial:
            case CONST_INVENTORY.CATEGORYSECOND_GemTreasure:
            case CONST_INVENTORY.CATEGORYSECOND_FiveGhostTreasure:
               this.FStringID = CONST_SYSTEMLANGUAGE.BACKPACK_FORMAT_02;
               _loc8_ = this.GetEffectText(this.FStringID);
               _loc7_ = uint(_loc12_.Count);
               _loc6_ = 0;
               while(_loc6_ < _loc7_)
               {
                  _loc11_ = _loc12_.GetInventoryByIndex(_loc6_) as TInventory;
                  _loc9_ = STRING_COMMON.GetItemNameByType(_loc11_.Type,_loc11_.IDTemplate);
                  if(_loc9_ == "")
                  {
                     _loc14_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc11_.IDTemplate) as TArticle;
                     _loc10_ += TUtilityString.Format(_loc8_.split("\\n")[1],_loc14_.Name,_loc11_.Quantity);
                  }
                  else
                  {
                     _loc14_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc11_.IDTemplate) as TArticle;
                     if(_loc11_.IDTemplate >= 14820001 && _loc11_.IDTemplate <= 14820030 || _loc11_.IDTemplate == 14820051)
                     {
                        this.PlayEffectTexts(_loc14_,_loc9_);
                     }
                     else
                     {
                        _loc10_ += TUtilityString.Format(_loc8_.split("\\n")[1],_loc9_,_loc11_.Quantity);
                     }
                  }
                  _loc10_ += "\n";
                  this.FEffectTexts.push(_loc10_);
                  _loc10_ = "";
                  _loc6_++;
               }
               break;
            default:
               EffectGenerateText(STRING_COMMON.COMMON_BACKPACK_USESUCCESS);
         }
         this.FIsEndPushText = true;
      }
      
      protected function ReloadGame() : void
      {
         SExternalCore.ReloadGame();
      }
      
      protected function GetEffectText(param1:uint) : String
      {
         this.FSystemLanguage = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,param1) as TSystemLanguage;
         if(this.FSystemLanguage != null)
         {
            return this.FSystemLanguage.Desc;
         }
         return "";
      }
      
      protected function PlayEffectTexts(param1:TArticle, param2:String) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         this.FStringID = CONST_SYSTEMLANGUAGE.BACKPACK_FORMAT_02;
         _loc3_ = this.GetEffectText(this.FStringID);
         if(param1.MinorType == CONST_INVENTORY.CATEGORYSECOND_ExperienceReel || param1.MinorType == CONST_INVENTORY.CATEGORYSECOND_MainHeroExperienceReel)
         {
            _loc4_ = TUtilityString.Format(_loc3_.split("\\n")[1],param2,this.FExperience);
         }
         else
         {
            _loc4_ = TUtilityString.Format(_loc3_.split("\\n")[1],param2,param1.FunctionValue * this.FQuantity);
         }
         this.FEffectTexts.push(_loc4_);
      }
      
      protected function PerformPacket_SC_SellItem(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:TArticle = null;
         var _loc6_:String = null;
         _loc2_ = param1.Data;
         this.FProcessorUserAssets.SetBtnLock(true);
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ == 0)
         {
            this.FProcessorWindowSell.Reset();
            this.FProcessorUserAssets.Reset();
            _loc4_ = "";
            this.FStringID = CONST_SYSTEMLANGUAGE.BACKPACK_FORMAT_01;
            _loc6_ = this.GetEffectText(this.FStringID);
            _loc4_ = _loc6_.split("\\n")[0] + "\n";
            _loc4_ = _loc4_ + TUtilityString.Format(this.FSystemLanguage.Desc.split("\\n")[1],int(this.FCoin));
            EffectGenerateText(_loc4_);
            this.FCoin = 0;
         }
         else
         {
            EffectGenerateTextByErrorCode(_loc3_);
         }
         this.FProcessorWindowSell.SetSaleBtnStatus(true);
      }
      
      protected function PerformPacket_SC_InventoryNtf(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:ByteArray = null;
         var _loc6_:TInventory = null;
         var _loc7_:TInventories = null;
         _loc5_ = param1.Data;
         this.FProcessorUserAssets.SetBtnLock(true);
         _loc7_ = this.FCharacter.Inventories;
         this.FUnstreamizerInventories.Unstreamize(_loc5_,_loc7_,null);
         _loc3_ = _loc7_.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = _loc7_.GetInventoryByIndex(_loc2_);
            _loc4_ = this.ProcessorInventoryUpdateByBackpack(_loc6_);
            if(!_loc4_)
            {
               _loc4_ = this.ProcessorInventoryUpdateByEquipmentsMounted(_loc6_);
               if(!_loc4_)
               {
                  _loc4_ = this.ProcessorInventoryUpdateByTalismansMounted(_loc6_);
                  if(!_loc4_)
                  {
                     _loc4_ = this.ProcessorInventoryUpdateAccessorysMounted(_loc6_);
                     if(!_loc4_)
                     {
                        _loc4_ = this.ProcessorInventoryUpdateMedalsMounted(_loc6_);
                        if(_loc4_)
                        {
                        }
                     }
                  }
               }
            }
            _loc2_++;
         }
         _loc7_.Clear();
         if(_loc3_ == 0)
         {
            return;
         }
         if(this.FOnUpdateInventories != null)
         {
            this.FOnUpdateInventories(this);
         }
      }
      
      protected function PerformPacket_SC_DepotToBag(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         this.FProcessorUserAssets.SetBtnLock(true);
         _loc3_ = _loc2_.readUnsignedInt();
      }
      
      protected function PerformPacket_SC_MergeBagItem(param1:TPacket) : void
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
         EffectGenerateText(STRING_BACKPACK.STRING_MergeBagOk);
      }
      
      protected function PACKETID_SC_Backpack_OnlineExtend_Ret(param1:TPacket) : void
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
         EffectGenerateText(STRING_BACKPACK.STRING_ExtendOk);
         this.FProcessorUserAssets.BackOnlineExtend();
      }
      
      protected function PACKETID_SC_Backpack_OnlineExtendInforMation_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         this.FProcessorUserAssets.SetTimeAndBegin(_loc2_);
      }
      
      protected function ProcessorInventoryUpdateByBackpack(param1:TInventory) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:TInventory = null;
         var _loc4_:TInventories = null;
         var _loc5_:TEquipment = null;
         var _loc6_:TEquipment = null;
         var _loc7_:TAppliance = null;
         var _loc8_:TAppliance = null;
         var _loc9_:TInventory = null;
         var _loc10_:TInventory = null;
         _loc2_ = false;
         switch(param1.Category)
         {
            case CATEGORY_Normal:
               _loc4_ = this.FCharacter.Appliances;
               break;
            case CATEGORY_Equipment:
               _loc4_ = this.FCharacter.Equipments;
               break;
            case CATEGORY_Gem:
               _loc4_ = this.FCharacter.Gems;
               break;
            case CATEGORY_Treasure:
               _loc4_ = this.FCharacter.Treasures;
               break;
            case CATEGORY_Material:
               _loc4_ = this.FCharacter.Materials;
               break;
            case CATEGORY_Accessories:
               _loc4_ = this.FCharacter.Accessories;
               break;
            case CATEGORY_Medals:
               _loc4_ = this.FCharacter.Medals;
         }
         _loc3_ = _loc4_.GetInventoryByIdentifier(param1.Identifier0,param1.Identifier1);
         if(_loc3_ != null)
         {
            switch(param1.Category)
            {
               case CATEGORY_Equipment:
               case CATEGORY_Accessories:
               case CATEGORY_Treasure:
               case CATEGORY_Medals:
                  _loc5_ = param1 as TEquipment;
                  _loc6_ = _loc3_ as TEquipment;
                  this.FUtilityInventory.EquipmentAssign(_loc5_,_loc6_);
                  break;
               case CATEGORY_Normal:
               case CATEGORY_Material:
               case CATEGORY_Gem:
                  _loc7_ = param1 as TAppliance;
                  _loc8_ = _loc3_ as TAppliance;
                  this.FUtilityInventory.ApplianceAssign(_loc7_,_loc8_);
            }
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      protected function ProcessorInventoryUpdateByEquipmentsMounted(param1:TInventory) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:THero = null;
         var _loc5_:THeros = null;
         var _loc6_:Boolean = false;
         var _loc7_:TInventory = null;
         var _loc8_:TCollectionInventory = null;
         var _loc9_:TEquipment = null;
         var _loc10_:TEquipment = null;
         _loc6_ = false;
         _loc5_ = this.FCharacter.Heros;
         _loc3_ = _loc5_.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc5_.GetHeroByIndex(_loc2_);
            _loc8_ = _loc4_.EquipmentsMounted;
            _loc7_ = _loc8_.GetInventoryByIdentifier(param1.Identifier0,param1.Identifier1);
            if(_loc7_ != null)
            {
               _loc9_ = param1 as TEquipment;
               _loc10_ = _loc7_ as TEquipment;
               this.FUtilityInventory.EquipmentAssign(_loc9_,_loc10_);
               _loc6_ = true;
               break;
            }
            _loc2_++;
         }
         return _loc6_;
      }
      
      protected function ProcessorInventoryUpdateByTalismansMounted(param1:TInventory) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:THero = null;
         var _loc5_:THeros = null;
         var _loc6_:Boolean = false;
         var _loc7_:TInventory = null;
         var _loc8_:TCollectionInventory = null;
         var _loc9_:TEquipment = null;
         var _loc10_:TEquipment = null;
         _loc6_ = false;
         _loc5_ = this.FCharacter.Heros;
         _loc3_ = _loc5_.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc5_.GetHeroByIndex(_loc2_);
            _loc8_ = _loc4_.TalismansMounted;
            _loc7_ = _loc8_.GetInventoryByIdentifier(param1.Identifier0,param1.Identifier1);
            if(_loc7_ != null)
            {
               _loc9_ = param1 as TEquipment;
               _loc10_ = _loc7_ as TEquipment;
               this.FUtilityInventory.EquipmentAssign(_loc9_,_loc10_);
               _loc6_ = true;
               break;
            }
            _loc2_++;
         }
         return _loc6_;
      }
      
      protected function ProcessorInventoryUpdateAccessorysMounted(param1:TInventory) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:THero = null;
         var _loc5_:THeros = null;
         var _loc6_:Boolean = false;
         var _loc7_:TInventory = null;
         var _loc8_:TCollectionInventory = null;
         var _loc9_:TEquipment = null;
         var _loc10_:TEquipment = null;
         _loc6_ = false;
         _loc5_ = this.FCharacter.Heros;
         _loc3_ = _loc5_.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc5_.GetHeroByIndex(_loc2_);
            _loc8_ = _loc4_.AccessoryMounted;
            _loc7_ = _loc8_.GetInventoryByIdentifier(param1.Identifier0,param1.Identifier1);
            if(_loc7_ != null)
            {
               _loc9_ = param1 as TEquipment;
               _loc10_ = _loc7_ as TEquipment;
               this.FUtilityInventory.EquipmentAssign(_loc9_,_loc10_);
               _loc6_ = true;
               break;
            }
            _loc2_++;
         }
         return _loc6_;
      }
      
      protected function ProcessorInventoryUpdateMedalsMounted(param1:TInventory) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:THero = null;
         var _loc5_:THeros = null;
         var _loc6_:Boolean = false;
         var _loc7_:TInventory = null;
         var _loc8_:TCollectionInventory = null;
         var _loc9_:TEquipment = null;
         var _loc10_:TEquipment = null;
         _loc6_ = false;
         _loc5_ = this.FCharacter.Heros;
         _loc3_ = _loc5_.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc5_.GetHeroByIndex(_loc2_);
            _loc8_ = _loc4_.MedalsMounted;
            _loc7_ = _loc8_.GetInventoryByIdentifier(param1.Identifier0,param1.Identifier1);
            if(_loc7_ != null)
            {
               _loc9_ = param1 as TEquipment;
               _loc10_ = _loc7_ as TEquipment;
               this.FUtilityInventory.EquipmentAssign(_loc9_,_loc10_);
               _loc6_ = true;
               break;
            }
            _loc2_++;
         }
         return _loc6_;
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         this.FProcessorUserAssets.UpdateTime();
         this.LogicsPerform_EffectText();
      }
      
      protected function LogicsPerform_EffectText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         _loc6_ = "";
         _loc4_ = "";
         if(this.FIsEndPushText)
         {
            if(this.FEffectTexts.length == 0)
            {
               return;
            }
            this.FStringID = CONST_SYSTEMLANGUAGE.BACKPACK_FORMAT_02;
            _loc2_ = int(this.FEffectTexts.length);
            _loc3_ = 8;
            _loc5_ = STimingCore.TickCount - this.FEffDelayReferenceTick;
            if(_loc5_ < EffectMulti_DelayTicks)
            {
               return;
            }
            _loc7_ = this.GetEffectText(this.FStringID);
            _loc6_ = _loc7_.split("\\n")[0] + "\n";
            _loc1_ = 0;
            while(_loc1_ < _loc3_)
            {
               if(_loc2_ <= _loc1_)
               {
                  break;
               }
               _loc4_ += this.FEffectTexts.shift();
               _loc1_++;
            }
            _loc6_ += _loc4_;
            this.FEffDelayReferenceTick = STimingCore.TickCount;
            EffectGenerateText(_loc6_);
         }
      }
      
      protected function ProcessorAddInventoryToSellList(param1:TInventory, param2:TInventory) : Boolean
      {
         return this.FProcessorWindowSell.AddInventory(param1,param2);
      }
      
      protected function ProcessorOnShortcutHyperlinks(param1:Object, param2:uint, param3:uint, param4:int = 0, param5:Object = null) : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(param1,param2,param3,param4,param5);
         }
      }
      
      protected function ProcessorsOnInventoryReveal(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryReveal != null)
         {
            this.FOnInventoryReveal(param1,param2);
         }
      }
      
      protected function GenerateIventories() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<uint> = null;
         var _loc4_:TBins = null;
         if(!this.FInit)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
            _loc2_ = _loc4_.Count;
            _loc3_ = new Vector.<uint>(_loc2_);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_[_loc1_] = _loc4_.GetDatebaseByIndex(_loc1_).Identifier;
               _loc1_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FCharacter.Inventories,_loc3_);
            this.FUnstreamizerCharacter.UnstreamizeClassificationInventories(null,this.FCharacter,null);
            this.FInit = true;
         }
      }
      
      override protected function PopTipsNotifyCheck() : void
      {
         if(FOnCheckPopTipsModes != null)
         {
            FOnCheckPopTipsModes(this,CONST_POPTIPS.POPTIP_Goto_Backpack);
         }
      }
      
      protected function WindowConfirmationSellOnOK(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         var _loc5_:TPacket = null;
         var _loc6_:ByteArray = null;
         _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Backpack_SellItem);
         _loc6_ = _loc5_.Data;
         _loc3_ = this.FInventories.Count;
         _loc6_.writeShort(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FInventories.GetInventoryByIndex(_loc2_);
            if(_loc4_ is TEquipment)
            {
               this.FCoin += _loc4_.SellValue + _loc4_.SellingValue;
            }
            else
            {
               this.FCoin += _loc4_.Quantity * _loc4_.SellValue;
            }
            _loc6_.writeUnsignedInt(_loc4_.Identifier0);
            _loc6_.writeUnsignedInt(_loc4_.Identifier1);
            _loc6_.writeShort(_loc4_.Quantity);
            _loc2_++;
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc5_);
         this.FProcessorWindowSell.SetSaleBtnStatus(false);
      }
      
      protected function ProcessorUserAssetsOnClose(param1:Object) : void
      {
         ProcessorClose();
         this.FProcessorWindowSell.Reset();
      }
      
      protected function ProcessorButtonSellOnClick(param1:Object) : void
      {
         var _loc2_:Boolean = false;
         _loc2_ = !this.FProcessorWindowSell.Visible;
         this.FProcessorWindowSell.Visible = _loc2_;
         this.FProcessorUserAssets.HiddenCorners(!_loc2_);
         if(_loc2_)
         {
            this.FProcessorWindowSell.Reset();
         }
      }
      
      protected function ProcessorCloseOnClick(param1:Object) : void
      {
         var _loc2_:Boolean = false;
         _loc2_ = !this.FProcessorWindowSell.Visible;
         this.FProcessorWindowSell.Visible = _loc2_;
         this.FProcessorWindowSell.Reset();
         this.FProcessorUserAssets.ResetSellWindow();
         this.FProcessorUserAssets.HiddenCorners(!_loc2_);
      }
      
      protected function ProcessorSellOnClick(param1:Object, param2:TInventory, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         this.FInventory = param2;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Backpack_SellItem);
         if(param2 is TEquipment)
         {
            this.FCoin = param2.SellValue + param2.SellingValue;
         }
         else
         {
            this.FCoin = param3 * param2.SellValue;
         }
         _loc5_ = _loc4_.Data;
         _loc5_.writeShort(1);
         _loc5_.writeUnsignedInt(param2.Identifier0);
         _loc5_.writeUnsignedInt(param2.Identifier1);
         _loc5_.writeShort(param3);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function ProcessorAllSellOnClick(param1:Object, param2:TInventories) : void
      {
         this.FInventories = param2;
         if(this.FUIWindowConfirmationSell.IsSelected)
         {
            this.WindowConfirmationSellOnOK(null);
         }
         else if(this.CheckEquipAndJade())
         {
            this.FUIWindowConfirmationSell.Text = STRING_BACKPACK.STRING_Tips;
            this.FUIWindowConfirmationSell.Visible = true;
         }
         else
         {
            this.WindowConfirmationSellOnOK(null);
         }
      }
      
      protected function CheckEquipAndJade() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TInventory = null;
         _loc2_ = uint(this.FInventories.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FInventories.GetInventoryByIndex(_loc1_);
            if(_loc3_.Category == CATEGORY_Equipment || _loc3_.Category == CATEGORY_Gem || _loc3_.Category == CATEGORY_Treasure)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      protected function ProcessorInventoryClick(param1:Object, param2:TInventories) : void
      {
         this.FProcessorUserAssets.UpdateSelectBox(param2);
      }
      
      protected function ProcessorUseInventory(param1:Object, param2:TInventory, param3:uint, param4:String = "") : void
      {
         var _loc5_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Backpack_UseAppliance);
         var _loc6_:ByteArray = _loc5_.Data;
         var _loc7_:int = int(param3);
         this.FQuantity = _loc7_;
         _loc6_.writeShort(1);
         _loc6_.writeUnsignedInt(param2.IDTemplate);
         _loc6_.writeShort(_loc7_);
         _loc6_.writeUnsignedInt(0);
         TUtilityString.FlushUTF(_loc6_,param4);
         SNetworkCore.Transceiver.PacketTransmit(_loc5_);
      }
      
      public function get OnShortcutHyperlinks() : Function
      {
         return this.FOnShortcutHyperlinks;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function get OnUpdateInventories() : Function
      {
         return this.FOnUpdateInventories;
      }
      
      public function set OnUpdateInventories(param1:Function) : void
      {
         this.FOnUpdateInventories = param1;
      }
      
      public function get OnInventoryReveal() : Function
      {
         return this.FOnInventoryReveal;
      }
      
      public function set OnInventoryReveal(param1:Function) : void
      {
         this.FOnInventoryReveal = param1;
      }
      
      public function get AddPopTips() : Function
      {
         return this.FAddPopTips;
      }
      
      public function set AddPopTips(param1:Function) : void
      {
         this.FAddPopTips = param1;
      }
      
      public function set EndBattle(param1:Function) : void
      {
         this.FEndBattle = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorUserAssets.Load();
            this.FProcessorWindowSell.Load();
            return;
         }
         this.FProcessorUserAssets.Reset();
         this.FProcessorUserAssets.ResetSellWindow();
         this.FProcessorUserAssets.Visible = true;
         this.FProcessorWindowSell.Visible = false;
         this.FProcessorUserAssets.PlayEffect();
      }
      
      override public function Unmount() : void
      {
      }
      
      public function SetExperience(param1:uint) : void
      {
         this.FExperience = param1;
      }
   }
}

