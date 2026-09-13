package Processors.Game.Lobby.Exercise.NationalDay
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.Exercise.NationalDay.TNationalDay;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Battle.Character.TActive;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowNationalDayNinjia extends TProcessorLobbyWindow
   {
      
      public static const STONE_COUNT:int = 5;
      
      public static const NINJIA_COUNT:int = 2;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FTF_Desc:TextField;
      
      protected var FInitialized:Boolean;
      
      protected var FNationalDay:TNationalDay;
      
      protected var FActive0:TActive;
      
      protected var FActive1:TActive;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnGetBox:Function;
      
      protected var FOnGetHero:Function;
      
      protected var FOnNinjiaOver:Function;
      
      protected var FOnNinjiaOut:Function;
      
      protected var FOnShowRecruit:Function;
      
      public function TProcessorWindowNationalDayNinjia(param1:TUIComponent)
      {
         super(param1);
         this.FNationalDay = SLogicsCore.NationalDay;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         this.FMC_Scene = param1;
         _loc2_ = 0;
         while(_loc2_ < STONE_COUNT)
         {
            _loc4_ = this.FMC_Scene["MC_Box" + _loc2_];
            _loc4_.buttonMode = true;
            _loc4_.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBox);
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < NINJIA_COUNT)
         {
            _loc5_ = this.FMC_Scene["MC_Hero" + _loc2_];
            _loc5_.BTN_Recruit.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroUp);
            TGameUtil.setButtonMode(_loc5_.BTN_ShowDesc,true);
            _loc5_.BTN_ShowDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
            _loc2_++;
         }
      }
      
      protected function UpdateText() : void
      {
         this.FMC_Scene["TF_CurTimes"].text = this.FNationalDay.FreeTimes.toString();
         this.FMC_Scene["TF_Count"].text = this.FNationalDay.Stones.toString();
      }
      
      protected function UpdateNinjia() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseHero = null;
         this.FActive0 = new TActive(this.Parent,this.FNationalDay.NinjiaVect[0].Identify,CONST_MODULES.ACTIVE_Test,false,false);
         if(this.FMC_Scene.MC_Hero0.MC_Hero.numChildren > 0)
         {
            this.FMC_Scene.MC_Hero0.MC_Hero.removeChildAt(0);
         }
         this.FMC_Scene.MC_Hero0.MC_Hero.addChild(this.FActive0);
         this.FActive0.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         this.FActive0.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHeroOut);
         this.FActive1 = new TActive(this.Parent,this.FNationalDay.NinjiaVect[1].Identify,CONST_MODULES.ACTIVE_Test,false,false);
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
            _loc3_ = this.FMC_Scene["MC_Hero" + _loc1_];
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.FNationalDay.NinjiaVect[_loc1_].Identify) as TBaseHero;
            _loc3_.TF_Name.text = _loc4_.Name;
            _loc3_.TF_Cost.text = this.FNationalDay.NinjiaVect[_loc1_].Price.toString();
            if(this.FNationalDay.NinjiaVect[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.MC_Got.visible = false;
               TGameUtil.setButtonMode(_loc3_.BTN_Recruit,true);
            }
            else if(this.FNationalDay.NinjiaVect[_loc1_].Status == TBaseActivity.STATUS_GETED)
            {
               _loc3_.MC_Got.visible = true;
               TGameUtil.setButtonMode(_loc3_.BTN_Recruit,false);
            }
            else
            {
               _loc3_.MC_Got.visible = false;
               TGameUtil.setButtonMode(_loc3_.BTN_Recruit,false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < STONE_COUNT)
         {
            _loc4_ = this.FNationalDay.StoneVect[_loc1_];
            _loc3_ = this.FMC_Scene["MC_Box" + _loc1_];
            _loc3_.gotoAndStop(_loc1_ + 1);
            if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.filters = [];
            }
            else
            {
               _loc3_.filters = [TGameUtil.GaryColorFilters];
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorOnGetBox(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(this.FNationalDay.StoneVect[_loc2_].Status != TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         if(this.FOnGetBox != null)
         {
            this.FOnGetBox(_loc2_);
         }
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FOnOverlay != null)
         {
            _loc2_ = int(String(param1.currentTarget.name).slice(6));
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
      
      protected function ProcessorOnHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FOnGetHero != null)
         {
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
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateNinjia();
         this.UpdateBox();
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         this.FMC_Scene.visible = param1;
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         super.LogicsPerform();
         if(this.FInitialized && this.FMC_Scene.visible)
         {
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
   }
}

