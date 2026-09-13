package Processors.Game.Lobby.Undertown.LittlePanel
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Common.THint;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TDungeonsBattle;
   import Logics.DatebaseVO.VO.TDungeonsBattleConfig;
   import Logics.SLogicsCore;
   import Logics.Undertown.TUndertownLogicData;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Processors.Game.Lobby.Undertown.CellPanel.SpUndertownFightingCell;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_UNDERTOWN;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   public class LittleOnePanel extends Sprite
   {
      
      protected var FTim:Timer;
      
      protected var Daojishi:int;
      
      protected var FParent:TUIComponent;
      
      protected var FTempPanel:MovieClip;
      
      protected var FScrollBar_0:TScrollBar = null;
      
      protected var FScrollBar_1:TScrollBar = null;
      
      protected var FLogicData:TUndertownLogicData = null;
      
      protected var CurTextField:TextField;
      
      protected var CurStr:String = "";
      
      protected var FMC_MopUpBtn:MovieClip = null;
      
      protected var FTF_HighestLayer:TextField;
      
      protected var FTF_CurLayer:TextField;
      
      protected var FTF_ChallengeCount:TextField;
      
      protected var FMC_ResetBtn:MovieClip = null;
      
      protected var FMC_SaoDangCountdown:MovieClip = null;
      
      protected var FTF_SaoDangDec:TextField;
      
      protected var CusTomsNameString:Vector.<String>;
      
      protected var FHint:THint;
      
      protected var FMopUpBtnClickBack:Function;
      
      protected var FMC_ResetBtnClickBack:Function;
      
      protected var FUIHintOnOver:Function;
      
      protected var FUIHintOnOut:Function;
      
      protected var FFightingCellBackFunction:Function;
      
      protected var FC_S_SaoDang:Function;
      
      protected var CurTempString:String;
      
      public function LittleOnePanel(param1:TUIComponent)
      {
         super();
         this.FParent = param1;
         this.FHint = new THint();
         this.FTim = new Timer(1000);
         this.CusTomsNameString = new Vector.<String>();
      }
      
      public function set TempPanel(param1:MovieClip) : void
      {
         this.FTempPanel = param1;
         addChild(this.FTempPanel);
         this.UIDispatch();
      }
      
      protected function UIDispatch() : void
      {
         this.FScrollBar_0 = new TScrollBar(this.FTempPanel["mc_list_0"],370,true,0,20,true);
         this.FScrollBar_0.Clear();
         this.FScrollBar_1 = new TScrollBar(this.FTempPanel["mc_list_1"],160,true,0,20,true);
         this.FScrollBar_1.Clear();
         this.FMC_MopUpBtn = this.FTempPanel["MC_MopUpBtn"];
         this.FMC_ResetBtn = this.FTempPanel["MC_ResetBtn"];
         this.FMC_ResetBtn.gotoAndStop(1);
         this.FTF_HighestLayer = this.FTempPanel["TF_HighestLayer"];
         this.FTF_CurLayer = this.FTempPanel["TF_CurLayer"];
         this.FTF_ChallengeCount = this.FTempPanel["TF_ChallengeCount"];
         this.FMC_SaoDangCountdown = this.FTempPanel["MC_SaoDangCountdown"];
         this.FTF_SaoDangDec = this.FMC_SaoDangCountdown["TF_SaoDangDec"];
         this.FMC_SaoDangCountdown.visible = false;
         this.CurTextField = new TextField();
         this.CurTextField.multiline = true;
         this.Initilization();
      }
      
      protected function Initilization() : void
      {
         var _loc1_:TBins = null;
         var _loc2_:int = 0;
         var _loc3_:SpUndertownFightingCell = null;
         var _loc4_:TDungeonsBattleConfig = null;
         this.FScrollBar_0.Clear();
         _loc1_ = this.FLogicData.DungeonsBattleConfigBin;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.Count)
         {
            _loc3_ = new SpUndertownFightingCell();
            _loc4_ = _loc1_.GetDatebaseByIndex(_loc2_) as TDungeonsBattleConfig;
            _loc3_.CurLayer = _loc2_;
            _loc3_.DungeonsBattleConfig = _loc4_;
            _loc3_.ThisPanelBackFunction = this.FFightingCellBackFunction;
            this.FScrollBar_0.AddItem(_loc3_);
            _loc2_++;
         }
         this.FScrollBar_0.ScrollToUp();
         this.FMC_MopUpBtn.addEventListener(MouseEvent.CLICK,this.MC_MopUpBtnClick);
         this.FMC_ResetBtn.addEventListener(MouseEvent.CLICK,this.MC_ReseBtnClick);
         this.FMC_ResetBtn.addEventListener(MouseEvent.MOUSE_OVER,this.MC_ReseBtnOver);
         this.FMC_ResetBtn.addEventListener(MouseEvent.MOUSE_OUT,this.MC_ReseBtnOut);
         this.FMC_ResetBtn.addEventListener(MouseEvent.MOUSE_MOVE,this.MC_ReseBtnMove);
         this.FMC_ResetBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.MC_ReseBtnDown);
         this.FMC_ResetBtn.addEventListener(MouseEvent.MOUSE_UP,this.MC_ReseBtnUp);
      }
      
      public function set FightingCellBackFunction(param1:Function) : void
      {
         this.FFightingCellBackFunction = param1;
      }
      
      protected function UpdateScrollBar_0() : void
      {
         var _loc1_:SpUndertownFightingCell = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FScrollBar_0.Count)
         {
            _loc1_ = this.FScrollBar_0.Items[_loc2_] as SpUndertownFightingCell;
            _loc1_.UpdateView();
            _loc2_++;
         }
      }
      
      public function UpdateView() : void
      {
         var _loc1_:String = null;
         if(this.FLogicData.LastCustomsData != null && this.FLogicData.GetRestCount > 0)
         {
            TGameUtil.setButtonMode(this.FMC_ResetBtn,true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_ResetBtn,false);
         }
         TGameUtil.setButtonMode(this.FMC_MopUpBtn,false);
         if(this.FLogicData.HistoricHighsCustomsData != null)
         {
            if(this.FLogicData.LastCustomsData != null)
            {
               if(this.FLogicData.HistoricHighsCustomsData.Identifier > this.FLogicData.LastCustomsData.Identifier)
               {
                  TGameUtil.setButtonMode(this.FMC_MopUpBtn,true);
               }
            }
            else
            {
               TGameUtil.setButtonMode(this.FMC_MopUpBtn,true);
            }
         }
         _loc1_ = this.FLogicData.TheHighestCustomsClearanceRecord;
         this.FTF_HighestLayer.text = _loc1_;
         if(!this.FLogicData.LastCustomsData)
         {
            _loc1_ = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_3).DescribeString;
         }
         else
         {
            _loc1_ = this.FLogicData.LastCustomsData.Name;
         }
         this.FTF_CurLayer.text = _loc1_;
         this.UpdateScrollBar_0();
      }
      
      public function StartTimer(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc7_:TDungeonsBattle = null;
         this.CusTomsNameString.length = 0;
         this.CurTempString = "";
         _loc5_ = param1.readUnsignedInt();
         var _loc6_:uint = uint(STimingCore.GetServerTick());
         if(_loc5_ <= _loc6_)
         {
            return;
         }
         _loc5_ -= _loc6_;
         _loc6_ = Math.floor(_loc5_ / this.FLogicData.SaoDangCostTime);
         if(_loc6_ <= 1)
         {
            return;
         }
         _loc4_ = param1.readShort();
         if(_loc4_ == 0)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = param1.readUnsignedInt();
            _loc7_ = this.FLogicData.DungeonsBattleBin.GetDatebaseByIdentifier(_loc3_) as TDungeonsBattle;
            this.CusTomsNameString.push(_loc7_.Name);
            _loc2_++;
         }
         if(_loc6_ >= this.CusTomsNameString.length)
         {
            _loc6_ = this.CusTomsNameString.length;
         }
         _loc2_ = 0;
         while(_loc2_ < this.CusTomsNameString.length - _loc6_)
         {
            this.CurTempString = this.CusTomsNameString.shift();
            _loc2_++;
         }
         if(this.CusTomsNameString.length > 0)
         {
            SLogicsCore.UndertownLogicData.LastCustomsId = _loc3_;
            if(!this.FTim.hasEventListener(TimerEvent.TIMER))
            {
               this.FTim.addEventListener(TimerEvent.TIMER,this.TEvent);
            }
            this.CurTempString = this.CusTomsNameString.shift();
            this.FLogicData.IsAtDaoJiShiIng = true;
            this.Daojishi = this.FLogicData.SaoDangCostTime;
            this.FTF_SaoDangDec.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_10).DescribeString,this.CurTempString,this.Daojishi);
            this.FMC_SaoDangCountdown.visible = true;
            this.FMC_MopUpBtn.visible = false;
            this.FTim.start();
         }
      }
      
      protected function TEvent(param1:TimerEvent) : void
      {
         --this.Daojishi;
         if(this.Daojishi <= 0)
         {
            if(this.CusTomsNameString.length > 0)
            {
               this.CurTempString = this.CusTomsNameString.shift();
               this.Daojishi = this.FLogicData.SaoDangCostTime;
            }
            else
            {
               this.CurTempString = "";
               this.FTim.reset();
               this.FTim.stop();
               if(this.FTim.hasEventListener(TimerEvent.TIMER))
               {
                  this.FTim.removeEventListener(TimerEvent.TIMER,this.TEvent);
               }
               if(this.FC_S_SaoDang != null)
               {
                  this.FC_S_SaoDang();
               }
               this.FLogicData.IsAtDaoJiShiIng = false;
               this.FMC_SaoDangCountdown.visible = false;
               this.FMC_MopUpBtn.visible = true;
               this.UpdateView();
            }
         }
         this.FTF_SaoDangDec.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_10).DescribeString,this.CurTempString,this.Daojishi);
      }
      
      public function LogicsPerform() : void
      {
      }
      
      public function UpdateScrollBar_1(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TArticle = null;
         var _loc5_:TDungeonsBattle = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         this.FScrollBar_1.Clear();
         this.CurStr = "";
         _loc3_ = param1.readShort();
         var _loc10_:TBins = null;
         if(_loc3_ > 0)
         {
            _loc10_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         }
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = param1.readUnsignedInt();
            _loc5_ = this.FLogicData.DungeonsBattleBin.GetDatebaseByIdentifier(_loc6_) as TDungeonsBattle;
            _loc9_ = param1.readShort();
            _loc8_ = 0;
            while(_loc8_ < _loc9_)
            {
               _loc6_ = uint(param1.readShort());
               _loc7_ = param1.readUnsignedInt();
               _loc6_ = CONST_COMMON.GetItemIDByType(_loc6_,_loc7_,_loc10_);
               _loc4_ = _loc10_.GetDatebaseByIdentifier(_loc6_) as TArticle;
               _loc6_ = param1.readUnsignedInt();
               if(_loc8_ >= 1)
               {
                  this.CurStr += TUtilityString.Format(new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_13).DescribeString,CONST_COMMON.QUALITYCOLOR_INDEX_1[_loc4_.Quality],_loc4_.Name,_loc6_);
               }
               else
               {
                  this.CurStr += TUtilityString.Format(new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_2).DescribeString,_loc5_.Name,CONST_COMMON.QUALITYCOLOR_INDEX_1[_loc4_.Quality],_loc4_.Name,_loc6_);
               }
               _loc8_++;
            }
            _loc2_++;
         }
         this.CurTextField.htmlText = this.CurStr;
         this.CurTextField.x = 0;
         this.CurTextField.y = 0;
         this.CurTextField.width = 110;
         this.CurTextField.height = this.CurTextField.textHeight + 20;
         this.FScrollBar_1.AddItem(this.CurTextField);
         this.FScrollBar_1.ScrollToDown();
      }
      
      public function set C_S_SaoDang(param1:Function) : void
      {
         this.FC_S_SaoDang = param1;
      }
      
      public function set LogicData(param1:TUndertownLogicData) : void
      {
         this.FLogicData = param1;
      }
      
      public function set MC_ResetBtnClickBack(param1:Function) : void
      {
         this.FMC_ResetBtnClickBack = param1;
      }
      
      public function set MopUpBtnClickBack(param1:Function) : void
      {
         this.FMopUpBtnClickBack = param1;
      }
      
      public function get UIHintOnOver() : Function
      {
         return this.FUIHintOnOver;
      }
      
      public function set UIHintOnOver(param1:Function) : void
      {
         this.FUIHintOnOver = param1;
      }
      
      public function get UIHintOnOut() : Function
      {
         return this.FUIHintOnOut;
      }
      
      public function set UIHintOnOut(param1:Function) : void
      {
         this.FUIHintOnOut = param1;
      }
      
      protected function MC_MopUpBtnClick(param1:MouseEvent) : void
      {
         if(!this.FMC_MopUpBtn.buttonMode)
         {
            return;
         }
         if(this.FMopUpBtnClickBack != null)
         {
            this.FMopUpBtnClickBack();
         }
      }
      
      protected function MC_ReseBtnClick(param1:MouseEvent) : void
      {
         if(!this.FMC_ResetBtn.buttonMode)
         {
            return;
         }
         if(this.FLogicData.IsAtDaoJiShiIng)
         {
            return;
         }
         this.FMC_ResetBtnClickBack();
      }
      
      protected function MC_ReseBtnOver(param1:MouseEvent) : void
      {
         if(!this.FMC_ResetBtn.buttonMode)
         {
            return;
         }
         this.FMC_ResetBtn.gotoAndStop(2);
      }
      
      protected function MC_ReseBtnDown(param1:MouseEvent) : void
      {
         if(!this.FMC_ResetBtn.buttonMode)
         {
            return;
         }
         this.FMC_ResetBtn.gotoAndStop(3);
      }
      
      protected function MC_ReseBtnUp(param1:MouseEvent) : void
      {
         if(!this.FMC_ResetBtn.buttonMode)
         {
            return;
         }
         this.FMC_ResetBtn.gotoAndStop(2);
      }
      
      protected function MC_ReseBtnOut(param1:MouseEvent) : void
      {
         if(this.FUIHintOnOut != null)
         {
            this.FUIHintOnOut(this);
         }
         if(!this.FMC_ResetBtn.buttonMode)
         {
            return;
         }
         this.FMC_ResetBtn.gotoAndStop(1);
      }
      
      protected function MC_ReseBtnMove(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(SLogicsCore.Character.VipLevel < this.FLogicData.OpenVipLevel)
         {
            _loc2_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_4).DescribeString,this.FLogicData.OpenVipLevel);
         }
         else
         {
            _loc2_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_5).DescribeString,this.FLogicData.GetRestCount);
         }
         this.FHint.Caption = _loc2_;
         if(this.FUIHintOnOver != null)
         {
            this.FUIHintOnOver(this,this.FHint);
         }
      }
   }
}

