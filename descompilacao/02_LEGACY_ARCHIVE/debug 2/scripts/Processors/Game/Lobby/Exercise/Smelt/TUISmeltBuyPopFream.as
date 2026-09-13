package Processors.Game.Lobby.Exercise.Smelt
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUISmeltBuyPopFream extends TUIComponent
   {
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FInitilization:int;
      
      protected var FMC_Slot:MovieClip = null;
      
      protected var FTF_GoodsName:TextField = null;
      
      protected var FBTN_Confirm:MovieClip = null;
      
      protected var FBTN_Cancel:MovieClip = null;
      
      protected var FMC_Price:MovieClip = null;
      
      protected var FTF_Count:TextField = null;
      
      protected var FTF_AllPrice:TextField = null;
      
      protected var FBTN_Reduce:SimpleButton = null;
      
      protected var FBTN_Add:SimpleButton = null;
      
      protected var FCurData:TBaseBox = null;
      
      protected var FCurCount:int = 1;
      
      protected var FGoodsSlot:TUISlot = null;
      
      protected var Cur_One_Price:uint;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      protected var FOnOver:Function = null;
      
      protected var FOnOut:Function = null;
      
      protected var FSureBtn:Function = null;
      
      protected var FCancelBtn:Function = null;
      
      public function TUISmeltBuyPopFream(param1:TUIComponent)
      {
         super(param1);
         this.Visible = false;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(-(CONST_COMMON.STAGE_Width / 2),-(CONST_COMMON.STAGE_Height / 2),CONST_COMMON.STAGE_Width * 2,CONST_COMMON.STAGE_Height * 2);
         this.graphics.endFill();
         this.FTempSelectInventoriesId = new Vector.<uint>();
         this.FSelectInventories = new TInventories();
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FThisPanel = param1;
         addChild(this.FThisPanel);
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         this.FMC_Slot = this.FThisPanel["MC_Slot"];
         this.FTF_GoodsName = this.FThisPanel["TF_GoodsName"];
         this.FBTN_Confirm = this.FThisPanel["BTN_Confirm"];
         this.FBTN_Cancel = this.FThisPanel["BTN_Cancel"];
         TGameUtil.setButtonMode(this.FBTN_Confirm,true);
         TGameUtil.setButtonMode(this.FBTN_Cancel,true);
         this.FMC_Price = this.FThisPanel["MC_Price"];
         this.FTF_Count = this.FMC_Price["TF_Count"];
         this.FBTN_Reduce = this.FMC_Price["BTN_Reduce"];
         this.FBTN_Add = this.FMC_Price["BTN_Add"];
         this.FTF_Count.restrict = "0-9";
         this.FTF_Count.maxChars = 10;
         this.FTF_AllPrice = this.FMC_Price["TF_AllPrice"];
         this.FGoodsSlot = new TUISlot(this);
         this.FGoodsSlot.Resource = this.FMC_Slot;
         this.FGoodsSlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FGoodsSlot.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FGoodsSlot.OnOverlay = this.SlotsOnOver;
         this.FGoodsSlot.OnOut = this.SlotsOnOut;
         this.FGoodsSlot.Init();
         this.FInitilization = 1;
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
      
      public function Perform_UILocations() : void
      {
         this.FBTN_Confirm.addEventListener(MouseEvent.CLICK,this.ClichHandle);
         this.FBTN_Cancel.addEventListener(MouseEvent.CLICK,this.ClichHandle);
         this.FTF_Count.addEventListener(Event.CHANGE,this.OnTextInput);
         this.FBTN_Reduce.addEventListener(MouseEvent.CLICK,this.ClichHandle);
         this.FBTN_Add.addEventListener(MouseEvent.CLICK,this.ClichHandle);
      }
      
      public function LogicsPerform() : void
      {
         if(Boolean(this.FInitilization) && this.visible)
         {
            this.FGoodsSlot.Update();
         }
      }
      
      protected function ClichHandle(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FBTN_Confirm:
               if(this.FSureBtn != null)
               {
                  this.FSureBtn(this.FCurData,this.FCurCount);
               }
               break;
            case this.FBTN_Cancel:
               this.visible = false;
               if(this.FCancelBtn != null)
               {
                  this.FCancelBtn(this.FCurData,this.FCurCount);
               }
               break;
            case this.FBTN_Reduce:
               --this.FCurCount;
               this.FTF_Count.text = String(this.FCurCount);
               this.OnTextInput(null);
               break;
            case this.FBTN_Add:
               ++this.FCurCount;
               this.FTF_Count.text = String(this.FCurCount);
               this.OnTextInput(null);
         }
      }
      
      protected function OnTextInput(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         this.FCurCount = int(this.FTF_Count.text) > 0 ? int(this.FTF_Count.text) : 1;
         _loc2_ = this.FCurData.BuyCount;
         if(this.FCurCount > _loc2_)
         {
            this.FCurCount = _loc2_;
         }
         if(this.FCurCount <= 0)
         {
            this.FCurCount = 1;
         }
         this.UpdateView();
      }
      
      public function UpdateView() : void
      {
         this.FTF_GoodsName.text = String(this.FCurData.Inventory.Name);
         this.FTF_GoodsName.textColor = QUALITYCOLOR_INDEX[this.FSelectInventories.GetInventoryByIndex(0).Quality];
         this.FTF_Count.text = String(this.FCurCount);
         this.FTF_AllPrice.text = String(this.FCurCount * this.FCurData.Price);
      }
      
      public function set CurData(param1:TBaseBox) : void
      {
         this.FCurData = param1;
         if(this.FCurData == null)
         {
            return;
         }
         this.FCurCount = 1;
         this.UpdateInventory();
         this.UpdateView();
      }
      
      public function get CurData() : TBaseBox
      {
         return this.FCurData;
      }
      
      protected function UpdateInventory() : void
      {
         this.FTempSelectInventoriesId.length = 0;
         this.FSelectInventories.Clear();
         this.FTempSelectInventoriesId.push(this.FCurData.Inventory.IDTemplate);
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
         this.FGoodsSlot.Context = this.FSelectInventories.GetInventoryByIndex(0);
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
      
      public function set OnOver(param1:Function) : void
      {
         this.FOnOver = param1;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function set SureBtn(param1:Function) : void
      {
         this.FSureBtn = param1;
      }
      
      public function set CancelBtn(param1:Function) : void
      {
         this.FCancelBtn = param1;
      }
   }
}

