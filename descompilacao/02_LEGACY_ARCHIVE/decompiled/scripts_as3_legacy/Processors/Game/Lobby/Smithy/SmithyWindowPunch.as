package Processors.Game.Lobby.Smithy
{
   import Components.Slots.TUISlot;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TDigHoleCost;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Jade.TJadeCommon;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_SMITHY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class SmithyWindowPunch extends TProcessorLobbyWindow
   {
      
      protected static const STATE_READY:int = 0;
      
      protected static const STATE_PUNCH:int = 1;
      
      protected var FCurrentState:int;
      
      protected var FInitialization:Boolean;
      
      protected var FEquipmentSlot:TUISlot;
      
      protected var FEquipment:TEquipment;
      
      protected var FTF_HoleCount:TextField;
      
      protected var FTF_UseHoleStoneCount:TextField;
      
      protected var FTF_UseCoin:TextField;
      
      protected var FTF_HasHoleStoneCount:TextField;
      
      protected var FBtn_Punch:MovieClip;
      
      protected var FDigHoleCostBins:TBins;
      
      protected var FNeedStone:uint;
      
      protected var FNeedCoin:uint;
      
      protected var FHeroID:uint;
      
      protected var FPunchNetwork:Function;
      
      protected var FStrengthenResult:uint;
      
      protected var FOnSlotMouseOver:Function;
      
      protected var FOnSlotMouseOut:Function;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FBackReset:Function;
      
      public function SmithyWindowPunch(param1:TUIComponent)
      {
         super(param1);
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.addChild(param1);
         this.FEquipmentSlot = new TUISlot(this);
         this.FEquipmentSlot.Resource = param1["Wash_Slot"];
         this.FTF_HoleCount = param1["tf_HoleCount"];
         this.FTF_UseHoleStoneCount = param1["tf_UseHoleStoneCount"];
         this.FTF_UseCoin = param1["tf_UseCoin"];
         this.FTF_HasHoleStoneCount = param1["tf_HasHoleStoneCount"];
         this.FBtn_Punch = param1["SingleRefined"];
      }
      
      public function Perform_UILocation() : void
      {
         TJadeCommon.InitSlot(this.FEquipmentSlot,CONST_MODULES.MODULE_Smithy);
         this.FEquipmentSlot.OnClick = this.OnSlotClick;
         this.FEquipmentSlot.OnOverlay = this.UIComponentsHintOnOver;
         this.FEquipmentSlot.OnOut = this.UIComponentsHintOnOut;
         this.FEquipmentSlot.Init();
         this.FBtn_Punch.addEventListener(MouseEvent.CLICK,this.OnBtnPunchClick);
         this.FDigHoleCostBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DigHoleCost);
         this.FInitialization = true;
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FInitialization && Visible)
         {
            this.FEquipmentSlot.Update();
         }
      }
      
      protected function ResetBtn() : void
      {
         TGameUtil.setButtonMode(this.FBtn_Punch,false);
         if(this.FBackReset != null)
         {
            this.FBackReset();
         }
      }
      
      protected function SendEquipment(param1:TEquipment) : void
      {
         this.FEquipment = param1;
         TGameUtil.setButtonMode(this.FBtn_Punch,this.FEquipment != null);
         this.UpdateEquipmentSlot();
      }
      
      protected function UpdateEquipmentSlot() : void
      {
         var _loc1_:TDigHoleCost = null;
         var _loc2_:uint = 0;
         this.FEquipmentSlot.Context = this.FEquipment;
         if(this.FEquipment == null)
         {
            this.FTF_HoleCount.text = "0";
            this.FTF_UseHoleStoneCount.text = "0";
            this.FTF_UseCoin.text = "0";
            this.FNeedStone = 0;
            this.FNeedCoin = 0;
         }
         else
         {
            _loc1_ = this.FDigHoleCostBins.GetDatebaseByIdentifier(this.FEquipment.RequirementLevel * 100 + this.FEquipment.Quality) as TDigHoleCost;
            if(_loc1_ == null)
            {
               return;
            }
            _loc2_ = this.FEquipment.DigHoleNum - this.FEquipment.ExpandHoleCount;
            this.FNeedStone = _loc1_["CostItem_Hole" + (this.FEquipment.DigHoleNum - _loc2_ + 1)];
            this.FNeedCoin = _loc1_["CostCoin_Hole" + (this.FEquipment.DigHoleNum - _loc2_ + 1)];
            this.FTF_HoleCount.text = String(_loc2_);
            this.FTF_UseHoleStoneCount.text = String(this.FNeedStone);
            this.FTF_UseCoin.text = String(this.FNeedCoin);
         }
         this.FTF_HasHoleStoneCount.text = String(this.GetExpandHoleStoneCount());
      }
      
      protected function GetExpandHoleStoneCount() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         var _loc4_:TInventory = null;
         var _loc5_:uint = 0;
         _loc3_ = SLogicsCore.Character.Appliances;
         _loc2_ = _loc3_.Count;
         _loc5_ = 0;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_.GetInventoryByIndex(_loc1_);
            if(_loc4_.CategorySecond == CONST_INVENTORY.CATEGORYSECOND_ExtendHoleStone)
            {
               _loc5_ += _loc4_.Quantity;
            }
            _loc1_++;
         }
         return _loc5_;
      }
      
      protected function ResetEquipmentSlot() : void
      {
         this.FEquipment = null;
         this.UpdateEquipmentSlot();
      }
      
      protected function OnBtnPunchClick(param1:MouseEvent) : void
      {
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FEquipment == null)
         {
            return;
         }
         if(this.FEquipment.ExpandHoleCount >= this.FEquipment.DigHoleNum)
         {
            EffectGenerateText(STRING_SMITHY.STRING_MAXHOLE);
            return;
         }
         if(this.FNeedStone > this.GetExpandHoleStoneCount())
         {
            EffectGenerateText(STRING_SMITHY.STRING_NOTENOUGHSTONE);
            return;
         }
         if(this.FNeedCoin > SLogicsCore.Character.CreditSilverCoin.ToNumber())
         {
            EffectGenerateText(STRING_COMMON.NOTENOUGH_Coin);
            return;
         }
         if(this.FPunchNetwork != null)
         {
            this.FPunchNetwork(this.FEquipment.Identifier0,this.FEquipment.Identifier1);
            this.FCurrentState = STATE_PUNCH;
         }
      }
      
      protected function OnSlotClick(param1:Object = null, param2:Object = null) : void
      {
         var _loc3_:TUISlot = null;
         _loc3_ = param1 as TUISlot;
         this.UIComponentsHintOnOut(param1,param2 as TInventory);
         this.FEquipment = null;
         this.ResetBtn();
         this.UpdateEquipmentSlot();
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:TInventory) : void
      {
         if(this.FOnSlotMouseOver != null)
         {
            this.FOnSlotMouseOver(param1,param2);
         }
      }
      
      protected function UIComponentsHintOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnSlotMouseOut != null)
         {
            this.FOnSlotMouseOut(param1,param2);
         }
      }
      
      public function set PunchNetwork(param1:Function) : void
      {
         this.FPunchNetwork = param1;
      }
      
      public function set OnSlotMouseOver(param1:Function) : void
      {
         this.FOnSlotMouseOver = param1;
      }
      
      public function set OnSlotMouseOut(param1:Function) : void
      {
         this.FOnSlotMouseOut = param1;
      }
      
      public function set StrengthenResult(param1:uint) : void
      {
         this.FStrengthenResult = param1;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function Update() : void
      {
         var _loc1_:THero = null;
         switch(this.FCurrentState)
         {
            case STATE_READY:
               break;
            case STATE_PUNCH:
               if(this.FStrengthenResult == 0)
               {
                  EffectGenerateText(STRING_SMITHY.STRING_PUNCH_SUCCESS);
               }
               this.FCurrentState = STATE_READY;
               if(this.FEquipment != null)
               {
                  this.FEquipment.ExpandHoleCount += 1;
                  this.UIComponentsHintOnOut(this,this.FEquipment);
               }
               _loc1_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(this.FHeroID);
               if(_loc1_ != null)
               {
                  this.FEquipment.SuitCount = _loc1_.GetSuitCountByEquipment(this.FEquipment);
               }
               if(this.FEquipment.ExpandHoleCount >= this.FEquipment.DigHoleNum)
               {
                  EffectGenerateText(STRING_SMITHY.STRING_MAXHOLE);
                  this.OnSlotClick();
               }
               this.UpdateEquipmentSlot();
         }
      }
      
      public function Reset() : void
      {
         this.ResetEquipmentSlot();
         this.ResetBtn();
      }
      
      public function set BackReset(param1:Function) : void
      {
         this.FBackReset = param1;
      }
      
      public function ReciveEquipment(param1:TEquipment, param2:uint) : void
      {
         this.FHeroID |= param2;
         if(param1.ExpandHoleCount >= param1.DigHoleNum)
         {
            EffectGenerateText(STRING_SMITHY.STRING_MAXHOLE);
            return;
         }
         this.SendEquipment(param1);
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         if(this.FEquipmentSlot != null && param1)
         {
            this.OnSlotClick(this.FEquipmentSlot,this.FEquipmentSlot.Context);
         }
         super.Visible = param1;
      }
   }
}

