package Processors.Game.Lobby.GeneralStar.PackageStarPoint
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.GeneralStar.TEsotericPoint;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TPoint extends TUIComponent
   {
      
      public static const RENDERINGSTATE_Disabled:int = 1;
      
      public static const RENDERINGSTATE_CanPoint:int = 2;
      
      public static const RENDERINGSTATE_Pointed:int = 3;
      
      protected var FSubstrate:MovieClip;
      
      protected var FTiaoZhuan0:MovieClip;
      
      protected var FTiaoZhuan1:MovieClip;
      
      protected var FTiaoZhuan2:MovieClip;
      
      protected var FTiaoZhuan3:MovieClip;
      
      protected var FContext:Object;
      
      protected var FInitialization:Boolean;
      
      protected var FOnClickPoint:Function;
      
      protected var FOnGeneralStarMove:Function;
      
      protected var FOnGeneralStarOut:Function;
      
      protected var FOnClickTiaoZhuan:Function;
      
      public function TPoint(param1:TUIComponent)
      {
         super(param1);
         this.FInitialization = false;
      }
      
      protected function Initialization() : void
      {
         this.FSubstrate.addEventListener(MouseEvent.MOUSE_OVER,this.PointOnOver,false,0,true);
         this.FSubstrate.addEventListener(MouseEvent.MOUSE_OUT,this.PointOnOut,false,0,true);
         this.FSubstrate.addEventListener(MouseEvent.MOUSE_MOVE,this.PointOnMove,false,0,true);
         this.FSubstrate.addEventListener(MouseEvent.CLICK,this.PointOnClick,false,0,true);
         if(this.FTiaoZhuan0)
         {
            TGameUtil.setButtonMode(this.FTiaoZhuan0["MC_LianJie"],true);
            this.FTiaoZhuan0.addEventListener(MouseEvent.CLICK,this.TiaoZhuanClick);
         }
         if(this.FTiaoZhuan1)
         {
            TGameUtil.setButtonMode(this.FTiaoZhuan1["MC_LianJie"],true);
            this.FTiaoZhuan1.addEventListener(MouseEvent.CLICK,this.TiaoZhuanClick);
         }
         if(this.FTiaoZhuan2)
         {
            TGameUtil.setButtonMode(this.FTiaoZhuan2["MC_LianJie"],true);
            this.FTiaoZhuan2.addEventListener(MouseEvent.CLICK,this.TiaoZhuanClick);
         }
         if(this.FTiaoZhuan3)
         {
            TGameUtil.setButtonMode(this.FTiaoZhuan3["MC_LianJie"],true);
            this.FTiaoZhuan3.addEventListener(MouseEvent.CLICK,this.TiaoZhuanClick);
         }
         this.FInitialization = true;
      }
      
      protected function PointOnOver(param1:MouseEvent) : void
      {
      }
      
      protected function PointOnOut(param1:MouseEvent) : void
      {
         if(this.FOnGeneralStarOut != null)
         {
            this.FOnGeneralStarOut(this);
         }
      }
      
      protected function PointOnMove(param1:MouseEvent) : void
      {
         if(this.FOnGeneralStarMove != null)
         {
            this.FOnGeneralStarMove(this);
         }
      }
      
      protected function PointOnClick(param1:MouseEvent) : void
      {
         if(this.FSubstrate.currentFrame == 2)
         {
            if(this.FOnClickPoint != null)
            {
               this.FOnClickPoint(this);
            }
         }
      }
      
      protected function TiaoZhuanClick(param1:MouseEvent) : void
      {
         if(this.FOnClickTiaoZhuan != null)
         {
            this.FOnClickTiaoZhuan(TEsotericPoint(this.FContext).Isgoto);
         }
      }
      
      public function get Substrate() : MovieClip
      {
         return this.FSubstrate;
      }
      
      public function set Substrate(param1:MovieClip) : void
      {
         this.FSubstrate = param1;
         this.FTiaoZhuan0 = this.FSubstrate["mc_0"];
         this.FTiaoZhuan1 = this.FSubstrate["mc_1"];
         this.FTiaoZhuan2 = this.FSubstrate["mc_2"];
         this.FTiaoZhuan3 = this.FSubstrate["mc_3"];
      }
      
      public function get OnClickTiaoZhuan() : Function
      {
         return this.FOnClickTiaoZhuan;
      }
      
      public function set OnClickTiaoZhuan(param1:Function) : void
      {
         this.FOnClickTiaoZhuan = param1;
      }
      
      public function get OnClickPoint() : Function
      {
         return this.FOnClickPoint;
      }
      
      public function set OnClickPoint(param1:Function) : void
      {
         this.FOnClickPoint = param1;
      }
      
      public function get OnGeneralStarMove() : Function
      {
         return this.FOnGeneralStarMove;
      }
      
      public function set OnGeneralStarMove(param1:Function) : void
      {
         this.FOnGeneralStarMove = param1;
      }
      
      public function get OnGeneralStarOut() : Function
      {
         return this.FOnGeneralStarOut;
      }
      
      public function set OnGeneralStarOut(param1:Function) : void
      {
         this.FOnGeneralStarOut = param1;
      }
      
      public function get Context() : Object
      {
         return this.FContext;
      }
      
      public function set Context(param1:Object) : void
      {
         this.FContext = param1;
      }
      
      public function Init() : void
      {
         if(this.FInitialization)
         {
            return;
         }
         this.Initialization();
      }
      
      public function SetPointState(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TEsotericPoint = null;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            if(this.FSubstrate["mc_" + _loc2_])
            {
               this.FSubstrate["mc_" + _loc2_].visible = false;
            }
            _loc2_++;
         }
         this.FSubstrate.gotoAndStop(param1);
         if(param1 == RENDERINGSTATE_Pointed)
         {
            this.FSubstrate["mm"].play();
            if(this.Context is TEsotericPoint)
            {
               _loc3_ = this.Context as TEsotericPoint;
               if(_loc3_.IsSkill)
               {
                  if(this.FSubstrate["mc_" + _loc3_.Arrow])
                  {
                     this.FSubstrate["mc_" + _loc3_.Arrow].visible = true;
                     this.FSubstrate["mc_" + _loc3_.Arrow].play();
                  }
               }
            }
         }
      }
      
      public function UpdateFrameOne() : void
      {
         if(this.FSubstrate != null)
         {
            this.FSubstrate.gotoAndStop(1);
         }
      }
      
      public function UpdateFrameTwo() : void
      {
         if(this.FSubstrate != null)
         {
            this.FSubstrate.gotoAndStop(2);
         }
      }
      
      public function UpdateFrameThree() : void
      {
         if(this.FSubstrate != null)
         {
            this.FSubstrate.gotoAndStop(3);
         }
      }
      
      public function RemoveSubstrateEvent() : void
      {
         if(this.FSubstrate.hasEventListener(MouseEvent.MOUSE_OVER))
         {
            this.FSubstrate.removeEventListener(MouseEvent.MOUSE_OVER,this.PointOnOver);
         }
         if(this.FSubstrate.hasEventListener(MouseEvent.MOUSE_OUT))
         {
            this.FSubstrate.removeEventListener(MouseEvent.MOUSE_OUT,this.PointOnOut);
         }
         if(this.FSubstrate.hasEventListener(MouseEvent.MOUSE_MOVE))
         {
            this.FSubstrate.removeEventListener(MouseEvent.MOUSE_MOVE,this.PointOnMove);
         }
         if(this.FSubstrate.hasEventListener(MouseEvent.CLICK))
         {
            this.FSubstrate.removeEventListener(MouseEvent.CLICK,this.PointOnClick);
         }
         if(this.FTiaoZhuan0)
         {
            if(this.FTiaoZhuan0.hasEventListener(MouseEvent.CLICK))
            {
               TGameUtil.setButtonMode(this.FTiaoZhuan0["MC_LianJie"],false);
               this.FTiaoZhuan0.removeEventListener(MouseEvent.CLICK,this.TiaoZhuanClick);
            }
         }
         if(this.FTiaoZhuan1)
         {
            if(this.FTiaoZhuan1.hasEventListener(MouseEvent.CLICK))
            {
               TGameUtil.setButtonMode(this.FTiaoZhuan1["MC_LianJie"],false);
               this.FTiaoZhuan1.removeEventListener(MouseEvent.CLICK,this.TiaoZhuanClick);
            }
         }
         if(this.FTiaoZhuan2)
         {
            if(this.FTiaoZhuan2.hasEventListener(MouseEvent.CLICK))
            {
               TGameUtil.setButtonMode(this.FTiaoZhuan2["MC_LianJie"],false);
               this.FTiaoZhuan2.removeEventListener(MouseEvent.CLICK,this.TiaoZhuanClick);
            }
         }
         if(this.FTiaoZhuan3)
         {
            if(this.FTiaoZhuan3.hasEventListener(MouseEvent.CLICK))
            {
               TGameUtil.setButtonMode(this.FTiaoZhuan3["MC_LianJie"],false);
               this.FTiaoZhuan3.removeEventListener(MouseEvent.CLICK,this.TiaoZhuanClick);
            }
         }
      }
   }
}

