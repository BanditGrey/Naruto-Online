package Processors.Game.Lobby.Pet.Component
{
   import Foundation.Utilities.TUtilityReflection;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TBarVeryGood extends Sprite
   {
      
      protected var FThisPanel:MovieClip;
      
      protected var FCurIndex:int;
      
      protected var FTotalIndex:int;
      
      protected var FCurNum:int;
      
      protected var Ftf_into:TextField;
      
      protected var FBackFunc:Function;
      
      public function TBarVeryGood(param1:uint, param2:int)
      {
         super();
         this.FCurNum = param1;
         this.FCurIndex = param2;
         this.LoadFla();
         this.Update();
      }
      
      protected function LoadFla() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_UpLevelListitem") as MovieClip;
         this.addChild(this.FThisPanel);
         this.Ftf_into = this.FThisPanel["tf_into"];
         this.addEventListener(MouseEvent.MOUSE_OVER,this.OvertEvent);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.OutEvent);
         this.addEventListener(MouseEvent.CLICK,this.ClickEvent);
         this.buttonMode = true;
      }
      
      public function set TotalIndex(param1:int) : void
      {
         this.FTotalIndex = param1;
      }
      
      public function Update() : void
      {
         this.Ftf_into.text = this.FCurNum.toString();
         if(this.FCurIndex == this.FTotalIndex)
         {
            this.FThisPanel.gotoAndStop(2);
         }
         else
         {
            this.FThisPanel.gotoAndStop(1);
         }
      }
      
      public function set BackFunc(param1:Function) : void
      {
         this.FBackFunc = param1;
      }
      
      protected function OvertEvent(param1:MouseEvent) : void
      {
         if(this.FCurIndex == this.FTotalIndex)
         {
            return;
         }
         this.FThisPanel.gotoAndStop(2);
      }
      
      protected function OutEvent(param1:MouseEvent) : void
      {
         if(this.FCurIndex == this.FTotalIndex)
         {
            return;
         }
         this.FThisPanel.gotoAndStop(1);
      }
      
      protected function ClickEvent(param1:MouseEvent) : void
      {
         if(this.FBackFunc != null)
         {
            this.FBackFunc(this.FCurIndex);
         }
      }
   }
}

