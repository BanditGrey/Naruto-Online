package Processors.Game.Windows.Editors
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Inventories.TInventory;
   import Processors.Game.Windows.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TUIWindowEditor extends TUIWindow
   {
      
      public static const SIZE_Window_Width:uint = 326;
      
      public static const SIZE_Window_Height:uint = 201;
      
      protected var FBtnClose:SimpleButton;
      
      protected var FCaption:TextField;
      
      protected var FLabel:TextField;
      
      protected var FQuantity:TextField;
      
      protected var FText:TextField;
      
      protected var FButtonMax:MovieClip;
      
      protected var FUISlot:TUISlot;
      
      protected var FModuleId:uint;
      
      protected var FMax:int;
      
      protected var FMin:int;
      
      protected var FEditorCaption:String;
      
      protected var FButtonMaxCaption:String;
      
      protected var FInputName:String;
      
      protected var FPriceText:String;
      
      protected var FOnMax:Function;
      
      protected var FCanUseMax:int;
      
      public function TUIWindowEditor(param1:TUIComponent, param2:uint)
      {
         this.AddMaskLayer();
         super(param1);
         this.FModuleId = param2;
      }
      
      override protected function ConstructComponentButtons() : void
      {
         FButtonOK = this.ConstructComponentButton(CONST_COMMON.RESOURCE_Link_Btn_Ok,CONST_COMMON.RESOURCE_Link_TF_BtnOkCaption,this.ButtonOKOnClick,FButtonOkCaption);
         FButtonCancel = this.ConstructComponentButton(CONST_COMMON.RESOURCE_Link_Btn_Cancel,CONST_COMMON.RESOURCE_Link_TF_BtnCancelCaption,this.ButtonCancelOnClick,FButtonCancelCaption);
         this.FButtonMax = this.ConstructComponentButton(CONST_COMMON.RESOURCE_Link_Btn_Max,CONST_COMMON.RESOURCE_Link_TF_BtnMaxCaption,this.ButtonMaxOnClick,this.FButtonMaxCaption);
      }
      
      protected function ConstructComponentButton(param1:String, param2:String = null, param3:Function = null, param4:String = null) : MovieClip
      {
         var _loc6_:TextField = null;
         var _loc5_:MovieClip = FScene[param1];
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
         this.FCaption = FScene[CONST_COMMON.RESOURCE_Link_TF_Caption];
         if(!TUtilityString.Empty(this.FEditorCaption))
         {
            this.FCaption.text = this.FEditorCaption;
         }
         this.FLabel = FScene[CONST_COMMON.RESOURCE_Link_TF_Label];
         this.FQuantity = FScene[CONST_COMMON.RESOURCE_Link_TF_Quantity];
         this.FText = FScene[CONST_COMMON.RESOURCE_Link_TF_Value];
         this.FText.restrict = "0-9";
         this.FText.addEventListener(Event.CHANGE,this.TextFieldOnChange);
      }
      
      override protected function ConstructComponentMovieClip() : void
      {
         this.FUISlot = new TUISlot(this);
         this.FUISlot.Resource = FScene[CONST_COMMON.RESOURCE_Link_MC_Slot];
         this.FUISlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FUISlot.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FUISlot.Init();
      }
      
      override protected function NCButtonCloseOnClick(param1:Object) : void
      {
         if(FOnCancel != null)
         {
            FOnCancel(this);
         }
         Visible = false;
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
      
      protected function ButtonMaxOnClick(param1:MouseEvent) : void
      {
         if(this.FOnMax != null)
         {
            this.FOnMax(this);
         }
      }
      
      protected function TextFieldOnChange(param1:Event) : void
      {
         var _loc2_:uint = uint(this.FText.text);
         if(_loc2_ < this.FMin)
         {
            this.FText.text = this.FMin.toString();
         }
         else if(this.FCanUseMax != 0 && _loc2_ > this.FCanUseMax)
         {
            this.FText.text = this.FCanUseMax.toString();
         }
         else if(_loc2_ > this.FMax)
         {
            this.FText.text = this.FMax.toString();
         }
         else
         {
            this.FText.text = _loc2_.toString();
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
      
      public function get WindowWidth() : int
      {
         return SIZE_Window_Width;
      }
      
      public function get WindowHeight() : int
      {
         return SIZE_Window_Height;
      }
      
      public function get EditorCaption() : String
      {
         return this.FEditorCaption;
      }
      
      public function set EditorCaption(param1:String) : void
      {
         this.FEditorCaption = param1;
      }
      
      public function get ButtonMaxCaption() : String
      {
         return this.FButtonMaxCaption;
      }
      
      public function set ButtonMaxCaption(param1:String) : void
      {
         this.FButtonMaxCaption = param1;
      }
      
      public function set Label(param1:String) : void
      {
         this.FLabel.text = param1;
      }
      
      public function get Label() : String
      {
         return this.FLabel.text;
      }
      
      public function get Quantity() : String
      {
         return this.FQuantity.text;
      }
      
      public function set Quantity(param1:String) : void
      {
         this.FQuantity.text = param1;
      }
      
      public function set Value(param1:uint) : void
      {
         if(param1 < this.FMin)
         {
            this.FText.text = this.FMin.toString();
         }
         if(param1 > this.FMax)
         {
            this.FText.text = this.FMax.toString();
         }
         if(this.FCanUseMax != 0 && param1 > this.FCanUseMax)
         {
            param1 = uint(this.FCanUseMax);
         }
         this.FText.text = param1.toString();
      }
      
      public function get Value() : uint
      {
         return uint(this.FText.text);
      }
      
      public function get ButtonMax() : MovieClip
      {
         return this.FButtonMax;
      }
      
      public function get Max() : int
      {
         return this.FMax;
      }
      
      public function set Max(param1:int) : void
      {
         this.FMax = param1;
      }
      
      public function get Min() : int
      {
         return this.FMin;
      }
      
      public function set Min(param1:int) : void
      {
         this.FMin = param1;
      }
      
      public function get OnMax() : Function
      {
         return this.FOnMax;
      }
      
      public function set OnMax(param1:Function) : void
      {
         this.FOnMax = param1;
      }
      
      override public function get Context() : Object
      {
         return this.FUISlot.Context;
      }
      
      override public function set Context(param1:Object) : void
      {
         this.FUISlot.Context = param1;
      }
      
      public function get CanUseMax() : int
      {
         return this.FCanUseMax;
      }
      
      public function set CanUseMax(param1:int) : void
      {
         this.FCanUseMax = param1;
      }
      
      public function SetFocus() : void
      {
         if(FUICore.UIStage.focus != this.FText)
         {
            FUICore.UIStage.focus = this.FText;
         }
      }
      
      public function Update() : void
      {
         this.FUISlot.Update();
      }
      
      public function SetCountVisible(param1:Boolean) : void
      {
         this.FQuantity.visible = param1;
      }
      
      public function AddMaskLayer() : void
      {
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-(CONST_COMMON.STAGE_Width - SIZE_Window_Width) / 2,-(CONST_COMMON.STAGE_Height - SIZE_Window_Height) / 2,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
      }
   }
}

