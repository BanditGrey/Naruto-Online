package Processors.Game.Lobby.Lottery.Components
{
   import Components.Slots.TUISlot;
   import Foundation.Common.THint;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TExchangeItem;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_LOTTERY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_LOTTERY;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIExchangeItem extends TUIComponent
   {
      
      protected var FMC_Item:MovieClip;
      
      protected var FMC_Slot:TUISlot;
      
      protected var FTF_Integral:TextField;
      
      protected var FBtn_Exchange:MovieClip;
      
      protected var FMC_Level:MovieClip;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_VIP:TextField;
      
      protected var FExchangeItemData:TExchangeItem;
      
      protected var FHintBoxTip:THint;
      
      protected var FMC_Buff:MovieClip;
      
      protected var FResource:Sprite;
      
      protected var FOnExchange:Function;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      public function TUIExchangeItem(param1:TUIComponent)
      {
         super(param1);
         this.FMC_Slot = new TUISlot(this);
         this.FHintBoxTip = new THint();
      }
      
      protected function UIDispatch() : void
      {
         this.FMC_Item = this.FResource as MovieClip;
         this.FTF_Integral = this.FMC_Item[CONST_LOTTERY.RESOURCE_Link_TF_Integral];
         this.FBtn_Exchange = this.FMC_Item[CONST_LOTTERY.RESOURCE_Link_Btn_Exchange];
         this.FMC_Buff = this.FMC_Item["MC_Buff"];
         this.FMC_Slot.Resource = this.FMC_Item[CONST_LOTTERY.RESOURCE_Link_MC_Slot];
         this.FMC_Slot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FMC_Slot.OnOverlay = this.SlotsOnOver;
         this.FMC_Slot.OnOut = this.SlotsOnOut;
         this.FMC_Slot.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FMC_Slot.Init();
      }
      
      protected function UILocations() : void
      {
         this.FBtn_Exchange.addEventListener(MouseEvent.CLICK,this.ExchangeOnClick);
         this.FBtn_Exchange.addEventListener(MouseEvent.MOUSE_OVER,this.ExchangeOnOver);
         this.FBtn_Exchange.addEventListener(MouseEvent.MOUSE_OUT,this.ExchangeOnOut);
      }
      
      protected function UpdateItemInfo() : void
      {
         if(SLogicsCore.Lottery.Point >= this.FExchangeItemData.CostPoint)
         {
            if(this.FExchangeItemData.BuyCount < this.FExchangeItemData.LimitCount)
            {
               TGameUtil.setButtonMode(this.FBtn_Exchange,true);
            }
            else
            {
               TGameUtil.setButtonMode(this.FBtn_Exchange,false);
            }
         }
         else
         {
            TGameUtil.setButtonMode(this.FBtn_Exchange,false);
         }
         this.FTF_Integral.text = TUtilityString.Format(STRING_LOTTERY.FORMAT_Exchange_Point,this.FExchangeItemData.CostPoint);
         if(SLogicsCore.Character.GetMainLevel() < this.FExchangeItemData.LimitLevel && this.FExchangeItemData.LimitLevel > 1)
         {
            if(this.FMC_Buff != null)
            {
               this.FMC_Buff.visible = true;
               this.FMC_Buff.TF_Buff.text = TUtilityString.Format(STRING_LOTTERY.FORMAT_EXCHANGE_LEVEL,this.FExchangeItemData.LimitLevel);
            }
            this.FBtn_Exchange.visible = false;
         }
         else
         {
            if(this.FMC_Buff != null)
            {
               this.FMC_Buff.visible = false;
            }
            this.FBtn_Exchange.visible = true;
         }
      }
      
      protected function UpdateSlotInfo() : void
      {
         this.FMC_Slot.Context = this.FExchangeItemData.Inventories.GetInventoryByIndex(0);
      }
      
      protected function ExchangeOnClick(param1:MouseEvent) : void
      {
         if(param1.currentTarget.buttonMode == false)
         {
            return;
         }
         TGameUtil.setButtonMode(this.FBtn_Exchange,false);
         if(this.FOnExchange != null)
         {
            this.FOnExchange(this.FExchangeItemData.Identify);
         }
      }
      
      protected function ExchangeOnOver(param1:MouseEvent) : void
      {
         if(param1.currentTarget.buttonMode == true)
         {
            return;
         }
         if(SLogicsCore.Lottery.Point < this.FExchangeItemData.CostPoint)
         {
            this.FHintBoxTip.Caption = STRING_LOTTERY.FORMAT_TIP_BUY_COST;
         }
         else if(this.FExchangeItemData.BuyCount >= this.FExchangeItemData.LimitCount)
         {
            this.FHintBoxTip.Caption = STRING_LOTTERY.FORMAT_TIP_ITEM_LIMIT;
         }
         if(this.FTipOnOver != null)
         {
            this.FTipOnOver(param1,this.FHintBoxTip);
         }
      }
      
      protected function ExchangeOnOut(param1:MouseEvent) : void
      {
         if(param1.currentTarget.buttonMode == true)
         {
            return;
         }
         if(this.FTipOnOut != null)
         {
            this.FTipOnOut(param1);
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
      
      public function get Resource() : Sprite
      {
         return this.FResource;
      }
      
      public function set Resource(param1:Sprite) : void
      {
         this.FResource = param1;
      }
      
      public function get OnExchange() : Function
      {
         return this.FOnExchange;
      }
      
      public function set OnExchange(param1:Function) : void
      {
         this.FOnExchange = param1;
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
      
      public function get TipOnOver() : Function
      {
         return this.FTipOnOver;
      }
      
      public function set TipOnOver(param1:Function) : void
      {
         this.FTipOnOver = param1;
      }
      
      public function get TipOnOut() : Function
      {
         return this.FTipOnOut;
      }
      
      public function set TipOnOut(param1:Function) : void
      {
         this.FTipOnOut = param1;
      }
      
      public function Init() : void
      {
         this.UIDispatch();
         this.UILocations();
      }
      
      public function SetItemInfo(param1:TExchangeItem) : void
      {
         this.FExchangeItemData = param1;
         this.UpdateItemInfo();
         this.UpdateSlotInfo();
      }
      
      public function UpdateSlot() : void
      {
         if(this.FMC_Slot != null)
         {
            this.FMC_Slot.Update();
         }
      }
      
      public function getIdentify() : int
      {
         return this.FExchangeItemData.Identify;
      }
      
      public function get BuyCount() : int
      {
         return this.FExchangeItemData.BuyCount;
      }
      
      public function set BuyCount(param1:int) : void
      {
         this.FExchangeItemData.BuyCount = param1;
      }
   }
}

