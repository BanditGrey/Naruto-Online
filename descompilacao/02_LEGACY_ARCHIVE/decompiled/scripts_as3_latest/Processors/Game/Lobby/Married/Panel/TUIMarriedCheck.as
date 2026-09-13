package Processors.Game.Lobby.Married.Panel
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class TUIMarriedCheck extends TUIBaseWindow
   {
      
      protected var FMask:Shape = null;
      
      protected var FCallback:Function = null;
      
      public function TUIMarriedCheck(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         FMC_Scene = param1;
         var _loc2_:Point = FMC_Scene.localToGlobal(new Point(0,0));
         this.FMask = new Shape();
         this.FMask.graphics.beginFill(0,0.5);
         this.FMask.graphics.drawRect(-_loc2_.x,-_loc2_.y,2000,1000);
         this.FMask.graphics.endFill();
         FMC_Scene.addChildAt(this.FMask,0);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Confirm,true);
         FMC_Scene.BTN_Confirm.addEventListener(MouseEvent.CLICK,this.onConfirmClick);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Cancel,true);
         FMC_Scene.BTN_Cancel.addEventListener(MouseEvent.CLICK,this.onCancelClick);
         this.SetVisible(false);
      }
      
      override public function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      public function Show(param1:String, param2:Function, param3:Point = null) : void
      {
         FMC_Scene.TF_Desc.text = param1;
         this.FCallback = param2;
         if(param3)
         {
            FMC_Scene.x = param3.x;
            FMC_Scene.y = param3.y;
         }
         this.SetVisible(true);
      }
      
      private function onConfirmClick(param1:MouseEvent) : void
      {
         if(this.FCallback != null)
         {
            this.FCallback();
         }
         this.SetVisible(false);
      }
      
      private function onCancelClick(param1:MouseEvent) : void
      {
         this.SetVisible(false);
      }
   }
}

