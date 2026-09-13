package Processors.Game.Lobby.TransmigrationAccessory
{
   import Components.ScrollBar.TScrollBar;
   import Components.Slots.TUISlot;
   import Components.Standard.TUITab;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TNewornamentGenerate;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.TransmigrationAccessory.Component.TMakeEquip;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_EQUIPMAKE;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowTransmigrationAccessoryMake extends TProcessorGame
   {
      
      protected static const CONST_TAB_MAX:uint = 3;
      
      protected static const MAX_SLOT_CONST:uint = 8;
      
      protected static const MAX_MATERIAL_CONST:uint = 3;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var FScene:MovieClip;
      
      protected var FSlotVect:Vector.<TUISlot>;
      
      protected var FUITab:TUITab;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FMC_FreeMakeEquipList:Vector.<TMakeEquip>;
      
      protected var FMC_UseMakeEquipList:Vector.<TMakeEquip>;
      
      protected var FMakeUISlot:TUISlot;
      
      protected var FMaterialUISlotVect:Vector.<TUISlot>;
      
      protected var FEquipInventoriesIds:Vector.<uint>;
      
      protected var FEquipInventories:TInventories;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectIndex:uint;
      
      protected var FNewornamentGenerateBin:TBins;
      
      protected var FIsCanMake:Boolean;
      
      protected var FCurSelectMakeEquip:TMakeEquip;
      
      protected var FMaking:Boolean;
      
      protected var FSlotsOnQuerySequenceContext:Function;
      
      protected var FSlotsOnQuerySubscript:Function;
      
      protected var FUIComponentsHintOnOver:Function;
      
      protected var FUIComponentsHintOnOut:Function;
      
      public function TProcessorWindowTransmigrationAccessoryMake(param1:TUIComponent)
      {
         super(param1);
         this.FMC_FreeMakeEquipList = new Vector.<TMakeEquip>();
         this.FMC_UseMakeEquipList = new Vector.<TMakeEquip>();
         this.FMaterialUISlotVect = new Vector.<TUISlot>();
         this.FMaking = false;
      }
      
      protected function OnSlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence) : void
      {
         if(this.FSlotsOnQuerySequenceContext != null)
         {
            this.FSlotsOnQuerySequenceContext(param1,param2,param3);
         }
      }
      
      protected function OnSlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         if(this.FSlotsOnQuerySubscript != null)
         {
            this.FSlotsOnQuerySubscript(param1,param2,param3);
         }
      }
      
      protected function OnUIComponentsHintOnOver(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsHintOnOver != null)
         {
            this.FUIComponentsHintOnOver(param1,param2);
         }
      }
      
      protected function OnUIComponentsHintOnOut(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsHintOnOut != null)
         {
            this.FUIComponentsHintOnOut(param1,param2);
         }
      }
      
      protected function OnSlotClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TMakeEquip = null;
         _loc3_ = param1 as TMakeEquip;
         if(this.FCurSelectMakeEquip != null)
         {
            this.FCurSelectMakeEquip.IsSelected = false;
         }
         this.FCurSelectMakeEquip = _loc3_;
         if(this.FCurSelectMakeEquip)
         {
            this.FCurSelectMakeEquip.IsSelected = true;
         }
         this.UpdateMakeEquips();
      }
      
      protected function UpdateList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TMakeEquip = null;
         var _loc4_:TInventory = null;
         this.FScrollBar.Clear();
         _loc2_ = this.FMC_UseMakeEquipList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_UseMakeEquipList[_loc1_];
            this.FMC_FreeMakeEquipList.push(_loc3_);
            _loc1_++;
         }
         this.FMC_UseMakeEquipList.length = 0;
         _loc1_ = 0;
         while(_loc1_ < MAX_SLOT_CONST)
         {
            _loc4_ = this.FEquipInventories.GetInventoryByIndex(MAX_SLOT_CONST * this.FSelectIndex + _loc1_);
            _loc3_ = this.GetMakeEquip();
            _loc3_.Context = _loc4_;
            this.FScrollBar.AddItem(_loc3_);
            this.FMC_UseMakeEquipList.push(_loc3_);
            _loc1_++;
         }
      }
      
      protected function UpdateMakeEquips() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:TInventories = null;
         var _loc5_:TInventory = null;
         var _loc6_:TNewornamentGenerate = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         if(this.FCurSelectMakeEquip == null)
         {
            this.FScene["MC_EquipBox"]["EquipName"].text = "";
            this.FScene["MC_EquipBox"]["EquipGrade"].text = "";
            this.FMakeUISlot.Context = null;
            _loc2_ = this.FMaterialUISlotVect.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.FMaterialUISlotVect[_loc1_];
               _loc3_.Context = null;
               this.FScene["mc_Material" + _loc1_]["TF_NeedNum"].text = "";
               _loc1_++;
            }
            TGameUtil.setButtonMode(this.FScene["btn_Make"],false);
            this.FScene["tf_Money"].text = "0";
         }
         else
         {
            this.FIsCanMake = true;
            _loc5_ = this.FCurSelectMakeEquip.Context as TInventory;
            this.FScene["MC_EquipBox"]["EquipName"].text = _loc5_.Name;
            this.FScene["MC_EquipBox"]["EquipName"].textColor = QUALITYCOLOR_INDEX[_loc5_.Quality];
            this.FScene["MC_EquipBox"]["EquipGrade"].text = STRING_EQUIPMAKE.STRINGS_NeedGrade + STRING_COMMON.GetLevelStrByLevelLineFeed(_loc5_.RequirementLevel);
            this.FMakeUISlot.Context = _loc5_;
            _loc6_ = this.FNewornamentGenerateBin.GetDatebaseByIdentifier(_loc5_.IDTemplate) as TNewornamentGenerate;
            _loc4_ = new TInventories();
            this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc4_,_loc6_.Materials);
            _loc2_ = uint(_loc4_.Count);
            _loc1_ = 0;
            while(_loc1_ < MAX_MATERIAL_CONST)
            {
               _loc3_ = this.FMaterialUISlotVect[_loc1_];
               if(_loc1_ < _loc2_)
               {
                  _loc5_ = _loc4_.GetInventoryByIndex(_loc1_);
                  _loc3_.Context = _loc5_;
                  _loc7_ = this.GetMaterialCountByID(_loc5_.IDTemplate);
                  _loc8_ = _loc6_.Quantitys[_loc1_];
                  this.FScene["mc_Material" + _loc1_]["TF_NeedNum"].text = _loc7_ + "/" + _loc8_;
                  if(_loc7_ < _loc8_)
                  {
                     this.FIsCanMake = false;
                     this.FScene["mc_Material" + _loc1_]["TF_NeedNum"].textColor = CONST_COMMON.TEXT_White_Color;
                  }
                  else
                  {
                     this.FScene["mc_Material" + _loc1_]["TF_NeedNum"].textColor = CONST_COMMON.TEXT_Green_Color;
                  }
               }
               else
               {
                  _loc3_.Context = null;
                  this.FScene["mc_Material" + _loc1_]["TF_NeedNum"].text = "";
               }
               _loc1_++;
            }
            this.FScene["tf_Money"].text = "" + _loc6_.Cost;
            if(SLogicsCore.Character.CreditSilverCoin.ToNumber() < _loc6_.Cost)
            {
               this.FIsCanMake = false;
            }
            TGameUtil.setButtonMode(this.FScene["btn_Make"],this.FIsCanMake);
         }
      }
      
      protected function GetMaterialCountByID(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TInventories = null;
         var _loc5_:TInventory = null;
         var _loc6_:uint = 0;
         _loc4_ = SLogicsCore.Character.Materials;
         _loc3_ = uint(_loc4_.Count);
         _loc6_ = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = _loc4_.GetInventoryByIndex(_loc2_);
            if(_loc5_.IDTemplate == param1)
            {
               _loc6_ += _loc5_.Quantity;
            }
            _loc2_++;
         }
         return _loc6_;
      }
      
      protected function OnMakeClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         if(this.FMaking)
         {
            return;
         }
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FCurSelectMakeEquip == null)
         {
            return;
         }
         if(this.FCurSelectMakeEquip.Context == null)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TransmigrationAccessory_MakeAccessory_Req);
         _loc2_.Data.writeUnsignedInt((this.FCurSelectMakeEquip.Context as TInventory).IDTemplate);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.FMaking = true;
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FSelectIndex = param1 as int;
         if(this.FCurSelectMakeEquip)
         {
            this.FCurSelectMakeEquip.IsSelected = false;
            this.FCurSelectMakeEquip = null;
         }
         this.Update();
      }
      
      protected function GetMakeEquip() : TMakeEquip
      {
         var _loc1_:TMakeEquip = null;
         if(this.FMC_FreeMakeEquipList.length > 0)
         {
            _loc1_ = this.FMC_FreeMakeEquipList.pop();
         }
         else
         {
            _loc1_ = new TMakeEquip(this);
            _loc1_.SlotsOnQuerySequenceContext = this.OnSlotsOnQuerySequenceContext;
            _loc1_.UIComponentsHintOnOver = this.OnUIComponentsHintOnOver;
            _loc1_.UIComponentsHintOnOut = this.OnUIComponentsHintOnOut;
            _loc1_.OnClick = this.OnSlotClick;
         }
         return _loc1_;
      }
      
      public function get SlotsOnQuerySequenceContext() : Function
      {
         return this.FSlotsOnQuerySequenceContext;
      }
      
      public function set SlotsOnQuerySequenceContext(param1:Function) : void
      {
         this.FSlotsOnQuerySequenceContext = param1;
      }
      
      public function get SlotsOnQuerySubscript() : Function
      {
         return this.FSlotsOnQuerySubscript;
      }
      
      public function set SlotsOnQuerySubscript(param1:Function) : void
      {
         this.FSlotsOnQuerySubscript = param1;
      }
      
      public function get UIComponentsHintOnOver() : Function
      {
         return this.FUIComponentsHintOnOver;
      }
      
      public function set UIComponentsHintOnOver(param1:Function) : void
      {
         this.FUIComponentsHintOnOver = param1;
      }
      
      public function get UIComponentsHintOnOut() : Function
      {
         return this.FUIComponentsHintOnOut;
      }
      
      public function set UIComponentsHintOnOut(param1:Function) : void
      {
         this.FUIComponentsHintOnOut = param1;
      }
      
      public function SetScene(param1:MovieClip) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TNewornamentGenerate = null;
         var _loc5_:TUISlot = null;
         this.FScene = param1;
         addChild(this.FScene);
         TGameUtil.setButtonMode(this.FScene["btn_Make"],true);
         this.FUITab = new TUITab(this);
         _loc2_ = 0;
         while(_loc2_ < CONST_TAB_MAX)
         {
            this.FUITab.SetTabByIndex(this.FScene["mc_tab" + _loc2_],_loc2_);
            _loc2_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FScene["btn_Make"].addEventListener(MouseEvent.CLICK,this.OnMakeClick);
         this.FScrollBar = new TScrollBar(this.FScene["mc_list"],348,false,-7);
         this.FEquipInventoriesIds = new Vector.<uint>();
         this.FEquipInventories = new TInventories();
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FNewornamentGenerateBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NewornamentGenerate) as TBins;
         _loc3_ = uint(this.FNewornamentGenerateBin.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FNewornamentGenerateBin.GetDatebaseByIndex(_loc2_) as TNewornamentGenerate;
            if(_loc4_.IsEpic > 0)
            {
               this.FEquipInventoriesIds.push(_loc4_.Identifier);
            }
            _loc2_++;
         }
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FEquipInventories,this.FEquipInventoriesIds);
         this.FMakeUISlot = new TUISlot(this);
         this.FMakeUISlot.Resource = this.FScene["MC_EquipBox"]["Equip_slot"];
         this.FMakeUISlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FMakeUISlot.OnQuerySequenceContext = this.OnSlotsOnQuerySequenceContext;
         this.FMakeUISlot.OnOverlay = this.OnUIComponentsHintOnOver;
         this.FMakeUISlot.OnOut = this.OnUIComponentsHintOnOut;
         this.FMakeUISlot.Init();
         _loc2_ = 0;
         while(_loc2_ < MAX_MATERIAL_CONST)
         {
            _loc5_ = new TUISlot(this);
            _loc5_.Resource = this.FScene["mc_Material" + _loc2_];
            _loc5_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc5_.OnQuerySequenceContext = this.OnSlotsOnQuerySequenceContext;
            _loc5_.OnOverlay = this.OnUIComponentsHintOnOver;
            _loc5_.OnOut = this.OnUIComponentsHintOnOut;
            _loc5_.Init();
            this.FMaterialUISlotVect.push(_loc5_);
            _loc2_++;
         }
      }
      
      public function Update() : void
      {
         this.UpdateList();
         this.UpdateMakeEquips();
      }
      
      public function UpdateView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TMakeEquip = null;
         var _loc4_:TUISlot = null;
         if(!Visible)
         {
            return;
         }
         _loc2_ = this.FMC_UseMakeEquipList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_UseMakeEquipList[_loc1_];
            _loc3_.UpdateSlot();
            _loc1_++;
         }
         if(this.FMakeUISlot)
         {
            this.FMakeUISlot.Update();
         }
         _loc2_ = this.FMaterialUISlotVect.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FMaterialUISlotVect[_loc1_];
            _loc4_.Update();
            _loc1_++;
         }
      }
      
      public function Reset() : void
      {
         this.FMaking = false;
         this.OnSlotClick(this,null);
      }
      
      public function ResetMaking() : void
      {
         this.FMaking = false;
      }
   }
}

