package Logics.DatebaseVO.VO.Json.Post
{
   import Resources.Constants.CONST_COMMON;
   
   public class TCityQuality extends TPostKey
   {
      
      public function TCityQuality(param1:Array)
      {
         super();
         FName = param1[0];
         FColor = CONST_COMMON.QUALITYCOLOR_INDEX[param1[1]];
      }
   }
}

