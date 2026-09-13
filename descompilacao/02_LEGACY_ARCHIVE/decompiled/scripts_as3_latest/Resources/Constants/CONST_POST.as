package Resources.Constants
{
   import Logics.DatebaseVO.VO.Json.Post.*;
   
   public class CONST_POST
   {
      
      public static const CLASSNAMECOMBAT_VEC:Vector.<String> = Vector.<String>(["HeroName","HeroNameQuality","HeroNameQualityUnderline","PlayerQualityUnderline","PlayerQualityUnderline1","PlayerCountryUnderline","Country","CountryColor","Job","Boss","Item","ItemUnderline","Reward","EventName","Name","Number","Corps","Single","OutlandArmy","CityQuality","Pet","OutLineUnderline","BB","Difficulty","LeagueMap"]);
      
      public static const CLASSNAME_VEC:Vector.<Class> = Vector.<Class>([THeroName,THeroNameQuality,THeroNameQualityUnderline,TPlayerQualityUnderline,TPlayerQualityUnderline,TPlayerCountryUnderline,TCountry,TCountryColor,TJob,TBoss,TItem,TItemUnderline,TReward,TEventName,TName,TNumber,TCorps,TSingle,TOutlandArmy,TCityQuality,TPet,TLinkURL,TBBUnderline,TDifficulty,TLeagueMap]);
      
      public static const CLASSNAME_NOUNDERLINE_VEC:Vector.<Class> = Vector.<Class>([THeroName,THeroNameQuality,TCountry,TCountryColor,TJob,TBoss,TItem,TReward,TEventName,TName,TNumber,TCorps,TSingle,TOutlandArmy,TCityQuality,TPet]);
      
      public static const CLASSNAME_UNDERLINE_VEC:Vector.<Class> = Vector.<Class>([THeroNameQualityUnderline,TPlayerQualityUnderline,TPlayerCountryUnderline,TItemUnderline,TLinkURL,TBBUnderline]);
      
      protected static const EventID_Avatar_Hero:uint = 1010;
      
      protected static const EventID_Avatar_Military:uint = 1020;
      
      protected static const EventID_Avatar_VIP:uint = 1030;
      
      protected static const EventID_Function_Heros:uint = 1040;
      
      protected static const EventID_Function_Star:uint = 1050;
      
      protected static const EventID_Function_TacticalDeployment:uint = 1060;
      
      protected static const EventID_Function_Backpack_Default:uint = 1070;
      
      protected static const EventID_Function_Backpack_Equipment:uint = 1071;
      
      protected static const EventID_Function_Backpack_Material:uint = 1072;
      
      protected static const EventID_Function_Backpack_Jade:uint = 1073;
      
      protected static const EventID_Function_Backpack_Talisman:uint = 1074;
      
      protected static const EventID_Function_Talisman_Equip:uint = 1080;
      
      protected static const EventID_Function_Talisman_Upgrade:uint = 1081;
      
      protected static const EventID_Function_Talisman_Transition:uint = 1082;
      
      protected static const EventID_Function_Talisman_Levelup:uint = 1083;
      
      protected static const EventID_Function_Pet_Levelup:uint = 1090;
      
      protected static const EventID_Function_Pet_ChangePet:uint = 1091;
      
      protected static const EventID_Function_Pet_TrainSoul:uint = 1092;
      
      protected static const EventID_Function_Smithy_Strengthen:uint = 1100;
      
      protected static const EventID_Function_Smithy_Refined:uint = 1101;
      
      protected static const EventID_Function_Smithy_Inherit:uint = 1102;
      
      protected static const EventID_Fucntion_Mail_Inbox:uint = 1110;
      
      protected static const EventID_Fucntion_Mail_Sentbox:uint = 1111;
      
      protected static const EventID_Function_Ramen:uint = 1120;
      
      protected static const EventID_Function_OrganiZation:uint = 1130;
      
      protected static const EventID_Function_Main:uint = 1131;
      
      protected static const EventID_Function_FightPet:uint = 1132;
      
      protected static const EventID_Map_Quest:uint = 1140;
      
      protected static const EventID_Map_Friend:uint = 1150;
      
      protected static const EventID_Map_Friend_Black:uint = 1151;
      
      protected static const EventID_Map_Friend_recommend:uint = 1152;
      
      protected static const EventID_Activity_DailyQuest:uint = 1160;
      
      protected static const EventID_Activity_Mall:uint = 1170;
      
      protected static const EventID_Activity_SuperHero:uint = 1180;
      
      protected static const EventID_Activity_TreasureMap:uint = 1190;
      
      protected static const EventID_Activity_CopyHero:uint = 1200;
      
      protected static const EventID_Activity_CopyHero_Strenthen:uint = 1201;
      
      protected static const EventID_Activity_DailySign:uint = 1210;
      
      protected static const EventID_Activity_DailySign_Exchange:uint = 1211;
      
      protected static const EventID_Activity_KillHeros:uint = 1220;
      
      protected static const EventID_Activity_Arena:uint = 1230;
      
      protected static const EventID_Activity_DailyActivity:uint = 1240;
      
      protected static const EventID_Activity_OrganizitionWar:uint = 1241;
      
      protected static const EventID_Activity_FightPet:uint = 1242;
      
      protected static const EventID_Activity_CItyDefend:uint = 1243;
      
      protected static const EventID_Additional_Tavern:uint = 1250;
      
      protected static const EventID_Additional_MakeEquip:uint = 1260;
      
      protected static const EventID_Additional_Jade:uint = 1270;
      
      protected static const EventID_Additional_Jade_Combine:uint = 1271;
      
      protected static const TYPE_Avatar_Hero:uint = 101;
      
      protected static const TYPE_Avatar_Military:uint = 102;
      
      protected static const TYPE_Avatar_VIP:uint = 103;
      
      protected static const TYPE_Function_Heros:uint = 104;
      
      protected static const TYPE_Function_Star:uint = 105;
      
      protected static const TYPE_Function_TacticalDeployment:uint = 106;
      
      protected static const TYPE_Function_Backpack:uint = 107;
      
      protected static const TYPE_Function_Talisman:uint = 108;
      
      protected static const TYPE_Function_Pet:uint = 109;
      
      protected static const TYPE_Function_Smithy:uint = 110;
      
      protected static const TYPE_Fucntion_Mail:uint = 111;
      
      protected static const TYPE_Activity_Ramen:uint = 112;
      
      protected static const TYPE_Function_OrganiZation:uint = 113;
      
      protected static const TYPE_Map_Quest:uint = 114;
      
      protected static const TYPE_Map_Friend:uint = 115;
      
      protected static const TYPE_Activity_DailyQuest:uint = 116;
      
      protected static const TYPE_Activity_Mall:uint = 117;
      
      protected static const TYPE_Activity_SuperHero:uint = 118;
      
      protected static const TYPE_Activity_TreasureMap:uint = 119;
      
      protected static const TYPE_Activity_CopyHero:uint = 120;
      
      protected static const TYPE_Activity_DailySign:uint = 121;
      
      protected static const TYPE_Activity_KillHeros:uint = 122;
      
      protected static const TYPE_Activity_Arena:uint = 123;
      
      protected static const TYPE_Activity_DailyActivity:uint = 124;
      
      protected static const TYPE_Additional_Tavern:uint = 125;
      
      protected static const TYPE_Additional_MakeEquip:uint = 126;
      
      protected static const TYPE_Additional_Jade:uint = 127;
      
      protected static const TYPE_Function_TongLing:uint = 128;
      
      protected static const TYPE_Activity_CrossServerWar:uint = 129;
      
      protected static const TYPE_Activity_Palace:uint = 130;
      
      protected static const TYPE_Activity_GroupBattle:uint = 131;
      
      protected static const TYPE_Activity_Laboratory:uint = 132;
      
      protected static const TYPE_Activity_TopTeam:uint = 133;
      
      protected static const TYPE_Activity_BloodFete:uint = 134;
      
      protected static const TYPE_Activity_EpicEquip:uint = 135;
      
      protected static const TYPE_Activity_Taboo:uint = 136;
      
      public static const TYPE_Avatar:Vector.<Array> = Vector.<Array>([[TYPE_Avatar_Hero,0],[TYPE_Avatar_Military,1],[TYPE_Avatar_VIP,2]]);
      
      public static const TYPE_Function:Vector.<Array> = Vector.<Array>([[TYPE_Function_Heros,0],[TYPE_Function_Star,1],[TYPE_Function_TacticalDeployment,2],[TYPE_Function_Backpack,3],[TYPE_Function_Talisman,4],[TYPE_Function_Pet,5],[TYPE_Function_Smithy,6],[TYPE_Fucntion_Mail,7],[TYPE_Function_TongLing,8],[TYPE_Function_OrganiZation,9]]);
      
      public static const TYPE_Map:Vector.<Array> = Vector.<Array>([[TYPE_Map_Quest,2],[TYPE_Map_Friend,3]]);
      
      public static const TYPE_Activity:Vector.<Array> = Vector.<Array>([[TYPE_Activity_DailyQuest,8],[TYPE_Activity_Mall,7],[TYPE_Activity_SuperHero,6],[TYPE_Activity_TreasureMap,5],[TYPE_Activity_CopyHero,4],[TYPE_Activity_DailySign,3],[TYPE_Activity_KillHeros,2],[TYPE_Activity_Arena,1],[TYPE_Activity_DailyActivity,9],[TYPE_Activity_Ramen,21],[TYPE_Activity_CrossServerWar,13],[TYPE_Activity_Palace,19],[TYPE_Activity_GroupBattle,23],[TYPE_Activity_TopTeam,28]]);
      
      public static const TYPE_Additional:Vector.<Array> = Vector.<Array>([[TYPE_Additional_Tavern,0],[TYPE_Additional_MakeEquip,2],[TYPE_Additional_Jade,1]]);
      
      public static const TYPES:Vector.<Vector.<Array>> = Vector.<Vector.<Array>>([TYPE_Function,TYPE_Activity,TYPE_Avatar,TYPE_Map,TYPE_Additional]);
      
      public static const POSITIONS:Vector.<uint> = Vector.<uint>([CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.POSITION_Avatar,CONST_SHORTCUTS.POSITION_Map,CONST_SHORTCUTS.POSITION_Additional]);
      
      public function CONST_POST()
      {
         super();
      }
   }
}

