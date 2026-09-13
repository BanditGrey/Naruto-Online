package Processors.Game.Lobby.awaken.cell
{
   import Foundation.Timing.STimingCore;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_AWAKEN;
   import Resources.Strings.STRING_AWAKEN;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class ThreeCell
   {
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FMC_Campaign:MovieClip = null;
      
      protected var FMC_BigCampaign:MovieClip = null;
      
      protected var FSlotVec:Vector.<MovieClip>;
      
      protected var FTF_Times:TextField = null;
      
      protected var Fmc_bg:MovieClip = null;
      
      protected var FMC_Bg:MovieClip = null;
      
      protected var FMC_Effect1:MovieClip = null;
      
      protected var FMC_Effect2:MovieClip = null;
      
      protected var VecLength:int;
      
      protected var FCurIndex:int;
      
      protected var CurType:int;
      
      protected var FIsDaoJishiMian:int;
      
      protected var ZJZ:int;
      
      protected var TanSuoId:uint;
      
      protected var FTF_NiMei_A:TextField;
      
      protected var FBackFun:Function = null;
      
      protected var FTeShuBackMove:Function = null;
      
      protected var FTeShuBackOut:Function = null;
      
      protected var FTeShuBackOver:Function = null;
      
      protected var FBackFunMove:Function;
      
      protected var FBackFunOut:Function;
      
      protected var FBackFunOver:Function;
      
      protected var FNiMeiFunction:Function;
      
      public function ThreeCell(param1:MovieClip, param2:int)
      {
         super();
         this.FThisPanel = param1;
         this.FCurIndex = param2;
         if(param2 == 1)
         {
            this.VecLength = 4;
         }
         else
         {
            this.VecLength = 3;
         }
         this.FSlotVec = new Vector.<MovieClip>(this.VecLength);
         this.Initilization();
      }
      
      protected function Initilization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FMC_Campaign = this.FThisPanel["MC_Campaign"];
         this.FTF_NiMei_A = this.FMC_Campaign["TF_NiMei_A"];
         this.FTF_NiMei_A.mouseEnabled = false;
         this.FMC_BigCampaign = this.FThisPanel["MC_BigCampaign"];
         this.FTF_Times = this.FThisPanel["TF_Times"];
         this.Fmc_bg = this.FThisPanel["mc_bg"];
         if(this.FCurIndex == 2)
         {
            this.Fmc_bg.gotoAndStop(2);
            this.FMC_Effect1 = this.FThisPanel["MC_Effect1"];
            this.FMC_Effect2 = this.FThisPanel["MC_Effect0"];
            this.FMC_Effect2.visible = false;
            this.FMC_Bg = this.Fmc_bg["MC_Bg"];
            _loc2_ = 2;
         }
         if(this.FCurIndex == 0)
         {
            this.FMC_Effect1 = this.FThisPanel["MC_Effect0"];
            this.FMC_Effect2 = this.FThisPanel["MC_Effect1"];
            this.FMC_Effect2.visible = false;
            this.FMC_Bg = this.Fmc_bg["MC_Bg"];
            _loc2_ = 1;
         }
         if(this.FCurIndex == 1)
         {
            this.FMC_Effect1 = this.FThisPanel["MC_Effect0"];
            this.FMC_Bg = this.FThisPanel["mc_bg"];
            _loc2_ = 1;
         }
         this.FMC_Effect1.visible = false;
         _loc1_ = 0;
         while(_loc1_ < this.VecLength)
         {
            this.FSlotVec[_loc1_] = this.FThisPanel["MC_Slot_" + _loc1_];
            this.FSlotVec[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.FBackOver);
            this.FSlotVec[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.FBackOut);
            this.FSlotVec[_loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.FBackMove);
            MovieClip(this.FSlotVec[_loc1_]["MC_Bmp_Icon_Copy"]).gotoAndStop(_loc1_ + _loc2_);
            _loc1_++;
         }
         this.FMC_Campaign.addEventListener(MouseEvent.CLICK,this.HealdClick);
         this.FMC_Campaign.addEventListener(MouseEvent.MOUSE_OVER,this.TOver);
         this.FMC_Campaign.addEventListener(MouseEvent.MOUSE_OUT,this.TOut);
         this.FMC_Campaign.addEventListener(MouseEvent.MOUSE_MOVE,this.TMove);
         this.FMC_BigCampaign.addEventListener(MouseEvent.CLICK,this.HealdClick);
         this.FMC_BigCampaign.addEventListener(MouseEvent.MOUSE_OVER,this.TOver);
         this.FMC_BigCampaign.addEventListener(MouseEvent.MOUSE_OUT,this.TOut);
         this.FMC_BigCampaign.addEventListener(MouseEvent.MOUSE_MOVE,this.TMove);
      }
      
      protected function FBackOver(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.charAt(_loc2_.length - 1));
         if(this.FTeShuBackOver != null)
         {
            this.FTeShuBackOver(this.FCurIndex,_loc3_);
         }
      }
      
      protected function FBackOut(param1:MouseEvent) : void
      {
         if(this.FTeShuBackOut != null)
         {
            this.FTeShuBackOut();
         }
      }
      
      protected function FBackMove(param1:MouseEvent) : void
      {
         if(this.FTeShuBackMove != null)
         {
            this.FTeShuBackMove();
         }
      }
      
      public function set BackMove(param1:Function) : void
      {
         this.FTeShuBackMove = param1;
      }
      
      public function set BackOut(param1:Function) : void
      {
         this.FTeShuBackOut = param1;
      }
      
      public function set BackOver(param1:Function) : void
      {
         this.FTeShuBackOver = param1;
      }
      
      public function set NiMeiFunction(param1:Function) : void
      {
         this.FNiMeiFunction = param1;
      }
      
      protected function HealdClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.currentTarget)
         {
            case this.FMC_Campaign:
               if(!this.FMC_Campaign.buttonMode || SLogicsCore.AwakenDate.TanSuoBtnIsCanClick == 7)
               {
                  if(this.FNiMeiFunction != null)
                  {
                     this.FNiMeiFunction();
                  }
                  return;
               }
               _loc2_ = 1;
               break;
            case this.FMC_BigCampaign:
               if(!this.FMC_BigCampaign.buttonMode || SLogicsCore.AwakenDate.TanSuoBtnIsCanClick == 7)
               {
                  if(this.FNiMeiFunction != null)
                  {
                     this.FNiMeiFunction();
                  }
                  return;
               }
               _loc2_ = 2;
         }
         this.GetIdByType(_loc2_);
         SLogicsCore.AwakenDate.TanSuoBtnIsCanClick = 7;
         if(this.FBackFun != null)
         {
            this.FBackFun(this.TanSuoId,this.FCurIndex);
         }
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
      
      public function TMove(param1:MouseEvent) : void
      {
         this.FBackFunMove();
      }
      
      public function TOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.currentTarget)
         {
            case this.FMC_Campaign:
               _loc2_ = 1;
               break;
            case this.FMC_BigCampaign:
               _loc2_ = 2;
         }
         this.CurType = _loc2_;
         this.FBackFunOver(this.GetIdByType(_loc2_),this.FCurIndex,this.CurType);
      }
      
      public function UpdateTip() : void
      {
         this.FBackFunOver(this.GetIdByType(this.CurType),this.FCurIndex,this.CurType);
      }
      
      public function TOut(param1:MouseEvent) : void
      {
         this.FBackFunOut();
      }
      
      protected function GetMastDanCiCountByType(param1:int) : uint
      {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case 0:
               _loc2_ = uint(SLogicsCore.AwakenDate.DiJiDanCiMastCount);
               break;
            case 1:
               _loc2_ = uint(SLogicsCore.AwakenDate.ZhongJiDanCiMastCount);
               break;
            case 2:
               _loc2_ = uint(SLogicsCore.AwakenDate.GaoJiDanCiMastCount);
         }
         return _loc2_;
      }
      
      protected function GetMastPiLiangCountByType(param1:int) : uint
      {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case 0:
               _loc2_ = uint(SLogicsCore.AwakenDate.DiJiPiLiangDanCiMastCount);
               break;
            case 1:
               _loc2_ = uint(SLogicsCore.AwakenDate.ZhongJiPiLiangDanCiMastCount);
               break;
            case 2:
               _loc2_ = uint(SLogicsCore.AwakenDate.GaoJiPiLiangDanCiMastCount);
         }
         return _loc2_;
      }
      
      public function UpdateView() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:uint = 0;
         this.FTF_NiMei_A.text = STRING_AWAKEN.Str777_3;
         if(this.FIsDaoJishiMian)
         {
            _loc1_ = true;
            this.FTF_NiMei_A.text = STRING_AWAKEN.Str777_1;
         }
         else
         {
            _loc2_ = uint(SLogicsCore.AwakenDate.GetDaoJuCountAtBeiBaoByType(this.FCurIndex));
            if(_loc2_ >= SLogicsCore.AwakenDate.GetArrByType(this.FCurIndex)[1])
            {
               _loc1_ = true;
               this.FTF_NiMei_A.text = TUtilityString.Format(STRING_AWAKEN.Str777_2,_loc2_);
            }
            else
            {
               _loc2_ = uint(SLogicsCore.AwakenDate.DanCiCountVec[this.FCurIndex]);
               if(_loc2_ < this.GetMastDanCiCountByType(this.FCurIndex))
               {
                  _loc1_ = true;
               }
            }
         }
         TGameUtil.setButtonMode(this.FMC_Campaign,_loc1_);
         _loc1_ = false;
         if(SLogicsCore.AwakenDate.PiLiangCountVec[this.FCurIndex] < this.GetMastPiLiangCountByType(this.FCurIndex))
         {
            _loc1_ = true;
         }
         TGameUtil.setButtonMode(this.FMC_BigCampaign,_loc1_);
      }
      
      public function UpdateImage() : void
      {
         var _loc1_:int = 0;
         _loc1_ = SLogicsCore.AwakenDate.NextTimesVec[this.FCurIndex] - STimingCore.GetServerTick();
         if(_loc1_ <= 0)
         {
            this.FIsDaoJishiMian = 1;
         }
         else
         {
            this.FIsDaoJishiMian = 0;
         }
         if(this.ZJZ != this.FIsDaoJishiMian)
         {
            this.UpdateView();
            this.ZJZ = this.FIsDaoJishiMian;
         }
         this.FTF_Times.text = TGameUtil.fomatTime(_loc1_);
      }
      
      protected function GetIdByType(param1:int = 1) : uint
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Vector.<uint> = null;
         if(Boolean(this.FIsDaoJishiMian) && param1 == 1)
         {
            _loc3_ = 3;
            _loc4_ = 0;
         }
         else if(Boolean(SLogicsCore.AwakenDate.GetDaoJuCountAtBeiBaoByType(this.FCurIndex)) && param1 == 1)
         {
            _loc3_ = 4;
            _loc4_ = 0;
         }
         else if(param1 == 1)
         {
            _loc3_ = 1;
            _loc5_ = SLogicsCore.AwakenDate.DanCiCountVec;
            _loc4_ = _loc5_[this.FCurIndex] + 1;
         }
         else
         {
            _loc3_ = 2;
            _loc5_ = SLogicsCore.AwakenDate.PiLiangCountVec;
            _loc4_ = _loc5_[this.FCurIndex] + 1;
         }
         this.TanSuoId = CONST_AWAKEN.BaseNum + CONST_AWAKEN.BaseNumTwo * (this.FCurIndex + 1) + CONST_AWAKEN.BaseNumThree * _loc3_ + _loc4_;
         return this.TanSuoId;
      }
      
      public function set BackFun(param1:Function) : void
      {
         this.FBackFun = param1;
      }
      
      public function get MC_Effect1() : MovieClip
      {
         return this.FMC_Effect1;
      }
      
      public function get MC_g() : MovieClip
      {
         return this.FMC_Bg;
      }
   }
}

