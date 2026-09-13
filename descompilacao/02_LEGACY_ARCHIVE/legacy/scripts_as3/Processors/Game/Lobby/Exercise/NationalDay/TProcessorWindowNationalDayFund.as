package Processors.Game.Lobby.Exercise.NationalDay
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.NationalDay.TNationalDay;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowNationalDayFund extends TProcessorLobbyWindow
   {
      
      public static const FUND_COUNT:int = 5;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMC_BuyFund:MovieClip;
      
      protected var FMC_GetFund:MovieClip;
      
      protected var FTF_Desc:TextField;
      
      protected var FInitialized:Boolean;
      
      protected var FNationalDay:TNationalDay;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnBoxOverlay:Function;
      
      protected var FOnBoxOut:Function;
      
      protected var FOnGetBox:Function;
      
      public function TProcessorWindowNationalDayFund(param1:TUIComponent)
      {
         super(param1);
         this.FNationalDay = SLogicsCore.NationalDay;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.FMC_Scene = param1;
         this.FMC_BuyFund = this.FMC_Scene.MC_BuyFund;
         this.FMC_GetFund = this.FMC_Scene.MC_GetFund;
         _loc2_ = 0;
         while(_loc2_ < FUND_COUNT)
         {
            param1 = this.FMC_BuyFund["MC_Tree" + _loc2_];
            param1.MC_Icon.gotoAndStop(_loc2_ + 1);
            param1.MC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTreeOver);
            param1.MC_Icon.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnTreeOut);
            param1.MC_BoxPic.buttonMode = true;
            param1.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            param1.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            TGameUtil.setButtonMode(param1.BTN_Buy,true);
            param1.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBox);
            _loc2_++;
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < FUND_COUNT)
         {
            _loc4_ = this.FNationalDay.FundVect[_loc1_];
            _loc3_ = this.FMC_BuyFund["MC_Tree" + _loc1_];
            _loc3_.TF_Rate.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_GET_RATE,_loc4_.Discount);
            _loc3_.TF_Count.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ALL_COUNT,_loc4_.Count);
            _loc3_.TF_Gold.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_EVERYDAY_GOLD,_loc4_.CurPrice);
            _loc1_++;
         }
      }
      
      protected function UpdateTree() : void
      {
         var _loc1_:TBaseBox = null;
         _loc1_ = this.FNationalDay.FundVect[this.FNationalDay.FundID - 1];
         this.FMC_GetFund.TF_Tree.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_HAVE_TREE,_loc1_.Title,_loc1_.Discount);
         this.FMC_GetFund.TF_Gold.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_EVERYDAY_GOLD,_loc1_.CurPrice);
         this.FMC_GetFund.TF_Count.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LEFT_COUNT,_loc1_.Count - _loc1_.BuyCount);
         this.FMC_GetFund.MC_TreePic.gotoAndStop(this.FNationalDay.FundID);
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
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
            this.FOnGetBox(_loc2_);
         }
      }
      
      protected function ProcessorOnTreeOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FOnOverlay != null)
         {
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
            this.FOnOverlay(_loc2_);
         }
      }
      
      protected function ProcessorOnTreeOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FOnOut != null)
         {
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
            this.FOnOut(_loc2_);
         }
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FOnBoxOverlay != null)
         {
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
            this.FOnBoxOverlay(_loc2_);
         }
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FOnBoxOut != null)
         {
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
            this.FOnBoxOut(_loc2_);
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
      
      public function get OnBoxOverlay() : Function
      {
         return this.FOnBoxOverlay;
      }
      
      public function set OnBoxOverlay(param1:Function) : void
      {
         this.FOnBoxOverlay = param1;
      }
      
      public function get OnBoxOut() : Function
      {
         return this.FOnBoxOut;
      }
      
      public function set OnBoxOut(param1:Function) : void
      {
         this.FOnBoxOut = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function UpdateUI() : void
      {
         if(this.FNationalDay.FundID == 0)
         {
            this.UpdateBox();
            this.FMC_BuyFund.visible = true;
            this.FMC_GetFund.visible = false;
         }
         else
         {
            this.UpdateTree();
            this.FMC_BuyFund.visible = false;
            this.FMC_GetFund.visible = true;
         }
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         this.FMC_Scene.visible = param1;
      }
   }
}

