package Processors.Game.Lobby.TongLing.ToolS
{
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUICore;
   import Foundation.Utilities.TGameUtil;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class MouseIcon extends Sprite
   {
      
      protected var FRootMvc:MovieClip;
      
      protected var FMesArr:Array;
      
      protected var FIconBitmap:Bitmap;
      
      protected var FIsRun:Boolean = false;
      
      protected var FMsgObj:Object;
      
      protected var FTuiCore:TUICore;
      
      protected var FCurPicId:int = 0;
      
      public function MouseIcon()
      {
         super();
         this.FIconBitmap = new Bitmap();
         this.buttonMode = true;
         this.mouseEnabled = false;
         this.addChild(this.FIconBitmap);
         this.UpDate();
      }
      
      public function UpDate() : void
      {
         var _loc1_:TCoordinate = null;
         if(this.FIsRun)
         {
            _loc1_ = TGameUtil.ShowImageByID(TGameUtil.Type_Pet,this.FIconBitmap,CONST_MODULES.MODULE_TongLing,this.FCurPicId,1);
         }
      }
      
      public function set SetPicId(param1:int) : void
      {
         this.FCurPicId = param1;
      }
      
      public function get SetPicId() : int
      {
         return this.FCurPicId;
      }
      
      public function set MsgObj(param1:Object) : void
      {
         this.FMsgObj = param1;
      }
      
      public function get MsgObj() : Object
      {
         return this.FMsgObj;
      }
      
      public function set IsRun(param1:Boolean) : void
      {
         this.FIsRun = param1;
      }
      
      public function get IsRun() : Boolean
      {
         return this.FIsRun;
      }
   }
}

