package Logics.Streamization.NarutoHelper
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.DatebaseVO.VO.TNinjiaClassroom;
   import Logics.DatebaseVO.VO.TNinjiaQuestions;
   import Logics.DatebaseVO.VO.TNinjiaRecommend;
   import Logics.NarutoHelper.TLevelRecommendNinja;
   import Logics.NarutoHelper.TLevelRecommendNinjas;
   import Logics.NarutoHelper.TNinjaLesson;
   import Logics.NarutoHelper.TNinjaLessons;
   import Logics.NarutoHelper.TQuestion;
   import Logics.NarutoHelper.TQuestions;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerNarutoHelper extends TUnstreamizer
   {
      
      public function TUnstreamizerNarutoHelper()
      {
         super();
      }
      
      protected function UnstreamizationPerformLevelRecommendNinjas(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:TBins = null;
         var _loc9_:TNinjiaRecommend = null;
         var _loc10_:TLevelRecommendNinjas = null;
         var _loc11_:TLevelRecommendNinja = null;
         var _loc12_:Boolean = false;
         _loc10_ = param2 as TLevelRecommendNinjas;
         _loc8_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NinjiaRecommend) as TBins;
         _loc5_ = uint(_loc8_.Count);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc9_ = _loc8_.GetDatebaseByIndex(_loc4_) as TNinjiaRecommend;
            _loc12_ = this.CheckIsHasLevelNinja(_loc10_,_loc9_);
            if(!_loc12_)
            {
               _loc11_ = new TLevelRecommendNinja();
               _loc11_.LevelRecommend = _loc9_.Level;
               _loc10_.Add(_loc11_);
            }
            _loc7_ = uint(_loc10_.Count);
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               _loc11_ = _loc10_.GetLevelRecommendNinjaByIndex(_loc6_);
               if(_loc11_.LevelRecommend == _loc9_.Level)
               {
                  _loc11_.HeroInfos.Add(_loc9_);
               }
               _loc6_++;
            }
            _loc4_++;
         }
      }
      
      protected function CheckIsHasLevelNinja(param1:TLevelRecommendNinjas, param2:TNinjiaRecommend) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TLevelRecommendNinja = null;
         _loc4_ = uint(param1.Count);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param1.GetLevelRecommendNinjaByIndex(_loc3_);
            if(_loc5_.LevelRecommend == param2.Level)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function UnstreamizationPerformClassroom(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TNinjaLesson = null;
         var _loc5_:TNinjaLessons = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:TBins = null;
         var _loc9_:TNinjiaClassroom = null;
         _loc5_ = param2 as TNinjaLessons;
         _loc8_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NinjiaClassroom) as TBins;
         _loc7_ = uint(_loc8_.Count);
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc4_ = new TNinjaLesson();
            _loc9_ = _loc8_.GetDatebaseByIndex(_loc6_) as TNinjiaClassroom;
            _loc4_.Name = _loc9_.Name;
            _loc4_.Level = _loc9_.Level;
            _loc4_.Desc = _loc9_.Desc;
            _loc5_.Add(_loc4_);
            _loc6_++;
         }
      }
      
      protected function UnstreamizationPerformQuestion(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TQuestions = null;
         var _loc5_:TQuestion = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:TBins = null;
         var _loc9_:TNinjiaQuestions = null;
         var _loc10_:int = 0;
         var _loc11_:uint = 0;
         _loc4_ = param2 as TQuestions;
         _loc8_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NinjiaQuestions) as TBins;
         _loc7_ = uint(_loc8_.Count);
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc9_ = _loc8_.GetDatebaseByIndex(_loc6_) as TNinjiaQuestions;
            _loc5_ = new TQuestion();
            _loc5_.Level = _loc9_.Level;
            _loc5_.Question = _loc9_.Questions;
            _loc11_ = _loc9_.Answers.length;
            _loc10_ = 0;
            while(_loc10_ < _loc11_)
            {
               _loc5_.Answers[_loc10_] = _loc9_.Answers[_loc10_];
               _loc5_.Feedbacks[_loc10_] = _loc9_.Feedbacks[_loc10_];
               _loc10_++;
            }
            _loc4_.Add(_loc5_);
            _loc6_++;
         }
      }
      
      public function UnstreamizeLevelRecommendNinjas(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformLevelRecommendNinjas(param1,param2,param3);
      }
      
      public function UnstreamizeClassroom(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformClassroom(param1,param2,param3);
      }
      
      public function UnstreamizeQuestion(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformQuestion(param1,param2,param3);
      }
   }
}

