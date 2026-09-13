package Processors.Game.Lobby.Heros.Panel
{
   import Components.Slots.TUISlot;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TErrorCode;
   import Logics.DatebaseVO.VO.TRingValue;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Homeland.THomelandModel;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import Processors.Game.Lobby.MarryRank.TMarryRankModel;
   import Processors.Game.Windows.Editors.TUIWindowEditor;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BACKPACK;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TUIRing extends TUIBaseWindow
   {
      
      public var EffectGenerateText:Function = null;
      
      protected var FSlot:TUISlot = null;
      
      protected var FUIWindowEditor:TUIWindowEditor;
      
      public function TUIRing(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         FMC_Scene = param1;
         this.FSlot = this.GetSlot(FMC_Scene.MC_Ring);
         this.FUIWindowEditor = new TUIWindowEditor(this.Parent.Parent,CONST_MODULES.MODULE_Heros);
         this.FUIWindowEditor.OnOK = this.WindowEditorOnOK;
         this.FUIWindowEditor.OnCancel = this.WindowEditorOnCancel;
         this.FUIWindowEditor.OnMax = this.WindowEditorOnMax;
         this.FUIWindowEditor.x = (CONST_COMMON.STAGE_Width - this.FUIWindowEditor.WindowWidth) / 2;
         this.FUIWindowEditor.y = (CONST_COMMON.STAGE_Height - this.FUIWindowEditor.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowEditor(this.FUIWindowEditor);
         THomelandModel.UpdateRingUI = this.UpdateUI;
      }
      
      override public function UpdateUI() : void
      {
         if(THomelandModel.selfHome.ringId == 0 || THomelandModel.selfHome.status == 0)
         {
            return;
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_UseRose,true);
         FMC_Scene.BTN_UseRose.addEventListener(MouseEvent.CLICK,this.onUseRoseClick);
         TGameUtil.setButtonMode(FMC_Scene.BTN_GoHome,true);
         FMC_Scene.BTN_GoHome.addEventListener(MouseEvent.CLICK,this.onGoHomeClick);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.onRankClick);
         var _loc1_:Vector.<uint> = new Vector.<uint>();
         _loc1_.push(THomelandModel.selfHome.ringId);
         var _loc2_:TInventories = new TInventories();
         var _loc3_:TUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         _loc3_.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc2_,_loc1_);
         var _loc4_:TInventory = _loc2_.GetInventoryByTempletID(THomelandModel.selfHome.ringId);
         this.FSlot.Context = _loc4_;
         var _loc5_:TRingValue = THomelandModel.getRingVOByExp(THomelandModel.selfHome.ringId,THomelandModel.selfHome.ringExp);
         var _loc6_:TRingValue = THomelandModel.getRingVOByLevel(THomelandModel.selfHome.ringId,_loc5_.BuildLevel + 1);
         var _loc7_:int = THomelandModel.getRingTotalExp(_loc5_);
         FMC_Scene.Text_Ring.text = _loc4_.Name;
         FMC_Scene.Text_Level.text = TIllustratedModel.TextFormat(70480031,_loc5_.BuildLevel);
         FMC_Scene.Text_Exp.text = TIllustratedModel.TextFormat(70480032,THomelandModel.selfHome.ringExp - _loc7_ + "/" + _loc5_.Exp);
         FMC_Scene.Text_Charm.text = TIllustratedModel.TextFormat(70480039,_loc5_.Charm);
         FMC_Scene.Text_NextCharm.text = TIllustratedModel.TextFormat(70480040,_loc6_.Charm);
         var _loc8_:Array = JSON.parse(_loc5_.Value).addOther;
         var _loc9_:Array = JSON.parse(_loc6_.Value).addOther;
         var _loc10_:int = 0;
         while(_loc10_ < 4)
         {
            FMC_Scene["Text_Attribute_" + _loc10_].text = _loc8_[_loc10_].value;
            FMC_Scene["Text_NextAttribute_" + _loc10_].text = _loc9_[_loc10_].value;
            _loc10_++;
         }
      }
      
      override public function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FSlot)
         {
            this.FSlot.Update();
         }
         if(this.FUIWindowEditor)
         {
            this.FUIWindowEditor.Update();
         }
      }
      
      protected function WindowEditorOnOK(param1:Object) : void
      {
         var _loc2_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Backpack_UseAppliance);
         var _loc3_:ByteArray = _loc2_.Data;
         _loc3_.writeShort(1);
         _loc3_.writeUnsignedInt(14111313);
         _loc3_.writeShort(this.FUIWindowEditor.Value);
         _loc3_.writeUnsignedInt(0);
         TUtilityString.FlushUTF(_loc3_,"");
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.FUIWindowEditor.Visible = false;
      }
      
      protected function WindowEditorOnCancel(param1:Object) : void
      {
         this.FUIWindowEditor.Context = null;
      }
      
      protected function WindowEditorOnMax(param1:Object) : void
      {
         this.FUIWindowEditor.Value = 1;
         this.FUIWindowEditor.SetFocus();
      }
      
      protected function GetSlot(param1:Sprite) : TUISlot
      {
         var _loc2_:TUISlot = new TUISlot(this);
         _loc2_.Resource = param1;
         _loc2_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         _loc2_.OnOverlay = OnItemOver;
         _loc2_.OnOut = OnItemOut;
         _loc2_.Init();
         return _loc2_;
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = param2 as TInventory;
         var _loc6_:TResourceRepositoryTexture = SResourcesCore.TexturesInventory;
         var _loc7_:TTexture = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Common);
         }
      }
      
      private function onUseRoseClick(param1:MouseEvent) : void
      {
         var _loc4_:TBins = null;
         var _loc5_:TErrorCode = null;
         var _loc6_:String = null;
         var _loc2_:TInventories = SLogicsCore.Character.Appliances as TInventories;
         var _loc3_:TInventory = _loc2_.GetInventoryByTempletID(14111313);
         if(_loc3_ == null)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ErrorCode);
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.GetDatebaseByIdentifier(1388) as TErrorCode;
               if(_loc5_ != null)
               {
                  _loc6_ = _loc5_.Desc;
                  if(this.EffectGenerateText != null)
                  {
                     this.EffectGenerateText(_loc6_);
                  }
               }
            }
            return;
         }
         this.FUIWindowEditor.Label = _loc3_.Name;
         this.FUIWindowEditor.Context = _loc3_ as TAppliance;
         this.FUIWindowEditor.Quantity = TUtilityString.Format(STRING_BACKPACK.FORMAT_UsePrompt,_loc3_.Quantity);
         this.FUIWindowEditor.Value = _loc3_.Quantity;
         this.FUIWindowEditor.Min = 1;
         this.FUIWindowEditor.Max = _loc3_.Quantity;
         this.FUIWindowEditor.SetFocus();
         this.FUIWindowEditor.Visible = true;
      }
      
      private function onGoHomeClick(param1:MouseEvent) : void
      {
         THomelandModel.ProcessorWindowsSwitch(THomelandModel.homeLand);
      }
      
      private function onRankClick(param1:MouseEvent) : void
      {
         THomelandModel.ProcessorWindowsSwitch(TMarryRankModel.marryRank);
      }
      
      override public function SetVisible(param1:Boolean) : void
      {
         super.SetVisible(param1);
         if(param1)
         {
            this.UpdateUI();
         }
      }
   }
}

