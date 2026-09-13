package Processors.Game.Lobby.BloodFete.cell
{
   import flash.display.MovieClip;
   
   public class TNumenBagCellMvc
   {
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FMc_Locked:MovieClip;
      
      protected var FMC_Panel:MovieClip = null;
      
      protected var FMC_Effect:MovieClip = null;
      
      protected var FBagBloodFeteCell:TBagBloodFeteCell = null;
      
      protected var FThisCellHave:Boolean = false;
      
      protected var FIsLocked:Boolean = false;
      
      protected var FIsBagOrHero:int = 0;
      
      protected var FBeginOrEnd:int = 0;
      
      protected var FCurentIndex:int;
      
      public function TNumenBagCellMvc(param1:MovieClip)
      {
         super();
         this.FThisPanel = param1;
         this.FMc_Locked = this.FThisPanel["Mc_Locked"];
         this.FMC_Panel = this.FThisPanel["MC_Panel"];
         this.FMC_Effect = this.FThisPanel["MC_Effect"];
         this.FMC_Effect.gotoAndStop(2);
         this.FThisPanel.mouseChildren = false;
      }
      
      protected function ClearCell() : void
      {
         while(Boolean(this.FMC_Panel) && Boolean(this.FMC_Panel.numChildren))
         {
            this.FMC_Panel.removeChildAt(0);
         }
      }
      
      public function get GetMC_Panel() : MovieClip
      {
         return this.FMC_Panel;
      }
      
      public function get MC_Effect() : MovieClip
      {
         return this.FMC_Effect;
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
      
      public function set BagBloodFeteCell(param1:TBagBloodFeteCell) : void
      {
         this.FBagBloodFeteCell = param1;
         if(this.FBagBloodFeteCell == null)
         {
            this.ClearCell();
            this.FThisCellHave = false;
            this.FMC_Panel.visible = false;
         }
         else
         {
            this.FMC_Panel.addChild(this.FBagBloodFeteCell);
            this.FBagBloodFeteCell.x = -20;
            this.FBagBloodFeteCell.y = -20;
            this.FThisCellHave = true;
            this.FMC_Panel.visible = true;
         }
      }
      
      public function get BagBloodFeteCell() : TBagBloodFeteCell
      {
         return this.FBagBloodFeteCell;
      }
      
      public function set ThisCellHave(param1:Boolean) : void
      {
         this.FThisCellHave = param1;
      }
      
      public function get ThisCellHave() : Boolean
      {
         return this.FThisCellHave;
      }
      
      public function set IsLocked(param1:Boolean) : void
      {
         this.FIsLocked = param1;
         this.FMc_Locked.visible = param1;
      }
      
      public function get IsLocked() : Boolean
      {
         return this.FIsLocked;
      }
      
      public function set BeginOrEnd(param1:int) : void
      {
         this.FBeginOrEnd = param1;
      }
      
      public function get BeginOrEnd() : int
      {
         return this.FBeginOrEnd;
      }
      
      public function set IsBagOrHero(param1:int) : void
      {
         this.FIsBagOrHero = param1;
      }
      
      public function get IsBagOrHero() : int
      {
         return this.FIsBagOrHero;
      }
      
      public function set CurentIndex(param1:int) : void
      {
         this.FCurentIndex = param1;
      }
      
      public function get CurentIndex() : int
      {
         return this.FCurentIndex;
      }
   }
}

