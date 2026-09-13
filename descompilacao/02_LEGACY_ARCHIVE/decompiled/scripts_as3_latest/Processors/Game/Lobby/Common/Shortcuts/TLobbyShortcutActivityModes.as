package Processors.Game.Lobby.Common.Shortcuts
{
   import Logics.SLogicsCore;
   import Resources.Constants.*;
   
   public class TLobbyShortcutActivityModes extends TLobbyShortcutModes
   {
      
      public static const SHORTCUTINDEX_More:uint = CONST_SHORTCUTS.TYPE_Activity_More;
      
      public static const SHORTCUTINDEX_Arena:uint = CONST_SHORTCUTS.TYPE_Activity_Arena;
      
      public static const SHORTCUTINDEX_KillHeros:uint = CONST_SHORTCUTS.TYPE_Activity_KillHeros;
      
      public static const SHORTCUTINDEX_Sign:uint = CONST_SHORTCUTS.TYPE_Activity_Sign;
      
      public static const SHORTCUTINDEX_CopyHero:uint = CONST_SHORTCUTS.TYPE_Activity_CopyHero;
      
      public static const SHORTCUTINDEX_TreasureMap:uint = CONST_SHORTCUTS.TYPE_Activity_TreasureMap;
      
      public static const SHORTCUTINDEX_SuperHero:uint = CONST_SHORTCUTS.TYPE_Activity_SuperHero;
      
      public static const SHORTCUTINDEX_Mall:uint = CONST_SHORTCUTS.TYPE_Activity_Mall;
      
      public static const SHORTCUTINDEX_DailyQuest:uint = CONST_SHORTCUTS.TYPE_Activity_DailyQuest;
      
      public static const SHORTCUTINDEX_DailyActivity:uint = CONST_SHORTCUTS.TYPE_Activity_DailyActivity;
      
      public static const SHORTCUTINDEX_NarutoRoad:uint = CONST_SHORTCUTS.TYPE_Activity_NarutoRoad;
      
      public static const SHORTCUTINDEX_Slave:uint = CONST_SHORTCUTS.TYPE_Activity_Slave;
      
      public static const SHORTCUTINDEX_SevenKing:uint = CONST_SHORTCUTS.TYPE_Activity_SevenKing;
      
      public static const SHORTCUTINDEX_CrossServerWar:uint = CONST_SHORTCUTS.TYPE_Activity_CrossServerWar;
      
      public static const SHORTCUTINDEX_SubmitBug:uint = CONST_SHORTCUTS.TYPE_Activity_SubmitBug;
      
      public static const SHORTCUTINDEX_Magic:uint = CONST_SHORTCUTS.TYPE_Activity_Magic;
      
      public static const SHORTCUTINDEX_Moutain:uint = CONST_SHORTCUTS.TYPE_Activity_Moutain;
      
      public static const SHORTCUTINDEX_Tower:uint = CONST_SHORTCUTS.TYPE_Activity_Tower;
      
      public static const SHORTCUTINDEX_DailyWelfare:uint = CONST_SHORTCUTS.TYPE_Activity_DailyWelfare;
      
      public static const SHORTCUTINDEX_Palace:uint = CONST_SHORTCUTS.TYPE_Activity_Palace;
      
      public static const SHORTCUTINDEX_NijiaStar:uint = CONST_SHORTCUTS.TYPE_Activity_NijiaStar;
      
      public static const SHORTCUTINDEX_Ramen:uint = CONST_SHORTCUTS.TYPE_Activity_Ramen;
      
      public static const SHORTCUTINDEX_TopOrganization:uint = CONST_SHORTCUTS.TYPE_Activity_TopOrganization;
      
      public static const SHORTCUTINDEX_GroupBattle:uint = CONST_SHORTCUTS.TYPE_Activity_GroupBattle;
      
      public static const SHORTCUTINDEX_Laboratory:uint = CONST_SHORTCUTS.TYPE_Activity_Laboratory;
      
      public static const SHORTCUTINDEX_SixFairy:uint = CONST_SHORTCUTS.TYPE_Activity_SixFairy;
      
      public static const SHORTCUTINDEX_TopTeam:uint = CONST_SHORTCUTS.TYPE_Activity_TopTeam;
      
      public static const SHORTCUTINDEX_RebirthRealm:uint = CONST_SHORTCUTS.TYPE_Activity_RebirthRealm;
      
      public static const SHORTCUTINDEX_NijiaMystic:uint = CONST_SHORTCUTS.TYPE_Activity_NijiaMystic;
      
      public static const SHORTCUTINDEX_NarutoHelper:uint = CONST_SHORTCUTS.TYPE_Activity_NarutoHelper;
      
      public static const SHORTCUTINDEX_Choose:uint = CONST_SHORTCUTS.TYPE_Activity_Choose;
      
      public static const SHORTCUTINDEX_NinjaRelation:uint = CONST_SHORTCUTS.TYPE_Activity_NinjaRelation;
      
      public static const SHORTCUTINDEX_NinjaHostel:uint = CONST_SHORTCUTS.TYPE_Activity_NinjaHostel;
      
      public static const SHORTCUTINDEX_BloodFete:uint = CONST_SHORTCUTS.TYPE_Activity_BloodFete;
      
      public static const SHORTCUTINDEX_EpicEquip:uint = CONST_SHORTCUTS.TYPE_Activity_EpicEquip;
      
      public static const SHORTCUTINDEX_Taboo:uint = CONST_SHORTCUTS.TYPE_Activity_Taboo;
      
      public static const SHORTCUTINDEX_Awaken:uint = CONST_SHORTCUTS.TYPE_Activity_Awaken;
      
      public static const SHORTCUTINDEX_TransmigrationAccessory:uint = CONST_SHORTCUTS.TYPE_Activity_TransmigrationAccessory;
      
      public static const SHORTCUTINDEX_EightDoor:uint = CONST_SHORTCUTS.TYPE_Activity_EightDoor;
      
      public static const SHORTCUTINDEX_TheWorldTree:uint = CONST_SHORTCUTS.TYPE_Activity_TheWorldTree;
      
      public static const SHORTCUTINDEX_Undertown:uint = CONST_SHORTCUTS.TYPE_Activity_Undertown;
      
      public static const TYPE_Activity_LostShenQi:uint = CONST_SHORTCUTS.TYPE_Activity_LostShenQi;
      
      public static const TYPE_Activity_Wing:uint = CONST_SHORTCUTS.TYPE_Activity_Wing;
      
      public static const TYPE_Activity_Challenge:uint = CONST_SHORTCUTS.TYPE_Activity_Challenge;
      
      public static const TYPE_Activity_Illustrated:uint = CONST_SHORTCUTS.TYPE_Activity_Illustrated;
      
      public static const TYPE_Activity_Aline:uint = CONST_SHORTCUTS.TYPE_Activity_Aline;
      
      public static const TYPE_Activity_KingWar:uint = CONST_SHORTCUTS.TYPE_Activity_KingWar;
      
      public static const TYPE_Activity_Medal:uint = CONST_SHORTCUTS.TYPE_Activity_Medal;
      
      public static const TYPE_Activity_InviteCode:uint = CONST_SHORTCUTS.TYPE_Activity_InviteCode;
      
      public static const TYPE_Activity_WuXing:uint = CONST_SHORTCUTS.TYPE_Activity_WuXing;
      
      public static const TYPE_Activity_GlobalBattle:uint = CONST_SHORTCUTS.TYPE_Activity_GlobalBattle;
      
      public static const TYPE_Activity_Emblem:uint = CONST_SHORTCUTS.TYPE_Activity_Emblem;
      
      public static const TYPE_Activity_WorldMatch:uint = CONST_SHORTCUTS.TYPE_Activity_WorldMatch;
      
      public static const TYPE_Activity_SummonBattle:uint = CONST_SHORTCUTS.TYPE_Activity_SummonBattle;
      
      public static const TYPE_Activity_NinjaTalent:uint = CONST_SHORTCUTS.TYPE_Activity_NinjaTalent;
      
      public static const TYPE_Activity_ChallengCamp:uint = CONST_SHORTCUTS.TYPE_Activity_ChallengCamp;
      
      public static const TYPE_Activity_GlobalBoss:uint = CONST_SHORTCUTS.TYPE_Activity_GlobalBoss;
      
      public static const TYPE_Activity_Recruit:uint = CONST_SHORTCUTS.TYPE_Activity_Recruit;
      
      public static const TYPE_Activity_CrossSlave:uint = CONST_SHORTCUTS.TYPE_Activity_CrossSlave;
      
      public static const CAPACITY_Shortcuts:int = CONST_SHORTCUTS.ACTIVITYS_TYPE.length;
      
      public function TLobbyShortcutActivityModes()
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
      
      public function get ShortcutModeMore() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_More];
      }
      
      public function set ShortcutModeMore(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_More] = param1;
      }
      
      public function get ShortcutModeSubmitBug() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_SubmitBug];
      }
      
      public function set ShortcutModeSubmitBug(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_SubmitBug] = param1;
      }
      
      public function get ShortcutModeKillHeros() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_KillHeros];
      }
      
      public function set ShortcutModeKillHeros(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_KillHeros] = param1;
      }
      
      public function get ShortcutModeArena() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Arena];
      }
      
      public function set ShortcutModeArena(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Arena] = param1;
      }
      
      public function get ShortcutModeSign() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Sign];
      }
      
      public function set ShortcutModeSign(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Sign] = param1;
      }
      
      public function get ShortcutModeCopyHero() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_CopyHero];
      }
      
      public function set ShortcutModeCopyHero(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_CopyHero] = param1;
      }
      
      public function get ShortcutModeTreasureMap() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_TreasureMap];
      }
      
      public function set ShortcutModeTreasureMap(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_TreasureMap] = param1;
      }
      
      public function get ShortcutModeSuperHero() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_SuperHero];
      }
      
      public function set ShortcutModeSuperHero(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_SuperHero] = param1;
      }
      
      public function get ShortcutModeMall() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Mall];
      }
      
      public function set ShortcutModeMall(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Mall] = param1;
      }
      
      public function get ShortcutModeDailyQuest() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_DailyQuest];
      }
      
      public function set ShortcutModeDailyQuest(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_DailyQuest] = param1;
      }
      
      public function get ShortcutModeDailyActivity() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_DailyActivity];
      }
      
      public function set ShortcutModeDailyActivity(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_DailyActivity] = param1;
      }
      
      public function get ShortcutModeNarutoRoad() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_NarutoRoad];
      }
      
      public function set ShortcutModeNarutoRoad(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_NarutoRoad] = param1;
      }
      
      public function get ShortcutModeSlave() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Slave];
      }
      
      public function set ShortcutModeSlave(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Slave] = param1;
      }
      
      public function get ShortcutModeSevenKing() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_SevenKing];
      }
      
      public function set ShortcutModeSevenKing(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_SevenKing] = param1;
      }
      
      public function get ShortcutModeCrossServerWar() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_CrossServerWar];
      }
      
      public function set ShortcutModeCrossServerWar(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_CrossServerWar] = param1;
      }
      
      public function get ShortcutModeMagic() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Magic];
      }
      
      public function set ShortcutModeMagic(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Magic] = param1;
      }
      
      public function get ShortcutModeMoutain() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Moutain];
      }
      
      public function set ShortcutModeMoutain(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Moutain] = param1;
      }
      
      public function get ShortcutModeTower() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Tower];
      }
      
      public function set ShortcutModeTower(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Tower] = param1;
      }
      
      public function get ShortcutModeDailyWelfare() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_DailyWelfare];
      }
      
      public function set ShortcutModeDailyWelfare(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_DailyWelfare] = param1;
      }
      
      public function get ShortcutModePalace() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Palace];
      }
      
      public function set ShortcutModePalace(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Palace] = param1;
      }
      
      public function get ShortcutModeNijiaStar() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_NijiaStar];
      }
      
      public function set ShortcutModeNijiaStar(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_NijiaStar] = param1;
      }
      
      public function get ShortcutModeRamen() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Ramen];
      }
      
      public function set ShortcutModeRamen(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Ramen] = param1;
      }
      
      public function get ShortcutTopOrganization() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_TopOrganization];
      }
      
      public function set ShortcutTopOrganization(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_TopOrganization] = param1;
      }
      
      public function get ShortcutGroupBattle() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_GroupBattle];
      }
      
      public function set ShortcutGroupBattle(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_GroupBattle] = param1;
      }
      
      public function get ShortcutLaboratory() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Laboratory];
      }
      
      public function set ShortcutLaboratory(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Laboratory] = param1;
      }
      
      public function get ShortcutSixFairy() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_SixFairy];
      }
      
      public function set ShortcutSixFairy(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_SixFairy] = param1;
      }
      
      public function get ShortcutTopTeam() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_TopTeam];
      }
      
      public function set ShortcutTopTeam(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_TopTeam] = param1;
      }
      
      public function get ShortcutRebirthRealm() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_RebirthRealm];
      }
      
      public function set ShortcutRebirthRealm(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_RebirthRealm] = param1;
      }
      
      public function get ShortcutNijiaMystic() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_NijiaMystic];
      }
      
      public function set ShortcutNijiaMystic(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_NijiaMystic] = param1;
      }
      
      public function get ShortcutChoose() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Choose];
      }
      
      public function set ShortcutChoose(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Choose] = param1;
      }
      
      public function get ShortcutNarutoHelper() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_NarutoHelper];
      }
      
      public function set ShortcutNarutoHelper(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_NarutoHelper] = param1;
      }
      
      public function get ShortcutNinjaRelation() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_NinjaRelation];
      }
      
      public function set ShortcutNinjaRelation(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_NinjaRelation] = param1;
      }
      
      public function get ShortcutNinjaHostel() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_NinjaHostel];
      }
      
      public function set ShortcutNinjaHostel(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_NinjaHostel] = param1;
      }
      
      public function get ShortcutBloodFete() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_BloodFete];
      }
      
      public function set ShortcutBloodFete(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_BloodFete] = param1;
      }
      
      public function get ShortcutEpicEquip() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_EpicEquip];
      }
      
      public function set ShortcutEpicEquip(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_EpicEquip] = param1;
      }
      
      public function get ShortcutTaboo() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Taboo];
      }
      
      public function set ShortcutTaboo(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Taboo] = param1;
      }
      
      public function get ShortcutAwaken() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Awaken];
      }
      
      public function set ShortcutAwaken(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Awaken] = param1;
      }
      
      public function get ShortcutTransmigrationAccessory() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_TransmigrationAccessory];
      }
      
      public function set ShortcutTransmigrationAccessory(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_TransmigrationAccessory] = param1;
      }
      
      public function get ShortcutEightDoor() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_EightDoor];
      }
      
      public function set ShortcutEightDoor(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_EightDoor] = param1;
      }
      
      public function get ShortcutTheWorldTree() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_TheWorldTree];
      }
      
      public function set ShortcutTheWorldTree(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_TheWorldTree] = param1;
      }
      
      public function get ShortcutUndertown() : uint
      {
         return FShortcutModes[SHORTCUTINDEX_Undertown];
      }
      
      public function set ShortcutUndertown(param1:uint) : void
      {
         FShortcutModes[SHORTCUTINDEX_Undertown] = param1;
      }
      
      public function get ShortcutLostShenQi() : uint
      {
         return FShortcutModes[TYPE_Activity_LostShenQi];
      }
      
      public function set ShortcutLostShenQi(param1:uint) : void
      {
         FShortcutModes[TYPE_Activity_LostShenQi] = param1;
      }
      
      public function get ShortcutWing() : uint
      {
         return FShortcutModes[TYPE_Activity_Wing];
      }
      
      public function set ShortcutWing(param1:uint) : void
      {
         FShortcutModes[TYPE_Activity_Wing] = param1;
      }
      
      public function get ShortcutChallenge() : uint
      {
         return FShortcutModes[TYPE_Activity_Challenge];
      }
      
      public function set ShortcutChallenge(param1:uint) : void
      {
         FShortcutModes[TYPE_Activity_Challenge] = param1;
      }
      
      public function get ShortcutIllustrated() : uint
      {
         return FShortcutModes[TYPE_Activity_Illustrated];
      }
      
      public function set ShortcutIllustrated(param1:uint) : void
      {
         FShortcutModes[TYPE_Activity_Illustrated] = param1;
      }
      
      public function get ShortcutAline() : uint
      {
         return FShortcutModes[TYPE_Activity_Aline];
      }
      
      public function set ShortcutAline(param1:uint) : void
      {
         FShortcutModes[TYPE_Activity_Aline] = param1;
      }
      
      public function get ShortcutKingwar() : uint
      {
         return FShortcutModes[TYPE_Activity_KingWar];
      }
      
      public function set ShortcutKingwar(param1:uint) : void
      {
         FShortcutModes[TYPE_Activity_KingWar] = param1;
      }
      
      public function get ShortcutMedal() : uint
      {
         return FShortcutModes[TYPE_Activity_Medal];
      }
      
      public function set ShortcutMedal(param1:uint) : void
      {
         FShortcutModes[TYPE_Activity_Medal] = param1;
      }
      
      public function get ShortcutInviteCode() : uint
      {
         return FShortcutModes[TYPE_Activity_InviteCode];
      }
      
      public function set ShortcutInviteCode(param1:uint) : void
      {
         FShortcutModes[TYPE_Activity_InviteCode] = param1;
      }
      
      public function get ShortcutWuXing() : uint
      {
         return FShortcutModes[TYPE_Activity_WuXing];
      }
      
      public function set ShortcutWuXing(param1:uint) : void
      {
         FShortcutModes[TYPE_Activity_WuXing] = param1;
      }
      
      public function get ShortcutGlobalBattle() : uint
      {
         return FShortcutModes[TYPE_Activity_GlobalBattle];
      }
      
      public function set ShortcutGlobalBattle(param1:uint) : void
      {
         FShortcutModes[TYPE_Activity_GlobalBattle] = param1;
      }
      
      public function get ShortcutEmblem() : uint
      {
         return FShortcutModes[TYPE_Activity_Emblem];
      }
      
      public function set ShortcutEmblem(param1:uint) : void
      {
         FShortcutModes[TYPE_Activity_Emblem] = param1;
      }
      
      public function get ShortcutWorldMatch() : uint
      {
         return FShortcutModes[TYPE_Activity_WorldMatch];
      }
      
      public function set ShortcutWorldMatch(param1:uint) : void
      {
         FShortcutModes[TYPE_Activity_WorldMatch] = param1;
      }
      
      public function get ShortcutSummonBattle() : uint
      {
         return FShortcutModes[TYPE_Activity_SummonBattle];
      }
      
      public function set ShortcutSummonBattle(param1:uint) : void
      {
         FShortcutModes[TYPE_Activity_SummonBattle] = param1;
      }
      
      public function get ShortcutNinjaTalent() : uint
      {
         return FShortcutModes[TYPE_Activity_NinjaTalent];
      }
      
      public function set ShortcutNinjaTalent(param1:uint) : void
      {
         FShortcutModes[TYPE_Activity_NinjaTalent] = param1;
      }
      
      public function get ShortcutChallengCamp() : uint
      {
         return FShortcutModes[TYPE_Activity_ChallengCamp];
      }
      
      public function set ShortcutChallengCamp(param1:uint) : void
      {
         FShortcutModes[TYPE_Activity_ChallengCamp] = param1;
      }
      
      public function get ShortcutGlobalBoss() : uint
      {
         return FShortcutModes[TYPE_Activity_GlobalBoss];
      }
      
      public function set ShortcutGlobalBoss(param1:uint) : void
      {
         FShortcutModes[TYPE_Activity_GlobalBoss] = param1;
      }
      
      public function get ShortcutRecruit() : uint
      {
         return FShortcutModes[TYPE_Activity_Recruit];
      }
      
      public function set ShortcutRecruit(param1:uint) : void
      {
         FShortcutModes[TYPE_Activity_Recruit] = param1;
      }
      
      public function get ShortcutCrossSlave() : uint
      {
         return FShortcutModes[TYPE_Activity_CrossSlave];
      }
      
      public function set ShortcutCrossSlave(param1:uint) : void
      {
         FShortcutModes[TYPE_Activity_CrossSlave] = param1;
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
      
      public function SetAllShortcutShow() : void
      {
         this.ShortcutModeMore = uint(!SLogicsCore.ButtonStatus[CONST_SHORTCUTS.TYPE_Activity_More]);
         this.ShortcutModeArena = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutModeKillHeros = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutModeSign = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutModeCopyHero = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutModeTreasureMap = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutModeSuperHero = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutModeMall = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutModeDailyQuest = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutModeDailyActivity = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutModeNarutoRoad = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutModeSlave = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutModeSevenKing = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutModeCrossServerWar = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutModeMagic = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeMoutain = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutModeTower = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutModeDailyWelfare = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutModePalace = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutModeNijiaStar = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeRamen = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutTopOrganization = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutGroupBattle = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutLaboratory = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutSixFairy = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutRebirthRealm = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutNijiaMystic = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutChoose = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutNarutoHelper = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutTopTeam = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutNinjaRelation = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutNinjaHostel = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutBloodFete = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutEpicEquip = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutTaboo = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutAwaken = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutTransmigrationAccessory = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutEightDoor = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutTheWorldTree = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutUndertown = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutLostShenQi = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutWing = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutChallenge = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutIllustrated = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutAline = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutKingwar = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutMedal = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutInviteCode = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutWuXing = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutGlobalBattle = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutEmblem = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutWorldMatch = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutSummonBattle = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutNinjaTalent = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutChallengCamp = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutGlobalBoss = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutRecruit = TLobbyShortcutMode.SHORTCUTMODE_Show;
         this.ShortcutCrossSlave = TLobbyShortcutMode.SHORTCUTMODE_Show;
      }
      
      public function SetAllShortcutHide() : void
      {
         this.ShortcutModeMore = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeArena = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeKillHeros = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeSign = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeCopyHero = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeTreasureMap = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeSuperHero = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeMall = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeDailyQuest = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeDailyActivity = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeNarutoRoad = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeSlave = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeSevenKing = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeCrossServerWar = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeMagic = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeMoutain = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeTower = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeDailyWelfare = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModePalace = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeNijiaStar = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutModeRamen = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutTopOrganization = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutGroupBattle = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutLaboratory = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutSixFairy = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutRebirthRealm = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutNijiaMystic = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutChoose = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutChoose = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutNarutoHelper = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutTopTeam = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutNinjaRelation = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutNinjaHostel = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutBloodFete = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutEpicEquip = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutTaboo = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutAwaken = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutTransmigrationAccessory = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutEightDoor = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutTheWorldTree = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutUndertown = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutLostShenQi = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutWing = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutChallenge = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutIllustrated = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutAline = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutKingwar = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutMedal = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutInviteCode = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutWuXing = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutGlobalBattle = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutEmblem = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutWorldMatch = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutSummonBattle = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutNinjaTalent = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutChallengCamp = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutGlobalBoss = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutRecruit = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         this.ShortcutCrossSlave = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
      }
   }
}

