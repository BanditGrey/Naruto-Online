package Processors.Game.Lobby.Exercise.UnlockGift
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Agent.SParametersNewCore;
   import Logics.Inventories.TInventory;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorUnlockGift extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_Window_Width:uint = 459;
      
      protected static const SIZE_Window_Height:uint = 410;
      
      protected static const STR_1:int = 70420036;
      
      protected static const STR_2:int = 70420037;
      
      protected static const STR_3:int = 70420038;
      
      protected static const CONFIRM:String = "BTN_Confirm";
      
      protected static const EDIT:String = "BTN_Edit";
      
      protected static const PASSWORD_MIN:int = 6;
      
      protected static const PASSWORD_MAX:int = 12;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FTF_Password0:TextField;
      
      protected var FTF_Password1:TextField;
      
      protected var FTF_Password2:TextField;
      
      protected var FTF_Password3:TextField;
      
      protected var FOnClickBtn:Function;
      
      protected var FInventory:TInventory;
      
      protected var FOnEffectGenerateText:Function;
      
      public function TProcessorUnlockGift(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(436207617);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_unlockGift") as MovieClip;
         addChild(this.FMC_Scene);
         this.FTF_Password0 = this.FMC_Scene.MC_Main0.TF_Password0;
         this.FTF_Password0.restrict = "a-zA-Z0-9";
         this.FTF_Password1 = this.FMC_Scene.MC_Main0.TF_Password1;
         this.FTF_Password1.restrict = "a-zA-Z0-9";
         TGameUtil.setButtonMode(this.FMC_Scene.MC_Main0.BTN_Confirm,true);
         TGameUtil.setButtonMode(this.FMC_Scene.MC_Main0.BTN_Edit,true);
         this.FMC_Scene.MC_Main0.BTN_Confirm.addEventListener(MouseEvent.CLICK,this.ProcessorOnHandleClick);
         this.FMC_Scene.MC_Main0.btn_close.addEventListener(MouseEvent.CLICK,this.ProcessorCloseWindow);
         this.FMC_Scene.MC_Main0.BTN_Edit.addEventListener(MouseEvent.CLICK,this.ProcessorOnHandleClick);
         this.FMC_Scene.MC_Edit.BTN_HideEdit.addEventListener(MouseEvent.CLICK,this.ProcessorCloseWindow);
         this.FTF_Password2 = this.FMC_Scene.MC_Edit.TF_Password4;
         this.FTF_Password2.restrict = "a-zA-Z0-9";
         this.FTF_Password2.mouseEnabled = false;
         this.FTF_Password3 = this.FMC_Scene.MC_Edit.TF_Password5;
         this.FTF_Password3.restrict = "a-zA-Z0-9";
         this.FTF_Password3.mouseEnabled = false;
      }
      
      protected function UpdateUI() : void
      {
         this.FMC_Scene.MC_Main0.visible = true;
         this.FMC_Scene.MC_Edit.visible = false;
         this.FTF_Password0.text = "";
         this.FTF_Password1.text = "";
         this.FTF_Password2.text = SParametersNewCore.CollectEmail;
         this.FTF_Password3.text = SParametersNewCore.CollectPswd;
      }
      
      protected function ProcessorOnHandleClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         switch(param1.currentTarget.name)
         {
            case CONFIRM:
               if(TUtilityString.Empty(this.FTF_Password0.text) || TUtilityString.Empty(this.FTF_Password1.text))
               {
                  this.FOnEffectGenerateText(this,"Please fill in the complete information");
                  return;
               }
               if(this.FTF_Password0.text != SParametersNewCore.CollectEmail || this.FTF_Password1.text != SParametersNewCore.CollectPswd)
               {
                  this.FOnEffectGenerateText(this,"Security account does not match. Please reenter.If you forget, click help");
                  return;
               }
               if(this.FTF_Password0.text == SParametersNewCore.CollectEmail && this.FTF_Password1.text == SParametersNewCore.CollectPswd)
               {
                  this.ProcessorOnGetBoxUp();
               }
               break;
            case EDIT:
               this.FMC_Scene.MC_Edit.visible = true;
               this.FMC_Scene.MC_Main0.visible = false;
         }
      }
      
      protected function ProcessorCloseWindow(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function ProcessorOnGetBoxUp() : void
      {
         if(this.FOnClickBtn != null)
         {
            this.FOnClickBtn(this.FInventory,"");
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.UpdateUI();
         this.Visible = true;
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
      
      public function get WindowWidth() : int
      {
         return SIZE_Window_Width;
      }
      
      public function get WindowHeight() : int
      {
         return SIZE_Window_Height;
      }
      
      public function set OnClickBtn(param1:Function) : void
      {
         this.FOnClickBtn = param1;
      }
      
      public function set Inventory(param1:TInventory) : void
      {
         this.FInventory = param1;
      }
      
      public function set OnEffectGenerateText(param1:Function) : void
      {
         this.FOnEffectGenerateText = param1;
      }
   }
}

