package Processors.Game.Lobby.Account.SelectEffects
{
   import Foundation.UI.TUIComponent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TCharacterBox extends TUIComponent
   {
      
      protected var FSelectCharacterMC:MovieClip;
      
      protected var FSubscript:int;
      
      protected var FRotationOnClick:Function;
      
      protected var FProfessionFrame:int;
      
      protected var FIndex:int;
      
      public function TCharacterBox(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function SelectCharacterOnClick(param1:MouseEvent) : void
      {
         if(this.FRotationOnClick != null)
         {
            this.FRotationOnClick(this);
         }
      }
      
      public function set SelectCharacterMC(param1:MovieClip) : void
      {
         this.FSelectCharacterMC = param1;
         addChild(this.FSelectCharacterMC);
         this.FSelectCharacterMC.addEventListener(MouseEvent.CLICK,this.SelectCharacterOnClick,false,0,true);
      }
      
      public function get SelectCharacterMC() : MovieClip
      {
         return this.FSelectCharacterMC;
      }
      
      public function get Subscript() : int
      {
         return this.FSubscript;
      }
      
      public function set Subscript(param1:int) : void
      {
         this.FSubscript = param1;
      }
      
      public function get RotationOnClick() : Function
      {
         return this.FRotationOnClick;
      }
      
      public function set RotationOnClick(param1:Function) : void
      {
         this.FRotationOnClick = param1;
      }
      
      public function get ProfessionFrame() : int
      {
         return this.FProfessionFrame;
      }
      
      public function set ProfessionFrame(param1:int) : void
      {
         this.FProfessionFrame = param1;
      }
      
      public function get Index() : int
      {
         return this.FIndex;
      }
      
      public function set Index(param1:int) : void
      {
         this.FIndex = param1;
      }
      
      public function Release() : void
      {
         this.FSelectCharacterMC.removeEventListener(MouseEvent.CLICK,this.SelectCharacterOnClick,false);
         this.parent.removeChild(this);
      }
   }
}

