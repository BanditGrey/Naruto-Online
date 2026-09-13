package Processors.Game.Lobby.Exercise.Exorcism
{
   import Components.Pages.TUIPage;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.Exorcism.TExorcism;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerExorcism;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.FebActive.TProcessorFebActiveShop;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorExorcism extends TProcessorBaseActivity
   {
      
      protected static const SHOW_ITEM_COUNT:int = 6;
      
      protected static const BOSS_COUNT:int = 3;
      
      protected static const BALL_COUNT:int = 3;
      
      protected static const ACT_TASK_COUNT:int = 5;
      
      protected static const ACT_TASK_STEP:int = TActivityTaskData.STEP_COUNT;
      
      public static const ACTIVITY_1_PLAY_GAME:int = 1;
      
      public static const ACTIVITY_1_GET_KILL_BOX:int = 2;
      
      public static const ACTIVITY_1_EXCHANGE_ITEM:int = 3;
      
      public static const ACTIVITY_1_GET_RECHARGE_BOX:int = 4;
      
      public static const ACTIVITY_1_GET_TASK:int = 5;
      
      public static const ACTIVITY_1_FINISH_TASK:int = 6;
      
      public static const MOVIE_OF_BEAT_BOSS:int = 1;
      
      public static const MOVIE_TYPE_BOSS_DIED:int = 2;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FExorcism:TExorcism;
      
      protected var FUnstreamizerExorcism:TUnstreamizerExorcism;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FIsPlaying:Boolean;
      
      protected var FWindowType:int;
      
      protected var FMovieType:int;
      
      protected var FOpenIndex:int;
      
      protected var FFrameCount:int;
      
      protected var FTotalFrame:int;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FPlayMovie:MovieClip;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      protected var FBossIndex:int;
      
      protected var FBallIndex:int;
      
      protected var FBallList:Vector.<MovieClip>;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      public function TProcessorExorcism(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FExorcism = SLogicsCore.Exorcism;
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         this.FUnstreamizerExorcism = new TUnstreamizerExorcism(param3);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FBuyBoxDate = new Object();
         this.FUIPage = new TUIPage(this);
         this.FBallList = new Vector.<MovieClip>(BALL_COUNT);
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < ACT_TASK_COUNT)
         {
            if(Boolean(FMC_Scene) && Boolean(FMC_Scene["MC_Task" + _loc1_]))
            {
               _loc5_ = FMC_Scene["MC_Task" + _loc1_];
               _loc5_.MC_Reward.gotoAndStop(_loc1_ + 1);
               TGameUtil.setButtonMode(_loc5_.BTN_Go,true);
               _loc5_.BTN_Go.addEventListener(MouseEvent.CLICK,this.ProcessorOnGoTaskUp);
               TGameUtil.setButtonMode(_loc5_.BTN_GetTask,true);
               _loc5_.BTN_GetTask.addEventListener(MouseEvent.CLICK,this.ProcessorOnAcceptTaskUp);
               TGameUtil.setButtonMode(_loc5_.BTN_Finish,true);
               _loc5_.BTN_Finish.addEventListener(MouseEvent.CLICK,this.ProcessorOnFinishTaskUp);
               _loc5_.MC_Reward.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGetTaskRewardOver);
               _loc5_.MC_Reward.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < BOSS_COUNT)
         {
            _loc4_ = FMC_Scene.MC_Game["MC_Icon" + _loc1_];
            _loc4_.buttonMode = true;
            _loc4_.gotoAndStop(_loc1_ + 1);
            _loc4_.addEventListener(MouseEvent.CLICK,this.ProcessorOnBossUp);
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBossOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < BALL_COUNT)
         {
            _loc4_ = FMC_Scene.MC_Game["MC_Ball" + _loc1_];
            _loc4_.buttonMode = true;
            _loc4_.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc4_.addEventListener(MouseEvent.CLICK,this.ProcessorOnBallUp);
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBallOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
            this.FBallList[_loc1_] = _loc4_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < BOSS_COUNT)
         {
            _loc4_ = FMC_Scene["MC_KillBox" + _loc1_];
            _loc4_.buttonMode = true;
            _loc4_.MC_Box.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc4_.addEventListener(MouseEvent.CLICK,this.ProcessorOnKillBoxUp);
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnKillBoxOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc1_++;
         }
         FMC_Scene.MC_Game.MC_Boss.MC_KillMovie.visible = false;
         FMC_Scene.MC_Game.MC_Boss.MC_Attack.visible = false;
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem.OnOut = UIComponentsHintOnOut;
         this.FShowItem.OnShowRecruit = ProcessorOnShowItemDesc;
         this.FProcessorFebActiveShop.Visible = false;
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorFebActiveShop.OnOut = UIComponentsHintOnOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorFebActiveShop.X = -21;
         this.FProcessorFebActiveShop.y = 15;
         FMC_Scene.MC_RechargeBox.buttonMode = true;
         FMC_Scene.MC_RechargeBox.MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnRechargeBoxUp);
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_RechargeBox.Btn_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_RechargeBox.Btn_Right;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = 1;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         FMC_Scene.MC_Tip0.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip0Over);
         FMC_Scene.MC_Tip0.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         FMC_Scene.MC_Tip1.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip1Over);
         FMC_Scene.MC_Tip1.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         this.FMC_Mask = FMC_Scene.MC_Game.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_TitleDesc,true);
         FMC_Scene.BTN_TitleDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowTitleDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_EquipDesc,true);
         FMC_Scene.BTN_EquipDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowEquipDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            if(this.FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_OF_BEAT_BOSS:
                  case MOVIE_TYPE_BOSS_DIED:
                     _loc2_ = this.FPlayMovie.currentFrame;
               }
               if(_loc2_ == this.FTotalFrame)
               {
                  this.FIsPlaying = false;
                  this.FFrameCount = 0;
                  this.MovieEnd();
               }
               else
               {
                  ++this.FFrameCount;
                  if(this.FFrameCount > 100)
                  {
                     this.FIsPlaying = false;
                     this.FFrameCount = 0;
                     this.UpdateUI();
                  }
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.FUIPage.PageIndex = this.FExorcism.GetCurIndex();
         this.FCurPage = this.FExorcism.GetCurIndex();
         this.UpdateGame();
         this.UpdateBox();
         this.UpdateTaskView();
         this.UpdateText();
         if(this.FProcessorFebActiveShop.Visible)
         {
            this.FProcessorFebActiveShop.UpdateUI(this.FExorcism);
         }
      }
      
      protected function UpdateGame() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < BOSS_COUNT)
         {
            _loc2_ = FMC_Scene.MC_Game["MC_Icon" + _loc1_];
            if(_loc1_ == this.FBossIndex)
            {
               _loc2_.MC_Select.visible = true;
            }
            else
            {
               _loc2_.MC_Select.visible = false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < BALL_COUNT)
         {
            _loc2_ = this.FBallList[_loc1_];
            _loc3_ = this.FExorcism.CannonList[this.FBossIndex];
            _loc2_.TF_Desc.text = this.FExorcism.DescListNew[10 + _loc1_];
            _loc1_++;
         }
         FMC_Scene.MC_Game.MC_Boss.MC_Icon.visible = true;
         FMC_Scene.MC_Game.MC_Boss.MC_Icon.gotoAndStop(this.FBossIndex + 1);
         FMC_Scene.MC_Game.MC_Boss.MC_KillMovie.visible = false;
         FMC_Scene.MC_Game.MC_Boss.MC_Attack.visible = false;
         _loc3_ = this.FExorcism.BossList[this.FBossIndex];
         FMC_Scene.MC_Game.MC_Bar.TF_Count.text = _loc3_.Min + "/" + _loc3_.Max;
         _loc4_ = Number(_loc3_.Min / _loc3_.Max) * this.FBarMaxWidth;
         _loc5_ = Math.min(_loc4_,this.FBarMaxWidth);
         this.FMC_Mask.width = _loc5_;
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:int = 0;
         this.FShowItem.UpdateUI(this.FExorcism.ShowItems);
         this.FUIPage.TotalQuantity = this.FExorcism.RechargeList.length;
         this.FUIPage.Update();
         _loc5_ = this.FCurPage;
         _loc4_ = this.FExorcism.RechargeList[_loc5_];
         FMC_Scene.MC_RechargeBox.TF_RechargeGold.text = this.FExorcism.ConsumeScore.toString();
         FMC_Scene.MC_RechargeBox.TF_Count.text = _loc4_.Inventories.GetInventoryByIndex(0).Quantity.toString();
         FMC_Scene.MC_RechargeBox.TF_Price.text = TUtilityString.Format(this.FExorcism.DescListNew[5],_loc4_.Price);
         if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.MC_RechargeBox.MC_Got.visible = false;
            FMC_Scene.MC_RechargeBox.MC_Click.visible = false;
            FMC_Scene.MC_RechargeBox.MC_Box.gotoAndStop(1);
            FMC_Scene.MC_RechargeBox.MC_Box.MC_Icon.gotoAndStop(_loc5_ + 1);
         }
         else if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_RechargeBox.MC_Got.visible = false;
            FMC_Scene.MC_RechargeBox.MC_Click.visible = true;
            FMC_Scene.MC_RechargeBox.MC_Box.gotoAndPlay(1);
            FMC_Scene.MC_RechargeBox.MC_Box.MC_Icon.gotoAndStop(_loc5_ + 1);
         }
         else
         {
            FMC_Scene.MC_RechargeBox.MC_Got.visible = true;
            FMC_Scene.MC_RechargeBox.MC_Click.visible = false;
            FMC_Scene.MC_RechargeBox.MC_Box.gotoAndStop(1);
            FMC_Scene.MC_RechargeBox.MC_Box.MC_Icon.gotoAndStop(_loc5_ + 1);
         }
         _loc1_ = 0;
         while(_loc1_ < BOSS_COUNT)
         {
            _loc3_ = FMC_Scene["MC_KillBox" + _loc1_];
            _loc4_ = this.FExorcism.KillBox[_loc1_];
            _loc3_.TF_Count.text = "*" + _loc4_.Count;
            if(_loc4_.Count > 0)
            {
               _loc3_.MC_Click.visible = true;
               _loc3_.MC_Box.gotoAndPlay(1);
            }
            else
            {
               _loc3_.MC_Click.visible = false;
               _loc3_.MC_Box.gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateTaskView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TDessertHouseTask = null;
         _loc1_ = 0;
         while(_loc1_ < ACT_TASK_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Task" + _loc1_];
            if(_loc1_ < this.FActivityTaskData.TaskList.length)
            {
               _loc4_.visible = true;
               _loc5_ = this.FActivityTaskData.TaskList[_loc1_];
               _loc3_ = _loc5_.Step >= ACT_TASK_STEP ? int(ACT_TASK_STEP - 1) : _loc5_.Step;
               _loc4_.TF_Desc.text = TUtilityString.Format(_loc5_.TaskDesc,_loc5_.TaskReq[_loc3_]);
               _loc4_.TF_Process.text = _loc5_.Process + "/" + _loc5_.ClientTaskReq[_loc3_];
               if(_loc5_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc4_.BTN_Finish.visible = false;
                  _loc4_.BTN_GetTask.visible = true;
                  _loc4_.MC_Finish.visible = false;
               }
               else if(_loc5_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc4_.BTN_Finish.visible = true;
                  _loc4_.BTN_GetTask.visible = false;
                  _loc4_.MC_Finish.visible = false;
                  if(_loc5_.Process >= _loc5_.ClientTaskReq[_loc3_])
                  {
                     TGameUtil.setButtonMode(_loc4_.BTN_Finish,true);
                  }
                  else
                  {
                     TGameUtil.setButtonMode(_loc4_.BTN_Finish,false);
                  }
               }
               else if(_loc5_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc4_.BTN_Finish.visible = false;
                  _loc4_.BTN_GetTask.visible = false;
                  _loc4_.MC_Finish.visible = true;
               }
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         FMC_Scene.TF_Desc.text = this.FExorcism.DescListNew[1];
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FExorcism.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FExorcism.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Score.text = this.FExorcism.RankPoint.toString();
         FMC_Scene.TF_Count.text = this.FExorcism.MyScore.toString();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnBossUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(!this.FIsPlaying && this.FBossIndex != _loc2_)
         {
            this.FBossIndex = _loc2_;
            this.UpdateGame();
         }
      }
      
      protected function ProcessorOnBossOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(this.FExorcism)
         {
            _loc4_ = TUtilityString.Format(this.FExorcism.DescListNew[7 + _loc2_]);
            ProcessorOnShowHtmlText(_loc4_);
         }
      }
      
      protected function ProcessorOnBallOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(this.FExorcism)
         {
            _loc4_ = TUtilityString.Format(this.FExorcism.DescListNew[13 + BALL_COUNT * this.FBossIndex + _loc2_]);
            ProcessorOnShowHtmlText(_loc4_);
         }
      }
      
      protected function ProcessorOnBallUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(this.FExorcism) && _loc2_ < this.FExorcism.CannonList.length)
         {
            _loc5_ = this.FExorcism.CannonList[_loc2_].ExchangeVect[this.FBossIndex];
            if(this.FExorcism.MyScore >= _loc5_)
            {
               this.ProcessorOnGetBoxUp(ACTIVITY_1_PLAY_GAME,this.FBossIndex + 1,_loc2_ + 1);
            }
            else
            {
               _loc3_ = (_loc5_ - this.FExorcism.MyScore) * this.FExorcism.ScorePrice;
               _loc4_ = TUtilityString.Format(this.FExorcism.DescListNew[4],_loc5_,_loc3_,_loc5_ - this.FExorcism.MyScore);
               this.ProcessorOnBuyBoxUp(ACTIVITY_1_PLAY_GAME,_loc3_,this.FBossIndex + 1,0,_loc4_,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnKillBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(10));
         if(Boolean(this.FExorcism) && Boolean(_loc2_ < this.FExorcism.KillBox.length) && this.FExorcism.KillBox[_loc2_].Count > 0)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_KILL_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnKillBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(10));
         if(Boolean(this.FExorcism) && _loc2_ < this.FExorcism.KillBox.length)
         {
            _loc3_ = this.FExorcism.KillBox[_loc2_].Inventories;
            ProcessorOnNewBoxOver(_loc3_);
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(this.FExorcism)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_EXCHANGE_ITEM,param1 + 1);
         }
      }
      
      protected function ProcessorOnRechargeBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         _loc3_ = _loc2_ + this.FCurPage;
         if(this.FExorcism.RechargeList[_loc3_].Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_RECHARGE_BOX,_loc3_ + 1);
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateBox();
      }
      
      protected function ProcessorOnTip0Over(param1:MouseEvent) : void
      {
         if(this.FExorcism)
         {
            ProcessorOnShowHtmlText(this.FExorcism.DescListNew[2]);
         }
      }
      
      protected function ProcessorOnTip1Over(param1:MouseEvent) : void
      {
         if(this.FExorcism)
         {
            ProcessorOnShowHtmlText(this.FExorcism.DescListNew[3]);
         }
      }
      
      protected function ProcessorOnGoTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGoto != null && _loc2_ < this.FActivityTaskData.TaskList.length)
         {
            this.ProcessorOnCloseWindow();
            _loc3_ = this.FActivityTaskData.TaskList[_loc2_];
            ProcessorOnGoto(_loc3_.Go);
         }
      }
      
      protected function ProcessorOnAcceptTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(!this.FIsPlaying && _loc2_ < this.FActivityTaskData.TaskList.length)
         {
            _loc3_ = this.FActivityTaskData.TaskList[_loc2_];
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_TASK,_loc3_.Identify);
         }
      }
      
      protected function ProcessorOnFinishTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(_loc2_ < this.FActivityTaskData.TaskList.length)
         {
            _loc3_ = this.FActivityTaskData.TaskList[_loc2_];
            this.ProcessorOnGetBoxUp(ACTIVITY_1_FINISH_TASK,_loc3_.Identify);
         }
      }
      
      protected function ProcessorOnGetTaskRewardOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TDessertHouseTask = null;
         var _loc5_:TInventories = null;
         var _loc6_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(_loc2_ < this.FActivityTaskData.TaskList.length)
         {
            _loc4_ = this.FActivityTaskData.TaskList[_loc2_];
            _loc6_ = Math.min(_loc4_.Step,ACT_TASK_STEP - 1);
            _loc5_ = _loc4_.TaskAward[_loc6_];
            ProcessorOnNewBoxOver(_loc5_);
         }
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0, param7:int = 0) : void
      {
         if(this.FBeClicked || this.FIsPlaying)
         {
            return;
         }
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxIndex = param3;
         this.FBuyBoxDate.Cost = param2;
         this.FBuyBoxDate.CostType = param4;
         this.FBuyBoxDate.BoxIndex1 = param6;
         this.FBuyBoxDate.ConfirmType = param7;
         if(param4 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = param2;
            if(param5 != "")
            {
               FUIWindowConfirmation.Text = param5;
            }
            else
            {
               FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            }
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGold >= this.FBuyBoxDate.Cost)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         if(this.FBeClicked || this.FIsPlaying)
         {
            return;
         }
         this.FBeClicked = true;
         _loc6_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc6_.push(param2);
         }
         if(param3 != 0)
         {
            _loc6_.push(param3);
         }
         PerformPacket_CS_AllReq(param1,_loc6_);
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI(this.FExorcism);
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorFebActiveShop.Visible = false;
      }
      
      protected function ProcessorOnShowTitleDesc(param1:MouseEvent) : void
      {
         ProcessorOnShowOtherWindow(TProcessorBaseActivity.WINDOW_TITLE_DESC,this.FExorcism);
      }
      
      protected function ProcessorOnShowEquipDesc(param1:MouseEvent) : void
      {
         ProcessorOnShowOtherWindow(TProcessorBaseActivity.WINDOW_EQUIPMENT_DESC,this.FExorcism);
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FExorcism;
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         ProcessorOnLoadRank_New(this.FExorcism);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorFebActiveShop.Load();
            return;
         }
         this.visible = true;
         this.alpha = 1;
         this.FIsOpen = true;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerExorcism.Unstreamize(_loc2_,this.FExorcism,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorLoadRankRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TConsumeRankInfo = null;
         var _loc7_:TBaseBox = null;
         var _loc8_:TInventories = null;
         var _loc9_:TInventory = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc11_ = int(_loc2_.readUnsignedInt());
         _loc2_.readUnsignedShort();
         if(this.FExorcism)
         {
            this.FExorcism.RankGiftList.length = 0;
            _loc5_ = int(_loc2_.readUnsignedShort());
            _loc10_ = new Vector.<uint>();
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc7_ = new TBaseBox();
               _loc7_.Min = _loc2_.readUnsignedInt();
               _loc7_.Max = _loc2_.readUnsignedInt();
               _loc7_.TitleID = _loc2_.readUnsignedInt();
               _loc10_.length = 0;
               _loc8_ = new TInventories();
               _loc10_.push(_loc2_.readUnsignedInt());
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc10_);
               _loc9_ = _loc8_.GetInventoryByIndex(0);
               _loc9_.Quantity = 1;
               _loc7_.Inventories = _loc8_;
               this.FExorcism.RankGiftList.push(_loc7_);
               _loc4_++;
            }
            this.FExorcism.RankPlayerList.length = 0;
            _loc5_ = int(_loc2_.readUnsignedShort());
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc6_ = new TConsumeRankInfo();
               _loc6_.UserName = TUtilityString.FetchUTF(_loc2_);
               _loc6_.ServerName = TUtilityString.FetchUTF(_loc2_);
               _loc6_.Rank = _loc2_.readUnsignedInt();
               _loc6_.Score = _loc2_.readUnsignedInt();
               this.FExorcism.RankPlayerList.push(_loc6_);
               _loc4_++;
            }
         }
         if(FIsResourcesLoadCompleted && this.visible)
         {
            FProcessorActiveRankOld.Visible = true;
            FProcessorActiveRankOld.UpdateUI(this.FExorcism);
         }
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         if(this.FExorcism)
         {
            this.FActivityTaskData.NeedShine = _loc2_.readUnsignedInt();
            this.FExorcism.ChangeStatus();
            if(this.FIsOpen)
            {
               this.UpdateUI();
            }
         }
      }
      
      override public function ProcessorActivityThirdLoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         ProcessorUnstreamActivityLog(this.FExorcism,_loc2_);
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventories = null;
         var _loc9_:TInventory = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:TBaseBox = null;
         var _loc14_:uint = 0;
         var _loc15_:TBins = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:uint = 0;
         var _loc21_:Vector.<uint> = null;
         var _loc22_:Vector.<uint> = null;
         var _loc23_:String = null;
         var _loc24_:TDessertHouseTask = null;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc7_)
         {
            case ACTIVITY_1_PLAY_GAME:
               this.FBossIndex = this.FExorcism.BossIndex = _loc2_.readUnsignedInt() - 1;
               this.FExorcism.BallIndex = _loc2_.readUnsignedInt() - 1;
               _loc12_ = _loc2_.readUnsignedInt();
               this.FExorcism.MyScore = _loc2_.readUnsignedInt();
               this.FExorcism.BossList[this.FBossIndex].Min = _loc2_.readUnsignedInt();
               this.FExorcism.RankPoint += _loc12_;
               this.FExorcism.ShopExchangePoint += _loc12_;
               this.FExorcism.KillBox[this.FBossIndex].Count = _loc2_.readUnsignedInt();
               this.FExorcism.ConsumeScore = _loc2_.readUnsignedInt();
               this.FExorcism.ChangeStatus();
               ProcessorEffectText(TUtilityString.Format(this.FExorcism.DescListNew[6],_loc12_));
               ProcessorCheckEffect(FActivityID,this.FExorcism.CheckStatus());
               this.PlayMovie(MOVIE_OF_BEAT_BOSS);
               break;
            case ACTIVITY_1_GET_KILL_BOX:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               --this.FExorcism.KillBox[_loc5_].Count;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FExorcism.KillBox[_loc5_].Inventories.Count)
               {
                  _loc9_ = this.FExorcism.KillBox[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               this.FExorcism.RankPoint = _loc2_.readUnsignedInt();
               this.FExorcism.ShopExchangePoint = _loc2_.readUnsignedInt();
               ProcessorEffectText(_loc4_);
               this.FExorcism.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FExorcism.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_EXCHANGE_ITEM:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FExorcism.ShopExchangePoint = _loc2_.readUnsignedInt();
               --this.FExorcism.ShopExchangeItems[_loc5_].LimitCount;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
               this.FExorcism.ChangeStatus();
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FExorcism.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_RECHARGE_BOX:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FExorcism.RechargeList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FExorcism.RechargeList[_loc5_].Inventories.Count)
               {
                  _loc9_ = this.FExorcism.RechargeList[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               this.FExorcism.MyScore = _loc2_.readUnsignedInt();
               this.FExorcism.RankPoint = _loc2_.readUnsignedInt();
               this.FExorcism.ShopExchangePoint = _loc2_.readUnsignedInt();
               ProcessorEffectText(_loc4_);
               this.FExorcism.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FExorcism.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_TASK:
               _loc20_ = _loc2_.readUnsignedInt();
               _loc24_ = this.FActivityTaskData.GetTaskByIdentify(_loc20_);
               if(_loc24_ != null)
               {
                  _loc24_.Status = TBaseActivity.STATUS_CANGET;
                  _loc24_.Process = 0;
               }
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET_TASK_SUCCESS);
               ProcessorCheckEffect(FActivityID,this.FExorcism.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_FINISH_TASK:
               _loc20_ = _loc2_.readUnsignedInt();
               _loc24_ = this.FActivityTaskData.GetTaskByIdentify(_loc20_);
               this.FActivityTaskData.NeedShine = _loc2_.readUnsignedInt();
               if(_loc24_ != null)
               {
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc24_.TaskAward[_loc24_.Step].Count)
                  {
                     _loc9_ = _loc24_.TaskAward[_loc24_.Step].GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ++_loc24_.Step;
                  if(_loc24_.Step >= TActivityTaskData.STEP_COUNT)
                  {
                     _loc24_.Status = TBaseActivity.STATUS_GETED;
                  }
                  else
                  {
                     _loc24_.Process = 0;
                     _loc24_.Status = TBaseActivity.STATUS_CANNOTGET;
                  }
               }
               this.FExorcism.MyScore = _loc2_.readUnsignedInt();
               this.FExorcism.RankPoint = _loc2_.readUnsignedInt();
               this.FExorcism.ShopExchangePoint = _loc2_.readUnsignedInt();
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FExorcism.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         this.FIsPlaying = true;
         this.FMovieType = param1;
         if(this.FMovieType == MOVIE_OF_BEAT_BOSS)
         {
            FMC_Scene.MC_Game.MC_Boss.MC_Icon.visible = false;
            FMC_Scene.MC_Game.MC_Boss.MC_Attack.MC_Icon.gotoAndStop(this.FBossIndex + 1);
            this.FPlayMovie = FMC_Scene.MC_Game.MC_Boss.MC_Attack;
            this.FPlayMovie.visible = true;
            this.FTotalFrame = this.FPlayMovie.totalFrames;
            this.FPlayMovie.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_TYPE_BOSS_DIED)
         {
            FMC_Scene.MC_Game.MC_Boss.MC_Icon.visible = false;
            FMC_Scene.MC_Game.MC_Boss.MC_KillMovie.MC_Icon.gotoAndStop(this.FBossIndex + 1);
            FMC_Scene.MC_Game.MC_Boss.MC_KillMovie.MC_Box.gotoAndStop(this.FBossIndex + 1);
            this.FPlayMovie = FMC_Scene.MC_Game.MC_Boss.MC_KillMovie;
            this.FPlayMovie.visible = true;
            this.FTotalFrame = this.FPlayMovie.totalFrames;
            this.FPlayMovie.gotoAndPlay(1);
         }
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.FIsPlaying = false;
         if(this.FMovieType == MOVIE_OF_BEAT_BOSS)
         {
            this.FPlayMovie.visible = false;
            _loc3_ = Number(this.FExorcism.BossList[this.FBossIndex].Min / this.FExorcism.BossList[this.FBossIndex].Max) * this.FBarMaxWidth;
            _loc4_ = Math.min(_loc3_,this.FBarMaxWidth);
            this.FMC_Mask.width = this.FBarMaxWidth;
            if(this.FExorcism.BossList[this.FBossIndex].Min == 0)
            {
               this.PlayMovie(MOVIE_TYPE_BOSS_DIED);
            }
            else
            {
               this.UpdateUI();
            }
         }
         else if(this.FMovieType == MOVIE_TYPE_BOSS_DIED)
         {
            this.FPlayMovie.visible = false;
            this.FExorcism.Reset();
            this.UpdateUI();
         }
      }
      
      public function Test() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(11);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"收集物A");
         TUtilityString.FlushUTF(_loc3_,"收集物B");
         TUtilityString.FlushUTF(_loc3_,"当前雪球消耗%0个雪花，是否花费%1金币补齐不足的%2个雪花？");
         TUtilityString.FlushUTF(_loc3_,"消耗XX%0个可领取");
         TUtilityString.FlushUTF(_loc3_,"你获得了%0个收集物");
         TUtilityString.FlushUTF(_loc3_,"怪物1");
         TUtilityString.FlushUTF(_loc3_,"怪物2");
         TUtilityString.FlushUTF(_loc3_,"怪物3");
         TUtilityString.FlushUTF(_loc3_,"炮1");
         TUtilityString.FlushUTF(_loc3_,"炮2");
         TUtilityString.FlushUTF(_loc3_,"炮3");
         TUtilityString.FlushUTF(_loc3_,"炮4");
         TUtilityString.FlushUTF(_loc3_,"炮5");
         TUtilityString.FlushUTF(_loc3_,"炮6");
         TUtilityString.FlushUTF(_loc3_,"炮7");
         TUtilityString.FlushUTF(_loc3_,"炮8");
         TUtilityString.FlushUTF(_loc3_,"炮9");
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

