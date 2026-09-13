package Processors.Game.Lobby.EightDoor.LittleClass
{
   import Logics.DatebaseVO.VO.TEightInnerGates_Attr;
   import Logics.DatebaseVO.VO.TEightInnerGates_Mission;
   import Logics.SLogicsCore;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TEightDoorCell
   {
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FCurIndex:int;
      
      protected var FMC_Btn:MovieClip = null;
      
      protected var FMC_Door:MovieClip = null;
      
      protected var FMC_MC_Labbel:MovieClip = null;
      
      protected var FMC_Effect:MovieClip = null;
      
      protected var FEightInnerGates_Mission:TEightInnerGates_Mission;
      
      protected var FBaseDataVec:Vector.<TEightInnerGates_Attr>;
      
      protected var FShangYiGeCell:TEightDoorCell;
      
      protected var FBackClcik:Function;
      
      protected var FBackOver:Function;
      
      protected var FBackMove:Function;
      
      protected var FBackOut:Function;
      
      public function TEightDoorCell()
      {
         super();
         this.FBaseDataVec = new Vector.<TEightInnerGates_Attr>();
      }
      
      public function SetPanel(param1:MovieClip, param2:int) : void
      {
         this.FThisPanel = param1;
         this.FCurIndex = param2;
         this.Inilization();
      }
      
      public function set SetData(param1:TEightInnerGates_Mission) : void
      {
         this.FEightInnerGates_Mission = param1;
      }
      
      protected function Inilization() : void
      {
         this.FMC_Btn = this.FThisPanel["MC_Btn"];
         this.FMC_Btn.gotoAndStop(this.FCurIndex + 1);
         this.FMC_Door = this.FMC_Btn["MC_Door"];
         this.FMC_MC_Labbel = this.FThisPanel["MC_Labbel"];
         this.FMC_MC_Labbel.mouseEnabled = false;
         this.FMC_MC_Labbel.mouseChildren = false;
         this.FMC_Effect = this.FThisPanel["MC_Effect"];
         this.FMC_Effect.mouseEnabled = false;
         this.FMC_Effect.mouseChildren = false;
         this.FMC_Door.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FMC_Door.addEventListener(MouseEvent.MOUSE_OVER,this.HandleOver);
         this.FMC_Door.addEventListener(MouseEvent.MOUSE_MOVE,this.HandleMove);
         this.FMC_Door.addEventListener(MouseEvent.MOUSE_OUT,this.HandleOut);
         this.FMC_Door.addEventListener(MouseEvent.MOUSE_DOWN,this.HandleDown);
         this.FMC_Door.addEventListener(MouseEvent.MOUSE_UP,this.HandleUp);
         this.FMC_Door.buttonMode = true;
      }
      
      public function HandleClick(param1:MouseEvent) : void
      {
      }
      
      public function HandleOver(param1:MouseEvent) : void
      {
         if(!this.FMC_Door.buttonMode)
         {
            if(this.FBackOver != null)
            {
               this.FBackOver(this.FCurIndex);
            }
         }
         if(param1.currentTarget.buttonMode)
         {
            param1.currentTarget.gotoAndStop(2);
         }
      }
      
      public function HandleMove(param1:MouseEvent) : void
      {
         if(!this.FMC_Door.buttonMode)
         {
            if(this.FBackMove != null)
            {
               this.FBackMove(this.FCurIndex);
            }
         }
      }
      
      public function HandleOut(param1:MouseEvent) : void
      {
         if(!this.FMC_Door.buttonMode)
         {
            if(this.FBackOut != null)
            {
               this.FBackOut(this.FCurIndex);
            }
         }
         if(param1.currentTarget.buttonMode)
         {
            param1.currentTarget.gotoAndStop(1);
         }
      }
      
      public function HandleUp(param1:MouseEvent) : void
      {
         if(!this.FMC_Door.buttonMode)
         {
            return;
         }
         this.FBackClcik(this.FCurIndex);
         if(param1.currentTarget.buttonMode)
         {
            param1.currentTarget.gotoAndStop(2);
         }
      }
      
      public function HandleDown(param1:MouseEvent) : void
      {
         if(param1.currentTarget.buttonMode)
         {
            param1.currentTarget.gotoAndStop(3);
         }
      }
      
      public function Update() : void
      {
         this.FMC_MC_Labbel.visible = false;
         if(SLogicsCore.EightDoorLogicData.OpenedLastId >= this.FBaseDataVec[this.FBaseDataVec.length - 1].Identifier)
         {
            this.FMC_MC_Labbel.visible = true;
            this.FMC_Door.gotoAndStop(1);
            this.FMC_Door.buttonMode = true;
         }
         else if(this.FShangYiGeCell)
         {
            if(SLogicsCore.EightDoorLogicData.OpenedLastId >= this.FShangYiGeCell.BaseDataVec[this.FShangYiGeCell.BaseDataVec.length - 1].Identifier && this.FEightInnerGates_Mission.Level <= SLogicsCore.Character.MainHero.Level)
            {
               this.FMC_Door.gotoAndStop(1);
               this.FMC_Door.buttonMode = true;
            }
            else
            {
               this.FMC_Door.gotoAndStop(4);
               this.FMC_Door.buttonMode = false;
            }
         }
         else if(SLogicsCore.EightDoorLogicData.OpenedLastId < this.FBaseDataVec[this.FBaseDataVec.length - 1].Identifier)
         {
            this.FMC_Door.gotoAndStop(1);
            this.FMC_Door.buttonMode = true;
         }
      }
      
      public function set BackClcik(param1:Function) : void
      {
         this.FBackClcik = param1;
      }
      
      public function set BackOver(param1:Function) : void
      {
         this.FBackOver = param1;
      }
      
      public function set BackMove(param1:Function) : void
      {
         this.FBackMove = param1;
      }
      
      public function set BackOut(param1:Function) : void
      {
         this.FBackOut = param1;
      }
      
      public function get EightDoorId() : int
      {
         return this.FEightInnerGates_Mission.Identifier;
      }
      
      public function get EightInnerGates_Mission() : TEightInnerGates_Mission
      {
         return this.FEightInnerGates_Mission;
      }
      
      public function get CurIndex() : int
      {
         return this.FCurIndex;
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
      
      public function get BaseDataVec() : Vector.<TEightInnerGates_Attr>
      {
         return this.FBaseDataVec;
      }
      
      public function set ShangYiGeCell(param1:TEightDoorCell) : void
      {
         this.FShangYiGeCell = param1;
      }
      
      public function get ShangYiGeCell() : TEightDoorCell
      {
         return this.FShangYiGeCell;
      }
      
      public function get MC_Effect() : MovieClip
      {
         return this.FMC_Effect;
      }
   }
}

