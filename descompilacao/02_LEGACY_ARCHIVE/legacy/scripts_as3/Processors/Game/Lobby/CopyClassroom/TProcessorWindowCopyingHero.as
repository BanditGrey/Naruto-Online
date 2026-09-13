package Processors.Game.Lobby.CopyClassroom
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.CopyHero.TCopyHero;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Components.TUIHero;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_COPYCLASSROOM;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_COPYCLASSROOM;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowCopyingHero extends TProcessorLobbyWindow
   {
      
      public var FMC:Sprite;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Pormpt:TextField;
      
      protected var FCopyHeroIndex:int;
      
      protected var FBtn_OK:MovieClip;
      
      protected var FBtn_Close:MovieClip;
      
      protected var FMC_ModelHero:MovieClip;
      
      protected var FMC_HeroPosition:Sprite;
      
      protected var FModelHeroBin:TBins;
      
      protected var FBRecruit:Boolean;
      
      protected var FInitializationSlots:Boolean;
      
      protected var FUIHero:TUIHero;
      
      protected var FSingleCopyHero:TCopyHero;
      
      protected var FCopyingTimes:int;
      
      public function TProcessorWindowCopyingHero(param1:TUIComponent)
      {
         super(param1);
         this.FSingleCopyHero = new TCopyHero();
         this.FInitializationSlots = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_COPYCLASSROOM.RESOURCESID_Swf_COPYCLASSROOM);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC = TUtilityReflection.CreateDisplayObjectInstance(CONST_COPYCLASSROOM.RESOURCE_ClassName_MC_PopupCopy) as Sprite;
         this.addChild(this.FMC);
         this.FTF_Name = this.FMC[CONST_COPYCLASSROOM.RESOURCE_Link_TF_CopyHeroName];
         this.FTF_Pormpt = this.FMC[CONST_COPYCLASSROOM.RESOURCE_Link_TF_CopyHeroPrompt];
         this.FBtn_Close = this.FMC[CONST_COPYCLASSROOM.RESOURCE_Link_Btn_Close];
         this.FBtn_OK = this.FMC[CONST_COPYCLASSROOM.RESOURCE_Link_Btn_Ok];
         this.FMC_HeroPosition = this.FMC[CONST_COPYCLASSROOM.RESOURCE_Link_MC_HeroPosition];
         this.FUIHero = new TUIHero(this);
         this.FMC_HeroPosition.addChild(this.FUIHero);
         this.FUIHero.OnQuerySequenceContext = this.HeroOnQuerySequenceContext;
         this.FUIHero.DefaultRole = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as Sprite;
         this.FBtn_OK.buttonMode = true;
         this.FBtn_Close.buttonMode = true;
         this.FInitializationSlots = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_OK.addEventListener(MouseEvent.CLICK,this.OnCopyingHeroClick);
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,FOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(!this.FInitializationSlots)
         {
            return;
         }
         this.FUIHero.Update();
      }
      
      protected function UpdateRoleModel() : void
      {
         var _loc1_:TCopyHero = null;
         _loc1_ = this.FSingleCopyHero;
         this.FUIHero.Context = _loc1_;
      }
      
      protected function OnCopyingHeroClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CopyHero_CopyingHeroReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FSingleCopyHero.CardID);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         FOnClose(this);
      }
      
      protected function OnCopyingHeroClose(param1:MouseEvent) : void
      {
         FOnClose(this);
      }
      
      protected function UpdateTF(param1:int) : void
      {
         var _loc2_:TBaseHero = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.FSingleCopyHero.HeroID) as TBaseHero;
         this.FTF_Name.text = this.FSingleCopyHero.HeroName;
         this.FTF_Name.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[_loc2_.Quality];
         if(param1 > 0)
         {
            this.FTF_Pormpt.text = STRING_COPYCLASSROOM.FORMAT_ChangeTimeWithChanged;
         }
         else
         {
            this.FTF_Pormpt.text = STRING_COPYCLASSROOM.FORMAT_ChangeTime;
         }
      }
      
      protected function HeroOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TCopyHero = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         var _loc8_:TBounds = null;
         var _loc9_:TCoordinate = null;
         _loc5_ = param2 as TCopyHero;
         _loc8_ = new TBounds();
         _loc9_ = new TCoordinate();
         _loc6_ = SResourcesCore.TexturesModel;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.HeroID);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIndex(5);
            param3.Value.Evaluate(_loc9_,_loc8_);
            this.FUIHero.X = _loc8_.X;
            this.FUIHero.Y = _loc8_.Y;
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.HeroID,CONST_MODULES.MODULE_CopyClassroom);
            this.FUIHero.X = 0;
            this.FUIHero.Y = 0;
         }
      }
      
      public function get SingleCopyHero() : TCopyHero
      {
         return this.FSingleCopyHero;
      }
      
      public function set SingleCopyHero(param1:TCopyHero) : void
      {
         this.FSingleCopyHero = param1;
      }
      
      public function get CopyingTimes() : int
      {
         return this.FCopyingTimes;
      }
      
      public function set CopyingTimes(param1:int) : void
      {
         this.FCopyingTimes = param1;
      }
      
      public function UpDateUI(param1:Object) : void
      {
         var _loc2_:int = 0;
         _loc2_ = param1 as int;
         this.UpdateTF(_loc2_);
         this.UpdateRoleModel();
      }
   }
}

