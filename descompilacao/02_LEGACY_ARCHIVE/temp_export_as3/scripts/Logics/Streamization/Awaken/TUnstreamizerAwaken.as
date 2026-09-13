package Logics.Streamization.Awaken
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Characters.THero;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.awaken.date.AwakenLogicDate;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerAwaken extends TUnstreamizer
   {
      
      public function TUnstreamizerAwaken()
      {
         super();
      }
      
      public function AwakenKnapsackChange(param1:ByteArray, param2:Object) : void
      {
         var _loc3_:AwakenLogicDate = param2 as AwakenLogicDate;
         _loc3_.AddBackPackageById(param1.readUnsignedInt(),param1.readUnsignedInt());
      }
      
      public function AwakenTanSuoBack(param1:ByteArray, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:AwakenLogicDate = param2 as AwakenLogicDate;
         _loc4_ = param1.readShort();
         _loc5_.TanSuoIdVec.length = 0;
         _loc5_.TanSuoCountVec.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = uint(param1.readShort());
            _loc7_ = int(param1.readUnsignedInt());
            _loc8_ = int(param1.readUnsignedInt());
            _loc5_.TanSuoIdVec.push(_loc7_);
            _loc5_.TanSuoCountVec.push(_loc8_);
            _loc5_.addGetRewardTakeNotesById(_loc7_,_loc8_);
            _loc3_++;
         }
      }
      
      public function AwakenGetRewardTakeNotes(param1:ByteArray, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:AwakenLogicDate = param2 as AwakenLogicDate;
         _loc4_ = param1.readShort();
         _loc5_.GetRewardTakeNotes.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_.addGetRewardTakeNotesById(param1.readUnsignedInt(),param1.readUnsignedInt());
            _loc3_++;
         }
      }
      
      public function AwakenSkillInformation(param1:ByteArray, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:THero = null;
         var _loc5_:AwakenLogicDate = param2 as AwakenLogicDate;
         _loc4_ = param1.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = param1.readUnsignedInt();
            _loc7_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc6_);
            _loc7_.AwakenSpecialSkillId = param1.readUnsignedInt();
            _loc7_.AwakenCommonSkillId = param1.readUnsignedInt();
            _loc3_++;
         }
      }
      
      public function AwakenPacksackInformation(param1:ByteArray, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:AwakenLogicDate = param2 as AwakenLogicDate;
         _loc4_ = param1.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_.AddBackPackageById(param1.readUnsignedInt(),param1.readUnsignedInt());
            _loc3_++;
         }
         SLogicsCore.AwakenDate.CommonCount = param1.readUnsignedInt();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc4_:AwakenLogicDate = param2 as AwakenLogicDate;
         _loc5_ = param1.readShort();
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = int(param1.readUnsignedInt());
            _loc4_.NextTimesVec[_loc7_ - 1] = param1.readUnsignedInt();
            _loc4_.DangRiYiDuiHuanCount[_loc7_ - 1] = param1.readUnsignedInt();
            _loc4_.DangRiYiShiYongDuiHuanCount[_loc7_ - 1] = param1.readUnsignedInt();
            _loc4_.DanCiCountVec[_loc7_ - 1] = param1.readUnsignedInt();
            _loc4_.PiLiangCountVec[_loc7_ - 1] = param1.readUnsignedInt();
            _loc6_++;
         }
      }
   }
}

