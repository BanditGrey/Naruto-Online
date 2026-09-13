package Processors.Game.Lobby.NarutoRoad
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TNarutoRoadPackage;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_NARUTOROAD;
   import Resources.Strings.STRING_NARUTOROAD;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowBuyBox extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Recharge_Window_Width:uint = 310;
      
      protected static const SIZE_Recharge_Window_Height:uint = 190;
      
      private var SIZE_NarutoRoad_Width:int = 818;
      
      private var SIZE_NarutoRoad_Height:int = 563;
      
      protected var FMC_Scene:Sprite;
      
      protected var FTF_GoodsName:TextField;
      
      protected var FBTN_Reduce:SimpleButton;
      
      protected var FBTN_Add:SimpleButton;
      
      protected var FTF_GoodsNum:TextField;
      
      protected var FMC_Bar:Sprite;
      
      protected var FMC_Icon:MovieClip;
      
      protected var FTF_Discount:TextField;
      
      protected var FTF_NowPrice:TextField;
      
      protected var FTF_OriginalPrice:TextField;
      
      protected var FBTN_Confirm:MovieClip;
      
      protected var FBTN_Cancel:MovieClip;
      
      protected var FBtnList:Vector.<MovieClip>;
      
      protected var FGoodsNum:int;
      
      protected var FCurrentPrice:uint;
      
      protected var FBoxData:TNarutoRoadPackage;
      
      protected var FBoxIndex:int;
      
      protected var FBuyCount:int;
      
      protected var FBoxOnBuy:Function;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      public function TProcessorWindowBuyBox(param1:TUIComponent)
      {
         super(param1);
         this.FBtnList = new Vector.<MovieClip>();
         this.FGoodsNum = 1;
         this.InitWindow();
         this.ResourcesPerformUILocations();
      }
      
      protected function InitWindow() : void
      {
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-470,-175,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_NARUTOROAD.RESOURCE_ClassName_MC_BuyLevelBox) as Sprite;
         addChild(this.FMC_Scene);
         this.FTF_GoodsName = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_TF_GoodsName];
         this.FTF_GoodsNum = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_TF_GoodsNum];
         this.FTF_GoodsNum.restrict = "0-9";
         this.FTF_GoodsNum.maxChars = 5;
         this.FBTN_Confirm = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_BTN_Confirm];
         TGameUtil.setButtonMode(this.FBTN_Confirm,true);
         this.FBtnList.push(this.FBTN_Confirm);
         this.FBTN_Cancel = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_BTN_Cancel];
         TGameUtil.setButtonMode(this.FBTN_Cancel,true);
         this.FBtnList.push(this.FBTN_Cancel);
         this.FBTN_Add = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_BTN_Add];
         this.FBTN_Reduce = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_BTN_Reduce];
         this.FMC_Bar = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_MC_Bar];
         this.FMC_Icon = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_MC_Icon];
         this.FTF_OriginalPrice = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_TF_OriginalPrice];
         this.FTF_NowPrice = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_TF_NowPrice];
         this.FTF_Discount = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_TF_Discount];
         this.FTF_OriginalPrice.mouseEnabled = false;
         this.FTF_NowPrice.mouseEnabled = false;
         this.FTF_Discount.mouseEnabled = false;
      }
      
      protected function ResourcesPerformUILocations() : void
      {
         this.FBTN_Reduce.addEventListener(MouseEvent.CLICK,this.ReduceOnClick,false,0,true);
         this.FBTN_Add.addEventListener(MouseEvent.CLICK,this.AddOnClick,false,0,true);
         this.FBTN_Confirm.addEventListener(MouseEvent.CLICK,this.ConfirmOnClick,false,0,true);
         this.FBTN_Cancel.addEventListener(MouseEvent.CLICK,this.CloseOnClick,false,0,true);
         this.FTF_GoodsNum.addEventListener(Event.CHANGE,this.OnTextInput,false,0,true);
         this.FMC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.OnRollOver,false,0,true);
         this.FMC_Icon.addEventListener(MouseEvent.MOUSE_OUT,this.OnRollOut,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      protected function UpdateIconInfo() : void
      {
         this.FMC_Icon.gotoAndStop(this.FBoxIndex + 1);
      }
      
      protected function UpdatePrice() : void
      {
         this.FTF_GoodsName.text = this.FBoxData.BoxNameVect[this.FBoxIndex];
         this.FTF_GoodsNum.text = this.FGoodsNum.toString();
         this.FTF_OriginalPrice.text = (this.FBoxData.RewardOriginalVect[this.FBoxIndex] * this.FGoodsNum).toString();
         this.FCurrentPrice = this.FBoxData.RewardPriceVect[this.FBoxIndex];
         this.FTF_NowPrice.text = (this.FCurrentPrice * this.FGoodsNum).toString();
         this.FTF_Discount.text = TUtilityString.Format(STRING_NARUTOROAD.FORMAT_Discount,this.FBoxData.RewardDiscountVect[this.FBoxIndex]);
      }
      
      protected function ReduceOnClick(param1:MouseEvent) : void
      {
         --this.FGoodsNum;
         if(this.FGoodsNum <= 0)
         {
            this.FGoodsNum = 1;
         }
         this.UpdatePrice();
      }
      
      protected function AddOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         ++this.FGoodsNum;
         this.UpdatePrice();
         _loc2_ = (SLogicsCore.Character.CreditGold + SLogicsCore.Character.CreditGiftCertificate) / this.FCurrentPrice;
         _loc3_ = this.FBoxData.RewardNumberVect[this.FBoxIndex] - this.FBuyCount;
         _loc2_ = Math.max(Math.min(_loc2_,_loc3_),1);
         if(this.FGoodsNum > _loc2_)
         {
            this.FGoodsNum = _loc2_;
            this.UpdatePrice();
         }
      }
      
      protected function ConfirmOnClick(param1:MouseEvent) : void
      {
         if(this.FBoxOnBuy != null)
         {
            this.FBoxOnBuy(this.FGoodsNum);
         }
         this.CloseOnClick(param1);
      }
      
      protected function CloseOnClick(param1:MouseEvent) : void
      {
         if(FOnClose != null)
         {
            FOnClose();
         }
      }
      
      protected function OnTextInput(param1:Event) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         this.FGoodsNum = uint(this.FTF_GoodsNum.text) > 0 ? int(uint(this.FTF_GoodsNum.text)) : 1;
         this.UpdatePrice();
         _loc2_ = (SLogicsCore.Character.CreditGold + SLogicsCore.Character.CreditGiftCertificate) / this.FCurrentPrice;
         _loc3_ = this.FBoxData.RewardNumberVect[this.FBoxIndex] - this.FBuyCount;
         _loc2_ = Math.min(_loc2_,_loc3_);
         if(this.FGoodsNum > _loc2_)
         {
            this.FGoodsNum = _loc2_;
            this.UpdatePrice();
         }
      }
      
      protected function OnRollOver(param1:MouseEvent) : void
      {
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(this,this.FBoxIndex);
         }
      }
      
      protected function OnRollOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      public function get BoxOnBuy() : Function
      {
         return this.FBoxOnBuy;
      }
      
      public function set BoxOnBuy(param1:Function) : void
      {
         this.FBoxOnBuy = param1;
      }
      
      public function get HintOnMove() : Function
      {
         return this.FHintOnMove;
      }
      
      public function set HintOnMove(param1:Function) : void
      {
         this.FHintOnMove = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function UpdateData(param1:TNarutoRoadPackage, param2:int, param3:int) : void
      {
         this.FBoxData = param1;
         this.FBoxIndex = param2;
         this.FBuyCount = param3;
         this.FGoodsNum = 1;
         if(this.FBoxData != null)
         {
            this.UpdateIconInfo();
            this.UpdatePrice();
         }
      }
   }
}

