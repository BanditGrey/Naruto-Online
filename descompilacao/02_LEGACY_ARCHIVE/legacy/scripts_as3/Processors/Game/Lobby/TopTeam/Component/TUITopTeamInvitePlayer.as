package Processors.Game.Lobby.TopTeam.Component
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.GroupBattle.TInviteShadow;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUITopTeamInvitePlayer extends TProcessorUIResourceTemplate
   {
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_FightPower:TextField;
      
      protected var FBTN_Invite:MovieClip;
      
      protected var FInviteOnClick:Function;
      
      public function TUITopTeamInvitePlayer(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function UIDispatch() : void
      {
         this.FTF_Name = FResource["TF_Name"];
         this.FTF_Level = FResource["TF_Level"];
         this.FTF_FightPower = FResource["TF_FightPower"];
         this.FBTN_Invite = FResource["BTN_Invite"];
         TGameUtil.setButtonMode(this.FBTN_Invite,true);
         super.UIDispatch();
      }
      
      override protected function UILocations() : void
      {
         this.FBTN_Invite.addEventListener(MouseEvent.CLICK,this.BTNInviteOnClick,false,0,true);
         super.UILocations();
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:TInviteShadow = null;
         if(FContext == null)
         {
            return;
         }
         _loc1_ = FContext as TInviteShadow;
         this.FTF_Name.text = _loc1_.PlayerName;
         this.FTF_Level.text = STRING_COMMON.FORMAT_Level + _loc1_.PlayerLevel.toString();
         this.FTF_FightPower.text = _loc1_.FightPower.ToString();
      }
      
      protected function BTNInviteOnClick(param1:MouseEvent) : void
      {
         if(this.FInviteOnClick != null)
         {
            this.FInviteOnClick(this,FContext);
         }
      }
      
      public function set InviteOnClick(param1:Function) : void
      {
         this.FInviteOnClick = param1;
      }
   }
}

