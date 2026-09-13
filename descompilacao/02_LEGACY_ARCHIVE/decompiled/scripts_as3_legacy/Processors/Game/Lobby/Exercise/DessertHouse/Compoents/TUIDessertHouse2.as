package Processors.Game.Lobby.Exercise.DessertHouse.Compoents
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.DessertHouse.TDessertHouse;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.DessertHouse.TProcessorDessertHouse;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIDessertHouse2 extends TUIBaseWindow
   {
      
      protected static const TASK_COUNT:int = 3;
      
      protected static const ITEM_COUNT:int = 3;
      
      protected static const BOX_COUNT:int = 4;
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      protected static const MIN_SCROLL_HEIGHT:Number = 244;
      
      protected static const ITEM_STAMP:Number = 2;
      
      protected static const SINGLE_ITEM_STAMP:Number = 87;
      
      protected static const ITEM_HEIGHT:Number = 87;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      protected var FDessertHouse:TDessertHouse;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FTaskList:Vector.<TUIDessertHouseTask>;
      
      protected var FCurTaskIndex:int;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      public function TUIDessertHouse2(param1:TUIComponent)
      {
         super(param1);
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         this.FDessertHouse = SLogicsCore.DessertHouse;
         this.FTaskList = new Vector.<TUIDessertHouseTask>();
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         this.FScrollBar = new TScrollBar(FMC_Scene.MC_List,MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
         _loc2_ = 0;
         while(_loc2_ < ITEM_COUNT)
         {
            FMC_Scene["MC_Item" + _loc2_].MC_Icon.gotoAndStop(_loc2_ + 1);
            _loc2_++;
         }
         this.FMC_Mask = FMC_Scene.MC_Bar.MC_Mask;
         if(this.FMC_Mask)
         {
            this.FBarMaxWidth = this.FMC_Mask.width;
         }
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT + 1)
         {
            FMC_Scene["MC_Box" + _loc2_].buttonMode = true;
            FMC_Scene["MC_Box" + _loc2_].MC_Icon.gotoAndStop(_loc2_ + 1);
            FMC_Scene["MC_Box" + _loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnBoxUp);
            FMC_Scene["MC_Box" + _loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            FMC_Scene["MC_Box" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         FMC_Scene.MC_Finish.visible = false;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Go,true);
         FMC_Scene.BTN_Go.addEventListener(MouseEvent.CLICK,this.ProcessorOnGoUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_GetTask,true);
         FMC_Scene.BTN_GetTask.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetTaskUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Finish,true);
         FMC_Scene.BTN_Finish.addEventListener(MouseEvent.CLICK,this.ProcessorOnFinishUp);
         TweenUtil.to(this.FMC_Mask,1000,{"width":0});
         FMC_Scene.MC_Effect.visible = false;
      }
      
      protected function UpdateTask() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUIDessertHouseTask = null;
         var _loc4_:TDessertHouseTask = null;
         if(this.FTaskList.length == 0)
         {
            _loc2_ = int(this.FActivityTaskData.TaskList.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc4_ = this.FActivityTaskData.TaskList[_loc1_];
               _loc3_ = new TUIDessertHouseTask(this);
               _loc3_.y = _loc1_ * ITEM_HEIGHT;
               _loc3_.OnSelect = this.ProcessorOnTaskSelect;
               _loc3_.OnReset = this.ProcessorOnTaskReset;
               _loc3_.Init(_loc1_,_loc4_);
               this.FTaskList[_loc1_] = _loc3_;
               this.FScrollBar.AddItem(_loc3_);
               if(this.FCurTaskIndex == _loc1_)
               {
                  _loc3_.SetSelected(true);
               }
               else
               {
                  _loc3_.SetSelected(false);
               }
               _loc1_++;
            }
         }
         else
         {
            _loc2_ = int(this.FTaskList.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc4_ = this.FActivityTaskData.TaskList[_loc1_];
               _loc3_ = this.FTaskList[_loc1_];
               _loc3_.Init(_loc1_,_loc4_);
               if(this.FCurTaskIndex == _loc1_)
               {
                  _loc3_.SetSelected(true);
               }
               else
               {
                  _loc3_.SetSelected(false);
               }
               _loc1_++;
            }
         }
      }
      
      protected function UpdateTaskContent() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TDessertHouseTask = null;
         var _loc5_:TInventory = null;
         _loc4_ = this.FActivityTaskData.TaskList[this.FCurTaskIndex];
         FMC_Scene.MC_Difficulty.gotoAndStop(_loc4_.Step + 1);
         _loc3_ = _loc4_.Step >= TASK_COUNT ? int(TASK_COUNT - 1) : _loc4_.Step;
         FMC_Scene.TF_Desc.text = TUtilityString.Format(_loc4_.TaskDesc,_loc4_.TaskReq[_loc3_]);
         FMC_Scene.TF_Process.text = _loc4_.Process + "/" + _loc4_.ClientTaskReq[_loc3_];
         FMC_Scene.TF_Point.text = _loc4_.TaskPoint[_loc3_];
         if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.BTN_Finish.visible = false;
            FMC_Scene.BTN_GetTask.visible = true;
            FMC_Scene.MC_Finish.visible = false;
         }
         else if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.BTN_Finish.visible = true;
            FMC_Scene.BTN_GetTask.visible = false;
            FMC_Scene.MC_Finish.visible = false;
            if(_loc4_.Process >= _loc4_.ClientTaskReq[_loc3_])
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Finish,true);
            }
            else
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Finish,false);
            }
         }
         else if(_loc4_.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.BTN_Finish.visible = false;
            FMC_Scene.BTN_GetTask.visible = false;
            FMC_Scene.MC_Finish.visible = true;
         }
         _loc1_ = 0;
         while(_loc1_ < ITEM_COUNT)
         {
            _loc5_ = _loc4_.TaskAward[_loc3_].GetInventoryByIndex(_loc1_);
            FMC_Scene["MC_Item" + _loc1_].TF_Num.text = _loc5_.Quantity.toString();
            _loc1_++;
         }
      }
      
      protected function UpdateBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Box" + _loc1_];
            _loc4_ = this.FActivityTaskData.BoxList[_loc1_];
            if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_.MC_Click.visible = false;
               _loc3_.MC_Got.visible = false;
            }
            else if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.MC_Click.visible = true;
               _loc3_.MC_Got.visible = false;
            }
            else
            {
               _loc3_.MC_Click.visible = false;
               _loc3_.MC_Got.visible = true;
            }
            _loc1_++;
         }
         _loc4_ = this.FActivityTaskData.BoxList[this.FActivityTaskData.BoxList.length - 1];
         if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.MC_Box4.MC_Click.visible = false;
            FMC_Scene.MC_Box4.MC_Got.visible = false;
            FMC_Scene.MC_Box4.MC_Opened.visible = false;
            FMC_Scene.MC_Box4.MC_Icon.gotoAndStop(1);
            FMC_Scene.MC_Box4.MC_Icon.visible = true;
         }
         else if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_Box4.MC_Click.visible = true;
            FMC_Scene.MC_Box4.MC_Got.visible = false;
            FMC_Scene.MC_Box4.MC_Opened.visible = false;
            FMC_Scene.MC_Box4.MC_Icon.gotoAndPlay(1);
            FMC_Scene.MC_Box4.MC_Icon.visible = true;
         }
         else
         {
            FMC_Scene.MC_Box4.MC_Click.visible = false;
            FMC_Scene.MC_Box4.MC_Got.visible = true;
            FMC_Scene.MC_Box4.MC_Opened.visible = false;
            FMC_Scene.MC_Box4.MC_Icon.gotoAndStop(1);
            FMC_Scene.MC_Box4.MC_Icon.visible = false;
            FMC_Scene.MC_Box4.MC_Opened.visible = true;
         }
         FMC_Scene.TF_Score.text = this.FActivityTaskData.Score.toString();
         _loc5_ = Number(this.FActivityTaskData.Score / this.FActivityTaskData.MaxScore) * this.FBarMaxWidth;
         _loc6_ = Math.min(_loc5_,this.FBarMaxWidth);
         TweenUtil.to(this.FMC_Mask,1000,{"width":_loc6_});
      }
      
      protected function ProcessorOnTaskSelect(param1:int) : void
      {
         this.FCurTaskIndex = param1;
         this.UpdateTask();
         this.UpdateTaskContent();
      }
      
      protected function ProcessorOnTaskReset(param1:int) : void
      {
         var _loc2_:TDessertHouseTask = null;
         if(FOnBuyBox != null)
         {
            _loc2_ = this.FActivityTaskData.GetTaskByIdentify(param1);
            FOnBuyBox(ACTIVITY_2_ID,TProcessorDessertHouse.ACTIVITY_2_RESET_TASK,_loc2_.Consume,param1);
         }
      }
      
      protected function ProcessorOnGoUp(param1:MouseEvent) : void
      {
         var _loc2_:TDessertHouseTask = null;
         if(FOnGoto != null && this.FCurTaskIndex < this.FActivityTaskData.TaskList.length)
         {
            FOnCloseWindow();
            _loc2_ = this.FActivityTaskData.TaskList[this.FCurTaskIndex];
            FOnGoto(_loc2_.Go);
         }
      }
      
      protected function ProcessorOnGetTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:TDessertHouseTask = null;
         if(FOnGetBox != null && this.FCurTaskIndex < this.FActivityTaskData.TaskList.length)
         {
            _loc2_ = this.FActivityTaskData.TaskList[this.FCurTaskIndex];
            FOnGetBox(ACTIVITY_2_ID,TProcessorDessertHouse.ACTIVITY_2_GET_TASK,_loc2_.Identify);
         }
      }
      
      protected function ProcessorOnFinishUp(param1:MouseEvent) : void
      {
         var _loc2_:TDessertHouseTask = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && this.FCurTaskIndex < this.FActivityTaskData.TaskList.length)
         {
            _loc2_ = this.FActivityTaskData.TaskList[this.FCurTaskIndex];
            FOnGetBox(ACTIVITY_2_ID,TProcessorDessertHouse.ACTIVITY_2_FINISH_TASK,_loc2_.Identify);
         }
      }
      
      protected function ProcessorOnBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnGetBox != null && this.FActivityTaskData) && Boolean(_loc2_ < this.FActivityTaskData.BoxList.length) && this.FActivityTaskData.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorDessertHouse.ACTIVITY_2_GET_TASK_BOX,_loc2_ + 1);
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FActivityTaskData) && _loc2_ < this.FActivityTaskData.BoxList.length)
         {
            FOnNewBoxOver(this.FActivityTaskData.BoxList[_loc2_].Inventories);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         if(FInitialized && FMC_Scene.visible)
         {
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateTask();
         this.UpdateTaskContent();
         this.UpdateBar();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         FMC_Scene.MC_Effect.visible = true;
         FMC_Scene.MC_Effect.gotoAndPlay(1);
      }
      
      override public function MovieEnd() : void
      {
      }
   }
}

