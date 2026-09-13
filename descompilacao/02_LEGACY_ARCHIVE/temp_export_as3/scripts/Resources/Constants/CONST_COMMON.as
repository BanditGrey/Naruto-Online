package Resources.Constants
{
   import Foundation.Resources.Bins.*;
   import flash.system.*;
   
   public class CONST_COMMON
   {
      
      public static var ReleaseVersion:String = "20120920.1.0";
      
      public static var STAGE_Width:uint = 1250;
      
      public static var STAGE_Height:uint = 650;
      
      public static var STAGE_Max_Width:uint = 1250;
      
      public static var STAGE_Max_Height:uint = 650;
      
      public static var STAGE_Min_Width:uint = 1250;
      
      public static var STAGE_Min_Height:uint = 650;
      
      public static var GAME_Width:uint = 1250;
      
      public static var GAME_Height:uint = 650;
      
      public static const STAGE_FrameRate:uint = 30;
      
      public static const STAGE_Background:uint = 4283256141;
      
      public static const FONT_DefaultName:String = "Tahoma";
      
      public static const FONT_DefaultSize:int = 12;
      
      public static const USABLE_WORKER:Boolean = true;
      
      public static const MAX_LOADING_SYNC:uint = 2;
      
      public static var GAME_CurrentFps:uint = 30;
      
      public static var GAME_AverageFps:uint = 30;
      
      public static const GAME_MemCriticalValue:uint = 700;
      
      public static var CITY_HeightMin:Number = 370;
      
      public static var CITY_HeighTMax:Number = STAGE_Height;
      
      public static var CITY_WidthMin:Number = 0;
      
      public static var CITY_WidthMax:Number = STAGE_Width;
      
      public static const SecondPerDay:int = 24 * 3600;
      
      public static const CAPACITY_Credits:int = 6;
      
      public static const CREDITINDEX_Gold:int = 0;
      
      public static const CREDITINDEX_SilverCoin:int = 1;
      
      public static const CREDITINDEX_GiftCertificate:int = 2;
      
      public static const CREDITINDEX_MilitaryOrders:int = 3;
      
      public static const CREDITINDEX_Integral:int = 4;
      
      public static const CREDITINDEX_MilitaryOrdersBuff:int = 5;
      
      public static const CAPACITY_HeroSouls:int = 4;
      
      public static const HEROSOULINDEX_BlueSoul:int = 0;
      
      public static const HEROSOULINDEX_PurpleSoul:int = 1;
      
      public static const HEROSOULINDEX_GoldSoul:int = 2;
      
      public static const HEROSOULINDEX_OrangeSoul:int = 3;
      
      public static const CAPACITY_KingSouls:int = 8;
      
      public static const CAPACITY_RespectSouls:int = 11;
      
      public static const KINGSOULINDEX_Common:int = 0;
      
      public static const KINGSOULINDEX_Wind:int = 1;
      
      public static const KINGSOULINDEX_Water:int = 2;
      
      public static const KINGSOULINDEX_Dust:int = 3;
      
      public static const KINGSOULINDEX_Thunder:int = 4;
      
      public static const KINGSOULINDEX_Fire:int = 5;
      
      public static const KINGSOULINDEX_Forth:int = 6;
      
      public static const KINGSOULINDEX_First:int = 7;
      
      public static const TIME_COOLDOWN_Strengthen:int = 240;
      
      public static const TIME_COOLDOWN_Arean:int = 241;
      
      public static const TIME_COOLDOWN_TreasureMap:int = 242;
      
      public static const TIME_COOLDOWN_CopyHero:int = 243;
      
      public static const TIME_COOLDOWN_Activity_PurpleNinja:int = 244;
      
      public static const TIME_COOLDOWN_Activity_CAMP:int = 245;
      
      public static const TIME_COOLDOWN_Activity_Recharge:int = 246;
      
      public static const TIME_COOLDOWN_Activity_GoldNinja:int = 247;
      
      public static const TIME_COOLDOWN_Activity_SuperNinja:int = 248;
      
      public static const TIME_COOLDOWN_Activity_Equipment:int = 249;
      
      public static const TIME_COOLDOWN_Activity_Talisman:int = 250;
      
      public static const TIME_COOLDOWN_Activity_Jade:int = 251;
      
      public static const TIME_COOLDOWN_Activity_OnlineGiftBag:int = 252;
      
      public static const TIME_COOLDOWN_OrganizationalWar_DieColdTime:int = 253;
      
      public static const TIME_COOLDOWN_OrganizationalWar_SystemColdTime:int = 254;
      
      public static const TIME_COOLDOWN_OrganizationalWar_ActiveColdTime:int = 255;
      
      public static const TIME_COOLDOWN_FightPet_EnterCD:int = 225;
      
      public static const TIME_COOLDOWN_FightPet_DieCD:int = 224;
      
      public static const TIME_COOLDOWN_FightPet_INIT:int = 226;
      
      public static const TIME_COOLDOWN_FightPet_BACKTOWN:int = 227;
      
      public static const TIME_COOLDOWN_Animal_DieCd:int = 228;
      
      public static const TIME_COOLDOWN_Animal_FIRE:int = 229;
      
      public static const CAPACITY_INVENTORIES:uint = 8;
      
      public static const INVENTORIESINDEX_Appliances:uint = 0;
      
      public static const INVENTORIESINDEX_Equipments:uint = 1;
      
      public static const INVENTORIESINDEX_Materials:uint = 2;
      
      public static const INVENTORIESINDEX_Gems:uint = 3;
      
      public static const INVENTORIESINDEX_Treasures:uint = 4;
      
      public static const INVENTORIESINDEX_Accessories:uint = 5;
      
      public static const INVENTORIESINDEX_Medals:uint = 6;
      
      public static const INVENTORIESINDEX_Temporary:uint = 7;
      
      public static const INVENTORIESINDEX_Heros_Equipments:uint = 0;
      
      public static const INVENTORIESINDEX_Heros_Appliances:uint = 1;
      
      public static const INVENTORIESINDEX_Heros_Accessories:uint = 2;
      
      public static const BASEATTRIBUTEINDEX_Power:uint = 0;
      
      public static const BASEATTRIBUTEINDEX_Intelligence:uint = 1;
      
      public static const BASEATTRIBUTEINDEX_Agile:uint = 2;
      
      public static const BASEATTRIBUTEINDEX_Life:uint = 3;
      
      public static const BASEATTRIBUTEINDEX_Speed:uint = 4;
      
      public static const BASEATTRIBUTEINDEX_Health:uint = 5;
      
      public static const BASEATTRIBUTEINDEX_PhysicalAttack:uint = 6;
      
      public static const BASEATTRIBUTEINDEX_MagicAttack:uint = 7;
      
      public static const BASEATTRIBUTEINDEX_PhysicalDefends:uint = 8;
      
      public static const BASEATTRIBUTEINDEX_MagicDefends:uint = 9;
      
      public static const BASEATTRIBUTEINDEX_BeginAnger:uint = 10;
      
      public static const BASEATTRIBUTEINDEX_AvoidInjury:uint = 11;
      
      public static const BASEATTRIBUTEINDEX_Hit:uint = 12;
      
      public static const BASEATTRIBUTEINDEX_Dodge:uint = 13;
      
      public static const BASEATTRIBUTEINDEX_Crit:uint = 14;
      
      public static const BASEATTRIBUTEINDEX_GridFile:uint = 15;
      
      public static const BASEATTRIBUTEINDEX_Punch:uint = 16;
      
      public static const BASEATTRIBUTEINDEX_Help:uint = 17;
      
      public static const BASEATTRIBUTEINDEX_Wreck:uint = 18;
      
      public static const BASEATTRIBUTEINDEX_Uprising:uint = 19;
      
      public static const BASEATTRIBUTEINDEX_Hurt:uint = 20;
      
      public static const BASEATTRIBUTEINDEX_FightingPower:uint = 21;
      
      public static const CAPACITY_BaseAttributes:uint = BASEATTRIBUTEINDEX_FightingPower + 1;
      
      public static const BASEATTRIBUTENAME_Power:uint = 1;
      
      public static const BASEATTRIBUTENAME_Agility:uint = 2;
      
      public static const BASEATTRIBUTENAME_Intellect:uint = 3;
      
      public static const BASEATTRIBUTENAME_Life:uint = 4;
      
      public static const BASEATTRIBUTENAME_Speed:uint = 11;
      
      public static const BASEATTRIBUTENAME_PowerGrow:uint = 12;
      
      public static const BASEATTRIBUTENAME_AgilityGrow:uint = 13;
      
      public static const BASEATTRIBUTENAME_IntellectGrow:uint = 14;
      
      public static const BASEATTRIBUTENAME_LifeGrow:uint = 15;
      
      public static const BASEATTRIBUTENAME_NearAttack:uint = 16;
      
      public static const BASEATTRIBUTENAME_NearDefense:uint = 17;
      
      public static const BASEATTRIBUTENAME_FarAttack:uint = 18;
      
      public static const BASEATTRIBUTENAME_FarDefense:uint = 19;
      
      public static const BASEATTRIBUTENAME_StrategyAttack:uint = 20;
      
      public static const BASEATTRIBUTENAME_StrategyDefense:uint = 21;
      
      public static const BASEATTRIBUTENAME_HitRate:uint = 22;
      
      public static const BASEATTRIBUTENAME_DodgeRate:uint = 23;
      
      public static const BASEATTRIBUTENAME_CritRate:uint = 24;
      
      public static const BASEATTRIBUTENAME_BlockRate:uint = 25;
      
      public static const BASEATTRIBUTENAME_PunchRate:uint = 26;
      
      public static const BASEATTRIBUTENAME_HelpRate:uint = 27;
      
      public static const BASEATTRIBUTENAME_HurtRate:uint = 28;
      
      public static const BASEATTRIBUTENAME_AvoidhurtRate:uint = 29;
      
      public static const BASEATTRIBUTENAME_WreckRate:uint = 30;
      
      public static const BASEATTRIBUTENAME_AntiknockRate:uint = 31;
      
      public static const BASEATTRIBUTENAME_AttachRate:uint = 32;
      
      public static const BASEATTRIBUTENAME_DefenceRate:uint = 33;
      
      public static const BASEATTRIBUTENAME_RecoverRate:uint = 34;
      
      public static const BASEATTRIBUTENAME_MAXHP:uint = 101;
      
      public static const BASEATTRIBUTENAME_HP:uint = 102;
      
      public static const BASEATTRIBUTENAME_ProbabilityAdd:uint = 39;
      
      public static const BASEATTRIBUTENAME_ResistanceAdd:uint = 40;
      
      public static const BASEATTRIBUTENAME_MinusEffectAdd:uint = 41;
      
      public static const BASEATTRIBUTENAME_MinusResistanceAdd:uint = 42;
      
      public static const BASEATTRIBUTENAME_WeakenAttack:uint = 35;
      
      public static const BASEATTRIBUTENAME_WeakenDefence:uint = 36;
      
      public static const BASEATTRIBUTENAME_CtrlSilencerate:uint = 37;
      
      public static const BASEATTRIBUTENAME_ImmctrlSilencerate:uint = 38;
      
      public static const BASEATTRIBUTENAME_CritAttack:uint = 43;
      
      public static const BASEATTRIBUTENAME_Anti_Critaddtion_Damage_Rate:uint = 44;
      
      public static const BASEATTRIBUTENAME_NoAttack_Rate:uint = 45;
      
      public static const BASEATTRIBUTENAME_Anti_NoAttack_Rate:uint = 46;
      
      public static const BASEATTRIBUTENAME_NoSkill_Rate:uint = 47;
      
      public static const BASEATTRIBUTENAME_Anti_NoSkill_Rate:uint = 48;
      
      public static const BASEATTRIBUTENAME_Confusion_Rate:uint = 49;
      
      public static const BASEATTRIBUTENAME_Anti_Confusion_Rate:uint = 50;
      
      public static const BASEATTRIBUTENAME_Poison_Rate:uint = 51;
      
      public static const BASEATTRIBUTENAME_Anti_Poison_Rate:uint = 52;
      
      public static const BASEATTRIBUTENAME_Bleed_Rate:uint = 53;
      
      public static const BASEATTRIBUTENAME_Anti_Bleed_Rate:uint = 54;
      
      public static const BASEATTRIBUTENAME_Burn_Rate:uint = 55;
      
      public static const BASEATTRIBUTENAME_Anti_Burn_Rate:uint = 56;
      
      public static const BASEATTRIBUTENAME_Anti_Weakenattack_Rate:uint = 57;
      
      public static const BASEATTRIBUTENAME_Anti_Weakendefence_Rate:uint = 58;
      
      public static const BASEATTRIBUTENAME_ST_LOSS_Rate:uint = 59;
      
      public static const BASEATTRIBUTENAME_Anti_ST_LOSS_Rate:uint = 60;
      
      public static const BASEATTRIBUTENAME_HIG_TOXIC_Rate:uint = 61;
      
      public static const BASEATTRIBUTENAME_Anti_HIG_TOXIC_Rate:uint = 62;
      
      public static const BASEATTRIBUTENAME_HURT_PULSE_Rate:uint = 63;
      
      public static const BASEATTRIBUTENAME_Anti_HURT_PULSE_Rate:uint = 64;
      
      public static const BASEATTRIBUTENAME_BLEED2_Rate:uint = 65;
      
      public static const BASEATTRIBUTENAME_Anti_BLEED2_Rate:uint = 66;
      
      public static const BASEATTRIBUTENAME_DIANXUE_Rate:uint = 67;
      
      public static const BASEATTRIBUTENAME_Anti_DIANXUE_Rate:uint = 68;
      
      public static const BASEATTRIBUTENAME_Cripple_Rate:uint = 69;
      
      public static const BASEATTRIBUTENAME_Anti_Cripple_Rate:uint = 70;
      
      public static const BASEATTRIBUTENAME_Awe_Rate:uint = 71;
      
      public static const BASEATTRIBUTENAME_Anti_Awe_Rate:uint = 72;
      
      public static const BASEATTRIBUTENAME_Cripple1_Rate:uint = 73;
      
      public static const BASEATTRIBUTENAME_Anti_Cripple1_Rate:uint = 74;
      
      public static const BASEATTRIBUTENAME_Unification_Rate:uint = 75;
      
      public static const BASEATTRIBUTENAME_Anti_Unification_Rate:uint = 76;
      
      public static const BASEATTRIBUTENAME_Exorcise_Rate:uint = 77;
      
      public static const BASEATTRIBUTENAME_Anti_Exorcise_Rate:uint = 78;
      
      public static const BASEATTRIBUTENAME_Died_Rate:uint = 79;
      
      public static const BASEATTRIBUTENAME_Anti_Died_Rate:uint = 80;
      
      public static const BASEATTRIBUTENAME_Expel_Rate:uint = 81;
      
      public static const BASEATTRIBUTENAME_Anti_Expel_Rate:uint = 82;
      
      public static const BASEATTRIBUTENAME_ParaExpel:uint = 83;
      
      public static const BASEATTRIBUTENAME_ImmParaExpel:uint = 84;
      
      public static const BASEATTRIBUTENAME_ParaBlindness:uint = 85;
      
      public static const BASEATTRIBUTENAME_ImmParaBlindness:uint = 86;
      
      public static const BASEATTRIBUTENAME_Stone:uint = 87;
      
      public static const BASEATTRIBUTENAME_ImmStone:uint = 88;
      
      public static const BASEATTRIBUTENAME_Fake:uint = 89;
      
      public static const BASEATTRIBUTENAME_ImmFake:uint = 90;
      
      public static const BASEATTRIBUTENAME_AllSkill:uint = 91;
      
      public static const BASEATTRIBUTENAME_ImmAllSkill:uint = 92;
      
      public static const BASEATTRIBUTENAME_Moon:uint = 93;
      
      public static const BASEATTRIBUTENAME_ImmMoon:uint = 94;
      
      public static const BASEATTRIBUTENAME_Seal:uint = 95;
      
      public static const BASEATTRIBUTENAME_ImmSeal:uint = 96;
      
      public static const BASEATTRIBUTENAME_Holding:uint = 98;
      
      public static const BASEATTRIBUTENAME_ImmHolding:uint = 99;
      
      public static const BASEATTRIBUTENAME_NewEffect:uint = 204;
      
      public static const BASEATTRIBUTENAME_ImmNewEffect:uint = 205;
      
      public static const BASEATTRIBUTENAME_NewHeathy:uint = 209;
      
      public static const BASEATTRIBUTENAME_NewAttack:uint = 210;
      
      public static const BASEATTRIBUTENAME_NewNearAttack:uint = 211;
      
      public static const BASEATTRIBUTENAME_NewFarAttack:uint = 212;
      
      public static const BASEATTRIBUTENAME_NewNearDefense:uint = 213;
      
      public static const BASEATTRIBUTENAME_NewFarDefense:uint = 214;
      
      public static const BASEATTRIBUTENAME_NewSpeed:uint = 215;
      
      public static const BASEATTRIBUTENAME_Ice:uint = 302;
      
      public static const BASEATTRIBUTENAME_ImmIce:uint = 303;
      
      public static const BASEATTRIBUTENAME_ADD_FanShang:uint = 304;
      
      public static const BASEATTRIBUTENAME_IMM_FanShang:uint = 305;
      
      public static const BASEATTRIBUTENAME_FengDun:uint = 308;
      
      public static const BASEATTRIBUTENAME_ImmFengDun:uint = 309;
      
      public static const BASEATTRIBUTENAME_Penetrate:uint = 310;
      
      public static const BASEATTRIBUTENAME_ImmPenetrate:uint = 311;
      
      public static const BASEATTRIBUTENAME_FengFu:uint = 312;
      
      public static const BASEATTRIBUTENAME_ImmFengFu:uint = 313;
      
      public static const BASEATTRIBUTENAME_Block:uint = 314;
      
      public static const BASEATTRIBUTENAME_ImmBlock:uint = 315;
      
      public static const BASEATTRIBUTENAME_NoSkill:uint = 316;
      
      public static const BASEATTRIBUTENAME_ImmNoSkill:uint = 317;
      
      public static const BASEATTRIBUTENAME_Charm:uint = 319;
      
      public static const BASEATTRIBUTENAME_ImmCharm:uint = 320;
      
      public static const BASEATTRIBUTENAME_DuFeng:uint = 321;
      
      public static const BASEATTRIBUTENAME_ImmDuFeng:uint = 322;
      
      public static const BASEATTRIBUTENAME_Weak:uint = 323;
      
      public static const BASEATTRIBUTENAME_ImmWeak:uint = 324;
      
      public static const BASEATTRIBUTENAME_P_DefShield:uint = 325;
      
      public static const BASEATTRIBUTENAME_Sec_P_DefShield:uint = 326;
      
      public static const BASEATTRIBUTENAME_S_DefShield:uint = 327;
      
      public static const BASEATTRIBUTENAME_Sec_S_DefShield:uint = 328;
      
      public static const BASEATTRIBUTENAME_ImmDefShield:uint = 329;
      
      public static const BASEATTRIBUTENAMESCOPY:Vector.<uint> = Vector.<uint>([BASEATTRIBUTENAME_MAXHP,BASEATTRIBUTENAME_Speed,BASEATTRIBUTENAME_NearAttack,BASEATTRIBUTENAME_NearDefense,BASEATTRIBUTENAME_StrategyDefense]);
      
      public static const BASEATTRIBUTENAMES:Vector.<uint> = Vector.<uint>([BASEATTRIBUTENAME_Power,BASEATTRIBUTENAME_Agility,BASEATTRIBUTENAME_Intellect,BASEATTRIBUTENAME_Life,BASEATTRIBUTENAME_Speed,BASEATTRIBUTENAME_PowerGrow,BASEATTRIBUTENAME_AgilityGrow,BASEATTRIBUTENAME_IntellectGrow,BASEATTRIBUTENAME_LifeGrow,BASEATTRIBUTENAME_NearAttack,BASEATTRIBUTENAME_NearDefense,BASEATTRIBUTENAME_FarAttack,BASEATTRIBUTENAME_FarDefense,BASEATTRIBUTENAME_StrategyAttack,BASEATTRIBUTENAME_StrategyDefense,BASEATTRIBUTENAME_HitRate,BASEATTRIBUTENAME_DodgeRate,BASEATTRIBUTENAME_CritRate,BASEATTRIBUTENAME_BlockRate,BASEATTRIBUTENAME_PunchRate,BASEATTRIBUTENAME_HelpRate,BASEATTRIBUTENAME_HurtRate,BASEATTRIBUTENAME_AvoidhurtRate,BASEATTRIBUTENAME_WreckRate,BASEATTRIBUTENAME_AntiknockRate,BASEATTRIBUTENAME_AttachRate,BASEATTRIBUTENAME_DefenceRate,BASEATTRIBUTENAME_RecoverRate,BASEATTRIBUTENAME_MAXHP,BASEATTRIBUTENAME_HP,BASEATTRIBUTENAME_ProbabilityAdd,BASEATTRIBUTENAME_ResistanceAdd,BASEATTRIBUTENAME_MinusEffectAdd
      ,BASEATTRIBUTENAME_MinusResistanceAdd,BASEATTRIBUTENAME_WeakenAttack,BASEATTRIBUTENAME_WeakenDefence,BASEATTRIBUTENAME_CtrlSilencerate,BASEATTRIBUTENAME_ImmctrlSilencerate,BASEATTRIBUTENAME_CritAttack,BASEATTRIBUTENAME_NoAttack_Rate,BASEATTRIBUTENAME_Anti_NoAttack_Rate,BASEATTRIBUTENAME_NoSkill_Rate,BASEATTRIBUTENAME_Anti_NoSkill_Rate,BASEATTRIBUTENAME_Confusion_Rate,BASEATTRIBUTENAME_Anti_Confusion_Rate,BASEATTRIBUTENAME_Poison_Rate,BASEATTRIBUTENAME_Anti_Poison_Rate,BASEATTRIBUTENAME_Bleed_Rate,BASEATTRIBUTENAME_Anti_Bleed_Rate,BASEATTRIBUTENAME_Burn_Rate,BASEATTRIBUTENAME_Anti_Burn_Rate,BASEATTRIBUTENAME_Anti_Weakenattack_Rate,BASEATTRIBUTENAME_Anti_Weakendefence_Rate,BASEATTRIBUTENAME_Anti_Critaddtion_Damage_Rate,BASEATTRIBUTENAME_ST_LOSS_Rate,BASEATTRIBUTENAME_Anti_ST_LOSS_Rate,BASEATTRIBUTENAME_HIG_TOXIC_Rate,BASEATTRIBUTENAME_Anti_HIG_TOXIC_Rate,BASEATTRIBUTENAME_HURT_PULSE_Rate,BASEATTRIBUTENAME_Anti_HURT_PULSE_Rate,BASEATTRIBUTENAME_BLEED2_Rate,BASEATTRIBUTENAME_Anti_BLEED2_Rate
      ,BASEATTRIBUTENAME_DIANXUE_Rate,BASEATTRIBUTENAME_Anti_DIANXUE_Rate,BASEATTRIBUTENAME_Cripple_Rate,BASEATTRIBUTENAME_Anti_Cripple_Rate,BASEATTRIBUTENAME_Awe_Rate,BASEATTRIBUTENAME_Anti_Awe_Rate,BASEATTRIBUTENAME_Cripple1_Rate,BASEATTRIBUTENAME_Anti_Cripple1_Rate,BASEATTRIBUTENAME_Unification_Rate,BASEATTRIBUTENAME_Anti_Unification_Rate,BASEATTRIBUTENAME_Exorcise_Rate,BASEATTRIBUTENAME_Anti_Exorcise_Rate,BASEATTRIBUTENAME_Died_Rate,BASEATTRIBUTENAME_Anti_Died_Rate,BASEATTRIBUTENAME_Expel_Rate,BASEATTRIBUTENAME_Anti_Expel_Rate,BASEATTRIBUTENAME_ParaExpel,BASEATTRIBUTENAME_ImmParaExpel,BASEATTRIBUTENAME_ParaBlindness,BASEATTRIBUTENAME_ImmParaBlindness,BASEATTRIBUTENAME_Stone,BASEATTRIBUTENAME_ImmStone,BASEATTRIBUTENAME_Fake,BASEATTRIBUTENAME_ImmFake,BASEATTRIBUTENAME_AllSkill,BASEATTRIBUTENAME_ImmAllSkill,BASEATTRIBUTENAME_Moon,BASEATTRIBUTENAME_ImmMoon,BASEATTRIBUTENAME_Seal,BASEATTRIBUTENAME_ImmSeal,BASEATTRIBUTENAME_Holding,BASEATTRIBUTENAME_ImmHolding,BASEATTRIBUTENAME_NewEffect,BASEATTRIBUTENAME_ImmNewEffect
      ,BASEATTRIBUTENAME_NewHeathy,BASEATTRIBUTENAME_NewAttack,BASEATTRIBUTENAME_NewNearAttack,BASEATTRIBUTENAME_NewFarAttack,BASEATTRIBUTENAME_NewNearDefense,BASEATTRIBUTENAME_NewFarDefense,BASEATTRIBUTENAME_NewSpeed,BASEATTRIBUTENAME_Ice,BASEATTRIBUTENAME_ImmIce,BASEATTRIBUTENAME_ADD_FanShang,BASEATTRIBUTENAME_IMM_FanShang,BASEATTRIBUTENAME_FengDun,BASEATTRIBUTENAME_ImmFengDun,BASEATTRIBUTENAME_Penetrate,BASEATTRIBUTENAME_ImmPenetrate,BASEATTRIBUTENAME_FengFu,BASEATTRIBUTENAME_ImmFengFu,BASEATTRIBUTENAME_Block,BASEATTRIBUTENAME_ImmBlock,BASEATTRIBUTENAME_NoSkill,BASEATTRIBUTENAME_ImmNoSkill,BASEATTRIBUTENAME_Charm,BASEATTRIBUTENAME_ImmCharm,BASEATTRIBUTENAME_DuFeng,BASEATTRIBUTENAME_ImmDuFeng,BASEATTRIBUTENAME_Weak,BASEATTRIBUTENAME_ImmWeak,BASEATTRIBUTENAME_P_DefShield,BASEATTRIBUTENAME_Sec_P_DefShield,BASEATTRIBUTENAME_S_DefShield,BASEATTRIBUTENAME_Sec_S_DefShield,BASEATTRIBUTENAME_ImmDefShield]);
      
      public static const CAPACITY_FirstAttributesRate:uint = 4;
      
      public static const CAPACITY_FirstAttributes:uint = 4;
      
      public static const FIRSTATTRIBUTERATEINDEX_Power:uint = 0;
      
      public static const FIRSTATTRIBUTERATEINDEX_Intelligence:uint = 1;
      
      public static const FIRSTATTRIBUTERATEINDEX_Agile:uint = 2;
      
      public static const FIRSTATTRIBUTERATEINDEX_Health:uint = 3;
      
      public static const RESOURCESID_Swf_Common:uint = 0;
      
      public static const RESOURCE_ClassName_MC_DefaultRoleTexture:String = "MC_DefaultRoleTexture";
      
      public static const RESOURCE_ClassName_MC_HitTexture:String = "MC_HitTexture";
      
      public static const RESOURCE_ClassName_MC_DividingLine:String = "MC_DividingLine";
      
      public static const RESOURCE_ClassName_MC_Information:String = "MC_Information";
      
      public static const RESOURCE_ClassName_MC_Confirmation:String = "MC_Confirmation";
      
      public static const RESOURCE_ClassName_MC_GotoRecharge:String = "MC_GotoRecharge";
      
      public static const RESOURCE_ClassName_MC_InputString:String = "MC_InputString";
      
      public static const RESOURCE_ClassName_MC_ItemIconLoaderStyle:String = "MC_ItemIconLoaderStyle";
      
      public static const RESOURCE_ClassName_MC_PopTip:String = "MC_PopTip";
      
      public static const RESOURCE_ClassName_MC_GrowRoadTip:String = "MC_GrowRoadTip";
      
      public static const RESOURCE_ClassName_GroupMonstonTip:String = "groupMonstonTip";
      
      public static const RESOURCE_ClassName_MC_InputPassword:String = "MC_InputPassword";
      
      public static const RESOURCE_ClassName_MC_SeekRoom:String = "MC_SeekRoom";
      
      public static const RESOURCE_ClassName_MC_ActivityNotify:String = "MC_ActivityNotify";
      
      public static const RESOURCE_ClassName_MC_Editor:String = "MC_Editor";
      
      public static const RESOURCE_ClassName_MC_EditorString:String = "MC_EditorString";
      
      public static const RESOURCE_ClassName_MC_MaterialCost:String = "MC_MaterialCost";
      
      public static const RESOURCE_ClassName_MC_GoodsPurchase:String = "MC_GoodsPurchase";
      
      public static const RESOURCE_ClassName_MC_PromptFrame:String = "MC_PromptFrame";
      
      public static const RESOURCE_Link_TF_Text:String = "TF_Text";
      
      public static const RESOURCE_Link_Btn_Ok:String = "Btn_Ok";
      
      public static const RESOURCE_Link_Btn_Cancel:String = "Btn_Cancel";
      
      public static const RESOURCE_Link_TF_BtnOkCaption:String = "TF_BtnOkCaption";
      
      public static const RESOURCE_Link_TF_BtnCancelCaption:String = "TF_BtnCancelCaption";
      
      public static const RESOURCE_Link_TF_BtnMaxCaption:String = "TF_BtnMaxCaption";
      
      public static const RESOURCE_Link_Btn_Close:String = "Btn_Close";
      
      public static const RESOURCE_Link_TF_Caption:String = "TF_Caption";
      
      public static const RESOURCE_Link_TF_Label:String = "TF_Label";
      
      public static const RESOURCE_Link_TF_Quantity:String = "TF_Quantity";
      
      public static const RESOURCE_Link_TF_GoldQuantity:String = "TF_GoldQuantity";
      
      public static const RESOURCE_Link_TF_Value:String = "TF_Value";
      
      public static const RESOURCE_Link_Btn_Max:String = "Btn_Max";
      
      public static const RESOURCE_Link_MC_Slot:String = "MC_Slot";
      
      public static const RESOURCE_Link_MC_CheckBox:String = "MC_CheckBox";
      
      public static const RESOURCE_Link_Btn_CheckBox:String = "Btn_CheckBox";
      
      public static const RESOURCE_Link_MC_Selected:String = "MC_Selected";
      
      public static const RESOURCE_Link_MC_UnSelect:String = "MC_UnSelect";
      
      public static const RESOURCE_Link_TF_CheckBox:String = "TF_CheckBox";
      
      public static const RESOURCE_Link_TF_InputPassword:String = "TF_InputPassword";
      
      public static const RESOURCE_Link_TF_InputRoomID:String = "TF_InputRoomID";
      
      public static const RESOURCE_Link_TF_EnterTime:String = "TF_EnterTime";
      
      public static const SEQUENCEID_Default:uint = 0;
      
      public static const STRING_ThinSquare:String = "[%0]";
      
      public static const STRING_ThickSquare:String = "【%0】";
      
      public static const STRING_ThinSquareLeft:String = "［";
      
      public static const STRING_ThinSquareRight:String = "］";
      
      public static const STRING_ThickSquareLeft:String = "【";
      
      public static const STRING_ThickSquareRight:String = "】";
      
      public static const STRING_ParenthesesLeft:String = "(";
      
      public static const STRING_ParenthesesRight:String = ")";
      
      public static const STRING_Capacity:String = "%0/%1";
      
      public static const STRING_Percentage:String = "%0%";
      
      public static const STRING_CapacityAndPercentage:String = "(%0/%1) (%2%)";
      
      protected static const QUALITYCOLOR_None:uint = 4294967295;
      
      protected static const QUALITYCOLOR_White:uint = 4294967295;
      
      protected static const QUALITYCOLOR_Green:uint = 4285071106;
      
      protected static const QUALITYCOLOR_Blue:uint = 4278228735;
      
      protected static const QUALITYCOLOR_Purple:uint = 4288217295;
      
      protected static const QUALITYCOLOR_Yellow:uint = 4294967040;
      
      protected static const QUALITYCOLOR_Red:uint = 4294836224;
      
      protected static const QUALITYCOLOR_Orange:uint = 4294901888;
      
      protected static const QUALITYCOLOR_Pink:uint = 4294928025;
      
      protected static const QUALITYCOLOR_HUI:uint = 4291611852;
      
      public static const QUALITYCOLOR_INDEX:Vector.<uint> = Vector.<uint>([QUALITYCOLOR_None,QUALITYCOLOR_White,QUALITYCOLOR_Green,QUALITYCOLOR_Blue,QUALITYCOLOR_Purple,QUALITYCOLOR_Yellow,QUALITYCOLOR_Red,QUALITYCOLOR_Orange,QUALITYCOLOR_Pink]);
      
      protected static const QUALITYCOLOR_None_1:String = "#FFFFFF";
      
      protected static const QUALITYCOLOR_White_1:String = "#FFFFFF";
      
      protected static const QUALITYCOLOR_Green_1:String = "#68FF02";
      
      protected static const QUALITYCOLOR_Blue_1:String = "#0096FF";
      
      protected static const QUALITYCOLOR_Purple_1:String = "#9900CF";
      
      protected static const QUALITYCOLOR_Yellow_1:String = "#FFFF00";
      
      protected static const QUALITYCOLOR_Red_1:String = "#FE0000";
      
      protected static const QUALITYCOLOR_Orange_1:String = "#FF0080";
      
      protected static const QUALITYCOLOR_Pink_1:String = "#FF6699";
      
      public static const QUALITYCOLOR_INDEX_1:Vector.<String> = Vector.<String>([QUALITYCOLOR_None_1,QUALITYCOLOR_White_1,QUALITYCOLOR_Green_1,QUALITYCOLOR_Blue_1,QUALITYCOLOR_Purple_1,QUALITYCOLOR_Yellow_1,QUALITYCOLOR_Red_1,QUALITYCOLOR_Orange_1,QUALITYCOLOR_Pink_1]);
      
      public static const QUALITYCOLOR_INDEX_2:Vector.<String> = Vector.<String>([QUALITYCOLOR_None_1,QUALITYCOLOR_Green_1,QUALITYCOLOR_Blue_1,QUALITYCOLOR_Purple_1,QUALITYCOLOR_Yellow_1,QUALITYCOLOR_Red_1]);
      
      protected static const COUNTRYCOLOR_One:uint = 4294901760;
      
      protected static const COUNTRYCOLOR_Two:uint = 4278255360;
      
      protected static const COUNTRYCOLOR_Three:uint = 4278190335;
      
      public static const COUNTRYCOLOR_INDEX:Vector.<uint> = Vector.<uint>([COUNTRYCOLOR_One,COUNTRYCOLOR_Two,COUNTRYCOLOR_Three]);
      
      public static const TEXT_Red_Color:uint = 16711680;
      
      public static const TEXT_Green_Color:uint = 7143168;
      
      public static const TEXT_White_Color:uint = 16777215;
      
      public static const SCENEPOSITION_MAINCITY:int = 0;
      
      public static const SCENEPOSITION_WORLDMAP:int = 1;
      
      public static const SCENEPOSITION_BATTLESENCE:int = 2;
      
      public static const SCENEPOSITION_BATTLESENCE_AUTO:int = 3;
      
      public static const SCENEPOSITION_ARENA:int = 4;
      
      public static const SCENEPOSITION_Tavern:int = 5;
      
      public static const SCENEPOSITION_TreasureMap:int = 6;
      
      public static const SCENEPOSITION_SuperHero:int = 7;
      
      public static const SCENEPOSITION_CityDefend:int = 8;
      
      public static const SCENEPOSITION_FightPet:int = 9;
      
      public static const SCENEPOSITION_OrganizationWar:int = 10;
      
      public static const SCENEPOSITION_TraitorAttack:int = 11;
      
      public static const SCENEPOSITION_SevenKing:int = 12;
      
      public static const SCENEPOSITION_CrossServerWar:int = 13;
      
      public static const SCENEPOSITION_Palace:int = 14;
      
      public static const SCENEPOSITION_FightAnimal:int = 15;
      
      public static const SCENEPOSITION_GroupBattle:int = 16;
      
      public static const SCENEPOSITION_TopTeam:int = 17;
      
      public static const SCENEPOSITION_Celebrate:int = 18;
      
      public static const REWARDIDNotInventory_DATA:Vector.<uint> = Vector.<uint>([14100022,14100023,14100024,14100025,14100026,14100027,14100028,14100061,14100062,14100063,14100064]);
      
      public static const REWARDID_DATA:Vector.<uint> = Vector.<uint>([14100022,14100023,14100024,14100025,14100026,14100027,14100028,14100061,14100062,14100063,14100064,14100043,14100044,14100045]);
      
      public static const REWARDID_TOMAINCODE:Vector.<uint> = Vector.<uint>([0,0,0,2,5,6,3,7,7,7,7,4,4,4]);
      
      public static const REWARDID_TOSUBCODE:Vector.<uint> = Vector.<uint>([0,1,2,0,0,0,0,3,4,5,6,11100101,11100102,11200003]);
      
      public static const REWARDID_DATA_MAIL:Vector.<uint> = Vector.<uint>([14100022,14100024,14100028,14100023,14100027,14100026,0,14100061,14100062,14100063,14100064,14100025,0,0,0,0,0,0,0]);
      
      public static const Ninja_One_Reincarnation_Footstone:int = 1000;
      
      public static const Ninja_Two_Reincarnation_Footstone:int = 2000;
      
      public static const Ninja_Reincarnation_Logic_:int = 120;
      
      public static const Ninja_Reincarnation_Logic_Footstone:int = 50;
      
      public static const Ninja_One_QianNeng:int = 100;
      
      public static const Ninja_Two_QianNeng:int = 150;
      
      public static const Ninja_Three_QianNeng:int = 200;
      
      public static const Ninja_Max_QianNeng:int = 250;
      
      public static const Ninja_BeforeReincarnation_MaxLevel:int = 150;
      
      public static const Ninja_BeforeReincarnationOne_MaxLevel:int = 1050;
      
      public static const Nija_Reincarnation_Effect_NotMain:uint = 90000001;
      
      public static const Ninja_Three_Reincarnation_Footstone:int = 3000;
      
      public function CONST_COMMON()
      {
         super();
      }
      
      public static function GAME_MemCriticalUpperLimit() : Boolean
      {
         return !Boolean(System.totalMemory / 1024 / 1000 < CONST_COMMON.GAME_MemCriticalValue);
      }
      
      public static function RewardIDToTemplateID(param1:uint, param2:uint) : uint
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc3_ = 0;
         while(_loc3_ < REWARDID_TOMAINCODE.length)
         {
            if(REWARDID_TOMAINCODE[_loc3_] == param1 && REWARDID_TOSUBCODE[_loc3_] == param2)
            {
               return REWARDID_DATA[_loc3_];
            }
            _loc3_++;
         }
         return 0;
      }
      
      public static function GetItemIDByType(param1:int, param2:int, param3:TBins) : uint
      {
         switch(param1)
         {
            case 0:
               if(param2 == 0)
               {
                  return 14100022;
               }
               if(param2 == 1)
               {
                  return 14100023;
               }
               if(param2 == 2)
               {
                  return 14100024;
               }
               break;
            case 2:
               break;
            case 3:
               return 14100028;
            case 4:
               return param3.GetArticleIdByValue(param2);
            case 5:
               return 14100026;
            case 6:
               return 14100027;
            case 7:
               if(param2 == 3)
               {
                  return 14100061;
               }
               if(param2 == 4)
               {
                  return 14100062;
               }
               if(param2 == 5)
               {
                  return 14100063;
               }
               if(param2 == 6)
               {
                  return 14100064;
               }
            case 12:
               return param2;
            case 13:
               if(param2 == 8)
               {
                  return 14101021;
               }
               if(param2 == 9)
               {
                  return 14111283;
               }
               if(param2 == 10)
               {
                  return 14111284;
               }
               if(param2 == 11)
               {
                  return 14111285;
               }
               if(param2 == 12)
               {
                  return 14111286;
               }
               if(param2 == 13)
               {
                  return 14111287;
               }
               if(param2 == 14)
               {
                  return 14111288;
               }
               if(param2 == 15)
               {
                  return 14111289;
               }
            case 21:
               return 14111273;
            case 23:
               return 14107166;
            case 25:
               return 14111276;
            default:
               return param2;
         }
         return 14100025;
      }
      
      public static function GetMainHeroLogicLevel(param1:int) : uint
      {
         if(param1 >= Ninja_Three_Reincarnation_Footstone)
         {
            param1 = Ninja_Reincarnation_Logic_ + Ninja_Reincarnation_Logic_Footstone * 2 + (param1 - Ninja_Three_Reincarnation_Footstone);
         }
         else if(param1 >= Ninja_Two_Reincarnation_Footstone)
         {
            param1 = Ninja_Reincarnation_Logic_ + Ninja_Reincarnation_Logic_Footstone + (param1 - Ninja_Two_Reincarnation_Footstone);
         }
         else if(param1 >= Ninja_One_Reincarnation_Footstone)
         {
            param1 = Ninja_Reincarnation_Logic_ + (param1 - Ninja_One_Reincarnation_Footstone);
         }
         return param1;
      }
   }
}

