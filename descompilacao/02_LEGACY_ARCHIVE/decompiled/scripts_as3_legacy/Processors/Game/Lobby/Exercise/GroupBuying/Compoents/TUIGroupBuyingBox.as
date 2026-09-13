package Processors.Game.Lobby.Exercise.GroupBuying.Compoents
{
   import Components.Pages.TUIPage;
   import Components.Slots.TUISlot;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.GroupBuying.TGroupBuying;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Battle.Character.TActive;
   import Rendering.Overlayers.Box.TOverlayerBox;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TUIGroupBuyingBox extends TUIComponent
   {
      
      protected var BOX_COUNT:int = 4;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMC_Items:MovieClip;
      
      protected var FMC_Box:MovieClip;
      
      protected var FMC_Hero:MovieClip;
      
      protected var FMC_HeroPosition:Sprite;
      
      protected var FBTN_ShowRecruit:MovieClip;
      
      protected var FGroupBuying:TGroupBuying;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FUIPage:TUIPage;
      
      protected var FActive:TActive;
      
      protected var FInitialized:Boolean;
      
      protected var FCurPage:int;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FOnShowRecruit:Function;
      
      public function TUIGroupBuyingBox(param1:TUIComponent)
      {
         super(param1);
         this.FGroupBuying = SLogicsCore.GroupBuying;
         this.FSlotList = new Vector.<TUISlot>(this.BOX_COUNT);
         this.FOverlayerBox = new TOverlayerBox(this.Parent.Parent);
         this.FOverlayerBox.Visible = false;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         this.FMC_Items = this.FMC_Scene.MC_Items;
         this.FMC_Box = this.FMC_Scene.MC_Box;
         this.FMC_Hero = this.FMC_Scene.MC_Hero;
         this.FMC_HeroPosition = this.FMC_Hero.MC_HeroPosition;
         this.FBTN_ShowRecruit = this.FMC_Hero.BTN_ShowRecruit;
         TGameUtil.setButtonMode(this.FBTN_ShowRecruit,true);
         this.FBTN_ShowRecruit.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnShowRecruit);
         this.Resources_UIDispatchBox();
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBox);
      }
      
      protected function Resources_UIDispatchBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         _loc1_ = 0;
         while(_loc1_ < this.BOX_COUNT)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_Items["MC_Slot" + _loc1_] as Sprite;
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
         this.FUIPage = new TUIPage(this);
         this.FUIPage.ButtonPrevious.Substrate = this.FMC_Items.Btn_Left;
         this.FUIPage.ButtonNext.Substrate = this.FMC_Items.Btn_Right;
         this.FUIPage.TotalQuantity = 1;
         this.FUIPage.PageSize = this.BOX_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         if(this.FMC_Box)
         {
            this.FMC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FMC_Box.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnBoxOut);
         }
      }
      
      protected function UpdateBox() : void
      {
         switch(this.FGroupBuying.SaleType)
         {
            case TGroupBuying.TYPE_ITEM:
               this.FMC_Items.visible = true;
               this.FMC_Box.visible = false;
               this.FMC_Hero.visible = false;
               this.UpdateItem();
               break;
            case TGroupBuying.TYPE_BOX:
               this.FMC_Items.visible = false;
               this.FMC_Box.visible = true;
               this.FMC_Hero.visible = false;
               this.UpdatePackage();
               break;
            case TGroupBuying.TYPE_HERO:
               this.FMC_Items.visible = false;
               this.FMC_Box.visible = false;
               this.FMC_Hero.visible = true;
               this.UpdateHero();
         }
      }
      
      protected function UpdateText() : void
      {
         this.FMC_Scene.TF_OrgPrice.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ORG_PRICE,this.FGroupBuying.OrigPrice);
         this.FMC_Scene.TF_CurPrice.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_CUR_PRICE,this.FGroupBuying.CurPrice);
         this.FMC_Scene.TF_DiffPrice.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_DIFF_PRICE,this.FGroupBuying.OrigPrice - this.FGroupBuying.CurPrice);
      }
      
      protected function UpdateItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         var _loc4_:TInventory = null;
         _loc3_ = this.FGroupBuying.Inventories;
         _loc1_ = 0;
         while(_loc1_ < this.BOX_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * this.BOX_COUNT;
            if(_loc2_ < _loc3_.Count)
            {
               _loc4_ = _loc3_.GetInventoryByIndex(_loc2_);
               this.FSlotList[_loc1_].Context = _loc4_;
               this.FSlotList[_loc1_].Resource.visible = true;
            }
            else
            {
               this.FSlotList[_loc1_].Resource.visible = false;
            }
            _loc1_++;
         }
         if(this.FActive)
         {
            this.FActive.Visible = false;
         }
      }
      
      protected function UpdatePackage() : void
      {
         if(this.FActive)
         {
            this.FActive.Visible = false;
         }
      }
      
      protected function UpdateHero() : void
      {
         if(!this.FActive)
         {
            this.FActive = new TActive(this,this.FGroupBuying.HeroID);
            this.FActive.X = this.FMC_HeroPosition.x + this.FMC_Scene.x;
            this.FActive.Y = this.FMC_HeroPosition.y + this.FMC_Scene.y;
         }
         this.FActive.Visible = true;
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateItem();
      }
      
      protected function ProcessorOnShowRecruit(param1:MouseEvent) : void
      {
         if(this.FOnShowRecruit != null)
         {
            this.FOnShowRecruit();
         }
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         this.FOverlayerBox.Context = this.FGroupBuying.Inventories;
         this.FOverlayerBox.Render(FUICore.MouseCoordinate);
         this.FOverlayerBox.Show();
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         this.FOverlayerBox.Hide();
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
      
      public function get OnShowRecruit() : Function
      {
         return this.FOnShowRecruit;
      }
      
      public function set OnShowRecruit(param1:Function) : void
      {
         this.FOnShowRecruit = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         if(this.FInitialized && this.Visible)
         {
            if(this.FActive)
            {
               this.FActive.UpdateActive();
            }
            if(this.FGroupBuying.SaleType == TGroupBuying.TYPE_ITEM)
            {
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
      
      public function UpdateUI() : void
      {
         this.UpdateBox();
         this.UpdateText();
      }
      
      public function RemoveHero() : void
      {
         if(this.FActive)
         {
            this.FActive.Visible = false;
         }
      }
   }
}

