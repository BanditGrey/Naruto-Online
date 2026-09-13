package Processors.Game.Lobby.Common.Shortcuts
{
   import Resources.Constants.*;
   
   public class TLobbyShortcutActiveSpecialModes extends TLobbyShortcutModes
   {
      
      public static const SHORTCUTINDEX_CDK:uint = CONST_SHORTCUTS.TYPE_Active_Special_CDK;
      
      public static const CAPACITY_Shortcuts:int = CONST_SHORTCUTS.ACTIVE_SPECIAL_TYPE.length;
      
      public function TLobbyShortcutActiveSpecialModes()
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
      
      public function get ShortcutModeCDK() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_CDK];
      }
      
      public function set ShortcutModeCDK(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_CDK] = param1;
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

