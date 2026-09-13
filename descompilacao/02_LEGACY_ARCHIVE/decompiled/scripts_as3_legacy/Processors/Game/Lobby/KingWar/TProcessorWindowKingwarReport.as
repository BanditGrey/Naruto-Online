package Processors.Game.Lobby.KingWar
{
   import Components.Pages.TUIPage;
   import Externals.SExternalCore;
   import Foundation.UI.TUIComponent;
   import Logics.Kingwar.TPVPKingPlayer;
   import Logics.Kingwar.TPVPKingReport;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Resources.Constants.CONST_KINGWAR;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowKingwarReport extends TUIComponent
   {
      
      protected static const REPORT_MAX:uint = 5;
      
      protected var FScene:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FMC_Page:TUIPage;
      
      protected var FPvpKingPlayer:TPVPKingPlayer;
      
      protected var FPvpKingReportVec:Vector.<TPVPKingReport>;
      
      protected var FightType:int;
      
      protected var FPageIndex:uint;
      
      public var ReportInfoFun:Function;
      
      public function TProcessorWindowKingwarReport(param1:TUIComponent, param2:MovieClip)
      {
         super(param1);
         this.FScene = param2;
         addChild(param2);
         this.Visible = false;
         this.InitReportUI();
      }
      
      protected function InitReportUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         this.FMC_Page = new TUIPage(this);
         this.FMC_Page.ButtonPrevious.Substrate = this.FScene.Btn_Left;
         this.FMC_Page.ButtonNext.Substrate = this.FScene.Btn_Right;
         this.FMC_Page.LabelPage = this.FScene.TF_Page;
         this.FMC_Page.PageSize = REPORT_MAX;
         this.FMC_Page.Init();
         this.FMC_Page.OnChangePage = this.OnChangePage;
         this.FBTN_Close = this.FScene[CONST_KINGWAR.RESOURCE_Link_Btn_Close];
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseBtnClick);
         _loc1_ == 0;
         while(_loc1_ < REPORT_MAX)
         {
            _loc2_ = this.FScene[CONST_KINGWAR.RESOURCE_MC_Report + _loc1_] as MovieClip;
            _loc2_.TF_Replay.htmlText = "<u>" + _loc2_.TF_Replay.text + "</u>";
            _loc2_.TF_Replay.addEventListener(MouseEvent.CLICK,this.OnReplayClick);
            _loc1_++;
         }
      }
      
      protected function OnChangePage(param1:Object, param2:int) : void
      {
         this.FPageIndex = param2;
         this.SetFightReport(this.FPvpKingPlayer,this.FightType);
      }
      
      public function SetFightReport(param1:TPVPKingPlayer, param2:int = 0) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TPVPKingReport = null;
         this.FPvpKingPlayer = param1;
         this.FightType = param2;
         this.ClearFightReport();
         if(this.FPvpKingPlayer)
         {
            this.FPvpKingReportVec = this.FPvpKingPlayer.PVPKingReports.GetPVPKingReportsByFightType(param2);
            this.FMC_Page.TotalQuantity = this.FPvpKingReportVec.length;
            this.FMC_Page.Update();
            _loc3_ = 0;
            while(_loc3_ < REPORT_MAX)
            {
               if(_loc3_ + this.FPageIndex * REPORT_MAX < this.FPvpKingReportVec.length)
               {
                  _loc4_ = this.FPvpKingReportVec[_loc3_ + this.FPageIndex * REPORT_MAX];
                  this.MakeReportTextInfo(_loc3_,_loc4_);
               }
               _loc3_++;
            }
            this.FScene.TF_HeroNme.text = this.FPvpKingPlayer.Name ? this.FPvpKingPlayer.Name : "";
         }
      }
      
      protected function MakeReportTextInfo(param1:int, param2:TPVPKingReport) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         _loc5_ = new ConsumeFrame(CONST_SYSTEMLANGUAGE.STRING_Kingwar_05).DescribeString;
         _loc6_ = new ConsumeFrame(CONST_SYSTEMLANGUAGE.STRING_Kingwar_06).DescribeString;
         _loc3_ = this.FScene[CONST_KINGWAR.RESOURCE_MC_Report + param1] as MovieClip;
         _loc3_.TF_Replay.visible = true;
         _loc4_ = this.ReportInfoFun(this.FPvpKingPlayer,param2);
         _loc3_.TF_Game.text = _loc4_.AckName + " VS " + _loc4_.DefName;
         _loc3_.TF_Result.text = _loc4_.IsWin ? _loc5_ : _loc6_;
         _loc3_.TF_Round.text = param1 + 1 + this.FPageIndex * REPORT_MAX;
         if(this.FightType > 0)
         {
            _loc3_.TF_Date.gotoAndStop(this.FightType - 2);
            _loc3_.TF_Time.gotoAndStop(param1 + 1);
         }
      }
      
      protected function OnReplayClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:String = null;
         _loc2_ == 0;
         while(_loc2_ < REPORT_MAX)
         {
            _loc3_ = this.FScene[CONST_KINGWAR.RESOURCE_MC_Report + _loc2_] as MovieClip;
            if(_loc3_.TF_Replay == param1.currentTarget)
            {
               _loc4_ = this.FPvpKingReportVec[_loc2_ + this.FPageIndex * REPORT_MAX].ReportID;
               break;
            }
            _loc2_++;
         }
         SExternalCore.NavigateToFightReport(_loc4_);
      }
      
      protected function OnCloseBtnClick(param1:MouseEvent) : void
      {
         this.Visible = false;
         this.FMC_Page.Reset();
         this.FPageIndex = 0;
      }
      
      protected function ClearFightReport() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         _loc1_ == 0;
         while(_loc1_ < REPORT_MAX)
         {
            _loc2_ = this.FScene[CONST_KINGWAR.RESOURCE_MC_Report + _loc1_] as MovieClip;
            _loc2_.TF_Replay.visible = false;
            _loc2_.TF_Date.gotoAndStop("null");
            _loc2_.TF_Game.text = "";
            _loc2_.TF_Result.text = "";
            _loc2_.TF_Round.text = "";
            _loc2_.TF_Time.gotoAndStop("null");
            _loc1_++;
         }
      }
   }
}

