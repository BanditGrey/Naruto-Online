package Processors.Game.Lobby.Talent
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.THeroTalent;
   import Logics.DatebaseVO.VO.TRefreshTalent;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Talent.Component.TUITalentItem;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class TProcessorTalentPerview extends TProcessorLobbyWindow
   {
      
      protected static const PageSize:uint = 16;
      
      protected static const PaddingH:uint = 17;
      
      protected static const PaddingV:uint = 9;
      
      protected static const ColN:uint = 4;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FTalentItemList:Vector.<TUITalentItem>;
      
      protected var FPageIndex:int;
      
      protected var FRefreshTalentBins:TBins;
      
      protected var FCurRefreshTalent:TRefreshTalent;
      
      protected var FCurTalentItem:TUITalentItem;
      
      protected var FBTN_prev:MovieClip;
      
      protected var FBTN_next:MovieClip;
      
      protected var FUIPage:TUIPage;
      
      protected var FMCScene:MovieClip;
      
      protected var FBTN_Activate:MovieClip;
      
      protected var FUITab:TUITab;
      
      protected var FTabIndex:int;
      
      public var OnRefreshTalentForce:Function;
      
      public function TProcessorTalentPerview(param1:TUIComponent)
      {
         super(param1);
         this.FTalentItemList = new Vector.<TUITalentItem>();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMCScene = TUtilityReflection.CreateDisplayObjectInstance("MC_TalentPreview") as MovieClip;
         addChild(this.FMCScene);
         this.ConstructorRecruitItems();
         this.FUIPage = new TUIPage(this);
         this.FUIPage.ButtonNext.Substrate = this.FMCScene.BTN_Next;
         this.FUIPage.ButtonPrevious.Substrate = this.FMCScene.BTN_Prev;
         this.FUIPage.PageSize = PageSize;
         this.FUIPage.OnChangePage = this.OnChangePage;
         this.FUIPage.Init();
         this.FUITab = new TUITab(this);
         this.FUITab.SetTabByIndex(this.FMCScene["mc_tab_A"],0);
         this.FUITab.SetTabByIndex(this.FMCScene["mc_tab_S"],1);
         this.FUITab.SetTabByIndex(this.FMCScene["mc_tab_SR"],2);
         this.FUITab.SetTabByIndex(this.FMCScene["mc_tab_SSR"],3);
         this.FUITab.SetTabByIndex(this.FMCScene["mc_tab_UR"],4);
         this.FUITab.OnSwitch = this.OnTabSwitch;
         this.FUITab.Init();
         this.FBTN_Activate = this.FMCScene.BTN_Activate;
         TGameUtil.setButtonMode(this.FBTN_Activate,true);
         this.FBTN_Close = this.FMCScene.BTN_Close;
         this.FBTN_Help = this.FMCScene.BTN_Help;
         this.FRefreshTalentBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RefreshTalent);
         this.UpdateUI();
         this.FMCScene.x = FUICore.StageWidth - this.FMCScene.width >> 1;
         this.FMCScene.y = FUICore.StageHeight - this.FMCScene.height >> 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Activate.addEventListener(MouseEvent.CLICK,this.ProcessorOnActivate);
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.OnWindowClose);
         super.ResourcesPerform_UILocations();
      }
      
      public function UpdateUI() : void
      {
         this.OnChangePage(null,this.FPageIndex);
         this.UpdateCurrentRecruitInfo(this.FCurRefreshTalent,this.FCurTalentItem);
      }
      
      protected function ConstructorRecruitItems() : void
      {
         var _loc1_:TUITalentItem = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < PageSize)
         {
            _loc1_ = new TUITalentItem();
            this.FTalentItemList.push(_loc1_);
            this.FMCScene.mc_pos.addChild(_loc1_);
            _loc1_.OnItemSelect = this.UpdateCurrentRecruitInfo;
            _loc1_.x = (_loc1_.width + PaddingH) * (_loc2_ % ColN);
            _loc1_.y = (_loc1_.height + PaddingV) * int(_loc2_ / ColN);
            _loc2_++;
         }
      }
      
      protected function UpdateRecruitList(param1:Vector.<TRefreshTalent>) : void
      {
         var _loc2_:TUITalentItem = null;
         var _loc3_:int = 0;
         var _loc4_:TRefreshTalent = null;
         _loc3_ = 0;
         while(_loc3_ < PageSize)
         {
            _loc2_ = this.FTalentItemList[_loc3_];
            _loc4_ = param1[_loc3_];
            _loc2_.Update(_loc4_);
            if(!this.FCurRefreshTalent)
            {
               this.FCurRefreshTalent = _loc4_;
               this.FCurTalentItem = _loc2_;
            }
            _loc3_++;
         }
      }
      
      protected function GetRecruitsByTabIndex() : Vector.<TRefreshTalent>
      {
         var _loc1_:int = 0;
         var _loc2_:TRefreshTalent = null;
         var _loc3_:Vector.<TRefreshTalent> = null;
         var _loc4_:MovieClip = null;
         _loc3_ = new Vector.<TRefreshTalent>();
         _loc4_ = this.FUITab.GetTabByIndex(this.FTabIndex);
         _loc1_ = 0;
         while(_loc1_ < this.FRefreshTalentBins.Count)
         {
            _loc2_ = this.FRefreshTalentBins.GetDatebaseByIndex(_loc1_) as TRefreshTalent;
            if(_loc2_.Assess == _loc4_.name.split("_")[2])
            {
               _loc3_.push(_loc2_);
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      protected function GetRecruitsByPageIndex() : Vector.<TRefreshTalent>
      {
         var _loc1_:int = 0;
         var _loc2_:TRefreshTalent = null;
         var _loc3_:Vector.<TRefreshTalent> = null;
         var _loc4_:Vector.<TRefreshTalent> = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc3_ = new Vector.<TRefreshTalent>();
         _loc3_ = this.GetRecruitsByTabIndex();
         this.FUIPage.TotalQuantity = _loc3_.length;
         this.FUIPage.Update();
         _loc5_ = this.FPageIndex * PageSize;
         _loc6_ = (this.FPageIndex + 1) * PageSize;
         _loc4_ = new Vector.<TRefreshTalent>();
         _loc1_ = _loc5_;
         while(_loc1_ < _loc6_)
         {
            if(_loc1_ < _loc3_.length)
            {
               _loc2_ = _loc3_[_loc1_];
               _loc4_.push(_loc2_);
            }
            else
            {
               _loc4_.push(null);
            }
            _loc1_++;
         }
         return _loc4_;
      }
      
      protected function UpdateCurrentRecruitInfo(param1:TRefreshTalent, param2:TUITalentItem) : void
      {
         var _loc3_:Array = null;
         var _loc4_:TArticle = null;
         var _loc5_:THeroTalent = null;
         this.FCurRefreshTalent = param1;
         if(this.FCurRefreshTalent == null)
         {
            return;
         }
         if(this.FCurTalentItem)
         {
            this.FCurTalentItem.AddGlowFilter(false);
         }
         this.FCurTalentItem = param2;
         this.FCurTalentItem.AddGlowFilter();
         _loc3_ = param1.ActivateObj;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc3_[0]) as TArticle;
         this.FMCScene.TF_Consume.text = _loc4_.Name + "*" + _loc3_[1];
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroTalent,param1.Talent) as THeroTalent;
         this.FMCScene.TF_Desc.text = _loc5_.TalentDesc;
         this.FMCScene.TF_Name.text = param1.Name;
         this.FMCScene.MC_Assess.gotoAndStop(param1.Assess);
      }
      
      protected function OnTabSwitch(param1:int) : void
      {
         this.FTabIndex = param1;
         this.OnChangePage(null,0);
         this.FUIPage.Reset();
      }
      
      protected function OnChangePage(param1:Object, param2:int) : void
      {
         var _loc3_:Vector.<TRefreshTalent> = null;
         this.FPageIndex = param2;
         _loc3_ = this.GetRecruitsByPageIndex();
         this.UpdateRecruitList(_loc3_);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:TUITalentItem = null;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(!FIsResourcesLoadCompleted || !this.Visible)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < PageSize)
         {
            _loc1_ = this.FTalentItemList[_loc2_];
            _loc1_.LogicsPerform();
            _loc2_++;
         }
      }
      
      protected function ProcessorOnActivate(param1:MouseEvent) : void
      {
         if(this.OnRefreshTalentForce != null && Boolean(this.FCurRefreshTalent))
         {
            this.OnRefreshTalentForce(this.FCurRefreshTalent.Identifier);
         }
      }
      
      protected function OnWindowClose(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
   }
}

