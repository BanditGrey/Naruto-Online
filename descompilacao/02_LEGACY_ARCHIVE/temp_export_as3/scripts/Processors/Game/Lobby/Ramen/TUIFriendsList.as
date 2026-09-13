package Processors.Game.Lobby.Ramen
{
   import Foundation.UI.TUIComponent;
   import Logics.Characters.TFriendDigest;
   import Logics.Ramn.TFriendRamenData;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_RAMEN;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIFriendsList extends TUIComponent
   {
      
      protected var FSubstrate:MovieClip;
      
      protected var FTF_FriendName:TextField;
      
      protected var FMC_Home:MovieClip;
      
      protected var FTF_FriendLevel:TextField;
      
      protected var FMC_GoodsIcon:MovieClip;
      
      protected var FFriendRamen:TFriendRamenData;
      
      protected var FSelectFriend:Function;
      
      public function TUIFriendsList(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FSubstrate = param1;
         this.FTF_FriendName = this.FSubstrate[CONST_RAMEN.RESOURCE_Link_TF_FriendName];
         this.FMC_Home = this.FSubstrate[CONST_RAMEN.RESOURCE_Link_MC_Home];
         this.FTF_FriendLevel = this.FSubstrate[CONST_RAMEN.RESOURCE_Link_TF_FriendLevel];
         this.FMC_GoodsIcon = this.FSubstrate[CONST_RAMEN.RESOURCE_Link_MC_GoodsIcon];
         this.FSubstrate.addEventListener(MouseEvent.CLICK,this.ListOnClick);
      }
      
      protected function ListOnClick(param1:MouseEvent) : void
      {
         if(this.FSelectFriend != null)
         {
            this.FSelectFriend(this,this.FFriendRamen);
         }
         this.FSubstrate.gotoAndStop(3);
      }
      
      public function get SelectFriend() : Function
      {
         return this.FSelectFriend;
      }
      
      public function set SelectFriend(param1:Function) : void
      {
         this.FSelectFriend = param1;
      }
      
      public function get FriendData() : TFriendRamenData
      {
         return this.FFriendRamen;
      }
      
      override public function get Visible() : Boolean
      {
         if(this.FSubstrate == null)
         {
            return false;
         }
         return this.FSubstrate.visible;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         if(this.FSubstrate != null)
         {
            this.FSubstrate.visible = param1;
         }
      }
      
      public function ResourcesUIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
      }
      
      public function SetSendGood(param1:Boolean) : void
      {
         this.FMC_GoodsIcon.visible = param1;
      }
      
      public function IsSelect(param1:Boolean) : void
      {
         this.FSubstrate.gotoAndStop(param1 ? 3 : 1);
      }
      
      public function SetFriendData(param1:TFriendRamenData, param2:TFriendDigest) : void
      {
         this.FFriendRamen = param1;
         this.FTF_FriendName.text = param2.Name;
         this.FMC_Home.gotoAndStop(param2.Country);
         this.FMC_Home.visible = Boolean(param2.Country != 0);
         this.FTF_FriendLevel.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(param2.Level);
         this.FMC_GoodsIcon.visible = Boolean(param1.FriendRamenSendGoodsCount <= 0);
      }
   }
}

