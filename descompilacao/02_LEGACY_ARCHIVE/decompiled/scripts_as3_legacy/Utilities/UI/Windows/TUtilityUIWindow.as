package Utilities.UI.Windows
{
   import Foundation.Utilities.TUtilityReflection;
   import Processors.Game.Windows.Editors.TUIWindowEditor;
   import Processors.Game.Windows.Editors.TUIWindowEditorString;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowDailyActivityNotify;
   import Processors.Game.Windows.Information.TUIWindowInformation;
   import Processors.Game.Windows.Information.TUIWindowInformationNew;
   import Processors.Game.Windows.Information.TUIWindowMaterialCost;
   import Processors.Game.Windows.Information.TUIWindowPromptFrame;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Processors.Game.Windows.Input.TUIWindowInputPassword;
   import Processors.Game.Windows.Input.TUIWindowInputString;
   import Processors.Game.Windows.Input.TUIWindowSeekRoom;
   import Resources.Constants.CONST_COMMON;
   import flash.display.Sprite;
   
   public class TUtilityUIWindow
   {
      
      public function TUtilityUIWindow()
      {
         super();
      }
      
      protected static function ResourcesDispatchWindowInformation(param1:TUIWindowInformation) : void
      {
         param1.Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_Information) as Sprite;
         param1.Init();
      }
      
      protected static function ResourcesDispatchWindowInformationNew(param1:TUIWindowInformationNew) : void
      {
         param1.Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_Information) as Sprite;
         param1.Init();
      }
      
      protected static function ResourcesDispatchWindowConfirmation(param1:TUIWindowConfirmation) : void
      {
         param1.Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_Confirmation) as Sprite;
         param1.Init();
      }
      
      protected static function ResourcesDispatchWindowEditor(param1:TUIWindowEditor) : void
      {
         param1.Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_Editor) as Sprite;
         param1.Init();
      }
      
      protected static function ResourcesDispatchWindowEditorString(param1:TUIWindowEditorString) : void
      {
         param1.Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_EditorString) as Sprite;
         param1.Init();
      }
      
      protected static function ResourcesDispatchWindowRecharge(param1:TUIWindowRecharge) : void
      {
         param1.Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_GotoRecharge) as Sprite;
         param1.Init();
      }
      
      protected static function ResourcesDispatchWindowInputString(param1:TUIWindowInputString) : void
      {
         param1.Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_InputString) as Sprite;
         param1.Init();
      }
      
      public static function ResourcesDispatchWindowDesString(param1:Sprite) : void
      {
         param1 = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_InputString) as Sprite;
      }
      
      protected static function ResourcesDispatchWindowInputPassword(param1:TUIWindowInputPassword) : void
      {
         param1.Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_InputPassword) as Sprite;
         param1.Init();
      }
      
      protected static function ResourcesDispatchWindowSeekRoom(param1:TUIWindowSeekRoom) : void
      {
         param1.Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_SeekRoom) as Sprite;
         param1.Init();
      }
      
      protected static function ResourcesDispatchWindowActivityNotify(param1:TUIWindowDailyActivityNotify) : void
      {
         param1.Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ActivityNotify) as Sprite;
         param1.Init();
      }
      
      protected static function ResourcesDispatchWindowMaterialCost(param1:TUIWindowMaterialCost) : void
      {
         param1.Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_MaterialCost) as Sprite;
         param1.Init();
      }
      
      protected static function ResourcesDispatchWindowPromptFrame(param1:TUIWindowPromptFrame) : void
      {
         param1.Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_PromptFrame) as Sprite;
         param1.Init();
      }
      
      public static function SetupWindowInformation(param1:TUIWindowInformation) : void
      {
         ResourcesDispatchWindowInformation(param1);
      }
      
      public static function SetupWindowInformationNew(param1:TUIWindowInformationNew) : void
      {
         ResourcesDispatchWindowInformationNew(param1);
      }
      
      public static function SetupWindowConfirmation(param1:TUIWindowConfirmation) : void
      {
         ResourcesDispatchWindowConfirmation(param1);
      }
      
      public static function SetupWindowEditor(param1:TUIWindowEditor) : void
      {
         ResourcesDispatchWindowEditor(param1);
      }
      
      public static function SetupWindowEditorString(param1:TUIWindowEditorString) : void
      {
         ResourcesDispatchWindowEditorString(param1);
      }
      
      public static function SetupWindowRecharge(param1:TUIWindowRecharge) : void
      {
         ResourcesDispatchWindowRecharge(param1);
      }
      
      public static function SetupWindowInputString(param1:TUIWindowInputString) : void
      {
         ResourcesDispatchWindowInputString(param1);
      }
      
      public static function SetupWindowPassword(param1:TUIWindowInputPassword) : void
      {
         ResourcesDispatchWindowInputPassword(param1);
      }
      
      public static function SetupWindowSeekRoom(param1:TUIWindowSeekRoom) : void
      {
         ResourcesDispatchWindowSeekRoom(param1);
      }
      
      public static function SetupWindowActivityNotify(param1:TUIWindowDailyActivityNotify) : void
      {
         ResourcesDispatchWindowActivityNotify(param1);
      }
      
      public static function SetupWindowMaterialCost(param1:TUIWindowMaterialCost) : void
      {
         ResourcesDispatchWindowMaterialCost(param1);
      }
      
      public static function SetupWindowPromptFrame(param1:TUIWindowPromptFrame) : void
      {
         ResourcesDispatchWindowPromptFrame(param1);
      }
   }
}

