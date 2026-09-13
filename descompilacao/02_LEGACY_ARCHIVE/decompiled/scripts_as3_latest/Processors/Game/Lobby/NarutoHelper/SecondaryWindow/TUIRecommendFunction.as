package Processors.Game.Lobby.NarutoHelper.SecondaryWindow
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TNinjiaRecommend;
   import Logics.NarutoHelper.TLevelRecommendNinja;
   import Logics.NarutoHelper.TLevelRecommendNinjas;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.NarutoHelper.Component.TUILevelRecommendHero;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_NARUTOHELPER;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_NARUTOHELPER;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextField;
   
   public class TUIRecommendFunction extends TProcessorGame
   {
      
      protected var FMainUI:Sprite;
      
      protected var FTF_Explanation:TextField;
      
      protected var FTF_HeroResource:TextField;
      
      protected var FMC_SlotLeft:MovieClip;
      
      protected var FMC_SlotRight:MovieClip;
      
      protected var FUIPage:TUIPage;
      
      protected var FUITab:TUITab;
      
      protected var FTabIndex:int;
      
      protected var FPageIndex:int;
      
      protected var FSlotIndex:int;
      
      protected var FSlotMaxPages:int;
      
      protected var FUIHeads:Vector.<TUILevelRecommendHero>;
      
      protected var FLevelRecommendNinja:TLevelRecommendNinja;
      
      protected var FCurrentLevelRecommendNinjas:TLevelRecommendNinjas;
      
      protected var FTextOnClick:Function;
      
      public function TUIRecommendFunction(param1:TUIComponent)
      {
         super(param1);
         this.FUITab = new TUITab(this);
         this.FUIPage = new TUIPage(this);
         this.FUIHeads = new Vector.<TUILevelRecommendHero>();
         this.FCurrentLevelRecommendNinjas = new TLevelRecommendNinjas();
      }
      
      protected function Perform_ResourceUIDispatch() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUILevelRecommendHero = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TextField = null;
         addChild(this.FMainUI);
         _loc3_ = CONST_NARUTOHELPER.CAPACITY_TF_Level;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = this.FMainUI["MC_Tab_" + _loc2_];
            this.FUITab.SetTabByIndex(_loc1_,_loc2_);
            this.FUITab.SetTabCaptionByIndex("",_loc2_);
            _loc2_++;
         }
         _loc3_ = CONST_NARUTOHELPER.CAPACITY_Heads;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FMainUI["MC_HeroHead_" + _loc2_];
            _loc5_ = new TUILevelRecommendHero(this);
            _loc5_.Resource = _loc4_;
            _loc5_.Tag = _loc2_;
            _loc5_.OnClick = this.ProcessorOnClick;
            _loc5_.Init();
            this.FUIHeads[_loc2_] = _loc5_;
            _loc2_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FMC_SlotLeft = this.FMainUI["MC_SlotLeft"];
         this.FMC_SlotRight = this.FMainUI["MC_SlotRight"];
         this.FTF_Explanation = this.FMainUI["TF_Explanation"];
         this.FTF_Explanation.text = "";
         this.FTF_HeroResource = this.FMainUI["TF_HeroResource"];
         this.FTF_HeroResource.text = "";
         _loc6_ = this.FMainUI["MC_Page"];
         _loc6_ = this.FMainUI["MC_Page"];
         _loc4_ = _loc6_["MC_PageLeft"];
         this.FUIPage.ButtonPrevious.Substrate = _loc4_;
         _loc4_ = _loc6_["MC_PageRight"];
         this.FUIPage.ButtonNext.Substrate = _loc4_;
         _loc7_ = _loc6_["TF_Page"];
         this.FUIPage.LabelPage = _loc7_;
         this.FUIPage.PageSize = CONST_NARUTOHELPER.CAPACITY_TF_Level;
         this.FUIPage.Init();
      }
      
      protected function Perform_ResourceUILocation() : void
      {
         this.FMC_SlotLeft.addEventListener(MouseEvent.CLICK,this.MCSlotLeftOnClick,false,0,true);
         this.FMC_SlotRight.addEventListener(MouseEvent.CLICK,this.MCSlotRightOnClick,false,0,true);
         this.FTF_HeroResource.addEventListener(TextEvent.LINK,this.TFHeroResourceOnClick,false,0,true);
         this.FUIPage.OnChangePage = this.PageOnChange;
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUILevelRecommendHero = null;
         super.LogicsPerform();
         if(!Visible)
         {
            return;
         }
         _loc2_ = CONST_NARUTOHELPER.CAPACITY_Heads;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIHeads[_loc1_];
            if(_loc3_ != null)
            {
               _loc3_.UpdateHead();
            }
            _loc1_++;
         }
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FUIPage.TotalQuantity = SLogicsCore.NarutoHelperData.LevelRecommendNinjas.Count;
         if(this.FUIPage.TotalQuantity == CONST_NARUTOHELPER.CAPACITY_TF_Level)
         {
            this.FPageIndex = 0;
         }
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function UpdateTabs() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TLevelRecommendNinjas = null;
         var _loc7_:TLevelRecommendNinja = null;
         _loc6_ = this.FCurrentLevelRecommendNinjas;
         _loc6_.Sort();
         _loc5_ = uint(SLogicsCore.Character.GetMainLevel());
         _loc2_ = int(CONST_NARUTOHELPER.CAPACITY_TF_Level);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc1_ + this.FPageIndex * _loc2_;
            if(_loc4_ >= _loc6_.Count)
            {
               this.FUITab.SetTabHideByIndex(_loc1_);
            }
            else
            {
               _loc7_ = _loc6_.GetLevelRecommendNinjaByIndex(_loc4_);
               this.FUITab.SetTabCaptionByIndex(TUtilityString.Format(STRING_NARUTOHELPER.FORMAT_Level,_loc7_.LevelRecommend),_loc1_);
               this.FUITab.SetTabShowByIndex(_loc1_);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateHeroHeadInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUILevelRecommendHero = null;
         var _loc4_:TNinjiaRecommend = null;
         var _loc5_:int = 0;
         _loc2_ = CONST_NARUTOHELPER.CAPACITY_Heads;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIHeads[_loc1_];
            _loc3_.HideSelect();
            _loc1_++;
         }
         this.FTF_Explanation.text = "";
         this.FTF_HeroResource.text = "";
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIHeads[_loc1_];
            _loc5_ = this.FSlotIndex + _loc1_;
            if(_loc5_ >= this.FLevelRecommendNinja.HeroInfos.Count)
            {
               _loc3_.Resource.visible = false;
            }
            else
            {
               _loc4_ = this.FLevelRecommendNinja.HeroInfos.GetHeroInfoByIndex(_loc5_);
               _loc3_.Context = _loc4_;
               _loc3_.Update();
               _loc3_.Resource.visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateExplanationText(param1:TNinjiaRecommend) : void
      {
         this.FTF_Explanation.htmlText = param1.Desc;
         this.FTF_HeroResource.htmlText = TUtilityString.Format(STRING_NARUTOHELPER.FORMAT_HeroResource,param1.Jump,param1.Page,param1.Source);
      }
      
      protected function CheckSlotPageUI() : void
      {
         this.FMC_SlotLeft.visible = this.FSlotIndex > 0;
         this.FMC_SlotRight.visible = this.FSlotIndex != this.FSlotMaxPages;
      }
      
      protected function CheckLevels() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TLevelRecommendNinja = null;
         var _loc4_:TLevelRecommendNinjas = null;
         var _loc5_:uint = 0;
         _loc5_ = uint(SLogicsCore.Character.GetMainLevel());
         _loc4_ = SLogicsCore.NarutoHelperData.LevelRecommendNinjas;
         this.FCurrentLevelRecommendNinjas.Clear();
         _loc2_ = uint(_loc4_.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc4_.GetLevelRecommendNinjaByIndex(_loc1_);
            if(_loc5_ >= _loc3_.LevelRecommend)
            {
               this.FCurrentLevelRecommendNinjas.Add(_loc3_);
            }
            _loc1_++;
         }
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndex = param2 as int;
         this.UpdateTabs();
         this.FUITab.TabIndex = 1;
         this.FUITab.SwithTagManual(0);
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         var _loc2_:TLevelRecommendNinja = null;
         this.FTabIndex = param1 as int;
         this.FTabIndex += this.FPageIndex * CONST_NARUTOHELPER.CAPACITY_TF_Level;
         this.Reset();
         this.FSlotIndex = 0;
         this.CheckSlotPageUI();
         if(this.FCurrentLevelRecommendNinjas.Count == 0)
         {
            return;
         }
         _loc2_ = this.FCurrentLevelRecommendNinjas.GetLevelRecommendNinjaByIndex(this.FTabIndex);
         this.FLevelRecommendNinja = _loc2_;
         this.FSlotMaxPages = _loc2_.HeroInfos.Count - 4;
         if(this.FSlotMaxPages < 0)
         {
            this.FSlotMaxPages = 0;
         }
         this.UpdateHeroHeadInfo();
      }
      
      protected function MCSlotLeftOnClick(param1:MouseEvent) : void
      {
         --this.FSlotIndex;
         if(this.FSlotIndex <= 0)
         {
            this.FSlotIndex = 0;
         }
         this.UpdateHeroHeadInfo();
         this.CheckSlotPageUI();
      }
      
      protected function MCSlotRightOnClick(param1:MouseEvent) : void
      {
         ++this.FSlotIndex;
         if(this.FSlotIndex >= this.FSlotMaxPages)
         {
            this.FSlotIndex = this.FSlotMaxPages;
         }
         this.UpdateHeroHeadInfo();
         this.CheckSlotPageUI();
      }
      
      protected function TFHeroResourceOnClick(param1:TextEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc2_ = param1.text;
         _loc3_ = 2;
         _loc4_ = parseInt(_loc2_.split("_")[0]);
         _loc5_ = parseInt(_loc2_.split("_")[1]);
         if(_loc4_ == CONST_SHORTCUTS.POSITION_Additional)
         {
            _loc3_ = CONST_SHORTCUTS.POSITION_Additional;
            _loc4_ = CONST_SHORTCUTS.TYPE_Additional_Tavern;
         }
         else if(_loc4_ == CONST_SHORTCUTS.POSITION_ActiveList)
         {
            _loc3_ = CONST_SHORTCUTS.POSITION_ActiveList;
            _loc4_ = CONST_SHORTCUTS.TYPE_ActiveList_FirstRecharge;
            return;
         }
         if(this.FTextOnClick != null)
         {
            this.FTextOnClick(this,_loc3_,_loc4_,_loc5_);
         }
      }
      
      protected function ProcessorOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TNinjiaRecommend = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:TUILevelRecommendHero = null;
         _loc7_ = param1 as TUILevelRecommendHero;
         _loc3_ = param2 as TNinjiaRecommend;
         _loc6_ = _loc7_.Tag;
         _loc5_ = CONST_NARUTOHELPER.CAPACITY_Heads;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = this.FUIHeads[_loc4_];
            if(_loc6_ != _loc4_)
            {
               _loc7_.HideSelect();
            }
            else
            {
               _loc7_.ShowSelect();
            }
            _loc4_++;
         }
         this.UpdateExplanationText(_loc3_);
      }
      
      public function set TextOnClick(param1:Function) : void
      {
         this.FTextOnClick = param1;
      }
      
      public function ResourceUIDispatch(param1:Sprite) : void
      {
         this.FMainUI = param1;
         this.Perform_ResourceUIDispatch();
         this.Perform_ResourceUILocation();
      }
      
      public function Update() : void
      {
         this.CheckLevels();
         this.UpdateTabs();
         this.UpdatePageInfo();
         this.FUITab.TabIndex = 1;
         this.FUITab.SwithTagManual(0);
      }
      
      public function Reset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = CONST_NARUTOHELPER.CAPACITY_Heads;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FUIHeads[_loc1_].Resource.visible = false;
            _loc1_++;
         }
         this.FTF_Explanation.text = "";
         this.FTF_HeroResource.text = "";
      }
   }
}

