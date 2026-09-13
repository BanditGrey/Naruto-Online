package Processors.Game.Lobby.Organization.Component
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Organization.TBaseOrganization;
   import Processors.Game.Lobby.Organization.TProcessorOrganization;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_ORGANIZATION;
   import Resources.Strings.STRING_ORGANIZATION;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIOrgActivitySlot extends TUIComponent
   {
      
      protected static const TYPE_ORGACTIVITY_CAMP:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_CAMP;
      
      protected static const TYPE_ORGACTIVITY_MUYEGUARD:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_MUYEGUARD;
      
      protected static const TYPE_ORGACTIVITY_PETBATTLE:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_PETBATTLE;
      
      protected static const TYPE_ORGACTIVITY_MUYEBATTLE:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_MUYEBATTLE;
      
      protected static const TYPE_ORGACTIVITY_AnimalSeal:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_AnimalSeal;
      
      protected static const STATUS_ORGACTIVITY_NotOpen:uint = CONST_ORGANIZATION.STATUS_ORGACTIVITY_NotOpen;
      
      protected static const STATUS_ORGACTIVITY_SignUp:uint = CONST_ORGANIZATION.STATUS_ORGACTIVITY_SignUp;
      
      protected static const STATUS_ORGACTIVITY_Battle:uint = CONST_ORGANIZATION.STATUS_ORGACTIVITY_Battle;
      
      protected static const STATUS_ORGACTIVITY_End:uint = CONST_ORGANIZATION.STATUS_ORGACTIVITY_End;
      
      protected static const STATUS_ORGACTIVITY_Added:uint = CONST_ORGANIZATION.STATUS_ORGACTIVITY_Added;
      
      protected static const STATUS_ORGACTIVITY_EndJoin:uint = CONST_ORGANIZATION.STATUS_ORGACTIVITY_EndJoin;
      
      protected static const FORMAT_ActivityBtnOkCaption:Vector.<String> = STRING_ORGANIZATION.FORMAT_ActivityBtnOkCaption;
      
      protected var FBtn_Ok:MovieClip;
      
      protected var FBtn_UpLv:MovieClip;
      
      protected var FMC_Bg:MovieClip;
      
      protected var FTF_CurLv:TextField;
      
      protected var FTF_Prompt:TextField;
      
      protected var FBtn_SelectMc:Sprite;
      
      protected var FTF_Caption:TextField;
      
      protected var FMC_Pic:MovieClip;
      
      protected var FTypeOrgActivity:uint;
      
      protected var FStatusOrgActivity:uint;
      
      protected var FData_OrgBaseInfo:TBaseOrganization;
      
      protected var FOrgActivityLevel:uint;
      
      protected var FOrgPlayerPower:uint;
      
      protected var FIsInitialization:Boolean;
      
      protected var FConfigValue:TConfigValue;
      
      protected var FOrgOpenLevel:int;
      
      protected var FMC:MovieClip;
      
      protected var FClickActivityOk:Function;
      
      protected var FClickUpLevel:Function;
      
      protected var FClickSelectMc:Function;
      
      protected var FOnMCOver:Function;
      
      protected var FOnMCOut:Function;
      
      public function TUIOrgActivitySlot(param1:TUIComponent)
      {
         super(param1);
         this.FIsInitialization = false;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC = param1;
         this.FBtn_Ok = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_Ok];
         this.FTF_Caption = this.FBtn_Ok["TF_Caption"];
         this.FBtn_UpLv = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_UpLv];
         this.FMC_Bg = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_MC_Bg];
         this.FTF_CurLv = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_TF_CurLv];
         this.FTF_Prompt = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_TF_Prompt];
         this.FBtn_SelectMc = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_SelectMc];
         this.FMC_Bg.gotoAndStop(1);
         this.FMC_Pic = this.FMC["MC_ActivityPic"];
         TGameUtil.setButtonMode(this.FBtn_UpLv,true);
         TGameUtil.setButtonMode(this.FBtn_Ok,true);
         this.FBtn_Ok.mouseChildren = false;
         this.FBtn_Ok.addEventListener(MouseEvent.CLICK,this.OnOkClick);
         this.FBtn_UpLv.addEventListener(MouseEvent.CLICK,this.OnUpLvClick);
         this.FBtn_SelectMc.addEventListener(MouseEvent.CLICK,this.OnClickSelectMc);
         this.FBtn_SelectMc.addEventListener(MouseEvent.MOUSE_MOVE,this.OnRollOverSelectMc);
         this.FBtn_SelectMc.addEventListener(MouseEvent.MOUSE_OUT,this.OnRollOutSelectMc);
         this.FConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.CanAnimalSealLevel) as TConfigValue;
         this.FOrgOpenLevel = this.FConfigValue.Value as int;
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:Vector.<uint> = null;
         this.FConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60230002) as TConfigValue;
         this.FTF_CurLv.text = "Lv." + this.FOrgActivityLevel.toString();
         if(this.FTypeOrgActivity == 9)
         {
            this.FMC_Pic.gotoAndStop(3);
         }
         else
         {
            this.FMC_Pic.gotoAndStop(this.FTypeOrgActivity);
         }
         if(this.FTypeOrgActivity == TYPE_ORGACTIVITY_CAMP)
         {
            this.FTF_Prompt.text = STRING_ORGANIZATION.STRING_UpgradeTechnology;
         }
         else if(this.FTypeOrgActivity == TYPE_ORGACTIVITY_MUYEGUARD)
         {
            _loc1_ = this.FConfigValue.Value as Vector.<uint>;
            this.FTF_Prompt.text = _loc1_[0] + ":" + _loc1_[1] + STRING_ORGANIZATION.STRING_EnterPrompt;
         }
         if(this.FOrgPlayerPower == 2)
         {
            this.FBtn_UpLv.visible = true;
         }
         else
         {
            this.FBtn_UpLv.visible = false;
         }
      }
      
      protected function UpdateUI_BtnOk() : void
      {
         var _loc1_:Vector.<uint> = null;
         var _loc2_:Array = null;
         TGameUtil.setButtonMode(this.FBtn_Ok,false);
         if(this.FTypeOrgActivity == 9)
         {
            this.FBtn_UpLv.visible = false;
            this.FTF_CurLv.visible = false;
         }
         else
         {
            this.FTF_Prompt.visible = true;
            if(this.FOrgPlayerPower == 2)
            {
               this.FBtn_UpLv.visible = true;
            }
            else
            {
               this.FBtn_UpLv.visible = false;
            }
            this.FTF_CurLv.visible = true;
         }
         if(this.FTypeOrgActivity == TYPE_ORGACTIVITY_CAMP)
         {
            this.FTF_Caption.text = STRING_ORGANIZATION.STRING_EnterPrompt;
         }
         else if(this.FTypeOrgActivity == TYPE_ORGACTIVITY_MUYEBATTLE)
         {
            if(this.FStatusOrgActivity == STATUS_ORGACTIVITY_NotOpen || this.FStatusOrgActivity == STATUS_ORGACTIVITY_End)
            {
               this.FConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60220002) as TConfigValue;
               _loc1_ = this.FConfigValue.Value as Vector.<uint>;
               this.FTF_Prompt.text = _loc1_[0] + ":" + _loc1_[1] + STRING_ORGANIZATION.STRING_SignUpPrompt;
            }
            else
            {
               this.FConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60220004) as TConfigValue;
               _loc1_ = this.FConfigValue.Value as Vector.<uint>;
               this.FTF_Prompt.text = _loc1_[0] + ":" + _loc1_[1] + STRING_ORGANIZATION.STRING_StartBattlePrompt;
            }
         }
         if(this.FTypeOrgActivity == TYPE_ORGACTIVITY_CAMP)
         {
            TGameUtil.setButtonMode(this.FBtn_Ok,true);
         }
         else if(this.FTypeOrgActivity == TYPE_ORGACTIVITY_AnimalSeal)
         {
            _loc2_ = STRING_ORGANIZATION.Cur_Scr_Open.split("&");
            if(this.FData_OrgBaseInfo.OrgLevel < this.FOrgOpenLevel)
            {
               this.FTF_Prompt.text = _loc2_[0] + this.FOrgOpenLevel + _loc2_[1];
               TGameUtil.setButtonMode(this.FBtn_Ok,false);
               this.FTF_Caption.text = STRING_ORGANIZATION.Cur_Scr_Temp_Open;
            }
            else
            {
               if(this.FStatusOrgActivity == 0)
               {
                  this.FTF_Caption.text = STRING_ORGANIZATION.FORMAT_ActivityBtnOkCaption[6];
                  TProcessorOrganization.See_Or_In = 0;
                  this.FTF_Prompt.text = STRING_ORGANIZATION.Cur_Scr_call;
               }
               else
               {
                  this.FTF_Caption.text = STRING_ORGANIZATION.FORMAT_ActivityBtnOkCaption[7];
                  TProcessorOrganization.See_Or_In = 1;
                  this.FTF_Prompt.text = STRING_ORGANIZATION.Cur_Scr_in;
               }
               TGameUtil.setButtonMode(this.FBtn_Ok,true);
            }
         }
         else
         {
            this.FTF_Caption.text = FORMAT_ActivityBtnOkCaption[this.FStatusOrgActivity];
            if(this.FStatusOrgActivity != STATUS_ORGACTIVITY_Added && this.FStatusOrgActivity != STATUS_ORGACTIVITY_EndJoin)
            {
               TGameUtil.setButtonMode(this.FBtn_Ok,true);
            }
         }
      }
      
      protected function OnOkClick(param1:MouseEvent) : void
      {
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FClickActivityOk == null)
         {
            return;
         }
         this.FClickActivityOk(this,this.FTypeOrgActivity,this.FStatusOrgActivity);
      }
      
      protected function OnUpLvClick(param1:MouseEvent) : void
      {
         if(this.FClickUpLevel == null)
         {
            return;
         }
         this.FClickUpLevel(this,this.FTypeOrgActivity);
      }
      
      protected function OnClickSelectMc(param1:MouseEvent) : void
      {
         if(this.FClickSelectMc == null)
         {
            return;
         }
         this.FClickSelectMc(this,this.FTypeOrgActivity);
      }
      
      protected function OnRollOverSelectMc(param1:MouseEvent) : void
      {
         this.FMC_Bg.gotoAndStop(2);
         if(this.FOnMCOver != null)
         {
            this.FOnMCOver(this,this.FTypeOrgActivity);
         }
      }
      
      protected function OnRollOutSelectMc(param1:MouseEvent) : void
      {
         this.FMC_Bg.gotoAndStop(1);
         if(this.FOnMCOut != null)
         {
            this.FOnMCOut(this);
         }
      }
      
      public function get ClickActivityOk() : Function
      {
         return this.FClickActivityOk;
      }
      
      public function set ClickActivityOk(param1:Function) : void
      {
         this.FClickActivityOk = param1;
      }
      
      public function get ClickUpLevel() : Function
      {
         return this.FClickUpLevel;
      }
      
      public function set ClickUpLevel(param1:Function) : void
      {
         this.FClickUpLevel = param1;
      }
      
      public function get ClickSelectMc() : Function
      {
         return this.FClickSelectMc;
      }
      
      public function set ClickSelectMc(param1:Function) : void
      {
         this.FClickSelectMc = param1;
      }
      
      public function get OnMCOver() : Function
      {
         return this.FOnMCOver;
      }
      
      public function set OnMCOver(param1:Function) : void
      {
         this.FOnMCOver = param1;
      }
      
      public function get OnMCOut() : Function
      {
         return this.FOnMCOut;
      }
      
      public function set OnMCOut(param1:Function) : void
      {
         this.FOnMCOut = param1;
      }
      
      public function get MC() : MovieClip
      {
         return this.FMC;
      }
      
      public function set MC(param1:MovieClip) : void
      {
         this.FMC = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FIsInitialization = true;
      }
      
      public function UpDateUI(param1:TBaseOrganization, param2:uint) : void
      {
         this.FData_OrgBaseInfo = param1;
         this.FTypeOrgActivity = param2;
         this.FOrgActivityLevel = this.FData_OrgBaseInfo.GetOrgActivityLevelByType(this.FTypeOrgActivity);
         this.FOrgPlayerPower = this.FData_OrgBaseInfo.OrgPower;
         this.UpdateUI();
      }
      
      public function UpDataUI_BtnOk(param1:uint) : void
      {
         this.FStatusOrgActivity = param1;
         this.UpdateUI_BtnOk();
      }
      
      public function Clear() : void
      {
         this.FTypeOrgActivity = 0;
         this.FStatusOrgActivity = 0;
         this.FOrgActivityLevel = 0;
         this.FTF_Caption.text = "";
         this.FTF_CurLv.text = "";
         this.FTF_Prompt.text = "";
         this.FBtn_UpLv.visible = false;
         TGameUtil.setButtonMode(this.FBtn_Ok,false);
      }
   }
}

