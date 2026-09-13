package Processors.Game.Lobby.Exercise.FirstRechange_new.component
{
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TInventories;
   import Processors.Game.Lobby.Exercise.FirstRechange_new.eve.DatasEvent;
   import Processors.Game.Lobby.Exercise.FirstRechange_new.eve.FirstRechargeEventTypeName;
   import Resources.Constants.CONST_FIRSTRECHAGE_NEW;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class ActivityRewardItem extends Sprite
   {
      
      private var _ui:MovieClip;
      
      private var _tf_peopleNum:TextField;
      
      private var _mc_bagType:MovieClip;
      
      private var _btn_getReward:MovieClip;
      
      private var _info:ActivityRewardInfo;
      
      private var _callBack:Function;
      
      public var tip:TInventories;
      
      public function ActivityRewardItem(param1:Function)
      {
         super();
         this._callBack = param1;
         this.initView();
      }
      
      private function initView() : void
      {
         this._ui = TUtilityReflection.CreateDisplayObjectInstance(CONST_FIRSTRECHAGE_NEW.RESOURCE_ACTIVITY_REWARD_ITEM) as MovieClip;
         this.addChild(this._ui);
         this._tf_peopleNum = this._ui[CONST_FIRSTRECHAGE_NEW.RESOURCE_PEOPLENUM];
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
               this._callBack(this,FirstRechargeEventTypeName.CLICK_ACTIVITY_REWARD_BTN);
         }
      }
      
      public function initInfo(param1:ActivityRewardInfo) : void
      {
         this._info = param1;
         this._tf_peopleNum.text = this._info.peopleNum + "";
         this._mc_bagType.gotoAndStop(this._info.rewardType);
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
         this._callBack = null;
         this._info = null;
         this._ui = null;
      }
      
      public function get rewardBtn() : MovieClip
      {
         return this._btn_getReward;
      }
   }
}

