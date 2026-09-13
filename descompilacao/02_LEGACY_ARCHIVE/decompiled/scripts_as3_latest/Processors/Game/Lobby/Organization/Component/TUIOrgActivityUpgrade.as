package Processors.Game.Lobby.Organization.Component
{
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TOrganizationBase;
   import Logics.Organization.TBaseOrganization;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_ORGANIZATION;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TUIOrgActivityUpgrade extends TUIComponent
   {
      
      protected static const SIZE_Window_Width:uint = 330;
      
      protected static const SIZE_Window_Height:uint = 274;
      
      protected var FMC:MovieClip;
      
      protected var FTF_CurOrgLevel:TextField;
      
      protected var FTF_CurOrgMoney:TextField;
      
      protected var FTF_UpLvNeedMoney:TextField;
      
      protected var FTF_CurPrompt:TextField;
      
      protected var FTF_CurBuff:TextField;
      
      protected var FTF_NextPrompt:TextField;
      
      protected var FTF_NextBuff:TextField;
      
      protected var FBtn_Ok:MovieClip;
      
      protected var FBtn_Cancel:MovieClip;
      
      protected var FIsInitialization:Boolean;
      
      protected var FData_OrgBaseInfo:TBaseOrganization;
      
      protected var FData_Type:uint;
      
      protected var FUpgradeNeedMoney:uint;
      
      protected var FOrgBaseBin:TBins;
      
      protected var FOrgMaxLevel:uint;
      
      protected var FOrgActivityLevel:uint;
      
      protected var FClickBtnOk:Function;
      
      protected var FClickBtnCancel:Function;
      
      protected var FOverHintUpgradeBtn:Function;
      
      protected var FOutHintUpgradeBtn:Function;
      
      public function TUIOrgActivityUpgrade(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC = param1;
         addChild(this.FMC);
         this.FMC.x = (CONST_COMMON.STAGE_Width - SIZE_Window_Width) / 2 - 140;
         this.FMC.y = (CONST_COMMON.STAGE_Height - SIZE_Window_Height) / 2 - 50;
         this.FTF_CurOrgLevel = this.FMC["TF_CurOrgLevel"];
         this.FTF_CurOrgMoney = this.FMC["TF_CurOrgMoney"];
         this.FTF_UpLvNeedMoney = this.FMC["TF_UpLvNeedMoney"];
         this.FTF_CurPrompt = this.FMC["TF_CurPrompt"];
         this.FTF_CurBuff = this.FMC["TF_CurBuff"];
         this.FTF_NextPrompt = this.FMC["TF_NextPrompt"];
         this.FTF_NextBuff = this.FMC["TF_NextBuff"];
         this.FBtn_Ok = this.FMC["Btn_Ok"];
         this.FBtn_Cancel = this.FMC["Btn_Cancel"];
         TGameUtil.setButtonMode(this.FBtn_Cancel,true);
         TGameUtil.setButtonMode(this.FBtn_Ok,false);
         this.FBtn_Ok.addEventListener(MouseEvent.MOUSE_MOVE,this.OnBtnOkMove);
         this.FBtn_Ok.addEventListener(MouseEvent.MOUSE_OUT,this.OnBtnOkOut);
         this.FBtn_Cancel.addEventListener(MouseEvent.CLICK,this.OnBtnCancelClick);
         this.FOrgBaseBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_OrganizationBase);
         this.FOrgMaxLevel = this.FOrgBaseBin.Count;
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:TOrganizationBase = null;
         var _loc2_:TOrganizationBase = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         _loc1_ = this.FOrgBaseBin.GetDatebaseByIndex(this.FOrgActivityLevel - 1) as TOrganizationBase;
         if(this.FOrgActivityLevel < this.FOrgMaxLevel)
         {
            _loc2_ = this.FOrgBaseBin.GetDatebaseByIndex(this.FOrgActivityLevel) as TOrganizationBase;
         }
         else
         {
            _loc2_ = _loc1_;
         }
         if(this.FData_OrgBaseInfo.OrgId > 0)
         {
            this.FTF_CurOrgLevel.text = "Lv." + this.FData_OrgBaseInfo.OrgLevel;
            this.FTF_CurOrgMoney.text = String(this.FData_OrgBaseInfo.OrgMoney);
            switch(this.FData_Type)
            {
               case 1:
                  this.FTF_UpLvNeedMoney.text = String(_loc2_.CampUpgradeMoney);
                  this.FTF_CurPrompt.text = STRING_ORGANIZATION.STRING_CurMaxMembersPrompt;
                  this.FTF_CurBuff.text = String(_loc1_.OrgMaxNumber);
                  this.FTF_NextPrompt.text = STRING_ORGANIZATION.STRING_NextMaxMembersPrompt;
                  this.FTF_NextBuff.text = String(_loc2_.OrgMaxNumber);
                  break;
               case 2:
                  this.FTF_UpLvNeedMoney.text = String(_loc2_.MuyeguardUpgradeMoney);
                  this.FTF_CurPrompt.text = STRING_ORGANIZATION.STRING_CurMuyeGuardHPAdditionPrompt;
                  this.FTF_CurBuff.text = _loc1_.MuyeguardUpgradeAddition / 10 + "%";
                  this.FTF_NextPrompt.text = STRING_ORGANIZATION.STRING_NextMuyeGuardHPAdditionPrompt;
                  this.FTF_NextBuff.text = _loc2_.MuyeguardUpgradeAddition / 10 + "%";
                  break;
               case 3:
                  break;
               case 4:
                  this.FTF_UpLvNeedMoney.text = String(_loc2_.MuyebattleUpgradeMoney);
                  this.FTF_CurPrompt.text = STRING_ORGANIZATION.STRING_CurMuyeBattleAttackAdditionPrompt;
                  this.FTF_CurBuff.text = _loc1_.MuyebattleUpgradeAddition / 10 + "%";
                  this.FTF_NextPrompt.text = STRING_ORGANIZATION.STRING_NextMuyeBattleAttackAdditionPrompt;
                  this.FTF_NextBuff.text = _loc2_.MuyebattleUpgradeAddition / 10 + "%";
            }
            _loc3_ = uint(this.FTF_UpLvNeedMoney.text);
            _loc4_ = int(this.FTF_CurOrgMoney.text);
            if(this.FData_Type == 1)
            {
               if(_loc4_ >= _loc3_)
               {
                  TGameUtil.setButtonMode(this.FBtn_Ok,true);
                  this.FBtn_Ok.addEventListener(MouseEvent.CLICK,this.OnBtnOkClick);
               }
               else
               {
                  TGameUtil.setButtonMode(this.FBtn_Ok,false);
                  if(this.FBtn_Ok.hasEventListener(MouseEvent.CLICK))
                  {
                     this.FBtn_Ok.removeEventListener(MouseEvent.CLICK,this.OnBtnOkClick);
                  }
               }
            }
            else if(_loc4_ >= _loc3_ && this.FData_OrgBaseInfo.OrgLevel > this.FData_OrgBaseInfo.GetOrgActivityLevelByType(this.FData_Type))
            {
               TGameUtil.setButtonMode(this.FBtn_Ok,true);
               this.FBtn_Ok.addEventListener(MouseEvent.CLICK,this.OnBtnOkClick);
            }
            else
            {
               TGameUtil.setButtonMode(this.FBtn_Ok,false);
               if(this.FBtn_Ok.hasEventListener(MouseEvent.CLICK))
               {
                  this.FBtn_Ok.removeEventListener(MouseEvent.CLICK,this.OnBtnOkClick);
               }
            }
         }
         else
         {
            this.FTF_CurOrgLevel.text = "";
            this.FTF_CurOrgMoney.text = "";
            this.FTF_UpLvNeedMoney.text = "";
            this.FTF_CurPrompt.text = "";
            this.FTF_CurBuff.text = "";
            this.FTF_NextPrompt.text = "";
            this.FTF_NextBuff.text = "";
         }
      }
      
      protected function OnBtnCancelClick(param1:MouseEvent) : void
      {
         if(this.FClickBtnCancel == null)
         {
            return;
         }
         this.FClickBtnCancel(this);
      }
      
      protected function OnBtnOkClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(param1.currentTarget.buttonMode == false)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_UpGradeReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FData_Type);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnBtnOkMove(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:THint = null;
         if(Boolean(param1.currentTarget) && Boolean(param1.currentTarget.buttonMode))
         {
            return;
         }
         _loc3_ = uint(this.FTF_UpLvNeedMoney.text);
         _loc4_ = int(this.FTF_CurOrgMoney.text);
         _loc5_ = this.FData_OrgBaseInfo.GetOrgActivityLevelByType(this.FData_Type);
         if(_loc3_ > _loc4_)
         {
            _loc2_ = STRING_ORGANIZATION.STRING_NoMoreOrgMoneyPrompt;
         }
         else if(this.FData_OrgBaseInfo.OrgLevel <= _loc5_ && this.FData_Type != 1)
         {
            _loc2_ = STRING_ORGANIZATION.STRING_NeedOrgLevelPrompt + (_loc5_ + 1);
         }
         _loc6_ = new THint();
         _loc6_.Caption = _loc2_;
         if(this.FOverHintUpgradeBtn != null)
         {
            this.FOverHintUpgradeBtn(this,_loc6_);
         }
      }
      
      protected function OnBtnOkOut(param1:MouseEvent) : void
      {
         if(Boolean(param1.currentTarget) && Boolean(param1.currentTarget.buttonMode))
         {
            return;
         }
         if(this.FOutHintUpgradeBtn != null)
         {
            this.FOutHintUpgradeBtn(this);
         }
      }
      
      public function get ClickBtnOk() : Function
      {
         return this.FClickBtnOk;
      }
      
      public function set ClickBtnOk(param1:Function) : void
      {
         this.FClickBtnOk = param1;
      }
      
      public function get ClickBtnCancel() : Function
      {
         return this.FClickBtnCancel;
      }
      
      public function set ClickBtnCancel(param1:Function) : void
      {
         this.FClickBtnCancel = param1;
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
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FIsInitialization = true;
      }
      
      public function UpData(param1:int, param2:TBaseOrganization) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         this.FData_Type = param1;
         this.FData_OrgBaseInfo = param2;
         _loc3_ = 0;
         while(_loc3_ < this.FData_OrgBaseInfo.OrgCampData.length)
         {
            _loc5_ = this.FData_OrgBaseInfo.OrgCampData[_loc3_];
            if(_loc5_.type == this.FData_Type)
            {
               this.FOrgActivityLevel = _loc5_.level;
               break;
            }
            _loc3_++;
         }
      }
      
      public function UpDateUI() : void
      {
         this.UpdateUI();
      }
   }
}

