package Processors.Game.Lobby.Exercise.ComeBack.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.ComeBack.TComeBack;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.ComeBack.TProcessorComeBack;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIComeBack2 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 5;
      
      protected static const LOTTERY_BOX_COUNT:int = 5;
      
      protected static const CDK_LENGTH:uint = 19;
      
      protected static const LOTTERY_MOVE_LENGTH:int = 254;
      
      protected var FComeBack:TComeBack;
      
      protected var FCDKAward:TUIBaseBox;
      
      protected var FLotteryAward:TUIBaseBox;
      
      protected var FTF_CDK:TextField;
      
      protected var FLotteryIndex:int;
      
      protected var FLotteryDirect:int;
      
      protected var FLotteryInitX:int;
      
      protected var FLotteryEndX:int;
      
      protected var FLotteryCount:int;
      
      protected var FLotteryCurCount:int;
      
      protected var FLotteryTargetX:int;
      
      public function TUIComeBack2(param1:TUIComponent)
      {
         super(param1);
         this.FComeBack = SLogicsCore.ComeBack;
         this.FCDKAward = new TUIBaseBox(this,BOX_COUNT);
         this.FLotteryAward = new TUIBaseBox(this,LOTTERY_BOX_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         this.FCDKAward.Perform_UIDispatch(FMC_Scene["MC_CDK"]);
         this.FCDKAward.OnOverlay = this.ProcessorOnItemOver;
         this.FCDKAward.OnOut = this.ProcessorOnItemOut;
         this.FLotteryAward.Perform_UIDispatch(FMC_Scene["MC_Lottery"]);
         this.FLotteryAward.OnOverlay = this.ProcessorOnItemOver;
         this.FLotteryAward.OnOut = this.ProcessorOnItemOut;
         this.FTF_CDK = FMC_Scene.TF_CDK;
         this.FTF_CDK.restrict = "a-zA-Z0-9\\-";
         this.FTF_CDK.maxChars = CDK_LENGTH;
         this.FTF_CDK.text = "";
         this.FTF_CDK.addEventListener(Event.CHANGE,this.ProcessorOnTextInput,false,0,true);
         FMC_Scene.Btn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnCloseWindow);
         TGameUtil.setButtonMode(FMC_Scene.BTN_NewGet,false);
         FMC_Scene.BTN_NewGet.addEventListener(MouseEvent.CLICK,this.ProcessorOnNewBoxUp);
         FMC_Scene.MC_NewGift.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnNewGiftOver);
         FMC_Scene.MC_NewGift.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         TGameUtil.setButtonMode(FMC_Scene.BTN_OldGet,false);
         FMC_Scene.BTN_OldGet.addEventListener(MouseEvent.CLICK,this.ProcessorOnOldBoxUp);
         FMC_Scene.MC_OldGift.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnOldGiftOver);
         FMC_Scene.MC_OldGift.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Active,false);
         FMC_Scene.BTN_Active.addEventListener(MouseEvent.CLICK,this.ProcessorOnActiveUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Lottery,true);
         FMC_Scene.BTN_Lottery.addEventListener(MouseEvent.CLICK,this.ProcessorOnLotteryUp);
         FMC_Scene.MC_Fire.visible = false;
         this.FLotteryInitX = FMC_Scene.MC_Fire.x;
         this.FLotteryEndX = this.FLotteryInitX + LOTTERY_MOVE_LENGTH;
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         if(this.FComeBack.IsOld == TComeBack.TYPE_OLD_PLAYER_IN_NEW_SERVER)
         {
            _loc4_ = this.FComeBack.OldAward;
            if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
            {
               FMC_Scene.MC_OldGot.visible = false;
               FMC_Scene.BTN_OldGet.visible = true;
               TGameUtil.setButtonMode(FMC_Scene.BTN_OldGet,true);
            }
            else
            {
               FMC_Scene.MC_OldGot.visible = true;
               FMC_Scene.BTN_OldGet.visible = false;
            }
            TGameUtil.setButtonMode(FMC_Scene.BTN_NewGet,false);
            FMC_Scene.MC_NewGot.visible = false;
         }
         else
         {
            _loc4_ = this.FComeBack.NewAward;
            if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
            {
               FMC_Scene.MC_NewGot.visible = false;
               FMC_Scene.BTN_NewGet.visible = true;
               TGameUtil.setButtonMode(FMC_Scene.BTN_NewGet,true);
            }
            else
            {
               FMC_Scene.MC_NewGot.visible = true;
               FMC_Scene.BTN_NewGet.visible = false;
            }
            TGameUtil.setButtonMode(FMC_Scene.BTN_OldGet,false);
            FMC_Scene.MC_OldGot.visible = false;
         }
      }
      
      protected function UpdateCDK() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.FTF_CDK.text = "";
         FMC_Scene.MC_Tag.visible = false;
         this.FCDKAward.UpdateUI(this.FComeBack.CDKAward.Inventories);
         this.FLotteryAward.UpdateUI(this.FComeBack.CDKLotteryAward.Inventories);
         if(this.FComeBack.CDKLotteryAward.Status >= TBaseActivity.STATUS_CANGET)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Lottery,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Lottery,false);
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:String = null;
         var _loc2_:TBaseBox = null;
         FMC_Scene.TF_Data.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FComeBack.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FComeBack.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Text0.text = this.FComeBack.DescListNew[1];
         FMC_Scene.TF_Text1.text = this.FComeBack.DescListNew[2];
         FMC_Scene.TF_Text2.text = this.FComeBack.IsOld == TComeBack.TYPE_OLD_PLAYER_IN_NEW_SERVER ? this.FComeBack.DescListNew[3] : this.FComeBack.DescListNew[4];
         FMC_Scene.TF_Text3.text = this.FComeBack.DescListNew[5];
         FMC_Scene.TF_Text4.text = TUtilityString.Format(this.FComeBack.DescListNew[6],this.FComeBack.CDKLotteryAward.BuyCount);
         _loc2_ = this.FComeBack.CDKLotteryAward;
         _loc1_ = TUtilityString.Format(this.FComeBack.DescListNew[7],_loc2_.Count - _loc2_.BuyCount);
         FMC_Scene.TF_Text5.text = this.FComeBack.CDKLotteryAward.Status >= TBaseActivity.STATUS_CANGET ? "" : _loc1_;
      }
      
      protected function ProcessorOnTextInput(param1:Event) : void
      {
         var _loc2_:String = null;
         _loc2_ = this.FTF_CDK.text;
         this.FTF_CDK.text = _loc2_.toUpperCase();
         if(_loc2_.length == CDK_LENGTH)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Active,true);
            FMC_Scene.MC_Tag.visible = true;
         }
         else
         {
            FMC_Scene.MC_Tag.visible = false;
         }
      }
      
      protected function ProcessorOnActiveUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnActiveUp != null)
         {
            _loc2_ = this.FTF_CDK.text;
            _loc2_ = _loc2_.toUpperCase();
            FOnActiveUp(_loc2_);
         }
      }
      
      protected function ProcessorOnLotteryUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && this.FComeBack.CDKLotteryAward.Status >= TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(TProcessorComeBack.TYPE_LOTTERY_REQ);
            TGameUtil.setButtonMode(FMC_Scene.BTN_Lottery,false);
         }
      }
      
      protected function ProcessorOnNewBoxUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && this.FComeBack.NewAward.Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(TProcessorComeBack.TYPE_GET_NEW_AWARD_REQ);
         }
      }
      
      protected function ProcessorOnOldBoxUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && this.FComeBack.OldAward.Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(TProcessorComeBack.TYPE_GET_OLD_AWARD_REQ);
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
      
      protected function ProcessorOnNewGiftOver(param1:MouseEvent) : void
      {
         if(FOnNewBoxOver != null)
         {
            FOnNewBoxOver(this.FComeBack.NewAward.Inventories);
         }
      }
      
      protected function ProcessorOnOldGiftOver(param1:MouseEvent) : void
      {
         if(FOnNewBoxOver != null)
         {
            FOnNewBoxOver(this.FComeBack.OldAward.Inventories);
         }
      }
      
      protected function ProcessorOnCloseWindow(param1:MouseEvent) : void
      {
         if(FOnCloseWindow != null)
         {
            FOnCloseWindow();
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
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
         if(FInitialized && this.visible)
         {
            if(this.FCDKAward)
            {
               this.FCDKAward.LogicsPerform();
            }
            if(this.FLotteryAward)
            {
               this.FLotteryAward.LogicsPerform();
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateBox();
         this.UpdateCDK();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         this.FLotteryIndex = param1;
         this.FLotteryDirect = 0;
         FMC_Scene.MC_Fire.visible = true;
         FMC_Scene.MC_Fire.x = this.FLotteryInitX;
         this.FLotteryCount = Math.random() * 2 + 4;
         this.FLotteryCurCount = 0;
         this.FLotteryTargetX = this.FLotteryInitX + this.FLotteryIndex * (LOTTERY_MOVE_LENGTH / (LOTTERY_BOX_COUNT - 1));
         this.StartMove();
      }
      
      public function StartMove() : void
      {
         var TargetX:int = 0;
         var EndTween:Function = null;
         EndTween = function():void
         {
            ++FLotteryCurCount;
            if(FLotteryCurCount < FLotteryCount)
            {
               StartMove();
            }
            else
            {
               TweenUtil.to(FMC_Scene.MC_Fire,300,{
                  "x":FLotteryTargetX,
                  "onComplete":MovieEnd
               });
            }
         };
         this.FLotteryDirect = this.FLotteryDirect == 1 ? 0 : 1;
         TweenUtil.to(FMC_Scene.MC_Fire,500,{
            "x":(this.FLotteryDirect == 0 ? this.FLotteryEndX : this.FLotteryInitX),
            "onComplete":EndTween
         });
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:String = null;
         var _loc2_:TInventories = null;
         var _loc3_:TInventory = null;
         _loc2_ = this.FComeBack.CDKLotteryAward.Inventories;
         _loc1_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc3_ = _loc2_.GetInventoryByIndex(this.FLotteryIndex);
         _loc1_ += _loc3_.Name + "*" + _loc3_.Quantity + "\n";
         FOnShowFlowText(_loc1_);
         this.UpdateUI();
      }
   }
}

