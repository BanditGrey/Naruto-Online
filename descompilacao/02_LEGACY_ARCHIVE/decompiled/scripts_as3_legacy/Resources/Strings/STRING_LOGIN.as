package Resources.Strings
{
   public class STRING_LOGIN
   {
      
      public static const STRING_Error:String = "Error de inicio de sesión";
      
      public static const STRING_ERROR_OK:String = "Normal";
      
      public static const STRING_ERROR_Network:String = "Fallo de conexión de red";
      
      public static const STRING_ERROR_Timeout:String = "Tiempo fuera de comunicación";
      
      public static const STRING_ERROR_Status:String = "Fallo de inicio de sesión de Status Server";
      
      public static const STRING_ERROR_Gate:String = "Fallo de inicio de sesión de Gate Server";
      
      public static const STRINGS_Error:Vector.<String> = Vector.<String>([STRING_ERROR_OK,STRING_ERROR_Network,STRING_ERROR_Timeout,STRING_ERROR_Status,STRING_ERROR_Gate]);
      
      public function STRING_LOGIN()
      {
         super();
      }
   }
}

