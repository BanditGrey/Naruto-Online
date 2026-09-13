package Processors.Game.Lobby.TongLing.ToolS
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TONGLING;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class FiveCell
   {
      
      protected var FThisRoot:MovieClip;
      
      protected var FPicBmp:Bitmap;
      
      protected var FHowLvel:MovieClip;
      
      protected var FHowLvelOpen:TextField;
      
      protected var FCurId:int = 0;
      
      protected var FCurObject:Object = null;
      
      protected var StatusExcel:TBB_Status;
      
      protected var FIsDraging:int = 0;
      
      protected var FIsOpenThis:int = 0;
      
      protected var FmoveClick:Function;
      
      protected var FoverClick:Function;
      
      protected var FoutClick:Function;
      
      protected var FThisindex:int = 0;
      
      public function FiveCell(param1:MovieClip)
      {
         super();
         this.FThisRoot = param1;
         this.FPicBmp = new Bitmap();
         this.ValueIniti();
      }
      
      public function ValueIniti() : void
      {
         MovieClip(this.FThisRoot["mvc_pic"]).addChild(this.FPicBmp);
         this.FHowLvelOpen = TextField(this.FThisRoot["T_Scr"]["level03"]);
         this.FHowLvel = MovieClip(this.FThisRoot["T_Scr"]);
         this.FThisRoot.addEventListener(MouseEvent.CLICK,this.MouseClick);
         this.FThisRoot.addEventListener(MouseEvent.MOUSE_MOVE,this.MoveClick);
         this.FThisRoot.addEventListener(MouseEvent.MOUSE_OVER,this.OverClick);
         this.FThisRoot.addEventListener(MouseEvent.MOUSE_OUT,this.OutClick);
      }
      
      public function set MC(param1:Function) : void
      {
         this.FmoveClick = param1;
      }
      
      public function set OC(param1:Function) : void
      {
         this.FoverClick = param1;
      }
      
      public function set TC(param1:Function) : void
      {
         this.FoutClick = param1;
      }
      
      public function MoveClick(param1:MouseEvent) : void
      {
         if(this.FCurObject == null)
         {
            return;
         }
         this.FmoveClick();
      }
      
      public function OverClick(param1:MouseEvent) : void
      {
         if(this.FCurObject == null)
         {
            return;
         }
         this.FoverClick(this.FCurObject);
      }
      
      public function OutClick(param1:MouseEvent) : void
      {
         this.FoutClick();
      }
      
      public function SetMsgObj(param1:Object) : void
      {
         this.FCurObject = param1;
         if(this.FCurObject == null)
         {
            return;
         }
         this.FCurId = param1.Id;
         this.StatusExcel = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,param1.Id) as TBB_Status;
      }
      
      public function Update() : void
      {
         if(this.FCurObject == null)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_Pet,this.FPicBmp,CONST_MODULES.MODULE_TongLing,this.StatusExcel.SmPic,1);
      }
      
      public function SetNull() : void
      {
         this.FCurId = 0;
         this.FHowLvelOpen.text = "";
         this.FPicBmp.bitmapData = null;
      }
      
      public function HowLvelOpen(param1:int, param2:int) : void
      {
         if(param1 == 2)
         {
            this.FHowLvelOpen.text = STRING_COMMON.FORMAT_VIP + param2 + STRING_TONGLING.TONGLING_OPEN;
         }
         else
         {
            this.FHowLvelOpen.text = STRING_COMMON.FORMAT_Level + String(param2) + STRING_TONGLING.TONGLING_OPEN;
         }
      }
      
      public function set IsVisibel_levelOpen(param1:Boolean) : void
      {
         this.FHowLvelOpen.visible = param1;
         this.FHowLvel.visible = param1;
      }
      
      public function get IsVisibel_levelOpen() : Boolean
      {
         return this.FHowLvelOpen.visible;
      }
      
      public function MouseClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FCurObject == null)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLingZhenXingTake_Rep);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FCurObject.Identifier0);
         _loc3_.writeUnsignedInt(this.FCurObject.Identifier1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function get Curobj() : Object
      {
         return this.FCurObject;
      }
      
      public function set IsOpenThis(param1:int) : void
      {
         this.FIsOpenThis = param1;
      }
      
      public function get IsOpenThis() : int
      {
         return this.FIsOpenThis;
      }
      
      public function set Draging(param1:int) : void
      {
         this.FIsDraging = param1;
      }
      
      public function get Draging() : int
      {
         return this.FIsDraging;
      }
      
      public function get Thisindex() : int
      {
         return this.FThisindex;
      }
      
      public function set Thisindex(param1:int) : void
      {
         this.FThisindex = param1;
      }
   }
}

