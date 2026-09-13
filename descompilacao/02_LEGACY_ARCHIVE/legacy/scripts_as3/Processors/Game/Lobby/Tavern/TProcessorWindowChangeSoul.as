package Processors.Game.Lobby.Tavern
{
   import Components.Slots.TUISlot;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_TAVERN;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TProcessorWindowChangeSoul extends TProcessorLobbyWindow
   {
      
      protected static const MAX_COUNT:uint = 4;
      
      protected static const MAX_Soul_COUNT:uint = 4;
      
      protected static const Soul_StartIndex:uint = 3;
      
      protected static const Soul_Type:uint = 7;
      
      protected var FScene:MovieClip;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FSoulAddEffect:Vector.<TextField>;
      
      protected var FArticleBins:TBins;
      
      protected var FExchangeRule:Vector.<Object>;
      
      protected var FCharacter:TCharacter;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FTimeoutId:uint;
      
      protected var FBarrierDeactuate:Function;
      
      protected var FSlotsOnMove:Function;
      
      protected var FSlotsOnOut:Function;
      
      public function TProcessorWindowChangeSoul(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function InitChangeSoul() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TConfigValue = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:Vector.<uint> = null;
         var _loc6_:MovieClip = null;
         this.FCharacter = SLogicsCore.Character;
         this.FInventories = new TInventories();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_TAVERN.RESOURCESID_CLASSNAME_ChangeSoul) as MovieClip;
         addChild(this.FScene);
         this.FScene.BT_Close.addEventListener(MouseEvent.CLICK,this.OnCloseChangeSoul);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TAVERN_Hero_SoulExchange) as TConfigValue;
         this.FExchangeRule = _loc2_.Value as Vector.<Object>;
         this.FUISlots = new Vector.<TUISlot>();
         this.FSoulAddEffect = new Vector.<TextField>();
         _loc5_ = new Vector.<uint>();
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc6_ = this.FScene["MC_ProofUint_" + _loc1_];
            _loc6_["mc_chang_btn"].addEventListener(MouseEvent.CLICK,this.OnChangeSoul);
            _loc3_ = this.FExchangeRule[_loc1_];
            _loc4_ = STRING_COMMON.COMMON_OPENLEVELTIP;
            _loc4_ = _loc4_.split("%count%").join(_loc3_["levelLimit"]);
            _loc6_["mc_Limit"]["TF_Level"].text = _loc4_;
            _loc6_["TF_right_name"].text = STRING_COMMON.GetItemNameByType(Soul_Type,_loc3_["srcSoulType"]);
            _loc6_["TF_left_name"].text = STRING_COMMON.GetItemNameByType(Soul_Type,_loc3_["destSoulType"]);
            _loc6_["TF_right_percent"].text = String(_loc3_["srcSoulTypeNum"]);
            _loc6_["TF_left_percent"].text = String(_loc3_["destSoulNum"]);
            _loc5_.push(CONST_COMMON.GetItemIDByType(Soul_Type,_loc3_["srcSoulType"],this.FArticleBins));
            _loc5_.push(CONST_COMMON.GetItemIDByType(Soul_Type,_loc3_["destSoulType"],this.FArticleBins));
            this.FUISlots.push(this.GetSlot(_loc6_["MC_Slot_0"]));
            this.FUISlots.push(this.GetSlot(_loc6_["MC_Slot_1"]));
            _loc1_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,_loc5_);
         _loc1_ = 0;
         while(_loc1_ < this.FUISlots.length)
         {
            this.FUISlots[_loc1_].Context = this.FInventories.GetInventoryByIndex(_loc1_);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_Soul_COUNT)
         {
            this.FScene["mc_proof_" + _loc1_]["mc_soul"].gotoAndStop(_loc1_ + Soul_StartIndex);
            this.FSoulAddEffect.push(this.FScene["mc_proof_" + _loc1_]["TF_Counted"]);
            this.FScene["mc_proof_" + _loc1_]["TF_Counted"].visible = false;
            _loc1_++;
         }
      }
      
      protected function GetSlot(param1:Sprite) : TUISlot
      {
         var _loc2_:TUISlot = null;
         _loc2_ = new TUISlot(this);
         _loc2_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         _loc2_.OnOverlay = this.FSlotsOnMove;
         _loc2_.OnOut = this.FSlotsOnOut;
         _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         _loc2_.Resource = param1;
         _loc2_.Init();
         return _loc2_;
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Common);
         }
      }
      
      protected function OnCloseChangeSoul(param1:MouseEvent = null) : void
      {
         this.Visible = false;
         if(this.FBarrierDeactuate != null)
         {
            this.FBarrierDeactuate(this);
         }
      }
      
      protected function OnChangeSoul(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         var _loc5_:Object = null;
         if(Boolean(param1) && Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc4_ = uint(int(String(param1.currentTarget.parent.name).slice(13)));
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Common_TavernChangeSoul_Req);
         _loc3_ = _loc2_.Data;
         _loc5_ = this.FExchangeRule[_loc4_];
         _loc3_.writeInt(_loc5_["srcSoulType"]);
         _loc3_.writeInt(1);
         _loc3_.writeInt(_loc5_["destSoulType"]);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function CheckExchangeStatus() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Object = null;
         var _loc3_:uint = 0;
         _loc3_ = this.FCharacter.GetMainLevel();
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc2_ = this.FExchangeRule[_loc1_];
            this.FScene["MC_ProofUint_" + _loc1_]["mc_chang_btn"].visible = Boolean(_loc3_ >= _loc2_["levelLimit"]);
            this.FScene["MC_ProofUint_" + _loc1_]["mc_Limit"].visible = Boolean(_loc3_ < _loc2_["levelLimit"]);
            TGameUtil.setButtonMode(this.FScene["MC_ProofUint_" + _loc1_]["mc_chang_btn"],this.FCharacter.GetHeroSoulByIndex(_loc2_["srcSoulType"] - 3) >= _loc2_["srcSoulTypeNum"]);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_Soul_COUNT)
         {
            this.FScene["mc_proof_" + _loc1_]["MC_movie"]["MC_movie_two"]["TF_Count"].text = this.FCharacter.GetHeroSoulByIndex(_loc1_);
            _loc1_++;
         }
      }
      
      protected function OnEndEffect() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < MAX_Soul_COUNT)
         {
            this.FSoulAddEffect[_loc1_].visible = false;
            _loc1_++;
         }
      }
      
      public function get BarrierDeactuat() : Function
      {
         return this.FBarrierDeactuate;
      }
      
      public function set BarrierDeactuate(param1:Function) : void
      {
         this.FBarrierDeactuate = param1;
      }
      
      public function get SlotsOnMove() : Function
      {
         return this.FSlotsOnMove;
      }
      
      public function set SlotsOnMove(param1:Function) : void
      {
         this.FSlotsOnMove = param1;
      }
      
      public function get SlotsOnOut() : Function
      {
         return this.FSlotsOnOut;
      }
      
      public function set SlotsOnOut(param1:Function) : void
      {
         this.FSlotsOnOut = param1;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
         if(Boolean(this.FScene) && param1)
         {
            this.CheckExchangeStatus();
            this.FScene["MC_Left"].gotoAndPlay(1);
            this.FScene["MC_Right"].gotoAndPlay(1);
         }
      }
      
      public function Init() : void
      {
         this.InitChangeSoul();
      }
      
      public function UpdataBitmap() : void
      {
         var _loc1_:uint = 0;
         if(this.FUISlots != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FUISlots.length)
            {
               this.FUISlots[_loc1_].Update();
               _loc1_++;
            }
         }
      }
      
      public function ChgSoulSucceed(param1:uint, param2:uint, param3:uint, param4:uint) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:Object = null;
         if(this.FTimeoutId != 0)
         {
            clearTimeout(this.FTimeoutId);
            this.FTimeoutId = 0;
            this.OnEndEffect();
         }
         _loc5_ = 0;
         while(_loc5_ < this.FExchangeRule.length)
         {
            _loc6_ = this.FExchangeRule[_loc5_];
            if(_loc6_["srcSoulType"] == param1 && _loc6_["destSoulType"] == param3)
            {
               param2 *= _loc6_["srcSoulTypeNum"];
               param4 *= _loc6_["destSoulNum"];
               break;
            }
            _loc5_++;
         }
         this.FScene["mc_proof_" + (param1 - 3)]["MC_movie"]["MC_movie_two"].gotoAndPlay(1);
         this.FScene["mc_proof_" + (param3 - 3)]["MC_movie"]["MC_movie_two"].gotoAndPlay(1);
         this.FSoulAddEffect[param1 - 3].visible = true;
         this.FSoulAddEffect[param3 - 3].visible = true;
         this.FSoulAddEffect[param1 - 3].text = "-" + String(param2);
         this.FSoulAddEffect[param3 - 3].text = "+" + String(param4);
         this.FSoulAddEffect[param1 - 3].textColor = 16711680;
         this.FSoulAddEffect[param3 - 3].textColor = 255;
         this.FTimeoutId = setTimeout(this.OnEndEffect,1000);
         this.CheckExchangeStatus();
      }
   }
}

