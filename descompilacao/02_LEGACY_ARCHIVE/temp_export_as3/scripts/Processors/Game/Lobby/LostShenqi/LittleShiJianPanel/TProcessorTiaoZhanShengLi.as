package Processors.Game.Lobby.LostShenqi.LittleShiJianPanel
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TMazeaward;
   import Logics.LostShenQi.TLostShenQiLogicData;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorTiaoZhanShengLi extends TProcessorLobbyWindow
   {
      
      protected var FThisPanel:MovieClip;
      
      protected var FIsInilization:Boolean;
      
      protected var FMC_SureBtn:MovieClip;
      
      protected var FTF_HoDeiJiFen:TextField;
      
      protected var FTF_HoDeiYu:TextField;
      
      protected var FTF_NextJiFen:TextField;
      
      protected var FTF_NextYu:TextField;
      
      protected var FLostShenQiLogicData:TLostShenQiLogicData;
      
      protected var FBackFunction:Function;
      
      public function TProcessorTiaoZhanShengLi(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(0,0,FUICore.StageWidth,FUICore.StageHeight);
         this.graphics.endFill();
         this.FLostShenQiLogicData = SLogicsCore.LostShenQiLogicData;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_TiaoZhanShengLi") as MovieClip;
         addChild(this.FThisPanel);
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         this.FMC_SureBtn = this.FThisPanel["MC_SureBtn"];
         this.FTF_HoDeiJiFen = this.FThisPanel["TF_HoDeiJiFen"];
         this.FTF_HoDeiYu = this.FThisPanel["TF_HoDeiYu"];
         this.FTF_NextJiFen = this.FThisPanel["TF_NextJiFen"];
         this.FTF_NextYu = this.FThisPanel["TF_NextYu"];
         this.FIsInilization = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      public function OpenThisPanel() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TBins = null;
         var _loc3_:TMazeaward = null;
         var _loc4_:* = 0;
         TGameUtil.setButtonMode(this.FMC_SureBtn,true);
         _loc1_ = this.FLostShenQiLogicData.MiGongJiFen;
         this.FTF_HoDeiJiFen.text = _loc1_.toString();
         this.FTF_HoDeiYu.text = "";
         this.FTF_NextJiFen.text = "";
         this.FTF_NextYu.text = "";
         _loc2_ = this.FLostShenQiLogicData.Mazeawardbins;
         _loc4_ = int(_loc2_.Count - 1);
         while(_loc4_ >= 0)
         {
            _loc3_ = _loc2_.GetDatebaseByIndex(_loc4_) as TMazeaward;
            if(_loc1_ >= _loc3_.EventPoint)
            {
               this.FTF_HoDeiYu.text = _loc3_.AwardLostpiece.toString();
               _loc1_ = uint(_loc3_.Identifier);
               _loc1_++;
               this.FTF_NextJiFen.text = _loc3_.EventPoint.toString();
               this.FTF_NextYu.text = _loc3_.AwardLostpiece.toString();
               _loc3_ = _loc2_.GetDatebaseByIdentifier(_loc1_) as TMazeaward;
               if(_loc3_)
               {
                  this.FTF_NextJiFen.text = _loc3_.EventPoint.toString();
                  this.FTF_NextYu.text = _loc3_.AwardLostpiece.toString();
                  break;
               }
            }
            _loc4_--;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_SureBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
         super.ResourcesPerform_UILocations();
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_SureBtn:
               if(!this.FMC_SureBtn.buttonMode)
               {
                  return;
               }
               this.Visible = false;
         }
      }
      
      public function set BackFunction(param1:Function) : void
      {
         this.FBackFunction = param1;
      }
   }
}

