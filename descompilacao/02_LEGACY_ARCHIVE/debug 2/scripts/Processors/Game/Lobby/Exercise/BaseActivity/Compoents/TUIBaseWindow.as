package Processors.Game.Lobby.Exercise.BaseActivity.Compoents
{
   import Foundation.Common.THint;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIBaseWindow extends TUIComponent
   {
      
      protected static const ACT_TASK_COUNT:int = 5;
      
      protected static const ACT_TASK_STEP:int = TActivityTaskData.STEP_COUNT;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FInitialized:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FTotalFrame:int;
      
      protected var CurFrame:int;
      
      protected var FIsMovieVisible:Boolean;
      
      protected var FHint:THint;
      
      protected var FActTaskData:TActivityTaskData;
      
      protected var FFlowStr:String;
      
      protected var FIsFirstLoad:Boolean;
      
      protected var FDoneIndex:int;
      
      protected var FOnBoxOver:Function;
      
      protected var FOnBoxOut:Function;
      
      protected var FOnItemOver:Function;
      
      protected var FOnItemOut:Function;
      
      protected var FOnItemClick:Function;
      
      protected var FOnGetBox:Function;
      
      protected var FOnBuyBox:Function;
      
      protected var FOnCollectUp:Function;
      
      protected var FOnShowTip:Function;
      
      protected var FOnHideTip:Function;
      
      protected var FOnShowHeroTip:Function;
      
      protected var FOnHideHeroTip:Function;
      
      protected var FOnShowRecruit:Function;
      
      protected var FOnLoadRank:Function;
      
      protected var FOnShowDesc:Function;
      
      protected var FOnShowThreeStr:Function;
      
      protected var FOnHideThreeStr:Function;
      
      protected var FOnLoadLog:Function;
      
      protected var FGotoRecharge:Function;
      
      protected var FOnSpecialOver:Function;
      
      protected var FOnSpecialOut:Function;
      
      protected var FOnShowFlowText:Function;
      
      protected var FOnShowTitleTip:Function;
      
      protected var FOnHideTitleTip:Function;
      
      protected var FOnShowPetTip:Function;
      
      protected var FOnHidePetTip:Function;
      
      protected var FOnShowHtmlTip:Function;
      
      protected var FOnHideHtmlTip:Function;
      
      protected var FOnShowActiveDesc:Function;
      
      protected var FOnIntervalFun:Function;
      
      protected var FOnGetWelfare:Function;
      
      protected var FOnRecharge:Function;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FOnShowExerciseTip:Function;
      
      protected var FOnHideExerciseTip:Function;
      
      protected var FOnShowWindow:Function;
      
      protected var FOnNewBoxOver:Function;
      
      protected var FOnNewBoxOut:Function;
      
      protected var FOnCloseWindow:Function;
      
      protected var FOnActiveUp:Function;
      
      protected var FOnGoto:Function;
      
      protected var FOnUpdateWindow:Function;
      
      public var OnHelpOver:Function;
      
      public var OnHelpOut:Function;
      
      public var CheckEffect:Function;
      
      public function TUIBaseWindow(param1:TUIComponent)
      {
         super(param1);
         this.FHint = new THint();
         this.FActTaskData = SLogicsCore.ActivityTaskData;
         this.FIsFirstLoad = true;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         this.FMC_Scene = param1;
         _loc3_ = 0;
         while(_loc3_ < ACT_TASK_COUNT)
         {
            if(Boolean(this.FMC_Scene) && Boolean(this.FMC_Scene["MC_Task" + _loc3_]))
            {
               _loc2_ = this.FMC_Scene["MC_Task" + _loc3_];
               _loc2_.MC_Reward.gotoAndStop(_loc3_ + 1);
               TGameUtil.setButtonMode(_loc2_.BTN_Go,true);
               _loc2_.BTN_Go.addEventListener(MouseEvent.CLICK,this.ProcessorOnGoTaskUp);
               TGameUtil.setButtonMode(_loc2_.BTN_GetTask,true);
               _loc2_.BTN_GetTask.addEventListener(MouseEvent.CLICK,this.ProcessorOnAcceptTaskUp);
               TGameUtil.setButtonMode(_loc2_.BTN_Finish,true);
               _loc2_.BTN_Finish.addEventListener(MouseEvent.CLICK,this.ProcessorOnFinishTaskUp);
               _loc2_.MC_Reward.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGetTaskRewardOver);
               _loc2_.MC_Reward.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnNewBoxOut);
            }
            _loc3_++;
         }
         if(Boolean(this.FMC_Scene) && Boolean(this.FMC_Scene.BTN_TitleDesc))
         {
            TGameUtil.setButtonMode(this.FMC_Scene.BTN_TitleDesc,true);
            this.FMC_Scene.BTN_TitleDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowTitleDesc);
         }
         if(Boolean(this.FMC_Scene) && Boolean(this.FMC_Scene.BTN_EquipDesc))
         {
            TGameUtil.setButtonMode(this.FMC_Scene.BTN_EquipDesc,true);
            this.FMC_Scene.BTN_EquipDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowEquipDesc);
         }
      }
      
      protected function UpdateTaskView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TDessertHouseTask = null;
         _loc1_ = 0;
         while(_loc1_ < ACT_TASK_COUNT)
         {
            _loc4_ = this.FMC_Scene["MC_Task" + _loc1_];
            if(_loc1_ < this.FActTaskData.TaskList.length)
            {
               _loc4_.visible = true;
               _loc5_ = this.FActTaskData.TaskList[_loc1_];
               _loc3_ = _loc5_.Step >= ACT_TASK_STEP ? int(ACT_TASK_STEP - 1) : _loc5_.Step;
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
      
      protected function ProcessorOnGoTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(this.FOnGoto != null && _loc2_ < this.FActTaskData.TaskList.length)
         {
            this.FOnCloseWindow();
            _loc3_ = this.FActTaskData.TaskList[_loc2_];
            this.FOnGoto(_loc3_.Go);
         }
      }
      
      protected function ProcessorOnAcceptTaskUp(param1:MouseEvent) : void
      {
      }
      
      protected function ProcessorOnFinishTaskUp(param1:MouseEvent) : void
      {
      }
      
      protected function ProcessorOnCollectUp(param1:MouseEvent) : void
      {
      }
      
      protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
      }
      
      protected function ProcessorOnShowHtmlTip(param1:String) : void
      {
         if(this.FOnShowHtmlTip != null)
         {
            this.FOnShowHtmlTip(param1);
         }
      }
      
      protected function ProcessorOnHideHtmlTip(param1:MouseEvent = null) : void
      {
         if(this.FOnHideHtmlTip != null)
         {
            this.FOnHideHtmlTip();
         }
      }
      
      protected function ProcessorOnGetTaskRewardOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TDessertHouseTask = null;
         var _loc5_:TInventories = null;
         var _loc6_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(this.FOnNewBoxOver != null && _loc2_ < this.FActTaskData.TaskList.length)
         {
            _loc4_ = this.FActTaskData.TaskList[_loc2_];
            _loc6_ = Math.min(_loc4_.Step,ACT_TASK_STEP - 1);
            _loc5_ = _loc4_.TaskAward[_loc6_];
            this.FOnNewBoxOver(_loc5_);
         }
      }
      
      protected function ProcessorOnShowTitleDesc(param1:MouseEvent) : void
      {
         if(this.FOnShowWindow != null)
         {
            this.FOnShowWindow(TProcessorBaseActivity.WINDOW_TITLE_DESC);
         }
      }
      
      protected function ProcessorOnShowEquipDesc(param1:MouseEvent) : void
      {
         if(this.FOnShowWindow != null)
         {
            this.FOnShowWindow(TProcessorBaseActivity.WINDOW_EQUIPMENT_DESC);
         }
      }
      
      public function get OnBoxOver() : Function
      {
         return this.FOnBoxOver;
      }
      
      public function set OnBoxOver(param1:Function) : void
      {
         this.FOnBoxOver = param1;
      }
      
      public function get OnBoxOut() : Function
      {
         return this.FOnBoxOut;
      }
      
      public function set OnBoxOut(param1:Function) : void
      {
         this.FOnBoxOut = param1;
      }
      
      public function get OnGetBox() : Function
      {
         return this.FOnGetBox;
      }
      
      public function set OnGetBox(param1:Function) : void
      {
         this.FOnGetBox = param1;
      }
      
      public function get OnCollectUp() : Function
      {
         return this.FOnCollectUp;
      }
      
      public function set OnCollectUp(param1:Function) : void
      {
         this.FOnCollectUp = param1;
      }
      
      public function get OnItemOver() : Function
      {
         return this.FOnItemOver;
      }
      
      public function set OnItemOver(param1:Function) : void
      {
         this.FOnItemOver = param1;
      }
      
      public function get OnItemOut() : Function
      {
         return this.FOnItemOut;
      }
      
      public function set OnItemOut(param1:Function) : void
      {
         this.FOnItemOut = param1;
      }
      
      public function get OnShowTip() : Function
      {
         return this.FOnShowTip;
      }
      
      public function set OnShowTip(param1:Function) : void
      {
         this.FOnShowTip = param1;
      }
      
      public function get OnHideTip() : Function
      {
         return this.FOnHideTip;
      }
      
      public function set OnHideTip(param1:Function) : void
      {
         this.FOnHideTip = param1;
      }
      
      public function get OnBuyBox() : Function
      {
         return this.FOnBuyBox;
      }
      
      public function set OnBuyBox(param1:Function) : void
      {
         this.FOnBuyBox = param1;
      }
      
      public function get OnLoadRank() : Function
      {
         return this.FOnLoadRank;
      }
      
      public function set OnLoadRank(param1:Function) : void
      {
         this.FOnLoadRank = param1;
      }
      
      public function get OnShowHeroTip() : Function
      {
         return this.FOnShowHeroTip;
      }
      
      public function set OnShowHeroTip(param1:Function) : void
      {
         this.FOnShowHeroTip = param1;
      }
      
      public function get OnHideHeroTip() : Function
      {
         return this.FOnHideHeroTip;
      }
      
      public function set OnHideHeroTip(param1:Function) : void
      {
         this.FOnHideHeroTip = param1;
      }
      
      public function get OnShowRecruit() : Function
      {
         return this.FOnShowRecruit;
      }
      
      public function set OnShowRecruit(param1:Function) : void
      {
         this.FOnShowRecruit = param1;
      }
      
      public function get OnShowDesc() : Function
      {
         return this.FOnShowDesc;
      }
      
      public function set OnShowDesc(param1:Function) : void
      {
         this.FOnShowDesc = param1;
      }
      
      public function get OnShowThreeStr() : Function
      {
         return this.FOnShowThreeStr;
      }
      
      public function set OnShowThreeStr(param1:Function) : void
      {
         this.FOnShowThreeStr = param1;
      }
      
      public function get OnHideThreeStr() : Function
      {
         return this.FOnHideThreeStr;
      }
      
      public function set OnHideThreeStr(param1:Function) : void
      {
         this.FOnHideThreeStr = param1;
      }
      
      public function get OnLoadLog() : Function
      {
         return this.FOnLoadLog;
      }
      
      public function set OnLoadLog(param1:Function) : void
      {
         this.FOnLoadLog = param1;
      }
      
      public function get GotoRecharge() : Function
      {
         return this.FGotoRecharge;
      }
      
      public function set GotoRecharge(param1:Function) : void
      {
         this.FGotoRecharge = param1;
      }
      
      public function get OnSpecialOver() : Function
      {
         return this.FOnSpecialOver;
      }
      
      public function set OnSpecialOver(param1:Function) : void
      {
         this.FOnSpecialOver = param1;
      }
      
      public function get OnSpecialOut() : Function
      {
         return this.FOnSpecialOut;
      }
      
      public function set OnSpecialOut(param1:Function) : void
      {
         this.FOnSpecialOut = param1;
      }
      
      public function get OnShowFlowText() : Function
      {
         return this.FOnShowFlowText;
      }
      
      public function set OnShowFlowText(param1:Function) : void
      {
         this.FOnShowFlowText = param1;
      }
      
      public function get IsMovieVisible() : Boolean
      {
         return this.FIsMovieVisible;
      }
      
      public function set IsMovieVisible(param1:Boolean) : void
      {
         this.FIsMovieVisible = param1;
      }
      
      public function get OnShowPetTip() : Function
      {
         return this.FOnShowPetTip;
      }
      
      public function set OnShowPetTip(param1:Function) : void
      {
         this.FOnShowPetTip = param1;
      }
      
      public function get OnHidePetTip() : Function
      {
         return this.FOnHidePetTip;
      }
      
      public function set OnHidePetTip(param1:Function) : void
      {
         this.FOnHidePetTip = param1;
      }
      
      public function get OnShowTitleTip() : Function
      {
         return this.FOnShowTitleTip;
      }
      
      public function set OnShowTitleTip(param1:Function) : void
      {
         this.FOnShowTitleTip = param1;
      }
      
      public function get OnHideTitleTip() : Function
      {
         return this.FOnHideTitleTip;
      }
      
      public function set OnHideTitleTip(param1:Function) : void
      {
         this.FOnHideTitleTip = param1;
      }
      
      public function get IsPlaying() : Boolean
      {
         return this.FIsPlaying;
      }
      
      public function set IsPlaying(param1:Boolean) : void
      {
         this.FIsPlaying = param1;
      }
      
      public function get OnShowHtmlTip() : Function
      {
         return this.FOnShowHtmlTip;
      }
      
      public function set OnShowHtmlTip(param1:Function) : void
      {
         this.FOnShowHtmlTip = param1;
      }
      
      public function get OnHideHtmlTip() : Function
      {
         return this.FOnHideHtmlTip;
      }
      
      public function set OnHideHtmlTip(param1:Function) : void
      {
         this.FOnHideHtmlTip = param1;
      }
      
      public function get OnIntervalFun() : Function
      {
         return this.FOnIntervalFun;
      }
      
      public function set OnIntervalFun(param1:Function) : void
      {
         this.FOnIntervalFun = param1;
      }
      
      public function get OnInventoryOut() : Function
      {
         return this.FOnInventoryOut;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
      }
      
      public function get OnInventoryOver() : Function
      {
         return this.FOnInventoryOver;
      }
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function get OnRecharge() : Function
      {
         return this.FOnRecharge;
      }
      
      public function set OnRecharge(param1:Function) : void
      {
         this.FOnRecharge = param1;
      }
      
      public function get OnGetWelfare() : Function
      {
         return this.FOnGetWelfare;
      }
      
      public function set OnGetWelfare(param1:Function) : void
      {
         this.FOnGetWelfare = param1;
      }
      
      public function get OnShowExerciseTip() : Function
      {
         return this.FOnShowExerciseTip;
      }
      
      public function set OnShowExerciseTip(param1:Function) : void
      {
         this.FOnShowExerciseTip = param1;
      }
      
      public function get OnHideExerciseTip() : Function
      {
         return this.FOnHideExerciseTip;
      }
      
      public function set OnHideExerciseTip(param1:Function) : void
      {
         this.FOnHideExerciseTip = param1;
      }
      
      public function get OnShowWindow() : Function
      {
         return this.FOnShowWindow;
      }
      
      public function set OnShowWindow(param1:Function) : void
      {
         this.FOnShowWindow = param1;
      }
      
      public function get OnNewBoxOver() : Function
      {
         return this.FOnNewBoxOver;
      }
      
      public function set OnNewBoxOver(param1:Function) : void
      {
         this.FOnNewBoxOver = param1;
      }
      
      public function get OnNewBoxOut() : Function
      {
         return this.FOnNewBoxOut;
      }
      
      public function set OnNewBoxOut(param1:Function) : void
      {
         this.FOnNewBoxOut = param1;
      }
      
      public function get OnCloseWindow() : Function
      {
         return this.FOnCloseWindow;
      }
      
      public function set OnCloseWindow(param1:Function) : void
      {
         this.FOnCloseWindow = param1;
      }
      
      public function get OnActiveUp() : Function
      {
         return this.FOnActiveUp;
      }
      
      public function set OnActiveUp(param1:Function) : void
      {
         this.FOnActiveUp = param1;
      }
      
      public function get OnGoto() : Function
      {
         return this.FOnGoto;
      }
      
      public function set OnGoto(param1:Function) : void
      {
         this.FOnGoto = param1;
      }
      
      public function get OnUpdateWindow() : Function
      {
         return this.FOnUpdateWindow;
      }
      
      public function set OnUpdateWindow(param1:Function) : void
      {
         this.FOnUpdateWindow = param1;
      }
      
      public function get FlowStr() : String
      {
         return this.FFlowStr;
      }
      
      public function set FlowStr(param1:String) : void
      {
         this.FFlowStr = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function LogicsPerform() : void
      {
      }
      
      public function UpdateUI() : void
      {
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         this.visible = param1;
         if(this.FMC_Scene)
         {
            this.FMC_Scene.visible = param1;
         }
      }
      
      public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
      }
      
      public function MovieEnd() : void
      {
      }
      
      public function UpdateSlot() : void
      {
      }
      
      public function ProcessorOnGotoRecharge(param1:MouseEvent) : void
      {
         if(this.FGotoRecharge != null)
         {
            this.FGotoRecharge(param1);
         }
      }
      
      public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
      }
      
      public function Unmount() : void
      {
      }
      
      public function ProcessorOnNewBoxOut(param1:MouseEvent = null) : void
      {
         if(this.FOnNewBoxOut != null)
         {
            this.FOnNewBoxOut();
         }
      }
      
      public function SetMovieParams(param1:Vector.<int>) : void
      {
      }
      
      public function ProcessorOnUpdateWindow() : void
      {
         if(this.FOnUpdateWindow != null)
         {
            this.FOnUpdateWindow();
         }
      }
      
      public function ProcessorOnHideTitleTip(param1:MouseEvent = null) : void
      {
         if(this.FOnHideTitleTip != null)
         {
            this.FOnHideTitleTip();
         }
      }
   }
}

