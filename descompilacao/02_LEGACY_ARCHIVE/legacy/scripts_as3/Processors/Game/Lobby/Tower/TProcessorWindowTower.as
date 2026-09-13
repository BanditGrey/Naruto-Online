package Processors.Game.Lobby.Tower
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TEnchantBattle;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Logics.Tower.TTower;
   import Logics.Tower.TTowerData;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.Tower.Conponents.TUITower;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TOWER;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowTower extends TProcessorWindowTemplate
   {
      
      protected static const MAX_TOWN_COUNT:uint = 6;
      
      protected var FTF_ExploreCount:TextField;
      
      protected var FMC_LeftPage:MovieClip;
      
      protected var FMC_RightPage:MovieClip;
      
      protected var FUITowers:Vector.<TUITower>;
      
      protected var FTowerData:TTowerData;
      
      protected var FEnterLevelOnClick:Function;
      
      public function TProcessorWindowTower(param1:TUIComponent)
      {
         super(param1);
         this.FUITowers = new Vector.<TUITower>(CONST_TOWER.CAPACITY_TowerCount);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TOWER.RESOURCESID_Swf_Tower);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TUITower = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_TOWER.RESOURCE_ClassName_MC_Tower) as Sprite;
         UIDispatch();
         _loc3_ = CONST_TOWER.CAPACITY_TowerCount;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = new TUITower(this);
            _loc1_.Resource = FMainUI[CONST_TOWER.RESOURCE_Link_MC_Tower + _loc2_] as MovieClip;
            _loc1_.Tag = _loc2_;
            _loc1_.EnterOnClick = this.ProcessorEnterOnClick;
            _loc1_.Init();
            this.FUITowers[_loc2_] = _loc1_;
            if(_loc2_ >= MAX_TOWN_COUNT)
            {
               FMainUI[CONST_TOWER.RESOURCE_Link_MC_Tower + _loc2_].visible = false;
            }
            _loc2_++;
         }
         this.FTF_ExploreCount = FMainUI["TF_ExploreCount"];
         this.FMC_LeftPage = FMainUI["MC_LeftPage"];
         TGameUtil.setButtonMode(this.FMC_LeftPage,true);
         this.FMC_LeftPage.visible = false;
         this.FMC_RightPage = FMainUI["MC_RightPage"];
         TGameUtil.setButtonMode(this.FMC_RightPage,true);
         this.FMC_RightPage.visible = true;
         this.FMC_LeftPage.addEventListener(MouseEvent.CLICK,this.OnLeftClick);
         this.FMC_RightPage.addEventListener(MouseEvent.CLICK,this.OnRightClick);
         if(!SLogicsCore.Character.GetConfigValueById(91000009))
         {
            this.FMC_RightPage.visible = false;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TSystemLanguage = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.Tower_Map_Tips) as TSystemLanguage;
         UILocations();
         FHelpTips.Content = _loc1_.Desc;
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateUI() : void
      {
         this.UpdateTowers();
         this.UpdateCount();
      }
      
      protected function UpdateTowers() : void
      {
         var _loc1_:TUITower = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TEnchantBattle = null;
         var _loc5_:TTower = null;
         _loc3_ = CONST_TOWER.CAPACITY_TowerCount;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = this.FUITowers[_loc2_];
            _loc4_ = this.FTowerData.Towers.GetEnchantBattleByIndex(_loc2_);
            if(this.FTowerData.OpenTowers.Count > 0)
            {
               _loc5_ = this.FTowerData.OpenTowers.GetTowerByIndex(_loc2_);
            }
            _loc1_.Context = _loc4_;
            _loc1_.ContextB = _loc5_;
            _loc1_.Update(this.FTowerData);
            _loc2_++;
         }
      }
      
      protected function UpdateCount() : void
      {
         this.FTF_ExploreCount.text = this.FTowerData.FreeExploreTimes.toString();
      }
      
      protected function ProcessorEnterOnClick(param1:Object, param2:int) : void
      {
         if(this.FEnterLevelOnClick != null)
         {
            this.FEnterLevelOnClick(this,param2);
         }
      }
      
      public function get EnterLevelOnClick() : Function
      {
         return this.FEnterLevelOnClick;
      }
      
      public function set EnterLevelOnClick(param1:Function) : void
      {
         this.FEnterLevelOnClick = param1;
      }
      
      protected function OnLeftClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         this.FMC_LeftPage.visible = false;
         this.FMC_RightPage.visible = true;
         _loc3_ = CONST_TOWER.CAPACITY_TowerCount;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = FMainUI[CONST_TOWER.RESOURCE_Link_MC_Tower + _loc2_];
            if(_loc2_ < MAX_TOWN_COUNT)
            {
               _loc4_.visible = true;
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc2_++;
         }
      }
      
      protected function OnRightClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         this.FMC_LeftPage.visible = true;
         this.FMC_RightPage.visible = false;
         _loc3_ = CONST_TOWER.CAPACITY_TowerCount;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = FMainUI[CONST_TOWER.RESOURCE_Link_MC_Tower + _loc2_];
            if(_loc2_ < MAX_TOWN_COUNT)
            {
               _loc4_.visible = false;
            }
            else
            {
               _loc4_.visible = true;
            }
            _loc2_++;
         }
      }
      
      public function Update(param1:TTowerData) : void
      {
         this.FTowerData = param1;
         this.UpdateUI();
      }
   }
}

