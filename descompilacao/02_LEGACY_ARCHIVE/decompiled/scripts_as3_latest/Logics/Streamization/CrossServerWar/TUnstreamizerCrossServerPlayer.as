package Logics.Streamization.CrossServerWar
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.CrossServerWar.TChallengePlayer;
   import Logics.CrossServerWar.TChallengePlayers;
   import Logics.DatebaseVO.VO.TBasePet;
   import Logics.Streamization.Characters.TUnstreamizerCharacter;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_CROSSSERVERWAR;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerCrossServerPlayer extends TUnstreamizer
   {
      
      protected var FUnstreamizerCharacter:TUnstreamizerCharacter;
      
      public function TUnstreamizerCrossServerPlayer()
      {
         super();
         this.FUnstreamizerCharacter = new TUnstreamizerCharacter();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:int = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:TChallengePlayer = null;
         var _loc13_:TChallengePlayers = null;
         var _loc14_:TBasePet = null;
         _loc8_ = new Vector.<uint>();
         _loc13_ = param2 as TChallengePlayers;
         _loc4_ = param1 as ByteArray;
         _loc6_ = _loc4_.readUnsignedShort();
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc12_ = new TChallengePlayer();
            _loc12_.TargetIndex = _loc4_.readUnsignedInt();
            _loc12_.TargetName = TUtilityString.FetchUTF(_loc4_);
            _loc12_.TargetServerName = TUtilityString.FetchUTF(_loc4_);
            _loc10_ = _loc8_.length;
            _loc9_ = 0;
            while(_loc9_ < _loc10_)
            {
               _loc8_.pop();
               _loc9_++;
            }
            _loc7_ = _loc4_.readUnsignedInt();
            _loc8_.push(_loc7_);
            _loc10_ = _loc4_.readUnsignedShort();
            _loc9_ = 0;
            while(_loc9_ < _loc10_)
            {
               _loc7_ = _loc4_.readUnsignedInt();
               _loc8_.push(_loc7_);
               _loc9_++;
            }
            this.FUnstreamizerCharacter.UnstreamizeGenerateHerosByIdentifiers(null,_loc12_.TargetHeros,_loc8_);
            _loc12_.TargetLevel = _loc4_.readUnsignedInt();
            _loc12_.TargetQuality = _loc4_.readUnsignedInt();
            _loc12_.TargetFightingPower.High = _loc4_.readUnsignedInt();
            _loc12_.TargetFightingPower.Low = _loc4_.readUnsignedInt();
            _loc7_ = _loc4_.readUnsignedInt();
            if(_loc7_ == 0)
            {
               _loc12_.TargetPetLevel = STRING_COMMON.COMMON_NONE;
            }
            else
            {
               _loc14_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BasePet,_loc7_) as TBasePet;
               if(_loc14_)
               {
                  if(_loc14_.NeedTransLv == 3)
                  {
                     _loc12_.TargetPetLevel = TUtilityString.Format(STRING_CROSSSERVERWAR.FORMAT_ReincarnationPetLevel2,_loc14_.ReviceCount + 1,_loc14_.Star);
                  }
                  else if(_loc14_.NeedTransLv == 2 || _loc14_.NeedTransLv == 1)
                  {
                     _loc12_.TargetPetLevel = TUtilityString.Format(STRING_CROSSSERVERWAR.FORMAT_ReincarnationPetLevel,_loc14_.ReviceCount + 1,_loc14_.Star);
                  }
                  else
                  {
                     _loc12_.TargetPetLevel = TUtilityString.Format(STRING_CROSSSERVERWAR.FORMAT_PetLevel,_loc14_.ReviceCount + 1,_loc14_.Star);
                  }
               }
            }
            _loc12_.TargetScore = _loc4_.readUnsignedInt();
            _loc12_.IsDefeated = Boolean(_loc4_.readUnsignedByte());
            _loc13_.Add(_loc12_);
            _loc5_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

