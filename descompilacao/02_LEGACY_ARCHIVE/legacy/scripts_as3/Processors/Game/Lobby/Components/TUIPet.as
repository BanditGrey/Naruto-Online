package Processors.Game.Lobby.Components
{
   import Foundation.Resources.Textures.TAnimationSequence;
   import Foundation.UI.TUIComponent;
   
   public class TUIPet extends TUIHero
   {
      
      public function TUIPet(param1:TUIComponent)
      {
         super(param1);
      }
      
      public function get BitmapHeight() : Number
      {
         return FBitmap.height;
      }
      
      public function get BitmapWidth() : Number
      {
         return FBitmap.width;
      }
      
      public function set SequenceContext(param1:TAnimationSequence) : void
      {
         FSequenceContext = param1;
      }
   }
}

