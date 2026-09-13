package Processors.Game.Lobby.ActivityInner.Components
{
   import Components.Slots.TUISlot;
   import Foundation.Common.THint;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.ActivityMode.TActivityAtom;
   import Logics.ActivityMode.TActivityAtoms;
   import Logics.DatebaseVO.VO.TPetImage;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Rendering.Overlayers.Pet.TOverlayerPet;
   import Resources.Constants.CONST_DATEBASEVO;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TActivityNewRewardPsychicBeast extends TUIComponent
   {
      
      protected static var TEXT_FORMAT:TextFormat;
      
      protected static var GOLD_FORMAT:TextFormat;
      
      protected var FCount:uint;
      
      protected var FMC_RewardItem:MovieClip;
      
      protected var FBTN_GetReward:MovieClip;
      
      protected var FMC_Get:MovieClip;
      
      protected var FMC_Icon:MovieClip;
      
      protected var FTF_RankText:TextField;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FMC_Slot:TUISlot;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FOnGetReward:Function;
      
      protected var FIdentifier:uint;
      
      protected var FType:uint;
      
      protected var FOverlayerHint:TOverlayerPet;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FHint:THint;
      
      protected var FImageBin:TBins;
      
      private var FPetImageId:uint;
      
      private var FPetBitmap:Bitmap;
      
      protected var FPetImage:TPetImage;
      
      protected var IconIndex:int;
      
      protected var FActivityAtoms:TActivityAtoms;
      
      protected var FRewardList:Vector.<TActivityRewardPsychicBeast>;
      
      public function TActivityNewRewardPsychicBeast(param1:TUIComponent, param2:int)
      {
         super(param1);
         this.IconIndex = param2;
         this.FRewardList = new Vector.<TActivityRewardPsychicBeast>();
      }
      
      protected function Initialization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:TActivityRewardPsychicBeast = null;
         this.FMC_RewardItem = TUtilityReflection.CreateDisplayObjectInstance("MC_PsychicBeastItem") as MovieClip;
         addChild(this.FMC_RewardItem);
         this.FMC_Icon = this.FMC_RewardItem["MC_Icon"];
         this.FMC_Icon.gotoAndStop(this.IconIndex);
         this.FHint = new THint();
         this.FOverlayerHint = new TOverlayerPet(this.Parent.Parent);
         this.FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         _loc2_ = 3;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = new TActivityRewardPsychicBeast(this,_loc1_);
            _loc4_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc4_.OnOverlay = this.SlotOnOver;
            _loc4_.OnOut = this.SlotOnOut;
            _loc4_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc4_.OnGetReward = this.ProcessorOnGetReward;
            _loc4_.Init();
            _loc4_.x = this.FMC_Icon.width;
            _loc4_.y = _loc4_.height * _loc1_;
            addChild(_loc4_);
            this.FRewardList.push(_loc4_);
            _loc1_++;
         }
         this.UILocations();
      }
      
      private function IconOnOut(param1:MouseEvent) : void
      {
         this.FOverlayerHint.visible = false;
      }
      
      private function IconOnMove(param1:MouseEvent) : void
      {
         this.FHint.Caption = this.GetInformation(this.FPetImage.Desc);
         this.FOverlayerHint.Context = this.FHint;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.visible = true;
      }
      
      protected function GetInformation(param1:String) : String
      {
         var _loc2_:Array = null;
         _loc2_ = param1.split("\\n");
         return _loc2_[0] + "\n\n" + _loc2_[1] + "\n" + _loc2_[2];
      }
      
      protected function UILocations() : void
      {
         if(this.FBTN_GetReward != null)
         {
            this.FBTN_GetReward.addEventListener(MouseEvent.CLICK,this.ButtonGetRewardOnClick,false,0,true);
         }
         if(this.FMC_Icon != null)
         {
            this.FMC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.IconOnMove,false,0,true);
            this.FMC_Icon.addEventListener(MouseEvent.MOUSE_OUT,this.IconOnOut,false,0,true);
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
      
      public function get ActivityAtoms() : TActivityAtoms
      {
         return this.FActivityAtoms;
      }
      
      public function set ActivityAtoms(param1:TActivityAtoms) : void
      {
         this.FActivityAtoms = param1;
      }
      
      public function Init() : void
      {
         this.Initialization();
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
      
      public function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TActivityRewardPsychicBeast = null;
         var _loc4_:uint = 0;
         var _loc5_:TInventory = null;
         var _loc6_:TInventories = null;
         var _loc7_:TActivityAtom = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc12_:int = 0;
         _loc4_ = uint(int(this.FActivityAtoms.GetActivityAtomByIndex(0).ConditionValue[0]));
         this.FPetImage = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_PetImage,_loc4_ - _loc4_ % 100) as TPetImage;
         var _loc11_:int = 0;
         while(_loc11_ < this.FActivityAtoms.Count)
         {
            _loc7_ = this.FActivityAtoms.GetActivityAtomByIndex(_loc11_);
            _loc8_ = _loc7_.Tips[0];
            this.FRewardList[_loc11_].SetText(_loc8_);
            _loc6_ = _loc7_.InventoriesVect[0];
            _loc2_ = uint(_loc6_.Count);
            this.FRewardList[_loc11_].Identifier = _loc7_.Identifier;
            _loc12_ = 0;
            while(_loc12_ < _loc2_)
            {
               _loc5_ = _loc6_.GetInventoryByIndex(_loc12_);
               this.FRewardList[_loc11_].SetItemInfo(_loc12_,_loc5_);
               _loc12_++;
            }
            this.FRewardList[_loc11_].SetBt(_loc7_.ActiveStatus);
            _loc11_++;
         }
      }
      
      public function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = this.FRewardList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FRewardList[_loc1_].UpdateSlot();
            _loc1_++;
         }
      }
      
      private function ProcessorOnGetReward(param1:Object, param2:uint) : void
      {
         if(this.FOnGetReward != null)
         {
            this.FOnGetReward(param1,param2);
         }
      }
      
      private function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         if(this.FOnQuerySubscript != null)
         {
            this.FOnQuerySubscript(param1,param2,param3);
         }
      }
      
      private function SlotOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(param1,param2);
         }
      }
      
      private function SlotOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(param1,param2);
         }
      }
      
      private function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         if(this.FOnQuerySequenceContext != null)
         {
            this.FOnQuerySequenceContext(param1,param2,param3,param4);
         }
      }
   }
}

