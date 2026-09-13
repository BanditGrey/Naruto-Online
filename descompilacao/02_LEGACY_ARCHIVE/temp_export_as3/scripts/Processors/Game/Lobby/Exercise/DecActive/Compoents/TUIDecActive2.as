package Processors.Game.Lobby.Exercise.DecActive.Compoents
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.DecActive.TDecActive2;
   import Logics.Exercise.DecActive.TLotteryResult;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.DecActive.TProcessorDecActive;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIDecActive2 extends TUIBaseWindow
   {
      
      protected static const SHOW_ITEM_COUNT:int = 5;
      
      protected static const BOX_COUNT:int = 5;
      
      protected static const LOTTERY_LEVEL:int = 3;
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      protected static const MOVIE_OF_LOTTERY:int = 0;
      
      protected static const MIN_SCROLL_HEIGHT:Number = 166;
      
      protected static const ITEM_HEIGHT:Number = 22;
      
      protected var FDecActive2:TDecActive2;
      
      protected var FIsFirst:Boolean;
      
      protected var FMovieType:int;
      
      protected var FIsChanged:Boolean;
      
      protected var FTimeID:int;
      
      protected var FTF_Time:TextField;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      public function TUIDecActive2(param1:TUIComponent)
      {
         super(param1);
         this.FIsFirst = true;
         this.FIsChanged = false;
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         var _loc5_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         this.FTF_Time = FMC_Scene.TF_Time;
         FMC_Scene.MC_Pool.buttonMode = true;
         FMC_Scene.MC_Pool.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGoldOver);
         FMC_Scene.MC_Pool.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_Lucky.buttonMode = true;
         FMC_Scene.MC_Lucky.addEventListener(MouseEvent.CLICK,this.ProcessorOnLuckyUp);
         FMC_Scene.MC_Lucky.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnLuckyOver);
         FMC_Scene.MC_Lucky.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            _loc5_ = FMC_Scene["MC_Box" + _loc2_];
            _loc5_.MC_Box.gotoAndStop(_loc2_ + 1);
            _loc5_.buttonMode = true;
            _loc5_.addEventListener(MouseEvent.CLICK,this.ProcessorOnTreeBoxUp);
            _loc2_++;
         }
         this.FMC_Mask = FMC_Scene.MC_Bar.MC_Mask;
         if(this.FMC_Mask)
         {
            this.FBarMaxWidth = this.FMC_Mask.width;
         }
         TweenUtil.to(this.FMC_Mask,1000,{"width":0});
         this.FScrollBar = new TScrollBar(FMC_Scene["MC_List"],MIN_SCROLL_HEIGHT,false,0,0);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnSelectNumUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_MyNum,true);
         FMC_Scene.BTN_MyNum.addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenMyNumUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_LotteryLog,true);
         FMC_Scene.BTN_LotteryLog.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLotteryLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         FMC_Scene.MC_Tips.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTipOver);
         FMC_Scene.MC_Tips.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_CurResult.visible = false;
      }
      
      protected function UpdatePool() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         FMC_Scene.MC_Pool.TF_Gold.text = this.FDecActive2.PoolGold.toString();
         FMC_Scene.TF_SelectedCount.text = this.FDecActive2.SelectedCount + "/" + this.FDecActive2.MaxCount;
         FMC_Scene.TF_Desc1.text = this.FDecActive2.DescListNew[3];
         if(this.FDecActive2.GameStatus == TDecActive2.STATUS_BUYING)
         {
            FMC_Scene.MC_CurResult.visible = false;
            FMC_Scene.MC_Waiting.visible = false;
            if(this.FDecActive2.SelectedCount < this.FDecActive2.MaxCount)
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
            }
            else
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,false);
            }
         }
         else if(this.FDecActive2.GameStatus == TDecActive2.STATUS_WAITING)
         {
            FMC_Scene.MC_CurResult.visible = false;
            FMC_Scene.MC_Waiting.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,false);
         }
         else if(this.FDecActive2.GameStatus == TDecActive2.STATUS_SENDING)
         {
            FMC_Scene.MC_CurResult.visible = true;
            FMC_Scene.MC_Waiting.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,false);
            _loc3_ = "";
            if(this.FDecActive2.CurResults.FirstNumbers.length > 0)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FDecActive2.CurResults.FirstNumbers.length)
               {
                  _loc3_ += String(Number(this.FDecActive2.CurResults.FirstNumbers[_loc1_] / 10000).toFixed(4)).slice(-3) + " ";
                  _loc1_++;
               }
            }
            else
            {
               _loc3_ = this.FDecActive2.DescListNew[11];
            }
            FMC_Scene.MC_CurResult.TF_Num0.text = _loc3_;
            _loc3_ = "";
            if(this.FDecActive2.CurResults.SecondNumbers.length > 0)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FDecActive2.CurResults.SecondNumbers.length)
               {
                  if(_loc1_ < this.FDecActive2.CurResults.SecondNumbers.length - 1)
                  {
                     _loc3_ += String(Number(this.FDecActive2.CurResults.SecondNumbers[_loc1_] / 10000).toFixed(4)).slice(-3) + " | ";
                  }
                  else
                  {
                     _loc3_ += String(Number(this.FDecActive2.CurResults.SecondNumbers[_loc1_] / 10000).toFixed(4)).slice(-3) + " ";
                  }
                  _loc1_++;
               }
            }
            else
            {
               _loc3_ = this.FDecActive2.DescListNew[11];
            }
            FMC_Scene.MC_CurResult.TF_Num1.text = _loc3_;
            _loc3_ = "";
            if(this.FDecActive2.CurResults.ThirdNumbers.length > 0)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FDecActive2.CurResults.ThirdNumbers.length)
               {
                  if(_loc1_ < this.FDecActive2.CurResults.ThirdNumbers.length - 1)
                  {
                     _loc3_ += String(Number(this.FDecActive2.CurResults.ThirdNumbers[_loc1_] / 10000).toFixed(4)).slice(-3) + " | ";
                  }
                  else
                  {
                     _loc3_ += String(Number(this.FDecActive2.CurResults.ThirdNumbers[_loc1_] / 10000).toFixed(4)).slice(-3) + " ";
                  }
                  _loc1_++;
               }
            }
            else
            {
               _loc3_ = this.FDecActive2.DescListNew[11];
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
         _loc3_ = int(this.FDecActive2.Results.length);
         _loc1_ = 0;
         while(_loc1_ < LOTTERY_LEVEL)
         {
            if(_loc1_ < this.FDecActive2.Results.length)
            {
               _loc6_ = this.FDecActive2.Results[_loc1_];
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
                  FMC_Scene["TF_Num" + _loc1_].text = this.FDecActive2.DescListNew[11];
                  FMC_Scene["TF_Gold" + _loc1_].text = this.FDecActive2.DescListNew[11];
               }
            }
            else
            {
               FMC_Scene["TF_Gold" + _loc1_].text = this.FDecActive2.DescListNew[11];
               FMC_Scene["TF_Num" + _loc1_].text = this.FDecActive2.DescListNew[11];
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < LOTTERY_LEVEL)
         {
            FMC_Scene["TF_CurGold" + _loc1_].text = this.FDecActive2.GoldList[_loc1_] + STRING_COMMON.ITEMNAME_Gold;
            _loc1_++;
         }
         _loc7_ = this.FDecActive2.LuckyBox;
         if(_loc7_.Count > 0)
         {
            FMC_Scene.MC_Lucky.MC_Click.visible = true;
            FMC_Scene.MC_Lucky.MC_Box.gotoAndPlay(1);
            FMC_Scene.MC_Lucky.TF_Count.text = "*" + _loc7_.Count;
         }
         else
         {
            FMC_Scene.MC_Lucky.MC_Click.visible = false;
            FMC_Scene.MC_Lucky.MC_Box.gotoAndStop(1);
            FMC_Scene.MC_Lucky.TF_Count.text = "*0";
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
            _loc5_.text = this.FDecActive2.DescListNew[4 + _loc1_];
            this.FScrollBar.AddItem(_loc5_);
            if(_loc1_ < this.FDecActive2.Players.length)
            {
               _loc7_ = this.FDecActive2.Players[_loc1_];
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
                  _loc6_.text = this.FDecActive2.DescListNew[11];
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
               _loc6_.text = this.FDecActive2.DescListNew[11];
               this.FScrollBar.AddItem(_loc6_);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateTree() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(this.FDecActive2.TreeLevel == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.TF_TreeLevel.text = this.FDecActive2.DescListNew[7];
            FMC_Scene.MC_End.visible = true;
            FMC_Scene.MC_Tree.gotoAndStop(5);
         }
         else
         {
            FMC_Scene.TF_TreeLevel.text = "Lv" + this.FDecActive2.TreeLevel;
            FMC_Scene.MC_End.visible = false;
            FMC_Scene.MC_Tree.gotoAndStop(this.FDecActive2.TreeLevel);
         }
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Box" + _loc1_];
            if(_loc1_ < this.FDecActive2.TreeItems.length)
            {
               _loc2_ = this.FDecActive2.TreeItems[_loc1_];
               _loc3_.MC_Box.gotoAndStop(_loc1_ + 1);
               FMC_Scene.MC_NeedGold["TF_Gold" + _loc1_].text = this.FDecActive2.NeedGolds[_loc1_].toString();
               if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc3_.visible = true;
                  _loc3_.gotoAndStop(1);
                  _loc3_.filters = [TGameUtil.GaryColorFilters];
               }
               else if(_loc2_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.visible = true;
                  _loc3_.gotoAndPlay(1);
                  _loc3_.filters = [];
               }
               else
               {
                  _loc3_.visible = false;
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
         _loc4_ = this.FDecActive2.NeedGolds.length - 1;
         _loc7_ = this.FDecActive2.NeedGolds[_loc4_] - this.FDecActive2.BarGold;
         FMC_Scene.TF_CurRecharge.text = this.FDecActive2.RechargeGold + STRING_COMMON.ITEMNAME_Gold;
         _loc5_ = Number((this.FDecActive2.RechargeGold - this.FDecActive2.BarGold) / _loc7_) * this.FBarMaxWidth;
         _loc6_ = Math.min(_loc5_,this.FBarMaxWidth);
         this.FMC_Mask.width = _loc6_;
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FDecActive2.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FDecActive2.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FDecActive2.DescListNew[1];
      }
      
      protected function SetInterval() : void
      {
         var _loc1_:Number = NaN;
         if(this.FTimeID != 0)
         {
            clearTimeout(this.FTimeID);
            this.FTimeID = 0;
         }
         _loc1_ = (this.FDecActive2.NextTime - STimingCore.GetServerTick()) * 1000 + 1000;
         if(_loc1_ > 0 && _loc1_ < int.MAX_VALUE)
         {
            this.FTimeID = setTimeout(ProcessorOnUpdateWindow,_loc1_);
         }
      }
      
      protected function ProcessorOnSelectNumUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnShowWindow != null)
         {
            FOnShowWindow(TProcessorDecActive.WINDOW_SELECTE_NUM);
         }
      }
      
      protected function ProcessorOnLuckyUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FDecActive2) && this.FDecActive2.LuckyBox.Count > 0)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorDecActive.ACTIVITY_2_GET_LUCKY_BOX);
         }
      }
      
      protected function ProcessorOnTreeBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(this.FDecActive2)
         {
            if(this.FDecActive2.TreeItems[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorDecActive.ACTIVITY_2_GET_GIFT,_loc2_ + 1);
            }
            else if(this.FDecActive2.DescList.length > 13)
            {
               FOnShowFlowText(this.FDecActive2.DescListNew[13]);
            }
         }
      }
      
      protected function ProcessorOnOpenMyNumUp(param1:MouseEvent) : void
      {
         if(FOnShowWindow != null)
         {
            FOnShowWindow(TProcessorDecActive.WINDOW_MY_SELECTED);
         }
      }
      
      protected function ProcessorOnLoadLotteryLog(param1:MouseEvent) : void
      {
         if(FOnShowWindow != null)
         {
            FOnShowWindow(TProcessorDecActive.WINDOW_LOTTERY_LOG);
         }
      }
      
      protected function ProcessorOnTipOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null)
         {
            FOnShowHtmlTip(this.FDecActive2.DescListNew[12]);
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_2_ID);
         }
      }
      
      protected function ProcessorOnGoldOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null)
         {
            FOnShowHtmlTip(this.FDecActive2.DescListNew[2]);
         }
      }
      
      protected function ProcessorOnLuckyOver(param1:MouseEvent) : void
      {
         if(FOnNewBoxOver != null)
         {
            FOnNewBoxOver(this.FDecActive2.LuckyBox.Inventories);
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
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            if(Boolean(this.FDecActive2) && Boolean(this.FTF_Time))
            {
               if(this.FDecActive2.GameStatus == TDecActive2.STATUS_BUYING)
               {
                  this.FTF_Time.text = TGameUtil.fomatTime(this.FDecActive2.NextTime - STimingCore.GetServerTick());
               }
               else if(this.FDecActive2.GameStatus == TDecActive2.STATUS_WAITING)
               {
                  FMC_Scene.MC_Waiting.TF_Time.text = TGameUtil.fomatTime(this.FDecActive2.NextTime - STimingCore.GetServerTick());
               }
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FDecActive2 = SLogicsCore.DecActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TDecActive2;
         this.UpdatePool();
         this.UpdateResult();
         this.UpdatePlayers();
         this.UpdateTree();
         this.UpdateText();
         this.SetInterval();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         FIsPlaying = true;
         this.FMovieType = param1;
         if(this.FMovieType == MOVIE_OF_LOTTERY)
         {
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:String = null;
         var _loc2_:TInventory = null;
         FIsPlaying = false;
         this.FIsChanged = false;
         if(this.FMovieType == MOVIE_OF_LOTTERY)
         {
         }
      }
      
      override public function Unmount() : void
      {
         var _loc1_:int = 0;
         TweenUtil.removeAllTween();
         FIsPlaying = false;
      }
   }
}

