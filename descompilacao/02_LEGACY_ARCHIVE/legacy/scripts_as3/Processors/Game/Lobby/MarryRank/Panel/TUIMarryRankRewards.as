package Processors.Game.Lobby.MarryRank.Panel
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TMarryRankgift;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.MarryRank.TMarryRankModel;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class TUIMarryRankRewards extends TUIBaseWindow
   {
      
      private var _page:int = -1;
      
      private var _maxPage:int = -1;
      
      protected var FMask:Shape = null;
      
      protected var FEquipInventories:TInventories = null;
      
      protected var FSlots:Array = null;
      
      public function TUIMarryRankRewards(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc7_:Vector.<TUISlot> = null;
         var _loc8_:int = 0;
         var _loc9_:TMarryRankgift = null;
         var _loc10_:Array = null;
         FMC_Scene = param1;
         FMC_Scene.BTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseClick);
         TGameUtil.setButtonMode(FMC_Scene.MC_PageLeft,true);
         FMC_Scene.MC_PageLeft.addEventListener(MouseEvent.CLICK,this.OnPageLeftClick);
         TGameUtil.setButtonMode(FMC_Scene.MC_PageRight,true);
         FMC_Scene.MC_PageRight.addEventListener(MouseEvent.CLICK,this.OnPageRightClick);
         this.FSlots = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            FMC_Scene["MC_RewardList_" + _loc2_].visible = false;
            _loc7_ = new Vector.<TUISlot>();
            _loc8_ = 0;
            while(_loc8_ < 4)
            {
               _loc7_.push(this.GetSlot(FMC_Scene["MC_RewardList_" + _loc2_]["MC_Item_" + _loc8_]));
               _loc8_++;
            }
            this.FSlots.push(_loc7_);
            _loc2_++;
         }
         var _loc3_:Point = FMC_Scene.localToGlobal(new Point(0,0));
         this.FMask = new Shape();
         this.FMask.graphics.beginFill(0,0.8);
         this.FMask.graphics.drawRect(-_loc3_.x,-_loc3_.y,1250,650);
         this.FMask.graphics.endFill();
         FMC_Scene.addChildAt(this.FMask,0);
         var _loc4_:Vector.<uint> = new Vector.<uint>();
         var _loc5_:int = TMarryRankModel.MarryRankgift.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc9_ = TMarryRankModel.MarryRankgift.GetDatebaseByIndex(_loc2_) as TMarryRankgift;
            _loc10_ = JSON.parse(_loc9_.RankGift) as Array;
            _loc8_ = 0;
            while(_loc8_ < _loc10_.length)
            {
               if(_loc4_.indexOf(_loc10_[_loc8_].code) == -1)
               {
                  _loc4_.push(_loc10_[_loc8_].code);
               }
               _loc8_++;
            }
            _loc2_++;
         }
         this.FEquipInventories = new TInventories();
         var _loc6_:TUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         _loc6_.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FEquipInventories,_loc4_);
         this.SetVisible(false);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         super.LogicsPerform();
         if(this.FSlots)
         {
            _loc1_ = int(this.FSlots.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               for each(_loc3_ in this.FSlots[_loc2_])
               {
                  _loc3_.Update();
               }
               _loc2_++;
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         var _loc5_:TMarryRankgift = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc1_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         var _loc2_:int = Math.max((this._page - 1) * 4,0);
         var _loc3_:int = Math.min(this._page * 4,TMarryRankModel.MarryRankgift.Count);
         var _loc4_:int = 0;
         while(_loc4_ < 4)
         {
            FMC_Scene["MC_RewardList_" + _loc4_].visible = _loc2_ + _loc4_ < _loc3_;
            if(FMC_Scene["MC_RewardList_" + _loc4_].visible)
            {
               _loc5_ = TMarryRankModel.MarryRankgift.GetDatebaseByIndex(_loc2_ + _loc4_) as TMarryRankgift;
               if(_loc5_.Rankmin == _loc5_.Rankmax)
               {
                  FMC_Scene["MC_RewardList_" + _loc4_]["Text_Rank"].text = _loc5_.Rankmin;
               }
               else if(_loc5_.Rankmin < 100)
               {
                  FMC_Scene["MC_RewardList_" + _loc4_]["Text_Rank"].text = _loc5_.Rankmin + "~" + _loc5_.Rankmax;
               }
               else
               {
                  FMC_Scene["MC_RewardList_" + _loc4_]["Text_Rank"].text = ">100";
               }
               _loc6_ = JSON.parse(_loc5_.RankGift) as Array;
               _loc7_ = 0;
               while(_loc7_ < 4)
               {
                  this.FSlots[_loc4_][_loc7_].Visible = _loc6_.length > _loc7_;
                  if(this.FSlots[_loc4_][_loc7_].Visible)
                  {
                     this.FSlots[_loc4_][_loc7_].Context = this.FEquipInventories.GetInventoryByTempletID(_loc6_[_loc7_].code);
                     FMC_Scene["MC_RewardList_" + _loc4_]["MC_Item_" + _loc7_]["TF_Subscript"].text = _loc6_[_loc7_].amount;
                  }
                  _loc7_++;
               }
            }
            _loc4_++;
         }
      }
      
      protected function GetSlot(param1:Sprite) : TUISlot
      {
         var _loc2_:TUISlot = new TUISlot(this);
         _loc2_.Resource = param1;
         _loc2_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         _loc2_.OnOverlay = OnItemOver;
         _loc2_.OnOut = OnItemOut;
         _loc2_.Init();
         return _loc2_;
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = param2 as TInventory;
         var _loc6_:TResourceRepositoryTexture = SResourcesCore.TexturesInventory;
         var _loc7_:TTexture = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Common);
         }
      }
      
      private function OnCloseClick(param1:MouseEvent) : void
      {
         this.SetVisible(false);
      }
      
      private function OnPageLeftClick(param1:MouseEvent) : void
      {
         --this.page;
      }
      
      private function OnPageRightClick(param1:MouseEvent) : void
      {
         ++this.page;
      }
      
      public function get page() : int
      {
         return this._page;
      }
      
      public function set page(param1:int) : void
      {
         this._page = Math.max(1,param1);
         this._page = Math.min(this._maxPage,this._page);
         FMC_Scene.TF_Page.text = this._page + "/" + this._maxPage;
         TGameUtil.setButtonMode(FMC_Scene.MC_PageLeft,this._page > 1);
         TGameUtil.setButtonMode(FMC_Scene.MC_PageRight,this._page < this._maxPage);
         this.UpdateUI();
      }
      
      override public function SetVisible(param1:Boolean) : void
      {
         super.SetVisible(param1);
         if(param1)
         {
            if(this._maxPage == -1)
            {
               this._maxPage = Math.ceil(TMarryRankModel.MarryRankgift.Count / 4);
               this.page = 1;
            }
            else
            {
               this.page = this.page;
            }
         }
      }
   }
}

