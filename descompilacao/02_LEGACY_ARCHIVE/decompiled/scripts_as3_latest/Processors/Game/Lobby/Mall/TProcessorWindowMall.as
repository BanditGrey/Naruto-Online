package Processors.Game.Lobby.Mall
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Externals.SExternalCore;
   import Foundation.Common.THint;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TInventory;
   import Logics.Inventories.TInventorySample;
   import Logics.Inventories.TInventorySamples;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Mall.Components.TUIMallItem;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MALL;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowMall extends TProcessorLobbyWindow
   {
      
      protected const Tab_HotOrNew:uint = 0;
      
      protected const Tab_Material:uint = 6;
      
      protected const Tab_KeepStone:uint = 7;
      
      protected var FMC_Tab:TUITab;
      
      protected var FMC_VIPDiscount:Sprite;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FMC_PopupBox:Sprite;
      
      protected var FTF_Gold:TextField;
      
      protected var FTF_Coupon:TextField;
      
      protected var FMC_Page:MovieClip;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_EffectLeft:MovieClip;
      
      protected var FMC_EffectRight:MovieClip;
      
      protected var FBTN_Recharge:MovieClip;
      
      protected var FMallItemList:Vector.<TUIMallItem>;
      
      protected var FInventorySamples:TInventorySamples;
      
      protected var FCurrentInventorySamples:TInventorySamples;
      
      protected var FTabIndex:uint;
      
      protected var FPageIndex:uint;
      
      protected var FinitData:Boolean;
      
      protected var FHelpHint:THint;
      
      protected var FSlotOnOver:Function;
      
      protected var FSlotOnOut:Function;
      
      protected var FItemOnClick:Function;
      
      protected var FHelpHintOnOver:Function;
      
      protected var FHelpHintOnOut:Function;
      
      public function TProcessorWindowMall(param1:TUIComponent)
      {
         super(param1);
         this.FMC_Tab = new TUITab(this);
         this.FUIPage = new TUIPage(this);
         this.FMallItemList = new Vector.<TUIMallItem>(CONST_MALL.Capacity_MallItems);
         this.FCurrentInventorySamples = new TInventorySamples();
         this.FinitData = false;
         this.FTabIndex = 0;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_MALL.RESOURCESID_SWF_MALL);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:Sprite = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         var _loc7_:TUIMallItem = null;
         var _loc8_:MovieClip = null;
         var _loc9_:TSystemLanguage = null;
         _loc3_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_MALL.RESOURCE_ClassName_Mall) as Sprite;
         addChild(_loc3_);
         _loc2_ = CONST_MALL.Capacity_Tabs;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_[CONST_MALL.RESOURCE_Link_MC_Tab + _loc1_];
            this.FMC_Tab.SetTabByIndex(_loc4_,_loc1_);
            _loc1_++;
         }
         this.FMC_Tab.OnSwitch = this.TabOnSwitch;
         this.FMC_Tab.Init();
         this.FMC_Page = _loc3_[CONST_MALL.RESOURCE_Link_MC_Page];
         _loc5_ = this.FMC_Page[CONST_MALL.RESOURCE_Link_MC_PageLeft];
         this.FUIPage.ButtonPrevious.Substrate = _loc5_;
         _loc5_ = this.FMC_Page[CONST_MALL.RESOURCE_Link_MC_PageRight];
         this.FUIPage.ButtonNext.Substrate = _loc5_;
         _loc6_ = this.FMC_Page[CONST_MALL.RESOURCE_Link_TF_Page];
         this.FUIPage.LabelPage = _loc6_;
         _loc6_.text = "0/0";
         this.FUIPage.PageSize = CONST_MALL.Capacity_MallItems;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.PageOnChange;
         this.FMC_VIPDiscount = _loc3_[CONST_MALL.RESOURCE_Link_MC_VIPDiscount];
         this.FTF_Gold = _loc3_[CONST_MALL.RESOURCE_Link_TF_Gold];
         this.FTF_Coupon = _loc3_[CONST_MALL.RESOURCE_Link_TF_Coupon];
         _loc2_ = this.FMallItemList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc8_ = _loc3_[CONST_MALL.RESOURCE_Link_MC_MallItem + _loc1_];
            _loc7_ = new TUIMallItem(this);
            _loc7_.Tag = _loc1_;
            _loc7_.Substrate = _loc8_;
            _loc7_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc7_.SlotOnOut = this.UIComponentsHintOnOut;
            _loc7_.SlotOnOver = this.UIComponentsHintOnOver;
            _loc7_.ItemOnClick = this.ProcessorItemOnClick;
            _loc7_.Perform_UIDispatch();
            _loc7_.Init();
            this.FMallItemList[_loc1_] = _loc7_;
            _loc1_++;
         }
         this.FBTN_Close = _loc3_[CONST_MALL.RESOURCE_Link_BTN_Close];
         this.FBTN_Help = _loc3_[CONST_MALL.RESOURCE_Link_BTN_Help];
         this.FBTN_Recharge = _loc3_[CONST_MALL.RESOURCE_Link_BTN_Recharge];
         TGameUtil.setButtonMode(this.FBTN_Recharge,true);
         this.FMC_EffectLeft = _loc3_[CONST_MALL.RESOURCE_Link_MC_EffectLeft];
         this.FMC_EffectRight = _loc3_[CONST_MALL.RESOURCE_Link_MC_EffectRight];
         this.FHelpHint = new THint();
         _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_MALL) as TSystemLanguage;
         this.FHelpHint.Content = _loc9_.Desc;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.CloseOnClick,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.OnHintHelpMove,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.ROLL_OUT,this.OnHintHelpOut,false,0,true);
         this.FBTN_Recharge.addEventListener(MouseEvent.CLICK,this.RechargeOnClick,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIMallItem = null;
         if(this.FinitData == true)
         {
            _loc2_ = this.FMallItemList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.FMallItemList[_loc1_];
               _loc3_.UpdateSlot();
               _loc1_++;
            }
         }
         super.LogicsPerform();
      }
      
      protected function UpdateMallItemsInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TUIMallItem = null;
         var _loc6_:TInventorySample = null;
         var _loc7_:int = 0;
         _loc2_ = uint(this.FCurrentInventorySamples.Count);
         _loc3_ = this.FMallItemList.length;
         _loc4_ = _loc2_ - this.FPageIndex * _loc3_;
         if(_loc4_ < _loc3_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc3_ - _loc4_)
            {
               this.FMallItemList[_loc3_ - 1 - _loc7_].Substrate.visible = false;
               _loc7_++;
            }
         }
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            if(_loc1_ + this.FPageIndex * _loc3_ >= _loc2_)
            {
               break;
            }
            _loc5_ = this.FMallItemList[_loc1_];
            _loc6_ = this.FCurrentInventorySamples.GetInventorySampleByIndex(_loc1_ + this.FPageIndex * _loc3_);
            _loc5_.Context = _loc6_;
            _loc5_.SetMallItemInfo();
            _loc5_.Substrate.visible = true;
            _loc1_++;
         }
      }
      
      protected function FilterTabMallItem() : void
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
               if(this.FTabIndex == this.Tab_HotOrNew && (Boolean(_loc3_.IsHot) || Boolean(_loc3_.IsNew)))
               {
                  this.FCurrentInventorySamples.Add(_loc3_);
               }
               else if(_loc3_.Page == this.FTabIndex + 1)
               {
                  this.FCurrentInventorySamples.Add(_loc3_);
               }
            }
            _loc1_++;
         }
         this.FMC_VIPDiscount.visible = this.FTabIndex != this.Tab_HotOrNew;
      }
      
      protected function UpdateCharacterMoney() : void
      {
         this.FTF_Gold.text = SLogicsCore.Character.CreditGold.toString();
         this.FTF_Coupon.text = SLogicsCore.Character.CreditGiftCertificate.toString();
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FPageIndex = 0;
         this.FUIPage.TotalQuantity = this.FCurrentInventorySamples.Count;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function CloseOnClick(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      protected function OnHintHelpMove(param1:MouseEvent) : void
      {
         if(this.FHelpHintOnOver != null)
         {
            this.FHelpHintOnOver(this,this.FHelpHint);
         }
      }
      
      protected function OnHintHelpOut(param1:MouseEvent) : void
      {
         if(this.FHelpHintOnOut != null)
         {
            this.FHelpHintOnOut(this);
         }
      }
      
      protected function RechargeOnClick(param1:MouseEvent) : void
      {
         SExternalCore.NavigateToRecharge();
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FTabIndex = param1 as uint;
         this.FPageIndex = 0;
         if(this.FinitData)
         {
            this.FilterTabMallItem();
            this.UpdateMallItemsInfo();
            this.UpdatePageInfo();
         }
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndex = param2;
         this.UpdateMallItemsInfo();
      }
      
      protected function ProcessorItemOnClick(param1:Object, param2:Object) : void
      {
         if(this.FItemOnClick != null)
         {
            this.FItemOnClick(param1,param2);
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_OldMall);
         }
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:TInventory) : void
      {
         if(this.FSlotOnOver != null)
         {
            this.FSlotOnOver(param1,param2);
         }
      }
      
      protected function UIComponentsHintOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FSlotOnOut != null)
         {
            this.FSlotOnOut(param1,param2);
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
      
      public function get ItemOnClick() : Function
      {
         return this.FItemOnClick;
      }
      
      public function set ItemOnClick(param1:Function) : void
      {
         this.FItemOnClick = param1;
      }
      
      public function get HelpHintOnOver() : Function
      {
         return this.FHelpHintOnOver;
      }
      
      public function set HelpHintOnOver(param1:Function) : void
      {
         this.FHelpHintOnOver = param1;
      }
      
      public function get HelpHintOnOut() : Function
      {
         return this.FHelpHintOnOut;
      }
      
      public function set HelpHintOnOut(param1:Function) : void
      {
         this.FHelpHintOnOut = param1;
      }
      
      public function InitData(param1:TInventorySamples) : void
      {
         this.FInventorySamples = param1;
         this.FilterTabMallItem();
         this.UpdateMallItemsInfo();
         this.UpdateCharacterMoney();
         this.UpdatePageInfo();
         this.FinitData = true;
      }
      
      public function PlayEffect() : void
      {
         this.FMC_EffectLeft.play();
         this.FMC_EffectRight.play();
      }
      
      public function UpdateMoney() : void
      {
         this.UpdateCharacterMoney();
      }
      
      public function SetTabIndex(param1:uint) : void
      {
         this.TabOnSwitch(param1);
         this.FMC_Tab.TabIndex = param1;
      }
   }
}

