package Processors.Game.Lobby.Common.Shortcuts
{
   import Resources.Constants.*;
   
   public class TLobbyShortcutAvatarModes extends TLobbyShortcutModes
   {
      
      public static const SHORTCUTINDEX_Hero:uint = CONST_SHORTCUTS.TYPE_Avatar_Hero;
      
      public static const CAPACITY_Shortcuts:int = CONST_SHORTCUTS.AVATARS_TYPE.length;
      
      public function TLobbyShortcutAvatarModes()
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
      
      public function get ShortcutModeAvatar() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Hero];
      }
      
      public function set ShortcutModeAvatar(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Hero] = param1;
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

