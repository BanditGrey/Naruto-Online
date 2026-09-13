package Resources.Constants
{
   public class CONST_INVENTORY
   {
      
      public static const CATEGORY_Normal:uint = 1;
      
      public static const CATEGORY_Equipment:uint = 2;
      
      public static const CATEGORY_Gem:uint = 3;
      
      public static const CATEGORY_Treasure:uint = 4;
      
      public static const CATEGORY_Material:uint = 5;
      
      public static const CATEGORY_Accessories:uint = 6;
      
      public static const CATEGORY_Medals:uint = 7;
      
      public static const CATEGORY_Equipments:Vector.<uint> = Vector.<uint>([CATEGORY_Equipment,CATEGORY_Treasure,CATEGORY_Accessories,CATEGORY_Medals]);
      
      public static const CATEGORY_Appliances:Vector.<uint> = Vector.<uint>([CATEGORY_Normal,CATEGORY_Gem,CATEGORY_Material]);
      
      public static const CATEGORYSECOND_Weapon:uint = 1;
      
      public static const CATEGORYSECOND_Headgear:uint = 2;
      
      public static const CATEGORYSECOND_Clothing:uint = 3;
      
      public static const CATEGORYSECOND_Cloak:uint = 4;
      
      public static const CATEGORYSECOND_Shoe:uint = 5;
      
      public static const CATEGORYSECOND_Sash:uint = 6;
      
      public static const INDEXEQUIPMENTMOUNTED:Vector.<uint> = Vector.<uint>([CATEGORYSECOND_Weapon,CATEGORYSECOND_Headgear,CATEGORYSECOND_Clothing,CATEGORYSECOND_Cloak,CATEGORYSECOND_Shoe,CATEGORYSECOND_Sash]);
      
      public static const CATEGORYSECOND_TreasurePower:uint = 7;
      
      public static const CATEGORYSECOND_TreasureIntelligence:uint = 8;
      
      public static const CATEGORYSECOND_TreasureAgile:uint = 9;
      
      public static const CATEGORYSECOND_TreasureLife:uint = 10;
      
      public static const INDEXTREASUREMOUNTED:Vector.<uint> = Vector.<uint>([CATEGORYSECOND_TreasurePower,CATEGORYSECOND_TreasureIntelligence,CATEGORYSECOND_TreasureAgile,CATEGORYSECOND_TreasureLife]);
      
      public static const CATEGORYSECOND_Headwear:uint = 11;
      
      public static const CATEGORYSECOND_Jade:uint = 12;
      
      public static const CATEGORYSECOND_Bracelet:uint = 13;
      
      public static const CATEGORYSECOND_Glove:uint = 14;
      
      public static const CATEGORYSECOND_Necklace:uint = 15;
      
      public static const CATEGORYSECOND_Amulet:uint = 16;
      
      public static const CATEGORYSECOND_HandChain:uint = 17;
      
      public static const CATEGORYSECOND_Ring:uint = 18;
      
      public static const INDEXACCESSORIES:Vector.<uint> = Vector.<uint>([CATEGORYSECOND_Headwear,CATEGORYSECOND_Jade,CATEGORYSECOND_Bracelet,CATEGORYSECOND_Glove,CATEGORYSECOND_Necklace,CATEGORYSECOND_Amulet,CATEGORYSECOND_HandChain,CATEGORYSECOND_Ring]);
      
      public static const CATEGORYSECOND_FormerArmy:uint = 19;
      
      public static const CATEGORYSECOND_MiddleArmy:uint = 20;
      
      public static const CATEGORYSECOND_BackArmy:uint = 21;
      
      public static const INDEXMEDALS:Vector.<uint> = Vector.<uint>([CATEGORYSECOND_FormerArmy,CATEGORYSECOND_MiddleArmy,CATEGORYSECOND_BackArmy]);
      
      public static const CATEGORYSECOND_ExperienceReel:uint = 90;
      
      public static const CATEGORYSECOND_PsychicReel:uint = 71;
      
      public static const CATEGORYSECOND_TreasureUpgrade:uint = 73;
      
      public static const CATEGORYSECOND_TreasureTransform:uint = 74;
      
      public static const CATEGORYSECOND_RefiningSoul:uint = 75;
      
      public static const CATEGORYSECOND_BagExtend:uint = 70;
      
      public static const CATEGORYSECOND_Treasure:uint = 98;
      
      public static const CATEGORYSECOND_SpecialMaterial:uint = 97;
      
      public static const CATEGORYSECOND_CommenMaterial:uint = 96;
      
      public static const CATEGORYSECOND_GemTreasure:uint = 95;
      
      public static const CATEGORYSECOND_SilverCard:uint = 80;
      
      public static const CATEGORYSECOND_FiveGhostTreasure:uint = 72;
      
      public static const CATEGORYSECOND_ExtendHoleStone:uint = 76;
      
      public static const CATEGORYSECOND_EnchantMaterial:uint = 78;
      
      public static const CATEGORYSECOND_EnchantStone:uint = 79;
      
      public static const CATEGORYSECOND_Magic:uint = 77;
      
      public static const CATEGORYSECOND_MagicCopy:uint = 1010;
      
      public static const CATEGORYSECOND_MainHeroExperienceReel:uint = 91;
      
      public static const CATEGORYSECOND_BattleSkipCard:uint = 230;
      
      public static const CATEGORYSECOND_AddActionCount:uint = 220;
      
      public static const CATEGORYSECOND_TongLingFastStrone:uint = 106;
      
      public static const CATEGORYSECOND_GiftReward:uint = 9002;
      
      public static const CATEGORYSECOND_ChangeName:uint = 851;
      
      public static const CATEGORYSECOND_ChangeFamily:uint = 852;
      
      public static const CATEGORY_EQUIPMENT_Base:uint = CATEGORYSECOND_Weapon;
      
      public static const CATEGORY_EQUIPMENT_End:uint = CATEGORYSECOND_Sash;
      
      public static const CATEGORY_EQUIPMENT_TREASURE_Base:uint = CATEGORYSECOND_TreasurePower;
      
      public static const CATEGORY_EQUIPMENT_TREASURE_End:uint = CATEGORYSECOND_TreasureLife;
      
      public static const TIMINGCATEGORY_Pick:uint = 1;
      
      public static const TIMINGCATEGORY_Equip:uint = 2;
      
      public static const TIMINGCATEGORY_Permant:uint = 3;
      
      public static const TIMINGSTATE_Unstarted:uint = 1;
      
      public static const TIMINGSTATE_Started:uint = 2;
      
      public static const TIMINGSTATE_Expired:uint = 3;
      
      public static const TIMINGSTATE_Permant:uint = 4;
      
      public static const UPGRADINGCATEGORY_Enchant:uint = 1;
      
      public static const UPGRADINGCATEGORY_Compound:uint = 2;
      
      public static const UPGRADINGCATEGORY_None:uint = 3;
      
      public static const REQUIREMENTCAREER_None:uint = CONST_CHARACTER.PROFESSION_None;
      
      public static const REQUIREMENTCAREER_Agility:uint = CONST_CHARACTER.PROFESSION_Agility;
      
      public static const REQUIREMENTCAREER_Defending:uint = CONST_CHARACTER.PROFESSION_Defending;
      
      public static const REQUIREMENTCAREER_Intellect:uint = CONST_CHARACTER.PROFESSION_Intellect;
      
      public static const REQUIREMENTCAREER_Strength:uint = CONST_CHARACTER.PROFESSION_Strength;
      
      public static const REQUIREMENTCAREER_Warlock:uint = CONST_CHARACTER.PROFESSION_Warlock;
      
      public function CONST_INVENTORY()
      {
         super();
      }
   }
}

