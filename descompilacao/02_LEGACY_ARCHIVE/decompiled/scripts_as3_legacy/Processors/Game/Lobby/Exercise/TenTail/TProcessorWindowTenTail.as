package Processors.Game.Lobby.Exercise.TenTail
{
   import Foundation.Common.THint;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.FrogWallet.TTenTail;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Rendering.Overlayers.Box.TOverlayerBox;
   import Resources.Constants.CONST_TENTAIL;
   import Resources.Strings.STRING_FROGWALLET;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowTenTail extends TProcessorLobbyWindow
   {
      
      public static const TAIL_COUNT:int = 10;
      
      public static const COLOR_PURPLE:int = 1;
      
      public static const COLOR_GOLD:int = 2;
      
      public static const COLOR_RED:int = 3;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FInitialized:Boolean;
      
      protected var FTenTail:TTenTail;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FTF_Time:TextField;
      
      protected var FTF_Date:TextField;
      
      protected var FTF_Desc1:TextField;
      
      protected var FTF_Desc2:TextField;
      
      protected var FTF_Desc3:TextField;
      
      protected var FTF_Desc4:TextField;
      
      protected var FTF_Finish:TextField;
      
      protected var FMC_Fire:MovieClip;
      
      protected var FHintBoxTip:THint;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FBeClicked:Boolean;
      
      protected var FBoxID:int;
      
      protected var FOnGetReward:Function;
      
      protected var FEffectText:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      public function TProcessorWindowTenTail(param1:TUIComponent)
      {
         super(param1);
         this.FTenTail = SLogicsCore.TenTail;
         this.FBoxList = new Vector.<MovieClip>(TAIL_COUNT);
         this.FHintBoxTip = new THint();
         this.FOverlayerBox = new TOverlayerBox(this.Parent.Parent.Parent);
         this.FOverlayerBox.Visible = false;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         _loc2_ = 0;
         while(_loc2_ < TAIL_COUNT)
         {
            _loc4_ = this.FMC_Scene[CONST_TENTAIL.RESOURCE_LINK_MC_Tail + _loc2_];
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTipOver);
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnTipOut);
            _loc4_.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnGetReward);
            this.FBoxList[_loc2_] = _loc4_;
            _loc2_++;
         }
         this.FTF_Date = this.FMC_Scene[CONST_TENTAIL.RESOURCE_LINK_TF_DATE];
         this.FTF_Desc1 = this.FMC_Scene[CONST_TENTAIL.RESOURCE_LINK_TF_Desc + "1"];
         this.FTF_Desc2 = this.FMC_Scene[CONST_TENTAIL.RESOURCE_LINK_TF_Desc + "2"];
         this.FTF_Desc3 = this.FMC_Scene[CONST_TENTAIL.RESOURCE_LINK_TF_Desc + "3"];
         this.FTF_Desc4 = this.FMC_Scene[CONST_TENTAIL.RESOURCE_LINK_TF_Desc + "4"];
         this.FTF_Finish = this.FMC_Scene["TF_Finish"];
         this.FTF_Finish.visible = false;
         this.FMC_Fire = this.FMC_Scene[CONST_TENTAIL.RESOURCE_LINK_MC_Fire];
         this.FMC_Fire.mouseEnabled = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBox);
      }
      
      protected function UpdateText() : void
      {
         this.FTF_Date.text = TUtilityString.Format(STRING_FROGWALLET.FormatString_TimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FTenTail.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FTenTail.PayEndTime - 1) * 1000)));
         if(this.FTenTail.ActivityDesc2)
         {
            this.FTF_Desc1.htmlText = this.FTenTail.ActivityDesc2;
         }
         this.FTF_Desc2.text = this.FTenTail.GetNextTailDesc();
         this.FTF_Desc3.text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_TOTAL_TAIL,this.FTenTail.CurTenTail);
         this.FTF_Desc4.text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_EXCHANGE_SCALE,this.FTenTail.ExchangeScale);
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = this.FTenTail.GetCurTailIndex();
         _loc1_ = 0;
         while(_loc1_ < TAIL_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            _loc3_.MC_Slot.gotoAndStop(this.FTenTail.RewardColor[_loc1_]);
            if(this.FTenTail.RewardStatus[_loc1_] == -1)
            {
               _loc3_.MC_Slot.MC_Got.visible = false;
               _loc3_.filters = [TGameUtil.GaryColorFilters];
            }
            else if(this.FTenTail.RewardStatus[_loc1_] == 0)
            {
               _loc3_.MC_Slot.MC_Got.visible = false;
               _loc3_.filters = [TGameUtil.highLightFilters];
            }
            else
            {
               _loc3_.MC_Slot.MC_Got.visible = true;
               _loc3_.filters = [];
            }
            _loc3_.TF_Text.text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_MULTI_LINE_SOUL,this.FTenTail.DisplayTenTailConfig[_loc1_]);
            if(_loc1_ == _loc4_)
            {
               _loc3_.MC_Effect.visible = true;
               _loc3_.MC_Effect.gotoAndPlay(1);
               if(this.FTenTail.RewardStatus[_loc1_] == -1)
               {
                  _loc3_.filters = [];
               }
            }
            else
            {
               _loc3_.MC_Effect.visible = false;
               _loc3_.MC_Effect.stop();
            }
            _loc1_++;
         }
         this.FMC_Fire.gotoAndStop(this.FTenTail.FireColor);
         switch(this.FTenTail.FireColor)
         {
            case COLOR_PURPLE:
               this.FMC_Fire["purple"].mouseEnabled = false;
               break;
            case COLOR_GOLD:
               this.FMC_Fire["gold"].mouseEnabled = false;
               break;
            case COLOR_RED:
               this.FMC_Fire["red"].mouseEnabled = false;
         }
      }
      
      protected function ProcessorOnGetReward(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(this.FBeClicked)
         {
            return;
         }
         _loc3_ = param1.currentTarget.name;
         _loc2_ = int(_loc3_.slice(7));
         if(this.FTenTail.RewardStatus[_loc2_] != 0)
         {
            return;
         }
         this.FBoxID = this.FTenTail.RewardID[_loc2_];
         this.FBeClicked = true;
         if(this.FOnGetReward != null)
         {
            this.FOnGetReward(this.FBoxID);
         }
      }
      
      protected function ProcessorOnTipOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         this.FOverlayerBox.Context = null;
         _loc3_ = param1.currentTarget.name;
         if(_loc3_ == "MC_Fire")
         {
            _loc2_ = TAIL_COUNT - 1;
         }
         else
         {
            _loc2_ = int(_loc3_.slice(7));
         }
         this.FOverlayerBox.Context = this.FTenTail.Rewards[_loc2_];
         this.FOverlayerBox.Render(FUICore.MouseCoordinate);
         this.FOverlayerBox.Show();
      }
      
      protected function ProcessorOnTipOut(param1:MouseEvent) : void
      {
         this.FOverlayerBox.Hide();
      }
      
      protected function ProcessorEffectText(param1:String) : void
      {
         if(this.FEffectText != null)
         {
            this.FEffectText(param1);
         }
      }
      
      public function get OnGetReward() : Function
      {
         return this.FOnGetReward;
      }
      
      public function set OnGetReward(param1:Function) : void
      {
         this.FOnGetReward = param1;
      }
      
      public function get EffectText() : Function
      {
         return this.FEffectText;
      }
      
      public function set EffectText(param1:Function) : void
      {
         this.FEffectText = param1;
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
      
      public function get BeClicked() : Boolean
      {
         return this.FBeClicked;
      }
      
      public function set BeClicked(param1:Boolean) : void
      {
         this.FBeClicked = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateBox();
      }
      
      public function GetRewardRet() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:TInventories = null;
         this.FBeClicked = false;
         this.FTenTail.ChangeBoxStatus(this.FBoxID,1,0);
         _loc4_ = this.FTenTail.RewardID.indexOf(this.FBoxID);
         if(_loc4_ == -1)
         {
            return;
         }
         _loc3_ = STRING_FROGWALLET.FORMAT_GET_SUCCESSED;
         _loc5_ = this.FTenTail.Rewards[_loc4_];
         _loc2_ = _loc5_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ += _loc5_.GetInventoryByIndex(_loc1_).Name + "*" + _loc5_.GetInventoryByIndex(_loc1_).Quantity + "\n";
            _loc1_++;
         }
         this.ProcessorEffectText(_loc3_);
         this.UpdateUI();
      }
   }
}

