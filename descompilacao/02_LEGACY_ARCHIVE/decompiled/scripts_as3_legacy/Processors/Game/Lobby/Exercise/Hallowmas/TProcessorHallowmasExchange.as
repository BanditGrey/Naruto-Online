package Processors.Game.Lobby.Exercise.Hallowmas
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.Exercise.Hallowmas.THallowmas;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Battle.Character.TActive;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorHallowmasExchange extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Window_Width:uint = 548;
      
      protected static const SIZE_Window_Height:uint = 334;
      
      protected static const ITEM_COUNT:int = 4;
      
      protected static const BOX_COUNT:int = 1;
      
      public static const NINJIA_COUNT:int = 2;
      
      public static const SWEET_COUNT:int = 3;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FTF_Desc:TextField;
      
      protected var FInitialized:Boolean;
      
      protected var FHallowmas:THallowmas;
      
      protected var FIndex:int;
      
      protected var FUIBoxVect:Vector.<TUIBaseBox>;
      
      protected var FBeClicked:Boolean;
      
      protected var FActive0:TActive;
      
      protected var FActive1:TActive;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FOnGetBox:Function;
      
      protected var FOnGetHero:Function;
      
      protected var FOnNinjiaOver:Function;
      
      protected var FOnNinjiaOut:Function;
      
      protected var FOnShowRecruit:Function;
      
      public function TProcessorHallowmasExchange(param1:TUIComponent)
      {
         super(param1);
         this.FHallowmas = SLogicsCore.Hallowmas;
         this.FUIBoxVect = new Vector.<TUIBaseBox>(ITEM_COUNT);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2181038080);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TUIBaseBox = null;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0 - (CONST_COMMON.STAGE_Width - SIZE_Window_Width) / 2,0 - (CONST_COMMON.STAGE_Height - SIZE_Window_Height) / 2,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_HallowmasExchange") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["Btn_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         this.FTF_Desc = this.FMC_Scene["TF_Desc"];
         _loc2_ = 0;
         while(_loc2_ < ITEM_COUNT)
         {
            _loc1_ = new TUIBaseBox(this,BOX_COUNT);
            _loc1_.Perform_UIDispatch(this.FMC_Scene["MC_Item" + _loc2_]);
            _loc1_.OnOverlay = this.SlotsOnOver;
            _loc1_.OnOut = this.SlotsOnOut;
            _loc1_.OnGetBox = this.ProcessorOnBuyUp;
            _loc1_.OnBtnOver = this.ProcessorOnExchangeItemOver;
            _loc1_.OnBtnOut = this.ProcessorOnExchangeItemOut;
            _loc1_.Tip.visible = false;
            this.FUIBoxVect[_loc2_] = _loc1_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < NINJIA_COUNT)
         {
            _loc3_ = this.FMC_Scene["MC_Hero" + _loc2_];
            _loc3_.MC_Tip.visible = false;
            TGameUtil.setButtonMode(_loc3_.BTN_Recruit,true);
            _loc3_.BTN_Recruit.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroUp);
            _loc3_.BTN_Recruit.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnExchangeHeroOver);
            _loc3_.BTN_Recruit.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnExchangeHeroOut);
            TGameUtil.setButtonMode(_loc3_.BTN_ShowDesc,true);
            _loc3_.BTN_ShowDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
            _loc2_++;
         }
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
      
      protected function UpdateText() : void
      {
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventories = null;
         var _loc6_:TBaseBox = null;
         var _loc7_:String = null;
         var _loc8_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < ITEM_COUNT)
         {
            _loc6_ = this.FHallowmas.ExchangeItemVect[_loc1_];
            _loc5_ = _loc6_.Inventories;
            this.FUIBoxVect[_loc1_].UpdateUI(_loc5_);
            this.FUIBoxVect[_loc1_].SetNameText(_loc5_.GetInventoryByIndex(0).Name);
            _loc7_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc6_.Count);
            this.FUIBoxVect[_loc1_].SetDescText(0,_loc7_);
            this.FUIBoxVect[_loc1_].Tip.visible = false;
            if(this.FHallowmas.ExchangeItemVect[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               this.FUIBoxVect[_loc1_].IsBoxGot(false);
               this.FUIBoxVect[_loc1_].SetBtnMode(true);
            }
            else if(this.FHallowmas.ExchangeItemVect[_loc1_].Status == TBaseActivity.STATUS_GETED)
            {
               this.FUIBoxVect[_loc1_].IsBoxGot(true);
            }
            else
            {
               this.FUIBoxVect[_loc1_].IsBoxGot(false);
               this.FUIBoxVect[_loc1_].SetBtnMode(false);
            }
            _loc2_ = 0;
            while(_loc2_ < SWEET_COUNT)
            {
               _loc8_ = this.FUIBoxVect[_loc1_].Tip["MC_Sprite" + _loc2_];
               _loc8_.MC_Icon.stop();
               _loc8_.MC_Icon.MC_Icon.gotoAndStop(_loc2_ + 1);
               _loc8_.TF_Count.text = this.FHallowmas.ExchangeItemVect[_loc1_].ExchangeVect[_loc2_];
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateHero() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TBaseHero = null;
         this.FActive0 = new TActive(this.Parent,this.FHallowmas.NinjiaVect[0].Identify,CONST_MODULES.ACTIVE_Test,false,false);
         if(this.FMC_Scene.MC_Hero0.MC_Hero.numChildren > 0)
         {
            this.FMC_Scene.MC_Hero0.MC_Hero.removeChildAt(0);
         }
         this.FMC_Scene.MC_Hero0.MC_Hero.addChild(this.FActive0);
         this.FActive0.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         this.FActive0.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHeroOut);
         this.FActive1 = new TActive(this.Parent,this.FHallowmas.NinjiaVect[1].Identify,CONST_MODULES.ACTIVE_Test,false,false);
         if(this.FMC_Scene.MC_Hero1.MC_Hero.numChildren > 0)
         {
            this.FMC_Scene.MC_Hero1.MC_Hero.removeChildAt(0);
         }
         this.FMC_Scene.MC_Hero1.MC_Hero.addChild(this.FActive1);
         this.FActive1.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         this.FActive1.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHeroOut);
         _loc1_ = 0;
         while(_loc1_ < NINJIA_COUNT)
         {
            _loc4_ = this.FMC_Scene["MC_Hero" + _loc1_];
            _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.FHallowmas.NinjiaVect[_loc1_].Identify) as TBaseHero;
            _loc4_.TF_Name.text = _loc6_.Name;
            if(this.FHallowmas.NinjiaVect[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               _loc4_.MC_Got.visible = false;
               _loc4_.BTN_Recruit.visible = true;
               TGameUtil.setButtonMode(_loc4_.BTN_Recruit,true);
            }
            else if(this.FHallowmas.NinjiaVect[_loc1_].Status == TBaseActivity.STATUS_GETED)
            {
               _loc4_.MC_Got.visible = true;
               _loc4_.BTN_Recruit.visible = false;
               TGameUtil.setButtonMode(_loc4_.BTN_Recruit,false);
            }
            else
            {
               _loc4_.MC_Got.visible = false;
               _loc4_.BTN_Recruit.visible = true;
               TGameUtil.setButtonMode(_loc4_.BTN_Recruit,false);
            }
            _loc2_ = 0;
            while(_loc2_ < SWEET_COUNT)
            {
               _loc5_ = _loc4_.MC_Tip["MC_Sprite" + _loc2_];
               _loc5_.MC_Icon.stop();
               _loc5_.MC_Icon.MC_Icon.gotoAndStop(_loc2_ + 1);
               _loc5_.TF_Count.text = this.FHallowmas.NinjiaVect[_loc1_].ExchangeVect[_loc2_];
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         super.LogicsPerform();
         if(this.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < ITEM_COUNT)
            {
               if(this.FUIBoxVect[_loc1_])
               {
                  this.FUIBoxVect[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
            if(this.FActive0)
            {
               this.FActive0.UpdateActive();
            }
            if(this.FActive1)
            {
               this.FActive1.UpdateActive();
            }
         }
      }
      
      private function ProcessorOnClose(param1:MouseEvent) : void
      {
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp();
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(this,param2);
         }
      }
      
      protected function ProcessorOnBuyUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBeClicked)
         {
            return;
         }
         if(this.FOnGetBox != null)
         {
            this.FBeClicked = true;
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
            this.FOnGetBox(_loc2_);
         }
      }
      
      protected function ProcessorOnHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBeClicked)
         {
            return;
         }
         if(this.FOnGetHero != null)
         {
            this.FBeClicked = true;
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
            this.FOnGetHero(_loc2_);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FOnNinjiaOver != null)
         {
            _loc2_ = int(String(param1.currentTarget.parent.parent.name).slice(7));
            this.FOnNinjiaOver(_loc2_);
         }
      }
      
      protected function ProcessorOnHeroOut(param1:MouseEvent) : void
      {
         if(this.FOnNinjiaOut != null)
         {
            this.FOnNinjiaOut();
         }
      }
      
      protected function ProcessorOnExchangeHeroOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         this.FMC_Scene["MC_Hero" + _loc2_].MC_Tip.visible = true;
      }
      
      protected function ProcessorOnExchangeHeroOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         this.FMC_Scene["MC_Hero" + _loc2_].MC_Tip.visible = false;
      }
      
      protected function ProcessorOnExchangeItemOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         this.FMC_Scene["MC_Item" + _loc2_].MC_Tip.visible = true;
      }
      
      protected function ProcessorOnExchangeItemOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         this.FMC_Scene["MC_Item" + _loc2_].MC_Tip.visible = false;
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FOnShowRecruit != null)
         {
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
            this.FOnShowRecruit(_loc2_);
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
      
      public function get TipOnOver() : Function
      {
         return this.FTipOnOver;
      }
      
      public function set TipOnOver(param1:Function) : void
      {
         this.FTipOnOver = param1;
      }
      
      public function get TipOnOut() : Function
      {
         return this.FTipOnOut;
      }
      
      public function set TipOnOut(param1:Function) : void
      {
         this.FTipOnOut = param1;
      }
      
      public function get OnGetBox() : Function
      {
         return this.FOnGetBox;
      }
      
      public function set OnGetBox(param1:Function) : void
      {
         this.FOnGetBox = param1;
      }
      
      public function get OnGetHero() : Function
      {
         return this.FOnGetHero;
      }
      
      public function set OnGetHero(param1:Function) : void
      {
         this.FOnGetHero = param1;
      }
      
      public function get OnNinjiaOver() : Function
      {
         return this.FOnNinjiaOver;
      }
      
      public function set OnNinjiaOver(param1:Function) : void
      {
         this.FOnNinjiaOver = param1;
      }
      
      public function get OnNinjiaOut() : Function
      {
         return this.FOnNinjiaOut;
      }
      
      public function set OnNinjiaOut(param1:Function) : void
      {
         this.FOnNinjiaOut = param1;
      }
      
      public function get OnShowRecruit() : Function
      {
         return this.FOnShowRecruit;
      }
      
      public function set OnShowRecruit(param1:Function) : void
      {
         this.FOnShowRecruit = param1;
      }
      
      public function get BeClicked() : Boolean
      {
         return this.FBeClicked;
      }
      
      public function set BeClicked(param1:Boolean) : void
      {
         this.FBeClicked = param1;
      }
      
      public function UpdateUI() : void
      {
         this.FHallowmas.CheckBoxStatus();
         this.UpdateText();
         this.UpdateBox();
         this.UpdateHero();
      }
   }
}

