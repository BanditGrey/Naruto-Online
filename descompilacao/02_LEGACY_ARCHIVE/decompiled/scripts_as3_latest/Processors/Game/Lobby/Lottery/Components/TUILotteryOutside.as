package Processors.Game.Lobby.Lottery.Components
{
   import Components.Slots.TUISlot;
   import Foundation.Common.THint;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLottery;
   import Logics.Lottery.TLotteryItem;
   import Logics.SLogicsCore;
   import Logics.Spaces.*;
   import Processors.Game.Lobby.Lottery.TProcessorLottery;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_LOTTERY;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_LOTTERY;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import ghostcat.util.easing.TweenUtil;
   
   use namespace LogicsSpace;
   
   public class TUILotteryOutside extends TUIComponent
   {
      
      protected static const ROW_COUNT:int = 5;
      
      protected static const COL_COUNT:int = 5;
      
      protected static const ROUND_COUNT:int = 16;
      
      protected static const TYPE_SINGLE_LOTTERY:int = 0;
      
      protected static const TYPE_TEN_TIMES_LOTTERY:int = 1;
      
      protected static const TYPE_FIFTY_TIMES_LOTTERY:int = 2;
      
      protected static const TAB_TYPE_FREE_LOTTERY:int = TProcessorLottery.TAB_TYPE_FREE_LOTTERY;
      
      protected static const TAB_TYPE_GOLD_LOTTERY:int = TProcessorLottery.TAB_TYPE_GOLD_LOTTERY;
      
      protected static const MOVE_X:Number = 77;
      
      protected static const MOVE_Y:Number = 77;
      
      protected static const SELECTED_INIT_X:Number = 2;
      
      protected static const SELECTED_INIT_Y:Number = 2;
      
      protected static const SELECTED_END_X:Number = SELECTED_INIT_X + (ROW_COUNT - 1) * MOVE_X;
      
      protected static const SELECTED_END_Y:Number = SELECTED_INIT_Y + (COL_COUNT - 1) * MOVE_Y;
      
      protected static const SPEED_UP:int = 2;
      
      protected static const SPEED_DOWN:int = 5;
      
      protected static const ADD_ROUND:int = 2;
      
      protected static const RANDOM_ROUND:int = 3;
      
      protected static const STOP_STEP:int = 2;
      
      protected static const RANDOM_STOP_STEP:int = 2;
      
      protected static const INTERVAL_TIMES:int = 6;
      
      protected static const TOTAL_SHINE_TIME:int = 120;
      
      public static const FFilterColor:int = 16711680;
      
      public static const FilterGlowWidth:int = 10;
      
      public static const FilterGlowStrength:int = 20;
      
      public static const SINGLE_FIRST_STEP:int = 0;
      
      public static const SINGLE_SECOND_STEP:int = 1;
      
      public static const SINGLE_FIRST_SPEED:int = 7;
      
      public static const SINGLE_SECOND_SPEED:int = 1;
      
      protected static const TYPE_COLOR_PURPLE:int = 1;
      
      protected static const TYPE_COLOR_GOLD:int = 2;
      
      protected static const TYPE_COLOR_RED:int = 3;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBtn_Start:MovieClip;
      
      protected var FBtn_10Times:MovieClip;
      
      protected var FBtn_50Times:MovieClip;
      
      protected var FMC_Selected:MovieClip;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FMC_Bar:MovieClip;
      
      protected var FTF_Process:TextField;
      
      protected var FMC_BarProgress:MovieClip;
      
      protected var FMC_LotteryTime:Sprite;
      
      protected var FTF_CDTime:TextField;
      
      protected var FInitialized:Boolean;
      
      protected var FLotteryCostType:int;
      
      protected var FCurRound:int;
      
      protected var FMoveRound:int;
      
      protected var FTotalMoveStep:int;
      
      protected var FEndStep:int;
      
      protected var FSelectedIndex:int;
      
      protected var FMoveStep:int;
      
      protected var FMoveSpeed:int;
      
      protected var FCurSpeed:int;
      
      protected var FCurStatus:int;
      
      protected var FMoveFlag:int;
      
      protected var FStopSlowIndex:int;
      
      protected var FShineFlag:Boolean;
      
      protected var FShineTime:int;
      
      protected var FTotalShineTime:int;
      
      protected var FIsMoveStart:Boolean;
      
      protected var FLotteryType:int;
      
      protected var FMaxWidth:int;
      
      protected var FMaxPoint:Vector.<int>;
      
      protected var FLotteryPoint:Vector.<int>;
      
      protected var FFreeIndex:int;
      
      protected var FGoldIndex:int;
      
      protected var FFreeSelectedArray:Vector.<int>;
      
      protected var FGoldSelectedArray:Vector.<int>;
      
      protected var FFreeOutsideItems:Vector.<TLotteryItem>;
      
      protected var FGoldOutsideItems:Vector.<TLotteryItem>;
      
      protected var FFireEffectList:Vector.<MovieClip>;
      
      protected var FGetEffectList:Vector.<MovieClip>;
      
      protected var FMC_ProgressEffect:MovieClip;
      
      protected var FIsWaiting:Boolean;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FHintBoxTip:THint;
      
      protected var FIsFirst:Boolean;
      
      protected var FCost:int;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FOnFreeLotteryUp:Function;
      
      protected var FOnGoldLotteryUp:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FOnMovieEnd:Function;
      
      public function TUILotteryOutside(param1:TUIComponent)
      {
         super(param1);
         this.FFreeSelectedArray = new Vector.<int>();
         this.FGoldSelectedArray = new Vector.<int>();
         this.FSlotList = new Vector.<TUISlot>(ROUND_COUNT);
         this.FMaxPoint = new Vector.<int>(2);
         this.FLotteryPoint = new Vector.<int>(2);
         this.FFreeOutsideItems = new Vector.<TLotteryItem>();
         this.FGoldOutsideItems = new Vector.<TLotteryItem>();
         this.FFireEffectList = new Vector.<MovieClip>(ROUND_COUNT);
         this.FGetEffectList = new Vector.<MovieClip>(ROUND_COUNT);
         this.FHintBoxTip = new THint();
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         this.FMC_Selected = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_Selected];
         this.Resources_UIDispatch_Btn();
         this.Resources_UIDispatch_Slot();
         this.Resources_UIDispatch_Bar();
         this.Resources_UIDispatch_Effect();
         if(this.FMC_Scene["MC_Boom"])
         {
            this.FMC_Scene["MC_Boom"].mouseEnabled = false;
         }
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent.Parent.Parent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent.Parent.Parent);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
      }
      
      protected function Resources_UIDispatch_Btn() : void
      {
         this.FMC_LotteryTime = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_LotteryTime];
         this.FTF_CDTime = this.FMC_LotteryTime[CONST_LOTTERY.RESOURCE_Link_TF_Time];
         this.FBtn_Start = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_Btn_Start];
         this.FBtn_10Times = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_Btn_10Times];
         this.FBtn_50Times = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_Btn_50Times];
         TGameUtil.setButtonMode(this.FBtn_Start,true);
         TGameUtil.setButtonMode(this.FBtn_10Times,true);
         TGameUtil.setButtonMode(this.FBtn_50Times,true);
      }
      
      protected function Resources_UIDispatch_Slot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUISlot = null;
         _loc1_ = 0;
         while(_loc1_ < ROUND_COUNT)
         {
            _loc2_ = new TUISlot(this);
            _loc2_.Resource = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_Slot + _loc1_] as Sprite;
            _loc2_.Resource.visible = false;
            _loc2_.Resource[CONST_LOTTERY.RESOURCE_Link_MC_Selected].visible = false;
            _loc2_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc2_.OnOverlay = this.SlotsOnOver;
            _loc2_.OnOut = this.SlotsOnOut;
            _loc2_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc2_.Init();
            this.FSlotList[_loc1_] = _loc2_;
            _loc1_++;
         }
      }
      
      protected function Resources_UIDispatch_Bar() : void
      {
         this.FTF_Process = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_TF_Process];
         this.FMC_Bar = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_Bar];
         this.FMC_BarProgress = this.FMC_Bar[CONST_LOTTERY.RESOURCE_Link_MC_BarProgress];
         this.FMaxWidth = this.FMC_Bar["mc_zhezhao"].width;
      }
      
      protected function Resources_UIDispatch_Effect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUISlot = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < ROUND_COUNT)
         {
            _loc3_ = this.FSlotList[_loc1_].Resource["MC_Fire"] as MovieClip;
            this.FFireEffectList[_loc1_] = _loc3_;
            _loc4_ = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_Get + _loc1_] as MovieClip;
            this.FGetEffectList[_loc1_] = _loc4_;
            _loc4_.visible = false;
            _loc1_++;
         }
         this.FMC_ProgressEffect = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_ProgressEffect] as MovieClip;
         this.FMC_ProgressEffect.visible = false;
      }
      
      protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Start.addEventListener(MouseEvent.CLICK,this.ProcessorOnStartClick);
         this.FBtn_Start.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMouseOver);
         this.FBtn_Start.addEventListener(MouseEvent.MOUSE_OUT,this.OnMouseOut);
         this.FBtn_10Times.addEventListener(MouseEvent.CLICK,this.ProcessorOn10TimesClick);
         this.FBtn_10Times.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMouseOver);
         this.FBtn_10Times.addEventListener(MouseEvent.MOUSE_OUT,this.OnMouseOut);
         this.FBtn_50Times.addEventListener(MouseEvent.CLICK,this.ProcessorOn50TimesClick);
         this.FBtn_50Times.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMouseOver);
         this.FBtn_50Times.addEventListener(MouseEvent.MOUSE_OUT,this.OnMouseOut);
         this.FMC_Selected.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnMove);
         this.FMC_Selected.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnOut);
      }
      
      protected function UpdateBtn() : void
      {
         var _loc1_:Number = SLogicsCore.Lottery.NextTime - STimingCore.GetServerTick();
         var _loc2_:int = int(SLogicsCore.Character.VipLevel);
         var _loc3_:int = int(SLogicsCore.Lottery.VipLv);
         if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
         {
            this.FBtn_10Times.visible = false;
            this.FBtn_50Times.visible = false;
            if(!this.FIsMoveStart && _loc1_ <= 0)
            {
               this.FBtn_Start.visible = true;
               TGameUtil.setButtonMode(this.FBtn_Start,true);
               this.FMC_LotteryTime.visible = false;
            }
            else
            {
               this.FBtn_Start.visible = false;
               TGameUtil.setButtonMode(this.FBtn_Start,false);
               this.FMC_LotteryTime.visible = true;
               this.FTF_CDTime.text = TGameUtil.fomatTime(_loc1_);
            }
            if(this.FMC_Scene["MC_Boom"])
            {
               this.FMC_Scene["MC_Boom"].visible = false;
            }
            if(this.FMC_Scene["MC_BoomRect"])
            {
               this.FMC_Scene["MC_BoomRect"].visible = false;
            }
         }
         else
         {
            this.FBtn_Start.visible = true;
            this.FBtn_10Times.visible = true;
            this.FBtn_50Times.visible = true;
            this.FMC_LotteryTime.visible = false;
            if(_loc2_ < _loc3_)
            {
               this.SetBtnMode(false);
            }
            else
            {
               this.SetBtnMode(true);
            }
            if(this.FMC_Scene["MC_Boom"])
            {
               this.FMC_Scene["MC_Boom"].visible = true;
            }
            if(this.FMC_Scene["MC_BoomRect"])
            {
               this.FMC_Scene["MC_BoomRect"].visible = true;
            }
         }
      }
      
      protected function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:TUISlot = null;
         if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
         {
            _loc3_ = this.FFreeIndex;
         }
         else
         {
            _loc3_ = this.FGoldIndex;
         }
         _loc2_ = this.FSlotList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(!this.FIsMoveStart)
            {
               if(this.FLotteryType == TYPE_SINGLE_LOTTERY)
               {
                  this.SetSelectedStatus(1);
               }
               else
               {
                  this.SetSelectedStatus(2);
               }
            }
            else if(this.FLotteryType == TYPE_SINGLE_LOTTERY)
            {
               this.SetSelectedStatus(1);
            }
            else
            {
               this.SetSelectedStatus(0);
            }
            if(this.FSlotList[_loc1_] != null)
            {
               this.FSlotList[_loc1_].Update();
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBar() : void
      {
         var _loc1_:TLottery = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc1_ = SLogicsCore.Lottery;
         if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
         {
            _loc3_ = _loc1_.FreeExp;
         }
         else
         {
            _loc3_ = _loc1_.GoldExp;
         }
         _loc2_ = _loc1_.CostProgress;
         var _loc4_:int = _loc2_ * int(_loc3_ / _loc2_);
         _loc4_ = _loc3_ - _loc4_;
         this.FTF_Process.text = TUtilityString.Format(STRING_LOTTERY.FORMAT_Process,_loc4_,_loc2_);
         this.FMC_Bar["mc_zhezhao"].width = this.FMaxWidth * Number(_loc4_ / _loc2_);
      }
      
      protected function UpdateEffect() : void
      {
         var _loc1_:Vector.<TLotteryItem> = null;
         var _loc2_:TLottery = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = SLogicsCore.Lottery;
         if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
         {
            _loc1_ = _loc2_.FreeOutsideItems;
         }
         else
         {
            _loc1_ = _loc2_.GoldOutsideItems;
         }
         _loc3_ = int(_loc1_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc1_[_loc4_].IsShine == 0)
            {
               this.FFireEffectList[_loc4_].visible = false;
            }
            else
            {
               this.FFireEffectList[_loc4_].visible = true;
               if(_loc1_[_loc4_].ShineColor == TYPE_COLOR_GOLD)
               {
                  this.FFireEffectList[_loc4_].gotoAndStop("gold");
               }
               else if(_loc1_[_loc4_].ShineColor == TYPE_COLOR_RED)
               {
                  this.FFireEffectList[_loc4_].gotoAndStop("red");
               }
               else
               {
                  this.FFireEffectList[_loc4_].gotoAndStop("purple");
               }
            }
            _loc4_++;
         }
      }
      
      public function HideGetEffectList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FGetEffectList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FGetEffectList[_loc2_].visible = false;
            _loc2_++;
         }
      }
      
      protected function PlaySingleMovie() : void
      {
         if(!this.CheckIsMove())
         {
            return;
         }
         var _loc1_:Boolean = true;
         if(this.FMC_Selected.x >= SELECTED_INIT_X && this.FMC_Selected.x < SELECTED_END_X && this.FMC_Selected.y == SELECTED_INIT_Y && _loc1_)
         {
            this.FMC_Selected.x += MOVE_X;
            _loc1_ = false;
         }
         if(this.FMC_Selected.y >= SELECTED_INIT_Y && this.FMC_Selected.y < SELECTED_END_Y && this.FMC_Selected.x == SELECTED_END_X && _loc1_)
         {
            this.FMC_Selected.y += MOVE_Y;
            _loc1_ = false;
         }
         if(this.FMC_Selected.x <= SELECTED_END_X && this.FMC_Selected.x > SELECTED_INIT_Y && this.FMC_Selected.y == SELECTED_END_Y && _loc1_)
         {
            this.FMC_Selected.x -= MOVE_X;
            _loc1_ = false;
         }
         if(this.FMC_Selected.y <= SELECTED_END_Y && this.FMC_Selected.y > SELECTED_INIT_Y && this.FMC_Selected.x == SELECTED_INIT_X && _loc1_)
         {
            this.FMC_Selected.y -= MOVE_Y;
            _loc1_ = false;
         }
         --this.FTotalMoveStep;
         if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
         {
            this.FFreeIndex = this.FFreeIndex >= ROUND_COUNT - 1 ? 0 : int(this.FFreeIndex + 1);
         }
         else
         {
            this.FGoldIndex = this.FGoldIndex >= ROUND_COUNT - 1 ? 0 : int(this.FGoldIndex + 1);
         }
         ++this.FMoveStep;
         this.ChangeSlotStatus();
         if(this.FTotalMoveStep == 0)
         {
            this.FMoveStep = 0;
            this.FIsMoveStart = false;
            this.PlayGetMovie();
         }
      }
      
      protected function PlayGetMovie() : void
      {
         var _loc1_:MovieClip = null;
         if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
         {
            _loc1_ = this.FGetEffectList[this.FFreeIndex];
         }
         else
         {
            _loc1_ = this.FGetEffectList[this.FGoldIndex];
         }
         _loc1_.visible = true;
         _loc1_.gotoAndPlay(1);
         _loc1_.MC_Get.TF_Count.text = "*1";
         TweenUtil.to(_loc1_,2000,{"onComplete":this.GetMovieEnd});
      }
      
      protected function GetMovieEnd() : void
      {
         var _loc1_:MovieClip = null;
         if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
         {
            _loc1_ = this.FGetEffectList[this.FFreeIndex];
         }
         else
         {
            _loc1_ = this.FGetEffectList[this.FGoldIndex];
         }
         this.FIsMoveStart = false;
         _loc1_.gotoAndStop(_loc1_.totalFrames);
         this.UpdateUI();
         if(this.FOnMovieEnd != null)
         {
            this.FOnMovieEnd(true);
         }
      }
      
      protected function PlayTimesMovie() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUISlot = null;
         ++this.FShineTime;
         --this.FTotalShineTime;
         if(this.FShineTime >= INTERVAL_TIMES)
         {
            _loc1_ = 0;
            while(_loc1_ < ROUND_COUNT)
            {
               _loc2_ = this.FSlotList[_loc1_];
               if(this.FShineFlag)
               {
                  if(_loc1_ % 2 == 0)
                  {
                     _loc2_.SetHighLightFilters(true);
                  }
                  else
                  {
                     _loc2_.SetHighLightFilters(false);
                  }
               }
               else if((_loc1_ + 1) % 2 == 0)
               {
                  _loc2_.SetHighLightFilters(true);
               }
               else
               {
                  _loc2_.SetHighLightFilters(false);
               }
               _loc1_++;
            }
            this.FShineFlag = !this.FShineFlag;
            this.FShineTime = 0;
         }
         if(this.FTotalShineTime <= 0)
         {
            this.FIsMoveStart = false;
            this.PlayTimesGetMovie();
         }
      }
      
      protected function PlayTimesGetMovie() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Vector.<int> = new Vector.<int>(ROUND_COUNT);
         _loc3_ = int(this.FGoldSelectedArray.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FGoldSelectedArray[_loc2_];
            ++_loc5_[_loc4_];
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FGoldSelectedArray[_loc2_];
            _loc1_ = this.FGetEffectList[_loc4_];
            _loc1_.visible = true;
            _loc1_.gotoAndPlay(1);
            _loc1_.MC_Get.TF_Count.text = "*" + _loc5_[_loc4_].toString();
            _loc2_++;
         }
         TweenUtil.to(_loc1_,2000,{"onComplete":this.TimesGetMovieEnd});
      }
      
      protected function TimesGetMovieEnd() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Vector.<int> = null;
         _loc3_ = int(this.FGoldSelectedArray.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FGoldSelectedArray[_loc2_];
            _loc1_ = this.FGetEffectList[_loc4_];
            _loc1_.gotoAndStop(_loc1_.totalFrames);
            _loc2_++;
         }
         this.FIsMoveStart = false;
         this.SetSelectedStatus(2);
         this.UpdateUI();
         if(this.FOnMovieEnd != null)
         {
            this.FOnMovieEnd(true);
         }
      }
      
      protected function GetLotteryItemCount() : int
      {
         return 1;
      }
      
      protected function CheckIsMove() : Boolean
      {
         ++this.FMoveFlag;
         if(this.FMoveStep == 0)
         {
            this.FMoveSpeed = SINGLE_FIRST_SPEED;
         }
         else
         {
            this.FCurStatus = SINGLE_SECOND_STEP;
         }
         if(this.FMoveFlag >= this.FMoveSpeed)
         {
            this.FMoveFlag = 0;
            if(this.FCurStatus == SINGLE_SECOND_STEP)
            {
               if(this.FMoveStep < this.FEndStep * 7 / 8)
               {
                  this.FMoveSpeed = this.FMoveSpeed > SINGLE_SECOND_SPEED ? int(this.FMoveSpeed - 1) : SINGLE_SECOND_SPEED;
               }
               else
               {
                  ++this.FMoveSpeed;
               }
            }
            return true;
         }
         return false;
      }
      
      protected function ChangeSlotStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
         {
            _loc3_ = this.FFreeIndex;
         }
         else
         {
            _loc3_ = this.FGoldIndex;
         }
         _loc2_ = this.FSlotList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc1_ == _loc3_)
            {
               this.FSlotList[_loc1_].SetHighLightFilters(true);
            }
            else
            {
               this.FSlotList[_loc1_].SetDarkFilters(true);
            }
            _loc1_++;
         }
      }
      
      protected function SetSelectedStatus(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
         {
            _loc6_ = this.FFreeSelectedArray;
         }
         else
         {
            _loc6_ = this.FGoldSelectedArray;
         }
         _loc3_ = this.FSlotList.length;
         if(param1 == 0)
         {
            this.FMC_Selected.visible = false;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = this.FSlotList[_loc2_].Resource[CONST_LOTTERY.RESOURCE_Link_MC_Selected];
               _loc4_.visible = false;
               _loc2_++;
            }
         }
         else if(param1 == 1)
         {
            this.FMC_Selected.visible = true;
            if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
            {
               _loc5_ = this.FFreeIndex;
            }
            else
            {
               _loc5_ = this.FGoldIndex;
            }
            if(!this.FIsMoveStart)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc3_)
               {
                  if(_loc5_ == _loc2_)
                  {
                     this.FSlotList[_loc2_].SetHighLightFilters(true);
                  }
                  else
                  {
                     this.FSlotList[_loc2_].SetHighLightFilters(false);
                  }
                  _loc4_ = this.FSlotList[_loc2_].Resource[CONST_LOTTERY.RESOURCE_Link_MC_Selected];
                  _loc4_.visible = false;
                  _loc2_++;
               }
            }
         }
         else
         {
            this.FMC_Selected.visible = false;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = this.FSlotList[_loc2_].Resource[CONST_LOTTERY.RESOURCE_Link_MC_Selected];
               if(_loc6_ == null || _loc6_.length == 0)
               {
                  this.FSlotList[0].SetHighLightFilters(true);
               }
               else if(_loc6_.indexOf(_loc2_) != -1)
               {
                  this.FSlotList[_loc2_].SetHighLightFilters(true);
                  _loc4_.visible = true;
               }
               else
               {
                  this.FSlotList[_loc2_].SetHighLightFilters(false);
                  _loc4_.visible = false;
               }
               _loc2_++;
            }
         }
      }
      
      protected function PlayProgressEffect() : void
      {
         this.FMC_ProgressEffect.visible = true;
         this.FMC_ProgressEffect.gotoAndPlay(1);
         this.FMC_BarProgress.gotoAndPlay(1);
         TweenUtil.to(this.FMC_ProgressEffect,800,{"onComplete":this.HideProgressEffect});
      }
      
      protected function HideProgressEffect() : void
      {
         this.FMC_ProgressEffect.visible = false;
      }
      
      protected function HideFireEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FFireEffectList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FFireEffectList[_loc2_].visible = false;
            _loc2_++;
         }
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence) : void
      {
         if(this.FOnQuerySequenceContext != null)
         {
            this.FOnQuerySequenceContext(this,param2,param3);
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:TInventory) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(param1,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(param1,param2);
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function ProceossorOnBuyUp(param1:int) : void
      {
         if(!this.FUIWindowConfirmation.IsSelected)
         {
            this.FCost = param1;
            this.FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            this.FUIWindowConfirmation.SetCheckBox(true);
            this.FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGold + _loc2_.CreditGiftCertificate >= this.FCost)
         {
            this.SetBtnMode(false);
            this.HideGetEffectList();
            this.HideFireEffect();
            switch(this.FLotteryType)
            {
               case TYPE_SINGLE_LOTTERY:
                  this.FIsWaiting = true;
                  if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
                  {
                     this.PerformPacket_CS_FreeLotteryReq();
                  }
                  else
                  {
                     this.PerformPacket_CS_GoldLotteryReq();
                  }
                  break;
               case TYPE_TEN_TIMES_LOTTERY:
                  this.PerformPacket_CS_GoldLotteryReq();
                  break;
               case TYPE_FIFTY_TIMES_LOTTERY:
                  this.PerformPacket_CS_GoldLotteryReq();
            }
         }
         else
         {
            this.FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnStartClick(param1:MouseEvent) : void
      {
         if(param1.currentTarget.buttonMode == false)
         {
            return;
         }
         if(this.FLotteryCostType == TAB_TYPE_GOLD_LOTTERY)
         {
            this.FCost = SLogicsCore.Lottery.OnePrice;
            this.ProceossorOnBuyUp(this.FCost);
         }
         else
         {
            this.FIsWaiting = true;
            this.SetBtnMode(false);
            this.HideGetEffectList();
            this.HideFireEffect();
            this.FLotteryType = TYPE_SINGLE_LOTTERY;
            if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
            {
               this.PerformPacket_CS_FreeLotteryReq();
            }
            else
            {
               this.PerformPacket_CS_GoldLotteryReq();
            }
         }
      }
      
      protected function ProcessorOn10TimesClick(param1:MouseEvent) : void
      {
         if(param1.currentTarget.buttonMode == false)
         {
            return;
         }
         this.FLotteryType = TYPE_TEN_TIMES_LOTTERY;
         this.FCost = SLogicsCore.Lottery.TenPrice;
         this.ProceossorOnBuyUp(this.FCost);
      }
      
      protected function ProcessorOn50TimesClick(param1:MouseEvent) : void
      {
         if(param1.currentTarget.buttonMode == false)
         {
            return;
         }
         this.FLotteryType = TYPE_FIFTY_TIMES_LOTTERY;
         this.FCost = SLogicsCore.Lottery.FiftyPrice;
         this.ProceossorOnBuyUp(this.FCost);
      }
      
      protected function PerformPacket_CS_FreeLotteryReq() : void
      {
         if(this.FOnFreeLotteryUp != null)
         {
            this.FOnFreeLotteryUp(1);
         }
      }
      
      protected function PerformPacket_CS_GoldLotteryReq() : void
      {
         if(this.FOnGoldLotteryUp != null)
         {
            this.FOnGoldLotteryUp(1,this.FLotteryType);
         }
      }
      
      protected function ProcessorOnMove(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
         {
            _loc2_ = this.FFreeOutsideItems[this.FFreeIndex].Inventories.GetInventoryByIndex(0);
         }
         else
         {
            _loc2_ = this.FGoldOutsideItems[this.FGoldIndex].Inventories.GetInventoryByIndex(0);
         }
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(null,_loc2_);
         }
      }
      
      protected function ProcessorOnOut(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
         {
            _loc2_ = this.FFreeOutsideItems[this.FFreeIndex].Inventories.GetInventoryByIndex(0);
         }
         else
         {
            _loc2_ = this.FGoldOutsideItems[this.FGoldIndex].Inventories.GetInventoryByIndex(0);
         }
         if(this.FOnOut != null)
         {
            this.FOnOut(null,_loc2_);
         }
      }
      
      protected function ProcessorOneLotteryRet(param1:int) : void
      {
         this.FIsMoveStart = true;
         this.FMoveRound = int(Math.random() * RANDOM_ROUND) + ADD_ROUND;
         this.FEndStep = this.FTotalMoveStep = param1 + this.FMoveRound * ROUND_COUNT - this.FGoldIndex;
         this.FStopSlowIndex = int(Math.random() * RANDOM_STOP_STEP) + STOP_STEP;
         this.SetSelectedStatus(1);
         this.SetBtnMode(false);
      }
      
      protected function ProcessorTimesLotteryRet() : void
      {
         this.FIsMoveStart = true;
         this.SetSelectedStatus(0);
         this.FTotalShineTime = TOTAL_SHINE_TIME;
      }
      
      protected function OnMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = int(SLogicsCore.Character.VipLevel);
         var _loc5_:int = int(SLogicsCore.Lottery.VipLv);
         if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
         {
            return;
         }
         if(_loc4_ < _loc5_)
         {
            _loc3_ = TUtilityString.Format(STRING_LOTTERY.FORMAT_VIP_LEVEL,_loc5_);
         }
         else if(param1.currentTarget.name == "Btn_Start")
         {
            _loc3_ = TUtilityString.Format(STRING_LOTTERY.FORMAT_COST_TIP,1,SLogicsCore.Lottery.OnePrice);
         }
         else if(param1.currentTarget.name == "Btn_10Times")
         {
            _loc3_ = TUtilityString.Format(STRING_LOTTERY.FORMAT_COST_TIP,10,SLogicsCore.Lottery.TenPrice);
         }
         else
         {
            _loc3_ = TUtilityString.Format(STRING_LOTTERY.FORMAT_COST_TIP,50,SLogicsCore.Lottery.FiftyPrice);
         }
         this.FHintBoxTip.Caption = _loc3_;
         if(this.FTipOnOver != null)
         {
            this.FTipOnOver(param1,this.FHintBoxTip);
         }
      }
      
      protected function OnMouseOut(param1:MouseEvent) : void
      {
         if(this.FTipOnOut != null)
         {
            this.FTipOnOut(param1);
         }
      }
      
      public function get OnQuerySequenceContext() : Function
      {
         return this.FOnQuerySequenceContext;
      }
      
      public function set OnQuerySequenceContext(param1:Function) : void
      {
         this.FOnQuerySequenceContext = param1;
      }
      
      public function get OnOverlay() : Function
      {
         return this.FOnOverlay;
      }
      
      public function set OnOverlay(param1:Function) : void
      {
         this.FOnOverlay = param1;
      }
      
      public function get OnOut() : Function
      {
         return this.FOnOut;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function get OnQuerySubscript() : Function
      {
         return this.FOnQuerySubscript;
      }
      
      public function set OnQuerySubscript(param1:Function) : void
      {
         this.FOnQuerySubscript = param1;
      }
      
      public function get OnFreeLotteryUp() : Function
      {
         return this.FOnFreeLotteryUp;
      }
      
      public function set OnFreeLotteryUp(param1:Function) : void
      {
         this.FOnFreeLotteryUp = param1;
      }
      
      public function get OnGoldLotteryUp() : Function
      {
         return this.FOnGoldLotteryUp;
      }
      
      public function set OnGoldLotteryUp(param1:Function) : void
      {
         this.FOnGoldLotteryUp = param1;
      }
      
      public function get TipOnOver() : Function
      {
         return this.FTipOnOver;
      }
      
      public function set TipOnOver(param1:Function) : void
      {
         this.FTipOnOver = param1;
      }
      
      public function get TipOnOut() : Function
      {
         return this.FTipOnOut;
      }
      
      public function set TipOnOut(param1:Function) : void
      {
         this.FTipOnOut = param1;
      }
      
      public function get IsMoveStart() : Boolean
      {
         return this.FIsMoveStart;
      }
      
      public function set IsMoveStart(param1:Boolean) : void
      {
         this.FIsMoveStart = param1;
      }
      
      public function get OnMovieEnd() : Function
      {
         return this.FOnMovieEnd;
      }
      
      public function set OnMovieEnd(param1:Function) : void
      {
         this.FOnMovieEnd = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.ResourcesPerform_UILocations();
         this.FInitialized = true;
      }
      
      public function SetItemInfo(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TInventory = null;
         if(param1 != this.FLotteryCostType)
         {
            this.HideGetEffectList();
         }
         if(this.FIsMoveStart)
         {
            return;
         }
         this.FLotteryCostType = param1;
         this.FFreeIndex = this.FGoldIndex = 0;
         this.FFreeSelectedArray.length = 0;
         this.FGoldSelectedArray.length = 0;
         this.FLotteryType = TYPE_SINGLE_LOTTERY;
         this.FFreeOutsideItems = SLogicsCore.Lottery.FreeOutsideItems;
         this.FGoldOutsideItems = SLogicsCore.Lottery.GoldOutsideItems;
         this.FMC_Selected.x = SELECTED_INIT_X;
         this.FMC_Selected.y = SELECTED_INIT_Y;
         _loc3_ = this.FSlotList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
            {
               _loc4_ = this.FFreeOutsideItems[_loc2_].Inventories.GetInventoryByIndex(0);
            }
            else
            {
               _loc4_ = this.FGoldOutsideItems[_loc2_].Inventories.GetInventoryByIndex(0);
            }
            this.FSlotList[_loc2_].Context = _loc4_;
            this.FSlotList[_loc2_].Resource.visible = true;
            _loc2_++;
         }
      }
      
      public function UpdateUI() : void
      {
         this.UpdateBtn();
         this.UpdateSlot();
         this.UpdateBar();
         this.UpdateEffect();
         if(!this.FIsFirst)
         {
            this.FIsFirst = true;
            this.FUIWindowConfirmation.Load();
            this.FUIWindowRecharge.Load();
         }
      }
      
      public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(this.FInitialized && this.Visible)
         {
            this.UpdateSlot();
            this.UpdateBar();
            _loc1_ = SLogicsCore.Lottery.NextTime - STimingCore.GetServerTick();
            this.FTF_CDTime.text = TGameUtil.fomatTime(_loc1_);
            if(_loc1_ <= 0)
            {
               this.FMC_LotteryTime.visible = false;
               this.FBtn_Start.visible = true;
               if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY && this.FBtn_Start.buttonMode == false && !this.FIsWaiting)
               {
                  TGameUtil.setButtonMode(this.FBtn_Start,true);
               }
            }
            if(this.FIsMoveStart)
            {
               if(this.FLotteryType == TYPE_SINGLE_LOTTERY)
               {
                  this.PlaySingleMovie();
               }
               else
               {
                  this.PlayTimesMovie();
               }
            }
         }
      }
      
      public function PerformPacket_SC_FreeLotteryRet(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TLottery = null;
         _loc3_ = SLogicsCore.Lottery;
         SLogicsCore.Lottery.NextTime = SLogicsCore.Lottery.CDTime + STimingCore.GetServerTick();
         _loc2_ = _loc3_.getItemIndexByIdentify(TLottery.TYPE_FREE_OUTSIDE,param1);
         if(_loc2_ == -1)
         {
            return;
         }
         this.FIsWaiting = false;
         _loc3_.FreeExp += _loc3_.GetProgess;
         this.PlayProgressEffect();
         this.FIsMoveStart = true;
         this.FMoveRound = int(Math.random() * RANDOM_ROUND) + ADD_ROUND;
         this.FEndStep = this.FTotalMoveStep = _loc2_ + this.FMoveRound * ROUND_COUNT - this.FFreeIndex;
         this.FStopSlowIndex = int(Math.random() * RANDOM_STOP_STEP) + STOP_STEP;
         this.SetSelectedStatus(1);
      }
      
      public function PerformPacket_SC_GoldLotteryRet(param1:Vector.<int>) : void
      {
         var _loc2_:Vector.<int> = null;
         var _loc3_:TLottery = null;
         _loc3_ = SLogicsCore.Lottery;
         _loc2_ = _loc3_.getItemsIndexByIdentifies(TLottery.TYPE_GOLD_OUTSIDE,param1);
         if(_loc2_ == null || _loc2_.length == 0)
         {
            return;
         }
         this.FIsWaiting = false;
         if(this.FLotteryType == TYPE_SINGLE_LOTTERY)
         {
            _loc3_.Point += _loc3_.GetPoint;
            _loc3_.GoldExp += _loc3_.GetProgess;
         }
         else if(this.FLotteryType == TYPE_TEN_TIMES_LOTTERY)
         {
            _loc3_.Point += _loc3_.GetPoint * 10;
            _loc3_.GoldExp += _loc3_.GetProgess * 10;
         }
         else
         {
            _loc3_.Point += _loc3_.GetPoint * 50;
            _loc3_.GoldExp += _loc3_.GetProgess * 50;
         }
         this.PlayProgressEffect();
         if(this.FLotteryType == TYPE_SINGLE_LOTTERY)
         {
            this.ProcessorOneLotteryRet(_loc2_[0]);
         }
         else
         {
            this.FGoldSelectedArray = _loc2_;
            this.ProcessorTimesLotteryRet();
         }
      }
      
      public function SetBtnMode(param1:Boolean) : void
      {
         TGameUtil.setButtonMode(this.FBtn_Start,param1);
         TGameUtil.setButtonMode(this.FBtn_10Times,param1);
         TGameUtil.setButtonMode(this.FBtn_50Times,param1);
      }
   }
}

