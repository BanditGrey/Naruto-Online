package Processors.Game.Windows.Information
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
   
   public class TUIWindowPromptFrame extends TUIWindow
   {
      
      protected static const SIZE_Window_Width:uint = 310;
      
      protected static const SIZE_Window_Height:uint = 190;
      
      protected var FMC_Scene:MovieClip = null;
      
      protected var FCallback:Function;
      
      protected var FTF_Count:TextField;
      
      protected var FTF_Desc:TextField;
      
      protected var FBTN_Reduce:MovieClip;
      
      protected var FBTN_Add:MovieClip;
      
      protected var FCount:int;
      
      protected var FMaxCount:int;
      
      public function TUIWindowPromptFrame(param1:TUIComponent)
      {
         super(param1);
         this.AddMaskLayer();
      }
      
      override protected function ConstructComponentButtons() : void
      {
         FButtonOK = this.ConstructComponentButton(CONST_COMMON.RESOURCE_Link_Btn_Ok,CONST_COMMON.RESOURCE_Link_TF_BtnOkCaption,this.ButtonOKOnClick,FButtonOkCaption);
         FButtonCancel = this.ConstructComponentButton(CONST_COMMON.RESOURCE_Link_Btn_Cancel,CONST_COMMON.RESOURCE_Link_TF_BtnCancelCaption,this.ButtonCancelOnClick,FButtonCancelCaption);
         this.FBTN_Reduce = FScene["BTN_Reduce"];
         this.FBTN_Add = FScene["BTN_Add"];
         this.FBTN_Reduce.addEventListener(MouseEvent.CLICK,this.ReduceOnClick,false,0,true);
         this.FBTN_Add.addEventListener(MouseEvent.CLICK,this.AddOnClick,false,0,true);
         TGameUtil.setButtonMode(FScene["BTN_Max"],true);
         FScene["BTN_Max"].addEventListener(MouseEvent.CLICK,this.OnMaxClick);
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
         this.FTF_Count = FScene["TF_Count"];
         this.FTF_Count.restrict = "0-9";
         this.FTF_Count.addEventListener(Event.CHANGE,this.OnCountChange);
         this.FTF_Desc = FScene["TF_Desc"];
         this.FTF_Desc.text = "";
      }
      
      private function OnCountChange(param1:Event) : void
      {
         this.Count = int(this.FTF_Count.text);
      }
      
      private function ReduceOnClick(param1:MouseEvent) : void
      {
         --this.Count;
      }
      
      private function AddOnClick(param1:MouseEvent) : void
      {
         ++this.Count;
      }
      
      private function OnMaxClick(param1:MouseEvent) : void
      {
         this.Count = this.FMaxCount;
      }
      
      private function ButtonOKOnClick(param1:MouseEvent) : void
      {
         if(this.FCallback != null)
         {
            this.FCallback(this.Count);
         }
         this.visible = false;
         this.Count = 1;
      }
      
      private function ButtonCancelOnClick(param1:MouseEvent) : void
      {
         this.visible = false;
         this.Count = 1;
      }
      
      public function get Callback() : Function
      {
         return this.FCallback;
      }
      
      public function set Callback(param1:Function) : void
      {
         this.FCallback = param1;
      }
      
      public function get Count() : int
      {
         return this.FCount;
      }
      
      public function set Count(param1:int) : void
      {
         this.FCount = Math.max(1,param1);
         this.FCount = Math.min(this.FMaxCount,this.FCount);
         TGameUtil.setButtonMode(this.FBTN_Reduce,this.FCount > 1);
         TGameUtil.setButtonMode(this.FBTN_Add,this.FCount < this.FMaxCount);
         this.FTF_Count.text = this.FCount.toString();
      }
      
      public function get MaxCount() : int
      {
         return this.FMaxCount;
      }
      
      public function set MaxCount(param1:int) : void
      {
         this.FMaxCount = param1;
      }
      
      public function get Window_Width() : uint
      {
         return SIZE_Window_Width;
      }
      
      public function get Window_Height() : uint
      {
         return SIZE_Window_Height;
      }
      
      public function AddMaskLayer() : void
      {
         FModalLayer.graphics.beginFill(0,0.3);
         FModalLayer.graphics.drawRect(-(CONST_COMMON.STAGE_Width / 2),-(CONST_COMMON.STAGE_Height / 2),CONST_COMMON.STAGE_Width * 2,CONST_COMMON.STAGE_Height * 2);
         FModalLayer.graphics.endFill();
      }
   }
}

