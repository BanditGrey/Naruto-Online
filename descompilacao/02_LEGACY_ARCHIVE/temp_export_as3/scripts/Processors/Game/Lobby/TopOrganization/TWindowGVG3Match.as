package Processors.Game.Lobby.TopOrganization
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TOPORGANIZATION;
   import Resources.Strings.STRING_TOPORGANIZATION;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TWindowGVG3Match extends TWindowOrgPreliminary
   {
      
      protected const STRING_GVG3RewardTipsVec:Vector.<uint> = Vector.<uint>([CONST_SYSTEMLANGUAGE.GVG_STRING_20,CONST_SYSTEMLANGUAGE.GVG_STRING_21,CONST_SYSTEMLANGUAGE.GVG_STRING_22,CONST_SYSTEMLANGUAGE.GVG_STRING_23]);
      
      protected var FType:uint;
      
      public function TWindowGVG3Match(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         super.ResourcesPerform_UIDispatch();
         FTF_OpenTime.text = STRING_TOPORGANIZATION.STRING_GVG2OpenTime[2];
         FTF_OpenTime.visible = false;
         FMC_Enter.visible = false;
         FMC_Join.visible = false;
         FMC_Apply.visible = false;
         FTF_Apply.text = STRING_TOPORGANIZATION.STRING_LastWeekRank;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TSystemLanguage = null;
         super.ResourcesPerform_UILocations();
         FMC_Picture.gotoAndStop(3);
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GVG_STRING_18) as TSystemLanguage;
         if(_loc1_ != null)
         {
            FTF_Explanation.htmlText = _loc1_.Desc;
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateTextField();
         this.UpdateButtonStatus();
      }
      
      override protected function UpdateTextField() : void
      {
         var _loc1_:String = null;
         var _loc2_:uint = 0;
         FTF_Name.text = STRING_TOPORGANIZATION.STRING_OrganizationName + FBaseOrganization.OrgName;
         _loc1_ = STRING_TOPORGANIZATION.STRING_WarStatus;
         if(this.FType == TYPE_GVG3BattleStart)
         {
            _loc1_ += STRING_TOPORGANIZATION.STRING_GVG3WarStatus[0];
         }
         else if(this.FType == TYPE_GVG3BattleEnter)
         {
            _loc1_ += STRING_TOPORGANIZATION.STRING_GVG3WarStatus[FTopOrganizationData.GVG3MyOrgStatus];
         }
         else if(FTopOrganizationData.GVG3MyOrgStatus > 1)
         {
            _loc2_ = FTopOrganizationData.GVG3MyOrgRank;
            if(_loc2_ != 0)
            {
               _loc1_ += STRING_TOPORGANIZATION.STRING_GVG3WarStatus[_loc2_ > 2 ? 5 : 6] + _loc2_;
            }
            else
            {
               _loc1_ += STRING_TOPORGANIZATION.STRING_GVG3WarStatus[4];
            }
         }
         else
         {
            _loc1_ += STRING_TOPORGANIZATION.STRING_GVG3WarStatus[FTopOrganizationData.GVG3MyOrgStatus];
         }
         FTF_WarStatus.text = _loc1_;
      }
      
      override protected function UpdateButtonStatus() : void
      {
         var _loc1_:Boolean = false;
         _loc1_ = this.FType > TYPE_GVG2BattleEnd;
         if(FTopOrganizationData.GVG3MyOrgStatus == 7)
         {
            _loc1_ = false;
         }
         FMC_Enter.visible = _loc1_;
         TGameUtil.setButtonMode(FMC_Enter,_loc1_);
         FMC_Enter.mouseEnabled = _loc1_;
         FMC_Apply.visible = _loc1_;
         FTF_OpenTime.visible = !_loc1_;
      }
      
      override protected function MCApplyOnClick(param1:MouseEvent) : void
      {
         this.ApplyOnOk(null);
      }
      
      override protected function ApplyOnOk(param1:Object) : void
      {
         if(FApplyOnClick != null)
         {
            FApplyOnClick(this,CONST_TOPORGANIZATION.TYPE_GVG3_LastRanking);
         }
      }
      
      override protected function MCEnterOnClick(param1:MouseEvent) : void
      {
         if(FEnterOnClick != null)
         {
            FEnterOnClick(this,CONST_TOPORGANIZATION.TYPE_CrossServerFinal);
         }
      }
      
      override protected function MCRewardOnOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         var _loc4_:TSystemLanguage = null;
         _loc3_ = uint((param1.currentTarget as MovieClip).name.split("_")[2]);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,this.STRING_GVG3RewardTipsVec[_loc3_]) as TSystemLanguage;
         if(_loc4_ != null)
         {
            FHint.Content = _loc4_.Desc;
            if(FOnHelpTipsOver != null)
            {
               FOnHelpTipsOver(this,FHint);
            }
         }
      }
      
      override protected function MCDetailOnMove(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GVG_STRING_17) as TSystemLanguage;
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
      
      public function UpdateGVG3UI(param1:uint = 0) : void
      {
         this.FType = param1;
         this.UpdateUI();
      }
   }
}

