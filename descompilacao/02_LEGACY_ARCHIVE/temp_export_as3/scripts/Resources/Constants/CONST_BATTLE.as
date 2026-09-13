package Resources.Constants
{
   import Foundation.Common.Integer.UInt64;
   import Processors.Game.Battle.Character.TRole;
   
   public class CONST_BATTLE
   {
      
      public static const BattlePetEffectId:uint = 13610069;
      
      public static const BattleSkipCard:uint = 14107065;
      
      public static const SOUNDID_BATTLE_PassNodel:uint = 0;
      
      public static const SOUNDID_BATTLE_Win:uint = 0;
      
      public static const SOUNDID_BATTLE_Lost:uint = 0;
      
      public static const BattleType_Nodal:int = 1;
      
      public static const BattleType_Camp:int = 2;
      
      public static const BattleType_KillHero:int = 3;
      
      public static const BattleType_Arena:int = 4;
      
      public static const BattleType_TreasureMap:int = 5;
      
      public static const BattleType_FightPet:int = 6;
      
      public static const BattleType_CityDefend:int = 7;
      
      public static const BattleType_OrganizationWar:int = 8;
      
      public static const BattleType_TraitorAttack:int = 9;
      
      public static const BattleType_Slave:int = 10;
      
      public static const BattleType_SevenKing:int = 11;
      
      public static const BattleType_CrossServerWar:int = 12;
      
      public static const BattleType_Magic:int = 13;
      
      public static const BattleType_Tower:int = 14;
      
      public static const BattleType_Palace:int = 15;
      
      public static const BattleType_OrganizationBoss:int = 16;
      
      public static const BattleType_Friend:int = 17;
      
      public static const BattleType_BloodSoul:int = 18;
      
      public static const BattleType_SixFairy:int = 19;
      
      public static const BattleType_RebirthRealm:int = 20;
      
      public static const BattleType_TransmigrationTrial:int = 21;
      
      public static const BattleType_Taboo:int = 22;
      
      public static const BattleType_TransmigrationAccessory:int = 23;
      
      public static const BattleType_UnderTown:int = 24;
      
      public static const BattleType_MiGong:int = 25;
      
      public static const BattleType_Alien:int = 26;
      
      public static const BattleType_Qiecuo:int = 27;
      
      public static const BattleType_GlobalBattle:int = 28;
      
      public static const BattleType_WorldMatch:int = 29;
      
      public static const BattleType_SummonBattle:int = 34;
      
      public static const BattleType_ChallengeCamp:int = 35;
      
      public static const BattleType_GlobalBoss:int = 36;
      
      public static const BattleType_CrossSlave:int = 37;
      
      public static const BattleType_GroupBattle:int = 30;
      
      public static const BattleType_MasterRoad:int = 31;
      
      public static const BattleType_Challenge:int = 32;
      
      public static const BattleType_Wing:int = 33;
      
      public static const BattleType_Replay:int = 99;
      
      public static const RESOURCE_Battle:uint = 2164260864;
      
      public static const RESOURCE_GroupBattle:uint = 2164260865;
      
      public static const RESOURCE_ClassName_Text:String = "BattleText";
      
      public static const RESOURCE_ClassName_HP_Bar:String = "HP_Bar";
      
      public static const RESOURCE_ClassName_Win:String = "mc_win";
      
      public static const RESOURCE_ClassName_Lost:String = "mc_lost";
      
      public static const RESOURCE_ClassName_BattleTip:String = "battleTip";
      
      public static const RESOURCE_ClassName_BuffTip:String = "buffTip";
      
      public static const RESOURCE_ClassName_GoneWordBg:String = "GoneWordBg";
      
      public static const RESOURCE_ClassName_GoneWordYellowBg:String = "GoneWordYellowBg";
      
      public static const RESOURCE_ClassName_Result:String = "mc_result";
      
      public static const RESOURCE_ClassName_GroupBattle_Main:String = "MC_GroupUI";
      
      public static const RESOURCE_ClassName_GroupBattle_Win:String = "MC_GroupWin";
      
      public static const RESOURCE_ClassName_GroupBattle_Lost:String = "MC_GroupLost";
      
      public static const RESOURCE_ClassName_GroupBattle_BattleLoad:String = "MC_Battle_UILoad";
      
      public static const RESOURCE_ClassName_TopTeamBattle_Main:String = "MC_TopTeamUI";
      
      public static const RESOURCE_ClassName_TopTeamBattle_Win:String = "MC_TopTeamWin";
      
      public static const RESOURCE_ClassName_TopTeamBattle_BattleLoad:String = "MC_Battle_UILoad";
      
      public static const Active_NormalAttack:int = 1;
      
      public static const Active_SkillAttack:int = 2;
      
      public static const Active_Block:int = 3;
      
      public static const Active_PassiveSkill:int = 4;
      
      public static const Active_DiedSkill:int = 5;
      
      public static const Active_SoulFormationAttck:int = 7;
      
      public static const Active_FightStatus:int = 8;
      
      public static const ActiveType_NoAttack:int = 1;
      
      public static const ActiveType_Daze:int = 2;
      
      public static const ActiveType_ImmCtrl:int = 4;
      
      public static const ActiveType_ImmCalm:int = 8;
      
      public static const ActiveType_NoAddAnger:int = 16;
      
      public static const ActiveType_NoSkill:int = 32;
      
      public static const ActiveType_NoAddHp:int = 64;
      
      public static const ActiveType_BeStone:int = 128;
      
      public static const ActiveType_Nothingness:int = 256;
      
      public static const ActiveType_AllMiss:int = 512;
      
      public static const ActiveType_Confusion:int = 1024;
      
      public static const ActiveType_ImmNoAnger:int = 2048;
      
      public static const ActiveType_ImmNoSkill:int = 4096;
      
      public static const ActiveType_ImmNoHeal:int = 8192;
      
      public static const ActiveType_ImmStone:int = 16384;
      
      public static const ActiveType_ImmFake:int = 32768;
      
      public static const ActiveType_ImmNoAttack:int = 65536;
      
      public static const ActiveType_ImmConfusion:int = 131072;
      
      public static const ActiveType_ImmAllMiss:int = 262144;
      
      public static const ActiveType_HitAcupoints:int = 524288;
      
      public static const ActiveType_ImmHitAcupoints:int = 1048576;
      
      public static const ActiveType_Awe:int = 2097152;
      
      public static const ActiveType_ImmAwe:int = 4194304;
      
      public static const ActiveType_ImmDead:int = 8388608;
      
      public static const ActiveType_Hit:int = 33554432;
      
      public static const ActiveType_Crit:int = 67108864;
      
      public static const ActiveType_Block:int = 134217728;
      
      public static const ActiveType_Help:int = 268435456;
      
      public static const ActiveType_Punch:int = 536870912;
      
      public static const ActiveType_Died:int = 1073741824;
      
      public static const ActiveType_TargetEffect:int = 2147483648;
      
      public static const ActiveType_Cripple:int = 1;
      
      public static const ActiveType_ImmCripple:int = 2;
      
      public static const ActiveType_Expel:int = 4;
      
      public static const ActiveType_ImmExpel:int = 8;
      
      public static const ActiveType_Paralysis:int = 16;
      
      public static const ActiveType_ImmParalysis:int = 32;
      
      public static const ActiveType_Blind:int = 64;
      
      public static const ActiveType_ImmBlind:int = 128;
      
      public static const ActiveType_Moon:int = 256;
      
      public static const ActiveType_ImmMoon:int = 512;
      
      public static const ActiveType_Seal:int = 1024;
      
      public static const ActiveType_ImmSeal:int = 2048;
      
      public static const ActiveType_Holding:int = 4096;
      
      public static const ActiveType_ImmHolding:int = 8192;
      
      public static const ActiveType_BengHuai:int = 16384;
      
      public static const ActiveType_ImmBengHuai:int = 32768;
      
      public static const ActiveType_Ice:int = 131072;
      
      public static const ActiveType_ImmIce:int = 262144;
      
      public static const ActiveType_FastMiss:int = 524288;
      
      public static const ActiveType_ImmFastMiss:int = 1048576;
      
      public static const ActiveType_CritExtra:int = 2097152;
      
      public static const ActiveType_FengDun:int = 4194304;
      
      public static const ActiveType_Penetrate:int = 16777216;
      
      public static const ActiveType_FengFu:int = 33554432;
      
      public static const ActiveType_ImmFengFu:int = 67108864;
      
      public static const ActiveType_Weak:int = 1;
      
      public static const ActiveType_ImmWeak:int = 2;
      
      public static const ActiveType_Charm:int = 4;
      
      public static const ActiveType_ImmCharm:int = 8;
      
      public static const ActiveType_Jiban:int = 16;
      
      public static const ActiveType_ImmJiban:int = 32;
      
      public static const ActiveType_ImmDownWind:int = 128;
      
      public static const ActiveType_ImmUpWind:int = 512;
      
      public static const ActiveType_ImmDuFeng:int = 2048;
      
      public static const ActiveType_ImmPoison:int = 8192;
      
      public static const ActiveType_ImmBurn:int = 32768;
      
      public static const ActiveType_ImmEndure:int = 131072;
      
      public static const EFFECT_BIGBLACK_ID:int = 13610001;
      
      public static const BATTLE_BIGBLACK_ID:int = 13610033;
      
      public static const BATTLE_ARENA_BackGround_ID:int = 1000000;
      
      public static const Effect_CITYDEFEND_BOOM:int = 13620044;
      
      public static const Public_Effect_AngerRing:int = 13610006;
      
      public static const Public_Effect_Crit:int = 13610008;
      
      public static const Public_Effect_Stakes:int = 13610010;
      
      public static const Public_Effect_Smoke:int = 13610011;
      
      public static const Public_Effect_Daoguang:int = 13610012;
      
      public static const Public_Effect_Shadow:int = 13610013;
      
      public static const Public_Effect_KniftEffect:int = 13610103;
      
      public static const Public_Effect_PetAttackEffect:int = 13620001;
      
      public static const Public_Effect_DeadSkillEffect_Enemy:int = 13610123;
      
      public static const Public_Effect_DeadSkillEffect_Friend:int = 13610124;
      
      public static const Public_Effect_AddHp:int = 13600007;
      
      public static const Public_Effect_AddAngle:int = 13610019;
      
      public static const Public_Effect_DecAngle:int = 13610020;
      
      public static const COMMON_EffectVect:Vector.<uint> = Vector.<uint>([Public_Effect_AngerRing,Public_Effect_Crit,Public_Effect_Stakes,Public_Effect_Smoke,Public_Effect_Daoguang,Public_Effect_Shadow,Public_Effect_AddHp,Public_Effect_AddAngle,Public_Effect_DecAngle,Public_Effect_DeadSkillEffect_Enemy,Public_Effect_DeadSkillEffect_Friend]);
      
      public static const CITY_DOOR:int = 13610018;
      
      public static const TEXT_Add_Color:uint = 4278255360;
      
      public static const TEXT_Add_FilterColor:uint = 4282128902;
      
      public static const TEXT_Dec_Color:uint = 4294953984;
      
      public static const TEXT_Dec_FilterColor:uint = 4282128902;
      
      public static const TEXT_Crit_Color:uint = 4294901760;
      
      public static const TEXT_Crit_FilterColor:uint = 4294953984;
      
      public static const TEXT_FIGHT_STATUS_NONE:int = 0;
      
      public static const TEXT_FIGHT_STATUS_Miss:int = 1;
      
      public static const TEXT_FIGHT_STATUS_Block:int = 2;
      
      public static const TEXT_FIGHT_STATUS_Poison:int = 3;
      
      public static const TEXT_FIGHT_STATUS_Kill:int = 4;
      
      public static const TEXT_FIGHT_STATUS_LostHp:int = 5;
      
      public static const TEXT_FIGHT_STATUS_AbsorbHp:int = 6;
      
      public static const TEXT_FIGHT_STATUS_Counterattack:int = 7;
      
      public static const TEXT_FIGHT_STATUS_Crit:int = 8;
      
      public static const TEXT_FIGHT_STATUS_Punch:int = 9;
      
      public static const TEXT_FIGHT_STATUS_Help:int = 10;
      
      public static const TEXT_FIGHT_STATUS_Lost:int = 11;
      
      public static const TEXT_FIGHT_STATUS_OtherTurn:int = 12;
      
      public static const TEXT_FIGHT_STATUS_OtherTurnLost:int = 13;
      
      public static const TEXT_FIGHT_STATUS_NoAddAnger:int = 14;
      
      public static const TEXT_FIGHT_STATUS_NoSkill:int = 15;
      
      public static const TEXT_FIGHT_STATUS_NoAddHp:int = 16;
      
      public static const TEXT_FIGHT_STATUS_NoAttack:int = 17;
      
      public static const TEXT_FIGHT_STATUS_BeStone:int = 18;
      
      public static const TEXT_FIGHT_STATUS_Nothingness:int = 19;
      
      public static const TEXT_FIGHT_STATUS_AllMiss:int = 20;
      
      public static const TEXT_FIGHT_STATUS_Confusion:int = 21;
      
      public static const TEXT_FIGHT_STATUS_ImmNoAnger:int = 22;
      
      public static const TEXT_FIGHT_STATUS_ImmNoSkill:int = 23;
      
      public static const TEXT_FIGHT_STATUS_ImmNoHeal:int = 24;
      
      public static const TEXT_FIGHT_STATUS_ImmStone:int = 25;
      
      public static const TEXT_FIGHT_STATUS_ImmFake:int = 26;
      
      public static const TEXT_FIGHT_STATUS_ImmNoAttack:int = 27;
      
      public static const TEXT_FIGHT_STATUS_ImmConfusion:int = 28;
      
      public static const TEXT_FIGHT_STATUS_ImmAllMiss:int = 29;
      
      public static const TEXT_FIGHT_STATUS_DeadSkill:int = 30;
      
      public static const TEXT_FIGHT_STATUS_Fire:int = 31;
      
      public static const TEXT_FIGHT_STATUS_HitAcupoints:int = 35;
      
      public static const TEXT_FIGHT_STATUS_ImmHitAcupoints:int = 36;
      
      public static const TEXT_FIGHT_STATUS_Awe:int = 37;
      
      public static const TEXT_FIGHT_STATUS_ImmAwe:int = 38;
      
      public static const TEXT_FIGHT_STATUS_HurtSelf:int = 39;
      
      public static const TEXT_FIGHT_STATUS_Cripple:int = 40;
      
      public static const TEXT_FIGHT_STATUS_Immcripple:int = 41;
      
      public static const TEXT_FIGHT_STATUS_Separate:int = 42;
      
      public static const TEXT_FIGHT_STATUS_Dead:int = 43;
      
      public static const TEXT_FIGHT_STATUS_ImmDead:int = 44;
      
      public static const TEXT_FIGHT_STATUS_Cripple1:int = 45;
      
      public static const TEXT_FIGHT_STATUS_ImmCripple1:int = 46;
      
      public static const TEXT_FIGHT_STATUS_Expel:int = 47;
      
      public static const TEXT_FIGHT_STATUS_ImmExpel:int = 48;
      
      public static const TEXT_FIGHT_STATUS_ImmParalysis:int = 52;
      
      public static const TEXT_FIGHT_STATUS_ImmBlind:int = 54;
      
      public static const TEXT_FIGHT_STATUS_ImmMoon:int = 55;
      
      public static const TEXT_FIGHT_STATUS_ImmSeal:int = 56;
      
      public static const TEXT_FIGHT_STATUS_ImmHolding:int = 57;
      
      public static const TEXT_FIGHT_STATUS_ImmBengHuai:int = 58;
      
      public static const TEXT_FIGHT_STATUS_FengMie:int = 59;
      
      public static const TEXT_FIGHT_STATUS_ImmIce:int = 60;
      
      public static const TEXT_FIGHT_STATUS_FastMiss:int = 61;
      
      public static const TEXT_FIGHT_STATUS_ImmFastMiss:int = 62;
      
      public static const TEXT_FIGHT_STATUS_CritExtra:int = 63;
      
      public static const TEXT_FIGHT_STATUS_FengDun:int = 64;
      
      public static const TEXR_FIGHT_STATUS_Penetrate:int = 65;
      
      public static const TEXR_FIGHT_STATUS_BlocksPlus:int = 66;
      
      public static const TEXT_FIGHT_STATUS_Relive:int = 67;
      
      public static const TEXT_FIGHT_STATUS_ImmFengFu:int = 68;
      
      public static const TEXT_FIGHT_STATUS_ImmWeak:int = 69;
      
      public static const TEXT_FIGHT_STATUS_ImmCharm:int = 70;
      
      public static const TEXT_FIGHT_STATUS_ImmJiban:int = 71;
      
      public static const TEXT_FIGHT_STATUS_ImmDownWind:int = 72;
      
      public static const TEXT_FIGHT_STATUS_ImmUpWind:int = 73;
      
      public static const TEXT_FIGHT_STATUS_DuFeng:int = 74;
      
      public static const TEXT_FIGHT_STATUS_ImmDuFeng:int = 75;
      
      public static const TEXT_FIGHT_STATUS_ImmPoison:int = 76;
      
      public static const TEXT_FIGHT_STATUS_ImmBurn:int = 77;
      
      public static const TEXT_FIGHT_STATUS_ImmEndure:int = 78;
      
      public static const TEXT_FIGHT_COLOR:Vector.<uint> = Vector.<uint>([4294953984,4294940928,4294940928,4281584640,4278190080,4291559424,4288230399,4294967295,4294953984,4294953984,4294953984,4294953984,4294953984,4294953984,4281566719,4281566719,4281566719,4281566719,4287529621,4290608116,4294965867,4287159859,4281566719,4281566719,4281566719,4281566719,4281566719,4281566719,4281566719,4281566719,4278190080,4278190080,4278190080,4278190080,4278190080,4278190080,4278190080,4278190080,4278190080,4278190080,4278190080,4278190080,4278190080,4278190080,4281566719,4278190080,4281566719,4278190080,4281566719,4278190080,4278190080,4278190080,4281566719,4278190080,4281566719,4281566719,4281566719,4281566719,4281566719,4278190080,4281566719,4294965867,4281566719,4281566719,4281566719,4294967295,4294967295,4294967295,4281566719,4281566719,4281566719,4281566719,4281566719,4281566719,4281566719,4281566719,4281566719,4281566719,4281566719]);
      
      public static const TEXT_FIGHT_FILTERCOLOR:Vector.<uint> = Vector.<uint>([4282128902,4284560387,4284560387,4278203136,4294967295,4294930287,4281532569,4280458205,4282128902,4282128902,4282128902,4282128902,4282128902,4282128902,4281215554,4281215554,4281215554,4281215554,4281215554,4281215554,4282916368,4280629015,4281215554,4281215554,4281215554,4281215554,4281215554,4281215554,4281215554,4281215554,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4281215554,4294967295,4281215554,4282128902,4281215554,4294967295,4294967295,4294967295,4281215554,4294967295,4281215554,4281215554,4281215554,4281215554,4281215554,4294967295,4281215554,4282916368,4281215554,4281215554,4281215554,4294967295,4294967295,4294967295,4281215554,4281215554,4281215554,4281215554,4281215554,4281215554,4281215554,4281215554,4281215554,4281215554,4281215554]);
      
      protected static const BUFFSKILL_ID_INDEX:Vector.<uint> = Vector.<uint>([0,0,0,13500020,0,13500021,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13500022,13500070,13500071,13500072,13500073,0,13500074,0,0,13500076,0,13500077,13500082,0,13500094,0,13500096,0,13500095,13500097,13500098,0,13500100,0,0,0,0,0,13500113,0,13500119,0,0,0,0,0,0,0,0,0,0,0,0,13500131,0,0,0,0]);
      
      public static const TURN_OF_CHALLENGE:int = 20;
      
      public function CONST_BATTLE()
      {
         super();
      }
      
      public static function GetColorIndex(param1:uint) : int
      {
         if(param1 > TEXT_FIGHT_COLOR.length)
         {
            return TEXT_FIGHT_COLOR[0];
         }
         return TEXT_FIGHT_COLOR[param1];
      }
      
      public static function GetFilterColorIndex(param1:uint) : int
      {
         if(param1 > TEXT_FIGHT_FILTERCOLOR.length)
         {
            return TEXT_FIGHT_FILTERCOLOR[0];
         }
         return TEXT_FIGHT_FILTERCOLOR[param1];
      }
      
      public static function GetBuffSkillIndex(param1:uint) : int
      {
         return BUFFSKILL_ID_INDEX.indexOf(param1);
      }
      
      public static function AverageX(param1:Vector.<TRole>, param2:int) : Number
      {
         var _loc3_:int = 0;
         var _loc4_:TRole = null;
         var _loc5_:Number = 0;
         var _loc6_:int = 0;
         if(param1 == null)
         {
            return 0;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            if(_loc4_.Camp != param2)
            {
               _loc5_ += _loc4_.PosX;
               _loc6_++;
            }
            _loc3_++;
         }
         return _loc5_ / _loc6_;
      }
      
      public static function AverageY(param1:Vector.<TRole>, param2:int) : Number
      {
         var _loc3_:int = 0;
         var _loc4_:TRole = null;
         var _loc5_:Number = 0;
         var _loc6_:int = 0;
         if(param1 == null)
         {
            return 0;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            if(_loc4_.Camp != param2)
            {
               _loc5_ += _loc4_.PosY;
               _loc6_++;
            }
            _loc3_++;
         }
         return _loc5_ / _loc6_;
      }
      
      public static function HasEnemy(param1:Vector.<TRole>, param2:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:TRole = null;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            if(_loc4_.Camp != param2)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public static function FightReport_Time(param1:UInt64) : int
      {
         return param1.Low;
      }
      
      public static function FightReport_Sid(param1:UInt64) : int
      {
         return param1.High & 0xFFFF;
      }
   }
}

