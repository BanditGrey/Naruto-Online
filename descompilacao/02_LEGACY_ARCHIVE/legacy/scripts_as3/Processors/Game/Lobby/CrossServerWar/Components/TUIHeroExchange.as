package Processors.Game.Lobby.CrossServerWar.Components
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.CrossServerWar.TOrangeInventorySample;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.SLogicsCore;
   import Processors.Game.Battle.Character.TActive;
   import Processors.Game.Battle.Character.TPoolRole;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CROSSSERVERWAR;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_CROSSSERVERWAR;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIHeroExchange extends TProcessorGame
   {
      
      protected var FTF_Cost:TextField;
      
      protected var FBTN_Recruit:MovieClip;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_RequireLevel:TextField;
      
      protected var FActive:TActive;
      
      protected var FMC_Hero:Sprite;
      
      protected var FResource:MovieClip;
      
      protected var FOnRecruitClick:Function;
      
      protected var FContext:Object;
      
      public function TUIHeroExchange(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function UIDispatch() : void
      {
         this.FBTN_Recruit = this.FResource[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Recruit];
         TGameUtil.setButtonMode(this.FBTN_Recruit,true);
         this.FMC_Hero = this.FResource[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_Heros];
         this.FTF_Cost = this.FResource[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Cost];
         this.FTF_Name = this.FResource[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Name];
         this.FTF_RequireLevel = this.FResource["TF_RequireLevel"];
      }
      
      protected function UILocation() : void
      {
         this.FBTN_Recruit.addEventListener(MouseEvent.CLICK,this.BTNRecruitOnClick,false,0,true);
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TOrangeInventorySample = null;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:THeros = null;
         var _loc8_:THero = null;
         var _loc9_:TBaseHero = null;
         var _loc10_:Boolean = false;
         _loc7_ = SLogicsCore.Character.Heros;
         if(this.FContext is TOrangeInventorySample)
         {
            _loc2_ = this.FContext as TOrangeInventorySample;
            _loc1_ = uint(_loc2_.VipLevel);
            _loc3_ = _loc2_.ExchangeCount.toString();
            _loc4_ = _loc2_.TemplateID;
         }
         _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc4_) as TBaseHero;
         if(_loc1_ > SLogicsCore.Character.VipLevel)
         {
            this.FBTN_Recruit["TF_Exchange"].text = TUtilityString.Format(STRING_CROSSSERVERWAR.FORMAT_VipRecruit,_loc1_);
         }
         else
         {
            _loc10_ = _loc7_.GetHeroByInitilzationIdentifier(_loc4_) != null || SLogicsCore.NinjaHostelData.GetHerBaseById(_loc4_) != null;
            if(!_loc10_)
            {
               this.FBTN_Recruit["TF_Exchange"].text = STRING_CROSSSERVERWAR.FORMAT_CanRecruit;
               TGameUtil.setButtonMode(this.FBTN_Recruit,true);
               this.FBTN_Recruit.mouseEnabled = true;
            }
            else
            {
               this.FBTN_Recruit["TF_Exchange"].text = STRING_CROSSSERVERWAR.STRING_Recruited;
               TGameUtil.setButtonMode(this.FBTN_Recruit,false);
               this.FBTN_Recruit.mouseEnabled = false;
            }
         }
         this.FTF_RequireLevel.text = TUtilityString.Format(STRING_CROSSSERVERWAR.FORMAT_RecruitLevel,_loc9_.NeedLevel);
         this.FTF_Name.text = _loc9_.Name;
         this.FTF_Name.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[_loc9_.Quality];
         this.FTF_Cost.text = _loc3_;
         if(this.FActive == null)
         {
            this.FActive = TPoolRole.GetActive(this,_loc4_,CONST_MODULES.MODULE_CrossServerWar,true,false);
         }
         else
         {
            this.FActive.ResetActive(this,_loc4_,CONST_MODULES.MODULE_CrossServerWar,true,false);
         }
         this.FMC_Hero.addChild(this.FActive);
      }
      
      override protected function LogicsPerform() : void
      {
         if(!this.Parent.Visible)
         {
            return;
         }
         if(this.FActive != null)
         {
            this.FActive.UpdateActive();
         }
         super.LogicsPerform();
      }
      
      protected function BTNRecruitOnClick(param1:MouseEvent) : void
      {
         if(this.FOnRecruitClick != null)
         {
            this.FOnRecruitClick(this,this.FContext);
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
      
      public function get OnRecruitClick() : Function
      {
         return this.FOnRecruitClick;
      }
      
      public function set OnRecruitClick(param1:Function) : void
      {
         this.FOnRecruitClick = param1;
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
      
      public function Update() : void
      {
         if(this.FContext == null)
         {
            return;
         }
         this.UpdateUI();
      }
   }
}

