package Processors.Game.Lobby.DialogMsg
{
   import Foundation.UI.TUIComponent;
   import Processors.Game.Windows.Information.TUIWindowInformation;
   import Processors.TProcessor;
   import Resources.Constants.CONST_COMMON;
   import Utilities.UI.Windows.TUtilityUIWindow;
   
   public class TProcessorDialogMsg extends TProcessor
   {
      
      public static var STAGE_Width:Number = CONST_COMMON.STAGE_Width;
      
      public static var STAGE_Height:Number = CONST_COMMON.STAGE_Height;
      
      protected var FUIWindowInformation:TUIWindowInformation;
      
      protected var FClickFun:Function;
      
      public function TProcessorDialogMsg(param1:TUIComponent)
      {
         super(param1);
         this.FUIWindowInformation = new TUIWindowInformation(this);
         this.FUIWindowInformation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowInformation.x = (STAGE_Width - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (STAGE_Height - this.FUIWindowInformation.WindowHeight) / 2;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIWindow.SetupWindowInformation(this.FUIWindowInformation);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      protected function ImportingPerform_Text(param1:String) : void
      {
         this.FUIWindowInformation.Text = param1;
         this.FUIWindowInformation.Visible = true;
      }
      
      protected function WindowInformationOnOK(param1:Object) : void
      {
         this.FUIWindowInformation.Text = "";
         if(this.FClickFun != null)
         {
            this.FClickFun(this);
         }
      }
      
      public function set ClickFun(param1:Function) : void
      {
         this.FClickFun = param1;
      }
      
      public function get ClickFun() : Function
      {
         return this.FClickFun;
      }
      
      public function ImportText(param1:String) : void
      {
         this.ImportingPerform_Text(param1);
      }
   }
}

