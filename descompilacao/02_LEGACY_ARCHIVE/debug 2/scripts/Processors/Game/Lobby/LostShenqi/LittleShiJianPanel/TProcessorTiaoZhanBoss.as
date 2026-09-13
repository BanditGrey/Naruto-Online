package Processors.Game.Lobby.LostShenqi.LittleShiJianPanel
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorTiaoZhanBoss extends TProcessorLobbyWindow
   {
      
      protected var FThisPanel:MovieClip;
      
      protected var FIsInilization:Boolean;
      
      protected var FMC_TiaoZhanBtn:MovieClip;
      
      protected var FMC_TiaoGuoBtn:MovieClip;
      
      protected var FMC_BianGengBtn:MovieClip;
      
      protected var FTF_ShengLiJiFen:TextField;
      
      protected var FTF_ShiBaiJiFen:TextField;
      
      public var Nimei:uint;
      
      protected var FBackFunction:Function;
      
      public function TProcessorTiaoZhanBoss(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(0,0,FUICore.StageWidth,FUICore.StageHeight);
         this.graphics.endFill();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_TiaoZhanBoss") as MovieClip;
         addChild(this.FThisPanel);
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         this.FMC_TiaoZhanBtn = this.FThisPanel["MC_TiaoZhanBtn"];
         this.FMC_TiaoGuoBtn = this.FThisPanel["MC_TiaoGuoBtn"];
         this.FMC_BianGengBtn = this.FThisPanel["MC_BianGengBtn"];
         this.FTF_ShengLiJiFen = this.FThisPanel["TF_ShengLiJiFen"];
         this.FTF_ShiBaiJiFen = this.FThisPanel["TF_ShiBaiJiFen"];
         this.FIsInilization = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      public function OpenThisPanel() : void
      {
         TGameUtil.setButtonMode(this.FMC_TiaoZhanBtn,true);
         TGameUtil.setButtonMode(this.FMC_TiaoGuoBtn,true);
         TGameUtil.setButtonMode(this.FMC_BianGengBtn,true);
         this.UpdateView();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_TiaoZhanBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FMC_TiaoGuoBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FMC_BianGengBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
         super.ResourcesPerform_UILocations();
      }
      
      public function UpdateView() : void
      {
         var _loc1_:uint = 0;
         if(!this.FIsInilization)
         {
            return;
         }
         _loc1_ = uint(SLogicsCore.LostShenQiLogicData.BaseValue);
         _loc1_ *= this.Nimei;
         this.FTF_ShengLiJiFen.text = _loc1_.toString();
         this.FTF_ShiBaiJiFen.text = SLogicsCore.LostShenQiLogicData.BaseValue.toString();
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_TiaoZhanBtn:
               if(!this.FMC_TiaoZhanBtn.buttonMode)
               {
                  return;
               }
               if(this.FBackFunction != null)
               {
                  this.FBackFunction(2);
               }
               break;
            case this.FMC_TiaoGuoBtn:
               if(!this.FMC_TiaoGuoBtn.buttonMode)
               {
                  return;
               }
               if(this.FBackFunction != null)
               {
                  this.FBackFunction(0);
               }
               break;
            case this.FMC_BianGengBtn:
               if(!this.FMC_BianGengBtn.buttonMode)
               {
                  return;
               }
               if(this.FBackFunction != null)
               {
                  this.FBackFunction(1);
               }
         }
      }
      
      public function set BackFunction(param1:Function) : void
      {
         this.FBackFunction = param1;
      }
   }
}

