package Processors.Game.Lobby.Exercise.ValentineDay.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.ValentineDay.TValentineDay2;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.ValentineDay.TProcessorValentineDay;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIValentineDay2 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 3;
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FGiftList:Vector.<MovieClip>;
      
      protected var FValentineDay2:TValentineDay2;
      
      public function TUIValentineDay2(param1:TUIComponent)
      {
         super(param1);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FGiftList = new Vector.<MovieClip>(BOX_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene["MC_Box" + _loc2_];
            this.FBoxList[_loc2_].MC_Mask.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnMaskOver);
            this.FBoxList[_loc2_].MC_Mask.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnMaskOut);
            this.FBoxList[_loc2_].MC_OpenBox.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc2_].MC_OpenBox.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            this.FBoxList[_loc2_].BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyBoxUp);
            this.FBoxList[_loc2_].BTN_Buy.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBuyBoxOver);
            this.FBoxList[_loc2_].BTN_Buy.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBuyBoxOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FGiftList[_loc2_] = FMC_Scene["MC_Gift" + _loc2_];
            this.FGiftList[_loc2_].MC_Tip.buttonMode = true;
            this.FGiftList[_loc2_].MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
            this.FGiftList[_loc2_].MC_Tip.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnGiftOut);
            this.FGiftList[_loc2_].MC_Tip.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
            _loc2_++;
         }
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FGiftList[_loc1_];
            if(_loc1_ < this.FValentineDay2.GiftList.length)
            {
               _loc4_ = this.FValentineDay2.GiftList[_loc1_];
               _loc3_.TF_Desc0.text = _loc4_.Desc1;
               _loc3_.TF_Desc1.text = _loc4_.Desc2;
               _loc3_.MC_Box.MC_Icon.gotoAndStop(_loc1_ + 1);
               if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc3_.MC_GetBox.visible = false;
                  _loc3_.MC_Got.visible = false;
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc3_.MC_Got.visible = true;
                  _loc3_.MC_GetBox.visible = false;
               }
               else
               {
                  _loc3_.MC_GetBox.visible = true;
                  _loc3_.MC_GetBox.gotoAndPlay(1);
                  _loc3_.MC_Got.visible = false;
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:TInventory = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(_loc1_ < this.FValentineDay2.BoxList.length)
            {
               _loc4_ = this.FValentineDay2.BoxList[_loc1_];
               _loc3_.TF_Count.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc4_.Count);
               _loc3_.TF_Buff.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_SAVE_PERCENT,_loc4_.Discount);
               if(_loc4_.Status != TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc3_.MC_Mask.visible = false;
                  if(_loc4_.BuyCount == 0)
                  {
                     _loc3_.BTN_Buy.visible = false;
                     _loc3_.MC_OpenBox.visible = true;
                     _loc3_.MC_OpenBox.gotoAndStop(_loc1_ + 1);
                     _loc3_.MC_Got.visible = true;
                  }
                  else
                  {
                     TGameUtil.setButtonMode(_loc3_.BTN_Buy,true);
                     _loc3_.BTN_Buy.visible = true;
                     _loc3_.MC_OpenBox.visible = true;
                     _loc3_.MC_OpenBox.gotoAndStop(_loc1_ + 1);
                     _loc3_.MC_Got.visible = false;
                  }
                  _loc5_ = _loc4_.Inventories.GetInventoryByIndex(0);
                  _loc3_.TF_Name.text = _loc5_.Name;
               }
               else
               {
                  _loc3_.MC_Mask.visible = true;
                  _loc3_.MC_OpenBox.visible = false;
                  _loc3_.MC_Got.visible = false;
                  TGameUtil.setButtonMode(_loc3_.BTN_Buy,false);
                  _loc5_ = _loc4_.Inventories.GetInventoryByIndex(0);
                  _loc3_.TF_Name.text = _loc5_.Name;
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FValentineDay2.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FValentineDay2.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FValentineDay2.ActivityDesc;
         FMC_Scene.TF_Talk.text = this.FValentineDay2.ActivityName;
         FMC_Scene.TF_Tips.text = this.FValentineDay2.ActivityDesc2;
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnGetBox != null && this.FValentineDay2) && Boolean(_loc2_ < this.FValentineDay2.GiftList.length) && this.FValentineDay2.GiftList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorValentineDay.ACTIVITY_2_GET_GIFT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         if(Boolean(FOnItemOver != null) && Boolean(this.FValentineDay2) && this.FValentineDay2.GiftList.length > 0)
         {
            _loc3_ = int(String(param1.currentTarget.parent.name).slice(7));
            _loc2_ = this.FValentineDay2.GiftList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOver(this,_loc2_);
         }
      }
      
      protected function ProcessorOnGiftOut(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         if(Boolean(FOnItemOut != null) && Boolean(this.FValentineDay2) && this.FValentineDay2.GiftList.length > 0)
         {
            _loc3_ = int(String(param1.currentTarget.parent.name).slice(7));
            _loc2_ = this.FValentineDay2.GiftList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOut(this,_loc2_);
         }
      }
      
      protected function ProcessorOnMaskOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(Boolean(FOnShowTip != null) && Boolean(this.FValentineDay2) && this.FValentineDay2.BoxList[0] != null)
         {
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
            _loc3_ = this.FValentineDay2.BoxList[_loc2_].Title;
            FOnShowTip(_loc3_);
         }
      }
      
      protected function ProcessorOnMaskOut(param1:MouseEvent) : void
      {
         if(Boolean(FOnHideTip != null) && Boolean(this.FValentineDay2) && this.FValentineDay2.BoxList[0] != null)
         {
            FOnHideTip();
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         if(Boolean(FOnItemOut != null) && Boolean(this.FValentineDay2) && this.FValentineDay2.BoxList[0] != null)
         {
            _loc3_ = int(String(param1.currentTarget.parent.name).slice(6));
            _loc2_ = this.FValentineDay2.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOver(this,_loc2_);
         }
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         if(Boolean(FOnItemOut != null) && Boolean(this.FValentineDay2) && this.FValentineDay2.BoxList[0] != null)
         {
            _loc3_ = int(String(param1.currentTarget.parent.name).slice(6));
            _loc2_ = this.FValentineDay2.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOut(this,_loc2_);
         }
      }
      
      protected function ProcessorOnBuyBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(!this.FValentineDay2 || this.FValentineDay2.BoxList[_loc2_].BuyCount == 0)
         {
            return;
         }
         if(FOnBuyBox != null)
         {
            FOnBuyBox(ACTIVITY_2_ID,TProcessorValentineDay.ACTIVITY_2_BUY_BOX,this.FValentineDay2.BoxList[_loc2_].Price,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnBuyBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!this.FValentineDay2 || this.FValentineDay2.BoxList.length <= 0)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(this.FValentineDay2.BoxList[_loc2_].BuyCount >= this.FValentineDay2.BoxList[_loc2_].Count)
         {
            return;
         }
         if(FOnShowTip != null)
         {
            if(this.FValentineDay2.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_ = STRING_BASEACTIVITY.FORMAT_NEED_RECHARGE;
            }
            else
            {
               _loc3_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BAR_TEXT2,this.FValentineDay2.BoxList[_loc2_].Price);
            }
            FOnShowTip(_loc3_);
         }
      }
      
      protected function ProcessorOnBuyBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(this.FValentineDay2.BoxList[_loc2_] == null)
         {
            return;
         }
         if(this.FValentineDay2.BoxList[_loc2_].BuyCount >= this.FValentineDay2.BoxList[_loc2_].Count)
         {
            return;
         }
         if(FOnHideTip != null)
         {
            FOnHideTip();
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         if(FInitialized && this.visible)
         {
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FValentineDay2 = SLogicsCore.ValentineDayDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TValentineDay2;
         this.UpdateBox();
         this.UpdateGift();
         this.UpdateText();
      }
   }
}

