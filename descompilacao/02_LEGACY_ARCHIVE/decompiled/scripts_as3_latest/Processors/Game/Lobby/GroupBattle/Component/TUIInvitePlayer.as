package Processors.Game.Lobby.GroupBattle.Component
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.GroupBattle.TInviteShadow;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_GROUPBATTLE;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIInvitePlayer extends TProcessorUIResourceTemplate
   {
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_FightPower:TextField;
      
      protected var FTF_CDTime:TextField;
      
      protected var FBTN_Invite:MovieClip;
      
      protected var FCDTime:uint;
      
      protected var FInviteOnClick:Function;
      
      public function TUIInvitePlayer(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function UIDispatch() : void
      {
         this.FTF_Name = FResource["TF_Name"];
         this.FTF_Level = FResource["TF_Level"];
         this.FTF_FightPower = FResource["TF_FightPower"];
         this.FTF_CDTime = FResource["TF_CDTime"];
         this.FBTN_Invite = FResource["BTN_Invite"];
         TGameUtil.setButtonMode(this.FBTN_Invite,true);
         super.UIDispatch();
      }
      
      override protected function UILocations() : void
      {
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SHADOW_COOLDOWN) as TConfigValue;
         this.FCDTime = _loc1_.Value as uint;
         this.FBTN_Invite.addEventListener(MouseEvent.CLICK,this.BTNInviteOnClick,false,0,true);
         super.UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:TInviteShadow = null;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         super.LogicsPerform();
         if(!this.Parent.Visible)
         {
            return;
         }
         if(FContext != null)
         {
            _loc1_ = FContext as TInviteShadow;
            if(_loc1_.LeftInviteTImes == 0)
            {
               TGameUtil.setButtonMode(this.FBTN_Invite,false);
               this.FBTN_Invite.mouseEnabled = false;
               this.FTF_CDTime.text = STRING_GROUPBATTLE.STRING_InviteUseless;
            }
            else
            {
               _loc2_ = _loc1_.CDTime + this.FCDTime - STimingCore.GetServerTime();
               if(_loc2_ <= 0)
               {
                  _loc2_ = 0;
               }
               this.FTF_CDTime.text = TGameUtil.fomatTime(_loc2_);
               _loc3_ = !Boolean(_loc2_);
               if(_loc3_ != this.FBTN_Invite.mouseEnabled)
               {
                  TGameUtil.setButtonMode(this.FBTN_Invite,_loc3_);
                  this.FBTN_Invite.mouseEnabled = _loc3_;
               }
            }
         }
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
         this.FTF_Level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc1_.PlayerLevel);
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

