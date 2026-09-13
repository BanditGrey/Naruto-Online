package Processors.Game.Lobby.MasterRoad.Components
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TMasterRoadEvent;
   import flash.display.MovieClip;
   
   public class TUIPalaceInfo extends TUIComponent
   {
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMasterRoadEvent:TMasterRoadEvent;
      
      public function TUIPalaceInfo(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function Initialization() : void
      {
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_MasterRoadPalaceInfo") as MovieClip;
         addChild(this.FMC_Scene);
         this.FMC_Scene.TF_Name.text = this.FMasterRoadEvent.name;
         this.FMC_Scene.TF_Desc.text = TUtilityString.Format(this.FMasterRoadEvent.description,this.FMasterRoadEvent.Command);
         this.FMC_Scene.TF_Progress.text = this.FMasterRoadEvent.Progress + "/" + this.FMasterRoadEvent.Command;
         this.FMC_Scene.TF_Score.text = this.FMasterRoadEvent.achievementReward.toString();
         this.FMC_Scene.TF_Reward.text = this.FMasterRoadEvent.getReward.toString();
         if(this.FMasterRoadEvent.Progress >= this.FMasterRoadEvent.Command)
         {
            this.FMC_Scene.filters = [];
            this.FMC_Scene.MC_Got.visible = true;
         }
         else
         {
            this.FMC_Scene.filters = [TGameUtil.GaryColorFilters];
            this.FMC_Scene.MC_Got.visible = false;
         }
      }
      
      public function Init(param1:TMasterRoadEvent) : void
      {
         this.FMasterRoadEvent = param1;
         this.Initialization();
      }
   }
}

