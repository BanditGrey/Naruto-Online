package Logics.Streamization.Pet
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Pet.TAddSoul;
   import Logics.Pet.TPet;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerAddSoul extends TUnstreamizer
   {
      
      public function TUnstreamizerAddSoul()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:TInventory = null;
         var _loc11_:TInventories = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:Vector.<uint> = null;
         var _loc16_:Vector.<uint> = null;
         var _loc17_:TBins = null;
         var _loc18_:TBaseBox = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:TPet = null;
         var _loc22_:TAddSoul = null;
         _loc21_ = param2 as TPet;
         _loc22_ = _loc21_.AddSoul;
         _loc22_.StoneCount = param1.readUnsignedInt();
         _loc22_.DayItemLimit = param1.readUnsignedInt();
         _loc21_.AddSoulFormation.CurExp = param1.readUnsignedInt();
         _loc22_.GradeInfo.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc18_ = new TBaseBox();
            _loc18_.LimitCount = param1.readUnsignedInt();
            _loc18_.Level = param1.readUnsignedInt();
            _loc18_.Price = param1.readUnsignedInt();
            _loc22_.GradeInfo[_loc4_] = _loc18_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

