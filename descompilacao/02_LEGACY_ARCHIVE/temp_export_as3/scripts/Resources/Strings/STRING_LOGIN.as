package Resources.Strings
{
   public class STRING_LOGIN
   {
      
      public static const STRING_Error:String = "Login error";
      
      public static const STRING_ERROR_OK:String = "Normal.";
      
      public static const STRING_ERROR_Network:String = "Failed to connect.";
      
      public static const STRING_ERROR_Timeout:String = "Network timeout.";
      
      public static const STRING_ERROR_Status:String = "Status server login failed.";
      
      public static const STRING_ERROR_Gate:String = "Gate server login failed.";
      
      public static const STRINGS_Error:Vector.<String> = Vector.<String>([STRING_ERROR_OK,STRING_ERROR_Network,STRING_ERROR_Timeout,STRING_ERROR_Status,STRING_ERROR_Gate]);
      
      public function STRING_LOGIN()
      {
         super();
      }
   }
}

