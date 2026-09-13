package Processors.Game.Lobby.Inspector
{
   import Foundation.Network.*;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.SensitiveWord.SSensitiveWord;
   import Foundation.Timing.*;
   import Foundation.Timing.Spaces.UITiming;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import LocalStorages.*;
   import Logics.*;
   import Logics.Agent.SParametersCore;
   import Logics.AntiAddiction.*;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TActivityPetConfig;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.THeroTalent;
   import Logics.DatebaseVO.VO.TMaskword;
   import Logics.HyperStrings.*;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TCollectionInventory;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Spaces.*;
   import Logics.Streamization.BloodFete.TUnstreamizerBloodFete;
   import Logics.Streamization.Characters.TUnstreamizerCharacter;
   import Logics.Streamization.HyperStrings.*;
   import Logics.Streamization.Inventories.TUnstreamizerInventories;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Lobby.Chat.HyperString.Importers.*;
   import Processors.Game.Lobby.Common.*;
   import Rendering.Overlayers.BaseAttribute.TOverlayerBaseAttribute;
   import Rendering.Overlayers.FeteBlood.TCellForRolePanelTip;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Sprite.TOverlayerSprite;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Overlayers.Title.TOverlayerTitle;
   import Resources.Constants.*;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.events.MouseEvent;
   import flash.utils.*;
   
   use namespace UITiming;
   use namespace LogicsSpace;
   
   public class TProcessorInspector extends TProcessorLobbyWindows
   {
      
      protected static const SYNCHRONIZE_SEVERY_TIME:uint = CONST_INSPECTOR.SYNCHRONIZE_SEVERY_TIME;
      
      protected static const TIME_INTERVAL_InspectorAntiAddiction:int = CONST_INSPECTOR.TIME_INTERVAL_InspectorAntiAddiction;
      
      protected static const TIME_Radix_InspectorAntiAddictions:Vector.<int> = CONST_INSPECTOR.TIME_Radix_InspectorAntiAddictions;
      
      protected static const TIME_AntiAddictionUpperLimit:int = CONST_INSPECTOR.TIME_AntiAddictionUpperLimit;
      
      public static const TYPE_ANTIADDICTION_ADULTHOOD:uint = CONST_INSPECTOR.TYPE_ANTIADDICTION_ADULTHOOD;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var FUnstreamizerHyperString:TUnstreamizerHyperString;
      
      protected var FHyperStringImporter:THyperStringImporter;
      
      protected var FPoolHyperString:TPoolHyperString;
      
      protected var FHyperString:THyperString;
      
      protected var FAntiAddiction:TAntiAddiction;
      
      protected var FTickInspectorAntiAddiction:int;
      
      protected var FIsAntiAddictionState:Boolean;
      
      protected var FAntiAddictionsState:Vector.<Boolean>;
      
      protected var FTickReference:int;
      
      protected var FIsInitialize:Boolean;
      
      protected var FWindowHeroInfor:TProcessorWindowHeroInfor;
      
      protected var FWindowInventoryInfor:TProcessorWindowInventoryInfor;
      
      protected var FWindowHeroDescription:TProcessorWindowHeroDescription;
      
      protected var FHeroIDHigh:uint;
      
      protected var FHeroIDLow:uint;
      
      protected var FUnstreamizerCharacter:TUnstreamizerCharacter;
      
      protected var FHeros:THeros;
      
      protected var FOverlayerEquipmentMounted:TOverlayerEquipment;
      
      protected var FOverlayerAccessoryMounted:TOverlayerAccessory;
      
      protected var FOverlayerBaseAttribute:TOverlayerBaseAttribute;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FOverlayerSprite:TOverlayerSprite;
      
      protected var FFBOverTip:TCellForRolePanelTip;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerInventories:TUnstreamizerInventories;
      
      protected var FIDTemplates:Vector.<uint>;
      
      protected var FInventories:TInventories;
      
      protected var FAppliance:TAppliance;
      
      protected var FEquipment:TEquipment;
      
      protected var FTitles:TTitles;
      
      protected var FActivityPetConfigBins:TBins;
      
      protected var FTUnstreamizerBloodFete:TUnstreamizerBloodFete;
      
      protected var FOnChatAnnouncement:Function;
      
      protected var FOnAntiAddiction:Function;
      
      protected var FOnCheckKingwarIconEffect:Function;
      
      protected var FRequestWhisper:Function;
      
      protected var FRequestAddFriend:Function;
      
      protected var FRequestSendMail:Function;
      
      protected var FIsCanShow:Boolean;
      
      public function TProcessorInspector(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FHyperStringImporter = new THyperStringImporter();
         this.FPoolHyperString = SLogicsCore.PoolHyperString;
         this.FAntiAddiction = SLogicsCore.AntiAddiction;
         this.FAntiAddictionsState = new Vector.<Boolean>(TIME_AntiAddictionUpperLimit);
         this.FTickInspectorAntiAddiction = STimingCore.TickCount;
         this.FWindowHeroInfor = new TProcessorWindowHeroInfor(this);
         this.FWindowHeroInfor.OnInventoryOver = this.UIComponentsOverlayerOnOver;
         this.FWindowHeroInfor.OnInventoryOut = this.UIComponentsOverlayerOnOut;
         this.FWindowHeroInfor.OnBaseAttributeOver = this.UIComponentsHintBaseAttributeOnOver;
         this.FWindowHeroInfor.OnBaseAttributeOut = this.UIComponentsHintBaseAttributeOnOut;
         this.FWindowHeroInfor.HintOnOver = ProcessorTipOnOver;
         this.FWindowHeroInfor.HintOnOut = ProcessorTipOnOut;
         this.FWindowHeroInfor.TitleHintOnOver = this.UITitleHintOnOver;
         this.FWindowHeroInfor.TitleHintOnOut = this.UITitleHintOnOut;
         this.FWindowHeroInfor.LittlePetOnOver = this.UILittlePetOnOver;
         this.FWindowHeroInfor.LittlePetOnOut = this.UILittlePetOnOut;
         this.FWindowHeroInfor.BFOnMove = this.BFOnMove;
         this.FWindowHeroInfor.BFOnOut = this.BFOnOut;
         this.FWindowInventoryInfor = new TProcessorWindowInventoryInfor(this);
         this.FWindowHeroDescription = new TProcessorWindowHeroDescription(this);
         this.FWindowHeroDescription.HintOnOver = ProcessorTipOnOver;
         this.FWindowHeroDescription.HintOnOut = ProcessorTipOnOut;
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.visible = false;
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_HeroInfo);
         FOverlayerEquipment.Visible = false;
         this.FOverlayerEquipmentMounted = new TOverlayerEquipment(this,CONST_MODULES.MODULE_HeroInfo);
         this.FOverlayerEquipmentMounted.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_HeroInfo);
         FOverlayerAccessory.Visible = false;
         this.FOverlayerAccessoryMounted = new TOverlayerAccessory(this,CONST_MODULES.MODULE_HeroInfo);
         this.FOverlayerAccessoryMounted.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_HeroInfo);
         FOverlayerAppliance.Visible = false;
         this.FOverlayerBaseAttribute = new TOverlayerBaseAttribute(this);
         this.FOverlayerBaseAttribute.Visible = false;
         this.FUnstreamizerCharacter = new TUnstreamizerCharacter();
         this.FUnstreamizerInventories = new TUnstreamizerInventories();
         this.FHeros = new THeros();
         this.FOverlayerTitle = new TOverlayerTitle(this);
         this.FOverlayerTitle.Visible = false;
         this.FOverlayerSprite = new TOverlayerSprite(this);
         this.FOverlayerSprite.Visible = false;
         this.FFBOverTip = new TCellForRolePanelTip(this);
         this.FFBOverTip.Visible = false;
         this.FTitles = SLogicsCore.Titles;
         this.FIDTemplates = new Vector.<uint>();
         this.FInventories = new TInventories();
         this.FTUnstreamizerBloodFete = new TUnstreamizerBloodFete();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(553648129);
         SResourcesCore.ResourceBin.LoadPrimary(CONST_DATEBASEVO.RESOURCEID_Maskword);
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_QUEST.RESOURCESID_QuestBadge);
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_MainScene.RESOURCESID_EnterNotification);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBins = null;
         var _loc4_:TMaskword = null;
         var _loc5_:String = null;
         _loc3_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Maskword);
         _loc2_ = _loc3_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_.GetDatebaseByIndex(_loc1_) as TMaskword;
            _loc5_ = _loc4_.Name;
            SSensitiveWord.AddKey(_loc5_);
            _loc1_++;
         }
         SSensitiveWord.Init();
         this.FWindowHeroInfor.UIDispatch();
         this.FWindowInventoryInfor.UIDispatch();
         this.FWindowHeroDescription.UIDispatch();
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerEquipmentMounted);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAccessoryMounted);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBaseAttribute);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTitle);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSprite);
         TUtilityUIOverlayer.ResourcesDispatch(this.FFBOverTip);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FActivityPetConfigBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ActivityPetConfig);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FWindowHeroInfor.UILocations();
         this.FWindowInventoryInfor.UILocation();
         this.FWindowHeroDescription.UILocation();
         this.FWindowHeroDescription.visible = true;
         FUICore.stage.addEventListener(MouseEvent.MOUSE_UP,this.OnMouseUp);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Inspector_CharInfoRet,this.PerformPacket_SC_Heros_CharInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Inspector_InventoryRet,this.PerformPacket_SC_InventoryInforRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Inspector_QuertServerTimeRet,this.PacketPerform_SC_QuertServerTime);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Inspector_Announcement,this.PacketPerform_SC_Announcement);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Inspector_CharInfoPVPRet,this.PACKETID_SC_Inspector_CharInfoPVPRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossUser_Ret,this.PerformPacket_SC_CrossUser_Ret);
      }
      
      protected function PerformPacket_SC_CrossUser_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:THeroTalent = null;
         _loc2_ = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         var _loc4_:int = _loc2_.readInt();
         var _loc5_:Number = _loc2_.readDouble();
         _loc7_ = TUtilityString.FetchUTF(_loc2_);
         this.FUnstreamizerCharacter.UnstreamizeHeros(_loc2_,this.FHeros,null);
         this.ProcessorAllHeroEquipmentMountedSuitCount(this.FHeros);
         this.FHeros.GetHeroByIndex(0).Quality = param1.Data.readUnsignedInt();
         this.FHeros.GetHeroByIndex(0).Name = _loc7_;
         this.FWindowHeroInfor.Heros = this.FHeros;
         _loc8_ = param1.Data.readUnsignedInt();
         _loc9_ = param1.Data.readUnsignedInt();
         _loc10_ = param1.Data.readUnsignedInt();
         _loc11_ = param1.Data.readUnsignedInt();
         _loc12_ = param1.Data.readUnsignedInt();
         this.FWindowHeroInfor.SoulFormationID = param1.Data.readUnsignedInt();
         _loc13_ = param1.Data.readUnsignedInt();
         this.FWindowHeroInfor.Wing.WingID = param1.Data.readUnsignedInt();
         this.FWindowHeroInfor.Wing.TransformID = param1.Data.readUnsignedInt();
         _loc14_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroTalent,_loc13_) as THeroTalent;
         if(_loc14_)
         {
            this.FHeros.GetHeroByIndex(0).TalentName = _loc14_.TalentName;
            this.FHeros.GetHeroByIndex(0).TalentDesc = _loc14_.TalentDesc;
         }
         this.FWindowHeroInfor.UpdateTitle(_loc8_);
         this.FWindowHeroInfor.UpdateLittlePet(_loc9_);
         this.FWindowHeroInfor.UpdateMagic(_loc10_,_loc11_,_loc12_);
         this.FWindowHeroInfor.Update();
         this.FWindowInventoryInfor.HideInventoryInfor();
         this.PACKETID_SC_Inspector_CharInfoPVPRet(param1);
      }
      
      protected function PacketPerform_SC_QuertServerTime(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:ByteArray = null;
         _loc6_ = param1.Data;
         _loc2_ = _loc6_.readUnsignedInt();
         if(_loc2_ == 0)
         {
            _loc3_ = int(_loc6_.readUnsignedInt());
            _loc4_ = _loc6_.readUnsignedInt();
            _loc5_ = _loc6_.readUnsignedInt();
            STimingCore.SetServerTime(_loc4_);
            STimingCore.SetServerStartTime(_loc5_);
            STimingCore.SetServerTimezoneOffset(_loc3_);
         }
         if(this.FOnCheckKingwarIconEffect != null)
         {
            this.FOnCheckKingwarIconEffect(this);
         }
      }
      
      protected function PacketPerform_SC_Announcement(param1:TPacket) : void
      {
      }
      
      public function PacketPerform_SC_UpdateOtheroPanel(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.Data.readUnsignedInt());
         if(_loc2_ != 0)
         {
            this.FIsCanShow = false;
            return;
         }
         this.FIsCanShow = true;
         this.FTUnstreamizerBloodFete.UnstreamizationPerformOthers(param1.Data,this.FHeros);
      }
      
      protected function PerformPacket_SC_Heros_CharInfoRet(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:THeroTalent = null;
         _loc2_ = int(param1.Data.readUnsignedInt());
         if(_loc2_ != 0)
         {
            return;
         }
         _loc3_ = TUtilityString.FetchUTF(param1.Data);
         this.FUnstreamizerCharacter.UnstreamizeHeros(param1.Data,this.FHeros,null);
         this.ProcessorAllHeroEquipmentMountedSuitCount(this.FHeros);
         this.FHeros.GetHeroByIndex(0).Quality = param1.Data.readUnsignedInt();
         this.FHeros.GetHeroByIndex(0).Name = _loc3_;
         this.FWindowHeroInfor.Heros = this.FHeros;
         _loc4_ = param1.Data.readUnsignedInt();
         _loc5_ = param1.Data.readUnsignedInt();
         _loc6_ = param1.Data.readUnsignedInt();
         _loc7_ = param1.Data.readUnsignedInt();
         _loc8_ = param1.Data.readUnsignedInt();
         this.FWindowHeroInfor.SoulFormationID = param1.Data.readUnsignedInt();
         _loc9_ = param1.Data.readUnsignedInt();
         this.FWindowHeroInfor.Wing.WingID = param1.Data.readUnsignedInt();
         this.FWindowHeroInfor.Wing.TransformID = param1.Data.readUnsignedInt();
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroTalent,_loc9_) as THeroTalent;
         if(_loc10_)
         {
            this.FHeros.GetHeroByIndex(0).TalentName = _loc10_.TalentName;
            this.FHeros.GetHeroByIndex(0).TalentDesc = _loc10_.TalentDesc;
         }
         this.FWindowHeroInfor.UpdateTitle(_loc4_);
         this.FWindowHeroInfor.UpdateLittlePet(_loc5_);
         this.FWindowHeroInfor.UpdateMagic(_loc6_,_loc7_,_loc8_);
         this.FWindowHeroInfor.Update();
         this.FWindowInventoryInfor.HideInventoryInfor();
      }
      
      protected function PACKETID_SC_Inspector_CharInfoPVPRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:THero = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_.readUnsignedInt();
            _loc6_ = this.FHeros.GetHeroByIdentifier(_loc5_);
            _loc8_ = _loc2_.readShort();
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               if(_loc7_ > 9)
               {
                  _loc9_ = _loc2_.readFloat();
                  _loc10_ = parseFloat(Number(_loc9_ * 100).toFixed(1));
                  _loc6_.BaseAttributesCopy[_loc7_] = _loc10_;
               }
               else
               {
                  if(_loc7_ == 4)
                  {
                     _loc9_ = Math.round(_loc2_.readFloat());
                  }
                  else
                  {
                     _loc9_ = _loc2_.readUnsignedInt();
                  }
                  _loc6_.BaseAttributesCopy[_loc7_] = _loc9_;
               }
               _loc7_++;
            }
            _loc4_++;
         }
         this.FWindowHeroInfor.UpdateHeroInformation();
      }
      
      protected function ProcessorAllHeroEquipmentMountedSuitCount(param1:THeros) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:THero = null;
         var _loc7_:TCollectionInventory = null;
         var _loc8_:TEquipment = null;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:int = 0;
         var _loc11_:uint = 0;
         var _loc12_:Object = null;
         _loc9_ = new Vector.<uint>();
         _loc3_ = param1.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = param1.GetHeroByIndex(_loc2_);
            _loc7_ = _loc6_.EquipmentsMounted;
            _loc5_ = _loc7_.Capacity;
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc8_ = _loc7_.GetInventoryByIndex(_loc4_) as TEquipment;
               if(_loc8_ != null)
               {
                  _loc12_ = _loc6_.GetSuitCountByEpicEquipment(_loc8_);
                  _loc6_.SetSuitObject(_loc8_,_loc12_);
                  _loc10_ = _loc9_.indexOf(_loc8_.SuitID);
                  if(_loc10_ < 0)
                  {
                     _loc9_.push(_loc8_.SuitID);
                     _loc11_ = _loc6_.GetSuitCountByEquipment(_loc8_);
                     _loc6_.SetSuitCount(_loc8_,_loc11_);
                  }
               }
               _loc4_++;
            }
            _loc7_ = _loc6_.AccessoryMounted;
            _loc5_ = _loc7_.Capacity;
            _loc9_.length = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc8_ = _loc7_.GetInventoryByIndex(_loc4_) as TEquipment;
               if(_loc8_ != null)
               {
                  _loc11_ = _loc6_.GetSuitCountByEquipment(_loc8_);
                  _loc6_.SetSuitCount(_loc8_,_loc11_);
               }
               _loc4_++;
            }
            _loc9_.length = 0;
            _loc2_++;
         }
      }
      
      protected function PerformPacket_SC_InventoryInforRet(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.Data.readUnsignedInt());
         if(_loc2_ != 0)
         {
            param1.Data.readUnsignedShort();
            param1.Data.readUnsignedByte();
            param1.Data.readUnsignedInt();
            param1.Data.readUnsignedInt();
            this.ShowInventoryInforFromLocalData(param1.Data.readUnsignedInt());
            return;
         }
         this.FInventories.Clear();
         this.FUnstreamizerInventories.Unstreamize(param1.Data,this.FInventories,null);
         this.FWindowInventoryInfor.Inventory = this.FInventories.GetInventoryByIndex(0);
         this.FWindowInventoryInfor.ShowInventoryInfor();
         this.FWindowInventoryInfor.visible = true;
      }
      
      protected function ShowInventoryInforFromLocalData(param1:uint) : void
      {
         this.FInventories.Clear();
         this.FIDTemplates.length = 0;
         this.FIDTemplates.push(param1);
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,this.FIDTemplates);
         this.FWindowInventoryInfor.Inventory = this.FInventories.GetInventoryByIndex(0);
         this.FWindowInventoryInfor.ShowInventoryInfor();
         this.FWindowHeroInfor.HideWindow();
         this.FWindowInventoryInfor.visible = true;
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:Boolean = false;
         super.LogicsPerform();
         if(this.FIsInitialize)
         {
            _loc1_ = this.LogicsPerform_ConnectionVerify();
            if(_loc1_)
            {
               this.LogicsPerform_UpdataServerTime();
               if(this.FIsAntiAddictionState)
               {
                  this.LogicsPerform_InspectorAntiAddiction();
               }
            }
         }
      }
      
      protected function LogicsPerform_ConnectionVerify() : Boolean
      {
         return SNetworkCore.ConnectionVerify();
      }
      
      protected function LogicsPerform_UpdataServerTime() : void
      {
         var _loc1_:int = 0;
         _loc1_ = int(STimingCore.TickCount);
         if(_loc1_ - this.FTickReference > SYNCHRONIZE_SEVERY_TIME)
         {
            this.ProcessorUpdataServerTimeReq();
            this.FTickReference = STimingCore.TickCount;
         }
      }
      
      protected function LogicsPerform_InspectorAntiAddiction() : void
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Boolean = false;
         var _loc12_:Date = null;
         var _loc13_:Date = null;
         var _loc14_:int = 0;
         var _loc15_:Boolean = false;
         _loc3_ = int(STimingCore.TickCount);
         if(_loc3_ - this.FTickInspectorAntiAddiction < TIME_INTERVAL_InspectorAntiAddiction)
         {
            return;
         }
         _loc4_ = int(STimingCore.GetServerTime());
         _loc5_ = this.FAntiAddiction.LastOnlineDate;
         _loc13_ = new Date(_loc4_ * 1000);
         _loc12_ = new Date(_loc5_ * 1000);
         _loc6_ = _loc13_.getTime() - _loc12_.getTime();
         this.FAntiAddiction.OnlineTime += _loc6_;
         _loc7_ = this.FAntiAddiction.OnlineTime / 1000;
         _loc2_ = TIME_AntiAddictionUpperLimit - 1;
         _loc1_ = _loc2_;
         while(_loc1_ >= 0)
         {
            _loc11_ = false;
            _loc14_ = TIME_Radix_InspectorAntiAddictions[_loc1_];
            _loc8_ = _loc14_ / 1000;
            _loc15_ = this.FAntiAddictionsState[_loc1_];
            if(_loc15_)
            {
               break;
            }
            if(_loc7_ >= _loc8_)
            {
               _loc11_ = true;
            }
            if(_loc11_)
            {
               if(this.FOnChatAnnouncement != null)
               {
                  this.FOnChatAnnouncement(this,_loc1_ + 1);
               }
               if(this.FOnAntiAddiction != null)
               {
                  this.FOnAntiAddiction(this,_loc1_ + 1);
               }
               this.FAntiAddiction.OnlineTime = _loc8_ * 1000;
               this.FAntiAddictionsState[_loc1_] = _loc11_;
               break;
            }
            _loc1_--;
         }
         _loc12_ = null;
         _loc13_ = null;
         this.FTickInspectorAntiAddiction = STimingCore.TickCount;
         this.FAntiAddiction.LastOnlineDate = STimingCore.GetServerTime();
         this.ProcessorSaveAntiAddiction();
      }
      
      protected function ProcessorUpdataServerTimeReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Inspector_QuertServerTimeReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorCharacterCheckAntiAddiction() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Date = null;
         var _loc6_:Date = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(this.FOnChatAnnouncement != null)
         {
            this.FOnChatAnnouncement(this,0);
         }
         _loc7_ = int(SParametersCore.AntiAddictionState);
         switch(_loc7_)
         {
            case TYPE_ANTIADDICTION_ADULTHOOD:
               this.FIsAntiAddictionState = false;
               break;
            default:
               this.FIsAntiAddictionState = true;
         }
         this.FIsAntiAddictionState = false;
         if(this.FIsAntiAddictionState)
         {
            _loc1_ = this.FAntiAddiction.LastOnlineDate;
            _loc2_ = int(STimingCore.GetServerTime());
            _loc5_ = new Date(_loc1_ * 1000);
            _loc6_ = new Date(_loc2_ * 1000);
            _loc3_ = _loc6_.getTime() - _loc5_.getTime();
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            _loc4_ = this.FAntiAddiction.OnlineTime - _loc3_;
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            this.FAntiAddiction.OnlineTime = _loc4_;
            _loc4_ /= 1000;
            _loc9_ = TIME_Radix_InspectorAntiAddictions[TIME_AntiAddictionUpperLimit - 1];
            _loc8_ = _loc9_ / 1000;
            if(_loc4_ >= _loc8_)
            {
               if(this.FOnChatAnnouncement != null)
               {
                  this.FOnChatAnnouncement(this,TIME_AntiAddictionUpperLimit);
               }
               if(this.FOnAntiAddiction != null)
               {
                  this.FOnAntiAddiction(this,TIME_AntiAddictionUpperLimit);
               }
            }
            this.FAntiAddiction.LastOnlineDate = STimingCore.GetServerTime();
            this.ProcessorSaveAntiAddiction();
            _loc5_ = null;
            _loc6_ = null;
         }
      }
      
      protected function ProcessorSaveAntiAddiction() : void
      {
         SLocalStoragelCore.Flush(this.FAntiAddiction.Data);
      }
      
      protected function CheckIfNeedGetDataFromSever(param1:uint) : Boolean
      {
         var _loc2_:TBins = null;
         var _loc3_:TArticle = null;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,param1) as TArticle;
         if(_loc3_ != null && _loc3_.MajorType == 4)
         {
            return true;
         }
         _loc2_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseEquip);
         if(_loc2_.GetDatebaseByIdentifier(param1) != null)
         {
            return true;
         }
         return false;
      }
      
      protected function ProcessorWindowHerosOnClose(param1:Object) : void
      {
      }
      
      protected function UIComponentsOverlayerOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TInventory = null;
         var _loc5_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               _loc5_ = FOverlayerEquipment;
               break;
            case CATEGORY_Accessories:
               FOverlayerAccessory.IsMeOrOthers = 1;
               _loc5_ = FOverlayerAccessory;
               break;
            default:
               _loc5_ = FOverlayerAppliance;
         }
         if(_loc5_ != null)
         {
            _loc5_.Context = _loc3_;
            _loc5_.Render(FUICore.MouseCoordinate);
            _loc5_.Show();
         }
      }
      
      protected function UIComponentsOverlayerOnOut(param1:Object, param2:TInventory) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               _loc4_ = FOverlayerEquipment;
               break;
            case CATEGORY_Accessories:
               _loc4_ = FOverlayerAccessory;
               break;
            default:
               _loc4_ = FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
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
      
      protected function OnMouseUp(param1:MouseEvent) : void
      {
         this.FWindowInventoryInfor.HideInventoryInfor();
         this.FWindowHeroDescription.Hide();
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
      
      protected function UITitleHintOnOut(param1:Object) : void
      {
         this.FOverlayerTitle.Hide();
      }
      
      protected function UILittlePetOnOver(param1:Object, param2:uint) : void
      {
         var _loc3_:TActivityPetConfig = null;
         _loc3_ = this.FActivityPetConfigBins.GetDatebaseByIdentifier(param2) as TActivityPetConfig;
         if(_loc3_ != null)
         {
            this.FOverlayerSprite.Context = _loc3_;
            this.FOverlayerSprite.Render(FUICore.MouseCoordinate);
            this.FOverlayerSprite.Show();
         }
      }
      
      protected function UILittlePetOnOut(param1:Object) : void
      {
         this.FOverlayerSprite.Hide();
      }
      
      protected function BFOnMove(param1:THero) : void
      {
         if(!this.FIsCanShow)
         {
            return;
         }
         this.FFBOverTip.Context = param1;
         this.FFBOverTip.Render(FUICore.MouseCoordinate);
         this.FFBOverTip.Show();
      }
      
      protected function BFOnOut() : void
      {
         this.FFBOverTip.Hide();
      }
      
      public function get OnChatAnnouncement() : Function
      {
         return this.FOnChatAnnouncement;
      }
      
      public function set OnChatAnnouncement(param1:Function) : void
      {
         this.FOnChatAnnouncement = param1;
      }
      
      public function get OnAntiAddiction() : Function
      {
         return this.FOnAntiAddiction;
      }
      
      public function set OnAntiAddiction(param1:Function) : void
      {
         this.FOnAntiAddiction = param1;
      }
      
      public function get OnCheckKingwarIconEffect() : Function
      {
         return this.FOnCheckKingwarIconEffect;
      }
      
      public function set OnCheckKingwarIconEffect(param1:Function) : void
      {
         this.FOnCheckKingwarIconEffect = param1;
      }
      
      public function UpdataServerTime() : void
      {
         this.ProcessorUpdataServerTimeReq();
         this.FTickReference = STimingCore.TickCount;
      }
      
      public function UpdateCharacterCheckAntiAddiction() : void
      {
         this.ProcessorCharacterCheckAntiAddiction();
         this.FIsInitialize = true;
      }
      
      public function RequestShowHero(param1:uint, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Inspector_CharInfoReq);
         _loc3_.Data.writeUnsignedInt(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLing_AllMsg_Rep);
         _loc3_.Data.writeUnsignedInt(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_FBB_C2S_OthersHeros_Req);
         _loc3_.Data.writeUnsignedInt(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      public function RequestInventoryInfor(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint) : void
      {
         var _loc6_:TPacket = null;
         var _loc7_:Boolean = false;
         _loc7_ = this.CheckIfNeedGetDataFromSever(param5);
         if(_loc7_)
         {
            _loc6_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Inspector_InventoryReq);
            _loc6_.Data.writeUnsignedInt(param1);
            _loc6_.Data.writeUnsignedInt(param2);
            _loc6_.Data.writeUnsignedInt(param5);
            _loc6_.Data.writeUnsignedInt(param3);
            _loc6_.Data.writeUnsignedInt(param4);
            SNetworkCore.Transceiver.PacketTransmit(_loc6_);
         }
         else
         {
            this.ShowInventoryInforFromLocalData(param5);
         }
      }
      
      public function RequestShowHeroDescription(param1:uint) : void
      {
         this.FWindowHeroDescription.HeroID = param1;
      }
      
      public function UpdataWindowHeroInfor(param1:Object) : void
      {
         if(Boolean(this.FWindowHeroInfor) && this.FWindowHeroInfor.visible)
         {
            this.FWindowHeroInfor.UpdateLittlePet(uint(param1));
         }
      }
   }
}

