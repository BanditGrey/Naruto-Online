package Logics.DatebaseVO.VO.Json.Post
{
   import Resources.Constants.CONST_COMMON;
   
   public class TCountryColor extends TPostKey
   {
      
      public function TCountryColor(param1:Array)
      {
         super();
         FName = param1[0];
         FColor = CONST_COMMON.COUNTRYCOLOR_INDEX[param1[1]];
      }
   }
}

