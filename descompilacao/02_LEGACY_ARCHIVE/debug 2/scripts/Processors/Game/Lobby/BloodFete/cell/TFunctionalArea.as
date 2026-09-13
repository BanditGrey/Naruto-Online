package Processors.Game.Lobby.BloodFete.cell
{
   import Foundation.Utilities.TGameUtil;
   import Logics.BloodFete.TBloodFeteData;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_BLOODFETE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TFunctionalArea
   {
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FSM_Bag_Btn:SimpleButton = null;
      
      protected var FMC_Attack:TextField = null;
      
      protected var FMC_AutoSell_Task:MovieClip = null;
      
      protected var FMC_AutoCompound_Task:MovieClip = null;
      
      protected var FMC_AutoBtn:MovieClip = null;
      
      protected var FMC_AutoSell_TaskIndex:int = 1;
      
      protected var FMC_AutoCompound_TaskIndex:int = 1;
      
      protected var FPurpleOrGold:int = 4;
      
      protected var Fmc_list_level:MovieClip = null;
      
      protected var FMC_Bar1:MovieClip = null;
      
      protected var FMC_Bar2:MovieClip = null;
      
      protected var FBTN_Showlist:MovieClip = null;
      
      protected var FPosArr:Vector.<Object>;
      
      protected var FIsDanOrShuang:int;
      
      protected var FBloodFeteData:TBloodFeteData = null;
      
      protected var FBackFunction:Function = null;
      
      protected var FPiaoString:Function;
      
      public function TFunctionalArea()
      {
         super();
      }
      
      protected function Initilization() : void
      {
         this.FSM_Bag_Btn = this.FThisPanel[CONST_BLOODFETE.MC_FunctionalArea_SM_Bag_Btn];
         this.FMC_Attack = this.FThisPanel["MC_Attack"];
         this.FMC_AutoBtn = this.FThisPanel["MC_AutoBtn"];
         this.FMC_AutoSell_Task = this.FMC_AutoBtn["MC_AutoSell_Task"];
         this.FMC_AutoCompound_Task = this.FMC_AutoBtn["MC_AutoCompound_Task"];
         this.Fmc_list_level = this.FMC_AutoBtn["mc_list_level"];
         this.FMC_Bar1 = this.Fmc_list_level["mc_bar1"];
         this.FMC_Bar1.buttonMode = true;
         this.FMC_Bar1.mouseChildren = false;
         this.FPosArr[0] = {
            "XX":this.FMC_Bar1.x,
            "YY":this.FMC_Bar1.y
         };
         this.FMC_Bar2 = this.Fmc_list_level["mc_bar2"];
         this.FMC_Bar2.buttonMode = true;
         this.FMC_Bar2.mouseChildren = false;
         this.FPosArr[1] = {
            "XX":this.FMC_Bar2.x,
            "YY":this.FMC_Bar2.y
         };
         this.FBTN_Showlist = this.Fmc_list_level["btn_showlist"];
         TGameUtil.setButtonMode(this.FBTN_Showlist,true);
      }
      
      protected function AddEventListener() : void
      {
         this.FSM_Bag_Btn.addEventListener(MouseEvent.CLICK,this.Bag_Btn_Click);
         this.FMC_AutoSell_Task.addEventListener(MouseEvent.CLICK,this.AutoBtn);
         this.FMC_AutoCompound_Task.addEventListener(MouseEvent.CLICK,this.AutoBtn);
         this.FBTN_Showlist.addEventListener(MouseEvent.CLICK,this.ShowlistClick);
         this.FMC_Bar1.addEventListener(MouseEvent.CLICK,this.BarClick);
         this.FMC_Bar2.addEventListener(MouseEvent.CLICK,this.BarClick);
         this.RefreshPostion();
         this.UpdataAtuoBtn();
      }
      
      protected function RefreshPostion() : void
      {
         if(this.FPurpleOrGold == 4)
         {
            this.FMC_Bar1.x = this.FPosArr[0].XX;
            this.FMC_Bar1.y = this.FPosArr[0].YY;
            this.FMC_Bar2.x = this.FPosArr[1].XX;
            this.FMC_Bar2.y = this.FPosArr[1].YY;
            this.FMC_Bar1.visible = true;
            this.FMC_Bar2.visible = false;
         }
         else
         {
            this.FMC_Bar1.x = this.FPosArr[1].XX;
            this.FMC_Bar1.y = this.FPosArr[1].YY;
            this.FMC_Bar2.x = this.FPosArr[0].XX;
            this.FMC_Bar2.y = this.FPosArr[0].YY;
            this.FMC_Bar2.visible = true;
            this.FMC_Bar1.visible = false;
         }
      }
      
      protected function UpdataAtuoBtn() : void
      {
         this.FMC_AutoSell_Task.gotoAndStop(this.FMC_AutoSell_TaskIndex + 1);
         this.FMC_AutoCompound_Task.gotoAndStop(this.FMC_AutoCompound_TaskIndex + 1);
         this.FBloodFeteData.MC_AutoSell_TaskIndex = this.FMC_AutoSell_TaskIndex;
         if(this.FMC_AutoCompound_TaskIndex == 0)
         {
            this.FBloodFeteData.MC_AutoCompound_Task = this.FPurpleOrGold;
         }
         else
         {
            this.FBloodFeteData.MC_AutoCompound_Task = 0;
         }
      }
      
      public function get SM_Bag_Btn() : SimpleButton
      {
         return this.FSM_Bag_Btn;
      }
      
      protected function Bag_Btn_Click(param1:MouseEvent) : void
      {
         if(this.FBackFunction != null)
         {
            this.FBackFunction();
         }
      }
      
      protected function AutoBtn(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_AutoSell_Task:
               this.FMC_AutoSell_TaskIndex = this.FMC_AutoSell_TaskIndex == 0 ? 1 : 0;
               break;
            case this.FMC_AutoCompound_Task:
               this.FMC_AutoCompound_TaskIndex = this.FMC_AutoCompound_TaskIndex == 0 ? 1 : 0;
         }
         this.UpdataAtuoBtn();
      }
      
      protected function ShowlistClick(param1:MouseEvent) : void
      {
         this.FMC_Bar1.visible = true;
         this.FMC_Bar2.visible = true;
         this.FIsDanOrShuang = this.FIsDanOrShuang == 1 ? 0 : 1;
         if(!this.FIsDanOrShuang)
         {
            this.RefreshPostion();
         }
      }
      
      protected function BarClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_Bar1:
               this.FPurpleOrGold = 4;
               break;
            case this.FMC_Bar2:
               this.FPurpleOrGold = 5;
         }
         this.FIsDanOrShuang = 0;
         this.RefreshPostion();
         this.UpdataAtuoBtn();
      }
      
      public function set BackFunction(param1:Function) : void
      {
         this.FBackFunction = param1;
      }
      
      public function set PiaoString(param1:Function) : void
      {
         this.FPiaoString = param1;
      }
      
      public function get PiaoString() : Function
      {
         return this.FPiaoString;
      }
      
      public function SetThisPanel(param1:MovieClip, param2:TBloodFeteData) : void
      {
         this.FThisPanel = param1;
         this.FBloodFeteData = param2;
         this.FPosArr = new Vector.<Object>(2);
         this.Initilization();
         this.AddEventListener();
      }
      
      public function UpdateData() : void
      {
         this.FMC_Attack.text = String(Math.max(this.FBloodFeteData.CallBloodFeteCountFree,0));
         this.UpdateShowHide();
      }
      
      public function UpdateShowHide() : void
      {
         if(SLogicsCore.Character.VipData.AddFollowBloodBoundAutoSell)
         {
            this.FMC_AutoBtn.visible = true;
         }
         else
         {
            this.FMC_AutoBtn.visible = false;
         }
      }
   }
}

