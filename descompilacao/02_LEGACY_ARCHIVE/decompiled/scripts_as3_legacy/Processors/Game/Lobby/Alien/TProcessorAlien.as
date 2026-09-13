package Processors.Game.Lobby.Alien
{
   import Components.Standard.TUITab;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
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
   import Logics.Alien.TAlien;
   import Logics.Alien.TAlienData;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.SLogicsCore;
   import Logics.Streamization.Alien.TUnstreamizerAlien;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Components.TUIHero;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Processors.Game.Windows.Information.TUIWindowBattleSkip;
   import Resources.Constants.CONST_ALIEN;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorAlien extends TProcessorLobbyWindows
   {
      
      protected var FUITab:TUITab;
      
      protected var FMc_tab:MovieClip;
      
      protected var FMCScene:MovieClip;
      
      protected var FTabGroup:TUITab;
      
      protected var FMapImage:Bitmap;
      
      protected var FT_Count:TextField;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FBtn_Saodang:MovieClip;
      
      protected var FBtn_Show:MovieClip;
      
      protected var FUIHero:TUIHero;
      
      protected var FMC_Hero:Sprite;
      
      protected var FT_NeedNum:TextField;
      
      protected var FT_Unlock:TextField;
      
      protected var FBtn_Ninja:MovieClip;
      
      protected var FBtn_jihuo:MovieClip;
      
      protected var FT_ItemName:TextField;
      
      protected var BTN_Sweep:MovieClip;
      
      protected var FTabIndex:int = -1;
      
      protected var FGroupIndex:int;
      
      protected var FprocessorAlinePanel:TProcessorAlienCapture;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FUIWindowBattleSkip:TUIWindowBattleSkip;
      
      protected var FIdentifier:int;
      
      protected var FUnstreamizerAlien:TUnstreamizerAlien;
      
      protected var FAlienData:TAlienData;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FGotoNinjaFun:Function;
      
      public function TProcessorAlien(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUITab = new TUITab(this);
         this.FTabGroup = new TUITab(this);
         this.FprocessorAlinePanel = new TProcessorAlienCapture(this);
         this.FprocessorAlinePanel.ClickFun = this.OnHandleClick;
         this.FprocessorAlinePanel.OverFun = this.OnHandleOver;
         this.FprocessorAlinePanel.OutFun = this.OnHandleOut;
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (stage.stageWidth - 390) / 2;
         this.FProcessorWindowRecruit.y = (stage.stageHeight - 358) / 2;
         this.FProcessorWindowRecruit.Load();
         this.FUnstreamizerAlien = new TUnstreamizerAlien();
         this.FAlienData = new TAlienData();
         SetUIModuleID(CONST_MODULES.MODULE_Alien);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_ALIEN.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:MovieClip = null;
         this.FMCScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_ALIEN.RESOURCE_ClassName_Alien) as MovieClip;
         addChild(this.FMCScene);
         this.FMapImage = new Bitmap();
         this.FMCScene.addChildAt(this.FMapImage,this.FMCScene.numChildren - 3);
         this.FMapImage.x = 183;
         this.FMapImage.y = 89;
         this.FMCScene.addChild(this.FprocessorAlinePanel);
         this.FprocessorAlinePanel.x = 183;
         this.FprocessorAlinePanel.y = 89;
         this.FMc_tab = this.FMCScene[CONST_ALIEN.RESOURCES_Tab_Component];
         this.FBtn_Close = this.FMCScene[CONST_ALIEN.RESOURCE_Link_Btn_Close];
         this.FBtn_Help = this.FMCScene[CONST_ALIEN.RESOURCE_Link_Btn_Help];
         this.FBtn_Saodang = this.FMCScene[CONST_ALIEN.RESOURCE_Link_Btn_Saodang];
         TGameUtil.setButtonMode(this.FBtn_Saodang,true);
         this.FBtn_Show = this.FMCScene[CONST_ALIEN.RESOURCE_Link_Btn_Show];
         TGameUtil.setButtonMode(this.FBtn_Show,true);
         this.FBtn_Ninja = this.FMCScene[CONST_ALIEN.RESOURCE_Link_Btn_Ninja];
         TGameUtil.setButtonMode(this.FBtn_Ninja,true);
         this.FBtn_jihuo = this.FMCScene[CONST_ALIEN.RESOURCE_Link_Btn_Jihuo];
         TGameUtil.setButtonMode(this.FBtn_jihuo,true);
         this.BTN_Sweep = this.FMCScene[CONST_ALIEN.RESOURCE_Link_BTN_Sweep];
         TGameUtil.setButtonMode(this.BTN_Sweep,true);
         this.FT_NeedNum = this.FMCScene[CONST_ALIEN.RESOURCE_Link_TF_NeedNum];
         this.FT_Count = this.FMCScene[CONST_ALIEN.RESOURCE_Link_TF_Count];
         this.FT_ItemName = this.FMCScene[CONST_ALIEN.RESOURCE_Link_TF_ItenName];
         this.FT_Unlock = this.FMCScene[CONST_ALIEN.RESOURCE_Link_TF_Unlock];
         this.FT_Unlock.visible = false;
         var _loc2_:int = 0;
         while(_loc2_ < CONST_ALIEN.CAPACITY_MC_Tabs)
         {
            _loc1_ = this.FMc_tab[CONST_ALIEN.RESOURCES_MC_Tab_ + _loc2_];
            this.FUITab.SetTabByIndex(_loc1_,_loc2_);
            _loc2_++;
         }
         this.FUITab.TabIndex = 1;
         this.FUITab.OnSwitch = this.OnTabSwitch;
         this.FUITab.SwithTagManual(0);
         this.FUITab.Init();
         this.FMc_tab = this.FMCScene["MC_Tab_Junior"];
         this.FTabGroup.SetTabByIndex(this.FMc_tab,0);
         this.FMc_tab = this.FMCScene["MC_Tab_Senior"];
         this.FTabGroup.SetTabByIndex(this.FMc_tab,1);
         this.FTabGroup.OnSwitch = this.OnClickTabGroup;
         this.FTabGroup.Init();
         this.FUIHero = new TUIHero(this);
         this.FMC_Hero = this.FMCScene[CONST_ALIEN.RESOURCE_Link_MC_Hero];
         this.FMC_Hero.addChild(this.FUIHero);
         this.FUIHero.OnQuerySequenceContext = this.HeroOnQuerySequenceContext;
         this.FUIHero.DefaultRole = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as Sprite;
         this.FUIWindowBattleSkip = new TUIWindowBattleSkip(this.Parent);
         this.FUIWindowBattleSkip.Perform_UIDispatch();
         this.FUIWindowBattleSkip.OnOK = this.OnConfirmationOk;
         this.FUIWindowBattleSkip.OnCancel = this.OnWindowCancel;
         this.x = stage.stageWidth - this.width >> 1;
         this.y = stage.stageHeight - this.height >> 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.OnWindowClose);
         this.FBtn_Saodang.addEventListener(MouseEvent.CLICK,this.OnClickSaodang);
         this.FBtn_Show.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowRecruit);
         this.FBtn_Ninja.addEventListener(MouseEvent.CLICK,this.OnClickGotoNinja);
         this.FBtn_jihuo.addEventListener(MouseEvent.CLICK,this.OnClickBtnJihuo);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.BTN_Sweep.addEventListener(MouseEvent.CLICK,this.OnClickSweep);
         this.FUnstreamizerAlien.UnstreamizeByDatabase(null,this.FAlienData,null);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Plane_LoadRet,this.PerformPacket_SC_Plane_LoadRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Plane_FightRet,this.PerformPacket_SC_Plane_FightRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Plane_CleanRet,this.PerformPacket_SC_Plane_CleanRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Plane_ExchangeRet,this.PerformPacket_SC_Plane_ExchangeRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Plane_AllCleanRet,this.PerformPacket_SC_Plane_AllCleanRet);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.PerformPacket_CS_Plane_Load_Req();
      }
      
      protected function PerformPacket_SC_Plane_LoadRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc4_:TAlien = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerAlien.Unstreamize(_loc2_,this.FAlienData,null);
         this.UpdateHeroInfoByTabIndex(this.FGroupIndex,this.FTabIndex + 1);
         var _loc3_:int = 0;
         while(_loc3_ < CONST_ALIEN.CAPACITY_MC_Tabs)
         {
            _loc4_ = this.FAlienData.GetAlienHerosByLevel(_loc3_ + 1);
            this.FUITab.SetTabCaptionByIndex(_loc4_.NameTotal,_loc3_);
            _loc3_++;
         }
      }
      
      protected function PerformPacket_SC_Plane_FightRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         var _loc4_:int = int(_loc2_.readUnsignedInt());
         var _loc5_:int = int(_loc2_.readUnsignedInt());
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_Alien,0);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
      }
      
      protected function PerformPacket_SC_Plane_ExchangeRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         EffectGenerateText(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.ALIEN_STRING_01));
      }
      
      protected function PerformPacket_SC_Plane_AllCleanRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerAlien.UnStreamizationPerformByAllSanDang(_loc2_,this.FAlienData,null);
         this.UpdateHeroInfoByTabIndex(this.FGroupIndex,this.FTabIndex + 1);
         EffectGenerateText(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.ALIEN_STRING_03));
      }
      
      protected function PerformPacket_SC_Plane_CleanRet(param1:TPacket) : void
      {
         var _loc2_:Boolean = this.CheckCanSaoDangByLevel(this.FTabIndex + 1 + this.FGroupIndex * CONST_ALIEN.CAPACITY_MC_Tabs);
         if(!_loc2_)
         {
            EffectGenerateText(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.ALIEN_STRING_02));
            return;
         }
         var _loc3_:ByteArray = param1.Data;
         var _loc4_:int = _loc3_.readInt();
         if(_loc4_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc4_);
            return;
         }
         var _loc5_:int = int(_loc3_.readUnsignedInt());
         this.FUnstreamizerAlien.UnstreamizationPerformBySaoDang(null,this.FAlienData,_loc5_);
         this.UpdateHeroInfoByTabIndex(0,_loc5_);
         EffectGenerateText(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.ALIEN_STRING_03));
      }
      
      protected function PerformPacket_CS_Plane_Load_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Plane_LoadReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_Plane_Fight_Req(param1:int) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Plane_FightReq);
         _loc2_.Data.writeInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_CS_Plane_CleanReq(param1:int) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Plane_CleanReq);
         _loc2_.Data.writeInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_CS_Plane_AllCleanReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Plane_AllCleanReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_plane_Exchange_Req(param1:int) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Plane_ExchangeReq);
         _loc2_.Data.writeInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function HeroOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:int = 0;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         var _loc8_:TBounds = null;
         var _loc9_:TCoordinate = null;
         var _loc10_:TRoleModel = null;
         _loc5_ = param2 as int;
         _loc8_ = new TBounds();
         _loc9_ = new TCoordinate();
         _loc6_ = SResourcesCore.TexturesModel;
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc5_) as TRoleModel;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc10_.Model);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIndex(0);
            param3.Value.Evaluate(_loc9_,_loc8_);
            this.FUIHero.X = _loc8_.X;
            this.FUIHero.Y = _loc8_.Y;
         }
         else
         {
            _loc6_.LoadSecondary(_loc10_.Model,CONST_MODULES.MODULE_Heros);
            this.FUIHero.X = 0;
            this.FUIHero.Y = 0;
         }
      }
      
      override protected function LogicsPerform() : void
      {
         if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
         {
            this.FProcessorWindowRecruit.UpdataBitmap();
         }
         if(this.FUIHero)
         {
            this.FUIHero.Update();
         }
         super.LogicsPerform();
      }
      
      private function OnClickTabGroup(param1:int) : void
      {
         var _loc3_:TAlien = null;
         this.FGroupIndex = param1;
         this.UpdateHeroInfoByTabIndex(this.FGroupIndex,this.FTabIndex + 1);
         var _loc2_:int = 0;
         while(_loc2_ < CONST_ALIEN.CAPACITY_MC_Tabs)
         {
            _loc3_ = this.FAlienData.GetAlienHerosByLevel(_loc2_ + 1 + param1 * CONST_ALIEN.CAPACITY_MC_Tabs);
            this.FUITab.SetTabCaptionByIndex(_loc3_.NameTotal,_loc2_);
            _loc2_++;
         }
      }
      
      private function OnTabSwitch(param1:int) : void
      {
         if(this.FTabIndex == param1)
         {
            return;
         }
         this.FTabIndex = param1;
         this.FMapImage.bitmapData = TUtilityReflection.CreateInstance(CONST_ALIEN.RESOURCE_ALIEN_MAP_ + ++param1) as BitmapData;
         this.FprocessorAlinePanel.CaptureIndex = param1;
         this.UpdateHeroInfoByTabIndex(this.FGroupIndex,param1);
      }
      
      private function UpdateHeroInfoByTabIndex(param1:int, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:Boolean = false;
         var _loc8_:Object = null;
         var _loc3_:int = param2 + param1 * CONST_ALIEN.CAPACITY_MC_Tabs;
         var _loc4_:Vector.<TAlien> = this.FAlienData.GetTAliensByLevel(_loc3_);
         this.FprocessorAlinePanel.setAlienCatureInfo(_loc4_);
         var _loc9_:TAlien = this.FAlienData.GetAlienHerosByLevel(_loc3_);
         if(_loc9_)
         {
            _loc8_ = _loc9_.Heros;
            this.FUIHero.Context = _loc8_.hero[0];
            this.FT_NeedNum.text = _loc6_ = _loc8_.hero[1];
            _loc5_ = int(SLogicsCore.Character.Appliances.GetAllCountByTempletID(_loc8_.hero[2]));
            this.FT_Count.text = _loc5_.toString();
            this.FT_ItemName.text = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc8_.hero[2]) as TArticle).Name + "：";
            this.FT_Count.x = this.FT_ItemName.x + this.FT_ItemName.textWidth + 5;
            _loc7_ = this.CheckPassConditionByLevel(_loc3_);
            this.FBtn_jihuo.visible = _loc7_ && this.FGroupIndex == 0;
            this.FT_Unlock.visible = !_loc7_ && this.FGroupIndex == 0;
         }
      }
      
      private function CheckCanSaoDangByLevel(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TAlien = null;
         var _loc2_:Boolean = false;
         var _loc3_:Vector.<TAlien> = this.FAlienData.GetTAliensByLevel(param1);
         _loc5_ = _loc3_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc3_[_loc4_];
            if(_loc6_.Status == 2 && _loc6_.IsBattled)
            {
               _loc2_ = true;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function CheckPassConditionByLevel(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TAlien = null;
         var _loc2_:Boolean = true;
         var _loc3_:Vector.<TAlien> = this.FAlienData.GetTAliensByLevel(param1);
         _loc5_ = _loc3_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc3_[_loc4_];
            if(_loc6_.Status != 1)
            {
               _loc2_ = false;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function OnHandleClick(param1:int) : void
      {
         this.FIdentifier = param1;
         if(!this.FUIWindowBattleSkip.IsSelected)
         {
            this.FUIWindowBattleSkip.Visible = true;
         }
         else
         {
            this.PerformPacket_CS_Plane_Fight_Req(param1);
         }
      }
      
      private function OnHandleOver() : void
      {
         var _loc1_:THint = new THint();
         if(UIHelpTipsHintOnOver != null)
         {
         }
      }
      
      private function OnHandleOut() : void
      {
         if(UIHelpTipsHintOnOut != null)
         {
            UIHelpTipsHintOnOut(this);
         }
      }
      
      private function OnClickSaodang(param1:MouseEvent) : void
      {
         this.PerformPacket_CS_Plane_CleanReq(this.FTabIndex + 1 + this.FGroupIndex * CONST_ALIEN.CAPACITY_MC_Tabs);
      }
      
      private function OnClickGotoNinja(param1:MouseEvent) : void
      {
         if(this.GotoNinjaFun != null)
         {
            this.GotoNinjaFun();
         }
      }
      
      private function OnClickBtnJihuo(param1:MouseEvent) : void
      {
         var _loc2_:TAlien = this.FAlienData.GetAlienHerosByLevel(this.FTabIndex + 1);
         this.PerformPacket_CS_plane_Exchange_Req(_loc2_.Id);
      }
      
      private function ProcessorOnShowRecruit(param1:MouseEvent) : void
      {
         var _loc3_:Object = null;
         var _loc2_:TAlien = this.FAlienData.GetAlienHerosByLevel(this.FTabIndex + 1);
         if(_loc2_)
         {
            _loc3_ = _loc2_.Heros;
            this.FProcessorWindowRecruit.SetHeroData(_loc3_.hero[0]);
         }
      }
      
      private function OnClickSweep(param1:MouseEvent) : void
      {
         this.PerformPacket_CS_Plane_AllCleanReq();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:THint = new THint();
         if(UIHelpTipsHintOnOver != null)
         {
            _loc2_.Content = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.HELPTIPS_70170114);
            UIHelpTipsHintOnOver(this,_loc2_);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(UIHelpTipsHintOnOut != null)
         {
            UIHelpTipsHintOnOut(this);
         }
      }
      
      private function OnWindowClose(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function OnConfirmationOk(param1:Object) : void
      {
         this.FUIWindowBattleSkip.SetBattleSkipStatus(true,CONST_BATTLE.BattleType_Alien);
         this.PerformPacket_CS_Plane_Fight_Req(this.FIdentifier);
      }
      
      protected function OnWindowCancel(param1:Object) : void
      {
         this.FUIWindowBattleSkip.SetBattleSkipStatus(false,CONST_BATTLE.BattleType_Alien);
         this.PerformPacket_CS_Plane_Fight_Req(this.FIdentifier);
      }
      
      public function get OnInitBattle() : Function
      {
         return this.FOnInitBattle;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      public function get SetStatusType() : Function
      {
         return this.FSetStatusType;
      }
      
      public function get GotoNinjaFun() : Function
      {
         return this.FGotoNinjaFun;
      }
      
      public function set GotoNinjaFun(param1:Function) : void
      {
         this.FGotoNinjaFun = param1;
      }
   }
}

