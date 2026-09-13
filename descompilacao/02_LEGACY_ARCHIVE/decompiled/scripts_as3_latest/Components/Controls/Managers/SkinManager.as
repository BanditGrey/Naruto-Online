package Components.Controls.Managers
{
   import Components.Controls.Support.*;
   
   public class SkinManager
   {
      
      public static var isUseDefaultSkin:Boolean = true;
      
      public function SkinManager()
      {
         super();
      }
      
      public static function loadNewSkin(param1:String) : void
      {
      }
      
      public static function updateAllComponentsSkin() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < ComponentsManager.allRefs.length)
         {
            UIComponent(ComponentsManager.allRefs[_loc1_]).updateSkin();
            _loc1_++;
         }
      }
   }
}

