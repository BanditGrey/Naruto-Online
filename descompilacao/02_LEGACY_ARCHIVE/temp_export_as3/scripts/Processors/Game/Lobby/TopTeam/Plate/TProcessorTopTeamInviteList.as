package Processors.Game.Lobby.TopTeam.Plate
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.GroupBattle.TInviteShadow;
   import Logics.GroupBattle.TInviteShadows;
   import Logics.SLogicsCore;
   import Logics.TopTeam.TTopTeamData;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.TopTeam.Component.TUITopTeamInvitePlayer;
   import Resources.Constants.CONST_TOPTEAM;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorTopTeamInviteList extends TProcessorWindowTemplate
   {
      
      protected var CAPACITY_ITEMS:uint = 12;
      
      protected var FMC_WorldInvite:MovieClip;
      
      protected var FMC_RapidInvite:MovieClip;
      
      protected var FMC_ChangeListPage:Sprite;
      
      protected var FUITopTeamInvitePlayers:Vector.<TUITopTeamInvitePlayer>;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FTopTeamData:TTopTeamData;
      
      protected var FInviteList:TInviteShadows;
      
      protected var FInviteOnClick:Function;
      
      protected var FWorldInviteOnClick:Function;
      
      protected var FRapidInviteOnClick:Function;
      
      public function TProcessorTopTeamInviteList(param1:TUIComponent)
      {
         super(param1);
         this.FUITopTeamInvitePlayers = new Vector.<TUITopTeamInvitePlayer>(this.CAPACITY_ITEMS);
         this.FUIPage = new TUIPage(this);
         this.FTopTeamData = SLogicsCore.TopTeamData;
         this.FInviteList = this.FTopTeamData.InviteList;
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(!Visible)
         {
            return;
         }
         _loc1_ = int(STimingCore.GetServerTime());
         if(_loc1_ - this.FTopTeamData.WorldInviteTime >= 0)
         {
            TGameUtil.setButtonMode(this.FMC_WorldInvite,true);
            this.FMC_WorldInvite.mouseEnabled = true;
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_WorldInvite,false);
            this.FMC_WorldInvite.mouseEnabled = false;
         }
         if(_loc1_ - this.FTopTeamData.RapidInviteTime >= 0)
         {
            TGameUtil.setButtonMode(this.FMC_RapidInvite,true);
            this.FMC_RapidInvite.mouseEnabled = true;
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_RapidInvite,false);
            this.FMC_RapidInvite.mouseEnabled = false;
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TOPTEAM.RESOURCESID_Swf_TOPTEAM);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUITopTeamInvitePlayer = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         TGameUtil.AddWindowMask(this);
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance("MC_ShadowList") as Sprite;
         UIDispatch();
         this.FMC_WorldInvite = FMainUI["MC_WorldInvite"];
         TGameUtil.setButtonMode(this.FMC_WorldInvite,true);
         this.FMC_RapidInvite = FMainUI["MC_RapidInvite"];
         TGameUtil.setButtonMode(this.FMC_RapidInvite,true);
         _loc2_ = this.CAPACITY_ITEMS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUITopTeamInvitePlayer(this);
            _loc3_.Resource = FMainUI["MC_FriendInfo_" + _loc1_];
            _loc3_.InviteOnClick = this.ProcessorInviteOnClick;
            _loc3_.Init();
            this.FUITopTeamInvitePlayers[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.FMC_ChangeListPage = FMainUI["MC_ChangeListPage"];
         _loc4_ = this.FMC_ChangeListPage["MC_PageLeft"];
         this.FUIPage.ButtonPrevious.Substrate = _loc4_;
         _loc4_ = this.FMC_ChangeListPage["MC_PageRight"];
         this.FUIPage.ButtonNext.Substrate = _loc4_;
         _loc5_ = this.FMC_ChangeListPage["TF_Page"];
         this.FUIPage.LabelPage = _loc5_;
         this.FUIPage.PageSize = this.CAPACITY_ITEMS;
         this.FUIPage.Init();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         UILocations();
         this.FMC_WorldInvite.addEventListener(MouseEvent.CLICK,this.MCWorldInviteOnClick,false,0,true);
         this.FMC_RapidInvite.addEventListener(MouseEvent.CLICK,this.MCRapidInviteOnClick,false,0,true);
         this.FUIPage.OnChangePage = this.PageOnChange;
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FUIPage.TotalQuantity = this.FInviteList.Count;
         if(this.FUIPage.TotalQuantity == this.CAPACITY_ITEMS)
         {
            this.FPageIndex = 0;
         }
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUITopTeamInvitePlayer = null;
         var _loc4_:TInviteShadow = null;
         var _loc5_:int = 0;
         _loc2_ = this.CAPACITY_ITEMS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUITopTeamInvitePlayers[_loc1_];
            _loc5_ = _loc1_ + this.FPageIndex * this.CAPACITY_ITEMS;
            _loc4_ = this.FInviteList.GetInviteShadowByIndex(_loc5_);
            _loc3_.Context = _loc4_;
            _loc3_.Update();
            _loc3_.Resource.visible = _loc4_ != null;
            _loc1_++;
         }
      }
      
      protected function ProcessorInviteOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TInviteShadow = null;
         _loc3_ = param2 as TInviteShadow;
         if(param2 == null)
         {
            return;
         }
         if(this.FInviteOnClick != null)
         {
            this.FInviteOnClick(this,_loc3_.Identifier0,_loc3_.Identifier1);
         }
      }
      
      protected function MCWorldInviteOnClick(param1:MouseEvent) : void
      {
         if(this.FWorldInviteOnClick != null)
         {
            this.FWorldInviteOnClick(this);
         }
      }
      
      protected function MCRapidInviteOnClick(param1:MouseEvent) : void
      {
         if(this.FRapidInviteOnClick != null)
         {
            this.FRapidInviteOnClick(this);
         }
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
         this.UpdateUI();
      }
      
      public function set InviteOnClick(param1:Function) : void
      {
         this.FInviteOnClick = param1;
      }
      
      public function set WorldInviteOnClick(param1:Function) : void
      {
         this.FWorldInviteOnClick = param1;
      }
      
      public function set RapidInviteOnClick(param1:Function) : void
      {
         this.FRapidInviteOnClick = param1;
      }
      
      public function Update() : void
      {
         this.UpdatePageInfo();
         this.UpdateUI();
      }
   }
}

