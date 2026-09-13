package Processors.Game.Lobby.Exercise.MoonFestival
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.MoonFestival.TMoonFestival2;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.FebActive.TProcessorFebActiveShop;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class TUIMoonFestival2 extends TUIBaseWindow
   {
      
      protected static const SHOW_ITEM_COUNT:int = 4;
      
      protected static const SWEET_COUNT:int = 5;
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      protected var FMoonFestival2:TMoonFestival2;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      protected var FSweetList:Vector.<MovieClip>;
      
      public function TUIMoonFestival2(param1:TUIComponent)
      {
         super(param1);
         this.FSweetList = new Vector.<MovieClip>(SWEET_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < SWEET_COUNT)
         {
            this.FSweetList[_loc2_] = FMC_Scene["MC_Sweet" + _loc2_];
            this.FSweetList[_loc2_].buttonMode = true;
            this.FSweetList[_loc2_].gotoAndStop(_loc2_ + 1);
            this.FSweetList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnSweetUp);
            this.FSweetList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSweetOver);
            this.FSweetList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc2_++;
         }
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItem);
         this.FShowItem.OnOverlay = this.ProcessorOnItemOver;
         this.FShowItem.OnOut = this.ProcessorOnItemOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
         this.FProcessorFebActiveShop.Visible = false;
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = this.ProcessorOnItemOver;
         this.FProcessorFebActiveShop.OnOut = this.ProcessorOnItemOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorFebActiveShop.X = -230;
         this.FProcessorFebActiveShop.y = -95;
         this.ResourcesPerform_UILocations();
      }
      
      protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Shop,true);
         FMC_Scene.BTN_Shop.addEventListener(MouseEvent.CLICK,this.ProcessorOnShopUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_PetDesc,true);
         FMC_Scene.BTN_PetDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnPetDescUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_TenGet,true);
         FMC_Scene.BTN_TenGet.addEventListener(MouseEvent.CLICK,this.ProcessorOnTenUp);
         FMC_Scene.BTN_TenGet.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTenOver);
         FMC_Scene.BTN_TenGet.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
      }
      
      protected function UpdateShowItem() : void
      {
         this.FShowItem.UpdateUI(this.FMoonFestival2.ShowItems);
      }
      
      protected function UpdateSweet() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < SWEET_COUNT)
         {
            _loc3_ = this.FSweetList[_loc1_];
            if(_loc1_ < this.FMoonFestival2.SweetList.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.FMoonFestival2.SweetList[_loc1_];
               if(_loc4_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc3_.filters = [];
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.filters = [TGameUtil.highLightFilters];
               }
               else
               {
                  _loc3_.filters = [TGameUtil.GaryColorFilters];
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdatePet() : void
      {
         if(this.FMoonFestival2.Pet.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Got.visible = true;
            FMC_Scene.BTN_Exchange.visible = false;
         }
         else
         {
            FMC_Scene.MC_Got.visible = false;
            if(this.FMoonFestival2.ShopExchangePoint >= this.FMoonFestival2.Pet.Price)
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
            }
            else
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,false);
            }
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FMoonFestival2.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FMoonFestival2.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FMoonFestival2.DescListNew[1];
         FMC_Scene.TF_Count.text = this.FMoonFestival2.Count.toString();
         FMC_Scene.TF_Score.text = this.FMoonFestival2.ShopExchangePoint.toString();
         FMC_Scene.TF_Price.text = this.FMoonFestival2.Pet.Price.toString();
      }
      
      protected function ProcessorOnShopUp(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI(this.FMoonFestival2);
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorFebActiveShop.Visible = false;
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(FOnGetBox != null && Boolean(this.FMoonFestival2))
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorMoonFestival.ACTIVITY_2_EXCHANGE_ITEM,param1 + 1);
         }
      }
      
      protected function ProcessorOnSweetUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(_loc2_ >= this.FMoonFestival2.SweetList.length || this.FMoonFestival2.SweetList[_loc2_].Status != TBaseActivity.STATUS_CANGET || FIsPlaying)
         {
            return;
         }
         FMC_Scene.MC_Click.visible = false;
         if(FOnBuyBox != null)
         {
            _loc3_ = this.FMoonFestival2.SweetList[_loc2_];
            if(this.FMoonFestival2.Count > 0)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorMoonFestival.ACTIVITY_2_GET_SWEET,_loc2_ + 1);
            }
            else
            {
               FOnBuyBox(ACTIVITY_2_ID,TProcessorMoonFestival.ACTIVITY_2_GET_SWEET,_loc3_.Price,_loc2_ + 1,TBaseActivity.SWEET_TYPE_GOLD);
            }
         }
      }
      
      protected function ProcessorOnTenUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode || FIsPlaying)
         {
            return;
         }
         if(FOnBuyBox != null)
         {
            FMC_Scene.MC_Click.visible = false;
            FOnBuyBox(ACTIVITY_2_ID,TProcessorMoonFestival.ACTIVITY_2_GET_TEN,this.FMoonFestival2.TenPrice,0,TBaseActivity.SWEET_TYPE_GOLD);
         }
      }
      
      protected function ProcessorOnTenOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FMoonFestival2))
         {
            FOnShowHtmlTip(this.FMoonFestival2.DescListNew[2]);
         }
      }
      
      protected function ProcessorOnSweetOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(FOnShowHtmlTip != null && Boolean(this.FMoonFestival2))
         {
            _loc3_ = this.FMoonFestival2.DescListNew[3 + _loc2_];
            FOnShowHtmlTip(_loc3_);
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && Boolean(this.FMoonFestival2))
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorMoonFestival.ACTIVITY_2_EXCHANGE_PET);
         }
      }
      
      protected function ProcessorOnPetDescUp(param1:MouseEvent) : void
      {
         if(FOnShowRecruit != null && Boolean(this.FMoonFestival2))
         {
            FOnShowRecruit(this.FMoonFestival2.Pet.Identify,this.FMoonFestival2.Pet.Type);
         }
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
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int) : void
      {
         if(FOnShowRecruit != null)
         {
            FOnShowRecruit(param1,param2);
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_2_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         if(FInitialized && this.visible && Boolean(this.FMoonFestival2))
         {
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FMoonFestival2 = SLogicsCore.MoonFestivalDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TMoonFestival2;
         this.UpdateShowItem();
         this.UpdateSweet();
         this.UpdatePet();
         this.UpdateText();
         if(FIsFirstLoad)
         {
            FIsFirstLoad = false;
            this.FProcessorFebActiveShop.Load();
         }
         if(this.FProcessorFebActiveShop.Visible)
         {
            this.FProcessorFebActiveShop.UpdateUI(this.FMoonFestival2);
         }
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         var _loc7_:String = null;
         TGameUtil.setButtonMode(FMC_Scene.BTN_TenGet,false);
         _loc5_ = int(this.FMoonFestival2.StatusList.length);
         if(_loc5_ > 0)
         {
            _loc3_ = this.FMoonFestival2.IndexList[0] - 1;
            this.FMoonFestival2.SweetList[_loc3_].Status = this.FMoonFestival2.StatusList[0];
            _loc7_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
            if(_loc3_ <= 0)
            {
               _loc4_ = 4;
            }
            else
            {
               _loc4_ = _loc3_ - 1;
            }
            if(_loc4_ != 0)
            {
               this.FMoonFestival2.SweetList[_loc4_].Status = TBaseActivity.STATUS_CANNOTGET;
            }
            if(this.FMoonFestival2.AmountList[0] > 0)
            {
               this.FMoonFestival2.ShopExchangePoint += this.FMoonFestival2.AmountList[0];
               _loc7_ += this.FMoonFestival2.DescListNew[8] + "*" + this.FMoonFestival2.AmountList[0] + "\n";
               this.FMoonFestival2.ChangeStatus();
            }
            if(FOnShowFlowText != null)
            {
               FOnShowFlowText(_loc7_);
            }
            this.UpdateUI();
            this.FMoonFestival2.StatusList.shift();
            this.FMoonFestival2.IndexList.shift();
            this.FMoonFestival2.AmountList.shift();
            setTimeout(this.PlayMovie,250);
         }
         else
         {
            FIsPlaying = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_TenGet,true);
         }
      }
      
      override public function MovieEnd() : void
      {
      }
      
      override public function Unmount() : void
      {
      }
   }
}

