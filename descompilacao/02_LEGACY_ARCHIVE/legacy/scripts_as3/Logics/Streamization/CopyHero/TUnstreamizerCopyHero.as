package Logics.Streamization.CopyHero
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.CopyHero.TCopyHero;
   import Logics.DatebaseVO.VO.TBaseCopyHero;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerCopyHero extends TUnstreamizer
   {
      
      public function TUnstreamizerCopyHero()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Vector.<TCopyHero> = null;
         var _loc7_:TCopyHero = null;
         var _loc8_:Vector.<TCopyHero> = null;
         var _loc9_:TCopyHero = null;
         var _loc10_:int = 0;
         var _loc11_:TBins = null;
         var _loc12_:TBaseCopyHero = null;
         var _loc13_:uint = 0;
         _loc5_ = int(param1.readUnsignedShort());
         _loc6_ = new Vector.<TCopyHero>(_loc5_);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = new TCopyHero();
            _loc7_.CardID = param1.readUnsignedInt();
            _loc7_.State = param1.readUnsignedByte();
            _loc7_.BRecruit = 1;
            _loc6_[_loc4_] = _loc7_;
            _loc4_++;
         }
         _loc8_ = param2 as Vector.<TCopyHero>;
         _loc11_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_HeroReplacement);
         _loc13_ = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc11_.Count)
         {
            _loc9_ = new TCopyHero();
            _loc12_ = _loc11_.GetDatebaseByIndex(_loc4_) as TBaseCopyHero;
            _loc9_.CardID = _loc12_.Identifier;
            _loc9_.HeroDesc = _loc12_.Desc;
            _loc9_.HeroName = _loc12_.Name;
            _loc9_.IsOpen = _loc12_.IsOpen;
            _loc9_.HeroID = _loc12_.HeroID;
            _loc9_.ModelLv = _loc12_.ModelLv;
            _loc9_.TimeLimit = _loc12_.TimeLimit;
            _loc9_.NewModelHeroID = _loc12_.NewModelHeroId;
            _loc9_.IsDisplay = _loc12_.IsDisplay;
            _loc10_ = 0;
            while(_loc10_ < _loc5_)
            {
               if(_loc9_.CardID == _loc6_[_loc10_].CardID)
               {
                  _loc9_.State = _loc6_[_loc10_].State;
                  _loc9_.BRecruit = _loc6_[_loc10_].BRecruit;
               }
               _loc10_++;
            }
            if(_loc9_.IsDisplay == 0 && _loc9_.BRecruit == 1 || _loc9_.IsDisplay != 0)
            {
               _loc8_[_loc13_] = _loc9_;
               _loc13_++;
            }
            _loc4_++;
         }
         _loc8_.sort(this.SortCopyHeroRecruit);
      }
      
      protected function SortCopyHeroRecruit(param1:TCopyHero, param2:TCopyHero) : Number
      {
         if(param1.BRecruit < param2.BRecruit)
         {
            return 1;
         }
         if(param1.BRecruit > param2.BRecruit)
         {
            return -1;
         }
         if(param1.CardID < param2.CardID)
         {
            return -1;
         }
         if(param1.CardID > param2.CardID)
         {
            return 1;
         }
         return 0;
      }
      
      protected function UnstreamizationPerform_CopyHeroByDatabase(param1:Object) : void
      {
         var _loc2_:Vector.<TCopyHero> = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TBins = null;
         var _loc7_:Vector.<TCopyHero> = null;
         var _loc8_:TCopyHero = null;
         var _loc9_:TBaseCopyHero = null;
         _loc2_ = param1 as Vector.<TCopyHero>;
         _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_HeroReplacement);
         _loc5_ = _loc6_.Count;
         _loc7_ = new Vector.<TCopyHero>(_loc5_);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc8_ = new TCopyHero();
            _loc9_ = _loc6_.GetDatebaseByIndex(_loc3_) as TBaseCopyHero;
            _loc8_.HeroDesc = _loc9_.Desc;
            _loc8_.HeroName = _loc9_.Name;
            _loc8_.IsOpen = _loc9_.IsOpen;
            _loc8_.HeroID = _loc9_.HeroID;
            _loc8_.ModelLv = _loc9_.ModelLv;
            _loc8_.TimeLimit = _loc9_.TimeLimit;
            _loc8_.NewModelHeroID = _loc9_.NewModelHeroId;
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               if(_loc2_[_loc4_].HeroID == _loc8_.HeroID)
               {
                  _loc8_.BRecruit = _loc2_[_loc4_].BRecruit;
                  _loc8_.State = _loc2_[_loc4_].State;
               }
               _loc4_++;
            }
            _loc7_[_loc3_] = _loc8_;
            _loc3_++;
         }
         _loc2_ = _loc7_;
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

