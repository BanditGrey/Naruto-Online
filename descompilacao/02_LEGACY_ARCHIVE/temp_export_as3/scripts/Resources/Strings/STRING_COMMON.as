package Resources.Strings
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TTitleConfig;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class STRING_COMMON
   {
      
      public static const COMMON_NONE:String = "None";
      
      public static const COMMON_ResKey:String = "GTRes_Skill_";
      
      public static const COMMON_OPENVIPTIP:String = "Vip %count% unlocks";
      
      public static const COMMON_OPENLEVELTIP:String = "Unlock at Lv.%count%";
      
      public static const COMMON_CONFIRM:String = "Ok";
      
      public static const COMMON_REFRESH:String = "Refresh";
      
      public static const COMMON_DROPPED:String = "Sorry, you disconnected...\nPlease click Ok to refresh the page.";
      
      public static const COMMON_BACKPACK_USESUCCESS:String = "Use Success";
      
      public static const FormatString_FamilyPromotString:String = "Join %0?";
      
      public static const FormatString_FamilyServerBackPromotString:String = "Congratulations! You joined %0!";
      
      public static const TYPE_PLACE_MainCity:String = "Main Scenes";
      
      public static const TYPE_Rank:String = "No.%count%";
      
      public static const TYPE_TIME_Year:String = "Year";
      
      public static const TYPE_TIME_Day:String = "Day";
      
      public static const TYPE_TIME_Hour:String = "Hour";
      
      public static const TYPE_TIME_Minute:String = "Minute";
      
      public static const TYPE_TIME_Second:String = "Second";
      
      public static const TYPE_PROFESSION_NONE:String = "No limit";
      
      public static const TYPE_PROFESSION_AGILITY:String = "Ninjutsu";
      
      public static const TYPE_PROFESSION_DEFENDING:String = "Great Jutsu";
      
      public static const TYPE_PROFESSION_INTELLECT:String = "Genjutsu";
      
      public static const TYPE_PROFESSION_STRENGTH:String = "Taijutsu";
      
      public static const TYPE_PROFESSION_WARLOCK:String = "Genjutsu";
      
      public static const TYPE_PROFESSION_BOOS:String = "Beast";
      
      public static const TYPE_PROFESSION_Defend:String = "Garrison";
      
      public static const TYPE_PROFESSION_Traitor:String = "Rebel Ninja";
      
      public static const TYPE_PROFESSIONS:Vector.<String> = Vector.<String>([TYPE_PROFESSION_NONE,TYPE_PROFESSION_AGILITY,TYPE_PROFESSION_DEFENDING,TYPE_PROFESSION_INTELLECT,TYPE_PROFESSION_STRENGTH,TYPE_PROFESSION_WARLOCK,TYPE_PROFESSION_BOOS,TYPE_PROFESSION_Defend,TYPE_PROFESSION_Traitor]);
      
      public static var NOTENOUGH_Coin:String = "Not enough Silver";
      
      public static var NOTENOUGH_Gold:String = "Not enough Gold";
      
      public static var NOTENOUGH_Vouchers:String = "Not enough Coupons";
      
      public static var NOTENOUGH_Integral:String = "Not enough Points";
      
      public static var NOTENOUGH_Military:String = "Not enough Vitality";
      
      public static var NOTENOUGH_Soul:String = "Not enough ninja souls";
      
      public static var NOTENOUGH_Level:String = "Level too low";
      
      public static var NOTENOUGH_Vip:String = "VIP level too low";
      
      public static var GOTO_RECHARGE:String = "Not enough Gold. Go to top up";
      
      public static var ITEMNAME_Coin:String = "Silver";
      
      public static var ITEMNAME_Gold:String = "Gold";
      
      public static var ITEMNAME_Vouchers:String = "Coupon";
      
      public static var ITEMNAME_Integral:String = "Points";
      
      public static var ITEMNAME_Gold_Or_Vouchers:String = "Gold or Coupon";
      
      public static var ITEMNAME_Exp:String = "EXP";
      
      public static var ITEMNAME_Exp_huiye:String = "Kaguya EXP";
      
      public static var ITEMNAME_Nature:String = "Fairy";
      
      public static var ITEMNAME_MagicTone:String = "Enchant Stone";
      
      public static var ITEMNAME_Military:String = "Vitality";
      
      public static var ITEMNAME_Prestige:String = "Prestige";
      
      public static var ITEMNAME_Soul:String = "S.Ability";
      
      public static var ITEMNAME_BlueSoul:String = "Blue Ninja Soul";
      
      public static var ITEMNAME_PurpleSoul:String = "Purple Ninja Soul";
      
      public static var ITEMNAME_GoldenSoul:String = "Gold Ninja Soul";
      
      public static var ITEMNAME_RedSoul:String = "Red Ninja Soul";
      
      public static var ITEMNAME_OrganizationExp:String = "Legion EXP";
      
      public static var ITEMNAME_VIPLevel:String = "VIP Level";
      
      public static var ITEMNAME_Mount:String = "Little White Horse";
      
      public static var ITEMNAME_Spirit:String = "Warlord Spirit";
      
      public static var ITEMNAME_Tittle:String = "Title";
      
      public static var ITEMNAME_ColorSoul:String = "Colorful Soul";
      
      public static var ITEMNAME_WindSoul:String = "Kazekage Soul";
      
      public static var ITEMNAME_WaterSoul:String = "Mizukage Soul";
      
      public static var ITEMNAME_DustSoul:String = "Tsuchikage Soul";
      
      public static var ITEMNAME_ThunderSoul:String = "Raikage Soul";
      
      public static var ITEMNAME_FireSoul:String = "Hokage Soul";
      
      public static var ITEMNAME_FourthSoul:String = "4th Hokage Soul";
      
      public static var ITEMNAME_FirstSoul:String = "1st Hokage Soul";
      
      public static var ITEMNAME_Token:String = "Challenge Order";
      
      public static var ITEMNAME_OrangeSoul:String = "Top Stone";
      
      public static var ITEMNAME_TeamBattlePoint:String = "Ninja Badge";
      
      public static var ITEMNAME_SpiritGeneral:String = "Universe Spirit";
      
      public static var ITEMNAME_SpiritFire:String = "Fire Spirit";
      
      public static var ITEMNAME_SpiritWind:String = "Wind Spirit";
      
      public static var ITEMNAME_SpiritWater:String = "Water Spirit";
      
      public static var ITEMNAME_SpiritGold:String = "Metal Spirit";
      
      public static var ITEMNAME_SpiritShadow:String = "Shadow Spirit";
      
      public static var ITEMNAME_SpiritEarth:String = "Earth Spirit";
      
      public static var ITEMNAME_SpiritThunder:String = "Thunder Spirit";
      
      public static var ITEMNAME_SpiritWood:String = "Wood Spirit";
      
      public static var ITEMNAME_TransmigrationTrialPoint_1:String = "1-RI Point";
      
      public static var ITEMNAME_TransmigrationTrialPoint_2:String = "2-RI Point";
      
      public static const STRINGS_BASEATTRIBUTENAMES:Vector.<String> = Vector.<String>(["Force","Agility","Chakra","Power","Speed","Force Growth Rate","AGI Growth Rate","Chakra Growth Rate","Power Growth Rate","Physical Attack","Physical Defense","Range Attack","Range Defense","Strategy Attack","Strategy Defense","Hit Rate","Dodge Rate","Crit. Rate","Block Rate","Punch Rate","Aid Rate","Damage rate","Avoid injury rate","S Attack Rate","Counter Rate","Attack Rate","Defense Rate","Recovery Rate","HP","HP limit","Increase the success rate of ally\'s stun skills","Decrease the success rate of enemy\'s stun skills","Increase the ally\'s fury reduction effect","Decrease the enemy\'s fury reduction effect","Weaken enemy\'s ATK","Weaken enemy\'s DEF","Chance to silence enemies","Reduce the chance of being silenced","Increases Crit. Damage","Normal ATK Forbid Rate","Resist Normal ATK Forbid Rate","Forbidden Jutsu Rate","Resist Forbidden Jutsu Rate","Chaos Rate","Resist Chaos Rate","Poison Rate","Resist Poison Rate"
      ,"Bleeding Rate","Resist Bleeding Rate","Ignite Rate","Resist Ignite Rate","Resistant and weaken enemy attack","Immune Weaken DEF","Resistant crit and increase injury","Possibility of HP loss","Possibility of resisting HP loss","Orochi Poison Possibility","Possibility of resisting Orochi Poison","Vein Damage Possibility","Possibility of resisting Vein Damage","Bleeding 2 Possibility","Possibility of resisting Bleeding 2","Acupoint Attack Possibility","Possibility of resisting Acupoint Attacks","Split Possibility","Possibility of resisting Split","Frighten Possibility","Possibility of resisting Frighten","Disable","Immune Disable","Unification","Immune Unification","Safeguard","Immune Safeguard","Death Seed","Immune Death Seed","Dispelling Rate","Resist Dispelling Rate","Paralysis","Immune Paralysis","Blind","Immune Blind","Void","Immune Void","Petrification","Immune Petrification","Increase The Success rate of control skills","Decrease the success rate of enemy\'s control skills","Tsukuyomi Rate"
      ,"Tsukuyomi-resist Rate","Curse Rate","Curse-resist Rate","Imprison","Immune Imprison","Bonus damage after attack","Damage taken reduction","HP","Attack","Strategy Attack","Physical Attack","Strategy Defense","Physical Defense","Speed","Freeze","Immune Freeze","Increase reflected DMG","Reduce reflected DMG","Wind Escape","Immune Wind Escape","Pierce","Immune Pierce","Wind Bound","Immune Bound","Block S","Immune Block S","Seal","Immune Seal","Immune Shatter Storm","Immune Upwind","Poisonous Wind rate","Immune Poisonous Wind rate","Weakened State","Immune Weakened State","P.DEF Shield(reduce direct damage)","P.DEF Shield (reduce DOT damage)","STR.DEF Shield (reduce direct damage)","STR.DEF Shield (reduce DOT damage)","Immune ALL DEF Shield"]);
      
      public static const STRINGS_OVERLAYERBASEATTRIBUTENAMES:Vector.<String> = Vector.<String>(["Force","Chakra","Agility","Power","Speed","Power","Physical Attack","Strategy Attack","Physical Defense","Strategy Defense","Hit Rate","Dodge Rate","Crit. Rate","Block Rate","Punch Rate","Aid Rate","S Attack Rate","Counter Rate"]);
      
      public static const FamilyNames:Vector.<String> = Vector.<String>(["None","Uchiha clan","Uzumaki clan","Senju clan"]);
      
      public static const TargetName:Vector.<String> = Vector.<String>(["Captain ","Vanguard ","Assaulter ","Support "]);
      
      public static const STRING_Thousand:String = "K";
      
      public static const STRING_GrowUpRate:String = "Growth Rate";
      
      public static const STRING_EndTime:String = "Countdown:";
      
      public static const STRING_PassFreshGuide:String = "Congratulations! You have completed all newbie quests! Now enjoy the game!";
      
      public static const STRING_NameRepeat:String = "Name already exists:";
      
      public static const STRING_HeroUpgrade:String = "Congratulations! Your character quality is improved to";
      
      public static const STRING_CanReward:String = "Able to claim:";
      
      public static const STRING_NextCanReward:String = "Next claim:";
      
      public static const STRING_VIRTUALNAMES:String = "<font color = \'#FFCC33\'>%0</font><font color = \'#FFFFFF\'>   Enter the game</font>\n";
      
      public static const STRING_ButtonStateVect:Vector.<String> = Vector.<String>(["Not started","Register","Battle","Ended","Registered","Registration ended"]);
      
      public static const STRING_Backage:String = "Bag";
      
      public static const STRING_AttributesNijiaStar:Vector.<String> = Vector.<String>(["Physical Attack","Strategy Attack","Physical Defense","Strategy Defense","HP","Speed"]);
      
      public static const STRING_NijiaStars:Vector.<String> = Vector.<String>(["Kazekage Star","Mizukage Star","Tsuchikage Star","Raikage Star","Hokage Star","4th Hokage Star","1st Hokage Star","The Second Tsuchikage Star","6th Hokage Star","7th Hokage Star"]);
      
      public static const STRING_KingSouls:Vector.<String> = Vector.<String>(["Kazekage Soul","Mizukage Soul","Tsuchikage Soul","Raikage Soul","Hokage Soul","4th Hokage Soul","1st Hokage Soul","Colorful Soul","Colorful Soul","Colorful Soul"]);
      
      public static const STRING_KingHeros:Vector.<String> = Vector.<String>(["Kazekage","Mizukage","Tsuchikage","Raikage","Hokage","4th Hokage","1st Hokage","2nd Tsuchikage","6th Hokage","7th Hokage"]);
      
      public static const STRING_BloodSoul:Vector.<String> = Vector.<String>(["Jade of Blood","Jade of Soul","Jade of Spirit","Jade of Sage"]);
      
      public static const STRING_Lock_Add:String = "Confirm Lock";
      
      public static const STRING_Lock_Dec:String = "Remove Lock";
      
      public static const STRING_Lock_Sure:String = "Ok";
      
      public static const COMMAND_Prefix_Debug:String = "/cmd ";
      
      public static const COMMAND_Prefix_Release:String = "/narutocommand ";
      
      public static const COMMAND_STRINGS:Vector.<String> = Vector.<String>(["-t"]);
      
      public static const COMMON_COST:String = " cost ";
      
      public static const COMMON_NARUTOTIME:String = "Naruto time:";
      
      public static const DEFAULT_MAX_CHARS:uint = 12;
      
      public static const EditorStringRestrict:String = "[a-zA-Z0-9 ]";
      
      public static const EditorStringRestrict_MaxChars:uint = 12;
      
      public static const SilverCoinUnit:uint = 1000;
      
      public static const SilverCoinCoefficient:Number = 0.001;
      
      public static const CreateChar_NameShort:String = "Name too short";
      
      public static const CreateChar_NameLength_Min:uint = 3;
      
      public static const FORMAT_CHARGEITEM:String = "Spend %0 Ninja Badge(s) to redeem?";
      
      public static const SixFary_NameSpecial_Show:String = "Preta Path 0 Star";
      
      public static const SixFary_Recommend_Power:String = "Character\'s Combat Power Recommended:";
      
      public static const SixFary_TodayChallengeTimes:String = "Today\'s Challenge Chances:%0/1";
      
      public static const SixFary_GetProperty:String = "Congrats! You have received attributes:%0 %1";
      
      public static const STRING_NewString:Vector.<String> = Vector.<String>(["Force","Agility","INT","Power","Senjutsu","Assaulter","Vanguard","Support","All Army"]);
      
      public static const STRING_AutoFight_String:String = "fuck_huihui";
      
      public static const STRING_FourActivity_String:String = "Cannot enter while the event is underway.";
      
      public static const FORMAT_Level:String = "Lv.";
      
      public static const FORMAT_VIP:String = "VIP";
      
      public static const STRING_SHUOMING:String = "Click the icon to claim";
      
      public static var NOTENOUGH_Niemi:String = "Soul Refining cannot be 0. Please enter again.";
      
      public static var ITEM_EIGHTDOOR:String = "Vigor";
      
      public static var ITEM_CHALLENGE_HURT:String = "Damage:";
      
      public static const CHANGE_USESUCCESS:int = 70100124;
      
      public static const STRINGS_SPECIAL_JADE_ATTRS:Array = ["Force","Agility","INT","Power","Decrease the success rate of enemy\'s control skills","Damage Rate","Avoid-Injury Rate"];
      
      public function STRING_COMMON()
      {
         super();
      }
      
      public static function GetProfessionType(param1:int) : String
      {
         switch(param1)
         {
            case 1:
               return TYPE_PROFESSION_AGILITY;
            case 2:
               return TYPE_PROFESSION_DEFENDING;
            case 3:
               return TYPE_PROFESSION_INTELLECT;
            case 4:
               return TYPE_PROFESSION_STRENGTH;
            case 5:
               return TYPE_PROFESSION_WARLOCK;
            default:
               return "";
         }
      }
      
      public static function GetItemNameByType(param1:int, param2:int) : String
      {
         var _loc3_:TTitleConfig = null;
         var _loc4_:TArticle = null;
         switch(param1)
         {
            case 0:
               if(param2 == 0)
               {
                  return ITEMNAME_Coin;
               }
               if(param2 == 1)
               {
                  return ITEMNAME_Gold;
               }
               if(param2 == 2)
               {
                  return ITEMNAME_Vouchers;
               }
               if(param2 == 3)
               {
                  return ITEMNAME_Integral;
               }
               if(param2 >= 14820011 && param2 <= 14820015)
               {
                  return ITEMNAME_BlueSoul;
               }
               if(param2 >= 14820016 && param2 <= 14820020)
               {
                  return ITEMNAME_PurpleSoul;
               }
               if(param2 >= 14820021 && param2 <= 14820025)
               {
                  return ITEMNAME_GoldenSoul;
               }
               if(param2 == 14820051)
               {
                  return ITEMNAME_OrangeSoul;
               }
               §§goto(addr03ea);
               break;
            case 1:
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,param2) as TArticle;
               return _loc4_.Name;
            case 2:
               return ITEMNAME_Exp;
            case 3:
               return ITEMNAME_Military;
            case 5:
               return ITEMNAME_Prestige;
            case 6:
               return ITEMNAME_Soul;
            case 7:
               if(param2 == 3)
               {
                  return ITEMNAME_BlueSoul;
               }
               if(param2 == 4)
               {
                  return ITEMNAME_PurpleSoul;
               }
               if(param2 == 5)
               {
                  return ITEMNAME_GoldenSoul;
               }
               if(param2 == 6)
               {
                  return ITEMNAME_RedSoul;
               }
               §§goto(addr03ea);
               break;
            case 8:
               return ITEMNAME_OrganizationExp;
            case 9:
               return ITEMNAME_VIPLevel;
            case 10:
               return ITEMNAME_Mount;
            case 11:
               return ITEMNAME_Spirit;
            case 12:
               _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TitleConfig,param2) as TTitleConfig;
               return _loc3_.Title;
            case 13:
               if(param2 == 8)
               {
                  return ITEMNAME_ColorSoul;
               }
               if(param2 == 9)
               {
                  return ITEMNAME_WindSoul;
               }
               if(param2 == 10)
               {
                  return ITEMNAME_WaterSoul;
               }
               if(param2 == 11)
               {
                  return ITEMNAME_DustSoul;
               }
               if(param2 == 12)
               {
                  return ITEMNAME_ThunderSoul;
               }
               if(param2 == 13)
               {
                  return ITEMNAME_FireSoul;
               }
               if(param2 == 14)
               {
                  return ITEMNAME_FourthSoul;
               }
               if(param2 == 15)
               {
                  return ITEMNAME_FirstSoul;
               }
            case 14:
               if(param2 == 21)
               {
                  return ITEMNAME_Token;
               }
               if(param2 == 22)
               {
                  return ITEMNAME_OrangeSoul;
               }
            case 15:
               if(param2 == 23)
               {
                  return ITEMNAME_SpiritGeneral;
               }
               if(param2 == 24)
               {
                  return ITEMNAME_SpiritFire;
               }
               if(param2 == 25)
               {
                  return ITEMNAME_SpiritWind;
               }
               if(param2 == 26)
               {
                  return ITEMNAME_SpiritWater;
               }
               if(param2 == 27)
               {
                  return ITEMNAME_SpiritGold;
               }
               if(param2 == 28)
               {
                  return ITEMNAME_SpiritShadow;
               }
               if(param2 == 29)
               {
                  return ITEMNAME_SpiritEarth;
               }
               if(param2 == 30)
               {
                  return ITEMNAME_SpiritThunder;
               }
               if(param2 == 31)
               {
                  return ITEMNAME_SpiritWood;
               }
               return ITEMNAME_TeamBattlePoint;
               break;
            case 17:
               if(param2 == 32)
               {
                  return ITEMNAME_TransmigrationTrialPoint_1;
               }
               if(param2 == 33)
               {
                  return ITEMNAME_TransmigrationTrialPoint_2;
               }
            case 21:
               if(param2 == 40)
               {
                  return ITEM_EIGHTDOOR;
               }
            case 24:
               if(param2 == 0)
               {
                  return ITEM_CHALLENGE_HURT;
               }
               break;
            case 25:
               break;
            default:
               addr03ea:
               return "";
         }
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,14111276) as TArticle;
         return _loc4_.Name;
      }
      
      public static function GetLevelStrByLevelLineFeed(param1:uint) : String
      {
         var _loc2_:String = "";
         if(param1 < CONST_COMMON.Ninja_One_Reincarnation_Footstone)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.LevelLv_Describe,param1);
         }
         else if(param1 < CONST_COMMON.Ninja_Two_Reincarnation_Footstone)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,1,param1 - CONST_COMMON.Ninja_One_Reincarnation_Footstone);
         }
         else if(param1 < CONST_COMMON.Ninja_Three_Reincarnation_Footstone)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,2,param1 - CONST_COMMON.Ninja_Two_Reincarnation_Footstone);
         }
         else
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,3,param1 - CONST_COMMON.Ninja_Three_Reincarnation_Footstone);
         }
         return _loc2_;
      }
      
      public static function GetBaseAttributeNameByType(param1:int) : String
      {
         var _loc2_:int = 0;
         _loc2_ = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(param1);
         return STRINGS_BASEATTRIBUTENAMES[_loc2_];
      }
   }
}

