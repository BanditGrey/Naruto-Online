package Processors.Game.Lobby.NarutoHelper.SecondaryWindow
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.UI.TUIComponent;
   import Logics.NarutoHelper.TNinjaLesson;
   import Logics.NarutoHelper.TNinjaLessons;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_NARUTOHELPER;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class TUINinjaLesson extends TUIComponent
   {
      
      protected var FMainUI:Sprite;
      
      protected var FTF_Explanation:TextField;
      
      protected var FUITab:TUITab;
      
      protected var FTabIndex:int;
      
      protected var FPageIndex:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FCurrentLessons:TNinjaLessons;
      
      public function TUINinjaLesson(param1:TUIComponent)
      {
         super(param1);
         this.FUITab = new TUITab(this);
         this.FUIPage = new TUIPage(this);
         this.FCurrentLessons = new TNinjaLessons();
      }
      
      protected function Perform_ResourceUIDispatch() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
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
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FTF_Explanation = this.FMainUI["TF_Explanation"];
         _loc4_ = this.FMainUI["MC_Page"];
         _loc4_ = this.FMainUI["MC_Page"];
         _loc5_ = _loc4_["MC_PageLeft"];
         this.FUIPage.ButtonPrevious.Substrate = _loc5_;
         _loc5_ = _loc4_["MC_PageRight"];
         this.FUIPage.ButtonNext.Substrate = _loc5_;
         _loc6_ = _loc4_["TF_Page"];
         this.FUIPage.LabelPage = _loc6_;
         this.FUIPage.PageSize = CONST_NARUTOHELPER.CAPACITY_TF_Level;
         this.FUIPage.Init();
      }
      
      protected function Perform_ResourceUILocation() : void
      {
         this.FUIPage.OnChangePage = this.PageOnChange;
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FUIPage.TotalQuantity = this.FCurrentLessons.Count;
         if(this.FUIPage.TotalQuantity == CONST_NARUTOHELPER.CAPACITY_TF_Level)
         {
            this.FPageIndex = 0;
         }
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function UpdateUITab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:TNinjaLessons = null;
         var _loc5_:TNinjaLesson = null;
         _loc4_ = this.FCurrentLessons;
         _loc2_ = CONST_NARUTOHELPER.CAPACITY_TF_Level;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc1_ + this.FPageIndex * _loc2_;
            if(_loc3_ >= _loc4_.Count)
            {
               this.FUITab.SetTabHideByIndex(_loc1_);
            }
            else
            {
               _loc5_ = _loc4_.GetNinjaLessonByIndex(_loc3_);
               this.FUITab.SetTabCaptionByIndex(_loc5_.Name,_loc1_);
               this.FUITab.SetTabShowByIndex(_loc1_);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateExplanationText() : void
      {
         var _loc1_:TNinjaLessons = null;
         var _loc2_:TNinjaLesson = null;
         _loc1_ = this.FCurrentLessons;
         _loc2_ = _loc1_.GetNinjaLessonByIndex(this.FTabIndex);
         this.FTF_Explanation.htmlText = _loc2_.Desc;
      }
      
      protected function CheckLessons() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TNinjaLesson = null;
         var _loc5_:TNinjaLessons = null;
         _loc3_ = uint(SLogicsCore.Character.GetMainLevel());
         _loc5_ = SLogicsCore.NarutoHelperData.NinjaLessons;
         this.FCurrentLessons.Clear();
         _loc2_ = uint(_loc5_.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc5_.GetNinjaLessonByIndex(_loc1_);
            if(_loc3_ >= _loc4_.Level)
            {
               this.FCurrentLessons.Add(_loc4_);
            }
            _loc1_++;
         }
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndex = param2 as int;
         this.UpdateUITab();
         this.FUITab.TabIndex = 1;
         this.FUITab.SwithTagManual(0);
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FTabIndex = param1 as int;
         this.FTabIndex += this.FPageIndex * CONST_NARUTOHELPER.CAPACITY_TF_Level;
         this.UpdateExplanationText();
      }
      
      public function ResourceUIDispatch(param1:Sprite) : void
      {
         this.FMainUI = param1;
         this.Perform_ResourceUIDispatch();
         this.Perform_ResourceUILocation();
      }
      
      public function Update() : void
      {
         this.CheckLessons();
         this.UpdatePageInfo();
         this.UpdateUITab();
         this.FUITab.TabIndex = 1;
         this.FUITab.SwithTagManual(0);
      }
   }
}

