package Processors.Game.Lobby.InviteCode.Components
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class TInviteCodeBind extends Sprite
   {
      
      new TInventories();
      
      protected var FSubstrate:MovieClip;
      
      protected var TF_Finish:TextField;
      
      protected var FAwardSlot:TUISlot;
      
      protected var TF_Condition:TextField;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FInventories:TInventories;
      
      protected var FOnOver:Function = null;
      
      protected var FOnOut:Function = null;
      
      public function TInviteCodeBind(param1:Sprite)
      {
         super();
         if(param1 != null)
         {
            param1.addChild(this);
         }
         this.Inititation();
         this.FInventories = new TInventories();
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      private function Inititation() : void
      {
         this.FSubstrate = TUtilityReflection.CreateDisplayObjectInstance("InviteCodeBind_Item") as MovieClip;
         addChild(this.FSubstrate);
         this.FAwardSlot = new TUISlot(this.parent.parent.parent as TUIComponent);
         this.FAwardSlot.Resource = this.FSubstrate["MC_Slot"];
         this.FAwardSlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FAwardSlot.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FAwardSlot.OnOverlay = this.SlotsOnOver;
         this.FAwardSlot.OnOut = this.SlotsOnOut;
         this.FAwardSlot.Init();
         this.TF_Condition = this.FSubstrate["TF_Condition"];
         this.TF_Finish = this.FSubstrate["TF_Finish"];
         this.TF_Finish.visible = false;
      }
      
      public function SetCodeInfo(param1:Object, param2:int) : void
      {
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,Vector.<uint>([param1[1]]));
         this.FAwardSlot.Context = this.FInventories.GetInventoryByIndex(0);
         this.TF_Condition.text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.STRING_yaoqingma_01).DescribeString,param1[0]);
         this.TF_Finish.visible = param1[0] <= param2 ? true : false;
      }
      
      public function UpdateSlot() : void
      {
         this.FAwardSlot.Update();
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_BaiDuMM);
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnOver != null)
         {
            this.FOnOver(param1,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(param1,param2);
         }
      }
      
      public function set OnOver(param1:Function) : void
      {
         this.FOnOver = param1;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
   }
}

