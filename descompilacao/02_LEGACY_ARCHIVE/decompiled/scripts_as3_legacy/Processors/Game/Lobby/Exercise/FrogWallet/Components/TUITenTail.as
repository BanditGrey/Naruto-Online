package Processors.Game.Lobby.Exercise.FrogWallet.Components
{
   import Foundation.Common.THint;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.FrogWallet.TTenTail;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Rendering.Overlayers.Box.TOverlayerBox;
   import Resources.Constants.CONST_FROGWALLET;
   import Resources.Strings.STRING_FROGWALLET;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TUITenTail extends TUIComponent
   {
      
      public static const TAIL_COUNT:int = 10;
      
      public static const SOUL_COUNT:int = 9;
      
      public static const COLOR_PURPLE:int = 1;
      
      public static const COLOR_GOLD:int = 2;
      
      public static const COLOR_RED:int = 3;
      
      public static const ACTIVITY_3_ID:int = CONST_FROGWALLET.ACTIVITY_3_ID;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FSoulList:Vector.<MovieClip>;
      
      protected var FTailList:Vector.<MovieClip>;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FTF_Time:TextField;
      
      protected var FTF_Date:TextField;
      
      protected var FTF_Desc:TextField;
      
      protected var FTF_TailDesc:TextField;
      
      protected var FTF_SoulDesc:TextField;
      
      protected var FTF_Scale:TextField;
      
      protected var FTF_DayTime:TextField;
      
      protected var FTF_Finish:TextField;
      
      protected var FMC_Fire:MovieClip;
      
      protected var FInitialized:Boolean;
      
      protected var FHintBoxTip:THint;
      
      protected var FTimeID:int;
      
      protected var FCurDayTime:Number;
      
      protected var FTenTail:TTenTail;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FBeClicked:Boolean;
      
      protected var FBoxID:int;
      
      protected var FOnGetReward:Function;
      
      protected var FEffectText:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      public function TUITenTail(param1:TUIComponent)
      {
         super(param1);
         this.FSoulList = new Vector.<MovieClip>(SOUL_COUNT);
         this.FBoxList = new Vector.<MovieClip>(TAIL_COUNT);
         this.FTailList = new Vector.<MovieClip>(TAIL_COUNT);
         this.FHintBoxTip = new THint();
         this.FOverlayerBox = new TOverlayerBox(this.Parent.Parent.Parent);
         this.FOverlayerBox.Visible = false;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         _loc2_ = 0;
         while(_loc2_ < SOUL_COUNT)
         {
            param1 = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_Soul + _loc2_];
            this.FSoulList[_loc2_] = param1;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < TAIL_COUNT)
         {
            param1 = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_Slot + _loc2_];
            param1.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTipOver);
            param1.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnTipOut);
            param1.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnGetReward);
            this.FBoxList[_loc2_] = param1;
            param1 = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_Tail + _loc2_];
            this.FTailList[_loc2_] = param1;
            _loc2_++;
         }
         this.FTF_Time = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_TF_TIME];
         this.FTF_Date = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_TF_DATE];
         this.FTF_Desc = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_TF_Desc];
         this.FTF_TailDesc = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_TF_TailDesc];
         this.FTF_SoulDesc = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_TF_SoulDesc];
         this.FTF_Scale = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_TF_Scale];
         this.FTF_DayTime = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_TF_DayTime];
         this.FTF_Finish = this.FMC_Scene["TF_Finish"];
         this.FTF_Finish.visible = false;
         this.FMC_Fire = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_Fire];
         this.FMC_Fire.mouseEnabled = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBox);
      }
      
      protected function UpdateSoul() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = this.FTenTail.GetCurSoulIndex();
         _loc1_ = 0;
         while(_loc1_ < SOUL_COUNT)
         {
            _loc3_ = this.FSoulList[_loc1_];
            if(_loc1_ < _loc4_)
            {
               _loc3_.gotoAndStop(2);
            }
            else
            {
               _loc3_.gotoAndStop(1);
            }
            _loc3_.MC_Soul.gotoAndStop(_loc1_ + 1);
            _loc3_.TF_Soul.text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_SOUL,this.FTenTail.DisplaySoulConfig[_loc1_]);
            _loc3_.TF_Certificate.text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_CERTIFICATE,this.FTenTail.CertificateConfig[_loc1_]);
            _loc1_++;
         }
      }
      
      protected function UpdateTail() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = this.FTenTail.GetCurTailIndex();
         _loc1_ = 0;
         while(_loc1_ < TAIL_COUNT)
         {
            _loc3_ = this.FTailList[_loc1_];
            if(_loc1_ < _loc4_)
            {
               _loc3_.gotoAndStop(1);
            }
            else
            {
               _loc3_.gotoAndStop(2);
            }
            if(_loc1_ == _loc4_ - 1)
            {
               _loc3_.MC_Effect.visible = true;
               _loc3_.MC_Effect.gotoAndPlay(1);
            }
            else
            {
               _loc3_.MC_Effect.visible = false;
               _loc3_.MC_Effect.stop();
            }
            _loc3_.TF_Text.text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_MULTI_LINE_SOUL,this.FTenTail.DisplayTenTailConfig[_loc1_]);
            _loc1_++;
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = this.FTenTail.GetCurTailIndex();
         _loc1_ = 0;
         while(_loc1_ < TAIL_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            _loc3_.gotoAndStop(this.FTenTail.RewardColor[_loc1_]);
            if(this.FTenTail.RewardStatus[_loc1_] == -1)
            {
               _loc3_.MC_Got.visible = false;
               _loc3_.filters = [TGameUtil.GaryColorFilters];
            }
            else if(this.FTenTail.RewardStatus[_loc1_] == 0)
            {
               _loc3_.MC_Got.visible = false;
               _loc3_.filters = [TGameUtil.highLightFilters];
            }
            else
            {
               _loc3_.MC_Got.visible = true;
               _loc3_.filters = [];
            }
            _loc1_++;
         }
         this.FMC_Fire.gotoAndStop(this.FTenTail.FireColor);
         switch(this.FTenTail.FireColor)
         {
            case COLOR_PURPLE:
               this.FMC_Fire["purple"].mouseEnabled = false;
               break;
            case COLOR_GOLD:
               this.FMC_Fire["gold"].mouseEnabled = false;
               break;
            case COLOR_RED:
               this.FMC_Fire["red"].mouseEnabled = false;
         }
      }
      
      protected function UpdateText() : void
      {
         this.FTF_Date.text = TUtilityString.Format(STRING_FROGWALLET.FormatString_TimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FTenTail.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FTenTail.PayEndTime - 1) * 1000)));
         this.FTF_Desc.htmlText = this.FTenTail.ActivityDesc;
         this.FTF_SoulDesc.text = this.FTenTail.GetNextSoulDesc();
         this.FTF_TailDesc.text = this.FTenTail.GetNextTailDesc();
         this.FTF_Finish.visible = this.FTenTail.IsFinish();
         this.FTF_Scale.text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_EXCHANGE_SCALE,this.FTenTail.ExchangeScale);
      }
      
      protected function ProcessorOnGetReward(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(this.FBeClicked)
         {
            return;
         }
         _loc3_ = param1.currentTarget.name;
         if(_loc3_ == "MC_Fire")
         {
            _loc2_ = TAIL_COUNT - 1;
         }
         else
         {
            _loc2_ = int(_loc3_.slice(7));
         }
         if(this.FTenTail.RewardStatus[_loc2_] != 0)
         {
            return;
         }
         this.FBoxID = this.FTenTail.RewardID[_loc2_];
         this.FBeClicked = true;
         if(this.FOnGetReward != null)
         {
            this.FOnGetReward(ACTIVITY_3_ID,this.FBoxID);
         }
      }
      
      protected function ProcessorOnTipOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         this.FOverlayerBox.Context = null;
         _loc3_ = param1.currentTarget.name;
         if(_loc3_ == "MC_Fire")
         {
            _loc2_ = TAIL_COUNT - 1;
         }
         else
         {
            _loc2_ = int(_loc3_.slice(7));
         }
         this.FOverlayerBox.Context = this.FTenTail.Rewards[_loc2_];
         this.FOverlayerBox.Render(FUICore.MouseCoordinate);
         this.FOverlayerBox.Show();
      }
      
      protected function ProcessorOnTipOut(param1:MouseEvent) : void
      {
         this.FOverlayerBox.Hide();
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
      
      public function get BeClicked() : Boolean
      {
         return this.FBeClicked;
      }
      
      public function set BeClicked(param1:Boolean) : void
      {
         this.FBeClicked = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function LogicsPerform() : void
      {
         var _loc1_:String = null;
         if(this.FInitialized && this.Visible)
         {
            if(!this.FTenTail)
            {
               return;
            }
            this.FTF_Time.text = TGameUtil.fomatTime(this.FTenTail.PayEndTime - STimingCore.GetServerTick());
            _loc1_ = TGameUtil.fomatTime(this.FCurDayTime / 1000 - STimingCore.GetServerTick());
            this.FTF_DayTime.text = STRING_FROGWALLET.FORMAT_TIMER + _loc1_;
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
         this.FTenTail = SLogicsCore.ActivitiesData.GetActivityByIdentify(ACTIVITY_3_ID) as TTenTail;
         if(!this.FTenTail)
         {
            return;
         }
         this.UpdateSoul();
         this.UpdateTail();
         this.UpdateBox();
         this.UpdateText();
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
         var _loc4_:int = 0;
         var _loc5_:TInventories = null;
         this.FBeClicked = false;
         this.FTenTail.ChangeBoxStatus(this.FBoxID,1,0);
         _loc4_ = this.FTenTail.RewardID.indexOf(this.FBoxID);
         if(_loc4_ == -1)
         {
            return;
         }
         _loc3_ = STRING_FROGWALLET.FORMAT_GET_SUCCESSED;
         _loc5_ = this.FTenTail.Rewards[_loc4_];
         _loc2_ = _loc5_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ += _loc5_.GetInventoryByIndex(_loc1_).Name + "*" + _loc5_.GetInventoryByIndex(_loc1_).Quantity + "\n";
            _loc1_++;
         }
         this.ProcessorEffectText(_loc3_);
         this.UpdateUI();
      }
   }
}

