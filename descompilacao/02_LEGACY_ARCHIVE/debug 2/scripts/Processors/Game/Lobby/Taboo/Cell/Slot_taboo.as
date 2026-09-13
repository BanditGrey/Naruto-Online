package Processors.Game.Lobby.Taboo.Cell
{
   import Foundation.Utilities.TGameUtil;
   import Processors.Game.Lobby.Taboo.Data.TabooDataCell;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class Slot_taboo
   {
      
      protected var FLevel:TextField = null;
      
      protected var FCount:TextField = null;
      
      protected var FMiddleBtn:SimpleButton = null;
      
      protected var FMC_Bmp_Icon:MovieClip = null;
      
      protected var FMC_Bmp_IconHighLight:MovieClip = null;
      
      protected var FThisPanel:MovieClip = null;
      
      protected var bm:Bitmap = null;
      
      protected var FTDCell:TabooDataCell = null;
      
      protected var CurIndex:int;
      
      protected var FSlotsOnM:Function = null;
      
      protected var FSlotsOnO:Function = null;
      
      protected var FBackFun:Function;
      
      protected var FBackFunMove:Function;
      
      protected var FBackFunOver:Function;
      
      protected var FBackFunOut:Function;
      
      public function Slot_taboo()
      {
         super();
         this.bm = new Bitmap();
      }
      
      public function SetPanel(param1:MovieClip = null, param2:int = 0) : void
      {
         this.FThisPanel = param1;
         this.CurIndex = param2;
         this.Initilization();
      }
      
      public function SetData(param1:TabooDataCell = null) : void
      {
         this.FTDCell = param1;
         if(this.FTDCell)
         {
            this.SetValue();
         }
         else
         {
            this.SetNull();
         }
      }
      
      public function SetCount(param1:int, param2:int = 1, param3:int = 1) : void
      {
         if(param3)
         {
            this.FCount.text = String(param1);
         }
         else
         {
            this.FCount.text = param1 + "/" + param2;
         }
      }
      
      protected function SetValue() : void
      {
         if(this.FMC_Bmp_Icon)
         {
            this.FMC_Bmp_Icon.visible = true;
         }
         if(this.FMC_Bmp_IconHighLight)
         {
            this.FMC_Bmp_IconHighLight.visible = true;
         }
         if(this.FLevel)
         {
            this.FLevel.text = "";
         }
         this.FCount.text = this.FTDCell.Count.toString();
         if(this.FMiddleBtn)
         {
            this.FMiddleBtn.visible = false;
         }
      }
      
      public function set MiddleBtnVisibel(param1:Boolean) : void
      {
         if(this.FMiddleBtn)
         {
            this.FMiddleBtn.visible = param1;
         }
      }
      
      protected function Initilization() : void
      {
         this.FLevel = this.FThisPanel["TF_EquipLevel"];
         this.FCount = this.FThisPanel["TF_Subscript"];
         this.FMiddleBtn = this.FThisPanel["MC_AdvancedEquip"];
         this.FMC_Bmp_Icon = this.FThisPanel["MC_Bmp_Icon"];
         this.FMC_Bmp_IconHighLight = this.FThisPanel["MC_Bmp_IconHighLight"];
         this.FThisPanel.addEventListener(MouseEvent.MOUSE_MOVE,this.MCMove);
         this.FThisPanel.addEventListener(MouseEvent.MOUSE_OUT,this.MCOut);
         if(this.FMC_Bmp_Icon)
         {
            this.FMC_Bmp_Icon.addChild(this.bm);
         }
      }
      
      public function MCMove(param1:MouseEvent) : void
      {
         if(!this.FTDCell)
         {
            return;
         }
         this.FSlotsOnM(null,this.FTDCell);
      }
      
      public function MCOut(param1:MouseEvent) : void
      {
         if(!this.FTDCell)
         {
            return;
         }
         this.FSlotsOnO(null,this.FTDCell);
      }
      
      public function IsAddEventListener() : void
      {
         if(this.FMiddleBtn)
         {
            this.FMiddleBtn.addEventListener(MouseEvent.CLICK,this.MiddleBtnClick);
            this.FMiddleBtn.addEventListener(MouseEvent.MOUSE_MOVE,this.MiddleBtnMOVE);
            this.FMiddleBtn.addEventListener(MouseEvent.MOUSE_OUT,this.MiddleBtnOUT);
            this.FMiddleBtn.addEventListener(MouseEvent.MOUSE_OVER,this.MiddleBtnOVER);
         }
      }
      
      public function set BackFun(param1:Function) : void
      {
         this.FBackFun = param1;
      }
      
      public function set BackFunOver(param1:Function) : void
      {
         this.FBackFunOver = param1;
      }
      
      public function set BackFunMove(param1:Function) : void
      {
         this.FBackFunMove = param1;
      }
      
      public function set BackFunOut(param1:Function) : void
      {
         this.FBackFunOut = param1;
      }
      
      protected function MiddleBtnClick(param1:MouseEvent) : void
      {
         if(this.FBackFun != null)
         {
            this.FBackFun(this.CurIndex);
         }
      }
      
      protected function MiddleBtnOVER(param1:MouseEvent) : void
      {
         if(this.FBackFunOver != null)
         {
            this.FBackFunOver(this.CurIndex);
         }
      }
      
      protected function MiddleBtnMOVE(param1:MouseEvent) : void
      {
         if(this.FBackFunMove != null)
         {
            this.FBackFunMove();
         }
      }
      
      protected function MiddleBtnOUT(param1:MouseEvent) : void
      {
         if(this.FBackFunOut != null)
         {
            this.FBackFunOut();
         }
      }
      
      protected function SetNull() : void
      {
         if(this.FLevel)
         {
            this.FLevel.text = "";
         }
         if(this.FCount)
         {
            this.FCount.text = "";
         }
         if(this.FMiddleBtn)
         {
            this.FMiddleBtn.visible = false;
         }
         if(this.FMC_Bmp_Icon)
         {
            this.FMC_Bmp_Icon.visible = false;
         }
         if(this.FMC_Bmp_IconHighLight)
         {
            this.FMC_Bmp_IconHighLight.visible = false;
         }
      }
      
      public function UpdateImage() : void
      {
         if(!this.FTDCell)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_Inventory,this.bm,CONST_MODULES.MODULE_Taboo,this.FTDCell.ConfigureConfig.Icon);
      }
      
      public function set SlotsOnM(param1:Function) : void
      {
         this.FSlotsOnM = param1;
      }
      
      public function set SlotsOnO(param1:Function) : void
      {
         this.FSlotsOnO = param1;
      }
   }
}

