package Processors.Game.Lobby.SuperHero
{
   import Foundation.Common.TBounds;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.ChatOptions.TChatOptions;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutActiveSpecialModes;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutActivityModes;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutAvatarModes;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutConstantlyModes;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutFunctionModes;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutMapModes;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutMode;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutModes;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutQuestGuideModes;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyPlate;
   import Resources.Constants.CONST_CHAT;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SUPERHERO;
   import flash.utils.ByteArray;
   
   public class TProcessorSuperHero extends TProcessorLobbyPlate
   {
      
      protected static const WINDOW_WIDTH:int = 1250;
      
      protected static const WINDOW_HEIGHT:int = 650;
      
      protected var FWindowSuperHero:TProcessorWindowSuperHero;
      
      protected var FBoundsSuperHero:TBounds;
      
      protected var FOnReturnMainScene:Function;
      
      protected var FTabIndex:uint;
      
      public function TProcessorSuperHero(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FWindowSuperHero = new TProcessorWindowSuperHero(this);
         this.FWindowSuperHero.OnEffectGenerateText = this.OnEffectGenerateText;
         this.FWindowSuperHero.y = -60;
         this.FWindowSuperHero.OnClose = this.ProcessorWindowSuperHeroOnClose;
         this.FWindowSuperHero.OnEnlist = this.HeroSLevel_CS_Enlist;
         SetUIModuleID(CONST_MODULES.MODULE_SuperHero);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SUPERHERO.RESOURCESID_Swf_SuperHero);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FWindowSuperHero.UIDispatch();
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FWindowSuperHero.UILocations();
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_HeroSLevel_EnlistRet,this.HeroSLevel_SC_Enlist);
      }
      
      protected function HeroSLevel_SC_Enlist(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         _loc2_ = param1.Data.readInt();
         if(_loc2_ == 0)
         {
            this.FWindowSuperHero.Update();
         }
         else
         {
            EffectGenerateTextByErrorCode(_loc2_);
         }
      }
      
      protected function HeroSLevel_CS_Enlist(param1:int, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HeroSLevel_EnlistReq);
         _loc3_.Data.writeByte(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function OnEffectGenerateText(param1:String) : void
      {
         EffectGenerateText(param1);
      }
      
      public function set OnBuyGoods(param1:Function) : void
      {
         this.FWindowSuperHero.OnBuyGoods = param1;
      }
      
      public function set OnEnlistSuccess(param1:Function) : void
      {
         this.FWindowSuperHero.OnEnlistSuccess = param1;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FWindowSuperHero.OnShortcutHyperlinks = param1;
      }
      
      public function get WindowSuperHero() : TProcessorWindowSuperHero
      {
         return this.FWindowSuperHero;
      }
      
      public function get OnReturnMainScene() : Function
      {
         return this.FOnReturnMainScene;
      }
      
      public function set OnReturnMainScene(param1:Function) : void
      {
         this.FOnReturnMainScene = param1;
      }
      
      protected function ProcessorWindowSuperHeroOnClose(param1:Object) : void
      {
         if(this.FOnReturnMainScene != null)
         {
            this.FOnReturnMainScene(param1);
         }
      }
      
      override public function ChatOptionsSetup(param1:TChatOptions) : void
      {
         param1.ChatStatus = CONST_CHAT.MODE_Hidden;
      }
      
      override public function ShortcutModesSetup(param1:TLobbyShortcutModes) : void
      {
         var _loc2_:TLobbyShortcutAvatarModes = null;
         var _loc3_:TLobbyShortcutActivityModes = null;
         var _loc4_:TLobbyShortcutActiveSpecialModes = null;
         var _loc5_:TLobbyShortcutFunctionModes = null;
         var _loc6_:TLobbyShortcutMapModes = null;
         var _loc7_:TLobbyShortcutQuestGuideModes = null;
         var _loc8_:TLobbyShortcutConstantlyModes = null;
         if(param1 is TLobbyShortcutAvatarModes)
         {
            _loc2_ = param1 as TLobbyShortcutAvatarModes;
            _loc2_.ShortcutModeAvatar = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutActivityModes)
         {
            _loc3_ = param1 as TLobbyShortcutActivityModes;
            _loc3_.SetAllShortcutHide();
         }
         if(param1 is TLobbyShortcutActiveSpecialModes)
         {
            _loc4_ = param1 as TLobbyShortcutActiveSpecialModes;
            _loc4_.ShortcutModeCDK = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutFunctionModes)
         {
            _loc5_ = param1 as TLobbyShortcutFunctionModes;
            _loc5_.ShortcutModeHero = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeStar = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeTacticalDeployment = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeInheritPractice = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeBackpack = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeTreasure = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeSummonPet = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeStrengthen = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeMail = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeTongLing = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeOrganiZation = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeReturn = TLobbyShortcutMode.SHORTCUTMODE_Show;
         }
         if(param1 is TLobbyShortcutMapModes)
         {
            _loc6_ = param1 as TLobbyShortcutMapModes;
            _loc6_.ShortcutModeMap = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc6_.ShortcutModeReturnHome = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutQuestGuideModes)
         {
            _loc7_ = param1 as TLobbyShortcutQuestGuideModes;
            _loc7_.ShortcutMode = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutConstantlyModes)
         {
            _loc8_ = param1 as TLobbyShortcutConstantlyModes;
            _loc8_.ShortcutModeStrengthen = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeArena = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeBigDipper = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeMentorship = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeTongLing = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         var tabindex:int = 0;
         var Stream:ByteArray = param1;
         super.Mount();
         if(Stream != null)
         {
            tabindex = 0;
            try
            {
               tabindex = int(Stream.readUnsignedInt());
            }
            catch(e:*)
            {
               tabindex = 0;
            }
            if(tabindex != 0)
            {
               this.FTabIndex = tabindex;
            }
         }
         if(!FIsResourcesLoadCompleted)
         {
            this.FWindowSuperHero.Load();
            return;
         }
         this.FWindowSuperHero.visible = true;
         this.FWindowSuperHero.Update();
         if(this.FTabIndex != 0)
         {
            this.FWindowSuperHero.FParameter = this.FTabIndex;
         }
         TutorialNextStep(2000);
         SLogicsCore.Character.RoleSencePosition = CONST_COMMON.SCENEPOSITION_SuperHero;
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FTabIndex = 0;
         TutorialNextStep(2002);
         this.FWindowSuperHero.SlotReset();
      }
      
      public function UpdateSuperHeroUI() : void
      {
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FWindowSuperHero.BuyGoodsRet(0);
      }
   }
}

