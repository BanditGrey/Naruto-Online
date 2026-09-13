package Processors.Game.Lobby.CrossServerWar.Window
{
   import Components.Pages.TUIPage;
   import Foundation.Common.THint;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.CrossServerWar.TEliteRecord;
   import Logics.CrossServerWar.TTokenInventorySample;
   import Logics.CrossServerWar.TTokenInventorySamples;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.CrossServerWar.Components.TUIItemExchange;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CROSSSERVERWAR;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowTokenExchange extends TProcessorLobbyWindow
   {
      
      protected const CAPACITY_Items:uint = 8;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FTF_TokenCount:TextField;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FUIPage:TUIPage;
      
      protected var FItemExchanges:Vector.<TUIItemExchange>;
      
      protected var FEliteRecord:TEliteRecord;
      
      protected var FTokenInventorySamples:TTokenInventorySamples;
      
      protected var FPageIndex:int;
      
      protected var FHint:THint;
      
      protected var FSlotOnOver:Function;
      
      protected var FSlotOnOut:Function;
      
      protected var FOnTokenExchangeClick:Function;
      
      protected var FHelpOnOver:Function;
      
      protected var FHelpOnOut:Function;
      
      public function TProcessorWindowTokenExchange(param1:TUIComponent)
      {
         super(param1);
         this.FItemExchanges = new Vector.<TUIItemExchange>();
         this.FUIPage = new TUIPage(this);
         this.FEliteRecord = SLogicsCore.EliteRecord;
         this.FHint = new THint();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:Sprite = null;
         var _loc4_:TUIItemExchange = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         var _loc7_:MovieClip = null;
         TGameUtil.AddWindowMask(this);
         _loc3_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_CROSSSERVERWAR.RESOURCE_ClassName_MC_TokenExchange) as Sprite;
         addChild(_loc3_);
         _loc3_.x = CONST_COMMON.STAGE_Width - _loc3_.width >> 1;
         _loc3_.y = CONST_COMMON.STAGE_Height - _loc3_.height >> 1;
         this.FBTN_Close = _loc3_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Close];
         this.FBTN_Help = _loc3_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Help];
         _loc2_ = this.CAPACITY_Items;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = new TUIItemExchange(this);
            _loc4_.Resource = _loc3_[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_ItemExchange + _loc1_];
            _loc4_.OnExchangeClick = this.ProcessorOnExchangeClick;
            _loc4_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc4_.SlotOnOut = this.UIComponentsHintOnOut;
            _loc4_.SlotOnOver = this.UIComponentsHintOnOver;
            _loc4_.Init();
            this.FItemExchanges[_loc1_] = _loc4_;
            _loc1_++;
         }
         _loc5_ = _loc3_[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_Page][CONST_CROSSSERVERWAR.RESOURCE_Link_MC_PageLeft];
         this.FUIPage.ButtonPrevious.Substrate = _loc5_;
         _loc5_ = _loc3_[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_Page][CONST_CROSSSERVERWAR.RESOURCE_Link_MC_PageRight];
         this.FUIPage.ButtonNext.Substrate = _loc5_;
         _loc6_ = _loc3_[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_Page][CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Page];
         this.FUIPage.LabelPage = _loc6_;
         this.FUIPage.PageSize = this.CAPACITY_Items;
         this.FUIPage.Init();
         this.FTF_TokenCount = _loc3_[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_TokenCount];
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.CloseOnClick,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.BTNHelpOnOver,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.BTNHelpOnOut,false,0,true);
         this.FUIPage.OnChangePage = this.PageOnChange;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TSystemLanguage = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_ChallengeToken) as TSystemLanguage;
         this.FHint.Content = _loc1_.Desc;
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      protected function UpdateItemInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIItemExchange = null;
         var _loc4_:int = 0;
         var _loc5_:TTokenInventorySample = null;
         if(this.FEliteRecord != null)
         {
            this.FTF_TokenCount.text = this.FEliteRecord.TokenCount.toString();
         }
         _loc2_ = this.CAPACITY_Items;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FItemExchanges[_loc1_];
            _loc3_.Resource.visible = false;
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_Items;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc1_ + this.FPageIndex * this.CAPACITY_Items;
            if(_loc4_ >= this.FTokenInventorySamples.Count)
            {
               break;
            }
            _loc3_ = this.FItemExchanges[_loc1_];
            _loc5_ = this.FTokenInventorySamples.GetInventorySampleByIndex(_loc4_);
            _loc3_.Resource.visible = true;
            _loc3_.Context = _loc5_;
            _loc3_.Update();
            _loc1_++;
         }
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FPageIndex = 0;
         this.FUIPage.TotalQuantity = this.FTokenInventorySamples.Count;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function CloseOnClick(param1:MouseEvent) : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function BTNHelpOnOver(param1:MouseEvent) : void
      {
         if(this.FHelpOnOver != null)
         {
            this.FHelpOnOver(this,this.FHint);
         }
      }
      
      protected function BTNHelpOnOut(param1:MouseEvent) : void
      {
         if(this.FHelpOnOut != null)
         {
            this.FHelpOnOut(this);
         }
      }
      
      protected function ProcessorOnExchangeClick(param1:Object, param2:Object) : void
      {
         if(this.FOnTokenExchangeClick != null)
         {
            this.FOnTokenExchangeClick(this,param2);
         }
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
         this.UpdateItemInfo();
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_CrossServerWar);
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
      
      public function get OnTokenExchangeClick() : Function
      {
         return this.FOnTokenExchangeClick;
      }
      
      public function set OnTokenExchangeClick(param1:Function) : void
      {
         this.FOnTokenExchangeClick = param1;
      }
      
      public function get HelpOnOver() : Function
      {
         return this.FHelpOnOver;
      }
      
      public function set HelpOnOver(param1:Function) : void
      {
         this.FHelpOnOver = param1;
      }
      
      public function get HelpOnOut() : Function
      {
         return this.FHelpOnOut;
      }
      
      public function set HelpOnOut(param1:Function) : void
      {
         this.FHelpOnOut = param1;
      }
      
      public function UpdateUI(param1:TTokenInventorySamples) : void
      {
         this.FTokenInventorySamples = param1;
         this.UpdateItemInfo();
         this.UpdatePageInfo();
      }
   }
}

