package Processors.Game.Lobby.AccessoryLing
{
   import Components.Slots.TUISlot;
   import Foundation.UI.TUIComponent;
   import Resources.Constants.CONST_ACCESSORY_INTENSITY;
   import flash.text.TextField;
   
   public class TSoltCell extends TUISlot
   {
      
      public function TSoltCell(param1:TUIComponent)
      {
         super(param1);
      }
      
      public function MaterialCount(param1:int, param2:int = 0, param3:Boolean = false, param4:uint = 15518068) : void
      {
         var _loc5_:TextField = FResource[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingLingZu_Solt_Pencent];
         if(_loc5_ == null)
         {
            return;
         }
         _loc5_.textColor = param4;
         if(param1 == 0 && param2 == 0)
         {
            _loc5_.text = "";
            return;
         }
         if(param3)
         {
            _loc5_.text = param1 + "/" + param2;
         }
         else
         {
            _loc5_.text = String(param1);
         }
      }
   }
}

