package Processors.Game.Lobby.Slave
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Slave.TSlaveRank;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Slave.Component.TUISlaveRankItem;
   import Resources.Constants.CONST_COMMON;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowSlaveRank extends TProcessorLobbyWindow
   {
      
      protected var CAPACITY_ITEMS:uint = 10;
      
      protected var FMC_MainUI:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FTF_UserRank:TextField;
      
      protected var FUITab:TUITab;
      
      protected var FUIPage:TUIPage;
      
      protected var FUISlaveRankItems:Vector.<TUISlaveRankItem>;
      
      protected var FPageIndex:int;
      
      protected var FTabIndex:int = -1;
      
      protected var FSlaveRanks:Vector.<TSlaveRank>;
      
      protected var FSingleRank:uint;
      
      public var OnRankListReq:Function;
      
      public function TProcessorWindowSlaveRank(param1:TUIComponent)
      {
         super(param1);
         this.FUIPage = new TUIPage(this);
         this.FUITab = new TUITab(this);
         this.FUISlaveRankItems = new Vector.<TUISlaveRankItem>(this.CAPACITY_ITEMS);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TUISlaveRankItem = null;
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-this.x,-this.y,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_MainUI = TUtilityReflection.CreateDisplayObjectInstance("MC_SlaveRank") as MovieClip;
         addChild(this.FMC_MainUI);
         this.FTF_UserRank = this.FMC_MainUI["TF_UserRank"];
         this.FBtn_Close = this.FMC_MainUI["BTN_Close"];
         _loc3_ = this.FMC_MainUI["MC_Page"]["MC_PageLeft"];
         this.FUIPage.ButtonPrevious.Substrate = _loc3_;
         _loc3_ = this.FMC_MainUI["MC_Page"]["MC_PageRight"];
         this.FUIPage.ButtonNext.Substrate = _loc3_;
         _loc4_ = this.FMC_MainUI["MC_Page"]["TF_Page"];
         this.FUIPage.LabelPage = _loc4_;
         this.FUIPage.PageSize = this.CAPACITY_ITEMS;
         this.FUIPage.Init();
         this.FUITab.SetTabByIndex(this.FMC_MainUI["MC_Tab_0"],0);
         this.FUITab.SetTabByIndex(this.FMC_MainUI["MC_Tab_1"],1);
         this.FUITab.OnSwitch = this.OnTabSwitch;
         this.FUITab.Init();
         this.FUITab.TabIndex = 1;
         this.FUITab.SwithTagManual(0);
         _loc2_ = this.CAPACITY_ITEMS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = new TUISlaveRankItem(this);
            _loc5_ = this.FMC_MainUI["MC_SlaveRank_" + _loc1_] as MovieClip;
            _loc6_.Resource = _loc5_;
            _loc6_.Init();
            this.FUISlaveRankItems[_loc1_] = _loc6_;
            _loc1_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick,false,0,true);
         this.FUIPage.OnChangePage = this.PageOnChange;
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FPageIndex = 0;
         this.FUIPage.TotalQuantity = this.FSlaveRanks.length;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function UpdateFightingRank() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlaveRankItem = null;
         var _loc4_:TSlaveRank = null;
         _loc2_ = this.CAPACITY_ITEMS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUISlaveRankItems[_loc1_];
            _loc3_.Resource.visible = false;
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_ITEMS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FPageIndex * _loc2_ + _loc1_ >= this.FSlaveRanks.length)
            {
               return;
            }
            _loc4_ = this.FSlaveRanks[this.FPageIndex * _loc2_ + _loc1_];
            _loc3_ = this.FUISlaveRankItems[_loc1_];
            _loc3_.SetInfo(_loc4_);
            _loc3_.Resource.visible = true;
            _loc1_++;
         }
      }
      
      protected function UpdateTextInfo() : void
      {
         this.FTF_UserRank.text = this.FSingleRank > 0 ? this.FSingleRank.toString() : "1000+";
      }
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         this.Visible = false;
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
         this.UpdateFightingRank();
      }
      
      protected function OnTabSwitch(param1:int) : void
      {
         if(this.FTabIndex == param1)
         {
            return;
         }
         this.FTabIndex = param1;
         if(this.OnRankListReq != null)
         {
            this.OnRankListReq(param1);
         }
      }
      
      public function Init(param1:Vector.<TSlaveRank>, param2:uint) : void
      {
         this.FSlaveRanks = param1;
         this.FSingleRank = param2;
         this.UpdateTextInfo();
         this.UpdatePageInfo();
         this.UpdateFightingRank();
      }
   }
}

