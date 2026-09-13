package Processors.Game.Lobby.GroupBattle.Window
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.GroupBattle.TGroupBattleData;
   import Logics.GroupBattle.TInviteShadow;
   import Logics.GroupBattle.TInviteShadows;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.GroupBattle.Component.TUIInvitePlayer;
   import Resources.Constants.CONST_GROUPBATTLE;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowInviteList extends TProcessorWindowTemplate
   {
      
      protected var CAPACITY_ITEMS:uint = 12;
      
      protected var FMC_WorldInvite:MovieClip;
      
      protected var FMC_ChangeListPage:Sprite;
      
      protected var FTUIInvitePlayers:Vector.<TUIInvitePlayer>;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FGroupBattleData:TGroupBattleData;
      
      protected var FInviteShadows:TInviteShadows;
      
      protected var FServerTime:int;
      
      protected var FInviteOnClick:Function;
      
      protected var FWorldInviteOnClick:Function;
      
      public function TProcessorWindowInviteList(param1:TUIComponent)
      {
         super(param1);
         this.FTUIInvitePlayers = new Vector.<TUIInvitePlayer>(this.CAPACITY_ITEMS);
         this.FUIPage = new TUIPage(this);
         this.FGroupBattleData = SLogicsCore.GroupBattleData;
         this.FInviteShadows = this.FGroupBattleData.InviteShadows;
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         super.LogicsPerform();
         _loc1_ = int(STimingCore.GetServerTime());
         if(this.FServerTime == 0)
         {
            return;
         }
         if(_loc1_ - this.FServerTime > 30)
         {
            TGameUtil.setButtonMode(this.FMC_WorldInvite,true);
            this.FMC_WorldInvite.mouseEnabled = true;
            this.FServerTime = 0;
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_WorldInvite,false);
            this.FMC_WorldInvite.mouseEnabled = false;
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_GROUPBATTLE.RESOURCESID_Swf_GroupBattle);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIInvitePlayer = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         TGameUtil.AddWindowMask(this);
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_GROUPBATTLE.RESOURCE_ClassName_MC_ShadowInviteList) as Sprite;
         UIDispatch();
         this.FMC_WorldInvite = FMainUI["MC_WorldInvite"];
         TGameUtil.setButtonMode(this.FMC_WorldInvite,true);
         _loc2_ = this.CAPACITY_ITEMS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUIInvitePlayer(this);
            _loc3_.Resource = FMainUI["MC_FriendInfo_" + _loc1_];
            _loc3_.InviteOnClick = this.ProcessorInviteOnClick;
            _loc3_.Init();
            this.FTUIInvitePlayers[_loc1_] = _loc3_;
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
         this.FUIPage.OnChangePage = this.PageOnChange;
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FUIPage.TotalQuantity = this.FInviteShadows.Count;
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
         var _loc3_:TUIInvitePlayer = null;
         var _loc4_:TInviteShadow = null;
         var _loc5_:int = 0;
         _loc2_ = this.CAPACITY_ITEMS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FTUIInvitePlayers[_loc1_];
            _loc5_ = _loc1_ + this.FPageIndex * this.CAPACITY_ITEMS;
            _loc4_ = this.FInviteShadows.GetInviteShadowByIndex(_loc5_);
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
         this.FServerTime = STimingCore.GetServerTime();
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
      
      public function Update() : void
      {
         this.UpdatePageInfo();
         this.UpdateUI();
      }
   }
}

