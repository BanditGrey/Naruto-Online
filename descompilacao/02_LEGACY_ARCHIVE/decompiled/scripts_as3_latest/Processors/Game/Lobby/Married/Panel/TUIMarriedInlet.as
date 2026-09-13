package Processors.Game.Lobby.Married.Panel
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Married.TProcessorMarried;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIMarriedInlet extends TUIBaseWindow
   {
      
      public function TUIMarriedInlet(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         FMC_Scene = param1;
         FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OVER,Parent["ButtonHelpOnOver"]);
         FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OUT,Parent["ButtonHelpOnOut"]);
         FMC_Scene["BTN_Close"].addEventListener(MouseEvent.CLICK,Parent["OnWindowClose"]);
         this.SetVisible(false);
      }
      
      override public function UpdateUI() : void
      {
         if(FMC_Scene.currentFrame == 1)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Married,true);
            FMC_Scene.BTN_Married.addEventListener(MouseEvent.CLICK,this.onMarriedClick);
         }
         else if(FMC_Scene.currentFrame == 2)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Divorce,true);
            FMC_Scene.BTN_Divorce.addEventListener(MouseEvent.CLICK,this.onDivorceClick);
         }
      }
      
      private function onMarriedClick(param1:MouseEvent) : void
      {
         Parent["Status"] = TProcessorMarried.APPLY;
      }
      
      private function onDivorceClick(param1:MouseEvent) : void
      {
         Parent["Status"] = TProcessorMarried.DIVORCE;
      }
      
      public function set Status(param1:int) : void
      {
         this.SetVisible(param1 != TProcessorMarried.DIVORCE);
         if(this.visible == false)
         {
            return;
         }
         if(param1 == TProcessorMarried.PRE_APPLY)
         {
            FMC_Scene.gotoAndStop(1);
         }
         else if(param1 == TProcessorMarried.PRE_DIVORCE)
         {
            FMC_Scene.gotoAndStop(2);
         }
         else
         {
            FMC_Scene.gotoAndStop(3);
         }
         this.UpdateUI();
      }
   }
}

