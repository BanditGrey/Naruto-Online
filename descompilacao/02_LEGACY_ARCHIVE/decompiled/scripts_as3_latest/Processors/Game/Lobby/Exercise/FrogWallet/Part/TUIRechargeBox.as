package Processors.Game.Lobby.Exercise.FrogWallet.Part
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.FrogWallet.TRechargeAccum;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_FROGWALLET;
   import Resources.Strings.STRING_FROGWALLET;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class TUIRechargeBox extends TUIComponent
   {
      
      public static const ACTIVITY_2_ID:int = CONST_FROGWALLET.ACTIVITY_2_ID;
      
      protected var FInitialization:Boolean;
      
      protected var FIsVisible:Boolean;
      
      protected var FIndex:uint;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMC_Finish:Sprite;
      
      protected var FMC_NotFinish:Sprite;
      
      protected var FMC_Process:Sprite;
      
      protected var FMC_NotBegin:Sprite;
      
      protected var FTF_FinishRebate:TextField;
      
      protected var FTF_FinishRechargeGold:TextField;
      
      protected var FTF_FinishRebateGold:TextField;
      
      protected var FTF_ProcessRebate:TextField;
      
      protected var FTF_ProcessRechargeGold:TextField;
      
      protected var FCurDayIndex:int;
      
      protected var FOnTipMove:Function;
      
      protected var FOnTipOut:Function;
      
      public function TUIRechargeBox(param1:TUIComponent)
      {
         super(param1);
         this.FInitialization = false;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         this.FMC_Finish = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_Finish];
         this.FMC_NotFinish = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_NotFinish];
         this.FMC_Process = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_Process];
         this.FMC_NotBegin = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_NotBegin];
         this.FTF_FinishRebate = this.FMC_Finish[CONST_FROGWALLET.RESOURCE_LINK_TF_Rebate];
         this.FTF_FinishRechargeGold = this.FMC_Finish[CONST_FROGWALLET.RESOURCE_LINK_TF_RechargeGold];
         this.FTF_FinishRebateGold = this.FMC_Finish[CONST_FROGWALLET.RESOURCE_LINK_TF_RebateGold];
         this.FTF_ProcessRebate = this.FMC_Process[CONST_FROGWALLET.RESOURCE_LINK_TF_Rebate];
         this.FTF_ProcessRechargeGold = this.FMC_Process[CONST_FROGWALLET.RESOURCE_LINK_TF_RechargeGold];
      }
      
      protected function UpdateInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TRechargeAccum = null;
         _loc2_ = SLogicsCore.ActivitiesData.GetActivityByIdentify(ACTIVITY_2_ID) as TRechargeAccum;
         _loc1_ = _loc2_.GetCurDayIndex();
         if(STimingCore.GetServerTick() > _loc2_.PayEndTime && this.FIndex == 4 || this.FIndex < _loc1_)
         {
            if(_loc2_.AmountGold[this.FIndex] > 0)
            {
               this.FMC_Finish.visible = true;
               this.FMC_NotFinish.visible = false;
               this.FMC_Process.visible = false;
               this.FMC_NotBegin.visible = false;
               this.FTF_FinishRebate.text = _loc2_.GetRebateByIndex(this.FIndex).toString() + "%";
               this.FTF_FinishRechargeGold.text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_RECHARGE_GOLD,_loc2_.AmountGold[this.FIndex]);
               this.FTF_FinishRebateGold.text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_REBATE_GOLD,_loc2_.GetRebateGoldByIndex(this.FIndex));
            }
            else
            {
               this.FMC_Finish.visible = false;
               this.FMC_NotFinish.visible = true;
               this.FMC_Process.visible = false;
               this.FMC_NotBegin.visible = false;
            }
         }
         else if(this.FIndex == _loc1_)
         {
            this.FMC_Finish.visible = false;
            this.FMC_NotFinish.visible = false;
            this.FMC_Process.visible = true;
            this.FMC_NotBegin.visible = false;
            this.FTF_ProcessRebate.text = _loc2_.GetRebateByIndex(this.FIndex).toString() + "%";
            this.FTF_ProcessRechargeGold.text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_RECHARGE_GOLD,_loc2_.AmountGold[this.FIndex]);
         }
         else
         {
            this.FMC_Finish.visible = false;
            this.FMC_NotFinish.visible = false;
            this.FMC_Process.visible = false;
            this.FMC_NotBegin.visible = true;
         }
      }
      
      public function get IsVisible() : Boolean
      {
         return this.FIsVisible;
      }
      
      public function set IsVisible(param1:Boolean) : void
      {
         this.FIsVisible = param1;
         this.FMC_Scene.visible = this.FIsVisible;
      }
      
      public function get Index() : uint
      {
         return this.FIndex;
      }
      
      public function set Index(param1:uint) : void
      {
         this.FIndex = param1;
      }
      
      public function get OnTipMove() : Function
      {
         return this.FOnTipMove;
      }
      
      public function set OnTipMove(param1:Function) : void
      {
         this.FOnTipMove = param1;
      }
      
      public function get OnTipOut() : Function
      {
         return this.FOnTipOut;
      }
      
      public function set OnTipOut(param1:Function) : void
      {
         this.FOnTipOut = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialization = true;
      }
      
      public function UpdateUI() : void
      {
         this.UpdateInfo();
      }
   }
}

