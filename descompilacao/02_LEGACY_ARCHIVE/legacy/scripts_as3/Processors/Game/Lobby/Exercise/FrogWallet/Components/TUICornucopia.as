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
   import Logics.Exercise.FrogWallet.TCornucopia;
   import Logics.Exercise.FrogWallet.TCornucopiaBox;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_FROGWALLET;
   import Resources.Strings.STRING_FROGWALLET;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TUICornucopia extends TUIComponent
   {
      
      public static const BOX_COUNT:int = 3;
      
      public static const SLOT_COUNT:int = 2;
      
      public static const ACTIVITY_1_ID:int = CONST_FROGWALLET.ACTIVITY_1_ID;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMC_BoxList:Vector.<MovieClip>;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FIndex:int;
      
      protected var FInitialized:Boolean;
      
      protected var FHintBoxTip:THint;
      
      protected var FTimeID:int;
      
      protected var FCurDayTime:Number;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FOnGetReward:Function;
      
      protected var FEffectText:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      public function TUICornucopia(param1:TUIComponent)
      {
         super(param1);
         this.FMC_BoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FSlotList = new Vector.<TUISlot>(SLOT_COUNT);
         this.FHintBoxTip = new THint();
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            param1 = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_Box + _loc2_];
            param1[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward].addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnGetReward);
            param1[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTipOver);
            param1[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward].addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnTipOut);
            param1[CONST_FROGWALLET.RESOURCE_LINK_MC_Got].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTipOver);
            param1[CONST_FROGWALLET.RESOURCE_LINK_MC_Got].addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnTipOut);
            this.FMC_BoxList[_loc2_] = param1;
            _loc2_++;
         }
         this.Resources_UIDispatch_Slot();
      }
      
      protected function Resources_UIDispatch_Slot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUISlot = null;
         var _loc3_:MovieClip = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < BOX_COUNT)
         {
            _loc5_ = 0;
            while(_loc5_ < SLOT_COUNT)
            {
               _loc2_ = new TUISlot(this);
               _loc3_ = this.FMC_BoxList[_loc4_];
               _loc2_.Resource = _loc3_[CONST_FROGWALLET.RESOURCE_LINK_MC_Slot + _loc5_] as Sprite;
               _loc2_.Resource.visible = false;
               _loc2_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
               _loc2_.OnOverlay = this.SlotsOnOver;
               _loc2_.OnOut = this.SlotsOnOut;
               _loc2_.OnQuerySubscript = this.SlotsOnQuerySubscript;
               _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
               _loc2_.Init();
               this.FSlotList[_loc1_] = _loc2_;
               _loc1_++;
               _loc5_++;
            }
            _loc4_++;
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TCornucopia = null;
         var _loc4_:TCornucopiaBox = null;
         var _loc5_:MovieClip = null;
         _loc3_ = SLogicsCore.ActivitiesData.GetActivityByIdentify(ACTIVITY_1_ID) as TCornucopia;
         _loc2_ = int(_loc3_.CornucopiaList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_.CornucopiaList[_loc1_];
            this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_TF_Recharge + _loc1_].text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_PAY_LIMIT,_loc4_.PayLimit.toString());
            _loc5_ = this.FMC_BoxList[_loc1_];
            (_loc5_[CONST_FROGWALLET.RESOURCE_LINK_MC_End] as Sprite).visible = false;
            if(_loc4_.State == 1)
            {
               (_loc5_[CONST_FROGWALLET.RESOURCE_LINK_MC_Got] as Sprite).visible = true;
               (_loc5_[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward] as MovieClip).visible = false;
            }
            else if(_loc4_.State == 0)
            {
               (_loc5_[CONST_FROGWALLET.RESOURCE_LINK_MC_Got] as Sprite).visible = false;
               (_loc5_[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward] as MovieClip).visible = true;
               TGameUtil.setButtonMode(_loc5_[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward] as MovieClip,true);
            }
            else
            {
               (_loc5_[CONST_FROGWALLET.RESOURCE_LINK_MC_Got] as Sprite).visible = false;
               (_loc5_[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward] as MovieClip).visible = true;
               TGameUtil.setButtonMode(_loc5_[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward] as MovieClip,false);
            }
            if(STimingCore.GetServerTick() >= _loc3_.PayEndTime)
            {
               if(_loc4_.GotTimes > 0)
               {
                  _loc5_[CONST_FROGWALLET.RESOURCE_LINK_MC_End].visible = false;
               }
               else
               {
                  _loc5_[CONST_FROGWALLET.RESOURCE_LINK_MC_End].visible = true;
                  _loc5_[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward].visible = false;
                  _loc5_[CONST_FROGWALLET.RESOURCE_LINK_MC_Got].visible = false;
               }
            }
            if(_loc1_ == 0)
            {
               (_loc5_[CONST_FROGWALLET.RESOURCE_LINK_MC_Stone0] as Sprite).visible = false;
               (_loc5_[CONST_FROGWALLET.RESOURCE_LINK_MC_Stone1] as Sprite).visible = false;
            }
            else if(_loc1_ == 1)
            {
               (_loc5_[CONST_FROGWALLET.RESOURCE_LINK_MC_Stone0] as Sprite).visible = true;
               (_loc5_[CONST_FROGWALLET.RESOURCE_LINK_MC_Stone1] as Sprite).visible = false;
            }
            else
            {
               (_loc5_[CONST_FROGWALLET.RESOURCE_LINK_MC_Stone0] as Sprite).visible = true;
               (_loc5_[CONST_FROGWALLET.RESOURCE_LINK_MC_Stone1] as Sprite).visible = true;
            }
            _loc5_[CONST_FROGWALLET.RESOURCE_LINK_TF_Gold].text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_PAY_LIMIT,_loc4_.CanGetTime * _loc4_.GetGold);
            _loc5_[CONST_FROGWALLET.RESOURCE_LINK_TF_Times].text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_GET_GOLD,_loc4_.CanGetTime);
            _loc1_++;
         }
      }
      
      protected function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TInventory = null;
         var _loc5_:TCornucopia = null;
         var _loc6_:TCornucopiaBox = null;
         var _loc8_:int = 0;
         _loc5_ = SLogicsCore.ActivitiesData.GetActivityByIdentify(ACTIVITY_1_ID) as TCornucopia;
         var _loc7_:int = 0;
         while(_loc7_ < BOX_COUNT)
         {
            _loc8_ = 0;
            while(_loc8_ < SLOT_COUNT)
            {
               if(_loc7_ < _loc5_.CornucopiaList.length)
               {
                  _loc6_ = _loc5_.CornucopiaList[_loc7_];
                  _loc4_ = _loc6_.Inventories.GetInventoryByIndex(_loc8_);
                  this.FSlotList[_loc1_].Context = _loc4_;
                  this.FSlotList[_loc1_].Resource.visible = true;
                  _loc1_++;
               }
               _loc8_++;
            }
            _loc7_++;
         }
      }
      
      protected function ProcessorOnGetReward(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TCornucopia = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         this.FIndex = int(String(param1.currentTarget.parent.name).slice(6));
         _loc3_ = SLogicsCore.ActivitiesData.GetActivityByIdentify(ACTIVITY_1_ID) as TCornucopia;
         _loc2_ = _loc3_.CornucopiaList[this.FIndex].Identify;
         var _loc4_:MovieClip = this.FMC_BoxList[this.FIndex];
         TGameUtil.setButtonMode(_loc4_[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward],false);
         if(this.FOnGetReward != null)
         {
            this.FOnGetReward(ACTIVITY_1_ID,_loc2_);
         }
      }
      
      protected function ProcessorOnTipOver(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TCornucopia = null;
         var _loc2_:String = "";
         if(param1.currentTarget.name == "BTN_GetReward" && !param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(6));
         _loc4_ = SLogicsCore.ActivitiesData.GetActivityByIdentify(ACTIVITY_1_ID) as TCornucopia;
         _loc2_ = TUtilityString.Format(STRING_FROGWALLET.FORMAT_GET_TIMES,_loc4_.CornucopiaList[_loc3_].GotTimes);
         this.FHintBoxTip.Caption = _loc2_;
         if(this.FTipOnOver != null)
         {
            this.FTipOnOver(param1,this.FHintBoxTip);
         }
      }
      
      protected function ProcessorOnTipOut(param1:MouseEvent) : void
      {
         if(this.FTipOnOut != null)
         {
            this.FTipOnOut(param1);
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
      
      protected function ProcessorEffectText(param1:String) : void
      {
         if(this.FEffectText != null)
         {
            this.FEffectText(param1);
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
      
      public function UpdateUI() : void
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
         this.UpdateBox();
         this.UpdateSlot();
      }
      
      public function GetRewardRet() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TCornucopia = null;
         var _loc5_:TCornucopiaBox = null;
         _loc4_ = SLogicsCore.ActivitiesData.GetActivityByIdentify(ACTIVITY_1_ID) as TCornucopia;
         _loc5_ = _loc4_.CornucopiaList[this.FIndex];
         _loc2_ = _loc5_.GotTimes - 1;
         _loc4_.ChangeBoxStatus(_loc5_.Identify,1,_loc2_);
         _loc3_ = STRING_FROGWALLET.FORMAT_GET_SUCCESSED;
         _loc3_ += TUtilityString.Format(STRING_FROGWALLET.FORMAT_PAY_LIMIT,_loc5_.GetGold) + "\n";
         _loc2_ = _loc5_.Inventories.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ += _loc5_.Inventories.GetInventoryByIndex(_loc1_).Name + "*" + _loc5_.Inventories.GetInventoryByIndex(_loc1_).Quantity + "\n";
            _loc1_++;
         }
         this.ProcessorEffectText(_loc3_);
         this.UpdateBox();
      }
      
      public function Unmount() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FSlotList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FSlotList[_loc1_] != null)
            {
               this.FSlotList[_loc1_].Context = null;
            }
            _loc1_++;
         }
      }
   }
}

