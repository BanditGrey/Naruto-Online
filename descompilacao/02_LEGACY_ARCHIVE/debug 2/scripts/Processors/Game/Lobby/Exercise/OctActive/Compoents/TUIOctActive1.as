package Processors.Game.Lobby.Exercise.OctActive.Compoents
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.OctActive.TOctActive1;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.OctActive.TProcessorOctActive;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIOctActive1 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 5;
      
      protected static const TASK_STEP:int = TActivityTaskData.STEP_COUNT;
      
      protected static const TASK_COUNT:int = 5;
      
      protected static const SHOW_ITEM_COUNT:int = 10;
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected var FOctActive1:TOctActive1;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      public function TUIOctActive1(param1:TUIComponent)
      {
         super(param1);
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FUIPage = new TUIPage(this);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.Resources_UIDispatch(param1);
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
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene["MC_Box" + _loc2_];
            this.FBoxList[_loc2_].MC_BoxPic.gotoAndStop(_loc2_ + 1);
            this.FBoxList[_loc2_].MC_CanGet.visible = false;
            this.FBoxList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
            _loc2_++;
         }
         FMC_Scene.MC_Gift.buttonMode = true;
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.CLICK,this.ProcessorOnBigBoxUp);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBigBoxOver);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBigBoxOut);
         TGameUtil.setButtonMode(FMC_Scene.MC_Server.BTN_Get,true);
         FMC_Scene.MC_Server.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnServerListUp);
         FMC_Scene.MC_Server.MC_GoldPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnServerListOver);
         FMC_Scene.MC_Server.MC_GoldPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItem);
         this.FShowItem.OnOverlay = this.ProcessorOnItemOver;
         this.FShowItem.OnOut = this.ProcessorOnItemOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_Server.BTN_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_Server.BTN_Right;
         this.FUIPage.PageSize = 1;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         FMC_Scene.MC_ScoreTip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnScoreTip);
         FMC_Scene.MC_ScoreTip.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_Count.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnCountTip);
         FMC_Scene.MC_Count.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
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
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:TBaseBox = null;
         _loc5_ = this.FOctActive1.BoxList[this.FOctActive1.BoxList.length - 1];
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(_loc1_ < this.FOctActive1.BoxList.length)
            {
               _loc4_ = this.FOctActive1.BoxList[_loc1_];
               _loc3_.MC_Count.TF_Count.text = "*" + (_loc4_.Price + (this.FOctActive1.Round - 1) * _loc5_.Price);
               if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.MC_CanGet.visible = true;
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc3_.MC_CanGet.visible = false;
               }
            }
            _loc1_++;
         }
         _loc3_ = FMC_Scene.MC_Gift;
         _loc4_ = this.FOctActive1.BigBox;
         _loc3_.MC_Count.TF_Count.text = "*" + _loc4_.Price;
         if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
         {
            _loc3_.MC_CanGet.visible = true;
            _loc3_.MC_Got.visible = false;
         }
         else if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            _loc3_.MC_CanGet.visible = false;
            _loc3_.MC_Got.visible = false;
         }
         else
         {
            _loc3_.MC_CanGet.visible = false;
            _loc3_.MC_Got.visible = true;
         }
      }
      
      protected function UpdateServerList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:TBaseBox = null;
         _loc2_ = FMC_Scene.MC_Server;
         this.FUIPage.TotalQuantity = this.FOctActive1.ServerList.length;
         this.FUIPage.Update();
         _loc1_ = this.FCurPage;
         _loc3_ = this.FOctActive1.ServerList[_loc1_];
         if(this.FOctActive1.TaskStatus == TBaseActivity.STATUS_CANNOTGET)
         {
            _loc2_.MC_Tip.visible = true;
            _loc2_.MC_End.visible = false;
            _loc2_.BTN_Get.visible = false;
            _loc2_.MC_Got.visible = false;
            _loc2_.TF_Price.text = TUtilityString.Format(this.FOctActive1.DescListNew[2],_loc3_.Price);
            _loc2_.MC_GoldPic.gotoAndStop(_loc1_ + 1);
         }
         else
         {
            _loc2_.MC_GoldPic.gotoAndStop(_loc1_ + 1);
            _loc2_.MC_Tip.visible = false;
            _loc2_.MC_End.visible = false;
            _loc2_.TF_Price.text = TUtilityString.Format(this.FOctActive1.DescListNew[2],_loc3_.Price);
            if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc2_.BTN_Get.visible = false;
               _loc2_.MC_Got.visible = false;
            }
            else if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc2_.MC_Got.visible = false;
               _loc2_.BTN_Get.visible = true;
            }
            else
            {
               _loc2_.BTN_Get.visible = false;
               _loc2_.MC_Got.visible = true;
            }
         }
      }
      
      protected function UpdateShowItem() : void
      {
         this.FShowItem.UpdateUI(this.FOctActive1.ShowItems);
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FOctActive1.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FOctActive1.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FOctActive1.DescListNew[1].toString();
         FMC_Scene.MC_Count.TF_Count.text = this.FOctActive1.RankPoint.toString();
         FMC_Scene.TF_TotalCount.text = this.FOctActive1.TotalCount.toString();
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateServerList();
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
            FOnGetBox(ACTIVITY_1_ID,TProcessorOctActive.ACTIVITY_1_GET_TASK,_loc3_.Identify);
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
            FOnGetBox(ACTIVITY_1_ID,TProcessorOctActive.ACTIVITY_1_FINISH_TASK,_loc3_.Identify);
         }
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnGetBox != null) && Boolean(this.FOctActive1) && _loc2_ < this.FOctActive1.BoxList.length)
         {
            if(this.FOctActive1.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorOctActive.ACTIVITY_1_GET_BOX,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnBigBoxUp(param1:MouseEvent) : void
      {
         if(FOnGetBox != null && Boolean(this.FOctActive1))
         {
            if(this.FOctActive1.BigBox.Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorOctActive.ACTIVITY_1_GET_BIG_BOX);
            }
         }
      }
      
      protected function ProcessorOnServerListUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = this.FCurPage;
         if(Boolean(FOnGetBox != null) && Boolean(this.FOctActive1) && _loc2_ < this.FOctActive1.ServerList.length)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorOctActive.ACTIVITY_1_GET_SERVER_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnRewardOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TDessertHouseTask = null;
         var _loc5_:TInventories = null;
         var _loc6_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnNewBoxOver != null && _loc2_ < this.FActivityTaskData.TaskList.length)
         {
            _loc4_ = this.FActivityTaskData.TaskList[_loc2_];
            _loc6_ = Math.min(_loc4_.Step,TASK_STEP - 1);
            _loc5_ = _loc4_.TaskAward[_loc6_];
            FOnNewBoxOver(_loc5_);
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnItemOver != null) && Boolean(this.FOctActive1) && _loc2_ < this.FOctActive1.BoxList.length)
         {
            FOnItemOver(this,this.FOctActive1.BoxList[_loc2_].Inventories.GetInventoryByIndex(0));
         }
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnItemOut != null) && Boolean(this.FOctActive1) && _loc2_ < this.FOctActive1.BoxList.length)
         {
            FOnItemOut(this,this.FOctActive1.BoxList[_loc2_].Inventories.GetInventoryByIndex(0));
         }
      }
      
      protected function ProcessorOnBigBoxOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnItemOver != null) && Boolean(this.FOctActive1) && Boolean(this.FOctActive1.BigBox))
         {
            FOnItemOver(this,this.FOctActive1.BigBox.Inventories.GetInventoryByIndex(0));
         }
      }
      
      protected function ProcessorOnBigBoxOut(param1:MouseEvent) : void
      {
         if(Boolean(FOnItemOut != null) && Boolean(this.FOctActive1) && Boolean(this.FOctActive1.BigBox))
         {
            FOnItemOut(this,this.FOctActive1.BigBox.Inventories.GetInventoryByIndex(0));
         }
      }
      
      protected function ProcessorOnServerListOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FCurPage;
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FOctActive1) && _loc2_ < this.FOctActive1.ServerList.length)
         {
            FOnNewBoxOver(this.FOctActive1.ServerList[_loc2_].Inventories);
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
      
      protected function ProcessorOnScoreTip(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FOctActive1) && this.FOctActive1.DescList.length > 3)
         {
            FOnShowHtmlTip(this.FOctActive1.DescListNew[3]);
         }
      }
      
      protected function ProcessorOnCountTip(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FOctActive1) && this.FOctActive1.DescList.length > 4)
         {
            FOnShowHtmlTip(this.FOctActive1.DescListNew[4]);
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int) : void
      {
         if(FOnShowRecruit != null)
         {
            FOnShowRecruit(param1,param2);
         }
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank(ACTIVITY_1_ID);
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
         this.FOctActive1 = SLogicsCore.OctActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TOctActive1;
         this.UpdateTask();
         this.UpdateBox();
         this.UpdateServerList();
         this.UpdateShowItem();
         this.UpdateText();
      }
   }
}

