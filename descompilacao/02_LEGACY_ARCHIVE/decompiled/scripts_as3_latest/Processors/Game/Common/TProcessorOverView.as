package Processors.Game.Common
{
   import Foundation.UI.TUIComponent;
   import Processors.Game.TProcessorGame;
   
   public class TProcessorOverView extends TProcessorGame
   {
      
      protected var FOnEffectText:Function;
      
      public function TProcessorOverView(param1:TUIComponent)
      {
         super(param1);
      }
      
      public function get OnEffectText() : Function
      {
         return this.FOnEffectText;
      }
      
      public function set OnEffectText(param1:Function) : void
      {
         this.FOnEffectText = param1;
      }
   }
}

