package Processors.Game.Lobby.Alien.cell
{
   import Foundation.Utilities.TGameUtil;
   import Logics.Alien.TAlien;
   import Resources.Strings.STRING_MAGIC;
   import Resources.Strings.STRING_TONGLING;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class AlienCell
   {
      
      private var FthisPanel:MovieClip;
      
      private var TF_Name:TextField;
      
      private var TF_Status:TextField;
      
      private var FClickFun:Function;
      
      private var FOverFun:Function;
      
      private var FOutFun:Function;
      
      private var FIdentifier:int;
      
      public function AlienCell()
      {
         super();
      }
      
      public function setPanel(param1:MovieClip) : void
      {
         this.FthisPanel = param1;
         this.initView();
      }
      
      private function initView() : void
      {
         this.TF_Name = this.FthisPanel["mc_Name"]["TF_Name"];
         this.TF_Status = this.FthisPanel["mc_status"]["TF_Status"];
         this.FthisPanel.buttonMode = true;
         this.FthisPanel.mouseChildren = false;
         this.FthisPanel.addEventListener(MouseEvent.MOUSE_MOVE,this.HandleOver);
         this.FthisPanel.addEventListener(MouseEvent.MOUSE_OUT,this.HandleOut);
         this.FthisPanel.addEventListener(MouseEvent.CLICK,this.HandleClick);
      }
      
      public function setCellInfo(param1:TAlien) : void
      {
         this.FIdentifier = param1.Id;
         if(param1.Status == 0)
         {
            this.FthisPanel.filters = [TGameUtil.GaryColorFilters];
            this.TF_Status.text = STRING_MAGIC.STRING_Locked;
            this.TF_Name.text = "";
         }
         else if(param1.Status == 1)
         {
            this.FthisPanel.filters = [];
            this.TF_Status.text = STRING_TONGLING.TONGLING_36;
            this.TF_Name.text = "";
         }
         else
         {
            this.FthisPanel.filters = [];
            this.TF_Status.text = "";
            this.TF_Name.text = param1.NamePart;
         }
      }
      
      private function HandleOver(param1:MouseEvent) : void
      {
         if(this.FOverFun != null)
         {
            this.FOverFun();
         }
      }
      
      private function HandleOut(param1:MouseEvent) : void
      {
         if(this.FOutFun != null)
         {
            this.FOutFun();
         }
      }
      
      private function HandleClick(param1:MouseEvent) : void
      {
         if(this.FClickFun != null)
         {
            this.FClickFun(this.FIdentifier);
         }
      }
      
      public function set ClickFun(param1:Function) : void
      {
         this.FClickFun = param1;
      }
      
      public function set OverFun(param1:Function) : void
      {
         this.FOverFun = param1;
      }
      
      public function set OutFun(param1:Function) : void
      {
         this.FOutFun = param1;
      }
   }
}

