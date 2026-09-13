package Processors.Game.Lobby.Exercise.MayActive.Compoents
{
   import Externals.SExternalCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.MayActive.TMayActive1;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TUIMayActive1 extends TUIBaseWindow
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const SIGN_COUNT:int = 20;
      
      public static const REWARD_COUNT:int = 3;
      
      protected var FMayActive1:TMayActive1;
      
      protected var FSIGNList:Vector.<TUIBaseBox>;
      
      protected var FRewardList:Vector.<TUIBaseBox>;
      
      public function TUIMayActive1(param1:TUIComponent)
      {
         super(param1);
         this.FSIGNList = new Vector.<TUIBaseBox>(SIGN_COUNT);
         this.FRewardList = new Vector.<TUIBaseBox>(REWARD_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIBaseBox = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < SIGN_COUNT)
         {
            _loc4_ = new TUIBaseBox(this,1);
            _loc4_.Perform_UIDispatch(FMC_Scene.MC_Alldays["day_" + _loc2_]);
            _loc4_.RewardIndex = _loc2_;
            _loc4_.OnOverlay = this.SlotsOnOver;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.OnClick = this.SlotsOnClick;
            _loc4_.SetMCIsVisible("MC_CanGet",false);
            _loc4_.SetMCIsVisible("MC_Fire",false);
            _loc4_.SetMCIsMouseEnabled("MC_Fire",false);
            _loc4_.SetMCIsVisible("MC_Effect",false);
            _loc4_.SetMCIsMouseEnabled("MC_Effect",false);
            _loc4_.SetMCIsVisible("MC_Got",false);
            _loc4_.SetMCIsMouseEnabled("MC_Got",false);
            _loc4_.SetMCIsVisible("TF_Limit",false);
            this.FSIGNList[_loc2_] = _loc4_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < REWARD_COUNT)
         {
            _loc4_ = new TUIBaseBox(this,1);
            _loc4_.Perform_UIDispatch(FMC_Scene["reward_" + _loc2_]);
            _loc4_.OnOverlay = this.SlotsOnOver;
            _loc4_.OnOut = this.SlotsOnOut;
            this.FRewardList[_loc2_] = _loc4_;
            _loc2_++;
         }
         FMC_Scene.MC_MayActiveDesc1.visible = false;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Compensate,true);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Compensate.addEventListener(MouseEvent.CLICK,this.ProcessorOnSignUp);
         FMC_Scene.BTN_Pay.addEventListener(MouseEvent.CLICK,this.ProcessorOnPay);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnDescUp);
         FMC_Scene.MC_MayActiveDesc1.Btn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnDescHitUp);
      }
      
      private function ProcessorOnDescHitUp(param1:MouseEvent) : void
      {
         FMC_Scene.MC_MayActiveDesc1.visible = false;
      }
      
      private function ProcessorOnDescUp(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function ProcessorOnPay(param1:MouseEvent) : void
      {
         SExternalCore.NavigateToRecharge();
      }
      
      protected function UpdateSign() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         var _loc4_:TUIBaseBox = null;
         var _loc5_:TInventory = null;
         _loc1_ = 0;
         while(_loc1_ < SIGN_COUNT)
         {
            _loc4_ = this.FSIGNList[_loc1_];
            _loc4_.SetVisible(true);
            _loc3_ = this.FMayActive1.BoxList[_loc1_];
            _loc4_.UpdateUI(_loc3_.Inventories);
            if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc4_.SetMCIsVisible("MC_Effect",false);
               _loc4_.SetMCIsVisible("MC_Got",true);
            }
            else
            {
               if(_loc3_.Identify != this.FMayActive1.CurIndex)
               {
                  _loc4_.SetMCIsVisible("MC_Effect",false);
                  _loc4_.SetMCIsVisible("MC_Fire",false);
               }
               _loc4_.SetMCIsVisible("MC_Got",false);
            }
            if(_loc3_.Level > 0)
            {
               _loc4_.SetBuff(true,TUtilityString.Format(this.FMayActive1.DescListNew[9],_loc3_.Level));
            }
            else
            {
               _loc4_.SetBuff(false);
            }
            if(_loc1_ < this.FMayActive1.CurIndex)
            {
               if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc4_.SetGaryFilters(true);
               }
               else
               {
                  _loc4_.SetGaryFilters(false);
               }
            }
            else
            {
               _loc4_.SetGaryFilters(false);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < REWARD_COUNT)
         {
            _loc4_ = this.FRewardList[_loc1_];
            _loc4_.SetVisible(true);
            _loc3_ = this.FMayActive1.RewardBoxList[_loc1_];
            _loc4_.UpdateUI(_loc3_.Inventories);
            _loc1_++;
         }
      }
      
      protected function UpdateBtn() : void
      {
         var _loc1_:TBaseBox = null;
         var _loc2_:TUIBaseBox = null;
         _loc2_ = this.FSIGNList[this.FMayActive1.CurIndex];
         _loc2_.SetMCIsVisible("MC_Fire",true);
         _loc1_ = this.FMayActive1.BoxList[this.FMayActive1.CurIndex];
         if(_loc1_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            this.FSIGNList[this.FMayActive1.CurIndex].SetMCIsVisible("MC_Effect",true);
         }
         else
         {
            this.FSIGNList[this.FMayActive1.CurIndex].SetMCIsVisible("MC_Effect",false);
         }
         if(this.FMayActive1.CanReturn == TBaseActivity.STATUS_CANNOTGET)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Pay,true);
            FMC_Scene.MC_Tree.gotoAndStop(1);
            this.SetMCIsMouseEnabled("BTN_Pay",true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Pay,false);
            FMC_Scene.MC_Tree.addEventListener(Event.ENTER_FRAME,this.ProcessorOnTreePlay);
            FMC_Scene.MC_Tree.play();
            this.SetMCIsMouseEnabled("BTN_Pay",false);
         }
      }
      
      private function ProcessorOnTreePlay(param1:Event) : void
      {
         if(FMC_Scene.MC_Tree.currentFrame == FMC_Scene.MC_Tree.totalFrames)
         {
            FMC_Scene.MC_Tree.gotoAndStop(FMC_Scene.MC_Tree.currentFrame);
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TInventories = null;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FMayActive1.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FMayActive1.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FMayActive1.DescListNew[0];
         FMC_Scene.TF_Desc1.text = TUtilityString.Format(this.FMayActive1.DescListNew[1],this.FMayActive1.GetSignedNum());
         FMC_Scene.TF_Desc2.text = TUtilityString.Format(this.FMayActive1.DescListNew[2],this.FMayActive1.NeedMoney,this.FMayActive1.GetMoney,this.FMayActive1.ContinueDays,this.FMayActive1.SendMailHour);
         FMC_Scene.TF_Desc3.text = TUtilityString.Format(this.FMayActive1.DescListNew[3]);
         FMC_Scene.TF_Desc4.text = TUtilityString.Format(this.FMayActive1.DescListNew[4],this.FMayActive1.GetMoney);
         FMC_Scene.MC_MayActiveDesc1.TF_Desc.text = this.FMayActive1.DescListNew[10];
      }
      
      protected function ProcessorOnSignUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         var _loc3_:TUIBaseBox = null;
         var _loc4_:String = null;
         var _loc5_:TInventory = null;
         _loc2_ = this.FMayActive1.GetResidueBaseBox();
         if(_loc2_ == null)
         {
            if(FOnBuyBox != null)
            {
               FOnShowFlowText(this.FMayActive1.DescListNew[8]);
            }
         }
         else if(FOnBuyBox != null)
         {
            _loc5_ = _loc2_.Inventories.GetInventoryByIndex(0);
            _loc4_ = TUtilityString.Format(this.FMayActive1.DescListNew[7],_loc2_.ReturnMoney,_loc5_.Name,this.FMayActive1.GetResidue());
            FOnBuyBox(ACTIVITY_1_ID,TBaseActivity.STATUS_CANGET,_loc2_.ReturnMoney,0,0,_loc4_);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(this,param2);
         }
      }
      
      protected function SlotsOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TBaseBox = null;
         var _loc5_:TUIBaseBox = null;
         _loc5_ = param1 as TUIBaseBox;
         _loc4_ = this.FMayActive1.BoxList[this.FMayActive1.CurIndex];
         _loc3_ = _loc5_.RewardIndex;
         if(FOnGetBox != null && _loc4_.Status == TBaseActivity.STATUS_CANNOTGET && _loc3_ == this.FMayActive1.CurIndex)
         {
            FOnGetBox(ACTIVITY_1_ID,TBaseActivity.STATUS_CANNOTGET);
         }
      }
      
      protected function ProcessorOnLasdBoxOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FMayActive1) && this.FMayActive1.DescList.length >= 4)
         {
            FOnShowHtmlTip(this.FMayActive1.DescListNew[3]);
         }
      }
      
      protected function ProcessorOnLasdBoxOut(param1:MouseEvent) : void
      {
         if(FOnHideHtmlTip != null)
         {
            FOnHideHtmlTip();
         }
      }
      
      protected function ProcessorOnLogUp(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_1_ID);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         if(FInitialized && this.visible)
         {
            if(this.FMayActive1)
            {
               _loc1_ = 0;
               while(_loc1_ < SIGN_COUNT)
               {
                  this.FSIGNList[_loc1_].LogicsPerform();
                  _loc1_++;
               }
               _loc1_ = 0;
               while(_loc1_ < REWARD_COUNT)
               {
                  this.FRewardList[_loc1_].LogicsPerform();
                  _loc1_++;
               }
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FMayActive1 = SLogicsCore.MayActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TMayActive1;
         this.UpdateWindow();
      }
      
      public function UpdateWindow() : void
      {
         this.UpdateSign();
         this.UpdateBtn();
         this.UpdateText();
      }
      
      public function SetMCIsMouseEnabled(param1:String, param2:Boolean) : void
      {
         switch(param1)
         {
            case "BTN_Pay":
               if(FMC_Scene.BTN_Pay)
               {
                  FMC_Scene.BTN_Pay.mouseEnabled = param2;
               }
         }
      }
   }
}

