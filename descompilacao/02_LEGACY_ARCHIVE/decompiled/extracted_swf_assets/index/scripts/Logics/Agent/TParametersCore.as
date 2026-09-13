package Logics.Agent
{
   import Foundation_Mini.Utilities.TUtilityString;
   import Logics.Agent.Spaces.ParametersSpace;
   import flash.utils.Dictionary;
   
   use namespace ParametersSpace;
   
   public class TParametersCore
   {
      
      public static const TYPE_ANTIADDICTION_ADULTHOOD:uint = 1;
      
      protected var FServerHost:String;
      
      protected var FServerPort:uint;
      
      protected var FOperatorUserID:String;
      
      protected var FAgentID:uint;
      
      protected var FServerID:uint;
      
      protected var FClientVersion:uint;
      
      protected var FServerVersion:uint;
      
      protected var FLoginStringToken:String;
      
      protected var FCdnRoot:String;
      
      protected var FLoginTime:String;
      
      protected var FAntiAddictionState:int;
      
      protected var FPayUrl:String;
      
      protected var FBattleReportUrl:String;
      
      protected var FSupportUrl:String;
      
      protected var FOfficeUrl:String;
      
      protected var FIsNewUser:Boolean;
      
      protected var FIsCombinServer:Boolean;
      
      protected var FIsFeedOpen:int;
      
      protected var FIsBound:Boolean;
      
      protected var FIsvk:Boolean;
      
      protected var FIs1377Display:Boolean;
      
      protected var FPassWord1377:String;
      
      protected var FPrefix:String;
      
      protected var FDXServerHost:String;
      
      protected var FWTServerHost:String;
      
      protected var FResourceVersionConfig:Dictionary;
      
      protected var FResourceSizeConfig:Dictionary;
      
      protected var FIsDebug:Boolean;
      
      protected var FUserIP:String;
      
      protected var FIsInitialization:Boolean;
      
      protected var FFightReportUrl:String;
      
      protected var FEmail:String;
      
      protected var FPassWord:String;
      
      public function TParametersCore()
      {
         super();
         this.FServerHost = "";
         this.FServerPort = 0;
         this.FOperatorUserID = "";
         this.FAgentID = 0;
         this.FServerID = 0;
         this.FClientVersion = 0;
         this.FServerVersion = 0;
         this.FLoginStringToken = "";
         this.FCdnRoot = "";
         this.FLoginTime = "";
         this.FAntiAddictionState = 0;
         this.FPayUrl = "";
         this.FBattleReportUrl = "";
         this.FSupportUrl = "";
         this.FOfficeUrl = "";
         this.FIsNewUser = false;
         this.FIsCombinServer = false;
         this.FIsFeedOpen = 0;
         this.FIsBound = false;
         this.FIsvk = false;
         this.FIs1377Display = false;
         this.FDXServerHost = "";
         this.FWTServerHost = "";
         this.FIsDebug = false;
         this.FUserIP = "";
         this.FFightReportUrl = "";
         this.FEmail = "";
         this.FPassWord = "";
         this.FIsInitialization = false;
      }
      
      ParametersSpace function CoerceProperties(param1:Object) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         this.FServerHost = param1.gatewayIP;
         this.FServerPort = parseInt(param1.gatewayPort);
         this.FOperatorUserID = param1.username;
         this.FAgentID = parseInt(param1.agent);
         this.FServerID = parseInt(param1.server);
         this.FClientVersion = parseInt(param1.version);
         this.FServerVersion = parseInt(param1.ServerVersion);
         this.FLoginStringToken = param1.token;
         this.FCdnRoot = param1.cdnRoot;
         this.FLoginTime = param1.time;
         this.FAntiAddictionState = parseInt(param1.isAdult);
         this.FPayUrl = param1.payurl;
         this.FBattleReportUrl = param1.fightreporturl;
         this.FSupportUrl = param1.support;
         this.FOfficeUrl = param1.officeurl;
         _loc2_ = uint(param1.isNew);
         this.FIsNewUser = Boolean(_loc2_);
         _loc3_ = uint(param1.isCombin);
         this.FIsCombinServer = Boolean(_loc3_);
         this.FIsFeedOpen = param1.isopen;
         _loc5_ = uint(param1.bound);
         this.FIsBound = Boolean(_loc5_);
         _loc6_ = uint(param1.vk);
         this.FIsvk = Boolean(_loc6_);
         _loc7_ = uint(param1.display);
         this.FIs1377Display = Boolean(_loc7_);
         this.FPassWord1377 = param1.pass;
         this.FPrefix = param1.prefix;
         this.FDXServerHost = param1.DXServerIP;
         this.FWTServerHost = param1.WTServerIP;
         _loc4_ = uint(param1.isdebug);
         this.FIsDebug = Boolean(_loc4_);
         this.FUserIP = param1.userIp;
         this.FEmail = param1.email;
         this.FPassWord = param1.pswd;
         if(TUtilityString.Empty(this.FServerHost))
         {
            this.FServerHost = "";
         }
         if(TUtilityString.Empty(this.FOperatorUserID))
         {
            this.FOperatorUserID = "";
         }
         if(TUtilityString.Empty(this.FLoginStringToken))
         {
            this.FLoginStringToken = "";
         }
         if(TUtilityString.Empty(this.FCdnRoot))
         {
            this.FCdnRoot = "";
         }
         if(TUtilityString.Empty(this.FLoginTime))
         {
            this.FLoginTime = "";
         }
         if(TUtilityString.Empty(this.FPayUrl))
         {
            this.FPayUrl = "#";
         }
         if(TUtilityString.Empty(this.FBattleReportUrl))
         {
            this.FBattleReportUrl = "#";
         }
         if(TUtilityString.Empty(this.FSupportUrl))
         {
            this.FSupportUrl = "#";
         }
         if(TUtilityString.Empty(this.FOfficeUrl))
         {
            this.FOfficeUrl = "#";
         }
         if(TUtilityString.Empty(this.FDXServerHost))
         {
            this.FDXServerHost = "";
         }
         if(TUtilityString.Empty(this.FWTServerHost))
         {
            this.FWTServerHost = "";
         }
         if(TUtilityString.Empty(this.FUserIP))
         {
            this.FUserIP = "0.0.0.0";
         }
         this.FIsInitialization = true;
      }
      
      ParametersSpace function CoerceResourceConfig(param1:Dictionary, param2:Dictionary) : void
      {
         this.FResourceVersionConfig = param1;
         this.FResourceSizeConfig = param2;
      }
      
      public function get OperatorUserID() : String
      {
         return this.FOperatorUserID;
      }
      
      public function get AgentID() : uint
      {
         return this.FAgentID;
      }
      
      public function get ServerID() : uint
      {
         return this.FServerID;
      }
      
      public function get ClientVersion() : uint
      {
         return this.FClientVersion;
      }
      
      public function get ServerVersion() : uint
      {
         return this.FServerVersion;
      }
      
      public function get LoginStringToken() : String
      {
         return this.FLoginStringToken;
      }
      
      public function get ServerHost() : String
      {
         return this.FServerHost;
      }
      
      public function get ServerPort() : uint
      {
         return this.FServerPort;
      }
      
      public function get CdnRoot() : String
      {
         return this.FCdnRoot;
      }
      
      public function set CdnRoot(param1:String) : void
      {
         this.FCdnRoot = param1;
      }
      
      public function get IsInitialization() : Boolean
      {
         return this.FIsInitialization;
      }
      
      public function get LoginTime() : String
      {
         return this.FLoginTime;
      }
      
      public function get AntiAddictionState() : int
      {
         return this.FAntiAddictionState;
      }
      
      public function get PayUrl() : String
      {
         return this.FPayUrl;
      }
      
      public function get BattleReportUrl() : String
      {
         return this.FBattleReportUrl;
      }
      
      public function get SupportUrl() : String
      {
         return this.FSupportUrl;
      }
      
      public function get OfficeUrl() : String
      {
         return this.FOfficeUrl;
      }
      
      public function get IsNewUser() : Boolean
      {
         return this.FIsNewUser;
      }
      
      public function get IsCombinServer() : Boolean
      {
         return this.FIsCombinServer;
      }
      
      public function get ResourceVersionConfig() : Dictionary
      {
         return this.FResourceVersionConfig;
      }
      
      public function get ResourceSizeConfig() : Dictionary
      {
         return this.FResourceSizeConfig;
      }
      
      public function get DXServerHost() : String
      {
         return this.FDXServerHost;
      }
      
      public function get WTServerHost() : String
      {
         return this.FWTServerHost;
      }
      
      public function get IsDebug() : Boolean
      {
         return this.FIsDebug;
      }
      
      public function get UserIP() : String
      {
         return this.FUserIP;
      }
      
      public function get IsFeedOpen() : int
      {
         return this.FIsFeedOpen;
      }
      
      public function set IsFeedOpen(param1:int) : void
      {
         this.FIsFeedOpen = param1;
      }
      
      public function get IsBound() : Boolean
      {
         return this.FIsBound;
      }
      
      public function set IsBound(param1:Boolean) : void
      {
         this.FIsBound = param1;
      }
      
      public function get Isvk() : Boolean
      {
         return this.FIsvk;
      }
      
      public function set Isvk(param1:Boolean) : void
      {
         this.FIsvk = param1;
      }
      
      public function get Is1377Display() : Boolean
      {
         return this.FIs1377Display;
      }
      
      public function set Is1377Display(param1:Boolean) : void
      {
         this.FIs1377Display = param1;
      }
      
      public function get PassWord1377() : String
      {
         return this.FPassWord1377;
      }
      
      public function set PassWord1377(param1:String) : void
      {
         this.FPassWord1377 = param1;
      }
      
      public function get Prefix() : String
      {
         return this.FPrefix;
      }
      
      public function set Prefix(param1:String) : void
      {
         this.FPrefix = param1;
      }
      
      public function get FightReportUrl() : String
      {
         return this.FFightReportUrl;
      }
      
      public function set FightReportUrl(param1:String) : void
      {
         this.FFightReportUrl = param1;
      }
      
      public function get Email() : String
      {
         return this.FEmail;
      }
      
      public function set Email(param1:String) : void
      {
         this.FEmail = param1;
      }
      
      public function get PassWord() : String
      {
         return this.FPassWord;
      }
      
      public function set PassWord(param1:String) : void
      {
         this.FPassWord = param1;
      }
   }
}

