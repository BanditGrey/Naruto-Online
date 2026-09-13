package Processors.Game.Lobby.BloodFete.cell
{
   import flash.display.MovieClip;
   
   public class TMouseBloodFete
   {
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FNumenBagCellMvc:TNumenBagCellMvc = null;
      
      protected var FIsFollowMouse:Boolean = false;
      
      protected var FBeginOrEnd:int;
      
      public function TMouseBloodFete(param1:MovieClip)
      {
         super();
         this.FThisPanel = param1;
         this.FThisPanel.mouseEnabled = false;
         this.FThisPanel.mouseChildren = false;
      }
      
      protected function ClearCell() : void
      {
         while(Boolean(this.FThisPanel) && Boolean(this.FThisPanel.numChildren))
         {
            this.FThisPanel.removeChildAt(0);
         }
      }
      
      public function set SetVisibel(param1:Boolean) : void
      {
         this.FThisPanel.visible = param1;
      }
      
      public function get SetVisibel() : Boolean
      {
         return this.FThisPanel.visible;
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
      
      public function set NumenBagCellMvc(param1:TNumenBagCellMvc) : void
      {
         this.FNumenBagCellMvc = param1;
         this.ClearCell();
         if(this.FNumenBagCellMvc == null || this.FNumenBagCellMvc.BagBloodFeteCell == null)
         {
            return;
         }
         this.FThisPanel.addChild(this.FNumenBagCellMvc.BagBloodFeteCell);
         this.FNumenBagCellMvc.BagBloodFeteCell.x = 5;
         this.FNumenBagCellMvc.BagBloodFeteCell.y = 5;
         this.FNumenBagCellMvc.GetMC_Panel.visible = false;
      }
      
      public function get NumenBagCellMvc() : TNumenBagCellMvc
      {
         return this.FNumenBagCellMvc;
      }
      
      public function set IsFollowMouse(param1:Boolean) : void
      {
         this.FIsFollowMouse = param1;
      }
      
      public function get IsFollowMouse() : Boolean
      {
         return this.FIsFollowMouse;
      }
      
      public function get BagBloodFeteCell() : TBagBloodFeteCell
      {
         return this.FNumenBagCellMvc.BagBloodFeteCell;
      }
      
      public function set BeginOrEnd(param1:int) : void
      {
         this.FBeginOrEnd = param1;
      }
      
      public function get BeginOrEnd() : int
      {
         return this.FBeginOrEnd;
      }
      
      public function UpdateImage() : void
      {
         if(Boolean(this.FNumenBagCellMvc) && Boolean(this.FNumenBagCellMvc.BagBloodFeteCell))
         {
            this.FNumenBagCellMvc.BagBloodFeteCell.UpdateImage();
         }
      }
   }
}

