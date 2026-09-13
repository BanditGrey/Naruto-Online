package Logics.TreasureMap
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TTreasureMapData
   {
      
      protected var FFightHeroList:TTreasureMapHeros;
      
      protected var FReportList:TTreasureMapReports;
      
      protected var FCurEnterTimes:int;
      
      protected var FCurRefreshTimes:int;
      
      protected var FCurQuality:uint;
      
      protected var FTreasureStatus:Boolean;
      
      protected var FRobberyTimes:int;
      
      public function TTreasureMapData()
      {
         super();
         this.FFightHeroList = new TTreasureMapHeros();
         this.FReportList = new TTreasureMapReports();
      }
      
      public function get FightHeroList() : TTreasureMapHeros
      {
         return this.FFightHeroList;
      }
      
      public function set FightHeroList(param1:TTreasureMapHeros) : void
      {
         this.FFightHeroList = param1;
      }
      
      public function get ReportList() : TTreasureMapReports
      {
         return this.FReportList;
      }
      
      public function set ReportList(param1:TTreasureMapReports) : void
      {
         this.FReportList = param1;
      }
      
      public function get CurEnterTimes() : int
      {
         return this.FCurEnterTimes;
      }
      
      public function set CurEnterTimes(param1:int) : void
      {
         this.FCurEnterTimes = param1;
      }
      
      public function get CurRefreshTimes() : int
      {
         return this.FCurRefreshTimes;
      }
      
      public function set CurRefreshTimes(param1:int) : void
      {
         this.FCurRefreshTimes = param1;
      }
      
      public function get CurQuality() : int
      {
         return this.FCurQuality;
      }
      
      public function set CurQuality(param1:int) : void
      {
         this.FCurQuality = param1;
      }
      
      public function get TreasureStatus() : Boolean
      {
         return this.FTreasureStatus;
      }
      
      public function set TreasureStatus(param1:Boolean) : void
      {
         this.FTreasureStatus = param1;
      }
      
      public function get RobberyTimes() : uint
      {
         return this.FRobberyTimes;
      }
      
      public function set RobberyTimes(param1:uint) : void
      {
         this.FRobberyTimes = param1;
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TreasureMap_Mast_FreeQuency) as TConfigValue).Value as int;
         if(!this.FTreasureStatus && this.FCurEnterTimes < _loc1_)
         {
            return true;
         }
         return false;
      }
   }
}

