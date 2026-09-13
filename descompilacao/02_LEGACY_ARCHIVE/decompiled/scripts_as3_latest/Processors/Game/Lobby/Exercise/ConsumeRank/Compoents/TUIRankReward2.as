package Processors.Game.Lobby.Exercise.ConsumeRank.Compoents
{
   import Components.Slots.TUISlot;
   import Foundation.Common.THint;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.ConsumeRank.TConsumeRank;
   import Logics.Exercise.ConsumeRank.TConsumeRankReward;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONSUMERANK;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_CONSUMERANK;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class TUIRankReward2 extends TUIComponent
   {
      
      protected var BOX_COUNT:int = 1;
      
      protected var MAX_COUNT:int = 6;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FIndex:int;
      
      protected var FConsumeRank:TConsumeRank;
      
      protected var FType:int;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FOnGetReward:Function;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FHint:THint;
      
      protected var FInitX:int;
      
      protected var FMaxWidth:int;
      
      public function TUIRankReward2(param1:TUIComponent, param2:int = 1)
      {
         super(param1);
         this.FSlotList = new Vector.<TUISlot>(this.BOX_COUNT);
         this.FConsumeRank = SLogicsCore.ConsumeRank;
         this.FType = param2;
      }
      
      protected function Initialization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_CONSUMERANK.RESOURCE_ClassName_MC_RankReward) as MovieClip;
         addChild(this.FMC_Scene);
         _loc1_ = 0;
         while(_loc1_ < this.BOX_COUNT)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_Scene[CONST_CONSUMERANK.RESOURCE_Link_MC_Slot + _loc1_] as Sprite;
            _loc3_.Resource.visible = false;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.OnOverlay = this.SlotsOnOver;
            _loc3_.OnOut = this.SlotsOnOut;
            _loc3_.Init();
            this.FSlotList[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.FInitX = this.FMC_Scene.MC_NeedGold.MC_Item0.x;
         this.FMaxWidth = this.FMC_Scene.MC_Bar.width;
      }
      
      protected function UpdateContent() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TConsumeRankReward = null;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         _loc3_ = this.FConsumeRank.RankRewardList2[this.FIndex];
         if(_loc3_.MinLimit == _loc3_.MaxLimit)
         {
            this.FMC_Scene.TF_Text.text = TUtilityString.Format(STRING_CONSUMERANK.FORMAT_RankText,_loc3_.MinLimit);
         }
         else
         {
            this.FMC_Scene.TF_Text.text = TUtilityString.Format(STRING_CONSUMERANK.FORMAT_RankText2,_loc3_.MinLimit,_loc3_.MaxLimit);
         }
         _loc2_ = int(_loc3_.NeedGold.length);
         _loc5_ = (this.FMaxWidth - 20) / _loc2_;
         _loc1_ = 0;
         while(_loc1_ < this.MAX_COUNT)
         {
            _loc4_ = this.FMC_Scene.MC_NeedGold["MC_Item" + _loc1_];
            _loc4_.MC_Icon.gotoAndStop(this.FType);
            if(_loc1_ < _loc2_)
            {
               _loc4_.visible = true;
               _loc4_.x = this.FInitX + _loc5_ * _loc1_;
               if(_loc3_.ReturnRate[_loc1_] > 0)
               {
                  _loc4_.TF_Gold.text = _loc3_.NeedGold[_loc1_].toString();
                  _loc4_.TF_Rate.text = _loc3_.ReturnRate[_loc1_] + "%";
               }
               else
               {
                  _loc4_.TF_Gold.text = _loc3_.NeedGold[_loc1_].toString();
                  _loc4_.TF_Rate.text = STRING_CONSUMERANK.FORMAT_NONE_RATE;
               }
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         var _loc4_:TInventory = null;
         _loc3_ = this.FConsumeRank.RankRewardList2[this.FIndex].Inventories;
         _loc1_ = 0;
         while(_loc1_ < this.BOX_COUNT)
         {
            if(_loc1_ < _loc3_.Count)
            {
               _loc4_ = _loc3_.GetInventoryByIndex(_loc1_);
               this.FSlotList[_loc1_].Context = _loc4_;
               this.FSlotList[_loc1_].Resource.visible = true;
            }
            else
            {
               this.FSlotList[_loc1_].Resource.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.ACTIVE_Test);
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(this,param2);
         }
      }
      
      public function get OnQuerySequenceContext() : Function
      {
         return this.FOnQuerySequenceContext;
      }
      
      public function set OnQuerySequenceContext(param1:Function) : void
      {
         this.FOnQuerySequenceContext = param1;
      }
      
      public function get OnOverlay() : Function
      {
         return this.FOnOverlay;
      }
      
      public function set OnOverlay(param1:Function) : void
      {
         this.FOnOverlay = param1;
      }
      
      public function get OnOut() : Function
      {
         return this.FOnOut;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function get OnQuerySubscript() : Function
      {
         return this.FOnQuerySubscript;
      }
      
      public function set OnQuerySubscript(param1:Function) : void
      {
         this.FOnQuerySubscript = param1;
      }
      
      public function Init() : void
      {
         this.Initialization();
      }
      
      public function SetItemInfo(param1:uint) : void
      {
         this.FIndex = param1;
         this.UpdateContent();
         this.UpdateItem();
      }
      
      public function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = this.FSlotList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FSlotList[_loc1_].Update();
            _loc1_++;
         }
      }
   }
}

