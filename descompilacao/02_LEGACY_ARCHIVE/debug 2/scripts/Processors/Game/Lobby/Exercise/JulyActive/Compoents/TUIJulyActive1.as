package Processors.Game.Lobby.Exercise.JulyActive.Compoents
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.JulyActive.TJulyActive1;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.JulyActive.TProcessorJulyActive;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIJulyActive1 extends TUIBaseWindow
   {
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected static const BUY_BOX_COUNT:int = 5;
      
      protected static const EXCHANGE_BOX_COUNT:int = 10;
      
      protected static const MOVIE_TYPE_OPEN_CRYSTAL:int = 1;
      
      protected static const MOVIE_TYPE_GET_CRYSTAL:int = 2;
      
      protected static const MOVIE_TYPE_OPEN_HOLE:int = 3;
      
      protected var FJulyActive1:TJulyActive1;
      
      protected var FGiftList:Vector.<MovieClip>;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      public function TUIJulyActive1(param1:TUIComponent)
      {
         super(param1);
         this.FGiftList = new Vector.<MovieClip>(BUY_BOX_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         FMC_Scene.MC_DailyBox.buttonMode = true;
         FMC_Scene.MC_DailyBox.addEventListener(MouseEvent.CLICK,this.ProcessorOnDailyBoxUp);
         FMC_Scene.MC_DailyBox.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnDailyBoxOver);
         FMC_Scene.MC_DailyBox.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnDailyBoxOut);
         FMC_Scene.MC_SaleBox.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnSaleBoxUp);
         FMC_Scene.MC_SaleBox.BTN_Buy.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSaleTipOver);
         FMC_Scene.MC_SaleBox.BTN_Buy.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_SaleBox.MC_Mask.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSaleBoxOver);
         FMC_Scene.MC_SaleBox.MC_Mask.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnSaleBoxOut);
         _loc2_ = 0;
         while(_loc2_ < BUY_BOX_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Gift" + _loc2_];
            _loc4_.MC_Box.MC_Icon.gotoAndStop(_loc2_ + 1);
            _loc4_.MC_Tip.buttonMode = true;
            _loc4_.MC_Tip.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
            _loc4_.MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
            _loc4_.MC_Tip.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnGiftOut);
            this.FGiftList[_loc2_] = _loc4_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < EXCHANGE_BOX_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Box" + _loc2_];
            _loc4_.MC_Icon.buttonMode = true;
            _loc4_.MC_Icon.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeItemUp);
            _loc4_.MC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnExchangeItemOver);
            _loc4_.MC_Icon.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnExchangeItemOut);
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.MC_Crystal.BTN_Buy,true);
         FMC_Scene.MC_Crystal.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyCrystalUp);
         FMC_Scene.MC_Crystal.MC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnCrystalOver);
         FMC_Scene.MC_Crystal.MC_Icon.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.MC_Hole.BTN_Buy,true);
         FMC_Scene.MC_Hole.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyHoleUp);
         FMC_Scene.MC_Hole.MC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHoleOver);
         FMC_Scene.MC_Hole.MC_Icon.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         if(FMC_Scene.BTN_EquipDesc)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_EquipDesc,true);
            FMC_Scene.BTN_EquipDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadEquipDesc);
         }
         FMC_Scene.MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTipOver);
         FMC_Scene.MC_Tip.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_CountATip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnCountATipOver);
         FMC_Scene.MC_CountATip.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_CountBTip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnCountBTipOver);
         FMC_Scene.MC_CountBTip.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         if(this.FJulyActive1.DailyStatus == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_DailyBox.gotoAndPlay(1);
            FMC_Scene.MC_DailyBox.MC_Got.visible = false;
         }
         else
         {
            FMC_Scene.MC_DailyBox.gotoAndStop(1);
            FMC_Scene.MC_DailyBox.MC_Got.visible = true;
         }
         if(this.FJulyActive1.NeedEffect == 0)
         {
            FMC_Scene.MC_GetBox.visible = true;
         }
         else
         {
            FMC_Scene.MC_GetBox.visible = false;
         }
         FMC_Scene.MC_SaleBox.TF_Count.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,this.FJulyActive1.SaleBox.Count);
         if(this.FJulyActive1.SaleBox.Status == TBaseActivity.STATUS_CANGET && this.FJulyActive1.SaleBox.Count > 0)
         {
            TGameUtil.setButtonMode(FMC_Scene.MC_SaleBox.BTN_Buy,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.MC_SaleBox.BTN_Buy,false);
         }
         _loc1_ = 0;
         while(_loc1_ < BUY_BOX_COUNT)
         {
            _loc3_ = this.FGiftList[_loc1_];
            if(_loc1_ < this.FJulyActive1.BuyCountAwards.length)
            {
               _loc4_ = this.FJulyActive1.BuyCountAwards[_loc1_];
               _loc3_.TF_Desc1.text = TUtilityString.Format(_loc4_.DescListNew[0],this.FJulyActive1.TotalCount);
               if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.MC_GetBox.visible = true;
                  _loc3_.MC_Got.visible = false;
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc3_.MC_GetBox.visible = false;
                  _loc3_.MC_Got.visible = false;
               }
               else
               {
                  _loc3_.MC_GetBox.visible = false;
                  _loc3_.MC_Got.visible = true;
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateExchange() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_BOX_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * EXCHANGE_BOX_COUNT;
            _loc4_ = FMC_Scene["MC_Box" + _loc1_];
            if(_loc2_ < this.FJulyActive1.BoxList.length)
            {
               _loc4_.visible = true;
               _loc4_.MC_Icon.gotoAndStop(_loc2_ + 1);
               _loc5_ = this.FJulyActive1.BoxList[_loc2_];
               _loc4_.TF_Price.text = "*" + _loc5_.Price.toString();
               _loc4_.TF_Count.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc5_.Count);
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FJulyActive1.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FJulyActive1.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FJulyActive1.DescListNew[1];
         FMC_Scene.TF_CountA.text = this.FJulyActive1.CountA.toString();
         FMC_Scene.TF_CountB.text = this.FJulyActive1.CountB.toString();
         FMC_Scene.MC_Crystal.TF_Count.text = this.FJulyActive1.ConsumeCountA.toString();
         FMC_Scene.MC_Hole.TF_Count.text = this.FJulyActive1.ConsumeCountB.toString();
         FMC_Scene.TF_Score.text = this.FJulyActive1.Score.toString();
         FMC_Scene.TF_Desc1.text = TUtilityString.Format(this.FJulyActive1.DescListNew[4],this.FJulyActive1.RankPoint);
         if(this.FJulyActive1.HoleStatus == 0)
         {
            FMC_Scene.MC_Hole.MC_Lock.visible = true;
         }
         else
         {
            FMC_Scene.MC_Hole.MC_Lock.visible = false;
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateExchange();
      }
      
      protected function ProcessorOnDailyBoxUp(param1:MouseEvent) : void
      {
         if(this.FJulyActive1.DailyStatus != TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         if(FOnGetBox != null)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorJulyActive.ACTIVITY_1_GET_DAILY_BOX);
         }
      }
      
      protected function ProcessorOnSaleBoxUp(param1:MouseEvent) : void
      {
         if(!this.FJulyActive1.SaleBox || this.FJulyActive1.SaleBox.Count <= 0 || this.FJulyActive1.SaleBox.Status != TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         if(FOnBuyBox != null)
         {
            FOnBuyBox(ACTIVITY_1_ID,TProcessorJulyActive.ACTIVITY_1_BUY_SALE_BOX,this.FJulyActive1.SaleBox.Price,0,TBaseActivity.SWEET_TYPE_GOLD);
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGetBox != null && _loc2_ < this.FJulyActive1.BuyCountAwards.length && this.FJulyActive1.BuyCountAwards[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorJulyActive.ACTIVITY_1_GET_SALE_COUNT_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnExchangeItemUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(FOnGetBox != null && _loc2_ < this.FJulyActive1.BoxList.length && this.FJulyActive1.BoxList[_loc2_].Count > 0)
         {
            if(this.FJulyActive1.Score >= this.FJulyActive1.BoxList[_loc2_].Price)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorJulyActive.ACTIVITY_1_EXCHANGE_ITEM,_loc2_ + 1);
            }
            else
            {
               FOnShowFlowText(this.FJulyActive1.DescListNew[9]);
            }
         }
      }
      
      protected function ProcessorOnBuyHoleUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnBuyBox != null && this.FJulyActive1.HoleStatus == 1)
         {
            if(this.FJulyActive1.CountB >= this.FJulyActive1.ConsumeCountB)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorJulyActive.ACTIVITY_1_OPEN_HOLE);
            }
            else
            {
               _loc2_ = (this.FJulyActive1.ConsumeCountB - this.FJulyActive1.CountB) * this.FJulyActive1.PriceB;
               _loc3_ = TUtilityString.Format(this.FJulyActive1.DescListNew[6],_loc2_);
               FOnBuyBox(ACTIVITY_1_ID,TProcessorJulyActive.ACTIVITY_1_OPEN_HOLE,_loc2_,0,TBaseActivity.SWEET_TYPE_GOLD,_loc3_);
            }
         }
      }
      
      protected function ProcessorOnBuyCrystalUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(FOnBuyBox != null)
         {
            if(this.FJulyActive1.CountA >= this.FJulyActive1.ConsumeCountA)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorJulyActive.ACTIVITY_1_OPEN_CRYSTAL);
            }
            else
            {
               _loc2_ = (this.FJulyActive1.ConsumeCountA - this.FJulyActive1.CountA) * this.FJulyActive1.PriceA;
               _loc3_ = TUtilityString.Format(this.FJulyActive1.DescListNew[6],_loc2_);
               FOnBuyBox(ACTIVITY_1_ID,TProcessorJulyActive.ACTIVITY_1_OPEN_CRYSTAL,_loc2_,0,TBaseActivity.SWEET_TYPE_GOLD,_loc3_);
            }
         }
      }
      
      protected function ProcessorOnDailyBoxOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnNewBoxOver != null && this.FJulyActive1) && Boolean(this.FJulyActive1.DailyItems) && this.FJulyActive1.DescList.length > 7)
         {
            FOnNewBoxOver(this.FJulyActive1.DailyItems,this.FJulyActive1.DescListNew[7]);
         }
      }
      
      protected function ProcessorOnDailyBoxOut(param1:MouseEvent) : void
      {
         if(FOnNewBoxOut != null)
         {
            FOnNewBoxOut();
         }
      }
      
      protected function ProcessorOnExchangeItemOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         _loc3_ = _loc2_ + this.FCurPage * EXCHANGE_BOX_COUNT;
         if(Boolean(FOnItemOver != null && this.FJulyActive1) && Boolean(_loc3_ < this.FJulyActive1.BoxList.length) && this.FJulyActive1.DescList.length > 8)
         {
            _loc4_ = this.FJulyActive1.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOver(this,_loc4_);
         }
      }
      
      protected function ProcessorOnExchangeItemOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         _loc3_ = _loc2_ + this.FCurPage * EXCHANGE_BOX_COUNT;
         if(Boolean(FOnItemOut != null && this.FJulyActive1) && Boolean(_loc3_ < this.FJulyActive1.BoxList.length) && this.FJulyActive1.DescList.length > 8)
         {
            _loc4_ = this.FJulyActive1.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOut(this,_loc4_);
         }
      }
      
      protected function ProcessorOnCountATipOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FJulyActive1) && this.FJulyActive1.DescList.length > 10)
         {
            FOnShowHtmlTip(this.FJulyActive1.DescListNew[10]);
         }
      }
      
      protected function ProcessorOnCountBTipOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FJulyActive1) && this.FJulyActive1.DescList.length > 11)
         {
            FOnShowHtmlTip(this.FJulyActive1.DescListNew[11]);
         }
      }
      
      protected function ProcessorOnTipOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FJulyActive1) && this.FJulyActive1.DescList.length > 5)
         {
            FOnShowHtmlTip(this.FJulyActive1.DescListNew[5]);
         }
      }
      
      protected function ProcessorOnCrystalOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FJulyActive1) && this.FJulyActive1.DescList.length > 2)
         {
            FOnShowHtmlTip(this.FJulyActive1.DescListNew[2]);
         }
      }
      
      protected function ProcessorOnHoleOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FJulyActive1) && this.FJulyActive1.DescList.length > 3)
         {
            FOnShowHtmlTip(this.FJulyActive1.DescListNew[3]);
         }
      }
      
      protected function ProcessorOnSaleTipOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FJulyActive1) && Boolean(this.FJulyActive1.SaleBox))
         {
            if(this.FJulyActive1.SaleBox.Price == 0)
            {
               _loc2_ = this.FJulyActive1.DescListNew[12];
            }
            else
            {
               _loc2_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BUY_PRICE,this.FJulyActive1.SaleBox.Price) + "    ";
            }
            FOnShowHtmlTip(_loc2_);
         }
      }
      
      protected function ProcessorOnSaleBoxOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnBoxOver != null && this.FJulyActive1) && Boolean(this.FJulyActive1.SaleBox) && Boolean(this.FJulyActive1.SaleBox.Inventories))
         {
            FOnNewBoxOver(this.FJulyActive1.SaleBox.Inventories,this.FJulyActive1.DescListNew[8]);
         }
      }
      
      protected function ProcessorOnSaleBoxOut(param1:MouseEvent) : void
      {
         if(FOnNewBoxOut != null)
         {
            FOnNewBoxOut();
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FJulyActive1) && _loc2_ < this.FJulyActive1.BuyCountAwards.length)
         {
            FOnNewBoxOver(this.FJulyActive1.BuyCountAwards[_loc2_].Inventories,this.FJulyActive1.DescListNew[8]);
         }
      }
      
      protected function ProcessorOnGiftOut(param1:MouseEvent) : void
      {
         if(FOnNewBoxOut != null)
         {
            FOnNewBoxOut();
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_1_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank(ACTIVITY_1_ID);
         }
      }
      
      protected function ProcessorOnLoadEquipDesc(param1:MouseEvent) : void
      {
         if(FOnShowWindow != null)
         {
            FOnShowWindow();
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         if(FInitialized && this.visible)
         {
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FJulyActive1 = SLogicsCore.JulyActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TJulyActive1;
         this.UpdateBox();
         this.UpdateExchange();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:TInventories = null;
         switch(param1)
         {
            case MOVIE_TYPE_OPEN_CRYSTAL:
               FMC_Scene.MC_Crystal.MC_Icon.gotoAndPlay(1);
               break;
            case MOVIE_TYPE_GET_CRYSTAL:
               FMC_Scene.MC_Crystal.MC_Item.gotoAndPlay(1);
               break;
            case MOVIE_TYPE_OPEN_HOLE:
               FMC_Scene.MC_Hole.MC_Icon.gotoAndPlay(1);
         }
      }
      
      override public function MovieEnd() : void
      {
      }
   }
}

