package Processors.Game.Lobby.Tavern
{
   import Foundation.Common.THint;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.CrossServerWar.TEliteRecord;
   import Logics.DatebaseVO.VO.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.TProcessorLobby;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TProcessorWindowRecruit extends TProcessorLobbyWindow
   {
      
      protected static const TYPE_Tavern:uint = 1;
      
      protected static const TYPE_Other:uint = 2;
      
      protected static const TYPE_CrossServerWar:uint = 3;
      
      protected static const BTN_QUALITY_BULE:uint = 3;
      
      protected static const BTN_QUALITY_PURPLE:uint = 4;
      
      protected static const BTN_QUALITY_GOLD:uint = 5;
      
      protected static const BTN_QUALITY_ORANGE:uint = 6;
      
      protected static const BTN_QUALITY_ORANGETONE:uint = 10;
      
      protected static const COLOR_QUALITY_BULE:uint = 6094297;
      
      protected static const COLOR_QUALITY_PURPLE:uint = 14245117;
      
      protected static const COLOR_QUALITY_GOLD:uint = 16763904;
      
      protected static const COLOR_QUALITY_ORANGE:uint = 16724736;
      
      protected var FScene:MovieClip;
      
      protected var FBaseHeroBins:TBins;
      
      protected var FRoleModelBins:TBins;
      
      protected var FHeroTalentBins:TBins;
      
      protected var FSkillConfigBins:TBins;
      
      protected var FMilitaryBins:TBins;
      
      protected var FConfigValueBin:TBins;
      
      protected var FBaseHero:TBaseHero;
      
      protected var FHeadIcon:uint;
      
      protected var FTavernWarriorId:uint;
      
      protected var FHeroId:uint;
      
      protected var FIsCanRecruit:Boolean;
      
      protected var FNeedSoulType:uint;
      
      protected var FNeedSoulValue:uint;
      
      protected var FHeadBitmap:Bitmap;
      
      protected var FCharacter:TCharacter;
      
      protected var FHint:THint;
      
      protected var FHeroTalent:THeroTalent;
      
      protected var FSkillConfig:TSkillConfig;
      
      protected var FConfigValue:TConfigValue;
      
      protected var FEliteRecord:TEliteRecord;
      
      protected var FCurType:uint;
      
      protected var FSource:Vector.<Object>;
      
      protected var FBarrierDeactuate:Function;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FOnRecruitCLick:Function;
      
      public function TProcessorWindowRecruit(param1:TUIComponent)
      {
         super(param1);
         this.FEliteRecord = SLogicsCore.EliteRecord;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TAVERN.RESOURCESID_TAVERN_TIP);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.InitRecruit();
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function InitRecruit() : void
      {
         this.FHint = new THint();
         this.FBaseHeroBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
         this.FRoleModelBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
         this.FHeroTalentBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_HeroTalent);
         this.FSkillConfigBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SkillConfig);
         this.FMilitaryBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Military);
         this.FConfigValueBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConfigValue);
         this.FConfigValue = this.FConfigValueBin.GetDatebaseByIdentifier(CONST_CONFIGVALUE.TAVERN_Hero_Source) as TConfigValue;
         this.FSource = this.FConfigValue.Value as Vector.<Object>;
         this.FHeadBitmap = new Bitmap();
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_TAVERN.RESOURCESID_CLASSNAME_TavernTip) as MovieClip;
         addChild(this.FScene);
         TGameUtil.setButtonMode(this.FScene.btn_closeBtn,true);
         this.FScene.btn_closeBtn.addEventListener(MouseEvent.CLICK,this.OnCloseRecruit);
         TGameUtil.setButtonMode(this.FScene.btn_close,true);
         this.FScene.btn_close.addEventListener(MouseEvent.CLICK,this.OnCloseRecruit);
         this.FScene.btn_recruitBtn.addEventListener(MouseEvent.CLICK,this.OnRecruit);
         this.FScene.mc_headIcon.addChild(this.FHeadBitmap);
         TGameUtil.setButtonMode(this.FScene.MC_SkillShow,true);
         this.FScene.MC_SkillShow.addEventListener(MouseEvent.CLICK,this.OnSkillShow);
         this.FScene.tf_skill.addEventListener(MouseEvent.MOUSE_MOVE,this.SkillOnMove);
         this.FScene.tf_skill.addEventListener(MouseEvent.ROLL_OUT,this.SkillOnOut);
         this.FScene.tf_talent.addEventListener(MouseEvent.MOUSE_MOVE,this.SkillOnMove);
         this.FScene.tf_talent.addEventListener(MouseEvent.ROLL_OUT,this.SkillOnOut);
         this.FCharacter = SLogicsCore.Character;
      }
      
      protected function GetSoulValueByType(param1:uint) : int
      {
         switch(param1)
         {
            case BTN_QUALITY_BULE:
               return this.FCharacter.HeroSoulBlueSoul;
            case BTN_QUALITY_PURPLE:
               return this.FCharacter.HeroSoulPurpleSoul;
            case BTN_QUALITY_GOLD:
               return this.FCharacter.HeroSoulGoldSoul;
            case BTN_QUALITY_ORANGE:
               return this.FCharacter.HeroSoulOrangeSoul;
            case BTN_QUALITY_ORANGETONE:
               return this.FEliteRecord.OrangeSoulCount;
            default:
               return 0;
         }
      }
      
      protected function GetProfession(param1:uint) : uint
      {
         switch(param1)
         {
            case 1:
               return CONST_SYSTEMLANGUAGE.Pro_1;
            case 2:
               return CONST_SYSTEMLANGUAGE.Pro_2;
            case 3:
               return CONST_SYSTEMLANGUAGE.Pro_3;
            case 4:
               return CONST_SYSTEMLANGUAGE.Pro_4;
            case 5:
               return CONST_SYSTEMLANGUAGE.Pro_5;
            default:
               return CONST_SYSTEMLANGUAGE.Pro_1;
         }
      }
      
      protected function GetProfessionName(param1:uint) : String
      {
         var _loc2_:uint = 0;
         var _loc3_:TSystemLanguage = null;
         _loc2_ = this.GetProfession(param1);
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,_loc2_) as TSystemLanguage;
         return _loc3_.Desc;
      }
      
      protected function GetPostion(param1:int) : String
      {
         var _loc2_:String = "";
         if(CONST_CHARACTER.PROFESSION_Agility == param1)
         {
            _loc2_ = STRING_TAVERN.GeneralMiddle;
         }
         if(CONST_CHARACTER.PROFESSION_Defending == param1)
         {
            _loc2_ = STRING_TAVERN.GeneralBefor;
         }
         if(CONST_CHARACTER.PROFESSION_Intellect == param1)
         {
            _loc2_ = STRING_TAVERN.GeneralAfter;
         }
         if(CONST_CHARACTER.PROFESSION_Strength == param1)
         {
            _loc2_ = STRING_TAVERN.GeneralMiddle;
         }
         if(CONST_CHARACTER.PROFESSION_Warlock == param1)
         {
            _loc2_ = STRING_TAVERN.GeneralAfter;
         }
         return _loc2_;
      }
      
      protected function GetColorWithQuality(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case BTN_QUALITY_BULE:
               _loc2_ = COLOR_QUALITY_BULE;
               break;
            case BTN_QUALITY_PURPLE:
               _loc2_ = COLOR_QUALITY_PURPLE;
               break;
            case BTN_QUALITY_GOLD:
               _loc2_ = COLOR_QUALITY_GOLD;
               break;
            case BTN_QUALITY_ORANGE:
               _loc2_ = COLOR_QUALITY_ORANGE;
               break;
            default:
               _loc2_ = COLOR_QUALITY_BULE;
         }
         return _loc2_;
      }
      
      protected function UpdataUI() : void
      {
         if(this.FBaseHero == null)
         {
            return;
         }
         if(this.FCurType == TYPE_Other)
         {
            this.FScene.btn_close.visible = true;
            this.FScene.btn_recruitBtn.visible = false;
            this.FScene.btn_closeBtn.visible = false;
         }
         else
         {
            TGameUtil.setButtonMode(this.FScene.btn_recruitBtn,this.FIsCanRecruit);
            this.FScene.btn_close.visible = false;
            this.FScene.btn_recruitBtn.visible = true;
            this.FScene.btn_closeBtn.visible = true;
         }
         this.FScene.tf_HeroName.text = this.FBaseHero.Name;
         this.FScene.tf_HeroName.textColor = this.GetColorWithQuality(this.FBaseHero.Quality);
         this.FScene.tf_briefIntroduction.text = this.FBaseHero.Desc;
         this.FScene.tf_profession.text = this.GetProfessionName(this.FBaseHero.Profession);
         this.FScene.tf_location.text = this.GetPostion(this.FBaseHero.Profession);
         this.FScene.tf_strength.text = this.FBaseHero.Power;
         this.FScene.tf_intelligence.text = this.FBaseHero.Intelligence;
         this.FScene.tf_agile.text = this.FBaseHero.Agile;
         this.FScene.tf_life.text = this.FBaseHero.Life;
         this.FScene.tf_strengthRate.text = this.FBaseHero.PowerGrow;
         this.FScene.tf_intelligenceRate.text = this.FBaseHero.IntelligenceGrow;
         this.FScene.tf_agileRate.text = this.FBaseHero.AgileGrow;
         this.FScene.tf_lifeRate.text = this.FBaseHero.LifeGrow;
         this.FHeroTalent = this.FHeroTalentBins.GetDatebaseByIdentifier(this.FBaseHero.Talent) as THeroTalent;
         this.FScene.tf_talent.text = this.FHeroTalent.TalentName;
         this.FSkillConfig = this.FSkillConfigBins.GetDatebaseByIdentifier(this.FBaseHero.Active) as TSkillConfig;
         this.FScene.tf_skill.text = this.FSkillConfig.Name;
         this.FScene.mc_assess.gotoAndStop(this.FBaseHero.Assess);
         if(this.FCurType == TYPE_Other)
         {
            this.FScene.tf_needSouls.text = this.FSource[this.FBaseHero.Source];
            this.FScene.mc_soul.visible = false;
            this.FScene.mc_source.visible = true;
         }
         else
         {
            this.FScene.mc_soul.gotoAndStop(this.FNeedSoulType);
            this.FScene.tf_needSouls.text = String(this.FNeedSoulValue);
            this.FScene.mc_soul.visible = true;
            this.FScene.mc_source.visible = false;
         }
         this.FScene.tf_needSouls.textColor = this.GetColorWithQuality(this.FBaseHero.Quality);
      }
      
      protected function IsCanRecruit() : Boolean
      {
         var _loc1_:TMilitary = null;
         _loc1_ = this.FMilitaryBins.GetDatebaseByIdentifier(this.FCharacter.MilitaryRank) as TMilitary;
         if(this.FCharacter.Heros.Count >= _loc1_.MaxHeroNum + this.FCharacter.BuyHeroSlot)
         {
            EffectGenerateText(STRING_TAVERN.NotRecruit);
            return false;
         }
         if(this.GetSoulValueByType(this.FNeedSoulType) < this.FNeedSoulValue)
         {
            EffectGenerateText(STRING_COMMON.NOTENOUGH_Soul);
            return false;
         }
         return true;
      }
      
      protected function OnRecruit(param1:MouseEvent) : void
      {
         if(this.FCurType == TYPE_Other)
         {
            return;
         }
         if(Boolean(param1) && Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FCurType == TYPE_Tavern)
         {
            if(!this.IsCanRecruit())
            {
               return;
            }
         }
         if(this.FOnRecruitCLick != null)
         {
            this.FOnRecruitCLick(this,this.FTavernWarriorId);
         }
         this.OnCloseRecruit();
      }
      
      protected function OnCloseRecruit(param1:MouseEvent = null) : void
      {
         Visible = false;
         if(param1)
         {
            SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_Recruit);
         }
         if(this.FBarrierDeactuate != null)
         {
            this.FBarrierDeactuate(this);
         }
      }
      
      protected function SkillOnMove(param1:MouseEvent) : void
      {
         if(this.FHintOnOver != null)
         {
            if(param1.currentTarget == this.FScene.tf_skill)
            {
               this.FHint.Caption = this.FSkillConfig.Desc;
            }
            else if(param1.currentTarget == this.FScene.tf_talent)
            {
               this.FHint.Caption = this.FHeroTalent.TalentDesc;
            }
            this.FHintOnOver(param1,this.FHint);
         }
      }
      
      protected function SkillOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      protected function OnSkillShow(param1:MouseEvent) : void
      {
         if(TProcessorLobby.SkillShowTimeFunction != null)
         {
            TProcessorLobby.SkillShowTimeFunction(this.FHeroId);
         }
      }
      
      public function get BarrierDeactuate() : Function
      {
         return this.FBarrierDeactuate;
      }
      
      public function set BarrierDeactuate(param1:Function) : void
      {
         this.FBarrierDeactuate = param1;
      }
      
      public function get HintOnOver() : Function
      {
         return this.FHintOnOver;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function get OnRecruitCLick() : Function
      {
         return this.FOnRecruitCLick;
      }
      
      public function set OnRecruitCLick(param1:Function) : void
      {
         this.FOnRecruitCLick = param1;
      }
      
      public function SetRecruitData(param1:TTavernWarrior, param2:Boolean, param3:uint = 0) : void
      {
         var _loc4_:TRoleModel = null;
         if(param3 == 0)
         {
            this.FCurType = TYPE_Tavern;
         }
         else
         {
            this.FCurType = param3;
         }
         this.FTavernWarriorId = param1.Identifier;
         this.FHeroId = param1.AwardId;
         this.FIsCanRecruit = param2;
         this.FNeedSoulType = param1.Awardsouls.Type;
         this.FNeedSoulValue = param1.RecruitSoul;
         this.FBaseHero = this.FBaseHeroBins.GetDatebaseByIdentifier(this.FHeroId) as TBaseHero;
         _loc4_ = this.FRoleModelBins.GetDatebaseByIdentifier(this.FHeroId) as TRoleModel;
         this.FHeadIcon = _loc4_.RoleHead;
         this.UpdataUI();
         Visible = true;
      }
      
      public function SetHeroData(param1:uint) : void
      {
         var _loc2_:TRoleModel = null;
         this.FCurType = TYPE_Other;
         this.FHeroId = param1;
         this.FBaseHero = this.FBaseHeroBins.GetDatebaseByIdentifier(this.FHeroId) as TBaseHero;
         _loc2_ = this.FRoleModelBins.GetDatebaseByIdentifier(this.FHeroId) as TRoleModel;
         this.FHeadIcon = _loc2_.RoleHead;
         this.UpdataUI();
         Visible = true;
      }
      
      public function UpdataBitmap() : void
      {
         if(this.FBaseHero != null)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FHeadBitmap,CONST_MODULES.MODULE_Recruit,this.FHeadIcon);
         }
      }
   }
}

