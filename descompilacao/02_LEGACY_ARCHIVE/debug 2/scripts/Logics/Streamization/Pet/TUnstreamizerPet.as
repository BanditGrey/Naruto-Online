package Logics.Streamization.Pet
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.DatebaseVO.VO.TBasePet;
   import Logics.DatebaseVO.VO.TSoulArray;
   import Logics.Pet.TPet;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerPet extends TUnstreamizer
   {
      
      public function TUnstreamizerPet()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TPet = null;
         var _loc5_:uint = 0;
         _loc4_ = param2 as TPet;
         _loc4_.SoulID = param1.readUnsignedInt();
         _loc4_.CurrentExp = param1.readUnsignedInt();
         _loc4_.CurrentSoulExp = param1.readUnsignedInt();
         _loc4_.Power = param1.readUnsignedInt();
         _loc4_.Agile = param1.readUnsignedInt();
         _loc4_.Intelligence = param1.readUnsignedInt();
         _loc4_.Life = param1.readUnsignedInt();
         this.UnstreamizationPerform_PetByDatabase(_loc4_);
         this.UnstreamizationPerform_UnlockPets(param1,_loc4_,param3);
         this.UnstreamizationPerform_SoulFormation(param1,_loc4_,param3);
      }
      
      protected function UnstreamizationPerform_PetByDatabase(param1:Object) : void
      {
         var _loc2_:TPet = null;
         var _loc3_:TBasePet = null;
         _loc2_ = param1 as TPet;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BasePet,_loc2_.PetID) as TBasePet;
         _loc2_.NeedExp = _loc3_.NeedExp;
         _loc2_.ReincarnationLevel = _loc3_.NeedTransLv;
      }
      
      protected function UnstreamizationPerform_SoulFormation(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TPet = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TSoulArray = null;
         _loc4_ = param2 as TPet;
         _loc4_.SoulFormations.length = 0;
         _loc6_ = param1.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = int(param1.readUnsignedInt());
            _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SoulArray,_loc7_) as TSoulArray;
            _loc8_.Status = param1.readInt();
            _loc4_.SoulFormations[_loc5_] = _loc8_;
            _loc5_++;
         }
      }
      
      protected function UnstreamizationPerform_UnlockPets(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TPet = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc4_ = param2 as TPet;
         param1.readUnsignedInt();
         param1.readUnsignedInt();
         _loc6_ = param1.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = int(param1.readUnsignedInt());
            _loc8_ = int(param1.readUnsignedInt());
            _loc4_.UnlockPetIds[_loc5_] = _loc7_;
            _loc5_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

