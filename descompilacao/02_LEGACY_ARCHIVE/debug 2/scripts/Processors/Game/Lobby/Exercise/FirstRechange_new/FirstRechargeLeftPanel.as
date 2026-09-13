package Processors.Game.Lobby.Exercise.FirstRechange_new
{
   import Components.ScrollBar.TScrollBar;
   import Components.Slots.TUISlot;
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.DatebaseVO.VO.TheFirstRecharge;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Exercise.TUnstreamizerFirstRechargeResInfo;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Exercise.FirstRechange_new.component.RechargeRewardInfo;
   import Processors.Game.Lobby.Exercise.FirstRechange_new.component.RechargeRewardItem;
   import Processors.Game.Lobby.Exercise.FirstRechange_new.eve.DatasEvent;
   import Processors.Game.Lobby.Exercise.FirstRechange_new.eve.FirstRechargeEventTypeName;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_FIRSTRECHAGE;
   import Resources.Constants.CONST_FIRSTRECHAGE_NEW;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NARUTOROAD;
   import Resources.Constants.CONST_RECHARGE;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class FirstRechargeLeftPanel extends Sprite
   {
      
      public static const SYSTEMLANGUAGE_FIRST_RECHARGE_NINJA_TIP:int = 70100016;
      
      public static const SLOT_NUM:int = 6;
      
      public static const CATEGORY_EQUIPMENT:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_TREASURE:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_ACCESSORIES:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const MIN_SCROLL_HEIGHT:Number = 149;
      
      public static const ITEM_STAMP:Number = 5;
      
      public static const SINGLE_ITEM_STAMP:Number = 55;
      
      private var _parent:TUIComponent;
      
      private var _ui:MovieClip;
      
      private var _tf_currentGold:TextField;
      
      private var _btn_recharge:SimpleButton;
      
      private var _btn_getReward:MovieClip;
      
      private var _mc_effect:MovieClip;
      
      private var _slotList:Vector.<TUISlot>;
      
      public var inventories:TInventories;
      
      private var _fUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      private var _itemTipList:Vector.<TInventories>;
      
      private var _itemTipReference:Vector.<TUnstreamizerInventoryReference>;
      
      private var _mc_list:MovieClip;
      
      private var _scrollBar:TScrollBar;
      
      private var _rewardItemList:Vector.<RechargeRewardItem>;
      
      private var _rewardInfoList:Vector.<RechargeRewardInfo>;
      
      private var _callBack:Function;
      
      private var _overlayerEquipment:TOverlayerEquipment;
      
      private var _overlayerTreasure:TOverlayerTreasure;
      
      private var _overlayerAppliance:TOverlayerAppliance;
      
      private var _overlayerAccessory:TOverlayerAccessory;
      
      private var _overlayerHelpTips:TOverlayerHelpTips;
      
      protected var FHelpTips:THint;
      
      private var _info:TUnstreamizerFirstRechargeResInfo;
      
      private var _mousePos:TCoordinate;
      
      private var _inited:Boolean;
      
      public function FirstRechargeLeftPanel(param1:TUIComponent, param2:MovieClip, param3:Function, param4:TUnstreamizerFirstRechargeResInfo)
      {
         super();
         this._parent = param1;
         this._ui = param2;
         this._callBack = param3;
         this._info = param4;
         this.initView();
         this.initEvent();
      }
      
      private function initView() : void
      {
         this._tf_currentGold = this._ui[CONST_FIRSTRECHAGE_NEW.RESOURCE_RECHARGE_GOLD];
         this._btn_recharge = this._ui[CONST_FIRSTRECHAGE_NEW.RESOURCE_RECHARGE_BTN];
         this._btn_getReward = this._ui[CONST_FIRSTRECHAGE_NEW.RESOURCE_GET_REWARD];
         TGameUtil.setButtonMode(this._btn_getReward,false);
         this._btn_getReward.mouseEnabled = false;
         this._mc_effect = this._ui[CONST_FIRSTRECHAGE.RESOURCE_Link_MC_Effect];
         this._mc_effect.stop();
         this._mc_effect.mouseEnabled = this._mc_effect.mouseChildren = false;
         this._mc_list = this._ui[CONST_NARUTOROAD.RESOURCE_LINK_MC_List];
         this._scrollBar = new TScrollBar(this._mc_list,MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
         this._overlayerEquipment = new TOverlayerEquipment(this._parent.Parent,CONST_MODULES.ACTIVE_Test);
         this._overlayerTreasure = new TOverlayerTreasure(this._parent.Parent,CONST_MODULES.ACTIVE_Test);
         this._overlayerAppliance = new TOverlayerAppliance(this._parent.Parent,CONST_MODULES.ACTIVE_Test);
         this._overlayerAccessory = new TOverlayerAccessory(this._parent.Parent,CONST_MODULES.ACTIVE_Test);
         this._overlayerHelpTips = new TOverlayerHelpTips(this._parent.Parent);
         this._overlayerEquipment.Visible = false;
         this._overlayerTreasure.Visible = false;
         this._overlayerAppliance.Visible = false;
         this._overlayerAccessory.Visible = false;
         this._overlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this._overlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(this._overlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(this._overlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(this._overlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(this._overlayerHelpTips);
         this.FHelpTips = new THint();
         if(this._ui.MC_Tip)
         {
            this._ui.MC_Tip.buttonMode = true;
            this._ui.MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnNinJaOnOver);
            this._ui.MC_Tip.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnNinJaOnOut);
         }
         this.initSlotList();
         this.initRewardList();
         this._inited = true;
      }
      
      private function initEvent() : void
      {
         this._btn_recharge.addEventListener(MouseEvent.CLICK,this.viewHandler,false,0,true);
         this._btn_getReward.addEventListener(MouseEvent.CLICK,this.viewHandler,false,0,true);
      }
      
      private function removeView() : void
      {
         this.playEffect(false);
         this._mc_effect = null;
         this._ui.parent.removeChild(this._ui);
         this._ui = null;
      }
      
      private function removeEvent() : void
      {
         this._callBack = null;
         this._btn_recharge.removeEventListener(MouseEvent.CLICK,this.viewHandler,false);
         this._btn_getReward.removeEventListener(MouseEvent.CLICK,this.viewHandler,false);
      }
      
      private function initSlotList() : void
      {
         var _loc2_:TUISlot = null;
         var _loc5_:uint = 0;
         var _loc8_:TBins = null;
         this._slotList = new Vector.<TUISlot>(SLOT_NUM);
         var _loc1_:int = int(this._slotList.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = new TUISlot(this._parent);
            _loc2_.Resource = this._ui[CONST_RECHARGE.RESOURCE_Link_MC_Slot + _loc3_] as MovieClip;
            _loc2_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc2_.Tag = _loc3_;
            _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc2_.OnOverlay = this.UIComponentsHintOnOver;
            _loc2_.OnOut = this.UIComponentsHintOnOut;
            _loc2_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc2_.Init();
            this._slotList[_loc3_] = _loc2_;
            _loc3_++;
         }
         this.inventories = new TInventories();
         this._fUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         var _loc4_:TheFirstRecharge = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TheFirstRecharge,50001) as TheFirstRecharge;
         _loc1_ = int(_loc4_.awardList.length);
         var _loc6_:Vector.<uint> = new Vector.<uint>();
         var _loc7_:Vector.<uint> = new Vector.<uint>();
         _loc8_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         var _loc9_:int = 0;
         while(_loc9_ < _loc1_)
         {
            _loc5_ = CONST_COMMON.GetItemIDByType(_loc4_.awardList[_loc9_].type,_loc4_.awardList[_loc9_].id,_loc8_);
            _loc6_.push(_loc5_);
            _loc7_.push(_loc4_.awardList[_loc9_].count);
            _loc9_++;
         }
         this._fUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.inventories,_loc6_);
         _loc9_ = 0;
         while(_loc9_ < _loc1_)
         {
            this.inventories.GetInventoryByIndex(_loc9_).Quantity = _loc7_[_loc9_];
            _loc9_++;
         }
         _loc1_ = int(this._slotList.length);
         _loc9_ = 0;
         while(_loc9_ < _loc1_)
         {
            this._slotList[_loc9_].Context = null;
            this._slotList[_loc9_].Resource.visible = false;
            _loc9_++;
         }
         _loc1_ = this.inventories.Count;
         _loc9_ = 0;
         while(_loc9_ < _loc1_)
         {
            if(_loc9_ >= this.inventories.Count)
            {
               break;
            }
            this._slotList[_loc9_].Context = this.inventories.GetInventoryByIndex(_loc9_);
            this._slotList[_loc9_].Resource.visible = true;
            _loc9_++;
         }
         this.playEffect(true);
      }
      
      private function initRewardList() : void
      {
         var _loc3_:TheFirstRecharge = null;
         var _loc4_:RechargeRewardInfo = null;
         var _loc5_:MovieClip = null;
         var _loc6_:RechargeRewardItem = null;
         this._scrollBar.Clear();
         this._rewardItemList = new Vector.<RechargeRewardItem>();
         this._rewardInfoList = new Vector.<RechargeRewardInfo>();
         var _loc1_:Array = [50002,50003,50004,50005];
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TheFirstRecharge,_loc1_[_loc2_]) as TheFirstRecharge;
            _loc4_ = new RechargeRewardInfo();
            _loc4_.rechargeValue = _loc3_.Frecharge;
            _loc4_.price = _loc3_.Fprice;
            _loc4_.rechargeType = _loc2_ + 1;
            _loc4_.getState = 0;
            this._rewardInfoList.push(_loc4_);
            _loc5_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_FIRSTRECHAGE_NEW.RESOURCE_RECHARGE_REWARD_ITEM) as MovieClip;
            _loc6_ = new RechargeRewardItem(_loc5_);
            _loc6_.addEventListener(MouseEvent.CLICK,this.viewHandler);
            _loc6_.addEventListener(FirstRechargeEventTypeName.SHOW_BAG_TIP,this.bagTipHandler);
            _loc6_.addEventListener(FirstRechargeEventTypeName.HIDE_BAG_TIP,this.bagTipHandler);
            _loc6_.addEventListener(FirstRechargeEventTypeName.MOVE_BAG_TIP,this.bagTipHandler);
            _loc6_.tip = this.createTip(_loc1_[_loc2_]);
            this._rewardItemList.push(_loc6_);
            _loc6_.initInfo(_loc4_);
            this._scrollBar.AddItem(_loc5_);
            _loc2_++;
         }
      }
      
      protected function ProcessorOnNinJaOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,SYSTEMLANGUAGE_FIRST_RECHARGE_NINJA_TIP) as TSystemLanguage;
         if(_loc2_)
         {
            this.FHelpTips.Content = _loc2_.Desc;
            this.UIHelpTipsHintOnOver(this,this.FHelpTips);
         }
      }
      
      protected function ProcessorOnNinJaOnOut(param1:MouseEvent) : void
      {
         this.UIHelpTipsHintOnOut(this);
      }
      
      protected function UIHelpTipsHintOnOver(param1:Object, param2:THint) : void
      {
         this._overlayerHelpTips.Context = param2;
         this._overlayerHelpTips.Render(this._mousePos);
         this._overlayerHelpTips.Show();
      }
      
      protected function UIHelpTipsHintOnOut(param1:Object) : void
      {
         this._overlayerHelpTips.Hide();
      }
      
      private function bagTipHandler(param1:DatasEvent) : void
      {
         switch(param1.type)
         {
            case FirstRechargeEventTypeName.SHOW_BAG_TIP:
               this._callBack(new DatasEvent(FirstRechargeEventTypeName.SHOW_BAG_TIP,param1.data));
               break;
            case FirstRechargeEventTypeName.HIDE_BAG_TIP:
               this._callBack(new DatasEvent(FirstRechargeEventTypeName.HIDE_BAG_TIP,param1.data));
               break;
            case FirstRechargeEventTypeName.MOVE_BAG_TIP:
               this._callBack(new DatasEvent(FirstRechargeEventTypeName.MOVE_BAG_TIP,param1.data));
         }
      }
      
      private function viewHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Object = param1.currentTarget;
         if(_loc2_ == this._btn_recharge)
         {
            this._callBack(new DatasEvent(FirstRechargeEventTypeName.CLICK_RECHARGE_BTN));
         }
         else if(_loc2_ == this._btn_getReward)
         {
            this._btn_getReward.mouseEnabled = false;
            this._callBack(new DatasEvent(FirstRechargeEventTypeName.CLICK_FIRST_RECHARGE_GET_REWARD_BTN));
         }
         else if(_loc2_ is RechargeRewardItem)
         {
            RechargeRewardItem(_loc2_).rewardBtn.mouseEnabled = false;
            _loc3_ = this._rewardItemList.indexOf(_loc2_) + 1;
            this._callBack(new DatasEvent(FirstRechargeEventTypeName.CLICK_MORE_RECHANGE_GET_REWARD_BTN,_loc3_));
         }
      }
      
      private function playEffect(param1:Boolean) : void
      {
         if(param1)
         {
            this._mc_effect.visible = true;
            this._mc_effect.play();
         }
         else
         {
            this._mc_effect.visible = false;
            this._mc_effect.gotoAndStop(1);
         }
      }
      
      private function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = param2 as TInventory;
         var _loc6_:TResourceRepositoryTexture = SResourcesCore.TexturesInventory;
         var _loc7_:TTexture = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.ACTIVE_Test);
         }
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:Object) : void
      {
         var _loc4_:TOverlayer = null;
         var _loc3_:TInventory = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_EQUIPMENT:
               _loc4_ = this._overlayerEquipment;
               break;
            case CATEGORY_TREASURE:
               _loc4_ = this._overlayerTreasure;
               break;
            case CATEGORY_ACCESSORIES:
               _loc4_ = this._overlayerAccessory;
               break;
            default:
               _loc4_ = this._overlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(this._mousePos);
            _loc4_.Show();
         }
      }
      
      private function UIComponentsHintOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_EQUIPMENT:
               _loc4_ = this._overlayerEquipment;
               break;
            case CATEGORY_TREASURE:
               _loc4_ = this._overlayerTreasure;
               break;
            case CATEGORY_ACCESSORIES:
               _loc4_ = this._overlayerAccessory;
               break;
            default:
               _loc4_ = this._overlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
      }
      
      private function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      private function updateRewardList() : void
      {
         var _loc3_:RechargeRewardInfo = null;
         var _loc4_:RechargeRewardItem = null;
         var _loc1_:Vector.<int> = this._info.assupRechargeStatus;
         var _loc2_:int = 0;
         while(_loc2_ < this._rewardItemList.length)
         {
            _loc3_ = this._rewardInfoList[_loc2_];
            _loc3_.getState = _loc1_[_loc2_];
            _loc4_ = this._rewardItemList[_loc2_];
            _loc4_.initInfo(_loc3_);
            _loc2_++;
         }
      }
      
      private function createTip(param1:int) : TInventories
      {
         var _loc6_:uint = 0;
         var _loc9_:TBins = null;
         var _loc2_:TInventories = new TInventories();
         var _loc3_:TUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         var _loc4_:TheFirstRecharge = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TheFirstRecharge,param1) as TheFirstRecharge;
         var _loc5_:int = int(_loc4_.awardList.length);
         var _loc7_:Vector.<uint> = new Vector.<uint>();
         var _loc8_:Vector.<uint> = new Vector.<uint>();
         _loc9_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         var _loc10_:int = 0;
         while(_loc10_ < _loc5_)
         {
            _loc6_ = CONST_COMMON.GetItemIDByType(_loc4_.awardList[_loc10_].type,_loc4_.awardList[_loc10_].id,_loc9_);
            _loc7_.push(_loc6_);
            _loc8_.push(_loc4_.awardList[_loc10_].count);
            _loc10_++;
         }
         _loc3_.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc2_,_loc7_);
         _loc10_ = 0;
         while(_loc10_ < _loc5_)
         {
            _loc2_.GetInventoryByIndex(_loc10_).Quantity = _loc8_[_loc10_];
            _loc10_++;
         }
         return _loc2_;
      }
      
      public function destroy() : void
      {
         this.removeEvent();
         this.removeView();
      }
      
      public function updateView() : void
      {
         this._tf_currentGold.text = this._info.totalRcharge + "";
         if(this._info.firstRechareStatus == 1)
         {
            TGameUtil.setButtonMode(this._btn_getReward,true);
            this._btn_getReward.mouseEnabled = true;
            this._btn_getReward.tf_label.text = STRING_BASEACTIVITY.FORMAT_BTN_STRING_0;
            this._btn_getReward.visible = true;
            this._ui["MC_Got"].visible = false;
         }
         else if(this._info.firstRechareStatus == -1)
         {
            TGameUtil.setButtonMode(this._btn_getReward,false);
            this._btn_getReward.mouseEnabled = false;
            this._btn_getReward.tf_label.text = STRING_BASEACTIVITY.FORMAT_BTN_STRING_1;
            this._btn_getReward.visible = false;
            this._ui["MC_Got"].visible = true;
         }
         else
         {
            TGameUtil.setButtonMode(this._btn_getReward,false);
            this._btn_getReward.mouseEnabled = false;
            this._btn_getReward.tf_label.text = STRING_BASEACTIVITY.FORMAT_BTN_STRING_0;
            this._btn_getReward.visible = true;
            this._ui["MC_Got"].visible = false;
         }
         this.updateRewardList();
         this.playEffect(true);
      }
      
      public function updateSlotList() : void
      {
         var _loc1_:int = int(this._slotList.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._slotList[_loc2_].Update();
            _loc2_++;
         }
      }
      
      public function setMouseCoordinate(param1:TCoordinate) : void
      {
         this._mousePos = param1;
      }
   }
}

