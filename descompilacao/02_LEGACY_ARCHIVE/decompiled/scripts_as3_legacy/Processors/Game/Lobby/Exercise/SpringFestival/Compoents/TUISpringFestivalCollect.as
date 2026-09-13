package Processors.Game.Lobby.Exercise.SpringFestival.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.SpringFestival.TSpringFestivalCollect;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.SpringFestival.TProcessorSpringFestival;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUISpringFestivalCollect extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 4;
      
      protected static const SWEET_COUNT:int = 5;
      
      protected static const HERO_COUNT:int = 5;
      
      protected static const ACTIVITY_4_ID:int = 4;
      
      protected var FSweetList:Vector.<MovieClip>;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FHeroList:Vector.<MovieClip>;
      
      protected var FSpringFestivalCollect:TSpringFestivalCollect;
      
      public function TUISpringFestivalCollect(param1:TUIComponent)
      {
         super(param1);
         this.FSweetList = new Vector.<MovieClip>(SWEET_COUNT);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FHeroList = new Vector.<MovieClip>(HERO_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < SWEET_COUNT)
         {
            this.FSweetList[_loc2_] = FMC_Scene["MC_Sweet" + _loc2_];
            this.FSweetList[_loc2_].buttonMode = true;
            this.FSweetList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnSweetUp);
            this.FSweetList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSweetOver);
            this.FSweetList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnSweetOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene["MC_Box" + _loc2_];
            TGameUtil.setButtonMode(this.FBoxList[_loc2_].BTN_Exchange,true);
            this.FBoxList[_loc2_].BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnBoxUp);
            this.FBoxList[_loc2_].MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc2_].MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_HeroDesc,true);
         FMC_Scene.BTN_HeroDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroUp);
         FMC_Scene.MC_HeroTip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         FMC_Scene.MC_HeroTip.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHeroOut);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetHeroUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
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
            _loc3_.gotoAndStop(_loc1_ + 1);
            if(_loc1_ < this.FSpringFestivalCollect.SweetList.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.FSpringFestivalCollect.SweetList[_loc1_];
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
            if(_loc1_ < this.FSpringFestivalCollect.BoxList.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.FSpringFestivalCollect.BoxList[_loc1_];
               _loc3_.TF_Count.text = "*" + this.FSpringFestivalCollect.BoxList[_loc1_].Price;
               _loc3_.MC_BoxPic.gotoAndStop(_loc1_ + 1);
               if(this.FSpringFestivalCollect.Score >= _loc4_.Price)
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
         if(this.FSpringFestivalCollect.HeroList[0].Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Got.visible = true;
            FMC_Scene.BTN_Exchange.visible = false;
         }
         else
         {
            FMC_Scene.MC_Got.visible = false;
            FMC_Scene.BTN_Exchange.visible = true;
            if(this.FSpringFestivalCollect.Score >= this.FSpringFestivalCollect.HeroList[0].Price)
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
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FSpringFestivalCollect.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FSpringFestivalCollect.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FSpringFestivalCollect.ActivityName;
         FMC_Scene.TF_Times.text = TUtilityString.Format(this.FSpringFestivalCollect.ActivityDesc2,this.FSpringFestivalCollect.Count);
         FMC_Scene.TF_Count.text = this.FSpringFestivalCollect.Score.toString();
         FMC_Scene.TF_Price.text = this.FSpringFestivalCollect.HeroList[0].Price.toString();
      }
      
      protected function ProcessorOnSweetUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(_loc2_ >= this.FSpringFestivalCollect.SweetList.length)
         {
            return;
         }
         if(this.FSpringFestivalCollect.SweetList[_loc2_].Status != TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         if(FOnBuyBox != null)
         {
            _loc3_ = this.FSpringFestivalCollect.SweetList[_loc2_];
            if(this.FSpringFestivalCollect.Count > 0)
            {
               FOnBuyBox(ACTIVITY_4_ID,TProcessorSpringFestival.COLLECT_GET_SWEET,_loc3_.Price,_loc2_ + 1,TBaseActivity.SWEET_TYPE_FREE);
            }
            else
            {
               FOnBuyBox(ACTIVITY_4_ID,TProcessorSpringFestival.COLLECT_GET_SWEET,_loc3_.Price,_loc2_ + 1,TBaseActivity.SWEET_TYPE_GOLD);
            }
         }
      }
      
      protected function ProcessorOnSweetOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(Boolean(FOnShowTip != null) && Boolean(this.FSpringFestivalCollect) && _loc2_ < this.FSpringFestivalCollect.SweetList.length)
         {
            _loc3_ = this.FSpringFestivalCollect.SweetList[_loc2_].Desc1;
            FOnShowTip(_loc3_);
         }
      }
      
      protected function ProcessorOnSweetOut(param1:MouseEvent) : void
      {
         if(FOnHideTip != null)
         {
            FOnHideTip();
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
         if(Boolean(FOnGetBox != null) && Boolean(this.FSpringFestivalCollect) && _loc2_ < this.FSpringFestivalCollect.BoxList.length)
         {
            FOnGetBox(ACTIVITY_4_ID,TProcessorSpringFestival.COLLECT_GET_BOX,_loc2_ + 1);
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(FOnItemOver != null) && Boolean(this.FSpringFestivalCollect) && _loc3_ < this.FSpringFestivalCollect.BoxList.length)
         {
            _loc2_ = this.FSpringFestivalCollect.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOver(this,_loc2_);
         }
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(FOnItemOut != null) && Boolean(this.FSpringFestivalCollect) && _loc3_ < this.FSpringFestivalCollect.BoxList.length)
         {
            _loc2_ = this.FSpringFestivalCollect.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOut(this,_loc2_);
         }
      }
      
      protected function ProcessorOnGetHeroUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(Boolean(FOnGetBox != null) && Boolean(this.FSpringFestivalCollect) && Boolean(this.FSpringFestivalCollect.HeroList[0]))
         {
            if(this.FSpringFestivalCollect.HeroList[0].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_4_ID,TProcessorSpringFestival.COLLECT_GET_HERO,1);
            }
         }
      }
      
      protected function ProcessorOnHeroUp(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FSpringFestivalCollect) && Boolean(this.FSpringFestivalCollect.HeroList[0]))
         {
            FOnShowRecruit(this.FSpringFestivalCollect.HeroList[0].Identify);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHeroTip != null) && Boolean(this.FSpringFestivalCollect) && Boolean(this.FSpringFestivalCollect.HeroList[0]))
         {
            FOnShowHeroTip(this.FSpringFestivalCollect.HeroList[0]);
         }
      }
      
      protected function ProcessorOnHeroOut(param1:MouseEvent) : void
      {
         if(FOnHideHeroTip != null)
         {
            FOnHideHeroTip();
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_4_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc(ACTIVITY_4_ID);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         if(FInitialized && this.visible)
         {
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FSpringFestivalCollect = SLogicsCore.SpringFestivalDatas.GetActivityByIdentify(ACTIVITY_4_ID) as TSpringFestivalCollect;
         this.UpdateSweet();
         this.UpdateBox();
         this.UpdateHero();
         this.UpdateText();
      }
   }
}

