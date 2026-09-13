package Processors.Game.Windows.Information
{
   import Externals.SExternalCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Processors.Game.Windows.TUIWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIWindowRecharge extends TUIWindow
   {
      
      protected static var SIZE_Window_Width:uint = 310;
      
      protected static var SIZE_Window_Height:uint = 190;
      
      protected var FBtn_Close:SimpleButton;
      
      public function TUIWindowRecharge(param1:TUIComponent)
      {
         super(param1);
         FModalLayer.x = 0 - (CONST_COMMON.STAGE_Width - SIZE_Window_Width) / 2;
         FModalLayer.y = 0 - (CONST_COMMON.STAGE_Height - SIZE_Window_Height) / 2;
      }
      
      public function get MaskUi() : Sprite
      {
         return FModalLayer;
      }
      
      override protected function ConstructComponentButtons() : void
      {
         FButtonOK = this.ConstructComponentButton(CONST_COMMON.RESOURCE_Link_Btn_Ok,CONST_COMMON.RESOURCE_Link_TF_BtnOkCaption,this.ButtonOKOnClick,FButtonOkCaption);
         this.FBtn_Close = FScene[CONST_COMMON.RESOURCE_Link_Btn_Close];
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ButtonCancelOnClick,false,0,true);
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
         FTextField = FScene[CONST_COMMON.RESOURCE_Link_TF_Text];
         FTextField.selectable = false;
         Text = STRING_COMMON.GOTO_RECHARGE;
      }
      
      override protected function NCButtonCloseOnClick(param1:Object) : void
      {
         if(FOnCancel != null)
         {
            FOnCancel(this);
         }
         Visible = false;
      }
      
      protected function ButtonOKOnClick(param1:MouseEvent) : void
      {
         SExternalCore.NavigateToRecharge();
         Visible = false;
      }
      
      protected function ButtonCancelOnClick(param1:MouseEvent) : void
      {
         if(FOnCancel != null)
         {
            FOnCancel(this);
         }
         Visible = false;
      }
      
      public function get WindowWidth() : int
      {
         return SIZE_Window_Width;
      }
      
      public function get WindowHeight() : int
      {
         return SIZE_Window_Height;
      }
   }
}

