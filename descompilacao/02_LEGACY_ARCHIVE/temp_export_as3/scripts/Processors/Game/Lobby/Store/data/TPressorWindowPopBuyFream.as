package Processors.Game.Lobby.Store.data
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_STORE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TPressorWindowPopBuyFream extends TProcessorLobbyWindow
   {
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FInitilization:int;
      
      protected var FMC_Slot:MovieClip = null;
      
      protected var FTF_GoodsName:TextField = null;
      
      protected var FTF_OriginalPrice:TextField = null;
      
      protected var FBTN_Confirm:MovieClip = null;
      
      protected var FBTN_Cancel:MovieClip = null;
      
      protected var FMC_Price:MovieClip = null;
      
      protected var FTF_Count:TextField = null;
      
      protected var FTF_AllPrice:TextField = null;
      
      protected var FBTN_Reduce:SimpleButton = null;
      
      protected var FBTN_Add:SimpleButton = null;
      
      protected var FCurData:NewMallCellData = null;
      
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
      
      public function TPressorWindowPopBuyFream(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(-(CONST_COMMON.STAGE_Width / 2),-(CONST_COMMON.STAGE_Height / 2),CONST_COMMON.STAGE_Width * 2,CONST_COMMON.STAGE_Height * 2);
         this.graphics.endFill();
         this.FTempSelectInventoriesId = new Vector.<uint>();
         this.FSelectInventories = new TInventories();
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_STORE.This_Resource_Id);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_STORE.This_Panel_Pop) as MovieClip;
         addChild(this.FThisPanel);
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         this.FMC_Slot = this.FThisPanel["MC_Slot"];
         this.FTF_GoodsName = this.FThisPanel["TF_GoodsName"];
         this.FTF_OriginalPrice = this.FThisPanel["TF_OriginalPrice"];
         this.FBTN_Confirm = this.FThisPanel["BTN_Confirm"];
         this.FBTN_Cancel = this.FThisPanel["BTN_Cancel"];
         TGameUtil.setButtonMode(this.FBTN_Confirm,true);
         TGameUtil.setButtonMode(this.FBTN_Cancel,true);
         this.FMC_Price = this.FThisPanel["MC_Price"];
         this.FTF_Count = this.FMC_Price["TF_Count"];
         this.FBTN_Reduce = this.FMC_Price["BTN_Reduce"];
         this.FBTN_Add = this.FMC_Price["BTN_Add"];
         this.FTF_Count.restrict = "0-9";
         this.FTF_Count.maxChars = 5;
         this.FTF_AllPrice = this.FMC_Price["TF_AllPrice"];
         this.FGoodsSlot = new TUISlot(this);
         this.FGoodsSlot.Resource = this.FMC_Slot;
         this.FGoodsSlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FGoodsSlot.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FGoodsSlot.OnOverlay = this.SlotsOnOver;
         this.FGoodsSlot.OnOut = this.SlotsOnOut;
         this.FGoodsSlot.Init();
         this.FInitilization = 1;
         super.ResourcesPerform_UIDispatch();
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
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Confirm.addEventListener(MouseEvent.CLICK,this.ClichHandle);
         this.FBTN_Cancel.addEventListener(MouseEvent.CLICK,this.ClichHandle);
         this.FTF_Count.addEventListener(Event.CHANGE,this.OnTextInput);
         this.FBTN_Reduce.addEventListener(MouseEvent.CLICK,this.ClichHandle);
         this.FBTN_Add.addEventListener(MouseEvent.CLICK,this.ClichHandle);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         if(Boolean(this.FInitilization) && this.visible)
         {
            this.FGoodsSlot.Update();
         }
         super.LogicsPerform();
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
         switch(this.FCurData.NewMall.Currencytype)
         {
            case 0:
               _loc3_ = SLogicsCore.Character.CreditSilverCoin.ToNumber();
               break;
            case 1:
               _loc3_ = SLogicsCore.Character.CreditGiftCertificate;
               break;
            case 2:
               _loc3_ = SLogicsCore.Character.CreditGold;
               break;
            case 3:
               _loc3_ = SLogicsCore.Character.CreditGold + SLogicsCore.Character.CreditGiftCertificate;
         }
         _loc2_ = int(_loc3_ / this.FCurData.NewMall.Price);
         if(this.FCurCount > _loc2_)
         {
            this.FCurCount = _loc2_;
         }
         if(this.FCurData.NewMall.Title == 3 || this.FCurData.NewMall.Title == 4)
         {
            if(this.FCurCount > this.FCurData.ToDayCanBuyCount)
            {
               this.FCurCount = this.FCurData.ToDayCanBuyCount;
            }
         }
         if(this.FCurCount <= 0)
         {
            this.FCurCount = 1;
         }
         this.UpdateView();
      }
      
      public function UpdateView() : void
      {
         MovieClip(this.FThisPanel["Mc_Icon1"]).gotoAndStop(this.GetIcon());
         this.FTF_GoodsName.text = String(this.FCurData.NewMall.Name);
         this.FTF_GoodsName.textColor = QUALITYCOLOR_INDEX[this.FSelectInventories.GetInventoryByIndex(0).Quality];
         this.FTF_OriginalPrice.text = String(this.Cur_One_Price);
         this.FTF_Count.text = String(this.FCurCount);
         this.FTF_AllPrice.text = String(this.FCurCount * this.Cur_One_Price);
      }
      
      public function set CurData(param1:NewMallCellData) : void
      {
         this.FCurData = param1;
         this.FCurCount = 1;
         this.GetPrice();
         this.UpdateInventory();
         this.UpdateView();
      }
      
      protected function GetIcon() : uint
      {
         var _loc1_:int = 2;
         if(this.FCurData.NewMall.Currencytype == 2)
         {
            _loc1_ = 1;
         }
         return _loc1_;
      }
      
      protected function GetPrice() : void
      {
         if(Boolean(SLogicsCore.Character.VipData.StonePecent) && this.FCurData.NewMall.VipPrice != 0)
         {
            this.Cur_One_Price = this.FCurData.NewMall.VipPrice;
         }
         else
         {
            this.Cur_One_Price = this.FCurData.NewMall.Price;
         }
      }
      
      public function get CurData() : NewMallCellData
      {
         return this.FCurData;
      }
      
      protected function UpdateInventory() : void
      {
         this.FTempSelectInventoriesId.length = 0;
         this.FSelectInventories.Clear();
         this.FTempSelectInventoriesId.push(this.FCurData.Artial.Identifier);
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_NewMall);
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

