package Foundation.Resources.Streamization.Bin
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Spaces.*;
   import Foundation.Resources.Streamization.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.TDatebaseVO;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.*;
   
   use namespace ResourcesSpace;
   
   public class TResourceUnstreamizerBin extends TResourceUnstreamizer
   {
      
      public static const RESOURCESID_DATEBASE:Vector.<uint> = CONST_DATEBASEVO.RESOURCESID_DATEBASE;
      
      public static const CLASSTYPE_NAMES:Vector.<Class> = CONST_DATEBASEVO.CLASSTYPE_NAMES;
      
      public function TResourceUnstreamizerBin()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_Traversal(param1,param2,param3);
      }
      
      protected function UnstreamizationPerform_Traversal(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TBins = null;
         var _loc9_:XML = null;
         var _loc10_:uint = 0;
         var _loc11_:Class = null;
         var _loc12_:TDatebaseVO = null;
         _loc8_ = param2 as TBins;
         _loc10_ = _loc8_.Identifier;
         param1.uncompress();
         if(_loc10_ == CONST_DATEBASEVO.RESOURCEID_Base)
         {
            _loc5_ = 0;
            while(_loc5_ < CLASSTYPE_NAMES.length)
            {
               _loc8_ = new TBins(RESOURCESID_DATEBASE[_loc5_]);
               _loc11_ = CLASSTYPE_NAMES[_loc5_];
               _loc6_ = int(param1.readUnsignedInt());
               _loc4_ = 0;
               while(_loc4_ < _loc6_)
               {
                  _loc12_ = new _loc11_();
                  _loc12_.Coerce(param1.readUnsignedInt());
                  _loc12_.ReadDataByStream(param1);
                  _loc8_.DatebaseAppend(_loc12_.Identifier,_loc12_);
                  _loc4_++;
               }
               ResourceNotifyUnstreamized(_loc8_);
               _loc5_++;
            }
         }
         else if(_loc10_ == CONST_DATEBASEVO.RESOURCEID_Maskword)
         {
            _loc11_ = CONST_DATEBASEVO.CLASSTYPE_Maskword;
            _loc6_ = int(param1.readUnsignedInt());
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc12_ = new _loc11_();
               _loc12_.Coerce(param1.readUnsignedInt());
               _loc12_.ReadDataByStream(param1);
               _loc8_.DatebaseAppend(_loc12_.Identifier,_loc12_);
               _loc4_++;
            }
            ResourceNotifyUnstreamized(_loc8_);
         }
      }
   }
}

