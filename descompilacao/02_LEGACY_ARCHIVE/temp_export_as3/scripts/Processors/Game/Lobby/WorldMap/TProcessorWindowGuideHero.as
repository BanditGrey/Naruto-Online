package Processors.Game.Lobby.WorldMap
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.TGuideHero;
   import Logics.DatebaseVO.VO.THeroTalent;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.DatebaseVO.VO.TSkillConfig;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.WorldMap.Componets.TGuideTeamHero;
   import Resources.Constants.CONST_CAMPAIGN;
   import Resources.Constants.CONST_CHARACTER;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowGuideHero extends TProcessorLobbyWindow
   {
      
      protected static const MAX_TEAMHERO_COUNT:uint = 6;
      
      protected static const MAX_HERO_COUNT:uint = 3;
      
      public static const PROFESSION_Agility:uint = CONST_CHARACTER.PROFESSION_Agility;
      
      public static const PROFESSION_Defending:uint = CONST_CHARACTER.PROFESSION_Defending;
      
      public static const PROFESSION_Intellect:uint = CONST_CHARACTER.PROFESSION_Intellect;
      
      public static const PROFESSION_Strength:uint = CONST_CHARACTER.PROFESSION_Strength;
      
      protected static const INDEX_Station_Front:int = 1;
      
      protected static const INDEX_Station_Middle:int = 2;
      
      protected static const INDEX_Station_After:int = 3;
      
      protected var FScene:MovieClip;
      
      protected var FIsInit:Boolean;
      
      protected var FBaseHeroBins:TBins;
      
      protected var FRoleModelBins:TBins;
      
      protected var FHeroTalentBins:TBins;
      
      protected var FSkillConfigBins:TBins;
      
      protected var FGuideHeroBins:TBins;
      
      protected var FGuideTeamHeroVect:Vector.<TGuideTeamHero>;
      
      protected var FGuideHero:TGuideHero;
      
      protected var FHeroBitmap:Bitmap;
      
      protected var FHeroModelId:uint;
      
      protected var FMissionId:uint;
      
      protected var FOnNotifySelectHero:Function;
      
      public function TProcessorWindowGuideHero(param1:TUIComponent)
      {
         super(param1);
         this.FIsInit = false;
         this.FGuideTeamHeroVect = new Vector.<TGuideTeamHero>(MAX_TEAMHERO_COUNT);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_CAMPAIGN.RESOURCESID_GuideHero);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIWait() : void
      {
         if(SResourcesCore.LoadingPrimary)
         {
            return;
         }
         this.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_CAMPAIGN.RESOURCE_ClassName_GuideHero) as MovieClip;
         addChild(this.FScene);
         this.InitGuideHero();
         this.FIsInit = true;
         this.AutoGetCurLevelHero();
         this.UpdataUI();
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function InitGuideHero() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TGuideTeamHero = null;
         var _loc3_:TGuideHero = null;
         var _loc4_:TGuideHero = null;
         var _loc5_:TGuideHero = null;
         this.FGuideHeroBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_GuideHero);
         this.FBaseHeroBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
         this.FRoleModelBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
         this.FHeroTalentBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_HeroTalent);
         this.FSkillConfigBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SkillConfig);
         _loc1_ = 0;
         while(_loc1_ < MAX_TEAMHERO_COUNT)
         {
            _loc2_ = new TGuideTeamHero(this.FScene["mc_hero"]["MC_Heros_" + _loc1_]);
            _loc3_ = this.FGuideHeroBins.GetDatebaseByIndex(_loc1_ * MAX_HERO_COUNT) as TGuideHero;
            _loc4_ = this.FGuideHeroBins.GetDatebaseByIndex(_loc1_ * MAX_HERO_COUNT + 1) as TGuideHero;
            _loc5_ = this.FGuideHeroBins.GetDatebaseByIndex(_loc1_ * MAX_HERO_COUNT + 2) as TGuideHero;
            _loc2_.SetInfo(_loc3_,_loc4_,_loc5_);
            _loc2_.OnSelectHero = this.OnSelectHero;
            this.FGuideTeamHeroVect[_loc1_] = _loc2_;
            _loc1_++;
         }
         this.FScene["mc_hero"]["Btn_ok"].addEventListener(MouseEvent.CLICK,this.OnHeroSelected);
         this.FHeroBitmap = new Bitmap();
         this.FScene["mc_hero"]["MC_RoleMoudle"]["MC_RoleMoudleInner"]["LargePic_MountPoint"].addChild(this.FHeroBitmap);
      }
      
      protected function OnSelectHero(param1:Object, param2:TGuideHero) : void
      {
         this.FGuideHero = param2;
         this.UpdataUI();
      }
      
      protected function AutoGetCurLevelHero() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TGuideTeamHero = null;
         var _loc3_:uint = 0;
         _loc3_ = uint(SLogicsCore.Character.GetMainLevel());
         _loc1_ = 0;
         while(_loc1_ < MAX_TEAMHERO_COUNT)
         {
            _loc2_ = this.FGuideTeamHeroVect[_loc1_];
            if(_loc3_ < _loc2_.OpenLevel)
            {
               break;
            }
            _loc1_++;
         }
         _loc2_ = this.FGuideTeamHeroVect[_loc1_ - 1];
         this.FGuideHero = _loc2_.FirstHero;
      }
      
      protected function UpdataUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TGuideTeamHero = null;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseHero = null;
         var _loc5_:TRoleModel = null;
         var _loc6_:THeroTalent = null;
         var _loc7_:TSkillConfig = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_TEAMHERO_COUNT)
         {
            _loc2_ = this.FGuideTeamHeroVect[_loc1_];
            _loc2_.SetSelectHero(this.FGuideHero);
            _loc1_++;
         }
         _loc4_ = this.FBaseHeroBins.GetDatebaseByIdentifier(this.FGuideHero.BaseheroID) as TBaseHero;
         _loc5_ = this.FRoleModelBins.GetDatebaseByIdentifier(this.FGuideHero.BaseheroID) as TRoleModel;
         this.FScene["mc_hero"]["MC_RoleMoudle"].gotoAndPlay(1);
         _loc3_ = this.FScene["mc_hero"]["MC_RoleMoudle"]["MC_RoleMoudleInner"];
         _loc3_["MC_Position"].gotoAndStop(this.StandPositionWithProfession(_loc4_));
         _loc3_["MC_TFName"]["TF_Name"].text = _loc4_.Name;
         this.FHeroModelId = _loc5_.Model;
         _loc3_["MC_Property"]["tf_power"].text = _loc4_.Power.toString();
         _loc3_["MC_Property"]["tf_intelligence"].text = _loc4_.Intelligence.toString();
         _loc3_["MC_Property"]["tf_agile"].text = _loc4_.Agile.toString();
         _loc3_["MC_Property"]["tf_speed"].text = _loc4_.Speed.toString();
         _loc3_["MC_Property"]["tf_powerGrow"].text = _loc4_.PowerGrow.toString();
         _loc3_["MC_Property"]["tf_intelligenceGrow"].text = _loc4_.IntelligenceGrow.toString();
         _loc3_["MC_Property"]["tf_agileGrow"].text = _loc4_.AgileGrow.toString();
         _loc3_["MC_Property"]["tf_speedGrow"].text = _loc4_.SpeedGrow.toString();
         _loc6_ = this.FHeroTalentBins.GetDatebaseByIdentifier(_loc4_.Talent) as THeroTalent;
         _loc3_["MC_Property"]["tf_talent"].text = _loc6_.TalentName;
         _loc7_ = this.FSkillConfigBins.GetDatebaseByIdentifier(_loc4_.Active) as TSkillConfig;
         _loc3_["MC_Property"]["tf_skillName"].text = _loc7_.Name;
      }
      
      public function StandPositionWithProfession(param1:TBaseHero) : uint
      {
         var _loc2_:uint = 0;
         switch(param1.Profession)
         {
            case PROFESSION_Agility:
            case PROFESSION_Strength:
               _loc2_ = uint(INDEX_Station_Middle);
               break;
            case PROFESSION_Defending:
               _loc2_ = uint(INDEX_Station_Front);
               break;
            case PROFESSION_Intellect:
               _loc2_ = uint(INDEX_Station_After);
         }
         return _loc2_;
      }
      
      protected function OnHeroSelected(param1:MouseEvent) : void
      {
         this.Visible = false;
         if(this.FOnNotifySelectHero != null)
         {
            this.FOnNotifySelectHero(this,this.FMissionId,this.FGuideHero.Identifier);
         }
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
         if(!this.FIsInit)
         {
            Load();
         }
         else if(param1)
         {
            this.AutoGetCurLevelHero();
            this.UpdataUI();
         }
      }
      
      public function get OnNotifySelectHero() : Function
      {
         return this.FOnNotifySelectHero;
      }
      
      public function set OnNotifySelectHero(param1:Function) : void
      {
         this.FOnNotifySelectHero = param1;
      }
      
      public function get MissionId() : uint
      {
         return this.FMissionId;
      }
      
      public function set MissionId(param1:uint) : void
      {
         this.FMissionId = param1;
      }
      
      public function UpdateBitmap() : void
      {
         if(this.FIsInit)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_LargeIcon,this.FHeroBitmap,CONST_MODULES.MODULE_WorldMap,this.FHeroModelId);
         }
      }
   }
}

