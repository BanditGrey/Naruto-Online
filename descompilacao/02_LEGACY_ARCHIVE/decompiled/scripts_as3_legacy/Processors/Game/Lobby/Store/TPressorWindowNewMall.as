package Processors.Game.Lobby.Store
{
   import Components.Pages.TUIPage;
   import Components.Slots.TUISlot;
   import Components.Standard.TUITab;
   import Externals.SExternalCore;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Store.Cell.TBaseUnit;
   import Processors.Game.Lobby.Store.data.NewMallCellData;
   import Processors.Game.Lobby.Store.data.NewMallData;
   import Processors.Game.Lobby.Store.data.TPressorWindowPopBuyFream;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_STORE;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_NEWMALL;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TPressorWindowNewMall extends TProcessorLobbyWindows
   {
      
      public static const SIX:int = 6;
      
      public static const NINE:int = 9;
      
      public static const THREE:int = 6;
      
      public static const FIFTEEN:int = 15;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var FMC_ROOT:MovieClip = null;
      
      protected var FBTN_Recharge:MovieClip = null;
      
      protected var FTF_Gold:TextField;
      
      protected var FTF_Coupon:TextField;
      
      protected var FMC_VIPDiscount:MovieClip = null;
      
      protected var FTF_Panel_Dec:TextField = null;
      
      protected var FMC_PropPage:MovieClip;
      
      protected var FBTN_Shop:MovieClip;
      
      protected var FBTN_Refresh:MovieClip;
      
      protected var FTF_Refrese_Num:TextField;
      
      protected var FhasRefrese_Num:int;
      
      protected var FFreeTime:int;
      
      protected var FCostVector:Vector.<uint>;
      
      protected var FRefrese_Num:int;
      
      protected var FUITab:TUITab;
      
      protected var FPropPage:TUIPage = null;
      
      protected var FPropPageIndex:int;
      
      protected var FPropTabIndex:int;
      
      protected var CurTabIndex:int;
      
      protected var FInitilization:int;
      
      protected var FNineVect:Vector.<TBaseUnit> = null;
      
      protected var FNineSlot:Vector.<TUISlot> = null;
      
      protected var FLiftThreeVect:Vector.<TBaseUnit> = null;
      
      protected var FLiftThreeSlot:Vector.<TUISlot> = null;
      
      protected var FRightThreeVect:Vector.<TBaseUnit> = null;
      
      protected var FRightThreeSlot:Vector.<TUISlot> = null;
      
      protected var CurBuy_data:NewMallCellData = null;
      
      protected var FLogicData:NewMallData;
      
      protected var FCharacter:TCharacter;
      
      protected var FCurTabVector:Vector.<NewMallCellData>;
      
      protected var FTPressorWindowPopBuyFream:TPressorWindowPopBuyFream = null;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FUIWindowInformation:TUIWindowConfirmation;
      
      protected var FOnUpdateSuperHeroUI:Function;
      
      protected var FNoticeOthersPanel:Function;
      
      protected var FGoToOpenShop:Function;
      
      public function TPressorWindowNewMall(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FTPressorWindowPopBuyFream = new TPressorWindowPopBuyFream(param1);
         this.FTPressorWindowPopBuyFream.OnOver = this.SlotsOnOver;
         this.FTPressorWindowPopBuyFream.OnOut = this.SlotsOnOut;
         this.FTPressorWindowPopBuyFream.SureBtn = this.C_S_BuyGoods;
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (stage.stageWidth - 390) / 2;
         this.FProcessorWindowRecruit.y = (stage.stageHeight - 358) / 2;
         this.FProcessorWindowRecruit.Load();
         this.FUIWindowInformation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowInformation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowInformation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowInformation.WindowHeight) / 2;
         this.FNineVect = new Vector.<TBaseUnit>(NINE);
         this.FNineSlot = new Vector.<TUISlot>(NINE);
         this.FLiftThreeVect = new Vector.<TBaseUnit>(THREE);
         this.FLiftThreeSlot = new Vector.<TUISlot>(THREE);
         FOverlayerEquipment = new TOverlayerEquipment(this.Parent,CONST_MODULES.MODULE_NewMall);
         FOverlayerEquipment.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this.Parent,CONST_MODULES.MODULE_NewMall);
         FOverlayerAccessory.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this.Parent,CONST_MODULES.MODULE_NewMall);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this.Parent,CONST_MODULES.MODULE_NewMall);
         FOverlayerAppliance.Visible = false;
         this.FPropPage = new TUIPage(this);
         this.FPropPageIndex = 0;
         this.FPropTabIndex = 0;
         this.FLogicData = SLogicsCore.NewMallLogicData;
         this.FCharacter = SLogicsCore.Character;
         SetUIModuleID(CONST_MODULES.MODULE_NewMall);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_STORE.This_Resource_Id);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TextField = null;
         var _loc4_:TBaseUnit = null;
         var _loc5_:TUISlot = null;
         this.FMC_ROOT = TUtilityReflection.CreateDisplayObjectInstance(CONST_STORE.This_Panel_) as MovieClip;
         addChild(this.FMC_ROOT);
         this.FMC_ROOT.x = (FUICore.StageWidth - this.FMC_ROOT.width) / 2;
         this.FMC_ROOT.y = (FUICore.StageHeight - this.FMC_ROOT.height) / 2;
         this.FBTN_Recharge = this.FMC_ROOT["BTN_Recharge"];
         TGameUtil.setButtonMode(this.FBTN_Recharge,true);
         this.FTF_Gold = this.FMC_ROOT["TF_Gold"];
         this.FTF_Coupon = this.FMC_ROOT["TF_Coupon"];
         this.FMC_VIPDiscount = this.FMC_ROOT["MC_VIPDiscount"];
         this.FTF_Panel_Dec = this.FMC_ROOT["TF_Panel_Dec"];
         this.FBTN_Shop = this.FMC_ROOT["BTN_Shop"];
         TGameUtil.setButtonMode(this.FBTN_Shop,true);
         this.FBTN_Refresh = this.FMC_ROOT["BTN_Refresh"];
         TGameUtil.setButtonMode(this.FBTN_Refresh,true);
         this.FTF_Refrese_Num = this.FMC_ROOT["TF_Refresh"];
         this.C_S_OpenSverTime();
         this.FUITab = new TUITab(this);
         _loc1_ = 0;
         while(_loc1_ < SIX)
         {
            this.FUITab.SetTabByIndex(this.FMC_ROOT["MC_Tab_" + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FMC_PropPage = this.FMC_ROOT["MC_Page"];
         _loc2_ = this.FMC_PropPage["MC_PageLeft"];
         this.FPropPage.ButtonPrevious.Substrate = _loc2_;
         _loc2_ = this.FMC_PropPage["MC_PageRight"];
         this.FPropPage.ButtonNext.Substrate = _loc2_;
         _loc3_ = this.FMC_PropPage["TF_Page"];
         this.FPropPage.LabelPage = _loc3_;
         _loc3_.text = "0/0";
         this.FPropPage.PageSize = NINE;
         this.FPropPage.Init();
         this.FMC_PropPage.visible = true;
         this.FPropPage.OnChangePage = this.HeroPageOnChange;
         _loc1_ = 0;
         while(_loc1_ < NINE)
         {
            _loc4_ = this.GetBaseUnit();
            _loc4_.ThisPanel = this.FMC_ROOT["MC_MallItem_" + _loc1_];
            _loc4_.OnClick = this.OnClick;
            _loc4_.OnClickShowRecruit = this.ProcessorOnShowRecruit;
            this.FNineVect[_loc1_] = _loc4_;
            _loc5_ = this.GetUISlot();
            _loc5_.Resource = _loc4_.ThisPanel["MC_Slot"];
            _loc5_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc5_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc5_.OnOverlay = this.SlotsOnOver;
            _loc5_.OnOut = this.SlotsOnOut;
            _loc5_.Init();
            this.FNineSlot[_loc1_] = _loc5_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < THREE)
         {
            _loc4_ = this.GetBaseUnit();
            _loc4_.ThisPanel = this.FMC_ROOT["MC_Special"]["MC_MallItem_0" + _loc1_];
            _loc4_.OnClick = this.OnClick;
            this.FLiftThreeVect[_loc1_] = _loc4_;
            _loc5_ = this.GetUISlot();
            _loc5_.Resource = _loc4_.ThisPanel["MC_Slot"];
            _loc5_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc5_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc5_.OnOverlay = this.SlotsOnOver;
            _loc5_.OnOut = this.SlotsOnOut;
            _loc5_.Init();
            this.FLiftThreeSlot[_loc1_] = _loc5_;
            _loc1_++;
         }
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         this.FInitilization = 1;
         var _loc6_:TConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60380133) as TConfigValue;
         this.FFreeTime = _loc6_.Value as int;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60380134) as TConfigValue;
         this.FCostVector = _loc6_.Value as Vector.<uint>;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowInformation);
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function OnClick(param1:NewMallCellData) : void
      {
         this.CurBuy_data = param1;
         if(this.NotBuyTip())
         {
            return;
         }
         this.FTPressorWindowPopBuyFream.CurData = param1;
         this.FTPressorWindowPopBuyFream.Visible = true;
      }
      
      protected function NotBuyTip() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         if(this.CurBuy_data.BuyCondition == 1 || this.CurBuy_data.BuyCondition == 2)
         {
            if(this.CurBuy_data.BuyCondition == 2)
            {
               _loc2_ = int(SLogicsCore.KaguyaData.CurLevel);
               if(SLogicsCore.KaguyaData.CurLevel < this.CurBuy_data.ConditionCount)
               {
                  EffectGenerateText(STRING_NEWMALL.S3);
                  _loc1_ = true;
               }
            }
            else if(this.FCharacter.VipLevel < this.CurBuy_data.ConditionCount)
            {
               EffectGenerateText(STRING_NEWMALL.S4);
               _loc1_ = true;
            }
         }
         else if(this.CurBuy_data.IsHaveCountCondition)
         {
            if(!this.CurBuy_data.CurGoodsIsShow)
            {
               EffectGenerateText(STRING_NEWMALL.S5);
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      protected function ProcessorOnShowRecruit(param1:int) : void
      {
         if(param1)
         {
            this.FProcessorWindowRecruit.SetHeroData(param1);
         }
      }
      
      protected function addListener() : void
      {
         SimpleButton(this.FMC_ROOT["BTN_Close"]).addEventListener(MouseEvent.CLICK,this.ClickHandle);
         this.FBTN_Recharge.addEventListener(MouseEvent.CLICK,this.ClickHandle);
         this.FBTN_Shop.addEventListener(MouseEvent.CLICK,this.ClickHandle);
         this.FBTN_Refresh.addEventListener(MouseEvent.CLICK,this.ClickHandle);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.addListener();
         this.FTF_Panel_Dec.text = new ConsumeFrame(CONST_SYSTEMLANGUAGE.HELPTIPS_Kaguya_Store).DescribeString;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         if(this.Visible && Boolean(this.FInitilization))
         {
            _loc1_ = 0;
            while(_loc1_ < this.FLiftThreeSlot.length)
            {
               this.FLiftThreeSlot[_loc1_].Update();
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < this.FNineSlot.length)
            {
               this.FNineSlot[_loc1_].Update();
               _loc1_++;
            }
            if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
            {
               this.FProcessorWindowRecruit.UpdataBitmap();
            }
            this.UpdateMoney();
         }
         super.LogicsPerform();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FTPressorWindowPopBuyFream.Load();
            return;
         }
         if(!this.FInitilization)
         {
            return;
         }
         this.FCurTabVector = this.FLogicData.getArrByType(this.CurTabIndex + 1);
         if(this.CurTabIndex + 1 != 4 || this.CurTabIndex + 1 != 5)
         {
            this.C_S_GoodsCount(4);
            this.C_S_GoodsCount(5);
         }
         this.C_S_GoodsCount(this.CurTabIndex + 1);
         this.GetInitilization();
         this.UpdateMoney();
         this.UpdatePage();
         this.UpdateCellLift();
         if(this.FCharacter.GetMainLevel() >= SLogicsCore.KaguyaData.OpenLevel)
         {
            this.FUITab.SetTabHideByIndexCopy(10);
         }
         else
         {
            this.FUITab.SetTabHideByIndexCopy(3);
         }
      }
      
      protected function PACKETID_SC_S2C_New_Mall_Get_Open(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         this.FLogicData.OpenSeverTime = _loc3_;
         this.FLogicData.ClearVector();
         this.FLogicData.Initilization();
         this.UpdatePage();
         this.UpdateCellLift();
         this.UpdateCellRight();
      }
      
      protected function PACKETID_SC_NewMall_Refrese_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
      }
      
      override public function Unmount() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUISlot = null;
         super.Unmount();
         _loc1_ = 0;
         while(_loc1_ < this.FNineVect.length)
         {
            _loc2_ = this.FNineSlot[_loc1_];
            if(_loc2_)
            {
               this.FNineSlot[_loc1_].Context = null;
            }
            _loc1_++;
         }
         this.C_S_OpenSverTime();
      }
      
      protected function HeroPageOnChange(param1:Object, param2:int) : void
      {
         this.FPropPageIndex = param2;
         this.FPropTabIndex = 0;
         this.FPropTabIndex += this.FPropPageIndex * NINE;
         this.UpdateCellLift();
      }
      
      protected function UpdatePage() : void
      {
         this.FPropPageIndex = 0;
         this.FPropTabIndex = 0;
         this.FPropPage.TotalQuantity = this.FCurTabVector.length;
         this.FPropPage.PageIndex = this.FPropTabIndex;
         this.FPropPage.Update();
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.CurTabIndex = param1 as int;
         this.C_S_GoodsCount(this.CurTabIndex + 1);
         this.FCurTabVector = this.FLogicData.getArrByType(this.CurTabIndex + 1);
         this.UpdatePage();
         this.UpdateCellLift();
         if(this.CurTabIndex == 3 || this.CurTabIndex == 4)
         {
            this.FMC_VIPDiscount.visible = false;
         }
         else
         {
            this.FMC_VIPDiscount.visible = true;
         }
      }
      
      protected function UpdateCellLift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < NINE)
         {
            _loc2_ = this.FPropTabIndex + _loc1_;
            if(_loc2_ >= this.FCurTabVector.length)
            {
               this.FNineVect[_loc1_].ThisPanel.visible = false;
            }
            else
            {
               this.FNineVect[_loc1_].ThisPanel.visible = true;
               this.FNineVect[_loc1_].AtState = this.CurTabIndex;
               this.FNineVect[_loc1_].CurData = this.FCurTabVector[_loc2_];
               this.FNineSlot[_loc1_].Context = this.FCurTabVector[_loc2_].GetTInventorie();
            }
            _loc1_++;
         }
      }
      
      protected function UpdateCellRight() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<NewMallCellData> = null;
         _loc3_ = this.FLogicData.vc6;
         _loc1_ = 0;
         while(_loc1_ < THREE)
         {
            if(_loc1_ >= _loc3_.length)
            {
               this.FLiftThreeVect[_loc1_].ThisPanel.visible = false;
            }
            else
            {
               this.FLiftThreeVect[_loc1_].ThisPanel.visible = true;
               this.FLiftThreeVect[_loc1_].AtState = 6;
               this.FLiftThreeVect[_loc1_].CurData = _loc3_[_loc1_];
               this.FLiftThreeSlot[_loc1_].Context = _loc3_[_loc1_].GetTInventorie();
            }
            _loc1_++;
         }
      }
      
      protected function GetInitilization() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NewMall_Get_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function C_S_BuyGoods(param1:NewMallCellData, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NewMall_BuyGoods);
         _loc3_.Data.writeUnsignedInt(param1.NewMall.Identifier);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function C_S_GoodsCount(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NewMall_GoodsCount);
         _loc2_.Data.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function C_S_OpenSverTime() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_New_Mall_Get_Open);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function WindowInformationOnOK(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NewMallRefrese_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function C_S_Refrese() : void
      {
         var _loc1_:int = 0;
         if(this.FRefrese_Num <= 0)
         {
            _loc1_ = this.FhasRefrese_Num - this.FFreeTime;
            if(_loc1_ < this.FCostVector.length)
            {
               this.FUIWindowInformation.Visible = true;
               this.FUIWindowInformation.SetHtml = TUtilityString.Format(TUtilityString.GetText(80002387),this.FCostVector[_loc1_]);
               return;
            }
         }
         this.WindowInformationOnOK(null);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NewMall_Get_Info,this.PACKETID_SC_NewMall_Get_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NewMall_BuyGoods,this.PACKETID_SC_NewMall_BuyGoods);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NewMall_GoodsCount,this.PACKETID_SC_NewMall_GoodsCount);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_S2C_New_Mall_Get_Open,this.PACKETID_SC_S2C_New_Mall_Get_Open);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NewMallRefrese_Ret,this.PACKETID_SC_NewMall_Refrese_Ret);
      }
      
      protected function PACKETID_SC_NewMall_Get_Info(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readShort();
         this.FLogicData.vc6.length = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            this.FLogicData.SetValueById(_loc2_.readUnsignedInt(),_loc2_.readUnsignedInt());
            _loc5_++;
         }
         this.FhasRefrese_Num = _loc2_.readUnsignedInt();
         this.FRefrese_Num = this.FFreeTime - this.FhasRefrese_Num;
         this.FTF_Refrese_Num.text = this.FRefrese_Num > 0 ? this.FRefrese_Num.toString() : "0";
         this.FLogicData.UpdateSortSix();
         this.UpdateCellRight();
      }
      
      public function set NoticeOthersPanel(param1:Function) : void
      {
         this.FNoticeOthersPanel = param1;
      }
      
      protected function PACKETID_SC_NewMall_BuyGoods(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         this.FTPressorWindowPopBuyFream.visible = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            if(this.FNoticeOthersPanel != null)
            {
               this.FNoticeOthersPanel(_loc3_);
            }
            return;
         }
         EffectGenerateText(STRING_NEWMALL.S6);
         if(this.FNoticeOthersPanel != null)
         {
            this.FNoticeOthersPanel(_loc3_);
         }
         if(this.FOnUpdateSuperHeroUI != null)
         {
            this.FOnUpdateSuperHeroUI(this);
         }
         if(this.CurBuy_data == null)
         {
            return;
         }
         this.CurBuy_data.CurGoodsBuyCount = _loc2_.readUnsignedInt();
         this.FLogicData.SetCountById(this.CurBuy_data.NewMall.Identifier,this.CurBuy_data.CurGoodsBuyCount);
         if(this.CurBuy_data.NewMall.Type == 6 || this.CurBuy_data.NewMall.Type == 7)
         {
            this.UpdateCellRight();
         }
         else
         {
            this.UpdateCellLift();
         }
      }
      
      protected function PACKETID_SC_NewMall_GoodsCount(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            this.FLogicData.SetCountById(_loc2_.readUnsignedInt(),_loc2_.readUnsignedInt());
            _loc5_++;
         }
         if(this.CurTabIndex == 2)
         {
            this.ForStoneUpdate();
         }
         if(_loc4_ > 0 || this.CurTabIndex == 2)
         {
            this.UpdateCellLift();
         }
      }
      
      protected function ForStoneUpdate() : void
      {
         var _loc1_:TInventories = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:NewMallCellData = null;
         var _loc5_:TInventory = null;
         _loc3_ = int(this.FCurTabVector.length);
         _loc1_ = this.FCharacter.Appliances;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = null;
            _loc4_ = this.FCurTabVector[_loc2_];
            _loc5_ = _loc1_.GetInventoryByTempletID(_loc4_.NewMall.Itemid);
            if(_loc5_)
            {
               this.FLogicData.SetCountById(_loc4_.NewMall.Identifier,1);
            }
            _loc2_++;
         }
      }
      
      public function set OnUpdateSuperHeroUI(param1:Function) : void
      {
         this.FOnUpdateSuperHeroUI = param1;
      }
      
      public function get OnUpdateSuperHeroUI() : Function
      {
         return this.FOnUpdateSuperHeroUI;
      }
      
      protected function ClickHandle(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_ROOT["BTN_Close"]:
               if(FOnClose != null)
               {
                  FOnClose(this);
               }
               break;
            case this.FBTN_Recharge:
               SExternalCore.NavigateToRecharge();
               break;
            case this.FBTN_Shop:
               if(this.FGoToOpenShop != null)
               {
                  this.FGoToOpenShop();
               }
               break;
            case this.FBTN_Refresh:
               this.C_S_Refrese();
         }
      }
      
      protected function UpdateMoney() : void
      {
         this.FTF_Gold.text = this.FCharacter.CreditGold.toString();
         this.FTF_Coupon.text = this.FCharacter.CreditGiftCertificate.toString();
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               _loc4_ = FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc4_ = FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = FOverlayerAccessory;
               break;
            default:
               _loc4_ = FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               _loc4_ = FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc4_ = FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = FOverlayerAccessory;
               break;
            default:
               _loc4_ = FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Hide();
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_NewMall);
         }
      }
      
      protected function GetBaseUnit() : TBaseUnit
      {
         return new TBaseUnit();
      }
      
      protected function GetUISlot() : TUISlot
      {
         return new TUISlot(this);
      }
      
      public function set GoToOpenShop(param1:Function) : void
      {
         this.FGoToOpenShop = param1;
      }
      
      public function get GoToOpenShop() : Function
      {
         return this.FGoToOpenShop;
      }
   }
}

