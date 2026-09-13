package Processors.Game.Lobby.WorldMatch
{
   import Externals.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Agent.*;
   import Logics.WorldMatch.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.text.*;
   
   public class TProcessorWorldMatchReport extends TUIComponent
   {
      
      protected static const REPORT_MAX:uint = CONST_WORLDMATCH.REPORT_MAX;
      
      protected static const REPORT_TextFilters:GlowFilter = new GlowFilter(0,1,2,2,10);
      
      protected var FArenaReports:Vector.<TWorldMatchReport>;
      
      protected var FTextReportVect:Vector.<TextField>;
      
      protected var FBtnReportVect:Vector.<SimpleButton>;
      
      protected var FScene:MovieClip;
      
      public function TProcessorWorldMatchReport(param1:TUIComponent, param2:MovieClip)
      {
         super(param1);
         this.FScene = param2;
         this.FTextReportVect = new Vector.<TextField>(REPORT_MAX);
         this.FBtnReportVect = new Vector.<SimpleButton>(REPORT_MAX);
         this.InitReportUI();
      }
      
      protected function InitReportUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TextField = null;
         var _loc3_:SimpleButton = null;
         _loc1_ = 0;
         while(_loc1_ < REPORT_MAX)
         {
            _loc2_ = this.FScene["TF_Report_" + _loc1_];
            _loc2_.filters = [REPORT_TextFilters];
            this.FTextReportVect[_loc1_] = _loc2_;
            _loc3_ = this.FScene["btn_Replay_" + _loc1_];
            this.FBtnReportVect[_loc1_] = _loc3_;
            _loc3_.addEventListener(MouseEvent.CLICK,this.OnReplayClick);
            _loc1_++;
         }
      }
      
      protected function GetReportWhen(param1:uint) : String
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:Date = null;
         var _loc6_:Date = null;
         _loc2_ = "";
         _loc3_ = STimingCore.GetServerTick() - param1;
         _loc4_ = _loc3_ / (24 * 60 * 60);
         if(_loc4_ < 7)
         {
            _loc5_ = new Date(STimingCore.GetServerTime() * 1000);
            _loc6_ = new Date(STimingCore.GetClientShowTime(param1) * 1000);
            if(_loc5_.day == _loc6_.day)
            {
               _loc2_ = STRING_ARENA.ARENA_Report_WhenVect[_loc4_];
            }
            else
            {
               _loc2_ = STRING_ARENA.ARENA_Report_WhenVect[_loc4_ + 1];
            }
         }
         else
         {
            _loc2_ = STRING_ARENA.ARENA_Report_WhenVect[STRING_ARENA.ARENA_Report_WhenVect.length - 1];
         }
         return _loc2_;
      }
      
      protected function MakeHtmlTextInfo(param1:TWorldMatchReport) : String
      {
         var _loc2_:String = null;
         if(param1.IsFight)
         {
            _loc2_ = STRING_ARENA.ARENA_Report_Fight;
         }
         else
         {
            _loc2_ = STRING_ARENA.ARENA_Report_BFight;
         }
         if(param1.IsWin)
         {
            _loc2_ += STRING_ARENA.ARENA_Report_Win;
         }
         else
         {
            _loc2_ += STRING_ARENA.ARENA_Report_Lost;
         }
         if(param1.ChgRanking > 0)
         {
            _loc2_ += STRING_ARENA.ARENA_Report_Ranking_Up;
         }
         else if(param1.ChgRanking < 0)
         {
            _loc2_ += STRING_ARENA.ARENA_Report_Ranking_Down;
         }
         else
         {
            _loc2_ += STRING_ARENA.ARENA_Report_Ranking_None;
         }
         _loc2_ = _loc2_.split("%when%").join(this.GetReportWhen(param1.When));
         _loc2_ = _loc2_.split("%who%").join(param1.PlayerNick);
         return _loc2_.split("%ranking%").join(Math.abs(param1.ChgRanking));
      }
      
      protected function UpdataUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TextField = null;
         var _loc3_:SimpleButton = null;
         _loc1_ = 0;
         while(_loc1_ < REPORT_MAX)
         {
            _loc2_ = this.FTextReportVect[_loc1_];
            _loc3_ = this.FBtnReportVect[_loc1_];
            if(_loc1_ < this.FArenaReports.length)
            {
               _loc2_.visible = true;
               _loc2_.htmlText = this.MakeHtmlTextInfo(this.FArenaReports[_loc1_]);
               _loc3_.visible = true;
            }
            else
            {
               _loc2_.visible = false;
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function OnReplayClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TWorldMatchReport = null;
         _loc2_ = uint(int(String(param1.currentTarget.name).slice(11)));
         _loc3_ = this.FArenaReports[_loc2_];
         SExternalCore.NavigateToFightReport(_loc3_.ReportId);
      }
      
      public function UpdateReportInfo(param1:Vector.<TWorldMatchReport>) : void
      {
         this.FArenaReports = param1;
         this.UpdataUI();
      }
   }
}

