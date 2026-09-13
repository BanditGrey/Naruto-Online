package Processors.Game.Lobby.Organization
{
   import Components.Pages.TUIPage;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Organization.TBaseOrganization;
   import Logics.Organization.TBaseOrganizationMember;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Organization.Component.TUIOrgApplyListElement;
   import Processors.Game.Lobby.Organization.Component.TUIOrgSwitchPowerListElement;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_ORGANIZATION;
   import Resources.Strings.STRING_ORGANIZATION;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowOrgApplyAndPower extends TProcessorLobbyWindow
   {
      
      protected static const MAX_LISTCOUNT:uint = 14;
      
      protected static const STAGE_Width:Number = 618;
      
      protected static const STAGE_Height:Number = 488;
      
      protected var FMC:Sprite;
      
      protected var FMC_SwitchPowerList:Sprite;
      
      protected var FMC_ApplyList:Sprite;
      
      protected var FMC_ChangePage:Sprite;
      
      protected var FMC_PageLeft:MovieClip;
      
      protected var FMC_PageRight:MovieClip;
      
      protected var FTF_Page:TextField;
      
      protected var FBtn_Refuse:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FTF_WindowCaption:TextField;
      
      protected var FApplyListElementVect:Vector.<TUIOrgApplyListElement>;
      
      protected var FSwitchPowerListElementVect:Vector.<TUIOrgSwitchPowerListElement>;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FSelectPageIndex:int;
      
      protected var FPopupType:int;
      
      protected var FApplyListData:Vector.<TBaseOrganizationMember>;
      
      protected var FSwitchPowerListData:Vector.<TBaseOrganizationMember>;
      
      protected var FData_OrgbaseInfo:TBaseOrganization;
      
      protected var FUIWindow_Confirm:TUIWindowConfirmation;
      
      protected var FOnApplyListCount:Function;
      
      public function TProcessorWindowOrgApplyAndPower(param1:TUIComponent)
      {
         super(param1);
         this.FUIPage = new TUIPage(this);
         this.FPageIndex = 0;
         this.FSelectPageIndex = 0;
         this.FApplyListElementVect = new Vector.<TUIOrgApplyListElement>(MAX_LISTCOUNT);
         this.FSwitchPowerListElementVect = new Vector.<TUIOrgSwitchPowerListElement>(MAX_LISTCOUNT);
         this.FPopupType = 1;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_ORGANIZATION.RESOURCESID_Swf_OrganizationMain);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUIOrgApplyListElement = null;
         var _loc4_:TUIOrgSwitchPowerListElement = null;
         this.FMC = TUtilityReflection.CreateDisplayObjectInstance(CONST_ORGANIZATION.RESOURCE_ClassName_MC_OrgApplyAndPower) as Sprite;
         addChild(this.FMC);
         this.FTF_WindowCaption = this.FMC["TF_WindowCaption"];
         this.FMC_SwitchPowerList = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_MC_SwitchPowerList];
         this.FMC_ApplyList = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_MC_ApplyList];
         this.FMC_ChangePage = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_MC_ChangePage];
         this.FMC_PageLeft = this.FMC_ChangePage[CONST_ORGANIZATION.RESOURCE_Link_MC_PageLeft];
         this.FMC_PageRight = this.FMC_ChangePage[CONST_ORGANIZATION.RESOURCE_Link_MC_PageRight];
         this.FTF_Page = this.FMC_ChangePage[CONST_ORGANIZATION.RESOURCE_Link_TF_Page];
         this.FBtn_Refuse = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_Refuse];
         this.FBtn_Close = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_BTN_Close];
         this.FUIPage.LabelPage = this.FTF_Page;
         this.FUIPage.ButtonPrevious.Substrate = this.FMC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = this.FMC_PageRight;
         this.FUIPage.PageSize = MAX_LISTCOUNT;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.PageOnChange;
         _loc1_ = 0;
         while(_loc1_ < MAX_LISTCOUNT)
         {
            _loc3_ = new TUIOrgApplyListElement(this);
            _loc3_.Perform_UIDispatch(this.FMC_ApplyList[CONST_ORGANIZATION.RESOURCE_Link_MC_Element + _loc1_]);
            _loc3_.ClickBtn = this.OnApplyElementClick;
            this.FApplyListElementVect[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_LISTCOUNT)
         {
            _loc4_ = new TUIOrgSwitchPowerListElement(this);
            _loc4_.Perform_UIDispatch(this.FMC_SwitchPowerList[CONST_ORGANIZATION.RESOURCE_Link_MC_Element + _loc1_]);
            _loc4_.ClickOnOk = this.OnSwitchPowerElementClick;
            this.FSwitchPowerListElementVect[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FMC_ApplyList.visible = true;
         this.FMC_SwitchPowerList.visible = false;
         this.FUIWindow_Confirm = new TUIWindowConfirmation(this);
         this.FUIWindow_Confirm.x = (STAGE_Width - this.FUIWindow_Confirm.WindowWidth) / 2;
         this.FUIWindow_Confirm.y = (STAGE_Height - this.FUIWindow_Confirm.WindowHeight) / 2;
         this.FUIWindow_Confirm.OnOK = this.UIWindowComfirm_OnOk;
         this.FUIWindow_Confirm.OnCancel = this.UIWindowComfirm_OnCancel;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindow_Confirm);
         this.FUIWindow_Confirm.Visible = false;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,OnClose);
         this.FBtn_Refuse.addEventListener(MouseEvent.CLICK,this.OnBtnRefuseClick);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateList(param1:TBaseOrganization, param2:Vector.<TBaseOrganizationMember>, param3:int) : void
      {
         this.FPopupType = param3;
         this.FData_OrgbaseInfo = param1;
         if(param3 == 1)
         {
            this.FTF_WindowCaption.text = STRING_ORGANIZATION.STRING_TitleApplyList;
            this.FBtn_Refuse.visible = true;
            this.FMC_ApplyList.visible = true;
            this.FMC_SwitchPowerList.visible = false;
            this.FApplyListData = param2;
            this.UpdataApplayList(param2);
         }
         else if(param3 == 2)
         {
            this.FTF_WindowCaption.text = STRING_ORGANIZATION.STRING_TitleSwitchPowerList;
            this.FBtn_Refuse.visible = false;
            this.FMC_SwitchPowerList.visible = true;
            this.FMC_ApplyList.visible = false;
            this.FSwitchPowerListData = param2;
            this.UpdataSwitchPowerList(param2);
         }
         this.FUIPage.TotalQuantity = param2.length;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function UpdataApplayList(param1:Vector.<TBaseOrganizationMember>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1.length <= 0)
         {
            TGameUtil.setButtonMode(this.FBtn_Refuse,false);
         }
         else
         {
            TGameUtil.setButtonMode(this.FBtn_Refuse,true);
         }
         _loc2_ = 0;
         while(_loc2_ < MAX_LISTCOUNT)
         {
            if(_loc2_ < param1.length)
            {
               this.FApplyListElementVect[_loc2_].MC.visible = true;
               this.FApplyListElementVect[_loc2_].UpDateList(param1[_loc2_]);
            }
            else
            {
               this.FApplyListElementVect[_loc2_].MC.visible = false;
            }
            _loc2_++;
         }
         if(this.FOnApplyListCount != null)
         {
            this.FOnApplyListCount(this,param1.length);
         }
      }
      
      protected function UpdataSwitchPowerList(param1:Vector.<TBaseOrganizationMember>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < MAX_LISTCOUNT)
         {
            if(_loc2_ < param1.length)
            {
               this.FSwitchPowerListElementVect[_loc2_].MC.visible = true;
               this.FSwitchPowerListElementVect[_loc2_].UpDateList(param1[_loc2_]);
            }
            else
            {
               this.FSwitchPowerListElementVect[_loc2_].MC.visible = false;
            }
            _loc2_++;
         }
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 != null)
         {
         }
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
         if(this.FPopupType == 1)
         {
            _loc5_ = int(this.FApplyListData.length);
            _loc3_ = 0;
            while(_loc3_ < MAX_LISTCOUNT)
            {
               _loc4_ = this.FPageIndex * MAX_LISTCOUNT + _loc3_;
               if(_loc4_ < _loc5_)
               {
                  if(this.FApplyListData[_loc4_] != null)
                  {
                     this.FApplyListElementVect[_loc3_].MC.visible = true;
                     this.FApplyListElementVect[_loc3_].UpDateList(this.FApplyListData[_loc4_]);
                  }
               }
               else
               {
                  this.FApplyListElementVect[_loc3_].MC.visible = false;
               }
               _loc3_++;
            }
         }
         else if(this.FPopupType == 2)
         {
            _loc5_ = int(this.FSwitchPowerListData.length);
            _loc3_ = 0;
            while(_loc3_ < MAX_LISTCOUNT)
            {
               _loc4_ = this.FPageIndex * MAX_LISTCOUNT + _loc3_;
               if(_loc4_ < _loc5_)
               {
                  if(this.FSwitchPowerListData[_loc4_] != null)
                  {
                     this.FSwitchPowerListElementVect[_loc3_].MC.visible = true;
                     this.FSwitchPowerListElementVect[_loc3_].UpDateList(this.FSwitchPowerListData[_loc4_]);
                  }
               }
               else
               {
                  this.FSwitchPowerListElementVect[_loc3_].MC.visible = false;
               }
               _loc3_++;
            }
         }
      }
      
      protected function OnApplyElementClick(param1:Object, param2:int, param3:uint, param4:uint) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(this.FOnApplyListCount != null)
         {
            this.FOnApplyListCount(this,this.FApplyListData.length);
         }
      }
      
      protected function OnBtnRefuseClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_ConfirmApplyJoinGuildReq);
         _loc5_ = _loc4_.Data;
         _loc5_.writeShort(this.FApplyListData.length);
         _loc2_ = 0;
         while(_loc2_ < this.FApplyListData.length)
         {
            _loc5_.writeUnsignedInt(this.FApplyListData[_loc2_].Identifier0);
            _loc5_.writeUnsignedInt(this.FApplyListData[_loc2_].Identifier1);
            _loc5_.writeByte(0);
            _loc2_++;
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
         this.FApplyListData.length = 0;
         this.UpdataApplayList(this.FApplyListData);
      }
      
      protected function OnSwitchPowerElementClick(param1:Object, param2:uint, param3:uint) : void
      {
         var _loc4_:Object = null;
         _loc4_ = {
            "high":param2,
            "low":param3
         };
         this.FUIWindow_Confirm.Text = STRING_ORGANIZATION.STRING_ConfirmSwitchPower;
         this.FUIWindow_Confirm.Context = _loc4_;
         this.FUIWindow_Confirm.Visible = true;
      }
      
      protected function UIWindowComfirm_OnOk(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc4_ = uint(this.FUIWindow_Confirm.Context.high);
         _loc5_ = uint(this.FUIWindow_Confirm.Context.low);
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_SwitchPowerReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(_loc4_);
         _loc3_.writeUnsignedInt(_loc5_);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function UIWindowComfirm_OnCancel(param1:Object) : void
      {
         this.FUIWindow_Confirm.Visible = false;
      }
      
      public function get OnApplyListCount() : Function
      {
         return this.FOnApplyListCount;
      }
      
      public function set OnApplyListCount(param1:Function) : void
      {
         this.FOnApplyListCount = param1;
      }
      
      public function UpDateList(param1:TBaseOrganization, param2:Vector.<TBaseOrganizationMember>, param3:int = 1) : void
      {
         this.UpdateList(param1,param2,param3);
      }
   }
}

