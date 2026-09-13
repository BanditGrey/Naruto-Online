package Processors.Game.Lobby.Exercise.OctActive.Compoents
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.OctActive.TOctActive2;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIWindowExchange extends TProcessorLobbyWindow
   {
      
      public static const SIZE_Window_Width:uint = 466;
      
      public static const SIZE_Window_Height:uint = 278;
      
      protected var FMC_Scene:Sprite;
      
      protected var FTF_Desc:TextField;
      
      protected var FTF_Count:TextField;
      
      protected var FOctActive2:TOctActive2;
      
      protected var FExchangeIndex:int;
      
      protected var FMax:int;
      
      protected var FCount:int;
      
      protected var FOnCancelUp:Function;
      
      protected var FOnOKUp:Function;
      
      public function TUIWindowExchange(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137105);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         super.ResourcesPerform_UIDispatch();
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_OctActiveExchange") as Sprite;
         addChild(this.FMC_Scene);
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FTF_Desc = this.FMC_Scene["TF_Desc"];
         this.FTF_Count = this.FMC_Scene["TF_Count"];
         this.FTF_Count.restrict = "0-9";
         this.FTF_Count.addEventListener(Event.CHANGE,this.OnTextInput,false,0,true);
         TGameUtil.setButtonMode(this.FMC_Scene["BTN_Max"],true);
         this.FMC_Scene["BTN_Max"].addEventListener(MouseEvent.CLICK,this.ProcessorOnMaxUp);
         TGameUtil.setButtonMode(this.FMC_Scene["BTN_OK"],true);
         this.FMC_Scene["BTN_OK"].addEventListener(MouseEvent.CLICK,this.ProcessorOnOKUp);
         TGameUtil.setButtonMode(this.FMC_Scene["BTN_Cancel"],true);
         this.FMC_Scene["BTN_Cancel"].addEventListener(MouseEvent.CLICK,this.ProcessorOnCancelUp);
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         _loc1_ = this.FOctActive2.BoxList[this.FExchangeIndex].Price;
         _loc2_ = this.FOctActive2.BoxList[this.FExchangeIndex].Inventories.GetInventoryByIndex(0).Name;
         this.FMax = this.FOctActive2.MyScore / _loc1_;
         this.FTF_Count.text = this.FCount.toString();
         if(this.FCount <= 0)
         {
            this.FTF_Desc.text = TUtilityString.Format(this.FOctActive2.DescListNew[13],this.FOctActive2.MyScore,1,_loc2_,_loc1_);
         }
         else
         {
            this.FTF_Desc.text = TUtilityString.Format(this.FOctActive2.DescListNew[13],this.FOctActive2.MyScore,this.FCount,_loc2_,this.FCount * _loc1_);
         }
      }
      
      protected function OnTextInput(param1:Event) : void
      {
         var _loc2_:int = 0;
         _loc2_ = parseInt(this.FTF_Count.text);
         this.FCount = Math.min(_loc2_,this.FMax);
         this.UpdateText();
      }
      
      protected function ProcessorOnMaxUp(param1:Event) : void
      {
         this.FCount = this.FMax;
         this.UpdateText();
      }
      
      protected function ProcessorOnOKUp(param1:Event) : void
      {
         if(this.FOnOKUp != null)
         {
            this.FOnOKUp(this.FExchangeIndex,this.FCount);
         }
         Visible = false;
      }
      
      protected function ProcessorOnCancelUp(param1:Event) : void
      {
         if(this.FOnCancelUp != null)
         {
            this.FOnCancelUp();
         }
         Visible = false;
      }
      
      public function get OnCancelUp() : Function
      {
         return this.FOnCancelUp;
      }
      
      public function set OnCancelUp(param1:Function) : void
      {
         this.FOnCancelUp = param1;
      }
      
      public function get OnOKUp() : Function
      {
         return this.FOnOKUp;
      }
      
      public function set OnOKUp(param1:Function) : void
      {
         this.FOnOKUp = param1;
      }
      
      public function UpdateUI(param1:int) : void
      {
         Visible = true;
         this.FExchangeIndex = param1;
         this.FOctActive2 = SLogicsCore.OctActiveDatas.GetActivityByIdentify(2) as TOctActive2;
         this.FCount = 0;
         this.UpdateText();
      }
   }
}

