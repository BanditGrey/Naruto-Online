package Processors.Game.Lobby.NijiaStar
{
   import Foundation.Common.THint;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TSevenHeroSoul;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.NijiaStar.TNijiaStar;
   import Logics.NijiaStar.TNijiaStars;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.NijiaStar.Components.TUIHeroHead;
   import Processors.Game.Lobby.NijiaStar.Components.TUIMainPoint;
   import Processors.Game.Lobby.NijiaStar.Components.TUISubPoint;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NIJIASTAR;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_OVERLAYERNIJIASTARMAINPOINT;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowNijiaStar extends TProcessorGame
   {
      
      protected const CAPACITY_KingSouls:uint = 8;
      
      protected const CAPACITY_HeroHead:uint = 5;
      
      protected const CAPACITY_NijiaStar:uint = 10;
      
      protected var FMC_NijiaStar:Sprite;
      
      protected var FMC_BaseCostInfo:Sprite;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FBTN_NijiaStarInherit:SimpleButton;
      
      protected var FBTN_GetKingSoul:SimpleButton;
      
      protected var FMC_HeroBox:Sprite;
      
      protected var FBTN_Left:MovieClip;
      
      protected var FBTN_Right:MovieClip;
      
      protected var FMC_Select:MovieClip;
      
      protected var FMC_KingSoulChart:Sprite;
      
      protected var FTF_Silver:TextField;
      
      protected var FTF_Gold:TextField;
      
      protected var FTF_GiftCertificate:TextField;
      
      protected var FKingSoulList:Vector.<MovieClip>;
      
      protected var FKingSoulVec:Vector.<MovieClip>;
      
      protected var FHeroHeadList:Vector.<TUIHeroHead>;
      
      protected var FMainPoints:Vector.<TUIMainPoint>;
      
      protected var FCurPage:int;
      
      protected var FTotalPage:int;
      
      protected var FHeros:THeros;
      
      protected var FHero:THero;
      
      protected var FHelpTips:THint;
      
      protected var FCharacter:TCharacter;
      
      protected var FSevenHeroSoul:TSevenHeroSoul;
      
      protected var FHint:THint;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      protected var FOnClose:Function;
      
      protected var FMainPointOnClick:Function;
      
      protected var FExchangeOnClick:Function;
      
      protected var FGetKingSoulOnClick:Function;
      
      protected var FUIComponentsOnOver:Function;
      
      protected var FUIComponentsOnOut:Function;
      
      protected var FUIHintOnOver:Function;
      
      protected var FUIHintOnOut:Function;
      
      public function TProcessorWindowNijiaStar(param1:TUIComponent)
      {
         super(param1);
         this.FKingSoulList = new Vector.<MovieClip>(this.CAPACITY_KingSouls);
         this.FKingSoulVec = new Vector.<MovieClip>(this.CAPACITY_KingSouls);
         this.FHeroHeadList = new Vector.<TUIHeroHead>(this.CAPACITY_HeroHead);
         this.FMainPoints = new Vector.<TUIMainPoint>(this.CAPACITY_NijiaStar);
         this.FHint = new THint();
         this.FHelpTips = new THint();
         this.FCharacter = SLogicsCore.Character;
         this.FHeros = this.FCharacter.Heros;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_NIJIASTAR.RESOURCESID_Swf_NjiaStar);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TUIHeroHead = null;
         var _loc5_:TUIMainPoint = null;
         var _loc6_:TUISubPoint = null;
         var _loc7_:TSevenHeroSoul = null;
         var _loc8_:TBins = null;
         var _loc9_:Boolean = false;
         _loc8_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SevenHeroSoul) as TBins;
         this.FMC_NijiaStar = TUtilityReflection.CreateDisplayObjectInstance(CONST_NIJIASTAR.RESOURCE_ClassName_MC_NjiaStar) as Sprite;
         addChild(this.FMC_NijiaStar);
         this.FMC_BaseCostInfo = this.FMC_NijiaStar[CONST_NIJIASTAR.RESOURCES_Link_MC_BaseCostInfo];
         this.FBTN_Close = this.FMC_BaseCostInfo[CONST_NIJIASTAR.RESOURCES_Link_MC_HelpClose][CONST_NIJIASTAR.RESOURCE_Link_BTN_Close];
         this.FBTN_Help = this.FMC_BaseCostInfo[CONST_NIJIASTAR.RESOURCES_Link_MC_HelpClose][CONST_NIJIASTAR.RESOURCE_Link_BTN_Help];
         this.FBTN_NijiaStarInherit = this.FMC_NijiaStar[CONST_NIJIASTAR.RESOURCES_Link_BTN_NijiaStarInherit];
         this.FBTN_GetKingSoul = this.FMC_NijiaStar[CONST_NIJIASTAR.RESOURCES_Link_BTN_GetKingSoul];
         this.FMC_HeroBox = this.FMC_NijiaStar[CONST_NIJIASTAR.RESOURCES_Link_MC_HeroBox];
         this.FBTN_Left = this.FMC_HeroBox[CONST_NIJIASTAR.RESOURCES_Link_BTN_Left];
         this.FBTN_Left.buttonMode = true;
         this.FBTN_Right = this.FMC_HeroBox[CONST_NIJIASTAR.RESOURCES_Link_BTN_Right];
         this.FBTN_Right.buttonMode = true;
         this.FMC_Select = this.FMC_HeroBox["MC_Select"];
         this.FMC_Select.mouseEnabled = false;
         this.FTF_Silver = this.FMC_BaseCostInfo[CONST_NIJIASTAR.RESOURCES_Link_TF_Silver];
         this.FTF_Gold = this.FMC_BaseCostInfo[CONST_NIJIASTAR.RESOURCES_Link_TF_Gold];
         this.FTF_GiftCertificate = this.FMC_BaseCostInfo[CONST_NIJIASTAR.RESOURCES_Link_TF_GiftCertificate];
         _loc2_ = this.CAPACITY_KingSouls;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_BaseCostInfo[CONST_NIJIASTAR.RESOURCES_Link_MC_KingSoul + _loc1_];
            this.FKingSoulList[_loc1_] = _loc3_;
            _loc3_ = this.FMC_BaseCostInfo[CONST_NIJIASTAR.RESOURCES_Link_MC_KingSoul + _loc1_]["MC_KingSoul"];
            this.FKingSoulVec[_loc1_] = _loc3_;
            _loc3_.gotoAndStop(_loc1_ + 1);
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_KingSouls;
         _loc1_ = 0;
         while(_loc1_ < _loc2_ - 1)
         {
            _loc7_ = _loc8_.GetDatebaseByIndex(_loc1_) as TSevenHeroSoul;
            this.FKingSoulList[_loc1_]["TF_KingSoul"].textColor = _loc7_.Color;
            _loc1_++;
         }
         _loc7_ = _loc8_.GetDatebaseByIndex(_loc2_ - 1) as TSevenHeroSoul;
         this.FKingSoulList[_loc2_ - 1]["TF_KingSoul"].textColor = _loc7_.Color;
         _loc2_ = this.CAPACITY_HeroHead;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = new TUIHeroHead(this);
            _loc4_.Resource = this.FMC_HeroBox[CONST_NIJIASTAR.RESOURCES_Link_MC_Hero + _loc1_];
            _loc4_.Tag = _loc1_;
            _loc4_.OnClick = this.ProcessorHeroHeadOnLcick;
            _loc4_.OnOut = this.ProcessorPointOnOut;
            _loc4_.OnOver = this.ProcessorPointOnOver;
            _loc4_.Init();
            this.FHeroHeadList[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FMC_KingSoulChart = this.FMC_NijiaStar[CONST_NIJIASTAR.RESOURCES_Link_MC_KingSoulChart];
         _loc2_ = this.CAPACITY_NijiaStar;
         if(!SLogicsCore.Character.GetConfigValueById(91000012))
         {
            _loc9_ = true;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = new TUIMainPoint(this);
            _loc5_.Resoures = this.FMC_KingSoulChart[CONST_NIJIASTAR.RESOURCES_Link_MC_MainPoint + _loc1_];
            _loc5_.Tag = _loc1_;
            _loc5_.OnClick = this.ProcessorPointOnClick;
            _loc5_.OnOut = this.ProcessorPointOnOut;
            _loc5_.OnOver = this.ProcessorPointOnOver;
            _loc5_.Init();
            this.FMainPoints[_loc1_] = _loc5_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 9)
         {
            _loc3_ = this.FMC_KingSoulChart["MC_" + _loc1_];
            _loc3_.mouseEnabled = false;
            _loc3_.mouseChildren = false;
            _loc1_++;
         }
         if(_loc9_)
         {
            _loc1_ = 0;
            while(_loc1_ < 3)
            {
               _loc2_ = _loc1_ + 6;
               _loc3_ = this.FMC_KingSoulChart["MC_" + _loc2_];
               _loc3_.visible = false;
               _loc2_ = _loc1_ + 7;
               this.FMainPoints[_loc2_].Resoures.visible = false;
               _loc1_++;
            }
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = this.CAPACITY_KingSouls;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FKingSoulVec[_loc1_];
            _loc3_.addEventListener(MouseEvent.MOUSE_MOVE,this.MCKingSoulOnOver,false,0,true);
            _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.MCKingSoulOnOut,false,0,true);
            _loc1_++;
         }
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.BTNCloseOnClick,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonHelpOnOver,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.FBTN_Left.addEventListener(MouseEvent.CLICK,this.OnLeft,false,0,true);
         this.FBTN_Right.addEventListener(MouseEvent.CLICK,this.OnRight,false,0,true);
         this.FBTN_NijiaStarInherit.addEventListener(MouseEvent.CLICK,this.BTNExchangeOnClick,false,0,true);
         this.FBTN_GetKingSoul.addEventListener(MouseEvent.CLICK,this.BTNGetKingSoulOnClick,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdatePage() : void
      {
         this.FBTN_Left.visible = Boolean(this.FCurPage != 1);
         this.FBTN_Right.visible = Boolean(this.FCurPage != this.FTotalPage);
      }
      
      protected function UpdateHeroHeadInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIHeroHead = null;
         var _loc4_:uint = 0;
         this.FHeros.Sort();
         _loc2_ = this.CAPACITY_HeroHead;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FHeroHeadList[_loc1_];
            _loc3_.Resource.visible = false;
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_HeroHead;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc1_ + (this.FCurPage - 1) * this.CAPACITY_HeroHead;
            if(_loc4_ >= this.FHeros.Count)
            {
               break;
            }
            _loc3_ = this.FHeroHeadList[_loc1_];
            _loc3_.Context = this.FHeros.GetHeroByIndex(_loc4_);
            _loc3_.Resource.visible = true;
            _loc1_++;
         }
      }
      
      protected function UpdateCostText() : void
      {
         this.FTF_Silver.text = this.FCharacter.CreditSilverCoin.ToNumber() + "";
         this.FTF_Gold.text = this.FCharacter.CreditGold.toString();
         this.FTF_GiftCertificate.text = this.FCharacter.CreditGiftCertificate.toString();
      }
      
      protected function UpdateHeroMainPoint() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TNijiaStar = null;
         var _loc4_:TNijiaStars = null;
         var _loc5_:TUIMainPoint = null;
         _loc4_ = this.FHero.NijiaStars;
         _loc2_ = uint(_loc4_.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc4_.GetNijiaStarByIndex(_loc1_);
            _loc5_ = this.FMainPoints[_loc1_];
            if(_loc5_.Resoures.visible)
            {
               _loc5_.Context = _loc3_;
               _loc5_.SetSubPointInfo();
            }
            _loc1_++;
         }
      }
      
      protected function SelectHero() : void
      {
         this.FMC_Select.x = 56;
         this.FHero = this.FHeros.GetHeroByIndex((this.FCurPage - 1) * this.CAPACITY_HeroHead);
      }
      
      protected function ProcessorPointOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TUIMainPoint = null;
         var _loc4_:TNijiaStar = null;
         if(param1 is TUIMainPoint)
         {
            _loc3_ = param1 as TUIMainPoint;
         }
         if(param2 is TNijiaStar)
         {
            _loc4_ = param2 as TNijiaStar;
            if(_loc4_.Identifier == -1)
            {
               return;
            }
         }
         if(this.FMainPointOnClick != null)
         {
            if(this.FMainPointOnClick != null)
            {
               this.FMainPointOnClick(this,param2,_loc3_,this.FHero);
            }
         }
      }
      
      protected function ProcessorPointOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TNijiaStar = null;
         if(param2 is TNijiaStar)
         {
            _loc3_ = param2 as TNijiaStar;
            if(_loc3_.Identifier != -1)
            {
               if(this.FUIComponentsOnOut != null)
               {
                  this.FUIComponentsOnOut(this,param2);
               }
            }
            else if(this.FUIHintOnOut != null)
            {
               this.FUIHintOnOut(this);
            }
         }
         else if(param2 is THero)
         {
            if(this.FUIComponentsOnOut != null)
            {
               this.FUIComponentsOnOut(this,param2);
            }
         }
      }
      
      protected function ProcessorPointOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TNijiaStar = null;
         if(param2 is TNijiaStar)
         {
            _loc3_ = param2 as TNijiaStar;
            if(_loc3_.Identifier != -1)
            {
               if(this.FUIComponentsOnOver != null)
               {
                  this.FUIComponentsOnOver(this,param2);
               }
            }
            else
            {
               this.FHint.Caption = TUtilityString.Format(STRING_OVERLAYERNIJIASTARMAINPOINT.FORMAT_WinAndOpen,_loc3_.HeroName);
               if(this.FUIHintOnOver != null)
               {
                  this.FUIHintOnOver(this,this.FHint);
               }
            }
         }
         else if(param2 is THero)
         {
            if(this.FUIComponentsOnOver != null)
            {
               this.FUIComponentsOnOver(this,param2);
            }
         }
      }
      
      protected function OnLeft(param1:MouseEvent = null) : void
      {
         --this.FCurPage;
         if(this.FCurPage < 1)
         {
            this.FCurPage = 1;
         }
         this.UpdatePage();
         this.SelectHero();
         this.UpdateHeroMainPoint();
         this.UpdateHeroHeadInfo();
      }
      
      protected function OnRight(param1:MouseEvent = null) : void
      {
         ++this.FCurPage;
         if(this.FCurPage > this.FTotalPage)
         {
            this.FCurPage = this.FTotalPage;
         }
         this.UpdatePage();
         this.SelectHero();
         this.UpdateHeroMainPoint();
         this.UpdateHeroHeadInfo();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_NijiaStar) as TSystemLanguage;
         this.FHelpTips.Content = _loc2_.Desc;
         if(this.FOnHelpTipsOver != null)
         {
            this.FOnHelpTipsOver(this,this.FHelpTips);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(this.FOnHelpTipsOut != null)
         {
            this.FOnHelpTipsOut(this);
         }
      }
      
      protected function BTNCloseOnClick(param1:MouseEvent) : void
      {
         if(this.FOnClose != null)
         {
            this.FOnClose(this);
         }
      }
      
      protected function MCKingSoulOnOut(param1:MouseEvent) : void
      {
         if(this.FUIComponentsOnOut != null)
         {
            this.FUIComponentsOnOut(this,this.FSevenHeroSoul);
         }
      }
      
      protected function MCKingSoulOnOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TSevenHeroSoul = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TBins = null;
         _loc5_ = param1.currentTarget as MovieClip;
         _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SevenHeroSoul) as TBins;
         _loc3_ = uint(_loc6_.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc6_.GetDatebaseByIndex(_loc2_) as TSevenHeroSoul;
            if(_loc4_.Identifier % 10 == _loc5_.currentFrame || _loc5_.currentFrame == _loc3_)
            {
               if(this.FUIComponentsOnOver != null)
               {
                  this.FSevenHeroSoul = _loc4_;
                  this.FUIComponentsOnOver(this,this.FSevenHeroSoul);
               }
            }
            _loc2_++;
         }
      }
      
      protected function ProcessorHeroHeadOnLcick(param1:Object, param2:Object) : void
      {
         var _loc3_:TUIHeroHead = null;
         _loc3_ = param1 as TUIHeroHead;
         this.FMC_Select.x = 56 + _loc3_.Tag * 92;
         this.FHero = param2 as THero;
         this.UpdateHeroMainPoint();
      }
      
      protected function BTNExchangeOnClick(param1:MouseEvent) : void
      {
         if(this.FExchangeOnClick != null)
         {
            this.FExchangeOnClick(this);
         }
      }
      
      protected function BTNGetKingSoulOnClick(param1:MouseEvent) : void
      {
         if(this.FGetKingSoulOnClick != null)
         {
            this.FGetKingSoulOnClick(this);
         }
      }
      
      public function get OnHelpTipsOver() : Function
      {
         return this.FOnHelpTipsOver;
      }
      
      public function set OnHelpTipsOver(param1:Function) : void
      {
         this.FOnHelpTipsOver = param1;
      }
      
      public function get OnHelpTipsOut() : Function
      {
         return this.FOnHelpTipsOut;
      }
      
      public function set OnHelpTipsOut(param1:Function) : void
      {
         this.FOnHelpTipsOut = param1;
      }
      
      public function get OnClose() : Function
      {
         return this.FOnClose;
      }
      
      public function set OnClose(param1:Function) : void
      {
         this.FOnClose = param1;
      }
      
      public function get MainPointOnClick() : Function
      {
         return this.FMainPointOnClick;
      }
      
      public function set MainPointOnClick(param1:Function) : void
      {
         this.FMainPointOnClick = param1;
      }
      
      public function get ExchangeOnClick() : Function
      {
         return this.FExchangeOnClick;
      }
      
      public function set ExchangeOnClick(param1:Function) : void
      {
         this.FExchangeOnClick = param1;
      }
      
      public function get GetKingSoulOnClick() : Function
      {
         return this.FGetKingSoulOnClick;
      }
      
      public function set GetKingSoulOnClick(param1:Function) : void
      {
         this.FGetKingSoulOnClick = param1;
      }
      
      public function get UIComponentsOnOver() : Function
      {
         return this.FUIComponentsOnOver;
      }
      
      public function set UIComponentsOnOver(param1:Function) : void
      {
         this.FUIComponentsOnOver = param1;
      }
      
      public function get UIComponentsOnOut() : Function
      {
         return this.FUIComponentsOnOut;
      }
      
      public function set UIComponentsOnOut(param1:Function) : void
      {
         this.FUIComponentsOnOut = param1;
      }
      
      public function get UIHintOnOver() : Function
      {
         return this.FUIHintOnOver;
      }
      
      public function set UIHintOnOver(param1:Function) : void
      {
         this.FUIHintOnOver = param1;
      }
      
      public function get UIHintOnOut() : Function
      {
         return this.FUIHintOnOut;
      }
      
      public function set UIHintOnOut(param1:Function) : void
      {
         this.FUIHintOnOut = param1;
      }
      
      public function UpdateUI() : void
      {
         this.FHeros.Sort();
         this.FCurPage = 1;
         this.FTotalPage = Math.ceil(this.FHeros.Count / this.CAPACITY_HeroHead);
         this.OnLeft();
         this.UpdateCostText();
         this.UpdateSoulCount();
      }
      
      public function UpdateSoulCount() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc2_ = this.CAPACITY_KingSouls;
         _loc1_ = 0;
         while(_loc1_ < _loc2_ - 1)
         {
            _loc3_ = this.FCharacter.GetKingSoulByIndex(_loc1_ + 1);
            this.FKingSoulList[_loc1_]["TF_KingSoul"].text = _loc3_.toString();
            _loc1_++;
         }
         this.FKingSoulList[_loc2_ - 1]["TF_KingSoul"].text = this.FCharacter.GetKingSoulByIndex(CONST_COMMON.KINGSOULINDEX_Common).toString();
      }
      
      public function UpdateUIMainPoint() : void
      {
         this.UpdateSoulCount();
         this.UpdateHeroMainPoint();
      }
   }
}

