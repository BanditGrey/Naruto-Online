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
   
   public class TProcessorShaiZiGame extends TProcessorLobbyWindow
   {
      
      protected var FThisPanel:MovieClip;
      
      protected var FIsInilization:Boolean;
      
      protected var FMC_Btn:SimpleButton;
      
      protected var FMC_DaBtn:MovieClip;
      
      protected var FMC_XiaoBtn:MovieClip;
      
      protected var FMC_0:MovieClip;
      
      protected var FMC_1:MovieClip;
      
      protected var FMC_2:MovieClip;
      
      public var FIsGameIng:Boolean;
      
      protected var FCurChence:uint;
      
      protected var FReult:uint;
      
      protected var FMvcPlayEffect1:MvcPlayEffect;
      
      protected var FMvcPlayEffect2:MvcPlayEffect;
      
      protected var FMvcPlayEffect3:MvcPlayEffect;
      
      protected var Timr:Timer;
      
      protected var FPiaoZi:Function;
      
      protected var FBackFunction:Function;
      
      public function TProcessorShaiZiGame(param1:TUIComponent)
      {
         super(param1);
         this.FMvcPlayEffect1 = new MvcPlayEffect(this.FMvcPlayerOver1,11);
         this.FMvcPlayEffect2 = new MvcPlayEffect(this.FMvcPlayerOver2,11);
         this.FMvcPlayEffect3 = new MvcPlayEffect(this.FMvcPlayerOver3,11);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(0,0,FUICore.StageWidth,FUICore.StageHeight);
         this.graphics.endFill();
         this.Timr = new Timer(1000,2);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_ShaiZiGame") as MovieClip;
         addChild(this.FThisPanel);
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         this.FMC_DaBtn = this.FThisPanel["MC_DaBtn"];
         this.FMC_XiaoBtn = this.FThisPanel["MC_XiaoBtn"];
         TGameUtil.setButtonMode(this.FMC_DaBtn,true);
         TGameUtil.setButtonMode(this.FMC_XiaoBtn,true);
         this.FMC_0 = this.FThisPanel["MC_Game"]["MC_0"];
         this.FMC_1 = this.FThisPanel["MC_Game"]["MC_1"];
         this.FMC_2 = this.FThisPanel["MC_Game"]["MC_2"];
         this.FMvcPlayEffect1.SetEffectPanel(this.FMC_0);
         this.FMvcPlayEffect2.SetEffectPanel(this.FMC_1);
         this.FMvcPlayEffect3.SetEffectPanel(this.FMC_2);
         this.FIsInilization = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      public function OpenThisPanel() : void
      {
         TGameUtil.setButtonMode(this.FMC_DaBtn,true);
         TGameUtil.setButtonMode(this.FMC_XiaoBtn,true);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_DaBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FMC_XiaoBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.Timr.addEventListener(TimerEvent.TIMER_COMPLETE,this.Over);
         super.ResourcesPerform_UILocations();
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_DaBtn:
               if(!this.FMC_DaBtn.buttonMode)
               {
                  return;
               }
               this.FCurChence = 2;
               if(this.FBackFunction != null)
               {
                  this.FBackFunction(2);
               }
               break;
            case this.FMC_XiaoBtn:
               if(!this.FMC_XiaoBtn.buttonMode)
               {
                  return;
               }
               this.FCurChence = 1;
               if(this.FBackFunction != null)
               {
                  this.FBackFunction(2);
               }
         }
      }
      
      public function S_C_Back(param1:uint) : void
      {
         TGameUtil.setButtonMode(this.FMC_DaBtn,false);
         TGameUtil.setButtonMode(this.FMC_XiaoBtn,false);
         this.FReult = param1;
         this.BeginDongHua();
      }
      
      protected function BeginDongHua() : void
      {
         this.FMvcPlayEffect1.playEffect();
         this.FMvcPlayEffect2.playEffect();
         this.FMvcPlayEffect3.playEffect();
      }
      
      protected function FMvcPlayerOver1() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         if(this.FReult == 0)
         {
            if(this.FCurChence == 1)
            {
               _loc1_ = Math.floor(Math.random() * 3 + 4);
            }
            else
            {
               _loc1_ = Math.floor(Math.random() * 4);
            }
         }
         else if(this.FCurChence == 1)
         {
            _loc1_ = Math.floor(Math.random() * 4);
         }
         else
         {
            _loc1_ = Math.floor(Math.random() * 3 + 4);
         }
         this.FMC_0.gotoAndStop(11);
         _loc2_ = this.FMC_0["MC_Nimei"];
         _loc2_.gotoAndStop(_loc1_);
      }
      
      protected function FMvcPlayerOver2() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         if(this.FReult == 0)
         {
            if(this.FCurChence == 1)
            {
               _loc1_ = Math.floor(Math.random() * 3 + 4);
            }
            else
            {
               _loc1_ = Math.floor(Math.random() * 4);
            }
         }
         else if(this.FCurChence == 1)
         {
            _loc1_ = Math.floor(Math.random() * 4);
         }
         else
         {
            _loc1_ = Math.floor(Math.random() * 3 + 4);
         }
         this.FMC_1.gotoAndStop(11);
         _loc2_ = this.FMC_1["MC_Nimei"];
         _loc2_.gotoAndStop(_loc1_);
      }
      
      protected function FMvcPlayerOver3() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         if(this.FReult == 0)
         {
            if(this.FCurChence == 1)
            {
               _loc1_ = Math.floor(Math.random() * 3 + 4);
            }
            else
            {
               _loc1_ = Math.floor(Math.random() * 4);
            }
         }
         else if(this.FCurChence == 1)
         {
            _loc1_ = Math.floor(Math.random() * 4);
         }
         else
         {
            _loc1_ = Math.floor(Math.random() * 3 + 4);
         }
         this.FMC_2.gotoAndStop(11);
         _loc2_ = this.FMC_2["MC_Nimei"];
         _loc2_.gotoAndStop(_loc1_);
         this.Timr.start();
      }
      
      protected function Over(param1:TimerEvent) : void
      {
         var _loc2_:String = null;
         if(this.FReult)
         {
            _loc2_ = TUtilityString.Format(new ConsumeFrame(70430003).DescribeString,SLogicsCore.LostShenQiLogicData.TempValue);
         }
         else
         {
            _loc2_ = TUtilityString.Format(new ConsumeFrame(70430004).DescribeString,SLogicsCore.LostShenQiLogicData.TempValue);
         }
         this.FPiaoZi(_loc2_);
         this.Timr.reset();
         this.Timr.stop();
         this.Visible = false;
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

