package Processors.Game.Lobby.TreasureMap
{
   import Components.Slots.TUISlot;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
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
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Overlayers.TreasureMap.TTreasureProofChangTips;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_TREASUREMAP;
   import Resources.Strings.STRING_TREASUREMAP;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorNewProofChange extends TProcessorLobbyWindow
   {
      
      public static const FOUR:int = 4;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      public static const FIVE:int = 6;
      
      protected var FPanel:MovieClip;
      
      private var FSprite:Sprite = new Sprite();
      
      protected var FOldProofChangBtn:Function;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      
      protected var FIDTemplates:Vector.<uint> = new Vector.<uint>();
      
      protected var FInventories:TInventories = new TInventories();
      
      protected var FPercent:Vector.<uint> = new Vector.<uint>();
      
      protected var FUISlots:Vector.<TUISlot> = new Vector.<TUISlot>();
      
      protected var FLimitLevel:Vector.<int> = new Vector.<int>(FOUR);
      
      protected var McSlotFour:Vector.<MovieClip> = new Vector.<MovieClip>(FOUR);
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FDateVec:Vector.<Object>;
      
      protected var FProofItems:Vector.<uint>;
      
      protected var FProofCount:Vector.<uint> = new Vector.<uint>(FIVE);
      
      protected var Fis_Execute:int = 1;
      
      protected var VecInventer:Vector.<TInventory> = new Vector.<TInventory>(FIVE);
      
      protected var VecInventerCount:Vector.<uint> = new Vector.<uint>(FIVE);
      
      protected var FVec_C_S:Vector.<TInventory> = new Vector.<TInventory>();
      
      protected var FCountVec:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      protected var FlashId:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      protected var FProofTip:TTreasureProofChangTips;
      
      public function TProcessorNewProofChange(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TREASUREMAP.RESOURCE_TREASUREMAP);
         super.ResourcesPerform_UIRequest();
      }
      
      public function BeginDraw() : void
      {
         this.FSprite.graphics.beginFill(0,0.3);
         this.FSprite.graphics.drawRect(0,0,FUICore.StageWidth,FUICore.StageHeight);
         this.FSprite.graphics.endFill();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc2_:TUISlot = null;
         this.FPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_TREASUREMAP.RESOURCE_ClassName_MC_ProofChange) as MovieClip;
         addChild(this.FSprite);
         this.BeginDraw();
         this.FSprite.addChild(this.FPanel);
         this.FSprite.x = FUICore.StageWidth - this.FSprite.width >> 1;
         this.FSprite.y = FUICore.StageHeight - this.FSprite.height >> 1;
         this.FPanel.x = this.FSprite.width - this.FPanel.width >> 1;
         this.FPanel.y = this.FSprite.height - this.FPanel.height >> 1;
         var _loc1_:int = 0;
         while(_loc1_ < FOUR)
         {
            this.McSlotFour[_loc1_] = this.FPanel["MC_ProofUint_" + _loc1_];
            _loc1_++;
         }
         this.AddEventListener();
         var _loc3_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < FOUR)
         {
            _loc2_ = this.GetSlot();
            _loc2_.Resource = this.McSlotFour[_loc1_]["MC_Slot_0"];
            _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc2_.Init();
            _loc2_.OnOverlay = this.ApplianceOnOver;
            _loc2_.OnOut = this.ApplianceOnOut;
            this.FUISlots[_loc3_] = _loc2_;
            _loc3_++;
            _loc2_ = this.GetSlot();
            _loc2_.Resource = this.McSlotFour[_loc1_]["MC_Slot_1"];
            _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc2_.Init();
            _loc2_.OnOverlay = this.ApplianceOnOver;
            _loc2_.OnOut = this.ApplianceOnOut;
            this.FUISlots[_loc3_] = _loc2_;
            _loc3_++;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < FOUR)
         {
            TGameUtil.setButtonMode(this.McSlotFour[_loc1_]["mc_chang_btn"],true);
            MovieClip(this.McSlotFour[_loc1_]["mc_chang_btn"]).addEventListener(MouseEvent.CLICK,this.ChangeCilck);
            MovieClip(this.McSlotFour[_loc1_]["mc_chang_btn"]).addEventListener(MouseEvent.MOUSE_OVER,this.ChangeOver);
            MovieClip(this.McSlotFour[_loc1_]["mc_chang_btn"]).addEventListener(MouseEvent.MOUSE_OUT,this.ChangeOut);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < FIVE)
         {
            this.FCountVec.push(this.FPanel["mc_proof_" + _loc1_]);
            TextField(this.FCountVec[_loc1_]["TF_Counted"]).text = "";
            MovieClip(this.FCountVec[_loc1_]["MC_Color"]).gotoAndStop(FIVE - _loc1_);
            this.FCountVec[_loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.CMOVE);
            this.FCountVec[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.COUT);
            this.FCountVec[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.COver);
            _loc1_++;
         }
         this.FOverlayerAppliance = new TOverlayerAppliance(FParent,CONST_MODULES.MODULE_TreasureMap);
         this.FOverlayerAppliance.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         this.FProofTip = new TTreasureProofChangTips(FParent);
         this.FProofTip.visible = false;
         this.FProofTip.mouseEnabled = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FProofTip);
         super.ResourcesPerform_UIDispatch();
      }
      
      public function COver(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.charAt(Number(_loc2_.length - 1)));
         this.FProofTip.Context = this.FProofItems[_loc3_];
         this.FProofTip.Render(FUICore.MouseCoordinate);
         this.FProofTip.Show();
      }
      
      public function COUT(param1:MouseEvent) : void
      {
         this.FProofTip.Hide();
      }
      
      public function CMOVE(param1:MouseEvent) : void
      {
         this.FProofTip.Render(FUICore.MouseCoordinate);
      }
      
      protected function ChangeCilck(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.McSlotFour[0]["mc_chang_btn"]:
               this.sendChangeMsg(0);
               break;
            case this.McSlotFour[1]["mc_chang_btn"]:
               this.sendChangeMsg(2);
               break;
            case this.McSlotFour[2]["mc_chang_btn"]:
               this.sendChangeMsg(4);
               break;
            case this.McSlotFour[3]["mc_chang_btn"]:
               this.sendChangeMsg(6);
         }
      }
      
      protected function sendChangeMsg(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TreasureMap_NewProof);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FVec_C_S[param1].IDTemplate);
         _loc3_.writeUnsignedInt(this.FVec_C_S[param1 + 1].IDTemplate);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ApplianceOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         _loc4_ = this.FOverlayerAppliance;
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function ApplianceOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         _loc4_ = this.FOverlayerAppliance;
         if(_loc4_ != null)
         {
            _loc4_.Hide();
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_TreasureMap);
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      protected function AddEventListener() : void
      {
         this.FPanel.BT_Close.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FPanel.S_OldProofChange_Btn.addEventListener(MouseEvent.CLICK,this.BtnClick);
      }
      
      public function BtnClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FPanel.BT_Close:
               this.visible = false;
               this.ClearSlot();
               break;
            case this.FPanel.S_OldProofChange_Btn:
               this.FOldProofChangBtn();
         }
      }
      
      public function set OldProofChangBtn(param1:Function) : void
      {
         this.FOldProofChangBtn = param1;
      }
      
      public function OpenMe(param1:Vector.<Object>, param2:Vector.<uint>) : void
      {
         var _loc3_:int = 0;
         if(this.Fis_Execute)
         {
            this.FInventories.Clear();
            this.FIDTemplates.length = 0;
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               this.FIDTemplates.push(param1[_loc3_].fr_itemid);
               this.FIDTemplates.push(param1[_loc3_].to_itemid);
               this.FPercent.push(param1[_loc3_].fr_itemcnt);
               this.FPercent.push(param1[_loc3_].to_itemcnt);
               this.FLimitLevel[_loc3_] = param1[_loc3_].level_limit;
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < FOUR - 1)
            {
               TextField(this.McSlotFour[_loc3_]["MC_LimitLevel"]["TF_Level"]).text = STRING_TREASUREMAP.STRING_Limit_Level.split("%0").join(this.FLimitLevel[_loc3_]);
               _loc3_++;
            }
            this.Fis_Execute = 0;
            this.FDateVec = param1;
            this.FProofItems = param2;
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,this.FIDTemplates);
            this.Initilazation();
         }
         this.RefleshVisibel();
         this.RefleshS_c();
         this.AllReflash();
         this.TwoSmallBell();
      }
      
      public function RefleshVisibel() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < FOUR)
         {
            if(this.getMainHeroLevel() >= uint(this.FLimitLevel[_loc1_]))
            {
               MovieClip(this.McSlotFour[_loc1_]["mc_chang_btn"]).visible = true;
               MovieClip(this.McSlotFour[_loc1_]["MC_LimitLevel"]).visible = false;
            }
            else
            {
               MovieClip(this.McSlotFour[_loc1_]["mc_chang_btn"]).visible = false;
               MovieClip(this.McSlotFour[_loc1_]["MC_LimitLevel"]).visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function getMainHeroLevel() : uint
      {
         return SLogicsCore.Character.GetMainLevel();
      }
      
      protected function TwoSmallBell() : void
      {
         MovieClip(this.FPanel["MC_Left"]).gotoAndPlay(1);
         MovieClip(this.FPanel["MC_Right"]).gotoAndPlay(1);
      }
      
      protected function RefleshS_c() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.FInventories.Count)
         {
            this.FInventories.GetInventoryByIndex(_loc1_).Quantity = 0;
            _loc1_++;
         }
      }
      
      protected function ReflashCount() : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         this.FVec_C_S.length = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FInventories.Count)
         {
            _loc2_ = this.FInventories.GetInventoryByIndex(_loc1_);
            _loc3_ = 0;
            while(_loc3_ < this.VecInventer.length)
            {
               if(this.VecInventer[_loc3_] != null)
               {
                  if(_loc2_.IDTemplate == this.VecInventer[_loc3_].IDTemplate)
                  {
                     _loc2_.Quantity = this.VecInventerCount[_loc3_];
                  }
               }
               _loc3_++;
            }
            this.FVec_C_S.push(_loc2_);
            this.FUISlots[_loc1_].Context = _loc2_;
            _loc1_++;
         }
         this.reflshFilter();
      }
      
      protected function ClearSlot() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FUISlots.length)
         {
            this.FUISlots[_loc1_].Context = null;
            _loc1_++;
         }
      }
      
      protected function reflshFilter() : void
      {
         var _loc2_:TInventory = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _loc2_ = this.FUISlots[_loc1_].Context as TInventory;
            if(_loc2_.Quantity <= 0)
            {
               this.FUISlots[_loc1_].SetDefaultFilters(true);
            }
            else
            {
               this.FUISlots[_loc1_].SetDefaultFilters(false);
            }
            _loc1_++;
         }
      }
      
      protected function AllReflash() : void
      {
         this.RefreshProofCount();
         this.ReflashCount();
      }
      
      public function Initilazation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc1_ < FOUR)
         {
            TextField(this.McSlotFour[_loc1_]["TF_right_percent"]).text = this.FDateVec[_loc1_].fr_itemcnt;
            TextField(this.McSlotFour[_loc1_]["TF_left_percent"]).text = this.FDateVec[_loc1_].to_itemcnt;
            TextField(this.McSlotFour[_loc1_]["TF_right_name"]).text = this.FInventories.GetInventoryByIndex(_loc2_).Name;
            TextField(this.McSlotFour[_loc1_]["TF_right_name"]).textColor = QUALITYCOLOR_INDEX[this.FInventories.GetInventoryByIndex(_loc2_).Quality];
            _loc2_++;
            TextField(this.McSlotFour[_loc1_]["TF_left_name"]).text = this.FInventories.GetInventoryByIndex(_loc2_).Name;
            TextField(this.McSlotFour[_loc1_]["TF_left_name"]).textColor = QUALITYCOLOR_INDEX[this.FInventories.GetInventoryByIndex(_loc2_).Quality];
            _loc2_++;
            _loc1_++;
         }
      }
      
      public function update() : void
      {
         if(this.FUISlots == null || this.FUISlots.length == 0)
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.FUISlots.length)
         {
            this.FUISlots[_loc1_].Update();
            _loc1_++;
         }
      }
      
      protected function GetSlot() : TUISlot
      {
         var _loc1_:TUISlot = null;
         _loc1_ = new TUISlot(this);
         _loc1_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         return _loc1_;
      }
      
      public function ChangeSucceed() : void
      {
         this.AllReflash();
         var _loc1_:int = 0;
         while(_loc1_ < this.FlashId.length)
         {
            MovieClip(this.FlashId[_loc1_]["MC_movie"]).gotoAndPlay(1);
            _loc1_++;
         }
         this.CheckChangBtn();
      }
      
      public function CheckChangBtn() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < FOUR)
         {
            _loc2_ = this.FProofItems.indexOf(this.FIDTemplates[_loc1_ * 2]);
            if(_loc2_ >= 0)
            {
               TGameUtil.setButtonMode(this.McSlotFour[_loc1_]["mc_chang_btn"],this.FPercent[_loc1_ * 2] <= this.FProofCount[_loc2_]);
            }
            _loc1_++;
         }
      }
      
      protected function RefreshProofCount() : void
      {
         var _loc2_:TInventory = null;
         var _loc4_:int = 0;
         var _loc1_:TInventories = SLogicsCore.Character.Appliances;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this.FProofCount.length)
         {
            this.FProofCount[_loc3_] = 0;
            this.VecInventer[_loc3_] = null;
            this.VecInventerCount[_loc3_] = 0;
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_.Count)
         {
            _loc2_ = _loc1_.GetInventoryByIndex(_loc3_);
            _loc4_ = 0;
            while(_loc4_ < this.FProofItems.length)
            {
               if(_loc2_.IDTemplate == this.FProofItems[_loc4_])
               {
                  if(this.FProofCount[_loc4_] == 0)
                  {
                     this.FProofCount[_loc4_] = _loc2_.Quantity;
                  }
                  else
                  {
                     this.FProofCount[_loc4_] += _loc2_.Quantity;
                  }
                  if(this.VecInventer[_loc4_] == null)
                  {
                     this.VecInventer[_loc4_] = _loc2_;
                     this.VecInventerCount[_loc4_] = _loc2_.Quantity;
                  }
                  else
                  {
                     this.VecInventerCount[_loc4_] += _loc2_.Quantity;
                  }
               }
               _loc4_++;
            }
            _loc3_++;
         }
         this.ReadText();
      }
      
      protected function ReadText() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < FIVE)
         {
            TextField(this.FPanel["mc_proof_" + _loc1_]["MC_movie"]["MC_movie_two"]["TF_Count"]).text = String(this.FProofCount[_loc1_]);
            _loc1_++;
         }
      }
      
      protected function ChangeOver(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.McSlotFour[0]["mc_chang_btn"]:
               this.BeforeSetCount(0);
               break;
            case this.McSlotFour[1]["mc_chang_btn"]:
               this.BeforeSetCount(2);
               break;
            case this.McSlotFour[2]["mc_chang_btn"]:
               this.BeforeSetCount(4);
               break;
            case this.McSlotFour[3]["mc_chang_btn"]:
               this.BeforeSetCount(6);
         }
      }
      
      protected function ChangeOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.FCountVec.length)
         {
            TextField(this.FCountVec[_loc2_]["TF_Counted"]).text = "";
            _loc2_++;
         }
      }
      
      protected function BeforeSetCount(param1:int) : void
      {
         this.FlashId.length = 0;
         var _loc2_:int = 0;
         while(_loc2_ < FIVE)
         {
            if(this.FInventories.GetInventoryByIndex(param1).IDTemplate == this.FProofItems[_loc2_])
            {
               TextField(this.FCountVec[_loc2_]["TF_Counted"]).text = "-" + String(this.FPercent[param1]);
               this.FlashId.push(this.FCountVec[_loc2_]);
            }
            else if(this.FInventories.GetInventoryByIndex(param1 + 1).IDTemplate == this.FProofItems[_loc2_])
            {
               TextField(this.FCountVec[_loc2_]["TF_Counted"]).text = "+" + String(this.FPercent[param1 + 1]);
               this.FlashId.push(this.FCountVec[_loc2_]);
            }
            _loc2_++;
         }
      }
   }
}

