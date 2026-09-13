package Processors.Game.Lobby.Friends.Components
{
   import Foundation.UI.*;
   import Foundation.Utilities.TGameUtil;
   import Logics.Characters.*;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_FRIEND;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   
   public class TUIItem extends TUIComponent
   {
      
      protected static const RENDERINGSTATE_Substrate:int = 1;
      
      protected static const RENDERINGSTATE_Alternation:int = 2;
      
      protected static const RENDERINGSTATE_Normal:int = 1;
      
      protected static const RENDERINGSTATE_Hovering:int = 2;
      
      public static const RESOURCE_Link_TF_Nickname:String = CONST_FRIEND.RESOURCE_Link_TF_Nickname;
      
      public static const RESOURCE_Link_MC_CountryIconMountPoint:String = CONST_FRIEND.RESOURCE_Link_MC_CountryIconMountPoint;
      
      public static const RESOURCE_Link_TF_Level:String = CONST_FRIEND.RESOURCE_Link_TF_Level;
      
      public static const RESOURCE_Link_Btn_Whisper:String = CONST_FRIEND.RESOURCE_Link_Btn_Whisper;
      
      public static const RESOURCE_Link_Btn_Mail:String = CONST_FRIEND.RESOURCE_Link_Btn_Mail;
      
      public static const RESOURCE_Link_Btn_Delete:String = CONST_FRIEND.RESOURCE_Link_Btn_Delete;
      
      public static const RESOURCE_Link_Btn_Add:String = CONST_FRIEND.RESOURCE_Link_Btn_Add;
      
      public static const RESOURCE_Link_Btn_Fight:String = CONST_FRIEND.RESOURCE_Link_Btn_Fight;
      
      public static const RESOURCE_Link_Btn_TiLi:String = CONST_FRIEND.RESOURCE_Link_Btn_TiLi;
      
      protected var FSubstrate:MovieClip;
      
      protected var FMC_Listitem:MovieClip;
      
      protected var FTFNickname:TextField;
      
      protected var FCountryIcon:MovieClip;
      
      protected var FTFLevel:TextField;
      
      protected var FBtnWhisper:SimpleButton;
      
      protected var FBtnMail:SimpleButton;
      
      protected var FBtnDelete:SimpleButton;
      
      protected var FBtnAdd:SimpleButton;
      
      protected var FBtnFight:MovieClip;
      
      protected var FMC_GiveTiLi:MovieClip;
      
      protected var FIsInitialization:Boolean;
      
      protected var FFilter:Array;
      
      protected var FFightStatus:Boolean;
      
      protected var FContext:TFriendDigest;
      
      protected var FOnWhisper:Function;
      
      protected var FOnMail:Function;
      
      protected var FOnDelete:Function;
      
      protected var FOnAdd:Function;
      
      protected var FOnFight:Function;
      
      protected var FOnGiveTiLi:Function;
      
      public function TUIItem(param1:TUIComponent)
      {
         super(param1);
         this.FIsInitialization = false;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip, param2:MovieClip) : void
      {
         this.FSubstrate = param1;
         this.FMC_Listitem = param2;
         this.FTFNickname = this.FMC_Listitem[RESOURCE_Link_TF_Nickname];
         this.FFilter = this.FTFNickname.filters;
         this.FCountryIcon = this.FMC_Listitem[RESOURCE_Link_MC_CountryIconMountPoint];
         this.FTFLevel = this.FMC_Listitem[RESOURCE_Link_TF_Level];
         this.FBtnWhisper = this.FMC_Listitem[RESOURCE_Link_Btn_Whisper];
         this.FBtnMail = this.FMC_Listitem[RESOURCE_Link_Btn_Mail];
         this.FBtnDelete = this.FMC_Listitem[RESOURCE_Link_Btn_Delete];
         this.FBtnAdd = this.FMC_Listitem[RESOURCE_Link_Btn_Add];
         this.FBtnFight = this.FMC_Listitem[RESOURCE_Link_Btn_Fight];
         this.FMC_GiveTiLi = this.FMC_Listitem[RESOURCE_Link_Btn_TiLi];
         this.FFightStatus = true;
         TGameUtil.setButtonMode(this.FBtnFight,this.FFightStatus);
         this.FCountryIcon.visible = false;
         if(SLogicsCore.Character.GetConfigValueById(91000006))
         {
            if(this.FMC_GiveTiLi)
            {
               this.FMC_GiveTiLi.visible = true;
            }
         }
         else if(this.FMC_GiveTiLi)
         {
            this.FMC_GiveTiLi.visible = false;
         }
      }
      
      protected function Resources_UILocations() : void
      {
         this.FMC_Listitem.addEventListener(MouseEvent.MOUSE_OVER,this.ListitemOnOver,false,0,true);
         this.FMC_Listitem.addEventListener(MouseEvent.MOUSE_OUT,this.ListitemOnOut,false,0,true);
         if(this.FBtnWhisper != null)
         {
            this.FBtnWhisper.addEventListener(MouseEvent.CLICK,this.BtnWhisperOnClick,false,0,true);
         }
         if(this.FBtnMail != null)
         {
            this.FBtnMail.addEventListener(MouseEvent.CLICK,this.BtnMailOnClick,false,0,true);
         }
         if(this.FBtnDelete != null)
         {
            this.FBtnDelete.addEventListener(MouseEvent.CLICK,this.BtnDeleteOnClick,false,0,true);
         }
         if(this.FBtnAdd != null)
         {
            this.FBtnAdd.addEventListener(MouseEvent.CLICK,this.BtnAddOnClick,false,0,true);
         }
         if(this.FBtnFight != null)
         {
            this.FBtnFight.addEventListener(MouseEvent.CLICK,this.BtnFightOnClick,false,0,true);
         }
         if(this.FMC_GiveTiLi != null)
         {
            this.FMC_GiveTiLi.addEventListener(MouseEvent.CLICK,this.BtnGiveTiLiOnClick,false,0,true);
         }
      }
      
      protected function Initialization() : void
      {
         var _loc1_:uint = 0;
         if(FTag % 2 == 0)
         {
            _loc1_ = uint(RENDERINGSTATE_Substrate);
         }
         else
         {
            _loc1_ = uint(RENDERINGSTATE_Alternation);
         }
         this.FSubstrate.gotoAndStop(_loc1_);
      }
      
      protected function UpdateItem() : void
      {
         var _loc1_:uint = 0;
         this.FTFNickname.text = this.FContext.Name;
         this.FTFLevel.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(this.FContext.Level);
         _loc1_ = this.FContext.Country;
         if(_loc1_ != 0)
         {
            this.FCountryIcon.gotoAndStop(this.FContext.Country);
            this.FCountryIcon.visible = true;
         }
         else
         {
            this.FCountryIcon.visible = false;
         }
         if(this.FContext.IsOnline)
         {
            this.FTFNickname.filters = this.FFilter;
            if(this.FBtnWhisper != null)
            {
               this.FBtnWhisper.mouseEnabled = true;
               this.FBtnWhisper.filters = [];
            }
         }
         else
         {
            this.FTFNickname.filters = [TGameUtil.GaryColorFilters];
            if(this.FBtnWhisper != null)
            {
               this.FBtnWhisper.mouseEnabled = false;
               this.FBtnWhisper.filters = [TGameUtil.GaryColorFilters];
            }
         }
      }
      
      protected function ListitemOnOver(param1:MouseEvent) : void
      {
         this.FMC_Listitem.gotoAndStop(RENDERINGSTATE_Hovering);
      }
      
      protected function ListitemOnOut(param1:MouseEvent) : void
      {
         this.FMC_Listitem.gotoAndStop(RENDERINGSTATE_Normal);
      }
      
      protected function BtnWhisperOnClick(param1:MouseEvent) : void
      {
         if(this.FOnWhisper != null)
         {
            this.FOnWhisper(this,this.FContext);
         }
      }
      
      protected function BtnMailOnClick(param1:MouseEvent) : void
      {
         if(this.FOnMail != null)
         {
            this.FOnMail(this,this.FContext);
         }
      }
      
      protected function BtnDeleteOnClick(param1:MouseEvent) : void
      {
         if(this.FOnDelete != null)
         {
            this.FOnDelete(this,this.FContext);
         }
      }
      
      protected function BtnAddOnClick(param1:MouseEvent) : void
      {
         if(this.FOnAdd != null)
         {
            this.FOnAdd(this,this.FContext);
         }
      }
      
      protected function BtnFightOnClick(param1:MouseEvent) : void
      {
         if(Boolean(param1.target) && !param1.target.buttonMode)
         {
            return;
         }
         if(this.FOnFight != null)
         {
            this.FOnFight(this,this.FContext);
         }
      }
      
      protected function BtnGiveTiLiOnClick(param1:MouseEvent) : void
      {
         if(Boolean(param1.target) && !param1.target.buttonMode)
         {
            return;
         }
         if(this.FOnGiveTiLi != null)
         {
            this.FOnGiveTiLi(this.FContext);
         }
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         this.Visible = param1;
         this.FMC_Listitem.visible = param1;
      }
      
      public function SetFightStatus(param1:Boolean) : void
      {
         if(this.FFightStatus != param1)
         {
            this.FFightStatus = param1;
            TGameUtil.setButtonMode(this.FBtnFight,this.FFightStatus);
         }
      }
      
      public function UpdateGiveBtnState() : void
      {
         if(!this.FContext)
         {
            return;
         }
         var _loc1_:TFriendDigestTiLi = null;
         _loc1_ = SLogicsCore.Friends.GetTiLiFriendById(this.FContext.Identifier0,this.FContext.Identifier1);
         if(_loc1_)
         {
            TGameUtil.setButtonMode(this.FMC_GiveTiLi,false);
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_GiveTiLi,true);
         }
      }
      
      public function get Context() : TFriendDigest
      {
         return this.FContext;
      }
      
      public function set Context(param1:TFriendDigest) : void
      {
         this.FContext = param1;
         this.UpdateItem();
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
      
      public function get OnDelete() : Function
      {
         return this.FOnDelete;
      }
      
      public function set OnDelete(param1:Function) : void
      {
         this.FOnDelete = param1;
      }
      
      public function get OnAdd() : Function
      {
         return this.FOnAdd;
      }
      
      public function set OnAdd(param1:Function) : void
      {
         this.FOnAdd = param1;
      }
      
      public function get OnFight() : Function
      {
         return this.FOnFight;
      }
      
      public function set OnFight(param1:Function) : void
      {
         this.FOnFight = param1;
      }
      
      public function get OnGiveTiLi() : Function
      {
         return this.FOnGiveTiLi;
      }
      
      public function set OnGiveTiLi(param1:Function) : void
      {
         this.FOnGiveTiLi = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip, param2:MovieClip) : void
      {
         this.Resources_UIDispatch(param1,param2);
         this.Resources_UILocations();
         this.FIsInitialization = true;
      }
      
      public function Init() : void
      {
         if(!this.FIsInitialization)
         {
            return;
         }
         this.Initialization();
      }
   }
}

