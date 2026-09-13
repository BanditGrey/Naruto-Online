package Processors.Game.Lobby.Exercise.NinjaTreasure.Compoents
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Exercise.NinjaTreasure.TNinjaTreasure6;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.NinjaTreasure.TProcessorNinjaTreasure;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class TUINinjaTreasure6 extends TUIBaseWindow
   {
      
      protected static const GET_COUNT:int = 10;
      
      protected static const BOX_COUNT:int = 4;
      
      protected static const SWEET_COUNT:int = 5;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      public static const ACTIVITY_3_DROP_ITEM_INDEX:int = 15;
      
      public static const ACTIVITY_4_DROP_ITEM_INDEX:int = 16;
      
      protected var FNinjaTreasure6:TNinjaTreasure6;
      
      protected var FSweetList:Vector.<MovieClip>;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FCurTimes:int;
      
      public function TUINinjaTreasure6(param1:TUIComponent)
      {
         super(param1);
         this.FSweetList = new Vector.<MovieClip>(SWEET_COUNT);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIBaseBox = null;
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
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene["MC_Box" + _loc2_];
            this.FBoxList[_loc2_].MC_BoxPic.gotoAndStop(_loc2_ + 1);
            TGameUtil.setButtonMode(this.FBoxList[_loc2_].BTN_Exchange,true);
            this.FBoxList[_loc2_].BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnBoxUp);
            this.FBoxList[_loc2_].MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc2_].MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_HeroDesc,true);
         FMC_Scene.BTN_HeroDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroUp);
         FMC_Scene.MC_HeroTip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         FMC_Scene.MC_HeroTip.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLogUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetHeroUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_TenGet,true);
         FMC_Scene.BTN_TenGet.addEventListener(MouseEvent.CLICK,this.ProcessorOnTenUp);
         FMC_Scene.BTN_TenGet.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTenOver);
         FMC_Scene.BTN_TenGet.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
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
            if(_loc1_ < this.FNinjaTreasure6.SweetList.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.FNinjaTreasure6.SweetList[_loc1_];
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
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(_loc1_ < this.FNinjaTreasure6.BoxList.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.FNinjaTreasure6.BoxList[_loc1_];
               _loc3_.TF_Count.text = "*" + this.FNinjaTreasure6.BoxList[_loc1_].Price;
               _loc3_.TF_limitCount.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc4_.LimitCount);
               if(this.FNinjaTreasure6.Score >= _loc4_.Price && _loc4_.LimitCount > 0)
               {
                  TGameUtil.setButtonMode(_loc3_.BTN_Exchange,true);
               }
               else
               {
                  TGameUtil.setButtonMode(_loc3_.BTN_Exchange,false);
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateHero() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         if(this.FNinjaTreasure6.HeroList[0].Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Got.visible = true;
            FMC_Scene.BTN_Exchange.visible = false;
         }
         else
         {
            FMC_Scene.MC_Got.visible = false;
            FMC_Scene.BTN_Exchange.visible = true;
            if(this.FNinjaTreasure6.Score >= this.FNinjaTreasure6.HeroList[0].Price)
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
         var _loc1_:int = 0;
         var _loc2_:TInventories = null;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FNinjaTreasure6.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FNinjaTreasure6.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FNinjaTreasure6.DescListNew[1];
         FMC_Scene.TF_Times.text = TUtilityString.Format(this.FNinjaTreasure6.DescListNew[2],this.FNinjaTreasure6.Count);
         FMC_Scene.TF_Count.text = this.FNinjaTreasure6.Score.toString();
         FMC_Scene.TF_Price.text = this.FNinjaTreasure6.HeroList[0].Price.toString();
      }
      
      protected function ProcessorOnSweetUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(_loc2_ >= this.FNinjaTreasure6.SweetList.length || this.FNinjaTreasure6.SweetList[_loc2_].Status != TBaseActivity.STATUS_CANGET || FIsPlaying)
         {
            return;
         }
         FMC_Scene.MC_Click.visible = false;
         if(FOnBuyBox != null)
         {
            _loc3_ = this.FNinjaTreasure6.SweetList[_loc2_];
            if(this.FNinjaTreasure6.Count > 0)
            {
               FOnBuyBox(ACTIVITY_4_ID,TProcessorNinjaTreasure.ACTIVITY_4_GET_SWEET,_loc3_.Price,_loc2_ + 1,TBaseActivity.SWEET_TYPE_FREE);
            }
            else
            {
               FOnBuyBox(ACTIVITY_4_ID,TProcessorNinjaTreasure.ACTIVITY_4_GET_SWEET,_loc3_.Price,_loc2_ + 1,TBaseActivity.SWEET_TYPE_GOLD);
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
            FOnBuyBox(ACTIVITY_4_ID,TProcessorNinjaTreasure.ACTIVITY_4_GET_TEN,this.FNinjaTreasure6.TenPrice,0,TBaseActivity.SWEET_TYPE_GOLD);
         }
      }
      
      protected function ProcessorOnTenOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FNinjaTreasure6) && this.FNinjaTreasure6.DescList.length >= 5)
         {
            FOnShowHtmlTip(this.FNinjaTreasure6.DescListNew[4]);
         }
      }
      
      protected function ProcessorOnSweetOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FNinjaTreasure6) && _loc2_ < this.FNinjaTreasure6.SweetList.length)
         {
            _loc3_ = this.FNinjaTreasure6.SweetList[_loc2_].Desc1;
            FOnShowHtmlTip(_loc3_);
         }
      }
      
      protected function ProcessorOnBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(FOnGetBox != null) && Boolean(this.FNinjaTreasure6) && _loc2_ < this.FNinjaTreasure6.BoxList.length)
         {
            if(this.FNinjaTreasure6.BoxList[_loc2_].LimitCount > 0)
            {
               FOnGetBox(ACTIVITY_4_ID,TProcessorNinjaTreasure.ACTIVITY_4_GET_BOX,_loc2_ + 1);
            }
            else
            {
               FOnShowFlowText(this.FNinjaTreasure6.DescListNew[3]);
            }
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(FOnItemOver != null) && Boolean(this.FNinjaTreasure6) && _loc3_ < this.FNinjaTreasure6.BoxList.length)
         {
            _loc2_ = this.FNinjaTreasure6.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOver(this,_loc2_);
         }
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(FOnItemOut != null) && Boolean(this.FNinjaTreasure6) && _loc3_ < this.FNinjaTreasure6.BoxList.length)
         {
            _loc2_ = this.FNinjaTreasure6.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOut(this,_loc2_);
         }
      }
      
      protected function ProcessorOnGetHeroUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(Boolean(FOnGetBox != null) && Boolean(this.FNinjaTreasure6) && Boolean(this.FNinjaTreasure6.HeroList[0]))
         {
            if(this.FNinjaTreasure6.HeroList[0].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_4_ID,TProcessorNinjaTreasure.ACTIVITY_4_GET_HERO,1);
            }
         }
      }
      
      protected function ProcessorOnHeroUp(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FNinjaTreasure6) && Boolean(this.FNinjaTreasure6.HeroList[0]))
         {
            FOnShowRecruit(this.FNinjaTreasure6.HeroList[0].Identify);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FNinjaTreasure6) && Boolean(this.FNinjaTreasure6.HeroList[0]))
         {
            FOnShowHtmlTip(this.FNinjaTreasure6.HeroList[0].Desc1);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function ProcessorOnLogUp(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_4_ID);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         if(FInitialized && this.visible)
         {
            if(!this.FNinjaTreasure6)
            {
            }
            if(FIsPlaying)
            {
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FNinjaTreasure6 = SLogicsCore.NinjaTreasureDatas.GetActivityByIdentify(ACTIVITY_4_ID) as TNinjaTreasure6;
         this.UpdateSweet();
         this.UpdateBox();
         this.UpdateHero();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         var _loc7_:String = null;
         var _loc8_:TConfigValue = null;
         var _loc9_:Vector.<Object> = null;
         _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.DROP_ITEM_NAME) as TConfigValue;
         _loc9_ = _loc8_.Value as Vector.<Object>;
         FIsPlaying = true;
         TGameUtil.setButtonMode(FMC_Scene.BTN_TenGet,false);
         _loc5_ = int(this.FNinjaTreasure6.StatusList.length);
         if(_loc5_ > 0)
         {
            _loc3_ = this.FNinjaTreasure6.IndexList[0] - 1;
            this.FNinjaTreasure6.SweetList[_loc3_].Status = this.FNinjaTreasure6.StatusList[0];
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
               this.FNinjaTreasure6.SweetList[_loc4_].Status = TBaseActivity.STATUS_CANNOTGET;
            }
            if(this.FNinjaTreasure6.Amount1List[0] > 0)
            {
               this.FNinjaTreasure6.Score += this.FNinjaTreasure6.Amount1List[0];
               _loc7_ += _loc9_[ACTIVITY_4_DROP_ITEM_INDEX] + "*" + this.FNinjaTreasure6.Amount1List[0] + "\n";
               if(this.FNinjaTreasure6.HeroList[0].Status == TBaseActivity.STATUS_CANNOTGET && this.FNinjaTreasure6.Score >= this.FNinjaTreasure6.HeroList[0].Price)
               {
                  this.FNinjaTreasure6.HeroList[0].Status = TBaseActivity.STATUS_CANGET;
               }
            }
            if(this.FNinjaTreasure6.Amount2List[0] > 0)
            {
               _loc7_ += _loc9_[ACTIVITY_3_DROP_ITEM_INDEX] + "*" + this.FNinjaTreasure6.Amount2List[0] + "\n";
            }
            if(FOnShowFlowText != null)
            {
               FOnShowFlowText(_loc7_);
            }
            this.UpdateUI();
            this.FNinjaTreasure6.StatusList.shift();
            this.FNinjaTreasure6.IndexList.shift();
            this.FNinjaTreasure6.Amount1List.shift();
            this.FNinjaTreasure6.Amount2List.shift();
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
         var _loc1_:String = null;
         var _loc2_:TInventory = null;
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
      }
      
      override public function Unmount() : void
      {
      }
   }
}

