package Processors.Game.Lobby.TopOrganization
{
   import Components.ScrollBar.TScrollBar;
   import Components.Standard.TUITab;
   import Externals.SExternalCore;
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Logics.TopOrganization.TJoinOrganization;
   import Logics.TopOrganization.TOrganizationTop3Ranking;
   import Logics.TopOrganization.TTopOrganizationData;
   import Logics.TopOrganization.TTopOrganizationReport;
   import Logics.TopOrganization.TTopOrganizationReports;
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
   import flash.events.TextEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class TProcessorWindowSeeReport extends TProcessorWindowTemplate
   {
      
      protected const STRING_TipsVec:Vector.<uint> = Vector.<uint>([CONST_SYSTEMLANGUAGE.GVG_STRING_05,CONST_SYSTEMLANGUAGE.GVG_STRING_06,CONST_SYSTEMLANGUAGE.GVG_STRING_07,CONST_SYSTEMLANGUAGE.GVG_STRING_08]);
      
      protected const STATE_Common:int = -1;
      
      protected const STATE_Top3:int = 0;
      
      protected const STATE_ObtainOrgRank:int = 1;
      
      protected const STATE_NORANK:uint = 0;
      
      protected const STATE_RANK:uint = 1;
      
      protected var FMC_PreliminaryExplanation:MovieClip;
      
      protected var FMC_SequenceWins:SimpleButton;
      
      protected var FMC_Return:SimpleButton;
      
      protected var FUITab:TUITab;
      
      protected var FTabIndex:int;
      
      protected var FRankingBoxVec:Vector.<MovieClip>;
      
      protected var FHint:THint;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FReportItems:Vector.<DisplayObject>;
      
      protected var FHistoryReportItems:Vector.<DisplayObject>;
      
      protected var FOrgRankScrollBar:TScrollBar;
      
      protected var FTopOrganizationData:TTopOrganizationData;
      
      protected var FShowTextType:int;
      
      protected var FOrganizationRank:uint;
      
      protected var FIsShowBattleStartTip:Boolean;
      
      protected var FIsShowTop3Tip:Boolean;
      
      protected var FIsShowSeeOrgOrPersonalReport:Boolean;
      
      protected var FIsNoOrgJoin:Boolean;
      
      protected var FOnOpenRankingUI:Function;
      
      protected var FOnReportReqest:Function;
      
      protected var FOnReturnMainUI:Function;
      
      public function TProcessorWindowSeeReport(param1:TUIComponent)
      {
         super(param1);
         this.Init();
      }
      
      protected function Init() : void
      {
         this.FUITab = new TUITab(this);
         this.FRankingBoxVec = new Vector.<MovieClip>(CONST_TOPORGANIZATION.CAPACITY_Boxes);
         this.FHint = new THint();
         this.FReportItems = new Vector.<DisplayObject>();
         this.FHistoryReportItems = new Vector.<DisplayObject>();
         this.FTopOrganizationData = SLogicsCore.TopOrganizationData;
         this.FTabIndex = 0;
         this.FShowTextType = -1;
         this.FOrganizationRank = 0;
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
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_TOPORGANIZATION.RESOURCE_ClassName_MC_SeeReport) as Sprite;
         UIDispatch();
         _loc2_ = CONST_TOPORGANIZATION.CAPACITY_Tabs;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = FMainUI["MC_Tab_" + _loc1_];
            this.FUITab.SetTabByIndex(_loc3_,_loc1_);
            if(_loc1_ > 0)
            {
               this.FUITab.SetTabHideByIndex(_loc1_);
            }
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         _loc2_ = CONST_TOPORGANIZATION.CAPACITY_Boxes;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = FMainUI["MC_Boxes"]["MC_Box_" + _loc1_] as MovieClip;
            _loc4_.gotoAndStop(_loc1_ + 1);
            this.FRankingBoxVec[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FMC_PreliminaryExplanation = FMainUI["MC_PreliminaryExplanation"];
         this.FMC_SequenceWins = FMainUI["MC_SequenceWins"];
         this.FMC_Return = FMainUI["MC_Return"];
         this.FScrollBar = new TScrollBar(FMainUI["MC_ShowReport"]["mc_list"],350,false,2);
         this.FOrgRankScrollBar = new TScrollBar(FMainUI["MC_OrganizationRank"]["mc_list"],321);
         this.FOrgRankScrollBar.ScrollToUp();
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
         this.FMC_PreliminaryExplanation.addEventListener(MouseEvent.MOUSE_MOVE,this.MCExplanationOnOver,false,0,true);
         this.FMC_PreliminaryExplanation.addEventListener(MouseEvent.MOUSE_OUT,this.MCExplanationOnOut,false,0,true);
         this.FMC_SequenceWins.addEventListener(MouseEvent.CLICK,this.MCSequenceWinsOnClick,false,0,true);
         this.FMC_Return.addEventListener(MouseEvent.CLICK,this.MCReturnOnClick,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TSystemLanguage = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GVG_Tips_06) as TSystemLanguage;
         FHelpTips.Content = _loc1_.Desc;
         super.ResourcesPerform_UIFinalize();
      }
      
      protected function UpdateUI(param1:int = -1) : void
      {
         var _loc2_:Vector.<DisplayObject> = null;
         var _loc3_:TextField = null;
         while(this.FHistoryReportItems.length > 0)
         {
            this.FHistoryReportItems.pop();
         }
         this.FHistoryReportItems.length = 0;
         if(param1 == -1)
         {
            _loc2_ = this.FReportItems;
         }
         else if(param1 == CONST_TOPORGANIZATION.TYPE_OrganizationReport)
         {
            this.CreateReportItems(this.FTopOrganizationData.OrganizationReports);
            _loc2_ = this.FHistoryReportItems;
         }
         else if(param1 == CONST_TOPORGANIZATION.TYPE_PersonalReport)
         {
            this.CreateReportItems(this.FTopOrganizationData.PersonalReports);
            _loc2_ = this.FHistoryReportItems;
         }
         this.FScrollBar.Clear();
         this.FScrollBar.AddItems(_loc2_);
         this.FScrollBar.ScrollToUp();
      }
      
      protected function CreateReportItems(param1:TTopOrganizationReports) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TextField = null;
         var _loc5_:TTopOrganizationReport = null;
         _loc3_ = param1.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.CreateTextField();
            _loc5_ = param1.GetTopOrganizationReportByIndex(_loc2_);
            if(_loc5_.ReportID != "0")
            {
               _loc4_.addEventListener(TextEvent.LINK,this.WatchReportOnCLick);
               _loc4_.htmlText = this.MakeHtmlTextInfo(_loc5_);
            }
            this.FHistoryReportItems.unshift(_loc4_);
            _loc2_++;
         }
      }
      
      protected function UpdateTabStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = CONST_TOPORGANIZATION.CAPACITY_Tabs;
         _loc1_ = 1;
         while(_loc1_ < _loc2_)
         {
            this.FUITab.SetTabShowByIndex(_loc1_);
            _loc1_++;
         }
      }
      
      protected function UpdateReportUI() : void
      {
         var _loc1_:String = null;
         var _loc2_:Boolean = false;
         var _loc3_:TTopOrganizationReport = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:TOrganizationTop3Ranking = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:uint = 0;
         _loc2_ = false;
         _loc1_ = "";
         _loc8_ = "";
         if(this.FShowTextType == this.STATE_Common)
         {
            _loc3_ = this.FTopOrganizationData.TopOrganizationReports.GetTopOrganizationReportByIndex(this.FTopOrganizationData.TopOrganizationReports.Count - 1);
            if(_loc3_.ReportID == "0")
            {
               if(_loc3_.WinSign == 1)
               {
                  _loc4_ = _loc3_.AttackOrg;
               }
               else
               {
                  _loc4_ = _loc3_.DefendOrg;
               }
               _loc1_ = TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_OrgWin,_loc4_);
            }
            else
            {
               _loc1_ = this.MakeHtmlTextInfo(_loc3_);
               _loc2_ = true;
            }
         }
         else if(this.FShowTextType == this.STATE_Top3)
         {
            if(this.FTopOrganizationData.OrganizationTop3Rankings.Count > 0)
            {
               if(!this.FIsShowTop3Tip)
               {
                  _loc1_ = STRING_TOPORGANIZATION.STRING_Congratulations;
                  _loc10_ = this.FTopOrganizationData.OrganizationTop3Rankings.Count;
                  _loc9_ = 0;
                  while(_loc9_ < _loc10_)
                  {
                     _loc7_ = this.FTopOrganizationData.OrganizationTop3Rankings.GetTopOrganizationReportByIndex(_loc9_);
                     if(_loc7_ != null)
                     {
                        _loc1_ += "<font color = \'#00FF00\'>" + _loc7_.OrganizaitonName + "</font>，";
                        _loc8_ += _loc7_.Rank + "，";
                     }
                     _loc9_++;
                  }
                  _loc1_ = _loc1_.slice(0,_loc1_.length - 1);
                  _loc8_ = _loc8_.slice(0,_loc8_.length - 1);
                  _loc1_ += STRING_TOPORGANIZATION.STRING_Top3 + _loc8_ + STRING_TOPORGANIZATION.STRING_Rank;
                  this.FIsShowTop3Tip = true;
               }
            }
         }
         else if(this.FShowTextType == this.STATE_ObtainOrgRank)
         {
            if(!this.FIsShowSeeOrgOrPersonalReport)
            {
               if(this.FTopOrganizationData.OrgPreliminaryRanking != 0)
               {
                  _loc1_ = TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_FirstMatchEnd[0],this.FTopOrganizationData.OrgPreliminaryRanking);
               }
               else
               {
                  _loc1_ = STRING_TOPORGANIZATION.FORMAT_FirstMatchEnd[1];
               }
               this.FIsShowSeeOrgOrPersonalReport = true;
            }
         }
         if(_loc1_ != "")
         {
            this.AddTextFieldIntoScrollBar(_loc1_,_loc2_);
         }
      }
      
      protected function ShowRankings() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:TTopOrganizationReport = null;
         var _loc4_:String = null;
         _loc4_ = "";
         if(this.FShowTextType == this.STATE_Common)
         {
            _loc3_ = this.FTopOrganizationData.TopOrganizationReports.GetTopOrganizationReportByIndex(this.FTopOrganizationData.TopOrganizationReports.Count - 1);
            if(_loc3_.ReportID != "0" && _loc3_.LoserRank != 0)
            {
               if(_loc3_.WinSign == 1)
               {
                  _loc1_ = _loc3_.AttackOrg;
                  _loc2_ = _loc3_.DefendOrg;
               }
               else
               {
                  _loc1_ = _loc3_.DefendOrg;
                  _loc2_ = _loc3_.AttackOrg;
               }
               _loc4_ += TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_Defeated,_loc2_,_loc1_,_loc3_.LoserRank);
               this.AddTextFieldIntoScrollBar(_loc4_,true);
            }
         }
      }
      
      protected function CreateTextField() : TextField
      {
         var _loc1_:TextField = null;
         var _loc2_:TextFormat = null;
         _loc1_ = new TextField();
         _loc1_.width = 470;
         _loc1_.wordWrap = true;
         _loc1_.autoSize = TextFieldAutoSize.CENTER;
         _loc1_.multiline = true;
         _loc1_.selectable = false;
         _loc2_ = new TextFormat();
         _loc2_.color = 16777215;
         _loc1_.defaultTextFormat = _loc2_;
         return _loc1_;
      }
      
      protected function MakeHtmlTextInfo(param1:TTopOrganizationReport) : String
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         _loc15_ = uint(SLogicsCore.Character.Identifier0);
         _loc16_ = uint(SLogicsCore.Character.Identifier1);
         _loc17_ = uint(SLogicsCore.Organization.OrgId);
         _loc3_ = "";
         if(param1 == null)
         {
            return "";
         }
         _loc8_ = param1.SequenceWinCount;
         if(param1.WinSign == 1)
         {
            _loc9_ = param1.AttackerID0;
            _loc10_ = param1.AttackerID1;
            _loc11_ = param1.DefenderID0;
            _loc12_ = param1.DefenderID1;
            _loc4_ = param1.Attacker;
            _loc5_ = param1.Defender;
            _loc6_ = param1.AttackOrg;
            _loc7_ = param1.DefendOrg;
            _loc13_ = param1.AttackOrgID;
            _loc14_ = param1.DefendOrgID;
         }
         else
         {
            _loc9_ = param1.DefenderID0;
            _loc10_ = param1.DefenderID1;
            _loc11_ = param1.AttackerID0;
            _loc12_ = param1.AttackerID1;
            _loc4_ = param1.Defender;
            _loc5_ = param1.Attacker;
            _loc6_ = param1.DefendOrg;
            _loc7_ = param1.AttackOrg;
            _loc13_ = param1.DefendOrgID;
            _loc14_ = param1.AttackOrgID;
         }
         _loc3_ += TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_Player,_loc9_ == _loc15_ && _loc10_ == _loc16_ ? "#FE0000" : "#FF6600",_loc4_);
         _loc3_ += TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_Organization,_loc17_ == _loc13_ ? "#FE0000" : "#00FF00",_loc6_);
         _loc3_ += STRING_TOPORGANIZATION.STRING_Win;
         _loc3_ += TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_Player,_loc11_ == _loc15_ && _loc12_ == _loc16_ ? "#FE0000" : "#FF6600",_loc5_);
         _loc3_ += TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_Organization,_loc17_ == _loc14_ ? "#FE0000" : "#00FF00",_loc7_) + "\n";
         _loc3_ += TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_Player,_loc9_ == _loc15_ && _loc10_ == _loc16_ ? "#FE0000" : "#FF6600",_loc4_);
         _loc3_ += TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_Win,_loc8_ > 10 ? "#FE0000" : (_loc8_ > 5 ? "#FFFF00" : "#9900CF"),_loc8_,param1.RestHPPercent);
         return _loc3_ + TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_WatchReport,param1.ReportID);
      }
      
      protected function UpdateOrganizationRankingsUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:TJoinOrganization = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TextField = null;
         var _loc8_:TextField = null;
         var _loc9_:TextField = null;
         var _loc10_:TextField = null;
         this.FOrgRankScrollBar.Clear();
         _loc2_ = this.FTopOrganizationData.JoinOrganizations.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = "";
            _loc5_ = TUtilityReflection.CreateDisplayObjectInstance("MC_UIOrgRank") as MovieClip;
            _loc6_ = _loc5_["MC_Bg"];
            _loc7_ = _loc5_["TF_State"];
            _loc8_ = _loc5_["TF_OrgName"];
            _loc9_ = _loc5_["TF_Log"];
            _loc4_ = this.FTopOrganizationData.JoinOrganizations.GetTopOrganizationReportByIndex(_loc1_);
            _loc6_.gotoAndStop((_loc1_ + 1) % 2 + 1);
            if(this.FOrganizationRank == this.STATE_NORANK)
            {
               _loc7_.text = STRING_TOPORGANIZATION.STRING_Battling;
            }
            else
            {
               _loc7_.text = "No." + _loc4_.Rank;
            }
            _loc8_.text = _loc4_.OrgName;
            _loc9_.text = _loc4_.TotalMembers.toString();
            this.FOrgRankScrollBar.AddItem(_loc5_);
            _loc1_++;
         }
         this.FOrgRankScrollBar.ScrollToUp();
      }
      
      protected function CheckNoOrganizationJoin() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = this.FTopOrganizationData.JoinOrganizations.Count;
         if(_loc1_ == 0)
         {
            this.AddTextFieldIntoScrollBar(STRING_TOPORGANIZATION.STRING_NoOrgJoin);
         }
      }
      
      protected function UpdateBattleStartTipsUI() : void
      {
         this.AddTextFieldIntoScrollBar(STRING_TOPORGANIZATION.STRING_BattleStart);
      }
      
      protected function AddTextFieldIntoScrollBar(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:TextField = null;
         _loc3_ = this.CreateTextField();
         if(param2)
         {
            _loc3_.htmlText = param1;
            _loc3_.addEventListener(TextEvent.LINK,this.WatchReportOnCLick);
         }
         else
         {
            _loc3_.htmlText = param1;
         }
         this.FReportItems.splice(0,0,_loc3_);
         this.FScrollBar.Clear();
         this.FScrollBar.AddItems(this.FReportItems);
         this.FScrollBar.ScrollToUp();
      }
      
      override protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         this.FUITab.Reset();
         super.ButtonCloseOnClick(param1);
      }
      
      protected function WatchReportOnCLick(param1:TextEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = param1.text;
         SExternalCore.NavigateToFightReport(_loc2_);
      }
      
      protected function MCRewardOnOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         var _loc4_:TSystemLanguage = null;
         _loc3_ = uint((param1.currentTarget as MovieClip).name.split("_")[2]);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,this.STRING_TipsVec[_loc3_]) as TSystemLanguage;
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
      
      protected function MCExplanationOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GVG_STRING_04) as TSystemLanguage;
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
      
      protected function MCSequenceWinsOnClick(param1:MouseEvent) : void
      {
         if(this.FOnOpenRankingUI != null)
         {
            this.FOnOpenRankingUI(this);
         }
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         if(param1 is int)
         {
            this.FTabIndex = param1 as int;
         }
         if(this.FTabIndex != 0)
         {
            if(this.FOnReportReqest != null)
            {
               this.FOnReportReqest(this,this.FTabIndex - 1);
            }
         }
         else
         {
            this.UpdateUI();
         }
      }
      
      protected function MCReturnOnClick(param1:MouseEvent) : void
      {
         if(this.FOnReturnMainUI != null)
         {
            this.FOnReturnMainUI(this);
         }
      }
      
      public function get OnOpenRankingUI() : Function
      {
         return this.FOnOpenRankingUI;
      }
      
      public function set OnOpenRankingUI(param1:Function) : void
      {
         this.FOnOpenRankingUI = param1;
      }
      
      public function get OnReportReqest() : Function
      {
         return this.FOnReportReqest;
      }
      
      public function set OnReportReqest(param1:Function) : void
      {
         this.FOnReportReqest = param1;
      }
      
      public function set OnReturnMainUI(param1:Function) : void
      {
         this.FOnReturnMainUI = param1;
      }
      
      public function Update(param1:int) : void
      {
         this.UpdateUI(param1);
      }
      
      public function UpdateBattlingReport() : void
      {
         this.FShowTextType = this.STATE_Common;
         this.UpdateReportUI();
         this.ShowRankings();
      }
      
      public function BattleEnd() : void
      {
         this.UpdateTabStatus();
      }
      
      public function UpdateOrganizationRankings() : void
      {
         this.UpdateOrganizationRankingsUI();
         if(!this.FIsNoOrgJoin)
         {
            this.CheckNoOrganizationJoin();
            this.FIsNoOrgJoin = true;
         }
      }
      
      public function UpdateTop3() : void
      {
         this.FShowTextType = this.STATE_Top3;
         this.UpdateReportUI();
      }
      
      public function UpdateOrgRank() : void
      {
         this.FShowTextType = this.STATE_ObtainOrgRank;
         this.UpdateReportUI();
         this.FOrganizationRank = this.STATE_RANK;
         this.UpdateOrganizationRankingsUI();
      }
      
      public function UpdateBattleStartTips() : void
      {
         if(!this.FIsShowBattleStartTip)
         {
            this.UpdateBattleStartTipsUI();
            this.FIsShowBattleStartTip = true;
         }
      }
      
      public function Reset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         this.FShowTextType = -1;
         _loc2_ = CONST_TOPORGANIZATION.CAPACITY_Tabs;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc1_ > 0)
            {
               this.FUITab.SetTabHideByIndex(_loc1_);
            }
            else
            {
               this.FUITab.SetTabShowByIndex(_loc1_);
            }
            _loc1_++;
         }
         this.FIsShowBattleStartTip = false;
         this.FIsShowTop3Tip = false;
         this.FIsShowSeeOrgOrPersonalReport = false;
         this.FIsNoOrgJoin = false;
         this.FScrollBar.Clear();
         this.FOrgRankScrollBar.Clear();
         this.ButtonCloseOnClick(null);
      }
   }
}

