package Processors.Game.Windows.Input
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Processors.Game.Windows.TUIWindow;
   import Resources.Constants.CONST_COMMON;
   import flash.display.MovieClip;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIWindowSeekRoom extends TUIWindow
   {
      
      protected static const SIZE_Window_Width:uint = 310;
      
      protected static const SIZE_Window_Height:uint = 190;
      
      protected var FTF_InputRoomID:TextField;
      
      protected var FTF_InputPassword:TextField;
      
      protected var FMC_FirstStatus:MovieClip;
      
      protected var FMC_SecondStatus:MovieClip;
      
      protected var FRoomID:String;
      
      protected var FPassword:String;
      
      protected var FBFocusRoomID:Boolean;
      
      protected var FBFocusPassword:Boolean;
      
      public function TUIWindowSeekRoom(param1:TUIComponent)
      {
         super(param1);
         FModalLayer.x = 0 - (CONST_COMMON.STAGE_Width - SIZE_Window_Width) / 2;
         FModalLayer.y = 0 - (CONST_COMMON.STAGE_Height - SIZE_Window_Height) / 2;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(FModalLayer.x,FModalLayer.y,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FRoomID = "";
         this.FPassword = "";
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
         this.FTF_InputPassword = FScene[CONST_COMMON.RESOURCE_Link_TF_InputPassword];
         this.FTF_InputPassword.restrict = "0-9";
         this.FTF_InputPassword.maxChars = 4;
         if(!TUtilityString.Empty(this.FPassword))
         {
            this.FTF_InputPassword.text = this.FPassword;
         }
         this.FTF_InputRoomID = FScene[CONST_COMMON.RESOURCE_Link_TF_InputRoomID];
         this.FTF_InputRoomID.restrict = "0-9";
         this.FTF_InputRoomID.maxChars = 3;
         if(!TUtilityString.Empty(this.FRoomID))
         {
            this.FTF_InputRoomID.text = this.FRoomID;
         }
         this.Reset();
         this.FMC_FirstStatus = FScene["MC_FirstStatus"];
         this.FMC_SecondStatus = FScene["MC_SecondStatus"];
         this.FMC_FirstStatus.visible = false;
         this.FMC_SecondStatus.visible = false;
         this.FTF_InputPassword.addEventListener(FocusEvent.FOCUS_IN,this.OnTextFocusIn);
         this.FTF_InputPassword.addEventListener(FocusEvent.FOCUS_OUT,this.OnTextFocusOut);
         this.FTF_InputRoomID.addEventListener(FocusEvent.FOCUS_IN,this.OnTextFocusIn);
         this.FTF_InputRoomID.addEventListener(FocusEvent.FOCUS_OUT,this.OnTextFocusOut);
      }
      
      protected function ButtonOKOnClick(param1:MouseEvent) : void
      {
         if(FOnOK != null)
         {
            FOnOK(this);
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
      
      protected function OnTextFocusIn(param1:FocusEvent) : void
      {
         var _loc2_:TextField = null;
         _loc2_ = param1.currentTarget as TextField;
         if(_loc2_ == this.FTF_InputRoomID)
         {
            if(!this.FBFocusRoomID)
            {
               this.FTF_InputRoomID.text = "";
               this.FBFocusRoomID = true;
            }
         }
         else if(_loc2_ == this.FTF_InputPassword)
         {
            if(!this.FBFocusPassword)
            {
               this.FTF_InputPassword.text = "";
               this.FBFocusPassword = true;
            }
         }
      }
      
      protected function OnTextFocusOut(param1:FocusEvent) : void
      {
         var _loc2_:TextField = null;
         _loc2_ = param1.currentTarget as TextField;
         if(_loc2_ == this.FTF_InputRoomID)
         {
            if(this.FTF_InputRoomID.text == "")
            {
               this.FTF_InputRoomID.text = this.FRoomID;
               this.FBFocusRoomID = false;
            }
         }
         else if(_loc2_ == this.FTF_InputPassword)
         {
            if(this.FTF_InputPassword.text == "")
            {
               this.FTF_InputPassword.text = this.FPassword;
               this.FBFocusPassword = false;
            }
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
      
      public function get Password() : String
      {
         return this.FTF_InputPassword.text;
      }
      
      public function set Password(param1:String) : void
      {
         this.FPassword = param1;
      }
      
      public function get RoomID() : String
      {
         return this.FTF_InputRoomID.text;
      }
      
      public function set RoomID(param1:String) : void
      {
         this.FRoomID = param1;
      }
      
      public function Reset() : void
      {
         this.FTF_InputPassword.text = "";
         this.FTF_InputRoomID.text = "";
      }
   }
}

