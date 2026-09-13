package Processors.Game.Lobby.Emblem.Component
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Emblem.TProcessorEmblem;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TUIEmblemPromptFrame extends TProcessorLobbyWindow
   {
      
      protected var FMC_Scene:MovieClip = null;
      
      protected var FCallback:Function;
      
      protected var FCount:int;
      
      protected var FMaxCount:int = 10;
      
      protected var FGetExpValue:int;
      
      public var ProcessorEmblem:TProcessorEmblem;
      
      public function TUIEmblemPromptFrame(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_UpgradePrompt") as MovieClip;
         this.FMC_Scene.x = (FUICore.StageWidth - this.FMC_Scene.width) / 2;
         this.FMC_Scene.y = (FUICore.StageHeight - this.FMC_Scene.height) / 2;
         this.addChild(this.FMC_Scene);
         var _loc1_:TConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Emblem) as TConfigValue;
         this.FGetExpValue = _loc1_.Value[1];
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_Scene.TF_Count.addEventListener(Event.CHANGE,this.OnCountChange);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Left,true);
         this.FMC_Scene.BTN_Left.addEventListener(MouseEvent.CLICK,this.OnLeftClick);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Right,true);
         this.FMC_Scene.BTN_Right.addEventListener(MouseEvent.CLICK,this.OnRightClick);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Max,true);
         this.FMC_Scene.BTN_Max.addEventListener(MouseEvent.CLICK,this.OnMaxClick);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Confirm,true);
         this.FMC_Scene.BTN_Confirm.addEventListener(MouseEvent.CLICK,this.OnConfirmClick);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Cancel,true);
         this.FMC_Scene.BTN_Cancel.addEventListener(MouseEvent.CLICK,this.OnCancelClick);
         super.ResourcesPerform_UILocations();
      }
      
      public function ShowPrompt(param1:Function) : void
      {
         this.visible = true;
         this.FCallback = param1;
         this.FMaxCount = this.ProcessorEmblem.getInventoryById();
         this.Count = 1;
      }
      
      private function OnCountChange(param1:Event) : void
      {
         this.Count = this.FMC_Scene.TF_Count.text;
      }
      
      private function OnLeftClick(param1:MouseEvent) : void
      {
         --this.Count;
      }
      
      private function OnRightClick(param1:MouseEvent) : void
      {
         ++this.Count;
      }
      
      private function OnMaxClick(param1:MouseEvent) : void
      {
         this.Count = this.FMaxCount;
      }
      
      private function OnConfirmClick(param1:MouseEvent) : void
      {
         if(this.FCallback != null)
         {
            this.FCallback(this.Count);
         }
         this.visible = false;
      }
      
      private function OnCancelClick(param1:MouseEvent) : void
      {
         this.visible = false;
      }
      
      public function get Count() : int
      {
         return this.FCount;
      }
      
      public function set Count(param1:int) : void
      {
         this.FCount = Math.max(1,param1);
         this.FCount = Math.min(this.FMaxCount,this.FCount);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Left,this.FCount > 1);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Right,this.FCount < this.FMaxCount);
         this.FMC_Scene.TF_Count.text = this.FCount;
         this.FMC_Scene.TF_Desc.text = TUtilityString.Format(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_Emblem_05),this.FCount,this.FGetExpValue * this.FCount);
      }
   }
}

