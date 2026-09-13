package Processors.Game.Lobby.Lottery.Components
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLottery;
   import Logics.Lottery.TLotteryItem;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Lottery.TProcessorLottery;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_LOTTERY;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUILotteryInside extends TUIComponent
   {
      
      protected static const TAB_TYPE_FREE_LOTTERY:int = TProcessorLottery.TAB_TYPE_FREE_LOTTERY;
      
      protected static const TAB_TYPE_GOLD_LOTTERY:int = TProcessorLottery.TAB_TYPE_GOLD_LOTTERY;
      
      protected static const ROUND_COUNT:int = 6;
      
      protected static const ADD_ROUND:int = 2;
      
      protected static const RANDOM_ROUND:int = 2;
      
      protected static const STOP_STEP:int = 2;
      
      protected static const RANDOM_STOP_STEP:int = 2;
      
      protected static const SLOT_POSITION:Array = [[12,72],[88,30],[164,72],[164,148],[88,182],[12,148]];
      
      public static const SINGLE_FIRST_STEP:int = 0;
      
      public static const SINGLE_SECOND_STEP:int = 1;
      
      public static const SINGLE_FIRST_SPEED:int = 7;
      
      public static const SINGLE_SECOND_SPEED:int = 1;
      
      public static const MOVE_SPEED:int = 4;
      
      protected static const TYPE_COLOR_PURPLE:int = 1;
      
      protected static const TYPE_COLOR_GOLD:int = 2;
      
      protected static const TYPE_COLOR_RED:int = 3;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBtn_Start:MovieClip;
      
      protected var FMC_Mask:Sprite;
      
      protected var FMC_Selected:MovieClip;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FTF_InsideTimes:TextField;
      
      protected var FInitialized:Boolean;
      
      protected var FMoveIndex:int;
      
      protected var FIsMoveStart:Boolean;
      
      protected var FMoveRound:int;
      
      protected var FCurRound:int;
      
      protected var FTotalMoveStep:int;
      
      protected var FEndStep:int;
      
      protected var FSelectedIndex:int;
      
      protected var FMoveStep:int;
      
      protected var FMoveSpeed:int;
      
      protected var FCurSpeed:int;
      
      protected var FCurStatus:int;
      
      protected var FMoveFlag:int;
      
      protected var FGoldIndex:int;
      
      protected var FFreeIndex:int;
      
      protected var FLotteryCostType:int;
      
      protected var FFreeInsideItems:Vector.<TLotteryItem>;
      
      protected var FGoldInsideItems:Vector.<TLotteryItem>;
      
      protected var FFireEffectList:Vector.<MovieClip>;
      
      protected var FGetEffectList:Vector.<MovieClip>;
      
      protected var FLockBtnStatus:Boolean;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FOnFreeLotteryUp:Function;
      
      protected var FOnGoldLotteryUp:Function;
      
      protected var FOnMovieEnd:Function;
      
      public function TUILotteryInside(param1:TUIComponent)
      {
         super(param1);
         this.FSlotList = new Vector.<TUISlot>(ROUND_COUNT);
         this.FFreeInsideItems = new Vector.<TLotteryItem>();
         this.FGoldInsideItems = new Vector.<TLotteryItem>();
         this.FFireEffectList = new Vector.<MovieClip>(ROUND_COUNT);
         this.FGetEffectList = new Vector.<MovieClip>(ROUND_COUNT);
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         this.FMC_Selected = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_Selected];
         this.FTF_InsideTimes = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_TF_InsideTimes];
         this.Resources_UIDispatch_Btn();
         this.Resources_UIDispatch_Slot();
         this.Resources_UIDispatch_Effect();
      }
      
      protected function Resources_UIDispatch_Btn() : void
      {
         this.FBtn_Start = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_Btn_Start];
         TGameUtil.setButtonMode(this.FBtn_Start,true);
         this.FMC_Mask = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_Mask];
         this.FMC_Mask.visible = true;
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
      }
      
      protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Start.addEventListener(MouseEvent.CLICK,this.ProcessorOnStartClick);
         this.FMC_Selected.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnMove);
         this.FMC_Selected.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnOut);
      }
      
      protected function UpdateBtn() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:TLottery = SLogicsCore.Lottery;
         if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
         {
            _loc2_ = _loc1_.FreeExp;
         }
         else
         {
            _loc2_ = _loc1_.GoldExp;
         }
         _loc3_ = _loc1_.CostProgress;
         if(_loc2_ >= _loc3_ && !this.FIsMoveStart)
         {
            TGameUtil.setButtonMode(this.FBtn_Start,true);
            this.FLockBtnStatus = true;
            this.UpdateMask(false);
         }
         else
         {
            TGameUtil.setButtonMode(this.FBtn_Start,false);
            this.FLockBtnStatus = false;
            this.UpdateMask(true);
         }
         this.FTF_InsideTimes.text = "*" + int(_loc2_ / _loc3_).toString();
      }
      
      protected function UpdateMask(param1:Boolean) : void
      {
         this.FMC_Mask.visible = param1;
         if(param1)
         {
            this.filters = [TGameUtil.GaryColorFilters];
         }
         else
         {
            this.filters = [];
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
               if(_loc3_ == _loc1_)
               {
                  this.FSlotList[_loc1_].SetHighLightFilters(true);
               }
               else
               {
                  this.FSlotList[_loc1_].SetHighLightFilters(false);
               }
            }
            if(this.FSlotList[_loc1_] != null)
            {
               this.FSlotList[_loc1_].Update();
            }
            _loc1_++;
         }
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
            _loc1_ = _loc2_.FreeInsideItems;
         }
         else
         {
            _loc1_ = _loc2_.GoldInsideItems;
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
      
      protected function CheckSelectedStatus() : void
      {
         if(!this.CheckIsMove())
         {
            return;
         }
         ++this.FMoveStep;
         --this.FTotalMoveStep;
         if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
         {
            this.FFreeIndex = this.FFreeIndex >= ROUND_COUNT - 1 ? 0 : int(this.FFreeIndex + 1);
            this.FMC_Selected.x = SLOT_POSITION[this.FFreeIndex][0];
            this.FMC_Selected.y = SLOT_POSITION[this.FFreeIndex][1];
         }
         else
         {
            this.FGoldIndex = this.FGoldIndex >= ROUND_COUNT - 1 ? 0 : int(this.FGoldIndex + 1);
            this.FMC_Selected.x = SLOT_POSITION[this.FGoldIndex][0];
            this.FMC_Selected.y = SLOT_POSITION[this.FGoldIndex][1];
         }
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
      
      protected function CheckIsMove() : Boolean
      {
         ++this.FMoveFlag;
         if(this.FMoveFlag >= MOVE_SPEED)
         {
            this.FMoveFlag = 0;
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
               this.FSlotList[_loc1_].SetHighLightFilters(false);
            }
            _loc1_++;
         }
      }
      
      protected function PerformPacket_CS_FreeLotteryReq() : void
      {
         if(this.FOnFreeLotteryUp != null)
         {
            this.FOnFreeLotteryUp(2);
         }
      }
      
      protected function PerformPacket_CS_GoldLotteryReq() : void
      {
         if(this.FOnGoldLotteryUp != null)
         {
            this.FOnGoldLotteryUp(2,1);
         }
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
      
      private function ProcessorOnStartClick(param1:MouseEvent) : void
      {
         if(param1.currentTarget.buttonMode == false)
         {
            return;
         }
         TGameUtil.setButtonMode(this.FBtn_Start,false);
         this.HideGetEffectList();
         this.HideFireEffect();
         if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
         {
            this.PerformPacket_CS_FreeLotteryReq();
         }
         else
         {
            this.PerformPacket_CS_GoldLotteryReq();
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
      
      protected function ProcessorOnMove(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
         {
            _loc2_ = this.FFreeInsideItems[this.FFreeIndex].Inventories.GetInventoryByIndex(0);
         }
         else
         {
            _loc2_ = this.FGoldInsideItems[this.FGoldIndex].Inventories.GetInventoryByIndex(0);
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
            _loc2_ = this.FFreeInsideItems[this.FFreeIndex].Inventories.GetInventoryByIndex(0);
         }
         else
         {
            _loc2_ = this.FGoldInsideItems[this.FGoldIndex].Inventories.GetInventoryByIndex(0);
         }
         if(this.FOnOut != null)
         {
            this.FOnOut(null,_loc2_);
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
      
      public function get IsMoveStart() : Boolean
      {
         return this.FIsMoveStart;
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
      
      public function LogicsPerform() : void
      {
         if(this.FInitialized && this.Visible)
         {
            this.UpdateSlot();
            if(!this.FLockBtnStatus)
            {
               this.UpdateBtn();
            }
            if(this.FIsMoveStart)
            {
               this.CheckSelectedStatus();
            }
         }
      }
      
      public function UpdateUI() : void
      {
         this.UpdateBtn();
         this.UpdateSlot();
         this.UpdateEffect();
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
         this.FMC_Selected.x = SLOT_POSITION[0][0];
         this.FMC_Selected.y = SLOT_POSITION[0][1];
         this.FFreeInsideItems = SLogicsCore.Lottery.FreeInsideItems;
         this.FGoldInsideItems = SLogicsCore.Lottery.GoldInsideItems;
         _loc3_ = this.FSlotList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FLotteryCostType == TAB_TYPE_FREE_LOTTERY)
            {
               _loc4_ = this.FFreeInsideItems[_loc2_].Inventories.GetInventoryByIndex(0);
            }
            else
            {
               _loc4_ = this.FGoldInsideItems[_loc2_].Inventories.GetInventoryByIndex(0);
            }
            this.FSlotList[_loc2_].Context = _loc4_;
            this.FSlotList[_loc2_].Resource.visible = true;
            _loc2_++;
         }
      }
      
      public function PerformPacket_SC_FreeLotteryRet(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TLottery = null;
         if(param1 == -1)
         {
            this.UpdateBtn();
            return;
         }
         _loc3_ = SLogicsCore.Lottery;
         _loc2_ = _loc3_.getItemIndexByIdentify(TLottery.TYPE_FREE_INSIDE,param1);
         if(_loc2_ == -1)
         {
            return;
         }
         _loc3_.FreeExp -= _loc3_.CostProgress;
         this.FIsMoveStart = true;
         this.FMoveRound = int(Math.random() * RANDOM_ROUND) + ADD_ROUND;
         this.FEndStep = this.FTotalMoveStep = _loc2_ + this.FMoveRound * ROUND_COUNT - this.FFreeIndex;
      }
      
      public function PerformPacket_SC_GoldLotteryRet(param1:Vector.<int>) : void
      {
         var _loc3_:Vector.<int> = null;
         if(param1 == null || param1.length == 0)
         {
            this.UpdateBtn();
            return;
         }
         var _loc2_:TLottery = SLogicsCore.Lottery;
         _loc3_ = _loc2_.getItemsIndexByIdentifies(TLottery.TYPE_GOLD_INSIDE,param1);
         if(_loc3_ == null || _loc3_.length == 0)
         {
            return;
         }
         _loc2_.GoldExp -= _loc2_.CostProgress;
         this.FIsMoveStart = true;
         this.FMoveRound = int(Math.random() * RANDOM_ROUND) + ADD_ROUND;
         this.FEndStep = this.FTotalMoveStep = _loc3_[0] + this.FMoveRound * ROUND_COUNT - this.FGoldIndex;
      }
      
      public function SetBtnMode(param1:Boolean) : void
      {
         TGameUtil.setButtonMode(this.FBtn_Start,param1);
      }
   }
}

