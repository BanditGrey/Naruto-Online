package Logics.Streamization.Campaign
{
   import Foundation.Resources.Repositories.*;
   import Logics.Campaign.*;
   import Logics.DatebaseVO.VO.*;
   import Resources.Constants.*;
   import flash.utils.*;
   
   public class TUnstreamizerNodalSceneMonster extends TUnstreamizerCampaignUnknown
   {
      
      public function TUnstreamizerNodalSceneMonster()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TNodalSceneModel = null;
         var _loc7_:TResourceRepositoryBin = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:TMonsters = null;
         var _loc12_:TMonster = null;
         var _loc13_:uint = 0;
         var _loc14_:TCity = null;
         var _loc15_:TBlockPoint = null;
         var _loc16_:TSingle = null;
         var _loc17_:TSinglePointPath = null;
         var _loc18_:TRaidersDailyConfig = null;
         var _loc19_:TEnemyArmy = null;
         var _loc20_:TEnemy = null;
         _loc6_ = param2 as TNodalSceneModel;
         _loc7_ = param3 as TResourceRepositoryBin;
         _loc6_.LayerIndex = param1.readByte();
         _loc6_.EnemyIndex = param1.readByte();
         if(_loc6_.EnterType == CONST_BATTLE.BattleType_Nodal)
         {
            _loc15_ = _loc7_.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BlockPoint,_loc6_.MissionId) as TBlockPoint;
            _loc6_.ResourceBgId = _loc15_.BigImage;
            _loc8_ = _loc15_.Armys.length;
            _loc4_ = 0;
            while(_loc4_ < _loc8_)
            {
               _loc11_ = new TMonsters();
               _loc19_ = _loc7_.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EnemyArmy,_loc15_.Armys[_loc4_]) as TEnemyArmy;
               _loc9_ = _loc19_.EnemyIdVect.length;
               _loc5_ = 0;
               while(_loc5_ < _loc9_)
               {
                  _loc20_ = _loc7_.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Enemy,_loc19_.EnemyIdVect[_loc5_]) as TEnemy;
                  _loc12_ = FPoolCampaign.AcquireMonster(_loc19_.EnemyIdVect[_loc5_]);
                  _loc12_.IsChar = false;
                  _loc12_.MonsterPos = _loc19_.EnemyPosVect[_loc5_];
                  _loc12_.MonsterLevel = _loc20_.Level;
                  _loc12_.MonsterHealth = _loc20_.Hp;
                  _loc11_.Add(_loc12_);
                  _loc5_++;
               }
               _loc6_.Monsters.push(_loc11_);
               _loc6_.EnemyArmyId.push(_loc15_.Armys[_loc4_]);
               _loc4_++;
            }
         }
         else if(_loc6_.EnterType == CONST_BATTLE.BattleType_Camp)
         {
            _loc14_ = _loc7_.GetDatebase(CONST_DATEBASEVO.RESOURCEID_City,_loc6_.CityId) as TCity;
            if(_loc14_.Start == _loc6_.MissionId)
            {
               _loc6_.Diffculty = TCampaign.Type_Noraml;
            }
            else if(_loc14_.Last == _loc6_.MissionId)
            {
               _loc6_.Diffculty = TCampaign.Type_Hard;
            }
            else
            {
               _loc6_.Diffculty = TCampaign.Type_None;
            }
            _loc16_ = _loc7_.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Single,_loc6_.MissionId) as TSingle;
            _loc17_ = _loc7_.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SinglePointPath,_loc16_.StartId + _loc6_.LayerIndex) as TSinglePointPath;
            _loc6_.ResourceBgId = _loc17_.Mapname;
            _loc8_ = _loc17_.Armys.length;
            _loc4_ = _loc6_.EnemyIndex;
            while(_loc4_ < _loc8_)
            {
               _loc11_ = new TMonsters();
               _loc19_ = _loc7_.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EnemyArmy,_loc17_.Armys[_loc4_]) as TEnemyArmy;
               _loc9_ = _loc19_.EnemyIdVect.length;
               _loc5_ = 0;
               while(_loc5_ < _loc9_)
               {
                  _loc20_ = _loc7_.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Enemy,_loc19_.EnemyIdVect[_loc5_]) as TEnemy;
                  _loc12_ = FPoolCampaign.AcquireMonster(_loc19_.EnemyIdVect[_loc5_]);
                  _loc12_.IsChar = false;
                  _loc12_.MonsterPos = _loc19_.EnemyPosVect[_loc5_];
                  _loc12_.MonsterLevel = _loc20_.Level;
                  _loc12_.MonsterHealth = _loc20_.Hp;
                  _loc11_.Add(_loc12_);
                  _loc5_++;
               }
               _loc6_.Monsters.push(_loc11_);
               _loc6_.EnemyArmyId.push(_loc17_.Armys[_loc4_]);
               _loc4_++;
            }
         }
         else if(_loc6_.EnterType == CONST_BATTLE.BattleType_KillHero)
         {
            _loc18_ = _loc7_.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RaidersDailyConfig,_loc6_.MissionId) as TRaidersDailyConfig;
            _loc6_.ResourceBgId = _loc18_.PicPath;
            _loc8_ = _loc18_.EnemyArmy.length;
            _loc4_ = 0;
            while(_loc4_ < _loc8_)
            {
               _loc11_ = new TMonsters();
               _loc19_ = _loc7_.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EnemyArmy,_loc18_.EnemyArmy[_loc4_]) as TEnemyArmy;
               _loc9_ = _loc19_.EnemyIdVect.length;
               _loc5_ = 0;
               while(_loc5_ < _loc9_)
               {
                  _loc20_ = _loc7_.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Enemy,_loc19_.EnemyIdVect[_loc5_]) as TEnemy;
                  _loc12_ = FPoolCampaign.AcquireMonster(_loc19_.EnemyIdVect[_loc5_]);
                  _loc12_.IsChar = false;
                  _loc12_.MonsterPos = _loc19_.EnemyPosVect[_loc5_];
                  _loc12_.MonsterLevel = _loc20_.Level;
                  _loc12_.MonsterHealth = _loc20_.Hp;
                  _loc11_.Add(_loc12_);
                  _loc5_++;
               }
               _loc6_.Monsters.push(_loc11_);
               _loc6_.EnemyArmyId.push(_loc18_.EnemyArmy[_loc4_]);
               _loc4_++;
            }
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

