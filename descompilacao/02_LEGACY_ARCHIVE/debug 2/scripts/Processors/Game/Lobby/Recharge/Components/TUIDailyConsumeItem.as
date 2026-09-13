package Processors.Game.Lobby.Recharge.Components
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.ActivityMode.TActivityAtom;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_RECHARGE;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextField;
   
   public class TUIDailyConsumeItem extends TUIComponent
   {
      
      protected var FMC_DailyConsume:MovieClip;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_BuyCount:TextField;
      
      protected var FTF_BuyAction:TextField;
      
      protected var FBTN_GetReward:MovieClip;
      
      protected var FMC_HasRecieved:MovieClip;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FActivityAtom:TActivityAtom;
      
      protected var FResource:MovieClip;
      
      protected var FOnGoto:Function;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FOnGetReward:Function;
      
      public function TUIDailyConsumeItem(param1:TUIComponent)
      {
         super(param1);
         this.FSlotList = new Vector.<TUISlot>(3);
      }
      
      protected function UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         this.FMC_DailyConsume = this.FResource;
         this.FTF_Name = this.FMC_DailyConsume[CONST_RECHARGE.RESOURCE_Link_TF_Name];
         this.FTF_BuyCount = this.FMC_DailyConsume[CONST_RECHARGE.RESOURCE_Link_TF_BuyCount];
         this.FTF_BuyAction = this.FMC_DailyConsume[CONST_RECHARGE.RESOURCE_Link_TF_BuyAction];
         this.FTF_BuyAction.selectable = false;
         this.FBTN_GetReward = this.FMC_DailyConsume[CONST_RECHARGE.RESOURCE_Link_BTN_GetReward];
         this.FMC_HasRecieved = this.FMC_DailyConsume[CONST_RECHARGE.RESOURCE_Link_MC_HasRecieved];
         _loc2_ = this.FSlotList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_DailyConsume[CONST_RECHARGE.RESOURCE_Link_MC_Slot + _loc1_] as Sprite;
            _loc3_.Resource.visible = false;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.OnQuerySequenceContext = this.ProcessorOnQuerySequenceContext;
            _loc3_.OnOverlay = this.ProcessorOnOverlay;
            _loc3_.OnOut = this.ProcessorOnOut;
            _loc3_.OnQuerySubscript = this.ProcessorOnQuerySubscript;
            _loc3_.Init();
            this.FSlotList[_loc1_] = _loc3_;
            _loc1_++;
         }
      }
      
      protected function UILocations() : void
      {
         this.FBTN_GetReward.addEventListener(MouseEvent.CLICK,this.ButtonGetRewardOnClick,false,0,true);
         this.FTF_BuyAction.addEventListener(TextEvent.LINK,this.GotoOnClick,false,0,true);
      }
      
      protected function UpdateItemInfo(param1:String, param2:uint) : void
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:TInventory = null;
         this.FTF_Name.text = this.FActivityAtom.Tips[0];
         this.FTF_BuyCount.text = SLogicsCore.CounterLimit.GetValue(param2) + "/" + (this.FActivityAtom.ConditionValue[0] as uint);
         this.FTF_BuyAction.htmlText = "<u><a href=\"event:二逼网址http://www.baidu.com\">" + param1 + "</a></u>";
         _loc4_ = this.FSlotList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(_loc3_ >= this.FActivityAtom.InventoriesVect[0].Count)
            {
               break;
            }
            _loc6_ = this.FActivityAtom.InventoriesVect[0].GetInventoryByIndex(_loc3_);
            if(_loc6_ != null)
            {
               this.FSlotList[_loc3_].Resource.visible = true;
               this.FSlotList[_loc3_].Context = _loc6_;
            }
            _loc3_++;
         }
         _loc5_ = this.FActivityAtom.ActiveStatus;
         if(_loc5_ == -1)
         {
            this.FMC_HasRecieved.visible = true;
            this.FBTN_GetReward.visible = false;
         }
         else if(_loc5_ == 0)
         {
            TGameUtil.setButtonMode(this.FBTN_GetReward,false);
            this.FBTN_GetReward.mouseEnabled = false;
            this.FBTN_GetReward.visible = true;
            this.FMC_HasRecieved.visible = false;
         }
         else
         {
            TGameUtil.setButtonMode(this.FBTN_GetReward,true);
            this.FBTN_GetReward.mouseEnabled = true;
            this.FBTN_GetReward.visible = true;
            this.FMC_HasRecieved.visible = false;
         }
      }
      
      protected function GotoOnClick(param1:TextEvent) : void
      {
         if(this.FOnGoto != null)
         {
            this.FOnGoto(this);
         }
      }
      
      protected function ButtonGetRewardOnClick(param1:MouseEvent) : void
      {
         if(this.FOnGetReward != null)
         {
            this.FOnGetReward(this,this.FActivityAtom.Identifier);
         }
      }
      
      protected function ProcessorOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         if(this.FOnQuerySequenceContext != null)
         {
            this.FOnQuerySequenceContext(this,param2,param3,param4);
         }
      }
      
      protected function ProcessorOnOverlay(param1:Object, param2:Object) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(this,param2);
         }
      }
      
      protected function ProcessorOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(this,param2);
         }
      }
      
      protected function ProcessorOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         if(this.FOnQuerySubscript != null)
         {
            this.FOnQuerySubscript(this,param2,param3);
         }
      }
      
      public function get Resource() : MovieClip
      {
         return this.FResource;
      }
      
      public function set Resource(param1:MovieClip) : void
      {
         this.FResource = param1;
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
      
      public function get OnGoto() : Function
      {
         return this.FOnGoto;
      }
      
      public function set OnGoto(param1:Function) : void
      {
         this.FOnGoto = param1;
      }
      
      public function get OnGetReward() : Function
      {
         return this.FOnGetReward;
      }
      
      public function set OnGetReward(param1:Function) : void
      {
         this.FOnGetReward = param1;
      }
      
      public function Init() : void
      {
         this.UIDispatch();
         this.UILocations();
      }
      
      public function SetItemInfo(param1:String, param2:TActivityAtom, param3:uint) : void
      {
         this.FActivityAtom = param2;
         this.UpdateItemInfo(param1,param3);
      }
      
      public function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         _loc2_ = this.FSlotList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FSlotList[_loc1_];
            this.FSlotList[_loc1_].Update();
            _loc1_++;
         }
      }
   }
}

