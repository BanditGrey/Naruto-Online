package Processors.Game.Windows.Information
{
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Processors.Game.Windows.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TUIWindowConfirmation extends TUIWindow
   {
      
      protected static const SIZE_Window_Width:uint = 310;
      
      protected static const SIZE_Window_Height:uint = 190;
      
      protected static const INDEXFRAME_CHECKBOX_UNSELECT:uint = 1;
      
      protected static const INDEXFRAME_CHECKBOX_SELECTED:uint = 2;
      
      protected var FMC_CheckBox:Sprite;
      
      protected var FBtn_CheckBox:MovieClip;
      
      protected var FMC_Selected:MovieClip;
      
      protected var FMC_UnSelect:MovieClip;
      
      protected var FTF_CheckBox:TextField;
      
      protected var FIsSelected:Boolean;
      
      protected var FOnCheckBoxSelected:Function;
      
      public function TUIWindowConfirmation(param1:TUIComponent)
      {
         super(param1);
         FModalLayer.x = 0 - (CONST_COMMON.STAGE_Width - SIZE_Window_Width) / 2;
         FModalLayer.y = 0 - (CONST_COMMON.STAGE_Height - SIZE_Window_Height) / 2;
         FModalLayer.width = CONST_COMMON.STAGE_Width * 2;
         FModalLayer.height = CONST_COMMON.STAGE_Height * 2;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(-(CONST_COMMON.STAGE_Width / 2),-(CONST_COMMON.STAGE_Height / 2),CONST_COMMON.STAGE_Width * 2,CONST_COMMON.STAGE_Height * 2);
         this.graphics.endFill();
         this.FIsSelected = false;
      }
      
      public function get MaskUi() : Sprite
      {
         return FModalLayer;
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
         FTextField = FScene[CONST_COMMON.RESOURCE_Link_TF_Text];
         FTextField.selectable = false;
         Text = "";
      }
      
      override protected function ConstructComponentMovieClip() : void
      {
         this.FMC_CheckBox = FScene[CONST_COMMON.RESOURCE_Link_MC_CheckBox];
         this.FMC_CheckBox.visible = false;
         this.FBtn_CheckBox = this.FMC_CheckBox[CONST_COMMON.RESOURCE_Link_Btn_CheckBox];
         this.FMC_UnSelect = this.FBtn_CheckBox[CONST_COMMON.RESOURCE_Link_MC_UnSelect];
         TGameUtil.setButtonMode(this.FMC_UnSelect,true);
         this.FMC_UnSelect.addEventListener(MouseEvent.CLICK,this.CheckBoxOnClick,false,0,true);
         this.FMC_Selected = this.FBtn_CheckBox[CONST_COMMON.RESOURCE_Link_MC_Selected];
         TGameUtil.setButtonMode(this.FMC_Selected,true);
         this.FMC_Selected.visible = false;
         this.FMC_Selected.addEventListener(MouseEvent.CLICK,this.CheckBoxOnClick,false,0,true);
         this.FTF_CheckBox = this.FMC_CheckBox[CONST_COMMON.RESOURCE_Link_TF_CheckBox];
      }
      
      override protected function NCButtonCloseOnClick(param1:Object) : void
      {
         Visible = false;
         if(FOnCancel != null)
         {
            FOnCancel(this);
         }
      }
      
      protected function ButtonOKOnClick(param1:MouseEvent) : void
      {
         Visible = false;
         if(FOnOK != null)
         {
            FOnOK(this);
         }
      }
      
      protected function ButtonCancelOnClick(param1:MouseEvent) : void
      {
         if(FOnCancel != null)
         {
            FOnCancel(this);
         }
         Visible = false;
      }
      
      protected function CheckBoxOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         this.FIsSelected = !this.FIsSelected;
         if(this.FIsSelected)
         {
            this.FMC_Selected.visible = true;
         }
         else
         {
            this.FMC_Selected.visible = false;
         }
         if(this.FOnCheckBoxSelected != null)
         {
            this.FOnCheckBoxSelected(this,this.FIsSelected);
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
      
      public function SetCheckBox(param1:Boolean) : void
      {
         if(param1 != this.FMC_CheckBox.visible)
         {
            this.FMC_CheckBox.visible = param1;
         }
      }
      
      public function SetSelectedOrNot(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            this.FMC_Selected.visible = true;
         }
         else
         {
            this.FMC_Selected.visible = false;
         }
      }
      
      public function get IsSelected() : Boolean
      {
         return this.FIsSelected;
      }
      
      public function set IsSelected(param1:Boolean) : void
      {
         this.FIsSelected = param1;
      }
      
      public function set OnCheckBoxSelected(param1:Function) : void
      {
         this.FOnCheckBoxSelected = param1;
      }
      
      public function set SetHtml(param1:String) : void
      {
         FTextField.htmlText = param1;
      }
      
      public function set SetCheckBoxInfo(param1:String) : void
      {
         if(this.FTF_CheckBox != null)
         {
            this.FTF_CheckBox.text = param1;
         }
      }
   }
}

