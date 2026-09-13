package Processors.Game.Lobby.Exercise.DessertHouse.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Logics.Exercise.DessertHouse.TDessertHouse;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.DessertHouse.TProcessorDessertHouse;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIDessertHouse1 extends TUIBaseWindow
   {
      
      protected static const LIST_COUNT:int = 3;
      
      protected static const FOOD_COUNT:int = 3;
      
      protected static const CAKE_COUNT:int = 3;
      
      protected static const HERO_COUNT:int = 5;
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected var FDessertHouse:TDessertHouse;
      
      protected var FCakeList:Vector.<MovieClip>;
      
      public function TUIDessertHouse1(param1:TUIComponent)
      {
         super(param1);
         this.FDessertHouse = SLogicsCore.DessertHouse;
         this.FCakeList = new Vector.<MovieClip>(CAKE_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < CAKE_COUNT)
         {
            this.FCakeList[_loc2_] = FMC_Scene["MC_Cake" + _loc2_];
            TGameUtil.setButtonMode(this.FCakeList[_loc2_].BTN_Buy,true);
            this.FCakeList[_loc2_].BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnMakeCakeUp);
            this.FCakeList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnCakeOver);
            this.FCakeList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc2_++;
         }
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         FMC_Scene.MC_Cake.buttonMode = true;
         FMC_Scene.MC_Cake.addEventListener(MouseEvent.CLICK,this.ProcessorOnServerBoxUp);
         FMC_Scene.MC_Cake.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnServerBoxOver);
         FMC_Scene.MC_Cake.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         TGameUtil.setButtonMode(FMC_Scene.BTN_BuyFood,true);
         FMC_Scene.BTN_BuyFood.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyFoodUp);
         FMC_Scene.BTN_BuyFood.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFoodOver);
         FMC_Scene.BTN_BuyFood.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
      }
      
      protected function UpdateLuckyList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = int(this.FDessertHouse.LuckyList.length);
         _loc1_ = 0;
         while(_loc1_ < LIST_COUNT)
         {
            _loc3_ = FMC_Scene.MC_LuckyLog["MC_Log" + _loc1_];
            if(_loc1_ < _loc2_)
            {
               _loc3_.visible = true;
               _loc3_.TF_Date.text = TUtilityDate.FormatDate(new Date(STimingCore.GetClientShowTime(this.FDessertHouse.LuckyList[_loc1_].date) * 1000));
               _loc3_.TF_Name.text = this.FDessertHouse.LuckyList[_loc1_].name;
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
         _loc2_ = int(this.FDessertHouse.LastLuckyList.length);
         _loc1_ = 0;
         while(_loc1_ < LIST_COUNT)
         {
            _loc3_ = FMC_Scene.MC_LastLuckyLog["MC_Log" + _loc1_];
            if(_loc1_ < _loc2_)
            {
               _loc3_.visible = true;
               _loc3_.TF_Date.text = TUtilityDate.FormatDate(new Date(STimingCore.GetClientShowTime(this.FDessertHouse.LastLuckyList[_loc1_].date) * 1000));
               _loc3_.TF_Name.text = this.FDessertHouse.LastLuckyList[_loc1_].name;
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateFood() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < FOOD_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Food" + _loc1_];
            _loc3_.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc3_.TF_Num.text = this.FDessertHouse.MyFood.GetInventoryByIndex(_loc1_).Quantity.toString();
            _loc1_++;
         }
         if(this.FDessertHouse.FoodBox.Status != TBaseActivity.STATUS_GETED)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_BuyFood,true);
            FMC_Scene.BTN_BuyFood.MC_Click.visible = true;
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_BuyFood,false);
            FMC_Scene.BTN_BuyFood.MC_Click.visible = false;
         }
      }
      
      protected function UpdateServerBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TBaseBox = null;
         _loc5_ = this.FDessertHouse.ServerBox;
         _loc2_ = _loc5_.BuyCount / (_loc5_.Count / HERO_COUNT);
         _loc1_ = 0;
         while(_loc1_ < HERO_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Hero" + _loc1_];
            if(_loc1_ == _loc2_)
            {
               _loc4_.visible = true;
               _loc4_.TF_Count.text = _loc5_.BuyCount + "/" + _loc5_.Count;
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
         if(_loc5_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.MC_Cake.MC_Click.visible = false;
            FMC_Scene.MC_Cake.MC_Tag.visible = true;
            FMC_Scene.MC_Cake.MC_Got.visible = false;
         }
         else if(_loc5_.Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_Cake.MC_Click.visible = true;
            FMC_Scene.MC_Cake.MC_Tag.visible = true;
            FMC_Scene.MC_Cake.MC_Got.visible = false;
         }
         else
         {
            FMC_Scene.MC_Cake.MC_Click.visible = false;
            FMC_Scene.MC_Cake.MC_Tag.visible = false;
            FMC_Scene.MC_Cake.MC_Got.visible = true;
         }
      }
      
      protected function ProcessorOnMakeCakeUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnShowWindow != null)
         {
            FOnShowWindow(_loc2_);
         }
      }
      
      protected function ProcessorOnBuyFoodUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnBuyBox != null)
         {
            _loc3_ = this.FDessertHouse.FoodBox.Price;
            FOnBuyBox(ACTIVITY_1_ID,TProcessorDessertHouse.ACTIVITY_1_BUY_FOOD,_loc3_);
         }
      }
      
      protected function ProcessorOnServerBoxUp(param1:MouseEvent) : void
      {
         if(Boolean(FOnGetBox != null) && Boolean(this.FDessertHouse.ServerBox) && this.FDessertHouse.ServerBox.Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorDessertHouse.ACTIVITY_1_GET_SERVER_BOX);
         }
      }
      
      protected function ProcessorOnCakeOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FDessertHouse) && _loc2_ < this.FDessertHouse.MakeFoods.length)
         {
            FOnShowHtmlTip(this.FDessertHouse.MakeFoods[_loc2_].Desc1);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FDessertHouse) && Boolean(this.FDessertHouse.LuckyBox))
         {
            FOnNewBoxOver(this.FDessertHouse.LuckyBox);
         }
      }
      
      protected function ProcessorOnFoodOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FDessertHouse) && Boolean(this.FDessertHouse.FoodBox))
         {
            FOnNewBoxOver(this.FDessertHouse.FoodBox.Inventories);
         }
      }
      
      protected function ProcessorOnServerBoxOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FDessertHouse) && Boolean(this.FDessertHouse.ServerBox))
         {
            FOnNewBoxOver(this.FDessertHouse.ServerBox.Inventories);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(1);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         if(FInitialized && FMC_Scene.visible)
         {
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateLuckyList();
         this.UpdateFood();
         this.UpdateServerBox();
      }
   }
}

