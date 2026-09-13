package Processors.Game.Lobby.ActivityInner.Components
{
   import Components.Slots.TUISlot;
   import Foundation.Common.THint;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TInventory;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_ACTIVITYINNER;
   import Resources.Constants.CONST_COMMON;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TActivityReward extends TUIComponent
   {
      
      protected static var TEXT_FORMAT:TextFormat;
      
      protected static var GOLD_FORMAT:TextFormat;
      
      protected var FCount:uint;
      
      protected var FMC_RewardItem:MovieClip;
      
      protected var FBTN_GetReward:MovieClip;
      
      protected var FMC_Get:MovieClip;
      
      protected var FTF_RankText:TextField;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FOnGetReward:Function;
      
      protected var FIdentifier:uint;
      
      protected var FType:uint;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FHint:THint;
      
      public function TActivityReward(param1:TUIComponent, param2:int = 0, param3:int = 6)
      {
         super(param1);
         this.FCount = param3;
         this.FType = param2;
         this.FSlotList = new Vector.<TUISlot>(this.FCount);
         if(TEXT_FORMAT == null)
         {
            TEXT_FORMAT = new TextFormat();
            TEXT_FORMAT.underline = true;
            TEXT_FORMAT.kerning = false;
            TEXT_FORMAT.color = "0xFF00FF";
         }
         if(GOLD_FORMAT == null)
         {
            GOLD_FORMAT = new TextFormat();
            GOLD_FORMAT.kerning = false;
            GOLD_FORMAT.color = "0xFFFFFF00";
         }
         this.FHint = new THint();
      }
      
      protected function Initialization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         if(this.FType == 0)
         {
            this.FMC_RewardItem = TUtilityReflection.CreateDisplayObjectInstance(CONST_ACTIVITYINNER.RESOURCE_ClassName_MC_Reward) as MovieClip;
            this.FMC_RewardItem["MC_Tip"].addEventListener(MouseEvent.MOUSE_MOVE,this.TXT_OnMove,false,0,true);
            this.FMC_RewardItem["MC_Tip"].addEventListener(MouseEvent.MOUSE_OUT,this.TXT_OnOut,false,0,true);
         }
         else if(this.FType == 1)
         {
            this.FMC_RewardItem = TUtilityReflection.CreateDisplayObjectInstance(CONST_ACTIVITYINNER.RESOURCE_ClassName_MC_SingleItem) as MovieClip;
         }
         else if(this.FType == 2)
         {
            this.FMC_RewardItem = TUtilityReflection.CreateDisplayObjectInstance(CONST_ACTIVITYINNER.RESOURCE_ClassName_MC_PetRank) as MovieClip;
            this.FTF_RankText = this.FMC_RewardItem["TF_Text"];
         }
         addChild(this.FMC_RewardItem);
         this.FBTN_GetReward = this.FMC_RewardItem[CONST_ACTIVITYINNER.RESOURCE_Link_BTN_GetReward];
         if(this.FBTN_GetReward != null)
         {
            TGameUtil.setButtonMode(this.FBTN_GetReward,true);
            this.FBTN_GetReward.mouseEnabled = true;
         }
         _loc2_ = this.FCount;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_RewardItem[CONST_ACTIVITYINNER.RESOURCE_Link_MC_Slot + _loc1_] as Sprite;
            _loc3_.Resource.visible = false;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.OnQuerySequenceContext = this.FOnQuerySequenceContext;
            _loc3_.OnOverlay = this.FOnOverlay;
            _loc3_.OnOut = this.FOnOut;
            _loc3_.OnQuerySubscript = this.FOnQuerySubscript;
            _loc3_.Init();
            this.FSlotList[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.FMC_Get = this.FMC_RewardItem[CONST_ACTIVITYINNER.RESOURCE_Link_MC_Get];
         if(this.FMC_Get != null)
         {
            this.FMC_Get.visible = false;
         }
         this.FOverlayerHint = new TOverlayerHint(this);
         this.FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         this.UILocations();
      }
      
      protected function UILocations() : void
      {
         if(this.FBTN_GetReward != null)
         {
            this.FBTN_GetReward.addEventListener(MouseEvent.CLICK,this.ButtonGetRewardOnClick,false,0,true);
         }
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      protected function UIComponentsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHint.Hide();
      }
      
      protected function ButtonGetRewardOnClick(param1:MouseEvent) : void
      {
         if(this.FOnGetReward != null)
         {
            this.FOnGetReward(this,this.FIdentifier);
         }
      }
      
      protected function TXT_OnMove(param1:MouseEvent) : void
      {
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(param1,this.FHint);
         }
      }
      
      protected function TXT_OnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(param1);
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
      
      public function get Identifier() : uint
      {
         return this.FIdentifier;
      }
      
      public function set Identifier(param1:uint) : void
      {
         this.FIdentifier = param1;
      }
      
      public function get OnGetReward() : Function
      {
         return this.FOnGetReward;
      }
      
      public function set OnGetReward(param1:Function) : void
      {
         this.FOnGetReward = param1;
      }
      
      public function get RewardItem() : MovieClip
      {
         return this.FMC_RewardItem;
      }
      
      public function set RewardItem(param1:MovieClip) : void
      {
         this.FMC_RewardItem = param1;
      }
      
      public function get HintOnMove() : Function
      {
         return this.FHintOnMove;
      }
      
      public function set HintOnMove(param1:Function) : void
      {
         this.FHintOnMove = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function Init() : void
      {
         this.Initialization();
      }
      
      public function SetItemInfo(param1:uint, param2:TInventory) : void
      {
         this.FSlotList[param1].Context = param2;
         this.FSlotList[param1].Resource.visible = true;
      }
      
      public function SetText(param1:String, param2:String, param3:String) : void
      {
         this.FMC_RewardItem["TF_Text_0"].text = param1;
         this.FMC_RewardItem["TF_Text_1"].text = param2;
         this.FMC_RewardItem["TF_Text_2"].text = param3;
      }
      
      public function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = this.FSlotList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FSlotList[_loc1_].Update();
            _loc1_++;
         }
      }
      
      public function SetBt(param1:int) : void
      {
         if(param1 == -1)
         {
            if(this.FType == 0)
            {
               if(this.FMC_Get != null)
               {
                  this.FMC_Get.gotoAndStop(this.FMC_Get.totalFrames);
               }
            }
            if(this.FMC_Get != null)
            {
               this.FMC_Get.visible = true;
            }
            if(this.FBTN_GetReward != null)
            {
               this.FBTN_GetReward.visible = false;
               TGameUtil.setButtonMode(this.FBTN_GetReward,false);
            }
         }
         else if(param1 == 0)
         {
            if(this.FMC_Get != null)
            {
               this.FMC_Get.visible = false;
            }
            if(this.FBTN_GetReward != null)
            {
               this.FBTN_GetReward.visible = true;
               this.FBTN_GetReward.mouseEnabled = false;
               TGameUtil.setButtonMode(this.FBTN_GetReward,false);
            }
         }
         else if(param1 >= 1)
         {
            if(this.FMC_Get != null)
            {
               this.FMC_Get.visible = false;
            }
            if(this.FBTN_GetReward != null)
            {
               this.FBTN_GetReward.visible = true;
               this.FBTN_GetReward.mouseEnabled = true;
               TGameUtil.setButtonMode(this.FBTN_GetReward,true);
            }
         }
      }
      
      public function SetTextFormat(param1:int, param2:int = 0) : void
      {
         if(param2 == 0)
         {
            this.FMC_RewardItem["TF_Text_" + param1].setTextFormat(TEXT_FORMAT);
            this.FMC_RewardItem["MC_Tip"].buttonMode = true;
            this.FMC_RewardItem["MC_Tip"].mouseChildren = false;
         }
         else
         {
            this.FMC_RewardItem["TF_Text_" + param1].setTextFormat(GOLD_FORMAT);
         }
      }
      
      public function setTipStr(param1:String) : void
      {
         this.FHint.Caption = param1;
      }
      
      public function setFinish() : void
      {
         if(this.FMC_Get != null)
         {
            this.FMC_Get.gotoAndStop(2);
            this.FMC_Get.visible = true;
         }
         if(this.FBTN_GetReward != null)
         {
            this.FBTN_GetReward.visible = false;
            TGameUtil.setButtonMode(this.FBTN_GetReward,false);
         }
      }
      
      public function HideBtn() : void
      {
         if(this.FBTN_GetReward != null)
         {
            this.FBTN_GetReward.visible = false;
         }
      }
      
      public function SetRankText(param1:String) : void
      {
         if(this.FTF_RankText != null)
         {
            this.FTF_RankText.text = param1;
         }
      }
   }
}

