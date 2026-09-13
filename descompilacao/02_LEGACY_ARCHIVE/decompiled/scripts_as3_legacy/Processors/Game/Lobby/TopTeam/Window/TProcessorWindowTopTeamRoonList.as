package Processors.Game.Lobby.TopTeam.Window
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Logics.TopTeam.THallPlayer;
   import Logics.TopTeam.TTopTeamData;
   import Logics.TopTeam.TTopTeamRoom;
   import Logics.TopTeam.TTopTeamRooms;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.TopTeam.Component.TUIHallPlayer;
   import Processors.Game.Lobby.TopTeam.Component.TUITopTeamRoom;
   import Processors.Game.Windows.Input.TUIWindowInputPassword;
   import Processors.Game.Windows.Input.TUIWindowSeekRoom;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TOPTEAM;
   import Resources.Strings.STRING_TOPTEAM;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowTopTeamRoonList extends TProcessorWindowTemplate
   {
      
      protected var FMC_NinjaPointMall:MovieClip;
      
      protected var FMC_RapidJoin:MovieClip;
      
      protected var FMC_CreateTroops:MovieClip;
      
      protected var FMC_FindRoom:MovieClip;
      
      protected var FTF_RestPlayCount:TextField;
      
      protected var FMC_NinjaRank:MovieClip;
      
      protected var FUIWindowInputPassword:TUIWindowInputPassword;
      
      protected var FUIWindowSeekRoom:TUIWindowSeekRoom;
      
      protected var FUIRoomPage:TUIPage;
      
      protected var FUIPlayerPage:TUIPage;
      
      protected var FRoomPageIndex:int;
      
      protected var FPlayerPageIndex:int;
      
      protected var FUIRooms:Vector.<TUITopTeamRoom>;
      
      protected var FUIHallPlayers:Vector.<TUIHallPlayer>;
      
      protected var FTopTeamData:TTopTeamData;
      
      protected var FNinjaPointMallOnClick:Function;
      
      protected var FCreateRoomOnClick:Function;
      
      protected var FEnterRoomOnClick:Function;
      
      protected var FNinjaRankOnClick:Function;
      
      public function TProcessorWindowTopTeamRoonList(param1:TUIComponent)
      {
         super(param1);
         this.Init();
      }
      
      protected function Init() : void
      {
         this.FUIRooms = new Vector.<TUITopTeamRoom>();
         this.FUIHallPlayers = new Vector.<TUIHallPlayer>();
         this.FUIRoomPage = new TUIPage(this);
         this.FUIPlayerPage = new TUIPage(this);
         this.FTopTeamData = SLogicsCore.TopTeamData;
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
         var _loc3_:MovieClip = null;
         var _loc4_:TUITopTeamRoom = null;
         var _loc5_:TUIHallPlayer = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TextField = null;
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance("MC_NinjaRoomList") as Sprite;
         UIDispatch();
         this.FMC_NinjaPointMall = FMainUI["MC_NinjaPointMall"];
         TGameUtil.setButtonMode(this.FMC_NinjaPointMall,true);
         this.FMC_NinjaRank = FMainUI["MC_NinjaRank"];
         TGameUtil.setButtonMode(this.FMC_NinjaRank,true);
         this.FTF_RestPlayCount = FMainUI["TF_RestPlayCount"];
         _loc2_ = _loc2_ = CONST_TOPTEAM.CAPACITY_ROOMS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = FMainUI["MC_Room_" + _loc1_];
            _loc4_ = new TUITopTeamRoom(this);
            _loc4_.Resource = _loc3_;
            _loc4_.RoomUIOnClick = this.ProcessorRoomUIOnClick;
            _loc4_.Init();
            this.FUIRooms[_loc1_] = _loc4_;
            _loc1_++;
         }
         _loc2_ = CONST_TOPTEAM.CAPACITY_Players;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = FMainUI["MC_Player_" + _loc1_];
            _loc5_ = new TUIHallPlayer(this);
            _loc5_.Resource = _loc3_;
            _loc5_.Init();
            this.FUIHallPlayers[_loc1_] = _loc5_;
            _loc1_++;
         }
         this.FMC_RapidJoin = FMainUI["MC_RapidJoin"];
         TGameUtil.setButtonMode(this.FMC_RapidJoin,true);
         this.FMC_CreateTroops = FMainUI["MC_CreateTroops"];
         TGameUtil.setButtonMode(this.FMC_CreateTroops,true);
         this.FMC_FindRoom = FMainUI["MC_FindRoom"];
         TGameUtil.setButtonMode(this.FMC_FindRoom,true);
         _loc6_ = FMainUI["MC_ChangeListPage_0"];
         _loc3_ = _loc6_["MC_PageLeft"];
         this.FUIRoomPage.ButtonPrevious.Substrate = _loc3_;
         _loc3_ = _loc6_["MC_PageRight"];
         this.FUIRoomPage.ButtonNext.Substrate = _loc3_;
         _loc7_ = _loc6_["TF_Page"];
         this.FUIRoomPage.LabelPage = _loc7_;
         this.FUIRoomPage.PageSize = CONST_TOPTEAM.CAPACITY_ROOMS;
         this.FUIRoomPage.Init();
         _loc6_ = FMainUI["MC_ChangeListPage_1"];
         _loc3_ = _loc6_["MC_PageLeft"];
         this.FUIPlayerPage.ButtonPrevious.Substrate = _loc3_;
         _loc3_ = _loc6_["MC_PageRight"];
         this.FUIPlayerPage.ButtonNext.Substrate = _loc3_;
         _loc7_ = _loc6_["TF_Page"];
         this.FUIPlayerPage.LabelPage = _loc7_;
         this.FUIPlayerPage.PageSize = CONST_TOPTEAM.CAPACITY_Players;
         this.FUIPlayerPage.Init();
         this.FUIWindowInputPassword = new TUIWindowInputPassword(this);
         this.FUIWindowInputPassword.OnOK = this.UIWindowInputPasswordOnOk;
         TUtilityUIWindow.SetupWindowPassword(this.FUIWindowInputPassword);
         this.FUIWindowInputPassword.x = (STAGE_Width - this.FUIWindowInputPassword.WindowWidth) / 2;
         this.FUIWindowInputPassword.y = (STAGE_Height - this.FUIWindowInputPassword.WindowHeight) / 2;
         this.FUIWindowInputPassword.Visible = false;
         this.FUIWindowSeekRoom = new TUIWindowSeekRoom(this);
         this.FUIWindowSeekRoom.OnOK = this.UIWindowSeekRoomOnOk;
         TUtilityUIWindow.SetupWindowSeekRoom(this.FUIWindowSeekRoom);
         this.FUIWindowSeekRoom.x = (STAGE_Width - this.FUIWindowSeekRoom.WindowWidth) / 2;
         this.FUIWindowSeekRoom.y = (STAGE_Height - this.FUIWindowSeekRoom.WindowHeight) / 2;
         this.FUIWindowSeekRoom.Visible = false;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TSystemLanguage = null;
         UILocations();
         this.FMC_NinjaPointMall.addEventListener(MouseEvent.CLICK,this.MCNinjaPointMallOnClick,false,0,true);
         this.FMC_NinjaRank.addEventListener(MouseEvent.CLICK,this.MCNinjaRankOnClick,false,0,true);
         this.FMC_RapidJoin.addEventListener(MouseEvent.CLICK,this.MCRapidJoinOnClick,false,0,true);
         this.FMC_CreateTroops.addEventListener(MouseEvent.CLICK,this.MCCreateTroopsOnClick,false,0,true);
         this.FMC_FindRoom.addEventListener(MouseEvent.CLICK,this.MCFindRoomOnClick,false,0,true);
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_TopTeam) as TSystemLanguage;
         FHelpTips.Content = _loc1_.Desc;
         this.FUIRoomPage.OnChangePage = this.RoomPageOnChange;
         this.FUIPlayerPage.OnChangePage = this.PlayerPageOnChange;
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TSystemLanguage = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GroupBattle) as TSystemLanguage;
         FHelpTips.Content = _loc1_.Desc;
         super.ResourcesPerform_UIFinalize();
      }
      
      protected function UpdateUIRoom() : void
      {
         var _loc1_:TUITopTeamRoom = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TTopTeamRoom = null;
         var _loc5_:int = 0;
         _loc3_ = CONST_TOPTEAM.CAPACITY_ROOMS;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = this.FUIRooms[_loc2_];
            _loc1_.Resource.visible = false;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = this.FUIRooms[_loc2_];
            _loc5_ = _loc2_ + _loc3_ * this.FRoomPageIndex;
            _loc4_ = this.FTopTeamData.TopTeamRooms.GetTopTeamRoomByIndex(_loc5_);
            if(_loc4_ != null)
            {
               _loc1_.Context = _loc4_;
               _loc1_.Update();
               _loc1_.Resource.visible = true;
            }
            _loc2_++;
         }
      }
      
      protected function UpdateUIPlayer() : void
      {
         var _loc1_:TUIHallPlayer = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:THallPlayer = null;
         var _loc5_:int = 0;
         _loc3_ = CONST_TOPTEAM.CAPACITY_Players;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = this.FUIHallPlayers[_loc2_];
            _loc1_.Resource.visible = false;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = this.FUIHallPlayers[_loc2_];
            _loc5_ = _loc2_ + _loc3_ * this.FPlayerPageIndex;
            _loc4_ = this.FTopTeamData.HallPlayers.GetHallPlayerByIndex(_loc5_);
            if(_loc4_ != null)
            {
               _loc1_.Context = _loc4_;
               _loc1_.Update();
               _loc1_.Resource.visible = true;
            }
            _loc2_++;
         }
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FRoomPageIndex = 0;
         this.FUIRoomPage.TotalQuantity = this.FTopTeamData.TopTeamRooms.Count;
         this.FUIRoomPage.PageIndex = this.FRoomPageIndex;
         this.FUIRoomPage.Update();
         this.FPlayerPageIndex = 0;
         this.FUIPlayerPage.TotalQuantity = this.FTopTeamData.HallPlayers.Count;
         this.FUIPlayerPage.PageIndex = this.FPlayerPageIndex;
         this.FUIPlayerPage.Update();
      }
      
      protected function UpdateOtherInfo() : void
      {
         this.FTF_RestPlayCount.text = TUtilityString.Format(STRING_TOPTEAM.FORMAT_RestPlayCount,this.FTopTeamData.RestPlayCount);
      }
      
      protected function CheckConditions() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TTopTeamRoom = null;
         var _loc5_:TTopTeamRooms = null;
         var _loc6_:Vector.<uint> = null;
         _loc5_ = this.FTopTeamData.TopTeamRooms;
         _loc6_ = new Vector.<uint>();
         _loc3_ = _loc5_.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc5_.GetTopTeamRoomByIndex(_loc2_);
            if(_loc4_.RoomPlayerCount < 3 && !_loc4_.HasPassword)
            {
               _loc6_.push(_loc4_.RoomID);
            }
            _loc2_++;
         }
         if(_loc6_.length != 0)
         {
            return _loc6_[uint(_loc6_.length * Math.random())];
         }
         return 0;
      }
      
      protected function UpdateUI() : void
      {
         this.UpdatePageInfo();
         this.UpdateOtherInfo();
         this.UpdateUIRoom();
         this.UpdateUIPlayer();
      }
      
      protected function ProcessorRoomUIOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TTopTeamRoom = null;
         _loc3_ = param2 as TTopTeamRoom;
         if(_loc3_ != null)
         {
            if(_loc3_.HasPassword)
            {
               this.FUIWindowInputPassword.Context = _loc3_.RoomID;
               this.FUIWindowInputPassword.Visible = true;
            }
            else if(this.FEnterRoomOnClick != null)
            {
               this.FEnterRoomOnClick(this,_loc3_.RoomID);
            }
         }
      }
      
      protected function RoomPageOnChange(param1:Object, param2:int) : void
      {
         if(param2 == this.FRoomPageIndex)
         {
            return;
         }
         this.FRoomPageIndex = param2;
         this.UpdateUIRoom();
      }
      
      protected function PlayerPageOnChange(param1:Object, param2:int) : void
      {
         if(param2 == this.FPlayerPageIndex)
         {
            return;
         }
         this.FPlayerPageIndex = param2;
         this.UpdateUIPlayer();
      }
      
      protected function MCRapidJoinOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FTopTeamData.RestPlayCount <= 0)
         {
            FOnEffectText(STRING_TOPTEAM.STRING_PlayCountUseless);
            return;
         }
         _loc2_ = int(this.CheckConditions());
         if(_loc2_ == 0)
         {
            FOnEffectText(STRING_TOPTEAM.STRING_NoSuitRoom);
         }
         else if(this.FEnterRoomOnClick != null)
         {
            this.FEnterRoomOnClick(this,_loc2_);
         }
      }
      
      protected function MCCreateTroopsOnClick(param1:MouseEvent) : void
      {
         if(this.FCreateRoomOnClick != null)
         {
            this.FCreateRoomOnClick(this);
         }
      }
      
      protected function MCFindRoomOnClick(param1:MouseEvent) : void
      {
         this.FUIWindowSeekRoom.Visible = true;
      }
      
      protected function UIWindowSeekRoomOnOk(param1:Object) : void
      {
         if(this.FEnterRoomOnClick != null)
         {
            this.FEnterRoomOnClick(this,parseInt(this.FUIWindowSeekRoom.RoomID),this.FUIWindowSeekRoom.Password);
         }
      }
      
      protected function UIWindowInputPasswordOnOk(param1:Object, param2:Object) : void
      {
         var _loc3_:uint = 0;
         _loc3_ = param2 as uint;
         if(this.FEnterRoomOnClick != null)
         {
            this.FEnterRoomOnClick(this,_loc3_,this.FUIWindowInputPassword.Password);
         }
      }
      
      protected function MCNinjaRankOnClick(param1:MouseEvent) : void
      {
         if(this.FNinjaRankOnClick != null)
         {
            this.FNinjaRankOnClick(this);
         }
      }
      
      protected function MCNinjaPointMallOnClick(param1:MouseEvent) : void
      {
         if(this.FNinjaPointMallOnClick != null)
         {
            this.FNinjaPointMallOnClick(this);
         }
      }
      
      public function set NinjaPointMallOnClick(param1:Function) : void
      {
         this.FNinjaPointMallOnClick = param1;
      }
      
      public function set NinjaRankOnClick(param1:Function) : void
      {
         this.FNinjaRankOnClick = param1;
      }
      
      public function set CreateRoomOnClick(param1:Function) : void
      {
         this.FCreateRoomOnClick = param1;
      }
      
      public function set EnterRoomOnClick(param1:Function) : void
      {
         this.FEnterRoomOnClick = param1;
      }
      
      public function Update() : void
      {
         this.UpdateUI();
      }
   }
}

