package Resources.Constants
{
   import Logics.Agent.SParametersCore;
   import Resources.Strings.STRING_LOBBY;
   
   public class CONST_PLATE
   {
      
      public static const ID_PLATE_NORMAL:uint = 1;
      
      public static const ID_PLATE_US:uint = 54;
      
      public static const ID_PLATE_UK:uint = 53;
      
      public static const ID_PLATE_ID:uint = 65;
      
      public static const ID_PLATE_USFB:uint = 70;
      
      public static const ID_PLATE_JOYFUN:uint = 73;
      
      public static const ID_PLATE_BRAZIL:uint = 75;
      
      public static const ID_PLATE_EUROPE:uint = 76;
      
      public static const ID_PLATE_JOYGAME:uint = 78;
      
      public static const ID_PLATE_RUSSIA:uint = 82;
      
      public static const ID_PLATE_FRENCH:uint = 87;
      
      public static const ID_PLATE_BAIDU:uint = 89;
      
      public static const ID_PLATE_TH_FACEBOOK:uint = 92;
      
      public static const ID_PLATE_TR:uint = 99;
      
      public static const ID_PLATE_RU_WIKI:uint = 104;
      
      public static const ID_PLATE_DE:uint = 105;
      
      public static const ID_PLATE_ESP:uint = 108;
      
      public static const ID_PLATE_FB_OTHER:uint = 109;
      
      public static const ID_PLATE_UK_OTHER:uint = 110;
      
      public static const ID_PLATE_RU_OTHER:uint = 112;
      
      public static const ID_PLATE_IT:uint = 113;
      
      public static const ID_PLATE_RU_GN:uint = 116;
      
      public static const ALL_OTHER_PLATE_ID:Vector.<uint> = Vector.<uint>([ID_PLATE_FB_OTHER,ID_PLATE_UK_OTHER]);
      
      public function CONST_PLATE()
      {
         super();
      }
      
      public static function GetStartLoadingID(param1:int) : int
      {
         if(SParametersCore.AgentID == ID_PLATE_ID)
         {
            return STRING_LOBBY.RESOURCESID_Textures_StartLoading_3[param1];
         }
         if(SParametersCore.AgentID == ID_PLATE_USFB || SParametersCore.AgentID == ID_PLATE_JOYFUN || SParametersCore.AgentID == ID_PLATE_EUROPE)
         {
            return STRING_LOBBY.RESOURCESID_Textures_StartLoading_4[param1];
         }
         if(SParametersCore.AgentID == ID_PLATE_US)
         {
            return STRING_LOBBY.RESOURCESID_Textures_StartLoading_5[param1];
         }
         if(ALL_OTHER_PLATE_ID.indexOf(SParametersCore.AgentID) == -1)
         {
            return STRING_LOBBY.RESOURCESID_Textures_StartLoading[param1];
         }
         return STRING_LOBBY.RESOURCESID_Textures_StartLoading_2[param1];
      }
      
      public static function GetBattleLoadingID(param1:int) : int
      {
         if(SParametersCore.AgentID == ID_PLATE_ID)
         {
            return STRING_LOBBY.RESOURCESID_Textures_BattleLoadingBackgroudVec_3[param1];
         }
         if(ALL_OTHER_PLATE_ID.indexOf(SParametersCore.AgentID) == -1)
         {
            return STRING_LOBBY.RESOURCESID_Textures_BattleLoadingBackgroudVec[param1];
         }
         return STRING_LOBBY.RESOURCESID_Textures_BattleLoadingBackgroudVec_2[param1];
      }
      
      public static function GetWelcomeID() : int
      {
         if(ALL_OTHER_PLATE_ID.indexOf(SParametersCore.AgentID) == -1)
         {
            return CONST_FRESHGUIDE.RESOURCESID_FreshGuide_Welcome;
         }
         return CONST_FRESHGUIDE.RESOURCESID_FreshGuide_Welcome_2;
      }
   }
}

