package Processors.Game.Lobby.Exercise.NewSpringFestival.items
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.DatebaseVO.VO.TActivityTask;
   import Processors.Game.Lobby.Exercise.NewSpringFestival.TProcessorNewSpringFestival;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TNewSpringTaskInfoItem extends TUIComponent
   {
      
      private var mc_effect:MovieClip;
      
      private var mc_complete:MovieClip;
      
      private var mc_skin:MovieClip;
      
      private var t_task_1:TextField;
      
      private var _taskIndex:int = -1;
      
      private var _main:TProcessorNewSpringFestival;
      
      private var status:int;
      
      private var _bProgressEnough:Boolean = false;
      
      public function TNewSpringTaskInfoItem(param1:TUIComponent, param2:TProcessorNewSpringFestival)
      {
         super(param1);
         this._main = param2;
      }
      
      public function initUI(param1:MovieClip, param2:int) : void
      {
         this.mc_skin = param1;
         this._taskIndex = param2;
         this.mc_effect = this.mc_skin["mc_effect"] as MovieClip;
         this.mc_complete = this.mc_skin["mc_complete"] as MovieClip;
         this.t_task_1 = this.mc_skin["t_task_1"] as TextField;
         this.mc_effect.visible = this.mc_complete.visible = false;
         this.mc_effect.buttonMode = true;
         this.mc_effect.addEventListener(MouseEvent.CLICK,this.onCompleteTaskHandler);
      }
      
      private function onCompleteTaskHandler(param1:MouseEvent) : void
      {
         if(this.status == -1 || !this._bProgressEnough)
         {
            return;
         }
         var _loc2_:Vector.<int> = new Vector.<int>();
         var _loc3_:int = int(this._main.newSpring2018Data.taskInfo[this._taskIndex].taskId);
         _loc2_.push(_loc3_);
         this._main.Packet_CS_AllReq(TProcessorNewSpringFestival.COMPLETE_TASK,_loc2_);
      }
      
      public function updateUI() : void
      {
         this._bProgressEnough = false;
         var _loc1_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ActivityTaskConfig);
         var _loc2_:TActivityTask = _loc1_.GetDatebaseByValue2("Identifier",this._main.newSpring2018Data.taskInfo[this._taskIndex].taskId,"Tasktype",this._main.ActivityID) as TActivityTask;
         this.status = this._main.newSpring2018Data.taskInfo[this._taskIndex].status;
         this.t_task_1.text = this._main.newSpring2018Data.taskInfo[this._taskIndex].progress.toString() + "/" + _loc2_.ClientReq[0];
         if(this._main.newSpring2018Data.taskInfo[this._taskIndex].progress >= _loc2_.ClientReq[0])
         {
            this._bProgressEnough = true;
         }
         if(this.status == -1)
         {
            this.mc_complete.visible = true;
            this.mc_effect.visible = false;
            this.mc_effect.stop();
         }
         else
         {
            this.mc_complete.visible = false;
            if(this._bProgressEnough)
            {
               this.mc_effect.visible = true;
               this.mc_effect.play();
            }
         }
      }
   }
}

