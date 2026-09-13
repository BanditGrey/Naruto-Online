package Processors.Game.Lobby.LostShenqi.LittleShiJianPanel
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TProcessorTiaoZhanShiBai extends TProcessorLobbyWindow
   {
      
      protected var FThisPanel:MovieClip;
      
      protected var FIsInilization:Boolean;
      
      protected var FMC_ShiBai:MovieClip;
      
      protected var FBackFunction:Function;
      
      public function TProcessorTiaoZhanShiBai(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(0,0,FUICore.StageWidth,FUICore.StageHeight);
         this.graphics.endFill();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_TiaoZhanShiBai") as MovieClip;
         addChild(this.FThisPanel);
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         this.FMC_ShiBai = this.FThisPanel["MC_ShiBai"];
         this.FIsInilization = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      public function OpenThisPanel() : void
      {
         TGameUtil.setButtonMode(this.FMC_ShiBai,true);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_ShiBai.addEventListener(MouseEvent.CLICK,this.HandleClick);
         super.ResourcesPerform_UILocations();
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_ShiBai:
               if(!this.FMC_ShiBai.buttonMode)
               {
                  return;
               }
               if(this.FBackFunction != null)
               {
                  this.FBackFunction(100);
               }
         }
      }
      
      public function set BackFunction(param1:Function) : void
      {
         this.FBackFunction = param1;
      }
   }
}

