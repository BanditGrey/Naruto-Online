package Processors.Game.Lobby.Common
{
   import Foundation.UI.TUIComponent;
   import Processors.Game.TProcessorGame;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class TProcessorUIResourceTemplate extends TProcessorGame
   {
      
      protected var FResource:MovieClip;
      
      protected var FContext:Object;
      
      public function TProcessorUIResourceTemplate(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function UIDispatch() : void
      {
      }
      
      protected function UILocations() : void
      {
         this.Reset();
      }
      
      protected function UpdateUI() : void
      {
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
      
      public function Init() : void
      {
         this.UIDispatch();
         this.UILocations();
      }
      
      public function Update() : void
      {
         this.UpdateUI();
      }
      
      public function Reset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TextField = null;
         var _loc4_:DisplayObject = null;
         _loc2_ = uint(this.FResource.numChildren);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FResource.getChildAt(_loc1_);
            if(_loc4_ is TextField)
            {
               _loc3_ = _loc4_ as TextField;
               _loc3_.text = "";
            }
            _loc1_++;
         }
      }
   }
}

