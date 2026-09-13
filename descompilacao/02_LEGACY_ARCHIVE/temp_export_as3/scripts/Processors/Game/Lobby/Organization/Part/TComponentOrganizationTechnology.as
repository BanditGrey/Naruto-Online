package Processors.Game.Lobby.Organization.Part
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TOrganizationAddition;
   import Logics.Organization.TBaseOrganization;
   import Logics.SLogicsCore;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Organization.Component.TTechnologyItem;
   import Rendering.Overlayers.OrganizationCamp.TOverlayerOrganizationCamp;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_ORGANIZATION;
   import Resources.Strings.STRING_ORGANIZATION;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TComponentOrganizationTechnology extends TUIComponent
   {
      
      protected static const SKILL_COUNT:int = 6;
      
      protected static const ADD_COUNT:int = 11;
      
      protected static const FORMAT_SKILL_NAME:Vector.<String> = STRING_ORGANIZATION.FORMAT_SKILL_NAME;
      
      protected static const PHYS_ATK_ADDITION:int = CONST_ORGANIZATION.PHYS_ATK_ADDITION;
      
      protected static const PHYS_DEF_ADDITION:int = CONST_ORGANIZATION.PHYS_DEF_ADDITION;
      
      protected static const MAG_DEF_ADDITION:int = CONST_ORGANIZATION.MAG_DEF_ADDITION;
      
      protected static const LIFE_ADDITION:int = CONST_ORGANIZATION.LIFE_ADDITION;
      
      protected static const SPEED_ADDITION:int = CONST_ORGANIZATION.SPEED_ADDITION;
      
      public static const FFilterColor:int = 16777113;
      
      public static const FilterGlowWidth:int = 4;
      
      public static const FilterGlowStrength:int = 20;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMC_Skill:Vector.<TTechnologyItem>;
      
      protected var FMC_Add:Vector.<MovieClip>;
      
      protected var FBtn_Donate:MovieClip;
      
      protected var FMC_MC_ChangePage:MovieClip;
      
      protected var FUI_Left_Btn:MovieClip;
      
      protected var FUI_Right_Btn:MovieClip;
      
      protected var FUI_Page_TF:TextField;
      
      private var FTF_Exploit:TextField;
      
      private var FInitialized:Boolean;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:uint = 1;
      
      protected var FCurPage:uint = 0;
      
      protected var FOverlayerOrganizationCamp:TOverlayerOrganizationCamp;
      
      protected var FGlowsFilter:TEffectBaseGlowTwo;
      
      protected var FOrgBaseInfo:TBaseOrganization;
      
      protected var FOnBtnDonateClick:Function;
      
      protected var FOnBtnLearnClick:Function;
      
      protected var FTechnologyData:Vector.<Object>;
      
      protected var FExploitData:Number;
      
      public function TComponentOrganizationTechnology(param1:TUIComponent)
      {
         super(param1);
         this.FMC_Skill = new Vector.<TTechnologyItem>();
         this.FMC_Add = new Vector.<MovieClip>();
         this.FOverlayerOrganizationCamp = new TOverlayerOrganizationCamp(this.Parent.Parent.Parent);
         this.FOverlayerOrganizationCamp.Visible = false;
         this.FGlowsFilter = new TEffectBaseGlowTwo();
         this.FTechnologyData = new Vector.<Object>();
         this.FCurPage = 0;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TTechnologyItem = null;
         var _loc4_:MovieClip = null;
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         this.FTF_Exploit = this.FMC_Scene[CONST_ORGANIZATION.RESOURCE_Link_TF_Exploit];
         var _loc5_:int = int(this.FMC_Skill.length);
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc3_ = this.FMC_Skill.pop();
            _loc3_.parent.removeChild(_loc3_);
            _loc2_++;
         }
         this.FMC_Skill.length = 0;
         _loc2_ = 0;
         while(_loc2_ < SKILL_COUNT)
         {
            _loc3_ = new TTechnologyItem(this);
            _loc4_ = this.FMC_Scene[CONST_ORGANIZATION.RESOURCE_Link_MC_TechnologyItem + _loc2_];
            _loc3_.Perform_UIDispatch(_loc4_);
            _loc3_.SkillIndex = _loc2_;
            _loc3_.OnLearnSkillClick = this.ProcessorOnLearnSkill;
            _loc3_.OnTipMove = this.UIComponentsHintOnOver;
            _loc3_.OnTipOut = this.UIComponentsHintOnOut;
            this.FMC_Skill.push(_loc3_);
            this.FMC_Skill[_loc2_].IsVisible = false;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < ADD_COUNT)
         {
            this.FMC_Add.push(this.FMC_Scene[CONST_ORGANIZATION.RESOURCE_Link_MC_AddAttribute + _loc2_]);
            this.FMC_Add[_loc2_].visible = false;
            _loc2_++;
         }
         this.FUIPage = new TUIPage(this);
         this.FMC_MC_ChangePage = this.FMC_Scene[CONST_ORGANIZATION.RESOURCE_Link_MC_ChangePage];
         this.FUI_Left_Btn = this.FMC_MC_ChangePage["MC_PageLeft"];
         this.FUI_Right_Btn = this.FMC_MC_ChangePage["MC_PageRight"];
         this.FUI_Page_TF = this.FMC_MC_ChangePage["TF_Page"];
         this.FUIPage.ButtonPrevious.Substrate = this.FUI_Left_Btn;
         this.FUIPage.ButtonNext.Substrate = this.FUI_Right_Btn;
         this.FUIPage.LabelPage = this.FUI_Page_TF;
         this.FUIPage.TotalQuantity = SKILL_COUNT;
         this.FUIPage.PageSize = SKILL_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.PageOnChange;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerOrganizationCamp);
         this.FBtn_Donate = this.FMC_Scene[CONST_ORGANIZATION.RESOURCE_Link_Btn_Donate];
         TGameUtil.setButtonMode(this.FBtn_Donate,true);
         this.FBtn_Donate.addEventListener(MouseEvent.CLICK,this.ProcessorOnBtnDonateClick);
         this.FGlowsFilter.SetParameters(this.FBtn_Donate,FFilterColor,FilterGlowWidth,FilterGlowStrength);
         this.UpdateUI();
      }
      
      public function LogicsPerform() : void
      {
         if(this.FInitialized && this.Visible)
         {
            this.UpdateDonateBtn();
         }
      }
      
      protected function UpdateUI() : void
      {
         this.FTF_Exploit.text = String(this.FExploitData);
         this.UpdateSkill();
         this.UpdateAddAttribute();
         this.UpdatePage();
         this.UpdateDonateBtn();
      }
      
      private function UpdateSkill() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < SKILL_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * SKILL_COUNT;
            if(_loc2_ < this.TechnologyData.length)
            {
               this.FMC_Skill[_loc1_].IsVisible = true;
               this.FMC_Skill[_loc1_].UpdateSkillInfo(this.FTechnologyData[_loc2_],this.FOrgBaseInfo);
            }
            else
            {
               this.FMC_Skill[_loc1_].IsVisible = false;
            }
            _loc1_++;
         }
      }
      
      private function UpdateAddAttribute() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < ADD_COUNT)
         {
            if(_loc1_ < this.TechnologyData.length)
            {
               if(this.GetSkillAddValue(this.TechnologyData[_loc1_]) > 0)
               {
                  this.FMC_Add[_loc2_].visible = true;
                  this.FMC_Add[_loc2_]["TF_Name"].text = FORMAT_SKILL_NAME[this.FTechnologyData[_loc1_].type - 1];
                  this.FMC_Add[_loc2_]["TF_AddValue"].text = "+" + this.GetSkillAddValue(this.FTechnologyData[_loc1_]);
                  _loc2_++;
               }
            }
            else
            {
               this.FMC_Add[_loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      private function UpdatePage() : void
      {
         this.FUIPage.Update();
      }
      
      protected function ResourcesPerform_UILocations() : void
      {
      }
      
      public function UpdateDonateBtn() : void
      {
         var _loc1_:TCharacter = SLogicsCore.Character;
         if(_loc1_.CheckCreditSilverCoinEnough(0))
         {
            this.FGlowsFilter.Run();
            this.FGlowsFilter.IsRunOver = false;
         }
         else
         {
            this.FGlowsFilter.Stop();
         }
      }
      
      protected function ProcessorOnBtnDonateClick(param1:MouseEvent) : void
      {
         if(this.FOnBtnDonateClick != null)
         {
            this.FOnBtnDonateClick();
         }
      }
      
      protected function ProcessorOnLearnSkill(param1:Object, param2:uint) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         _loc4_ = this.FCurPage * SKILL_COUNT + param2;
         _loc3_ = uint(this.FTechnologyData[_loc4_].type);
         if(this.FOnBtnLearnClick != null)
         {
            this.FOnBtnLearnClick(param1,_loc3_);
         }
      }
      
      protected function UIComponentsHintOnOver(param1:Object) : void
      {
         this.FOverlayerOrganizationCamp.Context = null;
         var _loc2_:uint = (param1 as TTechnologyItem).SkillLevel;
         var _loc3_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_OrganizationAddition);
         var _loc4_:TOrganizationAddition = _loc3_.GetDatebaseByIdentifier(CONST_ORGANIZATION.Organization_Addition_Base + _loc2_) as TOrganizationAddition;
         this.FOverlayerOrganizationCamp.Context = _loc4_;
         this.FOverlayerOrganizationCamp.SkillIndex = (param1 as TTechnologyItem).SkillIndex + this.FCurPage * SKILL_COUNT;
         this.FOverlayerOrganizationCamp.SkillLevel = (param1 as TTechnologyItem).SkillLevel;
         this.FOverlayerOrganizationCamp.Render(FUICore.MouseCoordinate);
         this.FOverlayerOrganizationCamp.Show();
      }
      
      protected function UIComponentsHintOnOut(param1:Object) : void
      {
         this.FOverlayerOrganizationCamp.Hide();
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateSkill();
      }
      
      public function get OnBtnDonateClick() : Function
      {
         return this.FOnBtnDonateClick;
      }
      
      public function set OnBtnDonateClick(param1:Function) : void
      {
         this.FOnBtnDonateClick = param1;
      }
      
      public function get OnBtnLearnClick() : Function
      {
         return this.FOnBtnLearnClick;
      }
      
      public function set OnBtnLearnClick(param1:Function) : void
      {
         this.FOnBtnLearnClick = param1;
      }
      
      public function get TechnologyData() : Vector.<Object>
      {
         return this.FTechnologyData;
      }
      
      public function set TechnologyData(param1:Vector.<Object>) : void
      {
         this.FTechnologyData = param1;
      }
      
      public function get ExploitData() : Number
      {
         return this.FExploitData;
      }
      
      public function set ExploitData(param1:Number) : void
      {
         this.FExploitData = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function GetSkillAddValue(param1:Object) : int
      {
         var _loc4_:int = 0;
         var _loc2_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_OrganizationAddition);
         var _loc3_:TOrganizationAddition = _loc2_.GetDatebaseByIdentifier(CONST_ORGANIZATION.Organization_Addition_Base + param1.level) as TOrganizationAddition;
         if(_loc3_ == null)
         {
            _loc3_ = _loc2_.GetDatebaseByIdentifier(CONST_ORGANIZATION.Organization_Addition_Base + _loc2_.Count - 1) as TOrganizationAddition;
         }
         switch(param1.type)
         {
            case PHYS_ATK_ADDITION:
               _loc4_ = int(_loc3_.AtkAddition);
               break;
            case PHYS_DEF_ADDITION:
               _loc4_ = int(_loc3_.PhysDefAddition);
               break;
            case MAG_DEF_ADDITION:
               _loc4_ = int(_loc3_.MagDefAddition);
               break;
            case LIFE_ADDITION:
               _loc4_ = int(_loc3_.LifeAddition);
               break;
            case SPEED_ADDITION:
               _loc4_ = int(_loc3_.SpeedAddition);
         }
         return _loc4_;
      }
      
      public function UpDateUI(param1:TBaseOrganization) : void
      {
         this.FOrgBaseInfo = param1;
         this.UpdateUI();
      }
   }
}

