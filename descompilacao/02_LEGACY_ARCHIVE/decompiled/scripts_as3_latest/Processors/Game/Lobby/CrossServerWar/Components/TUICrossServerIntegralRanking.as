package Processors.Game.Lobby.CrossServerWar.Components
{
   import Foundation.UI.TUIComponent;
   import Logics.CrossServerWar.TIntegralRanking;
   import Logics.GlobalBattle.TGlobalBattleRank;
   import Logics.Globalboss.TGlobalbossRank;
   import Logics.Palace.TRankingPlayer;
   import Logics.SLogicsCore;
   import Logics.TopTeam.TTopTeamRank;
   import Logics.WorldMatch.TWorldMatchRank;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_CROSSSERVERWAR;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_CROSSSERVERWAR;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUICrossServerIntegralRanking extends TProcessorGame
   {
      
      protected var FTF_Ranking:TextField;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Server:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_Score:TextField;
      
      protected var FTF_Group:TextField;
      
      protected var FTF_Job:TextField;
      
      protected var FTF_Agent:TextField;
      
      protected var FIntegralRanking:TIntegralRanking;
      
      protected var FResource:MovieClip;
      
      protected var FContext:Object;
      
      protected var FOnOut:Function;
      
      protected var FOnOver:Function;
      
      public function TUICrossServerIntegralRanking(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function UIDispatch() : void
      {
         this.FTF_Ranking = this.FResource[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Ranking];
         this.FTF_Name = this.FResource[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Name];
         this.FTF_Server = this.FResource[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Server];
         this.FTF_Level = this.FResource[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Level];
         this.FTF_Score = this.FResource[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Score];
         this.FTF_Group = this.FResource["TF_Group"];
         this.FTF_Job = this.FResource["TF_Job"];
         this.FTF_Agent = this.FResource["TF_Agent"];
      }
      
      protected function UILocation() : void
      {
         this.FResource.addEventListener(MouseEvent.MOUSE_OUT,this.UIOnOut,false,0,true);
         this.FResource.addEventListener(MouseEvent.MOUSE_MOVE,this.UIOnOver,false,0,true);
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:TIntegralRanking = null;
         var _loc2_:TRankingPlayer = null;
         var _loc3_:TTopTeamRank = null;
         var _loc4_:TGlobalBattleRank = null;
         var _loc5_:TWorldMatchRank = null;
         var _loc6_:TGlobalbossRank = null;
         if(this.FContext == null)
         {
            return;
         }
         if(this.FContext is TIntegralRanking)
         {
            _loc1_ = this.FContext as TIntegralRanking;
            this.FTF_Ranking.text = _loc1_.CurRanking.toString();
            this.FTF_Name.text = _loc1_.PlayerName;
            this.FTF_Server.text = _loc1_.ServerName;
            this.FTF_Level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc1_.PlayerLevel);
            this.FTF_Score.text = _loc1_.PlayerScore.toString();
            this.FTF_Group.text = STRING_CROSSSERVERWAR.CrossServerWar_Group[_loc1_.Group];
         }
         else if(this.FContext is TRankingPlayer)
         {
            _loc2_ = this.FContext as TRankingPlayer;
            this.FTF_Ranking.text = _loc2_.RankIndex.toString();
            this.FTF_Name.text = _loc2_.PlayerName;
            this.FTF_Server.text = _loc2_.ServerName;
            this.FTF_Level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc2_.PlayerLevel);
         }
         else if(this.FContext is TTopTeamRank)
         {
            _loc3_ = this.FContext as TTopTeamRank;
            this.FTF_Ranking.text = _loc3_.Rank.toString();
            this.FTF_Name.text = _loc3_.Name;
            this.FTF_Server.text = _loc3_.ServerName;
            this.FTF_Level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc3_.Level);
            this.FTF_Job.text = STRING_COMMON.TYPE_PROFESSIONS[_loc3_.Job];
            this.FTF_Score.text = _loc3_.Score.toString();
         }
         else if(this.FContext is TGlobalBattleRank)
         {
            _loc4_ = this.FContext as TGlobalBattleRank;
            this.FTF_Ranking.text = _loc4_.Rank.toString();
            this.FTF_Name.text = _loc4_.Username;
            this.FTF_Server.text = _loc4_.ServerId.toString();
            this.FTF_Level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc4_.Userlevel);
            this.FTF_Score.text = _loc4_.Score.toString();
            this.FTF_Agent.text = _loc4_.Agent.toString();
         }
         else if(this.FContext is TWorldMatchRank)
         {
            _loc5_ = this.FContext as TWorldMatchRank;
            this.FTF_Ranking.text = _loc5_.Rank.toString();
            this.FTF_Name.text = _loc5_.Username;
            this.FTF_Server.text = _loc5_.ServerName;
            this.FTF_Level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc5_.Userlevel);
            this.FTF_Agent.text = _loc5_.Agent.toString();
         }
         else if(this.FContext is TGlobalbossRank)
         {
            _loc6_ = this.FContext as TGlobalbossRank;
            this.FTF_Ranking.text = _loc6_.Rank.toString();
            this.FTF_Name.text = _loc6_.Username;
            this.FTF_Server.text = _loc6_.ServerName;
            this.FTF_Level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc6_.Userlevel);
            this.FTF_Agent.text = _loc6_.StarNum.toString();
         }
         this.FTF_Ranking.visible = parseInt(this.FTF_Ranking.text) > 3;
      }
      
      protected function UIOnOver(param1:MouseEvent) : void
      {
         if(this.FOnOver != null)
         {
            this.FOnOver(this,this.FIntegralRanking);
         }
      }
      
      protected function UIOnOut(param1:MouseEvent) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(this,this.FIntegralRanking);
         }
      }
      
      public function get Resource() : MovieClip
      {
         return this.FResource;
      }
      
      public function set Resource(param1:MovieClip) : void
      {
         this.FResource = param1;
      }
      
      public function get OnOver() : Function
      {
         return this.FOnOver;
      }
      
      public function set OnOver(param1:Function) : void
      {
         this.FOnOver = param1;
      }
      
      public function get OnOut() : Function
      {
         return this.FOnOut;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function get Context() : Object
      {
         return this.FContext;
      }
      
      public function set Context(param1:Object) : void
      {
         this.FContext = param1;
      }
      
      public function Init() : void
      {
         this.UIDispatch();
         this.UILocation();
      }
      
      public function SetInfo() : void
      {
         this.UpdateUI();
      }
   }
}

