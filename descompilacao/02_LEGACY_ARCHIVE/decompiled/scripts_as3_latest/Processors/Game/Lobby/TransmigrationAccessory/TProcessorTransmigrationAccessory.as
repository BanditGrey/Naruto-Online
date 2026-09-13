package Processors.Game.Lobby.TransmigrationAccessory
{
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TNewornament_battle;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventory;
   import Logics.Items.TItem;
   import Logics.Items.TItems;
   import Logics.SLogicsCore;
   import Logics.Streamization.TransmigrationAccessory.TUnstreamizerTransmigrationAccessory;
   import Logics.TransmigrationAccessory.TAccessoryCampaign;
   import Logics.TransmigrationAccessory.TTransmigrationAccessoryData;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Windows.Information.TUIWindowInformation;
   import Rendering.Overlayers.Inventories.*;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TRANSMIGRATIONACCESSORY;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TRANSMIGRATIONACCESSORY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorTransmigrationAccessory extends TProcessorLobbyWindows
   {
      
      protected static const CONST_TAB_MAX:uint = 4;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var FScene:MovieClip;
      
      protected var FUITab:TUITab;
      
      protected var FWindowTransmigrationAccessory:TProcessorWindowTransmigrationAccessory;
      
      protected var FWindowTransmigrationAccessoryMake:TProcessorWindowTransmigrationAccessoryMake;
      
      protected var FWindowTransmigrationAccessoryUpgrade:TProcessorWindowTransmigrationAccessoryUpgrade;
      
      protected var FWindowTransmigrationAccessoryMakeAdvanced:TProcessorWindowTransmigrationAccessoryMakeAdvanced;
      
      protected var UnstreamizerTransmigrationAccessory:TUnstreamizerTransmigrationAccessory;
      
      protected var FTransmigrationAccessoryData:TTransmigrationAccessoryData;
      
      protected var FCurTabIndex:uint;
      
      protected var FUIWindowInformationSure:TUIWindowInformation;
      
      protected var FArticleBin:TBins;
      
      protected var FSelectContext:Object;
      
      protected var FHelpTips:THint;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FOnEffectSign:Function;
      
      public function TProcessorTransmigrationAccessory(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.UnstreamizerTransmigrationAccessory = new TUnstreamizerTransmigrationAccessory();
         this.FTransmigrationAccessoryData = SLogicsCore.TransmigrationAccessoryData;
         this.FCurTabIndex = 0;
         this.FHelpTips = new THint();
         SetUIModuleID(CONST_MODULES.MODULE_TransmigrationAccessory);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FWindowTransmigrationAccessory.UpdateView();
         this.FWindowTransmigrationAccessoryMake.UpdateView();
         this.FWindowTransmigrationAccessoryUpgrade.UpdateView();
         this.FWindowTransmigrationAccessoryMakeAdvanced.UpdateView();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TRANSMIGRATIONACCESSORY.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.InitTransmigrationTrial();
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function InitTransmigrationTrial() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_TRANSMIGRATIONACCESSORY.RESOURCE_ClassName_TransmigrationAccessory) as MovieClip;
         addChild(this.FScene);
         this.FWindowTransmigrationAccessory = new TProcessorWindowTransmigrationAccessory(this);
         this.FWindowTransmigrationAccessory.SetScene(this.FScene["mc_Campaign"],this.FScene["mc_Stage"]);
         this.FWindowTransmigrationAccessory.Visible = false;
         this.FWindowTransmigrationAccessory.SlotsOnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FWindowTransmigrationAccessory.SlotsOnQuerySubscript = this.SlotsOnQuerySubscript;
         this.FWindowTransmigrationAccessory.UIComponentsHintOnOver = UIComponentsHintOnOver;
         this.FWindowTransmigrationAccessory.UIComponentsHintOnOut = UIComponentsHintOnOut;
         this.FWindowTransmigrationAccessoryMake = new TProcessorWindowTransmigrationAccessoryMake(this);
         this.FWindowTransmigrationAccessoryMake.SetScene(this.FScene["mc_MakeEquip"]);
         this.FWindowTransmigrationAccessoryMake.Visible = false;
         this.FWindowTransmigrationAccessoryMake.SlotsOnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FWindowTransmigrationAccessoryMake.SlotsOnQuerySubscript = this.SlotsOnQuerySubscript;
         this.FWindowTransmigrationAccessoryMake.UIComponentsHintOnOver = UIComponentsHintOnOver;
         this.FWindowTransmigrationAccessoryMake.UIComponentsHintOnOut = UIComponentsHintOnOut;
         this.FWindowTransmigrationAccessoryUpgrade = new TProcessorWindowTransmigrationAccessoryUpgrade(this);
         this.FWindowTransmigrationAccessoryUpgrade.SetScene(this.FScene["mc_Upgrade"]);
         this.FWindowTransmigrationAccessoryUpgrade.Visible = false;
         this.FWindowTransmigrationAccessoryUpgrade.SlotsOnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FWindowTransmigrationAccessoryUpgrade.SlotsOnQuerySubscript = this.SlotsOnQuerySubscript;
         this.FWindowTransmigrationAccessoryUpgrade.UIComponentsHintOnOver = UIComponentsHintOnOver;
         this.FWindowTransmigrationAccessoryUpgrade.UIComponentsHintOnOut = UIComponentsHintOnOut;
         this.FWindowTransmigrationAccessoryUpgrade.SlotsOnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
         this.FWindowTransmigrationAccessoryUpgrade.EffectText = this.OnTextEffect;
         this.FWindowTransmigrationAccessoryMakeAdvanced = new TProcessorWindowTransmigrationAccessoryMakeAdvanced(this);
         this.FWindowTransmigrationAccessoryMakeAdvanced.SetScene(this.FScene["mc_MakeEquipAdvanced"]);
         this.FWindowTransmigrationAccessoryMakeAdvanced.Visible = false;
         this.FWindowTransmigrationAccessoryMakeAdvanced.SlotsOnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FWindowTransmigrationAccessoryMakeAdvanced.SlotsOnQuerySubscript = this.SlotsOnQuerySubscript;
         this.FWindowTransmigrationAccessoryMakeAdvanced.UIComponentsHintOnOver = UIComponentsHintOnOver;
         this.FWindowTransmigrationAccessoryMakeAdvanced.UIComponentsHintOnOut = UIComponentsHintOnOut;
         this.FWindowTransmigrationAccessoryMakeAdvanced.SlotsOnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
         this.FWindowTransmigrationAccessoryMakeAdvanced.EffectText = this.OnTextEffect;
         this.FUITab = new TUITab(this);
         _loc1_ = 0;
         while(_loc1_ < CONST_TAB_MAX)
         {
            this.FUITab.SetTabByIndex(this.FScene["tab_" + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FScene["btn_Close"].addEventListener(MouseEvent.CLICK,this.BtnCloseOnClick);
         this.FScene["btn_help"].addEventListener(MouseEvent.MOUSE_MOVE,this.OnHelpMouseMove);
         this.FScene["btn_help"].addEventListener(MouseEvent.ROLL_OUT,this.OnHelpRoleOut);
         this.FScene["MC_PendantLeft"].gotoAndPlay(1);
         this.FScene["MC_PendantRight"].gotoAndPlay(1);
         FOverlayerEquipment = new TOverlayerEquipment(this.Parent,CONST_MODULES.MODULE_TransmigrationAccessory);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this.Parent,CONST_MODULES.MODULE_TransmigrationAccessory);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this.Parent,CONST_MODULES.MODULE_TransmigrationAccessory);
         FOverlayerAppliance.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this.Parent,CONST_MODULES.MODULE_TransmigrationAccessory);
         FOverlayerAccessory.Visible = false;
         FOverlayerAccessory.IsMeOrOthers = 0;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         this.FUIWindowInformationSure = new TUIWindowInformation(this);
         this.FUIWindowInformationSure.x = (FUICore.StageWidth - this.FUIWindowInformationSure.WindowWidth) / 2;
         this.FUIWindowInformationSure.y = (FUICore.StageHeight - this.FUIWindowInformationSure.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowInformation(this.FUIWindowInformationSure);
         this.FUIWindowInformationSure.visible = false;
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TransmigrationAccessory_BaseInfo_Ret,this.PACKETID_SC_TransmigrationAccessory_BaseInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TransmigrationAccessory_Challenge_Ret,this.PACKETID_SC_TransmigrationAccessory_Challenge);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TransmigrationAccessory_ResetCampaign_Ret,this.PACKETID_SC_TransmigrationAccessory_ResetCampaign);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TransmigrationAccessory_AutoFight_Ret,this.PACKETID_SC_TransmigrationAccessory_AutoFight);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TransmigrationAccessory_MakeAccessory_Ret,this.PACKETID_SC_TransmigrationAccessory_MakeAccessory);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TransmigrationAccessory_AccessoryLevelup_Ret,this.PACKETID_SC_TransmigrationAccessory_AccessoryLevelup);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TransmigrationAccessory_AccessoryUpgrade_Ret,this.PACKETID_SC_TransmigrationAccessory_AccessoryUpgrade);
      }
      
      protected function PACKETID_SC_TransmigrationAccessory_BaseInfo(param1:TPacket) : void
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
         this.UnstreamizerTransmigrationAccessory.Unstreamize(_loc2_,this.FTransmigrationAccessoryData,null);
         if(Visible)
         {
            this.SetTabVisble(this.FCurTabIndex);
         }
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_TransmigrationAccessory,!this.FTransmigrationAccessoryData.IsAttacked());
         }
      }
      
      protected function PACKETID_SC_TransmigrationAccessory_Challenge(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TNewornament_battle = null;
         var _loc6_:TAccessoryCampaign = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_TransmigrationAccessory,0,false,false,false);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Newornament_battle,_loc4_) as TNewornament_battle;
         if(_loc5_ == null)
         {
            return;
         }
         _loc6_ = this.FTransmigrationAccessoryData.GetAccessoryCampaignByCampaignId(_loc5_.Location);
         if(_loc6_ != null)
         {
            _loc6_.CurStageId = _loc4_;
         }
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_TransmigrationAccessory,!this.FTransmigrationAccessoryData.IsAttacked());
         }
      }
      
      protected function PACKETID_SC_TransmigrationAccessory_ResetCampaign(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TAccessoryCampaign = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = this.FTransmigrationAccessoryData.GetAccessoryCampaignByCampaignId(_loc4_);
         if(_loc5_ != null)
         {
            _loc5_.CurStageId = 0;
            ++_loc5_.TodayResetTimes;
         }
         EffectGenerateText(STRING_TRANSMIGRATIONACCESSORY.STRING_ResetSuss);
         this.SetTabVisble(this.FCurTabIndex);
      }
      
      protected function PACKETID_SC_TransmigrationAccessory_AutoFight(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         var _loc10_:TArticle = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:TNewornament_battle = null;
         var _loc14_:TAccessoryCampaign = null;
         var _loc15_:TItem = null;
         var _loc16_:TItems = null;
         _loc4_ = param1.Data;
         _loc5_ = _loc4_.readUnsignedInt();
         if(_loc5_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc5_);
            return;
         }
         _loc11_ = _loc4_.readUnsignedInt();
         _loc12_ = _loc4_.readUnsignedInt();
         if(this.FArticleBin == null)
         {
            this.FArticleBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         }
         _loc13_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Newornament_battle,_loc12_) as TNewornament_battle;
         _loc14_ = this.FTransmigrationAccessoryData.GetAccessoryCampaignByCampaignId(_loc13_.Location);
         if(_loc14_ != null)
         {
            _loc14_.CurStageId = _loc12_;
         }
         _loc9_ = TUtilityString.Format(STRING_TRANSMIGRATIONACCESSORY.STRING_REWARDINFO,_loc13_.SStageID);
         _loc16_ = new TItems();
         _loc3_ = _loc4_.readUnsignedShort();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = _loc4_.readUnsignedShort();
            _loc7_ = _loc4_.readUnsignedInt();
            _loc8_ = _loc4_.readUnsignedInt();
            _loc15_ = this.GetItemByID(_loc16_,_loc6_,_loc7_);
            _loc15_.Count += _loc8_;
            _loc2_++;
         }
         _loc3_ = uint(_loc16_.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc15_ = _loc16_.RewardByIndex(_loc2_);
            _loc10_ = this.FArticleBin.GetDatebaseByIdentifier(CONST_COMMON.GetItemIDByType(_loc15_.Type,_loc15_.ID,this.FArticleBin)) as TArticle;
            _loc9_ += _loc10_.Name + " *" + _loc15_.Count;
            if(_loc2_ != _loc3_ - 1)
            {
               _loc9_ += ",";
            }
            _loc2_++;
         }
         this.FUIWindowInformationSure.Text = _loc9_;
         this.FUIWindowInformationSure.Visible = true;
         this.SetTabVisble(this.FCurTabIndex);
         _loc16_.Clear();
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_TransmigrationAccessory,!this.FTransmigrationAccessoryData.IsAttacked());
         }
      }
      
      protected function PACKETID_SC_TransmigrationAccessory_MakeAccessory(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            this.FWindowTransmigrationAccessoryMake.ResetMaking();
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FWindowTransmigrationAccessoryMake.Reset();
         EffectGenerateText(STRING_TRANSMIGRATIONACCESSORY.STRING_MakeSuccess);
      }
      
      protected function PACKETID_SC_TransmigrationAccessory_AccessoryLevelup(param1:TPacket) : void
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
         this.FWindowTransmigrationAccessoryUpgrade.UpgradeUpdate();
         EffectGenerateText(STRING_TRANSMIGRATIONACCESSORY.STRING_UpgradeSuccess);
      }
      
      protected function PACKETID_SC_TransmigrationAccessory_AccessoryUpgrade(param1:TPacket) : void
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
         this.FWindowTransmigrationAccessoryMakeAdvanced.Update();
         EffectGenerateText(STRING_TRANSMIGRATIONACCESSORY.STRING_MakeAdvancedSuccess);
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FCurTabIndex = param1 as int;
         this.SetTabVisble(this.FCurTabIndex);
      }
      
      protected function SetTabVisble(param1:int) : void
      {
         this.FWindowTransmigrationAccessory.Visible = false;
         this.FWindowTransmigrationAccessoryMake.Visible = false;
         this.FWindowTransmigrationAccessoryUpgrade.Visible = false;
         this.FWindowTransmigrationAccessoryMakeAdvanced.Visible = false;
         switch(param1)
         {
            case 0:
               this.FWindowTransmigrationAccessory.Visible = true;
               this.FWindowTransmigrationAccessory.Update();
               break;
            case 1:
               this.FWindowTransmigrationAccessoryMake.Visible = true;
               this.FWindowTransmigrationAccessoryMake.Update();
               break;
            case 2:
               this.FWindowTransmigrationAccessoryUpgrade.Visible = true;
               this.FWindowTransmigrationAccessoryUpgrade.Update();
               break;
            case 3:
               this.FWindowTransmigrationAccessoryMakeAdvanced.Visible = true;
               this.FWindowTransmigrationAccessoryMakeAdvanced.Update();
         }
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
            _loc6_.LoadSecondary(_loc5_.IDTexture);
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
      
      protected function SlotsOnQueryEuqipLevel(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TInventory = null;
         if(param2 is TInventory)
         {
            _loc4_ = param2 as TInventory;
            if(_loc4_.UpgradingLevel > 0)
            {
               param3.Value = STRING_COMMON.FORMAT_Level + _loc4_.UpgradingLevel.toString();
            }
         }
      }
      
      protected function OnTextEffect(param1:Object, param2:String) : void
      {
         EffectGenerateText(param2);
      }
      
      protected function GetItemByID(param1:TItems, param2:uint, param3:uint) : TItem
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TItem = null;
         var _loc7_:TItem = null;
         _loc5_ = uint(param1.Count);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = param1.RewardByIndex(_loc4_);
            if(_loc6_.Type == param2 && _loc6_.ID == param3)
            {
               _loc7_ = _loc6_;
               break;
            }
            _loc4_++;
         }
         if(_loc7_ == null)
         {
            _loc7_ = new TItem();
            _loc7_.Type = param2;
            _loc7_.ID = param3;
            _loc7_.Count = 0;
            param1.Add(_loc7_);
         }
         return _loc7_;
      }
      
      protected function ProcessorStreamData(param1:ByteArray) : void
      {
         if(param1 != null)
         {
            this.FCurTabIndex = param1.readUnsignedInt();
         }
      }
      
      protected function BtnCloseOnClick(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function OnHelpMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_70170096) as TSystemLanguage;
         this.FHelpTips.Content = _loc2_.Desc;
         FOverlayerHelpTips.Context = this.FHelpTips;
         FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         FOverlayerHelpTips.Show();
      }
      
      protected function OnHelpRoleOut(param1:MouseEvent) : void
      {
         FOverlayerHelpTips.Hide();
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      public function get SetStatusType() : Function
      {
         return this.FSetStatusType;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function get OnInitBattle() : Function
      {
         return this.FOnInitBattle;
      }
      
      public function set OnEffectSign(param1:Function) : void
      {
         this.FOnEffectSign = param1;
      }
      
      public function get OnEffectSign() : Function
      {
         return this.FOnEffectSign;
      }
      
      public function get SelectContext() : Object
      {
         return this.FSelectContext;
      }
      
      public function set SelectContext(param1:Object) : void
      {
         this.FSelectContext = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         this.ProcessorStreamData(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FScene["MC_PendantLeft"].gotoAndPlay(1);
         this.FScene["MC_PendantRight"].gotoAndPlay(1);
         this.SetTabVisble(this.FCurTabIndex);
         this.FUITab.TabIndex = this.FCurTabIndex;
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FCurTabIndex = 0;
      }
   }
}

