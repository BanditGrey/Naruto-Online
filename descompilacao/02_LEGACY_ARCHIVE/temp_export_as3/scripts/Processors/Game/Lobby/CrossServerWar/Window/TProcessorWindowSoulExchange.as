package Processors.Game.Lobby.CrossServerWar.Window
{
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.CrossServerWar.TEliteRecord;
   import Logics.CrossServerWar.TOrangeInventorySample;
   import Logics.CrossServerWar.TOrangeInventorySamples;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.CrossServerWar.Components.TUIHeroExchange;
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
   
   public class TProcessorWindowSoulExchange extends TProcessorLobbyWindow
   {
      
      protected const CAPACITY_Heros:uint = 3;
      
      protected const CAPACITY_Items:uint = 8;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FMC_HerosExchange:Sprite;
      
      protected var FMC_ItemsExchange:Sprite;
      
      protected var FBTN_Left_A:MovieClip;
      
      protected var FBTN_Right_A:MovieClip;
      
      protected var FBTN_Left_B:MovieClip;
      
      protected var FBTN_Right_B:MovieClip;
      
      protected var FTF_OrangeCount:TextField;
      
      protected var FUITab:TUITab;
      
      protected var FHeroCurPage:int;
      
      protected var FItemCurPage:int;
      
      protected var FHeroTotalPage:int;
      
      protected var FItemTotalPage:int;
      
      protected var FUIHeroExhanges:Vector.<TUIHeroExchange>;
      
      protected var FUIItemExhanges:Vector.<TUIItemExchange>;
      
      protected var FOrangeInventorySamples:TOrangeInventorySamples;
      
      protected var FOrangeHeros:TOrangeInventorySamples;
      
      protected var FOrangeItems:TOrangeInventorySamples;
      
      protected var FHint:THint;
      
      protected var FEliteRecord:TEliteRecord;
      
      protected var FTabIndex:int;
      
      protected var FSlotOnOver:Function;
      
      protected var FSlotOnOut:Function;
      
      protected var FOnRecruitCLick:Function;
      
      protected var FOnItemExchangeClick:Function;
      
      protected var FHelpOnOver:Function;
      
      protected var FHelpOnOut:Function;
      
      protected var Cur_index_tab:int;
      
      public function TProcessorWindowSoulExchange(param1:TUIComponent)
      {
         super(param1);
         this.FUIHeroExhanges = new Vector.<TUIHeroExchange>();
         this.FUIItemExhanges = new Vector.<TUIItemExchange>();
         this.FOrangeHeros = new TOrangeInventorySamples();
         this.FOrangeItems = new TOrangeInventorySamples();
         this.FEliteRecord = SLogicsCore.EliteRecord;
         this.FUITab = new TUITab(this);
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
         var _loc4_:TUIHeroExchange = null;
         var _loc5_:TUIItemExchange = null;
         var _loc6_:MovieClip = null;
         TGameUtil.AddWindowMask(this);
         _loc3_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_CROSSSERVERWAR.RESOURCE_ClassName_MC_SoulExchange) as Sprite;
         addChild(_loc3_);
         _loc3_.x = CONST_COMMON.STAGE_Width - _loc3_.width >> 1;
         _loc3_.y = CONST_COMMON.STAGE_Height - _loc3_.height >> 1;
         this.FMC_HerosExchange = _loc3_[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_HerosExchange];
         this.FBTN_Left_A = this.FMC_HerosExchange[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Left];
         this.FBTN_Right_A = this.FMC_HerosExchange[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Right];
         TGameUtil.setButtonMode(this.FBTN_Left_A,true);
         TGameUtil.setButtonMode(this.FBTN_Right_A,true);
         _loc2_ = this.CAPACITY_Heros;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = new TUIHeroExchange(this);
            _loc4_.Resource = this.FMC_HerosExchange[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_Hero + _loc1_];
            _loc4_.OnRecruitClick = this.ProcessorOnRecruitClick;
            _loc4_.Init();
            this.FUIHeroExhanges[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FMC_ItemsExchange = _loc3_[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_ItemsExchange];
         this.FBTN_Left_B = this.FMC_ItemsExchange[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Left];
         this.FBTN_Right_B = this.FMC_ItemsExchange[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Right];
         TGameUtil.setButtonMode(this.FBTN_Left_B,true);
         TGameUtil.setButtonMode(this.FBTN_Right_B,true);
         _loc2_ = this.CAPACITY_Items;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = new TUIItemExchange(this);
            _loc5_.Resource = this.FMC_ItemsExchange[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_ItemExchange + _loc1_];
            _loc5_.OnExchangeClick = this.ProcessorOnExchangeClick;
            _loc5_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc5_.SlotOnOut = this.UIComponentsHintOnOut;
            _loc5_.SlotOnOver = this.UIComponentsHintOnOver;
            _loc5_.Init();
            this.FUIItemExhanges[_loc1_] = _loc5_;
            _loc1_++;
         }
         this.FBTN_Close = _loc3_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Close];
         this.FBTN_Help = _loc3_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Help];
         this.FTF_OrangeCount = _loc3_["TF_OrangeCount"];
         _loc2_ = 2;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = _loc3_["MC_Tab_" + _loc1_];
            this.FUITab.SetTabByIndex(_loc6_,_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.CloseOnClick,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.BTNHelpOnOver,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.BTNHelpOnOut,false,0,true);
         this.FBTN_Left_A.addEventListener(MouseEvent.CLICK,this.BTNLeftHeroOnClick,false,0,true);
         this.FBTN_Right_A.addEventListener(MouseEvent.CLICK,this.BTNRightHeroOnClick,false,0,true);
         this.FBTN_Left_B.addEventListener(MouseEvent.CLICK,this.BTNLeftItemOnClick,false,0,true);
         this.FBTN_Right_B.addEventListener(MouseEvent.CLICK,this.BTNRightItemOnClick,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TSystemLanguage = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_OrangeStone) as TSystemLanguage;
         this.FHint.Content = _loc1_.Desc;
         super.ResourcesPerform_UIFinalize();
      }
      
      protected function UpdateUIHeroExchange() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIHeroExchange = null;
         var _loc4_:TOrangeInventorySample = null;
         var _loc5_:int = 0;
         _loc2_ = this.CAPACITY_Heros;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIHeroExhanges[_loc1_];
            _loc3_.Resource.visible = false;
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_Heros;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = _loc1_ + (this.FHeroCurPage - 1) * this.CAPACITY_Heros;
            if(_loc5_ >= this.FOrangeHeros.Count)
            {
               break;
            }
            _loc3_ = this.FUIHeroExhanges[_loc1_];
            _loc4_ = this.FOrangeHeros.GetInventorySampleByIndex(_loc5_);
            _loc3_.Context = _loc4_;
            _loc3_.Resource.visible = true;
            _loc3_.Update();
            _loc1_++;
         }
      }
      
      protected function UpdateUIItemExchange() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIItemExchange = null;
         var _loc4_:int = 0;
         var _loc5_:TOrangeInventorySample = null;
         _loc2_ = this.CAPACITY_Items;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIItemExhanges[_loc1_];
            _loc3_.Resource.visible = false;
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_Items;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc1_ + (this.FItemCurPage - 1) * this.CAPACITY_Items;
            if(_loc4_ >= this.FOrangeItems.Count)
            {
               break;
            }
            _loc3_ = this.FUIItemExhanges[_loc1_];
            _loc5_ = this.FOrangeItems.GetInventorySampleByIndex(_loc4_);
            _loc3_.Resource.visible = true;
            _loc3_.Context = _loc5_;
            _loc3_.Update();
            _loc1_++;
         }
      }
      
      protected function UpdateHeroPage() : void
      {
         this.FBTN_Left_A.visible = Boolean(this.FHeroCurPage != 1);
         this.FBTN_Right_A.visible = Boolean(this.FHeroCurPage != this.FHeroTotalPage);
      }
      
      protected function UpdateOrangeSoul() : void
      {
         this.FTF_OrangeCount.text = this.FEliteRecord.OrangeSoulCount.toString();
      }
      
      protected function UpdateItemPage() : void
      {
         this.FBTN_Left_B.visible = Boolean(this.FItemCurPage != 1);
         this.FBTN_Right_B.visible = Boolean(this.FItemCurPage != this.FItemTotalPage);
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
      
      protected function ProcessorOnRecruitClick(param1:Object, param2:Object) : void
      {
         if(this.FOnRecruitCLick != null)
         {
            this.FOnRecruitCLick(this,param2);
         }
      }
      
      protected function ProcessorOnExchangeClick(param1:Object, param2:Object) : void
      {
         if(this.FOnItemExchangeClick != null)
         {
            this.FOnItemExchangeClick(this,param2);
         }
      }
      
      protected function BTNLeftHeroOnClick(param1:MouseEvent = null) : void
      {
         --this.FHeroCurPage;
         if(this.FHeroCurPage < 1)
         {
            this.FHeroCurPage = 1;
         }
         this.UpdateHeroPage();
         this.UpdateUIHeroExchange();
      }
      
      protected function BTNRightHeroOnClick(param1:MouseEvent = null) : void
      {
         ++this.FHeroCurPage;
         if(this.FHeroCurPage > this.FHeroTotalPage)
         {
            this.FHeroCurPage = this.FHeroTotalPage;
         }
         this.UpdateHeroPage();
         this.UpdateUIHeroExchange();
      }
      
      protected function BTNLeftItemOnClick(param1:MouseEvent = null) : void
      {
         --this.FItemCurPage;
         if(this.FItemCurPage < 1)
         {
            this.FItemCurPage = 1;
         }
         this.UpdateItemPage();
         this.UpdateUIItemExchange();
      }
      
      protected function BTNRightItemOnClick(param1:MouseEvent = null) : void
      {
         ++this.FItemCurPage;
         if(this.FItemCurPage > this.FItemTotalPage)
         {
            this.FItemCurPage = this.FItemTotalPage;
         }
         this.UpdateItemPage();
         this.UpdateUIItemExchange();
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
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FTabIndex = param1 as int;
         this.Cur_index_tab = this.FTabIndex;
         if(this.FTabIndex == 0)
         {
            this.FMC_HerosExchange.visible = true;
            this.FMC_ItemsExchange.visible = false;
            this.UpdateHeroPage();
            this.UpdateUIHeroExchange();
         }
         else
         {
            this.FMC_HerosExchange.visible = false;
            this.FMC_ItemsExchange.visible = true;
            this.UpdateItemPage();
            this.UpdateUIItemExchange();
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
      
      public function get OnRecruitCLick() : Function
      {
         return this.FOnRecruitCLick;
      }
      
      public function set OnRecruitCLick(param1:Function) : void
      {
         this.FOnRecruitCLick = param1;
      }
      
      public function get OnItemExchangeClick() : Function
      {
         return this.FOnItemExchangeClick;
      }
      
      public function set OnItemExchangeClick(param1:Function) : void
      {
         this.FOnItemExchangeClick = param1;
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
      
      public function UpdateUI(param1:TOrangeInventorySamples) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TOrangeInventorySample = null;
         this.FOrangeInventorySamples = param1;
         this.FOrangeItems.Clear();
         this.FOrangeHeros.Clear();
         _loc3_ = uint(this.FOrangeInventorySamples.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FOrangeInventorySamples.GetInventorySampleByIndex(_loc2_);
            if(_loc4_.Type == 1)
            {
               this.FOrangeItems.Add(_loc4_);
            }
            else if(_loc4_.Type == 4)
            {
               this.FOrangeHeros.Add(_loc4_);
            }
            _loc2_++;
         }
         this.FHeroCurPage = 1;
         this.FHeroTotalPage = Math.max(Math.ceil(this.FOrangeHeros.Count / this.CAPACITY_Heros),1);
         this.FItemCurPage = 1;
         this.FItemTotalPage = Math.max(Math.ceil(this.FOrangeItems.Count / this.CAPACITY_Items),1);
         this.BTNLeftHeroOnClick();
         this.BTNLeftItemOnClick();
         this.FUITab.TabIndex = this.Cur_index_tab;
         this.TabOnSwitch(this.Cur_index_tab);
         this.UpdateOrangeSoul();
      }
      
      public function UpdateExchangeSuccess() : void
      {
         this.UpdateUIHeroExchange();
         this.UpdateUIItemExchange();
      }
   }
}

