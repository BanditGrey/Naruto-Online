package Processors.Game.Lobby.TopOrganization
{
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Organization.TBaseOrganizationMember;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TOPORGANIZATION;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowTopOrganization extends TProcessorWindowTemplate
   {
      
      protected var FMC_ExRanking:MovieClip;
      
      protected var FMC_EffectLeft:MovieClip;
      
      protected var FMC_EffectRight:MovieClip;
      
      protected var FWindowOrgPreliminary:TWindowOrgPreliminary;
      
      protected var FWindowGVG2Match:TWindowGVG2Match;
      
      protected var FWindowGVG3Match:TWindowGVG3Match;
      
      protected var FOrgMemberListDataVect:Vector.<TBaseOrganizationMember>;
      
      protected var FInitialized:Boolean;
      
      protected var FOnOpenWarUI:Function;
      
      protected var FOnOpenRankingUI:Function;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FApplyOnClick:Function;
      
      protected var FJoinOnClick:Function;
      
      public function TProcessorWindowTopOrganization(param1:TUIComponent)
      {
         super(param1);
         this.Init();
      }
      
      protected function Init() : void
      {
         this.FWindowOrgPreliminary = new TWindowOrgPreliminary(this);
         this.FWindowGVG2Match = new TWindowGVG2Match(this);
         this.FWindowGVG3Match = new TWindowGVG3Match(this);
         this.FInitialized = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TOPORGANIZATION.RESOURCESID_Swf_TopOrganization);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_TOPORGANIZATION.RESOURCE_ClassName_MC_TopOrganization) as Sprite;
         UIDispatch();
         this.FMC_ExRanking = FMainUI["MC_ExRanking"];
         TGameUtil.setButtonMode(this.FMC_ExRanking,true);
         this.FMC_ExRanking.visible = false;
         this.FMC_EffectLeft = FMainUI["MC_EffectLeft"];
         this.FMC_EffectRight = FMainUI["MC_EffectRight"];
         this.OrgPreliminaryDispatch();
         this.GVG2MatchDispatch();
         this.GVG3MatchDispatch();
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function OrgPreliminaryDispatch() : void
      {
         this.FWindowOrgPreliminary.Perform_UIDispatch(FMainUI["MC_OrgPreliminary"]);
         this.FWindowOrgPreliminary.Perform_UILocations();
         this.FWindowOrgPreliminary.EnterOnClick = this.ProcessorEnterOnClick;
         this.FWindowOrgPreliminary.ApplyOnClick = this.ProcessorApplyOnClick;
         this.FWindowOrgPreliminary.JoinOnClick = this.ProcessorJoinOnClick;
         this.FWindowOrgPreliminary.OnInventoryOver = this.ProcessorOnInventoryOver;
         this.FWindowOrgPreliminary.OnInventoryOut = this.ProcessorOnInventoryOut;
         this.FWindowOrgPreliminary.OnHelpTipsOver = this.ProcessorOnHelpTipsOver;
         this.FWindowOrgPreliminary.OnHelpTipsOut = this.ProcessorOnHelpTipsOut;
         this.FWindowOrgPreliminary.OnEffectText = this.ProcessorOnEffectText;
      }
      
      protected function GVG2MatchDispatch() : void
      {
         this.FWindowGVG2Match.Perform_UIDispatch(FMainUI["MC_GVG2Match"]);
         this.FWindowGVG2Match.Perform_UILocations();
         this.FWindowGVG2Match.EnterOnClick = this.ProcessorEnterOnClick;
         this.FWindowGVG2Match.ApplyOnClick = this.ProcessorApplyOnClick;
         this.FWindowGVG2Match.JoinOnClick = this.ProcessorJoinOnClick;
         this.FWindowGVG2Match.OnInventoryOver = this.ProcessorOnInventoryOver;
         this.FWindowGVG2Match.OnInventoryOut = this.ProcessorOnInventoryOut;
         this.FWindowGVG2Match.OnHelpTipsOver = this.ProcessorOnHelpTipsOver;
         this.FWindowGVG2Match.OnHelpTipsOut = this.ProcessorOnHelpTipsOut;
         this.FWindowGVG2Match.OnEffectText = this.ProcessorOnEffectText;
      }
      
      protected function GVG3MatchDispatch() : void
      {
         this.FWindowGVG3Match.Perform_UIDispatch(FMainUI["MC_GVG3Match"]);
         this.FWindowGVG3Match.Perform_UILocations();
         this.FWindowGVG3Match.EnterOnClick = this.ProcessorEnterOnClick;
         this.FWindowGVG3Match.ApplyOnClick = this.ProcessorApplyOnClick;
         this.FWindowGVG3Match.OnInventoryOver = this.ProcessorOnInventoryOver;
         this.FWindowGVG3Match.OnInventoryOut = this.ProcessorOnInventoryOut;
         this.FWindowGVG3Match.OnHelpTipsOver = this.ProcessorOnHelpTipsOver;
         this.FWindowGVG3Match.OnHelpTipsOut = this.ProcessorOnHelpTipsOut;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_ExRanking.addEventListener(MouseEvent.CLICK,this.MCExRankingOnClick,false,0,true);
         UILocations();
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TSystemLanguage = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GVG_Tips_01) as TSystemLanguage;
         FHelpTips.Content = _loc1_.Desc;
         super.ResourcesPerform_UIFinalize();
      }
      
      protected function UpdateUI() : void
      {
         this.FWindowOrgPreliminary.Update();
         this.FWindowGVG2Match.Update();
         this.FWindowGVG3Match.Update();
      }
      
      protected function ProcessorOnHelpTipsOver(param1:Object, param2:THint) : void
      {
         if(FOnHelpTipsOver != null)
         {
            FOnHelpTipsOver(this,param2);
         }
      }
      
      protected function ProcessorOnHelpTipsOut(param1:Object) : void
      {
         if(FOnHelpTipsOut != null)
         {
            FOnHelpTipsOut(this);
         }
      }
      
      protected function ProcessorOnEffectText(param1:String) : void
      {
         if(FOnEffectText != null)
         {
            FOnEffectText(param1);
         }
      }
      
      protected function ProcessorEnterOnClick(param1:Object, param2:int) : void
      {
         if(this.FOnOpenWarUI != null)
         {
            this.FOnOpenWarUI(this,param2);
         }
      }
      
      protected function ProcessorApplyOnClick(param1:Object, param2:uint) : void
      {
         if(this.FApplyOnClick != null)
         {
            this.FApplyOnClick(this,param2);
         }
      }
      
      protected function ProcessorJoinOnClick(param1:Object, param2:uint) : void
      {
         if(this.FJoinOnClick != null)
         {
            this.FJoinOnClick(this,param2);
         }
      }
      
      protected function MCExRankingOnClick(param1:MouseEvent) : void
      {
         if(this.FOnOpenRankingUI != null)
         {
            this.FOnOpenRankingUI(this);
         }
      }
      
      protected function ProcessorOnInventoryOver(param1:Object, param2:Object) : void
      {
         if(this.FOnInventoryOver != null)
         {
            this.FOnInventoryOver(param2);
         }
      }
      
      protected function ProcessorOnInventoryOut(param1:Object, param2:Object) : void
      {
         if(this.FOnInventoryOut != null)
         {
            this.FOnInventoryOut(param2);
         }
      }
      
      public function get OnOpenWarUI() : Function
      {
         return this.FOnOpenWarUI;
      }
      
      public function set OnOpenWarUI(param1:Function) : void
      {
         this.FOnOpenWarUI = param1;
      }
      
      public function get OnOpenRankingUI() : Function
      {
         return this.FOnOpenRankingUI;
      }
      
      public function set OnOpenRankingUI(param1:Function) : void
      {
         this.FOnOpenRankingUI = param1;
      }
      
      public function get OnInventoryOver() : Function
      {
         return this.FOnInventoryOver;
      }
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function get OnInventoryOut() : Function
      {
         return this.FOnInventoryOut;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
      }
      
      public function get ApplyOnClick() : Function
      {
         return this.FApplyOnClick;
      }
      
      public function set ApplyOnClick(param1:Function) : void
      {
         this.FApplyOnClick = param1;
      }
      
      public function get JoinOnClick() : Function
      {
         return this.FJoinOnClick;
      }
      
      public function set JoinOnClick(param1:Function) : void
      {
         this.FJoinOnClick = param1;
      }
      
      public function Update() : void
      {
         this.UpdateUI();
      }
      
      public function OpenButtonStatus(param1:Boolean = true) : void
      {
         this.FWindowOrgPreliminary.OpenButtonStatus(param1);
      }
      
      public function SetButtonStatues(param1:Boolean) : void
      {
         this.FWindowOrgPreliminary.SetButtonStatues(param1);
         this.FWindowGVG2Match.SetButtonStatues(param1);
         this.FWindowGVG3Match.SetButtonStatues(param1);
      }
      
      public function UpdateOrgRank() : void
      {
         this.FWindowOrgPreliminary.UpdateOrgRank();
      }
      
      public function SetOrgMemberListData(param1:Vector.<TBaseOrganizationMember>) : void
      {
         this.FOrgMemberListDataVect = param1;
         this.FWindowOrgPreliminary.SetOrgMemberListData(param1);
         this.FWindowGVG2Match.SetOrgMemberListData(param1);
         this.FWindowGVG3Match.SetOrgMemberListData(param1);
      }
      
      public function OpenGVG2ButtonStatus(param1:uint) : void
      {
         this.FWindowGVG2Match.UpdateGVG2ButtonStatus(param1);
      }
      
      public function UpdateGVG2TextStatus(param1:uint) : void
      {
         this.FWindowGVG2Match.UpdateGVG2Text(param1);
      }
      
      public function UpdateGVG2UI() : void
      {
         this.FWindowGVG2Match.Update();
      }
      
      public function UpdateGVG3UI(param1:uint = 0) : void
      {
         this.FWindowGVG3Match.UpdateGVG3UI(param1);
      }
   }
}

