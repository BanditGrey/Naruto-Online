package Processors.Game.Lobby.Exercise.RechargeExchange.Compoents
{
   import Foundation.UI.TUIComponent;
   import Processors.Game.Lobby.Exercise.RechargeExchange.TProcessorRechargeExchange;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIMonsterItem extends TUIComponent
   {
      
      private var _monsterIndex:int;
      
      private var mc_selectTag:MovieClip;
      
      private var _resource:MovieClip;
      
      public function TUIMonsterItem(param1:TUIComponent)
      {
         super(param1);
      }
      
      public function init() : void
      {
         this.Initialization();
      }
      
      protected function Initialization() : void
      {
         this.mc_selectTag = this._resource["mc_selectTag"] as MovieClip;
         this.mc_selectTag.visible = false;
         this._resource.gotoAndStop(this._monsterIndex + 1);
         this._resource.buttonMode = true;
         this._resource.addEventListener(MouseEvent.CLICK,this.onClickHandler);
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         this.mc_selectTag.visible = true;
         (FParent as TProcessorRechargeExchange).setProcessorPageOnChange(this._monsterIndex);
      }
      
      public function cancelSelect() : void
      {
         this.mc_selectTag.visible = false;
      }
      
      public function get monsterIndex() : int
      {
         return this._monsterIndex;
      }
      
      public function set monsterIndex(param1:int) : void
      {
         this._monsterIndex = param1;
      }
      
      public function get resource() : MovieClip
      {
         return this._resource;
      }
      
      public function set resource(param1:MovieClip) : void
      {
         this._resource = param1;
      }
   }
}

