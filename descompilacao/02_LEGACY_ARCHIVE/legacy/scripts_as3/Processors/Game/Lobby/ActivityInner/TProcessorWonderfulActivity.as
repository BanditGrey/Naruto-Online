package Processors.Game.Lobby.ActivityInner
{
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.ActivityMode.TActivityAtom;
   import Logics.ActivityMode.TActivityAtoms;
   import Logics.SLogicsCore;
   import Logics.Signals.TSignal;
   import Processors.Game.Lobby.ActivityInner.Window.TProcessorWindowActivityInnerFightingPower;
   import Processors.Game.Lobby.ActivityInner.Window.TProcessorWindowActivityInnerPetRank;
   import Processors.Game.Lobby.Common.*;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.*;
   import Resources.Constants.*;
   import Utilities.UI.Overlayers.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.sampler.*;
   import flash.system.*;
   import flash.utils.*;
   
   public class TProcessorWonderfulActivity extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH_Activity:uint = 898;
      
      protected static const SIZE_HIGHT_Activity:uint = 556;
      
      protected static const Width_Offset:int = 193;
      
      protected static const Height_Offset:int = 48;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const SIGNALDESTINATION_ACTIVE_Inner_Ret:uint = CONST_SIGNAL.SIGNALDESTINATION_ACTIVE_Inner_Ret;
      
      protected static const TabNum:int = 10;
      
      protected var FMainScene:MovieClip;
      
      protected var FWindowMountPoint:MovieClip;
      
      protected var FActivities:Vector.<TProcessorWindowWonderfulActivity>;
      
      protected var FActivityAtoms:Vector.<TActivityAtoms>;
      
      protected var FActivityCanShowIndex:Vector.<int>;
      
      protected var FUITab:TUITab;
      
      protected var FArrowUp:SimpleButton;
      
      protected var FArrowDown:SimpleButton;
      
      protected var FcurrentShowStartIndex:int;
      
      protected var FCurrentSelectIndex:int;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Infor:SimpleButton;
      
      protected var FCurrentShowActivityWindowStore:TProcessorWindowWonderfulActivity;
      
      protected var FCurrentShowActivityWindow:TProcessorWindowWonderfulActivity;
      
      protected var FSwitchWindow:Function;
      
      protected var FNotifyShortcutEffect:Function;
      
      protected var FNotifyFNotifyPayRank:Function;
      
      public function TProcessorWonderfulActivity(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.ConstructWonderfulActivity();
         SetUIModuleID(CONST_MODULES.MODULE_ActivityInner);
      }
      
      protected function ConstructWonderfulActivity() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Class = null;
         var _loc3_:Vector.<Class> = null;
         _loc3_ = CONST_WONDERFULACTIVITY.WonderfulActivityReference;
         this.FActivities = new Vector.<TProcessorWindowWonderfulActivity>();
         _loc1_ = 0;
         while(_loc1_ < _loc3_.length)
         {
            _loc2_ = _loc3_[_loc1_];
            this.FActivities.push(new _loc2_(this));
            _loc1_++;
         }
         this.FActivityAtoms = new Vector.<TActivityAtoms>(this.FActivities.length);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         super.ResourcesPerform_UIRequest();
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_ACTIVITYINNER.RESOURCESID_Swf_ActivityInner);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TProcessorWindowWonderfulActivity = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:String = null;
         super.ResourcesPerform_UIDispatch();
         this.FMainScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_ACTIVITYINNER.RESOURCE_ClassName_MC_ActivityInner) as MovieClip;
         addChild(this.FMainScene);
         this.FMainScene.x = (CONST_COMMON.STAGE_Width - this.FMainScene.width) / 2;
         this.FMainScene.y = (CONST_COMMON.STAGE_Height - this.FMainScene.height) / 2;
         this.FArrowUp = this.FMainScene["Btn_Left"];
         this.FArrowDown = this.FMainScene["Btn_Right"];
         this.FBtn_Close = this.FMainScene["BTN_Close"];
         this.FBtn_Infor = this.FMainScene["BTN_Help"];
         this.FUITab = new TUITab(this);
         this.FUITab.FilterColor = 16776960;
         _loc1_ = 0;
         while(_loc1_ < TabNum)
         {
            this.FUITab.SetTabByIndex(this.FMainScene["MC_Tab_" + _loc1_],_loc1_);
            _loc1_++;
         }
         _loc5_ = this.FMainScene["MC_UIActivity"];
         this.FWindowMountPoint = _loc5_;
         _loc2_ = int(this.FActivities.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FActivities[_loc1_];
            _loc6_ = CONST_WONDERFULACTIVITY.RESOURCE_LINK_MC_Vector[_loc1_];
            _loc5_.gotoAndStop(_loc6_);
            _loc4_ = _loc5_[_loc6_];
            this.InitOneActivity(_loc4_,_loc3_);
            _loc1_++;
         }
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_ActivityInner);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_ActivityInner);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_ActivityInner);
         FOverlayerAppliance.Visible = false;
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_ActivityInner);
         FOverlayerAccessory.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         this.FActivityCanShowIndex = new Vector.<int>();
      }
      
      private function Btn_click(param1:MouseEvent) : void
      {
         this.FUITab.StopGlow();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FArrowUp.addEventListener(MouseEvent.CLICK,this.UpArrorOnMouseClick);
         this.FArrowDown.addEventListener(MouseEvent.CLICK,this.DownArrorOnMouseClick);
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.BtnCloseOnClick);
         this.FUITab.OnSwitch = this.OnTabSwitch;
         this.FUITab.Init();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FUITab != null)
         {
            this.FUITab.Update();
         }
         this.LogicsPerform_Signals();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Activity_PowerRankRet,this.PerformPacket_SC_PowerRankRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Activity_GlobelDataRet,this.PerformPacket_SC_GlobeDataRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Activity_ArenaRet,this.PerformPacket_SC_ArenaRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Activity_PowerRet,this.PerformPacket_SC_PowerRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Activity_RechageRankRet,this.PerformPacket_SC_NotifyPayRank);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FightingShow_SinglePetRankRet,this.PerformPacket_SC_SinglePetRankRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FightingShow_AllSinglePetRankRet,this.PerformPacket_SC_ALLPetRankRet);
      }
      
      protected function PerformPacket_SC_PowerRankRet(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TProcessorWindowWonderfulActivity = null;
         var _loc4_:int = 0;
         _loc4_ = param1.Data.readByte();
         switch(_loc4_)
         {
            case CONST_WONDERFULACTIVITY.RequestRankType_Power:
               _loc3_ = this.GetActivityByID(CONST_ACTIVITY_MODE.Activity_PowerRanking);
               break;
            case CONST_WONDERFULACTIVITY.RequestRankType_Level:
               _loc3_ = this.GetActivityByID(CONST_ACTIVITY_MODE.Activity_LevelRanking);
               break;
            case CONST_WONDERFULACTIVITY.RequestRankType_HFPower:
               _loc3_ = this.GetActivityByID(CONST_ACTIVITY_MODE.Activity_HFPowerRanking);
         }
         _loc3_.NotifyPacketArrive(param1);
      }
      
      protected function PerformPacket_SC_GlobeDataRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:ByteArray = null;
         var _loc6_:TActivityAtoms = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:TPacket = null;
         _loc5_ = param1.Data;
         _loc9_ = SNetworkCore.PacketAcquire(0);
         _loc2_ = _loc5_.readUnsignedInt();
         _loc3_ = _loc5_.readUnsignedInt();
         _loc8_ = _loc5_.readUnsignedInt();
         _loc4_ = _loc5_.readUnsignedInt();
         _loc7_ = 0;
         while(_loc7_ < this.FActivityAtoms.length)
         {
            _loc6_ = this.FActivityAtoms[_loc7_];
            if(_loc6_ != null && _loc6_.GetActivityAtomByIndex(0).Identifier == _loc3_)
            {
               _loc9_.Data.writeUnsignedInt(_loc2_);
               _loc9_.Data.writeUnsignedInt(_loc3_);
               _loc9_.Data.writeUnsignedInt(_loc8_);
               _loc9_.Data.writeUnsignedInt(_loc4_);
               _loc9_.Data.position = 0;
               this.FActivities[_loc7_].NotifyPacketArrive(_loc9_);
            }
            _loc7_++;
         }
      }
      
      protected function PerformPacket_SC_ArenaRet(param1:TPacket) : void
      {
         var _loc2_:TProcessorWindowWonderfulActivity = null;
         _loc2_ = this.GetActivityByID(CONST_ACTIVITY_MODE.Activity_AreanRanking);
         _loc2_.NotifyPacketArrive(param1);
      }
      
      protected function PerformPacket_SC_PowerRet(param1:TPacket) : void
      {
         var _loc2_:TProcessorWindowActivityInnerFightingPower = null;
         _loc2_ = this.GetActivityByID(CONST_ACTIVITY_MODE.Activity_PowerRanking) as TProcessorWindowActivityInnerFightingPower;
         if(!_loc2_.IsInit())
         {
            _loc2_ = this.GetActivityByID(CONST_ACTIVITY_MODE.Activity_HFPowerRanking) as TProcessorWindowActivityInnerFightingPower;
         }
         _loc2_.SendPower(param1);
      }
      
      protected function PerformPacket_SC_SinglePetRankRet(param1:TPacket) : void
      {
         var _loc2_:TProcessorWindowActivityInnerPetRank = null;
         _loc2_ = this.GetActivityByID(CONST_ACTIVITY_MODE.Activity_PetRankHF) as TProcessorWindowActivityInnerPetRank;
         _loc2_.SetSingleRank(param1);
      }
      
      protected function PerformPacket_SC_ALLPetRankRet(param1:TPacket) : void
      {
         var _loc2_:TProcessorWindowActivityInnerPetRank = null;
         _loc2_ = this.GetActivityByID(CONST_ACTIVITY_MODE.Activity_PetRankHF) as TProcessorWindowActivityInnerPetRank;
         _loc2_.SetAllRank(param1);
      }
      
      protected function PerformPacket_CS_ReceiveAwards(param1:Object, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Activity_ReceiveAwardsReq);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function PerformPacket_SC_NotifyPayRank(param1:TPacket) : void
      {
         if(this.FNotifyFNotifyPayRank != null)
         {
            this.FNotifyFNotifyPayRank(this,param1);
         }
      }
      
      protected function GetActivityByID(param1:uint) : TProcessorWindowWonderfulActivity
      {
         var _loc2_:Vector.<uint> = null;
         var _loc3_:int = 0;
         _loc2_ = CONST_WONDERFULACTIVITY.KEY_Activity_Vector;
         _loc3_ = _loc2_.indexOf(param1);
         return this.FActivities[_loc3_];
      }
      
      protected function LogicsPerform_Signals() : void
      {
         var _loc1_:TSignal = null;
         var _loc2_:int = 0;
         var _loc3_:Vector.<uint> = null;
         var _loc4_:TActivityAtoms = null;
         _loc1_ = SLogicsCore.SignalRetrieve(SIGNALDESTINATION_ACTIVE_Inner_Ret);
         if(_loc1_ == null)
         {
            return;
         }
         _loc3_ = CONST_WONDERFULACTIVITY.KEY_Activity_Vector;
         _loc2_ = _loc3_.indexOf(_loc1_.Identifier);
         if(_loc2_ >= 0)
         {
            _loc4_ = _loc1_.UserData as TActivityAtoms;
            this.FActivityAtoms[_loc2_] = _loc4_;
            this.CheckIfCanShowEffect();
            this.CheckTabShowGlow();
            if(FIsResourcesLoadCompleted)
            {
               this.FActivities[_loc2_].NotifyActivityAtoms(_loc4_);
            }
         }
      }
      
      protected function CheckIfCanShowEffect() : void
      {
         var _loc1_:TActivityAtoms = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < this.FActivityAtoms.length)
         {
            _loc1_ = this.FActivityAtoms[_loc2_];
            if(_loc1_ != null)
            {
               _loc4_ = this.CheckIfCanShowEffectSingle(_loc1_);
               if(_loc4_)
               {
                  if(this.FNotifyShortcutEffect != null)
                  {
                     this.FNotifyShortcutEffect(CONST_SHORTCUTS.POSITION_ActiveList,CONST_SHORTCUTS.TYPE_ActiveList_Wonderful,true);
                  }
                  return;
               }
            }
            _loc2_++;
         }
         if(this.FNotifyShortcutEffect != null)
         {
            this.FNotifyShortcutEffect(CONST_SHORTCUTS.POSITION_ActiveList,CONST_SHORTCUTS.TYPE_ActiveList_Wonderful,false);
         }
      }
      
      protected function CheckIfCanShowEffectSingle(param1:TActivityAtoms) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TActivityAtom = null;
         _loc2_ = 0;
         while(_loc2_ < param1.Count)
         {
            _loc4_ = param1.GetActivityAtomByIndex(_loc2_);
            if(_loc4_.ActiveStatus > 0)
            {
               if(this.FNotifyShortcutEffect != null)
               {
                  return true;
               }
               break;
            }
            _loc2_++;
         }
         return false;
      }
      
      protected function SendAtoms() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TActivityAtoms = null;
         _loc2_ = int(this.FActivityAtoms.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FActivityAtoms[_loc1_];
            if(_loc3_ != null)
            {
            }
            _loc1_++;
         }
      }
      
      protected function CheckTabShowGlow() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TActivityAtoms = null;
         var _loc4_:Boolean = false;
         if(this.FUITab == null)
         {
            return;
         }
         _loc2_ = this.FUITab.Count;
         _loc1_ = _loc1_;
         while(_loc1_ < _loc2_)
         {
            if(_loc1_ + this.FcurrentShowStartIndex >= this.FActivityCanShowIndex.length)
            {
               break;
            }
            _loc3_ = this.FActivityAtoms[this.FActivityCanShowIndex[_loc1_]];
            if(_loc3_ != null)
            {
               _loc4_ = this.CheckIfCanShowEffectSingle(_loc3_);
               if(_loc4_)
               {
                  this.FUITab.StartTabShowGlowByIndex(_loc1_);
               }
               else
               {
                  this.FUITab.StopTabShowGlowByIndex(_loc1_);
               }
            }
            _loc1_++;
         }
      }
      
      protected function InitOneActivity(param1:MovieClip, param2:TProcessorWindowWonderfulActivity) : void
      {
         this.FWindowMountPoint.addChild(param2);
         param2.x = param1.x;
         param2.y = param1.y;
         param2.OnOver = UIComponentsHintOnOver;
         param2.OnOut = UIComponentsHintOnOut;
         param2.OnHitOver = this.UIComponentsOnOver;
         param2.OnHitOut = this.UIComponentsOnOut;
         param2.OnEffectText = EffectGenerateText;
         param2.EffectGenerateTextByErrorCodeFunction = EffectGenerateTextByErrorCode;
         param2.OnReceiveAwards = this.PerformPacket_CS_ReceiveAwards;
         param2.OnOpenWindow = this.JmpToWindow;
         param2.UIDispatch(param1);
         param2.UILocation();
      }
      
      protected function SelectCurrentActivityCanShow() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TActivityAtoms = null;
         this.FActivityCanShowIndex.length = 0;
         _loc2_ = int(this.FActivityAtoms.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FActivityAtoms[_loc1_];
            if(_loc3_ != null)
            {
               if(_loc3_.IsOn)
               {
                  this.FActivityCanShowIndex.push(_loc1_);
               }
            }
            _loc1_++;
         }
      }
      
      protected function RefreshTabs() : void
      {
         var _loc1_:TActivityAtoms = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         _loc3_ = this.FUITab.Count;
         _loc5_ = int(this.FActivityCanShowIndex.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc2_ + this.FcurrentShowStartIndex;
            if(_loc4_ < _loc5_)
            {
               _loc4_ = this.FActivityCanShowIndex[_loc4_];
               this.FUITab.SetTabCaptionByIndex(this.FActivityAtoms[_loc4_].LeftCaption,_loc2_);
               this.FUITab.SetTabShowByIndex(_loc2_);
               if(this.FCurrentSelectIndex == _loc4_)
               {
                  this.FUITab.SwithTagManual(_loc2_);
                  _loc6_ = true;
               }
            }
            else
            {
               this.FUITab.SetTabHideByIndex(_loc2_);
            }
            _loc2_++;
         }
         if(!_loc6_ && _loc5_ != 0)
         {
            if(_loc5_ > 2)
            {
               this.FUITab.SwithTagManual(1);
            }
            this.FUITab.SwithTagManual(0);
            this.FCurrentSelectIndex = this.FcurrentShowStartIndex;
         }
      }
      
      protected function UpdateMilitaryArrorState() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = 0;
         if(this.FcurrentShowStartIndex <= _loc2_)
         {
            this.FArrowUp.visible = false;
         }
         else
         {
            this.FArrowUp.visible = true;
         }
         _loc1_ = this.FActivityCanShowIndex.length - this.FUITab.Count;
         if(this.FcurrentShowStartIndex >= _loc1_)
         {
            this.FArrowDown.visible = false;
         }
         else
         {
            this.FArrowDown.visible = true;
         }
      }
      
      protected function JmpToWindow(param1:TProcessorWindowWonderfulActivity, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc3_ = this.FActivities.indexOf(param1);
         _loc4_ = CONST_WONDERFULACTIVITY.JmpWindowPositionAndLocation[_loc3_ << 1];
         _loc5_ = CONST_WONDERFULACTIVITY.JmpWindowPositionAndLocation[(_loc3_ << 1) + 1];
         if(this.FSwitchWindow != null)
         {
            this.FSwitchWindow(this,_loc4_,_loc5_,param2);
         }
      }
      
      protected function UIComponentsOnOver(param1:Object, param2:THint) : void
      {
         FOverlayerHint.Context = param2;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.Show();
      }
      
      protected function UIComponentsOnOut(param1:Object) : void
      {
         FOverlayerHint.Hide();
      }
      
      protected function UpArrorOnMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         if(this.FcurrentShowStartIndex > _loc2_)
         {
            this.FcurrentShowStartIndex -= this.FUITab.Count;
            this.FcurrentShowStartIndex = this.FcurrentShowStartIndex < _loc2_ ? _loc2_ : this.FcurrentShowStartIndex;
            this.RefreshTabs();
         }
         this.UpdateMilitaryArrorState();
         this.CheckTabShowGlow();
      }
      
      protected function DownArrorOnMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FActivityCanShowIndex.length - 1;
         if(this.FcurrentShowStartIndex < _loc2_)
         {
            this.FcurrentShowStartIndex += this.FUITab.Count;
            this.FcurrentShowStartIndex = this.FcurrentShowStartIndex > _loc2_ ? _loc2_ : this.FcurrentShowStartIndex;
            this.RefreshTabs();
         }
         this.UpdateMilitaryArrorState();
         this.CheckTabShowGlow();
      }
      
      protected function OnTabSwitch(param1:int) : void
      {
         if(this.FCurrentShowActivityWindowStore != null)
         {
            this.FCurrentShowActivityWindowStore.Hide();
         }
         param1 = this.FActivityCanShowIndex[this.FcurrentShowStartIndex + param1];
         this.FCurrentShowActivityWindow = this.FActivities[param1];
         this.FCurrentShowActivityWindow.NotifyActivityAtoms(this.FActivityAtoms[param1]);
         this.FCurrentShowActivityWindow.Show();
         this.FCurrentShowActivityWindowStore = this.FCurrentShowActivityWindow;
         this.FCurrentSelectIndex = param1;
      }
      
      protected function BtnCloseOnClick(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      override public function set OnClose(param1:Function) : void
      {
         super.OnClose = param1;
      }
      
      public function set SwitchWindow(param1:Function) : void
      {
         this.FSwitchWindow = param1;
      }
      
      public function set NotifyShortcutEffect(param1:Function) : void
      {
         this.FNotifyShortcutEffect = param1;
      }
      
      public function set NotifyFNotifyPayRank(param1:Function) : void
      {
         this.FNotifyFNotifyPayRank = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.SendAtoms();
         this.SelectCurrentActivityCanShow();
         this.CheckTabShowGlow();
         this.FCurrentSelectIndex = 0;
         this.FcurrentShowStartIndex = 0;
         this.RefreshTabs();
         this.UpdateMilitaryArrorState();
         if(this.FActivityCanShowIndex.length > 0)
         {
            this.OnTabSwitch(0);
         }
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         if(this.FCurrentShowActivityWindow != null)
         {
            this.FCurrentShowActivityWindow.Hide();
            this.FCurrentShowActivityWindowStore = null;
            this.FCurrentShowActivityWindow = null;
         }
         this.FUITab.StopGlow();
         this.CheckIfCanShowEffect();
      }
   }
}

