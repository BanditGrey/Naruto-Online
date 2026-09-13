package Processors.Game.Lobby.awaken.date
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TAwakenConfig;
   import Logics.DatebaseVO.VO.TAwakenSkillConfig;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class AwakenDateCELL
   {
      
      protected var FAwakenConfigDate:TAwakenConfig = null;
      
      protected var FAwakenSkillDate:TAwakenSkillConfig = null;
      
      protected var FCount:int = 1;
      
      public function AwakenDateCELL()
      {
         super();
      }
      
      public function SetValueById(param1:int) : void
      {
         var _loc2_:TAwakenConfig = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_AwakenConfig,param1) as TAwakenConfig;
         if(_loc2_)
         {
            this.FAwakenConfigDate = _loc2_;
         }
         var _loc3_:TAwakenSkillConfig = null;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_AwakenSkillConfig,param1) as TAwakenSkillConfig;
         if(_loc3_)
         {
            this.FAwakenSkillDate = _loc3_;
         }
      }
      
      public function get AwakenSkillDate() : TAwakenSkillConfig
      {
         return this.FAwakenSkillDate;
      }
      
      public function get AwakenConfigDate() : TAwakenConfig
      {
         return this.FAwakenConfigDate;
      }
      
      public function set Count(param1:int) : void
      {
         this.FCount = param1;
      }
      
      public function get Count() : int
      {
         return this.FCount;
      }
   }
}

