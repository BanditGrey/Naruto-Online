package Processors.Game.Lobby.TongLing.ToolS
{
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TBB_BuyRapid;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TPBuyTuFeiFuShiCell
   {
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FTF_Count:TextField = null;
      
      protected var FTF_DiscountPrice:TextField = null;
      
      protected var FTF_MoneyCount:TextField = null;
      
      protected var FMC_BuyBtn:MovieClip = null;
      
      protected var FCurIndex:int;
      
      protected var FThisDate:TBB_BuyRapid = null;
      
      protected var FBackFun:Function = null;
      
      public function TPBuyTuFeiFuShiCell()
      {
         super();
      }
      
      public function SetThisPanel(param1:MovieClip, param2:int) : void
      {
         this.FThisPanel = param1;
         this.FCurIndex = param2;
         this.FTF_Count = this.FThisPanel["TF_Count"];
         this.FTF_DiscountPrice = this.FThisPanel["TF_DiscountPrice"];
         this.FTF_MoneyCount = this.FThisPanel["TF_MoneyCount"];
         this.FMC_BuyBtn = this.FThisPanel["MC_BuyBtn"];
         TGameUtil.setButtonMode(this.FMC_BuyBtn,true);
         this.FMC_BuyBtn.addEventListener(MouseEvent.CLICK,this.BClisk);
      }
      
      public function SetDate(param1:TBB_BuyRapid) : void
      {
         this.FThisDate = param1;
         this.InitiLization();
      }
      
      protected function InitiLization() : void
      {
         var _loc1_:int = 0;
         switch(this.FCurIndex)
         {
            case 0:
               _loc1_ = 50;
               break;
            case 1:
               _loc1_ = 100;
               break;
            case 2:
               _loc1_ = 200;
         }
         this.FTF_Count.text = _loc1_.toString();
         this.FTF_DiscountPrice.text = this.FThisDate.Description;
         this.FTF_MoneyCount.text = this.FThisDate.PriceArr[1];
      }
      
      protected function BClisk(param1:MouseEvent) : void
      {
         this.FBackFun(this.FThisDate);
      }
      
      public function set BackFun(param1:Function) : void
      {
         this.FBackFun = param1;
      }
   }
}

