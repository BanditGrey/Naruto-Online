package Processors.Game.Windows
{
   import Foundation.UI.TUIComponent;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TUIWindow extends TProcessorLobbyWindow
   {
      
      protected var FModalLayer:Sprite;
      
      protected var FScene:Sprite;
      
      protected var FTextField:TextField;
      
      protected var FButtonOK:MovieClip;
      
      protected var FButtonCancel:MovieClip;
      
      protected var FOnOK:Function;
      
      protected var FOnCancel:Function;
      
      protected var FButtonOkCaption:String;
      
      protected var FButtonCancelCaption:String;
      
      protected var FContext:Object;
      
      public function TUIWindow(param1:TUIComponent)
      {
         super(param1);
         this.FModalLayer = new Sprite();
         this.addChild(this.FModalLayer);
         this.Visible = false;
      }
      
      public function ConstructComponents() : void
      {
         this.ConstruceComponentTextfield();
         this.ConstructComponentButtons();
         this.ConstructComponentMovieClip();
      }
      
      protected function ConstruceComponentTextfield() : void
      {
      }
      
      protected function ConstructComponentButtons() : void
      {
      }
      
      protected function ConstructComponentMovieClip() : void
      {
      }
      
      public function get Scene() : Sprite
      {
         return this.FScene;
      }
      
      public function set Scene(param1:Sprite) : void
      {
         this.FScene = param1;
      }
      
      public function get Context() : Object
      {
         return this.FContext;
      }
      
      public function set Context(param1:Object) : void
      {
         this.FContext = param1;
      }
      
      public function get Text() : String
      {
         return this.FTextField.text;
      }
      
      public function set Text(param1:String) : void
      {
         this.FTextField.text = param1;
      }
      
      public function get ButtonOK() : MovieClip
      {
         return this.FButtonOK;
      }
      
      public function get ButtonCancel() : MovieClip
      {
         return this.FButtonCancel;
      }
      
      public function get OnOK() : Function
      {
         return this.FOnOK;
      }
      
      public function set OnOK(param1:Function) : void
      {
         this.FOnOK = param1;
      }
      
      public function get OnCancel() : Function
      {
         return this.FOnCancel;
      }
      
      public function set OnCancel(param1:Function) : void
      {
         this.FOnCancel = param1;
      }
      
      public function get ButtonOkCaption() : String
      {
         return this.FButtonOkCaption;
      }
      
      public function set ButtonOkCaption(param1:String) : void
      {
         this.FButtonOkCaption = param1;
      }
      
      public function get ButtonCancelCaption() : String
      {
         return this.FButtonCancelCaption;
      }
      
      public function set ButtonCancelCaption(param1:String) : void
      {
         this.FButtonCancelCaption = param1;
      }
      
      public function get Modal() : Boolean
      {
         return this.FModalLayer.visible;
      }
      
      public function set Modal(param1:Boolean) : void
      {
         this.FModalLayer.visible = param1;
      }
      
      public function Init() : void
      {
         addChild(this.FScene);
         this.ConstructComponents();
      }
      
      public function SetTextFormat(param1:TextFormat, param2:int = -1, param3:int = -1) : void
      {
         this.FTextField.setTextFormat(param1,param2,param3);
      }
   }
}

