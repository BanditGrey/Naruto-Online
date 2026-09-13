package Processors.Game.Lobby.TheWorldTree.LittlePanel
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Timing.STimingCore;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Logics.TheWorldTree.TTheWorldTreeLogicData;
   import Processors.Game.Lobby.TheWorldTree.BigPanel.TiaoFreamSetValue;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Strings.STRING_THEWORLDTREE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowTheWorldTree_RiskPanel
   {
      
      public static const ERSHILIU:uint = 26;
      
      protected var FThisPanel:Sprite;
      
      protected var FMC_HelpClose:MovieClip;
      
      protected var FTF_HaveSilverCoin:TextField;
      
      protected var FBtn_BegineMaoXian:SimpleButton;
      
      protected var FMC_GoToTheWordTree:MovieClip;
      
      protected var FMC_Sure:MovieClip;
      
      protected var FMC_Cance:MovieClip;
      
      protected var FMC_SureBtnClick:MovieClip;
      
      protected var FMC_SureBtnText:TextField;
      
      protected var FLogicDate:TTheWorldTreeLogicData;
      
      protected var FNumberVec:Vector.<MovieClip>;
      
      protected var FWanOuVec:Vector.<MovieClip>;
      
      protected var FMC_Nimei:MovieClip;
      
      protected var FCurStateMcVector:Vector.<MovieClip>;
      
      protected var CurBallId:uint;
      
      protected var FScrollBar:TScrollBar = null;
      
      protected var CurTextField:TextField;
      
      protected var CurStr:String = "";
      
      protected var FTiaoFreamSetValue:TiaoFreamSetValue;
      
      protected var FTF_Dec:TextField;
      
      protected var FBackFunction:Function;
      
      protected var FPiaoZi:Function;
      
      protected var FOnCloseFun:Function;
      
      protected var FCurvec:Vector.<uint>;
      
      protected var FCurShengyuWanOuCount:int;
      
      protected var FCurAtJieDian:int;
      
      protected var FMC_CanceIsClisk:Boolean;
      
      protected var FMC_SureBtnClickIsClisk:Boolean;
      
      public var FIsCanClick:Boolean;
      
      public function TProcessorWindowTheWorldTree_RiskPanel(param1:TTheWorldTreeLogicData)
      {
         super();
         this.FLogicDate = SLogicsCore.TheWorldTreeLogicData;
         this.FNumberVec = new Vector.<MovieClip>(ERSHILIU);
         this.FWanOuVec = new Vector.<MovieClip>(ERSHILIU);
         this.FCurStateMcVector = new Vector.<MovieClip>(4);
         this.FTiaoFreamSetValue = new TiaoFreamSetValue(12);
      }
      
      public function set ThisPanel(param1:Sprite) : void
      {
         this.FThisPanel = param1;
         this.Initilization();
      }
      
      protected function Initilization() : void
      {
         var _loc1_:int = 0;
         this.FMC_HelpClose = this.FThisPanel["MC_HelpClose"];
         this.FTF_HaveSilverCoin = this.FThisPanel["TF_HaveSilverCoin"];
         this.FMC_GoToTheWordTree = this.FThisPanel["MC_GoToTheWordTree"];
         this.FTF_Dec = this.FThisPanel["MC_Namber_26"]["TF_Dec"];
         this.FMC_Nimei = this.FThisPanel["MC_Namber_26"]["MC_Nimei"];
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            this.FCurStateMcVector[_loc1_] = this.FThisPanel["MC_CurState_" + _loc1_];
            _loc1_++;
         }
         this.FBtn_BegineMaoXian = this.FCurStateMcVector[0]["Btn_BegineMaoXian"];
         TGameUtil.setButtonMode(this.FMC_GoToTheWordTree,true);
         this.FMC_Sure = this.FCurStateMcVector[3]["MC_Sure"];
         this.FMC_Cance = this.FCurStateMcVector[3]["MC_Cance"];
         TGameUtil.setButtonMode(this.FMC_Sure,true);
         TGameUtil.setButtonMode(this.FMC_Cance,true);
         this.FMC_SureBtnClick = this.FCurStateMcVector[2]["MC_SureBtnClick"];
         this.FMC_SureBtnText = this.FCurStateMcVector[2]["TF_Dec"];
         this.FMC_SureBtnClick.visible = false;
         TGameUtil.setButtonMode(this.FMC_SureBtnClick,true);
         this.CurTextField = new TextField();
         this.CurTextField.multiline = true;
         this.FScrollBar = new TScrollBar(this.FThisPanel["MC_List"],120,true,0,0,true);
         this.FScrollBar.Clear();
         _loc1_ = 0;
         while(_loc1_ < ERSHILIU)
         {
            this.FNumberVec[_loc1_] = this.FThisPanel["MC_Namber_" + _loc1_];
            this.FNumberVec[_loc1_].buttonMode = false;
            this.FNumberVec[_loc1_].mouseEnabled = false;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < ERSHILIU)
         {
            this.FWanOuVec[_loc1_] = this.FThisPanel["MC_WanOus"]["MC_Namber_" + _loc1_];
            this.FWanOuVec[_loc1_].gotoAndStop(1);
            this.FWanOuVec[_loc1_].buttonMode = true;
            _loc1_++;
         }
         this.FTiaoFreamSetValue.BackFun = this.TiaoFreamBackFu;
      }
      
      public function AddEvent() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TextField = null;
         var _loc3_:Vector.<uint> = null;
         this.FMC_HelpClose["BTN_Close"].addEventListener(MouseEvent.CLICK,this.CloseClick);
         this.FBtn_BegineMaoXian.addEventListener(MouseEvent.CLICK,this.CloseClick);
         this.FMC_GoToTheWordTree.addEventListener(MouseEvent.CLICK,this.CloseClick);
         this.FMC_Sure.addEventListener(MouseEvent.CLICK,this.CloseClick);
         this.FMC_Cance.addEventListener(MouseEvent.CLICK,this.CloseClick);
         this.FMC_SureBtnClick.addEventListener(MouseEvent.CLICK,this.CloseClick);
         _loc1_ = 0;
         while(_loc1_ < ERSHILIU)
         {
            this.FWanOuVec[_loc1_].addEventListener(MouseEvent.CLICK,this.WanOuClick);
            _loc2_ = this.FWanOuVec[_loc1_]["TF_Dec"];
            _loc2_.text = _loc1_ + 1 + "";
            _loc2_.mouseEnabled = false;
            this.FWanOuVec[_loc1_]["MC_Nimei"].addEventListener(MouseEvent.MOUSE_OVER,this.WanOuOver);
            this.FWanOuVec[_loc1_]["MC_Nimei"].addEventListener(MouseEvent.MOUSE_OUT,this.WanOuOut);
            _loc1_++;
         }
         this.FMC_Nimei.addEventListener(MouseEvent.MOUSE_OVER,this.WanOuOver);
         this.FMC_Nimei.addEventListener(MouseEvent.MOUSE_OUT,this.WanOuOut);
      }
      
      public function ForValueToCurvec() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TextField = null;
         switch(this.FLogicDate.CurChangeModeState)
         {
            case 0:
               return;
            case 1:
               this.FCurvec = this.FLogicDate.ChuJiRewardVec;
               break;
            case 2:
               this.FCurvec = this.FLogicDate.GaoJiRewardVec;
               break;
            case 3:
               this.FCurvec = this.FLogicDate.DingJiRewardVec;
         }
         _loc1_ = 0;
         while(_loc1_ < ERSHILIU)
         {
            this.FNumberVec[_loc1_]["MC_BackEffect"].gotoAndStop(1);
            _loc2_ = this.FNumberVec[_loc1_]["MC_BackEffect"]["TF_MainName"];
            _loc2_.text = this.FCurvec[_loc1_].toString();
            this.FNumberVec[_loc1_]["MC_BackEffect"].gotoAndStop(2);
            _loc2_ = this.FNumberVec[_loc1_]["MC_BackEffect"]["TF_MainName"];
            _loc2_.text = this.FCurvec[_loc1_].toString();
            this.FNumberVec[_loc1_]["MC_BackEffect"].gotoAndStop(10);
            _loc2_ = this.FNumberVec[_loc1_]["MC_BackEffect"]["TF_MainName"];
            _loc2_.text = this.FCurvec[_loc1_].toString();
            this.FNumberVec[_loc1_]["MC_BackEffect"].gotoAndStop(12);
            _loc2_ = this.FNumberVec[_loc1_]["MC_BackEffect"]["TF_MainName"];
            _loc2_.text = this.FCurvec[_loc1_].toString();
            this.FNumberVec[_loc1_]["MC_BackEffect"].gotoAndStop(1);
            _loc1_++;
         }
      }
      
      public function UpdateView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TextField = null;
         _loc1_ = 0;
         while(_loc1_ < ERSHILIU)
         {
            if(this.GetBooBelBy(this.FCurvec[_loc1_],1))
            {
               this.FNumberVec[_loc1_]["MC_BackEffect"].gotoAndStop(12);
            }
            else
            {
               this.FNumberVec[_loc1_]["MC_BackEffect"].gotoAndStop(1);
            }
            _loc2_ = this.FNumberVec[_loc1_]["MC_BackEffect"]["TF_MainName"];
            _loc2_.text = this.FCurvec[_loc1_].toString();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < ERSHILIU)
         {
            if(this.GetBooBelBy(_loc1_,0))
            {
               this.FWanOuVec[_loc1_].visible = false;
            }
            else
            {
               this.FWanOuVec[_loc1_].visible = true;
            }
            _loc1_++;
         }
         this.FMC_CanceIsClisk = false;
         this.FMC_SureBtnClickIsClisk = false;
         this.UpdateDescription();
         this.UpdateJiLu();
         this.UpdateChangeed();
      }
      
      protected function UpdateJiLu() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:Date = null;
         this.FScrollBar.Clear();
         this.CurStr = "";
         this.CurStr += new ConsumeFrameCopy(STRING_THEWORLDTREE.str34).DescribeString;
         _loc1_ = 0;
         while(_loc1_ < this.FLogicDate.MaoXianJiLuVec.length / 2)
         {
            _loc2_ = _loc1_ * 2;
            _loc4_ = new Date(STimingCore.GetClientShowTime(this.FLogicDate.MaoXianJiLuVec[_loc2_]) * 1000);
            _loc3_ = TUtilityDate.FormatDateChineseNewCopy(_loc4_);
            this.CurStr += TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str35).DescribeString,_loc3_,this.FLogicDate.MaoXianJiLuVec[_loc2_ + 1]);
            _loc1_++;
         }
         this.CurTextField.htmlText = this.CurStr;
         this.CurTextField.x = 0;
         this.CurTextField.y = 0;
         this.CurTextField.width = 250;
         this.CurTextField.height = this.CurTextField.textHeight + 40;
         this.FScrollBar.AddItem(this.CurTextField);
         this.FScrollBar.ScrollToDown();
      }
      
      public function Rest() : void
      {
         this.FMC_CanceIsClisk = false;
         this.FIsCanClick = true;
      }
      
      protected function UpdateStateDec() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc1_ = this.FLogicDate.ShieldingVec.length / 2;
         if(this.FLogicDate.CurProgressState == 2)
         {
            this.FLogicDate.WhatTheFuck = 1;
         }
         else if(this.FLogicDate.CurProgressState == 1)
         {
            this.FLogicDate.WhatTheFuck = 0;
         }
         else
         {
            _loc1_--;
            _loc2_ = 0;
            while(_loc2_ < this.FLogicDate.OneTimesbabyCount.length)
            {
               _loc3_ += this.FLogicDate.OneTimesbabyCount[_loc2_];
               if(_loc1_ <= _loc3_)
               {
                  if(_loc1_ == _loc3_)
                  {
                     if(_loc2_ == this.FLogicDate.OneTimesbabyCount.length - 1)
                     {
                        if(this.FBackFunction != null)
                        {
                           this.FBackFunction(300);
                        }
                        return;
                     }
                     if(!this.FMC_CanceIsClisk)
                     {
                        this.FLogicDate.WhatTheFuck = 4;
                     }
                     else
                     {
                        if(_loc2_ == 0 && !this.FMC_SureBtnClickIsClisk && _loc1_ != _loc3_)
                        {
                           this.FLogicDate.WhatTheFuck = 3;
                        }
                        else
                        {
                           this.FLogicDate.WhatTheFuck = 2;
                        }
                        if(_loc2_ + 1 < this.FLogicDate.OneTimesbabyCount.length)
                        {
                           _loc3_ += this.FLogicDate.OneTimesbabyCount[_loc2_ + 1];
                        }
                     }
                  }
                  else if(_loc1_ == _loc3_ + 1 && _loc2_ == 0 && !this.FMC_SureBtnClickIsClisk)
                  {
                     this.FLogicDate.WhatTheFuck = 3;
                  }
                  else if(_loc1_ + this.FLogicDate.OneTimesbabyCount[_loc2_] == _loc3_ && _loc2_ == 0 && !this.FMC_SureBtnClickIsClisk)
                  {
                     this.FLogicDate.WhatTheFuck = 3;
                  }
                  else
                  {
                     if(_loc1_ == _loc3_)
                     {
                        if(_loc2_ + 1 < this.FLogicDate.OneTimesbabyCount.length)
                        {
                           _loc3_ += this.FLogicDate.OneTimesbabyCount[_loc2_ + 1];
                        }
                     }
                     this.FLogicDate.WhatTheFuck = 2;
                  }
                  this.FCurShengyuWanOuCount = _loc3_ - _loc1_;
                  break;
               }
               _loc2_++;
            }
         }
         this.UpdateFourPanelState();
      }
      
      protected function UpdateFourPanelState() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            this.FCurStateMcVector[_loc1_].visible = false;
            _loc1_++;
         }
         switch(this.FLogicDate.WhatTheFuck)
         {
            case 0:
               this.FCurStateMcVector[0].visible = true;
               break;
            case 1:
               this.FCurStateMcVector[1].visible = true;
               break;
            case 2:
               this.FCurStateMcVector[2].visible = true;
               this.FMC_SureBtnClick.visible = false;
               break;
            case 3:
               this.FCurStateMcVector[2].visible = true;
               this.FMC_SureBtnClick.visible = true;
               break;
            case 4:
               this.FCurStateMcVector[3].visible = true;
         }
         this.UpdateForLittlePanel();
      }
      
      protected function UpdateForLittlePanel() : void
      {
         var _loc1_:TextField = null;
         if(this.FCurStateMcVector[2].visible)
         {
            _loc1_ = this.FCurStateMcVector[2]["TF_Count"];
            _loc1_.text = this.FCurShengyuWanOuCount.toString();
            if(this.FMC_SureBtnClick.visible)
            {
               this.FMC_SureBtnText.text = new ConsumeFrameCopy(STRING_THEWORLDTREE.str38).DescribeString;
            }
            else
            {
               this.FMC_SureBtnText.text = new ConsumeFrameCopy(STRING_THEWORLDTREE.str39).DescribeString;
            }
         }
         if(this.FCurStateMcVector[3].visible)
         {
            _loc1_ = this.FCurStateMcVector[3]["TF_Count"];
            _loc1_.text = this.FLogicDate.SystemBid.toString();
         }
      }
      
      public function UpdateViewBySilverCoin(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TextField = null;
         _loc2_ = 0;
         while(_loc2_ < ERSHILIU)
         {
            if(this.FCurvec[_loc2_] == param1)
            {
               this.FTiaoFreamSetValue.SetEffectPanel(this.FNumberVec[_loc2_]["MC_BackEffect"],this.FCurvec[_loc2_]);
               this.FTiaoFreamSetValue.playEffect();
               break;
            }
            _loc2_++;
         }
         this.FWanOuVec[this.CurBallId - 1].visible = false;
         this.FLogicDate.ShieldingVec.push(this.CurBallId - 1);
         this.FLogicDate.ShieldingVec.push(param1);
         this.FMC_CanceIsClisk = false;
         this.UpdateStateDec();
         this.UpdateChangeed();
      }
      
      protected function UpdateChangeed() : void
      {
         var _loc1_:int = 0;
         if(this.FLogicDate.CurProgressState > 2)
         {
            _loc1_ = int(this.FLogicDate.ShieldingVec[0]);
            _loc1_++;
            this.FTF_Dec.text = _loc1_.toString();
            this.FMC_Nimei.visible = true;
         }
         else
         {
            this.FTF_Dec.text = "";
            this.FMC_Nimei.visible = false;
         }
      }
      
      protected function GetBooBelBy(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this.FLogicDate.ShieldingVec.length / 2)
         {
            if(this.FLogicDate.ShieldingVec[_loc3_ * 2 + param2] == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function UpdateDescription() : void
      {
         this.FMC_CanceIsClisk = false;
         this.FMC_SureBtnClickIsClisk = false;
         this.UpdateStateDec();
      }
      
      protected function WanOuOver(param1:MouseEvent) : void
      {
         param1.currentTarget.gotoAndStop(2);
      }
      
      protected function WanOuOut(param1:MouseEvent) : void
      {
         param1.currentTarget.gotoAndStop(1);
      }
      
      protected function TiaoFreamBackFu() : void
      {
         this.FIsCanClick = true;
      }
      
      protected function WanOuClick(param1:MouseEvent) : void
      {
         if(this.FLogicDate.CurProgressState == 1)
         {
            this.FPiaoZi(new ConsumeFrameCopy(STRING_THEWORLDTREE.str31).DescribeString);
            return;
         }
         if(!this.FIsCanClick)
         {
            this.FPiaoZi(new ConsumeFrameCopy(STRING_THEWORLDTREE.str33).DescribeString);
            return;
         }
         if(this.FCurStateMcVector[3].visible)
         {
            this.FPiaoZi(new ConsumeFrameCopy(STRING_THEWORLDTREE.str36).DescribeString);
            return;
         }
         if(this.FMC_SureBtnClick.visible)
         {
            this.FPiaoZi(new ConsumeFrameCopy(STRING_THEWORLDTREE.str37).DescribeString);
            return;
         }
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:Array = _loc2_.split("_");
         var _loc4_:int = int(_loc3_[2]);
         this.CurBallId = _loc4_ + 1;
         if(this.FBackFunction != null)
         {
            this.FBackFunction(this.CurBallId - 1);
         }
      }
      
      protected function CloseClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_HelpClose["BTN_Close"]:
               this.FOnCloseFun();
               break;
            case this.FBtn_BegineMaoXian:
               if(this.FBackFunction != null)
               {
                  this.FBackFunction(100);
               }
               break;
            case this.FMC_GoToTheWordTree:
               if(this.FBackFunction != null)
               {
                  this.FBackFunction(200);
               }
               break;
            case this.FMC_Sure:
               this.FLogicDate.SureBtnIsClick = true;
               if(this.FBackFunction != null)
               {
                  this.FBackFunction(300);
               }
               break;
            case this.FMC_Cance:
               this.FMC_CanceIsClisk = true;
               this.FMC_SureBtnClickIsClisk = false;
               this.UpdateStateDec();
               break;
            case this.FMC_SureBtnClick:
               this.FMC_SureBtnClickIsClisk = true;
               this.FIsCanClick = true;
               this.UpdateStateDec();
         }
      }
      
      public function GameOver() : void
      {
         this.FLogicDate.WhatTheFuck = 5;
         this.UpdateFourPanelState();
      }
      
      public function LogicsPerform() : void
      {
         if(!this.FThisPanel)
         {
            return;
         }
         if(!this.FThisPanel.visible)
         {
            return;
         }
         this.FTF_HaveSilverCoin.text = SLogicsCore.Character.CreditSilverCoin.ToNumber().toString();
      }
      
      public function get ThisPanel() : Sprite
      {
         return this.FThisPanel;
      }
      
      public function get MC_Close() : MovieClip
      {
         return this.FMC_HelpClose;
      }
      
      public function set BackFunction(param1:Function) : void
      {
         this.FBackFunction = param1;
      }
      
      public function set PiaoZi(param1:Function) : void
      {
         this.FPiaoZi = param1;
      }
      
      public function set OnCloseFun(param1:Function) : void
      {
         this.FOnCloseFun = param1;
      }
   }
}

