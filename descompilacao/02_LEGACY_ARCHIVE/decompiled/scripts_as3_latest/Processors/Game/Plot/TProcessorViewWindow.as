package Processors.Game.Plot
{
   import Externals.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Processors.Game.Lobby.Common.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   import ghostcat.util.easing.*;
   
   public class TProcessorViewWindow extends TProcessorLobbyWindow
   {
      
      public static const RESOURCESID_Swf_StartMovie:int = CONST_PLOT.RESOURCESID_Swf_StartMovie;
      
      protected var FMovie:MovieClip;
      
      protected var FOnEndView:Function;
      
      public function TProcessorViewWindow(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function OnStartMovie() : void
      {
         var CallBackFun:Function = null;
         CallBackFun = function():void
         {
            FMovie.gotoAndPlay(1);
         };
         TweenUtil.to(this,500,{
            "alpha":1,
            "onComplete":CallBackFun
         });
      }
      
      protected function OnEndMovie(param1:Event) : void
      {
         if(this.FMovie)
         {
            if(this.FMovie.parent)
            {
               this.FMovie.parent.removeChild(this.FMovie);
            }
            if(this.FMovie.hasEventListener(CONST_PLOT.EVENT_EndMovie))
            {
               this.FMovie.removeEventListener(CONST_PLOT.EVENT_EndMovie,this.OnEndMovie);
            }
            if(Boolean(this.FMovie.btn_skip) && Boolean(this.FMovie.btn_skip.hasEventListener(CONST_PLOT.EVENT_EndMovie)))
            {
               this.FMovie.btn_skip.removeEventListener(MouseEvent.CLICK,this.OnSkipView);
            }
         }
         if(this.FOnEndView != null)
         {
            this.FOnEndView(this);
         }
      }
      
      protected function OnSkipView(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         _loc3_ = this.FMovie.currentLabel;
         _loc4_ = int(_loc3_.slice(6)) + 1;
         _loc3_ = "story_" + _loc4_;
         _loc2_ = 0;
         while(_loc2_ < this.FMovie.currentLabels.length)
         {
            if(this.FMovie.currentLabels[_loc2_].name == _loc3_)
            {
               this.FMovie.gotoAndPlay(this.FMovie.currentLabels[_loc2_].frame);
               break;
            }
            _loc2_++;
         }
      }
      
      public function get OnEndView() : Function
      {
         return this.FOnEndView;
      }
      
      public function set OnEndView(param1:Function) : void
      {
         this.FOnEndView = param1;
      }
      
      public function SetViewPlot(param1:uint) : void
      {
         this.FMovie = TUtilityReflection.CreateDisplayObjectInstance("plot_movie_" + param1) as MovieClip;
         addChild(this.FMovie);
         alpha = 0;
         this.FMovie.gotoAndStop(1);
         this.FMovie.addEventListener(CONST_PLOT.EVENT_EndMovie,this.OnEndMovie);
         if(this.FMovie.btn_skip)
         {
            this.FMovie.btn_skip.addEventListener(MouseEvent.CLICK,this.OnSkipView);
         }
         this.OnStartMovie();
      }
   }
}

