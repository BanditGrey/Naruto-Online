package Processors.Game.Lobby.Taboo.panel
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.Json.TDailyTaskReward;
   import Logics.DatebaseVO.VO.TTabooBattle;
   import Logics.DatebaseVO.VO.TTabooBattleConfig;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Taboo.Cell.TSixGuanQia;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_TABOO;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowCustoms extends TProcessorLobbyWindow
   {
      
      public static const SIX:int = 6;
      
      public static const THREE:int = 3;
      
      protected var MainPanel:Sprite = null;
      
      protected var FBtn_Close:SimpleButton = null;
      
      protected var FSixGuanQia:Vector.<TSixGuanQia> = new Vector.<TSixGuanQia>(SIX);
      
      protected var FIsInilization:Boolean;
      
      protected var FMC_AutoFightBtn:MovieClip = null;
      
      protected var FCurScreenindex:int;
      
      protected var FCurScreenId:int;
      
      protected var FDateBins:TBins = null;
      
      protected var FTF_Screen_Name:TextField = null;
      
      protected var FChangeBtn:Function;
      
      protected var FFirebtnBack:Function;
      
      protected var FGetTongGuanReward:Function;
      
      protected var FFireBtnTipFunOver:Function;
      
      protected var FFireBtnTipFunOut:Function;
      
      protected var FFireBtnTipFunMove:Function;
      
      protected var FAutoFightBtnTipM:Function;
      
      protected var FAutoFightBtnTipO:Function;
      
      protected var FCloseBackFun:Function;
      
      protected var FAutoFightFun:Function;
      
      public function TProcessorWindowCustoms(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TABOO.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
         this.MainPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_TABOO.MC_Customs) as Sprite;
         addChild(this.MainPanel);
         this.MainPanel.x = (FUICore.StageWidth - this.MainPanel.width) / 2;
         this.MainPanel.y = (FUICore.StageHeight - this.MainPanel.height) / 2;
         this.FBtn_Close = this.MainPanel["Btn_Close"];
         _loc1_ = 0;
         while(_loc1_ < SIX)
         {
            this.FSixGuanQia[_loc1_] = new TSixGuanQia();
            this.FSixGuanQia[_loc1_].FireBack = this.FireBack;
            this.FSixGuanQia[_loc1_].ChangeNanduBtn = this.ChangeNandu;
            this.FSixGuanQia[_loc1_].GetRewardFun = this.GetRewardFun;
            this.FSixGuanQia[_loc1_].FireBtnTipFunOver = this.FireFunOver;
            this.FSixGuanQia[_loc1_].FireBtnTipFunOut = this.FireFunOut;
            this.FSixGuanQia[_loc1_].FireBtnTipFunMove = this.FireFunMove;
            this.FSixGuanQia[_loc1_].SetPanel(this.MainPanel["MC_Custom_" + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FMC_AutoFightBtn = this.MainPanel["MC_AutoFightBtn"];
         this.FTF_Screen_Name = this.MainPanel["TF_Screen_Name"];
         this.FIsInilization = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FDateBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_TabooBattle);
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.MCClick);
         this.FMC_AutoFightBtn.addEventListener(MouseEvent.CLICK,this.MCClick);
         this.FMC_AutoFightBtn.addEventListener(MouseEvent.MOUSE_MOVE,this.FightBtnMove);
         this.FMC_AutoFightBtn.addEventListener(MouseEvent.MOUSE_OUT,this.FightBtnOut);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(this.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < SIX)
            {
               this.FSixGuanQia[_loc1_].UpdateImage();
               _loc1_++;
            }
         }
         super.LogicsPerform();
      }
      
      public function OpenThisPanel() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:TTabooBattle = null;
         _loc1_ = this.FDateBins.GetDatebaseByIndex(0) as TTabooBattle;
         _loc2_ = (this.FCurScreenindex - 1) * SIX * THREE + _loc1_.Identifier;
         _loc1_ = this.FDateBins.GetDatebaseByIdentifier(_loc2_) as TTabooBattle;
         this.FCurScreenId = _loc1_.Location;
         var _loc5_:TTabooBattleConfig = null;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TabooBattleConfig,this.FCurScreenId) as TTabooBattleConfig;
         this.FTF_Screen_Name.text = _loc5_.CampaignName;
         _loc3_ = 0;
         while(_loc3_ < SIX)
         {
            _loc4_ = 0;
            while(_loc4_ < THREE)
            {
               this.FSixGuanQia[_loc3_].VecBattle[_loc4_] = this.FDateBins.GetDatebaseByIdentifier(_loc2_ + _loc3_ * THREE + _loc4_) as TTabooBattle;
               _loc4_++;
            }
            this.FSixGuanQia[_loc3_].UpdateView();
            _loc3_++;
         }
         this.UpdateAutoBtn();
      }
      
      public function UpdateAutoBtn() : void
      {
         if(SLogicsCore.TBooData.ChallengeSurplusCount > 0)
         {
            if(Boolean(SLogicsCore.TBooData.GetGuanQiaCellByConfig(this.FSixGuanQia[0].VecBattle[0])) || Boolean(SLogicsCore.TBooData.GetGuanQiaCellByConfig(this.FSixGuanQia[0].VecBattle[1])) || Boolean(SLogicsCore.TBooData.GetGuanQiaCellByConfig(this.FSixGuanQia[0].VecBattle[2])))
            {
               TGameUtil.setButtonMode(this.FMC_AutoFightBtn,true);
            }
            else
            {
               TGameUtil.setButtonMode(this.FMC_AutoFightBtn,false);
            }
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_AutoFightBtn,false);
         }
      }
      
      public function UpdateByIndex(param1:int, param2:int) : void
      {
         this.FSixGuanQia[param2].CurNanduIndex = param1;
         this.FSixGuanQia[param2].UpdateView();
         this.UpdateAutoBtn();
      }
      
      public function set CloseBackFun(param1:Function) : void
      {
         this.FCloseBackFun = param1;
      }
      
      public function set AutoFightFun(param1:Function) : void
      {
         this.FAutoFightFun = param1;
      }
      
      protected function MCClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FBtn_Close:
               this.visible = false;
               this.FCloseBackFun();
               break;
            case this.FMC_AutoFightBtn:
               if(this.FAutoFightFun != null && this.FMC_AutoFightBtn.buttonMode)
               {
                  this.FAutoFightFun(this.FCurScreenId);
               }
         }
      }
      
      protected function FightBtnMove(param1:MouseEvent) : void
      {
         if(this.FAutoFightBtnTipM != null)
         {
            this.FAutoFightBtnTipM();
         }
      }
      
      protected function FightBtnOut(param1:MouseEvent) : void
      {
         if(this.FAutoFightBtnTipO != null)
         {
            this.FAutoFightBtnTipO();
         }
      }
      
      protected function FireFunOver(param1:Vector.<TDailyTaskReward>) : void
      {
         if(this.FFireBtnTipFunOver != null)
         {
            this.FFireBtnTipFunOver(param1);
         }
      }
      
      protected function FireFunOut() : void
      {
         if(this.FFireBtnTipFunOut != null)
         {
            this.FFireBtnTipFunOut();
         }
      }
      
      protected function FireFunMove() : void
      {
         if(this.FFireBtnTipFunMove != null)
         {
            this.FFireBtnTipFunMove();
         }
      }
      
      protected function GetRewardFun(param1:uint) : void
      {
         if(this.FGetTongGuanReward != null)
         {
            this.FGetTongGuanReward(param1);
         }
      }
      
      protected function ChangeNandu(param1:Vector.<TTabooBattle>, param2:int) : void
      {
         if(this.FChangeBtn != null)
         {
            this.FChangeBtn(param1,param2);
         }
      }
      
      protected function FireBack(param1:int) : void
      {
         if(this.FFirebtnBack != null)
         {
            this.FFirebtnBack(param1);
         }
      }
      
      public function set GetTongGuanReward(param1:Function) : void
      {
         this.FGetTongGuanReward = param1;
      }
      
      public function set ChangeBtn(param1:Function) : void
      {
         this.FChangeBtn = param1;
      }
      
      public function set FirebtnBack(param1:Function) : void
      {
         this.FFirebtnBack = param1;
      }
      
      public function set FireBtnTipFunOver(param1:Function) : void
      {
         this.FFireBtnTipFunOver = param1;
      }
      
      public function set FireBtnTipFunOut(param1:Function) : void
      {
         this.FFireBtnTipFunOut = param1;
      }
      
      public function set FireBtnTipFunMove(param1:Function) : void
      {
         this.FFireBtnTipFunMove = param1;
      }
      
      public function set AutoFightBtnTipM(param1:Function) : void
      {
         this.FAutoFightBtnTipM = param1;
      }
      
      public function set AutoFightBtnTipO(param1:Function) : void
      {
         this.FAutoFightBtnTipO = param1;
      }
      
      public function get CurScreenindex() : int
      {
         return this.FCurScreenindex;
      }
      
      public function set CurScreenindex(param1:int) : void
      {
         this.FCurScreenindex = param1;
      }
   }
}

