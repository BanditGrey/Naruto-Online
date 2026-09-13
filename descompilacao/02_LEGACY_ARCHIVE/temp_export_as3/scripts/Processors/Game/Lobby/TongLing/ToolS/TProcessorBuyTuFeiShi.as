package Processors.Game.Lobby.TongLing.ToolS
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TBB_BuyRapid;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_TONGLINGANIMAL;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorBuyTuFeiShi extends TProcessorLobbyWindow
   {
      
      public static const THREE:int = 3;
      
      protected var FMainPanel:Sprite = null;
      
      protected var FCloseBtn:SimpleButton = null;
      
      protected var FCurBin:TBins;
      
      protected var FFeiFuShiCellVec:Vector.<TPBuyTuFeiFuShiCell> = null;
      
      protected var FBuyBackFun:Function;
      
      protected var FBackCloseFun:Function;
      
      public function TProcessorBuyTuFeiShi(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
         this.FFeiFuShiCellVec = new Vector.<TPBuyTuFeiFuShiCell>(THREE);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TONGLINGANIMAL.TONGLING_ID);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         this.FMainPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_BuyTuFeiFuShi") as Sprite;
         addChild(this.FMainPanel);
         this.FMainPanel.x = (FUICore.StageWidth - this.FMainPanel.width) / 2;
         this.FMainPanel.y = (FUICore.StageHeight - this.FMainPanel.height) / 2;
         this.FCloseBtn = this.FMainPanel["MC_Close"];
         _loc1_ = 0;
         while(_loc1_ < THREE)
         {
            this.FFeiFuShiCellVec[_loc1_] = new TPBuyTuFeiFuShiCell();
            this.FFeiFuShiCellVec[_loc1_].SetThisPanel(this.FMainPanel["MC_Cell" + _loc1_],_loc1_);
            this.FFeiFuShiCellVec[_loc1_].BackFun = this.BuyCellBack;
            _loc1_++;
         }
         this.FCloseBtn.addEventListener(MouseEvent.CLICK,this.CloseBtn);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         this.FCurBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BB_BuyRapid);
         var _loc2_:TBB_BuyRapid = null;
         _loc1_ = 0;
         while(_loc1_ < this.FCurBin.Count)
         {
            _loc2_ = this.FCurBin.GetDatebaseByIndex(_loc1_) as TBB_BuyRapid;
            this.FFeiFuShiCellVec[_loc1_].SetDate(_loc2_);
            _loc1_++;
         }
         super.ResourcesPerform_UILocations();
      }
      
      public function set BuyBackFun(param1:Function) : void
      {
         this.FBuyBackFun = param1;
      }
      
      protected function BuyCellBack(param1:TBB_BuyRapid) : void
      {
         if(this.FBuyBackFun != null)
         {
            this.FBuyBackFun(param1);
         }
      }
      
      public function set BackCloseFun(param1:Function) : void
      {
         this.FBackCloseFun = param1;
      }
      
      public function CloseBtn(param1:MouseEvent) : void
      {
         this.FBackCloseFun();
      }
   }
}

