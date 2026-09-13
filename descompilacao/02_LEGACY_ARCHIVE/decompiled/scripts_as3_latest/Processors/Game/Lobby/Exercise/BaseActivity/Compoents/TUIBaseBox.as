package Processors.Game.Lobby.Exercise.BaseActivity.Compoents
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
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIBaseBox extends TUIComponent
   {
      
      public static const NONE_FILTERS:int = 0;
      
      public static const GARY_COLOR_FILTERS:int = 1;
      
      public static const HIGH_LIGHT_FILTERS:int = 2;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBTN_Get:MovieClip;
      
      public var FMC_Got:MovieClip;
      
      protected var FMC_Tag:MovieClip;
      
      protected var FMC_CanGet:MovieClip;
      
      protected var FMC_Hook:MovieClip;
      
      protected var FBTN_Recharge:MovieClip;
      
      protected var FBTN_Renew:MovieClip;
      
      public var FBTN_Exchange:MovieClip;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FUIPage:TUIPage;
      
      protected var FInventories:TInventories;
      
      protected var FInitialized:Boolean;
      
      protected var FCurPage:int;
      
      protected var FTotalPage:int;
      
      protected var FBoxCount:int;
      
      protected var FTF_Price:TextField;
      
      protected var FTF_CurPrice:TextField;
      
      protected var FTF_Count:TextField;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Limit:TextField;
      
      protected var FTF_VipLv:TextField;
      
      protected var FMC_Buff:MovieClip;
      
      protected var FMC_TitleEffect:MovieClip;
      
      protected var FTitleAnimationID:uint;
      
      protected var FTitleBmp:Bitmap;
      
      protected var FMC_Tip:MovieClip;
      
      protected var FRewardIndex:int;
      
      public var FBoxIndex:int;
      
      public var BTN_Buy:MovieClip;
      
      public var MC_Bounght:MovieClip;
      
      protected var FIdentify:int;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FOnGetBox:Function;
      
      protected var FOnBtnOver:Function;
      
      protected var FOnBtnOut:Function;
      
      protected var FOnBuyBox:Function;
      
      protected var FOnBuyOver:Function;
      
      protected var FOnBuyOut:Function;
      
      protected var FTitleHintOnOver:Function;
      
      protected var FTitleHintOnOut:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FOnClick:Function;
      
      protected var FOnExchangeUp:Function;
      
      protected var FOnExchangeOver:Function;
      
      protected var FOnExchangeOut:Function;
      
      public function TUIBaseBox(param1:TUIComponent, param2:int)
      {
         super(param1);
         this.FBoxCount = param2;
         this.FSlotList = new Vector.<TUISlot>(this.FBoxCount);
         this.FUIPage = new TUIPage(this);
         this.FTitleBmp = new Bitmap();
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         this.FBTN_Get = this.FMC_Scene.BTN_Get;
         if(this.FBTN_Get)
         {
            TGameUtil.setButtonMode(this.FBTN_Get,true);
            this.FBTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBox);
            this.FBTN_Get.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBtnOver);
            this.FBTN_Get.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBtnOut);
         }
         this.BTN_Buy = this.FMC_Scene.BTN_Buy;
         if(this.BTN_Buy)
         {
            TGameUtil.setButtonMode(this.BTN_Buy,true);
            this.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyBox);
            this.BTN_Buy.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBuyOver);
            this.BTN_Buy.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBuyOut);
         }
         this.FBTN_Exchange = this.FMC_Scene.BTN_Exchange;
         if(this.FBTN_Exchange)
         {
            TGameUtil.setButtonMode(this.FBTN_Exchange,true);
            this.FBTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
            this.FBTN_Exchange.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnExchangeOver);
            this.FBTN_Exchange.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnExchangeOut);
         }
         this.MC_Bounght = this.FMC_Scene.MC_Bought;
         if(Boolean(this.FMC_Scene.Btn_Right) && Boolean(this.FMC_Scene.Btn_Left))
         {
            this.FUIPage.ButtonPrevious.Substrate = this.FMC_Scene.Btn_Left;
            this.FUIPage.ButtonNext.Substrate = this.FMC_Scene.Btn_Right;
            if(this.FMC_Scene.TF_Page)
            {
               this.FUIPage.LabelPage = this.FMC_Scene.TF_Page;
            }
            this.FUIPage.TotalQuantity = this.FTotalPage;
            this.FUIPage.PageSize = this.FBoxCount;
            this.FUIPage.PageIndex = 0;
            this.FCurPage = 0;
            this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         }
         this.FMC_Got = this.FMC_Scene.MC_Got;
         this.FMC_CanGet = this.FMC_Scene.MC_CanGet;
         this.FMC_Tag = this.FMC_Scene.MC_Tag0;
         this.FTF_Price = this.FMC_Scene.TF_Price;
         this.FTF_CurPrice = this.FMC_Scene.TF_CurPrice;
         this.FTF_Count = this.FMC_Scene.TF_Count;
         this.FTF_Name = this.FMC_Scene.TF_Name;
         this.FTF_Limit = this.FMC_Scene.TF_Limit;
         this.FBTN_Recharge = this.FMC_Scene.BTN_Recharge;
         this.FBTN_Renew = this.FMC_Scene.BTN_Renew;
         this.FMC_Buff = this.FMC_Scene.MC_Buff;
         this.FMC_Tip = this.FMC_Scene.MC_Tip;
         if(this.FMC_Tip)
         {
            this.FMC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorTipOnOver);
            this.FMC_Tip.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorTipOnOut);
         }
         this.FMC_TitleEffect = this.FMC_Scene.MC_TitleEffect;
         if(this.FMC_TitleEffect)
         {
            this.FMC_TitleEffect.addChild(this.FTitleBmp);
            this.FMC_TitleEffect.addEventListener(MouseEvent.MOUSE_MOVE,this.MCTitleEffectOnOver);
            this.FMC_TitleEffect.addEventListener(MouseEvent.ROLL_OUT,this.MCTitleEffectOnOut);
         }
         if(this.FMC_Scene.MC_Fire)
         {
            this.FMC_Scene.MC_Fire.mouseEnabled = false;
         }
         this.Resources_UIDispatchBox();
      }
      
      protected function Resources_UIDispatchBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         _loc1_ = 0;
         while(_loc1_ < this.FBoxCount)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_Scene["MC_Slot" + _loc1_] as Sprite;
            _loc3_.Resource.visible = false;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.OnOverlay = this.SlotsOnOver;
            _loc3_.OnOut = this.SlotsOnOut;
            _loc3_.OnClick = this.SlotsOnClick;
            _loc3_.BoxIndex = _loc1_;
            _loc3_.Init();
            this.FSlotList[_loc1_] = _loc3_;
            _loc1_++;
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         _loc1_ = 0;
         while(_loc1_ < this.FBoxCount)
         {
            _loc2_ = _loc1_ + this.FCurPage * this.FBoxCount;
            if(Boolean(this.FInventories) && _loc2_ < this.FInventories.Count)
            {
               _loc3_ = this.FInventories.GetInventoryByIndex(_loc2_);
               if(_loc3_ == null)
               {
               }
               this.FSlotList[_loc1_].Context = null;
               this.FSlotList[_loc1_].Context = _loc3_;
               this.FSlotList[_loc1_].Resource.visible = true;
            }
            else
            {
               this.FSlotList[_loc1_].Context = null;
               this.FSlotList[_loc1_].Resource.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateBox();
      }
      
      protected function ProcessorOnGetBox(param1:MouseEvent) : void
      {
         if(this.FOnGetBox != null)
         {
            this.FOnGetBox(param1);
         }
      }
      
      protected function ProcessorOnBuyBox(param1:MouseEvent) : void
      {
         if(this.FOnBuyBox != null)
         {
            this.FOnBuyBox(param1);
         }
      }
      
      protected function ProcessorOnBtnOver(param1:MouseEvent) : void
      {
         if(this.FOnBtnOver != null)
         {
            this.FOnBtnOver(param1);
         }
      }
      
      protected function ProcessorOnBtnOut(param1:MouseEvent) : void
      {
         if(this.FOnBtnOut != null)
         {
            this.FOnBtnOut(param1);
         }
      }
      
      protected function ProcessorOnBuyOver(param1:MouseEvent) : void
      {
         if(this.FOnBuyOver != null)
         {
            this.FOnBuyOver(param1);
         }
      }
      
      protected function ProcessorOnBuyOut(param1:MouseEvent) : void
      {
         if(this.FOnBuyOut != null)
         {
            this.FOnBuyOut(param1);
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         if(this.FOnExchangeUp != null)
         {
            this.FOnExchangeUp(param1,this.FIdentify);
         }
      }
      
      protected function ProcessorOnExchangeOver(param1:MouseEvent) : void
      {
         if(this.FOnExchangeOver != null)
         {
            this.FOnExchangeOver(this.FIdentify);
         }
      }
      
      protected function ProcessorOnExchangeOut(param1:MouseEvent) : void
      {
         if(this.FOnExchangeOut != null)
         {
            this.FOnExchangeOut(this.FIdentify);
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
         this.FBoxIndex = param1.BoxIndex;
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
      
      protected function SlotsOnClick(param1:Object, param2:Object) : void
      {
         if(this.FOnClick != null)
         {
            this.FOnClick(this,param2);
         }
      }
      
      protected function MCTitleEffectOnOver(param1:MouseEvent) : void
      {
         if(this.FTitleHintOnOver != null)
         {
            this.FTitleHintOnOver(this.FTitleAnimationID);
         }
      }
      
      protected function MCTitleEffectOnOut(param1:MouseEvent) : void
      {
         if(this.FTitleHintOnOut != null)
         {
            this.FTitleHintOnOut();
         }
      }
      
      protected function ProcessorTipOnOver(param1:MouseEvent) : void
      {
         if(this.FTipOnOver != null)
         {
            this.FTipOnOver(param1);
         }
      }
      
      protected function ProcessorTipOnOut(param1:MouseEvent) : void
      {
         if(this.FTipOnOut != null)
         {
            this.FTipOnOut();
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
      
      public function get OnGetBox() : Function
      {
         return this.FOnGetBox;
      }
      
      public function set OnGetBox(param1:Function) : void
      {
         this.FOnGetBox = param1;
      }
      
      public function get OnBtnOver() : Function
      {
         return this.FOnBtnOver;
      }
      
      public function set OnBtnOver(param1:Function) : void
      {
         this.FOnBtnOver = param1;
      }
      
      public function get OnBtnOut() : Function
      {
         return this.FOnBtnOut;
      }
      
      public function set OnBtnOut(param1:Function) : void
      {
         this.FOnBtnOut = param1;
      }
      
      public function get MC_Tag() : MovieClip
      {
         return this.FMC_Tag;
      }
      
      public function set MC_Tag(param1:MovieClip) : void
      {
         this.FMC_Tag = param1;
      }
      
      public function get TitleHintOnOver() : Function
      {
         return this.FTitleHintOnOver;
      }
      
      public function set TitleHintOnOver(param1:Function) : void
      {
         this.FTitleHintOnOver = param1;
      }
      
      public function get TitleHintOnOut() : Function
      {
         return this.FTitleHintOnOut;
      }
      
      public function set TitleHintOnOut(param1:Function) : void
      {
         this.FTitleHintOnOut = param1;
      }
      
      public function get Tip() : MovieClip
      {
         return this.FMC_Tip;
      }
      
      public function set Tip(param1:MovieClip) : void
      {
         this.FMC_Tip = param1;
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
      
      public function get OnBuyBox() : Function
      {
         return this.FOnBuyBox;
      }
      
      public function set OnBuyBox(param1:Function) : void
      {
         this.FOnBuyBox = param1;
      }
      
      public function get OnBuyOver() : Function
      {
         return this.FOnBuyOver;
      }
      
      public function set OnBuyOver(param1:Function) : void
      {
         this.FOnBuyOver = param1;
      }
      
      public function get OnBuyOut() : Function
      {
         return this.FOnBuyOut;
      }
      
      public function set OnBuyOut(param1:Function) : void
      {
         this.FOnBuyOut = param1;
      }
      
      public function get BTN_Get() : MovieClip
      {
         return this.FBTN_Get;
      }
      
      public function set BTN_Get(param1:MovieClip) : void
      {
         this.FBTN_Get = param1;
      }
      
      public function get MC_Got() : MovieClip
      {
         return this.FMC_Got;
      }
      
      public function set MC_Got(param1:MovieClip) : void
      {
         this.FMC_Got = param1;
      }
      
      public function get MC_Scene() : MovieClip
      {
         return this.FMC_Scene;
      }
      
      public function set MC_Scene(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
      }
      
      public function get OnClick() : Function
      {
         return this.FOnClick;
      }
      
      public function set OnClick(param1:Function) : void
      {
         this.FOnClick = param1;
      }
      
      public function get RewardIndex() : int
      {
         return this.FRewardIndex;
      }
      
      public function set RewardIndex(param1:int) : void
      {
         this.FRewardIndex = param1;
      }
      
      public function get Identify() : int
      {
         return this.FIdentify;
      }
      
      public function set Identify(param1:int) : void
      {
         this.FIdentify = param1;
      }
      
      public function get OnExchangeOver() : Function
      {
         return this.FOnExchangeOver;
      }
      
      public function set OnExchangeOver(param1:Function) : void
      {
         this.FOnExchangeOver = param1;
      }
      
      public function get OnExchangeOut() : Function
      {
         return this.FOnExchangeOut;
      }
      
      public function set OnExchangeOut(param1:Function) : void
      {
         this.FOnExchangeOut = param1;
      }
      
      public function get OnExchangeUp() : Function
      {
         return this.FOnExchangeUp;
      }
      
      public function set OnExchangeUp(param1:Function) : void
      {
         this.FOnExchangeUp = param1;
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
         if(this.FInitialized && this.visible)
         {
            _loc2_ = this.FSlotList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FSlotList[_loc1_].Update();
               _loc1_++;
            }
            this.UpdateTitleEffect(this.FTitleAnimationID);
         }
      }
      
      public function UpdateUI(param1:TInventories) : void
      {
         this.FInventories = param1;
         if(Boolean(this.FMC_Scene.Btn_Right) && Boolean(this.FMC_Scene.Btn_Left))
         {
            this.FUIPage.TotalQuantity = this.FInventories.Count;
            this.FUIPage.Update();
         }
         this.UpdateBox();
      }
      
      public function SetBtnMode(param1:Boolean) : void
      {
         TGameUtil.setButtonMode(this.FBTN_Get,param1);
      }
      
      public function SetExchangeBtnMode(param1:Boolean) : void
      {
         TGameUtil.setButtonMode(this.FBTN_Exchange,param1);
      }
      
      public function SetPriceText(param1:String) : void
      {
         if(this.FTF_Price)
         {
            this.FTF_Price.text = param1;
         }
      }
      
      public function SetCurPriceText(param1:String) : void
      {
         if(this.FTF_CurPrice)
         {
            this.FTF_CurPrice.text = param1;
         }
      }
      
      public function SetCountText(param1:String) : void
      {
         if(this.FTF_Count)
         {
            this.FTF_Count.text = param1;
         }
      }
      
      public function SetLimitText(param1:String) : void
      {
         if(this.FTF_Limit)
         {
            this.FTF_Limit.text = param1;
         }
      }
      
      public function SetNameText(param1:String) : void
      {
         if(this.FTF_Name)
         {
            this.FTF_Name.text = param1;
         }
      }
      
      public function SetBuff(param1:Boolean = true, param2:String = "") : void
      {
         if(this.FMC_Buff)
         {
            this.FMC_Buff.visible = param1;
            this.FMC_Buff.TF_Buff.text = param2;
         }
      }
      
      public function IsBoxGot(param1:Boolean) : void
      {
         if(this.FMC_Got)
         {
            this.FMC_Got.visible = param1;
         }
         if(this.FBTN_Get)
         {
            this.FBTN_Get.visible = !param1;
         }
      }
      
      public function UpdateTag(param1:int) : void
      {
         if(this.FMC_Tag)
         {
            this.FMC_Tag.gotoAndStop(param1 + 1);
         }
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         this.FMC_Scene.visible = param1;
      }
      
      public function SetDescText(param1:int, param2:String) : void
      {
         if(this.FMC_Scene["TF_Desc" + param1])
         {
            this.FMC_Scene["TF_Desc" + param1].text = param2;
         }
      }
      
      public function UpdateTitleEffect(param1:int = 0) : void
      {
         this.FTitleAnimationID = param1;
         if(Boolean(this.FMC_TitleEffect) && this.FTitleAnimationID != 0)
         {
            TGameUtil.ShowAnimationByID(TGameUtil.Type_UserTitle,this.FTitleBmp,CONST_MODULES.ACTIVE_Test,param1);
            this.FMC_TitleEffect.x = 103 + (165 - this.FMC_TitleEffect.width) / 2;
         }
         else
         {
            TGameUtil.ShowAnimationByID(TGameUtil.Type_UserTitle,this.FTitleBmp,CONST_MODULES.ACTIVE_Test,0);
         }
      }
      
      public function SetFrame(param1:int) : void
      {
         this.FMC_Scene.gotoAndStop(param1);
      }
      
      public function SetHighLightFilters(param1:Boolean) : void
      {
         if(param1)
         {
            this.FMC_Scene.filters = [TGameUtil.highLightFilters];
         }
         else
         {
            this.FMC_Scene.filters = [];
         }
      }
      
      public function SetGaryFilters(param1:Boolean) : void
      {
         if(param1)
         {
            this.FMC_Scene.filters = [TGameUtil.GaryColorFilters];
         }
         else
         {
            this.FMC_Scene.filters = [];
         }
      }
      
      public function SetSlotFiltersByIndex(param1:int, param2:int) : void
      {
         switch(param2)
         {
            case NONE_FILTERS:
               this.FSlotList[param1].SetHighLightFilters(false);
               break;
            case HIGH_LIGHT_FILTERS:
               this.FSlotList[param1].SetHighLightFilters(true);
               break;
            case GARY_COLOR_FILTERS:
               this.FSlotList[param1].SetGaryFilters(true);
         }
      }
      
      public function SetMCIsVisible(param1:String, param2:Boolean) : void
      {
         switch(param1)
         {
            case "MC_Fire":
               if(this.FMC_Scene.MC_Fire)
               {
                  this.FMC_Scene.MC_Fire.visible = param2;
               }
               break;
            case "MC_Effect":
               if(this.FMC_Scene.MC_Effect)
               {
                  this.FMC_Scene.MC_Effect.visible = param2;
               }
               break;
            case "MC_Got":
               if(this.FMC_Scene.MC_Got)
               {
                  this.FMC_Scene.MC_Got.visible = param2;
               }
               break;
            case "BTN_Get":
               if(this.FBTN_Get)
               {
                  this.FBTN_Get.visible = param2;
               }
               break;
            case "BTN_Buy":
               if(this.BTN_Buy)
               {
                  this.BTN_Buy.visible = param2;
               }
               break;
            case "MC_CanGet":
               if(this.FMC_CanGet)
               {
                  this.FMC_CanGet.visible = param2;
               }
               break;
            case "BTN_Recharge":
               if(this.FBTN_Recharge)
               {
                  this.FBTN_Recharge.visible = param2;
               }
               break;
            case "BTN_Renew":
               if(this.FBTN_Renew)
               {
                  this.FBTN_Renew.visible = param2;
               }
               break;
            case "MC_Lock":
               if(this.FMC_Scene.MC_Lock)
               {
                  this.FMC_Scene.MC_Lock.visible = param2;
               }
               break;
            case "MC_Hot":
               if(this.FMC_Scene.MC_Hot)
               {
                  this.FMC_Scene.MC_Hot.visible = param2;
               }
               break;
            case "BTN_Exchange":
               if(this.FMC_Scene.BTN_Exchange)
               {
                  this.FMC_Scene.BTN_Exchange.visible = param2;
               }
         }
      }
      
      public function SetMCIsMouseEnabled(param1:String, param2:Boolean) : void
      {
         switch(param1)
         {
            case "MC_Fire":
               if(this.FMC_Scene.MC_Fire)
               {
                  this.FMC_Scene.MC_Fire.visible = param2;
               }
               break;
            case "MC_Effect":
               if(this.FMC_Scene.MC_Effect)
               {
                  this.FMC_Scene.MC_Effect.mouseEnabled = param2;
               }
               break;
            case "MC_Got":
               if(this.FMC_Scene.MC_Got)
               {
                  this.FMC_Scene.MC_Got.mouseEnabled = param2;
               }
         }
      }
      
      public function SetMovieClipStatus(param1:String, param2:Boolean) : void
      {
         var _loc3_:MovieClip = null;
         switch(param1)
         {
            case "BTN_Get":
               if(this.FBTN_Get)
               {
                  _loc3_ = this.FBTN_Get;
               }
         }
         if(_loc3_)
         {
            TGameUtil.setButtonMode(_loc3_,param2);
            _loc3_.mouseEnabled = param2;
         }
      }
      
      public function SetSlotVisible(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.FSlotList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FSlotList[_loc2_].Resource.visible = param1;
            _loc2_++;
         }
      }
      
      public function SetBtnText(param1:String, param2:String) : void
      {
         var _loc3_:MovieClip = null;
         switch(param1)
         {
            case "BTN_Get":
               if(this.FBTN_Get)
               {
                  _loc3_ = this.FBTN_Get;
               }
         }
         if(Boolean(_loc3_) && Boolean(_loc3_["TF_Name"]))
         {
            _loc3_["TF_Name"].text = param2;
         }
      }
      
      public function SetFire(param1:Vector.<int>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         _loc3_ = int(param1.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FMC_Scene["MC_Slot" + _loc2_].MC_Fire;
            if(_loc4_)
            {
               if(param1[_loc2_] > 0)
               {
                  _loc4_.visible = true;
                  _loc4_.gotoAndStop(param1[_loc2_]);
               }
               else
               {
                  _loc4_.visible = false;
               }
            }
            _loc2_++;
         }
      }
      
      public function SetSelected(param1:Boolean = false, param2:int = -1) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         _loc3_ = 0;
         while(_loc3_ < this.FBoxCount)
         {
            _loc5_ = this.FMC_Scene["MC_Slot" + _loc3_].MC_Selected;
            if(_loc5_)
            {
               _loc5_.visible = param1;
            }
            _loc3_++;
         }
         if(param2 != -1)
         {
            this.FMC_Scene["MC_Slot" + param2].MC_Selected.visible = true;
         }
      }
      
      public function SetGetCount(param1:Boolean = false, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         _loc4_ = 0;
         while(_loc4_ < this.FBoxCount)
         {
            _loc6_ = this.FMC_Scene["MC_Slot" + _loc4_].MC_Get;
            if(_loc6_)
            {
               _loc6_.visible = param1;
            }
            _loc4_++;
         }
         if(param3 != 0)
         {
            this.FMC_Scene["MC_Slot" + param2].MC_Get.visible = true;
            this.FMC_Scene["MC_Slot" + param2].MC_Get.TF_Count.text = param3.toString();
         }
      }
      
      public function SetBoxShine(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         _loc2_ = 0;
         while(_loc2_ < this.FBoxCount)
         {
            _loc4_ = this.FMC_Scene["MC_Slot" + _loc2_];
            if(_loc4_)
            {
               if(_loc2_ % 2 == param1)
               {
                  _loc4_.MC_Selected.visible = true;
               }
               else
               {
                  _loc4_.MC_Selected.visible = false;
               }
            }
            _loc2_++;
         }
      }
      
      public function SetGetCountByList(param1:Vector.<int>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FBoxCount)
         {
            _loc4_ = this.FMC_Scene["MC_Slot" + _loc2_].MC_Get;
            if(_loc4_)
            {
               _loc5_ = this.GetCountByIndex(param1,_loc2_);
               if(_loc5_ > 0)
               {
                  _loc4_.visible = true;
                  _loc4_.TF_Count.text = _loc5_.toString();
               }
               else
               {
                  _loc4_.visible = false;
               }
            }
            _loc2_++;
         }
      }
      
      public function GetCountByIndex(param1:Vector.<int>, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param2 == param1[_loc3_])
            {
               _loc4_++;
            }
            _loc3_++;
         }
         return _loc4_;
      }
   }
}

