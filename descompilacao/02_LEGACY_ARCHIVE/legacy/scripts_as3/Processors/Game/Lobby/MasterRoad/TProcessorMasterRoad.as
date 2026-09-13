package Processors.Game.Lobby.MasterRoad
{
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.MasterRoad.TMasterRoad;
   import Logics.SLogicsCore;
   import Logics.Streamization.MasterRoad.TUnstreamizerMasterRoad;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyPlate;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Rendering.Overlayers.Box.TOverlayerBoxNew;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverSuperJade;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_MASTERROAD;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorMasterRoad extends TProcessorLobbyPlate
   {
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const TAB_COUNT:uint = 1;
      
      public static const UI_TYPE_MAIN:int = 0;
      
      public static const UI_TYPE_PALACE:int = 1;
      
      public static const UI_TYPE_TEMPLE:int = 2;
      
      public static const UI_TYPE_SHOP:int = 3;
      
      public static const UI_TYPE_ACHIEVEMENT:int = 4;
      
      public static const REQ_TYPE_FIGHT:int = 1;
      
      public static const REQ_TYPE_BUY_FIGHT_COUNT:int = 2;
      
      public static const REQ_TYPE_GET_FIGHT_AWARD:int = 3;
      
      public static const REQ_TYPE_ACTIVE_BADGE:int = 4;
      
      public static const REQ_TYPE_EXCHANGE_ITEM:int = 5;
      
      public static const REQ_TYPE_EDIT_INFO:int = 6;
      
      protected var FBuyBoxObj:Object;
      
      protected var FCurCost:int;
      
      protected var FIsClicked:Boolean;
      
      protected var FHtmlHint:THint;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FOverlayerEquipment:TOverlayerEquipment;
      
      protected var FOverlayerTreasure:TOverlayerTreasure;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FOverlayerAccessory:TOverlayerAccessory;
      
      protected var FOverSuperJade:TOverSuperJade;
      
      protected var FOverlayerBoxNew:TOverlayerBoxNew;
      
      protected var FUIGoldConfirmation:TUIWindowConfirmation;
      
      protected var FUIGotoRecharge:TUIWindowRecharge;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMasterRoad:TMasterRoad;
      
      protected var FUnstreamizerMasterRoad:TUnstreamizerMasterRoad;
      
      protected var FUIMasterRoadMain:TUIMasterRoadMain;
      
      protected var FUIMasterRoadPalace:TUIMasterRoadPalace;
      
      protected var FUIMasterRoadTemple:TUIMasterRoadTemple;
      
      protected var FUIMasterRoadShop:TUIMasterRoadShop;
      
      protected var FUIMasterRoadAchievement:TUIMasterRoadAchievement;
      
      protected var FPalaceIndex:int;
      
      public var OnReturnMainScene:Function;
      
      public var SetStatusType:Function;
      
      public var OnInitBattle:Function;
      
      public var OnUpdateBadge:Function;
      
      public var OnUpdateCharInfo:Function;
      
      public function TProcessorMasterRoad(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FMasterRoad = SLogicsCore.MasterRoad;
         this.FUnstreamizerMasterRoad = new TUnstreamizerMasterRoad();
         this.FBuyBoxObj = new Object();
         this.FHtmlHint = new THint();
         this.FUIGoldConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIGotoRecharge = new TUIWindowRecharge(this.Parent);
         SetUIModuleID(CONST_MODULES.MODULE_MasterRoad);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(1509949440);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_MasterRoadMain") as MovieClip;
         addChild(this.FMC_Scene);
         this.FUIMasterRoadMain = new TUIMasterRoadMain(this);
         this.FUIMasterRoadMain.Perform_UIDispatch(this.FMC_Scene);
         this.FUIMasterRoadMain.OnCloseWindow = this.OnCloseTavern;
         this.FUIMasterRoadMain.OnShowWindow = this.OnShowWindow;
         this.FUIMasterRoadMain.OnHelpOver = this.UIHelpTipsHintOnOver;
         this.FUIMasterRoadMain.OnHelpOut = this.UIHelpTipsHintOnOut;
         _loc2_ = TUtilityReflection.CreateDisplayObjectInstance("MC_MasterRoadPalace") as MovieClip;
         this.FUIMasterRoadPalace = new TUIMasterRoadPalace(this);
         this.FUIMasterRoadPalace.Perform_UIDispatch(_loc2_);
         this.FUIMasterRoadPalace.OnCloseWindow = this.OnCloseTavern;
         this.FUIMasterRoadPalace.OnGetBox = this.ProcessorOnGetBoxClick;
         this.FUIMasterRoadPalace.OnBuyBox = this.ProcessorOnBuyBoxClick;
         this.FUIMasterRoadPalace.OnNewBoxOver = this.ProcessorOnNewBoxOver;
         this.FUIMasterRoadPalace.OnNewBoxOut = this.ProcessorOnNewBoxOut;
         this.FUIMasterRoadPalace.OnHelpOver = this.UIHelpTipsHintOnOver;
         this.FUIMasterRoadPalace.OnHelpOut = this.UIHelpTipsHintOnOut;
         this.FUIMasterRoadPalace.OnShowHtmlTip = this.ProcessorOnShowHtmlText;
         this.FUIMasterRoadPalace.OnHideHtmlTip = this.ProcessorOnHideHtmlText;
         this.FUIMasterRoadPalace.SetVisible(false);
         _loc2_ = TUtilityReflection.CreateDisplayObjectInstance("MC_MasterRoadTemple") as MovieClip;
         this.FUIMasterRoadTemple = new TUIMasterRoadTemple(this);
         this.FUIMasterRoadTemple.Perform_UIDispatch(_loc2_);
         this.FUIMasterRoadTemple.OnCloseWindow = this.OnCloseTavern;
         this.FUIMasterRoadTemple.OnGetBox = this.ProcessorOnGetBoxClick;
         this.FUIMasterRoadTemple.OnHelpOver = this.UIHelpTipsHintOnOver;
         this.FUIMasterRoadTemple.OnHelpOut = this.UIHelpTipsHintOnOut;
         this.FUIMasterRoadTemple.SetVisible(false);
         _loc2_ = TUtilityReflection.CreateDisplayObjectInstance("MC_MasterRoadShop") as MovieClip;
         this.FUIMasterRoadShop = new TUIMasterRoadShop(this);
         this.FUIMasterRoadShop.Perform_UIDispatch(_loc2_);
         this.FUIMasterRoadShop.OnItemOver = this.UIComponentsHintOnOver;
         this.FUIMasterRoadShop.OnItemOut = this.UIComponentsHintOnOut;
         this.FUIMasterRoadShop.OnHelpOver = this.UIHelpTipsHintOnOver;
         this.FUIMasterRoadShop.OnHelpOut = this.UIHelpTipsHintOnOut;
         this.FUIMasterRoadShop.OnGetBox = this.ProcessorOnGetBoxClick;
         this.FUIMasterRoadShop.OnCloseWindow = this.OnCloseTavern;
         this.FUIMasterRoadShop.SetVisible(false);
         _loc2_ = TUtilityReflection.CreateDisplayObjectInstance("MC_MasterRoadAchievement") as MovieClip;
         this.FUIMasterRoadAchievement = new TUIMasterRoadAchievement(this);
         this.FUIMasterRoadAchievement.Perform_UIDispatch(_loc2_);
         this.FUIMasterRoadAchievement.OnCloseWindow = this.OnCloseTavern;
         this.FUIMasterRoadAchievement.OnHelpOver = this.UIHelpTipsHintOnOver;
         this.FUIMasterRoadAchievement.OnHelpOut = this.UIHelpTipsHintOnOut;
         this.FUIMasterRoadAchievement.SetVisible(false);
         this.FOverlayerHint = new TOverlayerHint(this.Parent);
         this.FOverlayerHint.Visible = false;
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this.Parent);
         this.FOverlayerHelpTips.Visible = false;
         this.FOverlayerEquipment = new TOverlayerEquipment(this.Parent,CONST_MODULES.MODULE_MasterRoad);
         this.FOverlayerEquipment.Visible = false;
         this.FOverlayerTreasure = new TOverlayerTreasure(this.Parent,CONST_MODULES.MODULE_MasterRoad);
         this.FOverlayerTreasure.Visible = false;
         this.FOverlayerAppliance = new TOverlayerAppliance(this.Parent,CONST_MODULES.MODULE_MasterRoad);
         this.FOverlayerAppliance.Visible = false;
         this.FOverlayerAccessory = new TOverlayerAccessory(this.Parent,CONST_MODULES.MODULE_MasterRoad);
         this.FOverlayerAccessory.Visible = false;
         this.FOverSuperJade = new TOverSuperJade(this.Parent);
         this.FOverSuperJade.Visible = false;
         this.FOverlayerBoxNew = new TOverlayerBoxNew(this.Parent);
         this.FOverlayerBoxNew.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverSuperJade);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBoxNew);
         this.FUIGoldConfirmation.OnOK = this.GoldConfirmationOnOK;
         this.FUIGoldConfirmation.OnCancel = this.GoldCofirmationOnCancel;
         this.FUIGoldConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIGoldConfirmation.WindowWidth) / 2;
         this.FUIGoldConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIGoldConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIGoldConfirmation);
         this.FUIGoldConfirmation.SetCheckBox(true);
         this.FUIGotoRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIGotoRecharge.WindowWidth) / 2;
         this.FUIGotoRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIGotoRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIGotoRecharge);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         super.LogicsPerform();
         if(!FIsResourcesLoadCompleted || !Visible)
         {
            return;
         }
         if(Boolean(this.FMC_Scene) && this.FMC_Scene.visible)
         {
            if(this.FUIMasterRoadMain.visible)
            {
               this.FUIMasterRoadMain.LogicsPerform();
            }
            if(this.FUIMasterRoadPalace.visible)
            {
               this.FUIMasterRoadPalace.LogicsPerform();
            }
            if(this.FUIMasterRoadTemple.visible)
            {
               this.FUIMasterRoadTemple.LogicsPerform();
            }
            if(this.FUIMasterRoadShop.visible)
            {
               this.FUIMasterRoadShop.LogicsPerform();
            }
            if(this.FUIMasterRoadAchievement.visible)
            {
               this.FUIMasterRoadAchievement.LogicsPerform();
            }
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MasterRoad_LoadInfoRet,this.ProcessorOnLoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MasterRoad_CommonRet,this.ProcessorOnCommonRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MasterRoad_TempleRet,this.ProcessorOnLoadTempleRet);
         super.PacketRegisterRoutines();
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         if(this.FUIMasterRoadMain.visible)
         {
            this.FUIMasterRoadMain.UpdateUI();
         }
         if(this.FUIMasterRoadPalace.visible)
         {
            this.FUIMasterRoadPalace.UpdateWindow(this.FPalaceIndex);
         }
         if(this.FUIMasterRoadTemple.visible)
         {
            this.FUIMasterRoadTemple.UpdateWindow();
         }
         if(this.FUIMasterRoadShop.visible)
         {
            this.FUIMasterRoadShop.UpdateWindow();
         }
         if(this.FUIMasterRoadAchievement.visible)
         {
            this.FUIMasterRoadAchievement.UpdateWindow();
         }
      }
      
      protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_MasterRoad_LoadInfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_AllReq(param1:int, param2:Vector.<int> = null, param3:String = "") : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_MasterRoad_CommonReq);
         _loc4_.Data.writeUnsignedInt(param1);
         if(param2 == null)
         {
            _loc4_.Data.writeShort(0);
         }
         else
         {
            _loc7_ = int(param2.length);
            _loc4_.Data.writeShort(_loc7_);
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               _loc4_.Data.writeUnsignedInt(param2[_loc6_]);
               _loc6_++;
            }
         }
         TUtilityString.FlushUTF(_loc4_.Data,param3);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function OnCloseTavern(param1:Object) : void
      {
         if(param1 == this.FUIMasterRoadMain)
         {
            if(this.OnReturnMainScene != null)
            {
               this.OnReturnMainScene(param1);
            }
         }
         else
         {
            this.FUIMasterRoadPalace.SetVisible(false);
            this.FUIMasterRoadTemple.SetVisible(false);
            this.FUIMasterRoadShop.SetVisible(false);
            this.FUIMasterRoadAchievement.SetVisible(false);
         }
      }
      
      protected function OnShowWindow(param1:int, param2:int = 0) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:int = 0;
         switch(param1)
         {
            case UI_TYPE_MAIN:
               break;
            case UI_TYPE_PALACE:
               this.FPalaceIndex = param2;
               this.FUIMasterRoadPalace.SetVisible(true);
               this.FUIMasterRoadPalace.UpdateWindow(param2);
               break;
            case UI_TYPE_TEMPLE:
               _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_MasterRoad_TempleReq);
               SNetworkCore.Transceiver.PacketTransmit(_loc3_);
               break;
            case UI_TYPE_SHOP:
               this.FUIMasterRoadShop.SetVisible(true);
               this.FUIMasterRoadShop.UpdateWindow();
               break;
            case UI_TYPE_ACHIEVEMENT:
               this.FUIMasterRoadAchievement.SetVisible(true);
               this.FUIMasterRoadAchievement.UpdateWindow();
         }
      }
      
      protected function ProcessorTipOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      protected function ProcessorTipOnOut(param1:Object) : void
      {
         this.FOverlayerHint.Hide();
      }
      
      protected function UIHelpTipsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHelpTips.Context = param2;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function UIHelpTipsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHelpTips.Hide();
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               _loc4_ = this.FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc4_ = this.FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = this.FOverlayerAccessory;
               break;
            default:
               if(SLogicsCore.LostShenQiLogicData.GetBooJade(_loc3_.IDTemplate))
               {
                  _loc4_ = this.FOverSuperJade;
               }
               else
               {
                  _loc4_ = this.FOverlayerAppliance;
               }
         }
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function UIComponentsHintOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         if(param2 == null)
         {
            if(this.FOverlayerEquipment.visible)
            {
               this.FOverlayerEquipment.Hide();
            }
            if(this.FOverlayerTreasure.visible)
            {
               this.FOverlayerTreasure.Hide();
            }
            if(this.FOverlayerAccessory.visible)
            {
               this.FOverlayerAccessory.Hide();
            }
            if(this.FOverlayerAppliance.visible)
            {
               this.FOverlayerAppliance.Hide();
            }
            return;
         }
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               _loc4_ = this.FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc4_ = this.FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = this.FOverlayerAccessory;
               break;
            default:
               _loc4_ = this.FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
      }
      
      protected function ProcessorOnBuyBoxClick(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0, param7:int = 0, param8:int = 0) : void
      {
         this.FBuyBoxObj.ActivityType = param1;
         this.FBuyBoxObj.BoxIndex = param3;
         this.FBuyBoxObj.Cost = param2;
         this.FBuyBoxObj.CostType = param4;
         this.FBuyBoxObj.BoxIndex1 = param6;
         this.FBuyBoxObj.ConfirmType = param7;
         if(param4 != TBaseActivity.SWEET_TYPE_GOLD && param4 != TBaseActivity.SWEET_TYPE_GOLD_GIFT)
         {
            this.ProcessorOnGetBoxClick(this.FBuyBoxObj.ActivityType,this.FBuyBoxObj.BoxIndex,this.FBuyBoxObj.BoxIndex1);
            return;
         }
         if(!this.FUIGoldConfirmation.IsSelected || param8 != 0)
         {
            this.FCurCost = param2;
            if(param5 != "")
            {
               this.FUIGoldConfirmation.Text = param5;
            }
            else if(param4 == TBaseActivity.SWEET_TYPE_GOLD)
            {
               this.FUIGoldConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCurCost);
            }
            else
            {
               this.FUIGoldConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGoldOrGift,this.FCurCost);
            }
            this.FUIGoldConfirmation.SetCheckBox(true);
            this.FUIGoldConfirmation.Visible = true;
         }
         else
         {
            this.GoldConfirmationOnOK();
         }
      }
      
      protected function GoldConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(this.FBuyBoxObj.CostType == TBaseActivity.SWEET_TYPE_GOLD)
         {
            if(_loc2_.CreditGold >= this.FBuyBoxObj.Cost)
            {
               this.ProcessorOnGetBoxClick(this.FBuyBoxObj.ActivityType,this.FBuyBoxObj.BoxIndex,this.FBuyBoxObj.BoxIndex1);
            }
            else
            {
               this.FUIGotoRecharge.Visible = true;
            }
         }
         else if(this.FBuyBoxObj.CostType == TBaseActivity.SWEET_TYPE_GOLD_GIFT)
         {
            if(_loc2_.CreditGold + _loc2_.CreditGiftCertificate >= this.FBuyBoxObj.Cost)
            {
               this.ProcessorOnGetBoxClick(this.FBuyBoxObj.ActivityType,this.FBuyBoxObj.BoxIndex,this.FBuyBoxObj.BoxIndex1);
            }
            else
            {
               this.FUIGotoRecharge.Visible = true;
            }
         }
      }
      
      protected function ProcessorOnGetBoxClick(param1:int, param2:int = 0, param3:int = 0, param4:String = "") : void
      {
         var _loc5_:TPacket = null;
         var _loc6_:int = 0;
         var _loc7_:Vector.<int> = null;
         if(this.FIsClicked)
         {
            return;
         }
         this.FIsClicked = true;
         _loc7_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc7_.push(param2);
         }
         if(param3 != 0)
         {
            _loc7_.push(param3);
         }
         this.PerformPacket_CS_AllReq(param1,_loc7_,param4);
         if(param1 == REQ_TYPE_FIGHT && this.SetStatusType != null)
         {
            this.SetStatusType(this,CONST_BATTLE.BattleType_MasterRoad,0);
         }
      }
      
      protected function GoldCofirmationOnCancel(param1:Object = null) : void
      {
      }
      
      protected function ProcessorOnShowHtmlText(param1:String) : void
      {
         param1 = param1;
         param1 = param1.split("&zt;").join("<");
         param1 = param1.split("&yt;").join(">");
         param1 = param1.split("%n").join("\n");
         if(param1 == "")
         {
            return;
         }
         this.FHtmlHint.Content = null;
         this.FHtmlHint.Content = param1;
         this.UIHelpTipsHintOnOver(this,this.FHtmlHint);
      }
      
      protected function ProcessorOnHideHtmlText(param1:MouseEvent = null) : void
      {
         this.UIHelpTipsHintOnOut(this);
      }
      
      protected function ProcessorOnNewBoxOver(param1:TInventories, param2:String = "") : void
      {
         if(param1 != null)
         {
            if(param2 == "")
            {
               param2 = STRING_BASEACTIVITY.FORMAT_BOX_CONTEXT;
            }
            this.FOverlayerBoxNew.Desc = param2;
            this.FOverlayerBoxNew.Context = param1;
            this.FOverlayerBoxNew.Render(FUICore.MouseCoordinate);
            this.FOverlayerBoxNew.Show();
         }
      }
      
      protected function ProcessorOnNewBoxOut(param1:MouseEvent = null) : void
      {
         this.FOverlayerBoxNew.Hide();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FUIGoldConfirmation.Load();
            this.FUIGotoRecharge.Load();
            return;
         }
         this.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnLoadInfoRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.OnReturnMainScene(this);
            return;
         }
         this.FUnstreamizerMasterRoad.Unstreamize(_loc2_,this.FMasterRoad,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      protected function ProcessorOnLoadTempleRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.OnReturnMainScene(this);
            return;
         }
         this.FUnstreamizerMasterRoad.UnstreamizationPerform_Temple(_loc2_,this.FMasterRoad,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.FUIMasterRoadTemple.SetVisible(true);
            this.FUIMasterRoadTemple.UpdateWindow();
         }
      }
      
      protected function ProcessorOnCommonRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:TInventories = null;
         this.FIsClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc4_)
         {
            case REQ_TYPE_FIGHT:
               this.PacketPerform_SC_FightRet(_loc2_);
               break;
            case REQ_TYPE_BUY_FIGHT_COUNT:
               _loc9_ = int(_loc2_.readUnsignedInt());
               this.FMasterRoad.VenuesData[this.FPalaceIndex].GetBattleByID(_loc9_).LimitCount = _loc2_.readUnsignedInt();
               this.FMasterRoad.VenuesData[this.FPalaceIndex].GetBattleByID(_loc9_).Price = _loc2_.readUnsignedInt();
               this.UpdateUI();
               break;
            case REQ_TYPE_GET_FIGHT_AWARD:
               _loc9_ = int(_loc2_.readUnsignedInt());
               this.FMasterRoad.VenuesData[this.FPalaceIndex].GetBattleByID(_loc9_).Status = TBaseActivity.STATUS_GETED;
               EffectGenerateText(STRING_BASEACTIVITY.FORMAT_GET);
               this.UpdateUI();
               this.PerformPacket_CS_LoadInfoReq();
               break;
            case REQ_TYPE_ACTIVE_BADGE:
               _loc5_ = int(_loc2_.readUnsignedInt());
               this.FMasterRoad.GetVenueByIdentify(_loc5_).Status = TBaseActivity.STATUS_GETED;
               SLogicsCore.Character.BadgeList.push(_loc5_);
               if(this.OnUpdateBadge != null)
               {
                  this.OnUpdateBadge(SLogicsCore.Character.BadgeList);
               }
               this.UpdateUI();
               break;
            case REQ_TYPE_EXCHANGE_ITEM:
               _loc5_ = int(_loc2_.readUnsignedInt());
               this.FMasterRoad.MyScore = _loc2_.readUnsignedInt();
               _loc11_ = this.FMasterRoad.GetMallByIdentify(_loc5_).Inventories;
               _loc11_.GetInventoryByIndex(0).LimitCount = _loc2_.readInt();
               SLogicsCore.Character.MainHero.Experience.High = _loc2_.readInt();
               SLogicsCore.Character.MainHero.Experience.Low = _loc2_.readInt();
               EffectGenerateText(STRING_BASEACTIVITY.FORMAT_EXCHANGE);
               this.UpdateUI();
               if(this.OnUpdateCharInfo != null)
               {
                  this.OnUpdateCharInfo();
               }
               break;
            case REQ_TYPE_EDIT_INFO:
               EffectGenerateText(new ConsumeFrameCopy(STRING_MASTERROAD.STRING_006).DescribeString);
               this.FMasterRoad.HonorPlayers[this.FMasterRoad.TempleIndex].Desc1 = this.FMasterRoad.Manifesto;
               this.FMasterRoad.TempleStatus = 1;
               this.UpdateUI();
         }
      }
      
      protected function PacketPerform_SC_FightRet(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.SetStatusType != null)
         {
            this.SetStatusType(this,CONST_BATTLE.BattleType_MasterRoad,0);
         }
         if(this.OnInitBattle != null)
         {
            this.OnInitBattle(this);
         }
         _loc3_ = int(param1.readUnsignedInt());
         _loc4_ = param1.readInt();
         this.FMasterRoad.VenuesData[this.FPalaceIndex].GetBattleByID(_loc3_).Status = _loc4_;
         this.PerformPacket_CS_LoadInfoReq();
      }
      
      public function TestInit() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeInt(10000);
         _loc3_.writeShort(9);
         _loc1_ = 0;
         while(_loc1_ < 9)
         {
            _loc3_.writeInt(10000 * _loc1_ + 10001);
            _loc3_.writeInt(10000);
            _loc3_.writeInt(_loc1_ % 2);
            _loc3_.writeUnsignedInt(1401571200);
            _loc3_.writeShort(9);
            _loc2_ = 0;
            while(_loc2_ < 9)
            {
               _loc3_.writeInt(10000000 * _loc2_ + 10000001 + _loc1_);
               _loc3_.writeInt(1000);
               _loc2_++;
            }
            _loc3_.writeShort(9);
            _loc2_ = 0;
            while(_loc2_ < 9)
            {
               _loc3_.writeInt(100000 * _loc2_ + 100001 + _loc1_);
               _loc3_.writeInt(_loc2_ % 2);
               _loc3_.writeInt(5);
               _loc3_.writeInt(_loc2_ % 2);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(9);
         _loc1_ = 0;
         while(_loc1_ < 9)
         {
            _loc3_.writeInt(10000001 + _loc1_);
            _loc3_.writeInt(5);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit1() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeInt(0);
         _loc3_.writeShort(0);
         _loc1_ = 0;
         while(_loc1_ < 0)
         {
            TUtilityString.FlushUTF(_loc3_,"ServerName" + _loc1_);
            TUtilityString.FlushUTF(_loc3_,"UserName" + _loc1_);
            TUtilityString.FlushUTF(_loc3_,"Desc1" + _loc1_);
            _loc3_.writeUnsignedInt(1401571200);
            _loc3_.writeUnsignedInt(SLogicsCore.Character.MainHero.LargeID);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

