package Processors.Game.Lobby.Exercise.BlackMarket.Compoents
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.BlackMarket.TBlackMarket;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BlackMarket.TProcessorBlackMarket;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_SEVENTHEVENING;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TUIBlackMarketShop extends TUIBaseWindow
   {
      
      protected static const HOT_ITEM:int = 5;
      
      protected static const SALE_ITEM:int = 9;
      
      protected static const LOG_COUNT:int = 6;
      
      protected static const COLOR_ContextOddsAward:uint = 4294967295;
      
      protected static const COLOR_ContextRobbed:uint = 4284900966;
      
      protected static const QUALITYCOLOR_None:uint = 4294967295;
      
      protected static const QUALITYCOLOR_White:uint = 4294967295;
      
      protected static const QUALITYCOLOR_Green:uint = 4285071106;
      
      protected static const QUALITYCOLOR_Blue:uint = 4278228735;
      
      protected static const QUALITYCOLOR_Purple:uint = 4288217295;
      
      protected static const QUALITYCOLOR_Yellow:uint = 4294967040;
      
      protected static const QUALITYCOLOR_Red:uint = 4294836224;
      
      protected static const QUALITYCOLOR_Orange:uint = 4294901888;
      
      public static const QUALITYCOLOR_INDEX:Vector.<uint> = Vector.<uint>([QUALITYCOLOR_None,QUALITYCOLOR_White,QUALITYCOLOR_Green,QUALITYCOLOR_Blue,QUALITYCOLOR_Purple,QUALITYCOLOR_Yellow,QUALITYCOLOR_Red,QUALITYCOLOR_Orange]);
      
      protected var FBlackMarket:TBlackMarket;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FHotItems:Vector.<TUIBaseBox>;
      
      protected var FSaleItems:Vector.<TUIBaseBox>;
      
      protected var FTF_Time:TextField;
      
      protected var FTextFormat:TextFormat;
      
      public function TUIBlackMarketShop(param1:TUIComponent)
      {
         super(param1);
         this.FBlackMarket = SLogicsCore.BlackMarket;
         this.FUIPage = new TUIPage(this);
         this.FHotItems = new Vector.<TUIBaseBox>(HOT_ITEM);
         this.FSaleItems = new Vector.<TUIBaseBox>(SALE_ITEM);
         this.FTextFormat = new TextFormat();
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIBaseBox = null;
         super.Resources_UIDispatch(param1);
         this.FTF_Time = FMC_Scene.TF_Time;
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene["Btn_Left"];
         this.FUIPage.ButtonNext.Substrate = FMC_Scene["Btn_Right"];
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = HOT_ITEM;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         _loc2_ = 0;
         while(_loc2_ < HOT_ITEM)
         {
            _loc4_ = new TUIBaseBox(this,1);
            _loc4_.Perform_UIDispatch(FMC_Scene["MC_Hot" + _loc2_]);
            _loc4_.OnOverlay = this.ProcessorOnItemOver;
            _loc4_.OnOut = this.ProcessorOnItemOut;
            this.FHotItems[_loc2_] = _loc4_;
            TGameUtil.setButtonMode(FMC_Scene["MC_Hot" + _loc2_].BTN_Desc,true);
            FMC_Scene["MC_Hot" + _loc2_].BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowRecruit);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < SALE_ITEM)
         {
            _loc4_ = new TUIBaseBox(this,1);
            _loc4_.Perform_UIDispatch(FMC_Scene["MC_Item" + _loc2_]["MC_Item"]);
            _loc4_.OnOverlay = this.ProcessorOnItemOver;
            _loc4_.OnOut = this.ProcessorOnItemOut;
            this.FSaleItems[_loc2_] = _loc4_;
            _loc4_.MC_Scene.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyBox);
            _loc4_.MC_Scene.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            _loc4_.MC_Scene.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_GoldFresh,true);
         FMC_Scene.BTN_GoldFresh.addEventListener(MouseEvent.CLICK,this.ProcessorOnGoldFresh);
         FMC_Scene.BTN_GoldFresh.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBtnOver);
         FMC_Scene.BTN_GoldFresh.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBtnOut);
         TGameUtil.setButtonMode(FMC_Scene.BTN_FreeFresh,true);
         FMC_Scene.BTN_FreeFresh.addEventListener(MouseEvent.CLICK,this.ProcessorOnFreeFresh);
      }
      
      protected function UpdateHotItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         var _loc4_:TUIBaseBox = null;
         this.FUIPage.TotalQuantity = this.FBlackMarket.HotItem.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < HOT_ITEM)
         {
            _loc2_ = _loc1_ + this.FCurPage * HOT_ITEM;
            _loc4_ = this.FHotItems[_loc1_];
            if(_loc2_ < this.FBlackMarket.HotItem.length)
            {
               _loc4_.SetVisible(true);
               _loc3_ = this.FBlackMarket.HotItem[_loc2_];
               _loc4_.UpdateUI(_loc3_.Inventories);
               if(_loc3_.Type != TBaseBox.TYPE_IS_ITEM)
               {
                  _loc4_.MC_Scene.BTN_Desc.visible = true;
               }
               else
               {
                  _loc4_.MC_Scene.BTN_Desc.visible = false;
               }
               _loc4_.SetPriceText(_loc3_.Max.toString());
               _loc4_.SetCurPriceText(_loc3_.Min.toString());
               if(_loc3_.Level > 0)
               {
                  switch(_loc3_.Level)
                  {
                     case 1:
                        FMC_Scene["MC_Hot" + _loc1_].MC_RedFire.visible = true;
                        FMC_Scene["MC_Hot" + _loc1_].MC_GoldFire.visible = false;
                        break;
                     case 2:
                        FMC_Scene["MC_Hot" + _loc1_].MC_RedFire.visible = false;
                        FMC_Scene["MC_Hot" + _loc1_].MC_GoldFire.visible = true;
                  }
               }
               else
               {
                  FMC_Scene["MC_Hot" + _loc1_].MC_RedFire.visible = false;
                  FMC_Scene["MC_Hot" + _loc1_].MC_GoldFire.visible = false;
               }
            }
            else
            {
               _loc4_.SetVisible(false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateSaleItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         var _loc4_:TUIBaseBox = null;
         var _loc5_:TInventory = null;
         _loc1_ = 0;
         while(_loc1_ < SALE_ITEM)
         {
            _loc4_ = this.FSaleItems[_loc1_];
            if(_loc1_ < this.FBlackMarket.SaleItem.length)
            {
               _loc4_.SetVisible(true);
               _loc3_ = this.FBlackMarket.SaleItem[_loc1_];
               _loc4_.UpdateUI(_loc3_.Inventories);
               _loc4_.SetPriceText(_loc3_.Price.toString());
               _loc4_.SetCurPriceText(_loc3_.CurPrice.toString());
               _loc5_ = _loc3_.Inventories.GetInventoryByIndex(0);
               _loc4_.SetNameText(_loc5_.Name);
               this.FTextFormat.color = QUALITYCOLOR_INDEX[_loc5_.Quality];
               _loc4_.MC_Scene.TF_Name.setTextFormat(this.FTextFormat);
               _loc4_.MC_Scene.MC_Tip.visible = false;
               if(_loc3_.Level > 0)
               {
                  switch(_loc3_.Level)
                  {
                     case 1:
                        FMC_Scene["MC_Item" + _loc1_].MC_Item.MC_RedFire.visible = true;
                        FMC_Scene["MC_Item" + _loc1_].MC_Item.MC_GoldFire.visible = false;
                        break;
                     case 2:
                        FMC_Scene["MC_Item" + _loc1_].MC_Item.MC_RedFire.visible = false;
                        FMC_Scene["MC_Item" + _loc1_].MC_Item.MC_GoldFire.visible = true;
                  }
               }
               else
               {
                  FMC_Scene["MC_Item" + _loc1_].MC_Item.MC_RedFire.visible = false;
                  FMC_Scene["MC_Item" + _loc1_].MC_Item.MC_GoldFire.visible = false;
               }
               if(_loc3_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc4_.SetGaryFilters(true);
               }
               else
               {
                  _loc4_.SetGaryFilters(false);
               }
            }
            else
            {
               _loc4_.SetVisible(false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateLog() : void
      {
         var _loc1_:String = null;
         var _loc2_:TInventory = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < LOG_COUNT)
         {
            if(_loc4_ < this.FBlackMarket.AllLogs.length)
            {
               FMC_Scene["TF_Log" + _loc4_].visible = true;
               _loc3_ = this.FBlackMarket.AllLogs[_loc4_];
               _loc2_ = _loc3_.Inventories.GetInventoryByIndex(0);
               _loc1_ = this.FBlackMarket.ActivityName;
               _loc1_ = _loc1_.split("%who%").join(_loc3_.Desc1);
               _loc1_ += STRING_SEVENTHEVENING.FORMAT_News_Item[_loc2_.Quality];
               _loc1_ = _loc1_.split("%what%").join(_loc2_.Name + "*" + _loc2_.Quantity);
               FMC_Scene["TF_Log" + _loc4_].htmlText = _loc1_;
            }
            else
            {
               FMC_Scene["TF_Log" + _loc4_].visible = false;
            }
            _loc4_++;
         }
      }
      
      protected function UpdateBtn() : void
      {
         if(this.FBlackMarket.FreshTime > STimingCore.GetServerTick())
         {
            FMC_Scene.BTN_GoldFresh.visible = true;
            FMC_Scene.BTN_FreeFresh.visible = false;
         }
         else
         {
            FMC_Scene.BTN_GoldFresh.visible = false;
            FMC_Scene.BTN_FreeFresh.visible = true;
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateUI();
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
      
      protected function ProcessorOnBuyBox(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnBuyBox != null && _loc2_ < this.FBlackMarket.SaleItem.length && this.FBlackMarket.SaleItem[_loc2_].Status != TBaseActivity.STATUS_GETED)
         {
            FOnBuyBox(TProcessorBlackMarket.TYPE_BUY_ITEM,this.FBlackMarket.SaleItem[_loc2_].CurPrice,_loc2_ + 1,TBaseActivity.SWEET_TYPE_GOLD);
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(_loc2_ < this.FBlackMarket.SaleItem.length && this.FBlackMarket.SaleItem[_loc2_].Status != TBaseActivity.STATUS_GETED)
         {
            this.FSaleItems[_loc2_].SetHighLightFilters(true);
            this.FSaleItems[_loc2_].MC_Scene.MC_Tip.visible = true;
         }
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(_loc2_ < this.FBlackMarket.SaleItem.length && this.FBlackMarket.SaleItem[_loc2_].Status != TBaseActivity.STATUS_GETED)
         {
            this.FSaleItems[_loc2_].SetHighLightFilters(false);
            this.FSaleItems[_loc2_].MC_Scene.MC_Tip.visible = false;
         }
      }
      
      protected function ProcessorOnGoldFresh(param1:MouseEvent) : void
      {
         if(FOnBuyBox != null)
         {
            if(this.FBlackMarket.SpecialItem == 0)
            {
               FOnBuyBox(TProcessorBlackMarket.TYPE_BUY_FRESH,this.FBlackMarket.FreshCost,0,TBaseActivity.SWEET_TYPE_GOLD);
            }
            else
            {
               FOnBuyBox(TProcessorBlackMarket.TYPE_BUY_FRESH,this.FBlackMarket.FreshCost,0,TBaseActivity.SWEET_TYPE_GOLD,this.FBlackMarket.ActivityDesc2,1);
            }
         }
      }
      
      protected function ProcessorOnBtnOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(FOnShowTip != null)
         {
            _loc2_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_COST_GOLD,this.FBlackMarket.FreshCost);
            FOnShowTip(_loc2_);
         }
      }
      
      protected function ProcessorOnBtnOut(param1:MouseEvent) : void
      {
         if(FOnHideTip != null)
         {
            FOnHideTip();
         }
      }
      
      protected function ProcessorOnFreeFresh(param1:MouseEvent) : void
      {
         if(this.FBlackMarket.FreshTime > STimingCore.GetServerTick())
         {
            return;
         }
         if(FOnBuyBox != null)
         {
            if(this.FBlackMarket.SpecialItem == 0)
            {
               FOnBuyBox(TProcessorBlackMarket.TYPE_FREE_FRESH,0,0,TBaseActivity.SWEET_TYPE_FREE);
            }
            else
            {
               FOnBuyBox(TProcessorBlackMarket.TYPE_FREE_FRESH,0,0,TBaseActivity.SWEET_TYPE_FREE,this.FBlackMarket.ActivityDesc2,1);
            }
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         _loc3_ = _loc2_ + this.FCurPage * HOT_ITEM;
         if(FOnShowRecruit != null && _loc3_ < this.FBlackMarket.HotItem.length)
         {
            FOnShowRecruit(this.FBlackMarket.HotItem[_loc3_].Identify,this.FBlackMarket.HotItem[_loc3_].Type);
         }
      }
      
      protected function ProcessorOnShowLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog();
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible)
         {
            if(this.FTF_Time)
            {
               this.FTF_Time.text = TGameUtil.fomatTime(this.FBlackMarket.FreshTime - STimingCore.GetServerTick());
               if(this.FBlackMarket.FreshTime <= STimingCore.GetServerTick())
               {
                  this.UpdateBtn();
               }
            }
            _loc1_ = 0;
            while(_loc1_ < HOT_ITEM)
            {
               if(this.FHotItems[_loc1_])
               {
                  this.FHotItems[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < SALE_ITEM)
            {
               if(this.FSaleItems[_loc1_])
               {
                  this.FSaleItems[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateHotItem();
         this.UpdateSaleItem();
         this.UpdateLog();
         this.UpdateBtn();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         _loc3_ = 0;
         while(_loc3_ < SALE_ITEM)
         {
            FMC_Scene["MC_Item" + _loc3_].gotoAndPlay(1);
            _loc3_++;
         }
      }
   }
}

