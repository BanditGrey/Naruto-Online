package Processors.Game.Lobby.Organization
{
   import Foundation.Common.Integer.UInt64;
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TInventories;
   import Logics.Organization.TBaseOrganization;
   import Logics.Organization.TBaseOrganizationMember;
   import Logics.Organization.TBaseOrganiztionList;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Organization.Part.TComponentOrganizationListPart;
   import Processors.Game.Lobby.Organization.Part.TComponentOrganizationMainPart;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_ORGANIZATION;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowOrganizationMain extends TProcessorLobbyWindow
   {
      
      protected var FMC_Main:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FMC_EffectLeft:MovieClip;
      
      protected var FMC_EffectRight:MovieClip;
      
      protected var FComponentOrganizationListPart:TComponentOrganizationListPart;
      
      protected var FComponentOrganizationMainPart:TComponentOrganizationMainPart;
      
      protected var FHelpHint:THint;
      
      protected var FOrganization:TBaseOrganization;
      
      protected var FClickMainPartOrgActivityOk:Function;
      
      protected var FClickMainPartOrgActivityUpLv:Function;
      
      protected var FClickCreateOrg:Function;
      
      protected var FClickBtnDonate:Function;
      
      protected var FClickBtnOrgList:Function;
      
      protected var FClickBtnGotoPower:Function;
      
      protected var FClickBtnApplyList:Function;
      
      protected var FClickBtnSwitchPowerList:Function;
      
      protected var FClickBtnQuitOrg:Function;
      
      protected var FOverAward:Function;
      
      protected var FOutAward:Function;
      
      protected var FOnShowHeroInfo:Function;
      
      protected var FOnChatWhisper:Function;
      
      protected var FOnInterpersonalRelationships:Function;
      
      protected var FOverHintUpgradeBtn:Function;
      
      protected var FOutHintUpgradeBtn:Function;
      
      protected var FHelpHintOnOver:Function;
      
      protected var FHelpHintOnOut:Function;
      
      protected var FOnUserFruitFastMature:Function;
      
      protected var FPickFruitOnClick:Function;
      
      protected var FWaterOrgMemberOnClick:Function;
      
      protected var FPushChakraOnClick:Function;
      
      protected var FAddChakraTimesOnClick:Function;
      
      protected var FFastOnClick:Function;
      
      protected var FKeyWatersClisk:Function;
      
      protected var FUpdateBaseOrganization:Function;
      
      public function TProcessorWindowOrganizationMain(param1:TUIComponent)
      {
         super(param1);
         this.FComponentOrganizationListPart = new TComponentOrganizationListPart(this);
         this.FComponentOrganizationListPart.ClickCreateOrg = this.OnCreateOrgClick;
         this.FComponentOrganizationMainPart = new TComponentOrganizationMainPart(this);
         this.FComponentOrganizationMainPart.ClickCampActivityOk = this.OnMainPartOrgActivityOkClick;
         this.FComponentOrganizationMainPart.ClickBtnDonate = this.OnOrgDonateClick;
         this.FComponentOrganizationMainPart.ClickBtnOrgList = this.OnOrgListClick;
         this.FComponentOrganizationMainPart.ClickBtnGotoPower = this.OnOrgGotoPowerClick;
         this.FComponentOrganizationMainPart.ClickBtnApplyList = this.OnOrgApplyListClick;
         this.FComponentOrganizationMainPart.ClickBtnSwitchPowerList = this.OnOrgSwitchPowerClick;
         this.FComponentOrganizationMainPart.ClickBtnQuitOrg = this.OnOrgQuitOrgClick;
         this.FComponentOrganizationMainPart.OnAwardOver = this.OnOverAward;
         this.FComponentOrganizationMainPart.OnAwardOut = this.OnOutAward;
         this.FComponentOrganizationMainPart.OnActivityOver = this.OnOverAward;
         this.FComponentOrganizationMainPart.OnActivityOut = this.OnOutAward;
         this.FComponentOrganizationMainPart.OnOrgBagEffectGenerateText = EffectGenerateText;
         this.FComponentOrganizationMainPart.OnShowHeroInfo = this.ProcessorOnShowHeroInfo;
         this.FComponentOrganizationMainPart.OnChatWhisper = this.ProcessorOnChatWhisper;
         this.FComponentOrganizationMainPart.OnInterpersonalRelationships = this.ProcessorOnInterpersonalRelationships;
         this.FComponentOrganizationMainPart.OverHintUpgradeBtn = this.OnOverHintUpgradeBtn;
         this.FComponentOrganizationMainPart.OutHintUpgradeBtn = this.OnOutHintUpgradeBtn;
         this.FComponentOrganizationMainPart.UpdateBaseOrganization = this.BaseOrganization;
         this.FComponentOrganizationMainPart.OnUserFruitFastMature = this.ProcessorUserFruitFastMature;
         this.FComponentOrganizationMainPart.PickFruitOnClick = this.ProcessorPickFruitOnClick;
         this.FComponentOrganizationMainPart.WaterOrgMemberOnClick = this.ProcessorWaterOrgMemberOnClick;
         this.FComponentOrganizationMainPart.OneKeyWatersClisk = this.OneKeyWatersClisk;
         this.FComponentOrganizationMainPart.PushChakraOnClick = this.ProcessorPushChakraOnClick;
         this.FComponentOrganizationMainPart.AddChakraTimesOnClick = this.ProcessorAddChakraTimesOnClick;
         this.FComponentOrganizationMainPart.FastOnClick = this.ProcessorFastOnClick;
         this.FComponentOrganizationMainPart.OnEffectText = EffectGenerateText;
         this.FComponentOrganizationMainPart.TutorialNextStep = TutorialNextStep;
      }
      
      protected function BaseOrganization(param1:TBaseOrganization) : void
      {
         this.FUpdateBaseOrganization(param1);
      }
      
      public function set UpdateBaseOrganization(param1:Function) : void
      {
         this.FUpdateBaseOrganization = param1;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_ORGANIZATION.RESOURCESID_Swf_OrganizationMain);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TSystemLanguage = null;
         this.FMC_Main = TUtilityReflection.CreateDisplayObjectInstance(CONST_ORGANIZATION.RESOURCE_ClassName_MC_OrganizationMain) as Sprite;
         addChild(this.FMC_Main);
         this.FMC_EffectLeft = this.FMC_Main[CONST_ORGANIZATION.RESOURCE_Link_MC_EffectLeft];
         this.FMC_EffectRight = this.FMC_Main[CONST_ORGANIZATION.RESOURCE_Link_MC_EffectRight];
         this.FBtn_Close = this.FMC_Main[CONST_ORGANIZATION.RESOURCE_Link_BTN_Close];
         this.FBtn_Help = this.FMC_Main[CONST_ORGANIZATION.RESOURCE_Link_BTN_Help];
         this.FComponentOrganizationListPart.Perform_UIDispatch(this.FMC_Main[CONST_ORGANIZATION.RESOURCE_Link_MC_OrganizationList]);
         this.FComponentOrganizationMainPart.Perform_UIDispatch(this.FMC_Main[CONST_ORGANIZATION.RESOURCE_Link_MC_OrganizationMain]);
         addChild(this.FComponentOrganizationListPart);
         addChild(this.FComponentOrganizationMainPart);
         this.FComponentOrganizationListPart.Visible = false;
         this.FComponentOrganizationMainPart.Visible = false;
         this.FHelpHint = new THint();
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_ORGANIZATION) as TSystemLanguage;
         this.FHelpHint.Content = _loc1_.Desc;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         this.FComponentOrganizationMainPart.LogicsPerform();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,OnClose);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.OnHintHelpMove);
         this.FBtn_Help.addEventListener(MouseEvent.ROLL_OUT,this.OnHintHelpOut);
         super.ResourcesPerform_UILocations();
      }
      
      public function FCloseThiseByOthers() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function OnMainPartOrgActivityOkClick(param1:Object, param2:uint, param3:uint) : void
      {
         if(this.FClickMainPartOrgActivityOk == null)
         {
            return;
         }
         this.FClickMainPartOrgActivityOk(param1,param2,param3);
      }
      
      protected function OnMainPartOrgActivityUpLvClick(param1:Object, param2:uint) : void
      {
         if(this.FClickMainPartOrgActivityUpLv == null)
         {
            return;
         }
         this.FClickMainPartOrgActivityUpLv(param1,param2);
      }
      
      protected function OnCreateOrgClick(param1:Object) : void
      {
         if(this.FClickCreateOrg == null)
         {
            return;
         }
         this.FClickCreateOrg(this);
      }
      
      protected function OnOrgDonateClick(param1:Object) : void
      {
         if(this.FClickBtnDonate == null)
         {
            return;
         }
         this.FClickBtnDonate(param1);
      }
      
      protected function OnOrgListClick(param1:Object, param2:Boolean) : void
      {
         if(this.FClickBtnOrgList == null)
         {
            return;
         }
         this.FClickBtnOrgList(param1,param2);
      }
      
      protected function OnOrgGotoPowerClick(param1:Object) : void
      {
         if(this.FClickBtnGotoPower == null)
         {
            return;
         }
         this.FClickBtnGotoPower(param1);
      }
      
      protected function OnOrgApplyListClick(param1:Object, param2:int) : void
      {
         if(this.FClickBtnApplyList == null)
         {
            return;
         }
         this.FClickBtnApplyList(param1,param2);
      }
      
      protected function OnOrgSwitchPowerClick(param1:Object, param2:int) : void
      {
         if(this.FClickBtnSwitchPowerList == null)
         {
            return;
         }
         this.FClickBtnSwitchPowerList(param1,param2);
      }
      
      protected function OnOrgQuitOrgClick(param1:Object) : void
      {
         if(this.FClickBtnQuitOrg == null)
         {
            return;
         }
         this.FClickBtnQuitOrg(param1);
      }
      
      protected function OnOverAward(param1:Object, param2:THint) : void
      {
         this.FOverAward(param1,param2);
      }
      
      protected function OnOutAward(param1:Object) : void
      {
         this.FOutAward(param1);
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
      
      protected function OnOverHintUpgradeBtn(param1:Object, param2:THint) : void
      {
         if(this.FOverHintUpgradeBtn != null)
         {
            this.FOverHintUpgradeBtn(param1,param2);
         }
      }
      
      protected function OnOutHintUpgradeBtn(param1:Object) : void
      {
         if(this.FOutHintUpgradeBtn != null)
         {
            this.FOutHintUpgradeBtn(param1);
         }
      }
      
      protected function OnHintHelpMove(param1:MouseEvent) : void
      {
         if(this.FHelpHintOnOver != null)
         {
            this.FHelpHintOnOver(this,this.FHelpHint);
         }
      }
      
      protected function OnHintHelpOut(param1:MouseEvent) : void
      {
         if(this.FHelpHintOnOut != null)
         {
            this.FHelpHintOnOut(this);
         }
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
      
      protected function OneKeyWatersClisk() : void
      {
         if(this.FKeyWatersClisk != null)
         {
            this.FKeyWatersClisk();
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
      
      public function get ClickMainPartOrgActivityOk() : Function
      {
         return this.FClickMainPartOrgActivityOk;
      }
      
      public function set ClickMainPartOrgActivityOk(param1:Function) : void
      {
         this.FClickMainPartOrgActivityOk = param1;
      }
      
      public function get ClickMainPartOrgActivityUpLv() : Function
      {
         return this.FClickMainPartOrgActivityUpLv;
      }
      
      public function set ClickMainPartOrgActivityUpLv(param1:Function) : void
      {
         this.FClickMainPartOrgActivityUpLv = param1;
      }
      
      public function get ClickCreateOrg() : Function
      {
         return this.FClickCreateOrg;
      }
      
      public function set ClickCreateOrg(param1:Function) : void
      {
         this.FClickCreateOrg = param1;
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
      
      public function get OverAward() : Function
      {
         return this.FOverAward;
      }
      
      public function set OverAward(param1:Function) : void
      {
         this.FOverAward = param1;
      }
      
      public function get OutAward() : Function
      {
         return this.FOutAward;
      }
      
      public function set OutAward(param1:Function) : void
      {
         this.FOutAward = param1;
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
      
      public function get OverHintUpgradeBtn() : Function
      {
         return this.FOverHintUpgradeBtn;
      }
      
      public function set OverHintUpgradeBtn(param1:Function) : void
      {
         this.FOverHintUpgradeBtn = param1;
      }
      
      public function get OutHintUpgradeBtn() : Function
      {
         return this.FOutHintUpgradeBtn;
      }
      
      public function set OutHintUpgradeBtn(param1:Function) : void
      {
         this.FOutHintUpgradeBtn = param1;
      }
      
      public function get HelpHintOnOver() : Function
      {
         return this.FHelpHintOnOver;
      }
      
      public function set HelpHintOnOver(param1:Function) : void
      {
         this.FHelpHintOnOver = param1;
      }
      
      public function get HelpHintOnOut() : Function
      {
         return this.FHelpHintOnOut;
      }
      
      public function set HelpHintOnOut(param1:Function) : void
      {
         this.FHelpHintOnOut = param1;
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
      
      public function set KeyWatersClisk(param1:Function) : void
      {
         this.FKeyWatersClisk = param1;
      }
      
      public function UpDataPartData(param1:TBaseOrganization, param2:Vector.<TBaseOrganiztionList>, param3:uint, param4:Boolean = true) : void
      {
         if(param1.OrgId > 0 && param4)
         {
            this.FComponentOrganizationMainPart.Visible = true;
            this.FComponentOrganizationListPart.Visible = false;
            this.FComponentOrganizationListPart.Unmount();
            this.FComponentOrganizationMainPart.UpDataUI(param1,param3);
         }
         else
         {
            this.FComponentOrganizationMainPart.Visible = false;
            this.FComponentOrganizationListPart.Visible = true;
            this.FComponentOrganizationListPart.UpDateOrgList(this,param2,param1.OrgId > 0 ? true : false);
         }
      }
      
      public function UpDataUI_OrgPart(param1:TBaseOrganization, param2:uint) : void
      {
         this.FComponentOrganizationMainPart.UpDataUI(param1,param2);
         this.FOrganization = param1;
      }
      
      public function UpData_OrgBag(param1:TInventories, param2:Vector.<UInt64>, param3:Vector.<TBaseOrganizationMember>, param4:TBaseOrganization) : void
      {
         this.FComponentOrganizationMainPart.UpData_OrgBag(param1,param2,param3,param4);
         this.FComponentOrganizationMainPart.UpDateUI_OrgBag();
         this.FComponentOrganizationMainPart.UpDateUI_OrgMemberList();
      }
      
      public function UpData_OrgMember(param1:Vector.<TBaseOrganizationMember>) : void
      {
         this.FComponentOrganizationMainPart.UpData_Members(param1);
      }
      
      public function UpDateUI_OrgMember() : void
      {
         this.FComponentOrganizationMainPart.UpDateUI_OrgMemberList();
      }
      
      public function UpDateUI_OrgActivityUpgrade(param1:uint) : void
      {
         this.FComponentOrganizationMainPart.UpDateUI_OrgActivityUpgrade(param1);
      }
      
      public function UpDateUI_OrgCamp() : void
      {
         this.FComponentOrganizationMainPart.UpDateUI_OrgCamp();
      }
      
      public function UpDateUI_OrgLog(param1:Vector.<Object>) : void
      {
         this.FComponentOrganizationMainPart.UpDateUI_OrgLog(param1);
      }
      
      public function UpDateUI_OrgMemberCount(param1:uint) : void
      {
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FComponentOrganizationMainPart.UpDateUI_OrgMemberCount(param1);
      }
      
      public function UpDataUI_OrgActivityBtnStatus(param1:uint, param2:uint) : void
      {
         this.FComponentOrganizationMainPart.UpDataUI_OrgActivityBtnStatus(param1,param2);
      }
      
      public function UpDateUI_OrgApplyListCount(param1:uint) : void
      {
         this.FComponentOrganizationMainPart.UpDateUI_ApplyListCount(param1);
      }
      
      public function UpdateTreeUI() : void
      {
         this.FComponentOrganizationMainPart.UpdateTreeUI();
      }
      
      public function PlayEffect() : void
      {
         this.FMC_EffectLeft.play();
         this.FMC_EffectRight.play();
      }
      
      public function Unmount() : void
      {
         this.FComponentOrganizationMainPart.Unmount();
      }
      
      public function get Organization() : TBaseOrganization
      {
         return this.FOrganization;
      }
      
      public function SetEffectStatus(param1:Boolean, param2:Boolean) : void
      {
         this.FComponentOrganizationMainPart.SetEffectStatus(param1,param2);
      }
   }
}

