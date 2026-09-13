package Processors.Game.Windows.Information
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Inventories.TInventory;
   import Processors.Game.Windows.TUIWindow;
   import Resources.Constants.CONST_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIWindowMaterialCost extends TUIWindow
   {
      
      protected static const SIZE_Window_Width:uint = 310;
      
      protected static const SIZE_Window_Height:uint = 190;
      
      protected var FLabel:TextField;
      
      protected var FQuantity:TextField;
      
      protected var FGoldQuantity:TextField;
      
      protected var FUISlot:TUISlot;
      
      protected var FModuleId:uint;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      public function TUIWindowMaterialCost(param1:TUIComponent, param2:uint)
      {
         super(param1);
         this.FModuleId = param2;
         this.AddMaskLayer();
      }
      
      protected function AddMaskLayer() : void
      {
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-(CONST_COMMON.STAGE_Width / 2),-(CONST_COMMON.STAGE_Height / 2),CONST_COMMON.STAGE_Width * 2,CONST_COMMON.STAGE_Height * 2);
         this.graphics.endFill();
      }
      
      override protected function ConstructComponentButtons() : void
      {
         FButtonOK = this.ConstructComponentButton(CONST_COMMON.RESOURCE_Link_Btn_Ok,CONST_COMMON.RESOURCE_Link_TF_BtnOkCaption,this.ButtonOKOnClick,FButtonOkCaption);
         FButtonCancel = this.ConstructComponentButton(CONST_COMMON.RESOURCE_Link_Btn_Cancel,CONST_COMMON.RESOURCE_Link_TF_BtnCancelCaption,this.ButtonCancelOnClick,FButtonCancelCaption);
      }
      
      protected function ConstructComponentButton(param1:String, param2:String = null, param3:Function = null, param4:String = null) : MovieClip
      {
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         _loc5_ = FScene[param1];
         TGameUtil.setButtonMode(_loc5_,true);
         _loc5_.addEventListener(MouseEvent.CLICK,param3,false,0,true);
         if(!TUtilityString.Empty(param2))
         {
            _loc6_ = _loc5_[param2];
            _loc6_.selectable = false;
            _loc6_.mouseEnabled = false;
         }
         if(!TUtilityString.Empty(param4))
         {
            _loc6_.text = param4;
         }
         return _loc5_;
      }
      
      override protected function ConstruceComponentTextfield() : void
      {
         super.ConstruceComponentTextfield();
         this.FLabel = FScene[CONST_COMMON.RESOURCE_Link_TF_Label];
         this.FLabel.mouseEnabled = false;
         this.FQuantity = FScene[CONST_COMMON.RESOURCE_Link_TF_Quantity];
         this.FQuantity.mouseEnabled = false;
         this.FGoldQuantity = FScene[CONST_COMMON.RESOURCE_Link_TF_GoldQuantity];
         this.FGoldQuantity.mouseEnabled = false;
      }
      
      override protected function ConstructComponentMovieClip() : void
      {
         this.FUISlot = new TUISlot(this);
         this.FUISlot.Resource = FScene[CONST_COMMON.RESOURCE_Link_MC_Slot];
         this.FUISlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FUISlot.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FUISlot.OnOverlay = this.SlotsOnOverlay;
         this.FUISlot.OnOut = this.SlotsOnOut;
         this.FUISlot.Init();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(!visible)
         {
            return;
         }
         if(this.FUISlot != null)
         {
            this.FUISlot.Update();
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,this.FModuleId);
         }
      }
      
      protected function SlotsOnOverlay(param1:Object, param2:Object) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(param1,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(param1,param2);
         }
      }
      
      protected function ButtonOKOnClick(param1:MouseEvent) : void
      {
         if(FOnOK != null)
         {
            FOnOK(this);
         }
         Visible = false;
      }
      
      protected function ButtonCancelOnClick(param1:MouseEvent) : void
      {
         if(FOnCancel != null)
         {
            FOnCancel(this);
         }
         Visible = false;
      }
      
      public function set Label(param1:String) : void
      {
         this.FLabel.text = param1;
      }
      
      public function set Quantity(param1:String) : void
      {
         this.FQuantity.text = param1;
      }
      
      public function set GoldQuantity(param1:String) : void
      {
         this.FGoldQuantity.text = param1;
      }
      
      override public function set Context(param1:Object) : void
      {
         FContext = param1;
         this.FUISlot.Context = param1;
      }
      
      public function get Window_Width() : uint
      {
         return SIZE_Window_Width;
      }
      
      public function get Window_Height() : uint
      {
         return SIZE_Window_Height;
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
   }
}

