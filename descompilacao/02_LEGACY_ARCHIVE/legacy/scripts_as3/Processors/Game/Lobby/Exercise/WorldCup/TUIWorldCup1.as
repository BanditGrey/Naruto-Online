package Processors.Game.Lobby.Exercise.WorldCup
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TWorldCupVo1;
   import Logics.Exercise.WorldCup.TWorldCup1;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIWorldCup1 extends TUIBaseWindow
   {
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected static const GROUP_COUNT:int = 8;
      
      protected static const TEAM_COUNT:int = 4;
      
      protected static const MAX_BET_COUNT:int = 3;
      
      protected var FWorldCup1:TWorldCup1;
      
      protected var FWorldCupBin:TBins;
      
      protected var FMC_Bet:MovieClip;
      
      protected var FTF_Input:TextField;
      
      protected var SelectVo:TWorldCupVo1;
      
      protected var BetValue:int;
      
      protected var FOnBackMain:Function;
      
      public function TUIWorldCup1(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TWorldCupVo1 = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < GROUP_COUNT)
         {
            _loc3_ = 0;
            while(_loc3_ < TEAM_COUNT)
            {
               param1 = FMC_Scene["MC_Group" + _loc2_]["MC_Team" + _loc3_];
               TGameUtil.setButtonMode(param1.btn_buy,true);
               param1.btn_buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowBet);
               _loc3_++;
            }
            _loc2_++;
         }
         this.FMC_Bet = FMC_Scene["MC_Bet"];
         this.FMC_Bet.visible = false;
         this.FTF_Input = this.FMC_Bet["TF_Input"];
         this.FTF_Input.restrict = "0-9";
         this.FTF_Input.maxChars = 7;
         this.FTF_Input.addEventListener(Event.CHANGE,this.OnTextChange);
         TGameUtil.setButtonMode(this.FMC_Bet.Btn_Ok,true);
         this.FMC_Bet.Btn_Ok.addEventListener(MouseEvent.CLICK,this.ButtonOKOnClick);
         TGameUtil.setButtonMode(this.FMC_Bet.Btn_Cancel,true);
         this.FMC_Bet.Btn_Cancel.addEventListener(MouseEvent.CLICK,this.ButtonCancelOnClick);
         FMC_Scene.Btn_Back.addEventListener(MouseEvent.CLICK,this.ProcessorOnBackMain);
         FMC_Scene.Btn_Recharge.addEventListener(MouseEvent.CLICK,this.ProcessorOnRechargeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(SLogicsCore.WorldCupDatas.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(SLogicsCore.WorldCupDatas.EndTime) - 1) * 1000)));
         FMC_Scene.TF_GiftGold.text = SLogicsCore.WorldCupDatas.giftGold.toString();
         FMC_Scene.TF_Gold.text = SLogicsCore.WorldCupDatas.gold.toString();
         if(this.FWorldCup1.betCountry.length == 0)
         {
            FMC_Scene.TF_Count.text = MAX_BET_COUNT.toString();
         }
         else
         {
            _loc3_ = MAX_BET_COUNT - this.FWorldCup1.betCountry.length;
            FMC_Scene.TF_Count.text = _loc3_.toString();
         }
      }
      
      protected function UpdateItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TWorldCupVo1 = null;
         _loc1_ = 0;
         while(_loc1_ < GROUP_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Group" + _loc1_];
            _loc2_ = 0;
            while(_loc2_ < TEAM_COUNT)
            {
               _loc5_ = this.FWorldCupBin.GetDatebaseByIndex(_loc1_ * TEAM_COUNT + _loc2_) as TWorldCupVo1;
               _loc3_.TF_Group.text = _loc5_.group;
               _loc4_ = _loc3_["MC_Team" + _loc2_];
               _loc4_.MC_Bet.visible = this.FWorldCup1.betCountry.indexOf(_loc5_.Identifier) == -1 ? false : true;
               _loc4_.TF_Name.text = _loc5_.name;
               _loc4_.TF_Rate.text = (_loc5_.odds / 100 as Number).toFixed(2);
               _loc4_.MC_Flag.gotoAndStop(_loc5_.flag);
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorOnShowBet(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc2_ = int(String(param1.currentTarget.parent.parent.name).slice(8));
         this.SelectVo = this.FWorldCupBin.GetDatebaseByIndex(_loc2_ * TEAM_COUNT + _loc3_) as TWorldCupVo1;
         this.BetValue = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FWorldCup1.betCountry.length)
         {
            if(this.FWorldCup1.betCountry[_loc2_] == this.SelectVo.Identifier)
            {
               this.BetValue = this.FWorldCup1.betValue[_loc2_];
               break;
            }
            _loc2_++;
         }
         this.FMC_Bet.visible = true;
         this.FTF_Input.text = "";
         this.FMC_Bet["TF_Value0"].text = this.BetValue.toString();
         this.FMC_Bet["TF_Value1"].text = this.SelectVo.max - this.BetValue;
      }
      
      protected function OnTextChange(param1:Event) : void
      {
         var _loc2_:int = 0;
         _loc2_ = parseInt(this.FTF_Input.text);
         _loc2_ = Math.min(_loc2_,this.SelectVo.max - this.BetValue);
         this.FTF_Input.text = _loc2_.toString();
      }
      
      protected function ButtonOKOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = parseInt(this.FTF_Input.text);
         this.FMC_Bet.visible = false;
         if(_loc2_ > 0)
         {
            FOnBuyBox(ACTIVITY_1_ID,TProcessorWorldCup.ACTIVITY_1_BET_CHAMPION,this.SelectVo.Identifier,_loc2_,_loc2_ * 100);
         }
      }
      
      protected function ButtonCancelOnClick(param1:MouseEvent) : void
      {
         this.FMC_Bet.visible = false;
      }
      
      protected function ProcessorOnBackMain(param1:MouseEvent) : void
      {
         if(OnShowWindow != null)
         {
            OnShowWindow();
         }
      }
      
      protected function ProcessorOnRechargeUp(param1:MouseEvent) : void
      {
         if(FGotoRecharge != null)
         {
            FGotoRecharge();
         }
      }
      
      protected function ProcessorOnItemOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(param1,param2);
         }
      }
      
      protected function ProcessorOnItemOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(param1,param2);
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int) : void
      {
         if(FOnShowRecruit != null)
         {
            FOnShowRecruit(param1,param2);
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_1_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      public function get OnBackMain() : Function
      {
         return this.FOnBackMain;
      }
      
      public function set OnBackMain(param1:Function) : void
      {
         this.FOnBackMain = param1;
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FWorldCup1 = SLogicsCore.WorldCupDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TWorldCup1;
         this.FWorldCupBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_WorldCup1);
         this.UpdateText();
         this.UpdateItem();
      }
   }
}

