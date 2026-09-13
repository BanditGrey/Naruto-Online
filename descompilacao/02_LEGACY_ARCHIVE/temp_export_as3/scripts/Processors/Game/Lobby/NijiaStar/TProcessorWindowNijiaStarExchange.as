package Processors.Game.Lobby.NijiaStar
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.NijiaStar.Components.TUIHeroHead;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NIJIASTAR;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_NIJIASTAR;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowNijiaStarExchange extends TProcessorLobbyWindow
   {
      
      protected const CAPACITY_HeroHead:uint = 6;
      
      protected var FMC_NijiaStarExchange:Sprite;
      
      protected var FMC_HeadFirst:TUIHeroHead;
      
      protected var FMC_HeadSecond:TUIHeroHead;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_NijiastarExchange:SimpleButton;
      
      protected var FTF_Name:TextField;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FHeroHeadList:Vector.<TUIHeroHead>;
      
      protected var FHeros:THeros;
      
      protected var FHero:THero;
      
      protected var FExchangeOnClick:Function;
      
      protected var FUIComponentsOnOut:Function;
      
      protected var FUIComponentsOnOver:Function;
      
      public function TProcessorWindowNijiaStarExchange(param1:TUIComponent)
      {
         super(param1);
         this.FUIPage = new TUIPage(this);
         this.FHeroHeadList = new Vector.<TUIHeroHead>(this.CAPACITY_HeroHead);
         this.FHeros = SLogicsCore.Character.Heros;
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
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_NijiaStarExchange = TUtilityReflection.CreateDisplayObjectInstance(CONST_NIJIASTAR.RESOURCE_ClassName_MC_NijiaStarExchange) as Sprite;
         addChild(this.FMC_NijiaStarExchange);
         this.FMC_NijiaStarExchange.x = (CONST_COMMON.STAGE_Width - this.FMC_NijiaStarExchange.width) / 2;
         this.FMC_NijiaStarExchange.y = (CONST_COMMON.STAGE_Height - this.FMC_NijiaStarExchange.height) / 2;
         this.FMC_HeadFirst = new TUIHeroHead(this);
         this.FMC_HeadFirst.Resource = this.FMC_NijiaStarExchange["MC_HeadFirst"];
         this.FMC_HeadFirst.OnClick = this.ProcessorLeftHeroHeadOnLcick;
         this.FMC_HeadFirst.OnOut = this.ProcessorHeroHeadOnOut;
         this.FMC_HeadFirst.OnOver = this.ProcessorHeroHeadOnOver;
         this.FMC_HeadFirst.Init();
         this.FMC_HeadSecond = new TUIHeroHead(this);
         this.FMC_HeadSecond.Resource = this.FMC_NijiaStarExchange["MC_HeadSecond"];
         this.FMC_HeadSecond.OnClick = this.ProcessorRightHeroHeadOnLcick;
         this.FMC_HeadSecond.OnOut = this.ProcessorHeroHeadOnOut;
         this.FMC_HeadSecond.OnOver = this.ProcessorHeroHeadOnOver;
         this.FMC_HeadSecond.Init();
         this.FBTN_Close = this.FMC_NijiaStarExchange[CONST_NIJIASTAR.RESOURCE_Link_BTN_Close];
         this.FBTN_NijiastarExchange = this.FMC_NijiaStarExchange["BTN_NijiaStarExchange"];
         _loc5_ = this.FMC_NijiaStarExchange[CONST_NIJIASTAR.RESOURCE_Link_MC_PageLeft];
         this.FUIPage.ButtonPrevious.Substrate = _loc5_;
         _loc5_ = this.FMC_NijiaStarExchange[CONST_NIJIASTAR.RESOURCE_Link_MC_PageRight];
         this.FUIPage.ButtonNext.Substrate = _loc5_;
         _loc6_ = this.FMC_NijiaStarExchange[CONST_NIJIASTAR.RESOURCE_Link_TF_Page];
         this.FUIPage.LabelPage = _loc6_;
         _loc6_.text = "0/0";
         this.FUIPage.PageSize = this.CAPACITY_HeroHead;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.PageOnChange;
         _loc2_ = this.CAPACITY_HeroHead;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = new TUIHeroHead(this);
            _loc4_.Resource = this.FMC_NijiaStarExchange[CONST_NIJIASTAR.RESOURCES_Link_MC_Hero + _loc1_];
            _loc4_.Tag = _loc1_;
            _loc4_.OnClick = this.ProcessorHeroHeadOnLcick;
            _loc4_.OnOut = this.ProcessorHeroHeadOnOut;
            _loc4_.OnOver = this.ProcessorHeroHeadOnOver;
            _loc4_.Init();
            this.FHeroHeadList[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FTF_Name = this.FMC_NijiaStarExchange["TF_Name"];
         this.FTF_Name.text = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.SEVENHERO_EXCHANGE_TEXT) as TSystemLanguage).Desc;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.BTNCloseOnClick,false,0,true);
         this.FBTN_NijiastarExchange.addEventListener(MouseEvent.CLICK,this.NijiastarExchangeOnClick,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FPageIndex = 0;
         this.FUIPage.TotalQuantity = this.FHeros.Count;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function UpdateHeroHead() : void
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
            _loc3_.Context = null;
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_HeroHead;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc1_ + this.FPageIndex * this.CAPACITY_HeroHead;
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
      
      protected function ProcessorHeroHeadOnLcick(param1:Object, param2:Object) : void
      {
         var _loc3_:THero = null;
         var _loc4_:THero = null;
         var _loc5_:THero = null;
         _loc4_ = this.FMC_HeadFirst.Context as THero;
         _loc5_ = this.FMC_HeadSecond.Context as THero;
         if(param2 is THero)
         {
            _loc3_ = param2 as THero;
         }
         if(_loc4_ == null)
         {
            if(_loc3_ != _loc5_)
            {
               this.FMC_HeadFirst.Context = _loc3_;
            }
            else
            {
               EffectGenerateText(STRING_NIJIASTAR.STRING_ExchangeDifferent);
            }
            return;
         }
         if(_loc4_.Identifier == _loc3_.Identifier)
         {
            EffectGenerateText(STRING_NIJIASTAR.STRING_ExchangeDifferent);
            return;
         }
         if(_loc3_ != _loc4_)
         {
            if(_loc3_ != _loc5_)
            {
               this.FMC_HeadSecond.Context = _loc3_;
            }
            else
            {
               EffectGenerateText(STRING_NIJIASTAR.STRING_ExchangeDifferent);
            }
         }
         else
         {
            EffectGenerateText(STRING_NIJIASTAR.STRING_ExchangeDifferent);
         }
      }
      
      protected function ProcessorLeftHeroHeadOnLcick(param1:Object, param2:Object) : void
      {
         if(param2 == null)
         {
            return;
         }
         this.FMC_HeadFirst.Context = null;
      }
      
      protected function ProcessorRightHeroHeadOnLcick(param1:Object, param2:Object) : void
      {
         if(param2 == null)
         {
            return;
         }
         this.FMC_HeadSecond.Context = null;
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndex = param2;
         this.UpdateHeroHead();
      }
      
      protected function BTNCloseOnClick(param1:MouseEvent) : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function NijiastarExchangeOnClick(param1:MouseEvent) : void
      {
         if(this.FExchangeOnClick != null)
         {
            this.FExchangeOnClick(this,this.FMC_HeadFirst.Context,this.FMC_HeadSecond.Context);
         }
      }
      
      protected function ProcessorHeroHeadOnOut(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsOnOut != null)
         {
            this.FUIComponentsOnOut(this,param2);
         }
      }
      
      protected function ProcessorHeroHeadOnOver(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsOnOver != null)
         {
            this.FUIComponentsOnOver(this,param2);
         }
      }
      
      public function get ExchangeOnClick() : Function
      {
         return this.FExchangeOnClick;
      }
      
      public function set ExchangeOnClick(param1:Function) : void
      {
         this.FExchangeOnClick = param1;
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
      
      public function Update() : void
      {
         this.FMC_HeadFirst.Context = null;
         this.FMC_HeadSecond.Context = null;
         this.UpdatePageInfo();
         this.UpdateHeroHead();
      }
   }
}

