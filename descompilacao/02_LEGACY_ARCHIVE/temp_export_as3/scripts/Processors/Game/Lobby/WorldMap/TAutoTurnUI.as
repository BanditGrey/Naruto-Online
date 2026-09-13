package Processors.Game.Lobby.WorldMap
{
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Campaign.AutoBattle.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Items.*;
   import Logics.SLogicsCore;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   
   public class TAutoTurnUI extends TUIComponent
   {
      
      protected var FSceneTitie:MovieClip;
      
      protected var FSceneTurnInfo:MovieClip;
      
      protected var FSceneEnd:MovieClip;
      
      protected var FAutoTurnResult:TTurnResult;
      
      protected var FAutoResult:TItems;
      
      protected var FTurn:int;
      
      protected var FPosY:int;
      
      protected var FTotleExp:int;
      
      protected var FTotleMoney:int;
      
      protected var FArticleBins:TBins;
      
      public function TAutoTurnUI(param1:TUIComponent)
      {
         super(param1);
         mouseEnabled = false;
         mouseChildren = false;
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
      }
      
      protected function InitUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         this.FSceneTitie = TUtilityReflection.CreateDisplayObjectInstance(CONST_CAMPAIGN.RESOURCE_ClassName_BattleTitle) as MovieClip;
         addChild(this.FSceneTitie);
         this.FPosY += this.FSceneTitie.height;
         this.FSceneTitie.tf_turn.text = String(this.FTurn);
         this.FSceneTitie.tf_turn.mouseEnabled = false;
         _loc1_ = 0;
         while(_loc1_ < this.FAutoTurnResult.WaveReward.length)
         {
            this.FSceneTurnInfo = TUtilityReflection.CreateDisplayObjectInstance(CONST_CAMPAIGN.RESOURCE_ClassName_BattleInfo) as MovieClip;
            addChild(this.FSceneTurnInfo);
            this.FSceneTurnInfo.y = this.FPosY;
            this.FPosY += this.FSceneTurnInfo.height;
            _loc2_ = int(this.FAutoTurnResult.WaveReward[_loc1_].Exp);
            _loc3_ = int(this.FAutoTurnResult.WaveReward[_loc1_].Money);
            this.FSceneTurnInfo.tf_times.text = String(_loc1_ + 1);
            this.FSceneTurnInfo.tf_times.mouseEnabled = false;
            this.FSceneTurnInfo.tf_exp.text = String("+" + (_loc2_ - SLogicsCore.KaguyaData.GetExpByExp(_loc2_)));
            this.FSceneTurnInfo.tf_exp.mouseEnabled = false;
            this.FSceneTurnInfo.tf_exp_extra.mouseEnabled = false;
            if(SLogicsCore.KaguyaData.OpenState == 0)
            {
               _loc4_ = STRING_OhtsutsukiKaguya.OnePanel_Up_Dec_03;
            }
            else if(SLogicsCore.KaguyaData.IsLongTime == 7)
            {
               _loc4_ = STRING_OhtsutsukiKaguya.OnePanel_Up_Dec_04;
            }
            else if(SLogicsCore.KaguyaData.CurLevel == 1)
            {
               _loc4_ = STRING_OhtsutsukiKaguya.OnePanel_Up_Dec_06;
            }
            else
            {
               _loc4_ = "+" + SLogicsCore.KaguyaData.GetExpByExp(_loc2_);
            }
            this.FSceneTurnInfo.tf_exp_extra.text = _loc4_;
            this.FSceneTurnInfo.tf_money.text = String("+" + _loc3_);
            this.FSceneTurnInfo.tf_money.mouseEnabled = false;
            this.FSceneTurnInfo.tf_items.text = this.GetTotleItemName(this.FAutoTurnResult.WaveReward[_loc1_]);
            this.FSceneTurnInfo.tf_items.mouseEnabled = false;
            this.FTotleExp += _loc2_;
            this.FTotleMoney += _loc3_;
            this.FAutoTurnResult.WaveReward[_loc1_].Clear();
            _loc1_++;
         }
         this.FSceneEnd = TUtilityReflection.CreateDisplayObjectInstance(CONST_CAMPAIGN.RESOURCE_ClassName_BattleEnd) as MovieClip;
         addChild(this.FSceneEnd);
         this.FSceneEnd.y = this.FPosY;
         this.FPosY += this.FSceneEnd.height;
         _loc2_ = int(this.FAutoTurnResult.EndReward.Exp);
         _loc3_ = int(this.FAutoTurnResult.EndReward.Money);
         this.FSceneEnd.tf_exp.text = String("+" + (_loc2_ - SLogicsCore.KaguyaData.GetExpByExp(_loc2_)));
         this.FSceneEnd.tf_exp.mouseEnabled = false;
         this.FSceneEnd.tf_money.text = String("+" + _loc3_);
         this.FSceneEnd.tf_money.mouseEnabled = false;
         if(SLogicsCore.KaguyaData.OpenState == 0)
         {
            _loc4_ = STRING_OhtsutsukiKaguya.OnePanel_Up_Dec_03;
         }
         else if(SLogicsCore.KaguyaData.IsLongTime == 7)
         {
            _loc4_ = STRING_OhtsutsukiKaguya.OnePanel_Up_Dec_04;
         }
         else if(SLogicsCore.KaguyaData.CurLevel == 1)
         {
            _loc4_ = STRING_OhtsutsukiKaguya.OnePanel_Up_Dec_06;
         }
         else
         {
            _loc4_ = "+" + SLogicsCore.KaguyaData.GetExpByExp(_loc2_);
         }
         this.FSceneEnd.tf_exp_extra.text = _loc4_;
         this.FSceneEnd.tf_items.text = this.GetTotleItemName(this.FAutoTurnResult.EndReward);
         this.FSceneEnd.tf_items.mouseEnabled = false;
         if(this.FSceneEnd.tf_additems)
         {
            this.FSceneEnd.tf_additems.text = this.GetAddItemName(this.FAutoTurnResult.AddReward);
            this.FSceneEnd.tf_additems.mouseEnabled = false;
         }
         this.FTotleExp += _loc2_;
         this.FTotleMoney += _loc3_;
         this.FAutoTurnResult.EndReward.Clear();
      }
      
      protected function InitResultUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FSceneTitie = TUtilityReflection.CreateDisplayObjectInstance(CONST_CAMPAIGN.RESOURCE_ClassName_BattleTitle) as MovieClip;
         addChild(this.FSceneTitie);
         this.FPosY += this.FSceneTitie.height;
         this.FSceneTitie.tf_turn.text = String(this.FTurn);
         this.FSceneTitie.tf_turn.mouseEnabled = false;
         this.FSceneTurnInfo = TUtilityReflection.CreateDisplayObjectInstance(CONST_CAMPAIGN.RESOURCE_ClassName_FBBattleInfo) as MovieClip;
         addChild(this.FSceneTurnInfo);
         this.FSceneTurnInfo.y = this.FPosY;
         this.FPosY += this.FSceneTurnInfo.height;
         _loc1_ = int(this.FAutoResult.Exp);
         _loc2_ = int(this.FAutoResult.Money);
         this.FSceneTurnInfo.tf_exp.text = String("+" + _loc1_);
         this.FSceneTurnInfo.tf_exp.mouseEnabled = false;
         this.FSceneTurnInfo.tf_money.text = String("+" + _loc2_);
         this.FSceneTurnInfo.tf_money.mouseEnabled = false;
         this.FSceneTurnInfo.tf_items.text = this.GetTotleItemName(this.FAutoResult);
         this.FSceneTurnInfo.tf_items.mouseEnabled = false;
         this.FAutoResult.Clear();
      }
      
      protected function InitPassResultUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FSceneTitie = TUtilityReflection.CreateDisplayObjectInstance(CONST_CAMPAIGN.RESOURCE_ClassName_BattlePass) as MovieClip;
         addChild(this.FSceneTitie);
         this.FPosY += this.FSceneTitie.height;
         this.FSceneEnd = TUtilityReflection.CreateDisplayObjectInstance(CONST_CAMPAIGN.RESOURCE_ClassName_BattleEndFB) as MovieClip;
         addChild(this.FSceneEnd);
         this.FSceneEnd.y = this.FPosY;
         this.FPosY += this.FSceneEnd.height;
         _loc1_ = int(this.FAutoResult.Exp);
         _loc2_ = int(this.FAutoResult.Money);
         this.FSceneEnd.tf_exp.text = String("+" + _loc1_);
         this.FSceneEnd.tf_exp.mouseEnabled = false;
         this.FSceneEnd.tf_money.text = String("+" + _loc2_);
         this.FSceneEnd.tf_money.mouseEnabled = false;
         this.FSceneEnd.tf_items.text = this.GetTotleItemName(this.FAutoResult);
         this.FSceneEnd.tf_items.mouseEnabled = false;
         this.FTotleExp += _loc1_;
         this.FTotleMoney += _loc2_;
         if(this.FSceneEnd.tf_additems)
         {
            this.FSceneEnd.tf_additems.text = "";
            this.FSceneEnd.tf_additems.mouseEnabled = false;
         }
         this.FAutoResult.Clear();
      }
      
      protected function GetTotleItemName(param1:TItems) : String
      {
         var _loc2_:int = 0;
         var _loc4_:Vector.<TItem> = null;
         var _loc5_:TArticle = null;
         var _loc3_:String = "";
         _loc4_ = param1.ItemIDs;
         _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            if(_loc2_ != 0)
            {
               _loc3_ += " ";
            }
            _loc5_ = this.FArticleBins.GetDatebaseByIdentifier(_loc4_[_loc2_].ID) as TArticle;
            if(_loc4_[_loc2_].Type == 1)
            {
               _loc3_ += _loc5_.Name;
            }
            else
            {
               _loc3_ += STRING_COMMON.GetItemNameByType(_loc4_[_loc2_].Type,_loc4_[_loc2_].ID);
            }
            _loc3_ += "* " + _loc4_[_loc2_].Count;
            _loc2_++;
         }
         return _loc3_;
      }
      
      protected function GetAddItemName(param1:TItem) : String
      {
         var _loc2_:int = 0;
         var _loc4_:Vector.<Object> = null;
         var _loc5_:TConfigValue = null;
         var _loc3_:String = "";
         if(param1 != null)
         {
            _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.DROP_ITEM_NAME) as TConfigValue;
            _loc4_ = _loc5_.Value as Vector.<Object>;
            _loc3_ = _loc4_[param1.Type - 1] + "* " + param1.Count;
         }
         return _loc3_;
      }
      
      public function SetTurnResult(param1:TTurnResult, param2:int) : void
      {
         this.FAutoTurnResult = param1;
         this.FTurn = param2;
         this.FPosY = 0;
         this.FTotleExp = 0;
         this.FTotleMoney = 0;
         this.InitUI();
      }
      
      public function SetResult(param1:TItems, param2:int) : void
      {
         this.FAutoResult = param1;
         this.FTurn = param2;
         this.FPosY = 0;
         this.InitResultUI();
      }
      
      public function SetPassResult(param1:TItems) : void
      {
         this.FAutoResult = param1;
         this.FPosY = 0;
         this.FTotleExp = 0;
         this.FTotleMoney = 0;
         this.InitPassResultUI();
      }
      
      public function get TotleExp() : int
      {
         return this.FTotleExp;
      }
      
      public function get TotleMoney() : int
      {
         return this.FTotleMoney;
      }
   }
}

