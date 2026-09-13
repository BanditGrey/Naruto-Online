package Processors.Game.Lobby.Exercise.Cornucopia
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.Cornucopia.TCornucopia;
   import Logics.Exercise.DecActive.TLotteryLog;
   import Logics.Exercise.DecActive.TLotteryResult;
   import Logics.Exercise.DecActive.TTicketData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerCornucopia;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowEquipDesc;
   import Processors.Game.Lobby.Exercise.FebActive.TProcessorFebActiveShop;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TProcessorCornucopia extends TProcessorBaseActivity
   {
      
      protected static const SHOW_ITEM_COUNT:int = 4;
      
      protected static const LOTTERY_LEVEL:int = 3;
      
      protected static const MOVIE_OF_LOTTERY:int = 0;
      
      protected static const MIN_SCROLL_HEIGHT:Number = 147;
      
      protected static const ITEM_HEIGHT:Number = 22;
      
      public static const ACTIVITY_2_GET_TICKET:int = 1;
      
      public static const ACTIVITY_2_GET_GIFT:int = 2;
      
      public static const WINDOW_SELECTE_NUM:int = 1;
      
      public static const WINDOW_MY_SELECTED:int = 2;
      
      public static const WINDOW_LOTTERY_LOG:int = 3;
      
      public static const WINDOW_EQUIPMENT_DESC_2:int = 5;
      
      public static const WINDOW_EGG_BOOK:int = 6;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FCornucopia:TCornucopia;
      
      protected var FUnstreamizerCornucopia:TUnstreamizerCornucopia;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FWindowType:int;
      
      protected var FStep:int;
      
      protected var FFrameCount:int;
      
      protected var FMoveIndex:int;
      
      protected var FEndIndex:int;
      
      protected var FIsFirst:Boolean;
      
      protected var FIsChanged:Boolean;
      
      protected var FTimeID1:int;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorWindowEquipDesc:TProcessorWindowEquipDesc;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      protected var FProcessorDecActiveSelectNum:TProcessorDecActiveSelectNum;
      
      protected var FProcessorDecActiveMySelected:TProcessorDecActiveMySelected;
      
      protected var FProcessorDecActiveLotteryLog:TProcessorDecActiveLotteryLog;
      
      public function TProcessorCornucopia(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FCornucopia = SLogicsCore.Cornucopia;
         this.FUnstreamizerCornucopia = new TUnstreamizerCornucopia();
         this.FBuyBoxDate = new Object();
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FProcessorWindowEquipDesc = new TProcessorWindowEquipDesc(this.Parent);
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
         this.FProcessorDecActiveSelectNum = new TProcessorDecActiveSelectNum(this.Parent);
         this.FProcessorDecActiveMySelected = new TProcessorDecActiveMySelected(this.Parent);
         this.FProcessorDecActiveLotteryLog = new TProcessorDecActiveLotteryLog(this.Parent);
         this.FIsFirst = true;
         this.FIsChanged = false;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIBaseBox = null;
         super.ResourcesPerform_UIDispatch();
         FTF_Time = FMC_Scene.TF_Time;
         FMC_Scene.MC_Pool.buttonMode = true;
         FMC_Scene.MC_Pool.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGoldOver);
         FMC_Scene.MC_Pool.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem.OnOut = UIComponentsHintOnOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FScrollBar = new TScrollBar(FMC_Scene["MC_List"],MIN_SCROLL_HEIGHT,false,0,0);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnSelectNumUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_MyNum,true);
         FMC_Scene.BTN_MyNum.addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenMyNumUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_LotteryLog,true);
         FMC_Scene.BTN_LotteryLog.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLotteryLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLogUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetGiftUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_BuyBox,true);
         FMC_Scene.BTN_BuyBox.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetGiftUp);
         FMC_Scene.MC_CurResult.visible = false;
         this.FProcessorDecActiveSelectNum.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorDecActiveSelectNum.OnGetBox = this.ProcessorOnGetBoxUp;
         this.FProcessorDecActiveSelectNum.OnShowFlowText = ProcessorEffectText;
         this.FProcessorDecActiveSelectNum.Visible = false;
         this.FProcessorDecActiveMySelected.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorDecActiveMySelected.Visible = false;
         this.FProcessorDecActiveLotteryLog.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorDecActiveLotteryLog.Visible = false;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            if(Boolean(this.FCornucopia) && Boolean(FTF_Time))
            {
               if(this.FCornucopia.GameStatus == TCornucopia.STATUS_BUYING)
               {
                  FTF_Time.text = TGameUtil.fomatTime(this.FCornucopia.NextTime - STimingCore.GetServerTick());
               }
               else if(this.FCornucopia.GameStatus == TCornucopia.STATUS_WAITING)
               {
                  FMC_Scene.MC_Waiting.TF_Time.text = TGameUtil.fomatTime(this.FCornucopia.NextTime - STimingCore.GetServerTick());
               }
               if(this.FShowItem)
               {
                  this.FShowItem.LogicsPerform();
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdatePool();
         this.UpdateResult();
         this.UpdatePlayers();
         this.UpdateItems();
         this.UpdateText();
         this.SetNewInterval();
         switch(this.FWindowType)
         {
            case WINDOW_SELECTE_NUM:
               this.FProcessorDecActiveSelectNum.UpdateUI();
               break;
            case WINDOW_MY_SELECTED:
               this.FProcessorDecActiveMySelected.UpdateUI();
               break;
            case WINDOW_LOTTERY_LOG:
               this.FProcessorDecActiveLotteryLog.UpdateUI();
         }
      }
      
      protected function UpdateItems() : void
      {
         this.FShowItem.UpdateUI(this.FCornucopia.ShowItems);
         if(this.FCornucopia.BoxType == 1)
         {
            FMC_Scene.MC_BoxType.visible = false;
            FMC_Scene.MC_RechargeTip.visible = true;
            FMC_Scene.MC_BoxPrice.visible = false;
            FMC_Scene.BTN_Get.visible = true;
            FMC_Scene.BTN_BuyBox.visible = false;
            FMC_Scene.MC_RechargeTip.TF_BoxPrice.text = this.FCornucopia.RechargeGold % this.FCornucopia.BoxPrice + "/" + this.FCornucopia.BoxPrice;
            if(this.FCornucopia.BoxCount > 0)
            {
               FBTN_Recharge.visible = false;
               FMC_Scene.BTN_Get.visible = true;
               FMC_Scene.MC_CountTip.visible = true;
               FMC_Scene.MC_CountTip.TF_Count.text = this.FCornucopia.BoxCount.toString();
            }
            else
            {
               FBTN_Recharge.visible = true;
               FMC_Scene.BTN_Get.visible = false;
               FMC_Scene.MC_CountTip.visible = false;
            }
         }
         else
         {
            FMC_Scene.MC_BoxType.visible = true;
            FMC_Scene.MC_BoxType.TF_Desc1.text = this.FCornucopia.DescListNew[3];
            FMC_Scene.MC_RechargeTip.visible = false;
            FMC_Scene.MC_BoxPrice.visible = true;
            FBTN_Recharge.visible = false;
            FMC_Scene.MC_CountTip.visible = false;
            FMC_Scene.BTN_Get.visible = false;
            FMC_Scene.BTN_BuyBox.visible = true;
            FMC_Scene.MC_BoxPrice.TF_BoxPrice.text = this.FCornucopia.BoxPrice.toString();
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FCornucopia.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FCornucopia.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FCornucopia.DescListNew[1];
      }
      
      protected function UpdatePool() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         FMC_Scene.MC_Pool.TF_Gold.text = this.FCornucopia.PoolGold.toString();
         FMC_Scene.TF_FreeCount.text = this.FCornucopia.CurCount.toString();
         FMC_Scene.TF_Desc1.text = TUtilityString.Format(this.FCornucopia.DescListNew[14],this.FCornucopia.SelectedCount,this.FCornucopia.MaxCount);
         if(this.FCornucopia.GameStatus == TCornucopia.STATUS_BUYING)
         {
            FMC_Scene.MC_CurResult.visible = false;
            FMC_Scene.MC_Waiting.visible = false;
         }
         else if(this.FCornucopia.GameStatus == TCornucopia.STATUS_WAITING)
         {
            FMC_Scene.MC_CurResult.visible = false;
            FMC_Scene.MC_Waiting.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,false);
         }
         else if(this.FCornucopia.GameStatus == TCornucopia.STATUS_SENDING)
         {
            FMC_Scene.MC_CurResult.visible = true;
            FMC_Scene.MC_Waiting.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,false);
            _loc3_ = "";
            if(this.FCornucopia.CurResults.FirstNumbers.length > 0)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FCornucopia.CurResults.FirstNumbers.length)
               {
                  _loc3_ += String(Number(this.FCornucopia.CurResults.FirstNumbers[_loc1_] / 10000).toFixed(4)).slice(-3) + " ";
                  _loc1_++;
               }
            }
            else
            {
               _loc3_ = this.FCornucopia.DescListNew[11];
            }
            FMC_Scene.MC_CurResult.TF_Num0.text = _loc3_;
            _loc3_ = "";
            if(this.FCornucopia.CurResults.SecondNumbers.length > 0)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FCornucopia.CurResults.SecondNumbers.length)
               {
                  if(_loc1_ < this.FCornucopia.CurResults.SecondNumbers.length - 1)
                  {
                     _loc3_ += String(Number(this.FCornucopia.CurResults.SecondNumbers[_loc1_] / 10000).toFixed(4)).slice(-3) + " | ";
                  }
                  else
                  {
                     _loc3_ += String(Number(this.FCornucopia.CurResults.SecondNumbers[_loc1_] / 10000).toFixed(4)).slice(-3) + " ";
                  }
                  _loc1_++;
               }
            }
            else
            {
               _loc3_ = this.FCornucopia.DescListNew[11];
            }
            FMC_Scene.MC_CurResult.TF_Num1.text = _loc3_;
            _loc3_ = "";
            if(this.FCornucopia.CurResults.ThirdNumbers.length > 0)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FCornucopia.CurResults.ThirdNumbers.length)
               {
                  if(_loc1_ < this.FCornucopia.CurResults.ThirdNumbers.length - 1)
                  {
                     _loc3_ += String(Number(this.FCornucopia.CurResults.ThirdNumbers[_loc1_] / 10000).toFixed(4)).slice(-3) + " | ";
                  }
                  else
                  {
                     _loc3_ += String(Number(this.FCornucopia.CurResults.ThirdNumbers[_loc1_] / 10000).toFixed(4)).slice(-3) + " ";
                  }
                  _loc1_++;
               }
            }
            else
            {
               _loc3_ = this.FCornucopia.DescListNew[11];
            }
            FMC_Scene.MC_CurResult.TF_Num2.text = _loc3_;
         }
      }
      
      protected function UpdateResult() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:TLotteryResult = null;
         var _loc7_:TBaseBox = null;
         _loc3_ = int(this.FCornucopia.Results.length);
         _loc1_ = 0;
         while(_loc1_ < LOTTERY_LEVEL)
         {
            if(_loc1_ < this.FCornucopia.Results.length)
            {
               _loc6_ = this.FCornucopia.Results[_loc1_];
               _loc4_ = int(_loc6_.Numbers.length);
               if(_loc4_ > 0)
               {
                  FMC_Scene["TF_Gold" + _loc1_].text = _loc6_.Gold + STRING_COMMON.ITEMNAME_Gold;
                  _loc5_ = "";
                  _loc2_ = 0;
                  while(_loc2_ < _loc4_)
                  {
                     if(_loc4_ > 1 && _loc2_ < _loc4_ - 1)
                     {
                        _loc5_ += String(Number(_loc6_.Numbers[_loc2_] / 10000).toFixed(4)).slice(-3) + "|";
                     }
                     else
                     {
                        _loc5_ += String(Number(_loc6_.Numbers[_loc2_] / 10000).toFixed(4)).slice(-3) + " ";
                     }
                     _loc2_++;
                  }
                  FMC_Scene["TF_Num" + _loc1_].text = _loc5_;
               }
               else
               {
                  FMC_Scene["TF_Num" + _loc1_].text = this.FCornucopia.DescListNew[11];
                  FMC_Scene["TF_Gold" + _loc1_].text = this.FCornucopia.DescListNew[11];
               }
            }
            else
            {
               FMC_Scene["TF_Gold" + _loc1_].text = this.FCornucopia.DescListNew[11];
               FMC_Scene["TF_Num" + _loc1_].text = this.FCornucopia.DescListNew[11];
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < LOTTERY_LEVEL)
         {
            FMC_Scene["TF_CurGold" + _loc1_].text = this.FCornucopia.GoldList[_loc1_] + STRING_COMMON.ITEMNAME_Gold;
            _loc1_++;
         }
      }
      
      protected function UpdatePlayers() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TextField = null;
         var _loc6_:TextField = null;
         var _loc7_:TLotteryResult = null;
         var _loc8_:* = 0;
         this.FScrollBar.Clear();
         _loc1_ = 0;
         while(_loc1_ < LOTTERY_LEVEL)
         {
            _loc5_ = new TextField();
            _loc5_.mouseEnabled = false;
            _loc5_.autoSize = TextFieldAutoSize.LEFT;
            _loc5_.textColor = 16750899;
            _loc5_.filters = [new GlowFilter(2818048,1,2,2,5)];
            _loc5_.y = _loc8_++ * ITEM_HEIGHT;
            _loc5_.text = this.FCornucopia.DescListNew[4 + _loc1_];
            this.FScrollBar.AddItem(_loc5_);
            if(_loc1_ < this.FCornucopia.Players.length)
            {
               _loc7_ = this.FCornucopia.Players[_loc1_];
               _loc4_ = _loc7_.Players.length;
               if(_loc4_ > 0)
               {
                  _loc2_ = 0;
                  while(_loc2_ < _loc4_)
                  {
                     _loc6_ = new TextField();
                     _loc6_.mouseEnabled = false;
                     _loc6_.autoSize = TextFieldAutoSize.LEFT;
                     _loc6_.textColor = 16776960;
                     _loc6_.filters = [new GlowFilter(2818048,1,2,2,5)];
                     _loc6_.y = _loc8_++ * ITEM_HEIGHT;
                     _loc6_.text = _loc7_.Players[_loc2_];
                     this.FScrollBar.AddItem(_loc6_);
                     _loc2_++;
                  }
               }
               else
               {
                  _loc6_ = new TextField();
                  _loc6_.mouseEnabled = false;
                  _loc6_.autoSize = TextFieldAutoSize.LEFT;
                  _loc6_.textColor = 16776960;
                  _loc6_.filters = [new GlowFilter(2818048,1,2,2,5)];
                  _loc6_.text = this.FCornucopia.DescListNew[11];
                  this.FScrollBar.AddItem(_loc6_);
               }
            }
            else
            {
               _loc6_ = new TextField();
               _loc6_.mouseEnabled = false;
               _loc6_.autoSize = TextFieldAutoSize.LEFT;
               _loc6_.textColor = 16776960;
               _loc6_.filters = [new GlowFilter(2818048,1,2,2,5)];
               _loc6_.text = this.FCornucopia.DescListNew[11];
               this.FScrollBar.AddItem(_loc6_);
            }
            _loc1_++;
         }
      }
      
      protected function SetNewInterval() : void
      {
         var _loc1_:Number = NaN;
         if(this.FTimeID1 != 0)
         {
            clearTimeout(this.FTimeID1);
            this.FTimeID1 = 0;
         }
         _loc1_ = (this.FCornucopia.NextTime - STimingCore.GetServerTick()) * 1000 + 1000;
         if(_loc1_ > 0 && _loc1_ < int.MAX_VALUE)
         {
            this.FTimeID1 = setTimeout(PerformPacket_CS_LoadInfoReq,_loc1_);
         }
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0, param7:int = 0) : void
      {
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxIndex = param3;
         this.FBuyBoxDate.Cost = param2;
         this.FBuyBoxDate.CostType = param4;
         this.FBuyBoxDate.BoxIndex1 = param6;
         this.FBuyBoxDate.ConfirmType = param7;
         if(param4 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = param2;
            if(param5 != "")
            {
               FUIWindowConfirmation.Text = param5;
            }
            else
            {
               FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            }
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGold >= this.FBuyBoxDate.Cost)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc6_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc6_.push(param2);
         }
         if(param3 != 0)
         {
            _loc6_.push(param3);
         }
         PerformPacket_CS_AllReq(param1,_loc6_);
      }
      
      protected function ProcessorOnGetGiftUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FCornucopia.BoxType == 1)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_2_GET_GIFT);
         }
         else
         {
            this.ProcessorOnBuyBoxUp(ACTIVITY_2_GET_GIFT,this.FCornucopia.BoxPrice);
         }
      }
      
      protected function ProcessorOnSelectNumUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         this.ProcessorOnShowWindow(WINDOW_SELECTE_NUM);
      }
      
      protected function ProcessorOnOpenMyNumUp(param1:MouseEvent) : void
      {
         this.ProcessorOnShowWindow(WINDOW_MY_SELECTED);
      }
      
      protected function ProcessorOnLoadLotteryLog(param1:MouseEvent) : void
      {
         this.ProcessorOnShowWindow(WINDOW_LOTTERY_LOG);
      }
      
      protected function ProcessorOnGoldOver(param1:MouseEvent) : void
      {
         ProcessorOnShowHtmlText(this.FCornucopia.DescListNew[2]);
      }
      
      protected function ProcessorOnShowWindow(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         this.FWindowType = param1;
         switch(param1)
         {
            case WINDOW_SELECTE_NUM:
               _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Cornucopia_LoadSelectNumReq);
               break;
            case WINDOW_MY_SELECTED:
               _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Cornucopia_LoadMySelectedReq);
               break;
            case WINDOW_LOTTERY_LOG:
               _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Cornucopia_LoadLotteryLogReq);
         }
         _loc2_.Data.writeUnsignedInt(FActivityID);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnHideWindow(param1:int = 0) : void
      {
         this.FWindowType = 0;
         switch(param1)
         {
            case WINDOW_SELECTE_NUM:
               this.FProcessorDecActiveSelectNum.Visible = false;
               break;
            case WINDOW_MY_SELECTED:
               this.FProcessorDecActiveMySelected.Visible = false;
               break;
            case WINDOW_LOTTERY_LOG:
               this.FProcessorDecActiveLotteryLog.Visible = false;
         }
      }
      
      protected function ProcessorOnLogUp(param1:MouseEvent) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FCornucopia;
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int = 0) : void
      {
         if(param2 == TBaseBox.TYPE_IS_HERO)
         {
            this.FProcessorWindowRecruit.SetHeroData(param1);
         }
         else if(param2 == TBaseBox.TYPE_IS_PET)
         {
            FProcessorWindowPetDesc.SetPetData(param1);
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorDecActiveSelectNum.Load();
            this.FProcessorDecActiveMySelected.Load();
            this.FProcessorDecActiveLotteryLog.Load();
            return;
         }
         this.visible = true;
         this.alpha = 1;
         this.FIsOpen = true;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
         PerformPacket_CS_LoadInfoReq();
         SetInterval();
         this.SetNewInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
      }
      
      public function ProcessorLoadSelectNumRet(param1:TPacket = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc6_:TTicketData = null;
         _loc4_ = param1.Data;
         _loc5_ = _loc4_.readInt();
         if(_loc5_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc5_);
            return;
         }
         this.FCornucopia.MyTickets.length = 0;
         _loc3_ = _loc4_.readShort();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = new TTicketData();
            _loc6_.Num = _loc4_.readUnsignedInt();
            _loc6_.Count = _loc4_.readUnsignedInt();
            this.FCornucopia.MyTickets[_loc2_] = _loc6_;
            _loc2_++;
         }
         if(FIsResourcesLoadCompleted && this.FIsOpen)
         {
            this.FProcessorDecActiveSelectNum.Visible = true;
            this.FProcessorDecActiveSelectNum.UpdateUI();
         }
      }
      
      public function ProcessorLoadMySelectedRet(param1:TPacket = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc6_:TTicketData = null;
         _loc4_ = param1.Data;
         _loc5_ = _loc4_.readInt();
         if(_loc5_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc5_);
            return;
         }
         this.FCornucopia.AllTickets.length = 0;
         _loc3_ = _loc4_.readShort();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = new TTicketData();
            _loc6_.Time = _loc4_.readUnsignedInt();
            _loc6_.Num = _loc4_.readUnsignedInt();
            _loc6_.Count = _loc4_.readUnsignedInt();
            _loc6_.Status = _loc4_.readInt();
            _loc6_.Gold = _loc4_.readUnsignedInt();
            this.FCornucopia.AllTickets[_loc2_] = _loc6_;
            _loc2_++;
         }
         if(FIsResourcesLoadCompleted && this.FIsOpen)
         {
            this.FProcessorDecActiveMySelected.Visible = true;
            this.FProcessorDecActiveMySelected.UpdateUI();
         }
      }
      
      public function ProcessorLoadLotteryLogRet(param1:TPacket = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:ByteArray = null;
         var _loc7_:int = 0;
         var _loc8_:TLotteryLog = null;
         _loc6_ = param1.Data;
         _loc7_ = _loc6_.readInt();
         if(_loc7_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc7_);
            return;
         }
         this.FCornucopia.LotteryLogs.length = 0;
         _loc4_ = _loc6_.readShort();
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc8_ = new TLotteryLog();
            _loc8_.Time = _loc6_.readUnsignedInt();
            _loc5_ = _loc6_.readShort();
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc8_.FirstNumbers.push(_loc6_.readUnsignedInt());
               _loc3_++;
            }
            _loc5_ = _loc6_.readShort();
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc8_.SecondNumbers.push(_loc6_.readUnsignedInt());
               _loc3_++;
            }
            _loc5_ = _loc6_.readShort();
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc8_.ThirdNumbers.push(_loc6_.readUnsignedInt());
               _loc3_++;
            }
            this.FCornucopia.LotteryLogs[_loc2_] = _loc8_;
            _loc2_++;
         }
         if(FIsResourcesLoadCompleted && this.FIsOpen)
         {
            this.FProcessorDecActiveLotteryLog.Visible = true;
            this.FProcessorDecActiveLotteryLog.UpdateUI();
         }
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerCornucopia.Unstreamize(_loc2_,this.FCornucopia,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         if(this.FCornucopia)
         {
            this.FCornucopia.RechargeGold = _loc2_.readUnsignedInt();
            this.FCornucopia.BoxCount = _loc2_.readUnsignedInt();
            this.FCornucopia.MaxCount = _loc2_.readUnsignedInt();
            if(this.FIsOpen)
            {
               this.UpdateUI();
            }
         }
      }
      
      override public function ProcessorActivityThirdLoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         ProcessorUnstreamActivityLog(this.FCornucopia,_loc2_);
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventories = null;
         var _loc9_:TInventory = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:TBaseBox = null;
         var _loc14_:uint = 0;
         var _loc15_:TBins = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc7_)
         {
            case ACTIVITY_2_GET_TICKET:
               _loc17_ = int(_loc2_.readUnsignedInt());
               this.FCornucopia.AddTicket(_loc17_);
               ++this.FCornucopia.SelectedCount;
               --this.FCornucopia.CurCount;
               this.FCornucopia.PoolGold = _loc2_.readUnsignedInt();
               _loc4_ = STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED;
               ProcessorEffectText(_loc4_);
               this.FCornucopia.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FCornucopia.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_2_GET_GIFT:
               this.FCornucopia.PoolGold = _loc2_.readInt();
               this.FCornucopia.CurCount = _loc2_.readInt();
               if(this.FCornucopia.BoxType == 1)
               {
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
                  --this.FCornucopia.BoxCount;
               }
               else
               {
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED;
               }
               ProcessorEffectText(_loc4_);
               this.FCornucopia.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FCornucopia.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function Test() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc3_.writeInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc3_,"描述1");
            _loc3_.writeInt(1);
            _loc3_.writeUnsignedInt(STimingCore.GetServerTime());
            _loc3_.writeInt(1);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(2);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(14);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"奖池金币为玩家选号花费金币总和");
         TUtilityString.FlushUTF(_loc3_,"每充值满100金币可增加1次选号上限");
         TUtilityString.FlushUTF(_loc3_,"一等奖");
         TUtilityString.FlushUTF(_loc3_,"二等奖");
         TUtilityString.FlushUTF(_loc3_,"三等奖");
         TUtilityString.FlushUTF(_loc3_,"已满级");
         TUtilityString.FlushUTF(_loc3_,"未开奖");
         TUtilityString.FlushUTF(_loc3_,"未中奖");
         TUtilityString.FlushUTF(_loc3_,"号码%0*%1次");
         TUtilityString.FlushUTF(_loc3_,"无");
         TUtilityString.FlushUTF(_loc3_,"无");
         TUtilityString.FlushUTF(_loc3_,"无");
         TUtilityString.FlushUTF(_loc3_,"无");
         TUtilityString.FlushUTF(_loc3_,"今日已用选号机会%0/%1次");
         TUtilityString.FlushUTF(_loc3_,"当前没有选号机会");
         TUtilityString.FlushUTF(_loc3_,"无");
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeInt(1);
         _loc3_.writeUnsignedInt(STimingCore.GetServerTick() + 1000);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc3_.writeShort(1);
         _loc1_ = 0;
         while(_loc1_ < 1)
         {
            _loc3_.writeInt(1 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeInt(1 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeInt(1 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(1 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(1 + _loc1_);
            _loc3_.writeShort(1 + _loc1_);
            _loc2_ = 0;
            while(_loc2_ < _loc1_ + 1)
            {
               _loc3_.writeUnsignedInt(1 + _loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeShort(3 + _loc1_);
            _loc2_ = 0;
            while(_loc2_ < _loc1_ + 3)
            {
               TUtilityString.FlushUTF(_loc3_,"新浪 S1 名字有六个字" + _loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt((_loc1_ + 1) * 100);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(1);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

