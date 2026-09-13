package Processors.Game.Lobby.BloodFete.cell
{
   import Foundation.Utilities.TGameUtil;
   import Logics.BloodFete.TBloodFeteData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class GetBloodFeteFiveBtn
   {
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FMC_Call:MovieClip = null;
      
      protected var FMc_select:MovieClip = null;
      
      protected var FFT_Scr:MovieClip = null;
      
      protected var FCurIndex:int;
      
      protected var Fmc_highlight:MovieClip = null;
      
      protected var FMC_HeadImage:MovieClip = null;
      
      protected var FMouseRollStatus:int;
      
      protected var FThisPanelIsBright:Boolean;
      
      protected var FIsCanClick:int = 0;
      
      protected var FBloodFeteData:TBloodFeteData = null;
      
      protected var FMC_CallF:Function = null;
      
      protected var FThisPanelClick:Function = null;
      
      protected var FM_C_F:Function = null;
      
      protected var FO_V_F:Function = null;
      
      protected var FO_U_F:Function = null;
      
      public function GetBloodFeteFiveBtn()
      {
         super();
      }
      
      protected function AddEventListener() : void
      {
         this.FThisPanel.addEventListener(MouseEvent.CLICK,this.OnPanelClick);
         this.FThisPanel.addEventListener(MouseEvent.MOUSE_OVER,this.OverClick);
         this.FThisPanel.addEventListener(MouseEvent.MOUSE_OUT,this.OutClick);
         this.FThisPanel.addEventListener(MouseEvent.MOUSE_MOVE,this.MoveClick);
      }
      
      protected function setVisibel(param1:Boolean) : void
      {
         this.FThisPanel.buttonMode = param1;
         TGameUtil.setButtonMode(this.FMC_Call,param1);
      }
      
      protected function Set_Call_true_false(param1:Boolean) : void
      {
         this.FMC_Call.visible = param1;
         this.FFT_Scr.visible = param1;
      }
      
      protected function OnPanelClick(param1:MouseEvent) : void
      {
         if(!this.FIsCanClick)
         {
            return;
         }
         this.FIsCanClick = 0;
         if(this.FCurIndex == 3 && this.FBloodFeteData.FiveState[this.FCurIndex] == 1)
         {
            if(this.FMC_CallF != null)
            {
               this.FMC_CallF(this.FCurIndex);
            }
         }
         else if(this.FThisPanel.buttonMode)
         {
            if(this.FThisPanelClick != null)
            {
               this.FThisPanelClick(this.FCurIndex);
            }
         }
      }
      
      protected function MoveClick(param1:MouseEvent) : void
      {
         if(this.FM_C_F != null)
         {
            this.FM_C_F(this.FCurIndex);
         }
      }
      
      protected function OverClick(param1:MouseEvent) : void
      {
         this.FMouseRollStatus = 1;
         this.FMc_select.visible = true;
         if(!this.FMC_Call.visible)
         {
            this.FO_V_F(this.FCurIndex,7);
            return;
         }
         if(this.FCurIndex != 3)
         {
            return;
         }
         if(this.FO_V_F != null)
         {
            this.FO_V_F(this.FCurIndex);
         }
      }
      
      protected function OutClick(param1:MouseEvent) : void
      {
         this.FMouseRollStatus = 0;
         this.FMc_select.visible = false;
         if(this.FO_U_F != null)
         {
            this.FO_U_F(this.FCurIndex);
         }
      }
      
      public function get ThisPanelIsBright() : Boolean
      {
         return this.FThisPanelIsBright;
      }
      
      public function set MC_CallF(param1:Function) : void
      {
         this.FMC_CallF = param1;
      }
      
      public function set ThisPanelClick(param1:Function) : void
      {
         this.FThisPanelClick = param1;
      }
      
      public function set M_C_F(param1:Function) : void
      {
         this.FM_C_F = param1;
      }
      
      public function set O_V_F(param1:Function) : void
      {
         this.FO_V_F = param1;
      }
      
      public function set O_U_F(param1:Function) : void
      {
         this.FO_U_F = param1;
      }
      
      public function set IsCanClick(param1:int) : void
      {
         this.FIsCanClick = param1;
      }
      
      public function get IsCanClick() : int
      {
         return this.FIsCanClick;
      }
      
      public function SetThisPanel(param1:MovieClip, param2:int, param3:TBloodFeteData) : void
      {
         this.FThisPanel = param1;
         this.FCurIndex = param2;
         this.FBloodFeteData = param3;
         this.FMC_Call = this.FThisPanel["MC_Call"];
         this.FMc_select = this.FThisPanel["mc_select"];
         this.FFT_Scr = this.FThisPanel["FT_Scr"];
         this.FMC_HeadImage = this.FThisPanel["MC_HeadImage"];
         this.Fmc_highlight = this.FThisPanel["mc_highlight"];
         this.Fmc_highlight.visible = false;
         TGameUtil.setButtonMode(this.FMC_Call,true);
         this.AddEventListener();
         this.FMc_select.mouseEnabled = false;
         this.FFT_Scr.mouseEnabled = false;
         this.FMC_HeadImage.mouseEnabled = false;
         this.Fmc_highlight.mouseEnabled = false;
         this.FMc_select.visible = false;
         this.FMC_HeadImage.gotoAndStop(this.FCurIndex + 1);
      }
      
      public function UpdateState() : void
      {
         if(this.FBloodFeteData.FiveState[this.FCurIndex])
         {
            this.FThisPanel.buttonMode = false;
            this.FThisPanelIsBright = false;
            this.Fmc_highlight.visible = false;
            this.FMC_HeadImage.filters = [TGameUtil.GaryColorFilters];
         }
         else
         {
            this.FThisPanel.buttonMode = true;
            this.Fmc_highlight.visible = true;
            this.FMC_HeadImage.filters = [];
            this.FThisPanelIsBright = true;
         }
         this.Set_Call_true_false(false);
         if(this.FCurIndex == 3)
         {
            this.Set_Call_true_false(false);
            if(!this.FThisPanelIsBright)
            {
               this.Set_Call_true_false(true);
            }
         }
         this.FIsCanClick = 1;
      }
      
      public function UpdateOnline() : void
      {
         if(this.FMouseRollStatus)
         {
            this.OverClick(null);
         }
      }
   }
}

