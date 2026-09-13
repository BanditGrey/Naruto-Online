package Processors.Game.Lobby.Exercise.FirstRechange_new.component
{
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Inventories.TInventories;
   import Processors.Game.Lobby.Exercise.FirstRechange_new.eve.DatasEvent;
   import Processors.Game.Lobby.Exercise.FirstRechange_new.eve.FirstRechargeEventTypeName;
   import Resources.Constants.CONST_FIRSTRECHAGE_NEW;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class RechargeRewardItem extends Sprite
   {
      
      private var _ui:MovieClip;
      
      private var _tf_goldNum:TextField;
      
      private var _tf_costNum:TextField;
      
      private var _mc_bagType:MovieClip;
      
      private var _btn_getReward:MovieClip;
      
      private var _info:RechargeRewardInfo;
      
      public var tip:TInventories;
      
      public function RechargeRewardItem(param1:MovieClip)
      {
         super();
         this._ui = param1;
         this.initView();
      }
      
      private function initView() : void
      {
         this._tf_goldNum = this._ui[CONST_FIRSTRECHAGE_NEW.RESOURCE_RECHARGE_GOLD];
         this._tf_costNum = this._ui[CONST_FIRSTRECHAGE_NEW.RESOURCE_COST_NUM];
         this._mc_bagType = this._ui[CONST_FIRSTRECHAGE_NEW.RESOURCE_BAG_TYPE];
         this._btn_getReward = this._ui[CONST_FIRSTRECHAGE_NEW.RESOURCE_GET_REWARD];
         TGameUtil.setButtonMode(this._btn_getReward,false);
         this._btn_getReward.mouseEnabled = false;
         this._mc_bagType.addEventListener(MouseEvent.MOUSE_OVER,this.overHandler);
         this._mc_bagType.addEventListener(MouseEvent.MOUSE_OUT,this.outHandler);
         this._mc_bagType.addEventListener(MouseEvent.MOUSE_MOVE,this.moveHandler);
         this._btn_getReward.addEventListener(MouseEvent.CLICK,this.viewHandler);
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         this.dispatchEvent(new DatasEvent(FirstRechargeEventTypeName.SHOW_BAG_TIP,this.tip));
      }
      
      private function outHandler(param1:MouseEvent) : void
      {
         this.dispatchEvent(new DatasEvent(FirstRechargeEventTypeName.HIDE_BAG_TIP,this.tip));
      }
      
      private function moveHandler(param1:MouseEvent) : void
      {
         this.dispatchEvent(new DatasEvent(FirstRechargeEventTypeName.MOVE_BAG_TIP,this.tip));
      }
      
      private function viewHandler(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this._btn_getReward:
               this._btn_getReward.mouseEnabled = false;
               this.dispatchEvent(param1);
         }
      }
      
      public function initInfo(param1:RechargeRewardInfo) : void
      {
         this._info = param1;
         this._tf_goldNum.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_TOTAL_RECHARGE_GOLD,this._info.price);
         this._tf_costNum.text = this._info.rechargeValue + "";
         this._mc_bagType.gotoAndStop(this._info.rechargeType);
         if(this._info.getState == 1)
         {
            TGameUtil.setButtonMode(this._btn_getReward,true);
            this._btn_getReward.mouseEnabled = true;
            this._btn_getReward.tf_label.text = STRING_BASEACTIVITY.FORMAT_BTN_STRING_0;
            this._btn_getReward.visible = true;
            this._ui["MC_Complete"].visible = false;
         }
         else if(this._info.getState == -1)
         {
            TGameUtil.setButtonMode(this._btn_getReward,false);
            this._btn_getReward.mouseEnabled = false;
            this._btn_getReward.tf_label.text = STRING_BASEACTIVITY.FORMAT_BTN_STRING_1;
            this._btn_getReward.visible = false;
            this._ui["MC_Complete"].visible = true;
         }
         else
         {
            TGameUtil.setButtonMode(this._btn_getReward,false);
            this._btn_getReward.mouseEnabled = false;
            this._btn_getReward.tf_label.text = STRING_BASEACTIVITY.FORMAT_BTN_STRING_0;
            this._btn_getReward.visible = true;
            this._ui["MC_Complete"].visible = false;
         }
      }
      
      public function destroy() : void
      {
         this._mc_bagType.removeEventListener(MouseEvent.MOUSE_OVER,this.overHandler);
         this._mc_bagType.removeEventListener(MouseEvent.MOUSE_OUT,this.outHandler);
         this._mc_bagType.removeEventListener(MouseEvent.MOUSE_MOVE,this.moveHandler);
         this._btn_getReward.removeEventListener(MouseEvent.CLICK,this.viewHandler);
         this._ui = null;
         this._info = null;
      }
      
      public function get rewardBtn() : MovieClip
      {
         return this._btn_getReward;
      }
      
      override public function get height() : Number
      {
         return super.height;
      }
   }
}

