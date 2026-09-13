package Processors.Game.Lobby.TopOrganization
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Logics.TopOrganization.TGVG2BattleReport;
   import Logics.TopOrganization.TGVG2BattleReports;
   import Logics.TopOrganization.TJoinGVG2MatchOrg;
   import Logics.TopOrganization.TTopOrganizationData;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TOPORGANIZATION;
   import Resources.Strings.STRING_TOPORGANIZATION;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class TProcessorWindowGVG2Report extends TProcessorWindowTemplate
   {
      
      protected const CAPACITY_ORGS:uint = 2;
      
      protected const STRING_RewardTipsVec:Vector.<uint> = Vector.<uint>([CONST_SYSTEMLANGUAGE.GVG_STRING_13,CONST_SYSTEMLANGUAGE.GVG_STRING_14,CONST_SYSTEMLANGUAGE.GVG_STRING_15,CONST_SYSTEMLANGUAGE.GVG_STRING_16]);
      
      protected var FMC_Return:SimpleButton;
      
      protected var FMC_GVG2Explanation:MovieClip;
      
      protected var FRankingBoxVec:Vector.<MovieClip>;
      
      protected var FPersonalReportItems:Vector.<DisplayObject>;
      
      protected var FOrgReportItems:Vector.<DisplayObject>;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FMyOrgScrollBar:TScrollBar;
      
      protected var FTopOrganizationData:TTopOrganizationData;
      
      protected var FHint:THint;
      
      protected var FHistoryReportItems:Vector.<DisplayObject>;
      
      protected var FMC_MyOrg:MovieClip;
      
      protected var FMC_EnemyOrg:MovieClip;
      
      protected var FLoseCount:uint;
      
      protected var FOnReturnMainUI:Function;
      
      public function TProcessorWindowGVG2Report(param1:TUIComponent)
      {
         super(param1);
         this.Init();
      }
      
      protected function Init() : void
      {
         this.FRankingBoxVec = new Vector.<MovieClip>(CONST_TOPORGANIZATION.CAPACITY_Boxes);
         this.FHint = new THint();
         this.FPersonalReportItems = new Vector.<DisplayObject>();
         this.FOrgReportItems = new Vector.<DisplayObject>();
         this.FHistoryReportItems = new Vector.<DisplayObject>();
         this.FTopOrganizationData = SLogicsCore.TopOrganizationData;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TOPORGANIZATION.RESOURCESID_Swf_TopOrganization);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_TOPORGANIZATION.RESOURCE_ClassName_MC_GVG2BattleUI) as Sprite;
         UIDispatch();
         _loc2_ = CONST_TOPORGANIZATION.CAPACITY_Boxes;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = FMainUI["MC_Boxes"]["MC_Box_" + _loc1_] as MovieClip;
            _loc4_.gotoAndStop(_loc1_ + 1);
            this.FRankingBoxVec[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FMC_Return = FMainUI["MC_Return"];
         this.FMC_GVG2Explanation = FMainUI["MC_GVG2Explanation"];
         this.FMC_EnemyOrg = FMainUI["MC_EnemyOrg"];
         this.FMC_MyOrg = FMainUI["MC_MyOrg"];
         this.FScrollBar = new TScrollBar(FMainUI["MC_ShowReport"]["mc_list"],225,false,2);
         this.FMyOrgScrollBar = new TScrollBar(FMainUI["MC_MyOrgReport"]["mc_list"],125);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         UILocations();
         _loc2_ = CONST_TOPORGANIZATION.CAPACITY_Boxes;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FRankingBoxVec[_loc1_];
            _loc3_.addEventListener(MouseEvent.MOUSE_MOVE,this.MCRewardOnOver,false,0,true);
            _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.MCRewardOnOut,false,0,true);
            _loc1_++;
         }
         this.FMC_GVG2Explanation.addEventListener(MouseEvent.MOUSE_MOVE,this.MCExplanationOnOver,false,0,true);
         this.FMC_GVG2Explanation.addEventListener(MouseEvent.MOUSE_OUT,this.MCExplanationOnOut,false,0,true);
         this.FMC_Return.addEventListener(MouseEvent.CLICK,this.MCReturnOnClick,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TSystemLanguage = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GVG_Tips_08) as TSystemLanguage;
         FHelpTips.Content = _loc1_.Desc;
         super.ResourcesPerform_UIFinalize();
      }
      
      protected function CreateTextField() : TextField
      {
         var _loc1_:TextField = null;
         var _loc2_:TextFormat = null;
         _loc1_ = new TextField();
         _loc1_.width = 550;
         _loc1_.wordWrap = true;
         _loc1_.autoSize = TextFieldAutoSize.CENTER;
         _loc1_.multiline = true;
         _loc1_.selectable = false;
         _loc2_ = new TextFormat();
         _loc2_.color = 16777215;
         _loc1_.defaultTextFormat = _loc2_;
         return _loc1_;
      }
      
      protected function AddTextFieldIntoScrollBar(param1:String, param2:Vector.<DisplayObject>, param3:TScrollBar) : void
      {
         var _loc4_:TextField = null;
         _loc4_ = this.CreateTextField();
         _loc4_.htmlText = param1;
         param2.splice(0,0,_loc4_);
         param3.Clear();
         param3.AddItems(param2);
         param3.ScrollToUp();
      }
      
      protected function CreatePersonalHtmlTextInfo(param1:TGVG2BattleReport) : String
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         var _loc10_:String = null;
         _loc3_ = uint(SLogicsCore.Organization.OrgId);
         _loc2_ = "";
         _loc4_ = "";
         _loc5_ = "";
         _loc6_ = "";
         _loc7_ = "";
         _loc9_ = "";
         _loc10_ = "";
         _loc5_ = param1.WinnerUserName;
         _loc4_ = param1.LoserUserName;
         _loc6_ = param1.WinnerOrgName;
         _loc7_ = param1.LoserOrgName;
         _loc8_ = param1.LeftHP;
         _loc10_ = param1.WinnerOrgServerName;
         _loc9_ = param1.LoserOrgServerName;
         return TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_PersonalReport,_loc5_,_loc10_,_loc6_,_loc4_,_loc9_,_loc7_,_loc8_);
      }
      
      protected function CreateOrgHtmlTextInfo(param1:TGVG2BattleReport) : String
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc3_ = uint(SLogicsCore.Organization.OrgId);
         _loc2_ = "";
         _loc4_ = "";
         _loc5_ = "";
         _loc6_ = "";
         _loc7_ = "";
         _loc8_ = "";
         _loc5_ = param1.WinnerOrgName;
         _loc6_ = param1.LoserOrgName;
         _loc8_ = param1.WinnerOrgServerName;
         _loc7_ = param1.LoserOrgServerName;
         if(_loc3_ == param1.LoserOrgID)
         {
            _loc9_ = param1.LoserFIghtCircles;
         }
         else if(_loc3_ == param1.WinnerOrgID)
         {
            _loc9_ = param1.WinnerFightCircles;
         }
         _loc2_ = TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_Circle,_loc9_) + "\n";
         return _loc2_ + TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_OrgReport,_loc5_,_loc8_,_loc6_,_loc7_,STRING_TOPORGANIZATION.STRING_ORGSTATUS[this.FLoseCount]);
      }
      
      protected function UpdatePersonalReport(param1:TGVG2BattleReport) : void
      {
         var _loc2_:String = null;
         _loc2_ = this.CreatePersonalHtmlTextInfo(param1);
         this.AddTextFieldIntoScrollBar(_loc2_,this.FPersonalReportItems,this.FScrollBar);
      }
      
      protected function UpdateOrgReport(param1:TGVG2BattleReport) : void
      {
         var _loc2_:String = null;
         var _loc3_:TextField = null;
         _loc2_ = this.CreateOrgHtmlTextInfo(param1);
         this.AddTextFieldIntoScrollBar(_loc2_,this.FOrgReportItems,this.FMyOrgScrollBar);
         if(this.FTopOrganizationData.GVG2IsBattling)
         {
            _loc3_ = this.CreateTextField();
            _loc3_.htmlText = _loc2_;
            this.FPersonalReportItems.splice(0,0,_loc3_);
            this.FScrollBar.Clear();
            this.FScrollBar.AddItems(this.FPersonalReportItems);
            this.FScrollBar.ScrollToUp();
         }
      }
      
      protected function UpdateReportUI() : void
      {
         var _loc1_:TGVG2BattleReports = null;
         var _loc2_:TGVG2BattleReport = null;
         _loc1_ = this.FTopOrganizationData.GVG2BattleReports;
         _loc2_ = _loc1_.GetGVG2BattleReportByIndex(_loc1_.Count - 1);
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.WinnerUserID0 == 0 && _loc2_.WinnerUserID1 == 0)
         {
            this.UpdateOrgReport(_loc2_);
         }
         else
         {
            this.UpdatePersonalReport(_loc2_);
         }
      }
      
      protected function UpdateBattleBoth() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TGVG2BattleReport = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:TJoinGVG2MatchOrg = null;
         _loc5_ = "";
         _loc6_ = "";
         _loc7_ = "";
         _loc8_ = "";
         _loc4_ = this.FTopOrganizationData.GVG2BattleReports.GetGVG2BattleReportByIndex(this.FTopOrganizationData.GVG2BattleReports.Count - 1);
         _loc5_ = SLogicsCore.Organization.OrgName;
         if(_loc4_.LoserOrgID == SLogicsCore.Organization.OrgId)
         {
            _loc7_ = _loc4_.LoserOrgServerName;
            _loc8_ = _loc4_.WinnerOrgServerName;
            _loc6_ = _loc4_.WinnerOrgName;
         }
         else if(_loc4_.WinnerOrgID == SLogicsCore.Organization.OrgId)
         {
            _loc7_ = _loc4_.WinnerOrgServerName;
            _loc8_ = _loc4_.LoserOrgServerName;
            _loc6_ = _loc4_.LoserOrgName;
         }
         this.FMC_MyOrg["TF_OrgName"].text = _loc5_;
         this.FMC_MyOrg["TF_ServerName"].text = _loc7_;
         this.FMC_EnemyOrg["TF_OrgName"].text = _loc6_;
         this.FMC_EnemyOrg["TF_ServerName"].text = _loc8_;
      }
      
      protected function MCExplanationOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GVG_STRING_12) as TSystemLanguage;
         this.FHint.Content = _loc2_.Desc;
         if(FOnHelpTipsOver != null)
         {
            FOnHelpTipsOver(this,this.FHint);
         }
      }
      
      protected function MCExplanationOnOut(param1:MouseEvent) : void
      {
         if(FOnHelpTipsOut != null)
         {
            FOnHelpTipsOut(this);
         }
      }
      
      protected function MCRewardOnOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         var _loc4_:TSystemLanguage = null;
         _loc3_ = uint((param1.currentTarget as MovieClip).name.split("_")[2]);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,this.STRING_RewardTipsVec[_loc3_]) as TSystemLanguage;
         this.FHint.Content = _loc4_.Desc;
         if(FOnHelpTipsOver != null)
         {
            FOnHelpTipsOver(this,this.FHint);
         }
      }
      
      protected function MCRewardOnOut(param1:MouseEvent) : void
      {
         if(FOnHelpTipsOut != null)
         {
            FOnHelpTipsOut(this);
         }
      }
      
      protected function MCReturnOnClick(param1:MouseEvent) : void
      {
         if(this.FOnReturnMainUI != null)
         {
            this.FOnReturnMainUI(this);
         }
      }
      
      public function set OnReturnMainUI(param1:Function) : void
      {
         this.FOnReturnMainUI = param1;
      }
      
      public function UpdateGVG2BattleReport() : void
      {
         this.UpdateBattleBoth();
         this.UpdateReportUI();
      }
      
      public function UpdateHistoryReport() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TGVG2BattleReport = null;
         var _loc4_:TextField = null;
         var _loc5_:uint = 0;
         _loc2_ = this.FOrgReportItems.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FOrgReportItems.pop();
            _loc1_++;
         }
         this.FOrgReportItems.length = 0;
         this.FLoseCount = 0;
         _loc2_ = this.FTopOrganizationData.GVG2BattleReports.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FTopOrganizationData.GVG2BattleReports.GetGVG2BattleReportByIndex(_loc1_);
            if(_loc3_.LoserOrgID == SLogicsCore.Organization.OrgId)
            {
               _loc5_ = _loc3_.LoserCount;
               this.FLoseCount = _loc5_;
            }
            this.UpdateOrgReport(_loc3_);
            _loc1_++;
         }
         _loc4_ = this.CreateTextField();
         _loc4_.htmlText = STRING_TOPORGANIZATION.STRING_GVG2End[_loc5_];
         this.FOrgReportItems.splice(0,0,_loc4_);
         this.FMyOrgScrollBar.Clear();
         this.FMyOrgScrollBar.AddItems(this.FOrgReportItems);
         this.FMyOrgScrollBar.ScrollToUp();
      }
      
      public function UpdateBattleStartTips(param1:Boolean = false) : void
      {
         if(param1)
         {
            this.AddTextFieldIntoScrollBar(STRING_TOPORGANIZATION.STRING_GVG2BattleStart,this.FPersonalReportItems,this.FScrollBar);
         }
         this.FMC_EnemyOrg.visible = !param1;
         this.FMC_MyOrg.visible = !param1;
      }
      
      public function Reset() : void
      {
         this.FLoseCount = 0;
      }
   }
}

