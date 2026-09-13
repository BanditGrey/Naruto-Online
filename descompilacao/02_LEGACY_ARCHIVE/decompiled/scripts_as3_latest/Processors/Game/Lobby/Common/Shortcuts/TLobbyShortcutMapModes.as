package Processors.Game.Lobby.Common.Shortcuts
{
   import Resources.Constants.*;
   
   public class TLobbyShortcutMapModes extends TLobbyShortcutModes
   {
      
      public static const SHORTCUTINDEX_Map:uint = CONST_SHORTCUTS.TYPE_Map;
      
      public static const SHORTCUTINDEX_ReturnHome:uint = CONST_SHORTCUTS.TYPE_ReturnHome;
      
      public static const SHORTCUTINDEX_AutoBattle:uint = CONST_SHORTCUTS.TYPE_AutoBattle;
      
      public static const CAPACITY_Shortcuts:int = CONST_SHORTCUTS.MAP_TYPE.length;
      
      public function TLobbyShortcutMapModes()
      {
         super();
      }
      
      override protected function ConstructShortcutModes() : void
      {
         super.ConstructShortcutModes();
         FShortcutModes = new Vector.<int>(CAPACITY_Shortcuts);
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
      
      public function get ShortcutModeMap() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Map];
      }
      
      public function set ShortcutModeMap(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Map] = param1;
      }
      
      public function get ShortcutModeReturnHome() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_ReturnHome];
      }
      
      public function set ShortcutModeReturnHome(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_ReturnHome] = param1;
      }
      
      public function get ShortcutModeAutoBattle() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_AutoBattle];
      }
      
      public function set ShortcutModeAutoBattle(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_AutoBattle] = param1;
      }
      
      override public function ShortcutModesReset(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.ShortcutModesReset(param1);
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

