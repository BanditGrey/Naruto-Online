package Processors.Game.Lobby.RebirthRealm
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowEntryRebirthPanel extends TProcessorLobbyWindow
   {
      
      public static const THREE:int = 3;
      
      protected var FRootPanel:MovieClip;
      
      protected var FGotoRebirthRealmFun:Function;
      
      protected var FBtnOverFunc:Function;
      
      protected var FBtnMoveFunc:Function;
      
      protected var FBtnOutFunc:Function;
      
      public function TProcessorWindowEntryRebirthPanel(param1:TUIComponent)
      {
         super(param1);
      }
      
      public function SetThisPanel(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.FRootPanel = param1;
         _loc2_ = 0;
         while(_loc2_ < THREE)
         {
            _loc3_ = this.FRootPanel["Btn_chapter_" + _loc2_];
            _loc3_.addEventListener(MouseEvent.CLICK,this.GotoRebirthRealmFunClick);
            TGameUtil.setButtonMode(_loc3_,true);
            _loc2_++;
         }
      }
      
      protected function GotoRebirthRealmFunClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FGotoRebirthRealmFun != null)
         {
            _loc2_ = int(param1.currentTarget.name.substr(12));
            this.FGotoRebirthRealmFun(_loc2_);
         }
      }
      
      protected function AutoBtnOut(param1:MouseEvent) : void
      {
         if(this.FBtnOutFunc != null)
         {
            this.FBtnOutFunc();
         }
      }
      
      protected function AutoBtnMove(param1:MouseEvent) : void
      {
         if(this.FBtnMoveFunc != null)
         {
            this.FBtnMoveFunc();
         }
      }
      
      public function set GotoRebirthRealmFun(param1:Function) : void
      {
         this.FGotoRebirthRealmFun = param1;
      }
      
      public function set BtnOverFunc(param1:Function) : void
      {
         this.FBtnOverFunc = param1;
      }
      
      public function set BtnOutFunc(param1:Function) : void
      {
         this.FBtnOutFunc = param1;
      }
      
      public function set BtnMoveFunc(param1:Function) : void
      {
         this.FBtnMoveFunc = param1;
      }
      
      public function ClosePanel() : void
      {
      }
   }
}

