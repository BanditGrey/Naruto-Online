package Processors.Game.Lobby.MasterRoad
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TMasterRoadMall;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.TBaseActivity;
   import Logics.MasterRoad.TMasterRoad;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TUIMasterRoadShop extends TUIBaseWindow
   {
      
      public static const TAB_COUNT:int = 5;
      
      public static const EXCHANGE_COUNT:int = 9;
      
      protected var FMasterRoad:TMasterRoad;
      
      protected var FUITab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FShowItems:Vector.<TUIShowItem>;
      
      protected var FItemList:Vector.<TMasterRoadMall>;
      
      protected var FBuyItem:TUIShowItem;
      
      protected var FCurCount:int;
      
      protected var FItem:TMasterRoadMall;
      
      protected var FHelpTips:THint;
      
      public function TUIMasterRoadShop(param1:TUIComponent)
      {
         super(param1);
         this.FMasterRoad = SLogicsCore.MasterRoad;
         this.FUITab = new TUITab(this);
         this.FUIPage = new TUIPage(this);
         this.FShowItems = new Vector.<TUIShowItem>();
         this.FItemList = new Vector.<TMasterRoadMall>();
         this.FHelpTips = new THint();
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIShowItem = null;
         super.Resources_UIDispatch(param1);
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         FMC_Scene = param1;
         addChild(FMC_Scene);
         FMC_Scene.x = (FUICore.StageWidth - FMC_Scene.width) / 2;
         FMC_Scene.y = (FUICore.StageHeight - FMC_Scene.height) / 2;
         FMC_Scene.MC_Item.visible = false;
         _loc2_ = 0;
         while(_loc2_ < TAB_COUNT)
         {
            this.FUITab.SetTabByIndex(FMC_Scene["MC_Tab" + _loc2_],_loc2_);
            _loc2_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FBuyItem = new TUIShowItem(this,1);
         this.FBuyItem.Perform_UIDispatch(FMC_Scene.MC_Item);
         _loc2_ = 0;
         while(_loc2_ < EXCHANGE_COUNT)
         {
            _loc5_ = new TUIShowItem(this,1);
            _loc5_.Perform_UIDispatch(FMC_Scene["MC_Box" + _loc2_]);
            _loc5_.OnOverlay = this.SlotsOnOver;
            _loc5_.OnOut = this.SlotsOnOut;
            this.FShowItems[_loc2_] = _loc5_;
            FMC_Scene["MC_Box" + _loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyUp);
            FMC_Scene["MC_Box" + _loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            FMC_Scene["MC_Box" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            _loc2_++;
         }
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_Page.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_Page.MC_PageRight;
         this.FUIPage.LabelPage = FMC_Scene.MC_Page.TF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = EXCHANGE_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         TGameUtil.setButtonMode(FMC_Scene.MC_Item.BTN_Confirm,true);
         FMC_Scene.MC_Item.BTN_Confirm.addEventListener(MouseEvent.CLICK,this.ProcessorOnConfirmUp);
         FMC_Scene.MC_Item.BTN_Cancel.addEventListener(MouseEvent.CLICK,this.ClichHandle);
         FMC_Scene.MC_Item.MC_Price.BTN_Reduce.addEventListener(MouseEvent.CLICK,this.ClichHandle);
         FMC_Scene.MC_Item.MC_Price.BTN_Add.addEventListener(MouseEvent.CLICK,this.ClichHandle);
         FMC_Scene.MC_Item.MC_Price.TF_Count.addEventListener(Event.CHANGE,this.OnTextInput);
         FMC_Scene.BTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseMain);
         FMC_Scene.BTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         FMC_Scene.BTN_Help.addEventListener(MouseEvent.ROLL_OUT,this.ButtonHelpOnOut);
      }
      
      protected function UpdateExchange() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TMasterRoadMall = null;
         var _loc6_:MovieClip = null;
         this.FItemList.length = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FMasterRoad.MallData.length)
         {
            _loc5_ = this.FMasterRoad.MallData[_loc1_];
            if(this.FChangeTabIndex == 0 || _loc5_.type == this.FChangeTabIndex)
            {
               this.FItemList.push(_loc5_);
            }
            _loc1_++;
         }
         this.FUIPage.TotalQuantity = this.FItemList.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_COUNT)
         {
            _loc6_ = FMC_Scene["MC_Box" + _loc1_];
            _loc3_ = _loc1_ + this.FCurPage * EXCHANGE_COUNT;
            if(_loc3_ < this.FItemList.length)
            {
               _loc6_.visible = true;
               _loc5_ = this.FItemList[_loc3_];
               this.FShowItems[_loc1_].UpdateUI(_loc5_.Inventories);
               _loc6_.MC_Slot0.TF_Name.text = _loc5_.Inventories.GetInventoryByIndex(0).Name;
               _loc6_.MC_Slot0.TF_Desc.text = _loc5_.Desc;
               if(this.FChangeTabIndex == 4 || _loc5_.type == 4)
               {
                  _loc6_.MC_Type.gotoAndStop(2);
               }
               else
               {
                  _loc6_.MC_Type.gotoAndStop(1);
               }
            }
            else
            {
               _loc6_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBuyItem() : void
      {
         if(Boolean(this.FBuyItem) && Boolean(this.FItem))
         {
            this.FBuyItem.UpdateUI(this.FItem.Inventories);
            FMC_Scene.MC_Item.MC_Slot0.TF_Name.text = this.FItem.Inventories.GetInventoryByIndex(0).Name;
            if(this.FChangeTabIndex != 4 || this.FItem.type == 4)
            {
               FMC_Scene.MC_Item.MC_Type.gotoAndStop(1);
            }
            else
            {
               FMC_Scene.MC_Item.MC_Type.gotoAndStop(2);
            }
            this.OnTextInput(null);
         }
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FChangeTabIndex = param1 as int;
         this.FCurPage = 0;
         this.FUIPage.Reset();
         FMC_Scene.MC_Item.visible = false;
         this.FCurCount = 1;
         this.UpdateExchange();
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateExchange();
      }
      
      protected function ProcessorOnBuyUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         _loc3_ = _loc2_ + this.FCurPage * EXCHANGE_COUNT;
         FMC_Scene["MC_Box" + _loc2_].filters = [];
         this.FItem = this.FItemList[_loc3_];
         FMC_Scene.MC_Item.visible = true;
         this.UpdateBuyItem();
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         FMC_Scene["MC_Box" + _loc2_].filters = [TGameUtil.highLightFilters];
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         FMC_Scene["MC_Box" + _loc2_].filters = [];
      }
      
      protected function ProcessorOnConfirmUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null)
         {
            FMC_Scene.MC_Item.visible = false;
            FOnGetBox(TProcessorMasterRoad.REQ_TYPE_EXCHANGE_ITEM,this.FItem.Identifier,this.FCurCount);
         }
      }
      
      protected function ClichHandle(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case FMC_Scene.MC_Item.BTN_Cancel:
               FMC_Scene.MC_Item.visible = false;
               break;
            case FMC_Scene.MC_Item.MC_Price.BTN_Reduce:
               --this.FCurCount;
               FMC_Scene.MC_Item.MC_Price.TF_Count.text = this.FCurCount.toString();
               this.OnTextInput(null);
               break;
            case FMC_Scene.MC_Item.MC_Price.BTN_Add:
               ++this.FCurCount;
               FMC_Scene.MC_Item.MC_Price.TF_Count.text = this.FCurCount.toString();
               this.OnTextInput(null);
         }
      }
      
      protected function OnTextInput(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.FChangeTabIndex == 4)
         {
            this.FCurCount = int(FMC_Scene.MC_Item.MC_Price.TF_Count.text) > 0 ? int(FMC_Scene.MC_Item.MC_Price.TF_Count.text) : 1;
            _loc2_ = int(SLogicsCore.Character.MainHero.Experience.ToNumber() / this.FItem.consume);
         }
         else
         {
            this.FCurCount = int(FMC_Scene.MC_Item.MC_Price.TF_Count.text) > 0 ? int(FMC_Scene.MC_Item.MC_Price.TF_Count.text) : 1;
            _loc2_ = int(this.FMasterRoad.MyScore / this.FItem.consume);
         }
         _loc3_ = this.FItem.Inventories.GetInventoryByIndex(0).LimitCount;
         if(_loc3_ == -1)
         {
            _loc3_ = 999999;
         }
         if(this.FCurCount > _loc2_)
         {
            this.FCurCount = _loc2_;
         }
         if(_loc3_ >= 0 && this.FCurCount > _loc3_)
         {
            this.FCurCount = _loc3_;
         }
         if(this.FCurCount < 0)
         {
            this.FCurCount = 0;
         }
         FMC_Scene.MC_Item.MC_Price.TF_Count.text = this.FCurCount.toString();
         FMC_Scene.MC_Item.MC_Price.TF_AllPrice.text = (this.FCurCount * this.FItem.consume).toString();
         if(this.FCurCount > 0 && this.FItem.Status == TBaseActivity.STATUS_CANGET)
         {
            TGameUtil.setButtonMode(FMC_Scene.MC_Item.BTN_Confirm,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.MC_Item.BTN_Confirm,false);
         }
      }
      
      protected function OnCloseMain(param1:MouseEvent) : void
      {
         if(FOnCloseWindow != null)
         {
            FOnCloseWindow(this);
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(param1,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(param1,param2);
         }
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(OnHelpOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_70170097) as TSystemLanguage;
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
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < EXCHANGE_COUNT)
            {
               if(this.FShowItems[_loc1_])
               {
                  this.FShowItems[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
            if(this.FBuyItem)
            {
               this.FBuyItem.LogicsPerform();
            }
         }
      }
      
      public function UpdateWindow() : void
      {
         this.UpdateExchange();
         if(FMC_Scene.MC_Item.visible)
         {
            this.OnTextInput(null);
         }
      }
      
      override public function Unmount() : void
      {
      }
   }
}

