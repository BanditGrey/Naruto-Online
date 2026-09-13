package Processors.Game.Lobby.Globalboss
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TDafubenAward;
   import Logics.Globalboss.TGlobalbossChapter;
   import Logics.Inventories.TInventory;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TProcessorGlobalbossAward extends TProcessorLobbyWindow
   {
      
      protected var FMainPanel:MovieClip;
      
      protected var FUIListAward:Vector.<TUIGlobalBossAward>;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      public function TProcessorGlobalbossAward(param1:TUIComponent)
      {
         super(param1);
         this.FUIListAward = new Vector.<TUIGlobalBossAward>();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TUIGlobalBossAward = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.FMainPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_globalbossAward") as MovieClip;
         addChild(this.FMainPanel);
         _loc3_ = 3;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = new TUIGlobalBossAward(this);
            _loc1_.Perform_UIDispatch(this.FMainPanel["MC_Award_" + _loc2_]);
            _loc1_.SlotsOnOver = this.OnSlotsOnOver;
            _loc1_.SlotsOnOut = this.OnSlotsOnOut;
            this.FUIListAward.push(_loc1_);
            _loc2_++;
         }
         this.FMainPanel.x = FUICore.StageWidth - this.FMainPanel.width >> 1;
         this.FMainPanel.y = FUICore.StageHeight - this.FMainPanel.height >> 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMainPanel.btn_close.addEventListener(MouseEvent.CLICK,this.OnCloseWindow);
         super.ResourcesPerform_UILocations();
      }
      
      public function SetData(param1:TGlobalbossChapter) : void
      {
         var _loc2_:TDafubenAward = null;
         var _loc3_:int = 0;
         if(this.FUIListAward)
         {
            _loc3_ = 0;
            while(_loc3_ < this.FUIListAward.length)
            {
               _loc2_ = param1.DafubenAwards[_loc3_];
               this.FUIListAward[_loc3_].SetDate(_loc2_,param1);
               _loc3_++;
            }
         }
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(this.FUIListAward)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FUIListAward.length)
            {
               this.FUIListAward[_loc1_].LogicsPerform();
               _loc1_++;
            }
         }
      }
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
      }
      
      protected function OnSlotsOnOver(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOver != null)
         {
            this.FOnInventoryOver(param1,param2);
         }
      }
      
      protected function OnSlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOut != null)
         {
            this.FOnInventoryOut(param1,param2);
         }
      }
      
      protected function OnCloseWindow(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
   }
}

