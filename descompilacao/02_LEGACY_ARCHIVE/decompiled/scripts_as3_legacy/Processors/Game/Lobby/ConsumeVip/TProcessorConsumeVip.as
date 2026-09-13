package Processors.Game.Lobby.ConsumeVip
{
   import Components.Pages.TUIPage;
   import Components.Slots.TUISlot;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.ConsumeVip.TConsumeVipData;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TConsumeVip;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.ConsumeVip.TUnstreamizerConsumeVip;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowPetDesc;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONSUMEVIP;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.Cubic;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorConsumeVip extends TProcessorLobbyWindows
   {
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorWindowPetDesc:TProcessorWindowPetDesc;
      
      protected var MC_VipLv:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FTF_CurrentLevel:TextField;
      
      protected var FTF_CurrentLevelRight:TextField;
      
      protected var FTF_CostMoney:TextField;
      
      protected var FTF_NextLevel:TextField;
      
      protected var FTF_EXP:TextField;
      
      protected var MC_EXP:MovieClip;
      
      protected var FMC_EXPBar:MovieClip;
      
      protected var FBTN_ShowRecruit:MovieClip;
      
      protected var FCurrentExp:int = -1;
      
      protected var MC_BGImg:Bitmap;
      
      protected var FBTN_buy:MovieClip;
      
      protected var FBTN_Reward:MovieClip;
      
      protected var FBTN_DailyAward:MovieClip;
      
      protected var FTF_Todaybuy:TextField;
      
      protected var FTF_Price:TextField;
      
      protected var FTF_ItemName:TextField;
      
      protected var FTF_VipLevel:TextField;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FUIItemSlot:TUISlot;
      
      protected var FUISlotList:TUIShowItem;
      
      protected var FCurConsumeVip:TConsumeVip;
      
      protected var FirstInitial:Boolean;
      
      protected var FUnstreamizerConsumeVip:TUnstreamizerConsumeVip;
      
      protected var FConsumeVipData:TConsumeVipData;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FCharacter:TCharacter;
      
      protected var FOnInitConsumeVip:Function;
      
      protected var FOnEffectBaseGlowVIP:Function;
      
      protected var FHint:THint;
      
      public function TProcessorConsumeVip(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (stage.stageWidth - 390) / 2;
         this.FProcessorWindowRecruit.y = (stage.stageHeight - 358) / 2;
         this.FProcessorWindowRecruit.Load();
         this.FProcessorWindowPetDesc = new TProcessorWindowPetDesc(this.Parent);
         this.FProcessorWindowPetDesc.x = (stage.stageWidth - 390) / 2;
         this.FProcessorWindowPetDesc.y = (stage.stageHeight - 358) / 2;
         this.FProcessorWindowPetDesc.Load();
         this.FUnstreamizerConsumeVip = new TUnstreamizerConsumeVip();
         this.FConsumeVipData = SLogicsCore.ConsumeVipData;
         this.FCharacter = SLogicsCore.Character;
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FHint = new THint();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_CONSUMEVIP.RESOURCESID_Swf_ConsumeVip);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:MovieClip = null;
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_CONSUMEVIP.RESOURCES_ClassName_ConsumeVip) as MovieClip;
         addChild(_loc1_);
         _loc1_.x = FUICore.StageWidth - _loc1_.width >> 1;
         _loc1_.y = FUICore.StageHeight - _loc1_.height >> 1;
         this.FTF_CurrentLevel = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_TF_CurrentLevel];
         this.FTF_CurrentLevelRight = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_TF_CurrentLevelRight];
         this.FTF_NextLevel = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_TF_NextLevel];
         this.FTF_CostMoney = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_TF_CostMoney];
         this.FTF_EXP = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_TF_EXP];
         this.MC_EXP = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_MC_EXP];
         this.FMC_EXPBar = this.MC_EXP[CONST_CONSUMEVIP.RESOURCE_Link_MC_EXPBar];
         this.FMC_EXPBar.x = 0 - this.FMC_EXPBar.width;
         this.MC_BGImg = new Bitmap();
         _loc1_["pos"].addChild(this.MC_BGImg);
         this.MC_VipLv = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_MC_VipLv];
         this.MC_VipLv.gotoAndStop(1);
         this.FTF_VipLevel = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_TF_VipLevel];
         this.FTF_Todaybuy = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_TF_Todaybuy];
         this.FTF_Price = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_TF_Price];
         this.FTF_ItemName = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_TF_ItemName];
         this.FUISlotList = new TUIShowItem(this,CONST_CONSUMEVIP.CAPACITY_ItemSlot);
         this.FUISlotList.Perform_UIDispatch(_loc1_);
         this.FUISlotList.OnOverlay = UIComponentsHintOnOver;
         this.FUISlotList.OnOut = UIComponentsHintOnOut;
         this.FUIItemSlot = new TUISlot(this);
         this.FUIItemSlot.Resource = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_MC_Slot];
         this.FUIItemSlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FUIItemSlot.OnQuerySequenceContext = this.OnQuerySequenceContext;
         this.FUIItemSlot.OnQuerySubscript = this.OnQuerySubscript;
         this.FUIItemSlot.OnOverlay = UIComponentsHintOnOver;
         this.FUIItemSlot.OnOut = UIComponentsHintOnOut;
         this.FUIItemSlot.Init();
         this.FUIPage = new TUIPage(this);
         this.FUIPage.ButtonNext.Substrate = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_BTN_Right];
         this.FUIPage.ButtonPrevious.Substrate = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_BTN_Left];
         this.FUIPage.OnChangePage = this.OnPageChangeHandlder;
         this.FUIPage.PageSize = 1;
         this.FUIPage.TotalQuantity = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConsumeVip).Count;
         this.FUIPage.Init();
         this.FUIPage.Reset();
         this.FBTN_ShowRecruit = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_BTN_ShowRecruit];
         TGameUtil.setButtonMode(this.FBTN_ShowRecruit,true);
         this.FBTN_ShowRecruit.visible = false;
         this.FBTN_DailyAward = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_BTN_DailyAward];
         this.FBTN_Help = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_BTN_Help];
         this.FBTN_Close = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_BTN_Close];
         this.FBTN_Reward = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_BTN_Reward];
         TGameUtil.setButtonMode(this.FBTN_Reward,true);
         this.FBTN_buy = _loc1_[CONST_CONSUMEVIP.RESOURCE_Link_BTN_Buy];
         TGameUtil.setButtonMode(this.FBTN_buy,true);
         _loc1_.buttonMode = false;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseBtnClick);
         this.FBTN_Reward.addEventListener(MouseEvent.CLICK,this.OnClickGetReward);
         this.FBTN_buy.addEventListener(MouseEvent.CLICK,this.OnClickBuy);
         this.FBTN_DailyAward.addEventListener(MouseEvent.CLICK,this.OnClickGetReward);
         this.FBTN_DailyAward.addEventListener(MouseEvent.MOUSE_MOVE,this.OnBtnMouseMove);
         this.FBTN_DailyAward.addEventListener(MouseEvent.MOUSE_OUT,this.OnBtnMouseOut);
         this.FBTN_ShowRecruit.addEventListener(MouseEvent.CLICK,this.OnShowRecruit);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ConsumeVip_InfoRet,this.PerformPacket_SC_ConsumeVip_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ConsumeVip_BuyRet,this.PerformPacket_SC_ConsumeVip_Buy);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ConsumeVip_AwardRet,this.PerformPacket_SC_ConsumeVip_Award);
      }
      
      protected function PerformPacket_SC_ConsumeVip_Info(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerConsumeVip.Unstreamize(_loc2_,this.FConsumeVipData,null);
         if(this.FOnInitConsumeVip != null)
         {
            this.FOnInitConsumeVip(this);
         }
         if(this.FOnEffectBaseGlowVIP != null)
         {
            this.FOnEffectBaseGlowVIP(this,this.FConsumeVipData.DailyAward);
         }
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.UpdateInterface();
      }
      
      protected function PerformPacket_SC_ConsumeVip_Buy(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         EffectGenerateText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
         this.PacketPerform_CS_ConsumeVip_Info();
      }
      
      protected function PerformPacket_SC_ConsumeVip_Award(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         EffectGenerateText(STRING_BASEACTIVITY.FORMAT_GET);
         this.PacketPerform_CS_ConsumeVip_Info();
      }
      
      protected function PacketPerform_CS_ConsumeVip_Info() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ConsumeVip_InfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_ConsumeVip_Award(param1:int, param2:int = 0) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ConsumeVip_AwardReq);
         _loc3_.Data.writeUnsignedInt(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function PacketPerform_CS_ConsumeVip_Buy(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ConsumeVip_BuyReq);
         _loc3_.Data.writeUnsignedInt(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FUISlotList)
         {
            this.FUISlotList.LogicsPerform();
         }
         if(this.FUIItemSlot)
         {
            this.FUIItemSlot.Update();
         }
         if(Boolean(this.FProcessorWindowRecruit) && this.FProcessorWindowRecruit.Visible)
         {
            this.FProcessorWindowRecruit.UpdataBitmap();
         }
         if(Boolean(this.FProcessorWindowPetDesc) && this.FProcessorWindowPetDesc.Visible)
         {
            this.FProcessorWindowPetDesc.UpdataBitmap();
         }
      }
      
      protected function UpdateProgressBarExp(param1:uint, param2:uint) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this.FTF_EXP.text = param1 + "/" + param2;
         _loc3_ = param1 / param2;
         if(_loc3_ > 1)
         {
            _loc3_ = 1;
         }
         _loc4_ = this.FMC_EXPBar.width * _loc3_;
         _loc5_ = this.FMC_EXPBar.x;
         _loc6_ = 0 - (this.FMC_EXPBar.width - _loc4_);
         TweenUtil.to(this.FMC_EXPBar,1000,{
            "x":_loc6_,
            "ease":Cubic.easeInOut,
            "onComplete":this.onMoveComplete
         });
      }
      
      protected function onMoveComplete() : void
      {
         TweenUtil.removeTween(this.FMC_EXPBar);
      }
      
      protected function UpdateInterface() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.FCurConsumeVip = this.CurConsumeVip;
         if(!this.FirstInitial)
         {
            this.FPageIndex = this.FCurConsumeVip.Identifier - 1;
            this.FirstInitial = true;
         }
         var _loc1_:int = this.NextConsumeVip.ConsumeCount < this.FConsumeVipData.ConsumeMoney ? 0 : int(this.NextConsumeVip.ConsumeCount - this.FConsumeVipData.ConsumeMoney);
         this.FTF_CostMoney.text = _loc1_ + STRING_COMMON.ITEMNAME_Gold;
         this.FTF_CurrentLevel.text = String(this.FCurConsumeVip.Identifier);
         this.FTF_CurrentLevelRight.text = String(this.FCurConsumeVip.Identifier);
         this.FTF_NextLevel.text = String(this.NextConsumeVip.Identifier);
         this.MC_BGImg.bitmapData = TUtilityReflection.CreateInstance("ConsumeVip_backImg_" + this.FPageIndex);
         this.MC_VipLv.gotoAndStop(this.FPageIndex + 1);
         this.FUIPage.PageIndex = this.FPageIndex;
         _loc2_ = this.FConsumeVipData.ConsumeMoney - this.CurConsumeVip.ConsumeCount;
         _loc3_ = this.NextConsumeVip.ConsumeCount - this.CurConsumeVip.ConsumeCount;
         if(this.FCurrentExp != _loc2_)
         {
            this.UpdateProgressBarExp(_loc2_,_loc3_);
            this.FCurrentExp = _loc2_;
         }
         this.UpdateItemSlotList();
         this.upButtonState();
      }
      
      protected function UpdateItemSlotList() : void
      {
         var _loc1_:TInventories = null;
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TConsumeVip = null;
         var _loc6_:TSystemLanguage = null;
         var _loc7_:TInventories = null;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,80002362) as TSystemLanguage;
         _loc1_ = new TInventories();
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConsumeVip,this.FPageIndex + 1) as TConsumeVip;
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc1_,_loc5_.IDTemplates);
         _loc3_ = _loc1_.Count;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _loc1_.GetInventoryByIndex(_loc4_);
            _loc2_.Quantity = _loc5_.Quantitys[_loc4_];
            _loc4_++;
         }
         this.FUISlotList.UpdateUI(_loc1_);
         _loc7_ = new TInventories();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc7_,Vector.<uint>([_loc5_.DailyItemId]));
         _loc2_ = _loc7_.GetInventoryByIndex(0);
         _loc2_.Quantity = _loc5_.Quantity;
         this.FUIItemSlot.Context = _loc2_;
         this.FBTN_ShowRecruit.visible = _loc5_.Heroid > 0;
         this.FTF_ItemName.text = _loc2_.Name;
         this.FTF_VipLevel.text = String(_loc5_.Identifier);
         this.FTF_Todaybuy.text = _loc5_.Daybuy > 0 ? this.FConsumeVipData.Daybuy[_loc5_.Identifier] : _loc6_.Desc;
         this.FTF_Price.text = String(_loc5_.Price);
      }
      
      protected function upButtonState() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         if((this.FCurConsumeVip.Daybuy == 0 || this.FConsumeVipData.Daybuy[this.FPageIndex + 1] > 0) && this.FCurConsumeVip.Identifier > this.FPageIndex)
         {
            TGameUtil.setButtonMode(this.FBTN_buy,true);
            this.FBTN_buy.mouseEnabled = true;
         }
         else
         {
            TGameUtil.setButtonMode(this.FBTN_buy,false);
            this.FBTN_buy.mouseEnabled = false;
         }
         if(this.FConsumeVipData.VipAward[this.FPageIndex + 1] == 1 && this.FCurConsumeVip.Identifier > this.FPageIndex)
         {
            TGameUtil.setButtonMode(this.FBTN_Reward,true);
            this.FBTN_Reward.mouseEnabled = true;
         }
         else
         {
            TGameUtil.setButtonMode(this.FBTN_Reward,false);
            this.FBTN_Reward.mouseEnabled = false;
         }
         if(this.FConsumeVipData.DailyAward == 1)
         {
            this.FBTN_DailyAward.gotoAndStop(5);
            _loc1_ = true;
            this.FBTN_DailyAward.mouseEnabled = true;
         }
         else
         {
            this.FBTN_DailyAward.gotoAndStop(1);
            _loc1_ = false;
            _loc2_ = true;
         }
         TGameUtil.setMovieClipButton(this.FBTN_DailyAward,_loc1_,_loc2_);
      }
      
      protected function get CurConsumeVip() : TConsumeVip
      {
         var _loc1_:TConsumeVip = null;
         var _loc2_:TConsumeVip = null;
         var _loc3_:TBins = null;
         var _loc4_:int = 0;
         _loc3_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConsumeVip);
         _loc4_ = 0;
         while(_loc4_ < _loc3_.Count)
         {
            _loc1_ = _loc3_.GetDatebaseByIndex(_loc4_) as TConsumeVip;
            if(_loc4_ + 1 < _loc3_.Count)
            {
               _loc2_ = _loc3_.GetDatebaseByIndex(_loc4_ + 1) as TConsumeVip;
            }
            else
            {
               _loc2_ = _loc1_;
            }
            if(this.FConsumeVipData.ConsumeMoney >= _loc1_.ConsumeCount && this.FConsumeVipData.ConsumeMoney < _loc2_.ConsumeCount)
            {
               break;
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      protected function get NextConsumeVip() : TConsumeVip
      {
         var _loc1_:TConsumeVip = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConsumeVip,this.FCurConsumeVip.Identifier + 1) as TConsumeVip;
         if(_loc1_ == null)
         {
            return SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConsumeVip,this.FCurConsumeVip.Identifier) as TConsumeVip;
         }
         return _loc1_;
      }
      
      protected function OnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
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
      
      protected function OnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function OnPageChangeHandlder(param1:Object, param2:int) : void
      {
         this.FPageIndex = param2;
         this.MC_BGImg.bitmapData = TUtilityReflection.CreateInstance("ConsumeVip_backImg_" + this.FPageIndex);
         this.MC_VipLv.gotoAndStop(this.FPageIndex + 1);
         this.UpdateItemSlotList();
         this.upButtonState();
      }
      
      protected function OnClickGetReward(param1:MouseEvent) : void
      {
         if(param1.currentTarget == this.FBTN_DailyAward)
         {
            this.PacketPerform_CS_ConsumeVip_Award(1);
         }
         else
         {
            this.PacketPerform_CS_ConsumeVip_Award(2,this.FPageIndex + 1);
         }
      }
      
      protected function OnClickBuy(param1:MouseEvent) : void
      {
         var _loc2_:TConsumeVip = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConsumeVip,this.FPageIndex + 1) as TConsumeVip;
         if(this.FCharacter.CreditGold < _loc2_.Price)
         {
            if(EffectGenerateText != null)
            {
               EffectGenerateText(STRING_COMMON.NOTENOUGH_Gold);
            }
            return;
         }
         this.PacketPerform_CS_ConsumeVip_Buy(1,this.FPageIndex + 1);
      }
      
      protected function OnCloseBtnClick(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function OnShowRecruit(param1:MouseEvent) : void
      {
         var _loc2_:TConsumeVip = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConsumeVip,this.FPageIndex + 1) as TConsumeVip;
         if(_loc2_)
         {
            _loc3_ = _loc2_.Heroid;
            _loc4_ = _loc2_.Tpye;
            if(_loc4_ == CONST_CONSUMEVIP.TYPE_IS_HERO)
            {
               this.FProcessorWindowRecruit.SetHeroData(_loc3_);
            }
            else if(_loc4_ == CONST_CONSUMEVIP.TYPE_IS_PET)
            {
               this.FProcessorWindowPetDesc.SetPetData(_loc3_);
            }
         }
      }
      
      protected function OnBtnMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:TArticle = null;
         var _loc4_:String = "";
         _loc5_ = this.FCurConsumeVip.DailyAward.split("|");
         _loc2_ = int(_loc5_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc6_ = _loc5_[_loc3_].split("_");
            _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc6_[0]) as TArticle;
            _loc4_ += _loc7_.Name + "*" + _loc6_[1] + "\n";
            _loc3_++;
         }
         this.FHint.Caption = _loc4_;
         ProcessorTipOnOver(this,this.FHint);
      }
      
      protected function OnBtnMouseOut(param1:MouseEvent) : void
      {
         ProcessorTipOnOut(this);
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         this.FHint.Content = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.ConsumeVip_STRING_001);
         UIHelpTipsHintOnOver(this,this.FHint);
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         UIHelpTipsHintOnOut(this);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.PacketPerform_CS_ConsumeVip_Info();
      }
      
      public function get OnInitConsumeVip() : Function
      {
         return this.FOnInitConsumeVip;
      }
      
      public function set OnInitConsumeVip(param1:Function) : void
      {
         this.FOnInitConsumeVip = param1;
      }
      
      public function get OnEffectBaseGlowVIP() : Function
      {
         return this.FOnEffectBaseGlowVIP;
      }
      
      public function set OnEffectBaseGlowVIP(param1:Function) : void
      {
         this.FOnEffectBaseGlowVIP = param1;
      }
   }
}

