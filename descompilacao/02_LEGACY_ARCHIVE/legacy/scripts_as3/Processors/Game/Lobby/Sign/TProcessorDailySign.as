package Processors.Game.Lobby.Sign
{
   import Foundation.Common.TBounds;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Logics.DailySign.TDailySign;
   import Logics.DatebaseVO.TSignReward_Circle;
   import Logics.DatebaseVO.VO.TSignReward;
   import Logics.Inventories.TInventory;
   import Logics.Inventories.TInventorySample;
   import Logics.Streamization.Dailysign.TUnstreamizerDailySign;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_DAILYSIGN;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_DAILYSIGN;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorDailySign extends TProcessorLobbyWindows
   {
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var SIZE_Window_Width:uint = 918;
      
      protected var SIZE_Window_Height:uint = 554;
      
      protected var FProcessorWindowDailySign:TProcessorWindowDailySign;
      
      protected var FDailyBounds:TBounds;
      
      protected var FUnstreamizerDailySign:TUnstreamizerDailySign;
      
      protected var FDailySign:TDailySign;
      
      protected var FInventorySample:TInventorySample;
      
      protected var FOnEffectSign:Function;
      
      public function TProcessorDailySign(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowDailySign = new TProcessorWindowDailySign(this);
         this.FProcessorWindowDailySign.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowDailySign.HintOnMove = this.UIComponentsUpHintOnOver;
         this.FProcessorWindowDailySign.HintOnOut = this.UIComponentsUpHintOnOut;
         this.FProcessorWindowDailySign.OnCompensate = this.ProcessorOnCompensate;
         this.FProcessorWindowDailySign.DownHintOnOver = this.UIComponentsDownHintOnOver;
         this.FProcessorWindowDailySign.DownHintOnOut = this.UIComponentsDownHintOnOut;
         this.FProcessorWindowDailySign.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowDailySign.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowDailySign.OnExchange = this.ProcessorOnExchange;
         this.FProcessorWindowDailySign.OnGetReward = this.ProcessorOnGetReward;
         this.FProcessorWindowDailySign.BackFun = this.PacketPerform_CS_NewGet;
         this.FProcessorWindowDailySign.PlayEffectNewSign = this.PlayEffectNewSign;
         this.FDailyBounds = new TBounds();
         this.FDailyBounds.Width = this.SIZE_Window_Width;
         this.FDailyBounds.Height = this.SIZE_Window_Height;
         this.FDailyBounds.X = this.FProcessorWindowDailySign.X;
         this.FDailyBounds.Y = this.FProcessorWindowDailySign.Y;
         ComponentBoundsCenter(this.FProcessorWindowDailySign,this.FDailyBounds);
         this.FUnstreamizerDailySign = new TUnstreamizerDailySign();
         this.FDailySign = new TDailySign();
         this.FProcessorWindowDailySign.DailySign = this.FDailySign;
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.visible = false;
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_Sign);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_Sign);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_Sign);
         FOverlayerAppliance.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_Sign);
         FOverlayerAccessory.Visible = false;
         SetUIModuleID(CONST_MODULES.MODULE_Sign);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_DAILYSIGN.RESOURCESID_Swf_DailySign);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Sign_Load,this.PacketPerform_SC_SignLoad);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Sign_Commit,this.PacketPerform_SC_SignCommit);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Sign_Reward,this.PacketPerform_SC_SignReward);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Load_CircleRet,this.PacketPerform_SC_Load_CircleRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Reward_CircleRet,this.PacketPerform_SC_Reward_CircleRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Reward_NewInfo,this.PACKETID_SC_Reward_NewInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Reward_NewGet,this.PACKETID_SC_Reward_NewGet);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:Date = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(!Visible || !FIsResourcesLoadCompleted)
         {
            return;
         }
         _loc1_ = new Date(STimingCore.GetServerTime() * 1000);
         if(this.FDailySign.CurrentMonth != _loc1_.month)
         {
            _loc3_ = this.FDailySign.DayList.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               this.FDailySign.DayList.pop();
               _loc2_++;
            }
            this.FDailySign.DayList[0] = "0";
            this.FDailySign.CurrentMonth = _loc1_.month;
            this.FProcessorWindowDailySign.UpdateUI();
         }
         super.LogicsPerform();
      }
      
      protected function PacketPerform_SC_SignLoad(param1:TPacket) : void
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
         this.FUnstreamizerDailySign.Unstreamize(_loc2_,this.FDailySign,null);
         if(this.FDailySign.DayList[this.FDailySign.DayList.length - 1] == "0")
         {
            this.PlayEffectNewSign(true);
            this.FDailySign.TempValue = true;
         }
         this.PacketPerform_CS_Load_CircleReq();
      }
      
      protected function PacketPerform_SC_SignCommit(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         _loc4_ = param1.Data;
         _loc2_ = int(_loc4_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc3_ = int(_loc4_.readUnsignedInt());
         if(new Date(STimingCore.GetServerTime() * 1000).date == _loc3_)
         {
            this.PlayEffectNewSign(false);
            this.FDailySign.TempValue = false;
         }
         this.FDailySign.DayList[_loc3_ - 1] = "1";
         ++this.FDailySign.SignTotalDays;
         this.FProcessorWindowDailySign.UpdateUI();
         this.PacketPerform_CS_NewInfo();
      }
      
      protected function PacketPerform_SC_SignReward(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         var _loc5_:TSignReward = null;
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         _loc8_ = STRING_DAILYSIGN.STRING_Congratulation;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc4_ = int(_loc3_.readUnsignedInt());
         if(this.FDailySign.RewardID != 1)
         {
            _loc6_ = this.FDailySign.SignReward.Desc.split("\\n");
            _loc7_ = _loc6_.length;
            _loc9_ = 1;
            while(_loc9_ < _loc7_)
            {
               _loc8_ += _loc6_[_loc9_] + "\n";
               _loc9_++;
            }
         }
         else
         {
            _loc8_ += this.FDailySign.SignReward.Desc;
         }
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SignReward,_loc4_) as TSignReward;
         EffectGenerateText(_loc8_);
         this.FDailySign.RewardID = _loc4_;
         this.FDailySign.SignReward = _loc5_;
         if(_loc5_ != null)
         {
            this.FProcessorWindowDailySign.UpdateReward();
         }
         else
         {
            this.PacketPerform_CS_Load_CircleReq();
         }
      }
      
      protected function PacketPerform_SC_Load_CircleRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:TSignReward_Circle = null;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc4_ = _loc2_.readUnsignedInt();
         this.FDailySign.CircleRewardID = _loc4_;
         this.FDailySign.CircleSignTotalDays = _loc2_.readUnsignedInt();
         this.FDailySign.IsCanGetReward = _loc2_.readUnsignedInt();
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SignReward_Circle,_loc4_) as TSignReward_Circle;
         this.FDailySign.SignReward_Circle = _loc3_;
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowDailySign.UpdateReward();
         }
      }
      
      protected function PacketPerform_SC_Reward_CircleRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TSignReward_Circle = null;
         var _loc5_:uint = 0;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc5_ = _loc2_.readUnsignedInt();
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SignReward_Circle,_loc5_) as TSignReward_Circle;
         EffectGenerateText(STRING_DAILYSIGN.STRING_Receive);
         this.FDailySign.SignReward_Circle = _loc4_;
         this.FDailySign.CircleRewardID = _loc5_;
         this.FProcessorWindowDailySign.UpdateReward();
      }
      
      protected function PacketPerform_CS_Load_CircleReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Load_CircleReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_Exchange() : void
      {
         var _loc1_:ByteArray = null;
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Mall_Buy);
         _loc1_ = _loc2_.Data;
         _loc1_.writeUnsignedInt(this.FInventorySample.Indentifier);
         _loc1_.writeShort(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PlayEffectNewSign(param1:Boolean) : void
      {
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Sign,param1);
         }
      }
      
      protected function PacketPerform_CS_NewInfo() : void
      {
         var _loc1_:ByteArray = null;
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Reward_NewInfo);
         _loc1_ = _loc2_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PacketPerform_CS_NewGet(param1:int) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Reward_NewGet);
         _loc2_ = _loc3_.Data;
         _loc2_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function PACKETID_SC_Reward_NewInfo(param1:TPacket) : void
      {
         this.FProcessorWindowDailySign.PACKETID_SC_Reward_NewInfo(param1);
      }
      
      protected function PACKETID_SC_Reward_NewGet(param1:TPacket) : void
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
         EffectGenerateText(STRING_DAILYSIGN.STRING_Seccource);
         this.PacketPerform_CS_NewInfo();
      }
      
      protected function ProcessorOnGetReward(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         if(this.FDailySign.SignReward == null)
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Reward_CircleReq);
         }
         else
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Sign_Reward);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnCompensate(param1:Object, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc3_ = param2 as int;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Sign_Commit);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(_loc3_);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function ProcessorOnExchange(param1:Object, param2:TInventorySample) : void
      {
         this.FInventorySample = param2;
         this.PacketPerform_CS_Exchange();
      }
      
      protected function ProcessorOnClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      protected function UIComponentsUpHintOnOver(param1:Object, param2:THint) : void
      {
         FOverlayerHint.Context = param2;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.visible = true;
      }
      
      protected function UIComponentsUpHintOnOut(param1:Object) : void
      {
         FOverlayerHint.visible = false;
      }
      
      protected function UIComponentsDownHintOnOver(param1:Object, param2:TInventory) : void
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
      
      protected function UIComponentsDownHintOnOut(param1:Object, param2:TInventory) : void
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
      
      public function get ProcessorWindowDailySign() : TProcessorWindowDailySign
      {
         return this.FProcessorWindowDailySign;
      }
      
      public function get OnEffectSign() : Function
      {
         return this.FOnEffectSign;
      }
      
      public function set OnEffectSign(param1:Function) : void
      {
         this.FOnEffectSign = param1;
      }
      
      override public function set OnEffectText(param1:Function) : void
      {
         FOnEffectText = param1;
         if(this.FProcessorWindowDailySign != null)
         {
            this.FProcessorWindowDailySign.OnEffectText = param1;
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowDailySign.Load();
            return;
         }
         this.FProcessorWindowDailySign.Visible = true;
         this.FProcessorWindowDailySign.Init();
         this.FProcessorWindowDailySign.PlayEffect();
         this.PacketPerform_CS_NewInfo();
      }
      
      public function UpdateIntegralInfo() : void
      {
         this.FProcessorWindowDailySign.UpdateIntegralInfo();
      }
   }
}

