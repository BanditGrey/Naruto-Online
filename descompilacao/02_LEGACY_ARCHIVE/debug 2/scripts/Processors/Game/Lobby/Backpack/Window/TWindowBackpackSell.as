package Processors.Game.Lobby.Backpack.Window
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventory;
   import Resources.Constants.CONST_BACKPACK;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_BACKPACK;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TWindowBackpackSell extends TUIComponent
   {
      
      protected static const SIZE_Window_Width:uint = 330;
      
      protected static const SIZE_Window_Height:uint = 274;
      
      protected static const STRINGS_Prompt_Sell:String = STRING_BACKPACK.STRINGS_Prompt_Sell;
      
      protected var FScene:Sprite;
      
      protected var FUISlot:TUISlot;
      
      protected var FInventory:TInventory;
      
      protected var FMaxCount:int;
      
      protected var FCurCount:int;
      
      protected var FOnOK:Function;
      
      protected var FSlotsOnQuerySequenceContext:Function;
      
      protected var FSlotsOnOver:Function;
      
      protected var FSlotsOnOut:Function;
      
      public function TWindowBackpackSell(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-(CONST_COMMON.STAGE_Width / 2),-(CONST_COMMON.STAGE_Height / 2),CONST_COMMON.STAGE_Width * 2,CONST_COMMON.STAGE_Height * 2);
         this.graphics.endFill();
         this.InitView();
      }
      
      protected function InitView() : void
      {
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_BACKPACK.RESOURCE_ClassName_MC_BackpackSell) as Sprite;
         addChild(this.FScene);
         this.FUISlot = new TUISlot(this);
         this.FUISlot.Resource = this.FScene["MC_Slot"] as Sprite;
         this.FUISlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FUISlot.OnQuerySequenceContext = this.OnSlotsOnQuerySequenceContext;
         this.FUISlot.OnOverlay = this.OnSlotsOnOver;
         this.FUISlot.OnOut = this.OnSlotsOnOut;
         this.FUISlot.Init();
         TGameUtil.setButtonMode(this.FScene["BTN_Max"],true);
         TGameUtil.setButtonMode(this.FScene["BTN_Confirm"],true);
         TGameUtil.setButtonMode(this.FScene["BTN_Cancel"],true);
         this.FScene["BTN_Max"].addEventListener(MouseEvent.CLICK,this.OnMaxClick);
         this.FScene["BTN_Reduce"].addEventListener(MouseEvent.CLICK,this.OnReduceClick);
         this.FScene["BTN_Add"].addEventListener(MouseEvent.CLICK,this.OnAddClick);
         this.FScene["BTN_Confirm"].addEventListener(MouseEvent.CLICK,this.OnConfirmClick);
         this.FScene["BTN_Cancel"].addEventListener(MouseEvent.CLICK,this.OnCancelClick);
         this.FScene["TF_GoodsNum"].addEventListener(Event.CHANGE,this.OnTextChange);
      }
      
      protected function CheckInfo() : void
      {
         var _loc1_:uint = 0;
         if(this.FInventory is TEquipment)
         {
            _loc1_ = this.FInventory.SellValue + this.FInventory.SellingValue;
         }
         else
         {
            _loc1_ = this.FCurCount * this.FInventory.SellValue;
         }
         this.FScene["TF_Info"].text = TUtilityString.Format(STRINGS_Prompt_Sell,this.FInventory.Name,this.FCurCount,_loc1_);
         this.FScene["TF_GoodsNum"].text = "" + this.FCurCount;
      }
      
      protected function OnSlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         if(this.FSlotsOnQuerySequenceContext != null)
         {
            this.FSlotsOnQuerySequenceContext(param1,param2,param3,param4 = 0);
         }
      }
      
      protected function OnSlotsOnOver(param1:Object, param2:TInventory) : void
      {
         if(this.FSlotsOnOver != null)
         {
            this.FSlotsOnOver(param1,param2);
         }
      }
      
      protected function OnSlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FSlotsOnOut != null)
         {
            this.FSlotsOnOut(param1,param2);
         }
      }
      
      protected function OnMaxClick(param1:MouseEvent = null) : void
      {
         this.FCurCount = this.FMaxCount;
         this.CheckInfo();
      }
      
      protected function OnReduceClick(param1:MouseEvent) : void
      {
         --this.FCurCount;
         if(this.FCurCount < 1)
         {
            this.FCurCount = 1;
         }
         this.CheckInfo();
      }
      
      protected function OnAddClick(param1:MouseEvent) : void
      {
         ++this.FCurCount;
         if(this.FCurCount > this.FMaxCount)
         {
            this.FCurCount = this.FMaxCount;
         }
         this.CheckInfo();
      }
      
      protected function OnConfirmClick(param1:MouseEvent) : void
      {
         Visible = false;
         if(this.FOnOK != null)
         {
            this.FOnOK(this);
         }
      }
      
      protected function OnCancelClick(param1:MouseEvent) : void
      {
         Visible = false;
      }
      
      protected function OnTextChange(param1:Event) : void
      {
         this.FCurCount = int(this.FScene["TF_GoodsNum"].text);
         if(this.FCurCount > this.FMaxCount)
         {
            this.FCurCount = this.FMaxCount;
         }
         if(this.FCurCount < 1)
         {
            this.FCurCount = 1;
         }
         this.CheckInfo();
      }
      
      public function get OnOK() : Function
      {
         return this.FOnOK;
      }
      
      public function set OnOK(param1:Function) : void
      {
         this.FOnOK = param1;
      }
      
      public function get SlotsOnQuerySequenceContext() : Function
      {
         return this.FSlotsOnQuerySequenceContext;
      }
      
      public function set SlotsOnQuerySequenceContext(param1:Function) : void
      {
         this.FSlotsOnQuerySequenceContext = param1;
      }
      
      public function get SlotsOnOver() : Function
      {
         return this.FSlotsOnOver;
      }
      
      public function set SlotsOnOver(param1:Function) : void
      {
         this.FSlotsOnOver = param1;
      }
      
      public function get SlotsOnOut() : Function
      {
         return this.FSlotsOnOut;
      }
      
      public function set SlotsOnOut(param1:Function) : void
      {
         this.FSlotsOnOut = param1;
      }
      
      public function get WindowWidth() : int
      {
         return SIZE_Window_Width;
      }
      
      public function get WindowHeight() : int
      {
         return SIZE_Window_Height;
      }
      
      public function get Inventory() : TInventory
      {
         return this.FInventory;
      }
      
      public function get CurCount() : uint
      {
         return this.FCurCount;
      }
      
      public function SetItem(param1:TInventory) : void
      {
         this.FInventory = param1;
         this.FUISlot.Context = this.FInventory;
         this.FMaxCount = this.FInventory.Quantity;
         this.FScene["TF_GoodsName"].text = this.FInventory.Name;
         this.OnMaxClick();
         this.CheckInfo();
      }
      
      public function UpdateSlot() : void
      {
         if(!Visible)
         {
            return;
         }
         if(this.FInventory == null)
         {
            return;
         }
         if(this.FScene == null)
         {
            return;
         }
         this.FUISlot.Update();
      }
   }
}

