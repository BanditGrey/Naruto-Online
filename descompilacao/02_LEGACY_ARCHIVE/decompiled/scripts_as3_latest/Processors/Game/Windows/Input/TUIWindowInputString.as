package Processors.Game.Windows.Input
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Processors.Game.Windows.TUIWindow;
   import Resources.Constants.CONST_COMMON;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIWindowInputString extends TUIWindow
   {
      
      public static const SIZE_Window_Width:uint = 310;
      
      public static const SIZE_Window_Height:uint = 190;
      
      protected var FCaption:TextField;
      
      protected var FLabel:TextField;
      
      protected var FText:TextField;
      
      protected var FBFocus:Boolean;
      
      protected var FEditorString:String;
      
      public function TUIWindowInputString(param1:TUIComponent)
      {
         super(param1);
         FModalLayer.x = 0 - (CONST_COMMON.STAGE_Width - SIZE_Window_Width) / 2;
         FModalLayer.y = 0 - (CONST_COMMON.STAGE_Height - SIZE_Window_Height) / 2;
         this.FBFocus = false;
      }
      
      override protected function ConstructComponentButtons() : void
      {
         FButtonOK = this.ConstructComponentButton(CONST_COMMON.RESOURCE_Link_Btn_Ok,CONST_COMMON.RESOURCE_Link_TF_BtnOkCaption,this.ButtonOKOnClick,FButtonOkCaption);
         FButtonCancel = this.ConstructComponentButton(CONST_COMMON.RESOURCE_Link_Btn_Cancel,CONST_COMMON.RESOURCE_Link_TF_BtnCancelCaption,this.ButtonCancelOnClick,FButtonCancelCaption);
      }
      
      protected function ConstructComponentButton(param1:String, param2:String = null, param3:Function = null, param4:String = null) : MovieClip
      {
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         _loc5_ = FScene[param1];
         TGameUtil.setButtonMode(_loc5_,true);
         _loc5_.addEventListener(MouseEvent.CLICK,param3,false,0,true);
         if(!TUtilityString.Empty(param2))
         {
            _loc6_ = _loc5_[param2];
            _loc6_.selectable = false;
            _loc6_.mouseEnabled = false;
         }
         if(!TUtilityString.Empty(param4))
         {
            _loc6_.text = param4;
         }
         return _loc5_;
      }
      
      override protected function ConstruceComponentTextfield() : void
      {
         super.ConstruceComponentTextfield();
         this.FText = FScene[CONST_COMMON.RESOURCE_Link_TF_Text];
         if(!TUtilityString.Empty(this.FEditorString))
         {
            this.FText.text = this.FEditorString;
         }
         this.FText = FScene[CONST_COMMON.RESOURCE_Link_TF_Text];
         this.FText.addEventListener(Event.CHANGE,this.TextFieldOnChange);
         this.FText.addEventListener(FocusEvent.FOCUS_IN,this.OnTextFocusIn);
         this.FText.addEventListener(FocusEvent.FOCUS_OUT,this.OnTextFocusOut);
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
         if(FOnOK != null)
         {
            FOnOK(this,String(this.FText.text));
         }
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
      
      protected function TextFieldOnChange(param1:Event) : void
      {
      }
      
      protected function OnTextFocusIn(param1:FocusEvent) : void
      {
         if(!this.FBFocus)
         {
            this.FText.text = "";
            this.FBFocus = true;
         }
      }
      
      protected function OnTextFocusOut(param1:FocusEvent) : void
      {
         if(this.FText.text == "")
         {
            this.FText.text = this.FEditorString;
            this.FBFocus = false;
         }
      }
      
      public function get WindowWidth() : int
      {
         return SIZE_Window_Width;
      }
      
      public function get WindowHeight() : int
      {
         return SIZE_Window_Height;
      }
      
      public function get EditorString() : String
      {
         return this.FEditorString;
      }
      
      public function set EditorString(param1:String) : void
      {
         this.FEditorString = param1;
      }
      
      public function SetFocus() : void
      {
         if(FUICore.UIStage.focus != this.FText)
         {
            FUICore.UIStage.focus = this.FText;
         }
      }
      
      public function Update(param1:String) : void
      {
      }
   }
}

