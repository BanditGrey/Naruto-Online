package Logics.DatebaseVO.VO.Json.Post
{
   import Resources.Constants.CONST_COMMON;
   
   public class TPlayerQualityUnderline extends TPostKey
   {
      
      public function TPlayerQualityUnderline(param1:Array)
      {
         super();
         FName = param1[0];
         FIdentifier0 = param1[1];
         FIdentifier1 = param1[2];
         FColor = CONST_COMMON.QUALITYCOLOR_INDEX[param1[3]];
         FUnderline = true;
      }
   }
}

