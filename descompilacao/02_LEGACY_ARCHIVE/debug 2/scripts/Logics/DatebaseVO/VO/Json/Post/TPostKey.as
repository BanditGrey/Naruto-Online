package Logics.DatebaseVO.VO.Json.Post
{
   public class TPostKey
   {
      
      protected var FName:String;
      
      protected var FIdentifier0:uint;
      
      protected var FIdentifier1:uint;
      
      protected var FIDTemplate:uint;
      
      protected var FColor:uint;
      
      protected var FUnderline:Boolean;
      
      protected var FNum:uint;
      
      public function TPostKey()
      {
         super();
         this.FName = "";
         this.FIdentifier0 = 0;
         this.FIdentifier1 = 0;
         this.FIDTemplate = 0;
         this.FColor = 4278190080;
         this.FUnderline = false;
         this.FNum = 0;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Color() : uint
      {
         return this.FColor;
      }
      
      public function get Underline() : Boolean
      {
         return this.FUnderline;
      }
      
      public function get Identifier0() : uint
      {
         return this.FIdentifier0;
      }
      
      public function get Identifier1() : uint
      {
         return this.FIdentifier1;
      }
      
      public function get Num() : uint
      {
         return this.FNum;
      }
      
      public function get IDTemplate() : uint
      {
         return this.FIDTemplate;
      }
      
      public function set IDTemplate(param1:uint) : void
      {
         this.FIDTemplate = param1;
      }
   }
}

