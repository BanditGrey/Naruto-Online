package Processors.Game.Lobby.Exercise.FrogWallet.Components
{
   import Foundation.Common.THint;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.FrogWallet.TRechargeAccum;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.FrogWallet.Part.TUIRechargeBox;
   import Resources.Constants.CONST_FROGWALLET;
   import Resources.Strings.STRING_FROGWALLET;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TUIRechargeAccum extends TUIComponent
   {
      
      public static const BOX_COUNT:int = 5;
      
      public static const LIMIT_COUNT:int = 5;
      
      public static const ACTIVITY_2_ID:int = CONST_FROGWALLET.ACTIVITY_2_ID;
      
      public static const ARROW_INIT_X:Number = 27;
      
      public static const ARROW_INIT_Y:Number = 31;
      
      public static const ARROW_INTERVAL:Number = 65;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBoxList:Vector.<TUIRechargeBox>;
      
      protected var FMC_AccumBar:MovieClip;
      
      protected var FMC_Bar:MovieClip;
      
      protected var FMC_Mask:Sprite;
      
      protected var FMC_BarText:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FInitialized:Boolean;
      
      protected var FHintBoxTip:THint;
      
      protected var FTimeID:int;
      
      protected var FCurDayTime:Number;
      
      protected var FOnGetReward:Function;
      
      protected var FEffectText:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      public function TUIRechargeAccum(param1:TUIComponent)
      {
         super(param1);
         this.FBoxList = new Vector.<TUIRechargeBox>();
         this.FHintBoxTip = new THint();
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIRechargeBox = null;
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         _loc3_ = int(this.FBoxList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FBoxList.pop();
            _loc4_.parent.removeChild(_loc4_);
            _loc2_++;
         }
         this.FBoxList.length = 0;
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            param1 = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_Box + _loc2_];
            _loc4_ = new TUIRechargeBox(this);
            _loc4_.Perform_UIDispatch(param1);
            _loc4_.Index = _loc2_;
            this.FBoxList.push(_loc4_);
            _loc2_++;
         }
         this.FMC_AccumBar = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_AccumBar];
         this.FMC_Bar = this.FMC_AccumBar[CONST_FROGWALLET.RESOURCE_LINK_MC_Bar];
         this.FMC_Mask = this.FMC_Bar[CONST_FROGWALLET.RESOURCE_LINK_MC_Mask];
         this.FBarMaxWidth = this.FMC_Mask.width;
         this.FMC_BarText = this.FMC_AccumBar[CONST_FROGWALLET.RESOURCE_LINK_MC_BarText];
         this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward].addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnGetReward);
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            this.FBoxList[_loc1_].UpdateUI();
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TRechargeAccum = null;
         var _loc5_:Vector.<int> = null;
         _loc3_ = SLogicsCore.ActivitiesData.GetActivityByIdentify(ACTIVITY_2_ID) as TRechargeAccum;
         _loc2_ = LIMIT_COUNT;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc1_ < _loc3_.RebateNeedGold.length)
            {
               this.FMC_AccumBar[CONST_FROGWALLET.RESOURCE_LINK_TF_NeedGold + _loc1_].visible = true;
               this.FMC_AccumBar[CONST_FROGWALLET.RESOURCE_LINK_TF_NeedGold + _loc1_].text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_PAY_LIMIT,_loc3_.RebateNeedGold[_loc1_]);
            }
            else
            {
               this.FMC_AccumBar[CONST_FROGWALLET.RESOURCE_LINK_TF_NeedGold + _loc1_].visible = false;
            }
            _loc1_++;
         }
         var _loc4_:int = _loc3_.GetCurDayIndex();
         if(STimingCore.GetServerTick() > _loc3_.PayEndTime)
         {
            this.FMC_AccumBar[CONST_FROGWALLET.RESOURCE_LINK_TF_Gold].text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_PAY_LIMIT,0);
         }
         else
         {
            this.FMC_AccumBar[CONST_FROGWALLET.RESOURCE_LINK_TF_Gold].text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_PAY_LIMIT,_loc3_.GetRebateGoldByIndex(_loc4_));
         }
         if(_loc3_.CheckIsContinue())
         {
            this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_TF_Rebate].text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_PAY_LIMIT,_loc3_.GetTotalRebateGold() + _loc3_.GetBuffGold());
         }
         else
         {
            this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_TF_Rebate].text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_PAY_LIMIT,_loc3_.GetTotalRebateGold());
         }
         if(_loc3_.CheckIsContinue())
         {
            this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_Buff].visible = true;
            this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_Buff][CONST_FROGWALLET.RESOURCE_LINK_TF_Buff].text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_REBATE,_loc3_.Buff);
         }
         else
         {
            this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_Buff].visible = false;
         }
         if(STimingCore.GetServerTick() > _loc3_.PayEndTime)
         {
            this.FMC_AccumBar[CONST_FROGWALLET.RESOURCE_LINK_TF_Context].text = "";
         }
         else if(_loc3_.AmountGold[_loc4_] >= _loc3_.MaxPayLimit)
         {
            this.FMC_AccumBar[CONST_FROGWALLET.RESOURCE_LINK_TF_Context].text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_MAX_REBATE,_loc3_.GetRebateByIndex(_loc4_));
         }
         else
         {
            _loc5_ = _loc3_.GetNextLimitNeedGold();
            this.FMC_AccumBar[CONST_FROGWALLET.RESOURCE_LINK_TF_Context].text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_RECHARGE_CONTEXT,_loc3_.AmountGold[_loc4_],_loc5_[0],_loc5_[1]);
         }
      }
      
      protected function UpdateBar() : void
      {
         var _loc1_:TRechargeAccum = null;
         _loc1_ = SLogicsCore.ActivitiesData.GetActivityByIdentify(ACTIVITY_2_ID) as TRechargeAccum;
         var _loc2_:int = _loc1_.GetTodayIndex();
         var _loc3_:int = _loc1_.GetCurDayIndex();
         if(STimingCore.GetServerTick() > _loc1_.PayEndTime)
         {
            this.FMC_Mask.width = 0;
            this.FMC_AccumBar[CONST_FROGWALLET.RESOURCE_LINK_MC_Arrow].x = -5;
            this.FMC_AccumBar[CONST_FROGWALLET.RESOURCE_LINK_MC_Arrow].gotoAndStop(1);
            this.FMC_BarText.gotoAndStop(2);
         }
         else if(_loc1_.AmountGold[_loc3_] < _loc1_.MinRechargeLimit)
         {
            this.FMC_Mask.width = 0;
            this.FMC_AccumBar[CONST_FROGWALLET.RESOURCE_LINK_MC_Arrow].x = -5;
            this.FMC_AccumBar[CONST_FROGWALLET.RESOURCE_LINK_MC_Arrow].gotoAndStop(1);
            this.FMC_BarText.gotoAndStop(2);
         }
         else
         {
            this.FMC_Mask.width = Math.min((_loc2_ + 1) * ARROW_INTERVAL,this.FBarMaxWidth);
            this.FMC_AccumBar[CONST_FROGWALLET.RESOURCE_LINK_MC_Arrow].x = ARROW_INIT_X + _loc2_ * ARROW_INTERVAL;
            this.FMC_AccumBar[CONST_FROGWALLET.RESOURCE_LINK_MC_Arrow].gotoAndPlay(1);
            this.FMC_BarText.gotoAndStop(1);
         }
         this.FMC_BarText[CONST_FROGWALLET.RESOURCE_LINK_TF_Rebate + "0"].text = "0%";
         _loc2_ = 0;
         while(_loc2_ < LIMIT_COUNT)
         {
            if(_loc2_ < _loc1_.Rebate.length)
            {
               this.FMC_BarText[CONST_FROGWALLET.RESOURCE_LINK_TF_Rebate + (_loc2_ + 1)].visible = true;
               this.FMC_BarText[CONST_FROGWALLET.RESOURCE_LINK_TF_Rebate + (_loc2_ + 1)].text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_REBATE,_loc1_.Rebate[_loc2_]);
            }
            else
            {
               this.FMC_BarText[CONST_FROGWALLET.RESOURCE_LINK_TF_Rebate + (_loc2_ + 1)].visible = false;
            }
            _loc2_++;
         }
         this.FMC_AccumBar[CONST_FROGWALLET.RESOURCE_LINK_TF_MinLimit].text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_PAY_LIMIT,_loc1_.MinRechargeLimit);
      }
      
      protected function UpdateBtn() : void
      {
         var _loc1_:TRechargeAccum = null;
         _loc1_ = SLogicsCore.ActivitiesData.GetActivityByIdentify(ACTIVITY_2_ID) as TRechargeAccum;
         if(STimingCore.GetServerTick() > _loc1_.PayEndTime)
         {
            if(_loc1_.RewardStatus[0] == 0)
            {
               this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward].visible = true;
               TGameUtil.setButtonMode(this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward],true);
            }
            else if(_loc1_.RewardStatus[0] == 1)
            {
               this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward].visible = false;
            }
            else
            {
               this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward].visible = true;
               TGameUtil.setButtonMode(this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward],false);
            }
         }
         else
         {
            this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward].visible = true;
            TGameUtil.setButtonMode(this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward],false);
         }
      }
      
      protected function ProcessorOnGetReward(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         TGameUtil.setButtonMode(this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_BTN_GetReward],false);
         if(this.FOnGetReward != null)
         {
            this.FOnGetReward(ACTIVITY_2_ID,1);
         }
      }
      
      protected function ProcessorEffectText(param1:String) : void
      {
         if(this.FEffectText != null)
         {
            this.FEffectText(param1);
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
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function LogicsPerform() : void
      {
         if(this.FInitialized && this.visible)
         {
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
         this.UpdateText();
         this.UpdateBar();
         this.UpdateBtn();
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
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TRechargeAccum = null;
         _loc4_ = SLogicsCore.ActivitiesData.GetActivityByIdentify(ACTIVITY_2_ID) as TRechargeAccum;
         _loc4_.ChangeBoxStatus(0,1,0);
         _loc3_ = STRING_FROGWALLET.FORMAT_GET;
         this.ProcessorEffectText(_loc3_);
         this.UpdateUI();
      }
   }
}

