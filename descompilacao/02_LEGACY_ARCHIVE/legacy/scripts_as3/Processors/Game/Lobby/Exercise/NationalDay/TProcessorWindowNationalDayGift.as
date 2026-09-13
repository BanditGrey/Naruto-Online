package Processors.Game.Lobby.Exercise.NationalDay
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.NationalDay.TNationalDay;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowNationalDayGift extends TProcessorLobbyWindow
   {
      
      public static const GIFT_COUNT:int = 5;
      
      protected var FMC_Scene:Sprite;
      
      protected var FTF_Desc:TextField;
      
      protected var FInitialized:Boolean;
      
      protected var FNationalDay:TNationalDay;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnGetBox:Function;
      
      public function TProcessorWindowNationalDayGift(param1:TUIComponent)
      {
         super(param1);
         this.FNationalDay = SLogicsCore.NationalDay;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBaseBox = null;
         this.FMC_Scene = param1;
         _loc2_ = 0;
         while(_loc2_ < GIFT_COUNT)
         {
            param1 = this.FMC_Scene["MC_Box" + _loc2_];
            param1.MC_Icon.gotoAndStop(_loc2_ + 1);
            param1.MC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            param1.MC_Icon.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            param1.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBox);
            _loc2_++;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         _loc2_ = this.FNationalDay.GiftID;
         if(_loc2_ == this.FNationalDay.GiftVect.length && this.FNationalDay.GiftVect[_loc2_ - 1].Status == TBaseActivity.STATUS_GETED)
         {
            this.FMC_Scene["TF_CurBox"].text = "";
         }
         else
         {
            _loc1_ = this.FNationalDay.GiftVect[this.FNationalDay.GiftID - 1].Title;
            this.FMC_Scene["TF_CurBox"].text = _loc1_ + TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_NEXT_REWARD_DAY,this.FNationalDay.GiftID);
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            _loc4_ = this.FNationalDay.GiftVect[_loc1_];
            _loc3_ = this.FMC_Scene["MC_Box" + _loc1_];
            _loc3_.TF_Title.text = _loc4_.Title;
            if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
            {
               TGameUtil.setButtonMode(_loc3_.BTN_Get,true);
               _loc3_.MC_Got.visible = false;
               _loc3_.BTN_Get.visible = true;
               _loc3_.MC_Miss.visible = false;
            }
            else if(_loc4_.Status == TBaseActivity.STATUS_GETED)
            {
               TGameUtil.setButtonMode(_loc3_.BTN_Get,false);
               _loc3_.MC_Got.visible = true;
               _loc3_.BTN_Get.visible = false;
               _loc3_.MC_Miss.visible = false;
            }
            else if(_loc1_ < this.FNationalDay.GiftID - 1)
            {
               _loc3_.BTN_Get.visible = false;
               _loc3_.MC_Miss.visible = true;
               _loc3_.MC_Got.visible = false;
            }
            else
            {
               TGameUtil.setButtonMode(_loc3_.BTN_Get,false);
               _loc3_.MC_Got.visible = false;
               _loc3_.BTN_Get.visible = true;
               _loc3_.MC_Miss.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorOnGetBox(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FOnGetBox != null)
         {
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
            this.FOnGetBox(_loc2_);
         }
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FOnOverlay != null)
         {
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
            this.FOnOverlay(_loc2_);
         }
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FOnOut != null)
         {
            this.FOnOut();
         }
      }
      
      public function get OnOverlay() : Function
      {
         return this.FOnOverlay;
      }
      
      public function set OnOverlay(param1:Function) : void
      {
         this.FOnOverlay = param1;
      }
      
      public function get OnOut() : Function
      {
         return this.FOnOut;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function get OnGetBox() : Function
      {
         return this.FOnGetBox;
      }
      
      public function set OnGetBox(param1:Function) : void
      {
         this.FOnGetBox = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateBox();
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         this.FMC_Scene.visible = param1;
      }
   }
}

