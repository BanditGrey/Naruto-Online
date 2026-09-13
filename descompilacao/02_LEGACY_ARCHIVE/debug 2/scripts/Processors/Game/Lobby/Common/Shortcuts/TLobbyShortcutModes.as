package Processors.Game.Lobby.Common.Shortcuts
{
   public class TLobbyShortcutModes
   {
      
      protected static const SHORTCUTMODE_Hidden:int = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
      
      protected var FShortcutModes:Vector.<int>;
      
      public function TLobbyShortcutModes()
      {
         super();
         this.ConstructShortcutModes();
      }
      
      protected function ConstructShortcutModes() : void
      {
      }
      
      public function GetShortcutModeByIndex(param1:int) : uint
      {
         return this.FShortcutModes[param1];
      }
      
      public function SetShortcutModeByIndex(param1:int, param2:uint) : void
      {
         this.FShortcutModes[param1] = param2;
      }
      
      public function ShortcutModesReset(param1:int) : void
      {
      }
   }
}

