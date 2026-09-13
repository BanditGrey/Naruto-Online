package Processors.Game.Windows.Information
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Resources.Constants.CONST_COMMON;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.utils.Dictionary;
   
   public class TUIWindowBattleSkip
   {
      
      protected static var FIsClickSkip:Boolean;
      
      protected static var BattleSkipStatus:Dictionary = new Dictionary();
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      public function TUIWindowBattleSkip(param1:TUIComponent = null)
      {
         super();
         this.FUIWindowConfirmation = new TUIWindowConfirmation(param1);
      }
      
      public function Perform_UIDispatch() : void
      {
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
      }
      
      public function GetBattleSkipStatus(param1:int) : Boolean
      {
         return BattleSkipStatus[param1];
      }
      
      public function SetBattleSkipStatus(param1:Boolean, param2:int) : void
      {
         BattleSkipStatus[param2] = param1;
      }
      
      public function get IsSelected() : Boolean
      {
         return this.FUIWindowConfirmation.IsSelected;
      }
      
      public function set IsSelected(param1:Boolean) : void
      {
         this.FUIWindowConfirmation.IsSelected = param1;
      }
      
      public function get IsClickSkip() : Boolean
      {
         return FIsClickSkip;
      }
      
      public function set IsClickSkip(param1:Boolean) : void
      {
         FIsClickSkip = param1;
      }
      
      public function set Visible(param1:Boolean) : void
      {
         this.FUIWindowConfirmation.Text = TUtilityString.GetText(80002381);
         this.FUIWindowConfirmation.SetCheckBox(param1);
         this.FUIWindowConfirmation.Visible = param1;
      }
      
      public function set OnOK(param1:Function) : void
      {
         this.FUIWindowConfirmation.OnOK = param1;
      }
      
      public function set OnCancel(param1:Function) : void
      {
         this.FUIWindowConfirmation.OnCancel = param1;
      }
   }
}

