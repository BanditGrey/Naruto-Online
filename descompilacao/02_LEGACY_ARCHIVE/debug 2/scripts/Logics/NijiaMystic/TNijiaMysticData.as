package Logics.NijiaMystic
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TNijiaMysticData
   {
      
      public static const MAX_Material_Count:uint = 9;
      
      public static const MAX_Mystic_Count:uint = 8;
      
      public static const MAX_Refresh_Count:uint = 8;
      
      protected var FMysticPointVect:Vector.<uint>;
      
      protected var FMysticIdVect:Vector.<uint>;
      
      protected var FRefreshMaterialVect:Vector.<uint>;
      
      protected var FBoomVect:Vector.<uint>;
      
      protected var FCurSelectMystic:uint;
      
      protected var FFlushTimes:uint;
      
      protected var FCollectTimes:uint;
      
      public function TNijiaMysticData()
      {
         super();
         this.FMysticPointVect = new Vector.<uint>(MAX_Material_Count);
         this.FMysticIdVect = new Vector.<uint>(MAX_Mystic_Count);
         this.FRefreshMaterialVect = new Vector.<uint>(MAX_Refresh_Count);
         this.FBoomVect = new Vector.<uint>();
      }
      
      public function get MysticPointVect() : Vector.<uint>
      {
         return this.FMysticPointVect;
      }
      
      public function set MysticPointVect(param1:Vector.<uint>) : void
      {
         this.FMysticPointVect = param1;
      }
      
      public function get MysticIdVect() : Vector.<uint>
      {
         return this.FMysticIdVect;
      }
      
      public function set MysticIdVect(param1:Vector.<uint>) : void
      {
         this.FMysticIdVect = param1;
      }
      
      public function get RefreshMaterialVect() : Vector.<uint>
      {
         return this.FRefreshMaterialVect;
      }
      
      public function set RefreshMaterialVect(param1:Vector.<uint>) : void
      {
         this.FRefreshMaterialVect = param1;
      }
      
      public function get BoomVect() : Vector.<uint>
      {
         return this.FBoomVect;
      }
      
      public function set BoomVect(param1:Vector.<uint>) : void
      {
         this.FBoomVect = param1;
      }
      
      public function get CurSelectMystic() : uint
      {
         return this.FCurSelectMystic;
      }
      
      public function set CurSelectMystic(param1:uint) : void
      {
         this.FCurSelectMystic = param1;
      }
      
      public function get FlushTimes() : uint
      {
         return this.FFlushTimes;
      }
      
      public function set FlushTimes(param1:uint) : void
      {
         this.FFlushTimes = param1;
      }
      
      public function get CollectTimes() : uint
      {
         return this.FCollectTimes;
      }
      
      public function set CollectTimes(param1:uint) : void
      {
         this.FCollectTimes = param1;
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<uint> = null;
         _loc3_ = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.MYSTIC_ResetCost) as TConfigValue).Value as Vector.<uint>;
         _loc1_ = 0;
         while(_loc1_ < _loc3_.length)
         {
            if(_loc3_[_loc1_] == 0)
            {
               _loc2_++;
            }
            _loc1_++;
         }
         if(this.FFlushTimes < _loc2_)
         {
            return true;
         }
         return false;
      }
   }
}

