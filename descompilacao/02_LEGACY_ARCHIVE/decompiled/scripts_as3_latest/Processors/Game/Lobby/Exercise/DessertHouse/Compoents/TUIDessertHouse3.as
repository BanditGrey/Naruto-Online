package Processors.Game.Lobby.Exercise.DessertHouse.Compoents
{
   import Components.Standard.TUITab;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.DessertHouse.TDessertHouse;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.DessertHouse.TProcessorDessertHouse;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIDessertHouse3 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 10;
      
      protected static const LEVEL_COUNT:int = 3;
      
      protected static const ACTIVITY_3_ID:int = 3;
      
      protected var FDessertHouse:TDessertHouse;
      
      protected var FBoxList:Vector.<TUIBaseBox>;
      
      protected var FUITab:TUITab;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FExchangeItems:Vector.<TBaseBox>;
      
      protected var FMC_Effect:MovieClip;
      
      public function TUIDessertHouse3(param1:TUIComponent)
      {
         super(param1);
         this.FDessertHouse = SLogicsCore.DessertHouse;
         this.FBoxList = new Vector.<TUIBaseBox>(BOX_COUNT);
         this.FUITab = new TUITab(this);
         this.FTabList = new Vector.<MovieClip>(LEVEL_COUNT);
         this.FChangeTabIndex = 0;
         this.FExchangeItems = new Vector.<TBaseBox>();
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIBaseBox = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < LEVEL_COUNT)
         {
            _loc4_ = FMC_Scene["BTN_Level" + _loc2_];
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,ProcessorOnBoxOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnBoxOut);
            this.FTabList[_loc2_] = _loc4_;
            this.FUITab.SetTabByIndex(_loc4_,_loc2_);
            _loc2_++;
         }
         this.FUITab.Init();
         this.FUITab.OnSwitch = this.ChangeTabOnSwitch;
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            _loc5_ = new TUIBaseBox(this,1);
            _loc5_.Perform_UIDispatch(FMC_Scene["MC_Box" + _loc2_]);
            _loc5_.OnOverlay = this.SlotsOnOver;
            _loc5_.OnOut = this.SlotsOnOut;
            _loc5_.OnExchangeUp = this.ProcessorOnExchangeUp;
            _loc5_.OnExchangeOver = this.ProcessorOnExchangeOver;
            _loc5_.OnExchangeOut = this.ProcessorOnExchangeOut;
            this.FBoxList[_loc2_] = _loc5_;
            _loc2_++;
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:TInventories = null;
         var _loc6_:int = 0;
         this.FExchangeItems.length = 0;
         _loc2_ = int(this.FDessertHouse.ExchangeItems.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FDessertHouse.ExchangeItems[_loc1_];
            if(_loc4_.Level == this.FChangeTabIndex + 1)
            {
               this.FExchangeItems.push(_loc4_);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            if(_loc1_ < this.FExchangeItems.length)
            {
               _loc4_ = this.FExchangeItems[_loc1_];
               _loc5_ = _loc4_.Inventories;
               this.FBoxList[_loc1_].UpdateUI(_loc5_);
               this.FBoxList[_loc1_].Identify = _loc4_.Identify;
               this.FBoxList[_loc1_].SetVisible(true);
               _loc3_ = TUtilityString.Format(this.FDessertHouse.DescListNew[6],_loc4_.LimitCount);
               this.FBoxList[_loc1_].SetLimitText(_loc3_);
               if(_loc4_.Status == 1)
               {
                  this.FBoxList[_loc1_].SetMCIsVisible("MC_Fire",true);
               }
               else
               {
                  this.FBoxList[_loc1_].SetMCIsVisible("MC_Fire",false);
               }
               this.FBoxList[_loc1_].SetMCIsVisible("MC_Effect",false);
               if(this.FDessertHouse.CakeLevel >= _loc4_.Level && _loc4_.LimitCount > 0)
               {
                  this.FBoxList[_loc1_].SetExchangeBtnMode(true);
                  this.FBoxList[_loc1_].SetMCIsVisible("MC_Lock",false);
               }
               else
               {
                  this.FBoxList[_loc1_].SetExchangeBtnMode(false);
                  if(this.FDessertHouse.CakeLevel < _loc4_.Level)
                  {
                     this.FBoxList[_loc1_].SetMCIsVisible("MC_Lock",true);
                  }
                  else
                  {
                     this.FBoxList[_loc1_].SetMCIsVisible("MC_Lock",false);
                  }
               }
            }
            else
            {
               this.FBoxList[_loc1_].SetVisible(false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBtn() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < LEVEL_COUNT)
         {
            _loc2_ = this.FTabList[_loc1_];
            _loc2_.TF_Level.text = "Level " + (_loc1_ + 1);
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.MC_Cake.gotoAndStop(this.FDessertHouse.CakeLevel);
         FMC_Scene.TF_Score.text = this.FDessertHouse.TastyValue.toString();
         FMC_Scene.TF_Level.text = this.FDessertHouse.CakeLevel.toString();
         FMC_Scene.TF_Exp.text = this.FDessertHouse.CakeExp + "/" + this.FDessertHouse.CakeNextExp;
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = 0;
         this.FChangeTabIndex = param1 as int;
         this.UpdateBox();
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TBaseBox = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null)
         {
            _loc5_ = this.FDessertHouse.GetItemByIdentify(param2);
            if(Boolean((_loc5_) && _loc5_.LimitCount > 0) && Boolean(this.FDessertHouse.CakeLevel >= _loc5_.Level) && this.FDessertHouse.TastyValue >= _loc5_.Price)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorDessertHouse.ACTIVITY_3_EXCHANGE_ITEM,param2);
            }
            else
            {
               FOnShowFlowText(this.FDessertHouse.DescListNew[5]);
            }
         }
      }
      
      protected function ProcessorOnExchangeOver(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TBaseBox = null;
         if(FOnShowHtmlTip != null)
         {
            _loc4_ = this.FDessertHouse.GetItemByIdentify(param1);
            if(_loc4_)
            {
               _loc3_ = TUtilityString.Format(this.FDessertHouse.DescListNew[2],_loc4_.Price);
               FOnShowHtmlTip(_loc3_);
            }
         }
      }
      
      protected function ProcessorOnExchangeOut(param1:int) : void
      {
         if(FOnHideHtmlTip != null)
         {
            FOnHideHtmlTip();
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(param1,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(param1,param2);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && FMC_Scene.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < BOX_COUNT)
            {
               if(this.FBoxList[_loc1_])
               {
                  this.FBoxList[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateBox();
         this.UpdateBtn();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc4_ = int(this.FExchangeItems.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(param1 == this.FExchangeItems[_loc3_].Identify)
            {
               this.FMC_Effect = FMC_Scene["MC_Box" + _loc3_].MC_Effect;
               this.FMC_Effect.visible = true;
               this.FMC_Effect.alpha = 1;
               this.FMC_Effect.x = -2;
               this.FMC_Effect.y = 45;
               _loc5_ = 95 - _loc3_ % 5 * 100;
               _loc6_ = -96 - int(_loc3_ / 5) * 123;
               TweenUtil.to(this.FMC_Effect,500,{
                  "x":_loc5_,
                  "y":_loc6_,
                  "alpha":0.5,
                  "onComplete":this.MovieEnd
               });
               return;
            }
            _loc3_++;
         }
      }
      
      override public function MovieEnd() : void
      {
         this.FMC_Effect.visible = false;
         this.FMC_Effect.alpha = 0;
         this.UpdateUI();
      }
   }
}

