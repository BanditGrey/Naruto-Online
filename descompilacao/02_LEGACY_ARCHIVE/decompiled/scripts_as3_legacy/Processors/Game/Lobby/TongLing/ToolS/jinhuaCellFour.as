package Processors.Game.Lobby.TongLing.ToolS
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class jinhuaCellFour
   {
      
      protected var FRootPanel:MovieClip;
      
      protected var FCurid:int = 0;
      
      protected var FHeadBmp:Bitmap;
      
      protected var FTbb:TBB_Status;
      
      protected var FCurRarity:int;
      
      protected var FOverClick:Function;
      
      protected var FOutClick:Function;
      
      protected var FMoveClick:Function;
      
      public function jinhuaCellFour(param1:MovieClip)
      {
         super();
         this.FRootPanel = param1;
         this.FHeadBmp = new Bitmap();
         MovieClip(this.FRootPanel["MC_Bmp_Icon"]).addChild(this.FHeadBmp);
         MovieClip(this.FRootPanel["MC_Lock"]).visible = false;
         MovieClip(this.FRootPanel["MC_Main"]).visible = false;
         TextField(this.FRootPanel["TF_name"]).visible = false;
         TextField(this.FRootPanel["TF_Level"]).visible = false;
         MovieClip(this.FRootPanel["MC_Bmp_IconHighLight"]).visible = false;
         MovieClip(this.FRootPanel["MC_SelectedBox"]).visible = false;
         MovieClip(this.FRootPanel).addEventListener(MouseEvent.MOUSE_MOVE,this.Move);
         MovieClip(this.FRootPanel).addEventListener(MouseEvent.MOUSE_OVER,this.Over);
         MovieClip(this.FRootPanel).addEventListener(MouseEvent.MOUSE_OUT,this.Out);
      }
      
      public function SetCoent(param1:int) : void
      {
         this.FCurid = param1;
         if(this.FCurid != 0)
         {
            this.FTbb = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,this.FCurid) as TBB_Status;
            this.FCurRarity = this.FTbb.Identifier;
         }
         else
         {
            this.FCurRarity = 77;
         }
      }
      
      public function get CurRarity() : int
      {
         return this.FCurRarity;
      }
      
      public function setBitNull() : void
      {
         this.FHeadBmp.bitmapData = null;
         this.FCurRarity = 77;
      }
      
      public function Update1() : void
      {
         if(this.FCurid == 0)
         {
            this.FHeadBmp.bitmapData = null;
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_Pet,this.FHeadBmp,CONST_MODULES.MODULE_TongLing,this.FTbb.SmPic);
      }
      
      public function Move(param1:MouseEvent) : void
      {
         if(this.FCurid == 0)
         {
            return;
         }
         this.FMoveClick(this.FCurid);
      }
      
      public function Over(param1:MouseEvent) : void
      {
         if(this.FCurid == 0)
         {
            return;
         }
         this.FOverClick(this.FCurid);
      }
      
      public function Out(param1:MouseEvent) : void
      {
         if(this.FCurid == 0)
         {
            return;
         }
         this.FOutClick(this.FCurid);
      }
      
      public function set OverClick(param1:Function) : void
      {
         this.FOverClick = param1;
      }
      
      public function set OutClick(param1:Function) : void
      {
         this.FOutClick = param1;
      }
      
      public function set MoveClick(param1:Function) : void
      {
         this.FMoveClick = param1;
      }
   }
}

