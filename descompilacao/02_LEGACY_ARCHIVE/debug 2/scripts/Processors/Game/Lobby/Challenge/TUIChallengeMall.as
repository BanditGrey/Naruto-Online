package Processors.Game.Lobby.Challenge
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Challenge.TChallenge;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TInventory;
   import Logics.Inventories.TInventorySample;
   import Logics.Inventories.TInventorySamples;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Mall.Components.TUIMallItem;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Processors.Game.Windows.Information.TUIWindowChallengeBuyGoods;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_CHALLENGE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIChallengeMall extends TUIBaseWindow
   {
      
      protected static const TAB_COUNT:int = 4;
      
      protected static const ITEM_COUNT:int = 9;
      
      protected var FChallenge:TChallenge;
      
      protected var FTF_NinjaPoint:TextField;
      
      protected var FMallItemList:Vector.<TUIMallItem>;
      
      protected var FMC_Tab:TUITab;
      
      protected var FTabIndex:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FUIWindowBuyGoods:TUIWindowChallengeBuyGoods;
      
      protected var FCurrentInventorySamples:TInventorySamples;
      
      protected var FInventorySamples:TInventorySamples;
      
      protected var FInventorySample:TInventorySample;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FHelpTips:THint;
      
      public function TUIChallengeMall(param1:TUIComponent)
      {
         super(param1);
         this.FChallenge = SLogicsCore.Challenge;
         this.FMallItemList = new Vector.<TUIMallItem>(ITEM_COUNT);
         this.FMC_Tab = new TUITab(this);
         this.FUIPage = new TUIPage(this);
         this.FCurrentInventorySamples = new TInventorySamples();
         this.FInventorySamples = this.FChallenge.InventorySamples;
         this.FHelpTips = new THint();
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIMallItem = null;
         super.Resources_UIDispatch(param1);
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         FMC_Scene = param1;
         addChild(FMC_Scene);
         FMC_Scene.x = (FUICore.StageWidth - FMC_Scene.width) / 2;
         FMC_Scene.y = (FUICore.StageHeight - FMC_Scene.height) / 2;
         _loc2_ = 0;
         while(_loc2_ < TAB_COUNT)
         {
            this.FMC_Tab.SetTabByIndex(FMC_Scene["MC_Tab_" + _loc2_],_loc2_);
            _loc2_++;
         }
         this.FMC_Tab.OnSwitch = this.TabOnSwitch;
         this.FMC_Tab.Init();
         this.FTF_NinjaPoint = FMC_Scene["TF_NinjaPoint"];
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_ChangeListPage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_ChangeListPage.MC_PageRight;
         this.FUIPage.LabelPage = FMC_Scene.MC_ChangeListPage.TF_Page;
         this.FUIPage.PageSize = ITEM_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FPageIndex = 0;
         this.FUIPage.OnChangePage = this.PageOnChange;
         _loc3_ = int(this.FMallItemList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = FMC_Scene["MC_MallItem_" + _loc2_];
            _loc5_ = new TUIMallItem(this);
            _loc5_.Tag = _loc2_;
            _loc5_.Substrate = _loc4_;
            _loc5_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc5_.SlotOnOver = this.ProcessorOnItemOver;
            _loc5_.SlotOnOut = this.ProcessorOnItemOut;
            _loc5_.ItemOnClick = this.ProcessorItemOnClick;
            _loc5_.LookUpOnClick = this.ProcessorLookUpOnClick;
            _loc5_.Perform_UIDispatch();
            _loc5_.Init();
            this.FMallItemList[_loc2_] = _loc5_;
            _loc2_++;
         }
         this.FUIWindowBuyGoods = new TUIWindowChallengeBuyGoods(this,CONST_MODULES.MODULE_Challenge);
         this.FUIWindowBuyGoods.Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_ChallengeBuyGoods") as Sprite;
         this.FUIWindowBuyGoods.Scene.x = (CONST_COMMON.STAGE_Width - this.FUIWindowBuyGoods.Window_Width) / 2;
         this.FUIWindowBuyGoods.Scene.y = (CONST_COMMON.STAGE_Height - this.FUIWindowBuyGoods.Window_Height) / 2;
         this.FUIWindowBuyGoods.Init();
         this.FUIWindowBuyGoods.OnOK = this.WindowOnOk;
         this.FUIWindowBuyGoods.OnCancel = this.WindowOnCancel;
         this.FOverlayerHint = new TOverlayerHint(this.Parent);
         this.FOverlayerHint.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         FMC_Scene.BTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseMain);
         FMC_Scene.BTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         FMC_Scene.BTN_Help.addEventListener(MouseEvent.ROLL_OUT,this.ButtonHelpOnOut);
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
            if(this.FTabIndex == 0)
            {
               this.FCurrentInventorySamples.Add(_loc3_);
            }
            else if(_loc3_.Page == this.FTabIndex)
            {
               this.FCurrentInventorySamples.Add(_loc3_);
            }
            _loc1_++;
         }
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
            _loc5_.UpdataPvpMallInfo();
            _loc5_.Substrate.visible = true;
            _loc1_++;
         }
      }
      
      public function UpdateNinjaPoint() : void
      {
         this.FTF_NinjaPoint.text = this.FChallenge.Point.toString();
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FPageIndex = 0;
         this.FUIPage.TotalQuantity = this.FCurrentInventorySamples.Count;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function OnCloseMain(param1:MouseEvent) : void
      {
         if(FOnCloseWindow != null)
         {
            FOnCloseWindow(this);
         }
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
      
      protected function WindowOnOk(param1:Object) : void
      {
         var _loc2_:String = null;
         if(SLogicsCore.Challenge.Point <= 0)
         {
            _loc2_ = new ConsumeFrameCopy(STRING_CHALLENGE.STRING_004).DescribeString;
            FOnShowFlowText(_loc2_);
            return;
         }
         this.FUIWindowBuyGoods.Reset();
         if(FOnGetBox != null)
         {
            FOnGetBox(TProcessorChallenge.REQ_TYPE_EXCHANGE_ITEM,this.FInventorySample.Indentifier,this.FUIWindowBuyGoods.Value);
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
         var _loc4_:TArticle = null;
         _loc3_ = param2 as TInventorySample;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc3_.TemplateID) as TArticle;
         if(OnShowRecruit != null)
         {
            OnShowRecruit(_loc4_.FunctionValue);
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Challenge);
         }
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(OnHelpOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_70170104) as TSystemLanguage;
            this.FHelpTips.Content = _loc2_.Desc;
            OnHelpOver(this,this.FHelpTips);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(OnHelpOut != null)
         {
            OnHelpOut(this);
         }
      }
      
      protected function ProcessorOnItemOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(param1,param2);
         }
      }
      
      protected function ProcessorOnItemOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(param1,param2);
         }
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIMallItem = null;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            _loc2_ = this.FMallItemList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.FMallItemList[_loc1_];
               _loc3_.UpdateSlot();
               _loc1_++;
            }
            if(this.FUIWindowBuyGoods != null)
            {
               this.FUIWindowBuyGoods.UpdateSlot();
            }
         }
      }
      
      public function UpdateWindow() : void
      {
         this.FMC_Tab.SwithTagManual(0);
         this.FilterTabMallItem();
         this.UpdatePageInfo();
         this.UpdateMallItemsInfo();
         this.UpdateNinjaPoint();
      }
      
      public function Reset() : void
      {
         this.FTF_NinjaPoint.text = "";
      }
   }
}

