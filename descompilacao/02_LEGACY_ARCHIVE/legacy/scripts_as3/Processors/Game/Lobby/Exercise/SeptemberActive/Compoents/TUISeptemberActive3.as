package Processors.Game.Lobby.Exercise.SeptemberActive.Compoents
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.SeptemberActive.TSeptemberActive3;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.SeptemberActive.TProcessorSeptemberActive;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUISeptemberActive3 extends TUIBaseWindow
   {
      
      protected static const SHOW_ITEM_COUNT:int = 4;
      
      protected static const BOX_COUNT:int = 6;
      
      protected static const TASK_STEP:int = TActivityTaskData.STEP_COUNT;
      
      protected static const TASK_COUNT:int = 5;
      
      protected static const LUCKY_COUNT:int = 6;
      
      protected static const ACTIVITY_3_ID:int = 3;
      
      protected var FSeptemberActive3:TSeptemberActive3;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      protected var FCurTaskIndex:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FUIPage_LuckyPlayer:TUIPage;
      
      protected var FTotalPage_LuckyPlayer:int;
      
      protected var FCurPage_LuckyPlayer:int;
      
      protected var FIsPanelVisible:Boolean;
      
      public function TUISeptemberActive3(param1:TUIComponent)
      {
         super(param1);
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FUIPage = new TUIPage(this);
         this.FUIPage_LuckyPlayer = new TUIPage(this);
         this.FIsPanelVisible = false;
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene["MC_Box" + _loc2_];
            this.FBoxList[_loc2_].MC_Icon.gotoAndStop(_loc2_ + 1);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < TASK_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Task" + _loc2_];
            _loc4_.MC_Reward.gotoAndStop(_loc2_ + 1);
            TGameUtil.setButtonMode(_loc4_.BTN_Go,true);
            _loc4_.BTN_Go.addEventListener(MouseEvent.CLICK,this.ProcessorOnGoUp);
            TGameUtil.setButtonMode(_loc4_.BTN_GetTask,true);
            _loc4_.BTN_GetTask.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetTaskUp);
            TGameUtil.setButtonMode(_loc4_.BTN_Finish,true);
            _loc4_.BTN_Finish.addEventListener(MouseEvent.CLICK,this.ProcessorOnFinishUp);
            _loc4_.MC_Reward.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnRewardOver);
            _loc4_.MC_Reward.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItem);
         this.FShowItem.OnOverlay = this.ProcessorOnItemOver;
         this.FShowItem.OnOut = this.ProcessorOnItemOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         FMC_Scene.MC_Gift.buttonMode = true;
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.Btn_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.Btn_Right;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = 1;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.FUIPage_LuckyPlayer.ButtonPrevious.Substrate = FMC_Scene.MC_LuckyPlayer.MC_ChangePage.MC_PageLeft;
         this.FUIPage_LuckyPlayer.ButtonNext.Substrate = FMC_Scene.MC_LuckyPlayer.MC_ChangePage.MC_PageRight;
         this.FUIPage_LuckyPlayer.TotalQuantity = this.FTotalPage_LuckyPlayer;
         this.FUIPage_LuckyPlayer.LabelPage = FMC_Scene.MC_LuckyPlayer.MC_ChangePage.TF_Page;
         this.FUIPage_LuckyPlayer.PageSize = LUCKY_COUNT;
         this.FUIPage_LuckyPlayer.PageIndex = 0;
         this.FCurPage_LuckyPlayer = 0;
         this.FUIPage_LuckyPlayer.OnChangePage = this.ProcessorPageOnChange_LuckyPlayer;
         FMC_Scene.MC_ShowList.MC_ShowList.btn_hidePanel.visible = false;
         TGameUtil.setButtonMode(FMC_Scene.MC_ShowList.MC_ShowList.btn_hidePanel,true);
         TGameUtil.setButtonMode(FMC_Scene.MC_ShowList.MC_ShowList.btn_showPanel,true);
         FMC_Scene.MC_ShowList.MC_ShowList.btn_hidePanel.addEventListener(MouseEvent.CLICK,this.ProcessorOnHidePanelUp);
         FMC_Scene.MC_ShowList.MC_ShowList.btn_showPanel.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowPanelUp);
         FMC_Scene.MC_Pool.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnPoolOver);
         FMC_Scene.MC_Pool.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnWishUp);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnWishOver);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         if(FMC_Scene.BTN_Equipment)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Equipment,true);
            FMC_Scene.BTN_Equipment.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowWindow);
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(_loc1_ < this.FSeptemberActive3.BoxList.length)
            {
               _loc4_ = this.FSeptemberActive3.BoxList[_loc1_];
               if(_loc1_ == this.FSeptemberActive3.WishIndex)
               {
                  _loc3_.filters = [];
                  _loc3_.gotoAndPlay(1);
               }
               else
               {
                  _loc3_.filters = [TGameUtil.darkFilters];
                  _loc3_.gotoAndStop(1);
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateTask() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TDessertHouseTask = null;
         _loc1_ = 0;
         while(_loc1_ < TASK_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Task" + _loc1_];
            if(_loc1_ < this.FActivityTaskData.TaskList.length)
            {
               _loc4_.visible = true;
               _loc5_ = this.FActivityTaskData.TaskList[_loc1_];
               _loc3_ = _loc5_.Step >= TASK_STEP ? int(TASK_STEP - 1) : _loc5_.Step;
               _loc4_.TF_Desc.text = TUtilityString.Format(_loc5_.TaskDesc,_loc5_.TaskReq[_loc3_]);
               _loc4_.TF_Process.text = _loc5_.Process + "/" + _loc5_.ClientTaskReq[_loc3_];
               if(_loc5_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc4_.BTN_Finish.visible = false;
                  _loc4_.BTN_GetTask.visible = true;
                  _loc4_.MC_Finish.visible = false;
               }
               else if(_loc5_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc4_.BTN_Finish.visible = true;
                  _loc4_.BTN_GetTask.visible = false;
                  _loc4_.MC_Finish.visible = false;
                  if(_loc5_.Process >= _loc5_.ClientTaskReq[_loc3_])
                  {
                     TGameUtil.setButtonMode(_loc4_.BTN_Finish,true);
                  }
                  else
                  {
                     TGameUtil.setButtonMode(_loc4_.BTN_Finish,false);
                  }
               }
               else if(_loc5_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc4_.BTN_Finish.visible = false;
                  _loc4_.BTN_GetTask.visible = false;
                  _loc4_.MC_Finish.visible = true;
               }
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateServerBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TBaseBox = null;
         this.FUIPage.TotalQuantity = this.FSeptemberActive3.ServerBoxList.length;
         this.FUIPage.Update();
         _loc2_ = this.FCurPage;
         _loc4_ = FMC_Scene.MC_Gift;
         _loc4_.MC_BoxPic.gotoAndStop(_loc2_ + 1);
         _loc5_ = this.FSeptemberActive3.ServerBoxList[_loc2_];
         _loc4_.MC_Desc.TF_Desc.text = TUtilityString.Format(this.FSeptemberActive3.DescListNew[2],_loc5_.Price);
         if(_loc5_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            _loc4_.MC_Got.visible = false;
            _loc4_.MC_CanGet.visible = false;
         }
         else if(_loc5_.Status == TBaseActivity.STATUS_CANGET)
         {
            _loc4_.MC_Got.visible = false;
            _loc4_.MC_CanGet.visible = true;
         }
         else
         {
            _loc4_.MC_Got.visible = true;
            _loc4_.MC_CanGet.visible = false;
         }
      }
      
      protected function UpdateLuckyPlayer() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         this.FUIPage_LuckyPlayer.TotalQuantity = this.FSeptemberActive3.LuckyList.length;
         this.FUIPage_LuckyPlayer.Update();
         FMC_Scene.MC_LuckyPlayer.visible = this.FIsPanelVisible;
         _loc1_ = 0;
         while(_loc1_ < LUCKY_COUNT)
         {
            _loc4_ = FMC_Scene.MC_LuckyPlayer["MC_Log" + _loc1_];
            _loc2_ = _loc1_ + this.FCurPage_LuckyPlayer * LUCKY_COUNT;
            if(_loc2_ < this.FSeptemberActive3.LuckyList.length)
            {
               _loc4_.visible = true;
               _loc4_.TF_Name.text = this.FSeptemberActive3.LuckyList[_loc2_].name;
               _loc4_.TF_Gold.text = this.FSeptemberActive3.LuckyList[_loc2_].gold.toString();
               _loc4_.TF_Server.text = this.FSeptemberActive3.LuckyList[_loc2_].server;
               _loc4_.TF_Date.text = TUtilityDate.FormatMMDDChineseNew(new Date(STimingCore.GetClientShowTime(this.FSeptemberActive3.LuckyList[_loc2_].date) * 1000));
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateShowItem() : void
      {
         this.FShowItem.UpdateUI(this.FSeptemberActive3.ShowItems);
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FSeptemberActive3.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FSeptemberActive3.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FSeptemberActive3.DescListNew[1].toString();
         FMC_Scene.TF_TotalCount.text = this.FSeptemberActive3.TotalCount.toString();
         FMC_Scene.MC_Count.TF_Count.text = this.FSeptemberActive3.RankPoint.toString();
         FMC_Scene.MC_Pool.TF_PoolGold.text = this.FSeptemberActive3.PoolGold.toString();
         FMC_Scene.TF_MyScore.text = this.FSeptemberActive3.MyScore.toString();
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateServerBox();
      }
      
      protected function ProcessorPageOnChange_LuckyPlayer(param1:Object, param2:int) : void
      {
         this.FCurPage_LuckyPlayer = param2;
         this.UpdateLuckyPlayer();
      }
      
      protected function ProcessorOnWishUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         _loc2_ = this.FSeptemberActive3.WishIndex;
         if(Boolean(FOnGetBox != null) && Boolean(this.FSeptemberActive3) && _loc2_ < this.FSeptemberActive3.BoxList.length)
         {
            _loc3_ = this.FSeptemberActive3.BoxList[_loc2_].Price;
            if(this.FSeptemberActive3.MyScore >= _loc3_)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorSeptemberActive.ACTIVITY_3_BUY_WISH,_loc2_ + 1);
            }
            else
            {
               _loc4_ = (_loc3_ - this.FSeptemberActive3.MyScore) * this.FSeptemberActive3.ScorePrice;
               _loc5_ = TUtilityString.Format(this.FSeptemberActive3.DescListNew[3],_loc3_,_loc3_ - this.FSeptemberActive3.MyScore,_loc4_);
               FOnBuyBox(ACTIVITY_3_ID,TProcessorSeptemberActive.ACTIVITY_3_BUY_WISH,_loc4_,_loc2_ + 1,0,_loc5_);
            }
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         if(Boolean(FOnGetBox != null) && Boolean(this.FSeptemberActive3) && this.FCurPage < this.FSeptemberActive3.ServerBoxList.length)
         {
            if(this.FSeptemberActive3.ServerBoxList[this.FCurPage].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorSeptemberActive.ACTIVITY_3_GET_SERVER_BOX,this.FCurPage + 1);
            }
         }
      }
      
      protected function ProcessorOnGoUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGoto != null && _loc2_ < this.FActivityTaskData.TaskList.length)
         {
            FOnCloseWindow();
            _loc3_ = this.FActivityTaskData.TaskList[_loc2_];
            FOnGoto(_loc3_.Go);
         }
      }
      
      protected function ProcessorOnGetTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGetBox != null && _loc2_ < this.FActivityTaskData.TaskList.length)
         {
            _loc3_ = this.FActivityTaskData.TaskList[_loc2_];
            FOnGetBox(ACTIVITY_3_ID,TProcessorSeptemberActive.ACTIVITY_3_GET_TASK,_loc3_.Identify);
         }
      }
      
      protected function ProcessorOnFinishUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGetBox != null && _loc2_ < this.FActivityTaskData.TaskList.length)
         {
            _loc3_ = this.FActivityTaskData.TaskList[_loc2_];
            FOnGetBox(ACTIVITY_3_ID,TProcessorSeptemberActive.ACTIVITY_3_FINISH_TASK,_loc3_.Identify);
         }
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank(ACTIVITY_3_ID);
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_3_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function ProcessorOnShowWindow(param1:MouseEvent) : void
      {
         if(FOnShowWindow != null)
         {
            FOnShowWindow();
         }
      }
      
      protected function ProcessorOnRewardOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TDessertHouseTask = null;
         var _loc5_:TInventories = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnNewBoxOver != null && _loc2_ < this.FActivityTaskData.TaskList.length && this.FSeptemberActive3.DescList.length > 5)
         {
            _loc4_ = this.FActivityTaskData.TaskList[_loc2_];
            _loc6_ = Math.min(_loc4_.Step,TASK_STEP - 1);
            _loc5_ = _loc4_.TaskAward[_loc6_];
            _loc7_ = this.FSeptemberActive3.DescListNew[5];
            _loc7_ = _loc7_.split("%n").join("\n");
            _loc7_ = TUtilityString.Format(_loc7_,_loc4_.TaskPoint[_loc6_]);
            FOnNewBoxOver(_loc5_,_loc7_);
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FSeptemberActive3) && _loc2_ < this.FSeptemberActive3.BoxList.length)
         {
            FOnShowHtmlTip(this.FSeptemberActive3.BoxList[_loc2_].Desc1);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FSeptemberActive3) && this.FCurPage < this.FSeptemberActive3.ServerBoxList.length)
         {
            FOnNewBoxOver(this.FSeptemberActive3.ServerBoxList[this.FCurPage].Inventories);
         }
      }
      
      protected function ProcessorOnWishOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FSeptemberActive3) && this.FSeptemberActive3.WishIndex < this.FSeptemberActive3.BoxList.length)
         {
            _loc2_ = this.FSeptemberActive3.BoxList[this.FSeptemberActive3.WishIndex].Price;
            _loc3_ = TUtilityString.Format(this.FSeptemberActive3.DescListNew[4],_loc2_);
            FOnShowHtmlTip(_loc3_);
         }
      }
      
      protected function ProcessorOnPoolOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FSeptemberActive3) && this.FSeptemberActive3.DescList.length > 8)
         {
            FOnShowHtmlTip(this.FSeptemberActive3.DescListNew[8]);
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
      
      protected function ProcessorOnShowPanelUp(param1:MouseEvent) : void
      {
         this.FIsPanelVisible = true;
         FMC_Scene.MC_LuckyPlayer.visible = this.FIsPanelVisible;
         FMC_Scene.MC_ShowList.MC_ShowList.btn_hidePanel.visible = true;
         FMC_Scene.MC_ShowList.MC_ShowList.btn_showPanel.visible = false;
      }
      
      protected function ProcessorOnHidePanelUp(param1:MouseEvent) : void
      {
         this.FIsPanelVisible = false;
         FMC_Scene.MC_LuckyPlayer.visible = this.FIsPanelVisible;
         FMC_Scene.MC_ShowList.MC_ShowList.btn_hidePanel.visible = false;
         FMC_Scene.MC_ShowList.MC_ShowList.btn_showPanel.visible = true;
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         if(FInitialized && this.visible)
         {
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FSeptemberActive3 = SLogicsCore.SeptemberActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TSeptemberActive3;
         this.UpdateTask();
         this.UpdateServerBox();
         this.UpdateBox();
         this.UpdateLuckyPlayer();
         this.UpdateShowItem();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
      }
      
      override public function MovieEnd() : void
      {
      }
   }
}

