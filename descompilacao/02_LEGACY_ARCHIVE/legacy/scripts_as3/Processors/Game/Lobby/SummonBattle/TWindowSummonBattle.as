package Processors.Game.Lobby.SummonBattle
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.SummonBattle.TSummonBattleData;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TWindowSummonBattle extends TProcessorLobbyWindow
   {
      
      protected var FThisPanel:MovieClip;
      
      protected var FSummonBattleData:TSummonBattleData;
      
      protected var FBTN_Occupy:MovieClip;
      
      protected var FBTN_Grab:MovieClip;
      
      protected var FBTN_Cancel:MovieClip;
      
      protected var FTF_Username:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_FightValue:TextField;
      
      protected var FTF_ColdTime:TextField;
      
      protected var FTF_Output:TextField;
      
      protected var FTF_Basic:TextField;
      
      protected var FTF_Addition:TextField;
      
      protected var FSelectIndex:int = 1;
      
      public var BaseUnitValue:Vector.<Object>;
      
      public var AddRateValue:Vector.<Object>;
      
      public var OnClickFun:Function;
      
      public var OnOpenInforWindon:Function;
      
      public var OncalcAgentNumFunc:Function;
      
      public function TWindowSummonBattle(param1:TUIComponent)
      {
         super(param1);
         TGameUtil.AddWindowMask(this);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_sumonPanel") as MovieClip;
         addChild(this.FThisPanel);
         this.FTF_Username = this.FThisPanel.TF_Username;
         this.FTF_ColdTime = this.FThisPanel.TF_ColdTime;
         this.FTF_Level = this.FThisPanel.TF_Level;
         this.FTF_FightValue = this.FThisPanel.TF_FightValue;
         this.FBTN_Occupy = this.FThisPanel.BTN_Occupy;
         TGameUtil.setButtonMode(this.FBTN_Occupy,true);
         this.FBTN_Grab = this.FThisPanel.BTN_Grab;
         TGameUtil.setButtonMode(this.FBTN_Grab,true);
         this.FBTN_Cancel = this.FThisPanel.BTN_Cancel;
         TGameUtil.setButtonMode(this.FBTN_Cancel,true);
         this.FTF_Output = this.FThisPanel.TF_Output;
         this.FTF_Basic = this.FThisPanel.TF_Basic;
         this.FTF_Addition = this.FThisPanel.TF_Addition;
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FThisPanel["BTN_Close"].addEventListener(MouseEvent.CLICK,this.OnHideClick);
         this.FBTN_Occupy.addEventListener(MouseEvent.CLICK,this.OnClickOccupy);
         this.FBTN_Grab.addEventListener(MouseEvent.CLICK,this.OnClickOccupy);
         this.FBTN_Cancel.addEventListener(MouseEvent.CLICK,this.OnClickWindow);
         super.ResourcesPerform_UILocations();
      }
      
      public function SetDate(param1:TSummonBattleData) : void
      {
         this.FSummonBattleData = param1;
         this.upButtonStatu();
         this.UpText();
      }
      
      protected function upButtonStatu() : void
      {
         if(this.FSummonBattleData)
         {
            this.SetOptionCheck(false);
            if(this.FSummonBattleData.IDHigh == 0 && this.FSummonBattleData.IDLow == 0)
            {
               this.FTF_Username.text = "--";
               this.FTF_ColdTime.text = "00:00:00";
               this.FTF_Level.text = "--";
               this.FTF_FightValue.text = "0";
               this.FBTN_Occupy.visible = true;
               this.FBTN_Grab.visible = false;
               this.FBTN_Cancel.visible = false;
               this.SetOptionCheck(true,this.FSelectIndex);
               this.SetCheckOptEnabled(true);
            }
            else
            {
               this.FTF_Username.text = this.FSummonBattleData.UserName;
               this.FTF_Level.text = this.FSummonBattleData.UserLevel.toString();
               this.FTF_FightValue.text = this.FSummonBattleData.PvpFightValue.ToString();
               this.SetCheckOptEnabled(false);
               if(!this.FSummonBattleData.IsMyself)
               {
                  this.FBTN_Occupy.visible = false;
                  this.FBTN_Grab.visible = true;
                  this.FBTN_Cancel.visible = false;
                  this.SetOptionCheck(true,this.FSelectIndex);
               }
               else
               {
                  this.FBTN_Occupy.visible = false;
                  this.FBTN_Grab.visible = false;
                  this.FBTN_Cancel.visible = true;
               }
            }
         }
      }
      
      protected function UpText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(this.FSummonBattleData)
         {
            _loc1_ = this.FSummonBattleData.SumonLevel;
            _loc2_ = int(this.BaseUnitValue[_loc1_ - 1][1]);
            this.FTF_Basic.text = _loc2_.toString();
            _loc3_ = this.FSummonBattleData.AgentId;
            _loc4_ = this.OncalcAgentNumFunc(_loc3_);
            if(_loc4_ > 0)
            {
               _loc5_ = int(this.AddRateValue[_loc4_ - 1][1]);
               this.FTF_Addition.text = _loc5_ + "%";
            }
            else
            {
               this.FTF_Addition.text = "0%";
            }
            _loc6_ = _loc2_ + _loc2_ * _loc5_ / 100;
            this.FTF_Output.text = _loc6_.toString();
         }
      }
      
      protected function SetOptionCheck(param1:Boolean, param2:int = -1) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         _loc5_ = this.FThisPanel["MC_opt_" + param2];
         _loc3_ = 1;
         while(_loc3_ <= 3)
         {
            _loc4_ = this.FThisPanel["MC_opt_" + _loc3_];
            if(!_loc5_ || _loc4_ == _loc5_)
            {
               if(param1)
               {
                  _loc4_.gotoAndStop("ok");
               }
               else
               {
                  _loc4_.gotoAndStop("cancle");
               }
            }
            _loc3_++;
         }
      }
      
      protected function SetCheckOptEnabled(param1:Boolean, param2:int = -1) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         _loc5_ = this.FThisPanel["MC_opt_" + param2];
         _loc3_ = 1;
         while(_loc3_ <= 3)
         {
            _loc4_ = this.FThisPanel["MC_opt_" + _loc3_];
            if(!_loc5_ || _loc4_ == _loc5_)
            {
               if(param1)
               {
                  _loc4_.addEventListener(MouseEvent.CLICK,this.OnclickOption);
               }
               else
               {
                  _loc4_.removeEventListener(MouseEvent.CLICK,this.OnclickOption);
               }
            }
            _loc3_++;
         }
      }
      
      protected function OnclickOption(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         _loc2_ = param1.currentTarget as MovieClip;
         _loc3_ = int(_loc2_.name.substr(-1));
         if(this.FSelectIndex == _loc3_)
         {
            return;
         }
         this.SetOptionCheck(false,this.FSelectIndex);
         this.FSelectIndex = _loc3_;
         this.SetOptionCheck(true,_loc3_);
      }
      
      protected function OnClickOccupy(param1:MouseEvent) : void
      {
         if(this.OnClickFun != null)
         {
            this.OnClickFun(this.FSummonBattleData.FieldId,this.FSummonBattleData.Index,this.FSelectIndex);
         }
      }
      
      protected function OnClickWindow(param1:MouseEvent) : void
      {
         if(this.OnOpenInforWindon != null)
         {
            this.OnOpenInforWindon();
         }
      }
      
      public function OnHideClick(param1:MouseEvent) : void
      {
         this.Visible = false;
         this.FSelectIndex = 1;
      }
      
      public function UpdateTime() : void
      {
         if(!this.FSummonBattleData || !Visible)
         {
            return;
         }
         var _loc1_:int = this.FSummonBattleData.OccupyTime - STimingCore.GetServerTick();
         this.FTF_ColdTime.text = TGameUtil.fomatTime_NoDay(_loc1_);
         if(_loc1_ <= 0 && this.FBTN_Cancel.visible)
         {
            this.OnOpenInforWindon && this.OnOpenInforWindon();
         }
      }
   }
}

