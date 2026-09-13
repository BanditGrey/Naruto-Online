package Processors.Game.Battle
{
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.Items.TItems;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MUSIC;
   import Resources.Constants.CONST_SIGNAL;
   import Resources.Strings.STRING_BATTLE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_OhtsutsukiKaguya;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TBattleResultWindow extends TProcessorLobbyWindow
   {
      
      protected static const MAX_COUNT:uint = 3;
      
      protected var FScene:MovieClip;
      
      protected var FReward:TItems;
      
      protected var FIsWin:Boolean;
      
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
      
      protected var FScore:int;
      
      public function TBattleResultWindow(param1:TUIComponent)
      {
         super(param1);
         this.InitBattleResultWindow();
      }
      
      protected function InitBattleResultWindow() : void
      {
         this.FHintBtn = new THint();
         TGameUtil.AddWindowMask(this,-448,-222);
         if(this.FScene == null)
         {
            this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_BATTLE.RESOURCE_ClassName_Result) as MovieClip;
            addChild(this.FScene);
         }
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
      
      protected function UpdataUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TArticle = null;
         if(this.FReward != null)
         {
            this.FScene.tf_exp_Copy.visible = false;
            if(this.FReward.Exp > 0)
            {
               _loc5_ = int(SLogicsCore.KaguyaData.RoleCurAtPosition);
               this.FScene.tf_exp.visible = true;
               if(_loc5_ != CONST_BATTLE.BattleType_Nodal || SLogicsCore.KaguyaData.OpenState == 0 || SLogicsCore.KaguyaData.IsLongTime == 7 || SLogicsCore.KaguyaData.CurLevel <= 1)
               {
                  this.FScene.tf_exp.text = STRING_COMMON.ITEMNAME_Exp + "+" + this.FReward.Exp;
               }
               else
               {
                  this.FScene.tf_exp.text = STRING_COMMON.ITEMNAME_Exp + "+" + (this.FReward.Exp - SLogicsCore.KaguyaData.GetExpByExp(this.FReward.Exp));
                  this.FScene.tf_exp_Copy.visible = true;
               }
               this.FScene.tf_exp_Copy.text = TUtilityString.Format(STRING_OhtsutsukiKaguya.Kagyu_,SLogicsCore.KaguyaData.GetExpByExp(this.FReward.Exp));
            }
            else if(this.FReward.Prestige > 0)
            {
               this.FScene.tf_exp.text = STRING_COMMON.ITEMNAME_Prestige + "+" + this.FReward.Prestige;
               this.FScene.tf_exp.visible = true;
            }
            else if(this.FReward.ReincarnatonScore != null)
            {
               this.FScene.tf_exp.text = this.FReward.ReincarnatonScore;
               this.FScene.tf_exp.visible = true;
            }
            else if(this.FReward.AwakenSoul != null)
            {
               this.FScene.tf_exp.text = this.FReward.AwakenSoul;
               this.FScene.tf_exp.visible = true;
            }
            else
            {
               this.FScene.tf_exp.visible = false;
               this.FScene.tf_exp_Copy.visible = false;
            }
            this.FScene.tf_money.visible = Boolean(this.FReward.Money > 0);
            if(this.FReward.Money > 0)
            {
               this.FScene.tf_money.text = STRING_COMMON.ITEMNAME_Coin + "+" + this.FReward.Money;
            }
            this.FScene.tf_soul.visible = Boolean(this.FReward.Soul > 0);
            if(this.FReward.Soul > 0)
            {
               this.FScene.tf_soul.text = STRING_COMMON.ITEMNAME_Soul + "+" + this.FReward.Soul;
            }
            this.FScene.tf_exp_Copy.visible = Boolean(this.FReward.ChallengeHurt > 0);
            if(this.FReward.ChallengeHurt > 0)
            {
               this.FScene.tf_exp_Copy.text = STRING_COMMON.ITEM_CHALLENGE_HURT + this.FReward.ChallengeHurt;
            }
            if(this.FScore != 0)
            {
               this.FScene.tf_exp.text = STRING_COMMON.ITEMNAME_Integral + (this.FScore > 0 ? "+" : "") + this.FScore;
               this.FScene.tf_exp.visible = true;
            }
            if(this.FReward.Items.length > 0)
            {
               _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,this.FReward.Items[0].ID) as TArticle;
               if(_loc6_ == null)
               {
                  return;
               }
               this.FScene.tf_exp.text = _loc6_.Name + "*" + this.FReward.Items[0].Count;
               this.FScene.tf_exp.visible = true;
            }
         }
      }
      
      protected function UpdatePopUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc2_ = _loc1_ + this.FShowIndex;
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
         this.FReward = null;
         this.FScore = 0;
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
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(param1)
         {
            this.FScene.mc_title.mc_title.gotoAndPlay(1);
            SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_SOUND,CONST_MUSIC.PLAY_SOUND_EFFECT,this.FIsWin ? int(CONST_BATTLE.SOUNDID_BATTLE_Win) : int(CONST_BATTLE.SOUNDID_BATTLE_Lost),true);
         }
      }
      
      public function SetWindow(param1:TItems, param2:Boolean = true, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) : void
      {
         this.FReward = param1;
         this.FIsWin = param2;
         this.FScene.btn_copy.visible = false;
         this.FScene.btn_replay.visible = param4;
         this.FScene.gotoAndStop(param2 ? 2 : 1);
         this.FIsAutoBattle = param5;
         if(this.FIsAutoBattle)
         {
            this.FAutoOutTimerId = setTimeout(this.OnAutoClose,5000);
         }
         this.UpdataUI();
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

