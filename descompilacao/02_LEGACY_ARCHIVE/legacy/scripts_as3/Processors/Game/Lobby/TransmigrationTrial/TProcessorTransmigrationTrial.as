package Processors.Game.Lobby.TransmigrationTrial
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
   import Logics.DatebaseVO.VO.TEpicEquip_battle;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventory;
   import Logics.Items.TItem;
   import Logics.Items.TItems;
   import Logics.SLogicsCore;
   import Logics.Streamization.TransmigrationTrial.TUnstreamizerTransmigrationTrial;
   import Logics.TransmigrationTrial.TTransmigrationTrialData;
   import Logics.TransmigrationTrial.TTrialCampaign;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.TransmigrationTrial.Component.TUIChange;
   import Processors.Game.Windows.Information.TUIWindowInformation;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TRANSMIGRATIONTRIAL;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TRANSMIGRATIONTRIAL;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorTransmigrationTrial extends TProcessorLobbyWindows
   {
      
      protected static const CONST_TAB_MAX:uint = 3;
      
      protected static const SIZE_Window_Width:uint = 865;
      
      protected static const SIZE_Window_Height:uint = 527;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var FScene:MovieClip;
      
      protected var FUITab:TUITab;
      
      protected var FWindowTransmigrationTrial:TProcessorWindowTransmigrationTrial;
      
      protected var FWindowMakeEquip:TProcessorWindowTransmigrationMakeEquip;
      
      protected var FWindowMakeEquipAdvanced:TProcessorWindowTransmigrationMakeEquipAdvanced;
      
      protected var FUIChange:TUIChange;
      
      protected var UnstreamizerTransmigrationTrial:TUnstreamizerTransmigrationTrial;
      
      protected var FTransmigrationTrialData:TTransmigrationTrialData;
      
      protected var FCurTabIndex:uint;
      
      protected var FUIWindowInformationSure:TUIWindowInformation;
      
      protected var FArticleBin:TBins;
      
      protected var FSelectContext:Object;
      
      protected var FHelpTips:THint;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FOnEffectSign:Function;
      
      public function TProcessorTransmigrationTrial(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.UnstreamizerTransmigrationTrial = new TUnstreamizerTransmigrationTrial();
         this.FTransmigrationTrialData = SLogicsCore.TransmigrationTrialData;
         this.FCurTabIndex = 0;
         SetUIModuleID(CONST_MODULES.MODULE_TransmigrationTrial);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FWindowTransmigrationTrial.UpdateView();
         this.FWindowMakeEquip.UpdateView();
         this.FWindowMakeEquipAdvanced.UpdateView();
         if(this.FUIChange != null && this.FUIChange.Visible)
         {
            this.FUIChange.UpdateSlot();
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TRANSMIGRATIONTRIAL.ResourceId);
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
         var _loc3_:TSystemLanguage = null;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_TRANSMIGRATIONTRIAL.RESOURCE_ClassName_TransmigrationTrial) as MovieClip;
         addChild(this.FScene);
         this.FWindowTransmigrationTrial = new TProcessorWindowTransmigrationTrial(this);
         this.FWindowTransmigrationTrial.SetScene(this.FScene["mc_Campaign"],this.FScene["mc_Stage"]);
         this.FWindowTransmigrationTrial.Visible = false;
         this.FWindowTransmigrationTrial.SlotsOnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FWindowTransmigrationTrial.SlotsOnQuerySubscript = this.SlotsOnQuerySubscript;
         this.FWindowTransmigrationTrial.UIComponentsHintOnOver = UIComponentsHintOnOver;
         this.FWindowTransmigrationTrial.UIComponentsHintOnOut = UIComponentsHintOnOut;
         this.FWindowTransmigrationTrial.ShowChangeView = this.ShowChangeView;
         this.FWindowMakeEquip = new TProcessorWindowTransmigrationMakeEquip(this);
         this.FWindowMakeEquip.SetScene(this.FScene["mc_MakeEquip"]);
         this.FWindowMakeEquip.Visible = false;
         this.FWindowMakeEquip.SlotsOnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FWindowMakeEquip.SlotsOnQuerySubscript = this.SlotsOnQuerySubscript;
         this.FWindowMakeEquip.UIComponentsHintOnOver = UIComponentsHintOnOver;
         this.FWindowMakeEquip.UIComponentsHintOnOut = UIComponentsHintOnOut;
         this.FWindowMakeEquip.ShowChangeView = this.ShowChangeView;
         this.FWindowMakeEquipAdvanced = new TProcessorWindowTransmigrationMakeEquipAdvanced(this);
         this.FWindowMakeEquipAdvanced.SetScene(this.FScene["mc_MakeEquipAdvanced"]);
         this.FWindowMakeEquipAdvanced.Visible = false;
         this.FWindowMakeEquipAdvanced.SlotsOnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FWindowMakeEquipAdvanced.SlotsOnQuerySubscript = this.SlotsOnQuerySubscript;
         this.FWindowMakeEquipAdvanced.UIComponentsHintOnOver = UIComponentsHintOnOver;
         this.FWindowMakeEquipAdvanced.UIComponentsHintOnOut = UIComponentsHintOnOut;
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
         FOverlayerEquipment = new TOverlayerEquipment(this.Parent,CONST_MODULES.MODULE_TransmigrationTrial);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this.Parent,CONST_MODULES.MODULE_TransmigrationTrial);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this.Parent,CONST_MODULES.MODULE_TransmigrationTrial);
         FOverlayerAppliance.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this.Parent,CONST_MODULES.MODULE_TransmigrationTrial);
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
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         this.FHelpTips = new THint();
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_TransmigrationTrial_help) as TSystemLanguage;
         this.FHelpTips.Content = _loc3_.Desc;
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TransmigrationTrial_Challenge_Ret,this.PACKETID_SC_TransmigrationTrial_Challenge);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TransmigrationTrial_ChangeFragment_Ret,this.PACKETID_SC_TransmigrationTrial_ChangeFragment);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TransmigrationTrial_BaseInfo_Ret,this.PACKETID_SC_TransmigrationTrial_BaseInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TransmigrationTrial_AutoFight_Ret,this.PACKETID_SC_TransmigrationTrial_AutoFight);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TransmigrationTrial_ResetCampaign_Ret,this.PACKETID_SC_TransmigrationTrial_ResetCampaign);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TransmigrationTrial_MakeEquip_Ret,this.PACKETID_SC_TransmigrationTrial_MakeEquip);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TransmigrationTrial_EquipGodCast_Ret,this.PACKETID_SC_TransmigrationTrial_EquipGodCast);
      }
      
      protected function PACKETID_SC_TransmigrationTrial_Challenge(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TEpicEquip_battle = null;
         var _loc6_:TTrialCampaign = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_TransmigrationTrial,0,false,false,false);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
         _loc4_ = _loc2_.readUnsignedInt();
         _loc7_ = _loc2_.readUnsignedInt();
         _loc8_ = _loc2_.readUnsignedInt();
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EpicEquip_battle,_loc4_) as TEpicEquip_battle;
         if(_loc5_ == null)
         {
            return;
         }
         _loc6_ = this.FTransmigrationTrialData.GetTrialCampaignByCampaignId(_loc5_.Location);
         if(_loc6_ != null)
         {
            _loc6_.CurStageId = _loc4_;
         }
         this.FTransmigrationTrialData.ScoreList[_loc7_] += _loc8_;
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_EpicEquip,!this.FTransmigrationTrialData.IsAttacked());
         }
      }
      
      protected function PACKETID_SC_TransmigrationTrial_ChangeFragment(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = _loc2_.readUnsignedInt();
         _loc6_ = _loc2_.readUnsignedInt();
         _loc7_ = _loc2_.readUnsignedInt();
         this.FTransmigrationTrialData.ScoreList[_loc6_] = _loc7_;
         this.FWindowTransmigrationTrial.UpdateChange();
         this.FUIChange.Update();
         EffectGenerateText(STRING_TRANSMIGRATIONTRIAL.STRING_ChangeSuss);
      }
      
      protected function PACKETID_SC_TransmigrationTrial_BaseInfo(param1:TPacket) : void
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
         this.UnstreamizerTransmigrationTrial.Unstreamize(_loc2_,this.FTransmigrationTrialData,null);
         if(Visible)
         {
            this.SetTabVisble(this.FCurTabIndex);
         }
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_EpicEquip,!this.FTransmigrationTrialData.IsAttacked());
         }
      }
      
      protected function PACKETID_SC_TransmigrationTrial_AutoFight(param1:TPacket) : void
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
         var _loc13_:TEpicEquip_battle = null;
         var _loc14_:TTrialCampaign = null;
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
         _loc13_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EpicEquip_battle,_loc12_) as TEpicEquip_battle;
         _loc14_ = this.FTransmigrationTrialData.GetTrialCampaignByCampaignId(_loc13_.Location);
         if(_loc14_ != null)
         {
            _loc14_.CurStageId = _loc12_;
         }
         _loc9_ = TUtilityString.Format(STRING_TRANSMIGRATIONTRIAL.STRING_REWARDINFO,_loc13_.SStageID);
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
            if(_loc15_.Type == 17)
            {
               _loc9_ += STRING_COMMON.GetItemNameByType(_loc15_.Type,_loc15_.ID) + " *" + _loc15_.Count;
               this.FTransmigrationTrialData.ScoreList[_loc15_.ID] += _loc15_.Count;
            }
            else
            {
               _loc10_ = this.FArticleBin.GetDatebaseByIdentifier(CONST_COMMON.GetItemIDByType(_loc15_.Type,_loc15_.ID,this.FArticleBin)) as TArticle;
               _loc9_ += _loc10_.Name + " *" + _loc15_.Count;
            }
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
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_EpicEquip,!this.FTransmigrationTrialData.IsAttacked());
         }
      }
      
      protected function PACKETID_SC_TransmigrationTrial_ResetCampaign(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TTrialCampaign = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = this.FTransmigrationTrialData.GetTrialCampaignByCampaignId(_loc4_);
         if(_loc5_ != null)
         {
            _loc5_.CurStageId = 0;
            ++_loc5_.TodayResetTimes;
         }
         EffectGenerateText(STRING_TRANSMIGRATIONTRIAL.STRING_ResetSuss);
         this.SetTabVisble(this.FCurTabIndex);
      }
      
      protected function PACKETID_SC_TransmigrationTrial_MakeEquip(param1:TPacket) : void
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
         EffectGenerateText(STRING_TRANSMIGRATIONTRIAL.STRING_MakeSuss);
         this.SetTabVisble(this.FCurTabIndex);
      }
      
      protected function PACKETID_SC_TransmigrationTrial_EquipGodCast(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         if(!this.Visible)
         {
            return;
         }
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         EffectGenerateText(STRING_TRANSMIGRATIONTRIAL.STRING_GodCastSuss);
         this.SetTabVisble(this.FCurTabIndex);
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FCurTabIndex = param1 as int;
         this.SetTabVisble(this.FCurTabIndex);
      }
      
      protected function SetTabVisble(param1:int) : void
      {
         this.FWindowTransmigrationTrial.Visible = false;
         this.FWindowMakeEquip.Visible = false;
         this.FWindowMakeEquipAdvanced.Visible = false;
         switch(param1)
         {
            case 0:
               this.FWindowTransmigrationTrial.Visible = true;
               this.FWindowTransmigrationTrial.Update();
               break;
            case 1:
               this.FWindowMakeEquip.Visible = true;
               this.FWindowMakeEquip.Update();
               break;
            case 2:
               this.FWindowMakeEquipAdvanced.Visible = true;
               this.FWindowMakeEquipAdvanced.Update();
               this.FWindowMakeEquipAdvanced.SetSelectContext(this.FSelectContext);
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_TransmigrationTrial);
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
      
      protected function ShowChangeView(param1:Object) : void
      {
         if(this.FUIChange == null)
         {
            this.FUIChange = new TUIChange(this);
            this.FUIChange.SlotsOnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            this.FUIChange.UIComponentsHintOnOver = UIComponentsHintOnOver;
            this.FUIChange.UIComponentsHintOnOut = UIComponentsHintOnOut;
            this.FUIChange.SlotsOnQuerySubscript = this.SlotsOnQuerySubscript;
         }
         this.FUIChange.Update();
         this.FUIChange.Visible = true;
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
         this.FWindowTransmigrationTrial.RoleReset();
         this.FCurTabIndex = 0;
      }
   }
}

