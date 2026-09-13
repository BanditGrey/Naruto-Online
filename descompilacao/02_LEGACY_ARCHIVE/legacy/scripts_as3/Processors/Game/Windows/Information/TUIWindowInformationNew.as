package Processors.Game.Windows.Information
{
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Processors.Game.Windows.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TUIWindowInformationNew extends TUIWindow
   {
      
      protected static const SIZE_Window_Width:uint = 272;
      
      protected static const SIZE_Window_Height:uint = 150;
      
      protected static const SIZE_TextWidthMin:int = 240;
      
      protected static const SIZE_TextWidthMax:int = 480;
      
      protected static const SIZE_TextMarginLeft:int = 32;
      
      protected static const SIZE_TextMarginRight:int = 32;
      
      protected static const SIZE_TextMarginTop:int = 60;
      
      protected static const SIZE_TextMarginBottom:int = 80;
      
      public function TUIWindowInformationNew(param1:TUIComponent)
      {
         super(param1);
         FModalLayer.x = 0 - (CONST_COMMON.STAGE_Width - SIZE_Window_Width) / 2;
         FModalLayer.y = 0 - (CONST_COMMON.STAGE_Height - SIZE_Window_Height) / 2;
         FModalLayer.width = CONST_COMMON.STAGE_Width * 2;
         FModalLayer.height = CONST_COMMON.STAGE_Height * 2;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(-(CONST_COMMON.STAGE_Width / 2),-(CONST_COMMON.STAGE_Height / 2),CONST_COMMON.STAGE_Width * 2,CONST_COMMON.STAGE_Height * 2);
         this.graphics.endFill();
      }
      
      override protected function ConstructComponentButtons() : void
      {
         FButtonOK = this.ConstructComponentButton(CONST_COMMON.RESOURCE_Link_Btn_Ok,CONST_COMMON.RESOURCE_Link_TF_BtnOkCaption,this.ButtonOKOnClick,FButtonOkCaption);
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
         Text = "";
      }
      
      public function set SetHtml(param1:String) : void
      {
         FTextField.htmlText = param1;
      }
      
      protected function ButtonOKOnClick(param1:MouseEvent) : void
      {
         if(FOnOK != null)
         {
            FOnOK(this);
         }
         Visible = false;
      }
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
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

