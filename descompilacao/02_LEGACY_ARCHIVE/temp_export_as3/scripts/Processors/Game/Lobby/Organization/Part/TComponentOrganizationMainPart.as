package Processors.Game.Lobby.Organization.Part
{
   import Components.Standard.TUITab;
   import Foundation.Common.Integer.UInt64;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.SensitiveWord.SSensitiveWord;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TOrganizationBase;
   import Logics.Inventories.TInventories;
   import Logics.Organization.TBaseOrganization;
   import Logics.Organization.TBaseOrganizationMember;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Processors.Game.Lobby.Organization.Component.TUIOrgActivityUpgrade;
   import Processors.Game.Lobby.Organization.Part.SecondPart.TCompOrgBags;
   import Processors.Game.Lobby.Organization.Part.SecondPart.TCompOrgCamp;
   import Processors.Game.Lobby.Organization.Part.SecondPart.TCompOrgLogs;
   import Processors.Game.Lobby.Organization.Part.SecondPart.TCompOrgMembers;
   import Processors.Game.Lobby.Organization.TreasureTree.TUITreasureTree;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Input.TUIWindowInputString;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_ORGANIZATION;
   import Resources.Strings.STRING_ORGANIZATION;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TComponentOrganizationMainPart extends TUIComponent
   {
      
      protected static const MAX_TABCOUNT:uint = 5;
      
      public static const STAGE_Width:Number = CONST_ORGANIZATION.STAGE_Width;
      
      public static const STAGE_Height:Number = CONST_ORGANIZATION.STAGE_Height;
      
      protected static const TYPE_ORGACTIVITY_CAMP:uint = 1;
      
      protected static const TYPE_ORGACTIVITY_MUYEGUARD:uint = 2;
      
      protected static const TYPE_ORGACTIVITY_PETBATTLE:uint = 3;
      
      protected static const TYPE_ORGACTIVITY_MUYEBATTLE:uint = 4;
      
      protected var FIsInitialization:Boolean;
      
      protected var FMC:MovieClip;
      
      protected var FMC_OrgCamp:TCompOrgCamp;
      
      protected var FMC_OrgBags:TCompOrgBags;
      
      protected var FMC_OrgMemberList:TCompOrgMembers;
      
      protected var FMC_OrgLogs:TCompOrgLogs;
      
      protected var FUITreasureTree:TUITreasureTree;
      
      protected var FUIWindow_InputString:TUIWindowInputString;
      
      protected var FMC_OrgActivityInfo:MovieClip;
      
      protected var FMC_OrgActivityPic:MovieClip;
      
      protected var FMC_Award_0:MovieClip;
      
      protected var FMC_Award_1:MovieClip;
      
      protected var FMC_OrgActivityUpgrade:TUIOrgActivityUpgrade;
      
      protected var FTF_OrgName:TextField;
      
      protected var FTF_LeaderName:TextField;
      
      protected var FTF_OrgLevel:TextField;
      
      protected var FTF_OrgMoney:TextField;
      
      protected var FTF_OrgMember:TextField;
      
      protected var FTF_OrgContribution:TextField;
      
      protected var FTF_OrgExploit:TextField;
      
      protected var FTF_OrgNotice:TextField;
      
      protected var FTF_OrgActivityInfo:TextField;
      
      protected var FTF_OrgQuitBtnCaption:TextField;
      
      protected var FMC_Farmliy:MovieClip;
      
      protected var FMC_ApplyCount:Sprite;
      
      protected var FBtn_Donate:MovieClip;
      
      protected var FBtn_AdjustNotice:MovieClip;
      
      protected var FBtn_GotoOrgList:MovieClip;
      
      protected var FBtn_GotoPower:MovieClip;
      
      protected var FBtn_ApplyList:MovieClip;
      
      protected var FBtn_SwitchPower:MovieClip;
      
      protected var FBtn_QuitOrg:MovieClip;
      
      protected var FTab_Org:TUITab;
      
      protected var FBtn_TabCamp:MovieClip;
      
      protected var FBtn_TabMember:MovieClip;
      
      protected var FBtn_TabLog:MovieClip;
      
      protected var FBtn_TabOrgBag:MovieClip;
      
      protected var FBtn_TabOrgTree:MovieClip;
      
      protected var FChangeTabIndex:int;
      
      protected var FTabVect:Vector.<MovieClip>;
      
      protected var FOrgBaseInfo:TBaseOrganization;
      
      protected var FOrgActivityType:uint;
      
      protected var FOrgApplyListCount:uint;
      
      protected var FHint:THint;
      
      protected var FUIWindow_Confirm:TUIWindowConfirmation;
      
      protected var FOrgDonateStatus:Boolean;
      
      protected var FOrgTreeStatus:Boolean;
      
      protected var FEffectsBaseGlowTab:TEffectBaseGlow;
      
      protected var FEffectsBaseGlowBtn:TEffectBaseGlow;
      
      protected var FEffectsBaseGlowBtn2:TEffectBaseGlow;
      
      protected var FClickCampActivityOk:Function;
      
      protected var FClickBtnDonate:Function;
      
      protected var FClickBtnOrgList:Function;
      
      protected var FClickBtnGotoPower:Function;
      
      protected var FClickBtnApplyList:Function;
      
      protected var FClickBtnSwitchPowerList:Function;
      
      protected var FClickBtnQuitOrg:Function;
      
      protected var FDataMembersVect:Vector.<TBaseOrganizationMember>;
      
      protected var FOnAwardOver:Function;
      
      protected var FOnAwardOut:Function;
      
      protected var FOnActivityOver:Function;
      
      protected var FOnActivityOut:Function;
      
      protected var FOnOrgBagEffectGenerateText:Function;
      
      protected var FOnShowHeroInfo:Function;
      
      protected var FOnChatWhisper:Function;
      
      protected var FOnInterpersonalRelationships:Function;
      
      protected var FOverHintUpgradeBtn:Function;
      
      protected var FOutHintUpgradeBtn:Function;
      
      protected var FUpdateBaseOrganization:Function;
      
      protected var FOnUserFruitFastMature:Function;
      
      protected var FPickFruitOnClick:Function;
      
      protected var FWaterOrgMemberOnClick:Function;
      
      protected var FPushChakraOnClick:Function;
      
      protected var FAddChakraTimesOnClick:Function;
      
      protected var FFastOnClick:Function;
      
      protected var FOnEffectText:Function;
      
      protected var FTutorialNextStep:Function;
      
      protected var FOneKeyWatersClisk:Function;
      
      public function TComponentOrganizationMainPart(param1:TUIComponent)
      {
         super(param1);
         this.FMC_OrgCamp = new TCompOrgCamp(this);
         this.FMC_OrgMemberList = new TCompOrgMembers(this);
         this.FMC_OrgLogs = new TCompOrgLogs(this);
         this.FMC_OrgBags = new TCompOrgBags(this);
         this.FUITreasureTree = new TUITreasureTree(this);
         this.FMC_OrgActivityUpgrade = new TUIOrgActivityUpgrade(this);
         this.FTab_Org = new TUITab(this);
         this.FChangeTabIndex = 0;
         this.FTabVect = new Vector.<MovieClip>();
      }
      
      public function set UpdateBaseOrganization(param1:Function) : void
      {
         this.FUpdateBaseOrganization = param1;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.FMC = param1;
         addChild(this.FMC);
         setChildIndex(this.FMC,0);
         this.FMC_OrgCamp.Perform_UIDispatch(this.FMC[CONST_ORGANIZATION.RESOURCE_Link_MC_Camp]);
         this.FMC_OrgCamp.x = 50;
         this.FMC_OrgCamp.y = 61;
         this.FMC_OrgCamp.ClickActivityOk = this.MCCampOnActivityOkClick;
         this.FMC_OrgCamp.ClickActivityUpLv = this.MCCampOnActivityUpLvClick;
         this.FMC_OrgCamp.OnActivityOver = this.OnActivityMouseOver;
         this.FMC_OrgCamp.OnActivityOut = this.OnActivityMouseOut;
         this.FMC_OrgMemberList.Perform_UIDispatch(this.FMC[CONST_ORGANIZATION.RESOURCE_Link_MC_OrgMemberList]);
         this.FMC_OrgMemberList.x = 50;
         this.FMC_OrgMemberList.y = 60;
         this.FMC_OrgMemberList.EffectText = this.FOnOrgBagEffectGenerateText;
         this.FMC_OrgMemberList.OnChatWhisper = this.ProcessorOnChatWhisper;
         this.FMC_OrgMemberList.OnShowHeroInfo = this.ProcessorOnShowHeroInfo;
         this.FMC_OrgMemberList.OnInterpersonalRelationships = this.ProcessorOnInterpersonalRelationships;
         this.FMC_OrgLogs.Perform_UIDispatch(this.FMC[CONST_ORGANIZATION.RESOURCE_Link_MC_OrgLogs]);
         this.FMC_OrgLogs.x = 50;
         this.FMC_OrgLogs.y = 60;
         this.FMC_OrgBags.Perform_UIDispatch(this.FMC[CONST_ORGANIZATION.RESOURCE_Link_MC_OrgBags]);
         this.FMC_OrgBags.EffectGenerateText = this.OrgBagEffectGenerateText;
         this.FMC_OrgBags.x = 50;
         this.FMC_OrgBags.y = 60;
         this.FUITreasureTree.Perform_UIDispatch(this.FMC["MC_TreasureTree"]);
         this.FUITreasureTree.UserFruitFastMature = this.ProcessorUserFruitFastMature;
         this.FUITreasureTree.PickFruitOnClick = this.ProcessorPickFruitOnClick;
         this.FUITreasureTree.WaterOrgMemberOnClick = this.ProcessorWaterOrgMemberOnClick;
         this.FUITreasureTree.KeyWatersClisk = this.KeyWatersClisk;
         this.FUITreasureTree.PushChakraOnClick = this.ProcessorPushChakraOnClick;
         this.FUITreasureTree.AddChakraTimesOnClick = this.ProcessorAddChakraTimesOnClick;
         this.FUITreasureTree.FastOnClick = this.ProcessorFastOnClick;
         this.FUITreasureTree.OnEffectText = this.ProcessorOnEffectText;
         this.FUITreasureTree.x = 50;
         this.FUITreasureTree.y = 60;
         this.FMC_OrgCamp.Visible = true;
         this.FMC_OrgMemberList.Visible = false;
         this.FMC_OrgLogs.Visible = false;
         this.FMC_OrgBags.Visible = false;
         this.FUITreasureTree.Visible = false;
         _loc3_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_ORGANIZATION.RESOURCE_ClassName_MC_OrgUpLevel) as MovieClip;
         this.FMC_OrgActivityUpgrade.Perform_UIDispatch(_loc3_);
         this.FMC_OrgActivityUpgrade.Visible = false;
         this.FMC_OrgActivityUpgrade.ClickBtnCancel = this.OnUpGradeCancelClick;
         this.FMC_OrgActivityUpgrade.OverHintUpgradeBtn = this.OnHintOverUpgradeBtn;
         this.FMC_OrgActivityUpgrade.OutHintUpgradeBtn = this.OnHintOutUpgradeBtn;
         this.FBtn_TabCamp = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_TabCamp];
         this.FBtn_TabMember = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_TabMember];
         this.FBtn_TabLog = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_TabLog];
         this.FBtn_TabOrgBag = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_TabOrgBag];
         this.FBtn_TabOrgTree = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_TabOrgTree];
         this.FTabVect.push(this.FBtn_TabCamp);
         this.FTabVect.push(this.FBtn_TabMember);
         this.FTabVect.push(this.FBtn_TabLog);
         this.FTabVect.push(this.FBtn_TabOrgBag);
         this.FTabVect.push(this.FBtn_TabOrgTree);
         _loc2_ = 0;
         while(_loc2_ < MAX_TABCOUNT)
         {
            this.FTab_Org.SetTabByIndex(this.FTabVect[_loc2_],_loc2_);
            _loc2_++;
         }
         this.FTab_Org.OnSwitch = this.ChangeTabOnSwitch;
         this.FTab_Org.OnOver = this.ProcessorTabOnOver;
         this.FTab_Org.OnOut = this.ProcessorTabOnOut;
         this.FTab_Org.Init();
         this.FTab_Org.SetTabEnabledByIndex(MAX_TABCOUNT - 1,false);
         this.FBtn_Donate = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_Donate];
         this.FBtn_AdjustNotice = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_AdjustNotice];
         this.FBtn_GotoOrgList = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_GotoOrgList];
         this.FBtn_GotoPower = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_GotoPower];
         this.FBtn_ApplyList = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_ApplyList];
         this.FBtn_SwitchPower = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_SwitchPower];
         this.FBtn_QuitOrg = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_QuitOrg];
         this.FTF_OrgQuitBtnCaption = this.FBtn_QuitOrg["TF_Caption"];
         TGameUtil.setButtonMode(this.FBtn_Donate,true);
         TGameUtil.setButtonMode(this.FBtn_AdjustNotice,true);
         TGameUtil.setButtonMode(this.FBtn_GotoOrgList,true);
         TGameUtil.setButtonMode(this.FBtn_GotoPower,true);
         TGameUtil.setButtonMode(this.FBtn_ApplyList,true);
         TGameUtil.setButtonMode(this.FBtn_SwitchPower,true);
         TGameUtil.setButtonMode(this.FBtn_QuitOrg,true);
         this.FBtn_Donate.addEventListener(MouseEvent.CLICK,this.OnOrgDonateClick);
         this.FBtn_AdjustNotice.addEventListener(MouseEvent.CLICK,this.OnOrgAdjustNoticeClick);
         this.FBtn_GotoOrgList.addEventListener(MouseEvent.CLICK,this.OnOrgGotoOrgListClick);
         this.FBtn_GotoPower.addEventListener(MouseEvent.CLICK,this.OnOrgGotoPowerClick);
         this.FBtn_ApplyList.addEventListener(MouseEvent.CLICK,this.OnOrgApplyListClick);
         this.FBtn_SwitchPower.addEventListener(MouseEvent.CLICK,this.OnOrgSwitchPowerClick);
         this.FBtn_QuitOrg.addEventListener(MouseEvent.CLICK,this.OnOrgQuitOrgClick);
         this.FHint = new THint();
         this.FMC_Farmliy = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_MC_Farmliy];
         this.FTF_OrgName = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_TF_OrgName];
         this.FTF_LeaderName = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_TF_LeaderName];
         this.FTF_OrgLevel = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_TF_OrgLevel];
         this.FTF_OrgMoney = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_TF_OrgMoney];
         this.FTF_OrgMember = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_TF_OrgMember];
         this.FTF_OrgContribution = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_TF_OrgContribution];
         this.FTF_OrgExploit = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_TF_OrgExploit];
         this.FTF_OrgNotice = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_TF_OrgNotice];
         this.FMC_ApplyCount = this.FMC["MC_ApplyCount"];
         this.FMC_Award_0 = this.FMC["MC_Award_0"];
         this.FMC_Award_1 = this.FMC["MC_Award_1"];
         this.FMC_Award_0.gotoAndStop(1);
         this.FMC_Award_1.gotoAndStop(2);
         this.FMC_Award_0.addEventListener(MouseEvent.MOUSE_MOVE,this.OnAwardMouseMove);
         this.FMC_Award_0.addEventListener(MouseEvent.MOUSE_OUT,this.OnAwardMouseOut);
         this.FMC_Award_1.addEventListener(MouseEvent.MOUSE_MOVE,this.OnAwardMouseMove);
         this.FMC_Award_1.addEventListener(MouseEvent.MOUSE_OUT,this.OnAwardMouseOut);
         this.FUIWindow_InputString = new TUIWindowInputString(this);
         this.FUIWindow_InputString.OnOK = this.FUIWindow_InputStringOnOk;
         this.FUIWindow_InputString.OnCancel = this.FUIWindow_InputStringOnCancel;
         this.FUIWindow_InputString.EditorString = STRING_ORGANIZATION.STRING_LimitNoticeWord;
         TUtilityUIWindow.SetupWindowInputString(this.FUIWindow_InputString);
         this.FUIWindow_InputString.x = (STAGE_Width - this.FUIWindow_InputString.WindowWidth) / 2;
         this.FUIWindow_InputString.y = (STAGE_Height - this.FUIWindow_InputString.WindowHeight) / 2;
         this.FUIWindow_InputString.Visible = false;
         this.FUIWindow_Confirm = new TUIWindowConfirmation(this);
         this.FUIWindow_Confirm.x = (STAGE_Width - this.FUIWindow_Confirm.WindowWidth) / 2;
         this.FUIWindow_Confirm.y = (STAGE_Height - this.FUIWindow_Confirm.WindowHeight) / 2;
         this.FUIWindow_Confirm.OnCancel = this.UIWindowComfirm_OnCancel;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindow_Confirm);
         this.FUIWindow_Confirm.Visible = false;
         this.FEffectsBaseGlowTab = new TEffectBaseGlow();
         this.FEffectsBaseGlowTab.SetParameters(this.FBtn_TabOrgTree,15911245,1);
         this.FEffectsBaseGlowTab.visible = false;
         this.FEffectsBaseGlowBtn = new TEffectBaseGlow();
         this.FEffectsBaseGlowBtn.SetParameters(this.FBtn_Donate,15911245,1);
         this.FEffectsBaseGlowBtn.visible = false;
         this.FEffectsBaseGlowBtn2 = new TEffectBaseGlow();
         this.FEffectsBaseGlowBtn2.SetParameters(this.FBtn_ApplyList,15911245,1);
         this.FEffectsBaseGlowBtn2.visible = false;
      }
      
      protected function UpDateUI() : void
      {
         var _loc1_:TBins = null;
         var _loc2_:TOrganizationBase = null;
         _loc1_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_OrganizationBase);
         _loc2_ = _loc1_.GetDatebaseByIndex(this.FOrgBaseInfo.OrgLevel - 1) as TOrganizationBase;
         this.FMC_Farmliy.gotoAndStop(this.FOrgBaseInfo.OrgFamily > 0 ? this.FOrgBaseInfo.OrgFamily : 1);
         this.FTF_OrgName.text = this.FOrgBaseInfo.OrgName;
         this.FTF_LeaderName.text = this.FOrgBaseInfo.MasterName;
         this.FTF_OrgLevel.text = String(this.FOrgBaseInfo.OrgLevel);
         this.FTF_OrgMoney.text = String(this.FOrgBaseInfo.OrgMoney);
         this.FTF_OrgMember.text = this.FOrgBaseInfo.OrgMembers + "/" + _loc2_.OrgMaxNumber;
         this.FTF_OrgContribution.text = String(this.FOrgBaseInfo.OrgContribution);
         this.FTF_OrgExploit.text = this.FOrgBaseInfo.OrgExploit.ToString();
         this.FTF_OrgNotice.text = String(this.FOrgBaseInfo.OrgNotice);
         TextField(this.FMC_ApplyCount["TXT_ApplyCount"]).text = String(this.FOrgApplyListCount);
         if(this.FOrgBaseInfo.OrgPower != 2)
         {
            this.FTF_OrgQuitBtnCaption.text = STRING_ORGANIZATION.STRING_QuitOrg;
         }
         else
         {
            this.FTF_OrgQuitBtnCaption.text = STRING_ORGANIZATION.STRING_DismissOrg;
         }
         if(_loc2_.GetMoreExp > 0)
         {
            this.FMC_Award_0.gotoAndStop(1);
            this.FMC_Award_0.visible = true;
         }
         if(_loc2_.GetMoreSiv > 0)
         {
            this.FMC_Award_1.gotoAndStop(2);
            this.FMC_Award_1.visible = true;
         }
         if(this.FOrgBaseInfo.OrgPower == 0)
         {
            this.FBtn_AdjustNotice.visible = false;
            this.FBtn_ApplyList.visible = false;
            this.FBtn_SwitchPower.visible = false;
            this.FMC_ApplyCount.visible = false;
         }
         else if(this.FOrgBaseInfo.OrgPower == 1)
         {
            this.FBtn_AdjustNotice.visible = true;
            this.FBtn_ApplyList.visible = true;
            this.FBtn_SwitchPower.visible = false;
            this.FMC_ApplyCount.visible = Boolean(this.FOrgApplyListCount > 0);
         }
         else
         {
            this.FBtn_AdjustNotice.visible = true;
            this.FBtn_ApplyList.visible = true;
            this.FBtn_SwitchPower.visible = true;
            this.FMC_ApplyCount.visible = Boolean(this.FOrgApplyListCount > 0);
         }
         this.FMC_OrgCamp.UpData(this.FOrgBaseInfo);
         this.FMC_OrgCamp.UpDateUI();
         this.FUpdateBaseOrganization(this.FOrgBaseInfo);
         if(this.FOrgBaseInfo.OrgLevel >= 5)
         {
            this.FTab_Org.SetTabOpenByIndex(MAX_TABCOUNT - 1,true);
         }
         else
         {
            this.FTab_Org.SetTabEnabledByIndex(MAX_TABCOUNT - 1,false);
         }
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = param1 as int;
         if(_loc3_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc3_;
         switch(this.FChangeTabIndex)
         {
            case 0:
               this.FMC_OrgCamp.Visible = true;
               this.FMC_OrgMemberList.Visible = false;
               this.FMC_OrgLogs.Visible = false;
               this.FMC_OrgBags.Visible = false;
               this.FUITreasureTree.Visible = false;
               break;
            case 1:
               this.FMC_OrgCamp.Visible = false;
               this.FMC_OrgMemberList.Visible = true;
               this.FMC_OrgLogs.Visible = false;
               this.FMC_OrgBags.Visible = false;
               this.FUITreasureTree.Visible = false;
               _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_LoadMemberListReq);
               SNetworkCore.Transceiver.PacketTransmit(_loc2_);
               break;
            case 2:
               this.FMC_OrgCamp.Visible = false;
               this.FMC_OrgMemberList.Visible = false;
               this.FMC_OrgLogs.Visible = true;
               this.FMC_OrgBags.Visible = false;
               this.FUITreasureTree.Visible = false;
               this.FMC_OrgLogs.UpDateUI();
               _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_GuildLogReq);
               SNetworkCore.Transceiver.PacketTransmit(_loc2_);
               break;
            case 3:
               this.FMC_OrgCamp.Visible = false;
               this.FMC_OrgMemberList.Visible = false;
               this.FMC_OrgLogs.Visible = false;
               this.FMC_OrgBags.Visible = true;
               this.FUITreasureTree.Visible = false;
               _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_LoadGulidDepotReq);
               SNetworkCore.Transceiver.PacketTransmit(_loc2_);
               break;
            case 4:
               this.FMC_OrgCamp.Visible = false;
               this.FMC_OrgMemberList.Visible = false;
               this.FMC_OrgLogs.Visible = false;
               this.FMC_OrgBags.Visible = false;
               this.FUITreasureTree.Visible = true;
               _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_ShowReq);
               _loc2_.Data.writeUnsignedInt(1);
               SNetworkCore.Transceiver.PacketTransmit(_loc2_);
               if(this.FTutorialNextStep != null)
               {
                  this.FTutorialNextStep(2402);
               }
         }
         if(this.FChangeTabIndex != 4)
         {
            this.FUITreasureTree.Reset();
         }
      }
      
      protected function ProcessorTabOnOver(param1:Object, param2:int, param3:Boolean) : void
      {
         if(param2 != MAX_TABCOUNT - 1 || this.FOrgBaseInfo.OrgLevel >= 5)
         {
            return;
         }
         this.FHint.Caption = STRING_ORGANIZATION.STRING_OrgLevelFiveOpen;
         if(this.FOnAwardOver != null)
         {
            this.FOnAwardOver(this,this.FHint);
         }
      }
      
      protected function ProcessorTabOnOut(param1:Object, param2:int, param3:Boolean) : void
      {
         if(this.FOnAwardOut != null)
         {
            this.FOnAwardOut(this);
         }
      }
      
      protected function MCCampOnActivityOkClick(param1:Object, param2:uint, param3:uint) : void
      {
         if(this.FClickCampActivityOk == null)
         {
            return;
         }
         this.FClickCampActivityOk(param1,param2,param3);
      }
      
      protected function MCCampOnActivityUpLvClick(param1:Object, param2:uint) : void
      {
         switch(param2)
         {
            case TYPE_ORGACTIVITY_CAMP:
               this.FMC_OrgActivityUpgrade.UpData(TYPE_ORGACTIVITY_CAMP,this.FOrgBaseInfo);
               break;
            case TYPE_ORGACTIVITY_MUYEGUARD:
               this.FMC_OrgActivityUpgrade.UpData(TYPE_ORGACTIVITY_MUYEGUARD,this.FOrgBaseInfo);
               break;
            case TYPE_ORGACTIVITY_PETBATTLE:
               this.FMC_OrgActivityUpgrade.UpData(TYPE_ORGACTIVITY_PETBATTLE,this.FOrgBaseInfo);
               break;
            case TYPE_ORGACTIVITY_MUYEBATTLE:
               this.FMC_OrgActivityUpgrade.UpData(TYPE_ORGACTIVITY_MUYEBATTLE,this.FOrgBaseInfo);
         }
         this.FMC_OrgActivityUpgrade.UpDateUI();
         this.FMC_OrgActivityUpgrade.Visible = true;
      }
      
      protected function OnUpGradeCancelClick(param1:Object) : void
      {
         this.FMC_OrgActivityUpgrade.Visible = false;
      }
      
      protected function OnHintOverUpgradeBtn(param1:Object, param2:THint) : void
      {
         if(this.FOverHintUpgradeBtn != null)
         {
            this.FOverHintUpgradeBtn(param1,param2);
         }
      }
      
      protected function OnHintOutUpgradeBtn(param1:Object) : void
      {
         if(this.FOutHintUpgradeBtn != null)
         {
            this.FOutHintUpgradeBtn(param1);
         }
      }
      
      protected function OnOrgDonateClick(param1:MouseEvent) : void
      {
         if(this.FClickBtnDonate == null)
         {
            return;
         }
         this.FClickBtnDonate(this);
      }
      
      protected function OnOrgAdjustNoticeClick(param1:MouseEvent) : void
      {
         this.FUIWindow_InputString.Visible = true;
      }
      
      protected function OnOrgGotoOrgListClick(param1:MouseEvent) : void
      {
         if(this.FClickBtnOrgList == null)
         {
            return;
         }
         this.FClickBtnOrgList(this,true);
      }
      
      protected function OnOrgGotoPowerClick(param1:MouseEvent) : void
      {
         if(this.FClickBtnGotoPower == null)
         {
            return;
         }
         this.FClickBtnGotoPower(this);
      }
      
      protected function OnOrgApplyListClick(param1:MouseEvent) : void
      {
         if(this.FClickBtnApplyList == null)
         {
            return;
         }
         this.FClickBtnApplyList(this,1);
      }
      
      protected function OnOrgSwitchPowerClick(param1:MouseEvent) : void
      {
         if(this.FClickBtnSwitchPowerList == null)
         {
            return;
         }
         this.FClickBtnSwitchPowerList(this,2);
      }
      
      protected function OnOrgQuitOrgClick(param1:MouseEvent) : void
      {
         this.FUIWindow_Confirm.OnOK = this.UIWindowConfirm_OnQuitOrgOk;
         if(this.FOrgBaseInfo.OrgPower == 2)
         {
            this.FUIWindow_Confirm.Text = STRING_ORGANIZATION.STRING_ConfirmDismissOrgText;
         }
         else
         {
            this.FUIWindow_Confirm.Text = STRING_ORGANIZATION.STRING_ConfirmQuitOrgText;
         }
         this.FUIWindow_Confirm.Visible = true;
      }
      
      protected function FUIWindow_InputStringOnOk(param1:Object, param2:String) : void
      {
         var _loc3_:String = null;
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         if(param2 != null)
         {
            _loc3_ = SSensitiveWord.Filter(param2);
            _loc3_.substr(0,90);
            _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_BoardModifyReq);
            _loc5_ = _loc4_.Data;
            TUtilityString.FlushUTF(_loc5_,_loc3_);
            SNetworkCore.Transceiver.PacketTransmit(_loc4_);
            this.FUIWindow_InputString.Visible = false;
         }
      }
      
      protected function FUIWindow_InputStringOnCancel(param1:Object) : void
      {
         this.FUIWindow_InputString.Visible = false;
      }
      
      protected function UIWindowConfirm_OnQuitOrgOk(param1:Object) : void
      {
         if(this.FClickBtnQuitOrg == null)
         {
            return;
         }
         this.FClickBtnQuitOrg(this);
      }
      
      protected function UIWindowComfirm_OnCancel(param1:Object) : void
      {
         this.FUIWindow_Confirm.Visible = false;
      }
      
      protected function OnAwardMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:TBins = null;
         var _loc3_:TOrganizationBase = null;
         _loc2_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_OrganizationBase);
         _loc3_ = _loc2_.GetDatebaseByIndex(this.FOrgBaseInfo.OrgLevel - 1) as TOrganizationBase;
         if(this.FOnAwardOver == null)
         {
            return;
         }
         if(param1.currentTarget.name == "MC_Award_0")
         {
            this.FHint.Caption = STRING_ORGANIZATION.STRING_ExpAdditionText + _loc3_.GetMoreExp / 10 + "%";
            this.FOnAwardOver(this,this.FHint);
         }
         else
         {
            this.FHint.Caption = STRING_ORGANIZATION.STRING_MoneyAdditionText + _loc3_.GetMoreSiv / 10 + "%";
            this.FOnAwardOver(this,this.FHint);
         }
      }
      
      protected function OnAwardMouseOut(param1:MouseEvent) : void
      {
         if(this.FOnAwardOut == null)
         {
            return;
         }
         this.FOnAwardOut(this);
      }
      
      protected function OnActivityMouseOver(param1:Object, param2:uint) : void
      {
         var _loc3_:TBins = null;
         var _loc4_:TOrganizationBase = null;
         _loc3_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_OrganizationBase);
         if(this.FOnActivityOver != null)
         {
            if(param2 == TYPE_ORGACTIVITY_MUYEBATTLE)
            {
               _loc4_ = _loc3_.GetDatebaseByIndex(this.FOrgBaseInfo.GetOrgActivityLevelByType(TYPE_ORGACTIVITY_MUYEBATTLE) - 1) as TOrganizationBase;
               this.FHint.Caption = STRING_ORGANIZATION.STRING_MuyeBattleAdditionPrompt + "\n" + STRING_ORGANIZATION.STRING_AllPlayerAttack + _loc4_.MuyebattleUpgradeAddition / 10 + "%";
               this.FOnActivityOver(param1,this.FHint);
            }
            else if(param2 == TYPE_ORGACTIVITY_MUYEGUARD)
            {
               _loc4_ = _loc3_.GetDatebaseByIndex(this.FOrgBaseInfo.GetOrgActivityLevelByType(TYPE_ORGACTIVITY_MUYEGUARD) - 1) as TOrganizationBase;
               this.FHint.Caption = STRING_ORGANIZATION.STRING_MuyeGuardAdditionPrompt + "\n" + STRING_ORGANIZATION.STRING_AllPlayerHP + _loc4_.MuyeguardUpgradeAddition / 10 + "%";
               this.FOnActivityOver(param1,this.FHint);
            }
         }
      }
      
      protected function OnActivityMouseOut(param1:Object) : void
      {
         if(this.FOnActivityOut != null)
         {
            this.FOnActivityOut(param1);
         }
      }
      
      protected function OrgBagEffectGenerateText(param1:Object, param2:String) : void
      {
         if(this.FOnOrgBagEffectGenerateText != null)
         {
            this.FOnOrgBagEffectGenerateText(param2,null,null);
         }
      }
      
      protected function ProcessorOnShowHeroInfo(param1:Object, param2:uint, param3:uint) : void
      {
         this.FOnShowHeroInfo(param1,param2,param3);
      }
      
      protected function ProcessorOnChatWhisper(param1:Object, param2:Object) : void
      {
         this.FOnChatWhisper(param1,param2);
      }
      
      protected function ProcessorOnInterpersonalRelationships(param1:Object, param2:uint, param3:Object) : void
      {
         this.FOnInterpersonalRelationships(param1,param2,param3);
      }
      
      protected function ProcessorUserFruitFastMature(param1:Object, param2:int, param3:uint) : void
      {
         if(this.FOnUserFruitFastMature != null)
         {
            this.FOnUserFruitFastMature(this,param2,param3);
         }
      }
      
      protected function ProcessorPickFruitOnClick(param1:Object, param2:int) : void
      {
         if(this.FPickFruitOnClick != null)
         {
            this.FPickFruitOnClick(this,param2);
         }
      }
      
      protected function ProcessorWaterOrgMemberOnClick(param1:Object, param2:uint, param3:uint) : void
      {
         if(this.FWaterOrgMemberOnClick != null)
         {
            this.FWaterOrgMemberOnClick(this,param2,param3);
         }
      }
      
      protected function KeyWatersClisk() : void
      {
         if(this.FOneKeyWatersClisk != null)
         {
            this.FOneKeyWatersClisk();
         }
      }
      
      protected function ProcessorPushChakraOnClick(param1:Object) : void
      {
         if(this.FPushChakraOnClick != null)
         {
            this.FPushChakraOnClick(this);
         }
      }
      
      protected function ProcessorAddChakraTimesOnClick(param1:Object) : void
      {
         if(this.FAddChakraTimesOnClick != null)
         {
            this.FAddChakraTimesOnClick(this);
         }
      }
      
      protected function ProcessorFastOnClick(param1:Object) : void
      {
         if(this.FFastOnClick != null)
         {
            this.FFastOnClick(this);
         }
      }
      
      protected function ProcessorOnEffectText(param1:String) : void
      {
         if(this.FOnEffectText != null)
         {
            this.FOnEffectText(param1);
         }
      }
      
      protected function UpdateEffectsGlow() : void
      {
         if(this.FEffectsBaseGlowBtn != null)
         {
            if(this.FOrgDonateStatus)
            {
               this.FEffectsBaseGlowBtn.Run();
               this.FEffectsBaseGlowBtn.visible = true;
            }
            else
            {
               this.FEffectsBaseGlowBtn.Stop();
               this.FEffectsBaseGlowBtn.visible = false;
            }
         }
         if(this.FEffectsBaseGlowTab != null)
         {
            if(this.FOrgTreeStatus)
            {
               this.FEffectsBaseGlowTab.Run();
               this.FEffectsBaseGlowTab.visible = true;
            }
            else
            {
               this.FEffectsBaseGlowTab.Stop();
               this.FEffectsBaseGlowTab.visible = false;
            }
         }
         if(this.FEffectsBaseGlowBtn2 != null)
         {
            if(this.FOrgApplyListCount > 0)
            {
               this.FEffectsBaseGlowBtn2.Run();
               this.FEffectsBaseGlowBtn2.visible = true;
            }
            else
            {
               this.FEffectsBaseGlowBtn2.Stop();
               this.FEffectsBaseGlowBtn2.visible = false;
            }
         }
      }
      
      public function get ClickCampActivityOk() : Function
      {
         return this.FClickCampActivityOk;
      }
      
      public function set ClickCampActivityOk(param1:Function) : void
      {
         this.FClickCampActivityOk = param1;
      }
      
      public function get ClickBtnDonate() : Function
      {
         return this.FClickBtnDonate;
      }
      
      public function set ClickBtnDonate(param1:Function) : void
      {
         this.FClickBtnDonate = param1;
      }
      
      public function get ClickBtnOrgList() : Function
      {
         return this.FClickBtnOrgList;
      }
      
      public function set ClickBtnOrgList(param1:Function) : void
      {
         this.FClickBtnOrgList = param1;
      }
      
      public function get ClickBtnGotoPower() : Function
      {
         return this.FClickBtnGotoPower;
      }
      
      public function set ClickBtnGotoPower(param1:Function) : void
      {
         this.FClickBtnGotoPower = param1;
      }
      
      public function get ClickBtnApplyList() : Function
      {
         return this.FClickBtnApplyList;
      }
      
      public function set ClickBtnApplyList(param1:Function) : void
      {
         this.FClickBtnApplyList = param1;
      }
      
      public function get ClickBtnSwitchPowerList() : Function
      {
         return this.FClickBtnSwitchPowerList;
      }
      
      public function set ClickBtnSwitchPowerList(param1:Function) : void
      {
         this.FClickBtnSwitchPowerList = param1;
      }
      
      public function get ClickBtnQuitOrg() : Function
      {
         return this.FClickBtnQuitOrg;
      }
      
      public function set ClickBtnQuitOrg(param1:Function) : void
      {
         this.FClickBtnQuitOrg = param1;
      }
      
      public function get DataMembersVect() : Vector.<TBaseOrganizationMember>
      {
         return this.FDataMembersVect;
      }
      
      public function set DataMembersVect(param1:Vector.<TBaseOrganizationMember>) : void
      {
         this.FDataMembersVect = param1;
      }
      
      public function get OnAwardOver() : Function
      {
         return this.FOnAwardOver;
      }
      
      public function set OnAwardOver(param1:Function) : void
      {
         this.FOnAwardOver = param1;
      }
      
      public function get OnAwardOut() : Function
      {
         return this.FOnAwardOut;
      }
      
      public function set OnAwardOut(param1:Function) : void
      {
         this.FOnAwardOut = param1;
      }
      
      public function get OnActivityOver() : Function
      {
         return this.FOnActivityOver;
      }
      
      public function set OnActivityOver(param1:Function) : void
      {
         this.FOnActivityOver = param1;
      }
      
      public function get OnActivityOut() : Function
      {
         return this.FOnActivityOut;
      }
      
      public function set OnActivityOut(param1:Function) : void
      {
         this.FOnActivityOut = param1;
      }
      
      public function get OnOrgBagEffectGenerateText() : Function
      {
         return this.FOnOrgBagEffectGenerateText;
      }
      
      public function set OnOrgBagEffectGenerateText(param1:Function) : void
      {
         this.FOnOrgBagEffectGenerateText = param1;
      }
      
      public function get OnShowHeroInfo() : Function
      {
         return this.FOnShowHeroInfo;
      }
      
      public function set OnShowHeroInfo(param1:Function) : void
      {
         this.FOnShowHeroInfo = param1;
      }
      
      public function get OnChatWhisper() : Function
      {
         return this.FOnChatWhisper;
      }
      
      public function set OnChatWhisper(param1:Function) : void
      {
         this.FOnChatWhisper = param1;
      }
      
      public function get OnInterpersonalRelationships() : Function
      {
         return this.FOnInterpersonalRelationships;
      }
      
      public function set OnInterpersonalRelationships(param1:Function) : void
      {
         this.FOnInterpersonalRelationships = param1;
      }
      
      public function get OutHintUpgradeBtn() : Function
      {
         return this.FOutHintUpgradeBtn;
      }
      
      public function set OutHintUpgradeBtn(param1:Function) : void
      {
         this.FOutHintUpgradeBtn = param1;
      }
      
      public function get OverHintUpgradeBtn() : Function
      {
         return this.FOverHintUpgradeBtn;
      }
      
      public function set OverHintUpgradeBtn(param1:Function) : void
      {
         this.FOverHintUpgradeBtn = param1;
      }
      
      public function set OnUserFruitFastMature(param1:Function) : void
      {
         this.FOnUserFruitFastMature = param1;
      }
      
      public function set PickFruitOnClick(param1:Function) : void
      {
         this.FPickFruitOnClick = param1;
      }
      
      public function set WaterOrgMemberOnClick(param1:Function) : void
      {
         this.FWaterOrgMemberOnClick = param1;
      }
      
      public function set PushChakraOnClick(param1:Function) : void
      {
         this.FPushChakraOnClick = param1;
      }
      
      public function set AddChakraTimesOnClick(param1:Function) : void
      {
         this.FAddChakraTimesOnClick = param1;
      }
      
      public function set FastOnClick(param1:Function) : void
      {
         this.FFastOnClick = param1;
      }
      
      public function set OnEffectText(param1:Function) : void
      {
         this.FOnEffectText = param1;
      }
      
      public function set TutorialNextStep(param1:Function) : void
      {
         this.FTutorialNextStep = param1;
      }
      
      public function set OneKeyWatersClisk(param1:Function) : void
      {
         this.FOneKeyWatersClisk = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FIsInitialization = true;
      }
      
      public function UpDataUI(param1:TBaseOrganization, param2:uint) : void
      {
         this.FOrgBaseInfo = param1;
         this.FOrgApplyListCount = param2;
         this.UpDateUI();
      }
      
      public function UpData_OrgBag(param1:TInventories, param2:Vector.<UInt64>, param3:Vector.<TBaseOrganizationMember>, param4:TBaseOrganization) : void
      {
         this.FOrgBaseInfo = param4;
         this.FMC_OrgBags.UpData(param1,param2,param3,param4);
      }
      
      public function UpDateUI_OrgBag() : void
      {
         this.FMC_OrgBags.UpDateUI();
      }
      
      public function UpData_Members(param1:Vector.<TBaseOrganizationMember>) : void
      {
         this.FDataMembersVect = param1;
         this.FMC_OrgMemberList.UpData(this.FDataMembersVect,this.FOrgBaseInfo);
      }
      
      public function UpDateUI_OrgMemberList() : void
      {
         this.FMC_OrgMemberList.UpDateUI();
      }
      
      public function UpDateUI_OrgActivityUpgrade(param1:uint) : void
      {
         this.FMC_OrgActivityUpgrade.UpData(param1,this.FOrgBaseInfo);
         this.FMC_OrgActivityUpgrade.UpDateUI();
      }
      
      public function UpDateUI_OrgCamp() : void
      {
         this.FMC_OrgCamp.UpData(this.FOrgBaseInfo);
         this.FMC_OrgCamp.UpDateUI();
      }
      
      public function UpDateUI_OrgLog(param1:Vector.<Object>) : void
      {
         this.FMC_OrgLogs.UpData(param1);
         this.FMC_OrgLogs.UpDateUI();
      }
      
      public function UpDateUI_OrgMemberCount(param1:uint) : void
      {
         this.FTF_OrgMember.text = param1 + "/" + this.FOrgBaseInfo.OrgMaxMemberCount;
      }
      
      public function UpDataUI_OrgActivityBtnStatus(param1:uint, param2:uint) : void
      {
         this.FMC_OrgCamp.UpDataUI_BtnActivity(param1,param2);
      }
      
      public function UpDateUI_ApplyListCount(param1:uint) : void
      {
         this.FOrgApplyListCount = param1;
         TextField(this.FMC_ApplyCount["TXT_ApplyCount"]).text = String(this.FOrgApplyListCount);
      }
      
      public function UpdateTreeUI() : void
      {
         this.FUITreasureTree.Update();
      }
      
      public function SetEffectStatus(param1:Boolean, param2:Boolean) : void
      {
         this.FOrgDonateStatus = param1;
         this.FOrgTreeStatus = param2;
      }
      
      public function LogicsPerform() : void
      {
         this.FMC_OrgBags.LogicsPerform();
         this.FMC_OrgCamp.LogicsPerform();
         this.FMC_OrgMemberList.LogicsPerform();
         this.FUITreasureTree.LogicsPerform();
         this.UpdateEffectsGlow();
      }
      
      public function Unmount() : void
      {
         this.FTab_Org.Reset();
         this.FMC_OrgBags.UnMount();
      }
   }
}

