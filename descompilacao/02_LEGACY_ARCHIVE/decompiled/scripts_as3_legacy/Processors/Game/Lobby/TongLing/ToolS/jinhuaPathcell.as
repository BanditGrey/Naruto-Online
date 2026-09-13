package Processors.Game.Lobby.TongLing.ToolS
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class jinhuaPathcell
   {
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var FRootPanel:MovieClip;
      
      protected var FHeadBmp:Bitmap;
      
      protected var FCurId:uint = 0;
      
      protected var FTbb:TBB_Status;
      
      protected var FOverFunction:Function;
      
      protected var FOutFunction:Function;
      
      protected var FMoveFunction:Function;
      
      public function jinhuaPathcell(param1:MovieClip)
      {
         super();
         this.FRootPanel = param1;
         this.FHeadBmp = new Bitmap();
         MovieClip(this.FRootPanel["MC_Bmp_Icon"]).addChild(this.FHeadBmp);
         this.FRootPanel.addEventListener(MouseEvent.MOUSE_OVER,this.OverClick);
         this.FRootPanel.addEventListener(MouseEvent.MOUSE_MOVE,this.MoveClick);
         this.FRootPanel.addEventListener(MouseEvent.MOUSE_OUT,this.OutClick);
      }
      
      public function OverClick(param1:MouseEvent) : void
      {
         this.FOverFunction(this.FCurId);
      }
      
      public function MoveClick(param1:MouseEvent) : void
      {
         this.FMoveFunction(this.FCurId);
      }
      
      public function OutClick(param1:MouseEvent) : void
      {
         this.FOutFunction(this.FCurId);
      }
      
      public function SetCoent(param1:uint) : void
      {
         this.FCurId = param1;
         this.setPic();
      }
      
      public function setPic() : void
      {
         if(this.FCurId != 0)
         {
            this.FTbb = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,this.FCurId) as TBB_Status;
         }
      }
      
      public function set OverFunction(param1:Function) : void
      {
         this.FOverFunction = param1;
      }
      
      public function set OutFunction(param1:Function) : void
      {
         this.FOutFunction = param1;
      }
      
      public function set MoveFunction(param1:Function) : void
      {
         this.FMoveFunction = param1;
      }
      
      public function update() : void
      {
         if(this.FCurId == 0)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_Pet,this.FHeadBmp,CONST_MODULES.MODULE_TongLing,this.FTbb.SmPic);
      }
   }
}

