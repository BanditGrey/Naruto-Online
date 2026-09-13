package Resources.Constants
{
   import Resources.Strings.*;
   
   public class CONST_CHAT
   {
      
      public static const FONT_DefaultName:String = "Tahoma";
      
      public static const FONT_DefaultSize:uint = 12;
      
      public static const FONT_DefaultColor:uint = 4294967295;
      
      public static const RESOURCESID_Swf_CHAT:uint = 1;
      
      public static const RESOURCE_ClassName_MC_Chat:String = "MC_Chat";
      
      public static const RESOURCE_ClassName_MC_Notice:String = "MC_Notice";
      
      public static const RESOURCE_Link_MC_PanelChat:String = "MC_PanelChat";
      
      public static const RESOURCE_Link_MC_ScrollBar:String = "MC_ScrollBar";
      
      public static const RESOURCE_ClassName_MC_PopupMenuChannelList:String = "MC_PopupMenuChannelList";
      
      public static const RESOURCE_ClassName_MC_PopupMenuCharacterList:String = "MC_PopupMenuCharacterList";
      
      public static const RESOURCE_Link_MC_PopupMenuSubstrate:String = "MC_PopupMenuSubstrate";
      
      public static const RESOURCE_Link_MC_Menus:String = "MC_Menu_";
      
      public static const RESOURCE_Link_MC_ChannelFilters:String = "MC_ChannelFilters";
      
      public static const RESOURCE_Link_MC_Tab_:String = "MC_Tab_";
      
      public static const RESOURCE_Link_MC_HyperEditorMountPoint:String = "MC_HyperEditorMountPoint";
      
      public static const RESOURCE_Link_MC_HyperEditorSubstrate:String = "MC_HyperEditorSubstrate";
      
      public static const RESOURCE_Link_MC_ChatViewMountPoint:String = "MC_ChatViewMountPoint";
      
      public static const RESOURCE_Link_MC_ChatViewSubstrate:String = "MC_ChatViewSubstrate";
      
      public static const RESOURCE_Link_MC_ScrollBarMountPoint:String = "MC_ScrollBarMountPoint";
      
      public static const RESOURCE_Link_Btn_ChannelSelect:String = "Btn_ChannelSelect";
      
      public static const RESOURCE_Link_TF_ChannelName:String = "TF_ChannelName";
      
      public static const RESOURCE_Link_Btn_Btn_MessageSend:String = "Btn_MessageSend";
      
      public static const RESOURCE_Link_Btn_Expression:String = "Btn_Expression";
      
      public static const RESOURCE_Link_MC_ZoomingMax:String = "MC_ZoomingMax";
      
      public static const RESOURCE_Link_MC_ZoomingMin:String = "MC_ZoomingMin";
      
      public static const MODE_None:uint = 0;
      
      public static const MODE_Hidden:uint = 1;
      
      public static const ZOOMING_Maximize:uint = 1;
      
      public static const ZOOMING_Minimize:uint = 2;
      
      public static const CHANNEL_TYPE_Composite:uint = 0;
      
      public static const CHANNEL_TYPE_SystemOne:uint = 1;
      
      public static const CHANNEL_TYPE_World:uint = 2;
      
      public static const CHANNEL_TYPE_Country:uint = 3;
      
      public static const CHANNEL_TYPE_Organization:uint = 4;
      
      public static const CHANNEL_TYPE_Whisper:uint = 5;
      
      public static const CHANNEL_TYPE_SystemTwo:uint = 6;
      
      public static const CHANNEL_TYPE_SystemThree:uint = 7;
      
      public static const CHANNEL_TYPE_Team:uint = 8;
      
      public static const CHANNEL_TYPE_Typhon:uint = 9;
      
      public static const CAPACITY_Channels:uint = CHANNEL_TYPE_Typhon + 1;
      
      public static const CHANNELS_TYPE:Vector.<uint> = Vector.<uint>([CHANNEL_TYPE_Composite,CHANNEL_TYPE_SystemOne,CHANNEL_TYPE_World,CHANNEL_TYPE_Country,CHANNEL_TYPE_Organization,CHANNEL_TYPE_Whisper,CHANNEL_TYPE_SystemTwo,CHANNEL_TYPE_SystemThree,CHANNEL_TYPE_Team,CHANNEL_TYPE_Typhon]);
      
      public static const CHANNELS_TYPE_Filter:Vector.<uint> = Vector.<uint>([CHANNEL_TYPE_World,CHANNEL_TYPE_World,CHANNEL_TYPE_Country,CHANNEL_TYPE_Organization,CHANNEL_TYPE_Whisper,CHANNEL_TYPE_Team,CHANNEL_TYPE_Typhon]);
      
      public static const CHANNEL_LIST_World:uint = 0;
      
      public static const CHANNEL_LIST_Country:uint = 1;
      
      public static const CHANNEL_LIST_Organization:uint = 2;
      
      public static const CHANNEL_LIST_Whisper:uint = 3;
      
      public static const CHANNEL_LIST_Team:uint = 8;
      
      public static const CHANNEL_LIST_Typhon:uint = 9;
      
      public static const CAPACITY_ChannelLists:uint = 6;
      
      public static const CHANNELS_TYPE_LIST:Vector.<uint> = Vector.<uint>([CHANNEL_TYPE_World,CHANNEL_TYPE_Country,CHANNEL_TYPE_Organization,CHANNEL_TYPE_Whisper,CHANNEL_LIST_Team,CHANNEL_LIST_Typhon]);
      
      public static const CHANNEL_FILTER_TYPE_Composite:uint = 0;
      
      public static const CHANNEL_FILTER_TYPE_World:uint = 1;
      
      public static const CHANNEL_FILTER_TYPE_Country:uint = 2;
      
      public static const CHANNEL_FILTER_TYPE_Organization:uint = 3;
      
      public static const CHANNEL_FILTER_TYPE_Whisper:uint = 4;
      
      public static const CHANNEL_FILTER_TYPE_Team:uint = 5;
      
      public static const CHANNEL_FILTER_TYPE_Typhon:uint = 6;
      
      public static const CAPACITY_ChannelsFilter:uint = CHANNEL_FILTER_TYPE_Typhon + 1;
      
      public static const CHANNELS_FILTER:Vector.<uint> = Vector.<uint>([CHANNEL_TYPE_Composite,CHANNEL_TYPE_World,CHANNEL_TYPE_Country,CHANNEL_TYPE_Organization,CHANNEL_TYPE_Whisper,CHANNEL_TYPE_Team,CHANNEL_TYPE_Typhon]);
      
      public static const CHANNEL_COOLING_Composite:int = 0;
      
      public static const CHANNEL_COOLING_SystemOne:int = 0;
      
      public static const CHANNEL_COOLING_World:int = 6000;
      
      public static const CHANNEL_COOLING_Country:int = 5000;
      
      public static const CHANNEL_COOLING_Organization:int = 1000;
      
      public static const CHANNEL_COOLING_Whisper:int = 1000;
      
      public static const CHANNEL_COOLING_SystemTwo:int = 0;
      
      public static const CHANNEL_COOLING_SystemThree:int = 0;
      
      public static const CHANNEL_COOLING_Team:int = 0;
      
      public static const CHANNELS_Cooling:Vector.<int> = Vector.<int>([CHANNEL_COOLING_Composite,CHANNEL_COOLING_SystemOne,CHANNEL_COOLING_World,CHANNEL_COOLING_Country,CHANNEL_COOLING_Organization,CHANNEL_COOLING_Whisper,CHANNEL_COOLING_SystemTwo,CHANNEL_COOLING_SystemThree,CHANNEL_COOLING_Team]);
      
      public static const CAPACITY_Expression:uint = 6;
      
      public static const CAPACITY_CharacterSelect:uint = 5;
      
      public static const CHARACTER_SELECT_View:uint = 0;
      
      public static const CHARACTER_SELECT_Whisper:uint = 1;
      
      public static const CHARACTER_SELECT_CopyName:uint = 2;
      
      public static const CHARACTER_SELECT_Friend:uint = 3;
      
      public static const CHARACTER_SELECT_Shield:uint = 4;
      
      public static const WHISPER_Receive:int = 1;
      
      public static const WHISPER_Echoplex:int = 2;
      
      public static const Post_Common:uint = 0;
      
      public static const Post_Special:uint = 1;
      
      public function CONST_CHAT()
      {
         super();
      }
   }
}

