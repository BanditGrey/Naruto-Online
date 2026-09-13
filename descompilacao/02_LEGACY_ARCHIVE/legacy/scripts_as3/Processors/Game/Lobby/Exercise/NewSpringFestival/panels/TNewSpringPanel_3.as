package Processors.Game.Lobby.Exercise.NewSpringFestival.panels
{
   import Foundation.Tools.MvcPlayEffect;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TNewSpring2018Config2;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.NewSpringFestival.TProcessorNewSpringFestival;
   import Processors.Game.Lobby.Exercise.NewSpringFestival.items.TNewSpringLanternItem;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TNewSpringPanel_3 extends TUIBaseWindow
   {
      
      private var t_scoreValue:TextField;
      
      private var t_commonValue:TextField;
      
      private var t_highValue:TextField;
      
      private var t_discountValue:TextField;
      
      private var t_priceValue:TextField;
      
      private var mc_refreshDiscount:MovieClip;
      
      private var mc_exchange_1:MovieClip;
      
      private var mc_exchange_2:MovieClip;
      
      private var mc_effect:MovieClip;
      
      private var mc_buy:MovieClip;
      
      private var _main:TProcessorNewSpringFestival;
      
      public var lanternItems:Array;
      
      private const LANTERN_COUNT:int = 3;
      
      private var keyBoxItem:Object;
      
      private var _totalPrice:int;
      
      private var mvcPlayEffect:MvcPlayEffect;
      
      public function TNewSpringPanel_3(param1:TUIComponent)
      {
         super(param1);
         this._main = param1 as TProcessorNewSpringFestival;
      }
      
      private function initUi() : void
      {
         var _loc2_:TNewSpringLanternItem = null;
         this.t_scoreValue = FMC_Scene["t_scoreValue"] as TextField;
         this.t_commonValue = FMC_Scene["t_commonValue"] as TextField;
         this.t_highValue = FMC_Scene["t_highValue"] as TextField;
         this.t_discountValue = FMC_Scene["t_discountValue"] as TextField;
         this.t_priceValue = FMC_Scene["t_priceValue"] as TextField;
         this.mc_refreshDiscount = FMC_Scene["mc_refreshDiscount"] as MovieClip;
         this.mc_exchange_1 = FMC_Scene["mc_exchange_1"] as MovieClip;
         this.mc_exchange_2 = FMC_Scene["mc_exchange_2"] as MovieClip;
         this.mc_buy = FMC_Scene["mc_buy"] as MovieClip;
         this.mc_effect = FMC_Scene["mc_effect"] as MovieClip;
         this.mc_effect.visible = false;
         this.mvcPlayEffect = new MvcPlayEffect(this.endEffectFun,this.mc_effect.totalFrames);
         this.mvcPlayEffect.SetEffectPanel(this.mc_effect);
         TGameUtil.setButtonMode(this.mc_refreshDiscount,true);
         TGameUtil.setButtonMode(this.mc_exchange_1,true);
         TGameUtil.setButtonMode(this.mc_exchange_2,true);
         TGameUtil.setButtonMode(this.mc_buy,true);
         this.mc_refreshDiscount.addEventListener(MouseEvent.CLICK,this.onRefreshDiscountHandler);
         this.mc_exchange_1.addEventListener(MouseEvent.CLICK,this.onExchange_1Handler);
         this.mc_exchange_2.addEventListener(MouseEvent.CLICK,this.onExchange_2Handler);
         this.mc_buy.addEventListener(MouseEvent.CLICK,this.onBuyHandler);
         var _loc1_:TNewSpring2018Config2 = this._main.tabConfig2.GetDatebaseByIdentifier(60011) as TNewSpring2018Config2;
         this.t_commonValue.text = int(_loc1_.jifeng).toString();
         _loc1_ = this._main.tabConfig2.GetDatebaseByIdentifier(60012) as TNewSpring2018Config2;
         this.t_highValue.text = int(_loc1_.jifeng).toString();
         this.lanternItems = [];
         var _loc3_:int = 0;
         while(_loc3_ < this.LANTERN_COUNT)
         {
            _loc2_ = new TNewSpringLanternItem(this,this._main);
            _loc2_.initUI(FMC_Scene["mc_denglong_" + _loc3_.toString()],_loc3_);
            _loc2_.selectFun = this.updatePrice;
            this.lanternItems.push(_loc2_);
            _loc3_++;
         }
      }
      
      public function updatePrice() : void
      {
         var _loc1_:Boolean = true;
         this._totalPrice = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.LANTERN_COUNT)
         {
            _loc2_ = (this.lanternItems[_loc3_] as TNewSpringLanternItem).getSeletctCurrentPrice();
            if(_loc2_ == 0)
            {
               _loc1_ = false;
            }
            this._totalPrice += _loc2_;
            _loc3_++;
         }
         this.t_priceValue.text = this._totalPrice.toString();
         this.mc_buy.mouseEnabled = _loc1_;
         TGameUtil.setButtonMode(this.mc_buy,_loc1_);
      }
      
      private function onBuyHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<int> = new Vector.<int>();
         var _loc4_:int = 0;
         while(_loc4_ < this.LANTERN_COUNT)
         {
            _loc3_ = (this.lanternItems[_loc4_] as TNewSpringLanternItem).selectInded;
            _loc2_.push(_loc3_);
            _loc4_++;
         }
         var _loc5_:Object = new Object();
         _loc5_["const"] = this._totalPrice;
         _loc5_["type"] = TProcessorNewSpringFestival.BUY_LANTERN;
         _loc5_["data"] = _loc2_;
         this._main.showBuyConfimBox(_loc5_);
      }
      
      private function onExchange_2Handler(param1:MouseEvent) : void
      {
         var _loc2_:Vector.<int> = new Vector.<int>();
         _loc2_.push(1);
         this._main.Packet_CS_AllReq(TProcessorNewSpringFestival.EXCHANGE_BAG,_loc2_);
      }
      
      private function onExchange_1Handler(param1:MouseEvent) : void
      {
         var _loc2_:Vector.<int> = new Vector.<int>();
         _loc2_.push(0);
         this._main.Packet_CS_AllReq(TProcessorNewSpringFestival.EXCHANGE_BAG,_loc2_);
      }
      
      private function onRefreshDiscountHandler(param1:MouseEvent) : void
      {
         var _loc2_:Vector.<int> = new Vector.<int>();
         var _loc3_:TNewSpring2018Config2 = this._main.tabConfig2.GetDatebaseByIdentifier(60010) as TNewSpring2018Config2;
         var _loc4_:Object = new Object();
         _loc4_["const"] = int(_loc3_.orgPrice);
         _loc4_["type"] = TProcessorNewSpringFestival.REFRESH_DISCOUNT;
         _loc4_["data"] = _loc2_;
         this._main.showBuyConfimBox(_loc4_);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         super.Resources_UIDispatch(param1);
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
         this.initUi();
      }
      
      override public function LogicsPerform() : void
      {
         super.LogicsPerform();
         var _loc1_:int = 0;
         while(_loc1_ < this.LANTERN_COUNT)
         {
            (this.lanternItems[_loc1_] as TNewSpringLanternItem).LogicsPerform();
            _loc1_++;
         }
      }
      
      public function restLanternItem(param1:int = -1) : void
      {
         var _loc2_:int = 0;
         if(param1 >= 0)
         {
            (this.lanternItems[param1] as TNewSpringLanternItem).restUI();
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < this.LANTERN_COUNT)
            {
               (this.lanternItems[_loc2_] as TNewSpringLanternItem).restUI();
               _loc2_++;
            }
         }
      }
      
      public function showEffect() : void
      {
         this.mc_effect.visible = true;
         this.mvcPlayEffect.playEffect();
      }
      
      private function endEffectFun() : void
      {
         this.mc_effect.visible = false;
      }
      
      override public function UpdateUI() : void
      {
         this.t_scoreValue.text = this._main.newSpring2018Data.consumePoint.toString();
         this.t_discountValue.text = this._main.newSpring2018Data.sale.toString();
         var _loc1_:int = 0;
         while(_loc1_ < this.LANTERN_COUNT)
         {
            (this.lanternItems[_loc1_] as TNewSpringLanternItem).updateUI(this._main.newSpring2018Data.Lanterns[_loc1_]);
            _loc1_++;
         }
         var _loc2_:TNewSpring2018Config2 = this._main.tabConfig2.GetDatebaseByIdentifier(60011) as TNewSpring2018Config2;
         if(this._main.newSpring2018Data.consumePoint >= int(_loc2_.jifeng))
         {
            TGameUtil.setButtonMode(this.mc_exchange_1,true);
            this.mc_exchange_1.mouseEnabled = true;
         }
         else
         {
            TGameUtil.setButtonMode(this.mc_exchange_1,false);
            this.mc_exchange_1.mouseEnabled = false;
         }
         _loc2_ = this._main.tabConfig2.GetDatebaseByIdentifier(60012) as TNewSpring2018Config2;
         if(this._main.newSpring2018Data.consumePoint >= int(_loc2_.jifeng))
         {
            TGameUtil.setButtonMode(this.mc_exchange_2,true);
            this.mc_exchange_2.mouseEnabled = true;
         }
         else
         {
            TGameUtil.setButtonMode(this.mc_exchange_2,false);
            this.mc_exchange_2.mouseEnabled = false;
         }
         this.updatePrice();
      }
   }
}

