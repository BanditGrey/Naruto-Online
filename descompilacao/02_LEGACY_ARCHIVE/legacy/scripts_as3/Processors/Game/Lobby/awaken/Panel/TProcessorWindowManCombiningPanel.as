package Processors.Game.Lobby.awaken.Panel
{
   import Components.Standard.TUITab;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_AWAKEN;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowManCombiningPanel extends TProcessorGame
   {
      
      protected var FThisPanel:Sprite = null;
      
      protected var FMC_Close:SimpleButton;
      
      protected var FMC_Help:SimpleButton;
      
      protected var FUITab:TUITab;
      
      protected var FCurTabIndex:int;
      
      protected var FProcessorLittleFenJieView:TProcessorLittleFenJieView = null;
      
      protected var FProcessorLittleHeChengView:TProcessorLittleHeChengView = null;
      
      protected var FCloseFunction:Function = null;
      
      protected var FBtnClickBack:Function = null;
      
      protected var BtnAutoClick:Function;
      
      protected var FBackOver:Function;
      
      protected var FBackOut:Function;
      
      protected var FBackMove:Function;
      
      public function TProcessorWindowManCombiningPanel(param1:TUIComponent)
      {
         super(param1);
         this.FUITab = new TUITab(this);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_AWAKEN.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_CombiningAndResolve") as Sprite;
         this.addChild(this.FThisPanel);
         this.x = (FUICore.StageWidth - this.width) / 2;
         this.y = (FUICore.StageHeight - this.height) / 2;
         this.FMC_Help = this.FThisPanel["MC_Help"];
         this.FMC_Close = this.FThisPanel["MC_Close"];
         this.FProcessorLittleFenJieView = new TProcessorLittleFenJieView(this);
         this.FProcessorLittleFenJieView.BtnClickBack = this.TwoPanelBack;
         this.FProcessorLittleFenJieView.BackMove = this.FBackMove;
         this.FProcessorLittleFenJieView.BackOut = this.FBackOut;
         this.FProcessorLittleFenJieView.BackOver = this.FBackOver;
         new Tools_Help(Parent,this.FMC_Help,70170090,FUICore);
         this.FProcessorLittleFenJieView.SetPanel(this.FThisPanel["MC_FenJie"]);
         this.FProcessorLittleHeChengView = new TProcessorLittleHeChengView(this);
         this.FProcessorLittleHeChengView.BtnClickBack = this.TwoPanelBack;
         this.FProcessorLittleHeChengView.BackMove = this.FBackMove;
         this.FProcessorLittleHeChengView.BackOut = this.FBackOut;
         this.FProcessorLittleHeChengView.BackOver = this.FBackOver;
         this.FProcessorLittleHeChengView.SetPanel(this.FThisPanel["MC_TabHeCheng"]);
         this.FUITab.SetTabByIndex(this.FThisPanel["MC_Tab_0"],0);
         this.FUITab.SetTabByIndex(this.FThisPanel["MC_Tab_1"],1);
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.AddEventlistener();
         super.ResourcesPerform_UILocations();
      }
      
      public function LogicPerform() : void
      {
         super.LogicsPerform();
      }
      
      protected function AddEventlistener() : void
      {
         this.FMC_Close.addEventListener(MouseEvent.CLICK,this.HandleClick);
         super.LogicsPerform();
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FCurTabIndex = param1 as int;
         this.ChangePanel(this.FCurTabIndex);
      }
      
      protected function ChangePanel(param1:int) : void
      {
         this.FProcessorLittleFenJieView.ThisPanel.visible = false;
         this.FProcessorLittleHeChengView.ThisPanel.visible = false;
         switch(param1)
         {
            case 0:
               this.FProcessorLittleHeChengView.ThisPanel.visible = true;
               this.FProcessorLittleHeChengView.OpenThisPanel();
               break;
            case 1:
               this.FProcessorLittleFenJieView.ThisPanel.visible = true;
               this.FProcessorLittleFenJieView.OpenThisPanel();
         }
      }
      
      public function UpdateFenJieView() : void
      {
         this.FProcessorLittleFenJieView.CurNeedFenJieDate = null;
         this.FProcessorLittleFenJieView.SetValueForVec();
         this.FProcessorLittleFenJieView.UpdateFenJieView();
         this.FProcessorLittleHeChengView.SetFCurNeedHeChengDate();
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_Close:
               this.visible = false;
         }
      }
      
      public function OpenThisPanel() : void
      {
         this.FCurTabIndex = 0;
         this.ChangePanel(this.FCurTabIndex);
         this.FUITab.SwithTagManual(0);
      }
      
      public function UpdateImage() : void
      {
         if(!this.visible)
         {
            return;
         }
         this.FProcessorLittleFenJieView.UpdateImage();
         this.FProcessorLittleHeChengView.UpdateImage();
      }
      
      protected function TwoPanelBack(param1:int, param2:int, param3:int, param4:String, param5:int, param6:int = 0) : void
      {
         if(this.FBtnClickBack != null)
         {
            this.FBtnClickBack(param1,param2,param3,param4,param5,param6);
         }
      }
      
      public function set BtnClickBack(param1:Function) : void
      {
         this.FBtnClickBack = param1;
      }
      
      public function set BackOver(param1:Function) : void
      {
         this.FBackOver = param1;
      }
      
      public function set BackOut(param1:Function) : void
      {
         this.FBackOut = param1;
      }
      
      public function set BackMove(param1:Function) : void
      {
         this.FBackMove = param1;
      }
   }
}

