package Processors.Game.Lobby.TheWorldTree.BigPanel
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TGodtreeDrop;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_ThreeWorldTree;
   import Resources.Strings.STRING_THEWORLDTREE;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TPViewLittlePanel extends Sprite
   {
      
      public static const FIVE:int = 6;
      
      protected var ThisPanel:Sprite;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      protected var FTempSelectInventoriesCount:Vector.<uint>;
      
      protected var FFiveSlot:Vector.<TUISlot> = null;
      
      protected var FMC_SureBtn:MovieClip;
      
      protected var FBTN_Left:MovieClip;
      
      protected var FBTN_Right:MovieClip;
      
      protected var FTF_LevelDec:TextField;
      
      protected var FTF_Reward_Dec:TextField;
      
      protected var FTF_GetRewardedIcon:MovieClip;
      
      protected var FMC_BoxPic:MovieClip;
      
      protected var FMC_SlotArea:MovieClip;
      
      protected var temp:TGodtreeDrop;
      
      protected var CurPageIndex:int;
      
      protected var FGetRewardBackFun:Function;
      
      protected var FBackBoxPicOut:Function;
      
      protected var FBackBoxPicOver:Function;
      
      protected var FBackBoxPicMove:Function;
      
      protected var FSlotBackOver:Function;
      
      protected var FSlotBackOut:Function;
      
      public function TPViewLittlePanel(param1:TUIComponent)
      {
         super();
         this.FFiveSlot = new Vector.<TUISlot>(FIVE);
         this.LoadPrimary();
         this.LoadFla(param1);
         this.FTempSelectInventoriesId = new Vector.<uint>();
         this.FSelectInventories = new TInventories();
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FTempSelectInventoriesCount = new Vector.<uint>();
      }
      
      protected function LoadPrimary() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_ThreeWorldTree.ResourceId);
      }
      
      protected function LoadFla(param1:TUIComponent) : void
      {
         this.ThisPanel = TUtilityReflection.CreateDisplayObjectInstance("TheWorldTree_OneReward") as Sprite;
         this.addChild(this.ThisPanel);
         this.Initilization(param1);
      }
      
      protected function Initilization(param1:TUIComponent) : void
      {
         var _loc2_:TUISlot = null;
         var _loc3_:int = 0;
         this.FTF_LevelDec = this.ThisPanel["TF_LevelDec"];
         this.FTF_Reward_Dec = this.ThisPanel["TF_Reward_Dec"];
         this.FTF_GetRewardedIcon = this.ThisPanel["TF_GetRewardedIcon"];
         this.FMC_BoxPic = this.ThisPanel["MC_BoxPic"];
         this.FMC_SlotArea = this.ThisPanel["MC_SlotArea"];
         this.FBTN_Left = this.FMC_SlotArea["BTN_Left"];
         this.FBTN_Right = this.FMC_SlotArea["BTN_Right"];
         this.FBTN_Left.visible = false;
         this.FBTN_Right.visible = false;
         _loc3_ = 0;
         while(_loc3_ < FIVE)
         {
            _loc2_ = new TUISlot(param1);
            _loc2_.Resource = this.FMC_SlotArea["MC_Slot_" + _loc3_];
            _loc2_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc2_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc2_.OnOverlay = this.SlotsOnOver;
            _loc2_.OnOut = this.SlotsOnOut;
            _loc2_.Init();
            this.FFiveSlot[_loc3_] = _loc2_;
            _loc3_++;
         }
         this.FMC_BoxPic.addEventListener(MouseEvent.CLICK,this.HandleClcik);
         this.FMC_BoxPic.addEventListener(MouseEvent.MOUSE_OVER,this.BoxPicOver);
         this.FMC_BoxPic.addEventListener(MouseEvent.MOUSE_OUT,this.BoxPicOut);
         this.FMC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.BoxPicMove);
      }
      
      public function set BackBoxPicOut(param1:Function) : void
      {
         this.FBackBoxPicOut = param1;
      }
      
      public function set BackBoxPicOver(param1:Function) : void
      {
         this.FBackBoxPicOver = param1;
      }
      
      public function set BackBoxPicMove(param1:Function) : void
      {
         this.FBackBoxPicMove = param1;
      }
      
      protected function BoxPicMove(param1:MouseEvent) : void
      {
         if(this.FBackBoxPicMove != null)
         {
            this.FBackBoxPicMove();
         }
      }
      
      protected function BoxPicOut(param1:MouseEvent) : void
      {
         if(this.FBackBoxPicOut != null)
         {
            this.FBackBoxPicOut();
         }
      }
      
      protected function BoxPicOver(param1:MouseEvent) : void
      {
         if(this.FBackBoxPicOver != null)
         {
            this.FBackBoxPicOver(this.temp);
         }
      }
      
      public function UpdateImage() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < FIVE)
         {
            this.FFiveSlot[_loc1_].Update();
            _loc1_++;
         }
      }
      
      public function UpdateView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < SLogicsCore.TheWorldTreeLogicData.CurGetGiftedId.length)
         {
            if(this.temp)
            {
               if(this.temp.GodtreeLevel == SLogicsCore.TheWorldTreeLogicData.CurGetGiftedId[_loc1_])
               {
                  _loc1_ = 100;
                  break;
               }
            }
            _loc1_++;
         }
         if(_loc1_ == 100)
         {
            this.FTF_GetRewardedIcon.visible = true;
            this.FMC_BoxPic.gotoAndStop(1);
            this.FMC_BoxPic.buttonMode = false;
            this.FMC_BoxPic.visible = false;
         }
         else if(SLogicsCore.TheWorldTreeLogicData.TheWorldTreeCurLevel < this.temp.GodtreeLevel)
         {
            this.FTF_GetRewardedIcon.visible = false;
            this.FMC_BoxPic.gotoAndStop(1);
            this.FMC_BoxPic.buttonMode = false;
            this.FMC_BoxPic.visible = true;
         }
         else
         {
            this.FTF_GetRewardedIcon.visible = false;
            this.FMC_BoxPic.gotoAndPlay(1);
            this.FMC_BoxPic.buttonMode = true;
            this.FMC_BoxPic.visible = true;
         }
      }
      
      public function set SlotBackOver(param1:Function) : void
      {
         this.FSlotBackOver = param1;
      }
      
      public function set SlotBackOut(param1:Function) : void
      {
         this.FSlotBackOut = param1;
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(this.FSlotBackOver != null)
         {
            this.FSlotBackOver(param1,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.FSlotBackOut != null)
         {
            this.FSlotBackOut(param1,param2);
         }
      }
      
      protected function HandleClcik(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FBTN_Left:
               --this.CurPageIndex;
               this.UpdatePage();
               break;
            case this.FBTN_Right:
               ++this.CurPageIndex;
               this.UpdatePage();
               break;
            case this.FMC_BoxPic:
               if(!this.FMC_BoxPic.buttonMode)
               {
                  return;
               }
               if(this.FGetRewardBackFun != null)
               {
                  this.FGetRewardBackFun(this.temp);
               }
         }
      }
      
      public function set GetRewardBackFun(param1:Function) : void
      {
         this.FGetRewardBackFun = param1;
      }
      
      protected function UpdatePage() : void
      {
         var _loc1_:Boolean = false;
         if(this.CurPageIndex <= 0)
         {
            _loc1_ = false;
            this.CurPageIndex = 0;
         }
         else
         {
            _loc1_ = true;
         }
         var _loc2_:int = this.FSelectInventories.Count / FIVE;
         if(this.CurPageIndex >= _loc2_)
         {
            _loc1_ = false;
            this.CurPageIndex = _loc2_;
         }
         else
         {
            _loc1_ = true;
         }
         this.UpdateFiveSlot();
      }
      
      public function SetDate(param1:TGodtreeDrop, param2:int) : void
      {
         var _loc3_:int = 0;
         this.temp = param1;
         this.FTF_Reward_Dec.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str13).DescribeString,this.temp.GodtreeLevel);
         this.FTF_LevelDec.text = new ConsumeFrameCopy(STRING_THEWORLDTREE.str14[param2]).DescribeString;
         this.FTempSelectInventoriesId.length = 0;
         this.FTempSelectInventoriesCount.length = 0;
         this.FSelectInventories.Clear();
         if(this.temp)
         {
            _loc3_ = 0;
            while(_loc3_ < this.temp.DropListFixedAward.length)
            {
               if(this.temp.DropListFixedAward[_loc3_].Code != 41)
               {
                  this.FTempSelectInventoriesId.push(this.temp.DropListFixedAward[_loc3_].Code);
                  this.FTempSelectInventoriesCount.push(this.temp.DropListFixedAward[_loc3_].Amount);
               }
               _loc3_++;
            }
         }
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
         _loc3_ = 0;
         while(_loc3_ < this.FSelectInventories.Count)
         {
            this.FSelectInventories.GetInventoryByIndex(_loc3_).Quantity = this.FTempSelectInventoriesCount[_loc3_];
            _loc3_++;
         }
         this.CurPageIndex = 0;
         this.UpdatePage();
      }
      
      protected function UpdateFiveSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < FIVE)
         {
            _loc2_ = this.CurPageIndex * FIVE + _loc1_;
            if(_loc2_ >= this.FSelectInventories.Count)
            {
               this.FFiveSlot[_loc2_].Context = null;
            }
            else
            {
               this.FFiveSlot[_loc2_].Context = this.FSelectInventories.GetInventoryByIndex(_loc2_);
            }
            _loc1_++;
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
            _loc6_.LoadSecondary(_loc5_.IDTexture);
         }
      }
   }
}

