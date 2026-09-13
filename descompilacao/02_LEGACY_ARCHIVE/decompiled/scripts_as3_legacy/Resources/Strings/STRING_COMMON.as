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
      
      public static const COMMON_NONE:String = "Nada";
      
      public static const COMMON_ResKey:String = "GTRes_Skill_";
      
      public static const COMMON_OPENVIPTIP:String = "Vip %count% Desbloquear";
      
      public static const COMMON_OPENLEVELTIP:String = "Nvl.%count% Disponible";
      
      public static const COMMON_CONFIRM:String = "Confirmar";
      
      public static const COMMON_REFRESH:String = "Actualizar";
      
      public static const COMMON_DROPPED:String = "Lo siento, está desconectado…\nPor favor, pulse el botón OK para actualizar la página";
      
      public static const COMMON_BACKPACK_USESUCCESS:String = "Uso con éxito";
      
      public static const FormatString_FamilyPromotString:String = "Añadir%0?";
      
      public static const FormatString_FamilyServerBackPromotString:String = "¡Felicidades por unirse a %0 con éxito!";
      
      public static const TYPE_PLACE_MainCity:String = "Escena principal";
      
      public static const TYPE_Rank:String = "Número%count%";
      
      public static const TYPE_TIME_Year:String = " Año";
      
      public static const TYPE_TIME_Day:String = " Días ";
      
      public static const TYPE_TIME_Hour:String = " Hora";
      
      public static const TYPE_TIME_Minute:String = " Minuto";
      
      public static const TYPE_TIME_Second:String = " Segundo";
      
      public static const TYPE_PROFESSION_NONE:String = "Sin límite";
      
      public static const TYPE_PROFESSION_AGILITY:String = "NinJutsu";
      
      public static const TYPE_PROFESSION_DEFENDING:String = "GouJutsu";
      
      public static const TYPE_PROFESSION_INTELLECT:String = "GenJutsu";
      
      public static const TYPE_PROFESSION_STRENGTH:String = "TaiJutsu";
      
      public static const TYPE_PROFESSION_WARLOCK:String = "GenJutsu";
      
      public static const TYPE_PROFESSION_BOOS:String = "Bestia espiritual";
      
      public static const TYPE_PROFESSION_Defend:String = "Depositario";
      
      public static const TYPE_PROFESSION_Traitor:String = "Nuke-Ninja";
      
      public static const TYPE_PROFESSIONS:Vector.<String> = Vector.<String>([TYPE_PROFESSION_NONE,TYPE_PROFESSION_AGILITY,TYPE_PROFESSION_DEFENDING,TYPE_PROFESSION_INTELLECT,TYPE_PROFESSION_STRENGTH,TYPE_PROFESSION_WARLOCK,TYPE_PROFESSION_BOOS,TYPE_PROFESSION_Defend,TYPE_PROFESSION_Traitor]);
      
      public static var NOTENOUGH_Coin:String = "Plata insuficiente";
      
      public static var NOTENOUGH_Gold:String = "Oros insuficiente";
      
      public static var NOTENOUGH_Vouchers:String = "Cupón insuficiente";
      
      public static var NOTENOUGH_Integral:String = "Puntos insuficiente";
      
      public static var NOTENOUGH_Military:String = "Energía insuficiente";
      
      public static var NOTENOUGH_Soul:String = "Alma Ninja insuficiente";
      
      public static var NOTENOUGH_Level:String = "Nivel insuficiente";
      
      public static var NOTENOUGH_Vip:String = "Vip insuficiente";
      
      public static var GOTO_RECHARGE:String = "Su oros restante es insuficiente. ¿Si desea ir a recargar?";
      
      public static var ITEMNAME_Coin:String = " Plata";
      
      public static var ITEMNAME_Gold:String = " Oros";
      
      public static var ITEMNAME_Vouchers:String = " Cupón";
      
      public static var ITEMNAME_Integral:String = " Puntos";
      
      public static var ITEMNAME_Gold_Or_Vouchers:String = " Oros o cupón";
      
      public static var ITEMNAME_Exp:String = "EXP";
      
      public static var ITEMNAME_Exp_huiye:String = "EXP de Kaguya";
      
      public static var ITEMNAME_Nature:String = "Hada de Myōboku";
      
      public static var ITEMNAME_MagicTone:String = "Piedra encantada";
      
      public static var ITEMNAME_Military:String = "Energía";
      
      public static var ITEMNAME_Prestige:String = "Prestigio";
      
      public static var ITEMNAME_Soul:String = "Ogi";
      
      public static var ITEMNAME_BlueSoul:String = "Alma Azul";
      
      public static var ITEMNAME_PurpleSoul:String = "Alma Violeta";
      
      public static var ITEMNAME_GoldenSoul:String = "Alma Oro";
      
      public static var ITEMNAME_RedSoul:String = "Alma Rojo";
      
      public static var ITEMNAME_OrganizationExp:String = "EXP de Legión";
      
      public static var ITEMNAME_VIPLevel:String = "Nivel de VIP";
      
      public static var ITEMNAME_Mount:String = "Caballito blanco";
      
      public static var ITEMNAME_Spirit:String = "Hoshi";
      
      public static var ITEMNAME_Tittle:String = "Título";
      
      public static var ITEMNAME_ColorSoul:String = "Alma Kage de colores";
      
      public static var ITEMNAME_WindSoul:String = "Alma Kage de Kazekage";
      
      public static var ITEMNAME_WaterSoul:String = "Alma Kage de Mizukage";
      
      public static var ITEMNAME_DustSoul:String = "Alma Kage de Tsuchikage";
      
      public static var ITEMNAME_ThunderSoul:String = "Alma Kage de Raikage";
      
      public static var ITEMNAME_FireSoul:String = "Alma Kage de Hokage";
      
      public static var ITEMNAME_FourthSoul:String = "Cuarto Alma Kage de Hokage";
      
      public static var ITEMNAME_FirstSoul:String = "Primer Alma Kage de Hokage";
      
      public static var ITEMNAME_Token:String = "Tarjeta de Desafío";
      
      public static var ITEMNAME_OrangeSoul:String = "Piedra de Kage";
      
      public static var ITEMNAME_TeamBattlePoint:String = "Divisa de Ninja";
      
      public static var ITEMNAME_SpiritGeneral:String = "Especial";
      
      public static var ITEMNAME_SpiritFire:String = "Fuego";
      
      public static var ITEMNAME_SpiritWind:String = "Viento";
      
      public static var ITEMNAME_SpiritWater:String = "Agua";
      
      public static var ITEMNAME_SpiritGold:String = "Oro";
      
      public static var ITEMNAME_SpiritShadow:String = "Kage";
      
      public static var ITEMNAME_SpiritEarth:String = "Tierra";
      
      public static var ITEMNAME_SpiritThunder:String = "Rayo";
      
      public static var ITEMNAME_SpiritWood:String = "Madera";
      
      public static var ITEMNAME_TransmigrationTrialPoint_1:String = "Pto de 1RE";
      
      public static var ITEMNAME_TransmigrationTrialPoint_2:String = "Pto de 2RE";
      
      public static const STRINGS_BASEATTRIBUTENAMES:Vector.<String> = Vector.<String>(["Fuerza","Agilidad","Chakra","Constitución","Velocidad","Tasa de crecimiento de Fuerza","Tasa de crecimiento de Agilidad","Tasa de crecimiento de Chakra","Tasa de crecimiento de Constitución","Ataque Físico","Defensa Física","Ataque a larga distancia","Defensa a larga distancia","Ataque Estratégico","DEF. Estratégica","Tasa de Golpe","Tasa de Esquivar","Tasa de Crit","Tasa de Bloque","Tasa de Doble Ataque ","Tasa de Ayuda","Tasa de Daños","Tasa de Exención de Herida","Tasa de Destrucción","Tasa de Anti-Crit","Tasa de Ataque","Tasa de Defensa","Tasa de recuperación","Vida","Max.Vida","Aumentar la tasa de éxito de vértigo de la propia habilidad ","Reducir la tasa de éxito de vértig del enemigo","Aumentar el efecto de reducción de furia de la propia habilidad","Reducir el efecto de reducción de furia del enemigo","Debilitar el ataque del enemigo","Debilitar la defensa del enemigo","Tasa de silencio del enemigo"
      ,"Tasa de inmunización de silencio del enemigo","Aumentar daño de Crit","Tasa de ataque general prohibido","Tasa de contraataque general prohibido","Tasa de silencio","Reducir la tasa de silencio del enemigo","Tasa de Caos","Tasa de Contra-Caos","Tasa de envenenamiento","Tasa de Contra-envenenamiento","Tasa de sangría","Tasa de Contra-sangría","Tasa de ignición","Tasa de Contra-ignición","Resistir y debilitar el ataque del enemigo","Inmune Debilitar Defensa","Resistir el crit y aumentar el daño","体力流失几率","抵抗体力流失几率","八岐剧毒几率","抵抗八岐剧毒几率","伤脉几率","抵抗伤脉几率","流血2几率","抵抗流血2抵抗几率","点穴几率","Probabilidad de resistencia de acupuntura","割裂几率","割裂抵抗几率","震慑敌方几率","Probabilidad de resistencia de disuasión del enemigo","残废敌方几率","Inmune Mutilar","归一几率","抵抗归一几率","辟邪几率","抵抗辟邪几率","即死几率","抵抗即死几率","驱逐几率","Probabilidad de resistencia de expulsión","麻痹几率","抵抗麻痹几率","致盲几率","抵抗致盲几率","虚无几率","抵抗虚无几率","石化几率","抵抗石化几率","Augmente le Tx. de succès de tous les Contrôles de","Réduit le Tx. de succès de tous les Contrôles ennemis de"
      ,"月读几率","抵抗月读几率","咒缚几率","抵抗咒缚几率","Aprisionar","Inmune Aprisionar","Bonus damage after attack","Damage taken reduction","HP","Attack","Ataque Estratégico","Ataque Físico","Defensa Estratégica","Defensa Física","Velocidad","Congelar","Inmune Congelar","Aumenta daño reflejado","Reduce daño reflejado ","Huida del Viento","Inmune Huida del Viento","Atravesar","Inmune Atravesar","Atadura de Viento","Inmune Atadura de Viento","Bloque S","Inmunizar Bloque S","Sellar","Inmune Sellar","Immune Shatter Storm","Immune Upwind","Poisonous Wind rate","Immune Poisonous Wind rate","Estado de Debilitación","Inmune Estado de Debilitación","Escudo de Defensa Física (reduce el daño directo)","Escudo de Defensa Física (reduce el daño DOT)","Escudo de Defensa Estratégica (reduce el daño directo)","Escudo de Defensa Estratégica (reduce el daño DOT)","Escudo Inmune a toda Defensa"]);
      
      public static const STRINGS_OVERLAYERBASEATTRIBUTENAMES:Vector.<String> = Vector.<String>(["Fuerza","Chakra","Agilidad","Constitución","Velocidad","Constitución","Ataque Físico","Ataque Estratégico","Defensa Física","Defensa de Estrategica","Tasa de Golpe","Tasa de Esquivar","Tasa de Crit","Tasa de Bloque","Tasa de Doble Ataque","Tasa de Ayuda","Tasa de Destrucción","Tasa de Anti-Crit"]);
      
      public static const FamilyNames:Vector.<String> = Vector.<String>(["Nada","Uchiha -Clan","Uzumaki-Clan","Senju-Clan"]);
      
      public static const TargetName:Vector.<String> = Vector.<String>(["Capitán","Vanguardia","Centro","Apoyo"]);
      
      public static const STRING_Thousand:String = "K";
      
      public static const STRING_GrowUpRate:String = "Tasa de Crecimiento";
      
      public static const STRING_EndTime:String = "Cuenta atrás:";
      
      public static const STRING_PassFreshGuide:String = "¡Enhorabuena! Ha completado todas las misiones nuevas. Ahora puede comenzar a disfrutar la diversión que le trae el juego";
      
      public static const STRING_NameRepeat:String = "El nombre ya existe";
      
      public static const STRING_HeroUpgrade:String = "¡Felicidades! El color de protagonista ya aumenta a";
      
      public static const STRING_CanReward:String = "Actualmente puede recibir：";
      
      public static const STRING_NextCanReward:String = "La próxima vez puede recibir：";
      
      public static const STRING_VIRTUALNAMES:String = "<font color = \'#FFCC33\'>%0</font><font color = \'#FFFFFF\'>  entrar en el juego</font>\n";
      
      public static const STRING_ButtonStateVect:Vector.<String> = Vector.<String>(["No se ha iniciado","Registrarse","Participar en el desafío","Se ha terminado","Se ha registrado","Registro Terminado"]);
      
      public static const STRING_Backage:String = "Bolsa";
      
      public static const STRING_AttributesNijiaStar:Vector.<String> = Vector.<String>(["Ataque Físico","Ataque Estratégico","Defensa Física","Defensa Estratégica","Vida","Velocidad"]);
      
      public static const STRING_NijiaStars:Vector.<String> = Vector.<String>(["Estrella Ninja de Kazekage","Estrella Ninja de Mizukage","Estrella Ninja de Tsuchikage","Estrella Ninja de Raikage","Estrella Ninja de Hokage","Cuarto Alma Kage de Hokage","Primer Alma Kage de Hokage","Cuarto Estrella Ninja de Tsuchikage","Sexto Estrella Ninja de Hokage","Séptimo Estrella Ninja de Hokage"]);
      
      public static const STRING_KingSouls:Vector.<String> = Vector.<String>(["Alma Kage de Kazekage","Mizukage","Tsuchikage","Raikage","Hokage","Cuarto Alma Kage de Hokage","Primer Alma Kage de Hokage","Alma Kage de colores","Alma Kage de colores","Alma Kage de colores"]);
      
      public static const STRING_KingHeros:Vector.<String> = Vector.<String>(["Kazekage","Mizukage","Tsuchikage","Raikage","Hokage","Cuarto Hokage","Primer Hokage","Segundo Tsuchikage","Sexto Hokage","Séptimo Hokage"]);
      
      public static const STRING_BloodSoul:Vector.<String> = Vector.<String>(["Magatama de Sangre","Magatama de Alma","Magatama de Esencia","Magatama de Espíritu"]);
      
      public static const STRING_Lock_Add:String = "Confirmar para bloquear";
      
      public static const STRING_Lock_Dec:String = "Desbloquear";
      
      public static const STRING_Lock_Sure:String = "Confirmar";
      
      public static const COMMAND_Prefix_Debug:String = "/cmd ";
      
      public static const COMMAND_Prefix_Release:String = "/narutocommand ";
      
      public static const COMMAND_STRINGS:Vector.<String> = Vector.<String>(["-t"]);
      
      public static const COMMON_COST:String = "Gastar";
      
      public static const COMMON_NARUTOTIME:String = "Naruto time:";
      
      public static const DEFAULT_MAX_CHARS:uint = 30;
      
      public static const EditorStringRestrict:String = "[a-zA-Z0-9一-龥]";
      
      public static const EditorStringRestrict_MaxChars:uint = 12;
      
      public static const SilverCoinUnit:uint = 1000;
      
      public static const SilverCoinCoefficient:Number = 0.001;
      
      public static const CreateChar_NameShort:String = "El nombre es demasiado corto";
      
      public static const CreateChar_NameLength_Min:uint = 1;
      
      public static const FORMAT_CHARGEITEM:String = "¿Seguro que gasta%0 divisa de ninaja para canjear？";
      
      public static const SixFary_NameSpecial_Show:String = "Camino Preta 0 estrella";
      
      public static const SixFary_Recommend_Power:String = "Punto de Fuerza recomendado：";
      
      public static const SixFary_TodayChallengeTimes:String = "Número de desafío hoy:%0/1";
      
      public static const SixFary_GetProperty:String = "Felicidades por conseguir el atributo:%0 %1";
      
      public static const STRING_NewString:Vector.<String> = Vector.<String>(["Fuerza","Agilidad","Chakra","Constitución","Senjutsu","Centro","Vanguardia","Apoyo","Todo el ejército"]);
      
      public static const STRING_AutoFight_String:String = "fuck_huihui";
      
      public static const STRING_FourActivity_String:String = "No se puede entrar cuando está realizando el evento";
      
      public static const FORMAT_Level:String = "Nvl.";
      
      public static const FORMAT_VIP:String = "VIP";
      
      public static const STRING_SHUOMING:String = "Haga clic en el icono para recibir";
      
      public static var NOTENOUGH_Niemi:String = "El número de Refinar es 0, por favor introduzca de nuevo.";
      
      public static var ITEM_EIGHTDOOR:String = "精气";
      
      public static var ITEM_CHALLENGE_HURT:String = "Daño:";
      
      public static const CHANGE_USESUCCESS:int = 70100124;
      
      public static const STRINGS_SPECIAL_JADE_ATTRS:Array = ["Fuerza","Agilidad","Chakra","Constitución","Réduit le Tx. de succès de tous les Contrôles ennemis de","Tasa de Daños","Tasa de Exención de Herida"];
      
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

