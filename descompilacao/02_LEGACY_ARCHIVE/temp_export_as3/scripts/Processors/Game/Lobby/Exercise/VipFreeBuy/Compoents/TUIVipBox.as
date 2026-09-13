package Processors.Game.Lobby.Exercise.VipFreeBuy.Compoents
{
   import Foundation.Common.THint;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.VipFreeBuy.TVipFreeBuy;
   import Logics.Exercise.VipShop.TVipBox;
   import Logics.SLogicsCore;
   import Resources.Strings.STRING_VIPFREEBUY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIVipBox extends TUIComponent
   {
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBTN_GetReward:MovieClip;
      
      protected var FBTN_Buy:MovieClip;
      
      protected var FVipFreeBuy:TVipFreeBuy;
      
      protected var FIndex:int;
      
      protected var FHintBoxTip:THint;
      
      protected var FOnGetReward:Function;
      
      protected var FOnBuyBox:Function;
      
      protected var FOnBtnOver:Function;
      
      protected var FOnBtnOut:Function;
      
      public function TUIVipBox(param1:TUIComponent)
      {
         super(param1);
         this.FVipFreeBuy = SLogicsCore.VipFreeBuy;
         this.FHintBoxTip = new THint();
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         this.FBTN_GetReward = this.FMC_Scene["BTN_GetReward"];
         this.FBTN_Buy = this.FMC_Scene["BTN_Buy"];
         TGameUtil.setButtonMode(this.FBTN_GetReward,false);
         TGameUtil.setButtonMode(this.FBTN_Buy,false);
         this.FBTN_GetReward.addEventListener(MouseEvent.CLICK,this.ButtonGetOnClick);
         this.FBTN_Buy.addEventListener(MouseEvent.CLICK,this.ButtonBuyOnClick);
         this.FBTN_Buy.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBtnOver);
         this.FBTN_Buy.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnBtnOut);
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:TVipBox = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc1_ = this.FVipFreeBuy.GetDateByIndex(this.FIndex);
         if(!_loc1_)
         {
            return;
         }
         this.FMC_Scene["TF_VipLevel"].text = "VIP" + _loc1_.VipLevel;
         this.FMC_Scene.mc_box.gotoAndStop(this.FIndex + 1);
         _loc2_ = this.FVipFreeBuy.RewardStatus[this.FIndex];
         if(_loc2_ == -1)
         {
            this.FMC_Scene["MC_Got"].visible = false;
            if(!this.FVipFreeBuy.IsActivityEnd(TBaseActivity.PAY_END))
            {
               if(_loc1_.CheckVipLevel())
               {
                  this.SetButtonsMode(true,false,true,false);
               }
               else
               {
                  this.SetButtonsMode(true,false,false,false);
               }
            }
         }
         else if(_loc2_ == 0)
         {
            this.FMC_Scene["MC_Got"].visible = false;
            this.SetButtonsMode(false,true,false,true);
         }
         else if(_loc2_ == 1)
         {
            this.FMC_Scene["MC_Got"].visible = true;
            this.SetButtonsMode(false,false,false,false);
         }
         if(this.FVipFreeBuy.IsActivityEnd(TBaseActivity.PAY_END))
         {
            if(_loc2_ == -1)
            {
               this.FMC_Scene["MC_End"].visible = true;
               this.SetButtonsMode(false,false,false,false);
            }
            else if(this.FVipFreeBuy.GetBoxDay[this.FIndex] == 5)
            {
               this.FMC_Scene["MC_End"].visible = true;
               this.SetButtonsMode(false,false,false,false);
            }
            else
            {
               this.FMC_Scene["MC_End"].visible = false;
            }
         }
         else
         {
            this.FMC_Scene["MC_End"].visible = false;
         }
      }
      
      protected function SetButtonsMode(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false) : void
      {
         this.FBTN_Buy.visible = param1;
         this.FBTN_GetReward.visible = param2;
         TGameUtil.setButtonMode(this.FBTN_Buy,param3);
         TGameUtil.setButtonMode(this.FBTN_GetReward,param4);
      }
      
      protected function ButtonBuyOnClick(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         TGameUtil.setButtonMode(this.FBTN_Buy,false);
         if(this.FOnBuyBox != null)
         {
            this.FOnBuyBox(this.FIndex);
         }
      }
      
      protected function ButtonGetOnClick(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         TGameUtil.setButtonMode(this.FBTN_GetReward,false);
         if(this.FOnGetReward != null)
         {
            this.FOnGetReward(this.FIndex);
         }
      }
      
      protected function ProcessorOnBtnOver(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TVipBox = null;
         var _loc2_:String = "";
         if(param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc4_ = this.FVipFreeBuy.GetDateByIndex(this.FIndex);
         if(!_loc4_)
         {
            return;
         }
         _loc2_ = TUtilityString.Format(STRING_VIPFREEBUY.STRINGS_VIP_BUY_LEVEL,_loc4_.VipLevel);
         this.FHintBoxTip.Caption = _loc2_;
         if(this.FOnBtnOver != null)
         {
            this.FOnBtnOver(param1,this.FHintBoxTip);
         }
      }
      
      protected function ProcessorOnBtnOut(param1:MouseEvent) : void
      {
         if(this.FOnBtnOut != null)
         {
            this.FOnBtnOut(param1);
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
      
      public function get OnBuyBox() : Function
      {
         return this.FOnBuyBox;
      }
      
      public function set OnBuyBox(param1:Function) : void
      {
         this.FOnBuyBox = param1;
      }
      
      public function get Index() : int
      {
         return this.FIndex;
      }
      
      public function set Index(param1:int) : void
      {
         this.FIndex = param1;
      }
      
      public function get OnBtnOver() : Function
      {
         return this.FOnBtnOver;
      }
      
      public function set OnBtnOver(param1:Function) : void
      {
         this.FOnBtnOver = param1;
      }
      
      public function get OnBtnOut() : Function
      {
         return this.FOnBtnOut;
      }
      
      public function set OnBtnOut(param1:Function) : void
      {
         this.FOnBtnOut = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
      }
      
      public function UpdateUI() : void
      {
         this.UpdateBox();
      }
   }
}

