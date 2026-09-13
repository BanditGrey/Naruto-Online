package Logics.Streamization.Title
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Timing.STimingCore;
   import Logics.DatebaseVO.VO.TTitleConfig;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerTitle extends TUnstreamizer
   {
      
      public function TUnstreamizerTitle()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TTitles = null;
         var _loc7_:TTitle = null;
         var _loc8_:TTitleConfig = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc6_ = param2 as TTitles;
         _loc6_.Clear();
         _loc5_ = param1.readUnsignedShort();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc9_ = param1.readUnsignedInt();
            _loc10_ = param1.readUnsignedInt();
            _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TitleConfig,_loc9_) as TTitleConfig;
            if(_loc8_.TitleType == 1)
            {
               _loc7_ = new TTitle();
               _loc7_.Identifier = _loc9_;
               _loc7_.TitleName = _loc8_.Title;
               _loc7_.TitleSource = _loc8_.TitleDesc;
               _loc7_.VipLevel = _loc8_.VipLv;
               _loc7_.Level = _loc8_.UsrLv;
               _loc7_.ImageId = _loc8_.ImageId;
               _loc7_.AddValues = _loc8_.AddValues;
               _loc7_.EndTime = _loc10_;
               _loc7_.Type = _loc8_.Type;
               _loc7_.LastTime = _loc8_.LastTime;
               _loc6_.Add(_loc7_);
            }
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerformByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TBins = null;
         var _loc5_:TTitleConfig = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:TTitle = null;
         var _loc9_:TTitles = null;
         _loc9_ = param2 as TTitles;
         _loc4_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_TitleConfig) as TBins;
         _loc9_.Clear();
         _loc7_ = uint(_loc4_.Count);
         _loc6_ = 0;
         for(; _loc6_ < _loc7_; _loc6_++)
         {
            _loc5_ = _loc4_.GetDatebaseByIndex(_loc6_) as TTitleConfig;
            if(_loc5_.Identifier != 0)
            {
               if(_loc5_.TitleType == 1)
               {
                  if(_loc5_.Type == 3)
                  {
                     if(this.GetBoolean(_loc5_.LastTime) && _loc5_.IsHide == 0)
                     {
                        continue;
                     }
                  }
                  _loc8_ = new TTitle();
                  _loc8_.Identifier = _loc5_.Identifier;
                  _loc8_.TitleName = _loc5_.Title;
                  _loc8_.TitleSource = _loc5_.TitleDesc;
                  _loc8_.VipLevel = _loc5_.VipLv;
                  _loc8_.Level = _loc5_.UsrLv;
                  _loc8_.ImageId = _loc5_.ImageId;
                  _loc8_.AddValues = _loc5_.AddValues;
                  _loc8_.EndTime = 0;
                  _loc8_.Type = _loc5_.Type;
                  _loc8_.LastTime = _loc5_.LastTime;
                  _loc9_.Add(_loc8_);
               }
            }
         }
      }
      
      protected function GetBoolean(param1:Vector.<uint>) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:Date = null;
         _loc3_ = new Date(STimingCore.GetClientShowTime(STimingCore.GetServerTick()) * 1000);
         if(_loc3_.fullYear > param1[0])
         {
            _loc2_ = true;
         }
         else if(_loc3_.fullYear < param1[0])
         {
            _loc2_ = false;
         }
         else if(_loc3_.month + 1 > param1[1])
         {
            _loc2_ = true;
         }
         else if(_loc3_.month + 1 < param1[1])
         {
            _loc2_ = false;
         }
         else if(_loc3_.date >= param1[2])
         {
            _loc2_ = true;
         }
         else
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
      
      public function UnstreamizeTitleByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformByDatabase(param1,param2,param3);
      }
   }
}

