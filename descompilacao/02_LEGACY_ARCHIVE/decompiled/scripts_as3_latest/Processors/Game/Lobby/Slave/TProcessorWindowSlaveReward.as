package Processors.Game.Lobby.Slave
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TGvgSlaveDrop;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Slave.TSlaveDisciple;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowSlaveReward extends TProcessorLobbyWindow
   {
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FUIShowItem:TUIShowItem;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FGvgSlaveDropBins:TBins;
      
      public var OnOverlay:Function;
      
      public var OnOut:Function;
      
      public function TProcessorWindowSlaveReward(param1:TUIComponent)
      {
         super(param1);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:MovieClip = null;
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance("MC_SlaveReward") as MovieClip;
         addChild(_loc1_);
         this.FUIShowItem = new TUIShowItem(this,8);
         this.FUIShowItem.Perform_UIDispatch(_loc1_["MC_Main"]["MC_ShowItems"]);
         this.FUIShowItem.OnOverlay = this.SlotsOnOver;
         this.FUIShowItem.OnOut = this.SlotsOnOut;
         this.FBTN_Close = _loc1_["MC_Main"]["btn_close"];
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.OnBTNCloseClick,false,0,true);
         this.FGvgSlaveDropBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_GvgSlaveDrop);
         super.ResourcesPerform_UIDispatch();
      }
      
      public function Update(param1:TSlaveDisciple) : void
      {
         var _loc2_:TInventories = null;
         var _loc3_:TInventory = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TGvgSlaveDrop = null;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:Vector.<uint> = null;
         if(param1 == null)
         {
            return;
         }
         this.FInventories = new TInventories();
         _loc7_ = new Vector.<uint>();
         _loc8_ = new Vector.<uint>();
         _loc6_ = this.GetGvgSlaveDropByRank(param1.Rank);
         _loc4_ = int(_loc6_.GiftArr.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_.push(_loc6_.GiftArr[_loc5_].code);
            _loc8_.push(_loc6_.GiftArr[_loc5_].amount);
            _loc5_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,_loc7_);
         _loc4_ = this.FInventories.Count;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = this.FInventories.GetInventoryByIndex(_loc5_);
            _loc3_.Quantity = _loc8_[_loc5_];
            _loc5_++;
         }
         this.FUIShowItem.UpdateUI(this.FInventories);
      }
      
      protected function GetGvgSlaveDropByRank(param1:uint) : TGvgSlaveDrop
      {
         var _loc2_:uint = 0;
         var _loc3_:TGvgSlaveDrop = null;
         _loc2_ = 0;
         while(_loc2_ < this.FGvgSlaveDropBins.Count)
         {
            _loc3_ = this.FGvgSlaveDropBins.GetDatebaseByIndex(_loc2_) as TGvgSlaveDrop;
            if(param1 >= _loc3_.From && param1 <= _loc3_.To)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(this.OnOverlay != null)
         {
            this.OnOverlay(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.OnOut != null)
         {
            this.OnOut(this,param2);
         }
      }
      
      override protected function LogicsPerform() : void
      {
         if(this.FUIShowItem)
         {
            this.FUIShowItem.LogicsPerform();
         }
      }
      
      protected function OnBTNCloseClick(param1:MouseEvent) : void
      {
         this.Visible = false;
      }
   }
}

