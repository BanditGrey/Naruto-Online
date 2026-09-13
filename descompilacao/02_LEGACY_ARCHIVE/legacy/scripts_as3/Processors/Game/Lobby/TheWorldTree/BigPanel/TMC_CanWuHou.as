package Processors.Game.Lobby.TheWorldTree.BigPanel
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.TheWorldTree.TTheWorldTreeLogicData;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_THEWORLDTREE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TMC_CanWuHou
   {
      
      protected var FThisPanel:MovieClip;
      
      protected var FLogicDate:TTheWorldTreeLogicData;
      
      protected var FScrollBar:TScrollBar = null;
      
      protected var FSM_StopCanwuBtn:SimpleButton;
      
      protected var CurTextField:TextField;
      
      protected var CurStr:String = "";
      
      protected var FTF_CanWuTimeeD:TextField;
      
      protected var FTF_CanWuExpeD:TextField;
      
      protected var FTF_CanWuPowereD:TextField;
      
      protected var FStopCanWuFunc:Function;
      
      protected var FCurPercent:uint;
      
      protected var FCurTempTime:uint;
      
      public function TMC_CanWuHou(param1:TTheWorldTreeLogicData)
      {
         super();
         this.FLogicDate = param1;
      }
      
      public function set ThisPanel(param1:MovieClip) : void
      {
         this.FThisPanel = param1;
         this.Initilization();
      }
      
      protected function Initilization() : void
      {
         this.CurTextField = new TextField();
         this.CurTextField.multiline = true;
         this.FScrollBar = new TScrollBar(this.FThisPanel["MC_List"],125,true,0,0,true);
         this.FScrollBar.Clear();
         this.FSM_StopCanwuBtn = this.FThisPanel["SM_StopCanwuBtn"];
         this.FTF_CanWuExpeD = this.FThisPanel["TF_CanWuExpeD"];
         this.FTF_CanWuPowereD = this.FThisPanel["TF_CanWuPowereD"];
         this.FTF_CanWuTimeeD = this.FThisPanel["TF_CanWuTimeeD"];
      }
      
      public function Rest() : void
      {
         this.FTF_CanWuExpeD.text = "0";
         this.FTF_CanWuPowereD.text = "0";
      }
      
      public function AddEvent() : void
      {
         this.FSM_StopCanwuBtn.addEventListener(MouseEvent.CLICK,this.HnadleClick);
      }
      
      public function LogicsPerform() : void
      {
         var _loc3_:uint = 0;
         if(!this.FThisPanel)
         {
            return;
         }
         if(!this.FThisPanel.visible)
         {
            return;
         }
         this.FTF_CanWuTimeeD.text = TGameUtil.fomatTime_NoDay(STimingCore.GetServerTick() - this.FLogicDate.PenetrateBeginTimes);
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         if(this.FLogicDate.SeverCurTime != this.FLogicDate.OnlineAdditionExpSurplusTimes)
         {
            if(STimingCore.GetServerTick() > this.FLogicDate.OnlineAdditionExpSurplusTimes)
            {
               _loc3_ = this.FLogicDate.OnlineAdditionExpSurplusTimes;
               _loc3_ -= this.FLogicDate.PenetrateBeginTimes;
            }
            else
            {
               _loc3_ = uint(STimingCore.GetServerTick());
               _loc3_ -= this.FLogicDate.PenetrateBeginTimes;
            }
            _loc3_ = uint(_loc3_ / this.FLogicDate.JieSuanTimeCell);
            _loc1_ = _loc3_ * this.FLogicDate.AddExpOneTime;
            _loc2_ = _loc1_ * this.FLogicDate.GoldBuyPercent / 10000;
         }
         this.FCurPercent += this.FLogicDate.OnlineBuffPercent;
         this.FCurPercent += this.FLogicDate.KaguyaPowerPercentCopy;
         this.FCurPercent += this.FLogicDate.VipLevelPercentCopy;
         _loc3_ = this.FLogicDate.PenetrateBeginTimes;
         if(_loc3_ > STimingCore.GetServerTick())
         {
            this.FCurTempTime = 0;
         }
         else
         {
            this.FCurTempTime = STimingCore.GetServerTick() - _loc3_ - this.FLogicDate.CurOfflineTimeAllTime;
         }
         _loc1_ = uint(this.FCurTempTime / this.FLogicDate.JieSuanTimeCell) * this.FLogicDate.AddExpOneTime;
         _loc1_ += _loc1_ * this.FCurPercent / 10000;
         _loc1_ += _loc2_;
         this.FCurPercent = this.FLogicDate.KaguyaPowerPercentCopy + this.FLogicDate.VipLevelPercentCopy;
         _loc2_ = uint(this.FLogicDate.CurOfflineTimeAllTime / this.FLogicDate.JieSuanTimeCell) * this.FLogicDate.AddExpOneTime;
         _loc2_ += _loc2_ * this.FCurPercent / 10000;
         _loc1_ += _loc2_;
         this.FTF_CanWuExpeD.text = _loc1_.toFixed();
         _loc3_ = this.FLogicDate.PenetrateBeginTimes;
         if(_loc3_ > STimingCore.GetServerTick())
         {
            this.FCurTempTime = 0;
         }
         else
         {
            this.FCurTempTime = STimingCore.GetServerTick() - _loc3_;
         }
         this.FTF_CanWuPowereD.text = String(uint(this.FCurTempTime / this.FLogicDate.JieSuanTimeCell) * this.FLogicDate.AddPowerOneTime);
      }
      
      protected function HnadleClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FSM_StopCanwuBtn:
               if(this.FStopCanWuFunc != null)
               {
                  this.FStopCanWuFunc();
               }
         }
      }
      
      public function UpdateView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TArticle = null;
         var _loc4_:String = null;
         var _loc5_:Date = null;
         this.FScrollBar.Clear();
         this.CurStr = "";
         this.CurStr += new ConsumeFrameCopy(STRING_THEWORLDTREE.str18).DescribeString;
         _loc1_ = 0;
         while(_loc1_ < this.FLogicDate.TheWorldTreeDropOutGoods.length / 4)
         {
            _loc2_ = _loc1_ * 4;
            _loc5_ = new Date(STimingCore.GetClientShowTime(this.FLogicDate.TheWorldTreeDropOutGoods[_loc2_]) * 1000);
            _loc4_ = TUtilityDate.FormatTime(_loc5_);
            if(this.FLogicDate.TheWorldTreeDropOutGoods[_loc2_ + 1] == 22)
            {
               this.CurStr += TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str19).DescribeString,"#FF6699",_loc4_,this.FLogicDate.MaoXianYouXiQuanName,this.FLogicDate.TheWorldTreeDropOutGoods[_loc2_ + 3]);
            }
            else
            {
               _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,this.FLogicDate.TheWorldTreeDropOutGoods[_loc2_ + 2]) as TArticle;
               this.CurStr += TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str19).DescribeString,CONST_COMMON.QUALITYCOLOR_INDEX_1[_loc3_.Quality],_loc4_,_loc3_.Name,this.FLogicDate.TheWorldTreeDropOutGoods[_loc2_ + 3]);
            }
            _loc1_++;
         }
         this.CurTextField.htmlText = this.CurStr;
         this.CurTextField.x = 0;
         this.CurTextField.y = 0;
         this.CurTextField.width = 190;
         this.CurTextField.height = this.CurTextField.textHeight + 40;
         this.FScrollBar.AddItem(this.CurTextField);
         this.FScrollBar.ScrollToDown();
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
      
      public function set StopCanWuFunc(param1:Function) : void
      {
         this.FStopCanWuFunc = param1;
      }
   }
}

