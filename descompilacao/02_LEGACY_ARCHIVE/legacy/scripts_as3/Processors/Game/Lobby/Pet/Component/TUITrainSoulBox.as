package Processors.Game.Lobby.Pet.Component
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_PET;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUITrainSoulBox extends TUIComponent
   {
      
      protected static const SIZE_WIDTH_Box:uint = 310;
      
      protected static const SIZE_HIGHT_Box:uint = 190;
      
      protected var FScene:Sprite;
      
      protected var FModalLayer:Sprite;
      
      protected var FBtn_Ok:MovieClip;
      
      protected var FBtn_Cancel:MovieClip;
      
      protected var FTF_Value:TextField;
      
      protected var FTF_CurCount:TextField;
      
      protected var FBtn_Max:MovieClip;
      
      protected var FMax:int;
      
      protected var FMin:int;
      
      protected var FCurCount:int;
      
      protected var FOnSetMax:Function;
      
      protected var FOnClickOk:Function;
      
      public function TUITrainSoulBox(param1:TUIComponent)
      {
         super(param1);
         this.FModalLayer = new Sprite();
         this.SetLayer();
      }
      
      protected function UIDispatch() : void
      {
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_PET.RESOURCE_Link_MC_Box) as Sprite;
         addChild(this.FScene);
         this.FScene.x = (632 - SIZE_WIDTH_Box) / 2;
         this.FScene.y = (482 - SIZE_HIGHT_Box) / 2;
         this.FBtn_Ok = this.FScene[CONST_PET.RESOURCE_Link_Btn_Ok];
         TGameUtil.setButtonMode(this.FBtn_Ok,true);
         this.FBtn_Cancel = this.FScene[CONST_PET.RESOURCE_Link_Btn_Cancel];
         TGameUtil.setButtonMode(this.FBtn_Cancel,true);
         this.FBtn_Max = this.FScene[CONST_PET.RESOURCE_Link_Btn_Max];
         TGameUtil.setButtonMode(this.FBtn_Max,true);
         this.FTF_Value = this.FScene[CONST_PET.RESOURCE_Link_TF_Value];
         this.FTF_Value.restrict = "0-9";
         this.FTF_Value.addEventListener(Event.CHANGE,this.TextFieldOnChange);
         this.FTF_CurCount = this.FScene[CONST_PET.RESOURCE_Link_TF_CurValue];
         this.UILocations();
      }
      
      protected function UILocations() : void
      {
         this.FBtn_Ok.addEventListener(MouseEvent.CLICK,this.OnOk);
         this.FBtn_Cancel.addEventListener(MouseEvent.CLICK,this.OnCancel);
         this.FBtn_Max.addEventListener(MouseEvent.CLICK,this.OnMax);
      }
      
      protected function OnCancel(param1:MouseEvent) : void
      {
         this.Visible = false;
      }
      
      protected function OnOk(param1:MouseEvent) : void
      {
         if(this.FOnClickOk != null)
         {
            this.FOnClickOk(this);
         }
         this.Visible = false;
      }
      
      private function OnMax(param1:MouseEvent) : void
      {
         if(this.FOnSetMax != null)
         {
            this.FOnSetMax(this);
         }
      }
      
      private function TextFieldOnChange(param1:Event) : void
      {
         var _loc2_:int = 0;
         _loc2_ = parseInt(this.FTF_Value.text);
         this.Value = uint(this.FTF_Value.text) > 0 ? int(uint(this.FTF_Value.text)) : 1;
         if(_loc2_ < this.FMin)
         {
            this.FTF_Value.text = this.FMin.toString();
         }
         if(_loc2_ > this.FMax)
         {
            this.FTF_Value.text = this.FMax.toString();
         }
      }
      
      protected function SetLayer() : void
      {
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
      }
      
      public function get Max() : int
      {
         return this.FMax;
      }
      
      public function set Max(param1:int) : void
      {
         this.FMax = param1;
      }
      
      public function get Min() : int
      {
         return this.FMin;
      }
      
      public function set Min(param1:int) : void
      {
         this.FMin = param1;
      }
      
      public function set Value(param1:int) : void
      {
         if(param1 < this.FMin)
         {
            this.FTF_Value.text = this.FMin.toString();
         }
         if(param1 > this.FMax)
         {
            this.FTF_Value.text = this.FMax.toString();
         }
         this.FTF_Value.text = param1.toString();
      }
      
      public function get Value() : int
      {
         return parseInt(this.FTF_Value.text);
      }
      
      public function get OnSetMax() : Function
      {
         return this.FOnSetMax;
      }
      
      public function set OnSetMax(param1:Function) : void
      {
         this.FOnSetMax = param1;
      }
      
      public function get OnClickOk() : Function
      {
         return this.FOnClickOk;
      }
      
      public function set OnClickOk(param1:Function) : void
      {
         this.FOnClickOk = param1;
      }
      
      public function set CurCount(param1:uint) : void
      {
         this.FCurCount = param1;
         if(this.FTF_CurCount != null)
         {
            this.FTF_CurCount.text = param1 + "";
         }
      }
      
      public function get CurCount() : uint
      {
         return this.FCurCount;
      }
      
      public function Init() : void
      {
         this.UIDispatch();
      }
   }
}

