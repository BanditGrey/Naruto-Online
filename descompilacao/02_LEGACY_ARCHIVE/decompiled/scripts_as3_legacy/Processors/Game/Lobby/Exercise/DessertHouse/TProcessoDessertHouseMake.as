package Processors.Game.Lobby.Exercise.DessertHouse
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.DessertHouse.TDessertHouse;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.CONST_COMMON;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessoDessertHouseMake extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Window_Width:uint = 405;
      
      protected static const SIZE_Window_Height:uint = 377;
      
      protected static const CAKE_COUNT:int = 3;
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FTF_Amount:TextField;
      
      protected var FFoodIndex:int;
      
      protected var FAmount:int;
      
      protected var FInitialized:Boolean;
      
      protected var FDessertHouse:TDessertHouse;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FConfirmStr:String;
      
      protected var FCost:int;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnBuyBox:Function;
      
      protected var FOnGetBox:Function;
      
      public function TProcessoDessertHouseMake(param1:TUIComponent)
      {
         super(param1);
         this.FDessertHouse = SLogicsCore.DessertHouse;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137095);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_DessertHouseMake") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["BTN_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         this.FTF_Amount = this.FMC_Scene["TF_Amount"];
         this.FTF_Amount.restrict = "0-9";
         this.FTF_Amount.addEventListener(Event.CHANGE,this.OnTextInput);
         this.FMC_Scene.BTN_Reduce.addEventListener(MouseEvent.CLICK,this.ProcessorOnReduceUp);
         this.FMC_Scene.BTN_Add.addEventListener(MouseEvent.CLICK,this.ProcessorOnAddUp);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Make,true);
         this.FMC_Scene.BTN_Make.addEventListener(MouseEvent.CLICK,this.ProcessorOnMakeUp);
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      public function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         var _loc4_:MovieClip = null;
         _loc3_ = this.FDessertHouse.MakeFoods[this.FFoodIndex];
         _loc1_ = 0;
         while(_loc1_ < CAKE_COUNT)
         {
            _loc4_ = this.FMC_Scene["MC_Item" + _loc1_];
            _loc4_.gotoAndStop(_loc1_ + 1);
            _loc4_.TF_Count.text = this.FDessertHouse.MyFood.GetInventoryByIndex(_loc1_).Quantity + "/" + _loc3_.ExchangeVect[_loc1_] * this.FAmount;
            _loc1_++;
         }
         this.FMC_Scene.TF_Desc.text = TUtilityString.Format(this.FDessertHouse.DescListNew[2],_loc3_.Count * this.FAmount);
         this.FMC_Scene.TF_Amount.text = this.FAmount.toString();
         if(this.FAmount > 0)
         {
            TGameUtil.setButtonMode(this.FMC_Scene.BTN_Make,true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_Scene.BTN_Make,false);
         }
      }
      
      private function ProcessorOnReduceUp(param1:MouseEvent) : void
      {
         if(this.FAmount > 0)
         {
            --this.FAmount;
            this.UpdateText();
         }
      }
      
      private function ProcessorOnAddUp(param1:MouseEvent) : void
      {
         ++this.FAmount;
         this.FAmount = Math.min(999,this.FAmount);
         this.UpdateText();
      }
      
      protected function OnTextInput(param1:Event) : void
      {
         this.FAmount = Math.min(999,int(this.FTF_Amount.text));
         this.UpdateText();
      }
      
      private function ProcessorOnMakeUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:TBaseBox = null;
         var _loc6_:TInventory = null;
         var _loc7_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FOnBuyBox != null)
         {
            _loc4_ = true;
            this.FCost = 0;
            this.FConfirmStr = "";
            _loc2_ = 0;
            while(_loc2_ < this.FDessertHouse.MyFood.Count)
            {
               _loc6_ = this.FDessertHouse.MyFood.GetInventoryByIndex(_loc2_);
               _loc5_ = this.FDessertHouse.MakeFoods[this.FFoodIndex];
               _loc7_ = _loc6_.Quantity - _loc5_.ExchangeVect[_loc2_] * this.FAmount;
               if(_loc7_ < 0)
               {
                  _loc4_ = false;
                  this.FConfirmStr += TUtilityString.Format(this.FDessertHouse.DescListNew[3],_loc6_.Name,Math.abs(_loc7_),this.FDessertHouse.FoodPrice[_loc2_]);
                  this.FCost += Math.abs(_loc7_) * this.FDessertHouse.FoodPrice[_loc2_];
               }
               _loc2_++;
            }
            if(_loc4_)
            {
               this.FOnGetBox(ACTIVITY_1_ID,TProcessorDessertHouse.ACTIVITY_1_MAKE_CAKE,this.FFoodIndex + 1,this.FAmount);
            }
            else
            {
               this.FConfirmStr += TUtilityString.Format(this.FDessertHouse.DescListNew[4],this.FCost);
               if(!this.FUIWindowConfirmation.IsSelected)
               {
                  this.FUIWindowConfirmation.Text = this.FConfirmStr;
                  this.FUIWindowConfirmation.SetCheckBox(true);
                  this.FUIWindowConfirmation.Visible = true;
               }
               else
               {
                  this.WindowConfirmationOnOK();
               }
            }
         }
      }
      
      protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGold >= this.FCost)
         {
            this.FOnGetBox(ACTIVITY_1_ID,TProcessorDessertHouse.ACTIVITY_1_MAKE_CAKE,this.FFoodIndex + 1,this.FAmount);
         }
         else
         {
            this.FUIWindowRecharge.Visible = true;
         }
      }
      
      private function ProcessorOnClose(param1:MouseEvent) : void
      {
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp();
         }
      }
      
      public function get OnCloseUp() : Function
      {
         return this.FOnCloseUp;
      }
      
      public function set OnCloseUp(param1:Function) : void
      {
         this.FOnCloseUp = param1;
      }
      
      public function get OnBuyBox() : Function
      {
         return this.FOnBuyBox;
      }
      
      public function set OnBuyBox(param1:Function) : void
      {
         this.FOnBuyBox = param1;
      }
      
      public function get OnGetBox() : Function
      {
         return this.FOnGetBox;
      }
      
      public function set OnGetBox(param1:Function) : void
      {
         this.FOnGetBox = param1;
      }
      
      public function UpdateUI(param1:int) : void
      {
         this.FFoodIndex = param1;
         this.FAmount = this.FDessertHouse.GetMaxMakeCount(this.FFoodIndex);
         this.FMC_Scene.MC_Cake.gotoAndStop(this.FFoodIndex + 1);
         this.UpdateText();
      }
   }
}

