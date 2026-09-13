package Utilities.UI.Marquees
{
   import Components.HyperStrings.TUIHyperStringMarquee;
   import Foundation.Utilities.TUtilityReflection;
   import Resources.Constants.CONST_COMMON;
   
   public class TUtilityUIMarquee
   {
      
      protected static const SEQUENCEID_Default:uint = CONST_COMMON.SEQUENCEID_Default;
      
      public function TUtilityUIMarquee()
      {
         super();
      }
      
      protected static function ResourcesDispatchSubstrate(param1:TUIHyperStringMarquee) : void
      {
         param1.AnimationSubstrate = TUtilityReflection.CreateBitmapDataByDisplayObject(CONST_COMMON.RESOURCE_ClassName_MC_HitTexture);
         param1.ResourcesUpdate();
      }
      
      public static function ResourcesDispatch(param1:TUIHyperStringMarquee) : void
      {
         ResourcesDispatchSubstrate(param1);
      }
   }
}

