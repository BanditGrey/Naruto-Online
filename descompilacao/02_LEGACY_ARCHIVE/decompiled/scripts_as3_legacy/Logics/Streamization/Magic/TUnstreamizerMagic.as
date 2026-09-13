package Logics.Streamization.Magic
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.DatebaseVO.VO.TMewMagic;
   import Logics.Magic.TMagic;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerMagic extends TUnstreamizer
   {
      
      protected const CAPACITY_Atrributes:uint = 4;
      
      public function TUnstreamizerMagic()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TMagic = null;
         var _loc5_:TMewMagic = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc8_ = param1.readUnsignedInt();
         _loc9_ = param1.readUnsignedInt();
         _loc10_ = param1.readUnsignedInt();
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_MewMagic,_loc8_) as TMewMagic;
         if(_loc5_ != null)
         {
            _loc4_ = param2 as TMagic;
            _loc4_.MagicID = _loc8_;
            _loc4_.Level = _loc5_.Level;
            _loc4_.Type = _loc5_.Type;
            _loc4_.MagicName = _loc5_.Name;
            _loc4_.NeedBlock = _loc5_.NeedBlock;
            _loc4_.NeedExp = _loc5_.NeedExp;
            _loc4_.NeedSilver = _loc5_.NeedSilver;
            _loc4_.SilverExp = _loc5_.SilverExp;
            _loc4_.NeedGold = _loc5_.NeedGold;
            _loc4_.GoldExp = _loc5_.GoldExp;
            _loc4_.NeedItem = _loc5_.NeedItem;
            _loc4_.ItemExp = _loc5_.ItemExp;
            _loc4_.Power = _loc5_.Power;
            _loc4_.Agile = _loc5_.Agile;
            _loc4_.Intelligence = _loc5_.Intelligence;
            _loc4_.Life = _loc5_.Life;
            _loc4_.ExpAll = _loc5_.ExpAll;
            _loc4_.NeedReincarnationLevel = _loc5_.NeedTransLv;
            _loc4_.Nextid = _loc5_.Nextid;
            _loc7_ = this.CAPACITY_Atrributes;
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               _loc4_.Atrributes[_loc6_] = _loc5_.Atrributes[_loc6_];
               _loc6_++;
            }
            _loc4_.CurExp = _loc9_;
            _loc4_.GoldPracticeCount = _loc10_;
         }
      }
      
      protected function UnstreamizationPerformByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TMagic = null;
         var _loc5_:TMewMagic = null;
         var _loc6_:TBins = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc4_ = param2 as TMagic;
         _loc9_ = param3 as uint;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_MewMagic,_loc9_) as TMewMagic;
         if(_loc5_ != null)
         {
            _loc4_.MagicID = _loc9_;
            _loc4_.Level = _loc5_.Level;
            _loc4_.Type = _loc5_.Type;
            _loc4_.MagicName = _loc5_.Name;
            _loc4_.NeedBlock = _loc5_.NeedBlock;
            _loc4_.NeedExp = _loc5_.NeedExp;
            _loc4_.NeedSilver = _loc5_.NeedSilver;
            _loc4_.SilverExp = _loc5_.SilverExp;
            _loc4_.NeedGold = _loc5_.NeedGold;
            _loc4_.GoldExp = _loc5_.GoldExp;
            _loc4_.NeedItem = _loc5_.NeedItem;
            _loc4_.ItemExp = _loc5_.ItemExp;
            _loc4_.Power = _loc5_.Power;
            _loc4_.Agile = _loc5_.Agile;
            _loc4_.Intelligence = _loc5_.Intelligence;
            _loc4_.Life = _loc5_.Life;
            _loc4_.NeedReincarnationLevel = _loc5_.NeedTransLv;
            _loc4_.Nextid = _loc5_.Nextid;
            _loc8_ = this.CAPACITY_Atrributes;
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               _loc4_.Atrributes[_loc7_] = _loc5_.Atrributes[_loc7_];
               _loc7_++;
            }
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
      
      public function UnstreamizeByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformByDatabase(param1,param2,param3);
      }
   }
}

