package Rendering.Texts
{
   import Foundation.UI.TUIComponent;
   
   public class TPainterTextEffectHTML extends TPainterTextEffect
   {
      
      public function TPainterTextEffectHTML(param1:TUIComponent)
      {
         super(param1);
      }
      
      override public function set Text(param1:String) : void
      {
         FTextField.htmlText = param1;
      }
      
      public function setFModified(param1:Boolean) : void
      {
         FModified = param1;
      }
   }
}

