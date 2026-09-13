package Processors.Game.Lobby.Exercise.FirstRechange_new
{
   import Components.Slots.TUISlot;
   import Foundation.Common.TCoordinate;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TheFirstRecharge;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Exercise.TUnstreamizerFirstRechargeResInfo;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Exercise.FirstRechange_new.component.ActivityRewardInfo;
   import Processors.Game.Lobby.Exercise.FirstRechange_new.component.ActivityRewardItem;
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
   import Resources.Constants.CONST_FIRSTRECHAGE_NEW;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_RECHARGE;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class FirstRechargeRightPanel extends Sprite
   {
      
      public static const REWARD_NUM:int = 3;
      
      public static const SLOT_NUM:int = 5;
      
      public static const CATEGORY_EQUIPMENT:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_TREASURE:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_ACCESSORIES:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      private var _overlayerEquipment:TOverlayerEquipment;
      
      private var _overlayerTreasure:TOverlayerTreasure;
      
      private var _overlayerAppliance:TOverlayerAppliance;
      
      private var _overlayerAccessory:TOverlayerAccessory;
      
      private var _overlayerHelpTips:TOverlayerHelpTips;
      
      private var _parent:TUIComponent;
      
      private var _ui:MovieClip;
      
      private var _btn_getReward:MovieClip;
      
      private var _btn_info:MovieClip;
      
      private var _tf_time:TextField;
      
      private var _tf_activityTimer:TextField;
      
      private var _tf_playerNum:TextField;
      
      private var _rewardItemList:Vector.<ActivityRewardItem>;
      
      private var _rewardInfoList:Vector.<ActivityRewardInfo>;
      
      private var _slotList:Vector.<TUISlot> = new Vector.<TUISlot>();
      
      private var _callBack:Function;
      
      private var _inventories:TInventories;
      
      private var _fUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      private var _mousePos:TCoordinate;
      
      private var _info:TUnstreamizerFirstRechargeResInfo;
      
      private var _inited:Boolean;
      
      public function FirstRechargeRightPanel(param1:TUIComponent, param2:MovieClip, param3:Function, param4:TUnstreamizerFirstRechargeResInfo)
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
         this._tf_time = this._ui["tf_time"];
         this._tf_activityTimer = this._ui[CONST_FIRSTRECHAGE_NEW.RESOURCE_ACTIVITY_TIMER];
         this._tf_playerNum = this._ui["tf_peopleNum"];
         this._btn_getReward = this._ui[CONST_FIRSTRECHAGE_NEW.RESOURCE_GET_REWARD];
         TGameUtil.setButtonMode(this._btn_getReward,false);
         this._btn_getReward.mouseEnabled = false;
         this._btn_info = this._ui["btn_info"];
         TGameUtil.setButtonMode(this._btn_info,true);
         this._btn_info.addEventListener(MouseEvent.CLICK,this.activityInfoHandler);
         this._ui.addFrameScript(this._ui.totalFrames - 1,this.closeView);
         this.initRewardList();
         this.initSlotList();
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
         this._inited = true;
      }
      
      private function initEvent() : void
      {
         this._btn_getReward.addEventListener(MouseEvent.CLICK,this.onClickRewardHandler,false,0,true);
      }
      
      private function removeView() : void
      {
         this._overlayerEquipment = null;
         this._overlayerAppliance = null;
         this._overlayerAccessory = null;
         this._overlayerHelpTips = null;
         this._ui.parent.removeChild(this._ui);
         this._ui = null;
         this._parent = null;
      }
      
      private function removeEvent() : void
      {
         this._callBack = null;
         this._btn_getReward.removeEventListener(MouseEvent.CLICK,this.onClickRewardHandler);
      }
      
      private function initRewardList() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:TheFirstRecharge = null;
         var _loc4_:ActivityRewardInfo = null;
         var _loc5_:ActivityRewardItem = null;
         this._rewardInfoList = new Vector.<ActivityRewardInfo>();
         this._rewardItemList = new Vector.<ActivityRewardItem>();
         _loc1_ = [50006,50007,50008];
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TheFirstRecharge,_loc1_[_loc2_]) as TheFirstRecharge;
            _loc4_ = new ActivityRewardInfo();
            _loc4_.peopleNum = _loc3_.Fprice;
            _loc4_.rewardType = _loc2_ + 1;
            _loc4_.getState = 0;
            this._rewardInfoList.push(_loc4_);
            _loc5_ = new ActivityRewardItem(this.viewHandler);
            _loc5_.x = 2;
            _loc5_.y = _loc2_ * 61;
            this._ui["mc_itemPmc"].addChild(_loc5_);
            _loc5_.addEventListener(FirstRechargeEventTypeName.SHOW_BAG_TIP,this.bagTipHandler);
            _loc5_.addEventListener(FirstRechargeEventTypeName.HIDE_BAG_TIP,this.bagTipHandler);
            _loc5_.addEventListener(FirstRechargeEventTypeName.MOVE_BAG_TIP,this.bagTipHandler);
            _loc5_.tip = this.createTip(_loc1_[_loc2_]);
            _loc5_.initInfo(_loc4_);
            this._rewardItemList.push(_loc5_);
            _loc2_++;
         }
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
      
      private function initSlotList() : void
      {
         var _loc1_:TUISlot = null;
         var _loc5_:uint = 0;
         var _loc8_:TBins = null;
         this._slotList = new Vector.<TUISlot>(SLOT_NUM);
         var _loc2_:int = 0;
         while(_loc2_ < SLOT_NUM)
         {
            _loc1_ = new TUISlot(this._parent);
            _loc1_.Resource = this._ui[CONST_RECHARGE.RESOURCE_Link_MC_Slot + _loc2_] as MovieClip;
            _loc1_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc1_.Tag = _loc2_;
            _loc1_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc1_.OnOverlay = this.UIComponentsHintOnOver;
            _loc1_.OnOut = this.UIComponentsHintOnOut;
            _loc1_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc1_.Init();
            this._slotList[_loc2_] = _loc1_;
            _loc2_++;
         }
         this._inventories = new TInventories();
         this._fUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         var _loc3_:TheFirstRecharge = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TheFirstRecharge,50009) as TheFirstRecharge;
         var _loc4_:int = int(_loc3_.awardList.length);
         var _loc6_:Vector.<uint> = new Vector.<uint>();
         var _loc7_:Vector.<uint> = new Vector.<uint>();
         _loc8_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         var _loc9_:int = 0;
         while(_loc9_ < _loc4_)
         {
            _loc5_ = CONST_COMMON.GetItemIDByType(_loc3_.awardList[_loc9_].type,_loc3_.awardList[_loc9_].id,_loc8_);
            _loc6_.push(_loc5_);
            _loc7_.push(_loc3_.awardList[_loc9_].count);
            _loc9_++;
         }
         this._fUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this._inventories,_loc6_);
         _loc9_ = 0;
         while(_loc9_ < _loc4_)
         {
            this._inventories.GetInventoryByIndex(_loc9_).Quantity = _loc7_[_loc9_];
            _loc9_++;
         }
         _loc4_ = int(this._slotList.length);
         _loc9_ = 0;
         while(_loc9_ < _loc4_)
         {
            this._slotList[_loc9_].Context = null;
            this._slotList[_loc9_].Resource.visible = false;
            _loc9_++;
         }
         _loc4_ = this._inventories.Count;
         _loc9_ = 0;
         while(_loc9_ < _loc4_)
         {
            if(_loc9_ >= this._inventories.Count)
            {
               break;
            }
            this._slotList[_loc9_].Context = this._inventories.GetInventoryByIndex(_loc9_);
            this._slotList[_loc9_].Resource.visible = true;
            _loc9_++;
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
      
      private function onClickRewardHandler(param1:MouseEvent) : void
      {
         this._btn_getReward.mouseEnabled = false;
         this._callBack(new DatasEvent(FirstRechargeEventTypeName.CLICK_MORE_ACTIVITY_REWARD_BTN));
      }
      
      private function activityInfoHandler(param1:MouseEvent) : void
      {
         this._callBack(new DatasEvent(FirstRechargeEventTypeName.GET_ACTIVITY_INFO));
      }
      
      private function viewHandler(param1:DisplayObject, param2:*) : void
      {
         var _loc3_:int = 0;
         if(param1 is ActivityRewardItem)
         {
            ActivityRewardItem(param1).rewardBtn.mouseEnabled = false;
            _loc3_ = this._rewardItemList.indexOf(param1) + 1;
            this._callBack(new DatasEvent(FirstRechargeEventTypeName.CLICK_ACTIVITY_REWARD_BTN,_loc3_));
         }
      }
      
      private function closeView() : void
      {
         if(this._ui.parent == null)
         {
            return;
         }
         this._ui.gotoAndStop(1);
         this._callBack(new DatasEvent(FirstRechargeEventTypeName.CLOSE_RIGHT_VIEW));
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
      
      public function destroy() : void
      {
         this.removeEvent();
         this.removeView();
      }
      
      public function updateSlotList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._inited)
         {
            _loc1_ = int(this._slotList.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._slotList[_loc2_].Update();
               _loc2_++;
            }
         }
      }
      
      private function updateRewardList() : void
      {
         var _loc3_:ActivityRewardInfo = null;
         var _loc4_:ActivityRewardItem = null;
         var _loc1_:int = int(this._rewardItemList.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._rewardInfoList[_loc2_];
            _loc3_.getState = this._info.groupRechargeStauts[_loc2_];
            _loc4_ = this._rewardItemList[_loc2_];
            _loc4_.initInfo(this._rewardInfoList[_loc2_]);
            _loc2_++;
         }
      }
      
      public function updateView() : void
      {
         var _loc1_:int = 0;
         this._tf_activityTimer.text = TUtilityDate.FormatDate(new Date(this._info.startTime * 1000)) + " - " + TUtilityDate.FormatDate(new Date(this._info.endTime * 1000));
         this._tf_playerNum.text = this._info.rechargePlayer + "";
         if(this._info.maxGroupRechargeStatus == 1)
         {
            TGameUtil.setButtonMode(this._btn_getReward,true);
            this._btn_getReward.mouseEnabled = true;
            this._btn_getReward.tf_label.text = STRING_BASEACTIVITY.FORMAT_BTN_STRING_0;
            this._btn_getReward.visible = true;
            this._ui["MC_Complete"].visible = false;
            if(this._ui["TF_MaxStatus"])
            {
               this._ui["TF_MaxStatus"].visible = false;
            }
         }
         else if(this._info.maxGroupRechargeStatus == -1)
         {
            TGameUtil.setButtonMode(this._btn_getReward,false);
            this._btn_getReward.mouseEnabled = false;
            this._btn_getReward.tf_label.text = STRING_BASEACTIVITY.FORMAT_BTN_STRING_1;
            this._btn_getReward.visible = false;
            this._ui["MC_Complete"].visible = true;
            if(this._ui["TF_MaxStatus"])
            {
               this._ui["TF_MaxStatus"].visible = false;
            }
         }
         else if(this._info.maxGroupRechargeStatus == 0)
         {
            TGameUtil.setButtonMode(this._btn_getReward,false);
            this._btn_getReward.mouseEnabled = false;
            this._btn_getReward.tf_label.text = STRING_BASEACTIVITY.FORMAT_BTN_STRING_0;
            this._btn_getReward.visible = true;
            this._ui["MC_Complete"].visible = false;
            if(this._ui["TF_MaxStatus"])
            {
               this._ui["TF_MaxStatus"].visible = false;
            }
         }
         else
         {
            TGameUtil.setButtonMode(this._btn_getReward,false);
            this._btn_getReward.mouseEnabled = false;
            this._btn_getReward.tf_label.text = STRING_BASEACTIVITY.FORMAT_BTN_STRING_0;
            this._btn_getReward.visible = false;
            this._ui["MC_Complete"].visible = false;
            if(this._ui["TF_MaxStatus"])
            {
               this._ui["TF_MaxStatus"].visible = true;
            }
         }
         this.updateRewardList();
         this.updateSlotList();
      }
      
      public function setMouseCoordinate(param1:TCoordinate) : void
      {
         this._mousePos = param1;
      }
      
      public function closeingView() : void
      {
         this._ui.play();
      }
      
      public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this._info.endTime - STimingCore.GetServerTick();
         this._tf_time.text = TGameUtil.FomatDayAndTime(_loc1_);
      }
   }
}

