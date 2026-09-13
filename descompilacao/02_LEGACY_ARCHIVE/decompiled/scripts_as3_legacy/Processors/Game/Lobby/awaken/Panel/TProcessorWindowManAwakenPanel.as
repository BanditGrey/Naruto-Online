package Processors.Game.Lobby.awaken.Panel
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Tools.MvcPlayEffect;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Processors.Game.Lobby.awaken.cell.BaseCell;
   import Processors.Game.Lobby.awaken.cell.ThreeCell;
   import Processors.Game.Lobby.awaken.date.AwakenDateCELL;
   import Processors.Game.Lobby.awaken.date.AwakenLogicDate;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_BLOODFETE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_AWAKEN;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   
   public class TProcessorWindowManAwakenPanel extends TProcessorGame
   {
      
      public static const Three:int = 3;
      
      public static const ThenThree:int = 13;
      
      public static const AllFream:int = 25;
      
      protected var FThisPanel:Sprite;
      
      protected var FIsInitilization:int;
      
      protected var FMC_Close:SimpleButton;
      
      protected var FMC_Help:SimpleButton;
      
      protected var FMC_BtnCombining:SimpleButton = null;
      
      protected var FMC_BtnAwaken:SimpleButton = null;
      
      protected var FAppendtext:TextField = null;
      
      protected var FMC_BtnChange:MovieClip = null;
      
      protected var FThreeVec:Vector.<ThreeCell> = null;
      
      protected var FThenThreeVec:Vector.<BaseCell>;
      
      protected var FCurDate:AwakenLogicDate;
      
      protected var FT_SilverCoin:TextField = null;
      
      protected var FT_Gold:TextField = null;
      
      protected var FT_Coupon:TextField = null;
      
      protected var IsRun:Boolean;
      
      protected var CurIndex:int;
      
      protected var FMvcPlayEffect:MvcPlayEffect;
      
      protected var FTimer:Timer;
      
      protected var FCloseFunction:Function = null;
      
      protected var FOpenOthersPanel:Function = null;
      
      protected var FBackFun:Function = null;
      
      protected var FBackFunMove:Function;
      
      protected var FBackFunOut:Function;
      
      protected var FBackFunOver:Function;
      
      protected var FBackOver:Function;
      
      protected var FBackOut:Function;
      
      protected var FBackMove:Function;
      
      protected var FBackFOver:Function;
      
      public function TProcessorWindowManAwakenPanel(param1:TUIComponent)
      {
         super(param1);
         this.FThreeVec = new Vector.<ThreeCell>(Three);
         this.FCurDate = SLogicsCore.AwakenDate;
         this.FThenThreeVec = new Vector.<BaseCell>(ThenThree);
         this.FMvcPlayEffect = new MvcPlayEffect(this.EffectPlayerOver,AllFream);
         this.FTimer = new Timer(3000,1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BLOODFETE.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      public function set SetPanel(param1:Sprite) : void
      {
         this.FThisPanel = param1;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ThreeCell = null;
         var _loc3_:BaseCell = null;
         this.FMC_Help = this.FThisPanel["MC_Help"];
         this.FMC_Close = this.FThisPanel["MC_Close"];
         this.FMC_BtnCombining = this.FThisPanel["mc_Campaign"]["MC_BtnCombining"];
         this.FMC_BtnAwaken = this.FThisPanel["mc_Campaign"]["MC_BtnAwaken"];
         this.FMC_BtnChange = this.FThisPanel["mc_Campaign"]["MC_BtnChange"];
         this.FAppendtext = this.FThisPanel["mc_Campaign"]["TF_JiLu"];
         this.FT_SilverCoin = this.FThisPanel["mc_Campaign"]["FT_SilverCoin"];
         this.FT_Gold = this.FThisPanel["mc_Campaign"]["FT_Gold"];
         this.FT_Coupon = this.FThisPanel["mc_Campaign"]["FT_Coupon"];
         new Tools_Help(Parent,this.FMC_Help,70170086,FUICore);
         TGameUtil.setButtonMode(this.FMC_BtnChange,true);
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            _loc2_ = new ThreeCell(this.FThisPanel["mc_Campaign"]["MC_Explore_" + _loc1_],_loc1_);
            _loc2_.BackFun = this.ThreeCellBackFun;
            _loc2_.NiMeiFunction = this.NiMeiFunction;
            _loc2_.BackFunMove = this.FBackFunMove;
            _loc2_.BackFunOut = this.FBackFunOut;
            _loc2_.BackFunOver = this.FBackFunOver;
            _loc2_.BackOver = this.FBackFOver;
            _loc2_.BackOut = this.FBackFunOut;
            _loc2_.BackMove = this.FBackFunMove;
            this.FThreeVec[_loc1_] = _loc2_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < ThenThree)
         {
            _loc3_ = new BaseCell();
            _loc3_.SetPanel(this.FThisPanel["mc_Campaign"]["MC_Slot_" + _loc1_]);
            this.FThenThreeVec[_loc1_] = _loc3_;
            this.FThenThreeVec[_loc1_].BackOver = this.FBackOver;
            this.FThenThreeVec[_loc1_].BackOut = this.FBackOut;
            this.FThenThreeVec[_loc1_].BackMove = this.FBackMove;
            _loc1_++;
         }
         this.SetVisibel();
         this.FIsInitilization = 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function BackOver(param1:int, param2:int) : void
      {
         if(this.FBackFOver != null)
         {
            this.FBackFOver(param1,param2);
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.AddEventlistener();
         super.ResourcesPerform_UILocations();
      }
      
      public function UpdateImage() : void
      {
         if(!this.FIsInitilization)
         {
            return;
         }
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < ThenThree)
         {
            if(this.FThenThreeVec[0].ThisPanel.visible == false)
            {
               break;
            }
            this.FThenThreeVec[_loc1_].UpdateImage();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            this.FThreeVec[_loc1_].UpdateImage();
            _loc1_++;
         }
         this.UpdateFream();
         this.updateMoney();
      }
      
      protected function AddEventlistener() : void
      {
         this.FMC_Close.addEventListener(MouseEvent.CLICK,this.ClickHandler);
         this.FMC_BtnCombining.addEventListener(MouseEvent.CLICK,this.ClickHandler);
         this.FMC_BtnAwaken.addEventListener(MouseEvent.CLICK,this.ClickHandler);
         this.FMC_BtnChange.addEventListener(MouseEvent.CLICK,this.ClickHandler);
         this.FTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.TimerHandle);
      }
      
      protected function ClickHandler(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_Close:
               if(this.FCloseFunction != null)
               {
                  this.FCloseFunction();
               }
               break;
            case this.FMC_BtnCombining:
               if(this.FOpenOthersPanel != null)
               {
                  this.FOpenOthersPanel(3);
               }
               break;
            case this.FMC_BtnAwaken:
               if(this.FOpenOthersPanel != null)
               {
                  this.FOpenOthersPanel(4);
               }
               break;
            case this.FMC_BtnChange:
               if(this.FOpenOthersPanel != null)
               {
                  this.FOpenOthersPanel(2);
               }
         }
      }
      
      public function UpdateView() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < Three)
         {
            this.FThreeVec[_loc1_].UpdateView();
            _loc1_++;
         }
      }
      
      public function UpdategetRewardNone() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = "";
         _loc1_ = 0;
         while(_loc1_ < this.FCurDate.GetRewardTakeNotes.length)
         {
            _loc2_ += TUtilityString.Format(STRING_AWAKEN.Str1,CONST_COMMON.QUALITYCOLOR_INDEX_1[this.FCurDate.GetRewardTakeNotes[_loc1_].AwakenConfigDate.Quality],this.FCurDate.GetRewardTakeNotes[_loc1_].AwakenConfigDate.Name,this.FCurDate.GetRewardTakeNotes[_loc1_].Count);
            _loc1_++;
         }
         this.FAppendtext.htmlText = _loc2_;
      }
      
      public function updateMoney() : void
      {
         this.FT_SilverCoin.text = SLogicsCore.Character.CreditSilverCoin.ToString();
         this.FT_Gold.text = SLogicsCore.Character.CreditGold.toString();
         this.FT_Coupon.text = SLogicsCore.Character.CreditGiftCertificate.toString();
      }
      
      override protected function ProcessorResize() : void
      {
         if(this.FThisPanel)
         {
            this.FMC_Close.x = FUICore.StageWidth - this.FMC_Close.width;
            this.FMC_Help.x = FUICore.StageWidth - this.FMC_Close.width - this.FMC_Help.width;
         }
      }
      
      public function StartPlayer() : void
      {
         this.FThreeVec[this.CurIndex].MC_Effect1.visible = true;
         this.FThreeVec[this.CurIndex].MC_Effect1.gotoAndStop(1);
         this.FMvcPlayEffect.SetEffectPanel(this.FThreeVec[this.CurIndex].MC_Effect1);
         this.FMvcPlayEffect.playEffect();
      }
      
      protected function NiMeiFunction() : void
      {
         if(!this.FTimer.running)
         {
            return;
         }
         this.TempFunction();
      }
      
      protected function TimerHandle(param1:TimerEvent) : void
      {
         this.TempFunction();
      }
      
      protected function TempFunction() : void
      {
         this.FTimer.stop();
         this.FTimer.reset();
         this.SetVisibel();
         this.FThreeVec[this.CurIndex].MC_Effect1.visible = true;
         this.IsRun = true;
         this.FThreeVec[this.CurIndex].MC_Effect1.gotoAndPlay(56);
         this.UpdategetRewardNone();
      }
      
      protected function EffectPlayerOver() : void
      {
         var _loc1_:int = 0;
         var _loc2_:AwakenDateCELL = null;
         _loc1_ = 0;
         while(_loc1_ < this.FCurDate.TanSuoIdVec.length)
         {
            _loc2_ = new AwakenDateCELL();
            _loc2_.SetValueById(this.FCurDate.TanSuoIdVec[_loc1_]);
            _loc2_.Count = this.FCurDate.TanSuoCountVec[_loc1_];
            this.FThenThreeVec[_loc1_].SetDate(_loc2_);
            this.FThenThreeVec[_loc1_].ThisPanel.visible = true;
            _loc1_++;
         }
         this.FThreeVec[this.CurIndex].MC_Effect1.visible = false;
         this.FTimer.start();
      }
      
      public function UpdateFream() : void
      {
         if(this.IsRun)
         {
            if(this.FThreeVec[this.CurIndex].MC_Effect1.currentFrame >= 75)
            {
               this.IsRun = false;
               this.FCurDate.TanSuoBtnIsCanClick = 0;
            }
         }
      }
      
      protected function SetVisibel() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < ThenThree)
         {
            this.FThenThreeVec[_loc1_].ThisPanel.visible = false;
            _loc1_++;
         }
      }
      
      protected function ThreeCellBackFun(param1:uint, param2:int) : void
      {
         this.CurIndex = param2;
         this.FThreeVec[this.CurIndex].MC_g.gotoAndStop(1);
         this.FThreeVec[this.CurIndex].MC_g.gotoAndPlay(1);
         if(this.FBackFun != null)
         {
            this.FBackFun(param1);
         }
      }
      
      public function UpdateTip() : void
      {
         this.FThreeVec[this.CurIndex].UpdateTip();
      }
      
      public function set BackFOver(param1:Function) : void
      {
         this.FBackFOver = param1;
      }
      
      public function set BackFunMove(param1:Function) : void
      {
         this.FBackFunMove = param1;
      }
      
      public function set BackFunOut(param1:Function) : void
      {
         this.FBackFunOut = param1;
      }
      
      public function set BackFunOver(param1:Function) : void
      {
         this.FBackFunOver = param1;
      }
      
      public function set BackFun(param1:Function) : void
      {
         this.FBackFun = param1;
      }
      
      public function set BackOver(param1:Function) : void
      {
         this.FBackOver = param1;
      }
      
      public function set BackOut(param1:Function) : void
      {
         this.FBackOut = param1;
      }
      
      public function set BackMove(param1:Function) : void
      {
         this.FBackMove = param1;
      }
      
      public function set OpenOthersPanel(param1:Function) : void
      {
         this.FOpenOthersPanel = param1;
      }
      
      public function set CloseFunction(param1:Function) : void
      {
         this.FCloseFunction = param1;
      }
   }
}

