package Logics.DatebaseVO.VO.Json.Post
{
   public class TLinkURL extends TPostKey
   {
      
      protected var FHyperlinkAddress:String;
      
      public function TLinkURL(param1:Array)
      {
         super();
         FName = param1[0];
         this.FHyperlinkAddress = param1[1];
         FUnderline = true;
      }
      
      public function get HyperlinkAddress() : String
      {
         return this.FHyperlinkAddress;
      }
      
      public function set HyperlinkAddress(param1:String) : void
      {
         this.FHyperlinkAddress = param1;
      }
   }
}

