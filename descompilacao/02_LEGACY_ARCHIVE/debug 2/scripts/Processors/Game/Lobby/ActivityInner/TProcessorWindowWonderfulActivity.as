package Processors.Game.Lobby.ActivityInner
{
   import Foundation.Common.THint;
   import Foundation.Network.TPacket;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.ActivityMode.TActivityAtoms;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   
   public class TProcessorWindowWonderfulActivity extends TProcessorLobbyWindow
   {
      
      protected static const SecondOneDay:int = 24 * 60 * 60;
      
      protected var FMainScene:MovieClip;
      
      protected var FOnOver:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnHitOver:Function;
      
      protected var FOnHitOut:Function;
      
      protected var FOnReceiveAwards:Function;
      
      protected var FOnOpenWindow:Function;
      
      protected var FEffectGenerateTextByErrorCodeFunction:Function;
      
      public function TProcessorWindowWonderfulActivity(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function ReceiveAward(param1:uint) : void
      {
         if(this.FOnReceiveAwards != null)
         {
            this.FOnReceiveAwards(this,param1);
         }
      }
      
      protected function SlotOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnOver != null)
         {
            this.FOnOver(this,param2);
         }
      }
      
      protected function SlotOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(this,param2);
         }
      }
      
      protected function MouseOnHitOver(param1:Object, param2:THint) : void
      {
         if(this.FOnHitOver != null)
         {
            this.FOnHitOver(this,param2);
         }
      }
      
      protected function MouseOnHitOut(param1:Object) : void
      {
         if(this.FOnHitOver != null)
         {
            this.FOnHitOut(this);
         }
      }
      
      protected function JmpToWindow(param1:int = 0) : void
      {
         if(this.FOnOpenWindow != null)
         {
            this.FOnOpenWindow(this,param1);
         }
      }
      
      protected function EffectGenerateTextByErrorCode(param1:int) : void
      {
         if(this.FEffectGenerateTextByErrorCodeFunction != null)
         {
            this.FEffectGenerateTextByErrorCodeFunction(param1);
         }
      }
      
      protected function FormatTime(param1:int) : String
      {
         var _loc2_:int = 0;
         _loc2_ = param1 / SecondOneDay;
         if(_loc2_ > 0)
         {
            return _loc2_ + STRING_COMMON.TYPE_TIME_Day;
         }
         return TGameUtil.fomatTime(param1);
      }
      
      public function set OnOver(param1:Function) : void
      {
         this.FOnOver = param1;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function set OnHitOver(param1:Function) : void
      {
         this.FOnHitOver = param1;
      }
      
      public function set OnHitOut(param1:Function) : void
      {
         this.FOnHitOut = param1;
      }
      
      public function set OnReceiveAwards(param1:Function) : void
      {
         this.FOnReceiveAwards = param1;
      }
      
      public function set OnOpenWindow(param1:Function) : void
      {
         this.FOnOpenWindow = param1;
      }
      
      public function set EffectGenerateTextByErrorCodeFunction(param1:Function) : void
      {
         this.FEffectGenerateTextByErrorCodeFunction = param1;
      }
      
      public function UIDispatch(param1:MovieClip) : void
      {
         this.FMainScene = param1;
         this.addChild(this.FMainScene);
      }
      
      public function UILocation() : void
      {
      }
      
      public function Show() : void
      {
         this.visible = true;
      }
      
      public function Hide() : void
      {
         this.visible = false;
      }
      
      public function NotifyActivityAtoms(param1:TActivityAtoms) : void
      {
      }
      
      public function NotifyPacketArrive(param1:TPacket) : void
      {
      }
   }
}

