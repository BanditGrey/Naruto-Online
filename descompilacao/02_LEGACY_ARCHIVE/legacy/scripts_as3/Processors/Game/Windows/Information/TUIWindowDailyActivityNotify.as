package Processors.Game.Windows.Information
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Processors.Game.Windows.TUIWindow;
   import Resources.Constants.CONST_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIWindowDailyActivityNotify extends TUIWindow
   {
      
      protected static const SIZE_Window_Width:uint = 300;
      
      protected static const SIZE_Window_Height:uint = 200;
      
      protected var FTF_EnterTime:TextField;
      
      protected var FActivityId:uint;
      
      public function TUIWindowDailyActivityNotify(param1:TUIComponent)
      {
         super(param1);
         this.AddMaskLayer();
      }
      
      override protected function ConstruceComponentTextfield() : void
      {
         FTextField = FScene[CONST_COMMON.RESOURCE_Link_TF_Text];
         FTextField.selectable = false;
         Text = "";
         this.FTF_EnterTime = FScene[CONST_COMMON.RESOURCE_Link_TF_EnterTime];
         FTextField.selectable = false;
      }
      
      override protected function ConstructComponentMovieClip() : void
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
      
      protected function AddMaskLayer() : void
      {
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-(CONST_COMMON.STAGE_Width - SIZE_Window_Width) / 2,-(CONST_COMMON.STAGE_Height - SIZE_Window_Height) / 2,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
      }
      
      protected function ButtonOKOnClick(param1:MouseEvent = null) : void
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
      
      public function get ActivityId() : uint
      {
         return this.FActivityId;
      }
      
      public function set ActivityId(param1:uint) : void
      {
         this.FActivityId = param1;
      }
      
      public function UpdataEnterTime(param1:String) : void
      {
         this.FTF_EnterTime.text = param1;
      }
      
      public function TimeOutAutoEnter() : void
      {
         if(FOnOK != null)
         {
            FOnOK(this,true);
         }
         Visible = false;
      }
   }
}

