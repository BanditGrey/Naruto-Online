package Processors.Game.Lobby.RebirthRealm
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_REBIRTHREALM;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TongYongQuanPinDaoJiShi extends TProcessorLobbyWindow
   {
      
      protected var FThisPanel:Sprite;
      
      protected var FDaoJiTime:uint;
      
      protected var FCurTimer:Timer;
      
      protected var SHI:uint;
      
      protected var GE:uint;
      
      protected var FMC_Number_0:MovieClip;
      
      protected var FMC_Number_1:MovieClip;
      
      protected var FBackFun:Function;
      
      public function TongYongQuanPinDaoJiShi(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.2);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_REBIRTHREALM.RebirthRealm_Resource);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("RebirthRealm_AutoTime") as Sprite;
         addChild(this.FThisPanel);
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         this.FCurTimer = new Timer(1000);
         this.FCurTimer.addEventListener(TimerEvent.TIMER,this.TimerHandle);
         this.FMC_Number_0 = this.FThisPanel["MC_Number_0"];
         this.FMC_Number_1 = this.FThisPanel["MC_Number_1"];
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function TimerHandle(param1:TimerEvent) : void
      {
         --this.FDaoJiTime;
         if(this.FDaoJiTime == 0)
         {
            this.FCurTimer.stop();
            this.FCurTimer.reset();
            if(this.FBackFun != null)
            {
               this.FBackFun();
            }
            this.visible = false;
         }
         this.UpdateNum();
      }
      
      protected function UpdateNum() : void
      {
         this.GE = this.FDaoJiTime % 10;
         this.SHI = this.FDaoJiTime / 10;
         this.FMC_Number_0.gotoAndStop(this.SHI + 1);
         this.FMC_Number_1.gotoAndStop(this.GE + 1);
      }
      
      public function SetBegin() : void
      {
         this.UpdateNum();
         this.visible = true;
         this.FCurTimer.start();
      }
      
      public function set DaoJiTime(param1:uint) : void
      {
         this.FDaoJiTime = param1;
      }
      
      public function get DaoJiTime() : uint
      {
         return this.FDaoJiTime;
      }
      
      public function set BackFun(param1:Function) : void
      {
         this.FBackFun = param1;
      }
      
      public function get BackFun() : Function
      {
         return this.FBackFun;
      }
   }
}

