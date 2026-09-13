package Processors.Game.Lobby.GoodsPurchase
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TInventory;
   import Logics.Inventories.TInventorySample;
   import Logics.Inventories.TInventorySamples;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventorySamples;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MALL;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_TAVERN;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorGoodsPurchase extends TProcessorLobbyWindows
   {
      
      protected static const CurrentFrame_New:uint = 1;
      
      protected static const CurrentFrame_Hot:uint = 2;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const Window_Width:int = 330;
      
      public static const Window_Height:int = 274;
      
      protected var FPopupBox:Sprite;
      
      protected var FMC_HotOrNew:MovieClip;
      
      protected var FMC_Slot:TUISlot;
      
      protected var FTF_GoodsName:TextField;
      
      protected var FBTN_Reduce:SimpleButton;
      
      protected var FBTN_Add:SimpleButton;
      
      protected var FTF_GoodsNum:TextField;
      
      protected var FMC_Price:Sprite;
      
      protected var FMC_SpecialPrice:Sprite;
      
      protected var FMC_NormalPrice:Sprite;
      
      protected var FTF_NormalPrice:TextField;
      
      protected var FMC_Bar:Sprite;
      
      protected var FTF_DiscountPrice:TextField;
      
      protected var FMC_VIP:MovieClip;
      
      protected var FMC_NowPrice:MovieClip;
      
      protected var FTF_NowPrice:TextField;
      
      protected var FTF_NoVIP:TextField;
      
      protected var FTF_OriginalPrice:TextField;
      
      protected var FBTN_Confirm:MovieClip;
      
      protected var FBTN_Cancel:MovieClip;
      
      protected var FBTN_BecomeVIP:MovieClip;
      
      protected var FUnstreamizerInventorySamples:TUnstreamizerInventorySamples;
      
      protected var FInventorySamples:TInventorySamples;
      
      protected var FCurrentInventorySamples:TInventorySamples;
      
      protected var FBtnList:Vector.<MovieClip>;
      
      protected var FInventorySample:TInventorySample;
      
      protected var FGoodsNum:int;
      
      protected var FCurrentPrice:uint;
      
      protected var FTotalPrice:uint;
      
      protected var FOnMallBuy:Function;
      
      protected var FInitialized:Boolean;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FSlotOnOver:Function;
      
      protected var FSlotOnOut:Function;
      
      protected var FMallOnBuy:Function;
      
      protected var FOnOpenVIP:Function;
      
      public function TProcessorGoodsPurchase(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FInventorySamples = new TInventorySamples();
         this.FCurrentInventorySamples = new TInventorySamples();
         this.FUnstreamizerInventorySamples = new TUnstreamizerInventorySamples();
         this.FMC_Slot = new TUISlot(this);
         this.FBtnList = new Vector.<MovieClip>();
         this.FGoodsNum = 1;
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_GoodsPurchase);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_GoodsPurchase);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_GoodsPurchase);
         FOverlayerAppliance.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_GoodsPurchase);
         FOverlayerAccessory.Visible = false;
         this.FInitialized = false;
         FResourcesState = RESOURCESSTATE_UIRequest;
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2 - 20;
         SetUIModuleID(CONST_MODULES.MODULE_GoodsPurchase);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfCommon.LoadPrimary(CONST_COMMON.RESOURCESID_Swf_Common);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FPopupBox = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_GoodsPurchase) as Sprite;
         addChild(this.FPopupBox);
         this.FMC_HotOrNew = this.FPopupBox[CONST_MALL.RESOURCE_Link_MC_HotOrNew];
         this.FMC_Slot.Resource = this.FPopupBox[CONST_MALL.RESOURCE_Link_MC_Slot];
         this.FMC_Slot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FMC_Slot.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FMC_Slot.OnOverlay = UIComponentsHintOnOver;
         this.FMC_Slot.OnOut = UIComponentsHintOnOut;
         this.FMC_Slot.Init();
         this.FTF_GoodsName = this.FPopupBox[CONST_MALL.RESOURCE_Link_TF_GoodsName];
         this.FTF_GoodsName.mouseEnabled = false;
         this.FTF_GoodsName.autoSize = "left";
         this.FTF_GoodsNum = this.FPopupBox[CONST_MALL.RESOURCE_Link_TF_GoodsNum];
         this.FTF_GoodsNum.restrict = "0-9";
         this.FTF_GoodsNum.maxChars = 5;
         this.FBTN_Confirm = this.FPopupBox[CONST_MALL.RESOURCE_Link_BTN_Confirm];
         TGameUtil.setButtonMode(this.FBTN_Confirm,true);
         this.FBtnList.push(this.FBTN_Confirm);
         this.FBTN_Cancel = this.FPopupBox[CONST_MALL.RESOURCE_Link_BTN_Cancel];
         TGameUtil.setButtonMode(this.FBTN_Cancel,true);
         this.FBtnList.push(this.FBTN_Cancel);
         this.FBTN_Add = this.FPopupBox[CONST_MALL.RESOURCE_Link_BTN_Add];
         this.FBTN_Reduce = this.FPopupBox[CONST_MALL.RESOURCE_Link_BTN_Reduce];
         this.FMC_Price = this.FPopupBox[CONST_MALL.RESOURCE_Link_MC_Price];
         this.FMC_SpecialPrice = this.FMC_Price[CONST_MALL.RESOURCE_Link_MC_SpecialPrice];
         this.FMC_Bar = this.FMC_SpecialPrice[CONST_MALL.RESOURCE_Link_MC_Bar];
         this.FTF_OriginalPrice = this.FMC_SpecialPrice[CONST_MALL.RESOURCE_Link_TF_OriginalPrice];
         this.FTF_OriginalPrice.mouseEnabled = false;
         this.FTF_DiscountPrice = this.FMC_SpecialPrice[CONST_MALL.RESOURCE_Link_TF_DiscountPrice];
         this.FTF_DiscountPrice.mouseEnabled = false;
         this.FMC_VIP = this.FMC_SpecialPrice[CONST_MALL.RESOURCE_Link_MC_VIP];
         this.FBTN_BecomeVIP = this.FMC_SpecialPrice[CONST_MALL.RESOURCE_Link_BTN_BecomeVIP];
         TGameUtil.setButtonMode(this.FBTN_BecomeVIP,true);
         this.FBtnList.push(this.FBTN_BecomeVIP);
         this.FMC_NowPrice = this.FMC_SpecialPrice[CONST_MALL.RESOURCE_Link_MC_NowPrice];
         this.FTF_NowPrice = this.FMC_NowPrice[CONST_MALL.RESOURCE_Link_TF_NowPrice];
         this.FTF_NowPrice.mouseEnabled = false;
         this.FTF_NoVIP = this.FMC_NowPrice[CONST_MALL.RESOURCE_Link_TF_NoVIP];
         this.FTF_NoVIP.mouseEnabled = false;
         this.FMC_NormalPrice = this.FMC_Price[CONST_MALL.RESOURCE_Link_MC_NormalPrice];
         this.FTF_NormalPrice = this.FMC_NormalPrice[CONST_MALL.RESOURCE_Link_TF_NormallPrice];
         this.FTF_NormalPrice.mouseEnabled = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         this.FInitialized = true;
         this.FPopupBox.visible = false;
         this.Visible = false;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Reduce.addEventListener(MouseEvent.CLICK,this.ReduceOnClick,false,0,true);
         this.FBTN_Add.addEventListener(MouseEvent.CLICK,this.AddOnClick,false,0,true);
         this.FBTN_Confirm.addEventListener(MouseEvent.CLICK,this.ConfirmOnClick,false,0,true);
         this.FBTN_Cancel.addEventListener(MouseEvent.CLICK,this.CloseOnClick,false,0,true);
         this.FBTN_BecomeVIP.addEventListener(MouseEvent.CLICK,this.BecomeVIPOnClick,false,0,true);
         this.FTF_GoodsNum.addEventListener(Event.CHANGE,this.OnTextInput,false,0,true);
         setChildIndex(this.FPopupBox,0);
         this.FUnstreamizerInventorySamples.UnstreamizeInventorySamplesByDatabase(null,this.FInventorySamples,null);
         this.FilterGoodsInfo();
         this.SetRecommendWindow();
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FMC_Slot != null)
         {
            this.FMC_Slot.Update();
         }
      }
      
      protected function SetRecommendWindow() : void
      {
         this.FPopupBox.x = CONST_COMMON.STAGE_Width - Window_Width >> 1;
         this.FPopupBox.y = CONST_COMMON.STAGE_Height - Window_Height >> 1;
      }
      
      protected function UpdateSlotInfo() : void
      {
         var _loc1_:uint = 0;
         this.FMC_Slot.Context = this.FInventorySample.Inventory;
         this.FTF_GoodsName.text = this.FInventorySample.Name;
         this.FTF_GoodsNum.text = this.FGoodsNum.toString();
         if(this.FInventorySample.IsHot > this.FInventorySample.IsNew)
         {
            _loc1_ = CurrentFrame_Hot;
         }
         else if(this.FInventorySample.IsHot == this.FInventorySample.IsNew)
         {
            _loc1_ = 0;
         }
         else
         {
            _loc1_ = CurrentFrame_New;
         }
         if(_loc1_ != 0)
         {
            this.FMC_HotOrNew.gotoAndStop(_loc1_);
            this.FMC_HotOrNew.visible = true;
         }
         else
         {
            this.FMC_HotOrNew.visible = false;
         }
      }
      
      protected function UpdatePrice() : void
      {
         this.FTF_GoodsNum.text = this.FGoodsNum.toString();
         if(this.FInventorySample.IsNew == 1)
         {
            this.FBTN_BecomeVIP.visible = false;
            this.FMC_NormalPrice.visible = true;
            this.FMC_SpecialPrice.visible = false;
            this.FTF_NormalPrice.text = (this.FInventorySample.HotPrice * this.FGoodsNum).toString();
            this.FCurrentPrice = this.FInventorySample.HotPrice;
            this.FTotalPrice = uint(this.FTF_NormalPrice.text);
         }
         else
         {
            this.FMC_NormalPrice.visible = false;
            this.FMC_SpecialPrice.visible = true;
            this.FTF_OriginalPrice.text = (this.FInventorySample.CostGold * this.FGoodsNum).toString();
            this.FTotalPrice = uint(this.FTF_OriginalPrice.text);
            if(this.FInventorySample.IsHot == 1)
            {
               this.FBTN_BecomeVIP.visible = false;
               this.FMC_Bar.visible = true;
               this.FTF_NowPrice.text = (this.FInventorySample.HotPrice * this.FGoodsNum).toString();
               this.FTF_DiscountPrice.visible = true;
               this.FMC_VIP.visible = false;
               this.FTF_NowPrice.visible = true;
               this.FTF_NoVIP.visible = false;
               this.FCurrentPrice = this.FInventorySample.HotPrice;
               this.FTotalPrice = uint(this.FTF_NowPrice.text);
            }
            else
            {
               this.FTF_DiscountPrice.visible = false;
               this.FMC_VIP.visible = true;
               if(this.FInventorySample.VipLevel <= SLogicsCore.Character.VipLevel)
               {
                  this.FBTN_BecomeVIP.visible = false;
                  this.FMC_Bar.visible = true;
                  this.FMC_VIP.gotoAndStop(1);
                  this.FTF_NowPrice.text = (this.FInventorySample.Discount * this.FGoodsNum).toString();
                  this.FTF_NowPrice.visible = true;
                  this.FTF_NoVIP.visible = false;
                  this.FCurrentPrice = this.FInventorySample.Discount;
                  this.FTotalPrice = uint(this.FTF_NowPrice.text);
               }
               else
               {
                  this.FBTN_BecomeVIP.visible = true;
                  this.FMC_Bar.visible = false;
                  this.FMC_VIP.gotoAndStop(2);
                  this.FTF_NoVIP.text = (this.FInventorySample.Discount * this.FGoodsNum).toString();
                  this.FCurrentPrice = this.FInventorySample.CostGold;
                  this.FTF_NoVIP.visible = true;
                  this.FTF_NowPrice.visible = false;
               }
            }
         }
      }
      
      protected function FilterGoodsInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TInventorySample = null;
         this.FCurrentInventorySamples.Clear();
         _loc2_ = uint(this.FInventorySamples.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FInventorySamples.GetInventorySampleByIndex(_loc1_);
            if(_loc3_.IsDisplay == 1 && _loc3_.Model == 2)
            {
               this.FCurrentInventorySamples.Add(_loc3_);
            }
            _loc1_++;
         }
      }
      
      protected function ReduceOnClick(param1:MouseEvent) : void
      {
         --this.FGoodsNum;
         if(this.FGoodsNum <= 0)
         {
            this.FGoodsNum = 1;
         }
         this.UpdatePrice();
      }
      
      protected function AddOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         ++this.FGoodsNum;
         this.UpdatePrice();
         _loc2_ = (SLogicsCore.Character.CreditGold + SLogicsCore.Character.CreditGiftCertificate) / this.FCurrentPrice;
         if(_loc2_ <= 0)
         {
            this.FGoodsNum = 1;
            this.UpdatePrice();
            return;
         }
         if(this.FGoodsNum > _loc2_)
         {
            this.FGoodsNum = _loc2_;
            this.UpdatePrice();
         }
      }
      
      protected function ConfirmOnClick(param1:MouseEvent) : void
      {
         this.FPopupBox.visible = false;
         this.Visible = false;
         if(this.FTotalPrice > SLogicsCore.Character.CreditGold + SLogicsCore.Character.CreditGiftCertificate)
         {
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         if(this.FMallOnBuy != null)
         {
            this.FMallOnBuy(this,this.FGoodsNum,this.FInventorySample,this.FOnMallBuy);
         }
      }
      
      protected function CloseOnClick(param1:MouseEvent) : void
      {
         this.FPopupBox.visible = false;
         this.Visible = false;
      }
      
      protected function BecomeVIPOnClick(param1:MouseEvent) : void
      {
         this.CloseOnClick(null);
         if(this.FOnOpenVIP != null)
         {
            this.FOnOpenVIP(this);
         }
      }
      
      protected function OnTextInput(param1:Event) : void
      {
         var _loc2_:uint = 0;
         this.FGoodsNum = uint(this.FTF_GoodsNum.text) > 0 ? int(uint(this.FTF_GoodsNum.text)) : 1;
         this.UpdatePrice();
         _loc2_ = (SLogicsCore.Character.CreditGold + SLogicsCore.Character.CreditGiftCertificate) / this.FCurrentPrice;
         if(this.FGoodsNum > _loc2_)
         {
            this.FGoodsNum = _loc2_;
            this.UpdatePrice();
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_GoodsPurchase);
         }
      }
      
      public function get SlotOnOver() : Function
      {
         return this.FSlotOnOver;
      }
      
      public function set SlotOnOver(param1:Function) : void
      {
         this.FSlotOnOver = param1;
      }
      
      public function get SlotOnOut() : Function
      {
         return this.FSlotOnOut;
      }
      
      public function set SlotOnOut(param1:Function) : void
      {
         this.FSlotOnOut = param1;
      }
      
      public function get MallOnBuy() : Function
      {
         return this.FMallOnBuy;
      }
      
      public function set MallOnBuy(param1:Function) : void
      {
         this.FMallOnBuy = param1;
      }
      
      public function get OnOpenVIP() : Function
      {
         return this.FOnOpenVIP;
      }
      
      public function set OnOpenVIP(param1:Function) : void
      {
         this.FOnOpenVIP = param1;
      }
      
      public function UpdateData(param1:Object) : void
      {
         var _loc2_:TInventorySample = null;
         _loc2_ = param1 as TInventorySample;
         this.FPopupBox.visible = true;
         this.Visible = true;
         this.FInventorySample = _loc2_;
         this.FGoodsNum = 1;
         this.UpdateSlotInfo();
         this.UpdatePrice();
      }
      
      public function UseMallBuy(param1:uint, param2:uint, param3:Function) : void
      {
         var _loc4_:TInventorySample = null;
         this.FOnMallBuy = param3;
         _loc4_ = this.FCurrentInventorySamples.GetInventorySampleByTemplateID(param1);
         this.FInventorySample = _loc4_;
         this.FGoodsNum = param2;
         this.UpdateSlotInfo();
         this.UpdatePrice();
         this.FPopupBox.visible = true;
         this.Visible = true;
      }
      
      public function ShowEffectText(param1:uint) : void
      {
         if(param1 != 0)
         {
            EffectGenerateTextByErrorCode(param1);
         }
         else
         {
            EffectGenerateText(STRING_TAVERN.BuySuccessful);
         }
      }
      
      public function SetButtonLockOrUnlock(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         _loc3_ = this.FBtnList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            TGameUtil.LockOrUnlockButton(this.FBtnList[_loc2_],param1);
            _loc2_++;
         }
      }
   }
}

