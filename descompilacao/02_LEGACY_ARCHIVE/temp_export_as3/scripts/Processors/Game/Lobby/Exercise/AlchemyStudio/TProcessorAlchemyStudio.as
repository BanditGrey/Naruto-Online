package Processors.Game.Lobby.Exercise.AlchemyStudio
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
   import Logics.Exercise.AlchemyStudio.TAlchemyStudio;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerAlchemyStudio;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowEquipDesc;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorAlchemyStudio extends TProcessorBaseActivity
   {
      
      protected static const POINT_COUNT:int = 20;
      
      protected static const GIFT_COUNT:int = 6;
      
      protected static const SHOW_ITEM_COUNT:int = 5;
      
      public static const MOVIE_OF_PLAY_GAME:int = 1;
      
      public static const MOVIE_OF_AUTO:int = 2;
      
      public static const MOVIE_OF_FLOW:int = 3;
      
      public static const ACTIVITY_2_PLAY_GAME:int = 1;
      
      public static const ACTIVITY_2_FIND_TEASURE:int = 2;
      
      public static const ACTIVITY_2_AUTO_PLAY:int = 3;
      
      public static const ACTIVITY_2_GET_SCOREB:int = 4;
      
      public static const ACTIVITY_2_GET_RECHARGE_BOX:int = 5;
      
      public static const ACTIVITY_2_GET_GIFT:int = 6;
      
      public static const ACTIVITY_1_GET_TASK:int = 7;
      
      public static const ACTIVITY_1_FINISH_TASK:int = 8;
      
      protected static const ACT_TASK_COUNT:int = 5;
      
      protected static const ACT_TASK_STEP:int = TActivityTaskData.STEP_COUNT;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FAlchemyStudio:TAlchemyStudio;
      
      protected var FUnstreamizerAlchemyStudio:TUnstreamizerAlchemyStudio;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FTotalFrame:int;
      
      protected var FOpenIndex:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FPlayMovie:MovieClip;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorWindowEquipDesc:TProcessorWindowEquipDesc;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      public function TProcessorAlchemyStudio(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FAlchemyStudio = SLogicsCore.AlchemyStudio;
         this.FUnstreamizerAlchemyStudio = new TUnstreamizerAlchemyStudio(param3);
         this.FBuyBoxDate = new Object();
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FProcessorWindowEquipDesc = new TProcessorWindowEquipDesc(this.Parent);
         this.FUIPage = new TUIPage(this);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIBaseBox = null;
         var _loc6_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < POINT_COUNT)
         {
            FMC_Scene["MC_Point" + _loc1_].buttonMode = true;
            FMC_Scene["MC_Point" + _loc1_].MC_Movie0.visible = false;
            FMC_Scene["MC_Point" + _loc1_].MC_Movie1.visible = false;
            FMC_Scene["MC_Point" + _loc1_].MC_Movie2.visible = false;
            FMC_Scene["MC_Point" + _loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnPointUp);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            FMC_Scene["MC_Gift" + _loc1_].MC_Box.buttonMode = true;
            FMC_Scene["MC_Gift" + _loc1_].MC_Effect.mouseEnabled = false;
            FMC_Scene["MC_Gift" + _loc1_].MC_Box.gotoAndStop(_loc1_ + 1);
            FMC_Scene["MC_Gift" + _loc1_].MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
            FMC_Scene["MC_Gift" + _loc1_].MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
            FMC_Scene["MC_Gift" + _loc1_].MC_Box.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < ACT_TASK_COUNT)
         {
            if(Boolean(FMC_Scene) && Boolean(FMC_Scene["MC_Task" + _loc1_]))
            {
               _loc6_ = FMC_Scene["MC_Task" + _loc1_];
               _loc6_.MC_Reward.gotoAndStop(_loc1_ + 1);
               TGameUtil.setButtonMode(_loc6_.BTN_Go,true);
               _loc6_.BTN_Go.addEventListener(MouseEvent.CLICK,this.ProcessorOnGoTaskUp);
               TGameUtil.setButtonMode(_loc6_.BTN_GetTask,true);
               _loc6_.BTN_GetTask.addEventListener(MouseEvent.CLICK,this.ProcessorOnAcceptTaskUp);
               TGameUtil.setButtonMode(_loc6_.BTN_Finish,true);
               _loc6_.BTN_Finish.addEventListener(MouseEvent.CLICK,this.ProcessorOnFinishTaskUp);
               _loc6_.MC_Reward.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGetTaskRewardOver);
               _loc6_.MC_Reward.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            }
            _loc1_++;
         }
         FMC_Scene.MC_RechargeBox.buttonMode = true;
         FMC_Scene.MC_RechargeBox.MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnRechargeBoxUp);
         FMC_Scene.MC_MyScore.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip0Over);
         FMC_Scene.MC_MyScore.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         FMC_Scene.MC_Mask.MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip1Over);
         FMC_Scene.MC_Mask.MC_Tip.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem.OnOut = UIComponentsHintOnOut;
         this.FShowItem.OnShowRecruit = ProcessorOnShowItemDesc;
         FMC_Scene.MC_Movie0.visible = false;
         FMC_Scene.MC_Movie1.visible = false;
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_RechargeBox.Btn_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_RechargeBox.Btn_Right;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = 1;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,true);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.CLICK,this.ProcessorOnAutoUp);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnAutoOver);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetUp);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGetOver);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         TGameUtil.setButtonMode(FMC_Scene.MC_Mask.BTN_Buy,true);
         FMC_Scene.MC_Mask.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnStartUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         if(FMC_Scene.BTN_TitleDesc)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_TitleDesc,true);
            FMC_Scene.BTN_TitleDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenTitleDesc);
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && Boolean(FMC_Scene.visible) && Boolean(this.FAlchemyStudio))
         {
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            if(this.FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_OF_PLAY_GAME:
                     _loc2_ = this.FPlayMovie.currentFrame;
                     break;
                  case MOVIE_OF_FLOW:
                     _loc2_ = this.FPlayMovie.currentFrame;
                     break;
                  case MOVIE_OF_AUTO:
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
         this.UpdatePoint();
         this.UpdateBox();
         this.UpdateText();
         this.UpdateTaskView();
      }
      
      protected function UpdatePoint() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         if(this.FAlchemyStudio.GameStatus == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.MC_Mask.visible = true;
            FMC_Scene.MC_Mask.MC_Tip.TF_Count.text = this.FAlchemyStudio.ScoreA.toString();
            TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,false);
            _loc1_ = 0;
            while(_loc1_ < POINT_COUNT)
            {
               _loc2_ = FMC_Scene["MC_Point" + _loc1_];
               _loc2_.MC_Icon.gotoAndStop(1);
               _loc1_++;
            }
         }
         else
         {
            FMC_Scene.MC_Mask.visible = false;
            _loc4_ = this.FAlchemyStudio.IsClick;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,_loc4_);
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,!_loc4_);
            _loc1_ = 0;
            while(_loc1_ < POINT_COUNT)
            {
               _loc2_ = FMC_Scene["MC_Point" + _loc1_];
               _loc3_ = this.FAlchemyStudio.PointList[_loc1_];
               if(_loc3_ == TAlchemyStudio.TYPE_NONE)
               {
                  _loc2_.MC_Icon.gotoAndStop(1);
                  _loc2_.TF_Count.text = "";
               }
               else if(_loc3_ == TAlchemyStudio.TYPE_DOUBLE)
               {
                  _loc2_.MC_Icon.gotoAndStop(2);
                  _loc2_.TF_Count.text = "";
               }
               else if(_loc3_ == TAlchemyStudio.TYPE_MINUS)
               {
                  _loc2_.MC_Icon.gotoAndStop(3);
                  _loc2_.TF_Count.text = "";
               }
               else
               {
                  _loc2_.MC_Icon.gotoAndStop(4);
                  _loc2_.TF_Count.text = this.FAlchemyStudio.PointList[_loc1_];
               }
               _loc1_++;
            }
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TBaseBox = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.FShowItem.UpdateUI(this.FAlchemyStudio.ShowItems);
         _loc3_ = 0;
         while(_loc3_ < GIFT_COUNT)
         {
            _loc1_ = FMC_Scene["MC_Gift" + _loc3_];
            _loc2_ = this.FAlchemyStudio.Gift[_loc3_];
            _loc1_.TF_Desc.text = TUtilityString.Format(this.FAlchemyStudio.DescListNew[14],_loc2_.Price);
            if(_loc2_.IsHot == 1)
            {
               _loc1_.MC_Effect.visible = true;
               _loc1_.MC_Effect.play();
            }
            else
            {
               _loc1_.MC_Effect.visible = false;
               _loc1_.MC_Effect.stop();
            }
            if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc1_.MC_Click.visible = false;
               _loc1_.MC_Got.visible = false;
            }
            else if(_loc2_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc1_.MC_Click.visible = true;
               _loc1_.MC_Got.visible = false;
            }
            else
            {
               _loc1_.MC_Click.visible = false;
               _loc1_.MC_Got.visible = true;
            }
            if(this.FAlchemyStudio.ScoreB >= _loc2_.Price)
            {
               FMC_Scene["MC_Bar" + _loc3_].filters = [];
            }
            else
            {
               FMC_Scene["MC_Bar" + _loc3_].filters = [TGameUtil.GaryColorFilters];
            }
            _loc3_++;
         }
         this.FUIPage.TotalQuantity = this.FAlchemyStudio.RechargeList.length;
         this.FUIPage.Update();
         _loc4_ = this.FCurPage;
         _loc2_ = this.FAlchemyStudio.RechargeList[_loc4_];
         FMC_Scene.MC_RechargeBox.TF_RechargeGold.text = this.FAlchemyStudio.RechargeGold.toString();
         FMC_Scene.MC_RechargeBox.TF_Count.text = _loc2_.Inventories.GetInventoryByIndex(0).Quantity.toString();
         FMC_Scene.MC_RechargeBox.TF_Price.text = TUtilityString.Format(this.FAlchemyStudio.DescListNew[5],_loc2_.Price);
         if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.MC_RechargeBox.MC_Got.visible = false;
            FMC_Scene.MC_RechargeBox.MC_Click.visible = false;
         }
         else if(_loc2_.Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_RechargeBox.MC_Got.visible = false;
            FMC_Scene.MC_RechargeBox.MC_Click.visible = true;
         }
         else
         {
            FMC_Scene.MC_RechargeBox.MC_Got.visible = true;
            FMC_Scene.MC_RechargeBox.MC_Click.visible = false;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FAlchemyStudio.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FAlchemyStudio.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FAlchemyStudio.DescListNew[1];
         FMC_Scene.MC_MyScore.TF_Count.text = this.FAlchemyStudio.ScoreB.toString();
         FMC_Scene.TF_GameValue.text = this.FAlchemyStudio.GameValue.toString();
         if(this.FAlchemyStudio.GameBuff == 0)
         {
            FMC_Scene.MC_Minus.visible = false;
            FMC_Scene.MC_Double.visible = false;
         }
         else if(this.FAlchemyStudio.GameBuff > 0)
         {
            FMC_Scene.MC_Minus.visible = false;
            FMC_Scene.MC_Double.visible = true;
            FMC_Scene.MC_Double.TF_Count.text = "x" + this.FAlchemyStudio.GameBuff;
         }
         else
         {
            FMC_Scene.MC_Minus.visible = true;
            FMC_Scene.MC_Double.visible = false;
            FMC_Scene.MC_Minus.TF_Count.text = "/" + Math.abs(this.FAlchemyStudio.GameBuff);
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
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0, param7:int = 0) : void
      {
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
         if(this.FBeClicked)
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
      
      protected function ProcessorOnPointUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(Boolean(!this.FIsPlaying) && Boolean(this.FAlchemyStudio) && this.FAlchemyStudio.PointList[_loc2_] == TAlchemyStudio.TYPE_NONE)
         {
            this.ProcessorOnBuyBoxUp(ACTIVITY_2_FIND_TEASURE,this.FAlchemyStudio.Price,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(!this.FIsPlaying && _loc2_ < this.FAlchemyStudio.Gift.length && this.FAlchemyStudio.Gift[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_2_GET_GIFT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnAutoUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!this.FIsPlaying)
         {
            this.ProcessorOnBuyBoxUp(ACTIVITY_2_AUTO_PLAY,this.FAlchemyStudio.AutoPrice);
         }
      }
      
      protected function ProcessorOnGetUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!this.FIsPlaying)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_2_GET_SCOREB);
         }
      }
      
      protected function ProcessorOnStartUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FAlchemyStudio.ScoreA > 0)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_2_PLAY_GAME);
         }
         else
         {
            _loc2_ = TUtilityString.Format(this.FAlchemyStudio.DescListNew[3],this.FAlchemyStudio.ScorePrice);
            this.ProcessorOnBuyBoxUp(ACTIVITY_2_PLAY_GAME,this.FAlchemyStudio.ScorePrice,0,0,_loc2_);
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
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(!this.FIsPlaying && _loc2_ < this.FAlchemyStudio.Gift.length)
         {
            ProcessorOnNewBoxOver(this.FAlchemyStudio.Gift[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnRechargeBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         _loc3_ = _loc2_ + this.FCurPage;
         if(!this.FIsPlaying && this.FAlchemyStudio.RechargeList[_loc3_].Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_2_GET_RECHARGE_BOX,_loc3_ + 1);
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateBox();
      }
      
      protected function ProcessorOnTip0Over(param1:MouseEvent) : void
      {
         if(this.FAlchemyStudio)
         {
            ProcessorOnShowHtmlText(this.FAlchemyStudio.DescListNew[9]);
         }
      }
      
      protected function ProcessorOnTip1Over(param1:MouseEvent) : void
      {
         if(this.FAlchemyStudio)
         {
            ProcessorOnShowHtmlText(this.FAlchemyStudio.DescListNew[10]);
         }
      }
      
      protected function ProcessorOnAutoOver(param1:MouseEvent) : void
      {
         if(this.FAlchemyStudio)
         {
            ProcessorOnShowHtmlText(this.FAlchemyStudio.DescListNew[11]);
         }
      }
      
      protected function ProcessorOnGetOver(param1:MouseEvent) : void
      {
         if(this.FAlchemyStudio)
         {
            ProcessorOnShowHtmlText(this.FAlchemyStudio.DescListNew[12]);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FAlchemyStudio;
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
      }
      
      protected function ProcessorOnOpenTitleDesc(param1:MouseEvent) : void
      {
         ProcessorOnShowOtherWindow(WINDOW_TITLE_DESC,this.FAlchemyStudio);
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
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
         PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         this.visible = false;
         this.FIsOpen = false;
         TweenUtil.removeAllTween();
         super.Unmount();
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
         this.FUnstreamizerAlchemyStudio.Unstreamize(_loc2_,this.FAlchemyStudio,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.FActivityTaskData = this.FAlchemyStudio.ActivityTaskData;
            this.UpdateUI();
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
         if(this.FAlchemyStudio)
         {
            this.FAlchemyStudio.RechargeGold = _loc2_.readUnsignedInt();
            this.FAlchemyStudio.ChangeStatus();
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
         ProcessorUnstreamActivityLog(this.FAlchemyStudio,_loc2_);
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
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:TBaseBox = null;
         var _loc16_:uint = 0;
         var _loc17_:TBins = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:Vector.<Object> = null;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         var _loc27_:Vector.<uint> = null;
         var _loc28_:Vector.<uint> = null;
         var _loc29_:String = null;
         var _loc30_:int = 0;
         var _loc31_:TDessertHouseTask = null;
         _loc17_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
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
            case ACTIVITY_2_PLAY_GAME:
               if(this.FAlchemyStudio.ScoreA > 0)
               {
                  --this.FAlchemyStudio.ScoreA;
               }
               this.FAlchemyStudio.GameStatus = TBaseActivity.STATUS_CANGET;
               this.FAlchemyStudio.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FAlchemyStudio.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_2_FIND_TEASURE:
               this.FOpenIndex = _loc2_.readUnsignedInt() - 1;
               this.FAlchemyStudio.PointList[this.FOpenIndex] = _loc2_.readInt();
               this.FAlchemyStudio.GameStatus = _loc2_.readInt();
               this.FAlchemyStudio.GameBuff = _loc2_.readInt();
               this.FAlchemyStudio.GameValue = _loc2_.readInt();
               if(this.FAlchemyStudio.PointList[[this.FOpenIndex]] == TAlchemyStudio.TYPE_MINUS)
               {
                  _loc4_ = this.FAlchemyStudio.DescListNew[7];
               }
               else if(this.FAlchemyStudio.PointList[[this.FOpenIndex]] == TAlchemyStudio.TYPE_DOUBLE)
               {
                  _loc4_ = this.FAlchemyStudio.DescListNew[15];
               }
               else
               {
                  _loc4_ = TUtilityString.Format(this.FAlchemyStudio.DescListNew[6],this.FAlchemyStudio.PointList[this.FOpenIndex]);
               }
               ProcessorEffectText(_loc4_);
               this.FAlchemyStudio.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FAlchemyStudio.CheckStatus());
               this.PlayMovie(MOVIE_OF_PLAY_GAME);
               break;
            case ACTIVITY_2_GET_SCOREB:
               _loc14_ = int(_loc2_.readUnsignedInt());
               _loc4_ = TUtilityString.Format(this.FAlchemyStudio.DescListNew[2],_loc14_);
               this.FAlchemyStudio.ScoreB += _loc14_;
               ProcessorEffectText(_loc4_);
               this.FAlchemyStudio.ChangeStatus();
               this.FAlchemyStudio.Reset();
               ProcessorCheckEffect(FActivityID,this.FAlchemyStudio.CheckStatus());
               this.PlayMovie(MOVIE_OF_FLOW);
               break;
            case ACTIVITY_2_AUTO_PLAY:
               _loc14_ = int(_loc2_.readUnsignedInt());
               this.FAlchemyStudio.GameValue = _loc14_;
               this.FAlchemyStudio.GameBuff = _loc2_.readInt();
               _loc6_ = 0;
               while(_loc6_ < this.FAlchemyStudio.PointList.length)
               {
                  this.FAlchemyStudio.PointList[_loc6_] = _loc2_.readInt();
                  _loc6_++;
               }
               this.FAlchemyStudio.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FAlchemyStudio.CheckStatus());
               _loc4_ = TUtilityString.Format(this.FAlchemyStudio.DescListNew[6],_loc14_);
               ProcessorEffectText(_loc4_);
               this.PlayMovie(MOVIE_OF_AUTO);
               break;
            case ACTIVITY_2_GET_GIFT:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FAlchemyStudio.ScoreA = _loc2_.readUnsignedInt();
               this.FAlchemyStudio.ScoreB = _loc2_.readUnsignedInt();
               this.FAlchemyStudio.Gift[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FAlchemyStudio.Gift[_loc5_].Inventories.Count)
               {
                  _loc9_ = this.FAlchemyStudio.Gift[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               ProcessorEffectText(_loc4_);
               this.FAlchemyStudio.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FAlchemyStudio.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_2_GET_RECHARGE_BOX:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FAlchemyStudio.ScoreA = _loc2_.readUnsignedInt();
               this.FAlchemyStudio.ScoreB = _loc2_.readUnsignedInt();
               this.FAlchemyStudio.RechargeList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FAlchemyStudio.RechargeList[_loc5_].Inventories.Count)
               {
                  _loc9_ = this.FAlchemyStudio.RechargeList[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               ProcessorEffectText(_loc4_);
               this.FAlchemyStudio.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FAlchemyStudio.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_TASK:
               _loc12_ = _loc2_.readUnsignedInt();
               _loc31_ = this.FActivityTaskData.GetTaskByIdentify(_loc12_);
               if(_loc31_ != null)
               {
                  _loc31_.Status = TBaseActivity.STATUS_CANGET;
                  _loc31_.Process = 0;
               }
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET_TASK_SUCCESS);
               ProcessorCheckEffect(FActivityID,this.FAlchemyStudio.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_FINISH_TASK:
               _loc12_ = _loc2_.readUnsignedInt();
               _loc31_ = this.FActivityTaskData.GetTaskByIdentify(_loc12_);
               this.FActivityTaskData.NeedShine = _loc2_.readUnsignedInt();
               if(_loc31_ != null)
               {
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc31_.TaskAward[_loc31_.Step].Count)
                  {
                     _loc9_ = _loc31_.TaskAward[_loc31_.Step].GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ++_loc31_.Step;
                  if(_loc31_.Step >= TActivityTaskData.STEP_COUNT)
                  {
                     _loc31_.Status = TBaseActivity.STATUS_GETED;
                  }
                  else
                  {
                     _loc31_.Process = 0;
                     _loc31_.Status = TBaseActivity.STATUS_CANNOTGET;
                  }
               }
               this.FAlchemyStudio.ScoreA = _loc2_.readUnsignedInt();
               this.FAlchemyStudio.ScoreB = _loc2_.readUnsignedInt();
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FAlchemyStudio.CheckStatus());
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
         if(this.FMovieType == MOVIE_OF_PLAY_GAME)
         {
            _loc5_ = this.FAlchemyStudio.PointList[this.FOpenIndex];
            _loc3_ = this.FOpenIndex;
            if(_loc5_ == TAlchemyStudio.TYPE_DOUBLE)
            {
               this.FPlayMovie = FMC_Scene["MC_Point" + _loc3_].MC_Movie2;
               FMC_Scene["MC_Point" + _loc3_].MC_Icon.gotoAndStop(2);
               FMC_Scene["MC_Point" + _loc3_].TF_Count.text = "";
            }
            else if(_loc5_ == TAlchemyStudio.TYPE_MINUS)
            {
               this.FPlayMovie = FMC_Scene["MC_Point" + _loc3_].MC_Movie0;
               FMC_Scene["MC_Point" + _loc3_].MC_Icon.gotoAndStop(3);
               FMC_Scene["MC_Point" + _loc3_].TF_Count.text = "";
            }
            else
            {
               this.FPlayMovie = FMC_Scene["MC_Point" + _loc3_].MC_Movie1;
               FMC_Scene["MC_Point" + _loc3_].MC_Icon.gotoAndStop(4);
               FMC_Scene["MC_Point" + _loc3_].TF_Count.text = "*" + this.FAlchemyStudio.PointList[this.FOpenIndex];
            }
            this.FPlayMovie.visible = true;
            this.FTotalFrame = this.FPlayMovie.totalFrames;
            this.FPlayMovie.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_FLOW)
         {
            this.FPlayMovie = FMC_Scene.MC_Movie0;
            this.FPlayMovie.visible = true;
            this.FTotalFrame = this.FPlayMovie.totalFrames;
            this.FPlayMovie.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_AUTO)
         {
            this.FPlayMovie = FMC_Scene.MC_Movie1;
            this.FPlayMovie.visible = true;
            this.FTotalFrame = this.FPlayMovie.totalFrames;
            this.FPlayMovie.gotoAndPlay(1);
         }
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         this.FIsPlaying = false;
         if(this.FMovieType == MOVIE_OF_PLAY_GAME)
         {
            this.FPlayMovie.visible = false;
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_FLOW)
         {
            this.FPlayMovie.visible = false;
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_AUTO)
         {
            this.FPlayMovie.visible = false;
            this.UpdateUI();
         }
      }
      
      public function Test() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

