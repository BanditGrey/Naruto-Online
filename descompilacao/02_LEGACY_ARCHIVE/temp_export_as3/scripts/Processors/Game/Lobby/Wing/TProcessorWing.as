package Processors.Game.Lobby.Wing
{
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.DatebaseVO.VO.TWingBattleConfig;
   import Logics.SLogicsCore;
   import Logics.Streamization.Wing.TUnstreamizerWing;
   import Logics.TransmigrationTrial.TTrialCampaign;
   import Logics.Wing.TWing;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Processors.Game.Windows.Information.TUIWindowInformation;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_WING;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TRANSMIGRATIONTRIAL;
   import Resources.Strings.STRING_WING;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorWing extends TProcessorLobbyWindows
   {
      
      public static const TAB_COUNT:uint = 4;
      
      public static const TAB_STRENGTHEN:int = 0;
      
      public static const TAB_TRANSFORM:int = 1;
      
      public static const TAB_CAMPAIGN:int = 2;
      
      public static const TAB_STAGE:int = 3;
      
      public static const COIN_STRENGTHEN:int = 1;
      
      public static const GOLD_STRENGTHEN:int = 2;
      
      public static const AUTO_STRENGTHEN:int = 3;
      
      public static const TRANSFORM_WING:int = 4;
      
      public static const UPDATE_WING:int = 5;
      
      public static const HIDE_WING:int = 6;
      
      public static const FIGHT:int = 7;
      
      public static const AUTO_FIGHT:int = 8;
      
      public static const RESET:int = 9;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FWing:TWing;
      
      protected var FUITab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      protected var FHelpTips:THint;
      
      protected var FUnstreamizerWing:TUnstreamizerWing;
      
      protected var FUIWindowInformationSure:TUIWindowInformation;
      
      protected var FArticleBin:TBins;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIWingStrengthen,TUIWingTransform,TUIWingCampaign,TUIWingBattleStage]);
      
      public var OnUpdateWing:Function;
      
      public var SetStatusType:Function;
      
      public var OnInitBattle:Function;
      
      public function TProcessorWing(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FWing = SLogicsCore.Character.Wing;
         this.FUnstreamizerWing = new TUnstreamizerWing();
         this.FUITab = new TUITab(this);
         this.FUIWindowVect = new Vector.<TUIBaseWindow>(TAB_COUNT);
         this.FHelpTips = new THint();
         SetUIModuleID(CONST_MODULES.MODULE_Wing);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_WING.RESOURCESID_Swf_ID);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Class = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_WING.RESOURCE_ClassName_Main) as MovieClip;
         addChild(this.FMC_Scene);
         this.FMC_Scene.x = (FUICore.StageWidth - this.FMC_Scene.width) / 2;
         this.FMC_Scene.y = (FUICore.StageHeight - this.FMC_Scene.height) / 2;
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            _loc2_ = this.ACTIVITY_REFERENCE[_loc1_];
            this.FUIWindowVect[_loc1_] = new _loc2_(this);
            this.FUIWindowVect[_loc1_].Perform_UIDispatch(this.FMC_Scene["MC_Main" + _loc1_]);
            this.FUIWindowVect[_loc1_].OnGetBox = this.ProcessorOnGetBoxClick;
            this.FUIWindowVect[_loc1_].OnBuyBox = ProcessorOnBuyBoxClick;
            this.FUIWindowVect[_loc1_].OnItemOver = UIComponentsHintOnOver;
            this.FUIWindowVect[_loc1_].OnItemOut = UIComponentsHintOnOut;
            this.FUIWindowVect[_loc1_].OnShowHtmlTip = ProcessorOnShowHtmlText;
            this.FUIWindowVect[_loc1_].OnHideHtmlTip = ProcessorOnHideHtmlText;
            this.FUIWindowVect[_loc1_].OnGoto = this.ProcessorOnGotoStage;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT - 1)
         {
            this.FUITab.SetTabByIndex(this.FMC_Scene["BTN_Tab" + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FUIWindowInformationSure = new TUIWindowInformation(this);
         this.FUIWindowInformationSure.x = (FUICore.StageWidth - this.FUIWindowInformationSure.WindowWidth) / 2;
         this.FUIWindowInformationSure.y = (FUICore.StageHeight - this.FUIWindowInformationSure.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowInformation(this.FUIWindowInformationSure);
         this.FUIWindowInformationSure.visible = false;
         this.FArticleBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_Scene["BTN_Close"].addEventListener(MouseEvent.CLICK,this.OnWindowClose);
         this.FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OVER,this.ButtonHelpOnOver);
         this.FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         super.LogicsPerform();
         if(!FIsResourcesLoadCompleted || !Visible)
         {
            return;
         }
         if(Boolean(this.FMC_Scene) && this.FMC_Scene.visible)
         {
            this.FUIWindowVect[this.FChangeTabIndex].LogicsPerform();
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Wing_LoadInfoRet,this.ProcessorOnLoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Wing_CommonRet,this.ProcessorOnCommonRet);
         super.PacketRegisterRoutines();
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            if(_loc1_ == this.FChangeTabIndex)
            {
               this.FUIWindowVect[_loc1_].SetVisible(true);
               this.FUIWindowVect[_loc1_].UpdateUI();
            }
            else
            {
               this.FUIWindowVect[_loc1_].SetVisible(false);
            }
            _loc1_++;
         }
      }
      
      protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Wing_LoadInfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_AllReq(param1:int, param2:Vector.<int> = null) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Wing_CommonReq);
         _loc3_.Data.writeUnsignedInt(param1);
         if(param2 == null)
         {
            _loc3_.Data.writeShort(0);
         }
         else
         {
            _loc6_ = int(param2.length);
            _loc3_.Data.writeShort(_loc6_);
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc3_.Data.writeUnsignedInt(param2[_loc5_]);
               _loc5_++;
            }
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_70170093) as TSystemLanguage;
         this.FHelpTips.Content = _loc2_.Desc;
         UIHelpTipsHintOnOver(this,this.FHelpTips);
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         UIHelpTipsHintOnOut(this);
      }
      
      override protected function ProcessorOnGetBoxClick(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         if(FIsClicked)
         {
            return;
         }
         FIsClicked = true;
         _loc6_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc6_.push(param2);
         }
         _loc6_.push(param3);
         this.PerformPacket_CS_AllReq(param1,_loc6_);
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FChangeTabIndex = param1 as int;
         this.UpdateUI();
      }
      
      protected function OnWindowClose(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function ProcessorOnGotoStage(param1:int, param2:TTrialCampaign = null) : void
      {
         this.FChangeTabIndex = param1;
         if(param1 == TAB_STAGE)
         {
            (this.FUIWindowVect[this.FChangeTabIndex] as TUIWingBattleStage).SetData(param2);
         }
         else if(param1 == TAB_CAMPAIGN)
         {
         }
         this.UpdateUI();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.PerformPacket_CS_LoadInfoReq();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FUIWindowVect[TAB_CAMPAIGN].Unmount();
      }
      
      protected function ProcessorOnLoadInfoRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerWing.Unstreamize(_loc2_,this.FWing,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      protected function ProcessorOnCommonRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         FIsClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc4_)
         {
            case COIN_STRENGTHEN:
               _loc5_ = int(_loc2_.readUnsignedInt());
               _loc6_ = int(_loc2_.readUnsignedInt());
               this.FWing.CurExp = _loc2_.readUnsignedInt();
               this.FWing.WingID = _loc2_.readUnsignedInt();
               this.FWing.CoinPrice = _loc2_.readUnsignedInt();
               this.FWing.CoinCount = _loc2_.readUnsignedInt();
               this.FWing.CoinExp = _loc2_.readUnsignedInt();
               _loc7_ = int(_loc2_.readUnsignedInt());
               _loc8_ = int(_loc2_.readUnsignedInt());
               this.FWing.ColorfulFeather = _loc2_.readUnsignedInt();
               this.FWing.Stone = _loc2_.readUnsignedInt();
               _loc9_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_006 + _loc5_).DescribeString;
               _loc9_ = TUtilityString.Format(_loc9_,_loc6_);
               EffectGenerateText(_loc9_);
               this.UpdateUI();
               break;
            case GOLD_STRENGTHEN:
               _loc5_ = int(_loc2_.readUnsignedInt());
               _loc6_ = int(_loc2_.readUnsignedInt());
               this.FWing.CurExp = _loc2_.readUnsignedInt();
               this.FWing.WingID = _loc2_.readUnsignedInt();
               this.FWing.GoldPrice = _loc2_.readUnsignedInt();
               this.FWing.GoldCount = _loc2_.readUnsignedInt();
               this.FWing.GoldExp = _loc2_.readUnsignedInt();
               _loc7_ = int(_loc2_.readUnsignedInt());
               _loc8_ = int(_loc2_.readUnsignedInt());
               this.FWing.ColorfulFeather = _loc2_.readUnsignedInt();
               this.FWing.Stone = _loc2_.readUnsignedInt();
               _loc9_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_006 + _loc5_).DescribeString;
               _loc9_ = TUtilityString.Format(_loc9_,_loc6_);
               EffectGenerateText(_loc9_);
               this.UpdateUI();
               break;
            case AUTO_STRENGTHEN:
               _loc5_ = int(_loc2_.readUnsignedInt());
               _loc6_ = int(_loc2_.readUnsignedInt());
               this.FWing.CurExp = _loc2_.readUnsignedInt();
               this.FWing.WingID = _loc2_.readUnsignedInt();
               this.FWing.AutoPrice = _loc2_.readUnsignedInt();
               this.FWing.AutoCount = _loc2_.readUnsignedInt();
               this.FWing.AutoExp = _loc2_.readUnsignedInt();
               _loc7_ = int(_loc2_.readUnsignedInt());
               _loc8_ = int(_loc2_.readUnsignedInt());
               this.FWing.ColorfulFeather = _loc2_.readUnsignedInt();
               this.FWing.Stone = _loc2_.readUnsignedInt();
               if(_loc7_ > 0 && _loc8_ > 0)
               {
                  _loc9_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_009).DescribeString;
                  _loc9_ = TUtilityString.Format(_loc9_,_loc7_,_loc8_,_loc6_);
               }
               else if(_loc7_ > 0)
               {
                  _loc9_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_010).DescribeString;
                  _loc9_ = TUtilityString.Format(_loc9_,_loc7_,_loc6_);
               }
               else if(_loc8_ > 0)
               {
                  _loc9_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_011).DescribeString;
                  _loc9_ = TUtilityString.Format(_loc9_,_loc8_,_loc6_);
               }
               else
               {
                  _loc9_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_006).DescribeString;
                  _loc9_ = TUtilityString.Format(_loc9_,_loc6_);
               }
               EffectGenerateText(_loc9_);
               this.UpdateUI();
               break;
            case TRANSFORM_WING:
               this.FWing.TransformID = _loc2_.readUnsignedInt();
               this.FWing.JihuoCnt = _loc2_.readUnsignedInt();
               this.FWing.TransformTime = _loc2_.readUnsignedInt();
               this.FWing.ColorfulFeather = _loc2_.readUnsignedInt();
               this.FWing.Stone = _loc2_.readUnsignedInt();
               _loc9_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_013).DescribeString;
               EffectGenerateText(_loc9_);
               this.FWing.ChangeWingTransformTimeByID(this.FWing.TransformID,this.FWing.TransformTime);
               this.FWing.ChangeWingTransformCountByID(this.FWing.TransformID,this.FWing.JihuoCnt);
               this.UpdateUI();
               if(this.OnUpdateWing != null)
               {
                  this.OnUpdateWing(this.FWing.TransformID,this.FWing.HideWing);
               }
               break;
            case UPDATE_WING:
               this.FWing.TransformID = _loc2_.readUnsignedInt();
               this.FWing.TransformTime = _loc2_.readUnsignedInt();
               if(this.FWing.TransformTime <= STimingCore.GetServerTick())
               {
                  this.FWing.HideWing = 1;
               }
               if(this.OnUpdateWing != null)
               {
                  this.OnUpdateWing(this.FWing.TransformID,this.FWing.HideWing);
               }
               if(FIsResourcesLoadCompleted && this.visible && this.FMC_Scene.visible)
               {
                  this.UpdateUI();
                  break;
               }
               return;
               break;
            case HIDE_WING:
               this.FWing.HideWing = _loc2_.readUnsignedInt();
               if(this.OnUpdateWing != null)
               {
                  if(this.FWing.HideWing == 2)
                  {
                     this.OnUpdateWing(this.FWing.TransformID,this.FWing.HideWing);
                  }
                  else
                  {
                     this.OnUpdateWing(0,this.FWing.HideWing);
                  }
               }
               this.UpdateUI();
               break;
            case FIGHT:
               this.PACKETID_SC_Fight(_loc2_);
               break;
            case AUTO_FIGHT:
               this.PACKETID_SC_AutoFight(_loc2_);
               break;
            case RESET:
               this.PACKETID_SC_Reset(_loc2_);
         }
         ProcessorOnHideHtmlText();
      }
      
      protected function PACKETID_SC_Fight(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TWingBattleConfig = null;
         var _loc4_:TTrialCampaign = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         if(this.SetStatusType != null)
         {
            this.SetStatusType(this,CONST_BATTLE.BattleType_Wing,0);
         }
         if(this.OnInitBattle != null)
         {
            this.OnInitBattle(this);
         }
         this.FWing.ColorfulFeather = param1.readUnsignedInt();
         this.FWing.Stone = param1.readUnsignedInt();
         _loc2_ = param1.readUnsignedInt();
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_WingBattleConfig,_loc2_) as TWingBattleConfig;
         if(_loc3_ == null)
         {
            return;
         }
         _loc4_ = this.FWing.GetTrialCampaignByCampaignId(_loc3_.Location);
         if(_loc4_ != null)
         {
            _loc4_.CurStageId = _loc2_;
         }
      }
      
      protected function PACKETID_SC_AutoFight(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:TWingBattleConfig = null;
         var _loc11_:TTrialCampaign = null;
         _loc8_ = param1.readUnsignedInt();
         _loc9_ = param1.readUnsignedInt();
         if(this.FArticleBin == null)
         {
            this.FArticleBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         }
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_WingBattleConfig,_loc9_) as TWingBattleConfig;
         _loc11_ = this.FWing.GetTrialCampaignByCampaignId(_loc10_.Location);
         if(_loc11_ != null)
         {
            _loc11_.CurStageId = _loc9_;
         }
         _loc7_ = TUtilityString.Format(STRING_TRANSMIGRATIONTRIAL.STRING_REWARDINFO,_loc10_.SStageID);
         _loc3_ = uint(param1.readInt());
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1.readUnsignedInt();
            _loc5_ = param1.readUnsignedInt();
            _loc6_ = param1.readUnsignedInt();
            _loc7_ += STRING_COMMON.GetItemNameByType(_loc4_,_loc5_) + " *" + _loc6_;
            _loc2_++;
         }
         this.FWing.ColorfulFeather = param1.readUnsignedInt();
         this.FWing.Stone = param1.readUnsignedInt();
         this.FUIWindowInformationSure.Text = _loc7_;
         this.FUIWindowInformationSure.Visible = true;
         this.UpdateUI();
      }
      
      protected function PACKETID_SC_Reset(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TTrialCampaign = null;
         _loc2_ = param1.readUnsignedInt();
         _loc3_ = this.FWing.GetTrialCampaignByCampaignId(_loc2_);
         if(_loc3_ != null)
         {
            _loc3_.CurStageId = 0;
            ++_loc3_.TodayResetTimes;
         }
         EffectGenerateText(STRING_TRANSMIGRATIONTRIAL.STRING_ResetSuss);
         this.UpdateUI();
      }
   }
}

