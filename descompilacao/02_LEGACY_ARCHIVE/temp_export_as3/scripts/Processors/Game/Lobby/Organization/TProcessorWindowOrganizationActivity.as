package Processors.Game.Lobby.Organization
{
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Organization.TBaseOrganization;
   import Logics.Organization.TBaseOrganizationMember;
   import Logics.Organization.TBaseOrganiztionList;
   import Logics.Organization.TMuyeGuardRank;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Organization.Part.TComponentOrganizationFightPet;
   import Processors.Game.Lobby.Organization.Part.TComponentOrganizationMuyeGuardRank;
   import Processors.Game.Lobby.Organization.Part.TComponentOrganizationTechnology;
   import Processors.Game.Lobby.Organization.Part.TComponentOrganizationWarRank;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_ORGANIZATION;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowOrganizationActivity extends TProcessorLobbyWindow
   {
      
      public static const ACTIVITY_TYPE_TECHNOLOGY:uint = 1;
      
      public static const ACTIVITY_TYPE_MUYEGUARD:uint = 2;
      
      public static const ACTIVITY_TYPE_FIGHTPET:uint = 3;
      
      public static const ACTIVITY_TYPE_WARRANK:uint = 4;
      
      protected var FMC_Activity:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FComponentOrganizationTechnology:TComponentOrganizationTechnology;
      
      protected var FComponentOrganizationFightPet:TComponentOrganizationFightPet;
      
      protected var FComponentOrganizationWarRank:TComponentOrganizationWarRank;
      
      protected var FComponentOrganizationMuyeGuardRank:TComponentOrganizationMuyeGuardRank;
      
      protected var FOrgBaseInfo:TBaseOrganization;
      
      protected var FOnBtnDonateClick:Function;
      
      protected var FOnHintMove:Function;
      
      protected var FOnHintOut:Function;
      
      protected var FSetRoot:Function;
      
      protected var FEffectGenerateTextByErrorCode:Function;
      
      protected var FCloseCallPanelFatherin:Function = null;
      
      public function TProcessorWindowOrganizationActivity(param1:TUIComponent)
      {
         super(param1);
         this.FComponentOrganizationTechnology = new TComponentOrganizationTechnology(this);
         this.FComponentOrganizationTechnology.OnBtnDonateClick = this.ProcessorOnBtnDonateClick;
         this.FComponentOrganizationTechnology.OnBtnLearnClick = this.ProcessorOnBtnLearnClick;
         this.FComponentOrganizationFightPet = new TComponentOrganizationFightPet(this);
         this.FComponentOrganizationFightPet.EffectGenerateTextByError = this.TextErrorCode;
         this.FComponentOrganizationFightPet.SetRoot = this.Excel;
         this.FComponentOrganizationWarRank = new TComponentOrganizationWarRank(this);
         this.FComponentOrganizationMuyeGuardRank = new TComponentOrganizationMuyeGuardRank(this);
         this.FComponentOrganizationMuyeGuardRank.HintOnMove = this.OnHintMouseMove;
         this.FComponentOrganizationMuyeGuardRank.HintOnOut = this.OnHintMouseOut;
      }
      
      public function PopWindowOnOk() : void
      {
         this.FComponentOrganizationFightPet.PopWindowOnOk();
      }
      
      public function set SetRoot(param1:Function) : void
      {
         this.FSetRoot = param1;
      }
      
      protected function Excel(param1:TUIComponent) : void
      {
         this.FSetRoot(param1);
      }
      
      protected function TextErrorCode(param1:int) : void
      {
         this.FEffectGenerateTextByErrorCode(param1);
      }
      
      public function set EffectGenerateTextByError(param1:Function) : void
      {
         this.FEffectGenerateTextByErrorCode = param1;
      }
      
      public function PACKETID_SC_AnimalSeall_Open_Ret(param1:TPacket) : void
      {
         this.FComponentOrganizationFightPet.PACKETID_SC_AnimalSeall_Open_Ret(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_ORGANIZATION.RESOURCESID_Swf_OrganizationMain);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_Activity = TUtilityReflection.CreateDisplayObjectInstance(CONST_ORGANIZATION.RESOURCE_ClassName_MC_OrganizationActivity) as Sprite;
         addChild(this.FMC_Activity);
         this.FBtn_Close = this.FMC_Activity[CONST_ORGANIZATION.RESOURCE_Link_BTN_Close];
         this.FComponentOrganizationTechnology.Perform_UIDispatch(this.FMC_Activity[CONST_ORGANIZATION.RESOURCE_Link_MC_Technology]);
         this.FComponentOrganizationFightPet.Perform_UIDispatch(this.FMC_Activity[CONST_ORGANIZATION.RESOURCE_Link_MC_FightPet],FParent);
         this.FComponentOrganizationWarRank.Perform_UIDispatch(this.FMC_Activity[CONST_ORGANIZATION.RESOURCE_Link_MC_WarRank]);
         this.FComponentOrganizationMuyeGuardRank.Perform_UIDispatch(this.FMC_Activity[CONST_ORGANIZATION.RESOURCE_Link_MC_MuyeGuardRank]);
         addChild(this.FComponentOrganizationTechnology);
         addChild(this.FComponentOrganizationFightPet);
         addChild(this.FComponentOrganizationWarRank);
         addChild(this.FComponentOrganizationMuyeGuardRank);
         addChild(this.FBtn_Close);
         this.FComponentOrganizationTechnology.Visible = false;
         this.FComponentOrganizationFightPet.Visible = false;
         this.FComponentOrganizationWarRank.Visible = false;
         this.FComponentOrganizationMuyeGuardRank.Visible = false;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function LogicsPerform() : void
      {
         if(this.Visible)
         {
            this.FComponentOrganizationTechnology.LogicsPerform();
            this.FComponentOrganizationWarRank.LogicsPerform();
            this.FComponentOrganizationFightPet.LogicsPerform();
         }
         super.LogicsPerform();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      protected function ProcessorOnBtnDonateClick() : void
      {
         if(this.FOnBtnDonateClick != null)
         {
            this.FOnBtnDonateClick(this);
         }
      }
      
      protected function ProcessorOnBtnLearnClick(param1:Object, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_UpGradeGuildTechReq);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ProcessorOnClose(param1:MouseEvent) : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      public function ProcessorOnCloseCopy() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
         if(this.FCloseCallPanelFatherin != null)
         {
            this.FCloseCallPanelFatherin();
         }
      }
      
      public function set CloseCallPanelFatherin(param1:Function) : void
      {
         this.FCloseCallPanelFatherin = param1;
      }
      
      protected function OnHintMouseMove(param1:Object, param2:THint) : void
      {
         if(this.FOnHintMove != null)
         {
            this.FOnHintMove(param1,param2);
         }
      }
      
      protected function OnHintMouseOut(param1:Object) : void
      {
         if(this.FOnHintOut != null)
         {
            this.FOnHintOut(param1);
         }
      }
      
      public function get OnBtnDonateClick() : Function
      {
         return this.FOnBtnDonateClick;
      }
      
      public function set OnBtnDonateClick(param1:Function) : void
      {
         this.FOnBtnDonateClick = param1;
      }
      
      public function get OnHintMove() : Function
      {
         return this.FOnHintMove;
      }
      
      public function set OnHintMove(param1:Function) : void
      {
         this.FOnHintMove = param1;
      }
      
      public function get OnHintOut() : Function
      {
         return this.FOnHintOut;
      }
      
      public function set OnHintOut(param1:Function) : void
      {
         this.FOnHintOut = param1;
      }
      
      public function OnOrgActivityClick(param1:int) : void
      {
         switch(param1)
         {
            case ACTIVITY_TYPE_TECHNOLOGY:
               this.FComponentOrganizationTechnology.Visible = true;
               this.FComponentOrganizationMuyeGuardRank.Visible = false;
               this.FComponentOrganizationFightPet.Visible = false;
               this.FComponentOrganizationWarRank.Visible = false;
               this.FComponentOrganizationTechnology.TechnologyData = this.FOrgBaseInfo.OrgAddition;
               this.FComponentOrganizationTechnology.UpDateUI(this.FOrgBaseInfo);
               break;
            case ACTIVITY_TYPE_FIGHTPET:
               this.FComponentOrganizationTechnology.Visible = false;
               this.FComponentOrganizationMuyeGuardRank.Visible = false;
               this.FComponentOrganizationFightPet.Visible = true;
               this.FComponentOrganizationWarRank.Visible = false;
               break;
            case ACTIVITY_TYPE_WARRANK:
               this.FComponentOrganizationTechnology.Visible = false;
               this.FComponentOrganizationMuyeGuardRank.Visible = false;
               this.FComponentOrganizationFightPet.Visible = false;
               this.FComponentOrganizationWarRank.Visible = true;
               this.FComponentOrganizationWarRank.MuyeBattleRankReq();
               break;
            case ACTIVITY_TYPE_MUYEGUARD:
               this.FComponentOrganizationTechnology.Visible = false;
               this.FComponentOrganizationMuyeGuardRank.Visible = true;
               this.FComponentOrganizationFightPet.Visible = false;
               this.FComponentOrganizationWarRank.Visible = false;
               this.FComponentOrganizationMuyeGuardRank.MuyeGuardRankReq();
         }
      }
      
      public function UpData_Technology(param1:Vector.<Object>, param2:Number) : void
      {
         this.FComponentOrganizationTechnology.TechnologyData = param1;
         this.FComponentOrganizationTechnology.ExploitData = param2;
      }
      
      public function UpDateUI_Technology() : void
      {
         this.FComponentOrganizationTechnology.UpDateUI(this.FOrgBaseInfo);
      }
      
      public function UpDataUI_MuyeGuardRank(param1:TMuyeGuardRank) : void
      {
         this.FComponentOrganizationMuyeGuardRank.SetData(param1);
      }
      
      public function UpdateUI_MuyeBattleRank(param1:Vector.<TBaseOrganiztionList>, param2:Vector.<TBaseOrganizationMember>) : void
      {
         this.FComponentOrganizationWarRank.Update(param1,param2);
      }
      
      public function UpData_OrgBaseInfo(param1:TBaseOrganization) : void
      {
         this.FOrgBaseInfo = param1;
      }
      
      public function ShowEffectGenerateText(param1:String) : void
      {
         EffectGenerateText(param1);
      }
      
      public function InitilaFightPet(param1:int, param2:int, param3:int, param4:int, param5:int, param6:TBaseOrganization) : void
      {
         this.FComponentOrganizationFightPet.initization(param1,param2,param3,param4,param5,param6);
      }
      
      public function updateFightPet(param1:TBaseOrganization) : void
      {
         this.FComponentOrganizationFightPet.updateinitization(param1);
      }
   }
}

