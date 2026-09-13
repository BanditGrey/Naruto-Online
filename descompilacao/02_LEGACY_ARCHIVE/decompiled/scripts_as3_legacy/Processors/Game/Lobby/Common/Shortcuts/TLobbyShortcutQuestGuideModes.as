package Processors.Game.Lobby.Common.Shortcuts
{
   public class TLobbyShortcutQuestGuideModes extends TLobbyShortcutModes
   {
      
      public static const CAPACITY_Shortcuts:int = 1;
      
      public function TLobbyShortcutQuestGuideModes()
      {
         super();
      }
      
      override protected function ConstructShortcutModes() : void
      {
         super.ConstructShortcutModes();
         FShortcutModes = new Vector.<int>(1);
         this.ShortcutModesSet(SHORTCUTMODE_Hidden);
      }
      
      protected function ShortcutModesSet(param1:uint) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < CAPACITY_Shortcuts)
         {
            FShortcutModes[_loc2_] = param1;
            _loc2_++;
         }
      }
      
      public function get ShortcutMode() : uint
      {
         return FShortcutModes[0];
      }
      
      public function set ShortcutMode(param1:uint) : void
      {
         FShortcutModes[0] = param1;
      }
      
      override public function ShortcutModesReset(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = CAPACITY_Shortcuts;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            FShortcutModes[_loc2_] = param1;
            _loc2_++;
         }
      }
   }
}

