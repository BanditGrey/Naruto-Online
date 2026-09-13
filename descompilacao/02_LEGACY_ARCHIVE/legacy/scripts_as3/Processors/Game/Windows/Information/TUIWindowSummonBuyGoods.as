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
   import Logics.Inventories.TInventorySample;
   import Processors.Game.Windows.TUIWindow;
   import Resources.Constants.CONST_COMMON;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIWindowSummonBuyGoods extends TUIWindow
   {
      
      protected static const SIZE_Window_Width:uint = 330;
      
      protected static const SIZE_Window_Height:uint = 274;
      
      protected var FCaption:TextField;
      
      protected var FLabel:TextField;
      
      protected var FText:TextField;
      
      protected var FTF_Desc:TextField;
      
      protected var FBTN_Reduce:SimpleButton;
      
      protected var FBTN_Add:SimpleButton;
      
      protected var FUISlot:TUISlot;
      
      protected var FGoodsNum:int;
      
      protected var FInventorySample:TInventorySample;
      
      protected var FModuleId:uint;
      
      public var PointId:uint;
      
      public function TUIWindowSummonBuyGoods(param1:TUIComponent, param2:uint)
      {
         super(param1);
         this.FModuleId = param2;
         this.AddMaskLayer();
         this.FGoodsNum = 1;
      }
      
      override protected function ConstructComponentButtons() : void
      {
         FButtonOK = this.ConstructComponentButton(CONST_COMMON.RESOURCE_Link_Btn_Ok,CONST_COMMON.RESOURCE_Link_TF_BtnOkCaption,this.ButtonOKOnClick,FButtonOkCaption);
         FButtonCancel = this.ConstructComponentButton(CONST_COMMON.RESOURCE_Link_Btn_Cancel,CONST_COMMON.RESOURCE_Link_TF_BtnCancelCaption,this.ButtonCancelOnClick,FButtonCancelCaption);
         this.FBTN_Reduce = FScene["BTN_Reduce"];
         this.FBTN_Add = FScene["BTN_Add"];
         this.FBTN_Reduce.addEventListener(MouseEvent.CLICK,this.ReduceOnClick,false,0,true);
         this.FBTN_Add.addEventListener(MouseEvent.CLICK,this.AddOnClick,false,0,true);
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
         this.FText = FScene[CONST_COMMON.RESOURCE_Link_TF_Value];
         this.FText.restrict = "0-9";
         this.FText.addEventListener(Event.CHANGE,this.TextFieldOnChange);
         this.FTF_Desc = FScene["TF_Desc"];
      }
      
      override protected function ConstructComponentMovieClip() : void
      {
         this.FUISlot = new TUISlot(this);
         this.FUISlot.Resource = FScene[CONST_COMMON.RESOURCE_Link_MC_Slot];
         this.FUISlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FUISlot.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FUISlot.Init();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FUISlot != null)
         {
            this.FUISlot.Update();
         }
      }
      
      protected function UpdateItemInfo() : void
      {
         this.FLabel.text = this.FInventorySample.Name;
         this.FUISlot.Context = this.FInventorySample.Inventory;
      }
      
      protected function UpdatePrice() : void
      {
         this.FText.text = this.FGoodsNum.toString();
         this.FTF_Desc.text = TUtilityString.Format(TUtilityString.GetText(80002365),this.FInventorySample.Integration * this.FGoodsNum);
      }
      
      protected function UpdateUI() : void
      {
         this.UpdateItemInfo();
         this.UpdatePrice();
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
      
      protected function TextFieldOnChange(param1:Event) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc3_ = this.PointId;
         this.FGoodsNum = int(this.FText.text) > 0 ? int(this.FText.text) : 1;
         _loc2_ = uint(_loc3_ / this.FInventorySample.Integration);
         if(this.FGoodsNum > _loc2_)
         {
            this.FGoodsNum = _loc2_ == 0 ? 1 : int(_loc2_);
         }
         this.UpdatePrice();
      }
      
      protected function AddOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc3_ = this.PointId;
         ++this.FGoodsNum;
         _loc2_ = uint(_loc3_ / this.FInventorySample.Integration);
         if(_loc2_ < this.FGoodsNum)
         {
            this.FGoodsNum = _loc2_ == 0 ? 1 : int(_loc2_);
         }
         this.UpdatePrice();
      }
      
      protected function ReduceOnClick(param1:MouseEvent) : void
      {
         --this.FGoodsNum;
         if(this.FGoodsNum <= 0)
         {
            this.FGoodsNum = 1;
         }
         this.UpdatePrice();
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
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         if(FOnCancel != null)
         {
            FOnCancel(this);
         }
         Visible = false;
      }
      
      public function set Value(param1:uint) : void
      {
         this.FText.text = param1.toString();
      }
      
      public function get Value() : uint
      {
         return uint(this.FText.text);
      }
      
      public function get Window_Width() : uint
      {
         return SIZE_Window_Width;
      }
      
      public function get Window_Height() : uint
      {
         return SIZE_Window_Height;
      }
      
      public function Update() : void
      {
         this.FInventorySample = FContext as TInventorySample;
         if(this.FInventorySample == null)
         {
            return;
         }
         this.UpdateUI();
      }
      
      public function SetFocus() : void
      {
         if(FUICore.UIStage.focus != this.FText)
         {
            FUICore.UIStage.focus = this.FText;
         }
      }
      
      public function UpdateSlot() : void
      {
         this.FUISlot.Update();
      }
      
      public function Reset() : void
      {
         this.FGoodsNum = 1;
         this.FUISlot.Context = null;
      }
      
      public function AddMaskLayer() : void
      {
         FModalLayer.graphics.beginFill(0,0.3);
         FModalLayer.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         FModalLayer.graphics.endFill();
      }
   }
}

