package Components.Controls.Support
{
   public class BaseButton extends UIComponent
   {
      
      protected var _enabled:Boolean;
      
      public function BaseButton()
      {
         super();
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this._enabled = param1;
         if(this._enabled == false)
         {
            this.mouseChildren = false;
            this.mouseEnabled = false;
            this.alpha = 0.5;
         }
         else
         {
            this.mouseChildren = true;
            this.mouseEnabled = true;
            this.alpha = 1;
         }
      }
   }
}

