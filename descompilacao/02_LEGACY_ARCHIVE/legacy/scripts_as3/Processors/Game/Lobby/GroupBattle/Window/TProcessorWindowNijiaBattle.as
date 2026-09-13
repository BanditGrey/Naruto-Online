package Processors.Game.Lobby.GroupBattle.Window
{
   import Components.Pages.TUIPage;
   import Components.Slots.TUISlot;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TLeagueMapPve;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.GroupBattle.TGroupBattleData;
   import Logics.GroupBattle.TGroupBattleLevel;
   import Logics.GroupBattle.TGroupBattleLevels;
   import Logics.GroupBattle.TGroupBattleRoom;
   import Logics.GroupBattle.TGroupBattleRooms;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.GroupBattle.Component.TUIBattleSelect;
   import Processors.Game.Lobby.GroupBattle.Component.TUIRoom;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Input.TUIWindowInputPassword;
   import Processors.Game.Windows.Input.TUIWindowSeekRoom;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_GROUPBATTLE;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_GROUPBATTLE;
   import Resources.Strings.STRING_OhtsutsukiKaguya;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowNijiaBattle extends TProcessorWindowTemplate
   {
      
      protected const CAPACITY_BATTLESELECT:uint = 5;
      
      protected const CAPACITY_SLOTS:uint = 4;
      
      protected const CAPACITY_ROOMS:uint = 6;
      
      protected const CAPACITY_BUTTONS:uint = 4;
      
      protected const LABEL_SELECT:uint = 1;
      
      protected const LABEL_UNSELECT:uint = 2;
      
      protected const LABEL_DISABLED:uint = 3;
      
      protected var FTF_BattleName:TextField;
      
      protected var FTF_RecommendLevel:TextField;
      
      protected var FTF_RecommendPopulation:TextField;
      
      protected var FTF_RestPlayCount:TextField;
      
      protected var FTF_AddCountTip:TextField;
      
      protected var FMC_Slots:Sprite;
      
      protected var FMC_RapidJoin:MovieClip;
      
      protected var FMC_CreateTroops:MovieClip;
      
      protected var FMC_FindRoom:MovieClip;
      
      protected var FMC_ShadowClone:MovieClip;
      
      protected var FMC_BattleUILeft:MovieClip;
      
      protected var FMC_BattleUIRight:MovieClip;
      
      protected var FMC_SlotLeft:MovieClip;
      
      protected var FMC_SlotRight:MovieClip;
      
      protected var FMC_ChangeListPage:Sprite;
      
      protected var FMC_Background:MovieClip;
      
      protected var FMC_Common:MovieClip;
      
      protected var FMC_Difficulty:MovieClip;
      
      protected var FMC_addTimes:MovieClip;
      
      protected var FMC_GoAccessoryPanel:MovieClip;
      
      protected var FUIBattleSelects:Vector.<TUIBattleSelect>;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FUIRooms:Vector.<TUIRoom>;
      
      protected var FUIButtons:Vector.<MovieClip>;
      
      protected var FUIPageRoom:TUIPage;
      
      protected var FPageRoomIndex:int;
      
      protected var FCurrentClickBattleUI:TUIBattleSelect;
      
      protected var FCurrentGroupBattleLevel:TGroupBattleLevel;
      
      protected var FBattleSelectIndex:int;
      
      protected var FBattleSelectMaxPages:uint;
      
      protected var FSlotIndex:int;
      
      protected var FSlotMaxPages:uint;
      
      protected var FProcessorWindowShadowInvite:TProcessorWindowShadowInvite;
      
      protected var FUIWindowInputPassword:TUIWindowInputPassword;
      
      protected var FUIWindowSeekRoom:TUIWindowSeekRoom;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowConfirmationSure:TUIWindowConfirmation = null;
      
      protected var FGroupBattleData:TGroupBattleData;
      
      protected var FFilterGroupBattleRooms:TGroupBattleRooms;
      
      protected var FFilterGroupBattleLevels:TGroupBattleLevels;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FHint:THint;
      
      protected var FChallengeMissionID:uint;
      
      protected var FBackGroundBitmap:Bitmap;
      
      protected var FBackGroundID:uint;
      
      protected var FSlotOnOver:Function;
      
      protected var FSlotOnOut:Function;
      
      protected var FCreateRoomOnClick:Function;
      
      protected var FEnterRoomOnClick:Function;
      
      protected var FUIHintOnOver:Function;
      
      protected var FUIHintOnOut:Function;
      
      protected var FUIHintOnMove:Function;
      
      protected var FGoAccessory:Function;
      
      public function TProcessorWindowNijiaBattle(param1:TUIComponent)
      {
         super(param1);
         this.InitParameter();
      }
      
      protected function InitParameter() : void
      {
         this.FUIBattleSelects = new Vector.<TUIBattleSelect>(this.CAPACITY_BATTLESELECT);
         this.FUISlots = new Vector.<TUISlot>(this.CAPACITY_SLOTS);
         this.FUIRooms = new Vector.<TUIRoom>(this.CAPACITY_ROOMS);
         this.FUIButtons = new Vector.<MovieClip>();
         this.FUIPageRoom = new TUIPage(this);
         this.FFilterGroupBattleRooms = new TGroupBattleRooms();
         this.FFilterGroupBattleLevels = new TGroupBattleLevels();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FHint = new THint();
         this.FBackGroundBitmap = new Bitmap();
         this.FGroupBattleData = SLogicsCore.GroupBattleData;
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
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         var _loc5_:TUIBattleSelect = null;
         var _loc6_:TUISlot = null;
         var _loc7_:TUIRoom = null;
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_GROUPBATTLE.RESOURCE_ClassName_MC_NjiaStar) as Sprite;
         UIDispatch();
         this.FTF_BattleName = FMainUI["TF_BattleName"];
         this.FTF_RecommendLevel = FMainUI["TF_RecommendLevel"];
         this.FTF_RecommendPopulation = FMainUI["TF_RecommendPopulation"];
         this.FTF_RestPlayCount = FMainUI["TF_RestPlayCount"];
         this.FTF_AddCountTip = FMainUI["TF_AddCountTip"];
         this.FMC_Slots = FMainUI["MC_Slots"];
         this.FMC_RapidJoin = FMainUI["MC_RapidJoin"];
         this.FMC_CreateTroops = FMainUI["MC_CreateTroops"];
         this.FMC_FindRoom = FMainUI["MC_FindRoom"];
         this.FMC_ShadowClone = FMainUI["MC_ShadowClone"];
         this.FMC_ChangeListPage = FMainUI["MC_ChangeListPage"];
         this.FMC_Background = FMainUI["MC_Background"];
         this.FMC_Background.addChild(this.FBackGroundBitmap);
         this.FMC_Common = FMainUI["MC_Common"];
         this.FMC_Difficulty = FMainUI["MC_Difficulty"];
         this.FMC_addTimes = FMainUI["MC_addTimes"];
         this.FMC_GoAccessoryPanel = FMainUI["MC_GoAccessoryPanel"];
         if(this.FMC_GoAccessoryPanel)
         {
            TGameUtil.setButtonMode(this.FMC_GoAccessoryPanel,true);
         }
         this.FMC_Common.mouseEnabled = false;
         this.FUIButtons.push(this.FMC_RapidJoin);
         this.FUIButtons.push(this.FMC_CreateTroops);
         this.FUIButtons.push(this.FMC_FindRoom);
         this.FUIButtons.push(this.FMC_ShadowClone);
         this.FMC_BattleUILeft = FMainUI["MC_BattleUILeft"];
         TGameUtil.setButtonMode(this.FMC_BattleUILeft,true);
         this.FMC_BattleUIRight = FMainUI["MC_BattleUIRight"];
         TGameUtil.setButtonMode(this.FMC_BattleUIRight,true);
         this.FMC_SlotLeft = this.FMC_Slots["MC_SlotLeft"];
         TGameUtil.setButtonMode(this.FMC_SlotLeft,true);
         this.FMC_SlotRight = this.FMC_Slots["MC_SlotRight"];
         TGameUtil.setButtonMode(this.FMC_SlotRight,true);
         _loc3_ = this.FMC_ChangeListPage["MC_PageLeft"];
         this.FUIPageRoom.ButtonPrevious.Substrate = _loc3_;
         _loc3_ = this.FMC_ChangeListPage["MC_PageRight"];
         this.FUIPageRoom.ButtonNext.Substrate = _loc3_;
         _loc4_ = this.FMC_ChangeListPage["TF_Page"];
         this.FUIPageRoom.LabelPage = _loc4_;
         this.FUIPageRoom.PageSize = this.CAPACITY_ROOMS;
         this.FUIPageRoom.Init();
         _loc2_ = this.CAPACITY_BUTTONS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIButtons[_loc1_];
            TGameUtil.setButtonMode(_loc3_,true);
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_BATTLESELECT;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = new TUIBattleSelect(this);
            _loc5_.Tag = 0;
            _loc5_.Resource = FMainUI["MC_BattleUI_" + _loc1_] as MovieClip;
            _loc5_.BattleUIOnClick = this.ProcessorBattleUIOnClick;
            _loc5_.Init();
            this.FUIBattleSelects[_loc1_] = _loc5_;
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_SLOTS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = new TUISlot(this);
            _loc6_.Resource = this.FMC_Slots["MC_Slot_" + _loc1_] as MovieClip;
            _loc6_.Resource.visible = false;
            _loc6_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc6_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc6_.OnOverlay = this.SlotsOnOver;
            _loc6_.OnOut = this.SlotsOnOut;
            _loc6_.Init();
            this.FUISlots[_loc1_] = _loc6_;
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_ROOMS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc7_ = new TUIRoom(this);
            _loc7_.Resource = FMainUI["MC_Room_" + _loc1_];
            _loc7_.RoomUIOnClick = this.ProcessorRoomUIOnClick;
            _loc7_.Init();
            this.FUIRooms[_loc1_] = _loc7_;
            _loc1_++;
         }
         this.Reset();
         this.FProcessorWindowShadowInvite = new TProcessorWindowShadowInvite(this);
         this.FProcessorWindowShadowInvite.PermitOrganizationOnClick = this.ProcessorPermitOrganizationOnClick;
         this.FProcessorWindowShadowInvite.PermitFriendInviteOnClick = this.ProcessorPermitFriendInviteOnClick;
         this.FProcessorWindowShadowInvite.OnEffectText = this.ProcessorOnEffectText;
         this.FProcessorWindowShadowInvite.Init(FMainUI["MC_ShadowInvite"]);
         this.FProcessorWindowShadowInvite.Visible = false;
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
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.visible = false;
         this.FUIWindowConfirmationSure = new TUIWindowConfirmation(this);
         this.FUIWindowConfirmationSure.OnOK = this.WindowConfirmationSureOnOK;
         this.FUIWindowConfirmationSure.x = (FUICore.StageWidth - this.FUIWindowConfirmationSure.WindowWidth) / 2;
         this.FUIWindowConfirmationSure.y = (FUICore.StageHeight - this.FUIWindowConfirmationSure.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationSure);
         this.FUIWindowConfirmationSure.visible = false;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.UILocations();
         this.FMC_RapidJoin.addEventListener(MouseEvent.CLICK,this.MCRapidJoinOnClick,false,0,true);
         this.FMC_CreateTroops.addEventListener(MouseEvent.CLICK,this.MCCreateTroopsOnClick,false,0,true);
         this.FMC_FindRoom.addEventListener(MouseEvent.CLICK,this.MCFindRoomOnClick,false,0,true);
         this.FMC_ShadowClone.addEventListener(MouseEvent.CLICK,this.MCShadowCloneOnClick,false,0,true);
         this.FMC_Common.addEventListener(MouseEvent.CLICK,this.MCCommonOnClick,false,0,true);
         this.FMC_Difficulty.addEventListener(MouseEvent.CLICK,this.MCDifficultyOnClick,false,0,true);
         this.FMC_Difficulty.addEventListener(MouseEvent.ROLL_OVER,this.MCDifficultyOnOver,false,0,true);
         this.FMC_Difficulty.addEventListener(MouseEvent.ROLL_OUT,this.MCDifficultyOnOut,false,0,true);
         this.FMC_Difficulty.addEventListener(MouseEvent.MOUSE_MOVE,this.MoveClick,false,0,true);
         this.FMC_BattleUILeft.addEventListener(MouseEvent.CLICK,this.MCBattleUILeftOnClick,false,0,true);
         this.FMC_BattleUIRight.addEventListener(MouseEvent.CLICK,this.MCBattleUIRightOnClick,false,0,true);
         this.FMC_SlotLeft.addEventListener(MouseEvent.CLICK,this.MCSlotLeftOnClick,false,0,true);
         this.FMC_SlotRight.addEventListener(MouseEvent.CLICK,this.MCSlotRightOnClick,false,0,true);
         this.FMC_addTimes.addEventListener(MouseEvent.CLICK,this.addTimesClick);
         this.FMC_addTimes.addEventListener(MouseEvent.MOUSE_OVER,this.OverClick);
         this.FMC_addTimes.addEventListener(MouseEvent.MOUSE_OUT,this.OutClick);
         this.FMC_addTimes.addEventListener(MouseEvent.MOUSE_MOVE,this.MoveClick);
         if(this.FMC_GoAccessoryPanel)
         {
            this.FMC_GoAccessoryPanel.addEventListener(MouseEvent.CLICK,this.FMC_GoAccessoryPanelClick);
         }
         this.FUIPageRoom.OnChangePage = this.RoomPageOnChange;
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TSystemLanguage = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GroupBattle) as TSystemLanguage;
         FHelpTips.Content = _loc1_.Desc;
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         if(!Visible)
         {
            return;
         }
         super.LogicsPerform();
         _loc2_ = this.CAPACITY_SLOTS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUISlots[_loc1_];
            _loc3_.Update();
            _loc1_++;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBackGroundBitmap,CONST_MODULES.MODULE_GroupBattle,this.FBackGroundID);
      }
      
      protected function UpdateUIRoom() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIRoom = null;
         var _loc4_:int = 0;
         var _loc5_:TGroupBattleRoom = null;
         var _loc6_:TGroupBattleRooms = null;
         _loc6_ = this.FGroupBattleData.GroupBattleRooms;
         this.FFilterGroupBattleRooms.Clear();
         _loc2_ = _loc6_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = _loc6_.GetGroupBattleRoomByIndex(_loc1_);
            if(this.CheckGroupBattleRoom(_loc5_))
            {
               this.FFilterGroupBattleRooms.Add(_loc5_);
            }
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_ROOMS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIRooms[_loc1_];
            _loc4_ = _loc1_ + this.CAPACITY_ROOMS * this.FPageRoomIndex;
            if(_loc4_ < this.FFilterGroupBattleRooms.Count)
            {
               _loc5_ = this.FFilterGroupBattleRooms.GetGroupBattleRoomByIndex(_loc4_);
            }
            else
            {
               _loc5_ = null;
            }
            _loc3_.Context = _loc5_;
            _loc3_.Update();
            _loc3_.Resource.visible = _loc5_ != null;
            _loc1_++;
         }
      }
      
      protected function CheckGroupBattleRoom(param1:TGroupBattleRoom) : Boolean
      {
         if(param1.RoomStatus)
         {
            return false;
         }
         if(param1.RoomPlayerCount == 3)
         {
            return false;
         }
         return true;
      }
      
      protected function UpdateUIBattleSelect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TGroupBattleLevel = null;
         var _loc4_:TUIBattleSelect = null;
         var _loc5_:int = 0;
         this.FFilterGroupBattleLevels.Clear();
         this.CreateFilterGroupBattleLevels();
         _loc2_ = this.CAPACITY_BATTLESELECT;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FUIBattleSelects[_loc1_];
            _loc5_ = _loc1_ + this.CAPACITY_BATTLESELECT * this.FBattleSelectIndex;
            _loc3_ = this.FFilterGroupBattleLevels.GetGroupBattleLevelByIndex(_loc5_);
            _loc4_.Context = _loc3_;
            _loc4_.Update();
            _loc4_.Resource.visible = _loc3_ != null;
            _loc1_++;
         }
      }
      
      protected function CreateFilterGroupBattleLevels() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TGroupBattleLevel = null;
         var _loc4_:TGroupBattleLevels = null;
         _loc4_ = this.FGroupBattleData.GroupBattleLevels;
         _loc2_ = _loc4_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc4_.GetGroupBattleLevelByIndex(_loc1_);
            if(_loc3_.IsServerData || !_loc3_.IsOpenLevel)
            {
               if(this.FFilterGroupBattleLevels.Count == 0)
               {
                  this.FFilterGroupBattleLevels.Add(_loc3_);
               }
               else if(this.CheckGroupBattleLevel(_loc3_))
               {
                  this.FFilterGroupBattleLevels.Add(_loc3_);
               }
            }
            _loc1_++;
         }
      }
      
      protected function CheckGroupBattleLevel(param1:TGroupBattleLevel) : Boolean
      {
         var _loc2_:TGroupBattleLevel = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         _loc4_ = this.FFilterGroupBattleLevels.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = this.FFilterGroupBattleLevels.GetGroupBattleLevelByIndex(_loc3_);
            if(uint(param1.LevelID / 10) == uint(_loc2_.LevelID / 10))
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      protected function UpdateRewardSlots() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         var _loc6_:TLeagueMapPve = null;
         var _loc7_:uint = 0;
         var _loc8_:TGroupBattleLevel = null;
         var _loc9_:TInventories = null;
         if(this.FCurrentGroupBattleLevel == null)
         {
            return;
         }
         if(this.FMC_Common.currentFrame == 1 && this.FCurrentGroupBattleLevel.PreLevel != 0)
         {
            _loc7_ = this.FCurrentGroupBattleLevel.PreLevel;
            _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_LeagueMapPve,_loc7_) as TLeagueMapPve;
            _loc8_ = new TGroupBattleLevel();
            _loc8_.AwardInventories.Clear();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_.AwardInventories,_loc6_.RewardsVect);
            _loc9_ = _loc8_.AwardInventories;
         }
         else
         {
            _loc9_ = this.FCurrentGroupBattleLevel.AwardInventories;
         }
         _loc2_ = this.CAPACITY_SLOTS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUISlots[_loc1_];
            _loc4_ = _loc1_ + this.FSlotIndex;
            if(_loc4_ >= _loc9_.Count)
            {
               _loc5_ = null;
            }
            else
            {
               _loc5_ = _loc9_.GetInventoryByIndex(_loc4_);
            }
            _loc3_.Context = _loc5_;
            _loc3_.Resource.visible = _loc5_ != null;
            _loc1_++;
         }
      }
      
      protected function UpdateOtherInfo() : void
      {
         this.FTF_RestPlayCount.text = TUtilityString.Format(STRING_GROUPBATTLE.FORMAT_RestPlayCount,this.FGroupBattleData.PVETimes);
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FUIPageRoom.TotalQuantity = this.FFilterGroupBattleRooms.Count;
         if(this.FUIPageRoom.TotalQuantity == this.CAPACITY_ROOMS)
         {
            this.FPageRoomIndex = 0;
         }
         this.FUIPageRoom.PageIndex = this.FPageRoomIndex;
         this.FUIPageRoom.Update();
      }
      
      protected function UpdateDifficultyDetailInfo() : void
      {
         var _loc1_:TLeagueMapPve = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(this.FMC_Common.currentFrame == 1 && this.FCurrentGroupBattleLevel.PreLevel != 0)
         {
            _loc3_ = this.FCurrentGroupBattleLevel.PreLevel;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_LeagueMapPve,_loc3_) as TLeagueMapPve;
            _loc2_ = _loc1_.Recommendlevel;
            _loc4_ = _loc1_.BigImage;
         }
         else
         {
            _loc2_ = this.FCurrentGroupBattleLevel.RecommendLevel;
            _loc3_ = this.FCurrentGroupBattleLevel.LevelID;
            _loc4_ = this.FCurrentGroupBattleLevel.BigImage;
         }
         this.FChallengeMissionID = _loc3_;
         this.FBackGroundID = _loc4_;
         this.FTF_BattleName.text = this.FCurrentGroupBattleLevel.LevelName;
         this.FTF_RecommendLevel.text = TUtilityString.Format(STRING_GROUPBATTLE.FORMAT_RecommendLevel,_loc2_);
      }
      
      protected function UpdateBattleDetailInfo() : void
      {
         if(this.FCurrentGroupBattleLevel != null)
         {
            if(this.FCurrentGroupBattleLevel.IsOpenLevel)
            {
               if(this.FCurrentGroupBattleLevel.PreLevel != 0)
               {
                  this.MCDifficultyOnClick(null);
                  this.FMC_Difficulty.mouseEnabled = true;
                  this.FMC_Common.mouseEnabled = true;
               }
               else
               {
                  this.FMC_Difficulty.gotoAndStop(this.LABEL_DISABLED);
                  this.FMC_Common.gotoAndStop(this.LABEL_SELECT);
                  this.FMC_Common.mouseEnabled = false;
               }
            }
            else
            {
               this.FMC_Common.mouseEnabled = false;
               this.FMC_Common.gotoAndStop(this.LABEL_DISABLED);
               this.FMC_Difficulty.gotoAndStop(this.LABEL_DISABLED);
            }
         }
         this.FTF_RecommendPopulation.text = STRING_GROUPBATTLE.STRING_RecommendPopulation;
      }
      
      protected function CheckConditions() : uint
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TGroupBattleRoom = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TGroupBattleLevel = null;
         var _loc7_:TGroupBattleLevels = null;
         _loc7_ = this.FGroupBattleData.GroupBattleLevels;
         this.FFilterGroupBattleRooms.Sort();
         _loc2_ = this.FFilterGroupBattleRooms.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FFilterGroupBattleRooms.GetGroupBattleRoomByIndex(_loc1_);
            _loc5_ = _loc7_.Count;
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc6_ = _loc7_.GetGroupBattleLevelByIndex(_loc4_);
               if(_loc3_.MissionID == _loc6_.LevelID && _loc6_.IsServerData && _loc6_.IsOpenLevel && !_loc3_.HasPassword)
               {
                  return _loc3_.RoomID;
               }
               _loc4_++;
            }
            _loc1_++;
         }
         return 0;
      }
      
      protected function CheckSlotPageUI() : void
      {
         this.FMC_SlotLeft.visible = this.FSlotIndex > 0;
         this.FMC_SlotRight.visible = this.FSlotIndex != this.FSlotMaxPages;
      }
      
      override protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         super.ButtonCloseOnClick(param1);
         this.FProcessorWindowShadowInvite.Visible = false;
      }
      
      protected function WindowConfirmationOnOK(param1:Object) : void
      {
      }
      
      protected function WindowConfirmationSureOnOK(param1:Object) : void
      {
         SLogicsCore.KaguyaData.C_S_RenJie();
      }
      
      protected function UIWindowSeekRoomOnOk(param1:Object) : void
      {
         if(this.FEnterRoomOnClick != null)
         {
            this.FEnterRoomOnClick(this,1,parseInt(this.FUIWindowSeekRoom.RoomID),0,this.FUIWindowSeekRoom.Password);
         }
      }
      
      protected function UIWindowInputPasswordOnOk(param1:Object, param2:Object) : void
      {
         var _loc3_:uint = 0;
         _loc3_ = param2 as uint;
         if(this.FEnterRoomOnClick != null)
         {
            this.FEnterRoomOnClick(this,1,_loc3_,0,this.FUIWindowInputPassword.Password);
         }
      }
      
      protected function ProcessorBattleUIOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TGroupBattleLevel = null;
         var _loc4_:TUIBattleSelect = null;
         _loc4_ = param1 as TUIBattleSelect;
         _loc3_ = param2 as TGroupBattleLevel;
         if(_loc3_ == null || !_loc3_.IsServerData)
         {
            return;
         }
         this.FCurrentGroupBattleLevel = _loc3_;
         this.UpdateBattleDetailInfo();
         if(this.FCurrentClickBattleUI != null)
         {
            this.FCurrentClickBattleUI.ShowSelectBox = false;
         }
         this.FCurrentClickBattleUI = _loc4_;
         this.FCurrentClickBattleUI.ShowSelectBox = true;
         this.UpdateDifficultyDetailInfo();
         this.FSlotMaxPages = this.FCurrentGroupBattleLevel.AwardInventories.Count - 4;
         this.FSlotIndex = 0;
         this.CheckSlotPageUI();
         this.UpdateRewardSlots();
      }
      
      protected function ProcessorRoomUIOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TGroupBattleRoom = null;
         _loc3_ = param2 as TGroupBattleRoom;
         if(_loc3_ != null)
         {
            if(_loc3_.HasPassword)
            {
               this.FUIWindowInputPassword.Context = _loc3_.RoomID;
               this.FUIWindowInputPassword.Visible = true;
            }
            else if(this.FEnterRoomOnClick != null)
            {
               this.FEnterRoomOnClick(this,1,_loc3_.RoomID,0);
            }
         }
      }
      
      protected function RoomPageOnChange(param1:Object, param2:int) : void
      {
         if(param2 == this.FPageRoomIndex)
         {
            return;
         }
         this.FPageRoomIndex = param2;
         this.UpdateUIRoom();
      }
      
      protected function MCRapidJoinOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FGroupBattleData.PVETimes <= 0)
         {
            FOnEffectText(STRING_GROUPBATTLE.STRING_PlayCountUseless);
            return;
         }
         _loc2_ = int(this.CheckConditions());
         if(_loc2_ == 0)
         {
            FOnEffectText(STRING_GROUPBATTLE.STRING_NoSuitRoom);
         }
         else if(this.FEnterRoomOnClick != null)
         {
            this.FEnterRoomOnClick(this,1,_loc2_,1);
         }
      }
      
      protected function MCCreateTroopsOnClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!this.FCurrentGroupBattleLevel.IsOpenLevel)
         {
            FOnEffectText(STRING_GROUPBATTLE.STRING_BattleLocked);
            return;
         }
         if(this.FGroupBattleData.PVETimes <= 0)
         {
            FOnEffectText(STRING_GROUPBATTLE.STRING_PlayCountUseless);
            return;
         }
         if(this.FCreateRoomOnClick != null)
         {
            this.FCreateRoomOnClick(this,1,this.FChallengeMissionID);
         }
      }
      
      protected function MCFindRoomOnClick(param1:MouseEvent) : void
      {
         this.FUIWindowSeekRoom.Visible = true;
      }
      
      protected function MCShadowCloneOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_FriendList_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function MCCommonOnClick(param1:MouseEvent) : void
      {
         this.FMC_Common.gotoAndStop(this.LABEL_SELECT);
         this.FMC_Difficulty.gotoAndStop(this.LABEL_UNSELECT);
         this.UpdateDifficultyDetailInfo();
         this.UpdateRewardSlots();
      }
      
      protected function MCDifficultyOnClick(param1:MouseEvent) : void
      {
         if(!this.FCurrentGroupBattleLevel.IsOpenLevel)
         {
            return;
         }
         if(this.FCurrentGroupBattleLevel.PreLevel == 0)
         {
            return;
         }
         this.FMC_Difficulty.gotoAndStop(this.LABEL_SELECT);
         this.FMC_Common.gotoAndStop(this.LABEL_UNSELECT);
         this.UpdateDifficultyDetailInfo();
         this.UpdateRewardSlots();
      }
      
      protected function MCDifficultyOnOver(param1:MouseEvent) : void
      {
         if(!this.FCurrentGroupBattleLevel.IsOpenLevel)
         {
            return;
         }
         if(this.FCurrentGroupBattleLevel.PreLevel == 0)
         {
            this.FHint.Caption = STRING_GROUPBATTLE.STRING_OpenDifficulty;
            if(this.FUIHintOnOver != null)
            {
               this.FUIHintOnOver(this,this.FHint);
            }
         }
      }
      
      protected function OverClick(param1:MouseEvent) : void
      {
         this.FHint.Caption = TUtilityString.Format(STRING_OhtsutsukiKaguya.Smithy_Dec_5,SLogicsCore.KaguyaData.CurLevel,SLogicsCore.KaguyaData.Type_Count_Vector[4]);
         if(this.FUIHintOnOver != null)
         {
            this.FUIHintOnOver(this,this.FHint);
         }
      }
      
      protected function MoveClick(param1:MouseEvent) : void
      {
         if(this.FUIHintOnMove != null)
         {
            this.FUIHintOnMove(this);
         }
      }
      
      protected function OutClick(param1:MouseEvent) : void
      {
         if(this.FUIHintOnOut != null)
         {
            this.FUIHintOnOut(this);
         }
      }
      
      protected function MCDifficultyOnOut(param1:MouseEvent) : void
      {
         if(this.FUIHintOnOut != null)
         {
            this.FUIHintOnOut(this);
         }
      }
      
      protected function MCBattleUILeftOnClick(param1:MouseEvent) : void
      {
         --this.FBattleSelectIndex;
         if(this.FBattleSelectIndex <= 0)
         {
            this.FBattleSelectIndex = 0;
         }
         this.UpdateUIBattleSelect();
      }
      
      protected function MCBattleUIRightOnClick(param1:MouseEvent) : void
      {
         ++this.FBattleSelectIndex;
         if(this.FBattleSelectIndex >= this.FBattleSelectMaxPages)
         {
            this.FBattleSelectIndex = this.FBattleSelectMaxPages;
         }
         this.UpdateUIBattleSelect();
      }
      
      protected function MCSlotLeftOnClick(param1:MouseEvent) : void
      {
         --this.FSlotIndex;
         if(this.FSlotIndex <= 0)
         {
            this.FSlotIndex = 0;
         }
         this.UpdateRewardSlots();
         this.CheckSlotPageUI();
      }
      
      protected function MCSlotRightOnClick(param1:MouseEvent) : void
      {
         ++this.FSlotIndex;
         if(this.FSlotIndex >= this.FSlotMaxPages)
         {
            this.FSlotIndex = this.FSlotMaxPages;
         }
         this.UpdateRewardSlots();
         this.CheckSlotPageUI();
      }
      
      protected function addTimesClick(param1:MouseEvent) : void
      {
         var _loc2_:Vector.<uint> = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.FMC_addTimes.buttonMode)
         {
            _loc2_ = SLogicsCore.KaguyaData.NiJiBuyCounGold;
            _loc3_ = int(SLogicsCore.KaguyaData.GetValueByTypeCopy(4));
            _loc4_ = _loc3_ - SLogicsCore.KaguyaData.Type_Count_Vector[4];
            this.FUIWindowConfirmationSure.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_NinJiaBuyCount).DescribeString,SLogicsCore.KaguyaData.NiJiBuyCounGold[_loc4_]);
            this.FUIWindowConfirmationSure.Visible = true;
         }
      }
      
      protected function FMC_GoAccessoryPanelClick(param1:MouseEvent) : void
      {
         if(this.FGoAccessory != null)
         {
            this.FGoAccessory();
         }
      }
      
      public function UpdateFreeCount() : void
      {
         if(SLogicsCore.KaguyaData.OpenLevel == 0 || SLogicsCore.KaguyaData.IsLongTime == 7)
         {
            this.FMC_addTimes.visible = false;
         }
         else
         {
            this.FMC_addTimes.visible = true;
         }
         if(SLogicsCore.KaguyaData.Type_Count_Vector[4] == 0)
         {
            TGameUtil.setButtonMode(this.FMC_addTimes,false);
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_addTimes,true);
         }
         this.UpdateOtherInfo();
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_GroupBattle);
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(this.FSlotOnOver != null)
         {
            this.FSlotOnOver(param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.FSlotOnOut != null)
         {
            this.FSlotOnOut(param2);
         }
      }
      
      protected function ProcessorPermitOrganizationOnClick(param1:Object, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_AuthorizeGuildInvited_Req);
         _loc4_ = _loc3_.Data;
         _loc4_.writeByte(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ProcessorPermitFriendInviteOnClick(param1:Object, param2:uint, param3:uint, param4:uint) : void
      {
         var _loc5_:TPacket = null;
         var _loc6_:ByteArray = null;
         _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_AuthorizeUserInvited_Req);
         _loc6_ = _loc5_.Data;
         _loc6_.writeUnsignedInt(param2);
         _loc6_.writeUnsignedInt(param3);
         _loc6_.writeByte(param4);
         SNetworkCore.Transceiver.PacketTransmit(_loc5_);
      }
      
      protected function ProcessorOnEffectText(param1:String) : void
      {
         if(FOnEffectText != null)
         {
            FOnEffectText(param1);
         }
      }
      
      public function set SlotOnOver(param1:Function) : void
      {
         this.FSlotOnOver = param1;
      }
      
      public function set SlotOnOut(param1:Function) : void
      {
         this.FSlotOnOut = param1;
      }
      
      public function set CreateRoomOnClick(param1:Function) : void
      {
         this.FCreateRoomOnClick = param1;
      }
      
      public function set EnterRoomOnClick(param1:Function) : void
      {
         this.FEnterRoomOnClick = param1;
      }
      
      public function set UIHintOnOver(param1:Function) : void
      {
         this.FUIHintOnOver = param1;
      }
      
      public function set UIHintOnOut(param1:Function) : void
      {
         this.FUIHintOnOut = param1;
      }
      
      public function set UIHintOnMove(param1:Function) : void
      {
         this.FUIHintOnMove = param1;
      }
      
      public function set GoAccessory(param1:Function) : void
      {
         this.FGoAccessory = param1;
      }
      
      public function Update() : void
      {
         this.UpdateUIBattleSelect();
         this.ProcessorBattleUIOnClick(this.FUIBattleSelects[0],this.FUIBattleSelects[0].Context);
         this.UpdateUIRoom();
         this.UpdatePageInfo();
         this.UpdateOtherInfo();
         this.UpdateFreeCount();
         this.FBattleSelectMaxPages = Math.ceil(this.FGroupBattleData.GroupBattleLevels.Count / 2 / this.CAPACITY_BATTLESELECT) - 1;
      }
      
      public function UpdateFriendList() : void
      {
         this.FProcessorWindowShadowInvite.Visible = true;
         this.FProcessorWindowShadowInvite.Update();
      }
      
      public function UpdateOrgAuthorizeStatus() : void
      {
         this.FProcessorWindowShadowInvite.Update();
      }
      
      public function UpdateRoomsInfo() : void
      {
         this.UpdateUIRoom();
         this.UpdatePageInfo();
      }
      
      public function Reset() : void
      {
         this.FBattleSelectIndex = 0;
         this.FPageRoomIndex = 0;
         this.FSlotIndex = 0;
         if(this.FCurrentClickBattleUI != null)
         {
            this.FCurrentClickBattleUI.ShowSelectBox = false;
         }
         this.FCurrentClickBattleUI = null;
      }
   }
}

