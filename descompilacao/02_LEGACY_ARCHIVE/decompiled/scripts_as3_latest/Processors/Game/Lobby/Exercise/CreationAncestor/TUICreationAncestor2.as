package Processors.Game.Lobby.Exercise.CreationAncestor
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.CreationAncestor.TCreationAncestor;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.FebActive.TProcessorFebActiveShop;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUICreationAncestor2 extends TUIBaseWindow
   {
      
      protected static const ZONE_COUNT:int = 4;
      
      protected static const MAP_COUNT:int = 40;
      
      protected var FCreationAncestor:TCreationAncestor;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      protected var FMovieType:int;
      
      protected var FStartIndex:int;
      
      protected var FEndIndex:int;
      
      public function TUICreationAncestor2(param1:TUIComponent)
      {
         super(param1);
         this.FCreationAncestor = SLogicsCore.CreationAncestor;
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < ZONE_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Zone" + _loc2_];
            _loc4_.buttonMode = true;
            _loc4_.addEventListener(MouseEvent.CLICK,this.ProcessorOnZoneClick);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < MAP_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Chess_" + _loc2_];
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnMapOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.Btn_step,true);
         FMC_Scene.Btn_step.addEventListener(MouseEvent.CLICK,this.ProcessorOnStepClick);
         TGameUtil.setButtonMode(FMC_Scene.Btn_step5,true);
         FMC_Scene.Btn_step5.addEventListener(MouseEvent.CLICK,this.ProcessorOnStep5Click);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
         this.FProcessorFebActiveShop.Visible = false;
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = this.ProcessorOnItemOver;
         this.FProcessorFebActiveShop.OnOut = this.ProcessorOnItemOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorFebActiveShop.X = -174;
         this.FProcessorFebActiveShop.Y = -22;
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Count.text = this.FCreationAncestor.ShopExchangePoint.toString();
         FMC_Scene.TF_Price1.text = this.FCreationAncestor.Price1.toString();
         FMC_Scene.TF_Price5.text = this.FCreationAncestor.Price5.toString();
         FMC_Scene.TF_Recharge.text = this.FCreationAncestor.NeedGold.toString();
         FMC_Scene.TF_FreeSteps.text = this.FCreationAncestor.FreeCount.toString();
      }
      
      protected function UpdateZone() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = this.FCreationAncestor.MapIndex % 10;
         _loc4_ = this.FCreationAncestor.MaxStep / 10;
         _loc1_ = 0;
         while(_loc1_ < ZONE_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Zone" + _loc1_];
            if(_loc1_ < _loc4_)
            {
               _loc2_.gotoAndStop(_loc1_ == _loc4_ ? 2 : 3);
               _loc2_.buttonMode = false;
            }
            else
            {
               _loc2_.gotoAndStop(1);
               _loc2_.buttonMode = true;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAP_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Chess_" + _loc1_];
            _loc2_.TF_Prompt.text = String(_loc1_ + 1);
            if(_loc2_.MC_mv)
            {
               _loc2_.MC_mv.visible = _loc1_ / 10 < _loc4_ ? true : false;
            }
            _loc1_++;
         }
         FMC_Scene.MC_Man.visible = this.FCreationAncestor.MapIndex >= 0 ? true : false;
         FMC_Scene.MC_Man.gotoAndStop(this.FCreationAncestor.MapIndex + 1);
      }
      
      protected function UpdateBtn() : void
      {
         if(this.FCreationAncestor.MapIndex == MAP_COUNT - 1)
         {
            TGameUtil.setButtonMode(FMC_Scene.Btn_step,true);
            TGameUtil.setButtonMode(FMC_Scene.Btn_step5,true);
         }
         else if(this.FCreationAncestor.MapIndex + 1 >= this.FCreationAncestor.MaxStep)
         {
            TGameUtil.setButtonMode(FMC_Scene.Btn_step,false);
            TGameUtil.setButtonMode(FMC_Scene.Btn_step5,false);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.Btn_step,true);
            if(this.FCreationAncestor.MapIndex % 10 >= 5)
            {
               TGameUtil.setButtonMode(FMC_Scene.Btn_step5,false);
            }
            else
            {
               TGameUtil.setButtonMode(FMC_Scene.Btn_step5,true);
            }
         }
      }
      
      protected function ProcessorOnZoneClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(!FIsPlaying && FOnBuyBox != null && Boolean(this.FCreationAncestor))
         {
            _loc3_ = this.FCreationAncestor.OpenGold(_loc2_);
            if(_loc3_ == this.FCreationAncestor.PriceList[_loc2_])
            {
               _loc4_ = TUtilityString.Format(this.FCreationAncestor.DescListNew[5],_loc3_);
            }
            else
            {
               _loc4_ = TUtilityString.Format(this.FCreationAncestor.DescListNew[6],this.FCreationAncestor.PriceList[_loc2_],_loc3_ - this.FCreationAncestor.PriceList[_loc2_],_loc3_);
            }
            FOnBuyBox(TProcessorCreationAncestor.ACTIVE_GAME_REQ,_loc3_,_loc2_ + 1,0,_loc4_);
         }
      }
      
      protected function ProcessorOnStepClick(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!FIsPlaying && FOnBuyBox != null && Boolean(this.FCreationAncestor))
         {
            if(this.FCreationAncestor.FreeCount > 0)
            {
               FOnGetBox(TProcessorCreationAncestor.PLAY_GAME_REQ);
            }
            else
            {
               FOnBuyBox(TProcessorCreationAncestor.PLAY_GAME_REQ,this.FCreationAncestor.Price1);
            }
         }
      }
      
      protected function ProcessorOnStep5Click(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!FIsPlaying && FOnBuyBox != null && Boolean(this.FCreationAncestor))
         {
            if(this.FCreationAncestor.FreeCount >= 5)
            {
               FOnGetBox(TProcessorCreationAncestor.AUTO_GAME_REQ);
            }
            else
            {
               _loc2_ = (5 - this.FCreationAncestor.FreeCount) * this.FCreationAncestor.Price1;
               FOnBuyBox(TProcessorCreationAncestor.AUTO_GAME_REQ,_loc2_);
            }
         }
      }
      
      protected function ProcessorOnMapOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(9));
         if(this.FCreationAncestor)
         {
            if((_loc2_ + 1) % 10 == 0)
            {
               FOnShowHtmlTip(this.FCreationAncestor.DescListNew[4]);
            }
            else
            {
               FOnShowHtmlTip(this.FCreationAncestor.DescListNew[3]);
            }
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FCreationAncestor))
         {
            FOnGetBox(TProcessorCreationAncestor.EXCHANGE_ITEM_REQ,param1 + 1);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI(this.FCreationAncestor);
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorFebActiveShop.Visible = false;
      }
      
      protected function ProcessorOnItemOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(param1,param2);
         }
      }
      
      protected function ProcessorOnItemOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(param1,param2);
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
         var _loc1_:uint = 0;
         if(FInitialized && FMC_Scene.visible && this.Visible)
         {
            if(FIsPlaying)
            {
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateZone();
         this.UpdateBtn();
         if(FIsFirstLoad)
         {
            FIsFirstLoad = false;
            this.FProcessorFebActiveShop.Load();
         }
         if(this.FProcessorFebActiveShop.Visible)
         {
            this.FProcessorFebActiveShop.UpdateUI(this.FCreationAncestor);
         }
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
      }
      
      override public function MovieEnd() : void
      {
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FStartIndex = param1;
         this.FEndIndex = param2;
      }
      
      override public function Unmount() : void
      {
      }
   }
}

