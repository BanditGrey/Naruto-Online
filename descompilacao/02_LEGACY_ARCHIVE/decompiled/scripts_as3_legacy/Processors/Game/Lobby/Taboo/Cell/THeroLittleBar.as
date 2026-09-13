package Processors.Game.Lobby.Taboo.Cell
{
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.THero;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_TABOO;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class THeroLittleBar extends Sprite
   {
      
      protected var ThisPanel:MovieClip = null;
      
      protected var TF_Name:TextField = null;
      
      protected var FMC_Nimei:MovieClip = null;
      
      protected var FCurData:THero = null;
      
      protected var FThisPanelClick:Function = null;
      
      protected var FThisPanelMove:Function = null;
      
      protected var FThisPanelOut:Function = null;
      
      public function THeroLittleBar()
      {
         super();
         this.LoadFla();
      }
      
      protected function LoadFla() : void
      {
         this.ThisPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_TABOO.MC_LittlePanel) as MovieClip;
         this.addChild(this.ThisPanel);
         this.ThisPanel.buttonMode = true;
         this.TF_Name = this.ThisPanel["TF_Name"];
         this.FMC_Nimei = this.ThisPanel["MC_Nimei"];
         this.TF_Name.mouseEnabled = false;
         this.addEventListener(MouseEvent.CLICK,this.ThisClcik);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.ThisMove);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.ThisOut);
      }
      
      public function SetData(param1:THero) : void
      {
         this.FCurData = param1;
         this.UpdateView();
      }
      
      protected function UpdateView() : void
      {
         this.TF_Name.text = this.FCurData.Name;
         this.TF_Name.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[this.FCurData.Quality];
      }
      
      public function set ThisPanelOut(param1:Function) : void
      {
         this.FThisPanelOut = param1;
      }
      
      public function set ThisPanelMove(param1:Function) : void
      {
         this.FThisPanelMove = param1;
      }
      
      public function set ThisPanelClick(param1:Function) : void
      {
         this.FThisPanelClick = param1;
      }
      
      protected function ThisMove(param1:MouseEvent) : void
      {
         this.FMC_Nimei.gotoAndStop(2);
      }
      
      protected function ThisOut(param1:MouseEvent) : void
      {
         this.FMC_Nimei.gotoAndStop(1);
      }
      
      protected function ThisClcik(param1:MouseEvent) : void
      {
         if(this.FThisPanelClick != null)
         {
            this.FThisPanelClick(this.FCurData);
         }
      }
   }
}

