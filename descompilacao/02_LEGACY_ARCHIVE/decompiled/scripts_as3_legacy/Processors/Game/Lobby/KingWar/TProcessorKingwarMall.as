package Processors.Game.Lobby.KingWar
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TInventory;
   import Logics.Inventories.TInventorySample;
   import Logics.Inventories.TInventorySamples;
   import Logics.SLogicsCore;
   import Logics.Streamization.Kingwar.TUnstreamizerKingwarMall;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.Mall.Components.TUIMallItem;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Processors.Game.Windows.Information.TUIWindowKingwarBuyGoods;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_KINGWAR;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorKingwarMall extends TProcessorWindowTemplate
   {
      
      protected var FTF_NinjaPoint:TextField;
      
      protected var FMallItemList:Vector.<TUIMallItem>;
      
      protected var FMC_Tab:TUITab;
      
      protected var FTabIndex:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FUIWindowBuyGoods:TUIWindowKingwarBuyGoods;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FCurrentInventorySamples:TInventorySamples;
      
      protected var FInventorySamples:TInventorySamples;
      
      protected var FInventorySample:TInventorySample;
      
      protected var FUnstreamizerKingwarMall:TUnstreamizerKingwarMall;
      
      protected var FPointId:int;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FSlotOnOver:Function;
      
      protected var FSlotOnOut:Function;
      
      protected var FOnMallBuy:Function;
      
      protected var FHelpHintOnOver:Function;
      
      protected var FHelpHintOnOut:Function;
      
      public function TProcessorKingwarMall(param1:TUIComponent)
      {
         super(param1);
         this.Init();
      }
      
      protected function Init() : void
      {
         this.FMallItemList = new Vector.<TUIMallItem>(CONST_KINGWAR.Capacity_MallItems);
         this.FMC_Tab = new TUITab(this);
         this.FUIPage = new TUIPage(this);
         this.FCurrentInventorySamples = new TInventorySamples();
         this.FInventorySamples = new TInventorySamples();
         this.FUnstreamizerKingwarMall = new TUnstreamizerKingwarMall();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TUIMallItem = null;
         var _loc5_:Sprite = null;
         var _loc6_:TextField = null;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         TGameUtil.AddWindowMask(this);
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance("KingwarMall") as Sprite;
         UIDispatch();
         _loc2_ = CONST_KINGWAR.CAPACITY_Mall_Tabs;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc7_ = FMainUI["MC_Tab_" + _loc1_];
            this.FMC_Tab.SetTabByIndex(_loc7_,_loc1_);
            _loc1_++;
         }
         this.FMC_Tab.OnSwitch = this.TabOnSwitch;
         this.FMC_Tab.Init();
         this.FTF_NinjaPoint = FMainUI["TF_NinjaPoint"];
         _loc5_ = FMainUI["MC_ChangeListPage"];
         _loc8_ = _loc5_["MC_PageLeft"];
         this.FUIPage.ButtonPrevious.Substrate = _loc8_;
         _loc8_ = _loc5_["MC_PageRight"];
         this.FUIPage.ButtonNext.Substrate = _loc8_;
         _loc6_ = _loc5_["TF_Page"];
         this.FUIPage.LabelPage = _loc6_;
         _loc6_.text = "0/0";
         this.FUIPage.PageSize = CONST_KINGWAR.Capacity_MallItems;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.PageOnChange;
         _loc2_ = this.FMallItemList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = FMainUI["MC_MallItem_" + _loc1_];
            _loc4_ = new TUIMallItem(this);
            _loc4_.Tag = _loc1_;
            _loc4_.Substrate = _loc3_;
            _loc4_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc4_.SlotOnOut = this.UIComponentsHintOnOut;
            _loc4_.SlotOnOver = this.UIComponentsHintOnOver;
            _loc4_.ItemOnClick = this.ProcessorItemOnClick;
            _loc4_.LookUpOnClick = this.ProcessorLookUpOnClick;
            _loc4_.Perform_UIDispatch();
            _loc4_.Init();
            this.FMallItemList[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FUIWindowBuyGoods = new TUIWindowKingwarBuyGoods(this,CONST_MODULES.MODULE_Kingwar);
         this.FUIWindowBuyGoods.Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_buyGoodsFrame") as Sprite;
         this.FUIWindowBuyGoods.Scene.x = (STAGE_Width - this.FUIWindowBuyGoods.Window_Width) / 2;
         this.FUIWindowBuyGoods.Scene.y = (STAGE_Height - this.FUIWindowBuyGoods.Window_Height) / 2;
         this.FUIWindowBuyGoods.Init();
         this.FUIWindowBuyGoods.OnOK = this.WindowOnOk;
         this.FUIWindowBuyGoods.OnCancel = this.WindowOnCancel;
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this);
         this.FProcessorWindowRecruit.Load();
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.HintOnOver = this.ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = this.ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FOverlayerHint = new TOverlayerHint(this.Parent);
         this.FOverlayerHint.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TSystemLanguage = null;
         var _loc2_:TConfigValue = null;
         UILocations();
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_MALL) as TSystemLanguage;
         FHelpTips.Content = _loc1_.Desc;
         super.ResourcesPerform_UILocations();
         this.FUnstreamizerKingwarMall.UnstreamizeInventorySamplesByDatabase(null,this.FInventorySamples,null);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.KingBattleMall) as TConfigValue;
         this.FPointId = _loc2_.Value[0];
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIMallItem = null;
         if(!Visible)
         {
            return;
         }
         _loc2_ = this.FMallItemList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMallItemList[_loc1_];
            _loc3_.UpdateSlot();
            _loc1_++;
         }
         if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible)
         {
            this.FProcessorWindowRecruit.UpdataBitmap();
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
            _loc5_.SetKingBattleMallInfo();
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
            if(_loc3_.Page == this.FTabIndex + 1)
            {
               this.FCurrentInventorySamples.Add(_loc3_);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateNinjaPoint() : void
      {
         this.FTF_NinjaPoint.text = SLogicsCore.Character.Appliances.GetAllCountByTempletID(this.FPointId).toString();
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FPageIndex = 0;
         this.FUIPage.TotalQuantity = this.FCurrentInventorySamples.Count;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function ProcessorTipOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      protected function ProcessorTipOnOut(param1:Object) : void
      {
         this.FOverlayerHint.Hide();
      }
      
      override protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         this.Visible = false;
      }
      
      protected function WindowOnOk(param1:Object) : void
      {
         this.FUIWindowBuyGoods.Reset();
         if(this.FOnMallBuy != null)
         {
            this.FOnMallBuy(this,this.FUIWindowBuyGoods.Value,this.FInventorySample.TemplateID);
         }
      }
      
      protected function WindowOnCancel(param1:Object) : void
      {
         this.FUIWindowBuyGoods.Reset();
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FTabIndex = param1 as uint;
         this.FPageIndex = 0;
         this.FilterTabMallItem();
         this.UpdateMallItemsInfo();
         this.UpdatePageInfo();
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndex = param2;
         this.UpdateMallItemsInfo();
      }
      
      protected function ProcessorItemOnClick(param1:Object, param2:Object) : void
      {
         this.FUIWindowBuyGoods.Visible = true;
         this.FInventorySample = param2 as TInventorySample;
         this.FUIWindowBuyGoods.Context = param2;
         this.FUIWindowBuyGoods.Update();
      }
      
      protected function ProcessorLookUpOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventorySample = null;
         _loc3_ = param2 as TInventorySample;
         this.FProcessorWindowRecruit.Visible = true;
         this.FProcessorWindowRecruit.SetHeroData(_loc3_.Model);
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Kingwar);
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
      
      protected function OnHintHelpMove(param1:MouseEvent) : void
      {
         if(this.FHelpHintOnOver != null)
         {
            this.FHelpHintOnOver(this,FHelpTips);
         }
      }
      
      protected function OnHintHelpOut(param1:MouseEvent) : void
      {
         if(this.FHelpHintOnOut != null)
         {
            this.FHelpHintOnOut(this);
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
      
      public function set OnMallBuy(param1:Function) : void
      {
         this.FOnMallBuy = param1;
      }
      
      public function Update() : void
      {
         this.FMC_Tab.SwithTagManual(0);
         this.FilterTabMallItem();
         this.UpdatePageInfo();
         this.UpdateMallItemsInfo();
         this.UpdateNinjaPoint();
      }
      
      public function UpdateNinjaPointUI() : void
      {
         this.UpdateNinjaPoint();
      }
      
      public function Reset() : void
      {
         this.FTF_NinjaPoint.text = "";
      }
   }
}

