package Processors.Game.Lobby.awaken.cell
{
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Processors.Game.Lobby.awaken.date.AwakenDateCELL;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_AWAKEN;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class BaseCell
   {
      
      protected var FThisPanel:MovieClip = null;
      
      protected var btm:Bitmap = null;
      
      protected var FMC_Bmp_Icon:MovieClip = null;
      
      protected var FTF_NeedNum:TextField = null;
      
      protected var FMC_Bmp_IconHighLight:MovieClip = null;
      
      protected var FMC_Bmp_Icon_Copy:MovieClip = null;
      
      protected var FMC_Locked:MovieClip = null;
      
      protected var FTDCell:AwakenDateCELL = null;
      
      protected var FBackOver:Function = null;
      
      protected var FBackOut:Function = null;
      
      protected var FBackMove:Function = null;
      
      protected var FBackClick:Function = null;
      
      public function BaseCell()
      {
         super();
         this.btm = new Bitmap();
      }
      
      public function SetPanel(param1:MovieClip) : void
      {
         this.FThisPanel = param1;
         this.Initilization();
      }
      
      public function SetDate(param1:AwakenDateCELL) : void
      {
         this.FTDCell = param1;
         this.SetView();
      }
      
      protected function SetView() : void
      {
         if(this.FTDCell)
         {
            if(this.FTF_NeedNum)
            {
               this.FTF_NeedNum.text = this.FTDCell.Count.toString();
            }
            if(this.FMC_Bmp_Icon)
            {
               this.FMC_Bmp_Icon.visible = true;
            }
         }
         else
         {
            if(this.FTF_NeedNum)
            {
               this.FTF_NeedNum.text = "";
            }
            if(this.FMC_Bmp_Icon)
            {
               this.FMC_Bmp_Icon.visible = false;
            }
         }
      }
      
      protected function Initilization() : void
      {
         this.FMC_Bmp_Icon = this.FThisPanel["MC_Bmp_Icon"];
         this.FTF_NeedNum = this.FThisPanel["TF_NeedNum"];
         this.FMC_Bmp_IconHighLight = this.FThisPanel["MC_Bmp_IconHighLight"];
         this.FMC_Bmp_Icon_Copy = this.FThisPanel["MC_Bmp_Icon_Copy"];
         this.FMC_Locked = this.FThisPanel["MC_Locked"];
         if(this.FMC_Bmp_Icon)
         {
            this.FMC_Bmp_Icon.addChild(this.btm);
         }
         if(this.FMC_Bmp_IconHighLight)
         {
            this.FMC_Bmp_IconHighLight.visible = false;
         }
         if(this.FMC_Bmp_Icon_Copy)
         {
            this.FMC_Bmp_Icon_Copy.visible = false;
         }
         this.FThisPanel.mouseChildren = false;
         this.FThisPanel.addEventListener(MouseEvent.MOUSE_OVER,this.HandleOver);
         this.FThisPanel.addEventListener(MouseEvent.MOUSE_OUT,this.HandleOut);
         this.FThisPanel.addEventListener(MouseEvent.MOUSE_MOVE,this.HandleMove);
         this.FThisPanel.addEventListener(MouseEvent.CLICK,this.HandleMoveClick);
      }
      
      public function SetCountDanGe(param1:int) : void
      {
         if(this.FTF_NeedNum)
         {
            this.FTF_NeedNum.text = param1.toString();
         }
      }
      
      public function SetCount(param1:int, param2:int) : void
      {
         if(this.FTF_NeedNum)
         {
            this.FTF_NeedNum.text = TUtilityString.Format(STRING_AWAKEN.Str3,param1,param2);
         }
      }
      
      public function SetCountAddCommon(param1:int, param2:int, param3:int) : void
      {
         if(this.FTF_NeedNum)
         {
            this.FTF_NeedNum.text = param1 + "(+" + param2 + ")" + "/" + param3;
         }
      }
      
      public function SetCountColor(param1:uint) : void
      {
         if(this.FTF_NeedNum)
         {
            this.FTF_NeedNum.textColor = param1;
         }
      }
      
      protected function HandleOver(param1:MouseEvent) : void
      {
         if(this.FTDCell)
         {
            this.FThisPanel.buttonMode = true;
            if(this.FMC_Bmp_IconHighLight)
            {
               this.FMC_Bmp_IconHighLight.visible = true;
            }
         }
         else
         {
            this.FThisPanel.buttonMode = false;
         }
         if(this.FBackOver != null && this.FTDCell != null)
         {
            this.FBackOver(this.FTDCell);
         }
      }
      
      protected function HandleOut(param1:MouseEvent) : void
      {
         if(this.FTDCell)
         {
            this.FThisPanel.buttonMode = false;
            if(this.FMC_Bmp_IconHighLight)
            {
               this.FMC_Bmp_IconHighLight.visible = false;
            }
         }
         if(this.FBackOut != null && this.FTDCell != null)
         {
            this.FBackOut(this.FTDCell);
         }
      }
      
      protected function HandleMove(param1:MouseEvent) : void
      {
         if(this.FBackMove != null && this.FTDCell != null)
         {
            this.FBackMove(this.FTDCell);
         }
      }
      
      protected function HandleMoveClick(param1:MouseEvent) : void
      {
         if(this.FBackClick != null && this.FTDCell != null)
         {
            this.FBackClick(this.FTDCell);
         }
      }
      
      public function UpdateImage() : void
      {
         if(!this.FTDCell)
         {
            return;
         }
         if(!this.FTDCell.AwakenConfigDate)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_Awaken,this.btm,CONST_MODULES.MODULE_Awaken,this.FTDCell.AwakenConfigDate.Icon);
      }
      
      public function SetLocked(param1:Boolean) : void
      {
         if(this.FMC_Locked)
         {
            this.FMC_Locked.visible = param1;
         }
      }
      
      public function set moviClipFream(param1:int) : void
      {
         if(this.FMC_Bmp_Icon_Copy)
         {
            this.FMC_Bmp_Icon_Copy.gotoAndStop(param1);
            this.FMC_Bmp_Icon_Copy.visible = true;
         }
      }
      
      public function set BackOver(param1:Function) : void
      {
         this.FBackOver = param1;
      }
      
      public function set BackOut(param1:Function) : void
      {
         this.FBackOut = param1;
      }
      
      public function set BackMove(param1:Function) : void
      {
         this.FBackMove = param1;
      }
      
      public function set BackClick(param1:Function) : void
      {
         this.FBackClick = param1;
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
   }
}

