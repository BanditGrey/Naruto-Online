package Processors.Game.Lobby.Common.Shortcuts
{
   import Resources.Constants.*;
   
   public class TLobbyShortcutConstantlyModes extends TLobbyShortcutModes
   {
      
      public static const TYPE_Constantly_Strengthen:uint = CONST_SHORTCUTS.TYPE_Constantly_Strengthen;
      
      public static const TYPE_Constantly_Arena:uint = CONST_SHORTCUTS.TYPE_Constantly_Arena;
      
      public static const TYPE_Constantly_BigDipper:uint = CONST_SHORTCUTS.TYPE_Constantly_BigDipper;
      
      public static const TYPE_Constantly_Slave:uint = CONST_SHORTCUTS.TYPE_Constantly_Slave;
      
      public static const TYPE_Constantly_TongLing:uint = CONST_SHORTCUTS.TYPE_Constantly_TongLing;
      
      public static const CAPACITY_Shortcuts:int = CONST_SHORTCUTS.CONSTANTLY_TYPE.length;
      
      public function TLobbyShortcutConstantlyModes()
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
      
      public function get ShortcutModeStrengthen() : uint
      {
         return FShortcutModes[TYPE_Constantly_Strengthen];
      }
      
      public function set ShortcutModeStrengthen(param1:uint) : void
      {
         FShortcutModes[TYPE_Constantly_Strengthen] = param1;
      }
      
      public function get ShortcutModeArena() : uint
      {
         return FShortcutModes[TYPE_Constantly_Arena];
      }
      
      public function set ShortcutModeArena(param1:uint) : void
      {
         FShortcutModes[TYPE_Constantly_Arena] = param1;
      }
      
      public function get ShortcutModeBigDipper() : uint
      {
         return FShortcutModes[TYPE_Constantly_BigDipper];
      }
      
      public function set ShortcutModeBigDipper(param1:uint) : void
      {
         FShortcutModes[TYPE_Constantly_BigDipper] = param1;
      }
      
      public function get ShortcutModeMentorship() : uint
      {
         return FShortcutModes[TYPE_Constantly_Slave];
      }
      
      public function set ShortcutModeMentorship(param1:uint) : void
      {
         FShortcutModes[TYPE_Constantly_Slave] = param1;
      }
      
      public function get ShortcutModeTongLing() : uint
      {
         return FShortcutModes[TYPE_Constantly_TongLing];
      }
      
      public function set ShortcutModeTongLing(param1:uint) : void
      {
         FShortcutModes[TYPE_Constantly_TongLing] = param1;
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

