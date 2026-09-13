package Processors.Game.Lobby.Exercise.ValentineDay.Compoents
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.ValentineDay.TValentineDay1;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.ValentineDay.TProcessorValentineDay;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.Expo;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIValentineDay1 extends TUIBaseWindow
   {
      
      protected static const FLOWER_COUNT:int = 18;
      
      protected static const LABA_COUNT:int = 6;
      
      protected static const LABA_ItemStamp:int = 76;
      
      protected static const MAX_LABACOUNT:int = 20;
      
      protected static const DAYS_COUNT:int = 42;
      
      protected static const INTERVALTIME:Number = 172800000;
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected static const MOVIE_OF_LABA:int = 1;
      
      protected static const MOVIE_OF_FLOWER:int = 2;
      
      protected static const MOVIE_OF_FULL_SCREEN:int = 3;
      
      protected static const LABA_VIP_COUNT:int = 3;
      
      protected var FFlowerList:Vector.<MovieClip>;
      
      protected var FMC_AllDays:Vector.<MovieClip>;
      
      protected var FFirstDayIndex:int;
      
      protected var FToday:int;
      
      protected var FMonthDays:int;
      
      protected var ServerStartDate:Date;
      
      protected var FValentineDay1:TValentineDay1;
      
      protected var FLabaList0:MovieClip;
      
      protected var FLabaList1:MovieClip;
      
      protected var FLabaList2:MovieClip;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FUIItems:Vector.<MovieClip>;
      
      protected var FLabaInitY:int;
      
      protected var FLabaIndex:int;
      
      protected var FMovieType:int;
      
      public function TUIValentineDay1(param1:TUIComponent)
      {
         super(param1);
         this.FFlowerList = new Vector.<MovieClip>(FLOWER_COUNT);
         this.FMC_AllDays = new Vector.<MovieClip>(DAYS_COUNT);
         this.FUISlots = new Vector.<TUISlot>(LABA_COUNT);
         this.FUIItems = new Vector.<MovieClip>(LABA_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < FLOWER_COUNT)
         {
            this.FFlowerList[_loc2_] = FMC_Scene["flower" + _loc2_];
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < DAYS_COUNT)
         {
            this.FMC_AllDays[_loc2_] = FMC_Scene["day_" + _loc2_];
            this.FMC_AllDays[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnDayOver);
            this.FMC_AllDays[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnDayOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < LABA_COUNT)
         {
            _loc4_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_BASEACTIVITY.RESOURCE_Link_MC_Laba) as MovieClip;
            _loc4_.graphics.beginFill(255);
            _loc4_.graphics.drawRect(0,0,30,30);
            _loc4_.graphics.endFill();
            this.FUISlots[_loc2_] = new TUISlot(this);
            this.FUISlots[_loc2_].MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            this.FUISlots[_loc2_].OnOverlay = this.SlotsOnOver;
            this.FUISlots[_loc2_].OnOut = this.SlotsOnOut;
            this.FUISlots[_loc2_].OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            this.FUISlots[_loc2_].OnQuerySubscript = this.SlotsOnQuerySubscript;
            this.FUISlots[_loc2_].Resource = _loc4_;
            this.FUISlots[_loc2_].Init();
            this.FUIItems[_loc2_] = _loc4_;
            _loc2_++;
         }
         this.FLabaList0 = FMC_Scene["MC_LabaItem0"];
         this.FLabaList0.addChild(this.FUIItems[0]);
         this.FLabaList0.addChild(this.FUIItems[1]);
         this.FLabaList1 = FMC_Scene["MC_LabaItem1"];
         this.FLabaList1.addChild(this.FUIItems[2]);
         this.FLabaList1.addChild(this.FUIItems[3]);
         this.FLabaList2 = FMC_Scene["MC_LabaItem2"];
         this.FLabaList2.addChild(this.FUIItems[4]);
         this.FLabaList2.addChild(this.FUIItems[5]);
         this.FLabaInitY = this.FLabaList0.y;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
         TGameUtil.setButtonMode(FMC_Scene.BTN_laba,true);
         FMC_Scene.BTN_laba.addEventListener(MouseEvent.CLICK,this.ProcessorOnLaBaUp);
         FMC_Scene.MC_Gift.buttonMode = true;
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetGiftUp);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnGiftOut);
         TGameUtil.setButtonMode(FMC_Scene.MC_Gift.BTN_Buy,true);
         FMC_Scene.MC_Gift.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyGiftUp);
         FMC_Scene.MC_Effect.visible = false;
         FMC_Scene.MC_Vip0.mouseChildren = false;
         FMC_Scene.MC_Vip1.mouseChildren = false;
         FMC_Scene.MC_Vip2.mouseChildren = false;
         FMC_Scene.MC_Vip0.mouseEnabled = false;
         FMC_Scene.MC_Vip1.mouseEnabled = false;
         FMC_Scene.MC_Vip2.mouseEnabled = false;
         FMC_Scene.MC_Movie2.visible = false;
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.ACTIVE_Test);
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
      
      public function UpdateDays() : void
      {
         var _loc1_:* = 0;
         var _loc2_:uint = 0;
         var _loc3_:Date = null;
         var _loc4_:Date = null;
         var _loc5_:Date = null;
         var _loc6_:uint = 0;
         var _loc7_:* = 0;
         var _loc8_:uint = 0;
         var _loc9_:int = 0;
         var _loc10_:MovieClip = null;
         _loc3_ = new Date(STimingCore.GetServerTime() * 1000);
         _loc4_ = new Date(STimingCore.GetServerTime() * 1000);
         _loc5_ = new Date(STimingCore.GetServerTime() * 1000);
         this.FToday = _loc4_.getDate();
         _loc3_.setDate(1);
         _loc5_.setHours(0);
         _loc6_ = _loc3_.getDay();
         this.FFirstDayIndex = _loc6_ % 7;
         if(this.FFirstDayIndex == 0)
         {
            this.FFirstDayIndex = 7;
         }
         _loc7_ = uint(_loc3_.getDate());
         _loc8_ = 0;
         _loc2_ = uint(TUtilityDate.GetMonthDaysByDate(_loc3_));
         this.FMonthDays = _loc2_;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc10_ = this.FMC_AllDays[this.FFirstDayIndex + _loc1_];
            _loc10_.TF_Day.text = _loc7_.toString();
            _loc9_ = ++_loc7_ - 2;
            _loc8_ = _loc9_ + 1;
            if(this.FValentineDay1.DayList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               _loc10_.MC_SelectBox.visible = true;
               _loc10_.MC_Got.visible = false;
            }
            else if(this.FValentineDay1.DayList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc10_.MC_SelectBox.visible = false;
               _loc10_.MC_Got.visible = false;
            }
            else
            {
               _loc10_.MC_SelectBox.visible = false;
               _loc10_.MC_Got.visible = true;
            }
            if(_loc1_ < this.FToday - 1)
            {
               if(this.FValentineDay1.DayList[_loc1_].Status == TBaseActivity.STATUS_GETED)
               {
                  _loc10_.gotoAndStop(3);
               }
               else
               {
                  _loc10_.gotoAndStop(5);
               }
            }
            else if(_loc1_ == this.FToday - 1)
            {
               _loc10_.gotoAndStop(4);
            }
            else
            {
               _loc5_.setDate(_loc1_ + 1);
               if(_loc5_.getTime() > STimingCore.GetClientShowTime(this.FValentineDay1.EndTime) * 1000)
               {
                  _loc10_.gotoAndStop(5);
               }
               else
               {
                  _loc10_.gotoAndStop(2);
               }
            }
            _loc1_++;
         }
         _loc7_ = uint(TUtilityDate.GetMonthDaysByDate(new Date(_loc3_.getTime() - INTERVALTIME)));
         _loc1_ = int(this.FFirstDayIndex - 1);
         while(_loc1_ > -1)
         {
            _loc10_ = this.FMC_AllDays[_loc1_];
            _loc10_.TF_Day.text = _loc7_.toString();
            _loc10_.gotoAndStop(1);
            _loc10_.MC_SelectBox.visible = false;
            _loc10_.MC_Got.visible = false;
            _loc7_--;
            _loc1_--;
         }
         _loc7_ = 1;
         _loc1_ = int(_loc2_ + this.FFirstDayIndex);
         while(_loc1_ < DAYS_COUNT)
         {
            _loc10_ = this.FMC_AllDays[_loc1_];
            _loc10_.TF_Day.text = _loc7_.toString();
            _loc10_.gotoAndStop(1);
            _loc10_.MC_SelectBox.visible = false;
            _loc10_.MC_Got.visible = false;
            _loc7_++;
            _loc1_++;
         }
      }
      
      protected function UpdateToday() : void
      {
         if(this.FValentineDay1.DayList[this.FToday - 1].Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.BTN_Get.visible = true;
            FMC_Scene.TF_Get.text = STRING_BASEACTIVITY.FORMAT_TODAY_CAN_GET;
         }
         else
         {
            FMC_Scene.BTN_Get.visible = false;
            if(this.FToday < this.FValentineDay1.DayList.length)
            {
               FMC_Scene.TF_Get.text = STRING_BASEACTIVITY.FORMAT_TOMORROW_CAN_GET;
            }
            else
            {
               FMC_Scene.TF_Get.text = STRING_BASEACTIVITY.FORMAT_TODAY_GOT;
            }
         }
      }
      
      protected function UpdateFlower() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < FLOWER_COUNT)
         {
            _loc3_ = this.FFlowerList[_loc1_];
            if(_loc1_ < this.FValentineDay1.NeedDays)
            {
               _loc3_.visible = true;
               if(_loc1_ < this.FValentineDay1.ContiueDays)
               {
                  _loc3_.gotoAndStop(2);
               }
               else
               {
                  _loc3_.gotoAndStop(1);
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
         if(this.FValentineDay1.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.MC_Gift.BTN_Buy.visible = true;
            FMC_Scene.MC_Gift.MC_Got.visible = false;
            FMC_Scene.MC_Gift.MC_Icon.gotoAndStop(1);
            FMC_Scene.MC_Gift.MC_Movie.visible = false;
         }
         else if(this.FValentineDay1.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Gift.BTN_Buy.visible = false;
            FMC_Scene.MC_Gift.MC_Got.visible = true;
            FMC_Scene.MC_Gift.MC_Icon.visible = false;
            FMC_Scene.MC_Gift.MC_Movie.visible = true;
            FMC_Scene.MC_Gift.MC_Movie.gotoAndStop(1);
         }
         else
         {
            FMC_Scene.MC_Gift.BTN_Buy.visible = false;
            FMC_Scene.MC_Gift.MC_Got.visible = false;
            FMC_Scene.MC_Gift.MC_Icon.gotoAndPlay(1);
            FMC_Scene.MC_Gift.MC_Movie.visible = false;
         }
      }
      
      protected function UpdateLaBa() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TCharacter = null;
         this.FLabaList0.y = this.FLabaInitY;
         this.FLabaList1.y = this.FLabaInitY;
         this.FLabaList2.y = this.FLabaInitY;
         _loc1_ = 0;
         while(_loc1_ < LABA_COUNT)
         {
            if(_loc1_ % 2 == 0)
            {
               this.FUIItems[_loc1_].y = 0;
            }
            else
            {
               this.FUIItems[_loc1_].y = LABA_ItemStamp * (int(_loc1_ / 2) % 2 == 0 ? 1 : -1);
            }
            this.FUISlots[_loc1_].Context = this.FValentineDay1.BoxList[int(_loc1_ / 2)].Inventories.GetInventoryByIndex(int(_loc1_ / 2) % 2);
            _loc1_++;
         }
         _loc2_ = SLogicsCore.Character;
         _loc1_ = 0;
         while(_loc1_ < LABA_VIP_COUNT)
         {
            if(_loc2_.VipLevel >= this.FValentineDay1.BoxList[_loc1_].Price)
            {
               FMC_Scene["MC_Vip" + _loc1_].visible = false;
            }
            else
            {
               FMC_Scene["MC_Vip" + _loc1_].visible = true;
               FMC_Scene["MC_Vip" + _loc1_].TF_Vip.text = this.FValentineDay1.BoxList[_loc1_].Desc1;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         if(this.FValentineDay1.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.TF_Day.text = TUtilityString.Format(this.FValentineDay1.ActivityDesc2,this.FValentineDay1.ContiueDays,this.FValentineDay1.NeedDays - this.FValentineDay1.ContiueDays);
         }
         else
         {
            FMC_Scene.TF_Day.text = "";
         }
         FMC_Scene.TF_Count.text = TUtilityString.Format(this.FValentineDay1.ActivityName,this.FValentineDay1.FreeCount);
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FValentineDay1.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FValentineDay1.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FValentineDay1.ActivityDesc;
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorValentineDay.ACTIVITY_1_GET_SIGN_BOX);
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventories = null;
         if(FOnBoxOver != null && Boolean(this.FValentineDay1))
         {
            if(this.FToday >= this.FValentineDay1.DayList.length)
            {
               _loc2_ = this.FValentineDay1.DayList[this.FToday - 1].Inventories;
            }
            else if(this.FValentineDay1.DayList[this.FToday - 1].Status == TBaseActivity.STATUS_CANGET)
            {
               _loc2_ = this.FValentineDay1.DayList[this.FToday - 1].Inventories;
            }
            else
            {
               _loc2_ = this.FValentineDay1.DayList[this.FToday].Inventories;
            }
            if(_loc2_ != null && _loc2_.Count > 0)
            {
               FOnBoxOver(_loc2_);
            }
         }
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         if(FOnBoxOut != null)
         {
            FOnBoxOut();
         }
      }
      
      protected function ProcessorOnDayOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         if(FOnBoxOver != null)
         {
            _loc2_ = int(String(param1.currentTarget.name).slice(4));
            if(_loc2_ < this.FFirstDayIndex || _loc2_ > this.FMonthDays + this.FFirstDayIndex - 1)
            {
               return;
            }
            _loc3_ = this.FValentineDay1.DayList[_loc2_ - this.FFirstDayIndex].Inventories;
            if(_loc3_ != null && _loc3_.Count > 0)
            {
               FOnBoxOver(_loc3_);
            }
         }
      }
      
      protected function ProcessorOnDayOut(param1:MouseEvent) : void
      {
         if(FOnBoxOut != null)
         {
            FOnBoxOut();
         }
      }
      
      protected function ProcessorOnGetGiftUp(param1:MouseEvent) : void
      {
         if(FOnGetBox != null)
         {
            if(this.FValentineDay1.Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorValentineDay.ACTIVITY_1_GET_GIFT);
            }
         }
      }
      
      protected function ProcessorOnBuyGiftUp(param1:MouseEvent) : void
      {
         if(FOnBuyBox != null && Boolean(this.FValentineDay1))
         {
            if(this.FValentineDay1.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               FOnBuyBox(ACTIVITY_1_ID,TProcessorValentineDay.ACTIVITY_1_BUY_GIFT,this.FValentineDay1.Cost);
            }
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnBoxOver != null) && Boolean(this.FValentineDay1) && Boolean(this.FValentineDay1.Inventories))
         {
            FOnBoxOver(this.FValentineDay1.Inventories);
         }
      }
      
      protected function ProcessorOnGiftOut(param1:MouseEvent) : void
      {
         if(FOnBoxOut != null)
         {
            FOnBoxOut();
         }
      }
      
      protected function ProcessorOnLaBaUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FIsPlaying)
         {
            FOnShowFlowText(STRING_BASEACTIVITY.FORMAT_WAIT_AMOUNT);
            return;
         }
         if(FOnGetBox != null)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorValentineDay.ACTIVITY_1_GET_LABA);
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(this,param2);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         if(FInitialized && this.visible)
         {
            if(FIsPlaying)
            {
               if(this.FMovieType == MOVIE_OF_FLOWER)
               {
                  CurFrame = FMC_Scene.MC_Gift.MC_Movie.currentFrame;
               }
               else if(this.FMovieType == MOVIE_OF_FULL_SCREEN)
               {
                  CurFrame = FMC_Scene.MC_Effect.currentFrame;
               }
               if(CurFrame == FTotalFrame)
               {
                  FIsPlaying = false;
                  this.MovieEnd();
               }
            }
            _loc1_ = 0;
            while(_loc1_ < LABA_COUNT)
            {
               this.FUISlots[_loc1_].Update();
               _loc1_++;
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FValentineDay1 = SLogicsCore.ValentineDayDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TValentineDay1;
         this.UpdateDays();
         this.UpdateToday();
         this.UpdateFlower();
         this.UpdateLaBa();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:TInventories = null;
         this.FMovieType = param1;
         switch(param1)
         {
            case MOVIE_OF_LABA:
               FIsPlaying = true;
               this.PlayLaBaMovie();
               break;
            case MOVIE_OF_FLOWER:
               _loc5_ = FMC_Scene.MC_Gift.MC_Movie;
               if(_loc5_)
               {
                  FIsPlaying = true;
                  _loc5_.visible = true;
                  FMC_Scene.MC_Gift.MC_Icon.visible = false;
                  FTotalFrame = _loc5_.totalFrames;
                  _loc5_.gotoAndPlay(1);
               }
               break;
            case MOVIE_OF_FULL_SCREEN:
               _loc5_ = FMC_Scene.MC_Effect;
               if(_loc5_)
               {
                  FIsPlaying = true;
                  _loc5_.visible = true;
                  FTotalFrame = _loc5_.totalFrames;
                  _loc5_.gotoAndPlay(1);
                  FMC_Scene.MC_Movie2.visible = true;
                  FMC_Scene.MC_Movie2.gotoAndPlay(1);
               }
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         if(this.FMovieType == MOVIE_OF_FLOWER)
         {
            this.PlayMovie(3);
         }
         else if(this.FMovieType == MOVIE_OF_FULL_SCREEN)
         {
            FMC_Scene.MC_Effect.stop();
            FMC_Scene.MC_Effect.visible = false;
         }
         this.UpdateUI();
      }
      
      public function PlayLaBaMovie() : void
      {
         this.UpdateLaBa();
         this.FLabaIndex = 0;
         TweenUtil.to(this.FLabaList0,6000,{
            "y":this.FLabaList0.y - LABA_ItemStamp * MAX_LABACOUNT,
            "onUpdate":this.CheckOutArea,
            "onComplete":this.LaBaMovieEnd,
            "ease":Expo.easeOut
         });
         TweenUtil.to(this.FLabaList1,6000,{
            "y":this.FLabaList1.y + LABA_ItemStamp * MAX_LABACOUNT,
            "ease":Expo.easeOut
         });
         TweenUtil.to(this.FLabaList2,6000,{
            "y":this.FLabaList2.y - LABA_ItemStamp * MAX_LABACOUNT,
            "ease":Expo.easeOut
         });
      }
      
      public function CheckOutArea() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TUISlot = null;
         var _loc3_:TInventory = null;
         if(int(Math.abs(this.FLabaList0.y - this.FLabaInitY) / LABA_ItemStamp) > this.FLabaIndex)
         {
            this.FUIItems[0 + this.FLabaIndex % 2].y += LABA_ItemStamp * 2;
            this.FUIItems[2 + this.FLabaIndex % 2].y -= LABA_ItemStamp * 2;
            this.FUIItems[4 + this.FLabaIndex % 2].y += LABA_ItemStamp * 2;
            _loc1_ = uint(this.FValentineDay1.BoxList[0].Inventories.Count);
            _loc2_ = this.FUISlots[0 + this.FLabaIndex % 2];
            _loc3_ = this.FValentineDay1.BoxList[0].Inventories.GetInventoryByIndex(int(Math.random() * _loc1_));
            _loc2_.Context = _loc3_;
            _loc1_ = uint(this.FValentineDay1.BoxList[1].Inventories.Count);
            _loc2_ = this.FUISlots[2 + this.FLabaIndex % 2];
            _loc3_ = this.FValentineDay1.BoxList[1].Inventories.GetInventoryByIndex(int(Math.random() * _loc1_));
            _loc2_.Context = _loc3_;
            _loc1_ = uint(this.FValentineDay1.BoxList[2].Inventories.Count);
            _loc2_ = this.FUISlots[4 + this.FLabaIndex % 2];
            _loc3_ = this.FValentineDay1.BoxList[2].Inventories.GetInventoryByIndex(int(Math.random() * _loc1_));
            _loc2_.Context = _loc3_;
            if(this.FLabaIndex >= MAX_LABACOUNT - 2)
            {
               _loc1_ = uint(this.FValentineDay1.LabaInventories.Count);
               if(_loc1_ > 0)
               {
                  _loc2_ = this.FUISlots[0 + this.FLabaIndex % 2];
                  _loc3_ = this.FValentineDay1.LabaInventories.GetInventoryByIndex(0);
                  _loc2_.Context = _loc3_;
               }
               if(_loc1_ > 1)
               {
                  _loc2_ = this.FUISlots[2 + this.FLabaIndex % 2];
                  _loc3_ = this.FValentineDay1.LabaInventories.GetInventoryByIndex(1);
                  _loc2_.Context = _loc3_;
               }
               if(_loc1_ > 2)
               {
                  _loc2_ = this.FUISlots[4 + this.FLabaIndex % 2];
                  _loc3_ = this.FValentineDay1.LabaInventories.GetInventoryByIndex(2);
                  _loc2_.Context = _loc3_;
               }
            }
            ++this.FLabaIndex;
         }
      }
      
      public function LaBaMovieEnd() : void
      {
         FIsPlaying = false;
         if(this.FValentineDay1.LabaFlowStr != "")
         {
            FOnShowFlowText(this.FValentineDay1.LabaFlowStr);
         }
      }
   }
}

