package Processors.Game.Battle
{
   import Foundation.Common.THint;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_MUSIC;
   import Resources.Constants.CONST_SIGNAL;
   import Resources.Strings.STRING_BATTLE;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TBattleLostWindow extends TProcessorLobbyWindow
   {
      
      protected static const MAX_COUNT:uint = 3;
      
      protected var FScene:MovieClip;
      
      protected var FHintBtn:THint;
      
      protected var FShowIndex:uint;
      
      protected var FShowMax:uint;
      
      protected var FShowData:Vector.<uint>;
      
      protected var FIsAutoBattle:Boolean;
      
      protected var FAutoOutTimerId:uint;
      
      protected var FClickCallBack:Function;
      
      protected var FReplayCallBack:Function;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      public function TBattleLostWindow(param1:TUIComponent)
      {
         super(param1);
         this.InitBattleLostWindow();
      }
      
      protected function InitBattleLostWindow() : void
      {
         this.FHintBtn = new THint();
         TGameUtil.AddWindowMask(this,-448,-189);
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_BATTLE.RESOURCE_ClassName_Lost) as MovieClip;
         addChild(this.FScene);
         TGameUtil.setButtonMode(this.FScene.btn_ok,true);
         this.FScene.btn_ok.addEventListener(MouseEvent.MOUSE_UP,this.OnOutBattle);
         this.FScene.btn_copy.addEventListener(MouseEvent.MOUSE_UP,this.OnCopyBattle);
         this.FScene.btn_replay.addEventListener(MouseEvent.MOUSE_UP,this.OnReplayBattle);
         this.FScene.btn_copy.addEventListener(MouseEvent.MOUSE_MOVE,this.Btn_CopyOnMove,false,0,true);
         this.FScene.btn_copy.addEventListener(MouseEvent.MOUSE_OUT,this.Btn_OnOut,false,0,true);
         this.FScene.btn_replay.addEventListener(MouseEvent.MOUSE_MOVE,this.Btn_ReplayOnMove,false,0,true);
         this.FScene.btn_replay.addEventListener(MouseEvent.MOUSE_OUT,this.Btn_OnOut,false,0,true);
         TGameUtil.setButtonMode(this.FScene.btn_left,true);
         this.FScene.btn_left.addEventListener(MouseEvent.CLICK,this.OnLeftClick);
         TGameUtil.setButtonMode(this.FScene.btn_right,true);
         this.FScene.btn_right.addEventListener(MouseEvent.CLICK,this.OnRightClick);
      }
      
      protected function UpdatePopUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc2_ = _loc1_ + this.FShowIndex * MAX_COUNT;
            if(_loc2_ < this.FShowData.length)
            {
               this.FScene["MC_UpgradeAbility_" + _loc1_].gotoAndStop(this.FShowData[_loc2_]);
               this.FScene["MC_UpgradeAbility_" + _loc1_].visible = true;
            }
            else
            {
               this.FScene["MC_UpgradeAbility_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function CheckBtn() : void
      {
         this.FScene.btn_left.visible = Boolean(this.FShowIndex != 0);
         this.FScene.btn_right.visible = Boolean(this.FShowIndex != this.FShowMax);
      }
      
      protected function OnOutBattle(param1:MouseEvent = null) : void
      {
         this.visible = false;
         if(this.FIsAutoBattle)
         {
            clearTimeout(this.FAutoOutTimerId);
         }
         if(this.FClickCallBack != null)
         {
            this.FClickCallBack(this);
         }
      }
      
      protected function OnCopyBattle(param1:MouseEvent) : void
      {
      }
      
      protected function OnReplayBattle(param1:MouseEvent) : void
      {
         this.visible = false;
         if(this.FReplayCallBack != null)
         {
            this.FReplayCallBack(this);
         }
      }
      
      protected function Btn_CopyOnMove(param1:MouseEvent) : void
      {
         if(this.FHintOnMove != null)
         {
            this.FHintBtn.Caption = STRING_BATTLE.STRINGS_BattleBtnTip_Copy;
            this.FHintOnMove(param1,this.FHintBtn);
         }
      }
      
      protected function Btn_ReplayOnMove(param1:MouseEvent) : void
      {
         if(this.FHintOnMove != null)
         {
            this.FHintBtn.Caption = STRING_BATTLE.STRINGS_BattleBtnTip_Replay;
            this.FHintOnMove(param1,this.FHintBtn);
         }
      }
      
      protected function Btn_OnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(param1);
         }
      }
      
      protected function OnLeftClick(param1:MouseEvent) : void
      {
         --this.FShowIndex;
         if(this.FShowIndex < 0)
         {
            this.FShowIndex = 0;
         }
         this.CheckBtn();
         this.UpdatePopUI();
      }
      
      protected function OnRightClick(param1:MouseEvent) : void
      {
         ++this.FShowIndex;
         if(this.FShowIndex >= this.FShowMax)
         {
            this.FShowIndex = this.FShowMax;
         }
         this.CheckBtn();
         this.UpdatePopUI();
      }
      
      protected function OnAutoClose() : void
      {
         this.OnOutBattle();
      }
      
      public function set ClickCallBack(param1:Function) : void
      {
         this.FClickCallBack = param1;
      }
      
      public function get ClickCallBack() : Function
      {
         return this.FClickCallBack;
      }
      
      public function set ReplayCallBack(param1:Function) : void
      {
         this.FReplayCallBack = param1;
      }
      
      public function get ReplayCallBack() : Function
      {
         return this.FReplayCallBack;
      }
      
      public function set HintOnMove(param1:Function) : void
      {
         this.FHintOnMove = param1;
      }
      
      public function get HintOnMove() : Function
      {
         return this.FHintOnMove;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(param1)
         {
            this.FScene.mc_title.mc_title.gotoAndPlay(1);
            SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_SOUND,CONST_MUSIC.PLAY_SOUND_EFFECT,CONST_BATTLE.SOUNDID_BATTLE_Lost,true);
         }
      }
      
      public function SetWindow(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false) : void
      {
         this.FScene.tf_info.text = param1;
         this.FScene.btn_copy.visible = false;
         this.FScene.btn_replay.visible = param3;
         this.FIsAutoBattle = param4;
         if(this.FIsAutoBattle)
         {
            this.FAutoOutTimerId = setTimeout(this.OnAutoClose,5000);
         }
      }
      
      public function SetLostShowData(param1:Vector.<uint>) : void
      {
         this.FShowData = param1;
         this.FShowMax = Math.max(Math.ceil(this.FShowData.length / MAX_COUNT) - 1,0);
         this.FShowIndex = 0;
         this.CheckBtn();
         this.UpdatePopUI();
      }
      
      public function SetShowReplay(param1:Boolean) : void
      {
         this.FScene.btn_replay.visible = param1;
      }
   }
}

