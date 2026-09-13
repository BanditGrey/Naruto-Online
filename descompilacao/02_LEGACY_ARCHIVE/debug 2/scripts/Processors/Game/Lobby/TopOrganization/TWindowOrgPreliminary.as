package Processors.Game.Lobby.TopOrganization
{
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Organization.TBaseOrganization;
   import Logics.Organization.TBaseOrganizationMember;
   import Logics.SLogicsCore;
   import Logics.TopOrganization.TStatusJoinMember;
   import Logics.TopOrganization.TTopOrganizationData;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TOPORGANIZATION;
   import Resources.Strings.STRING_TOPORGANIZATION;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TWindowOrgPreliminary extends TProcessorLobbyWindow
   {
      
      protected static const TYPE_JoinStart:uint = CONST_TOPORGANIZATION.TYPE_JoinStart;
      
      protected static const TYPE_EnterStart:uint = CONST_TOPORGANIZATION.TYPE_EnterStart;
      
      protected static const TYPE_BattleStart:uint = CONST_TOPORGANIZATION.TYPE_BattleStart;
      
      protected static const TYPE_BattleEnd:uint = CONST_TOPORGANIZATION.TYPE_BattleEnd;
      
      protected static const TYPE_GVG2JoinStart:uint = CONST_TOPORGANIZATION.TYPE_GVG2JoinStart;
      
      protected static const TYPE_GVG2Enter:uint = CONST_TOPORGANIZATION.TYPE_GVG2Enter;
      
      protected static const TYPE_GVG2Start:uint = CONST_TOPORGANIZATION.TYPE_GVG2Start;
      
      protected static const TYPE_GVG2BattleEnd:uint = CONST_TOPORGANIZATION.TYPE_GVG2BattleEnd;
      
      protected static const TYPE_GVG3BattleStart:uint = CONST_TOPORGANIZATION.TYPE_GVG3BattleStart;
      
      protected static const TYPE_GVG3BattleEnter:uint = CONST_TOPORGANIZATION.TYPE_GVG3BattleEnter;
      
      protected const STRING_TipsVec:Vector.<uint> = Vector.<uint>([CONST_SYSTEMLANGUAGE.GVG_STRING_05,CONST_SYSTEMLANGUAGE.GVG_STRING_06,CONST_SYSTEMLANGUAGE.GVG_STRING_07,CONST_SYSTEMLANGUAGE.GVG_STRING_08]);
      
      protected var FMainUI:MovieClip;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_WarStatus:TextField;
      
      protected var FMC_Picture:MovieClip;
      
      protected var FTF_Explanation:TextField;
      
      protected var FMC_Enter:MovieClip;
      
      protected var FMC_Join:MovieClip;
      
      protected var FTF_Caption:TextField;
      
      protected var FMC_Apply:MovieClip;
      
      protected var FTF_Apply:TextField;
      
      protected var FMC_Fighting:MovieClip;
      
      protected var FMC_Detail:MovieClip;
      
      protected var FRankingBoxVec:Vector.<MovieClip>;
      
      protected var FTF_OpenTime:TextField;
      
      protected var FTopOrganizationData:TTopOrganizationData;
      
      protected var FBaseOrganization:TBaseOrganization;
      
      protected var FOrgMemberListDataVect:Vector.<TBaseOrganizationMember>;
      
      protected var FOrganizationJoinMinLevel:uint;
      
      protected var FOrganizationMemberMinLevel:uint;
      
      protected var FOrganizationJoinMinMembers:uint;
      
      protected var FOrganizationJoinMaxMembers:uint;
      
      protected var FOrgPreliminaryTimes:Array;
      
      protected var FServerDate:Date;
      
      protected var FStartPlayBattleReportSign:Boolean;
      
      protected var FHint:THint;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FEnterOnClick:Function;
      
      protected var FJoinOnClick:Function;
      
      protected var FApplyOnClick:Function;
      
      protected var FDetailOnMove:Function;
      
      protected var FDetailOnOut:Function;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      public function TWindowOrgPreliminary(param1:TUIComponent)
      {
         super(param1);
         this.FRankingBoxVec = new Vector.<MovieClip>(CONST_TOPORGANIZATION.CAPACITY_Boxes);
         this.FHint = new THint();
         this.FTopOrganizationData = SLogicsCore.TopOrganizationData;
         this.FBaseOrganization = SLogicsCore.Organization;
         this.FStartPlayBattleReportSign = false;
      }
      
      override protected function LogicsPerform() : void
      {
         if(this.FOrgPreliminaryTimes == null)
         {
            return;
         }
         this.FStartPlayBattleReportSign = this.FServerDate.day == this.FOrgPreliminaryTimes[0] && this.FServerDate.hours == this.FOrgPreliminaryTimes[1] && this.FServerDate.minutes == this.FOrgPreliminaryTimes[2];
         if(this.FMC_Fighting != null)
         {
            this.FMC_Fighting.visible = this.FStartPlayBattleReportSign;
         }
         super.LogicsPerform();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         this.FTF_Name = this.FMainUI["TF_Name"];
         this.FTF_WarStatus = this.FMainUI["TF_WarStatus"];
         this.FMC_Picture = this.FMainUI["MC_Picture"];
         this.FMC_Picture.gotoAndStop(1);
         this.FTF_Explanation = this.FMainUI["TF_Explanation"];
         this.FMC_Fighting = this.FMainUI["MC_Fighting"];
         this.FMC_Fighting.visible = false;
         this.FTF_OpenTime = this.FMainUI["TF_OpenTime"];
         this.FTF_OpenTime.visible = false;
         this.FMC_Detail = this.FMainUI["MC_Detail"];
         this.FMC_Enter = this.FMainUI["MC_Enter"];
         TGameUtil.setButtonMode(this.FMC_Enter,false);
         this.FMC_Enter.mouseEnabled = false;
         this.FMC_Join = this.FMainUI["MC_Join"];
         TGameUtil.setButtonMode(this.FMC_Join,true);
         this.FMC_Join.mouseEnabled = true;
         this.FMC_Join.visible = false;
         this.FTF_Caption = this.FMC_Join["TF_Caption"];
         this.FMC_Apply = this.FMainUI["MC_Apply"];
         this.FTF_Apply = this.FMC_Apply["TF_Apply"];
         TGameUtil.setButtonMode(this.FMC_Apply,true);
         _loc2_ = CONST_TOPORGANIZATION.CAPACITY_Boxes;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMainUI["MC_Box_" + _loc1_] as MovieClip;
            _loc3_.gotoAndStop(_loc1_ + 1);
            this.FRankingBoxVec[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent.Parent);
         this.FUIWindowConfirmation.OnOK = this.ApplyOnOk;
         this.FUIWindowConfirmation.x = (STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TSystemLanguage = null;
         var _loc4_:TConfigValue = null;
         var _loc5_:MovieClip = null;
         this.FMC_Enter.addEventListener(MouseEvent.CLICK,this.MCEnterOnClick,false,0,true);
         this.FMC_Join.addEventListener(MouseEvent.CLICK,this.MCJoinOnClick,false,0,true);
         this.FMC_Detail.addEventListener(MouseEvent.MOUSE_MOVE,this.MCDetailOnMove,false,0,true);
         this.FMC_Detail.addEventListener(MouseEvent.ROLL_OUT,this.MCDetailOnOut,false,0,true);
         this.FMC_Apply.addEventListener(MouseEvent.CLICK,this.MCApplyOnClick,false,0,true);
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GVG_STRING_02) as TSystemLanguage;
         this.FTF_Explanation.htmlText = _loc3_.Desc;
         this.FOrganizationJoinMinLevel = this.GetConfigValue(CONST_CONFIGVALUE.GVG_Fst_Signup_TeamLv_Min);
         this.FOrganizationMemberMinLevel = this.GetConfigValue(CONST_CONFIGVALUE.GVG_Fst_Signup_PlayerLv_Min);
         this.FOrganizationJoinMinMembers = this.GetConfigValue(CONST_CONFIGVALUE.GVG_Fst_Signup_PlayerNumber_Min);
         this.FOrganizationJoinMaxMembers = this.GetConfigValue(CONST_CONFIGVALUE.GVG_Fst_Signup_PlayerNumber_Max);
         this.FOrgPreliminaryTimes = this.GetConfigValueArray(CONST_CONFIGVALUE.GVG_Fst_Enter_Time);
         _loc2_ = CONST_TOPORGANIZATION.CAPACITY_Boxes;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = this.FRankingBoxVec[_loc1_];
            _loc5_.addEventListener(MouseEvent.MOUSE_MOVE,this.MCRewardOnOver,false,0,true);
            _loc5_.addEventListener(MouseEvent.MOUSE_OUT,this.MCRewardOnOut,false,0,true);
            _loc1_++;
         }
         this.FMC_Picture.gotoAndStop(1);
         super.ResourcesPerform_UILocations();
      }
      
      protected function GetConfigValue(param1:uint) : uint
      {
         var _loc2_:TConfigValue = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,param1) as TConfigValue;
         if(_loc2_ != null)
         {
            return _loc2_.Value as uint;
         }
         return 0;
      }
      
      protected function GetConfigValueArray(param1:uint) : Array
      {
         var _loc2_:TConfigValue = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,param1) as TConfigValue;
         if(_loc2_ != null)
         {
            return _loc2_.Value as Array;
         }
         return null;
      }
      
      protected function UpdateUI() : void
      {
         this.UpdateTextField();
         this.UpdateButtonStatus();
      }
      
      protected function UpdateTextField() : void
      {
         var _loc1_:String = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc2_ = this.FTopOrganizationData.ApplyStatus;
         _loc3_ = this.FTopOrganizationData.OrgPreliminaryRanking;
         this.FTF_Name.text = STRING_TOPORGANIZATION.STRING_OrganizationName + this.FBaseOrganization.OrgName;
         if(_loc3_ == 0)
         {
            _loc1_ = STRING_TOPORGANIZATION.STRING_WarStatus + STRING_TOPORGANIZATION.STRING_IsApplyVec[_loc2_];
         }
         else
         {
            _loc1_ = TUtilityString.Format(STRING_TOPORGANIZATION.STRING_OrgRanking,_loc3_);
         }
         this.FTF_WarStatus.text = _loc1_;
      }
      
      protected function UpdateButtonStatus() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:TStatusJoinMember = null;
         var _loc3_:Boolean = false;
         _loc1_ = this.CheckPower();
         if(Boolean(this.FTopOrganizationData.ApplyStatus))
         {
            this.FMC_Join.visible = true;
         }
         else
         {
            this.FMC_Join.visible = _loc1_;
         }
         this.FTF_Caption.text = STRING_TOPORGANIZATION.STRING_TextSwitch[this.FTopOrganizationData.ApplyStatus];
         _loc3_ = Boolean(this.FTopOrganizationData.IsSubmitData);
         _loc1_ = !_loc3_;
         TGameUtil.setButtonMode(this.FMC_Apply,_loc1_);
         this.FMC_Apply.mouseEnabled = _loc1_;
         this.FTF_Apply.text = STRING_TOPORGANIZATION.STRING_IsApplyData[this.FTopOrganizationData.IsSubmitData];
      }
      
      protected function CheckUserInJoinMembers() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TStatusJoinMember = null;
         _loc2_ = this.FTopOrganizationData.StatusJoinMembers.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FTopOrganizationData.StatusJoinMembers.GetStatusJoinMemberByIndex(_loc1_);
            if(SLogicsCore.Character.Identifier0 == _loc3_.Identifier0 && SLogicsCore.Character.Identifier1 == _loc3_.Identifier1)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      protected function CheckPower() : Boolean
      {
         var _loc1_:TBaseOrganizationMember = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         if(this.FOrgMemberListDataVect != null)
         {
            _loc3_ = this.FOrgMemberListDataVect.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc1_ = this.FOrgMemberListDataVect[_loc2_];
               if(_loc1_.Identifier0 == SLogicsCore.Character.Identifier0 && _loc1_.Identifier1 == SLogicsCore.Character.Identifier1 && _loc1_.OrgDuties != 0)
               {
                  return true;
               }
               _loc2_++;
            }
         }
         return false;
      }
      
      protected function MCEnterOnClick(param1:MouseEvent) : void
      {
         if(this.FEnterOnClick != null)
         {
            this.FEnterOnClick(this,CONST_TOPORGANIZATION.TYPE_LocalServer);
         }
      }
      
      protected function MCJoinOnClick(param1:MouseEvent) : void
      {
         if(SLogicsCore.Organization.OrgLevel < this.FOrganizationJoinMinLevel)
         {
            FOnEffectText(TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_LevelLitmited,this.FOrganizationJoinMinLevel));
            return;
         }
         if(this.FJoinOnClick != null)
         {
            this.FJoinOnClick(this,CONST_TOPORGANIZATION.TYPE_GVG1_Join);
         }
      }
      
      protected function MCDetailOnMove(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GVG_STRING_01) as TSystemLanguage;
         this.FHint.Content = _loc2_.Desc;
         if(this.FOnHelpTipsOver != null)
         {
            this.FOnHelpTipsOver(this,this.FHint);
         }
      }
      
      protected function MCDetailOnOut(param1:MouseEvent) : void
      {
         if(this.FOnHelpTipsOut != null)
         {
            this.FOnHelpTipsOut(this);
         }
      }
      
      protected function MCApplyOnClick(param1:MouseEvent) : void
      {
         this.FUIWindowConfirmation.Text = STRING_TOPORGANIZATION.STRING_ApplyConfirm;
         this.FUIWindowConfirmation.visible = true;
      }
      
      protected function MCRewardOnOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         var _loc4_:TSystemLanguage = null;
         _loc3_ = uint((param1.currentTarget as MovieClip).name.split("_")[2]);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,this.STRING_TipsVec[_loc3_]) as TSystemLanguage;
         this.FHint.Content = _loc4_.Desc;
         if(this.FOnHelpTipsOver != null)
         {
            this.FOnHelpTipsOver(this,this.FHint);
         }
      }
      
      protected function MCRewardOnOut(param1:MouseEvent) : void
      {
         if(this.FOnHelpTipsOut != null)
         {
            this.FOnHelpTipsOut(this);
         }
      }
      
      protected function ApplyOnOk(param1:Object) : void
      {
         if(this.FApplyOnClick != null)
         {
            this.FApplyOnClick(this,CONST_TOPORGANIZATION.TYPE_GVG1_Join);
         }
      }
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
      }
      
      public function set EnterOnClick(param1:Function) : void
      {
         this.FEnterOnClick = param1;
      }
      
      public function set JoinOnClick(param1:Function) : void
      {
         this.FJoinOnClick = param1;
      }
      
      public function set DetailOnMove(param1:Function) : void
      {
         this.FDetailOnMove = param1;
      }
      
      public function set DetailOnOut(param1:Function) : void
      {
         this.FDetailOnOut = param1;
      }
      
      public function set ApplyOnClick(param1:Function) : void
      {
         this.FApplyOnClick = param1;
      }
      
      public function get OnHelpTipsOver() : Function
      {
         return this.FOnHelpTipsOver;
      }
      
      public function set OnHelpTipsOver(param1:Function) : void
      {
         this.FOnHelpTipsOver = param1;
      }
      
      public function get OnHelpTipsOut() : Function
      {
         return this.FOnHelpTipsOut;
      }
      
      public function set OnHelpTipsOut(param1:Function) : void
      {
         this.FOnHelpTipsOut = param1;
      }
      
      public function Update() : void
      {
         this.UpdateUI();
         this.FServerDate = new Date(STimingCore.GetServerTick() * 1000);
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.FMainUI = param1;
         this.ResourcesPerform_UIDispatch();
      }
      
      public function Perform_UILocations() : void
      {
         this.ResourcesPerform_UILocations();
      }
      
      public function UpdateOrgRank() : void
      {
         this.UpdateTextField();
      }
      
      public function OpenButtonStatus(param1:Boolean = true) : void
      {
         TGameUtil.setButtonMode(this.FMC_Enter,param1);
         this.FMC_Enter.mouseEnabled = param1;
      }
      
      public function SetButtonStatues(param1:Boolean) : void
      {
         TGameUtil.setButtonMode(this.FMC_Join,param1);
         this.FMC_Join.mouseEnabled = param1;
      }
      
      public function SetOrgMemberListData(param1:Vector.<TBaseOrganizationMember>) : void
      {
         this.FOrgMemberListDataVect = param1;
      }
      
      public function Reset() : void
      {
         this.FTF_Name.text = "";
         this.FTF_WarStatus.text = "";
         this.FMC_Fighting.visible = false;
         this.FTF_Caption.text = STRING_TOPORGANIZATION.STRING_TextSwitch[0];
      }
   }
}

