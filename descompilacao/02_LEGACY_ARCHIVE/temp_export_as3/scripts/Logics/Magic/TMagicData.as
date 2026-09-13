package Logics.Magic
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TMagicData
   {
      
      protected var FIsCanDown:Boolean;
      
      protected var FMagics:TMagics;
      
      protected var FSilverPracticeCount:uint;
      
      protected var FStageID:uint;
      
      protected var FMagicLevels:TMagicLevels;
      
      public function TMagicData()
      {
         super();
         this.FIsCanDown = false;
         this.FMagics = new TMagics();
         this.FSilverPracticeCount = 0;
         this.FStageID = 0;
         this.FMagicLevels = new TMagicLevels();
      }
      
      public function get Magics() : TMagics
      {
         return this.FMagics;
      }
      
      public function set Magics(param1:TMagics) : void
      {
         this.FMagics = param1;
      }
      
      public function get SilverPracticeCount() : uint
      {
         return this.FSilverPracticeCount;
      }
      
      public function set SilverPracticeCount(param1:uint) : void
      {
         this.FSilverPracticeCount = param1;
      }
      
      public function get StageID() : uint
      {
         return this.FStageID;
      }
      
      public function set StageID(param1:uint) : void
      {
         this.FStageID = param1;
      }
      
      public function get MagicLevels() : TMagicLevels
      {
         return this.FMagicLevels;
      }
      
      public function set MagicLevels(param1:TMagicLevels) : void
      {
         this.FMagicLevels = param1;
      }
      
      public function get IsCanDown() : Boolean
      {
         return this.FIsCanDown;
      }
      
      public function set IsCanDown(param1:Boolean) : void
      {
         this.FIsCanDown = param1;
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:uint = 0;
         _loc1_ = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Mew_Silver_number) as TConfigValue).Value as uint;
         if(this.FSilverPracticeCount < _loc1_)
         {
            return true;
         }
         return false;
      }
   }
}

