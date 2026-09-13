package Processors.Game.Lobby.Globalboss
{
   import Foundation.Timing.STimingCore;
   import Logics.Globalboss.TGlobalboss;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   
   public class TUIGlobalBossStage
   {
      
      protected static const DOUBLE_CLICK_INTERVAL:int = 300;
      
      protected var FGlobalboss:TGlobalboss;
      
      protected var FResource:MovieClip;
      
      protected var FStage:MovieClip;
      
      protected var FTF_Chapter:TextField;
      
      protected var MC_Star:MovieClip;
      
      protected var FGlowFilter:GlowFilter;
      
      protected var FCurClickTick:int;
      
      protected var FPreClickTick:int;
      
      public var onStageSelectFunc:Function;
      
      public var onStartFight:Function;
      
      public function TUIGlobalBossStage()
      {
         super();
         this.FGlowFilter = new GlowFilter();
      }
      
      public function DispatchRes(param1:MovieClip, param2:TGlobalboss) : void
      {
         var _loc3_:String = null;
         _loc3_ = param2.Dafuben.Iconzy;
         this.FResource = param1[["MC_stage_" + int(_loc3_)]];
         this.FStage = this.FResource["icon"];
         this.FStage.gotoAndStop(int(_loc3_));
         this.FResource.addEventListener(MouseEvent.CLICK,this.onMouseDownStage);
      }
      
      public function SetStage(param1:TGlobalboss) : void
      {
         var _loc3_:int = 0;
         this.FGlobalboss = param1;
         this.FGlobalboss.GlobalbossStage = this;
         this.FTF_Chapter = this.FResource["TF_Chapter"];
         this.FTF_Chapter.text = this.FGlobalboss.Dafuben.Name;
         this.FResource.visible = this.FGlobalboss.Status == 0 ? false : true;
         var _loc2_:int = this.FGlobalboss.starNum;
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            this.MC_Star = this.FResource["star_" + _loc3_];
            if(_loc3_ < _loc2_)
            {
               this.MC_Star.gotoAndStop(1);
            }
            else
            {
               this.MC_Star.gotoAndStop(2);
            }
            _loc3_++;
         }
      }
      
      public function AddGlowFilter(param1:Boolean) : void
      {
         this.FStage.filters = param1 ? [this.FGlowFilter] : null;
      }
      
      protected function onMouseDownStage(param1:MouseEvent) : void
      {
         if(this.onStageSelectFunc != null)
         {
            this.onStageSelectFunc(this.FGlobalboss);
         }
         this.FCurClickTick = STimingCore.TickCount;
         if(this.FCurClickTick - this.FPreClickTick > DOUBLE_CLICK_INTERVAL)
         {
            this.FPreClickTick = this.FCurClickTick;
            return;
         }
         this.FPreClickTick = 0;
         if(this.onStartFight != null)
         {
            this.onStartFight(null);
         }
      }
   }
}

