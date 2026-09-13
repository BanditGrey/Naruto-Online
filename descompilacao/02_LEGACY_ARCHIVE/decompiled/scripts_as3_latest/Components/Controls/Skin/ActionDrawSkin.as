package Components.Controls.Skin
{
   import Components.Controls.Support.UIComponent;
   
   public class ActionDrawSkin
   {
      
      protected var isHideOutSide:Boolean;
      
      public function ActionDrawSkin()
      {
         super();
      }
      
      public function init(param1:UIComponent, param2:Object) : void
      {
      }
      
      public function reDraw() : void
      {
      }
      
      public function hideOutState() : void
      {
         this.isHideOutSide = true;
      }
      
      public function updateSkin() : void
      {
         this.reDraw();
      }
   }
}

