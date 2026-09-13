package Processors.Game.Lobby.Pet
{
   import Components.Slots.TUISlot;
   import Foundation.Network.*;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Pet.TAddSoul;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.*;
   import Resources.Strings.STRING_COMMON;
   import flash.display.*;
   import flash.events.*;
   import flash.text.TextField;
   import flash.utils.*;
   
   public class TProcessorWindowMysteryShop extends TUIComponent
   {
      
      protected static const MAX_COUNT:uint = 2;
      
      protected static const MAX_SOUL_COUNT:uint = 8;
      
      protected static const NinjaStar_Type:uint = 13;
      
      protected var Bg_Sp:Shape;
      
      protected var FScene:MovieClip;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FUISlots1:Vector.<TUISlot>;
      
      protected var FArticleBins:TBins;
      
      protected var FExchangeRule:Vector.<Object>;
      
      protected var FInventories:TInventories;
      
      protected var FInventories1:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSoulAddEffect:Vector.<TextField>;
      
      protected var FAddSoul:TAddSoul;
      
      protected var FDayGoods:Vector.<uint>;
      
      public var OnOverlay:Function;
      
      public var OnOut:Function;
      
      public var OnExchangeItem:Function;
      
      public var OnShowHtmlText:Function;
      
      public var OnHideHtmlText:Function;
      
      protected var FOnQuerySequenceContext:Function;
      
      public function TProcessorWindowMysteryShop(param1:TUIComponent)
      {
         super(param1);
         this.FAddSoul = SLogicsCore.Character.Pet.AddSoul;
         this.FSoulAddEffect = new Vector.<TextField>();
         this.FDayGoods = new Vector.<uint>();
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-(CONST_COMMON.STAGE_Width / 2),-(CONST_COMMON.STAGE_Height / 2),CONST_COMMON.STAGE_Width * 2,CONST_COMMON.STAGE_Height * 2);
         this.graphics.endFill();
      }
      
      protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TConfigValue = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:Vector.<uint> = null;
         var _loc6_:MovieClip = null;
         this.FInventories = new TInventories();
         this.FInventories1 = new TInventories();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance("MC_MysteryShop") as MovieClip;
         addChild(this.FScene);
         this.FScene.BTN_Close.addEventListener(MouseEvent.CLICK,this.OnClose);
         this.FScene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OVER,this.ButtonHelpOnOver);
         this.FScene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60109017) as TConfigValue;
         this.FExchangeRule = _loc2_.Value as Vector.<Object>;
         this.FUISlots = new Vector.<TUISlot>();
         this.FUISlots1 = new Vector.<TUISlot>();
         this.FSoulAddEffect = new Vector.<TextField>();
         _loc5_ = new Vector.<uint>();
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc6_ = this.FScene["MC_Item" + _loc1_];
            _loc6_["mc_chang_btn"].addEventListener(MouseEvent.CLICK,this.OnChangeSoul);
            this.FUISlots.push(this.GetSlot(_loc6_["MC_Slot_0"]));
            this.FUISlots.push(this.GetSlot(_loc6_["MC_Slot_1"]));
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
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60109018) as TConfigValue;
         this.FDayGoods = _loc2_.Value as Vector.<uint>;
         _loc5_.length = 0;
         _loc5_.push(this.FDayGoods[0]);
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories1,_loc5_);
         this.FUISlots1.push(this.GetSlot(this.FScene["MC_Slot_0"]));
         TGameUtil.setButtonMode(this.FScene["BTN_Buy"],true);
         this.FScene["BTN_Buy"].addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyGoods);
      }
      
      protected function GetSlot(param1:Sprite) : TUISlot
      {
         var _loc2_:TUISlot = null;
         _loc2_ = new TUISlot(this);
         _loc2_.Resource = param1;
         _loc2_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         _loc2_.OnQuerySubscript = this.SlotsOnQuerySubscript;
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
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc4_ = this.FScene["MC_Item" + _loc1_];
            _loc3_ = this.FExchangeRule[_loc1_];
            TGameUtil.setButtonMode(_loc4_["mc_chang_btn"],true);
            _loc4_["TF_right_name"].text = STRING_COMMON.GetItemNameByType(1,_loc3_["fr_itemid"]);
            _loc4_["TF_left_name"].text = STRING_COMMON.GetItemNameByType(1,_loc3_["to_itemid"]);
            _loc4_["TF_right_percent"].text = String(_loc3_["fr_itemcnt"]);
            _loc4_["TF_left_percent"].text = String(_loc3_["to_itemcnt"]);
            this.FUISlots[_loc1_ * 2].Context = this.FInventories.GetInventoryByIndex(_loc1_ * 2);
            this.FUISlots[_loc1_ * 2 + 1].Context = this.FInventories.GetInventoryByIndex(_loc1_ * 2 + 1);
            _loc1_++;
         }
         this.FUISlots1[0].Context = this.FInventories1.GetInventoryByIndex(0);
         this.FScene.TF_Name.text = this.FInventories1.GetInventoryByIndex(0).Name;
         this.FScene.TF_Limit.text = this.FAddSoul.DayItemLimit.toString();
         this.FScene.TF_Price.text = this.FDayGoods[3];
         if(this.FAddSoul.DayItemLimit > 0)
         {
            TGameUtil.setButtonMode(this.FScene["BTN_Buy"],true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FScene["BTN_Buy"],false);
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
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = this.FDayGoods[1].toString();
         }
      }
      
      protected function OnClose(param1:MouseEvent) : void
      {
         this.Visible = false;
      }
      
      protected function ProcessorOnBuyGoods(param1:MouseEvent = null) : void
      {
         if(Boolean(param1) && Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.OnExchangeItem != null && this.FAddSoul.DayItemLimit > 0)
         {
            this.OnExchangeItem(TProcessorWindowAddSoul.REQ_TYPE_7);
         }
      }
      
      protected function OnChangeSoul(param1:MouseEvent = null) : void
      {
         var _loc2_:uint = 0;
         if(Boolean(param1) && Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = uint(int(String(param1.currentTarget.parent.name).slice(7)));
         if(this.OnExchangeItem != null)
         {
            this.OnExchangeItem(TProcessorWindowAddSoul.REQ_TYPE_6,_loc2_ + 1);
         }
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
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         var _loc3_:String = null;
         if(this.OnShowHtmlText != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,70170095) as TSystemLanguage;
            _loc3_ = _loc2_.Desc;
            this.OnShowHtmlText(_loc3_);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(this.OnHideHtmlText != null)
         {
            this.OnHideHtmlText();
         }
      }
      
      public function get OnQuerySequenceContext() : Function
      {
         return this.FOnQuerySequenceContext;
      }
      
      public function set OnQuerySequenceContext(param1:Function) : void
      {
         this.FOnQuerySequenceContext = param1;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
         if(Boolean(this.FScene) && param1)
         {
            this.UpdateExchangeStatus();
         }
      }
      
      public function Init() : void
      {
         this.ResourcesPerform_UIDispatch();
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
            this.FUISlots1[0].Update();
         }
      }
      
      public function UpdateUI() : void
      {
         this.UpdateExchangeStatus();
      }
   }
}

