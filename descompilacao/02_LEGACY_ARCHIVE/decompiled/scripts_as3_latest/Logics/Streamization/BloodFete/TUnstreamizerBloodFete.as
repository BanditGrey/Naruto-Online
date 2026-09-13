package Logics.Streamization.BloodFete
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.BloodFete.TBloodFeteData;
   import Logics.BloodFete.TBloodFeteSingle;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.BloodFete.Panel.TProcessorWindowBloodFeteMainPanel;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerBloodFete extends TUnstreamizer
   {
      
      public function TUnstreamizerBloodFete()
      {
         super();
      }
      
      public function MoveSynchronization(param1:ByteArray, param2:Object) : void
      {
         var _loc3_:TBloodFeteData = null;
         var _loc4_:TBloodFeteSingle = null;
         var _loc5_:THero = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc3_ = param2 as TBloodFeteData;
         _loc6_ = param1.readUnsignedInt();
         _loc7_ = param1.readUnsignedInt();
         _loc8_ = param1.readUnsignedInt();
         _loc9_ = param1.readUnsignedInt();
         if(_loc6_ == 0)
         {
            _loc4_ = _loc3_.GetBloodFeteById64Real(_loc8_,_loc9_);
            _loc4_.PositionIndex = _loc7_;
         }
         else
         {
            _loc5_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc6_);
            _loc4_ = _loc5_.GetBloodFeteById64(_loc8_,_loc9_);
            _loc4_.PositionIndex = _loc7_;
         }
      }
      
      public function SellBloodFete(param1:ByteArray, param2:Object, param3:TProcessorWindowBloodFeteMainPanel) : void
      {
         var _loc4_:TBloodFeteData = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:TBloodFeteSingle = null;
         _loc4_ = param2 as TBloodFeteData;
         _loc6_ = uint(param1.readShort());
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = param1.readUnsignedInt();
            _loc8_ = param1.readUnsignedInt();
            _loc9_ = param1.readUnsignedInt();
            _loc10_ = _loc4_.deleteNumenBagBloodFete(_loc8_,_loc9_);
            param3.MoveTextField(_loc10_.Price,_loc10_.PositionIndex);
            _loc5_++;
         }
      }
      
      public function AddBloodFete(param1:ByteArray, param2:Object, param3:TProcessorWindowBloodFeteMainPanel) : Boolean
      {
         var _loc4_:THero = null;
         var _loc5_:TBloodFeteData = null;
         var _loc6_:TBloodFeteSingle = null;
         var _loc7_:TBloodFeteSingle = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:int = 0;
         _loc5_ = param2 as TBloodFeteData;
         _loc8_ = param1.readUnsignedInt();
         _loc9_ = param1.readUnsignedInt();
         _loc10_ = param1.readUnsignedInt();
         _loc11_ = param1.readUnsignedInt();
         _loc12_ = param1.readUnsignedInt();
         _loc13_ = param1.readUnsignedInt();
         _loc14_ = param1.readUnsignedInt();
         _loc15_ = param1.readUnsignedInt();
         _loc16_ = param1.readUnsignedInt();
         if(_loc9_ == 0)
         {
            if(_loc8_ == 7)
            {
               _loc6_ = new TBloodFeteSingle();
               _loc6_.Identifier = _loc11_;
               _loc6_.IdentifierUInt64.High = _loc15_;
               _loc6_.IdentifierUInt64.Low = _loc16_;
               _loc5_.addNumenBagBloodFete(_loc6_);
               _loc5_.NewName = _loc6_.Name;
               return true;
            }
            if(_loc8_ == 6)
            {
               _loc6_ = new TBloodFeteSingle();
               _loc6_.Identifier = _loc11_;
               _loc6_.IdentifierUInt64.High = _loc15_;
               _loc6_.IdentifierUInt64.Low = _loc16_;
               _loc5_.ReflaeshProperty(_loc6_);
               ++_loc5_.DebrisNum;
            }
            else
            {
               _loc17_ = _loc5_.GetIndexByRealBloodFete(_loc15_,_loc16_);
               if(_loc17_ < 0)
               {
                  _loc6_ = new TBloodFeteSingle();
                  _loc6_.Identifier = _loc11_;
                  _loc6_.IdentifierUInt64.High = _loc15_;
                  _loc6_.IdentifierUInt64.Low = _loc16_;
                  _loc5_.addRealBagBloodFete(_loc6_);
               }
               else
               {
                  _loc6_ = _loc5_.GetBloodFeteById64Real(_loc15_,_loc16_);
                  _loc6_.Identifier = _loc11_;
                  _loc5_.ReflaeshProperty(_loc6_);
               }
            }
         }
         else
         {
            _loc4_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc9_);
            _loc6_ = _loc4_.GetBloodFeteById64(_loc15_,_loc16_);
            if(_loc6_)
            {
               _loc6_.Identifier = _loc11_;
               _loc5_.ReflaeshProperty(_loc6_);
            }
            else
            {
               _loc6_ = new TBloodFeteSingle();
               _loc6_.Identifier = _loc11_;
               _loc6_.IdentifierUInt64.High = _loc15_;
               _loc6_.IdentifierUInt64.Low = _loc16_;
               _loc4_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc9_);
               _loc4_.AddBloodFete(_loc6_);
            }
         }
         _loc6_.PositionIndex = _loc10_;
         _loc6_.Identifier = _loc11_;
         _loc6_.IdentifierUInt64.High = _loc15_;
         _loc6_.IdentifierUInt64.Low = _loc16_;
         _loc6_.Exp = _loc12_;
         _loc6_.Level = _loc13_;
         _loc6_.Quality = _loc14_;
         if(_loc8_ == 0 || _loc8_ == 6)
         {
            _loc7_ = _loc5_.deleteNumenBagBloodFete(_loc15_,_loc16_);
            if(_loc7_)
            {
               _loc6_.ThisIsAccident = _loc7_.PositionIndex;
               param3.MoveEffect(_loc6_);
            }
         }
         return false;
      }
      
      public function DeleteBloodFete(param1:ByteArray, param2:Object) : void
      {
         var _loc3_:THero = null;
         var _loc4_:TBloodFeteData = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc4_ = param2 as TBloodFeteData;
         _loc5_ = param1.readUnsignedInt();
         _loc6_ = param1.readUnsignedInt();
         _loc7_ = param1.readUnsignedInt();
         if(_loc5_ == 0)
         {
            _loc4_.deleteRealBagBloodFete(_loc6_,_loc7_);
         }
         else
         {
            _loc3_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc5_);
            _loc3_.DeleteBloodFete(_loc6_,_loc7_);
         }
      }
      
      public function LightenBooldFete(param1:ByteArray, param2:Object) : void
      {
         var _loc3_:TBloodFeteData = null;
         var _loc4_:TBloodFeteSingle = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc3_ = param2 as TBloodFeteData;
         _loc5_ = param1.readUnsignedInt();
         _loc6_ = param1.readUnsignedInt();
         if(_loc5_ == 6)
         {
            _loc5_ = 4;
         }
         if(_loc5_ == 0)
         {
            _loc3_.FiveState[_loc5_] = 0;
         }
         else
         {
            _loc3_.FiveState[_loc5_] = 1;
         }
         if(_loc6_ >= _loc3_.FiveState.length)
         {
            _loc3_.NewIndex = 0;
         }
         else
         {
            _loc3_.NewIndex = _loc6_;
            _loc3_.FiveState[_loc6_] = 0;
         }
         _loc4_ = new TBloodFeteSingle();
         _loc3_.CallBloodFeteCountFree = param1.readUnsignedInt();
         _loc3_.CallBtnCountFree = param1.readUnsignedInt();
         _loc4_.Identifier = param1.readUnsignedInt();
         if(_loc4_.Identifier == 0)
         {
            return;
         }
         _loc4_.IdentifierUInt64.High = param1.readUnsignedInt();
         _loc4_.IdentifierUInt64.Low = param1.readUnsignedInt();
         _loc3_.addNumenBagBloodFete(_loc4_);
         _loc3_.NewName = _loc4_.Name;
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc6_:THero = null;
         var _loc7_:uint = 0;
         var _loc8_:TBloodFeteData = null;
         var _loc9_:TBloodFeteSingle = null;
         var _loc5_:int = 0;
         _loc8_ = param2 as TBloodFeteData;
         _loc8_.CallBloodFeteCountFree = param1.readUnsignedInt();
         _loc8_.CallBtnCountFree = param1.readUnsignedInt();
         _loc8_.DebrisId = param1.readUnsignedInt();
         _loc8_.DebrisNum = param1.readUnsignedInt();
         _loc8_.BagFieldLocked = param1.readUnsignedInt();
         _loc8_.Debris64int.High = param1.readUnsignedInt();
         _loc8_.Debris64int.Low = param1.readUnsignedInt();
         _loc4_ = uint(param1.readShort());
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc8_.FiveState[param1.readUnsignedInt()] = param1.readUnsignedInt();
            _loc5_++;
         }
         _loc4_ = uint(param1.readShort());
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc9_ = new TBloodFeteSingle();
            _loc9_.Identifier = param1.readUnsignedInt();
            _loc9_.IdentifierUInt64.High = param1.readUnsignedInt();
            _loc9_.IdentifierUInt64.Low = param1.readUnsignedInt();
            _loc8_.addNumenBagBloodFete(_loc9_);
            _loc5_++;
         }
         _loc4_ = uint(param1.readShort());
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc9_ = new TBloodFeteSingle();
            _loc9_.PositionIndex = param1.readUnsignedInt();
            _loc9_.Identifier = param1.readUnsignedInt();
            _loc9_.Exp = param1.readUnsignedInt();
            _loc9_.Level = param1.readUnsignedInt();
            _loc9_.Quality = param1.readUnsignedInt();
            _loc9_.IdentifierUInt64.High = param1.readUnsignedInt();
            _loc9_.IdentifierUInt64.Low = param1.readUnsignedInt();
            _loc8_.addRealBagBloodFete(_loc9_);
            _loc5_++;
         }
         _loc4_ = uint(param1.readShort());
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = param1.readUnsignedInt();
            _loc6_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc7_);
            _loc9_ = new TBloodFeteSingle();
            _loc9_.PositionIndex = param1.readUnsignedInt();
            _loc9_.Identifier = param1.readUnsignedInt();
            _loc9_.Exp = param1.readUnsignedInt();
            _loc9_.Level = param1.readUnsignedInt();
            _loc9_.Quality = param1.readUnsignedInt();
            _loc9_.IdentifierUInt64.High = param1.readUnsignedInt();
            _loc9_.IdentifierUInt64.Low = param1.readUnsignedInt();
            _loc6_.AddBloodFete(_loc9_);
            _loc5_++;
         }
      }
      
      public function UnstreamizationPerformOthers(param1:ByteArray, param2:THeros) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:THero = null;
         var _loc7_:TBloodFeteSingle = null;
         _loc3_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < param2.Count)
         {
            param2.GetHeroByIndex(_loc4_).BloodFeteMounted.length = 0;
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1.readUnsignedInt();
            _loc6_ = param2.GetHeroByIdentifier(_loc5_);
            _loc7_ = new TBloodFeteSingle();
            _loc7_.PositionIndex = param1.readUnsignedInt();
            _loc7_.Identifier = param1.readUnsignedInt();
            _loc7_.Exp = param1.readUnsignedInt();
            _loc7_.Level = param1.readUnsignedInt();
            _loc7_.Quality = param1.readUnsignedInt();
            _loc7_.IdentifierUInt64.High = param1.readUnsignedInt();
            _loc7_.IdentifierUInt64.Low = param1.readUnsignedInt();
            _loc6_.AddBloodFete(_loc7_);
            _loc4_++;
         }
      }
   }
}

