package Processors.Game.Lobby.Exercise.PersiaTrader
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.PersiaTrader.TPersiaTrader;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIPersiaTrader1 extends TUIBaseWindow
   {
      
      protected static const ITEM_TYPE:int = 5;
      
      protected static const LOG_COUNT:int = 4;
      
      protected var FPersiaTrader:TPersiaTrader;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FOpenIndex:int;
      
      protected var FIsCD:Boolean;
      
      protected var FSaleList:Vector.<TUIShowItem>;
      
      protected var FTF_Time:TextField;
      
      public function TUIPersiaTrader1(param1:TUIComponent)
      {
         super(param1);
         this.FPersiaTrader = SLogicsCore.PersiaTrader;
         this.FSaleList = new Vector.<TUIShowItem>(ITEM_TYPE);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         this.FTF_Time = FMC_Scene.TF_Time;
         _loc2_ = 0;
         while(_loc2_ < ITEM_TYPE)
         {
            _loc5_ = FMC_Scene["MC_Item" + _loc2_];
            _loc5_.MC_Name.gotoAndStop(_loc2_ + 1);
            _loc4_ = new TUIShowItem(this,1);
            _loc4_.Perform_UIDispatch(_loc5_);
            _loc4_.OnOverlay = this.SlotsOnOver;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FSaleList[_loc2_] = _loc4_;
            TGameUtil.setButtonMode(_loc5_.BTN_Buy,true);
            TGameUtil.setButtonMode(_loc5_.BTN_FreshPrice,true);
            TGameUtil.setButtonMode(_loc5_.BTN_FreshItem,true);
            _loc5_.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyItemUp);
            _loc5_.BTN_FreshPrice.addEventListener(MouseEvent.CLICK,this.ProcessorOnFreshPriceUp);
            _loc5_.BTN_FreshPrice.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFreshPriceOver);
            _loc5_.BTN_FreshPrice.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc5_.BTN_FreshItem.addEventListener(MouseEvent.CLICK,this.ProcessorOnFreshItemUp);
            _loc5_.BTN_FreshItem.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFreshItemOver);
            _loc5_.BTN_FreshItem.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_FreeFresh,true);
         TGameUtil.setButtonMode(FMC_Scene.BTN_GoldFresh,true);
         FMC_Scene.BTN_FreeFresh.addEventListener(MouseEvent.CLICK,this.ProcessorOnFreeFreshAllUp);
         FMC_Scene.BTN_GoldFresh.addEventListener(MouseEvent.CLICK,this.ProcessorOnGoldFreshAllUp);
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FPersiaTrader.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FPersiaTrader.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FPersiaTrader.DescListNew[1];
      }
      
      protected function UpdateItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TBaseBox = null;
         var _loc6_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < ITEM_TYPE)
         {
            _loc6_ = FMC_Scene["MC_Item" + _loc1_];
            _loc5_ = this.FPersiaTrader.SaleItems[_loc1_];
            if(Boolean(_loc5_.Inventories) && Boolean(_loc5_.Inventories.Count > 0) && _loc5_.Inventories.GetInventoryByIndex(0).Quantity > 0)
            {
               _loc6_.MC_End.visible = false;
               this.FSaleList[_loc1_].UpdateUI(_loc5_.Inventories);
               _loc6_.TF_Name.text = _loc5_.Inventories.GetInventoryByIndex(0).Name;
               _loc6_.TF_MinPrice.text = _loc5_.Min.toString();
               _loc6_.TF_Price.text = _loc5_.Price.toString();
               _loc6_.TF_CurPrice.text = _loc5_.CurPrice.toString();
               if(_loc5_.Status == TBaseActivity.STATUS_IS_GOT)
               {
                  _loc6_.MC_Got.visible = true;
                  _loc6_.MC_Bought.visible = false;
                  _loc6_.BTN_Buy.visible = false;
                  _loc6_.BTN_FreshPrice.visible = false;
               }
               else if(_loc5_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc6_.MC_Got.visible = false;
                  _loc6_.MC_Bought.visible = true;
                  _loc6_.BTN_Buy.visible = true;
                  _loc6_.BTN_FreshPrice.visible = true;
                  TGameUtil.setButtonMode(_loc6_.BTN_Buy,false);
                  TGameUtil.setButtonMode(_loc6_.BTN_FreshPrice,false);
               }
               else
               {
                  _loc6_.MC_Got.visible = false;
                  _loc6_.MC_Bought.visible = false;
                  _loc6_.BTN_Buy.visible = true;
                  _loc6_.BTN_FreshPrice.visible = true;
                  TGameUtil.setButtonMode(_loc6_.BTN_Buy,true);
                  TGameUtil.setButtonMode(_loc6_.BTN_FreshPrice,true);
               }
            }
            else
            {
               _loc6_.MC_End.visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateLog() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TextField = null;
         var _loc3_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < LOG_COUNT)
         {
            _loc2_ = FMC_Scene["TF_Log" + _loc1_];
            if(_loc1_ < this.FPersiaTrader.SaleLogs.length)
            {
               _loc3_ = this.FPersiaTrader.SaleLogs[_loc1_];
               _loc2_.text = TUtilityString.Format(this.FPersiaTrader.DescListNew[2],_loc3_.Desc1,_loc3_.Price,_loc3_.Inventory.Name);
            }
            else
            {
               _loc2_.text = "";
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBtn() : void
      {
         if(this.FIsCD)
         {
            FMC_Scene.BTN_FreeFresh.visible = false;
            FMC_Scene.BTN_GoldFresh.visible = true;
         }
         else
         {
            FMC_Scene.BTN_FreeFresh.visible = true;
            FMC_Scene.BTN_GoldFresh.visible = false;
         }
      }
      
      protected function ProcessorOnBuyItemUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnBuyBox != null && Boolean(this.FPersiaTrader))
         {
            _loc3_ = this.FPersiaTrader.SaleItems[_loc2_].CurPrice;
            FOnBuyBox(TProcessorPersiaTrader.ACTIVITY_1_BUY_ITEM,_loc3_,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnFreshPriceUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnBuyBox != null && Boolean(this.FPersiaTrader))
         {
            _loc3_ = this.FPersiaTrader.FreshSinglePrice[_loc2_];
            if(this.FPersiaTrader.SaleItems[_loc2_].Min == this.FPersiaTrader.SaleItems[_loc2_].CurPrice)
            {
               FOnBuyBox(TProcessorPersiaTrader.ACTIVITY_1_FRESH_PRICE,_loc3_,_loc2_ + 1,0,this.FPersiaTrader.DescListNew[6],0,1);
            }
            else
            {
               FOnBuyBox(TProcessorPersiaTrader.ACTIVITY_1_FRESH_PRICE,_loc3_,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnFreshItemUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnBuyBox != null && Boolean(this.FPersiaTrader))
         {
            _loc3_ = this.FPersiaTrader.FreshSingleItem[_loc2_];
            if(this.FPersiaTrader.SaleItems[_loc2_].Level == 1)
            {
               FOnBuyBox(TProcessorPersiaTrader.ACTIVITY_1_FRESH_ITEM,_loc3_,_loc2_ + 1,0,this.FPersiaTrader.DescListNew[7],0,1);
            }
            else
            {
               FOnBuyBox(TProcessorPersiaTrader.ACTIVITY_1_FRESH_ITEM,_loc3_,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnFreeFreshAllUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && Boolean(this.FPersiaTrader))
         {
            if(this.FPersiaTrader.IsHaveSpecialGood())
            {
               FOnBuyBox(TProcessorPersiaTrader.ACTIVITY_1_FREE_FRESH_ALL_ITEM,0,0,0,this.FPersiaTrader.DescListNew[8],0,1);
            }
            else
            {
               FOnGetBox(TProcessorPersiaTrader.ACTIVITY_1_FREE_FRESH_ALL_ITEM);
            }
         }
      }
      
      protected function ProcessorOnGoldFreshAllUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnBuyBox != null && Boolean(this.FPersiaTrader))
         {
            _loc2_ = this.FPersiaTrader.FreshPrice;
            if(this.FPersiaTrader.IsHaveSpecialGood())
            {
               FOnBuyBox(TProcessorPersiaTrader.ACTIVITY_1_GOLD_FRESH_ALL_ITEM,0,0,0,this.FPersiaTrader.DescListNew[8],0,1);
            }
            else
            {
               FOnBuyBox(TProcessorPersiaTrader.ACTIVITY_1_GOLD_FRESH_ALL_ITEM,_loc2_);
            }
         }
      }
      
      protected function ProcessorOnFreshPriceOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnShowHtmlTip != null)
         {
            _loc3_ = this.FPersiaTrader.FreshSinglePrice[_loc2_];
            _loc4_ = TUtilityString.Format(this.FPersiaTrader.DescListNew[4],_loc3_);
            FOnShowHtmlTip(_loc4_);
         }
      }
      
      protected function ProcessorOnFreshItemOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnShowHtmlTip != null)
         {
            _loc3_ = this.FPersiaTrader.FreshSingleItem[_loc2_];
            _loc4_ = TUtilityString.Format(this.FPersiaTrader.DescListNew[3],_loc3_);
            FOnShowHtmlTip(_loc4_);
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(this,param2);
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int) : void
      {
         if(FOnShowRecruit != null)
         {
            FOnShowRecruit(param1,param2);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < ITEM_TYPE)
            {
               if(this.FSaleList[_loc1_])
               {
                  this.FSaleList[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
            if(Boolean(this.FTF_Time) && Boolean(this.FPersiaTrader))
            {
               _loc2_ = this.FPersiaTrader.NextTime - STimingCore.GetServerTick();
               this.FTF_Time.text = TGameUtil.fomatTime(_loc2_);
               if(_loc2_ <= 0 && this.FIsCD || _loc2_ > 0 && !this.FIsCD)
               {
                  this.FIsCD = _loc2_ <= 0 ? false : true;
                  this.UpdateBtn();
               }
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateItems();
         this.UpdateLog();
         this.UpdateBtn();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
      }
      
      override public function MovieEnd() : void
      {
      }
      
      override public function Unmount() : void
      {
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
      }
   }
}

