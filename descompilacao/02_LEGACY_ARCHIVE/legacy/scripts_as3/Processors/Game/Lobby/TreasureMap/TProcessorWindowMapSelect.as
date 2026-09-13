package Processors.Game.Lobby.TreasureMap
{
   import Components.Slots.*;
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Queries.*;
   import Foundation.Queries.Textures.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Logics.Streamization.Inventories.*;
   import Logics.TreasureMap.*;
   import Logics.Vip.*;
   import Processors.Game.Windows.Information.*;
   import Rendering.Overlayers.TreasureMap.TOverlayerTreasureMap;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TProcessorWindowMapSelect extends TUIComponent
   {
      
      protected static const MAX_COUNT_Map:uint = 5;
      
      protected static const MAX_COUNT_Slot:uint = 8;
      
      protected var FScene:MovieClip;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FIDTemplates:Vector.<uint>;
      
      protected var FIDTemplatesCount:Vector.<uint>;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FHintBtnRefresh:THint;
      
      protected var FCurRefreshType:uint;
      
      protected var FCurRefreshCost:uint;
      
      protected var FOpenMapId:uint;
      
      protected var FTreasureMapData:TTreasureMapData;
      
      protected var FMaxEnterTimes:int;
      
      protected var FCanEnterTimes:int;
      
      protected var FCostMoney:Vector.<Object>;
      
      protected var FDiggingBins:TBins;
      
      protected var FCharacter:TCharacter;
      
      protected var FVipData:TVip;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowConfirmationTreasure:TUIWindowConfirmation;
      
      protected var FUIWindowConfirmationForDirectOpenBtn:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FOverlayerTreasureMap:TOverlayerTreasureMap;
      
      protected var FOnCanDig:Function;
      
      protected var FOpenGame:Function;
      
      protected var FOnApplianceOnOver:Function;
      
      protected var FOnApplianceOnOut:Function;
      
      protected var FOnHintOnOver:Function;
      
      protected var FOnHintOnOut:Function;
      
      protected var FOnEffectText:Function;
      
      protected var FTutorialNextStep:Function;
      
      public function TProcessorWindowMapSelect(param1:TUIComponent, param2:MovieClip)
      {
         var _loc3_:TConfigValue = null;
         super(param1);
         this.FScene = param2;
         this.FDiggingBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Digging);
         this.FUISlots = new Vector.<TUISlot>(MAX_COUNT_Slot);
         this.FIDTemplates = new Vector.<uint>(MAX_COUNT_Slot);
         this.FIDTemplatesCount = new Vector.<uint>(MAX_COUNT_Slot);
         this.FInventories = new TInventories();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FHintBtnRefresh = new THint();
         this.FCharacter = SLogicsCore.Character;
         this.FVipData = this.FCharacter.VipData;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TreasureMap_Mast_FreeQuency) as TConfigValue;
         this.FMaxEnterTimes = int(_loc3_.Value);
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TreasureMap_FreeQuency) as TConfigValue;
         this.FCanEnterTimes = int(_loc3_.Value);
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TreasureMap_RefreshCost) as TConfigValue;
         this.FCostMoney = Vector.<Object>(_loc3_.Value);
         this.FOverlayerTreasureMap = new TOverlayerTreasureMap(this.Parent);
         this.FOverlayerTreasureMap.Visible = false;
         this.InitWindowMapSelect();
      }
      
      protected function GetSlot() : TUISlot
      {
         var _loc1_:TUISlot = null;
         _loc1_ = new TUISlot(this);
         _loc1_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         return _loc1_;
      }
      
      protected function InitWindowMapSelect() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Bitmap = null;
         var _loc3_:TDigging = null;
         var _loc4_:TUISlot = null;
         this.FScene.btn_close.addEventListener(MouseEvent.CLICK,this.OnClose);
         TGameUtil.setButtonMode(this.FScene.btn_start,true);
         this.FScene.btn_start.addEventListener(MouseEvent.CLICK,this.OnStartDig);
         TGameUtil.setButtonMode(this.FScene.btn_refresh,true);
         this.FScene.btn_refresh.addEventListener(MouseEvent.CLICK,this.OnRefreshMap);
         this.FScene.btn_refresh.addEventListener(MouseEvent.MOUSE_MOVE,this.OnRefreshMapMouseMove);
         this.FScene.btn_refresh.addEventListener(MouseEvent.MOUSE_OUT,this.OnRefreshMapMouseOut);
         this.FScene.btn_refresh.tf_btnInfo.mouseEnabled = false;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT_Map)
         {
            TGameUtil.setButtonMode(this.FScene["mc_map_" + _loc1_].mc_open.btn_open,true);
            this.FScene["mc_map_" + _loc1_].mc_open.btn_open.addEventListener(MouseEvent.CLICK,this.OnOpenMap);
            this.FScene["mc_map_" + _loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.OnMapMove);
            this.FScene["mc_map_" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.OnMapOut);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT_Slot)
         {
            _loc4_ = this.GetSlot();
            _loc4_.Resource = this.FScene["mc_slot_" + _loc1_];
            _loc4_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc4_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc4_.Init();
            _loc4_.OnOverlay = this.ApplianceOnOver;
            _loc4_.OnOut = this.ApplianceOnOut;
            this.FUISlots[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this);
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
         this.FUIWindowConfirmationForDirectOpenBtn = new TUIWindowConfirmation(this);
         this.FUIWindowConfirmationForDirectOpenBtn.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmationForDirectOpenBtn.WindowWidth) / 2;
         this.FUIWindowConfirmationForDirectOpenBtn.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmationForDirectOpenBtn.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationForDirectOpenBtn);
         this.FUIWindowConfirmationForDirectOpenBtn.SetCheckBox(true);
         this.FUIWindowConfirmationTreasure = new TUIWindowConfirmation(this);
         this.FUIWindowConfirmationTreasure.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmationTreasure.WindowWidth) / 2;
         this.FUIWindowConfirmationTreasure.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmationTreasure.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationTreasure);
         this.FUIWindowRecharge = new TUIWindowRecharge(this);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTreasureMap);
         this.FScene.tf_reward2.text = "";
      }
      
      protected function GetItemStr(param1:int, param2:int, param3:int) : String
      {
         return param3 + STRING_COMMON.GetItemNameByType(param1,param2);
      }
      
      protected function UpdataUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TDigging = null;
         var _loc3_:TDigging = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         var _loc10_:TDiggingReward = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:int = 0;
         _loc4_ = 0;
         _loc3_ = this.FDiggingBins.GetDatebaseByIdentifier(this.FTreasureMapData.CurQuality) as TDigging;
         if(_loc3_ != null)
         {
            _loc4_ = int(_loc3_.Rate);
         }
         if(_loc4_ != 0 && !this.FTreasureMapData.TreasureStatus)
         {
            TGameUtil.setButtonMode(this.FScene.btn_start,true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FScene.btn_start,false);
         }
         this.FScene.tf_completeTimes.text = this.FTreasureMapData.CurEnterTimes + "/" + this.FMaxEnterTimes;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT_Map)
         {
            this.FScene["mc_map_" + _loc1_].gotoAndStop(Boolean(_loc4_ == _loc1_ + 2) ? 1 : 2);
            this.FScene["mc_map_" + _loc1_].mc_bg.mc_select.visible = Boolean(_loc4_ == _loc1_ + 2);
            this.FScene["mc_map_" + _loc1_].mc_name.gotoAndStop(_loc1_ + 1);
            _loc2_ = this.FDiggingBins.GetDatebaseByIndex(_loc1_) as TDigging;
            if(_loc2_.Isgold)
            {
               this.FScene["mc_map_" + _loc1_].mc_open.visible = true;
               if(_loc2_.Rate > _loc4_)
               {
                  if(this.FVipData.Digging)
                  {
                     this.FScene["mc_map_" + _loc1_].mc_open.btn_open.visible = true;
                     this.FScene["mc_map_" + _loc1_].mc_open.tf_openTips.visible = false;
                     TGameUtil.setButtonMode(this.FScene["mc_map_" + _loc1_].mc_open.btn_open,true);
                  }
                  else
                  {
                     this.FScene["mc_map_" + _loc1_].mc_open.btn_open.visible = false;
                     this.FScene["mc_map_" + _loc1_].mc_open.tf_openTips.visible = true;
                     _loc7_ = STRING_TREASUREMAP.STRING_VipOpenTip;
                     _loc7_ = _loc7_.split("%count%").join(_loc2_.Viplevel);
                     this.FScene["mc_map_" + _loc1_].mc_open.tf_openTips.text = _loc7_;
                  }
               }
               else if(this.FVipData.Digging)
               {
                  this.FScene["mc_map_" + _loc1_].mc_open.btn_open.visible = true;
                  this.FScene["mc_map_" + _loc1_].mc_open.tf_openTips.visible = false;
                  TGameUtil.setButtonMode(this.FScene["mc_map_" + _loc1_].mc_open.btn_open,false);
               }
               else
               {
                  this.FScene["mc_map_" + _loc1_].mc_open.btn_open.visible = false;
                  this.FScene["mc_map_" + _loc1_].mc_open.tf_openTips.visible = true;
                  _loc7_ = STRING_TREASUREMAP.STRING_VipOpenTip;
                  _loc7_ = _loc7_.split("%count%").join(_loc2_.Viplevel);
                  this.FScene["mc_map_" + _loc1_].mc_open.tf_openTips.text = _loc7_;
               }
            }
            else
            {
               this.FScene["mc_map_" + _loc1_].mc_open.visible = false;
            }
            _loc1_++;
         }
         if(_loc3_ != null)
         {
            _loc8_ = this.FCharacter.GetMainHero().Level;
            _loc9_ = String(_loc8_) + String(_loc3_.Identifier);
            _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TDiggingReward,uint(_loc9_)) as TDiggingReward;
            _loc11_ = "";
            _loc12_ = ",";
            _loc1_ = 0;
            while(_loc1_ < _loc10_.MastGetReward.length)
            {
               if(_loc1_ == _loc10_.MastGetReward.length - 1)
               {
                  _loc12_ = "";
               }
               _loc11_ += STRING_COMMON.GetItemNameByType(_loc10_.MastGetReward[_loc1_].type,_loc10_.MastGetReward[_loc1_].code) + "*" + _loc10_.MastGetReward[_loc1_].amount + _loc12_;
               _loc1_++;
            }
            this.FScene.tf_reward1.text = _loc11_;
            this.FScene.tf_costTime.text = _loc3_.Digtime / 60 + STRING_COMMON.TYPE_TIME_Minute;
            this.FScene.tf_desc.text = _loc3_.Description;
            this.FIDTemplates.length = 0;
            this.FIDTemplatesCount.length = 0;
            _loc1_ = 0;
            while(_loc1_ < MAX_COUNT_Slot)
            {
               if(_loc1_ >= _loc10_.OddsGetReward.length)
               {
                  break;
               }
               this.FScene["mc_slot_" + _loc1_].visible = true;
               this.FIDTemplates.push(_loc10_.OddsGetReward[_loc1_].code);
               this.FIDTemplatesCount.push(_loc10_.OddsGetReward[_loc1_].amount);
               _loc1_++;
            }
            _loc13_ = 0;
            while(_loc1_ < MAX_COUNT_Slot)
            {
               if(_loc1_ < _loc10_.OddsGetReward.length + _loc10_.OddsGetReward2.length)
               {
                  this.FScene["mc_slot_" + _loc1_].visible = true;
                  this.FIDTemplates.push(_loc10_.OddsGetReward2[_loc13_].code);
                  this.FIDTemplatesCount.push(_loc10_.OddsGetReward2[_loc13_].amount);
               }
               else
               {
                  this.FScene["mc_slot_" + _loc1_].visible = false;
               }
               _loc1_++;
               _loc13_++;
            }
            this.FInventories.Clear();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,this.FIDTemplates);
            _loc1_ = 0;
            while(_loc1_ < this.FInventories.Count)
            {
               this.FInventories.GetInventoryByIndex(_loc1_).Quantity = this.FIDTemplatesCount[_loc1_];
               this.FUISlots[_loc1_].Context = this.FInventories.GetInventoryByIndex(_loc1_);
               _loc1_++;
            }
         }
         else
         {
            this.FScene.tf_reward1.text = "";
            this.FScene.tf_reward2.text = "";
            this.FScene.tf_costTime.text = "";
            this.FScene.tf_desc.text = "";
            _loc1_ = 0;
            while(_loc1_ < MAX_COUNT_Slot)
            {
               this.FScene["mc_slot_" + _loc1_].visible = false;
               _loc1_++;
            }
         }
         _loc5_ = uint(this.FCostMoney[0].times);
         _loc6_ = uint(this.FCostMoney[1].times);
         if(this.FTreasureMapData.CurRefreshTimes < _loc5_)
         {
            this.FCurRefreshType = this.FCostMoney[0].code;
            this.FCurRefreshCost = this.FCostMoney[0].amount;
            this.FScene.btn_refresh.visible = true;
            this.FScene.btn_refresh.tf_btnInfo.text = STRING_TREASUREMAP.STRING_RefreshCoinBtn.split("%count%").join(_loc5_ - this.FTreasureMapData.CurRefreshTimes);
            this.FHintBtnRefresh.Caption = STRING_TREASUREMAP.STRING_RefreshCoinHint.split("%count%").join(this.FCurRefreshCost);
         }
         else if(this.FTreasureMapData.CurRefreshTimes < _loc5_ + _loc6_)
         {
            this.FCurRefreshType = this.FCostMoney[1].code;
            this.FCurRefreshCost = this.FCostMoney[1].amount;
            this.FScene.btn_refresh.visible = true;
            this.FScene.btn_refresh.tf_btnInfo.text = STRING_TREASUREMAP.STRING_RefreshGoldBtn.split("%count%").join(_loc6_ + _loc5_ - this.FTreasureMapData.CurRefreshTimes);
            this.FHintBtnRefresh.Caption = STRING_TREASUREMAP.STRING_RefreshGoldHint.split("%count%").join(this.FCurRefreshCost);
         }
         else
         {
            this.FScene.btn_refresh.visible = false;
            this.FHintBtnRefresh.Caption = "";
         }
         if(_loc4_ - 1 >= MAX_COUNT_Map)
         {
            TGameUtil.setButtonMode(this.FScene.btn_refresh,false);
         }
         else
         {
            TGameUtil.setButtonMode(this.FScene.btn_refresh,true);
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
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function ApplianceOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnApplianceOnOver != null)
         {
            this.FOnApplianceOnOver(param1,param2);
         }
      }
      
      protected function ApplianceOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnApplianceOnOut != null)
         {
            this.FOnApplianceOnOut(param1,param2);
         }
      }
      
      protected function OnRefreshMapSure(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TreasureMap_RefreshReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.SetBtnEnable(false);
      }
      
      protected function OnOpenMapSure(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TreasureMap_OpenMapReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeInt(this.FOpenMapId);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnMapMove(param1:MouseEvent) : void
      {
         var _loc2_:uint = this.FCharacter.GetMainHero().Level;
         this.FOverlayerTreasureMap.Context = null;
         var _loc3_:String = param1.currentTarget.name;
         var _loc4_:int = int(_loc3_.slice(-1));
         var _loc5_:TDigging = this.FDiggingBins.GetDatebaseByIndex(_loc4_) as TDigging;
         var _loc6_:String = String(_loc2_) + String(_loc5_.Identifier);
         var _loc7_:Object = {
            "id":_loc6_,
            "Digging":_loc5_
         };
         this.FOverlayerTreasureMap.Context = _loc7_;
         this.FOverlayerTreasureMap.Render(FUICore.MouseCoordinate);
         this.FOverlayerTreasureMap.Show();
      }
      
      protected function OnMapOut(param1:MouseEvent) : void
      {
         this.FOverlayerTreasureMap.Hide();
      }
      
      protected function OnClose(param1:MouseEvent = null) : void
      {
         this.Visible = false;
      }
      
      protected function OnStartDig(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         if(this.FTutorialNextStep != null)
         {
            this.FTutorialNextStep(1903);
         }
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FOnCanDig != null)
         {
            if(!this.FOnCanDig())
            {
               return;
            }
         }
         if(this.FOpenGame != null)
         {
            this.FOpenGame();
         }
         this.OnClose();
      }
      
      protected function OnRefreshMap(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(this.FTutorialNextStep != null)
         {
            this.FTutorialNextStep(1902);
         }
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FCurRefreshType == 0)
         {
            if(this.FCharacter.CreditSilverCoin.ToNumber() < this.FCurRefreshCost)
            {
               if(this.FOnEffectText != null)
               {
                  this.FOnEffectText(STRING_COMMON.NOTENOUGH_Coin);
               }
               return;
            }
         }
         else if(this.FCurRefreshType == 2)
         {
            if(this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate < this.FCurRefreshCost)
            {
               this.FUIWindowRecharge.Visible = true;
               return;
            }
         }
         if(this.FCurRefreshType == 2)
         {
            if(!this.FUIWindowConfirmation.IsSelected)
            {
               _loc2_ = STRING_TREASUREMAP.STRING_RefreshCostSure;
               _loc2_ = _loc2_.split("%count%").join(this.FCurRefreshCost);
               this.FUIWindowConfirmation.Text = _loc2_;
               this.FUIWindowConfirmation.OnOK = this.OnRefreshMapSure;
               this.FUIWindowConfirmation.visible = true;
            }
            else
            {
               this.OnRefreshMapSure(this);
            }
         }
         else
         {
            this.OnRefreshMapSure(this);
         }
      }
      
      protected function OnRefreshMapMouseMove(param1:MouseEvent) : void
      {
         if(this.FOnHintOnOver != null)
         {
            this.FOnHintOnOver(this,this.FHintBtnRefresh);
         }
      }
      
      protected function OnRefreshMapMouseOut(param1:MouseEvent) : void
      {
         if(this.FOnHintOnOut != null)
         {
            this.FOnHintOnOut(this);
         }
      }
      
      protected function OnOpenMap(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:uint = 0;
         var _loc4_:TDigging = null;
         var _loc5_:String = null;
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc3_ = uint(int(String(param1.currentTarget.parent.parent.name).slice(7)));
         _loc4_ = this.FDiggingBins.GetDatebaseByIndex(_loc3_) as TDigging;
         if(!_loc4_.Isgold)
         {
            if(this.FOnEffectText != null)
            {
               this.FOnEffectText(STRING_TREASUREMAP.STRING_CanNotOpen);
            }
            return;
         }
         if(this.FVipData.VipLevel < _loc4_.Viplevel)
         {
            if(this.FOnEffectText != null)
            {
               this.FOnEffectText(STRING_COMMON.NOTENOUGH_Vip);
            }
            return;
         }
         if(this.FCharacter.CreditGold < _loc4_.OpenCost[0].amount && this.FCharacter.CreditGiftCertificate < _loc4_.OpenCost[0].amount)
         {
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         _loc5_ = STRING_TREASUREMAP.STRING_OpenCostSure;
         _loc5_ = _loc5_.split("%count%").join(_loc4_.OpenCost[0].amount);
         _loc5_ = _loc5_.split("%name%").join(_loc4_.Name);
         this.FOpenMapId = _loc4_.Identifier;
         this.FUIWindowConfirmationForDirectOpenBtn.Text = _loc5_;
         this.FUIWindowConfirmationForDirectOpenBtn.OnOK = this.OnOpenMapSure;
         if(this.FUIWindowConfirmationForDirectOpenBtn.IsSelected)
         {
            this.OnOpenMapSure(null);
         }
         else
         {
            this.FUIWindowConfirmationForDirectOpenBtn.visible = true;
         }
      }
      
      override public function get Visible() : Boolean
      {
         if(this.FScene == null)
         {
            return false;
         }
         return this.FScene.visible;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         if(this.FScene == null)
         {
            return;
         }
         this.FScene.visible = param1;
         if(Boolean(this.FTreasureMapData) && this.FTreasureMapData.TreasureStatus)
         {
            TGameUtil.setButtonMode(this.FScene.btn_start,false);
            TGameUtil.setButtonMode(this.FScene.btn_refresh,false);
         }
      }
      
      public function get OnCanDig() : Function
      {
         return this.FOnCanDig;
      }
      
      public function set OnCanDig(param1:Function) : void
      {
         this.FOnCanDig = param1;
      }
      
      public function get OpenGame() : Function
      {
         return this.FOpenGame;
      }
      
      public function set OpenGame(param1:Function) : void
      {
         this.FOpenGame = param1;
      }
      
      public function get OnApplianceOnOver() : Function
      {
         return this.FOnApplianceOnOver;
      }
      
      public function set OnApplianceOnOver(param1:Function) : void
      {
         this.FOnApplianceOnOver = param1;
      }
      
      public function get OnApplianceOnOut() : Function
      {
         return this.FOnApplianceOnOut;
      }
      
      public function set OnApplianceOnOut(param1:Function) : void
      {
         this.FOnApplianceOnOut = param1;
      }
      
      public function get OnHintOnOver() : Function
      {
         return this.FOnHintOnOver;
      }
      
      public function set OnHintOnOver(param1:Function) : void
      {
         this.FOnHintOnOver = param1;
      }
      
      public function get OnHintOnOut() : Function
      {
         return this.FOnHintOnOut;
      }
      
      public function set OnHintOnOut(param1:Function) : void
      {
         this.FOnHintOnOut = param1;
      }
      
      public function get OnEffectText() : Function
      {
         return this.FOnEffectText;
      }
      
      public function set OnEffectText(param1:Function) : void
      {
         this.FOnEffectText = param1;
      }
      
      public function set TutorialNextStep(param1:Function) : void
      {
         this.FTutorialNextStep = param1;
      }
      
      public function SetTreasureMapData(param1:TTreasureMapData) : void
      {
         this.FTreasureMapData = param1;
         this.UpdataUI();
      }
      
      public function UpdataBitmp() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FUISlots.length)
         {
            this.FUISlots[_loc1_].Update();
            _loc1_++;
         }
      }
      
      public function SetBtnEnable(param1:Boolean) : void
      {
         this.FScene.btn_refresh.mouseEnabled = param1;
      }
   }
}

