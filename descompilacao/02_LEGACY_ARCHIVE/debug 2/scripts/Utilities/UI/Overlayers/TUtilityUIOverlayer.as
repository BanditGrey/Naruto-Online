package Utilities.UI.Overlayers
{
   import Foundation.Utilities.TUtilityReflection;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_COMMON;
   
   public class TUtilityUIOverlayer
   {
      
      protected static const SEQUENCEID_Default:uint = CONST_COMMON.SEQUENCEID_Default;
      
      public function TUtilityUIOverlayer()
      {
         super();
      }
      
      protected static function ResourcesDispatchSubstrate(param1:TOverlayer) : void
      {
         param1.AnimationSubstrate = TUtilityReflection.CreateBitmapDataByDisplayObject(CONST_COMMON.RESOURCE_ClassName_MC_HitTexture);
         param1.DividingLine = TUtilityReflection.CreateBitmapDataByDisplayObject(CONST_COMMON.RESOURCE_ClassName_MC_DividingLine);
         param1.ResourcesUpdate();
      }
      
      public static function ResourcesDispatch(param1:TOverlayer) : void
      {
         ResourcesDispatchSubstrate(param1);
      }
   }
}

