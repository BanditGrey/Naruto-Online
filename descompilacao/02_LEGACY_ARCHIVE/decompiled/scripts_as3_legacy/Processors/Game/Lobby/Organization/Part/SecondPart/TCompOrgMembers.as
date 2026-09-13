package Processors.Game.Lobby.Organization.Part.SecondPart
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityCartisian;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.TCharacter;
   import Logics.Characters.TDigest;
   import Logics.Characters.TFriendDigest;
   import Logics.Characters.TFriendDigests;
   import Logics.Organization.TBaseOrganization;
   import Logics.Organization.TBaseOrganizationMember;
   import Logics.SLogicsCore;
   import Logics.Spaces.*;
   import Processors.Game.Lobby.Chat.Window.TWindowCharacterSelectPopupMenu;
   import Processors.Game.Lobby.Organization.Component.TUIOrgMemberElement;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_FRIEND;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_ORGANIZATION;
   import Resources.Strings.STRING_CHAT;
   import Resources.Strings.STRING_ORGANIZATION;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.system.System;
   import flash.utils.ByteArray;
   
   use namespace LogicsSpace;
   
   public class TCompOrgMembers extends TUIComponent
   {
      
      public static const CHARACTER_SELECT_View:uint = CONST_ORGANIZATION.CHARACTER_SELECT_View;
      
      public static const CHARACTER_SELECT_Whisper:uint = CONST_ORGANIZATION.CHARACTER_SELECT_Whisper;
      
      public static const CHARACTER_SELECT_CopyName:uint = CONST_ORGANIZATION.CHARACTER_SELECT_CopyName;
      
      public static const CHARACTER_SELECT_Friend:uint = CONST_ORGANIZATION.CHARACTER_SELECT_Friend;
      
      public static const CHARACTER_SELECT_Kick:uint = CONST_ORGANIZATION.CHARACTER_SELECT_Kick;
      
      public static const WIDTH_WINDOW_Organization:Number = CONST_ORGANIZATION.STAGE_Width;
      
      public static const HEIGHT_WINDOW_Organization:Number = CONST_ORGANIZATION.STAGE_Height;
      
      protected static const TYPE_Whitelist_Add:uint = CONST_FRIEND.TYPE_Whitelist_Add;
      
      public static const STRING_AddWhitelistPrompt:String = STRING_CHAT.STRING_AddWhitelistPrompt;
      
      public static const TYPE_White:uint = CONST_FRIEND.TYPE_White;
      
      public static const SIX:int = 6;
      
      protected var FIsInitialization:Boolean;
      
      protected var FMC:MovieClip;
      
      protected var FMC_MemberList:MovieClip;
      
      protected var FMC_List:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FMC_ScrollBarContent:MovieClip;
      
      protected var FBInit:Boolean;
      
      protected var FData_MemberList:Vector.<TBaseOrganizationMember>;
      
      protected var FData_OrgBaseInfo:TBaseOrganization;
      
      protected var FMemberIDHigh:uint;
      
      protected var FMemberIDLow:uint;
      
      protected var FMemberName:String;
      
      protected var FWindowCharacterSelectPopupMenu:TWindowCharacterSelectPopupMenu;
      
      protected var FWindowConfirm:TUIWindowConfirmation;
      
      protected var FCharacter:TCharacter;
      
      protected var FFriends:TFriendDigests;
      
      protected var FCharacterDigest:TFriendDigest;
      
      protected var FDigst:TDigest;
      
      protected var FCurMcIndex:int;
      
      protected var FEffectText:Function;
      
      protected var FOnShowHeroInfo:Function;
      
      protected var FOnChatWhisper:Function;
      
      protected var FOnInterpersonalRelationships:Function;
      
      public function TCompOrgMembers(param1:TUIComponent)
      {
         super(param1);
         this.FBInit = false;
         this.FCharacter = SLogicsCore.Character;
         this.FFriends = SLogicsCore.Friends;
         this.FCharacterDigest = new TFriendDigest(0,0);
         this.FDigst = new TDigest(0,0);
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.FMC = param1;
         addChild(this.FMC);
         this.FMC_MemberList = this.FMC["MC_MemberList"];
         this.FMC_List = this.FMC_MemberList["mc_list"];
         this.FMC_ScrollBarContent = new MovieClip();
         this.FScrollBar = new TScrollBar(this.FMC_List,323,false,0,23);
         this.ConstructWindwoConfirmPopup();
         this.ConstructWindowCharacterSelectPopupMenu();
         this.addEventListenerWindowPopup();
         this.FBInit = true;
         _loc2_ = 0;
         while(_loc2_ < SIX)
         {
            _loc3_ = this.FMC_MemberList["MC_" + _loc2_];
            _loc3_.gotoAndStop(1);
            TGameUtil.setButtonMode(_loc3_["mc_"],true);
            _loc3_.addEventListener(MouseEvent.CLICK,this.MC_Click);
            _loc2_++;
         }
         this.FCurMcIndex = SIX;
      }
      
      protected function ConstructWindwoConfirmPopup() : void
      {
         this.FWindowConfirm = new TUIWindowConfirmation(this);
         this.FWindowConfirm.OnOK = this.ClickWindowConfirmOk;
         this.FWindowConfirm.X = (WIDTH_WINDOW_Organization - this.FWindowConfirm.WindowWidth) / 2;
         this.FWindowConfirm.Y = (HEIGHT_WINDOW_Organization - this.FWindowConfirm.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FWindowConfirm);
         this.FWindowConfirm.Visible = false;
      }
      
      protected function ConstructWindowCharacterSelectPopupMenu() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Sprite = null;
         _loc3_ = TUtilityReflection.CreateDisplayObjectInstance("MC_PopupMenuList") as Sprite;
         this.FWindowCharacterSelectPopupMenu = new TWindowCharacterSelectPopupMenu(this);
         this.FWindowCharacterSelectPopupMenu.OnSelect = this.PopupMenuCharacterSelectOnClick;
         this.FWindowCharacterSelectPopupMenu.SetSequenceButton(_loc3_);
         _loc2_ = 5;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FWindowCharacterSelectPopupMenu.SetChannelsUsable(_loc1_,true);
            _loc1_++;
         }
      }
      
      protected function addEventListenerWindowPopup() : void
      {
         FUICore.UIStage.addEventListener(MouseEvent.MOUSE_UP,this.WindowPopupHiderOnUp,false,0,true);
      }
      
      protected function ProcessorWindowPopupHider(param1:TUIComponent) : void
      {
         var _loc2_:Boolean = false;
         if(param1.Visible)
         {
            _loc2_ = this.HitWindowTest(param1);
            if(_loc2_)
            {
               return;
            }
            param1.Visible = false;
         }
      }
      
      protected function HitWindowTest(param1:TUIComponent) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:TCoordinate = null;
         var _loc4_:TBounds = null;
         _loc3_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(param1);
         _loc4_ = new TBounds();
         _loc4_.Assign(_loc3_);
         _loc4_.X = param1.Width;
         _loc4_.Y = param1.Height;
         return TUtilityCartisian.BoundsContainsCoordinate(_loc4_,FUICore.MouseCoordinate);
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUIOrgMemberElement = null;
         var _loc4_:MovieClip = null;
         if(this.FScrollBar == null)
         {
            return;
         }
         this.FScrollBar.Clear();
         _loc2_ = int(this.FData_MemberList.length);
         this.FData_MemberList.sort(this.SortOnOrgMemeberList);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUIOrgMemberElement(this);
            _loc3_.Perform_UIDispatch();
            _loc3_.ClickMemberElement = this.OnMemberClick;
            this.FScrollBar.AddItem(_loc3_);
            _loc3_.UpData(this.FData_MemberList[_loc1_],_loc1_);
            _loc3_.UpDateUI();
            _loc1_++;
         }
         this.FScrollBar.ScrollToUp();
         this.FScrollBar.Visible = true;
         _loc1_ = 0;
         while(_loc1_ < SIX)
         {
            _loc4_ = this.FMC_MemberList["MC_" + _loc1_];
            _loc4_.gotoAndStop(1);
            TGameUtil.setButtonMode(_loc4_["mc_"],true);
            _loc1_++;
         }
      }
      
      protected function MC_Click(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_MemberList["MC_0"]:
               this.WoCao(0);
               break;
            case this.FMC_MemberList["MC_1"]:
               this.WoCao(1);
               break;
            case this.FMC_MemberList["MC_2"]:
               this.WoCao(2);
               break;
            case this.FMC_MemberList["MC_3"]:
               this.WoCao(3);
               break;
            case this.FMC_MemberList["MC_4"]:
               this.WoCao(4);
               break;
            case this.FMC_MemberList["MC_5"]:
               this.WoCao(5);
         }
      }
      
      protected function WoCao(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = 0;
         while(_loc2_ < SIX)
         {
            _loc3_ = this.FMC_MemberList["MC_" + _loc2_];
            _loc3_.gotoAndStop(1);
            TGameUtil.setButtonMode(_loc3_["mc_"],true);
            _loc2_++;
         }
         _loc3_ = this.FMC_MemberList["MC_" + param1];
         _loc3_.gotoAndStop(2);
         TGameUtil.setButtonMode(_loc3_["mc_"],true);
         this.FScrollBar.Items.sort(this["Sort_" + param1]);
         this.FScrollBar.AgainRefresh();
         this.FScrollBar.ScrollToUp();
      }
      
      protected function Sort_5(param1:DisplayObject, param2:DisplayObject) : Number
      {
         if(TUIOrgMemberElement(param1).Data_Member.LastLogginTime < TUIOrgMemberElement(param2).Data_Member.LastLogginTime)
         {
            return 1;
         }
         if(TUIOrgMemberElement(param1).Data_Member.LastLogginTime > TUIOrgMemberElement(param2).Data_Member.LastLogginTime)
         {
            return -1;
         }
         return 0;
      }
      
      protected function Sort_4(param1:DisplayObject, param2:DisplayObject) : Number
      {
         if(TUIOrgMemberElement(param1).Data_Member.TotalContribution < TUIOrgMemberElement(param2).Data_Member.TotalContribution)
         {
            return 1;
         }
         if(TUIOrgMemberElement(param1).Data_Member.TotalContribution > TUIOrgMemberElement(param2).Data_Member.TotalContribution)
         {
            return -1;
         }
         return 0;
      }
      
      protected function Sort_3(param1:DisplayObject, param2:DisplayObject) : Number
      {
         if(TUIOrgMemberElement(param1).Data_Member.TodayContribution < TUIOrgMemberElement(param2).Data_Member.TodayContribution)
         {
            return 1;
         }
         if(TUIOrgMemberElement(param1).Data_Member.TodayContribution > TUIOrgMemberElement(param2).Data_Member.TodayContribution)
         {
            return -1;
         }
         return 0;
      }
      
      protected function Sort_2(param1:DisplayObject, param2:DisplayObject) : Number
      {
         if(TUIOrgMemberElement(param1).Data_Member.OrgDuties < TUIOrgMemberElement(param2).Data_Member.OrgDuties)
         {
            return 1;
         }
         if(TUIOrgMemberElement(param1).Data_Member.OrgDuties > TUIOrgMemberElement(param2).Data_Member.OrgDuties)
         {
            return -1;
         }
         return 0;
      }
      
      protected function Sort_1(param1:DisplayObject, param2:DisplayObject) : Number
      {
         if(TUIOrgMemberElement(param1).Data_Member.PlayerLevel < TUIOrgMemberElement(param2).Data_Member.PlayerLevel)
         {
            return 1;
         }
         if(TUIOrgMemberElement(param1).Data_Member.PlayerLevel > TUIOrgMemberElement(param2).Data_Member.PlayerLevel)
         {
            return -1;
         }
         return 0;
      }
      
      protected function Sort_0(param1:DisplayObject, param2:DisplayObject) : Number
      {
         if(TUIOrgMemberElement(param1).Data_Member.Rank < TUIOrgMemberElement(param2).Data_Member.Rank)
         {
            return -1;
         }
         if(TUIOrgMemberElement(param1).Data_Member.Rank > TUIOrgMemberElement(param2).Data_Member.Rank)
         {
            return 1;
         }
         return 0;
      }
      
      protected function SortOnOrgMemeberList(param1:TBaseOrganizationMember, param2:TBaseOrganizationMember) : Number
      {
         if(param1.OrgDuties < param2.OrgDuties)
         {
            return 1;
         }
         if(param1.OrgDuties > param2.OrgDuties)
         {
            return -1;
         }
         if(param1.TotalContribution < param2.TotalContribution)
         {
            return 1;
         }
         if(param1.TotalContribution > param2.TotalContribution)
         {
            return -1;
         }
         if(param1.PlayerLevel < param2.PlayerLevel)
         {
            return 1;
         }
         if(param1.PlayerLevel > param2.PlayerLevel)
         {
            return -1;
         }
         if(param1.Rank < param2.Rank)
         {
            return 1;
         }
         if(param1.Rank > param2.Rank)
         {
            return -1;
         }
         return 0;
      }
      
      protected function ProcessorInterpersonalRelationshipsByCharacter() : void
      {
         var _loc1_:TFriendDigest = null;
         _loc1_ = this.FFriends.GetDigestByIdentifier(this.FCharacterDigest.Identifier0,this.FCharacterDigest.Identifier1);
         if(_loc1_ != null && _loc1_.Type != TYPE_White)
         {
            this.FEffectText(STRING_AddWhitelistPrompt);
         }
         else if(this.FOnInterpersonalRelationships != null)
         {
            this.FOnInterpersonalRelationships(this,TYPE_Whitelist_Add,this.FCharacterDigest);
         }
      }
      
      protected function PerformPacket_CS_KickMemberReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_KickMemberReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(this.FMemberIDHigh);
         _loc2_.writeUnsignedInt(this.FMemberIDLow);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function OnMemberClick(param1:Object, param2:uint, param3:uint, param4:String) : void
      {
         var _loc5_:TUIOrgMemberElement = null;
         if(param2 == SLogicsCore.Character.Identifier0 && param3 == SLogicsCore.Character.Identifier1)
         {
            return;
         }
         _loc5_ = param1 as TUIOrgMemberElement;
         this.FWindowCharacterSelectPopupMenu.X = mouseX;
         this.FWindowCharacterSelectPopupMenu.Y = mouseY;
         this.FWindowCharacterSelectPopupMenu.Visible = true;
         this.FMemberIDHigh = param2;
         this.FMemberIDLow = param3;
         this.FMemberName = param4;
      }
      
      protected function PopupMenuCharacterSelectOnClick(param1:Object, param2:uint) : void
      {
         switch(param2)
         {
            case CHARACTER_SELECT_View:
               if(this.FOnShowHeroInfo != null)
               {
                  this.FOnShowHeroInfo(this,this.FMemberIDHigh,this.FMemberIDLow);
               }
               break;
            case CHARACTER_SELECT_Whisper:
               this.FDigst.Coerce(this.FMemberIDHigh,this.FMemberIDLow);
               this.FDigst.Name = this.FMemberName;
               if(this.FOnChatWhisper != null)
               {
                  this.FOnChatWhisper(this,this.FDigst);
               }
               break;
            case CHARACTER_SELECT_CopyName:
               System.setClipboard(this.FMemberName);
               break;
            case CHARACTER_SELECT_Friend:
               this.FCharacterDigest.Coerce(this.FMemberIDHigh,this.FMemberIDLow);
               this.FCharacterDigest.Tag = TYPE_Whitelist_Add;
               this.ProcessorInterpersonalRelationshipsByCharacter();
               break;
            case CHARACTER_SELECT_Kick:
               if(this.FData_OrgBaseInfo.OrgPower != 2)
               {
                  if(this.FEffectText != null)
                  {
                     this.FEffectText(STRING_ORGANIZATION.STRING_NoMasterPrompt);
                  }
                  return;
               }
               this.FWindowConfirm.Text = STRING_ORGANIZATION.STRING_ConfirmPrompt + this.FMemberName + STRING_ORGANIZATION.STRING_KickMemberPrompt;
               this.FWindowConfirm.Visible = true;
         }
      }
      
      protected function ClickWindowConfirmOk(param1:Object) : void
      {
         this.PerformPacket_CS_KickMemberReq();
      }
      
      protected function WindowPopupHiderOnUp(param1:MouseEvent) : void
      {
         this.ProcessorWindowPopupHider(this.FWindowCharacterSelectPopupMenu);
      }
      
      public function get EffectText() : Function
      {
         return this.FEffectText;
      }
      
      public function set EffectText(param1:Function) : void
      {
         this.FEffectText = param1;
      }
      
      public function get OnShowHeroInfo() : Function
      {
         return this.FOnShowHeroInfo;
      }
      
      public function set OnShowHeroInfo(param1:Function) : void
      {
         this.FOnShowHeroInfo = param1;
      }
      
      public function get OnChatWhisper() : Function
      {
         return this.FOnChatWhisper;
      }
      
      public function set OnChatWhisper(param1:Function) : void
      {
         this.FOnChatWhisper = param1;
      }
      
      public function get OnInterpersonalRelationships() : Function
      {
         return this.FOnInterpersonalRelationships;
      }
      
      public function set OnInterpersonalRelationships(param1:Function) : void
      {
         this.FOnInterpersonalRelationships = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FIsInitialization = true;
      }
      
      public function UpData(param1:Vector.<TBaseOrganizationMember>, param2:TBaseOrganization) : void
      {
         this.FData_MemberList = param1;
         this.FData_OrgBaseInfo = param2;
      }
      
      public function UpDateUI() : void
      {
         this.UpdateUI();
      }
      
      public function LogicsPerform() : void
      {
         if(this.FBInit)
         {
            this.FWindowCharacterSelectPopupMenu.Update();
         }
      }
   }
}

