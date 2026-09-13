package Processors.Game.Lobby.GroupBattle.Window
{
   import Components.Pages.TUIPage;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.GroupBattle.TGroupBattleData;
   import Logics.GroupBattle.TShadowList;
   import Logics.GroupBattle.TShadowPlayer;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.GroupBattle.Component.TUIPlayer;
   import Resources.Strings.STRING_GROUPBATTLE;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowShadowInvite extends TProcessorWindowTemplate
   {
      
      protected const CAPACITY_PLAYERS:uint = 12;
      
      protected var FTF_RestShadowCount:TextField;
      
      protected var FTF_SeekPlayer:TextField;
      
      protected var FMC_Seek:MovieClip;
      
      protected var FMC_ChangeListPage:Sprite;
      
      protected var FMC_Option:MovieClip;
      
      protected var FUIPlayers:Vector.<TUIPlayer>;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FGroupBattleData:TGroupBattleData;
      
      protected var FFriendList:TShadowList;
      
      protected var FFilterFriendList:TShadowList;
      
      protected var FPermitOrganizationOnClick:Function;
      
      protected var FPermitFriendInviteOnClick:Function;
      
      public function TProcessorWindowShadowInvite(param1:TUIComponent)
      {
         super(param1);
         this.FUIPlayers = new Vector.<TUIPlayer>(this.CAPACITY_PLAYERS);
         this.FUIPage = new TUIPage(this);
         this.FFilterFriendList = new TShadowList();
         this.FGroupBattleData = SLogicsCore.GroupBattleData;
         this.FFriendList = SLogicsCore.GroupBattleData.FriendList;
      }
      
      protected function Perform_UIDispatch() : void
      {
         var _loc1_:TUIPlayer = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc6_ = FMainUI.x + FMainUI.parent.x;
         _loc7_ = FMainUI.y + FMainUI.parent.y;
         UIDispatch();
         FMainUI.x = 0;
         FMainUI.y = 0;
         this.X = _loc6_;
         this.Y = _loc7_;
         this.FTF_RestShadowCount = FMainUI["TF_RestShadowCount"];
         this.FTF_SeekPlayer = FMainUI["TF_SeekPlayer"];
         this.FMC_Seek = FMainUI["MC_Seek"];
         TGameUtil.setButtonMode(this.FMC_Seek,true);
         _loc3_ = this.CAPACITY_PLAYERS;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = new TUIPlayer(this);
            _loc1_.Resource = FMainUI["MC_Player_" + _loc2_] as MovieClip;
            _loc1_.ChooseOnClick = this.ProcessorChooseOnClick;
            _loc1_.Init();
            this.FUIPlayers[_loc2_] = _loc1_;
            _loc2_++;
         }
         this.FMC_ChangeListPage = FMainUI["MC_ChangeListPage"];
         _loc4_ = this.FMC_ChangeListPage["MC_PageLeft"];
         this.FUIPage.ButtonPrevious.Substrate = _loc4_;
         _loc4_ = this.FMC_ChangeListPage["MC_PageRight"];
         this.FUIPage.ButtonNext.Substrate = _loc4_;
         _loc5_ = this.FMC_ChangeListPage["TF_Page"];
         this.FUIPage.LabelPage = _loc5_;
         this.FUIPage.PageSize = this.CAPACITY_PLAYERS;
         this.FUIPage.Init();
         this.FMC_Option = FMainUI["MC_Option"];
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function Perform_UILocations() : void
      {
         UILocations();
         this.FMC_Seek.addEventListener(MouseEvent.CLICK,this.MCSeekOnClick,false,0,true);
         this.FMC_Option.addEventListener(MouseEvent.CLICK,this.MCOptionOnClick,false,0,true);
         this.FTF_SeekPlayer.addEventListener(FocusEvent.FOCUS_IN,this.TFOnFocusIn,false,0,true);
         this.FTF_SeekPlayer.addEventListener(FocusEvent.FOCUS_OUT,this.TFOnFocusOut,false,0,true);
         this.FUIPage.OnChangePage = this.PageOnChange;
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIPlayer = null;
         this.FTF_RestShadowCount.text = TUtilityString.Format(STRING_GROUPBATTLE.FORMAT_RestShadowCount,this.FGroupBattleData.RestShadowCount);
         this.FUIPage.TotalQuantity = this.FFriendList.Count;
         _loc1_ = 0;
         while(_loc1_ < this.CAPACITY_PLAYERS)
         {
            _loc3_ = this.FUIPlayers[_loc1_];
            _loc2_ = this.FPageIndex * this.CAPACITY_PLAYERS + _loc1_;
            if(_loc2_ < this.FFriendList.Count)
            {
               _loc3_.Context = this.FFriendList.GetShadowPlayerByIndex(_loc2_);
               _loc3_.Update();
               _loc3_.Resource.visible = true;
            }
            else
            {
               _loc3_.Resource.visible = false;
            }
            _loc1_++;
         }
         this.FMC_Option.gotoAndStop((this.FGroupBattleData.OrgAuthorizeStatus + 1) % 2 + 1);
      }
      
      protected function UpdateFriendUI(param1:Boolean = false, param2:String = null) : void
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TUIPlayer = null;
         var _loc6_:int = 0;
         var _loc7_:TShadowPlayer = null;
         var _loc8_:TShadowList = null;
         if(param1 && param2 != "" && param2 != STRING_GROUPBATTLE.STRING_InputName)
         {
            this.FFilterFriendList.Clear();
            _loc4_ = this.FGroupBattleData.FriendList.Count;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc7_ = this.FGroupBattleData.FriendList.GetShadowPlayerByIndex(_loc3_);
               if(_loc7_.PlayerName == param2)
               {
                  this.FFilterFriendList.Add(_loc7_);
                  break;
               }
               _loc3_++;
            }
            if(this.FFilterFriendList.Count == 0)
            {
               FOnEffectText(STRING_GROUPBATTLE.STRING_SeekNoPlayer);
            }
            _loc8_ = this.FFilterFriendList;
         }
         else
         {
            _loc8_ = this.FGroupBattleData.FriendList;
         }
         _loc4_ = this.CAPACITY_PLAYERS;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FUIPlayers[_loc3_];
            _loc6_ = _loc3_ + this.CAPACITY_PLAYERS * this.FPageIndex;
            _loc7_ = _loc8_.GetShadowPlayerByIndex(_loc6_);
            _loc5_.Context = _loc7_;
            _loc5_.Update();
            _loc5_.Resource.visible = _loc7_ != null;
            _loc3_++;
         }
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FUIPage.TotalQuantity = this.FGroupBattleData.FriendList.Count;
         if(this.FUIPage.TotalQuantity == this.CAPACITY_PLAYERS)
         {
            this.FPageIndex = 0;
         }
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function ProcessorChooseOnClick(param1:Object, param2:uint, param3:uint, param4:uint) : void
      {
         if(this.FPermitFriendInviteOnClick != null)
         {
            this.FPermitFriendInviteOnClick(this,param2,param3,param4);
         }
      }
      
      protected function MCSeekOnClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = this.FTF_SeekPlayer.text;
         this.FTF_SeekPlayer.text == "";
         this.UpdateFriendUI(true,_loc2_);
      }
      
      protected function MCOptionOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc3_ = uint(this.FMC_Option.currentFrame);
         this.FMC_Option.gotoAndStop(_loc3_ % 2 + 1);
         _loc2_ = _loc3_ - 1;
         if(this.FPermitOrganizationOnClick != null)
         {
            this.FPermitOrganizationOnClick(this,_loc2_);
         }
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
         this.UpdateFriendUI();
      }
      
      protected function TFOnFocusIn(param1:FocusEvent) : void
      {
         var _loc2_:TextField = null;
         _loc2_ = param1.target as TextField;
         if(_loc2_.text == STRING_GROUPBATTLE.STRING_InputName)
         {
            _loc2_.text = "";
         }
      }
      
      protected function TFOnFocusOut(param1:FocusEvent) : void
      {
         var _loc2_:TextField = null;
         _loc2_ = param1.target as TextField;
         if(_loc2_.text == "")
         {
            this.FTF_SeekPlayer.text = STRING_GROUPBATTLE.STRING_InputName;
         }
      }
      
      public function set PermitOrganizationOnClick(param1:Function) : void
      {
         this.FPermitOrganizationOnClick = param1;
      }
      
      public function set PermitFriendInviteOnClick(param1:Function) : void
      {
         this.FPermitFriendInviteOnClick = param1;
      }
      
      public function Init(param1:MovieClip) : void
      {
         FMainUI = param1;
         this.Perform_UIDispatch();
         this.Perform_UILocations();
      }
      
      public function Update() : void
      {
         if(!Visible)
         {
            return;
         }
         this.UpdatePageInfo();
         this.UpdateUI();
         this.UpdateFriendUI();
      }
   }
}

