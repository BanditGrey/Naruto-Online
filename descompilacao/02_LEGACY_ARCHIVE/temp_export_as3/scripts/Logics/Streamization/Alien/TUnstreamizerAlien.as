package Logics.Streamization.Alien
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Alien.TAlien;
   import Logics.Alien.TAlienData;
   import Logics.DatebaseVO.VO.TPlaneInvasionConfig;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerAlien extends TUnstreamizer
   {
      
      public function TUnstreamizerAlien()
      {
         super();
      }
      
      protected function UnstreamizationPerformByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TBins = null;
         var _loc7_:TAlienData = null;
         var _loc8_:TPlaneInvasionConfig = null;
         var _loc9_:TAlien = null;
         _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Alien) as TBins;
         _loc7_ = param2 as TAlienData;
         _loc5_ = uint(_loc6_.Count);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc9_ = new TAlien();
            _loc8_ = _loc6_.GetDatebaseByIndex(_loc4_) as TPlaneInvasionConfig;
            _loc9_.Id = _loc8_.Identifier;
            _loc9_.Level = _loc8_.Level;
            _loc9_.Heros = _loc8_.HerosArr;
            _loc9_.NamePart = _loc8_.NamePart;
            _loc9_.NameTotal = _loc8_.NameTotal;
            _loc7_.Add(_loc9_);
            _loc4_++;
         }
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TAlienData = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TAlien = null;
         var _loc9_:int = 0;
         _loc4_ = param2 as TAlienData;
         _loc5_ = param1.readShort();
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = int(param1.readUnsignedInt());
            _loc9_ = int(param1.readUnsignedInt());
            _loc8_ = _loc4_.GetTAlienByIdentifier(_loc7_);
            _loc8_.Status = _loc9_ == 1 ? _loc9_ : 2;
            _loc8_.IsBattled = true;
            _loc6_++;
         }
         this.UnstreamizationPerformByStatus(null,_loc4_,null);
         _loc5_ = param1.readShort();
      }
      
      protected function UnstreamizationPerformByStatus(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TAlien = null;
         var _loc7_:int = 0;
         var _loc8_:TAlienData = null;
         _loc8_ = param2 as TAlienData;
         _loc4_ = int(_loc8_.Aliens.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc8_.Aliens[_loc5_];
            if(!_loc6_.IsBattled && _loc7_ != _loc6_.Level)
            {
               _loc6_.Status = 2;
               _loc7_ = _loc6_.Level;
            }
            _loc5_++;
         }
      }
      
      public function UnstreamizationPerformBySaoDang(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TAlien = null;
         var _loc7_:int = 0;
         var _loc8_:Vector.<TAlien> = null;
         var _loc9_:TAlienData = null;
         _loc9_ = param2 as TAlienData;
         _loc7_ = param3 as int;
         _loc8_ = _loc9_.GetTAliensByLevel(_loc7_);
         _loc4_ = int(_loc8_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc8_[_loc5_];
            if(_loc6_.IsBattled && _loc6_.Status == 2)
            {
               _loc6_.Status = 1;
            }
            _loc5_++;
         }
      }
      
      public function UnStreamizationPerformByAllSanDang(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TAlienData = null;
         _loc7_ = param2 as TAlienData;
         _loc4_ = param1.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = int(param1.readUnsignedInt());
            this.UnstreamizationPerformBySaoDang(null,_loc7_,_loc6_);
            _loc5_++;
         }
      }
      
      public function UnstreamizeByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformByDatabase(param1,param2,param3);
      }
   }
}

