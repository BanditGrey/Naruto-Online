package Processors.Game.Lobby.Exercise.ThanksgivingDay
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.ThanksgivingDay.TThanksgivingDay3;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIThanksgivingDay3 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 5;
      
      protected static const TASK_STEP:int = TActivityTaskData.STEP_COUNT;
      
      protected static const TASK_COUNT:int = 5;
      
      protected static const TASK_AWARD_COUNT:int = 2;
      
      protected static const ACTIVITY_3_ID:int = 3;
      
      protected static const PLAY_COUNT:int = 10;
      
      protected var FThanksgivingDay3:TThanksgivingDay3;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      protected var FCurTaskIndex:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      public function TUIThanksgivingDay3(param1:TUIComponent)
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
         var _loc5_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene["MC_Box" + _loc2_];
            this.FBoxList[_loc2_].MC_BoxPic.MC_Icon.gotoAndStop(_loc2_ + 1);
            this.FBoxList[_loc2_].MC_CanGet.visible = false;
            this.FBoxList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < TASK_COUNT)
         {
            _loc4_ = FMC_Scene["MC_task" + _loc2_];
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
         while(_loc2_ < TASK_AWARD_COUNT)
         {
            _loc5_ = FMC_Scene["MC_TaskBox" + _loc2_];
            _loc5_.addEventListener(MouseEvent.CLICK,this.ProcessorOnTaskRewardUp);
            _loc5_.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTaskRewardOver);
            _loc5_.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         TGameUtil.setButtonMode(FMC_Scene.BTN_PetDesc,true);
         FMC_Scene.BTN_PetDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnPetDescUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         FMC_Scene.MC_Gift.buttonMode = true;
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.CLICK,this.ProcessorOnBigBoxUp);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBigBoxOver);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBigBoxOut);
         FMC_Scene.MC_Pet.buttonMode = true;
         FMC_Scene.MC_Pet.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnPetOver);
         FMC_Scene.MC_Pet.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_ItemTip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnItemTipOver);
         FMC_Scene.MC_ItemTip.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_Target.MC_Movie.visible = false;
         TGameUtil.setButtonMode(FMC_Scene.MC_Click,true);
         FMC_Scene.MC_Click.addEventListener(MouseEvent.CLICK,this.ProcessorOnTargetUp);
         FMC_Scene.MC_Click.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTargetOver);
         FMC_Scene.MC_Click.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Ten,true);
         FMC_Scene.BTN_Ten.addEventListener(MouseEvent.CLICK,this.ProcessorOnTargetTenUp);
         FMC_Scene.BTN_Ten.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTargetTenOver);
         FMC_Scene.BTN_Ten.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.Btn_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.Btn_Right;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = TASK_AWARD_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         FMC_Scene.MC_Target.MC_Movie.visible = false;
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:TBaseBox = null;
         _loc5_ = this.FThanksgivingDay3.BoxList[this.FThanksgivingDay3.BoxList.length - 1];
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(_loc1_ < this.FThanksgivingDay3.BoxList.length)
            {
               _loc4_ = this.FThanksgivingDay3.BoxList[_loc1_];
               _loc3_.MC_Count.TF_Count.text = "*" + (_loc4_.Price + (this.FThanksgivingDay3.Round - 1) * _loc5_.Price);
               if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.MC_CanGet.visible = true;
                  _loc3_.MC_BoxPic.gotoAndPlay(1);
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc3_.MC_CanGet.visible = false;
                  _loc3_.MC_BoxPic.gotoAndStop(1);
               }
            }
            _loc1_++;
         }
         _loc3_ = FMC_Scene.MC_Gift;
         _loc4_ = this.FThanksgivingDay3.BigBox;
         _loc3_.MC_Count.TF_Count.text = "*" + _loc4_.Price;
         if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
         {
            _loc3_.MC_Click.visible = true;
            _loc3_.MC_Got.visible = false;
         }
         else if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            _loc3_.MC_Click.visible = false;
            _loc3_.MC_Got.visible = false;
         }
         else
         {
            _loc3_.MC_Click.visible = false;
            _loc3_.MC_Got.visible = true;
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
            _loc4_ = FMC_Scene["MC_task" + _loc1_];
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
            _loc1_++;
         }
      }
      
      protected function UpdateTaskReward() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TBaseBox = null;
         this.FUIPage.TotalQuantity = this.FActivityTaskData.BoxList.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < TASK_AWARD_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * TASK_AWARD_COUNT;
            _loc4_ = FMC_Scene["MC_TaskBox" + _loc1_];
            if(_loc2_ < this.FActivityTaskData.BoxList.length)
            {
               _loc4_.visible = true;
               _loc4_.MC_BoxPic.MC_Icon.gotoAndStop(_loc2_ + 1);
               _loc5_ = this.FActivityTaskData.BoxList[_loc2_];
               _loc4_.TF_Price.text = "*" + _loc5_.Price.toString();
               if(_loc5_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc4_.MC_BoxPic.gotoAndStop(1);
                  _loc4_.MC_Got.visible = false;
                  _loc4_.MC_CanGet.visible = false;
               }
               else if(_loc5_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc4_.MC_BoxPic.gotoAndPlay(1);
                  _loc4_.MC_Got.visible = false;
                  _loc4_.MC_CanGet.visible = true;
               }
               else
               {
                  _loc4_.MC_BoxPic.gotoAndStop(1);
                  _loc4_.MC_Got.visible = true;
                  _loc4_.MC_CanGet.visible = false;
               }
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
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FThanksgivingDay3.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FThanksgivingDay3.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FThanksgivingDay3.DescListNew[1].toString();
         FMC_Scene.TF_FreeCount.text = this.FThanksgivingDay3.FreeCount.toString();
         FMC_Scene.TF_Count.text = this.FThanksgivingDay3.MyPower;
         FMC_Scene.TF_Score.text = this.FThanksgivingDay3.RankPoint.toString();
         FMC_Scene.TF_TaskPoint.text = this.FActivityTaskData.Score.toString();
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateTaskReward();
      }
      
      protected function ProcessorOnTargetUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(Boolean(FOnGetBox != null) && Boolean(this.FThanksgivingDay3) && this.FThanksgivingDay3.DescList.length > 4)
         {
            if(this.FThanksgivingDay3.FreeCount > 0 || this.FThanksgivingDay3.MyPower > 0)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorThanksgivingDay.ACTIVITY_3_PLAY_DART);
            }
            else
            {
               _loc2_ = TUtilityString.Format(this.FThanksgivingDay3.DescListNew[4],this.FThanksgivingDay3.PowerPrice);
               FOnBuyBox(ACTIVITY_3_ID,TProcessorThanksgivingDay.ACTIVITY_3_PLAY_DART,this.FThanksgivingDay3.PowerPrice,0,0,_loc2_);
            }
         }
      }
      
      protected function ProcessorOnTargetTenUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(Boolean(FOnGetBox != null) && Boolean(this.FThanksgivingDay3) && this.FThanksgivingDay3.DescList.length > 4)
         {
            _loc2_ = PLAY_COUNT - this.FThanksgivingDay3.FreeCount - this.FThanksgivingDay3.MyPower;
            if(_loc2_ > 0)
            {
               _loc3_ = TUtilityString.Format(this.FThanksgivingDay3.DescListNew[4],this.FThanksgivingDay3.PowerPrice * _loc2_);
               FOnBuyBox(ACTIVITY_3_ID,TProcessorThanksgivingDay.ACTIVITY_3_PLAY_DART_TEN,this.FThanksgivingDay3.PowerPrice * _loc2_,0,0,_loc3_);
            }
            else
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorThanksgivingDay.ACTIVITY_3_PLAY_DART_TEN);
            }
         }
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnGetBox != null) && Boolean(this.FThanksgivingDay3) && _loc2_ < this.FThanksgivingDay3.BoxList.length)
         {
            if(this.FThanksgivingDay3.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorThanksgivingDay.ACTIVITY_3_GET_BOX,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnBigBoxUp(param1:MouseEvent) : void
      {
         if(FOnGetBox != null)
         {
            if(this.FThanksgivingDay3.BigBox.Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorThanksgivingDay.ACTIVITY_3_GET_BIG_BOX);
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
            FOnGetBox(ACTIVITY_3_ID,TProcessorThanksgivingDay.ACTIVITY_3_GET_TASK,_loc3_.Identify);
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
            FOnGetBox(ACTIVITY_3_ID,TProcessorThanksgivingDay.ACTIVITY_3_FINISH_TASK,_loc3_.Identify);
         }
      }
      
      protected function ProcessorOnTaskRewardUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(10));
         _loc3_ = _loc2_ + this.FCurPage * TASK_AWARD_COUNT;
         if(FOnGetBox != null && _loc3_ < this.FActivityTaskData.BoxList.length && this.FActivityTaskData.BoxList[_loc3_].Status == TBaseActivity.STATUS_CANGET)
         {
            _loc4_ = this.FActivityTaskData.BoxList[_loc3_];
            FOnGetBox(ACTIVITY_3_ID,TProcessorThanksgivingDay.ACTIVITY_3_GET_TASK_BOX,_loc3_ + 1);
         }
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank();
         }
      }
      
      protected function ProcessorOnPetDescUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FThanksgivingDay3) && Boolean(this.FThanksgivingDay3.Pet))
         {
            _loc2_ = this.FThanksgivingDay3.Pet;
            FOnShowRecruit(_loc2_.Identify,_loc2_.Type);
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
      
      protected function ProcessorOnRewardOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TDessertHouseTask = null;
         var _loc5_:TInventories = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnNewBoxOver != null && _loc2_ < this.FActivityTaskData.TaskList.length && this.FThanksgivingDay3.DescList.length > 7)
         {
            _loc4_ = this.FActivityTaskData.TaskList[_loc2_];
            _loc6_ = Math.min(_loc4_.Step,TASK_STEP - 1);
            _loc5_ = _loc4_.TaskAward[_loc6_];
            _loc7_ = this.FThanksgivingDay3.DescListNew[7];
            _loc7_ = _loc7_.split("%n").join("\n");
            _loc7_ = TUtilityString.Format(_loc7_,_loc4_.TaskPoint[_loc6_]);
            FOnNewBoxOver(_loc5_,_loc7_);
         }
      }
      
      protected function ProcessorOnTaskRewardOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(10));
         _loc3_ = _loc2_ + this.FCurPage * TASK_AWARD_COUNT;
         if(FOnNewBoxOver != null && _loc3_ < this.FActivityTaskData.BoxList.length)
         {
            _loc4_ = this.FActivityTaskData.BoxList[_loc3_];
            FOnNewBoxOver(_loc4_.Inventories);
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnItemOver != null) && Boolean(this.FThanksgivingDay3) && _loc2_ < this.FThanksgivingDay3.BoxList.length)
         {
            FOnItemOver(this,this.FThanksgivingDay3.BoxList[_loc2_].Inventories.GetInventoryByIndex(0));
         }
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnItemOut != null) && Boolean(this.FThanksgivingDay3) && _loc2_ < this.FThanksgivingDay3.BoxList.length)
         {
            FOnItemOut(this,this.FThanksgivingDay3.BoxList[_loc2_].Inventories.GetInventoryByIndex(0));
         }
      }
      
      protected function ProcessorOnBigBoxOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnItemOver != null) && Boolean(this.FThanksgivingDay3) && Boolean(this.FThanksgivingDay3.BigBox))
         {
            FOnItemOver(this,this.FThanksgivingDay3.BigBox.Inventories.GetInventoryByIndex(0));
         }
      }
      
      protected function ProcessorOnBigBoxOut(param1:MouseEvent) : void
      {
         if(Boolean(FOnItemOut != null) && Boolean(this.FThanksgivingDay3) && Boolean(this.FThanksgivingDay3.BigBox))
         {
            FOnItemOut(this,this.FThanksgivingDay3.BigBox.Inventories.GetInventoryByIndex(0));
         }
      }
      
      protected function ProcessorOnTargetOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FThanksgivingDay3) && this.FThanksgivingDay3.DescList.length > 3)
         {
            FOnShowHtmlTip(this.FThanksgivingDay3.DescListNew[3]);
         }
      }
      
      protected function ProcessorOnTargetTenOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FThanksgivingDay3) && this.FThanksgivingDay3.DescList.length > 8)
         {
            FOnShowHtmlTip(this.FThanksgivingDay3.DescListNew[8]);
         }
      }
      
      protected function ProcessorOnPetOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FThanksgivingDay3) && this.FThanksgivingDay3.DescList.length > 5)
         {
            FOnShowHtmlTip(this.FThanksgivingDay3.DescListNew[5]);
         }
      }
      
      protected function ProcessorOnItemTipOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FThanksgivingDay3) && this.FThanksgivingDay3.DescList.length > 6)
         {
            FOnShowHtmlTip(this.FThanksgivingDay3.DescListNew[6]);
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
         this.FThanksgivingDay3 = SLogicsCore.ThanksgivingDayDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TThanksgivingDay3;
         if(this.FActivityTaskData.BoxList[0].Status == TBaseActivity.STATUS_GETED && this.FActivityTaskData.BoxList[1].Status == TBaseActivity.STATUS_GETED)
         {
            this.FUIPage.TotalQuantity = this.FActivityTaskData.BoxList.length;
            this.FUIPage.PageIndex = 1;
            this.FUIPage.Update();
            this.FCurPage = 1;
         }
         this.UpdateBox();
         this.UpdateTask();
         this.UpdateTaskReward();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:MovieClip = null;
         _loc3_ = FMC_Scene.MC_Target.MC_Movie;
         _loc3_.visible = true;
         _loc3_.gotoAndPlay(1);
      }
      
      override public function MovieEnd() : void
      {
      }
   }
}

