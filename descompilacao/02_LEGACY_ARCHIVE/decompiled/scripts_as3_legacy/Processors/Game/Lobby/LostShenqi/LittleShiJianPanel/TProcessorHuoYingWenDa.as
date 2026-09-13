package Processors.Game.Lobby.LostShenqi.LittleShiJianPanel
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TNinjiaQuestions;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorHuoYingWenDa extends TProcessorLobbyWindow
   {
      
      protected var FThisPanel:MovieClip;
      
      protected var FIsInilization:Boolean;
      
      protected var FMC_JianDaoBtn:MovieClip;
      
      protected var FMC_ShiTouBtn:MovieClip;
      
      protected var FMC_BuBtn:MovieClip;
      
      protected var FTF_WenTi:TextField;
      
      protected var FTF_A:TextField;
      
      protected var FTF_B:TextField;
      
      protected var FTF_C:TextField;
      
      protected var FBackFunction:Function;
      
      public function TProcessorHuoYingWenDa(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(0,0,FUICore.StageWidth,FUICore.StageHeight);
         this.graphics.endFill();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_HuoYingWenDa") as MovieClip;
         addChild(this.FThisPanel);
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         this.FMC_JianDaoBtn = this.FThisPanel["MC_JianDaoBtn"];
         this.FMC_ShiTouBtn = this.FThisPanel["MC_ShiTouBtn"];
         this.FMC_BuBtn = this.FThisPanel["MC_BuBtn"];
         this.FTF_WenTi = this.FThisPanel["TF_WenTi"];
         this.FTF_A = this.FThisPanel["TF_A"];
         this.FTF_B = this.FThisPanel["TF_B"];
         this.FTF_C = this.FThisPanel["TF_C"];
         this.FIsInilization = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      public function UpdateView(param1:uint) : void
      {
         var _loc2_:TBins = null;
         var _loc3_:TNinjiaQuestions = null;
         _loc2_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NinjiaQuestions);
         _loc3_ = _loc2_.GetDatebaseByValue("Level",param1) as TNinjiaQuestions;
         this.FTF_WenTi.text = _loc3_.Questions;
         this.FTF_A.text = _loc3_.Answerone;
         this.FTF_B.text = _loc3_.Answertwo;
         this.FTF_C.text = _loc3_.Answerthree;
      }
      
      public function OpenThisPanel() : void
      {
         TGameUtil.setButtonMode(this.FMC_JianDaoBtn,true);
         TGameUtil.setButtonMode(this.FMC_ShiTouBtn,true);
         TGameUtil.setButtonMode(this.FMC_BuBtn,true);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_JianDaoBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FMC_ShiTouBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FMC_BuBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
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
               if(this.FBackFunction != null)
               {
                  this.FBackFunction(1);
               }
               break;
            case this.FMC_ShiTouBtn:
               if(!this.FMC_ShiTouBtn.buttonMode)
               {
                  return;
               }
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
               if(this.FBackFunction != null)
               {
                  this.FBackFunction(3);
               }
         }
      }
      
      public function set BackFunction(param1:Function) : void
      {
         this.FBackFunction = param1;
      }
   }
}

