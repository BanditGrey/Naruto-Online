package Processors.Game.Lobby.TopTeam.Window
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.SLogicsCore;
   import Logics.TopTeam.TTopTeamRank;
   import Logics.TopTeam.TTopTeamRanks;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.CrossServerWar.Components.TUICrossServerIntegralRanking;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_TOPTEAM;
   import Resources.Strings.STRING_TOPTEAM;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowNinjaRank extends TProcessorLobbyWindow
   {
      
      protected const CAPACITY_Items:uint = 10;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FTF_SelfRank:TextField;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_FrontThree:Sprite;
      
      protected var FPageIndex:int;
      
      protected var FTopTeamRanks:TTopTeamRanks;
      
      protected var FSingleRank:uint;
      
      protected var FUIScoreRankings:Vector.<TUICrossServerIntegralRanking>;
      
      public function TProcessorWindowNinjaRank(param1:TUIComponent)
      {
         super(param1);
         this.FUIScoreRankings = new Vector.<TUICrossServerIntegralRanking>();
         this.FUIPage = new TUIPage(this);
         this.FTopTeamRanks = SLogicsCore.TopTeamData.TopTeamRanks;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TOPTEAM.RESOURCESID_Swf_TOPTEAM);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:Sprite = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TUICrossServerIntegralRanking = null;
         TGameUtil.AddWindowMask(this);
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance("MC_NinjaRank") as Sprite;
         addChild(_loc1_);
         _loc1_.x = CONST_COMMON.STAGE_Width - _loc1_.width >> 1;
         _loc1_.y = CONST_COMMON.STAGE_Height - _loc1_.height >> 1;
         this.FBTN_Close = _loc1_["BTN_Close"];
         this.FTF_SelfRank = _loc1_["TF_SelfRank"];
         _loc4_ = _loc1_["MC_ChangePage"]["MC_PageLeft"];
         this.FUIPage.ButtonPrevious.Substrate = _loc4_;
         _loc4_ = _loc1_["MC_ChangePage"]["MC_PageRight"];
         this.FUIPage.ButtonNext.Substrate = _loc4_;
         _loc5_ = _loc1_["MC_ChangePage"]["TF_Page"];
         this.FUIPage.LabelPage = _loc5_;
         this.FUIPage.PageSize = this.CAPACITY_Items;
         this.FUIPage.Init();
         _loc3_ = this.CAPACITY_Items;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc7_ = new TUICrossServerIntegralRanking(this);
            _loc6_ = _loc1_["MC_Hero_" + _loc2_] as MovieClip;
            _loc7_.Resource = _loc6_;
            _loc7_.Init();
            this.FUIScoreRankings[_loc2_] = _loc7_;
            _loc2_++;
         }
         this.FMC_FrontThree = _loc1_["MC_FrontThree"] as Sprite;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick,false,0,true);
         this.FUIPage.OnChangePage = this.PageOnChange;
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateUIRankings() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TTopTeamRank = null;
         var _loc4_:TUICrossServerIntegralRanking = null;
         if(this.FPageIndex > 0)
         {
            this.FMC_FrontThree.visible = false;
         }
         else
         {
            this.FMC_FrontThree.visible = true;
         }
         this.FTF_SelfRank.text = this.FSingleRank == 0 ? STRING_TOPTEAM.STRING_NotInRankings : this.FSingleRank.toString();
         _loc2_ = this.CAPACITY_Items;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FUIScoreRankings[_loc1_];
            _loc4_.Resource.visible = false;
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_Items;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FPageIndex * _loc2_ + _loc1_ >= this.FTopTeamRanks.Count)
            {
               return;
            }
            _loc3_ = this.FTopTeamRanks.GetTopTeamRankByIndex(this.FPageIndex * _loc2_ + _loc1_);
            _loc4_ = this.FUIScoreRankings[_loc1_];
            _loc4_.Context = _loc3_;
            _loc4_.SetInfo();
            _loc4_.Resource.visible = true;
            _loc1_++;
         }
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FPageIndex = 0;
         this.FUIPage.TotalQuantity = this.FTopTeamRanks.Count;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
         this.UpdateUIRankings();
      }
      
      public function UpdateRankings() : void
      {
         this.FSingleRank = SLogicsCore.TopTeamData.MyRank;
         this.UpdatePageInfo();
         this.UpdateUIRankings();
      }
   }
}

