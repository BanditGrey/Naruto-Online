package Processors.Game.Battle
{
   import Components.Slots.*;
   import Foundation.Common.THint;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Globalboss.*;
   import Logics.Inventories.*;
   import Logics.Items.*;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Items.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Taboo.Data.TabooDataCell;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TBattleWinWindow extends TProcessorLobbyWindow
   {
      
      public static const MAX_COUNT:int = 3;
      
      public static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var FScene:MovieClip;
      
      protected var FReward:TItems;
      
      protected var FCurPage:int;
      
      protected var FTotlePage:int;
      
      protected var FUISlots:Vector.<TUISlotCopy>;
      
      protected var FArticle:TBins;
      
      protected var FIDTemplates:Vector.<uint>;
      
      protected var FQualityTemplates:Vector.<uint>;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FHintBtn:THint;
      
      protected var FVecTabooCell:Vector.<TabooDataCell>;
      
      protected var FIsAutoBattle:Boolean;
      
      protected var FAutoOutTimerId:uint;
      
      protected var FClickCallBack:Function;
      
      protected var FReplayCallBack:Function;
      
      protected var FSlotsOnMove:Function;
      
      protected var FSlotsOnOut:Function;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FScore:int;
      
      protected var FGlobalboss:TGlobalboss;
      
      public function TBattleWinWindow(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function InitBattleWinWindow() : void
      {
         var _loc1_:int = 0;
         this.FHintBtn = new THint();
         this.FArticle = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FCurPage = 1;
         this.FTotlePage = 1;
         this.FUISlots = new Vector.<TUISlotCopy>(MAX_COUNT);
         this.FIDTemplates = new Vector.<uint>(MAX_COUNT);
         this.FQualityTemplates = new Vector.<uint>(MAX_COUNT);
         this.FInventories = new TInventories();
         this.FVecTabooCell = new Vector.<TabooDataCell>();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         TGameUtil.AddWindowMask(this,-440,-189);
         if(this.FScene == null)
         {
            this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_BATTLE.RESOURCE_ClassName_Win) as MovieClip;
            addChild(this.FScene);
         }
         TGameUtil.setButtonMode(this.FScene.btn_get,true);
         this.FScene.btn_get.addEventListener(MouseEvent.MOUSE_UP,this.OnOutBattle);
         this.FScene.btn_copy.addEventListener(MouseEvent.MOUSE_UP,this.OnCopyBattle);
         this.FScene.btn_replay.addEventListener(MouseEvent.MOUSE_UP,this.OnReplayBattle);
         TGameUtil.setButtonMode(this.FScene.btn_arrorUp,true);
         this.FScene.btn_arrorUp.addEventListener(MouseEvent.MOUSE_UP,this.OnUp);
         TGameUtil.setButtonMode(this.FScene.btn_arrorDown,true);
         this.FScene.btn_arrorDown.addEventListener(MouseEvent.MOUSE_UP,this.OnDown);
         this.FScene.btn_copy.addEventListener(MouseEvent.MOUSE_MOVE,this.Btn_CopyOnMove,false,0,true);
         this.FScene.btn_copy.addEventListener(MouseEvent.MOUSE_OUT,this.Btn_OnOut,false,0,true);
         this.FScene.btn_replay.addEventListener(MouseEvent.MOUSE_MOVE,this.Btn_ReplayOnMove,false,0,true);
         this.FScene.btn_replay.addEventListener(MouseEvent.MOUSE_OUT,this.Btn_OnOut,false,0,true);
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            this.FUISlots[_loc1_] = this.GetSlot();
            this.FUISlots[_loc1_].Resource = this.FScene["mc_slot_" + _loc1_].mc_slot;
            this.FUISlots[_loc1_].Init();
            _loc1_++;
         }
      }
      
      protected function GetSlot() : TUISlotCopy
      {
         var _loc1_:TUISlotCopy = null;
         _loc1_ = new TUISlotCopy(this,CONST_MODULES.MODULE_Battle);
         _loc1_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         _loc1_.OnOverlay = this.FSlotsOnMove;
         _loc1_.OnOut = this.FSlotsOnOut;
         _loc1_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         _loc1_.OnQuerySubscript = this.SlotsOnQuerySubscript;
         return _loc1_;
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Battle);
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TInventory = null;
         var _loc5_:TabooDataCell = null;
         if(param2 is TabooDataCell)
         {
            _loc5_ = param2 as TabooDataCell;
            param3.Value = _loc5_.Count.toString();
         }
         else
         {
            _loc4_ = param2 as TInventory;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function CheckBtn() : void
      {
         this.FScene.btn_arrorUp.visible = Boolean(this.FCurPage != 1);
         this.FScene.btn_arrorDown.visible = Boolean(this.FCurPage != this.FTotlePage);
      }
      
      protected function SetSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:TArticle = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TabooDataCell = null;
         var _loc7_:TInventory = null;
         var _loc8_:int = 0;
         if(this.FReward != null)
         {
            this.FIDTemplates.length = 0;
            this.FQualityTemplates.length = 0;
            this.FVecTabooCell.length = 0;
            _loc4_ = (this.FCurPage - 1) * MAX_COUNT;
            this.FScene.tf_exp.visible = this.FScene.tf_money.visible = this.FScene.tf_soul.visible = this.FScene.tf_exp_Copy.visible = false;
            if(this.FScene.currentFrame == 1)
            {
               this.FScene.tf_exp_Copy.visible = false;
               if(this.FReward.Exp > 0)
               {
                  this.FScene.tf_exp.visible = true;
                  _loc8_ = int(SLogicsCore.KaguyaData.RoleCurAtPosition);
                  if(_loc8_ != CONST_BATTLE.BattleType_Nodal || SLogicsCore.KaguyaData.OpenState == 0 || SLogicsCore.KaguyaData.IsLongTime == 7 || SLogicsCore.KaguyaData.CurLevel <= 1)
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
               else
               {
                  this.FScene.tf_exp.visible = false;
               }
               if(this.FScore != 0)
               {
                  this.FScene.tf_exp.text = STRING_COMMON.ITEMNAME_Integral + (this.FScore > 0 ? "+" : "") + this.FScore;
                  this.FScene.tf_exp.visible = true;
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
            }
            _loc6_ = null;
            _loc1_ = 0;
            while(_loc1_ < MAX_COUNT)
            {
               if(_loc1_ + _loc4_ < this.FReward.ItemIDs.length)
               {
                  this.FScene["mc_slot_" + _loc1_].visible = true;
                  if(this.FReward.ItemIDs[_loc1_ + _loc4_].Type == 18)
                  {
                     _loc6_ = new TabooDataCell();
                     _loc6_.SetValueById(this.FReward.ItemIDs[_loc1_ + _loc4_].ID);
                     _loc6_.Count = this.FReward.ItemIDs[_loc1_ + _loc4_].Count;
                     this.FVecTabooCell.push(_loc6_);
                     this.FScene["mc_slot_" + _loc1_].tf_name.text = _loc6_.ConfigureConfig.Name;
                     this.FScene["mc_slot_" + _loc1_].tf_name.textColor = QUALITYCOLOR_INDEX[_loc6_.ConfigureConfig.Quality];
                  }
                  else
                  {
                     _loc3_ = this.FArticle.GetDatebaseByIdentifier(this.FReward.ItemIDs[_loc1_ + _loc4_].ID) as TArticle;
                     _loc2_ = _loc3_.Name;
                     _loc5_ = _loc3_.Quality;
                     this.FIDTemplates.push(this.FReward.ItemIDs[_loc1_ + _loc4_].ID);
                     this.FQualityTemplates.push(this.FReward.ItemIDs[_loc1_ + _loc4_].Count);
                     this.FScene["mc_slot_" + _loc1_].tf_name.text = _loc2_;
                     this.FScene["mc_slot_" + _loc1_].tf_name.textColor = QUALITYCOLOR_INDEX[_loc5_];
                  }
               }
               else
               {
                  this.FScene["mc_slot_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
            this.FInventories.Clear();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,this.FIDTemplates);
            _loc1_ = 0;
            while(_loc1_ < this.FInventories.Count + this.FVecTabooCell.length)
            {
               if(_loc1_ >= this.FInventories.Count)
               {
                  this.FUISlots[_loc1_].Context = this.FVecTabooCell[_loc1_ - this.FInventories.Count];
               }
               else
               {
                  _loc7_ = this.FInventories.GetInventoryByIndex(_loc1_);
                  _loc7_.Quantity = this.FQualityTemplates[_loc1_];
                  this.FUISlots[_loc1_].Context = _loc7_;
               }
               _loc1_++;
            }
            _loc1_ = this.FInventories.Count + this.FVecTabooCell.length;
            while(_loc1_ < MAX_COUNT)
            {
               this.FUISlots[_loc1_].Context = null;
               _loc1_++;
            }
         }
      }
      
      protected function OnOutBattle(param1:MouseEvent = null) : void
      {
         this.visible = false;
         this.FScore = 0;
         this.FCurPage = 1;
         this.FReward = null;
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
      
      protected function OnUp(param1:MouseEvent) : void
      {
         --this.FCurPage;
         if(this.FCurPage < 1)
         {
            this.FCurPage = 1;
         }
         this.CheckBtn();
         this.SetSlot();
      }
      
      protected function OnDown(param1:MouseEvent) : void
      {
         ++this.FCurPage;
         if(this.FCurPage > this.FTotlePage)
         {
            this.FCurPage = this.FTotlePage;
         }
         this.CheckBtn();
         this.SetSlot();
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
      
      public function set SlotsOnMove(param1:Function) : void
      {
         this.FSlotsOnMove = param1;
      }
      
      public function get SlotsOnMove() : Function
      {
         return this.FSlotsOnMove;
      }
      
      public function set SlotsOnOut(param1:Function) : void
      {
         this.FSlotsOnOut = param1;
      }
      
      public function get SlotsOnOut() : Function
      {
         return this.FSlotsOnOut;
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
      
      public function set Globalboss(param1:TGlobalboss) : void
      {
         var _loc2_:TDafubenCondition = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         this.FGlobalboss = param1;
         if(this.Visible && Boolean(this.FGlobalboss))
         {
            _loc3_ = this.FGlobalboss.Dafuben.ConditionList;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc4_ = int(_loc3_[_loc5_]);
               _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_DafubenCondition,_loc4_) as TDafubenCondition;
               this.FScene["mc_desc_" + _loc5_].TF_Desc.text = _loc2_.Dec;
               _loc6_ = this.FScene["star_" + _loc5_];
               if(this.FGlobalboss.PassIds.indexOf(_loc4_) >= 0)
               {
                  _loc6_.gotoAndStop(1);
               }
               else
               {
                  _loc6_.gotoAndStop(2);
               }
               _loc5_++;
            }
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(param1)
         {
            this.FScene.mc_title.mc_title.gotoAndPlay(1);
            SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_SOUND,CONST_MUSIC.PLAY_SOUND_EFFECT,CONST_BATTLE.SOUNDID_BATTLE_Win,true);
         }
      }
      
      public function Setup() : void
      {
         this.InitBattleWinWindow();
      }
      
      public function SetWindow(param1:TItems, param2:int, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) : void
      {
         this.FReward = param1;
         this.FTotlePage = Math.max(int(this.FReward.ItemIDs.length - 1) / MAX_COUNT + 1,1);
         if(param2 == CONST_BATTLE.BattleType_GlobalBoss)
         {
            this.FScene.gotoAndStop(2);
         }
         else
         {
            this.FScene.gotoAndStop(1);
         }
         this.FScene.btn_copy.visible = false;
         this.FScene.btn_replay.visible = param4;
         this.FIsAutoBattle = param5;
         if(this.FIsAutoBattle)
         {
            this.FAutoOutTimerId = setTimeout(this.OnAutoClose,5000);
         }
         this.CheckBtn();
         this.SetSlot();
         this.Globalboss = this.FGlobalboss;
      }
      
      public function UpdataSlot() : void
      {
         var _loc1_:int = 0;
         if(this.FReward == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            if(_loc1_ < this.FUISlots.length)
            {
               this.FUISlots[_loc1_].Update();
            }
            _loc1_++;
         }
      }
      
      public function SetShowReplay(param1:Boolean) : void
      {
         this.FScene.btn_replay.visible = param1;
      }
   }
}

