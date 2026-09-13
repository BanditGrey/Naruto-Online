package Processors.Game.Lobby.TopOrganization
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Logics.TopOrganization.TGVG2BattleReport;
   import Logics.TopOrganization.TGVG2BattleReports;
   import Logics.TopOrganization.TGVG3BattleOrg;
   import Logics.TopOrganization.TGVG3BattleOrgs;
   import Logics.TopOrganization.TOrgMemberDigest;
   import Logics.TopOrganization.TOrgMemberDigests;
   import Logics.TopOrganization.TTopOrganizationData;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.TopOrganization.Componets.TUIBattleHead;
   import Processors.Game.Lobby.TopOrganization.Componets.TUIOrgInfo;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TOPORGANIZATION;
   import Resources.Strings.STRING_TOPORGANIZATION;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class TProcessorWindowFinalBattleField extends TProcessorWindowTemplate
   {
      
      protected const CAPACITY_BattleHead:uint = 4;
      
      protected const CAPACITY_TotalBattleHeads:uint = 8;
      
      protected const CAPACITY_Orgs:uint = 2;
      
      protected const CAPACITY_BoomEffect:uint = 4;
      
      protected var FMC_RemindTime:MovieClip;
      
      protected var FMC_High:MovieClip;
      
      protected var FMC_Low:MovieClip;
      
      protected var FMC_ThreeWinsEffect:MovieClip;
      
      protected var FMC_BattleHeads:Vector.<TUIBattleHead>;
      
      protected var FMC_OrgInfos:Vector.<TUIOrgInfo>;
      
      protected var FMC_BoomEffects:Vector.<MovieClip>;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FReportItems:Vector.<DisplayObject>;
      
      protected var FMaskSp:Sprite;
      
      protected var FTopOrganizationData:TTopOrganizationData;
      
      protected var FCountDown:int;
      
      protected var FIdentifier:uint;
      
      protected var FPlayBattleReports:TGVG2BattleReports;
      
      protected var FThreeWinsMemberDigests:TOrgMemberDigests;
      
      protected var FInitializeBattleReportData:Boolean;
      
      protected var FUnPlayBoomEffectIndex:int;
      
      protected var FIsPlayThreeWinsEffect:Boolean;
      
      public function TProcessorWindowFinalBattleField(param1:TUIComponent)
      {
         super(param1);
         this.Init();
      }
      
      protected function Init() : void
      {
         this.FMC_BattleHeads = new Vector.<TUIBattleHead>(this.CAPACITY_TotalBattleHeads);
         this.FMC_OrgInfos = new Vector.<TUIOrgInfo>(this.CAPACITY_Orgs);
         this.FMC_BoomEffects = new Vector.<MovieClip>(this.CAPACITY_BoomEffect);
         this.FPlayBattleReports = new TGVG2BattleReports();
         this.FThreeWinsMemberDigests = new TOrgMemberDigests();
         this.FReportItems = new Vector.<DisplayObject>();
         this.FTopOrganizationData = SLogicsCore.TopOrganizationData;
         this.FMaskSp = new Sprite();
         this.FUnPlayBoomEffectIndex = -1;
         this.FIsPlayThreeWinsEffect = true;
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TUIBattleHead = null;
         var _loc5_:TOrgMemberDigest = null;
         super.LogicsPerform();
         if(!Visible)
         {
            return;
         }
         if(FIsResourcesLoadCompleted)
         {
            this.UpdateBattleHeadStatus();
         }
         _loc2_ = this.CAPACITY_BoomEffect;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_BoomEffects[_loc1_];
            if(_loc3_.currentFrame == 8)
            {
               _loc3_.gotoAndStop(1);
               _loc3_.visible = false;
            }
            _loc1_++;
         }
         if(this.FThreeWinsMemberDigests.Count > 0)
         {
            if(this.FIsPlayThreeWinsEffect)
            {
               this.FIsPlayThreeWinsEffect = false;
               this.FMC_ThreeWinsEffect.visible = true;
               this.PlayThreeWinsEffect();
               _loc5_ = this.FThreeWinsMemberDigests.ShiftOrgMemberDigest();
               this.FMC_ThreeWinsEffect["MC_Hero"]["TF_Name"].text = _loc5_.Name;
               this.FMC_ThreeWinsEffect["MC_Hero"]["TF_Level"].text = _loc5_.Level.toString();
            }
         }
         if(this.FMC_ThreeWinsEffect.currentFrame == this.FMC_ThreeWinsEffect.totalFrames)
         {
            this.FMC_ThreeWinsEffect.gotoAndStop(1);
            this.FIsPlayThreeWinsEffect = true;
            this.FMC_ThreeWinsEffect.visible = false;
         }
         if(this.FInitializeBattleReportData)
         {
            this.SetPlayBattleReports();
            this.SetBattleReportData();
            this.UpdateBattleReport();
            this.ResetBattleHeads();
            this.FInitializeBattleReportData = false;
            if(this.FTopOrganizationData.GVG3BattleReports.Count == 0)
            {
               this.UpdateOrgInfoUI();
               return;
            }
            this.Update(false,5,false);
         }
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
         var _loc4_:TUIBattleHead = null;
         var _loc5_:TUIOrgInfo = null;
         var _loc6_:BitmapData = null;
         var _loc7_:Bitmap = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Boolean = false;
         var _loc11_:Number = NaN;
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_TOPORGANIZATION.RESOURCE_ClassName_MC_FinalBattleField) as Sprite;
         UIDispatch();
         this.FMC_ThreeWinsEffect = FMainUI["MC_ThreeWinsEffect"];
         this.FMC_ThreeWinsEffect.visible = false;
         _loc2_ = this.CAPACITY_TotalBattleHeads;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = FMainUI["MC_BattleHead_" + _loc1_];
            _loc4_ = new TUIBattleHead(this);
            _loc4_.Tag = _loc1_;
            _loc4_.Resource = _loc3_;
            _loc4_.Init();
            if(_loc1_ >= 4)
            {
               _loc4_.Type = CONST_TOPORGANIZATION.TYPE_RightOrg;
            }
            else
            {
               _loc4_.Type = CONST_TOPORGANIZATION.TYPE_LeftOrg;
            }
            this.FMC_BattleHeads[_loc1_] = _loc4_;
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_BoomEffect;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = FMainUI["MC_Boom_" + _loc1_];
            _loc3_.visible = false;
            this.FMC_BoomEffects[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_Orgs;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = FMainUI["MC_OrgInfo_" + _loc1_];
            _loc5_ = new TUIOrgInfo(this);
            _loc5_.Resource = _loc3_;
            _loc5_.Init();
            this.FMC_OrgInfos[_loc1_] = _loc5_;
            _loc1_++;
         }
         this.FMC_RemindTime = FMainUI["MC_RemindTime"];
         this.FMC_High = this.FMC_RemindTime["MC_High"];
         this.FMC_Low = this.FMC_RemindTime["MC_Low"];
         this.FScrollBar = new TScrollBar(FMainUI["MC_BattleReport"]["mc_list"],86,false,2);
         this.FMaskSp.graphics.beginFill(0,0.3);
         this.FMaskSp.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.FMaskSp.graphics.endFill();
         addChild(this.FMaskSp);
         this.FMaskSp.addChild(this.FMC_RemindTime);
         this.FMC_RemindTime.x += 120;
         this.FMC_RemindTime.y += 40;
         this.FMaskSp.visible = false;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TSystemLanguage = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GVG_Tips_09) as TSystemLanguage;
         FHelpTips.Content = _loc1_.Desc;
         super.ResourcesPerform_UIFinalize();
      }
      
      protected function UpdateBattleHeadStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIBattleHead = null;
         _loc2_ = this.CAPACITY_TotalBattleHeads;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.UpdateSingleBattleHead(this.FMC_BattleHeads[_loc1_]);
            _loc1_++;
         }
      }
      
      protected function UpdateSingleBattleHead(param1:TUIBattleHead) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.Status);
         if(_loc2_ != CONST_TOPORGANIZATION.STATUS_START)
         {
            if(_loc2_ == CONST_TOPORGANIZATION.STATUS_WAIT)
            {
               param1.PlayWaitAnimation();
            }
            else if(_loc2_ == CONST_TOPORGANIZATION.STATUS_MOVE)
            {
               param1.PlayMoveAnimation();
            }
            else if(_loc2_ == CONST_TOPORGANIZATION.STATUS_Fight)
            {
               this.ProcessorOnPlayeBoomEffect();
               param1.Status = CONST_TOPORGANIZATION.STATUS_End;
            }
            else if(_loc2_ == CONST_TOPORGANIZATION.STATUS_End)
            {
               param1.Reset();
               this.FInitializeBattleReportData = true;
            }
         }
      }
      
      protected function SetBattleReportData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TGVG3BattleOrgs = null;
         var _loc4_:TGVG3BattleOrg = null;
         var _loc5_:TOrgMemberDigests = null;
         var _loc6_:TOrgMemberDigest = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:int = 0;
         var _loc10_:uint = 0;
         var _loc11_:TGVG2BattleReport = null;
         _loc3_ = this.FTopOrganizationData.GVG3BattleOrgs;
         _loc2_ = this.CAPACITY_Orgs;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_.GetGVG3BattleOrgByIndex(_loc1_);
            _loc5_ = _loc4_.OrgMemberDigests;
            _loc8_ = uint(_loc5_.Count);
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               _loc6_ = _loc5_.GetOrgMemberDigestByIndex(_loc7_);
               _loc10_ = this.FPlayBattleReports.Count;
               _loc9_ = 0;
               while(_loc9_ < _loc10_)
               {
                  _loc11_ = this.FPlayBattleReports.GetGVG2BattleReportByIndex(_loc9_);
                  if(_loc11_.LoserUserID0 == _loc6_.Identifier0 && _loc11_.LoserUserID1 == _loc6_.Identifier1)
                  {
                     _loc6_.IsDead = 1;
                  }
                  if(_loc11_.WinnerUserID0 == _loc6_.Identifier0 && _loc11_.WinnerUserID1 == _loc6_.Identifier1)
                  {
                     _loc6_.IsThreeWins = _loc11_.IsThreeWins;
                     _loc6_.LeftHP = _loc11_.LeftHP;
                     if(Boolean(_loc11_.IsThreeWins))
                     {
                        this.FThreeWinsMemberDigests.Add(_loc6_);
                     }
                  }
                  _loc9_++;
               }
               _loc7_++;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBattleHead(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TUIBattleHead = null;
         _loc3_ = this.CAPACITY_TotalBattleHeads;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FMC_BattleHeads[_loc2_];
            _loc4_.Context = null;
            _loc4_.Resource.visible = false;
            _loc2_++;
         }
         this.SetBattleHeadData(0,this.FMC_BattleHeads,param1);
         this.SetBattleHeadData(1,this.FMC_BattleHeads,param1);
      }
      
      protected function SetBattleHeadData(param1:int, param2:Vector.<TUIBattleHead>, param3:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TGVG3BattleOrgs = null;
         var _loc7_:TGVG3BattleOrg = null;
         var _loc8_:TOrgMemberDigests = null;
         var _loc9_:TOrgMemberDigest = null;
         var _loc10_:TUIBattleHead = null;
         var _loc11_:int = 0;
         _loc6_ = this.FTopOrganizationData.GVG3BattleOrgs;
         _loc7_ = _loc6_.GetGVG3BattleOrgByIndex(param1);
         _loc8_ = _loc7_.OrgMemberDigests;
         _loc8_.Sort();
         _loc5_ = this.CAPACITY_BattleHead;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc11_ = _loc4_ + param1 * this.CAPACITY_BoomEffect;
            if(_loc11_ >= param2.length)
            {
               break;
            }
            _loc10_ = param2[_loc11_];
            _loc9_ = _loc8_.GetOrgMemberDigestByIndex(_loc4_);
            if(_loc9_ != null)
            {
               if(_loc9_.IsDead == 0 && _loc9_.IsThreeWins == 0)
               {
                  _loc10_.Context = _loc9_;
                  _loc10_.Resource.visible = true;
                  _loc10_.IsFirstSet = param3;
                  _loc10_.Update();
                  _loc10_.Status = CONST_TOPORGANIZATION.STATUS_WAIT;
               }
            }
            _loc4_++;
         }
      }
      
      protected function UpdateBattleReport() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TGVG2BattleReports = null;
         var _loc5_:TGVG2BattleReport = null;
         _loc3_ = this.FPlayBattleReports.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = this.FPlayBattleReports.GetGVG2BattleReportByIndex(_loc2_);
            _loc1_ = this.MakeHtmlTextInfo(_loc5_);
            this.AddTextFieldIntoScrollBar(_loc1_,this.FReportItems,this.FScrollBar);
            _loc2_++;
         }
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
      
      protected function MakeHtmlTextInfo(param1:TGVG2BattleReport) : String
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:uint = 0;
         var _loc8_:String = null;
         var _loc9_:String = null;
         _loc2_ = "";
         _loc3_ = "";
         _loc4_ = "";
         _loc5_ = "";
         _loc6_ = "";
         _loc8_ = "";
         _loc9_ = "";
         _loc4_ = param1.WinnerUserName;
         _loc3_ = param1.LoserUserName;
         _loc5_ = param1.WinnerOrgName;
         _loc6_ = param1.LoserOrgName;
         _loc7_ = param1.LeftHP;
         _loc9_ = param1.WinnerOrgServerName;
         _loc8_ = param1.LoserOrgServerName;
         _loc2_ = TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_PersonalReport,_loc4_,_loc9_,_loc5_,_loc3_,_loc8_,_loc6_,_loc7_);
         if(param1.IsThreeWins)
         {
            _loc2_ += STRING_TOPORGANIZATION.STRING_ThreeWins;
         }
         return _loc2_;
      }
      
      protected function UpdateOrgInfoUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIOrgInfo = null;
         var _loc4_:TGVG3BattleOrgs = null;
         var _loc5_:TGVG3BattleOrg = null;
         _loc4_ = this.FTopOrganizationData.GVG3BattleOrgs;
         _loc2_ = this.CAPACITY_Orgs;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_OrgInfos[_loc1_];
            _loc5_ = _loc4_.GetGVG3BattleOrgByIndex(_loc1_);
            _loc3_.Context = _loc5_;
            _loc3_.Update();
            _loc1_++;
         }
      }
      
      protected function UpdateCountDownTime() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc1_ = this.FCountDown / 10;
         _loc2_ = this.FCountDown % 10;
         this.FMC_High.gotoAndStop(_loc1_ + 1);
         this.FMC_Low.gotoAndStop(_loc2_ + 1);
         --this.FCountDown;
         if(this.FCountDown < -1)
         {
            return;
         }
         if(this.FCountDown < 0)
         {
            clearInterval(this.FIdentifier);
            this.FMaskSp.visible = false;
            this.SetModelState();
         }
      }
      
      protected function SetModelState() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIBattleHead = null;
         var _loc4_:TUIBattleHead = null;
         _loc2_ = this.CAPACITY_BattleHead;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_BattleHeads[_loc1_];
            _loc4_ = this.FMC_BattleHeads[_loc1_ + this.CAPACITY_BattleHead];
            if(!_loc3_.Resource.visible || !_loc4_.Resource.visible)
            {
               _loc3_.Status = CONST_TOPORGANIZATION.STATUS_WAIT;
               this.FUnPlayBoomEffectIndex = _loc1_;
            }
            else
            {
               _loc3_.Status = CONST_TOPORGANIZATION.STATUS_MOVE;
               _loc3_.StopWait();
               _loc4_.Status = CONST_TOPORGANIZATION.STATUS_MOVE;
               _loc4_.StopWait();
            }
            _loc1_++;
         }
      }
      
      protected function SetPlayBattleReports() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TGVG2BattleReports = null;
         var _loc4_:TGVG2BattleReport = null;
         var _loc5_:uint = 0;
         this.FPlayBattleReports.Clear();
         _loc3_ = this.FTopOrganizationData.GVG3BattleReports;
         _loc2_ = _loc5_ = uint(this.GetRestOrgMembers());
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_.ShiftBattleReport();
            if(_loc4_ != null)
            {
               this.FPlayBattleReports.Add(_loc4_);
            }
            _loc1_++;
         }
      }
      
      protected function GetRestOrgMembers() : int
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TGVG3BattleOrgs = null;
         var _loc4_:TGVG3BattleOrg = null;
         var _loc5_:TOrgMemberDigests = null;
         var _loc6_:TOrgMemberDigest = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:int = 0;
         _loc3_ = this.FTopOrganizationData.GVG3BattleOrgs;
         _loc9_ = new Vector.<uint>();
         _loc2_ = this.CAPACITY_Orgs;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_.GetGVG3BattleOrgByIndex(_loc1_);
            _loc9_[_loc1_] = 0;
            _loc5_ = _loc4_.OrgMemberDigests;
            _loc8_ = uint(_loc5_.Count);
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               _loc6_ = _loc5_.GetOrgMemberDigestByIndex(_loc7_);
               if(_loc6_.IsDead == 0 && _loc6_.IsThreeWins == 0)
               {
                  ++_loc9_[_loc1_];
               }
               _loc7_++;
            }
            _loc1_++;
         }
         _loc10_ = Math.min(_loc9_[0],_loc9_[1]);
         if(_loc10_ < 4)
         {
            return _loc10_;
         }
         return 4;
      }
      
      protected function PlayThreeWinsEffect() : void
      {
         this.FMC_ThreeWinsEffect.play();
      }
      
      protected function ResetBattleHeads() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIBattleHead = null;
         _loc2_ = this.CAPACITY_TotalBattleHeads;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_BattleHeads[_loc1_];
            _loc3_.Reset();
            _loc1_++;
         }
      }
      
      protected function ResetScrollBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = this.FReportItems.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FReportItems.pop();
            _loc1_++;
         }
         this.FReportItems.length = 0;
         this.FScrollBar.Clear();
      }
      
      override protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         this.ResetBattleHeads();
         this.ResetScrollBar();
         super.ButtonCloseOnClick(param1);
      }
      
      protected function ProcessorOnPlayeBoomEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         _loc3_ = uint(Tag / 2);
         _loc2_ = this.CAPACITY_BoomEffect;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FMC_BoomEffects[_loc1_];
            if(this.FUnPlayBoomEffectIndex != _loc1_)
            {
               _loc4_.visible = true;
               _loc4_.play();
            }
            _loc1_++;
         }
      }
      
      public function Update(param1:Boolean = true, param2:uint = 3, param3:Boolean = true) : void
      {
         this.UpdateOrgInfoUI();
         this.UpdateBattleHead(param3);
         this.FCountDown = param2;
         this.UpdateCountDownTime();
         this.FMaskSp.visible = param1;
         this.FIdentifier = setInterval(this.UpdateCountDownTime,1000);
         this.FUnPlayBoomEffectIndex = -1;
      }
   }
}

