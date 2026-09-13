package Processors.Game.Lobby.NinjaHostel
{
   import Components.ScrollBar.TScrollBar;
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TMilitary;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TInventory;
   import Logics.NinjaHostel.THeroBaseData;
   import Logics.NinjaHostel.TNinjaHostelData;
   import Logics.SLogicsCore;
   import Logics.Streamization.Characters.TUnstreamizerCharacter;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.NinjaHostel.Components.TUIHostelHero;
   import Processors.Game.Lobby.NinjaHostel.Components.TUITeamHero;
   import Processors.Game.Lobby.TacticalDeployment.TDeploymentTip;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_NINJAHOSTEL;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_HEROS;
   import Resources.Strings.STRING_NINJAHOSTEL;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorNinjaHostel extends TProcessorLobbyWindows
   {
      
      protected static const MAX_TAB_COUNT:uint = 4;
      
      protected static const TAB_INDEX_All:uint = 0;
      
      protected static const TAB_INDEX_Front:uint = 1;
      
      protected static const TAB_INDEX_Middle:uint = 2;
      
      protected static const TAB_INDEX_Back:uint = 3;
      
      protected static const STRING_HEROSOUL_NAME:Vector.<String> = Vector.<String>(["","","",STRING_COMMON.ITEMNAME_BlueSoul,STRING_COMMON.ITEMNAME_PurpleSoul,STRING_COMMON.ITEMNAME_GoldenSoul,STRING_COMMON.ITEMNAME_RedSoul]);
      
      protected var FScene:MovieClip;
      
      protected var FUITab:TUITab;
      
      protected var FTabIndex:uint;
      
      protected var FHeroList:Vector.<TUITeamHero>;
      
      protected var FFreeHeroList:Vector.<TUITeamHero>;
      
      protected var FHeroScrollBar:TScrollBar;
      
      protected var FHostelHeroList:Vector.<TUIHostelHero>;
      
      protected var FFreeHostelHeroList:Vector.<TUIHostelHero>;
      
      protected var FHostelHeroScrollBar:TScrollBar;
      
      protected var FHeros:THeros;
      
      protected var FNinjaHostelData:TNinjaHostelData;
      
      protected var FUnstreamizerCharacter:TUnstreamizerCharacter;
      
      protected var FMaxCount:uint;
      
      protected var FMinCount:uint;
      
      protected var FRecallCost:Vector.<Object>;
      
      protected var FLevelOpenCount:Vector.<Object>;
      
      protected var FReturnTeamCost:uint;
      
      protected var FSelectHeroId:uint;
      
      protected var FUIConfirmation:TUIWindowConfirmation;
      
      protected var FReqHeroInfo:Vector.<uint>;
      
      protected var FShowTipsHeroId:uint;
      
      protected var FHeroInfoTip:TDeploymentTip;
      
      protected var FNextOpenLevel:uint;
      
      protected var FNextOpenCount:uint;
      
      protected var FHelpTips:THint;
      
      protected var FOnResetHeros:Function;
      
      protected var FOnTakeBackHero:Function;
      
      public function TProcessorNinjaHostel(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FHeros = SLogicsCore.Character.Heros;
         this.FNinjaHostelData = SLogicsCore.NinjaHostelData;
         this.FUnstreamizerCharacter = new TUnstreamizerCharacter();
         this.FReqHeroInfo = new Vector.<uint>();
         this.FShowTipsHeroId = 0;
         this.FHelpTips = new THint();
         SetUIModuleID(CONST_MODULES.MODULE_NinjaHostel);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_NINJAHOSTEL.RESOURCESID_Swf_NinjaHostel);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TSystemLanguage = null;
         var _loc3_:TConfigValue = null;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_NINJAHOSTEL.RESOURCE_ClassName_NinjaHostel_Main) as MovieClip;
         addChild(this.FScene);
         this.FScene.x = (FUICore.StageWidth - this.FScene.width) / 2;
         this.FScene.y = (FUICore.StageHeight - this.FScene.height) / 2;
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_BTN_Close].addEventListener(MouseEvent.CLICK,this.OnWindowClose);
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_BTN_Help].addEventListener(MouseEvent.MOUSE_OVER,this.ButtonHelpOnOver);
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_BTN_Help].addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
         this.FUITab = new TUITab(this);
         _loc1_ = 0;
         while(_loc1_ < MAX_TAB_COUNT)
         {
            this.FUITab.SetTabByIndex(this.FScene[CONST_NINJAHOSTEL.RESOURCE_Tab_Head + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FHeroList = new Vector.<TUITeamHero>();
         this.FFreeHeroList = new Vector.<TUITeamHero>();
         this.FHeroScrollBar = new TScrollBar(this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_HeroList],365,false);
         this.FHostelHeroList = new Vector.<TUIHostelHero>();
         this.FFreeHostelHeroList = new Vector.<TUIHostelHero>();
         this.FHostelHeroScrollBar = new TScrollBar(this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_HostelHeroList],385,false);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_NinjaHostel) as TSystemLanguage;
         this.FHelpTips.Content = _loc2_.Desc;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaHostel_MaxCount) as TConfigValue;
         this.FMaxCount = _loc3_.Value as uint;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaHostel_MinCount) as TConfigValue;
         this.FMinCount = _loc3_.Value as uint;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaHostel_RecallCost) as TConfigValue;
         this.FRecallCost = _loc3_.Value as Vector.<Object>;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaHostel_LevelOpenCount) as TConfigValue;
         this.FLevelOpenCount = _loc3_.Value as Vector.<Object>;
         this.FUIConfirmation = new TUIWindowConfirmation(this.Parent);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIConfirmation);
         this.FUIConfirmation.x = (FUICore.StageWidth - this.FUIConfirmation.WindowWidth) / 2;
         this.FUIConfirmation.y = (FUICore.StageHeight - this.FUIConfirmation.WindowHeight) / 2;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         this.FHeroInfoTip = new TDeploymentTip(this.Parent);
         this.FHeroInfoTip.Visible = false;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         super.LogicsPerform();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         if(!Visible)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FHeroList.length)
         {
            this.FHeroList[_loc1_].UpdateHead();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FHostelHeroList.length)
         {
            this.FHostelHeroList[_loc1_].UpdateHead();
            _loc1_++;
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaHostel_Init_Ret,this.PacketPerform_SC_InitRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaHostel_HeroInfo_Ret,this.PacketPerform_SC_HeroInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaHostel_HeroStatus_Ret,this.PacketPerform_SC_HeroStatusRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaHostel_DeleteHero_Ret,this.PacketPerform_SC_DeleteHeroRet);
         super.PacketRegisterRoutines();
      }
      
      protected function PacketPerform_SC_InitRet(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc4_ = param1.Data;
         _loc5_ = _loc4_.readUnsignedInt();
         if(_loc5_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc5_);
            return;
         }
         this.FNinjaHostelData.MaxTabCount = _loc4_.readUnsignedInt();
         _loc3_ = _loc4_.readUnsignedShort();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = _loc4_.readUnsignedInt();
            _loc7_ = _loc4_.readUnsignedInt();
            this.FNinjaHostelData.AddHeroBase(_loc6_,_loc7_);
            _loc2_++;
         }
         this.FNinjaHostelData.CommonItem = _loc4_.readUnsignedInt();
         if(FIsResourcesLoadCompleted)
         {
            this.ResetHostelHeroList();
            this.UpdataHostelHeroList();
         }
      }
      
      protected function PacketPerform_SC_HeroInfoRet(param1:TPacket) : void
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
         _loc4_ = this.FUnstreamizerCharacter.UnstreamizeHero(_loc2_,null,null);
         this.FNinjaHostelData.HostelHeros.Add(_loc4_);
         if(FIsResourcesLoadCompleted && this.FShowTipsHeroId == _loc4_.Identifier)
         {
            this.FHeroInfoTip.SetHeroData(_loc4_);
            this.FHeroInfoTip.Visible = true;
         }
      }
      
      protected function PacketPerform_SC_HeroStatusRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:THero = null;
         _loc2_ = param1.Data;
         _loc5_ = _loc2_.readUnsignedInt();
         if(_loc5_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc5_);
            if(this.FOnResetHeros != null)
            {
               this.FOnResetHeros(this);
            }
            return;
         }
         _loc3_ = _loc2_.readUnsignedInt();
         _loc4_ = _loc2_.readUnsignedInt();
         this.FNinjaHostelData.CommonItem = _loc2_.readUnsignedInt();
         if(_loc4_ == 1)
         {
            _loc6_ = this.FHeros.GetHeroByIdentifier(_loc3_);
            if(_loc6_ != null)
            {
               this.FHeros.Delete(_loc6_);
               this.FNinjaHostelData.AddHeroBase(_loc6_.Identifier,_loc6_.Level);
               this.FNinjaHostelData.AddHeroInfo(_loc6_);
            }
            if(this.FOnResetHeros != null)
            {
               this.FOnResetHeros(this);
            }
         }
         else if(_loc4_ == 2)
         {
            this.FNinjaHostelData.DeleteHeroBase(_loc3_);
            _loc6_ = this.FNinjaHostelData.GetHeroInfoById(_loc3_);
            if(_loc6_ != null)
            {
               this.FNinjaHostelData.DeleteHeroInfo(_loc6_);
               SLogicsCore.Character.Heros.Add(_loc6_);
               SLogicsCore.Character.Heros.Sort();
            }
            this.HeroDataReq();
         }
         if(FIsResourcesLoadCompleted)
         {
            this.ResetHeroList();
            this.UpdataHeroList();
            this.ResetHostelHeroList();
            this.UpdataHostelHeroList();
         }
         if(this.FOnTakeBackHero != null)
         {
            this.FOnTakeBackHero(this);
         }
      }
      
      protected function PacketPerform_SC_DeleteHeroRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:THero = null;
         _loc2_ = param1.Data;
         _loc4_ = _loc2_.readUnsignedInt();
         if(_loc4_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc4_);
            return;
         }
         _loc3_ = _loc2_.readUnsignedInt();
         this.FNinjaHostelData.DeleteHeroBase(_loc3_);
         _loc5_ = this.FNinjaHostelData.GetHeroInfoById(_loc3_);
         if(_loc5_ != null)
         {
            this.FNinjaHostelData.DeleteHeroInfo(_loc5_);
         }
         this.ResetHostelHeroList();
         this.UpdataHostelHeroList();
         EffectGenerateText(STRING_NINJAHOSTEL.STRING_DeleteHeroSussect);
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = 0;
         _loc2_ = param1 as int;
         if(_loc2_ == this.FTabIndex)
         {
            return;
         }
         this.FTabIndex = _loc2_;
         switch(this.FTabIndex)
         {
            case TAB_INDEX_All:
            case TAB_INDEX_Front:
            case TAB_INDEX_Middle:
            case TAB_INDEX_Back:
         }
         this.FilterHostelHeros(this.FTabIndex);
      }
      
      protected function FilterHostelHeros(param1:uint) : void
      {
         this.FNinjaHostelData.SetFilterStatus(param1);
         this.ResetHostelHeroList();
         this.UpdataHostelHeroList();
      }
      
      protected function ResetHeroList() : void
      {
         var _loc1_:int = 0;
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FHeroScrollBar.Clear();
         while(this.FHeroList.length)
         {
            this.FFreeHeroList.push(this.FHeroList.pop());
         }
      }
      
      protected function ResetHostelHeroList() : void
      {
         var _loc1_:int = 0;
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FHostelHeroScrollBar.Clear();
         while(this.FHostelHeroList.length)
         {
            this.FFreeHostelHeroList.push(this.FHostelHeroList.pop());
         }
      }
      
      protected function UpdataHeroList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUITeamHero = null;
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FHeros.Count)
         {
            _loc2_ = this.GetUITeamHero();
            this.FHeroScrollBar.AddItem(_loc2_);
            _loc2_.SetHeroInfo(this.FHeros.GetHeroByIndex(_loc1_));
            _loc2_.x = TUITeamHero.SceneWidth * (_loc1_ % 2);
            _loc2_.y = TUITeamHero.SceneHeight * int(_loc1_ / 2);
            if(_loc1_ == 0)
            {
               _loc2_.CantLeave();
            }
            this.FHeroList.push(_loc2_);
            _loc1_++;
         }
      }
      
      protected function UpdataHostelHeroList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIHostelHero = null;
         var _loc4_:Vector.<THeroBaseData> = null;
         var _loc5_:uint = 0;
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FNinjaHostelData.SortHeroBase();
         _loc4_ = this.FNinjaHostelData.FilterHeros();
         _loc5_ = this.GetCurSlotCount();
         _loc2_ = Math.min(_loc4_.length,_loc5_);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.GetUIHostelHero();
            this.FHostelHeroScrollBar.AddItem(_loc3_);
            _loc3_.SetHero(_loc4_[_loc1_]);
            _loc3_.x = TUIHostelHero.SceneWidth * (_loc1_ % 6);
            _loc3_.y = TUIHostelHero.SceneHeight * int(_loc1_ / 6);
            this.FHostelHeroList.push(_loc3_);
            _loc1_++;
         }
         if(this.FTabIndex != 0)
         {
            return;
         }
         _loc2_ = _loc5_;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.GetUIHostelHero();
            this.FHostelHeroScrollBar.AddItem(_loc3_);
            _loc3_.SetHero(null);
            _loc3_.x = TUIHostelHero.SceneWidth * (_loc1_ % 6);
            _loc3_.y = TUIHostelHero.SceneHeight * int(_loc1_ / 6);
            this.FHostelHeroList.push(_loc3_);
            _loc1_++;
         }
         var _loc6_:uint = 0;
         while(_loc1_ < this.FMaxCount)
         {
            _loc3_ = this.GetUIHostelHero();
            this.FHostelHeroScrollBar.AddItem(_loc3_);
            if(_loc6_ < this.FNextOpenCount)
            {
               _loc3_.SetLock(true,this.FNextOpenLevel);
            }
            else
            {
               _loc3_.SetLock();
            }
            _loc3_.x = TUIHostelHero.SceneWidth * (_loc1_ % 6);
            _loc3_.y = TUIHostelHero.SceneHeight * int(_loc1_ / 6);
            this.FHostelHeroList.push(_loc3_);
            _loc6_++;
            _loc1_++;
         }
         if(this.FScene.MC_Item)
         {
            this.FScene.MC_Item.TF_Count.text = this.FNinjaHostelData.CommonItem.toString();
         }
      }
      
      protected function GetCurSlotCount() : uint
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc5_ = 0;
         _loc3_ = this.FNinjaHostelData.MaxTabCount + SLogicsCore.Character.VipData.AddNinjaHostel;
         _loc4_ = uint(SLogicsCore.Character.GetMainLevel());
         this.FNextOpenLevel = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FLevelOpenCount.length)
         {
            if(_loc4_ < this.FLevelOpenCount[_loc1_][0])
            {
               this.FNextOpenLevel = this.FLevelOpenCount[_loc1_][0];
               this.FNextOpenCount = this.FLevelOpenCount[_loc1_][2];
               break;
            }
            _loc5_ = uint(this.FLevelOpenCount[_loc1_][1]);
            _loc1_++;
         }
         return _loc3_ + _loc5_ + this.FMinCount;
      }
      
      protected function HostelIsFull() : Boolean
      {
         return this.GetCurSlotCount() <= this.FNinjaHostelData.HostelHeroCount;
      }
      
      protected function TeamIsFull() : Boolean
      {
         var _loc1_:uint = 0;
         var _loc2_:TMilitary = null;
         var _loc3_:uint = 0;
         _loc1_ = uint(SLogicsCore.Character.Heros.Count);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Military,SLogicsCore.Character.MilitaryRank) as TMilitary;
         _loc3_ = _loc2_ == null ? 5 : uint(_loc2_.MaxHeroNum);
         _loc3_ += SLogicsCore.Character.BuyHeroSlot;
         return _loc1_ >= _loc3_;
      }
      
      protected function GetUITeamHero() : TUITeamHero
      {
         var _loc1_:TUITeamHero = null;
         if(this.FFreeHeroList.length != 0)
         {
            _loc1_ = this.FFreeHeroList.pop();
         }
         else
         {
            _loc1_ = new TUITeamHero(this);
            _loc1_.HeroLeaveTeam = this.OnHeroLeaveTeam;
            _loc1_.ShowHeroTip = this.OnShowHeroTip;
            _loc1_.HideHeroTip = this.OnHideHeroTip;
         }
         return _loc1_;
      }
      
      protected function GetUIHostelHero() : TUIHostelHero
      {
         var _loc1_:TUIHostelHero = null;
         if(this.FFreeHostelHeroList.length != 0)
         {
            _loc1_ = this.FFreeHostelHeroList.pop();
         }
         else
         {
            _loc1_ = new TUIHostelHero(this);
            _loc1_.HeroReturnTeam = this.OnHeroReturnTeam;
            _loc1_.HeroDismissal = this.OnHeroDismissal;
            _loc1_.ShowHeroTip = this.OnShowHeroTip;
            _loc1_.HideHeroTip = this.OnHideHeroTip;
         }
         return _loc1_;
      }
      
      protected function OnHeroLeaveTeam(param1:Object, param2:uint) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TBaseHero = null;
         if(param2 == 0)
         {
            return;
         }
         if(this.HostelIsFull())
         {
            EffectGenerateText(STRING_NINJAHOSTEL.STRING_HostelIsFull);
            return;
         }
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,param2) as TBaseHero;
         _loc4_ = this.FRecallCost.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(this.FRecallCost[_loc3_][0] == _loc5_.Quality)
            {
               this.FReturnTeamCost = this.FRecallCost[_loc3_][1];
               break;
            }
            _loc3_++;
         }
         this.FSelectHeroId = param2;
         this.FUIConfirmation.Text = TUtilityString.Format(STRING_NINJAHOSTEL.STRING_SureLeaveTeam,_loc5_.Name,this.FReturnTeamCost);
         this.FUIConfirmation.visible = true;
         this.FUIConfirmation.OnOK = this.OnSureHeroLeaveTeam;
      }
      
      protected function OnSureHeroLeaveTeam(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:THero = null;
         _loc4_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(this.FSelectHeroId);
         if(this.CheckEquipMentsMounted(_loc4_))
         {
            EffectGenerateText(STRING_HEROS.STRING_StripEquipment);
            return;
         }
         if(this.CheckTalismanMounted(_loc4_))
         {
            EffectGenerateText(STRING_HEROS.STRING_StripAdder);
            return;
         }
         if(this.CheckAccessoryMounted(_loc4_))
         {
            EffectGenerateText(STRING_HEROS.STRING_StripAdderAccessory);
            return;
         }
         if(this.CheckBloodFeteMounted(_loc4_))
         {
            EffectGenerateText(STRING_HEROS.STRING_StripBloodFete);
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjaHostel_HeroStatus_Req);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FSelectHeroId);
         _loc3_.writeUnsignedInt(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         if(this.FTabIndex != 0)
         {
            this.TabOnSwitch(0);
            this.FUITab.TabIndex = 0;
         }
      }
      
      protected function OnHeroReturnTeam(param1:Object, param2:uint, param3:uint) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TPacket = null;
         var _loc7_:ByteArray = null;
         var _loc8_:TBaseHero = null;
         if(param2 == 0)
         {
            return;
         }
         if(this.TeamIsFull())
         {
            EffectGenerateText(STRING_NINJAHOSTEL.STRING_TeamIsFull);
            return;
         }
         if(this.FReqHeroInfo.indexOf(param2) < 0)
         {
            this.FReqHeroInfo.push(param2);
            _loc6_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjaHostel_HeroInfo_Req);
            _loc7_ = _loc6_.Data;
            _loc7_.writeUnsignedInt(param2);
            SNetworkCore.Transceiver.PacketTransmit(_loc6_);
         }
         _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,param2) as TBaseHero;
         _loc5_ = this.FRecallCost.length;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            if(this.FRecallCost[_loc4_][0] == _loc8_.Quality)
            {
               this.FReturnTeamCost = this.FRecallCost[_loc4_][1];
               break;
            }
            _loc4_++;
         }
         this.FSelectHeroId = param2;
         if(_loc8_.Quality >= 5 && this.FNinjaHostelData.CommonItem > 0)
         {
            this.FReturnTeamCost = 0;
            this.FUIConfirmation.Text = TUtilityString.Format(STRING_NINJAHOSTEL.STRING_UseCommonItem,_loc8_.Name);
         }
         else
         {
            this.FUIConfirmation.Text = TUtilityString.Format(STRING_NINJAHOSTEL.STRING_SureReturnTeam,this.FReturnTeamCost,_loc8_.Name);
         }
         this.FUIConfirmation.visible = true;
         this.FUIConfirmation.OnOK = this.OnSureHeroReturnTeam;
      }
      
      protected function OnSureHeroReturnTeam(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(SLogicsCore.Character.CreditGold + SLogicsCore.Character.CreditGiftCertificate < this.FReturnTeamCost)
         {
            EffectGenerateText(STRING_COMMON.NOTENOUGH_Gold);
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjaHostel_HeroStatus_Req);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FSelectHeroId);
         _loc3_.writeUnsignedInt(2);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnHeroDismissal(param1:Object, param2:uint) : void
      {
         var _loc3_:TBaseHero = null;
         var _loc4_:Array = null;
         if(param2 == 0)
         {
            return;
         }
         this.FSelectHeroId = param2;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,param2) as TBaseHero;
         if(_loc3_.HeroSoul == "0" || _loc3_.HeroSoul == "0.0")
         {
            this.FUIConfirmation.Text = TUtilityString.Format(STRING_NINJAHOSTEL.STRING_SureDismissal0,_loc3_.Name);
         }
         else
         {
            _loc4_ = _loc3_.HeroSoul.split("_");
            this.FUIConfirmation.Text = TUtilityString.Format(STRING_NINJAHOSTEL.STRING_SureDismissal1,_loc3_.Name,_loc4_[1],STRING_HEROSOUL_NAME[_loc4_[0]]);
         }
         this.FUIConfirmation.visible = true;
         this.FUIConfirmation.OnOK = this.OnSureHeroDismissal;
      }
      
      protected function OnSureHeroDismissal(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjaHostel_DeleteHero_Req);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FSelectHeroId);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnShowHeroTip(param1:Object, param2:uint, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         var _loc6_:THero = null;
         if(param3 == 0)
         {
            return;
         }
         this.FShowTipsHeroId = param3;
         if(param2 == 1)
         {
            _loc6_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(param3);
            this.FHeroInfoTip.SetHeroData(_loc6_);
         }
         else if(param2 == 2)
         {
            if(this.FReqHeroInfo.indexOf(param3) < 0)
            {
               this.FReqHeroInfo.push(param3);
               _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjaHostel_HeroInfo_Req);
               _loc5_ = _loc4_.Data;
               _loc5_.writeUnsignedInt(param3);
               SNetworkCore.Transceiver.PacketTransmit(_loc4_);
               return;
            }
            _loc6_ = this.FNinjaHostelData.HostelHeros.GetHeroByIdentifier(param3);
            if(_loc6_ == null)
            {
               return;
            }
            this.FHeroInfoTip.SetHeroData(_loc6_);
         }
         this.FHeroInfoTip.Visible = true;
      }
      
      protected function OnHideHeroTip(param1:Object) : void
      {
         this.FShowTipsHeroId = 0;
         this.FHeroInfoTip.Visible = false;
      }
      
      protected function CheckEquipMentsMounted(param1:THero) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = uint(param1.EquipmentsMounted.Capacity);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.EquipmentsMounted.GetInventoryByIndex(_loc3_);
            if(_loc4_ != null)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function CheckTalismanMounted(param1:THero) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = uint(param1.TalismansMounted.Capacity);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.TalismansMounted.GetInventoryByIndex(_loc3_);
            if(_loc4_ != null)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function CheckAccessoryMounted(param1:THero) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = uint(param1.AccessoryMounted.Capacity);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.AccessoryMounted.GetInventoryByIndex(_loc3_);
            if(_loc4_ != null)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function CheckBloodFeteMounted(param1:THero) : Boolean
      {
         var _loc2_:uint = 0;
         _loc2_ = param1.BloodFeteMounted.length;
         if(_loc2_ > 0)
         {
            return true;
         }
         return false;
      }
      
      protected function HeroDataReq() : void
      {
      }
      
      protected function OnWindowClose(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         FOverlayerHelpTips.Context = this.FHelpTips;
         FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         FOverlayerHelpTips.Show();
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         FOverlayerHelpTips.Hide();
      }
      
      public function get OnResetHeros() : Function
      {
         return this.FOnResetHeros;
      }
      
      public function set OnResetHeros(param1:Function) : void
      {
         this.FOnResetHeros = param1;
      }
      
      public function get OnTakeBackHero() : Function
      {
         return this.FOnTakeBackHero;
      }
      
      public function set OnTakeBackHero(param1:Function) : void
      {
         this.FOnTakeBackHero = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.ResetHeroList();
         this.UpdataHeroList();
         this.ResetHostelHeroList();
         this.UpdataHostelHeroList();
      }
   }
}

