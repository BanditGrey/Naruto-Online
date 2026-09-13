package Processors.Game.Lobby.Exercise.DessertHouse.Compoents
{
   import Components.Slots.TUISlot;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIDessertHouseTask extends TUIComponent
   {
      
      protected var BOX_COUNT:int = 3;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FIndex:int;
      
      protected var FTask:TDessertHouseTask;
      
      protected var FOnReset:Function;
      
      protected var FOnSelect:Function;
      
      public function TUIDessertHouseTask(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function Initialization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_DessertHouseTask") as MovieClip;
         addChild(this.FMC_Scene);
         this.FMC_Scene.MC_Select.visible = false;
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Reset,true);
         this.FMC_Scene.BTN_Reset.addEventListener(MouseEvent.CLICK,this.ProcessorOnResetUp);
         this.FMC_Scene.buttonMode = true;
         this.FMC_Scene.addEventListener(MouseEvent.CLICK,this.ProcessorOnTaskUp);
         this.UpdateTask();
      }
      
      protected function ProcessorOnResetUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FOnReset != null)
         {
            this.FOnReset(this.FTask.Identify);
         }
      }
      
      protected function ProcessorOnTaskUp(param1:MouseEvent) : void
      {
         if(this.FOnSelect != null)
         {
            this.FOnSelect(this.FIndex);
         }
      }
      
      public function get OnReset() : Function
      {
         return this.FOnReset;
      }
      
      public function set OnReset(param1:Function) : void
      {
         this.FOnReset = param1;
      }
      
      public function get OnSelect() : Function
      {
         return this.FOnSelect;
      }
      
      public function set OnSelect(param1:Function) : void
      {
         this.FOnSelect = param1;
      }
      
      public function Init(param1:int, param2:TDessertHouseTask) : void
      {
         this.FIndex = param1;
         this.FTask = param2;
         this.Initialization();
      }
      
      public function UpdateTask() : void
      {
         this.FMC_Scene.TF_Title.text = this.FTask.TaskName;
         this.FMC_Scene.MC_Difficulty.gotoAndStop(this.FTask.Step + 1);
         this.FMC_Scene.TF_Reset.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_RESET_COUNT,this.FTask.Reset,this.FTask.MaxReset);
         if(this.FTask.Reset > 0 && this.FTask.Step == 3)
         {
            this.FMC_Scene.BTN_Reset.visible = true;
         }
         else
         {
            this.FMC_Scene.BTN_Reset.visible = false;
         }
      }
      
      public function SetSelected(param1:Boolean) : void
      {
         this.FMC_Scene.MC_Select.visible = param1;
      }
   }
}

