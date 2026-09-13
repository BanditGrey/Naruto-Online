package Processors.Game.Lobby.NijiaStar
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THeros;
   import Logics.NijiaStar.TNijiaStar;
   import Logics.NijiaStar.TNijiaStarAtom;
   import Processors.Game.Lobby.NijiaStar.Components.TUIMainPoint;
   import Processors.Game.Lobby.NijiaStar.Components.TUISubPoint;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_NIJIASTAR;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowMainPoint extends TProcessorGame
   {
      
      protected const CAPACITY_SubPoint:uint = 6;
      
      protected const WIDTH_OffSet:uint = 50;
      
      protected var FMC_KingStarDetail:Sprite;
      
      protected var FBTN_back:MovieClip;
      
      protected var FMC_CenterPoint:MovieClip;
      
      protected var FSubPointList:Vector.<TUISubPoint>;
      
      protected var FCharacter:TCharacter;
      
      protected var FHeros:THeros;
      
      protected var FNijiaStar:TNijiaStar;
      
      protected var FUIMainPoint:TUIMainPoint;
      
      protected var FMC_CenterEffect:MovieClip;
      
      protected var FOnClose:Function;
      
      protected var FOnClick:Function;
      
      protected var FOnNijiaPointOut:Function;
      
      protected var FOnNijiaPointOver:Function;
      
      public function TProcessorWindowMainPoint(param1:TUIComponent)
      {
         super(param1);
         this.FSubPointList = new Vector.<TUISubPoint>(this.CAPACITY_SubPoint);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_NIJIASTAR.RESOURCESID_Swf_NjiaStar);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISubPoint = null;
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_KingStarDetail = TUtilityReflection.CreateDisplayObjectInstance(CONST_NIJIASTAR.RESOURCE_ClassName_MC_KingStarDetail) as Sprite;
         addChild(this.FMC_KingStarDetail);
         this.FBTN_back = this.FMC_KingStarDetail[CONST_NIJIASTAR.RESOURCES_Link_BTN_back];
         TGameUtil.setButtonMode(this.FBTN_back,true);
         this.FMC_CenterPoint = this.FMC_KingStarDetail[CONST_NIJIASTAR.RESOURCES_Link_MC_CenterPoint];
         this.FMC_CenterEffect = this.FMC_KingStarDetail["MC_CenterEffect"];
         _loc2_ = this.CAPACITY_SubPoint;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUISubPoint(this);
            _loc3_.Resoures = this.FMC_KingStarDetail[CONST_NIJIASTAR.RESOURCES_Link_MC_SubPoint + _loc1_];
            _loc3_.Tag = _loc1_;
            _loc3_.OnClick = this.ProcessorSubPointOnClick;
            _loc3_.OnOut = this.ProcessorSubPointOnOut;
            _loc3_.OnOver = this.ProcessorSubPointOnOver;
            _loc3_.Init();
            this.FSubPointList[_loc1_] = _loc3_;
            _loc1_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_back.addEventListener(MouseEvent.CLICK,this.BackOnClick,false,0,true);
         this.FMC_CenterPoint.addEventListener(MouseEvent.MOUSE_MOVE,this.CenterPointOnOver,false,0,true);
         this.FMC_CenterPoint.addEventListener(MouseEvent.MOUSE_OUT,this.CenterPointOnOut,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      protected function ProcessorUpdateSubPoint(param1:TNijiaStar, param2:TUIMainPoint) : void
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TUISubPoint = null;
         var _loc7_:TNijiaStarAtom = null;
         _loc5_ = param2.Tag + 1;
         _loc4_ = this.FSubPointList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = this.FSubPointList[_loc3_];
            _loc6_.Context = param1;
            _loc7_ = param1.GetNijiaStarAtomByIndex(_loc3_);
            _loc6_.SetSubPointInfo(_loc7_,param2);
            _loc3_++;
         }
         this.FMC_CenterPoint.gotoAndStop(_loc5_);
         if(param1.IsLastPoint)
         {
            this.FMC_CenterEffect.play();
         }
         else
         {
            this.FMC_CenterEffect.stop();
         }
      }
      
      protected function BackOnClick(param1:MouseEvent) : void
      {
         if(this.FOnClose != null)
         {
            this.FOnClose(this);
         }
      }
      
      protected function ProcessorSubPointOnClick(param1:Object, param2:Object) : void
      {
         if(this.FOnClick != null)
         {
            this.FOnClick(this,param2);
         }
      }
      
      protected function ProcessorSubPointOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnNijiaPointOut != null)
         {
            this.FOnNijiaPointOut(this,param2);
         }
      }
      
      protected function ProcessorSubPointOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnNijiaPointOver != null)
         {
            this.FOnNijiaPointOver(this,param2,this.FNijiaStar);
         }
      }
      
      protected function CenterPointOnOver(param1:MouseEvent) : void
      {
         if(this.FOnNijiaPointOver != null)
         {
            this.FOnNijiaPointOver(this,this.FNijiaStar);
         }
      }
      
      protected function CenterPointOnOut(param1:MouseEvent) : void
      {
         if(this.FOnNijiaPointOut != null)
         {
            this.FOnNijiaPointOut(this,this.FNijiaStar);
         }
      }
      
      public function get OnClose() : Function
      {
         return this.FOnClose;
      }
      
      public function set OnClose(param1:Function) : void
      {
         this.FOnClose = param1;
      }
      
      public function get OnClick() : Function
      {
         return this.FOnClick;
      }
      
      public function set OnClick(param1:Function) : void
      {
         this.FOnClick = param1;
      }
      
      public function get OnNijiaPointOut() : Function
      {
         return this.FOnNijiaPointOut;
      }
      
      public function set OnNijiaPointOut(param1:Function) : void
      {
         this.FOnNijiaPointOut = param1;
      }
      
      public function get OnNijiaPointOver() : Function
      {
         return this.FOnNijiaPointOver;
      }
      
      public function set OnNijiaPointOver(param1:Function) : void
      {
         this.FOnNijiaPointOver = param1;
      }
      
      public function UpdateSubPoint(param1:Object, param2:TUIMainPoint) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TNijiaStar = null;
         _loc5_ = param1 as TNijiaStar;
         this.FNijiaStar = _loc5_;
         this.FUIMainPoint = param2;
         _loc3_ = param2.Resoures.x;
         _loc4_ = param2.Resoures.y;
         this.FMC_KingStarDetail.x = _loc3_;
         this.FMC_KingStarDetail.y = _loc4_;
         this.ProcessorUpdateSubPoint(_loc5_,param2);
      }
      
      public function UpdateUI(param1:TNijiaStar) : void
      {
         this.ProcessorUpdateSubPoint(param1,this.FUIMainPoint);
      }
   }
}

