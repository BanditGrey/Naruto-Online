package Processors.Game.Lobby.Exercise.JanActive2016
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.JanActive_2016.TJanActive2_2016;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.FebActive.TProcessorFebActiveShop;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIJanActive2_2016 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 4;
      
      protected static const FRUIT_COUNT:int = 5;
      
      protected static const BTN_COUNT:int = 3;
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      protected var FJanActive2_2016:TJanActive2_2016;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      public function TUIJanActive2_2016(param1:TUIComponent)
      {
         super(param1);
         this.FUIPage = new TUIPage(this);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < FRUIT_COUNT)
         {
            _loc5_ = FMC_Scene["MC_Box" + _loc2_];
            _loc5_.buttonMode = true;
            _loc5_.addEventListener(MouseEvent.CLICK,this.ProcessorOnFruitUp);
            _loc5_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFruitOver);
            _loc5_.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < BTN_COUNT)
         {
            _loc5_ = FMC_Scene["BTN_Wish" + _loc2_];
            _loc5_.buttonMode = true;
            TGameUtil.setButtonMode(_loc5_,true);
            _loc5_.addEventListener(MouseEvent.CLICK,this.ProcessorOnWishUp);
            _loc5_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnWishOver);
            _loc5_.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc2_++;
         }
         FMC_Scene.MC_RechargeBox.MC_GoldPic.buttonMode = true;
         FMC_Scene.MC_RechargeBox.MC_GoldPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnRechargeBoxUp);
         FMC_Scene.MC_RechargeBox.MC_GoldPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnRechargeBoxOver);
         FMC_Scene.MC_RechargeBox.MC_GoldPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         FMC_Scene.MC_ConsumeBox.buttonMode = true;
         FMC_Scene.MC_ConsumeBox.addEventListener(MouseEvent.CLICK,this.ProcessorOnConsumeBoxUp);
         FMC_Scene.MC_ConsumeBox.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnConsumeBoxOver);
         FMC_Scene.MC_ConsumeBox.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_RechargeBox.BTN_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_RechargeBox.BTN_Right;
         this.FUIPage.PageSize = 1;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.FMC_Mask = FMC_Scene.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
         this.FShowItem = new TUIShowItem(this,BOX_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = this.ProcessorOnItemOver;
         this.FShowItem.OnOut = this.ProcessorOnItemOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
         this.FProcessorFebActiveShop.Visible = false;
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = this.ProcessorOnItemOver;
         this.FProcessorFebActiveShop.OnOut = this.ProcessorOnItemOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorFebActiveShop.X = -111;
         this.FProcessorFebActiveShop.y = -31;
         this.FProcessorFebActiveShop.Load();
         TGameUtil.setButtonMode(FMC_Scene.BTN_Upgrade,true);
         FMC_Scene.BTN_Upgrade.addEventListener(MouseEvent.CLICK,this.ProcessorOnUpgradeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Reset,true);
         FMC_Scene.BTN_Reset.addEventListener(MouseEvent.CLICK,this.ProcessorOnResetUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FJanActive2_2016.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FJanActive2_2016.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FJanActive2_2016.DescListNew[1];
         FMC_Scene.TF_ExchangePoint.text = this.FJanActive2_2016.ShopExchangePoint.toString();
         FMC_Scene.TF_RankPoint.text = this.FJanActive2_2016.RankPoint.toString();
         FMC_Scene.TF_Score.text = this.FJanActive2_2016.Score.toString();
      }
      
      protected function UpdateTree() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < FRUIT_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Box" + _loc1_];
            _loc4_.MC_Icon.gotoAndStop(this.FJanActive2_2016.TreeLevel);
            _loc5_ = this.FJanActive2_2016.FruitList[_loc1_];
            FMC_Scene.MC_Bar["TF_Value" + _loc1_].text = _loc5_.Price;
            if(_loc5_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc4_.MC_Click.visible = true;
               _loc4_.filters = [];
               _loc4_.visible = true;
            }
            else if(_loc5_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc4_.MC_Click.visible = false;
               _loc4_.filters = [TGameUtil.GaryColorFilters];
               _loc4_.visible = true;
            }
            else
            {
               _loc4_.MC_Click.visible = false;
               _loc4_.visible = false;
            }
            _loc1_++;
         }
         if(this.FJanActive2_2016.NeedReset == 1)
         {
            FMC_Scene.BTN_Upgrade.visible = false;
            FMC_Scene.BTN_Reset.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Reset,this.FJanActive2_2016.CanUpgrade);
         }
         else
         {
            FMC_Scene.BTN_Upgrade.visible = true;
            FMC_Scene.BTN_Reset.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Upgrade,this.FJanActive2_2016.CanUpgrade);
         }
         FMC_Scene.TF_Level.text = TUtilityString.Format(this.FJanActive2_2016.DescListNew[2],this.FJanActive2_2016.TreeLevel);
         FMC_Scene.MC_Tree.gotoAndStop(this.FJanActive2_2016.TreeLevel);
         FMC_Scene.MC_Bar.TF_Count.text = this.FJanActive2_2016.TreeExp + "/" + this.FJanActive2_2016.TreeExpMax;
         _loc2_ = Number(this.FJanActive2_2016.TreeExp / this.FJanActive2_2016.TreeExpMax) * this.FBarMaxWidth;
         _loc3_ = Math.min(_loc2_,this.FBarMaxWidth);
         this.FMC_Mask.width = _loc3_;
      }
      
      protected function UpdateRechargeBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:int = 0;
         this.FUIPage.TotalQuantity = this.FJanActive2_2016.RechargeBox.length;
         this.FUIPage.Update();
         _loc1_ = this.FCurPage;
         _loc3_ = this.FJanActive2_2016.RechargeBox[_loc1_];
         _loc2_ = FMC_Scene.MC_RechargeBox;
         _loc2_.MC_GoldPic.gotoAndStop(_loc1_ + 1);
         _loc2_.TF_Desc0.text = TUtilityString.Format(this.FJanActive2_2016.DescListNew[3],this.FJanActive2_2016.TotalRechargeGold);
         _loc2_.TF_Desc1.text = TUtilityString.Format(this.FJanActive2_2016.DescListNew[4],_loc3_.Price);
         _loc2_.TF_Count.text = "*" + _loc3_.Inventories.GetInventoryByIndex(0).Quantity;
         if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            _loc2_.MC_Click.visible = false;
            _loc2_.MC_Got.visible = false;
         }
         else if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
         {
            _loc2_.MC_Got.visible = false;
            _loc2_.MC_Click.visible = true;
         }
         else
         {
            _loc2_.MC_Click.visible = false;
            _loc2_.MC_Got.visible = true;
         }
      }
      
      protected function UpdateConsumeBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:int = 0;
         this.FShowItem.UpdateUI(this.FJanActive2_2016.ShowItem);
         _loc2_ = FMC_Scene.MC_ConsumeBox;
         _loc2_.TF_Desc0.text = TUtilityString.Format(this.FJanActive2_2016.DescListNew[5],this.FJanActive2_2016.TotalConsumeGold);
         _loc2_.TF_Desc1.text = TUtilityString.Format(this.FJanActive2_2016.DescListNew[6],this.FJanActive2_2016.ConsumeBox.Price);
         _loc2_.TF_Count.text = "*" + this.FJanActive2_2016.ConsumeBox.Count;
         _loc2_.MC_Click.visible = this.FJanActive2_2016.ConsumeBox.Count > 0 ? true : false;
         if(this.FJanActive2_2016.ConsumeBox.Count > 0)
         {
            _loc2_.MC_BoxPic.gotoAndPlay(1);
         }
         else
         {
            _loc2_.MC_BoxPic.stop();
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateRechargeBox();
      }
      
      override protected function ProcessorOnAcceptTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGetBox != null && _loc2_ < FActTaskData.TaskList.length && !FIsPlaying)
         {
            _loc3_ = FActTaskData.TaskList[_loc2_];
            FOnGetBox(ACTIVITY_2_ID,TProcessorJanActive2016.ACTIVITY_2_GET_TASK,_loc3_.Identify);
         }
      }
      
      override protected function ProcessorOnFinishTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGetBox != null && _loc2_ < FActTaskData.TaskList.length && !FIsPlaying)
         {
            _loc3_ = FActTaskData.TaskList[_loc2_];
            FOnGetBox(ACTIVITY_2_ID,TProcessorJanActive2016.ACTIVITY_2_FINISH_TASK,_loc3_.Identify);
         }
      }
      
      protected function ProcessorOnRechargeBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FCurPage;
         if(Boolean(FOnGetBox != null && !FIsPlaying) && Boolean(this.FJanActive2_2016) && this.FJanActive2_2016.RechargeBox[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorJanActive2016.ACTIVITY_2_GET_RECHARGE_GIFT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnConsumeBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(Boolean(FOnGetBox != null && !FIsPlaying) && Boolean(this.FJanActive2_2016) && this.FJanActive2_2016.ConsumeBox.Count > 0)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorJanActive2016.ACTIVITY_2_GET_CONSUME_GIFT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnFruitUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnGetBox != null && !FIsPlaying) && Boolean(this.FJanActive2_2016) && this.FJanActive2_2016.FruitList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorJanActive2016.ACTIVITY_2_GET_FRUIT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnWishUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc5_ = int(String(param1.currentTarget.name).slice(8));
         if(FOnBuyBox != null && !FIsPlaying && Boolean(this.FJanActive2_2016))
         {
            _loc4_ = this.FJanActive2_2016.CostList[_loc5_];
            if(this.FJanActive2_2016.Score >= _loc4_)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorJanActive2016.ACTIVITY_2_WISH,_loc5_ + 1);
            }
            else
            {
               _loc2_ = (_loc4_ - this.FJanActive2_2016.Score) * this.FJanActive2_2016.ScorePrice;
               _loc3_ = TUtilityString.Format(this.FJanActive2_2016.DescListNew[8],_loc4_,_loc2_,_loc4_ - this.FJanActive2_2016.Score);
               FOnBuyBox(ACTIVITY_2_ID,TProcessorJanActive2016.ACTIVITY_2_WISH,_loc2_,_loc5_ + 1,0,_loc3_);
            }
         }
      }
      
      protected function ProcessorOnUpgradeUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FJanActive2_2016))
         {
            FOnBuyBox(ACTIVITY_2_ID,TProcessorJanActive2016.ACTIVITY_2_UPGRADE,this.FJanActive2_2016.UpgradeCost);
         }
      }
      
      protected function ProcessorOnResetUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FJanActive2_2016))
         {
            FOnBuyBox(ACTIVITY_2_ID,TProcessorJanActive2016.ACTIVITY_2_RESET,this.FJanActive2_2016.ResetCost);
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FJanActive2_2016))
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorJanActive2016.ACTIVITY_2_EXCHANGE_BOX,param1 + 1);
         }
      }
      
      protected function ProcessorOnFruitOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && this.FJanActive2_2016.DescListNew.length > 0)
         {
            FOnShowHtmlTip(this.FJanActive2_2016.DescListNew[14 + this.FJanActive2_2016.TreeLevel - 1]);
         }
      }
      
      protected function ProcessorOnWishOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(FOnShowHtmlTip != null)
         {
            FOnShowHtmlTip(this.FJanActive2_2016.DescListNew[9 + _loc2_]);
         }
      }
      
      protected function ProcessorOnRechargeBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FCurPage;
         if(FOnNewBoxOver != null)
         {
            FOnNewBoxOver(this.FJanActive2_2016.RechargeBox[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnConsumeBoxOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null)
         {
            FOnShowHtmlTip(this.FJanActive2_2016.DescListNew[7]);
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
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int) : void
      {
         if(FOnShowRecruit != null)
         {
            FOnShowRecruit(param1,param2);
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI(this.FJanActive2_2016);
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank(ACTIVITY_2_ID);
         }
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorFebActiveShop.Visible = false;
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_2_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
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
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            if(FIsPlaying)
            {
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FJanActive2_2016 = SLogicsCore.JanActiveDatas_2016.GetActivityByIdentify(ACTIVITY_2_ID) as TJanActive2_2016;
         this.FCurPage = this.FUIPage.PageIndex = this.FJanActive2_2016.CurBoxIndex;
         this.UpdateText();
         UpdateTaskView();
         this.UpdateRechargeBox();
         this.UpdateConsumeBox();
         this.UpdateTree();
         if(this.FProcessorFebActiveShop.Visible)
         {
            this.FProcessorFebActiveShop.UpdateUI(this.FJanActive2_2016);
         }
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
      }
      
      override public function MovieEnd() : void
      {
      }
      
      override public function Unmount() : void
      {
         var _loc1_:int = 0;
         TweenUtil.removeAllTween();
      }
   }
}

