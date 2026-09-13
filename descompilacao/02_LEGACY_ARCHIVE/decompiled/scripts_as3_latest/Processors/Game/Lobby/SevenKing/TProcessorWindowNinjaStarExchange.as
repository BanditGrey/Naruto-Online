package Processors.Game.Lobby.SevenKing
{
   import Components.Pages.TUIPage;
   import Components.Slots.TUISlot;
   import Foundation.Network.*;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSevenHeroArmy;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.SevenKing.TSevenKingData;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.*;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_SEVENHEROS;
   import flash.display.*;
   import flash.events.*;
   import flash.text.TextField;
   import flash.utils.*;
   
   public class TProcessorWindowNinjaStarExchange extends TUIComponent
   {
      
      protected static const MAX_COUNT:uint = 4;
      
      protected static const MAX_SOUL_COUNT:uint = 8;
      
      protected static const NinjaStar_Type:uint = 13;
      
      protected var Bg_Sp:Shape;
      
      protected var FScene:MovieClip;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FArticleBins:TBins;
      
      protected var FExchangeRule:Vector.<Object>;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSoulAddEffect:Vector.<TextField>;
      
      protected var FCharacter:TCharacter;
      
      public var FSevenKingData:TSevenKingData;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      public var OnOverlay:Function;
      
      public var OnOut:Function;
      
      public function TProcessorWindowNinjaStarExchange(param1:TUIComponent)
      {
         super(param1);
         this.FCharacter = SLogicsCore.Character;
         this.FSoulAddEffect = new Vector.<TextField>();
         this.FUIPage = new TUIPage(this);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-(CONST_COMMON.STAGE_Width / 2),-(CONST_COMMON.STAGE_Height / 2),CONST_COMMON.STAGE_Width * 2,CONST_COMMON.STAGE_Height * 2);
         this.graphics.endFill();
      }
      
      protected function InitNinjaStar() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TConfigValue = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:Vector.<uint> = null;
         var _loc6_:MovieClip = null;
         this.FInventories = new TInventories();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance("MC_SevenKingExchange") as MovieClip;
         addChild(this.FScene);
         this.FScene.BTN_Close.addEventListener(MouseEvent.CLICK,this.OnClose);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SERVEN_HERO_EXCHANGE_RULE) as TConfigValue;
         this.FExchangeRule = _loc2_.Value as Vector.<Object>;
         this.FUISlots = new Vector.<TUISlot>();
         this.FSoulAddEffect = new Vector.<TextField>();
         _loc5_ = new Vector.<uint>();
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc6_ = this.FScene["MC_ProofUint_" + _loc1_];
            _loc6_["mc_chang_btn"].addEventListener(MouseEvent.CLICK,this.OnChangeSoul);
            this.FUISlots.push(this.GetSlot(_loc6_["MC_Slot_0"]));
            this.FUISlots.push(this.GetSlot(_loc6_["MC_Slot_1"]));
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_SOUL_COUNT)
         {
            this.FScene["mc_proof_" + _loc1_]["mc_soul"].gotoAndStop(_loc1_ + 1);
            this.FSoulAddEffect.push(this.FScene["mc_proof_" + _loc1_]["TF_Count"]);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FExchangeRule.length)
         {
            _loc3_ = this.FExchangeRule[_loc1_];
            _loc5_.push(_loc3_["fr_itemid"]);
            _loc5_.push(_loc3_["to_itemid"]);
            _loc1_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,_loc5_);
         this.FUIPage.ButtonPrevious.Substrate = this.FScene.MC_ChangePage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = this.FScene.MC_ChangePage.MC_PageRight;
         this.FUIPage.LabelPage = this.FScene.MC_ChangePage.TF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = MAX_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.FCurPage = 0;
      }
      
      protected function GetSlot(param1:Sprite) : TUISlot
      {
         var _loc2_:TUISlot = null;
         _loc2_ = new TUISlot(this);
         _loc2_.Resource = param1;
         _loc2_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         _loc2_.OnOverlay = this.SlotsOnOver;
         _loc2_.OnOut = this.SlotsOnOut;
         _loc2_.Init();
         return _loc2_;
      }
      
      protected function UpdateExchangeStatus() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TSevenHeroArmy = null;
         this.FUIPage.TotalQuantity = this.FExchangeRule.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc4_ = this.FScene["MC_ProofUint_" + _loc1_];
            _loc2_ = _loc1_ + this.FCurPage * MAX_COUNT;
            if(_loc2_ < this.FExchangeRule.length)
            {
               _loc3_ = this.FExchangeRule[_loc2_];
               _loc4_.visible = true;
               _loc4_["mc_chang_btn"].visible = Boolean(this.FSevenKingData.CurProgressFlag > _loc3_["stage_limit"]);
               _loc4_["mc_Limit"].visible = Boolean(this.FSevenKingData.CurProgressFlag <= _loc3_["stage_limit"]);
               _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SevenHeroArmy,_loc3_["stage_limit"]) as TSevenHeroArmy;
               _loc4_["mc_Limit"].TF_Level.text = TUtilityString.Format(STRING_SEVENHEROS.STRING_EXCHANGE_LIMIT,_loc5_.Name);
               TGameUtil.setButtonMode(_loc4_["mc_chang_btn"],this.FCharacter.GetKingSoulByType(_loc3_["fr_soultype"]) >= _loc3_["fr_itemcnt"]);
               _loc4_["TF_right_name"].text = STRING_COMMON.GetItemNameByType(NinjaStar_Type,_loc3_["fr_soultype"]);
               _loc4_["TF_left_name"].text = STRING_COMMON.GetItemNameByType(NinjaStar_Type,_loc3_["to_soultype"]);
               _loc4_["TF_right_percent"].text = String(_loc3_["fr_itemcnt"]);
               _loc4_["TF_left_percent"].text = String(_loc3_["to_itemcnt"]);
               this.FUISlots[_loc1_ * 2].Context = this.FInventories.GetInventoryByIndex(_loc2_ * 2);
               this.FUISlots[_loc1_ * 2 + 1].Context = this.FInventories.GetInventoryByIndex(_loc2_ * 2 + 1);
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_SOUL_COUNT)
         {
            this.FScene["mc_proof_" + _loc1_]["TF_Count"].text = this.FCharacter.GetKingSoulByIndex(_loc1_);
            _loc1_++;
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Common);
         }
      }
      
      protected function OnClose(param1:MouseEvent) : void
      {
         this.Visible = false;
      }
      
      protected function OnChangeSoul(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         if(Boolean(param1) && Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc4_ = uint(int(String(param1.currentTarget.parent.name).slice(13)));
         _loc5_ = MAX_COUNT * this.FCurPage + _loc4_;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SevenKing_ExchangeReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeInt(_loc5_);
         _loc3_.writeInt(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateExchangeStatus();
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(this.OnOverlay != null)
         {
            this.OnOverlay(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.OnOut != null)
         {
            this.OnOut(this,param2);
         }
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
         if(Boolean(this.FScene) && param1)
         {
            this.UpdateExchangeStatus();
            this.FScene["MC_Left"].gotoAndPlay(1);
            this.FScene["MC_Right"].gotoAndPlay(1);
         }
      }
      
      public function Init(param1:TSevenKingData) : void
      {
         this.FSevenKingData = param1;
         this.InitNinjaStar();
      }
      
      public function LogicsPerform() : void
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
      
      public function UpdateUI() : void
      {
         this.UpdateExchangeStatus();
      }
   }
}

