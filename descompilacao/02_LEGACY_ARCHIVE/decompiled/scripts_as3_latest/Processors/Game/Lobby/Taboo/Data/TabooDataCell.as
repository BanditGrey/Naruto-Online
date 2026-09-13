package Processors.Game.Lobby.Taboo.Data
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TTabooAddition;
   import Logics.DatebaseVO.VO.TTabooConfig;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TabooDataCell
   {
      
      protected var FConfigureConfig:TTabooConfig = null;
      
      protected var FConfigureAddition:TTabooAddition = null;
      
      protected var FCount:int = 1;
      
      protected var FSkillCount:int = 1;
      
      protected var FOriginalNum:int;
      
      public function TabooDataCell()
      {
         super();
      }
      
      public function SetValueById(param1:int) : void
      {
         var _loc2_:TTabooConfig = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TabooConfig,param1) as TTabooConfig;
         if(_loc2_)
         {
            this.FConfigureConfig = _loc2_;
         }
         var _loc3_:TTabooAddition = null;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TabooAddition,param1) as TTabooAddition;
         if(_loc3_)
         {
            this.FConfigureAddition = _loc3_;
         }
      }
      
      public function get ConfigureConfig() : TTabooConfig
      {
         return this.FConfigureConfig;
      }
      
      public function get ConfigureAddition() : TTabooAddition
      {
         return this.FConfigureAddition;
      }
      
      public function set Count(param1:int) : void
      {
         this.FCount = param1;
      }
      
      public function get Count() : int
      {
         return this.FCount;
      }
      
      public function set OriginalNum(param1:int) : void
      {
         this.FOriginalNum = param1;
      }
      
      public function get OriginalNum() : int
      {
         return this.FOriginalNum;
      }
      
      public function get SkillCount() : int
      {
         return this.FSkillCount;
      }
      
      public function set SkillCount(param1:int) : void
      {
         this.FSkillCount = param1;
      }
   }
}

