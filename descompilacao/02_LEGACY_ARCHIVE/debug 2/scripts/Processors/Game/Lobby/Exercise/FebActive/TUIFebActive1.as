package Processors.Game.Lobby.Exercise.FebActive
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.FebActive.TFebActive1;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIFebActive1 extends TUIBaseWindow
   {
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected static const DAILY_BOX_COUNT:int = 2;
      
      protected static const LOGIN_BOX_COUNT:int = 3;
      
      protected static const SPECIAL_BOX_COUNT:int = 3;
      
      protected var FFebActive1:TFebActive1;
      
      protected var FIsFirst:Boolean;
      
      protected var FMovieType:int;
      
      public function TUIFebActive1(param1:TUIComponent)
      {
         super(param1);
         this.FIsFirst = true;
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         FMC_Scene.MC_DailyGift.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnDailyGiftOver);
         FMC_Scene.MC_DailyGift.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         _loc2_ = 0;
         while(_loc2_ < DAILY_BOX_COUNT)
         {
            _loc5_ = FMC_Scene["MC_Box" + _loc2_];
            _loc5_.MC_BoxPic.buttonMode = true;
            _loc5_.MC_BoxPic.MC_Icon.gotoAndStop(_loc2_ + 1);
            _loc5_.MC_BoxPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnDailyBoxUp);
            _loc5_.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnDailyBoxOver);
            _loc5_.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < LOGIN_BOX_COUNT)
         {
            _loc5_ = FMC_Scene["MC_Fish" + _loc2_];
            _loc5_.MC_BoxPic.buttonMode = true;
            _loc5_.MC_BoxPic.MC_Icon.gotoAndStop(_loc2_ + 1);
            _loc5_.MC_BoxPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoginBoxUp);
            _loc5_.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnLoginBoxOver);
            _loc5_.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < SPECIAL_BOX_COUNT)
         {
            _loc5_ = FMC_Scene["MC_Gift" + _loc2_];
            _loc5_.MC_BoxPic.buttonMode = true;
            _loc5_.MC_BoxPic.gotoAndStop(_loc2_ + 1);
            _loc5_.MC_BoxPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnSpecialGiftUp);
            _loc5_.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSpecialGiftOver);
            _loc5_.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < SPECIAL_BOX_COUNT)
         {
            _loc5_ = FMC_Scene["MC_Item" + _loc2_];
            _loc5_.MC_BoxPic.gotoAndStop(_loc2_ + 1);
            TGameUtil.setButtonMode(_loc5_.BTN_Buy,true);
            _loc5_.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnSpecialItemUp);
            _loc5_.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSpecialItemOver);
            _loc5_.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnDailyGiftUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Back,true);
         FMC_Scene.BTN_Back.addEventListener(MouseEvent.CLICK,this.ProcessorOnBackUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
      }
      
      protected function UpdateDailyGift() : void
      {
         var _loc1_:TBaseBox = null;
         _loc1_ = this.FFebActive1.DailyGift;
         if(_loc1_.Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_DailyGift.MC_Got.visible = false;
            FMC_Scene.MC_DailyGift.gotoAndPlay(1);
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
            FMC_Scene.BTN_Get.visible = true;
         }
         else
         {
            FMC_Scene.MC_DailyGift.MC_Got.visible = true;
            FMC_Scene.MC_DailyGift.gotoAndStop(1);
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,false);
            FMC_Scene.BTN_Get.visible = false;
         }
      }
      
      protected function UpdateDailyBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < DAILY_BOX_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Box" + _loc1_];
            _loc2_ = this.FFebActive1.DailyBox[_loc1_];
            _loc3_.TF_Desc.text = TUtilityString.Format(_loc2_.Desc1,_loc2_.Count);
            if(_loc2_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.MC_Click.visible = true;
               _loc3_.MC_Got.visible = false;
               _loc3_.MC_BoxPic.gotoAndPlay(1);
            }
            else if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_.MC_Click.visible = false;
               _loc3_.MC_Got.visible = false;
               _loc3_.MC_BoxPic.gotoAndStop(1);
            }
            else if(_loc2_.Status == TBaseActivity.STATUS_GETED)
            {
               _loc3_.MC_Click.visible = false;
               _loc3_.MC_Got.visible = true;
               _loc3_.MC_BoxPic.gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateLoginGift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:MovieClip = null;
         FMC_Scene.TF_Days.text = TUtilityString.Format(this.FFebActive1.DescListNew[3],this.FFebActive1.LoginDay);
         _loc1_ = 0;
         while(_loc1_ < LOGIN_BOX_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Fish" + _loc1_];
            _loc2_ = this.FFebActive1.LoginGift[_loc1_];
            _loc3_.TF_Desc.text = TUtilityString.Format(_loc2_.Desc1,this.FFebActive1.LoginDay);
            if(_loc2_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.MC_Click.visible = true;
               _loc3_.MC_Got.visible = false;
               _loc3_.MC_None.visible = false;
               _loc3_.MC_BoxPic.gotoAndPlay(1);
               _loc3_.MC_BoxPic.MC_Icon.gotoAndStop(_loc1_ + 1);
            }
            else if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_.MC_Click.visible = false;
               _loc3_.MC_Got.visible = false;
               _loc3_.MC_None.visible = true;
               _loc3_.MC_BoxPic.gotoAndStop(1);
               _loc3_.MC_BoxPic.MC_Icon.gotoAndStop(_loc1_ + LOGIN_BOX_COUNT + 1);
            }
            else if(_loc2_.Status == TBaseActivity.STATUS_GETED)
            {
               _loc3_.MC_Click.visible = false;
               _loc3_.MC_Got.visible = true;
               _loc3_.MC_None.visible = false;
               _loc3_.MC_BoxPic.gotoAndStop(1);
               _loc3_.MC_BoxPic.MC_Icon.gotoAndStop(_loc1_ + LOGIN_BOX_COUNT + 1);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateSpecialGift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < SPECIAL_BOX_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Gift" + _loc1_];
            _loc2_ = this.FFebActive1.SpecialGift[_loc1_];
            _loc3_.TF_Desc.text = _loc2_.Desc1;
            if(_loc2_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.MC_Click.visible = true;
               _loc3_.MC_Got.visible = false;
               _loc3_.MC_None.visible = false;
            }
            else if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_.MC_Click.visible = false;
               _loc3_.MC_Got.visible = false;
               _loc3_.MC_None.visible = false;
            }
            else if(_loc2_.Status == TBaseActivity.STATUS_GETED)
            {
               _loc3_.MC_Click.visible = false;
               _loc3_.MC_Got.visible = true;
               _loc3_.MC_None.visible = false;
            }
            else if(_loc2_.Status == TBaseActivity.STATUS_IS_GOT)
            {
               _loc3_.MC_Click.visible = false;
               _loc3_.MC_Got.visible = false;
               _loc3_.MC_None.visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateSpecialItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < SPECIAL_BOX_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Item" + _loc1_];
            _loc2_ = this.FFebActive1.SpecialItem[_loc1_];
            _loc3_.TF_Desc.text = _loc2_.Desc1;
            _loc3_.TF_Price.text = TUtilityString.Format(this.FFebActive1.DescListNew[4],_loc2_.Price);
            if(_loc2_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.BTN_Buy.visible = true;
               TGameUtil.setButtonMode(_loc3_.BTN_Buy,true);
               _loc3_.MC_Got.visible = false;
               _loc3_.MC_None.visible = false;
            }
            else if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_.BTN_Buy.visible = true;
               TGameUtil.setButtonMode(_loc3_.BTN_Buy,false);
               _loc3_.MC_Got.visible = false;
               _loc3_.MC_None.visible = false;
            }
            else if(_loc2_.Status == TBaseActivity.STATUS_GETED)
            {
               _loc3_.BTN_Buy.visible = false;
               TGameUtil.setButtonMode(_loc3_.BTN_Buy,false);
               _loc3_.MC_Got.visible = true;
               _loc3_.MC_None.visible = false;
            }
            else if(_loc2_.Status == TBaseActivity.STATUS_IS_GOT)
            {
               _loc3_.BTN_Buy.visible = false;
               TGameUtil.setButtonMode(_loc3_.BTN_Buy,false);
               _loc3_.MC_Got.visible = false;
               _loc3_.MC_None.visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Desc.text = this.FFebActive1.DescListNew[1];
      }
      
      protected function ProcessorOnDailyGiftUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && !FIsPlaying && Boolean(this.FFebActive1))
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorFebActive.ACTIVITY_1_GET_DAILY_GIFT);
         }
      }
      
      protected function ProcessorOnDailyBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(FOnGetBox != null && !FIsPlaying && this.FFebActive1) && Boolean(_loc2_ < this.FFebActive1.DailyBox.length) && this.FFebActive1.DailyBox[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorFebActive.ACTIVITY_1_GET_DAILY_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnLoginBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnGetBox != null && !FIsPlaying && this.FFebActive1) && Boolean(_loc2_ < this.FFebActive1.LoginGift.length) && this.FFebActive1.LoginGift[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorFebActive.ACTIVITY_1_GET_LOGIN_GIFT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnSpecialGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnGetBox != null && !FIsPlaying && this.FFebActive1) && Boolean(_loc2_ < this.FFebActive1.SpecialGift.length) && this.FFebActive1.SpecialGift[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorFebActive.ACTIVITY_1_GET_SPECIAL_GIFT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnSpecialItemUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnBuyBox != null && !FIsPlaying && this.FFebActive1) && Boolean(_loc2_ < this.FFebActive1.SpecialItem.length) && this.FFebActive1.SpecialItem[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnBuyBox(ACTIVITY_1_ID,TProcessorFebActive.ACTIVITY_1_BUY_SPECIAL_ITEM,this.FFebActive1.SpecialItem[_loc2_].Price,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnBackUp(param1:MouseEvent) : void
      {
         if(FOnShowWindow != null)
         {
            FOnShowWindow(TProcessorFebActive.WINDOW_HOME);
         }
      }
      
      protected function ProcessorOnDailyGiftOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FFebActive1))
         {
            FOnShowHtmlTip(this.FFebActive1.DescListNew[2]);
         }
      }
      
      protected function ProcessorOnDailyBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FFebActive1) && _loc2_ < this.FFebActive1.DailyBox.length)
         {
            FOnNewBoxOver(this.FFebActive1.DailyBox[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnLoginBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FFebActive1) && _loc2_ < this.FFebActive1.LoginGift.length)
         {
            FOnNewBoxOver(this.FFebActive1.LoginGift[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnSpecialGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FFebActive1) && _loc2_ < this.FFebActive1.SpecialGift.length)
         {
            FOnNewBoxOver(this.FFebActive1.SpecialGift[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnSpecialItemOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FFebActive1) && _loc2_ < this.FFebActive1.SpecialItem.length)
         {
            FOnNewBoxOver(this.FFebActive1.SpecialItem[_loc2_].Inventories);
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
         this.FFebActive1 = SLogicsCore.FebActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TFebActive1;
         this.UpdateDailyGift();
         this.UpdateDailyBox();
         this.UpdateLoginGift();
         this.UpdateSpecialGift();
         this.UpdateSpecialItem();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
      }
      
      override public function MovieEnd() : void
      {
      }
      
      override public function Unmount() : void
      {
         var _loc1_:int = 0;
         TweenUtil.removeAllTween();
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
      }
   }
}

