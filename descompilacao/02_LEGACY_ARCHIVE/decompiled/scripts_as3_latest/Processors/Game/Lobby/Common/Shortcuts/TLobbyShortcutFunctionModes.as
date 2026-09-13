package Processors.Game.Lobby.Common.Shortcuts
{
   import Resources.Constants.*;
   
   public class TLobbyShortcutFunctionModes extends TLobbyShortcutModes
   {
      
      public static const SHORTCUTINDEX_Heros:uint = CONST_SHORTCUTS.TYPE_Function_Heros;
      
      public static const SHORTCUTINDEX_Star:uint = CONST_SHORTCUTS.TYPE_Function_Star;
      
      public static const SHORTCUTINDEX_TacticalDeployment:uint = CONST_SHORTCUTS.TYPE_Function_TacticalDeployment;
      
      public static const SHORTCUTINDEX_InheritPractice:uint = CONST_SHORTCUTS.TYPE_Function_InheritPractice;
      
      public static const SHORTCUTINDEX_Backpack:uint = CONST_SHORTCUTS.TYPE_Function_Backpack;
      
      public static const SHORTCUTINDEX_Treasure:uint = CONST_SHORTCUTS.TYPE_Function_Treasure;
      
      public static const SHORTCUTINDEX_SummonPet:uint = CONST_SHORTCUTS.TYPE_Function_SummonPet;
      
      public static const SHORTCUTINDEX_Strengthen:uint = CONST_SHORTCUTS.TYPE_Function_Strengthen;
      
      public static const SHORTCUTINDEX_Mail:uint = CONST_SHORTCUTS.TYPE_Function_Mail;
      
      public static const SHORTCUTINDEX_TongLing:uint = CONST_SHORTCUTS.TYPE_Function_TongLing;
      
      public static const SHORTCUTINDEX_OrganiZation:uint = CONST_SHORTCUTS.TYPE_Function_OrganiZation;
      
      public static const SHORTCUTINDEX_Return:uint = CONST_SHORTCUTS.TYPE_Function_Return;
      
      public static const CAPACITY_Shortcuts:int = CONST_SHORTCUTS.FUNCTIONS_TYPE.length;
      
      public function TLobbyShortcutFunctionModes()
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
      
      public function get ShortcutModeHero() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Heros];
      }
      
      public function set ShortcutModeHero(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Heros] = param1;
      }
      
      public function get ShortcutModeStar() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Star];
      }
      
      public function set ShortcutModeStar(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Star] = param1;
      }
      
      public function get ShortcutModeTacticalDeployment() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_TacticalDeployment];
      }
      
      public function set ShortcutModeTacticalDeployment(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_TacticalDeployment] = param1;
      }
      
      public function get ShortcutModeInheritPractice() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_InheritPractice];
      }
      
      public function set ShortcutModeInheritPractice(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_InheritPractice] = param1;
      }
      
      public function get ShortcutModeBackpack() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Backpack];
      }
      
      public function set ShortcutModeBackpack(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Backpack] = param1;
      }
      
      public function get ShortcutModeTreasure() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Treasure];
      }
      
      public function set ShortcutModeTreasure(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Treasure] = param1;
      }
      
      public function get ShortcutModeSummonPet() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_SummonPet];
      }
      
      public function set ShortcutModeSummonPet(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_SummonPet] = param1;
      }
      
      public function get ShortcutModeStrengthen() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Strengthen];
      }
      
      public function set ShortcutModeStrengthen(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Strengthen] = param1;
      }
      
      public function get ShortcutModeMail() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Mail];
      }
      
      public function set ShortcutModeMail(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Mail] = param1;
      }
      
      public function get ShortcutModeTongLing() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_TongLing];
      }
      
      public function set ShortcutModeTongLing(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_TongLing] = param1;
      }
      
      public function get ShortcutModeOrganiZation() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_OrganiZation];
      }
      
      public function set ShortcutModeOrganiZation(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_OrganiZation] = param1;
      }
      
      public function get ShortcutModeReturn() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Return];
      }
      
      public function set ShortcutModeReturn(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Return] = param1;
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

