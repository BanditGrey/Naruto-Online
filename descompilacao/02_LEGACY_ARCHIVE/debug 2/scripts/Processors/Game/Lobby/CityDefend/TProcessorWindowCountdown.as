package Processors.Game.Lobby.CityDefend
{
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Processors.Game.*;
   import Resources.Constants.*;
   import flash.display.*;
   
   public class TProcessorWindowCountdown extends TProcessorGame
   {
      
      protected var Bg_Sp:Shape;
      
      protected var FScene:MovieClip;
      
      protected var FCountdown:uint;
      
      protected var FIsStart:Boolean;
      
      protected var FOnTimeOver:Function;
      
      protected var FDeathCountdown:Function;
      
      public function TProcessorWindowCountdown(param1:TUIComponent)
      {
         super(param1);
         this.FIsStart = false;
         this.Bg_Sp = new Shape();
         this.Bg_Sp.graphics.beginFill(0,0.3);
         this.Bg_Sp.graphics.drawRect(0,0,CONST_COMMON.STAGE_Max_Width,CONST_COMMON.STAGE_Max_Height);
         this.Bg_Sp.graphics.endFill();
         addChild(this.Bg_Sp);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(Visible)
         {
            this.LogicsPerform_Countdown();
         }
      }
      
      protected function LogicsPerform_Countdown() : void
      {
         var _loc1_:int = 0;
         if(this.FScene == null)
         {
            return;
         }
         _loc1_ = this.FCountdown - STimingCore.GetServerTick();
         this.FScene.mc_time0.gotoAndStop(_loc1_ % 10 + 1);
         this.FScene.mc_time1.gotoAndStop(int(_loc1_ / 10) + 1);
         if(_loc1_ <= 0)
         {
            this.FIsStart = false;
            Visible = false;
            if(this.FOnTimeOver != null)
            {
               this.FOnTimeOver(this);
            }
         }
      }
      
      public function set OnTimeOver(param1:Function) : void
      {
         this.FOnTimeOver = param1;
      }
      
      public function get OnTimeOver() : Function
      {
         return this.FOnTimeOver;
      }
      
      public function SetScene(param1:MovieClip) : void
      {
         this.FScene = param1;
         addChild(this.FScene);
         this.FScene.mc_time0.stop();
         this.FScene.mc_time1.stop();
      }
      
      public function StartCountdown(param1:uint) : void
      {
         if(param1 - STimingCore.GetServerTick() <= 0)
         {
            return;
         }
         this.FCountdown = param1;
         if(this.FCountdown - STimingCore.GetServerTick() > 60)
         {
            this.FCountdown = STimingCore.GetServerTick() + 60;
         }
         this.FIsStart = true;
         Visible = true;
      }
      
      public function Stop() : void
      {
         this.FCountdown = 0;
         this.FIsStart = false;
         Visible = false;
      }
      
      public function getBoo() : Boolean
      {
         return this.FIsStart;
      }
      
      public function GetLastTime() : int
      {
         return this.FCountdown - STimingCore.GetServerTick();
      }
      
      public function set DeathCountdown(param1:Function) : void
      {
         this.FDeathCountdown = param1;
      }
   }
}

