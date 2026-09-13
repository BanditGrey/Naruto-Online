package Processors.Game.Lobby.DailyWelfare
{
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DailyWelfare.TDailyWelfareData;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TDailyWelfare_GetBack;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowInformationNew;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DAILYWELFARE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_DAILYWELFARE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorDailyWelfare extends TProcessorLobbyWindows
   {
      
      protected static const TAB_INDEX_ResourceFound:int = 0;
      
      protected static const TAB_INDEX_DailyWelfare:int = 1;
      
      protected var FScene:MovieClip;
      
      protected var FUIWindowInformation:TUIWindowInformationNew;
      
      protected var FHelpTips:THint;
      
      protected var FWindows:Vector.<TUIComponent>;
      
      protected var FTabs:TUITab;
      
      protected var FWindowDailyResourceFound:TProcessorWindowDailyResourceFound;
      
      protected var FWindowDailyWelfare:TProcessorWindowDailyWelfare;
      
      protected var FWindowSupremeFound:TProcessorWindowSupremeFound;
      
      protected var FInitWelfare:Boolean;
      
      protected var FShowDailyWelfareLevel:uint;
      
      protected var FIsDailyShowSign:Boolean;
      
      protected var FIsResourceShowSign:Boolean;
      
      protected var FDailyWelfareData:TDailyWelfareData;
      
      protected var FKeySort:Array;
      
      protected var FGetBackSort:Object;
      
      protected var FOnEffectSign:Function;
      
      public function TProcessorDailyWelfare(param1:TUIComponent, param2:TLobbyParameters)
      {
         var _loc3_:uint = 0;
         super(param1,param2);
         this.FDailyWelfareData = new TDailyWelfareData();
         this.FWindowDailyResourceFound = new TProcessorWindowDailyResourceFound(this);
         this.FWindowDailyResourceFound.OnGenerateEffectText = this.OnGenerateEffectText;
         this.FWindowDailyResourceFound.OnEffectSign = this.CheckEffectSign;
         this.FWindowDailyWelfare = new TProcessorWindowDailyWelfare(this);
         this.FWindowDailyWelfare.OnGenerateEffectText = this.OnGenerateEffectText;
         this.FWindowDailyWelfare.OnEffectSign = this.CheckEffectSign;
         this.FWindowSupremeFound = new TProcessorWindowSupremeFound(this);
         this.FWindowSupremeFound.OnGenerateEffectText = this.OnGenerateEffectText;
         this.FWindowSupremeFound.OnEffectSign = this.CheckEffectSign;
         this.FUIWindowInformation = new TUIWindowInformationNew(this.Parent);
         this.FUIWindowInformation.OnOK = this.OnGetOfflineReward;
         this.FUIWindowInformation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowInformation.WindowHeight) / 2;
         this.FInitWelfare = false;
         this.FIsDailyShowSign = false;
         this.FIsResourceShowSign = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_DAILYWELFARE.RESOURCESID_Swf_DailyWelfare);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:Vector.<String> = null;
         var _loc5_:int = 0;
         var _loc6_:TSystemLanguage = null;
         var _loc7_:TConfigValue = null;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_DAILYWELFARE.RESOURCE_ClassName_DailyWelfare) as MovieClip;
         addChild(this.FScene);
         this.FWindowDailyResourceFound.Perform_UIDispatch(this.FScene["MC_ResourceFound"]);
         addChild(this.FWindowDailyResourceFound);
         this.FWindowDailyWelfare.Perform_UIDispatch(this.FScene["MC_DailyWelfare"]);
         addChild(this.FWindowDailyWelfare);
         this.FWindowDailyWelfare.Visible = false;
         this.FWindowSupremeFound.Perform_UIDispatch(this.FScene["MC_SupremeFound"]);
         addChild(this.FWindowSupremeFound);
         this.FWindowSupremeFound.Visible = false;
         this.FWindows = new Vector.<TUIComponent>();
         this.FWindows.push(this.FWindowDailyResourceFound);
         this.FWindows.push(this.FWindowDailyWelfare);
         this.FWindows.push(this.FWindowSupremeFound);
         this.FTabs = new TUITab(this);
         _loc4_ = CONST_DAILYWELFARE.Tab_Names;
         _loc5_ = int(_loc4_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc5_)
         {
            _loc3_ = this.FScene[_loc4_[_loc1_]];
            _loc3_.buttonMode = true;
            _loc3_.mouseChildren = false;
            this.FTabs.SetTabByIndex(_loc3_,_loc1_);
            _loc1_++;
         }
         this.FTabs.OnSwitch = this.TabClick;
         this.FTabs.Init();
         this.FHelpTips = new THint();
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Welfare_OpenLevel) as TConfigValue;
         this.FShowDailyWelfareLevel = _loc7_.Value as uint;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.DailyWelfare_Tips) as TSystemLanguage;
         this.FHelpTips.Content = _loc6_.Desc;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         this.FScene.btn_Close.addEventListener(MouseEvent.CLICK,this.OnCloseWindow);
         this.FScene.btn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         this.FScene.btn_Help.addEventListener(MouseEvent.ROLL_OUT,this.ButtonHelpOnOut);
         super.ResourcesPerform_UILocations();
      }
      
      protected function SwitchTab(param1:int) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < CONST_DAILYWELFARE.TAB_NUM)
         {
            this.FWindows[_loc3_].Visible = false;
            _loc3_++;
         }
         if(param1 == TAB_INDEX_ResourceFound)
         {
            this.FWindows[param1].Visible = true;
         }
         else if(param1 == TAB_INDEX_DailyWelfare)
         {
            this.FWindows[param1].Visible = true;
         }
         else
         {
            this.FWindows[param1].Visible = true;
         }
      }
      
      protected function InitWelfare() : void
      {
         if(this.FInitWelfare)
         {
            return;
         }
         this.FInitWelfare = true;
      }
      
      protected function OnGenerateEffectText(param1:Object, param2:String) : void
      {
         EffectGenerateText(param2);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DailyWelfare_LoadInfo_Ret,this.PerformPacket_SC_DailyWelfare_LoadInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DailyWelfare_GetReward_Ret,this.PerformPacket_SC_DailyWelfare_GetRewardOk);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DailyGetBackRecordRet,this.PerformPacket_SC_DailyGetBackRecordRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DailyGetBackRewardRet,this.PerformPacket_SC_DailyGetBackRewardRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DailyGetBackGroupRewardRet,this.PerformPacket_SC_DailyGetBackGroupRewardRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DailyGetBackBuyRewardRet,this.PerformPacket_SC_DailyGetBackBuyRewardRet);
      }
      
      protected function PerformPacket_SC_DailyWelfare_LoadInfo(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         _loc3_ = param1.Data;
         _loc6_ = int(_loc3_.readUnsignedInt());
         if(_loc6_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc6_);
            return;
         }
         this.FWindowDailyWelfare.DailyWelfare_LoadInfo(_loc3_);
      }
      
      protected function PerformPacket_SC_DailyWelfare_GetRewardOk(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         EffectGenerateText(STRING_DAILYWELFARE.STRING_GetRewardOk);
         this.FWindowDailyWelfare.DailyWelfare_GetRewardOk(_loc2_);
      }
      
      protected function PerformPacket_SC_DailyGetBackRecordRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc2_ = param1.Data;
         _loc4_ = uint(_loc2_.readShort());
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc2_.readUnsignedInt();
            _loc8_ = _loc2_.readUnsignedInt();
            _loc9_ = _loc2_.readUnsignedInt();
            _loc6_ = this.GetResourceIdByModeleId(_loc8_);
            this.FDailyWelfareData.SetResourceData(_loc6_,_loc5_,_loc9_);
            _loc3_++;
         }
         this.FDailyWelfareData.EndTimer = _loc2_.readInt();
         this.FDailyWelfareData.Offdays = _loc2_.readInt();
         this.FWindowDailyResourceFound.DailyWelfareData = this.FDailyWelfareData;
         this.FWindowSupremeFound.DailyWelfareData = this.FDailyWelfareData;
         TUtilityUIWindow.SetupWindowInformationNew(this.FUIWindowInformation);
         if(this.FDailyWelfareData.Offdays >= 3)
         {
            this.FUIWindowInformation.Visible = true;
            this.FUIWindowInformation.SetHtml = TUtilityString.Format(this.FormatText(new ConsumeFrame(80002310).DescribeString),this.FWindowSupremeFound.GetOfflineResourceback(TDailyWelfare_GetBack.TYPE_EXP) * this.FDailyWelfareData.Offdays,this.FWindowSupremeFound.GetOfflineResourceback(TDailyWelfare_GetBack.TYPE_SILVER) * this.FDailyWelfareData.Offdays);
         }
      }
      
      protected function FormatText(param1:String) : String
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         _loc4_ = "";
         _loc5_ = param1.split("%n");
         _loc3_ = int(_loc5_.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc4_ + _loc5_[_loc2_] + "\n";
            _loc2_++;
         }
         return _loc4_;
      }
      
      protected function PerformPacket_SC_DailyGetBackRewardRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc5_ = _loc2_.readUnsignedInt();
         _loc4_ = _loc2_.readUnsignedInt();
         this.FWindowDailyResourceFound.DailyGetBack_RewardRet(_loc5_);
         this.FWindowSupremeFound.DailyGetBack_RewardRet(_loc5_);
         EffectGenerateText(STRING_DAILYWELFARE.STRING_GetRewardOk);
      }
      
      protected function PerformPacket_SC_DailyGetBackGroupRewardRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FWindowDailyResourceFound.DailyGetBack_GroupRewardRet();
         this.FWindowSupremeFound.DailyGetBack_GroupRewardRet();
         EffectGenerateText(STRING_DAILYWELFARE.STRING_GetRewardOk);
      }
      
      protected function PerformPacket_SC_DailyGetBackBuyRewardRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FDailyWelfareData.EndTimer = _loc2_.readInt();
         this.FDailyWelfareData.Offdays = _loc2_.readInt();
         if(_loc4_ == 0)
         {
            return;
         }
         if(_loc4_ == 2)
         {
            return;
         }
         this.FWindowDailyResourceFound.DailyGetBack_GroupRewardRet();
         this.FWindowSupremeFound.DailyGetBack_GroupRewardRet();
         EffectGenerateText(STRING_DAILYWELFARE.STRING_GetRewardOk);
      }
      
      protected function KeySortFun(param1:Array, param2:Array) : int
      {
         return param1[0] - param2[0];
      }
      
      protected function GetResourceIdByModeleId(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TConfigValue = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(this.FKeySort == null)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Welfare_GetBack_Sort) as TConfigValue;
            this.FGetBackSort = _loc4_.Value as Object;
            this.FKeySort = new Array();
            for(_loc6_ in this.FGetBackSort)
            {
               this.FKeySort.push([this.FGetBackSort[_loc6_],_loc6_]);
            }
            this.FKeySort.sort(this.KeySortFun);
         }
         _loc3_ = 0;
         _loc5_ = CONST_DAILYWELFARE.ModuleIndex[param1];
         _loc2_ = 0;
         while(_loc2_ < this.FKeySort.length)
         {
            if(this.FKeySort[_loc2_][1] == _loc5_)
            {
               _loc3_ = uint(this.FKeySort[_loc2_][0]);
               break;
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      protected function OnGetOfflineReward(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DailyGetBackBuyRewardReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeInt(2);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FIsResourcesLoadCompleted)
         {
            this.FWindowSupremeFound.LogicsPerform();
         }
      }
      
      protected function TabClick(param1:Object) : void
      {
         this.SwitchTab(param1 as int);
      }
      
      protected function OnCloseWindow(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         UIHelpTipsHintOnOver(this,this.FHelpTips);
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         UIHelpTipsHintOnOut(this);
      }
      
      protected function CheckEffectSign(param1:Object, param2:Boolean) : void
      {
         if(SLogicsCore.Character.GetMainLevel() < this.FShowDailyWelfareLevel)
         {
            return;
         }
         if(param1 as TProcessorWindowDailyWelfare)
         {
            this.FIsDailyShowSign = param2;
         }
         else if(param1 as TProcessorWindowDailyResourceFound)
         {
            this.FIsResourceShowSign = param2;
         }
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_DailyWelfare,this.FIsDailyShowSign || this.FIsResourceShowSign);
         }
      }
      
      public function get OnEffectSign() : Function
      {
         return this.FOnEffectSign;
      }
      
      public function set OnEffectSign(param1:Function) : void
      {
         this.FOnEffectSign = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.InitWelfare();
         this.FWindowDailyWelfare.CheckRewardType();
         this.FWindowDailyWelfare.DailyWelfareUpdateUI();
         this.FWindowDailyResourceFound.ChechReward();
         this.FWindowDailyResourceFound.DailyWelfareUpdateUI();
         this.FWindowSupremeFound.ChechReward();
         this.FWindowSupremeFound.DailyWelfareUpdateUI();
         this.FScene.MC_EffectLeft.gotoAndPlay(1);
         this.FScene.MC_EffectRight.gotoAndPlay(1);
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
      
      public function LevelUpCheckRewardType() : void
      {
         if(!this.FInitWelfare)
         {
            return;
         }
         this.FWindowDailyWelfare.CheckRewardType();
         this.FWindowDailyWelfare.CheckRewardStatus();
         this.FWindowDailyResourceFound.ChechReward();
         if(Visible)
         {
            this.FWindowDailyWelfare.DailyWelfareUpdateUI();
            this.FWindowDailyResourceFound.DailyWelfareUpdateUI();
         }
      }
      
      public function VipLevelUpCheckRewardStatus() : void
      {
         if(!this.FInitWelfare)
         {
            return;
         }
         this.FWindowDailyWelfare.CheckRewardStatus();
         if(Visible)
         {
            this.FWindowDailyWelfare.DailyWelfareUpdateUI();
         }
      }
   }
}

