package Logics.Streamization.Campaign
{
   import Foundation.Resources.Repositories.TResourceRepositoryBin;
   import Logics.Campaign.TMonster;
   import Logics.Campaign.TMonsters;
   import Logics.Campaign.TNodalSceneModel;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TCity;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerNodalScene extends TUnstreamizerCampaignUnknown
   {
      
      protected var UnstreamizerNodalSceneMonster:TUnstreamizerNodalSceneMonster;
      
      public function TUnstreamizerNodalScene()
      {
         super();
         this.UnstreamizerNodalSceneMonster = new TUnstreamizerNodalSceneMonster();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:TNodalSceneModel = null;
         var _loc6_:TMonster = null;
         var _loc7_:TMonsters = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:TResourceRepositoryBin = null;
         var _loc11_:THeros = null;
         var _loc12_:THero = null;
         var _loc13_:TCity = null;
         _loc5_ = param2 as TNodalSceneModel;
         _loc10_ = param3 as TResourceRepositoryBin;
         _loc5_.CityId = param1.readInt();
         _loc5_.MissionId = param1.readInt();
         _loc13_ = _loc10_.GetDatebase(CONST_DATEBASEVO.RESOURCEID_City,_loc5_.CityId) as TCity;
         if(_loc13_ == null)
         {
            _loc5_.EnterType = CONST_BATTLE.BattleType_KillHero;
         }
         else
         {
            _loc5_.EnterType = _loc13_.Type;
         }
         _loc11_ = SLogicsCore.Character.Heros;
         _loc9_ = uint(_loc11_.Count);
         _loc7_ = _loc5_.Heros;
         _loc4_ = 0;
         while(_loc4_ < _loc11_.Count)
         {
            _loc12_ = _loc11_.GetHeroByIndex(_loc4_);
            if((Boolean(_loc12_)) && _loc12_.FightPosition > 0)
            {
               _loc8_ = _loc12_.Identifier;
               _loc6_ = FPoolCampaign.AcquireMonster(_loc8_);
               _loc6_.IsChar = Boolean(_loc4_ == 0);
               _loc6_.MonsterPos = _loc12_.FightPosition;
               _loc7_.Add(_loc6_);
            }
            _loc4_++;
         }
         this.UnstreamizerNodalSceneMonster.Unstreamize(param1,param2,param3);
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

