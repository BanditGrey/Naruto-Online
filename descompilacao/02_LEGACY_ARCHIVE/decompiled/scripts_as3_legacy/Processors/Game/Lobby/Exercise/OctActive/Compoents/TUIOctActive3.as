package Processors.Game.Lobby.Exercise.OctActive.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.OctActive.TOctActive3;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.OctActive.TProcessorOctActive;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIOctActive3 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 8;
      
      protected static const ACTIVITY_3_ID:int = 3;
      
      protected var FOctActive3:TOctActive3;
      
      protected var FBoxList:Vector.<TUIBaseBox>;
      
      public function TUIOctActive3(param1:TUIComponent)
      {
         super(param1);
         this.FBoxList = new Vector.<TUIBaseBox>(BOX_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIBaseBox = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            _loc4_ = new TUIBaseBox(this,1);
            _loc4_.Perform_UIDispatch(FMC_Scene.MC_ExchangeItems["MC_Slot" + _loc2_]);
            _loc4_.OnOverlay = this.SlotsOnOver;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.OnExchangeUp = this.ProcessorOnExchangeUp;
            _loc4_.SetMCIsVisible("MC_Effect",false);
            this.FBoxList[_loc2_] = _loc4_;
            _loc2_++;
         }
         FMC_Scene.MC_Hero.MC_Hero.buttonMode = true;
         TGameUtil.setButtonMode(FMC_Scene.MC_Hero.BTN_HeroDesc,true);
         TGameUtil.setButtonMode(FMC_Scene.MC_Hero.BTN_Exchange,true);
         FMC_Scene.MC_Hero.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeHeroUp);
         FMC_Scene.MC_Hero.BTN_HeroDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroDescUp);
         FMC_Scene.MC_Hero.MC_Hero.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         FMC_Scene.MC_Hero.MC_Hero.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         if(FMC_Scene.BTN_Log)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
            FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         }
         if(FMC_Scene.BTN_Desc)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
            FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         }
         if(FMC_Scene.MC_ScoreTip)
         {
            FMC_Scene.MC_ScoreTip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnScoreTip);
            FMC_Scene.MC_ScoreTip.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUIBaseBox = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:String = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(_loc1_ < this.FOctActive3.ExchangeItems.length)
            {
               _loc3_.SetVisible(true);
               _loc4_ = this.FOctActive3.ExchangeItems[_loc1_];
               _loc3_.UpdateUI(_loc4_.Inventories);
               _loc3_.Identify = _loc1_;
               _loc5_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc4_.LimitCount);
               _loc3_.SetLimitText(_loc5_);
               _loc3_.SetCurPriceText(_loc4_.Price.toString());
               if(_loc4_.LimitCount > 0 && this.FOctActive3.Score >= _loc4_.Price)
               {
                  _loc3_.SetExchangeBtnMode(true);
               }
               else
               {
                  _loc3_.SetExchangeBtnMode(false);
               }
               if(Boolean(_loc4_) && _loc4_.Level > 0)
               {
                  _loc3_.SetMCIsVisible("MC_Fire",true);
               }
               else
               {
                  _loc3_.SetMCIsVisible("MC_Fire",false);
               }
            }
            else
            {
               _loc3_.SetVisible(false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateHero() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TBaseBox = null;
         _loc1_ = FMC_Scene.MC_Hero;
         _loc2_ = this.FOctActive3.Hero;
         _loc1_.TF_Price.text = _loc2_.Price.toString();
         if(_loc2_.Status == TBaseActivity.STATUS_GETED)
         {
            _loc1_.MC_Got.visible = true;
            _loc1_.BTN_Exchange.visible = false;
            TGameUtil.setButtonMode(_loc1_.BTN_Exchange,false);
         }
         else if(this.FOctActive3.Score >= _loc2_.Price)
         {
            _loc1_.MC_Got.visible = false;
            _loc1_.BTN_Exchange.visible = true;
            TGameUtil.setButtonMode(_loc1_.BTN_Exchange,true);
         }
         else
         {
            _loc1_.MC_Got.visible = false;
            _loc1_.BTN_Exchange.visible = true;
            TGameUtil.setButtonMode(_loc1_.BTN_Exchange,false);
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FOctActive3.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FOctActive3.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FOctActive3.DescListNew[1];
         FMC_Scene.TF_Score.text = this.FOctActive3.Score.toString();
      }
      
      protected function ProcessorOnExchangeHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(!param1.currentTarget.buttonMode || FIsPlaying)
         {
            return;
         }
         if(FOnGetBox != null && Boolean(this.FOctActive3))
         {
            _loc2_ = this.FOctActive3.Hero;
            if(_loc2_.Status != TBaseActivity.STATUS_GETED && this.FOctActive3.Score >= _loc2_.Price)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorOctActive.ACTIVITY_3_EXCHANGE_HERO,0);
            }
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent, param2:int) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         param2 = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnGetBox != null && this.FOctActive3 && param2 < this.FOctActive3.ExchangeItems.length) && Boolean(this.FOctActive3.ExchangeItems[param2].LimitCount > 0) && this.FOctActive3.Score >= this.FOctActive3.ExchangeItems[param2].Price)
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorOctActive.ACTIVITY_3_EXCHANGE_ITEM,param2 + 1);
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(this,param2);
         }
      }
      
      protected function ProcessorOnHeroDescUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FOctActive3) && Boolean(this.FOctActive3.Hero))
         {
            _loc2_ = this.FOctActive3.Hero;
            FOnShowRecruit(_loc2_.Identify,_loc2_.Type);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FOctActive3) && this.FOctActive3.DescList.length > 2)
         {
            FOnShowHtmlTip(this.FOctActive3.DescListNew[2]);
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_3_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function ProcessorOnScoreTip(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FOctActive3) && this.FOctActive3.DescList.length > 3)
         {
            FOnShowHtmlTip(this.FOctActive3.DescListNew[3]);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(FInitialized && this.visible)
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
         this.FOctActive3 = SLogicsCore.OctActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TOctActive3;
         this.UpdateBox();
         this.UpdateHero();
         this.UpdateText();
      }
   }
}

