package Processors.Game.Windows.Input
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Processors.Game.Windows.TUIWindow;
   import Resources.Constants.CONST_COMMON;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIWindowInputPassword extends TUIWindow
   {
      
      protected static const SIZE_Window_Width:uint = 310;
      
      protected static const SIZE_Window_Height:uint = 190;
      
      protected var FTF_InputPassword:TextField;
      
      protected var FPassword:String;
      
      protected var FBFocus:Boolean;
      
      public function TUIWindowInputPassword(param1:TUIComponent)
      {
         super(param1);
         FModalLayer.x = 0 - (CONST_COMMON.STAGE_Width - SIZE_Window_Width) / 2;
         FModalLayer.y = 0 - (CONST_COMMON.STAGE_Height - SIZE_Window_Height) / 2;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(FModalLayer.x,FModalLayer.y,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
      }
      
      override protected function ConstructComponentButtons() : void
      {
         FButtonOK = this.ConstructComponentButton(CONST_COMMON.RESOURCE_Link_Btn_Ok,CONST_COMMON.RESOURCE_Link_TF_BtnOkCaption,this.ButtonOKOnClick,FButtonOkCaption);
         FButtonCancel = this.ConstructComponentButton(CONST_COMMON.RESOURCE_Link_Btn_Cancel,CONST_COMMON.RESOURCE_Link_TF_BtnCancelCaption,this.ButtonCancelOnClick,FButtonCancelCaption);
      }
      
      protected function ConstructComponentButton(param1:String, param2:String, param3:Function, param4:String) : MovieClip
      {
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         _loc5_ = FScene[param1];
         TGameUtil.setButtonMode(_loc5_,true);
         _loc5_.addEventListener(MouseEvent.CLICK,param3,false,0,true);
         return _loc5_;
      }
      
      override protected function ConstruceComponentTextfield() : void
      {
         super.ConstruceComponentTextfield();
         this.FTF_InputPassword = FScene[CONST_COMMON.RESOURCE_Link_TF_InputPassword];
         this.FTF_InputPassword.restrict = "0-9";
         this.FTF_InputPassword.maxChars = 4;
         this.Reset();
         if(!TUtilityString.Empty(this.FPassword))
         {
            this.FTF_InputPassword.text = this.FPassword;
         }
         this.FTF_InputPassword.addEventListener(Event.CHANGE,this.OnTextChange);
      }
      
      protected function ButtonOKOnClick(param1:MouseEvent) : void
      {
         if(FOnOK != null)
         {
            FOnOK(this,Context);
         }
         Visible = false;
         this.Reset();
      }
      
      protected function ButtonCancelOnClick(param1:MouseEvent) : void
      {
         if(FOnCancel != null)
         {
            FOnCancel(this);
         }
         Visible = false;
         this.Reset();
      }
      
      protected function OnTextChange(param1:Event) : void
      {
         this.FPassword = this.FTF_InputPassword.text;
      }
      
      public function get WindowWidth() : int
      {
         return SIZE_Window_Width;
      }
      
      public function get WindowHeight() : int
      {
         return SIZE_Window_Height;
      }
      
      public function get Password() : String
      {
         return this.FPassword;
      }
      
      public function set Password(param1:String) : void
      {
         this.FPassword = param1;
      }
      
      public function Reset() : void
      {
         this.FTF_InputPassword.text = "";
      }
   }
}

