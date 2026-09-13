package Processors.Game.Lobby.Exercise.DecActive.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.DecActive.TDecActive1;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.DecActive.TProcessorDecActive;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIDecActive1 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 3;
      
      protected static const LOTTERY_COUNT:int = 10;
      
      protected static const INVESTMENT_TYPE:int = 3;
      
      protected static const INVESTMENT_COUNT:int = 3;
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected static const MOVIE_OF_LOTTERY:int = 0;
      
      protected var FDecActive1:TDecActive1;
      
      protected var FIsFirst:Boolean;
      
      protected var FLotteryItem:TUIShowItem;
      
      protected var FInvestedItem:TUIShowItem;
      
      protected var FInvestment:Vector.<TUIShowItem>;
      
      protected var FOriginScaleX:Number;
      
      protected var FOriginScaleY:Number;
      
      public function TUIDecActive1(param1:TUIComponent)
      {
         super(param1);
         this.FIsFirst = true;
         this.FInvestment = new Vector.<TUIShowItem>(INVESTMENT_TYPE);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         var _loc5_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         this.FLotteryItem = new TUIShowItem(this,LOTTERY_COUNT);
         this.FLotteryItem.Perform_UIDispatch(FMC_Scene.MC_LotteryItems);
         this.FLotteryItem.OnOverlay = this.ProcessorOnItemOver;
         this.FLotteryItem.OnOut = this.ProcessorOnItemOut;
         this.FLotteryItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FInvestedItem = new TUIShowItem(this,INVESTMENT_COUNT);
         this.FInvestedItem.Perform_UIDispatch(FMC_Scene.MC_Invested.MC_Item.MC_Items);
         this.FInvestedItem.OnOverlay = this.ProcessorOnItemOver;
         this.FInvestedItem.OnOut = this.ProcessorOnItemOut;
         this.FInvestedItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         _loc2_ = 0;
         while(_loc2_ < INVESTMENT_TYPE)
         {
            _loc4_ = new TUIShowItem(this,INVESTMENT_COUNT);
            _loc4_.Perform_UIDispatch(FMC_Scene["MC_Item" + _loc2_].MC_Items);
            _loc4_.OnOverlay = this.ProcessorOnItemOver;
            _loc4_.OnOut = this.ProcessorOnItemOut;
            _loc4_.OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FInvestment[_loc2_] = _loc4_;
            TGameUtil.setButtonMode(FMC_Scene["MC_Item" + _loc2_].BTN_Buy,true);
            FMC_Scene["MC_Item" + _loc2_].BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnInvestUp);
            FMC_Scene["MC_Item" + _loc2_].addEventListener(MouseEvent.ROLL_OVER,this.ProcessorOnInvestOver);
            FMC_Scene["MC_Item" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnInvestOut);
            this.FOriginScaleX = FMC_Scene["MC_Item" + _loc2_].scaleX;
            this.FOriginScaleY = FMC_Scene["MC_Item" + _loc2_].scaleY;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            _loc5_ = FMC_Scene["MC_Box" + _loc2_];
            _loc5_.MC_BoxPic.gotoAndStop(_loc2_ + 1);
            _loc5_.MC_BoxPic.buttonMode = true;
            _loc5_.MC_BoxPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnLotteryBoxUp);
            _loc5_.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnLotteryBoxOver);
            _loc5_.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.MC_DailyBox.addEventListener(MouseEvent.CLICK,this.ProcessorOnDailyBoxUp);
         FMC_Scene.MC_DailyBox.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnDailyBoxOver);
         FMC_Scene.MC_DailyBox.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         TGameUtil.setButtonMode(FMC_Scene.Btn_Lottery,true);
         FMC_Scene.Btn_Lottery.addEventListener(MouseEvent.CLICK,this.ProcessorOnLotteryUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         FMC_Scene.MC_Invested.visible = false;
      }
      
      protected function UpdateDailyBox() : void
      {
         var _loc1_:TBaseBox = null;
         _loc1_ = this.FDecActive1.DailyBox;
         if(_loc1_.Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_DailyBox.MC_BoxPic.gotoAndPlay(1);
            FMC_Scene.MC_TodayEnd.visible = false;
         }
         else
         {
            FMC_Scene.MC_DailyBox.MC_BoxPic.gotoAndStop(1);
            FMC_Scene.MC_TodayEnd.visible = true;
         }
      }
      
      protected function UpdateLotteryItems() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < LOTTERY_COUNT)
         {
            FMC_Scene["MC_Fire" + _loc1_].visible = false;
            _loc1_++;
         }
         this.FLotteryItem.UpdateUI(this.FDecActive1.LotteryItems);
         if(this.FDecActive1.LotteryCount > 0)
         {
            TGameUtil.setButtonMode(FMC_Scene.Btn_Lottery,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.Btn_Lottery,false);
         }
      }
      
      protected function UpdateBoxList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Box" + _loc1_];
            _loc3_ = this.FDecActive1.BoxList[_loc1_];
            _loc2_.TF_Desc.text = TUtilityString.Format(this.FDecActive1.DescListNew[3],_loc3_.Price);
            if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc2_.MC_Click.visible = false;
               _loc2_.MC_Got.visible = false;
            }
            else if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc2_.MC_Click.visible = true;
               _loc2_.MC_Got.visible = false;
            }
            else
            {
               _loc2_.MC_Click.visible = false;
               _loc2_.MC_Got.visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateInvestment() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:MovieClip = null;
         if(this.FDecActive1.InvestIndex == -1)
         {
            FMC_Scene.MC_Invested.visible = false;
         }
         else
         {
            _loc1_ = this.FDecActive1.InvestIndex;
            FMC_Scene.MC_Invested.visible = true;
            _loc3_ = FMC_Scene.MC_Invested.MC_Item;
            _loc2_ = this.FDecActive1.Investment[_loc1_];
            _loc3_.TF_Desc.text = _loc2_.Desc1;
            _loc3_.TF_Gold.text = TUtilityString.Format(this.FDecActive1.DescListNew[4],_loc2_.Count);
            this.FInvestedItem.UpdateUI(_loc2_.Inventories);
         }
         _loc1_ = 0;
         while(_loc1_ < INVESTMENT_TYPE)
         {
            _loc3_ = FMC_Scene["MC_Item" + _loc1_];
            _loc2_ = this.FDecActive1.Investment[_loc1_];
            _loc3_.TF_Desc.text = _loc2_.Desc1;
            _loc3_.TF_Price.text = _loc2_.Price;
            _loc3_.TF_Gold.text = TUtilityString.Format(this.FDecActive1.DescListNew[4],_loc2_.Count);
            this.FInvestment[_loc1_].UpdateUI(_loc2_.Inventories);
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:String = null;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FDecActive1.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FDecActive1.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FDecActive1.DescListNew[1];
         _loc1_ = this.FDecActive1.DescListNew[2].split("%n").join("\n");
         FMC_Scene.TF_LoginDay.text = TUtilityString.Format(_loc1_,this.FDecActive1.DailyBox.Count);
         FMC_Scene.TF_LotteryCount.text = this.FDecActive1.LotteryCount.toString();
         FMC_Scene.TF_Count.text = this.FDecActive1.Count.toString();
         FMC_Scene.TF_Desc2.text = this.FDecActive1.DescListNew[5];
         FMC_Scene.TF_Desc3.text = this.FDecActive1.DescListNew[6];
      }
      
      protected function ProcessorOnDailyBoxUp(param1:MouseEvent) : void
      {
         if(Boolean(FOnGetBox != null && !FIsPlaying) && Boolean(this.FDecActive1) && Boolean(this.FDecActive1.DailyBox))
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorDecActive.ACTIVITY_1_GET_DAILY_BOX);
         }
      }
      
      protected function ProcessorOnLotteryUp(param1:MouseEvent) : void
      {
         if(Boolean(FOnGetBox != null && !FIsPlaying) && Boolean(this.FDecActive1) && this.FDecActive1.LotteryCount > 0)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorDecActive.ACTIVITY_1_LOTTERY);
         }
      }
      
      protected function ProcessorOnLotteryBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(FOnGetBox != null && !FIsPlaying && this.FDecActive1) && Boolean(_loc2_ < this.FDecActive1.BoxList.length) && this.FDecActive1.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorDecActive.ACTIVITY_1_GET_LOTTERY_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnInvestUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnBuyBox != null && !FIsPlaying) && Boolean(this.FDecActive1) && _loc2_ < this.FDecActive1.Investment.length)
         {
            _loc3_ = this.FDecActive1.Investment[_loc2_].Price;
            _loc4_ = TUtilityString.Format(this.FDecActive1.DescListNew[7],_loc3_);
            FOnBuyBox(ACTIVITY_1_ID,TProcessorDecActive.ACTIVITY_1_BUY_INVESTMENT,_loc3_,_loc2_ + 1,0,_loc4_);
         }
      }
      
      protected function ProcessorOnInvestOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(this.FDecActive1) && this.FDecActive1.InvestIndex == -1)
         {
            _loc2_ = 0;
            while(_loc2_ < INVESTMENT_TYPE)
            {
               FMC_Scene["MC_Item" + _loc2_].alpha = 0.5;
               FMC_Scene["MC_Item" + _loc2_].scaleX = this.FOriginScaleX;
               FMC_Scene["MC_Item" + _loc2_].scaleY = this.FOriginScaleY;
               _loc2_++;
            }
            FMC_Scene["MC_Item" + _loc3_].alpha = 1;
            TweenUtil.to(FMC_Scene["MC_Item" + _loc3_],50,{
               "scaleX":this.FOriginScaleX + 0.1,
               "scaleY":this.FOriginScaleY + 0.1
            });
         }
      }
      
      protected function ProcessorOnInvestOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(this.FDecActive1) && this.FDecActive1.InvestIndex == -1)
         {
            _loc2_ = 0;
            while(_loc2_ < INVESTMENT_TYPE)
            {
               FMC_Scene["MC_Item" + _loc2_].alpha = 1;
               FMC_Scene["MC_Item" + _loc2_].scaleX = this.FOriginScaleX;
               FMC_Scene["MC_Item" + _loc2_].scaleY = this.FOriginScaleY;
               _loc2_++;
            }
         }
      }
      
      protected function ProcessorOnDailyBoxOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FDecActive1) && Boolean(this.FDecActive1.DailyBox))
         {
            FOnNewBoxOver(this.FDecActive1.DailyBox.Inventories);
         }
      }
      
      protected function ProcessorOnLotteryBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FDecActive1) && _loc2_ < this.FDecActive1.BoxList.length)
         {
            FOnNewBoxOver(this.FDecActive1.BoxList[_loc2_].Inventories);
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
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank(ACTIVITY_1_ID);
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_1_ID);
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
         var _loc1_:int = 0;
         if(FInitialized && this.visible)
         {
            if(this.FLotteryItem)
            {
               this.FLotteryItem.LogicsPerform();
            }
            if(this.FInvestedItem)
            {
               this.FInvestedItem.LogicsPerform();
            }
            _loc1_ = 0;
            while(_loc1_ < this.FInvestment.length)
            {
               if(this.FInvestment[_loc1_])
               {
                  this.FInvestment[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FDecActive1 = SLogicsCore.DecActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TDecActive1;
         this.UpdateDailyBox();
         this.UpdateLotteryItems();
         this.UpdateBoxList();
         this.UpdateInvestment();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         FIsPlaying = true;
         if(param1 == MOVIE_OF_LOTTERY)
         {
            _loc3_ = 0;
            while(_loc3_ < LOTTERY_COUNT)
            {
               _loc4_ = FMC_Scene["MC_Fire" + _loc3_];
               _loc4_.visible = true;
               _loc4_.alpha = 1;
               _loc4_.gotoAndPlay(1);
               if(_loc3_ == this.FDecActive1.LotteryIndex)
               {
                  TweenUtil.to(_loc4_,3000,{
                     "alpha":1,
                     "onComplete":this.MovieEnd
                  });
               }
               else
               {
                  TweenUtil.to(_loc4_,1500,{"alpha":0});
               }
               _loc3_++;
            }
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:String = null;
         var _loc2_:TInventory = null;
         FIsPlaying = false;
         if(FOnShowFlowText != null)
         {
            _loc1_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
            _loc2_ = this.FDecActive1.LotteryItems.GetInventoryByIndex(this.FDecActive1.LotteryIndex);
            _loc1_ += _loc2_.Name + "*" + _loc2_.Quantity + "\n";
            FOnShowFlowText(_loc1_);
            this.UpdateUI();
         }
      }
      
      override public function Unmount() : void
      {
         var _loc1_:int = 0;
         TweenUtil.removeAllTween();
         FIsPlaying = false;
         _loc1_ = 0;
         while(_loc1_ < INVESTMENT_TYPE)
         {
            FMC_Scene["MC_Item" + _loc1_].alpha = 1;
            FMC_Scene["MC_Item" + _loc1_].scaleX = this.FOriginScaleX;
            FMC_Scene["MC_Item" + _loc1_].scaleY = this.FOriginScaleY;
            _loc1_++;
         }
      }
   }
}

