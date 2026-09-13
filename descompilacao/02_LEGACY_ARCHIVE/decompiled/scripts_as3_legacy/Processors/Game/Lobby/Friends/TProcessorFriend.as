package Processors.Game.Lobby.Friends
{
   import Components.Pages.*;
   import Components.Standard.*;
   import Debugging.*;
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Signals.TSignal;
   import Logics.Streamization.Characters.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Friends.Components.*;
   import Processors.Game.Windows.Editors.*;
   import Processors.Game.Windows.Information.*;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.Timing.*;
   import Utilities.UI.Overlayers.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class TProcessorFriend extends TProcessorLobbyWindows
   {
      
      protected static const STAGE_Width:uint = CONST_COMMON.STAGE_Width;
      
      protected static const STAGE_Height:uint = CONST_COMMON.STAGE_Height;
      
      public static const SIZE_WindowFriend_Width:uint = 502;
      
      public static const SIZE_WindowFriend_Height:uint = 505;
      
      public static const SIZE_WindowFriendAndRecommend_Width:uint = 846;
      
      public static const SIZE_WindowFriendAndRecommend_Height:uint = 505;
      
      public static const TIME_INTERVAL_UpdateFriendState:uint = 300000;
      
      public static const CAPACITY_MC_Tabs:uint = CONST_FRIEND.CAPACITY_MC_Tabs;
      
      public static const PAGESIZE_Listitem:uint = CONST_FRIEND.PAGESIZE_Listitem;
      
      public static const CAPACITY_Listitem:uint = CONST_FRIEND.CAPACITY_Listitem;
      
      public static const STRING_TabsCaption:Vector.<String> = STRING_FRIEND.STRING_TabsCaption;
      
      public static const FORMAT_RefreshPrompt:String = STRING_FRIEND.FORMAT_RefreshPrompt;
      
      public static const STRING_InputNickname:String = STRING_FRIEND.STRING_InputNickname;
      
      public static const FORMAT_WhiteDeletePrompt:String = STRING_FRIEND.FORMAT_WhiteDeletePrompt;
      
      public static const FORMAT_BlackDeletePrompt:String = STRING_FRIEND.FORMAT_BlackDeletePrompt;
      
      public static const FORMAT_WhiteAddPrompt:String = STRING_FRIEND.FORMAT_WhiteAddPrompt;
      
      public static const FORMAT_BlackAddPrompt:String = STRING_FRIEND.FORMAT_BlackAddPrompt;
      
      public static const STRING_MaxWhite:String = STRING_FRIEND.STRING_MaxWhite;
      
      public static const STRING_MaxBlack:String = STRING_FRIEND.STRING_MaxWhite;
      
      public static const STRING_AddSuccessful:String = STRING_FRIEND.STRING_AddSuccessful;
      
      public static const TYPE_White:uint = CONST_FRIEND.TYPE_White;
      
      public static const TYPE_Black:uint = CONST_FRIEND.TYPE_Black;
      
      public static const TYPE_Recommend:uint = CONST_FRIEND.TYPE_Recommend;
      
      protected static const TYPE_Whitelist_Add:uint = CONST_FRIEND.TYPE_Whitelist_Add;
      
      protected static const TYPE_Whitelist_Delete:uint = CONST_FRIEND.TYPE_Whitelist_Delete;
      
      protected static const TYPE_Blacklist_Add:uint = CONST_FRIEND.TYPE_Blacklist_Add;
      
      protected static const TYPE_Blacklist_Delete:uint = CONST_FRIEND.TYPE_Blacklist_Delete;
      
      protected static const MODE_INQUIRY_Internal:uint = 0;
      
      protected static const MODE_INQUIRY_External:uint = 1;
      
      protected var FUnstreamizerFriendDigests:TUnstreamizerFriendDigests;
      
      protected var FUnstreamizerFriendDigest:TUnstreamizerFriendDigest;
      
      protected var FUIWindowEditorString:TUIWindowEditorString;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FHelpTips:THint;
      
      protected var FWhiteDigests:TFriendDigests;
      
      protected var FBlackDigests:TFriendDigests;
      
      protected var FRecommendDigests:TFriendDigests;
      
      protected var FCurrentDigests:TFriendDigests;
      
      protected var FFriends:TFriendDigests;
      
      protected var FMC_Friend:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FBtnRecommend_Close:SimpleButton;
      
      protected var FMC_EffectLeft:MovieClip;
      
      protected var FMC_EffectRight:MovieClip;
      
      protected var FMC_EffectRightRecommend:MovieClip;
      
      protected var FMC_HiddenCornersTop:Sprite;
      
      protected var FMC_HiddenCornersBottom:Sprite;
      
      protected var FMC_FightTimer:MovieClip;
      
      protected var FTF_Timer:TextField;
      
      protected var FTF_GiveOtheroTiLi:TextField;
      
      protected var FMC_ShowOrHide:MovieClip;
      
      protected var FUITab:TUITab;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_Whitelist:Sprite;
      
      protected var FMC_Blacklist:Sprite;
      
      protected var FMC_RecommendView:Sprite;
      
      protected var FUIWhitelItems:Vector.<TUIItem>;
      
      protected var FUIBlackItems:Vector.<TUIItem>;
      
      protected var FUIRecommendItems:Vector.<TUIItem>;
      
      protected var FUICurrentItems:Vector.<TUIItem>;
      
      protected var FBtnRecommend:SimpleButton;
      
      protected var FBtnInquiry:SimpleButton;
      
      protected var FBtnAdd:SimpleButton;
      
      protected var FBtnRefresh:MovieClip;
      
      protected var FBtnOnekeyAdd:SimpleButton;
      
      protected var FBTN_GetTiLi:SimpleButton;
      
      protected var FBTN_OneKeyGetTiLi:SimpleButton;
      
      protected var FBoundsFriend:TBounds;
      
      protected var FTabIndex:int;
      
      protected var FPageIndex:int;
      
      protected var FTickUpdate:int;
      
      protected var FHintRefresh:THint;
      
      protected var FInquiryMode:uint;
      
      protected var FTypeInquiry:uint;
      
      protected var FMaxWhitelist:uint;
      
      protected var FMaxBlacklist:uint;
      
      protected var FTimingRefreshReferenceTick:int;
      
      protected var FTimeIntervalRefreshRecommendFriend:uint;
      
      protected var FIsBtnRefreshOver:Boolean;
      
      protected var FRefreshOverCount:uint;
      
      protected var FIsRefreshRecommendFriend:Boolean;
      
      protected var FIsInitialization:Boolean;
      
      protected var FFightTimes:int;
      
      protected var FFightStamp:uint;
      
      protected var FGiveAndGetTiLi:TGiveAndGetTiLi;
      
      protected var FOnWhisper:Function;
      
      protected var FOnMail:Function;
      
      protected var FOnInquiryRet:Function;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FCurTiLi:TFriendDigestTiLi;
      
      protected var FShowEffectNotification:Function;
      
      public function TProcessorFriend(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerFriendDigests = new TUnstreamizerFriendDigests();
         this.FUnstreamizerFriendDigest = new TUnstreamizerFriendDigest();
         this.FGiveAndGetTiLi = new TGiveAndGetTiLi(param1);
         this.FGiveAndGetTiLi.GetBtnBack = this.GiveAndGetTiLiBtnBack;
         this.FGiveAndGetTiLi.OneKeyGetFun = this.OneKeyGetFun;
         this.FHelpTips = new THint();
         this.FWhiteDigests = new TFriendDigests();
         this.FBlackDigests = new TFriendDigests();
         this.FRecommendDigests = new TFriendDigests();
         this.FFriends = SLogicsCore.Friends;
         this.FGiveAndGetTiLi.AllData = this.FFriends;
         this.FUIWhitelItems = new Vector.<TUIItem>(CAPACITY_Listitem);
         this.FUIBlackItems = new Vector.<TUIItem>(CAPACITY_Listitem);
         this.FUIRecommendItems = new Vector.<TUIItem>(CAPACITY_Listitem);
         this.FBoundsFriend = new TBounds();
         this.FBoundsFriend.Width = SIZE_WindowFriend_Width;
         this.FBoundsFriend.Height = SIZE_WindowFriend_Height;
         this.FUITab = new TUITab(this);
         this.FUIPage = new TUIPage(this);
         this.FHintRefresh = new THint();
         this.FIsInitialization = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_FRIEND.RESOURCESID_Swf_Friend);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Sprite = null;
         var _loc5_:TUIItem = null;
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:Sprite = null;
         var _loc9_:MovieClip = null;
         var _loc10_:TextField = null;
         var _loc11_:Sprite = null;
         var _loc12_:TConfigValue = null;
         this.FMC_Friend = TUtilityReflection.CreateDisplayObjectInstance(CONST_FRIEND.RESOURCE_ClassName_MC_Friend) as Sprite;
         addChild(this.FMC_Friend);
         this.FBtn_Close = this.FMC_Friend[CONST_FRIEND.RESOURCE_Link_Btn_Close];
         this.FBtn_Help = this.FMC_Friend[CONST_FRIEND.RESOURCE_Link_Btn_Help];
         this.FMC_EffectLeft = this.FMC_Friend[CONST_FRIEND.RESOURCE_Link_MC_EffectLeft];
         this.FMC_EffectRight = this.FMC_Friend[CONST_FRIEND.RESOURCE_Link_MC_EffectRight];
         this.FMC_EffectLeft.gotoAndStop(1);
         this.FMC_EffectRight.gotoAndStop(1);
         this.FMC_HiddenCornersTop = this.FMC_Friend[CONST_FRIEND.RESOURCE_Link_MC_HiddenCornersTop] as Sprite;
         this.FMC_HiddenCornersBottom = this.FMC_Friend[CONST_FRIEND.RESOURCE_Link_MC_HiddenCornersBottom] as Sprite;
         this.FMC_FightTimer = this.FMC_Friend[CONST_FRIEND.RESOURCE_Link_MC_FightTimer];
         this.FTF_Timer = this.FMC_FightTimer[CONST_FRIEND.RESOURCE_Link_TF_Timer];
         this.FMC_ShowOrHide = this.FMC_Friend["MC_ShowOrHide"];
         this.FTF_GiveOtheroTiLi = this.FMC_ShowOrHide["TF_GiveOtheroTiLi"];
         this.FBTN_GetTiLi = this.FMC_ShowOrHide["BTN_GetTiLi"];
         this.FBTN_OneKeyGetTiLi = this.FMC_ShowOrHide["BTN_OneKeyGiveTiLi"];
         _loc2_ = int(CAPACITY_MC_Tabs);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_Friend[CONST_FRIEND.RESOURCE_Link_MC_Tabs + _loc1_];
            this.FUITab.SetTabByIndex(_loc3_,_loc1_);
            this.FUITab.SetTabCaptionByIndex(STRING_TabsCaption[_loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         _loc4_ = this.FMC_Friend[CONST_FRIEND.RESOURCE_Link_MC_FriendMountPoint];
         this.FMC_Whitelist = TUtilityReflection.CreateDisplayObjectInstance(CONST_FRIEND.RESOURCE_ClassName_MC_Whitelist) as Sprite;
         this.FMC_Blacklist = TUtilityReflection.CreateDisplayObjectInstance(CONST_FRIEND.RESOURCE_ClassName_MC_Blacklist) as Sprite;
         _loc4_.addChild(this.FMC_Whitelist);
         _loc4_.addChild(this.FMC_Blacklist);
         this.FMC_Blacklist.visible = false;
         _loc2_ = int(CAPACITY_Listitem);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = this.FMC_Whitelist[CONST_FRIEND.RESOURCE_Link_MC_Substrate + _loc1_];
            _loc7_ = this.FMC_Whitelist[CONST_FRIEND.RESOURCE_Link_MC_Listitem + _loc1_];
            _loc5_ = new TUIItem(this);
            _loc5_.Tag = _loc1_;
            _loc5_.OnWhisper = this.ListItemOnWhisper;
            _loc5_.OnMail = this.ListItemOnMail;
            _loc5_.OnDelete = this.ListItemOnDelete;
            _loc5_.OnFight = this.ListItemOnFight;
            _loc5_.OnGiveTiLi = this.ListItemOnGiveTiLi;
            _loc5_.Perform_UIDispatch(_loc6_,_loc7_);
            _loc5_.Init();
            this.FUIWhitelItems[_loc1_] = _loc5_;
            _loc1_++;
         }
         _loc2_ = int(CAPACITY_Listitem);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = this.FMC_Blacklist[CONST_FRIEND.RESOURCE_Link_MC_Substrate + _loc1_];
            _loc7_ = this.FMC_Blacklist[CONST_FRIEND.RESOURCE_Link_MC_Listitem + _loc1_];
            _loc5_ = new TUIItem(this);
            _loc5_.Tag = _loc1_;
            _loc5_.OnDelete = this.ListItemOnDelete;
            _loc5_.Perform_UIDispatch(_loc6_,_loc7_);
            _loc5_.Init();
            this.FUIBlackItems[_loc1_] = _loc5_;
            _loc1_++;
         }
         _loc8_ = this.FMC_Friend[CONST_FRIEND.RESOURCE_Link_MC_Page];
         _loc9_ = _loc8_[CONST_FRIEND.RESOURCE_Link_MC_PageLeft];
         this.FUIPage.ButtonPrevious.Substrate = _loc9_;
         _loc9_ = _loc8_[CONST_FRIEND.RESOURCE_Link_MC_PageRight];
         this.FUIPage.ButtonNext.Substrate = _loc9_;
         _loc10_ = _loc8_[CONST_BACKPACK.RESOURCE_Link_TF_Page];
         this.FUIPage.LabelPage = _loc10_;
         this.FUIPage.PageSize = PAGESIZE_Listitem;
         this.FUIPage.Init();
         this.FBtnRecommend = this.FMC_Friend[CONST_FRIEND.RESOURCE_Link_Btn_Recommend];
         this.FBtnInquiry = this.FMC_Friend[CONST_FRIEND.RESOURCE_Link_Btn_Inquiry];
         this.FBtnAdd = this.FMC_Friend[CONST_FRIEND.RESOURCE_Link_Btn_Add];
         this.FBtnAdd.visible = false;
         this.FMC_RecommendView = this.FMC_Friend[CONST_FRIEND.RESOURCE_Link_MC_RecommendView];
         this.FBtnRecommend_Close = this.FMC_RecommendView[CONST_FRIEND.RESOURCE_Link_Btn_Close];
         this.FMC_EffectRightRecommend = this.FMC_RecommendView[CONST_FRIEND.RESOURCE_Link_MC_EffectRight];
         this.FMC_EffectRightRecommend.play();
         this.FBtnRefresh = this.FMC_RecommendView[CONST_FRIEND.RESOURCE_Link_Btn_Refresh];
         this.FBtnOnekeyAdd = this.FMC_RecommendView[CONST_FRIEND.RESOURCE_Link_Btn_OnekeyAdd];
         TGameUtil.setButtonMode(this.FBtnRefresh,true);
         _loc11_ = this.FMC_RecommendView[CONST_FRIEND.RESOURCE_Link_MC_ListItem_Recommend];
         _loc2_ = int(CAPACITY_Listitem);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = _loc11_[CONST_FRIEND.RESOURCE_Link_MC_Substrate + _loc1_];
            _loc7_ = _loc11_[CONST_FRIEND.RESOURCE_Link_MC_Listitem + _loc1_];
            _loc5_ = new TUIItem(this);
            _loc5_.Tag = _loc1_;
            _loc5_.OnAdd = this.ListItemOnAdd;
            _loc5_.Perform_UIDispatch(_loc6_,_loc7_);
            _loc5_.Init();
            this.FUIRecommendItems[_loc1_] = _loc5_;
            _loc1_++;
         }
         this.SetRecommendWindow();
         this.FUIWindowEditorString = new TUIWindowEditorString(this);
         this.FUIWindowEditorString.OnOK = this.WindowEditorStringOnOK;
         this.FUIWindowEditorString.OnCancel = this.WindowEditorStringOnCancel;
         this.FUIWindowEditorString.x = (CONST_COMMON.STAGE_Width - this.FUIWindowEditorString.WindowWidth) / 2;
         this.FUIWindowEditorString.y = (CONST_COMMON.STAGE_Height - this.FUIWindowEditorString.WindowHeight) / 2;
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowEditorString(this.FUIWindowEditorString);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         _loc12_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.FRIEND_RECOMMEND_REFRESH) as TConfigValue;
         this.FTimeIntervalRefreshRecommendFriend = _loc12_.Value as uint;
         this.FTimeIntervalRefreshRecommendFriend *= 1000;
         _loc12_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.FRIEND_NUM_LIMIT) as TConfigValue;
         this.FMaxWhitelist = _loc12_.Value as uint;
         _loc12_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.FRIEND_BLACK_LIMIT) as TConfigValue;
         this.FMaxBlacklist = _loc12_.Value as uint;
         _loc12_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.FRIEND_CHALLENGECD) as TConfigValue;
         this.FFightStamp = _loc12_.Value as uint;
         _loc12_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60111005) as TConfigValue;
         this.FFriends.GiveCountMax = _loc12_.Value as uint;
         _loc12_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60111007) as TConfigValue;
         this.FFriends.GetCountMax = _loc12_.Value as uint;
         _loc12_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60111006) as TConfigValue;
         this.FFriends.OneTimesNum = _loc12_.Value as uint;
         if(SLogicsCore.Character.GetConfigValueById(91000006))
         {
            this.FMC_ShowOrHide.visible = true;
         }
         else
         {
            this.FMC_ShowOrHide.visible = false;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FUIPage.OnChangePage = this.PageOnChange;
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.BtnCloseOnClick,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.FBtnRecommend.addEventListener(MouseEvent.CLICK,this.BtnRecommendOnClick,false,0,true);
         this.FBtnInquiry.addEventListener(MouseEvent.CLICK,this.BtnInquiryOnClick,false,0,true);
         this.FBtnAdd.addEventListener(MouseEvent.CLICK,this.BtnAddOnClick,false,0,true);
         this.FBtnRecommend_Close.addEventListener(MouseEvent.CLICK,this.BtnRecommendCloseOnClick,false,0,true);
         this.FBtnRefresh.addEventListener(MouseEvent.CLICK,this.BtnRefreshOnClick,false,0,true);
         this.FBtnOnekeyAdd.addEventListener(MouseEvent.CLICK,this.BtnOnekeyAddOnClick,false,0,true);
         this.FBTN_GetTiLi.addEventListener(MouseEvent.CLICK,this.GetTiLiOnClick,false,0,true);
         this.FBTN_OneKeyGetTiLi.addEventListener(MouseEvent.CLICK,this.OneKeyGiveTiLiOnClick,false,0,true);
         this.FIsInitialization = true;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Friend_LoadFriendResult,this.PerformPacket_SC_Friend_LoadFriendResult);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Friend_LoadRecommendFriendResult,this.PerformPacket_SC_Friend_LoadRecommendFriendResult);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Friend_ProcessFriendRet,this.PerformPacket_SC_Friend_ProcessFriendRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Friend_FriendState,this.PerformPacket_SC_Friend_FriendState);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Friend_InquiryFriendIDRet,this.PerformPacket_SC_Friend_InquiryFriendIDRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Friend_Fight,this.PerformPacket_SC_Friend_Fight);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Friend_Share_S2C,this.PACKETID_SC_Friend_Share_S2C);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Friend_Get_Share_Info_S2C,this.PACKETID_SC_Friend_Get_Share_Info_S2C);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Friend_Get_Present_S2C,this.PACKETID_SC_Friend_Get_Present_S2C);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Friend_Share_Message_S2C,this.PACKETID_SC_Friend_Share_Message_S2C);
      }
      
      protected function PACKETID_SC_Friend_Share_Message_S2C(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:TFriendDigestTiLi = null;
         _loc2_ = param1.Data;
         _loc3_ = new TFriendDigestTiLi(_loc2_.readUnsignedInt(),_loc2_.readUnsignedInt());
         _loc3_.Type = 1;
         _loc3_.Name = TUtilityString.FetchUTF(_loc2_);
         _loc3_.Level = _loc2_.readUnsignedInt();
         _loc3_.IsGet = _loc2_.readUnsignedInt();
         this.FFriends.TiLiAdd(_loc3_);
         this.FGiveAndGetTiLi.UpdateView();
         this.IsShowEffect();
      }
      
      protected function GiveAndGetTiLiBtnBack(param1:TFriendDigestTiLi) : void
      {
         var _loc2_:TPacket = null;
         this.FCurTiLi = param1;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Friend_Get_Present_C2S);
         _loc2_.Data.writeUnsignedInt(1);
         _loc2_.Data.writeUnsignedInt(this.FCurTiLi.Identifier0);
         _loc2_.Data.writeUnsignedInt(this.FCurTiLi.Identifier1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OneKeyGetFun() : void
      {
         var _loc1_:TPacket = null;
         this.FCurTiLi = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Friend_Get_Present_C2S);
         _loc1_.Data.writeUnsignedInt(2);
         _loc1_.Data.writeUnsignedInt(0);
         _loc1_.Data.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function GetTiLiOnClick(param1:MouseEvent) : void
      {
         this.FGiveAndGetTiLi.visible = true;
         this.FGiveAndGetTiLi.UpdateView();
      }
      
      protected function PACKETID_SC_Friend_Get_Present_S2C(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         if(this.FCurTiLi)
         {
            this.FCurTiLi.IsGet = 1;
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < this.FFriends.FriendDigestTiLis.length)
            {
               if(this.FFriends.FriendDigestTiLis[_loc4_].Type == 1)
               {
                  this.FFriends.FriendDigestTiLis[_loc4_].IsGet = 1;
               }
               _loc4_++;
            }
         }
         this.FGiveAndGetTiLi.UpdateGetBtnState();
         this.FGiveAndGetTiLi.UpdateYiYongCount();
         this.IsShowEffect();
      }
      
      protected function IsShowEffect() : void
      {
         if(this.FShowEffectNotification != null)
         {
            if(this.FFriends.GetBooleanForEffect())
            {
               this.FShowEffectNotification(CONST_SHORTCUTS.POSITION_Others,CONST_SHORTCUTS.TYPE_Map_Friend,true);
            }
            else
            {
               this.FShowEffectNotification(CONST_SHORTCUTS.POSITION_Others,CONST_SHORTCUTS.TYPE_Map_Friend,false);
            }
         }
      }
      
      protected function ListItemOnGiveTiLi(param1:TFriendDigest) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Friend_Share_C2S);
         _loc2_.Data.writeUnsignedInt(1);
         _loc2_.Data.writeUnsignedInt(param1.Identifier0);
         _loc2_.Data.writeUnsignedInt(param1.Identifier1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OneKeyGiveTiLiOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Friend_Share_C2S);
         _loc2_.Data.writeUnsignedInt(2);
         _loc2_.Data.writeUnsignedInt(0);
         _loc2_.Data.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PACKETID_SC_Friend_Share_S2C(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         var _loc5_:TFriendDigestTiLi = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc4_ = _loc3_.readShort();
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = new TFriendDigestTiLi(_loc3_.readUnsignedInt(),_loc3_.readUnsignedInt());
            _loc5_.Type = 2;
            this.FFriends.TiLiAdd(_loc5_);
            _loc6_++;
         }
         this.CheckGiveTiLiBtn();
         this.UpdateOverTiLiCount();
      }
      
      protected function PACKETID_CS_Friend_Get_Share_Info_() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Friend_Get_Share_Info_C2S);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_SC_Friend_Get_Share_Info_S2C(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TFriendDigestTiLi = null;
         _loc2_ = param1.Data;
         this.FFriends.TiLiClear();
         _loc4_ = _loc2_.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = new TFriendDigestTiLi(_loc2_.readUnsignedInt(),_loc2_.readUnsignedInt());
            _loc5_.Type = 2;
            this.FFriends.TiLiAdd(_loc5_);
            _loc3_++;
         }
         _loc4_ = _loc2_.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = new TFriendDigestTiLi(_loc2_.readUnsignedInt(),_loc2_.readUnsignedInt());
            _loc5_.Type = 1;
            _loc5_.Name = TUtilityString.FetchUTF(_loc2_);
            _loc5_.Level = _loc2_.readUnsignedInt();
            _loc5_.IsGet = _loc2_.readUnsignedInt();
            this.FFriends.TiLiAdd(_loc5_);
            _loc3_++;
         }
         this.IsShowEffect();
         this.CheckGiveTiLiBtn();
         this.UpdateOverTiLiCount();
      }
      
      protected function UpdateOverTiLiCount() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this.FFriends.GetCountByType(2);
         this.FTF_GiveOtheroTiLi.text = TUtilityString.Format(STRING_FRIEND.STRING_GiveTiLiCount,_loc1_,this.FFriends.GiveCountMax);
      }
      
      public function set ShowEffectNotification(param1:Function) : void
      {
         this.FShowEffectNotification = param1;
      }
      
      protected function PerformPacket_SC_Friend_LoadFriendResult(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FUnstreamizerFriendDigests.Unstreamize(_loc3_,this.FFriends,null);
      }
      
      protected function PerformPacket_SC_Friend_LoadRecommendFriendResult(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:ByteArray = null;
         var _loc6_:TFriendDigest = null;
         _loc5_ = param1.Data;
         _loc4_ = _loc5_.readUnsignedInt();
         if(_loc4_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc4_);
            return;
         }
         this.FUnstreamizerFriendDigests.Unstreamize(_loc5_,this.FRecommendDigests,null);
         this.FFriends.ClearRecommendList();
         _loc3_ = this.FRecommendDigests.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = this.FRecommendDigests.GetDigestByIndex(_loc2_);
            this.FFriends.Add(_loc6_);
            _loc2_++;
         }
         this.UpdateRecommendListItemFriendDigests(this.FRecommendDigests,this.FUIRecommendItems);
      }
      
      protected function PerformPacket_SC_Friend_ProcessFriendRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TFriendDigest = null;
         var _loc6_:TFriendDigest = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedByte();
         _loc5_ = SLogicsCore.PoolCharacter.AcquireFriendDigest();
         this.FUnstreamizerFriendDigest.Unstreamize(_loc2_,_loc5_,null);
         switch(_loc4_)
         {
            case TYPE_Whitelist_Add:
               EffectGenerateText(STRING_AddSuccessful);
            case TYPE_Blacklist_Add:
               _loc6_ = this.FFriends.GetDigestByIdentifier(_loc5_.Identifier0,_loc5_.Identifier1);
               if(_loc6_ != null)
               {
                  _loc6_.Type = _loc5_.Type;
               }
               else
               {
                  this.FFriends.Add(_loc5_);
               }
               break;
            case TYPE_Whitelist_Delete:
            case TYPE_Blacklist_Delete:
               this.FFriends.Delete(_loc5_);
         }
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.UpdateUserFriendDigests();
         this.UpdateListFriends();
         this.UpdateListItemRecommendFriend();
      }
      
      protected function PerformPacket_SC_Friend_FriendState(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:uint = 0;
         var _loc6_:TFriendDigest = null;
         var _loc7_:Boolean = false;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc4_ = param1.Data;
         _loc5_ = _loc4_.readUnsignedInt();
         if(_loc5_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc5_);
            return;
         }
         _loc3_ = int(_loc4_.readUnsignedShort());
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc8_ = _loc4_.readUnsignedInt();
            _loc9_ = _loc4_.readUnsignedInt();
            _loc6_ = this.FFriends.GetDigestByIdentifier(_loc8_,_loc9_);
            if(_loc6_ != null)
            {
               _loc6_.IsOnline = _loc4_.readBoolean();
            }
            else
            {
               _loc7_ = _loc4_.readBoolean();
            }
            _loc2_++;
         }
         if(this.Visible)
         {
            this.UpdateListItemFriendDigests(this.FCurrentDigests,this.FUICurrentItems);
         }
      }
      
      protected function PerformPacket_SC_Friend_InquiryFriendIDRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TFriendDigest = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            if(this.FInquiryMode == MODE_INQUIRY_External)
            {
               this.FInquiryMode = MODE_INQUIRY_Internal;
               if(this.FOnInquiryRet != null)
               {
                  this.FOnInquiryRet(this,0,0);
               }
               return;
            }
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc5_ = _loc2_.readUnsignedInt();
         _loc6_ = _loc2_.readUnsignedInt();
         if(this.FInquiryMode == MODE_INQUIRY_External)
         {
            if(this.FOnInquiryRet != null)
            {
               this.FOnInquiryRet(this,_loc5_,_loc6_);
            }
            this.FInquiryMode = MODE_INQUIRY_Internal;
         }
         _loc4_ = SLogicsCore.PoolCharacter.AcquireFriendDigest(_loc5_,_loc6_);
         this.ProcessOperatingFriends(this.FTypeInquiry,_loc4_,null);
         this.FTypeInquiry = 0;
      }
      
      protected function PerformPacket_SC_Friend_Fight(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_Friend,CONST_MUSIC.ID_SCENE_Arena);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         super.LogicsPerform();
         _loc1_ = int(STimingCore.TickCount);
         this.LogicsPerform_RefreshRecommendFriend(_loc1_);
         if(!Visible)
         {
            return;
         }
         if(_loc1_ - this.FTickUpdate >= TIME_INTERVAL_UpdateFriendState)
         {
            this.UpdateFriendState();
            this.FTickUpdate = STimingCore.TickCount;
         }
         if(FIsResourcesLoadCompleted && Visible)
         {
            this.LogicsPerform_Signals();
            this.CheckFightBtn();
         }
      }
      
      protected function LogicsPerform_RefreshRecommendFriend(param1:int) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(this.FIsRefreshRecommendFriend)
         {
            if(param1 - this.FTimingRefreshReferenceTick >= this.FTimeIntervalRefreshRecommendFriend)
            {
               this.FIsRefreshRecommendFriend = false;
               TGameUtil.setButtonMode(this.FBtnRefresh,true);
               this.BtnRefreshOnOut(null);
               this.FBtnRefresh.removeEventListener(MouseEvent.MOUSE_OVER,this.BtnRefreshOnOver);
               this.FBtnRefresh.removeEventListener(MouseEvent.MOUSE_OUT,this.BtnRefreshOnOut);
               ProcessorTipOnOut(this);
            }
            if(this.FIsBtnRefreshOver)
            {
               if(param1 % 150 > 100)
               {
                  _loc3_ = (this.FTimeIntervalRefreshRecommendFriend - (param1 - this.FTimingRefreshReferenceTick)) / 1000;
                  _loc2_ = TUtilityString.Format(FORMAT_RefreshPrompt,TUtilityTiming.FormatDHMBySeconds(_loc3_));
                  this.FHintRefresh.Caption = _loc2_;
                  ProcessorTipOnOver(this,this.FHintRefresh);
               }
            }
            else if(this.FRefreshOverCount == 0)
            {
               ProcessorTipOnOut(this);
               this.FRefreshOverCount++;
            }
         }
      }
      
      protected function SetRecommendWindow(param1:Boolean = false) : void
      {
         this.FMC_RecommendView.visible = param1;
         if(param1)
         {
            this.FBoundsFriend.Width = SIZE_WindowFriendAndRecommend_Width;
            this.FBoundsFriend.Height = SIZE_WindowFriendAndRecommend_Height;
         }
         else
         {
            this.FBoundsFriend.Width = SIZE_WindowFriend_Width;
            this.FBoundsFriend.Height = SIZE_WindowFriend_Height;
         }
         this.SetComponentBoundsCenter(this.FMC_Friend,this.FBoundsFriend);
      }
      
      protected function SetComponentBoundsCenter(param1:DisplayObject, param2:TBounds) : void
      {
         param1.x = (STAGE_Width - param2.Width) / 2;
         param1.y = (STAGE_Height - param2.Height) / 2;
      }
      
      protected function HiddenCorners(param1:Boolean = true) : void
      {
         this.FMC_HiddenCornersTop.visible = param1;
         this.FMC_HiddenCornersBottom.visible = param1;
      }
      
      protected function PlayEffect() : void
      {
         this.FMC_EffectLeft.play();
         this.FMC_EffectRight.play();
      }
      
      protected function UpdateUserFriendDigests() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TFriendDigest = null;
         this.FWhiteDigests.Clear();
         this.FBlackDigests.Clear();
         this.FRecommendDigests.Clear();
         _loc2_ = this.FFriends.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FFriends.GetDigestByIndex(_loc1_);
            switch(_loc3_.Type)
            {
               case TYPE_White:
                  this.FWhiteDigests.Add(_loc3_);
                  break;
               case TYPE_Black:
                  this.FBlackDigests.Add(_loc3_);
                  break;
               case TYPE_Recommend:
                  this.FRecommendDigests.Add(_loc3_);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateListFriends() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TFriendDigests = null;
         var _loc3_:Vector.<TUIItem> = null;
         _loc1_ = this.FTabIndex;
         switch(_loc1_)
         {
            case 0:
               _loc2_ = this.FWhiteDigests;
               _loc3_ = this.FUIWhitelItems;
               break;
            case 1:
               _loc2_ = this.FBlackDigests;
               _loc3_ = this.FUIBlackItems;
         }
         this.FCurrentDigests = _loc2_;
         this.FUICurrentItems = _loc3_;
         this.FPageIndex = 0;
         this.FUIPage.TotalQuantity = _loc2_.Count;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
         this.UpdateListItemFriendDigests(_loc2_,_loc3_);
         this.CheckGiveTiLiBtn();
      }
      
      protected function UpdateListItemRecommendFriend() : void
      {
         this.UpdateRecommendListItemFriendDigests(this.FRecommendDigests,this.FUIRecommendItems);
      }
      
      protected function UpdateListItemFriendDigests(param1:TFriendDigests, param2:Vector.<TUIItem>) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TUIItem = null;
         var _loc8_:TFriendDigest = null;
         _loc5_ = this.FPageIndex;
         _loc4_ = int(CAPACITY_Listitem);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc7_ = param2[_loc3_];
            _loc7_.SetVisible(false);
            _loc3_++;
         }
         _loc4_ = param1.Count;
         if(_loc4_ <= 0)
         {
            return;
         }
         _loc6_ = _loc5_ * CAPACITY_Listitem;
         _loc3_ = 0;
         while(_loc3_ < CAPACITY_Listitem)
         {
            if(_loc3_ + _loc6_ >= _loc4_)
            {
               break;
            }
            _loc7_ = param2[_loc3_];
            _loc8_ = param1.GetDigestByIndex(_loc3_ + _loc6_);
            _loc7_.Context = _loc8_;
            _loc7_.SetVisible(true);
            _loc3_++;
         }
      }
      
      protected function UpdateRecommendListItemFriendDigests(param1:TFriendDigests, param2:Vector.<TUIItem>) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TUIItem = null;
         var _loc7_:TFriendDigest = null;
         _loc4_ = int(CAPACITY_Listitem);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = param2[_loc3_];
            _loc6_.SetVisible(false);
            _loc3_++;
         }
         _loc4_ = param1.Count;
         if(_loc4_ <= 0)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < CAPACITY_Listitem)
         {
            if(_loc3_ >= _loc4_)
            {
               break;
            }
            _loc6_ = param2[_loc3_];
            _loc7_ = param1.GetDigestByIndex(_loc3_);
            _loc6_.Context = _loc7_;
            _loc6_.SetVisible(true);
            _loc3_++;
         }
      }
      
      protected function ProcessOperatingFriends(param1:uint, param2:TFriendDigest, param3:TFriendDigests) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TPacket = null;
         var _loc7_:ByteArray = null;
         var _loc8_:TFriendDigest = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc6_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Friend_ProcessFriendReq);
         _loc7_ = _loc6_.Data;
         _loc7_.writeByte(param1);
         if(param2 != null)
         {
            _loc7_.writeShort(1);
            _loc9_ = param2.Identifier0;
            _loc10_ = param2.Identifier1;
            _loc7_.writeUnsignedInt(_loc9_);
            _loc7_.writeUnsignedInt(_loc10_);
         }
         else if(param3 != null)
         {
            _loc5_ = param3.Count;
            if(_loc5_ == 0)
            {
               return;
            }
            _loc7_.writeShort(_loc5_);
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc8_ = param3.GetDigestByIndex(_loc4_);
               _loc9_ = _loc8_.Identifier0;
               _loc10_ = _loc8_.Identifier1;
               _loc7_.writeUnsignedInt(_loc9_);
               _loc7_.writeUnsignedInt(_loc10_);
               _loc4_++;
            }
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc6_);
      }
      
      protected function ProcessorRecommendFriendListReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Friend_LoadRecommendFriend);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorInquiryFriendIDReq(param1:String) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Friend_InquiryFriendIDReq);
         _loc3_ = _loc2_.Data;
         TUtilityString.FlushUTF(_loc3_,param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function UpdateFriendState() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         var _loc5_:TFriendDigest = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc2_ = this.FWhiteDigests.Count;
         if(_loc2_ == 0)
         {
            return;
         }
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Friend_FriendState);
         _loc4_ = _loc3_.Data;
         _loc4_.writeShort(_loc2_);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = this.FWhiteDigests.GetDigestByIndex(_loc1_);
            _loc6_ = _loc5_.Identifier0;
            _loc7_ = _loc5_.Identifier1;
            _loc4_.writeUnsignedInt(_loc6_);
            _loc4_.writeUnsignedInt(_loc7_);
            _loc1_++;
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function VerificationAddFriend(param1:uint) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:uint = 0;
         var _loc4_:TFriendDigests = null;
         _loc2_ = true;
         switch(param1)
         {
            case TYPE_Whitelist_Add:
               _loc3_ = this.FMaxWhitelist;
               _loc4_ = this.FWhiteDigests;
               break;
            case TYPE_Blacklist_Add:
               _loc3_ = this.FMaxBlacklist;
               _loc4_ = this.FBlackDigests;
         }
         if(_loc4_.Count >= _loc3_)
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      override protected function PopTipsNotifyCheck() : void
      {
         if(FOnCheckPopTipsModes != null)
         {
            FOnCheckPopTipsModes(this,CONST_POPTIPS.POPTIP_Goto_Friend);
         }
      }
      
      protected function FriendFightRequest() : void
      {
         var _loc1_:Vector.<uint> = null;
         _loc1_ = Vector.<uint>([CONST_COUNTER.KEY_FriendFightTimes]);
         SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_COMMON_FriendFightTimes_Req,0,0,_loc1_);
      }
      
      protected function LogicsPerform_Signals() : void
      {
         var _loc1_:TSignal = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc1_ = SLogicsCore.SignalRetrieve(CONST_SIGNAL.SIGNALDESTINATION_COMMON_FriendFightTimes_Ret);
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = _loc1_.Identifier;
         _loc3_ = uint(_loc1_.Value);
         if(_loc2_ != CONST_COUNTER.KEY_FriendFightTimes)
         {
            return;
         }
         this.FFightTimes = _loc3_;
      }
      
      protected function CheckFightBtn() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Boolean = false;
         var _loc3_:TUIItem = null;
         var _loc4_:int = 0;
         _loc2_ = Boolean(STimingCore.GetServerTick() - this.FFightTimes > this.FFightStamp);
         _loc4_ = this.FFightStamp - (STimingCore.GetServerTick() - this.FFightTimes);
         _loc1_ = 0;
         while(_loc1_ < CAPACITY_Listitem)
         {
            _loc3_ = this.FUIWhitelItems[_loc1_];
            if(_loc3_.Visible)
            {
               _loc3_.SetFightStatus(_loc2_);
            }
            _loc1_++;
         }
         this.FMC_FightTimer.visible = Boolean(_loc4_ > 0);
         if(_loc4_ > 0)
         {
            this.FTF_Timer.text = TGameUtil.fomatSmallTime(_loc4_);
         }
      }
      
      protected function CheckGiveTiLiBtn() : void
      {
         var _loc1_:int = 0;
         if(!this.FUIWhitelItems[0])
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < CAPACITY_Listitem)
         {
            this.FUIWhitelItems[_loc1_].UpdateGiveBtnState();
            _loc1_++;
         }
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FTabIndex = param1 as int;
         this.FMC_Whitelist.visible = false;
         this.FMC_Blacklist.visible = false;
         this.FBtnRecommend.visible = false;
         this.FBtnInquiry.visible = false;
         this.FBtnAdd.visible = false;
         switch(this.FTabIndex)
         {
            case 0:
               this.FMC_Whitelist.visible = true;
               this.FBtnRecommend.visible = true;
               this.FBtnInquiry.visible = true;
               break;
            case 1:
               this.FMC_Blacklist.visible = true;
               this.FBtnAdd.visible = true;
         }
         this.FUIPage.Reset();
         this.FPageIndex = 0;
         this.UpdateListFriends();
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndex = param2;
         this.UpdateListItemFriendDigests(this.FCurrentDigests,this.FUICurrentItems);
         this.CheckGiveTiLiBtn();
      }
      
      protected function BtnCloseOnClick(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_Friend) as TSystemLanguage;
         this.FHelpTips.Content = _loc2_.Desc;
         UIHelpTipsHintOnOver(this,this.FHelpTips);
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         UIHelpTipsHintOnOut(this);
      }
      
      protected function BtnRecommendOnClick(param1:MouseEvent) : void
      {
         this.UpdateListItemRecommendFriend();
         this.FMC_RecommendView.visible = !this.FMC_RecommendView.visible;
         this.SetRecommendWindow(this.FMC_RecommendView.visible);
      }
      
      protected function BtnInquiryOnClick(param1:MouseEvent) : void
      {
         this.FTypeInquiry = TYPE_Whitelist_Add;
         this.FUIWindowEditorString.Tag = TYPE_Whitelist_Add;
         this.FUIWindowEditorString.Label = STRING_InputNickname;
         this.FUIWindowEditorString.SetFocus();
         this.FUIWindowEditorString.Visible = true;
      }
      
      protected function BtnAddOnClick(param1:MouseEvent) : void
      {
         this.FTypeInquiry = TYPE_Blacklist_Add;
         this.FUIWindowEditorString.Tag = TYPE_Blacklist_Add;
         this.FUIWindowEditorString.Label = STRING_InputNickname;
         this.FUIWindowEditorString.SetFocus();
         this.FUIWindowEditorString.Visible = true;
      }
      
      protected function BtnRecommendCloseOnClick(param1:MouseEvent) : void
      {
         this.FMC_RecommendView.visible = false;
         this.SetRecommendWindow();
      }
      
      protected function BtnRefreshOnClick(param1:MouseEvent) : void
      {
         if(this.FIsRefreshRecommendFriend)
         {
            return;
         }
         this.ProcessorRecommendFriendListReq();
         TGameUtil.setButtonMode(this.FBtnRefresh,false);
         this.FIsRefreshRecommendFriend = true;
         this.FTimingRefreshReferenceTick = STimingCore.TickCount;
         this.FBtnRefresh.addEventListener(MouseEvent.MOUSE_OVER,this.BtnRefreshOnOver,false,0,true);
         this.FBtnRefresh.addEventListener(MouseEvent.MOUSE_OUT,this.BtnRefreshOnOut,false,0,true);
         this.BtnRefreshOnOver(null);
      }
      
      protected function BtnRefreshOnOver(param1:MouseEvent) : void
      {
         this.FIsBtnRefreshOver = true;
      }
      
      protected function BtnRefreshOnOut(param1:MouseEvent) : void
      {
         this.FIsBtnRefreshOver = false;
         this.FRefreshOverCount = 0;
      }
      
      protected function BtnOnekeyAddOnClick(param1:MouseEvent) : void
      {
         this.ProcessOperatingFriends(TYPE_Whitelist_Add,null,this.FRecommendDigests);
      }
      
      protected function ListItemOnWhisper(param1:Object, param2:TFriendDigest) : void
      {
         if(this.FOnWhisper != null)
         {
            this.FOnWhisper(this,param2);
            ProcessorClose();
         }
      }
      
      protected function ListItemOnMail(param1:Object, param2:TFriendDigest) : void
      {
         if(this.FOnMail != null)
         {
            this.FOnMail(this,param2);
         }
      }
      
      protected function ListItemOnDelete(param1:Object, param2:TFriendDigest) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         _loc6_ = this.FTabIndex;
         switch(_loc6_)
         {
            case 0:
               _loc3_ = TYPE_Whitelist_Delete;
               _loc4_ = FORMAT_WhiteDeletePrompt;
               break;
            case 1:
               _loc3_ = TYPE_Blacklist_Delete;
               _loc4_ = FORMAT_BlackDeletePrompt;
         }
         _loc5_ = TUtilityString.Format(_loc4_,param2.Name);
         this.FUIWindowConfirmation.Text = _loc5_;
         this.FUIWindowConfirmation.Tag = _loc3_;
         this.FUIWindowConfirmation.Context = param2;
         this.FUIWindowConfirmation.Visible = true;
      }
      
      protected function ListItemOnAdd(param1:Object, param2:TFriendDigest) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         _loc4_ = this.FTabIndex;
         switch(_loc4_)
         {
            case 0:
               _loc3_ = TYPE_Whitelist_Add;
               break;
            case 1:
               _loc3_ = TYPE_Blacklist_Add;
         }
         this.ProcessOperatingFriends(_loc3_,param2,null);
      }
      
      protected function ListItemOnFight(param1:Object, param2:TFriendDigest) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Friend_Fight);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(SLogicsCore.Character.Identifier0);
         _loc4_.writeUnsignedInt(SLogicsCore.Character.Identifier1);
         _loc4_.writeUnsignedInt(param2.Identifier0);
         _loc4_.writeUnsignedInt(param2.Identifier1);
         _loc4_.writeUnsignedInt(0);
         _loc4_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function WindowEditorStringOnOK(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:uint = 0;
         var _loc8_:TFriendDigest = null;
         _loc2_ = this.FUIWindowEditorString.Value;
         if(!TUtilityString.Empty(_loc2_))
         {
            _loc8_ = this.FFriends.GetDigestByName(_loc2_);
            if(_loc8_ != null)
            {
               switch(_loc8_.Type)
               {
                  case TYPE_White:
                     _loc7_ = TYPE_Blacklist_Add;
                     _loc4_ = FORMAT_BlackAddPrompt;
                     break;
                  case TYPE_Black:
                     _loc7_ = TYPE_Whitelist_Add;
                     _loc4_ = FORMAT_WhiteAddPrompt;
               }
               _loc5_ = TUtilityString.Format(_loc4_,_loc8_.Name);
               this.FUIWindowConfirmation.Text = _loc5_;
               this.FUIWindowConfirmation.Tag = _loc7_;
               this.FUIWindowConfirmation.Context = _loc8_;
               this.FUIWindowConfirmation.Visible = true;
            }
            else
            {
               _loc3_ = this.VerificationAddFriend(this.FUIWindowEditorString.Tag);
               if(_loc3_)
               {
                  this.ProcessorInquiryFriendIDReq(_loc2_);
                  this.FInquiryMode = MODE_INQUIRY_Internal;
               }
               else
               {
                  switch(this.FUIWindowEditorString.Tag)
                  {
                     case TYPE_Whitelist_Add:
                        _loc6_ = STRING_MaxWhite;
                        break;
                     case TYPE_Blacklist_Add:
                        _loc6_ = STRING_MaxBlack;
                  }
                  EffectGenerateText(_loc6_);
               }
            }
         }
         this.FUIWindowEditorString.Value = "";
      }
      
      protected function WindowConfirmationOnOK(param1:Object) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TFriendDigest = null;
         _loc2_ = uint(this.FUIWindowConfirmation.Tag);
         _loc3_ = this.FUIWindowConfirmation.Context as TFriendDigest;
         this.ProcessOperatingFriends(_loc2_,_loc3_,null);
      }
      
      protected function WindowEditorStringOnCancel(param1:Object) : void
      {
         this.FUIWindowEditorString.Value = "";
      }
      
      public function get OnWhisper() : Function
      {
         return this.FOnWhisper;
      }
      
      public function set OnWhisper(param1:Function) : void
      {
         this.FOnWhisper = param1;
      }
      
      public function get OnMail() : Function
      {
         return this.FOnMail;
      }
      
      public function set OnMail(param1:Function) : void
      {
         this.FOnMail = param1;
      }
      
      public function get OnInquiryRet() : Function
      {
         return this.FOnInquiryRet;
      }
      
      public function set OnInquiryRet(param1:Function) : void
      {
         this.FOnInquiryRet = param1;
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      public function get SetStatusType() : Function
      {
         return this.FSetStatusType;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function get OnInitBattle() : Function
      {
         return this.FOnInitBattle;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TFriendDigest = null;
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FGiveAndGetTiLi.Load();
            return;
         }
         this.UpdateUserFriendDigests();
         this.UpdateListFriends();
         this.UpdateFriendState();
         this.FriendFightRequest();
         this.PACKETID_CS_Friend_Get_Share_Info_();
         this.SetRecommendWindow();
         this.HiddenCorners();
         this.PlayEffect();
      }
      
      override public function Unmount() : void
      {
         this.FTabIndex = 0;
         this.FUITab.Reset();
         this.FPageIndex = 0;
         this.FUIPage.Reset();
         this.IsShowEffect();
      }
      
      public function ProcessorInquiryCharacterIDByNickname(param1:String) : void
      {
         this.ProcessorInquiryFriendIDReq(param1);
         this.FInquiryMode = MODE_INQUIRY_External;
      }
      
      public function ProcessorInterpersonalRelationshipsReq(param1:uint, param2:Object) : void
      {
         var _loc3_:TFriendDigest = null;
         _loc3_ = param2 as TFriendDigest;
         this.ProcessOperatingFriends(param1,_loc3_,null);
      }
   }
}

