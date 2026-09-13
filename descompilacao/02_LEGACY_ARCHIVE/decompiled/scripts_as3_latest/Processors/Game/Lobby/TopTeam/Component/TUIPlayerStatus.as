package Processors.Game.Lobby.TopTeam.Component
{
   import Foundation.UI.TUIComponent;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Processors.Game.Lobby.GroupBattle.Component.TUIHeroStatusInfo;
   import flash.display.MovieClip;
   
   public class TUIPlayerStatus extends TProcessorUIResourceTemplate
   {
      
      protected var FUIHeroStatusInfo:TUIHeroStatusInfo;
      
      protected var FMC_Position:MovieClip;
      
      public function TUIPlayerStatus(param1:TUIComponent)
      {
         super(param1);
         this.FUIHeroStatusInfo = new TUIHeroStatusInfo(this);
      }
      
      override protected function UIDispatch() : void
      {
         this.FUIHeroStatusInfo.Resource = FResource;
         this.FMC_Position = FResource["MC_Position"];
         this.FMC_Position.gotoAndStop(FTag + 1);
         this.FUIHeroStatusInfo.Init();
      }
      
      override protected function UpdateUI() : void
      {
         this.FUIHeroStatusInfo.Context = FContext;
         this.FUIHeroStatusInfo.UpdateTopTeamInfo();
      }
   }
}

