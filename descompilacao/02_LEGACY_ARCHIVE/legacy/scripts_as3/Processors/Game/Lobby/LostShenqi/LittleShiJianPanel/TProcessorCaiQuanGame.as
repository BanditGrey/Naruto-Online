package Processors.Game.Lobby.LostShenqi.LittleShiJianPanel
{
   import Foundation.Tools.MvcPlayEffect;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TProcessorCaiQuanGame extends TProcessorLobbyWindow
   {
      
      protected var FThisPanel:MovieClip;
      
      protected var FIsInilization:Boolean;
      
      protected var FMC_Btn:SimpleButton;
      
      protected var FMC_JianDaoBtn:MovieClip;
      
      protected var FMC_ShiTouBtn:MovieClip;
      
      protected var FMC_BuBtn:MovieClip;
      
      protected var FMC_0:MovieClip;
      
      protected var FMC_1:MovieClip;
      
      protected var FMvcPlayEffect1:MvcPlayEffect;
      
      protected var FMvcPlayEffect2:MvcPlayEffect;
      
      protected var FCurChence:uint;
      
      protected var FReult:uint;
      
      protected var Timr:Timer;
      
      protected var FPiaoZi:Function;
      
      protected var FBackFunction:Function;
      
      public function TProcessorCaiQuanGame(param1:TUIComponent)
      {
         super(param1);
         this.FMvcPlayEffect1 = new MvcPlayEffect(this.FMvcPlayerOver1,31);
         this.FMvcPlayEffect2 = new MvcPlayEffect(this.FMvcPlayerOver2,31);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(0,0,FUICore.StageWidth,FUICore.StageHeight);
         this.graphics.endFill();
         this.Timr = new Timer(1000,2);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_CaiQuanGame") as MovieClip;
         addChild(this.FThisPanel);
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         this.FMC_JianDaoBtn = this.FThisPanel["MC_JianDaoBtn"];
         this.FMC_ShiTouBtn = this.FThisPanel["MC_ShiTouBtn"];
         this.FMC_BuBtn = this.FThisPanel["MC_BuBtn"];
         this.FMC_0 = this.FThisPanel["MC_Game"]["MC_0"];
         this.FMC_1 = this.FThisPanel["MC_Game"]["MC_1"];
         this.FIsInilization = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      public function OpenThisPanel() : void
      {
         this.SetBtnVisibel(true);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_JianDaoBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FMC_ShiTouBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FMC_BuBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.Timr.addEventListener(TimerEvent.TIMER_COMPLETE,this.Over);
         super.ResourcesPerform_UILocations();
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_JianDaoBtn:
               if(!this.FMC_JianDaoBtn.buttonMode)
               {
                  return;
               }
               this.FCurChence = 1;
               if(this.FBackFunction != null)
               {
                  this.FBackFunction(2);
               }
               break;
            case this.FMC_ShiTouBtn:
               if(!this.FMC_ShiTouBtn.buttonMode)
               {
                  return;
               }
               this.FCurChence = 2;
               if(this.FBackFunction != null)
               {
                  this.FBackFunction(2);
               }
               break;
            case this.FMC_BuBtn:
               if(!this.FMC_BuBtn.buttonMode)
               {
                  return;
               }
               this.FCurChence = 3;
               if(this.FBackFunction != null)
               {
                  this.FBackFunction(2);
               }
         }
      }
      
      public function SetBtnVisibel(param1:Boolean) : void
      {
         TGameUtil.setButtonMode(this.FMC_JianDaoBtn,param1);
         TGameUtil.setButtonMode(this.FMC_ShiTouBtn,param1);
         TGameUtil.setButtonMode(this.FMC_BuBtn,param1);
      }
      
      public function S_C_Back(param1:uint) : void
      {
         this.SetBtnVisibel(false);
         this.FReult = param1;
         this.BeginDongHua();
      }
      
      protected function BeginDongHua() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = null;
         if(this.FReult == 2)
         {
            switch(this.FCurChence)
            {
               case 1:
                  this.FMC_0.gotoAndStop(1);
                  _loc1_ = this.FMC_0["MC_"];
                  this.FMC_1.gotoAndStop(1);
                  _loc2_ = this.FMC_1["MC_"];
                  break;
               case 2:
                  this.FMC_0.gotoAndStop(3);
                  _loc1_ = this.FMC_0["MC_"];
                  this.FMC_1.gotoAndStop(3);
                  _loc2_ = this.FMC_1["MC_"];
                  break;
               case 3:
                  this.FMC_0.gotoAndStop(2);
                  _loc1_ = this.FMC_0["MC_"];
                  this.FMC_1.gotoAndStop(2);
                  _loc2_ = this.FMC_1["MC_"];
            }
         }
         else if(this.FReult == 1)
         {
            switch(this.FCurChence)
            {
               case 1:
                  this.FMC_0.gotoAndStop(1);
                  _loc1_ = this.FMC_0["MC_"];
                  this.FMC_1.gotoAndStop(2);
                  _loc2_ = this.FMC_1["MC_"];
                  break;
               case 2:
                  this.FMC_0.gotoAndStop(3);
                  _loc1_ = this.FMC_0["MC_"];
                  this.FMC_1.gotoAndStop(1);
                  _loc2_ = this.FMC_1["MC_"];
                  break;
               case 3:
                  this.FMC_0.gotoAndStop(2);
                  _loc1_ = this.FMC_0["MC_"];
                  this.FMC_1.gotoAndStop(3);
                  _loc2_ = this.FMC_1["MC_"];
            }
         }
         else
         {
            switch(this.FCurChence)
            {
               case 1:
                  this.FMC_0.gotoAndStop(1);
                  _loc1_ = this.FMC_0["MC_"];
                  this.FMC_1.gotoAndStop(3);
                  _loc2_ = this.FMC_1["MC_"];
                  break;
               case 2:
                  this.FMC_0.gotoAndStop(3);
                  _loc1_ = this.FMC_0["MC_"];
                  this.FMC_1.gotoAndStop(2);
                  _loc2_ = this.FMC_1["MC_"];
                  break;
               case 3:
                  this.FMC_0.gotoAndStop(2);
                  _loc1_ = this.FMC_0["MC_"];
                  this.FMC_1.gotoAndStop(1);
                  _loc2_ = this.FMC_1["MC_"];
            }
         }
         this.FMvcPlayEffect1.SetEffectPanel(_loc1_);
         this.FMvcPlayEffect2.SetEffectPanel(_loc2_);
         this.FMvcPlayEffect1.playEffect();
         this.FMvcPlayEffect2.playEffect();
      }
      
      protected function FMvcPlayerOver2() : void
      {
         if(this.FReult != 2)
         {
            this.Timr.start();
         }
         else
         {
            this.FPiaoZi(new ConsumeFrame(70430012).DescribeString);
            this.SetBtnVisibel(true);
         }
      }
      
      protected function Over(param1:TimerEvent) : void
      {
         var _loc2_:String = null;
         if(this.FPiaoZi != null)
         {
            if(this.FReult)
            {
               _loc2_ = TUtilityString.Format(new ConsumeFrame(70430001).DescribeString,SLogicsCore.LostShenQiLogicData.TempValue);
            }
            else
            {
               _loc2_ = TUtilityString.Format(new ConsumeFrame(70430002).DescribeString,SLogicsCore.LostShenQiLogicData.TempValue);
            }
            this.FPiaoZi(_loc2_);
         }
         this.Timr.reset();
         this.Timr.stop();
         this.Visible = false;
      }
      
      protected function FMvcPlayerOver1() : void
      {
      }
      
      public function set PiaoZi(param1:Function) : void
      {
         this.FPiaoZi = param1;
      }
      
      public function set BackFunction(param1:Function) : void
      {
         this.FBackFunction = param1;
      }
   }
}

