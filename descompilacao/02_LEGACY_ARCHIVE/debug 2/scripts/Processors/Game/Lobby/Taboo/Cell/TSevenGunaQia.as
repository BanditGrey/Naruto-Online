package Processors.Game.Lobby.Taboo.Cell
{
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TTabooBattleConfig;
   import Logics.SLogicsCore;
   import Resources.Strings.STRING_TABOO;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TSevenGunaQia
   {
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FTF_GuanQia_Name:TextField = null;
      
      protected var FMC_Changeed:MovieClip = null;
      
      protected var FTF_GuanQia_OpenLevel:TextField = null;
      
      protected var FConfigInformation:TTabooBattleConfig = null;
      
      protected var FCurIndex:int;
      
      protected var FThisPanelClick:Function = null;
      
      protected var FThisPanelOver:Function = null;
      
      protected var FThisPanelOut:Function = null;
      
      protected var FThisPanelMove:Function = null;
      
      public function TSevenGunaQia()
      {
         super();
      }
      
      public function SetPanel(param1:MovieClip, param2:int) : void
      {
         this.FThisPanel = param1;
         this.FCurIndex = param2;
         this.FThisPanel.gotoAndStop(this.FCurIndex);
         this.Initilization();
      }
      
      protected function Initilization() : void
      {
         this.FTF_GuanQia_Name = this.FThisPanel["TF_GuanQia_Name"];
         this.FTF_GuanQia_OpenLevel = this.FThisPanel["TF_GuanQia_OpenLevel"];
         this.FThisPanel.addEventListener(MouseEvent.CLICK,this.MoClick);
         this.FThisPanel.addEventListener(MouseEvent.MOUSE_OVER,this.MoOver);
         this.FThisPanel.addEventListener(MouseEvent.MOUSE_OUT,this.MoOut);
         this.FThisPanel.addEventListener(MouseEvent.MOUSE_MOVE,this.MoMove);
      }
      
      protected function UpdateBaseInforMation() : void
      {
         this.FTF_GuanQia_OpenLevel.text = TUtilityString.Format(STRING_TABOO.Str5,SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevel(this.FConfigInformation.OpenLevel));
         this.FTF_GuanQia_Name.text = this.FConfigInformation.CampaignName;
      }
      
      public function UpdateInforMation() : void
      {
         this.FThisPanel.filters = [];
         if(SLogicsCore.TBooData.CurSceneCode == this.FCurIndex || SLogicsCore.TBooData.CurSceneCode == 0)
         {
            this.FThisPanel.buttonMode = true;
            if(SLogicsCore.Character.MainHero.Level >= this.FConfigInformation.OpenLevel)
            {
               this.FThisPanel.gotoAndStop(this.FCurIndex);
            }
            else
            {
               this.FThisPanel.buttonMode = false;
               this.FThisPanel.gotoAndStop(this.FCurIndex + 7);
            }
         }
         else
         {
            this.FThisPanel.buttonMode = false;
            if(SLogicsCore.Character.MainHero.Level >= this.FConfigInformation.OpenLevel)
            {
               this.FThisPanel.filters = [TGameUtil.GaryColorFilters];
            }
            else
            {
               this.FThisPanel.gotoAndStop(this.FCurIndex + 7);
            }
         }
         this.FMC_Changeed = this.FThisPanel["MC_Changeed"];
         this.FMC_Changeed.mouseEnabled = false;
         this.FMC_Changeed.visible = false;
         if(SLogicsCore.TBooData.CurSceneCode == this.FCurIndex)
         {
            this.FMC_Changeed.visible = true;
         }
      }
      
      protected function MoOver(param1:MouseEvent) : void
      {
         if(this.FThisPanelOver != null)
         {
            if(!this.FConfigInformation.MissionTips)
            {
               return;
            }
            this.FThisPanelOver(this.FConfigInformation.MissionTips);
         }
      }
      
      protected function MoOut(param1:MouseEvent) : void
      {
         if(this.FThisPanelOut != null)
         {
            this.FThisPanelOut();
         }
      }
      
      protected function MoMove(param1:MouseEvent) : void
      {
         if(this.FThisPanelMove != null)
         {
            this.FThisPanelMove();
         }
      }
      
      protected function MoClick(param1:MouseEvent) : void
      {
         if(!this.FThisPanel.buttonMode)
         {
            return;
         }
         this.FThisPanelClick(this.FCurIndex,this.FConfigInformation);
      }
      
      public function set ThisPanelMove(param1:Function) : void
      {
         this.FThisPanelMove = param1;
      }
      
      public function set ThisPanelOut(param1:Function) : void
      {
         this.FThisPanelOut = param1;
      }
      
      public function set ThisPanelOver(param1:Function) : void
      {
         this.FThisPanelOver = param1;
      }
      
      public function set ThisPanelClick(param1:Function) : void
      {
         this.FThisPanelClick = param1;
      }
      
      public function set ConfigInformation(param1:TTabooBattleConfig) : void
      {
         this.FConfigInformation = param1;
         this.UpdateBaseInforMation();
      }
      
      public function get ConfigInformation() : TTabooBattleConfig
      {
         return this.FConfigInformation;
      }
   }
}

