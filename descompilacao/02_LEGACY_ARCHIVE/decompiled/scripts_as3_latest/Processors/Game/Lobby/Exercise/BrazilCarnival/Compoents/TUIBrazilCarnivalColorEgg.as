package Processors.Game.Lobby.Exercise.BrazilCarnival.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.BrazilCarnival.TBrazilCarnivalColorEgg;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BrazilCarnival.TProcessorBrazilCarnival;
   import Processors.Game.Lobby.Exercise.Christmas.Compoents.TUIChristmasBase;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIBrazilCarnivalColorEgg extends TUIChristmasBase
   {
      
      protected static const BOX_COUNT:int = 3;
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FBrazilCarnivalColorEgg:TBrazilCarnivalColorEgg;
      
      public function TUIBrazilCarnivalColorEgg(param1:TUIComponent)
      {
         super(param1);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
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
            TGameUtil.setButtonMode(this.FBoxList[_loc2_].BTN_Buy,true);
            this.FBoxList[_loc2_].MC_Mask.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnMaskOver);
            this.FBoxList[_loc2_].MC_Mask.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnMaskOut);
            this.FBoxList[_loc2_].MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc2_].MC_Box.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            this.FBoxList[_loc2_].MC_OpenBox.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc2_].MC_OpenBox.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            this.FBoxList[_loc2_].BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyBoxUp);
            this.FBoxList[_loc2_].BTN_Buy.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBuyBoxOver);
            this.FBoxList[_loc2_].BTN_Buy.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBuyBoxOut);
            _loc2_++;
         }
         FMC_Scene.MC_Gift.buttonMode = true;
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnGiftOut);
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TInventory = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            _loc3_.MC_Box.gotoAndStop(_loc1_ + 1);
            _loc3_.TF_Count.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,this.FBrazilCarnivalColorEgg.BoxList[_loc1_].Count);
            _loc3_.TF_Buff.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_SAVE_PERCENT,this.FBrazilCarnivalColorEgg.BoxList[_loc1_].Discount);
            if(this.FBrazilCarnivalColorEgg.Status != TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_.MC_Mask.visible = false;
               if(this.FBrazilCarnivalColorEgg.BoxList[_loc1_].BuyCount >= this.FBrazilCarnivalColorEgg.BoxList[_loc1_].Count)
               {
                  _loc3_.BTN_Buy.visible = false;
                  _loc3_.MC_OpenBox.visible = true;
                  _loc3_.MC_OpenBox.gotoAndStop(_loc1_ + 1);
                  _loc3_.MC_Box.visible = false;
                  _loc3_.MC_Got.visible = true;
               }
               else
               {
                  TGameUtil.setButtonMode(_loc3_.BTN_Buy,true);
                  _loc3_.BTN_Buy.visible = true;
                  _loc3_.MC_OpenBox.visible = false;
                  _loc3_.MC_Box.visible = true;
                  _loc3_.MC_Got.visible = false;
               }
               _loc4_ = this.FBrazilCarnivalColorEgg.BoxList[_loc1_].Inventories.GetInventoryByIndex(0);
               _loc3_.TF_Name.text = _loc4_.Name;
            }
            else
            {
               _loc3_.MC_Mask.visible = true;
               _loc3_.MC_OpenBox.visible = false;
               _loc3_.MC_Box.visible = false;
               _loc3_.MC_Got.visible = false;
               TGameUtil.setButtonMode(_loc3_.BTN_Buy,false);
               _loc3_.TF_Name.text = STRING_BASEACTIVITY.FORMAT_COLOR_EGG_NAME;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateGift() : void
      {
         if(this.FBrazilCarnivalColorEgg.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.MC_Gift.gotoAndStop(1);
            if(FMC_Scene.MC_Gift.MC_GetBox)
            {
               FMC_Scene.MC_Gift.MC_GetBox.visible = false;
               FMC_Scene.MC_Gift.MC_Box.stop();
            }
         }
         else if(this.FBrazilCarnivalColorEgg.Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_Gift.gotoAndStop(1);
            if(FMC_Scene.MC_Gift.MC_GetBox)
            {
               FMC_Scene.MC_Gift.MC_GetBox.visible = true;
               FMC_Scene.MC_Gift.MC_GetBox.gotoAndPlay(1);
               FMC_Scene.MC_Gift.MC_Box.gotoAndPlay(1);
            }
         }
         else
         {
            FMC_Scene.MC_Gift.gotoAndStop(2);
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FBrazilCarnivalColorEgg.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FBrazilCarnivalColorEgg.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FBrazilCarnivalColorEgg.ActivityDesc;
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBrazilCarnivalColorEgg.Status != TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         if(FOnGetBox != null)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorBrazilCarnival.BrazilCarnival_COLOREGG_GIFT);
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
         if(this.FBrazilCarnivalColorEgg.BoxList[_loc2_].BuyCount >= this.FBrazilCarnivalColorEgg.BoxList[_loc2_].Count)
         {
            return;
         }
         if(FOnBuyBox != null)
         {
            FOnBuyBox(ACTIVITY_2_ID,TProcessorBrazilCarnival.BrazilCarnival_COLOREGG_BUY_BOX,this.FBrazilCarnivalColorEgg.BoxList[_loc2_].Price,_loc2_ + 1);
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
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(this.FBrazilCarnivalColorEgg.BoxList[_loc2_] == null)
         {
            return;
         }
         if(this.FBrazilCarnivalColorEgg.BoxList[_loc2_].BuyCount >= this.FBrazilCarnivalColorEgg.BoxList[_loc2_].Count)
         {
            return;
         }
         if(FOnShowTip != null)
         {
            if(this.FBrazilCarnivalColorEgg.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_ = STRING_BASEACTIVITY.FORMAT_NEED_RECHARGE;
            }
            else
            {
               _loc3_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BAR_TEXT2,this.FBrazilCarnivalColorEgg.BoxList[_loc2_].Price);
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
         if(this.FBrazilCarnivalColorEgg.BoxList[_loc2_] == null)
         {
            return;
         }
         if(this.FBrazilCarnivalColorEgg.BoxList[_loc2_].BuyCount >= this.FBrazilCarnivalColorEgg.BoxList[_loc2_].Count)
         {
            return;
         }
         if(FOnHideTip != null)
         {
            FOnHideTip();
         }
      }
      
      protected function ProcessorOnMaskOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(FOnShowTip != null && this.FBrazilCarnivalColorEgg.BoxList[0] != null)
         {
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
            _loc3_ = this.FBrazilCarnivalColorEgg.BoxList[_loc2_].Title;
            FOnShowTip(_loc3_);
         }
      }
      
      protected function ProcessorOnMaskOut(param1:MouseEvent) : void
      {
         if(FOnHideTip != null && this.FBrazilCarnivalColorEgg.BoxList[0] != null)
         {
            FOnHideTip();
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         if(FOnItemOver != null && this.FBrazilCarnivalColorEgg.Inventories.Count > 0)
         {
            _loc2_ = this.FBrazilCarnivalColorEgg.Inventories.GetInventoryByIndex(0);
            FOnItemOver(this,_loc2_);
         }
      }
      
      protected function ProcessorOnGiftOut(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         if(FOnItemOut != null && this.FBrazilCarnivalColorEgg.Inventories.Count > 0)
         {
            _loc2_ = this.FBrazilCarnivalColorEgg.Inventories.GetInventoryByIndex(0);
            FOnItemOut(this,_loc2_);
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         if(FOnItemOut != null && this.FBrazilCarnivalColorEgg.BoxList[0] != null)
         {
            _loc3_ = int(String(param1.currentTarget.parent.name).slice(6));
            _loc2_ = this.FBrazilCarnivalColorEgg.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOver(this,_loc2_);
         }
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         if(FOnItemOut != null)
         {
            _loc3_ = int(String(param1.currentTarget.parent.name).slice(6));
            _loc2_ = this.FBrazilCarnivalColorEgg.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOut(this,_loc2_);
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
            if(Boolean(FMC_Scene) && Boolean(this.FBrazilCarnivalColorEgg))
            {
               FMC_Scene.TF_Time.text = TGameUtil.fomatTime(this.FBrazilCarnivalColorEgg.EndTime - STimingCore.GetServerTick());
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FBrazilCarnivalColorEgg = SLogicsCore.BrazilCarnivalDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TBrazilCarnivalColorEgg;
         this.UpdateBox();
         this.UpdateGift();
         this.UpdateText();
      }
   }
}

