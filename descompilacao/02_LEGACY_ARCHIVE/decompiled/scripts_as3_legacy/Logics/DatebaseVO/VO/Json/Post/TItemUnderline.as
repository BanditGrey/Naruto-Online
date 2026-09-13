package Logics.DatebaseVO.VO.Json.Post
{
   import Resources.Constants.CONST_COMMON;
   
   public class TItemUnderline extends TPostKey
   {
      
      public function TItemUnderline(param1:Array)
      {
         super();
         FName = param1[0];
         FIDTemplate = param1[1];
         FColor = CONST_COMMON.QUALITYCOLOR_INDEX[param1[2]];
      }
   }
}

