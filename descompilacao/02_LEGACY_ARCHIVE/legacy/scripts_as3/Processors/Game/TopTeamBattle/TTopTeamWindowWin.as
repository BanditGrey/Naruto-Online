package Processors.Game.TopTeamBattle
{
   import Foundation.Resources.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.GroupBattle.*;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TTopTeamWindowWin extends TProcessorLobbyWindow
   {
      
      protected static const MAX_COUNT:uint = 3;
      
      protected static const MAX_ITEM_COUNT:uint = 5;
      
      protected var FScene:MovieClip;
      
      protected var FTF_Sure:TextField;
      
      protected var FPlayerHeadBitmapVect:Vector.<Bitmap>;
      
      protected var FLastTime:uint;
      
      protected var FCloseTime:uint;
      
      protected var FGroupBattleRewardsVect:Vector.<TGroupBattleRewards>;
      
      public function TTopTeamWindowWin(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(Visible)
         {
            _loc1_ = this.FCloseTime - STimingCore.GetServerTick();
            this.FTF_Sure.text = TUtilityString.Format(STRING_GROUPBATTLE.STRING_SURE_BACK,_loc1_);
            if(_loc1_ <= 0)
            {
               ProcessorWindowClose();
            }
         }
      }
      
      protected function InitWindow() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Bitmap = null;
         var _loc3_:TConfigValue = null;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_BATTLE.RESOURCE_ClassName_TopTeamBattle_Win) as MovieClip;
         addChild(this.FScene);
         TGameUtil.setButtonMode(this.FScene["BTN_OK"],true);
         this.FScene["BTN_OK"].addEventListener(MouseEvent.CLICK,this.OnCloseWindow);
         this.FTF_Sure = this.FScene["BTN_OK"]["TF_Sure"];
         this.FScene.x = (FUICore.StageWidth - this.FScene.width) / 2;
         this.FScene.y = (FUICore.StageHeight - this.FScene.height) / 2;
         this.FPlayerHeadBitmapVect = new Vector.<Bitmap>(MAX_COUNT);
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc2_ = new Bitmap();
            this.FScene["MC_Player" + _loc1_]["MC_Head"]["MC_Head"].addChild(_loc2_);
            this.FPlayerHeadBitmapVect[_loc1_] = _loc2_;
            _loc1_++;
         }
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GROUPBATTLE_OutTime) as TConfigValue;
         this.FLastTime = _loc3_.Value as uint;
      }
      
      protected function UpdataUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TGroupBattleRewards = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            if(_loc1_ >= this.FGroupBattleRewardsVect.length)
            {
               this.FScene["MC_Player" + _loc1_].visible = false;
            }
            else
            {
               _loc2_ = this.FGroupBattleRewardsVect[_loc1_];
               this.FScene["MC_Player" + _loc1_]["TF_Name"].text = _loc2_.UserName;
               this.FScene["MC_Player" + _loc1_]["TF_Level"].text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc2_.UserLevel);
               this.FScene["MC_Player" + _loc1_]["TF_Score"].text = TUtilityString.Format(STRING_TOPTEAM.STRING_Score,_loc2_.Score,_loc2_.ExtraScore);
               this.FScene["MC_Player" + _loc1_]["TF_Point"].text = TUtilityString.Format(STRING_TOPTEAM.STRING_Point,_loc2_.Point);
               this.FScene["MC_Player" + _loc1_].visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function OnCloseWindow(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
         if(this.FScene != null && param1)
         {
            this.FScene["MC_Title"]["MC_Title"].gotoAndPlay(1);
            this.FCloseTime = STimingCore.GetServerTick() + this.FLastTime;
         }
      }
      
      public function SetGroupBattleWinRewards(param1:Vector.<TGroupBattleRewards>, param2:uint) : void
      {
         var _loc3_:uint = 0;
         this.FGroupBattleRewardsVect = param1;
         if(param2 == 1)
         {
            this.FScene["MC_Title"].gotoAndStop(1);
         }
         else
         {
            this.FScene["MC_Title"].gotoAndStop(2);
         }
         this.UpdataUI();
      }
      
      public function Updata() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc2_ = this.FGroupBattleRewardsVect.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FPlayerHeadBitmapVect[_loc1_],CONST_MODULES.MODULE_TopTeam,this.FGroupBattleRewardsVect[_loc1_].ModelId);
            _loc1_++;
         }
      }
      
      public function Init() : void
      {
         this.InitWindow();
      }
   }
}

