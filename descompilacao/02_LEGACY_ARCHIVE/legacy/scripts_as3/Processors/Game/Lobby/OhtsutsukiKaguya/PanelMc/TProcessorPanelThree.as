package Processors.Game.Lobby.OhtsutsukiKaguya.PanelMc
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.OhtsutsukiKaguya.CellMc.TPThreeSell;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_OhtsutsukiKaguya;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class TProcessorPanelThree extends TProcessorLobbyWindow
   {
      
      protected static const three:int = 3;
      
      protected var ThisPanel:MovieClip = null;
      
      protected var FMC_Main_Panel:MovieClip = null;
      
      protected var FBtn:SimpleButton = null;
      
      protected var TPThreeSellVec:Vector.<TPThreeSell>;
      
      protected var FBackGetVipFun:Function;
      
      public function TProcessorPanelThree(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(-(CONST_COMMON.STAGE_Width / 2),-(CONST_COMMON.STAGE_Height / 2),CONST_COMMON.STAGE_Width * 2,CONST_COMMON.STAGE_Height * 2);
         this.graphics.endFill();
         this.TPThreeSellVec = new Vector.<TPThreeSell>(three);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_OhtsutsukiKaguya.This_Resource_Id);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         this.ThisPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_OhtsutsukiKaguya.This_CostGold_fream) as MovieClip;
         addChild(this.ThisPanel);
         this.ThisPanel.x = (FUICore.StageWidth - this.ThisPanel.width) / 2;
         this.ThisPanel.y = (FUICore.StageHeight - this.ThisPanel.height) / 2;
         this.FMC_Main_Panel = this.ThisPanel["MC_Main_Panel"];
         this.FBtn = this.ThisPanel["BtnClose"];
         var _loc2_:TPThreeSell = null;
         _loc1_ = 0;
         while(_loc1_ < three)
         {
            _loc2_ = new TPThreeSell();
            _loc2_.SetThisPanel(this.FMC_Main_Panel["childer_" + _loc1_],_loc1_);
            _loc2_.BackOpen = this.BackOpen;
            this.TPThreeSellVec[_loc1_] = _loc2_;
            _loc1_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      public function OpenPanel() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < three)
         {
            this.TPThreeSellVec[_loc1_].Update();
            _loc1_++;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn.addEventListener(MouseEvent.CLICK,this.ClickHandle);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      public function Update() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < three)
         {
            this.TPThreeSellVec[_loc1_].Update();
            _loc1_++;
         }
      }
      
      public function set BackGetVipFun(param1:Function) : void
      {
         this.FBackGetVipFun = param1;
      }
      
      public function get BackGetVipFun() : Function
      {
         return this.FBackGetVipFun;
      }
      
      protected function BackOpen(param1:int) : void
      {
         if(this.FBackGetVipFun != null)
         {
            this.FBackGetVipFun(param1);
         }
      }
      
      public function getThisPanel() : MovieClip
      {
         return this.ThisPanel;
      }
      
      protected function ClickHandle(param1:MouseEvent) : void
      {
         FOnClose(this);
      }
   }
}

