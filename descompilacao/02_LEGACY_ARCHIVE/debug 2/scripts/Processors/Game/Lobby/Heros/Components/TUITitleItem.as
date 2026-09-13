package Processors.Game.Lobby.Heros.Components
{
   import Foundation.UI.TUIComponent;
   import Logics.Title.TTitle;
   import Processors.Game.TProcessorGame;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUITitleItem extends TProcessorGame
   {
      
      protected var FTF_Title:TextField;
      
      protected var FMC_HasGet:MovieClip;
      
      protected var FResource:MovieClip;
      
      protected var FContext:Object;
      
      protected var FSelectOnClick:Function;
      
      public function TUITitleItem(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      protected function UIDispatch() : void
      {
         this.FTF_Title = this.FResource["TF_Title"];
         this.FMC_HasGet = this.FResource["MC_HasGet"];
      }
      
      protected function UILocation() : void
      {
         this.FResource.addEventListener(MouseEvent.CLICK,this.MCSelectOnClick,false,0,true);
         this.FResource.addEventListener(MouseEvent.MOUSE_DOWN,this.MCOnDown,false,0,true);
         this.FResource.addEventListener(MouseEvent.MOUSE_UP,this.MCOnUp,false,0,true);
         this.FResource.addEventListener(MouseEvent.MOUSE_MOVE,this.MCOnMove,false,0,true);
         this.FResource.addEventListener(MouseEvent.MOUSE_OUT,this.MCOnOut,false,0,true);
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:TTitle = null;
         if(this.FContext is TTitle)
         {
            _loc1_ = this.FContext as TTitle;
            if(_loc1_.IsEquiped != 0)
            {
               this.FMC_HasGet.visible = true;
               this.FMC_HasGet.play();
            }
            else
            {
               this.FMC_HasGet.visible = false;
            }
            this.FTF_Title.text = _loc1_.TitleName;
         }
      }
      
      protected function MCSelectOnClick(param1:MouseEvent) : void
      {
         if(this.FSelectOnClick != null)
         {
            this.FSelectOnClick(this,this.FContext);
         }
      }
      
      protected function MCOnDown(param1:MouseEvent) : void
      {
         this.FResource.gotoAndStop(3);
      }
      
      protected function MCOnUp(param1:MouseEvent) : void
      {
         this.FResource.gotoAndStop(1);
      }
      
      protected function MCOnMove(param1:MouseEvent) : void
      {
         this.FResource.gotoAndStop(2);
      }
      
      protected function MCOnOut(param1:MouseEvent) : void
      {
         this.FResource.gotoAndStop(1);
      }
      
      public function get Resource() : MovieClip
      {
         return this.FResource;
      }
      
      public function set Resource(param1:MovieClip) : void
      {
         this.FResource = param1;
      }
      
      public function get Context() : Object
      {
         return this.FContext;
      }
      
      public function set Context(param1:Object) : void
      {
         this.FContext = param1;
      }
      
      public function get SelectOnClick() : Function
      {
         return this.FSelectOnClick;
      }
      
      public function set SelectOnClick(param1:Function) : void
      {
         this.FSelectOnClick = param1;
      }
      
      public function Init() : void
      {
         this.UIDispatch();
         this.UILocation();
      }
      
      public function Update() : void
      {
         this.UpdateUI();
      }
   }
}

