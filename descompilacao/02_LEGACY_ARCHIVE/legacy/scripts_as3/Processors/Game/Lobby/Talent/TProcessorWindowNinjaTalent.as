package Processors.Game.Lobby.Talent
{
   import Foundation.Utilities.TGameUtil;
   import Logics.Talent.TNinjaTalentData;
   import Logics.Talent.TNinjaTalentVO;
   import Processors.Game.Lobby.Talent.Component.TUINinjaTalentBox;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowNinjaTalent
   {
      
      protected static const BOX_COUNT:int = 6;
      
      protected var FSubstrate:MovieClip;
      
      protected var FBTN_Change:MovieClip;
      
      protected var FBTN_Refresh:MovieClip;
      
      protected var FBTN_Ignore:MovieClip;
      
      protected var FBTN_Unload:MovieClip;
      
      protected var NinjaTalentBoxs:Array;
      
      protected var MaskLayer:MovieClip;
      
      protected var FBTN_Activate:MovieClip;
      
      protected var FTargetNinjaTalentBox:TUINinjaTalentBox;
      
      protected var FCurrNinjaTalentBox:TUINinjaTalentBox;
      
      protected var FNinjaTalentData:TNinjaTalentData;
      
      public var ConfigValue:Vector.<Object>;
      
      public var OnOpenTalentPerview:Function;
      
      public var OnNinjaTalentRefreshReq:Function;
      
      public var OnNinjaTalentSetReq:Function;
      
      public var OnBoxLockOnOver:Function;
      
      public var OnBoxLockOnOut:Function;
      
      public var OnGetInventoryById:Function;
      
      public var OnEffectGenerateText:Function;
      
      public function TProcessorWindowNinjaTalent(param1:MovieClip)
      {
         super();
         this.FSubstrate = param1;
         this.UIDispatch();
         this.UILocations();
      }
      
      protected function UIDispatch() : void
      {
         var _loc1_:TUINinjaTalentBox = null;
         var _loc2_:int = 0;
         this.NinjaTalentBoxs = [];
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            _loc1_ = new TUINinjaTalentBox(this.FSubstrate["MC_Box_" + _loc2_],_loc2_);
            this.NinjaTalentBoxs.push(_loc1_);
            _loc1_.OnBoxSelectFun = this.OnSelectNinjaTalentBox;
            _loc1_.OnSetThisReqFun = this.OnSetNinjaTalent;
            _loc1_.OnBoxLockOver = this.OnBoxLockOverHandler;
            _loc1_.OnBoxLockOut = this.OnBoxLockOutHandler;
            _loc1_.OnEffectGenerateText = this.EffectGenerateText;
            _loc2_++;
         }
         this.FTargetNinjaTalentBox = new TUINinjaTalentBox(this.FSubstrate["MC_TargetBox"]);
         this.FTargetNinjaTalentBox.OnEffectGenerateText = this.EffectGenerateText;
         this.FBTN_Refresh = this.FSubstrate.BTN_Refresh;
         TGameUtil.setButtonMode(this.FBTN_Refresh,true);
         this.FBTN_Refresh.visible = false;
         this.FBTN_Change = this.FSubstrate.BTN_Change;
         TGameUtil.setButtonMode(this.FBTN_Change,true);
         this.FBTN_Change.visible = false;
         this.FBTN_Ignore = this.FSubstrate.BTN_Ignore;
         TGameUtil.setButtonMode(this.FBTN_Ignore,true);
         this.FBTN_Ignore.visible = false;
         this.FBTN_Unload = this.FSubstrate.BTN_unload;
         TGameUtil.setButtonMode(this.FBTN_Unload,true);
         this.MaskLayer = this.FSubstrate["maskLayer"];
         this.MaskLayer.visible = false;
         this.FBTN_Activate = this.FSubstrate.BTN_Activate;
         TGameUtil.setButtonMode(this.FBTN_Activate,true);
      }
      
      protected function UILocations() : void
      {
         this.FBTN_Change.addEventListener(MouseEvent.CLICK,this.onClickChange);
         this.FBTN_Refresh.addEventListener(MouseEvent.CLICK,this.onClickRefresh);
         this.FBTN_Ignore.addEventListener(MouseEvent.CLICK,this.onClickIgnore);
         this.FBTN_Unload.addEventListener(MouseEvent.CLICK,this.onClickUnload);
         this.FBTN_Activate.addEventListener(MouseEvent.CLICK,this.onClickActivate);
      }
      
      public function UpdateUI(param1:TNinjaTalentData) : void
      {
         var _loc2_:TUINinjaTalentBox = null;
         var _loc3_:TNinjaTalentVO = null;
         var _loc4_:int = 0;
         this.FNinjaTalentData = param1;
         _loc4_ = 0;
         while(_loc4_ < BOX_COUNT)
         {
            _loc2_ = this.NinjaTalentBoxs[_loc4_] as TUINinjaTalentBox;
            _loc3_ = param1.GetNinjaTalentVOByIndex(_loc4_);
            _loc2_.UpdateBox(_loc3_);
            if(_loc3_.RefreshStatus)
            {
               this.FCurrNinjaTalentBox = _loc2_;
               _loc2_.Selected = true;
            }
            _loc4_++;
         }
         this.FTargetNinjaTalentBox.UpdateHeroId(param1.CurHeroId);
         this.upBtnStatus(param1);
         this.FSubstrate["TF_ItemNum"].text = this.OnGetInventoryById(this.ConfigValue[0][1]);
      }
      
      protected function upBtnStatus(param1:TNinjaTalentData) : void
      {
         if(param1.RefreshStatus)
         {
            this.FBTN_Change.visible = true;
            this.FBTN_Ignore.visible = true;
            this.FBTN_Refresh.visible = false;
         }
         else
         {
            this.FBTN_Change.visible = false;
            this.FBTN_Ignore.visible = false;
            this.FBTN_Refresh.visible = true;
         }
      }
      
      protected function refreshCostnumText() : void
      {
         var _loc1_:int = 0;
         if(this.FCurrNinjaTalentBox)
         {
            _loc1_ = this.FCurrNinjaTalentBox.PosIdx;
            this.FSubstrate["TF_CostNum"].text = this.ConfigValue[_loc1_][2];
            return;
         }
         this.FSubstrate["TF_CostNum"].text = "0";
      }
      
      public function LogicsPerform() : void
      {
         var NinjaTalentBox:TUINinjaTalentBox = null;
         var index:int = 0;
         this.NinjaTalentBoxs && this.NinjaTalentBoxs.forEach(function(param1:TUINinjaTalentBox, param2:int, param3:Array):void
         {
            param1.LogicsPerform();
         });
         this.FTargetNinjaTalentBox.LogicsPerform();
      }
      
      protected function OnSelectNinjaTalentBox(param1:TUINinjaTalentBox) : void
      {
         if(this.FCurrNinjaTalentBox)
         {
            this.FCurrNinjaTalentBox.Selected = false;
         }
         if(this.FCurrNinjaTalentBox != param1)
         {
            this.FCurrNinjaTalentBox = param1;
            param1.Selected = true;
         }
         else
         {
            this.FCurrNinjaTalentBox = null;
         }
         this.refreshCostnumText();
      }
      
      protected function OnBoxLockOverHandler(param1:TUINinjaTalentBox) : void
      {
         if(this.OnBoxLockOnOver != null)
         {
            this.OnBoxLockOnOver(param1);
         }
      }
      
      protected function OnBoxLockOutHandler() : void
      {
         if(this.OnBoxLockOnOut != null)
         {
            this.OnBoxLockOnOut();
         }
      }
      
      protected function OnSetNinjaTalent(param1:TUINinjaTalentBox) : void
      {
         if(this.OnNinjaTalentSetReq != null)
         {
            this.OnNinjaTalentSetReq(param1.NinjaTalentVO.Identity,param1.PosIdx + 1);
         }
      }
      
      protected function onClickChange(param1:MouseEvent) : void
      {
         if(Boolean(this.FCurrNinjaTalentBox) && this.OnNinjaTalentRefreshReq != null)
         {
            this.OnNinjaTalentRefreshReq(this.FCurrNinjaTalentBox.NinjaTalentVO.RefreshId,this.FCurrNinjaTalentBox.PosIdx + 1,2);
         }
      }
      
      protected function onClickRefresh(param1:MouseEvent) : void
      {
         if(Boolean(this.FCurrNinjaTalentBox) && this.OnNinjaTalentRefreshReq != null)
         {
            this.OnNinjaTalentRefreshReq(this.FCurrNinjaTalentBox.NinjaTalentVO.RefreshId,this.FCurrNinjaTalentBox.PosIdx + 1,1);
         }
      }
      
      protected function onClickIgnore(param1:MouseEvent) : void
      {
         if(Boolean(this.FCurrNinjaTalentBox) && this.OnNinjaTalentRefreshReq != null)
         {
            this.OnNinjaTalentRefreshReq(this.FCurrNinjaTalentBox.NinjaTalentVO.RefreshId,this.FCurrNinjaTalentBox.PosIdx + 1,3);
         }
      }
      
      protected function onClickUnload(param1:MouseEvent) : void
      {
         if(this.FNinjaTalentData.RefreshStatus)
         {
            this.OnEffectGenerateText();
            return;
         }
         if(this.OnNinjaTalentSetReq != null)
         {
            this.OnNinjaTalentSetReq(0,0);
         }
      }
      
      protected function onClickActivate(param1:MouseEvent) : void
      {
         if(this.OnOpenTalentPerview != null)
         {
            this.OnOpenTalentPerview();
         }
      }
      
      protected function EffectGenerateText() : void
      {
         if(this.OnEffectGenerateText != null)
         {
            this.OnEffectGenerateText();
         }
      }
      
      public function set Visible(param1:Boolean) : void
      {
         this.FSubstrate.visible = param1;
      }
      
      public function get CurrNinjaTalentBox() : TUINinjaTalentBox
      {
         return this.FCurrNinjaTalentBox;
      }
   }
}

