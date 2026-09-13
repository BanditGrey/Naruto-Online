package Processors.Game.Lobby.ShinobidoPractise
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.FightingCapacity.TFightingCapacityRank;
   import Logics.FightingCapacity.TFightingCapacityRanks;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.ShinobidoPractise.Components.TFightingCapacityRankItem;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_SHINOBIDOPRACTISE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowFightingCapacityRank extends TProcessorLobbyWindow
   {
      
      protected var CAPACITY_ITEMS:uint = 10;
      
      protected var FMC_MainUI:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FTF_UserRank:TextField;
      
      protected var FTF_UserFightingCapacity:TextField;
      
      protected var FUIPage:TUIPage;
      
      protected var FFightingItems:Vector.<TFightingCapacityRankItem>;
      
      protected var FPageIndex:int;
      
      protected var FFightingCapacityRanks:TFightingCapacityRanks;
      
      protected var FSingleRank:uint;
      
      public function TProcessorWindowFightingCapacityRank(param1:TUIComponent)
      {
         super(param1);
         this.FUIPage = new TUIPage(this);
         this.FFightingItems = new Vector.<TFightingCapacityRankItem>(this.CAPACITY_ITEMS);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SHINOBIDOPRACTISE.RESOURCESID_Swf_ShinobidoPractise);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TFightingCapacityRankItem = null;
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-this.x,-this.y,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_MainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_SHINOBIDOPRACTISE.RESOURCE_ClassName_MC_FightingPowerRanks) as MovieClip;
         addChild(this.FMC_MainUI);
         this.FTF_UserRank = this.FMC_MainUI[CONST_SHINOBIDOPRACTISE.RESOURCE_Link_TF_UserRank];
         this.FTF_UserFightingCapacity = this.FMC_MainUI[CONST_SHINOBIDOPRACTISE.RESOURCE_Link_TF_UserFightingCapacity];
         this.FBtn_Close = this.FMC_MainUI[CONST_SHINOBIDOPRACTISE.RESOURCE_Link_BTN_Close];
         _loc3_ = this.FMC_MainUI[CONST_SHINOBIDOPRACTISE.RESOURCE_Link_MC_Page][CONST_SHINOBIDOPRACTISE.RESOURCE_Link_MC_PageLeft];
         this.FUIPage.ButtonPrevious.Substrate = _loc3_;
         _loc3_ = this.FMC_MainUI[CONST_SHINOBIDOPRACTISE.RESOURCE_Link_MC_Page][CONST_SHINOBIDOPRACTISE.RESOURCE_Link_MC_PageRight];
         this.FUIPage.ButtonNext.Substrate = _loc3_;
         _loc4_ = this.FMC_MainUI[CONST_SHINOBIDOPRACTISE.RESOURCE_Link_MC_Page][CONST_SHINOBIDOPRACTISE.RESOURCE_Link_TF_Page];
         this.FUIPage.LabelPage = _loc4_;
         this.FUIPage.PageSize = this.CAPACITY_ITEMS;
         this.FUIPage.Init();
         _loc2_ = this.CAPACITY_ITEMS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = new TFightingCapacityRankItem(this);
            _loc5_ = this.FMC_MainUI[CONST_SHINOBIDOPRACTISE.RESOURCE_Link_MC_FightingRank + _loc1_] as MovieClip;
            _loc6_.Resource = _loc5_;
            _loc6_.Init();
            this.FFightingItems[_loc1_] = _loc6_;
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
         this.FUIPage.TotalQuantity = this.FFightingCapacityRanks.Count;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function UpdateFightingRank() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TFightingCapacityRankItem = null;
         var _loc4_:TFightingCapacityRank = null;
         _loc2_ = this.CAPACITY_ITEMS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FFightingItems[_loc1_];
            _loc3_.Resource.visible = false;
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_ITEMS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FPageIndex * _loc2_ + _loc1_ >= this.FFightingCapacityRanks.Count)
            {
               return;
            }
            _loc4_ = this.FFightingCapacityRanks.GetFightingCapacityRankByIndex(this.FPageIndex * _loc2_ + _loc1_);
            _loc3_ = this.FFightingItems[_loc1_];
            _loc3_.SetInfo(_loc4_);
            _loc3_.Resource.visible = true;
            _loc1_++;
         }
      }
      
      protected function UpdateTextInfo() : void
      {
         this.FTF_UserRank.text = this.FSingleRank > 0 ? this.FSingleRank.toString() : "1000+";
         this.FTF_UserFightingCapacity.text = SLogicsCore.Character.GetFightingPowerPVE().ToString();
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
      
      public function Init(param1:TFightingCapacityRanks, param2:uint) : void
      {
         if(param1.Count == 0)
         {
            return;
         }
         this.FFightingCapacityRanks = param1;
         this.FSingleRank = param2;
         this.UpdateTextInfo();
         this.UpdatePageInfo();
         this.UpdateFightingRank();
      }
   }
}

