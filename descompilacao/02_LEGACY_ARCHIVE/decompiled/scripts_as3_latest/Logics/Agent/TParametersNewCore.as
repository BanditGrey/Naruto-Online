package Logics.Agent
{
   import Foundation.Utilities.TUtilityString;
   
   public class TParametersNewCore
   {
      
      protected var FIsCollect:int;
      
      protected var FCollectEmail:String;
      
      protected var FCollectPswd:String;
      
      protected var FIsMicroLogin:Boolean;
      
      public function TParametersNewCore()
      {
         super();
         this.FIsCollect = 0;
         this.FCollectEmail = "";
         this.FCollectPswd = "";
         this.FIsMicroLogin = false;
      }
      
      public function CoerceProperties(param1:Object) : void
      {
         this.FIsCollect = param1.collect;
         this.FCollectEmail = param1.collectEmail;
         this.FCollectPswd = param1.collectPswd;
         this.FIsMicroLogin = Boolean(param1.web_app);
         if(TUtilityString.Empty(this.FCollectEmail))
         {
            this.FCollectEmail = "";
         }
         if(TUtilityString.Empty(this.FCollectPswd))
         {
            this.FCollectPswd = "";
         }
      }
      
      public function get IsCollect() : int
      {
         return this.FIsCollect;
      }
      
      public function set IsCollect(param1:int) : void
      {
         this.FIsCollect = param1;
      }
      
      public function get CollectPswd() : String
      {
         return this.FCollectPswd;
      }
      
      public function set CollectPswd(param1:String) : void
      {
         this.FCollectPswd = param1;
      }
      
      public function get CollectEmail() : String
      {
         return this.FCollectEmail;
      }
      
      public function set CollectEmail(param1:String) : void
      {
         this.FCollectEmail = param1;
      }
      
      public function get IsMicroLogin() : Boolean
      {
         return this.FIsMicroLogin;
      }
      
      public function set IsMicroLogin(param1:Boolean) : void
      {
         this.FIsMicroLogin = param1;
      }
   }
}

