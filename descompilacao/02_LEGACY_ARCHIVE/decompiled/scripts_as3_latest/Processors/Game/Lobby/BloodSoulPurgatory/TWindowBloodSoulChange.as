package Processors.Game.Lobby.BloodSoulPurgatory
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
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TBloodSoul_battle;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_BLOODPURGATORY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TONGLING;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TWindowBloodSoulChange extends TProcessorLobbyWindow
   {
      
      protected static const MAX_COUNT:uint = 4;
      
      protected static const MAX_Soul_COUNT:uint = 5;
      
      protected static const Soul_StartIndex:uint = 1;
      
      protected static const Soul_Type:uint = 1;
      
      public static const WindowWidth:uint = 660;
      
      public static const WindowHeight:uint = 486;
      
      protected var BloodSoulItemIds:Vector.<uint> = TProcessorBloodSoul.InventoryItemId;
      
      protected var FScene:MovieClip;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FSoulAddEffect:Vector.<TextField>;
      
      protected var FArticleBins:TBins;
      
      protected var FExchangeRule:Vector.<Object>;
      
      protected var FCharacter:TCharacter;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FTimeoutId:uint;
      
      protected var FCustomId:uint;
      
      protected var FItemCount:Dictionary;
      
      protected var FChangeIndex:int;
      
      protected var FSlotsOnMove:Function;
      
      protected var FSlotsOnOut:Function;
      
      protected var FOnChangeBackFun:Function;
      
      public function TWindowBloodSoulChange(param1:TUIComponent)
      {
         super(param1);
         this.FCharacter = SLogicsCore.Character;
         this.FItemCount = new Dictionary();
         this.FChangeIndex = -1;
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-(CONST_COMMON.STAGE_Width / 2),-(CONST_COMMON.STAGE_Height / 2),CONST_COMMON.STAGE_Width * 2,CONST_COMMON.STAGE_Height * 2);
         this.graphics.endFill();
      }
      
      protected function InitChangeSoul() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TConfigValue = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:Vector.<uint> = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TBloodSoul_battle = null;
         this.FInventories = new TInventories();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_BLOODPURGATORY.BooldPurgatory_Change) as MovieClip;
         addChild(this.FScene);
         this.FScene.BT_Close.addEventListener(MouseEvent.CLICK,this.OnCloseChangeSoul);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.BLOODSOUL_Conversion) as TConfigValue;
         this.FExchangeRule = _loc2_.Value as Vector.<Object>;
         this.FUISlots = new Vector.<TUISlot>();
         this.FSoulAddEffect = new Vector.<TextField>();
         _loc5_ = new Vector.<uint>();
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc6_ = this.FScene["MC_ProofUint_" + _loc1_];
            if(_loc1_ >= this.FExchangeRule.length)
            {
               _loc6_.visible = false;
            }
            else
            {
               _loc6_["mc_chang_btn"].addEventListener(MouseEvent.CLICK,this.OnChangeSoul);
               _loc3_ = this.FExchangeRule[_loc1_];
               _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BloodPurgatory_Battle,_loc3_["stage_limit"]) as TBloodSoul_battle;
               _loc4_ = TUtilityString.Format(STRING_TONGLING.TONGLING_61,_loc7_.Name);
               _loc6_["mc_Limit"]["TF_Level"].text = _loc4_;
               _loc6_["TF_right_name"].text = STRING_COMMON.GetItemNameByType(Soul_Type,_loc3_["fr_itemid"]);
               _loc6_["TF_left_name"].text = STRING_COMMON.GetItemNameByType(Soul_Type,_loc3_["to_itemid"]);
               _loc6_["TF_right_percent"].text = String(_loc3_["fr_itemcnt"]);
               _loc6_["TF_left_percent"].text = String(_loc3_["to_itemcnt"]);
               _loc5_.push(CONST_COMMON.GetItemIDByType(Soul_Type,_loc3_["fr_itemid"],this.FArticleBins));
               _loc5_.push(CONST_COMMON.GetItemIDByType(Soul_Type,_loc3_["to_itemid"],this.FArticleBins));
               this.FUISlots.push(this.GetSlot(_loc6_["MC_Slot_0"]));
               this.FUISlots.push(this.GetSlot(_loc6_["MC_Slot_1"]));
            }
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
            if(_loc1_ >= 4)
            {
               this.FScene["mc_proof_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         if(!SLogicsCore.Character.GetConfigValueById(91000011))
         {
            this.FScene["mc_proof_3"].visible = false;
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_BloodSoulPurgatory);
         }
      }
      
      protected function OnCloseChangeSoul(param1:MouseEvent = null) : void
      {
         this.Visible = false;
      }
      
      public function set OnChangeBackFun(param1:Function) : void
      {
         this.FOnChangeBackFun = param1;
      }
      
      protected function OnChangeSoul(param1:MouseEvent = null) : void
      {
         var _loc2_:Object = null;
         if(Boolean(param1) && Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FChangeIndex >= 0)
         {
            return;
         }
         this.FChangeIndex = int(String(param1.currentTarget.parent.name).slice(13));
         _loc2_ = this.FExchangeRule[this.FChangeIndex];
         if(this.FOnChangeBackFun != null)
         {
            this.FOnChangeBackFun(_loc2_);
         }
      }
      
      public function C_S_(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ExchangeItemRet_Req);
         _loc5_ = _loc4_.Data;
         _loc5_.writeShort(1);
         _loc5_.writeInt(param1);
         _loc5_.writeInt(param3);
         _loc5_.writeInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function CheckExchangeStatus() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Object = null;
         var _loc3_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            if(_loc1_ >= this.FExchangeRule.length)
            {
               break;
            }
            _loc2_ = this.FExchangeRule[_loc1_];
            this.FScene["MC_ProofUint_" + _loc1_]["mc_chang_btn"].visible = Boolean(this.FCustomId >= _loc2_["stage_limit"]);
            this.FScene["MC_ProofUint_" + _loc1_]["mc_Limit"].visible = Boolean(this.FCustomId < _loc2_["stage_limit"]);
            TGameUtil.setButtonMode(this.FScene["MC_ProofUint_" + _loc1_]["mc_chang_btn"],this.FItemCount[_loc2_["fr_itemid"]] >= _loc2_["fr_itemcnt"]);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_Soul_COUNT)
         {
            if(_loc1_ >= this.BloodSoulItemIds.length)
            {
               break;
            }
            this.FScene["mc_proof_" + _loc1_]["MC_movie"]["MC_movie_two"]["TF_Count"].text = this.FItemCount[this.BloodSoulItemIds[_loc1_]];
            _loc1_++;
         }
      }
      
      protected function CheckBloodSoulById(param1:uint) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TInventories = null;
         var _loc6_:TInventory = null;
         _loc4_ = 0;
         _loc5_ = this.FCharacter.Appliances;
         _loc3_ = uint(_loc5_.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = _loc5_.GetInventoryByIndex(_loc2_);
            if(_loc6_.IDTemplate == param1)
            {
               _loc4_ += _loc6_.Quantity;
            }
            _loc2_++;
         }
         this.FItemCount[param1] = _loc4_;
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
            this.CheckBloodSoul();
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
      
      public function Reset() : void
      {
         this.FChangeIndex = -1;
      }
      
      public function ChgBloodSoulSucceed() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Object = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         if(this.FTimeoutId != 0)
         {
            clearTimeout(this.FTimeoutId);
            this.FTimeoutId = 0;
            this.OnEndEffect();
         }
         _loc2_ = this.FExchangeRule[this.FChangeIndex];
         _loc3_ = uint(_loc2_["fr_itemid"]);
         _loc5_ = uint(_loc2_["to_itemid"]);
         _loc4_ = uint(_loc2_["fr_itemcnt"]);
         _loc6_ = uint(_loc2_["to_itemcnt"]);
         _loc7_ = this.BloodSoulItemIds.indexOf(_loc3_);
         _loc8_ = this.BloodSoulItemIds.indexOf(_loc5_);
         this.FScene["mc_proof_" + _loc7_]["MC_movie"]["MC_movie_two"].gotoAndPlay(1);
         this.FScene["mc_proof_" + _loc8_]["MC_movie"]["MC_movie_two"].gotoAndPlay(1);
         this.FSoulAddEffect[_loc7_].visible = true;
         this.FSoulAddEffect[_loc8_].visible = true;
         this.FSoulAddEffect[_loc7_].text = "-" + String(_loc4_);
         this.FSoulAddEffect[_loc8_].text = "+" + String(_loc6_);
         this.FSoulAddEffect[_loc7_].textColor = 16711680;
         this.FSoulAddEffect[_loc8_].textColor = 255;
         this.FTimeoutId = setTimeout(this.OnEndEffect,1000);
         this.FChangeIndex = -1;
         this.CheckBloodSoul();
         this.CheckExchangeStatus();
      }
      
      public function SetCustomId(param1:uint) : void
      {
         this.FCustomId = param1;
         this.FCustomId = uint.MAX_VALUE;
      }
      
      public function CheckBloodSoul() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < this.BloodSoulItemIds.length)
         {
            this.CheckBloodSoulById(this.BloodSoulItemIds[_loc1_]);
            _loc1_++;
         }
      }
   }
}

