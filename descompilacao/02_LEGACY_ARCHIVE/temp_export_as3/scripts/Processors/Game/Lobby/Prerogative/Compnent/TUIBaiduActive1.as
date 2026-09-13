package Processors.Game.Lobby.Prerogative.Compnent
{
   import Foundation.UI.TUIComponent;
   import Logics.Prerogative.TPrerogativeOne;
   import Logics.Prerogative.TPrerogativeOnes;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import flash.display.MovieClip;
   
   public class TUIBaiduActive1 extends TUIBaseWindow
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const SIGN_COUNT:int = 20;
      
      public static const REWARD_COUNT:int = 2;
      
      protected var FMC_VIPWelfares:Vector.<TUIVIPWelfare>;
      
      public function TUIBaiduActive1(param1:TUIComponent)
      {
         super(param1);
         this.FMC_VIPWelfares = new Vector.<TUIVIPWelfare>(REWARD_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIBaseBox = null;
         var _loc5_:TUIVIPWelfare = null;
         super.Resources_UIDispatch(param1);
         _loc3_ = 2;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = new TUIVIPWelfare(this);
            _loc5_.Resource = FMC_Scene["MC_VIPWelfare_" + _loc2_];
            _loc5_.Tag = _loc2_;
            _loc5_.GetWelfareOnClick = this.ProcessorGetWelfareOnClick;
            _loc5_.RechargeOnClick = this.ProcessorRechargeOnClick;
            _loc5_.OnInventoryOver = this.ProcessorOnInventoryOver;
            _loc5_.OnInventoryOut = this.ProcessorOnInventoryOut;
            _loc5_.Init();
            this.FMC_VIPWelfares[_loc2_] = _loc5_;
            _loc2_++;
         }
      }
      
      protected function ProcessorOnInventoryOver(param1:Object) : void
      {
         if(FOnInventoryOver != null)
         {
            FOnInventoryOver(param1);
         }
      }
      
      protected function ProcessorOnInventoryOut(param1:Object) : void
      {
         if(FOnInventoryOut != null)
         {
            FOnInventoryOut(param1);
         }
      }
      
      protected function ProcessorGetWelfareOnClick(param1:Object, param2:Object) : void
      {
         if(FOnGetWelfare != null)
         {
            FOnGetWelfare(this,param2);
         }
      }
      
      protected function ProcessorRechargeOnClick(param1:Object) : void
      {
         if(OnRecharge != null)
         {
            OnRecharge(param1);
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateSlotUI();
      }
      
      protected function UpdateSlotUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TPrerogativeOnes = null;
         var _loc4_:TPrerogativeOne = null;
         var _loc5_:TUIVIPWelfare = null;
         _loc3_ = SLogicsCore.PlatformPrerogative.PrerogativeOnes.GetPrerogativesByType(1);
         _loc2_ = _loc3_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = this.FMC_VIPWelfares[_loc1_];
            _loc4_ = _loc3_.GetPrerogativeOneByIndex(_loc1_);
            _loc5_.Context = _loc4_;
            _loc5_.Update();
            _loc1_++;
         }
      }
      
      override public function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIVIPWelfare = null;
         if(!Visible)
         {
            return;
         }
         _loc2_ = this.FMC_VIPWelfares.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_VIPWelfares[_loc1_];
            if(_loc3_ != null)
            {
               _loc3_.UpdateSlot();
            }
            _loc1_++;
         }
      }
   }
}

