package Processors.Game.Lobby.Campaign
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
   import Logics.Items.*;
   import Logics.Streamization.Inventories.*;
   import Logics.Streamization.Items.*;
   import Logics.Vip.*;
   import Processors.Game.*;
   import Processors.Game.Lobby.Common.*;
   import Rendering.Overlayers.*;
   import Rendering.Overlayers.Hints.*;
   import Rendering.Overlayers.Inventories.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TPassNodalWindow extends TProcessorLobbyWindow
   {
      
      protected static const MAX_ITEM_COUNT:uint = 4;
      
      public static const PASSTYPE_NODAL:int = CONST_BATTLE.BattleType_Nodal;
      
      public static const PASSTYPE_FB:int = CONST_BATTLE.BattleType_Camp;
      
      public static const PASSTYPE_KILLHERO:int = CONST_BATTLE.BattleType_KillHero;
      
      protected static const RESOURCESSTATE_Request:int = 0;
      
      protected static const RESOURCESSTATE_Wait:int = 1;
      
      protected static const RESOURCESSTATE_Dispatch:int = 2;
      
      protected static const STAR_COUNT:int = 5;
      
      protected static const BOX_COUNT:int = 3;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const Status_Init:uint = 0;
      
      public static const Status_CanGet:uint = 1;
      
      public static const Status_CanReturn:uint = 2;
      
      private var FReturnCityFun:Function;
      
      private var FPassType:int;
      
      private var FPassNodalId:uint;
      
      private var FStarCount:int;
      
      private var FScene:MovieClip;
      
      protected var FLookCost:uint;
      
      protected var FCharacter:TCharacter;
      
      protected var FVipData:TVip;
      
      protected var FRewards:Vector.<TItems>;
      
      protected var UnstreamizerRewards:TUnstreamizerRewards;
      
      protected var FSelectIndex:int;
      
      protected var FArticleBins:TBins;
      
      protected var FIsInWorldMap:Boolean;
      
      protected var FStarIndex:uint;
      
      protected var FStatus:uint;
      
      protected var FIDTemplates:Vector.<uint>;
      
      protected var FQualityTemplates:Vector.<uint>;
      
      protected var FInventories:TInventories;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FHintLookAt:THint;
      
      protected var FHintStar:THint;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FModuleId:uint;
      
      protected var FEffectGenerateTextByErrorCode:Function;
      
      public function TPassNodalWindow(param1:TUIComponent, param2:uint, param3:Boolean = true)
      {
         var _loc4_:TConfigValue = null;
         super(param1);
         this.FModuleId = param2;
         this.FIsInWorldMap = param3;
         this.FRewards = new Vector.<TItems>(BOX_COUNT);
         this.UnstreamizerRewards = new TUnstreamizerRewards();
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FIDTemplates = new Vector.<uint>(BOX_COUNT);
         this.FQualityTemplates = new Vector.<uint>(BOX_COUNT);
         this.FInventories = new TInventories();
         this.FHintStar = new THint();
         this.FHintLookAt = new THint();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FCharacter = SLogicsCore.Character;
         this.FVipData = this.FCharacter.VipData;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SINGLE_CHEST_GOLD) as TConfigValue;
         this.FLookCost = _loc4_.Value.amount as uint;
         this.FStatus = Status_Init;
      }
      
      protected static function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TInventory = null;
         if(param2 is TInventory)
         {
            _loc4_ = param2 as TInventory;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Hurdle_QueryChestRet,this.PacketPerform_SC_LookBoxInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_Hurdle_ReceiveChestRet,this.PacketPerform_SC_GetBoxInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_WorldMap_QueryChestRet,this.PacketPerform_SC_LookBoxInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_WorldMap_ReceiveChestRet,this.PacketPerform_SC_GetBoxInfo);
      }
      
      protected function PacketPerform_SC_LookBoxInfo(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TItems = null;
         var _loc6_:uint = 0;
         _loc3_ = 0;
         while(_loc3_ < BOX_COUNT)
         {
            _loc5_ = this.FRewards[_loc3_];
            if(_loc5_ == null)
            {
               _loc5_ = new TItems();
               this.FRewards[_loc3_] = _loc5_;
            }
            else
            {
               _loc5_.Clear();
            }
            _loc3_++;
         }
         _loc2_ = param1.Data;
         _loc6_ = _loc2_.readUnsignedInt();
         if(_loc6_ != 0)
         {
            if(this.FEffectGenerateTextByErrorCode != null)
            {
               this.FEffectGenerateTextByErrorCode(_loc6_);
            }
            return;
         }
         _loc4_ = _loc2_.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FRewards[_loc3_];
            this.UnstreamizerRewards.Unstreamize(_loc2_,_loc5_,null);
            this.FRewards[_loc3_] = _loc5_;
            _loc3_++;
         }
         this.ShowReward(true);
      }
      
      protected function PacketPerform_SC_GetBoxInfo(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TItems = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < BOX_COUNT)
         {
            _loc5_ = this.FRewards[_loc3_];
            if(_loc5_ == null)
            {
               _loc5_ = new TItems();
               this.FRewards[_loc3_] = _loc5_;
            }
            else
            {
               _loc5_.Clear();
            }
            _loc3_++;
         }
         _loc2_ = param1.Data;
         _loc6_ = _loc2_.readUnsignedInt();
         if(_loc6_ != 0)
         {
            if(this.FEffectGenerateTextByErrorCode != null)
            {
               this.FEffectGenerateTextByErrorCode(_loc6_);
            }
            return;
         }
         _loc7_ = uint(_loc2_.readByte());
         _loc4_ = _loc2_.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FRewards[_loc3_];
            this.UnstreamizerRewards.Unstreamize(_loc2_,_loc5_,null);
            this.FRewards[_loc3_] = _loc5_;
            _loc3_++;
         }
         this.ShowReward();
         TutorialNextStep(305);
         this.FScene.mc_passReward.mc_passReward.btn_lookat.visible = false;
         if(!hasEventListener(MouseEvent.MOUSE_DOWN))
         {
            addEventListener(MouseEvent.MOUSE_DOWN,this.OnReturnCity);
         }
         _loc4_ = _loc2_.readShort();
         if(_loc4_ > 0)
         {
            this.FScene.mc_passReward.mc_passReward.MC_AddItem.visible = true;
            _loc3_ = int(_loc2_.readUnsignedInt());
            this.FScene.mc_passReward.mc_passReward.MC_AddItem.MC_Icon.gotoAndStop(_loc3_);
            this.FScene.mc_passReward.mc_passReward.MC_AddItem.TF_Num.text = "*" + _loc2_.readUnsignedInt();
         }
         else
         {
            this.FScene.mc_passReward.mc_passReward.MC_AddItem.visible = false;
         }
      }
      
      protected function InitPassNodalWindow() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         _loc4_ = "";
         if(this.FScene == null)
         {
            this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_CAMPAIGN.RESOURCE_ClassName_Bonus) as MovieClip;
            addChild(this.FScene);
            _loc1_ = 0;
            while(_loc1_ < BOX_COUNT)
            {
               _loc2_ = this.FScene.mc_passReward.mc_passReward["mc_box_" + _loc1_];
               if(_loc2_)
               {
                  TGameUtil.setButtonMode(_loc2_,true);
                  _loc2_.addEventListener(MouseEvent.MOUSE_DOWN,this.OnGetReward);
               }
               _loc1_++;
            }
            this.FScene.mc_star.addEventListener(MouseEvent.MOUSE_MOVE,this.Btn_StarOnMove);
            this.FScene.mc_star.addEventListener(MouseEvent.MOUSE_OUT,this.Btn_OnOut);
            this.FHintStar.Caption = STRING_BATTLE.STRINGS_StartBtnTip;
            this.FOverlayerAppliance = new TOverlayerAppliance(this,this.FModuleId);
            this.FOverlayerAppliance.Visible = false;
            this.FOverlayerHint = new TOverlayerHint(this);
            this.FOverlayerHint.visible = false;
            TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
            TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         }
         this.FStarIndex = 1;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc2_ = this.FScene.mc_passReward.mc_passReward["mc_box_" + _loc1_];
            if(_loc2_)
            {
               _loc2_.gotoAndStop(2);
               _loc2_.gotoAndStop(1);
               _loc2_.buttonMode = true;
               _loc2_.mc_rewardInfo.mouseEnabled = false;
               _loc2_.mc_rewardInfo.visible = false;
               _loc2_.mc_reward_fb.mc_reward_fb.tf_rewardInfo.mouseEnabled = false;
               _loc2_.mc_reward_fb.visible = false;
            }
            _loc1_++;
         }
         this.FScene.mc_title.mc_title.gotoAndStop(this.FStarCount);
         _loc3_ = this.FScene.mc_passReward.mc_passReward.btn_lookat;
         if(_loc3_)
         {
            _loc3_.visible = Boolean(PASSTYPE_FB == this.FPassType);
            if(!_loc3_.hasEventListener(MouseEvent.CLICK))
            {
               TGameUtil.setButtonMode(_loc3_,true);
               _loc3_.addEventListener(MouseEvent.CLICK,this.OnLookAtBoxs);
               _loc3_.addEventListener(MouseEvent.MOUSE_MOVE,this.Btn_LookAtOnMove);
               _loc3_.addEventListener(MouseEvent.ROLL_OUT,this.Btn_OnOut);
            }
            if(this.FVipData.FreeLook)
            {
               _loc5_ = STRING_BATTLE.STRINGS_LookAtBoxFreeTip;
            }
            else
            {
               _loc5_ = STRING_BATTLE.STRINGS_LookAtBoxTip;
               _loc5_ = _loc5_.split("%count%").join(this.FLookCost);
            }
            this.FHintLookAt.Caption = _loc5_;
         }
         this.FStatus = Status_CanGet;
         this.FScene.tf_turnbackTip.visible = false;
         this.FScene.tf_turnbackTip.stop();
         this.FScene.mc_passReward.mc_passReward.MC_AddItem.visible = false;
         this.InitSlot();
      }
      
      protected function InitSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUISlot = null;
         if(this.FUISlots != null)
         {
            return;
         }
         this.FUISlots = new Vector.<TUISlot>(BOX_COUNT);
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc2_ = this.GetSlot();
            _loc2_.Resource = this.FScene.mc_passReward.mc_passReward["mc_box_" + _loc1_].mc_reward_fb.mc_reward_fb.mc_slot;
            _loc2_.Init();
            this.FUISlots[_loc1_] = _loc2_;
            _loc1_++;
         }
      }
      
      protected function GetSlot() : TUISlot
      {
         var _loc1_:TUISlot = null;
         _loc1_ = new TUISlot(this);
         _loc1_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         _loc1_.OnOverlay = this.UIComponentsApplianceOnOver;
         _loc1_.OnOut = this.UIComponentsApplianceOnOut;
         _loc1_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         _loc1_.OnQuerySubscript = SlotsOnQuerySubscript;
         return _loc1_;
      }
      
      protected function PlayStarMovie() : void
      {
         this.FScene.mc_star["star_" + this.FStarIndex].gotoAndPlay(2);
         this.FScene.mc_star["star_" + this.FStarIndex].visible = this.FStarIndex <= this.FStarCount;
         if(this.FStarIndex < STAR_COUNT)
         {
            setTimeout(this.PlayStarMovie,100);
            ++this.FStarIndex;
         }
      }
      
      protected function ShowReward(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TArticle = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TInventory = null;
         var _loc9_:uint = 0;
         var _loc10_:int = 0;
         _loc4_ = "";
         this.FIDTemplates.length = 0;
         this.FQualityTemplates.length = 0;
         var _loc8_:int = 2;
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            _loc6_ = this.FScene.mc_passReward.mc_passReward["mc_box_" + _loc2_];
            if(_loc6_ != null)
            {
               _loc6_.buttonMode = param1;
               _loc6_.mc_rewardInfo.mouseEnabled = true;
               _loc6_.mouseChildren = true;
               if(!param1)
               {
                  if(_loc2_ == this.FSelectIndex)
                  {
                     _loc6_.gotoAndStop(4);
                  }
                  else
                  {
                     _loc6_.gotoAndStop(5);
                  }
               }
               if(this.FPassType == PASSTYPE_NODAL)
               {
                  _loc6_.mc_reward_fb.visible = false;
                  _loc6_.mc_rewardInfo.visible = true;
                  _loc6_.mc_rewardInfo.mc_rewardInfo.mc_item_0.tf_name.text = STRING_COMMON.ITEMNAME_Exp + ":";
                  _loc9_ = this.FRewards[_loc2_].Exp;
                  _loc10_ = int(SLogicsCore.KaguyaData.GetExpByExp(this.FRewards[_loc2_].Exp));
                  _loc6_.mc_rewardInfo.mc_rewardInfo.mc_item_0.tf_count.text = _loc9_ - _loc10_;
                  if(SLogicsCore.KaguyaData.OpenState == 0 || SLogicsCore.KaguyaData.IsLongTime == 7 || SLogicsCore.KaguyaData.CurLevel <= 1)
                  {
                     _loc6_.mc_rewardInfo.mc_rewardInfo.mc_item_1.tf_name.text = STRING_COMMON.ITEMNAME_Coin + ":";
                     _loc6_.mc_rewardInfo.mc_rewardInfo.mc_item_1.tf_count.text = this.FRewards[_loc2_].Money;
                  }
                  else
                  {
                     _loc8_ = 3;
                     _loc6_.mc_rewardInfo.mc_rewardInfo.mc_item_1.tf_name.text = STRING_COMMON.ITEMNAME_Exp_huiye + ":";
                     _loc6_.mc_rewardInfo.mc_rewardInfo.mc_item_1.tf_count.text = "" + _loc10_;
                     _loc6_.mc_rewardInfo.mc_rewardInfo.mc_item_2.tf_name.text = STRING_COMMON.ITEMNAME_Coin + ":";
                     _loc6_.mc_rewardInfo.mc_rewardInfo.mc_item_2.tf_count.text = this.FRewards[_loc2_].Money;
                  }
                  _loc6_.mc_rewardInfo.gotoAndPlay(1);
                  _loc3_ = 0;
                  while(_loc3_ < this.FRewards[_loc2_].ItemIDs.length)
                  {
                     if(_loc6_.mc_rewardInfo.mc_rewardInfo["mc_item_" + (_loc3_ + _loc8_)])
                     {
                        _loc6_.mc_rewardInfo.mc_rewardInfo["mc_item_" + (_loc3_ + _loc8_)].visible = true;
                        if(this.FRewards[_loc2_].ItemIDs[_loc3_].Type == 3)
                        {
                           _loc6_.mc_rewardInfo.mc_rewardInfo["mc_item_" + (_loc3_ + _loc8_)].tf_name.text = STRING_COMMON.ITEMNAME_Military + ":";
                           _loc6_.mc_rewardInfo.mc_rewardInfo["mc_item_" + (_loc3_ + _loc8_)].tf_count.text = this.FRewards[_loc2_].ItemIDs[_loc3_].Count;
                        }
                        else if(this.FRewards[_loc2_].ItemIDs[_loc3_].Type == 0)
                        {
                           _loc6_.mc_rewardInfo.mc_rewardInfo["mc_item_" + (_loc3_ + _loc8_)].tf_name.text = STRING_COMMON.ITEMNAME_Vouchers + ":";
                           _loc6_.mc_rewardInfo.mc_rewardInfo["mc_item_" + (_loc3_ + _loc8_)].tf_count.text = this.FRewards[_loc2_].ItemIDs[_loc3_].Count;
                        }
                        else
                        {
                           _loc5_ = this.FArticleBins.GetDatebaseByIdentifier(this.FRewards[_loc2_].ItemIDs[_loc3_].ID) as TArticle;
                           _loc6_.mc_rewardInfo.mc_rewardInfo["mc_item_" + (_loc3_ + _loc8_)].tf_name.text = _loc5_.Name + ":";
                           _loc6_.mc_rewardInfo.mc_rewardInfo["mc_item_" + (_loc3_ + _loc8_)].tf_count.text = this.FRewards[_loc2_].ItemIDs[_loc3_].Count;
                        }
                     }
                     _loc3_++;
                  }
                  _loc3_ += _loc8_;
                  while(_loc3_ < MAX_ITEM_COUNT)
                  {
                     if(_loc6_.mc_rewardInfo.mc_rewardInfo["mc_item_" + _loc3_])
                     {
                        _loc6_.mc_rewardInfo.mc_rewardInfo["mc_item_" + _loc3_].visible = false;
                     }
                     _loc3_++;
                  }
               }
               else
               {
                  _loc6_.mc_reward_fb.visible = true;
                  _loc6_.mc_rewardInfo.visible = false;
                  _loc4_ = STRING_COMMON.ITEMNAME_Exp + ":" + this.FRewards[_loc2_].Exp + "\n";
                  _loc4_ = _loc4_ + (STRING_COMMON.ITEMNAME_Coin + ":" + this.FRewards[_loc2_].Money + "\n");
                  _loc6_.mc_reward_fb.gotoAndPlay(1);
                  _loc3_ = 0;
                  while(_loc3_ < this.FRewards[_loc2_].ItemIDs.length)
                  {
                     if(this.FRewards[_loc2_].ItemIDs[_loc3_].Type != 3)
                     {
                        this.FIDTemplates.push(this.FRewards[_loc2_].ItemIDs[_loc3_].ID);
                        this.FQualityTemplates.push(this.FRewards[_loc2_].ItemIDs[_loc3_].Count);
                     }
                     else
                     {
                        _loc4_ += STRING_COMMON.ITEMNAME_Military + ":" + this.FRewards[_loc2_].ItemIDs[_loc3_].Count + "\n";
                     }
                     _loc3_++;
                  }
                  _loc6_.mc_reward_fb.mc_reward_fb.tf_rewardInfo.text = String(_loc4_);
               }
            }
            _loc2_++;
         }
         this.FInventories.Clear();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,this.FIDTemplates);
         _loc2_ = 0;
         while(_loc2_ < this.FInventories.Count)
         {
            _loc7_ = this.FInventories.GetInventoryByIndex(_loc2_);
            _loc7_.Quantity = this.FQualityTemplates[_loc2_];
            this.FUISlots[_loc2_].Context = _loc7_;
            _loc2_++;
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,this.FModuleId);
         }
      }
      
      protected function UIComponentsApplianceOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
            case CATEGORY_Treasure:
               break;
            default:
               _loc4_ = this.FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function UIComponentsApplianceOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
            case CATEGORY_Treasure:
               break;
            default:
               _loc4_ = this.FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
      }
      
      protected function Btn_StarOnMove(param1:MouseEvent) : void
      {
         this.FOverlayerHint.Context = this.FHintStar;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.visible = true;
      }
      
      protected function Btn_LookAtOnMove(param1:MouseEvent) : void
      {
         this.FOverlayerHint.Context = this.FHintLookAt;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.visible = true;
      }
      
      protected function Btn_OnOut(param1:MouseEvent) : void
      {
         this.FOverlayerHint.visible = false;
      }
      
      protected function OnGetReward(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FStatus != Status_CanGet)
         {
            return;
         }
         this.FStatus = Status_CanReturn;
         if(Boolean(param1) && Boolean(param1.currentTarget))
         {
            this.FSelectIndex = int(String(param1.currentTarget.name).slice(7));
         }
         else
         {
            this.FSelectIndex = int(Math.random() * 3);
         }
         if(this.FIsInWorldMap)
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LOBBY_WorldMap_ReceiveChest);
         }
         else
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LOBBY_Hurdle_ReceiveChest);
         }
         _loc3_ = _loc2_.Data;
         _loc3_.writeByte(this.FSelectIndex);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         TutorialNextStep(304);
         this.FScene.tf_turnbackTip.visible = true;
         this.FScene.tf_turnbackTip.play();
      }
      
      protected function OnLookAtBoxs(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         if(!this.FVipData.FreeLook)
         {
            if(this.FLookCost > this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate)
            {
               EffectGenerateText(STRING_COMMON.NOTENOUGH_Gold);
               return;
            }
         }
         if(this.FIsInWorldMap)
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LOBBY_WorldMap_QueryChest);
         }
         else
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LOBBY_Hurdle_QueryChest);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.FScene.mc_passReward.mc_passReward.btn_lookat.visible = false;
      }
      
      protected function OnReturnCity(param1:MouseEvent) : void
      {
         if(this.FStatus != Status_CanReturn)
         {
            return;
         }
         this.FStatus = Status_Init;
         visible = false;
         TutorialNextStep(306);
         if(this.FReturnCityFun != null)
         {
            this.FReturnCityFun(this);
         }
         if(hasEventListener(MouseEvent.MOUSE_DOWN))
         {
            removeEventListener(MouseEvent.MOUSE_DOWN,this.OnReturnCity);
         }
      }
      
      public function get EffectGenerateTextByErrorCode() : Function
      {
         return this.FEffectGenerateTextByErrorCode;
      }
      
      public function set EffectGenerateTextByErrorCode(param1:Function) : void
      {
         this.FEffectGenerateTextByErrorCode = param1;
      }
      
      public function SetPassNodalWindow(param1:int, param2:uint, param3:int, param4:Function = null) : void
      {
         this.FPassType = param1;
         this.FPassNodalId = param2;
         this.FStarCount = param3;
         this.FReturnCityFun = param4;
         this.FSelectIndex = -1;
         this.InitPassNodalWindow();
         if(Parent != null)
         {
            Parent.addChild(this);
         }
      }
      
      public function ShowWindows() : void
      {
         if(visible == true)
         {
            return;
         }
         visible = true;
         this.FScene.gotoAndPlay(1);
         this.FScene.mc_passReward.gotoAndPlay(1);
         this.FScene.mc_star.gotoAndPlay(1);
         this.FScene.mc_title.gotoAndPlay(1);
         this.FScene.mc_bg.gotoAndPlay(1);
         this.PlayStarMovie();
      }
      
      public function UpdataSlot() : void
      {
         var _loc1_:uint = 0;
         if(visible == false)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FUISlots.length)
         {
            this.FUISlots[_loc1_].Update();
            _loc1_++;
         }
      }
   }
}

