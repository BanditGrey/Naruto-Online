package Processors.Game.Lobby.TheWorldTree.BigPanel
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Logics.TheWorldTree.TTheWorldTreeLogicData;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Strings.STRING_THEWORLDTREE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   
   public class TheWorldTree
   {
      
      public static const THREE:int = 3;
      
      public static const TWO:int = 2;
      
      protected var FTMC_CanWuQian:TMC_CanWuQian;
      
      protected var FTMC_CanWuHou:TMC_CanWuHou;
      
      protected var FThisPanel:Sprite = null;
      
      protected var FCurTimer:Timer;
      
      protected var FThreeBuffVector:Vector.<MovieClip>;
      
      protected var FTwoBuffVector:Vector.<MovieClip>;
      
      protected var FBtn_GoToMaoXianPanel:SimpleButton;
      
      protected var FMC_Icon:MovieClip;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FMC_Close:MovieClip = null;
      
      protected var FMC_BackMainScreenBtn:SimpleButton;
      
      protected var FLogicDate:TTheWorldTreeLogicData;
      
      protected var FOnCloseFun:Function;
      
      protected var FUpdateFiveSlot:Function;
      
      protected var FQianBackFunction:Function;
      
      protected var FHouBackFunction:Function;
      
      protected var FPiaoZi:Function;
      
      protected var FBuyExpBtn:Function;
      
      protected var FTongBuTimeFun:Function;
      
      protected var FGoToMaoXianPanelFun:Function;
      
      protected var FTextFormatWhite:TextFormat;
      
      protected var FTextFormatGreen:TextFormat;
      
      protected var FTF_PropertyName1:TextField;
      
      protected var FTF_PropertyName2:TextField;
      
      protected var FBackOverFun:Function;
      
      protected var FBackOutFun:Function;
      
      protected var FBackMoveFun:Function;
      
      public function TheWorldTree(param1:TTheWorldTreeLogicData, param2:TUIComponent)
      {
         super();
         this.FCurTimer = new Timer(1000);
         this.FThreeBuffVector = new Vector.<MovieClip>(THREE);
         this.FTwoBuffVector = new Vector.<MovieClip>(TWO);
         this.FLogicDate = param1;
         this.FTMC_CanWuQian = new TMC_CanWuQian(param1);
         this.FTMC_CanWuQian.UpdateFiveSlot = this.FUpdateFiveSlotF;
         this.FTMC_CanWuQian.BackFunction = this.CanWuQianBackFunction;
         this.FTMC_CanWuHou = new TMC_CanWuHou(param1);
         this.FTMC_CanWuHou.StopCanWuFunc = this.StopCanWuFunc;
         this.FTextFormatWhite = new TextFormat();
         this.FTextFormatWhite.color = 16777215;
         this.FTextFormatGreen = new TextFormat();
         this.FTextFormatGreen.color = 65280;
      }
      
      public function set ThisPanel(param1:Sprite) : void
      {
         this.FThisPanel = param1;
         this.Initilization();
      }
      
      protected function Initilization() : void
      {
         var _loc1_:int = 0;
         this.FTMC_CanWuQian.ThisPanel = this.FThisPanel["MC_CanWuQian"];
         this.FTMC_CanWuHou.ThisPanel = this.FThisPanel["MC_CanWuHou"];
         this.FBtn_GoToMaoXianPanel = this.FThisPanel["Btn_GoToMaoXianPanel"];
         this.FMC_Close = this.FThisPanel["MC_Close"];
         this.FMC_BackMainScreenBtn = this.FTMC_CanWuQian.ThisPanel["MC_BackMainScreenBtn"];
         this.FMC_Icon = this.FThisPanel["MC_Icon"];
         _loc1_ = 0;
         while(_loc1_ < THREE)
         {
            this.FThreeBuffVector[_loc1_] = this.FThisPanel["MC_Three_" + _loc1_];
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < TWO)
         {
            this.FTwoBuffVector[_loc1_] = this.FThisPanel["MC_Two_" + _loc1_];
            _loc1_++;
         }
         this.FTF_PropertyName1 = this.FTwoBuffVector[0]["TF_PropertyName"];
         this.FTF_PropertyName2 = this.FTwoBuffVector[1]["TF_PropertyName"];
      }
      
      public function AddEvent() : void
      {
         var _loc1_:int = 0;
         this.FCurTimer.addEventListener(TimerEvent.TIMER,this.TheTimeKeepsOnTurning);
         this.FBtn_GoToMaoXianPanel.addEventListener(MouseEvent.CLICK,this.GoToMaoXianPanel);
         SimpleButton(this.FMC_Close["BTN_Close"]).addEventListener(MouseEvent.CLICK,this.CloseThisPanel);
         this.FMC_BackMainScreenBtn.addEventListener(MouseEvent.CLICK,this.CloseThisPanel);
         this.FTMC_CanWuQian.AddEvent();
         this.FTMC_CanWuHou.AddEvent();
         _loc1_ = 0;
         while(_loc1_ < TWO)
         {
            MovieClip(this.FTwoBuffVector[_loc1_]["BT_Sell"]).addEventListener(MouseEvent.CLICK,this.SellClick);
            TGameUtil.setButtonMode(MovieClip(this.FTwoBuffVector[_loc1_]["BT_Sell"]),true);
            this.FTwoBuffVector[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.HandleOver);
            this.FTwoBuffVector[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.HandleOut);
            this.FTwoBuffVector[_loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.HandleMove);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < THREE)
         {
            this.FThreeBuffVector[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.HandleOver);
            this.FThreeBuffVector[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.HandleOut);
            this.FThreeBuffVector[_loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.HandleMove);
            _loc1_++;
         }
      }
      
      protected function HandleOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.currentTarget)
         {
            case this.FThreeBuffVector[0]:
               _loc2_ = 0;
               break;
            case this.FThreeBuffVector[1]:
               _loc2_ = 1;
               break;
            case this.FThreeBuffVector[2]:
               _loc2_ = 2;
               break;
            case this.FTwoBuffVector[0]:
               _loc2_ = 3;
               break;
            case this.FTwoBuffVector[1]:
               _loc2_ = 4;
         }
         if(this.FBackOverFun != null)
         {
            this.FBackOverFun(_loc2_);
         }
      }
      
      protected function HandleOut(param1:MouseEvent) : void
      {
         if(this.FBackOutFun != null)
         {
            this.FBackOutFun();
         }
      }
      
      protected function HandleMove(param1:MouseEvent) : void
      {
         if(this.FBackMoveFun != null)
         {
            this.FBackMoveFun();
         }
      }
      
      public function set BackOverFun(param1:Function) : void
      {
         this.FBackOverFun = param1;
      }
      
      public function set BackOutFun(param1:Function) : void
      {
         this.FBackOutFun = param1;
      }
      
      public function set BackMoveFun(param1:Function) : void
      {
         this.FBackMoveFun = param1;
      }
      
      protected function SellClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FTwoBuffVector[0]["BT_Sell"]:
               if(this.FBuyExpBtn != null)
               {
                  this.FBuyExpBtn(1);
                  this.OpenThisPanel();
               }
               break;
            case this.FTwoBuffVector[1]["BT_Sell"]:
               if(this.FBuyExpBtn != null)
               {
                  this.FBuyExpBtn(2);
                  this.OpenThisPanel();
               }
         }
      }
      
      protected function SetVisibel(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < TWO)
         {
            MovieClip(this.FTwoBuffVector[_loc2_]["BT_Sell"]).visible = param1;
            _loc2_++;
         }
      }
      
      public function LogicsPerform() : void
      {
         this.FTMC_CanWuQian.LogicsPerform();
         this.FTMC_CanWuHou.LogicsPerform();
      }
      
      public function NowPlayeEffect() : void
      {
         this.FTMC_CanWuQian.NowPlayeEffect();
      }
      
      public function OpenThisPanel() : void
      {
         if(this.FLogicDate.CurPenetrateState == 1)
         {
            if(this.FLogicDate.OnlineAdditionExpSurplusTimesCopy != 0 || this.FLogicDate.PropsAdditionExpSurplusTimes != 0)
            {
               if(!this.FCurTimer.running)
               {
                  this.FCurTimer.start();
               }
            }
         }
         else if(this.FCurTimer.running)
         {
            this.FCurTimer.reset();
            this.FCurTimer.stop();
         }
         this.WoQu();
      }
      
      protected function GoToMaoXianPanel(param1:MouseEvent) : void
      {
         if(this.FGoToMaoXianPanelFun != null)
         {
            this.FGoToMaoXianPanelFun();
         }
      }
      
      public function CloseThisPanel(param1:MouseEvent) : void
      {
         if(this.FLogicDate.CurPenetrateState == 1)
         {
            this.FPiaoZi(new ConsumeFrameCopy(STRING_THEWORLDTREE.str8).DescribeString);
            return;
         }
         if(this.FOnCloseFun != null)
         {
            this.FOnCloseFun();
         }
         this.FCurTimer.reset();
         this.FCurTimer.stop();
      }
      
      public function UpdateByPenetrateState() : void
      {
         this.FTMC_CanWuQian.ThisPanel.visible = false;
         this.FTMC_CanWuHou.ThisPanel.visible = false;
         switch(this.FLogicDate.CurPenetrateState)
         {
            case 0:
               this.FTMC_CanWuQian.ThisPanel.visible = true;
               this.FTMC_CanWuQian.UpdateView();
               this.SetVisibel(true);
               break;
            case 2:
               this.FTMC_CanWuQian.ThisPanel.visible = true;
               this.FTMC_CanWuQian.UpdateView();
               this.SetVisibel(true);
               this.CanWuQianBackFunction(4);
               break;
            case 1:
               this.FTMC_CanWuQian.UpdateView();
               this.FTMC_CanWuHou.Rest();
               this.FTMC_CanWuHou.ThisPanel.visible = true;
               this.FTMC_CanWuHou.UpdateView();
               this.SetVisibel(false);
         }
      }
      
      public function UpdateView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this.FLogicDate.TheWorldTreeCurLevel / 10;
         if(_loc1_ == 10)
         {
            _loc1_ = 10;
         }
         else
         {
            _loc1_ += 1;
         }
         this.FMC_Icon.gotoAndStop(_loc1_);
         this.FMC_Effect = this.FMC_Icon["MC_Effect"];
         this.FMC_Effect.gotoAndStop(1);
         if(!this.FMC_Effect.hasEventListener(MouseEvent.MOUSE_OVER))
         {
            this.FMC_Effect.addEventListener(MouseEvent.MOUSE_OVER,this.EffectOver);
         }
         if(!this.FMC_Effect.hasEventListener(MouseEvent.MOUSE_OUT))
         {
            this.FMC_Effect.addEventListener(MouseEvent.MOUSE_OUT,this.EffectOut);
         }
         this.UpdateByPenetrateState();
         this.UpdateThreeBuff();
      }
      
      protected function EffectOver(param1:MouseEvent) : void
      {
         param1.currentTarget.gotoAndStop(2);
      }
      
      protected function EffectOut(param1:MouseEvent) : void
      {
         param1.currentTarget.gotoAndStop(1);
      }
      
      protected function WoQu() : void
      {
         var _loc1_:String = null;
         _loc1_ = TGameUtil.fomatTime_NoDay(this.FLogicDate.OnlineAdditionExpSurplusTimesCopy);
         this.FTF_PropertyName1.text = _loc1_;
         if(this.FLogicDate.OnlineAdditionExpSurplusTimesCopy > 0)
         {
            this.FTF_PropertyName1.setTextFormat(this.FTextFormatGreen);
         }
         else
         {
            this.FTF_PropertyName1.setTextFormat(this.FTextFormatWhite);
         }
         _loc1_ = TGameUtil.fomatTime_NoDay(this.FLogicDate.PropsAdditionExpSurplusTimes);
         this.FTF_PropertyName2.text = _loc1_;
         if(this.FLogicDate.PropsAdditionExpSurplusTimes > 0)
         {
            this.FTF_PropertyName2.setTextFormat(this.FTextFormatGreen);
         }
         else
         {
            this.FTF_PropertyName2.setTextFormat(this.FTextFormatWhite);
         }
         if(this.FTongBuTimeFun != null)
         {
            this.FTongBuTimeFun(this.FLogicDate.OnlineAdditionExpSurplusTimesCopy,this.FLogicDate.PropsAdditionExpSurplusTimes,7);
         }
      }
      
      protected function TheTimeKeepsOnTurning(param1:TimerEvent) : void
      {
         var _loc2_:String = null;
         if(this.FLogicDate.OnlineAdditionExpSurplusTimesCopy > 0)
         {
            --this.FLogicDate.OnlineAdditionExpSurplusTimesCopy;
         }
         _loc2_ = TGameUtil.fomatTime_NoDay(this.FLogicDate.OnlineAdditionExpSurplusTimesCopy);
         this.FTF_PropertyName1.text = _loc2_;
         if(this.FLogicDate.OnlineAdditionExpSurplusTimesCopy > 0)
         {
            this.FTF_PropertyName1.setTextFormat(this.FTextFormatGreen);
         }
         else
         {
            this.FTF_PropertyName1.setTextFormat(this.FTextFormatWhite);
         }
         if(this.FLogicDate.PropsAdditionExpSurplusTimes > 0)
         {
            --this.FLogicDate.PropsAdditionExpSurplusTimes;
         }
         _loc2_ = TGameUtil.fomatTime_NoDay(this.FLogicDate.PropsAdditionExpSurplusTimes);
         this.FTF_PropertyName2.text = _loc2_;
         if(this.FLogicDate.PropsAdditionExpSurplusTimes > 0)
         {
            this.FTF_PropertyName2.setTextFormat(this.FTextFormatGreen);
         }
         else
         {
            this.FTF_PropertyName2.setTextFormat(this.FTextFormatWhite);
         }
         if(this.FLogicDate.OnlineAdditionExpSurplusTimesCopy <= 0 && this.FLogicDate.PropsAdditionExpSurplusTimes <= 0)
         {
            this.FTF_PropertyName1.text = "00:00:00";
            this.FTF_PropertyName2.text = "00:00:00";
            this.FCurTimer.reset();
         }
         if(this.FTongBuTimeFun != null)
         {
            this.FTongBuTimeFun(this.FLogicDate.OnlineAdditionExpSurplusTimesCopy,this.FLogicDate.PropsAdditionExpSurplusTimes);
         }
      }
      
      public function set TongBuTimeFun(param1:Function) : void
      {
         this.FTongBuTimeFun = param1;
      }
      
      public function UpdateThreeBuff() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         _loc2_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str1).DescribeString,this.FLogicDate.OnlineBuffPercent / 100);
         TextField(this.FThreeBuffVector[0]["TF_BuffDec"]).text = _loc2_;
         if(SLogicsCore.KaguyaData.CurLevel >= this.FLogicDate.KaguyaPowerPercent.length)
         {
            _loc1_ = this.FLogicDate.KaguyaPowerPercent.length - 1;
         }
         else
         {
            _loc1_ = uint(SLogicsCore.KaguyaData.CurLevel);
         }
         _loc1_ = this.FLogicDate.KaguyaPowerPercent[_loc1_];
         if(SLogicsCore.KaguyaData.IsLongTime == 7)
         {
            _loc1_ = 0;
         }
         this.FLogicDate.KaguyaPowerPercentCopy = _loc1_;
         if(SLogicsCore.KaguyaData.IsLongTime == 7)
         {
            _loc2_ = new ConsumeFrameCopy(STRING_THEWORLDTREE.str42).DescribeString;
         }
         else if(_loc1_ == 0)
         {
            _loc2_ = new ConsumeFrameCopy(STRING_THEWORLDTREE.str2).DescribeString;
         }
         else
         {
            _loc2_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str1).DescribeString,_loc1_ / 100);
         }
         TextField(this.FThreeBuffVector[1]["TF_BuffDec"]).text = _loc2_;
         if(SLogicsCore.KaguyaData.CurLevel + 1 >= this.FLogicDate.KaguyaPowerPercent.length)
         {
            _loc1_ = this.FLogicDate.KaguyaPowerPercent.length - 1;
         }
         else
         {
            _loc1_ = SLogicsCore.KaguyaData.CurLevel + 1;
         }
         _loc1_ = this.FLogicDate.KaguyaPowerPercent[_loc1_];
         this.FLogicDate.KaguyaPowerPercentCopy2 = _loc1_;
         if(SLogicsCore.Character.VipLevel >= this.FLogicDate.VipLevelPercent.length)
         {
            _loc1_ = this.FLogicDate.VipLevelPercent.length - 1;
         }
         else
         {
            _loc1_ = uint(SLogicsCore.Character.VipLevel);
         }
         _loc1_ = this.FLogicDate.VipLevelPercent[_loc1_];
         this.FLogicDate.VipLevelPercentCopy = _loc1_;
         if(_loc1_ == 0)
         {
            _loc2_ = new ConsumeFrameCopy(STRING_THEWORLDTREE.str2).DescribeString;
         }
         else
         {
            _loc2_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str1).DescribeString,_loc1_ / 100);
         }
         TextField(this.FThreeBuffVector[2]["TF_BuffDec"]).text = _loc2_;
         if(SLogicsCore.Character.VipLevel + 1 >= this.FLogicDate.VipLevelPercent.length)
         {
            _loc1_ = this.FLogicDate.VipLevelPercent.length - 1;
         }
         else
         {
            _loc1_ = SLogicsCore.Character.VipLevel + 1;
         }
         _loc1_ = this.FLogicDate.VipLevelPercent[_loc1_];
         this.FLogicDate.VipLevelPercentCopy2 = _loc1_;
      }
      
      public function set HouBackFunction(param1:Function) : void
      {
         this.FHouBackFunction = param1;
      }
      
      protected function StopCanWuFunc() : void
      {
         if(this.FHouBackFunction != null)
         {
            this.FHouBackFunction();
         }
      }
      
      protected function CanWuQianBackFunction(param1:int) : void
      {
         if(this.FQianBackFunction != null)
         {
            this.FQianBackFunction(param1);
         }
      }
      
      public function set QianBackFunction(param1:Function) : void
      {
         this.FQianBackFunction = param1;
      }
      
      public function get MC_Close() : MovieClip
      {
         return this.FMC_Close;
      }
      
      public function get ThisPanel() : Sprite
      {
         return this.FThisPanel;
      }
      
      protected function FUpdateFiveSlotF(param1:TInventories, param2:int) : void
      {
         if(this.FUpdateFiveSlot != null)
         {
            this.FUpdateFiveSlot(param1,param2);
         }
      }
      
      public function set UpdateFiveSlot(param1:Function) : void
      {
         this.FUpdateFiveSlot = param1;
      }
      
      public function set OnCloseFun(param1:Function) : void
      {
         this.FOnCloseFun = param1;
      }
      
      public function set PiaoZi(param1:Function) : void
      {
         this.FPiaoZi = param1;
      }
      
      public function set BuyExpBtn(param1:Function) : void
      {
         this.FBuyExpBtn = param1;
      }
      
      public function set GoToMaoXianPanelFun(param1:Function) : void
      {
         this.FGoToMaoXianPanelFun = param1;
      }
   }
}

