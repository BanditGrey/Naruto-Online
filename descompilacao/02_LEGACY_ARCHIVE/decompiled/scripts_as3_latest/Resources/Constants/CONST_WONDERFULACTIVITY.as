package Resources.Constants
{
   import Processors.Game.Lobby.ActivityInner.Window.*;
   
   public class CONST_WONDERFULACTIVITY
   {
      
      public static const KEY_Activity_Vector:Vector.<uint> = Vector.<uint>([CONST_ACTIVITY_MODE.Activity_LevelRanking,CONST_ACTIVITY_MODE.Activity_PowerRanking,CONST_ACTIVITY_MODE.Activity_AreanRanking,CONST_ACTIVITY_MODE.Activity_PurpleHeros,CONST_ACTIVITY_MODE.Activity_GoldHeros,CONST_ACTIVITY_MODE.Activity_CampPass,CONST_ACTIVITY_MODE.Activity_KillHeroPass,CONST_ACTIVITY_MODE.Activity_MilitaryLv,CONST_ACTIVITY_MODE.Activity_TalismanLv,CONST_ACTIVITY_MODE.Activity_JadeCombin,CONST_ACTIVITY_MODE.Activity_SHeroLv,CONST_ACTIVITY_MODE.Activity_Inventorie,CONST_ACTIVITY_MODE.Activity_JadeCombinHF,CONST_ACTIVITY_MODE.Activity_PetRankHF,CONST_ACTIVITY_MODE.Activity_HFPowerRanking,CONST_ACTIVITY_MODE.Activity_RewardPsychicBeast]);
      
      public static const WonderfulActivityReference:Vector.<Class> = Vector.<Class>([TProcessorWindowActivityInnerUpgrade,TProcessorWindowActivityInnerFightingPower,TProcessorWindowActivityInnerArena,TProcessorWindowActivityInnerPurpleNinja,TProcessorWindowActivityInnerGoldNinja,TProcessorWindowActivityInnerCamp,TProcessorWindowActivityInnerKillHeros,TProcessorWindowActivityInnerProtagonist,TProcessorWindowActivityInnerTalisman,TProcessorWindowActivityInnerJade,TProcessorWindowActivityInnerSuperNinja,TProcessorWindowActivityInnerEquipment,TProcessorWindowActivityInnerJadeHF,TProcessorWindowActivityInnerPetRank,TProcessorWindowActivityInnerFightingPower,TProcessorWindowActivityInnerPsychicBeast]);
      
      public static const JmpWindowPositionAndLocation:Vector.<int> = Vector.<int>([-1,-1,-1,-1,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Arena,CONST_SHORTCUTS.POSITION_Additional,CONST_SHORTCUTS.TYPE_Additional_Tavern,CONST_SHORTCUTS.POSITION_Additional,CONST_SHORTCUTS.TYPE_Additional_Tavern,CONST_SHORTCUTS.POSITION_Map,CONST_SHORTCUTS.TYPE_Map_EnterWorldMap,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_KillHeros,CONST_SHORTCUTS.POSITION_Avatar,CONST_SHORTCUTS.TYPE_Avatar_Military,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Treasure,CONST_SHORTCUTS.POSITION_Additional,CONST_SHORTCUTS.TYPE_Additional_Jade,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_SuperHero,-1,-1,CONST_SHORTCUTS.POSITION_Additional,CONST_SHORTCUTS.TYPE_Additional_Jade,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_SummonPet,-1,-1,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_SummonPet]);
      
      public static const RESOURCE_LINK_MC_ARENA:String = "MC_Arena";
      
      public static const RESOURCE_LINK_MC_UPGRADE:String = "MC_Upgrade";
      
      public static const RESOURCE_LINK_MC_PROTAGONIST:String = "MC_Protagonist";
      
      public static const RESOURCE_LINK_MC_CAMP:String = "MC_Camp";
      
      public static const RESOURCE_LINK_MC_KILLHERO:String = "MC_KillHero";
      
      public static const RESOURCE_LINK_MC_TALISMAN:String = "MC_Talisman";
      
      public static const RESOURCE_LINK_MC_PURPLENINJA:String = "MC_PurpleNinja";
      
      public static const RESOURCE_LINK_MC_GOLDNINJA:String = "MC_GoldNinja";
      
      public static const RESOURCE_LINK_MC_SUPERNINJA:String = "MC_SuperNinja";
      
      public static const RESOURCE_LINK_MC_FIGHTINGPOWER:String = "MC_FightingPower";
      
      public static const RESOURCE_LINK_MC_EQUIPMENT:String = "MC_Equipment";
      
      public static const RESOURCE_LINK_MC_JADE:String = "MC_Jade";
      
      public static const RESOURCE_LINK_MC_JADEHF:String = "MC_JadeHF";
      
      public static const RESOURCE_LINK_MC_PETRANK:String = "MC_PetRank";
      
      public static const RESOURCE_LINK_MC_HFFIGHTINGPOWER:String = "MC_HFFightingPowe";
      
      public static const RESOURCE_LINK_MC_RewardPsychicBeast:String = "MC_RewardPsychicBeast";
      
      public static const RESOURCE_LINK_MC_Vector:Vector.<String> = Vector.<String>([RESOURCE_LINK_MC_UPGRADE,RESOURCE_LINK_MC_FIGHTINGPOWER,RESOURCE_LINK_MC_ARENA,RESOURCE_LINK_MC_PURPLENINJA,RESOURCE_LINK_MC_GOLDNINJA,RESOURCE_LINK_MC_CAMP,RESOURCE_LINK_MC_KILLHERO,RESOURCE_LINK_MC_PROTAGONIST,RESOURCE_LINK_MC_TALISMAN,RESOURCE_LINK_MC_JADE,RESOURCE_LINK_MC_SUPERNINJA,RESOURCE_LINK_MC_EQUIPMENT,RESOURCE_LINK_MC_JADEHF,RESOURCE_LINK_MC_PETRANK,RESOURCE_LINK_MC_HFFIGHTINGPOWER,RESOURCE_LINK_MC_RewardPsychicBeast]);
      
      public static const RequestRankType_Power:int = 1;
      
      public static const RequestRankType_Level:int = 2;
      
      public static const RequestRankType_HFPower:int = 3;
      
      public function CONST_WONDERFULACTIVITY()
      {
         super();
      }
   }
}

