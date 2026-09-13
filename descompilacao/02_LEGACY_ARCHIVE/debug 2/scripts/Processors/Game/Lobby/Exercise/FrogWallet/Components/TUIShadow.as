package Processors.Game.Lobby.Exercise.FrogWallet.Components
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
   import Logics.Exercise.FrogWallet.TShadow;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_FROGWALLET;
   import Resources.Strings.STRING_FROGWALLET;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TUIShadow extends TUIComponent
   {
      
      public static const ACTIVITY_4_ID:int = CONST_FROGWALLET.ACTIVITY_4_ID;
      
      public static const BOX_COUNT:int = 3;
      
      public static const RESULT_LOSE:int = TShadow.RESULT_LOSE;
      
      public static const RESULT_NOCHANGE:int = TShadow.RESULT_NOCHANGE;
      
      public static const RESULT_WIN:int = TShadow.RESULT_WIN;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBTN_Put:MovieClip;
      
      protected var FBTN_Take:MovieClip;
      
      protected var FBTN_Start:MovieClip;
      
      protected var FMC_Dialog:MovieClip;
      
      protected var FTF_Time:TextField;
      
      protected var FTF_Desc:TextField;
      
      protected var FTF_Gold:TextField;
      
      protected var FMC_HeroEffect:MovieClip;
      
      protected var FMC_SingleEffect0:MovieClip;
      
      protected var FMC_SingleEffect1:MovieClip;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FInitialized:Boolean;
      
      protected var FHintBoxTip:THint;
      
      protected var FTimeID:int;
      
      protected var FCurDayTime:Number;
      
      protected var FShadow:TShadow;
      
      protected var FOnGetReward:Function;
      
      protected var FEffectText:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FOnShowPackage:Function;
      
      protected var FOnStartPractice:Function;
      
      protected var FOnShadowGetReward:Function;
      
      public function TUIShadow(param1:TUIComponent)
      {
         super(param1);
         this.FHintBoxTip = new THint();
         this.FSlotList = new Vector.<TUISlot>(BOX_COUNT);
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         this.FBTN_Put = this.FMC_Scene.BTN_Put;
         this.FBTN_Take = this.FMC_Scene.BTN_Take;
         this.FBTN_Start = this.FMC_Scene.BTN_Start;
         this.FBTN_Put.addEventListener(MouseEvent.CLICK,this.ProcessorOnPutUp);
         this.FBTN_Take.addEventListener(MouseEvent.CLICK,this.ProcessorOnTakeUp);
         this.FBTN_Start.addEventListener(MouseEvent.CLICK,this.ProcessorOnStartUp);
         this.FTF_Time = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_TF_TIME];
         this.FTF_Desc = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_TF_Desc];
         this.FTF_Gold = this.FMC_Scene.TF_Gold;
         this.FTF_Gold.text = "1";
         this.FTF_Gold.restrict = "0-9";
         this.FTF_Gold.addEventListener(Event.CHANGE,this.TextFieldOnChange);
         this.FMC_HeroEffect = this.FMC_Scene.MC_HeroEffect;
         this.FMC_SingleEffect0 = this.FMC_Scene.MC_SingleEffect0;
         this.FMC_SingleEffect1 = this.FMC_Scene.MC_SingleEffect1;
         this.FMC_Dialog = this.FMC_Scene.MC_Dialog;
         this.Resources_UIDispatch_Slot();
      }
      
      protected function Resources_UIDispatch_Slot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUISlot = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc2_ = new TUISlot(this);
            _loc2_.Resource = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_Slot + _loc1_] as Sprite;
            _loc2_.Resource.visible = true;
            _loc2_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc2_.Tag = _loc1_;
            _loc2_.OnOverlay = this.SlotsOnOver;
            _loc2_.OnOut = this.SlotsOnOut;
            _loc2_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc2_.Init();
            this.FSlotList[_loc1_] = _loc2_;
            _loc1_++;
         }
      }
      
      public function UpdateText() : void
      {
         this.FTF_Desc.htmlText = this.FShadow.ActivityDesc;
         this.FTF_Gold.text = this.FShadow.MinGold.toString();
      }
      
      public function UpdateRateText() : void
      {
         if(!this.FShadow.Inventories || this.FShadow.Inventories.Count <= 0 || this.FShadow.Result == RESULT_WIN)
         {
            this.FMC_Dialog.visible = false;
         }
         else if(this.FShadow.PutCount > 0)
         {
            this.FMC_Dialog.visible = true;
            this.FMC_Dialog.gotoAndPlay(1);
            this.FMC_Dialog.MC_Dialog.TF_Dialog.text = TUtilityString.Format(STRING_FROGWALLET.FormatString_Rate,this.FShadow.GetRate());
         }
      }
      
      public function UpdateBtn() : void
      {
         var _loc1_:uint = uint(this.FTF_Gold.text);
         if(!this.FShadow.Inventories || this.FShadow.Inventories.Count <= 0)
         {
            this.FBTN_Take.visible = false;
            this.FBTN_Put.visible = true;
            TGameUtil.setButtonMode(this.FBTN_Put,true);
            TGameUtil.setButtonMode(this.FBTN_Start,false);
         }
         else
         {
            this.FBTN_Take.visible = true;
            this.FBTN_Put.visible = false;
            TGameUtil.setButtonMode(this.FBTN_Take,true);
            if(_loc1_ < this.FShadow.MinGold || this.FShadow.Result == RESULT_WIN)
            {
               TGameUtil.setButtonMode(this.FBTN_Start,false);
            }
            else
            {
               TGameUtil.setButtonMode(this.FBTN_Start,true);
            }
         }
      }
      
      public function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TInventory = null;
         if(Boolean(this.FShadow.Inventories) && this.FShadow.Inventories.Count > 0)
         {
            _loc4_ = this.FShadow.Inventories.GetInventoryByIndex(0);
         }
         switch(this.FShadow.Result)
         {
            case RESULT_LOSE:
               this.FSlotList[0].Context = _loc4_;
               this.FSlotList[1].Context = null;
               this.FSlotList[2].Context = null;
               break;
            case RESULT_NOCHANGE:
               this.FSlotList[0].Context = _loc4_;
               this.FSlotList[1].Context = null;
               this.FSlotList[2].Context = null;
               break;
            case RESULT_WIN:
               this.FSlotList[0].Context = null;
               this.FSlotList[1].Context = _loc4_;
               this.FSlotList[2].Context = _loc4_;
         }
      }
      
      protected function TextFieldOnChange(param1:Event) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = uint(this.FTF_Gold.text);
         if(_loc2_ < this.FShadow.MinGold)
         {
            this.FTF_Gold.text = this.FShadow.MinGold.toString();
         }
         else if(_loc2_ > this.FShadow.MaxGold)
         {
            this.FTF_Gold.text = this.FShadow.MaxGold.toString();
         }
         else
         {
            this.FTF_Gold.text = _loc2_.toString();
         }
         this.FShadow.PutGold = int(this.FTF_Gold.text);
         this.UpdateRateText();
      }
      
      protected function ProcessorOnGetReward(param1:MouseEvent) : void
      {
         if(this.FOnGetReward != null)
         {
            this.FOnGetReward(ACTIVITY_4_ID,0);
         }
      }
      
      protected function ProcessorEffectText(param1:String) : void
      {
         if(this.FEffectText != null)
         {
            this.FEffectText(param1);
         }
      }
      
      protected function ProcessorOnPutUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FOnShowPackage != null)
         {
            this.FOnShowPackage();
         }
      }
      
      protected function ProcessorOnTakeUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FShadow.Result == RESULT_LOSE)
         {
            this.FShadow.Inventories.Clear();
            this.FShadow.PutCount = 0;
            this.UpdateUI();
            return;
         }
         if(this.FOnShadowGetReward != null)
         {
            this.FOnShadowGetReward();
         }
      }
      
      protected function ProcessorOnStartUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FOnStartPractice != null)
         {
            this.FOnStartPractice();
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
            if((param1 as TUISlot).Tag == 0)
            {
               param3.Value = this.FShadow.PutCount.toString();
            }
            else if(this.FShadow.Result == RESULT_WIN)
            {
               param3.Value = String(this.FShadow.PutCount);
            }
         }
         else if(param2 is TInventory)
         {
            if((param1 as TUISlot).Tag == 0)
            {
               param3.Value = this.FShadow.PutCount.toString();
            }
            else if(this.FShadow.Result == RESULT_WIN)
            {
               param3.Value = String(this.FShadow.PutCount);
            }
         }
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         if(this.FOnQuerySequenceContext != null)
         {
            this.FOnQuerySequenceContext(this,param2,param3);
         }
      }
      
      public function get OnGetReward() : Function
      {
         return this.FOnGetReward;
      }
      
      public function set OnGetReward(param1:Function) : void
      {
         this.FOnGetReward = param1;
      }
      
      public function get EffectText() : Function
      {
         return this.FEffectText;
      }
      
      public function set EffectText(param1:Function) : void
      {
         this.FEffectText = param1;
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
      
      public function get OnShowPackage() : Function
      {
         return this.FOnShowPackage;
      }
      
      public function set OnShowPackage(param1:Function) : void
      {
         this.FOnShowPackage = param1;
      }
      
      public function get OnStartPractice() : Function
      {
         return this.FOnStartPractice;
      }
      
      public function set OnStartPractice(param1:Function) : void
      {
         this.FOnStartPractice = param1;
      }
      
      public function get OnShadowGetReward() : Function
      {
         return this.FOnShadowGetReward;
      }
      
      public function set OnShadowGetReward(param1:Function) : void
      {
         this.FOnShadowGetReward = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FInitialized && this.visible)
         {
            if(!this.FShadow || !this.FTF_Time)
            {
               return;
            }
            this.FTF_Time.text = TGameUtil.fomatTime(this.FShadow.EndTime - STimingCore.GetServerTick());
            _loc2_ = int(this.FSlotList.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               if(this.FSlotList[_loc1_] != null)
               {
                  this.FSlotList[_loc1_].Update();
               }
               _loc1_++;
            }
         }
      }
      
      public function SetReset() : void
      {
         var _loc2_:Number = NaN;
         if(this.FTimeID != 0)
         {
            clearTimeout(this.FTimeID);
            this.FTimeID = 0;
         }
         var _loc1_:Date = new Date(STimingCore.GetServerTime() * 1000);
         _loc1_.hours = 0;
         _loc1_.minutes = 0;
         _loc1_.seconds = 0;
         this.FCurDayTime = _loc1_.getTime() + 24 * 60 * 60 * 1000 + 5000;
         _loc2_ = this.FCurDayTime - STimingCore.GetServerTime() * 1000;
         this.FTimeID = setTimeout(this.UpdateUI,_loc2_);
      }
      
      public function UpdateUI() : void
      {
         this.SetReset();
         this.FShadow = SLogicsCore.ActivitiesData.GetActivityByIdentify(ACTIVITY_4_ID) as TShadow;
         if(!this.FShadow)
         {
            return;
         }
         this.UpdateText();
         this.UpdateBtn();
         this.UpdateSlot();
         this.UpdateRateText();
      }
      
      public function Unmount() : void
      {
         if(this.FTimeID != 0)
         {
            clearTimeout(this.FTimeID);
            this.FTimeID = 0;
         }
      }
      
      public function GetRewardRet() : void
      {
         if(this.FShadow.IsContinue)
         {
            this.UpdateRateText();
         }
         else
         {
            this.UpdateText();
            this.UpdateBtn();
            this.UpdateSlot();
            this.UpdateRateText();
         }
      }
      
      public function ProcessorOnItemSelect(param1:Object) : void
      {
         var _loc2_:TInventory = null;
         _loc2_ = param1 as TInventory;
         this.FShadow.Inventories.Clear();
         if(_loc2_ != null)
         {
            this.FShadow.Inventories.Add(_loc2_);
         }
         this.UpdateText();
         this.UpdateBtn();
         this.UpdateSlot();
         this.UpdateRateText();
      }
      
      public function ProcessorOnPlayEffect() : void
      {
         this.FMC_Scene.MC_HeroEffect.gotoAndPlay(1);
         this.FMC_Scene.MC_SingleEffect0.gotoAndPlay(1);
         this.FMC_Scene.MC_SingleEffect1.gotoAndPlay(1);
      }
   }
}

