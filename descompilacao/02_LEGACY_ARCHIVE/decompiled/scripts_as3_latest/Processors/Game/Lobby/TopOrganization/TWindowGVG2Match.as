package Processors.Game.Lobby.TopOrganization
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Logics.TopOrganization.TJoinGVG2MatchOrg;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TOPORGANIZATION;
   import Resources.Strings.STRING_TOPORGANIZATION;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TWindowGVG2Match extends TWindowOrgPreliminary
   {
      
      protected const STRING_RewardTipsVec:Vector.<uint> = Vector.<uint>([CONST_SYSTEMLANGUAGE.GVG_STRING_13,CONST_SYSTEMLANGUAGE.GVG_STRING_14,CONST_SYSTEMLANGUAGE.GVG_STRING_15,CONST_SYSTEMLANGUAGE.GVG_STRING_16]);
      
      protected var FType:uint;
      
      protected var FValue:Boolean;
      
      public function TWindowGVG2Match(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         super.ResourcesPerform_UIDispatch();
         FTF_OpenTime.text = STRING_TOPORGANIZATION.STRING_GVG2OpenTime[0];
         FTF_OpenTime.visible = false;
         FMC_Enter.visible = false;
         FMC_Join.visible = false;
         FMC_Apply.visible = false;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TSystemLanguage = null;
         super.ResourcesPerform_UILocations();
         FMC_Picture.gotoAndStop(2);
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GVG_STRING_10) as TSystemLanguage;
         FTF_Explanation.htmlText = _loc1_.Desc;
      }
      
      protected function SetTextField(param1:uint = 0) : void
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:TJoinGVG2MatchOrg = null;
         FTF_Name.text = STRING_TOPORGANIZATION.STRING_OrganizationName + FBaseOrganization.OrgName;
         _loc2_ = STRING_TOPORGANIZATION.STRING_WarStatus;
         if(param1 < TYPE_BattleEnd && param1 > TYPE_JoinStart)
         {
            _loc2_ += STRING_TOPORGANIZATION.STRING_GVG2Status_UnOpen;
         }
         else
         {
            _loc4_ = FTopOrganizationData.JoinGVG2MatchOrgs.GetMyOrgByIdentifier(FBaseOrganization.OrgId);
            _loc3_ = _loc4_ == null ? 0 : _loc4_.GVG2Status;
            if(_loc3_ == 0)
            {
               _loc2_ += STRING_TOPORGANIZATION.STRING_GVG2Status_UnEnter;
            }
            else if(_loc3_ == 1)
            {
               _loc2_ += STRING_TOPORGANIZATION.STRING_GVG2Status_UnJoin;
            }
            else if(_loc3_ == 2)
            {
               _loc2_ += STRING_TOPORGANIZATION.STRING_GVG2Status_HasJoin;
               if(!FTopOrganizationData.GVG2IsBattling)
               {
                  _loc2_ = STRING_TOPORGANIZATION.STRING_WarStatus + STRING_TOPORGANIZATION.STRING_EnterNextOrOut[_loc4_.LoseCount > 1 ? 1 : 0];
               }
            }
         }
         FTF_WarStatus.text = _loc2_;
      }
      
      protected function IsShowButton(param1:uint) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:TJoinGVG2MatchOrg = null;
         _loc3_ = FTopOrganizationData.JoinGVG2MatchOrgs.GetMyOrgByIdentifier(FBaseOrganization.OrgId);
         if(param1 < TYPE_GVG2JoinStart)
         {
            _loc2_ = false;
         }
         else
         {
            _loc2_ = true;
         }
         if(param1 == TYPE_GVG2JoinStart)
         {
            TGameUtil.setButtonMode(FMC_Enter,false);
            FMC_Enter.mouseEnabled = false;
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Enter,true);
            FMC_Enter.mouseEnabled = true;
         }
         if(_loc3_ == null || _loc3_ != null && _loc3_.GVG2Status != 0)
         {
            FMC_Enter.visible = _loc2_;
            FMC_Join.visible = _loc2_;
            FMC_Apply.visible = _loc2_;
            FTF_OpenTime.visible = !_loc2_;
            FTF_OpenTime.text = STRING_TOPORGANIZATION.STRING_GVG2OpenTime[uint(_loc2_)];
         }
         else
         {
            FMC_Enter.visible = !_loc2_;
            FMC_Join.visible = !_loc2_;
            FMC_Apply.visible = !_loc2_;
            FTF_OpenTime.visible = _loc2_;
            FTF_OpenTime.text = STRING_TOPORGANIZATION.STRING_GVG2OpenTime[uint(_loc2_)];
         }
      }
      
      override protected function UpdateButtonStatus() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:TJoinGVG2MatchOrg = null;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         _loc3_ = FTopOrganizationData.JoinGVG2MatchOrgs.GetMyOrgByIdentifier(FBaseOrganization.OrgId);
         if(_loc3_ == null)
         {
            _loc1_ = false;
         }
         else
         {
            _loc4_ = CheckPower();
            _loc5_ = _loc3_.GVG2Status == 2;
            if(_loc5_)
            {
               _loc1_ = true;
            }
            else
            {
               _loc1_ = _loc4_;
            }
            FTF_Caption.text = STRING_TOPORGANIZATION.STRING_TextSwitch[_loc3_.GVG2Status - 1];
         }
         FMC_Join.visible = _loc1_;
         _loc2_ = Boolean(FTopOrganizationData.GVG2IsSubmitData);
         _loc1_ = !_loc2_;
         TGameUtil.setButtonMode(FMC_Apply,_loc1_);
         FMC_Apply.mouseEnabled = _loc1_;
         FTF_Apply.text = STRING_TOPORGANIZATION.STRING_IsApplyData[FTopOrganizationData.GVG2IsSubmitData];
      }
      
      override protected function UpdateUI() : void
      {
         this.SetTextField(this.FType);
         this.IsShowButton(this.FType);
         this.UpdateButtonStatus();
      }
      
      override protected function MCJoinOnClick(param1:MouseEvent) : void
      {
         if(SLogicsCore.Organization.OrgLevel < FOrganizationJoinMinLevel)
         {
            FOnEffectText(TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_LevelLitmited,FOrganizationJoinMinLevel));
            return;
         }
         if(FJoinOnClick != null)
         {
            FJoinOnClick(this,CONST_TOPORGANIZATION.TYPE_GVG2_Join);
         }
      }
      
      override protected function ApplyOnOk(param1:Object) : void
      {
         if(FApplyOnClick != null)
         {
            FApplyOnClick(this,CONST_TOPORGANIZATION.TYPE_GVG2_Join);
         }
      }
      
      override protected function MCEnterOnClick(param1:MouseEvent) : void
      {
         if(FEnterOnClick != null)
         {
            FEnterOnClick(this,CONST_TOPORGANIZATION.TYPE_CrossServerFirst);
         }
      }
      
      override protected function MCRewardOnOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         var _loc4_:TSystemLanguage = null;
         _loc3_ = uint((param1.currentTarget as MovieClip).name.split("_")[2]);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,this.STRING_RewardTipsVec[_loc3_]) as TSystemLanguage;
         FHint.Content = _loc4_.Desc;
         if(FOnHelpTipsOver != null)
         {
            FOnHelpTipsOver(this,FHint);
         }
      }
      
      override protected function MCDetailOnMove(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GVG_STRING_09) as TSystemLanguage;
         FHint.Content = _loc2_.Desc;
         if(FOnHelpTipsOver != null)
         {
            FOnHelpTipsOver(this,FHint);
         }
      }
      
      override public function Update() : void
      {
         this.UpdateUI();
      }
      
      public function UpdateGVG2ButtonStatus(param1:uint = 0) : void
      {
         this.FType = param1;
         this.IsShowButton(param1);
      }
      
      public function UpdateGVG2Text(param1:uint = 0) : void
      {
         this.FType = param1;
         this.SetTextField(param1);
      }
   }
}

