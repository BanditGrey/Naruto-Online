package Processors.Game.Windows.Editors
{
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Processors.Game.Windows.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TUIWindowEditorString extends TUIWindow
   {
      
      public static const SIZE_Window_Width:uint = 310;
      
      public static const SIZE_Window_Height:uint = 190;
      
      public static const DEFAULT_MAX_CHARS:uint = STRING_COMMON.DEFAULT_MAX_CHARS;
      
      protected var FBtnClose:SimpleButton;
      
      protected var FCaption:TextField;
      
      protected var FLabel:TextField;
      
      protected var FText:TextField;
      
      protected var FEditorCaption:String;
      
      protected var FEditorLabel:String;
      
      public function TUIWindowEditorString(param1:TUIComponent)
      {
         super(param1);
         FModalLayer.x = 0 - (CONST_COMMON.STAGE_Width - SIZE_Window_Width) / 2;
         FModalLayer.y = 0 - (CONST_COMMON.STAGE_Height - SIZE_Window_Height) / 2;
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
         return _loc5_;
      }
      
      override protected function ConstruceComponentTextfield() : void
      {
         super.ConstruceComponentTextfield();
         this.FCaption = FScene[CONST_COMMON.RESOURCE_Link_TF_Caption];
         if(!TUtilityString.Empty(this.FEditorCaption))
         {
            this.FCaption.text = this.FEditorCaption;
         }
         this.FLabel = FScene[CONST_COMMON.RESOURCE_Link_TF_Label];
         if(!TUtilityString.Empty(this.FEditorLabel))
         {
            this.FLabel.text = this.FEditorLabel;
         }
         this.FText = FScene[CONST_COMMON.RESOURCE_Link_TF_Value];
         this.FText.text = "";
         this.FText.maxChars = DEFAULT_MAX_CHARS;
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
            FOnOK(this);
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
      
      public function get WindowWidth() : int
      {
         return SIZE_Window_Width;
      }
      
      public function get WindowHeight() : int
      {
         return SIZE_Window_Height;
      }
      
      public function get EditorCaption() : String
      {
         return this.FEditorCaption;
      }
      
      public function set EditorCaption(param1:String) : void
      {
         this.FEditorCaption = param1;
      }
      
      public function get EditorLabel() : String
      {
         return this.FEditorLabel;
      }
      
      public function set EditorLabel(param1:String) : void
      {
         this.FEditorLabel = param1;
      }
      
      public function set Label(param1:String) : void
      {
         this.FLabel.text = param1;
      }
      
      public function get Label() : String
      {
         return this.FLabel.text;
      }
      
      public function set Value(param1:String) : void
      {
         this.FText.text = param1;
      }
      
      public function get Value() : String
      {
         return this.FText.text;
      }
      
      public function set Restrict(param1:String) : void
      {
         this.FText.restrict = param1;
      }
      
      public function get Restrict() : String
      {
         return this.FText.restrict;
      }
      
      public function set MaxChars(param1:uint) : void
      {
         this.FText.maxChars = param1;
      }
      
      public function get MaxChars() : uint
      {
         return this.FText.maxChars;
      }
      
      public function SetFocus() : void
      {
         if(FUICore.UIStage.focus != this.FText)
         {
            FUICore.UIStage.focus = this.FText;
         }
      }
   }
}

