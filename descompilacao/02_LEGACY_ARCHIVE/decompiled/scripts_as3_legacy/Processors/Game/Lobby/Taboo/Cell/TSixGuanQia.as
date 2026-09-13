package Processors.Game.Lobby.Taboo.Cell
{
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TTabooBattle;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_TABOO;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TSixGuanQia
   {
      
      public static const Three:int = 3;
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FCurIndex:int;
      
      protected var FTF_Custom_Name:TextField = null;
      
      protected var FTF_Nandu_Name:TextField = null;
      
      protected var FMC_ChangeBtn:MovieClip = null;
      
      protected var FMC_Fire_Btn:MovieClip = null;
      
      protected var FMC_GetReward:MovieClip = null;
      
      protected var FImageBmp:MovieClip = null;
      
      protected var bmp:Bitmap;
      
      protected var CurImageId:uint;
      
      protected var FCurNanduIndex:int;
      
      protected var FVecBattle:Vector.<TTabooBattle> = null;
      
      protected var FFireBtnTipFunOver:Function;
      
      protected var FFireBtnTipFunOut:Function;
      
      protected var FFireBtnTipFunMove:Function;
      
      protected var FFireBack:Function;
      
      protected var FChangeNanduBtn:Function;
      
      protected var FGetRewardFun:Function;
      
      public function TSixGuanQia()
      {
         super();
         this.bmp = new Bitmap();
         this.FVecBattle = new Vector.<TTabooBattle>(Three);
      }
      
      public function SetPanel(param1:MovieClip, param2:int) : void
      {
         this.FThisPanel = param1;
         this.FCurIndex = param2;
         this.Initilization();
      }
      
      protected function Initilization() : void
      {
         this.FTF_Custom_Name = this.FThisPanel["TF_Custom_Name"];
         this.FTF_Nandu_Name = this.FThisPanel["TF_Nandu_Name"];
         this.FMC_ChangeBtn = this.FThisPanel["MC_ChangeBtn"];
         this.FMC_Fire_Btn = this.FThisPanel["MC_Fire_Btn"];
         this.FMC_GetReward = this.FThisPanel["MC_GetReward"];
         this.FImageBmp = this.FThisPanel["MC_HeadFirst"]["MC_Head"];
         this.FImageBmp.addChild(this.bmp);
         TGameUtil.setButtonMode(this.FMC_ChangeBtn,true);
         this.AddEventListener();
      }
      
      protected function AddEventListener() : void
      {
         this.FMC_ChangeBtn.addEventListener(MouseEvent.CLICK,this.McClick,false,0,true);
         this.FMC_Fire_Btn.addEventListener(MouseEvent.CLICK,this.McClick,false,0,true);
         this.FMC_Fire_Btn.addEventListener(MouseEvent.ROLL_OVER,this.McOver,false,0,true);
         this.FMC_Fire_Btn.addEventListener(MouseEvent.MOUSE_OUT,this.McOut,false,0,true);
         this.FMC_Fire_Btn.addEventListener(MouseEvent.MOUSE_UP,this.McUp,false,0,true);
         this.FMC_GetReward.addEventListener(MouseEvent.ROLL_OVER,this.McOver,false,0,true);
         this.FMC_GetReward.addEventListener(MouseEvent.MOUSE_OUT,this.McOut,false,0,true);
         this.FMC_GetReward.addEventListener(MouseEvent.MOUSE_MOVE,this.McMove,false,0,true);
         this.FMC_GetReward.addEventListener(MouseEvent.MOUSE_UP,this.McUp,false,0,true);
         this.FMC_GetReward.addEventListener(MouseEvent.CLICK,this.McClick,false,0,true);
      }
      
      public function UpdateView() : void
      {
         this.FTF_Custom_Name.text = TUtilityString.Format(STRING_TABOO.Str6,this.FVecBattle[0].SStage);
         this.CurImageId = this.FVecBattle[0].Image;
         this.UpdateNanduName();
         if(SLogicsCore.TBooData.CurStage == 6)
         {
            this.SetthisFilters(true);
            this.SetFireBtnState(2);
         }
         else if(SLogicsCore.TBooData.CurStage == 0)
         {
            if(this.FVecBattle[0].SStage == SLogicsCore.TBooData.CurStage + 1)
            {
               this.SetthisFilters(false);
               this.SetFireBtnState(0);
            }
            else
            {
               this.SetthisFilters(true);
               this.SetFireBtnState(1);
            }
         }
         else if(this.FVecBattle[0].SStage == SLogicsCore.TBooData.CurStage + 1 && this.FVecBattle[0].Location == SLogicsCore.TBooData.CurSceneIdentifier)
         {
            this.SetthisFilters(false);
            this.SetFireBtnState(0);
         }
         else
         {
            this.SetthisFilters(true);
            if(this.FVecBattle[0].SStage < SLogicsCore.TBooData.CurStage + 1)
            {
               this.SetFireBtnState(2);
            }
            else
            {
               this.SetFireBtnState(1);
            }
         }
         this.UpdateBeefOffal();
      }
      
      public function UpdateBeefOffal() : void
      {
         var _loc1_:int = 0;
         if(Boolean(SLogicsCore.TBooData.GetGuanQiaCellByConfig(this.FVecBattle[0])) && Boolean(SLogicsCore.TBooData.GetGuanQiaCellByConfig(this.FVecBattle[1])) && Boolean(SLogicsCore.TBooData.GetGuanQiaCellByConfig(this.FVecBattle[2])) && !SLogicsCore.TBooData.GetGuanQiaCellByConfig(this.FVecBattle[0]).IsGetRewards)
         {
            this.FMC_GetReward.gotoAndStop(1);
            this.FMC_GetReward.buttonMode = true;
         }
         else
         {
            this.FMC_GetReward.buttonMode = false;
            if(SLogicsCore.TBooData.GetGuanQiaCellByConfig(this.FVecBattle[0]))
            {
               if(SLogicsCore.TBooData.GetGuanQiaCellByConfig(this.FVecBattle[0]).IsGetRewards)
               {
                  this.FMC_GetReward.gotoAndStop(5);
               }
               else
               {
                  this.FMC_GetReward.gotoAndStop(4);
               }
            }
            else
            {
               this.FMC_GetReward.gotoAndStop(4);
            }
         }
      }
      
      public function UpdateNanduName() : void
      {
         this.FTF_Nandu_Name.text = STRING_TABOO.Str7[this.FVecBattle[0].CurNanDu];
      }
      
      protected function McOver(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_Fire_Btn:
               if(this.FMC_Fire_Btn.buttonMode)
               {
                  this.FMC_Fire_Btn.gotoAndStop(2);
               }
               break;
            case this.FMC_GetReward:
               if(this.FFireBtnTipFunOver != null)
               {
                  this.FFireBtnTipFunOver(this.FVecBattle[0].ClearanceRewardsVect);
               }
               if(this.FMC_GetReward.buttonMode)
               {
                  this.FMC_GetReward.gotoAndStop(2);
               }
         }
      }
      
      protected function McMove(param1:MouseEvent) : void
      {
         if(this.FFireBtnTipFunMove != null)
         {
            this.FFireBtnTipFunMove();
         }
      }
      
      protected function McOut(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_Fire_Btn:
               if(this.FMC_Fire_Btn.buttonMode)
               {
                  this.FMC_Fire_Btn.gotoAndStop(1);
               }
               break;
            case this.FMC_GetReward:
               if(this.FFireBtnTipFunOut != null)
               {
                  this.FFireBtnTipFunOut();
               }
               if(this.FMC_GetReward.buttonMode)
               {
                  this.FMC_GetReward.gotoAndStop(1);
               }
         }
      }
      
      protected function McUp(param1:MouseEvent) : void
      {
         if(this.FMC_Fire_Btn.buttonMode)
         {
            this.FMC_Fire_Btn.gotoAndStop(1);
         }
         if(this.FMC_GetReward.buttonMode)
         {
            this.FMC_GetReward.gotoAndStop(1);
         }
      }
      
      protected function McClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_ChangeBtn:
               if(this.FChangeNanduBtn != null)
               {
                  this.FChangeNanduBtn(this.FVecBattle,this.FCurIndex);
               }
               break;
            case this.FMC_Fire_Btn:
               if(this.FFireBack != null && this.FMC_Fire_Btn.buttonMode)
               {
                  this.FMC_Fire_Btn.gotoAndStop(3);
                  this.FFireBack(this.FVecBattle[this.FVecBattle[0].CurNanDu].Identifier);
               }
               break;
            case this.FMC_GetReward:
               if(this.FMC_GetReward.buttonMode)
               {
                  SLogicsCore.TBooData.CurGuanQiaCell = SLogicsCore.TBooData.GetGuanQiaCellByConfig(this.FVecBattle[0]);
                  this.FGetRewardFun(this.FVecBattle[0].Identifier);
               }
         }
      }
      
      public function SetthisFilters(param1:Boolean) : void
      {
         if(param1)
         {
            this.FImageBmp.filters = [TGameUtil.GaryColorFilters];
            this.FMC_ChangeBtn.filters = [TGameUtil.GaryColorFilters];
         }
         else
         {
            this.FImageBmp.filters = [];
            this.FMC_ChangeBtn.filters = [];
         }
      }
      
      protected function SetFireBtnState(param1:int) : void
      {
         switch(param1)
         {
            case 0:
               this.FMC_Fire_Btn.gotoAndStop(1);
               this.FMC_Fire_Btn.buttonMode = true;
               break;
            case 1:
               this.FMC_Fire_Btn.gotoAndStop(4);
               this.FMC_Fire_Btn.buttonMode = false;
               break;
            case 2:
               this.FMC_Fire_Btn.gotoAndStop(5);
               this.FMC_Fire_Btn.buttonMode = false;
         }
      }
      
      public function set CurNanduIndex(param1:int) : void
      {
         this.FVecBattle[0].CurNanDu = param1;
      }
      
      public function get CurNanduIndex() : int
      {
         return this.FVecBattle[0].CurNanDu;
      }
      
      public function set GetRewardFun(param1:Function) : void
      {
         this.FGetRewardFun = param1;
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
      
      public function set FireBack(param1:Function) : void
      {
         this.FFireBack = param1;
      }
      
      public function set ChangeNanduBtn(param1:Function) : void
      {
         this.FChangeNanduBtn = param1;
      }
      
      public function get VecBattle() : Vector.<TTabooBattle>
      {
         return this.FVecBattle;
      }
      
      public function UpdateImage() : void
      {
         if(!this.CurImageId)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.bmp,CONST_MODULES.MODULE_Taboo,this.CurImageId);
      }
   }
}

