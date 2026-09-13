package Processors.Game.Lobby.TreasureMap
{
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.SLogicsCore;
   import Logics.TreasureMap.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   
   public class TProcessorHeroTips extends TUIComponent
   {
      
      protected var FScene:MovieClip;
      
      protected var FTreasureMapHero:TTreasureMapHero;
      
      protected var FDiggingBins:TBins;
      
      protected var FGameWinLessTimes:uint;
      
      public function TProcessorHeroTips(param1:TUIComponent)
      {
         var _loc2_:TConfigValue = null;
         super(param1);
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_TREASUREMAP.RESOURCE_ClassName_MC_HeroTip) as MovieClip;
         addChild(this.FScene);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TreasureMap_ColdTime) as TConfigValue;
         this.FGameWinLessTimes = int(_loc2_.Value);
         this.FDiggingBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Digging);
      }
      
      protected function MakeRewardStr(param1:Vector.<Object>) : String
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         _loc3_ = "";
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc4_ = uint(param1[_loc2_].amount);
            _loc3_ += STRING_COMMON.GetItemNameByType(param1[_loc2_].type,param1[_loc2_].code) + "*" + _loc4_ + ",";
            _loc2_++;
         }
         return _loc3_;
      }
      
      protected function UpdataUI() : void
      {
         var _loc1_:TDigging = null;
         var _loc2_:TDiggingReward = null;
         _loc1_ = this.FDiggingBins.GetDatebaseByIdentifier(this.FTreasureMapHero.CurQuality) as TDigging;
         var _loc3_:uint = uint(String(this.FTreasureMapHero.PlayerLevel) + _loc1_.Identifier);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TDiggingReward,_loc3_) as TDiggingReward;
         this.FScene.tf_name.text = this.FTreasureMapHero.PlayerNick;
         this.FScene.tf_level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(this.FTreasureMapHero.PlayerLevel);
         this.FScene.tf_unionName.text = this.FTreasureMapHero.HeroUnionName;
         this.FScene.tf_mapName.text = _loc1_.Name;
         this.FScene.tf_beRobberyTimes.text = this.FTreasureMapHero.BeRobberyTimes + "/" + _loc1_.Robbery;
         this.FScene.tf_rewards.text = this.MakeRewardStr(_loc2_.LossThings);
      }
      
      public function UpdataColdDown() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TDigging = null;
         _loc2_ = this.FDiggingBins.GetDatebaseByIdentifier(this.FTreasureMapHero.CurQuality) as TDigging;
         _loc1_ = _loc2_.Digtime - (this.FTreasureMapHero.IsGameWin ? this.FGameWinLessTimes : 0);
         this.FScene.tf_lastTime.text = TGameUtil.fomatTime(_loc1_ + (this.FTreasureMapHero.LastTime - STimingCore.GetServerTick()));
      }
      
      public function SetHeroData(param1:TTreasureMapHero) : void
      {
         this.FTreasureMapHero = param1;
         this.UpdataUI();
      }
      
      public function CheckTipPoint() : void
      {
         if(mouseX > CONST_COMMON.STAGE_Width - this.FScene.width)
         {
            this.FScene.x = Math.max(mouseX - this.FScene.width - 40,0);
         }
         else
         {
            this.FScene.x = Math.min(mouseX + 40,CONST_COMMON.STAGE_Width - this.FScene.width);
         }
         if(mouseY > CONST_COMMON.STAGE_Height - this.FScene.height)
         {
            this.FScene.y = Math.max(mouseY - this.FScene.height,0);
         }
         else
         {
            this.FScene.y = Math.min(mouseY,CONST_COMMON.STAGE_Height - this.FScene.height);
         }
      }
   }
}

